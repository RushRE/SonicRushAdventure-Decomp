#include <game/network/wfs.h>
#include <nitro/wbt.h>

// --------------------
// CONSTANTS
// --------------------

#define WFS_MSG_OPENFILE_REQ  0
#define WFS_MSG_OPENFILE_ACK  1
#define WFS_MSG_CLOSEFILE_REQ 2
#define WFS_MSG_CLOSEFILE_ACK 3

#define WFS_FILE_INDEX_OFFSET 0x10000
#define WFS_FILE_TO_BLOCK(id) ((id) + WFS_FILE_INDEX_OFFSET)
#define WFS_FILE_TABLEINFO    0x10000

// --------------------
// ENUMS
// --------------------

enum WFSi_FSRegion
{
    WFSi_FSREGION_FAT,
    WFSi_FSREGION_FNT,
    WFSi_FSREGION_OVT9,
    WFSi_FSREGION_OVT7,

    WFSi_FSREGION_COUNT
};

// --------------------
// VARIABLES
// --------------------

WFSWork *gWFSWorker;
static BOOL sDebugEnabled;
static BOOL sInitialized;

static const u8 sWBTBlockUserData[WBT_USER_ID_LEN] = { 0 };

// --------------------
// FUNCTION DECLS
// --------------------

static FSResult WFSi_ReadRomCallback(FSArchive *arc, void *dst, u32 src, u32 len);
static FSResult WFSi_WriteRomCallback(FSArchive *arc, const void *src, u32 dst, u32 len);
static FSResult WFSi_RomArchiveProc(FSFile *file, FSCommandType cmd);
static void WFSi_LoadTables(FSFile *rom, BOOL useParentFS);
static u32 WFSi_ReplaceRomArchive(void *table);

static void WFSi_OnSendMessageDone(void *arg);
static BOOL WFSi_SendMessage(u8 type, u16 bitmap, u32 id, u32 flag);
static void WFSi_SendAck(void);
void WFSi_SendOpenAck(WFSParentContext *parentContext, WFSiFileList *target, BOOL unknown);
static WFSiFileList *WFSi_FindAlive(WFSParentContext *parentContext, u32 top, u32 len);
static WFSiFileList *WFSi_FindBusy(WFSParentContext *parent, u32 src, u32 len);
static WFSiFileList *WFSi_FindAliveForID(WFSParentContext *parent, u32 id);
static void WFSi_MoveList(WFSiFileList **src, WFSiFileList **dst, WFSiFileList *target);
static WFSiFileList *WFSi_FromFreeToBusy(WFSParentContext *parent);
static void WFSi_FromBusyToAlive(WFSParentContext *parentContext, WFSiFileList *target);
static void WFSi_FromAliveToBusy(WFSParentContext *parentContext, WFSiFileList *target);
void WFSi_FromBusyToFree(WFSParentContext *parentContext, WFSiFileList *target);
static void WFSi_ReadRequest(FSFile *file);
static void WFSi_SetMPData(void);
static void WFSi_OnSetMPDataDone(void *arg);
static void WFSi_PortCallback(void *arg);
static void WFSi_OnParentSystemCallback(void *arg);
static void WFSi_ReallocBitmap(WFSChildContext *child, int size);
static void WFSi_OnChildSystemCallback(void *arg);
static void WFSi_InitCommon(int port, WFSStateCallback callback, WFSAllocator allocator, void *allocatorArg);

