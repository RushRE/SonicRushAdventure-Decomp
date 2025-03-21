#include <sail/sailManager.h>
#include <sail/unknown2153770.h>
#include <sail/sailPlayer.h>
#include <sail/sailGraphics.h>
#include <sail/sailCommonObjects.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/mappingsQueue.h>
#include <game/audio/audioSystem.h>
#include <game/audio/spatialAudio.h>
#include <game/graphics/renderCore.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/system/system.h>
#include <game/system/sysEvent.h>
#include <game/input/replayRecorder.h>
#include <game/file/fsRequest.h>
#include <sail/sailDemoPlayer.h>
#include <sail/sailAssetLoader.h>
#include <seaMap/sailSeaMapView.h>
#include <sail/sailTraining.h>

// Objects
#include <sail/objects/sailCloud.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SailHUDInitEvent__Create(void);
NOT_DECOMPILED void SailRampTrick__Create(void);
NOT_DECOMPILED void SailChallengeHUD__Create(void);

// --------------------
// VARIABLES
// --------------------

static Task *sailManagerTask;
static Task *sailUnknownTask;

u8 const shipShiftUnknown[SHIP_COUNT] = {
    [SHIP_JET]       = 6, // jetski unknown
    [SHIP_BOAT]      = 3, // sailboat unknown
    [SHIP_HOVER]     = 6, // hovercraft unknown
    [SHIP_SUBMARINE] = 3  // subarmine unknown
};

static u8 bgmForShip[SHIP_COUNT] = {
    [SHIP_JET]       = SND_SAIL_SEQ_SEQ_WET_BIKE,   // jetski BGM
    [SHIP_BOAT]      = SND_SAIL_SEQ_SEQ_SAILING,    // sailboat BGM
    [SHIP_HOVER]     = SND_SAIL_SEQ_SEQ_HOVERCRAFT, // hovercraft BGM
    [SHIP_SUBMARINE] = SND_SAIL_SEQ_SEQ_SUBMARINE   // subarmine BGM
};

static const char *archiveForShip[SHIP_COUNT] = {
    [SHIP_JET]       = "narc/sb_jet_lz7.narc",      // jetski Assets
    [SHIP_BOAT]      = "narc/sb_sailer_lz7.narc",   // sailboat Assets
    [SHIP_HOVER]     = "narc/sb_hover_lz7.narc",    // hovercraft Assets
    [SHIP_SUBMARINE] = "narc/sb_submarine_lz7.narc" // subarmine Assets
};

// --------------------
// FUNCTIONS
// --------------------

