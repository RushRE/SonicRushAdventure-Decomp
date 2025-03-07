#ifndef RUSH_SAILEVENTMANAGER_H
#define RUSH_SAILEVENTMANAGER_H

#include <stage/stageTask.h>
#include <sail/sailRingManager.h>
#include <seaMap/seaMapCommon.h>

// --------------------
// ENUMS
// --------------------

enum SailMapObjectTypes
{
    SAILMAPOBJECT_TYPE_JET_HOVER,
    SAILMAPOBJECT_TYPE_BOAT,
    SAILMAPOBJECT_TYPE_SUBMARINE,

    SAILMAPOBJECT_TYPE_COUNT,
};

enum SailMapObjectIDs
{
    SAILMAPOBJECT_NONE,
    SAILMAPOBJECT_RING,
    SAILMAPOBJECT_2,
    SAILMAPOBJECT_3,
    SAILMAPOBJECT_4,
    SAILMAPOBJECT_5,
    SAILMAPOBJECT_6,
    SAILMAPOBJECT_7,
    SAILMAPOBJECT_8,
    SAILMAPOBJECT_9,
    SAILMAPOBJECT_10,
    SAILMAPOBJECT_11,
    SAILMAPOBJECT_12,
    SAILMAPOBJECT_13,
    SAILMAPOBJECT_14,
    SAILMAPOBJECT_15,
    SAILMAPOBJECT_16,
    SAILMAPOBJECT_17,
    SAILMAPOBJECT_18,
    SAILMAPOBJECT_19,
    SAILMAPOBJECT_20,
    SAILMAPOBJECT_21,
    SAILMAPOBJECT_22,
    SAILMAPOBJECT_23,
    SAILMAPOBJECT_24,
    SAILMAPOBJECT_25,
    SAILMAPOBJECT_26,
    SAILMAPOBJECT_27,
    SAILMAPOBJECT_28,
    SAILMAPOBJECT_29,
    SAILMAPOBJECT_30,
    SAILMAPOBJECT_31,
    SAILMAPOBJECT_32,
    SAILMAPOBJECT_33,
    SAILMAPOBJECT_34,
    SAILMAPOBJECT_35,
    SAILMAPOBJECT_36,
    SAILMAPOBJECT_37,

    SAILMAPOBJECT_COUNT,
};

enum SailMapObjectFlags_
{
    SAILMAPOBJECT_FLAG_NONE = 0x00,

    SAILMAPOBJECT_FLAG_100  = 0x100,
    SAILMAPOBJECT_FLAG_200  = 0x200,
    SAILMAPOBJECT_FLAG_400  = 0x400,

    SAILMAPOBJECT_FLAG_8000000  = 0x8000000,
    SAILMAPOBJECT_FLAG_10000000 = 0x10000000,
    SAILMAPOBJECT_FLAG_20000000 = 0x20000000,
    SAILMAPOBJECT_FLAG_40000000 = 0x40000000,
    SAILMAPOBJECT_FLAG_80000000 = 0x80000000,
};
typedef u32 SailMapObjectFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct SBBFile_
{
    u32 headerSize;
    u32 segmentCount;
    u32 unknown1;
} SBBFile;

typedef struct SBBUnknown2_
{
    u32 field_0;
} SBBUnknown2;

typedef struct SBBUnknown_
{
    u32 offset;
    u16 field_4;
    u16 field_6;
} SBBUnknown;

typedef struct SBBUnknownHeader_
{
    u32 headerSize;
    SBBUnknown entries[1];
} SBBUnknownHeader;

typedef struct SBBObject_
{
    VecFx32 unknown;
    u16 type;
    u16 flags;
    u16 field_10;
    u16 field_12;
    u32 field_14;
} SBBObject;

typedef struct SBBSegment_
{
    u32 offset;
    u16 count;
    u16 flags;
    u16 unknown;
    u16 field_A;
} SBBSegment;

typedef struct SailEventManagerObject_
{
    s32 field_0;
    s32 field_4;
    StageTask *objTask;
    SailRing *ringTask;
    VecFx32 unknown;
    VecFx32 position;
    s32 objectValue10;
    u16 id;
    u16 angle;
    u16 type;
    u16 word32;
    SailMapObjectFlags flags;
    u32 objectValue14;
    SBBObject *objectRef;
} SailEventManagerObject;

typedef struct SailEventManager_
{
    NNSFndList stageObjectList;
    NNSFndList tempObjectList;
    SailEventManagerObject *stageObjectEntries;
    SailEventManagerObject *tempObjectEntries;
    u16 field_20;
    u16 field_22;
    VecFx32 field_24;
    fx32 field_30;
    u16 field_34;
    u16 blockID;
    s32 field_38;
    s32 field_3C;
    u16 activeObjectCount;
    u16 field_42;
    u16 field_44;
    u16 field_46;
    SBBFile *sbbFile;
} SailEventManager;

// --------------------
// TYPES
// --------------------

typedef StageTask *(*SailObjectSpawnFunc)(SailEventManagerObject *mapObject);

// --------------------
// VARIABLES
// --------------------

extern const u16 _0218B9AC[SHIP_COUNT];
extern const u16 _0218B9B4[SHIP_COUNT];

extern const SailObjectSpawnFunc sailObjectSpawnList[SAILMAPOBJECT_TYPE_COUNT][SAILMAPOBJECT_COUNT];

// --------------------
// FUNCTIONS
// --------------------

SailEventManager *SailEventManager__Create(void);

void SailEventManager__ProcessSBB(void);
void SailEventManager__LoadMapObjects(u32 id);
void SailEventManager__LoadObject(SBBObject *object);
BOOL SailEventManager__ViewCheck(VecFx32 *position, s32 a2);
void SailEventManager__RemoveEntry(SailEventManagerObject *object);
SailEventManagerObject *SailEventManager__CreateObject(u16 type, VecFx32 *position);
void SailEventManager__CreateObject2(SailEventManagerObject *object);

void SailEventManager__Destructor(Task *task);
void SailEventManager__Main(void);
SailEventManagerObject *SailEventManager__AllocateStageObject(void);
SailEventManagerObject *SailEventManager__AllocateTempObject(void);

#endif // !RUSH_SAILEVENTMANAGER_H