// Effect System Headers
#include <stage/effectTask.h>
#include <stage/gameObject.h>

// Common Effect Headers
#include <stage/effects/explosion.h>
#include <stage/effects/found.h>
#include <stage/effects/vitality.h>
#include <stage/effects/enemyDebris.h>
#include <stage/effects/waterExplosion.h>
#include <stage/effects/groundExplosion.h>
#include <stage/effects/battleBurst.h>

// Zone Effect Headers
#include <stage/effects/steamBlasterSmoke.h>
#include <stage/effects/steamBlasterSteam.h>
#include <stage/effects/waterSplash.h>
#include <stage/effects/waterWake.h>
#include <stage/effects/waterGush.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/coralDebris.h>
#include <stage/effects/bridgeDebris.h>
#include <stage/effects/iceSparkles.h>
#include <stage/effects/startDash.h>
#include <stage/effects/breakableObjDebris.h>
#include <stage/effects/goalJewel.h>
#include <stage/effects/bouncyMushroomPuff.h>
#include <stage/effects/pipeFlowPetal.h>
#include <stage/effects/pipeFlowSeed.h>
#include <stage/effects/steam.h>
#include <stage/effects/steamFan.h>
#include <stage/effects/piston.h>
#include <stage/effects/iceBlockDebris.h>
#include <stage/effects/truckSparkles.h>
#include <stage/effects/snowslide.h>
#include <stage/effects/truckJewel.h>
#include <stage/effects/pirateShipCannonBlast.h>
#include <stage/effects/unknown202C414.h>
#include <stage/effects/slingDust.h>
#include <stage/effects/sailboatBazookaSmoke.h>
#include <stage/effects/hoverCrystalSparkle.h>
#include <stage/effects/iceSparklesSpawner.h>
#include <stage/effects/medal.h>
#include <stage/effects/ringSparkle.h>
#include <stage/effects/buttonPrompt.h>

// Player Effect Headers
#include <stage/effects/waterSplash.h>
#include <stage/effects/waterWake.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/brakeDust.h>
#include <stage/effects/spindashDust.h>
#include <stage/effects/flameDust.h>
#include <stage/effects/flameJet.h>
#include <stage/effects/hummingTop.h>
#include <stage/effects/boost.h>
#include <stage/effects/playerTrail.h>
#include <stage/effects/shield.h>
#include <stage/effects/grind.h>
#include <stage/effects/trickSparkle.h>
#include <stage/effects/invincible.h>
#include <stage/effects/invincibleSparkle.h>
#include <stage/effects/snowSmoke.h>
#include <stage/effects/drownAlert.h>
#include <stage/effects/playerIcon.h>
#include <stage/effects/battleAttack.h>

// Misc Includes
#include <game/object/objectManager.h>
#include <game/stage/mapSys.h>
#include <game/system/allocator.h>
#include <game/stage/gameSystem.h>
#include <game/stage/bossHelpers.h>
#include <game/game/gameState.h>
#include <game/math/mtMath.h>
#include <game/math/akMath.h>
#include <game/object/objAction.h>
#include <game/object/obj.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/paletteAnimation.h>
#include <game/audio/spatialAudio.h>

#include <stage/enemies/robot.h>

// --------------------
// VARIABLES
// --------------------

// const u8 _0210EA44[2] = {61, 33};
// const u16 EffectButtonPrompt_animIDs[2] = {1, 0};
NOT_DECOMPILED const u8 _0210EA44[2];

// force string alignment when matching
// (it's likely stripped functions/variables caused the order to change)
#ifndef NON_MATCHING
static const char *aNsbtp = ".nsbtp";
static const char *aNsbca = ".nsbca";
static const char *aNsbma = ".nsbma";
static const char *aNsbva = ".nsbva";
static const char *aNsbta = ".nsbta";
#endif

static const char *iceSparklesSprite[2] = { "/act/ac_eff_ice_kira.bac", "/act/ac_eff_water_kira.bac" };

static const char *animationType[B3D_ANIM_MAX] = {
    [B3D_ANIM_JOINT_ANIM] = ".nsbca", [B3D_ANIM_MAT_ANIM] = ".nsbma", [B3D_ANIM_PAT_ANIM] = ".nsbtp", [B3D_ANIM_TEX_ANIM] = ".nsbta", [B3D_ANIM_VIS_ANIM] = ".nsbva"
};

static u16 goalJewelSpriteSize[10] = { 29, 22, 32, 9, 29, 36, 22, 32, 9, 36 };

typedef void (*EffectButtonPromptState)(EffectButtonPrompt *work);
EffectButtonPromptState const EffectButtonPrompt__states[2] = { EffectButtonPrompt__State_DPadUp, EffectButtonPrompt__State_JumpButton };

// --------------------
// FUNCTION DECLS
// --------------------

// Common
static void HandleEffectZScale(fx32 z, fx32 *a2, fx32 *scale);

// --------------------
// FUNCTIONS
// --------------------

// ==============
// EFFECT TASK
// ==============

StageTask *CreateEffectTask(size_t size, StageTask *parent)
{
    if (size < sizeof(StageTask))
        size = sizeof(StageTask);

#ifdef RUSH_DEBUG
    Task *task = TaskCreate_(StageTask_Main, StageTask_Destructor, TASK_FLAG_NONE, 0, 0x1800, TASK_GROUP(2), size, "StageEffectTask");
#else
    Task *task = TaskCreate_(StageTask_Main, StageTask_Destructor, TASK_FLAG_NONE, 0, 0x1800, TASK_GROUP(2), size);
#endif
    EffectTask__sVars.lastCreatedTask = task;

    if (task == HeapNull)
        return NULL;

    StageTask *work = TaskGetWork(task, StageTask);
    MI_CpuClear8(work, size);

    work->objType = STAGE_OBJ_TYPE_EFFECT;

    work->scale.x = work->scale.y = work->scale.z = FLOAT_TO_FX32(1.0);

    work->gravityStrength  = FLOAT_TO_FX32(0.1640625);
    work->terminalVelocity = FLOAT_TO_FX32(15.0);

    if (parent != NULL)
    {
        work->parentObj = parent;

        work->position.x = parent->position.x;
        work->position.y = parent->position.y;
        work->position.z = parent->position.z;
    }

    work->displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    return work;
}

