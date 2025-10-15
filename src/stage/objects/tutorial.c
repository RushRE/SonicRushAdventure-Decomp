#include <stage/objects/tutorial.h>
#include <stage/objects/checkpoint.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapSys.h>
#include <game/save/saveGame.h>
#include <game/graphics/drawFadeTask.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/system/sysEvent.h>
#include <game/object/objectManager.h>
#include <game/file/fileUnknown.h>
#include <game/util/advancePrompt.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// used for both Tutorial & TutorialCheckpoint
#define mapObjectParam_id               mapObject->left // not used for Tutorial (it's hardcoded to id 0)
#define mapObjectParam_nextSectionWidth mapObject->top
#define mapObjectParam_promptPosX       mapObject->width
#define mapObjectParam_promptPosY       mapObject->height

// --------------------
// MACROS
// --------------------

#define CHECK_NEXT_PROMPT_TOUCH(touchPos, buttonPos)                                                                                                                               \
    ((buttonPos).x <= (touchPos).x && (touchPos).x <= (buttonPos).x + 24 && (buttonPos).y <= (touchPos).y && (touchPos).y <= (buttonPos).y + 24)

// --------------------
// ENUMS
// --------------------

enum TutorialFlags
{
    TUTORIAL_FLAG_SHOW_DIALOG_WINDOW   = 1 << 0,
    TUTORIAL_FLAG_SHOW_NEXT_PROMPT     = 1 << 1,
    TUTORIAL_FLAG_SHOW_CHARACTER_ICON  = 1 << 2,
    TUTORIAL_FLAG_8                    = 1 << 3,
    TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE = 1 << 4,
    TUTORIAL_FLAG_AUTO_ADVANCE_DIALOG  = 1 << 5,
    TUTORIAL_FLAG_40                   = 1 << 6,
    TUTORIAL_FLAG_HAS_DIALOG_CHOICE    = 1 << 7,
};

enum TutorialSectionFlags
{
    TUTORIAL_SECTIONFLAG_COMPLETE             = 1 << 0,
    TUTORIAL_SECTIONFLAG_SHOW_KEY_1           = 1 << 1,
    TUTORIAL_SECTIONFLAG_SHOW_KEY_2           = 1 << 2,
    TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON     = 1 << 3,
    TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT = 1 << 4,
    TUTORIAL_SECTIONFLAG_SKIPPED              = 1 << 5,

    TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL =
        TUTORIAL_SECTIONFLAG_SHOW_KEY_1 | TUTORIAL_SECTIONFLAG_SHOW_KEY_2 | TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT,
};

enum TutorialPlayerAction
{
    TUTORIAL_PLAYERACTION_NONE = 0x00,

    TUTORIAL_PLAYERACTION_JUMP          = 1 << 0,
    TUTORIAL_PLAYERACTION_ENEMY_DESTROY = 1 << 1,
    TUTORIAL_PLAYERACTION_JUMPDASH      = 1 << 2,
    TUTORIAL_PLAYERACTION_SPINDASH      = 1 << 3,
    TUTORIAL_PLAYERACTION_TRICK_FINISH  = 1 << 4,
};

enum TutorialMsgSequences
{
    TUTORIAL_MSGSEQ_INTRO,
    TUTORIAL_MSGSEQ_INTRO_RETRY,
    TUTORIAL_MSGSEQ_TASK_MOVING,
    TUTORIAL_MSGSEQ_TASK_MOVING_LOOPS,
    TUTORIAL_MSGSEQ_TASK_JUMP,
    TUTORIAL_MSGSEQ_TASK_JUMPDASH,
    TUTORIAL_MSGSEQ_TASK_SPINDASH,
    TUTORIAL_MSGSEQ_TASK_TRICK,
    TUTORIAL_MSGSEQ_TASK_HOPJUMP,
    TUTORIAL_MSGSEQ_TASK_SUPERBOOST,
    TUTORIAL_MSGSEQ_TASK_HUMMINGTOP,
    TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
    TUTORIAL_MSGSEQ_LOOKS_LIKE_YOU_GOT_HANG_OF_IT,
    TUTORIAL_MSGSEQ_PLACE_MARINE_SAID_BLOCKED_OFF,
    TUTORIAL_MSGSEQ_YES_NO,
    TUTORIAL_MSGSEQ_GOOD_LUCK_SONIC,

    TUTORIAL_MSGSEQ_INVALID = 0xFF,
};

enum TutorialSections
{
    TUTORIAL_SECTION_MOVE,
    TUTORIAL_SECTION_MOVE_LOOP,
    TUTORIAL_SECTION_JUMP,
    TUTORIAL_SECTION_JUMPDASH,
    TUTORIAL_SECTION_SPINDASH,
    TUTORIAL_SECTION_TRICK,
    TUTORIAL_SECTION_HOPJUMP,
    TUTORIAL_SECTION_SUPERBOOST,
    TUTORIAL_SECTION_BREAKABLE,
    TUTORIAL_SECTION_HUMMINGTOP,
    TUTORIAL_SECTION_INTRO,
    TUTORIAL_SECTION_INTRO_RETRY,

    TUTORIAL_SECTION_COUNT,
};

enum TutorialCharacterAnims
{
    TUTORIALCHARACTER_ANI_SONIC,
    TUTORIALCHARACTER_ANI_TAILS_1,
    TUTORIALCHARACTER_ANI_TAILS_2,
    TUTORIALCHARACTER_ANI_TAILS_3,
    TUTORIALCHARACTER_ANI_TAILS_4,
};

enum TutorialIconAnims
{
    TUTORIALICON_ANI_CHECKPOINT,
    TUTORIALICON_ANI_SPRING,
    TUTORIALICON_ANI_DPAD_LEFT,
    TUTORIALICON_ANI_DPAD_UP,
    TUTORIALICON_ANI_DPAD_RIGHT,
    TUTORIALICON_ANI_DPAD_DOWN,
};

enum TutorialPromptAnims
{
    TUTORIALPROMPT_ANI_DPAD_IDLE,
    TUTORIALPROMPT_ANI_DPAD_LEFT,
    TUTORIALPROMPT_ANI_DPAD_UP,
    TUTORIALPROMPT_ANI_DPAD_RIGHT,
    TUTORIALPROMPT_ANI_DPAD_DOWN,
    TUTORIALPROMPT_ANI_BTN_A,
    TUTORIALPROMPT_ANI_BTN_B,
    TUTORIALPROMPT_ANI_BTN_Y,
    TUTORIALPROMPT_ANI_BTN_L,
    TUTORIALPROMPT_ANI_BTN_R,
    TUTORIALPROMPT_ANI_PROMPT_RIGHT,
    TUTORIALPROMPT_ANI_SCROLL_LEFT,
    TUTORIALPROMPT_ANI_SCROLL_RIGHT,
};

// --------------------
// STRUCTS
// --------------------

struct TutorialSection
{
    u8 seqStart;
    u8 seqFinish;
    fx32 unknown; // set, but never used
    void (*statePlayer)(Tutorial *work);
    void (*stateBtnPrompt)(Tutorial *work);
};

// this may not be a struct, but that's the only way to get 'iconAnimIDs' & the other arrays local to 'CreateTutorial' to line up perfectly as far as I know!
struct TutorialStaticVars
{
    FontFile *fontFile;
    Tutorial *activeTutorial;
    void *archive;
    OBS_DATA_WORK textIconFile;
    OBS_DATA_WORK nextPromptFile;
    OBS_DATA_WORK characterIconFile;
    OBS_DATA_WORK buttonPromptFile;
};

// --------------------
// FUNCTION DECLS
// --------------------

// Misc
static void Tutorial_Destructor(Task *task);

// States & Drawing
static void Tutorial_State_Init(Tutorial *work);
static void Tutorial_State_Active(Tutorial *work);
static void Tutorial_Draw(void);

// Scroll States & actions
static void UpdateTutorialBounds(Tutorial *work, fx32 nextSectionWidth);
static void Tutorial_StateScroll_Scrolling(Tutorial *work);

