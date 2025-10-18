#include <stage/objects/jumpbox.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED const char *aActAcGmkJumpbo;
NOT_DECOMPILED const char *aDfGmkJumpBoxDf;

// --------------------
// ENUMS
// --------------------

enum JumpBoxAnimID
{
    JUMPBOX_ANI_STAND,
    JUMPBOX_ANI_STAND_ACTIVE,
    JUMPBOX_ANI_TOP_SONIC,
    JUMPBOX_ANI_TOP_BLAZE,
};

enum PlaneSwitchSpringAnimID
{
    PLANESWITCHSPRING_ANI_NEAR_IDLE,
    PLANESWITCHSPRING_ANI_NEAR_ACTIVE,
    PLANESWITCHSPRING_ANI_NEAR_BASE,
    PLANESWITCHSPRING_ANI_FAR_IDLE,
    PLANESWITCHSPRING_ANI_FAR_ACTIVE,
    PLANESWITCHSPRING_ANI_FAR_BASE,
};

enum JumpBoxObjectFlags
{
    JUMPBOX_OBJFLAG_NONE,

    JUMPBOX_OBJFLAG_FOR_BLAZE    = 1 << 0, // determines if the box favours sonic or blaze
    JUMPBOX_OBJFLAG_FLAT_ON_LEFT = 1 << 1, // determines if left or right collision is flat
};

// --------------------
// FUNCTION DECLS
// --------------------

static void JumpBox_Destructor(Task *task);
static void JumpBox_State_Cooldown(JumpBox *work);
static void JumpBox_State_Activated(JumpBox *work);
static void JumpBox_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void JumpBox_Draw(void);

static void PlaneSwitchSpring_Destructor(Task *task);
static void PlaneSwitchSpring_State_Active(PlaneSwitchSpring *work);
static void PlaneSwitchSpring_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void PlaneSwitchSpring_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

JumpBox *CreateJumpBox(MapObject *mapObject, fx32 x, fx32 y, fx32 z)
{
    Task *task;
    JumpBox *work;
    AnimatorSpriteDS *ani;
    s32 id;
    s32 anim;
    s16 left;
    s16 right;

    task = CreateStageTask(JumpBox_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), JumpBox);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, JumpBox);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    id = mapObject->flags & JUMPBOX_OBJFLAG_FOR_BLAZE;
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_jumpbox.bac", GetObjectFileWork(OBJDATAWORK_89), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 5, GetObjectFileWork(OBJDATAWORK_90 + 2 * id));

    anim = JUMPBOX_ANI_TOP_SONIC + id;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, 8);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    ani = &work->aniJumpBox;
    ObjAction2dBACLoad(ani, "/act/ac_gmk_jumpbox.bac", 16, GetObjectFileWork(OBJDATAWORK_89), gameArchiveStage);
    ani->work.cParam.palette      = ObjDrawAllocSpritePalette(work->gameWork.animator.fileWork->fileData, 0, 3);
    ani->cParam[0].palette = ani->cParam[1].palette = ani->work.cParam.palette;
    ani->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    AnimatorSpriteDS__SetAnimation(ani, JUMPBOX_ANI_STAND);
    StageTask__SetOAMOrder(&ani->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&ani->work, SPRITE_PRIORITY_2);

    left  = -36;
    right = 36;
    if (mapObject->id == MAPOBJECT_240)
    {
        if ((mapObject->flags & JUMPBOX_OBJFLAG_FLAT_ON_LEFT) != 0)
            left = 0;
        else
            right = 0;
    }
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, left, -16, right, 0);
    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], JumpBox_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_jumpbox.df", GetObjectFileWork(OBJDATAWORK_94), gameArchiveStage);
    work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.width  = 64;
    work->gameWork.collisionObject.work.height = 64;
    work->gameWork.collisionObject.work.ofst_x = -32;
    work->gameWork.collisionObject.work.ofst_y = -64;

    SetTaskOutFunc(&work->gameWork.objWork, JumpBox_Draw);
    return work;
}

