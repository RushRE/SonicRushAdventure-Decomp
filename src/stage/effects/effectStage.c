// Effect System Headers
#include <stage/effectTask.h>
#include <stage/gameObject.h>
#include <stage/core/ringManager.h>

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
#include <game/stage/bossHelpers.h>
#include <game/system/allocator.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/math/mtMath.h>
#include <game/math/akMath.h>
#include <game/object/objAction.h>
#include <game/object/obj.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/paletteAnimation.h>
#include <game/audio/spatialAudio.h>
#include <stage/objects/jumpbox.h>

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
NOT_DECOMPILED void *_02119324;
NOT_DECOMPILED void *_0211930C;

NOT_DECOMPILED const char *aActAcGmkSnowsl;
NOT_DECOMPILED const char *aActAcGmkPirate;
NOT_DECOMPILED const char *aActAcGmkSlingD;
NOT_DECOMPILED const char *aModSbBazooka;
NOT_DECOMPILED const char *aActAcGmkAirEfB;
NOT_DECOMPILED const char *aActAcGmkMedal;
NOT_DECOMPILED const char *aAcItmRingBac_0;
NOT_DECOMPILED const char *aAcFixKeyLittle;
NOT_DECOMPILED const char *aActAcGmkTruckJ;
NOT_DECOMPILED const char *aActAcGmkTruckJ_0;
NOT_DECOMPILED const char *aBpaGmkMedal;

NOT_DECOMPILED u8 RegularShield__matList[];
NOT_DECOMPILED u8 RegularShield__shpList[];

NOT_DECOMPILED u8 MagnetShield__matList[];
NOT_DECOMPILED u8 MagnetShield__shpList[];

NOT_DECOMPILED void *_0210EA5C;

// --------------------
// VARIABLES
// --------------------

extern RingManager *ringManagerWork;

// --------------------
// FUNCTIONS
// --------------------

// EffectAvalanche
EffectSnowSlide *EffectAvalanche__Create(fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    EffectSnowSlide *work = CreateEffect(EffectSnowSlide, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_snowslide.bac", GetObjectDataWork(OBJDATAWORK_193), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->objWork, 160, GetObjectSpriteRef(OBJDATAWORK_194));
    ObjActionAllocSpritePalette(&work->objWork, 0, 35);
    StageTask__SetAnimation(&work->objWork, 0);

    if ((GetObjectSpriteRef(OBJDATAWORK_194)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) <= 1)
    {
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
        AnimatorSpriteDS__ProcessAnimationFast(&work->objWork.obj_2d->ani);
    }
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 32, 0, 0, 0, 0);

    work->objWork.userTimer = 32;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

EffectSnowSlide *EffectAvalancheDebris__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    type = MATH_MIN(type, 2);

    EffectSnowSlide *work = CreateEffect(EffectSnowSlide, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_snowslide.bac", GetObjectFileWork(OBJDATAWORK_193), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, 0, 35);

    u16 anim = type + 1;
    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, type + 1), GetObjectSpriteRef(2 * type + OBJDATAWORK_196));
    StageTask__SetAnimation(&work->objWork, anim);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if ((mtMathRand() & 1) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((mtMathRand() & 1) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 32;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

// EffectTruckJewel
EffectTruckJewel *EffectTruckJewel__Create(StageTask *parent, fx32 velX, fx32 velY, fx32 velZ, u8 type, u8 flag)
{
    EffectTruckJewel *work = CreateEffect(EffectTruckJewel, parent);
    if (work == NULL)
        return NULL;

    if (type >= 5)
        type = 4;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani2D, "/act/ac_gmk_truck_jewel.bac", GetObjectDataWork(OBJDATAWORK_181), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 58);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_24);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

    ObjObjectAction3dBACLoad(&work->objWork, &work->ani3D, "/act/ac_gmk_truck_jewel3d.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, GetObjectDataWork(OBJDATAWORK_182),
                             gameArchiveStage);
    work->ani3D.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->ani3D.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    StageTask__SetAnimation(&work->objWork, type);

    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.velocity.z = velZ;

    if (flag)
    {
        work->objWork.userTimer = 0x2000 + (FX32_FROM_WHOLE(mtMathRand() & 3));
    }

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_SCALE;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.displayFlag |= parent->displayFlag & DISPLAY_FLAG_FLIP_X;

    work->objWork.flag |= STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT;
    SetTaskOutFunc(&work->objWork, EffectTruckJewel__Draw);
    SetTaskState(&work->objWork, EffectTruckJewel__State_202C06C);

    return work;
}

void EffectTruckJewel__State_202C06C(EffectTruckJewel *work)
{
    if (work->objWork.parentObj != NULL)
    {
        work->objWork.position.x = work->objWork.parentObj->position.x + work->objWork.parentObj->offset.x;
        work->objWork.position.y = work->objWork.parentObj->position.y + work->objWork.parentObj->offset.y;
        work->objWork.position.z = work->objWork.parentObj->position.z;

        fx32 x, y, z;
        AkMath__Func_2002C98(work->objWork.velocity.z, work->objWork.velocity.x, &z, &x, -work->objWork.parentObj->dir.y);
        AkMath__Func_2002C98(x, work->objWork.velocity.y, &x, &y, work->objWork.parentObj->dir.z);
        work->objWork.position.x += x;
        work->objWork.position.y += y;
        work->objWork.position.z += z;

        work->objWork.dir = work->objWork.parentObj->dir;

        // check if the jewel should fly out of the truck
        if (work->objWork.userTimer != 0)
        {
            if (work->objWork.parentObj->velocity.x == FLOAT_TO_FX32(0.0) && work->objWork.parentObj->velocity.y >= work->objWork.userTimer)
            {
                InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);
                work->objWork.velocity.x = FLOAT_TO_FX32(0.0);
                work->objWork.velocity.y = work->objWork.parentObj->velocity.y;
                work->objWork.velocity.z = FLOAT_TO_FX32(0.0);
                work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                SetTaskState(&work->objWork, NULL);
                work->objWork.parentObj = NULL;
            }
        }
    }
    else
    {
        // no parent, get ejected!!

        work->objWork.velocity.x = FLOAT_TO_FX32(6.0) + (16 * (mtMathRand() & 0x3F0));
        work->objWork.velocity.y = -FLOAT_TO_FX32(4.0) - (16 * (mtMathRand() & 0x3F0));
        work->objWork.velocity.z = FLOAT_TO_FX32(0.0);

        work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

        InitEffectTaskViewCheck(&work->objWork, 64, 0, 0, 0, 0);
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        SetTaskState(&work->objWork, NULL);
    }
}

