#include <hub/cviDockPlayer.hpp>
#include <game/math/cppMath.hpp>
#include <game/graphics/renderCore.h>
#include <game/file/binaryBundle.h>

// resources
#include <resources/bb/vi_son.h>

// --------------------
// STRUCTS
// --------------------

struct CViDockPlayerMoveConfig
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

NOT_DECOMPILED void _ZN13CViDockPlayer7ReleaseEv(void);
}

// --------------------
// VARIABLES
// --------------------

static const CViDockPlayerMoveConfig cviDockPlayerMoveConfig[2] = {
    { FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.0078125) },
    { FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.0625) },
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef NON_MATCHING
CViDockPlayer::CViDockPlayer()
#else
// NONMATCH_FUNC CViDockPlayer::CViDockPlayer()
NONMATCH_FUNC void _ZN13CViDockPlayerC1Ev()
#endif
{
#ifdef NON_MATCHING
    this->resModel     = NULL;
    this->resAnims     = NULL;
    this->loadedAssets = FALSE;

    this->Release();
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
	bl _ZN13CViDockPlayer7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

#ifdef NON_MATCHING
CViDockPlayer::~CViDockPlayer()
#else
// NONMATCH_FUNC CViDockPlayer::~CViDockPlayer()
NONMATCH_FUNC void _ZN13CViDockPlayerD0Ev()
#endif
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViDockPlayer+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViDockPlayer7ReleaseEv
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

#ifndef NON_MATCHING
// NONMATCH_FUNC CViDockPlayer::~CViDockPlayer()
NONMATCH_FUNC void _ZN13CViDockPlayerD1Ev()
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViDockPlayer+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViDockPlayer7ReleaseEv
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}
#endif

void CViDockPlayer::Init()
{
    if (!this->loadedAssets)
    {
        GetCompressedFileFromBundle("bb/vi_son.bb", BUNDLE_VI_SON_FILE_RESOURCES_BB_VI_SON_SON_NSBMD, &this->resModel, TRUE, FALSE);
        GetCompressedFileFromBundle("bb/vi_son.bb", BUNDLE_VI_SON_FILE_RESOURCES_BB_VI_SON_SON_NSBCA, &this->resAnims, TRUE, FALSE);

        this->SetResources(this->resModel, CViDockPlayer::ANI_IDLE, FALSE, FALSE, this->resAnims, NULL, NULL, NULL, NULL, CVI3DOBJECT_RESOURCE_NONE);
        this->aniBody.speed[B3D_ANIM_JOINT_ANIM] = FLOAT_TO_FX32(0.25);
        this->SetJointAnimForBody(CViDockPlayer::ANI_IDLE, TRUE, FALSE, FALSE, TRUE);

        this->flags |= CVi3dObject::FLAG_TURNING;
        this->turnSpeed    = FLOAT_DEG_TO_IDX(20.0);
        this->loadedAssets = TRUE;
    }

    this->moveState     = CViDockPlayer::MOVESTATE_IDLE;
    this->prevMoveState = CViDockPlayer::MOVESTATE_IDLE;
    this->idleState     = CViDockPlayer::IDLESTATE_INACTIVE;
    this->idleTimer     = 0;
    this->prevPos.x     = FLOAT_TO_FX32(0.0);
    this->prevPos.y     = FLOAT_TO_FX32(0.0);
    this->prevPos.z     = FLOAT_TO_FX32(0.0);
    this->velocity      = FLOAT_TO_FX32(0.0);
    this->moveFlag      = CViDockPlayer::MOVEFLAG_NO_INPUTS;
    this->topSpeed      = FLOAT_TO_FX32(1.0);
}

void CViDockPlayer::Release()
{
    CVi3dObject::Release();

    if (this->resModel != NULL)
    {
        NNS_G3dResDefaultRelease(this->resModel);
        HeapFree(HEAP_USER, this->resModel);
        this->resModel = NULL;
    }

    if (this->resAnims != NULL)
    {
        HeapFree(HEAP_USER, this->resAnims);
        this->resAnims = NULL;
    }

    this->allowBored   = TRUE;
    this->loadedAssets = FALSE;
}

VecFx32 *CViDockPlayer::GetPrevPosition()
{
    return &this->prevPos;
}

void CViDockPlayer::SetTurnAngle(u16 angle, BOOL snap)
{
    this->targetTurnAngle = angle;

    if (snap)
        this->currentTurnAngle = this->targetTurnAngle;
}

void CViDockPlayer::SetMoveAngle(u16 angle, BOOL isRunning)
{
    this->targetTurnAngle = angle;
    this->moveFlag        = isRunning != FALSE ? CViDockPlayer::MOVEFLAG_RUNNING : CViDockPlayer::MOVEFLAG_WALKING;
}

