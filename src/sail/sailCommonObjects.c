#include <sail/sailCommonObjects.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/graphics/screenShake.h>
#include <sail/sailAudio.h>
#include <game/math/unknown2066510.h>
#include <sail/sailPlayer.h>

// Objects
#include <sail/objects/sailIsland.h>
#include <sail/objects/sailMine.h>
#include <sail/objects/sailBomb.h>
#include <sail/objects/sailCloud.h>
#include <sail/objects/sailBuoy.h>
#include <sail/objects/sailSeagull.h>
#include <sail/objects/sailRock.h>
#include <sail/objects/sailIce.h>
#include <sail/objects/sailFish.h>
#include <sail/objects/sailGoal.h>
#include <sail/objects/sailItemBox.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED StageTask *EffectSailHit__Create(VecFx32 *position);
NOT_DECOMPILED StageTask *EffectCreateSailBomb(VecFx32 *position);
NOT_DECOMPILED StageTask *EffectUnknown2161544__Create(StageTask *parent, VecFx32 *position);
NOT_DECOMPILED StageTask *EffectSailWater06__Create(VecFx32 *position);
NOT_DECOMPILED StageTask *EffectSailGuard__Create(VecFx32 *position);
NOT_DECOMPILED StageTask *SailExplosionHazard__Create(VecFx32 *position);

// --------------------
// VARIABLES
// --------------------

static const s16 oscillateTable[] = { FLOAT_TO_FX32(0.03125),  FLOAT_TO_FX32(0.0625),  FLOAT_TO_FX32(0.03125),  FLOAT_TO_FX32(0.0078125),
                                      -FLOAT_TO_FX32(0.03125), -FLOAT_TO_FX32(0.0625), -FLOAT_TO_FX32(0.03125), -FLOAT_TO_FX32(0.0078125) };

NOT_DECOMPILED const char *aSbLandBac;
NOT_DECOMPILED const char *aSbMineBac_0;
NOT_DECOMPILED const char *aSbBomberBac;
NOT_DECOMPILED const char *aSbCloudBac_0;
NOT_DECOMPILED const char *aSbBuoyNsbmd_0;
NOT_DECOMPILED const char *aSbBuoyNsbca;
NOT_DECOMPILED const char *aSbSeagullBac;
NOT_DECOMPILED const char *aSbSeagullNsbmd_0;
NOT_DECOMPILED const char *aSbStoneNsbmd_0;

// --------------------
// FUNCTION DECLS
// --------------------

static void SailIsland_State_Other(StageTask *work);
static void SailIsland_Draw_Destination(void);
static void SailIsland_Draw_Other(void);

static void SailMine_State_Active(StageTask *work);

static void SailBomb_Action_Init(StageTask *work);
static void SailBomb_State_Active(StageTask *work);

static void SailFogCloud_State_Active(StageTask *work);
static void SailSkyCloud_State_Active(StageTask *work);

static void SailObject_Action_Destroy(StageTask *work);
static void SailObject_Action_ExplodeSimple(StageTask *work);
static void SailObject_State_ExplodeSimple(StageTask *work);
static void SailObject_Action_Explode(StageTask *work);
static void SailObject_CreateRingsForExplode1(StageTask *work);
static void SailObject_CreateRingsForExplode2(StageTask *work);
static void SailObject_State_Explode(StageTask *work);

static void SailBuoy_Action_Init(StageTask *work);
static void SailBuoy_State_Floating(StageTask *work);

static void SailUnusedSeagull_Action_Init(StageTask *work);
static void SailUnusedSeagull_State_Flying(StageTask *work);

static void SailSeagull_Action_Init(StageTask *work);
static void SailSeagull_State_Flying(StageTask *work);

static void SailIslandSeagull_Action_Init(StageTask *work);
static void SailIslandSeagull_State_Flying(StageTask *work);

static void SailFish_Action_Init(StageTask *work);
static void SailFish_State_Swimming(StageTask *work);

static void SailIslandFish_Action_Init(StageTask *work);
static void SailIslandFish_State_Swimming(StageTask *work);

static void SailGoalChaosEmerald_Action_Init(StageTask *work);
static void SailGoalChaosEmerald_State_Idle(StageTask *work);
static void SailGoalChaosEmerald_Action_Grab(StageTask *work);
static void SailGoalChaosEmerald_State_Grabbed(StageTask *work);

static void SailGoal_Action_Init(StageTask *work);
static void SailGoal_State_Active(StageTask *work);

static void SailGoalText_Action_Init(StageTask *work);
static void SailGoalText_State_Active(StageTask *work);

static void SailItemBox_GiveItem(StageTask *work, StageTask *object);
static void SailItemBoxRewardText_State_Active(StageTask *work);

// --------------------
// FUNCTIONS
// --------------------

void SailObject_InitCommon(StageTask *work)
{
    Animator3D *aniModel = NULL;

    if (work->obj_3d != NULL || work->obj_3des != NULL)
    {
        if (work->obj_3d != NULL)
            aniModel = &work->obj_3d->ani.work;
        else
            aniModel = &work->obj_3des->ani.work;

        aniModel->scale.x = FLOAT_TO_FX32(0.125);
        aniModel->scale.y = FLOAT_TO_FX32(0.125);
        aniModel->scale.z = FLOAT_TO_FX32(0.125);
        work->displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

        SetTaskOutFunc(work, SailObject_Draw_Default);
    }

    if (work->obj_2dIn3d != NULL)
    {
        work->scale.x = FLOAT_TO_FX32(0.03125);
        work->scale.y = FLOAT_TO_FX32(0.03125);
        work->scale.z = FLOAT_TO_FX32(0.03125);
        work->displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    }

    if ((work->userFlag & SAILOBJECT_FLAG_10000000) == 0)
    {
        switch (SailManager__GetShipType())
        {
            case SHIP_JET:
                if ((work->userFlag & SAILOBJECT_FLAG_40000000) != 0)
                {
                    fx32 scale        = MultiplyFX(FLOAT_TO_FX32(0.1796875), aniModel->scale.x);
                    aniModel->scale.x = scale;
                    aniModel->scale.y = scale;
                    aniModel->scale.z = scale;
                }
                break;

            case SHIP_BOAT:
                if ((work->userFlag & SAILOBJECT_FLAG_20000000) == 0 && (work->userFlag & SAILOBJECT_FLAG_40000000) == 0 && (work->userFlag & SAILOBJECT_FLAG_80000000) == 0)
                {
                    if (aniModel != NULL)
                    {
                        fx32 scale = MultiplyFX(FLOAT_TO_FX32(4.0), aniModel->scale.x);

                        aniModel->scale.x = scale;
                        aniModel->scale.y = scale;
                        aniModel->scale.z = scale;
                    }
                    else if (work->obj_2dIn3d != NULL)
                    {
                        fx32 scale = MultiplyFX(FLOAT_TO_FX32(4.0), work->scale.x);

                        work->scale.x = scale;
                        work->scale.y = scale;
                        work->scale.z = scale;
                    }
                }
                break;

            case SHIP_SUBMARINE:
                if ((work->userFlag & SAILOBJECT_FLAG_20000000) == 0 && (work->userFlag & SAILOBJECT_FLAG_40000000) == 0 && (work->userFlag & SAILOBJECT_FLAG_80000000) == 0)
                {
                    if (aniModel != NULL)
                    {
                        fx32 scale = MultiplyFX(FLOAT_TO_FX32(4.0), aniModel->scale.x);

                        aniModel->scale.x = scale;
                        aniModel->scale.y = scale;
                        aniModel->scale.z = scale;
                    }
                    else if (work->obj_2dIn3d != NULL)
                    {
                        fx32 scale = MultiplyFX(FLOAT_TO_FX32(4.0), work->scale.x);

                        work->scale.x = scale;
                        work->scale.y = scale;
                        work->scale.z = scale;
                    }
                }
                break;

            case SHIP_HOVER:
                if ((work->userFlag & SAILOBJECT_FLAG_40000000) != 0)
                {
                    fx32 scale        = MultiplyFX(FLOAT_TO_FX32(0.1796875), aniModel->scale.x);
                    aniModel->scale.x = scale;
                    aniModel->scale.y = scale;
                    aniModel->scale.z = scale;
                }
                break;
        }
    }

    SailObject_SetAnimSpeed(work, FLOAT_TO_FX32(1.0));

    SetTaskInFunc(work, SailObject_In_Default);

    if (work->objType == SAILSTAGE_OBJ_TYPE_OBJECT)
        SetTaskLastFunc(work, SailObject_Last_Default);

    if (work->objType == SAILSTAGE_OBJ_TYPE_OBJECT)
    {
        SailObject *worker     = GetStageTaskWorker(work, SailObject);
        worker->player         = SailManager__GetWork()->sailPlayer;
        worker->explosionScale = FLOAT_TO_FX32(1.0);

        SetTaskViewCheckFunc(work, SailObject_ViewCheck_Default);
        work->flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        work->userFlag |= SAILOBJECT_FLAG_40;
        SetTaskDestructorEvent(work->taskRef, SailObject_Destructor);
    }

    SailObject_SetLightColors(work, 0);

    work->flag |= STAGE_TASK_FLAG_DISABLE_SHAKE;
}

void SailObject_InitFromMapObject(StageTask *work, SailEventManagerObject *mapObject)
{
    SailObject *worker               = GetStageTaskWorker(work, SailObject);
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (mapObject != NULL)
    {
        work->position    = mapObject->position;
        worker->objectRef = NULL;

        if ((mapObject->flags & SAILMAPOBJECT_FLAG_20000000) == 0)
        {
            mapObject->objTask     = work;
            worker->voyagePosition = mapObject->voyagePosition;
            worker->segmentID      = mapObject->segmentID;
            worker->objectAngle    = mapObject->angle;

            s32 segmentPos = FX_Div(worker->voyagePosition.z & 0x7FFFF, SailVoyageManager__GetSegmentSize(&voyageManager->segmentList[mapObject->segmentID]));
            SailVoyageManager__Func_2158888(&voyageManager->segmentList[mapObject->segmentID], segmentPos, &worker->field_1C.x, &worker->field_1C.z);
            worker->objectRef = mapObject;
        }
    }
}

void SailObject_SetAnimSpeed(StageTask *work, fx32 speed)
{
    if (work->obj_3d != NULL)
    {
        work->obj_3d->ani.speedMultiplier = MultiplyFX(speed, FLOAT_TO_FX32(2.0));
    }

    if (work->obj_2d != NULL)
    {
        work->obj_2d->ani.work.animAdvance = MultiplyFX(speed, FLOAT_TO_FX32(2.0));
    }

    if (work->obj_2dIn3d != NULL)
    {
        work->obj_2dIn3d->ani.animatorSprite.animAdvance = MultiplyFX(speed, FLOAT_TO_FX32(2.0));
    }
}

void SailObject_HandleParentFollow(StageTask *work)
{
    StageTask *parent = work->parentObj;

    work->dir.y = parent->dir.y;

    VecFx32 offset;
    FXMatrix33 mtx;
    MTX_RotY33(mtx.nnMtx, SinFX(work->dir.y), CosFX(work->dir.y));
    MTX_MultVec33(&work->parentOffset, mtx.nnMtx, &offset);

    work->position.x = parent->position.x + offset.x;
    work->position.y = parent->position.y + offset.y;
    work->position.z = parent->position.z + offset.z;

    work->displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    work->displayFlag |= parent->displayFlag & DISPLAY_FLAG_DISABLE_DRAW;
}

void SailObject_ApplyRotation(StageTask *work)
{
    Animator3D *animator;

    if (work->obj_3d != NULL)
    {
        animator = &work->obj_3d->ani.work;
    }
    else if (work->obj_3des != NULL)
    {
        animator = &work->obj_3des->ani.work;
    }
    else if (work->obj_2dIn3d != NULL)
    {
        animator = &work->obj_2dIn3d->ani.work;
    }
    else
    {
        return;
    }

    FXMatrix33 mtx;
    MTX_Identity33(animator->rotation.nnMtx);

    if (work->dir.x != FLOAT_DEG_TO_IDX(0.0))
    {
        MTX_RotX33(mtx.nnMtx, SinFX((s32)work->dir.x), CosFX((s32)work->dir.x));
        MTX_Concat33(animator->rotation.nnMtx, mtx.nnMtx, animator->rotation.nnMtx);
    }

    if (work->dir.z != FLOAT_DEG_TO_IDX(0.0))
    {
        MTX_RotZ33(mtx.nnMtx, SinFX((s32)work->dir.z), CosFX((s32)work->dir.z));
        MTX_Concat33(animator->rotation.nnMtx, mtx.nnMtx, animator->rotation.nnMtx);
    }

    if (work->dir.y != FLOAT_DEG_TO_IDX(0.0))
    {
        MTX_RotY33(mtx.nnMtx, SinFX((s32)work->dir.y), CosFX((s32)work->dir.y));
        MTX_Concat33(animator->rotation.nnMtx, mtx.nnMtx, animator->rotation.nnMtx);
    }
}

void SailObject_SetSpriteColor(StageTask *work, GXRgb color)
{
    if (work->obj_2dIn3d != NULL)
        work->obj_2dIn3d->ani.color = color;
}

void SailObject_In_Default(void)
{
    StageTask *work = TaskGetWorkCurrent(StageTask);

    if ((work->userFlag & SAILOBJECT_FLAG_1) == 0)
    {
        VEC_Subtract(&work->position, SailVoyageManager__GetVoyageVelocity(), &work->position);
    }

    if ((work->flag & STAGE_TASK_FLAG_DISABLE_SHAKE) != 0)
        SailObject_ShakeScreen(work, FX32_TO_WHOLE(work->shakeTimer));

    if ((work->userFlag & SAILOBJECT_FLAG_40) != 0)
    {
        SailObject *worker = GetStageTaskWorker(work, SailObject);
        if (worker == NULL)
            return;

        if (worker->player != NULL && IsStageTaskDestroyed(worker->player))
            worker->player = NULL;

        if (worker->collidedObj != NULL && IsStageTaskDestroyed(worker->collidedObj))
            worker->collidedObj = NULL;

        if (worker->targetHUD != NULL && IsStageTaskDestroyed(worker->targetHUD))
            worker->targetHUD = NULL;
    }

    if (work->objType == SAILSTAGE_OBJ_TYPE_OBJECT)
    {
        SailManager *manager             = SailManager__GetWork();
        SailObject *worker               = GetStageTaskWorker(work, SailObject);
        SailVoyageManager *voyageManager = manager->voyageManager;

        if (worker == NULL)
            return;

        worker->voyagePosition.z += voyageManager->field_74;

        // in the submarine, distant objects should appear darker than closer ones.
        if (SailManager__GetShipType() == SHIP_SUBMARINE)
        {
            fx32 x   = MATH_ABS(work->position.x);
            fx32 z   = MATH_ABS(work->position.z);
            fx32 pos = MT_MATH_MAX(x, z);

            fx32 distance = FLOAT_TO_FX32(1.0);
            if (pos > FLOAT_TO_FX32(96.0))
            {
                distance = FLOAT_TO_FX32(0.0);
            }
            else if (pos > FLOAT_TO_FX32(80.0))
            {
                distance = (FLOAT_TO_FX32(16.0) - (u32)(pos - FLOAT_TO_FX32(80.0)));
                distance >>= 4;
            }

            if (distance < FLOAT_TO_FX32(0.3125))
                distance = FLOAT_TO_FX32(0.3125);

            if (work->obj_3d != NULL)
            {
                u16 color1 = MultiplyFX(GX_COLOR_FROM_888(0xF8), distance);
                u16 color2 = MultiplyFX(GX_COLOR_FROM_888(0x88), distance);
                u16 color3 = MultiplyFX(GX_COLOR_FROM_888(0x40), distance);

                worker->lightColor[0] = GX_RGB(color1, color1, color1);
                worker->lightColor[1] = GX_RGB(color2, color2, color2);
                worker->lightColor[2] = GX_RGB(color3, color3, color3);
            }
        }
    }
}

void SailObject_Draw_Default(void)
{
    StageTask *work    = TaskGetWorkCurrent(StageTask);
    SailObject *object = GetStageTaskWorker(work, SailObject);

    switch (work->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER: {
            SailPlayer *player = (SailPlayer *)object;

            NNS_G3dGlbLightColor(GX_LIGHTID_0, SailObject_ApplyFogBrightness(player->lightColor[0]));
            NNS_G3dGlbLightColor(GX_LIGHTID_1, SailObject_ApplyFogBrightness(player->lightColor[1]));
            NNS_G3dGlbLightColor(GX_LIGHTID_2, SailObject_ApplyFogBrightness(player->lightColor[2]));
        }
        break;

        case SAILSTAGE_OBJ_TYPE_OBJECT:
            NNS_G3dGlbLightColor(GX_LIGHTID_0, SailObject_ApplyFogBrightness(object->lightColor[0]));
            NNS_G3dGlbLightColor(GX_LIGHTID_1, SailObject_ApplyFogBrightness(object->lightColor[1]));
            NNS_G3dGlbLightColor(GX_LIGHTID_2, SailObject_ApplyFogBrightness(object->lightColor[2]));
            break;

        case SAILSTAGE_OBJ_TYPE_EFFECT:
            if ((work->userFlag & SAILOBJECT_FLAG_400000) == 0)
                break;

            NNS_G3dGlbLightColor(GX_LIGHTID_0, SailObject_ApplyFogBrightness(object->lightColor[0]));
            NNS_G3dGlbLightColor(GX_LIGHTID_1, SailObject_ApplyFogBrightness(object->lightColor[1]));
            NNS_G3dGlbLightColor(GX_LIGHTID_2, SailObject_ApplyFogBrightness(object->lightColor[2]));
            break;
    }

    StageTask__Draw(work);
}

GXRgb SailObject_ApplyFogBrightness(GXRgb color)
{
    SailManager *manager = SailManager__GetWork();

    s32 r = MultiplyFX((color >> GX_RGB_R_SHIFT) & 0x1F, manager->skyBrightness.x);
    s32 g = MultiplyFX((color >> GX_RGB_G_SHIFT) & 0x1F, manager->skyBrightness.y);
    s32 b = MultiplyFX((color >> GX_RGB_B_SHIFT) & 0x1F, manager->skyBrightness.z);

    return GX_RGB(r, g, b);
}

void SailObject_SetLightColors(StageTask *work, s32 type)
{
    GXRgb *lightColor0;
    GXRgb *lightColor1;
    GXRgb *lightColor2;

    SailObject *object = GetStageTaskWorker(work, SailObject);

    switch (work->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER: {
            SailPlayer *player = (SailPlayer *)object;
            lightColor0        = &player->lightColor[0];
            lightColor1        = &player->lightColor[1];
            lightColor2        = &player->lightColor[2];
        }
        break;

        case SAILSTAGE_OBJ_TYPE_EFFECT:
            if ((work->userFlag & SAILOBJECT_FLAG_400000) == 0)
                return;

        case SAILSTAGE_OBJ_TYPE_OBJECT:

            lightColor0 = &object->lightColor[0];
            lightColor1 = &object->lightColor[1];
            lightColor2 = &object->lightColor[2];

            if ((work->userFlag & SAILOBJECT_FLAG_8000) != 0 && type == 0)
                type = 5;
            break;

        default:
            return;
    }

    switch (type)
    {
        default:
            *lightColor0 = GX_RGB_888(0xF8, 0xF8, 0xF8);
            *lightColor1 = GX_RGB_888(0x88, 0x88, 0x88);
            *lightColor2 = GX_RGB_888(0x40, 0x40, 0x40);
            break;

        case 1:
            *lightColor0 = GX_RGB_888(0xF8, 0x00, 0x00);
            *lightColor1 = GX_RGB_888(0xF8, 0x00, 0x00);
            *lightColor2 = GX_RGB_888(0xF8, 0x00, 0x00);
            break;

        case 2:
            *lightColor0 = GX_RGB_888(0x00, 0x00, 0xF8);
            *lightColor1 = GX_RGB_888(0x00, 0x00, 0xF8);
            *lightColor2 = GX_RGB_888(0x00, 0x00, 0xF8);
            break;

        case 3:
            *lightColor0 = GX_RGB_888(0xF8, 0xF8, 0x00);
            *lightColor1 = GX_RGB_888(0xF8, 0xF8, 0x00);
            *lightColor2 = GX_RGB_888(0xF8, 0xF8, 0x00);
            break;

        case 4:
            *lightColor0 = GX_RGB_888(0x20, 0x20, 0x20);
            *lightColor1 = GX_RGB_888(0x20, 0x20, 0x20);
            *lightColor2 = GX_RGB_888(0x20, 0x20, 0x20);
            break;

        case 5:
            *lightColor0 = GX_RGB_888(0x50, 0x50, 0xF8);
            *lightColor1 = GX_RGB_888(0x30, 0x30, 0x88);
            *lightColor2 = GX_RGB_888(0x10, 0x10, 0x40);
            break;
    }
}

void SailObject_Last_Default(void)
{
    StageTask *work    = TaskGetWorkCurrent(StageTask);
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    if (worker->invincibleTimer != 0)
        worker->invincibleTimer--;

    if (worker->blinkTimer != 0)
    {
        worker->blinkTimer--;
        if ((worker->blinkTimer & 2) != 0)
            SailObject_SetLightColors(work, 1);
        else
            SailObject_SetLightColors(work, 0);
    }

    worker->collidedObj = NULL;
}

void SailObject_DoColliderUnknown(StageTask *work, SailColliderHitCheckBox *collider)
{
    UNUSED(work);
    UNUSED(collider);

    // Does..... nothing?
}

BOOL SailObject_ColliderCheckActive_Default(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SailColliderWork *collider1;
    SailColliderWork *collider2;

    SailColliderHitCheckBox *hitCheck1_box   = NULL;
    SailColliderHitCheckBox *hitCheck2_box   = NULL;
    SailColliderHitCheckLine *hitCheck1_line = NULL;
    SailColliderHitCheckLine *hitCheck2_line = NULL;

    collider1 = rect1->userData;
    collider2 = rect2->userData;

    s32 type = collider1->type;

    switch (collider1->type)
    {
        case SAILCOLLIDER_TYPE_BOX:
            hitCheck1_box = &collider1->hitCheck.box;
            break;

        case SAILCOLLIDER_TYPE_LINE:
            hitCheck1_line = &collider1->hitCheck.line;
            break;

        default:
            return FALSE;
    }

    switch (collider2->type)
    {
        case SAILCOLLIDER_TYPE_BOX:
            hitCheck2_box = &collider2->hitCheck.box;
            break;

        case SAILCOLLIDER_TYPE_LINE:
            hitCheck2_line = &collider2->hitCheck.line;
            break;

        default:
            return FALSE;
    }

    if (hitCheck1_box != NULL && hitCheck2_box != NULL)
        return SailObject_CheckHitboxEnabled_Box(hitCheck1_box, hitCheck2_box, type);

    if (hitCheck1_box != NULL && hitCheck2_line != NULL)
        return SailObject_CheckHitboxEnabled_Line(hitCheck1_box, hitCheck2_line, type);

    if (hitCheck2_box != NULL && hitCheck1_line != NULL)
        return SailObject_CheckHitboxEnabled_Line(hitCheck2_box, hitCheck1_line, type);

    // ???
    BOOL value = FALSE;
    if (hitCheck1_line != NULL)
    {
        value = FALSE;
    }

    return value;
}

BOOL SailObject_CheckHitboxEnabled_Box(SailColliderHitCheckBox *collider1, SailColliderHitCheckBox *collider2, fx32 a3)
{
    fx32 distanceX;
    fx32 distanceZ;

    distanceZ = (collider1->position.z - collider2->position.z);
    distanceX = (collider1->position.x - collider2->position.x);

    if (distanceX < 0)
        distanceX = -distanceX;
    if (distanceZ < 0)
        distanceZ = -distanceZ;

    fx32 value;
    if (distanceX > distanceZ)
    {
        value = MultiplyFX(FLOAT_TO_FX32(0.96045), distanceX);
        value += MultiplyFX(FLOAT_TO_FX32(0.397706), distanceZ);
    }
    else
    {
        value = MultiplyFX(FLOAT_TO_FX32(0.96045), distanceZ);
        value += MultiplyFX(FLOAT_TO_FX32(0.397706), distanceX);
    }

    if (value > FLOAT_TO_FX32(256.0))
        return FALSE;

    VecFx32 dest;
    VEC_Subtract(&collider1->position, &collider2->position, &dest);
    fx32 dot = VEC_DotProduct(&dest, &dest);

    fx32 sizeX2 = collider2->size.x;
    fx32 sizeX1 = collider1->size.x;

    if ((dot - MultiplyFX(sizeX1 + sizeX2, sizeX1 + sizeX2)) > 0)
        return FALSE;

    if (collider1->size.y != 0 || collider2->size.y != 0)
    {
        s32 sizeY1 = collider1->size.y;
        s32 sizeY2 = collider2->size.y;

        s32 distanceY = collider1->position.y - collider2->position.y;

        if (sizeY1 == 0)
            sizeY1 = collider1->size.x;

        if (sizeY2 != 0)
            sizeY1 += sizeY2;
        else
            sizeY1 += sizeX2;

        s32 value2 = MultiplyFX(distanceY, distanceY) - MultiplyFX(sizeY1, sizeY1);
        if (value2 > 0)
            return FALSE;
    }

    if (collider1->size.z != 0 || collider2->size.z != 0)
    {
        u16 angle = FX_Atan2Idx(collider2->position.x - collider1->position.x, collider2->position.z - collider1->position.z);

        if (collider1->size.z != 0)
        {
            sizeX1 -= MATH_ABS(MultiplyFX(sizeX1 - collider1->size.z, SinFX((s32)(u16)(angle - collider1->angle))));
        }

        if (collider2->size.z != 0)
        {
            sizeX2 -= MATH_ABS(MultiplyFX(sizeX2 - collider2->size.z, SinFX((s32)(u16)(angle - collider2->angle))));
        }

        if (dot - MultiplyFX(sizeX1 + sizeX2, sizeX1 + sizeX2) > 0)
            return FALSE;
    }

    VEC_Add(&collider1->position, &collider2->position, &collider1->hitPosition);
    collider1->hitPosition.x >>= 1;
    collider1->hitPosition.y >>= 1;
    collider1->hitPosition.z >>= 1;
    collider1->hitPosition.y = -collider1->hitPosition.y;

    collider2->hitPosition = collider1->hitPosition;

    return TRUE;
}

