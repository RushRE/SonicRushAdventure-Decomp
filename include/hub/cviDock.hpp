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
#include <hub/cviDockDrawState.hpp>
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
        TYPE_0,
        TYPE_1,
        TYPE_2,

        TYPE_COUNT,
        TYPE_INVALID,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u16 area;
    u16 type;
    s32 areaUnknown;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    CViDockDrawState dockDrawState;
    CViDockBack dockBack;
    CViDockPlayer player;
    CViDockNpcGroup npcGroup;
    CViShadow shadow;
    s32 talkActionType;
    s32 talkActionParam;
    CViDockNpc *talkNpc;
    s32 field_146C;
    s32 field_1470;
    s32 field_1474;
    VecFx32 field_1478;
    VecFx32 field_1484;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    u16 rotationY;
    s16 field_15BA;
    VecFx32 field_15BC[16];
    s16 field_167C;
    s16 field_167E;
    s32 field_1680;
    s16 field_1684[9];
    u16 colors[7];
    VecFx32 field_16A4[16][6];
    s32 environmentSfxTimer;
    s32 field_1B28;
    Thread thread;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(void);
    static void Func_215DB9C(void);
    static void Func_215DBC8(s32 area);
    static void Func_215DC80(s32 a1, s32 area);
    static BOOL Func_215DD00(void);
    static void Func_215DD2C(void);
    static void Func_215DD64(s32 area, s32 a2);
    static void Func_215DE40(s32 area);
    static void Func_215DEF4(void);
    static void Func_215DF64(s32 a1);
    static void Func_215DF84(void);
    static BOOL Func_215DFA0(void);
    static s32 Func_215DFE4(void);
    static BOOL Func_215E000(void);
    static void Func_215E02C(s32 *type, s32 *param);
    static s32 Func_215E06C(void);
    static void Func_215E098(void);
    static s32 GetTalkingNpc(void);
    static void Func_215E104(s32 a1);
    static void Func_215E178(void);
    static void Func_215E340(s32 a1, s32 a2);
    static void Func_215E410(void);
    static BOOL Func_215E4A0(void);
    static void Func_215E4BC(s32 a1);
    static void Func_215E4DC(void);
    static void Func_215E578(BOOL a1);
    static void Func_215E658(s32 a1);
    static void Func_215E678(CViDock *work);
    static void Func_215E6E4(CViDock *work);
    static void LoadPlayer(CViDock *work, s32 area);
    static void Func_215E81C(CViDock *work);
    static void HandlePlayerMovement(CViDock *work);
    static void Func_215E9F4(CViDock *work, BOOL a2);
    static void Func_215EA7C(CViDock *work);
    static void Func_215EA8C(CViDock *work);
    static void Func_215EAF4(CViDock *work);
    static void CreateNpcs(CViDock *work);
    static void ClearNpcGroup(CViDock *work);
    static BOOL CheckTouchRect(CViDock *work, s32 touchX, s32 touchY, int px, int py);
    static void Func_215ED0C(CViDock *work);
    static void Func_215EE58(CViDock *work);
    static void Func_215EE7C(CViDock *work);
    static void Func_215EEA0(CViDock *work);
    static void Func_215EF3C(CViDock *work);
    static void Func_215EF40(CViDock *work);
    static void Func_215F1A8(CViDock *work);
    static void Draw(CViDock *work, BOOL drawPlayer, BOOL drawNpcs, BOOL drawDock);
    static void HandleEnvironmentSfx(CViDock *work);
    static void Main(void);
    static void Main_215F998(void);
    static void Main_215F9CC(void);
    static void Main_215FD48(void);
    static void Main_215FE00(void);
    static void Main_215FE34(void);
    static void Main_215FE68(void);
    static void Destructor(Task *task);
    static void Main_215FFC0(void);
    static void ThreadFunc(void *arg);
};

#endif

#endif // RUSH_CVIDOCK_HPP