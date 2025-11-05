#include <ex/system/exUtils.h>
#include <ex/system/exMath.h>

// --------------------
// FUNCTION DECLS
// --------------------

static fx32 ExUtils_Func_21529C4(fx32 a1);

// --------------------
// FUNCTIONS
// --------------------

BOOL ExUtils_InitMissileMover(ExUtilMissileMover *work, VecFx32 *positionList, s32 positionListSize, s16 stepCount)
{
    if (work == NULL)
        return FALSE;
    if (positionList == NULL)
        return FALSE;
    if (stepCount <= 0)
        return FALSE;
    if (positionListSize <= 0)
        return FALSE;

    work->positionList     = positionList;
    work->positionListSize = positionListSize;
    work->stepCount        = stepCount;
    work->currentStep      = 0;
    work->prevPosition.x   = positionList[0].x;
    work->prevPosition.y   = positionList[0].y;
    work->prevPosition.z   = positionList[0].z;

    return TRUE;
}

fx32 ExUtils_Func_21529C4(fx32 a1)
{
    if (a1 < 0)
        a1 = -a1;

    if (a1 < FLOAT_TO_FX32(1.0))
    {
        return FX_Div(MultiplyFX(MultiplyFX(MultiplyFX(FLOAT_TO_FX32(3.0), a1), a1), a1) - MultiplyFX(MultiplyFX(FLOAT_TO_FX32(6.0), a1), a1) + FLOAT_TO_FX32(4.0),
                      FLOAT_TO_FX32(6.0));
    }

    if (a1 >= FLOAT_TO_FX32(2.0))
    {
        return FLOAT_TO_FX32(0.0);
    }

    fx32 value = a1 - FLOAT_TO_FX32(2.0);
    return FX_Div(MultiplyFX(MultiplyFX(-value, value), value), FLOAT_TO_FX32(6.0));
}

BOOL ExUtils_ProcessMissileMover(ExUtilMissileMover *work)
{
    if (work->currentStep >= work->stepCount)
    {
        work->currentPosition.x = work->positionList[work->positionListSize - 1].x;
        work->currentPosition.y = work->positionList[work->positionListSize - 1].y;
        work->currentPosition.z = work->positionList[work->positionListSize - 1].z;

        return TRUE;
    }

    s32 progress = (FX32_FROM_WHOLE(work->positionListSize + 1) / work->stepCount);
    progress *= work->currentStep;

    work->currentStep++;

    s32 startIndex = work->positionListSize;

    fx32 x = FLOAT_TO_FX32(0.0);
    fx32 y = FLOAT_TO_FX32(0.0);
    fx32 z = FLOAT_TO_FX32(0.0);

    for (s32 i = -2; i <= work->positionListSize + 1; i++)
    {
        s32 indexFx32 = i * FLOAT_TO_FX32(1.0);

        s32 index = i;
        if (i < 0)
            index = 0;

        if (i > startIndex - 1)
            index = startIndex - 1;

        fx32 amplitude = ExUtils_Func_21529C4((progress - FLOAT_TO_FX32(1.0)) - indexFx32);
        startIndex     = work->positionListSize;

        x += FX32_TO_WHOLE(amplitude * work->positionList[index].x);
        y += FX32_TO_WHOLE(amplitude * work->positionList[index].y);
        z += FX32_TO_WHOLE(amplitude * work->positionList[index].z);
    }
    work->currentPosition.x = x + 1;
    work->currentPosition.y = y + 1;
    work->currentPosition.z = z + 1;

    work->velocity.x = work->currentPosition.x - work->prevPosition.x;
    work->velocity.y = work->currentPosition.y - work->prevPosition.y;
    work->velocity.z = work->currentPosition.z - work->prevPosition.z;

    work->prevPosition.x = work->currentPosition.x;
    work->prevPosition.y = work->currentPosition.y;
    work->prevPosition.z = work->currentPosition.z;

    return FALSE;
}

void ExUtils_SetJointAnimation(EX_ACTION_NN_WORK *work, void *resModel, void *resTexture, NNSG3dResFileHeader *resJointAnim, u16 animID)
{
    work->model.animID = animID;
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, resJointAnim, work->model.animID, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }
}

