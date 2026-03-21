#include <game/object/objPacket.h>
#include <network/networkHandler.h>
#include <game/network/wirelessManager.h>
#include <game/input/padInput.h>

// --------------------
// CONSTANTS
// --------------------

#define OBJ_PACKET_IDENTIFIER 85

#define OBJ_PACKET_AID_AUTO 0xFF

#define OBJ_PACKET_SEND_QUEUE_SIZE 0x40

// --------------------
// STRUCTS
// --------------------

struct ObjPacketManager
{
    u8 aid;
    void (*clearSendBuffer)(void);
    void *(*getReceiveBuffer)(u32 id);
    size_t minDataSize;
    u8 (*getCurrentAID)(void);
    void *(*getSendBuffer)(void);
};

typedef struct ObjPacketBufferHeader_
{
    struct
    {
        u8 identifier;
        u8 aid;
    };
    u16 param;

    u8 data[0];
} ObjPacketBufferHeader;

// --------------------
// FUNCTION DECLS
// --------------------

static ObjSendPacket *InitPacketForSend(ObjSendPacket *packet, u16 type, u16 priority, u16 dataSize);
static void InitSendBuffer(void);
static u32 GetPacketSize(ObjPacketHeader *header);

// --------------------
// VARIABLES
// --------------------

static struct ObjPacketManager sObjPacketManager = {
    .aid              = OBJ_PACKET_AID_AUTO,
    .clearSendBuffer  = WirelessManager__ClearSendBuffer,
    .getReceiveBuffer = WirelessManager__GetReceiveBuffer,
    .minDataSize      = OBJ_PACKET_SEND_QUEUE_SIZE,
    .getCurrentAID    = WH_GetCurrentAid,
    .getSendBuffer    = WirelessManager__GetSendBuffer,
};

static void *sReceiveBufferStart;
static void *sSendBufferStart;
static ObjSendPacket sObjPacketList[OBJ_PACKET_SEND_QUEUE_SIZE];

extern u8 gObjPacketAIDList[0x10];

// --------------------
// INLINE FUNCTIONS
// --------------------

#define GetReceiveBufferStart(id) (u8*)sObjPacketManager.getReceiveBuffer(gObjPacketAIDList[id])
#define GetReceiveBufferEnd(id) (u8*)((size_t)sObjPacketManager.minDataSize + (size_t)sObjPacketManager.getReceiveBuffer(gObjPacketAIDList[id]))

// --------------------
// FUNCTIONS
// --------------------

void ObjPacket__Init(void *unknown, ObjPacketMode mode, size_t minDataSize)
{
    sSendBufferStart = NULL;
    MI_CpuClear8(sObjPacketList, sizeof(sObjPacketList));
    sReceiveBufferStart = NULL;

    for (u8 i = 0; i < 0x10; i++)
    {
        gObjPacketAIDList[i] = i;
    }

    sObjPacketManager.aid = OBJ_PACKET_AID_AUTO;
    switch (mode)
    {
        case OBJPACKET_MODE_WIFI:
            sObjPacketManager.getReceiveBuffer = GetDataTransferReceiveBuffer;
            sObjPacketManager.getSendBuffer    = GetDataTransferSendBuffer;
            sObjPacketManager.getCurrentAID    = DWC_GetMyAID;
            sObjPacketManager.clearSendBuffer  = ClearDataTransferSendBuffer;
            break;

        // case OBJPACKET_MODE_WIRELESS:
        default:
            sObjPacketManager.getReceiveBuffer = WirelessManager__GetReceiveBuffer;
            sObjPacketManager.getSendBuffer    = WirelessManager__GetSendBuffer;
            sObjPacketManager.getCurrentAID    = WH_GetCurrentAid;
            sObjPacketManager.clearSendBuffer  = WirelessManager__ClearSendBuffer;
            break;
    }

    sObjPacketManager.minDataSize = minDataSize;
}

u16 ObjPacket__GetAIDIndex(u16 aid)
{
    for (u16 i = 0; i < 0x10; i++)
    {
        if (gObjPacketAIDList[i] == aid)
            return i;
    }

    return -1;
}

ObjSendPacket *InitPacketForSend(ObjSendPacket *packet, u16 type, u16 priority, u16 dataSize)
{
    u16 packetSize = dataSize;
    if (dataSize == 0)
        MI_CpuClear8(packet, dataSize);
    else
        MI_CpuClear8(packet, sizeof(ObjPacketHeader));

    packet->header.type     = (u8)type;
    packet->header.priority = (u8)priority;

    if (sSendBufferStart == NULL)
    {
        if (packetSize == 0)
            packetSize = sizeof(ObjPacketHeader);

        packet->header.size = (u8)packetSize;
    }

    return packet;
}