extern void WFSi_NotifyBusy(void);
extern void WFSi_TaskThread(void *arg);
extern void WFSi_CreateTaskThread(void);
extern void WFSi_EndTaskThread(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void *WFSi_Alloc(size_t size)
{
    void *ret;
    OSIntrMode bak_cpsr = OS_DisableInterrupts();
    ret                 = gWFSWorker->alloc_func(gWFSWorker->alloc_arg, size, NULL);
    OS_RestoreInterrupts(bak_cpsr);

    return ret;
}

RUSH_INLINE void WFSi_Free(void *ptr)
{
    if (ptr)
    {
        OSIntrMode bak_cpsr = OS_DisableInterrupts();
        gWFSWorker->alloc_func(gWFSWorker->alloc_arg, 0, ptr);
        OS_RestoreInterrupts(bak_cpsr);
    }
}

// --------------------
// FUNCTIONS
// --------------------

FSResult WFSi_ReadRomCallback(FSArchive *arc, void *dst, size_t src, size_t len)
{
    MI_CpuCopy8((const void *)src, dst, len);
    return FS_RESULT_SUCCESS;
}

FSResult WFSi_WriteRomCallback(FSArchive *arc, const void *src, size_t dst, size_t len)
{
    return FS_RESULT_FAILURE;
}

FSResult WFSi_RomArchiveProc(FSFile *file, FSCommandType cmd)
{
    switch (cmd)
    {
        case FS_COMMAND_READFILE:
            if (gWFSWorker == NULL || (gWFSWorker->state != WFS_STATE_READY))
                return FS_RESULT_ERROR;

            if (file->arg.readfile.len == 0)
                return FS_RESULT_SUCCESS;

            WFSi_ReadRequest(file);
            return FS_RESULT_PROC_ASYNC;

        case FS_COMMAND_WRITEFILE:
            return FS_RESULT_UNSUPPORTED;

        default:
            return FS_RESULT_PROC_UNKNOWN;
    }
}

void WFSi_LoadTables(FSFile *rom, BOOL useParentFS)
{
    typedef struct
    {
        u32 len;
        u32 data[1];
    } TableInfo;

    int i;

    u8 *mem  = NULL;
    u32 size = 0;

    const BOOL hasROM     = (rom == NULL);
    const BOOL isMixedFAT = (!hasROM && useParentFS);

    u32 childBaseOffset;
    u32 romBaseOffset;
    const u8 *romHeader;
    u8 romBuffer[0x60];

    CARDRomRegion region[WFSi_FSREGION_COUNT];
    u32 alignedLength[WFSi_FSREGION_COUNT];
    TableInfo *tableInfo[WFSi_FSREGION_COUNT];

    FSFile romFile[1];

    FS_InitFile(romFile);
    FS_CreateFileFromRom(romFile, 0, 0x7FFFFFFF);

    if (hasROM)
    {
        romBaseOffset   = 0;
        childBaseOffset = 0;
        romHeader       = (const u8 *)CARD_GetRomHeader();
    }
    else
    {
        const u32 romFilePos = FS_GetPosition(rom);
        romBaseOffset        = romFilePos + FS_GetFileImageTop(rom);
        childBaseOffset      = romBaseOffset;
        romHeader            = romBuffer;
        FS_ReadFile(rom, romBuffer, sizeof(romBuffer));
        FS_SeekFile(rom, romFilePos, FS_SEEK_SET);
    }

    if (!isMixedFAT)
    {
        region[WFSi_FSREGION_FAT]  = *(const CARDRomRegion *)(romHeader + 0x48);
        region[WFSi_FSREGION_FNT]  = *(const CARDRomRegion *)(romHeader + 0x40);
        region[WFSi_FSREGION_OVT9] = *(const CARDRomRegion *)(romHeader + 0x50);
        region[WFSi_FSREGION_OVT7] = *(const CARDRomRegion *)(romHeader + 0x58);
    }
    else
    {
        region[WFSi_FSREGION_FAT]         = *(const CARDRomRegion *)(CARD_GetRomHeader() + 0x48);
        region[WFSi_FSREGION_FNT]         = *(const CARDRomRegion *)(CARD_GetRomHeader() + 0x40);
        region[WFSi_FSREGION_OVT9].offset = (u32)(*(const u32 *)(romHeader + 0x50) + romBaseOffset);
        region[WFSi_FSREGION_OVT9].length = (u32)(*(const u32 *)(romHeader + 0x54));
        region[WFSi_FSREGION_OVT7].offset = (u32)(*(const u32 *)(romHeader + 0x58) + romBaseOffset);
        region[WFSi_FSREGION_OVT7].length = (u32)(*(const u32 *)(romHeader + 0x5C));

        childBaseOffset = 0;
    }

    size += sizeof(u32);
    for (i = 0; i < WFSi_FSREGION_COUNT; i++)
    {
        u32 r_len = region[i].length;
        if ((i == WFSi_FSREGION_FAT) && isMixedFAT)
        {
            int j;
            for (j = WFSi_FSREGION_OVT9; j < WFSi_FSREGION_COUNT; j++)
            {
                r_len += ((region[j].length / sizeof(FSOverlayInfoHeader)) * sizeof(CARDRomRegion));
            }
        }
        alignedLength[i] = ((r_len + 31) & ~31);
        size += (sizeof(u32) + alignedLength[i]);
    }
    mem         = (u8 *)WFSi_Alloc(size);
    *(u32 *)mem = childBaseOffset;

    u8 *dst = mem + sizeof(u32);
    for (i = 0; i < WFSi_FSREGION_COUNT; i++)
    {
        tableInfo[i]      = (TableInfo *)dst;
        tableInfo[i]->len = region[i].length;
        FS_SeekFile(romFile, (childBaseOffset + region[i].offset), FS_SEEK_SET);
        FS_ReadFile(romFile, tableInfo[i]->data, tableInfo[i]->len);
        dst += sizeof(u32) + alignedLength[i];
    }

    if (isMixedFAT)
    {
        typedef struct
        {
            u32 top, bottom;
        } FatInfo;

        FatInfo *const fat = (FatInfo *)tableInfo[WFSi_FSREGION_FAT]->data;
        int fatCount       = (tableInfo[WFSi_FSREGION_FAT]->len / sizeof(FatInfo));

        const u32 childFATBase = (u32)(romBaseOffset + ((const CARDRomRegion *)(romHeader + 0x48))->offset);

        for (i = WFSi_FSREGION_OVT9; i < WFSi_FSREGION_COUNT; i++)
        {
            FSOverlayInfoHeader *const overlayTable = (FSOverlayInfoHeader *)tableInfo[i]->data;
            const int overlayTableCount             = (tableInfo[i]->len / sizeof(FSOverlayInfoHeader));
            int j;
            for (j = 0; j < overlayTableCount; j++)
            {
                FS_SeekFile(romFile, (childFATBase + overlayTable[j].file_id * sizeof(FatInfo)), FS_SEEK_SET);
                FS_ReadFile(romFile, &fat[fatCount], sizeof(FatInfo));

                fat[fatCount].top += romBaseOffset;
                fat[fatCount].bottom += romBaseOffset;

                overlayTable[j].file_id = fatCount;
                fatCount++;
            }
        }

        tableInfo[WFSi_FSREGION_FAT]->len = (fatCount * sizeof(FatInfo));
    }

    DC_FlushRange(mem, size);
    DC_WaitWriteBufferEmpty();
    FS_CloseFile(romFile);

    gWFSWorker->table      = mem;
    gWFSWorker->table_size = size;
}

u32 WFSi_ReplaceRomArchive(void *table)
{
    u32 result;
    CARDRomRegion region[WFSi_FSREGION_COUNT];

    FSArchive *const rom = FS_FindArchive("rom", sizeof("rom") - 1);

    int i;

    FS_UnloadArchive(rom);

    FS_SetArchiveProc(rom, WFSi_RomArchiveProc, FS_ARCHIVE_PROC_ALL);

    result = *(u32 *)table;
    table  = ((u8 *)table) + sizeof(u32);

    for (i = 0; i < WFSi_FSREGION_COUNT; i++)
    {
        region[i].offset = ((u32)table + sizeof(u32));
        region[i].length = *(u32 *)table;
        table            = (void *)(region[i].offset + ((region[i].length + 0x1F) & ~0x1F));
    }

    FS_LoadArchive(rom, 0, region[WFSi_FSREGION_FAT].offset, region[WFSi_FSREGION_FAT].length, region[WFSi_FSREGION_FNT].offset, region[WFSi_FSREGION_FNT].length,
                   WFSi_ReadRomCallback, WFSi_WriteRomCallback);

    return result;
}

void WFSi_OnSendMessageDone(void *arg)
{
    WFSWork *const work = gWFSWorker;

    if (work && work->state != WFS_STATE_STOP)
    {
        if (work->is_parent)
        {
            WBTCommand *callback = (WBTCommand *)arg;

            if (callback->target_bmp == 0x00)
            {
                work->context.parent->msg_busy = FALSE;
                WFSi_SendAck();
            }
        }
    }
}

BOOL WFSi_SendMessage(u8 type, u16 bitmap, u32 id, u32 flag)
{
    WFSiMessage packet;

    packet.type  = type;
    packet.flag  = flag;
    packet.arg   = id;
    packet.pck_h = (u8)(gWFSWorker->parent_packet_size >> 8);
    packet.pck_l = (u8)(gWFSWorker->parent_packet_size >> 0);

    return WBT_PutUserData(bitmap, &packet, WBT_SIZE_USER_DATA, WFSi_OnSendMessageDone);
}

void WFSi_SendAck(void)
{
    WFSWork *const work            = gWFSWorker;
    WFSParentContext *const parent = work->context.parent;

    if (work != NULL && work->is_parent)
    {
        if (!parent->msg_busy)
        {
            parent->ack_bitmap &= parent->all_bitmap;
            parent->sync_bitmap &= parent->all_bitmap;
            parent->busy_bitmap &= parent->all_bitmap;
            parent->deny_bitmap &= parent->all_bitmap;

            if (parent->is_changing && !parent->busy_count)
            {
                const int size_p         = parent->new_packet_size;
                const int size_c         = work->child_packet_size;
                parent->is_changing      = FALSE;
                work->parent_packet_size = size_p;
                WBT_SetPacketSize(size_p, size_c);

                if (parent->deny_bitmap)
                {
                    if (WFSi_SendMessage(WFS_MSG_OPENFILE_ACK, parent->deny_bitmap, 0, FALSE))
                    {
                        parent->msg_busy    = TRUE;
                        parent->deny_bitmap = 0;
                    }
                }
            }
            else
            {
                int bitmap = parent->ack_bitmap;

                if (bitmap)
                {

                    WFSiMessage *msg = NULL;
                    int i;
                    const int sync     = parent->sync_bitmap;
                    const BOOL is_sync = (sync && ((bitmap & sync) == sync));

                    if (is_sync)
                        bitmap = sync;
                    else
                        bitmap &= ~sync;

                    for (i = 0;; i++)
                    {
                        const int bit = (1 << i);
                        if (bit > bitmap)
                            break;

                        if ((bit & bitmap) != 0)
                        {
                            if (!msg)
                            {
                                msg = &parent->recv_msg[i];
                            }
                            else if ((msg->type == parent->recv_msg[i].type) && (msg->arg == parent->recv_msg[i].arg))
                            {
                            }
                            else
                            {
                                bitmap &= ~bit;
                            }
                        }
                    }

                    if (is_sync && bitmap != sync)
                    {
                        parent->sync_bitmap = 0;
                    }

                    if (msg)
                    {
                        switch (msg->type)
                        {
                            case WFS_MSG_OPENFILE_REQ:
                                msg->type = WFS_MSG_OPENFILE_ACK;
                                break;

                            case WFS_MSG_CLOSEFILE_REQ:
                                msg->type = WFS_MSG_CLOSEFILE_ACK;
                                parent->busy_bitmap &= ~bitmap;

                                for (u16 i = 1; i < 16; i++)
                                {
                                    if ((bitmap & (1 << i)) == 0x00)
                                        continue;

                                    parent->sentFileCount[i]++;
                                }
                                break;
                        }

                        if (WFSi_SendMessage(msg->type, bitmap, msg->arg, TRUE))
                        {
                            parent->msg_busy = TRUE;
                            parent->ack_bitmap &= ~bitmap;
                        }
                    }
                }
            }
        }
    }
}

void WFSi_SendOpenAck(WFSParentContext *parentContext, WFSiFileList *target, BOOL unknown)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();

    if (gWFSWorker != NULL && gWFSWorker->state != WFS_STATE_STOP)
    {
        int bitmap         = target->req_bitmap;
        target->req_bitmap = 0;
        parentContext->ack_bitmap |= bitmap;

        if (target->ref <= 0)
        {
            const u32 id    = target->own_id;
            const u32 size  = FS_GetLength(&target->file);
            const void *src = (size <= WFS_FILE_CACHE_SIZE) ? target->cache : NULL;
            WBT_RegisterBlock(&target->info, id, sWBTBlockUserData, src, size, 0);
            WFSi_FromBusyToAlive(parentContext, target);
        }

        int i;
        for (i = 0;; i++)
        {
            const int bit = (1 << i);
            if (bit > bitmap)
                break;

            if ((bit & bitmap) != 0)
            {
                target->ref++;
                parentContext->recv_msg[i].arg = target->own_id;
            }
        }
    }

    OS_RestoreInterrupts(bak_cpsr);
}

