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
#include <stage/effects/flipMushPuff.h>
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
// TEMP
// --------------------

NOT_DECOMPILED void *_02118FBC;
NOT_DECOMPILED void *_0210EA44;
NOT_DECOMPILED void *_0202B670;
NOT_DECOMPILED void *_0202C470;
NOT_DECOMPILED void *EffectButtonPrompt__states;
NOT_DECOMPILED void *_02118FB4;
NOT_DECOMPILED void *EffectButtonPrompt_animIDs;

NOT_DECOMPILED const char *aAcEffBombWater;
NOT_DECOMPILED const char *aActAcEffBombGr;
NOT_DECOMPILED const char *aAcEffBattleBac;
NOT_DECOMPILED const char *aActAcEneProtDa;
NOT_DECOMPILED const char *aActAcEffWaterB_0;
NOT_DECOMPILED const char *aNsbmd;
NOT_DECOMPILED const char *aActAcGmkTruckJ;
NOT_DECOMPILED const char *aActAcGmkTruckJ_0;
NOT_DECOMPILED const char *aBpaGmkMedal;
NOT_DECOMPILED const char *aActAcDecCoralB;
NOT_DECOMPILED const char *aActAcDecSakuBa;
NOT_DECOMPILED const char *aEffeStartdash;
NOT_DECOMPILED const char *aActAcGmkBreakO;
NOT_DECOMPILED const char *aAcEffGoalJewel;
NOT_DECOMPILED const char *aActAcGmkFlipmu;
NOT_DECOMPILED const char *aActAcGmkPipeFl;
NOT_DECOMPILED const char *aActAcGmkPipeFl;
NOT_DECOMPILED const char *aActAcEffSteamD;
NOT_DECOMPILED const char *aActAcGmkSteamE;
NOT_DECOMPILED const char *aActAcGmkSteamF;
NOT_DECOMPILED const char *aModGmkPistonEf;
NOT_DECOMPILED const char *aActAcGmkIceBlo;
NOT_DECOMPILED const char *aActAcGmkTruckB;
NOT_DECOMPILED const char *aActAcGmkSnowsl;
NOT_DECOMPILED const char *aActAcGmkSnowsl;
NOT_DECOMPILED const char *aActAcGmkPirate;
NOT_DECOMPILED const char *aActAcGmkSlingD;
NOT_DECOMPILED const char *aModSbBazooka;
NOT_DECOMPILED const char *aActAcGmkAirEfB;
NOT_DECOMPILED const char *aActAcGmkMedal;
NOT_DECOMPILED const char *aAcItmRingBac_0;
NOT_DECOMPILED const char *aAcFixKeyLittle;

NOT_DECOMPILED u8 RegularShield__matList[];
NOT_DECOMPILED u8 RegularShield__shpList[];

NOT_DECOMPILED u8 MagnetShield__matList[];
NOT_DECOMPILED u8 MagnetShield__shpList[];

NOT_DECOMPILED void *_02118FD0;

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

    Task *task                        = TaskCreate_(StageTask_Main, StageTask_Destructor, TASK_FLAG_NONE, 0, 0x1800, TASK_SCOPE_2, size);
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