StageTask *InitEffectTaskViewCheck(StageTask *work, s16 offset, s16 left, s16 top, s16 right, s16 bottom)
{
    SetTaskViewCheckFunc(work, StageTask__ViewCheck_Default);

    work->viewOutOffset             = offset;
    work->viewOutOffsetBoundsLeft   = left;
    work->viewOutOffsetBoundsTop    = top;
    work->viewOutOffsetBoundsRight  = right;
    work->viewOutOffsetBoundsBottom = bottom;

    work->flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
}

// ==============
// EFFECT TASK 3D
// ==============

void LoadEffectTask3DAsset(EffectTask3D *work, const char *path, OBS_DATA_WORK *fileWork, NNSiFndArchiveHeader *archive, u32 resourceFlags, StageTaskState nextState,
                           BOOL initResources)
{
    work->filePtr = fileWork;

    char tempPath[32];
    STD_CopyString(tempPath, path);
    STD_ConcatenateString(tempPath, ".nsbmd");

    NNSG3dResFileHeader *resource = ObjDataLoad(fileWork, tempPath, archive);
    if (resource != NULL)
    {
        if (archive)
            work->flags |= EFFECTTASK3D_FLAG_HAS_ARCHIVE;

        work->resource = resource;
        AnimatorMDL__Init(&work->animatorMDL, ANIMATORMDL_FLAG_NONE);

        if (initResources)
        {
            work->flags |= EFFECTTASK3D_FLAG_HAS_MODEL;
            if (fileWork == NULL || (fileWork != NULL && (fileWork->referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1))
                NNS_G3dResDefaultSetup(resource);
        }

        AnimatorMDL__Init(&work->animatorMDL, ANIMATORMDL_FLAG_NONE);
        AnimatorMDL__SetResource(&work->animatorMDL, resource, 0, FALSE, FALSE);

        VEC_Set(&work->animatorMDL.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

        for (s32 r = 0; r < B3D_ANIM_MAX; r++)
        {
            if ((resourceFlags & (1 << r)) != 0)
            {
                STD_CopyString(tempPath, path);
                STD_ConcatenateString(tempPath, animationType[r]);

                work->files[r] = ObjDataLoad(NULL, tempPath, archive);

                if (work->files[r] != NULL)
                {
                    if (archive != NULL)
                        work->flags |= (EFFECTTASK3D_FLAG_HAS_ANIM_JOINT << r);

                    if (r != B3D_ANIM_PAT_ANIM)
                        AnimatorMDL__SetAnimation(&work->animatorMDL, r, work->files[r], 0, NULL);
                }
            }
        }

        work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED;
        work->delay = 2;
        SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectTask3D_Destructor);

        if (nextState == NULL)
            work->nextState = (EffectTask3DState)EffectTask_State_DestroyAfterAnimation;
        else
            work->nextState = (EffectTask3DState)nextState;

        SetTaskState(&work->objWork, EffectTask3D_State_Init);
        SetTaskOutFunc(&work->objWork, EffectTask3D_Draw_3D);
    }
}

void EffectTask3D_State_Init(EffectTask3D *work)
{
    work->delay--;
    if (work->delay == 0)
    {
        if (work->files[B3D_ANIM_PAT_ANIM] != NULL)
        {
            AnimatorMDL__SetAnimation(&work->animatorMDL, B3D_ANIM_PAT_ANIM, work->files[2], 0, NNS_G3dGetTex(work->resource));
        }

        work->objWork.displayFlag &= ~(DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED);
        SetTaskState(&work->objWork, work->nextState);
    }
}

void EffectTask3D_Draw_3D(void)
{
    EffectTask3D *curWork = TaskGetWorkCurrent(EffectTask3D);
    StageTask__Draw3D(&curWork->objWork, &curWork->animatorMDL.work);
}

void EffectTask3D_Destructor(Task *task)
{
    EffectTask3D *work = TaskGetWork(task, EffectTask3D);

    AnimatorMDL__Release(&work->animatorMDL);

    if (work->filePtr != NULL)
    {
        if ((work->flags & EFFECTTASK3D_FLAG_HAS_MODEL) != 0 && (work->filePtr->referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
            NNS_G3dResDefaultRelease(work->resource);

        ObjDataRelease(work->filePtr);
    }
    else
    {
        if ((work->flags & EFFECTTASK3D_FLAG_HAS_MODEL) != 0)
            NNS_G3dResDefaultRelease(work->resource);

        if ((work->flags & EFFECTTASK3D_FLAG_HAS_ARCHIVE) == 0)
            HeapFree(HEAP_USER, work->resource);
    }

    for (s32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (work->files[r] != NULL && (work->flags & (EFFECTTASK3D_FLAG_HAS_ANIM_JOINT << r)) == 0)
            HeapFree(HEAP_USER, work->files[r]);
    }

    StageTask_Destructor(task);
}

// ==============
// COMMON STATES
// ==============

void EffectTask_State_DestroyAfterAnimation(StageTask *work)
{
    if ((work->displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(work);
}

void EffectTask_State_DestroyAfterTime(StageTask *work)
{
    work->userTimer -= GetObjSpeed();

    if (work->userTimer <= 0)
        DestroyStageTask(work);
}

void EffectTask_State_MoveTowardsZeroX(StageTask *work)
{
    work->velocity.x = ObjSpdDownSet(work->velocity.x, work->userTimer);
}

void EffectTask_State_TrackParent(StageTask *work)
{
    StageTask *parent = work->parentObj;
    if (parent != NULL)
    {
        work->position.x = parent->position.x;
        work->position.y = parent->position.y;
        work->position.z = parent->position.z;

        if ((work->userFlag & 1) != 0)
        {
            work->displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            work->displayFlag |= parent->displayFlag & DISPLAY_FLAG_FLIP_X;
        }

        if ((work->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->position.x -= work->velocity.x;
        else
            work->position.x += work->velocity.x;

        work->position.y += work->velocity.y;
        work->position.z += work->velocity.z;
    }

    if ((work->displayFlag & DISPLAY_FLAG_DISABLE_LOOPING) != 0)
    {
        if (work->userTimer == 0)
        {
            DestroyStageTask(work);
            return;
        }

        work->userTimer--;
    }
    else if ((work->displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        if (work->userTimer == 0)
        {
            DestroyStageTask(work);
            return;
        }

        work->userTimer--;
    }
}

// ==============
// EXPLOSION
// ==============

EffectExplosion *CreateEffectExplosion(StageTask *parent, fx32 velX, fx32 velY, ExplosionType type)
{
    EffectExplosion *work = CreateEffect(EffectExplosion, NULL);
    if (work == NULL)
        return NULL;

    if (type >= EXPLOSION_COUNT)
        type = EXPLOSION_ENEMY;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_zako_bomb.bac", &EffectTask__sVars.effectExplosionFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 83);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, type);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x;
    work->objWork.position.y = parent->position.y;

    if (parent->fallDir != FLOAT_DEG_TO_IDX(0.0))
    {
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
        work->objWork.dir.z = parent->fallDir;
        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    }

    if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    StageTask__ObjectSpdDirFall(&velX, &velY, parent->fallDir);
    work->objWork.position.x += velX;
    work->objWork.position.y += velY;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// ==============
// EXPLOSION2
// ==============

EffectExplosionHazard *CreateEffectExplosionHazard(StageTask *parent, fx32 velX, fx32 velY, s16 left, s16 top, s16 right, s16 bottom, u16 targetFrame, ExplosionType type)
{
    EffectExplosionHazard *work = CreateEffect(EffectExplosionHazard, NULL);
    if (work == NULL)
        return NULL;

    if (type >= EXPLOSION_COUNT)
        type = EXPLOSION_ENEMY;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_zako_bomb.bac", &EffectTask__sVars.effectExplosionFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 83);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, type);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x;
    work->objWork.position.y = parent->position.y;

    if (parent->fallDir != FLOAT_DEG_TO_IDX(0.0))
    {
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
        work->objWork.dir.z = parent->fallDir;
        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    }

    if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    StageTask__ObjectSpdDirFall(&velX, &velY, parent->fallDir);
    work->objWork.position.x += velX;
    work->objWork.position.y += velY;

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskState(&work->objWork, EffectExplosionHazard_State_Active);
    work->targetFrame = targetFrame;

    StageTask__InitCollider(&work->objWork, &work->collider, 0, STAGE_TASK_COLLIDER_FLAGS_NONE);
    ObjRect__SetGroupFlags(&work->collider, 2, 1);
    ObjRect__SetAttackStat(&work->collider, 2, 0x40);
    ObjRect__SetDefenceStat(&work->collider, 0, 0x3F);
    work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    ObjRect__SetBox2D(&work->collider.rect, left, top, right, bottom);

    return work;
}

void EffectExplosionHazard_State_Active(EffectExplosionHazard *work)
{
    EffectTask_State_DestroyAfterAnimation(&work->objWork);

    if (work->objWork.obj_2d->ani.work.animFrameIndex == work->targetFrame)
        work->collider.flag |= OBS_RECT_WORK_FLAG_800;
}

// ==============
// FOUND
// ==============

EffectFound *CreateEffectFound(StageTask *parent, fx32 velX, fx32 velY)
{
    EffectFound *work = CreateEffect(EffectFound, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_found.bac", &EffectTask__sVars.effectFoundFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 56);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if (parent->fallDir != FLOAT_DEG_TO_IDX(0.0))
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    work->objWork.dir.z = parent->fallDir;

    StageTask__ObjectSpdDirFall(&velX, &velY, parent->fallDir);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.shakeTimer = FLOAT_TO_FX32(4.0);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    SetTaskState(&work->objWork, EffectTask_State_TrackParent);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FIND);
    ProcessSpatialSfx(NULL, &work->objWork.position);

    return work;
}

// ==============
// VITALITY
// ==============

EffectVitality *CreateEffectVitality(StageTask *parent, fx32 velX, fx32 velY, u8 health)
{
    EffectVitality *work = CreateEffect(EffectVitality, parent);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_vitality.bac", &EffectTask__sVars.effectVitalityFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 81);
    StageTask__SetAnimation(&work->objWork, (health - 1));
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if (parent->fallDir)
    {
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    work->objWork.dir.z = parent->fallDir;
    StageTask__ObjectSpdDirFall(&velX, &velY, parent->fallDir);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.shakeTimer = FLOAT_TO_FX32(8.0);
    work->objWork.moveFlag |= (STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.userTimer = 60;
    SetTaskState(&work->objWork, EffectTask_State_TrackParent);

    return work;
}

// ==============
// ENEMY DEBRIS
// ==============

EffectEnemyDebris *CreateEffectEnemyDebris(StageTask *parent, fx32 offsetX, fx32 offsetY, fx32 velX, fx32 velY, EnemyDebrisType type)
{
    EffectEnemyDebris *work = CreateEffect(EffectEnemyDebris, NULL);

    if (work == NULL)
        return NULL;

    u16 spriteType;
    if (type < ENEMYDEBRIS_RANDOM)
    {
        spriteType = type & 3;
    }
    else
    {
        spriteType = mtMathRandRepeat(4);
    }

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_zako_bomb.bac", &EffectTask__sVars.effectExplosionFile, gameArchiveCommon, 2);
    s32 anim = spriteType + 3;
    ObjActionAllocSpritePalette(&work->objWork, anim, 83);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);

    if ((parent->flag & STAGE_TASK_FLAG_ON_PLANE_B) != 0)
    {
        work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
        StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);
    }
    else
    {
        StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    }

    StageTask__SetAnimation(&work->objWork, anim);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.displayFlag |= parent->displayFlag & DISPLAY_FLAG_FLIP_X;
    work->objWork.position.x = parent->position.x;
    work->objWork.position.y = parent->position.y;

    work->objWork.fallDir = parent->fallDir;
    StageTask__ObjectSpdDirFall(&offsetX, &offsetY, work->objWork.fallDir);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.position.x -= offsetX;
        work->objWork.velocity.x = -work->objWork.velocity.x;
    }
    else
    {
        work->objWork.position.x += offsetX;
    }

    work->objWork.position.y += offsetY;

    if (type >= ENEMYDEBRIS_COIL_RANDOM && type != ENEMYDEBRIS_RANDOM)
    {
        work->objWork.velocity.x += FLOAT_TO_FX32(4.0) - (0x7FFF & mtMathRand());
        work->objWork.velocity.y += (u32) - ((0x7FFF - FLOAT_TO_FX32(4.0)) & mtMathRand());

        work->objWork.position.x += FLOAT_TO_FX32(16.0) - ((0x7FFF + FLOAT_TO_FX32(24.0)) & mtMathRand());
        work->objWork.position.y += FLOAT_TO_FX32(16.0) - ((0x7FFF + FLOAT_TO_FX32(24.0)) & mtMathRand());
    }

    StageTask__SetHitbox(&work->objWork, -2, -4, 2, 4);
    work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_IN_AIR;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    SetTaskState(&work->objWork, EffectEnemyDebris_State_Active);

    return work;
}

void EffectEnemyDebris_State_Active(EffectEnemyDebris *work)
{
    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT) != 0)
    {
        work->objWork.userWork++;
        if (work->objWork.userWork >= 48)
        {
            DestroyStageTask(&work->objWork);
        }
        else if (work->objWork.userWork > 32)
        {
            if ((work->objWork.userWork & 2) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
            else
                work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
        }
    }
    else if (work->objWork.userTimer == 0)
    {
        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            work->objWork.userTimer++;
            work->objWork.velocity.y = -(work->objWork.move.y >> 1);
            work->objWork.velocity.x >>= 1;
            work->objWork.shakeTimer = FLOAT_TO_FX32(4.0);
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
            work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        }
    }
    else
    {
        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            work->objWork.shakeTimer = FLOAT_TO_FX32(4.0);
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
            work->objWork.velocity.x = work->objWork.velocity.y = FLOAT_TO_FX32(0.0);
        }
    }
}

// ===============
// WATER EXPLOSION
// ===============

EffectWaterExplosion *CreateEffectWaterExplosion(StageTask *parent, fx32 velX, fx32 velY, WaterExplosionType type)
{
    u8 gfxSizes[] = { 32, 4 };

    EffectWaterExplosion *work = CreateEffect(EffectWaterExplosion, NULL);

    if (work == NULL)
        return NULL;

    if (type >= WATEREXPLOSION_COUNT)
        type = WATEREXPLOSION_BOMB;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_bomb_water.bac", GetObjectFileWork(OBJDATAWORK_4), gameArchiveCommon, gfxSizes[type]);
    ObjActionAllocSpritePalette(&work->objWork, 0, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, type);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x;
    work->objWork.position.y = parent->position.y;
    StageTask__ObjectSpdDirFall(&velX, &velY, parent->fallDir);
    work->objWork.position.x += velX;
    work->objWork.position.y += velY;

    switch (type)
    {
        // case WATEREXPLOSION_BUBBLES:
        default:
            work->objWork.velocity.y = -FLOAT_TO_FX32(1.0) - (0x3FF & mtMathRand());

            if (mtMathRandRepeat(2) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;

        case WATEREXPLOSION_BOMB:
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

            if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;
    }

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// ================
// GROUND EXPLOSION
// ================

EffectGroundExplosion *CreateEffectGroundExplosion(StageTask *parent, fx32 velX, fx32 velY)
{
    EffectGroundExplosion *work = CreateEffect(EffectGroundExplosion, NULL);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_bomb_ground.bac", GetObjectFileWork(OBJDATAWORK_151), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 83);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x;
    work->objWork.position.y = parent->position.y;

    if (parent->fallDir != FLOAT_DEG_TO_IDX(0.0))
    {
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
        work->objWork.dir.z = parent->fallDir;
        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    }

    if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    StageTask__ObjectSpdDirFall(&velX, &velY, parent->fallDir);
    work->objWork.position.x += velX;
    work->objWork.position.y += velY;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// ==============
// BATTLE BURST
// ==============

EffectBattleBurst *CreateEffectBattleBurst(fx32 x, fx32 y)
{
    EffectBattleBurst *work = CreateEffect(EffectBattleBurst, NULL);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_battle.bac", &EffectTask__sVars.effectBattleBurstFile, gameArchiveCommon, 8);
    ObjActionAllocSpritePalette(&work->objWork, 4, 31);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, 4);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = x;
    work->objWork.position.y = y;

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// ===================
// STEAM BLASTER SMOKE
// ===================

EffectSteamBlasterSmoke *CreateEffectSteamBlasterSmoke(StageTask *parent)
{
    EffectSteamBlasterSmoke *work = CreateEffect(EffectSteamBlasterSmoke, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_ene_prot_damp.bac", GetObjectFileWork(OBJDATAWORK_7), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, STEAMBLASTER_ANI_SMOKE, 36);
    StageTask__SetAnimation(&work->objWork, STEAMBLASTER_ANI_SMOKE);
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = parent->position.x;
    work->objWork.position.y = parent->position.y;

    work->objWork.parentObj = parent;
    SetTaskState(&work->objWork, EffectSteamBlasterSmoke_State_Active);

    return work;
}

void EffectSteamBlasterSmoke_State_Active(EffectSteamBlasterSmoke *work)
{
    if ((s32)work->objWork.parentObj->obj_2d->ani.work.animID != STEAMBLASTER_ANI_MOVE && work->objWork.parentObj->obj_2d->ani.work.animID != STEAMBLASTER_ANI_DETECT)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    }
    else
    {
        work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
        work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

        work->objWork.displayFlag |= work->objWork.parentObj->displayFlag & DISPLAY_FLAG_FLIP_X;

        work->objWork.position.x = work->objWork.parentObj->position.x;
        work->objWork.position.y = work->objWork.parentObj->position.y;
    }
}

// EffectSteamBlasterSmoke
EffectSteamBlasterSteam *CreateEffectSteamBlasterSteam(StageTask *parent, fx32 offsetX, fx32 offsetY, u32 timer)
{
    EffectSteamBlasterSteam *work = CreateEffect(EffectSteamBlasterSteam, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_ene_prot_damp.bac", GetObjectFileWork(OBJDATAWORK_7), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, STEAMBLASTER_ANI_STEAM_START, 34);
    StageTask__SetAnimation(&work->objWork, STEAMBLASTER_ANI_STEAM_START);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.position.x = parent->position.x - offsetX;
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }
    else
    {
        work->objWork.position.x = parent->position.x + offsetX;
    }

    work->objWork.position.y = parent->position.y + offsetY;
    work->objWork.parentObj  = parent;
    work->objWork.userTimer  = timer;

    SetTaskState(&work->objWork, EffectSteamBlasterSteam_State_Active);

    return work;
}

void EffectSteamBlasterSteam_State_Active(EffectSteamBlasterSteam *work)
{
    if (work->objWork.parentObj != NULL && (work->objWork.parentObj->displayFlag & DISPLAY_FLAG_PAUSED) != 0)
    {
        work->objWork.flag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }
    else
    {
        switch (work->objWork.obj_2d->ani.work.animID)
        {
            case STEAMBLASTER_ANI_STEAM_START:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    StageTask__SetAnimation(&work->objWork, STEAMBLASTER_ANI_STEAM_ACTIVE);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;

            case STEAMBLASTER_ANI_STEAM_ACTIVE:
                work->objWork.userTimer--;
                if (work->objWork.userTimer <= 0)
                    StageTask__SetAnimation(&work->objWork, STEAMBLASTER_ANI_STEAM_END);
                break;

                // case STEAMBLASTER_ANI_STEAM_END:
            default:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    work->objWork.flag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;
        }
    }
}

// EffectWater
EffectWaterSplash *CreateEffectWaterSplash(StageTask *parent, fx32 offsetX, fx32 positionY, fx32 offsetY)
{
    EffectWaterSplash *work = CreateEffect(EffectWaterSplash, NULL);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_water.bac", &EffectTask__sVars.effectWaterSplashFile, gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, WATERBUBBLE_ANI_SPLASH, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if (MATH_ABS(parent->velocity.y) > FLOAT_TO_FX32(6.0))
        StageTask__SetAnimation(&work->objWork, WATERBUBBLE_ANI_BIG_SPLASH);
    else
        StageTask__SetAnimation(&work->objWork, WATERBUBBLE_ANI_SPLASH);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x + offsetX;
    work->objWork.position.y = positionY + FX32_FROM_WHOLE(offsetY);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
    return work;
}

EffectWaterWake *CreateEffectWaterWake(StageTask *parent, fx32 offsetX, fx32 positionY, fx32 offsetY, u16 type)
{
    EffectWaterWake *work = CreateEffect(EffectWaterWake, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_water.bac", &EffectTask__sVars.effectWaterSplashFile, gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, WATERBUBBLE_ANI_SPLASH, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    u16 anim;
    switch (type)
    {
        case 0:
        default:
            anim = WATERBUBBLE_ANI_SMALL_SPLASH;
            break;

        case 1:
            anim = WATERBUBBLE_ANI_SMALL_WAKE;
            break;

        case 2:
            anim = WATERBUBBLE_ANI_WATER_WAKE;
            break;
    }
    StageTask__SetAnimation(&work->objWork, anim);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x + offsetX;
    work->objWork.position.y = positionY + FX32_FROM_WHOLE(offsetY);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    if (parent->objType == STAGE_OBJ_TYPE_PLAYER)
    {
        if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }
    else
    {
        if ((parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        }
    }

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
    return work;
}

EffectWaterGush *EffectWaterGush__Create(StageTask *parent, fx32 velX, fx32 velY, s32 type)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    EffectWaterGush *work = CreateEffect(EffectWaterGush, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_water.bac", &EffectTask__sVars.effectWaterSplashFile, gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, WATERBUBBLE_ANI_SPLASH, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, WATERBUBBLE_ANI_GUSH_H);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = parent->position.x + velX;
    work->objWork.position.y = parent->position.y + velY;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    if (velX >= FLOAT_TO_FX32(0.0))
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (type == 0)
    {
        SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
    }
    else
    {
        work->objWork.parentObj = parent;
        SetTaskState(&work->objWork, EffectTask_State_TrackParent);

        work->objWork.velocity.x = velX;
        work->objWork.velocity.y = velY;
    }

    return work;
}

EffectWaterBubble *EffectWaterBubble__Create(fx32 x, fx32 y, s32 anim, u16 duration)
{
    EffectWaterBubble *work = CreateEffect(EffectWaterBubble, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_awa.bac", GetObjectFileWork(OBJDATAWORK_122), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, WATERBUBBLE_ANI_TINY_BUBBLE, 22);
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, anim), GetObjectFileWork(2 * anim + OBJDATAWORK_123));
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, anim);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = x;
    work->objWork.position.y = y;

    work->objWork.userWork = FX32_FROM_WHOLE(duration + 8);

    work->objWork.velocity.y = mtMathRandRange(-0x800, 0x800);
    work->objWork.userTimer  = 0x2BFF - (0xFFE & mtMathRand());
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    SetTaskState(&work->objWork, EffectWaterBubble__State_202A198);
    return work;
}

void EffectWaterBubble__State_202A198(EffectWaterBubble *work)
{
    OBS_COL_CHK_DATA colData;

    colData.x    = FX32_TO_WHOLE(work->objWork.position.x);
    colData.y    = FX32_TO_WHOLE(work->objWork.position.y);
    colData.flag = OBJ_COL_FLAG_USE_PLANE_B;
    colData.vec  = OBJ_COL_VEC_VERTICAL;
    colData.dir  = NULL;
    colData.attr = NULL;

    s32 collideDistY = ObjDiffCollisionFast(&colData);
    if (work->objWork.position.y <= work->objWork.userWork || collideDistY < 0)
    {
        DestroyStageTask(&work->objWork);
    }
    else
    {
        work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, -FLOAT_TO_FX32(0.05078125), work->objWork.userTimer);
        work->objWork.velocity.x = work->objWork.velocity.y >> 1;

        if ((playerGameStatus.stageTimer & 2) != 0)
            work->objWork.velocity.x = -work->objWork.velocity.x;
    }
}

// EffectCoralDebris
EffectCoralDebris *EffectCoralDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u8 type)
{
    type = MATH_MIN(type, 2);

    EffectCoralDebris *work = CreateEffect(EffectCoralDebris, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_dec_coral.bac", GetObjectFileWork(OBJDATAWORK_193), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, type + 20, 67);

    u16 anim = type + 20;
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type + 20), GetObjectSpriteRef(2 * type + OBJDATAWORK_194));
    StageTask__SetAnimation(&work->objWork, anim);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    if (mtMathRandRepeat(2) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (mtMathRandRepeat(2) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

// EffectBridgeDebris
EffectBridgeDebris *EffectBridgeDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u8 type)
{
    type = MATH_MIN(type, 1);

    EffectBridgeDebris *work = CreateEffect(EffectBridgeDebris, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_dec_saku.bac", GetObjectFileWork(OBJDATAWORK_168), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, type + 3, 89);

    u16 anim = type + 3;
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type + 3), GetObjectSpriteRef(2 * type + OBJDATAWORK_169));
    StageTask__SetAnimation(&work->objWork, anim);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    if (mtMathRandRepeat(2) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (mtMathRandRepeat(2) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

// EffectIceSparkles
EffectIceSparkles *EffectIceSparkles__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, s32 type)
{
    type = MTM_MATH_CLIP(type, 0, 2);

    EffectIceSparkles *work = CreateEffect(EffectIceSparkles, NULL);
    if (!work)
        return 0;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, iceSparklesSprite[type], GetObjectDataWork(type + OBJDATAWORK_154), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, _0210EA44[type]);
    StageTask__SetAnimation(&work->objWork, 0);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// EffectStartDash
EffectStartDash *EffectStartDash__Create(StageTask *parent)
{
    EffectStartDash *work = CreateEffect(EffectStartDash, NULL);
    if (work == NULL)
        return NULL;

    LoadEffectTask3DAsset(&work->effWork, "/effe_startdash", NULL, gameArchiveCommon, B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, NULL, FALSE);
    work->effWork.objWork.parentObj = parent;

    work->effWork.objWork.position = parent->position;

    work->effWork.objWork.position.x += FLOAT_TO_FX32(50.0);
    work->effWork.objWork.position.y += FLOAT_TO_FX32(20.0);

    work->effWork.objWork.velocity.x = FLOAT_TO_FX32(6.0);

    return work;
}

// EffectBreakableObjDebris
EffectBreakableObjDebris *EffectBreakableObjDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u8 type)
{
    type = MATH_MIN(type, 1);

    EffectBreakableObjDebris *work = CreateEffect(EffectBreakableObjDebris, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_break_obj.bac", GetObjectFileWork(OBJDATAWORK_54), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, type, 6);

    u16 anim = type + 1;
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type + 1), GetObjectSpriteRef(2 * type + OBJDATAWORK_57));
    StageTask__SetAnimation(&work->objWork, anim);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

// EffectGoalJewel
EffectGoalJewel *EffectGoalJewel__Create(u16 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    type = MATH_MIN(type, 9);

    EffectGoalJewel *work = CreateEffect(EffectGoalJewel, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->aniEffect, "/ac_eff_goal_jewel.bac", GetObjectDataWork(OBJDATAWORK_128), gameArchiveCommon, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->objWork, goalJewelSpriteSize[type], GetObjectSpriteRef(2 * type + OBJDATAWORK_129));
    ObjActionAllocSpritePalette(&work->objWork, type, 23);
    StageTask__SetAnimation(&work->objWork, type);
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    AnimatorSpriteDS *aniJewel = &work->objWork.obj_2d->ani;
    if ((GetObjectSpriteRef(2 * type + OBJDATAWORK_129)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
    {
        aniJewel->work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
        AnimatorSpriteDS__ProcessAnimationFast(aniJewel);
        StageTask__SetAnimation(&work->objWork, type);
    }
    aniJewel->work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 24, 0, 0, 0, 0);

    return work;
}

// EffectFlipMush
EffectBouncyMushroomPuff *EffectBouncyMushroomPuff__Create(fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    EffectBouncyMushroomPuff *work = CreateEffect(EffectBouncyMushroomPuff, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_flipmush.bac", GetObjectFileWork(OBJDATAWORK_166), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, FLIPMUSHROOM_ANI_PUFF, 15);
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, FLIPMUSHROOM_ANI_PUFF), GetObjectSpriteRef(OBJDATAWORK_171));
    StageTask__SetAnimation(&work->objWork, FLIPMUSHROOM_ANI_PUFF);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x     = x;
    work->objWork.position.y     = y;
    work->objWork.velocity.x     = velX;
    work->objWork.velocity.y     = velY;
    work->objWork.acceleration.x = -velX >> 5;
    work->objWork.acceleration.y = -velY >> 5;

    InitEffectTaskViewCheck(&work->objWork, 64, 0, 0, 0, 0);

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// EffectFlowerPipePetal
EffectFlowerPipePetal *EffectFlowerPipePetal__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type)
{
    EffectFlowerPipePetal *work = CreateEffect(EffectFlowerPipePetal, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_pipe_flw.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage, 8);
    ObjActionAllocSpritePalette(&work->objWork, 3, 10);
    StageTask__SetAnimation(&work->objWork, type + 3);
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 256, 0, 0, 0, 0);

    if (velX >= FLOAT_TO_FX32(0.0))
    {
        work->objWork.userWork = 1;
    }
    else
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        work->objWork.userWork = -1;
    }

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.gravityStrength  = FLOAT_TO_FX32(0.0625);
    work->objWork.terminalVelocity = FLOAT_TO_FX32(3.0);

    SetTaskState(&work->objWork, EffectFlowerPipePetal__State_202AC78);

    return work;
}

void EffectFlowerPipePetal__State_202AC78(EffectFlowerPipePetal *work)
{
    if (work->objWork.velocity.y > FLOAT_TO_FX32(1.0))
    {
        work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, work->objWork.userWork * FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(3.0));

        if (work->objWork.velocity.x == FLOAT_TO_FX32(3.0) * work->objWork.userWork)
            work->objWork.userWork = -work->objWork.userWork;
    }
    else
    {
        work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625));
    }
}

// EffectFlowerPipeSeed
EffectFlowerPipeSeed *EffectFlowerPipeSeed__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type)
{
    EffectFlowerPipeSeed *work = CreateEffect(EffectFlowerPipeSeed, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_pipe_flw.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage, 1);
    ObjActionAllocSpritePalette(&work->objWork, 5, 10);
    StageTask__SetAnimation(&work->objWork, type + 5);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 256, 0, 0, 0, 0);

    if (velX >= FLOAT_TO_FX32(0.0))
    {
        work->objWork.userWork = 1;
    }
    else
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        work->objWork.userWork = -1;
    }

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.gravityStrength  = FLOAT_TO_FX32(0.0625);
    work->objWork.terminalVelocity = FLOAT_TO_FX32(2.5);

    SetTaskState(&work->objWork, EffectFlowerPipeSeed__State_202ADFC);

    return work;
}

