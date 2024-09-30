#include <stage/objects/springCrystal.h>
#include <stage/effects/truckSparkles.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// ENUMS
// --------------------

enum SpringCrystalAnimIDs
{
    SPRINGCRYSTAL_ANI_IDLE_V,
    SPRINGCRYSTAL_ANI_ACTIVATED_V,
    SPRINGCRYSTAL_ANI_IDLE_H,
    SPRINGCRYSTAL_ANI_ACTIVATED_H,
};

// --------------------
// VARIABLES
// --------------------

static Vec2Fx32 bounceForce[4][2] = {
    {
        { -FLOAT_TO_FX32(4.65625), -FLOAT_TO_FX32(4.65625), },
        { FLOAT_TO_FX32(4.65625), -FLOAT_TO_FX32(4.65625), },
    },

    {
        { -FLOAT_TO_FX32(4.65625), FLOAT_TO_FX32(4.65625), },
        { FLOAT_TO_FX32(4.65625), FLOAT_TO_FX32(4.65625), },
    },

    {
        { -FLOAT_TO_FX32(4.65625), -FLOAT_TO_FX32(4.65625), },
        { -FLOAT_TO_FX32(4.65625), FLOAT_TO_FX32(4.65625), },
    },

    {
        { FLOAT_TO_FX32(4.65625), -FLOAT_TO_FX32(4.65625), },
        { FLOAT_TO_FX32(4.65625), FLOAT_TO_FX32(4.65625), },
    },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SpringCrystal_State_Activated(SpringCrystal *work);
static void SpringCrystal_Draw(void);
static void SpringCrystal_OnDefend_L(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void SpringCrystal_OnDefend_R(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void SpringCrystal_HandleInteractions(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2, u32 type);

// --------------------
// FUNCTIONS
// --------------------

SpringCrystal *CreateSpringCrystal(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, SpringCrystal);
    if (task == HeapNull)
        return NULL;

    SpringCrystal *work = TaskGetWork(task, SpringCrystal);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_sprg_crystal.bac", GetObjectDataWork(OBJDATAWORK_172), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SPRINGCRYSTAL_ANI_IDLE_V, 48);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    u16 anim;
    switch (mapObject->id)
    {
        default:
        case MAPOBJECT_163:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
            // fallthrough

        case MAPOBJECT_162:
            anim                            = SPRINGCRYSTAL_ANI_IDLE_V;
            work->gameWork.objWork.userWork = SPRINGCRYSTAL_ANI_IDLE_V;

            ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -50, -64, 0, -24);
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, 0, -64, 50, -24);

            ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_sprg_crystal_v.df", GetObjectDataWork(OBJDATAWORK_200), gameArchiveStage);
            work->gameWork.collisionObject.work.width  = 96;
            work->gameWork.collisionObject.work.height = 64;
            work->gameWork.collisionObject.work.ofst_x = -48;
            work->gameWork.collisionObject.work.ofst_y = -64;
            break;

        case MAPOBJECT_165:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            // fallthrough

        case MAPOBJECT_164:
            anim                            = SPRINGCRYSTAL_ANI_IDLE_H;
            work->gameWork.objWork.userWork = SPRINGCRYSTAL_ANI_IDLE_H;

            ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -64, -50, -24, 0);
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -64, 0, -24, 50);

            ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_sprg_crystal_h.df", GetObjectDataWork(OBJDATAWORK_201), gameArchiveStage);
            work->gameWork.collisionObject.work.width  = 64;
            work->gameWork.collisionObject.work.height = 96;
            work->gameWork.collisionObject.work.ofst_x = -64;
            work->gameWork.collisionObject.work.ofst_y = -48;
            break;
    }
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], SpringCrystal_OnDefend_L);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    work->gameWork.colliders[1].parent = &work->gameWork.objWork;
    ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], SpringCrystal_OnDefend_R);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400;

    work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;

    SetTaskOutFunc(&work->gameWork.objWork, SpringCrystal_Draw);

    return work;
}

void SpringCrystal_State_Activated(SpringCrystal *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, work->gameWork.objWork.userWork);
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void SpringCrystal_Draw(void)
{
    SpringCrystal *work = TaskGetWorkCurrent(SpringCrystal);

    StageDisplayFlags altDisplayFlag = work->gameWork.objWork.displayFlag | DISPLAY_FLAG_PAUSED;
    if (work->gameWork.mapObject->id == MAPOBJECT_162 || work->gameWork.mapObject->id == MAPOBJECT_163)
        altDisplayFlag |= DISPLAY_FLAG_FLIP_X;
    else
        altDisplayFlag |= DISPLAY_FLAG_FLIP_Y;
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    StageDisplayFlags displayFlagStore = work->gameWork.objWork.displayFlag;
    work->gameWork.objWork.displayFlag = altDisplayFlag;
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
    work->gameWork.objWork.displayFlag = displayFlagStore;
}

void SpringCrystal_OnDefend_L(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SpringCrystal_HandleInteractions(rect1, rect2, 0);
}

void SpringCrystal_OnDefend_R(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SpringCrystal_HandleInteractions(rect1, rect2, 1);
}

