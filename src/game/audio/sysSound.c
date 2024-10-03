#include <game/audio/sysSound.h>
#include <game/audio/audioSystem.h>
#include <game/system/allocator.h>
#include <game/save/saveGame.h>

// --------------------
// CONSTANTS
// --------------------

#define SYSSOUND_ID_NONE 0xFFFF

// --------------------
// STRUCTS
// --------------------

struct SysSoundManager
{
    SysSoundGroupID id;
    NNSSndHandle *trackHandle;
    NNSSndHandle *sfxHandle;
    NNSSndHandle *voiceHandle;
    NNSSndStrmHandle strmHandle;
    u16 seqNo;
    u16 curStreamNo;
};

struct MenuNavSfx
{
    u16 seqNo[3];
};

// --------------------
// VARIABLES
// --------------------

struct SysSoundManager *sysSoundManager;

static const u16 seqArcForSysGroup[SYSSOUND_GROUP_COUNT] = {
    [SYSSOUND_GROUP_DL_PLAY]    = SND_SYS_SEQARC_ARC_DL_PLAY,    // Download Play
    [SYSSOUND_GROUP_TITLE_1]    = SND_SYS_SEQARC_ARC_TITLE,      // Title (1)
    [SYSSOUND_GROUP_TITLE_2]    = SND_SYS_SEQARC_ARC_TITLE,      // Title (2)
    [SYSSOUND_GROUP_VILLAGE1_0] = SND_SYS_SEQARC_ARC_VILLAGE,    // Village 1-1 (Before completing tutorial)
    [SYSSOUND_GROUP_VILLAGE1_1] = SND_SYS_SEQARC_ARC_VILLAGE,    // Village 1-1
    [SYSSOUND_GROUP_VILLAGE1_2] = SND_SYS_SEQARC_ARC_VILLAGE,    // Village 1-2
    [SYSSOUND_GROUP_VILLAGE2_1] = SND_SYS_SEQARC_ARC_VILLAGE,    // Village 2-1
    [SYSSOUND_GROUP_VILLAGE2_2] = SND_SYS_SEQARC_ARC_VILLAGE,    // Village 2-1
    [SYSSOUND_GROUP_VILLAGE3]   = SND_SYS_SEQARC_ARC_VILLAGE,    // Village 3
    [SYSSOUND_GROUP_DOCK]       = SYSSOUND_ID_NONE,              // Dock
    [SYSSOUND_GROUP_POWERUP]    = SYSSOUND_ID_NONE,              // Power-up ship
    [SYSSOUND_GROUP_CHART]      = SYSSOUND_ID_NONE,              // Sea Map
    [SYSSOUND_GROUP_CLEAR]      = SND_SYS_SEQARC_ARC_CLEAR,      // Stage Clear
    [SYSSOUND_GROUP_CLEAR_B]    = SND_SYS_SEQARC_ARC_CLEAR_B,    // Stage Clear (Boss)
    [SYSSOUND_GROUP_CLEAR_F]    = SND_SYS_SEQARC_ARC_CLEAR_F,    // Stage Clear (Final Boss)
    [SYSSOUND_GROUP_CLEAR_E]    = SND_SYS_SEQARC_ARC_CLEAR_E,    // Stage Clear (Extra Boss)
    [SYSSOUND_GROUP_TA_CLEAR]   = SND_SYS_SEQARC_ARC_TA_CLEAR,   // Stage Clear (Time Attack)
    [SYSSOUND_GROUP_TA_CLEAR_B] = SND_SYS_SEQARC_ARC_TA_CLEAR_B, // Stage Clear (Time Attack, Boss)
    [SYSSOUND_GROUP_CONVER_NOR] = SND_SYS_SEQARC_ARC_CONV_NOR,   // Conversation (Normal)
    [SYSSOUND_GROUP_CONVER_TEN] = SND_SYS_SEQARC_ARC_CONV_TEN,   // Conversation (Tense)
    [SYSSOUND_GROUP_CONVER_PIR] = SND_SYS_SEQARC_ARC_CONV_PIR,   // Conversation (Pirates)
    [SYSSOUND_GROUP_CONVER_FIN] = SND_SYS_SEQARC_ARC_CONV_FIN,   // Conversation (Finale)
    [SYSSOUND_GROUP_CONVER_ANX] = SND_SYS_SEQARC_ARC_CONV_ANX,   // Conversation (Anxious)
    [SYSSOUND_GROUP_CONVER_UND] = SND_SYS_SEQARC_ARC_CONV_UND,   // Conversation (Extra Boss)
    [SYSSOUND_GROUP_OPENING]    = SND_SYS_SEQARC_ARC_OPENING,    // Opening
    [SYSSOUND_GROUP_MYSTERY]    = SND_SYS_SEQARC_ARC_MYSTERY,    // Mystery
    [SYSSOUND_GROUP_STAFF]      = SND_SYS_SEQARC_ARC_STAFF,      // Credits
    [SYSSOUND_GROUP_EMERALD]    = SND_SYS_SEQARC_ARC_EMERALD     // Emerald Collected
};

