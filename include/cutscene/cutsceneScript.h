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
typedef struct CutsceneSwapBuffer3D_ CutsceneCamera3D;
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
    u8 field_195;
    u8 field_196;
    u8 field_197;
    s32 field_198;
};

typedef struct CutsceneFadeTaskInfo_
{
    Task *task;
} CutsceneFadeTaskInfo;

typedef struct UnknownBackground_
{
    u16 field_0;
    u16 field_2;
    u8 field_4;
    u8 field_5;
    u8 field_6;
    u8 field_7;
} UnknownBackground;

typedef struct CutsceneBackgroundUnknown_
{
    UnknownBackground *fileData;
    u16 *memory;
    u16 *dword8;
    u16 *dwordC;
    u16 *dword10;
    u16 *dword14;
    u16 *dword18;
    u16 width1;
    u16 height1;
    u16 width2;
    u16 height2;
} CutsceneBackgroundUnknown;

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
} CutsceneSystem;

// --------------------
// FUNCTIONS
// --------------------

// CutsceneScript initialization
void CreateCutsceneScript(CutsceneSystem *parent, u32 priority);
void DestroyCutsceneScript(CutsceneSystem *work);
CutsceneScript *GetCutsceneScript(CutsceneSystem *work);
void CutsceneScript_InitFileSystemManager(CutsceneSystem *work, u32 handleCount);
void CutsceneScript_InitSpriteButtonManager(CutsceneSystem *work, u32 handleCount);
void CutsceneScript_InitBackgroundManager(CutsceneSystem *work);
void CutsceneScript_InitModelManager(CutsceneSystem *work, u32 handleCount);
void CutsceneScript_InitAudioManager(CutsceneSystem *work, u32 handleCount);
void CutsceneScript_InitTextManager(CutsceneSystem *work);
CutsceneTextWorker *GetCutsceneScriptTextWorker(CutsceneSystem *work);
void LoadCutsceneScript(CutsceneSystem *work, CutsceneScriptHeader *script);
void StartCutsceneScript(CutsceneSystem *work, s32 startParam, CutsceneScriptOnFinish onFinish);
void CutsceneScript_Destructor(Task *task);
void CutsceneFade_Destructor(Task *task);

