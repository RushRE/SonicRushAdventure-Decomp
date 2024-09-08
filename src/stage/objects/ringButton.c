#include <stage/objects/ringButton.h>
#include <stage/objects/ringButtonSfxManager.h>
#include <stage/core/ringBattleManager.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>

// --------------------
// CONSTANTS
// --------------------

#define RINGBUTTON_DURATION SECONDS_TO_FRAMES(17.0)

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_width  mapObject->width
#define mapObjectParam_height mapObject->height

// --------------------
// ENUMS
// --------------------

enum RingButtonObjectFlags
{
    RINGBUTTON_OBJFLAG_FLIPPED  = 1 << 0,
    RINGBUTTON_OBJFLAG_2        = 1 << 1,
    RINGBUTTON_OBJFLAG_PLAY_SFX = 1 << 2,
};

enum RingButtonFlags
{
    RINGBUTTON_FLAG_1 = 1 << 0,
    RINGBUTTON_FLAG_MOVE_BACK = 1 << 1,
    RINGBUTTON_FLAG_MOVE_FORWARD = 1 << 2,
    RINGBUTTON_FLAG_ACTIVATED = 1 << 3,
};

enum RingButtonAnimID
{
    RINGBUTTON_ANI_BASE_V,
    RINGBUTTON_ANI_BUTTON_V,
    RINGBUTTON_ANI_BASE_H,
    RINGBUTTON_ANI_BUTTON_H,
    RINGBUTTON_ANI_ACTIVATED_PALETTE,
};

// --------------------
// FUNCTIONS
// --------------------

static void RingButton_Destructor(Task *task);
static void RingButton_Action_Init(RingButton *work);
static void RingButton_State_Vertical(RingButton *work);
static void RingButton_State_Horizontal(RingButton *work);
static void RingButton_Draw(void);
static void RingButton_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void UpdateRingButtonPalette(RingButton *work, BOOL activated);

// --------------------
// FUNCTIONS
// --------------------

RingButton *CreateRingButton(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(RingButton_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, RingButton);
    if (task == HeapNull)
        return NULL;

    RingButton *work = TaskGetWork(task, RingButton);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    s32 buttonType = mapObject->id - MAPOBJECT_256;
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_switch.bac", GetObjectFileWork(OBJDATAWORK_106), gameArchiveCommon, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 2, GetObjectFileWork(2 * buttonType + OBJDATAWORK_113));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, RINGBUTTON_ANI_BASE_V, 107);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    AnimatorSpriteDS *aniBase = &work->aniBase;
    ObjAction2dBACLoad(aniBase, "/act/ac_gmk_switch.bac", 0, GetObjectFileWork(OBJDATAWORK_106), gameArchiveCommon);

    aniBase->vramPixels[0]     = (void *)ObjActionAllocSprite((OBS_GFX_REF *)GetObjectFileWork(2 * buttonType + OBJDATAWORK_109), FALSE, 2);
    aniBase->vramPixels[1]     = (void *)ObjActionAllocSprite((OBS_GFX_REF *)GetObjectFileWork(2 * buttonType + OBJDATAWORK_110), TRUE, 2);
    aniBase->work.palette      = work->gameWork.objWork.obj_2d->ani.work.palette;
    aniBase->cParam[0].palette = aniBase->cParam[1].palette = aniBase->work.palette;

    aniBase->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    StageTask__SetOAMOrder(&aniBase->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniBase->work, SPRITE_PRIORITY_2);
    if (mapObject->id == MAPOBJECT_256)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, RINGBUTTON_ANI_BUTTON_V);
        AnimatorSpriteDS__SetAnimation(&work->aniBase, RINGBUTTON_ANI_BASE_V);

        if ((mapObject->flags & RINGBUTTON_OBJFLAG_FLIPPED) != 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

        ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_switch.df", GetObjectFileWork(OBJDATAWORK_107), gameArchiveCommon);
        work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
        work->gameWork.collisionObject.work.width  = 32;
        work->gameWork.collisionObject.work.height = 16;
        work->gameWork.collisionObject.work.ofst_x = -16;
        work->gameWork.collisionObject.work.ofst_y = -16;
    }
    else
    {
        StageTask__SetAnimation(&work->gameWork.objWork, RINGBUTTON_ANI_BUTTON_H);
        AnimatorSpriteDS__SetAnimation(&work->aniBase, RINGBUTTON_ANI_BASE_H);

        if ((mapObject->flags & RINGBUTTON_OBJFLAG_FLIPPED) != 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

        ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_switch_tate.df", GetObjectFileWork(OBJDATAWORK_108), gameArchiveCommon);
        work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
        work->gameWork.collisionObject.work.width  = 16;
        work->gameWork.collisionObject.work.height = 32;
        work->gameWork.collisionObject.work.ofst_x = -16;
        work->gameWork.collisionObject.work.ofst_y = -16;
    }

    work->buttonPos = work->gameWork.objWork.position;
    RingButton_Action_Init(work);

    if (gmCheckRingBattle())
    {
        AddButtonToRingBattleManager(work);
        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], RingButton_OnDefend);
        work->gameWork.objWork.flag |= OBS_RECT_WORK_FLAG_10 | OBS_RECT_WORK_FLAG_FLIP_Y;
        work->onActivated = RingBattleManager_OnButtonActivated;
    }

    return work;
}