// Talk States & actions
static void Tutorial_Action_Init(Tutorial *work);
static void Tutorial_StateTalk_WaitForEventChange(Tutorial *work);
static void Tutorial_StateTalk_WaitForFadeIn(Tutorial *work);
static void Tutorial_Action_ShowWindowForIntro(Tutorial *work);
static void Tutorial_StateTalk_ShowWindowForIntro(Tutorial *work);
static void Tutorial_Action_IntroDialog(Tutorial *work);
static void Tutorial_StateTalk_IntroDialog(Tutorial *work);
static void Tutorial_StateTalk_PracticeSelection(Tutorial *work);
static void Tutorial_StateTalk_SkipTutorialTalk(Tutorial *work);
static void Tutorial_StateTalk_SkipTutorial(Tutorial *work);
static void Tutorial_Action_ActivateCheckpoint(Tutorial *work, s32 id, fx32 nextSectionWidth, fx32 promptPosX, fx32 promptPosY);
static void Tutorial_StateTalk_FinishedSection_ShowCharacter(Tutorial *work);
static void Tutorial_StateTalk_Talking(Tutorial *work);
static void Tutorial_Action_FinishSection(Tutorial *work);
static void Tutorial_StateTalk_FinishSection(Tutorial *work);
static void Tutorial_StateTalk_NextSection(Tutorial *work);
static void Tutorial_StateTalk_CloseWindowForFinishSection(Tutorial *work);
static void Tutorial_Action_FinishedStage(Tutorial *work);
static void Tutorial_StateTalk_ShowWindowForFinishedStage(Tutorial *work);
static void Tutorial_StateTalk_FinishedStage(Tutorial *work);
static void Tutorial_StateTalk_CloseWindowForFinishedStage(Tutorial *work);
static void Tutorial_StatePlayer_MoveToNewBounds(Tutorial *work);
static void Tutorial_StatePlayer_CheckJumped(Tutorial *work);
static void Tutorial_StatePlayer_CheckJumpDashed(Tutorial *work);
static void Tutorial_StatePlayer_CheckSpindashed(Tutorial *work);
static void Tutorial_StatePlayer_CheckTrickFinished(Tutorial *work);
static void Tutorial_StatePlayer_CheckStageFinished(Tutorial *work);

// Button Prompt States
static void Tutorial_StatePrompt_Move_Init(Tutorial *work);
static void Tutorial_StatePrompt_Move_Active(Tutorial *work);
static void Tutorial_StatePrompt_MoveLoop_Init(Tutorial *work);
static void Tutorial_StatePrompt_MoveLoop_Active(Tutorial *work);
static void Tutorial_StatePrompt_Jump_Init(Tutorial *work);
static void Tutorial_StatePrompt_Jump_Active(Tutorial *work);
static void Tutorial_StatePrompt_JumpDash_Init(Tutorial *work);
static void Tutorial_StatePrompt_JumpDash_Active(Tutorial *work);
static void Tutorial_StatePrompt_SpindashCharge_Init(Tutorial *work);
static void Tutorial_StatePrompt_SpindashCharge_Active(Tutorial *work);
static void Tutorial_StatePrompt_Trick_Init(Tutorial *work);
static void Tutorial_StatePrompt_Trick_Active(Tutorial *work);
static void Tutorial_StatePrompt_HopJump_Init(Tutorial *work);
static void Tutorial_StatePrompt_HopJump_Active(Tutorial *work);
static void Tutorial_StatePrompt_HummingTop_Init(Tutorial *work);
static void Tutorial_StatePrompt_HummingTop_Active(Tutorial *work);
static void Tutorial_StatePrompt_Boost_Init(Tutorial *work);
static void Tutorial_StatePrompt_Boost_Active(Tutorial *work);

// Misc
static void HandleTutorialNextPrompt(Tutorial *work);
static void TutorialFontCallback(u32 id, FontAnimator *animator, void *userData);

// TutorialCheckpoint
static void TutorialCheckpoint_State_Active(TutorialCheckpoint *work);
static void TutorialCheckpoint_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// VARIABLES
// --------------------

static struct TutorialStaticVars sVars;

static u16 promptAngles[4]         = { FLOAT_DEG_TO_IDX(180.0), FLOAT_DEG_TO_IDX(270.0), FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(90.0) };
static Vec2Fx16 promptPositions[4] = { { -24, 0 }, { 0, -24 }, { 24, 0 }, { 0, 24 } };

static struct TutorialSection sectionList[TUTORIAL_SECTION_COUNT] =
{
    [TUTORIAL_SECTION_MOVE] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_MOVING,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(0.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = Tutorial_StatePrompt_Move_Init,
    },

    [TUTORIAL_SECTION_MOVE_LOOP] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_MOVING_LOOPS,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = Tutorial_StatePrompt_MoveLoop_Init,
    },
    
    [TUTORIAL_SECTION_JUMP] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_JUMP,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = Tutorial_StatePlayer_CheckJumped,
        .stateBtnPrompt = Tutorial_StatePrompt_Jump_Init,
    },
    
    [TUTORIAL_SECTION_JUMPDASH] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_JUMPDASH,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = Tutorial_StatePlayer_CheckJumpDashed,
        .stateBtnPrompt = Tutorial_StatePrompt_JumpDash_Init,
    },
    
    [TUTORIAL_SECTION_SPINDASH] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_SPINDASH,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = Tutorial_StatePlayer_CheckSpindashed,
        .stateBtnPrompt = Tutorial_StatePrompt_SpindashCharge_Init,
    },
    
    [TUTORIAL_SECTION_TRICK] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_TRICK,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = Tutorial_StatePlayer_CheckTrickFinished,
        .stateBtnPrompt = Tutorial_StatePrompt_Trick_Init,
    },
    
    [TUTORIAL_SECTION_HOPJUMP] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_HOPJUMP,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = Tutorial_StatePrompt_HopJump_Init,
    },
    
    [TUTORIAL_SECTION_SUPERBOOST] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_SUPERBOOST,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = Tutorial_StatePrompt_Boost_Init,
    },
    
    [TUTORIAL_SECTION_BREAKABLE] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_PLACE_MARINE_SAID_BLOCKED_OFF,
        .seqFinish      = TUTORIAL_MSGSEQ_LOOKS_LIKE_YOU_GOT_HANG_OF_IT,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = Tutorial_StatePlayer_CheckStageFinished,
        .stateBtnPrompt = NULL,
    },
    
    [TUTORIAL_SECTION_HUMMINGTOP] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_TASK_HUMMINGTOP,
        .seqFinish      = TUTORIAL_MSGSEQ_WAY_TO_GO_SONIC,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = Tutorial_StatePrompt_HummingTop_Init,
    },
    
    [TUTORIAL_SECTION_INTRO] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_INVALID,
        .seqFinish      = TUTORIAL_MSGSEQ_INTRO,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = NULL,
    },
    
    [TUTORIAL_SECTION_INTRO_RETRY] = 
    {
        .seqStart       = TUTORIAL_MSGSEQ_INVALID,
        .seqFinish      = TUTORIAL_MSGSEQ_INTRO_RETRY,
        .unknown        = FLOAT_TO_FX32(32.0),
        .statePlayer    = NULL,
        .stateBtnPrompt = NULL,
    }
};

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckAdvancePress(Tutorial *work)
{
    if (padInput.btnPress & PAD_BUTTON_A)
        goto BUTTON_PRESSED;

    if (work->aniNextPrompt.work.animID == ADVANCEPROMPT_ANI_HELD && IsTouchInputEnabled() && TOUCH_HAS_PULL(touchInput.flags))
    {
        s16 y;
        s16 x;

        x = work->aniNextPrompt.position[0].x;
        if (x <= (s32)touchInput.pull.x && (s32)touchInput.pull.x <= (x + 24))
        {
            y = work->aniNextPrompt.position[0].y;
            if (y <= (s32)touchInput.pull.y && (s32)touchInput.pull.y <= (y + 24))
            {
            BUTTON_PRESSED:
                return TRUE;
            }
        }
    }

    return FALSE;
}

// --------------------
// FUNCTIONS
// --------------------

