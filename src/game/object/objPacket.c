#include <game/object/objPacket.h>
#include <network/networkHandler.h>
#include <game/network/wirelessManager.h>
#include <game/input/padInput.h>

// --------------------
// STRUCTS
// --------------------

struct ObjPacketStaticVars
{
    void *sendBufferStart;
    void *recieveBufferStart;
};

struct ObjPacketManager
{
    u8 aid;
    void (*clearSendBuffer)(void);
    void *(*getRecieveBuffer)(u32 id);
    size_t minDataSize;
    u8 (*getCurrentAID)(void);
    void *(*getSendBuffer)(void);
};

typedef struct ObjPacketHeader2_
{
    struct
    {
        u8 flag1;
        u8 flag2;
    };
    u16 param;
} ObjPacketHeader2;

// --------------------
// VARIABLES
// --------------------

static struct ObjPacketManager objPacketManager = {
    .aid              = -1,
    .clearSendBuffer  = WirelessManager__ClearSendBuffer,
    .getRecieveBuffer = WirelessManager__GetRecieveBuffer,
    .minDataSize      = 0x40,
    .getCurrentAID    = WH_GetCurrentAid,
    .getSendBuffer    = WirelessManager__GetSendBuffer,
};

NOT_DECOMPILED u8 objPacketAIDList[0x10];
// static u8 objPacketAIDList[0x10] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

static void *recieveBufferStart;
static void *sendBufferStart;
static ObjSendPacket objPacketList[0x40];

// --------------------
// FUNCTIONS
// --------------------