void RingButton_Destructor(Task *task)
{
    RingButton *work = TaskGetWork(task, RingButton);

    s32 buttonType = work->gameWork.mapObject->id - MAPOBJECT_256;
    ObjActionReleaseSprite((OBS_GFX_REF *)GetObjectFileWork(2 * buttonType + OBJDATAWORK_109), FALSE);
    ObjActionReleaseSprite((OBS_GFX_REF *)GetObjectFileWork(2 * buttonType + OBJDATAWORK_110), TRUE);
    work->aniBase.vramPixels[0] = NULL;
    work->aniBase.vramPixels[1] = NULL;

    ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_106), &work->aniBase);

    if (gmCheckRingBattle())
        RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] = 0;

    GameObject__Destructor(task);
}

void RingButton_Action_Init(RingButton *work)
{
    if (gmCheckRingBattle())
    {
        if (work->gameWork.mapObject->id == MAPOBJECT_256)
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                work->gameWork.objWork.position.y -= FLOAT_TO_FX32(2.0);
            else
                work->gameWork.objWork.position.y += FLOAT_TO_FX32(2.0);
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->gameWork.objWork.position.x -= FLOAT_TO_FX32(2.0);
            else
                work->gameWork.objWork.position.x += FLOAT_TO_FX32(2.0);
        }

        RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] = RINGBUTTON_DURATION;
        UpdateRingButtonPalette(work, TRUE);
    }
    else
    {
        if (RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id])
        {
            if (work->gameWork.mapObject->id == MAPOBJECT_256)
            {
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                    work->gameWork.objWork.position.y -= FLOAT_TO_FX32(2.0);
                else
                    work->gameWork.objWork.position.y += FLOAT_TO_FX32(2.0);
            }
            else
            {
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->gameWork.objWork.position.x -= FLOAT_TO_FX32(2.0);
                else
                    work->gameWork.objWork.position.x += FLOAT_TO_FX32(2.0);
            }

            UpdateRingButtonPalette(work, TRUE);
        }
    }

    SetTaskOutFunc(&work->gameWork.objWork, RingButton_Draw);

    if (work->gameWork.mapObject->id == MAPOBJECT_256)
        SetTaskState(&work->gameWork.objWork, RingButton_State_Vertical);
    else
        SetTaskState(&work->gameWork.objWork, RingButton_State_Horizontal);
}