NONMATCH_FUNC void SpringCrystal_HandleInteractions(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2, u32 type)
{
#ifdef NON_MATCHING
    SpringCrystal *springCrystal = (SpringCrystal *)rect2->parent;
    Player *player               = (Player *)rect1->parent;

    if (springCrystal == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    fx32 playerX  = player->objWork.position.x;
    fx32 playerY  = player->objWork.position.y;
    fx32 crystalX = springCrystal->gameWork.objWork.position.x;
    fx32 crystalY = springCrystal->gameWork.objWork.position.y;

    fx32 offsetX1;
    fx32 offsetY1;
    fx32 offsetX2;
    fx32 offsetY2;
    u16 flags1;
    u16 flags2;

    if (springCrystal->gameWork.mapObject->id != MAPOBJECT_162)
    {
        u16 angle = 0;
        switch (springCrystal->gameWork.mapObject->id)
        {
            case MAPOBJECT_163:
                angle = FLOAT_DEG_TO_IDX(180.0);

                offsetY2 = FLOAT_TO_FX32(42.0);
                offsetY1 = FLOAT_TO_FX32(42.0);
                offsetX1 = FLOAT_TO_FX32(26.0);
                offsetX2 = -FLOAT_TO_FX32(26.0);

                flags1 = 0;
                flags2 = 1;
                break;

            case MAPOBJECT_164:
                angle = FLOAT_DEG_TO_IDX(90.0);

                offsetX1 = -FLOAT_TO_FX32(42.0);
                offsetY1 = FLOAT_TO_FX32(26.0);
                offsetX2 = -FLOAT_TO_FX32(42.0);
                offsetY2 = -FLOAT_TO_FX32(26.0);

                flags1 = 1;
                flags2 = 3;
                break;

            case MAPOBJECT_165:
                angle = FLOAT_DEG_TO_IDX(270.0);

                offsetX1 = FLOAT_TO_FX32(42.0);
                offsetY1 = FLOAT_TO_FX32(26.0);
                offsetX2 = FLOAT_TO_FX32(42.0);
                offsetY2 = -FLOAT_TO_FX32(26.0);

                flags1 = 0;
                flags2 = 2;
                break;
        }

        MtxFx33 mtx;
        VecFx32 dest;
        dest.x = playerX - crystalX;
        dest.y = playerY - crystalY;
        dest.z = 0;

        MTX_RotZ33(&mtx, SinFX((s32)angle), CosFX((s32)angle));
        MTX_MultVec33(&dest, &mtx, &dest);

        playerX = dest.x + crystalX;
        playerY = dest.y + crystalY;
    }
    else
    {
        offsetX2 = -FLOAT_TO_FX32(26.0);
        offsetX1 = FLOAT_TO_FX32(26.0);
        offsetY1 = -FLOAT_TO_FX32(42.0);
        offsetY2 = -FLOAT_TO_FX32(42.0);

        flags1 = 2;
        flags2 = 3;
    }

    fx32 distance;
    if (playerY <= crystalY - FLOAT_TO_FX32(64.0))
    {
        distance = FLOAT_TO_FX32(20.0);
    }
    else
    {
        if (playerY < crystalY - FLOAT_TO_FX32(24.0))
            distance = FLOAT_TO_FX32(20.0) + FX_Div(50 * (FLOAT_TO_FX32(40.0) - ((crystalY - playerY) - FLOAT_TO_FX32(24.0))), FLOAT_TO_FX32(40.0));
        else
            distance = FLOAT_TO_FX32(70.0);
    }

    if (crystalX >= playerX)
    {
        if (playerX - crystalX > distance)
        {
            ObjRect__FuncNoHit(rect1, rect2);
            return;
        }
    }
    else if (crystalX - playerX > distance)
    {
        ObjRect__FuncNoHit(rect1, rect2);
        return;
    }

    StageTask__SetAnimation(&springCrystal->gameWork.objWork, springCrystal->gameWork.objWork.userWork + SPRINGCRYSTAL_ANI_ACTIVATED_V);

    fx32 force = springCrystal->gameWork.mapObject->left;
    fx32 velX  = bounceForce[springCrystal->gameWork.mapObject->id - MAPOBJECT_162][2 * type].x;
    fx32 velY  = bounceForce[springCrystal->gameWork.mapObject->id - MAPOBJECT_162][2 * type].y;

    if (velX >= 0)
        velX += (force << 11);
    else
        velX -= (force << 11);

    if (velY >= 0)
        velY += (force * FLOAT_TO_FX32(0.5));
    else
        velY -= (force * FLOAT_TO_FX32(0.5));

    Player__Action_SpringCrystal(player, velX, velY);
    Player__Action_AllowTrickCombos(player, &springCrystal->gameWork);
    EffectTruckSparkles__Create(&springCrystal->gameWork.objWork, 16, 2, offsetX1, offsetY1, flags1);
    EffectTruckSparkles__Create(&springCrystal->gameWork.objWork, 16, 2, offsetX2, offsetY2, flags2);

    SetTaskState(&springCrystal->gameWork.objWork, SpringCrystal_State_Activated);

    NNS_SndPlayerStopSeqBySeqArcIdx(SND_ZONE_SEQARC_GAME_SE, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING_CRYSTAL, 0);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING_CRYSTAL);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	ldr r4, [r1, #0x1c]
	str r1, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	str r0, [sp, #8]
	cmpne r5, #0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r4, #0x340]
	ldr r8, [r5, #0x44]
	ldrh r2, [r0, #2]
	ldr r0, [r5, #0x48]
	ldr r9, [r4, #0x44]
	cmp r2, #0xa2
	ldr r10, [r4, #0x48]
	beq _0216D3FC
	cmp r2, #0xa3
	mov r1, #0
	beq _0216D318
	cmp r2, #0xa4
	beq _0216D344
	cmp r2, #0xa5
	beq _0216D36C
	b _0216D390
_0216D318:
	mov r2, #0x1a000
	str r1, [sp, #0x14]
	mov r1, r2
	mov r11, #0x2a000
	sub r1, r1, #0x34000
	str r1, [sp, #0x18]
	str r2, [sp, #0x1c]
	mov r6, r11
	mov r1, #0x8000
	mov r7, #1
	b _0216D390
_0216D344:
	mov r1, #0x4000
	sub r2, r1, #0x2e000
	mov r6, #0x1a000
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	mov r2, #1
	sub r11, r6, #0x34000
	str r2, [sp, #0x14]
	mov r7, #3
	b _0216D390
_0216D36C:
	mov r2, #0x2a000
	mov r6, #0x1a000
	str r1, [sp, #0x14]
	mov r1, r2
	str r1, [sp, #0x1c]
	str r2, [sp, #0x18]
	sub r11, r6, #0x34000
	mov r1, #0xc000
	mov r7, #2
_0216D390:
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	sub r2, r8, r9
	mov r8, r1, lsl #1
	sub r0, r0, r10
	str r0, [sp, #0x24]
	mov r0, #0
	str r0, [sp, #0x28]
	add r1, r1, #1
	str r2, [sp, #0x20]
	ldr r3, =FX_SinCosTable_
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r8]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x2c
	bl MTX_RotZ33_
	add r0, sp, #0x20
	add r1, sp, #0x2c
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	add r8, r1, r9
	add r0, r0, r10
	b _0216D420
_0216D3FC:
	mov r1, #0x1a000
	sub r11, r1, #0x44000
	str r1, [sp, #0x1c]
	sub r1, r1, #0x34000
	str r1, [sp, #0x18]
	mov r1, #2
	mov r6, r11
	str r1, [sp, #0x14]
	mov r7, #3
_0216D420:
	sub r1, r10, #0x40000
	cmp r0, r1
	movle r1, #0x14000
	ble _0216D460
	sub r1, r10, #0x18000
	cmp r0, r1
	movge r1, #0x46000
	bge _0216D460
	sub r0, r10, r0
	sub r0, r0, #0x18000
	rsb r1, r0, #0x28000
	mov r0, #0x32
	mul r0, r1, r0
	mov r1, #0x28000
	bl FX_Div
	add r1, r0, #0x14000
_0216D460:
	cmp r9, r8
	blt _0216D488
	sub r0, r9, r8
	cmp r0, r1
	ble _0216D4A8
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	bl ObjRect__FuncNoHit
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216D488:
	sub r0, r8, r9
	cmp r0, r1
	ble _0216D4A8
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	bl ObjRect__FuncNoHit
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216D4A8:
	ldr r1, [r4, #0x28]
	mov r0, r4
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x340]
	ldr r1, =bounceForce
	ldrh r2, [r3, #2]
	ldr r0, =0x021894DC
	ldrsb r3, [r3, #6]
	sub r8, r2, #0xa2
	add r2, r1, r8, lsl #4
	add r1, r0, r8, lsl #4
	ldr r0, [sp, #0x10]
	ldr r8, [r2, r0, lsl #3]
	ldr r2, [r1, r0, lsl #3]
	cmp r8, #0
	addge r1, r8, r3, lsl #11
	sublt r1, r8, r3, lsl #11
	cmp r2, #0
	addge r2, r2, r3, lsl #11
	sublt r2, r2, r3, lsl #11
	mov r0, r5
	bl Player__Action_SpringCrystal
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldr r0, [sp, #0x14]
	str r6, [sp]
	str r0, [sp, #4]
	ldr r3, [sp, #0x1c]
	mov r0, r4
	mov r1, #0x10
	mov r2, #2
	bl EffectTruckSparkles__Create
	str r11, [sp]
	ldr r3, [sp, #0x18]
	mov r0, r4
	mov r1, #0x10
	mov r2, #2
	str r7, [sp, #4]
	bl EffectTruckSparkles__Create
	ldr r1, =SpringCrystal_State_Activated
	mov r0, #0
	str r1, [r4, #0xf4]
	mov r1, #0x5d
	mov r2, r0
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	mov r0, #0
	str r0, [sp]
	mov r1, #0x5d
	str r1, [sp, #4]
	sub r1, r1, #0x5e
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