WFSiFileList *WFSi_FindAlive(WFSParentContext *parentContext, u32 top, u32 len)
{
    WFSiFileList *fileList = parentContext->alive_list;

    while (fileList)
    {
        if (fileList->stat == WFS_FILE_STAT_ALIVE && FS_GetFileImageTop(&fileList->file) == top && FS_GetLength(&fileList->file) == len)
            break;

        fileList = fileList->next;
    }

    return fileList;
}

WFSiFileList *WFSi_FindBusy(WFSParentContext *parent, u32 src, u32 len)
{
    WFSiFileList *target;

    for (target = parent->busy_list; target; target = target->next)
    {
        if (target->stat == WFS_FILE_STAT_OPENING && target->rom_src == src && target->rom_len == len)
            break;
    }

    if (target == NULL)
    {
        target          = WFSi_FromFreeToBusy(parent);
        target->ref     = 0;
        target->rom_src = src;
        target->rom_len = len;
        WFSi_NotifyBusy();
    }

    return target;
}

WFSiFileList *WFSi_FindAliveForID(WFSParentContext *parent, u32 id)
{
    WFSiFileList *target;

    for (target = parent->alive_list; target; target = target->next)
    {
        if (target->stat == WFS_FILE_STAT_ALIVE && target->info.data_info.id == id)
            break;
    }

    return target;
}

