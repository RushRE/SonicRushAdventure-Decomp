#ifndef RUSH_EXUTILS_H
#define RUSH_EXUTILS_H

#include <ex/system/exTask.h>
#include <ex/player/exPlayer.h>

// --------------------
// ENUMS
// --------------------

enum ExUtilRotateAxis_
{
    EXUTIL_ROTATE_AXIS_X,
    EXUTIL_ROTATE_AXIS_Y,
    EXUTIL_ROTATE_AXIS_Z,
};
typedef s32 ExUtilRotateAxis;

enum ExUtilRotateDir_
{
    EXUTIL_ROTATE_DIR_NONE,
    EXUTIL_ROTATE_DIR_CW,
    EXUTIL_ROTATE_DIR_CCW,
};
typedef u16 ExUtilRotateDir;

// --------------------
// STRUCTS
// --------------------

typedef struct ExUtilMissileMover_
{
    VecFx32 *positionList;
    s16 positionListSize;
    VecFx32 currentPosition;
    s16 stepCount;
    s16 currentStep;
    VecFx32 velocity;
    VecFx32 prevPosition;
} ExUtilMissileMover;

typedef struct ExUtilMeteorMover_
{
    VecFx32 progress;
    VecFx32 step;
    fx32 stepSize;
    fx32 duration;
} ExUtilMeteorMover;

// --------------------
// FUNCTIONS
// --------------------

BOOL ExUtils_InitMissileMover(ExUtilMissileMover *work, VecFx32 *positionList, s32 positionListSize, s16 stepCount);
BOOL ExUtils_ProcessMissileMover(ExUtilMissileMover *work);
void ExUtils_SetJointAnimation(EX_ACTION_NN_WORK *work, void *resModel, void *resTexture, NNSG3dResFileHeader *resJointAnim, u16 animID);
void ExUtils_ResetRenderTransform(void);
void ExUtils_RotateOnAxis(VecU16 *angle, VecU16 *direction, VecU16 *velocity, ExUtilRotateAxis axis);
u16 ExUtils_Atan2(fx32 y, fx32 x);
u16 ExUtils_RotateTowards(fx32 y, fx32 x, VecU16 *rotation, s16 *angle, u16 rotateSpeed);
void ExUtils_InitMeteorMover(ExUtilMeteorMover *work, VecFx32 *start, VecFx32 *target, float stepSize, float duration);
BOOL ExUtils_CheckMeteorMoverFinished(ExUtilMeteorMover *work, VecFx32 *position, BOOL useCurrentPositionZ);

#endif // RUSH_EXUTILS_H
