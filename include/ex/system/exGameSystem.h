#ifndef RUSH_EXGAMESYSTEM_H
#define RUSH_EXGAMESYSTEM_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exGameSystemTask_
{
    u16 field_0;
    u16 field_2;
    u16 timer;
    u16 field_6;
    s32 field_8;
    s32 field_C;
} exGameSystemTask;

// --------------------
// FUNCTIONS
// --------------------

// ExGameSystem
NOT_DECOMPILED void exGameSystemTask__Main(void);
NOT_DECOMPILED void exGameSystemTask__Func8(void);
NOT_DECOMPILED void exGameSystemTask__Destructor(void);
NOT_DECOMPILED void exGameSystemTask__Main_216AB78(void);
NOT_DECOMPILED void exGameSystemTask__Action_216ABA8(void);
NOT_DECOMPILED void exGameSystemTask__Main_216ABD4(void);
NOT_DECOMPILED void exGameSystemTask__Action_216AC00(void);
NOT_DECOMPILED void exGameSystemTask__Main_216AC34(void);
NOT_DECOMPILED void exGameSystemTask__Action_216AC68(void);
NOT_DECOMPILED void exGameSystemTask__Main_216ACA0(void);
NOT_DECOMPILED void exGameSystemTask__Action_216ACD0(void);
NOT_DECOMPILED void exGameSystemTask__Main_216ACF0(void);
NOT_DECOMPILED void exGameSystemTask__Create(void);
NOT_DECOMPILED void exGameSystemTask__Destroy(void);

#endif // RUSH_EXGAMESYSTEM_H