void EffectFlowerPipeSeed__State_202ADFC(EffectFlowerPipeSeed *work)
{
    if (work->objWork.velocity.y > FLOAT_TO_FX32(1.0))
    {
        work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, work->objWork.userWork * FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(0.5));

        if (work->objWork.velocity.x == work->objWork.userWork * FLOAT_TO_FX32(0.5))
            work->objWork.userWork = -work->objWork.userWork;

        work->objWork.userTimer++;
        if (work->objWork.userTimer >= 120)
        {
            DestroyStageTask(&work->objWork);
        }
        else if (work->objWork.userTimer > 90)
        {
            work->objWork.displayFlag ^= DISPLAY_FLAG_NO_DRAW;
        }
    }
    else
    {
        work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.015625));
    }
}

// EffectSteam
EffectSteam *EffectSteamDust__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    type = MATH_MIN(type, 1);

    EffectSteam *work = CreateEffect(EffectSteam, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_steam_dust.bac", GetObjectFileWork(OBJDATAWORK_160), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, 0, 32);

    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type), GetObjectSpriteRef(2 * type + OBJDATAWORK_161));
    StageTask__SetAnimation(&work->objWork, type);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

EffectSteam *EffectSteamEffect__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY, s32 timer)
{
    type = MATH_MIN(type, EFFECTSTEAM_TYPE_COUNT - 1);

    EffectSteam *work = CreateEffect(EffectSteam, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_steam_efct.bac", GetObjectDataWork(OBJDATAWORK_179), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, 0, 34);
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type), GetObjectSpriteRef(EFFECTSTEAM_TYPE_COUNT * type + OBJDATAWORK_180));
    StageTask__SetAnimation(&work->objWork, type);
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    AnimatorSpriteDS *aniDust = &work->objWork.obj_2d->ani;
    if ((GetObjectSpriteRef(EFFECTSTEAM_TYPE_COUNT * type + OBJDATAWORK_180)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
    {
        aniDust->work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
        AnimatorSpriteDS__ProcessAnimationFast(aniDust);
        StageTask__SetAnimation(&work->objWork, type);
    }
    aniDust->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    switch (type)
    {
        // case EFFECTSTEAM_TYPE_SMALL:
        default:
            StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_14);
            StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);
            break;

        case EFFECTSTEAM_TYPE_LARGE:
            StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
            StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);
            break;
    }

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.userTimer  = timer;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterTime);

    return work;
}

