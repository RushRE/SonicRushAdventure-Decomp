#include <stage/stageTask.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/system/allocator.h>
#include <game/object/objCollision.h>
#include <game/object/objBlock.h>
#include <game/object/objDraw.h>
#include <game/object/obj.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/spritePaletteAnimation.h>

// --------------------
// FUNCTION DECLS
// --------------------

void ObjectManager_Main(void);
void ObjectManager_Destructor(Task *task);

// --------------------
// VARIABLES
// --------------------

static Task *obj_ptcb;
struct ObjectManager g_obj;

s8 const StageTask__shakeOffsetTable[] = { 1, 1, -1, -1, 2, 2, -2, -2, 4, 4, -4, -4, -4, 4, 4, -4 };

// --------------------
// FUNCTIONS
// --------------------

void CreateObjectManager(void)
{
    MI_CpuClear8(&g_obj, sizeof(g_obj));

    ObjDispSRand(0);
    g_obj.speed           = FLOAT_TO_FX32(1.0);
    g_obj.scale.x         = FLOAT_TO_FX32(1.0);
    g_obj.scale.y         = FLOAT_TO_FX32(1.0);
    g_obj.scale.z         = FLOAT_TO_FX32(1.0);
    g_obj.depth           = FLOAT_TO_FX32(1.0);
    g_obj.col_through_dot = 5;

    ObjRect__CheckInit();
    ObjCollisionObjectClear();
    ObjCollisionObjectClear();
    ObjDrawInit();

    if (obj_ptcb == NULL)
        obj_ptcb =
            TaskCreateNoWork(ObjectManager_Main, ObjectManager_Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_END - 2, TASK_GROUP(5), "ObjectManager");
}

void ObjectManager_Main(void)
{
    if ((g_obj.flag & OBJECTMANAGER_FLAG_ALLOW_RECT_COLLISIONS) != 0)
        ObjRect__CheckAllGroup();

    ObjCollisionObjectClear();

    g_obj.timer_fx += StageTask__AdvanceBySpeed(FLOAT_TO_FX32(1.0));
    g_obj.flag |= OBJECTMANAGER_FLAG_TIMER_CHANGED;

    if (g_obj.timer == FX32_TO_WHOLE(g_obj.timer_fx))
        g_obj.flag &= ~OBJECTMANAGER_FLAG_TIMER_CHANGED;

    g_obj.timer = FX32_TO_WHOLE(g_obj.timer_fx);

    if ((g_obj.flag & OBJECTMANAGER_FLAG_REQUEST_PAUSE) != 0)
        g_obj.flag |= OBJECTMANAGER_FLAG_IS_PAUSED;
    else
        g_obj.flag &= ~OBJECTMANAGER_FLAG_IS_PAUSED;
}

void ObjectManager_Destructor(Task *task)
{
    obj_ptcb = NULL;

    ObjSetBlockCollision(NULL);
    ObjSetDiffCollision(NULL);

    ReleaseObjectFileWork();
}

void EnableObjectManagerFlag2(void)
{
    g_obj.flag |= OBJECTMANAGER_FLAG_REQUEST_PAUSE;
}

void DisableObjectManagerFlag2(void)
{
    g_obj.flag &= ~OBJECTMANAGER_FLAG_REQUEST_PAUSE;
}

BOOL ObjectPauseCheck(u32 flag)
{
    return (g_obj.flag & OBJECTMANAGER_FLAG_IS_PAUSED) != 0 && (flag & STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE) == 0;
}

void AllocObjectFileWork(u32 count)
{
    g_obj.data_max = count;
    g_obj.pData    = HeapAllocHead(HEAP_USER, sizeof(OBS_DATA_WORK) * count);

    MI_CpuClear8(g_obj.pData, sizeof(OBS_DATA_WORK) * count);
}

void *GetObjectFileWork(s32 index)
{
    return g_obj.data_max <= index ? NULL : &g_obj.pData[index];
}

void ReleaseObjectFileWork(void)
{
    g_obj.data_max = 0;

    if (g_obj.pData != NULL)
    {
        HeapFree(HEAP_USER, g_obj.pData);
        g_obj.pData = NULL;
    }
}

void SetObjOffset(s16 x, s16 y)
{
    g_obj.offset.x = x;
    g_obj.offset.y = y;
}

void SetObjSpeed(fx32 speed)
{
    g_obj.speed = speed;
}

fx32 GetObjSpeed(void)
{
    return g_obj.speed;
}

void SetObjCameraPosition(fx32 x1, fx32 y1, fx32 x2, fx32 y2)
{
    g_obj.camera[GRAPHICS_ENGINE_A].x = x1;
    g_obj.camera[GRAPHICS_ENGINE_A].y = y1;

    g_obj.camera[GRAPHICS_ENGINE_B].x = x2;
    g_obj.camera[GRAPHICS_ENGINE_B].y = y2;
}

StageTask *CreateStageTask_(void)
{
    CreateStageTaskEx_(TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1));
}

StageTask *CreateStageTaskEx_(u32 priority, TaskGroup group)
{
    Task *task = TaskCreate(StageTask_Main, StageTask_Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, priority, group, StageTask);
    if (task == HeapNull)
        return NULL;

    StageTask *work = TaskGetWork(task, StageTask);
    TaskInitWork8(work);

    work->taskRef = task;
    work->scale.x = FLOAT_TO_FX32(1.0);
    work->scale.y = FLOAT_TO_FX32(1.0);
    work->scale.z = FLOAT_TO_FX32(1.0);

    work->moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_VRAM_ON_AB) == 0)
    {
        if ((g_obj.flag & OBJECTMANAGER_FLAG_VRAM_ON_B) != 0)
            work->flag |= STAGE_TASK_FLAG_NO_VRAM_A;
        else
            work->flag |= STAGE_TASK_FLAG_NO_VRAM_B;
    }

    SetTaskViewCheckFunc(work, StageTask__ViewCheck_Default);

    if ((g_obj.flag & OBJECTMANAGER_FLAG_DISABLE_VIEWCHECK_BY_DEFAULT) != 0)
        work->flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    return work;
}

void StageTask__SetType(StageTask *work, u16 type)
{
    work->objType = type;
}

void StageTask__SetParent(StageTask *work, StageTask *parent, u16 ulFlag)
{
    work->parentObj = parent;

    work->flag &= ~(STAGE_TASK_FLAG_USE_PARENT_SPRITES | STAGE_TASK_FLAG_IS_CHILD_OBJ | STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT);
    work->flag |= ulFlag & (STAGE_TASK_FLAG_USE_PARENT_SPRITES | STAGE_TASK_FLAG_IS_CHILD_OBJ | STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT);
}

void StageTask__Draw(StageTask *work)
{
    if (work->obj_3d != NULL && work->obj_3d->resources[B3D_RESOURCE_MODEL] != NULL)
        StageTask__Draw3D(work, &work->obj_3d->ani.work);

    if (work->obj_3des != NULL && work->obj_3des->resource != NULL)
        StageTask__Draw3D(work, &work->obj_3des->ani.work);

    if (work->obj_2dIn3d != NULL && work->obj_2dIn3d->fileData != NULL)
        StageTask__Draw3D(work, &work->obj_2dIn3d->ani.work);

    if (work->obj_2d != NULL && work->obj_2d->ani.work.fileData != NULL)
    {
        u32 displayFlag;

        if (work->obj_3d != NULL || work->obj_3des != NULL || work->obj_2dIn3d != NULL)
            displayFlag = work->displayFlag;

        StageTask__Draw2D(work, &work->obj_2d->ani);

        if (work->obj_3d != NULL || work->obj_3des != NULL || work->obj_2dIn3d != NULL)
            work->displayFlag = displayFlag;
    }
}