void WFSi_MoveList(WFSiFileList **src, WFSiFileList **dst, WFSiFileList *target)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();

    WFSiFileList **fileListPtr = src;
    while (*fileListPtr != NULL)
    {
        if (*fileListPtr == target)
        {
            (*fileListPtr) = target->next;
            while (*dst != NULL)
            {
                dst = &(*dst)->next;
            }
            *dst         = target;
            target->next = NULL;
            break;
        }

        fileListPtr = &(*fileListPtr)->next;
    }

    OS_RestoreInterrupts(bak_cpsr);
}

WFSiFileList *WFSi_FromFreeToBusy(WFSParentContext *parent)
{
    WFSiFileList *const target = parent->free_list;

    WFSi_MoveList(&parent->free_list, &parent->busy_list, target);
    target->stat = WFS_FILE_STAT_OPENING;
    parent->busy_count++;

    return target;
}

void WFSi_FromBusyToAlive(WFSParentContext *parentContext, WFSiFileList *target)
{
    WFSi_MoveList(&parentContext->busy_list, &parentContext->alive_list, target);
    target->stat = WFS_FILE_STAT_ALIVE;
}

void WFSi_FromAliveToBusy(WFSParentContext *parentContext, WFSiFileList *target)
{
    WFSi_MoveList(&parentContext->alive_list, &parentContext->busy_list, target);
    target->stat = WFS_FILE_STAT_CLOSING;
}

void WFSi_FromBusyToFree(WFSParentContext *parentContext, WFSiFileList *target)
{
    WFSi_MoveList(&parentContext->busy_list, &parentContext->free_list, target);
    target->stat = WFS_FILE_STAT_FREE;
    parentContext->busy_count--;
}

void WFSi_ReadRequest(FSFile *file)
{
    WFSChildContext *const child = gWFSWorker->context.child;

    WFSi_ReallocBitmap(child, file->arg.readfile.len);
    gWFSWorker->target_file = file;

    if (!WFSi_SendMessage(WFS_MSG_OPENFILE_REQ, WFS_BITMAP_TO_PARENT, child->base_offset + file->prop.file.pos, file->arg.readfile.len))
    {
        OS_Terminate();
    }
}

void WFSi_SetMPData(void)
{
    WFSWork *const work = gWFSWorker;

    u16 sendSize;
    if (work->is_parent)
        sendSize = work->parent_packet_size;
    else
        sendSize = work->child_packet_size;

    if (work->send_idle)
    {
        void *sendBuffer = work->send_buf;
        if (work->is_parent)
            sendSize = WBT_MpParentSendHook(sendBuffer, sendSize);
        else
            sendSize = WBT_MpChildSendHook(sendBuffer, sendSize);

        work->is_running = WM_SetMPDataToPort(WFSi_OnSetMPDataDone, sendBuffer, sendSize, 0xFFFF, work->port, WM_PRIORITY_LOW) == WM_ERRCODE_OPERATING;
        work->send_idle  = !gWFSWorker->is_running;
    }
}

