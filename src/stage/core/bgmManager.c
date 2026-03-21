#include <stage/core/bgmManager.h>
#include <game/audio/audioSystem.h>
#include <game/audio/spatialAudio.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>

// --------------------
// STRUCTS
// --------------------

struct StageTrack
{
    // 2 tracks per stage (non-pinch & pinch, only used for bosses)
    // 1 set of tracks per character (likely leftover from rush having unique themes per character and not per act)
    u16 trackID[CHARACTER_COUNT][2];
};

// --------------------
// VARIABLES
// --------------------

static Task *sBGMManagerTaskSingleton;
static BOOL sStoredProgNoTable;
NNSSndHandle gBGMHandle;
static BOOL usingUnderwaterBGM;
static NNSSndHandle sPinchBGMHandle;

static u16 sBGMTrackProgNo[SND_TRACK_NUM_PER_PLAYER] = { 0xFFFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

static const struct StageTrack sTrackForStage[STAGE_COUNT] = {
    [STAGE_Z11] = { .trackID = 
    { 
        [CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 },     // Sonic BGM (normal, pinch)
        [CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 } }    // Blaze BGM (normal, pinch)
    },

    [STAGE_Z12] = { .trackID = 
    { 
        [CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_1ACT2, SND_ZONE_SEQ_SEQ_1ACT2 },     // Sonic BGM (normal, pinch)
        [CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_1ACT2, SND_ZONE_SEQ_SEQ_1ACT2 } }    // Blaze BGM (normal, pinch)
    },

    [STAGE_TUTORIAL] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_TUTORIAL, SND_ZONE_SEQ_SEQ_TUTORIAL },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_TUTORIAL, SND_ZONE_SEQ_SEQ_TUTORIAL } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_Z1B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW },      // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW } }     // Blaze BGM (normal, pinch)
	},

    [STAGE_Z21] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z22] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_2ACT2, SND_ZONE_SEQ_SEQ_2ACT2 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_2ACT2, SND_ZONE_SEQ_SEQ_2ACT2 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z2B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW },      // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW } }     // Blaze BGM (normal, pinch)
	},

    [STAGE_Z31] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z32] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_3ACT2, SND_ZONE_SEQ_SEQ_3ACT2 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_3ACT2, SND_ZONE_SEQ_SEQ_3ACT2 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_1] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_Z3B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW },      // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW } }     // Blaze BGM (normal, pinch)
	},

    [STAGE_Z41] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_4ACT1, SND_ZONE_SEQ_SEQ_4ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_4ACT1, SND_ZONE_SEQ_SEQ_4ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z42] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_4ACT2, SND_ZONE_SEQ_SEQ_4ACT2 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_4ACT2, SND_ZONE_SEQ_SEQ_4ACT2 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z4B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW },      // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW } }     // Blaze BGM (normal, pinch)
	},

    [STAGE_Z51] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_5ACT1, SND_ZONE_SEQ_SEQ_5ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_5ACT1, SND_ZONE_SEQ_SEQ_5ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z52] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_5ACT2, SND_ZONE_SEQ_SEQ_5ACT2 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_5ACT2, SND_ZONE_SEQ_SEQ_5ACT2 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z5B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW },      // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW } }     // Blaze BGM (normal, pinch)
	},

    [STAGE_Z61] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_6ACT1, SND_ZONE_SEQ_SEQ_6ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_6ACT1, SND_ZONE_SEQ_SEQ_6ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z62] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_6ACT2, SND_ZONE_SEQ_SEQ_6ACT2 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_6ACT2, SND_ZONE_SEQ_SEQ_6ACT2 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_2] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_Z6B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW },      // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS, SND_ZONE_SEQ_SEQ_BOSSW } }     // Blaze BGM (normal, pinch)
	},

    [STAGE_Z71] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_7ACT1, SND_ZONE_SEQ_SEQ_7ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_7ACT1, SND_ZONE_SEQ_SEQ_7ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z72] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_7ACT2, SND_ZONE_SEQ_SEQ_7ACT2 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_7ACT2, SND_ZONE_SEQ_SEQ_7ACT2 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_Z7B] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSS7, SND_ZONE_SEQ_SEQ_BOSS7W },    // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSS7, SND_ZONE_SEQ_SEQ_BOSS7W } }   // Blaze BGM (normal, pinch)
	},

    [STAGE_BOSS_FINAL] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_BOSSF, SND_ZONE_SEQ_SEQ_BOSSFW },    // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_BOSSF, SND_ZONE_SEQ_SEQ_BOSSFW } }   // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_3] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_4] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_5] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_6] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_7] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_8] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_9] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_10] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_11] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_12] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_5ACT1, SND_ZONE_SEQ_SEQ_5ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_5ACT1, SND_ZONE_SEQ_SEQ_5ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_13] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_5ACT1, SND_ZONE_SEQ_SEQ_5ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_5ACT1, SND_ZONE_SEQ_SEQ_5ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_14] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_15] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_4ACT1, SND_ZONE_SEQ_SEQ_4ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_4ACT1, SND_ZONE_SEQ_SEQ_4ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_16] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_VS1] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_1ACT1, SND_ZONE_SEQ_SEQ_1ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_VS2] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_2ACT1, SND_ZONE_SEQ_SEQ_2ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_VS3] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_3ACT1, SND_ZONE_SEQ_SEQ_3ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_VS4] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_4ACT1, SND_ZONE_SEQ_SEQ_4ACT1 },     // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_4ACT1, SND_ZONE_SEQ_SEQ_4ACT1 } }    // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_R1] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_R2] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},

    [STAGE_HIDDEN_ISLAND_R3] = { .trackID = 
    { 
		[CHARACTER_SONIC] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN },   // Sonic BGM (normal, pinch)
		[CHARACTER_BLAZE] = { SND_ZONE_SEQ_SEQ_HIDDEN, SND_ZONE_SEQ_SEQ_HIDDEN } }  // Blaze BGM (normal, pinch)
	},
};

