#include <stage/objects/startPlatform.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/system/sysEvent.h>
#include <stage/core/titleCard.h>
#include <game/input/padInput.h>
#include <game/graphics/drawFadeTask.h>
#include <game/stage/bossArena.h>
#include <game/stage/mapFarSys.h>
#include <stage/objects/playerSnowboard.h>
#include <stage/effects/startDash.h>
#include <game/math/unknown2066510.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void LoadStartPlatformAssets(struct StartPlatformAssets *assets);
static void StartPlatform_Destructor(Task *task);
static void StartPlatform_Draw(void);

static void StartPlatform_Action_Init(StartPlatform *work);
static void StartPlatform_State_Active(StartPlatform *work);

static void StartPlatform_StateCamera_SetupIntroConfig(StartPlatform *work);
static void StartPlatform_StateCamera_IntroShot(StartPlatform *work);
static void StartPlatform_StateCamera_SetupPlatformWalk(StartPlatform *work);
static void StartPlatform_StateCamera_PlatformWalk(StartPlatform *work);
static void StartPlatform_StateCamera_2179024(StartPlatform *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE s32 Lerp(s32 start, s32 end, s32 percent)
{
    return start + MultiplyFX(end - start, percent);
}

// --------------------
// FUNCTIONS
// --------------------

StartPlatform *CreateStartPlatform(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(StartPlatform_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), StartPlatform);
    // No null check

    StartPlatform *work = TaskGetWork(task, StartPlatform);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y - FLOAT_TO_FX32(96.0));

    SetTaskOutFunc(&work->gameWork.objWork, StartPlatform_Draw);
    work->stateCamera = StartPlatform_StateCamera_SetupIntroConfig;

    // fill the platform collision data with all-solid tiles
    MI_CpuFill8(work->platformCollision, (0x8 << 0) | (0x8 << 4), sizeof(work->platformCollision));

    work->advanceDelay = 30;
    LoadStartPlatformAssets(&work->assets);

    StageTaskCollisionWork *platformColWork = &work->collisionObj[0];
    platformColWork->work.parent            = &work->gameWork.objWork;
    platformColWork->work.diff_data         = work->platformCollision;
    platformColWork->work.ofst_x            = -32;
    platformColWork->work.ofst_y            = 0;
    platformColWork->work.width             = STARTPLATFORM_COLLISION_WIDTH;
    platformColWork->work.height            = STARTPLATFORM_COLLISION_HEIGHT;

    StageTaskCollisionWork *springColWork = &work->collisionObj[1];
    springColWork->work.parent            = &work->gameWork.objWork;
    springColWork->work.diff_data         = work->assets.startJumpCollision;
    springColWork->work.ofst_x            = 232;
    springColWork->work.ofst_y            = -30;
    springColWork->work.width             = 48;
    springColWork->work.height            = 32;

    NNS_G3dResDefaultSetup(work->assets.mdlStartJump);

    OBS_ACTION3D_NN_WORK *aniPlatform = &work->aniPlatform;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, aniPlatform, "/gmk_start_jump.nsbmd", 0, NULL, gameArchiveCommon);
    VEC_Set(&work->aniPlatform.ani.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

    ObjAction3dNNMotionLoad(&work->gameWork.objWork, aniPlatform, "/gmk_start_jump.nsbca", NULL, gameArchiveCommon);

    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "com", gameArchiveCommon);
    NNSG3dResFileHeader *resource = NNS_FndGetArchiveFileByName("com:/effe_startdash.nsbmd");
    NNS_G3dResDefaultSetup(resource);
    NNS_FndUnmountArchive(&arc);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    StartPlatform_Action_Init(work);

    gPlayer->objWork.position.x = x;
    gPlayer->objWork.position.y = y - FLOAT_TO_FX32(96.0) - FX32_FROM_WHOLE(gPlayer->objWork.hitboxRect.bottom);

    gPlayer->objWork.prevPosition = gPlayer->objWork.position;

    Player__SaveStartingPosition(gPlayer->objWork.position.x, gPlayer->objWork.position.y, gPlayer->objWork.position.z);
    gPlayer->objWork.displayFlag &= ~(DISPLAY_FLAG_800 | DISPLAY_FLAG_APPLY_CAMERA_CONFIG);

    if ((gPlayer->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
    {
        Player__ChangeAction(gPlayer, PLAYER_ACTION_START_SNOWBOARD);
        ChangePlayerSnowboardAction(gPlayer, PLAYERSNOWBOARD_ACTION_START);
        Player__Action_StageStartSnowboard(gPlayer);
    }
    else
    {
        Player__ChangeAction(gPlayer, PLAYER_ACTION_START_01);
    }

    BossArenaCamera *camera = BossArena__GetCamera(0);
    VecFx32 position        = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    BossArena__SetType(BOSSARENA_TYPE_1);
    BossArena__SetCameraType(camera, BOSSARENACAMERA_TYPE_1);
    BossArena__SetTracker1TargetWork(camera, &gPlayer->objWork, &gPlayer->objWork, &gPlayer->objWork);
    BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.25), 0);
    BossArena__SetTracker1UseObj3D(camera, TRUE);
    BossArena__SetAmplitudeXZSpeed(camera, FLOAT_TO_FX32(0.0498046875));
    BossArena__SetAmplitudeYSpeed(camera, FLOAT_TO_FX32(0.0498046875));
    BossArena__SetUpVector(camera, &position);

    return work;
}

