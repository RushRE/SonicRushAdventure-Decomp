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
#include <network/wirelessManager.h>

// files
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
// TEMP
// --------------------

NOT_DECOMPILED void *eventManagerArchive;

NOT_DECOMPILED const GMS_GAMEDAT_LOAD_INFO assetList_Common[2];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_INFO assetList_Stage[STAGE_COUNT];

NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z1B[8];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z2B[14];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z3B[11];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z4B[9];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z5B[10];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z6B[10];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_Z7B[8];
NOT_DECOMPILED const GMS_GAMEDAT_LOAD_DATA assetList_ZFB[9];

NOT_DECOMPILED const AreaFlushFunc flushAreaTable[STAGE_COUNT];
NOT_DECOMPILED const AreaBuildFunc buildAreaTable[STAGE_COUNT];
NOT_DECOMPILED const AreaReleaseFunc releaseAreaTable[STAGE_COUNT];

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

static GMS_GAMEDAT_LOAD_CONTEXT loadContext;
void *gameArchiveSound;
void *gameArchiveCommon;
void *gameArchiveStage;
OBS_DATA_WORK bossAssetFiles[16];

// TODO: figure the order these are meant to be in
/*
static const GMS_GAMEDAT_LOAD_DATA assetList_CommonBoss[2] = { { "/narc/player_lz7.narc", LoadAlloc_FromHead, NULL, PostLoad_InitPlayerArchive },
                                                        { "/narc/act_com_b_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitCommonArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_CommonAct[2] = { { "/narc/player_lz7.narc", LoadAlloc_FromHead, NULL, PostLoad_InitPlayerArchive },
                                                       { "/narc/act_com_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitCommonArchive } };


static const GMS_GAMEDAT_LOAD_DATA assetList_Z93[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z93_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z93_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z11[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z11_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z11_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z11.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z62[STAGE_FILE_COUNT] = { { "/narc/z61_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z62_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z62_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z62_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z61.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z62/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z12[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z12_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z12_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z12_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z12/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z94[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z33_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z33_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z914[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm9_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm9_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS3[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zv3_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zv3_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z95[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z94_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z94_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z21[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z21_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z21_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z22[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z22_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z22_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z22_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z22/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z96[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zm1_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zm1_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z915[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z41_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm10_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm10_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z41/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z71[STAGE_FILE_COUNT] = { { "/narc/z71_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z71_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z71_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z71_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z71.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z71/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z97[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zm2_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zm2_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z72[STAGE_FILE_COUNT] = { { "/narc/z71_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z72_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z72_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z72_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z71.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z72/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS4[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z41_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zv4_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zv4_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z41/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z31[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z31_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z31_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z32[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z32_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z32_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z32_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z32/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z98[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zm3_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zm3_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z916[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm11_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm11_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_R2[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                { "/narc/zr2_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                { "/narc/zr2_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_R3[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                { "/narc/zr3_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                { "/narc/zr3_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z99[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zm4_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zm4_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z41[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z41_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z41_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z41_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z41/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z42[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z42_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z42_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z42_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z42/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z910[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm5_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm5_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS1[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zv1_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zv1_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z911[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm6_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm6_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z51[STAGE_FILE_COUNT] = { { "/narc/z51_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z51_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z51_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z51_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z51/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z1T[STAGE_FILE_COUNT] = { { "/narc/z1t_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                        { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                        { "/narc/z1t_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                        { "/narc/z1t_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                        { "/bg/z11.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                        { "/snd/z1t/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_R1[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                { "/narc/zr1_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                { "/narc/zr1_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z52[STAGE_FILE_COUNT] = { { "/narc/z52_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z52_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z52_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z52_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z52/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z912[STAGE_FILE_COUNT] = { { "/narc/z51_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z51_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm7_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm7_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z51/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS2[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/zv2_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/zv2_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z91[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z91_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z91_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z913[STAGE_FILE_COUNT] = { { "/narc/z51_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z51_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/zm8_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/zm8_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z51/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z92[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z92_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z92_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };


static const GMS_GAMEDAT_LOAD_DATA assetList_Z61[STAGE_FILE_COUNT] = { { "/narc/z61_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z61_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z61_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z61_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z61.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z61/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z1B[8] = { { "/narc/z1boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z1boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z1boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z1boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z1boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z1b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                 { "/mod/boss1_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ1 },
                                                 { "/mod/boss1_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ1 } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z2B[14] = { { "/narc/z2boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z2boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/z2boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/z2boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z2boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z2b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                  { "/mod/boss2_body_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_arm_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_drop_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_ball_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_spike_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_zako_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_stage_00_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                  { "/mod/boss2_stage_01_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z3B[11] = { { "/narc/z3boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z3boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/z3boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/z3boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z3boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z3b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                  { "/mod/boss3_body_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                  { "/mod/boss3_stage_00_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                  { "/mod/boss3_stage_01_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                  { "/mod/boss3_stage_02_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                  { "/mod/boss3_stage_03_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 } };

static const GMS_GAMEDAT_LOAD_DATA assetList_ZFB[9] = { { "/narc/z8boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z8boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z8boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z8boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z8boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/zfb/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                 { "/mod/bossF_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZF },
                                                 { "/mod/bossF_arm_l_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZF },
                                                 { "/mod/bossF_arm_r_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZF } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z5B[10] = { { "/narc/z5boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z5boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/z5boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/z5boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z5boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z5b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                  { "/mod/boss5_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 },
                                                  { "/mod/boss5_core_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 },
                                                  { "/mod/boss5_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 },
                                                  { "/mod/boss5_map_a_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z6B[10] = { { "/narc/z6boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                  { "/narc/z6boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                  { "/narc/z6boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                  { "/narc/z6boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                  { "/bg/z6boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                  { "/snd/z6b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                  { "/mod/boss6_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 },
                                                  { "/mod/boss6_zako_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 },
                                                  { "/mod/boss6_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 },
                                                  { "/mod/boss6_sky_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z7B[8] = { { "/narc/z7boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z7boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z7boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z7boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z7boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z7b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                 { "/mod/boss7_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ7 },
                                                 { "/mod/boss7_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ7 } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z4B[9] = { { "/narc/z4boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                 { "/narc/z4boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                 { "/narc/z4boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                 { "/narc/z4boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                 { "/bg/z4boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                 { "/snd/z4b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                 { "/mod/boss4_body_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ4 },
                                                 { "/mod/boss4_core_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ4 },
                                                 { "/mod/boss4_stage_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ4 } };

static const GMS_GAMEDAT_LOAD_INFO assetList_Common[2] = { { assetList_CommonAct, 2 }, { assetList_CommonBoss, 2 } };

static const GMS_GAMEDAT_LOAD_INFO assetList_Stage[STAGE_COUNT] = {
    [STAGE_Z11] = { assetList_Z11, 6 },
    [STAGE_Z12] = { assetList_Z12, 6 },
    [STAGE_TUTORIAL] = { assetList_Z1T, 6 },
    [STAGE_Z1B] = { assetList_Z1B, 8 },
    [STAGE_Z21] = { assetList_Z21, 6 },
    [STAGE_Z22] = { assetList_Z22, 6 },
    [STAGE_Z2B] = { assetList_Z2B, 14 },
    [STAGE_Z31] = { assetList_Z31, 6 },
    [STAGE_Z32] = { assetList_Z32, 6 },
    [STAGE_HIDDEN_ISLAND_1] = { assetList_Z91, 6 },
    [STAGE_Z3B] = { assetList_Z3B, 11 },
    [STAGE_Z41] = { assetList_Z41, 6 },
    [STAGE_Z42] = { assetList_Z42, 6 },
    [STAGE_Z4B] = { assetList_Z4B, 9 },
    [STAGE_Z51] = { assetList_Z51, 6 },
    [STAGE_Z52] = { assetList_Z52, 6 },
    [STAGE_Z5B] = { assetList_Z5B, 10 },
    [STAGE_Z61] = { assetList_Z61, 6 },
    [STAGE_Z62] = { assetList_Z62, 6 },
    [STAGE_HIDDEN_ISLAND_2] = { assetList_Z92, 6 },
    [STAGE_Z6B] = { assetList_Z6B, 10 },
    [STAGE_Z71] = { assetList_Z71, 6 },
    [STAGE_Z72] = { assetList_Z72, 6 },
    [STAGE_Z7B] = { assetList_Z7B, 8 },
    [STAGE_BOSS_FINAL] = { assetList_ZFB, 9 },
    [STAGE_HIDDEN_ISLAND_3] = { assetList_Z93, 6 },
    [STAGE_HIDDEN_ISLAND_4] = { assetList_Z94, 6 },
    [STAGE_HIDDEN_ISLAND_5] = { assetList_Z95, 6 },
    [STAGE_HIDDEN_ISLAND_6] = { assetList_Z96, 6 },
    [STAGE_HIDDEN_ISLAND_7] = { assetList_Z97, 6 },
    [STAGE_HIDDEN_ISLAND_8] = { assetList_Z98, 6 },
    [STAGE_HIDDEN_ISLAND_9] = { assetList_Z99, 6 },
    [STAGE_HIDDEN_ISLAND_10] = { assetList_Z910, 6 },
    [STAGE_HIDDEN_ISLAND_11] = { assetList_Z911, 6 },
    [STAGE_HIDDEN_ISLAND_12] = { assetList_Z912, 6 },
    [STAGE_HIDDEN_ISLAND_13] = { assetList_Z913, 6 },
    [STAGE_HIDDEN_ISLAND_14] = { assetList_Z914, 6 },
    [STAGE_HIDDEN_ISLAND_15] = { assetList_Z915, 6 },
    [STAGE_HIDDEN_ISLAND_16] = { assetList_Z916, 6 },
    [STAGE_HIDDEN_ISLAND_VS1] = { assetList_VS1, 6 },
    [STAGE_HIDDEN_ISLAND_VS2] = { assetList_VS2, 6 },
    [STAGE_HIDDEN_ISLAND_VS3] = { assetList_VS3, 6 },
    [STAGE_HIDDEN_ISLAND_VS4] = { assetList_VS4, 6 },
    [STAGE_HIDDEN_ISLAND_R1] = { assetList_R1, 6 },
    [STAGE_HIDDEN_ISLAND_R2] = { assetList_R2, 6 },
    [STAGE_HIDDEN_ISLAND_R3] = { assetList_R3, 6 },
};

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
*/

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

    LoadDrawState(GetStageDrawState(), DRAWSTATE_SWAPBUFFERMODE | DRAWSTATE_SHININESS | DRAWSTATE_SHADING_STYLE | DRAWSTATE_TOONTABLE | DRAWSTATE_ALPHATEST | DRAWSTATE_ALPHABLEND
                                             | DRAWSTATE_SWAPSORTMODE | DRAWSTATE_FOGOFFSET | DRAWSTATE_FOGCOLOR | DRAWSTATE_FOGTABLE | DRAWSTATE_EDGEMARKING
                                             | DRAWSTATE_ANTIALIASING | DRAWSTATE_DISPLAY1DOTDEPTH | DRAWSTATE_CLEARCOLOR);
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
    LoadDrawState(drawState, DRAWSTATE_LIGHT3 | DRAWSTATE_LIGHT2 | DRAWSTATE_LIGHT1 | DRAWSTATE_LIGHT0);
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

NONMATCH_FUNC void LoadBossAssets(AsyncFileWork *file, const char *path, const GMS_GAMEDAT_LOAD_DATA *loadFiles, OBS_DATA_WORK *files, u16 count)
{
#ifdef NON_MATCHING
    s32 id                   = GetLoadedFileID(&loadFiles[STAGE_FILE_COUNT], count, path);
    files[id].fileData       = AllocBossAsset(file->userData);
    files[id].referenceCount = 1;
    file->userData           = NULL;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r1
	ldrh r1, [sp, #0x18]
	mov r7, r0
	add r0, r2, #0x60
	mov r2, r4
	mov r6, r3
	bl GetLoadedFileID
	mov r4, r0
	ldr r0, [r7, #0x60]
	add r5, r6, r4, lsl #3
	bl AllocBossAsset
	str r0, [r6, r4, lsl #3]
	mov r0, #1
	strh r0, [r5, #4]
	mov r0, #0
	str r0, [r7, #0x60]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
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