void InitSailingSysEvent(void)
{
    GameState *state;
    BOOL replayActive = FALSE;

    sailManagerTask = NULL;
    sailUnknownTask = NULL;

    GetSystemUnknown();

    state = GetGameState();

    RenderCore_SetTargetVBlankCount(1);
    CreateObjectManager();
    ObjDrawSetManagedRows(2, 16);

    AllocObjectFileWork(121);
    g_obj.flag |= OBJECTMANAGER_FLAG_40 | OBJECTMANAGER_FLAG_20000;
    g_obj.spriteMode = 1;

    SailGraphics__SetupDisplay();

    StartSamplingTouchInput(4);
    if ((state->sailUnknownFlags & 1) != 0)
        CreateSailDemoPlayer();

    ReleaseAudioSystem();
    SetMusicVolume(AUDIOMANAGER_VOLUME_MAX);
    SetSfxVolume(AUDIOMANAGER_VOLUME_MAX);
    SetVoiceVolume(AUDIOMANAGER_VOLUME_MAX);
    InitSpatialAudioConfig();
    SetSpatialAudioDropoffRate(FLOAT_TO_FX32(128.0));

    char sndArcPath[] = "snd/sb1/sound_data.sdat";
    sndArcPath[6] += state->sailShipType; // change snd/sb1/ to snd/sb[x]/
    LoadAudioSndArc(sndArcPath);

    NNS_SndArcLoadSeq(bgmForShip[state->sailShipType], audioManagerSndHeap);
    NNS_SndArcLoadSeq(SND_SAIL_SEQ_SEQ_RETIRE, audioManagerSndHeap);
    NNS_SndArcLoadSeq(SND_SAIL_SEQ_SEQ_RESULT, audioManagerSndHeap);
    NNS_SndArcLoadSeq(SND_SAIL_SEQ_SEQ_DISCOVER, audioManagerSndHeap);
    NNS_SndArcLoadSeqArc(SND_SAIL_SEQARC_ARC_VOYAGE_SE, audioManagerSndHeap);
    NNS_SndArcLoadBank(SND_SAIL_BANK_BANK_VOYAGE_SE, audioManagerSndHeap);

    if (state->sailShipType != SHIP_SUBMARINE)
        PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, bgmForShip[state->sailShipType]);

    if (state->sailRandSeed != 0)
        _mt_math_rand = state->sailRandSeed;
    else
        state->sailRandSeed = _mt_math_rand;

    if ((state->sailUnknownFlags & 1) == 0 && (state->sailVsJohnny || (state->missionType == MISSION_TYPE_VIKINGCUP_TIME || state->missionType == MISSION_TYPE_VIKINGCUP_SCORE)))
    {
        if (state->sailPadReplayData == NULL)
        {
            state->sailPadReplayData = HeapAllocHead(HEAP_USER, sizeof(KeyDataHeader) + ((12800 - 1) * sizeof(KeyDataPadFrame)));
            CreateReplayRecorderPadEx(REPLAYRECORDER_TYPE_RECORD, &padInput, NULL, state->sailPadReplayData, sizeof(KeyDataHeader) + ((12800 - 1) * sizeof(KeyDataPadFrame)), 0,
                                      TASK_PRIORITY_UPDATE_LIST_START + 1);
        }
        else
        {
            replayActive = TRUE;
            CreateReplayRecorderPad(REPLAYRECORDER_TYPE_PLAY_MEMORY, &padInput, NULL, state->sailPadReplayData, sizeof(KeyDataHeader) + ((12800 - 1) * sizeof(KeyDataPadFrame)));
        }

        if (state->sailTouchReplayData == NULL)
        {
            state->sailTouchReplayData = HeapAllocHead(HEAP_USER, sizeof(KeyDataHeader) + ((38400 - 1) * sizeof(KeyDataTouchFrame)));
            CreateReplayRecorderTouchEx(REPLAYRECORDER_TYPE_RECORD, &touchInput, NULL, state->sailTouchReplayData,
                                        sizeof(KeyDataHeader) + ((38400 - 1) * sizeof(KeyDataTouchFrame)), 0, TASK_PRIORITY_UPDATE_LIST_START + 1);
        }
        else
        {
            CreateReplayRecorderTouch(REPLAYRECORDER_TYPE_PLAY_MEMORY, &touchInput, NULL, state->sailTouchReplayData,
                                      sizeof(KeyDataHeader) + ((38400 - 1) * sizeof(KeyDataTouchFrame)));
        }
    }

    if ((!state->sailVsJohnny && state->missionType == MISSION_TYPE_NONE) && state->seaMapNodeList.nodes.numObjects != 0)
    {
        GXS_SetVisiblePlane(GX_PLANEMASK_ALL);
        CreateSailSeaMapView(state->sailShipType);
    }

    SailManager *manager = SailManager__Create();
    if (replayActive)
        manager->flags |= SAILMANAGER_FLAG_REPLAY_ACTIVE;

    if (manager->missionType != MISSION_TYPE_NONE && manager->missionType == MISSION_TYPE_TRAINING)
        CreateSailTraining();

    SailUnknown2153770__Create();
    SailGraphics__SetupLights();
    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));
}