static const u16 sndGroupForSysGroup[SYSSOUND_GROUP_COUNT] = {
    [SYSSOUND_GROUP_DL_PLAY]    = SND_SYS_GROUP_DL_PLAY,    // Download Play
    [SYSSOUND_GROUP_TITLE_1]    = SND_SYS_GROUP_TITLE,      // Title (1)
    [SYSSOUND_GROUP_TITLE_2]    = SND_SYS_GROUP_TITLE,      // Title (2)
    [SYSSOUND_GROUP_VILLAGE1_0] = SND_SYS_GROUP_VILLAGE1_1, // Village 1-1 (Before completing tutorial)
    [SYSSOUND_GROUP_VILLAGE1_1] = SND_SYS_GROUP_VILLAGE1_1, // Village 1-1
    [SYSSOUND_GROUP_VILLAGE1_2] = SND_SYS_GROUP_VILLAGE1_2, // Village 1-2
    [SYSSOUND_GROUP_VILLAGE2_1] = SND_SYS_GROUP_VILLAGE2_1, // Village 2-1
    [SYSSOUND_GROUP_VILLAGE2_2] = SND_SYS_GROUP_VILLAGE2_2, // Village 2-1
    [SYSSOUND_GROUP_VILLAGE3]   = SND_SYS_GROUP_VILLAGE3,   // Village 3
    [SYSSOUND_GROUP_DOCK]       = SND_SYS_GROUP_DOCK,       // Dock
    [SYSSOUND_GROUP_POWERUP]    = SND_SYS_GROUP_POWERUP,    // Power-up ship
    [SYSSOUND_GROUP_CHART]      = SND_SYS_GROUP_CHART,      // Sea Map
    [SYSSOUND_GROUP_CLEAR]      = SND_SYS_GROUP_CLEAR,      // Stage Clear
    [SYSSOUND_GROUP_CLEAR_B]    = SND_SYS_GROUP_CLEAR_B,    // Stage Clear (Boss)
    [SYSSOUND_GROUP_CLEAR_F]    = SND_SYS_GROUP_CLEAR_F,    // Stage Clear (Final Boss)
    [SYSSOUND_GROUP_CLEAR_E]    = SND_SYS_GROUP_CLEAR_E,    // Stage Clear (Extra Boss)
    [SYSSOUND_GROUP_TA_CLEAR]   = SND_SYS_GROUP_TA_CLEAR,   // Stage Clear (Time Attack)
    [SYSSOUND_GROUP_TA_CLEAR_B] = SND_SYS_GROUP_TA_CLEAR_B, // Stage Clear (Time Attack, Boss)
    [SYSSOUND_GROUP_CONVER_NOR] = SND_SYS_GROUP_CONVER_NOR, // Conversation (Normal)
    [SYSSOUND_GROUP_CONVER_TEN] = SND_SYS_GROUP_CONVER_TEN, // Conversation (Tense)
    [SYSSOUND_GROUP_CONVER_PIR] = SND_SYS_GROUP_CONVER_PIR, // Conversation (Pirates)
    [SYSSOUND_GROUP_CONVER_FIN] = SND_SYS_GROUP_CONVER_FIN, // Conversation (Finale)
    [SYSSOUND_GROUP_CONVER_ANX] = SND_SYS_GROUP_CONVER_ANX, // Conversation (Anxious)
    [SYSSOUND_GROUP_CONVER_UND] = SND_SYS_GROUP_CONVER_UND, // Conversation (Extra Boss)
    [SYSSOUND_GROUP_OPENING]    = SND_SYS_GROUP_OPENING,    // Opening
    [SYSSOUND_GROUP_MYSTERY]    = SND_SYS_GROUP_MYSTERY,    // Mystery
    [SYSSOUND_GROUP_STAFF]      = SND_SYS_GROUP_STAFF,      // Credits
    [SYSSOUND_GROUP_EMERALD]    = SND_SYS_GROUP_EMERALD     // Emerald Collected
};

