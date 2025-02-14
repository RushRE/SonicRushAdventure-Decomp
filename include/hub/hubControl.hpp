#ifndef RUSH_HUBCONTROL_HPP
#define RUSH_HUBCONTROL_HPP

#include <hub/hubTask.hpp>
#include <game/graphics/sprite.h>
#include <game/text/fontWindow.h>

// --------------------
// ENUMS
// --------------------

enum HubEventIDs
{
    HUBEVENT_UPDATE_PROGRESS,
    HUBEVENT_SAILING,
    HUBEVENT_MAIN_MENU,
    HUBEVENT_DELETE_SAVE_MENU,
    HUBEVENT_PLAYER_NAME_MENU,
    HUBEVENT_VS_MAIN_MENU,
    HUBEVENT_STAGE_SELECT,
    HUBEVENT_CUTSCENE_1,
    HUBEVENT_CUTSCENE_2,
    HUBEVENT_START_MISSION,
    HUBEVENT_START_TUTORIAL,
    HUBEVENT_SOUND_TEST,
    HUBEVENT_VIKING_CUP,
    HUBEVENT_LOAD_STAGE,
    HUBEVENT_CORRUPT_SAVE_WARNING,

    HUBEVENT_COUNT,
    HUBEVENT_INVALID,
};

// --------------------
// STRUCTS
// --------------------

typedef struct HubControlNpcSpawnCheck_
{
    u16 gameProgress;
    u16 canSpawn;
} HubControlNpcSpawnCheck;

#ifdef __cplusplus

class HubControl
{

    // --------------------
    // VARIABLES
    // --------------------

public:
    s32 flags;
    u32 genericTimer;
    u32 field_8;
    s32 dockArea;
    s32 field_10;
    s32 mapArea;
    s32 nextMapArea;
    s32 shipConstructID;
    s32 decorConstructID;
    s32 shipUpgradeID;
    s32 talkingNpc;
    u32 touchFlags;
    Task *hubAreaPreview;
    void *viActArchive;
    void *viActLocArchive;
    void *viBGArchive;
    void *viBGUpArchive;
    void *viMsgArchive;
    void *viMsgCtrlArchive;
    void *fontFile;
    void *tkdmNameSprite;
    FontWindow fontWindow;
    s32 nextEvent;
    s32 nextSelectionID;
    s32 field_10C;
    s16 field_110;
    s16 field_112;
    s32 mapIconArea;
    s32 field_118;
    s32 field_11C;
    u32 timer;
    s32 field_124;
    s32 field_128;
    s32 field_12C;
    s32 field_130;
    s32 field_134;
    u16 cutsceneID;
    u16 field_13A;
    u16 curAreaID;
    u16 npcCount;
    u16 field_140;
    s16 npcIconPos;
    AnimatorSprite aniNpcIcon[5];
    AnimatorSprite aniNpcBackground;
    AnimatorSprite aniOptionsIcon[2];
    AnimatorSprite aniOptionsName[3];

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Release();

    void LoadArchives();
    void ReleaseAssets();
    void SaveState(BOOL isMap);
    void ClearAnimators();
    void SetAreaSpritesForInit();
    void ReleaseAnimators();
    void ReleaseGraphics();
    BOOL ProcessHideNpcIcons();
    BOOL ProcessShowNpcIcons();
    void SetAreaSpritesForAreaChange(s32 area);
    void DrawNpcIcons();

    // TODO: make these member functions when all xrefs have been decompiled
    static void TryFadeOutBGM(HubControl *work);
    static void ProcessGenericTimer(HubControl *work);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void CreateForMap(s32 mapArea);
    static void CreateForDock(s32 dockArea, BOOL loadCharacterStates, s32 a3);
    static void SetMapIconArea(s32 mapArea);
    static void Main_InitMap();
    static void Main_21578CC();
    static void Main_2157A94();
    static void Main_2157C0C();
    static void Main_InitDock();
    static void Main_InitDockPlayerControl();
    static void Main_ProcessDock();
    static void Main_FadeOutForDockChange();
    static void Main_WaitForDockChanged();
    static void Main_FadeOutForExitDockArea();
    static void Main_FadeOutForEventChange();
    static void Main_21588D4();
    static void Main_2158918();
    static void Main_2158958();
    static void Main_2158A04();
    static void Destructor(Task *task);
    static void Func_2158D28();
    static void Func_2158E14();
    static void Func_2158F28();
    static void Func_2158F64();
    static void Func_2159084();
    static void Func_2159104();
    static void Func_21591A8();
    static void Func_21592E0();
    static void StartHubCutscene(s16 cutscene, s32 dockArea);
    static void StartHubCutsceneUnknown();
    static BOOL CheckEventHasBGMChange(s32 event);
    static void Func_215A2E0(s32 a1, s32 a2);
    static void IncrementGameProgress();
    static void ChangeEvent(s32 eventID, s32 selection);

    static void InitForNoState();
    static void Func_215701C(s32 a1);
    static void Func_21570B8(s32 a1);
    static void Func_215710C(BOOL a2);
    static void InitForNewSave();
    static void InitForUnfinishedTutorial();
    static void DisableTouchInteractions();
    static BOOL TouchEnabled();
    static void *GetFileFrom_ViAct(u16 id);
    static void *GetFileFrom_ViActLoc(u16 id);
    static void *GetFileFrom_ViBG(u16 id);
    static void *GetFileFrom_ViMsg();
    static void *GetFileFrom_ViMsgCtrl();
    static FontWindow *GetField54();
    static void *GetTKDMNameSprite();
    static void InitMainMemoryPriorityForHub();
    static void ResetMainMemoryPriorityFromHub();

    static void Main_DoTalkAction();
    static void Main_2158AB4();

    static void InitDisplay();
    static void InitEngineAForTalk();
    static void InitEngineAFor3DHub();
    static void InitEngineBForMissionList();
    static void InitEngineBForTalkPurchase();
    static void InitEngineBFor3DHub();
    static void InitEngineAForAreaSelect();
    static void InitEngineAForExitHub();
    static void InitEngineAForCutscene();
    static void InitEngineAForUnknown();
    static void Func_215B03C();
    static void Func_215B168();
    static void Func_215B250();
    static void Func_215B3B4();
    static void InitVRAMSystem();
    static void UpdateSaveProgressForShipConstructed(s32 shipType, BOOL unknown);
    static BOOL CheckShipConstructed(s32 shipType);
    static s32 GetNextShipToBuild();
    static BOOL Func_215B51C(s32 a1);
    static void UpdateSaveForDecorConstruction(s32 a1, s32 a2);
    static BOOL CheckDecorConstructed(s32 id);
    static BOOL CanSpawnNpcType(s32 npcType);
    static BOOL CanSpawnNpc(s32 npcType);
    static void Func_215B8FC(u16 id);
    static void Func_215B92C(u16 id);
    static void Func_215B958();
    static s32 Func_215B978();
    static s32 HandleFade(s16 targetA, s16 targetB, s16 fadeSpeed);
    static s32 HandleFadeA(s16 target, s16 fadeSpeed);
    static s32 HandleFadeB(s16 target, s16 fadeSpeed);
};

#else

// declare this struct for use in C code
typedef struct HubControl_
{
    u32 __private;
} HubControl;

#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void InitHubSysEvent(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_HUBCONTROL_HPP