void WFSi_OnSetMPDataDone(void *arg)
{
    WFSWork *const work = gWFSWorker;

    if (work != NULL && work->state != WFS_STATE_STOP)
    {
        work->send_idle = TRUE;
        WFSi_SendAck();
        WFSi_SetMPData();
    }
}

void WFSi_PortCallback(void *arg)
{
    WFSWork *const work            = gWFSWorker;
    WFSParentContext *const parent = work->context.parent;

    if (work && work->state != WFS_STATE_STOP)
    {
        const WMPortRecvCallback *const recv = (const WMPortRecvCallback *)arg;

        switch (recv->state)
        {
            case WM_STATECODE_CONNECTED:
                if (work->is_parent && (work->state == WFS_STATE_READY))
                {
                    if (!work->is_running)
                        WFSi_SetMPData();
                }
                break;

            case WM_STATECODE_DISCONNECTED:
                if (work->is_parent && (work->state == WFS_STATE_READY))
                {
                    const int aid = recv->aid;
                    parent->all_bitmap &= ~(1 << aid);

                    WBT_CancelCurrentCommand((1 << aid));
                }
                break;

            case WM_STATECODE_PORT_RECV: {
                const void *src = recv->data;
                const int len   = recv->length;
                if (work->is_parent && (work->state == WFS_STATE_READY))
                {
                    const int aid = recv->aid;
                    parent->all_bitmap |= (1 << aid);
                    WBT_MpParentRecvHook(src, len, aid);
                }
                else
                {
                    WBT_MpChildRecvHook(src, len);
                }
            }
            break;

            case WM_STATECODE_PORT_INIT:
            case WM_STATECODE_DISCONNECTED_FROM_MYSELF:
                break;
        }
    }
}

void WFSi_OnParentSystemCallback(void *arg)
{
    WBTCommand *uc    = (WBTCommand *)arg;
    const int peerAID = WBT_AidbitmapToAid(uc->peer_bmp);

    switch (uc->command)
    {
        case WBT_CMD_SYSTEM_CALLBACK:
            switch (uc->event)
            {
                case WBT_CMD_REQ_USER_DATA: {
                    const WFSiMessage *const msg = (const WFSiMessage *)uc->user_data.data;

                    gWFSWorker->context.parent->recv_msg[peerAID] = *msg;

                    switch (msg->type)
                    {
                        case WFS_MSG_OPENFILE_REQ: {
                            const u32 src         = msg->arg;
                            const u32 len         = msg->flag;
                            const int packet_size = ((msg->pck_h << 8) | msg->pck_l);

                            WFSParentContext *const parent = gWFSWorker->context.parent;

                            if (parent->is_changing || (packet_size != gWFSWorker->parent_packet_size))
                            {
                                parent->is_changing = TRUE;
                                parent->deny_bitmap |= (1 << peerAID);
                                parent->busy_bitmap |= (1 << peerAID);
                            }
                            else
                            {
                                WFSiFileList *target;

                                target = WFSi_FindAlive(parent, src, len);
                                if (target)
                                {
                                    parent->ack_bitmap |= (1 << peerAID);
                                    parent->recv_msg[peerAID].arg = target->own_id;
                                    target->ref++;
                                }
                                else
                                {
                                    target = WFSi_FindBusy(parent, src, len);
                                    target->req_bitmap |= (1 << peerAID);
                                }
                                parent->busy_bitmap |= (1 << peerAID);
                            }
                        }
                        break;

                        case WFS_MSG_CLOSEFILE_REQ: {
                            WFSParentContext *const parent = gWFSWorker->context.parent;

                            {
                                OSIntrMode bak_cpsr = OS_DisableInterrupts();

                                parent->ack_bitmap |= (1 << peerAID);

                                {
                                    WFSiFileList *target = WFSi_FindAliveForID(parent, msg->arg);
                                    if (target)
                                    {
                                        target->ref--;
                                        if (target->ref <= 0)
                                        {
                                            target->req_bitmap = 0;
                                            WBT_UnregisterBlock(msg->arg);
                                            WFSi_FromAliveToBusy(parent, target);
                                            WFSi_NotifyBusy();
                                        }
                                    }
                                }
                                OS_RestoreInterrupts(bak_cpsr);
                            }
                        }
                        break;
                    }
                }
                break;

                case WBT_CMD_REQ_SYNC:
                    break;

                case WBT_CMD_PREPARE_SEND_DATA: {
                    WFSParentContext *const parent = gWFSWorker->context.parent;
                    WFSiFileList *target;

                    WBTPrepareSendDataCallback *const p_prep = &uc->prepare_send_data;

                    const u32 id = p_prep->block_id;

                    p_prep->data_ptr = NULL;

                    target = WFSi_FindAliveForID(parent, id);
                    if (target)
                    {

                        const int width       = p_prep->own_packet_size;
                        const int bak_req_seq = target->ack_seq;
                        const int new_req_seq = p_prep->block_seq_no;
                        int cur_page;

                        if ((target->busy_page != WFS_FILE_CACHE_LINE) && !FS_IsBusy(&target->file))
                            target->busy_page = WFS_FILE_CACHE_LINE;

                        target->ack_seq = (u32)new_req_seq;

                        {
                            const int pos = width * bak_req_seq;
                            for (cur_page = 0; cur_page < WFS_FILE_CACHE_LINE; cur_page++)
                            {
                                if (cur_page != target->busy_page)
                                {
                                    const int ofs = pos - target->page[cur_page];
                                    if ((ofs >= 0) && (ofs + width <= WFS_FILE_CACHE_SIZE))
                                    {
                                        p_prep->block_seq_no = bak_req_seq;
                                        p_prep->data_ptr     = target->cache[cur_page] + ofs;
                                        break;
                                    }
                                }
                            }
                        }

                        if (target->busy_page == WFS_FILE_CACHE_LINE)
                        {
                            int i;
                            int pos = width * new_req_seq;
                            for (i = 0; i < WFS_FILE_CACHE_LINE; i++)
                            {
                                const int ofs = pos - target->page[i];
                                if ((ofs >= 0) && (ofs + width <= WFS_FILE_CACHE_SIZE))
                                    break;
                            }

                            if (i >= WFS_FILE_CACHE_LINE)
                            {
                                int new_page = target->last_page;
                                do
                                {
                                    new_page++;
                                    if (new_page >= WFS_FILE_CACHE_LINE)
                                        new_page = 0;
                                } while (new_page == cur_page);

                                target->last_page = new_page;
                                target->busy_page = new_page;
                                pos &= ~(CARD_ROM_PAGE_SIZE - 1);
                                target->page[new_page] = pos;

                                FS_SeekFile(&target->file, pos, FS_SEEK_SET);
                                FS_ReadFileAsync(&target->file, target->cache[new_page], WFS_FILE_CACHE_SIZE);
                            }
                        }
                    }
                }
                break;

                case WBT_CMD_REQ_GET_BLOCK_DONE:
                    // Missing code?
                    (void)0;
                    break;
            }
            break;
    }
}