ObjSendPacket *ObjPacket__QueueSendPacket(void *packet, u16 type, u16 priority, u16 dataSize)
{
    ObjSendPacket *packetWork = NULL;
    ObjSendPacket *packetList = sObjPacketList;

    for (u16 i = 1; i < OBJ_PACKET_SEND_QUEUE_SIZE; i++)
    {
        if (sObjPacketList[i].header.type == 0)
        {
            packetWork = &sObjPacketList[i];
            break;
        }
    }

    if (packetWork == NULL)
        return NULL;

    InitPacketForSend(packetWork, type, priority, dataSize + sizeof(ObjPacketHeader));
    packetWork->packet = packet;

    if (packetList->next == NULL)
    {
        packetList->next = packetWork;
        packetWork->next = NULL;

        return packetWork;
    }
    else
    {
        for (ObjSendPacket *packet = packetList->next; TRUE; packet = packet->next)
        {
            if (packet->header.priority < packetWork->header.priority)
            {
                packetWork->next = packetList->next;
                packetList->next = packetWork;

                return packetWork;
            }

            if (packet->next == NULL)
            {
                packet->next     = packetWork;
                packetWork->next = NULL;

                return packetWork;
            }
        }
    }

    return NULL;
}

void InitSendBuffer(void)
{
    ObjPacketBufferHeader *receiveBuffer = (ObjPacketBufferHeader *)sObjPacketManager.getReceiveBuffer(0);
    if (receiveBuffer->aid == OBJ_PACKET_AID_AUTO)
        return;

    for (u16 c = 0; c < whConfig_wmMaxChildCount + 1; c++)
    {
        receiveBuffer = (ObjPacketBufferHeader *)sObjPacketManager.getReceiveBuffer(c);
        if (receiveBuffer->identifier != OBJ_PACKET_IDENTIFIER)
            break;

        if (receiveBuffer->aid != OBJ_PACKET_AID_AUTO)
            gObjPacketAIDList[c] = receiveBuffer->aid;

        receiveBuffer->aid = OBJ_PACKET_AID_AUTO;
    }
}

BOOL ObjPacket__WriteToSendBuffer(void)
{
    ObjSendPacket *next       = sObjPacketList[0].next;
    ObjSendPacket *packetList = &sObjPacketList[0];

    u8 *sendBuffer = sObjPacketManager.getSendBuffer();

    u16 packetSize = 0;
    sObjPacketManager.clearSendBuffer();

    InitSendBuffer();

    if (sObjPacketManager.aid == OBJ_PACKET_AID_AUTO)
        sObjPacketManager.aid = sObjPacketManager.getCurrentAID();

    ObjPacketBufferHeader sendBufferHeader;
    sendBufferHeader.identifier = OBJ_PACKET_IDENTIFIER;
    sendBufferHeader.aid        = gObjPacketAIDList[sObjPacketManager.aid];
    sendBufferHeader.param      = padInput.btnDown;
    sObjPacketManager.aid        = sObjPacketManager.getCurrentAID();

    MI_CpuCopy8(&sendBufferHeader, sendBuffer, sizeof(ObjPacketBufferHeader));

    packetSize += sizeof(ObjPacketBufferHeader);
    while (TRUE)
    {
        if (next == NULL)
        {
            packetList->next = NULL;
            return FALSE;
        }

        if (packetSize + GetPacketSize(&next->header) > sObjPacketManager.minDataSize)
            return TRUE;

        MI_CpuCopy8(next, &sendBuffer[packetSize], sizeof(ObjPacketHeader));
        packetSize += sizeof(ObjPacketHeader);

        if (next->packet != NULL)
        {
            u32 packetSendBufferSize = GetPacketSize(&next->header);
            MI_CpuCopy8(next->packet, &sendBuffer[packetSize], packetSendBufferSize - sizeof(ObjPacketHeader));
            packetSize += packetSendBufferSize - sizeof(ObjPacketHeader);
        }

        ObjSendPacket *prevPacket = next;
        next                      = next->next;
        packetList->next          = next;

        MI_CpuClear8(prevPacket, sizeof(ObjSendPacket));
    }
}

void ObjPacket__PrepareReceivedPackets(void)
{
    sReceiveBufferStart = NULL;
}

