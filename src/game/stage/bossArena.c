#include <game/stage/bossArena.h>
#include <game/math/unknown2066510.h>
#include <game/graphics/background.h>

// --------------------
// TYPES
// --------------------

typedef void (*BossArenaFunc1)(BossArena *work, BossArenaCamera *camera);
typedef void (*BossArenaFunc2)(BossArena *work);

// --------------------
// VARIABLES
// --------------------

static Task *bossArenaTaskSingleton;

const u32 BossArena__explosionFXSpawnTime[3] = { 90, 135, 150 };

NOT_DECOMPILED const BossArenaFunc1 BossArena__CamFuncTable[BOSSARENA_TYPE_COUNT];
NOT_DECOMPILED const BossArenaFunc2 BossArena__MainFuncTable[BOSSARENACAMERA_TYPE_COUNT];

// static const BossArenaFunc1 BossArena__CamFuncTable[BOSSARENA_TYPE_COUNT] = { BossArena__CamFunc_Type0, BossArena__CamFunc_Type1 };
//
// static const BossArenaFunc2 BossArena__MainFuncTable[BOSSARENACAMERA_TYPE_COUNT] = {
//     BossArena__MainFunc_Type0, BossArena__MainFunc_Type1, BossArena__MainFunc_Type2, BossArena__MainFunc_Type3, BossArena__MainFunc_Type4,
// };

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void BossArena__Create(BossArenaType type, u32 priority)
{
    // https://decomp.me/scratch/5mcUr -> 81.59%
#ifdef NON_MATCHING
    Task *task             = TaskCreate(BossArena__Main, BossArena__Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, priority, TASK_GROUP(3), BossArena);
    bossArenaTaskSingleton = task;

    BossArena *work = TaskGetWork(task, BossArena);
    TaskInitWork16(work);

    work->type = type;

    work->field_358 = 0;
    work->field_35C = 0x2AAA;

    for (s32 i = 0; i < 3; i++)
    {
        BossArena__InitCamera(&work->camera[i]);
    }

    BossArenaUnknown4A8 *unknown = &work->background.field_148;

    unknown->field_10      = 0;
    unknown->field_18      = 0;
    unknown->field_1C      = VRAM_GET_PALETTE_COLOR(VRAMSystem__VRAM_PALETTE_BG[GRAPHICS_ENGINE_A], 0);
    unknown->field_20      = 0;
    unknown->field_24      = VRAM_GET_PALETTE_COLOR(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A], 0);
    unknown->mappingsMode  = MAPPINGS_MODE_TEXT_512x256_A;
    unknown->displayWidth  = BOSSARENA_BACKGROUND_TILE_WIDTH;
    unknown->displayHeight = BOSSARENA_BACKGROUND_TILE_HEIGHT;

    BossArena__Process(work);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	str r1, [sp]
	mov r0, #3
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x000004FC
	ldr r0, =BossArena__Main
	ldr r1, =BossArena__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, =bossArenaTaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, =0x000004FC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	str r5, [r4]
	mov r5, #0
	ldr r1, =0x00002AAA
	str r5, [r4, #0x358]
	add r0, r4, #0x300
	strh r1, [r0, #0x5c]
	add r6, r4, #4
_0203972C:
	mov r0, r6
	bl BossArena__InitCamera
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x11c
	blt _0203972C
	add r0, r4, #0xa8
	ldr r2, =VRAMSystem__VRAM_PALETTE_BG
	ldr r1, =VRAMSystem__VRAM_BG
	add ip, r0, #0x400
	mov r3, #0
	str r3, [ip, #0x10]
	ldr r0, [r2, #0]
	str r3, [ip, #0x18]
	str r0, [ip, #0x1c]
	ldr r0, [r1, #0]
	str r3, [ip, #0x20]
	str r0, [ip, #0x24]
	mov r0, #1
	str r0, [ip, #0x28]
	mov r1, #0x21
	mov r0, r4
	strh r1, [ip, #0x34]
	mov r1, #0x19
	strh r1, [ip, #0x36]
	bl BossArena__Process
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

void BossArena__Destroy(void)
{
    if (bossArenaTaskSingleton != NULL)
    {
        DestroyTask(bossArenaTaskSingleton);
        bossArenaTaskSingleton = NULL;
    }
}

void BossArena__DoProcess(void)
{
    BossArena *work = TaskGetWork(bossArenaTaskSingleton, BossArena);

    BossArena__Process(work);
}

void BossArena__SetType(BossArenaType type)
{
    BossArena *work = BossArena__GetWork();

    work->type = type;
}

s32 BossArena__GetType(void)
{
    BossArena *work = BossArena__GetWork();

    return work->type;
}

BossArenaCamera *BossArena__GetCamera(s32 id)
{
    BossArena *work = BossArena__GetWork();

    return &work->camera[id];
}

void BossArena__SetField358(s32 value)
{
    BossArena *work = BossArena__GetWork();

    work->field_358 = value;
}

void BossArena__SetField35C(s32 value)
{
    BossArena *work = BossArena__GetWork();

    work->field_35C = value;
}

void BossArena__SetCameraType(BossArenaCamera *camera, BossArenaCameraType type)
{
    camera->type = type;
}

Camera3D *BossArena__GetCameraConfig2(BossArenaCamera *camera)
{
    return &camera->camera;
}

Camera3D *BossArena__GetCameraConfig(BossArenaCamera *camera)
{
    return &camera->camera;
}

void BossArena__SetCameraConfig(BossArenaCamera *camera, CameraConfig *config)
{
    MI_CpuCopy16(config, &camera->camera.config, sizeof(camera->camera.config));
}

void BossArena__SetUpVector(BossArenaCamera *camera, VecFx32 *up)
{
    camera->upDir = *up;
}

void BossArena__SetNextPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z)
{
    camera->nextPosition.x = x;
    camera->nextPosition.y = y;
    camera->nextPosition.z = z;
}

void BossArena__SetTracker1TargetPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z)
{
    camera->positionTracker[1].targetTrackPos.x = x;
    camera->positionTracker[1].targetTrackPos.y = y;
    camera->positionTracker[1].targetTrackPos.z = z;
}

void BossArena__GetTracker1TargetPos(BossArenaCamera *camera, fx32 *x, fx32 *y, fx32 *z)
{
    if (x != NULL)
        *x = camera->positionTracker[1].targetTrackPos.x;

    if (y != NULL)
        *y = camera->positionTracker[1].targetTrackPos.y;

    if (z != NULL)
        *z = camera->positionTracker[1].targetTrackPos.z;
}

void BossArena__SetTracker1TargetOffset(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z)
{
    camera->positionTracker[1].targetOffset.x = x;
    camera->positionTracker[1].targetOffset.y = y;
    camera->positionTracker[1].targetOffset.z = z;
}

void BossArena__UpdateTracker1TargetPos(BossArenaCamera *camera)
{
    BossArena__TrackTarget2(camera);
    VEC_Add(&camera->positionTracker[1].targetTrackPos, &camera->positionTracker[1].targetOffset, &camera->positionTracker[1].targetPos);
    camera->positionTracker[1].moveSpeed = 0;
}

void BossArena__SetTracker1TargetWork(BossArenaCamera *camera, StageTask *x, StageTask *y, StageTask *z)
{
    camera->positionTracker[1].workX = x;
    camera->positionTracker[1].workY = y;
    camera->positionTracker[1].workZ = z;
}

void BossArena__SetTracker1UseObj3D(BossArenaCamera *camera, BOOL enabled)
{
    camera->positionTracker[1].useObj3D = enabled;
}

void BossArena__SetTracker1Speed(BossArenaCamera *camera, s16 speed, fx32 velocity)
{
    camera->positionTracker[1].speed        = speed;
    camera->positionTracker[1].moveVelocity = velocity;
}

void BossArena__SetTracker0TargetPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z)
{
    camera->positionTracker[0].targetTrackPos.x = x;
    camera->positionTracker[0].targetTrackPos.y = y;
    camera->positionTracker[0].targetTrackPos.z = z;
}

void BossArena__GetTracker0TargetPos(BossArenaCamera *camera, fx32 *x, fx32 *y, fx32 *z)
{
    if (x != NULL)
        *x = camera->positionTracker[0].targetTrackPos.x;

    if (y != NULL)
        *y = camera->positionTracker[0].targetTrackPos.y;

    if (z != NULL)
        *z = camera->positionTracker[0].targetTrackPos.z;
}

void BossArena__UpdateTracker0TargetPos(BossArenaCamera *camera)
{
    BossArena__TrackTarget1(camera);
    VEC_Add(&camera->positionTracker[0].targetTrackPos, &camera->positionTracker[0].targetOffset, &camera->positionTracker[0].targetPos);
    camera->positionTracker[0].moveSpeed = 0;
}

void BossArena__SetTracker0TargetWork(BossArenaCamera *camera, StageTask *x, StageTask *y, StageTask *z)
{
    camera->positionTracker[0].workX = x;
    camera->positionTracker[0].workY = y;
    camera->positionTracker[0].workZ = z;
}

void BossArena__SetTracker0Speed(BossArenaCamera *camera, s16 speed, fx32 velocity)
{
    camera->positionTracker[0].speed        = speed;
    camera->positionTracker[0].moveVelocity = velocity;
}

void BossArena__SetAmplitudeXZTarget(BossArenaCamera *camera, s32 target)
{
    camera->amplitudeXZTracker.target = target;
}

void BossArena__ApplyAmplitudeXZTarget(BossArenaCamera *camera)
{
    camera->amplitudeXZTracker.value = camera->amplitudeXZTracker.target;
}

void BossArena__SetAmplitudeXZSpeed(BossArenaCamera *camera, s16 speed)
{
    camera->amplitudeXZTracker.speed = speed;
}

void BossArena__SetAmplitudeYTarget(BossArenaCamera *camera, s32 target)
{
    camera->amplitudeYTracker.target = target;
}

void BossArena__ApplyAmplitudeYTarget(BossArenaCamera *camera)
{
    camera->amplitudeYTracker.value = camera->amplitudeYTracker.target;
}

void BossArena__SetAmplitudeYSpeed(BossArenaCamera *camera, s16 speed)
{
    camera->amplitudeYTracker.speed = speed;
}

void BossArena__SetAngleTarget(BossArenaCamera *camera, u16 target)
{
    camera->angleTracker.target = target;
}

u16 BossArena__GetAngleTarget(BossArenaCamera *camera)
{
    return camera->angleTracker.target;
}

void BossArena__ApplyAngleTarget(BossArenaCamera *camera)
{
    camera->angleTracker.value = camera->angleTracker.target;
}

void BossArena__SetAngleSpeed(BossArenaCamera *camera, s16 speed)
{
    camera->angleTracker.speed = speed;
}

void BossArena__SetBackgroundType(BossArenaBackgroundType type)
{
    BossArena *work = BossArena__GetWork();

    BossArena__FreeMappings(&work->background);

    work->background.type = type;
    if (work->background.type == BOSSARENABACKGROUND_TYPE_3D)
        BossArena__AllocMappings(&work->background);
}

AnimatorMDL *BossArena__GetBackgroundAnimator(void)
{
    BossArena *work = BossArena__GetWork();

    return &work->background.animator;
}

BossArenaUnknown4A8 *BossArena__GetField4A8(void)
{
    BossArena *work = BossArena__GetWork();

    return &work->background.field_148;
}

void BossArena__SetBoundsX(s16 left, s16 right)
{
    BossArenaBackground *background = &BossArena__GetWork()->background;

    background->left  = left;
    background->right = right;
}

void BossArena__SetBoundsY(s16 top, s16 bottom)
{
    BossArenaBackground *background = &BossArena__GetWork()->background;

    background->top    = top;
    background->bottom = bottom;
}

void BossArena__Func_2039AD4(VecFx32 *a1, VecFx32 *a2, VecFx32 *a3, s32 a4, u16 a5, VecFx32 *a6, VecFx32 *a7, VecFx32 *a8, VecFx32 *a9, VecFx32 *a10, VecFx32 *a11)
{
    VecFx32 vec1;
    VecFx32 dir;
    VecFx32 vec2;

    VEC_Subtract(a2, a1, &vec1);
    VEC_CrossProduct(a3, &vec1, &vec2);
    VEC_Normalize(&vec2, &vec2);
    VEC_CrossProduct(&vec1, &vec2, &dir);
    VEC_Normalize(&dir, &dir);

    a6->x = a1->x + MultiplyFX((a4 >> 1), dir.x);
    a6->y = a1->y + MultiplyFX((a4 >> 1), dir.y);
    a6->z = a1->z + MultiplyFX((a4 >> 1), dir.z);
    Unknown2066510__Func_20668A8(&vec2, -a5 >> 1, &vec1, a7);
    VEC_Add(a6, a7, a7);

    *a8 = *a3;

    a9->x = a1->x - MultiplyFX((a4 >> 1), dir.x);
    a9->y = a1->y - MultiplyFX((a4 >> 1), dir.y);
    a9->z = a1->z - MultiplyFX((a4 >> 1), dir.z);
    Unknown2066510__Func_20668A8(&vec2, a5 >> 1, &vec1, a10);
    VEC_Add(a9, a10, a10);

    *a11 = *a3;
}

NONMATCH_FUNC void BossArena__Func_2039CA4(s16 *xz, s16 *y, VecFx32 *camPos, VecFx32 *camTarget, u16 a5, u16 a6, s16 left, s16 right)
{
    // https://decomp.me/scratch/rrUI8 -> 93.38%
#ifdef NON_MATCHING
    VecFx32 lookDir;
    VecFx32 dest;
    Unknown206703C unknown;

    VEC_Subtract(camTarget, camPos, &lookDir);
    *xz = left + FX32_TO_WHOLE((FX_Atan2Idx(lookDir.z, lookDir.x) >> 4) * a5);
    VEC_Normalize(&lookDir, &dest);

    VecFx32 vec = { 0 };

    VEC_Set(&unknown.pos, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));
    unknown.w = -camPos->y;

    s32 angle = Math__Func_207B14C(Unknown2066510__Func_20670CC(&unknown.pos, &dest));
    if (Unknown2066510__Func_20670B4(&unknown, camTarget) < 0)
        angle = (u16)-angle;

    *y = right + FX32_TO_WHOLE((((-(s16)angle >> 2) + FLOAT_TO_FX32(1.0)) >> 1) * a6);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x34
	mov r5, r2
	mov r6, r1
	mov r4, r3
	mov r7, r0
	add r2, sp, #0x28
	mov r0, r4
	mov r1, r5
	bl VEC_Subtract
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x28]
	bl FX_Atan2Idx
	mov r2, r0, asr #4
	ldrh r1, [sp, #0x48]
	ldrsh r3, [sp, #0x50]
	add r0, sp, #0x28
	mul r1, r2, r1
	add r2, r3, r1, asr #12
	add r1, sp, #0x10
	strh r2, [r7]
	bl VEC_Normalize
	mov r1, #0
	mov r0, #0x1000
	str r0, [sp, #4]
	str r1, [sp, #0x24]
	str r1, [sp, #0x20]
	str r1, [sp, #0x1c]
	str r1, [sp]
	str r1, [sp, #8]
	ldr r1, [r5, #4]
	add r0, sp, #0
	rsb r2, r1, #0
	add r1, sp, #0x10
	str r2, [sp, #0xc]
	bl Unknown2066510__Func_20670CC
	bl Math__Func_207B14C
	mov r1, r4
	mov r4, r0
	add r0, sp, #0
	bl Unknown2066510__Func_20670B4
	cmp r0, #0
	rsblt r0, r4, #0
	movlt r0, r0, lsl #0x10
	movlt r4, r0, lsr #0x10
	mov r0, r4, lsl #0x10
	mov r0, r0, asr #0x10
	rsb r0, r0, #0
	mov r0, r0, asr #2
	add r1, r0, #0x1000
	mov r2, r1, asr #1
	ldrh r0, [sp, #0x4c]
	ldrsh r1, [sp, #0x54]
	mul r0, r2, r0
	add r0, r1, r0, asr #12
	strh r0, [r6]
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

BossArena *BossArena__GetWork(void)
{
    return TaskGetWork(bossArenaTaskSingleton, BossArena);
}

NONMATCH_FUNC void BossArena__InitCamera(BossArenaCamera *camera)
{
    // https://decomp.me/scratch/GhO9v -> 93.24%
#ifdef NON_MATCHING
    MI_CpuClear16(camera, sizeof(*camera));

    camera->type                      = BOSSARENACAMERA_TYPE_1;
    camera->camera.config.projFOV     = FLOAT_DEG_TO_IDX(30.0);
    camera->camera.config.projNear    = FLOAT_TO_FX32(1.0);
    camera->camera.config.projFar     = FLOAT_TO_FX32(2048.0);
    camera->camera.config.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    camera->camera.config.projScaleW  = FLOAT_TO_FX32(1.0);
    camera->upDir.x                   = FLOAT_TO_FX32(0.0);
    camera->upDir.y                   = FLOAT_TO_FX32(1.0);
    camera->upDir.z                   = FLOAT_TO_FX32(0.0);
    camera->positionTracker[1].speed  = 0x200;
    camera->positionTracker[0].speed  = 0x200;
    camera->amplitudeXZTracker.value  = 0xC8000;
    camera->amplitudeXZTracker.target = 0xC8000;
    camera->amplitudeXZTracker.speed  = 0x200;
    camera->amplitudeYTracker.value   = 0x3C000;
    camera->amplitudeYTracker.target  = 0x3C000;
    camera->amplitudeYTracker.speed   = 0x200;
    camera->angleTracker.value        = 0;
    camera->angleTracker.target       = 0;
    camera->angleTracker.speed        = 0x200;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x11c
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4]
	ldr ip, =0x00001555
	mov r2, #0x1000
	strh ip, [r4, #4]
	str r2, [r4, #8]
	mov r0, #0x800000
	str r0, [r4, #0xc]
	str ip, [r4, #0x10]
	mov r3, #0
	str r2, [r4, #0x14]
	str r3, [r4, #0x54]
	str r2, [r4, #0x58]
	str r3, [r4, #0x5c]
	mov r2, #0x200
	strh r2, [r4, #0xc4]
	mov r1, #0xc8000
	strh r2, [r4, #0x84]
	str r1, [r4, #0xf0]
	str r1, [r4, #0xec]
	mov r0, #0x3c000
	strh r2, [r4, #0xf4]
	str r0, [r4, #0x104]
	str r0, [r4, #0x100]
	add r0, r4, #0x100
	strh r2, [r0, #8]
	strh r3, [r0, #0x16]
	strh r3, [r0, #0x14]
	strh r2, [r0, #0x18]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void BossArena__ProcessPositionTracker(BossArenaPositionTracker *tracker)
{
    VecFx32 move;

    VEC_Subtract(&tracker->targetTrackPos, &tracker->targetPos, &move);
    move.x = MultiplyFX(move.x, tracker->speed);
    move.y = MultiplyFX(move.y, tracker->speed);
    move.z = MultiplyFX(move.z, tracker->speed);

    if (tracker->moveVelocity > FLOAT_TO_FX32(0.0))
    {
        fx32 mag = VEC_Mag(&move);
        if (mag > 4)
        {
            move.x = FX_Div(move.x, mag);
            move.y = FX_Div(move.y, mag);
            move.z = FX_Div(move.z, mag);
        }
        else
        {
            move.x = move.y = move.z = FLOAT_TO_FX32(0.0);
        }

        if (tracker->moveSpeed < mag)
            tracker->moveSpeed += tracker->moveVelocity;
        else
            tracker->moveSpeed = mag;

        move.x = MultiplyFX(move.x, tracker->moveSpeed);
        move.y = MultiplyFX(move.y, tracker->moveSpeed);
        move.z = MultiplyFX(move.z, tracker->moveSpeed);
    }

    VEC_Add(&tracker->targetPos, &move, &tracker->targetPos);
}

void BossArena__ProcessAmplitudeTracker(BossArenaAmplitudeTracker *tracker)
{
    fx32 move = MultiplyFX(tracker->target - tracker->value, tracker->speed);

    if (tracker->offsetVelocity > FLOAT_TO_FX32(0.0))
    {
        if (tracker->offset < move)
            tracker->offset += tracker->offsetVelocity;
        else
            tracker->offset = move;

        move = tracker->offset;
    }

    tracker->value += move;
}

void BossArena__ProcessAngleTracker(BossArenaAngleTracker *tracker)
{
    tracker->value += FX32_TO_WHOLE((u32)(tracker->speed * (s16)(tracker->target - tracker->value)) << 4) >> 4;
}

void BossArena__SetTrackPos(VecFx32 *trackPos, VecFx32 *targetPos, s32 amplitudeXZ, s32 amplitudeY, u16 angle)
{
    trackPos->x = targetPos->x + MultiplyFX(amplitudeXZ, SinFX(angle));
    trackPos->y = targetPos->y + amplitudeY;
    trackPos->z = targetPos->z + MultiplyFX(amplitudeXZ, CosFX(angle));
}

u16 BossArena__GetBackgroundTop(BossArenaBackground *background)
{
    return background->top;
}

u16 BossArena__GetBackgroundBottom(BossArenaBackground *background)
{
    u16 bottom = background->bottom;
    if (bottom == 0)
        bottom = GetBackgroundHeight(background->field_148.background) - background->top;

    return bottom;
}

void BossArena__Main(void)
{
    BossArena *work = TaskGetWorkCurrent(BossArena);

    BossArena__Process(work);
}

void BossArena__Destructor(Task *task)
{
    BossArena *work = TaskGetWork(bossArenaTaskSingleton, BossArena);

    AnimatorMDL__Release(&work->background.animator);
    BossArena__FreeMappings(&work->background);

    bossArenaTaskSingleton = NULL;
}

void BossArena__Process(BossArena *work)
{
    BossArena__MainFuncTable[work->type](work);
}

void BossArena__MainFunc_Type0(BossArena *work)
{
    work->camera[0].camera.camTarget.x = FLOAT_TO_FX32(128.0);
    work->camera[0].camera.camTarget.y = -FLOAT_TO_FX32(96.0);
    work->camera[0].camera.camTarget.z = FLOAT_TO_FX32(0.0);

    work->camera[0].camera.camPos.x = FLOAT_TO_FX32(128.0);
    work->camera[0].camera.camPos.y = -FLOAT_TO_FX32(96.0);
    work->camera[0].camera.camPos.z = 96 * FX_Div(CosFX(work->camera[0].camera.config.projFOV), SinFX(work->camera[0].camera.config.projFOV));

    work->camera[0].camera.camUp.x = FLOAT_TO_FX32(0.0);
    work->camera[0].camera.camUp.y = FLOAT_TO_FX32(1.0);
    work->camera[0].camera.camUp.z = FLOAT_TO_FX32(0.0);

    Camera3D__LoadState(&work->camera[0].camera);
}

void BossArena__MainFunc_Type1(BossArena *work)
{
    BossArena__ProcessCamera(work, work->camera);
    Camera3D__LoadState(&work->camera[0].camera);
    BossArena__DrawBackground(&work->background, work->camera);
}

void BossArena__MainFunc_Type2(BossArena *work)
{
    BossArena__ProcessCamera(work, work->camera);

    if (Camera3D__UseEngineA() != GRAPHICS_ENGINE_A)
        work->camera[0].camera.config.matProjPosition.y = -work->field_358 >> 1;
    else
        work->camera[0].camera.config.matProjPosition.y = work->field_358 >> 1;

    Camera3D__LoadState(&work->camera[0].camera);
    BossArena__DrawBackground(&work->background, work->camera);
}

void BossArena__MainFunc_Type3(BossArena *work)
{
    VecFx32 target0_1;
    VecFx32 target1_1;
    VecFx32 upDir_1;
    VecFx32 target0_2;
    VecFx32 target1_2;
    VecFx32 upDir_2;

    BossArena__ProcessCamera(work, work->camera);
    BossArena__Func_2039AD4(&work->camera[0].camera.camPos, &work->camera[0].camera.camTarget, &work->camera[0].camera.camUp, work->field_358, work->field_35C, &target0_1,
                            &target1_1, &upDir_1, &target0_2, &target1_2, &upDir_2);
    BossArena__SetCameraType(&work->camera[1], 0);
    BossArena__SetTracker0TargetPos(&work->camera[1], target0_1.x, target0_1.y, target0_1.z);
    BossArena__SetTracker1TargetPos(&work->camera[1], target1_1.x, target1_1.y, target1_1.z);
    BossArena__SetUpVector(&work->camera[1], &upDir_1);

    BossArena__SetCameraType(&work->camera[2], 0);
    BossArena__SetTracker0TargetPos(&work->camera[2], target0_2.x, target0_2.y, target0_2.z);
    BossArena__SetTracker1TargetPos(&work->camera[2], target1_2.x, target1_2.y, target1_2.z);
    BossArena__SetUpVector(&work->camera[2], &upDir_2);

    BossArenaCamera *camera;
    if (Camera3D__UseEngineA())
    {
        BossArena__ProcessCamera(work, &work->camera[2]);
        camera = &work->camera[1];
        BossArena__ProcessCamera(work, camera);
        Camera3D__LoadState(&camera->camera);
    }
    else
    {
        BossArena__ProcessCamera(work, &work->camera[1]);
        camera = &work->camera[2];
        BossArena__ProcessCamera(work, camera);
        Camera3D__LoadState(&camera->camera);
    }

    BossArena__DrawBackground(&work->background, camera);
}

void BossArena__MainFunc_Type4(BossArena *work)
{
    BossArena__ProcessCamera(work, work->camera);

    BossArenaCamera *camera;
    if (Camera3D__UseEngineA())
    {
        BossArena__ProcessCamera(work, &work->camera[2]);
        camera = &work->camera[1];
        BossArena__ProcessCamera(work, camera);
        Camera3D__LoadState(&camera->camera);
    }
    else
    {
        BossArena__ProcessCamera(work, &work->camera[1]);
        camera = &work->camera[2];
        BossArena__ProcessCamera(work, camera);
        Camera3D__LoadState(&camera->camera);
    }

    BossArena__DrawBackground(&work->background, camera);
}

void BossArena__DrawBackground(BossArenaBackground *background, BossArenaCamera *camera)
{
    switch (background->type)
    {
        case BOSSARENABACKGROUND_TYPE_2D:
            BossArena__DrawBackground3D(background, camera);
            break;

        case BOSSARENABACKGROUND_TYPE_3D:
            BossArena__DrawBackground2D(background, camera);
            break;
    }
}

void BossArena__DrawBackground3D(BossArenaBackground *background, BossArenaCamera *camera)
{
    background->animator.work.translation = camera->camera.camPos;

    AnimatorMDL__ProcessAnimation(&background->animator);
    AnimatorMDL__Draw(&background->animator);
}

NONMATCH_FUNC void BossArena__DrawBackground2D(BossArenaBackground *background, BossArenaCamera *camera)
{
    // https://decomp.me/scratch/DaCuL -> 99.02%
    // Minor register mismatch
#ifdef NON_MATCHING
    Camera3D *config = BossArena__GetCameraConfig2(camera);

    s16 y;
    s16 x;
    BossArena__Func_2039CA4(&x, &y, &config->camPos, &config->camTarget, HW_LCD_WIDTH * 4, (HW_LCD_HEIGHT + 96) * 2, background->left, background->right);

    GXScrFmtText *mappingsPtr;
    s16 bottom;
    s16 top;
    mappingsPtr = (GXScrFmtText *)GetBackgroundMappings(background->field_148.background)->data;

    top    = BossArena__GetBackgroundTop(background);
    bottom = BossArena__GetBackgroundBottom(background) + top;

    s32 r;
    for (r = 0; r < 25; r++)
    {
        s32 value = r + (y >> 3);
        if (top > value)
        {
            value = top;
        }
        else if (bottom <= value)
        {
            value = bottom - 1;
        }

        s32 v12 = (x >> 3) & 0x7F;
        if (v12 <= 0x5F)
        {
            MI_CpuCopy16(&mappingsPtr[128 * value + v12], background->mappingsPtr->scr[r], BOSSARENA_BACKGROUND_TILE_WIDTH * sizeof(GXScrFmtText));
        }
        else
        {
            GXScrFmtText *v13 = &mappingsPtr[128 * value];
            s32 v14           = 128 - v12;

            MI_CpuCopy16(&v13[v12], background->mappingsPtr->scr[r], sizeof(GXScrFmtText) * v14);
            MI_CpuCopy16(v13, background->mappingsPtr->scr[r] + v14, sizeof(GXScrFmtText) * (BOSSARENA_BACKGROUND_TILE_WIDTH - v14));
        }
    }

    DC_StoreRange(background->mappingsPtr, sizeof(BossArena2DBGTiles));

    Mappings__ReadMappingsCompressed(background->mappingsPtr, 0, 0, BOSSARENA_BACKGROUND_TILE_WIDTH, 0, background->field_148.mappingsMode,
                                              background->field_148.screenBaseA, background->field_148.screenBaseBlock, background->field_148.offsetX,
                                              background->field_148.offsetY, background->field_148.displayWidth, background->field_148.displayHeight);

    RenderCoreGFXControl *gfxControl;
    if (Camera3D__GetTask() != NULL)
    {
        gfxControl = &Camera3D__GetWork()->gfxControl[Camera3D__UseEngineA() ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B];
    }
    else
    {
        gfxControl = &renderCoreGFXControlA;
    }

    gfxControl->bgPosition[background->field_148.backgroundID].x = x & 7;
    gfxControl->bgPosition[background->field_148.backgroundID].y = y & 7;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	mov r10, r0
	mov r0, r1
	bl BossArena__GetCameraConfig2
	mov r1, #0x400
	str r1, [sp]
	mov r1, #0x240
	str r1, [sp, #4]
	add r2, r10, #0x100
	ldrsh r3, [r2, #0x94]
	mov r5, r0
	add r0, sp, #0x24
	str r3, [sp, #8]
	ldrsh r4, [r2, #0x96]
	add r1, sp, #0x26
	add r2, r5, #0x20
	add r3, r5, #0x2c
	str r4, [sp, #0xc]
	bl BossArena__Func_2039CA4
	ldr r0, [r10, #0x14c]
	bl GetBackgroundMappings
	add r4, r0, #4
	mov r0, r10
	bl BossArena__GetBackgroundTop
	mov r5, r0, lsl #0x10
	mov r0, r10
	mov r8, r5, asr #0x10
	bl BossArena__GetBackgroundBottom
	add r0, r0, r5, asr #16
	mov r0, r0, lsl #0x10
	mov r11, r0, asr #0x10
	mov r5, #0
	sub r0, r11, #1
	mov r7, r5
	str r0, [sp, #0x20]
_0203A4D8:
	ldrsh r0, [sp, #0x26]
	add r2, r5, r0, asr #3
	cmp r8, r2
	movgt r2, r8
	bgt _0203A4F4
	cmp r11, r2
	ldrle r2, [sp, #0x20]
_0203A4F4:
	ldrsh r0, [sp, #0x24]
	ldr r1, [r10, #0x190]
	mov r0, r0, asr #3
	and r3, r0, #0x7f
	cmp r3, #0x5f
	bgt _0203A524
	add r0, r4, r2, lsl #8
	mov r2, #0x42
	add r0, r0, r3, lsl #1
	add r1, r1, r7
	bl MIi_CpuCopy16
	b _0203A558
_0203A524:
	add r9, r4, r2, lsl #8
	rsb r6, r3, #0x80
	add r0, r9, r3, lsl #1
	add r1, r1, r7
	mov r2, r6, lsl #1
	bl MIi_CpuCopy16
	ldr r1, [r10, #0x190]
	rsb r2, r6, #0x21
	add r1, r1, r7
	mov r0, r9
	add r1, r1, r6, lsl #1
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
_0203A558:
	add r5, r5, #1
	cmp r5, #0x19
	add r7, r7, #0x42
	blt _0203A4D8
	ldr r0, [r10, #0x190]
	ldr r1, =0x00000672
	bl DC_StoreRange
	mov r1, #0
	str r1, [sp]
	ldr r2, [r10, #0x170]
	add r0, r10, #0x100
	str r2, [sp, #4]
	ldrh r4, [r0, #0x74]
	mov r2, r1
	mov r3, #0x21
	str r4, [sp, #8]
	ldrh r4, [r0, #0x76]
	str r4, [sp, #0xc]
	ldrh r4, [r0, #0x78]
	str r4, [sp, #0x10]
	ldrh r4, [r0, #0x7a]
	str r4, [sp, #0x14]
	ldrh r4, [r0, #0x7c]
	str r4, [sp, #0x18]
	ldrh r0, [r0, #0x7e]
	str r0, [sp, #0x1c]
	ldr r0, [r10, #0x190]
	bl Mappings__ReadMappingsCompressed
	bl Camera3D__GetTask
	cmp r0, #0
	beq _0203A5F4
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r4, #0
	moveq r4, #1
	bl Camera3D__GetWork
	mov r1, #0x5c
	mla r2, r4, r1, r0
	b _0203A5F8
_0203A5F4:
	ldr r2, =renderCoreGFXControlA
_0203A5F8:
	ldrsh r1, [sp, #0x24]
	ldrb r0, [r10, #0x15c]
	and r1, r1, #7
	mov r0, r0, lsl #2
	strh r1, [r2, r0]
	ldrsh r1, [sp, #0x26]
	ldrb r0, [r10, #0x15c]
	and r1, r1, #7
	add r0, r2, r0, lsl #2
	strh r1, [r0, #2]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void BossArena__AllocMappings(BossArenaBackground *background)
{
    if (background->mappingsPtr == NULL)
        background->mappingsPtr = (BossArena2DBGTiles *)HeapAllocTail(HEAP_SYSTEM, sizeof(BossArena2DBGTiles));
}

void BossArena__FreeMappings(BossArenaBackground *background)
{
    if (background->mappingsPtr != NULL)
    {
        HeapFree(HEAP_SYSTEM, background->mappingsPtr);
        background->mappingsPtr = NULL;
    }
}

void BossArena__TrackTarget1(BossArenaCamera *camera)
{
    if (camera->positionTracker[0].useObj3D)
    {
        if (camera->positionTracker[0].workX != NULL)
            camera->positionTracker[0].targetTrackPos.x = camera->positionTracker[0].workX->obj_3d->ani.work.translation.x + camera->positionTracker[0].targetOffset.x;

        if (camera->positionTracker[0].workY != NULL)
            camera->positionTracker[0].targetTrackPos.y = camera->positionTracker[0].workY->obj_3d->ani.work.translation.y + camera->positionTracker[0].targetOffset.y;

        if (camera->positionTracker[0].workZ != NULL)
            camera->positionTracker[0].targetTrackPos.z = camera->positionTracker[0].workZ->obj_3d->ani.work.translation.z + camera->positionTracker[0].targetOffset.z;
    }
    else
    {
        if (camera->positionTracker[0].workX != NULL)
            camera->positionTracker[0].targetTrackPos.x = camera->positionTracker[0].workX->position.x + camera->positionTracker[0].targetOffset.x;

        if (camera->positionTracker[0].workY != NULL)
            camera->positionTracker[0].targetTrackPos.y = camera->positionTracker[0].targetOffset.y - camera->positionTracker[0].workY->position.y;

        if (camera->positionTracker[0].workZ != NULL)
            camera->positionTracker[0].targetTrackPos.z = camera->positionTracker[0].workZ->position.z + camera->positionTracker[0].targetOffset.z;
    }
}

void BossArena__TrackTarget2(BossArenaCamera *camera)
{
    if (camera->positionTracker[1].useObj3D)
    {
        if (camera->positionTracker[1].workX != NULL)
            camera->positionTracker[1].targetTrackPos.x = camera->positionTracker[1].workX->obj_3d->ani.work.translation.x + camera->positionTracker[1].targetOffset.x;

        if (camera->positionTracker[1].workY != NULL)
            camera->positionTracker[1].targetTrackPos.y = camera->positionTracker[1].workY->obj_3d->ani.work.translation.y + camera->positionTracker[1].targetOffset.y;

        if (camera->positionTracker[1].workZ != NULL)
            camera->positionTracker[1].targetTrackPos.z = camera->positionTracker[1].workZ->obj_3d->ani.work.translation.z + camera->positionTracker[1].targetOffset.z;
    }
    else
    {
        if (camera->positionTracker[1].workX != NULL)
            camera->positionTracker[1].targetTrackPos.x = camera->positionTracker[1].workX->position.x + camera->positionTracker[1].targetOffset.x;

        if (camera->positionTracker[1].workY != NULL)
            camera->positionTracker[1].targetTrackPos.y = camera->positionTracker[1].targetOffset.y - camera->positionTracker[1].workY->position.y;

        if (camera->positionTracker[1].workZ != NULL)
            camera->positionTracker[1].targetTrackPos.z = camera->positionTracker[1].workZ->position.z + camera->positionTracker[1].targetOffset.z;
    }
}

void BossArena__ProcessCamera(BossArena *work, BossArenaCamera *camera)
{
    BossArena__TrackTarget1(camera);
    BossArena__TrackTarget2(camera);

    BossArena__CamFuncTable[camera->type](work, camera);

    camera->camera.position = camera->nextPosition;

    camera->nextPosition.x = FLOAT_TO_FX32(0.0);
    camera->nextPosition.y = FLOAT_TO_FX32(0.0);
    camera->nextPosition.z = FLOAT_TO_FX32(0.0);
}

void BossArena__CamFunc_Type0(BossArena *work, BossArenaCamera *camera)
{
    BossArena__ProcessPositionTracker(camera->positionTracker);

    camera->camera.camPos = camera->positionTracker[0].targetPos;

    BossArena__ProcessPositionTracker(&camera->positionTracker[1]);

    camera->camera.camTarget = camera->positionTracker[1].targetPos;
    camera->camera.camUp   = camera->upDir;
}

void BossArena__CamFunc_Type1(BossArena *work, BossArenaCamera *camera)
{
    BossArena__ProcessPositionTracker(&camera->positionTracker[1]);

    camera->camera.camTarget = camera->positionTracker[1].targetPos;

    BossArena__ProcessAmplitudeTracker(&camera->amplitudeXZTracker);
    BossArena__ProcessAmplitudeTracker(&camera->amplitudeYTracker);
    BossArena__ProcessAngleTracker(&camera->angleTracker);
    BossArena__SetTrackPos(&camera->positionTracker[0].targetTrackPos, &camera->positionTracker[1].targetPos, camera->amplitudeXZTracker.value, camera->amplitudeYTracker.value,
                           camera->angleTracker.value);
    BossArena__ProcessPositionTracker(camera->positionTracker);

    camera->camera.camPos = camera->positionTracker[0].targetPos;
    camera->camera.camUp = camera->upDir;
}