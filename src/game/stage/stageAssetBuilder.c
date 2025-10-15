#include <game/stage/gameSystem.h>
#include <game/system/allocator.h>
#include <game/input/touchInput.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/drawState.h>
#include <game/audio/audioSystem.h>
#include <game/file/fsRequest.h>
#include <game/object/objPacket.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/system/sysEvent.h>
#include <game/stage/eventManager.h>
#include <game/stage/mapSys.h>
#include <game/stage/mapFarSys.h>
#include <game/input/replayRecorder.h>
#include <game/game/gameState.h>
#include <game/system/system.h>
#include <game/audio/spatialAudio.h>
#include <game/object/objectManager.h>
#include <stage/core/bgmManager.h>
#include <stage/player/starCombo.h>
#include <stage/core/titleCard.h>
#include <stage/core/ringManager.h>
#include <stage/core/hud.h>
#include <stage/core/pauseMenu.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/screenShake.h>
#include <stage/core/demoPlayer.h>
#include <game/graphics/drawReqTask.h>
#include <stage/gameObject.h>
#include <game/network/wirelessManager.h>

// resources
#include <resources/narc/act_com_lz7.h>

// acts
#include <resources/narc/z11_act_lz7.h>
#include <resources/narc/z21_act_lz7.h>
#include <resources/narc/z31_act_lz7.h>
#include <resources/narc/z41_act_lz7.h>
#include <resources/narc/z51_act_lz7.h>
#include <resources/narc/z61_act_lz7.h>
#include <resources/narc/z71_act_lz7.h>
#include <resources/narc/z91_act_lz7.h>

// bosses
#include <resources/narc/z1boss_act_lz7.h>
#include <resources/narc/z2boss_act_lz7.h>
#include <resources/narc/z3boss_act_lz7.h>
#include <resources/narc/z4boss_act_lz7.h>
#include <resources/narc/z5boss_act_lz7.h>
#include <resources/narc/z6boss_act_lz7.h>
#include <resources/narc/z7boss_act_lz7.h>
#include <resources/narc/z8boss_act_lz7.h>

// --------------------
// TYPES
// --------------------

typedef void (*AreaBuildFunc)(void);
typedef void (*AreaFlushFunc)(void);
typedef void (*AreaReleaseFunc)(void);

// --------------------
// CONSTANTS
// --------------------

// all stages require at least 6 files to function properly
// (object asset archive, map asset archive, map layout archive, map event archive, background, sound archive)
#define STAGE_FILE_COUNT 6

// --------------------
// FUNCTION DECLS
// --------------------

static GameDataFileReqStatus GameDataLoadFileReq(const GMS_GAMEDAT_LOAD_INFO *loadInfo, BOOL isCommonAsset);

static s16 GetLoadedFileID(const GMS_GAMEDAT_LOAD_DATA *loadFiles, u32 count, const char *path);
static void *AllocBossAsset(void *compressedFile);
static void LoadBossAssets(AsyncFileWork *file, const char *path, const GMS_GAMEDAT_LOAD_DATA *loadFiles, OBS_DATA_WORK *files, u16 count);
static void ReleaseBossAssets(OBS_DATA_WORK *files, u32 count);

/* static */ void *LoadAlloc_FromHead(const char *path);
/* static */ void *LoadAlloc_FromTail(const char *path);
/* static */ void *LoadAlloc_Snd(const char *path);

/* static */ void PreLoad_SoundArchiveZone(GMS_GAMEDAT_LOAD_CONTEXT *state);
/* static */ void PreLoad_SoundArchiveBoss(GMS_GAMEDAT_LOAD_CONTEXT *state);