void LoadStartPlatformAssets(struct StartPlatformAssets *assets)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "com", gameArchiveCommon);
    assets->mdlStartJump       = NNS_FndGetArchiveFileByName("com:/gmk_start_jump.nsbmd");
    assets->aniStartJump       = NNS_FndGetArchiveFileByName("com:/gmk_start_jump.nsbca");
    assets->startJumpCollision = NNS_FndGetArchiveFileByName("com:/gmk_stdm_jump.df");
    NNS_FndUnmountArchive(&arc);
}

void StartPlatform_Destructor(Task *task)
{
    NNSFndArchive arc;

    StartPlatform *work = TaskGetWork(task, StartPlatform);

    OBS_ACTION3D_NN_WORK *aniWork = &work->aniPlatform;
    Animator3D__Release(&aniWork->ani.work);

    NNS_FndMountArchive(&arc, "com", gameArchiveCommon);
    NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByName("com:/gmk_start_jump.nsbmd"));
    NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByName("com:/effe_startdash.nsbmd"));
    NNS_FndUnmountArchive(&arc);

    GameObject__Destructor(task);
}

void StartPlatform_Draw(void)
{
    StartPlatform *work = TaskGetWorkCurrent(StartPlatform);

    VecU16 dir       = { FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(0.0) };
    VecFx32 position = work->gameWork.objWork.position;

    if ((gPlayer->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
        position.y += FLOAT_TO_FX32(4.0);

    StageTask__Draw3DEx(&work->aniPlatform.ani.work, &position, &dir, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL, NULL);
}

void StartPlatform_Action_Init(StartPlatform *work)
{
    SetTaskState(&work->gameWork.objWork, StartPlatform_State_Active);
}

void StartPlatform_State_Active(StartPlatform *work)
{
    ObjCollisionObjectRegist(&work->collisionObj[0].work);
    ObjCollisionObjectRegist(&work->collisionObj[1].work);

    if ((work->gameWork.objWork.flag & STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT) != 0)
        Player__SetP2Offset(0, 0, FLOAT_TO_FX32(1000.0));

    work->playerDistance = FX_Div(gPlayer->objWork.position.x - work->gameWork.objWork.position.x, FLOAT_TO_FX32(264.0));
    work->playerDistance = MTM_MATH_CLIP(work->playerDistance, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0));

    // if the player has moved away from the start, then they're walking!
    if (work->playerDistance >= FLOAT_TO_FX32(0.75))
        work->isPlayerWalking = TRUE;

    StageTaskCollisionWork *colWork = &work->collisionObj[1];
    Player *player                  = (Player *)colWork->work.riderObj;

    // check if player has reached the spring
    if (player != NULL && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER
        && work->gameWork.objWork.position.x + (FLOAT_TO_FX32(32.0) + FX32_FROM_WHOLE(colWork->work.ofst_x)) < player->objWork.position.x)
    {
        if (GetSysEventList()->currentEventID == SYSEVENT_TITLECARD)
        {
            RequestSysEventChange(0); // SYSEVENT_STAGE_ACTIVE
            NextSysEvent();
        }

        player->playerFlag &= ~PLAYER_FLAG_DISABLE_INPUT_READ;

        if (!work->playerLeftPlatform)
        {
            if (gmCheckVsBattleFlag())
                gPlayer->blinkTimer = SECONDS_TO_FRAMES(5.0);

            work->playerLeftPlatform = TRUE;
        }

        Player__Action_SpringboardLaunch(player, player->objWork.groundVel + FLOAT_TO_FX32(1.0), -(player->jumpForce + FLOAT_TO_FX32(0.5)));
        Player__Action_AllowTrickCombos(player, &work->gameWork);
        gPlayer->objWork.displayFlag &= ~(DISPLAY_FLAG_800 | DISPLAY_FLAG_APPLY_CAMERA_CONFIG);
        AnimatorMDL__SetAnimation(&work->aniPlatform.ani, B3D_ANIM_JOINT_ANIM, work->aniPlatform.resources[B3D_RESOURCE_JOINT_ANIM], 0, NULL);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMP_STAND);
    }

    work->stateCamera(work);

    if (BossArena__GetType() == 1)
    {
        s16 y, xz;

        BossArenaCamera *camera = BossArena__GetCamera(0);
        Camera3D *config        = BossArena__GetCameraConfig2(camera);
        BossArena__Func_2039CA4(&xz, &y, &config->lookAtTo, &config->lookAtFrom, 0x400, 0x240, 0, 0);
        MapFarSys__SetScrollSpeed(0, FX32_FROM_WHOLE(xz), 0);
    }
}