// EffectSteamFan
EffectSteamFan *EffectCreateSteamFan(StageTask *parent, s32 radius, u16 angle, s32 rotationSpeed)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    EffectSteamFan *work = CreateEffect(EffectSteamFan, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_steam_fan.bac", GetObjectDataWork(OBJDATAWORK_165), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, 0, 34);
    ObjObjectActionAllocSprite(&work->objWork, 24, GetObjectSpriteRef(OBJDATAWORK_168));
    StageTask__SetAnimation(&work->objWork, 1);

    AnimatorSpriteDS *aniSteam = &work->objWork.obj_2d->ani;
    if ((GetObjectSpriteRef(OBJDATAWORK_168)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
    {
        aniSteam->work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
        AnimatorSpriteDS__ProcessAnimationFast(aniSteam);
        StageTask__SetAnimation(&work->objWork, 1);
    }
    aniSteam->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    work->objWork.displayFlag |= parent->displayFlag & DISPLAY_FLAG_FLIP_X;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_14);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->objWork.parentObj = parent;
    work->objWork.userTimer = radius;
    work->objWork.userWork  = rotationSpeed;
    work->objWork.dir.z     = angle;

    work->objWork.position.x = parent->position.x + MultiplyFX(CosFX((s32)angle), radius);
    work->objWork.position.y = parent->position.y + MultiplyFX(SinFX((s32)angle), radius);

    SetTaskState(&work->objWork, EffectSteamFan__State_202B324);

    return work;
}

void EffectSteamFan__State_202B324(EffectSteamFan *work)
{
    fx32 radius = work->objWork.userTimer + (FX32_FROM_WHOLE(mtMathRandRepeat(4)));

    work->objWork.dir.z += (u16)work->objWork.userWork;

    work->objWork.position.x = work->objWork.parentObj->position.x + MultiplyFX(CosFX(work->objWork.dir.z), radius);
    work->objWork.position.y = work->objWork.parentObj->position.y + MultiplyFX(SinFX(work->objWork.dir.z), radius);

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->objWork);
}

