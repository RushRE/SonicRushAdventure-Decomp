#ifndef RUSH_CVIMAP_HPP
#define RUSH_CVIMAP_HPP

#include <hub/hubTask.hpp>
#include <hub/cviMapBack.hpp>
#include <hub/cviMapIcon.hpp>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/unknown2056C5C.h>
#include <hub/talkHelpersUnknown.h>
#include <hub/talkHelpersUnknown2.h>
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

    enum DecorationConstructionType
    {
        CONSTRUCT_DECOR_0,
        CONSTRUCT_DECOR_1,
        CONSTRUCT_DECOR_2,
        CONSTRUCT_DECOR_3,
        CONSTRUCT_DECOR_4,
        CONSTRUCT_DECOR_5,
        CONSTRUCT_DECOR_6,
        CONSTRUCT_DECOR_7,
        CONSTRUCT_DECOR_8,
        CONSTRUCT_DECOR_9,
        CONSTRUCT_DECOR_10,
        CONSTRUCT_DECOR_11,
        CONSTRUCT_DECOR_12,
        CONSTRUCT_DECOR_13,
        CONSTRUCT_DECOR_14,
        CONSTRUCT_DECOR_15,
        CONSTRUCT_DECOR_16,
        CONSTRUCT_DECOR_17,
        CONSTRUCT_DECOR_18,
        CONSTRUCT_DECOR_19,
        CONSTRUCT_DECOR_20,
        CONSTRUCT_DECOR_21,

        CONSTRUCT_DECOR_COUNT,
        CONSTRUCT_DECOR_INVALID,
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
    u16 field_7C0;
    u16 field_7C2;
    u16 field_7C4;
    u16 field_7C6;
    u16 field_7C8;
    u16 field_7CA;
    u16 field_7CC;
    u16 field_7CE;
    u16 field_7D0;
    u16 field_7D2;
    s32 field_7D4;
    s32 cutsceneState;
    s32 shipConstructionID;
    s32 decorConstructionID;
    s32 shipUpgradeID;
    u16 field_7E8;
    u16 cutsceneTimer;
    u16 materialCircleAngle;
    u16 materialCircleAngleOffset;
    u32 materialRadius[8];
    AnimatorSprite aniMaterialIcon[SAVE_MATERIAL_COUNT];
    AnimatorSprite aniRingIcon;
    AnimatorSprite aniSparkle[8];
    Vec2Fx16 sparklePos[8];
    TalkHelpersUnknown talkUnknown;
    TalkHelpersUnknown2 talkUnknown2;
    Unknown2056FDC unknown;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

typedef struct CViMapPaletteAnimation_
{
    PaletteAnimator aniPalette[3];
    void *aniPaletteFile;
} CViMapPaletteAnimation;

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void ViMap__Create(void);
Task *ViMap__CreateInternal(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group);
void ViMap__Destroy(void);
void ViMap__SetType(s32 type);
void ViMap__Func_215BBAC(u16 x, u16 y);
void ViMap__Func_215BBF4(u16 x, u16 y, u16 a3);
void ViMap__Func_215BC40(u16 *x, u16 *y);
s32 ViMap__GetMapIconDockAreaFromTouchPos(void);
s32 ViMap__GetMapIconDockArea(BOOL mustBeIdle);
void ViMap__Func_215BCE4(u32 area, BOOL a2);
s32 ViMap__GetDockAreaFromMapIcon(void);
void ViMap__StartShipConstructCutscene(s32 id);
void ViMap__StartDecorConstructCutscene(s32 id);
void ViMap__StartShipUpgradeCutscene(s32 id);
void ViMap__Func_215C284(s32 a1);
void ViMap__Func_215C408(void);
BOOL ViMap__Func_215C48C(void);
void ViMap__Func_215C4CC(void);
BOOL ViMap__Func_215C4F8(void);
void ViMap__Func_215C524(u16 a1);
void ViMap__Func_215C58C(u16 a1);
void ViMap__Func_215C638(u16 a1);
void ViMap__Func_215C6AC(void);
void ViMap__Func_215C76C(u16 a1);
void ViMap__Func_215C7E0(void);
void ViMap__Func_215C82C(void);
void ViMap__Func_215C84C(BOOL enabled);
void ViMap__Func_215C878(s16 x, s16 y);
void ViMapPaletteAnimation__Create(void);
void ViMapPaletteAnimation__Destroy(void);
AnimatorSprite *ViMap__Func_215C98C(u16 id);
void ViMap__Func_215C9B4(CViMap *work);
void ViMap__Func_215CA1C(CViMap *work);
void ViMap__Func_215CA60(CViMap *work);
void ViMap__Func_215CA84(CViMap *work);
void ViMap__Func_215CC14(CViMap *work);
void ViMap__Main_Moving(void);
void ViMap__Main_Idle(void);
void ViMap__Main_ConstructionCutscene(void);
void ViMap__Destructor(Task *task);
void ViMap__Func_215D150(Task *task);
void ViMapPaletteAnimation__Main(void);
void ViMapPaletteAnimation__Destructor(Task *task);
void ViMap__Func_215D214(CViMap *work);
void ViMap__Func_215D27C(u16 x, u16 y, u16 *outX, u16 *outY);
void ViMap__Func_215D2B4(CViMap *work);
void ViMap__Func_215D374(CViMap *work);
void ViMap__Func_215D44C(CViMap *work, s32 a2, s32 a3);
void ViMap__Func_215D4B4(CViMap *work);
void ViMap__Func_215D604(CViMap *work);
void ViMap__Func_215D734(CViMap *work);
void ViMap__Func_215D7B4(CViMap *work);
void ViMap__Func_215D7D8(CViMap *work, u16 a2);
void ViMap__Func_215D930(CViMap *work, GXRgb color);
void ViMap__ReleaseTalkUnknown2(CViMap *work);
void ViMap__Func_215D9E8(CViMap *work);
void ViMap__Func_215D9EC(CViMap *work);
void ViMap__Func_215DA38(CViMap *work, u16 a2);
void ViMap__Func_215DA68(CViMap *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAP_HPP