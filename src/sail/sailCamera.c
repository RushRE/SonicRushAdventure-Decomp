#include <sail/sailCamera.h>
#include <sail/sailPlayer.h>
#include <game/stage/bossArena.h>
#include <game/graphics/screenShake.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SailCamera_Main(void);

static void SailCamera_State_JetHover(SailCamera *work);
static void SailCamera_State_Boat(SailCamera *work);

// --------------------
// FUNCTIONS
// --------------------

SailCamera *CreateSailCamera(void)
{
    Task *task = TaskCreate(SailCamera_Main, NULL, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x3800, TASK_GROUP(3), SailCamera);

    SailCamera *work = TaskGetWork(task, SailCamera);
    TaskInitWork16(work);

    BossArena__Create(BOSSARENA_TYPE_1, TASK_PRIORITY_UPDATE_LIST_START + 0x3F00);

    BossArenaCamera *camera3D = BossArena__GetCamera(0);
    BossArena__SetCameraType(camera3D, BOSSARENACAMERA_TYPE_0);

    CameraConfig config;
    MI_CpuClear16(&config, sizeof(config));

    config.projFOV     = FLOAT_TO_FX32(0.75);
    config.projNear    = FLOAT_TO_FX32(1.0);
    config.projScaleW  = FLOAT_TO_FX32(1.0);
    config.projFar     = FLOAT_TO_FX32(400.0);
    config.aspectRatio = FLOAT_TO_FX32(1.3333);

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
            work->tracker1.x = FLOAT_TO_FX32(0.0);
            work->tracker1.y = FLOAT_TO_FX32(1.5);
            work->tracker1.z = FLOAT_TO_FX32(0.0);

            BossArena__SetTracker1TargetPos(camera3D, work->tracker1.x, work->tracker1.y, work->tracker1.z);
            BossArena__UpdateTracker1TargetPos(camera3D);
            BossArena__SetTracker1Speed(camera3D, FLOAT_TO_FX32(1.0), 0);

            work->tracker0.x = FLOAT_TO_FX32(0.0);
            work->tracker0.y = FLOAT_TO_FX32(3.0);
            work->tracker0.z = FLOAT_TO_FX32(8.0);

            BossArena__SetTracker0TargetPos(camera3D, work->tracker0.x, work->tracker0.y, work->tracker0.z);
            BossArena__UpdateTracker0TargetPos(camera3D);
            BossArena__SetTracker0Speed(camera3D, FLOAT_TO_FX32(1.0), 0);

            work->radius1  = FLOAT_TO_FX32(8.0);
            work->state    = SailCamera_State_JetHover;
            config.projFOV = FLOAT_TO_FX32(0.75);
            break;

        case SHIP_HOVER:
            work->tracker1.x = FLOAT_TO_FX32(0.0);
            work->tracker1.y = FLOAT_TO_FX32(1.5);
            work->tracker1.z = FLOAT_TO_FX32(0.0);

            BossArena__SetTracker1TargetPos(camera3D, work->tracker1.x, work->tracker1.y, work->tracker1.z);
            BossArena__UpdateTracker1TargetPos(camera3D);
            BossArena__SetTracker1Speed(camera3D, FLOAT_TO_FX32(1.0), 0);

            work->tracker0.x = FLOAT_TO_FX32(0.0);
            work->tracker0.y = FLOAT_TO_FX32(3.375);
            work->tracker0.z = FLOAT_TO_FX32(8.0);
            BossArena__SetTracker0TargetPos(camera3D, work->tracker0.x, work->tracker0.y, work->tracker0.z);
            BossArena__UpdateTracker0TargetPos(camera3D);
            BossArena__SetTracker0Speed(camera3D, FLOAT_TO_FX32(1.0), 0);

            work->radius1  = FLOAT_TO_FX32(8.0);
            work->state    = SailCamera_State_JetHover;
            config.projFOV = FLOAT_TO_FX32(0.75);
            break;

        case SHIP_BOAT:
            work->tracker1.x = FLOAT_TO_FX32(0.0);
            work->tracker1.y = FLOAT_TO_FX32(10.3125);
            work->tracker1.z = FLOAT_TO_FX32(0.0);

            work->tracker0.x = FLOAT_TO_FX32(0.0);
            work->tracker0.y = FLOAT_TO_FX32(19.0);
            work->tracker0.z = FLOAT_TO_FX32(48.0);

            work->tracker1.x = FLOAT_TO_FX32(0.0);
            work->tracker1.y = FLOAT_TO_FX32(10.3125);
            work->tracker1.z = FLOAT_TO_FX32(0.0);

            work->tracker0.x = FLOAT_TO_FX32(0.0);
            work->tracker0.y = FLOAT_TO_FX32(19.0);
            work->tracker0.z = FLOAT_TO_FX32(48.0);

            work->radius1  = FLOAT_TO_FX32(48.0);
            work->state    = SailCamera_State_Boat;
            config.projFOV = FLOAT_TO_FX32(0.625);
            break;

        case SHIP_SUBMARINE:
            work->tracker1.x = FLOAT_TO_FX32(0.0);
            work->tracker1.y = FLOAT_TO_FX32(24.0);
            work->tracker1.z = FLOAT_TO_FX32(0.0);

            work->tracker0.x = FLOAT_TO_FX32(0.0);
            work->tracker0.y = FLOAT_TO_FX32(27.0);
            work->tracker0.z = FLOAT_TO_FX32(16.0);

            work->tracker1.x = FLOAT_TO_FX32(0.0);
            work->tracker1.y = FLOAT_TO_FX32(24.0);
            work->tracker1.z = FLOAT_TO_FX32(0.0);

            work->tracker0.x = FLOAT_TO_FX32(0.0);
            work->tracker0.y = FLOAT_TO_FX32(27.0);
            work->tracker0.z = FLOAT_TO_FX32(16.0);

            work->radius1  = FLOAT_TO_FX32(16.0);
            config.projFOV = FLOAT_TO_FX32(0.625);
            break;
    }

    BossArena__SetTracker1TargetPos(camera3D, work->tracker1.x, work->tracker1.y, work->tracker1.z);
    BossArena__UpdateTracker1TargetPos(camera3D);
    BossArena__SetTracker1Speed(camera3D, FLOAT_TO_FX32(1.0), 0);
    BossArena__SetTracker0TargetPos(camera3D, work->tracker0.x, work->tracker0.y, work->tracker0.z);
    BossArena__UpdateTracker0TargetPos(camera3D);
    BossArena__SetTracker0Speed(camera3D, FLOAT_TO_FX32(1.0), 0);
    BossArena__SetCameraConfig(camera3D, &config);

    work->targetRadius1 = work->radius1;

    g_obj.cameraConfig = BossArena__GetCameraConfig2(BossArena__GetCamera(0));

    return work;
}

