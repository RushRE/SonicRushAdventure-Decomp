#ifndef RUSH_SEAMAPUNKNOWN204AB60_H
#define RUSH_SEAMAPUNKNOWN204AB60_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapUnknown204AB60ObjectType_
{
    SEAMAPUNKNOWN204AB60OBJECT_TYPE_0,
    SEAMAPUNKNOWN204AB60OBJECT_TYPE_1,
    SEAMAPUNKNOWN204AB60OBJECT_TYPE_2,
    SEAMAPUNKNOWN204AB60OBJECT_TYPE_3,
    SEAMAPUNKNOWN204AB60OBJECT_TYPE_4,
};
typedef s32 SeaMapUnknown204AB60ObjectType;

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapUnknown204AB60Object_
{
    fx32 distance;
    SeaMapUnknown204AB60ObjectType type;

    union
    {
        struct
        {
            s32 unknown;
            s32 unlockID;
        } type1;

        struct
        {
            s32 attribute;
        } type2;

        struct
        {
            s32 value;
        } type3;

        struct
        {
            s32 type;
            CHEVObject *chevRef;
        } type4;
    };

    s32 field_10;

} SeaMapUnknown204AB60Object;

typedef struct SeaMapUnknown204AB60ObjectLink_
{
    NNSFndLink link;
    SeaMapUnknown204AB60Object object;
} SeaMapUnknown204AB60ObjectLink;

typedef struct SeaMapUnknown204AB60StaticVars_
{
    u32 field_0;
    NNSFndList list;
} SeaMapUnknown204AB60StaticVars;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED BOOL SeaMapUnknown204AB60__Init(void);
NOT_DECOMPILED s32 SeaMapUnknown204AB60__Func_204ABB0(void);
NOT_DECOMPILED s32 SeaMapUnknown204AB60__Func_204ABBC(void);
NOT_DECOMPILED SeaMapUnknown204AB60ObjectLink *SeaMapUnknown204AB60__Func_204ABCC(s32 a1);
NOT_DECOMPILED s32 SeaMapUnknown204AB60__Func_204AC04(void);
NOT_DECOMPILED BOOL SeaMapUnknown204AB60__Func_204AC6C(s32 a1, s32 a2);
NOT_DECOMPILED BOOL SeaMapUnknown204AB60__Func_204AD10(s32 a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
NOT_DECOMPILED void SeaMapUnknown204AB60__Func_204AE28(s32 a1, s32 a2, s32 a3, s32 a4);
NOT_DECOMPILED void SeaMapUnknown204AB60__Func_204B038(s32 a1, s32 x, s32 y);
NOT_DECOMPILED void SeaMapUnknown204AB60__AddObjectForAttr(s32 a1, s32 x, s32 y);
NOT_DECOMPILED void SeaMapUnknown204AB60__AddObjectForLV(s32 a1, s32 x, s32 y);
NOT_DECOMPILED void SeaMapUnknown204AB60__InitList(void);
NOT_DECOMPILED SeaMapUnknown204AB60ObjectLink *SeaMapUnknown204AB60__AddObject(SeaMapUnknown204AB60Object *work);
NOT_DECOMPILED void SeaMapUnknown204AB60__RemoveAllObjects(void);
NOT_DECOMPILED SeaMapUnknown204AB60ObjectLink *SeaMapUnknown204AB60__FindObject(u32 type);
NOT_DECOMPILED SeaMapUnknown204AB60ObjectLink *SeaMapUnknown204AB60__FindObject2(u32 attr, CHEVObject *work);
NOT_DECOMPILED u32 SeaMapManager__GetAttribute(s32 x, s32 y);
NOT_DECOMPILED u32 SeaMapManager__GetCHLV(s32 x, s32 y);
NOT_DECOMPILED void SeaMapUnknown204AB60__Func_204B4F0(s32 a1, s32 a2, s32 a3);

#endif // RUSH_SEAMAPUNKNOWN204AB60_H