Tutorial *CreateTutorial(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(Tutorial_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F0, TASK_GROUP(2), Tutorial);
    if (task == HeapNull)
        return NULL;

    Tutorial *work = TaskGetWork(task, Tutorial);
    TaskInitWork8(work);
    sVars.activeTutorial = work;

    work->boundsL = FLOAT_TO_FX32(0.0);
    work->boundsR = FLOAT_TO_FX32(8.0);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    sVars.archive = FSRequestFileSync("/narc/z1t_tutorial.narc", FSREQ_AUTO_ALLOC_HEAD);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/nl_tre.bac", &sVars.characterIconFile, sVars.archive, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, TUTORIALCHARACTER_ANI_TAILS_1, 125);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_1);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->gameWork.objWork, TUTORIALCHARACTER_ANI_TAILS_1);

    static const u8 iconAllocIDs[] = { 91, 91, 90, 90, 90, 90 };
    AnimatorSpriteDS *aniIcon      = work->aniObjectiveIcons;
    for (u16 i = 0; i < 6; i++, aniIcon++)
    {
        ObjAction2dBACLoad(aniIcon, "/act/ac_fix_tut_check.bac", 2, &sVars.textIconFile, sVars.archive);
        aniIcon->work.cParam.palette = ObjDrawAllocSpritePalette(sVars.textIconFile.fileData, i, iconAllocIDs[i]);
        aniIcon->cParam[0].palette = aniIcon->cParam[1].palette = aniIcon->work.cParam.palette;

        aniIcon->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
        StageTask__SetOAMOrder(&aniIcon->work, SPRITE_ORDER_1);
        StageTask__SetOAMPriority(&aniIcon->work, SPRITE_PRIORITY_0);
        AnimatorSpriteDS__SetAnimation(aniIcon, i);
    }

    AnimatorSpriteDS *aniNextPrompt = &work->aniNextPrompt;
    ObjAction2dBACLoad(aniNextPrompt, "/act/dmcmn_fix_next.bac", 4, &sVars.nextPromptFile, sVars.archive);
    aniNextPrompt->work.cParam.palette = ObjDrawAllocSpritePalette(sVars.nextPromptFile.fileData, 2, 127);
    aniNextPrompt->cParam[0].palette = aniNextPrompt->cParam[1].palette = aniNextPrompt->work.cParam.palette;
    aniNextPrompt->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_LOOPING;
    StageTask__SetOAMOrder(&aniNextPrompt->work, SPRITE_ORDER_1);
    StageTask__SetOAMPriority(&aniNextPrompt->work, SPRITE_PRIORITY_0);
    AnimatorSpriteDS__SetAnimation(aniNextPrompt, ADVANCEPROMPT_ANI_DISABLED);

    const u16 buttonSpriteSizes[] = { 18, 8, 2 };
    const u16 buttonAnimIDs[]     = { TUTORIALPROMPT_ANI_DPAD_IDLE, TUTORIALPROMPT_ANI_BTN_A, TUTORIALPROMPT_ANI_PROMPT_RIGHT };

    s32 i;
    AnimatorSpriteDS *aniKey = work->aniKeys;
    for (i = 0; i < 3; i++, aniKey++)
    {
        ObjAction2dBACLoad(aniKey, "/act/ac_fix_key.bac", buttonSpriteSizes[i], &sVars.buttonPromptFile, gameArchiveStage);
        aniKey->work.cParam.palette = ObjDrawAllocSpritePalette(sVars.buttonPromptFile.fileData, 0, 90);
        aniKey->cParam[0].palette = aniKey->cParam[1].palette = aniKey->work.cParam.palette;

        aniKey->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_LOOPING;
        aniKey->flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;
        StageTask__SetOAMOrder(&aniKey->work, SPRITE_ORDER_1);
        StageTask__SetOAMPriority(&aniKey->work, SPRITE_PRIORITY_0);
        AnimatorSpriteDS__SetAnimation(aniKey, buttonAnimIDs[i]);
    }
    work->aniKeys[2].work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

    sVars.fontFile = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, sVars.fontFile, TRUE);
    FontWindow__Load_mw_frame(&work->fontWindow);

    u8 palette1 = ObjDrawAllocSpritePalette(sVars.characterIconFile.fileData, 0, 122);
    u8 palette2 = ObjDrawAllocSpritePalette(sVars.characterIconFile.fileData, 0, 123);
    u8 palette3 = ObjDrawAllocSpritePalette(sVars.characterIconFile.fileData, 0, 124);
    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont2(&work->fontAnimator, &work->fontWindow, 8, PIXEL_TO_TILE(64), PIXEL_TO_TILE(8), PIXEL_TO_TILE(184), PIXEL_TO_TILE(64), GRAPHICS_ENGINE_A,
                            SPRITE_PRIORITY_0, SPRITE_ORDER_1, palette1);
    FontAnimator__LoadMPCFile(&work->fontAnimator, FileUnknown__GetAOUFile(sVars.archive, GetGameLanguage()));
    FontWindowAnimator__Init(work->fontWindowAnimator);
    FontWindowAnimator__Load2(work->fontWindowAnimator, &work->fontWindow, 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(0),
                              PIXEL_TO_TILE(0), PIXEL_TO_TILE(HW_LCD_WIDTH), PIXEL_TO_TILE(64), GRAPHICS_ENGINE_A, SPRITE_PRIORITY_0, SPRITE_ORDER_3, palette2);
    FontUnknown2058D78__Func_2058D54(&work->fontUnknown);
    FontUnknown2058D78__Init(&work->fontUnknown, &work->fontAnimator, 0, 8, 1, GRAPHICS_ENGINE_B, SPRITE_PRIORITY_0, SPRITE_ORDER_1, palette1);
    FontUnknown2058D78__LoadPalette2(&work->fontUnknown);
    FontWindowAnimator__Init(&work->fontWindowAnimator[1]);
    FontWindowAnimator__Load2(&work->fontWindowAnimator[1], &work->fontWindow, 8, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(0),
                              PIXEL_TO_TILE(0), PIXEL_TO_TILE(HW_LCD_WIDTH), PIXEL_TO_TILE(64), GRAPHICS_ENGINE_B, SPRITE_PRIORITY_0, SPRITE_ORDER_3, palette2);
    FontWindowMWControl__Init(&work->fontMWControl);
    FontWindowMWControl__Load(&work->fontMWControl, &work->fontWindow, 0, FONTWINDOWMW_FILL, 184, 16, GRAPHICS_ENGINE_A, SPRITE_PRIORITY_0, SPRITE_ORDER_2, palette3);
    FontAnimator__SetCallbackType(&work->fontAnimator, 1);
    FontAnimator__LoadPaletteFunc2(&work->fontAnimator);
    FontUnknown2058D78__LoadPalette2(&work->fontUnknown);

    MI_CpuCopy8(((16 * sizeof(GXRgb)) * palette1) + VRAM_OBJ_PLTT, &objDrawPalette2[16 * palette1], 16 * sizeof(GXRgb));
    MI_CpuCopy8(((16 * sizeof(GXRgb)) * palette1) + VRAM_OBJ_PLTT, &objDrawPalette1[16 * palette1], 16 * sizeof(GXRgb));
    FontAnimator__SetCallback(&work->fontAnimator, TutorialFontCallback, work);
    FontAnimator__SetMsgSequence(&work->fontAnimator, TUTORIAL_MSGSEQ_INTRO);

    SetTaskState(&work->gameWork.objWork, Tutorial_State_Init);
    SetTaskOutFunc(&work->gameWork.objWork, Tutorial_Draw);

    Tutorial_Action_Init(work);

    return work;
}

TutorialCheckpoint *CreateTutorialCheckpoint(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (CheckTutorialInactive())
        return NULL;

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TutorialCheckpoint);
    if (task == HeapNull)
        return NULL;

    TutorialCheckpoint *work = TaskGetWork(task, TutorialCheckpoint);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/ac_gmk_check.bac", GetObjectFileWork(OBJDATAWORK_72), gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, CHECKPOINT_ANI_IDLE, 91);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_2);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_IDLE);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], TutorialCheckpoint_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    if (sVars.activeTutorial != NULL && sectionList[sVars.activeTutorial->sectionID].statePlayer && (sVars.activeTutorial->sectionFlags & TUTORIAL_SECTIONFLAG_COMPLETE) == 0)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->gameWork.colliders[0].parent = NULL;
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
    }

    SetTaskState(&work->gameWork.objWork, TutorialCheckpoint_State_Active);

    return work;
}

// Misc
void SetTutorialEnemyDestroy(void)
{
    if (sVars.activeTutorial != NULL)
        sVars.activeTutorial->playerActionFlags |= TUTORIAL_PLAYERACTION_ENEMY_DESTROY;
}

BOOL CheckTutorialInactive(void)
{
    if (sVars.activeTutorial != NULL && (sVars.activeTutorial->sectionFlags & TUTORIAL_SECTIONFLAG_SKIPPED) == 0)
        return FALSE;

    return TRUE;
}

void Tutorial_Destructor(Task *task)
{
    AnimatorSpriteDS *aniIcon;
    s32 i;

    Tutorial *work = TaskGetWork(task, Tutorial);

    sVars.activeTutorial = NULL;

    aniIcon = work->aniObjectiveIcons;
    for (i = 0; i < 6; i++)
    {
        ObjDrawReleaseSpritePalette(aniIcon->work.cParam.palette);
        ObjAction2dBACRelease(&sVars.textIconFile, aniIcon);

        aniIcon++;
    }

    ObjDrawReleaseSprite(127);
    ObjAction2dBACRelease(&sVars.nextPromptFile, &work->aniNextPrompt);

    for (i = 0; i < 3; ++i)
    {
        ObjDrawReleaseSprite(90);
        ObjAction2dBACRelease(&sVars.buttonPromptFile, &work->aniKeys[i]);
    }

    FontWindowMWControl__Release(&work->fontMWControl);
    FontUnknown2058D78__Release(&work->fontUnknown, &work->fontAnimator);
    FontAnimator__Release(&work->fontAnimator);
    FontWindowAnimator__Release(&work->fontWindowAnimator[0]);
    FontWindowAnimator__Release(&work->fontWindowAnimator[1]);

    ObjDrawReleaseSprite(122);
    ObjDrawReleaseSprite(123);
    FontWindow__Release(&work->fontWindow);

    if (sVars.fontFile != NULL)
    {
        HeapFree(HEAP_USER, sVars.fontFile);
        sVars.fontFile = NULL;
    }

    if (sVars.archive != NULL)
    {
        HeapFree(HEAP_USER, sVars.archive);
        sVars.archive = NULL;
    }

    GameObject__Destructor(task);
}

