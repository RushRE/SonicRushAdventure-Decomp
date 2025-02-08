#include <hub/npcCutsceneViewer.hpp>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>
#include <hub/cviDock.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <hub/hubControl.hpp>
#include <game/cutscene/script.h>

// resources
#include <resources/bb/vi_msg/vi_msg_eng.h>
#include <resources/narc/vi_act_lz7.h>
#include <resources/bb/vi_act_loc/vi_act_loc_eng.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define NPCCUTSCENEVIEWER_UNLOCK_ALWAYS          0xFFFF
#define NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE 0xFFFE

// --------------------
// STRUCTS
// --------------------

struct CutsceneListEntry
{
    u16 cutsceneID;
    u16 id;
    u16 unlock;
};

// --------------------
// VARIABLES
// --------------------

static const u16 cutsceneTransitionList[5][2] = {
    { CUTSCENE_CORAL_CAVE_SURFACES_PART1, CUTSCENE_CORAL_CAVE_APPEARS },
    { CUTSCENE_CORAL_CAVE_APPEARS, CUTSCENE_CORAL_CAVE_SURFACES_PART2 },
    { CUTSCENE_HOVER_WHAT_HAUNTED_SHIP, CUTSCENE_HOVER_WHAT_BOAT },
    { CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ENTRANCE, CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_DOOR },
    { CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_DOOR, CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ARRIVAL },
};

static const CutsceneListEntry cutsceneListEntryConfig[] = {
    { CUTSCENE_OPENING, 0, NPCCUTSCENEVIEWER_UNLOCK_ALWAYS },
    { CUTSCENE_MARINE_APPEARS, 1, 6 },
    { CUTSCENE_ENCOUNTER, 2, 6 },
    { CUTSCENE_RICKETY_SHIP_LAUNCH, 3, 6 },
    { CUTSCENE_GET_THE_MATERIAL, 4, 6 },
    { CUTSCENE_FOUND_MATERIAL, 5, 6 },
    { CUTSCENE_WAVE_CYCLONE_COMPLETE, 6, 6 },
    { CUTSCENE_WAVE_CYCLONE_LAUNCH, 7, 6 },
    { CUTSCENE_ARRIVAL_AT_PLANT_KINGDOM, 8, 6 },
    { CUTSCENE_GHOST_REX_APPOACHES, 9, 6 },
    { CUTSCENE_FOUND_GREEN_MATERIAL, 10, 6 },
    { CUTSCENE_ARRIVAL_AT_MACHINE_LABYRINTH, 11, 16 },
    { CUTSCENE_IMPOSING_GHOST_PENDULUM, 12, 16 },
    { CUTSCENE_FOUND_BRONZE_MATERIAL, 13, 16 },
    { CUTSCENE_OCEAN_TORNADO_COMPLETE, 14, 16 },
    { CUTSCENE_OCEAN_TORNADO_LAUNCH, 15, 16 },
    { CUTSCENE_JOHNNY_APPEARS, 16, 16 },
    { CUTSCENE_CORAL_CAVE_SURFACES_PART1, 17, 16 },
    { CUTSCENE_ARRIVAL_AT_CORAL_CAVE, 18, 16 },
    { CUTSCENE_WHISKER_APPEARS_3D, 19, 16 },
    { CUTSCENE_REUNION_3D, 20, 16 },
    { CUTSCENE_THIS_IS_BLAZES_WORLD, 21, 16 },
    { CUTSCENE_BUILDING_A_RADIO_TOWER, 22, 16 },
    { CUTSCENE_STRANGE_ELECTROMAGNETIC_SIGNAL, 23, 16 },
    { CUTSCENE_KYLOK_ISLAND_EMPTY, 24, 16 },
    { CUTSCENE_KYLOK_FOUND, 25, 16 },
    { CUTSCENE_ARRIVAL_AT_HAUNTED_SHIP, 26, 26 },
    { CUTSCENE_HAIR_RAISING_GHOST_PIRATE, 27, 26 },
    { CUTSCENE_HOVER_WHAT_HAUNTED_SHIP, 28, 26 },
    { CUTSCENE_AQUA_BLAST_COMPLETE, 29, 26 },
    { CUTSCENE_AQUA_BLAST_LAUNCH, 30, 26 },
    { CUTSCENE_ARRIVAL_AT_BLIZZARD_PEAKS, 31, 26 },
    { CUTSCENE_FREEZING_GHOST_WHALE, 32, 26 },
    { CUTSCENE_LEGENDARY_ANCIENT_RUINS_1, 33, 26 },
    { CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_1, 34, 26 },
    { CUTSCENE_DAIKUN_DISCOVERED, 35, 26 },
    { CUTSCENE_DAIKUN_ISLAND_EMPTY, 36, 26 },
    { CUTSCENE_TO_SKY_BABYLON, 37, 26 },
    { CUTSCENE_ARRIVAL_AT_SKY_BABYLON, 38, 26 },
    { CUTSCENE_LEGENDARY_ANCIENT_RUINS_2, 39, 26 },
    { CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_2, 40, 26 },
    { CUTSCENE_EARTHQUAKE, 41, 36 },
    { CUTSCENE_DEEP_TYPHOON_COMPLETE, 42, 36 },
    { CUTSCENE_DEEP_TYPHOON_LAUNCH, 43, 36 },
    { CUTSCENE_PIRATES_ISLAND_DISCOVERED, 44, 36 },
    { CUTSCENE_MYSTERIOUS_MARKER_NO_1, 45, 36 },
    { CUTSCENE_MYSTERIOUS_MARKER_NO_2, 46, 36 },
    { CUTSCENE_CLUE_NO_1, 47, 36 },
    { CUTSCENE_CLUE_NO_2, 48, 36 },
    { CUTSCENE_CLUE_NO_3, 49, 36 },
    { CUTSCENE_COLLECTED_THE_CLUES, 50, 36 },
    { CUTSCENE_CRUEL_TO_BE_KIND, 51, 36 },
    { CUTSCENE_INVADING_PIRATES_ISLAND, 52, 36 },
    { CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ENTRANCE, 53, 36 },
    { CUTSCENE_CLASH_WITH_WHISKER_AND_JOHNNY, 54, 36 },
    { CUTSCENE_AFTER_THEM, 55, 47 },
    { CUTSCENE_ARRIVAL_AT_BIG_SWELL, 56, 47 },
    { CUTSCENE_DUEL_WITH_GHOST_TITAN, 57, 47 },
    { CUTSCENE_GHOST_TITANS_IMPACT, 58, 47 },
    { CUTSCENE_ENDING, 59, 47 },
    { CUTSCENE_EX_PROLOGUE, 60, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_EGGMANS_DOUBLE_APPEARANCE_3D, 61, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_MAGMA_HURRICANE_COMPLETE, 62, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_MAGMA_HURRICANE_LAUNCH, 63, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_EGGMANS_THE_SOURCE_OF_POWER_3D, 64, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_SONIC_AND_BLAZE_TRANSFORM, 65, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_FINAL_BATTLE_EGG_WIZARD, 66, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_EGG_WIZARD_DESTROYED, 67, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_EX_ENDING, 68, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
    { CUTSCENE_WE_WILL_MEET_AGAIN, 69, NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE },
};

// --------------------
// FUNCTIONS
// --------------------

void NpcCutsceneViewer::Create(s32 param)
{
    Task *task =
        HubTaskCreate(NpcCutsceneViewer::Main_Init, NpcCutsceneViewer::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), NpcCutsceneViewer);

    NpcCutsceneViewer *work = TaskGetWork(task, NpcCutsceneViewer);

    InitThreadWorker(&work->thread, 0x800);
    CreateThreadWorker(&work->thread, NpcCutsceneViewer::ThreadFunc, work, 20);
}