static const struct MenuNavSfx menuNavSfx[SYSSOUND_GROUP_COUNT] = {
    [SYSSOUND_GROUP_DL_PLAY] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_DL_PLAY_SEQ_SE_D_DECIDE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_DL_PLAY_SEQ_SE_D_CANCELL,
                                   [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_DL_PLAY_SEQ_SE_D_CURSOL } }, // Download Play

    [SYSSOUND_GROUP_TITLE_1] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_TITLE_SEQ_SE_T_DECIDE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Title (1)

    [SYSSOUND_GROUP_TITLE_2] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_TITLE_SEQ_SE_T_DECIDE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Title (2)

    [SYSSOUND_GROUP_VILLAGE1_0] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL } }, // Village 1-1 (Before completing tutorial)

    [SYSSOUND_GROUP_VILLAGE1_1] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL } }, // Village 1-1

    [SYSSOUND_GROUP_VILLAGE1_2] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL } }, // Village 1-2

    [SYSSOUND_GROUP_VILLAGE2_1] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL } }, // Village 2-1

    [SYSSOUND_GROUP_VILLAGE2_2] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL } }, // Village 2-1

    [SYSSOUND_GROUP_VILLAGE3] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
                                    [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL,
                                    [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL } }, // Village 3

    [SYSSOUND_GROUP_DOCK] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Dock

    [SYSSOUND_GROUP_POWERUP] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Power-up ship

    [SYSSOUND_GROUP_CHART] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                 [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                 [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Sea Map

    [SYSSOUND_GROUP_CLEAR] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                 [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                 [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Stage Clear

    [SYSSOUND_GROUP_CLEAR_B] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Stage Clear (Boss)

    [SYSSOUND_GROUP_CLEAR_F] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Stage Clear (Final Boss)

    [SYSSOUND_GROUP_CLEAR_E] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Stage Clear (Extra Boss)

    [SYSSOUND_GROUP_TA_CLEAR] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_TA_CLEAR_SEQ_SE_TN_DECIDE,
                                    [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                    [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_TA_CLEAR_SEQ_SE_TN_CURSOL } }, // Stage Clear (Time Attack)

    [SYSSOUND_GROUP_TA_CLEAR_B] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_TA_CLEAR_B_SEQ_SE_TB_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_TA_CLEAR_B_SEQ_SE_TB_CURSOL } }, // Stage Clear (Time Attack, Boss)

    [SYSSOUND_GROUP_CONVER_NOR] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Conversation (Normal)

    [SYSSOUND_GROUP_CONVER_TEN] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Conversation (Tense)

    [SYSSOUND_GROUP_CONVER_PIR] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Conversation (Pirates)

    [SYSSOUND_GROUP_CONVER_FIN] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_CONV_FIN_SEQ_SE_CF_DECIDE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_CONV_FIN_SEQ_SE_CF_CANCELL,
                                      [SYSSOUND_MENUNAV_CURSOR] = SND_SYS_SEQARC_ARC_CONV_FIN_SEQ_SE_CF_CURSOL } }, // Conversation (Finale)

    [SYSSOUND_GROUP_CONVER_ANX] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Conversation (Anxious)

    [SYSSOUND_GROUP_CONVER_UND] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                      [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Conversation (Extra Boss)

    [SYSSOUND_GROUP_OPENING] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Opening

    [SYSSOUND_GROUP_MYSTERY] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_M_DECIDE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_M_CANCELL,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Mystery

    [SYSSOUND_GROUP_STAFF] = { { [SYSSOUND_MENUNAV_DECIDE] = SND_SYS_SEQARC_ARC_STAFF_SEQ_SE_SR_DECIDE,
                                 [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                 [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Credits

    [SYSSOUND_GROUP_EMERALD] = { { [SYSSOUND_MENUNAV_DECIDE] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CANCEL] = SYSSOUND_ID_NONE,
                                   [SYSSOUND_MENUNAV_CURSOR] = SYSSOUND_ID_NONE } }, // Emerald Collected
};

// --------------------
// FUNCTIONS
// --------------------

// Admin
void ExitSysSound(void)
{
    sysSoundManager = NULL;
}

void LoadSysSound(SysSoundGroupID id)
{
    if (id == GetCurrentSysSoundGroup())
        return;

    ReleaseSysSound();
    sysSoundManager = HeapAllocHead(HEAP_SYSTEM, sizeof(struct SysSoundManager));

    sysSoundManager->id          = id;
    sysSoundManager->trackHandle = AllocSndHandle();
    sysSoundManager->sfxHandle   = AllocSndHandle();
    sysSoundManager->voiceHandle = AllocSndHandle();
    sysSoundManager->seqNo       = SYSSOUND_ID_NONE;
    sysSoundManager->curStreamNo = SYSSOUND_ID_NONE;

    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcStrmInit(10, audioManagerSndHeap);
    NNS_SndStrmHandleInit(&sysSoundManager->strmHandle);
    NNS_SndArcLoadGroup(sndGroupForSysGroup[id], audioManagerSndHeap);
}

void LoadSysSoundVillage(void)
{
    s32 id;
    if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_26)
    {
        id = SYSSOUND_GROUP_VILLAGE3;
    }
    else if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_22)
    {
        id = SYSSOUND_GROUP_VILLAGE2_2;
    }
    else if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_9)
    {
        id = SYSSOUND_GROUP_VILLAGE2_1;
    }
    else if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_2 || (SaveGame__GetGameProgress() >= SAVE_PROGRESS_1 && SaveGame__Func_205BB18() >= 1))
    {
        id = SYSSOUND_GROUP_VILLAGE1_2;
    }
    else
    {
        id = SYSSOUND_GROUP_VILLAGE1_1;
    }

    LoadSysSound(id);
}

