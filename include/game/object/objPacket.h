#ifndef RUSH_OBJPACKET_H
#define RUSH_OBJPACKET_H

#include <global.h>

// --------------------
// ENUMS
// --------------------

enum ObjPacketMode_
{
    OBJPACKET_MODE_WIRELESS, // use wireless services like download play & local wireless to communicate
    OBJPACKET_MODE_WIFI,     // use wifi services to communicate
};
typedef u32 ObjPacketMode;

// --------------------
// STRUCTS
// --------------------

typedef struct ObjPacketHeader_
{
    struct
    {
        u16 type : 8;
        u16 priority : 2;
        u16 size : 6;
    };

    u16 param;
} ObjPacketHeader;

typedef struct ObjSendPacket_
{
    ObjPacketHeader header;
    void *packet;
    struct ObjSendPacket_ *next;
} ObjSendPacket;

typedef struct ObjReceivePacket_
{
    ObjPacketHeader header;
    u8 data[1];
} ObjReceivePacket;

typedef struct GameObjectSendPacket_
{
    u8 type;
    u8 playerID;
    u16 id;
} GameObjectSendPacket;

// --------------------
// FUNCTIONS
// --------------------

void ObjPacket__Init(void *unknown, ObjPacketMode mode, size_t minDataSize);
u16 ObjPacket__GetAIDIndex(u16 aid);
ObjSendPacket *ObjPacket__QueueSendPacket(void *packet, u16 type, u16 priority, u16 dataSize);
BOOL ObjPacket__WriteToSendBuffer(void);
void ObjPacket__PrepareReceivedPackets(void);
void *ObjPacket__GetNextReceivedPacketData(s32 type, s32 id);
ObjReceivePacket *ObjPacket__GetNextReceivedPacket(s32 type, s32 id);

#endif // RUSH_OBJPACKET_H