// States & Drawing
void Tutorial_State_Init(Tutorial *work)
{
    gPlayer->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    gPlayer->inputLock = TRUE;

    SetTaskState(&work->gameWork.objWork, Tutorial_State_Active);
}

void Tutorial_State_Active(Tutorial *work)
{
    if (GetSysEventList()->currentEventID == SYSEVENT_STAGE_ACTIVE)
    {
        if (work->stateScroll != NULL)
            work->stateScroll(work);

        if (work->stateTalk != NULL)
            work->stateTalk(work);

        if (work->statePlayer != NULL)
            work->statePlayer(work);

        if (work->stateBtnPrompt != NULL)
            work->stateBtnPrompt(work);

        HandleTutorialNextPrompt(work);

        if (gPlayer->tension < PLAYER_TENSION_PER_LEVEL && (gPlayer->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
        {
            work->tensionRefillTimer++;
            if (work->tensionRefillTimer >= 30)
            {
                work->tensionRefillTimer = 0;
                Player__GiveTension(gPlayer, (s16)(PLAYER_TENSION_PER_LEVEL - gPlayer->tension));
            }
        }
        else
        {
            work->tensionRefillTimer = 0;
        }

        if ((work->flags & TUTORIAL_FLAG_SHOW_DIALOG_WINDOW) != 0)
        {
            s32 i      = 0;
            s32 offset = 0;
            for (; i < 2; i++)
            {
                s16 x = work->characterIconPos.x;
                s16 y = (work->characterIconPos.y + offset);
                if (x > -HW_LCD_WIDTH && x < HW_LCD_WIDTH && y >= -64 && y < HW_LCD_HEIGHT)
                {
                    FontWindowAnimator__Func_2059B88(&work->fontWindowAnimator[i], x, y);
                    FontWindowAnimator__Draw(&work->fontWindowAnimator[i]);
                }

                offset += BOTTOM_SCREEN_CAMERA_OFFSET;
            }
        }

        FontWindow__PrepareSwapBuffer(&work->fontWindow);
    }
}

void Tutorial_Draw(void)
{
    Tutorial *work = TaskGetWorkCurrent(Tutorial);

    if ((work->flags & TUTORIAL_FLAG_SHOW_CHARACTER_ICON) != 0)
    {
        AnimatorSpriteDS *aniCharacter = &work->gameWork.animator.ani;

        aniCharacter->position[0].x = work->characterIconPos.x;
        aniCharacter->position[0].y = work->characterIconPos.y;
        aniCharacter->position[1].x = work->characterIconPos.x;
        aniCharacter->position[1].y = work->characterIconPos.y + BOTTOM_SCREEN_CAMERA_OFFSET;
        AnimatorSpriteDS__ProcessAnimationFast(aniCharacter);
        AnimatorSpriteDS__DrawFrame(aniCharacter);
    }

    s32 i;
    AnimatorSpriteDS *aniIcon = work->aniObjectiveIcons;
    for (s32 a = 0; a < 6; a++)
    {
        for (i = 0; i < work->iconCount[a]; i++)
        {
            aniIcon->position[0].x = work->characterIconPos.x + work->iconPositions[a][i].x + 72;
            aniIcon->position[0].y = work->characterIconPos.y + work->iconPositions[a][i].y + 16;
            aniIcon->position[1].x = work->characterIconPos.x + work->iconPositions[a][i].x + 72;
            aniIcon->position[1].y = work->characterIconPos.y + work->iconPositions[a][i].y + 288;
            AnimatorSpriteDS__ProcessAnimationFast(aniIcon);
            AnimatorSpriteDS__DrawFrame(aniIcon);
        }

        aniIcon++;
    }

    AnimatorSpriteDS *aniNextPrompt = &work->aniNextPrompt;
    if ((work->flags & TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE) != 0)
    {
        if (IsTouchInputEnabled() && TOUCH_HAS_ON(touchInput.flags) && work->characterIconPos.y == 0 && CHECK_NEXT_PROMPT_TOUCH(touchInput.on, aniNextPrompt->position[0]))
        {
            if (aniNextPrompt->work.animID != ADVANCEPROMPT_ANI_HELD)
                AnimatorSpriteDS__SetAnimation(aniNextPrompt, ADVANCEPROMPT_ANI_HELD);
        }
        else
        {
            if (aniNextPrompt->work.animID != ADVANCEPROMPT_ANI_PROMPTING)
                AnimatorSpriteDS__SetAnimation(aniNextPrompt, ADVANCEPROMPT_ANI_PROMPTING);
        }
    }
    else
    {
        if (aniNextPrompt->work.animID != ADVANCEPROMPT_ANI_DISABLED)
            AnimatorSpriteDS__SetAnimation(aniNextPrompt, ADVANCEPROMPT_ANI_DISABLED);
    }

    if (!work->characterIconPos.y)
    {
        if ((work->flags & TUTORIAL_FLAG_SHOW_NEXT_PROMPT) != 0 && (work->flags & TUTORIAL_FLAG_HAS_DIALOG_CHOICE) == 0)
        {
            aniNextPrompt->position[0].x = work->characterIconPos.x + 224;
            aniNextPrompt->position[0].y = work->characterIconPos.y + 33;
            aniNextPrompt->position[1].x = work->characterIconPos.x + 224;
            aniNextPrompt->position[1].y = work->characterIconPos.y + 305;
            AnimatorSpriteDS__ProcessAnimationFast(aniNextPrompt);
            AnimatorSpriteDS__DrawFrame(aniNextPrompt);
        }
    }

    if ((work->sectionFlags & TUTORIAL_SECTIONFLAG_SHOW_KEY_1) != 0)
    {
        AnimatorSpriteDS__ProcessAnimationFast(work->aniKeys);
        AnimatorSpriteDS__DrawFrame(work->aniKeys);
    }

    if ((work->sectionFlags & TUTORIAL_SECTIONFLAG_SHOW_KEY_2) != 0)
    {
        AnimatorSpriteDS__ProcessAnimationFast(&work->aniKeys[1]);
        AnimatorSpriteDS__DrawFrame(&work->aniKeys[1]);
    }

    if ((work->sectionFlags & TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON) != 0)
    {
        AnimatorSpriteDS__ProcessAnimationFast(&work->aniKeys[2]);
        AnimatorSpriteDS__DrawFrameRotoZoom(&work->aniKeys[2], FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), work->promptIconAngle);
    }

    if ((work->sectionFlags & TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT) != 0)
    {
        VecFx32 position;
        VecU16 direction;

        StageDisplayFlags displayFlag = DISPLAY_FLAG_DISABLE_SCALE | DISPLAY_FLAG_DISABLE_LOOPING;

        s16 x = work->aniKeys[2].position[0].x;
        s16 y = work->aniKeys[2].position[0].y;

        position.x = work->promptIconPos.x;
        position.y = work->promptIconPos.y;
        position.z = FLOAT_TO_FX32(0.0);

        direction.x = direction.y = FLOAT_DEG_TO_IDX(0.0);
        direction.z               = FLOAT_DEG_TO_IDX(90.0);

        work->aniKeys[2].flags &= ~ANIMATORSPRITEDS_FLAG_DISABLE_B;
        StageTask__Draw2DEx(&work->aniKeys[2], &position, &direction, NULL, &displayFlag, NULL, NULL);
        work->aniKeys[2].flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

        work->aniKeys[2].position[0].x = x;
        work->aniKeys[2].position[0].y = y;
    }
}

// Scroll States & actions
void UpdateTutorialBounds(Tutorial *work, fx32 nextSectionWidth)
{
    MapSysCamera *cameraA = &mapCamera.camera[0];
    MapSysCamera *cameraB = &mapCamera.camera[1];

    if (work->boundsL == FLOAT_TO_FX32(8.0))
    {
        work->boundsL = FLOAT_TO_FX32(0.0);
        work->boundsR -= FLOAT_TO_FX32(8.0);
    }

    work->boundsL = work->boundsR;
    work->boundsR += nextSectionWidth;

    if (work->boundsR > FX32_FROM_WHOLE(mapCamera.camControl.width - 8))
        work->boundsR = FX32_FROM_WHOLE(mapCamera.camControl.width - 8);

    cameraA->boundsL = cameraA->disp_pos.x;
    cameraB->boundsL = cameraB->disp_pos.x;
    cameraA->boundsR = cameraA->disp_pos.x + FLOAT_TO_FX32(HW_LCD_WIDTH);
    cameraB->boundsR = cameraB->disp_pos.x + FLOAT_TO_FX32(HW_LCD_WIDTH);

    gPlayer->gimmickFlag |= PLAYER_GIMMICK_8000000;
    gPlayer->gimmickMapLimitTop = FX32_TO_WHOLE(work->boundsR);

    work->stateScroll = Tutorial_StateScroll_Scrolling;
}

void Tutorial_StateScroll_Scrolling(Tutorial *work)
{
    MapSysCamera *cameraA = &mapCamera.camera[0];
    MapSysCamera *cameraB = &mapCamera.camera[1];

    cameraA->boundsL += FLOAT_TO_FX32(8.0);
    cameraA->boundsR += FLOAT_TO_FX32(8.0);

    if (cameraA->boundsL >= work->boundsL)
    {
        cameraA->boundsL = work->boundsL;
        cameraA->boundsR = work->boundsR;

        work->stateScroll = NULL;
    }

    cameraB->boundsL = cameraA->boundsL;
    cameraB->boundsR = cameraA->boundsR;

    gPlayer->gimmickMapLimitLeft = FX32_TO_WHOLE(cameraA->boundsL);
}

// Talk States & actions
void Tutorial_Action_Init(Tutorial *work)
{
    if (GetSysEventList()->currentEventID != SYSEVENT_STAGE_ACTIVE)
    {
        work->stateTalk = Tutorial_StateTalk_WaitForEventChange;
    }
    else
    {
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));
        work->stateTalk = Tutorial_StateTalk_WaitForFadeIn;
        mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_DISABLE_CAM_LOOK;
    }
}