// EffectPiston
EffectPiston *EffectPiston__Create(VecFx32 *position, VecU16 *dir)
{
    EffectPiston *work = CreateEffect(EffectPiston, NULL);
    if (work == NULL)
        return NULL;

    LoadEffectTask3DAsset(&work->effWork, "/mod/gmk_piston_ef", GetObjectDataWork(OBJDATAWORK_191), gameArchiveStage, B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                          EffectTask_State_TrackParent, 0);

    // ~3.63
    VEC_Set(&work->effWork.animatorMDL.work.scale, FLOAT_TO_FX32(3.629638671875), FLOAT_TO_FX32(3.629638671875), FLOAT_TO_FX32(3.629638671875));

    work->effWork.objWork.position = *position;
    work->effWork.objWork.dir      = *dir;

    work->effWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->effWork.objWork.displayFlag |= DISPLAY_FLAG_APPLY_CAMERA_CONFIG;
    work->effWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    return work;
}

// EffectIceBlock
EffectIceBlockDebris *EffectIceBlockDebris__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    type = MATH_MIN(type, 3);

    EffectIceBlockDebris *work = CreateEffect(EffectIceBlockDebris, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_ice_block.bac", GetObjectFileWork(OBJDATAWORK_175), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, 0, 35);

    u16 anim = type + 1;
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type + 1), GetObjectSpriteRef(2 * type + OBJDATAWORK_178));
    StageTask__SetAnimation(&work->objWork, anim);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