void StageTask_Main(void)
{
    StageTask *work = TaskGetWorkCurrent(StageTask);

    if (IsStageTaskDestroyed(work))
    {
        DestroyCurrentTask();
        return;
    }

    if (IsStageTaskDestroyQueued(work))
    {
        DestroyStageTask(work);
        return;
    }

    if ((work->flag & STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT) == 0)
    {
        if (work->ppViewCheck != NULL)
        {
            if (work->ppViewCheck(work))
            {
                DestroyStageTask(work);
                return;
            }
        }
    }

    if (!StageTask__ObjectParent(work))
    {
        StageTask__HandleRide(work);
        work->position.x -= work->prevTempOffset.x;
        work->position.y -= work->prevTempOffset.y;
        work->position.z -= work->prevTempOffset.z;

        if (!ObjectPauseCheck(work->flag) || (work->flag & STAGE_TASK_FLAG_ALWAYS_RUN_PPIN) != 0)
        {
            if (work->ppIn != NULL)
                work->ppIn();
        }

        if (!ObjectPauseCheck(work->flag))
        {
            if (work->shakeTimer != 0)
                work->shakeTimer = StageTask__DecrementBySpeed(work->shakeTimer);

            if (work->hitstopTimer != 0)
            {
                work->hitstopTimer = StageTask__DecrementBySpeed(work->hitstopTimer);
                if ((work->flag & STAGE_TASK_FLAG_DISABLE_HITSTOP) != 0)
                    work->hitstopTimer = 0;
            }

            if (!ObjectPauseCheck(work->flag))
            {
                if (((g_obj.flag & OBJECTMANAGER_FLAG_NO_STATE_IN_HITSTOP) == 0 || work->hitstopTimer == 0) && (work->flag & STAGE_TASK_FLAG_DISABLE_STATE) == 0)
                {
                    if (work->state != NULL)
                        work->state(work);
                }

                if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT) == 0)
                {
                    if (work->ppMove != NULL)
                        work->ppMove(work);
                    else
                        StageTask__Move(work);
                }
            }
        }

        if ((g_obj.flag & (OBJECTMANAGER_FLAG_USE_BLOCK_COLLISIONS | OBJECTMANAGER_FLAG_USE_DIFF_COLLISIONS)) != 0
            && (work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0)
        {
            work->rideObj  = NULL;
            work->touchObj = NULL;
            StageTask__ObjectCollision(work);
        }

        work->position.x += work->lockOffset.x;
        work->position.y += work->lockOffset.y;
        work->position.z += work->lockOffset.z;

        work->prevTempOffset.x = work->lockOffset.x;
        work->prevTempOffset.y = work->lockOffset.y;
        work->prevTempOffset.z = work->lockOffset.z;

        if (work->shakeTimer && (work->flag & STAGE_TASK_FLAG_DISABLE_SHAKE) == 0)
        {
            work->offset.x += FX32_FROM_WHOLE(StageTask__shakeOffsetTable[FX32_TO_WHOLE(work->shakeTimer >> 1) & 0xF]);
            work->offset.y += FX32_FROM_WHOLE(StageTask__shakeOffsetTable[(FX32_TO_WHOLE(work->shakeTimer >> 1) + 1) & 0xF]);
        }

        u32 displayFlag;
        if (work->hitstopTimer != 0 || ObjectPauseCheck(work->flag))
        {
            displayFlag = work->displayFlag & DISPLAY_FLAG_PAUSED;
            work->displayFlag |= DISPLAY_FLAG_PAUSED;
        }

        if (!IsStageTaskDestroyed(work))
        {
            if (work->ppOut == NULL || (work->displayFlag & DISPLAY_FLAG_USE_DEFAULT_DRAW) != 0)
                StageTask__Draw(work);

            if (work->ppOut != NULL)
                work->ppOut();
        }

        if (work->hitstopTimer || ObjectPauseCheck(work->flag))
        {
            work->displayFlag &= ~DISPLAY_FLAG_PAUSED;
            work->displayFlag |= displayFlag;
        }

        if (!ObjectPauseCheck(work->flag))
        {
            if ((g_obj.flag & STAGE_TASK_FLAG_ALWAYS_RUN_PPIN) != 0)
            {
                if (work->ppCollide != NULL)
                {
                    work->ppCollide();
                }
                else
                {
                    if (work->collisionObj != NULL && !StageTask__ViewOutCheck(work->position.x, work->position.y, 32, 0, 0, 0, 0))
                        ObjCollisionObjectRegist(&work->collisionObj->work);

                    for (u16 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
                    {
                        if (work->colliderList[c] != NULL)
                            StageTask__HandleCollider(work, work->colliderList[c]);
                    }
                }
            }

            work->flow.x = 0;
            work->flow.y = 0;
            work->flow.z = 0;

            work->prevOffset.x = work->offset.x;
            work->prevOffset.y = work->offset.y;
            work->prevOffset.z = work->offset.z;

            work->offset.x = 0;
            work->offset.y = 0;
            work->offset.z = 0;

            if (work->ppLast != NULL)
                work->ppLast();
        }
    }
}

void StageTask_Destructor(Task *task)
{
    StageTask *work = TaskGetWork(task, StageTask);

    if (work->sequencePlayerPtr != NULL)
        ReleaseStageSfx(work->sequencePlayerPtr);

    if (work->sequencePlayerPtr != NULL)
        FreeSndHandle(work->sequencePlayerPtr);

    ObjObjectActionReleaseGfxRefs(work);

    if (work->obj_2d != NULL)
    {
        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_PALETTE_ANIM_OLD) != 0)
            ReleaseSpritePalette_OLD(work->obj_2d->ani.cParam[0].palette);

        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_SPRITE_PALETTE) != 0)
            ObjDrawReleaseSpritePalette(work->obj_2d->ani.cParam[0].palette + 16);
        else
            ObjDrawReleaseSpritePalette(work->obj_2d->ani.cParam[0].palette);

        if (work->obj_2d->fileWork != NULL)
        {
            ObjDataRelease(work->obj_2d->fileWork);
        }
        else if (work->obj_2d->ani.work.fileData != NULL && (work->flag & STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE) == 0)
        {
            HeapFree(HEAP_USER, work->obj_2d->ani.work.fileData);
        }
    }

    if (work->obj_3d != NULL)
    {
        Animator3D__Release(&work->obj_3d->ani.work);

        if (work->obj_3d->file[B3D_RESOURCE_MODEL] != NULL)
        {
            if (work->obj_3d->file[B3D_RESOURCE_MODEL]->referenceCount == 1)
                NNS_G3dResDefaultRelease(work->obj_3d->resources[B3D_RESOURCE_MODEL]);

            ObjDataRelease(work->obj_3d->file[B3D_RESOURCE_MODEL]);
            work->obj_3d->resources[B3D_RESOURCE_MODEL] = NULL;
        }
        else if (work->obj_3d->resources[B3D_RESOURCE_MODEL] != NULL && (work->obj_3d->flags & (1 << B3D_RESOURCE_MODEL)) == 0)
        {
            NNS_G3dResDefaultRelease(work->obj_3d->resources[B3D_RESOURCE_MODEL]);
            HeapFree(HEAP_USER, work->obj_3d->resources[B3D_RESOURCE_MODEL]);
            work->obj_3d->resources[B3D_RESOURCE_MODEL] = NULL;
        }

        for (u16 i = 0; i < B3D_ANIM_MAX; i++)
        {
            if (work->obj_3d->file[B3D_ANIM_RESOURCE_OFFSET + i] != NULL)
            {
                if (work->obj_3d->file[B3D_ANIM_RESOURCE_OFFSET + i]->referenceCount == 1)
                    NNS_G3dResDefaultRelease(work->obj_3d->file[B3D_ANIM_RESOURCE_OFFSET + i]);

                ObjDataRelease(work->obj_3d->file[B3D_ANIM_RESOURCE_OFFSET + i]);
                work->obj_3d->resources[B3D_ANIM_RESOURCE_OFFSET + i] = NULL;
            }
            else if (work->obj_3d->resources[B3D_ANIM_RESOURCE_OFFSET + i] != NULL && (work->obj_3d->flags & ((B3D_ANIM_RESOURCE_OFFSET + 1) << i)) == 0)
            {
                NNS_G3dResDefaultRelease(work->obj_3d->file[B3D_ANIM_RESOURCE_OFFSET + i]);
                HeapFree(HEAP_USER, work->obj_3d->resources[B3D_ANIM_RESOURCE_OFFSET + i]);
                work->obj_3d->resources[B3D_ANIM_RESOURCE_OFFSET + i] = NULL;
            }
        }
    }

    for (OBS_ACTION3D_SIMPLE_WORK *esWork = work->obj_3des; esWork != NULL; esWork = esWork->next)
    {
        Animator3D__Release(&esWork->ani.work);

        if (esWork->fileWork != NULL)
        {
            if (esWork->fileWork->referenceCount == 1)
                NNS_G3dResDefaultRelease(esWork->resource);

            ObjDataRelease(esWork->fileWork);
            esWork->resource = NULL;
        }
        else if (esWork->resource != NULL && (esWork->flags & 1) == 0)
        {
            NNS_G3dResDefaultRelease(esWork->resource);
            HeapFree(HEAP_USER, esWork->resource);
            esWork->resource = NULL;
        }
    }

    if (work->obj_2dIn3d != NULL)
    {
        if (work->obj_2dIn3d->fileWork != NULL)
        {
            ObjDataRelease(work->obj_2dIn3d->fileWork);
            work->obj_2dIn3d->fileData = NULL;
        }
        else if (work->obj_2dIn3d->fileData != NULL && (work->obj_2dIn3d->flags & 1) == 0)
        {
            HeapFree(HEAP_USER, work->obj_2dIn3d->fileData);
            work->obj_2dIn3d->fileData = NULL;
        }
    }

    if (work->collisionObj != NULL)
    {
        if (work->collisionObj->diff_data_work != NULL)
        {
            ObjDataRelease(work->collisionObj->diff_data_work);
        }
        else if (work->collisionObj->work.diff_data != NULL)
        {
            HeapFree(HEAP_USER, work->collisionObj->work.diff_data);
        }

        if (work->collisionObj->dir_data_work != NULL)
        {
            ObjDataRelease(work->collisionObj->dir_data_work);
        }
        else if (work->collisionObj->work.dir_data != NULL)
        {
            HeapFree(HEAP_USER, work->collisionObj->work.dir_data);
        }

        if (work->collisionObj->attr_data_work != NULL)
        {
            ObjDataRelease(work->collisionObj->attr_data_work);
        }
        else if (work->collisionObj->work.attr_data != NULL)
        {
            HeapFree(HEAP_USER, work->collisionObj->work.attr_data);
        }
    }

    if ((work->flag
         & (STAGE_TASK_FLAG_ALLOCATED_OBJ_2DIN3D | STAGE_TASK_FLAG_ALLOCATED_OBJ_3DES | STAGE_TASK_FLAG_ALLOCATED_OBJ_3D | STAGE_TASK_FLAG_ALLOCATED_OBJ_2D
            | STAGE_TASK_FLAG_ALLOCATED_COLLIDERS | STAGE_TASK_FLAG_ALLOCATED_COLLISION_OBJ))
        != 0)
    {
        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_OBJ_2D) != 0 && work->obj_2d != NULL)
            HeapFree(HEAP_USER, work->obj_2d);

        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_OBJ_3D) != 0 && work->obj_3d != NULL)
            HeapFree(HEAP_USER, work->obj_3d);

        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_OBJ_3DES) != 0 && work->obj_3des != NULL)
            HeapFree(HEAP_USER, work->obj_3des);

        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_OBJ_2DIN3D) != 0 && work->obj_2dIn3d != NULL)
            HeapFree(HEAP_USER, work->obj_2dIn3d);

        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_COLLISION_OBJ) != 0 && work->collisionObj != NULL)
            HeapFree(HEAP_USER, work->collisionObj);

        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_COLLIDERS) != 0)
        {
            for (u16 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
            {
                if (work->colliderList[c] != NULL)
                    HeapFree(HEAP_USER, work->colliderList[c]);
            }
        }
    }

    if (work->taskWorker != NULL && (work->flag & STAGE_TASK_FLAG_ALLOCATED_TASK_WORKER) != 0)
        HeapFree(HEAP_USER, work->taskWorker);

    if (work->tbl_work != NULL)
    {
        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_TBL_WORK) != 0)
        {
            ObjTblWorkReset(work->tbl_work);
            HeapFree(HEAP_USER, work->tbl_work);
        }
    }
}