BOOL SailObject_CheckHitboxEnabled_Line(SailColliderHitCheckBox *collider1, SailColliderHitCheckLine *collider2, fx32 a3)
{
    s32 range = collider1->size.x + collider2->range;

    VecFx32 line;
    VecFx32 localLine;
    VEC_Subtract(&collider2->localEnd, &collider2->localStart, &line);
    VEC_Subtract(&collider1->position, &collider2->localStart, &localLine);

    s32 dot1 = VEC_DotProduct(&localLine, &line);
    if (dot1 < 0)
        return 0;

    s32 dot2 = VEC_DotProduct(&line, &line);
    if (dot1 > dot2)
        return 0;

    fx32 step = FX_Div(dot1, dot2);
    VecFx32 hitPos;
    hitPos.x = localLine.x - MultiplyFX(step, line.x);
    hitPos.y = localLine.y - MultiplyFX(step, line.y);
    hitPos.z = localLine.z - MultiplyFX(step, line.z);

    if (VEC_DotProduct(&hitPos, &hitPos) > MultiplyFX(range, range))
        return FALSE;

    VEC_Subtract(&collider1->position, &hitPos, &collider2->hitPos);
    collider2->hitPos.y    = -collider2->hitPos.y;
    collider1->hitPosition = collider2->hitPos;

    return TRUE;
}

void SailObject_InitColliderForCommon(StageTask *work, SailColliderWork *sailCollider, s32 id)
{
    StageTask__InitCollider(work, NULL, id, STAGE_TASK_COLLIDER_FLAGS_NONE);

    OBS_RECT_WORK *collider = StageTask__GetCollider(work, id);
    collider->onDefend      = NULL;
    collider->flag          = OBS_RECT_WORK_FLAG_CHECK_FUNC | OBS_RECT_WORK_FLAG_ENABLED;
    collider->userData      = sailCollider;
    ObjRect__SetCheckActive(collider, SailObject_ColliderCheckActive_Default);

    switch (id)
    {
        case 0:
        case 3:
        default:
            collider->hitPower = OBS_RECT_HITPOWER_VULNERABLE;
            collider->defPower = 10;
            collider->hitFlag |= OBS_RECT_WORK_ATTR_BODY;
            collider->hitFlag &= ~OBS_RECT_WORK_ATTR_NORMAL;
            collider->defFlag &= ~OBS_RECT_WORK_ATTR_BODY;
            break;

        case 1:
        case 2:
            collider->hitPower = 10;
            collider->defPower = 100;
            break;
    }

    switch (work->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER:
        case SAILSTAGE_OBJ_TYPE_EFFECT:
            // Does not match with the macro, has to be manually written out.
            // ObjRect__SetGroupFlags(collider, 1, 2);
            collider->groupFlags = 1;
            collider->groupFlags |= 2 << 8;
            collider->flag |= OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;
            break;

        case SAILSTAGE_OBJ_TYPE_OBJECT:
        default:
            ObjRect__SetGroupFlags(collider, 2, 1);
            sailCollider->atkPower = FLOAT_TO_FX32(64.0);

            if (id == 0 || id == 3)
            {
                collider->hitPower = 10;
                collider->defPower = 5;
                ObjRect__SetOnDefend(collider, SailObject_OnDefend_Default);
                collider->flag |= OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;
            }
            break;
    }

    sailCollider->stageTask = work;
}

void SailObject_InitColliderForObject(StageTask *work, s32 id)
{
    if (work->objType == SAILSTAGE_OBJ_TYPE_OBJECT)
    {
        OBS_RECT_WORK *collider = StageTask__GetCollider(work, id);
        collider->groupFlags |= 2 << 8;
        collider->hitPower = 8;
    }
}

void SailObject_InitColliderBox(StageTask *work, s32 id, fx32 size, VecFx32 *offset)
{
    OBS_RECT_WORK *obsCollider = StageTask__GetCollider(work, id);

    SailColliderWork *collider = obsCollider->userData;
    collider->type             = SAILCOLLIDER_TYPE_BOX;

    collider->hitCheck.box.position = work->position;

    collider->hitCheck.box.size.x = size;
    collider->hitCheck.box.origin = &work->position;

    if (offset != NULL)
    {
        collider->hitCheck.box.offset = *offset;
    }

    VecFx32 position;
    SailObject_GetCollisionOffset(work, &position);
    collider->hitCheck.box.offset.x += position.x;
    collider->hitCheck.box.offset.y -= position.y;
    collider->hitCheck.box.offset.z += position.z;
}

void SailObject_InitColliderLine(StageTask *work, s32 id, s32 range, VecFx32 *start, VecFx32 *end, VecFx32 *offset)
{
    OBS_RECT_WORK *obsCollider = StageTask__GetCollider(work, id);

    SailColliderWork *collider = obsCollider->userData;
    collider->type             = SAILCOLLIDER_TYPE_LINE;

    collider->hitCheck.line.start = *start;
    collider->hitCheck.line.end   = *end;

    collider->hitCheck.line.range = range;

    VEC_Subtract(end, start, &collider->hitCheck.line.direction);
    VEC_Normalize(&collider->hitCheck.line.direction, &collider->hitCheck.line.direction);
    collider->hitCheck.line.lineOriginPos = &work->position;

    if (offset != NULL)
    {
        collider->hitCheck.line.offset = *offset;
    }

    VecFx32 position;
    SailObject_GetCollisionOffset(work, &position);
    collider->hitCheck.line.offset.x += position.x;
    collider->hitCheck.line.offset.y -= position.y;
    collider->hitCheck.line.offset.z += position.z;
}

void SailObject_ShakeScreen(StageTask *work, s32 timer)
{
    u16 shipType = SailManager__GetShipType();

    if (timer != 0)
    {
        fx32 shakeX = FX32_FROM_WHOLE(StageTask__shakeOffsetTable[timer & 0xF]);
        fx32 shakeY = FX32_FROM_WHOLE(StageTask__shakeOffsetTable[(timer + 1) & 0xF]);

        work->offset.x += shakeX >> shipShiftUnknown[shipType];
        work->offset.y += shakeY >> shipShiftUnknown[shipType];
        if ((work->flag & STAGE_TASK_FLAG_UNKNOWN) == 0)
            work->offset.z += shakeX >> shipShiftUnknown[shipType];
    }
}

void SailObject_GetCollisionOffset(StageTask *work, VecFx32 *position)
{
    switch (work->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER: {
            SailPlayer *player = GetStageTaskWorker(work, SailPlayer);

            *position = player->collisionOffset;
        }
        break;

        case SAILSTAGE_OBJ_TYPE_OBJECT: {
            SailObject *object = GetStageTaskWorker(work, SailObject);

            *position = object->collisionOffset;
        }
        break;

        // case SAILSTAGE_OBJ_TYPE_EFFECT:
        default:
            position->x = 0;
            position->y = 0;
            position->z = 0;
            break;
    }
}

void SailObject_SetCollisionOffset(StageTask *work, VecFx32 *position)
{
    switch (work->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER: {
            SailPlayer *player = GetStageTaskWorker(work, SailPlayer);

            player->collisionOffset = *position;
        }
        break;

        case SAILSTAGE_OBJ_TYPE_OBJECT: {
            SailObject *object = GetStageTaskWorker(work, SailObject);

            object->collisionOffset = *position;
        }
        break;
    }
}

