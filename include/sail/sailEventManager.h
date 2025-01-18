#ifndef RUSH_SAILEVENTMANAGER_H
#define RUSH_SAILEVENTMANAGER_H

#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SBBFile_
{
    u32 headerSize;
    u32 segmentCount;
    u32 unknown1;
} SBBFile;

typedef struct SBBObject_
{
    u32 radius;
    u32 field_4;
    u32 field_8;
    u16 type;
    u16 flags;
    u16 field_10;
    u16 field_12;
    u32 field_14;
} SBBObject;

typedef struct SailEventManagerObject_
{
    s32 field_0;
    s32 field_4;
    StageTask *parent;
    s32 field_C;
    u32 radius;
    u32 objectValue4;
    s32 objectValue8;
    VecFx32 position;
    u32 objectValue10;
    u16 id;
    u16 angle;
    u16 type;
    u16 word32;
    u32 flags;
    u32 objectValue14;
    struct SailEventManagerObject_ *objectRef;
} SailEventManagerObject;

typedef struct SailEventManager_
{
    NNSFndList stageObjectList;
    NNSFndList tempObjectList;
    SailEventManagerObject *stageObjectEntries;
    SailEventManagerObject *tempObjectEntries;
    u16 field_20;
    u16 field_22;
    u32 field_24;
    s32 field_28;
    u32 field_2C;
    u32 field_30;
    u16 field_34;
    u16 blockID;
    u32 field_38;
    u32 field_3C;
    u16 activeObjectCount;
    u16 field_42;
    u16 field_44;
    u16 field_46;
    SBBFile *sbbFile;
} SailEventManager;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SailEventManager *SailEventManager__Create(void);

NOT_DECOMPILED void SailEventManager__ProcessSBB(void);
NOT_DECOMPILED void SailEventManager__LoadMapObjects(u32 id);
NOT_DECOMPILED void SailEventManager__LoadObject(SBBObject *object);
NOT_DECOMPILED void SailEventManager__ViewCheck(VecFx32 *position, s32 a2);
NOT_DECOMPILED void SailEventManager__RemoveEntry(SailEventManagerObject *object);
NOT_DECOMPILED SailEventManagerObject *SailEventManager__CreateObject(u16 type, VecFx32 *position);
NOT_DECOMPILED void SailEventManager__CreateObject2(SailEventManagerObject *object);

NOT_DECOMPILED void SailEventManager__Destructor(Task *task);
NOT_DECOMPILED void SailEventManager__Main(void);
NOT_DECOMPILED SailEventManagerObject *SailEventManager__AllocateStageObject(void);
NOT_DECOMPILED SailEventManagerObject *SailEventManager__AllocateTempObject(void);

#endif // !RUSH_SAILEVENTMANAGER_H