BOOL StageTask__ObjectParent(StageTask *work)
{
    StageTask *parent = work->parentObj;
    if (parent != NULL)
    {
        if (IsStageTaskDestroyed(parent))
        {
            if ((work->flag & STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT) == 0)
            {
                DestroyStageTask(work);
                work->parentObj = NULL;
                return TRUE;
            }

            work->parentObj = NULL;
        }

        if ((work->flag & STAGE_TASK_FLAG_IS_CHILD_OBJ) != 0)
        {
            work->displayFlag &= ~(DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);
            work->displayFlag |= parent->displayFlag & (DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);

            work->position.x = parent->position.x + work->parentOffset.x;
            work->position.y = parent->position.y + work->parentOffset.y;
            work->position.z = parent->position.z + work->parentOffset.z;

            if ((work->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->position.x = parent->position.x - work->parentOffset.x;

            if ((work->displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                work->position.y = parent->position.y - work->parentOffset.y;

            work->offset.x = parent->prevOffset.x;
            work->offset.y = parent->prevOffset.y;
            work->offset.z = parent->prevOffset.z;

            if (parent->hitstopTimer != 0)
            {
                work->hitstopTimer = parent->hitstopTimer;
                work->hitstopTimer += StageTask__AdvanceBySpeed(FLOAT_TO_FX32(1.0));
            }
        }

        if ((work->flag & STAGE_TASK_FLAG_USE_PARENT_SPRITES) != 0)
        {
            BOOL changeAnim = FALSE;

            if ((work->obj_2dIn3d != NULL && parent->obj_2dIn3d != NULL) || (work->obj_2d != NULL && parent->obj_2d != NULL))
            {
                AnimatorSprite *workAnimator;
                AnimatorSprite *parentAnimator;

                if (work->obj_2dIn3d != NULL)
                {
                    workAnimator   = &work->obj_2dIn3d->ani.animatorSprite;
                    parentAnimator = &parent->obj_2dIn3d->ani.animatorSprite;
                }
                else
                {
                    workAnimator   = &work->obj_2d->ani.work;
                    parentAnimator = &parent->obj_2d->ani.work;
                }

                workAnimator->animAdvance = parentAnimator->animAdvance;

                if (workAnimator->animID != parentAnimator->animID)
                {
                    changeAnim = TRUE;
                }
                else if (workAnimator->animFrameIndex > parentAnimator->animFrameIndex)
                {
                    changeAnim = TRUE;
                }
                else if (workAnimator->animFrameIndex == parentAnimator->animFrameIndex && workAnimator->frameRemainder < parentAnimator->frameRemainder)
                {
                    changeAnim = TRUE;
                }

                if (changeAnim)
                    StageTask__SetAnimation(work, parentAnimator->animID);
            }

            work->displayFlag &= ~(DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_DID_FINISH | DISPLAY_FLAG_DISABLE_LOOPING);
            work->displayFlag |= parent->displayFlag & (DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_DID_FINISH | DISPLAY_FLAG_DISABLE_LOOPING);
        }
    }

    return FALSE;
}

void StageTask__ObjectCollision(StageTask *work)
{
    fx32 endX   = work->position.x;
    fx32 endY   = work->position.y;
    fx32 startX = work->prevPosition.x;
    fx32 startY = work->prevPosition.y;

    u32 newCollisionFlag = 0;
    u32 newMoveFlag      = 0;

    work->prevCollisionFlag = work->collisionFlag;
    work->collisionFlag     = 0;

    u16 step = FLOAT_TO_FX32(8.0);
    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0)
    {
        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
            step >>= 1;

        if (MATH_ABS(work->position.x - work->prevPosition.x) > step || MATH_ABS(work->position.y - work->prevPosition.y) > step)
        {
            work->position.x = work->prevPosition.x;
            work->position.y = work->prevPosition.y;

            while (TRUE)
            {
                if (MATH_ABS(work->position.x - endX) > step)
                {
                    work->prevPosition.x = work->position.x;

                    if (endX > work->prevPosition.x)
                        work->position.x = work->prevPosition.x + step;
                    else
                        work->position.x = work->prevPosition.x - step;
                }
                else
                {
                    work->position.x = endX;
                }

                if (MATH_ABS(work->position.y - endY) > step)
                {
                    work->prevPosition.y = work->position.y;

                    if (endY > work->prevPosition.y)
                        work->position.y = work->prevPosition.y + step;
                    else
                        work->position.y = work->prevPosition.y - step;
                }
                else
                {
                    work->position.y = endY;
                }

                if (work->position.x == endX && work->position.y == endY)
                    break;

                fx32 storeX = work->position.x;
                fx32 storeY = work->position.y;
                ObjDiffCollisionEarthCheck(work);

                newCollisionFlag |= work->collisionFlag;
                newMoveFlag |= work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY;

                if (storeX != work->position.x)
                    endX = work->position.x;

                if (storeY != work->position.y)
                    endY = work->position.y;
            }
        }

        ObjDiffCollisionEarthCheck(work);

        u32 flag            = work->collisionFlag;
        work->collisionFlag = newCollisionFlag;
        work->collisionFlag |= flag;
        work->moveFlag |= newMoveFlag;

        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_ALLOW_TOP_SOLID) != 0 && (work->collisionFlag & STAGE_TASK_COLLISION_FLAG_ALLOW_TOP_SOLID) == 0)
            work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_ALLOW_TOP_SOLID;
    }

    work->prevPosition.x = startX;
    work->prevPosition.y = startY;
}

void StageTask__Draw2D(StageTask *work, AnimatorSpriteDS *animator)
{
    VecFx32 position;
    VecU16 direction;

    position = work->position;

    direction = work->dir;

    position.x += work->offset.x;
    position.y += work->offset.y;

    if (work->fallDir != FLOAT_DEG_TO_IDX(0.0))
        direction.z += work->fallDir;

    if (work->obj_3d != NULL || work->obj_3des != NULL || work->obj_2dIn3d != NULL)
        animator->flags |= ANIMATORSPRITEDS_FLAG_DISABLE_A;

    StageTask__Draw2DEx(animator, &position, &direction, &work->scale, &work->displayFlag, (SpriteFrameCallback)StageTask__SpriteBlockCallback_Hitbox, work);
}

void StageTask__Draw2DEx(AnimatorSpriteDS *animator, VecFx32 *position, VecU16 *direction, VecFx32 *scale, StageDisplayFlags *displayFlagPtr, SpriteFrameCallback callback,
                         void *userData)
{
    s32 cameraX;
    s32 cameraY;
    fx32 backupAnimAdvance;
    StageDisplayFlags copyDisplayFlagPtr;
    fx32 scaleX, scaleY;
    u16 rotation;

    cameraX            = 0;
    cameraY            = 0;
    copyDisplayFlagPtr = DISPLAY_FLAG_NONE;

    rotation = FLOAT_DEG_TO_IDX(0.0);
    if (direction != NULL)
    {
        rotation = direction->z;
    }

    if (displayFlagPtr != NULL)
    {
        copyDisplayFlagPtr = *displayFlagPtr;
        animator->work.flags &= ~(ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_FLIP_X | ANIMATOR_FLAG_FLIP_Y);
        *displayFlagPtr &= ~DISPLAY_FLAG_DID_FINISH;

        if (copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_LOOPING)
        {
            animator->work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
        }

        if (copyDisplayFlagPtr & DISPLAY_FLAG_FLIP_X)
        {
            animator->work.flags |= ANIMATOR_FLAG_FLIP_X;
        }

        if (copyDisplayFlagPtr & DISPLAY_FLAG_FLIP_Y)
        {
            animator->work.flags |= ANIMATOR_FLAG_FLIP_Y;
        }
    }

    for (u16 c = 0; c < 2; c++)
    {
        if ((g_obj.flag & OBJECTMANAGER_FLAG_ENABLE_CAMERA) != 0 && ((copyDisplayFlagPtr & DISPLAY_FLAG_SCREEN_RELATIVE) == 0))
        {
            cameraX = FX_Whole(g_obj.camera[c].x);
            cameraY = FX_Whole(g_obj.camera[c].y);
        }

        if ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_POSITION) == 0)
        {
            if (position != NULL)
            {
                animator->position[c].x = FX_Whole(position->x) - cameraX;
                animator->position[c].y = FX_Whole(position->y) - cameraY;

                if ((g_obj.flag & OBJECTMANAGER_FLAG_USE_Z_AS_SCROLL) != 0)
                {
                    const fx32 z = MultiplyFX(position->z, g_obj.depth);

                    animator->position[c].y += FX_Whole(z);
                }
            }

            if ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_POSITION_OFFSETS) == 0)
            {
                animator->position[c].x += g_obj.offset.x;
                animator->position[c].y += g_obj.offset.y;
            }
        }
    }

    backupAnimAdvance          = animator->work.animAdvance;
    animator->work.animAdvance = MultiplyFX(animator->work.animAdvance, g_obj.speed);

    if (copyDisplayFlagPtr & DISPLAY_FLAG_PAUSED)
    {
        animator->work.animAdvance = FLOAT_TO_FX32(0.0);
    }

    if ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_UPDATE) == 0)
    {
        AnimatorSpriteDS__ProcessAnimation(animator, callback, userData);
    }
    animator->work.animAdvance = backupAnimAdvance;

    scaleX = g_obj.scale.x;
    scaleY = g_obj.scale.y;

    if (scale != NULL)
    {
        scaleX = MultiplyFX(g_obj.scale.x, scale->x);
        scaleY = MultiplyFX(g_obj.scale.y, scale->y);
    }

    if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
    {
        animator->position[0].x = MultiplyFX(animator->position[0].x - HW_LCD_CENTER_X, g_obj.scale.x) + HW_LCD_CENTER_X;
        animator->position[1].x = MultiplyFX(animator->position[1].x - HW_LCD_CENTER_X, g_obj.scale.x) + HW_LCD_CENTER_X;
    }

    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
    {
        animator->position[0].y = MultiplyFX(animator->position[0].y - HW_LCD_CENTER_Y, g_obj.scale.y) + HW_LCD_CENTER_Y;
        animator->position[1].y = MultiplyFX(animator->position[1].y - HW_LCD_CENTER_Y, g_obj.scale.y) + HW_LCD_CENTER_Y;
    }

    if ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        if ((((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_ROTATION) == 0) && (rotation != FLOAT_DEG_TO_IDX(0.0)))
            || ((scaleX != FLOAT_TO_FX32(1.0) || scaleY != FLOAT_TO_FX32(1.0)) && ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_SCALE) == 0)))
        {
            AnimatorSpriteDS__DrawFrameRotoZoom(animator, scaleX, scaleY, rotation);
        }
        else
        {
            AnimatorSpriteDS__DrawFrame(animator);
        }
    }

    if ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_FINISH_EVENT) != 0)
    {
        return;
    }

    if ((animator->work.flags & ANIMATOR_FLAG_DID_FINISH) == 0)
    {
        return;
    }

    *displayFlagPtr |= DISPLAY_FLAG_DID_FINISH;
}

