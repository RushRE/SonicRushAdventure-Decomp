#include <sail/sailManager.h>
#include <sail/unknown2153770.h>
#include <sail/sailPlayer.h>
#include <sail/sailGraphics.h>
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

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SailHUDInitEvent__Create(void);
NOT_DECOMPILED void SailObject__Func_2166D88(void);
NOT_DECOMPILED void SailRampTrick__Create(void);
NOT_DECOMPILED void SailTraining__Create(void);
NOT_DECOMPILED void SailJetBoatCloud__CreateUnknown(void);
NOT_DECOMPILED void SailCloud__Create(s32 type);
NOT_DECOMPILED void SailSeaMapView__Create(ShipType ship);
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

    if ((state->sailUnknownFlags & 1) == 0 && (state->sailVsJohnny || (state->missionType == MISSION_TYPE_2 || state->missionType == MISSION_TYPE_3)))
    {
        if (state->sailPadReplayData == NULL)
        {
            state->sailPadReplayData = HeapAllocHead(HEAP_USER, sizeof(KeyDataHeader) + (12799 * sizeof(KeyDataPadFrame)));
            CreateReplayRecorderPadEx(REPLAYRECORDER_TYPE_RECORD, &padInput, NULL, state->sailPadReplayData, sizeof(KeyDataHeader) + (12799 * sizeof(KeyDataPadFrame)), 0,
                                      TASK_PRIORITY_UPDATE_LIST_START + 1);
        }
        else
        {
            replayActive = TRUE;
            CreateReplayRecorderPad(REPLAYRECORDER_TYPE_PLAY_MEMORY, &padInput, NULL, state->sailPadReplayData, sizeof(KeyDataHeader) + (12799 * sizeof(KeyDataPadFrame)));
        }

        if (state->sailTouchReplayData == NULL)
        {
            state->sailTouchReplayData = HeapAllocHead(HEAP_USER, sizeof(KeyDataHeader) + (38399 * sizeof(KeyDataTouchFrame)));
            CreateReplayRecorderTouchEx(REPLAYRECORDER_TYPE_RECORD, &touchInput, NULL, state->sailTouchReplayData, sizeof(KeyDataHeader) + (38399 * sizeof(KeyDataTouchFrame)), 0,
                                        TASK_PRIORITY_UPDATE_LIST_START + 1);
        }
        else
        {
            CreateReplayRecorderTouch(REPLAYRECORDER_TYPE_PLAY_MEMORY, &touchInput, NULL, state->sailTouchReplayData, sizeof(KeyDataHeader) + (38399 * sizeof(KeyDataTouchFrame)));
        }
    }

    if ((!state->sailVsJohnny && state->missionType == MISSION_TYPE_0) && state->seaMapNodeList.nodes.numObjects != 0)
    {
        GXS_SetVisiblePlane(GX_PLANEMASK_ALL);
        SailSeaMapView__Create(state->sailShipType);
    }

    SailManager *manager = SailManager__Create();
    if (replayActive)
        manager->flags |= SAILMANAGER_FLAG_REPLAY_ACTIVE;

    if (manager->missionType != MISSION_TYPE_0 && manager->missionType == MISSION_TYPE_TRAINING)
        SailTraining__Create();

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