// Engine Script functions
CutsceneScriptResult CutsceneScript_SystemCommand_GetPadInputMask(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SystemCommand_GetTouchPos(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SystemCommand_GetGameLanguage(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SystemCommand_GetVCount(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SystemCommand_GetBrightness(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_InitVRAMSystem(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetupBGBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetupOBJBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetupBGExtPalBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetupOBJExtPalBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetupTextureBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetupTexturePalBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetGraphicsMode(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBackgroundControlText(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBackgroundControlAffine(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetCurrentDisplay(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_ProcessFadeTask(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_CreateFadeTask(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetVisiblePlane(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBackgroundPriority(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendPlane(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendEffect(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendAlpha(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendCoefficient(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetWindowVisible(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetWindowPlane(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetWindowPosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_Unknown(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_SetCapture(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_ShakeScreen1(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ScreenCommand_ShakeScreen2(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_AllocFileHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_ReleaseFileHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_ReleaseAllFileHandles(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_MountArchive(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_UnmountArchive(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_SetNextFileCompressedFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_FileSystemCommand_SetNextFileASyncLoadFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_AllocSpriteHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_ReleaseSpriteHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_ReleaseAllSpriteHandles(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_LoadSpriteResource(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetAnimation(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpritePosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteVisible(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteLoopFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteFlip(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpritePriority(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteType(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_GetSpritePosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_GetSpritePalette(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_AddTouchArea(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_RemoveTouchArea(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SpriteCommand_GetTouchAreaResponseFlags(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_BackgroundCommand_LoadBackgroundHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_BackgroundCommand_ReleaseBackgroundHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_BackgroundCommand_ReleaseAllBackgroundHandles(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_BackgroundCommand_SetBackgroundPosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_BackgroundCommand_SetBackgroundHandleFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_BackgroundCommand_SetBackgroundFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_AllocModelHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_ReleaseModelHandle(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_ReleaseModelHandles(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_LoadModelResource(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_LoadModelAnimResource(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelScale(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelRotation(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelPosition(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelPosition2(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelVisible(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelLoopFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelCanLoopFlag(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_SetModelRenderCallback(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_LoadDrawState(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_ModelCommand_CheckModelAnimFinished(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArc(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_SetVolume(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_MoveVolume(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcGroup(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcSeq(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcSeqArc(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcBank(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_PlayTrack(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_PlayTrackEx(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_PlaySequence(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_PlaySequenceEx(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_PlayVoiceClip(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_PlayVoiceClipEx(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_FadeSeq(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_FadeAllSeq(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_SetTrackPan(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_SoundCommand_SetPlayerPriority(ScriptThread *thread, CutsceneScript *work);
CutsceneScriptResult CutsceneScript_TextCommand_Execute(ScriptThread *thread, CutsceneScript *work);

// CutsceneScript management
void CutsceneScript_Main(void);
void CutsceneFade_Main(void);
void InitCutsceneScriptProcessor(CutsceneScript *work, CutsceneScriptHeader *script, CutsceneScriptEngineCommand **funcTable, s32 unknown);
void ReleaseCutsceneScriptProcessor(CutsceneScript *work);
BOOL CutsceneScript_Run(CutsceneScript *work);
ScriptThread *CutsceneScript_InitProcessor(CutsceneScript *work, CutsceneScriptOnFinish onFinish);
ScriptThread *CutsceneScript_InitThread(CutsceneScript *work, u32 pc);
CutsceneScriptSection CutsceneScript_GetAddressSection(u32 addr);
void *CutsceneScript_GetFunctionParamConstant(CutsceneScript *work, ScriptThread *thread, u32 addr);
s32 CutsceneScript_GetFunctionParamRegister(ScriptThread *thread, s32 id);
const char *CutsceneScript_CutsceneScript_GetFunctionParamStringPointer(ScriptThread *thread, CutsceneScript *cutscene, s32 id);
const char *CutsceneScript_GetFunctionParamString(ScriptThread *thread, CutsceneScript *cutscene, s32 id);
void CutsceneScript_SetRegister(ScriptThread *work, u32 id, s32 value);
CutsceneScriptResult CutsceneScript_ProcessThread(CutsceneScript *work, ScriptThread *thread);
s32 *CutsceneScript_GetRegister(ScriptThread *work, u32 id);
CutsceneScriptSection GetCutsceneScriptAddressSection(u32 addr);
void *CutsceneScript_GetAddressPointer(CutsceneScript *work, ScriptThread *thread, u32 addr);
void CutsceneScript_PushStack(ScriptThread *work, s32 value);
s32 CutsceneScript_PopStack(ScriptThread *work);
void *CutsceneScript_GetInstructionParam(s32 type, s32 *param, s32 unknown, CutsceneScript *work, ScriptThread *thread);
s32 CutsceneScript_AllocThread(CutsceneScript *work, u32 pc);

// Script Instruction functions
CutsceneScriptResult CutsceneScript_EndCommand_StopThreads(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_EndCommand_Continue(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_EndCommand_Suspend(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Assign(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Add(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Subtract(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Multiply(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Divide(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Negate(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Increment(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_Decrement(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ArithmeticCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_BitwiseAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_LogicalAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_BitwiseOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_LogicalOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_XOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_BitwiseNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_LogicalNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_ShiftL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_RotateL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BitwiseCommand_RotateR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ComparisonCommand_Equal(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ComparisonCommand_NotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ComparisonCommand_Less(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ComparisonCommand_LessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ComparisonCommand_Greater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_ComparisonCommand_GreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_SwitchCommand_Case(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_SwitchCommand_Default(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchAlways(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchNotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchGreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchGreater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchLessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_BranchCommand_BranchLess(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_FunctionCommand_CallFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_FunctionCommand_EndFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_FunctionCommand_CallFunctionASync(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_FunctionCommand_End(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_EngineCommand_Execute(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_StackCommand_Load(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);
CutsceneScriptResult CutsceneScript_StackCommand_Store(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command);

// misc
CutsceneFadeManager *GetCutsceneSystemFadeManager(CutsceneSystemManager *work);
void InitCutsceneSystemFadeManager(CutsceneSystemManager *work);
void ReleaseCutsceneAssetSystem(CutsceneSystemManager *work);

// FileSystem manager
void InitCutsceneFileSystemManager(CutsceneSystemManager *work, u32 handleCount);
void *CutsceneFileSystemManager_GetFile(CutsceneSystemManager *work, s32 handleSlot);
BOOL CutsceneFileSystemManager_CheckSingleReference(CutsceneSystemManager *work, s32 handleSlot);
void CutsceneFileSystemManager_SetNextFileCompressedFlag(CutsceneSystemManager *work, BOOL isCompressed);
BOOL CutsceneFileSystemManager_GetNextFileCompressedFlag(CutsceneSystemManager *work);
void CutsceneFileSystemManager_SetNextFileASyncLoadFlag(CutsceneSystemManager *work, BOOL loadASync);
void CutsceneFileSystemManager_MountArchive(CutsceneSystemManager *work, s32 handleSlot, const char *arcName);
void CutsceneFileSystemManager_UnmountArchive(CutsceneSystemManager *work, s32 handleSlot);
s32 CutsceneFileSystemManager_AllocFileHandle(CutsceneSystemManager *work, const char *path, s32 fileID);
void CutsceneFileSystemManager_ReleaseFile(CutsceneSystemManager *work, s32 handleSlot);
s32 CutsceneFileSystemManager_LoadFile(CutsceneSystemManager *work, s32 handleSlot, const char *path, s32 fileID);

// Sprite manager
void InitCutsceneSpriteButtonManager(CutsceneSystemManager *work, u32 handleCount);
u32 CutsceneSpriteButtonManager_GetSpriteHandleCount(CutsceneSystemManager *work);
AnimatorSprite *CutsceneSpriteButtonManager_GetSpriteHandleAnimator(CutsceneSystemManager *work, s32 handleSlot);
CutsceneTouchArea *CutsceneSpriteButtonManager_GetSpriteHandleTouchArea(CutsceneSystemManager *work, s32 handleSlot);
u32 *CutsceneSpriteButtonManager_GetSpriteHandleFlags(CutsceneSystemManager *work, s32 handleSlot);
s32 CutsceneSpriteButtonManager_AllocSpriteHandle(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow);
s32 CutsceneSpriteButtonManager_LoadSpriteResource(CutsceneSystemManager *work, s32 is, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow);
void CutsceneSpriteButtonManager_AddTouchAreaToHandle(CutsceneSystemManager *work, s32 handleSlot, u32 flags, s32 type, CutsceneScript *cutscene);
void CutsceneSpriteButtonManager_RemoveTouchAreaFromHandle(CutsceneSystemManager *work, s32 handleSlot);
void CutsceneSpriteButtonManager_ReleaseSpriteHandle(CutsceneSystemManager *work, s32 handleSlot);

// Background manager
void InitCutsceneBackgroundManager(CutsceneSystemManager *work);
Background *CutsceneBackgroundManager_GetBackgroundHandleBackground(CutsceneSystemManager *work, s32 handleSlot);
void *CutsceneBackgroundManager_GetBackgroundHandleFlags(CutsceneSystemManager *work, s32 handleSlot);
void *CutsceneBackgroundManager_GetBackgroundFlags(CutsceneSystemManager *work, s32 useEngineB, s32 backgroundID);
s32 CutsceneBackgroundManager_GetBackgroundHandleCount(CutsceneSystemManager *work);
s32 CutsceneBackgroundManager_LoadBackgroundResource(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u8 bgID);
void CutsceneModelManager_ReleaseBackgroundHandle(CutsceneSystemManager *work, s32 handleSlot);

// Model manager
void InitCutsceneModelManager(CutsceneSystemManager *work, u32 handleCount);
s32 CutsceneModelManager_GetModelHandleCount(CutsceneSystemManager *work);
AnimatorMDL *CutsceneModelManager_GetModelHandleModel(CutsceneSystemManager *work, s32 handleSlot);
s32 CutsceneModelManager_AllocModelHandle(CutsceneSystemManager *work, const char *path, s32 fileID, s32 id);
s32 CutsceneModelManager_LoadModelResource(CutsceneSystemManager *work, s32 handleSlot, const char *path, s32 fileID, s32 id);
s32 CutsceneModelManager_LoadModelAnimResource(CutsceneSystemManager *work, s32 handleSlot, s32 type, const char *path, s32 fileID, s32 animID, const char *texPath, s32 texFileID);
void CutsceneModelManager_SetRenderCallback(CutsceneSystemManager *work, s32 type, s32 handleSlot, s32 value);
void CutsceneModelManager_ResetRenderCallback(CutsceneSystemManager *work);
void CutsceneModelManager_LoadDrawState(CutsceneSystemManager *work, void *memory);
void CutsceneModelManager_ReleaseModelHandle(CutsceneSystemManager *work, s32 handleSlot);

// Audio manager
void InitCutsceneAudioManager(CutsceneSystemManager *work, u32 handleCount);

// Text manager
void InitCutsceneTextManager(CutsceneSystemManager *work, CutsceneScriptTextCommand commandFunc, void (*processFunc)(CutsceneTextWorker *worker),
                             void (*releaseFunc)(CutsceneTextWorker *worker), size_t size);

// System manager
void ProcessCutsceneSystem(CutsceneSystemManager *work);

// Audio manager
NNSSndHandle *CutsceneAudioManager_GetSoundHandle(CutsceneSystemManager *work, s32 handleSlot);
s32 CutsceneAudioManager_AllocSoundHandle(CutsceneSystemManager *work);
void CutsceneAudioManager_ResetSystem(CutsceneSystemManager *work);
void CutsceneAudioManager_StopAllSounds(CutsceneSystemManager *work, s32 fadeFrame);

// Text manager
CutsceneTextWorker *CutsceneTextManager_GetWorker(CutsceneSystemManager *work);

// Model manager
void CutsceneModelManager_RenderCallback_Single(NNSG3dRS *rs);
void CutsceneModelManager_RenderCallback_Double(NNSG3dRS *rs);
void CutsceneModelManager_ConfigureCameraState(CutsceneCamera3D *work);

// Fade manager
void CreateCutsceneFadeManager(CutsceneSystemManager *work);
void ReleaseCutsceneFadeManager(CutsceneSystemManager *work);
void ProcessCutsceneFadeManager(CutsceneSystemManager *work);

// FileSystem manager
void CreateCutsceneFileSystemManager(CutsceneSystemManager *work, u32 handleCount);
void ReleaseCutsceneFileSystemManagerFile(CutsceneArchive *work);
void ReleaseCutsceneFileSystemManager(CutsceneSystemManager *work);
void ProcessCutsceneFileSystemManager(CutsceneSystemManager *work);

// SpriteButton manager
void CreateCutsceneSpriteButtonManager(CutsceneSystemManager *work, u32 handleCount);
void ReleaseCutsceneSpriteButtonManagerSprite(CutsceneSpriteButton *work, CutsceneSystemManager *manager);
void ReleaseCutsceneSpriteButtonManager(CutsceneSystemManager *work);
void ProcessCutsceneSpriteButtonManager(CutsceneSystemManager *work);

// Background manager
void CreateCutsceneBackgroundManager(CutsceneSystemManager *work);
void ReleaseCutsceneBackgroundManagerBackground(CutsceneBackground *work, CutsceneSystemManager *manager);
void ReleaseCutsceneBackgroundManager(CutsceneSystemManager *work);
void ProcessCutsceneBackgroundManager(CutsceneSystemManager *work);

// Model manager
void CreateCutsceneModelManager(CutsceneSystemManager *work, u32 handleCount);
void ReleaseCutsceneModelManagerModel(CutsceneModel *work, CutsceneSystemManager *manager);
void ReleaseCutsceneModelManager(CutsceneSystemManager *work);
void ProcessCutsceneModelManager(CutsceneSystemManager *work);

// Audio manager
void CreateCutsceneAudioManager(CutsceneSystemManager *work, u32 handleCount);
void ReleaseCutsceneAudioManagerHandle(CutsceneAudioHandle *work, CutsceneSystemManager *manager);
void ReleaseCutsceneAudioManager(CutsceneSystemManager *work);
void ProcessCutsceneAudioManager(CutsceneSystemManager *work);

// Text manager
void CreateCutsceneTextManager(CutsceneSystemManager *work, size_t size);
void ReleaseCutsceneTextManager(CutsceneSystemManager *work);
void ProcessCutsceneTextManager(CutsceneSystemManager *work);

// Unknown
void CutsceneDisplay_ConfigureBackgroundText(BOOL useEngineB, u8 backgroundID, s32 screenSize, s32 colorMode, s32 screenBase, s32 charBase);
void CutsceneDisplay_ConfigureBackgroundExtended(BOOL useEngineB, s32 type, s32 backgroundID, s32 screenSize, s32 areaOver, s32 screenBase, s32 charBase);
void CutsceneDisplay_SetupOBJBank(GXVRamOBJ bank, u16 bankOffset);
void CutsceneDisplay_SetupSubOBJBank(GXVRamSubOBJ bank, u16 bankOffset);
u32 CutsceneDisplay_GetBankID(s32 a1);

// FadeManager
void InitCutsceneFade(CutsceneFadeManager *work);
void ProcessCutsceneFade(CutsceneFadeManager *work, s32 mode, s32 timer);
void DrawCutsceneFade(CutsceneFadeManager *work);

// SpriteButton touch area
void CutsceneSpriteButtonManager_AddTouchArea_Internal(CutsceneTouchArea *work, TouchField *touchField, AnimatorSprite *animator, u32 flags, CutsceneScript *cutscene, s32 type);
void CutsceneSpriteButtonManager_RemoveTouchArea_Internal(CutsceneTouchArea *work);
void CutsceneSpriteButtonManager_TouchAreaCallback(TouchAreaResponse *response, CutsceneTouchArea *area, void *userData);

// CutsceneTextSystem
void InitCutsceneTextSystem(CutsceneTextWorker *work);
void DrawCutsceneTextSystem(CutsceneTextWorker *work);
void ReleaseCutsceneTextSystem(CutsceneTextWorker *work);
CutsceneScriptResult ProcessCutsceneTextSystem(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *work);

// Text Commands
CutsceneScriptResult CutsceneScript_TextCommand_LoadWindow(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_ReleaseWindow(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_LoadTextSequenceFile(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_SetTextSequence(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_SetUnknown180(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_SetUnknown184(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_SetUnknown188(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_EnableUnknown18C(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_DisableUnknown18C(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_ResetLoadedCharacters(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_LoadCharacters(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_CheckEndOfLine(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_AdvanceDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_CheckLastDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);
CutsceneScriptResult CutsceneScript_TextCommand_Draw(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene);

// CutsceneSystem
void CreateCutsceneSystem(void);
void InitCutsceneSystem(Task *task);
void CutsceneSystem_Destructor(Task *task);
void CutsceneSystem_OnCutsceneFinish(CutsceneScript *work);
s32 CutsceneSystem_GetCutsceneID(void);
s32 CutsceneSystem_GetNextSysEvent(void);
void CutsceneSystem_LoadCanSkipFlag(CutsceneScript *work);
void CutsceneSystem_StoreCanSkipFlag(CutsceneScript *work);
void CutsceneSystem_Main_Running(void);
void CutsceneSystem_Main_NextSysEvent(void);

// CutsceneUnknownBackground
void CutsceneUnknownBackground__Func_215A124(void *background, void *vramPixels, s32 displayWidth, s32 displayHeight);
void CutsceneUnknownBackground__Func_215A248(CutsceneBackgroundUnknown *work);
void CutsceneUnknownBackground__Func_215A2F0(u16 *src, u16 *dst);
void CutsceneUnknownBackground__Func_215A374(CutsceneBackgroundUnknown *work);
void CutsceneUnknownBackground__Func_215A490(u16 *a1, u16 *a2, s32 a3, s32 a4);
void CutsceneUnknownBackground__Func_215A640(u16 *a1, u16 *a2);
void CutsceneUnknownBackground__Func_215A738(s16 *a1, s16 *a2);
void CutsceneUnknownBackground__Func_215A788(CutsceneBackgroundUnknown *work);
void CutsceneUnknownBackground__Func_215A9A8(CutsceneBackgroundUnknown *work, u16 *a2, u32 a3, u32 a4);
void CutsceneUnknownBackground__Func_215AB20(s16 *a1, u32 a2, s32 a3);
void CutsceneUnknownBackground__Func_215ADA0(s32 a1, s32 a2, s32 a3);
void CutsceneUnknownBackground__Func_215AE54(u8 *a1, u16 *a2);
void CutsceneUnknownBackground__Func_215AF60(s32 a1, s32 a2, u32 *a3);
void CutsceneUnknownBackground__Func_215B094(s32 a1, u32 a2, u32 a3, s32 *a4);
s16 CutsceneUnknownBackground__Func_215B108(s32 value, s32 id);
void CutsceneUnknownBackground__Func_215B158(u32 *a1, s32 a2, u32 a3);
u32 CutsceneUnknownBackground__Func_215B170(u32 *a1);
void CutsceneUnknownBackground__Func_215B180(u32 *a1);

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