/* static */ void PostLoad_InitRawArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitMapArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitEveArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitMapFar(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitPlayerArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitCommonArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitStageArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitSoundArchive(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ1(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ2(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ3(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ4(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ5(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ6(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZ7(AsyncFileWork *file, const char *path);
/* static */ void PostLoad_InitBossAssetsZF(AsyncFileWork *file, const char *path);

/* static */ void gmGameData__FlushZ11(void);
/* static */ void gmGameData__FlushZ12(void);
/* static */ void gmGameData__FlushZ1B(void);
/* static */ void gmGameData__FlushZ21(void);
/* static */ void gmGameData__FlushZ22(void);
/* static */ void gmGameData__FlushZ2B(void);
/* static */ void gmGameData__FlushZ31(void);
/* static */ void gmGameData__FlushZ32(void);
/* static */ void gmGameData__FlushZ3B(void);
/* static */ void gmGameData__FlushZ41(void);
/* static */ void gmGameData__FlushZ42(void);
/* static */ void gmGameData__FlushZ4B(void);
/* static */ void gmGameData__FlushZ51(void);
/* static */ void gmGameData__FlushZ52(void);
/* static */ void gmGameData__FlushZ5B(void);
/* static */ void gmGameData__FlushZ61(void);
/* static */ void gmGameData__FlushZ62(void);
/* static */ void gmGameData__FlushZ6B(void);
/* static */ void gmGameData__FlushZ71(void);
/* static */ void gmGameData__FlushZ72(void);
/* static */ void gmGameData__FlushZ7B(void);
/* static */ void gmGameData__FlushZFB(void);
/* static */ void gmGameData__FlushZ91(void);

/* static */ void gmGameData__BuildZ11(void);
/* static */ void gmGameData__BuildZ12(void);
/* static */ void gmGameData__BuildZ1B(void);
/* static */ void gmGameData__BuildZ1T(void);
/* static */ void gmGameData__BuildZ21(void);
/* static */ void gmGameData__BuildZ22(void);
/* static */ void gmGameData__BuildZ2B(void);
/* static */ void gmGameData__BuildZ31(void);
/* static */ void gmGameData__BuildZ32(void);
/* static */ void gmGameData__BuildZ3B(void);
/* static */ void gmGameData__BuildZ41(void);
/* static */ void gmGameData__BuildZ42(void);
/* static */ void gmGameData__BuildZ4B(void);
/* static */ void gmGameData__BuildZ51(void);
/* static */ void gmGameData__BuildZ52(void);
/* static */ void gmGameData__BuildZ5B(void);
/* static */ void gmGameData__BuildZ61(void);
/* static */ void gmGameData__BuildZ62(void);
/* static */ void gmGameData__BuildZ6B(void);
/* static */ void gmGameData__BuildZ71(void);
/* static */ void gmGameData__BuildZ72(void);
/* static */ void gmGameData__BuildZ7B(void);
/* static */ void gmGameData__BuildZFB(void);
/* static */ void gmGameData__BuildZ91(void);

/* static */ void gmGameData__ReleaseZ11(void);
/* static */ void gmGameData__ReleaseZ12(void);
/* static */ void gmGameData__ReleaseZ1B(void);
/* static */ void gmGameData__ReleaseZ1T(void);
/* static */ void gmGameData__ReleaseZ21(void);
/* static */ void gmGameData__ReleaseZ22(void);
/* static */ void gmGameData__ReleaseZ2B(void);
/* static */ void gmGameData__ReleaseZ31(void);
/* static */ void gmGameData__ReleaseZ32(void);
/* static */ void gmGameData__ReleaseZ3B(void);
/* static */ void gmGameData__ReleaseZ41(void);
/* static */ void gmGameData__ReleaseZ42(void);
/* static */ void gmGameData__ReleaseZ4B(void);
/* static */ void gmGameData__ReleaseZ51(void);
/* static */ void gmGameData__ReleaseZ52(void);
/* static */ void gmGameData__ReleaseZ5B(void);
/* static */ void gmGameData__ReleaseZ61(void);
/* static */ void gmGameData__ReleaseZ62(void);
/* static */ void gmGameData__ReleaseZ6B(void);
/* static */ void gmGameData__ReleaseZ71(void);
/* static */ void gmGameData__ReleaseZ72(void);
/* static */ void gmGameData__ReleaseZ7B(void);
/* static */ void gmGameData__ReleaseZFB(void);
/* static */ void gmGameData__ReleaseZ91(void);

static s32 GetLoadProgress(s32 count, s32 id, u32 subCount, u32 subID);

// --------------------
// VARIABLES
// --------------------

#ifdef NON_MATCHING

// TODO: figure the order these are meant to be in

#include "stageResources.inc"

static GMS_GAMEDAT_LOAD_CONTEXT loadContext;

OBS_DATA_WORK bossAssetFiles[16];

extern void *eventManagerArchive;
void *gameArchiveSound;
void *gameArchiveCommon;
void *gameArchiveStage;

static const AreaReleaseFunc releaseAreaTable[STAGE_COUNT] = {
    [STAGE_Z11] = gmGameData__ReleaseZ11,
    [STAGE_Z12] = gmGameData__ReleaseZ12,
    [STAGE_TUTORIAL] = gmGameData__ReleaseZ1T,
    [STAGE_Z1B] = gmGameData__ReleaseZ1B,
    [STAGE_Z21] = gmGameData__ReleaseZ21,
    [STAGE_Z22] = gmGameData__ReleaseZ22,
    [STAGE_Z2B] = gmGameData__ReleaseZ2B,
    [STAGE_Z31] = gmGameData__ReleaseZ31,
    [STAGE_Z32] = gmGameData__ReleaseZ32,
    [STAGE_HIDDEN_ISLAND_1] = gmGameData__ReleaseZ91,
    [STAGE_Z3B] = gmGameData__ReleaseZ3B,
    [STAGE_Z41] = gmGameData__ReleaseZ41,
    [STAGE_Z42] = gmGameData__ReleaseZ42,
    [STAGE_Z4B] = gmGameData__ReleaseZ4B,
    [STAGE_Z51] = gmGameData__ReleaseZ51,
    [STAGE_Z52] = gmGameData__ReleaseZ52,
    [STAGE_Z5B] = gmGameData__ReleaseZ5B,
    [STAGE_Z61] = gmGameData__ReleaseZ61,
    [STAGE_Z62] = gmGameData__ReleaseZ62,
    [STAGE_HIDDEN_ISLAND_2] = gmGameData__ReleaseZ91,
    [STAGE_Z6B] = gmGameData__ReleaseZ6B,
    [STAGE_Z71] = gmGameData__ReleaseZ71,
    [STAGE_Z72] = gmGameData__ReleaseZ72,
    [STAGE_Z7B] = gmGameData__ReleaseZ7B,
    [STAGE_BOSS_FINAL] = gmGameData__ReleaseZFB,
    [STAGE_HIDDEN_ISLAND_3] = gmGameData__ReleaseZ91,
    [STAGE_HIDDEN_ISLAND_4] = gmGameData__ReleaseZ31,
    [STAGE_HIDDEN_ISLAND_5] = gmGameData__ReleaseZ91,
    [STAGE_HIDDEN_ISLAND_6] = gmGameData__ReleaseZ11,
    [STAGE_HIDDEN_ISLAND_7] = gmGameData__ReleaseZ11,
    [STAGE_HIDDEN_ISLAND_8] = gmGameData__ReleaseZ31,
    [STAGE_HIDDEN_ISLAND_9] = gmGameData__ReleaseZ21,
    [STAGE_HIDDEN_ISLAND_10] = gmGameData__ReleaseZ21,
    [STAGE_HIDDEN_ISLAND_11] = gmGameData__ReleaseZ31,
    [STAGE_HIDDEN_ISLAND_12] = gmGameData__ReleaseZ51,
    [STAGE_HIDDEN_ISLAND_13] = gmGameData__ReleaseZ51,
    [STAGE_HIDDEN_ISLAND_14] = gmGameData__ReleaseZ91,
    [STAGE_HIDDEN_ISLAND_15] = gmGameData__ReleaseZ41,
    [STAGE_HIDDEN_ISLAND_16] = gmGameData__ReleaseZ91,
    [STAGE_HIDDEN_ISLAND_VS1] = gmGameData__ReleaseZ11,
    [STAGE_HIDDEN_ISLAND_VS2] = gmGameData__ReleaseZ21,
    [STAGE_HIDDEN_ISLAND_VS3] = gmGameData__ReleaseZ31,
    [STAGE_HIDDEN_ISLAND_VS4] = gmGameData__ReleaseZ41,
    [STAGE_HIDDEN_ISLAND_R1] = gmGameData__ReleaseZ91,
    [STAGE_HIDDEN_ISLAND_R2] = gmGameData__ReleaseZ91,
    [STAGE_HIDDEN_ISLAND_R3] = gmGameData__ReleaseZ91,
};

static const AreaFlushFunc flushAreaTable[STAGE_COUNT] = {
    [STAGE_Z11] = gmGameData__FlushZ11,
    [STAGE_Z12] = gmGameData__FlushZ12,
    [STAGE_TUTORIAL] = gmGameData__FlushZ11,
    [STAGE_Z1B] = gmGameData__FlushZ1B,
    [STAGE_Z21] = gmGameData__FlushZ21,
    [STAGE_Z22] = gmGameData__FlushZ22,
    [STAGE_Z2B] = gmGameData__FlushZ2B,
    [STAGE_Z31] = gmGameData__FlushZ31,
    [STAGE_Z32] = gmGameData__FlushZ32,
    [STAGE_HIDDEN_ISLAND_1] = gmGameData__FlushZ91,
    [STAGE_Z3B] = gmGameData__FlushZ3B,
    [STAGE_Z41] = gmGameData__FlushZ41,
    [STAGE_Z42] = gmGameData__FlushZ42,
    [STAGE_Z4B] = gmGameData__FlushZ4B,
    [STAGE_Z51] = gmGameData__FlushZ51,
    [STAGE_Z52] = gmGameData__FlushZ52,
    [STAGE_Z5B] = gmGameData__FlushZ5B,
    [STAGE_Z61] = gmGameData__FlushZ61,
    [STAGE_Z62] = gmGameData__FlushZ62,
    [STAGE_HIDDEN_ISLAND_2] = gmGameData__FlushZ91,
    [STAGE_Z6B] = gmGameData__FlushZ6B,
    [STAGE_Z71] = gmGameData__FlushZ71,
    [STAGE_Z72] = gmGameData__FlushZ72,
    [STAGE_Z7B] = gmGameData__FlushZ7B,
    [STAGE_BOSS_FINAL] = gmGameData__FlushZFB,
    [STAGE_HIDDEN_ISLAND_3] = gmGameData__FlushZ91,
    [STAGE_HIDDEN_ISLAND_4] = gmGameData__FlushZ31,
    [STAGE_HIDDEN_ISLAND_5] = gmGameData__FlushZ91,
    [STAGE_HIDDEN_ISLAND_6] = gmGameData__FlushZ11,
    [STAGE_HIDDEN_ISLAND_7] = gmGameData__FlushZ11,
    [STAGE_HIDDEN_ISLAND_8] = gmGameData__FlushZ31,
    [STAGE_HIDDEN_ISLAND_9] = gmGameData__FlushZ21,
    [STAGE_HIDDEN_ISLAND_10] = gmGameData__FlushZ21,
    [STAGE_HIDDEN_ISLAND_11] = gmGameData__FlushZ31,
    [STAGE_HIDDEN_ISLAND_12] = gmGameData__FlushZ51,
    [STAGE_HIDDEN_ISLAND_13] = gmGameData__FlushZ51,
    [STAGE_HIDDEN_ISLAND_14] = gmGameData__FlushZ91,
    [STAGE_HIDDEN_ISLAND_15] = gmGameData__FlushZ41,
    [STAGE_HIDDEN_ISLAND_16] = gmGameData__FlushZ91,
    [STAGE_HIDDEN_ISLAND_VS1] = gmGameData__FlushZ11,
    [STAGE_HIDDEN_ISLAND_VS2] = gmGameData__FlushZ21,
    [STAGE_HIDDEN_ISLAND_VS3] = gmGameData__FlushZ31,
    [STAGE_HIDDEN_ISLAND_VS4] = gmGameData__FlushZ41,
    [STAGE_HIDDEN_ISLAND_R1] = gmGameData__FlushZ91,
    [STAGE_HIDDEN_ISLAND_R2] = gmGameData__FlushZ91,
    [STAGE_HIDDEN_ISLAND_R3] = gmGameData__FlushZ91,
};

static const AreaBuildFunc buildAreaTable[STAGE_COUNT] = {
    [STAGE_Z11] = gmGameData__BuildZ11,
    [STAGE_Z12] = gmGameData__BuildZ12,
    [STAGE_TUTORIAL] = gmGameData__BuildZ1T,
    [STAGE_Z1B] = gmGameData__BuildZ1B,
    [STAGE_Z21] = gmGameData__BuildZ21,
    [STAGE_Z22] = gmGameData__BuildZ22,
    [STAGE_Z2B] = gmGameData__BuildZ2B,
    [STAGE_Z31] = gmGameData__BuildZ31,
    [STAGE_Z32] = gmGameData__BuildZ32,
    [STAGE_HIDDEN_ISLAND_1] = gmGameData__BuildZ91,
    [STAGE_Z3B] = gmGameData__BuildZ3B,
    [STAGE_Z41] = gmGameData__BuildZ41,
    [STAGE_Z42] = gmGameData__BuildZ42,
    [STAGE_Z4B] = gmGameData__BuildZ4B,
    [STAGE_Z51] = gmGameData__BuildZ51,
    [STAGE_Z52] = gmGameData__BuildZ52,
    [STAGE_Z5B] = gmGameData__BuildZ5B,
    [STAGE_Z61] = gmGameData__BuildZ61,
    [STAGE_Z62] = gmGameData__BuildZ62,
    [STAGE_HIDDEN_ISLAND_2] = gmGameData__BuildZ91,
    [STAGE_Z6B] = gmGameData__BuildZ6B,
    [STAGE_Z71] = gmGameData__BuildZ71,
    [STAGE_Z72] = gmGameData__BuildZ72,
    [STAGE_Z7B] = gmGameData__BuildZ7B,
    [STAGE_BOSS_FINAL] = gmGameData__BuildZFB,
    [STAGE_HIDDEN_ISLAND_3] = gmGameData__BuildZ91,
    [STAGE_HIDDEN_ISLAND_4] = gmGameData__BuildZ31,
    [STAGE_HIDDEN_ISLAND_5] = gmGameData__BuildZ91,
    [STAGE_HIDDEN_ISLAND_6] = gmGameData__BuildZ11,
    [STAGE_HIDDEN_ISLAND_7] = gmGameData__BuildZ11,
    [STAGE_HIDDEN_ISLAND_8] = gmGameData__BuildZ31,
    [STAGE_HIDDEN_ISLAND_9] = gmGameData__BuildZ21,
    [STAGE_HIDDEN_ISLAND_10] = gmGameData__BuildZ21,
    [STAGE_HIDDEN_ISLAND_11] = gmGameData__BuildZ31,
    [STAGE_HIDDEN_ISLAND_12] = gmGameData__BuildZ51,
    [STAGE_HIDDEN_ISLAND_13] = gmGameData__BuildZ51,
    [STAGE_HIDDEN_ISLAND_14] = gmGameData__BuildZ91,
    [STAGE_HIDDEN_ISLAND_15] = gmGameData__BuildZ41,
    [STAGE_HIDDEN_ISLAND_16] = gmGameData__BuildZ91,
    [STAGE_HIDDEN_ISLAND_VS1] = gmGameData__BuildZ11,
    [STAGE_HIDDEN_ISLAND_VS2] = gmGameData__BuildZ21,
    [STAGE_HIDDEN_ISLAND_VS3] = gmGameData__BuildZ31,
    [STAGE_HIDDEN_ISLAND_VS4] = gmGameData__BuildZ41,
    [STAGE_HIDDEN_ISLAND_R1] = gmGameData__BuildZ91,
    [STAGE_HIDDEN_ISLAND_R2] = gmGameData__BuildZ91,
    [STAGE_HIDDEN_ISLAND_R3] = gmGameData__BuildZ91,
};

#else

extern const GMS_GAMEDAT_LOAD_INFO assetList_Common[2];
extern const GMS_GAMEDAT_LOAD_INFO assetList_Stage[STAGE_COUNT];

extern const GMS_GAMEDAT_LOAD_DATA assetList_Z1B[8];
extern const GMS_GAMEDAT_LOAD_DATA assetList_Z2B[14];
extern const GMS_GAMEDAT_LOAD_DATA assetList_Z3B[11];
extern const GMS_GAMEDAT_LOAD_DATA assetList_Z4B[9];
extern const GMS_GAMEDAT_LOAD_DATA assetList_Z5B[10];
extern const GMS_GAMEDAT_LOAD_DATA assetList_Z6B[10];
extern const GMS_GAMEDAT_LOAD_DATA assetList_Z7B[8];
extern const GMS_GAMEDAT_LOAD_DATA assetList_ZFB[9];

extern const AreaFlushFunc flushAreaTable[STAGE_COUNT];
extern const AreaBuildFunc buildAreaTable[STAGE_COUNT];
extern const AreaReleaseFunc releaseAreaTable[STAGE_COUNT];

static GMS_GAMEDAT_LOAD_CONTEXT loadContext;

extern void *eventManagerArchive;
void *gameArchiveSound;
void *gameArchiveCommon;
void *gameArchiveStage;

OBS_DATA_WORK bossAssetFiles[16];

#endif

// --------------------
// FUNCTIONS
// --------------------

void InitGameDataLoadContext(GameDataFileReqMode mode)
{
    MI_CpuClear16(&loadContext, sizeof(loadContext));

    loadContext.mode        = mode;
    loadContext.characterID = gameState.characterID[0];
    loadContext.stageID     = gameState.stageID;
}

GameDataFileReqStatus LoadStageCommonAssets(void)
{
    if (!IsBossStage())
        return GameDataLoadFileReq(&assetList_Common[0], TRUE);
    else
        return GameDataLoadFileReq(&assetList_Common[1], TRUE);
}

GameDataFileReqStatus LoadStageAssets(void)
{
    return GameDataLoadFileReq(&assetList_Stage[loadContext.stageID], FALSE);
}

void ReleaseStageCommonArchives(void)
{
    ReleasePlayerAssets();
    TitleCard__ReleaseCommonArchive();

    if (gameArchiveCommon != NULL)
    {
        HeapFree(HEAP_USER, gameArchiveCommon);
        gameArchiveCommon = NULL;
    }
}

void FlushStageArea(void)
{
    flushAreaTable[gameState.stageID]();

    TitleCard__ReleaseStageArchive();
    MapSys__Flush();
    EventManager__Release();
    MapFarSys__Release();

    if (gameArchiveStage != NULL)
    {
        HeapFree(HEAP_USER, gameArchiveStage);
        gameArchiveStage = NULL;
    }
    ReleaseStageAudioWork();
}

void BuildStageCommonAssets(void)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "com", gameArchiveCommon);
    if (!IsBossStage())
    {
        NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_GMK_GOAL_CHEST_NSBMD));
        NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_GMK_CHEST_EFECT_NSBMD));
        NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_EFF_BARRIER_NSBMD));
        NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_EFF_MAGNET_NSBMD));
    }
    NNS_FndUnmountArchive(&arc);

    LoadDrawState(GetStageDrawState(), DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT | DRAWSTATE_PROJECTION | DRAWSTATE_LIGHT_ALL | DRAWSTATE_EDGECOLORTABLE));
}

