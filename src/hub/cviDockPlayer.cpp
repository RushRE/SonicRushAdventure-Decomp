#include <hub/cviDockPlayer.hpp>
#include <game/util/cppHelpers.hpp>
#include <game/graphics/renderCore.h>
#include <game/file/binaryBundle.h>

// resources
#include <resources/bb/vi_son.h>

// --------------------
// STRUCTS
// --------------------

struct CVIDockPlayerMoveConfig
{
    fx32 topSpeed;
    fx32 minSpeed;
    fx32 acceleration;
};

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void *_ZTV13CViDockPlayer;

NOT_DECOMPILED void _ZdlPv(void);
}

// --------------------
// VARIABLES
// --------------------

static const CVIDockPlayerMoveConfig cviDockPlayerMoveConfig[2] = {
    { FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.0078125) },
    { FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.0625) },
};

// --------------------
// FUNCTIONS
// --------------------

// NONMATCH_FUNC CViDockPlayer::CViDockPlayer()
NONMATCH_FUNC void _ZN13CViDockPlayerC1Ev()
{
#ifdef NON_MATCHING
    this->resModel     = NULL;
    this->resAnims     = NULL;
    this->loadedAssets = 0;
    ViDockPlayer__Release(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN11CVi3dObjectC1Ev
	ldr r0, =_ZTV13CViDockPlayer+0x08
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x330]
	str r1, [r4, #0x334]
	mov r0, r4
	str r1, [r4, #0x310]
	bl ViDockPlayer__Release
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// NONMATCH_FUNC CViDockPlayer::~CViDockPlayer()
NONMATCH_FUNC void _ZN13CViDockPlayerD0Ev()
{
#ifdef NON_MATCHING
    ViDockPlayer__Release(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViDockPlayer+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockPlayer__Release
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// NONMATCH_FUNC CViDockPlayer::~CViDockPlayer()
NONMATCH_FUNC void _ZN13CViDockPlayerD1Ev()
{
#ifdef NON_MATCHING
    ViDockPlayer__Release(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViDockPlayer+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockPlayer__Release
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void ViDockPlayer__Init(CViDockPlayer *work)
{
    if (!work->loadedAssets)
    {
        GetCompressedFileFromBundle("bb/vi_son.bb", BUNDLE_VI_SON_FILE_RESOURCES_BB_VI_SON_SON_NSBMD, &work->resModel, TRUE, FALSE);
        GetCompressedFileFromBundle("bb/vi_son.bb", BUNDLE_VI_SON_FILE_RESOURCES_BB_VI_SON_SON_NSBCA, &work->resAnims, TRUE, FALSE);

        work->Func_216763C(work->resModel, CViDockPlayer::ANI_IDLE, FALSE, FALSE, work->resAnims, NULL, NULL, NULL, NULL, CVI3DOBJECT_RESOURCE_NONE);
        work->aniBody.speed[B3D_ANIM_JOINT_ANIM] = FLOAT_TO_FX32(0.25);
        work->Func_2167900(CViDockPlayer::ANI_IDLE, TRUE, FALSE, FALSE, TRUE);

        work->flags |= CVi3dObject::FLAG_1;
        work->turnSpeed    = FLOAT_DEG_TO_IDX(20.0);
        work->loadedAssets = TRUE;
    }

    work->moveState            = CViDockPlayer::MOVESTATE_IDLE;
    work->prevMoveState        = CViDockPlayer::MOVESTATE_IDLE;
    work->idleState            = CViDockPlayer::IDLESTATE_INACTIVE;
    work->idleTimer            = 0;
    work->translationUnknown.x = FLOAT_TO_FX32(0.0);
    work->translationUnknown.y = FLOAT_TO_FX32(0.0);
    work->translationUnknown.z = FLOAT_TO_FX32(0.0);
    work->velocity             = FLOAT_TO_FX32(0.0);
    work->moveFlag             = CViDockPlayer::MOVEFLAG_NO_INPUTS;
    work->topSpeed             = FLOAT_TO_FX32(1.0);
}

void ViDockPlayer__Release(CViDockPlayer *work)
{
    work->Func_21677C4();

    if (work->resModel != NULL)
    {
        NNS_G3dResDefaultRelease(work->resModel);
        HeapFree(HEAP_USER, work->resModel);
        work->resModel = NULL;
    }

    if (work->resAnims != NULL)
    {
        HeapFree(HEAP_USER, work->resAnims);
        work->resAnims = NULL;
    }

    work->allowBored   = TRUE;
    work->loadedAssets = FALSE;
}

VecFx32 *ViDockPlayer__GetTranslationUnknown(CViDockPlayer *work)
{
    return &work->translationUnknown;
}

void ViDockPlayer__SetTurnAngle(CViDockPlayer *work, u16 angle, BOOL snap)
{
    work->targetTurnAngle = angle;
	
    if (snap)
        work->currentTurnAngle = work->targetTurnAngle;
}

void ViDockPlayer__SetMoveAngle(CViDockPlayer *work, u16 angle, BOOL isRunning)
{
    work->targetTurnAngle = angle;
    work->moveFlag        = isRunning != FALSE ? CViDockPlayer::MOVEFLAG_RUNNING : CViDockPlayer::MOVEFLAG_WALKING;
}

void ViDockPlayer__Process(CViDockPlayer *work, fx32 speed)
{
    MtxFx33 mtx1;
    MtxFx33 mtx2;
    VecFx32 moveVelocity;

    CPPHelpers__Func_2085E40(&mtx1);
    CPPHelpers__Func_2085E40(&mtx2);
    CPPHelpers__Func_2085EE8(&moveVelocity);

    s32 sin2;
    s32 sin = SinFX(work->targetTurnAngle);
    s32 cos = CosFX(work->targetTurnAngle);
    sin2    = sin;
    CPPHelpers__MtxRotY33(&mtx1, &sin2, &cos);

    moveVelocity.x = FLOAT_TO_FX32(0.0);
    moveVelocity.y = FLOAT_TO_FX32(0.0);
    moveVelocity.z = FLOAT_TO_FX32(1.0);
    CPPHelpers__Func_2085E74(&moveVelocity, &mtx1);

    if (work->moveFlag < CViDockPlayer::MOVEFLAG_INVALID)
    {
        const CVIDockPlayerMoveConfig *config = &cviDockPlayerMoveConfig[work->moveFlag];

        if (work->velocity < config->minSpeed)
        {
            work->velocity = config->minSpeed;
        }
        else
        {
            if (work->velocity < config->topSpeed)
            {
                work->velocity += config->acceleration;
                if (work->velocity > config->topSpeed)
                    work->velocity = config->topSpeed;
            }
            else
            {
                if (work->velocity > config->topSpeed)
                {
                    work->velocity -= FLOAT_TO_FX32(0.03125);
                    if (work->velocity < config->topSpeed)
                        work->velocity = config->topSpeed;
                }
            }
        }

        if (work->moveFlag != CViDockPlayer::MOVEFLAG_RUNNING)
        {
            if (work->velocity > work->topSpeed)
                work->velocity = work->topSpeed;
        }
    }
    else
    {
        work->velocity = FLOAT_TO_FX32(0.0);
    }

    CPPHelpers__VEC_Multiply_Alt(&moveVelocity, MultiplyFX(work->velocity, speed));

    if (work->velocity == FLOAT_TO_FX32(0.0))
        work->moveState = CViDockPlayer::MOVESTATE_IDLE;
    else if (work->velocity <= FLOAT_TO_FX32(1.0))
        work->moveState = CViDockPlayer::MOVESTATE_WALKING;
    else
        work->moveState = CViDockPlayer::MOVESTATE_RUNNING;

    if (work->moveState != work->prevMoveState)
    {
        switch (work->moveState)
        {
            case CViDockPlayer::MOVESTATE_IDLE:
                work->Func_2167900(CViDockPlayer::ANI_IDLE, TRUE, TRUE, FALSE, FALSE);
                break;

            case CViDockPlayer::MOVESTATE_WALKING:
                work->Func_2167900(CViDockPlayer::ANI_WALK, TRUE, TRUE, TRUE, FALSE);
                break;

            case CViDockPlayer::MOVESTATE_RUNNING:
                work->Func_2167900(CViDockPlayer::ANI_RUN, TRUE, TRUE, TRUE, FALSE);
                break;
        }

        work->prevMoveState = work->moveState;
        work->idleState     = CViDockPlayer::IDLESTATE_INACTIVE;
        work->idleTimer     = 0;
    }
    else
    {
        if (work->moveState == CViDockPlayer::MOVESTATE_IDLE && work->idleState != CViDockPlayer::IDLESTATE_INACTIVE && !work->allowBored)
        {
            work->Func_2167900(CViDockPlayer::ANI_IDLE, TRUE, TRUE, FALSE, FALSE);
            work->idleState = CViDockPlayer::IDLESTATE_INACTIVE;
            work->idleTimer = 0;
        }
        else
        {
            if (work->allowBored && work->moveState == CViDockPlayer::MOVESTATE_IDLE && work->idleTimer >= SECONDS_TO_FRAMES(3.0))
            {
                if (work->idleState != CViDockPlayer::IDLESTATE_ANIM_STARTING)
                {
                    if (work->idleState != CViDockPlayer::IDLESTATE_BORED && work->idleState == CViDockPlayer::IDLESTATE_INACTIVE)
                    {
                        work->Func_2167900(CViDockPlayer::ANI_BORED_00, FALSE, FALSE, FALSE, FALSE);
                        work->idleState = CViDockPlayer::IDLESTATE_ANIM_STARTING;
                    }
                }
                else if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
                {
                    work->Func_2167900(CViDockPlayer::ANI_BORED_01, TRUE, FALSE, FALSE, FALSE);
                    work->idleState = CViDockPlayer::IDLESTATE_BORED;
                }
            }
        }
    }

    switch (work->moveState)
    {
        case CViDockPlayer::MOVESTATE_IDLE:
            work->aniBody.speed[0] = FLOAT_TO_FX32(1.0);
            break;

        case CViDockPlayer::MOVESTATE_WALKING:
            work->aniBody.speed[0] = 2 * work->velocity;
            break;

        case CViDockPlayer::MOVESTATE_RUNNING:
            work->aniBody.speed[0] = work->velocity + (work->velocity >> 1);
            break;
    }

    work->translationUnknown = *CPPHelpers__Func_2085F9C(&work->translation1);

    // Apply velocity
    VecFx32 vecResult;
    CPPHelpers__VEC_Add_Alt2(&vecResult, &moveVelocity, &work->translationUnknown);
    CPPHelpers__VEC_Copy_Alt(&work->translation1, CPPHelpers__Func_2085F98(&vecResult));

    work->ProcessAnimation();

    work->idleTimer++;
    work->moveState = CViDockPlayer::MOVESTATE_IDLE;
    work->moveFlag  = CViDockPlayer::MOVEFLAG_NO_INPUTS;
}

void ViDockPlayer__AllowBored(CViDockPlayer *work, BOOL allowBored)
{
    work->allowBored = allowBored;
    work->idleTimer  = 0;
}

void ViDockPlayer__SetTopSpeed(CViDockPlayer *work, fx32 topSpeed)
{
    work->topSpeed = topSpeed;
}