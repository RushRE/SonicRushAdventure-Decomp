#include <game/object/objTblWork.h>
#include <stage/stageTask.h>

// --------------------
// FUNCTION DECLS
// --------------------

extern void ProcessObjTblMove(StageTask *work, OBS_TBL_WORK *tblWork);
extern void ProcessObjTblSprite2D(StageTask *work, OBS_TBL_WORK *tblWork);
extern void ProcessObjTblScale(StageTask *work, OBS_TBL_WORK *tblWork);
extern void ProcessObjTblAngle(StageTask *work, OBS_TBL_WORK *tblWork);

// --------------------
// FUNCTIONS
// --------------------

void ObjObjectTblWork(StageTask *work)
{
    ObjTblWork(work, work->tbl_work);
}

void ObjTblWork(StageTask *work, OBS_TBL_WORK *tblWork)
{
    if ((tblWork->flags & OBD_TBLWORK_FLAG_USE_PARENT_FLIP) != 0)
    {
        tblWork->flags &= ~(OBD_TBLWORK_FLAG_MOVE_FLIP_X | OBD_TBLWORK_FLAG_MOVE_FLIP_Y);

        if ((work->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            tblWork->flags |= OBD_TBLWORK_FLAG_MOVE_FLIP_X;

        if ((work->displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            tblWork->flags |= OBD_TBLWORK_FLAG_MOVE_FLIP_Y;
    }

    if (tblWork->moveTbl != NULL)
        ProcessObjTblMove(work, tblWork);

    if (tblWork->sprite2DTbl != NULL)
        ProcessObjTblSprite2D(work, tblWork);

    if (tblWork->scaleTbl != NULL)
        ProcessObjTblScale(work, tblWork);

    if (tblWork->angleTbl != NULL)
        ProcessObjTblAngle(work, tblWork);
}

void InitObjTblWork(OBS_TBL_WORK *work)
{
    for (u16 i = 0; i < OBD_TBLWORK_TYPE_COUNT; i++)
    {
        work->frameID[i] = -1;
    }

    MI_CpuClear8(work->frameTimer, sizeof(work->frameTimer));
    MI_CpuClear8(&work->velocity, sizeof(work->velocity));

    work->flags &= ~(OBD_TBLWORK_FLAG_ANGLE_IS_FINISHED | OBD_TBLWORK_FLAG_SCALE_IS_FINISHED | OBD_TBLWORK_FLAG_MOVE_IS_FINISHED | OBD_TBLWORK_FLAG_SPRITE2D_IS_FINISHED);
    work->flags &= ~(OBD_TBLWORK_FLAG_CAN_LOOP);
}

void ObjTblWorkReset(OBS_TBL_WORK *work)
{
    for (u16 i = 0; i < OBD_TBLWORK_TYPE_COUNT; i++)
    {
        if (work->dataWork[i] != NULL)
            ObjDataRelease(work->dataWork[i]);
    }
}

void ObjTblWorkMoveSet(OBS_TBL_WORK *work, OBS_MOVE_TBL *moveTbl)
{
    work->moveTbl = moveTbl;
}