SailManager *SailManager__GetWork(void)
{
    if (sailManagerTask == NULL)
        return NULL;

    return TaskGetWork(sailManagerTask, SailManager);
}

void SailManager__AddPlayerWeaponTask(StageTask *work)
{
    SailManager *manager = SailManager__GetWork();

    if (manager != NULL)
    {
        if (manager->weaponTaskCount < 6)
        {
            manager->weaponTaskList[manager->weaponTaskCount] = work;
            manager->weaponTaskCount++;
        }
    }
}

ShipType SailManager__GetShipType(void)
{
    SailManager *work = SailManager__GetWork();
    if (work == NULL)
        return SHIP_JET;

    return work->shipType;
}

void *SailManager__GetArchive(void)
{
    SailManager *work = SailManager__GetWork();
    return work->archive;
}

SailManager *SailManager__Create(void)
{
    SailManager *work;
    GameState *state = GetGameState();

    sailManagerTask = TaskCreate(SailManager__Main, SailManager__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_END - 5, TASK_GROUP(5), SailManager);

    work = TaskGetWork(sailManagerTask, SailManager);
    TaskInitWork16(work);

    work->targetIslandID = -1;
    work->shipType       = state->sailShipType;
    work->field_5DC      = 0;

    if (state->missionType != MISSION_TYPE_NONE)
    {
        work->flags |= SAILMANAGER_FLAG_400;
        work->missionType  = state->missionType;
        work->missionID    = state->missionConfig.sail.courseID;
        work->missionQuota = state->missionConfig.sail.unknown;
        state->missionType = MISSION_TYPE_NONE;
        MI_CpuClear16(&state->missionConfig, sizeof(state->missionConfig));

        if (work->missionType == MISSION_TYPE_TRAINING)
            work->flags |= SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER;

        if (work->missionType == MISSION_TYPE_REACH_GOAL)
        {
            state->clearedMission = FALSE;
            work->field_5DC       = 2;
        }
    }
    else if (SailManager__GetShipType() == SHIP_JET && state->sailVsJohnny)
    {
        work->isRivalRace = state->sailVsJohnny;

        if (state->sailVsJohnnyID >= 10)
        {
            work->rivalRaceID = state->sailVsJohnnyID - 10;
            work->flags |= SAILMANAGER_FLAG_100000;
        }
        else
        {
            work->rivalRaceID = state->sailVsJohnnyID;
        }

        state->sailVsJohnny   = 0;
        state->sailVsJohnnyID = 0;
        work->nextEvent       = SYSEVENT_TITLE;

        if ((work->flags & SAILMANAGER_FLAG_100000) != 0)
            work->nextEvent = SYSEVENT_NONE;
    }

    if ((state->sailUnknownFlags & 1) == 0 && GetPadReplayState() == REPLAY_MODE_PLAYBACK)
        work->flags |= SAILMANAGER_FLAG_200000;

    if (work->nextEvent == SYSEVENT_NONE)
        work->nextEvent = SYSEVENT_NONE;

    FSRequestArchive(archiveForShip[work->shipType], &work->archive, TRUE);

    work->camera = CreateSailCamera();
    InitSailAssets();

    if ((work->flags & SAILMANAGER_FLAG_400) != 0 || work->isRivalRace && work->shipType == SHIP_JET)
        SailChallengeHUD__Create();

    work->sailPlayer = SailPlayer__Create(work->shipType, FALSE);

    if (work->isRivalRace && work->shipType == SHIP_JET)
        work->rivalJohnny = SailPlayer__Create(SHIP_JET, TRUE);

    work->sea           = CreateSailSea();
    work->voyageManager = SailVoyageManager__Create();
    work->ringManager   = CreateSailRingManager();
    work->eventManager  = SailEventManager__Create();
    work->hud           = SailHUD__Create();

    if (SailManager__GetShipType() != SHIP_SUBMARINE)
        CreateSailFogCloudsForVoyage();

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
            SailRampTrick__Create();
            break;

        case SHIP_BOAT:
        case SHIP_HOVER:
        case SHIP_SUBMARINE:
            break;
    }

    work->skyBrightness.x   = FLOAT_TO_FX32(1.0);
    work->skyBrightness.y   = FLOAT_TO_FX32(1.0);
    work->skyBrightness.z   = FLOAT_TO_FX32(1.0);
    work->daytimeTimer      = SECONDS_TO_FRAMES(25.0);
    work->initialVelocity.x = ObjDispRandRange5(-FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    work->initialVelocity.z = ObjDispRandRange5(-FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    work->velocity.x        = work->initialVelocity.x;
    work->velocity.z        = work->initialVelocity.z;

    TouchField__Init(&work->touchField);

    SailVoyageManager__SetupVoyage();

    SailHUDInitEvent__Create();

    work->fontFile = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fontFile, TRUE);
    FontWindow__Load_mw_frame(&work->fontWindow);
    FontWindow__SetDMA(&work->fontWindow, 1);
    FontWindowAnimator__Init(&work->fontWindow1);
    FontWindowAnimator__Init(&work->fontWindow2);
    FontWindowAnimator__Init(&work->fontWindow3);
    FontWindowAnimator__Init(&work->fontWindow4);
    FontAnimator__Init(&work->fontAnimator1);
    FontAnimator__Init(&work->fontAnimator2);
    FontAnimator__Init(&work->fontAnimator3);
    FontWindowMWControl__Init(&work->fontWindowMW);
    FontUnknown2058D78__Func_2058D54(&work->fontUnknown);

    return work;
}