void StageTask__Draw3D(StageTask *work, Animator3D *animator)
{
    VecFx32 position;
    VecU16 direction;

    position = work->position;

    direction = work->dir;

    position.x += work->offset.x;
    position.y += work->offset.y;
    position.z += work->offset.z;

    if (work->fallDir != FLOAT_DEG_TO_IDX(0.0))
        direction.z += work->fallDir;

    if (work->obj_3d != NULL || work->obj_3des != NULL)
    {
        if (work->obj_2d != NULL)
            work->obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_A;
    }

    StageTask__Draw3DEx(animator, &position, &direction, &work->scale, &work->displayFlag, work->obj_3des, (SpriteFrameCallback)StageTask__SpriteBlockCallback_Hitbox, work);
}

RUSH_INLINE void Copy_VecFx32(VecFx32 *target, VecFx32 const *source)
{
    // A matching decomp does require this variable declaration order.
    const fx32 x = source->x, z = source->z, y = source->y;
    target->x = x;
    target->y = y;
    target->z = z;
}

/* "Necessary" in order to match the bloat LSL16/LSR16 pairs (which probably stem from implicit conversions in
    the source code across inlined functions (or macros) but I couldn't find the right combination) */
#define FX_SINCOSCAST (s32)(u16)
//! Allows passing two arguments at once to functions taking sin and cos parameters next to each other.
#define FX_SIN_AND_COS(angle) SinFX(FX_SINCOSCAST(angle)), CosFX(FX_SINCOSCAST(angle))