// --------------------
// FUNCTION DECLS
// --------------------

static void StageBGMManager_Main(void);
static void StageBGMManager_Destructor(Task *task);

// handles swapping between track variants (e.g. underwater vs not underwater)
static BOOL HandleStageBGMVariantChange(BOOL isInWater);

static void ManagedSfx_Destructor(Task *task);
static void ManagedSfx_Main(void);

// --------------------
// FUNCTIONS
// --------------------

// StageBGMManager
void InitStageBGM(void)
{
    NNS_SndHandleInit(&gBGMHandle);
    NNS_SndHandleInit(&sPinchBGMHandle);

    usingUnderwaterBGM = FALSE;
    sStoredProgNoTable  = FALSE;

    MI_CpuFill16(sBGMTrackProgNo, 0xFFFF, sizeof(sBGMTrackProgNo));
}

void ReleaseStageBGM(void)
{
    StopStageBGM();
    ReleaseStageSfx(&gBGMHandle);
    ReleaseStageSfx(&sPinchBGMHandle);
}

void StartStageBGM(BOOL inWater)
{
    u32 stage     = gameState.stageID;
    u16 character = gameState.characterID[0];

    if (IsBossStage())
    {
        StopStageSfx(&gDefaultTrackPlayer);
        StopStageSfx(&gBGMHandle);
        StopStageSfx(&sPinchBGMHandle);
        PlayTrack(&gBGMHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, sTrackForStage[stage].trackID[character][0]);
    }
    else
    {
        s32 volume = GetMusicVolume();

        StopStageSfx(&gBGMHandle);
        StopStageSfx(&sPinchBGMHandle);
        NNS_SndArcPlayerStartSeq(&gBGMHandle, sTrackForStage[stage].trackID[character][0]);
        NNS_SndPlayerSetVolume(&gBGMHandle, volume);

        usingUnderwaterBGM = FALSE;

        NNS_SndUpdateDriverInfo();
        ChangeStageBGMVariant(inWater);
    }
}

void StopStageBGM(void)
{
    FadeOutStageBGM(0);
}

void FadeOutStageBGM(s32 fadeFrames)
{
    FadeOutStageSfx(&gBGMHandle, fadeFrames);
    FadeOutStageSfx(&sPinchBGMHandle, fadeFrames);
}

void ChangeStageBGMVariant(BOOL isInWater)
{
    if (!IsBossStage() && usingUnderwaterBGM != isInWater)
    {
        BOOL didVariantChange = FALSE;
        if (sBGMManagerTaskSingleton == NULL)
            didVariantChange = HandleStageBGMVariantChange(isInWater);

        if (didVariantChange == FALSE)
        {
            if (sBGMManagerTaskSingleton == NULL)
                sBGMManagerTaskSingleton =
                    TaskCreate(StageBGMManager_Main, StageBGMManager_Destructor, TASK_FLAG_NONE, 3, TASK_PRIORITY_UPDATE_LIST_START + 1, TASK_GROUP(3), StageBGMManager);

            StageBGMManager *work    = TaskGetWork(sBGMManagerTaskSingleton, StageBGMManager);
            work->usingUnderwaterBGM = isInWater;
        }
    }
}