void RingButton_State_Vertical(RingButton *work)
{
    StageTaskCollisionWork *collisionObj = &work->gameWork.objWork.collisionObj[0];

    BOOL activated                    = FALSE;
    work->gameWork.objWork.velocity.y = 0;

    StageTask *toucherObj = collisionObj->work.toucherObj;
    if (toucherObj != NULL && toucherObj->objType == STAGE_OBJ_TYPE_PLAYER
        && (collisionObj->work.riderObj == toucherObj
            || (toucherObj->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING) != 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0))
    {
        if (MATH_ABS(FX32_TO_WHOLE(work->gameWork.objWork.position.x) - (toucherObj->hitboxRect.left + FX32_TO_WHOLE(toucherObj->position.x))) < 14
            || MATH_ABS(FX32_TO_WHOLE(work->gameWork.objWork.position.x) - (toucherObj->hitboxRect.right + FX32_TO_WHOLE(toucherObj->position.x))) < 14)
        {
            if (RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] == 0)
            {
                if (work->onActivated != NULL)
                    work->onActivated(work);
            }

            if (!gmCheckRingBattle())
            {
                if (!RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id])
                {
                    RingButtonSfxManager__Create(work->gameWork.RingButton_mapObjectParam_id, work->gameWork.mapObject->flags & RINGBUTTON_OBJFLAG_PLAY_SFX);
                    UpdateRingButtonPalette(work, TRUE);
                }
                RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] = 2 * (work->gameWork.mapObjectParam_width + work->gameWork.mapObjectParam_height);
            }
            else
            {
                if (!RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id])
                {
                    GameObject__SendPacket(&work->gameWork, (Player *)toucherObj, GAMEOBJECT_PACKET_OBJ_COLLISION);
                    UpdateRingButtonPalette(work, TRUE);
                }
                RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] = RINGBUTTON_DURATION;
            }
            activated = TRUE;

            work->gameWork.flags |= RINGBUTTON_FLAG_MOVE_BACK;
            work->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_FORWARD;
        }
    }

    if ((work->gameWork.flags & RINGBUTTON_FLAG_MOVE_FORWARD) != 0)
    {
        if (MATH_ABS(work->gameWork.objWork.position.y - work->buttonPos.y) <= FLOAT_TO_FX32(2.0))
        {
            work->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_FORWARD;
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(1.0);
            else
                work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(1.0);
        }
    }
    else if ((work->gameWork.flags & RINGBUTTON_FLAG_MOVE_BACK) != 0)
    {
        if (MATH_ABS(work->gameWork.objWork.position.y - work->buttonPos.y) >= FLOAT_TO_FX32(4.0))
        {
            work->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_BACK;
            work->gameWork.flags |= RINGBUTTON_FLAG_MOVE_FORWARD;
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.5);
            else
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.5);
        }
    }

    if (!activated && RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] == 0)
    {
        fx32 distance = MATH_ABS(work->gameWork.objWork.position.y - work->buttonPos.y);
        fx32 move     = 0;

        if (distance != 0)
        {
            work->gameWork.flags &= ~(RINGBUTTON_FLAG_MOVE_BACK | RINGBUTTON_FLAG_MOVE_FORWARD);
            move                              = ObjShiftSet(distance, 0, 2, FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(0.5));
            work->gameWork.objWork.velocity.y = distance - move;
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) == 0)
                work->gameWork.objWork.velocity.y = -work->gameWork.objWork.velocity.y;
        }

        if (move == 0)
            UpdateRingButtonPalette(work, FALSE);
    }
}

