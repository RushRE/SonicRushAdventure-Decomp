#ifndef RUSH_CUTSCENESCRIPT_H
#define RUSH_CUTSCENESCRIPT_H

#include <game/system/task.h>
#include <game/cutscene/script.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindow.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/input/touchField.h>

// --------------------
// TYPES
// --------------------

// forward decls.
typedef struct CutsceneScript_ CutsceneScript;
typedef struct ScriptThread_ ScriptThread;

typedef struct ScriptCommand_ ScriptCommand;
typedef struct ScriptParam1_ ScriptParam1;
typedef struct ScriptParam2_ ScriptParam2;

typedef u32 CutsceneScriptResult;

typedef struct CutsceneFader_ CutsceneFader;
typedef struct CutsceneArchive_ CutsceneArchive;
typedef struct CutsceneTouchArea_ CutsceneTouchArea;
typedef struct CutsceneSpriteButton_ CutsceneSpriteButton;
typedef struct CutsceneBackground_ CutsceneBackground;
typedef struct CutsceneCamera3D_ CutsceneCamera3D;
typedef struct CutsceneModel_ CutsceneModel;
typedef struct CutsceneAudioHandle_ CutsceneAudioHandle;
typedef struct CutsceneTextWorker_ CutsceneTextWorker;

typedef struct CutsceneFadeManager_ CutsceneFadeManager;
typedef struct CutsceneFileSystemManager_ CutsceneFileSystemManager;
typedef struct CutsceneSpriteButtonManager_ CutsceneSpriteButtonManager;
typedef struct CutsceneBackgroundManager_ CutsceneBackgroundManager;
typedef struct CutsceneModelManager_ CutsceneModelManager;
typedef struct CutsceneAudioManager_ CutsceneAudioManager;
typedef struct CutsceneTextManager_ CutsceneTextManager;