void CViDockPlayer::Process(fx32 speed)
{
    CMatrix33 mtx1;
    CMatrix33 mtx2;
    CVector3 moveVelocity;

    s32 sin2;
    s32 sin = SinFX(this->targetTurnAngle);
    s32 cos = CosFX(this->targetTurnAngle);
    sin2    = sin;
    mtx1.RotateY(&sin2, &cos);

    moveVelocity.x = FLOAT_TO_FX32(0.0);
    moveVelocity.y = FLOAT_TO_FX32(0.0);
    moveVelocity.z = FLOAT_TO_FX32(1.0);
    CMatrix33::MultiplyVector(moveVelocity, &mtx1);

    if (this->moveFlag < CViDockPlayer::MOVEFLAG_INVALID)
    {
        const CViDockPlayerMoveConfig *config = &cviDockPlayerMoveConfig[this->moveFlag];

        if (this->velocity < config->minSpeed)
        {
            this->velocity = config->minSpeed;
        }
        else
        {
            if (this->velocity < config->topSpeed)
            {
                this->velocity += config->acceleration;
                if (this->velocity > config->topSpeed)
                    this->velocity = config->topSpeed;
            }
            else
            {
                if (this->velocity > config->topSpeed)
                {
                    this->velocity -= FLOAT_TO_FX32(0.03125);
                    if (this->velocity < config->topSpeed)
                        this->velocity = config->topSpeed;
                }
            }
        }

        if (this->moveFlag != CViDockPlayer::MOVEFLAG_RUNNING)
        {
            if (this->velocity > this->topSpeed)
                this->velocity = this->topSpeed;
        }
    }
    else
    {
        this->velocity = FLOAT_TO_FX32(0.0);
    }

    moveVelocity *= MultiplyFX(this->velocity, speed);

    if (this->velocity == FLOAT_TO_FX32(0.0))
        this->moveState = CViDockPlayer::MOVESTATE_IDLE;
    else if (this->velocity <= FLOAT_TO_FX32(1.0))
        this->moveState = CViDockPlayer::MOVESTATE_WALKING;
    else
        this->moveState = CViDockPlayer::MOVESTATE_RUNNING;

    if (this->moveState != this->prevMoveState)
    {
        switch (this->moveState)
        {
            case CViDockPlayer::MOVESTATE_IDLE:
                this->SetJointAnimForBody(CViDockPlayer::ANI_IDLE, TRUE, TRUE, FALSE, FALSE);
                break;

            case CViDockPlayer::MOVESTATE_WALKING:
                this->SetJointAnimForBody(CViDockPlayer::ANI_WALK, TRUE, TRUE, TRUE, FALSE);
                break;

            case CViDockPlayer::MOVESTATE_RUNNING:
                this->SetJointAnimForBody(CViDockPlayer::ANI_RUN, TRUE, TRUE, TRUE, FALSE);
                break;
        }

        this->prevMoveState = this->moveState;
        this->idleState     = CViDockPlayer::IDLESTATE_INACTIVE;
        this->idleTimer     = 0;
    }
    else
    {
        if (this->moveState == CViDockPlayer::MOVESTATE_IDLE && this->idleState != CViDockPlayer::IDLESTATE_INACTIVE && !this->allowBored)
        {
            this->SetJointAnimForBody(CViDockPlayer::ANI_IDLE, TRUE, TRUE, FALSE, FALSE);
            this->idleState = CViDockPlayer::IDLESTATE_INACTIVE;
            this->idleTimer = 0;
        }
        else
        {
            if (this->allowBored && this->moveState == CViDockPlayer::MOVESTATE_IDLE && this->idleTimer >= SECONDS_TO_FRAMES(3.0))
            {
                if (this->idleState != CViDockPlayer::IDLESTATE_ANIM_STARTING)
                {
                    if (this->idleState != CViDockPlayer::IDLESTATE_BORED && this->idleState == CViDockPlayer::IDLESTATE_INACTIVE)
                    {
                        this->SetJointAnimForBody(CViDockPlayer::ANI_BORED_00, FALSE, FALSE, FALSE, FALSE);
                        this->idleState = CViDockPlayer::IDLESTATE_ANIM_STARTING;
                    }
                }
                else if ((this->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
                {
                    this->SetJointAnimForBody(CViDockPlayer::ANI_BORED_01, TRUE, FALSE, FALSE, FALSE);
                    this->idleState = CViDockPlayer::IDLESTATE_BORED;
                }
            }
        }
    }

    switch (this->moveState)
    {
        case CViDockPlayer::MOVESTATE_IDLE:
            this->aniBody.speed[0] = FLOAT_TO_FX32(1.0);
            break;

        case CViDockPlayer::MOVESTATE_WALKING:
            this->aniBody.speed[0] = 2 * this->velocity;
            break;

        case CViDockPlayer::MOVESTATE_RUNNING:
            this->aniBody.speed[0] = this->velocity + (this->velocity >> 1);
            break;
    }

    this->prevPos = this->position.ToConstVecFx32Ref();

    // Apply velocity
    this->position = (moveVelocity + this->prevPos).ToVecFx32Ref();

    CVi3dObject::Process();

    this->idleTimer++;
    this->moveState = CViDockPlayer::MOVESTATE_IDLE;
    this->moveFlag  = CViDockPlayer::MOVEFLAG_NO_INPUTS;
}

void CViDockPlayer::AllowBored(BOOL allowBored)
{
    this->allowBored = allowBored;
    this->idleTimer  = 0;
}

void CViDockPlayer::SetTopSpeed(fx32 topSpeed)
{
    this->topSpeed = topSpeed;
}