void BuildStageArea(void)
{
    MapSys__BuildData();
    EventManager__LoadObjectLayout();
    MapFarSys__Build();
    InitAudioSystemForStage(gameArchiveSound);
    buildAreaTable[gameState.stageID]();
}

void ReleaseStageCommonAssets(void)
{
    if (gameArchiveCommon == NULL)
        return;

    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "com", gameArchiveCommon);
    if (!IsBossStage())
    {
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_GMK_GOAL_CHEST_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_GMK_CHEST_EFECT_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_EFF_BARRIER_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_ACT_COM_LZ7_FILE_EFF_MAGNET_NSBMD));
    }
    NNS_FndUnmountArchive(&arc);
}

void ReleaseStageArea(void)
{
    NNS_SndStopSoundAll();
    NNS_SndStopChannelAll();
    releaseAreaTable[gameState.stageID]();
    MapSys__Release();
    EventManager__ReleaseObjectLayout();
}

void ReleaseStageAudioWork(void)
{
    ReleaseAudioSystem();
    gameArchiveSound = NULL;
}

void *GetStageDrawState(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "eve", eventManagerArchive);

    void *fileData = NNS_FndGetArchiveFileByIndex(&arc, ARC_EVE_FILE_DRAWSTATE);

    NNS_FndUnmountArchive(&arc);
    return fileData;
}