void ObjPacket__Init(void *a1, ObjPacketMode mode, size_t minDataSize)
{
    sendBufferStart = NULL;
    MI_CpuFill8(objPacketList, 0, sizeof(objPacketList));
    recieveBufferStart = NULL;

    for (u8 i = 0; i < 0x10; i++)
    {
        objPacketAIDList[i] = i;
    }

    objPacketManager.aid = -1;
    switch (mode)
    {
        case OBJPACKET_MODE_WIFI:
            objPacketManager.getRecieveBuffer = GetDataTransferRecieveBuffer;
            objPacketManager.getSendBuffer    = GetDataTransferSendBuffer;
            objPacketManager.getCurrentAID    = DWC_GetMyAID;
            objPacketManager.clearSendBuffer  = ClearDataTransferSendBuffer;
            break;

        // case OBJPACKET_MODE_WIRELESS:
        default:
            objPacketManager.getRecieveBuffer = WirelessManager__GetRecieveBuffer;
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
    return 0xFFFF;
}

ObjSendPacket *ObjPacket__InitPacketForSend(ObjSendPacket *packet, u16 type, u16 priority, u16 dataSize)
{
    u16 packetSize = dataSize;
    if (dataSize == 0)
        MI_CpuFill8(packet, 0, dataSize);
    else
        MI_CpuFill8(packet, 0, sizeof(ObjPacketHeader));

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

ObjSendPacket *ObjPacket__SendPacket(void *packet, u16 type, u16 priority, u16 dataSize)
{
    ObjSendPacket *packetWork = NULL;
    ObjSendPacket *packetList = objPacketList;

    for (u16 i = 1; i < 0x40; i++)
    {
        if (objPacketList[i].header.type == 0)
        {
            packetWork = &objPacketList[i];
            break;
        }
    }

    if (packetWork == NULL)
        return NULL;

    ObjPacket__InitPacketForSend(packetWork, type, priority, dataSize + sizeof(ObjPacketHeader));
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

void ObjPacket__Func_2074BB4(void)
{
    ObjPacketHeader2 *packetPtr = (ObjPacketHeader2 *)objPacketManager.getRecieveBuffer(0);
    if (packetPtr->flag2 == 0xFF)
        return;

    for (u16 c = 0; c < whConfig_wmMaxChildCount + 1; c++)
    {
        packetPtr = (ObjPacketHeader2 *)objPacketManager.getRecieveBuffer(c);
        if (packetPtr->flag1 != 85)
            break;

        if (packetPtr->flag2 != 0xFF)
            objPacketAIDList[c] = packetPtr->flag2;

        packetPtr->flag2 = 0xFF;
    }
}

NONMATCH_FUNC BOOL ObjPacket__FillSendDataBuffer(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r0, =objPacketManager
	ldr r1, =sendBufferStart
	ldr r0, [r0, #0x14]
	ldr r7, [r1, #0x10]
	ldr r8, =objPacketList
	blx r0
	ldr r1, =objPacketManager
	mov r9, r0
	ldr r0, [r1, #4]
	mov r10, #0
	blx r0
	bl ObjPacket__Func_2074BB4
	ldr r0, =objPacketManager
	ldrb r1, [r0, #0]
	cmp r1, #0xff
	bne _02074CA0
	ldr r0, [r0, #0x10]
	blx r0
	ldr r1, =objPacketManager
	strb r0, [r1]
_02074CA0:
	ldr r1, =objPacketManager
	ldr r0, =padInput
	ldrb r3, [r1, #0]
	ldr r2, =objPacketAIDList
	ldrh r0, [r0, #0]
	ldrb r2, [r2, r3]
	mov r3, #0x55
	strb r3, [sp]
	strb r2, [sp, #1]
	strh r0, [sp, #2]
	ldr r0, [r1, #0x10]
	blx r0
	ldr r2, =objPacketManager
	mov r1, r9
	strb r0, [r2]
	add r0, sp, #0
	mov r2, #4
	bl MI_CpuCopy8
	add r0, r10, #4
	mov r0, r0, lsl #0x10
	ldr r4, =objPacketManager
	mov r10, r0, lsr #0x10
	mov r6, #4
	mov r11, #0
_02074D00:
	cmp r7, #0
	moveq r0, #0
	streq r0, [r8, #8]
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r7
	bl ObjPacket__GetPacketSize
	ldr r1, [r4, #0xc]
	add r0, r10, r0
	cmp r0, r1
	movhi r0, #1
	ldmhiia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r7
	mov r2, r6
	add r1, r9, r10
	bl MI_CpuCopy8
	add r0, r10, #4
	ldr r1, [r7, #4]
	mov r0, r0, lsl #0x10
	cmp r1, #0
	mov r10, r0, lsr #0x10
	beq _02074D80
	mov r0, r7
	bl ObjPacket__GetPacketSize
	mov r5, r0
	ldr r0, [r7, #4]
	add r1, r9, r10
	sub r2, r5, #4
	bl MI_CpuCopy8
	sub r0, r5, #4
	add r0, r10, r0
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
_02074D80:
	mov r0, r7
	ldr r7, [r7, #8]
	mov r1, r11
	mov r2, #0xc
	str r7, [r8, #8]
	bl MI_CpuFill8
	b _02074D00
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void ObjPacket__Func_2074DB4(void)
{
    recieveBufferStart = NULL;
}

void *ObjPacket__GetRecievedPacketData(s32 type, s32 id)
{
    ObjRecievePacket *packet = ObjPacket__GetRecievedPacket(type, id);
    if (packet == NULL)
        return NULL;

    return packet->data;
}

NONMATCH_FUNC ObjRecievePacket *ObjPacket__GetRecievedPacket(s32 type, s32 id)
{
#ifdef NON_MATCHING

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
	bl ObjPacket__Func_2074BB4
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
	bl ObjPacket__GetPacketSize
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
	bl ObjPacket__GetPacketSize
	ldr r1, [r8, #4]
	add r5, r1, r0
	str r5, [r8, #4]
	b _02074E9C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

u32 ObjPacket__GetPacketSize(ObjPacketHeader *header)
{
    if (sendBufferStart == NULL)
        return header->size;

    u32 size = *((u8 *)sendBufferStart + header->type);
    if (size == 0)
        return sizeof(ObjPacketHeader);

    return size;
}