void SailManager__Destructor(Task *task)
{
    SailManager *work = TaskGetWork(task, SailManager);

    HeapFree(HEAP_USER, work->fontFile);
    FontWindowAnimator__Release(&work->fontWindow1);
    FontWindowAnimator__Release(&work->fontWindow2);
    FontWindowAnimator__Release(&work->fontWindow3);
    FontWindowAnimator__Release(&work->fontWindow4);
    FontUnknown2058D78__Release(&work->fontUnknown, &work->fontAnimator1);
    FontAnimator__Release(&work->fontAnimator1);
    FontAnimator__Release(&work->fontAnimator2);
    FontAnimator__Release(&work->fontAnimator3);
    FontWindowMWControl__Release(&work->fontWindowMW);
    FontWindow__Release(&work->fontWindow);

    HeapFree(HEAP_USER, work->archive);

    GetSystemUnknown();
    RenderCore_SetTargetVBlankCount(0);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    ClearPixelsQueue();
    Mappings__ClearQueue();
    ClearPaletteQueue();

    ReleaseAudioSystem();

    VRAMSystem__InitTextureBuffer();
    VRAMSystem__InitPaletteBuffer();

    StopSamplingTouchInput();

    sailManagerTask = NULL;
}

void SailManager__Main(void)
{
    SailManager *work = TaskGetWorkCurrent(SailManager);

    if (work->missionType != MISSION_TYPE_VIKINGCUP_SCORE || work->shipType != SHIP_SUBMARINE)
    {
        if (work->cloudType != 3 && (work->timer & 0x1FF) == 0)
        {
            if (ObjDispRandRepeat(4) == 0)
            {
                if (work->cloudType == 2)
                    work->cloudType = 0;

                if (work->cloudType == 0)
                    work->cloudType = 2;
            }
        }

        if (work->prevCloudType != work->cloudType)
        {
            if (work->cloudType == 2 || (s32)work->cloudType == 3)
            {
                if (work->prevCloudType != 2 && work->prevCloudType != 3)
                {
                    CreateSailSkyCloud(SAILSKYCLOUD_TYPE_0);
                    CreateSailSkyCloud(SAILSKYCLOUD_TYPE_0);

                    if (work->shipType != SHIP_SUBMARINE)
                        CreateSailSkyCloud(SAILSKYCLOUD_TYPE_0);

                    CreateSailSkyCloud(SAILSKYCLOUD_TYPE_1);

                    if (work->shipType != SHIP_SUBMARINE)
                        CreateSailSkyCloud(SAILSKYCLOUD_TYPE_1);
                }
            }
        }

        if (work->cloudType == 3)
        {
            if (work->cloudyness < 32)
                work->cloudyness++;
        }
        else
        {
            if (work->cloudyness != 0)
                work->cloudyness--;
        }
    }

    work->prevCloudType = work->cloudType;

    if (work->sailPlayer != NULL)
    {
        SailPlayer *player = GetStageTaskWorker(work->sailPlayer, SailPlayer);
        s32 angle          = (u16)((u16)-work->voyageManager->angle - player->seaAngle2);

        MtxFx33 mtx;
        MTX_RotY33(&mtx, SinFX(angle), CosFX(angle));

        InitSpatialAudioMatrix(&mtx);
        SetSpatialAudioOriginPosition(&work->sailPlayer->position);
    }

    SailObject_ProcessColliders();

    for (u16 i = 0; i < work->weaponTaskCount; i++)
    {
        StageTask *unknownWork = work->weaponTaskList[i];
        if (unknownWork != NULL)
            SailRingManager_CheckPlayerCollisions(work->ringManager, unknownWork);

        work->weaponTaskList[i] = NULL;
    }
    work->weaponTaskCount = 0;

    ShipType ship = SailManager__GetShipType();
    if (ship == SHIP_JET || ship == SHIP_HOVER)
        SailRingManager_CheckPlayerCollisions(work->ringManager, work->sailPlayer);

    if (work->shipType == SHIP_SUBMARINE && work->timer == 30)
        PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, bgmForShip[work->shipType]);

    work->timer++;
    if ((work->flags & (SAILMANAGER_FLAG_1 | SAILMANAGER_FLAG_2)) == 0)
    {
        work->stageTimer++;
        if (work->stageTimer > 17999)
            work->stageTimer = 17999;
    }
    work->field_30 = 0;

    MtxFx33 matRot;
    MTX_RotY33(&matRot, SinFX(work->voyageManager->angle), CosFX(work->voyageManager->angle));
    MTX_MultVec33(&work->initialVelocity, &matRot, &work->velocity);

    // process time of day timer
    if ((work->flags & SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER) == 0)
    {
        work->daytimeTimer++;
        if (work->daytimeTimer > SECONDS_TO_FRAMES(60.0))
            work->daytimeTimer = SECONDS_TO_FRAMES(0.0);
    }

    // process brightness for current time of day
    if (work->daytimeTimer > SECONDS_TO_FRAMES(12.5) && work->daytimeTimer < SECONDS_TO_FRAMES(17.5))
    {
        u16 percent           = 13 * (work->daytimeTimer - SECONDS_TO_FRAMES(12.5));
        work->skyBrightness.x = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.5), percent);
        work->skyBrightness.y = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.5625), percent);
        work->skyBrightness.z = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.625), percent);
    }

    if (work->daytimeTimer > SECONDS_TO_FRAMES(42.5) && work->daytimeTimer < SECONDS_TO_FRAMES(45.0))
    {
        u16 percent           = 27 * (work->daytimeTimer - SECONDS_TO_FRAMES(42.5));
        work->skyBrightness.x = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), percent);
        work->skyBrightness.y = ObjAlphaSet(FLOAT_TO_FX32(0.8125), FLOAT_TO_FX32(1.0), percent);
        work->skyBrightness.z = ObjAlphaSet(FLOAT_TO_FX32(0.625), FLOAT_TO_FX32(1.0), percent);
    }

    if (work->daytimeTimer > SECONDS_TO_FRAMES(45.0) && work->daytimeTimer < SECONDS_TO_FRAMES(50.0))
    {
        u16 percent           = 13 * (work->daytimeTimer - SECONDS_TO_FRAMES(45.0));
        work->skyBrightness.x = ObjAlphaSet(FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(1.0), percent);
        work->skyBrightness.y = ObjAlphaSet(FLOAT_TO_FX32(0.5625), FLOAT_TO_FX32(0.8125), percent);
        work->skyBrightness.z = ObjAlphaSet(FLOAT_TO_FX32(0.625), FLOAT_TO_FX32(0.625), percent);
    }

    if (work->daytimeTimer >= SECONDS_TO_FRAMES(50.0) || work->daytimeTimer <= SECONDS_TO_FRAMES(12.5))
    {
        work->skyBrightness.x = FLOAT_TO_FX32(0.5);
        work->skyBrightness.y = FLOAT_TO_FX32(0.5625);
        work->skyBrightness.z = FLOAT_TO_FX32(0.625);
    }

    if (work->daytimeTimer >= SECONDS_TO_FRAMES(17.5) && work->daytimeTimer <= SECONDS_TO_FRAMES(42.5))
    {
        work->skyBrightness.x = FLOAT_TO_FX32(1.0);
        work->skyBrightness.y = FLOAT_TO_FX32(1.0);
        work->skyBrightness.z = FLOAT_TO_FX32(1.0);
    }

    if (work->daytimeTimer >= SECONDS_TO_FRAMES(45.0) && work->daytimeTimer <= SECONDS_TO_FRAMES(45.0))
    {
        work->skyBrightness.x = FLOAT_TO_FX32(1.0);
        work->skyBrightness.y = FLOAT_TO_FX32(0.8125);
        work->skyBrightness.z = FLOAT_TO_FX32(0.625);
    }

    if (work->cloudyness != 0)
    {
        s32 change = ObjAlphaSet(FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(0.0), work->cloudyness << 7);
        work->skyBrightness.x -= change;
        work->skyBrightness.y -= change;
        work->skyBrightness.z -= change;

        if (work->skyBrightness.x < FLOAT_TO_FX32(0.375))
            work->skyBrightness.x = FLOAT_TO_FX32(0.375);

        if (work->skyBrightness.y < FLOAT_TO_FX32(0.375))
            work->skyBrightness.y = FLOAT_TO_FX32(0.375);

        if (work->skyBrightness.z < FLOAT_TO_FX32(0.375))
            work->skyBrightness.z = FLOAT_TO_FX32(0.375);
    }

    if (work->isRivalRace && (work->flags & SAILMANAGER_FLAG_8) == 0)
    {
        if (work->voyageManager->voyagePos >= GetStageTaskWorker(work->rivalJohnny, SailPlayer)->racePos.z)
            work->raceRank = 0; // player is in the lead!
        else
            work->raceRank = 1; // player has fallen behind!
    }

    work->flags &= ~SAILMANAGER_FLAG_PLAYED_RING_SFX_THIS_FRAME;
}

// SailUnknown2153770

SailUnknown2153770 *SailUnknown2153770__Create(void)
{
    sailUnknownTask =
        TaskCreate(SailUnknown2153770__Main, SailUnknown2153770__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xEFFF, TASK_GROUP(4), SailUnknown2153770);

    SailUnknown2153770 *work = TaskGetWork(sailUnknownTask, SailUnknown2153770);
    TaskInitWork16(work);

    return work;
}

void SailUnknown2153770__Destructor(Task *task)
{
    sailUnknownTask = NULL;
}

void SailUnknown2153770__Main(void)
{
    SailUnknown2153770 *work = TaskGetWorkCurrent(SailUnknown2153770);

    SailManager *manager = SailManager__GetWork();
    manager->flags &= ~SAILMANAGER_FLAG_DISABLE_BTN_PRESS;
    manager->flags &= ~SAILMANAGER_FLAG_10000000;
}