void StageTask__Draw3DEx(Animator3D *animator, VecFx32 *position, VecU16 *dir, VecFx32 *scale, StageDisplayFlags *displayFlag, OBS_ACTION3D_SIMPLE_WORK *obj3d_es_arg,
                         SpriteFrameCallback callback, void *userData)
{
    // Leaving this scratch here in case it becomes possible to compile this file using MW2.0sp5. However, it is fine using the lower compiler version as a workaround.
    // https://decomp.me/scratch/9f4ui: 100% with MW < 2.0sp5, but only close to 100% otherwise

    AnimatorMDL *mdlAnimator;
    struct AnimatorSprite3DSpecific *sprite3DAnimatorSpecific;
    StageDisplayFlags copyStageDisplayFlags;
    BOOL disablePosition;
    u32 i;
    Camera3D defaultCamera3D;
    MtxFx44 backupNNS_G3dGlb_projMtx;
    VecFx32 copyScale;
    MtxFx33 mat33Rotations;
    fx32 xCameraFunc;
    fx32 yCameraFunc;
    u16 baseAngleRotationAroundYAxis;
    s32 backupAnimAdvance;
    fx32 backupSpeedMultiplier;
    s16 backupRatioMultiplier;
    AnimatorSprite3D *sprite3DAnimator;
    s32 applyCameraConfig;

    copyScale                    = animator->scale;
    baseAngleRotationAroundYAxis = 0;
    mdlAnimator                  = NULL;
    sprite3DAnimator             = NULL;
    sprite3DAnimatorSpecific     = NULL;
    copyStageDisplayFlags        = DISPLAY_FLAG_NONE;

    if (animator->type == ANIMATOR3D_MODEL)
    {
        mdlAnimator = (AnimatorMDL *)animator;
    }
    if (animator->type == ANIMATOR3D_SPRITE)
    {
        sprite3DAnimatorSpecific = (struct AnimatorSprite3DSpecific *)(&((AnimatorSprite3D *)animator)->animatorSprite);
        sprite3DAnimator         = (AnimatorSprite3D *)animator;
    }
    if (displayFlag != NULL)
    {
        copyStageDisplayFlags = *displayFlag;
    }

    if (sprite3DAnimatorSpecific != NULL)
    {
        sprite3DAnimatorSpecific->animatorSprite.flags &= ~(ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_FLIP_X | ANIMATOR_FLAG_FLIP_Y);
        if (copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_LOOPING)
        {
            sprite3DAnimatorSpecific->animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
        }
        if (copyStageDisplayFlags & DISPLAY_FLAG_FLIP_X)
        {
            sprite3DAnimatorSpecific->animatorSprite.flags |= ANIMATOR_FLAG_FLIP_X;
        }
        if (copyStageDisplayFlags & DISPLAY_FLAG_FLIP_Y)
        {
            sprite3DAnimatorSpecific->animatorSprite.flags |= ANIMATOR_FLAG_FLIP_Y;
        }
    }
    else
    {
        if (copyStageDisplayFlags & DISPLAY_FLAG_FLIP_X)
        {
            baseAngleRotationAroundYAxis = FLOAT_DEG_TO_IDX(270);
        }
        else
        {
            baseAngleRotationAroundYAxis = FLOAT_DEG_TO_IDX(90);
        }
    }

    if (mdlAnimator != NULL)
    {
        for (i = 0; i < B3D_ANIM_MAX; i++)
        {
            mdlAnimator->animFlags[i] &= ~(ANIMATORMDL_FLAG_STOPPED | ANIMATORMDL_FLAG_CAN_LOOP);
        }
        if (copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_LOOPING)
        {
            for (i = 0; i < B3D_ANIM_MAX; i++)
            {
                //                        ??????????????????????????????
                mdlAnimator->animFlags[i] |= (ANIMATORMDL_FLAG_CAN_LOOP);
            }
        }
    }

    copyStageDisplayFlags &= ~(DISPLAY_FLAG_DID_FINISH);
    if (copyStageDisplayFlags & DISPLAY_FLAG_LOCK_LIGHT_DIR)
    {
        if (copyStageDisplayFlags & DISPLAY_FLAG_FLIP_X)
        {
            for (i = 0; i < g_obj.lightCount; i++)
            {
                NNS_G3dGlbLightVector((GXLightId)i, g_obj.lightDirs[i].x, g_obj.lightDirs[i].y, g_obj.lightDirs[i].z);
            }
        }
        else
        {
            for (i = 0; i < g_obj.lightCount; i++)
            {
                const fx16 flippedX = (-1 * g_obj.lightDirs[i].x);
                NNS_G3dGlbLightVector((GXLightId)i, flippedX, g_obj.lightDirs[i].y, g_obj.lightDirs[i].z);
            }
        }
    }
    else
    {
        for (i = 0; i < g_obj.lightCount; i++)
        {
            NNS_G3dGlbLightVector((GXLightId)i, g_obj.lightDirs[i].x, g_obj.lightDirs[i].y, g_obj.lightDirs[i].z);
        }
    }

    disablePosition = (copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_POSITION);
    if (disablePosition == FALSE)
    {
        xCameraFunc = 0;
        yCameraFunc = 0;
        if ((g_obj.flag & OBJECTMANAGER_FLAG_ENABLE_CAMERA) && ((copyStageDisplayFlags & DISPLAY_FLAG_SCREEN_RELATIVE) == 0))
        {
            if (g_obj.cameraFunc != NULL)
            {
                g_obj.cameraFunc(&xCameraFunc, &yCameraFunc);
            }
            else
            {
                xCameraFunc = g_obj.camera[GRAPHICS_ENGINE_A].x;
                yCameraFunc = g_obj.camera[GRAPHICS_ENGINE_A].y;
            }
        }

        animator->translation.x = position->x - xCameraFunc;
        animator->translation.y = -(position->y - yCameraFunc);
        animator->translation.z = position->z;
        if ((copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_POSITION_OFFSETS) == 0)
        {
            animator->translation.x = animator->translation.x + FX32_FROM_WHOLE(g_obj.offset.x);
            animator->translation.y = animator->translation.y + FX32_FROM_WHOLE(g_obj.offset.y);
        }

        if (g_obj.flag & OBJECTMANAGER_FLAG_USE_Z_AS_SCROLL)
        {
            animator->translation.z = position->z * 2;
            animator->translation.y = animator->translation.y - MultiplyFX(position->z, g_obj.depth);
        }

        if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
        {
            animator->translation.x = FX32_FROM_WHOLE(HW_LCD_CENTER_X) + MultiplyFX(animator->translation.x - FX32_FROM_WHOLE(HW_LCD_CENTER_X), g_obj.scale.x);
        }

        if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
        {
            animator->translation.y = -(FX32_FROM_WHOLE(HW_LCD_CENTER_Y) + MultiplyFX(-FX32_FROM_WHOLE(HW_LCD_CENTER_Y) - animator->translation.y, g_obj.scale.y));
        }
    }

    if (((copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_ROTATION) == 0) && (disablePosition == FALSE))
    {
        MTX_Identity33(&animator->rotation);
        MTX_RotY33(&mat33Rotations, FX_SIN_AND_COS(baseAngleRotationAroundYAxis));
        MTX_Concat33(&animator->rotation, &mat33Rotations, &animator->rotation);
        MTX_RotX33(&mat33Rotations, FX_SIN_AND_COS(-dir->x));
        MTX_Concat33(&animator->rotation, &mat33Rotations, &animator->rotation);
        MTX_RotY33(&mat33Rotations, FX_SIN_AND_COS(-dir->y));
        MTX_Concat33(&animator->rotation, &mat33Rotations, &animator->rotation);
        MTX_RotZ33(&mat33Rotations, FX_SIN_AND_COS(-dir->z));
        MTX_Concat33(&animator->rotation, &mat33Rotations, &animator->rotation);
    }

    fx32 xScaled = FLOAT_TO_FX32(1.0), yScaled = FLOAT_TO_FX32(1.0), zScaled = FLOAT_TO_FX32(1.0);
    if (scale != NULL)
    {
        const fx32 localYScaled = MultiplyFX(g_obj.scale.y, scale->y);
        const fx32 localXScaled = MultiplyFX(g_obj.scale.x, scale->x);
        xScaled                 = localXScaled;
        yScaled                 = localYScaled;
        zScaled                 = scale->z;
    }
    const s32 newScaleX = MultiplyFX(animator->scale.x, xScaled);
    const s32 newScaleZ = MultiplyFX(animator->scale.z, zScaled);
    const s32 newScaleY = MultiplyFX(animator->scale.y, yScaled);

    animator->scale.x = newScaleX;
    animator->scale.y = newScaleY;
    animator->scale.z = newScaleZ;

    applyCameraConfig = copyStageDisplayFlags & DISPLAY_FLAG_ROTATE_CAMERA_DIR;
    if (applyCameraConfig)
    {
        CameraConfig const *const ptrConfig = &g_obj.cameraConfig->config;
        const u32 halfFOV                   = ptrConfig->projFOV;
        const u32 nearPlaneDistance         = ptrConfig->projNear;
        const fx32 tangentHalfFOV           = FX_Div(FX_SIN_AND_COS(halfFOV));
        const fx32 frustumHalfHeight        = MultiplyFX(tangentHalfFOV, nearPlaneDistance);
        const fx32 frustumHalfWidth         = MultiplyFX(frustumHalfHeight, ptrConfig->aspectRatio);
        const fx32 nearByZ                  = FX_Div(ptrConfig->projNear, g_obj.cameraConfig->lookAtTo.z);
        const fx32 frustumCenterY           = MultiplyFX(nearByZ, (FX32_FROM_WHOLE(HW_LCD_CENTER_Y) + animator->translation.y));
        const fx32 frustumCenterX           = MultiplyFX(nearByZ, (FX32_FROM_WHOLE(HW_LCD_CENTER_X) - animator->translation.x));
        animator->translation.x             = FX32_FROM_WHOLE(HW_LCD_CENTER_X);
        animator->translation.y             = -FX32_FROM_WHOLE(HW_LCD_CENTER_Y);

        backupNNS_G3dGlb_projMtx = *NNS_G3dGlbGetProjectionMtx();

        const fx32 top    = -frustumCenterY + frustumHalfHeight;
        const fx32 bottom = -(frustumHalfHeight + frustumCenterY);
        const fx32 left   = frustumCenterX - frustumHalfWidth;
        const fx32 right  = frustumHalfWidth + frustumCenterX;
        const fx32 near   = ptrConfig->projNear;
        const fx32 far    = ptrConfig->projFar;
        NNS_G3dGlbFrustum(top, bottom, left, right, near, far);
    }
    else if (copyStageDisplayFlags & DISPLAY_FLAG_DRAW_3D_SPRITE_AS_2D)
    {
        const u16 defaultFOV = FLOAT_DEG_TO_IDX(88.59375); // or 0x3F00
        // MW < 2.0sp1p5 seems necessary in order to match the early computing of the sin/cos array indices.
        defaultCamera3D                = *g_obj.cameraConfig;
        defaultCamera3D.config.projFOV = defaultFOV;
        defaultCamera3D.lookAtFrom.x   = FX32_FROM_WHOLE(HW_LCD_CENTER_X);
        defaultCamera3D.lookAtFrom.y   = -FX32_FROM_WHOLE(HW_LCD_CENTER_Y);
        defaultCamera3D.lookAtFrom.z   = FLOAT_TO_FX32(0.0);
        defaultCamera3D.lookAtTo.x     = FX32_FROM_WHOLE(HW_LCD_CENTER_X);
        defaultCamera3D.lookAtTo.y     = -FX32_FROM_WHOLE(HW_LCD_CENTER_Y);
        defaultCamera3D.lookAtTo.z     = HW_LCD_CENTER_Y * FX_Div(CosFX(FX_SINCOSCAST(defaultCamera3D.config.projFOV)), SinFX(FX_SINCOSCAST(defaultCamera3D.config.projFOV)));
        defaultCamera3D.lookAtUp.x     = FLOAT_TO_FX32(0.0);
        defaultCamera3D.lookAtUp.y     = FLOAT_TO_FX32(1.0);
        defaultCamera3D.lookAtUp.z     = FLOAT_TO_FX32(0.0);
        Camera3D__LoadState(&defaultCamera3D);
    }

    if (mdlAnimator != NULL)
    {
        backupSpeedMultiplier        = mdlAnimator->speedMultiplier;
        mdlAnimator->speedMultiplier = MultiplyFX(backupSpeedMultiplier, g_obj.speed);
        backupRatioMultiplier        = mdlAnimator->ratioMultiplier;
        mdlAnimator->ratioMultiplier = MultiplyFX(backupRatioMultiplier, g_obj.speed);
    }

    if (sprite3DAnimatorSpecific != NULL)
    {
        backupAnimAdvance                                    = sprite3DAnimatorSpecific->animatorSprite.animAdvance;
        sprite3DAnimatorSpecific->animatorSprite.animAdvance = MultiplyFX(sprite3DAnimatorSpecific->animatorSprite.animAdvance, g_obj.speed);
    }

    if (copyStageDisplayFlags & DISPLAY_FLAG_PAUSED)
    {
        if (mdlAnimator != NULL)
        {
            mdlAnimator->speedMultiplier = 0;
        }
        if (sprite3DAnimatorSpecific != NULL)
        {
            sprite3DAnimatorSpecific->animatorSprite.animAdvance = 0;
        }
    }

    if ((copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_UPDATE) == 0)
    {
        if (mdlAnimator != NULL && (mdlAnimator->renderObj.recJntAnm != NULL))
        {
            mdlAnimator->renderObj.flag |= NNS_G3D_RENDEROBJ_FLAG_RECORD;
        }
        if (sprite3DAnimator != NULL)
        {
            AnimatorSprite3D__ProcessAnimation(sprite3DAnimator, callback, userData);
        }
        else
        {
            Animator3D__Process(animator);
        }
    }
    else
    {
        if (mdlAnimator != NULL)
        {
            mdlAnimator->renderObj.flag &= ~(NNS_G3D_RENDEROBJ_FLAG_RECORD);
        }
    }

    if (sprite3DAnimatorSpecific != NULL)
    {
        sprite3DAnimatorSpecific->animatorSprite.animAdvance = backupAnimAdvance;
    }
    if (mdlAnimator != NULL)
    {
        mdlAnimator->speedMultiplier = backupSpeedMultiplier;
        mdlAnimator->ratioMultiplier = backupRatioMultiplier;
    }

    if ((copyStageDisplayFlags & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        OBS_ACTION3D_SIMPLE_WORK *obj3d_es = obj3d_es_arg;
        if (obj3d_es != NULL)
        {
            while (TRUE)
            {
                if (obj3d_es == NULL)
                    break;

                if ((obj3d_es->flags & OBJ_ACTION_FLAG_DO_NOT_DRAW) == 0)
                {
                    Copy_VecFx32(&obj3d_es->ani.work.scale, &animator->scale);
                    Copy_VecFx32(&obj3d_es->ani.work.translation, &animator->translation);
                    if ((obj3d_es->flags & OBJ_ACTION_FLAG_DRAW_WITH_OWN_ROTATION) == 0)
                    {
                        MI_Copy36B(&animator->rotation, &obj3d_es->ani.work.rotation);
                    }
                    Animator3D__Draw(&obj3d_es->ani.work);
                }
                obj3d_es = obj3d_es->next;
            }
        }
        else
        {
            Animator3D__Draw(animator);
        }
    }

    if (applyCameraConfig)
    {
        NNS_G3dGlb.projMtx = backupNNS_G3dGlb_projMtx;
    }

    if (copyStageDisplayFlags & DISPLAY_FLAG_DRAW_3D_SPRITE_AS_2D)
    {
        Camera3D__LoadState(g_obj.cameraConfig);
    }

    if (mdlAnimator != NULL)
    {
        if (mdlAnimator->animFlags[0] & ANIMATORMDL_FLAG_BLENDING_PAUSED)
        {
            copyStageDisplayFlags &= ~(DISPLAY_FLAG_ENABLE_ANIMATION_BLENDING);
        }

        if (mdlAnimator->animFlags[0] & ANIMATORMDL_FLAG_FINISHED)
        {
            copyStageDisplayFlags &= ~(DISPLAY_FLAG_ENABLE_ANIMATION_BLENDING);
            copyStageDisplayFlags |= DISPLAY_FLAG_DID_FINISH;
        }
    }

    if (sprite3DAnimatorSpecific != NULL)
    {
        if (sprite3DAnimatorSpecific->animatorSprite.flags & ANIMATOR_FLAG_DID_FINISH)
        {
            copyStageDisplayFlags |= DISPLAY_FLAG_DID_FINISH;
        }
    }

    if (scale != NULL)
    {
        animator->scale = copyScale;
    }
    if (displayFlag != NULL)
    {
        *displayFlag = copyStageDisplayFlags;
    }
}

void StageTask__SetAnimatorOAMOrder(StageTask *work, u32 order)
{
    if (work->obj_2d != NULL)
        StageTask__SetOAMOrder(&work->obj_2d->ani.work, order);
}

void StageTask__SetOAMOrder(AnimatorSprite *animator, u32 order)
{
    animator->oamOrder = order;
}

void StageTask__SetAnimatorPriority(StageTask *work, SpritePriority priority)
{
    if (work->obj_2d != NULL)
        StageTask__SetOAMPriority(&work->obj_2d->ani.work, priority);
}

void StageTask__SetOAMPriority(AnimatorSprite *animator, SpritePriority priority)
{
    animator->oamPriority = priority;
}

void StageTask__SetAnimation(StageTask *work, u16 animID)
{
    work->displayFlag &= ~DISPLAY_FLAG_DID_FINISH;
    work->displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

    if (work->obj_3d != NULL && work->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM] != NULL)
    {
        work->obj_3d->animID = animID;
        AnimatorMDL__SetAnimation(&work->obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], animID, NULL);
    }

    if (work->obj_2dIn3d != NULL && work->obj_2dIn3d->fileData != NULL)
        AnimatorSprite__SetAnimation(&work->obj_2dIn3d->ani.animatorSprite, animID);

    if (work->obj_2d != NULL && work->obj_2d->ani.work.fileData != NULL)
    {
        AnimatorSpriteDS__SetAnimation(&work->obj_2d->ani, animID);

        for (u16 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
        {
            if (work->colliderList[c] != NULL)
            {
                if (work->colliderFlags[c] != STAGE_TASK_COLLIDER_FLAGS_NONE)
                    work->colliderList[c]->flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
            }
        }
    }
}