void ReleaseSysSound(void)
{
    if (sysSoundManager != NULL)
    {
        StopSysTrack();
        StopSysSfx();
        StopSysVoice();
        StopSysStream();
        NNS_SndStopSoundAll();

        FreeSndHandle(sysSoundManager->trackHandle);
        sysSoundManager->trackHandle = NULL;

        FreeSndHandle(sysSoundManager->sfxHandle);
        sysSoundManager->sfxHandle = NULL;

        FreeSndHandle(sysSoundManager->voiceHandle);
        sysSoundManager->voiceHandle = NULL;

        HeapFree(HEAP_SYSTEM, sysSoundManager);
        sysSoundManager = NULL;
    }
    else
    {
        NNS_SndStopSoundAll();
    }

    ReleaseAudioSystem();
}

s32 GetCurrentSysSoundGroup(void)
{
    if (sysSoundManager == NULL)
        return SYSSOUND_GROUP_COUNT + 1;

    return sysSoundManager->id;
}

// Tracks
void PlaySysTrack(s32 seqNo, BOOL alwaysPlay)
{
    if (sysSoundManager == NULL)
        return;

    if (alwaysPlay || sysSoundManager->seqNo != seqNo)
    {
        StopSysTrack();
        NNS_SndArcLoadSeq(seqNo, audioManagerSndHeap);
        PlayTrack(sysSoundManager->trackHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqNo);

        sysSoundManager->seqNo = seqNo;
    }
}