void WFSi_ReallocBitmap(WFSChildContext *child, int size)
{
    if (size < 0)
    {
        size                 = child->max_file_size;
        child->max_file_size = 0;
    }

    if (child->max_file_size < size)
    {
        child->max_file_size = size;

        WFSi_Free(child->recv_pkt_bmp_buf);
        child->recv_pkt_bmp_buf                           = (u32 *)(WFSi_Alloc((sizeof(u32) * WBT_PACKET_BITMAP_SIZE(child->max_file_size, gWFSWorker->parent_packet_size))));
        child->recv_buf_packet_bmp_table.packet_bitmap[0] = child->recv_pkt_bmp_buf;
    }
}

void WFSi_OnChildSystemCallback(void *arg)
{
    WBTCommand *uc               = (WBTCommand *)arg;
    int peerAID                  = WBT_AidbitmapToAid(uc->peer_bmp);
    WFSChildContext *const child = gWFSWorker->context.child;

    switch (uc->command)
    {
        case WBT_CMD_REQ_SYNC:
            if (!uc->target_bmp)
            {
                gWFSWorker->parent_packet_size = uc->sync.peer_packet_size + WBT_PACKET_SIZE_MIN;
                gWFSWorker->child_packet_size  = uc->sync.my_packet_size + WBT_PACKET_SIZE_MIN;

                if (!gWFSWorker->table)
                {
                    WBT_GetBlockInfo(WFS_BITMAP_TO_PARENT, 0, &child->block_info_table, WFSi_OnChildSystemCallback);
                }
                else if (gWFSWorker->target_file)
                {
                    WFSi_ReallocBitmap(child, -1);
                    WFSi_ReadRequest(gWFSWorker->target_file);
                }
            }
            break;

        case WBT_CMD_REQ_GET_BLOCKINFO:
            gWFSWorker->table_size = child->block_info_table.block_info[peerAID]->block_size;
            gWFSWorker->table      = (u8 *)WFSi_Alloc(gWFSWorker->table_size);

            WFSi_ReallocBitmap(child, gWFSWorker->table_size);
            child->recv_buf_table.recv_buf[peerAID] = gWFSWorker->table;
            WBT_GetBlock(WFS_BITMAP_TO_PARENT, WFS_FILE_TO_BLOCK(WFS_FILE_TABLEINFO), &child->recv_buf_table, gWFSWorker->table_size, &child->recv_buf_packet_bmp_table,
                         WFSi_OnChildSystemCallback);
            break;

        case WBT_CMD_REQ_GET_BLOCK:
            if (!uc->target_bmp)
            {
                if (gWFSWorker->state != WFS_STATE_READY)
                {
                    DC_FlushRange(gWFSWorker->table, gWFSWorker->table_size);
                    child->base_offset = WFSi_ReplaceRomArchive(gWFSWorker->table);

                    gWFSWorker->state = WFS_STATE_READY;
                    if (gWFSWorker->state_func)
                    {
                        gWFSWorker->state_func(NULL);
                    }
                }
                else
                {
                    if (!WFSi_SendMessage(WFS_MSG_CLOSEFILE_REQ, WFS_BITMAP_TO_PARENT, child->block_id, TRUE))
                        OS_Terminate();
                }
            }
            break;

        case WBT_CMD_SYSTEM_CALLBACK:
            switch (uc->event)
            {
                case WBT_CMD_REQ_USER_DATA: {
                    const WFSiMessage *const msg = (const WFSiMessage *)uc->user_data.data;

                    switch (msg->type)
                    {
                        case WFS_MSG_OPENFILE_ACK:
                            if (!msg->flag)
                            {
                                WBT_RequestSync(WFS_BITMAP_TO_PARENT, WFSi_OnChildSystemCallback);
                            }
                            else
                            {
                                child->block_id                         = msg->arg;
                                child->recv_buf_table.recv_buf[peerAID] = gWFSWorker->target_file->arg.readfile.dst;

                                WBT_GetBlock(WFS_BITMAP_TO_PARENT, child->block_id, &child->recv_buf_table, gWFSWorker->target_file->arg.readfile.len,
                                             &child->recv_buf_packet_bmp_table, WFSi_OnChildSystemCallback);
                            }
                            break;

                        case WFS_MSG_CLOSEFILE_ACK: {
                            FSFile *const target    = gWFSWorker->target_file;
                            FSArchive *const arc    = FS_GetAttachedArchive(gWFSWorker->target_file);
                            gWFSWorker->target_file = NULL;

                            target->prop.file.pos += target->arg.readfile.len;
                            FS_NotifyArchiveAsyncEnd(arc, FS_RESULT_SUCCESS);
                        }
                        break;
                    }
                }
                break;
            }
            break;
    }
}