u16 StageTask__GetAnimID(StageTask *work)
{
    if (work->obj_3d != NULL)
        return work->obj_3d->animID;

    if (work->obj_2dIn3d != NULL)
        return work->obj_2dIn3d->ani.animatorSprite.animID;

    if (work->obj_2d != NULL)
        return work->obj_2d->ani.work.animID;

    return 0;
}

void StageTask__Move(StageTask *work)
{
    fx32 slopeX = 0;
    fx32 slopeY = 0;

    work->prevPosition.x = work->position.x;
    work->prevPosition.y = work->position.y;
    work->prevPosition.z = work->position.z;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_RESET_FLOW) != 0)
    {
        work->flow.x = 0;
        work->flow.y = 0;
        work->flow.z = 0;
    }

    fx32 flowX = work->flow.x;
    fx32 flowY = work->flow.y;

    if ((flowX != 0 || flowY != 0) && work->fallDir != FLOAT_DEG_TO_IDX(0.0))
        StageTask__ObjectSpdDirFall(&flowX, &flowY, work->fallDir);

    if (work->hitstopTimer != 0)
    {
        work->move.x = MultiplyFX(flowX, g_obj.speed);
        work->move.y = MultiplyFX(flowY, g_obj.speed);
        work->move.z = MultiplyFX(work->flow.z, g_obj.speed);
    }
    else
    {
        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
        {
            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_HAS_GRAVITY) != 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
                work->velocity.y += MultiplyFX(work->gravityStrength, g_obj.speed);

            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_HAS_GRAVITY) != 0)
            {
                if (work->velocity.y > work->terminalVelocity)
                    work->velocity.y = work->terminalVelocity;
            }
        }

        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES) != 0)
        {
            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION) != 0)
            {
                if (work->groundVel != FLOAT_TO_FX32(0.0) || (work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_IDLE_ACCELERATION) == 0)
                {
                    if ((u16)(work->dir.z + work->slopeAcceleration) >= 2 * work->slopeAcceleration)
                    {
                        if (work->dir.z != FLOAT_DEG_TO_IDX(0.0))
                            work->groundVel = ObjSpdUpSet(work->groundVel, MultiplyFX(work->slopeAcceleration, SinFX((s32)work->dir.z)), work->maxSlopeSpeed);
                        else
                            work->groundVel = ObjSpdUpSet(work->groundVel, MultiplyFX(-work->slopeAcceleration, SinFX((s32)work->dir.z)), work->maxSlopeSpeed);
                    }
                }
            }

            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) == 0)
            {
                slopeX = MultiplyFX(work->groundVel, CosFX((s32)work->dir.z));
                slopeY = MultiplyFX(work->groundVel, SinFX((s32)work->dir.z));
            }
        }

        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJECT_SCROLL) != 0)
        {
            work->move.x = MultiplyFX(work->velocity.x + slopeX + flowX, g_obj.speed);
            work->move.y = MultiplyFX(work->velocity.y + slopeY + flowY, g_obj.speed);
        }
        else
        {
            work->move.x = MultiplyFX(work->velocity.x + slopeX + flowX + g_obj.scroll.x, g_obj.speed);
            work->move.y = MultiplyFX(work->velocity.y + slopeY + flowY + g_obj.scroll.y, g_obj.speed);
        }

        work->move.z = MultiplyFX((work->flow.z + work->velocity.z), g_obj.speed);
        StageTask__ObjectSpdDirFall(&work->move.x, &work->move.y, work->fallDir);
    }

    work->flow.x = 0;
    work->flow.y = 0;
    work->flow.z = 0;

    work->position.x += work->move.x;
    work->position.y += work->move.y;
    work->position.z += work->move.z;

    work->velocity.x += work->acceleration.x;
    work->velocity.y += work->acceleration.y;
    work->velocity.z += work->acceleration.z;
}