void InitStageLightConfig(void)
{
    void *drawState = GetStageDrawState();
    LoadDrawState(drawState, DRAWSTATE_LIGHT_ALL);
}

void InitStageEdgeConfig(void)
{
    void *drawState = GetStageDrawState();
    LoadDrawState(drawState, DRAWSTATE_EDGECOLORTABLE | DRAWSTATE_EDGEMARKING);
}

GameDataFileReqStatus GameDataLoadFileReq(const GMS_GAMEDAT_LOAD_INFO *loadInfo, BOOL isCommonAsset)
{
    GMS_GAMEDAT_LOAD_CONTEXT *context = &loadContext;

    if (context->status == GAMEDATA_FILEREQ_STATUS_COMPLETE || context->status == GAMEDATA_FILEREQ_STATUS_ERROR)
        return context->status;

    u16 fileID                        = context->fileID;
    const GMS_GAMEDAT_LOAD_DATA *data = &loadInfo->dataTable[fileID];

    switch (context->mode)
    {
        case GAMEDATA_FILEREQ_MODE_0: {
            if (context->file == NULL)
            {
                strcpy(context->path, data->path);

                if (data->proc_pre != NULL)
                    data->proc_pre(context);

                context->file     = FSRequestFileASync(context->path, data->alloc(context->path));
                context->progress = GetLoadProgress((u16)loadInfo->count, context->fileID, 0, 0);
            }
            else
            {
                if (context->file->status == FSREQ_STATUS_CLOSED)
                {
                    if (WirelessManager__Func_2068234() == 2 && (WFS_GetStatus() == WFS_STATE_ERROR || WFS_GetStatus() == WFS_STATE_STOP))
                    {
                        ReleaseFSRequestWork(context->file);
                        context->file   = NULL;
                        context->status = GAMEDATA_FILEREQ_STATUS_ERROR;
                        return context->status;
                    }
                    else
                    {
                        if (data->proc_post != NULL)
                            data->proc_post(context->file, context->path);

                        ReleaseFSRequestWork(context->file);
                        context->file = NULL;
                        context->fileID++;

                        context->progress = GetLoadProgress((u16)loadInfo->count, context->fileID, 0, 0);
                    }
                }
                else if (context->file->status == FSREQ_STATUS_NEEDS_CLOSE)
                {
                    context->progress = GetLoadProgress((u16)loadInfo->count, fileID, 0, 0);
                }
            }
            break;
        }

        case GAMEDATA_FILEREQ_MODE_1: {
            if (context->file == NULL)
            {
                strcpy(context->path, data->path);

                if (data->proc_pre != NULL)
                    data->proc_pre(context);

                context->file = FSRequestFileASync(context->path, data->alloc(context->path));
            }
            else
            {
                if (context->file->status == FSREQ_STATUS_CLOSED)
                {
                    if ((WH_GetConnectBitmap() & ~1) == 0)
                    {
                        ReleaseFSRequestWork(context->file);
                        context->file   = NULL;
                        context->status = GAMEDATA_FILEREQ_STATUS_ERROR;
                        return context->status;
                    }
                    else
                    {
                        if (context->fileID < WFS_Func_206D9B4())
                        {
                            if (data->proc_post != NULL)
                                data->proc_post(context->file, context->path);

                            ReleaseFSRequestWork(context->file);
                            context->file = NULL;
                            context->fileID++;
                        }
                    }
                }
            }
            break;
        }

        case GAMEDATA_FILEREQ_MODE_2: {
            u32 oldBitmap     = context->connectBitmap;
            context->connectBitmap = WH_GetConnectBitmap();
            if (WirelessManager__Func_2068284(oldBitmap) > WirelessManager__Func_2068284(context->connectBitmap))
            {
                context->status = GAMEDATA_FILEREQ_STATUS_ERROR;
                return context->status;
            }

            u16 fileCount = WFS_Func_206D9B4();
            if (!isCommonAsset)
                fileCount -= 2;

            if (context->fileID < fileCount)
                context->fileID++;

            context->progress = GetLoadProgress((u16)loadInfo->count, context->fileID, 0, 0);
            break;
        }
    }

    if (loadInfo->count <= context->fileID)
        context->status = GAMEDATA_FILEREQ_STATUS_COMPLETE;

    return context->status;
}