void SailManager__Func_2152CAC(StageTask *work)
{
    SailManager *manager = SailManager__GetWork();

    if (manager != NULL)
    {
        if (manager->unknownListCount < 6)
        {
            manager->unknownList[manager->unknownListCount] = work;
            manager->unknownListCount++;
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

    sailManagerTask = TaskCreate(SailManager__Main, SailManager__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xEFFA, TASK_GROUP(5), SailManager);

    work = TaskGetWork(sailManagerTask, SailManager);
    TaskInitWork16(work);

    work->field_4   = -1;
    work->shipType  = state->sailShipType;
    work->field_5DC = 0;

    if (state->missionType != MISSION_TYPE_0)
    {
        work->flags |= SAILMANAGER_FLAG_400;
        work->missionType  = state->missionType;
        work->missionID    = state->missionTimeLimit;
        work->missionQuota = state->missionQuota;
        state->missionType = MISSION_TYPE_0;
        MI_CpuClear16(&state->missionTimeLimit, 8);

        if (work->missionType == MISSION_TYPE_TRAINING)
            work->flags |= SAILMANAGER_FLAG_FREEZE_ALPHA_TIMER;

        if (work->missionType == MISSION_TYPE_REACH_GOAL)
        {
            state->missionFlag = FALSE;
            work->field_5DC    = 2;
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

    work->camera = SailCamera__Create();
    InitSailAssets();

    if ((work->flags & SAILMANAGER_FLAG_400) != 0 || work->isRivalRace && work->shipType == SHIP_JET)
        SailChallengeHUD__Create();

    work->sailPlayer = SailPlayer__Create(work->shipType, FALSE);

    if (work->isRivalRace && work->shipType == SHIP_JET)
        work->rivalJohnny = SailPlayer__Create(SHIP_JET, TRUE);

    work->sea           = SailSea__Create();
    work->voyageManager = SailVoyageManager__Create();
    work->ringManager   = SailRingManager_Create();
    work->eventManager  = SailEventManager__Create();
    work->hud           = SailHUD__Create();

    if (SailManager__GetShipType() != SHIP_SUBMARINE)
        SailJetBoatCloud__CreateUnknown();

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

    work->dword64.x  = FLOAT_TO_FX32(1.0);
    work->dword64.y  = FLOAT_TO_FX32(1.0);
    work->dword64.z  = FLOAT_TO_FX32(1.0);
    work->alphaTimer = SECONDS_TO_FRAMES(25.0);
    work->dword40.x  = FLOAT_TO_FX32(1.0) - (ObjDispRand() & 0x1FFF);
    work->dword40.z  = FLOAT_TO_FX32(1.0) - (ObjDispRand() & 0x1FFF);
    work->velocity.x = work->dword40.x;
    work->velocity.z = work->dword40.z;
    TouchField__Init(&work->touchField);
    SailVoyageManager__SetupVoyage();
    SailHUDInitEvent__Create();

    work->fontFile = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fontFile, 1);
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

    if (work->missionType != MISSION_TYPE_3 || work->shipType != SHIP_SUBMARINE)
    {
        if (work->field_5A != 3 && (work->timer & 0x1FF) == 0)
        {
            if ((ObjDispRand() & 3) == 0)
            {
                if (work->field_5A == 2)
                    work->field_5A = 0;

                if (work->field_5A == 0)
                    work->field_5A = 2;
            }
        }

        if (work->field_5C != work->field_5A)
        {
            if (work->field_5A == 2 || (s32)work->field_5A == 3)
            {
                if (work->field_5C != 2 && work->field_5C != 3)
                {
                    SailCloud__Create(0);
                    SailCloud__Create(0);

                    if (work->shipType != SHIP_SUBMARINE)
                        SailCloud__Create(0);

                    SailCloud__Create(1);

                    if (work->shipType != SHIP_SUBMARINE)
                        SailCloud__Create(1);
                }
            }
        }

        if (work->field_5A == 3)
        {
            if (work->field_50 < 32)
                work->field_50++;
        }
        else
        {
            if (work->field_50 != 0)
                work->field_50--;
        }
    }

    work->field_5C = work->field_5A;

    if (work->sailPlayer != NULL)
    {
        SailPlayer *player = GetStageTaskWorker(work->sailPlayer, SailPlayer);
        s32 angle          = (u16)((u16)-work->voyageManager->angle - player->field_1CA);

        MtxFx33 mtx;
        MTX_RotY33(&mtx, SinFX(angle), CosFX(angle));

        InitSpatialAudioMatrix(&mtx);
        SetSpatialAudioOriginPosition(&work->sailPlayer->position);
    }

    SailObject__Func_2166D88();

    for (u16 i = 0; i < work->unknownListCount; i++)
    {
        StageTask *unknownWork = work->unknownList[i];
        if (unknownWork != NULL)
            SailRingManager_Func_2156AB4(work->ringManager, unknownWork);

        work->unknownList[i] = NULL;
    }
    work->unknownListCount = 0;

    ShipType ship = SailManager__GetShipType();
    if (ship == SHIP_JET || ship == SHIP_HOVER)
        SailRingManager_Func_2156AB4(work->ringManager, work->sailPlayer);

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
    MTX_MultVec33(&work->dword40, &matRot, &work->velocity);

    if ((work->flags & SAILMANAGER_FLAG_FREEZE_ALPHA_TIMER) == 0)
    {
        work->alphaTimer++;
        if (work->alphaTimer > 3600)
            work->alphaTimer = 0;
    }

    if (work->alphaTimer > 750 && work->alphaTimer < 1050)
    {
        u16 percent     = 13 * (work->alphaTimer - 750);
        work->dword64.x = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.5), percent);
        work->dword64.y = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.5625), percent);
        work->dword64.z = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.625), percent);
    }

    if (work->alphaTimer > 2550 && work->alphaTimer < 2700)
    {
        u16 percent     = 27 * (work->alphaTimer - 2550);
        work->dword64.x = ObjAlphaSet(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), percent);
        work->dword64.y = ObjAlphaSet(FLOAT_TO_FX32(0.8125), FLOAT_TO_FX32(1.0), percent);
        work->dword64.z = ObjAlphaSet(FLOAT_TO_FX32(0.625), FLOAT_TO_FX32(1.0), percent);
    }

    if (work->alphaTimer > 2700 && work->alphaTimer < 3000)
    {
        u16 percent     = 13 * (work->alphaTimer - 2700);
        work->dword64.x = ObjAlphaSet(FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(1.0), percent);
        work->dword64.y = ObjAlphaSet(FLOAT_TO_FX32(0.5625), FLOAT_TO_FX32(0.8125), percent);
        work->dword64.z = ObjAlphaSet(FLOAT_TO_FX32(0.625), FLOAT_TO_FX32(0.625), percent);
    }

    if (work->alphaTimer >= 3000 || work->alphaTimer <= 750)
    {
        work->dword64.x = FLOAT_TO_FX32(0.5);
        work->dword64.y = FLOAT_TO_FX32(0.5625);
        work->dword64.z = FLOAT_TO_FX32(0.625);
    }

    if (work->alphaTimer >= 1050 && work->alphaTimer <= 2550)
    {
        work->dword64.x = FLOAT_TO_FX32(1.0);
        work->dword64.y = FLOAT_TO_FX32(1.0);
        work->dword64.z = FLOAT_TO_FX32(1.0);
    }

    if (work->alphaTimer >= 2700 && work->alphaTimer <= 2700)
    {
        work->dword64.x = FLOAT_TO_FX32(1.0);
        work->dword64.y = FLOAT_TO_FX32(0.8125);
        work->dword64.z = FLOAT_TO_FX32(0.625);
    }

    if (work->field_50 != 0)
    {
        s32 change = ObjAlphaSet(FLOAT_TO_FX32(0.25), 0, work->field_50 << 7);
        work->dword64.x -= change;
        work->dword64.y -= change;
        work->dword64.z -= change;

        if (work->dword64.x < FLOAT_TO_FX32(0.375))
            work->dword64.x = FLOAT_TO_FX32(0.375);

        if (work->dword64.y < FLOAT_TO_FX32(0.375))
            work->dword64.y = FLOAT_TO_FX32(0.375);

        if (work->dword64.z < FLOAT_TO_FX32(0.375))
            work->dword64.z = FLOAT_TO_FX32(0.375);
    }

    if (work->isRivalRace && (work->flags & SAILMANAGER_FLAG_8) == 0)
    {
        if (work->voyageManager->voyagePos >= GetStageTaskWorker(work->rivalJohnny, SailPlayer)->racePos.z)
            work->field_28 = FALSE;
        else
            work->field_28 = TRUE;
    }

    work->flags &= ~SAILMANAGER_FLAG_1000000;
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
