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

static struct ObjPacketManager objPacketManager = {
    .aid              = OBJ_PACKET_AID_AUTO,
    .clearSendBuffer  = WirelessManager__ClearSendBuffer,
    .getReceiveBuffer = WirelessManager__GetReceiveBuffer,
    .minDataSize      = OBJ_PACKET_SEND_QUEUE_SIZE,
    .getCurrentAID    = WH_GetCurrentAid,
    .getSendBuffer    = WirelessManager__GetSendBuffer,
};

static void *receiveBufferStart;
static void *sendBufferStart;
static ObjSendPacket objPacketList[OBJ_PACKET_SEND_QUEUE_SIZE];

extern u8 objPacketAIDList[0x10];

// --------------------
// INLINE FUNCTIONS
// --------------------

#define GetReceiveBufferStart(id) (u8*)objPacketManager.getReceiveBuffer(objPacketAIDList[id])
#define GetReceiveBufferEnd(id) (u8*)((size_t)objPacketManager.minDataSize + (size_t)objPacketManager.getReceiveBuffer(objPacketAIDList[id]))

// --------------------
// FUNCTIONS
// --------------------

void ObjPacket__Init(void *unknown, ObjPacketMode mode, size_t minDataSize)
{
    sendBufferStart = NULL;
    MI_CpuClear8(objPacketList, sizeof(objPacketList));
    receiveBufferStart = NULL;

    for (u8 i = 0; i < 0x10; i++)
    {
        objPacketAIDList[i] = i;
    }

    objPacketManager.aid = OBJ_PACKET_AID_AUTO;
    switch (mode)
    {
        case OBJPACKET_MODE_WIFI:
            objPacketManager.getReceiveBuffer = GetDataTransferReceiveBuffer;
            objPacketManager.getSendBuffer    = GetDataTransferSendBuffer;
            objPacketManager.getCurrentAID    = DWC_GetMyAID;
            objPacketManager.clearSendBuffer  = ClearDataTransferSendBuffer;
            break;

        // case OBJPACKET_MODE_WIRELESS:
        default:
            objPacketManager.getReceiveBuffer = WirelessManager__GetReceiveBuffer;
            objPacketManager.getSendBuffer    = WirelessManager__GetSendBuffer;
            objPacketManager.getCurrentAID    = WH_GetCurrentAid;
            objPacketManager.clearSendBuffer  = WirelessManager__ClearSendBuffer;
            break;
    }

    objPacketManager.minDataSize = minDataSize;
}