// EffectTruckSparkles
void EffectTruckSparkles__Create(StageTask *parent, u16 duration, s32 userWork, fx32 offsetX, fx32 offsetY, u32 flags)
{
    s32 i;

    EffectTruckSparkles *work = CreateEffect(EffectTruckSparkles, NULL);
    if (work == NULL)
        return;

    SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectTruckSparkles__Destructor);

    AnimatorSpriteDS *aniSparkle2;
    AnimatorSpriteDS *aniSparkle = work->aniSparkles;
    i                            = 0;
    u32 id                       = OBJDATAWORK_184;
    for (; i < 3; i++)
    {
        aniSparkle2 = aniSparkle++;

        void *archive = gameArchiveStage;
        ObjAction2dBACLoad(aniSparkle2, "/act/ac_gmk_truck.bac", OBJ_DATA_GFX_NONE, GetObjectDataWork(OBJDATAWORK_180), archive);
        aniSparkle2->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

        ObjActionAllocSpriteDS(aniSparkle2, Sprite__GetSpriteSize2FromAnim(aniSparkle2->work.fileData, i + 1), GetObjectSpriteRef(id));
        AnimatorSpriteDS__SetAnimation(aniSparkle2, i + 1);

        if ((GetObjectSpriteRef(OBJDATAWORK_184)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) <= 1)
            AnimatorSpriteDS__ProcessAnimationFast(aniSparkle2);

        aniSparkle2->work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
        StageTask__SetOAMOrder(&aniSparkle2->work, SPRITE_ORDER_12);
        StageTask__SetOAMPriority(&aniSparkle2->work, SPRITE_PRIORITY_2);

        // sure, whatever I guess
        aniSparkle++;
        aniSparkle--;

        id += 2;
    }

    u16 palette = ObjDrawAllocSpritePalette(aniSparkle2->work.fileData, 1, 58);
    for (i = 0; i < 3; i++)
    {
        work->aniSparkles[i].cParam[0].palette = work->aniSparkles[i].cParam[1].palette = work->aniSparkles[i].work.cParam.palette = palette;
    }

    work->duration = duration;
    work->flags    = flags;

    work->position.x = parent->position.x + offsetX;
    work->position.y = parent->position.y + offsetY;

    work->objWork.userWork = userWork;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    SetTaskOutFunc(&work->objWork, EffectTruckSparkles__Draw);
    SetTaskState(&work->objWork, EffectTruckSparkles__State_202B86C);
}

