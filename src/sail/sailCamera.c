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

void SailCamera_Main(void)
{
    u16 shipType;
    SailManager *manager;
    u16 voyageAngle;
    StageTask *player;
    SailCamera *work;
    Camera3D *cameraConfig;
    BossArenaCamera *camera3D;
    
    manager = SailManager__GetWork();
    work     = TaskGetWorkCurrent(SailCamera);

    camera3D = BossArena__GetCamera(0);
    cameraConfig      = BossArena__GetCameraConfig2(camera3D);

    shipType       = SailManager__GetShipType();
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

    voyageAngle = SailVoyageManager__GetVoyageAngle();

    player = SailManager__GetWork()->sailPlayer;
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
}

void SailCamera_State_JetHover(SailCamera *work)
{
    StageTask *player = SailManager__GetWork()->sailPlayer;

    if (player != NULL)
    {
        if ((player->moveFlag & STAGE_TASK_MOVE_FLAG_IS_FALLING) != 0)
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