void PlaySysVillageTrack(BOOL alwaysPlay)
{
    if (sysSoundManager == NULL)
        return;

    s32 seqNo;
    switch (sysSoundManager->id)
    {
        case 4:
            seqNo = SND_SYS_SEQ_SEQ_VILLAGE1_1;
            break;

        case 5:
            seqNo = SND_SYS_SEQ_SEQ_VILLAGE1_2;
            break;

        case 6:
            seqNo = SND_SYS_SEQ_SEQ_VILLAGE2_1;
            break;

        case 7:
            seqNo = SND_SYS_SEQ_SEQ_VILLAGE2_2;
            break;

        case 8:
            seqNo = SND_SYS_SEQ_SEQ_VILLAGE3;
            break;

        default:
            return;
    }

    PlaySysTrack(seqNo, alwaysPlay);
}

void StopSysTrack(void)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->trackHandle->player != NULL)
    {
        StopStageSfx(sysSoundManager->trackHandle);
        ReleaseStageSfx(sysSoundManager->trackHandle);
    }

    sysSoundManager->seqNo = SYSSOUND_ID_NONE;
}

void FadeSysTrack(s32 fadeFrame)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->trackHandle->player != NULL)
    {
        FadeOutStageSfx(sysSoundManager->trackHandle, fadeFrame);
    }

    sysSoundManager->seqNo = SYSSOUND_ID_NONE;
}

void SetSysTrackVolume(u8 volume)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->trackHandle == NULL)
        return;

    NNS_SndPlayerSetVolume(sysSoundManager->trackHandle, volume);
}

// Sfx/Voices
void PlaySysSfx(s32 seqNo)
{
    if (sysSoundManager == NULL)
        return;

    if (seqArcForSysGroup[sysSoundManager->id] == SYSSOUND_ID_NONE)
        return;

    PlaySfxEx(sysSoundManager->sfxHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcForSysGroup[sysSoundManager->id], seqNo);
}

void PlaySysMenuNavSfx(SysSoundMenuNavSeq id)
{
    if (sysSoundManager == NULL)
        return;

    s32 seqNo = menuNavSfx[sysSoundManager->id].seqNo[id];
    if (seqNo == SYSSOUND_ID_NONE)
        return;

    PlaySfxEx(sysSoundManager->sfxHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcForSysGroup[sysSoundManager->id], seqNo);
}

void StopSysSfx(void)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->sfxHandle->player == NULL)
        return;

    StopStageSfx(sysSoundManager->sfxHandle);
    ReleaseStageSfx(sysSoundManager->sfxHandle);
}

// Unknown
void StopSysVoice(void)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->voiceHandle->player == NULL)
        return;

    StopStageSfx(sysSoundManager->voiceHandle);
    ReleaseStageSfx(sysSoundManager->voiceHandle);
}

// Streams
void PlaySysStream(s32 strmNo, BOOL alwaysPlay)
{
    if (sysSoundManager == NULL)
        return;

    if (alwaysPlay || sysSoundManager->curStreamNo != strmNo)
    {
        StopSysStream();
        NNS_SndArcStrmStart(&sysSoundManager->strmHandle, strmNo, 0);
        sysSoundManager->curStreamNo = strmNo;
    }
}

void StopSysStream(void)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->strmHandle.player != NULL)
    {
        NNS_SndArcStrmStop(&sysSoundManager->strmHandle, 0);
        NNS_SndStrmHandleRelease(&sysSoundManager->strmHandle);
    }

    sysSoundManager->curStreamNo = SYSSOUND_ID_NONE;
}

void FadeSysStream(s32 fadeFrame)
{
    if (sysSoundManager == NULL)
        return;

    if (sysSoundManager->strmHandle.player != NULL)
    {
        NNS_SndArcStrmStop(&sysSoundManager->strmHandle, fadeFrame);
    }

    sysSoundManager->curStreamNo = SYSSOUND_ID_NONE;
}
