#include <game/object/objTblWork.h>
#include <stage/stageTask.h>

// --------------------
// FUNCTION DECLS
// --------------------

void ProcessObjTblMove(StageTask *work, OBS_TBL_WORK *tblWork);
void ProcessObjTblSprite2D(StageTask *work, OBS_TBL_WORK *tblWork);
void ProcessObjTblScale(StageTask *work, OBS_TBL_WORK *tblWork);
void ProcessObjTblAngle(StageTask *work, OBS_TBL_WORK *tblWork);

// --------------------
// FUNCTIONS
// --------------------

void ProcessObjTblMove(StageTask *work, OBS_TBL_WORK *tblWork)
{
    OBS_MOVE_TBL *moveTbl = tblWork->moveTbl;

    if (work->hitstopTimer == 0)
    {
        tblWork->flags &= ~OBD_TBLWORK_FLAG_MOVE_IS_FINISHED;

        if (tblWork->frameTimer[OBD_TBLWORK_TYPE_MOVE] == 0)
        {
            tblWork->frameID[OBD_TBLWORK_TYPE_MOVE]++;
            tblWork->frameTimer[OBD_TBLWORK_TYPE_MOVE] = moveTbl[tblWork->frameID[OBD_TBLWORK_TYPE_MOVE]].timer;

            if (tblWork->frameTimer[OBD_TBLWORK_TYPE_MOVE] == 0)
            {
                tblWork->flags |= OBD_TBLWORK_FLAG_MOVE_IS_FINISHED;

                if ((tblWork->flags & OBD_TBLWORK_FLAG_CAN_LOOP) != 0)
                {
                    tblWork->frameID[OBD_TBLWORK_TYPE_MOVE]    = tblWork->loopPoint[OBD_TBLWORK_TYPE_MOVE];
                    tblWork->frameTimer[OBD_TBLWORK_TYPE_MOVE] = moveTbl[tblWork->frameID[OBD_TBLWORK_TYPE_MOVE]].timer;
                }
                else
                {
                    tblWork->frameID[OBD_TBLWORK_TYPE_MOVE]--;
                    return;
                }
            }

            if ((moveTbl[tblWork->frameID[OBD_TBLWORK_TYPE_MOVE]].flag & OBS_MOVE_TBL_FLAG_IS_LOOP_POINT) != 0)
                tblWork->loopPoint[OBD_TBLWORK_TYPE_MOVE] = tblWork->frameID[OBD_TBLWORK_TYPE_MOVE];

            if ((tblWork->flags & OBD_TBLWORK_FLAG_NO_MOVE) == 0)
            {
                VecFx32 velocity;
                VEC_Set(&velocity, moveTbl[tblWork->frameID[1]].velocity.x, moveTbl[tblWork->frameID[1]].velocity.y, moveTbl[tblWork->frameID[1]].velocity.z);

                // Calculate velocity
                {
                    if (tblWork->scale.x != FLOAT_TO_FX32(0.0) || tblWork->scale.y != FLOAT_TO_FX32(0.0) || tblWork->scale.z != FLOAT_TO_FX32(0.0))
                    {
                        velocity.x = MultiplyFX(velocity.x, tblWork->scale.x);
                        velocity.y = MultiplyFX(velocity.y, tblWork->scale.y);
                        velocity.z = MultiplyFX(velocity.z, tblWork->scale.z);
                    }

                    if (tblWork->angle.x | tblWork->angle.y | tblWork->angle.z)
                    {
                        FXMatrix33 matTemp;
                        FXMatrix33 matRotate;
                        MTX_Identity33(matRotate.nnMtx);

                        if (tblWork->angle.x != FLOAT_DEG_TO_IDX(0.0))
                        {
                            MTX_RotX33(matTemp.nnMtx, SinFX((s32)(u16)tblWork->angle.x), CosFX((s32)(u16)tblWork->angle.x));
                            MTX_Concat33(matRotate.nnMtx, matTemp.nnMtx, matRotate.nnMtx);
                        }

                        if (tblWork->angle.y != FLOAT_DEG_TO_IDX(0.0))
                        {
                            MTX_RotY33(matTemp.nnMtx, SinFX((s32)(u16)tblWork->angle.y), CosFX((s32)(u16)tblWork->angle.y));
                            MTX_Concat33(matRotate.nnMtx, matTemp.nnMtx, matRotate.nnMtx);
                        }

                        if (tblWork->angle.z != FLOAT_DEG_TO_IDX(0.0))
                        {
                            MTX_RotZ33(matTemp.nnMtx, SinFX((s32)(u16)tblWork->angle.z), CosFX((s32)(u16)tblWork->angle.z));
                            MTX_Concat33(matRotate.nnMtx, matTemp.nnMtx, matRotate.nnMtx);
                        }

                        MTX_MultVec33(&velocity, matRotate.nnMtx, &velocity);
                    }

                    if ((tblWork->flags & OBD_TBLWORK_FLAG_MOVE_FLIP_X) != 0)
                        velocity.x = -velocity.x;

                    if ((tblWork->flags & OBD_TBLWORK_FLAG_MOVE_FLIP_Y) != 0)
                        velocity.y = -velocity.y;
                }

                if ((tblWork->flags & OBD_TBLWORK_FLAG_MOVE_PARENT) != 0)
                {
                    VEC_Set(&tblWork->velocity, velocity.x, velocity.y, velocity.z);
                }
                else
                {
                    VEC_Set(&work->velocity, velocity.x, velocity.y, velocity.z);
                }
            }
        }

        if ((tblWork->flags & OBD_TBLWORK_FLAG_NO_MOVE) == 0)
        {
            VecFx32 velocity;
            VEC_Set(&velocity, moveTbl[tblWork->frameID[1]].acceleration.x, moveTbl[tblWork->frameID[1]].acceleration.y, moveTbl[tblWork->frameID[1]].acceleration.z);

            // Calculate velocity
            {
                if (tblWork->scale.x != FLOAT_TO_FX32(0.0) || tblWork->scale.y != FLOAT_TO_FX32(0.0) || tblWork->scale.z != FLOAT_TO_FX32(0.0))
                {
                    velocity.x = MultiplyFX(velocity.x, tblWork->scale.x);
                    velocity.y = MultiplyFX(velocity.y, tblWork->scale.y);
                    velocity.z = MultiplyFX(velocity.z, tblWork->scale.z);
                }

                if (tblWork->angle.x | tblWork->angle.y | tblWork->angle.z)
                {
                    FXMatrix33 matTemp;
                    FXMatrix33 matRotate;
                    MTX_Identity33(matRotate.nnMtx);

                    if (tblWork->angle.x != FLOAT_DEG_TO_IDX(0.0))
                    {
                        MTX_RotX33(matTemp.nnMtx, SinFX((s32)(u16)tblWork->angle.x), CosFX((s32)(u16)tblWork->angle.x));
                        MTX_Concat33(matRotate.nnMtx, matTemp.nnMtx, matRotate.nnMtx);
                    }

                    if (tblWork->angle.y != FLOAT_DEG_TO_IDX(0.0))
                    {
                        MTX_RotY33(matTemp.nnMtx, SinFX((s32)(u16)tblWork->angle.y), CosFX((s32)(u16)tblWork->angle.y));
                        MTX_Concat33(matRotate.nnMtx, matTemp.nnMtx, matRotate.nnMtx);
                    }

                    if (tblWork->angle.z != FLOAT_DEG_TO_IDX(0.0))
                    {
                        MTX_RotZ33(matTemp.nnMtx, SinFX((s32)(u16)tblWork->angle.z), CosFX((s32)(u16)tblWork->angle.z));
                        MTX_Concat33(matRotate.nnMtx, matTemp.nnMtx, matRotate.nnMtx);
                    }

                    MTX_MultVec33(&velocity, matRotate.nnMtx, &velocity);
                }

                if ((tblWork->flags & OBD_TBLWORK_FLAG_MOVE_FLIP_X) != 0)
                    velocity.x = -velocity.x;

                if ((tblWork->flags & OBD_TBLWORK_FLAG_MOVE_FLIP_Y) != 0)
                    velocity.y = -velocity.y;
            }

            if ((tblWork->flags & OBD_TBLWORK_FLAG_MOVE_PARENT) != 0)
            {
                VEC_Add(&work->lockOffset, &tblWork->velocity, &work->lockOffset);
                VEC_Add(&tblWork->velocity, &velocity, &tblWork->velocity);
            }
            else
            {
                VEC_Add(&work->velocity, &velocity, &work->velocity);
            }
        }

        tblWork->frameTimer[OBD_TBLWORK_TYPE_MOVE]--;
    }
}