void StartPlatform_StateCamera_SetupIntroConfig(StartPlatform *work)
{
    struct StartPlatformCameraConfig *config = &work->cameraConfig;
    if (TitleCard__GetProgress() == TITLECARD_PROGRESS_WAITING_TITLECARD_START)
    {
        BossArenaCamera *camera = BossArena__GetCamera(0);

        config->lerpPercent = FLOAT_TO_FX32(0.0);

        config->startPos.x = FLOAT_TO_FX32(0.0);
        config->startPos.y = FLOAT_TO_FX32(150.0);
        config->startPos.z = FLOAT_TO_FX32(50.0);

        config->amplitudeXZStart = FLOAT_TO_FX32(150.0);
        config->amplitudeYStart  = FLOAT_TO_FX32(10.0);
        config->angleStart       = FLOAT_TO_FX32(4.0);

        config->endPos.x = FLOAT_TO_FX32(0.0);
        config->endPos.y = FLOAT_TO_FX32(10.0);
        config->endPos.z = FLOAT_TO_FX32(20.0);

        config->amplitudeXZEnd = FLOAT_TO_FX32(60.0);
        config->amplitudeYEnd  = FLOAT_TO_FX32(10.0);
        config->angleEnd       = FLOAT_TO_FX32(13.333251953125);

        TitleCard__SetAllowContinue();
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));

        work->stateCamera = StartPlatform_StateCamera_IntroShot;
        work->stateCamera(work);

        BossArena__ApplyAmplitudeXZTarget(camera);
        BossArena__ApplyAmplitudeYTarget(camera);
        BossArena__ApplyAngleTarget(camera);
        BossArena__UpdateTracker1TargetPos(camera);
        BossArena__DoProcess();
        BossArena__UpdateTracker0TargetPos(camera);
    }
}