void WFSi_InitCommon(int port, WFSStateCallback callback, WFSAllocator allocator, void *allocatorArg)
{
    WFSWork *work;

    work = (*allocator)(allocatorArg, sizeof(*work), NULL);
    if (work == NULL)
        OS_Terminate();

    gWFSWorker = work;

    FS_Init(FS_DMA_NOT_USE);
    work->port       = port;
    work->send_idle  = FALSE;
    work->is_running = FALSE;

    work->state       = WFS_STATE_STOP;
    work->state_func  = callback;
    work->alloc_func  = allocator;
    work->alloc_arg   = allocatorArg;
    work->target_file = NULL;
    work->table_size  = 0;
    work->table       = NULL;

    work->parent_packet_size = 0;
    work->child_packet_size  = WBT_PACKET_SIZE_MIN;
    sDebugEnabled            = FALSE;

    if (WM_SetPortCallback(port, WFSi_PortCallback, NULL) != WM_ERRCODE_SUCCESS)
        OS_Terminate();
}

void WFS_InitParent(int port, WFSStateCallback callback, WFSAllocator allocator, void *allocatorArg, int parentPacket, FSFile *rom, BOOL useParentFS)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();
    if (sInitialized == FALSE)
    {
        sInitialized = TRUE;
        WFSi_InitCommon(port, callback, allocator, allocatorArg);
        OS_RestoreInterrupts(bak_cpsr);

        {
            WFSWork *const work                   = gWFSWorker;
            WFSParentContext *const parentContext = work->context.parent;

            work->is_parent = TRUE;

            MI_CpuClear8(parentContext, sizeof(*parentContext));
            DC_FlushRange(parentContext, sizeof(*parentContext));
            DC_WaitWriteBufferEmpty();

            {
                WFSiFileList *fileList   = &parentContext->list[0];
                parentContext->free_list = fileList;
                for (;; fileList = fileList->next)
                {
                    fileList->next = fileList + 1;
                    FS_InitFile(&fileList->file);
                    fileList->ref    = 0;
                    fileList->stat   = WFS_FILE_STAT_FREE;
                    fileList->own_id = (WFS_FILE_TABLEINFO + 1 + fileList - &parentContext->list[0]);
                    if (fileList->next >= &parentContext->list[WFS_FILE_HANDLE_MAX])
                    {
                        fileList->next = NULL;
                        break;
                    }
                }
            }

            parentContext->sync_bitmap = 0;
            parentContext->ack_bitmap  = 0;
            parentContext->msg_busy    = FALSE;
            parentContext->alive_list  = NULL;
            parentContext->busy_list   = NULL;
            work->parent_packet_size   = parentPacket;

            parentContext->all_bitmap  = 1;
            parentContext->busy_bitmap = 0;

            parentContext->is_changing     = FALSE;
            parentContext->deny_bitmap     = 0;
            parentContext->busy_count      = 0;
            parentContext->new_packet_size = work->parent_packet_size;

            MI_CpuClear32(parentContext->sentFileCount, sizeof(parentContext->sentFileCount));

            DC_FlushRange(parentContext, sizeof(*parentContext));
            DC_WaitWriteBufferEmpty();

            WBT_InitParent(work->parent_packet_size, work->child_packet_size, WFSi_OnParentSystemCallback);

            WFSi_LoadTables(rom, useParentFS);
            {
                WFSiFileList *fileList    = parentContext->free_list;
                parentContext->free_list  = fileList->next;
                fileList->next            = parentContext->alive_list;
                parentContext->alive_list = fileList;
                fileList->ref             = 1;
                MI_CpuClear8(fileList, sizeof(*fileList));
                WBT_RegisterBlock(&fileList->info, WFS_FILE_TO_BLOCK(WFS_FILE_TABLEINFO), sWBTBlockUserData, work->table, gWFSWorker->table_size, 0);
            }

            bak_cpsr    = OS_DisableInterrupts();
            work->state = WFS_STATE_IDLE;
            if (work->send_idle)
                WFS_Start();
            OS_RestoreInterrupts(bak_cpsr);

            WFSi_CreateTaskThread();
        }
    }
    else
    {
        OS_RestoreInterrupts(bak_cpsr);
    }
}