NONMATCH_FUNC void SailCamera_Main(void)
{
    // https://decomp.me/scratch/95Y4x -> 98.92%
    // minor register mismatches
#ifdef NON_MATCHING
    SailManager *manager;
    Camera3D *cameraConfig;
    BossArenaCamera *camera3D;
    SailCamera *work;

    manager = SailManager__GetWork();
    work    = TaskGetWorkCurrent(SailCamera);

    camera3D     = BossArena__GetCamera(0);
    cameraConfig = BossArena__GetCameraConfig2(camera3D);

    u16 shipType       = SailManager__GetShipType();
    g_obj.cameraConfig = cameraConfig;

    VecFx32 tracker1;
    VecFx32 tracker0;
    BossArena__GetTracker1TargetPos(camera3D, &tracker1.x, &tracker1.y, &tracker1.z);
    BossArena__GetTracker0TargetPos(camera3D, &tracker0.x, &tracker0.y, &tracker0.z);

    if ((manager->flags & SAILMANAGER_FLAG_1) == 0)
    {
        work->radius1 = ObjShiftSet(work->radius1, work->targetRadius1, 3, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
        work->offsetY = ObjShiftSet(work->offsetY, work->targetOffsetY, 4, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
        work->trackY2 = ObjShiftSet(work->trackY2, work->targetTrackY2, 4, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
        work->trackY1 = ObjShiftSet(work->trackY1, work->targetTrackY1, 4, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
    }

    u16 voyageAngle = SailVoyageManager__GetVoyageAngle();

    StageTask *player = SailManager__GetWork()->sailPlayer;
    if (player != NULL)
    {
        SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);
        voyageAngle += playerWorker->seaAngle2;
    }

    tracker1.x = work->tracker1.x;
    tracker1.y = work->trackY1 + (work->tracker1.y + work->offsetY);
    tracker1.z = work->tracker1.z;

    tracker0.y = work->trackY2 + (work->tracker0.y + work->offsetY);
    tracker0.x = MultiplyFX(work->radius1 + work->radius2, SinFX((s32)voyageAngle));
    tracker0.z = MultiplyFX(work->radius1 + work->radius2, CosFX((s32)voyageAngle));

    BossArena__SetTracker1TargetPos(camera3D, tracker1.x, tracker1.y, tracker1.z);
    BossArena__SetTracker0TargetPos(camera3D, tracker0.x, tracker0.y, tracker0.z);

    BossArena__SetNextPos(camera3D, GetScreenShakeOffsetX() >> shipShiftUnknown[shipType], GetScreenShakeOffsetY() >> shipShiftUnknown[shipType], 0);

    if ((manager->flags & SAILMANAGER_FLAG_1) == 0)
    {
        if (work->state != NULL)
            work->state(work);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	bl SailManager__GetWork
	mov r5, r0
	bl GetCurrentTaskWork_
	mov r7, r0
	mov r0, #0
	bl BossArena__GetCamera
	mov r8, r0
	bl BossArena__GetCameraConfig2
	mov r6, r0
	bl SailManager__GetShipType
	ldr r1, =g_obj
	mov r4, r0, lsl #0x10
	str r6, [r1, #0x3c]
	mov r0, r8
	add r1, sp, #0x10
	add r2, sp, #0x14
	add r3, sp, #0x18
	bl BossArena__GetTracker1TargetPos
	mov r0, r8
	add r1, sp, #4
	add r2, sp, #8
	add r3, sp, #0xc
	bl BossArena__GetTracker0TargetPos
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _0215F5D4
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x18]
	ldr r1, [r7, #0x1c]
	mov r2, #3
	bl ObjShiftSet
	str r0, [r7, #0x18]
	mov r3, #0
	str r3, [sp]
	ldmia r7, {r0, r1}
	mov r2, #4
	bl ObjShiftSet
	str r0, [r7]
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x10]
	ldr r1, [r7, #0x14]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r7, #0x10]
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #8]
	ldr r1, [r7, #0xc]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r7, #8]
_0215F5D4:
	bl SailVoyageManager__GetVoyageAngle
	mov r6, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	cmp r0, #0
	beq _0215F604
	ldr r0, [r0, #0x124]
	add r0, r0, #0x100
	ldrsh r0, [r0, #0xca]
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_0215F604:
	ldr r1, [r7, #0x30]
	mov r0, r6, lsl #0x10
	str r1, [sp, #0x10]
	ldr r3, [r7, #0x34]
	ldr r2, [r7, #0]
	ldr r6, [r7, #8]
	add r2, r3, r2
	add r2, r6, r2
	str r2, [sp, #0x14]
	ldr r3, [r7, #0x38]
	mov r0, r0, lsr #0x10
	str r3, [sp, #0x18]
	mov r0, r0, asr #4
	ldr r9, [r7, #0x28]
	ldr r6, [r7, #0]
	mov ip, r0, lsl #1
	add r0, r9, r6
	ldr r10, [r7, #0x10]
	mov r6, ip, lsl #1
	add r0, r10, r0
	str r0, [sp, #8]
	ldr r0, =FX_SinCosTable_
	ldr r10, [r7, #0x18]
	ldr r9, [r7, #0x20]
	ldrsh lr, [r0, r6]
	add r6, ip, #1
	add r9, r10, r9
	smull ip, r10, r9, lr
	adds ip, ip, #0x800
	adc r9, r10, #0
	mov r10, ip, lsr #0xc
	orr r10, r10, r9, lsl #20
	str r10, [sp, #4]
	mov r6, r6, lsl #1
	ldrsh r6, [r0, r6]
	ldr lr, [r7, #0x18]
	ldr ip, [r7, #0x20]
	mov r0, r8
	add ip, lr, ip
	smull lr, r6, ip, r6
	adds ip, lr, #0x800
	adc r6, r6, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r6, lsl #20
	str ip, [sp, #0xc]
	bl BossArena__SetTracker1TargetPos
	ldr r1, [sp, #4]
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	mov r0, r8
	bl BossArena__SetTracker0TargetPos
	ldr r0, =shipShiftUnknown
	ldrb r6, [r0, r4, lsr #16]
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r2, r0, asr r6
	mov r1, r4, asr r6
	mov r0, r8
	mov r3, #0
	bl BossArena__SetNextPos
	ldr r0, [r5, #0x24]
	tst r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, [r7, #0x3c]
	cmp r1, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void SailCamera_State_JetHover(SailCamera *work)
{
    StageTask *player = SailManager__GetWork()->sailPlayer;

    if (player != NULL)
    {
        if ((player->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
        {
            if (player->velocity.y < -FLOAT_TO_FX32(0.03125))
            {
                work->targetOffsetY = FLOAT_TO_FX32(1.0);

                if (player->position.y < -FLOAT_TO_FX32(2.5))
                    work->targetOffsetY -= player->position.y + FLOAT_TO_FX32(2.5);

                work->targetTrackY2 = -FLOAT_TO_FX32(0.6875);
            }
            else if (player->velocity.y < FLOAT_TO_FX32(0.03125))
            {
                work->targetOffsetY = FLOAT_TO_FX32(1.5);

                if (player->position.y < -FLOAT_TO_FX32(2.5))
                    work->targetOffsetY -= player->position.y + FLOAT_TO_FX32(2.5);

                work->targetTrackY2 = FLOAT_TO_FX32(0.0);
            }
            else
            {
                work->targetOffsetY = FLOAT_TO_FX32(0.0);

                if (player->position.y < -FLOAT_TO_FX32(2.5))
                    work->targetOffsetY -= player->position.y + FLOAT_TO_FX32(2.5);

                work->targetTrackY2 = FLOAT_TO_FX32(2.0);
            }

            work->targetRadius1 = FLOAT_TO_FX32(8.0);
        }
        else
        {
            if ((player->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
            {
                work->targetOffsetY = -FLOAT_TO_FX32(0.25);
                work->targetRadius1 = FLOAT_TO_FX32(7.0);
                work->targetTrackY2 = FLOAT_TO_FX32(0.0);
            }
            else
            {
                work->targetTrackY2 = FLOAT_TO_FX32(0.0);
                work->targetOffsetY = FLOAT_TO_FX32(0.0);
                work->targetRadius1 = FLOAT_TO_FX32(8.0);
            }
        }
    }
}

void SailCamera_State_Boat(SailCamera *work)
{
    StageTask *player = SailManager__GetWork()->sailPlayer;

    if (player != NULL)
    {
        SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);

        s32 seaAngle2 = playerWorker->seaAngle2;
        if (seaAngle2 < 0)
            seaAngle2 = -seaAngle2;
        work->targetRadius1 = FLOAT_TO_FX32(48.0) - MultiplyFX(FLOAT_TO_FX32(7.0), seaAngle2);

        seaAngle2 = playerWorker->seaAngle2;
        if (seaAngle2 < 0)
            seaAngle2 = -seaAngle2;
        work->targetTrackY2 = -MultiplyFX(-FLOAT_TO_FX32(0.1875), seaAngle2);

        seaAngle2 = playerWorker->seaAngle2;
        if (seaAngle2 < 0)
            seaAngle2 = -seaAngle2;
        work->targetTrackY1 = -MultiplyFX(-FLOAT_TO_FX32(0.8125), seaAngle2);
    }
}