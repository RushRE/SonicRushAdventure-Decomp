#ifndef RUSH2_TOUCH_FIELD_H
#define RUSH2_TOUCH_FIELD_H

#include <global.h>
#include <game/input/touchInput.h>
#include <game/graphics/sprite.h>

// --------------------
// TYPES
// --------------------

typedef struct TouchArea_ TouchArea;
typedef struct TouchAreaResponse_ TouchAreaResponse;
typedef u32 TouchAreaResponseFlags;

typedef BOOL (*TouchAreaBoundsCheckFunc)(TouchArea *area);
typedef void (*TouchAreaCallback)(TouchAreaResponse *responce, TouchArea *area, void *userData);

// --------------------
// CONSTANTS
// --------------------

// --------------------
// ENUMS
// --------------------

enum TouchAreaResponseFlags_
{
    TOUCHAREA_RESPONSE_1                 = 0x1,
    TOUCHAREA_RESPONSE_2                 = 0x2,
    TOUCHAREA_RESPONSE_4                 = 0x4,
    TOUCHAREA_RESPONSE_8                 = 0x8,
    TOUCHAREA_RESPONSE_IN_BOUNDS         = 0x10,
    TOUCHAREA_RESPONSE_20                = 0x20,
    TOUCHAREA_RESPONSE_40                = 0x40,
    TOUCHAREA_RESPONSE_80                = 0x80,
    TOUCHAREA_RESPONSE_100               = 0x100,
    TOUCHAREA_RESPONSE_200               = 0x200,
    TOUCHAREA_RESPONSE_IN_RECT2          = 0x400,
    TOUCHAREA_RESPONSE_CHECK_RECT2       = 0x800,
    TOUCHAREA_RESPONSE_WANT_DELAY        = 0x1000,
    TOUCHAREA_RESPONSE_HAS_DELAY         = 0x2000,
    TOUCHAREA_RESPONSE_4000              = 0x4000,
    TOUCHAREA_RESPONSE_8000              = 0x8000,
    TOUCHAREA_RESPONSE_ENTERED_AREA_2    = 0x10000,
    TOUCHAREA_RESPONSE_20000             = 0x20000,
    TOUCHAREA_RESPONSE_40000             = 0x40000,
    TOUCHAREA_RESPONSE_80000             = 0x80000,
    TOUCHAREA_RESPONSE_100000            = 0x100000,
    TOUCHAREA_RESPONSE_ENTERED_AREA_3    = 0x200000,
    TOUCHAREA_RESPONSE_ENTERED_AREA_ALT  = 0x400000,
    TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT = 0x800000,
    TOUCHAREA_RESPONSE_EXITED_AREA_ALT   = 0x1000000,
    TOUCHAREA_RESPONSE_ENTERED_AREA      = 0x2000000,
    TOUCHAREA_RESPONSE_MOVED_IN_AREA     = 0x4000000,
    TOUCHAREA_RESPONSE_EXITED_AREA       = 0x8000000,
    TOUCHAREA_RESPONSE_10000000          = 0x10000000,
    TOUCHAREA_RESPONSE_20000000          = 0x20000000,
    TOUCHAREA_RESPONSE_40000000          = 0x40000000,
    TOUCHAREA_RESPONSE_80000000          = 0x80000000,
};

// --------------------
// STRUCTS
// --------------------

typedef struct TouchRect_
{
    union
    {
        struct
        {
            u16 id;
            u16 flags;
        };

        u32 id_flags_value;
    };
    
    HitboxRect box;
    s32 unknown;
} TouchRect;

struct TouchAreaResponse_
{
    TouchAreaResponseFlags flags;
    Vec2Fx16 move;
};

struct TouchArea_
{
    NNSFndLink link;
    TouchAreaBoundsCheckFunc boundsCheckFunc;
    TouchAreaCallback callback;
    void *context;
    TouchAreaResponseFlags responseFlags;
    TouchAreaResponseFlags prevResponseFlags;
    TouchPos touchPos;

    struct
    {
        u16 priority;
        u16 field_2;
    };

    union
    {
        struct
        {
            AnimatorSprite *animator;
            u16 hitboxID;
            u16 aniFlags;
            HitboxRect hitbox;
            u32 unknown;
        } sprite;

        struct
        {
            Vec2Fx16 position;
            s32 radius;
            HitboxRect hitbox;
            u32 unknown;
        } shape;
    };
};

typedef struct TouchField_
{
    TouchArea *areaList;
    u32 flags;
    TouchPos touchPos;
    u32 mode;
    u8 delayDuration1;
    u8 rectSize1;
    u8 rectSize2;
    u8 delayDuration3;
    u8 delayDuration2;
} TouchField;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void TouchField__Init(TouchField *field);
NOT_DECOMPILED void TouchField__Process(TouchField *field);
NOT_DECOMPILED void TouchField__InitAreaShape(TouchArea *area, Vec2Fx16 *pos, TouchAreaBoundsCheckFunc boundsCheckFunc, TouchRect *rect, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__ResetArea(TouchArea *area);
NOT_DECOMPILED void TouchField__SetHitbox(TouchArea *area, void *a2);
NOT_DECOMPILED void TouchField__InitAreaSprite(TouchArea *area, void *animatorPtr, s32 hitboxID, s16 aniFlags, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__SetAreaHitbox(TouchArea *area, void *hitbox);
NOT_DECOMPILED void TouchField__AddArea(TouchField *manager, TouchArea *area, unsigned int priority);
NOT_DECOMPILED void TouchField__RemoveArea(TouchField *manager, TouchArea *entry);
NOT_DECOMPILED void TouchField__UpdateAreaPriority(TouchField *manager, TouchArea *entry, unsigned int priority);
NOT_DECOMPILED void TouchField__Func_206EA6C(TouchArea *area);
NOT_DECOMPILED void TouchField__Func_206EAA4(TouchArea *area);
NOT_DECOMPILED void TouchField__Func_206EAC4(TouchArea *area1, TouchArea *area2);
NOT_DECOMPILED BOOL TouchField__PointInRect(TouchArea *area);
NOT_DECOMPILED BOOL TouchField__PointInCircle(TouchArea *area);
NOT_DECOMPILED BOOL TouchField__PointInAnimator(TouchArea *area);
NOT_DECOMPILED void TouchField__ProcessSingle(TouchArea *area, TouchArea *entry, BOOL a3);
NOT_DECOMPILED void TouchField__Func_206F2A8(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F2C4(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F2E0(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F2FC(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F318(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F334(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F350(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F36C(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F3B8(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F3D4(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F3F0(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
NOT_DECOMPILED void TouchField__Func_206F43C(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);

#endif // RUSH2_TOUCH_FIELD_H