void EffectTruckSparkles__Destructor(Task *task)
{
    s32 i;
    AnimatorSpriteDS *aniSparkles;
    u32 id;

    EffectTruckSparkles *work = TaskGetWork(task, EffectTruckSparkles);

    id          = OBJDATAWORK_184;
    aniSparkles = &work->aniSparkles[0];
    for (i = 0; i < 3; i++)
    {
        ObjActionReleaseSpriteDS(GetObjectFileWork(id));

        aniSparkles->vramPixels[0] = NULL;
        aniSparkles->vramPixels[1] = NULL;

        ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_179), aniSparkles);

        aniSparkles++;
        id += 2;
    }

    StageTask_Destructor(task);
}

void EffectTruckSparkles__State_202B86C(EffectTruckSparkles *work)
{
    s32 id = -1;

    fx32 moveX = ((work->flags & 1) != 0) ? -FLOAT_TO_FX32(4.0) : FLOAT_TO_FX32(4.0);
    fx32 moveY = ((work->flags & 2) != 0) ? -FLOAT_TO_FX32(4.0) : FLOAT_TO_FX32(4.0);

    work->objWork.userTimer--;

    for (s32 i = 0; i < EFFECT_TRUCK_SPARKLES_PARTICLE_COUNT; i++)
    {
        if ((work->flagsBitfield[i >> 5] & (1 << (i & 0x1F))) == 0)
        {
            id = i;
            continue;
        }

        work->positionList[i].x += moveX;
        work->positionList[i].y += moveY;
    }

    if (work->objWork.userTimer <= 0 && id != -1)
    {
        u8 sparkleType[] = { 0, 1, 2, 2 };

        work->objWork.userTimer = work->objWork.userWork;
        work->flagsBitfield[id >> 5] |= 1 << (id & 0x1F);

        work->positionList[id].x = work->position.x + FX32_FROM_WHOLE(mtMathRandRepeat(32) - 15);
        work->positionList[id].y = work->position.y + FX32_FROM_WHOLE(mtMathRandRepeat(32) - 15);

        MI_CpuCopy8(&work->aniSparkles[sparkleType[mtMathRandRepeat(4)]], &work->animatorList[id], sizeof(work->animatorList[0]));

        work->duration--;
        if (work->duration == 0)
            SetTaskState(&work->objWork, EffectTruckSparkles__State_202BA48);
    }
}

