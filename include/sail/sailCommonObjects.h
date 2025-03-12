#ifndef RUSH_SAILCOMMONOBJECTS_H
#define RUSH_SAILCOMMONOBJECTS_H

#include <stage/stageTask.h>
#include <game/object/objDraw.h>
#include <sail/sailManager.h>
#include <sail/sailEventManager.h>
#include <sail/sailVoyageManager.h>

// --------------------
// ENUMS
// --------------------

enum SailStageObjTypes_
{
    SAILSTAGE_OBJ_TYPE_PLAYER,
    SAILSTAGE_OBJ_TYPE_OBJECT,
    SAILSTAGE_OBJ_TYPE_EFFECT,
};
typedef u16 SailStageObjTypes;

enum SailObjectFlags_
{
    SAILOBJECT_FLAG_NONE = 0x00,

    SAILOBJECT_FLAG_1        = 1 << 0,
    SAILOBJECT_FLAG_2        = 1 << 1,
    SAILOBJECT_FLAG_4        = 1 << 2,
    SAILOBJECT_FLAG_8        = 1 << 3,
    SAILOBJECT_FLAG_10       = 1 << 4,
    SAILOBJECT_FLAG_20       = 1 << 5,
    SAILOBJECT_FLAG_40       = 1 << 6,
    SAILOBJECT_FLAG_80       = 1 << 7,
    SAILOBJECT_FLAG_100      = 1 << 8,
    SAILOBJECT_FLAG_200      = 1 << 9,
    SAILOBJECT_FLAG_400      = 1 << 10,
    SAILOBJECT_FLAG_800      = 1 << 11,
    SAILOBJECT_FLAG_1000     = 1 << 12,
    SAILOBJECT_FLAG_2000     = 1 << 13,
    SAILOBJECT_FLAG_4000     = 1 << 14,
    SAILOBJECT_FLAG_8000     = 1 << 15,
    SAILOBJECT_FLAG_10000    = 1 << 16,
    SAILOBJECT_FLAG_20000    = 1 << 17,
    SAILOBJECT_FLAG_40000    = 1 << 18,
    SAILOBJECT_FLAG_80000    = 1 << 19,
    SAILOBJECT_FLAG_100000   = 1 << 20,
    SAILOBJECT_FLAG_200000   = 1 << 21,
    SAILOBJECT_FLAG_400000   = 1 << 22,
    SAILOBJECT_FLAG_800000   = 1 << 23,
    SAILOBJECT_FLAG_1000000  = 1 << 24,
    SAILOBJECT_FLAG_2000000  = 1 << 25,
    SAILOBJECT_FLAG_4000000  = 1 << 26,
    SAILOBJECT_FLAG_8000000  = 1 << 27,
    SAILOBJECT_FLAG_10000000 = 1 << 28,
    SAILOBJECT_FLAG_20000000 = 1 << 29,
    SAILOBJECT_FLAG_40000000 = 1 << 30,
    SAILOBJECT_FLAG_80000000 = 1 << 31,
};
typedef u32 SailObjectFlags;

enum SailColliderWorkType_
{
    SAILCOLLIDER_TYPE_NONE,
    SAILCOLLIDER_TYPE_BOX,
    SAILCOLLIDER_TYPE_LINE,
};
typedef u16 SailColliderWorkType;

enum SailColliderFlags_
{
    SAILCOLLIDER_FLAG_NONE = 0x00,

    SAILCOLLIDER_FLAG_1    = 1 << 0,
    SAILCOLLIDER_FLAG_2    = 1 << 1,
    SAILCOLLIDER_FLAG_4    = 1 << 2,
    SAILCOLLIDER_FLAG_8    = 1 << 3,
    SAILCOLLIDER_FLAG_10   = 1 << 4,
    SAILCOLLIDER_FLAG_20   = 1 << 5,
    SAILCOLLIDER_FLAG_40   = 1 << 6,
    SAILCOLLIDER_FLAG_80   = 1 << 7,
    SAILCOLLIDER_FLAG_100  = 1 << 8,
    SAILCOLLIDER_FLAG_200  = 1 << 9,
    SAILCOLLIDER_FLAG_400  = 1 << 10,
    SAILCOLLIDER_FLAG_800  = 1 << 11,
    SAILCOLLIDER_FLAG_1000 = 1 << 12,
    SAILCOLLIDER_FLAG_2000 = 1 << 13,
    SAILCOLLIDER_FLAG_4000 = 1 << 14,
    SAILCOLLIDER_FLAG_8000 = 1 << 15,
};
typedef u16 SailColliderFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct SailColliderHitCheckBox_
{
    VecFx32 position;
    VecFx32 offset;
    VecFx32 unknown;
    VecFx32 size;
    u16 angle;
    VecFx32 *origin;

    VecFx32 hitPosition;
} SailColliderHitCheckBox;