void *ObjPacket__GetNextReceivedPacketData(s32 type, s32 id)
{
    ObjReceivePacket *packet = ObjPacket__GetNextReceivedPacket(type, id);
    if (packet == NULL)
        return NULL;

    return packet->data;
}

NONMATCH_FUNC ObjReceivePacket *ObjPacket__GetNextReceivedPacket(s32 type, s32 id)
{
	// https://decomp.me/scratch/ASU4F -> 97.96%
#ifdef NON_MATCHING
    ObjPacketBufferHeader *receiveBuffer = (ObjPacketBufferHeader *)GetReceiveBufferStart(id);
    if (receiveBuffer->identifier != OBJ_PACKET_IDENTIFIER)
        return NULL;

    InitSendBuffer();

    ObjSendPacket *packet = (ObjSendPacket *)sReceiveBufferStart;

    ObjReceivePacket *currentPacket;
    if (GetReceiveBufferStart(id) <= (u8 *)packet && GetReceiveBufferEnd(id) > (u8 *)packet)
    {
        currentPacket      = (ObjReceivePacket *)((u8 *)sReceiveBufferStart + GetPacketSize(&packet->header));
        sReceiveBufferStart = currentPacket;
    }
    else
    {
        currentPacket      = (ObjReceivePacket *)((ObjPacketBufferHeader *)GetReceiveBufferStart(id))->data;
        sReceiveBufferStart = currentPacket;
    }

    while (TRUE)
    {
        if (GetReceiveBufferEnd(id) <= sReceiveBufferStart)
        {
            sReceiveBufferStart = NULL;
            return FALSE;
        }

        if (type == currentPacket->header.type)
            return currentPacket;

        if (currentPacket->header.type == 0)
            return NULL;

        currentPacket      = (ObjReceivePacket *)((u8 *)sReceiveBufferStart + GetPacketSize(&currentPacket->header));
        sReceiveBufferStart = currentPacket;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r4, =gObjPacketAIDList
	ldr r2, =sObjPacketManager
	mov r6, r1
	mov r7, r0
	ldrb r0, [r4, r6]
	ldr r1, [r2, #8]
	blx r1
	ldrb r0, [r0, #0]
	cmp r0, #0x55
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	bl InitSendBuffer
	ldr r2, =sSendBufferStart
	ldr r1, =sObjPacketManager
	ldrb r0, [r4, r6]
	ldr r5, [r2, #4]
	ldr r1, [r1, #8]
	blx r1
	cmp r0, r5
	bhi _02074E74
	ldr r1, =sObjPacketManager
	ldrb r0, [r4, r6]
	ldr r1, [r1, #8]
	blx r1
	ldr r1, =sObjPacketManager
	ldr r1, [r1, #0xc]
	add r0, r1, r0
	cmp r0, r5
	bls _02074E74
	mov r0, r5
	bl GetPacketSize
	ldr r1, =sSendBufferStart
	ldr r2, [r1, #4]
	add r5, r2, r0
	str r5, [r1, #4]
	b _02074E90
_02074E74:
	ldr r1, =sObjPacketManager
	ldrb r0, [r4, r6]
	ldr r1, [r1, #8]
	blx r1
	ldr r1, =sSendBufferStart
	add r5, r0, #4
	str r5, [r1, #4]
_02074E90:
	ldr r4, =gObjPacketAIDList
	ldr r8, =sSendBufferStart
	ldr r9, =sObjPacketManager
_02074E9C:
	ldrb r0, [r4, r6]
	ldr r1, [r9, #8]
	blx r1
	ldr r2, [r9, #0xc]
	ldr r1, [r8, #4]
	add r0, r2, r0
	cmp r0, r1
	bhi _02074ECC
	ldr r1, =sSendBufferStart
	mov r0, #0
	str r0, [r1, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02074ECC:
	ldrh r0, [r5, #0]
	mov r0, r0, lsl #0x18
	cmp r7, r0, lsr #24
	mov r0, r0, lsr #0x18
	moveq r0, r5
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r5
	bl GetPacketSize
	ldr r1, [r8, #4]
	add r5, r1, r0
	str r5, [r8, #4]
	b _02074E9C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

u32 GetPacketSize(ObjPacketHeader *header)
{
    if (sSendBufferStart == NULL)
        return header->size;

    u32 size = *((u8 *)sSendBufferStart + header->type);
    if (size == 0)
        return sizeof(ObjPacketHeader);

    return size;
}