void ExUtils_ResetRenderTransform(void)
{
    VecFx32 translation = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) };
    VecFx32 scale       = { FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0) };
    FXMatrix33 rotation;

    MTX_Identity33(rotation.nnMtx);
    NNS_G3dGlbSetBaseScale(&scale);
    NNS_G3dGlbSetBaseRot(rotation.nnMtx);
    NNS_G3dGlbSetBaseTrans(&translation);
}

void ExUtils_RotateOnAxis(VecU16 *angle, VecU16 *direction, VecU16 *velocity, s32 axis)
{
    switch (axis)
    {
        case EXUTIL_ROTATE_AXIS_X:
            switch (direction->x)
            {
                case EXUTIL_ROTATE_DIR_CW:
                    angle->x += 182 * velocity->x;
                    break;

                case EXUTIL_ROTATE_DIR_CCW:
                    angle->x -= 182 * velocity->x;
                    break;
            }
            break;

        case EXUTIL_ROTATE_AXIS_Y:
            switch (direction->y)
            {
                case EXUTIL_ROTATE_DIR_CW:
                    angle->y += 182 * velocity->y;
                    break;

                case EXUTIL_ROTATE_DIR_CCW:
                    angle->y -= 182 * velocity->y;
                    break;
            }
            break;

        case EXUTIL_ROTATE_AXIS_Z:
            switch (direction->z)
            {
                case EXUTIL_ROTATE_DIR_CW:
                    angle->z += 182 * velocity->z;
                    break;

                case EXUTIL_ROTATE_DIR_CCW:
                    angle->z -= 182 * velocity->z;
                    break;
            }
            break;
    }
}

u16 ExUtils_Atan2(fx32 y, fx32 x)
{
    float fxAtan = FX_Atan2(y, x);

    fxAtan /= 4096.0f;
    fxAtan *= 180.0f;
    fxAtan /= 3.1415f;
    fxAtan += 360.0f;

    return 182 * (u16)((u16)fxAtan % 360);
}

u16 ExUtils_RotateTowards(fx32 y, fx32 x, VecU16 *rotation, s16 *angle, u16 rotateSpeed)
{
    s16 rotateSpeedDiv = rotateSpeed / 182;

    u16 atanAngle = ExUtils_Atan2(y, x);
    s16 oldAngle  = *angle;
    s16 newAngle  = (atanAngle / 182);

    if (oldAngle - 180 > newAngle)
    {
        newAngle += 360;
        atanAngle += FLOAT_DEG_TO_IDX(360.0);
    }
    if (oldAngle + 180 < newAngle)
    {
        newAngle -= 360;
        atanAngle -= FLOAT_DEG_TO_IDX(360.0);
    }

    s16 angleDist = (oldAngle - newAngle);
    if (rotateSpeedDiv < angleDist)
    {
        rotation->y -= rotateSpeed;
        *angle -= rotateSpeedDiv;
    }
    else if (angleDist < -rotateSpeedDiv)
    {
        rotation->y += rotateSpeed;
        *angle += rotateSpeedDiv;
    }
    else
    {
        rotation->y = atanAngle;
        *angle      = newAngle;
    }

    return rotation->y;
}

void ExUtils_InitMeteorMover(ExUtilMeteorMover *work, VecFx32 *start, VecFx32 *target, float stepSize, float duration)
{
    work->stepSize = FloatToFx32(stepSize);

    fx32 progress    = FX_Sqrt(MultiplyFX(FX_Div(start->z - target->z, work->stepSize), FLOAT_TO_FX32(2.0)));
    work->progress.x = progress;
    work->progress.y = progress;
    work->progress.z = progress;

    work->step.x = FX_Div(target->x - start->x, work->progress.x);
    work->step.y = FX_Div(target->y - start->y, work->progress.y);

    // ???
    work->progress.z = FX_Div(target->z - start->z, work->progress.z);
    work->step.z     = 0;

    if (duration)
    {
        work->duration = FloatToFx32(duration);
    }
    else
    {
        work->duration = FLOAT_TO_FX32(1.0);
    }
}

BOOL ExUtils_CheckMeteorMoverFinished(ExUtilMeteorMover *work, VecFx32 *position, BOOL useCurrentPositionZ)
{
    if (useCurrentPositionZ)
        work->step.z = work->step.z - MultiplyFX(work->stepSize, work->duration);
    else
        work->step.z = work->progress.z;

    position->x += work->step.x;
    position->y += work->step.y;
    position->z += work->step.z;

    return work->step.z <= 0;
}