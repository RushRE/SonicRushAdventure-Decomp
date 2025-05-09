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

typedef struct ObjRecievePacket_
{
    ObjPacketHeader header;
    u8 data[1];
} ObjRecievePacket;

typedef struct GameObjectSendPacket_
{
    u8 type;
    u16 id;
} GameObjectSendPacket;

// --------------------
// FUNCTIONS
// --------------------

void ObjPacket__Init(void *a1, ObjPacketMode mode, size_t minDataSize);
u16 ObjPacket__GetAIDIndex(u16 aid);
ObjSendPacket *ObjPacket__InitPacketForSend(ObjSendPacket *packet, u16 type, u16 priority, u16 dataSize);
ObjSendPacket *ObjPacket__SendPacket(void *packet, u16 type, u16 priority, u16 dataSize);
void ObjPacket__Func_2074BB4(void);
BOOL ObjPacket__FillSendDataBuffer(void);
void ObjPacket__Func_2074DB4(void);
void *ObjPacket__GetRecievedPacketData(s32 type, s32 id);
ObjRecievePacket *ObjPacket__GetRecievedPacket(s32 type, s32 id);
u32 ObjPacket__GetPacketSize(ObjPacketHeader *header);

#endif // RUSH_OBJPACKET_H
