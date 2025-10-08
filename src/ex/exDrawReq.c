#include <ex/system/exDrawReq.h>
#include <ex/system/exDrawFade.h>
#include <game/graphics/drawState.h>
#include <game/math/unknown2066510.h>
#include <ex/system/exSystem.h>
#include <ex/boss/exBoss.h>
#include <ex/system/exUtils.h>

// --------------------
// CONSTANTS
// --------------------

#define EXDRAWREQ_REQUEST_LIST_SIZE 160

// --------------------
// STRUCTS
// --------------------

typedef struct exDrawRequest_
{
    u16 slot;
    ExDrawReqTaskPriority priority;
    ExDrawReqTaskType type;
    struct exDrawRequest_ *next;
    void *drawWork;
    EX_ACTION_NN_WORK model;
    EX_ACTION_BAC3D_WORK sprite3D;
    EX_ACTION_BAC2D_WORK sprite2D;
    EX_ACTION_TRAIL_WORK trail;
} exDrawRequest;

typedef struct exDrawReqTask_
{
    u32 unused;
    exDrawRequest *currentRequest;
} exDrawReqTask;

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED u16 exDrawFadeTask__word_2176444[4];

static u16 requestListSize;
static exDrawRequest *requestBuffer;
static exDrawRequest *nextRequestList;
static exDrawRequest *currentRequestList;
static exDrawReqTaskConfig globalModelConfig;

// --------------------
// FUNCTION DECLS
// --------------------

extern void ApplyExDrawCameraConfig(ExDrawCameraConfig *work);
extern void SetExDrawLightConfig(ExDrawLightConfig *config);

static void InitExDrawRequestBossHomingLaserTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
static void InitExDrawRequestBossFireDragonTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
static void InitExDrawRequestPlayerTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);

static void ProcessModelExDrawRequest(EX_ACTION_NN_WORK *work);

// Model
static void InitExDrawRequestModelWorker(ExGraphicsModel *work);
static void InitExDrawRequestModelConfig(exDrawReqTaskConfig *work);
static void ProcessExDrawRequestModelTransform(ExGraphicsModel *work);
static void ProcessExDrawRequestModelPriority(EX_ACTION_NN_WORK *work);
static void ProcessExDrawRequestModelUnknown(EX_ACTION_NN_WORK *work);
static void DrawExDrawRequestModel(EX_ACTION_NN_WORK *work);
static void ProcessExDrawRequestModelLighting(EX_ACTION_NN_WORK *work);

// Sprite2D
static void InitExDrawRequestSprite2DWorker(ExGraphicsSprite2D *work);
static void InitExDrawRequestSprite2DConfig(exDrawReqTaskConfig *work);
static void ProcessExDrawRequestSprite2DTransform(EX_ACTION_BAC2D_WORK *work);
static void ProcessExDrawRequestSprite2DUnknown(EX_ACTION_BAC2D_WORK *work);
static void DrawExDrawRequestSprite2D(EX_ACTION_BAC2D_WORK *work);
static void ProcessExDrawRequestSprite2DPriority(EX_ACTION_BAC2D_WORK *work);
static void ProcessSprite2DExDrawRequest(EX_ACTION_BAC2D_WORK *work);

// Sprite3D
static void InitExDrawRequestSprite3DWorker(ExGraphicsSprite3D *work);
static void InitExDrawRequestSprite3DConfig(exDrawReqTaskConfig *work);
static void ProcessExDrawRequestSprite3DTransform(ExGraphicsSprite3D *work);
static void ProcessExDrawRequestSprite3DPriority(EX_ACTION_BAC3D_WORK *work);
static void ProcessExDrawRequestSprite3DUnknown(EX_ACTION_BAC3D_WORK *work);
static void DrawExDrawRequestSprite3D(EX_ACTION_BAC3D_WORK *work);
static void ProcessSprite3DExDrawRequest(EX_ACTION_BAC3D_WORK *work);

// Trail
static void ProcessTrailExDrawRequest(EX_ACTION_TRAIL_WORK *work);

// exDrawReqTask
static void ExDrawReqTask_Main_Init(void);
static void ExDrawReqTask_OnCheckStageFinished(void);
static void ExDrawReqTask_Destructor(void);
static void ExDrawReqTask_Main_Process(void);
static void InitAllExDrawRequests(void *list);
static void InitExDrawRequest(void *req);
static void InitExDrawRequestList(void);
static exDrawReqTaskConfig *GetExDrawGlobalConfig(void);
static void InitExDrawGlobalConfig(void);

// Misc
BOOL SetExDrawRequestGlobalModelConfigTimer(u8 duration);

// --------------------
// FUNCTIONS
// --------------------

void InitExDrawRequestSprite2DWorker(ExGraphicsSprite2D *work)
{
    MI_CpuClear8(work, sizeof(*work));

    work->rotation = 0;
    work->pos.x    = 0;
    work->pos.y    = 0;
    work->scale.x  = FLOAT_TO_FX32(1.0);
    work->scale.y  = FLOAT_TO_FX32(1.0);
    work->unknown  = 0;
}

void InitExDrawRequestSprite2DConfig(exDrawReqTaskConfig *work)
{
    work->control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
    work->control.isInvisible   = FALSE;
    work->control.timer         = 0;

    work->graphics.unknown            = FALSE;
    work->graphics.disableAnimation   = FALSE;
    work->graphics.canFinish          = FALSE;
    work->graphics.noStopOnFinish     = TRUE;
    work->graphics.forceStopAnimation = FALSE;
    work->graphics.drawType           = EXDRAWREQTASK_TYPE_SPRITE2D;

    work->priority = 0;

    work->display.disableAffine = FALSE;
}

void InitExDrawRequestSprite2D(EX_ACTION_BAC2D_WORK *work)
{
    InitExDrawRequestSprite2DWorker(&work->sprite);
    InitExDrawRequestSprite2DConfig(&work->config);
}

void ProcessExDrawRequestSprite2DTransform(EX_ACTION_BAC2D_WORK *work)
{
    work->sprite.animator.pos.x = work->sprite.pos.x;
    work->sprite.animator.pos.y = work->sprite.pos.y;

    if (work->sprite.scale.x >= FLOAT_TO_FX32(2.0))
        work->sprite.scale.x = FLOAT_TO_FX32(2.0);

    if (work->sprite.scale.y >= FLOAT_TO_FX32(2.0))
        work->sprite.scale.y = FLOAT_TO_FX32(2.0);

    if (work->sprite.scale.x <= -FLOAT_TO_FX32(2.0))
        work->sprite.scale.x = -FLOAT_TO_FX32(2.0);

    if (work->sprite.scale.y <= -FLOAT_TO_FX32(2.0))
        work->sprite.scale.y = -FLOAT_TO_FX32(2.0);
}