PlaneSwitchSpring *CreatePlaneSwitchSpring(MapObject *mapObject, fx32 x, fx32 y, fx32 z)
{
    Task *task = CreateStageTask(PlaneSwitchSpring_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PlaneSwitchSpring);
    if (task == HeapNull)
        return NULL;

    PlaneSwitchSpring *work = TaskGetWork(task, PlaneSwitchSpring);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    u16 anim1;
    u16 anim2;
    u8 order1;
    u8 order2;
    u8 priority;
    if (mapObject->id >= MAPOBJECT_244)
    {
        work->gameWork.objWork.position.z = FLOAT_TO_FX32(50.0);
        work->gameWork.objWork.userWork   = PLANESWITCHSPRING_ANI_NEAR_IDLE;

        anim1    = PLANESWITCHSPRING_ANI_NEAR_IDLE;
        anim2    = PLANESWITCHSPRING_ANI_NEAR_BASE;
        order1   = SPRITE_ORDER_23;
        order2   = SPRITE_ORDER_22;
        priority = SPRITE_PRIORITY_0;
    }
    else
    {
        work->gameWork.objWork.position.z = -FLOAT_TO_FX32(80.0);
        work->gameWork.objWork.userWork   = PLANESWITCHSPRING_ANI_FAR_IDLE;

        anim1    = PLANESWITCHSPRING_ANI_FAR_IDLE;
        anim2    = PLANESWITCHSPRING_ANI_FAR_BASE;
        order1   = SPRITE_ORDER_22;
        order2   = SPRITE_ORDER_23;
        priority = SPRITE_PRIORITY_2;
    }

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_spring_st6.bac", GetObjectFileWork(OBJDATAWORK_177), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, PLANESWITCHSPRING_ANI_NEAR_IDLE, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, order1);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, priority);
    StageTask__SetAnimation(&work->gameWork.objWork, anim1);

    AnimatorSpriteDS *ani = &work->aniSpring;
    ObjAction2dBACLoad(ani, "/act/ac_gmk_spring_st6.bac", OBJ_DATA_GFX_AUTO, GetObjectFileWork(OBJDATAWORK_177), gameArchiveStage);
    ani->cParam[0].palette = ani->cParam[1].palette = ani->work.cParam.palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;

    ani->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(&work->aniSpring, anim2);
    StageTask__SetOAMOrder(&ani->work, order2);
    StageTask__SetOAMPriority(&ani->work, priority);
    SetTaskOutFunc(&work->gameWork.objWork, PlaneSwitchSpring_Draw);
    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = PlaneSwitchSpring_OnDefend;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    return work;
}

void JumpBox_Destructor(Task *task)
{
    JumpBox *work = TaskGetWork(task, JumpBox);

    ObjDrawReleaseSpritePalette(work->aniJumpBox.work.cParam.palette);
    ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_89), &work->aniJumpBox);
    GameObject__Destructor(task);
}

