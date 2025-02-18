#ifndef RUSH_CVIMAP_HPP
#define RUSH_CVIMAP_HPP

#include <hub/hubTask.hpp>
#include <hub/dockCommon.h>
#include <hub/cviMapBack.hpp>
#include <hub/cviMapIcon.hpp>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/unknown2056C5C.h>
#include <hub/hubBgCircleEffect.h>
#include <game/save/saveGame.h>

// --------------------
// STRUCTS
// --------------------

class CViMap
{
public:
    // --------------------
    // ENUMS
    // --------------------

    enum Type
    {
        TYPE_MAP_ACTIVE,
        TYPE_DOCK_ACTIVE,
        TYPE_CONSTRUCTION_CUTSCENE,
    };

    enum ShipConstructionType
    {
        CONSTRUCT_SHIP_JET,
        CONSTRUCT_SHIP_BOAT,
        CONSTRUCT_SHIP_HOVER,
        CONSTRUCT_SHIP_SUBMARINE,
        CONSTRUCT_SHIP_DRILL, // unused in the final game

        CONSTRUCT_SHIP_COUNT,
        CONSTRUCT_SHIP_INVALID,
    };

    enum ShipUpgradeType
    {
        UPGRADE_SHIP_JET_LEVEL2,
        UPGRADE_SHIP_BOAT_LEVEL2,
        UPGRADE_SHIP_HOVER_LEVEL2,
        UPGRADE_SHIP_SUBMARIN_LEVEL2,
        UPGRADE_SHIP_JET_LEVEL3,
        UPGRADE_SHIP_BOAT_LEVEL3,
        UPGRADE_SHIP_HOVER_LEVEL3,
        UPGRADE_SHIP_SUBMARIN_LEVEL3,

        UPGRADE_SHIP_COUNT,
        UPGRADE_SHIP_INVALID,
    };

    // --------------------
    // VARIABLES
    // --------------------

    CViMapBack mapBack;
    CViMapIcon mapIcon;
    Vec2U16 mapPos;
    Vec2U16 mapPrevPos;
    Vec2U16 mapTargetPos;
    u16 mapMoveDuration;
    u16 mapMoveTimer;
    Vec2U16 constructionPos;
    s32 field_7D4;
    s32 cutsceneState;
    s32 shipConstructionID;
    s32 decorConstructionID;
    s32 shipUpgradeID;
    u16 shipConstructionImageID;
    u16 cutsceneTimer;
    u16 materialCircleAngle;
    u16 materialCircleAngleOffset;
    u32 materialRadius[8];
    AnimatorSprite aniMaterialIcon[SAVE_MATERIAL_COUNT];
    AnimatorSprite aniRingIcon;
    AnimatorSprite aniSparkle[8];
    Vec2Fx16 sparklePos[8];
    HubBGCircleEffect bgCircleEffect;
    HubConstructionCompletePulse constructionCompletePulse;
    u16 unknownStartX;
    u16 unknownStartY;
    Unknown2056FDC unknown;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(void);
    static void Destroy(void);
    static void SetType(s32 type);
    static void WarpToPosition(u16 x, u16 y);
    static void TravelToPosition(u16 x, u16 y, u16 duration);
    static void GetMapPosition(u16 *x, u16 *y);
    static MapArea GetMapAreaFromMapIconTouchInput(void);
    static MapArea GetMapAreaFromMapIconMarker(BOOL mustBeIdle);
    static void GoToMapArea(u32 mapArea, BOOL shouldTravel);
    static MapArea GetChosenMapArea(void);
    static void StartShipConstructCutscene(s32 id);
    static void StartDecorConstructCutscene(s32 id);
    static void StartShipUpgradeCutscene(s32 id);
    static void TravelToConstructionPos(fx32 progress);
    static void InitMaterialRingAppearConstructCutsceneState(void);
    static BOOL CheckMaterialRingAppearStateDone(void);
    static void InitMaterialRingShrinkConstructCutsceneState(void);
    static BOOL CheckMaterialRingShrinkStateDone(void);
    static void AddDockToMap(u16 id);
    static void AddDecorationToMap(u16 id);
    static void InitShipBuiltConstructCutsceneState(u16 id);
    static void InitDecorBuiltConstructCutsceneState(void);
    static void InitShipUpgradedConstructCutsceneState(u16 id);
    static void InitAllFinishedConstructCutsceneState(void);
    static void InitMapIcons(void);
    static void EnableMapIcons(BOOL enabled);
    static void DrawMapCursor(s16 x, s16 y);

    static AnimatorSprite *GetMaterialIconAnimator(u16 id);
    static void InitMapBack(CViMap *work);
    static void InitMapIcon(CViMap *work);
    static void InitIslandBackgrounds(CViMap *work);
    static void InitSprites(CViMap *work);
    static void Release(CViMap *work);
    static void Main_Moving(void);
    static void Main_Idle(void);
    static void Main_ConstructionCutscene(void);
    static void Destructor(Task *task);
    static void WarpToIconPosition(CViMap *work);
    static void ClampPosToMapBounds(u16 x, u16 y, u16 *outX, u16 *outY);
    static void ProcessMapPosMove(CViMap *work);
    static void InitDecorations(CViMap *work);
    static void ProcessBGCircleEffect(CViMap *work, fx32 scale, s32 progress);
    static void DrawConstructionMaterials(CViMap *work);
    static void SpawnConstructionSparkle(CViMap *work);
    static void DrawConstructionSparkles(CViMap *work);
    static void InitUnknown2056FDC(CViMap *work);
    static void LoadUnknown2056FDC(CViMap *work, u16 id);
    static void ProcessUnknown2056FDC(CViMap *work, GXRgb color);
    static void ReleaseUnknown2056FDC(CViMap *work);
    static void InitUnknown(CViMap *work);
    static void InitConstructionCompletePulse(CViMap *work);
    static void DrawConstructionCompletePulse(CViMap *work, GXRgb color);
    static void ReleaseConstructionCompletePulse(CViMap *work);

    // TODO: remove when properly decompiled
private:
    static Task *CreateInternal(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group);
    static void DestructorInternal(Task *task);
};

class CViMapPaletteAnimation
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    PaletteAnimator aniPalette[3];
    void *aniPaletteFile;

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create();
    static void Destroy();
    static void Main();
    static void Destructor(Task *task);
};

#endif // RUSH_CVIMAP_HPP