void Tutorial_StateTalk_WaitForEventChange(Tutorial *work)
{
    if (GetSysEventList()->currentEventID == SYSEVENT_STAGE_ACTIVE)
    {
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));

        work->stateTalk = Tutorial_StateTalk_WaitForFadeIn;

        gPlayer->objWork.groundVel  = FLOAT_TO_FX32(0.0);
        gPlayer->objWork.velocity.x = gPlayer->objWork.velocity.y = gPlayer->objWork.groundVel;

        gPlayer->gimmickFlag |= PLAYER_GIMMICK_8000000;
        mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_DISABLE_CAM_LOOK;
    }
}

void Tutorial_StateTalk_WaitForFadeIn(Tutorial *work)
{
    if (IsDrawFadeTaskFinished())
        Tutorial_Action_ShowWindowForIntro(work);
}

void Tutorial_Action_ShowWindowForIntro(Tutorial *work)
{
    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator[0], 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator[0]);

    work->stateTalk = Tutorial_StateTalk_ShowWindowForIntro;
    work->flags |= TUTORIAL_FLAG_SHOW_DIALOG_WINDOW;
}

void Tutorial_StateTalk_ShowWindowForIntro(Tutorial *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator[0]);
    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator[0]))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator[0]);

        work->flags |= TUTORIAL_FLAG_SHOW_CHARACTER_ICON | TUTORIAL_FLAG_SHOW_NEXT_PROMPT;
        if (!SaveGame__HasBeatenTutorial())
        {
            work->sectionID = TUTORIAL_SECTION_INTRO;
            Tutorial_Action_IntroDialog(work);
        }
        else
        {
            work->sectionID = TUTORIAL_SECTION_INTRO_RETRY;
            ObjDrawReleaseSprite(124);

            Tutorial_Action_ActivateCheckpoint(work, 0, FX32_FROM_WHOLE(work->gameWork.mapObjectParam_nextSectionWidth << 6),
                                               FX32_FROM_WHOLE(work->gameWork.mapObjectParam_promptPosX << 3),
                                               work->gameWork.objWork.position.y - FX32_FROM_WHOLE(work->gameWork.mapObjectParam_promptPosY << 3));
        }
    }
}

void Tutorial_Action_IntroDialog(Tutorial *work)
{
    work->stateTalk = Tutorial_StateTalk_IntroDialog;
}

void Tutorial_StateTalk_IntroDialog(Tutorial *work)
{
    if (FontAnimator__IsEndOfLine(&work->fontAnimator))
    {
        work->flags |= TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;

        if (CheckAdvancePress(work))
        {
            work->flags &= ~TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;

            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);
            FontAnimator__SetMsgSequence(&work->fontAnimator, TUTORIAL_MSGSEQ_YES_NO);
            FontAnimator__LoadCharacters(&work->fontAnimator, 0);

            work->stateTalk = Tutorial_StateTalk_PracticeSelection;
            work->flags |= TUTORIAL_FLAG_HAS_DIALOG_CHOICE;
        }
    }
}

void Tutorial_StateTalk_PracticeSelection(Tutorial *work)
{
    if (work->field_D08 != 0)
    {
        work->field_D08--;
        if (work->field_D08 == 0)
        {
            ObjDrawReleaseSprite(124);
            work->flags &= ~TUTORIAL_FLAG_HAS_DIALOG_CHOICE;

            switch (work->selection)
            {
                case 0: // Yes
                    Tutorial_Action_ActivateCheckpoint(work, 0, FX32_FROM_WHOLE(work->gameWork.mapObjectParam_nextSectionWidth << 6),
                                                       FX32_FROM_WHOLE(work->gameWork.mapObjectParam_promptPosX << 3),
                                                       work->gameWork.objWork.position.y - FX32_FROM_WHOLE(work->gameWork.mapObjectParam_promptPosY << 3));

                    Tutorial_Action_FinishSection(work);
                    break;

                // case 1:
                default: // No
                    work->stateTalk = Tutorial_StateTalk_SkipTutorialTalk;
                    FontAnimator__SetMsgSequence(&work->fontAnimator, TUTORIAL_MSGSEQ_GOOD_LUCK_SONIC);
                    break;
            }

            return;
        }
    }
    else
    {
        if (IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags) != 0 && touchInput.push.x >= 64 && touchInput.push.x <= 248 && touchInput.push.y >= 8
            && touchInput.push.y <= 40)
        {
            if (touchInput.push.y < 24)
            {
                if (work->selection != 0)
                    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);

                work->selection = 0;
            }
            else
            {
                if (work->selection != 1)
                    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);

                work->selection = 1;
            }
        }
        else if ((padInput.btnPress & PAD_BUTTON_A) != 0
                 || IsTouchInputEnabled() && TOUCH_HAS_PULL(touchInput.flags) != 0 && touchInput.pull.x >= 64 && touchInput.pull.x <= 248
                        && ((work->selection == 0 && touchInput.pull.y >= 8 && touchInput.pull.y <= 24)
                            || (work->selection == 1 && touchInput.pull.y >= 24 && touchInput.pull.y <= 40)))
        {
            FontWindowMWControl__SetPaletteAnim(&work->fontMWControl, 1);
            work->field_D08 = 30;
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_T_DECIDE);
        }
        else if ((padInput.btnPress & (PAD_KEY_DOWN | PAD_KEY_UP)) != 0)
        {
            work->selection ^= 1;
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);
        }
    }

    FontWindowMWControl__SetPosition(&work->fontMWControl, 64, 16 * work->selection + 8);
    FontWindowMWControl__Draw(&work->fontMWControl);
    FontWindowMWControl__CallWindowFunc2(&work->fontMWControl);
}

void Tutorial_StateTalk_SkipTutorialTalk(Tutorial *work)
{
    if (FontAnimator__IsLastDialog(&work->fontAnimator))
    {
        if (CheckAdvancePress(work))
        {
            work->flags &= ~(TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE | TUTORIAL_FLAG_SHOW_CHARACTER_ICON | TUTORIAL_FLAG_SHOW_NEXT_PROMPT);

            FontWindowAnimator__InitAnimation(work->fontWindowAnimator, 4, 8, 0, 0);
            FontWindowAnimator__StartAnimating(work->fontWindowAnimator);
            work->stateTalk = Tutorial_StateTalk_SkipTutorial;
        }
        else
        {
            work->flags |= TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;
        }
    }
}

void Tutorial_StateTalk_SkipTutorial(Tutorial *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator[0]);
    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator[0]))
    {
        MapSysCamera *cameraA = &mapCamera.camera[0];
        MapSysCamera *cameraB = &mapCamera.camera[1];

        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator[0]);

        work->flags &= ~TUTORIAL_FLAG_SHOW_DIALOG_WINDOW;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SKIPPED;

        cameraA->boundsL = FLOAT_TO_FX32(8.0);
        cameraB->boundsL = FLOAT_TO_FX32(8.0);
        cameraA->boundsR = FX32_FROM_WHOLE(mapCamera.camControl.width - 8);
        cameraB->boundsR = FX32_FROM_WHOLE(mapCamera.camControl.width - 8);

        gPlayer->gimmickMapLimitLeft = 8;
        gPlayer->gimmickMapLimitTop  = FX32_TO_WHOLE(FX32_FROM_WHOLE(mapCamera.camControl.width - 8));
        gPlayer->playerFlag &= ~(PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_DISABLE_TENSION_DRAIN);

        work->stateScroll    = NULL;
        work->stateTalk      = NULL;
        work->statePlayer    = NULL;
        work->stateBtnPrompt = NULL;
    }
}