s16 GetLoadedFileID(const GMS_GAMEDAT_LOAD_DATA *loadFiles, u32 count, const char *path)
{
    for (u16 id = 0; id < count; id++)
    {
        if (STD_CompareString(loadFiles[id].path, path) == 0)
        {
            return id;
        }
    }

    return 0xFFFF;
}

void *AllocBossAsset(void *compressedFile)
{
    void *file = HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(compressedFile));
    RenderCore_CPUCopyCompressed(compressedFile, file);
    HeapFree(HEAP_USER, compressedFile);

    NNS_G3dResDefaultSetup(file);
    void *resource = HeapAllocHead(HEAP_USER, Asset3DSetup__GetTexSize(file));
    Asset3DSetup__GetTexture(file, resource);
    HeapFree(HEAP_USER, file);

    return resource;
}

void LoadBossAssets(AsyncFileWork *file, const char *path, const GMS_GAMEDAT_LOAD_DATA *loadFiles, OBS_DATA_WORK *files, u16 count)
{
    s32 id = GetLoadedFileID(&loadFiles[STAGE_FILE_COUNT], count, path);

    OBS_DATA_WORK *dataWork  = &files[id];
    dataWork->fileData       = AllocBossAsset(file->userData);
    dataWork->referenceCount = 1;

    file->userData = NULL;
}