void ChangeBossBGMVariant(BOOL pinchTrack)
{
    if (IsBossStage())
    {
        if (pinchTrack)
        {
            StopStageSfx(&gBGMHandle);
            PlayTrack(&sPinchBGMHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO,
                      sTrackForStage[gameState.stageID].trackID[gameState.characterID[0]][1]);
        }
        else
        {
            StopStageSfx(&sPinchBGMHandle);
            PlayTrack(&gBGMHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO,
                      sTrackForStage[gameState.stageID].trackID[gameState.characterID[0]][0]);
        }
    }
}

void FadeStageBGMToTargetVolume(s32 volume, s32 duration, BOOL isInWater)
{
    if (volume != 0)
    {
        s32 targetVolume = (volume * GetMusicVolume()) >> 7;
        if (isInWater)
        {
            NNS_SndPlayerMoveVolume(&sPinchBGMHandle, targetVolume, duration);
            NNS_SndPlayerSetChannelPriority(&gBGMHandle, 0);
            NNS_SndPlayerSetChannelPriority(&sPinchBGMHandle, 64);
        }
        else
        {
            NNS_SndPlayerMoveVolume(&gBGMHandle, targetVolume, duration);
            NNS_SndPlayerSetChannelPriority(&gBGMHandle, 64);
            NNS_SndPlayerSetChannelPriority(&sPinchBGMHandle, 0);
        }
    }
    else
    {
        NNS_SndPlayerMoveVolume(&gBGMHandle, volume, duration);
        NNS_SndPlayerMoveVolume(&sPinchBGMHandle, volume, duration);
    }
}

void CreateManagedSfx(s32 seqArcNo, s32 soundID, ManagedSfxFlags flags, StageTask *parent, s32 duration, s32 delay)
{
    Task *task = TaskCreate(ManagedSfx_Main, ManagedSfx_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1A00, TASK_GROUP(3), ManagedSfx);

    ManagedSfx *work = TaskGetWork(task, ManagedSfx);
    TaskInitWork16(work);

    work->sndHandle    = AllocSndHandle();
    work->parent       = parent;
    work->flags        = flags;
    work->seqArcNo     = seqArcNo;
    work->soundID      = soundID;
    work->playDuration = duration;

    if ((flags & MANAGEDSFX_FLAG_HAS_DELAY) != 0)
        work->playDelay = delay;

    if ((flags & MANAGEDSFX_FLAG_HAS_DELAY) == 0 && work->sndHandle != NULL)
    {
        PlaySfxEx(work->sndHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, soundID);

        if ((flags & MANAGEDSFX_FLAG_HAS_PARENT) != 0 && parent != NULL)
            ProcessSpatialSfx(work->sndHandle, &parent->position);
    }
}

void StageBGMManager_Main(void)
{
    StageBGMManager *work = TaskGetWorkCurrent(StageBGMManager);

    if (HandleStageBGMVariantChange(work->usingUnderwaterBGM))
        DestroyCurrentTask();
}

void StageBGMManager_Destructor(Task *task)
{
    if (sBGMManagerTaskSingleton == task)
        sBGMManagerTaskSingleton = NULL;
}