void Tutorial_Action_ActivateCheckpoint(Tutorial *work, s32 id, fx32 nextSectionWidth, fx32 promptPosX, fx32 promptPosY)
{
    if (id >= TUTORIAL_SECTION_COUNT)
        id = 0;

    work->nextSection      = id;
    work->nextSectionWidth = nextSectionWidth;

    gPlayer->objWork.velocity.x = gPlayer->objWork.groundVel = FLOAT_TO_FX32(0.0);
    gPlayer->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    gPlayer->inputLock = TRUE;

    if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Roll) || StageTaskStateMatches(&gPlayer->objWork, Player__State_Spindash))
        gPlayer->actionGroundIdle(gPlayer);

    work->statePlayer    = NULL;
    work->stateBtnPrompt = NULL;
    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;

    if (promptPosX == 0)
    {
        work->promptIconPos.x = work->promptIconPos.y = 0;
    }
    else
    {
        work->promptIconPos.x = work->boundsR + promptPosX;
        work->promptIconPos.y = promptPosY;
    }

    if (work->characterIconPos.y < 0)
    {
        work->stateTalk = Tutorial_StateTalk_FinishedSection_ShowCharacter;
        FontAnimator__ClearPixels(&work->fontAnimator);
    }
    else
    {
        FontAnimator__SetMsgSequence(&work->fontAnimator, sectionList[work->sectionID].seqFinish);
        MI_CpuClear8(work->iconCount, sizeof(work->iconCount));
        work->gameWork.objWork.userTimer = 0;

        work->stateTalk = Tutorial_StateTalk_Talking;
    }
}

void Tutorial_StateTalk_FinishedSection_ShowCharacter(Tutorial *work)
{
    work->characterIconPos.y += 16;
    if (work->characterIconPos.y >= 0)
    {
        work->characterIconPos.y = 0;

        FontAnimator__SetMsgSequence(&work->fontAnimator, sectionList[work->sectionID].seqFinish);
        MI_CpuClear8(work->iconCount, sizeof(work->iconCount));

        work->stateTalk = Tutorial_StateTalk_Talking;
    }
}

void Tutorial_StateTalk_Talking(Tutorial *work)
{
    if (FontAnimator__IsLastDialog(&work->fontAnimator) == FALSE)
        return;

    work->flags |= TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;

    if (CheckAdvancePress(work))
    {
        work->flags &= ~TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);
        Tutorial_Action_FinishSection(work);
    }
}

void Tutorial_Action_FinishSection(Tutorial *work)
{
    work->sectionID   = work->nextSection;
    work->nextSection = -1;
    FontAnimator__SetMsgSequence(&work->fontAnimator, sectionList[work->sectionID].seqStart);

    MI_CpuClear8(work->iconCount, sizeof(work->iconCount));
    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_COMPLETE;

    UpdateTutorialBounds(work, work->nextSectionWidth);
    work->statePlayer = Tutorial_StatePlayer_MoveToNewBounds;
    work->stateTalk   = Tutorial_StateTalk_FinishSection;
}

void Tutorial_StateTalk_FinishSection(Tutorial *work)
{
    if (FontAnimator__IsLastDialog(&work->fontAnimator) == FALSE)
        return;

    work->flags |= TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;

    if (CheckAdvancePress(work))
    {
        if (work->stateScroll == NULL && work->statePlayer == NULL)
        {
            work->flags &= ~TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);

            if (work->sectionID == TUTORIAL_SECTION_BREAKABLE)
            {
                work->stateTalk = Tutorial_StateTalk_CloseWindowForFinishSection;
                work->flags &= ~(TUTORIAL_FLAG_SHOW_CHARACTER_ICON | TUTORIAL_FLAG_SHOW_NEXT_PROMPT);

                FontWindowAnimator__InitAnimation(work->fontWindowAnimator, 4, 8, 0, 0);
                FontWindowAnimator__StartAnimating(work->fontWindowAnimator);
            }
            else
            {
                work->stateTalk = Tutorial_StateTalk_NextSection;
            }
        }
    }
}

void Tutorial_StateTalk_NextSection(Tutorial *work)
{
    work->characterIconPos.y -= 16;
    if (work->characterIconPos.y <= -BOTTOM_SCREEN_CAMERA_OFFSET)
    {
        work->characterIconPos.y = -BOTTOM_SCREEN_CAMERA_OFFSET;

        gPlayer->playerFlag &= ~(PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_DISABLE_TENSION_DRAIN);

        work->statePlayer       = sectionList[work->sectionID].statePlayer;
        work->playerActionFlags = TUTORIAL_PLAYERACTION_NONE;
        work->stateBtnPrompt    = sectionList[work->sectionID].stateBtnPrompt;
        work->stateTalk         = NULL;
    }
}

void Tutorial_StateTalk_CloseWindowForFinishSection(Tutorial *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator[0]);
    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator[0]))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator[0]);

        work->flags &= ~TUTORIAL_FLAG_SHOW_DIALOG_WINDOW;
        gPlayer->playerFlag &= ~(PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        work->statePlayer       = sectionList[work->sectionID].statePlayer;
        work->playerActionFlags = TUTORIAL_PLAYERACTION_NONE;
        work->stateTalk         = NULL;
    }
}

void Tutorial_Action_FinishedStage(Tutorial *work)
{
    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator[0], 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator[0]);

    work->characterIconPos.y = 0;
    work->flags |= TUTORIAL_FLAG_SHOW_DIALOG_WINDOW;
    work->stateTalk = Tutorial_StateTalk_ShowWindowForFinishedStage;
}

void Tutorial_StateTalk_ShowWindowForFinishedStage(Tutorial *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator[0]);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator[0]))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator[0]);
        FontAnimator__SetMsgSequence(&work->fontAnimator, TUTORIAL_MSGSEQ_LOOKS_LIKE_YOU_GOT_HANG_OF_IT);

        work->flags |= TUTORIAL_FLAG_SHOW_CHARACTER_ICON | TUTORIAL_FLAG_SHOW_NEXT_PROMPT;
        work->gameWork.objWork.userTimer = 0;
        work->stateTalk                  = Tutorial_StateTalk_FinishedStage;
    }
}

void Tutorial_StateTalk_FinishedStage(Tutorial *work)
{
    if (FontAnimator__IsLastDialog(&work->fontAnimator))
    {
        work->gameWork.objWork.userTimer++;
        if (work->gameWork.objWork.userTimer >= 120)
        {
            work->flags &= ~TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);
            FontAnimator__ClearPixels(&work->fontAnimator);
            FontWindowAnimator__InitAnimation(&work->fontWindowAnimator[0], 4, 8, 0, 0);
            FontWindowAnimator__StartAnimating(&work->fontWindowAnimator[0]);
            work->flags &= ~(TUTORIAL_FLAG_SHOW_CHARACTER_ICON | TUTORIAL_FLAG_SHOW_NEXT_PROMPT);
            work->stateTalk = Tutorial_StateTalk_CloseWindowForFinishedStage;
        }
    }
}

void Tutorial_StateTalk_CloseWindowForFinishedStage(Tutorial *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator[0]);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator[0]))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator[0]);
        work->flags &= ~TUTORIAL_FLAG_SHOW_DIALOG_WINDOW;
        work->stateTalk = NULL;
    }
}

void Tutorial_StatePlayer_MoveToNewBounds(Tutorial *work)
{
    if (gPlayer->objWork.position.x < work->boundsL + FLOAT_TO_FX32(16.0))
    {
        gPlayer->inputKeyDown = PAD_KEY_RIGHT;
    }
    else
    {
        work->statePlayer = NULL;

        gPlayer->inputKeyDown       = PAD_INPUT_NONE_MASK;
        gPlayer->objWork.velocity.x = 0;
    }
}

void Tutorial_StatePlayer_CheckJumped(Tutorial *work)
{
    if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Air))
        work->playerActionFlags |= TUTORIAL_PLAYERACTION_JUMP;

    if ((work->playerActionFlags & (TUTORIAL_PLAYERACTION_ENEMY_DESTROY | TUTORIAL_PLAYERACTION_JUMP)) == (TUTORIAL_PLAYERACTION_ENEMY_DESTROY | TUTORIAL_PLAYERACTION_JUMP))
    {
        work->statePlayer = NULL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_COMPLETE;
    }
}