// types
typedef CutsceneScriptResult (*CutsceneScriptEngineCommand)(ScriptThread *thread, CutsceneScript *work);
typedef CutsceneScriptResult (*CutsceneScriptControlCommand)(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
typedef CutsceneScriptResult (*CutsceneScriptTextCommand)(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);

typedef void (*CutsceneScriptOnFinish)(CutsceneScript *work);

// --------------------
// ENUMS
// --------------------

enum CutsceneScriptRegisters
{
    CUTSCENESCRIPT_REGISTER_R0,
    CUTSCENESCRIPT_REGISTER_R1,
    CUTSCENESCRIPT_REGISTER_R2,
    CUTSCENESCRIPT_REGISTER_R3,
    CUTSCENESCRIPT_REGISTER_R4,
    CUTSCENESCRIPT_REGISTER_R5,
    CUTSCENESCRIPT_REGISTER_R6,
    CUTSCENESCRIPT_REGISTER_R7,
    CUTSCENESCRIPT_REGISTER_R8,
    CUTSCENESCRIPT_REGISTER_R9,
    CUTSCENESCRIPT_REGISTER_R10,
    CUTSCENESCRIPT_REGISTER_R11,
    CUTSCENESCRIPT_REGISTER_R12,
    CUTSCENESCRIPT_REGISTER_RESULT,
    CUTSCENESCRIPT_REGISTER_SP,
    CUTSCENESCRIPT_REGISTER_PC,
};

enum CutsceneScriptResult_
{
    CUTSCENESCRIPT_RESULT_NONE,
    CUTSCENESCRIPT_RESULT_CONTINUE,
    CUTSCENESCRIPT_RESULT_FINISH,
    CUTSCENESCRIPT_RESULT_STOP_THREADS,
    CUTSCENESCRIPT_RESULT_SUSPEND,
    CUTSCENESCRIPT_RESULT_SUSPEND_RETURN,
};

enum CutsceneScriptSection_
{
    CUTSCENESCRIPT_SECTION_DATA,
    CUTSCENESCRIPT_SECTION_STACK,
    CUTSCENESCRIPT_SECTION_ROM,
};
typedef u32 CutsceneScriptSection;

enum CutsceneScriptStatus_
{
    CUTSCENESCRIPT_STATUS_IDLE,
    CUTSCENESCRIPT_STATUS_READY,
    CUTSCENESCRIPT_STATUS_LOADING,
};
typedef u32 CutsceneScriptStatus;

// --------------------
// STRUCTS
// --------------------

struct ScriptCommand_
{
    u8 type;
    u8 param1;
    u8 param2;
    u8 _padding;
};

struct ScriptParam1_
{
    ScriptCommand command;
    s32 param1;
};

struct ScriptParam2_
{
    ScriptCommand command;
    s32 param1;
    s32 param2;
};

struct ScriptThread_
{
    s32 registers[16];
    s32 data[0x100];
    BOOL keepAlive;
};

struct CutsceneTextWorker_
{
    FontWindow fontWindow;
    FontAnimator fontAnimator;
    void *files[2];
    u32 dword17C;
    u32 dword180;
    u32 dword184;
    u32 dword188;
    u32 dword18C;
    u32 dword190;
    u8 alignment;
    s32 field_198;
};

typedef struct CutsceneFadeTaskInfo_
{
    Task *task;
} CutsceneFadeTaskInfo;

typedef struct CutsceneSystemManager_
{
    CutsceneFadeManager *fadeManager;
    CutsceneFileSystemManager *fileSystemManager;
    CutsceneSpriteButtonManager *spriteButtonManager;
    CutsceneBackgroundManager *backgroundManager;
    CutsceneModelManager *modelManager;
    CutsceneAudioManager *audioManager;
    CutsceneTextManager *textManager;
} CutsceneSystemManager;

struct CutsceneScript_
{
    struct CutsceneScriptRunner
    {
        ScriptThread *threads[8];
        u32 data[0x400];
        CutsceneScriptHeader *script;
        CutsceneScriptEngineCommand **funcTable;
        CutsceneScriptOnFinish onFinish;
    } runner;

    CutsceneScriptStatus status;
    CutsceneSystemManager systemManager;
    CutsceneFadeTaskInfo taskFade[1];
};

typedef struct CutsceneAssetSystem_
{
    Task *cutsceneTask;
    CutsceneScript *cutscene;
    CutsceneScriptHeader *script;
} CutsceneAssetSystem;

// --------------------
// FUNCTIONS
// --------------------

// CutsceneScript funcs
void CutsceneScript__Create(CutsceneAssetSystem *parent, u32 priority);
void CutsceneAssetSystem__Destroy(CutsceneAssetSystem *work);
CutsceneScript *CutsceneAssetSystem__GetCutsceneScript(CutsceneAssetSystem *work);
void CutsceneScript__InitFileSystemManager(CutsceneAssetSystem *work, u32 count);
void CutsceneScript__InitSpriteButtonManager(CutsceneAssetSystem *work, u32 count);
void CutsceneScript__InitBackgroundManager(CutsceneAssetSystem *work);
void CutsceneScript__InitModelManager(CutsceneAssetSystem *work, u32 count);
void CutsceneScript__InitAudioManager(CutsceneAssetSystem *work, u32 count);
void CutsceneScript__InitTextManager(CutsceneAssetSystem *work);
CutsceneTextWorker *CutsceneScript__GetTextWorker(CutsceneAssetSystem *work);
void CutsceneScript__LoadScript(CutsceneAssetSystem *work, CutsceneScriptHeader *script);
void CutsceneScript__StartScript(CutsceneAssetSystem *work, s32 startParam, CutsceneScriptOnFinish onFinish);
void CutsceneScript__Destructor(Task *task);
void CutsceneFadeTask__Destructor(Task *task);

// Engine Script Functions
CutsceneScriptResult CutsceneScript__SystemCommand__GetPadInputMask(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SystemCommand__GetTouchPos(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SystemCommand__GetGameLanguage(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SystemCommand__GetVCount(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SystemCommand__GetBrightness(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__InitVRAMSystem(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetupBGBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetupOBJBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetupBGExtPalBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetupOBJExtPalBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetupTextureBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetupTexturePalBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetGraphicsMode(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBackgroundControlText(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBackgroundControlAffine(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetCurrentDisplay(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__ProcessFadeTask(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__CreateFadeTask(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetVisiblePlane(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBackgroundPriority(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendPlane(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendEffect(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendAlpha(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendCoefficient(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetWindowVisible(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetWindowPlane(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetWindowPosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__Unknown(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__SetCapture(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__ShakeScreen1(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ScreenCommand__ShakeScreen2(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153C90(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153CE8(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153D10(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__MountArchive(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__UnmountArchive(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153DAC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153DDC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__LoadSprite(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2153EB4(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2153EDC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__LoadSprite2(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetAnimation(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpritePosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteVisible(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteLoopFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteFlip(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpritePriority(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteType(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2154240(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__GetSpritePosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__GetSpritePalette(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2154320(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2154384(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SpriteCommand__Func_21543AC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__BackgroundCommand__LoadBBG(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_2154494(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_21544BC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_2154504(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_215455C(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_21545B0(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__LoadMDL(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154684(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_21546AC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__LoadMDL2(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__LoadAniMDL(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_215483C(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_21548A8(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_21549E4(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154A50(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154ABC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154B10(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154B64(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154BF8(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__LoadDrawState(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154CCC(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArc(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_SetVolume(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_MoveVolume(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcGroup(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcSeq(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcSeqArc(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_PlayTrack(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_PlayTrackEx(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_PlaySequence(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_PlaySequenceEx(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_PlayVoiceClip(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_PlayVoiceClipEx(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_FadeSeq(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_FadeAllSeq(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_SetTrackPan(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__SoundCommand_SetPlayerPriority(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript__TextFunc__Execute(ScriptThread *thread, CutsceneScript *work);

void CutsceneScript__Main(void);
void CutsceneFadeTask__Main(void);
void CutsceneScript__LoadScriptFile(CutsceneScript *work, CutsceneScriptHeader *script, CutsceneScriptEngineCommand **funcTable, s32 unknown);
void CutsceneAssetSystem__Release(CutsceneScript *work);
BOOL CutsceneScript__RunThreads(CutsceneScript *work);
ScriptThread *CutsceneScript__InitScriptWorker(CutsceneScript *work, CutsceneScriptOnFinish onFinish);
ScriptThread *CutsceneScript__InitScriptThread(CutsceneScript *work, u32 pc);
CutsceneScriptSection CutsceneScript__GetAYKCommandLocation(u32 addr);
void *CutsceneScript__GetFunctionParamConstant(CutsceneScript *work, ScriptThread *thread, u32 addr);
s32 CutsceneScript__GetFunctionParamRegister(ScriptThread *thread, s32 id);
const char *CutsceneScript__GetFunctionParamString_(ScriptThread *thread, CutsceneScript *cutscene, s32 id);
const char *CutsceneScript__GetFunctionParamString(ScriptThread *thread, CutsceneScript *cutscene, s32 id);
void AYKCommand__SetRegister(ScriptThread *work, u32 id, s32 value);
CutsceneScriptResult CutsceneScript__ExecuteCommand(CutsceneScript *work, ScriptThread *thread);
s32 *CutsceneScript__GetRegister(ScriptThread *work, u32 id);
CutsceneScriptSection ovl07_2155770(u32 addr);
void *CutsceneScript__GetScriptPtr(CutsceneScript *work, ScriptThread *thread, u32 addr);
void ScriptThread__PushStack(ScriptThread *work, s32 value);
s32 ScriptThread__PopStack(ScriptThread *work);
void *CutsceneScript__GetScriptParam(s32 type, s32 *param, s32 unknown, CutsceneScript *work, ScriptThread *thread);
s32 CutsceneScript__AllocScriptThread(CutsceneScript *work, u32 pc);

// Script Control Functions
CutsceneScriptResult CutsceneScript__EndCommand_StopThreads(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__EndCommand_Continue(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__EndCommand_Suspend(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Assign(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Add(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Subtract(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Multiply(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Divide(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Negate(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Increment(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_Decrement(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ArithmeticCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_BitwiseAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_LogicalAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_BitwiseOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_LogicalOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_XOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_BitwiseNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_LogicalNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_ShiftL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_RotateL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__BitwiseCommand_RotateR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ComparisonCommand_Equal(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ComparisonCommand_NotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ComparisonCommand_Less(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ComparisonCommand_LessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ComparisonCommand_Greater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__ComparisonCommand_GreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__UnknownCommand_215636C(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__UnknownCommand_21563D8(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_Branch(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_IfEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_IfNotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_IfGreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_IfGreater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_IfLessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__IfCommand_IfLess(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__FunctionCommand_CallFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__FunctionCommand_EndFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__FunctionCommand_CallFunctionASync(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__FunctionCommand_End(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__EngineCommand_Execute(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__StackCommand_Load(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript__StackCommand_Store(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);

// Misc
CutsceneFadeManager *CutsceneScript__GetFadeManager(CutsceneSystemManager *work);
void CutsceneScript__InitFadeManager(CutsceneSystemManager *work);
void CutsceneSystemManager__Release(CutsceneSystemManager *work);

// FileSystem manager
void CutsceneFileSystemManager__Init(CutsceneSystemManager *work, u32 count);
void *CutsceneFileSystemManager__GetArchive(CutsceneSystemManager *work, s32 id);
BOOL CutsceneFileSystemManager__Func_21569A4(CutsceneSystemManager *work, s32 id);
void CutsceneFileSystemManager__Func_21569CC(CutsceneSystemManager *work, s32 value);
BOOL CutsceneFileSystemManager__Func_21569E4(CutsceneSystemManager *work);
void CutsceneFileSystemManager__Func_21569FC(CutsceneSystemManager *work, s32 value);
void CutsceneFileSystemManager__MountArchive(CutsceneSystemManager *work, s32 id, const char *arcName);
void CutsceneFileSystemManager__UnmountArchive(CutsceneSystemManager *work, s32 id);
s32 CutsceneFileSystemManager__Func_2156B08(CutsceneSystemManager *work, const char *path, s32 fileID);
void CutsceneFileSystemManager__Func_2156BEC(CutsceneSystemManager *work, s32 id);
s32 CutsceneFileSystemManager__Func_2156C88(CutsceneSystemManager *work, s32 id, const char *path, s32 fileID);

// SpriteButton manager
void CutsceneSpriteButtonManager__Init(CutsceneSystemManager *work, u32 count);
u32 CutsceneSpriteButtonManager__Func_2156E2C(CutsceneSystemManager *work);
AnimatorSprite *CutsceneSpriteButtonManager__GetAnimator(CutsceneSystemManager *work, s32 id);
CutsceneTouchArea *CutsceneSpriteButtonManager__Func_2156E54(CutsceneSystemManager *work, s32 id);
u32 *CutsceneSpriteButtonManager__Func_2156E70(CutsceneSystemManager *work, s32 id);
s32 CutsceneSpriteButtonManager__LoadSprite2(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow);
s32 CutsceneSpriteButtonManager__LoadSprite(CutsceneSystemManager *work, s32 is, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow);
void CutsceneSpriteButtonManager__Func_215707C(CutsceneSystemManager *work, s32 id, u32 flags, s32 type, CutsceneScript *cutscene);
void CutsceneSpriteButtonManager__Func_21570F4(CutsceneSystemManager *work, s32 id);
void CutsceneSpriteButtonManager__Func_2157128(CutsceneSystemManager *work, s32 id);

// Background manager
void CutsceneBackgroundManager__Init(CutsceneSystemManager *work);
Background *CutsceneBackgroundManager__GetBackground(CutsceneSystemManager *work, s32 id);
void *CutsceneBackgroundManager__Func_2157174(CutsceneSystemManager *work, s32 id);
void *CutsceneBackgroundManager__Func_215718C(CutsceneSystemManager *work, s32 id1, s32 id2);
s32 CutsceneBackgroundManager__Func_21571A4(CutsceneSystemManager *work);
s32 CutsceneBackgroundManager__LoadBackground(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u8 bgID);
void CutsceneBackgroundManager__Func_2157430(CutsceneSystemManager *work, s32 id);

// Model manager
void CutsceneModelManager__Init(CutsceneSystemManager *work, u32 count);
s32 CutsceneModelManager__Func_2157460(CutsceneSystemManager *work);
AnimatorMDL *CutsceneModelManager__GetModel(CutsceneSystemManager *work, s32 id);
s32 CutsceneModelManager__TryLoadModel(CutsceneSystemManager *work, const char *path, s32 fileID, s32 id);
s32 CutsceneModelManager__LoadModel(CutsceneSystemManager *work, s32 slot, const char *path, s32 fileID, s32 id);
s32 CutsceneModelManager__LoadModelAnimation(CutsceneSystemManager *work, s32 slot, s32 type, const char *path, s32 fileID, s32 animID, const char *texPath, s32 texFileID);
void CutsceneModelManager__Func_2157738(CutsceneSystemManager *work, s32 type, s32 id, s32 value);
void CutsceneModelManager__Func_215793C(CutsceneSystemManager *work);
void CutsceneModelManager__LoadDrawState(CutsceneSystemManager *work, void *memory);
void CutsceneModelManager__Func_2157A0C(CutsceneSystemManager *work, s32 id);

// Audio manager
void CutsceneAudioManager__Init(CutsceneSystemManager *work, u32 count);

// Text manager
void CutsceneTextManager__Init(CutsceneSystemManager *work, CutsceneScriptTextCommand commandFunc, void (*processFunc)(CutsceneTextWorker *worker),
                               void (*releaseFunc)(CutsceneTextWorker *worker), size_t size);

// System manager
void CutsceneSystemManager__Process(CutsceneSystemManager *work);

// Audio manager
NNSSndHandle *CutsceneAudioManager__GetSoundHandle(CutsceneSystemManager *work, s32 id);
s32 CutsceneAudioManager__AllocSoundHandle(CutsceneSystemManager *work);
void CutsceneAudioManager__Func_2157B08(CutsceneSystemManager *work);
void CutsceneAudioManager__StopAllSeq(CutsceneSystemManager *work, s32 fadeFrame);

// Text manager
CutsceneTextWorker *CutsceneTextManager__GetWorker(CutsceneSystemManager *work);

// Model manager
void CutsceneModelManager__RenderCallback_Single(NNSG3dRS *rs);
void CutsceneModelManager__RenderCallback_Double(NNSG3dRS *rs);
void CutsceneModelManager__Func_2157D6C(CutsceneCamera3D *work);

// Fade manager
void CutsceneFadeManager__Alloc(CutsceneSystemManager *work);
void CutsceneFadeManager__Release(CutsceneSystemManager *work);
void CutsceneFadeManager__Process(CutsceneSystemManager *work);

// FileSystem manager
void CutsceneFileSystemManager__Alloc(CutsceneSystemManager *work, u32 count);
void CutsceneFileSystemManager__UnmountArchive2(CutsceneArchive *work);
void CutsceneFileSystemManager__Release(CutsceneSystemManager *work);
void CutsceneFileSystemManager__Process(CutsceneSystemManager *work);

// SpriteButton manager
void CutsceneSpriteButtonManager__Alloc(CutsceneSystemManager *work, u32 count);
void CutsceneSpriteButtonManager__Func_21580E0(CutsceneSpriteButton *work, CutsceneSystemManager *manager);
void CutsceneSpriteButtonManager__Release(CutsceneSystemManager *work);
void CutsceneSpriteButtonManager__Process(CutsceneSystemManager *work);

// Background manager
void CutsceneBackgroundManager__Alloc(CutsceneSystemManager *work);
void CutsceneBackgroundManager__Func_21582F4(CutsceneBackground *work, CutsceneSystemManager *manager);
void CutsceneBackgroundManager__Release(CutsceneSystemManager *work);
void CutsceneBackgroundManager__Process(CutsceneSystemManager *work);

// Model manager
void CutsceneModelManager__Alloc(CutsceneSystemManager *work, u32 count);
void CutsceneModelManager__Func_215858C(CutsceneModel *work, CutsceneSystemManager *manager);
void CutsceneModelManager__Release(CutsceneSystemManager *work);
void CutsceneModelManager__Process(CutsceneSystemManager *work);

// Audio manager
void CutsceneAudioManager__Alloc(CutsceneSystemManager *work, u32 count);
void CutsceneAudioManager__Func_21588A8(CutsceneAudioHandle *work, CutsceneSystemManager *manager);
void CutsceneAudioManager__Release(CutsceneSystemManager *work);
void CutsceneAudioManager__Process(CutsceneSystemManager *work);

// Text manager
void CutsceneTextManager__Alloc(CutsceneSystemManager *work, size_t size);
void CutsceneTextManager__Release(CutsceneSystemManager *work);
void CutsceneTextManager__Process(CutsceneSystemManager *work);

// Unknown
void CutsceneUnknown__Func_2158A6C(BOOL useEngineB, u8 backgroundID, s32 screenSize, s32 colorMode, s32 a5, s32 a6);
void CutsceneUnknown__Func_2158D3C(BOOL useEngineB, u8 type, s32 backgroundID, s32 screenSize, s32 areaOver, s32 screenBase, s32 charBase);
void CutsceneUnknown__Func_215902C(GXVRamOBJ bank, u16 bankOffset);
void CutsceneUnknown__Func_2159188(GXVRamSubOBJ bank, u16 bankOffset);
u32 CutsceneUnknown__GetBankID(s32 a1);

// FadeManager
void CutsceneFadeManager__Init(CutsceneFadeManager *work);
void CutsceneFadeTask__Process(CutsceneFadeManager *work, s32 mode, s32 timer);
void CutsceneFadeManager__Draw(CutsceneFadeManager *work);

// SpriteButton touch area
void CutsceneSpriteButtonManager__AddTouchArea(CutsceneTouchArea *work, TouchField *touchField, AnimatorSprite *animator, u32 flags, CutsceneScript *cutscene, s32 type);
void CutsceneSpriteButtonManager__RemoveTouchArea(CutsceneTouchArea *work);
void CutsceneSpriteButtonManager__TouchAreaCallback(TouchAreaResponse *response, CutsceneTouchArea *area, void *userData);

void CutsceneTextWorker__Init(CutsceneTextWorker *work);
void CutsceneTextWorker__Draw(CutsceneTextWorker *work);
void CutsceneTextWorker__Release(CutsceneTextWorker *work);
CutsceneScriptResult CutsceneTextWorker__Process(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *work);

// Text Commands
CutsceneScriptResult CutsceneScript__TextCommand__LoadFontFile(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Func_2159B14(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__LoadMPCFile(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__SetMsgSeq(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Func_2159C68(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Func_2159C88(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Func_2159CA8(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Func_2159CC8(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Func_2159CD8(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__LoadCharacters(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__LoadCharactersConditional(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__IsEndOfLine(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__AdvanceDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__IsLastDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript__TextCommand__Draw(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);

// CutsceneAssetSystem funcs
void CutsceneAssetSystem__Create(void);
void CutsceneAssetSystem__Func_2159E28(Task *task);
void CutsceneAssetSystem__Destructor(Task *task);
void CutsceneAssetSystem__OnCutsceneFinish(CutsceneScript *work);
s32 CutsceneAssetSystem__GetCutsceneID(void);
s32 CutsceneAssetSystem__GetNextSysEvent(void);
void CutsceneAssetSystem__LoadCanSkipFlag(CutsceneScript *work);
void CutsceneAssetSystem__StoreCanSkipFlag(CutsceneScript *work);
void CutsceneAssetSystem__Main(void);
void CutsceneAssetSystem__NextSysEvent(void);
void CutsceneAssetSystem__Func_215A124(void *background, void *vramPixels, s32 displayWidth, s32 displayHeight);
void CutsceneAssetSystem__Func_215A248(void);
void CutsceneAssetSystem__Func_215A2F0(void);
void CutsceneAssetSystem__Func_215A374(void);
void CutsceneAssetSystem__Func_215A490(void);
void CutsceneAssetSystem__Func_215A640(void);
void CutsceneAssetSystem__Func_215A738(void);
void CutsceneAssetSystem__Func_215A788(void);
void CutsceneAssetSystem__Func_215A9A8(void);
void CutsceneAssetSystem__Func_215AB20(void);
void CutsceneAssetSystem__Func_215ADA0(void);
void CutsceneAssetSystem__Func_215AE54(void);
void CutsceneAssetSystem__Func_215AF60(void);
void CutsceneAssetSystem__Func_215B094(void);
s16 CutsceneAssetSystem__Func_215B108(s32 value, s32 id);
void CutsceneAssetSystem__Func_215B158(void);
void CutsceneAssetSystem__Func_215B170(void);
void CutsceneAssetSystem__Func_215B180(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE s32 *GetScriptParam1(ScriptCommand *command)
{
    ScriptParam1 *command1 = (ScriptParam1 *)command;
    return &command1->param1;
}

RUSH_INLINE s32 *GetScriptParam2(ScriptCommand *command)
{
    ScriptParam2 *command2 = (ScriptParam2 *)command;
    return &command2->param2;
}

#endif // RUSH_CUTSCENESCRIPT_H