NONMATCH_FUNC StageTask *CreateSailIsland(SailEventManagerObject *mapObject)
{
    // should match when 'aSbLandBac' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    SailManager *manager = SailManager__GetWork();

    work = CreateStageTaskSimpleEx(TASK_PRIORITY_UPDATE_LIST_START + 0xB10, TASK_GROUP(1));
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    ObjObjectAction3dBACLoad(work, NULL, "/sb_land.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_18), SailManager__GetArchive());
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);

    work->userTimer                             = mapObject->param;
    work->obj_2dIn3d->ani.polygonAttr.polygonID = 48;
    work->obj_2dIn3d->ani.polygonAttr.enableFog = FALSE;
    work->obj_2dIn3d->ani.work.matrixOpIDs[0]   = MATRIX_OP_SET_CAMERA_ROT_33;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1]   = MATRIX_OP_FLUSH_P_CAMERA3D;

    if (SailManager__GetShipType() == SHIP_SUBMARINE)
        work->position.y = -FLOAT_TO_FX32(2.0);
    else
        work->position.y = -FLOAT_TO_FX32(0.40625);

    if (work->userTimer != manager->targetIslandID)
    {
        // this island is NOT the destination.

        SetTaskState(work, SailIsland_State_Other);
        SetTaskOutFunc(work, SailIsland_Draw_Other);

        work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        if (SailManager__GetShipType() == SHIP_BOAT)
            work->position.y = -FLOAT_TO_FX32(0.125);
    }
    else
    {
        // this island _is_ NOT the destination.

        SetTaskOutFunc(work, SailIsland_Draw_Destination);

        if (SailManager__GetShipType() == SHIP_SUBMARINE)
            CreateSailFishForDestination(work);
        else
            CreateSailSeagullForDestination(work);
    }

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	bl SailManager__GetWork
	mov r5, r0
	mov r0, #0xb10
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r0, #0x12
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, =0x0000FFFF
	ldr r2, =aSbLandBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	bl SailObject_InitCommon
	mov r0, r4
	mov r1, r7
	bl SailObject_InitFromMapObject
	ldr r0, [r7, #0x38]
	mov r2, #0x1d
	str r0, [r4, #0x2c]
	ldr r3, [r4, #0x134]
	mov r1, #7
	ldr r0, [r3, #0xf4]
	bic r0, r0, #0x3f000000
	orr r0, r0, #0x30000000
	str r0, [r3, #0xf4]
	ldr r3, [r4, #0x134]
	ldr r0, [r3, #0xf4]
	bic r0, r0, #0x8000
	str r0, [r3, #0xf4]
	ldr r0, [r4, #0x134]
	strb r2, [r0, #0xa]
	ldr r0, [r4, #0x134]
	strb r1, [r0, #0xb]
	bl SailManager__GetShipType
	cmp r0, #3
	moveq r0, #0x2000
	movne r0, #0x680
	rsb r0, r0, #0
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x2c]
	ldr r0, [r5, #4]
	cmp r1, r0
	beq _02165C50
	ldr r1, =SailIsland_State_Other
	ldr r0, =SailIsland_Draw_Other
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	bl SailManager__GetShipType
	cmp r0, #1
	bne _02165C74
	mov r0, #0x200
	rsb r0, r0, #0
	str r0, [r4, #0x48]
	b _02165C74
_02165C50:
	ldr r0, =SailIsland_Draw_Destination
	str r0, [r4, #0xfc]
	bl SailManager__GetShipType
	cmp r0, #3
	mov r0, r4
	bne _02165C70
	bl CreateSailFishForDestination
	b _02165C74
_02165C70:
	bl CreateSailSeagullForDestination
_02165C74:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageTask *CreateSailMine(SailEventManagerObject *mapObject)
{
    // should match when 'aSbMineBac_0' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    SailManager *manager = SailManager__GetWork();

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjObjectAction3dBACLoad(work, 0, "sb_mine.bac", OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectDataWork(OBJDATAWORK_2), SailManager__GetArchive());
    ObjObjectActionAllocTexture(work, OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectTextureRef(OBJDATAWORK_54));
    work->obj_2dIn3d->ani.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);

    work->position.y -= FLOAT_TO_FX32(1.0);
    worker->score = 300;

    if (SailManager__GetShipType() == SHIP_HOVER)
    {
        worker->maxHealth = FLOAT_TO_FX32(1.5);
        worker->health    = FLOAT_TO_FX32(1.5);
    }
    work->obj_2dIn3d->ani.polygonAttr.enableFog = FALSE;
    work->obj_2dIn3d->ani.work.matrixOpIDs[0]   = MATRIX_OP_SET_CAMERA_ROT_43;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1]   = MATRIX_OP_FLUSH_P_CAMERA3D;

    work->userFlag |= SAILOBJECT_FLAG_40000 | SAILOBJECT_FLAG_2;
    worker->explosionScale = FLOAT_TO_FX32(0.75);
    SailObject_InitColliderForCommon(work, &worker->collider[0], 0);
    SailObject_InitColliderBox(work, 0, 0x600, 0);

    if ((manager->flags & SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER) != 0)
        worker->collider[0].atkPower >>= 1;

    if (SailManager__GetShipType() == SHIP_HOVER)
        worker->collider[0].hitCheck.box.size.x = FLOAT_TO_FX32(0.5625);

    if (SailManager__GetShipType() == SHIP_BOAT)
    {
        worker->collider[0].hitCheck.box.size.x = FLOAT_TO_FX32(2.0);
        work->userFlag |= SAILOBJECT_FLAG_20000;
    }

    StageTask__InitSeqPlayer(work);

    SetTaskState(work, SailMine_State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r7, r0
	bl SailManager__GetWork
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #2
	bl GetObjectFileWork
	mov r8, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r8}
	str r0, [sp, #8]
	ldr r2, =aSbMineBac_0
	mov r0, r4
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x36
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r2, [r4, #0x134]
	mov r0, r4
	ldr r1, [r2, #0xcc]
	orr r1, r1, #0x18
	str r1, [r2, #0xcc]
	bl SailObject_InitCommon
	mov r1, r7
	mov r0, r4
	bl SailObject_InitFromMapObject
	ldr r1, [r4, #0x48]
	mov r0, #0x12c
	sub r1, r1, #0x1000
	str r1, [r4, #0x48]
	str r0, [r5, #0x118]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x1800
	streq r0, [r5, #0x120]
	streq r0, [r5, #0x11c]
	ldr r1, [r4, #0x134]
	mov r2, #0x1c
	ldr r0, [r1, #0xf4]
	mov r3, #7
	bic r0, r0, #0x8000
	str r0, [r1, #0xf4]
	ldr r1, [r4, #0x134]
	mov r0, r4
	strb r2, [r1, #0xa]
	ldr r2, [r4, #0x134]
	add r1, r5, #0x28
	strb r3, [r2, #0xb]
	ldr r2, [r4, #0x24]
	mov r3, #0xc00
	orr r2, r2, #2
	orr r2, r2, #0x40000
	str r2, [r4, #0x24]
	mov r2, #0
	str r3, [r5, #0x124]
	bl SailObject_InitColliderForCommon
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x600
	bl SailObject_InitColliderBox
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldrne r0, [r5, #0x98]
	movne r0, r0, asr #1
	strne r0, [r5, #0x98]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x900
	streq r0, [r5, #0x50]
	bl SailManager__GetShipType
	cmp r0, #1
	bne _02165E04
	mov r0, #0x2000
	str r0, [r5, #0x50]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x20000
	str r0, [r4, #0x24]
_02165E04:
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldr r1, =SailMine_State_Active
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageTask *CreateSailBomb(SailEventManagerObject *mapObject)
{
    // should match when 'aSbBomberBac' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjObjectAction3dBACLoad(work, NULL, "sb_bomber.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_103), SailManager__GetArchive());
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);
    work->position.y -= FLOAT_TO_FX32(1.0);
    if (SailManager__GetShipType() == SHIP_HOVER)
    {
        worker->maxHealth = FLOAT_TO_FX32(1.5);
        worker->health    = FLOAT_TO_FX32(1.5);
    }
    worker->score                               = 300;
    work->obj_2dIn3d->ani.polygonAttr.enableFog = FALSE;
    work->obj_2dIn3d->ani.work.matrixOpIDs[0]   = MATRIX_OP_SET_CAMERA_ROT_43;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1]   = MATRIX_OP_FLUSH_P_CAMERA3D;
    work->userFlag |= SAILOBJECT_FLAG_2;

    SailObject_InitColliderForCommon(work, &worker->collider[0], 0);
    SailObject_InitColliderBox(work, 0, 0x600, 0);

    StageTask__InitSeqPlayer(work);
    SailBomb_Action_Init(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x67
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, =0x0000FFFF
	ldr r2, =aSbBomberBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	bl SailObject_InitCommon
	mov r1, r7
	mov r0, r4
	bl SailObject_InitFromMapObject
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x1000
	str r0, [r4, #0x48]
	bl SailManager__GetShipType
	cmp r0, #2
	moveq r0, #0x1800
	streq r0, [r5, #0x120]
	streq r0, [r5, #0x11c]
	mov r0, #0x12c
	str r0, [r5, #0x118]
	ldr r1, [r4, #0x134]
	mov r2, #0x1c
	ldr r0, [r1, #0xf4]
	mov r3, #7
	bic r0, r0, #0x8000
	str r0, [r1, #0xf4]
	ldr r1, [r4, #0x134]
	mov r0, r4
	strb r2, [r1, #0xa]
	ldr r2, [r4, #0x134]
	add r1, r5, #0x28
	strb r3, [r2, #0xb]
	ldr r3, [r4, #0x24]
	mov r2, #0
	orr r3, r3, #2
	str r3, [r4, #0x24]
	bl SailObject_InitColliderForCommon
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x600
	bl SailObject_InitColliderBox
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailBomb_Action_Init
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CreateSailFogCloudsForVoyage(void)
{
    // https://decomp.me/scratch/ARkA2 -> 84.07%
#ifdef NON_MATCHING
    VecFx32 position;
    SailEventManagerObject object = { 0 };

    object.type = SAILMAPOBJECT_37;

    for (u16 i = 0; i < 16; i++)
    {
        object.viewRange = -0x4F000 - ObjDispRandRepeat(0x20000);
        s32 angle        = (ObjDispRandRepeat(0x8000) + 0x800);
        object.angle     = angle;

        position.x = MultiplyFX(object.viewRange, SinFX(object.angle));
        position.y = -FLOAT_TO_FX32(7.0) - ObjDispRandRepeat(0x8000);
        position.z = MultiplyFX(object.viewRange, CosFX(object.angle));

        object.position = position;

        object.flags |= SAILMAPOBJECT_FLAG_20000000;
        SailEventManager__CreateObject2(&object);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x4c
	mov r9, #0
	add r2, sp, #0
	mov r0, r9
	mov r1, r9
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2, {r0, r1}
	mov r0, #0x25
	strh r0, [sp, #0x30]
	mov r4, #0x4f000
	ldr r0, =0x0001FFFF
	rsb r4, r4, #0
	ldr r11, =FX_SinCosTable_
	ldr r5, =0x00196225
	ldr r6, =0x3C6EF35F
	mov r10, r9
	sub r7, r0, #0x18000
	add r8, r4, #0x48000
_02165F9C:
	ldr r0, =_obj_disp_rand
	ldr r0, [r0, #0]
	mla r2, r0, r5, r6
	mov r0, r2, lsr #0x10
	mov r1, r0, lsl #0x10
	ldr r0, =0x0001FFFF
	and r0, r0, r1, lsr #16
	mla r1, r2, r5, r6
	mov r2, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	and r2, r2, r4, lsr #19
	add r2, r2, #0x800
	add r2, r9, r2
	mov r2, r2, lsl #0x10
	mov r9, r2, lsr #0x10
	mla r2, r1, r5, r6
	ldr r1, =_obj_disp_rand
	sub r0, r4, r0
	str r2, [r1]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r7, r1, lsr #16
	sub r1, r8, r1
	str r1, [sp, #0x44]
	mov r1, r9, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	mov r1, r3, lsl #1
	ldrsh r2, [r11, r1]
	add r1, r11, r3, lsl #1
	ldrsh r1, [r1, #2]
	smull ip, r3, r0, r2
	smull r2, r1, r0, r1
	str r0, [sp, #0x28]
	mov r0, #0x800
	adds r0, ip, r0
	adc r3, r3, #0
	mov r0, r0, lsr #0xc
	orr r0, r0, r3, lsl #20
	str r0, [sp, #0x40]
	mov r0, #0x800
	mov ip, #0
	adds r2, r2, r0
	mov r0, ip
	adc r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	strh r9, [sp, #0x2e]
	add r0, sp, #0x40
	str r1, [sp, #0x48]
	add r3, sp, #0x1c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0x34]
	add r0, sp, #0
	orr r1, r1, #0x20000000
	str r1, [sp, #0x34]
	bl SailEventManager__CreateObject2
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #0x10
	blo _02165F9C
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageTask *CreateSailFogCloud(SailEventManagerObject *mapObject)
{
    // should match when 'aSbCloudBac_0' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimpleEx(TASK_PRIORITY_UPDATE_LIST_START + 0x1060, TASK_GROUP(1));
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjObjectAction3dBACLoad(work, NULL, "sb_cloud.bac", OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(OBJDATAWORK_23), SailManager__GetArchive());

    u16 anim = ObjDispRandRepeat(4);
    if (anim > 2)
        anim = 0;
    Animator2D__SetAnimation(&work->obj_2dIn3d->ani.animatorSprite, anim);

    ObjObjectActionAllocTexture(work, OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(2 * anim + OBJDATAWORK_56));
    work->obj_2dIn3d->ani.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);
    worker->startEmissionColor.x = mapObject->angle;
    worker->startEmissionColor.y = mapObject->viewRange;

    work->obj_2dIn3d->ani.polygonAttr.enableFog = FALSE;
    work->obj_2dIn3d->ani.work.matrixOpIDs[0]   = MATRIX_OP_SET_CAMERA_ROT_33;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1]   = MATRIX_OP_FLUSH_P_CAMERA3D;

    fx32 scale    = ObjDispRandRepeat(0x8000) + FLOAT_TO_FX32(7.0);
    scale         = MultiplyFX(scale, FLOAT_TO_FX32(0.03125));
    work->scale.x = scale;
    work->scale.y = scale;
    work->scale.z = scale;

    if (ObjDispRandRepeat(2) != 0)
        work->scale.y = -work->scale.y;

    if (ObjDispRandRepeat(2) != 0)
        work->scale.x = -work->scale.x;

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->userFlag |= SAILOBJECT_FLAG_1;

    SetTaskState(work, SailFogCloud_State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r0, =0x00001060
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x17
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r7}
	str r0, [sp, #8]
	ldr r2, =aSbCloudBac_0
	mov r0, r4
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r7, r0, #3
	ldr r2, [r4, #0x134]
	cmp r7, #2
	ldr r0, [r2, #0x90]
	movhi r7, #0
	cmp r0, #1
	beq _02166170
	cmp r0, #2
	beq _02166180
	cmp r0, #3
	beq _02166190
	b _0216619C
_02166170:
	mov r1, r7
	add r0, r2, #0x90
	bl AnimatorSprite__SetAnimation
	b _0216619C
_02166180:
	mov r1, r7
	add r0, r2, #0x90
	bl AnimatorSpriteDS__SetAnimation
	b _0216619C
_02166190:
	mov r1, r7
	add r0, r2, #0x90
	bl AnimatorSpriteDS__SetAnimation2
_0216619C:
	mov r0, r7, lsl #1
	add r0, r0, #0x38
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r2, [r4, #0x134]
	mov r0, r4
	ldr r1, [r2, #0xcc]
	orr r1, r1, #0x18
	str r1, [r2, #0xcc]
	bl SailObject_InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject_InitFromMapObject
	ldrh r0, [r6, #0x2e]
	mov r2, #0x1d
	mov ip, #7
	str r0, [r5, #0x138]
	ldr r0, [r6, #0x28]
	ldr r6, =_obj_disp_rand
	str r0, [r5, #0x13c]
	ldr r1, [r4, #0x134]
	ldr r3, =0x00196225
	ldr r0, [r1, #0xf4]
	ldr r5, =0x3C6EF35F
	bic r0, r0, #0x8000
	str r0, [r1, #0xf4]
	ldr r0, [r4, #0x134]
	ldr r1, =0x00007FFF
	strb r2, [r0, #0xa]
	ldr r0, [r4, #0x134]
	mov r2, #0x800
	strb ip, [r0, #0xb]
	ldr r0, [r6, #0]
	mla ip, r0, r3, r5
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	add r1, r0, #0x7000
	adds r0, r2, r1, lsl #7
	mov r2, r0, lsr #0xc
	mov r0, r1, asr #0x1f
	mov r0, r0, lsl #7
	orr r0, r0, r1, lsr #25
	adc r0, r0, #0
	str ip, [r6]
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	ldr r0, [r6, #0]
	ldr r2, =_obj_disp_rand
	mla r1, r0, r3, r5
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [r6]
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r4, #0x3c]
	ldr r1, =0x3C6EF35F
	rsbne r0, r0, #0
	strne r0, [r4, #0x3c]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r4, #0x38]
	ldr r1, =SailFogCloud_State_Active
	rsbne r0, r0, #0
	strne r0, [r4, #0x38]
	ldr r0, [r4, #0x18]
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x24]
	mov r0, r4
	orr r2, r2, #1
	str r2, [r4, #0x24]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageTask *CreateSailSkyCloud(s32 type)
{
    // should match when 'aSbCloudBac_0' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjObjectAction3dBACLoad(work, NULL, "sb_cloud.bac", OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(OBJDATAWORK_23), SailManager__GetArchive());

    u16 anim = ObjDispRandRepeat(2);
    Animator2D__SetAnimation(&work->obj_2dIn3d->ani.animatorSprite, anim);

    ObjObjectActionAllocTexture(work, OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(2 * anim + OBJDATAWORK_56));
    work->obj_2dIn3d->ani.animatorSprite.flags |= DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_DID_FINISH;

    SailObject_InitCommon(work);
    work->obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    work->userWork                            = ObjDispRandRepeat(0x40) + 32;
    work->userTimer                           = 0;

    if (type != SAILSKYCLOUD_TYPE_0)
    {
        worker->startEmissionColor.y = ObjDispRandRepeat(FLOAT_TO_FX32(2.0)) + FLOAT_TO_FX32(16.0);
        worker->startEmissionColor.x = (u16)ObjDispRandRange(-FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
        work->position.y             = ObjDispRandRepeat(FLOAT_TO_FX32(1.0)) - FLOAT_TO_FX32(2.0);

        fx32 scale    = MultiplyFX(ObjDispRandRepeat(FLOAT_TO_FX32(1.0)) + FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(0.03125));
        work->scale.x = scale;
        work->scale.y = scale;
        work->scale.z = scale;

        if (SailManager__GetShipType() == SHIP_BOAT)
        {
            worker->startEmissionColor.y *= 4;
            worker->startEmissionColor.x *= 4;
            work->position.y *= 4;

            work->scale.z = work->scale.y = work->scale.x = 4 * work->scale.x;
        }
    }
    else
    {
        work->displayFlag |= DISPLAY_FLAG_DRAW_3D_SPRITE_AS_2D;
        work->position.x = FLOAT_TO_FX32(128.0);
        work->position.y = FLOAT_TO_FX32(96.0);

        work->position.x += FX32_FROM_WHOLE(ObjDispRandRange(-64, 64));
        work->position.y += FX32_FROM_WHOLE(ObjDispRandRange(-64, 64));
        work->position.z = -880;

        fx32 scale    = ObjDispRandRepeat(FLOAT_TO_FX32(4.0)) + FLOAT_TO_FX32(6.0);
        work->scale.x = scale;
        work->scale.y = scale;
        work->scale.z = scale;

        work->velocity.x = ObjDispRandRange(-FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
        work->velocity.y = ObjDispRandRange(-FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
        work->velocity.z = 8;
    }

    if (ObjDispRandRepeat(2) != 0)
        work->scale.y = -work->scale.y;

    if (ObjDispRandRepeat(2) != 0)
        work->scale.x = -work->scale.x;

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->userFlag |= SAILOBJECT_FLAG_1;

    SetTaskState(work, SailSkyCloud_State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x17
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r7}
	str r0, [sp, #8]
	ldr r2, =aSbCloudBac_0
	mov r0, r4
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r2, [r4, #0x134]
	and r7, r0, #1
	ldr r0, [r2, #0x90]
	cmp r0, #1
	beq _021663B8
	cmp r0, #2
	beq _021663C8
	cmp r0, #3
	beq _021663D8
	b _021663E4
_021663B8:
	mov r1, r7
	add r0, r2, #0x90
	bl AnimatorSprite__SetAnimation
	b _021663E4
_021663C8:
	mov r1, r7
	add r0, r2, #0x90
	bl AnimatorSpriteDS__SetAnimation
	b _021663E4
_021663D8:
	mov r1, r7
	add r0, r2, #0x90
	bl AnimatorSpriteDS__SetAnimation2
_021663E4:
	mov r0, r7, lsl #1
	add r0, r0, #0x38
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r2, [r4, #0x134]
	mov r0, r4
	ldr r1, [r2, #0xcc]
	orr r1, r1, #0x18
	str r1, [r2, #0xcc]
	bl SailObject_InitCommon
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r0, [r4, #0x134]
	mov r1, #7
	ldr r2, =_obj_disp_rand
	strb r1, [r0, #0xb]
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mov ip, #0
	mla r7, r3, r0, r1
	mov r3, r7, lsr #0x10
	str r7, [r2]
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	and r3, r3, #0x3f
	add r3, r3, #0x20
	str r3, [r4, #0x28]
	str ip, [r4, #0x2c]
	cmp r6, #0
	beq _02166580
	ldr r3, [r2, #0]
	ldr r6, =0x00001FFF
	mla r7, r3, r0, r1
	mov r3, r7, lsr #0x10
	mov r3, r3, lsl #0x10
	and r3, r6, r3, lsr #16
	str r7, [r2]
	add r3, r3, #0x10000
	str r3, [r5, #0x13c]
	ldr lr, [r2]
	sub r7, r6, #1
	mla r3, lr, r0, r1
	mov lr, r3, lsr #0x10
	mov lr, lr, lsl #0x10
	and lr, r7, lr, lsr #16
	sub r7, r6, #0x1000
	sub r7, r7, lr
	mov r7, r7, lsl #0x10
	str r3, [r2]
	mov r3, r7, lsr #0x10
	str r3, [r5, #0x138]
	ldr r3, [r2, #0]
	sub r7, r6, #0x1000
	mla lr, r3, r0, r1
	mov r3, lr, lsr #0x10
	mov r3, r3, lsl #0x10
	and r3, r7, r3, lsr #16
	str lr, [r2]
	sub r3, r3, #0x2000
	str r3, [r4, #0x48]
	ldr r7, [r2, #0]
	sub r3, r6, #0x1000
	mla r0, r7, r0, r1
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r3, r1, lsr #16
	add r3, r1, #0x8000
	mov r1, r3, asr #0x1f
	mov r6, r1, lsl #7
	mov r1, #0x800
	adds r7, r1, r3, lsl #7
	orr r6, r6, r3, lsr #25
	adc r1, r6, ip
	mov r3, r7, lsr #0xc
	str r0, [r2]
	orr r3, r3, r1, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	bl SailManager__GetShipType
	cmp r0, #1
	bne _02166674
	ldr r0, [r5, #0x13c]
	mov r0, r0, lsl #2
	str r0, [r5, #0x13c]
	ldr r0, [r5, #0x138]
	mov r0, r0, lsl #2
	str r0, [r5, #0x138]
	ldr r0, [r4, #0x48]
	mov r0, r0, lsl #2
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x38]
	mov r0, r0, lsl #2
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	b _02166674
_02166580:
	ldr r5, [r4, #0x20]
	mov r3, #0x80000
	orr r5, r5, #0x20000
	str r5, [r4, #0x20]
	str r3, [r4, #0x44]
	mov r3, #0x60000
	str r3, [r4, #0x48]
	ldr r3, [r2, #0]
	sub r6, ip, #0x370
	mla r5, r3, r0, r1
	mov r3, r5, lsr #0x10
	mov r3, r3, lsl #0x10
	str r5, [r2]
	mov r3, r3, lsr #0x10
	and r3, r3, #0x7e
	ldr r5, [r4, #0x44]
	rsb r3, r3, #0x3f
	add r3, r5, r3, lsl #12
	str r3, [r4, #0x44]
	ldr r3, [r2, #0]
	ldr r5, =0x00003FFF
	mla r7, r3, r0, r1
	mov r3, r7, lsr #0x10
	mov r3, r3, lsl #0x10
	str r7, [r2]
	mov r3, r3, lsr #0x10
	and r3, r3, #0x7e
	ldr r7, [r4, #0x48]
	rsb r3, r3, #0x3f
	add r3, r7, r3, lsl #12
	str r3, [r4, #0x48]
	str r6, [r4, #0x4c]
	ldr r3, [r2, #0]
	ldr r6, =0x00001FFE
	mla r7, r3, r0, r1
	mov r3, r7, lsr #0x10
	mov r3, r3, lsl #0x10
	and r3, r5, r3, lsr #16
	str r7, [r2]
	add r3, r3, #0x6000
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	ldr r3, [r2, #0]
	mov r5, #8
	mla r7, r3, r0, r1
	mov r3, r7, lsr #0x10
	mov r3, r3, lsl #0x10
	and r3, r6, r3, lsr #16
	str r7, [r2]
	rsb r3, r3, r6, lsr #1
	str r3, [r4, #0x98]
	ldr r3, [r2, #0]
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r6, r0, lsr #16
	str r1, [r2]
	rsb r0, r0, r6, lsr #1
	str r0, [r4, #0x9c]
	str r5, [r4, #0xa0]
_02166674:
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r4, #0x3c]
	ldr r2, =_obj_disp_rand
	rsbne r0, r0, #0
	strne r0, [r4, #0x3c]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r4, #0x38]
	ldr r1, =SailSkyCloud_State_Active
	rsbne r0, r0, #0
	strne r0, [r4, #0x38]
	ldr r0, [r4, #0x18]
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x24]
	mov r0, r4
	orr r2, r2, #1
	str r2, [r4, #0x24]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SailObject_LookAtPlayer(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    VecFx32 position = worker->player->position;

    StageTask *player = worker->player;
    switch (player->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER: {
            SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);
            VEC_Subtract(&player->position, &playerWorker->collisionOffset, &position);
        }
        break;

        case SAILSTAGE_OBJ_TYPE_EFFECT:
        case SAILSTAGE_OBJ_TYPE_OBJECT: {
            if ((work->userFlag & SAILOBJECT_FLAG_40) == 0)
                break;

            SailObject *playerWorker = GetStageTaskWorker(player, SailObject);
            VEC_Subtract(&player->position, &playerWorker->collisionOffset, &position);
        }
        break;
    }

    worker->camPos = position;
}

void SailObject_LookAtPlayerY(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    VecFx32 position = worker->player->position;

    StageTask *player = worker->player;
    switch (player->objType)
    {
        case SAILSTAGE_OBJ_TYPE_PLAYER: {
            SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);
            VEC_Subtract(&player->position, &playerWorker->collisionOffset, &position);
        }
        break;

        case SAILSTAGE_OBJ_TYPE_OBJECT: {
            SailObject *playerWorker = GetStageTaskWorker(player, SailObject);
            VEC_Subtract(&player->position, &playerWorker->collisionOffset, &position);
        }
        break;
    }

    worker->camPos.y = position.y;
}

void SailObject_HandleLookAt(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    VecFx32 position = work->position;
    VEC_Subtract(&work->position, &worker->collisionOffset, &position);

    VecFx32 camPos = worker->camPos;

    SailObject_LookAt(work, &position, &camPos);
}

void SailObject_LookAt(StageTask *work, VecFx32 *vecFrom, VecFx32 *vecTo)
{
    FXMatrix43 mtx;

    OBS_ACTION3D_NN_WORK *animator = work->obj_3d;

    VecFx32 up = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    VecFx32 from = *vecFrom;
    VecFx32 to   = *vecTo;

    from.y = -from.y;
    to.y   = -to.y;

    Unknown2066510__LookAt(&from, &to, &up, &mtx);
    MTX_Copy43To33(mtx.nnMtx, animator->ani.work.rotation.nnMtx);
}

void SailObject_HandleVoyageScroll(StageTask *work, VecFx32 *velocity)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    VecFx32 unknown = { 0, 0, 0 };

    SailVoyageSegment *voyageSegment = &voyageManager->segmentList[worker->segmentID];

    worker->voyagePosition.z -= worker->voyageScrollSpeed;

    if (worker->segmentID > FX32_TO_WHOLE(worker->voyagePosition.z) >> 7)
    {
        worker->objectAngle = voyageSegment->angle;
        if (worker->segmentID != 0)
        {
            worker->segmentID--;
            voyageSegment--;
        }
    }

    if (FX32_TO_WHOLE(worker->voyagePosition.z) >> 7 > worker->segmentID)
    {
        worker->segmentID++;
        voyageSegment++;
        worker->objectAngle = voyageSegment->angle;
    }

    s32 segmentPos      = FX_Div(worker->voyagePosition.z & 0x7FFFF, SailVoyageManager__GetSegmentSize(voyageSegment));
    worker->objectAngle = SailVoyageManager__GetAngleForSegmentPos(voyageSegment, segmentPos);

    if (velocity != NULL)
    {
        SailVoyageManager__Func_2158888(voyageSegment, segmentPos, &unknown.x, &unknown.z);
        VEC_Subtract(&unknown, &worker->field_1C, velocity);

        worker->field_1C = unknown;
    }
}

void SailObject_HandleVoyageVelocity(StageTask *work)
{
    SailObject *worker;
    SailVoyageSegment *voyageSegment;
    SailVoyageManager *voyageManager;

    worker = GetStageTaskWorker(work, SailObject);

    voyageManager = SailManager__GetWork()->voyageManager;

    s32 segmentID = FX32_TO_WHOLE(worker->voyagePosition.z) >> 7;
    voyageSegment = &voyageManager->segmentList[segmentID];

    if (work->hitstopTimer == 0)
        VEC_Add(&worker->voyagePosition, &worker->voyageVelocity, &worker->voyagePosition);

    if ((work->userFlag & SAILOBJECT_FLAG_1) != 0)
    {
        worker->voyagePosition.z += voyageManager->voyagePos - voyageManager->prevVoyagePos;
    }
    else if (SailManager__GetShipType() == SHIP_BOAT && work->hitstopTimer != 0)
    {
        worker->voyagePosition.z += FLOAT_TO_FX32(0.5);
    }

    if (segmentID > FX32_TO_WHOLE(worker->voyagePosition.z) >> 7)
    {
        worker->objectAngle = voyageSegment->angle;

        if (segmentID != 0)
        {
            segmentID--;
            voyageSegment--;
        }
    }

    if (segmentID < FX32_TO_WHOLE(worker->voyagePosition.z) >> 7)
    {
        voyageSegment++;
        worker->objectAngle = voyageSegment->angle;
    }

    s32 segmentPos      = FX_Div(worker->voyagePosition.z & 0x7FFFF, SailVoyageManager__GetSegmentSize(voyageSegment));
    worker->objectAngle = SailVoyageManager__GetAngleForSegmentPos(voyageSegment, segmentPos);

    SailVoyageManager__Func_2158888(voyageSegment, segmentPos, &work->position.x, &work->position.z);

    work->position.x += MultiplyFX(worker->voyagePosition.x, CosFX((s32)(u16)-worker->objectAngle));
    work->position.z += MultiplyFX(worker->voyagePosition.x, SinFX((s32)(u16)-worker->objectAngle));
    work->position.y = worker->voyagePosition.y;

    VEC_Subtract(&work->position, &voyageManager->position, &work->position);
}

void SailObject_Func_2166C04(StageTask *work, VecFx32 *position)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailVoyageSegment *voyageSegment = &voyageManager->segmentList[FX32_TO_WHOLE(worker->voyagePosition.z) >> 7];

    SailVoyageManager__Func_2158888(voyageSegment, FX_Div(worker->voyagePosition.z & 0x7FFFF, SailVoyageManager__GetSegmentSize(voyageSegment)), &position->x, &position->z);

    position->x += MultiplyFX(worker->voyagePosition.x, CosFX((s32)(u16)-worker->objectAngle));
    position->z += MultiplyFX(worker->voyagePosition.x, SinFX((s32)(u16)-worker->objectAngle));

    VEC_Subtract(position, &voyageManager->position, position);
}

void SailObject_Oscillate(StageTask *work)
{
    work->velocity.y += oscillateTable[(work->userTimer >> 2) & 0x7];
    work->userTimer++;
}

void SailIce_State_Oscillate(StageTask *work)
{
    work->velocity.y = -oscillateTable[(work->userTimer >> 2) & 0x7] >> 2;
    work->userTimer++;
}

void SailObject_ProcessColliders(void)
{
    OBS_RECT_WORK *rect;
    SailColliderWork *collider;
    s16 i;

    for (i = 0; TRUE; i++)
    {
        rect = ObjRect__RegistGetNext((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3), i);
        if (rect == NULL)
            break;

        if ((rect->flag & OBS_RECT_WORK_FLAG_NO_HIT_CHECKS) == 0 && (rect->flag & OBS_RECT_WORK_FLAG_CHECK_FUNC) != 0)
        {
            collider = rect->userData;

            VecFx32 position;
            FXMatrix33 mtxRotate;
            switch (collider->type)
            {
                case SAILCOLLIDER_TYPE_BOX: {
                    SailColliderHitCheckBox *hitCheck = &collider->hitCheck.box;

                    if (hitCheck->offset.x != 0 || hitCheck->offset.z != 0 || hitCheck->size.z != 0)
                    {
                        if (rect->parent != NULL)
                            hitCheck->angle = rect->parent->dir.y;
                    }

                    hitCheck->position   = *hitCheck->origin;
                    hitCheck->position.y = -hitCheck->position.y;

                    position = hitCheck->offset;

                    if (hitCheck->angle != 0)
                    {
                        if (hitCheck->offset.x != 0 || hitCheck->offset.z != 0)
                        {
                            MTX_RotY33(mtxRotate.nnMtx, SinFX((s32)hitCheck->angle), CosFX((s32)hitCheck->angle));
                            MTX_MultVec33(&position, mtxRotate.nnMtx, &position);
                        }
                    }

                    VEC_Subtract(&hitCheck->position, &position, &hitCheck->position);
                }
                break;

                case SAILCOLLIDER_TYPE_LINE: {
                    SailColliderHitCheckLine *hitCheck = &collider->hitCheck.line;

                    position   = *collider->hitCheck.line.lineOriginPos;
                    position.y = -position.y;

                    VEC_Subtract(&position, &hitCheck->offset, &position);
                    VEC_Add(&hitCheck->start, &position, &hitCheck->localStart);
                    VEC_Add(&hitCheck->end, &position, &hitCheck->localEnd);
                }
                break;
            }
        }
    }
}

NONMATCH_FUNC StageTask *CreateSailBuoy(SailEventManagerObject *mapObject)
{
    // should match when 'aSbBuoyNsbmd_0' & 'aSbBuoyNsbca' are decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjAction3dNNModelLoad(work, NULL, "sb_buoy.nsbmd", 0, GetObjectFileWork(OBJDATAWORK_28), SailManager__GetArchive());
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        ObjAction3dNNMotionLoad(work, NULL, "sb_buoy.nsbca", GetObjectFileWork(OBJDATAWORK_29), SailManager__GetArchive());
        AnimatorMDL__SetAnimation(&work->obj_3d->ani, 0, work->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
        SailObject_SetAnimSpeed(work, FLOAT_TO_FX32(2.0));
        work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    NNS_G3dMdlSetMdlEmi(work->obj_3d->ani.renderObj.resMdl, 1, GX_RGB_888(0x00, 0x00, 0x00));
    NNS_G3dMdlSetMdlLightEnableFlag(work->obj_3d->ani.renderObj.resMdl, 1, GX_LIGHTID_0);

    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);

    work->userWork = mapObject->viewRange;
    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->userFlag |= SAILOBJECT_FLAG_80000;

    fx32 scale;
    if (SailManager__GetShipType() != SHIP_BOAT)
    {
        scale = MultiplyFX(FLOAT_TO_FX32(0.5), work->scale.x);
    }
    else
    {
        scale = MultiplyFX(FLOAT_TO_FX32(0.25), work->scale.x);
        SailObject_InitColliderForCommon(work, &worker->collider[0], 0);
        SailObject_InitColliderForCommon(work, &worker->collider[1], 3);
        SailObject_InitColliderForObject(work, 0);

        VecFx32 a4;
        a4.x = FLOAT_TO_FX32(0.0);
        a4.y = -FLOAT_TO_FX32(1.5);
        a4.z = FLOAT_TO_FX32(0.0);
        SailObject_InitColliderBox(work, 0, FLOAT_TO_FX32(1.75), &a4);

        a4.x = FLOAT_TO_FX32(0.0);
        a4.y = -FLOAT_TO_FX32(4.625);
        a4.z = FLOAT_TO_FX32(0.0);
        SailObject_InitColliderBox(work, 3, FLOAT_TO_FX32(1.5), &a4);

        work->flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        worker->maxHealth = FLOAT_TO_FX32(150.0);
        worker->health    = FLOAT_TO_FX32(150.0);
        worker->score     = 1500;
        work->userFlag |= SAILOBJECT_FLAG_2000000;
        work->userFlag |= SAILOBJECT_FLAG_40000;
    }

    work->scale.x = scale;
    work->scale.y = scale;
    work->scale.z = scale;

    StageTask__InitSeqPlayer(work);
    SailBuoy_Action_Init(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x1c
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, =aSbBuoyNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02166FCC
	mov r0, #0x1d
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, =aSbBuoyNsbca
	mov r0, r4
	mov r3, r7
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	mov r0, r4
	mov r1, #0x2000
	bl SailObject_SetAnimSpeed
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_02166FCC:
	ldr r0, [r4, #0x12c]
	mov r1, #1
	ldr r0, [r0, #0x94]
	mov r2, #0
	bl NNS_G3dMdlSetMdlEmi
	ldr r0, [r4, #0x12c]
	mov r1, #1
	ldr r0, [r0, #0x94]
	mov r2, #0
	bl NNS_G3dMdlSetMdlLightEnableFlag
	mov r0, r4
	bl SailObject_InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject_InitFromMapObject
	ldr r0, [r6, #0x28]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x80000
	str r0, [r4, #0x24]
	bl SailManager__GetShipType
	ldr r2, [r4, #0x38]
	cmp r0, #1
	mov r0, #0x800
	mov r1, r2, asr #0x1f
	beq _0216705C
	mov r1, r1, lsl #0xb
	adds r3, r0, r2, lsl #11
	orr r1, r1, r2, lsr #21
	adc r0, r1, #0
	mov r6, r3, lsr #0xc
	orr r6, r6, r0, lsl #20
	b _02167118
_0216705C:
	mov r1, r1, lsl #0xa
	adds r6, r0, r2, lsl #10
	orr r1, r1, r2, lsr #22
	adc r3, r1, #0
	mov r6, r6, lsr #0xc
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	orr r6, r6, r3, lsl #20
	bl SailObject_InitColliderForCommon
	mov r0, r4
	add r1, r5, #0xa0
	mov r2, #3
	bl SailObject_InitColliderForCommon
	mov r0, r4
	mov r1, #0
	bl SailObject_InitColliderForObject
	mov r1, #0
	sub r0, r1, #0x1800
	str r0, [sp, #0xc]
	mov r0, r4
	mov r2, #0x1c00
	add r3, sp, #8
	str r1, [sp, #8]
	str r1, [sp, #0x10]
	bl SailObject_InitColliderBox
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0x10]
	sub r0, r0, #0x4a00
	str r0, [sp, #0xc]
	mov r0, r4
	mov r1, #3
	mov r2, #0x1800
	add r3, sp, #8
	bl SailObject_InitColliderBox
	ldr r1, [r4, #0x18]
	mov r0, #0x96000
	bic r1, r1, #2
	str r1, [r4, #0x18]
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	ldr r0, =0x000005DC
	str r0, [r5, #0x118]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x2040000
	str r0, [r4, #0x24]
_02167118:
	str r6, [r4, #0x38]
	str r6, [r4, #0x3c]
	mov r0, r4
	str r6, [r4, #0x40]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailBuoy_Action_Init
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void CreateSailBuoyForSegment(SailVoyageSegment *voyageSegment)
{
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    VecFx32 position = { 0, 0, 0 };

    u16 shipType = SailManager__GetShipType();

    position.y = 0;
    position.z = voyageSegment->field_24 + SailVoyageManager__GetSegmentSize(voyageSegment) - (SailVoyageManager__GetSegmentSize(voyageSegment) >> 4);

    switch (shipType)
    {
        case SHIP_JET:
        case SHIP_HOVER:
        default:
            position.x = 92 * _0218B9AC[shipType];
            break;

        case SHIP_BOAT:
            position.x = MultiplyFX(11, MATH_ABS(voyageSegment->targetSeaAngle)) + 16;
            position.x *= _0218B9AC[shipType];
            break;
    }

    if (voyageSegment->targetSeaAngle > 0)
        position.x = -position.x;

    if (voyageSegment->targetSeaAngle == 0)
    {
        if (ObjDispRandRepeat(2) != 0)
            position.x = -position.x;
    }

    SailEventManagerObject *buoy = SailEventManager__CreateObject(SAILMAPOBJECT_31, &position);

    if (voyageSegment[1].header2EntryID >= 3 && voyageSegment[1].header2EntryID <= 5)
        buoy->viewRange = 1;

    NNS_FndAppendListObject(&eventManager->stageObjectList, buoy);
}

void CreateSailBuoyForGoal(SailVoyageSegment *voyageSegment)
{
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    VecFx32 position = { 0, 0, 0 };
    position.y       = 0;
    position.z       = voyageSegment->field_24 + SailVoyageManager__GetSegmentSize(voyageSegment);
    position.x       = 92 * _0218B9AC[SailManager__GetShipType()];

    switch (SailManager__GetShipType())
    {
        case SHIP_BOAT:
            position.x = 10 * _0218B9AC[SailManager__GetShipType()];
            break;

        case SHIP_SUBMARINE:
            position.x = 60 * _0218B9AC[SailManager__GetShipType()];
            position.y = 1024;
            position.z += SailVoyageManager__GetSegmentSize(voyageSegment) >> 2;
            break;
    }

    SailEventManagerObject *buoyL = SailEventManager__CreateObject(SAILMAPOBJECT_31, &position);
    buoyL->viewRange              = 2;
    NNS_FndAppendListObject(&eventManager->stageObjectList, buoyL);

    position.x                    = -position.x;
    SailEventManagerObject *buoyR = SailEventManager__CreateObject(SAILMAPOBJECT_31, &position);
    buoyR->viewRange              = 2;
    NNS_FndAppendListObject(&eventManager->stageObjectList, buoyR);
}

NONMATCH_FUNC StageTask *CreateSailUnusedSeagull(SailEventManagerObject *mapObject)
{
    // should match when 'aSbSeagullBac' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    // NOTE: "sb_seagull.bac" is not found anywhere in th game's files.
    // So even if this object were to be spawned in, it'd be invisible.
    ObjObjectAction3dBACLoad(work, NULL, "sb_seagull.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_30), SailManager__GetArchive());
    work->obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);
    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SailUnusedSeagull_Action_Init(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r0, #0x1e
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, =0x0000FFFF
	ldr r2, =aSbSeagullBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	strb r2, [r1, #0xb]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	mov r1, r5
	mov r0, r4
	bl SailObject_InitFromMapObject
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r1, r1, #2
	str r1, [r4, #0x18]
	bl SailUnusedSeagull_Action_Init
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageTask *CreateSailSeagull(SailEventManagerObject *mapObject)
{
    // should match when 'aSbSeagullNsbmd_0' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    ObjAction3dNNModelLoad(work, NULL, "sb_seagull.nsbmd", 0, GetObjectFileWork(OBJDATAWORK_31), SailManager__GetArchive());
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);
    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SailSeagull_Action_Init(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r0, #0x1f
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	str r4, [sp]
	str r0, [sp, #4]
	mov r0, r5
	mov r1, #0
	ldr r2, =aSbSeagullNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r5
	bl SailObject_InitCommon
	mov r1, r6
	mov r0, r5
	bl SailObject_InitFromMapObject
	ldr r1, [r5, #0x18]
	mov r0, r5
	orr r1, r1, #2
	str r1, [r5, #0x18]
	bl SailSeagull_Action_Init
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageTask *CreateSailIslandSeagull(StageTask *parent)
{
    // should match when 'aSbSeagullNsbmd_0' is decompiled
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    ObjAction3dNNModelLoad(work, NULL, "sb_seagull.nsbmd", 0, GetObjectFileWork(OBJDATAWORK_31), SailManager__GetArchive());
    SailObject_InitCommon(work);
    StageTask__SetParent(work, parent, 0);

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    OBS_ACTION3D_NN_WORK *animator = work->obj_3d;
    fx32 scale                     = animator->ani.work.scale.x;
    scale                          = MultiplyFX(0x200, 0x1200 + ObjDispRandRepeat(0x200));
    animator->ani.work.scale.z = animator->ani.work.scale.y = animator->ani.work.scale.x = scale;

    SailIslandSeagull_Action_Init(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r0, #0x1f
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r5, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, =aSbSeagullNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r4
	bl SailObject_InitCommon
	mov r1, r6
	mov r0, r4
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r4, #0x18]
	ldr ip, =_obj_disp_rand
	orr r0, r0, #0x12
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	ldr r1, =0x00196225
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	ldr lr, [ip]
	ldr r2, =0x3C6EF35F
	ldr r0, [r4, #0x12c]
	mla r1, lr, r1, r2
	str r1, [ip]
	mov r1, r1, lsr #0x10
	ldr r3, =0x000001FF
	mov r1, r1, lsl #0x10
	and r1, r3, r1, lsr #16
	add r2, r1, #0x1200
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	orr r3, r3, r2, lsr #23
	adds r2, r1, r2, lsl #9
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x18]
	str r2, [r0, #0x1c]
	str r2, [r0, #0x20]
	mov r0, r4
	bl SailIslandSeagull_Action_Init
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CreateSailSeagullForSegment(SailVoyageSegment *voyageSegment)
{
    // https://decomp.me/scratch/UBdFn -> 84.11%
#ifdef NON_MATCHING
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    VecFx32 position = { 0, 0, 0 };

    u16 shipType = SailManager__GetShipType();

    position.z = voyageSegment->field_24;

    switch (shipType)
    {
        case SHIP_JET:
        case SHIP_HOVER:
        default:
            position.x = ObjDispRandRange(-0x40, 0x40);
            position.x *= _0218B9AC[shipType];

            position.y = -(ObjDispRandRepeat(0x20) + 80);
            position.y *= _0218B9B4[shipType];
            break;

        case SHIP_BOAT:
            position.x = MultiplyFX(11, MATH_ABS(voyageSegment->targetSeaAngle));
            position.x += ObjDispRandRepeat(16);
            position.x *= _0218B9AC[shipType];

            if (voyageSegment->targetSeaAngle > 0)
                position.x = -position.x;

            if (voyageSegment->targetSeaAngle == 0)
            {
                if (ObjDispRandRepeat(2) != 0)
                    position.x = -position.x;
            }

            position.y = ObjDispRandRepeat(8);
            position.y += 6;
            position.y *= -_0218B9B4[shipType];

            position.z += SailVoyageManager__GetSegmentSize(voyageSegment) >> 2;

            break;
    }

    SailEventManagerObject *seagull = SailEventManager__CreateObject(SAILMAPOBJECT_35, &position);
    NNS_FndAppendListObject(&eventManager->stageObjectList, seagull);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl SailManager__GetWork
	ldr r4, [r0, #0xa0]
	add r1, sp, #0
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	str r0, [r1, #8]
	bl SailManager__GetShipType
	ldr r1, [r5, #0x24]
	mov r0, r0, lsl #0x10
	str r1, [sp, #8]
	movs lr, r0, lsr #0x10
	beq _0216767C
	cmp lr, #1
	beq _021676EC
	cmp lr, #2
_0216767C:
	ldr r6, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r6, #0]
	ldr r2, =0x3C6EF35F
	ldr r1, =_0218B9AC
	mla r5, r3, r0, r2
	mla r0, r5, r0, r2
	mov r2, r0, lsr #0x10
	mov r3, r5, lsr #0x10
	mov r5, r2, lsl #0x10
	mov r2, lr, lsl #1
	ldr r7, =0x0218B9B4
	mov r3, r3, lsl #0x10
	mov r5, r5, lsr #0x10
	mov ip, r3, lsr #0x10
	and r3, r5, #0x1f
	and r5, ip, #0x7e
	add r3, r3, #0x50
	ldrh ip, [r1, r2]
	rsb r5, r5, #0x3f
	ldrh r2, [r7, r2]
	rsb r1, r3, #0
	mul r3, ip, r5
	mul r1, r2, r1
	str r3, [sp]
	str r0, [r6]
	str r1, [sp, #4]
	b _02167800
_021676EC:
	ldrsh r6, [r5, #0xa]
	mov r3, #0xb
	mov r2, #0
	cmp r6, #0
	rsblt r6, r6, #0
	umull r7, r1, r6, r3
	mla r1, r6, r2, r1
	mov r6, r6, asr #0x1f
	mla r1, r6, r3, r1
	adds r2, r7, #0x800
	ldr r0, =_obj_disp_rand
	ldr r6, =0x00196225
	ldr r7, [r0, #0]
	ldr ip, =0x3C6EF35F
	ldr r3, =_0218B9AC
	mla r6, r7, r6, ip
	mov r7, r6, lsr #0x10
	mov ip, lr, lsl #1
	mov r7, r7, lsl #0x10
	mov r7, r7, lsr #0x10
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	and r1, r7, #0xf
	ldrh r3, [r3, ip]
	add r1, r2, r1
	str r6, [r0]
	mul r1, r3, r1
	str r1, [sp]
	ldrsh r0, [r5, #0xa]
	cmp r0, #0
	rsbgt r0, r1, #0
	strgt r0, [sp]
	ldrsh r0, [r5, #0xa]
	cmp r0, #0
	bne _021677AC
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldr r2, =_obj_disp_rand
	mla r6, r0, r6, r1
	mov r0, r6, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [sp]
	str r6, [r2]
	rsbne r0, r0, #0
	strne r0, [sp]
_021677AC:
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldr r2, =0x0218B9B4
	mla r1, r6, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r3, lr, lsl #1
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	add r0, r0, #6
	ldrh r3, [r2, r3]
	rsb r0, r0, #0
	ldr r2, =_obj_disp_rand
	mul r6, r3, r0
	mov r0, r5
	str r1, [r2]
	str r6, [sp, #4]
	bl SailVoyageManager__GetSegmentSize
	ldr r1, [sp, #8]
	add r0, r1, r0, asr #2
	str r0, [sp, #8]
_02167800:
	add r1, sp, #0
	mov r0, #0x23
	bl SailEventManager__CreateObject
	mov r1, r0
	mov r0, r4
	bl NNS_FndAppendListObject
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void CreateSailSeagullForDestination(StageTask *parent)
{
    u16 count = 2 + ObjDispRandRepeat(4);

    for (u16 i = 0; i < count; i++)
    {
        CreateSailIslandSeagull(parent);
    }
}

NONMATCH_FUNC StageTask *CreateSailRock(SailEventManagerObject *mapObject)
{
    // https://decomp.me/scratch/aBonY -> 96.38%
#ifdef NON_MATCHING
    StageTask *work;
    SailObject *worker;

    fx32 v2 = FLOAT_TO_FX32(1.0);

    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = manager->voyageManager;

    u8 *segmentType;
    segmentType = &voyageManager->segmentList[mapObject->segmentID].type;
    if (mapObject->type != SAILMAPOBJECT_26)
    {
        if (*segmentType == SAILVOYAGESEGMENT_TYPE_1 || *segmentType == SAILVOYAGESEGMENT_TYPE_8)
        {
            return CreateSailIce(mapObject);
        }
    }

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    u16 anim;
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        anim = ObjDispRandRepeat(2);
    }
    else
    {
        s32 type1 = ObjDispRandRepeat(2);
        s32 type2 = ObjDispRandRepeat(2);
        anim      = (u16)type1 + (u16)type2;
    }

    ObjAction3dNNModelLoad(work, NULL, "sb_stone.nsbmd", anim, GetObjectFileWork(OBJDATAWORK_32), SailManager__GetArchive());
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);
    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->userFlag |= SAILOBJECT_FLAG_40000;

    fx32 scale_1 = work->scale.x;

    VecFx32 position;
    switch (SailManager__GetShipType())
    {
        default: {
            if ((worker->objectRef->flags & 7) != 0)
                v2 *= (worker->objectRef->flags & 7);

            fx32 scale_2  = MultiplyFX(scale_1, v2);
            work->scale.y = MultiplyFX(scale_2, 0x800 + (u32)(0xFF - (ObjDispRandRepeat((0x100 * 2) - 1))));

            if (worker->objectRef->type == SAILMAPOBJECT_26)
            {
                if (anim == 0)
                {
                    work->scale.x = MultiplyFX(scale_2, 0xA60);
                    work->scale.z = work->scale.x;
                }
                else
                {
                    work->scale.x = MultiplyFX(scale_2, 0x9C0);
                    work->scale.z = work->scale.x;
                }

                SailObject_InitColliderForCommon(work, &worker->collider[1], 1);
                SailObject_InitColliderBox(work, 1, MultiplyFX(0x1160, v2), 0);
                worker->collider[1].flags |= SAILCOLLIDER_FLAG_4000;
                work->colliderList[1]->hitPower = 20;
                work->colliderList[1]->defPower = OBS_RECT_DEFPOWER_VULNERABLE;
                work->flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            }
            else
            {
                work->scale.x = MultiplyFX(scale_2, 0x800 + (u32)(0x1FF - ObjDispRandRepeat((0x200 * 2) - 1)));
                work->scale.z = MultiplyFX(scale_2, 0x800 + (u32)(0x1FF - ObjDispRandRepeat((0x200 * 2) - 1)));
            }
            break;
        }

        case SHIP_BOAT: {
            if ((worker->objectRef->flags & 7) != 0)
                v2 *= (worker->objectRef->flags & 7);

            if (mapObject->param)
            {
                v2 = ObjDispRandRange2(0x1000, 0x1800);
            }

            fx32 scale_2 = MultiplyFX(MultiplyFX(work->scale.x, 0x400), v2);

            work->scale.x = MultiplyFX(scale_2, 0x1000 + (u32)(0x1FF - ObjDispRandRepeat((0x200 * 2) - 1)));
            work->scale.y = MultiplyFX(scale_2, 0x1000 + (u32)(0xFF - ObjDispRandRepeat((0x100 * 2) - 1)));
            work->scale.z = MultiplyFX(scale_2, 0x1000 + (u32)(0x1FF - ObjDispRandRepeat((0x200 * 2) - 1)));

            if (mapObject->param)
            {
                fx32 value    = 0x1B00 + (0xFF - ObjDispRandRepeat((0x400 * 2) - 1));
                work->scale.x = MultiplyFX(work->scale.x, value);
                work->scale.z = MultiplyFX(work->scale.z, value);
            }

            if (anim != 0)
            {
                position.x = FLOAT_TO_FX32(0.0);
                position.y = FLOAT_TO_FX32(0.0);
                position.z = FLOAT_TO_FX32(0.0);
            }
            else
            {
                position.x = FLOAT_TO_FX32(0.0);
                position.y = FLOAT_TO_FX32(1.0);
                position.z = FLOAT_TO_FX32(0.0);
            }
            SailObject_SetCollisionOffset(work, &position);
            SailObject_InitColliderForCommon(work, worker->collider, 0);
            if (!mapObject->param)
                SailObject_InitColliderForObject(work, 0);
            SailObject_InitColliderBox(work, 0, MultiplyFX(v2, 0x2000), 0);

            work->flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;

            fx32 health       = MultiplyFX(FLOAT_TO_FX32(40.0), v2);
            worker->maxHealth = health;
            worker->health    = health;

            worker->score = 300;
            worker->score = MultiplyFX(v2, worker->score);

            break;
        }

        case SHIP_HOVER: {
            if ((worker->objectRef->flags & 7) != 0)
                v2 *= (worker->objectRef->flags & 7);

            fx32 scale_2 = MultiplyFX(scale_1, v2);

            work->scale.y = MultiplyFX(scale_2, 0x800 + (u32)(0xFF - ObjDispRandRepeat((0x100 * 2) - 1)));
            work->scale.x = MultiplyFX(scale_2, 0x800 + (u32)(0x1FF - ObjDispRandRepeat((0x200 * 2) - 1)));
            work->scale.z = MultiplyFX(scale_2, 0x800 + (u32)(0x1FF - ObjDispRandRepeat((0x200 * 2) - 1)));

            if (worker->objectRef->type == SAILMAPOBJECT_26)
            {
                SailObject_InitColliderForCommon(work, worker->collider, 0);
                SailObject_InitColliderBox(work, 0, MultiplyFX(v2, 0x1000), 0);
                work->flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
                worker->collider[0].atkPower = FLOAT_TO_FX32(64.0);

                OBS_RECT_WORK *collider = StageTask__GetCollider(work, 0);
                collider->defFlag |= OBS_RECT_WORK_ATTR_USER_1;
                collider->hitPower = 20;

                const s32 value = FLOAT_TO_FX32(40.0);

                fx32 health       = MultiplyFX(value, v2);
                worker->maxHealth = health;
                worker->health    = health;

                worker->score = MultiplyFX(300, v2);
            }
            break;
        }

        case SHIP_SUBMARINE: {
            work->scale.x = MultiplyFX(scale_1, 0x1000 + (u32)(0x7FF - ObjDispRandRepeat((0x800 * 2) - 1)));
            work->scale.y = MultiplyFX(scale_1, 0x800 + (u32)(0x3FF - ObjDispRandRepeat((0x400 * 2) - 1)));
            work->scale.z = MultiplyFX(scale_1, 0x1000 + (u32)(0x7FF - ObjDispRandRepeat((0x800 * 2) - 1)));

            SailObject_SetLightColors(work, 5);

            if (mapObject->param)
            {
                fx32 scale = 0x1B00 + (0xFF - ObjDispRandRepeat((0x200 * 2) - 1));

                work->scale.x = MultiplyFX(work->scale.x, scale);
                work->scale.y = MultiplyFX(work->scale.y, scale);
                work->scale.z = MultiplyFX(work->scale.z, scale);

                work->scale.y = MultiplyFX(work->scale.y, 0x1400 + (u32)(0x7FF & ObjDispRandRepeat((0x800 * 2))));
            }

            if (anim != 0)
            {
                position.x = FLOAT_TO_FX32(0.0);
                position.y = FLOAT_TO_FX32(0.0);
                position.z = FLOAT_TO_FX32(0.0);
            }
            else
            {
                position.x = FLOAT_TO_FX32(0.0);
                position.y = FLOAT_TO_FX32(1.0);
                position.z = FLOAT_TO_FX32(0.0);
            }

            SailObject_SetCollisionOffset(work, &position);
            break;
        }
    }

    work->dir.y = ObjDispRand();

    SailObject_ApplyRotation(work);
    StageTask__InitSeqPlayer(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r9, r0
	mov r8, #0x1000
	bl SailManager__GetWork
	ldrh r1, [r9, #0x30]
	ldr r3, [r0, #0x98]
	ldrh r2, [r9, #0x2c]
	mov r0, #0x28
	cmp r1, #0x1a
	mul r0, r2, r0
	ldr r1, [r3, #0xc0]
	beq _021678F8
	ldrb r0, [r1, r0]
	cmp r0, #1
	cmpne r0, #8
	bne _021678F8
	mov r0, r9
	bl CreateSailIce
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021678F8:
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	bl SailManager__GetShipType
	cmp r0, #3
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	beq _02167950
	ldr r2, =_obj_disp_rand
	ldr r3, [r2, #0]
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r6, r0, #1
	str r1, [r2]
	b _02167994
_02167950:
	ldr r3, =_obj_disp_rand
	ldr r2, [r3, #0]
	mla r6, r2, r0, r1
	mla r0, r6, r0, r1
	mov r1, r6, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r6, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r1, r2, lsr #0x10
	and r6, r6, #1
	and r2, r1, #1
	mov r1, r6, lsl #0x10
	add r1, r2, r1, lsr #16
	mov r1, r1, lsl #0x10
	str r0, [r3]
	mov r6, r1, lsr #0x10
_02167994:
	mov r0, #0x20
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	str r0, [sp, #4]
	ldr r2, =aSbStoneNsbmd_0
	mov r0, r4
	mov r1, #0
	mov r3, r6
	bl ObjAction3dNNModelLoad
	mov r0, r4
	bl SailObject_InitCommon
	mov r0, r4
	mov r1, r9
	bl SailObject_InitFromMapObject
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x24]
	orr r0, r0, #0x40000
	str r0, [r4, #0x24]
	ldr r7, [r4, #0x38]
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02167BE0
	cmp r0, #2
	beq _02167E88
	cmp r0, #3
	beq _02168054
	ldr r0, [r5, #0x164]
	ldr r11, =_obj_disp_rand
	ldr r0, [r0, #0x34]
	ldr lr, =0x00196225
	ands r0, r0, #7
	mulne r0, r8, r0
	movne r8, r0
	smull r9, r1, r7, r8
	ldr r7, [r11, #0]
	ldr r2, =0x3C6EF35F
	ldr r3, =0x000001FE
	mla r0, r7, lr, r2
	adds r7, r9, #0x800
	mov r9, r0, lsr #0x10
	mov r9, r9, lsl #0x10
	and r9, r3, r9, lsr #16
	adc r10, r1, #0
	mov r1, r7, lsr #0xc
	rsb r9, r9, #0xff
	orr r1, r1, r10, lsl #20
	add r7, r9, #0x800
	smull r9, r7, r1, r7
	adds r9, r9, #0x800
	adc r7, r7, #0
	mov r9, r9, lsr #0xc
	orr r9, r9, r7, lsl #20
	str r0, [r11]
	str r9, [r4, #0x3c]
	ldr r0, [r5, #0x164]
	mov r7, r8, asr #0x1f
	ldrh r9, [r0, #0x30]
	mov r0, r1, asr #0x1f
	mov r10, #0
	cmp r9, #0x1a
	mov r9, #0x800
	bne _02167B44
	cmp r6, #0
	moveq r2, #0xa60
	movne r2, #0x9c0
	umull r6, r3, r1, r2
	mla r3, r1, r10, r3
	mla r3, r0, r2, r3
	adds r1, r6, r9
	adc r0, r3, r10
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x38]
	str r1, [r4, #0x40]
	mov r0, r4
	add r1, r5, #0xa0
	mov r2, #1
	bl SailObject_InitColliderForCommon
	ldr r0, =0x00001160
	mov r3, #0
	umull r2, r1, r8, r0
	mla r1, r8, r3, r1
	mla r1, r7, r0, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mov r0, r4
	mov r1, #1
	bl SailObject_InitColliderBox
	add r0, r5, #0x100
	ldrh r3, [r0, #0x14]
	mov r2, #0x14
	mov r1, #0
	orr r3, r3, #0x4000
	strh r3, [r0, #0x14]
	ldr r0, [r4, #0x148]
	strh r2, [r0, #0x2c]
	ldr r0, [r4, #0x148]
	strh r1, [r0, #0x2e]
	ldr r0, [r4, #0x18]
	bic r0, r0, #2
	str r0, [r4, #0x18]
	b _02168230
_02167B44:
	ldr r5, [r11, #0]
	add r6, r3, #0x200
	mla ip, r5, lr, r2
	mov r5, ip, lsr #0x10
	mov r5, r5, lsl #0x10
	and r6, r6, r5, lsr #16
	add r5, r3, #1
	sub r5, r5, r6
	add r6, r5, #0x800
	umull r8, r7, r1, r6
	mov r5, r6, asr #0x1f
	str ip, [r11]
	mla r7, r1, r5, r7
	adds r8, r8, r9
	mla r7, r0, r6, r7
	adc r5, r7, r10
	mov r6, r8, lsr #0xc
	orr r6, r6, r5, lsl #20
	str r6, [r4, #0x38]
	ldr r5, [r11, #0]
	add r6, r3, #0x200
	mla r2, r5, lr, r2
	mov r5, r2, lsr #0x10
	mov r5, r5, lsl #0x10
	and r5, r6, r5, lsr #16
	add r3, r3, #1
	sub r3, r3, r5
	add r5, r3, #0x800
	umull r7, r6, r1, r5
	mov r3, r5, asr #0x1f
	str r2, [r11]
	mla r6, r1, r3, r6
	adds r1, r7, r9
	mla r6, r0, r5, r6
	adc r0, r6, r10
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x40]
	b _02168230
_02167BE0:
	ldr r0, [r5, #0x164]
	ldr r0, [r0, #0x34]
	ands r0, r0, #7
	mulne r0, r8, r0
	movne r8, r0
	ldr r0, [r9, #0x38]
	cmp r0, #0
	beq _02167C2C
	ldr r3, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r7, [r3, #0]
	ldr r1, =0x3C6EF35F
	ldr r2, =0x000007FF
	mla r1, r7, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	str r1, [r3]
	add r8, r0, #0x1000
_02167C2C:
	ldr r1, [r4, #0x38]
	ldr r3, =_obj_disp_rand
	mov r0, r1, asr #0x1f
	mov r10, r0, lsl #0xa
	mov r0, #0x800
	adds r2, r0, r1, lsl #10
	orr r10, r10, r1, lsr #22
	ldr r7, [r3, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	adc r10, r10, #0
	mov r2, r2, lsr #0xc
	mla r11, r7, r0, r1
	orr r2, r2, r10, lsl #20
	smull r10, r7, r2, r8
	adds r10, r10, #0x800
	adc r2, r7, #0
	mov r10, r10, lsr #0xc
	orr r10, r10, r2, lsl #20
	mov r2, r11, lsr #0x10
	str r11, [r3]
	mov r11, r2, lsl #0x10
	ldr r2, =0x000003FE
	mov r7, r8, asr #0x1f
	and r11, r2, r11, lsr #16
	rsb r11, r11, r2, lsr #1
	add r11, r11, #0x1000
	smull r11, ip, r10, r11
	adds r11, r11, #0x800
	adc ip, ip, #0
	mov r11, r11, lsr #0xc
	orr r11, r11, ip, lsl #20
	str r11, [r4, #0x38]
	ldr ip, [r3]
	sub r11, r2, #0x200
	mla lr, ip, r0, r1
	mov ip, lr, lsr #0x10
	mov ip, ip, lsl #0x10
	and r11, r11, ip, lsr #16
	rsb r11, r11, #0xff
	add r11, r11, #0x1000
	smull r11, ip, r10, r11
	adds r11, r11, #0x800
	adc ip, ip, #0
	mov r11, r11, lsr #0xc
	str lr, [r3]
	orr r11, r11, ip, lsl #20
	str r11, [r4, #0x3c]
	ldr r11, [r3, #0]
	mla ip, r11, r0, r1
	mov r11, ip, lsr #0x10
	mov r11, r11, lsl #0x10
	and r11, r2, r11, lsr #16
	rsb r11, r11, r2, lsr #1
	add r11, r11, #0x1000
	str ip, [r3]
	smull ip, r11, r10, r11
	adds ip, ip, #0x800
	adc r10, r11, #0
	mov r11, ip, lsr #0xc
	orr r11, r11, r10, lsl #20
	str r11, [r4, #0x40]
	ldr r10, [r9, #0x38]
	cmp r10, #0
	beq _02167D94
	ldr r10, [r3, #0]
	add r2, r2, #0x400
	mla r1, r10, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r3]
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	ldr r1, =0x00001BFF
	ldr r2, [r4, #0x38]
	sub r0, r1, r0
	smull r10, r3, r2, r0
	adds r2, r10, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x38]
	ldr r1, [r4, #0x40]
	smull r3, r2, r1, r0
	mov r0, #0x800
	adds r1, r3, r0
	mov r0, #0
	adc r0, r2, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x40]
_02167D94:
	cmp r6, #0
	beq _02167DB0
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	b _02167DC4
_02167DB0:
	mov r1, #0
	mov r0, #0x1000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
_02167DC4:
	add r1, sp, #8
	mov r0, r4
	bl SailObject_SetCollisionOffset
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject_InitColliderForCommon
	ldr r0, [r9, #0x38]
	cmp r0, #0
	bne _02167DF8
	mov r0, r4
	mov r1, #0
	bl SailObject_InitColliderForObject
_02167DF8:
	mov r2, r7, lsl #0xd
	mov r0, #0x800
	mov r1, #0
	adds r0, r0, r8, lsl #13
	orr r2, r2, r8, lsr #19
	adc r6, r2, #0
	mov r2, r0, lsr #0xc
	mov r0, r4
	mov r3, r1
	orr r2, r2, r6, lsl #20
	bl SailObject_InitColliderBox
	mov r10, #0x28000
	umull r0, r6, r10, r8
	adds r0, r0, #0x800
	mov r9, r0, lsr #0xc
	mov r3, #0x12c
	umull r2, r1, r3, r8
	ldr r11, [r4, #0x18]
	mla r6, r10, r7, r6
	mov r0, r10, asr #0x1f
	mla r6, r0, r8, r6
	adc r0, r6, #0
	orr r9, r9, r0, lsl #20
	bic r11, r11, #2
	str r11, [r4, #0x18]
	str r9, [r5, #0x120]
	mla r1, r3, r7, r1
	mov r0, r3, asr #0x1f
	mla r1, r0, r8, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	str r9, [r5, #0x11c]
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x118]
	b _02168230
_02167E88:
	ldr r0, [r5, #0x164]
	ldr r3, =_obj_disp_rand
	ldr r0, [r0, #0x34]
	ldr r11, [r3, #0]
	ands r0, r0, #7
	mulne r0, r8, r0
	movne r8, r0
	smull r10, r6, r7, r8
	adds r7, r10, #0x800
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	ldr r0, =0x000001FE
	mla r9, r11, r1, r2
	mov r10, r9, lsr #0x10
	mov r10, r10, lsl #0x10
	and r10, r0, r10, lsr #16
	rsb r10, r10, #0xff
	adc r6, r6, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r6, lsl #20
	add r6, r10, #0x800
	smull r10, r6, r7, r6
	adds r10, r10, #0x800
	adc r6, r6, #0
	mov r10, r10, lsr #0xc
	str r9, [r3]
	orr r10, r10, r6, lsl #20
	str r10, [r4, #0x3c]
	ldr r9, [r3, #0]
	add r10, r0, #0x200
	mla r6, r9, r1, r2
	mov r9, r6, lsr #0x10
	mov r9, r9, lsl #0x10
	and r10, r10, r9, lsr #16
	add r9, r0, #1
	sub r9, r9, r10
	add r9, r9, #0x800
	smull r10, r9, r7, r9
	adds r10, r10, #0x800
	str r6, [r3]
	add r6, r0, #0x200
	adc r9, r9, #0
	mov r10, r10, lsr #0xc
	orr r10, r10, r9, lsl #20
	str r10, [r4, #0x38]
	ldr r9, [r3, #0]
	add r0, r0, #1
	mla r1, r9, r1, r2
	mov r2, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	and r2, r6, r2, lsr #16
	sub r0, r0, r2
	add r0, r0, #0x800
	smull r2, r0, r7, r0
	adds r2, r2, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	str r1, [r3]
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x40]
	ldr r0, [r5, #0x164]
	mov r6, r8, asr #0x1f
	ldrh r0, [r0, #0x30]
	mov r2, #0
	cmp r0, #0x1a
	bne _02168230
	mov r0, r4
	add r1, r5, #0x28
	bl SailObject_InitColliderForCommon
	mov r2, r6, lsl #0xc
	mov r0, #0x800
	mov r1, #0
	adds r0, r0, r8, lsl #12
	orr r2, r2, r8, lsr #20
	adc r7, r2, #0
	mov r2, r0, lsr #0xc
	mov r0, r4
	mov r3, r1
	orr r2, r2, r7, lsl #20
	bl SailObject_InitColliderBox
	ldr r1, [r4, #0x18]
	mov r0, r4
	bic r1, r1, #2
	str r1, [r4, #0x18]
	mov r1, #0x40000
	str r1, [r5, #0x98]
	mov r1, #0
	bl StageTask__GetCollider
	ldrh r2, [r0, #0x32]
	mov r3, #0x28000
	mov r1, #0x14
	orr r2, r2, #4
	strh r2, [r0, #0x32]
	strh r1, [r0, #0x2c]
	umull r0, r1, r3, r8
	adds r0, r0, #0x800
	mov r2, r0, lsr #0xc
	mla r1, r3, r6, r1
	mov r0, r3, asr #0x1f
	mla r1, r0, r8, r1
	adc r0, r1, #0
	orr r2, r2, r0, lsl #20
	str r2, [r5, #0x120]
	mov r3, #0x12c
	str r2, [r5, #0x11c]
	umull r2, r1, r3, r8
	mla r1, r3, r6, r1
	mov r0, r3, asr #0x1f
	mla r1, r0, r8, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x118]
	b _02168230
_02168054:
	ldr r5, =_obj_disp_rand
	mov r3, #0x800
	ldr r10, [r5, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldr r2, =0x00000FFE
	mla r8, r10, r0, r1
	mov r10, r8, lsr #0x10
	mov r10, r10, lsl #0x10
	and r10, r2, r10, lsr #16
	rsb r10, r10, r2, lsr #1
	add r10, r10, #0x1000
	smull r11, r10, r7, r10
	adds r11, r11, #0x800
	adc r10, r10, #0
	mov r11, r11, lsr #0xc
	str r8, [r5]
	orr r11, r11, r10, lsl #20
	str r11, [r4, #0x38]
	ldr r10, [r5, #0]
	sub r11, r3, #2
	mla r8, r10, r0, r1
	mov r10, r8, lsr #0x10
	mov r10, r10, lsl #0x10
	and r10, r11, r10, lsr #16
	rsb r10, r10, r2, lsr #2
	add r10, r10, #0x800
	smull r11, r10, r7, r10
	adds r11, r11, #0x800
	adc r10, r10, #0
	mov r11, r11, lsr #0xc
	str r8, [r5]
	orr r11, r11, r10, lsl #20
	str r11, [r4, #0x3c]
	ldr r8, [r5, #0]
	sub r3, r3, #1
	mla r0, r8, r0, r1
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r2, r1, lsr #16
	sub r1, r3, r1
	add r1, r1, #0x1000
	smull r2, r1, r7, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	str r0, [r5]
	orr r2, r2, r1, lsl #20
	mov r0, r4
	str r2, [r4, #0x40]
	mov r1, #5
	bl SailObject_SetLightColors
	ldr r0, [r9, #0x38]
	cmp r0, #0
	beq _021681F4
	mov r8, r5
	ldr r0, [r8, #0]
	ldr r3, =0x00196225
	ldr r5, =0x3C6EF35F
	ldr r1, =0x000003FE
	mla r2, r0, r3, r5
	mov r0, r2, lsr #0x10
	str r2, [r8]
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	ldr r2, =0x00001BFF
	ldr r1, [r4, #0x38]
	sub r0, r2, r0
	smull r9, r2, r1, r0
	adds r9, r9, #0x800
	adc r1, r2, #0
	mov r2, r9, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x38]
	mov r7, #0x800
	ldr r2, [r4, #0x3c]
	sub r1, r7, #1
	smull r9, r7, r2, r0
	adds r9, r9, #0x800
	adc r2, r7, #0
	mov r7, r9, lsr #0xc
	orr r7, r7, r2, lsl #20
	str r7, [r4, #0x3c]
	ldr r2, [r4, #0x40]
	smull r7, r0, r2, r0
	adds r2, r7, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x40]
	ldr r0, [r8, #0]
	mla r2, r0, r3, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	str r2, [r8]
	ldr r1, [r4, #0x3c]
	add r0, r0, #0x1400
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x3c]
_021681F4:
	cmp r6, #0
	beq _02168210
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	b _02168224
_02168210:
	mov r1, #0
	mov r0, #0x1000
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
_02168224:
	add r1, sp, #8
	mov r0, r4
	bl SailObject_SetCollisionOffset
_02168230:
	ldr r3, =_obj_disp_rand
	ldr r1, =0x00196225
	ldr r5, [r3, #0]
	ldr r2, =0x3C6EF35F
	mov r0, r4
	mla r1, r5, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	strh r1, [r4, #0x32]
	bl SailObject_ApplyRotation
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CreateSailRockForSegment(SailVoyageSegment *voyageSegment, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	bl SailManager__GetWork
	ldr r4, [r0, #0xa0]
	bl SailManager__GetWork
	add r2, sp, #0
	mov r1, #0
	mov r5, r0
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _021682F0
_021682E0: // jump table
	b _021682F0 // case 0
	b _0216838C // case 1
	b _021682F0 // case 2
	b _0216862C // case 3
_021682F0:
	ldr r1, =_obj_disp_rand
	ldr r2, =0x00196225
	ldr r8, [r1, #0]
	ldr r3, =0x3C6EF35F
	ldr r5, =_0218B9AC
	mla r10, r8, r2, r3
	mla r9, r10, r2, r3
	mov r10, r10, lsr #0x10
	mla r2, r9, r2, r3
	mov r8, r0, lsl #1
	ldr r0, =0x0218B9B4
	mov r3, r10, lsl #0x10
	mov r9, r9, lsr #0x10
	mov r3, r3, lsr #0x10
	mov r9, r9, lsl #0x10
	and r3, r3, #0xff
	mov r10, r9, lsr #0x10
	mov r9, r2, lsr #0x10
	mov r9, r9, lsl #0x10
	ldrh r5, [r5, r8]
	add r11, r3, #0x58
	ldrh r3, [r0, r8]
	and r0, r10, #0xf
	mul r8, r5, r11
	mul r5, r3, r0
	mov r0, r7
	str r8, [sp]
	str r5, [sp, #4]
	str r2, [r1]
	mov r5, r9, lsr #0x10
	bl SailVoyageManager__GetSegmentSize
	mov r1, r5, lsl #0x12
	ldr r2, [r7, #0x24]
	mov r1, r1, lsr #0xe
	add r2, r2, r0
	add r0, r1, #0x10000
	sub r0, r2, r0
	str r0, [sp, #8]
	b _02168788
_0216838C:
	cmp r6, #1
	beq _0216845C
	cmp r6, #2
	ldrsh r8, [r7, #0xa]
	mov r5, #0xb
	beq _02168538
	cmp r8, #0
	rsblt r8, r8, #0
	mov r3, #0
	umull r9, r2, r8, r5
	mla r2, r8, r3, r2
	adds r3, r9, #0x800
	mov r8, r8, asr #0x1f
	mla r2, r8, r5, r2
	ldr r1, =_obj_disp_rand
	mov r5, #0x800
	ldr r10, [r1, #0]
	ldr r8, =0x00196225
	ldr r9, =0x3C6EF35F
	ldr r11, =_0218B9AC
	mov r0, r0, lsl #1
	ldrh r0, [r11, r0]
	mla r11, r10, r8, r9
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	mla r2, r11, r8, r9
	add r3, r3, #0x10
	mov r8, r2, lsr #0x10
	mul r0, r3, r0
	mov r9, r11, lsr #0x10
	mov r3, r9, lsl #0x10
	sub r5, r5, #1
	and r3, r5, r3, lsr #16
	add r3, r3, #0x800
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r3, r5, lsr #0xc
	orr r3, r3, r0, lsl #20
	mov r8, r8, lsl #0x10
	mov r0, r7
	str r3, [sp]
	str r2, [r1]
	mov r5, r8, lsr #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r2, [r7, #0x24]
	mov r1, r5, lsl #0x10
	add r0, r2, r0
	sub r0, r0, r1, lsr #16
	str r0, [sp, #8]
	b _02168788
_0216845C:
	ldr r1, =_obj_disp_rand
	ldr r3, =0x00196225
	ldr r2, [r1, #0]
	ldr r10, =0x3C6EF35F
	ldr r11, =_0218B9AC
	mla r9, r2, r3, r10
	mla r8, r9, r3, r10
	mla r2, r8, r3, r10
	mla r3, r2, r3, r10
	str r9, [r1]
	mov ip, r9, lsr #0x10
	ldrh r9, [r5, #0x58]
	mov r10, r0, lsl #1
	mov r0, ip, lsl #0x10
	mov lr, r8, lsr #0x10
	mov r8, r0, lsr #0x10
	str r3, [r1]
	mov ip, r2, lsr #0x10
	ldr r0, =0x00007FFE
	mov r1, lr, lsl #0x10
	mov r2, r3, lsr #0x10
	and r3, r0, r1, lsr #16
	ldrh r1, [r11, r10]
	mov r9, r9, lsl #0x1e
	and r8, r8, #7
	add r8, r8, r9, lsr #27
	rsb r0, r3, r0, lsr #1
	mla r3, r1, r8, r0
	mov r0, r7
	str r3, [sp]
	mov r8, ip, lsl #0x10
	mov r9, r2, lsl #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r7, #0x24]
	ldr r1, =0x00003FFF
	add r0, r3, r0
	ldrh r10, [r5, #0x58]
	add r2, r1, #0x4000
	sub r0, r0, #0x16000
	mov r3, r10, asr #2
	add r3, r0, r3, lsl #16
	and r0, r2, r8, lsr #16
	and r1, r1, r9, lsr #16
	add r0, r3, r0
	add r0, r1, r0
	str r0, [sp, #8]
	ldrh r0, [r5, #0x58]
	tst r0, #1
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldrh r0, [r5, #0x58]
	add r0, r0, #1
	strh r0, [r5, #0x58]
	b _02168788
_02168538:
	cmp r8, #0
	rsblt r8, r8, #0
	mov r3, #0
	umull r9, r2, r8, r5
	mla r2, r8, r3, r2
	adds r3, r9, #0x800
	mov r8, r8, asr #0x1f
	mla r2, r8, r5, r2
	ldr r1, =_obj_disp_rand
	mov r5, #0x800
	ldr r10, [r1, #0]
	ldr r8, =0x00196225
	ldr r9, =0x3C6EF35F
	ldr r11, =_0218B9AC
	mov r0, r0, lsl #1
	ldrh r0, [r11, r0]
	mla r11, r10, r8, r9
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	mla r2, r11, r8, r9
	add r3, r3, #0x10
	mov r8, r2, lsr #0x10
	mul r0, r3, r0
	mov r9, r11, lsr #0x10
	mov r3, r9, lsl #0x10
	sub r5, r5, #1
	and r3, r5, r3, lsr #16
	add r3, r3, #0x800
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r3, r5, lsr #0xc
	orr r3, r3, r0, lsl #20
	mov r8, r8, lsl #0x10
	mov r0, r7
	str r3, [sp]
	str r2, [r1]
	mov r5, r8, lsr #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r2, =_obj_disp_rand
	ldr r1, [r7, #0x24]
	ldr r3, [r2, #0]
	add r8, r1, r0
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	sub r8, r8, #0x10000
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r3, r5, lsl #0x12
	mov r0, r0, lsl #0x10
	sub r3, r8, r3, lsr #13
	mov r0, r0, lsr #0x10
	str r3, [sp, #8]
	str r1, [r2]
	tst r0, #1
	beq _02168788
	ldr r0, [sp]
	rsb r0, r0, #0
	str r0, [sp]
	b _02168788
_0216862C:
	cmp r6, #1
	beq _021686AC
	ldr r1, =_obj_disp_rand
	mov r2, #0
	ldr r10, [r1, #0]
	ldr r8, =0x00196225
	ldr r9, =0x3C6EF35F
	ldr r3, =_0218B9AC
	mla r5, r10, r8, r9
	mov r10, r5, lsr #0x10
	mov r0, r0, lsl #1
	mla r8, r5, r8, r9
	mov r5, r10, lsl #0x10
	mov r5, r5, lsr #0x10
	and r9, r5, #0xfe
	mov r5, r8, lsr #0x10
	mov r5, r5, lsl #0x10
	ldrh r10, [r3, r0]
	rsb r3, r9, #0x7f
	mov r0, r7
	mul r3, r10, r3
	str r3, [sp]
	str r2, [sp, #4]
	str r8, [r1]
	mov r5, r5, lsr #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r2, [r7, #0x24]
	mov r1, r5, lsl #0x11
	add r0, r2, r0
	sub r0, r0, r1, lsr #13
	str r0, [sp, #8]
	b _02168788
_021686AC:
	ldr r1, =_obj_disp_rand
	ldr r3, =0x00196225
	ldr r2, [r1, #0]
	ldr r11, =0x3C6EF35F
	mov ip, r0, lsl #1
	mla r10, r2, r3, r11
	mla r9, r10, r3, r11
	mla r2, r9, r3, r11
	mla r3, r2, r3, r11
	str r10, [r1]
	ldrh r8, [r5, #0x58]
	mov r10, r10, lsr #0x10
	mov r0, r10, lsl #0x10
	and r11, r8, #3
	mov r8, r2, lsr #0x10
	mov r10, r0, lsr #0x10
	ldr lr, =_0218B9AC
	mov r9, r9, lsr #0x10
	str r3, [r1]
	mov r1, r9, lsl #0x10
	ldr r0, =0x00007FFE
	mov r2, r3, lsr #0x10
	and r3, r0, r1, lsr #16
	ldrh r1, [lr, ip]
	rsb r11, r11, r11, lsl #5
	and r9, r10, #7
	add r9, r11, r9
	rsb r0, r3, r0, lsr #1
	mla r3, r1, r9, r0
	mov r0, r7
	str r3, [sp]
	mov r8, r8, lsl #0x10
	mov r9, r2, lsl #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r7, #0x24]
	ldr r1, =0x00003FFF
	add r0, r3, r0
	ldrh r10, [r5, #0x58]
	add r2, r1, #0x4000
	sub r0, r0, #0x16000
	mov r3, r10, asr #2
	add r3, r0, r3, lsl #16
	and r0, r2, r8, lsr #16
	and r1, r1, r9, lsr #16
	add r0, r3, r0
	add r0, r1, r0
	str r0, [sp, #8]
	ldrh r0, [r5, #0x58]
	tst r0, #1
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldrh r0, [r5, #0x58]
	add r0, r0, #1
	strh r0, [r5, #0x58]
_02168788:
	ldrsh r0, [r7, #0xa]
	cmp r0, #0
	ldrgt r0, [sp]
	rsbgt r0, r0, #0
	strgt r0, [sp]
	ldrsh r0, [r7, #0xa]
	cmp r0, #0
	bne _021687DC
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [sp]
	str r1, [r2]
	rsbne r0, r0, #0
	strne r0, [sp]
_021687DC:
	add r1, sp, #0
	mov r0, #0x21
	bl SailEventManager__CreateObject
	mov r1, r0
	cmp r6, #1
	moveq r0, #1
	streq r0, [r1, #0x38]
	mov r0, r4
	bl NNS_FndAppendListObject
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

StageTask *CreateSailIce(SailEventManagerObject *mapObject)
{
    StageTask *work;
    SailObject *worker;
    fx32 scale;
    u16 radius;
    u16 anim;

    anim   = 1;
    radius = 96;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    if (SailManager__GetShipType() == SHIP_BOAT)
        radius = 12;

    if (MATH_ABS(mapObject->voyagePosition.x) > radius * _0218B9AC[SailManager__GetShipType()])
    {
        anim = ObjDispRandRepeat(2);
    }

    ObjAction3dNNModelLoad(work, NULL, "sb_ice.nsbmd", anim, GetObjectFileWork(OBJDATAWORK_33), SailManager__GetArchive());
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);

    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->userFlag |= SAILOBJECT_FLAG_40000 | SAILOBJECT_FLAG_80000;

    scale = work->scale.x;
    if (SailManager__GetShipType() != SHIP_BOAT)
    {
        if (MATH_ABS(mapObject->voyagePosition.x) > 96 * _0218B9AC[SailManager__GetShipType()])
        {
            work->scale.x = MultiplyFX(scale, 0xD00 + ObjDispRandRange4(0x100, 0x300));
            work->scale.y = MultiplyFX(scale, 0xD00 + ObjDispRandRange4(0x100, 0x300));
            work->scale.z = MultiplyFX(scale, 0xD00 + ObjDispRandRange4(0x100, 0x300));
        }
        else
        {
            work->scale.x = MultiplyFX(scale, 0x1100 + ObjDispRandRange4(0x100, 0x300));
            work->scale.y = MultiplyFX(scale, 0x400);
            work->scale.z = MultiplyFX(scale, 0x1100 + ObjDispRandRange4(0x100, 0x300));
        }
    }
    else
    {
        work->scale.x = MultiplyFX(scale, 0xB00 + ObjDispRandRange4(0x100, 0x300));
        work->scale.y = MultiplyFX(scale, 0x580 + ObjDispRandRange4(0x100, 0x300));
        work->scale.z = MultiplyFX(scale, 0xB00 + ObjDispRandRange4(0x100, 0x300));

        if (anim == 0)
        {
            work->scale.y = MultiplyFX(scale, 0x800 + ObjDispRandRange4(0x100, 0x300));
        }
        else
        {
            VecFx32 pos;
            pos.x = FLOAT_TO_FX32(0.0);
            pos.y = -FLOAT_TO_FX32(1.0);
            pos.z = FLOAT_TO_FX32(0.0);

            SailObject_SetCollisionOffset(work, &pos);
        }

        SailObject_InitColliderForCommon(work, worker->collider, 0);
        SailObject_InitColliderForObject(work, 0);
        SailObject_InitColliderBox(work, 0, 0x4200, 0);
        work->flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        worker->maxHealth = FLOAT_TO_FX32(100.0);
        worker->health    = FLOAT_TO_FX32(100.0);
        worker->score     = 500;
    }

    work->dir.y = ObjDispRand();

    SailObject_ApplyRotation(work);
    StageTask__InitSeqPlayer(work);

    SetTaskState(work, SailIce_State_Oscillate);

    return work;
}

NONMATCH_FUNC void CreateSailIceForSegment(SailVoyageSegment *voyageSegment, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r8, r0
	mov r7, r1
	bl SailManager__GetWork
	ldr r4, [r0, #0xa0]
	add r1, sp, #0
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	str r0, [r1, #8]
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl SailManager__GetWork
	mov r6, r0
	cmp r5, #0
	beq _02168CD4
	cmp r5, #1
	beq _02168E18
	cmp r5, #2
_02168CD4:
	cmp r7, #0
	ldr r9, =0x3C6EF35F
	beq _02168DA0
	ldr r3, =_obj_disp_rand
	ldr r2, =0x00196225
	ldr r0, [r3, #0]
	ldr r1, =_0218B9AC
	mla r11, r0, r2, r9
	mla r10, r11, r2, r9
	str r11, [r3]
	mla r9, r10, r2, r9
	ldrh r0, [r6, #0x58]
	mov r2, r5, lsl #1
	mov r11, r11, lsr #0x10
	mov r5, r11, lsl #0x10
	mov r11, r5, lsr #0x10
	ldrh r1, [r1, r2]
	mov r2, r0, lsl #0x1e
	and r0, r11, #0x3f
	add r0, r0, r2, lsr #24
	mul r2, r1, r0
	mov r5, r9, lsr #0x10
	mov r10, r10, lsr #0x10
	str r9, [r3]
	mov r0, r8
	str r2, [sp]
	mov r9, r10, lsl #0x10
	mov r5, r5, lsl #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r8, #0x24]
	ldr r1, =0x00001FFF
	add r0, r3, r0
	ldrh r10, [r6, #0x58]
	add r2, r1, #0x2000
	sub r0, r0, #0x16000
	mov r3, r10, asr #2
	add r3, r0, r3, lsl #15
	and r0, r2, r9, lsr #16
	and r1, r1, r5, lsr #16
	add r0, r3, r0
	add r0, r1, r0
	str r0, [sp, #8]
	ldrh r0, [r6, #0x58]
	tst r0, #1
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldrh r0, [r6, #0x58]
	add r0, r0, #1
	strh r0, [r6, #0x58]
	b _02168E0C
_02168DA0:
	ldr r10, =_obj_disp_rand
	ldr r6, =0x00196225
	ldr r1, [r10, #0]
	ldr r0, =_0218B9AC
	mla r2, r1, r6, r9
	mov r3, r2, lsr #0x10
	mov r1, r5, lsl #1
	mla r5, r2, r6, r9
	mov r3, r3, lsl #0x10
	mov r2, r3, lsr #0x10
	ldrh r6, [r0, r1]
	and r3, r2, #0x7f
	add r1, r3, #0x60
	mul r1, r6, r1
	mov r2, r5, lsr #0x10
	mov r2, r2, lsl #0x10
	str r5, [r10]
	mov r0, r8
	str r1, [sp]
	mov r5, r2, lsr #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r2, [r8, #0x24]
	mov r1, r5, lsl #0x12
	add r0, r2, r0
	sub r0, r0, #0x10000
	sub r0, r0, r1, lsr #13
	str r0, [sp, #8]
_02168E0C:
	mov r0, #0
	str r0, [sp, #4]
	b _02168FB8
_02168E18:
	cmp r7, #0
	ldr r10, =0x3C6EF35F
	beq _02168EFC
	ldr r1, =_obj_disp_rand
	ldr r3, =0x00196225
	ldr r0, [r1, #0]
	ldr r11, =_0218B9AC
	mla r9, r0, r3, r10
	mla r2, r9, r3, r10
	mla r0, r2, r3, r10
	mla r3, r0, r3, r10
	str r9, [r1]
	mov ip, r9, lsr #0x10
	ldrh r9, [r6, #0x58]
	mov r10, r5, lsl #1
	mov r5, ip, lsl #0x10
	mov ip, r2, lsr #0x10
	mov lr, r5, lsr #0x10
	mov r5, r0, lsr #0x10
	str r3, [r1]
	ldr r0, =0x00007FFE
	mov r1, ip, lsl #0x10
	mov r2, r3, lsr #0x10
	and r3, r0, r1, lsr #16
	ldrh r1, [r11, r10]
	mov r10, r9, lsl #0x1e
	and r9, lr, #7
	add r9, r9, r10, lsr #27
	rsb r0, r3, r0, lsr #1
	mla r3, r1, r9, r0
	mov r0, r8
	str r3, [sp]
	mov r5, r5, lsl #0x10
	mov r9, r2, lsl #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r8, #0x24]
	ldr r1, =0x00003FFF
	add r0, r3, r0
	ldrh r10, [r6, #0x58]
	add r2, r1, #0x4000
	sub r0, r0, #0x16000
	mov r3, r10, asr #2
	add r3, r0, r3, lsl #16
	and r0, r2, r5, lsr #16
	and r1, r1, r9, lsr #16
	add r0, r3, r0
	add r0, r1, r0
	str r0, [sp, #8]
	ldrh r0, [r6, #0x58]
	tst r0, #1
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldrh r0, [r6, #0x58]
	add r0, r0, #1
	strh r0, [r6, #0x58]
	b _02168FB8
_02168EFC:
	ldrsh r6, [r8, #0xa]
	ldr r1, =_obj_disp_rand
	mov r3, #0xb
	cmp r6, #0
	rsblt r6, r6, #0
	mov r2, #0
	umull r9, r0, r6, r3
	mla r0, r6, r2, r0
	adds r2, r9, #0x800
	mov r6, r6, asr #0x1f
	mla r0, r6, r3, r0
	ldr r11, [r1, #0]
	ldr r9, =0x00196225
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	mov r0, r5, lsl #1
	ldr ip, =_0218B9AC
	mla r5, r11, r9, r10
	add r3, r2, #0x10
	mla r2, r5, r9, r10
	ldrh r0, [ip, r0]
	mov r10, r5, lsr #0x10
	mov r5, r2, lsr #0x10
	mul r0, r3, r0
	mov r6, #0x800
	mov r9, r5, lsl #0x10
	mov r3, r10, lsl #0x10
	sub r5, r6, #1
	and r3, r5, r3, lsr #16
	add r3, r3, #0x800
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r3, r5, lsr #0xc
	orr r3, r3, r0, lsl #20
	mov r0, r8
	str r3, [sp]
	str r2, [r1]
	mov r5, r9, lsr #0x10
	bl SailVoyageManager__GetSegmentSize
	ldr r2, [r8, #0x24]
	mov r1, r5, lsl #0x12
	add r0, r2, r0
	sub r0, r0, #0x10000
	sub r0, r0, r1, lsr #13
	str r0, [sp, #8]
_02168FB8:
	ldrsh r0, [r8, #0xa]
	cmp r0, #0
	ldrgt r0, [sp]
	rsbgt r0, r0, #0
	strgt r0, [sp]
	cmp r7, #0
	ldreqsh r0, [r8, #0xa]
	cmpeq r0, #0
	bne _02169010
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [sp]
	str r1, [r2]
	rsbne r0, r0, #0
	strne r0, [sp]
_02169010:
	add r1, sp, #0
	mov r0, #0x22
	bl SailEventManager__CreateObject
	mov r1, r0
	mov r0, r4
	bl NNS_FndAppendListObject
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

StageTask *CreateSailFish(SailEventManagerObject *mapObject)
{
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    s32 anim = ObjDispRandRepeat(8) + ObjDispRandRepeat(2);
    ObjAction3dNNModelLoad(work, NULL, "sb_sub_fish.nsbmd", (u16)anim, GetObjectDataWork(OBJDATAWORK_34), SailManager__GetArchive());
    SailObject_InitCommon(work);
    SailObject_InitFromMapObject(work, mapObject);
    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    fx32 scale    = work->scale.x;
    scale         = MultiplyFX(scale, FLOAT_TO_FX32(0.5) + ObjDispRandRange(-0x100, 0x100));
    work->scale.x = scale;
    work->scale.y = scale;
    work->scale.z = scale;

    SailFish_Action_Init(work);

    return work;
}

StageTask *CreateSailIslandFish(StageTask *parent)
{
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    s32 anim = ObjDispRandRepeat(8) + ObjDispRandRepeat(2);
    ObjAction3dNNModelLoad(work, NULL, "sb_sub_fish.nsbmd", (u16)anim, GetObjectDataWork(OBJDATAWORK_34), SailManager__GetArchive());
    SailObject_InitCommon(work);
    StageTask__SetParent(work, parent, 0);
    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    OBS_ACTION3D_NN_WORK *animator = work->obj_3d;
    fx32 scale                     = animator->ani.work.scale.x;
    scale                          = MultiplyFX(scale, ObjDispRandRange2(FLOAT_TO_FX32(0.75), FLOAT_TO_FX32(0.875)));
    animator->ani.work.scale.z = animator->ani.work.scale.y = animator->ani.work.scale.x = scale;

    SailIslandFish_Action_Init(work);

    return work;
}

void CreateSailFishForSegment(SailVoyageSegment *voyageSegment)
{
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    VecFx32 position = { 0 };

    u16 shipType = SailManager__GetShipType();

    position.x = _0218B9AC[shipType] * ObjDispRandRange(-128, 128);
    position.y = _0218B9B4[shipType] * ObjDispRandRange3(15, 64);
    position.z = voyageSegment->field_24 + SailVoyageManager__GetSegmentSize(voyageSegment) - ((u16)(2 * ObjDispRand()) * 8);

    if (voyageSegment->targetSeaAngle > 0)
    {
        position.x = -position.x;
    }

    if (voyageSegment->targetSeaAngle == 0)
    {
        if (ObjDispRandRepeat(2) != 0)
            position.x = -position.x;
    }

    NNS_FndAppendListObject(&eventManager->stageObjectList, SailEventManager__CreateObject(SAILMAPOBJECT_36, &position));
}

void CreateSailFishForDestination(StageTask *parent)
{
    u16 i;
    u16 count;

    SailManager *manager = SailManager__GetWork();
    UNUSED(manager);

    count = ObjDispRandRange2(2, 10);
    for (i = 0; i < count; i++)
    {
        CreateSailIslandFish(parent);
    }
}

StageTask *CreateSailGoalChaosEmerald(fx32 voyagePosZ)
{
    StageTask *work;
    SailObject *worker;

    SailManager *manager = SailManager__GetWork();

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_EFFECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjAction3dNNModelLoad(work, NULL, "sb_chaos.nsbmd", manager->rivalRaceID, GetObjectFileWork(OBJDATAWORK_102), SailManager__GetArchive());
    SailObject_InitCommon(work);

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    worker->voyagePosition.z = voyagePosZ;
    worker->voyagePosition.y = -FLOAT_TO_FX32(1.953125);

    SailObject_HandleVoyageVelocity(work);
    SailGoalChaosEmerald_Action_Init(work);
    return work;
}

StageTask *CreateSailGoal(fx32 radius)
{
    StageTask *work;
    SailObject *worker;

    SailManager *manager = SailManager__GetWork();

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_EFFECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjAction3dNNModelLoad(work, NULL, "sb_goal.nsbmd", 0, GetObjectFileWork(OBJDATAWORK_46), SailManager__GetArchive());
    ObjAction3dNNMotionLoad(work, NULL, "sb_goal.nsbca", GetObjectFileWork(OBJDATAWORK_47), SailManager__GetArchive());
    AnimatorMDL__SetAnimation(&work->obj_3d->ani, 0, work->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], 0, 0);
    SailObject_SetAnimSpeed(work, FLOAT_TO_FX32(2.0));
    work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->obj_3d->ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->obj_3d->ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    SailObject_InitCommon(work);
    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    worker->voyagePosition.z = radius;
    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
        default:
            worker->voyagePosition.y = -FLOAT_TO_FX32(1.953125);
            break;

        case SHIP_BOAT:
            worker->voyagePosition.y = -FLOAT_TO_FX32(8.0);
            break;

        case SHIP_SUBMARINE:
            worker->voyagePosition.y = -FLOAT_TO_FX32(22.0);
            break;
    }

    SailObject_HandleVoyageVelocity(work);

    if (!manager->isRivalRace)
    {
        fx32 scale = MultiplyFX(work->scale.x, FLOAT_TO_FX32(2.0));

        work->scale.x = scale;
        work->scale.y = scale;
        work->scale.z = scale;
    }

    SailGoal_Action_Init(work);

    return work;
}

StageTask *CreateSailGoalText(fx32 voyagePosZ)
{
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_EFFECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjObjectAction3dBACLoad(work, NULL, "/sb_cldm_goal.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_49), SailManager__GetArchive());
    SailObject_InitCommon(work);
    work->obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    SailObject_InitCommon(work);
    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    worker->voyagePosition.z = voyagePosZ - FLOAT_TO_FX32(1.0);
    work->userWork           = voyagePosZ;

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
        default:
            worker->voyagePosition.y = -FLOAT_TO_FX32(1.953125);
            break;

        case SHIP_BOAT:
            worker->voyagePosition.y = -FLOAT_TO_FX32(8.0);
            break;

        case SHIP_SUBMARINE:
            worker->voyagePosition.y = -FLOAT_TO_FX32(22.0);
            break;
    }

    SailObject_HandleVoyageVelocity(work);
    SailGoalText_Action_Init(work);

    return work;
}

StageTask *CreateSailItemBox(SailEventManagerObject *mapObject)
{
    StageTask *work;
    SailObject *worker;

    SailManager *manager = SailManager__GetWork();

    work = CreateStageTaskSimpleEx(TASK_PRIORITY_UPDATE_LIST_START + 0x1001, TASK_GROUP(1));
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));

    ObjObjectAction3dBACLoad(work, NULL, "sb_item.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_37), SailManager__GetArchive());
    SailObject_InitCommon(work);

    SailObject_InitFromMapObject(work, mapObject);

    work->position.y -= FLOAT_TO_FX32(1.0);
    work->userFlag |= SAILOBJECT_FLAG_10000;

    work->userWork = mapObject->viewRange;
    if (work->userWork > 16)
        work->userWork = 0;

    if (manager->missionType == MISSION_TYPE_REACH_GOAL && work->userWork <= 3)
        work->userWork = 11;

    StageTask__SetAnimation(work, (work->userWork >> 2) + 1);
    worker->score                             = 500;
    work->obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    SailObject_InitColliderForCommon(work, worker->collider, 0);
    SailObject_InitColliderBox(work, 0, 0x900, 0);

    OBS_RECT_WORK *collider = StageTask__GetCollider(work, 0);
    collider->hitPower      = OBS_RECT_HITPOWER_VULNERABLE;
    collider->defPower      = OBS_RECT_DEFPOWER_VULNERABLE;

    if (SailManager__GetShipType() == SHIP_BOAT)
        worker->collider[0].hitCheck.box.size.x = FLOAT_TO_FX32(2.5);

    CreateSailItemBoxCase(work);
    StageTask__InitSeqPlayer(work);

    return work;
}

StageTask *CreateSailItemBoxCase(StageTask *parent)
{
    StageTask *work;
    SailObject *worker;

    work = CreateStageTaskSimpleEx(TASK_PRIORITY_UPDATE_LIST_START + 0x1001, TASK_GROUP(1));
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_OBJECT);

    worker = StageTask__AllocateWorker(work, sizeof(SailObject));
    UNUSED(worker);

    ObjObjectAction3dBACLoad(work, NULL, "sb_item.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_37), SailManager__GetArchive());
    SailObject_InitCommon(work);
    work->userFlag |= SAILOBJECT_FLAG_1;

    work->position = parent->position;
    StageTask__SetParent(work, parent, 1024);

    work->obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    work->obj_2dIn3d->ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    if (SailManager__GetShipType() == SHIP_SUBMARINE)
    {
        work->scale.x = FLOAT_TO_FX32(0.15625);
        work->scale.y = FLOAT_TO_FX32(0.15625);
        work->scale.z = FLOAT_TO_FX32(0.15625);
    }

    return work;
}

StageTask *CreateSailItemBoxRewardText(StageTask *parent, u32 type)
{
    StageTask *work = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_EFFECT);

    ObjObjectAction3dBACLoad(work, NULL, "sb_logo_fix.bac", 1024, 16, GetObjectFileWork(OBJDATAWORK_41), SailManager__GetArchive());
    StageTask__SetAnimation(work, type + 4);
    SailObject_InitCommon(work);
    work->userFlag |= SAILOBJECT_FLAG_1;
    work->displayFlag |= DISPLAY_FLAG_DRAW_3D_SPRITE_AS_2D;

    VecFx32 worldPos = parent->position;
    worldPos.y       = -worldPos.y;

    int px;
    int py;
    NNS_G3dWorldPosToScrPos(&worldPos, &px, &py);
    work->position.x = FX32_FROM_WHOLE(px);
    work->position.y = FX32_FROM_WHOLE(py);

    work->scale.x = FLOAT_TO_FX32(1.0);
    work->scale.y = FLOAT_TO_FX32(1.0);
    work->scale.z = FLOAT_TO_FX32(1.0);
    work->position.y -= FLOAT_TO_FX32(20.0);
    work->velocity.y = -FLOAT_TO_FX32(1.0);

    SetTaskState(work, SailItemBoxRewardText_State_Active);

    return work;
}

void SailObject_Destructor(Task *task)
{
    StageTask *work    = TaskGetWork(task, StageTask);
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    ObjDraw__PaletteTex__Release(&worker->paletteTex);

    if (worker->objectRef && (worker->objectRef->flags & SAILMAPOBJECT_FLAG_20000000) == 0)
        SailEventManager__RemoveEntry(worker->objectRef);

    StageTask_Destructor(task);
}

BOOL SailObject_ViewCheck_Default(StageTask *work)
{
    s32 range          = 0;
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    if ((work->flag & STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT) != 0)
        return FALSE;

    if (worker->objectRef != NULL)
    {
        if ((worker->objectRef->flags & SAILMAPOBJECT_FLAG_40000000) != 0)
            range = worker->objectRef->viewRange;
    }

    return SailEventManager__ViewCheck(&work->position, range) != FALSE;
}

void SailObject_OnDefend_Default(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SailColliderWork *collider2;
    SailColliderWork *collider1;

    StageTask *effectHit;
    SailObject *worker2;

    collider1 = rect1->userData;
    collider2 = rect2->userData;

    worker2 = GetStageTaskWorker(collider2->stageTask, SailObject);

    effectHit = NULL;

    if ((SailManager__GetShipType() == SHIP_SUBMARINE && collider1->stageTask->objType == SAILSTAGE_OBJ_TYPE_EFFECT) && collider1->stageTask->userFlag != SAILOBJECT_FLAG_NONE
        && GetStageTaskWorker(collider1->stageTask, SailObject)->player != collider2->stageTask)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else if (worker2->invincibleTimer != 0 && (collider1->flags & SAILCOLLIDER_FLAG_40) != 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        VecFx32 hitPosition;
        if ((collider1->flags & SAILCOLLIDER_FLAG_1000) == 0 && collider1->stageTask->objType == SAILSTAGE_OBJ_TYPE_OBJECT)
        {
            rect2->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;

            if (collider1->stageTask != collider2->stageTask)
            {
                VecFx32 hitNormal;

                VEC_Subtract(&collider2->stageTask->position, &collider1->stageTask->position, &hitNormal);

                if ((hitNormal.x | hitNormal.z | hitNormal.y) == 0)
                {
                    hitNormal.x = FLOAT_TO_FX32(1.0);
                    hitNormal.y = FLOAT_TO_FX32(0.0);
                    hitNormal.z = FLOAT_TO_FX32(0.0);
                }
                else
                {
                    VEC_Normalize(&hitNormal, &hitNormal);
                }

                hitNormal.x = -hitNormal.x;

                hitNormal.y = FLOAT_TO_FX32(0.0);
                hitNormal.x = MultiplyFX(FLOAT_TO_FX32(0.25), hitNormal.x);
                hitNormal.z = MultiplyFX(FLOAT_TO_FX32(0.25), hitNormal.z);

                VEC_Add(&collider2->stageTask->position, &hitNormal, &collider2->stageTask->position);
                VEC_Add(&worker2->voyagePosition, &hitNormal, &worker2->voyagePosition);
            }
        }
        else
        {
            hitPosition = collider2->hitCheck.box.hitPosition;

            if (collider1->type == SAILCOLLIDER_TYPE_LINE)
            {
                VecFx32 lineDir;
                lineDir   = collider1->hitCheck.line.direction;
                lineDir.y = -lineDir.y;

                VEC_MultAdd(collider2->hitCheck.box.size.x * -4, &lineDir, &hitPosition, &hitPosition);
            }

            if ((collider1->flags & SAILCOLLIDER_FLAG_8000) != 0 && collider1->stageTask != NULL)
            {
                hitPosition = collider1->stageTask->prevPosition;
            }

            if ((collider1->flags & SAILCOLLIDER_FLAG_4) == 0)
            {
                if ((collider2->flags & SAILCOLLIDER_FLAG_20) != 0 && (collider1->flags & SAILCOLLIDER_FLAG_10) != 0)
                    effectHit = EffectSailGuard__Create(&hitPosition);
                else
                    effectHit = EffectSailHit__Create(&hitPosition);
            }

            if (effectHit != NULL)
            {
                if ((collider1->flags & SAILCOLLIDER_FLAG_1) != 0)
                {
                    fx32 scale = MultiplyFX(effectHit->scale.x, FLOAT_TO_FX32(0.5));

                    effectHit->scale.x = scale;
                    effectHit->scale.y = scale;
                    effectHit->scale.z = scale;
                }
                else if ((collider1->flags & SAILCOLLIDER_FLAG_2) != 0)
                {
                    fx32 scale = MultiplyFX(effectHit->scale.x, FLOAT_TO_FX32(0.25));

                    effectHit->scale.x = scale;
                    effectHit->scale.y = scale;
                    effectHit->scale.z = scale;
                }

                if (collider1->type == SAILCOLLIDER_TYPE_LINE)
                    effectHit->userFlag &= ~SAILOBJECT_FLAG_1;
            }

            if (worker2->collidedObj == NULL || worker2->collidedObj != collider1->stageTask)
            {
                worker2->collidedObj = collider1->stageTask;

                if ((collider2->flags & SAILCOLLIDER_FLAG_20) != 0 && (collider1->flags & SAILCOLLIDER_FLAG_10) != 0)
                {
                    if (worker2->healthBar == NULL)
                        worker2->healthBar = SailEnemyHealthBar__Create(collider2->stageTask);

                    SailAudio__PlaySpatialSequence(collider2->stageTask->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_RICOCHET, &hitPosition);
                }
                else
                {
                    fx32 atkPower = collider1->atkPower;

                    if ((collider1->flags & SAILCOLLIDER_FLAG_40) == 0 && (collider2->stageTask->userFlag & SAILOBJECT_FLAG_20) != 0)
                    {
                        atkPower >>= 2;
                        if (atkPower > FLOAT_TO_FX32(1.0))
                            atkPower = FLOAT_TO_FX32(1.0);
                    }

                    if (collider1->flags & SAILCOLLIDER_FLAG_40)
                    {
                        worker2->invincibleTimer = 4;
                        if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_80000) != 0)
                            atkPower *= 4;
                    }

                    if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_200000) != 0 && atkPower < FLOAT_TO_FX32(60.0))
                        atkPower = FLOAT_TO_FX32(1.0);

                    if ((collider1->flags & SAILCOLLIDER_FLAG_400) == 0)
                    {
                        collider1->stageTask->shakeTimer   = FLOAT_TO_FX32(4.0);
                        collider1->stageTask->hitstopTimer = FLOAT_TO_FX32(2.0);
                    }

                    if ((collider1->flags & SAILCOLLIDER_FLAG_40) == 0)
                        collider2->stageTask->hitstopTimer = FLOAT_TO_FX32(2.0);

                    collider2->stageTask->shakeTimer = FLOAT_TO_FX32(4.0);

                    if ((collider1->flags & SAILCOLLIDER_FLAG_800) == 0 && (SailManager__GetShipType() == SHIP_JET || SailManager__GetShipType() == SHIP_HOVER))
                    {
                        ShakeScreen(SCREENSHAKE_C_SHORT);
                    }

                    if (SailManager__GetShipType() == SHIP_BOAT)
                    {
                        if ((collider1->flags & SAILCOLLIDER_FLAG_10) != 0)
                        {
                            SailAudio__PlaySpatialSequence(collider2->stageTask->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BULLET_HIT, &hitPosition);
                        }
                        else if ((collider1->flags & SAILCOLLIDER_FLAG_40) != 0)
                        {
                            SailAudio__PlaySpatialSequence(collider2->stageTask->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BULLET_HIT, &hitPosition);
                        }
                        else if ((collider1->flags & SAILCOLLIDER_FLAG_8000) != 0)
                        {
                            SailAudio__PlaySpatialSequence(collider2->stageTask->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CANNON_BOMB, &hitPosition);
                        }

                        SailObject_GivePlayerScore(rect1, rect2, 10);
                    }

                    if (SailManager__GetShipType() == SHIP_HOVER)
                    {
                        if ((collider1->flags & SAILCOLLIDER_FLAG_10) != 0)
                            SailAudio__PlaySpatialSequence(collider2->stageTask->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BULLET_HIT, &hitPosition);

                        SailObject_GivePlayerScore(rect1, rect2, 10);
                    }

                    if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_100000) == 0)
                    {
                        worker2->health -= atkPower;

                        if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_10000) != 0)
                        {
                            SailItemBox_GiveItem(collider2->stageTask, collider1->stageTask);
                        }
                        else if (worker2->health <= 0)
                        {
                            SailObject_Action_Destroy(collider2->stageTask);

                            if (SailManager__GetShipType() == SHIP_HOVER && collider1->stageTask->objType == SAILSTAGE_OBJ_TYPE_EFFECT)
                            {
                                collider2->stageTask->userTimer = 12;
                            }
                            else if (SailManager__GetShipType() == SHIP_HOVER || SailManager__GetShipType() == SHIP_JET)
                            {
                                SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_SPLASH, NULL);
                            }
                        }
                        else
                        {
                            if (worker2->healthBar == NULL)
                                worker2->healthBar = SailEnemyHealthBar__Create(collider2->stageTask);

                            worker2->blinkTimer = 4;
                        }
                    }

                    SailObject_OnPlayerCollide(rect1, rect2);
                }
            }
        }
    }
}

void SailObject_GivePlayerScore(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2, u32 score)
{
    SailPlayer *player = NULL;

    SailColliderWork *collider = rect1->userData;
    StageTask *work            = collider->stageTask;

    if (work->objType == SAILSTAGE_OBJ_TYPE_PLAYER)
    {
        player = GetStageTaskWorker(work, SailPlayer);
    }
    else
    {
        if (work->parentObj != NULL && work->parentObj->objType == SAILSTAGE_OBJ_TYPE_PLAYER)
            player = GetStageTaskWorker(work->parentObj, SailPlayer);
    }

    if (player != NULL)
    {
        player->score += score;
        if (player->score > SAILPLAYER_MAX_SCORE)
            player->score = SAILPLAYER_MAX_SCORE;
    }
}

void SailObject_OnPlayerCollide(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SailColliderWork *collider2;
    SailColliderWork *collider1;

    SailObject *worker;
    SailPlayer *player;

    collider1 = rect1->userData;
    collider2 = rect2->userData;

    player = NULL;

    worker = GetStageTaskWorker(collider2->stageTask, SailObject);

    if (collider1->stageTask->objType == SAILSTAGE_OBJ_TYPE_PLAYER)
    {
        player = GetStageTaskWorker(collider1->stageTask, SailPlayer);
    }
    else
    {
        StageTask *parent = collider1->stageTask->parentObj;
        if (parent != NULL && parent->objType == SAILSTAGE_OBJ_TYPE_PLAYER)
            player = GetStageTaskWorker(parent, SailPlayer);
    }

    if (player != NULL)
    {
        switch (SailManager__GetShipType())
        {
            case SHIP_JET:
            case SHIP_HOVER:
                player->trickFinishTimer = 80;
                player->missedRingCount  = 0;
                // fallthrough

            case SHIP_BOAT:
            case SHIP_SUBMARINE:
                player->scoreComboCurrent++;
                if (player->scoreComboCurrent > SAILPLAYER_MAX_SCORE_COMBO)
                    player->scoreComboCurrent = SAILPLAYER_MAX_SCORE_COMBO;

                if (player->scoreComboBest < player->scoreComboCurrent)
                    player->scoreComboBest = player->scoreComboCurrent;

                if ((collider1->flags & SAILCOLLIDER_FLAG_10) == 0 && (collider1->flags & SAILCOLLIDER_FLAG_40) == 0)
                    player->field_1B4++;
                break;
        }

        if (worker->health <= 0)
        {
            u16 multiplier       = 1;
            SailManager *manager = SailManager__GetWork();

            multiplier += FX_DivS32(player->scoreComboCurrent, 50);

            if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_1000) != 0)
                worker->score += (worker->score >> 1);

            if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_2000) != 0)
                worker->score += worker->score;

            player->score += worker->score * multiplier;
            if (player->score > SAILPLAYER_MAX_SCORE)
                player->score = SAILPLAYER_MAX_SCORE;

            VecFx32 position = collider2->stageTask->position;
            position.y       = -position.y;
            position.y += worker->collisionOffset.y + worker->collider[0].hitCheck.box.size.x;

            if (SailManager__GetShipType() == SHIP_HOVER)
                position.y += FLOAT_TO_FX32(1.0);

            if (multiplier > 9)
                multiplier = 9;

            SailScoreBonus__CreateWorld(&position, worker->score, multiplier);
            if ((collider2->stageTask->userFlag & SAILOBJECT_FLAG_800000) == 0)
                player->enemyDefeatCount++;

            switch (SailManager__GetShipType())
            {
                case SHIP_HOVER:
                    if ((collider1->flags & SAILCOLLIDER_FLAG_10) != 0)
                    {
                        player->field_1B0++;
                    }
                    else if ((collider1->flags & SAILCOLLIDER_FLAG_2000) != 0 && rect2->defPower >= 11)
                    {
                        player->field_1B2++;
                    }
                    else
                    {
                        player->field_1B1++;
                    }
                    break;

                case SHIP_BOAT:
                    if ((collider1->flags & SAILCOLLIDER_FLAG_10) != 0)
                        player->field_1B3++;
                    break;
            }

            if (worker->objectRef != NULL)
            {
                if ((worker->objectRef->flags & SAILMAPOBJECT_FLAG_20000000) == 0 && worker->objectRef->type < SAILMAPOBJECT_29)
                {
                    if ((worker->objectRef->flags & SAILMAPOBJECT_FLAG_80) == 0 && worker->objectRef->word32 == manager->field_60)
                        manager->field_5E++;
                }
            }
        }
    }
}

void SailIsland_State_Other(StageTask *work)
{
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    for (u16 i = 0; i < voyageManager->visibleIslandCount; i++)
    {
        if (work->userTimer == voyageManager->visibleIslandList[i].object->unlockID)
        {
            work->position.x = FX32_FROM_WHOLE(voyageManager->visibleIslandList[i].object->position.x);
            work->position.z = FX32_FROM_WHOLE(voyageManager->visibleIslandList[i].object->position.y);
            return;
        }
    }

    DestroyStageTask(work);
}

void SailIsland_Draw_Destination(void)
{
    StageTask *work    = TaskGetWorkCurrent(StageTask);
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    if (!IsStageTaskDestroyed(work))
    {
        VecFx32 startPos = work->position;

        fx32 mag = VEC_Mag(&startPos);
        if (mag > FLOAT_TO_FX32(80.0))
        {
            if (mag > FLOAT_TO_FX32(384.0))
                return;

            fx32 distanceFactor = FX_Div(FLOAT_TO_FX32(384.0) - mag, FLOAT_TO_FX32(304.0));

            fx32 scale    = MultiplyFX(distanceFactor, FLOAT_TO_FX32(0.25));
            work->scale.x = scale;
            work->scale.y = scale;
            work->scale.z = scale;

            fx32 alpha = MultiplyFX(GX_COLOR_FROM_888(0xFF), distanceFactor);
            if (alpha < 0)
                alpha = 0;

            work->obj_2dIn3d->ani.polygonAttr.alpha = alpha;
        }
        else
        {
            work->scale.x                           = FLOAT_TO_FX32(0.25);
            work->scale.y                           = FLOAT_TO_FX32(0.25);
            work->scale.z                           = FLOAT_TO_FX32(0.25);
            work->obj_2dIn3d->ani.polygonAttr.alpha = GX_COLOR_FROM_888(0xFF);
        }

        VecFx32 position = work->position;

        VecFx32 heightVector;
        heightVector.x = FLOAT_TO_FX32(0.0);
        heightVector.z = FLOAT_TO_FX32(0.0);
        heightVector.y = position.y;

        VEC_Subtract(&position, &heightVector, &position);

        if (position.x == FLOAT_TO_FX32(0.0) && position.y == FLOAT_TO_FX32(0.0) && position.z == FLOAT_TO_FX32(0.0))
            position.z = 1; // prevent divide-by-zero when normalizing

        VEC_Normalize(&position, &position);
        VEC_MultAdd(FLOAT_TO_FX32(80.0), &position, &heightVector, &position);

        work->position = position;

        SailObject_SetSpriteColor(work, SailObject_ApplyFogBrightness(GX_RGB_888(0xFF, 0xFF, 0xFF)));
        StageTask__Draw3D(work, &work->obj_2dIn3d->ani.work);

        worker->camPos = work->position;
        work->position   = startPos;
    }
}

void SailIsland_Draw_Other(void)
{
    SailVoyageManager *voyageManager;

    StageTask *work;
    SailObject *worker;

    StageTask *player;
    SailPlayer *playerWorker;

    voyageManager = SailManager__GetWork()->voyageManager;

    work   = TaskGetWorkCurrent(StageTask);
    worker = GetStageTaskWorker(work, SailObject);

    player       = SailManager__GetWork()->sailPlayer;
    playerWorker = GetStageTaskWorker(player, SailPlayer);

    if (!IsStageTaskDestroyed(work))
    {
        // not sure what's up with z & y being swapped but thats what matches
        VecFx32 distance;
        distance.x = voyageManager->unknownX - work->position.x;
        distance.y = voyageManager->unknownZ - work->position.z;
        distance.z = 0;

        u16 angle    = FX_Atan2Idx(distance.x, distance.y);
        s32 seaAngle = (voyageManager->angle + playerWorker->seaAngle2);
        angle -= seaAngle;
        work->userWork = (u16)(angle + seaAngle);

        if (ObjRoopDiff16((u16)work->userWork, (u16)(voyageManager->angle + playerWorker->seaAngle2)) <= 0x2800)
        {
            fx32 distanceX = MATH_ABS(distance.x);
            fx32 distanceZ = MATH_ABS(distance.y);

            fx32 value;
            if (distanceX > distanceZ)
            {
                value = MultiplyFX(FLOAT_TO_FX32(0.96045), distanceX);
                value += MultiplyFX(FLOAT_TO_FX32(0.397706), distanceZ);
            }
            else
            {
                value = MultiplyFX(FLOAT_TO_FX32(0.96045), distanceZ);
                value += MultiplyFX(FLOAT_TO_FX32(0.397706), distanceX);
            }

            if (value > FLOAT_TO_FX32(64.0))
                value = FLOAT_TO_FX32(64.0);

            fx32 magnitude = FLOAT_TO_FX32(64.0) - value;
            if (magnitude < FLOAT_TO_FX32(64.0))
            {
                fx32 distanceFactor = FX_Div(magnitude, FLOAT_TO_FX32(64.0));

                fx32 scale    = MultiplyFX(distanceFactor, FLOAT_TO_FX32(0.125));
                work->scale.x = scale;
                work->scale.y = scale;
                work->scale.z = scale;

                fx32 alpha = MultiplyFX(GX_COLOR_FROM_888(0xFF), distanceFactor);
                if (alpha < 0)
                    alpha = 0;

                work->obj_2dIn3d->ani.polygonAttr.alpha = alpha;
            }
            else
            {
                work->scale.x = FLOAT_TO_FX32(0.125);
                work->scale.y = FLOAT_TO_FX32(0.125);
                work->scale.z = FLOAT_TO_FX32(0.125);

                work->obj_2dIn3d->ani.polygonAttr.alpha = GX_COLOR_FROM_888(0xFF);
            }

            distance = work->position;

            fx32 range = FLOAT_TO_FX32(80.0);
            if (SailManager__GetShipType() == SHIP_BOAT)
                range = FLOAT_TO_FX32(88.0);
            work->position.x = MultiplyFX(range, SinFX((s32)(u16)(work->userWork + FLOAT_DEG_TO_IDX(180.0))));
            work->position.z = MultiplyFX(range, CosFX((s32)(u16)(work->userWork + FLOAT_DEG_TO_IDX(180.0))));

            SailObject_SetSpriteColor(work, SailObject_ApplyFogBrightness(GX_RGB_888(0xFF, 0xFF, 0xFF)));
            StageTask__Draw3D(work, &work->obj_2dIn3d->ani.work);

            work->position = distance;
        }
    }
}

void SailMine_State_Active(StageTask *work)
{
    OBS_RECT_WORK *collider = StageTask__GetCollider(work, 0);

    if (collider != NULL)
    {
        if ((collider->flag & OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME) != 0)
        {
            SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXPLOSION, &work->position);
            DestroyStageTask(work);
            EffectCreateSailBomb(&work->position);
        }
    }
}

void SailBomb_Action_Init(StageTask *work)
{
    SetTaskState(work, SailBomb_State_Active);

    work->userTimer  = 32;
    work->velocity.y = -FLOAT_TO_FX32(0.125);

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    work->gravityStrength  = FLOAT_TO_FX32(0.0341796875);
    work->terminalVelocity = FLOAT_TO_FX32(0.15625);
}

void SailBomb_State_Active(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    OBS_RECT_WORK *collider = StageTask__GetCollider(work, 0);

    if (work->position.y > 0)
    {
        work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->velocity.y = ObjSpdUpSet(work->velocity.y, -FLOAT_TO_FX32(0.0546875), FLOAT_TO_FX32(0.125));
    }

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_HAS_GRAVITY) == 0 && work->position.y < FLOAT_TO_FX32(0.0))
        work->velocity.y = ObjSpdUpSet(work->velocity.y, FLOAT_TO_FX32(0.02734375), FLOAT_TO_FX32(0.046875));

    if (work->userTimer == 6)
        work->shakeTimer = FX32_FROM_WHOLE(work->userTimer);

    if (work->userTimer < 16)
    {
        // bomb is going to explode soon!! danger!!
        if ((work->userTimer & 2) != 0)
            SailObject_SetSpriteColor(work, GX_RGB_888(0xFF, 0x00, 0x00));
        else
            SailObject_SetSpriteColor(work, GX_RGB_888(0xFF, 0xFF, 0xFF));
    }
    else
    {
        // bomb is going to explode... but not yet..!
        if ((work->userTimer & 4) != 0)
            SailObject_SetSpriteColor(work, GX_RGB_888(0xFF, 0x00, 0x00));
        else
            SailObject_SetSpriteColor(work, GX_RGB_888(0xFF, 0xFF, 0xFF));
    }

    if (collider != NULL)
    {
        if ((collider->flag & OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME) != 0)
        {
            DestroyStageTask(work);

            if ((work->displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
            {
                EffectCreateSailBomb(&work->position);
                SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXPLOSION, &work->position);
            }
        }
    }

    work->userTimer--;
    if (work->userTimer == 0)
    {
        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

        StageTask *explosion = EffectCreateSailBomb(&work->position);

        fx32 scale         = MultiplyFX(explosion->scale.x, FLOAT_TO_FX32(2.0));
        explosion->scale.x = scale;
        explosion->scale.y = scale;
        explosion->scale.z = scale;

        SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXPLOSION, &work->position);
    }

    if (work->userTimer == -4)
        worker->collider[0].hitCheck.box.size.x *= 3;

    if (work->userTimer < -6)
        DestroyStageTask(work);
}

void SailFogCloud_State_Active(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailManager *manager = SailManager__GetWork();

    worker->startEmissionColor.x += (manager->velocity.x >> 9);
    worker->startEmissionColor.x = (u16)worker->startEmissionColor.x;

    work->position.y -= manager->velocity.z >> 5;

    u16 alpha = GX_COLOR_FROM_888(0xFF);

    work->position.x = MultiplyFX(worker->startEmissionColor.y, SinFX((s32)(u16)worker->startEmissionColor.x));
    work->position.z = MultiplyFX(worker->startEmissionColor.y, CosFX((s32)(u16)worker->startEmissionColor.x));

    work->obj_2dIn3d->ani.polygonAttr.polygonID = manager->field_30;
    manager->field_30++;

    if (work->position.y > -FLOAT_TO_FX32(7.125))
    {
        alpha = MATH_ABS(work->position.y + FLOAT_TO_FX32(6.125)) >> 7;
    }

    if (work->position.y < -FLOAT_TO_FX32(17.5))
    {
        alpha = MATH_ABS(work->position.y + FLOAT_TO_FX32(18.5)) >> 7;
    }

    if (alpha > (GX_COLOR_FROM_888(0xFF) + 1))
        alpha = GX_COLOR_FROM_888(0xFF);

    if (alpha == GX_COLOR_FROM_888(0x00))
        alpha = GX_COLOR_FROM_888(0x08);

    work->obj_2dIn3d->ani.polygonAttr.alpha = alpha;

    if (work->position.y < -FLOAT_TO_FX32(18.5) || work->position.y > -FLOAT_TO_FX32(6.125))
    {
        if (!IsStageTaskDestroyed(work))
        {
            SailEventManagerObject fogCloud = { 0 };

            fogCloud.type = SAILMAPOBJECT_37;

            fogCloud.viewRange = -FLOAT_TO_FX32(79.0) - ObjDispRandRepeat(FLOAT_TO_FX32(32.0));
            fogCloud.angle     = worker->startEmissionColor.x;
            fogCloud.angle += ObjDispRandRange5(-FLOAT_DEG_TO_IDX(45.0), FLOAT_DEG_TO_IDX(45.0));

            fogCloud.position.x = MultiplyFX(fogCloud.viewRange, SinFX(fogCloud.angle));
            fogCloud.position.z = MultiplyFX(fogCloud.viewRange, CosFX(fogCloud.angle));

            if (work->position.y < -FLOAT_TO_FX32(18.5))
                fogCloud.position.y = -FLOAT_TO_FX32(6.125);

            if (work->position.y > -FLOAT_TO_FX32(6.125))
                fogCloud.position.y = -FLOAT_TO_FX32(18.5);

            fogCloud.flags |= SAILMAPOBJECT_FLAG_20000000;
            SailEventManager__CreateObject2(&fogCloud);
        }

        DestroyStageTask(work);
    }
    else
    {
        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

        u16 seaAngle = MATH_ABS(manager->sea->voyageAngle + manager->sea->playerAngle - worker->startEmissionColor.x);

        if (seaAngle < FLOAT_DEG_TO_IDX(33.75) || seaAngle > FLOAT_DEG_TO_IDX(326.25))
            work->displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

        if (work->userWork != 0)
            work->displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;

        work->userWork = 1;

        if ((work->displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
        {
            SailObject_SetSpriteColor(work, SailObject_ApplyFogBrightness(GX_RGB_888(0xFF, 0xFF, 0xFF)));
        }
    }
}

void SailSkyCloud_State_Active(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailManager *manager = SailManager__GetWork();

    StageTask *player        = SailManager__GetWork()->sailPlayer;
    SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    worker->startEmissionColor.x += (manager->velocity.x >> 9);
    worker->startEmissionColor.x = (u16)worker->startEmissionColor.x;

    if ((work->displayFlag & DISPLAY_FLAG_DRAW_3D_SPRITE_AS_2D) == 0)
    {
        s32 angle = worker->startEmissionColor.x + (playerWorker->seaAngle2 + (voyageManager->angle - FLOAT_DEG_TO_IDX(180.0)));

        work->position.y -= manager->velocity.z >> 5;
        work->position.x = MultiplyFX(worker->startEmissionColor.y, SinFX((s32)(u16)angle));
        work->position.z = MultiplyFX(worker->startEmissionColor.y, CosFX((s32)(u16)angle));
    }

    work->obj_2dIn3d->ani.polygonAttr.polygonID = manager->field_30;
    manager->field_30++;

    if (work->userTimer != 0)
        work->displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;

    work->userTimer++;

    u16 alpha;
    if (work->userTimer >= work->userWork)
        alpha = GX_COLOR_FROM_888(0x80) - (work->userTimer - work->userWork);
    else
        alpha = work->userTimer;

    if (manager->cloudType == 3)
    {
        if (alpha > GX_COLOR_FROM_888(0x70))
            alpha = GX_COLOR_FROM_888(0x70);
    }
    else
    {
        if (alpha > GX_COLOR_FROM_888(0x30))
            alpha = GX_COLOR_FROM_888(0x30);
    }

    if (alpha == GX_COLOR_FROM_888(0x00))
        alpha = GX_COLOR_FROM_888(0x08);

    work->obj_2dIn3d->ani.polygonAttr.alpha = alpha;

    if (work->userTimer == work->userWork + 16)
    {
        DestroyStageTask(work);

        if (manager->cloudType != 2 && manager->cloudType != 3)
            return;

        if ((work->displayFlag & DISPLAY_FLAG_DRAW_3D_SPRITE_AS_2D) != 0)
            CreateSailSkyCloud(SAILSKYCLOUD_TYPE_0);
        else
            CreateSailSkyCloud(SAILSKYCLOUD_TYPE_1);
    }

    if (manager->cloudType != 2 && manager->cloudType != 3)
        work->userTimer = work->userWork;

    if ((work->displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        SailObject_SetSpriteColor(work, SailObject_ApplyFogBrightness(GX_RGB_888(0xFF, 0xFF, 0xFF)));
    }
}

void SailObject_Action_Destroy(StageTask *work)
{
    ShipType shipType = SailManager__GetShipType();

    if (shipType != SHIP_BOAT && shipType != SHIP_SUBMARINE)
        SailObject_Action_ExplodeSimple(work);
    else
        SailObject_Action_Explode(work);
}

void SailObject_Action_ExplodeSimple(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);
    SailPlayer *player = GetStageTaskWorker(worker->player, SailPlayer);

    worker->startEmissionColor.x = ObjDispRandRange5(-FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(0.125));
    worker->startEmissionColor.y = ObjDispRandRepeat(FLOAT_TO_FX32(0.125));
    worker->startEmissionColor.y = -FLOAT_TO_FX32(0.125) - worker->startEmissionColor.y;
    worker->startEmissionColor.z = ObjDispRandRange5(-FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.5));
    worker->voyageScrollSpeed    = -(player->speed + FLOAT_TO_FX32(1.0));

    SetTaskState(work, SailObject_State_ExplodeSimple);

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->userFlag |= SAILOBJECT_FLAG_1;
    work->userTimer = 0;
}

void SailObject_State_ExplodeSimple(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    u16 angle        = (s32)(u16)(worker->objectAngle + worker->startEmissionColor.x);
    work->velocity.x = MultiplyFX(worker->voyageScrollSpeed, SinFX(angle));
    work->velocity.z = MultiplyFX(worker->voyageScrollSpeed, CosFX(angle));
    work->velocity.y = worker->startEmissionColor.y;

    work->dir.y += FLOAT_DEG_TO_IDX(33.75);
    work->dir.z += worker->startEmissionColor.z + FLOAT_DEG_TO_IDX(22.5);
    work->dir.x += FLOAT_DEG_TO_IDX(22.5) - worker->startEmissionColor.z;

    SailObject_ApplyRotation(work);
    work->userTimer++;

    if ((work->userFlag & SAILOBJECT_FLAG_2) != 0 && work->userTimer > 12)
    {
        VecFx32 explosionPos;
        SailObject_GetCollisionOffset(work, &explosionPos);
        VEC_Subtract(&work->position, &explosionPos, &explosionPos);

        SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ENEMY_DEAD, &work->position);
        DestroyStageTask(work);

        StageTask *explosion = EffectCreateSailBomb(&explosionPos);

        fx32 scale         = MultiplyFX(explosion->scale.x, worker->explosionScale);
        explosion->scale.x = scale;
        explosion->scale.y = scale;
        explosion->scale.z = scale;
        return;
    }

    if (work->userTimer > 24)
    {
        DestroyStageTask(work);
        return;
    }
}

void SailObject_Action_Explode(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SetTaskState(work, SailObject_State_Explode);

    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->userTimer = 0;

    if ((work->userFlag & SAILOBJECT_FLAG_4) != 0)
    {
        EffectUnknown2161544__Create(work, &work->position);
        work->userTimer    = 36;
        worker->blinkTimer = 32;

        work->velocity.y = FLOAT_TO_FX32(0.0703125);
        if ((work->userFlag & SAILOBJECT_FLAG_1) == 0)
            worker->voyageVelocity.z = FLOAT_TO_FX32(0.25);
        else
            worker->voyageVelocity.z = -FLOAT_TO_FX32(0.25);

        worker->voyageVelocity.y = FLOAT_TO_FX32(0.0);
    }
    else
    {
        if (SailManager__GetShipType() == SHIP_SUBMARINE)
            SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXP_S, &work->position);
        else
            SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ENE_EXP_S, &work->position);
    }

    work->shakeTimer = FLOAT_TO_FX32(4.0);
}

void SailObject_CreateRingsForExplode1(StageTask *work)
{
    if ((work->userFlag & SAILOBJECT_FLAG_40000) != 0)
    {
        VecFx32 ringVelocity;
        VecFx32 ringPosition;

        ringVelocity.x = FLOAT_TO_FX32(0.0703125);
        ringVelocity.y = -FLOAT_TO_FX32(0.3125);
        ringVelocity.z = FLOAT_TO_FX32(0.0703125);
        SailObject_GetCollisionOffset(work, &ringPosition);

        VEC_Subtract(&work->position, &ringPosition, &ringPosition);
        if ((work->userFlag & SAILOBJECT_FLAG_1000000) != 0)
        {
            ringPosition.y -= FLOAT_TO_FX32(1.0);
            ringVelocity.y -= FLOAT_TO_FX32(0.1875);
        }

        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = -ringVelocity.x;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.z = -ringVelocity.z;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = -ringVelocity.x;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        if ((work->userFlag & SAILOBJECT_FLAG_2000000) != 0)
        {
            for (u16 i = 0; i < 2; i++)
            {
                if (i == 0)
                {
                    ringVelocity.x = FLOAT_TO_FX32(0.09375);
                    ringVelocity.y = -FLOAT_TO_FX32(0.625);
                    ringVelocity.z = FLOAT_TO_FX32(0.09375);
                }

                if (i == 1)
                {
                    ringVelocity.x = FLOAT_TO_FX32(0.125);
                    ringVelocity.y = -FLOAT_TO_FX32(0.4375);
                    ringVelocity.z = FLOAT_TO_FX32(0.125);
                }

                ringPosition.y -= FLOAT_TO_FX32(1.0);
                SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

                ringVelocity.x = -ringVelocity.x;
                SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

                ringVelocity.z = -ringVelocity.z;
                SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

                ringVelocity.x = -ringVelocity.x;
                SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);
            }
        }
    }
}

void SailObject_CreateRingsForExplode2(StageTask *work)
{
    if ((work->userFlag & SAILOBJECT_FLAG_40000) != 0)
    {
        VecFx32 ringVelocity;
        VecFx32 ringPosition;

        ringVelocity.x = FLOAT_TO_FX32(0.1640625);
        ringVelocity.y = -FLOAT_TO_FX32(0.3125);
        ringVelocity.z = FLOAT_TO_FX32(0.1640625);
        SailObject_GetCollisionOffset(work, &ringPosition);

        if ((work->userFlag & SAILOBJECT_FLAG_1000000) != 0)
        {
            ringPosition.y -= FLOAT_TO_FX32(1.0);
            ringVelocity.y -= FLOAT_TO_FX32(0.4375);
        }

        VEC_Subtract(&work->position, &ringPosition, &ringPosition);

        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = -ringVelocity.x;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.z = -ringVelocity.z;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = -ringVelocity.x;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = FLOAT_TO_FX32(0.0);
        ringVelocity.y = -FLOAT_TO_FX32(0.3125);
        ringVelocity.z = FLOAT_TO_FX32(0.125);
        if ((work->userFlag & SAILOBJECT_FLAG_1000000) != 0)
            ringVelocity.y -= FLOAT_TO_FX32(0.3125);

        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.z = -ringVelocity.z;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = FLOAT_TO_FX32(0.125);
        ringVelocity.y = -FLOAT_TO_FX32(0.3125);
        ringVelocity.z = FLOAT_TO_FX32(0.0);
        if ((work->userFlag & SAILOBJECT_FLAG_1000000) != 0)
            ringVelocity.y -= FLOAT_TO_FX32(0.3125);

        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);

        ringVelocity.x = -ringVelocity.x;
        SailRingManager_CreateObjectRing(&ringPosition, &ringVelocity);
    }
}

void SailObject_State_Explode(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailObject_ApplyRotation(work);

    if ((work->userFlag & SAILOBJECT_FLAG_4) != 0)
    {
        SailObject_HandleVoyageVelocity(work);

        if (work->shakeTimer == FLOAT_TO_FX32(0.0))
            work->shakeTimer = FLOAT_TO_FX32(4.0);

        if ((work->userTimer & 7) == 0)
        {
            SailObject_CreateRingsForExplode1(work);

            if (SailManager__GetShipType() == SHIP_SUBMARINE)
                SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXP_M, &work->position);
            else
                SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ENE_EXP_M, &work->position);
        }
    }

    if (work->userTimer == 0 && ((work->userFlag & SAILOBJECT_FLAG_2) | SAILOBJECT_FLAG_8) != 0)
    {
        VecFx32 splashPos;
        SailObject_GetCollisionOffset(work, &splashPos);
        VEC_Subtract(&work->position, &splashPos, &splashPos);

        if ((work->userFlag & SAILOBJECT_FLAG_2) != 0)
        {
            if ((work->userFlag & SAILOBJECT_FLAG_4) != 0)
            {
                if (SailManager__GetShipType() == SHIP_SUBMARINE)
                    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXP_M, &work->position);
                else
                    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ENE_EXP_M, &work->position);
            }

            StageTask *explosion = EffectCreateSailBomb(&splashPos);

            fx32 scale;
            if (worker->collider[0].hitCheck.box.size.x > FLOAT_TO_FX32(3.0))
            {
                scale = MultiplyFX(explosion->scale.x, worker->collider[0].hitCheck.box.size.x - FLOAT_TO_FX32(2.0));

                explosion->scale.x = scale;
                explosion->scale.y = scale;
                explosion->scale.z = scale;
            }
            else if (worker->collider[0].hitCheck.box.size.x > FLOAT_TO_FX32(1.0))
            {
                scale = MultiplyFX(explosion->scale.x, worker->collider[0].hitCheck.box.size.x - FLOAT_TO_FX32(0.5)) >> 1;

                explosion->scale.x = scale;
                explosion->scale.y = scale;
                explosion->scale.z = scale;
            }

            if ((work->userFlag & SAILOBJECT_FLAG_20000) != 0)
            {
                scale = MultiplyFX(FLOAT_TO_FX32(2.875), scale);

                explosion->scale.x = scale;
                explosion->scale.y = scale;
                explosion->scale.z = scale;

                if (SailManager__GetShipType() == SHIP_SUBMARINE)
                    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_EXP_L, &work->position);
                else
                    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ENE_EXP_L, &work->position);

                SailExplosionHazard__Create(&work->position);
            }
        }

        if ((work->userFlag & SAILOBJECT_FLAG_8) != 0)
        {
            StageTask *waterSplash = EffectSailWater06__Create(&splashPos);

            fx32 scale           = MultiplyFX(waterSplash->scale.x, FLOAT_TO_FX32(2.0));
            waterSplash->scale.x = scale;
            waterSplash->scale.y = scale;
            waterSplash->scale.z = scale;
        }

        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    }

    if (work->userTimer < 0)
    {
        if ((work->userFlag & SAILOBJECT_FLAG_4) == 0)
            SailObject_CreateRingsForExplode1(work);
        else
            SailObject_CreateRingsForExplode2(work);

        DestroyStageTask(work);
    }

    work->userTimer--;
}

void SailBuoy_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    switch (work->userWork)
    {
        // case 0:
        default:
            worker->startEmissionColor.x = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x60));
            worker->startEmissionColor.y = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xF8));
            worker->startEmissionColor.z = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x60));

            worker->targetEmissionColor.x = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x40));
            worker->targetEmissionColor.y = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xA0));
            worker->targetEmissionColor.z = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x40));
            break;

        case 1:
            worker->startEmissionColor.x = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xF8));
            worker->startEmissionColor.y = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x50));
            worker->startEmissionColor.z = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x28));

            worker->targetEmissionColor.x = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x38));
            worker->targetEmissionColor.y = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x10));
            worker->targetEmissionColor.z = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x000));
            break;

        case 2:
            worker->startEmissionColor.x = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xF8));
            worker->startEmissionColor.y = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xF8));
            worker->startEmissionColor.z = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xF8));

            worker->targetEmissionColor.x = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x28));
            worker->targetEmissionColor.y = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x40));
            worker->targetEmissionColor.z = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x50));
            break;
    }

    SetTaskState(work, SailBuoy_State_Floating);

    work->userTimer = 0;
    work->userWork  = 0;
}

void SailBuoy_State_Floating(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    if (work->userWork == 0)
    {
        work->userTimer += FLOAT_TO_FX32(0.125);
        if (work->userTimer >= FLOAT_TO_FX32(1.0))
        {
            work->userTimer = FLOAT_TO_FX32(1.0);
            work->userWork ^= 1;
        }
    }
    else
    {
        work->userTimer -= FLOAT_TO_FX32(0.125);
        if (work->userTimer < FLOAT_TO_FX32(0.0))
        {
            work->userTimer = FLOAT_TO_FX32(0.0);
            work->userWork ^= 1;
        }
    }

    s32 emissionR = ObjAlphaSet(worker->startEmissionColor.x, worker->targetEmissionColor.x, work->userTimer);
    s32 emissionG = ObjAlphaSet(worker->startEmissionColor.y, worker->targetEmissionColor.y, work->userTimer);
    s32 emissionB = ObjAlphaSet(worker->startEmissionColor.z, worker->targetEmissionColor.z, work->userTimer);

    GXRgb color = GX_RGB(FX32_TO_WHOLE(emissionR), FX32_TO_WHOLE(emissionG), FX32_TO_WHOLE(emissionB));

    NNS_G3dMdlSetMdlEmi(work->obj_3d->ani.renderObj.resMdl, 1, color);
    work->dir.y = worker->objectAngle;
    SailObject_ApplyRotation(work);
}

void SailUnusedSeagull_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailVoyageSegment *voyageSegment = &voyageManager->segmentList[FX32_TO_WHOLE(worker->voyagePosition.z) >> 7];

    SetTaskState(work, SailUnusedSeagull_State_Flying);

    if (voyageSegment->targetSeaAngle != 0)
    {
        s32 range = 0x300 + ObjDispRandRepeat(0x200);

        worker->voyageVelocity.y = -64;
        worker->voyageVelocity.x = MultiplyFX(range, SinFX(voyageSegment->targetSeaAngle));
        worker->voyageVelocity.z = MultiplyFX(range, CosFX(voyageSegment->targetSeaAngle));
    }
    else
    {
        worker->voyageVelocity.x = mtMathRandRange(-0x200, 0x200);
        worker->voyageVelocity.y = -64;
        worker->voyageVelocity.z = -ObjDispRandRepeat(0x400);
    }

    work->userTimer = 32;
    work->userWork  = 0;
}

void SailUnusedSeagull_State_Flying(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    work->userTimer--;

    if (work->userWork != 0)
    {
        worker->voyageVelocity.y = ObjSpdUpSet(worker->voyageVelocity.y, 16, 128);
        if (work->userTimer < 0)
        {
            work->userTimer = 32;
            work->userWork  = 0;
        }
    }
    else
    {
        worker->voyageVelocity.y = ObjSpdUpSet(worker->voyageVelocity.y, -16, 64);
        if (work->userTimer < 0)
        {
            work->userTimer = 32;
            work->userWork  = 1;
        }
    }

    SailObject_HandleVoyageVelocity(work);
}

void SailSeagull_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailVoyageSegment *voyageSegment = &voyageManager->segmentList[FX32_TO_WHOLE(worker->voyagePosition.z) >> 7];

    SetTaskState(work, SailSeagull_State_Flying);

    if (voyageSegment->targetSeaAngle != 0)
    {
        s32 range = 0x300 + ObjDispRandRepeat(0x200);

        worker->voyageVelocity.y = 16;
        worker->voyageVelocity.x = MultiplyFX(range, SinFX(voyageSegment->targetSeaAngle));
        worker->voyageVelocity.z = MultiplyFX(range, CosFX(voyageSegment->targetSeaAngle));
    }
    else
    {
        worker->voyageVelocity.x = mtMathRandRange(-0x100, 0x100);
        worker->voyageVelocity.y = 16;

        worker->voyageVelocity.z = -(ObjDispRandRepeat(0x40) + 128);
    }
}

void SailSeagull_State_Flying(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    work->dir.y = worker->objectAngle;

    SailObject_ApplyRotation(work);
    SailObject_HandleVoyageVelocity(work);
}

void SailIslandSeagull_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SetTaskState(work, SailIslandSeagull_State_Flying);

    work->parentOffset.x = 4 * ObjDispRandRange(-FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(2.0));
    work->parentOffset.y -= FLOAT_TO_FX32(6.0) + ObjDispRandRepeat(FLOAT_TO_FX32(4.0));
    work->parentOffset.z = 4 * ObjDispRandRange(-FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(2.0));

    // TODO: clean this up
    worker->voyageScrollSpeed = 639 - ObjDispRandRepeat(0x100 - 1);
    work->userTimer           = 207 - ObjDispRandRepeat(0x20 - 1);

    work->dir.y = ObjDispRand();
}

void SailIslandSeagull_State_Flying(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    StageTask *parent        = work->parentObj;
    SailObject *parentWorker = GetStageTaskWorker(parent, SailObject);

    work->position = parentWorker->camPos;

    fx32 scale    = FX_Div(parent->scale.x, 1024);
    work->scale.x = scale;
    work->scale.y = work->scale.x;
    work->scale.z = work->scale.x;
    NNS_G3dMdlSetMdlAlphaAll(work->obj_3d->ani.renderObj.resMdl, parent->obj_2dIn3d->ani.polygonAttr.alpha);

    work->userWork--;
    work->velocity.y = oscillateTable[(work->userWork >> 2) & 0x7] >> 2;

    work->dir.y += work->userTimer;

    work->velocity.x = MultiplyFX(worker->voyageScrollSpeed, SinFX(work->dir.y));
    work->velocity.z = MultiplyFX(worker->voyageScrollSpeed, CosFX(work->dir.y));
    VEC_Add(&work->parentOffset, &work->velocity, &work->parentOffset);

    work->offset = work->parentOffset;

    SailObject_ApplyRotation(work);
}

void SailFish_Action_Init(StageTask *work)
{
    SetTaskState(work, SailFish_State_Swimming);
    work->userTimer = 0;

    work->userWork = ObjDispRandRepeat(64) + 6;
    work->dir.y    = ObjDispRandRange(-FLOAT_DEG_TO_IDX(90.0), FLOAT_DEG_TO_IDX(90.0));
}

void SailFish_State_Swimming(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    work->userWork--;
    if (work->userWork == 0)
        work->userTimer = 1;

    if (work->userTimer != 0)
    {
        if (work->dir.y > FLOAT_DEG_TO_IDX(180.0))
            work->dir.y = ObjRoopMove16(work->dir.y, FLOAT_DEG_TO_IDX(270.0), FLOAT_DEG_TO_IDX(2.8125));
        else
            work->dir.y = ObjRoopMove16(work->dir.y, FLOAT_DEG_TO_IDX(90.0), FLOAT_DEG_TO_IDX(2.8125));
    }

    worker->voyageVelocity.y += oscillateTable[(work->userWork >> 2) & 0x7] >> 1;

    worker->voyageVelocity.x = MultiplyFX(FLOAT_TO_FX32(0.75), SinFX(work->dir.y));
    worker->voyageVelocity.z = MultiplyFX(FLOAT_TO_FX32(0.75), CosFX(work->dir.y));
    SailObject_HandleVoyageVelocity(work);

    u16 angleY  = work->dir.y;
    work->dir.y = -angleY;
    SailObject_ApplyRotation(work);
    work->dir.y = angleY;
}

void SailIslandFish_Action_Init(StageTask *work)
{
    SetTaskState(work, SailIslandFish_State_Swimming);

    work->userTimer = ObjDispRandRepeat(128);
    work->userWork  = ObjDispRandRepeat(64) + 6;

    work->parentOffset.x = 16 * ObjDispRandRange(-FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    work->parentOffset.y -= ObjDispRandRepeat(FLOAT_TO_FX32(8.0));
    work->parentOffset.z -= ObjDispRandRepeat(FLOAT_TO_FX32(4.0));

    if (ObjDispRandRepeat(2) != 0)
        work->dir.y = FLOAT_DEG_TO_IDX(90.0);
    else
        work->dir.y = -FLOAT_DEG_TO_IDX(90.0);

    work->dir.y = ObjDispRandRange(-FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(0.25));
}

void SailIslandFish_State_Swimming(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    StageTask *parent        = work->parentObj;
    SailObject *parentWorker = GetStageTaskWorker(parent, SailObject);

    work->position = parentWorker->camPos;

    fx32 scale    = FX_Div(parent->scale.x, FLOAT_TO_FX32(0.25));
    work->scale.x = scale;
    work->scale.y = work->scale.x;
    work->scale.z = work->scale.x;

    work->userWork--;
    work->userTimer++;

    work->velocity.y          = oscillateTable[(work->userWork >> 2) & 0x7];
    worker->voyageScrollSpeed = 2 * oscillateTable[(work->userTimer >> 3) & 0x7];

    work->velocity.x = MultiplyFX(worker->voyageScrollSpeed, CosFX(work->dir.y));
    work->velocity.z = MultiplyFX(worker->voyageScrollSpeed, SinFX(work->dir.y));
    VEC_Add(&work->parentOffset, &work->velocity, &work->parentOffset);

    work->offset = work->parentOffset;

    SailObject_ApplyRotation(work);
}

void SailGoalChaosEmerald_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    worker->player = SailManager__GetWork()->sailPlayer;
    SetTaskState(work, SailGoalChaosEmerald_State_Idle);
    work->userTimer = 0;
    work->userWork  = 0;
}

void SailGoalChaosEmerald_State_Idle(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailManager *manager             = SailManager__GetWork();

    worker->voyageVelocity.y = oscillateTable[(work->userTimer >> 2) & 0x7] >> 2;
    work->userTimer++;

    SailObject_HandleVoyageVelocity(work);
    work->dir.y = worker->objectAngle;
    SailObject_ApplyRotation(work);

    if ((manager->flags & SAILMANAGER_FLAG_8) == 0)
    {
        if (voyageManager->voyagePos > worker->voyagePosition.z)
        {
            SailGoalChaosEmerald_Action_Grab(work);
        }
    }
    else
    {
        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    }
}

void SailGoalChaosEmerald_Action_Grab(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    worker->player           = SailManager__GetWork()->sailPlayer;
    worker->voyageVelocity.y = 0;
    SetTaskState(work, SailGoalChaosEmerald_State_Grabbed);
    work->userTimer = 0;
    work->userWork  = 0;

    gameState.saveFile.chaosEmeraldID = SailManager__GetWork()->rivalRaceID;
}

void SailGoalChaosEmerald_State_Grabbed(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    UNUSED(voyageManager);

    if (worker->player != NULL)
    {
        FXMatrix33 mtx;
        VecFx32 offset;

        offset.x = -FLOAT_TO_FX32(0.25);
        offset.y = -FLOAT_TO_FX32(1.0625);
        offset.z = FLOAT_TO_FX32(0.0);
        MTX_RotY33(mtx.nnMtx, SinFX(worker->player->dir.y), CosFX(worker->player->dir.y));
        MTX_MultVec33(&offset, mtx.nnMtx, &offset);

        work->position.x = ObjShiftSet(work->position.x, worker->player->position.x + offset.x, 1, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.0));
        work->position.y = ObjShiftSet(work->position.y, worker->player->position.y + offset.y, 1, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.0));
        work->position.z = ObjShiftSet(work->position.z, worker->player->position.z + offset.z, 1, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.0));
    }
}

void SailGoal_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    worker->player = SailManager__GetWork()->sailPlayer;
    SetTaskState(work, SailGoal_State_Active);
    work->userTimer = 0;
    work->userWork  = 0;
}

void SailGoal_State_Active(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailManager *manager             = SailManager__GetWork();

    worker->voyageVelocity.y = oscillateTable[(work->userTimer >> 2) & 0x7] >> 2;
    work->userTimer++;

    SailObject_HandleVoyageVelocity(work);
    work->dir.y = worker->objectAngle;
    SailObject_ApplyRotation(work);

    if (voyageManager->voyagePos > worker->voyagePosition.z)
    {
        fx32 scale = ObjShiftSet(work->scale.x, FLOAT_TO_FX32(8.0), 1, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0625));
        if (!work->userWork)
        {
            work->userWork = 1;
            scale          = FLOAT_TO_FX32(1.0);
        }

        work->scale.x = scale;
        work->scale.y = scale;
        work->scale.z = scale;

        if (scale == FLOAT_TO_FX32(8.0))
            DestroyStageTask(work);
    }

    if (manager->isRivalRace)
    {
        if ((manager->flags & SAILMANAGER_FLAG_8) != 0)
            work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    }
}

void SailGoalText_Action_Init(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    worker->player = SailManager__GetWork()->sailPlayer;
    SetTaskState(work, SailGoalText_State_Active);
    work->userTimer = 0;
}

void SailGoalText_State_Active(StageTask *work)
{
    SailObject *worker = GetStageTaskWorker(work, SailObject);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    worker->voyageVelocity.y = oscillateTable[(work->userTimer >> 2) & 0x7] >> 2;
    work->userTimer++;

    SailObject_HandleVoyageVelocity(work);

    if (voyageManager->voyagePos > work->userWork)
        DestroyStageTask(work);
}

void SailItemBox_GiveItem(StageTask *work, StageTask *object)
{
    StageTask *player;
    SailPlayer *playerWorker;

    u32 score = 0;

    player = object;
    if (object->objType != SAILSTAGE_OBJ_TYPE_PLAYER)
    {
        if (player->parentObj == NULL)
            return;

        player = object->parentObj;
        if (player->objType != SAILSTAGE_OBJ_TYPE_PLAYER)
            return;
    }

    playerWorker = GetStageTaskWorker(player, SailPlayer);

    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ITEM, &work->position);

    switch (work->userWork)
    {
        default: // repair 25%
            SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX * 0.25f);
            break;

        case 1: // repair 50%
            SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX * 0.5f);
            break;

        case 2:                                                               // repair 75%
            SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX * 0.765625f); // 75%, but rounded up to a clean number in fixed-12
            break;

        case 3: // repair 100%
            SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX * 1.0f);
            break;

        case 4: // boost 10%
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_TRICK_SUC, &work->position);
            // desite saying "boost 10%", it appears they used the "HEALTH_MAX" value instead of "BOOST_MAX" one.
            // because of this you won't get 10% boost, you'll get 10% of the max health added to the boost gauge instead!
            SailPlayer__GiveBoost(player, SAILPLAYER_HEALTH_MAX * 0.09765625); // 10%, but rounded down to a clean number in fixed-12
            break;

        case 5: // boost 20%
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_TRICK_SUC, &work->position);
            // desite saying "boost 20%", it appears they used the "HEALTH_MAX" value instead of "BOOST_MAX" one.
            // because of this you won't get 20% boost, you'll get 20% of the max health added to the boost gauge instead!
            SailPlayer__GiveBoost(player, SAILPLAYER_HEALTH_MAX * 0.1953125); // 20%, but rounded down to a clean number in fixed-12
            break;

        case 6: // boost 50%
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_TRICK_SUC, &work->position);
            // desite saying "boost 50%", it appears they used the "HEALTH_MAX" value instead of "BOOST_MAX" one.
            // because of this you won't get 50% boost, you'll get 50% of the max health added to the boost gauge instead!
            SailPlayer__GiveBoost(player, SAILPLAYER_HEALTH_MAX * 0.5f);
            break;

        case 7: // boost 100%
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_TRICK_SUC, &work->position);
            // desite saying "boost 100%", it appears they used the "HEALTH_MAX" value instead of "BOOST_MAX" one.
            // because of this you won't get 100% boost, you'll get 100% of the max health added to the boost gauge instead!
            SailPlayer__GiveBoost(player, SAILPLAYER_HEALTH_MAX * 1.0f);
            break;

        case 8: // 10 rings
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_RING, &work->position);
            playerWorker->rings += 10;
            break;

        case 9: // 20 rings
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_RING, &work->position);
            playerWorker->rings += 20;
            break;

        case 10: // 30 rings
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_RING, &work->position);
            playerWorker->rings += 30;
            break;

        case 11: // 50 rings
            SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_RING, &work->position);
            playerWorker->rings += 50;
            break;

        case 12: // 1000 score
            score = 1000;
            break;

        case 13: // 2000 score
            score = 2000;
            break;

        case 14: // 5000 score
            score = 5000;
            break;

        case 15: // 8000 score
            score = 8000;
            break;
    }

    if (playerWorker->rings > SAILPLAYER_MAX_RINGS)
        playerWorker->rings = SAILPLAYER_MAX_RINGS;

    if (score != 0)
    {
        u16 multiplier = 1;
        multiplier += FX_DivS32(playerWorker->scoreComboCurrent, 50);

        playerWorker->score += score * multiplier;
        if (playerWorker->score > SAILPLAYER_MAX_SCORE)
            playerWorker->score = SAILPLAYER_MAX_SCORE;
    }

    CreateSailItemBoxRewardText(work, work->userWork);

    if (SailManager__GetShipType() == SHIP_BOAT || SailManager__GetShipType() == SHIP_SUBMARINE)
        EffectCreateSailBomb(&work->position);

    work->flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    QueueDestroyStageTask(work);
}

void SailItemBoxRewardText_State_Active(StageTask *work)
{
    if (work->userTimer > 6)
        work->velocity.y = ObjSpdDownSet(work->velocity.y, FLOAT_TO_FX32(0.046875));

    if (work->userTimer > 30)
    {
        if ((work->userTimer & 1) != 0)
            work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        else
            work->displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    }

    if (work->userTimer > 64)
        DestroyStageTask(work);

    work->userTimer++;
}