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

NONMATCH_FUNC void WFSi_LoadTables(FSFile *rom, BOOL useParentFS)
{
    // https://decomp.me/scratch/SgSYw -> 98.34%
#ifdef NON_MATCHING
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
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xf4
	movs r5, r0
	mov r0, #0
	moveq r4, #1
	movne r4, r0
	str r0, [sp, #4]
	cmp r4, #0
	mov r8, #0
	bne _0206BFB8
	cmp r1, #0
	movne r8, #1
_0206BFB8:
	add r0, sp, #0x4c
	bl FS_InitFile
	mov r1, #0
	add r0, sp, #0x4c
	sub r2, r1, #0x80000001
	bl FS_CreateFileFromRom
	cmp r4, #0
	beq _0206BFEC
	mov r4, #0
	mov r6, r4
	bl CARD_GetRomHeader
	mov r7, r0
	b _0206C024
_0206BFEC:
	ldr r1, [r5, #0x24]
	ldr r0, [r5, #0x2c]
	add r7, sp, #0x94
	sub r9, r0, r1
	add r4, r9, r1
	mov r0, r5
	mov r1, r7
	mov r2, #0x60
	mov r6, r4
	bl FS_ReadFile
	mov r0, r5
	mov r1, r9
	mov r2, #0
	bl FS_SeekFile
_0206C024:
	cmp r8, #0
	bne _0206C070
	ldr r1, [r7, #0x48]
	ldr r0, [r7, #0x4c]
	str r1, [sp, #0x2c]
	str r0, [sp, #0x30]
	ldr r1, [r7, #0x40]
	ldr r0, [r7, #0x44]
	str r1, [sp, #0x34]
	str r0, [sp, #0x38]
	ldr r1, [r7, #0x50]
	ldr r0, [r7, #0x54]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x40]
	ldr r1, [r7, #0x58]
	ldr r0, [r7, #0x5c]
	str r1, [sp, #0x44]
	str r0, [sp, #0x48]
	b _0206C0C4
_0206C070:
	bl CARD_GetRomHeader
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x4c]
	str r1, [sp, #0x2c]
	str r0, [sp, #0x30]
	bl CARD_GetRomHeader
	ldr r1, [r0, #0x40]
	ldr r0, [r0, #0x44]
	mov r6, #0
	str r1, [sp, #0x34]
	str r0, [sp, #0x38]
	ldr r0, [r7, #0x50]
	add r0, r0, r4
	str r0, [sp, #0x3c]
	ldr r0, [r7, #0x54]
	str r0, [sp, #0x40]
	ldr r0, [r7, #0x58]
	add r0, r0, r4
	str r0, [sp, #0x44]
	ldr r0, [r7, #0x5c]
	str r0, [sp, #0x48]
_0206C0C4:
	ldr r0, [sp, #4]
	mov r2, #0
	add r0, r0, #4
	str r0, [sp, #4]
	add r1, sp, #0x2c
	mov r0, #2
	add r9, sp, #0x1c
_0206C0E0:
	add r3, r1, r2, lsl #3
	cmp r2, #0
	ldr r5, [r3, #4]
	bne _0206C118
	cmp r8, #0
	beq _0206C118
	mov r10, r0
_0206C0FC:
	add r3, r1, r10, lsl #3
	ldr r3, [r3, #4]
	add r10, r10, #1
	mov r3, r3, lsr #5
	cmp r10, #4
	add r5, r5, r3, lsl #3
	blt _0206C0FC
_0206C118:
	add r3, r5, #0x1f
	bic r3, r3, #0x1f
	str r3, [r9, r2, lsl #2]
	add r5, r3, #4
	ldr r3, [sp, #4]
	add r2, r2, #1
	add r3, r3, r5
	cmp r2, #4
	str r3, [sp, #4]
	blt _0206C0E0
	bl OS_DisableInterrupts
	ldr r1, =gWFSWorker
	mov r5, r0
	ldr r2, [r1, #0]
	ldr r1, [sp, #4]
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	str r0, [sp, #8]
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [sp, #8]
	mov r10, #0
	str r6, [r0]
	add r9, r0, #4
	add r5, sp, #0x2c
	add r11, sp, #0x4c
_0206C188:
	add r0, r5, r10, lsl #3
	ldr r1, [r0, #4]
	add r0, sp, #0xc
	str r1, [r9]
	ldr r1, [r5, r10, lsl #3]
	str r9, [r0, r10, lsl #2]
	mov r0, r11
	mov r2, #0
	add r1, r6, r1
	bl FS_SeekFile
	ldr r2, [r9, #0]
	mov r0, r11
	add r1, r9, #4
	bl FS_ReadFile
	add r0, sp, #0x1c
	ldr r0, [r0, r10, lsl #2]
	add r10, r10, #1
	add r0, r0, #4
	add r9, r9, r0
	cmp r10, #4
	blt _0206C188
	cmp r8, #0
	beq _0206C2AC
	ldr r2, [sp, #0xc]
	ldr r0, [r7, #0x48]
	ldr r1, [r2, #0]
	add r11, r4, r0
	mov r0, #2
	add r5, r2, #4
	mov r6, r1, lsr #3
	add r10, r5, r6, lsl #3
	str r0, [sp]
_0206C208:
	ldr r0, [sp]
	add r1, sp, #0xc
	ldr r0, [r1, r0, lsl #2]
	mov r9, #0
	add r7, r0, #4
	ldr r0, [r0, #0]
	mov r8, r0, lsr #5
	cmp r8, #0
	ble _0206C28C
_0206C22C:
	add r1, r7, r9, lsl #5
	ldr r1, [r1, #0x18]
	add r0, sp, #0x4c
	mov r2, #0
	add r1, r11, r1, lsl #3
	bl FS_SeekFile
	add r0, sp, #0x4c
	mov r1, r10
	mov r2, #8
	bl FS_ReadFile
	ldr r2, [r5, r6, lsl #3]
	add r1, r7, r9, lsl #5
	add r2, r2, r4
	add r9, r9, #1
	add r0, r5, r6, lsl #3
	str r2, [r5, r6, lsl #3]
	ldr r2, [r0, #4]
	add r10, r10, #8
	add r2, r2, r4
	str r2, [r0, #4]
	str r6, [r1, #0x18]
	add r6, r6, #1
	cmp r9, r8
	blt _0206C22C
_0206C28C:
	ldr r0, [sp]
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #4
	blt _0206C208
	ldr r0, [sp, #0xc]
	mov r1, r6, lsl #3
	str r1, [r0]
_0206C2AC:
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	add r0, sp, #0x4c
	bl FS_CloseFile
	ldr r1, =gWFSWorker
	ldr r0, [sp, #8]
	ldr r2, [r1, #0]
	str r0, [r2, #0x20]
	ldr r1, [r1, #0]
	ldr r0, [sp, #4]
	str r0, [r1, #0x24]
	add sp, sp, #0xf4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
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

NONMATCH_FUNC WFSiFileList *WFSi_FindAlive(WFSParentContext *parentContext, u32 top, u32 len)
{
    // https://decomp.me/scratch/x1j7s -> 49.38%
#ifdef NON_MATCHING
    WFSiFileList *fileList;

    for (fileList = parentContext->alive_list; fileList; fileList = fileList->next)
    {
        if (fileList->stat == WFS_FILE_STAT_ALIVE && FS_GetFileImageTop(&fileList->file) == top && FS_GetLength(&fileList->file) == len)
            break;
    }

    return fileList;
#else
    // clang-format off
	add r0, r0, #0x10000
	ldr r0, [r0, #0x744]
	cmp r0, #0
	bxeq lr
_0206C7E0:
	ldr r3, [r0, #0x80]
	cmp r3, #2
	ldreq ip, [r0, #0x5c]
	cmpeq r1, ip
	ldreq r3, [r0, #0x60]
	subeq r3, r3, ip
	cmpeq r2, r3
	bxeq lr
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206C7E0
	bx lr

// clang-format on
#endif
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

NONMATCH_FUNC void WFSi_OnParentSystemCallback(void *arg)
{
    // https://decomp.me/scratch/hlFRn -> 99.71%
#ifdef NON_MATCHING
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
                    break;
            }
            break;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldrh r0, [r4, #0xa]
	bl WBT_AidbitmapToAid
	ldr r1, [r4, #0]
	mov r5, r0
	cmp r1, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #2
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #0xd
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #8
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #0xa
	beq _0206CCCC
	cmp r0, #0xd
	beq _0206CE64
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CCCC:
	ldr r3, =gWFSWorker
	add r6, r4, #0x14
	ldr r1, [r3, #0]
	mov r0, #0xc
	mla r0, r5, r0, r1
	add r7, r0, #0x440
	ldmia r6, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldr r4, [r4, #0x14]
	mov r0, r4, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _0206CD08
	cmp r0, #2
	beq _0206CDEC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CD08:
	ldr r1, [r3, #0]
	mov r3, r4, lsl #0x18
	add r7, r1, #0x440
	add r0, r7, #0x10000
	ldr r0, [r0, #0x760]
	ldrb r2, [r6, #8]
	mov r3, r3, lsr #0x1c
	cmp r0, #0
	ldreq r0, [r1, #0x28]
	orr r2, r2, r3, lsl #8
	mov r4, r4, lsr #8
	ldr r6, [r6, #4]
	cmpeq r2, r0
	beq _0206CD68
	add r0, r7, #0x10000
	mov r2, #1
	str r2, [r0, #0x760]
	ldr r1, [r0, #0x768]
	orr r1, r1, r2, lsl r5
	str r1, [r0, #0x768]
	ldr r1, [r0, #0x75c]
	orr r1, r1, r2, lsl r5
	str r1, [r0, #0x75c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CD68:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl WFSi_FindAlive
	cmp r0, #0
	beq _0206CDB4
	add r1, r7, #0x10000
	mov r2, #0xc
	ldr r4, [r1, #0x74c]
	mov r3, #1
	orr r3, r4, r3, lsl r5
	str r3, [r1, #0x74c]
	mla r1, r5, r2, r7
	ldr r2, [r0, #0x8c]
	str r2, [r1, #4]
	ldr r1, [r0, #0x84]
	add r1, r1, #1
	str r1, [r0, #0x84]
	b _0206CDD4
_0206CDB4:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl WFSi_FindBusy
	ldr r2, [r0, #0x88]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x88]
_0206CDD4:
	add r0, r7, #0x10000
	ldr r2, [r0, #0x75c]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x75c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CDEC:
	ldr r0, [r3, #0]
	add r4, r0, #0x440
	bl OS_DisableInterrupts
	add r1, r4, #0x10000
	ldr r3, [r1, #0x74c]
	mov r2, #1
	orr r2, r3, r2, lsl r5
	str r2, [r1, #0x74c]
	mov r7, r0
	ldr r1, [r6, #4]
	mov r0, r4
	bl WFSi_FindAliveForID
	movs r5, r0
	beq _0206CE58
	ldr r0, [r5, #0x84]
	sub r0, r0, #1
	str r0, [r5, #0x84]
	cmp r0, #0
	bgt _0206CE58
	mov r0, #0
	str r0, [r5, #0x88]
	ldr r0, [r6, #4]
	bl WBT_UnregisterBlock
	mov r0, r4
	mov r1, r5
	bl WFSi_FromAliveToBusy
	bl WFSi_NotifyBusy
_0206CE58:
	mov r0, r7
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CE64:
	ldr r0, =gWFSWorker
	ldr r1, [r4, #0x14]
	ldr r0, [r0, #0]
	mov r2, #0
	add r0, r0, #0x440
	str r2, [r4, #0x1c]
	bl WFSi_FindAliveForID
	movs r5, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x9c]
	ldrsh r0, [r4, #0x20]
	cmp r1, #2
	ldr r1, [r5, #0x98]
	ldr r2, [r4, #0x18]
	beq _0206CEBC
	ldr r3, [r5, #0x44]
	tst r3, #1
	movne r3, #1
	moveq r3, #0
	cmp r3, #0
	moveq r3, #2
	streq r3, [r5, #0x9c]
_0206CEBC:
	mul ip, r0, r1
	str r2, [r5, #0x98]
	mov r3, #0
	b _0206CF10
_0206CECC:
	ldr r6, [r5, #0x9c]
	cmp r3, r6
	beq _0206CF0C
	add r6, r5, r3, lsl #2
	ldr r6, [r6, #0xa4]
	subs r7, ip, r6
	bmi _0206CF0C
	add r6, r7, r0
	cmp r6, #0x400
	bgt _0206CF0C
	add r6, r5, #0xc0
	add r6, r6, r3, lsl #10
	str r1, [r4, #0x18]
	add r1, r6, r7
	str r1, [r4, #0x1c]
	b _0206CF18
_0206CF0C:
	add r3, r3, #1
_0206CF10:
	cmp r3, #2
	blt _0206CECC
_0206CF18:
	ldr r1, [r5, #0x9c]
	cmp r1, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mul r6, r0, r2
	mov r2, #0
	b _0206CF50
_0206CF30:
	add r1, r5, r2, lsl #2
	ldr r1, [r1, #0xa4]
	subs r1, r6, r1
	bmi _0206CF4C
	add r1, r1, r0
	cmp r1, #0x400
	ble _0206CF58
_0206CF4C:
	add r2, r2, #1
_0206CF50:
	cmp r2, #2
	blt _0206CF30
_0206CF58:
	cmp r2, #2
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r4, [r5, #0xa0]
	mov r0, #0
_0206CF68:
	add r4, r4, #1
	cmp r4, #2
	movge r4, r0
	cmp r4, r3
	beq _0206CF68
	mov r0, #0x200
	str r4, [r5, #0xa0]
	rsb r0, r0, #0
	and r1, r6, r0
	str r4, [r5, #0x9c]
	add r3, r5, r4, lsl #2
	add r0, r5, #0x38
	mov r2, #0
	str r1, [r3, #0xa4]
	bl FS_SeekFile
	add r1, r5, #0xc0
	add r0, r5, #0x38
	add r1, r1, r4, lsl #10
	mov r2, #0x400
	bl FS_ReadFileAsync
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
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