void StartPlatform_StateCamera_IntroShot(StartPlatform *work)
{
    struct StartPlatformCameraConfig *camConfig = &work->cameraConfig;
    BossArenaCamera *camera                     = BossArena__GetCamera(0);
    BOOL advanceReady                           = FALSE;

    if (!gmCheckVsBattleFlag() && (playerGameStatus.input.btnPress & (PAD_BUTTON_Y | PAD_BUTTON_X | PAD_BUTTON_B | PAD_BUTTON_A)) != 0)
    {
        work->skippedTitleCard = TRUE;
        TitleCard__SetFinished();
    }

    if (TitleCard__GetProgress() == TITLECARD_PROGRESS_SHOWING_READY_TEXT)
    {
        if ((gPlayer->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            if (gPlayer->actionState != PLAYER_ACTION_START_03)
            {
                Player__ChangeAction(gPlayer, PLAYER_ACTION_START_03);
                gPlayer->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
    }

    camConfig->lerpPercent += work->skippedTitleCard ? FLOAT_TO_FX32(1.0f / 30.0f) : FLOAT_TO_FX32(1.0f / 120.0f);

    if (camConfig->lerpPercent >= FLOAT_TO_FX32(1.0))
    {
        camConfig->lerpPercent = FLOAT_TO_FX32(1.0);
        advanceReady           = TRUE;
    }

    BossArena__SetTracker1TargetOffset(camera, Lerp(camConfig->startPos.x, camConfig->endPos.x, camConfig->lerpPercent),
                                       Lerp(camConfig->startPos.y, camConfig->endPos.y, camConfig->lerpPercent),
                                       Lerp(camConfig->startPos.z, camConfig->endPos.z, camConfig->lerpPercent));
    BossArena__SetAmplitudeXZTarget(camera, Lerp(camConfig->amplitudeXZStart, camConfig->amplitudeXZEnd, camConfig->lerpPercent));
    BossArena__SetAmplitudeYTarget(camera, Lerp(camConfig->amplitudeYStart, camConfig->amplitudeYEnd, camConfig->lerpPercent));
    BossArena__SetAngleTarget(camera, Unknown2066510__LerpAngle(camConfig->angleStart, camConfig->angleEnd, camConfig->lerpPercent));

    if (TitleCard__GetProgress() >= TITLECARD_PROGRESS_SHOWING_READY_TEXT)
    {
        if (work->advanceDelay != 0)
        {
            work->advanceDelay--;
        }
        else
        {
            if (work->advanceTimer != 0)
                work->advanceTimer++;

            if ((playerGameStatus.input.btnPress & (PAD_BUTTON_Y | PAD_KEY_UP | PAD_KEY_RIGHT)) != 0)
            {
                if (work->advanceTimer != 0)
                    work->disableStartDash = TRUE;
                else
                    work->advanceTimer = TRUE;
            }
        }
    }

    if (advanceReady && TitleCard__GetProgress() == TITLECARD_PROGRESS_WAITING_TITLECARD_COMPLETE)
    {
        if (work->advanceTimer != 0)
        {
            if (work->advanceTimer <= 3)
                work->tryStartDash = TRUE;
        }

        TitleCard__SetAllowContinue();
        work->stateCamera = StartPlatform_StateCamera_SetupPlatformWalk;
    }
}

void StartPlatform_StateCamera_SetupPlatformWalk(StartPlatform *work)
{
    struct StartPlatformCameraConfig *camConfig = &work->cameraConfig;

    BossArenaCamera *camera = BossArena__GetCamera(0);

    camConfig->lerpPercent = FLOAT_TO_FX32(0.0);

    camConfig->startPos = camConfig->endPos;

    camConfig->amplitudeXZStart = camConfig->amplitudeXZEnd;
    camConfig->amplitudeYStart  = camConfig->amplitudeYEnd;
    camConfig->angleStart       = camConfig->angleEnd;

    camConfig->endPos.x = FLOAT_TO_FX32(0.0);
    camConfig->endPos.y = FLOAT_TO_FX32(0.0);
    camConfig->endPos.z = FLOAT_TO_FX32(0.0);

    camConfig->amplitudeYEnd = 0;
    camConfig->angleEnd      = 0;

    Camera3D *config          = BossArena__GetCameraConfig(camera);
    camConfig->amplitudeXZEnd = FX_Div(FLOAT_TO_FX32(96.0), FX_Div(SinFX((s32)config->config.projFOV), CosFX(config->config.projFOV)));

    Player__OnLandGround(gPlayer);
    work->startDashTimer = 0;

    work->stateCamera = StartPlatform_StateCamera_PlatformWalk;
    work->stateCamera(work);
}

void StartPlatform_StateCamera_PlatformWalk(StartPlatform *work)
{
    struct StartPlatformCameraConfig *camConfig = &work->cameraConfig;
    BossArenaCamera *camera                     = BossArena__GetCamera(0);

    if (!work->disableStartDash && !work->tryStartDash)
    {
        if (work->startDashTimer++ < 6)
        {
            if ((playerGameStatus.input.btnPress & (PAD_BUTTON_Y | PAD_KEY_UP | PAD_KEY_RIGHT)) != 0)
                work->tryStartDash = TRUE;
        }
        else
        {
            work->disableStartDash = TRUE;
        }
    }

    if (work->tryStartDash && !work->usedStartDash)
    {
        work->usedStartDash = TRUE;
        EffectStartDash__Create(&gPlayer->objWork);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DASH_PANEL);
    }

    fx32 startVel = FLOAT_TO_FX32(3.0);
    if (work->usedStartDash)
        startVel += FLOAT_TO_FX32(6.0);
    gPlayer->objWork.groundVel = startVel;

    if (work->isPlayerWalking)
    {
        fx16 y;
        fx16 x;

        camConfig->lerpPercent += FLOAT_TO_FX32(0.0166015625);
        if (camConfig->lerpPercent >= FLOAT_TO_FX32(1.0))
            camConfig->lerpPercent = FLOAT_TO_FX32(1.0);

        MapSys__Func_20090D0(&mapCamera.camera[0], gPlayer->objWork.position.x, gPlayer->objWork.position.y, &x, &y);
        camConfig->endPos.x = FX32_FROM_WHOLE(128 - x);
        camConfig->endPos.y = -FX32_FROM_WHOLE(96 - y);

        BossArena__SetTracker1TargetOffset(camera, Lerp(camConfig->startPos.x, camConfig->endPos.x, camConfig->lerpPercent),
                                           Lerp(camConfig->startPos.y, camConfig->endPos.y, camConfig->lerpPercent),
                                           Lerp(camConfig->startPos.z, camConfig->endPos.z, camConfig->lerpPercent));
        BossArena__SetTracker1Speed(camera, camConfig->lerpPercent, 0);
        BossArena__SetTracker0Speed(camera, camConfig->lerpPercent, 0);
        BossArena__SetAmplitudeXZTarget(camera, Lerp(camConfig->amplitudeXZStart, camConfig->amplitudeXZEnd, camConfig->lerpPercent));
        BossArena__SetAmplitudeXZSpeed(camera, camConfig->lerpPercent);
        BossArena__SetAmplitudeYTarget(camera, Lerp(camConfig->amplitudeYStart, camConfig->amplitudeYEnd, camConfig->lerpPercent));
        BossArena__SetAmplitudeYSpeed(camera, camConfig->lerpPercent);
        BossArena__SetAngleTarget(camera, Unknown2066510__LerpAngle(camConfig->angleStart, camConfig->angleEnd, camConfig->lerpPercent));
        BossArena__SetAngleSpeed(camera, camConfig->lerpPercent);
        Player__SetP2Offset(MultiplyFX(FLOAT_TO_FX32(50.0), camConfig->lerpPercent) - FLOAT_TO_FX32(50.0), 0, 0);
    }

    gPlayer->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

    if (work->playerLeftPlatform)
    {
        if (camConfig->lerpPercent == FLOAT_TO_FX32(1.0))
        {
            BossArena__SetType(BOSSARENA_TYPE_0);
            gPlayer->objWork.displayFlag |= DISPLAY_FLAG_800 | DISPLAY_FLAG_APPLY_CAMERA_CONFIG;
            gPlayer->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
            work->stateCamera = StartPlatform_StateCamera_2179024;
        }
    }
}

void StartPlatform_StateCamera_2179024(StartPlatform *work)
{
    // Empty
}
