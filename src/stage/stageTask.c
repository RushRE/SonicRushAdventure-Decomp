#include <stage/stageTask.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/system/allocator.h>
#include <game/object/objCollision.h>
#include <game/object/objBlock.h>
#include <game/object/objDraw.h>
#include <game/object/obj.h>
#include <game/object/objExWork.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/screenUnknown.h>

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
        obj_ptcb = TaskCreateNoWork(ObjectManager_Main, ObjectManager_Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_END - 2, TASK_GROUP(5), "ObjectManager");
}

void ObjectManager_Main(void)
{
    if ((g_obj.flag & OBJECTMANAGER_FLAG_40) != 0)
        ObjRect__CheckAllGroup();

    ObjCollisionObjectClear();

    g_obj.timer_fx += StageTask__AdvanceBySpeed(FLOAT_TO_FX32(1.0));
    g_obj.flag |= OBJECTMANAGER_FLAG_1000;

    if (g_obj.timer == FX32_TO_WHOLE(g_obj.timer_fx))
        g_obj.flag &= ~OBJECTMANAGER_FLAG_1000;

    g_obj.timer = FX32_TO_WHOLE(g_obj.timer_fx);

    if ((g_obj.flag & OBJECTMANAGER_FLAG_2) != 0)
        g_obj.flag |= OBJECTMANAGER_FLAG_1;
    else
        g_obj.flag &= ~OBJECTMANAGER_FLAG_1;
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
    g_obj.flag |= OBJECTMANAGER_FLAG_2;
}

void DisableObjectManagerFlag2(void)
{
    g_obj.flag &= ~OBJECTMANAGER_FLAG_2;
}

BOOL ObjectPauseCheck(u32 flag)
{
    return (g_obj.flag & OBJECTMANAGER_FLAG_1) != 0 && (flag & STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE) == 0;
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
    g_obj.offset[0] = x;
    g_obj.offset[1] = y;
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
    g_obj.camera[0].x = x1;
    g_obj.camera[0].y = y1;

    g_obj.camera[1].x = x2;
    g_obj.camera[1].y = y2;
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

    if ((g_obj.flag & OBJECTMANAGER_FLAG_2000) == 0)
    {
        if ((g_obj.flag & OBJECTMANAGER_FLAG_4000) != 0)
            work->flag |= STAGE_TASK_FLAG_400000;
        else
            work->flag |= STAGE_TASK_FLAG_800000;
    }

    SetTaskViewCheckFunc(work, StageTask__ViewCheck_Default);

    if ((g_obj.flag & OBJECTMANAGER_FLAG_10000) != 0)
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

    if ((work->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
    {
        DestroyCurrentTask();
        return;
    }

    if ((work->flag & STAGE_TASK_FLAG_DESTROY_NEXT_FRAME) != 0)
    {
        work->flag |= STAGE_TASK_FLAG_DESTROYED;
        return;
    }

    if ((work->flag & STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT) == 0)
    {
        if (work->ppViewCheck != NULL)
        {
            if (work->ppViewCheck(work))
            {
                work->flag |= STAGE_TASK_FLAG_DESTROYED;
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
                if (((g_obj.flag & OBJECTMANAGER_FLAG_8000) == 0 || work->hitstopTimer == 0) && (work->flag & STAGE_TASK_FLAG_DISABLE_STATE) == 0)
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

        if ((g_obj.flag & (OBJECTMANAGER_FLAG_USE_BLOCK_COLLISIONS | OBJECTMANAGER_FLAG_20)) != 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0)
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

        if ((work->flag & STAGE_TASK_FLAG_DESTROYED) == 0)
        {
            if (work->ppOut == NULL || (work->displayFlag & DISPLAY_FLAG_NO_DRAW_EVENT) != 0)
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
        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_SCREEN_UNKNOWN) != 0)
            ReleaseScreenUnknown(work->obj_2d->ani.cParam[0].palette);

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

    for (OBS_ACTION3D_ES_WORK *esWork = work->obj_3des; esWork != NULL; esWork = esWork->next)
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

    if (work->ex_work != NULL)
    {
        if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_EX_WORK) != 0)
        {
            ObjExWork__Release(work->ex_work);
            HeapFree(HEAP_USER, work->ex_work);
        }
    }
}

BOOL StageTask__ObjectParent(StageTask *work)
{
    StageTask *parent = work->parentObj;
    if (parent != NULL)
    {
        if ((parent->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
        {
            if ((work->flag & STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT) == 0)
            {
                work->flag |= STAGE_TASK_FLAG_DESTROYED;
                work->parentObj = NULL;
                return TRUE;
            }

            work->parentObj = NULL;
        }

        if ((work->flag & STAGE_TASK_FLAG_IS_CHILD_OBJ) != 0)
        {
            work->displayFlag &= ~(DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);
            work->displayFlag |= parent->displayFlag & (DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);

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

            work->displayFlag &= ~(DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_DID_FINISH | DISPLAY_FLAG_DISABLE_LOOPING);
            work->displayFlag |= parent->displayFlag & (DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_DID_FINISH | DISPLAY_FLAG_DISABLE_LOOPING);
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

        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_20) != 0 && (work->collisionFlag & STAGE_TASK_COLLISION_FLAG_2) == 0)
            work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_20;
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
        animator->screensToDraw |= SCREEN_DRAW_A;

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
        if ((g_obj.flag & OBJECTMANAGER_FLAG_8) != 0 && ((copyDisplayFlagPtr & DISPLAY_FLAG_SCREEN_RELATIVE) == 0))
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

                if ((g_obj.flag & OBJECTMANAGER_FLAG_400) != 0)
                {
                    const fx32 z = MultiplyFX(position->z, g_obj.depth);

                    animator->position[c].y = animator->position[c].y + FX_Whole(z);
                }
            }

            if ((copyDisplayFlagPtr & DISPLAY_FLAG_DISABLE_POSITION_OFFSETS) == 0)
            {
                animator->position[c].x += g_obj.offset[0];
                animator->position[c].y += g_obj.offset[1];
            }
        }
    }

    backupAnimAdvance          = animator->work.animAdvance;
    animator->work.animAdvance = MultiplyFX(animator->work.animAdvance, g_obj.speed);

    if (copyDisplayFlagPtr & DISPLAY_FLAG_PAUSED)
    {
        animator->work.animAdvance = FLOAT_TO_FX32(0.0);
    }

    if ((copyDisplayFlagPtr & DISPLAY_FLAG_NO_ANIMATE_CB) == 0)
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
        animator->position[0].x = MultiplyFX(animator->position[0].x - 128, g_obj.scale.x) + 128;
        animator->position[1].x = MultiplyFX(animator->position[1].x - 128, g_obj.scale.x) + 128;
    }

    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
    {
        animator->position[0].y = MultiplyFX(animator->position[0].y - 96, g_obj.scale.y) + 96;
        animator->position[1].y = MultiplyFX(animator->position[1].y - 96, g_obj.scale.y) + 96;
    }

    if ((copyDisplayFlagPtr & DISPLAY_FLAG_NO_DRAW) == 0)
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
            work->obj_2d->ani.screensToDraw |= SCREEN_DRAW_A;
    }

    StageTask__Draw3DEx(animator, &position, &direction, &work->scale, &work->displayFlag, work->obj_3des, (SpriteFrameCallback)StageTask__SpriteBlockCallback_Hitbox, work);
}