typedef struct SailColliderHitCheckLine_
{
    VecFx32 localStart;
    VecFx32 localEnd;
    VecFx32 start;
    VecFx32 end;
    u16 angle;
    VecFx32 *origin;

    s32 hitPosition;
    VecFx32 offset;
    s32 range;
    VecFx32 *lineOriginPos;
    VecFx32 direction;
    VecFx32 hitPos;
} SailColliderHitCheckLine;

typedef struct SailColliderWork_
{
    SailColliderWorkType type;
    union
    {
        SailColliderHitCheckBox box;
        SailColliderHitCheckLine line;
    } hitCheck;

    StageTask *stageTask;
    s32 atkPower;
    SailColliderFlags flags;
} SailColliderWork;

typedef struct SailObject_
{
    s32 shipType; // unused?
    VecFx32 collisionOffset;
    VecFx32 lookAtTo;
    VecFx32 field_1C;
    SailColliderWork collider[2];
    u32 score;
    s32 health;
    s32 maxHealth;
    fx32 explosionScale;
    s32 field_128;
    s16 field_12C;
    u16 blinkTimer;
    u16 invincibleTimer;
    fx32 voyageScrollSpeed;
    VecFx32 startEmissionColor;
    VecFx32 targetEmissionColor;
    s32 field_150;
    s32 field_154;
    StageTask *collidedObj;
    StageTask *player;
    StageTask *targetHUD;
    SailEventManagerObject *objectRef;
    void *healthBar;
    u16 segmentID;
    u16 objectAngle;
    VecFx32 voyagePosition;
    VecFx32 voyageVelocity;
    Vec2Fx16 lockOnPos;
    PaletteTexture paletteTex;
    u16 lightColor[3];
} SailObject;

// --------------------
// FUNCTIONS
// --------------------

void SailObject_InitCommon(StageTask *work);
void SailObject_InitFromMapObject(StageTask *work, SailEventManagerObject *mapObject);
void SailObject_SetAnimSpeed(StageTask *work, fx32 speed);
void SailObject_HandleParentFollow(StageTask *work);
void SailObject_ApplyRotation(StageTask *work);
void SailObject_SetSpriteColor(StageTask *work, GXRgb color);
void SailObject_In_Default(void);
void SailObject_Draw_Default(void);
GXRgb SailObject_ApplyFogBrightness(GXRgb color);
void SailObject_SetLightColors(StageTask *work, s32 a2);
void SailObject_Last_Default(void);
void SailObject_DoColliderUnknown(StageTask *work, SailColliderHitCheckBox *collider);
BOOL SailObject_ColliderCheckActive_Default(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
BOOL SailObject_CheckHitboxEnabled_Box(SailColliderHitCheckBox *collider1, SailColliderHitCheckBox *collider2, fx32 a3);
BOOL SailObject_CheckHitboxEnabled_Line(SailColliderHitCheckBox *collider1, SailColliderHitCheckLine *collider2, fx32 a3);
void SailObject_InitColliderForCommon(StageTask *work, SailColliderWork *sailCollider, s32 id);
void SailObject_InitColliderForObject(StageTask *work, s32 id);
void SailObject_InitColliderBox(StageTask *work, s32 id, fx32 size, VecFx32 *offset);
void SailObject_InitColliderLine(StageTask *work, s32 id, s32 range, VecFx32 *start, VecFx32 *end, VecFx32 *offset);
void SailObject_ShakeScreen(StageTask *work, s32 timer);
void SailObject_GetCollisionOffset(StageTask *work, VecFx32 *position);
void SailObject_SetCollisionOffset(StageTask *work, VecFx32 *position);

void SailObject_LookAtPlayer(StageTask *work);
void SailObject_LookAtPlayerY(StageTask *work);
void SailObject_HandleLookAt(StageTask *work);
void SailObject_LookAt(StageTask *work, VecFx32 *vecFrom, VecFx32 *vecTo);
void SailObject_HandleVoyageScroll(StageTask *work, VecFx32 *velocity);
void SailObject_HandleVoyageVelocity(StageTask *work);
void SailObject_Func_2166C04(StageTask *work, VecFx32 *position);
void SailObject_Oscillate(StageTask *work);
void SailIce_State_Oscillate(StageTask *work);
void SailObject_ProcessColliders(void);

void SailObject_Destructor(Task *task);
BOOL SailObject_ViewCheck_Default(StageTask *work);
void SailObject_OnDefend_Default(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SailObject_GivePlayerScore(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2, u32 score);
void SailObject_OnPlayerCollide(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // !RUSH_SAILCOMMONOBJECTS_H