u16 NpcCutsceneViewer::GetNextCutscene(u16 id)
{
    for (s32 i = 0; i < 5; i++)
    {
        if (id == cutsceneTransitionList[i][0])
            return cutsceneTransitionList[i][1];
    }

    return CUTSCENE_NONE;
}

void NpcCutsceneViewer::ThreadFunc(void *arg)
{
    NpcCutsceneViewer *work = (NpcCutsceneViewer *)arg;

    work->mpcFile       = FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsg(), ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DEMO_VIEWER_MPC);
    work->cutsceneCount = ARRAY_COUNT(cutsceneListEntryConfig);

    work->InitDisplay();
    work->InitList();
}

void NpcCutsceneViewer::InitDisplay()
{
    HubControl::Func_215A888();
}

void NpcCutsceneViewer::InitList()
{
    this->cutsceneList = (NpcTalkListEntry *)HeapAllocHead(HEAP_SYSTEM, 4 * this->cutsceneCount);

    for (s32 i = 0; i < this->cutsceneCount; i++)
    {
        NpcTalkListEntry *entry = &this->cutsceneList[i];

        entry->flags = 0;

        if (NpcCutsceneViewer::CheckCutsceneUnlocked(i))
        {
            entry->flags |= 1;
            entry->id = cutsceneListEntryConfig[i].id;
        }
        else
        {
            entry->id = ARRAY_COUNT(cutsceneListEntryConfig);
        }
    }

    ViTalkListConfig config;
    config.fontWindow      = HubControl::GetField54();
    config.mpcFile         = this->mpcFile;
    config.entryList       = this->cutsceneList;
    config.entryCount      = this->cutsceneCount;
    config.selection       = NpcCutsceneViewer::GetSelectionFromCutscene();
    config.field_22        = 2;
    config.vi_fix_loc      = HubControl::GetFileFrom_ViActLoc(ARCHIVE_VI_ACT_LOC_ENG_FILE_VI_FIX_LOC_BAC);
    config.vi_menu         = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_MENU_BAC);
    config.vi_ms_ret       = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_MS_RET_BAC);
    config.nl_cursor_ikari = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_NL_CURSOR_IKARI_BAC);
    config.headerAnim      = 6;
    config.windowSizeX     = 0;
    config.windowSizeY     = 5;
    config.field_28        = 3;

    NpcUnknown__Func_216EDCC(&this->npcTalk);
    NpcUnknown__Func_216EDF8(&this->npcTalk, &config);
}