NONMATCH_FUNC void StageTask__Draw3DEx(Animator3D *animator, VecFx32 *position, VecU16 *dir, VecFx32 *scale, StageDisplayFlags *displayFlag, OBS_ACTION3D_ES_WORK *obj3d_es,
                                       SpriteFrameCallback callback, void *userData)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x104
	mov r5, r0
	add r6, sp, #0x68
	add r0, r5, #0x18
	mov r4, r1
	str r2, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	mov r0, #0
	mov r6, r0
	str r0, [sp, #0x2c]
	mov r0, r6
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x128]
	ldr r1, [r5, #0]
	str r0, [sp, #0x128]
	mov r7, r6
	ldr r0, [sp, #0x128]
	cmp r1, #1
	mov r8, r6
	moveq r6, r5
	cmp r1, #3
	addeq r7, r5, #0x90
	streq r5, [sp, #0x1c]
	cmp r0, #0
	ldrne r8, [r0, #0]
	mov r11, r3
	cmp r7, #0
	beq _020722A8
	ldr r0, [r7, #0x3c]
	tst r8, #4
	bic r0, r0, #0x184
	str r0, [r7, #0x3c]
	ldrne r0, [r7, #0x3c]
	orrne r0, r0, #4
	strne r0, [r7, #0x3c]
	tst r8, #1
	ldrne r0, [r7, #0x3c]
	orrne r0, r0, #0x80
	strne r0, [r7, #0x3c]
	tst r8, #2
	beq _020722BC
	ldr r0, [r7, #0x3c]
	orr r0, r0, #0x100
	str r0, [r7, #0x3c]
	b _020722BC
_020722A8:
	tst r8, #1
	movne r0, #0xc000
	strne r0, [sp, #0x2c]
	moveq r0, #0x4000
	streq r0, [sp, #0x2c]
_020722BC:
	cmp r6, #0
	beq _02072314
	mov r2, #0
_020722C8:
	add r0, r6, r2, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0xc]
	add r2, r2, #1
	cmp r2, #5
	bic r1, r1, #3
	strh r1, [r0, #0xc]
	blo _020722C8
	tst r8, #4
	beq _02072314
	mov r2, #0
_020722F4:
	add r0, r6, r2, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0xc]
	add r2, r2, #1
	cmp r2, #5
	orr r1, r1, #2
	strh r1, [r0, #0xc]
	blo _020722F4
_02072314:
	bic r8, r8, #8
	tst r8, #0x800
	mov r10, #0
	beq _020723C0
	tst r8, #1
	beq _02072370
	ldr r0, =obj_ptcb
	ldrh r0, [r0, #0x60]
	cmp r0, #0
	bls _02072400
	ldr r9, =g_obj
_02072340:
	ldrsh r1, [r9, #0x44]
	ldrsh r2, [r9, #0x46]
	ldrsh r3, [r9, #0x48]
	mov r0, r10
	bl NNS_G3dGlbLightVector
	ldr r0, =obj_ptcb
	add r10, r10, #1
	ldrh r0, [r0, #0x60]
	add r9, r9, #6
	cmp r10, r0
	blo _02072340
	b _02072400
_02072370:
	ldr r0, =obj_ptcb
	ldrh r0, [r0, #0x60]
	cmp r0, #0
	bls _02072400
	ldr r9, =g_obj
_02072384:
	ldrsh r1, [r9, #0x44]
	ldrsh r2, [r9, #0x46]
	ldrsh r3, [r9, #0x48]
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r0, r10
	mov r1, r1, asr #0x10
	bl NNS_G3dGlbLightVector
	ldr r0, =obj_ptcb
	add r10, r10, #1
	ldrh r0, [r0, #0x60]
	add r9, r9, #6
	cmp r10, r0
	blo _02072384
	b _02072400
_020723C0:
	ldr r0, =obj_ptcb
	ldrh r0, [r0, #0x60]
	cmp r0, #0
	bls _02072400
	ldr r9, =g_obj
_020723D4:
	ldrsh r1, [r9, #0x44]
	ldrsh r2, [r9, #0x46]
	ldrsh r3, [r9, #0x48]
	mov r0, r10
	bl NNS_G3dGlbLightVector
	ldr r0, =obj_ptcb
	add r10, r10, #1
	ldrh r0, [r0, #0x60]
	add r9, r9, #6
	cmp r10, r0
	blo _020723D4
_02072400:
	ands r9, r8, #0x2000
	bne _02072568
	mov r0, #0
	str r0, [sp, #0x40]
	str r0, [sp, #0x3c]
	ldr r0, =obj_ptcb
	ldr r1, [r0, #0x2c]
	tst r1, #8
	beq _02072458
	tst r8, #0x80
	bne _02072458
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02072448
	add r0, sp, #0x40
	add r1, sp, #0x3c
	blx r2
	b _02072458
_02072448:
	ldr r1, [r0, #0x30]
	ldr r0, [r0, #0x34]
	str r1, [sp, #0x40]
	str r0, [sp, #0x3c]
_02072458:
	tst r8, #0x4000
	ldr r1, [r4, #0]
	ldr r0, [sp, #0x40]
	sub r0, r1, r0
	str r0, [r5, #0x48]
	ldr r1, [r4, #4]
	ldr r0, [sp, #0x3c]
	sub r0, r1, r0
	rsb r0, r0, #0
	str r0, [r5, #0x4c]
	ldr r0, [r4, #8]
	str r0, [r5, #0x50]
	bne _020724B0
	ldr r2, [r5, #0x48]
	ldr r0, =obj_ptcb
	ldrsh r1, [r0, #0x10]
	add r1, r2, r1, lsl #12
	str r1, [r5, #0x48]
	ldrsh r0, [r0, #0x12]
	ldr r1, [r5, #0x4c]
	add r0, r1, r0, lsl #12
	str r0, [r5, #0x4c]
_020724B0:
	ldr r0, =obj_ptcb
	ldr r1, [r0, #0x2c]
	tst r1, #0x400
	beq _020724F4
	ldr r1, [r4, #8]
	mov r1, r1, lsl #1
	str r1, [r5, #0x50]
	ldr r2, [r4, #8]
	ldr r1, [r0, #0x20]
	ldr r0, [r5, #0x4c]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r0, r0, r2
	str r0, [r5, #0x4c]
_020724F4:
	ldr r0, =obj_ptcb
	ldr r1, [r0, #4]
	cmp r1, #0x1000
	beq _02072528
	ldr r0, [r5, #0x48]
	sub r0, r0, #0x80000
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x80000
	str r0, [r5, #0x48]
_02072528:
	ldr r0, =obj_ptcb
	ldr r2, [r0, #8]
	cmp r2, #0x1000
	beq _02072568
	ldr r1, [r5, #0x4c]
	mov r0, #0x60000
	rsb r0, r0, #0
	sub r0, r0, r1
	smull r2, r1, r0, r2
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x60000
	rsb r0, r0, #0
	str r0, [r5, #0x4c]
_02072568:
	tst r8, #0x100
	cmpeq r9, #0
	bne _020726BC
	add r0, r5, #0x24
	bl MTX_Identity33_
	ldr r0, [sp, #0x2c]
	ldr r3, =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	mov r4, r1, lsl #1
	add r1, r1, #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x44
	blx MTX_RotY33_
	add r0, r5, #0x24
	add r1, sp, #0x44
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [sp, #0x14]
	ldr r3, =FX_SinCosTable_
	ldrh r1, [r0, #0]
	add r0, sp, #0x44
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotX33_
	add r0, r5, #0x24
	add r1, sp, #0x44
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [sp, #0x14]
	ldr r3, =FX_SinCosTable_
	ldrh r1, [r0, #2]
	add r0, sp, #0x44
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	add r0, r5, #0x24
	add r1, sp, #0x44
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [sp, #0x14]
	ldr r3, =FX_SinCosTable_
	ldrh r1, [r0, #4]
	add r0, sp, #0x44
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	add r0, r5, #0x24
	add r1, sp, #0x44
	mov r2, r0
	bl MTX_Concat33
_020726BC:
	mov r2, #0x1000
	mov r3, r2
	mov r4, r2
	cmp r11, #0
	beq _02072710
	ldr r0, =obj_ptcb
	ldr r2, [r11, #0]
	ldr r3, [r0, #4]
	ldr r1, [r0, #8]
	ldr r0, [r11, #4]
	smull r4, r2, r3, r2
	smull r3, r0, r1, r0
	adds r4, r4, #0x800
	adc r1, r2, #0
	mov r2, r4, lsr #0xc
	orr r2, r2, r1, lsl #20
	adds r1, r3, #0x800
	adc r0, r0, #0
	mov r3, r1, lsr #0xc
	orr r3, r3, r0, lsl #20
	ldr r4, [r11, #8]
_02072710:
	ldr r1, [r5, #0x20]
	ldr r0, [r5, #0x1c]
	smull r10, r9, r1, r4
	adds r1, r10, #0x800
	smull r4, r3, r0, r3
	adc r0, r9, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r4, #0x800
	adc r3, r3, #0
	mov r0, r0, lsr #0xc
	orr r0, r0, r3, lsl #20
	ldr r3, [r5, #0x18]
	smull r4, r2, r3, r2
	adds r3, r4, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r5, #0x18]
	str r0, [r5, #0x1c]
	ands r0, r8, #0x200
	str r1, [r5, #0x20]
	str r0, [sp, #0x18]
	beq _020728CC
	ldr r0, =obj_ptcb
	ldr r2, =FX_SinCosTable_
	ldr r4, [r0, #0x40]
	ldrh r0, [r4, #0]
	ldr r9, [r4, #4]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	mov r0, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r0, [r2, r0]
	ldrsh r1, [r2, r1]
	bl FX_Div
	smull r2, r1, r0, r9
	adds r0, r2, #0x800
	adc r1, r1, #0
	mov r0, r0, lsr #0xc
	orr r0, r0, r1, lsl #20
	str r0, [sp, #0x30]
	ldr r2, [r4, #0xc]
	ldr r1, [sp, #0x30]
	ldr r0, [r4, #4]
	smull r3, r2, r1, r2
	adds r1, r3, #0x800
	adc r2, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r2, lsl #20
	str r1, [sp, #0x34]
	ldr r1, =obj_ptcb
	ldr r1, [r1, #0x40]
	ldr r1, [r1, #0x28]
	bl FX_Div
	ldr r1, [r5, #0x4c]
	ldr r10, =NNS_G3dGlb+0x00000008
	add r1, r1, #0x60000
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	mov ip, r2, lsr #0xc
	adc r1, r1, #0
	ldr r2, [r5, #0x48]
	orr ip, ip, r1, lsl #20
	mov r1, #0x80000
	str r1, [r5, #0x48]
	sub r1, r1, #0xe0000
	rsb r2, r2, #0x80000
	str r1, [r5, #0x4c]
	smull r2, r1, r0, r2
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov lr, r2, lsr #0xc
	orr lr, lr, r0, lsl #20
	ldr r0, [sp, #0x30]
	add r9, sp, #0x74
	add r0, r0, ip
	str r0, [sp, #0x38]
	ldmia r10!, {r0, r1, r2, r3}
	stmia r9!, {r0, r1, r2, r3}
	ldmia r10!, {r0, r1, r2, r3}
	stmia r9!, {r0, r1, r2, r3}
	ldmia r10!, {r0, r1, r2, r3}
	stmia r9!, {r0, r1, r2, r3}
	ldmia r10, {r0, r1, r2, r3}
	stmia r9, {r0, r1, r2, r3}
	ldr r9, [r4, #4]
	ldr r0, [sp, #0x30]
	str r9, [sp]
	ldr r4, [r4, #8]
	ldr r1, [sp, #0x38]
	str r4, [sp, #4]
	mov r4, #0x1000
	ldr r2, [sp, #0x34]
	ldr r3, [sp, #0x34]
	str r4, [sp, #8]
	mov r4, #0
	str r4, [sp, #0xc]
	ldr r4, =NNS_G3dGlb+0x00000008
	sub r0, r0, ip
	rsb r1, r1, #0
	sub r2, lr, r2
	add r3, r3, lr
	str r4, [sp, #0x10]
	bl G3i_FrustumW_
	ldr r0, =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #0x50
	str r1, [r0, #0xfc]
	b _02072968
_020728CC:
	tst r8, #0x20000
	beq _02072968
	ldr r0, =obj_ptcb
	add r9, sp, #0xb4
	ldr r10, [r0, #0x40]
	mov r4, #5
_020728E4:
	subs r4, r4, #1
	ldmia r10!, {r0, r1, r2, r3}
	stmia r9!, {r0, r1, r2, r3}
	bne _020728E4
	mov r2, #0x3f00
	mov r0, r2, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	strh r2, [sp, #0xb4]
	ldr r2, =FX_SinCosTable_
	mov r0, r0, lsl #1
	mov r1, r1, lsl #1
	ldrsh r0, [r2, r0]
	ldrsh r1, [r2, r1]
	mov r2, #0x80000
	str r2, [sp, #0xe0]
	str r2, [sp, #0xd4]
	sub r2, r2, #0xe0000
	str r2, [sp, #0xe4]
	str r2, [sp, #0xd8]
	mov r2, #0
	str r2, [sp, #0xe8]
	bl FX_Div
	mov r2, #0
	mov r1, #0x60
	mul r1, r0, r1
	mov r0, #0x1000
	str r0, [sp, #0xf0]
	add r0, sp, #0xb4
	str r1, [sp, #0xdc]
	str r2, [sp, #0xec]
	str r2, [sp, #0xf4]
	bl Camera3D__LoadState
_02072968:
	cmp r6, #0
	beq _020729C4
	ldr r2, =obj_ptcb
	ldr r0, [r6, #0x118]
	ldr r3, [r2, #0x14]
	str r0, [sp, #0x24]
	smull r4, r3, r0, r3
	adds r4, r4, #0x800
	adc r0, r3, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r1, r6, #0x100
	str r3, [r6, #0x118]
	ldrsh r0, [r1, #0x30]
	str r0, [sp, #0x20]
	ldr r2, [r2, #0x14]
	mov r0, r0
	smull r3, r2, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	strh r2, [r1, #0x30]
_020729C4:
	cmp r7, #0
	beq _020729F4
	ldr r1, =obj_ptcb
	ldr r0, [r7, #0x38]
	ldr r1, [r1, #0x14]
	str r0, [sp, #0x28]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r7, #0x38]
_020729F4:
	tst r8, #0x10
	beq _02072A14
	cmp r6, #0
	movne r0, #0
	strne r0, [r6, #0x118]
	cmp r7, #0
	movne r0, #0
	strne r0, [r7, #0x38]
_02072A14:
	tst r8, #0x1000
	bne _02072A9C
	cmp r6, #0
	ldrne r0, [r6, #0xc4]
	cmpne r0, #0
	ldrne r0, [r6, #0x90]
	orrne r0, r0, #1
	strne r0, [r6, #0x90]
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	beq _02072A50
	ldr r1, [sp, #0x130]
	ldr r2, [sp, #0x134]
	bl AnimatorSprite3D__ProcessAnimation
	b _02072AAC
_02072A50:
	ldr r0, [r5, #0]
	cmp r0, #1
	beq _02072A70
	cmp r0, #2
	beq _02072A7C
	cmp r0, #3
	beq _02072A88
	b _02072AAC
_02072A70:
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	b _02072AAC
_02072A7C:
	mov r0, r5
	bl AnimatorShape3D__ProcessAnimation
	b _02072AAC
_02072A88:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	b _02072AAC
_02072A9C:
	cmp r6, #0
	ldrne r0, [r6, #0x90]
	bicne r0, r0, #1
	strne r0, [r6, #0x90]
_02072AAC:
	cmp r7, #0
	ldrne r0, [sp, #0x28]
	strne r0, [r7, #0x38]
	cmp r6, #0
	beq _02072AD4
	ldr r0, [sp, #0x24]
	add r1, r6, #0x100
	str r0, [r6, #0x118]
	ldr r0, [sp, #0x20]
	strh r0, [r1, #0x30]
_02072AD4:
	tst r8, #0x20
	bne _02072BCC
	ldr r4, [sp, #0x12c]
	cmp r4, #0
	beq _02072B8C
_02072AE8:
	cmp r4, #0
	beq _02072BCC
	ldr r0, [r4, #0xac]
	tst r0, #0x80
	bne _02072B84
	ldr r2, [r5, #0x20]
	ldr r1, [r5, #0x1c]
	ldr r0, [r5, #0x18]
	str r0, [r4, #0x18]
	str r1, [r4, #0x1c]
	str r2, [r4, #0x20]
	ldr r2, [r5, #0x50]
	ldr r1, [r5, #0x4c]
	ldr r0, [r5, #0x48]
	str r0, [r4, #0x48]
	str r1, [r4, #0x4c]
	str r2, [r4, #0x50]
	ldr r0, [r4, #0xac]
	tst r0, #0x40
	bne _02072B44
	add r0, r5, #0x24
	add r1, r4, #0x24
	bl MI_Copy36B
_02072B44:
	ldr r0, [r4, #0]
	cmp r0, #1
	beq _02072B64
	cmp r0, #2
	beq _02072B70
	cmp r0, #3
	beq _02072B7C
	b _02072B84
_02072B64:
	mov r0, r4
	bl AnimatorMDL__Draw
	b _02072B84
_02072B70:
	mov r0, r4
	bl AnimatorShape3D__Draw
	b _02072B84
_02072B7C:
	mov r0, r4
	bl AnimatorSprite3D__Draw
_02072B84:
	ldr r4, [r4, #0xa0]
	b _02072AE8
_02072B8C:
	ldr r0, [r5, #0]
	cmp r0, #1
	beq _02072BAC
	cmp r0, #2
	beq _02072BB8
	cmp r0, #3
	beq _02072BC4
	b _02072BCC
_02072BAC:
	mov r0, r5
	bl AnimatorMDL__Draw
	b _02072BCC
_02072BB8:
	mov r0, r5
	bl AnimatorShape3D__Draw
	b _02072BCC
_02072BC4:
	mov r0, r5
	bl AnimatorSprite3D__Draw
_02072BCC:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _02072C00
	ldr r4, =NNS_G3dGlb+0x00000008
	add r9, sp, #0x74
	ldmia r9!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r9!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r9!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r9, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
_02072C00:
	tst r8, #0x20000
	beq _02072C14
	ldr r0, =obj_ptcb
	ldr r0, [r0, #0x40]
	bl Camera3D__LoadState
_02072C14:
	cmp r6, #0
	beq _02072C38
	add r0, r6, #0x100
	ldrh r0, [r0, #0xc]
	tst r0, #0x4000
	bicne r8, r8, #0x400
	tst r0, #0x8000
	bicne r0, r8, #0x400
	orrne r8, r0, #8
_02072C38:
	cmp r7, #0
	beq _02072C4C
	ldr r0, [r7, #0x3c]
	tst r0, #0x40000000
	orrne r8, r8, #8
_02072C4C:
	cmp r11, #0
	beq _02072C64
	add r0, sp, #0x68
	add r3, r5, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02072C64:
	ldr r0, [sp, #0x128]
	cmp r0, #0
	strne r8, [r0]
	add sp, sp, #0x104
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
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
                    work->colliderList[c]->flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
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
        if (work->collisionObj->work.riderObj != NULL && (work->collisionObj->work.riderObj->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
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

            if ((work->collisionObj->work.toucherObj->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
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

        if ((work->touchObj->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
            work->touchObj = NULL;
    }

    if (work->rideObj != NULL)
    {
        if ((work->rideObj->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
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
    if ((work->flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) == 0 && (g_obj.flag & OBJECTMANAGER_FLAG_40) != 0
        && (work->flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
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

NONMATCH_FUNC BOOL StageTask__ViewOutCheck(fx32 x, fx32 y, s32 offset, s16 sLeft, s16 sTop, s16 sRight, s16 sBottom)
{
    // https://decomp.me/scratch/Dm8eK -> 73.65%
#ifdef NON_MATCHING
    s16 lcdWidth  = HW_LCD_WIDTH;
    s16 lcdHeight = HW_LCD_HEIGHT;

    if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
        lcdWidth = MultiplyFX(HW_LCD_WIDTH, (FLOAT_TO_FX32(2.0) - g_obj.scale.x));

    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
        lcdHeight = MultiplyFX(HW_LCD_HEIGHT, (FLOAT_TO_FX32(2.0) - g_obj.scale.y));

    if ((g_obj.flag & OBJECTMANAGER_FLAG_8) == 0)
        return FALSE;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_800) != 0)
    {
        fx32 rectX;
        fx32 rectY;

        fx32 sizeY;
        if (g_obj.camera[0].y < g_obj.camera[1].y)
        {
            sizeY = lcdHeight + (FX32_TO_WHOLE(g_obj.camera[1].y) - FX32_TO_WHOLE(g_obj.camera[0].y));
            rectX = FX32_TO_WHOLE(g_obj.camera[0].x) - offset;
            rectY = FX32_TO_WHOLE(g_obj.camera[0].y) - offset;
        }
        else
        {
            sizeY = lcdHeight + (FX32_TO_WHOLE(g_obj.camera[0].y) - FX32_TO_WHOLE(g_obj.camera[1].y));
            rectX = FX32_TO_WHOLE(g_obj.camera[1].x) - offset;
            rectY = FX32_TO_WHOLE(g_obj.camera[1].y) - offset;
        }

        if (rectX + sLeft <= FX32_TO_WHOLE(x) && rectX + sLeft + ((lcdWidth + (offset << 1)) + sRight - sLeft) >= FX32_TO_WHOLE(x) && rectY + sTop <= FX32_TO_WHOLE(y)
            && rectY + sBottom + (sizeY + (offset << 1)) >= FX32_TO_WHOLE(y))
            return FALSE;
    }
    else
    {
        fx32 rectX = FX32_TO_WHOLE(g_obj.camera[0].x) - offset + sLeft;
        fx32 rectY = FX32_TO_WHOLE(g_obj.camera[0].y) - offset + sTop;

        fx32 height = lcdHeight + (offset << 1) + (-sTop + sBottom);
        fx32 width  = lcdWidth + (offset << 1) + (-sLeft + sRight);

        if (rectX <= FX32_TO_WHOLE(x) && rectX + width >= FX32_TO_WHOLE(x) && rectY <= FX32_TO_WHOLE(y) && rectY + height >= FX32_TO_WHOLE(y))
            return FALSE;

        rectY = FX32_TO_WHOLE(g_obj.camera[1].y) - offset + sTop;
        rectX = FX32_TO_WHOLE(g_obj.camera[1].x) - offset + sLeft;
        if (rectX <= FX32_TO_WHOLE(x) && rectX + width >= FX32_TO_WHOLE(x) && rectY <= FX32_TO_WHOLE(y) && rectY + height >= FX32_TO_WHOLE(y))
            return FALSE;
    }

    return TRUE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r4, =obj_ptcb
	ldr ip, [sp, #0x20]
	ldr r4, [r4, #4]
	mov r7, #0x100
	cmp r4, #0x1000
	mov r8, #0xc0
	beq _0207359C
	rsb r5, r4, #0x2000
	mov r4, r5, asr #0x1f
	mov r6, r4, lsl #8
	mov r4, #0x800
	adds r7, r4, r5, lsl #8
	orr r6, r6, r5, lsr #24
	adc r4, r6, #0
	mov r5, r7, lsr #0xc
	orr r5, r5, r4, lsl #20
	mov r4, r5, lsl #0x10
	mov r7, r4, asr #0x10
_0207359C:
	ldr r4, =obj_ptcb
	ldr r4, [r4, #8]
	cmp r4, #0x1000
	beq _020735E0
	rsb r6, r4, #0x2000
	mov r4, #0xc0
	umull r9, r8, r6, r4
	mov r5, #0
	mla r8, r6, r5, r8
	mov r5, r6, asr #0x1f
	adds r6, r9, #0x800
	mla r8, r5, r4, r8
	adc r4, r8, #0
	mov r5, r6, lsr #0xc
	orr r5, r5, r4, lsl #20
	mov r4, r5, lsl #0x10
	mov r8, r4, asr #0x10
_020735E0:
	ldr r6, =obj_ptcb
	ldr r4, [r6, #0x2c]
	tst r4, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	tst r4, #0x800
	beq _02073698
	ldr r5, [r6, #0x3c]
	ldr r4, [r6, #0x34]
	cmp r4, r5
	bge _02073628
	mov r5, r5, asr #0xc
	sub r5, r5, r4, asr #12
	ldr r6, [r6, #0x30]
	add r8, r8, r5
	rsb r6, r2, r6, asr #12
	rsb r4, r2, r4, asr #12
	b _02073640
_02073628:
	mov r4, r4, asr #0xc
	ldr r6, [r6, #0x38]
	sub r4, r4, r5, asr #12
	add r8, r8, r4
	rsb r6, r2, r6, asr #12
	rsb r4, r2, r5, asr #12
_02073640:
	add r5, r7, r2, lsl #1
	add lr, r8, r2, lsl #1
	ldrsh r8, [sp, #0x28]
	add r2, r6, r3
	ldrsh r7, [sp, #0x24]
	sub r6, r8, ip
	cmp r2, r0, asr #12
	sub r3, r7, r3
	add r7, r4, ip
	add r4, lr, r6
	add r3, r5, r3
	bgt _02073744
	add r2, r2, r3
	cmp r2, r0, asr #12
	blt _02073744
	cmp r7, r1, asr #12
	bgt _02073744
	add r0, r7, r4
	cmp r0, r1, asr #12
	blt _02073744
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02073698:
	ldr r5, [r6, #0x30]
	ldrsh lr, [sp, #0x28]
	ldrsh r9, [sp, #0x24]
	ldr r4, [r6, #0x34]
	rsb r5, r2, r5, asr #12
	rsb r6, r2, r4, asr #12
	add r4, r5, r3
	add r5, r7, r2, lsl #1
	sub r7, r9, r3
	add r10, r8, r2, lsl #1
	sub r8, lr, ip
	cmp r4, r0, asr #12
	add r9, r6, ip
	add r6, r10, r8
	add r5, r5, r7
	bgt _020736FC
	add r4, r4, r5
	cmp r4, r0, asr #12
	blt _020736FC
	cmp r9, r1, asr #12
	bgt _020736FC
	add r4, r9, r6
	cmp r4, r1, asr #12
	movge r0, #0
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020736FC:
	ldr r4, =obj_ptcb
	ldr r7, [r4, #0x38]
	ldr r4, [r4, #0x3c]
	rsb r7, r2, r7, asr #12
	rsb r4, r2, r4, asr #12
	add r2, r7, r3
	cmp r2, r0, asr #12
	add r3, r4, ip
	bgt _02073744
	add r2, r2, r5
	cmp r2, r0, asr #12
	blt _02073744
	cmp r3, r1, asr #12
	bgt _02073744
	add r0, r3, r6
	cmp r0, r1, asr #12
	movge r0, #0
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02073744:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
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
    work->colliderList[id]->hitPower = 0x40;
    work->colliderList[id]->defPower = 0x3F;
    work->colliderList[id]->hitFlag  = 2;
    work->colliderList[id]->defFlag  = 1;
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
                    work->colliderList[block->id]->flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
                }
                else
                {
                    if ((work->colliderList[block->id]->flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) == 0)
                        work->colliderList[block->id]->flag &= ~OBS_RECT_WORK_FLAG_200;

                    ObjRect__SetBox(work->colliderList[block->id], block->hitbox.left, block->hitbox.top, block->hitbox.right, block->hitbox.bottom);
                }
            }
        }
    }

    if (work->ppSpriteCallback != NULL)
        work->ppSpriteCallback((BACFrameGroupBlockHeader *)block, animator, work);
}

void StageTask__InitExWork(StageTask *work, ObjExWork *exWork)
{
    if (exWork == NULL)
    {
        if (work->ex_work != NULL)
        {
            exWork = work->ex_work;
        }
        else
        {
            exWork = (ObjExWork *)HeapAllocHead(HEAP_USER, sizeof(ObjExWork));
            MI_CpuClear8(exWork, sizeof(ObjExWork));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_EX_WORK;
        }
    }

    work->ex_work = exWork;
    ObjExWork__Init(exWork);
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