void Tutorial_StatePlayer_CheckJumpDashed(Tutorial *work)
{
    if (gPlayer->actionState == PLAYER_ACTION_JUMPDASH_01)
        work->playerActionFlags |= TUTORIAL_PLAYERACTION_JUMPDASH;

    if ((work->playerActionFlags & TUTORIAL_PLAYERACTION_JUMPDASH) == TUTORIAL_PLAYERACTION_JUMPDASH)
    {
        work->statePlayer = NULL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_COMPLETE;
    }
}

void Tutorial_StatePlayer_CheckSpindashed(Tutorial *work)
{
    if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Roll))
        work->playerActionFlags |= TUTORIAL_PLAYERACTION_SPINDASH;

    if ((work->playerActionFlags & TUTORIAL_PLAYERACTION_SPINDASH) == TUTORIAL_PLAYERACTION_SPINDASH)
    {
        work->statePlayer = NULL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_COMPLETE;
    }
}

void Tutorial_StatePlayer_CheckTrickFinished(Tutorial *work)
{
    if (gPlayer->actionState == PLAYER_ACTION_TRICK_FINISH)
        work->playerActionFlags |= TUTORIAL_PLAYERACTION_TRICK_FINISH;

    if ((work->playerActionFlags & TUTORIAL_PLAYERACTION_TRICK_FINISH) == TUTORIAL_PLAYERACTION_TRICK_FINISH)
    {
        work->statePlayer = NULL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_COMPLETE;
    }
}

void Tutorial_StatePlayer_CheckStageFinished(Tutorial *work)
{
    if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) != 0)
    {
        work->statePlayer = NULL;

        Tutorial_Action_FinishedStage(work);
    }
}

// Button Prompt States
void Tutorial_StatePrompt_Move_Init(Tutorial *work)
{
    work->timer = 0;
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_RIGHT);

    work->aniKeys[0].position[0].x = 128;
    work->aniKeys[0].position[0].y = 48;
    work->aniKeys[2].position[0].x = promptPositions[2].x + 128;
    work->aniKeys[2].position[0].y = promptPositions[2].y + 48;
    work->promptIconAngle          = promptAngles[2];

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_1;

    work->stateBtnPrompt = Tutorial_StatePrompt_Move_Active;
    Tutorial_StatePrompt_Move_Active(work);
}

void Tutorial_StatePrompt_Move_Active(Tutorial *work)
{
    work->timer++;
    if (work->timer >= 30)
    {
        work->timer = 0;

        u16 anim = TUTORIALPROMPT_ANI_DPAD_LEFT;
        if (work->aniKeys[0].work.animID == TUTORIALPROMPT_ANI_DPAD_LEFT)
            anim = TUTORIALPROMPT_ANI_DPAD_RIGHT;

        AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], anim);
        work->aniKeys[2].position[0].x = work->aniKeys[0].position[0].x + promptPositions[anim - 1].x;
        work->aniKeys[2].position[0].y = work->aniKeys[0].position[0].y + promptPositions[anim - 1].y;
        work->promptIconAngle          = promptAngles[anim - 1];
    }
}

void Tutorial_StatePrompt_MoveLoop_Init(Tutorial *work)
{
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_RIGHT);

    work->aniKeys[0].position[0].x = 128;
    work->aniKeys[0].position[0].y = 48;
    work->aniKeys[2].position[0].x = promptPositions[2].x + 128;
    work->aniKeys[2].position[0].y = promptPositions[2].y + 48;
    work->promptIconAngle          = promptAngles[2];

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_1;

    work->stateBtnPrompt = Tutorial_StatePrompt_MoveLoop_Active;
    Tutorial_StatePrompt_MoveLoop_Active(work);
}

void Tutorial_StatePrompt_MoveLoop_Active(Tutorial *work)
{
    // Nothin'
}

void Tutorial_StatePrompt_Jump_Init(Tutorial *work)
{
    work->timer = 0;
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_B);

    work->aniKeys[1].position[0].x = 128;
    work->aniKeys[1].position[0].y = 48;

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_KEY_2;

    work->stateBtnPrompt = Tutorial_StatePrompt_Jump_Active;
    Tutorial_StatePrompt_Jump_Active(work);
}

void Tutorial_StatePrompt_Jump_Active(Tutorial *work)
{
    // Nothin'
}

void Tutorial_StatePrompt_JumpDash_Init(Tutorial *work)
{
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_B);

    work->aniKeys[1].position[0].x = 128;
    work->aniKeys[1].position[0].y = 48;

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_KEY_2;

    work->stateBtnPrompt = Tutorial_StatePrompt_JumpDash_Active;
    Tutorial_StatePrompt_JumpDash_Active(work);
}

void Tutorial_StatePrompt_JumpDash_Active(Tutorial *work)
{
    if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Air) && work->aniKeys[1].work.animID != TUTORIALPROMPT_ANI_BTN_R)
    {
        AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_R);
    }
    else if (!StageTaskStateMatches(&gPlayer->objWork, Player__State_Air) && work->aniKeys[1].work.animID != TUTORIALPROMPT_ANI_BTN_B)
    {
        AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_B);
    }
}

void Tutorial_StatePrompt_SpindashCharge_Init(Tutorial *work)
{
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_DOWN);
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_B);

    work->aniKeys[0].position[0].x = 128;
    work->aniKeys[0].position[0].y = 48;
    work->aniKeys[2].position[0].x = promptPositions[3].x + 128;
    work->aniKeys[2].position[0].y = promptPositions[3].y + 48;
    work->aniKeys[1].position[0].x = 156;
    work->aniKeys[1].position[0].y = 48;
    work->promptIconAngle          = promptAngles[3];

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_1;

    work->stateBtnPrompt = Tutorial_StatePrompt_SpindashCharge_Active;
    Tutorial_StatePrompt_SpindashCharge_Active(work);
}

void Tutorial_StatePrompt_SpindashCharge_Active(Tutorial *work)
{
    if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Crouch))
    {
        if ((work->sectionFlags & TUTORIAL_SECTIONFLAG_SHOW_KEY_2) == 0)
        {
            work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_KEY_2;
            work->aniKeys[0].position[0].x = 100;
            work->aniKeys[2].position[0].x = promptPositions[3].x + 100;
        }
    }
    else if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Spindash))
    {
        if (work->aniKeys[0].work.animID != TUTORIALPROMPT_ANI_DPAD_IDLE)
        {
            work->sectionFlags &= ~(TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_2);
            AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_IDLE);
            work->aniKeys[0].position[0].x = 128;
        }
    }
    else if (StageTaskStateMatches(&gPlayer->objWork, Player__State_Roll))
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    }
    else if ((work->sectionFlags & TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL) != (TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_1))
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_1;

        AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_DOWN);
        work->aniKeys[0].position[0].x = 128;
        work->aniKeys[2].position[0].x = promptPositions[3].x + 128;
    }
}

void Tutorial_StatePrompt_Trick_Init(Tutorial *work)
{
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_B);
    work->aniKeys[1].position[0].x = 128;
    work->aniKeys[1].position[0].y = 48;

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;

    work->stateBtnPrompt = Tutorial_StatePrompt_Trick_Active;
    Tutorial_StatePrompt_Trick_Active(work);
}

void Tutorial_StatePrompt_Trick_Active(Tutorial *work)
{
    if (gPlayer->actionState >= PLAYER_ACTION_TRICK_SUCCESS1 && gPlayer->actionState <= PLAYER_ACTION_TRICK_SUCCESS2)
    {
        if (work->aniKeys[1].work.animID != TUTORIALPROMPT_ANI_BTN_A)
        {
            work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
            work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_KEY_2;

            AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_A);
        }
    }
    else if (gPlayer->actionState == PLAYER_ACTION_TRICK_FINISH)
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    }
    else if (gPlayer->actionState >= PLAYER_ACTION_AIRRISE && gPlayer->actionState <= PLAYER_ACTION_AIRFALL_02)
    {
        if (work->aniKeys[1].work.animID != TUTORIALPROMPT_ANI_BTN_B)
            AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_B);

        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_KEY_2;
    }
    else
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
    }
}

void Tutorial_StatePrompt_HopJump_Init(Tutorial *work)
{
    work->timer = 0;
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_UP);
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_R);

    work->aniKeys[1].position[0].x = 156;
    work->aniKeys[1].position[0].y = 48;
    work->aniKeys[2].position[0].x = promptPositions[1].x + 100;
    work->aniKeys[2].position[0].y = promptPositions[1].y + 48;
    work->aniKeys[0].position[0].x = 100;
    work->aniKeys[0].position[0].y = 48;
    work->promptIconAngle          = promptAngles[1];

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;

    work->stateBtnPrompt = Tutorial_StatePrompt_HopJump_Active;
    Tutorial_StatePrompt_HopJump_Active(work);
}