void ReleaseBossAssets(OBS_DATA_WORK *files, u32 count)
{
    for (u16 id = 0; id < count; id++)
    {
        ObjDataRelease(&files[id]);
    }
}

void *LoadAlloc_FromHead(const char *path)
{
    return FSREQ_AUTO_ALLOC_HEAD;
}

void *LoadAlloc_FromTail(const char *path)
{
    return FSREQ_AUTO_ALLOC_TAIL;
}

void *LoadAlloc_Snd(const char *path)
{
    return NNS_SndHeapAlloc(audioManagerSndHeap, 0x60400, NULL, 0, 0);
}

void PreLoad_SoundArchiveZone(GMS_GAMEDAT_LOAD_CONTEXT *state)
{
    // Empty!
}

void PreLoad_SoundArchiveBoss(GMS_GAMEDAT_LOAD_CONTEXT *state)
{
    // Empty!
}

void PostLoad_InitRawArchive(AsyncFileWork *file, const char *path)
{
    MapSys__LoadArchive_RAW(file->userData);
}

void PostLoad_InitMapArchive(AsyncFileWork *file, const char *path)
{
    void *archive = file->userData;

    MapSys__LoadArchive_MAP(archive);
    TitleCard__LoadStageArchive(archive);
}

void PostLoad_InitEveArchive(AsyncFileWork *file, const char *path)
{
    eventManagerArchive = file->userData;

    file->userData = NULL;
}