void ProcessObjTblSprite2D(StageTask *work, OBS_TBL_WORK *tblWork)
{
    OBS_ACT_TBL *sprite2DTbl = tblWork->sprite2DTbl;

    tblWork->flags &= ~OBD_TBLWORK_FLAG_SPRITE2D_IS_FINISHED;

    if (tblWork->frameTimer[OBD_TBLWORK_TYPE_SPRITE2D] == 0)
    {
        tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]++;
        tblWork->frameTimer[OBD_TBLWORK_TYPE_SPRITE2D] = sprite2DTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]].timer;

        if (tblWork->frameTimer[OBD_TBLWORK_TYPE_SPRITE2D] == 0)
        {
            tblWork->flags |= OBD_TBLWORK_FLAG_SPRITE2D_IS_FINISHED;

            if ((tblWork->flags & OBD_TBLWORK_FLAG_CAN_LOOP) != 0)
            {
                tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]    = tblWork->loopPoint[OBD_TBLWORK_TYPE_SPRITE2D];
                tblWork->frameTimer[OBD_TBLWORK_TYPE_SPRITE2D] = sprite2DTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]].timer;
            }
            else
            {
                tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]--;
                return;
            }
        }

        if ((sprite2DTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]].flag & OBS_ACT_TBL_FLAG_IS_LOOP_POINT) != 0)
            tblWork->loopPoint[OBD_TBLWORK_TYPE_SPRITE2D] = tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D];

        if ((tblWork->flags & OBD_TBLWORK_FLAG_NO_SPRITE2D) == 0)
        {
            StageTask__SetAnimation(work, sprite2DTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]].animID);

            if ((sprite2DTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SPRITE2D]].flag & OBS_ACT_TBL_FLAG_DISABLE_LOOPING) != 0)
                work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }

    tblWork->frameTimer[OBD_TBLWORK_TYPE_SPRITE2D]--;
}