void Tutorial_StatePrompt_HopJump_Active(Tutorial *work)
{
    if (gPlayer->actionState >= PLAYER_ACTION_TRICK_FINISH_V_01 && gPlayer->actionState <= PLAYER_ACTION_TRICK_FINISH_V_04)
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    }
    else if (gPlayer->actionState >= PLAYER_ACTION_AIRRISE && gPlayer->actionState <= PLAYER_ACTION_AIRFALL_02)
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_2 | TUTORIAL_SECTIONFLAG_SHOW_KEY_1;
    }
    else
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
    }
}

void Tutorial_StatePrompt_HummingTop_Init(Tutorial *work)
{
    work->timer = 0;
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_UP);
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_R);

    work->aniKeys[1].position[0].x = 128;
    work->aniKeys[1].position[0].y = 48;

    work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;

    work->stateBtnPrompt = Tutorial_StatePrompt_HummingTop_Active;
    Tutorial_StatePrompt_HummingTop_Active(work);
}

void Tutorial_StatePrompt_HummingTop_Active(Tutorial *work)
{
    if (gPlayer->actionState >= PLAYER_ACTION_TRICK_FINISH_H_01 && gPlayer->actionState <= PLAYER_ACTION_TRICK_FINISH_H_02)
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
    }
    else if (gPlayer->actionState >= PLAYER_ACTION_AIRRISE && gPlayer->actionState <= PLAYER_ACTION_AIRFALL_02)
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_KEY_2;
    }
    else
    {
        work->sectionFlags &= ~TUTORIAL_SECTIONFLAG_SHOW_KEY_ALL;
        work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON_ALT;
    }
}

void Tutorial_StatePrompt_Boost_Init(Tutorial *work)
{
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[0], TUTORIALPROMPT_ANI_DPAD_RIGHT);
    AnimatorSpriteDS__SetAnimation(&work->aniKeys[1], TUTORIALPROMPT_ANI_BTN_Y);

    work->aniKeys[1].position[0].x = 156;
    work->aniKeys[1].position[0].y = 48;
    work->aniKeys[2].position[0].x = promptPositions[2].x + 100;
    work->aniKeys[2].position[0].y = promptPositions[2].y + 48;
    work->aniKeys[0].position[0].x = 100;
    work->aniKeys[0].position[0].y = 48;
    work->promptIconAngle          = promptAngles[2];

    work->sectionFlags |= TUTORIAL_SECTIONFLAG_SHOW_PROMPT_ICON | TUTORIAL_SECTIONFLAG_SHOW_KEY_2 | TUTORIAL_SECTIONFLAG_SHOW_KEY_1;

    work->stateBtnPrompt = Tutorial_StatePrompt_Boost_Active;
    Tutorial_StatePrompt_Boost_Active(work);
}

void Tutorial_StatePrompt_Boost_Active(Tutorial *work)
{
    // Nothin'
}

// Misc
void HandleTutorialNextPrompt(Tutorial *work)
{
    if ((work->flags & TUTORIAL_FLAG_SHOW_NEXT_PROMPT) != 0)
    {
        if (!FontAnimator__IsLastDialog(&work->fontAnimator))
        {
            work->flags &= ~TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;

            if (FontAnimator__IsEndOfLine(&work->fontAnimator))
            {
                if ((work->flags & TUTORIAL_FLAG_AUTO_ADVANCE_DIALOG) != 0)
                {
                    FontAnimator__AdvanceDialog(&work->fontAnimator);
                    MI_CpuClear8(work->iconCount, sizeof(work->iconCount));
                }
                else
                {
                    if (CheckAdvancePress(work))
                    {
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTTON);
                        FontAnimator__AdvanceDialog(&work->fontAnimator);
                        MI_CpuClear8(work->iconCount, sizeof(work->iconCount));
                    }
                    else
                    {
                        work->flags |= TUTORIAL_FLAG_ALLOW_DIALOG_ADVANCE;
                    }
                }
            }
            else
            {
                u16 id = 1;
                if ((padInput.btnPress & PAD_BUTTON_A) != 0)
                    id = 0;

                FontAnimator__LoadCharacters(&work->fontAnimator, id);
            }
        }

        s16 x = work->characterIconPos.x;
        s16 y = work->characterIconPos.y;
        if (x <= -HW_LCD_WIDTH || x >= HW_LCD_WIDTH || y < -64 || y >= HW_LCD_HEIGHT)
        {
            FontAnimator__EnableFlags(&work->fontAnimator, 0x40);
        }
        else
        {
            FontAnimator__DisableFlags(&work->fontAnimator, 0x40);
            FontAnimator__SetSpriteStartPos(&work->fontAnimator, x, y);
        }

        y += BOTTOM_SCREEN_CAMERA_OFFSET;
        if (x <= -HW_LCD_WIDTH || x >= HW_LCD_WIDTH || y < -64 || y >= HW_LCD_HEIGHT)
        {
            FontUnknown2058D78__EnableFlags(&work->fontUnknown, 0x40);
        }
        else
        {
            FontUnknown2058D78__DisableFlags(&work->fontUnknown, 0x40);
            FontUnknown2058D78__Func_2058F2C(&work->fontUnknown, x, y);
        }

        FontAnimator__Draw(&work->fontAnimator);
    }
}

void TutorialFontCallback(u32 id, FontAnimator *animator, void *userData)
{
    Tutorial *work = (Tutorial *)userData;

    if (id == 10)
    {
        s32 count = work->iconCount[0];
        if (count < 2)
        {
            FontAnimator__GetMsgPosition(animator, &work->iconPositions[0][count].x, &work->iconPositions[0][count].y);
            FontAnimator__AdvanceXPos(animator, 16);
            work->iconCount[0]++;
        }
    }
    else if (id >= 16 && id <= 20)
    {
        s32 iconID = id - 15;
        s32 count  = work->iconCount[iconID];
        if (count < 2)
        {
            FontAnimator__GetMsgPosition(animator, &work->iconPositions[iconID][count].x, &work->iconPositions[iconID][count].y);
            FontAnimator__AdvanceXPos(animator, 16);
            work->iconCount[iconID]++;
        }
    }
    else
    {
        u16 anim;
        switch (id)
        {
            case 11:
                anim = TUTORIALCHARACTER_ANI_SONIC;
                break;

            default:
                anim = TUTORIALCHARACTER_ANI_TAILS_1;
                break;

            case 13:
                anim = TUTORIALCHARACTER_ANI_TAILS_2;
                break;

            case 14:
                anim = TUTORIALCHARACTER_ANI_TAILS_3;
                break;

            case 15:
                anim = TUTORIALCHARACTER_ANI_TAILS_4;
                break;
        }

        if (work->gameWork.objWork.obj_2d->ani.work.animID == TUTORIALCHARACTER_ANI_SONIC && anim != TUTORIALCHARACTER_ANI_SONIC)
        {
            ObjDrawReleaseSprite(126);
            ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, 125);
        }
        else if (work->gameWork.animator.ani.work.animID != TUTORIALCHARACTER_ANI_SONIC && anim == TUTORIALCHARACTER_ANI_SONIC)
        {
            ObjDrawReleaseSprite(125);
            ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, 126);
        }

        StageTask__SetAnimation(&work->gameWork.objWork, anim);
    }
}

// TutorialCheckpoint
void TutorialCheckpoint_State_Active(TutorialCheckpoint *work)
{
    if (CheckTutorialInactive())
    {
        DestroyStageTask(&work->gameWork.objWork);
    }
    else
    {
        if (sVars.activeTutorial != NULL)
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) != 0 && (sVars.activeTutorial->sectionFlags & TUTORIAL_SECTIONFLAG_COMPLETE) != 0)
            {
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
                work->gameWork.colliders[0].parent = &work->gameWork.objWork;
                work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            }
        }

        if (work->gameWork.objWork.obj_2d->ani.work.animID == CHECKPOINT_ANI_ACTIVATING && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            StageTask__SetAnimation(&work->gameWork.objWork, CHECKPOINT_ANI_ACTIVATED);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }
}

void TutorialCheckpoint_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    TutorialCheckpoint *checkpoint = (TutorialCheckpoint *)rect2->parent;
    Player *player                 = (Player *)rect1->parent;

    if (CheckTutorialInactive())
        return;

    if (checkpoint == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (sVars.activeTutorial == NULL)
        return;

    checkpoint->gameWork.colliders[0].parent = NULL;
    checkpoint->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    Tutorial_Action_ActivateCheckpoint(sVars.activeTutorial, checkpoint->gameWork.mapObjectParam_id, FX32_FROM_WHOLE(checkpoint->gameWork.mapObjectParam_nextSectionWidth << 6),
                                       FX32_FROM_WHOLE(checkpoint->gameWork.mapObjectParam_promptPosX << 3),
                                       checkpoint->gameWork.objWork.position.y - FX32_FROM_WHOLE(checkpoint->gameWork.mapObjectParam_promptPosY << 3));

    StageTask__SetAnimation(&checkpoint->gameWork.objWork, CHECKPOINT_ANI_ACTIVATING);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CHECK_POINT);
}