NONMATCH_FUNC void ProcessExDrawRequestSprite2DUnknown(EX_ACTION_BAC2D_WORK *work)
{
    // https://decomp.me/scratch/1INet -> 96.73%
#ifdef NON_MATCHING
    u32 time   = (u32)(work->config.control.timer) >> 1;
    s32 offset = (s16)((u8)time + (mtMathRand() % 2));

    if (exHitCheckTask_IsPaused() == FALSE && work->config.control.timer != 0)
    {
        if (mtMathRand() % 2)
            work->sprite.animator.pos.x += offset;
        else
            work->sprite.animator.pos.x -= offset;

        if (mtMathRand() % 2)
            work->sprite.animator.pos.y += offset;
        else
            work->sprite.animator.pos.y -= offset;

        if (work->config.control.timer != 0)
            work->config.control.timer--;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldrb ip, [r5, #0x80]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, ip, lsl #0x18
	mov r1, r0, lsr #0x1f
	mov r3, r3, lsr #0x1d
	rsb r0, r1, r0, lsl #31
	and r3, r3, #0xff
	add r0, r1, r0, ror #31
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r4, [r2]
	mov r4, r0, lsl #0x10
	bl exHitCheckTask_IsPaused
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r0, [r5, #0x80]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrsh r0, [r5, #0xc]
	ldr r2, =_mt_math_rand
	ldr r1, =0x3C6EF35F
	addne r0, r0, r4, asr #16
	subeq r0, r0, r4, asr #16
	strh r0, [r5, #0xc]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrsh r0, [r5, #0xe]
	addne r0, r0, r4, asr #16
	subeq r0, r0, r4, asr #16
	strh r0, [r5, #0xe]
	ldrb r1, [r5, #0x80]
	mov r0, r1, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0xff
	and r0, r0, #0xff
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r0, r1, r0, lsr #24
	strb r0, [r5, #0x80]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void AnimateExDrawRequestSprite2D(EX_ACTION_BAC2D_WORK *work)
{
    if (work->config.graphics.forceStopAnimation)
    {
        Stop2DExDrawRequestAnimation(work);
    }

    if (work->config.graphics.disableAnimation == FALSE)
    {
        AnimatorSprite__ProcessAnimationFast(&work->sprite.animator);

        if (work->config.graphics.canFinish)
        {
            if (work->config.graphics.noStopOnFinish)
                return;

            if (IsExDrawRequestSprite2DAnimFinished(work))
                Stop2DExDrawRequestAnimation(work);
        }
    }
}

void ProcessExDrawRequestSprite2DPriority(EX_ACTION_BAC2D_WORK *work)
{
    if (work->config.priority < EXDRAWREQTASK_PRIORITY_DEFAULT)
        work->sprite.animator.oamPriority = SPRITE_PRIORITY_1;

    if (work->config.priority >= EXDRAWREQTASK_PRIORITY_DEFAULT)
        work->sprite.animator.oamPriority = SPRITE_PRIORITY_0;
}

void DrawExDrawRequestSprite2D(EX_ACTION_BAC2D_WORK *work)
{
    if (work->config.control.isInvisible == FALSE)
    {
        if (work->sprite.targetAlpha != 0)
        {
            RenderCore_ChangeBlendAlpha(&Camera3D__GetWork()->gfxControl[GRAPHICS_ENGINE_B].blendManager, work->sprite.targetAlpha, 0x1F);
            work->sprite.animator.spriteType = GX_OAM_MODE_XLU;
        }

        ExDrawReqTaskConfig_ActiveScreens activeScreens = work->config.control.activeScreens;
        if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_BOTH)
        {
            if (Camera3D__UseEngineA())
            {
                work->sprite.animator.pos.y += HW_LCD_HEIGHT;
                if (work->config.display.disableAffine == FALSE)
                    AnimatorSprite__DrawFrameRotoZoom(&work->sprite.animator, work->sprite.scale.x, work->sprite.scale.y, work->sprite.rotation);
                else
                    AnimatorSprite__DrawFrame(&work->sprite.animator);
                work->sprite.animator.pos.y -= HW_LCD_HEIGHT;
            }
            else
            {
                if (work->config.display.disableAffine == FALSE)
                    AnimatorSprite__DrawFrameRotoZoom(&work->sprite.animator, work->sprite.scale.x, work->sprite.scale.y, work->sprite.rotation);
                else
                    AnimatorSprite__DrawFrame(&work->sprite.animator);
            }
        }
        else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_A)
        {
            if (Camera3D__UseEngineA())
            {
                if (work->config.display.disableAffine == FALSE)
                    AnimatorSprite__DrawFrameRotoZoom(&work->sprite.animator, work->sprite.scale.x, work->sprite.scale.y, work->sprite.rotation);
                else
                    AnimatorSprite__DrawFrame(&work->sprite.animator);
            }
        }
        else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_B)
        {
            if (Camera3D__UseEngineA() == FALSE)
            {
                if (work->config.display.disableAffine == FALSE)
                    AnimatorSprite__DrawFrameRotoZoom(&work->sprite.animator, work->sprite.scale.x, work->sprite.scale.y, work->sprite.rotation);
                else
                    AnimatorSprite__DrawFrame(&work->sprite.animator);
            }
        }

        work->sprite.animator.pos.x = work->sprite.pos.x;
        work->sprite.animator.pos.y = work->sprite.pos.y;
    }
}

void ProcessSprite2DExDrawRequest(EX_ACTION_BAC2D_WORK *work)
{
    ProcessExDrawRequestSprite2DTransform(work);
    ProcessExDrawRequestSprite2DUnknown(work);
    ProcessExDrawRequestSprite2DPriority(work);
    DrawExDrawRequestSprite2D(work);
}

void Stop2DExDrawRequestAnimation(EX_ACTION_BAC2D_WORK *work)
{
    work->config.graphics.canFinish          = FALSE;
    work->config.graphics.disableAnimation   = TRUE;
    work->config.graphics.noStopOnFinish     = FALSE;
    work->config.graphics.forceStopAnimation = FALSE;
}

void SetExDrawRequestSprite2DOnlyEngineA(EX_ACTION_BAC2D_WORK *work)
{
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;
}

void SetExDrawRequestSprite2DOnlyEngineB(EX_ACTION_BAC2D_WORK *work)
{
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_B;
}

BOOL IsExDrawRequestSprite2DAnimFinished(EX_ACTION_BAC2D_WORK *work)
{
    return work->sprite.animator.animFrameCount == work->sprite.animator.animFrameIndex && work->sprite.animator.frameRemainder <= work->sprite.animator.animAdvance;
}

void InitExDrawRequestModelWorker(ExGraphicsModel *work)
{
    MI_CpuClear8(work, sizeof(*work));

    AnimatorMDL__Init(&work->animator, ANIMATOR_FLAG_NONE);

    work->animID = 0;

    work->angle.x = FLOAT_DEG_TO_IDX(0.0);
    work->angle.y = FLOAT_DEG_TO_IDX(0.0);
    work->angle.z = FLOAT_DEG_TO_IDX(0.0);

    work->translation.x = FLOAT_TO_FX32(0.0);
    work->translation.y = FLOAT_TO_FX32(0.0);
    work->translation.z = FLOAT_TO_FX32(0.0);

    work->scale.x = FLOAT_TO_FX32(1.0);
    work->scale.y = FLOAT_TO_FX32(1.0);
    work->scale.z = FLOAT_TO_FX32(1.0);

    work->translation2.x = FLOAT_TO_FX32(0.0);
    work->translation2.y = FLOAT_TO_FX32(0.0);
    work->translation2.z = FLOAT_TO_FX32(0.0);
}

void InitExDrawRequestModelConfig(exDrawReqTaskConfig *work)
{
    work->control.activeScreens      = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
    work->control.isInvisible        = FALSE;
    work->control.useInstanceUnknown = FALSE;
    work->control.timer              = 0;

    work->graphics.unknown            = FALSE;
    work->graphics.disableAnimation   = FALSE;
    work->graphics.canFinish          = FALSE;
    work->graphics.noStopOnFinish     = TRUE;
    work->graphics.forceStopAnimation = FALSE;
    work->graphics.drawType           = EXDRAWREQTASK_TYPE_MODEL;

    work->display.lightType = EXDRAWREQ_LIGHT_DEFAULT;

    work->priority = EXDRAWREQTASK_PRIORITY_LOWEST;

    work->display.unknown = FALSE;
}

void InitExDrawRequestModel(EX_ACTION_NN_WORK *work)
{
    InitExDrawRequestModelWorker(&work->model);
    exHitCheckTask_InitHitChecker(&work->hitChecker);
    InitExDrawRequestModelConfig(&work->config);
}

void ProcessExDrawRequestModelTransform(ExGraphicsModel *work)
{
    MtxFx33 matRotZ;
    MtxFx33 matRotY;
    MtxFx33 matRotX;
    MtxFx33 matRotXY;

    MTX_RotX33(&matRotX, SinFX(work->angle.x), CosFX(work->angle.x));
    MTX_RotY33(&matRotY, SinFX(work->angle.y), CosFX(work->angle.y));
    MTX_RotZ33(&matRotZ, SinFX(work->angle.z), CosFX(work->angle.z));
    MTX_Concat33(&matRotY, &matRotX, &matRotXY);
    MTX_Concat33(&matRotZ, &matRotXY, &work->animator.work.rotation);

    work->animator.work.translation.x = work->translation.x;
    work->animator.work.translation.y = work->translation.y;
    work->animator.work.translation.z = work->translation.z;

    work->animator.work.scale.x = work->scale.x;
    work->animator.work.scale.y = work->scale.y;
    work->animator.work.scale.z = work->scale.z;

    work->animator.work.translation2.x = work->translation2.x;
    work->animator.work.translation2.y = work->translation2.y;
    work->animator.work.translation2.z = work->translation2.z;
}

void ProcessExDrawRequestModelPriority(EX_ACTION_NN_WORK *work)
{
    ExDrawCameraConfig *cameraA;
    ExDrawCameraConfig *cameraB;
    if (work->config.control.useInstanceUnknown == TRUE)
    {
        cameraA = &work->cameraConfig[GRAPHICS_ENGINE_A];
        cameraB = &work->cameraConfig[GRAPHICS_ENGINE_B];
    }
    else
    {
        cameraA = GetExDrawCameraConfigA();
        cameraB = GetExDrawCameraConfigB();
    }

    if (work->hitChecker.input.isBossFireRed || work->hitChecker.input.isBossFireBlue || work->hitChecker.input.isBossDragon || work->hitChecker.input.isBossMagmaWave
        || work->hitChecker.input.isBossHomingEffect || work->hitChecker.input.isBossShotEffect || work->hitChecker.input.isBossFireEffect
        || work->hitChecker.input.isBluntLineMissile || work->hitChecker.input.isSpikedLineMissile || work->hitChecker.input.isBossMeteorEffect
        || work->hitChecker.input.isBossFireballShotEffect || work->hitChecker.input.isBossFireballEffect || work->hitChecker.input.isIntroMeteor
        || work->hitChecker.input.isBossHitEffect)
    {
        if (work->model.translation.y > FLOAT_TO_FX32(36.751))
            work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_B;
        if (work->model.translation.y <= FLOAT_TO_FX32(36.751))
            work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;
    }

    ExDrawReqTaskConfig_ActiveScreens activeScreens = work->config.control.activeScreens;
    if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_BOTH)
    {
        if (Camera3D__UseEngineA())
        {
            ApplyExDrawCameraConfig(cameraA);
        }
        else
        {
            ApplyExDrawCameraConfig(cameraB);
        }
    }
    else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_A)
    {
        if (Camera3D__UseEngineA() == FALSE)
        {
            ApplyExDrawCameraConfig(cameraB);
            return;
        }

        work->config.control.isInvisible = TRUE;
    }
    else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_B)
    {
        if (Camera3D__UseEngineA())
        {
            ApplyExDrawCameraConfig(cameraA);
            return;
        }

        work->config.control.isInvisible = TRUE;
    }
}

void ProcessExDrawRequestModelUnknown(EX_ACTION_NN_WORK *work)
{
    s32 offset = (work->config.control.timer);
    offset += (mtMathRand() % 2);
    offset <<= 7;

    if (exHitCheckTask_IsPaused() == FALSE)
    {
        if (GetExDrawGlobalConfig()->control.timer != 0)
        {
            ProcessExDrawTimer(GetExDrawGlobalConfig());

            work->config.control.timer = GetExDrawGlobalConfig()->control.timer;

            offset = (work->config.control.timer);
            offset += (mtMathRand() % 2);
            offset <<= 7;
        }

        if (work->config.control.timer != 0)
        {
            if (mtMathRand() % 2)
                work->model.animator.work.translation.x += offset;
            else
                work->model.animator.work.translation.x -= offset;

            if (mtMathRand() % 2)
                work->model.animator.work.translation.y += offset;
            else
                work->model.animator.work.translation.y -= offset;

            if (mtMathRand() % 2)
                work->model.animator.work.translation.z += offset;
            else
                work->model.animator.work.translation.z -= offset;
        }
    }
}

BOOL AnimateExDrawRequestModel(EX_ACTION_NN_WORK *work)
{
    if (work->hitChecker.input.isBoss)
    {
        for (s16 i = 0; i < 15; i++)
        {
            AnimatePalette(&work->model.paletteAnimator[i]);
            DrawAnimatedPalette(&work->model.paletteAnimator[i]);
        }
    }

    if (work->config.graphics.forceStopAnimation)
    {
        work->model.primaryAnimResource = NULL;
        Stop3DExDrawRequestAnimation(&work->config);
    }

    if (work->config.graphics.disableAnimation)
        return FALSE;

    AnimatorMDL__ProcessAnimation(&work->model.animator);
    if (work->config.graphics.canFinish)
    {
        if (work->config.graphics.noStopOnFinish)
            return TRUE;

        if (IsExDrawRequestModelAnimFinished(work))
        {
            Stop3DExDrawRequestAnimation(&work->config);
            return FALSE;
        }
    }

    return TRUE;
}

void DrawExDrawRequestModel(EX_ACTION_NN_WORK *work)
{
    MtxFx43 mtxCurrent;

    if (work->config.control.isInvisible)
    {
        work->config.control.isInvisible = FALSE;
        return;
    }

    G3X_AlphaBlend(TRUE);

    if (work->hitChecker.input.isSuperSonicPlayer)
    {
        if (IsExDrawRequestModelAnimFinished(work))
        {
            Camera3D__UseEngineA();
            AnimatorMDL__Draw(&work->model.animator);
        }
        else
        {
            AnimatorMDL__Draw(&work->model.animator);
        }
    }
    else if (work->hitChecker.input.isBoss)
    {
        EX_ACTION_NN_WORK *bossWork = GetExBossAssets();
        AnimatorMDL__Draw(&work->model.animator);

        NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
        NNS_G3dGeRestoreMtx(NNS_G3D_MTXSTACK_SYS);
        NNS_G3dGetCurrentMtx(&mtxCurrent, NULL);
        bossWork->model.bossStaffPos.x = mtxCurrent.m[3][0];
        bossWork->model.bossStaffPos.y = mtxCurrent.m[3][1];
        bossWork->model.bossStaffPos.z = mtxCurrent.m[3][2];

        NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
        NNS_G3dGeRestoreMtx(NNS_G3D_MTXSTACK_USER);
        NNS_G3dGetCurrentMtx(&mtxCurrent, NULL);
        bossWork->model.bossChestPos.x = mtxCurrent.m[3][0];
        bossWork->model.bossChestPos.y = mtxCurrent.m[3][1];
        bossWork->model.bossChestPos.z = FLOAT_TO_FX32(60.0);
    }
    else
    {
        AnimatorMDL__Draw(&work->model.animator);
    }

    work->model.animator.work.translation.x = work->model.translation.x;
    work->model.animator.work.translation.y = work->model.translation.y;
    work->model.animator.work.translation.z = work->model.translation.z;
}

void ProcessExDrawRequestModelLighting(EX_ACTION_NN_WORK *work)
{
    GetExDrawLightConfig()->type = work->config.display.lightType;

    SetExDrawLightConfig(GetExDrawLightConfig());
}

void ProcessModelExDrawRequest(EX_ACTION_NN_WORK *work)
{
    ProcessExDrawRequestModelTransform(&work->model);
    ProcessExDrawRequestModelLighting(work);
    ProcessExDrawRequestModelUnknown(work);
    ProcessExDrawRequestModelPriority(work);
    DrawExDrawRequestModel(work);
}

BOOL IsExDrawRequestModelAnimFinished(EX_ACTION_NN_WORK *work)
{
    return (work->model.animator.animFlags[work->model.primaryAnimType] & ANIMATORMDL_FLAG_FINISHED) != 0;
}

void InitExDrawRequestTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *position, ExDrawReqTaskTrailType type)
{
    u16 angle = work->trail.angle;

    MI_CpuClear8(&work->hitChecker, sizeof(work->hitChecker));
    MI_CpuClear8(&work->trail, sizeof(work->trail));
    MI_CpuClear8(&work->config, sizeof(work->config));
    MI_CpuClear8(&work->cameraConfig[GRAPHICS_ENGINE_A], sizeof(work->cameraConfig[GRAPHICS_ENGINE_A]));
    MI_CpuClear8(&work->cameraConfig[GRAPHICS_ENGINE_B], sizeof(work->cameraConfig[GRAPHICS_ENGINE_B]));

    work->trail.angle = angle;
    work->trail.type  = type;

    switch (work->trail.type)
    {
        case EXDRAWREQTASK_TRAIL_PLAYER:
            InitExDrawRequestPlayerTrail(work, position);
            break;
        case EXDRAWREQTASK_TRAIL_BOSS_FIRE_DRAGON:
            InitExDrawRequestBossFireDragonTrail(work, position);
            break;
        case EXDRAWREQTASK_TRAIL_BOSS_HOMING_LASER:
            InitExDrawRequestBossHomingLaserTrail(work, position);
            break;
    }

    work->config.graphics.drawType          = EXDRAWREQTASK_TYPE_TRAIL;
    work->config.control.useInstanceUnknown = FALSE;
}

void InitExDrawRequestBossHomingLaserTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
    ExGraphicsTrail *trail = &work->trail;

    trail->trailOffset.x = FLOAT_TO_FX32(2.0);
    trail->trailOffset.y = FLOAT_TO_FX32(2.0);

    for (u16 i = 0; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->color[i] = GX_RGB_888(0xC8, 0xC8, 0xF0);
    }

    for (u16 i = 0; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->alpha[i] = GX_COLOR_FROM_888(0x00);
    }

    trail->id            = 0;
    trail->translation.x = pos->x;
    trail->translation.y = pos->y;
    trail->translation.z = pos->z;

    trail->unknownValue = 0;
    trail->angle += FLOAT_DEG_TO_IDX(90.0);

    trail->position[0].x = pos->x + MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[0].y = pos->y + MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[0].z = pos->z;

    trail->position[1].x = pos->x + MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[1].y = pos->y + MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[1].z = pos->z;

    trail->unknown.x = trail->position[0].x - pos->x;
    trail->unknown.y = trail->position[0].y - pos->y;
    trail->unknown.z = trail->position[0].z - pos->z;

    for (u16 i = 2; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->position[i].x = trail->position[i - 2].x;
        trail->position[i].y = trail->position[i - 2].y;
        trail->position[i].z = trail->position[i - 2].z;
    }

    work->hitChecker.type                         = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossHomingLaserTrail = TRUE;
    work->hitChecker.box.size.x                   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.y                   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.z                   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position                 = &work->trail.translation;
    work->config.control.activeScreens            = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
}

void ProcessExDrawRequestBossHomingLaserTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, ExDrawReqTaskHomingLaserTrailType type)
{
    s32 *trailAlpha;
    ExGraphicsTrail *trail = &work->trail;

    u32 offset;
    switch (type)
    {
        case EXDRAWREQTASK_HOMINGLASER_TRAIL_0:
            offset = FLOAT_TO_FX32(1.5);
            break;

        case EXDRAWREQTASK_HOMINGLASER_TRAIL_1:
            offset = FLOAT_TO_FX32(3.0);
            break;

        case EXDRAWREQTASK_HOMINGLASER_TRAIL_2:
            offset = FLOAT_TO_FX32(1.5);
            break;
    }

    trail->translation.x = pos->x;
    trail->translation.y = pos->y;
    trail->translation.z = pos->z;

    for (u16 i = (EXDRAW_TRAIL_SEGMENT_COUNT - 1); i >= 12; i--)
    {
        trail->position[i].x = trail->position[i - 2].x;
        trail->position[i].y = trail->position[i - 2].y;
        trail->position[i].z = trail->position[i - 2].z;

        if (trail->alpha[i - 2] > 1)
            trail->alpha[i] = trail->alpha[i - 2] - 2;
    }

    trail->position[10].x = trail->position[8].x;
    trail->position[10].y = trail->position[8].y;
    trail->position[10].z = trail->position[8].z;

    trailAlpha       = trail->alpha;
    trail->alpha[10] = trailAlpha[8];

    trail->position[11].x = trail->position[9].x;
    trail->position[11].y = trail->position[9].y;
    trail->position[11].z = trail->position[9].z;
    trail->alpha[11]      = trailAlpha[9];

    trail->angle += FLOAT_DEG_TO_IDX(90.0);

    trail->position[8].x = pos->x + MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[8].y = pos->y + MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[8].z = pos->z;
    trail->alpha[8]      = GX_COLOR_FROM_888(0xFF);

    trail->position[9].x = pos->x - MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[9].y = pos->y - MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[9].z = pos->z;
    trail->alpha[9]      = trailAlpha[8];

    trail->position[0].x = pos->x + FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[0].y = pos->y + offset;
    trail->position[0].z = pos->z;
    trail->alpha[0]      = GX_COLOR_FROM_888(0xFF);

    trail->position[1].x = pos->x - FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[1].y = pos->y + offset;
    trail->position[1].z = pos->z;
    trail->alpha[1]      = GX_COLOR_FROM_888(0xFF);

    trail->position[2].x = pos->x + offset;
    trail->position[2].y = pos->y + FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[2].z = pos->z;
    trail->alpha[2]      = GX_COLOR_FROM_888(0xFF);

    trail->position[3].x = pos->x - offset;
    trail->position[3].y = pos->y + FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[3].z = pos->z;
    trail->alpha[3]      = GX_COLOR_FROM_888(0xFF);

    trail->position[4].x = pos->x + offset;
    trail->position[4].y = pos->y - FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[4].z = pos->z;
    trail->alpha[4]      = GX_COLOR_FROM_888(0xFF);

    trail->position[5].x = pos->x - offset;
    trail->position[5].y = pos->y - FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[5].z = pos->z;
    trail->alpha[5]      = GX_COLOR_FROM_888(0xFF);

    trail->position[6].x = pos->x + FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[6].y = pos->y - offset;
    trail->position[6].z = pos->z;
    trail->alpha[6]      = GX_COLOR_FROM_888(0xFF);

    trail->position[7].x = pos->x - FX_Div(offset, FLOAT_TO_FX32(2.0));
    trail->position[7].y = pos->y - offset;
    trail->position[7].z = pos->z;
    trail->alpha[7]      = GX_COLOR_FROM_888(0xFF);
}

void InitExDrawRequestBossFireDragonTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
    ExGraphicsTrail *trail = &work->trail;

    trail->trailOffset.x = FLOAT_TO_FX32(8.0);
    trail->trailOffset.y = FLOAT_TO_FX32(8.0);

    for (u16 i = 0; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->color[i] = GX_RGB_888(0xFF, 0x88, 0x00);
        trail->alpha[i] = GX_COLOR_FROM_888(0x08);
    }

    trail->id            = 0;
    trail->translation.x = pos->x;
    trail->translation.y = pos->y;
    trail->translation.z = pos->z;

    trail->unknownValue = 0;
    trail->angle += FLOAT_DEG_TO_IDX(90.0);

    trail->position[0].x = pos->x + MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[0].y = pos->y + MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[0].z = pos->z;

    trail->position[1].x = pos->x + MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[1].y = pos->y + MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[1].z = pos->z;

    trail->unknown.x = trail->position[0].x - pos->x;
    trail->unknown.y = trail->position[0].y - pos->y;
    trail->unknown.z = trail->position[0].z - pos->z;

    for (u16 i = 2; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->position[i].x = trail->position[i - 2].x;
        trail->position[i].y = trail->position[i - 2].y;
        trail->position[i].z = trail->position[i - 2].z;
    }

    work->hitChecker.type              = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isTrailVFX  = TRUE;
    work->hitChecker.box.size.x        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position      = &work->trail.translation;
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
}

void ProcessExDrawRequestBossFireDragonTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
    ExGraphicsTrail *trail = &work->trail;

    trail->translation.x = pos->x;
    trail->translation.y = pos->y;
    trail->translation.z = pos->z;
    for (u16 i = (EXDRAW_TRAIL_SEGMENT_COUNT - 1); i >= 4; i--)
    {
        trail->position[i].x = trail->position[i - 2].x;
        trail->position[i].y = trail->position[i - 2].y;
        trail->position[i].z = trail->position[i - 2].z;

        if (trail->alpha[i - 2] > 1)
            trail->alpha[i] = trail->alpha[i - 2] - 2;
    }

    trail->position[2].x = trail->position[0].x;
    trail->position[2].y = trail->position[0].y;
    trail->position[2].z = trail->position[0].z;
    trail->alpha[2]      = trail->alpha[0];

    trail->position[3].x = trail->position[1].x;
    trail->position[3].y = trail->position[1].y;
    trail->position[3].z = trail->position[1].z;
    trail->alpha[3]      = trail->alpha[1];

    trail->alpha[0] = GX_COLOR_FROM_888(0xFF);
    trail->angle += FLOAT_DEG_TO_IDX(90.0);

    trail->position[0].x = pos->x + MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[0].y = pos->y + MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[0].z = pos->z;

    trail->position[1].x = pos->x - MultiplyFX(CosFX(trail->angle), trail->trailOffset.x);
    trail->position[1].y = pos->y - MultiplyFX(SinFX(trail->angle), trail->trailOffset.y);
    trail->position[1].z = pos->z;
    trail->alpha[1]      = trail->alpha[0];
}

void InitExDrawRequestPlayerTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
    ExGraphicsTrail *trail = &work->trail;

    trail->trailOffset.x = FLOAT_TO_FX32(2.5);
    trail->trailOffset.y = -FLOAT_TO_FX32(3.0);

    for (u16 i = 0; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->color[i] = GX_RGB_888(0xFF, 0xFF, 0x00);
        trail->alpha[i] = GX_COLOR_FROM_888(0x00);
    }

    trail->id            = 1;
    trail->translation.x = pos->x;
    trail->translation.y = pos->y;
    trail->translation.z = pos->z;

    trail->position[0].x = pos->x - FX_Div(trail->trailOffset.x, FLOAT_TO_FX32(2.0));
    trail->position[0].y = pos->y + trail->trailOffset.y;
    trail->position[0].z = pos->z;

    trail->position[1].x = pos->x + FX_Div(trail->trailOffset.x, FLOAT_TO_FX32(2.0));
    trail->position[1].y = pos->y + trail->trailOffset.y;
    trail->position[1].z = pos->z;

    for (u16 i = 2; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
    {
        trail->position[i].x = trail->position[i - 2].x;
        trail->position[i].y = trail->position[i - 2].y;
        trail->position[i].z = trail->position[i - 2].z;
    }

    work->hitChecker.type              = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isTrailVFX  = TRUE;
    work->hitChecker.box.size.x        = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.y        = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.size.z        = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position      = &work->trail.translation;
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;
}

void ProcessExDrawRequestPlayerTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, u32 type, ExPlayerCharacter character)
{
    ExGraphicsTrail *trail = &work->trail;

    trail->translation.x = pos->x;
    trail->translation.y = pos->y;
    trail->translation.z = pos->z;

    switch (type)
    {
        case 0:
            trail->trailOffset.x = FLOAT_TO_FX32(2.5);
            trail->trailOffset.y = -FLOAT_TO_FX32(3.0);
            break;

        case 1:
            trail->trailOffset.x = FLOAT_TO_FX32(1.5);
            trail->trailOffset.y = -FLOAT_TO_FX32(3.0);
            break;

        case 2:
            trail->trailOffset.x = FLOAT_TO_FX32(3.5);
            trail->trailOffset.y = -FLOAT_TO_FX32(4.0);
            break;

        case 3:
            trail->trailOffset.x = FLOAT_TO_FX32(2.5);
            trail->trailOffset.y = -FLOAT_TO_FX32(4.0);
            break;
    }

    switch (character)
    {
        case EXPLAYER_CHARACTER_SONIC:
            for (u16 i = 0; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
            {
                trail->color[i] = GX_RGB_888(0xFF, 0xFF, 0x00);
            }
            break;

        case EXPLAYER_CHARACTER_BLAZE:
            for (u16 i = 0; i < EXDRAW_TRAIL_SEGMENT_COUNT; i++)
            {
                trail->color[i] = GX_RGB_888(0xFF, 0x00, 0xFF);
            }
            break;
    }

    for (u16 i = (EXDRAW_TRAIL_SEGMENT_COUNT - 1); i >= 4; i--)
    {
        trail->position[i].x = trail->position[i - 2].x;
        trail->position[i].y = trail->position[i - 2].y + trail->trailOffset.y;
        trail->position[i].z = trail->position[i - 2].z;

        if ((i % 2) == 0)
        {
            if (i < 10)
            {
                if (trail->alpha[i - 2] < (EXDRAW_TRAIL_SEGMENT_COUNT - 1))
                    trail->alpha[i] = trail->alpha[i - 2] + 2;
            }
            else
            {
                if (trail->alpha[i - 2] > 0)
                    trail->alpha[i] = trail->alpha[i - 2] - 2;
            }
        }
    }

    trail->position[2].x = trail->position[0].x - FX_Div(trail->trailOffset.x, FLOAT_TO_FX32(2.0));
    trail->position[2].y = trail->position[0].y + trail->trailOffset.y;
    trail->position[2].z = trail->position[0].z;
    trail->alpha[2]      = trail->alpha[0];

    trail->position[3].x = trail->position[1].x + FX_Div(trail->trailOffset.x, FLOAT_TO_FX32(2.0));
    trail->position[3].y = trail->position[1].y + trail->trailOffset.y;
    trail->position[3].z = trail->position[1].z;
    trail->alpha[3]      = trail->alpha[1];

    trail->alpha[0]      = GX_COLOR_FROM_888(0x7F);
    trail->position[0].x = pos->x - FX_Div(trail->trailOffset.x, FLOAT_TO_FX32(2.0));
    trail->position[0].y = pos->y + trail->trailOffset.y;
    trail->position[0].z = pos->z;

    trail->position[1].x = pos->x + FX_Div(trail->trailOffset.x, FLOAT_TO_FX32(2.0));
    trail->position[1].y = pos->y + trail->trailOffset.y;
    trail->position[1].z = pos->z;
    trail->alpha[1]      = trail->alpha[0];
}

NONMATCH_FUNC void ProcessTrailExDrawRequest(EX_ACTION_TRAIL_WORK *work)
{
    // https://decomp.me/scratch/Fmh68 -> 99.74%
#ifdef NON_MATCHING
    VecFx16 trailBuffer[EXDRAW_TRAIL_SEGMENT_COUNT];
    MtxFx43 matrix;
    u16 i;

    ExGraphicsTrail *trail = &work->trail;
    if (exDrawFadeTask__word_2176444[0] < 10)
    {
        exDrawFadeTask__word_2176444[0]++;
        return;
    }

    if (Camera3D__GetTask() == NULL)
        return;

    Unknown2066510__Func_2066D18(trail->position, ARRAY_COUNT(trailBuffer), trailBuffer, &matrix);

    ExDrawCameraConfig *cameraA;
    ExDrawCameraConfig *cameraB;
    if (work->config.control.useInstanceUnknown == TRUE)
    {
        cameraA = &work->cameraConfig[GRAPHICS_ENGINE_A];
        cameraB = &work->cameraConfig[GRAPHICS_ENGINE_B];
    }
    else
    {
        cameraA = GetExDrawCameraConfigA();
        cameraB = GetExDrawCameraConfigB();
    }

    if (cameraA == NULL || cameraB == NULL)
        return;

    ExDrawReqTaskConfig_ActiveScreens activeScreens = work->config.control.activeScreens;
    if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_BOTH)
    {
        if (Camera3D__UseEngineA())
        {
            Camera3D__LoadState(&cameraA->currentCamera);
        }
        else
        {
            Camera3D__LoadState(&cameraB->currentCamera);
        }
    }
    else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_A)
    {
        if (Camera3D__UseEngineA() != FALSE)
            return;

        Camera3D__LoadState(&cameraB->currentCamera);
    }
    else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_B)
    {
        if (Camera3D__UseEngineA() == FALSE)
            return;

        Camera3D__LoadState(&cameraA->currentCamera);
    }

    NNS_G3dGlbFlushVP();
    NNS_G3dGeTexImageParam(GX_TEXFMT_NONE, GX_TEXGEN_NONE, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS, 0x00000000);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
    NNS_G3dGeLoadMtx43(&matrix);

    for (i = 0; i < ARRAY_COUNT(trailBuffer) - 2; i += 2)
    {
        if (trail->alpha[i] > 0)
        {
            switch (work->trail.type)
            {
                case EXDRAWREQTASK_TRAIL_PLAYER:
                    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, trail->id, trail->alpha[i], GX_POLYGON_ATTR_MISC_XLU_DEPTH_UPDATE);
                    NNS_G3dGeColor(trail->color[i]);
                    break;

                case EXDRAWREQTASK_TRAIL_BOSS_FIRE_DRAGON:
                    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, trail->id, trail->alpha[i], GX_POLYGON_ATTR_MISC_XLU_DEPTH_UPDATE);
                    NNS_G3dGeColor(trail->color[i]);
                    break;

                case EXDRAWREQTASK_TRAIL_BOSS_HOMING_LASER:
                    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_BACK, trail->id, trail->alpha[i], GX_POLYGON_ATTR_MISC_XLU_DEPTH_UPDATE);
                    NNS_G3dGeColor(trail->color[i]);
                    break;
            }

            NNS_G3dGeBegin(GX_BEGIN_QUADS);
            NNS_G3dGeVtx10(trailBuffer[i + 0].x, trailBuffer[i + 0].y, trailBuffer[i + 0].z);
            NNS_G3dGeVtx10(trailBuffer[i + 1].x, trailBuffer[i + 1].y, trailBuffer[i + 1].z);
            NNS_G3dGeVtx10(trailBuffer[i + 3].x, trailBuffer[i + 3].y, trailBuffer[i + 3].z);
            NNS_G3dGeVtx10(trailBuffer[i + 2].x, trailBuffer[i + 2].y, trailBuffer[i + 2].z);
            NNS_G3dGeEnd();
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x118
	ldr r1, =exDrawFadeTask__word_2176444
	mov r4, r0
	ldrh r0, [r1, #0]
	add r9, r4, #0x1c
	cmp r0, #0xa
	addlo r0, r0, #1
	addlo sp, sp, #0x118
	strloh r0, [r1]
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl Camera3D__GetTask
	cmp r0, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r2, sp, #0x64
	add r3, sp, #0x34
	add r0, r9, #8
	mov r1, #0x1e
	bl Unknown2066510__Func_2066D18
	ldrb r0, [r4, #0x26c]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq r5, r4, #0x274
	addeq r6, r4, #0x318
	beq _021632B4
	bl GetExDrawCameraConfigA
	mov r5, r0
	bl GetExDrawCameraConfigB
	mov r6, r0
_021632B4:
	cmp r5, #0
	cmpne r6, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r0, [r4, #0x26c]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _021632F8
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021632EC
	mov r0, r5
	bl Camera3D__LoadState
	b _0216333C
_021632EC:
	mov r0, r6
	bl Camera3D__LoadState
	b _0216333C
_021632F8:
	cmp r0, #1
	bne _0216331C
	bl Camera3D__UseEngineA
	cmp r0, #0
	addne sp, sp, #0x118
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r6
	bl Camera3D__LoadState
	b _0216333C
_0216331C:
	cmp r0, #2
	bne _0216333C
	bl Camera3D__UseEngineA
	cmp r0, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl Camera3D__LoadState
_0216333C:
	bl NNS_G3dGlbFlushVP
	mov r3, #0x20000000
	add r1, sp, #0x30
	mov r0, #0x2a
	mov r2, #1
	str r3, [sp, #0x30]
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	add r1, sp, #0x2c
	mov r0, #0x10
	str r2, [sp, #0x2c]
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x34
	mov r0, #0x17
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r11, #6
	add r6, r4, #0x200
	ldr r5, =0x000003FF
	mov r8, #0
	add r7, sp, #0x64
	mov r4, r11
_02163394:
	add r0, r9, r8, lsl #2
	ldr r1, [r0, #0x1ac]
	cmp r1, #0
	ble _021635BC
	ldrh r0, [r6, #0x64]
	cmp r0, #1
	beq _021633C4
	cmp r0, #2
	beq _0216340C
	cmp r0, #3
	beq _02163454
	b _02163498
_021633C4:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x8c0
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x28]
	add r1, sp, #0x28
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x24
	str r2, [sp, #0x24]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02163498
_0216340C:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x880
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x20]
	add r1, sp, #0x20
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x1c
	str r2, [sp, #0x1c]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02163498
_02163454:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x880
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x18]
	add r1, sp, #0x18
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x14
	str r2, [sp, #0x14]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_02163498:
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, #0x40
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mul r0, r8, r11
	add r3, r7, r0
	ldrsh r1, [r7, r0]
	ldrsh r0, [r3, #2]
	ldrsh r2, [r3, #4]
	and r1, r5, r1, asr #6
	mov r0, r0, asr #6
	mov r2, r2, asr #6
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #12
	mov r2, r2, lsl #0x16
	orr r0, r0, r2, lsr #2
	str r0, [sp, #0xc]
	mov r0, #0x24
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mla r10, r8, r4, r7
	ldrsh r1, [r10, #8]
	ldrsh r0, [r10, #0xa]
	ldrsh r2, [r10, #6]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp, #8]
	mov r0, #0x24
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldrsh r1, [r10, #0x14]
	ldrsh r0, [r10, #0x16]
	ldrsh r2, [r10, #0x12]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp, #4]
	mov r0, #0x24
	add r1, sp, #4
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldrsh r1, [r10, #0xe]
	ldrsh r0, [r10, #0x10]
	ldrsh r2, [r10, #0xc]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp]
	mov r0, #0x24
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x41
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
_021635BC:
	add r0, r8, #2
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x1c
	blo _02163394
	add sp, sp, #0x118
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void InitExDrawRequestSprite3DWorker(ExGraphicsSprite3D *work)
{
    MI_CpuClear16(work, sizeof(*work));

    work->anim = 0;

    work->angle.x = FLOAT_DEG_TO_IDX(0.0);
    work->angle.y = FLOAT_DEG_TO_IDX(0.0);
    work->angle.z = FLOAT_DEG_TO_IDX(0.0);

    work->translation.x = FLOAT_TO_FX32(0.0);
    work->translation.y = FLOAT_TO_FX32(0.0);
    work->translation.z = FLOAT_TO_FX32(0.0);

    work->scale.x = FLOAT_TO_FX32(1.0);
    work->scale.y = FLOAT_TO_FX32(1.0);
    work->scale.z = FLOAT_TO_FX32(1.0);

    work->translation2.x = FLOAT_TO_FX32(0.0);
    work->translation2.y = FLOAT_TO_FX32(0.0);
    work->translation2.z = FLOAT_TO_FX32(0.0);
}

void InitExDrawRequestSprite3DConfig(exDrawReqTaskConfig *work)
{
    work->control.activeScreens      = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
    work->control.isInvisible        = FALSE;
    work->control.useInstanceUnknown = FALSE;
    work->control.timer              = 0;

    work->graphics.unknown            = FALSE;
    work->graphics.disableAnimation   = FALSE;
    work->graphics.canFinish          = FALSE;
    work->graphics.noStopOnFinish     = TRUE;
    work->graphics.forceStopAnimation = FALSE;
    work->display.unknown             = FALSE;
    work->graphics.drawType           = EXDRAWREQTASK_TYPE_SPRITE3D;

    work->priority = EXDRAWREQTASK_PRIORITY_LOWEST;
}

void InitExDrawRequestSprite3D(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3DWorker(&work->sprite);
    exHitCheckTask_InitHitChecker(&work->hitChecker);
    InitExDrawRequestSprite3DConfig(&work->config);
}

void ProcessExDrawRequestSprite3DTransform(ExGraphicsSprite3D *work)
{
    MtxFx33 matRotZ;
    MtxFx33 matRotY;
    MtxFx33 matRotX;
    MtxFx33 matRotXY;

    MTX_RotX33(&matRotX, SinFX(work->angle.x), CosFX(work->angle.x));
    MTX_RotY33(&matRotY, SinFX(work->angle.y), CosFX(work->angle.y));
    MTX_RotZ33(&matRotZ, SinFX(work->angle.z), CosFX(work->angle.z));
    MTX_Concat33(&matRotY, &matRotX, &matRotXY);
    MTX_Concat33(&matRotZ, &matRotXY, &work->animator.work.rotation);

    work->animator.work.translation.x = work->translation.x;
    work->animator.work.translation.y = work->translation.y;
    work->animator.work.translation.z = work->translation.z;

    work->animator.work.scale.x = work->scale.x;
    work->animator.work.scale.y = work->scale.y;
    work->animator.work.scale.z = work->scale.z;

    work->animator.work.translation2.x = work->translation2.x;
    work->animator.work.translation2.y = work->translation2.y;
    work->animator.work.translation2.z = work->translation2.z;
}

void ProcessExDrawRequestSprite3DPriority(EX_ACTION_BAC3D_WORK *work)
{
    ExDrawCameraConfig *cameraA;
    ExDrawCameraConfig *cameraB;
    if (work->config.control.useInstanceUnknown == TRUE)
    {
        cameraA = &work->cameraConfig[GRAPHICS_ENGINE_A];
        cameraB = &work->cameraConfig[GRAPHICS_ENGINE_B];
    }
    else
    {
        cameraA = GetExDrawCameraConfigA();
        cameraB = GetExDrawCameraConfigB();
    }

    if (work->hitChecker.input.isBlazeFireballEffect || work->hitChecker.input.isRing || work->hitChecker.input.isBossMeteorBomb)
    {
        if (work->sprite.translation.y > FLOAT_TO_FX32(36.751))
            work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_B;
        if (work->sprite.translation.y <= FLOAT_TO_FX32(36.751))
            work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;
    }

    ExDrawReqTaskConfig_ActiveScreens activeScreens = work->config.control.activeScreens;
    if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_BOTH)
    {
        if (Camera3D__UseEngineA())
        {
            ApplyExDrawCameraConfig(cameraA);
        }
        else
        {
            ApplyExDrawCameraConfig(cameraB);
        }
    }
    else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_A)
    {
        if (Camera3D__UseEngineA() == FALSE)
        {
            ApplyExDrawCameraConfig(cameraB);
            return;
        }

        work->config.control.isInvisible = TRUE;
    }
    else if (activeScreens == EXDRAWREQTASKCONFIG_SCREEN_B)
    {
        if (Camera3D__UseEngineA())
        {
            ApplyExDrawCameraConfig(cameraA);
            return;
        }

        work->config.control.isInvisible = TRUE;
    }
}

void ProcessExDrawRequestSprite3DUnknown(EX_ACTION_BAC3D_WORK *work)
{
    s32 offset = (work->config.control.timer);
    offset += (mtMathRand() % 2);
    offset <<= 7;

    if (exHitCheckTask_IsPaused() == FALSE)
    {
        if (GetExDrawGlobalConfig()->control.timer != 0)
        {
            ProcessExDrawTimer(GetExDrawGlobalConfig());

            work->config.control.timer = GetExDrawGlobalConfig()->control.timer;

            offset = (work->config.control.timer);
            offset += (mtMathRand() % 2);
            offset <<= 7;
        }

        if (work->config.control.timer != 0)
        {
            if (mtMathRand() % 2)
                work->sprite.animator.work.translation.x += offset;
            else
                work->sprite.animator.work.translation.x -= offset;

            if (mtMathRand() % 2)
                work->sprite.animator.work.translation.y += offset;
            else
                work->sprite.animator.work.translation.y -= offset;

            if (mtMathRand() % 2)
                work->sprite.animator.work.translation.z += offset;
            else
                work->sprite.animator.work.translation.z -= offset;
        }
    }
}

void AnimateExDrawRequestSprite3D(EX_ACTION_BAC3D_WORK *work)
{
    if (work->config.graphics.forceStopAnimation)
    {
        work->sprite.animator.animatorSprite.animFrameCount = 1;
        work->sprite.animator.animatorSprite.frameTimer     = 0;
        Stop3DExDrawRequestAnimation(&work->config);
    }

    if (work->config.graphics.disableAnimation == FALSE)
    {
        AnimatorSprite3D__ProcessAnimationFast(&work->sprite.animator);

        if (work->config.graphics.canFinish)
        {
            if (work->config.graphics.noStopOnFinish)
                return;

            if (IsExDrawRequestSprite3DAnimFinished(work))
                Stop3DExDrawRequestAnimation(&work->config);
        }
    }
}

void DrawExDrawRequestSprite3D(EX_ACTION_BAC3D_WORK *work)
{
    if (work->config.control.isInvisible)
    {
        work->config.control.isInvisible = FALSE;
    }
    else
    {
        G3X_AlphaBlend(TRUE);
        AnimatorSprite3D__Draw(&work->sprite.animator);

        work->sprite.animator.work.translation.x = work->sprite.translation.x;
        work->sprite.animator.work.translation.y = work->sprite.translation.y;
        work->sprite.animator.work.translation.z = work->sprite.translation.z;
    }
}

void ProcessSprite3DExDrawRequest(EX_ACTION_BAC3D_WORK *work)
{
    ProcessExDrawRequestSprite3DTransform(&work->sprite);
    SetExDrawLightConfig(GetExDrawLightConfig());
    ProcessExDrawRequestSprite3DUnknown(work);
    ProcessExDrawRequestSprite3DPriority(work);
    DrawExDrawRequestSprite3D(work);
}

BOOL IsExDrawRequestSprite3DAnimFinished(EX_ACTION_BAC3D_WORK *work)
{
    return (work->sprite.animator.animatorSprite.flags & ANIMATOR_FLAG_DID_FINISH) != 0;
}

void ExDrawFadeTask_Main_Init(void)
{
    exDrawFadeTask *work = ExTaskGetWorkCurrent(exDrawFadeTask);

    work->hasStarted = FALSE;

    SetCurrentExTaskMainEvent(ExDrawFadeTask_Main_Active);
    ExDrawFadeTask_Main_Active();
}

void ExDrawFadeTask_OnCheckStageFinished(void)
{
    exDrawFadeTask *work = ExTaskGetWorkCurrent(exDrawFadeTask);
    UNUSED(work);
}

void ExDrawFadeTask_Destructor(void)
{
    exDrawFadeTask *work = ExTaskGetWorkCurrent(exDrawFadeTask);
    UNUSED(work);
}

void ExDrawFadeTask_Main_Active(void)
{
    exDrawFadeTask *work = ExTaskGetWorkCurrent(exDrawFadeTask);

    work->timer++;

    s32 progress = work->timer - work->delay;
    if (progress >= 0)
    {
        s32 brightness = work->brightness;
        if (work->hasStarted)
            brightness += (progress * (work->targetBrightness - brightness)) / work->duration;
        else
            work->hasStarted = TRUE;

        if ((work->flags & EXDRAWFADETASK_FLAG_ON_ENGINE_A) != 0)
        {
            if (brightness < RENDERCORE_BRIGHTNESS_BLACK)
                brightness = RENDERCORE_BRIGHTNESS_BLACK;

            if (brightness > RENDERCORE_BRIGHTNESS_WHITE)
                brightness = RENDERCORE_BRIGHTNESS_WHITE;

            Camera3D__GetWork()->gfxControl[0].brightness = brightness;
        }

        if ((work->flags & EXDRAWFADETASK_FLAG_ON_ENGINE_B) != 0)
        {
            if (brightness < RENDERCORE_BRIGHTNESS_BLACK)
                brightness = RENDERCORE_BRIGHTNESS_BLACK;

            if (brightness > RENDERCORE_BRIGHTNESS_WHITE)
                brightness = RENDERCORE_BRIGHTNESS_WHITE;

            Camera3D__GetWork()->gfxControl[1].brightness = brightness;
        }

        if (progress >= work->duration)
        {
            if ((work->flags & EXDRAWFADETASK_FLAG_ON_ENGINE_A) != 0)
                Camera3D__GetWork()->gfxControl[0].brightness = work->targetBrightness;

            if ((work->flags & EXDRAWFADETASK_FLAG_ON_ENGINE_B) != 0)
                Camera3D__GetWork()->gfxControl[1].brightness = work->targetBrightness;

            DestroyCurrentExTask();
        }
        else
        {
            RunCurrentExTaskOnCheckStageFinishedEvent();
        }
    }
}

void CreateExDrawFadeTask(s32 brightness, s32 targetBrightness, s32 duration, s32 delay, ExDrawFadeTaskFlags flags)
{
    if (duration == 0)
        return;

    Task *task = ExTaskCreate(ExDrawFadeTask_Main_Init, ExDrawFadeTask_Destructor, TASK_PRIORITY_RENDER_LIST_START, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exDrawFadeTask);

    exDrawFadeTask *work = ExTaskGetWork(task, exDrawFadeTask);
    TaskInitWork8(work);

    SetExTaskOnCheckStageFinishedEvent(task, ExDrawFadeTask_OnCheckStageFinished);

    if (brightness < RENDERCORE_BRIGHTNESS_BLACK)
        brightness = RENDERCORE_BRIGHTNESS_BLACK;
    if (brightness > RENDERCORE_BRIGHTNESS_WHITE)
        brightness = RENDERCORE_BRIGHTNESS_WHITE;

    // Not sure what's happening here, perhaps this is a bug?
    if (targetBrightness < RENDERCORE_BRIGHTNESS_BLACK)
        brightness = RENDERCORE_BRIGHTNESS_BLACK;
    if (targetBrightness > RENDERCORE_BRIGHTNESS_WHITE)
        brightness = RENDERCORE_BRIGHTNESS_WHITE;

    work->timer            = 0;
    work->brightness       = brightness;
    work->targetBrightness = targetBrightness;
    work->duration         = duration;
    work->delay            = delay;
    work->flags            = flags;
}

void ExDrawReqTask_Main_Init(void)
{
    exDrawReqTask *work = ExTaskGetWorkCurrent(exDrawReqTask);

    requestBuffer = HeapAllocHead(HEAP_USER, EXDRAWREQ_REQUEST_LIST_SIZE * sizeof(exDrawRequest));
    InitExDrawRequestList();
    InitAllExDrawRequests(work->currentRequest);
    InitExDrawGlobalConfig();

    SetCurrentExTaskMainEvent(ExDrawReqTask_Main_Process);
    ExDrawReqTask_Main_Process();
}

void ExDrawReqTask_OnCheckStageFinished(void)
{
    exDrawReqTask *work = ExTaskGetWorkCurrent(exDrawReqTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExDrawReqTask_Destructor(void)
{
    exDrawReqTask *work = ExTaskGetWorkCurrent(exDrawReqTask);
    UNUSED(work);

    HeapFree(HEAP_USER, requestBuffer);
    requestBuffer = NULL;
}

void ExDrawReqTask_Main_Process(void)
{
    exDrawReqTask *work = ExTaskGetWorkCurrent(exDrawReqTask);

    exDrawRequest *request = currentRequestList;
    for (work->currentRequest = currentRequestList; request != NULL; work->currentRequest = request)
    {
        if (request->slot == 0 || request->priority == EXDRAWREQTASK_PRIORITY_LOWEST || request->drawWork == NULL || request->type == EXDRAWREQTASK_TYPE_NONE)
            break;

        if (request->type == EXDRAWREQTASK_TYPE_SPRITE2D)
        {
            ProcessSprite2DExDrawRequest(&request->sprite2D);
        }
        else if (request->type == EXDRAWREQTASK_TYPE_MODEL)
        {
            ProcessModelExDrawRequest(&request->model);
        }
        else if (request->type == EXDRAWREQTASK_TYPE_SPRITE3D)
        {
            ProcessSprite3DExDrawRequest(&request->sprite3D);
        }
        else if (request->type == EXDRAWREQTASK_TYPE_TRAIL)
        {
            ProcessTrailExDrawRequest(&request->trail);
        }

        request = work->currentRequest->next;
    }

    if (exHitCheckTask_IsPaused())
    {
        EnableExTaskNoUpdate(TRUE);
    }
    else
    {
        EnableExTaskNoUpdate(FALSE);
        InitAllExDrawRequests(work->currentRequest);
        InitExDrawRequestList();
        ExUtils_ResetRenderTransform();
    }

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void CreateExDrawReqTask(void)
{
    Task *task = ExTaskCreate(ExDrawReqTask_Main_Init, ExDrawReqTask_Destructor, TASK_PRIORITY_UPDATE_LIST_END - 1, TASK_GROUP(3), 0, EXTASK_TYPE_ALWAYSUPDATE, exDrawReqTask);

    exDrawReqTask *work = ExTaskGetWork(task, exDrawReqTask);
    TaskInitWork8(work);

    SetExTaskOnCheckStageFinishedEvent(task, ExDrawReqTask_OnCheckStageFinished);
}

void AddExDrawRequest(void *work, exDrawReqTaskConfig *config)
{
    if (CheckExStageFinished() == FALSE && requestListSize < EXDRAWREQ_REQUEST_LIST_SIZE)
    {
        exDrawRequest *request = nextRequestList;
        exDrawRequest *next    = currentRequestList;

        request->type = config->graphics.drawType;

        exDrawRequest **requestList = &currentRequestList;
        exHitCheckTask_DoArenaBoundsCheck(work, request->type);

        if (request->type == EXDRAWREQTASK_TYPE_SPRITE2D)
        {
            MI_CpuCopy8(work, &request->sprite2D, sizeof(request->sprite2D));
        }
        else if (request->type == EXDRAWREQTASK_TYPE_MODEL)
        {
            MI_CpuCopy8(work, &request->model, sizeof(request->model));
        }
        else if (request->type == EXDRAWREQTASK_TYPE_SPRITE3D)
        {
            MI_CpuCopy8(work, &request->sprite3D, sizeof(request->sprite3D));
        }
        else if (request->type == EXDRAWREQTASK_TYPE_TRAIL)
        {
            MI_CpuCopy8(work, &request->trail, sizeof(request->trail));
        }

        requestListSize++;
        request->slot     = requestListSize;
        request->priority = config->priority;
        request->drawWork = work;

        for (; next; next = next->next)
        {
            if (request->priority >= next->priority)
                break;

            requestList = &next->next;
        }

        *requestList  = request;
        request->next = next;

        nextRequestList++;
    }
}

void InitAllExDrawRequests(void *list)
{
    for (u16 i = 0; i < EXDRAWREQ_REQUEST_LIST_SIZE; i++)
    {
        InitExDrawRequest(&requestBuffer[i]);
    }
}

void InitExDrawRequest(void *req)
{
    exDrawRequest *request = (exDrawRequest *)req;

    request->slot     = 0;
    request->priority = EXDRAWREQTASK_PRIORITY_LOWEST;
    request->type     = EXDRAWREQTASK_TYPE_NONE;
    request->next     = NULL;
    request->drawWork = NULL;
}

void InitExDrawRequestList(void)
{
    nextRequestList    = requestBuffer;
    currentRequestList = NULL;
    requestListSize    = 0;
}

void SetExDrawRequestPriority(exDrawReqTaskConfig *work, ExDrawReqTaskPriority priority)
{
    work->priority = priority;
}

void SetExDrawRequestAnimStopOnFinish(exDrawReqTaskConfig *config)
{
    config->graphics.canFinish          = TRUE;
    config->graphics.disableAnimation   = FALSE;
    config->graphics.noStopOnFinish     = FALSE;
    config->graphics.forceStopAnimation = FALSE;
}

void SetExDrawRequestAnimAsOneShot(exDrawReqTaskConfig *config)
{
    config->graphics.canFinish          = TRUE;
    config->graphics.disableAnimation   = FALSE;
    config->graphics.noStopOnFinish     = TRUE;
    config->graphics.forceStopAnimation = FALSE;
}

void Stop3DExDrawRequestAnimation(exDrawReqTaskConfig *config)
{
    config->graphics.canFinish          = FALSE;
    config->graphics.disableAnimation   = TRUE;
    config->graphics.noStopOnFinish     = FALSE;
    config->graphics.forceStopAnimation = FALSE;
}

exDrawReqTaskConfig *GetExDrawGlobalConfig(void)
{
    return &globalModelConfig;
}

void InitExDrawGlobalConfig(void)
{
    MI_CpuClear8(&globalModelConfig, sizeof(globalModelConfig));
}

BOOL SetExDrawRequestGlobalModelConfigTimer(u8 duration)
{
    if (duration > 15)
        return FALSE;

    GetExDrawGlobalConfig()->control.timer = duration;
    return TRUE;
}

BOOL ProcessExDrawTimer(exDrawReqTaskConfig *config)
{
    if (config->control.timer == 0)
        return TRUE;

    config->control.timer--;
    return FALSE;
}

void SetExDrawLightType(exDrawReqTaskConfig *config, ExDrawReqLightType type)
{
    if (type <= EXDRAWREQ_LIGHT_DEFAULT)
        config->display.lightType = type;
}