void ProcessObjTblScale(StageTask *work, OBS_TBL_WORK *tblWork)
{
    OBS_SCALE_TBL *scaleTbl = tblWork->scaleTbl;

    tblWork->flags &= ~OBD_TBLWORK_FLAG_SCALE_IS_FINISHED;

    if (tblWork->frameTimer[OBD_TBLWORK_TYPE_SCALE] == 0)
    {
        tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]++;
        tblWork->frameTimer[OBD_TBLWORK_TYPE_SCALE] = scaleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]].timer;

        if (tblWork->frameTimer[OBD_TBLWORK_TYPE_SCALE] == 0)
        {
            tblWork->flags |= OBD_TBLWORK_FLAG_SCALE_IS_FINISHED;

            if ((tblWork->flags & OBD_TBLWORK_FLAG_CAN_LOOP) != 0)
            {
                tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]    = tblWork->loopPoint[OBD_TBLWORK_TYPE_SCALE];
                tblWork->frameTimer[OBD_TBLWORK_TYPE_SCALE] = scaleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]].timer;
            }
            else
            {
                tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]--;
                return;
            }
        }

        if ((scaleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]].flag & OBS_SCALE_TBL_FLAG_IS_LOOP_POINT) != 0)
            tblWork->loopPoint[OBD_TBLWORK_TYPE_SCALE] = tblWork->frameID[OBD_TBLWORK_TYPE_SCALE];

        if ((tblWork->flags & OBD_TBLWORK_FLAG_NO_SCALE) == 0)
        {
            VEC_Set(&work->scale, scaleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]].scale.x, scaleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]].scale.y,
                    scaleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_SCALE]].scale.z);
        }
    }

    tblWork->frameTimer[OBD_TBLWORK_TYPE_SCALE]--;
}

void ProcessObjTblAngle(StageTask *work, OBS_TBL_WORK *tblWork)
{
    OBS_DIR_TBL *angleTbl = tblWork->angleTbl;

    // BUG: this should be using OBD_TBLWORK_FLAG_ANGLE_IS_FINISHED
    tblWork->flags &= ~OBD_TBLWORK_FLAG_SPRITE2D_IS_FINISHED;

    if (tblWork->frameTimer[OBD_TBLWORK_TYPE_ANGLE] == 0)
    {
        tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]++;
        tblWork->frameTimer[OBD_TBLWORK_TYPE_ANGLE] = angleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]].timer;

        if (tblWork->frameTimer[OBD_TBLWORK_TYPE_ANGLE] == 0)
        {
            // BUG: this should be using OBD_TBLWORK_FLAG_ANGLE_IS_FINISHED
            tblWork->flags |= OBD_TBLWORK_FLAG_SPRITE2D_IS_FINISHED;

            if ((tblWork->flags & OBD_TBLWORK_FLAG_CAN_LOOP) != 0)
            {
                tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]    = tblWork->loopPoint[OBD_TBLWORK_TYPE_ANGLE];
                tblWork->frameTimer[OBD_TBLWORK_TYPE_ANGLE] = angleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]].timer;
            }
            else
            {
                tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]--;
                return;
            }
        }

        if ((angleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]].flag & OBS_ANGLE_TBL_FLAG_IS_LOOP_POINT) != 0)
            tblWork->loopPoint[OBD_TBLWORK_TYPE_ANGLE] = tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE];

        if ((tblWork->flags & OBD_TBLWORK_FLAG_NO_DIR) == 0)
        {
            work->dir.x = angleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]].dir.x;
            work->dir.y = angleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]].dir.y;
            work->dir.z = angleTbl[tblWork->frameID[OBD_TBLWORK_TYPE_ANGLE]].dir.z;
        }
    }

    tblWork->frameTimer[OBD_TBLWORK_TYPE_ANGLE]--;
}