void PostLoad_InitMapFar(AsyncFileWork *file, const char *path)
{
    MapFarSys__SetAsset(file->userData);
    file->userData = NULL;
}

void PostLoad_InitPlayerArchive(AsyncFileWork *file, const char *path)
{
    void *archive = HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(file->userData));
    playerArchive = archive;
    RenderCore_CPUCopyCompressed(file->userData, archive);
    HeapFree(HEAP_USER, file->userData);

    file->userData = NULL;
    LoadPlayerAssets();
}

void PostLoad_InitCommonArchive(AsyncFileWork *file, const char *path)
{
    gameArchiveCommon = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(file->userData));
    RenderCore_CPUCopyCompressed(file->userData, gameArchiveCommon);
    TitleCard__LoadCommonArchive(gameArchiveCommon);
}

void PostLoad_InitStageArchive(AsyncFileWork *file, const char *path)
{
    gameArchiveStage = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(file->userData));
    RenderCore_CPUCopyCompressed(file->userData, gameArchiveStage);
}

void PostLoad_InitSoundArchive(AsyncFileWork *file, const char *path)
{
    gameArchiveSound = file->userData;
}

void PostLoad_InitBossAssetsZ1(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z1B, bossAssetFiles, ARRAY_COUNT(assetList_Z1B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZ2(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z2B, bossAssetFiles, ARRAY_COUNT(assetList_Z2B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZ3(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z3B, bossAssetFiles, ARRAY_COUNT(assetList_Z3B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZ4(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z4B, bossAssetFiles, ARRAY_COUNT(assetList_Z4B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZ5(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z5B, bossAssetFiles, ARRAY_COUNT(assetList_Z5B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZ6(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z6B, bossAssetFiles, ARRAY_COUNT(assetList_Z6B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZ7(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_Z7B, bossAssetFiles, ARRAY_COUNT(assetList_Z7B) - STAGE_FILE_COUNT);
}

void PostLoad_InitBossAssetsZF(AsyncFileWork *file, const char *path)
{
    LoadBossAssets(file, path, assetList_ZFB, bossAssetFiles, ARRAY_COUNT(assetList_ZFB) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ11(void)
{
    // Empty
}

void gmGameData__FlushZ12(void)
{
    // Empty
}

void gmGameData__FlushZ1B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z1B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ21(void)
{
    // Empty
}

void gmGameData__FlushZ22(void)
{
    // Empty
}

void gmGameData__FlushZ2B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z2B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ31(void)
{
    // Empty
}

void gmGameData__FlushZ32(void)
{
    // Empty
}

void gmGameData__FlushZ3B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z3B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ41(void)
{
    // Empty
}

void gmGameData__FlushZ42(void)
{
    // Empty
}

void gmGameData__FlushZ4B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z4B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ51(void)
{
    // Empty
}

void gmGameData__FlushZ52(void)
{
    // Empty
}

void gmGameData__FlushZ5B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z5B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ61(void)
{
    // Empty
}

void gmGameData__FlushZ62(void)
{
    // Empty
}

void gmGameData__FlushZ6B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z6B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ71(void)
{
    // Empty
}

void gmGameData__FlushZ72(void)
{
    // Empty
}

void gmGameData__FlushZ7B(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_Z7B) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZFB(void)
{
    ReleaseBossAssets(bossAssetFiles, ARRAY_COUNT(assetList_ZFB) - STAGE_FILE_COUNT);
}

void gmGameData__FlushZ91(void)
{
    // Empty
}

void gmGameData__BuildZ11(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GRD_3LINE_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GST_TREE_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ12(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GRD_3LINE_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GST_TREE_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ1B(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    // Do nothing

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ1T(void)
{
    // Empty
}

void gmGameData__BuildZ21(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_L_PISTON_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_PISTON_EF_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ22(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_L_PISTON_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_PISTON_EF_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ2B(void)
{
    // Empty
}

void gmGameData__BuildZ31(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_VROT_CRANE_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_TRUCK_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ32(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_VROT_CRANE_NSBMD)); 
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_TRUCK_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ3B(void)
{
    // Empty
}

void gmGameData__BuildZ41(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_ANCHOR_ROPE_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_CANNON_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_SB_BAZOOKA_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ42(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_ANCHOR_ROPE_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_CANNON_NSBMD));
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_SB_BAZOOKA_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ4B(void)
{
    // Empty
}

void gmGameData__BuildZ51(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    // Do nothing?

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ52(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    // Do nothing?

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ5B(void)
{
    // Empty
}

void gmGameData__BuildZ61(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    // Do nothing?

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ62(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    // Do nothing?

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ6B(void)
{
    // Empty
}

void gmGameData__BuildZ71(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z71_ACT_LZ7_FILE_MOD_GMK_DOLPHIN_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ72(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z71_ACT_LZ7_FILE_MOD_GMK_DOLPHIN_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__BuildZ7B(void)
{
    // Empty
}

void gmGameData__BuildZFB(void)
{
    // Empty
}

void gmGameData__BuildZ91(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z91_ACT_LZ7_FILE_MOD_GMK_ROPE_C_NSBMD));

    NNS_FndUnmountArchive(&arc);
}

void gmGameData__ReleaseZ11(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GRD_3LINE_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GST_TREE_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ12(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GRD_3LINE_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z11_ACT_LZ7_FILE_MOD_GMK_GST_TREE_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ1B(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        // Do nothing?

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ1T(void)
{
    // Empty
}

void gmGameData__ReleaseZ21(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_L_PISTON_NSBMD)); 
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_PISTON_EF_NSBMD)); 

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ22(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_L_PISTON_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z21_ACT_LZ7_FILE_MOD_GMK_PISTON_EF_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ2B(void)
{
    // Empty
}

void gmGameData__ReleaseZ31(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_VROT_CRANE_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_TRUCK_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ32(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_VROT_CRANE_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z31_ACT_LZ7_FILE_MOD_GMK_TRUCK_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ3B(void)
{
    // Empty
}

void gmGameData__ReleaseZ41(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_ANCHOR_ROPE_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_CANNON_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_SB_BAZOOKA_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ42(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_ANCHOR_ROPE_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_GMK_CANNON_NSBMD));
        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z41_ACT_LZ7_FILE_MOD_SB_BAZOOKA_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ4B(void)
{
    // Empty
}

void gmGameData__ReleaseZ51(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        // Do nothing?

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ52(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        // Do nothing?

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ5B(void)
{
    // Empty
}

void gmGameData__ReleaseZ61(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        // Do nothing?

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ62(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        // Do nothing?

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ6B(void)
{
    // Empty
}

void gmGameData__ReleaseZ71(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z71_ACT_LZ7_FILE_MOD_GMK_DOLPHIN_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ72(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z71_ACT_LZ7_FILE_MOD_GMK_DOLPHIN_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

void gmGameData__ReleaseZ7B(void)
{
    // Empty
}

void gmGameData__ReleaseZFB(void)
{
    // Empty
}

void gmGameData__ReleaseZ91(void)
{
    if (gameArchiveStage != NULL)
    {
        NNSFndArchive arc;
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z91_ACT_LZ7_FILE_MOD_GMK_ROPE_C_NSBMD));

        NNS_FndUnmountArchive(&arc);
    }
}

s32 GetLoadProgress(s32 count, s32 id, u32 subCount, u32 subID)
{
    s32 progress = (u16)((100 * id) / count);

    if (subCount != 0)
        progress = (u16)(progress + ((100 * subID) / (count * subCount)));

    return progress;
}