u16 ObjPacket__GetAIDIndex(u16 aid)
{
    for (u16 i = 0; i < 0x10; i++)
    {
        if (objPacketAIDList[i] == aid)
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

    if (sendBufferStart == NULL)
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
    ObjSendPacket *packetList = objPacketList;

    for (u16 i = 1; i < OBJ_PACKET_SEND_QUEUE_SIZE; i++)
    {
        if (objPacketList[i].header.type == 0)
        {
            packetWork = &objPacketList[i];
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
    ObjPacketBufferHeader *receiveBuffer = (ObjPacketBufferHeader *)objPacketManager.getReceiveBuffer(0);
    if (receiveBuffer->aid == OBJ_PACKET_AID_AUTO)
        return;

    for (u16 c = 0; c < whConfig_wmMaxChildCount + 1; c++)
    {
        receiveBuffer = (ObjPacketBufferHeader *)objPacketManager.getReceiveBuffer(c);
        if (receiveBuffer->identifier != OBJ_PACKET_IDENTIFIER)
            break;

        if (receiveBuffer->aid != OBJ_PACKET_AID_AUTO)
            objPacketAIDList[c] = receiveBuffer->aid;

        receiveBuffer->aid = OBJ_PACKET_AID_AUTO;
    }
}

BOOL ObjPacket__WriteToSendBuffer(void)
{
    ObjSendPacket *next       = objPacketList[0].next;
    ObjSendPacket *packetList = &objPacketList[0];

    u8 *sendBuffer = objPacketManager.getSendBuffer();

    u16 packetSize = 0;
    objPacketManager.clearSendBuffer();

    InitSendBuffer();

    if (objPacketManager.aid == OBJ_PACKET_AID_AUTO)
        objPacketManager.aid = objPacketManager.getCurrentAID();

    ObjPacketBufferHeader sendBufferHeader;
    sendBufferHeader.identifier = OBJ_PACKET_IDENTIFIER;
    sendBufferHeader.aid        = objPacketAIDList[objPacketManager.aid];
    sendBufferHeader.param      = padInput.btnDown;
    objPacketManager.aid        = objPacketManager.getCurrentAID();

    MI_CpuCopy8(&sendBufferHeader, sendBuffer, sizeof(ObjPacketBufferHeader));

    packetSize += sizeof(ObjPacketBufferHeader);
    while (TRUE)
    {
        if (next == NULL)
        {
            packetList->next = NULL;
            return FALSE;
        }

        if (packetSize + GetPacketSize(&next->header) > objPacketManager.minDataSize)
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
    receiveBufferStart = NULL;
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

    ObjSendPacket *packet = (ObjSendPacket *)receiveBufferStart;

    ObjReceivePacket *currentPacket;
    if (GetReceiveBufferStart(id) <= (u8 *)packet && GetReceiveBufferEnd(id) > (u8 *)packet)
    {
        currentPacket      = (ObjReceivePacket *)((u8 *)receiveBufferStart + GetPacketSize(&packet->header));
        receiveBufferStart = currentPacket;
    }
    else
    {
        currentPacket      = (ObjReceivePacket *)((ObjPacketBufferHeader *)GetReceiveBufferStart(id))->data;
        receiveBufferStart = currentPacket;
    }

    while (TRUE)
    {
        if (GetReceiveBufferEnd(id) <= receiveBufferStart)
        {
            receiveBufferStart = NULL;
            return FALSE;
        }

        if (type == currentPacket->header.type)
            return currentPacket;

        if (currentPacket->header.type == 0)
            return NULL;

        currentPacket      = (ObjReceivePacket *)((u8 *)receiveBufferStart + GetPacketSize(&currentPacket->header));
        receiveBufferStart = currentPacket;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r4, =objPacketAIDList
	ldr r2, =objPacketManager
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
	ldr r2, =sendBufferStart
	ldr r1, =objPacketManager
	ldrb r0, [r4, r6]
	ldr r5, [r2, #4]
	ldr r1, [r1, #8]
	blx r1
	cmp r0, r5
	bhi _02074E74
	ldr r1, =objPacketManager
	ldrb r0, [r4, r6]
	ldr r1, [r1, #8]
	blx r1
	ldr r1, =objPacketManager
	ldr r1, [r1, #0xc]
	add r0, r1, r0
	cmp r0, r5
	bls _02074E74
	mov r0, r5
	bl GetPacketSize
	ldr r1, =sendBufferStart
	ldr r2, [r1, #4]
	add r5, r2, r0
	str r5, [r1, #4]
	b _02074E90
_02074E74:
	ldr r1, =objPacketManager
	ldrb r0, [r4, r6]
	ldr r1, [r1, #8]
	blx r1
	ldr r1, =sendBufferStart
	add r5, r0, #4
	str r5, [r1, #4]
_02074E90:
	ldr r4, =objPacketAIDList
	ldr r8, =sendBufferStart
	ldr r9, =objPacketManager
_02074E9C:
	ldrb r0, [r4, r6]
	ldr r1, [r9, #8]
	blx r1
	ldr r2, [r9, #0xc]
	ldr r1, [r8, #4]
	add r0, r2, r0
	cmp r0, r1
	bhi _02074ECC
	ldr r1, =sendBufferStart
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
    if (sendBufferStart == NULL)
        return header->size;

    u32 size = *((u8 *)sendBufferStart + header->type);
    if (size == 0)
        return sizeof(ObjPacketHeader);

    return size;
}