void EffectTruckJewel__Draw(void)
{
    EffectTruckJewel *work = TaskGetWorkCurrent(EffectTruckJewel);

    StageTask *truck = work->objWork.parentObj;
    if (truck)
    {
        if (truck->position.z == FLOAT_DEG_TO_IDX(0.0) && truck->dir.y == FLOAT_DEG_TO_IDX(0.0))
        {
            StageTask__Draw2DEx(&work->objWork.obj_2d->ani, &work->objWork.position, &work->objWork.dir, &work->objWork.scale, &work->objWork.displayFlag, NULL, NULL);
        }
        else
        {
            StageTask__Draw3DEx(&work->objWork.obj_2dIn3d->ani.work, &work->objWork.position, &work->objWork.dir, &work->objWork.scale, &work->objWork.displayFlag, NULL, NULL,
                                NULL);
        }
    }
    else
    {
        StageTask__Draw2DEx(&work->objWork.obj_2d->ani, &work->objWork.position, &work->objWork.dir, &work->objWork.scale, &work->objWork.displayFlag, NULL, NULL);
    }
}

// EffectPirateShip
EffectPirateShipCannonBlast *PirateShipCannonBlast__Create(StageTask *parent, fx32 velX, fx32 velY)
{
    EffectPirateShipCannonBlast *work = CreateEffect(EffectPirateShipCannonBlast, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_pirate_ship.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage, 8);
    ObjActionAllocSpritePalette(&work->objWork, 0, 83);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_3);
    StageTask__SetAnimation(&work->objWork, 1);

    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SetTaskState(&work->objWork, EffectTask_State_TrackParent);

    return work;
}

// EffectUnknown202C414
EffectUnknown202C414 *EffectUnknown202C414__Create(StageTask *parent)
{
    EffectUnknown202C414 *work = CreateEffect(EffectUnknown202C414, parent);
    if (work == NULL)
        return NULL;

    SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectUnknown202C414__Destructor);

    work->drawList = HeapAllocHead(HEAP_SYSTEM, 0x300);
    G3_BeginMakeDL(&work->dlInfo, work->drawList, 0x300);

    u8 polygonAlpha[] = { GX_COLOR_FROM_888(0x28), GX_COLOR_FROM_888(0x38), GX_COLOR_FROM_888(0x48), GX_COLOR_FROM_888(0x58), GX_COLOR_FROM_888(0x68),
                          GX_COLOR_FROM_888(0x58), GX_COLOR_FROM_888(0x48), GX_COLOR_FROM_888(0x38), GX_COLOR_FROM_888(0x28), GX_COLOR_FROM_888(0x18) };

    G3C_MtxMode(&work->dlInfo, GX_MTXMODE_POSITION);
    G3C_Color(&work->dlInfo, GX_RGB_888(0xFF, 0xFF, 0xFF));

    s32 i;
    fx32 z;

    for (i = 0, z = FLOAT_TO_FX32(0.0); i < 10; i++)
    {
        G3C_PolygonAttr(&work->dlInfo, 0, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, polygonAlpha[i], GX_POLYGON_ATTR_MISC_NONE);
        G3C_Begin(&work->dlInfo, GX_BEGIN_QUAD_STRIP);

        G3C_Vtx(&work->dlInfo, 0, 32, z >> 6);
        G3C_Vtx(&work->dlInfo, 0, -32, z >> 6);

        z += FLOAT_TO_FX32(3.2);
        G3C_Vtx(&work->dlInfo, 0, 32, z >> 6);
        G3C_Vtx(&work->dlInfo, 0, -32, z >> 6);

        G3C_End(&work->dlInfo);
    }
    G3_EndMakeDL(&work->dlInfo);
    DC_FlushRange(work->drawList, 0x300);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SetTaskState(&work->objWork, EffectUnknown202C414__State_202C5F8);
    SetTaskOutFunc(&work->objWork, EffectUnknown202C414__Draw);

    work->objWork.position.z = FLOAT_TO_FX32(0.0);
    return work;
}

void EffectUnknown202C414__Destructor(Task *task)
{
    EffectUnknown202C414 *work = TaskGetWork(task, EffectUnknown202C414);

    HeapFree(HEAP_SYSTEM, work->drawList);
    StageTask_Destructor(task);
}