void JumpBox_State_Cooldown(JumpBox *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer <= 0)
    {
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;
        work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void JumpBox_State_Activated(JumpBox *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if ((JumpBox *)player->gimmickObj != work)
    {
        AnimatorSpriteDS__SetAnimation(&work->aniJumpBox, JUMPBOX_ANI_STAND);
        SetTaskState(&work->gameWork.objWork, JumpBox_State_Cooldown);
        work->gameWork.objWork.userTimer = 30;
    }
    else
    {
        if (player->objWork.userWork == JUMPBOX_STATE_VAULTING)
        {
            if (work->aniJumpBox.work.animID != JUMPBOX_ANI_STAND_ACTIVE)
                AnimatorSpriteDS__SetAnimation(&work->aniJumpBox, JUMPBOX_ANI_STAND_ACTIVE);
        }
        else if (player->objWork.userWork >= JUMPBOX_STATE_VAULTED)
        {
            AnimatorSpriteDS__SetAnimation(&work->aniJumpBox, JUMPBOX_ANI_STAND);
            SetTaskState(&work->gameWork.objWork, JumpBox_State_Cooldown);
            work->gameWork.objWork.userTimer = 30;
        }
    }
}

void JumpBox_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    JumpBox *jumpbox = (JumpBox *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (jumpbox == NULL || player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((JumpBox *)player->objWork.rideObj == jumpbox || (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0
        || (player->objWork.position.x <= jumpbox->gameWork.objWork.position.x && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        || (player->objWork.position.x > jumpbox->gameWork.objWork.position.x && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
    {
        ObjRect__FuncNoHit(rect1, rect2);
        return;
    }

    Player__Gimmick_JumpBox(player, &jumpbox->gameWork, jumpbox->gameWork.mapObject->flags & JUMPBOX_OBJFLAG_FOR_BLAZE);
    jumpbox->gameWork.collisionObject.work.parent = NULL;
    SetTaskState(&jumpbox->gameWork.objWork, JumpBox_State_Activated);
    jumpbox->gameWork.parent = &player->objWork;
}

void JumpBox_Draw(void)
{
    JumpBox *work = TaskGetWorkCurrent(JumpBox);

    u32 displayFlag = work->gameWork.objWork.displayFlag;

    // Draw base (left)
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__Draw2D(&work->gameWork.objWork, &work->aniJumpBox);

    // Draw base (right)
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE | DISPLAY_FLAG_FLIP_X;
    StageTask__Draw2D(&work->gameWork.objWork, &work->aniJumpBox);

    // Draw top (left)
    work->gameWork.objWork.displayFlag = displayFlag;
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    // Draw top (right)
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE | DISPLAY_FLAG_FLIP_X;
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    work->gameWork.objWork.displayFlag = displayFlag;
}

void PlaneSwitchSpring_Destructor(Task *task)
{
    PlaneSwitchSpring *work = TaskGetWork(task, PlaneSwitchSpring);

    ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_177), &work->aniSpring);
    GameObject__Destructor(task);
}

void PlaneSwitchSpring_State_Active(PlaneSwitchSpring *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;
        StageTask__SetAnimation(&work->gameWork.objWork, work->gameWork.objWork.userWork);

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

NONMATCH_FUNC void PlaneSwitchSpring_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // https://decomp.me/scratch/F4JY2 -> 95.11%
    // issues near 'velY' variable
#ifdef NON_MATCHING
    PlaneSwitchSpring *planeSwitchSpring = (PlaneSwitchSpring *)rect2->parent;
    Player *player                       = (Player *)rect1->parent;

    if (planeSwitchSpring == NULL || player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    StageTask__SetAnimation(&planeSwitchSpring->gameWork.objWork, PLANESWITCHSPRING_ANI_NEAR_ACTIVE + planeSwitchSpring->gameWork.objWork.userWork);
    SetTaskState(&planeSwitchSpring->gameWork.objWork, PlaneSwitchSpring_State_Active);

    fx32 power = MTM_MATH_CLIP(planeSwitchSpring->gameWork.mapObject->left, 0, 5);
    fx32 force = FLOAT_TO_FX32(7.5);
    force += FLOAT_TO_FX32(1.5) * power;

    fx32 velX = (0xB5 * force) >> 8;
    fx32 velY = (0xB5 * -force) >> 8;

    if (planeSwitchSpring->gameWork.mapObject->id == MAPOBJECT_243 || planeSwitchSpring->gameWork.mapObject->id == MAPOBJECT_245)
        velX = -velX;

    Player__Action_PlaneSwitchSpring(player, velX, velY);
    Player__Action_AllowTrickCombos(player, &planeSwitchSpring->gameWork);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x28]
	mov r0, r4
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, =PlaneSwitchSpring_State_Active
	str r0, [r4, #0xf4]
	ldr ip, [r4, #0x340]
	ldrsb r3, [ip, #6]
	cmp r3, #0
	movlt r3, #0
	blt _0217F3E4
	cmp r3, #5
	movgt r3, #5
_0217F3E4:
	mov r1, #0x7800
	mov r0, #0x1800
	mla r2, r3, r0, r1
	mov r0, #0xb5
	mul r1, r2, r0
	rsb r3, r2, #0
	mul r2, r3, r0
	ldrh r0, [ip, #2]
	mov r1, r1, asr #8
	mov r2, r2, asr #8
	cmp r0, #0xf3
	cmpne r0, #0xf5
	rsbeq r1, r1, #0
	mov r0, r5
	bl Player__Action_PlaneSwitchSpring
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}
// clang-format on
#endif
}

void PlaneSwitchSpring_Draw(void)
{
    PlaneSwitchSpring *work = TaskGetWorkCurrent(PlaneSwitchSpring);

    StageTask__Draw(&work->gameWork.objWork);

    u32 displayFlag = work->gameWork.objWork.displayFlag;
    StageTask__Draw2D(&work->gameWork.objWork, &work->aniSpring);

    work->gameWork.objWork.displayFlag = displayFlag;
}
