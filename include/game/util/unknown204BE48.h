#ifndef RUSH2_UNKNOWN204BE48_H
#define RUSH2_UNKNOWN204BE48_H

#include <global.h>

// --------------------
// TYPES
// --------------------

struct TaskUnknown204BE48_;

typedef void (*Unknown204BE48Callback)(s32 type, struct TaskUnknown204BE48_ *work, void *arg);
typedef fx32 (*Unknown204BE48LerpCallback)(s32 start, s32 end, s16 a3, s32 a4);

// --------------------
// STRUCTS
// --------------------

typedef struct TaskUnknown204BE48_
{
    void *data;
    s32 start;
    s32 end;
    u16 varSize;
    u16 field_E;
    u16 field_10;
    u16 field_12;
    u16 speed;
    s16 timer;
    Unknown204BE48LerpCallback lerpCallback;
    u16 field_1C;
    s16 field_1E;
    Unknown204BE48Callback callback;
    void *callbackArg;
} TaskUnknown204BE48;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void Task__Unknown204BE48__Create(void *data, u16 varSize, s32 start, s32 end, u16 a5, u16 a6, Unknown204BE48LerpCallback lerpCallback, u16 a8,
                                                 Unknown204BE48Callback callback, void *arg, u8 pauseLevel, u16 priority, TaskScope scope);
NOT_DECOMPILED void Task__Unknown204BE48__Func_204BF04(Task *task, Unknown204BE48Callback callback, void *arg);
NOT_DECOMPILED void Task__Unknown204BE48__Func_204BF20(void);
NOT_DECOMPILED fx32 Task__Unknown204BE48__LerpValue(s32 start, s32 end, s16 a3, s32 a4);
NOT_DECOMPILED void Task__Unknown204BE48__LerpVec2(Vec2Fx32 *result, Vec2Fx32 *start, Vec2Fx32 *end, fx32 a4, fx32 a5);
NOT_DECOMPILED void Task__Unknown204BE48__LerpVec3(VecFx32 *result, VecFx32 *start, VecFx32 *end, fx32 a4, fx32 a5);
NOT_DECOMPILED u32 Task__Unknown204BE48__Rand(void);
NOT_DECOMPILED s32 Task__Unknown204BE48__Func_204C104(u32 seed);
NOT_DECOMPILED void Task__Unknown204BE48__Main(void);
NOT_DECOMPILED void Task__Unknown204BE48__Destructor(Task *task);
NOT_DECOMPILED s32 Task__Unknown204BE48__GetPercent(int percent, int a2);

#endif // RUSH2_UNKNOWN204BE48_H
