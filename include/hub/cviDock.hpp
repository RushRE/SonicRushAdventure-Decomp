#ifndef RUSH_CVIDOCK_HPP
#define RUSH_CVIDOCK_HPP

#include <global.h>

#ifdef __cplusplus

#include <hub/hubTask.hpp>
#include <hub/cviDockBack.hpp>
#include <hub/cviDockNpcGroup.hpp>
#include <hub/cvi3dObject.hpp>
#include <hub/cviDockNpc.hpp>
#include <hub/cviDockPlayer.hpp>
#include <hub/cviDockCamera.hpp>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

class CViDock
{
public:
    // --------------------
    // ENUMS
    // --------------------

    enum Area
    {
        AREA_BASE      = DOCKAREA_BASE,
        AREA_BASE_NEXT = DOCKAREA_BASE_NEXT,
        AREA_JET       = DOCKAREA_JET,
        AREA_BOAT      = DOCKAREA_BOAT,
        AREA_HOVER     = DOCKAREA_HOVER,
        AREA_SUBMARINE = DOCKAREA_SUBMARINE,
        AREA_BEACH     = DOCKAREA_BEACH,

        AREA_COUNT,
        AREA_INVALID,
    };

    enum Type
    {
        TYPE_DOCK,
        TYPE_PREVIEW,
        TYPE_CONSTRUCTION_CUTSCENE,

        TYPE_COUNT,
        TYPE_INVALID,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u16 area;
    u16 type;
    DockArea nextArea;
    BOOL playerInputEnabled;
    BOOL nextAreaLoaded;
    BOOL charactersEnabled;
    BOOL disableExitArea;
    CViDockCamera camera;
    CViDockBack dockBack;
    CViDockPlayer player;
    CViDockNpcGroup npcGroup;
    CViShadow shadow;
    s32 talkActionType;
    s32 talkActionParam;
    CViDockNpc *talkNpc;
    BOOL inSailPromptRange;
    s32 field_1470;
    BOOL movedCamForNpcTalk;
    VecFx32 camTarget;
    VecFx32 camDirection;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    u16 rotationY;
    s16 field_15BA;
    VecFx32 shipConstructBGVertices[16];
    s16 field_167C;
    s16 field_167E;
    s32 field_1680;
    s16 field_1684[9];
    u16 colors[7];
    VecFx32 field_16A4[16][6];
    s32 environmentSfxTimer;
    BOOL isThreadBusy;
    Thread thread;

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(void);
    static void Destroy(void);
    static void InitForPlayerControl(s32 area);
    static void InitForDockChange(s32 nextArea, s32 area);
    static BOOL CheckThreadIdle(void);
    static void ReturnPlayerControl(void);
    static void InitForPreview(DockArea dockArea, BOOL waitForLoad);
    static void InitForConstructionCutscene(s32 area);
    static void InitForInactive(void);
    static void EnablePlayerInput(BOOL enabled);
    static void DrawShipConstructionFontWindow(void);
    static BOOL DidExitArea(void);
    static s32 GetNextArea(void);
    static BOOL HasActiveTalkAction(void);
    static void GetTalkActionFromTalkingNpc(s32 *type, s32 *param);
    static s32 GetTalkingNpcTalkCount(void);
    static void DecrementTalkingNpcTalkCount(void);
    static s32 GetTalkingNpc(void);
    static void SetTalkingNpc(s32 id);
    static void StartTalkingToNpc(void);
    static void MoveCameraForNpcTalk(BOOL a1, BOOL a2);
    static void FinishTalkingToNpc(void);
    static BOOL CheckNextDockAreaLoaded(void);
    static void SetCharactersEnabled(BOOL enabled);
    static void SaveCharacterStates(void);
    static void LoadCharacterStates(BOOL loadAngle);
    static void DisableExitArea(BOOL areaExitDisabled);
    static void Init(CViDock *work);
    static void Release(CViDock *work);
    static void InitPlayer(CViDock *work, s32 area);
    static void ReleasePlayer(CViDock *work);
    static void HandlePlayerMovement(CViDock *work);
    static void InitDockBack(CViDock *work, BOOL noDisableAnimation);
    static void ReleaseDockBack(CViDock *work);
    static void InitDockCamera(CViDock *work);
    static void ReleaseDockDrawState(CViDock *work);
    static void InitNpcs(CViDock *work);
    static void ReleaseNpcGroup(CViDock *work);
    static BOOL CheckTouchRect(CViDock *work, s32 touchX, s32 touchY, int px, int py);
    static void InitShipConstructCompletedMessage(CViDock *work);
    static void ReleaseFontWindow(CViDock *work);
    static void DrawFontWindow(CViDock *work);
    static void InitShipConstructedBG(CViDock *work);
    static void ReleaseUnknown(CViDock *work);
    static void ProcessShipConstructedBG(CViDock *work);
    static void DrawShipConstructedBG(CViDock *work);
    static void Draw(CViDock *work, BOOL drawPlayer, BOOL drawNpcs, BOOL drawDock);
    static void HandleEnvironmentSfx(CViDock *work);
    static void Main_Init(void);
    static void Main_DockPreview(void);
    static void Main_PlayerActive(void);
    static void Main_TalkActive(void);
    static void Main_InitForPreviewDockChange(void);
    static void Main_WaitForPreviewDockChanged(void);
    static void Main_UpgradeShipSpin(void);
    static void Destructor(Task *task);
    static void Main_ChangingArea(void);
    static void ThreadFunc(void *arg);
};

#endif

#endif // RUSH_CVIDOCK_HPP