void StageTask__ObjectSpdDirFall(fx32 *velX, fx32 *velY, u16 fallDir)
{
    MtxFx33 matrix;

    fx32 x = 0;
    fx32 y = 0;

    if (velX != NULL)
        x = *velX;

    if (velY != NULL)
        y = *velY;

    MTX_Identity33(&matrix);
    MTX_RotZ33(&matrix, SinFX((s32)fallDir), CosFX((s32)fallDir));

    VecFx32 velocity;
    velocity.x = x;
    velocity.y = y;
    velocity.z = 0;
    MTX_MultVec33(&velocity, &matrix, &velocity);

    if (velX != NULL)
        *velX = velocity.x;

    if (velY != NULL)
        *velY = velocity.y;
}

BOOL StageTask__ObjectDirFallReverseCheck(u32 fallDir)
{
    return fallDir > FLOAT_DEG_TO_IDX(135.0) && fallDir < FLOAT_DEG_TO_IDX(225.0);
}

void StageTask__HandleRide(StageTask *work)
{
    if (work->collisionObj != NULL)
    {
        if (work->collisionObj->work.riderObj != NULL && IsStageTaskDestroyed(work->collisionObj->work.riderObj))
            work->collisionObj->work.riderObj = NULL;

        if (work->collisionObj->work.toucherObj != NULL && work->collisionObj->work.toucherObj != work->collisionObj->work.riderObj)
        {
            if ((work->collisionObj->work.toucherObj->moveFlag & STAGE_TASK_MOVE_FLAG_2000000) != 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_4000000) != 0)
            {
                fx32 pushMove = MTM_MATH_CLIP_2(
                    MTM_MATH_CLIP_2(work->collisionObj->work.toucherObj->move.x, -work->collisionObj->work.toucherObj->pushCap, work->collisionObj->work.toucherObj->pushCap),
                    -work->pushCap, work->pushCap);

                work->flow.x += pushMove;
            }

            if (IsStageTaskDestroyed(work->collisionObj->work.toucherObj))
                work->collisionObj->work.toucherObj = NULL;
        }
    }

    if (work->touchObj != NULL)
    {
        if ((work->touchObj->moveFlag & STAGE_TASK_MOVE_FLAG_4000000) != 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_2000000) != 0)
        {
            work->flow.x += (s16)(work->touchObj->position.x - work->touchObj->prevPosition.x);

            if ((work->touchObj->move.x & 0xFFF) != 0)
            {
                if (work->touchObj->move.x > 0)
                    work->flow.x += FLOAT_TO_FX32(1.0) - (work->touchObj->move.x & 0xFFF);
                else
                    work->flow.x -= FLOAT_TO_FX32(1.0) + (work->touchObj->move.x & 0xFFF);
            }
        }

        if (IsStageTaskDestroyed(work->touchObj))
            work->touchObj = NULL;
    }

    if (work->rideObj != NULL)
    {
        if (IsStageTaskDestroyed(work->rideObj))
        {
            work->rideObj = NULL;
        }
        else
        {
            if ((work->rideObj->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) != 0)
            {
                work->flow.x += work->rideObj->move.x;
                work->flow.y += work->rideObj->move.y;
                work->flow.z += work->rideObj->move.z;
            }
            else
            {
                work->flow.x += (s16)(work->rideObj->position.x - work->rideObj->prevPosition.x);
                work->flow.y += (s16)(work->rideObj->position.y - work->rideObj->prevPosition.y);
                work->flow.z += (s16)(work->rideObj->position.z - work->rideObj->prevPosition.z);
            }

            if ((work->rideObj->move.y & 0xFFF) != 0)
                work->flow.y += FLOAT_TO_FX32(1.0) - (work->rideObj->move.y & 0xFFF);
        }
    }
}