void NpcCutsceneViewer::Release()
{
    ReleaseThreadWorker(&this->thread);

    this->ReleaseList();
    this->ResetDisplay();
}

void NpcCutsceneViewer::ResetDisplay()
{
    HubControl::Func_215A96C();
}

void NpcCutsceneViewer::ReleaseList()
{
    NpcUnknown__Func_216EE98(&this->npcTalk);

    if (this->cutsceneList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->cutsceneList);
        this->cutsceneList = NULL;
    }
}

void NpcCutsceneViewer::Main_Init()
{
    NpcCutsceneViewer *work = TaskGetWorkCurrent(NpcCutsceneViewer);

    if (IsThreadWorkerFinished(&work->thread))
    {
        NpcUnknown__Func_216EEC0(&work->npcTalk, gameState.talk.field_40, 1);
        gameState.talk.field_40 = 0;
        SetCurrentTaskMainEvent(NpcCutsceneViewer::Main_Active);
    }
}

void NpcCutsceneViewer::Main_Active()
{
    NpcCutsceneViewer *work = TaskGetWorkCurrent(NpcCutsceneViewer);

    NpcUnknown__Func_216EF50(&work->npcTalk);
    if (NpcUnknown__Func_216EF80(&work->npcTalk))
    {
        ViDock__Func_215E4BC(1);
        SetCurrentTaskMainEvent(NpcCutsceneViewer::Main_CloseWindow);
    }
    else if (NpcUnknown__Func_216EF78(&work->npcTalk))
    {
        ViDock__Func_215E4BC(0);
    }
}

void NpcCutsceneViewer::Main_CloseWindow()
{
    NpcCutsceneViewer *work = TaskGetWorkCurrent(NpcCutsceneViewer);

    NpcUnknown__Func_216EF50(&work->npcTalk);
    if (NpcUnknown__Func_216EFC0(&work->npcTalk))
    {
        s32 selection;
        if (NpcUnknown__Func_216EF88(&work->npcTalk))
        {
            selection               = cutsceneListEntryConfig[NpcUnknown__Func_216EFDC(&work->npcTalk)].cutsceneID;
            gameState.talk.field_40 = NpcUnknown__Func_216EFDC(&work->npcTalk);
        }
        else
        {
            selection               = 0xFFFF;
            gameState.talk.field_40 = 0;
        }

        DestroyCurrentTask();

        if (selection != 0xFFFF)
        {
            CViDockNpcTalk::SetTalkAction(20);
            CViDockNpcTalk::SetSelection(selection);
        }
        else
        {
            CViDockNpcTalk::SetTalkAction(0);
            CViDockNpcTalk::SetSelection(0);
        }
    }
}

void NpcCutsceneViewer::Destructor(Task *task)
{
    NpcCutsceneViewer *work = TaskGetWork(task, NpcCutsceneViewer);

    work->Release();

    HubTaskDestroy<NpcCutsceneViewer>(task);
}

BOOL NpcCutsceneViewer::CheckCutsceneUnlocked(u16 id)
{
    u16 unlock = cutsceneListEntryConfig[id].unlock;

    if (unlock == NPCCUTSCENEVIEWER_UNLOCK_ALWAYS)
        return TRUE;

    if (unlock == NPCCUTSCENEVIEWER_UNLOCK_AFTER_DEEP_CORE)
        return SaveGame__GetGameProgress() >= SAVE_PROGRESS_39;

    return SaveGame__GetMissionStatus(unlock) == MISSION_STATE_COMPLETED;
}

u16 NpcCutsceneViewer::GetSelectionFromCutscene()
{
    s32 i;

    u16 id = gameState.cutscene.cutsceneID;
    if (id == 0)
        return 0;

    for (i = 4; i >= 0; i--)
    {
        if (id == cutsceneTransitionList[i][1])
            id = cutsceneTransitionList[i][0];
    }

    for (i = 0; i < 70; i++)
    {
        if (id == cutsceneListEntryConfig[i].cutsceneID)
            return i;
    }

    return 0;
}