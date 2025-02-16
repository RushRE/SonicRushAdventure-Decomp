#ifndef RUSH_HUBCONTROL_HPP
#define RUSH_HUBCONTROL_HPP

#include <hub/hubTask.hpp>
#include <hub/dockCommon.h>
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
    HUBEVENT_MOVIELIST_CUTSCENE,
    HUBEVENT_STORY_CUTSCENE,
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
    u32 referenceTime;
    DockArea dockArea;
    DockArea previewDockArea;
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
    BOOL constructionFadeOutDone;
    s16 constructionViewPercent;
    s32 mapIconArea;
    BOOL startWithJetConstructedCutscene;
    BOOL disableAreaExit;
    u32 timer;
    BOOL startWithOptionsTalk;
    BOOL startWithMovieListTalk;
    BOOL startWithMissionListTalk;
    BOOL startWithGameOverTalk;
    BOOL isStageGameOver;
    u16 cutsceneID;
    u16 bgmVolume;
    u16 previewMapArea;
    u16 npcCount;
    u16 tutorialAreaPreviewScrollPos;
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

    static void CreateForMap(MapArea mapArea);
    static void CreateForDock(s32 dockArea, BOOL loadCharacterStates, BOOL disableAreaExit);
    static void SetMapIconArea(MapArea mapArea);
    static void Main_InitMap();
    static void Main_MapIdle();
    static void Main_LookAroundActive();
    static void Main_FadeOutForDockInit();
    static void Main_InitDock();
    static void Main_InitDockPlayerControl();
    static void Main_ProcessDock();
    static void Main_FadeOutForDockChange();
    static void Main_WaitForDockChanged();
    static void Main_FadeOutForExitDockArea();
    static void Main_FadeOutForEventChange();
    static void Main_InitForcedMapAreaChange();
    static void Main_WaitForForcedMapAreaChange();
    static void Main_FinishForcedMapAreaChange();
    static void Main_FadeOutForStoryEvent();
    static void Destructor(Task *task);
    static void Main_FadeOutForConstructionCutscene();
    static void Main_StartConstructionCutscene();
    static void Main_ConstructionCutscene_MaterialSpin();
    static void Main_ConstructionCutscene_FadeOutForShowShip();
    static void Main_ConstructionCutscene_FadeOutForShowDecoration();
    static void Main_ConstructionCutscene_ShowShip();
    static void Main_ConstructionCutscene_FadeOutForCutsceneEnd();
    static void Main_ConstructionCutscene_FadeInForConstructionDone();
    static void StartHubCutscene(s16 cutscene, s32 dockArea);
    static void StartHubEggmanAppearsCutscene();
    static BOOL CheckEventHasBGMChange(s32 event);
    static void StartSailing(DockArea dockArea, BOOL isTraining);
    static void IncrementGameProgress();
    static void ChangeEvent(s32 eventID, s32 selection);

    static void InitForNoState();
    static void HandleGameOverStartEvent(s32 startAction);
    static void InitForClearedTraining(BOOL loadCharacterStates);
    static void InitForFirstVoyage(BOOL loadCharacterStates);
    static void InitForNewSave();
    static void InitForUnfinishedTutorial();
    static void DisableTouchInteractions();
    static BOOL TouchEnabled();
    static void *GetSpriteFile(u16 id);
    static void *GetLocalizedSpriteFile(u16 id);
    static void *GetBackgroundFile(u16 id);
    static void *GetMsgSequenceArchive();
    static void *GetMsgControlArchive();
    static FontWindow *GetFontWindow();
    static void *GetCharacterNameSprite();
    static void InitMainMemoryPriorityForHub();
    static void ResetMainMemoryPriorityFromHub();

    static void Main_DoTalkAction();
    static void Main_PrepareCutsceneStart();

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
    static void InitEngineBForShipConstructionCutscene();
    static void Func_215B168();
    static void Func_215B250();
    static void Func_215B3B4();
    static void InitVRAMSystem();
    static void UpdateSaveProgressForShipConstructed(s32 shipType, BOOL unknown);
    static BOOL CheckShipConstructed(s32 shipType);
    static s32 GetNextShipToBuild();
    static BOOL CheckMapIconEnabled(MapArea mapArea);
    static void UpdateSaveForDecorConstruction(s32 a1, s32 a2);
    static BOOL CheckDecorConstructed(s32 id);
    static BOOL CanSpawnNpcType(s32 npcType);
    static BOOL CanSpawnNpc(s32 npcType);
    static void InitCutsceneForMovieList(u16 id);
    static void InitCutsceneForStory(u16 id);
    static void InitTutorial();
    static s32 GetNextShipUpgrade();
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