void StageTask__HandleCollider(StageTask *work, OBS_RECT_WORK *rect)
{
    if (!IsStageTaskDestroyedAny(work) && (g_obj.flag & OBJECTMANAGER_FLAG_ALLOW_RECT_COLLISIONS) != 0 && (work->flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
    {
        rect->parent = work;

        rect->flag &= ~(OBS_RECT_WORK_FLAG_FLIP_Y | OBS_RECT_WORK_FLAG_FLIP_X);
        if (StageTask__ObjectDirFallReverseCheck(work->fallDir))
        {
            rect->flag ^= OBS_RECT_WORK_FLAG_FLIP_Y;
            rect->flag ^= OBS_RECT_WORK_FLAG_FLIP_X;
        }

        ObjRect__Register(rect);
    }
}

BOOL StageTask__ViewCheck_Default(StageTask *work)
{
    return StageTask__ViewOutCheck(work->position.x, work->position.y, work->viewOutOffset, work->viewOutOffsetBoundsLeft, work->viewOutOffsetBoundsTop,
                                   work->viewOutOffsetBoundsRight, work->viewOutOffsetBoundsBottom);
}

BOOL StageTask__ViewOutCheck(fx32 x, fx32 y, s16 offset, s16 sLeft, s16 sTop, s16 sRight, s16 sBottom)
{
    s32 testLeft, testTop;
    s32 testRight, testBottom;

    s16 screenWidth = HW_LCD_WIDTH, screenHeight = HW_LCD_HEIGHT;

    if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
        screenWidth = (s16)FX_Mul(screenWidth, (FLOAT_TO_FX32(2.0) - g_obj.scale.x));
    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
        screenHeight = (s16)FX_Mul(screenHeight, (FLOAT_TO_FX32(2.0) - g_obj.scale.y));

    if ((g_obj.flag & OBJECTMANAGER_FLAG_ENABLE_CAMERA) == 0)
        return FALSE;

    if (g_obj.flag & OBJECTMANAGER_FLAG_USE_DUAL_CAMERAS)
    {
        if (g_obj.camera[GRAPHICS_ENGINE_A].y < g_obj.camera[GRAPHICS_ENGINE_B].y)
        {
            testLeft   = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_A].x) - offset;
            testTop    = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_A].y) - offset;
            testRight  = screenWidth + (offset << 1);
            testBottom = (FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_B].y) - FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_A].y)) + screenHeight + (offset << 1);
        }
        else
        {
            testLeft   = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_B].x) - offset;
            testTop    = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_B].y) - offset;
            testRight  = screenWidth + (offset << 1);
            testBottom = (FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_A].y) - FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_B].y)) + screenHeight + (offset << 1);
        }

        testLeft += sLeft;
        testTop += sTop;
        testBottom += -sTop + sBottom;
        testRight += -sLeft + sRight;

        if ((testLeft <= FX32_TO_WHOLE(x) && (testLeft + testRight >= FX32_TO_WHOLE(x))) && (testTop <= FX32_TO_WHOLE(y) && testTop + testBottom >= FX32_TO_WHOLE(y)))
            return FALSE;
    }
    else
    {
        testLeft   = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_A].x) - offset;
        testTop    = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_A].y) - offset;
        testRight  = screenWidth + (offset << 1);
        testBottom = screenHeight + (offset << 1);

        testLeft += sLeft;
        testTop += sTop;
        testBottom += -sTop + sBottom;
        testRight += -sLeft + sRight;

        if ((testLeft <= FX32_TO_WHOLE(x) && testLeft + testRight >= FX32_TO_WHOLE(x)) && (testTop <= FX32_TO_WHOLE(y) && testTop + testBottom >= FX32_TO_WHOLE(y)))
            return FALSE;

        testLeft = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_B].x) - offset;
        testTop  = FX32_TO_WHOLE(g_obj.camera[GRAPHICS_ENGINE_B].y) - offset;

        testLeft += sLeft;
        testTop += sTop;

        if ((testLeft <= FX32_TO_WHOLE(x) && testLeft + testRight >= FX32_TO_WHOLE(x)) && (testTop <= FX32_TO_WHOLE(y) && testTop + testBottom >= FX32_TO_WHOLE(y)))
            return FALSE;
    }

    return TRUE;
}

void StageTask__SetHitbox(StageTask *work, s16 left, s16 top, s16 right, s16 bottom)
{
    work->hitboxRect.left   = left;
    work->hitboxRect.top    = top;
    work->hitboxRect.right  = right;
    work->hitboxRect.bottom = bottom;

    work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
}

void StageTask__SetGravity(StageTask *work, s32 gravity, s32 terminalVelocity)
{
    work->gravityStrength  = gravity;
    work->terminalVelocity = terminalVelocity;
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
}

void StageTask__InitCollider(StageTask *work, OBS_RECT_WORK *collider, u32 id, StageObjColliderFlags flags)
{
    if (collider == NULL)
    {
        if (work->colliderList[id] != NULL)
        {
            collider = work->colliderList[id];
        }
        else
        {
            collider = (OBS_RECT_WORK *)HeapAllocHead(HEAP_USER, sizeof(OBS_RECT_WORK));
            MI_CpuClear8(collider, sizeof(OBS_RECT_WORK));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_COLLIDERS;
        }
    }

    work->colliderList[id]         = collider;
    work->colliderFlags[id]        = flags;
    work->colliderList[id]->parent = work;
    ObjRect__SetGroupFlags(work->colliderList[id], 1, 1);
    work->colliderList[id]->hitPower = OBS_RECT_HITPOWER_DEFAULT;
    work->colliderList[id]->defPower = OBS_RECT_DEFPOWER_DEFAULT;
    work->colliderList[id]->hitFlag  = OBS_RECT_WORK_ATTR_NORMAL;
    work->colliderList[id]->defFlag  = OBS_RECT_WORK_ATTR_BODY;
}

OBS_RECT_WORK *StageTask__GetCollider(StageTask *work, u32 id)
{
    return work->colliderList[id];
}

void *StageTask__AllocateWorker(StageTask *work, size_t size)
{
    if (work->taskWorker != NULL)
    {
        HeapFree(HEAP_USER, work->taskWorker);
        work->taskWorker = NULL;
    }

    if (size != 0)
    {
        work->taskWorker = HeapAllocHead(HEAP_USER, size);
        MI_CpuClear8(work->taskWorker, size);
        work->flag |= STAGE_TASK_FLAG_ALLOCATED_TASK_WORKER;
    }

    return work->taskWorker;
}

void StageTask__InitSeqPlayer(StageTask *work)
{
    if (work->sequencePlayerPtr != NULL)
        ReleaseStageSfx(work->sequencePlayerPtr);

    if (work->sequencePlayerPtr != NULL)
        FreeSndHandle(work->sequencePlayerPtr);

    work->sequencePlayerPtr = AllocSndHandle();
}

void StageTask__SpriteBlockCallback_Hitbox(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, StageTask *work)
{
    if (block->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        if (block->id < STAGETASK_COLLIDER_COUNT)
        {
            if (work->colliderFlags[block->id] != STAGE_TASK_COLLIDER_FLAGS_NONE)
            {
                if (block->hitbox.left == block->hitbox.right && block->hitbox.top == block->hitbox.bottom)
                {
                    ObjRect__SetBox(work->colliderList[block->id], 0, 0, 0, 0);
                    work->colliderList[block->id]->flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
                }
                else
                {
                    if ((work->colliderList[block->id]->flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
                        work->colliderList[block->id]->flag &= ~OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME;

                    ObjRect__SetBox(work->colliderList[block->id], block->hitbox.left, block->hitbox.top, block->hitbox.right, block->hitbox.bottom);
                }
            }
        }
    }

    if (work->ppSpriteCallback != NULL)
        work->ppSpriteCallback((BACFrameGroupBlockHeader *)block, animator, work);
}

void StageTask__InitTblWork(StageTask *work, OBS_TBL_WORK *tblWork)
{
    if (tblWork == NULL)
    {
        if (work->tbl_work != NULL)
        {
            tblWork = work->tbl_work;
        }
        else
        {
            tblWork = (OBS_TBL_WORK *)HeapAllocHead(HEAP_USER, sizeof(OBS_TBL_WORK));
            MI_CpuClear8(tblWork, sizeof(OBS_TBL_WORK));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_TBL_WORK;
        }
    }

    work->tbl_work = tblWork;
    InitObjTblWork(tblWork);
}

fx32 StageTask__AdvanceBySpeed(fx32 value)
{
    if (g_obj.speed != FLOAT_TO_FX32(1.0))
        value = MultiplyFX(value, g_obj.speed);

    return value;
}

fx32 StageTask__DecrementBySpeed(fx32 value)
{
    if (g_obj.speed == FLOAT_TO_FX32(1.0))
        value -= FLOAT_TO_FX32(1.0);
    else
        value -= MultiplyFX(g_obj.speed, FLOAT_TO_FX32(1.0));

    if (value < 0)
        value = 0;

    return value;
}