BOOL HandleStageBGMVariantChange(BOOL isInWater)
{
#define GetOffset(type, member) ((u32)(&((type *)0)->member))
#define GetSize(type, member)   (sizeof(((type *)0)->member))

    s32 t;

    ZoneID zoneID = GetCurrentZoneID();

    if (gBGMHandle.player == NULL)
        return FALSE;

    SNDPlayerInfo sndInfo;
    if (!NNS_SndPlayerReadDriverPlayerInfo(&gBGMHandle, &sndInfo) || sndInfo.activeFlag == FALSE)
        return FALSE;

    if (isInWater)
    {
        if (sStoredProgNoTable)
        {
            for (t = 0; t < SND_TRACK_NUM_PER_PLAYER; t++)
            {
                if ((sndInfo.trackBitMask & (1 << t)) != 0)
                    SNDi_SetTrackParam(gBGMHandle.player->playerNo, 1 << t, GetOffset(SNDTrack, prgNo), sBGMTrackProgNo[t] + 20, GetSize(SNDTrack, prgNo));
            }
        }
        else
        {
            SNDTrackInfo trackInfo;
            for (t = 0; t < SND_TRACK_NUM_PER_PLAYER; t++)
            {
                if ((sndInfo.trackBitMask & (1 << t)) != 0 && NNS_SndPlayerReadDriverTrackInfo(&gBGMHandle, t, &trackInfo))
                {
                    sBGMTrackProgNo[t] = trackInfo.prgNo;
                    SNDi_SetTrackParam(gBGMHandle.player->playerNo, 1 << t, GetOffset(SNDTrack, prgNo), trackInfo.prgNo + 20, GetSize(SNDTrack, prgNo));
                }
            }

            sStoredProgNoTable = TRUE;
        }

        if (zoneID == ZONE_PLANT_KINGDOM)
        {
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & (1 << 0), 99);
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & ~(1 << 0), 79);
        }
        else if (zoneID == ZONE_CORAL_CAVE)
        {
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & (1 << 0), 45);
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & ~(1 << 0), 90);
        }
        else
        {
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & ((1 << 0) | (1 << 1) | (1 << 2)), 45);
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & ~((1 << 0) | (1 << 1) | (1 << 2)), 90);
        }
    }
    else
    {
        for (t = 0; t < SND_TRACK_NUM_PER_PLAYER; t++)
        {
            if ((sndInfo.trackBitMask & (1 << t)) != 0)
                SNDi_SetTrackParam(gBGMHandle.player->playerNo, 1 << t, 2, sBGMTrackProgNo[t], 2);
        }

        if (zoneID == ZONE_CORAL_CAVE)
        {
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & ((1 << 1) | (1 << 2)), 50);
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask & ~((1 << 1) | (1 << 2)), 0);
        }
        else
        {
            NNS_SndPlayerSetTrackModDepth(&gBGMHandle, sndInfo.trackBitMask, 0x00);
        }
    }

    usingUnderwaterBGM = isInWater;

    return TRUE;
}

void ManagedSfx_Destructor(Task *task)
{
    ManagedSfx *work = TaskGetWork(task, ManagedSfx);

    if (work->sndHandle != NULL)
    {
        if ((work->flags & MANAGEDSFX_FLAG_HAS_DURATION) != 0)
            StopStageSfx(work->sndHandle);

        ReleaseStageSfx(work->sndHandle);

        FreeSndHandle(work->sndHandle);
    }
}

void ManagedSfx_Main(void)
{
    ManagedSfx *work = TaskGetWorkCurrent(ManagedSfx);

    StageTask *parent = work->parent;
    BOOL finished     = FALSE;
    if (parent != NULL)
    {
        if ((work->flags & MANAGEDSFX_FLAG_DESTROY_WITH_PARENT) != 0 && IsStageTaskDestroyedAny(parent))
        {
            if ((work->flags & MANAGEDSFX_FLAG_HAS_DURATION) == 0)
                StopStageSfx(work->sndHandle);

            DestroyCurrentTask();
            return;
        }
    }

    if ((work->flags & MANAGEDSFX_FLAG_HAS_DELAY) != 0)
    {
        work->playDelay--;
        if (work->playDelay > 0)
            return;

        PlaySfxEx(work->sndHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, work->seqArcNo, work->soundID);

        work->flags &= ~MANAGEDSFX_FLAG_HAS_DELAY;
        if ((work->flags & MANAGEDSFX_FLAG_HAS_DURATION) == 0)
            finished = TRUE;
    }

    if ((work->flags & MANAGEDSFX_FLAG_HAS_PARENT) != 0 && work->parent != NULL)
    {
        if (IsStageTaskDestroyedAny(work->parent))
        {
            work->flags &= ~MANAGEDSFX_FLAG_HAS_PARENT;
            work->parent = NULL;
        }
        else
        {
            ProcessSpatialSfx(work->sndHandle, &work->parent->position);
        }
    }

    if ((work->flags & MANAGEDSFX_FLAG_HAS_DURATION) != 0)
    {
        work->playDuration--;
        if (work->playDuration <= 0)
            finished = TRUE;
    }

    if (finished)
    {
        DestroyCurrentTask();
        return;
    }
}