NONMATCH_FUNC void EffectUnknown202C414__State_202C5F8(EffectUnknown202C414 *work)
{
    // https://decomp.me/scratch/fpt9F -> 99.03%
    // minor register issues
#ifdef NON_MATCHING
    s32 id;
    BOOL isActive = FALSE;

    if (work->objWork.parentObj != NULL && (work->objWork.parentObj->flag & STAGE_TASK_FLAG_DESTROYED) == 0 && work->objWork.parentObj->userFlag)
        work->objWork.userFlag = TRUE;

    work->objWork.position.x = work->objWork.parentObj->position.x;
    work->objWork.position.y = work->objWork.parentObj->position.y;

    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0 && !work->objWork.userFlag)
    {
        id = 0;
        for (; id < EFFECTUNKNOWN202C414_LIST_SIZE; id++)
        {
            EffectUnknown202C414Entry *entry = &work->list[id];

            if (entry->active)
                continue;

            entry->active = TRUE;

            entry->position.x = ((mtMathRand() & 0x1F) * 0x20) + 0x200;
            entry->position.y = FLOAT_TO_FX32(0.0);
            entry->position.z = FLOAT_TO_FX32(0.0);

            entry->angle1 = (mtMathRand() & 0x3FF) + 0x1000;
            entry->angle2 = mtMathRand();
            entry->scale  = FLOAT_TO_FX32(0.0);
            break;
        }

        if (id < EFFECTUNKNOWN202C414_LIST_SIZE)
        {
            work->objWork.userTimer = mtMathRand() & 7;
        }
    }

    for (s32 i = 0; i < EFFECTUNKNOWN202C414_LIST_SIZE; i++)
    {
        EffectUnknown202C414Entry *entry = &work->list[i];

        if (!entry->active)
            continue;

        isActive = TRUE;

        if (entry->scale < FLOAT_TO_FX32(1.0))
        {
            entry->scale += FLOAT_TO_FX32(0.25);

            if (entry->scale > FLOAT_TO_FX32(1.0))
                entry->scale = FLOAT_TO_FX32(1.0);
        }
        else
        {
            entry->position.z += FLOAT_TO_FX32(0.125);

            if (entry->position.z >= FLOAT_TO_FX32(1.0))
                entry->active = FALSE;
        }
    }

    if (work->objWork.userFlag)
    {
        if (!isActive)
            DestroyStageTask(&work->objWork);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r2, [r0, #0x11c]
	mov r4, #0
	cmp r2, #0
	beq _0202C628
	ldr r1, [r2, #0x18]
	tst r1, #4
	bne _0202C628
	ldr r1, [r2, #0x24]
	cmp r1, #0
	movne r1, #1
	strne r1, [r0, #0x24]
_0202C628:
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x44]
	str r1, [r0, #0x44]
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x48]
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x2c]
	sub r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #0
	bgt _0202C740
	ldr r1, [r0, #0x24]
	cmp r1, #0
	bne _0202C740
	add lr, r0, #0x180
	mov ip, #0
_0202C668:
	ldrh r1, [lr]
	cmp r1, #0
	bne _0202C6FC
	mov r3, #1
	ldr r8, =_mt_math_rand
	strh r3, [lr]
	ldr r5, [r8, #0]
	ldr r6, =0x00196225
	ldr r7, =0x3C6EF35F
	mov r1, #0
	mla r2, r5, r6, r7
	mov r5, r2, lsr #0x10
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	mov r5, r5, lsl #0x1b
	mov r5, r5, lsr #0x16
	str r2, [r8]
	add r2, r5, #0x200
	str r2, [lr, #8]
	str r1, [lr, #0xc]
	str r1, [lr, #0x10]
	ldr r2, [r8, #0]
	rsb r3, r3, #0x400
	mla r5, r2, r6, r7
	mov r2, r5, lsr #0x10
	mov r2, r2, lsl #0x10
	and r2, r3, r2, lsr #16
	str r5, [r8]
	add r2, r2, #0x1000
	strh r2, [lr, #4]
	ldr r2, [r8, #0]
	mla r3, r2, r6, r7
	str r3, [r8]
	mov r2, r3, lsr #0x10
	strh r2, [lr, #6]
	str r1, [lr, #0x14]
	b _0202C70C
_0202C6FC:
	add ip, ip, #1
	cmp ip, #0x20
	add lr, lr, #0x18
	blt _0202C668
_0202C70C:
	cmp ip, #0x20
	bge _0202C740
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r5, [r3, #0]
	ldr r2, =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r3]
	and r1, r1, #7
	str r1, [r0, #0x2c]
_0202C740:
	mov r7, #0
	add r6, r0, #0x180
	mov r5, #1
	mov r1, r7
	mov r3, #0x1000
_0202C754:
	ldrh r2, [r6, #0]
	cmp r2, #0
	beq _0202C798
	ldr r2, [r6, #0x14]
	mov r4, r5
	cmp r2, #0x1000
	bge _0202C784
	add r2, r2, #0x400
	str r2, [r6, #0x14]
	cmp r2, #0x1000
	strgt r3, [r6, #0x14]
	b _0202C798
_0202C784:
	ldr r2, [r6, #0x10]
	add r2, r2, #0x200
	str r2, [r6, #0x10]
	cmp r2, #0x1000
	strgeh r1, [r6]
_0202C798:
	add r7, r7, #1
	cmp r7, #0x20
	add r6, r6, #0x18
	blt _0202C754
	ldr r1, [r0, #0x24]
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r4, #0
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectUnknown202C414__Draw(void)
{
    // https://decomp.me/scratch/2LqfC -> 90.19%
    // small mismatch near NNS_G3dGeScale
#ifdef NON_MATCHING
    EffectUnknown202C414 *work = TaskGetWorkCurrent(EffectUnknown202C414);

    VecFx32 inputPos;
    VecFx32 baseScale;
    baseScale.x = FLOAT_TO_FX32(211.1875);
    baseScale.y = FLOAT_TO_FX32(211.1875);
    baseScale.z = FLOAT_TO_FX32(211.1875);

    MtxFx33 matRotation;
    MtxFx33 matTemp;
    MTX_RotX33(&matRotation, SinFX(FLOAT_DEG_TO_IDX(22.5)), CosFX(FLOAT_DEG_TO_IDX(22.5)));
    MTX_RotY33(&matTemp, SinFX(FLOAT_DEG_TO_IDX(337.5)), CosFX(FLOAT_DEG_TO_IDX(337.5)));
    MTX_Concat33(&matRotation, &matTemp, &matRotation);

    MTX_RotZ33(&matTemp, SinFX(FLOAT_DEG_TO_IDX(0.0)), CosFX(FLOAT_DEG_TO_IDX(0.0)));
    MTX_Concat33(&matRotation, &matTemp, &matRotation);

    VecFx32 baseTranslation;
    inputPos.x = work->objWork.position.x + FLOAT_TO_FX32(24.0);
    inputPos.y = work->objWork.position.y - FLOAT_TO_FX32(24.0);
    inputPos.z = work->objWork.position.z;
    GameObject__Func_20282A8(&inputPos, &baseTranslation, NULL, FALSE);
    NNS_G3dGlbSetBaseScale(&baseScale);
    NNS_G3dGlbSetBaseRot(&matRotation);
    NNS_G3dGlbSetBaseTrans(&baseTranslation);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
    NNS_G3dGlbFlushP();

    EffectUnknown202C414Entry *entry = work->list;
    for (s32 i = 0; i < 32;)
    {
        if (entry->active)
        {
            NNS_G3dGePushMtx();

            MTX_RotX33(&matRotation, SinFX(entry->angle0), CosFX(entry->angle0));
            MTX_RotY33(&matTemp, SinFX(entry->angle1), CosFX(entry->angle1));
            MTX_Concat33(&matRotation, &matTemp, &matRotation);

            MTX_RotZ33(&matTemp, SinFX(entry->angle2), CosFX(entry->angle2));
            MTX_Concat33(&matRotation, &matTemp, &matRotation);

            NNS_G3dGeMultMtx33(&matRotation);

            NNS_G3dGeTranslate(entry->position.x, entry->position.y, entry->position.z);
            NNS_G3dGeScale(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), entry->scale);

            NNS_G3dGeSendDL(work->drawList, G3_GetDLSize(&work->dlInfo));

            NNS_G3dGePopMtx(1);
        }

        i++;
        entry++;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x8c
	bl GetCurrentTaskWork_
	ldr r3, =0x000D3300
	ldr r2, =FX_SinCosTable_+0x00000400
	mov r8, r0
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	add r0, sp, #0x50
	str r3, [sp, #0x74]
	str r3, [sp, #0x78]
	str r3, [sp, #0x7c]
	bl MTX_RotX33_
	ldr r2, =FX_SinCosTable_+0x00003C00
	add r0, sp, #0x2c
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	add r0, sp, #0x50
	add r1, sp, #0x2c
	mov r2, r0
	bl MTX_Concat33
	ldr r2, =FX_SinCosTable_
	add r0, sp, #0x2c
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotZ33_
	add r0, sp, #0x50
	add r1, sp, #0x2c
	mov r2, r0
	bl MTX_Concat33
	ldr r1, [r8, #0x44]
	add r0, sp, #0x80
	add r1, r1, #0x18000
	str r1, [sp, #0x80]
	ldr r2, [r8, #0x48]
	add r1, sp, #0x20
	sub r2, r2, #0x18000
	str r2, [sp, #0x84]
	ldr r3, [r8, #0x4c]
	mov r2, #0
	str r3, [sp, #0x88]
	mov r3, r2
	bl GameObject__Func_20282A8
	add r0, sp, #0x74
	bl NNS_G3dGlbSetBaseScale
	ldr r1, =NNS_G3dGlb+0x000000BC
	add r0, sp, #0x50
	bl MI_Copy36B
	ldr r1, =NNS_G3dGlb
	add r0, sp, #0x20
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	mov r2, #1
	mov r0, #0x10
	add r1, sp, #4
	str r2, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	bl NNS_G3dGlbFlushP
	ldr r6, =FX_SinCosTable_
	add r9, r8, #0x180
	mov r10, #0
	mov r11, #0x11
	add r7, sp, #0x50
	add r5, sp, #0x2c
	mov r4, #0x1000
_0202C8E4:
	ldrh r0, [r9, #0]
	cmp r0, #0
	beq _0202CA18
	mov r1, #0
	mov r0, r11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	ldrh r1, [r9, #2]
	mov r0, r7
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r6, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r2, #2]
	bl MTX_RotX33_
	ldrh r1, [r9, #4]
	mov r0, r5
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r6, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	mov r0, r7
	mov r1, r5
	mov r2, r7
	bl MTX_Concat33
	ldrh r1, [r9, #6]
	mov r0, r5
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r6, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r2, #2]
	bl MTX_RotZ33_
	mov r0, r7
	mov r1, r5
	mov r2, r7
	bl MTX_Concat33
	mov r0, #0x1a
	mov r1, r7
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	ldr r3, [r9, #0x10]
	ldr r2, [r9, #0xc]
	ldr r1, [r9, #8]
	mov r0, #0x1c
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r3, [sp, #0x1c]
	add r1, sp, #0x14
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r9, #0x14]
	add r1, sp, #8
	str r0, [sp, #0x10]
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r1, [r8, #0x168]
	ldr r0, [r8, #0x170]
	tst r1, #3
	ldrne r1, [r8, #0x16c]
	sub r1, r1, r0
	ldr r0, [r8, #0x17c]
	bl NNS_G3dGeSendDL
	mov r0, #1
	str r0, [sp]
	mov r0, #0x12
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_0202CA18:
	add r10, r10, #1
	cmp r10, #0x20
	add r9, r9, #0x18
	blt _0202C8E4
	add sp, sp, #0x8c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

// EffectSlingDust
EffectSlingDust *EffectSlingDust__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, u8 type)
{
    type = MATH_MIN(type, 1);

    EffectSlingDust *work = CreateEffect(EffectSlingDust, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_sling_dust.bac", GetObjectFileWork(OBJDATAWORK_160), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->objWork, type, 92);

    ObjObjectActionAllocSprite(&work->objWork, Sprite__GetSpriteSize2FromAnim(work->ani.fileWork->fileData, (s32)type), GetObjectSpriteRef(2 * type + OBJDATAWORK_161));
    StageTask__SetAnimation(&work->objWork, (s32)type);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    if ((mtMathRand() & 1) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((mtMathRand() & 1) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.userTimer = 160;

    SetTaskState(&work->objWork, EffectTask_State_MoveTowardsZeroX);

    return work;
}

// EffectSailboatBazookaSmoke
EffectSailboatBazookaSmoke *EffectSailboatBazookaSmoke__Create(StageTask *parent, fx32 velX, fx32 velY, fx32 velZ)
{
    EffectSailboatBazookaSmoke *work = CreateEffect(EffectSailboatBazookaSmoke, parent);
    if (work == NULL)
        return NULL;

    LoadEffectTask3DAsset(&work->effWork, "/mod/sb_bazooka", GetObjectFileWork(OBJDATAWORK_167), gameArchiveStage,
                          B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, EffectTask_State_TrackParent, FALSE);

    MtxFx33 matRotate;
    MtxFx33 matTemp;
    MTX_RotX33(&matRotate, SinFX(parent->dir.x), CosFX(parent->dir.x));
    MTX_RotY33(&matTemp, SinFX((s32)(u16)-parent->dir.y), CosFX((s32)(u16)-parent->dir.y));
    MTX_Concat33(&matRotate, &matTemp, &matRotate);

    MTX_RotZ33(&matTemp, SinFX(parent->dir.z), CosFX(parent->dir.z));
    MTX_Concat33(&matRotate, &matTemp, &matRotate);

    VecFx32 velocity;
    velocity.x = velX;
    velocity.y = velY;
    velocity.z = velZ;
    MTX_MultVec33(&velocity, &matRotate, &velocity);

    work->effWork.objWork.position.x = parent->position.x + velocity.x;
    work->effWork.objWork.position.y = parent->position.y + velocity.y;
    work->effWork.objWork.position.z = parent->position.z + velocity.z;

    work->effWork.objWork.velocity.x = velocity.x;
    work->effWork.objWork.velocity.y = velocity.y;
    work->effWork.objWork.velocity.z = velocity.z;

    work->effWork.objWork.dir = parent->dir;

    work->effWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->effWork.objWork.displayFlag &= ~DISPLAY_FLAG_APPLY_CAMERA_CONFIG;
    work->effWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    return work;
}

// EffectHoverCrystalSparkle
NONMATCH_FUNC EffectHoverCrystalSparkle *EffectHoverCrystalSparkle__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, fx32 accX, fx32 accY)
{
    // https://decomp.me/scratch/PEJri -> 98.12%
#ifdef NON_MATCHING
    EffectHoverCrystalSparkle *work = (EffectHoverCrystalSparkle *)EffectTask__sVars.airEffectSingleton;

    if (work == NULL || work->listCount >= EFFECT_HOVERCRYSTALSPARKLE_PARTICLE_COUNT)
    {
        work = CreateEffect(EffectHoverCrystalSparkle, NULL);
        if (work == NULL)
            return NULL;

        SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectHoverCrystalSparkle__Destructor);
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        EffectTask__sVars.airEffectSingleton = &work->objWork;

        ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_gmk_air_ef.bac", GetObjectDataWork(OBJDATAWORK_174), gameArchiveStage, OBJ_DATA_GFX_NONE);
        ObjObjectActionAllocSprite(&work->objWork, 10, GetObjectSpriteRef(OBJDATAWORK_175));
        ObjActionAllocSpritePalette(&work->objWork, 0, 97);
        StageTask__SetAnimation(&work->objWork, 0);
        StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
        StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
        AnimatorSpriteDS__ProcessAnimationFast(&work->objWork.obj_2d->ani);
        work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

        SetTaskState(&work->objWork, EffectHoverCrystalSparkle__State_202CFB8);
        SetTaskOutFunc(&work->objWork, EffectHoverCrystalSparkle__Draw);
    }

    struct EffectHoverCrystalParticle *particle = &work->list[(work->listStartSlot + work->listCount) & 0x1F];
    particle->position.x                     = x;
    particle->position.y                     = y;
    particle->velocity.x                     = velX;
    particle->velocity.y                     = velY;
    particle->acceleration.x                 = accX;
    particle->acceleration.y                 = accY;
    particle->timer                          = 0;

    work->listCount++;

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, =EffectTask__sVars
	mov r8, r0
	ldr r4, [r4, #4]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	cmp r4, #0
	beq _0202CE0C
	add r0, r4, #0x200
	ldrsh r0, [r0, #0x18]
	cmp r0, #0x20
	blt _0202CF08
_0202CE0C:
	ldr r0, =0x0000059C
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectHoverCrystalSparkle__Destructor
	ldr r0, [r0, #0]
	bl SetTaskDestructorEvent
	ldr r0, [r4, #0x1c]
	ldr r1, =EffectTask__sVars
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	mov r0, #0xae
	str r4, [r1, #4]
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	ldr r2, =aActAcGmkAirEfB
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0xaf
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0xa
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x61
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
	ldr r3, [r4, #0x128]
	mov r1, #0
	ldr r0, [r3, #0x3c]
	mov r2, r1
	orr r0, r0, #0x20
	str r0, [r3, #0x3c]
	ldr r0, [r4, #0x128]
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r3, [r4, #0x128]
	ldr r1, =EffectHoverCrystalSparkle__State_202CFB8
	ldr r2, [r3, #0x3c]
	ldr r0, =EffectHoverCrystalSparkle__Draw
	orr r2, r2, #8
	str r2, [r3, #0x3c]
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
_0202CF08:
	add r1, r4, #0x200
	ldrsh r3, [r1, #0x1a]
	ldrsh r2, [r1, #0x18]
	mov r0, #0x1c
	add ip, r4, #0x21c
	add r2, r3, r2
	and r2, r2, #0x1f
	smulbb r0, r2, r0
	str r8, [ip, r0]
	add r3, ip, r0
	str r7, [r3, #4]
	str r6, [r3, #8]
	ldr r2, [sp, #0x20]
	str r5, [r3, #0xc]
	ldr r0, [sp, #0x24]
	str r2, [r3, #0x10]
	str r0, [r3, #0x14]
	mov r0, #0
	strh r0, [r3, #0x18]
	ldrsh r2, [r1, #0x18]
	mov r0, r4
	add r2, r2, #1
	strh r2, [r1, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

void EffectHoverCrystalSparkle__Destructor(Task *task)
{
    EffectHoverCrystalSparkle *work = TaskGetWork(task, EffectHoverCrystalSparkle);

    if (EffectTask__sVars.airEffectSingleton == &work->objWork)
        EffectTask__sVars.airEffectSingleton = NULL;

    StageTask_Destructor(task);
}

void EffectHoverCrystalSparkle__State_202CFB8(EffectHoverCrystalSparkle *work)
{
    s32 i           = 0;
    s32 removeCount = 0;

    for (; i < work->listCount; i++)
    {
        struct EffectHoverCrystalParticle *particle = &work->list[(work->listStartSlot + i) & 0x1F];

        particle->timer++;
        if (particle->timer >= 36)
        {
            removeCount++;
            work->listStartSlot = (work->listStartSlot + 1) & 0x1F;
        }
        else
        {
            particle->position.x += particle->velocity.x;
            particle->position.y += particle->velocity.y;

            particle->velocity.x += particle->acceleration.x;
            particle->velocity.y += particle->acceleration.y;
        }
    }

    work->listCount -= removeCount;
    if (work->listCount <= 0)
    {
        if (EffectTask__sVars.airEffectSingleton == &work->objWork)
            EffectTask__sVars.airEffectSingleton = NULL;

        DestroyStageTask(&work->objWork);
    }
}

void EffectHoverCrystalSparkle__Draw(void)
{
    s32 i;
    s32 lastTime;
    struct EffectHoverCrystalParticle *particle;
    u32 displayFlag = DISPLAY_FLAG_NO_ANIMATE_CB;

    EffectHoverCrystalSparkle *work = TaskGetWorkCurrent(EffectHoverCrystalSparkle);

    AnimatorSpriteDS *aniSparkle = &work->objWork.obj_2d->ani;
    AnimatorSpriteDS__SetAnimation(aniSparkle, 0);

    VecFx32 position;
    position.z = FLOAT_TO_FX32(0.0);

    lastTime = 0;
    for (i = work->listCount - 1; i >= 0; i--)
    {
        particle = &work->list[(work->listStartSlot + i) & 0x1F];

        fx32 advance = (particle->timer - lastTime);
        if (advance != 0)
        {
            AnimatorSpriteDS__AnimateManualFast(aniSparkle, FX32_FROM_WHOLE(advance));
            lastTime = particle->timer;
        }

        position.x = particle->position.x;
        position.y = particle->position.y;
        StageTask__Draw2DEx(aniSparkle, &position, NULL, NULL, &displayFlag, NULL, NULL);
    }
}

// EffectIceSparklesSpawner
void EffectIceSparklesSpawner__Create(StageTask *parent)
{
    EffectIceSparklesSpawner *work = CreateEffect(EffectIceSparklesSpawner, parent);
    if (work == NULL)
        return;

    SetTaskState(&work->objWork, EffectIceSparklesSpawner__State_202D19C);
}

void EffectIceSparklesSpawner__State_202D19C(EffectIceSparklesSpawner *work)
{
    StageTask *parent = work->objWork.parentObj;

    if ((work->objWork.userTimer & 3) == 0)
    {
        fx32 y = parent->position.y + FX32_FROM_WHOLE((3 - (mtMathRand() & 6))) + FLOAT_TO_FX32(16.0);
        fx32 x = parent->position.x + FX32_FROM_WHOLE((3 - (mtMathRand() & 6)));

        EffectIceSparkles__Create(x, y, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.0), 1);
    }

    work->objWork.userTimer++;
    if (work->objWork.userTimer >= 60)
        DestroyStageTask(&work->objWork);
}

// EffectMedal
NONMATCH_FUNC EffectMedal *EffectMedal__Create(StageTask *parent)
{
    // will match when the strings are decompiled
#ifdef NON_MATCHING
    EffectMedal *work = CreateEffect(EffectMedal, parent);
    if (work == NULL)
        return NULL;

    SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectMedal__Destructor);

    u16 animID;
    switch (gameState.stageID)
    {
        default:
            // case STAGE_Z11:
            animID = 0;
            break;

        case STAGE_Z12:
            animID = 1;
            break;

        case STAGE_Z21:
            animID = 2;
            break;

        case STAGE_Z22:
            animID = 3;
            break;

        case STAGE_Z31:
            animID = 4;
            break;

        case STAGE_Z32:
            animID = 5;
            break;

        case STAGE_Z41:
            animID = 6;
            break;

        case STAGE_Z42:
            animID = 7;
            break;

        case STAGE_Z51:
            animID = 8;
            break;

        case STAGE_Z52:
            animID = 9;
            break;

        case STAGE_Z61:
            animID = 10;
            break;

        case STAGE_Z62:
            animID = 11;
            break;

        case STAGE_Z71:
            animID = 12;
            break;

        case STAGE_Z72:
            animID = 13;
            break;
    }

    char path[64];
    char id[3];
    id[0] = FX_DivS32(animID, 10) + '0';
    id[1] = FX_ModS32(animID, 10) + '0';
    id[2] = 0;
    STD_CopyString(path, "/act/ac_gmk_medal");
    STD_ConcatenateString(path, id);
    STD_ConcatenateString(path, ".bac");

    ObjObjectAction2dBACLoad(&work->objWork, &work->aniSprite, path, GetObjectDataWork(OBJDATAWORK_156), 0, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 108);
    StageTask__SetAnimation(&work->objWork, 0);
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_13);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    STD_CopyString(path, "/bpa/gmk_medal");
    STD_ConcatenateString(path, id);
    STD_ConcatenateString(path, ".bpa");

    InitPaletteAnimator(&work->aniPalette, ObjDataLoad(GetObjectDataWork(OBJDATAWORK_157), path, NULL), 0, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SPRITE,
                        VRAMKEY_TO_ADDR(&((u16 *)VRAM_OBJ_PLTT)[16 * work->objWork.obj_2d->ani.cParam[0].palette]));

    work->objWork.position.y -= FLOAT_TO_FX32(32.0);

    work->objWork.scale.x = FLOAT_TO_FX32(0.0);
    work->objWork.scale.y = FLOAT_TO_FX32(0.0);

    work->objWork.velocity.y = -FLOAT_TO_FX32(7.0);

    SetTaskState(&work->objWork, EffectMedal__State_202D514);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r1, r0
	mov r0, #0x23c
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #0x4c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectMedal__Destructor
	ldr r0, [r0, #0]
	bl SetTaskDestructorEvent
	ldr r0, =gameState
	ldrh r0, [r0, #0x28]
	cmp r0, #0x16
	addls pc, pc, r0, lsl #2
	b _0202D2F8
_0202D29C: // jump table
	b _0202D2F8 // case 0
	b _0202D300 // case 1
	b _0202D2F8 // case 2
	b _0202D2F8 // case 3
	b _0202D308 // case 4
	b _0202D310 // case 5
	b _0202D2F8 // case 6
	b _0202D318 // case 7
	b _0202D320 // case 8
	b _0202D2F8 // case 9
	b _0202D2F8 // case 10
	b _0202D328 // case 11
	b _0202D330 // case 12
	b _0202D2F8 // case 13
	b _0202D338 // case 14
	b _0202D340 // case 15
	b _0202D2F8 // case 16
	b _0202D348 // case 17
	b _0202D350 // case 18
	b _0202D2F8 // case 19
	b _0202D2F8 // case 20
	b _0202D358 // case 21
	b _0202D360 // case 22
_0202D2F8:
	mov r5, #0
	b _0202D364
_0202D300:
	mov r5, #1
	b _0202D364
_0202D308:
	mov r5, #2
	b _0202D364
_0202D310:
	mov r5, #3
	b _0202D364
_0202D318:
	mov r5, #4
	b _0202D364
_0202D320:
	mov r5, #5
	b _0202D364
_0202D328:
	mov r5, #6
	b _0202D364
_0202D330:
	mov r5, #7
	b _0202D364
_0202D338:
	mov r5, #8
	b _0202D364
_0202D340:
	mov r5, #9
	b _0202D364
_0202D348:
	mov r5, #0xa
	b _0202D364
_0202D350:
	mov r5, #0xb
	b _0202D364
_0202D358:
	mov r5, #0xc
	b _0202D364
_0202D360:
	mov r5, #0xd
_0202D364:
	mov r0, r5
	mov r1, #0xa
	bl FX_DivS32
	add r2, r0, #0x30
	mov r0, r5
	mov r1, #0xa
	strb r2, [sp, #8]
	bl FX_ModS32
	add r3, r0, #0x30
	mov r2, #0
	ldr r1, =aActAcGmkMedal
	add r0, sp, #0xb
	strb r3, [sp, #9]
	strb r2, [sp, #0xa]
	bl STD_CopyString
	add r0, sp, #0xb
	add r1, sp, #8
	bl STD_ConcatenateString
	ldr r1, =_0211930C
	add r0, sp, #0xb
	bl STD_ConcatenateString
	mov r0, #0x9c
	bl GetObjectFileWork
	mov r3, r0
	mov r0, #0
	str r0, [sp]
	ldr r1, =0x0000FFFF
	mov r0, r4
	str r1, [sp, #4]
	add r1, r4, #0x168
	add r2, sp, #0xb
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x6c
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, #0xd
	orr r2, r2, #0x200
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r1, =aBpaGmkMedal
	add r0, sp, #0xb
	bl STD_CopyString
	add r0, sp, #0xb
	add r1, sp, #8
	bl STD_ConcatenateString
	ldr r1, =_02119324
	add r0, sp, #0xb
	bl STD_ConcatenateString
	mov r0, #0x9d
	bl GetObjectFileWork
	add r1, sp, #0xb
	mov r2, #0
	bl ObjDataLoad
	mov r2, #0
	str r2, [sp]
	ldr r3, [r4, #0x128]
	mov r1, r0
	ldrh ip, [r3, #0x90]
	add r0, r4, #0x218
	mov r3, #2
	mov ip, ip, lsl #5
	add ip, ip, #0x200
	add ip, ip, #0x5000000
	str ip, [sp, #4]
	bl InitPaletteAnimator
	ldr r1, [r4, #0x48]
	mov r0, #0
	sub r1, r1, #0x20000
	str r1, [r4, #0x48]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	sub r0, r0, #0x7000
	str r0, [r4, #0x9c]
	ldr r1, =EffectMedal__State_202D514
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
// clang-format on
#endif
}

void EffectMedal__Destructor(Task *task)
{
    EffectMedal *work = TaskGetWork(task, EffectMedal);

    ReleasePaletteAnimator(&work->aniPalette);
    ObjDataRelease(GetObjectDataWork(OBJDATAWORK_157));

    StageTask_Destructor(task);
}

NONMATCH_FUNC void EffectMedal__State_202D514(EffectMedal *work)
{
    // https://decomp.me/scratch/YWcKZ -> 93.98%
#ifdef NON_MATCHING
    if ((work->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B) != 0)
    {
        u32 flagsA             = mapCamera.camera[0].flags;
        u32 flagsB             = mapCamera.camera[1].flags;
        BOOL useObjDrawPalette = FALSE;

        AnimatePalette(&work->aniPalette);
        if (CheckPaletteAnimationIsValid(&work->aniPalette))
        {
            if ((flagsA & MAPSYS_CAMERA_FLAG_1000000) == 0 || (flagsA & MAPSYS_CAMERA_FLAG_2000000) != 0)
            {
                SetPaletteAnimationTarget(&work->aniPalette, PALETTE_MODE_SPRITE, &((u16 *)VRAM_OBJ_PLTT)[16 * work->objWork.obj_2d->ani.cParam[0].palette]);
                DrawAnimatedPalette(&work->aniPalette);
            }
            else
            {
                useObjDrawPalette = TRUE;
            }

            if ((flagsB & MAPSYS_CAMERA_FLAG_1000000) == 0 || (flagsB & MAPSYS_CAMERA_FLAG_2000000) != 0)
            {
                SetPaletteAnimationTarget(&work->aniPalette, PALETTE_MODE_SPRITE, &((u16 *)VRAM_DB_OBJ_PLTT)[16 * work->objWork.obj_2d->ani.cParam[0].palette]);
                DrawAnimatedPalette(&work->aniPalette);
            }
            else
            {
                useObjDrawPalette = TRUE;
            }

            if (useObjDrawPalette)
            {
                SetPaletteAnimationTarget(&work->aniPalette, PALETTE_MODE_SPRITE, &objDrawPalette2[16 * work->objWork.obj_2d->ani.cParam[0].palette]);
                DrawAnimatedPalette(&work->aniPalette);
            }
        }
    }

    switch (work->objWork.userWork)
    {
        case 0:
            work->objWork.userTimer += 68;

            if (work->objWork.userTimer > FLOAT_TO_FX32(1.0))
            {
                work->objWork.userWork++;
                work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
                work->objWork.scale.x = work->objWork.scale.y = FLOAT_TO_FX32(1.0);
                work->objWork.velocity.y                      = FLOAT_TO_FX32(0.0);
            }
            else
            {
                work->objWork.scale.x = mtLerpEx(work->objWork.userTimer, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), 1);
                work->objWork.scale.y = work->objWork.scale.x;

                if (work->objWork.userTimer <= FLOAT_TO_FX32(0.5))
                {
                    work->objWork.velocity.y = mtLerpEx(2 * work->objWork.userTimer, -FLOAT_TO_FX32(7.0), FLOAT_TO_FX32(0.0), 0);
                }
                else
                {
                    work->objWork.velocity.y = mtLerpEx(2 * (work->objWork.userTimer - FLOAT_TO_FX32(0.5)), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(7.0), 0);
                }
            }
            break;

        case 1:
            break;
    }

    if (work->objWork.scale.x > FLOAT_TO_FX32(0.0625))
    {
        if ((work->sparkleTimer & 0xF) == 0)
        {
            fx32 offsetY = FX32_FROM_WHOLE((15 - (mtMathRand() & 0x1E)));
            fx32 offsetX = FX32_FROM_WHOLE((15 - (mtMathRand() & 0x1E)));
            EffectRingSparkle__Create(work->objWork.position.x + offsetX, work->objWork.position.y + offsetY, 0, 0, 0, 0);
        }

        work->sparkleTimer++;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #1
	beq _0202D600
	ldr r1, =mapCamera
	add r0, r4, #0x218
	ldr r7, [r1, #0]
	ldr r5, [r1, #0x70]
	mov r6, #0
	bl AnimatePalette
	add r0, r4, #0x218
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _0202D600
	tst r7, #0x1000000
	beq _0202D564
	tst r7, #0x2000000
	beq _0202D590
_0202D564:
	ldr r1, [r4, #0x128]
	add r0, r4, #0x218
	ldrh r2, [r1, #0x90]
	mov r1, #0
	mov r2, r2, lsl #5
	add r2, r2, #0x200
	add r2, r2, #0x5000000
	bl SetPaletteAnimationTarget
	add r0, r4, #0x218
	bl DrawAnimatedPalette
	b _0202D594
_0202D590:
	mov r6, #1
_0202D594:
	tst r5, #0x1000000
	beq _0202D5A4
	tst r5, #0x2000000
	beq _0202D5D0
_0202D5A4:
	ldr r1, [r4, #0x128]
	add r0, r4, #0x218
	ldrh r2, [r1, #0x90]
	mov r1, #0
	mov r2, r2, lsl #5
	add r2, r2, #0x600
	add r2, r2, #0x5000000
	bl SetPaletteAnimationTarget
	add r0, r4, #0x218
	bl DrawAnimatedPalette
	b _0202D5D4
_0202D5D0:
	mov r6, #1
_0202D5D4:
	cmp r6, #0
	beq _0202D600
	ldr r0, [r4, #0x128]
	ldr r3, =objDrawPalette2
	ldrh r2, [r0, #0x90]
	add r0, r4, #0x218
	mov r1, #0
	add r2, r3, r2, lsl #5
	bl SetPaletteAnimationTarget
	add r0, r4, #0x218
	bl DrawAnimatedPalette
_0202D600:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _0202D614
	cmp r0, #1
	b _0202D764
_0202D614:
	ldr r0, [r4, #0x2c]
	add r0, r0, #0x44
	str r0, [r4, #0x2c]
	cmp r0, #0x1000
	ble _0202D658
	ldr r1, [r4, #0x28]
	mov r0, #0x1000
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r4, #0x18]
	orr r1, r1, #1
	str r1, [r4, #0x18]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x38]
	mov r0, #0
	str r0, [r4, #0x9c]
	b _0202D764
_0202D658:
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, #0
	mov r2, r3, asr #0x1f
	mov r1, #1
	mov r6, r0
	mov r5, #0x800
_0202D674:
	rsb r7, r0, #0x1000
	umull ip, r8, r7, r3
	mla r8, r7, r2, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r3, r8
	adds ip, ip, r5
	adc r7, r8, r6
	mov r8, ip, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r1, #0
	add r0, r0, r8
	sub r1, r1, #1
	bne _0202D674
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x2c]
	cmp r0, #0x800
	bgt _0202D714
	mov r0, r0, lsl #0x11
	mov r3, r0, asr #0x10
	mov r1, #0
	sub r0, r1, #0x7000
	mov r2, r3, asr #0x1f
	mov r6, r1
	mov r5, #0x800
_0202D6D8:
	rsb ip, r0, #0
	umull r7, lr, ip, r3
	mla lr, ip, r2, lr
	mov ip, ip, asr #0x1f
	adds r8, r7, r5
	mla lr, ip, r3, lr
	adc r7, lr, r6
	mov r8, r8, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r1, #0
	add r0, r0, r8
	sub r1, r1, #1
	bne _0202D6D8
	str r0, [r4, #0x9c]
	b _0202D764
_0202D714:
	sub r0, r0, #0x800
	mov r0, r0, lsl #0x11
	mov ip, r0, asr #0x10
	mov r7, #0
	mov r8, ip, asr #0x1f
	mov r6, #0x7000
	mov r1, r7
	mov r0, #0x800
_0202D734:
	umull r5, r3, r6, ip
	mla r3, r6, r8, r3
	mov r2, r6, asr #0x1f
	adds r5, r5, r0
	mla r3, r2, ip, r3
	adc r2, r3, r1
	mov r6, r5, lsr #0xc
	cmp r7, #0
	orr r6, r6, r2, lsl #20
	sub r7, r7, #1
	bne _0202D734
	str r6, [r4, #0x9c]
_0202D764:
	ldr r0, [r4, #0x38]
	cmp r0, #0x100
	addle sp, sp, #8
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x238]
	tst r0, #0xf
	bne _0202D7EC
	ldr r5, =_obj_disp_rand
	mov r2, #0
	ldr r6, [r5, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mov r3, r2
	mla ip, r6, r0, r1
	mla r0, ip, r0, r1
	str r0, [r5]
	str r2, [sp]
	str r2, [sp, #4]
	ldr r0, [r5, #0]
	mov r5, ip, lsr #0x10
	mov r1, r0, lsr #0x10
	mov r0, r5, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	and r1, r0, #0x1e
	and r0, r5, #0x1e
	ldr ip, [r4, #0x44]
	rsb r6, r1, #0xf
	ldr r5, [r4, #0x48]
	rsb r1, r0, #0xf
	add r0, ip, r6, lsl #12
	add r1, r5, r1, lsl #12
	bl EffectRingSparkle__Create
_0202D7EC:
	ldr r0, [r4, #0x238]
	add r0, r0, #1
	str r0, [r4, #0x238]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

// EffectRingSparkle
NONMATCH_FUNC EffectRingSparkle *EffectRingSparkle__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, fx32 accX, fx32 accY)
{
    // will match when "/ac_itm_ring.bac" is decompiled
#ifdef NON_MATCHING
    if (ringManagerWork == NULL)
        return NULL;

    EffectRingSparkle *work = CreateEffect(EffectRingSparkle, NULL);
    if (work == NULL)
        return NULL;

    SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectRingSparkle__Destructor);

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_itm_ring.bac", GetObjectFileWork(OBJDATAWORK_153), gameArchiveCommon, OBJ_DATA_GFX_NONE);
    work->objWork.obj_2d->ani.vramPixels[0]     = ringManagerWork->aniRingSparkle.vramPixels[0];
    work->objWork.obj_2d->ani.vramPixels[1]     = ringManagerWork->aniRingSparkle.vramPixels[1];
    work->objWork.obj_2d->ani.cParam[1].palette = 2;
    work->objWork.obj_2d->ani.cParam[0].palette = work->objWork.obj_2d->ani.cParam[1].palette;
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    StageTask__SetAnimation(&work->objWork, 1);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    work->objWork.position.x     = x;
    work->objWork.position.y     = y;
    work->objWork.velocity.x     = velX;
    work->objWork.velocity.y     = velY;
    work->objWork.acceleration.x = accX;
    work->objWork.acceleration.y = accY;

    InitEffectTaskViewCheck(&work->objWork, 16, 0, 0, 0, 0);

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, =ringManagerWork
	mov r8, r0
	ldr r0, [r4, #0]
	mov r7, r1
	cmp r0, #0
	mov r6, r2
	mov r5, r3
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0x218
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectRingSparkle__Destructor
	ldr r0, [r0, #0]
	bl SetTaskDestructorEvent
	mov r0, #0x99
	bl GetObjectFileWork
	ldr r1, =gameArchiveCommon
	mov r3, r0
	ldr r1, [r1, #0]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, r4
	add r1, r4, #0x168
	ldr r2, =aAcItmRingBac_0
	bl ObjObjectAction2dBACLoad
	ldr r1, =ringManagerWork
	ldr r2, [r4, #0x128]
	ldr r0, [r1, #0]
	mov r3, #2
	ldr ip, [r0, #0x130]
	mov r0, r4
	str ip, [r2, #0x78]
	ldr r1, [r1, #0]
	ldr r2, [r4, #0x128]
	ldr ip, [r1, #0x134]
	mov r1, #1
	str ip, [r2, #0x7c]
	ldr r2, [r4, #0x128]
	strh r3, [r2, #0x92]
	ldr r3, [r4, #0x128]
	ldrh r2, [r3, #0x92]
	strh r2, [r3, #0x90]
	ldr r3, [r4, #0x128]
	ldr r2, [r3, #0x3c]
	orr r2, r2, #0x10
	str r2, [r3, #0x3c]
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
	str r5, [r4, #0x9c]
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	str r1, [r4, #0xa4]
	str r0, [r4, #0xa8]
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
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

void EffectRingSparkle__Destructor(Task *task)
{
    EffectRingSparkle *work = TaskGetWork(task, EffectRingSparkle);

    work->objWork.obj_2d->ani.vramPixels[0] = NULL;
    work->objWork.obj_2d->ani.vramPixels[1] = NULL;

    StageTask_Destructor(task);
}

// EffectButtonPrompt
// static const u8 EffectButtonPrompt_animIDs[2]                               = { 1, 0 };

NONMATCH_FUNC EffectButtonPrompt *EffectButtonPrompt__Create(StageTask *parent, s32 type)
{
	// will match when "/ac_fix_key_little.bac" is decompiled
#ifdef NON_MATCHING

    EffectButtonPrompt *work = CreateEffect(EffectButtonPrompt, parent);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_fix_key_little.bac", GetObjectFileWork(OBJDATAWORK_152), gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    work->objWork.obj_2d->ani.cParam[1].palette = 1;
    work->objWork.obj_2d->ani.cParam[0].palette = work->objWork.obj_2d->ani.cParam[1].palette;
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    StageTask__SetAnimation(&work->objWork, EffectButtonPrompt_animIDs[type]);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_6);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->objWork.position.y -= FLOAT_TO_FX32(32.0);
    SetTaskState(&work->objWork, states[type]);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r1
	mov r1, r0
	mov r0, #0x218
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #0x98
	bl GetObjectFileWork
	ldr r1, =gameArchiveCommon
	ldr ip, =0x0000FFFF
	ldr r1, [r1, #0]
	mov r3, r0
	stmia sp, {r1, ip}
	ldr r2, =aAcFixKeyLittle
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r2, #1
	strh r2, [r1, #0x92]
	ldr r3, [r4, #0x128]
	ldr r0, =EffectButtonPrompt_animIDs
	ldrh r2, [r3, #0x92]
	ldrb r1, [r0, r5]
	mov r0, r4
	strh r2, [r3, #0x90]
	ldr r3, [r4, #0x128]
	ldr r2, [r3, #0x3c]
	orr r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #6
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r1, [r4, #0x1c]
	ldr r0, =EffectButtonPrompt__states
	orr r2, r1, #0x2000
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r1, [r0, r5, lsl #2]
	orr r2, r2, #4
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x48]
	mov r0, r4
	sub r2, r2, #0x20000
	str r2, [r4, #0x48]
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
// clang-format on
#endif
}

void EffectButtonPrompt__State_DPadUp(EffectButtonPrompt *work)
{
    StageTask *parent = work->objWork.parentObj;
    if (parent != NULL)
    {
        work->objWork.position.x = parent->position.x;
        work->objWork.position.y = parent->position.y - FLOAT_TO_FX32(32.0);

        work->objWork.userTimer++;
        if (work->objWork.userTimer >= 300 || !StageTaskStateMatches(parent, Player__State_DreamWing))
            DestroyStageTask(&work->objWork);
    }
}

void EffectButtonPrompt__State_JumpButton(EffectButtonPrompt *work)
{
    StageTask *parent = work->objWork.parentObj;
    if (parent != NULL)
    {
        work->objWork.position.x = parent->position.x;
        work->objWork.position.y = parent->position.y - FLOAT_TO_FX32(32.0);

        if (parent->userWork != JUMPBOX_STATE_VAULTING || !StageTaskStateMatches(parent, Player__State_JumpBox))
            DestroyStageTask(&work->objWork);
    }
}