void WFS_InitChild(int port, WFSStateCallback callback, WFSAllocator allocator, void *allocatorArg)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();

    if (sInitialized == FALSE)
    {
        sInitialized = TRUE;
        WFSi_InitCommon(port, callback, allocator, allocatorArg);

        OS_RestoreInterrupts(bak_cpsr);

        WFSWork *const worl          = gWFSWorker;
        WFSChildContext *const child = worl->context.child;

        worl->is_parent = FALSE;
        DC_FlushRange(child, sizeof(*child));
        DC_WaitWriteBufferEmpty();

        for (int i = 0; i < WBT_NUM_OF_AID; i++)
        {
            child->block_info_table.block_info[i]             = &child->block_info[i];
            child->recv_buf_table.recv_buf[i]                 = NULL;
            child->recv_buf_packet_bmp_table.packet_bitmap[i] = NULL;
        }

        child->recv_pkt_bmp_buf = NULL;
        child->max_file_size    = 0;
        child->block_id         = 0;

        DC_FlushRange(child, sizeof(*child));
        DC_WaitWriteBufferEmpty();

        WBT_InitChild(WFSi_OnChildSystemCallback);

        bak_cpsr    = OS_DisableInterrupts();
        worl->state = WFS_STATE_IDLE;
        if (worl->send_idle)
            WFS_Start();

        OS_RestoreInterrupts(bak_cpsr);
    }
    else
    {
        OS_RestoreInterrupts(bak_cpsr);
    }
}

void WFS_Start(void)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();
    if (WFS_GetStatus() != WFS_STATE_IDLE)
    {
        gWFSWorker->send_idle = TRUE;
    }
    else
    {
        gWFSWorker->send_idle = TRUE;

        if (gWFSWorker->is_parent == FALSE)
        {
            WFSChildContext *const parentContext = gWFSWorker->context.child;
            WM_ReadStatus(parentContext->status);

            WBT_SetOwnAid(parentContext->status->aid);

            WBT_RequestSync(WFS_BITMAP_TO_PARENT, WFSi_OnChildSystemCallback);
        }
        else
        {
            gWFSWorker->state = WFS_STATE_READY;
            if (gWFSWorker->state_func)
                gWFSWorker->state_func(NULL);
        }

        WFSi_SetMPData();
    }
    OS_RestoreInterrupts(bak_cpsr);
}

void WFS_End(void)
{
    WFSWork *const work = gWFSWorker;

    OSIntrMode bak_cpsr = OS_DisableInterrupts();
    if (sInitialized)
    {
        if (work->table)
        {
            WFSi_Free(work->table);
            work->table      = NULL;
            work->table_size = 0;
        }

        work->state = WFS_STATE_STOP;

        if (gWFSWorker->is_parent == FALSE)
        {
            WFSChildContext *const child = work->context.child;
            if (work->target_file)
            {
                FSFile *const target = work->target_file;

                FSArchive *const arc = FS_GetAttachedArchive(target);
                work->target_file    = NULL;
                FS_NotifyArchiveAsyncEnd(arc, FS_RESULT_ERROR);
            }
            WFSi_Free(child->recv_pkt_bmp_buf);
        }
        else
        {
            WFSi_EndTaskThread();
        }

        WBT_End();

        WM_SetPortCallback(gWFSWorker->port, NULL, NULL);

        WFSi_Free(gWFSWorker);
        gWFSWorker   = NULL;
        sInitialized = FALSE;
    }

    OS_RestoreInterrupts(bak_cpsr);
}

s32 WFS_GetStatus(void)
{
    return gWFSWorker != NULL ? gWFSWorker->state : WFS_STATE_STOP;
}

u32 WFS_GetCurrentBitmap(void)
{
    if (sInitialized == FALSE || gWFSWorker->is_parent == FALSE)
        return 0;

    return gWFSWorker->context.parent->all_bitmap;
}

#if defined(__MWERKS__)
#pragma optimize_for_size on
#endif
u32 WFS_GetSentFileCount(void)
{
    u32 count = 0xFFFFFFFF;

    if (sInitialized == FALSE || gWFSWorker->is_parent == FALSE)
        return 0;

    u32 bitmap = WFS_GetCurrentBitmap();
    for (s32 i = 1; i < 16; i++)
    {
        if ((bitmap & (1 << i)) == 0x00)
            continue;

        if (count > gWFSWorker->context.parent->sentFileCount[i])
            count = gWFSWorker->context.parent->sentFileCount[i];
    }

    return count;
}
#if defined(__MWERKS__)
#pragma optimize_for_size off
#endif

void WFS_EnableSync(u16 syncBitmap)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();

    WFSParentContext *const parent = gWFSWorker->context.parent;

    parent->sync_bitmap = syncBitmap & ~1;

    OS_RestoreInterrupts(bak_cpsr);
}

void WFS_SetDebugMode(BOOL enabled)
{
    sDebugEnabled = enabled;
}