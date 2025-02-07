#ifndef RUSH_TOUCH_FIELD_H
#define RUSH_TOUCH_FIELD_H

#include <global.h>
#include <game/input/touchInput.h>
#include <game/graphics/sprite.h>

#ifdef __cplusplus
extern "C"
{
#endif

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

#define TOUCHAREA_PRIORITY_FIRST 0xFFFF

// --------------------
// ENUMS
// --------------------

enum TouchFieldMode_
{
    TOUCHFIELD_MODE_0,
    TOUCHFIELD_MODE_1,
};
typedef u32 TouchFieldMode;

enum TouchFieldFlags_
{
    TOUCHFIELD_FLAG_NONE = 0x00,

    TOUCHFIELD_FLAG_HAS_TOUCH_PRESS     = 1 << 0,
    TOUCHFIELD_FLAG_HAS_TOUCH_HOLD      = 1 << 1,
    TOUCHFIELD_FLAG_HAS_TOUCH_START_POS = 1 << 2,
    TOUCHFIELD_FLAG_HAS_TOUCH_RELEASE   = 1 << 3,
};
typedef u32 TouchFieldFlags;

enum TouchAreaResponseFlags_
{
    TOUCHAREA_RESPONSE_NONE = 0x00,

    // Internal state flags
    TOUCHAREA_RESPONSE_1               = 0x1,
    TOUCHAREA_RESPONSE_2               = 0x2,
    TOUCHAREA_RESPONSE_4               = 0x4,
    TOUCHAREA_RESPONSE_8               = 0x8,
    TOUCHAREA_RESPONSE_IN_BOUNDS       = 0x10,
    TOUCHAREA_RESPONSE_20              = 0x20,
    TOUCHAREA_RESPONSE_DISABLED        = 0x40,
    TOUCHAREA_RESPONSE_NO_BOUNDS_CHECK = 0x80,
    TOUCHAREA_RESPONSE_100             = 0x100,
    TOUCHAREA_RESPONSE_200             = 0x200,
    TOUCHAREA_RESPONSE_IN_RECT2        = 0x400,
    TOUCHAREA_RESPONSE_CHECK_RECT2     = 0x800,
    TOUCHAREA_RESPONSE_WANT_DELAY      = 0x1000,
    TOUCHAREA_RESPONSE_HAS_DELAY       = 0x2000,
    TOUCHAREA_RESPONSE_4000            = 0x4000,
    TOUCHAREA_RESPONSE_8000            = 0x8000,

    // Responce flags
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

typedef struct TouchRectUnknown_
{
    HitboxRect box;
    s32 unknown1;
    s32 unknown2;
} TouchRectUnknown;

struct TouchAreaResponse_
{
    TouchAreaResponseFlags flags;
    Vec2Fx16 move;
};

struct TouchArea_
{
    struct
    {
        struct TouchArea_ *next;
        struct TouchArea_ *prev;
    } link;

    TouchAreaBoundsCheckFunc boundsCheckFunc;
    TouchAreaCallback callback;
    void *context;
    TouchAreaResponseFlags responseFlags;
    TouchAreaResponseFlags prevResponseFlags;
    TouchPos touchPos;

    struct
    {
        u16 priority;
        u16 delay;
    };

    union
    {
        struct
        {
            AnimatorSprite *animator;
            TouchRect rect;
        } sprite;

        struct
        {
            Vec2Fx16 position;
            s32 radius;
            HitboxRect hitbox;
        } shape;
    };
};

typedef struct TouchField_
{
    TouchArea *areaList;
    TouchFieldFlags flags;
    TouchPos touchStartPos;
    TouchFieldMode mode;
    u8 delayDuration1;
    u8 rectSize1;
    u8 rectSize2;
    u8 delayDuration3;
    u8 delayDuration2;
} TouchField;

// --------------------
// FUNCTIONS
// --------------------

void TouchField__Init(TouchField *field);
void TouchField__Process(TouchField *field);
void TouchField__InitAreaShape(TouchArea *area, Vec2Fx16 *pos, TouchAreaBoundsCheckFunc boundsCheckFunc, TouchRectUnknown *rect, TouchAreaCallback callback, void *context);
void TouchField__ResetArea(TouchArea *area);
void TouchField__SetHitbox(TouchArea *area, TouchRectUnknown *rect);
void TouchField__InitAreaSprite(TouchArea *area, void *animator, s32 id, s16 flags, TouchAreaCallback callback, void *context);
void TouchField__SetAreaHitbox(TouchArea *area, HitboxRect *hitbox);
void TouchField__AddArea(TouchField *manager, TouchArea *area, u32 priority);
void TouchField__RemoveArea(TouchField *field, TouchArea *area);
void TouchField__UpdateAreaPriority(TouchField *field, TouchArea *area, u32 priority);
void TouchField__Func_206EA6C(TouchArea *area);
void TouchField__Func_206EAA4(TouchArea *area);
void TouchField__Func_206EAC4(TouchArea *area1, TouchArea *area2);
BOOL TouchField__PointInRect(TouchArea *area);
BOOL TouchField__PointInCircle(TouchArea *area);
BOOL TouchField__PointInAnimator(TouchArea *area);

#ifdef __cplusplus
}
#endif

#endif // RUSH_TOUCH_FIELD_H