NONMATCH_FUNC void LoadEffectTask3DAsset(EffectTask3D *work, const char *path, OBS_DATA_WORK *fileWork, NNSiFndArchiveHeader *archive, u32 resourceFlags,
                                         EffectTask3DState nextState, BOOL initResources)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r10, r0
	mov r5, r2
	add r0, sp, #4
	mov r9, r1
	mov r8, r3
	str r5, [r10, #0x2ac]
	ldr r7, [sp, #0x48]
	bl STD_CopyString
	ldr r1, =aNsbmd
	add r0, sp, #4
	bl STD_ConcatenateString
	add r1, sp, #4
	mov r0, r5
	mov r2, r8
	bl ObjDataLoad
	movs r4, r0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, #0
	beq _020286AC
	add r0, r10, #0x200
	ldrh r1, [r0, #0xce]
	orr r1, r1, #2
	strh r1, [r0, #0xce]
_020286AC:
	add r0, r10, #0x168
	mov r1, #0
	str r4, [r10, #0x2b0]
	bl AnimatorMDL__Init
	ldr r0, [sp, #0x50]
	cmp r0, #0
	beq _02028700
	add r0, r10, #0x200
	ldrh r1, [r0, #0xce]
	cmp r5, #0
	orr r1, r1, #1
	strh r1, [r0, #0xce]
	beq _020286F8
	cmp r5, #0
	beq _02028700
	ldrh r0, [r5, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02028700
_020286F8:
	mov r0, r4
	bl NNS_G3dResDefaultSetup
_02028700:
	add r0, r10, #0x168
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	mov r1, r4
	mov r3, r2
	add r0, r10, #0x168
	str r2, [sp]
	bl AnimatorMDL__SetResource
	ldr r0, =0x000034CC
	mov r6, #0
	str r0, [r10, #0x180]
	str r0, [r10, #0x184]
	str r0, [r10, #0x188]
	add r0, r10, #0xce
	add r4, r0, #0x200
	mov r11, r6
	add r5, sp, #4
_02028748:
	mov r0, #1
	tst r7, r0, lsl r6
	beq _020287CC
	mov r0, r5
	mov r1, r9
	bl STD_CopyString
	ldr r1, =_02118FBC
	mov r0, r5
	ldr r1, [r1, r6, lsl #2]
	bl STD_ConcatenateString
	mov r0, #0
	mov r1, r5
	mov r2, r8
	bl ObjDataLoad
	add r1, r10, r6, lsl #2
	str r0, [r1, #0x2b4]
	cmp r0, #0
	beq _020287CC
	cmp r8, #0
	beq _020287A8
	ldrh r1, [r4]
	mov r0, #4
	orr r0, r1, r0, lsl r6
	strh r0, [r4]
_020287A8:
	cmp r6, #2
	beq _020287CC
	str r11, [sp]
	add r0, r10, r6, lsl #2
	ldr r2, [r0, #0x2b4]
	mov r1, r6
	add r0, r10, #0x168
	mov r3, r11
	bl AnimatorMDL__SetAnimation
_020287CC:
	add r6, r6, #1
	cmp r6, #5
	blt _02028748
	ldr r1, [r10, #0x20]
	add r0, r10, #0x200
	orr r1, r1, #0x30
	str r1, [r10, #0x20]
	mov r2, #2
	ldr r1, =EffectTask__sVars
	strh r2, [r0, #0xcc]
	ldr r0, [r1]
	ldr r1, =EffectTask3D_Destructor
	bl SetTaskDestructorEvent
	ldr r0, [sp, #0x4c]
	ldr r1, =EffectTask3D_State_Init
	cmp r0, #0
	ldreq r0, =EffectTask_State_DestroyAfterAnimation
	str r0, [r10, #0x2c8]
	ldr r0, =EffectTask3D_State_Visible
	str r1, [r10, #0xf4]
	str r0, [r10, #0xfc]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

void EffectTask3D_State_Init(EffectTask3D *work)
{
    work->field_2CC--;
    if (work->field_2CC == 0)
    {
        if (work->files[B3D_ANIM_PAT_ANIM] != NULL)
        {
            AnimatorMDL__SetAnimation(&work->animatorMDL, B3D_ANIM_PAT_ANIM, work->files[2], 0, NNS_G3dGetTex(work->resource));
        }

        work->objWork.displayFlag &= ~(DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED);
        SetTaskState(&work->objWork, work->nextState);
    }
}

void EffectTask3D_State_Visible(EffectTask3D *work)
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
        if ((work->activeFiles & (1 << 0)) != 0 && (work->filePtr->referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
            NNS_G3dResDefaultRelease(work->resource);

        ObjDataRelease(work->filePtr);
    }
    else
    {
        if ((work->activeFiles & (1 << 0)) != 0)
            NNS_G3dResDefaultRelease(work->resource);

        if ((work->activeFiles & (1 << 1)) == 0)
            HeapFree(HEAP_USER, work->resource);
    }

    for (s32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if (work->files[i] != NULL && (work->activeFiles & (4 << i)) == 0)
            HeapFree(HEAP_USER, work->files[i]);
    }

    StageTask_Destructor(task);
}

// ==============
// COMMON STATES
// ==============

void EffectTask_State_DestroyAfterAnimation(StageTask *work)
{
    if ((work->displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        work->flag |= STAGE_TASK_FLAG_DESTROYED;
}

void EffectTask_State_DestroyAfterTime(StageTask *work)
{
    work->userTimer -= GetObjSpeed();

    if (work->userTimer <= 0)
        work->flag |= STAGE_TASK_FLAG_DESTROYED;
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
            work->flag |= STAGE_TASK_FLAG_DESTROYED;
            return;
        }

        work->userTimer--;
    }
    else if ((work->displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        if (work->userTimer == 0)
        {
            work->flag |= STAGE_TASK_FLAG_DESTROYED;
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

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_zako_bomb.bac", &EffectTask__sVars.field_8, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 0x53);
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

EffectExplosion2 *CreateEffectHarmfulExplosion(StageTask *parent, fx32 velX, fx32 velY, s16 left, s16 top, s16 right, s16 bottom, u16 targetFrame, ExplosionType type)
{
    EffectExplosion2 *work = CreateEffect(EffectExplosion2, NULL);
    if (work == NULL)
        return NULL;

    if (type >= EXPLOSION_COUNT)
        type = EXPLOSION_ENEMY;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_zako_bomb.bac", &EffectTask__sVars.field_8, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 0x53);
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
    SetTaskState(&work->objWork, EffectHarmfulExplosion_State_Active);
    work->targetFrame = targetFrame;

    StageTask__InitCollider(&work->objWork, &work->collider, 0, 0);
    ObjRect__SetGroupFlags(&work->collider, 2, 1);
    ObjRect__SetAttackStat(&work->collider, 2, 0x40);
    ObjRect__SetDefenceStat(&work->collider, 0, 0x3F);
    work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    ObjRect__SetBox2D(&work->collider.rect, left, top, right, bottom);

    return work;
}

void EffectHarmfulExplosion_State_Active(EffectExplosion2 *work)
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

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_found.bac", &EffectTask__sVars.field_18, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
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
        spriteType = mtMathRand() & 3;
    }

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_zako_bomb.bac", &EffectTask__sVars.field_8, gameArchiveCommon, 2);
    s32 anim = spriteType + 3;
    ObjActionAllocSpritePalette(&work->objWork, anim, 0x53);
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
            work->objWork.velocity.y = 0;
            work->objWork.velocity.x = 0;
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
    ObjActionAllocSpritePalette(&work->objWork, 0, 0x21);
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

            if ((mtMathRand() & 1) != 0)
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
    ObjActionAllocSpritePalette(&work->objWork, 0, 0x53);
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

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_eff_battle.bac", &EffectTask__sVars.field_30, gameArchiveCommon, 8);
    ObjActionAllocSpritePalette(&work->objWork, 4, 0x1F);
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

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_water.bac", &EffectTask__sVars.field_10, gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if (MATH_ABS(parent->velocity.y) > FLOAT_TO_FX32(6.0))
        StageTask__SetAnimation(&work->objWork, 1);
    else
        StageTask__SetAnimation(&work->objWork, 0);

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

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_water.bac", &EffectTask__sVars.field_10, gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    u16 anim;
    switch (type)
    {
        case 0:
        default:
            anim = 5;
            break;

        case 1:
            anim = 6;
            break;

        case 2:
            anim = 2;
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

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_water.bac", &EffectTask__sVars.field_10, gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 33);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, 7);

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
    ObjActionAllocSpritePalette(&work->objWork, 0, 22);
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, anim), GetObjectFileWork(2 * anim + OBJDATAWORK_123));
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, anim);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;

    work->objWork.position.x = x;
    work->objWork.position.y = y;

    work->objWork.userWork = FX32_FROM_WHOLE(duration + 8);

    work->objWork.velocity.y = 2047 - (mtMathRand() & 0xFFE);
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
        work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, -0xD0, work->objWork.userTimer);
        work->objWork.velocity.x = work->objWork.velocity.y >> 1;

        if ((playerGameStatus.stageTimer & 2) != 0)
            work->objWork.velocity.x = -work->objWork.velocity.x;
    }
}

// EffectCoralDebris
NONMATCH_FUNC EffectCoralDebris *EffectCoralDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 type)
{
    // https://decomp.me/scratch/vKybC -> 98.15%
#ifdef NON_MATCHING
    u8 debrisType;
    if (type > 2)
        debrisType = 2;
    else
        debrisType = type;

    EffectCoralDebris *work = CreateEffect(EffectCoralDebris, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_dec_coral.bac", GetObjectFileWork(OBJDATAWORK_193), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, debrisType + 20, 67);

    u16 debrisAnim = debrisType + 20;
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, debrisType + 20), GetObjectSpriteRef(2 * debrisType + OBJDATAWORK_194));
    StageTask__SetAnimation(&work->objWork, debrisAnim);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    if ((mtMathRand() & 1) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((mtMathRand() & 1) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r8, [sp, #0x28]
	mov r7, r0
	mov r6, r1
	cmp r8, #2
	movhi r8, #2
	mov r0, #0x218
	mov r1, #0
	mov r5, r2
	mov r4, r3
	and r8, r8, #0xff
	bl CreateEffectTask
	movs r9, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	ldr r2, =aActAcDecCoralB
	ldr r1, [r1]
	mov r3, r0
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	mov r0, r9
	add r1, r9, #0x168
	bl ObjObjectAction2dBACLoad
	add r10, r8, #0x14
	mov r1, r10, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	mov r2, #0x43
	bl ObjActionAllocSpritePalette
	ldr r0, [r9, #0x20c]
	mov r1, r10, lsl #0x10
	ldr r0, [r0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r8, lsl #1
	mov r8, r0
	add r0, r1, #0xc2
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r8
	mov r0, r9
	bl ObjObjectActionAllocSprite
	mov r0, r10, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r9
	bl StageTask__SetAnimation
	mov r0, r9
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	str r7, [r9, #0x44]
	str r6, [r9, #0x48]
	str r5, [r9, #0x98]
	ldr r2, =_mt_math_rand
	str r4, [r9, #0x9c]
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r9, #0x20]
	ldr r2, =_mt_math_rand
	orrne r0, r0, #1
	strne r0, [r9, #0x20]
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r9, #0x20]
	mov r2, #0
	orrne r0, r0, #2
	strne r0, [r9, #0x20]
	str r2, [sp]
	mov r0, r9
	mov r3, r2
	str r2, [sp, #4]
	mov r1, #0x10
	bl InitEffectTaskViewCheck
	ldr r1, [r9, #0x1c]
	mov r0, #0xa0
	orr r1, r1, #0x80
	str r1, [r9, #0x1c]
	str r0, [r9, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r9
	str r1, [r9, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

// EffectBridgeDebris
NONMATCH_FUNC EffectBridgeDebris *EffectBridgeDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r8, [sp, #0x28]
	mov r7, r0
	mov r6, r1
	cmp r8, #1
	movhi r8, #1
	mov r0, #0x218
	mov r1, #0
	mov r5, r2
	mov r4, r3
	and r8, r8, #0xff
	bl CreateEffectTask
	movs r9, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0xa8
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	ldr r2, =aActAcDecSakuBa
	ldr r1, [r1]
	mov r3, r0
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	mov r0, r9
	add r1, r9, #0x168
	bl ObjObjectAction2dBACLoad
	add r10, r8, #3
	mov r1, r10, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	mov r2, #0x59
	bl ObjActionAllocSpritePalette
	ldr r0, [r9, #0x20c]
	mov r1, r10, lsl #0x10
	ldr r0, [r0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r8, lsl #1
	mov r8, r0
	add r0, r1, #0xa9
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r8
	mov r0, r9
	bl ObjObjectActionAllocSprite
	mov r0, r10, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r9
	bl StageTask__SetAnimation
	mov r0, r9
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	str r7, [r9, #0x44]
	str r6, [r9, #0x48]
	str r5, [r9, #0x98]
	ldr r2, =_mt_math_rand
	str r4, [r9, #0x9c]
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r9, #0x20]
	ldr r2, =_mt_math_rand
	orrne r0, r0, #1
	strne r0, [r9, #0x20]
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r9, #0x20]
	mov r2, #0
	orrne r0, r0, #2
	strne r0, [r9, #0x20]
	str r2, [sp]
	mov r0, r9
	mov r3, r2
	str r2, [sp, #4]
	mov r1, #0x10
	bl InitEffectTaskViewCheck
	ldr r1, [r9, #0x1c]
	mov r0, #0xa0
	orr r1, r1, #0x80
	str r1, [r9, #0x1c]
	str r0, [r9, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r9
	str r1, [r9, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

// EffectIceSparkles
NONMATCH_FUNC EffectIceSparkles *EffectIceSparkles__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	ldr r5, [sp, #0x28]
	mov r9, r0
	cmp r5, #0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	movlt r5, #0
	blt _0202A5F4
	cmp r5, #2
	movgt r5, #2
_0202A5F4:
	mov r0, #0x218
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r5, #0x9a
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	ldr r2, =0x0000FFFF
	ldr r3, [r1]
	ldr r1, =_02118FB4
	str r3, [sp]
	str r2, [sp, #4]
	mov r3, r0
	ldr r2, [r1, r5, lsl #2]
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	ldr r2, =_0210EA44
	ldrb r2, [r2, r5]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r9, [r4, #0x44]
	str r8, [r4, #0x48]
	str r7, [r4, #0x98]
	str r6, [r4, #0x9c]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, r4
	mov r1, #0x10
	mov r3, r2
	bl InitEffectTaskViewCheck
	ldr r1, =EffectTask_State_DestroyAfterAnimation
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

// EffectStartDash
NONMATCH_FUNC EffectStartDash *EffectStartDash__Create(StageTask *parent)
{
#ifdef NON_MATCHING
    EffectStartDash *work = CreateEffect(EffectStartDash, NULL);
    if (work == NULL)
        return NULL;

    LoadEffectTask3DAsset(EffectStartDash, "/effe_startdash", NULL, gameArchiveCommon, (1 << B3D_ANIM_VIS_ANIM) | (1 << B3D_ANIM_MAT_ANIM) | (1 << B3D_ANIM_JOINT_ANIM), NULL,
                          FALSE);
    work->parentObj = parent;

    work->position = parent->position;

    work->position.x += FLOAT_TO_FX32(50.0);
    work->position.y += FLOAT_TO_FX32(20.0);

    work->velocity.x = FLOAT_TO_FX32(6.0);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #0x2d0
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r1, #0x13
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	ldr r1, =gameArchiveCommon
	str r2, [sp, #8]
	ldr r3, [r1]
	ldr r1, =aEffeStartdash
	bl LoadEffectTask3DAsset
	str r5, [r4, #0x11c]
	add r0, r5, #0x44
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x44]
	mov r1, #0x6000
	add r0, r0, #0x32000
	str r0, [r4, #0x44]
	ldr r2, [r4, #0x48]
	mov r0, r4
	add r2, r2, #0x14000
	str r2, [r4, #0x48]
	str r1, [r4, #0x98]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
// clang-format on
#endif
}

// EffectBreakableObjDebris
NONMATCH_FUNC EffectBreakableObjDebris *EffectBreakableObjDebris__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r8, [sp, #0x28]
	mov r7, r0
	mov r6, r1
	cmp r8, #1
	movhi r8, #1
	mov r0, #0x218
	mov r1, #0
	mov r5, r2
	mov r4, r3
	and r8, r8, #0xff
	bl CreateEffectTask
	movs r9, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0x36
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkBreakO
	mov r0, r9
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	add r1, r9, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r9
	mov r1, r8
	mov r2, #6
	bl ObjActionAllocSpritePalette
	add r10, r8, #1
	ldr r0, [r9, #0x20c]
	mov r1, r10, lsl #0x10
	ldr r0, [r0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r8, lsl #1
	mov r8, r0
	add r0, r1, #0x39
	bl GetObjectFileWork
	mov r1, r8
	mov r2, r0
	mov r0, r9
	bl ObjObjectActionAllocSprite
	mov r0, r10, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r9
	bl StageTask__SetAnimation
	mov r0, r9
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r9
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r7, [r9, #0x44]
	str r6, [r9, #0x48]
	str r5, [r9, #0x98]
	str r4, [r9, #0x9c]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, r9
	mov r1, #0x10
	mov r3, r2
	bl InitEffectTaskViewCheck
	ldr r1, [r9, #0x1c]
	mov r0, #0xa0
	orr r1, r1, #0x80
	str r1, [r9, #0x1c]
	str r0, [r9, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r9
	str r1, [r9, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

// EffectGoalJewel
NONMATCH_FUNC EffectGoalJewel *EffectGoalJewel__Create(u32 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	cmp r9, #9
	mov r8, r1
	movhi r9, #9
	mov r7, r2
	mov r2, r9, lsl #0x10
	mov r0, #0x218
	mov r1, #0
	mov r6, r3
	mov r9, r2, lsr #0x10
	bl CreateEffectTask
	movs r5, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0x80
	bl GetObjectFileWork
	ldr r1, =gameArchiveCommon
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aAcEffGoalJewel
	str r1, [sp]
	mov r4, #0
	mov r0, r5
	add r1, r5, #0x168
	str r4, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r4, r9, lsl #1
	add r0, r4, #0x81
	bl GetObjectFileWork
	mov r2, r0
	ldr r1, =_02118FD0
	mov r3, r4
	ldrh r1, [r1, r3]
	mov r0, r5
	bl ObjObjectActionAllocSprite
	mov r0, r5
	mov r1, r9
	mov r2, #0x17
	bl ObjActionAllocSpritePalette
	mov r0, r5
	mov r1, r9
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x20]
	add r0, r4, #0x81
	orr r1, r1, #4
	str r1, [r5, #0x20]
	ldr r4, [r5, #0x128]
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _0202A9AC
	ldr r0, [r4, #0x3c]
	mov r1, #0
	orr r3, r0, #0x20
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, r5
	mov r1, r9
	bl StageTask__SetAnimation
_0202A9AC:
	ldr r1, [r4, #0x3c]
	mov r0, r5
	orr r2, r1, #8
	mov r1, #0xc
	str r2, [r4, #0x3c]
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r5, #0x44]
	str r7, [r5, #0x48]
	mov r2, #0
	ldr r0, [sp, #0x28]
	str r6, [r5, #0x98]
	str r0, [r5, #0x9c]
	str r2, [sp]
	mov r0, r5
	mov r3, r2
	mov r1, #0x18
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

// EffectFlipMush
NONMATCH_FUNC EffectFlipMushPuff *EffectFlipMushPuff__Create(fx32 x, fx32 y, fx32 velX, fx32 velY)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r0, #0x218
	mov r1, #0
	mov r6, r2
	mov r5, r3
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0xa6
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkFlipmu
	mov r0, r4
	str r1, [sp]
	mov r9, #0
	add r1, r4, #0x168
	str r9, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #3
	mov r2, #0xf
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x20c]
	mov r1, #3
	ldr r0, [r0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r9, r0
	mov r0, #0xab
	bl GetObjectFileWork
	mov r1, r9
	mov r2, r0
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x98]
	rsb r0, r6, #0
	mov r0, r0, asr #5
	str r5, [r4, #0x9c]
	str r0, [r4, #0xa4]
	rsb r0, r5, #0
	mov r0, r0, asr #5
	str r0, [r4, #0xa8]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, r4
	mov r1, #0x40
	mov r3, r2
	bl InitEffectTaskViewCheck
	ldr r1, =EffectTask_State_DestroyAfterAnimation
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

// EffectPipeFlowPetal
NONMATCH_FUNC EffectPipeFlowPetal *EffectPipeFlowPetal__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r0, #0x218
	mov r1, #0
	mov r6, r2
	mov r5, r3
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0x9f
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkPipeFl
	str r1, [sp]
	mov ip, #8
	mov r0, r4
	add r1, r4, #0x168
	str ip, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #3
	mov r2, #0xa
	bl ObjActionAllocSpritePalette
	ldrh r1, [sp, #0x20]
	mov r0, r4
	add r1, r1, #3
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x98]
	mov r2, #0
	str r5, [r4, #0x9c]
	str r2, [sp]
	mov r0, r4
	mov r1, #0x100
	mov r3, r2
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	cmp r6, #0
	movge r0, #1
	bge _0202AC38
	ldr r1, [r4, #0x20]
	mvn r0, #0
	orr r1, r1, #1
	str r1, [r4, #0x20]
_0202AC38:
	str r0, [r4, #0x28]
	ldr r1, [r4, #0x1c]
	mov r0, #0x100
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0xd8]
	mov r0, #0x3000
	str r0, [r4, #0xdc]
	ldr r1, =EffectPipeFlowPetal__State_202AC78
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

void EffectPipeFlowPetal__State_202AC78(EffectPipeFlowPetal *work)
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

// EffectPipeFlowSeed
NONMATCH_FUNC EffectPipeFlowSeed *EffectPipeFlowSeed__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r0, #0x218
	mov r1, #0
	mov r6, r2
	mov r5, r3
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0x9f
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkPipeFl
	str r1, [sp]
	mov ip, #1
	mov r0, r4
	add r1, r4, #0x168
	str ip, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #5
	mov r2, #0xa
	bl ObjActionAllocSpritePalette
	ldrh r1, [sp, #0x20]
	mov r0, r4
	add r1, r1, #5
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x98]
	mov r2, #0
	str r5, [r4, #0x9c]
	str r2, [sp]
	mov r0, r4
	mov r1, #0x100
	mov r3, r2
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	cmp r6, #0
	movge r0, #1
	bge _0202ADBC
	ldr r1, [r4, #0x20]
	mvn r0, #0
	orr r1, r1, #1
	str r1, [r4, #0x20]
_0202ADBC:
	str r0, [r4, #0x28]
	ldr r1, [r4, #0x1c]
	mov r0, #0x100
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0xd8]
	mov r0, #0x2800
	str r0, [r4, #0xdc]
	ldr r1, =EffectPipeFlowSeed__State_202ADFC
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

void EffectPipeFlowSeed__State_202ADFC(EffectPipeFlowSeed *work)
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
NONMATCH_FUNC EffectSteam *EffectSteamDust__Create(u32 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	cmp r8, #1
	movhi r8, #1
	mov r0, #0x218
	mov r1, #0
	mov r6, r2
	mov r5, r3
	and r8, r8, #0xff
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0xa0
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcEffSteamD
	str r1, [sp]
	mov r9, #0
	mov r0, r4
	add r1, r4, #0x168
	str r9, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, r9
	mov r2, #0x20
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x20c]
	mov r1, r8
	ldr r0, [r0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r9, r0
	mov r0, r8, lsl #1
	add r0, r0, #0xa1
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r9
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r1, r8
	mov r0, r4
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	mov r2, #0
	ldr r0, [sp, #0x28]
	str r5, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, r4
	mov r1, #0x10
	mov r3, r2
	bl InitEffectTaskViewCheck
	ldr r1, [r4, #0x1c]
	mov r0, #0xa0
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

NONMATCH_FUNC EffectSteam *EffectSteamEffect__Create(u32 type, fx32 x, fx32 y, fx32 velX, fx32 velY, s32 timer)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r9, r0
	mov r8, r1
	cmp r9, #1
	movhi r9, #1
	mov r0, #0x218
	mov r1, #0
	mov r7, r2
	mov r6, r3
	and r9, r9, #0xff
	bl CreateEffectTask
	movs r5, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0xb3
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkSteamE
	str r1, [sp]
	mov r4, #0
	mov r0, r5
	add r1, r5, #0x168
	str r4, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r5
	mov r1, r4
	mov r2, #0x22
	bl ObjActionAllocSpritePalette
	ldr r0, [r5, #0x20c]
	mov r4, r9, lsl #1
	ldr r0, [r0]
	mov r1, r9
	bl Sprite__GetSpriteSize2FromAnim
	mov r10, r0
	add r0, r4, #0xb4
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r10
	mov r0, r5
	bl ObjObjectActionAllocSprite
	mov r0, r5
	mov r1, r9
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x20]
	add r0, r4, #0xb4
	orr r1, r1, #4
	str r1, [r5, #0x20]
	ldr r4, [r5, #0x128]
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _0202B0CC
	ldr r0, [r4, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, r5
	mov r1, r9
	bl StageTask__SetAnimation
_0202B0CC:
	ldr r0, [r4, #0x3c]
	cmp r9, #0
	orr r0, r0, #0x18
	str r0, [r4, #0x3c]
	mov r0, r5
	beq _0202B0FC
	mov r1, #0xe
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	b _0202B110
_0202B0FC:
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimatorPriority
_0202B110:
	str r8, [r5, #0x44]
	str r7, [r5, #0x48]
	ldr r1, [sp, #0x28]
	str r6, [r5, #0x98]
	ldr r0, [sp, #0x2c]
	str r1, [r5, #0x9c]
	ldr r1, =EffectTask_State_DestroyAfterTime
	str r0, [r5, #0x2c]
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

// EffectSteamFan
NONMATCH_FUNC EffectSteamFan *EffectSteamFan__Create(StageTask *parent, s32 userTimer, u16 angle, s32 userWork)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	ldr r4, =playerGameStatus
	mov r9, r0
	ldr r0, [r4]
	mov r8, r1
	tst r0, #1
	mov r7, r2
	mov r6, r3
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0x218
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0xa5
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkSteamF
	str r1, [sp]
	mov r5, #0
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, r5
	mov r2, #0x22
	bl ObjActionAllocSpritePalette
	mov r0, #0xa8
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x18
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	mov r0, #0xa8
	ldr r5, [r4, #0x128]
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _0202B240
	ldr r0, [r5, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r5
	mov r2, r1
	str r3, [r5, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
_0202B240:
	ldr r1, [r5, #0x3c]
	mov r0, r4
	orr r1, r1, #0x18
	str r1, [r5, #0x3c]
	ldr r1, [r9, #0x20]
	ldr r2, [r4, #0x20]
	and r1, r1, #1
	orr r2, r2, r1
	mov r1, #0xe
	str r2, [r4, #0x20]
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r5, r0, lsl #1
	add r1, r5, #1
	ldr r0, [r4, #0x1c]
	ldr r3, =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh r2, [r3, r1]
	mov r1, r5, lsl #1
	ldrsh r1, [r3, r1]
	smull r5, r3, r2, r8
	adds r5, r5, #0x800
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	str r9, [r4, #0x11c]
	str r8, [r4, #0x2c]
	str r6, [r4, #0x28]
	strh r7, [r4, #0x34]
	smull r2, r0, r1, r8
	adc r3, r3, #0
	adds r1, r2, #0x800
	mov r2, r5, lsr #0xc
	ldr r5, [r9, #0x44]
	orr r2, r2, r3, lsl #20
	add r2, r5, r2
	str r2, [r4, #0x44]
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r9, #0x48]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	ldr r1, =EffectSteamFan__State_202B324
	str r0, [r4, #0x48]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

void EffectSteamFan__State_202B324(EffectSteamFan *work)
{
    fx32 power = work->objWork.userTimer + (FX32_FROM_WHOLE(mtMathRand() & 3));

    work->objWork.dir.z += (u16)work->objWork.userWork;

    work->objWork.position.x = work->objWork.parentObj->position.x + MultiplyFX(CosFX(work->objWork.dir.z), power);
    work->objWork.position.y = work->objWork.parentObj->position.y + MultiplyFX(SinFX(work->objWork.dir.z), power);

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->objWork);
}

// EffectPiston
NONMATCH_FUNC EffectPiston *EffectPiston__Create(VecFx32 *position, VecU16 *dir)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	mov r5, r1
	mov r0, #0x2d0
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, #0xbf
	bl GetObjectFileWork
	mov r2, #3
	str r2, [sp]
	ldr r1, =EffectTask_State_TrackParent
	mov r2, r0
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r0, =gameArchiveStage
	ldr r1, =aModGmkPistonEf
	ldr r3, [r0]
	mov r0, r4
	bl LoadEffectTask3DAsset
	ldr r0, =0x00003A13
	add r3, r4, #0x44
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
	str r0, [r4, #0x188]
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrh r2, [r5]
	ldrh r1, [r5, #2]
	mov r0, r4
	strh r2, [r4, #0x30]
	strh r1, [r4, #0x32]
	ldrh r1, [r5, #4]
	strh r1, [r4, #0x34]
	ldr r1, [r4, #0x20]
	bic r1, r1, #0x100
	orr r1, r1, #0x200
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
// clang-format on
#endif
}

// EffectIceBlock
NONMATCH_FUNC EffectIceBlockDebris *EffectIceBlockDebris__Create(u32 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	mov r8, r1
	cmp r9, #3
	movhi r9, #3
	mov r0, #0x218
	mov r1, #0
	mov r7, r2
	mov r6, r3
	and r9, r9, #0xff
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0xaf
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkIceBlo
	str r1, [sp]
	mov r5, #0
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, r5
	mov r2, #0x23
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x20c]
	add r5, r9, #1
	mov r1, r5, lsl #0x10
	ldr r0, [r0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r9, lsl #1
	mov r9, r0
	add r0, r1, #0xb2
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r9
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r5, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r4
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	mov r2, #0
	ldr r0, [sp, #0x28]
	str r6, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, r4
	mov r1, #0x10
	mov r3, r2
	bl InitEffectTaskViewCheck
	ldr r1, [r4, #0x1c]
	mov r0, #0xa0
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

// EffectTruckSparkles
NONMATCH_FUNC EffectTruckSparkles *EffectTruckSparkles__Create(StageTask *parent, u16 duration, s32 userWork, fx32 offsetX, fx32 offsetY, u16 flags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	str r0, [sp, #4]
	str r1, [sp, #8]
	ldr r0, =0x00000E64
	mov r1, #0
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	bl CreateEffectTask
	movs r7, r0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectTruckSparkles__Destructor
	ldr r0, [r0]
	bl SetTaskDestructorEvent
	ldr r4, =gameArchiveStage
	add r9, r7, #0x168
	mov r6, #0
	mov r10, #0xb8
	mov r11, #0xb4
_0202B670:
	mov r0, r11
	mov r8, r9
	bl GetObjectFileWork
	ldr r1, [r4]
	mov r3, r0
	str r1, [sp]
	ldr r1, =aActAcGmkTruckB
	mov r0, r9
	mov r2, #0
	bl ObjAction2dBACLoad
	ldr r1, [r9, #0x3c]
	add r0, r6, #1
	orr r1, r1, #0x10
	str r1, [r9, #0x3c]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, [r9, #0x14]
	bl Sprite__GetSpriteSize2FromAnim
	mov r5, r0
	mov r0, r10
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r5
	mov r0, r9
	bl ObjActionAllocSpriteDS
	add r1, r6, #1
	mov r1, r1, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	bl AnimatorSpriteDS__SetAnimation
	mov r0, #0xb8
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bgt _0202B710
	mov r1, #0
	mov r0, r9
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
_0202B710:
	ldr r1, [r9, #0x3c]
	mov r0, r9
	orr r1, r1, #8
	str r1, [r9, #0x3c]
	mov r1, #0xc
	bl StageTask__SetOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r6, r6, #1
	add r9, r9, #0xa4
	add r10, r10, #2
	cmp r6, #3
	blt _0202B670
	ldr r0, [r8, #0x14]
	mov r1, #1
	mov r2, #0x3a
	bl ObjDrawAllocSpritePalette
	mov r3, r7
	mov r4, #0
_0202B760:
	add r1, r3, #0x100
	strh r0, [r1, #0xb8]
	ldrh r2, [r1, #0xb8]
	add r4, r4, #1
	cmp r4, #3
	strh r2, [r1, #0xfa]
	strh r2, [r1, #0xf8]
	add r3, r3, #0xa4
	blt _0202B760
	ldr r0, [sp, #8]
	add r1, r7, #0xe00
	strh r0, [r1, #0x60]
	ldr r2, [sp, #0x3c]
	ldr r0, [sp, #4]
	strh r2, [r1, #0x62]
	ldr r1, [r0, #0x44]
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #0x38]
	add r0, r1, r0
	str r0, [r7, #0xe58]
	ldr r0, [sp, #4]
	ldr r1, =EffectTruckSparkles__Draw
	ldr r0, [r0, #0x48]
	add r0, r0, r2
	str r0, [r7, #0xe5c]
	ldr r0, [sp, #0xc]
	str r0, [r7, #0x28]
	ldr r2, [r7, #0x1c]
	ldr r0, =EffectTruckSparkles__State_202B86C
	orr r2, r2, #0x2000
	str r2, [r7, #0x1c]
	str r1, [r7, #0xfc]
	str r0, [r7, #0xf4]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectTruckSparkles__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r0
	bl GetTaskWork_
	mov r6, #0
	add r7, r0, #0x168
	mov r8, #0xb8
	mov r5, r6
	mov r4, #0xb3
_0202B828:
	mov r0, r8
	bl GetObjectFileWork
	bl ObjActionReleaseSpriteDS
	str r5, [r7, #0x78]
	mov r0, r4
	str r5, [r7, #0x7c]
	bl GetObjectFileWork
	mov r1, r7
	bl ObjAction2dBACRelease
	add r6, r6, #1
	cmp r6, #3
	add r7, r7, #0xa4
	add r8, r8, #2
	blt _0202B828
	mov r0, r9
	bl StageTask_Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
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

        work->positionList[id].x = work->position.x + FX32_FROM_WHOLE((mtMathRand() & 0x1F) - 15);
        work->positionList[id].y = work->position.y + FX32_FROM_WHOLE((mtMathRand() & 0x1F) - 15);

        MI_CpuCopy8(&work->aniSparkles[sparkleType[mtMathRand() & 3]], &work->animatorList[id], sizeof(work->animatorList[0]));

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