void RingButton_State_Horizontal(RingButton *work)
{
    StageTaskCollisionWork *collisionObj = &work->gameWork.objWork.collisionObj[0];

    BOOL activated                    = FALSE;
    work->gameWork.objWork.velocity.x = 0;

    StageTask *toucherObj = collisionObj->work.toucherObj;
    if (toucherObj != NULL &&                                                // check that it's not null
        toucherObj->objType == STAGE_OBJ_TYPE_PLAYER &&                      // check that we're colliding with a player
        collisionObj->work.riderObj != toucherObj &&                         // check the touching object isn't riding
        (toucherObj->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0 && // check the toucher is touching the wall on the left
        ((toucherObj->displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0
         || (toucherObj->displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0))
    {
        if (RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] == 0)
        {
            if (work->onActivated != NULL)
                work->onActivated(work);
        }

        if (!gmCheckRingBattle())
        {
            if (!RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id])
            {
                RingButtonSfxManager__Create(work->gameWork.RingButton_mapObjectParam_id, work->gameWork.mapObject->flags & RINGBUTTON_OBJFLAG_PLAY_SFX);
                UpdateRingButtonPalette(work, TRUE);
            }
            RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] = 2 * (work->gameWork.mapObjectParam_width + work->gameWork.mapObjectParam_height);
        }
        else
        {
            if (!RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id])
            {
                GameObject__SendPacket(&work->gameWork, (Player *)toucherObj, GAMEOBJECT_PACKET_OBJ_COLLISION);
                UpdateRingButtonPalette(work, TRUE);
            }
            RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] = RINGBUTTON_DURATION;
        }
        activated = TRUE;

        work->gameWork.flags |= RINGBUTTON_FLAG_MOVE_BACK;
        work->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_FORWARD;
    }

    if ((work->gameWork.flags & RINGBUTTON_FLAG_MOVE_FORWARD) != 0)
    {
        if (MATH_ABS(work->gameWork.objWork.position.x - work->buttonPos.x) <= FLOAT_TO_FX32(2.0))
        {
            work->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_FORWARD;
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(1.0);
            else
                work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(1.0);
        }
    }
    else if ((work->gameWork.flags & RINGBUTTON_FLAG_MOVE_BACK) != 0)
    {
        if (MATH_ABS(work->gameWork.objWork.position.x - work->buttonPos.x) >= FLOAT_TO_FX32(4.0))
        {
            work->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_BACK;
            work->gameWork.flags |= RINGBUTTON_FLAG_MOVE_FORWARD;
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(0.5);
            else
                work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.5);
        }
    }

    if (!activated && RingButtonSfxManager__timerTable[work->gameWork.RingButton_mapObjectParam_id] == 0)
    {
        fx32 distance = MATH_ABS(work->gameWork.objWork.position.x - work->buttonPos.x);
        fx32 move     = 0;

        if (distance != 0)
        {
            work->gameWork.flags &= ~(RINGBUTTON_FLAG_MOVE_BACK | RINGBUTTON_FLAG_MOVE_FORWARD);
            move                              = ObjShiftSet(distance, 0, 2, FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(0.5));
            work->gameWork.objWork.velocity.x = distance - move;
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                work->gameWork.objWork.velocity.x = -work->gameWork.objWork.velocity.x;
        }

        if (move == 0)
            UpdateRingButtonPalette(work, FALSE);
    }
}

void RingButton_Draw(void)
{
    RingButton *work = TaskGetWorkCurrent(RingButton);

    u32 displayFlag = work->gameWork.objWork.displayFlag;

    VecFx32 position;
    position.x = work->buttonPos.x;
    position.y = work->buttonPos.y;
    position.z = 0;

    StageTask__Draw2DEx(&work->aniBase, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
}

void RingButton_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    RingButton *button = (RingButton *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    if (button == NULL || player == NULL)
        return;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && gmCheckRingBattle())
    {
        button->onActivated(button);
        RingButtonSfxManager__timerTable[button->gameWork.RingButton_mapObjectParam_id] = RINGBUTTON_DURATION;
        UpdateRingButtonPalette(button, TRUE);
        button->gameWork.flags |= RINGBUTTON_FLAG_MOVE_BACK;
        button->gameWork.flags &= ~RINGBUTTON_FLAG_MOVE_FORWARD;
    }
}

void UpdateRingButtonPalette(RingButton *work, BOOL activated)
{
    if ((!activated || (work->gameWork.flags & RINGBUTTON_FLAG_ACTIVATED) == 0) && (activated || (work->gameWork.flags & RINGBUTTON_FLAG_ACTIVATED) != 0))
    {
        ObjActionReleaseSpritePalette(&work->gameWork.objWork);

        if (activated)
        {
            ObjActionAllocSpritePalette(&work->gameWork.objWork, RINGBUTTON_ANI_ACTIVATED_PALETTE, 109);
            work->gameWork.flags |= RINGBUTTON_FLAG_ACTIVATED;
        }
        else
        {
            ObjActionAllocSpritePalette(&work->gameWork.objWork, RINGBUTTON_ANI_BASE_V, 107);
            work->gameWork.flags &= ~RINGBUTTON_FLAG_ACTIVATED;
        }

        AnimatorSpriteDS *aniBase  = &work->aniBase;
        aniBase->work.palette      = work->gameWork.objWork.obj_2d->ani.work.palette;
        aniBase->cParam[0].palette = aniBase->cParam[1].palette = aniBase->work.palette;
    }
}