void EffectTruckSparkles__State_202BA48(EffectTruckSparkles *work)
{
    fx32 moveX = ((work->flags & 1) != 0) ? -FLOAT_TO_FX32(4.0) : FLOAT_TO_FX32(4.0);
    fx32 moveY = ((work->flags & 2) != 0) ? -FLOAT_TO_FX32(4.0) : FLOAT_TO_FX32(4.0);

    s32 i           = 0;
    s32 activeCount = 0;
    for (; i < EFFECT_TRUCK_SPARKLES_PARTICLE_COUNT; i++)
    {
        if ((work->flagsBitfield[i >> 5] & (1 << (i & 0x1F))) != 0)
        {
            activeCount++;
            work->positionList[i].x += moveX;
            work->positionList[i].y += moveY;
        }
    }

    if (activeCount == 0)
        DestroyStageTask(&work->objWork);
}

void EffectTruckSparkles__Draw(void)
{
    s32 i;

    EffectTruckSparkles *work = TaskGetWorkCurrent(EffectTruckSparkles);

    u32 displayFlag = DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_SCALE;
    for (i = 0; i < EFFECT_TRUCK_SPARKLES_PARTICLE_COUNT; i++)
    {
        if ((work->flagsBitfield[i >> 5] & (1 << (i & 0x1F))) != 0)
        {
            StageTask__Draw2DEx(&work->animatorList[i], &work->positionList[i], NULL, NULL, &displayFlag, NULL, NULL);
            if ((displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                work->flagsBitfield[i >> 5] &= ~(1 << (i & 0x1F));
        }
    }
}