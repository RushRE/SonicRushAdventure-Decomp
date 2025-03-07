#ifndef RUSH_SEAMAPUNKNOWN204A9E4_H
#define RUSH_SEAMAPUNKNOWN204A9E4_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

typedef BOOL (*SeaMapUnknown204A9E4Callback)(s32 a1, void *work, CHEVObject *mapObject, s32 a3);

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapUnknown204A9E4Object_
{
    NNSFndLink link;
    SeaMapUnknown204A9E4Callback callback;
    void *work;
} SeaMapUnknown204A9E4Object;

typedef struct SeaMapUnknown204A9E4StaticVars_
{
    u32 field_0;
    NNSFndList list;
} SeaMapUnknown204A9E4StaticVars;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapUnknown204A9E4__Func_204A9E4(void);
NOT_DECOMPILED void SeaMapUnknown204A9E4__Func_204AA00(void);
NOT_DECOMPILED SeaMapUnknown204A9E4Object *SeaMapUnknown204A9E4__AddObject(SeaMapUnknown204A9E4Callback callback, void *work);
NOT_DECOMPILED void SeaMapUnknown204A9E4__RemoveObject(SeaMapUnknown204A9E4Object *work);
NOT_DECOMPILED void SeaMapUnknown204A9E4__RunCallbacks(s32 a1, CHEVObject *a2, s32 a3);
NOT_DECOMPILED void SeaMapUnknown204A9E4__InitList(void);

#endif // RUSH_SEAMAPUNKNOWN204A9E4_H