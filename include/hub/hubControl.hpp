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
    HUBEVENT_UNKNOWN,
    HUBEVENT_LOAD_STAGE_1,
    HUBEVENT_SOUND_TEST,
    HUBEVENT_VIKING_CUP,
    HUBEVENT_LOAD_STAGE_2,
    HUBEVENT_CORRUPT_SAVE_WARNING,

    HUBEVENT_COUNT,
    HUBEVENT_INVALID,
};

#ifdef __cplusplus

// --------------------
// STRUCTS
// --------------------

struct HubControlSaveUnknown
{
    u16 gameProgress;
    u16 flag;
};

class HubControl
{

    // --------------------
    // VARIABLES
    // --------------------

public:
    s32 field_0;
    u32 field_4;
    u32 field_8;
    s32 field_C;
    s32 field_10;
    s32 nextAreaID;
    s32 nextAreaID2;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    u32 flags;
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
    s32 field_114;
    s32 field_118;
    s32 field_11C;
    u32 field_120;
    s32 field_124;
    s32 field_128;
    s32 field_12C;
    s32 field_130;
    s32 field_134;
    u16 field_138;
    u16 field_13A;
    u16 curAreaID;
    u16 npcCount;
    u16 field_140;
    s16 field_142;
    AnimatorSprite aniNpcIcon[5];
    AnimatorSprite aniNpcBackground;
    AnimatorSprite aniOptionsIcon[2];
    AnimatorSprite aniOptionsName[3];

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Func_21576CC();

    void LoadArchives();
    void Func_215966C();
    void Func_2159758(s32 a2);
    void ClearAnimators();
    void Func_215993C();
    void ReleaseAnimators();
    void Func_2159D08();
    BOOL Func_2159D14();
    BOOL Func_2159D4C();
    void Func_2159D84(s32 area);
    void Func_215A014();
    
    // TODO: make these member functions when all xrefs have been decompiled
    static void Func_21598B4(HubControl *work);
    static void Func_2159740(HubControl *work);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 area);
    static void Create2(s32 a1, BOOL a2, s32 a3);
    static void Func_21576AC(s32 a1);
    static void Main1();
    static void Main_21578CC();
    static void Main_2157A94();
    static void Main_2157C0C();
    static void Main2();
    static void Main_2157F2C();
    static void Main_2157F64();
    static void Main_21580C0();
    static void Main_2158108();
    static void Main_21587D8();
    static void Main_2158868();
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
    static void Func_21597A4(s16 a1, s32 a2);
    static void Func_2159810();
    static BOOL Func_2159854(s32 event);
    static void Func_215A2E0(s32 a1, s32 a2);
    static void Func_215A3EC();
    static void Func_215A400(s32 eventID, s32 selection);

    static void Func_215700C();
    static void Func_215701C(s32 a1);
    static void Func_21570B8(s32 a1);
    static void Func_215710C(BOOL a2);
    static void Func_2157124();
    static void Func_215713C();
    static void Func_2157154();
    static BOOL Func_2157178();
    static void *GetFileFrom_ViAct(u16 id);
    static void *GetFileFrom_ViActLoc(u16 id);
    static void *GetFileFrom_ViBG(u16 id);
    static void *GetFileFrom_ViMsg();
    static void *GetFileFrom_ViMsgCtrl();
    static FontWindow *GetField54();
    static void *GetTKDMNameSprite();
    static void Func_2157288();
    static void Func_21572B8();

    static void Main_2158160();
    static void Main_2158AB4();

    static void Func_215A520();
    static void Func_215A888();
    static void Func_215A96C();
    static void Func_215A9D8();
    static void Func_215AAB4();
    static void Func_215AB84();
    static void Func_215ABF8();
    static void Func_215AD34();
    static void Func_215ADA0();
    static void Func_215AE84();
    static void Func_215B03C();
    static void Func_215B168();
    static void Func_215B250();
    static void Func_215B3B4();
    static void Func_215B3D0();
    static void Func_215B470(s32 a1, s32 a2);
    static BOOL Func_215B498(s32 a1);
    static s32 GetNextShipToBuild();
    static BOOL Func_215B51C(s32 a1);
    static void Func_215B588(s32 a1, s32 a2);
    static BOOL Func_215B6C4(s32 a1);
    static BOOL Func_215B850(s32 a1);
    static BOOL Func_215B858(s32 type);
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
