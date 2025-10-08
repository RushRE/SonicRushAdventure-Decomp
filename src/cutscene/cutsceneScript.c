#include <cutscene/cutsceneScript.h>
#include <game/system/sysEvent.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/input/touchField.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/graphics/drawState.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/spriteUnknown.h>
#include <game/graphics/bankUnknown.h>
#include <game/audio/audioSystem.h>
#include <game/file/fsRequest.h>
#include <game/file/archiveFile.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindow.h>
#include <game/game/gameState.h>
#include <game/util/unknown204BE48.h>
#include <game/graphics/backgroundUnknown.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _s32_div_f(void);
NOT_DECOMPILED void _u32_div_f(void);

// --------------------
// CONSTANTS
// --------------------

#define CUTSCENESCRIPT_LOCATION_DATA  0x00000000
#define CUTSCENESCRIPT_LOCATION_STACK 0x70000000
#define CUTSCENESCRIPT_LOCATION_ROM   0x80000000

#define CUTSCENESCRIPT_ASSETSLOT_NONE  0x00
#define CUTSCENESCRIPT_ASSETSLOT_START (CUTSCENESCRIPT_ASSETSLOT_NONE + 1)

// --------------------
// STRUCTS
// --------------------

struct CutsceneFader_
{
    u32 mode;
    s8 brightness1;
    s8 brightness2;
    u8 timer3;
};

typedef union CutsceneArchiveName_
{
    char text[4];
    u32 value;
} CutsceneArchiveName;

typedef struct CutsceneFSArchive_
{
    NNSFndArchive arc;
    CutsceneArchiveName name;
} CutsceneFSArchive;

struct CutsceneArchive_
{
    s32 refCount;
    const char *path;
    s32 id;
    void *filePtr;
    CutsceneArchive *next;
    CutsceneFSArchive *fsArchive;
};

struct CutsceneTouchArea_
{
    TouchArea area;
    TouchField *touchField;
    AnimatorSprite *animator;
    u32 dword40;
    u16 anim1;
    u16 anim2;
    u16 palette1;
    u16 palette2;
    CutsceneScript *cutscene;
    u32 type;
};

struct CutsceneSpriteButton_
{
    u32 resourceFileHandle;
    AnimatorSprite ani;
    CutsceneTouchArea *touchArea;
    u32 flags;
};

struct CutsceneBackground_
{
    u32 resourceFileHandle;
    Background ani;
    u32 flags;
};

struct CutsceneCamera3D_
{
    BOOL active;
    s32 modelHandle;
    Camera3D config;
    s32 posY;
    u32 matProjPositionY;
};

struct CutsceneModel_
{
    u32 resourceFileHandle[B3D_RESOURCE_MAX];
    u32 texResourceFileHandle;
    AnimatorMDL ani;
    u32 unknown;
};

struct CutsceneAudioHandle_
{
    BOOL isActive;
    NNSSndHandle *sndHandle;
};

struct CutsceneFadeManager_
{
    u32 flags;
    CutsceneFader control[2];
};

struct CutsceneFileSystemManager_
{
    s32 handleCount;
    CutsceneArchive *handleList;
    u32 loadCompressedFile;
    u32 loadASync;
    u32 asyncFileHandle;
    ArchiveFile asyncFileWorker;
};

struct CutsceneSpriteButtonManager_
{
    s32 handleCount;
    CutsceneSpriteButton *handleList;
    TouchField touchField;
};

struct CutsceneBackgroundManager_
{
    CutsceneBackground handleList[(GRAPHICS_ENGINE_COUNT * BACKGROUND_COUNT)];
};

struct CutsceneModelManager_
{
    s32 handleCount;
    CutsceneModel *handleList;
    CutsceneCamera3D camera;
};

struct CutsceneAudioManager_
{
    s32 handleCount;
    CutsceneAudioHandle *handleList;
};

struct CutsceneTextManager_
{
    CutsceneScriptTextCommand commandFunc;
    void (*processFunc)(CutsceneTextWorker *worker);
    void (*releaseFunc)(CutsceneTextWorker *worker);
    CutsceneTextWorker *worker;
};

typedef struct CutsceneFadeTask_
{
    CutsceneFadeTaskInfo *taskInfo;
    fx32 timer;
    CutsceneFadeManager *manager;
    s32 speed;
    s32 flags;
    s32 mode;
} CutsceneFadeTask;

// --------------------
// VARIABLES
// --------------------

static Task *cutsceneSystemTask;

extern CutsceneScriptEngineCommand *CutsceneScript_EngineCommandTable[];
extern CutsceneScriptControlCommand *cutsceneScriptInstructionTable[];

static const NNSG3dResName camera2NodeName = { "node_camera2" };
static const NNSG3dResName target2NodeName = { "node_target2" };
static const NNSG3dResName target1NodeName = { "node_target" };
static const NNSG3dResName cameraNodeName  = { "node_camera" };
static const NNSG3dResName targetNodeName  = { "node_target" };
static const NNSG3dResName camera1NodeName = { "node_camera" };

// --------------------
// FUNCTIONS
// --------------------

void CreateCutsceneScript(CutsceneSystem *parent, u32 priority)
{
    Task *task           = TaskCreate(CutsceneScript_Main, CutsceneScript_Destructor, TASK_FLAG_NONE, 0, priority, TASK_GROUP(0), CutsceneScript);
    parent->cutsceneTask = task;

    parent->cutscene = TaskGetWork(task, CutsceneScript);
    TaskInitWork16(parent->cutscene);

    InitCutsceneSystemFadeManager(&parent->cutscene->systemManager);
    parent->cutscene->status = CUTSCENESCRIPT_STATUS_IDLE;

    StartSamplingTouchInput(1);
}

void DestroyCutsceneScript(CutsceneSystem *work)
{
    StopSamplingTouchInput();

    for (CutsceneFadeTaskInfo *taskPtr = work->cutscene->taskFade; taskPtr != &work->cutscene->taskFade[1]; taskPtr++)
    {
        if (taskPtr->task != NULL)
        {
            // TODO: figure out this struct
            s32 *taskWork = TaskGetWork(taskPtr->task, s32);
            *taskWork     = 0;

            DestroyTask(taskPtr->task);
        }
    }

    ReleaseCutsceneAssetSystem(&work->cutscene->systemManager);
    ShakeScreen(SCREENSHAKE_STOP);
    ReleaseCutsceneScriptProcessor(work->cutscene);
    DestroyTask(work->cutsceneTask);
}

CutsceneScript *GetCutsceneScript(CutsceneSystem *work)
{
    return work->cutscene;
}

void CutsceneScript_InitFileSystemManager(CutsceneSystem *work, u32 handleCount)
{
    InitCutsceneFileSystemManager(&work->cutscene->systemManager, handleCount);
}

void CutsceneScript_InitSpriteButtonManager(CutsceneSystem *work, u32 handleCount)
{
    InitCutsceneSpriteButtonManager(&work->cutscene->systemManager, handleCount);
}

void CutsceneScript_InitBackgroundManager(CutsceneSystem *work)
{
    InitCutsceneBackgroundManager(&work->cutscene->systemManager);
}

void CutsceneScript_InitModelManager(CutsceneSystem *work, u32 handleCount)
{
    InitCutsceneModelManager(&work->cutscene->systemManager, handleCount);

    // it'd be cleaner to do something like 'GX_SetPower(GX_GetPower() | GX_POWER_3D);', but that's not what they did unfortunately
    reg_GX_POWCNT |= GX_POWER_3D;
}

void CutsceneScript_InitAudioManager(CutsceneSystem *work, u32 handleCount)
{
    InitCutsceneAudioManager(&work->cutscene->systemManager, handleCount);
}

void CutsceneScript_InitTextManager(CutsceneSystem *work)
{
    InitCutsceneTextManager(&work->cutscene->systemManager, ProcessCutsceneTextSystem, DrawCutsceneTextSystem, ReleaseCutsceneTextSystem, sizeof(CutsceneTextWorker));

    CutsceneTextWorker *worker = GetCutsceneScriptTextWorker(work);
    MI_CpuClear16(worker, sizeof(*worker));
    InitCutsceneTextSystem(worker);
}

CutsceneTextWorker *GetCutsceneScriptTextWorker(CutsceneSystem *work)
{
    return CutsceneTextManager_GetWorker(&work->cutscene->systemManager);
}

void LoadCutsceneScript(CutsceneSystem *work, CutsceneScriptHeader *script)
{
    InitCutsceneScriptProcessor(work->cutscene, script, CutsceneScript_EngineCommandTable, 0);
    work->cutscene->status = CUTSCENESCRIPT_STATUS_LOADING;
}

void StartCutsceneScript(CutsceneSystem *work, s32 startParam, CutsceneScriptOnFinish onFinish)
{
    CutsceneScript_InitProcessor(work->cutscene, onFinish);

    s32 *data = CutsceneScript_GetFunctionParamConstant(work->cutscene, NULL, CUTSCENESCRIPT_LOCATION_DATA + 0x00);
    *data     = startParam;

    work->cutscene->status = CUTSCENESCRIPT_STATUS_READY;
}

void CutsceneScript_Destructor(Task *task)
{
    CutsceneScript *work = TaskGetWork(task, CutsceneScript);
    ReleaseCutsceneScriptProcessor(work);
}

void CutsceneFade_Destructor(Task *task)
{
    CutsceneFadeTask *work = TaskGetWork(task, CutsceneFadeTask);

    if (work->taskInfo != NULL)
        work->taskInfo->task = NULL;
}

CutsceneScriptResult CutsceneScript_SystemCommand_GetPadInputMask(ScriptThread *thread, CutsceneScript *work)
{
    s32 inputType  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 buttonMask = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    u16 padButtons;
    switch (inputType)
    {
        case 0:
            padButtons = padInput.btnDown;
            break;

        case 1:
            padButtons = padInput.prevBtnDown;
            break;

        case 2:
            padButtons = padInput.btnPress;
            break;

        case 3:
            padButtons = padInput.btnRelease;
            break;

        case 4:
            padButtons = padInput.btnPressRepeat;
            break;
    }

    if (buttonMask == PAD_INPUT_NONE_MASK)
    {
        buttonMask = PAD_BUTTON_Y | PAD_BUTTON_X | PAD_BUTTON_L | PAD_BUTTON_R | PAD_KEY_DOWN | PAD_KEY_UP | PAD_KEY_LEFT | PAD_KEY_RIGHT | PAD_BUTTON_START | PAD_BUTTON_SELECT
                     | PAD_BUTTON_B | PAD_BUTTON_A;
    }

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, padButtons & buttonMask);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SystemCommand_GetTouchPos(ScriptThread *thread, CutsceneScript *work)
{
    // ???
    s32 inputType  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 buttonMask = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    UNUSED(inputType);
    UNUSED(buttonMask);

    if (TOUCH_HAS_ON(touchInput.flags))
    {
        CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, touchInput.on.x);
        CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R1, touchInput.on.y);
    }
    else
    {
        CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, -1);
        CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R1, -1);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SystemCommand_GetGameLanguage(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, GetGameLanguage());

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SystemCommand_GetVCount(ScriptThread *thread, CutsceneScript *work)
{
    s32 value;

    s32 count = GX_GetVCount();
    if (count > HW_LCD_HEIGHT)
    {
        value = ClampS32(count - 342, 0, 100);
    }
    else
    {
        value = ClampS32(count - 79, 0, 100);
    }

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, value);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SystemCommand_GetBrightness(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 type       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    s16 brightness;
    if (type == 0)
    {
        brightness = GetCutsceneSystemFadeManager(&work->systemManager)->control[useEngineB].brightness1;
    }
    else
    {
        brightness = VRAMSystem__GFXControl[useEngineB]->brightness;
    }

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, brightness);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_InitVRAMSystem(ScriptThread *thread, CutsceneScript *work)
{
    s32 mode = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    switch (mode)
    {
        case -1:
            VRAMSystem__Reset();
            break;

        case VRAM_MODE_0:
        case VRAM_MODE_1:
        case VRAM_MODE_2:
            VRAMSystem__Init(mode);
            break;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetupBGBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamBG bank = (GXVRamBG)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        VRAMSystem__SetupBGBank(bank);
    }
    else
    {
        GXVRamSubBG bank = (GXVRamSubBG)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        VRAMSystem__SetupSubBGBank(bank);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetupOBJBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamOBJ bank = (GXVRamOBJ)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        CutsceneDisplay_SetupOBJBank(bank, 0);
    }
    else
    {
        GXVRamSubOBJ bank = (GXVRamSubOBJ)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        CutsceneDisplay_SetupSubOBJBank(bank, 0);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetupBGExtPalBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamBGExtPltt bank = (GXVRamBGExtPltt)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        VRAMSystem__SetupBGExtPalBank(bank);
    }
    else
    {
        GXVRamSubBGExtPltt bank = (GXVRamSubBGExtPltt)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        VRAMSystem__SetupSubBGExtPalBank(bank);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetupOBJExtPalBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamOBJExtPltt bank = (GXVRamOBJExtPltt)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        VRAMSystem__SetupOBJExtPalBank(bank);
    }
    else
    {
        GXVRamSubOBJExtPltt bank = (GXVRamSubOBJExtPltt)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
        VRAMSystem__SetupSubOBJExtPalBank(bank);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetupTextureBank(ScriptThread *thread, CutsceneScript *work)
{
    GXVRamTex bank = (GXVRamTex)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    VRAMSystem__SetupTextureBank(bank);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetupTexturePalBank(ScriptThread *thread, CutsceneScript *work)
{
    GXVRamTexPltt bank = (GXVRamTexPltt)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    VRAMSystem__SetupTexturePalBank(bank);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetGraphicsMode(ScriptThread *thread, CutsceneScript *work)
{
    GXBGMode bgModeA = (GXBGMode)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    GXBG0As bg0_2d3d = (GXBG0As)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    GXBGMode bgModeB = (GXBGMode)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    if (bgModeA != (GXBGMode)-1)
        GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, bgModeA, (GXBG0As)(bg0_2d3d != FALSE));

    if (bgModeB != (GXBGMode)-1)
        GXS_SetGraphicsMode(bgModeB);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBackgroundControlText(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    u8 backgroundID = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 screenSize  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 colorMode   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 screenBase  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    s32 charBase    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);

    CutsceneDisplay_ConfigureBackgroundText(useEngineB, backgroundID, screenSize, colorMode, screenBase, charBase);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBackgroundControlAffine(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    u8 type          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 backgroundID = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 screenSize   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 areaOver     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    s32 screenBase   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);
    s32 charBase     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R6);

    CutsceneDisplay_ConfigureBackgroundExtended(useEngineB, type, backgroundID, screenSize, areaOver, screenBase, charBase);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetCurrentDisplay(ScriptThread *thread, CutsceneScript *work)
{
    renderCurrentDisplay = (GXDispSelect)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_ProcessFadeTask(ScriptThread *thread, CutsceneScript *work)
{
    s32 mode  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 timer = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    CutsceneFadeManager *fadeManager = GetCutsceneSystemFadeManager(&work->systemManager);
    ProcessCutsceneFade(fadeManager, mode, timer);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_CreateFadeTask(ScriptThread *thread, CutsceneScript *work)
{
    s32 mode  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 flags = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 speed = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    if (work->taskFade[0].task != NULL)
        DestroyTask(work->taskFade[0].task);

    Task *parent = GetCurrentTask();

    Task *task             = TaskCreate(CutsceneFade_Main, CutsceneFade_Destructor, TASK_FLAG_NONE, 0, parent->priority, TASK_GROUP(0), CutsceneFadeTask);
    work->taskFade[0].task = task;

    CutsceneFadeTask *fadeManager = TaskGetWork(task, CutsceneFadeTask);
    TaskInitWork16(fadeManager);

    fadeManager->taskInfo = &work->taskFade[0];
    fadeManager->manager  = GetCutsceneSystemFadeManager(&work->systemManager);

    if (flags == -1)
    {
        if (mode != 3)
        {
            if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
            {
                flags = 17;
            }
            else
            {
                flags = 16;
            }
        }
        else
        {
            if (renderCoreGFXControlB.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
            {
                flags = 17;
            }
            else
            {
                flags = 16;
            }
        }
    }

    fadeManager->speed = FLOAT_TO_FX32(16.0) / speed;
    fadeManager->flags = flags;
    fadeManager->mode  = mode;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetVisiblePlane(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 enablePlaneBG0 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 enablePlaneBG1 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 enablePlaneBG2 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 enablePlaneBG3 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    s32 enablePlaneOBJ = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);

    u32 maskOnBG1 = enablePlaneBG1 == TRUE ? GX_PLANEMASK_BG1 : GX_PLANEMASK_NONE;
    u32 maskOnBG0 = enablePlaneBG0 == TRUE ? GX_PLANEMASK_BG0 : GX_PLANEMASK_NONE;
    u32 maskOnBG2 = enablePlaneBG2 == TRUE ? GX_PLANEMASK_BG2 : GX_PLANEMASK_NONE;
    u32 maskOnBG3 = enablePlaneBG3 == TRUE ? GX_PLANEMASK_BG3 : GX_PLANEMASK_NONE;
    u32 maskOnOBJ = enablePlaneOBJ == TRUE ? GX_PLANEMASK_OBJ : GX_PLANEMASK_NONE;

    u32 planeMaskOn = maskOnBG0 | maskOnBG1 | maskOnBG2 | maskOnBG3 | maskOnOBJ;

    u32 maskOffBG1 = enablePlaneBG1 == FALSE ? GX_PLANEMASK_BG1 : GX_PLANEMASK_NONE;
    u32 maskOffBG0 = enablePlaneBG0 == FALSE ? GX_PLANEMASK_BG0 : GX_PLANEMASK_NONE;
    u32 maskOffBG2 = enablePlaneBG2 == FALSE ? GX_PLANEMASK_BG2 : GX_PLANEMASK_NONE;
    u32 maskOffBG3 = enablePlaneBG3 == FALSE ? GX_PLANEMASK_BG3 : GX_PLANEMASK_NONE;
    u32 maskOffOBJ = enablePlaneOBJ == FALSE ? GX_PLANEMASK_OBJ : GX_PLANEMASK_NONE;

    u32 planeOffMask = maskOffBG0 | maskOffBG1 | maskOffBG2 | maskOffBG3 | maskOffOBJ;

    if (useEngineB == GRAPHICS_ENGINE_A)
    {
        GX_SetVisiblePlane(planeMaskOn | ~planeOffMask & GX_GetVisiblePlane());
    }
    else
    {
        GXS_SetVisiblePlane(planeMaskOn | ~planeOffMask & GXS_GetVisiblePlane());
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBackgroundPriority(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 bg0Priority = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 bg1Priority = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 bg2Priority = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 bg3Priority = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);

    if (useEngineB == GRAPHICS_ENGINE_A)
    {
        if (bg0Priority != -1)
            G2_SetBG0Priority(bg0Priority);

        if (bg1Priority != -1)
            G2_SetBG1Priority(bg1Priority);

        if (bg2Priority != -1)
            G2_SetBG2Priority(bg2Priority);

        if (bg3Priority != -1)
            G2_SetBG3Priority(bg3Priority);
    }
    else
    {
        if (bg0Priority != -1)
            G2S_SetBG0Priority(bg0Priority);

        if (bg1Priority != -1)
            G2S_SetBG1Priority(bg1Priority);

        if (bg2Priority != -1)
            G2S_SetBG2Priority(bg2Priority);

        if (bg3Priority != -1)
            G2S_SetBG3Priority(bg3Priority);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendPlane(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 id                  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 enablePlaneBG0      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 enablePlaneBG1      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 enablePlaneBG2      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    s32 enablePlaneBG3      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);
    s32 enablePlaneOBJ      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R6);
    s32 enablePlaneBackdrop = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R7);

    u32 maskBG1      = enablePlaneBG1 ? GX_PLANEMASK_BG1 : GX_PLANEMASK_NONE;
    u32 maskBG0      = enablePlaneBG0 ? GX_PLANEMASK_BG0 : GX_PLANEMASK_NONE;
    u32 maskBG2      = enablePlaneBG2 ? GX_PLANEMASK_BG2 : GX_PLANEMASK_NONE;
    u32 maskBG3      = enablePlaneBG3 ? GX_PLANEMASK_BG3 : GX_PLANEMASK_NONE;
    u32 maskOBJ      = enablePlaneOBJ ? GX_PLANEMASK_OBJ : GX_PLANEMASK_NONE;
    u32 maskBackdrop = enablePlaneBackdrop ? GX_PLANEMASK_EFFECT : GX_PLANEMASK_NONE;

    u16 planeMask = maskBG0 | maskBG1 | maskBG2 | maskBG3 | maskOBJ | maskBackdrop;

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    if (id == 0)
    {
        // TODO: this might be able to use 'gfxControl->blendManager.blendControl.plane1'?
        // here's a decomp.me scratch for anyone willing to try: https://decomp.me/scratch/JSJq5
        gfxControl->blendManager.blendControl.value = (planeMask << 0) | (gfxControl->blendManager.blendControl.value & ~0x3F);
    }
    else
    {
        // TODO: this might be able to use 'gfxControl->blendManager.blendControl.plane2'?
        // here's a decomp.me scratch for anyone willing to try: https://decomp.me/scratch/JSJq5
        gfxControl->blendManager.blendControl.value = (planeMask << 8) | (gfxControl->blendManager.blendControl.value & ~0x3F00);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendEffect(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 effect     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    VRAMSystem__GFXControl[useEngineB]->blendManager.blendControl.effect = effect;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendAlpha(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 ev1        = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 ev2        = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    u16 ev_value = ev1 | (ev2 << 8);

    // TODO: this might be able to use 'gfxControl->blendManager.blendAlpha.ev1' & 'gfxControl->blendManager.blendAlpha.ev2'?
    // here's a decomp.me scratch for anyone willing to try: https://decomp.me/scratch/kCVnY
    VRAMSystem__GFXControl[useEngineB]->blendManager.blendAlpha.value = ev_value;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetBlendCoefficient(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 brightness = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    VRAMSystem__GFXControl[useEngineB]->blendManager.coefficient.value = brightness;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetWindowVisible(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 enableWindowW0 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 enableWindowW1 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 enableWindowOW = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    u32 maskW1 = enableWindowW1 ? GX_WNDMASK_W1 : GX_WNDMASK_NONE;
    u32 maskW0 = enableWindowW0 ? GX_WNDMASK_W0 : GX_WNDMASK_NONE;
    u32 maskOW = enableWindowOW ? GX_WNDMASK_OW : GX_WNDMASK_NONE;

    VRAMSystem__GFXControl[useEngineB]->windowManager.visible = maskW0 | maskW1 | maskOW;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetWindowPlane(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB        = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 id                = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 enablePlaneBG0    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 enablePlaneBG1    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 enablePlaneBG2    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    s32 enablePlaneBG3    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);
    s32 enablePlaneOBJ    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R6);
    s32 enablePlaneEffect = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R7);

    u32 maskBG1    = enablePlaneBG1 ? GX_PLANEMASK_BG1 : GX_PLANEMASK_NONE;
    u32 maskBG0    = enablePlaneBG0 ? GX_PLANEMASK_BG0 : GX_PLANEMASK_NONE;
    u32 maskBG2    = enablePlaneBG2 ? GX_PLANEMASK_BG2 : GX_PLANEMASK_NONE;
    u32 maskBG3    = enablePlaneBG3 ? GX_PLANEMASK_BG3 : GX_PLANEMASK_NONE;
    u32 maskOBJ    = enablePlaneOBJ ? GX_PLANEMASK_OBJ : GX_PLANEMASK_NONE;
    u32 maskEffect = enablePlaneEffect ? GX_PLANEMASK_EFFECT : GX_PLANEMASK_NONE;

    u8 planeMask = maskBG0 | maskBG1 | maskBG2 | maskBG3 | maskOBJ | maskEffect;
    switch (id)
    {
        case 0:
            VRAMSystem__GFXControl[useEngineB]->windowManager.registers.win0InPlane.value = planeMask;
            break;

        case 1:
            VRAMSystem__GFXControl[useEngineB]->windowManager.registers.win1InPlane.value = planeMask;
            break;

        case 2:
            VRAMSystem__GFXControl[useEngineB]->windowManager.registers.winOutPlane.value = planeMask;
            break;

        case 3:
            VRAMSystem__GFXControl[useEngineB]->windowManager.registers.winOBJOutPlane.value = planeMask;
            break;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetWindowPosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 id         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    u8 winX1       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    u8 winY1       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    u8 winX2       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    u8 winY2       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    switch (id)
    {
        case 0:
            gfxControl->windowManager.registers.win0X2 = winX2;
            gfxControl->windowManager.registers.win0X1 = winX1;
            gfxControl->windowManager.registers.win0Y2 = winY2;
            gfxControl->windowManager.registers.win0Y1 = winY1;
            break;

        case 1:
            gfxControl->windowManager.registers.win1X2 = winX2;
            gfxControl->windowManager.registers.win1X1 = winX1;
            gfxControl->windowManager.registers.win1Y2 = winY2;
            gfxControl->windowManager.registers.win1Y1 = winY1;
            break;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_Unknown(ScriptThread *thread, CutsceneScript *work)
{
    s32 value1 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 value2 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_SetCapture(ScriptThread *thread, CutsceneScript *work)
{
    GXCaptureSrcA a    = (GXCaptureSrcA)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    GXCaptureSrcB b    = (GXCaptureSrcB)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 ev             = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    GXCaptureDest dest = (GXCaptureDest)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    GXCaptureMode mode;
    switch (ev)
    {
        case -8:
            mode = GX_CAPTURE_MODE_A;
            break;

        case 8:
            mode = GX_CAPTURE_MODE_B;
            break;

        default:
            mode = GX_CAPTURE_MODE_AB;
            break;
    }

    s32 bank;
    switch (dest & 3)
    {
        case 0:
            bank = 1;
            break;

        case 1:
            bank = 2;
            break;

        case 2:
            bank = 4;
            break;

        case 3:
            bank = 8;
            break;
    }

    switch (CutsceneDisplay_GetBankID(bank))
    {
        case 0:
            VRAMSystem__SetupBGBank(GX_VRAM_BG_NONE);
            break;

        case 1:
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
            break;

        case 2:
            VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_NONE);
            break;

        case 3:
            VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_NONE);
            break;

        case 4:
            VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_NONE);
            break;

        case 5:
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
            break;

        case 6:
            VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_NONE);
            break;

        case 7:
            VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_NONE);
            break;

        case 8:
            VRAMSystem__SetupTextureBank(GX_VRAM_TEX_NONE);
            break;

        case 9:
            VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_NONE);
            break;

        default:
            return CUTSCENESCRIPT_RESULT_CONTINUE;
    }

    GX_SetBankForLCDC(GX_VRAM_LCDC_A);
    GX_SetCapture(GX_CAPTURE_SIZE_256x192, mode, a, b, dest, 8 - ev, ev + 8);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_ShakeScreen1(ScriptThread *thread, CutsceneScript *work)
{
    s32 lifetime = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    ShakeScreenEx(lifetime, FLOAT_TO_FX32(4.8), 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ScreenCommand_ShakeScreen2(ScriptThread *thread, CutsceneScript *work)
{
    u32 lifetime = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    ScreenShake *screenShake = ShakeScreen(SCREENSHAKE_CUSTOM);
    if (screenShake != NULL)
        ShakeScreenEx(0, FLOAT_TO_FX32(4.8), screenShake->lifetime / lifetime);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_AllocFileHandle(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R1);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    s32 handleSlot = CutsceneFileSystemManager_AllocFileHandle(&work->systemManager, path, fileID);
    if (handleSlot == 0)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_ReleaseFileHandle(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneFileSystemManager_ReleaseFile(&work->systemManager, CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0));

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_ReleaseAllFileHandles(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneScript_SpriteCommand_ReleaseAllSpriteHandles(thread, work);
    CutsceneScript_BackgroundCommand_ReleaseAllBackgroundHandles(thread, work);
    CutsceneScript_ModelCommand_ReleaseModelHandles(thread, work);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_MountArchive(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R1);

    CutsceneFileSystemManager_MountArchive(&work->systemManager, handleSlot, path);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_UnmountArchive(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneFileSystemManager_UnmountArchive(&work->systemManager, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_SetNextFileCompressedFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 enabled = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    s32 nextFileCompressedFlag;
    if (enabled != FALSE)
        nextFileCompressedFlag = TRUE;
    else
        nextFileCompressedFlag = FALSE;
    CutsceneFileSystemManager_SetNextFileCompressedFlag(&work->systemManager, nextFileCompressedFlag);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FileSystemCommand_SetNextFileASyncLoadFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 enabled = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    s32 nextFileASyncLoadFlag;
    if (enabled != FALSE)
        nextFileASyncLoadFlag = TRUE;
    else
        nextFileASyncLoadFlag = FALSE;

    CutsceneFileSystemManager_SetNextFileASyncLoadFlag(&work->systemManager, nextFileASyncLoadFlag);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_AllocSpriteHandle(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    u16 animID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    u16 paletteRow   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R4);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);

    s32 handleSlot = CutsceneSpriteButtonManager_AllocSpriteHandle(&work->systemManager, path, fileID, useEngineB, animID, paletteRow);
    if (handleSlot == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_ReleaseSpriteHandle(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneSpriteButtonManager_ReleaseSpriteHandle(&work->systemManager, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_ReleaseAllSpriteHandles(ScriptThread *thread, CutsceneScript *work)
{
    u32 handleCount;

    handleCount = CutsceneSpriteButtonManager_GetSpriteHandleCount(&work->systemManager) + CUTSCENESCRIPT_ASSETSLOT_START;

    for (s32 i = CUTSCENESCRIPT_ASSETSLOT_START; i < handleCount; i++)
    {
        CutsceneSpriteButtonManager_ReleaseSpriteHandle(&work->systemManager, i);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_LoadSpriteResource(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 useEngineB   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    u16 animID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    u16 paletteRow   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R4);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R5);

    if (CutsceneSpriteButtonManager_LoadSpriteResource(&work->systemManager, handleSlot, path, fileID, useEngineB, animID, paletteRow) == FALSE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetAnimation(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 animID     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorSprite__SetAnimation(CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot), animID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpritePosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 x          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 y          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);
    animator->pos.x          = x;
    animator->pos.y          = y;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteVisible(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL visible   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);
    if (visible)
        animator->flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
    else
        animator->flags |= ANIMATOR_FLAG_DISABLE_DRAW;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteLoopFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL loopFlag  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);
    if (loopFlag)
        animator->flags &= ~ANIMATOR_FLAG_DID_LOOP;
    else
        animator->flags |= ANIMATOR_FLAG_DID_LOOP;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteFlip(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL flipX     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    BOOL flipY     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);

    if (flipX)
        animator->flags |= ANIMATOR_FLAG_FLIP_X;
    else
        animator->flags &= ~ANIMATOR_FLAG_FLIP_X;

    if (flipY)
        animator->flags |= ANIMATOR_FLAG_FLIP_Y;
    else
        animator->flags &= ~ANIMATOR_FLAG_FLIP_Y;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpritePriority(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s16 priority   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s16 order      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);

    if (priority != -1)
        animator->oamPriority = priority;

    if (order != -1)
        animator->oamOrder = order;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteType(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    GXOamMode type = (GXOamMode)CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);

    animator->spriteType = type;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_SetSpriteFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL flag      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    u32 *flagsPtr = CutsceneSpriteButtonManager_GetSpriteHandleFlags(&work->systemManager, handleSlot);

    if (flag)
        *flagsPtr &= ~1;
    else
        *flagsPtr |= 1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_GetSpritePosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);

    s16 x = animator->pos.x;
    s16 y = animator->pos.y;
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R1, x);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R2, y);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_GetSpritePalette(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    AnimatorSprite *animator = CutsceneSpriteButtonManager_GetSpriteHandleAnimator(&work->systemManager, handleSlot);

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R1, animator->cParam.palette);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_AddTouchArea(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    u16 flags      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 type       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    CutsceneSpriteButtonManager_AddTouchAreaToHandle(&work->systemManager, handleSlot, flags, type, work);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_RemoveTouchArea(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneSpriteButtonManager_RemoveTouchAreaFromHandle(&work->systemManager, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SpriteCommand_GetTouchAreaResponseFlags(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 mask       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    CutsceneTouchArea *touchArea = CutsceneSpriteButtonManager_GetSpriteHandleTouchArea(&work->systemManager, handleSlot);

    TouchAreaResponseFlags responseFlags = touchArea->area.responseFlags;
    if (mask != 0)
        responseFlags &= mask;

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R2, responseFlags);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BackgroundCommand_LoadBackgroundHandle(ScriptThread *thread, CutsceneScript *work)
{
    BOOL useEngineB  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    u8 bgID          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R3);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);

    s32 handleSlot = CutsceneBackgroundManager_LoadBackgroundResource(&work->systemManager, path, fileID, useEngineB, bgID);
    if (handleSlot == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BackgroundCommand_ReleaseBackgroundHandle(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneModelManager_ReleaseBackgroundHandle(&work->systemManager, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BackgroundCommand_ReleaseAllBackgroundHandles(ScriptThread *thread, CutsceneScript *work)
{
    u32 handleCount;

    handleCount = CutsceneBackgroundManager_GetBackgroundHandleCount(&work->systemManager) + CUTSCENESCRIPT_ASSETSLOT_START;

    for (s32 i = CUTSCENESCRIPT_ASSETSLOT_START; i < handleCount; i++)
    {
        CutsceneModelManager_ReleaseBackgroundHandle(&work->systemManager, i);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BackgroundCommand_SetBackgroundPosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 x          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 y          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    Background *bg = CutsceneBackgroundManager_GetBackgroundHandleBackground(&work->systemManager, handleSlot);
    bg->position.x = x;
    bg->position.y = y;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BackgroundCommand_SetBackgroundHandleFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 flag       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    u32 *flagsPtr = CutsceneBackgroundManager_GetBackgroundHandleFlags(&work->systemManager, handleSlot);

    if (flag)
        *flagsPtr &= ~1;
    else
        *flagsPtr |= 1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BackgroundCommand_SetBackgroundFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 id1  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    u8 id2   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 flag = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    u32 *flagsPtr = CutsceneBackgroundManager_GetBackgroundFlags(&work->systemManager, id1, id2);

    if (flag)
        *flagsPtr &= ~1;
    else
        *flagsPtr |= 1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_AllocModelHandle(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R1);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 id           = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    s32 handleSlot = CutsceneModelManager_AllocModelHandle(&work->systemManager, path, fileID, id);
    if (handleSlot == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_ReleaseModelHandle(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneModelManager_ReleaseModelHandle(&work->systemManager, handleSlot);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_ReleaseModelHandles(ScriptThread *thread, CutsceneScript *work)
{
    u32 handleCount = CutsceneModelManager_GetModelHandleCount(&work->systemManager);
    CutsceneModelManager_ResetRenderCallback(&work->systemManager);

    for (u32 i = CUTSCENESCRIPT_ASSETSLOT_START; i < handleCount + CUTSCENESCRIPT_ASSETSLOT_START; i++)
    {
        CutsceneModelManager_ReleaseModelHandle(&work->systemManager, i);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_LoadModelResource(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R1);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 id           = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    if (CutsceneModelManager_LoadModelResource(&work->systemManager, handleSlot, path, fileID, id) == FALSE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_LoadModelAnimResource(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot      = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 type            = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    const char *path    = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R2);
    s32 fileID          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 animID          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    const char *texPath = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R5);
    s32 texFileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R6);

    if (CutsceneModelManager_LoadModelAnimResource(&work->systemManager, handleSlot, type, path, fileID, animID, texPath, texFileID) == FALSE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelScale(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    fx32 x         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    fx32 y         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    fx32 z         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    AnimatorMDL *aniModel  = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);
    aniModel->work.scale.x = x;
    aniModel->work.scale.y = y;
    aniModel->work.scale.z = z;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelRotation(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    u16 x          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    u16 y          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    u16 z          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    AnimatorMDL *aniModel = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);

    MtxFx33 mtx;
    MtxFx33 mtxTemp;

    MTX_RotY33(&mtx, SinFX((s32)y), CosFX((s32)y));

    MTX_RotX33(&mtxTemp, SinFX((s32)x), CosFX((s32)x));
    MTX_Concat33(&mtx, &mtxTemp, &mtx);

    MTX_RotZ33(&mtxTemp, SinFX((s32)z), CosFX((s32)z));
    MTX_Concat33(&mtx, &mtxTemp, &mtx);

    MI_CpuCopy32(&mtx, &aniModel->work.rotation, sizeof(MtxFx33));

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelPosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    fx32 x         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    fx32 y         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    fx32 z         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    AnimatorMDL *aniModel        = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);
    aniModel->work.translation.x = x;
    aniModel->work.translation.y = y;
    aniModel->work.translation.z = z;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelPosition2(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    fx32 x         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    fx32 y         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    fx32 z         = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    AnimatorMDL *aniModel         = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);
    aniModel->work.translation2.x = x;
    aniModel->work.translation2.y = y;
    aniModel->work.translation2.z = z;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelVisible(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL enabled   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorMDL *aniModel = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);
    if (enabled)
        aniModel->work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
    else
        aniModel->work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelLoopFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL enabled   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorMDL *aniModel = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);
    if (enabled)
        aniModel->work.flags &= ~ANIMATOR_FLAG_DID_LOOP;
    else
        aniModel->work.flags |= ANIMATOR_FLAG_DID_LOOP;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelCanLoopFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    BOOL enabled   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorMDL *aniModel = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);

    if (enabled)
    {
        for (AnimatorMDLFlags *aniFlags = &aniModel->animFlags[0]; aniFlags != &aniModel->animFlags[B3D_ANIM_MAX]; aniFlags++)
        {
            *aniFlags |= ANIMATORMDL_FLAG_CAN_LOOP;
        }
    }
    else
    {
        for (AnimatorMDLFlags *aniFlags = &aniModel->animFlags[0]; aniFlags != &aniModel->animFlags[B3D_ANIM_MAX]; aniFlags++)
        {
            *aniFlags &= ~ANIMATORMDL_FLAG_CAN_LOOP;
        }
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_SetModelRenderCallback(ScriptThread *thread, CutsceneScript *work)
{
    s32 type       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 posY       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    if (handleSlot >= CUTSCENESCRIPT_ASSETSLOT_NONE)
        CutsceneModelManager_SetRenderCallback(&work->systemManager, type, handleSlot, posY);
    else
        CutsceneModelManager_ResetRenderCallback(&work->systemManager);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_LoadDrawState(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R0);

    s32 fileID = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    if (fileID < 0)
        fileID = ARCHIVEFILE_ID_NONE;

    void *memory = ArchiveFile__Load(path, fileID, NULL, ARCHIVEFILE_FLAG_NONE, NULL);
    CutsceneModelManager_LoadDrawState(&work->systemManager, memory);
    HeapFree(HEAP_USER, memory);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ModelCommand_CheckModelAnimFinished(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 resource   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    AnimatorMDL *aniModel = CutsceneModelManager_GetModelHandleModel(&work->systemManager, handleSlot);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R2, (aniModel->animFlags[resource] & ANIMATORMDL_FLAG_FINISHED) != 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArc(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript_GetFunctionParamString(thread, work, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneAudioManager_ResetSystem(&work->systemManager);
    LoadAudioSndArc(path);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_SetVolume(ScriptThread *thread, CutsceneScript *work)
{
    s32 musicVolume = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 sfxVolume   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 voiceVolume = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    if (musicVolume != -1)
        SetMusicVolume(musicVolume);

    if (sfxVolume != -1)
        SetSfxVolume(sfxVolume);

    if (voiceVolume != -1)
        SetVoiceVolume(voiceVolume);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_MoveVolume(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 volume     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 frames     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleSlot);
    if (frames == -1)
        NNS_SndPlayerSetVolume(handle, volume);
    else
        NNS_SndPlayerMoveVolume(handle, volume, frames);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcGroup(ScriptThread *thread, CutsceneScript *work)
{
    s32 groupNo = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    NNS_SndArcLoadGroup(groupNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcSeq(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqNo = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    NNS_SndArcLoadSeq(seqNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcSeqArc(ScriptThread *thread, CutsceneScript *work)
{
    s32 waveArcNo = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    NNS_SndArcLoadSeqArc(waveArcNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_LoadSndArcBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    NNS_SndArcLoadBank(seqArcNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_PlayTrack(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 frames     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    u32 handleID         = CutsceneAudioManager_AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleID);

    PlayTrack(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, handleSlot);
    NNS_SndPlayerMoveVolume(handle, AUDIOMANAGER_VOLUME_MAX, frames);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_PlayTrackEx(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 frames     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);

    u32 handleID         = CutsceneAudioManager_AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleID);

    PlayTrackEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, handleSlot);
    NNS_SndPlayerMoveVolume(handle, AUDIOMANAGER_VOLUME_MAX, frames);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_PlaySequence(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    u32 handleID         = CutsceneAudioManager_AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleID);

    PlaySfx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, handleSlot);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_PlaySequenceEx(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    u32 handleID         = CutsceneAudioManager_AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleID);

    PlaySfxEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, handleSlot);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_PlayVoiceClip(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    u32 handleID         = CutsceneAudioManager_AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleID);

    PlayVoiceClip(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, handleSlot);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_PlayVoiceClipEx(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    u32 handleID         = CutsceneAudioManager_AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleID);

    PlayVoiceClipEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, handleSlot);
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_FadeSeq(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 fadeFrame  = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleSlot);

    FadeOutStageSfx(handle, fadeFrame);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_FadeAllSeq(ScriptThread *thread, CutsceneScript *work)
{
    s32 fadeFrame = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    CutsceneAudioManager_StopAllSounds(&work->systemManager, fadeFrame);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_SetTrackPan(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 pan        = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleSlot);

    NNS_SndPlayerSetTrackPan(handle, 0xFFFF, pan);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SoundCommand_SetPlayerPriority(ScriptThread *thread, CutsceneScript *work)
{
    s32 handleSlot = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);
    s32 priority   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    NNSSndHandle *handle = CutsceneAudioManager_GetSoundHandle(&work->systemManager, handleSlot);

    NNS_SndPlayerSetPlayerPriority(handle, priority);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_Execute(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneTextManager *textManager = work->systemManager.textManager;

    return textManager->commandFunc(textManager->worker, thread, work);
}

void CutsceneScript_Main(void)
{
    CutsceneScript *work = TaskGetWorkCurrent(CutsceneScript);

    if (work->status == CUTSCENESCRIPT_STATUS_READY)
    {
        if (CutsceneScript_Run(work))
            work->status = CUTSCENESCRIPT_STATUS_IDLE;
        else
            ProcessCutsceneSystem(&work->systemManager);
    }
}

void CutsceneFade_Main(void)
{
    CutsceneFadeTask *work = TaskGetWorkCurrent(CutsceneFadeTask);

    work->timer += work->speed;

    fx32 brightness = work->timer;

    if (brightness >= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
        brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE);

    if ((work->flags & 0x10) != 0)
        brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE) - brightness;

    if ((work->flags & 1) == 0)
        brightness = -brightness;

    ProcessCutsceneFade(work->manager, work->mode, FX32_TO_WHOLE(brightness));

    if (work->timer >= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
        DestroyCurrentTask();
}

void InitCutsceneScriptProcessor(CutsceneScript *work, CutsceneScriptHeader *script, CutsceneScriptEngineCommand **funcTable, s32 unknown)
{
    MI_CpuClear32(&work->runner, sizeof(work->runner));
    work->runner.script = script;

    // NOTE: this will not work if ported to other architectures where sizeof(s32) != sizeof(void*)
    if (work->runner.script->rodataAddr < (size_t)script)
    {
        work->runner.script->rodataAddr += (size_t)script;
        work->runner.script->dataAddr += (size_t)script;
    }

    work->runner.funcTable = funcTable;
}

void ReleaseCutsceneScriptProcessor(CutsceneScript *work)
{
    for (ScriptThread **thread = work->runner.threads; thread != &work->runner.threads[8]; thread++)
    {
        if ((*thread) != NULL)
        {
            HeapFree(HEAP_SYSTEM, (*thread));
        }
    }

    MI_CpuClear32(&work->runner, sizeof(work->runner));
}

BOOL CutsceneScript_Run(CutsceneScript *work)
{
    ScriptThread **thread;

    s32 activeCount   = 0;
    BOOL needsDestroy = FALSE;

    for (thread = work->runner.threads; thread != &work->runner.threads[8]; thread++)
    {
        if ((*thread) != NULL)
        {
            CutsceneScriptResult result = CutsceneScript_ProcessThread(work, (*thread));
            switch (result)
            {
                case CUTSCENESCRIPT_RESULT_FINISH:
                    HeapFree(HEAP_SYSTEM, (*thread));
                    (*thread) = NULL;
                    break;

                case CUTSCENESCRIPT_RESULT_STOP_THREADS:
                    needsDestroy         = TRUE;
                    (*thread)->keepAlive = TRUE;
                    break;

                case CUTSCENESCRIPT_RESULT_SUSPEND:
                    activeCount++;
                    break;
            }
        }
    }

    if (needsDestroy)
    {
        activeCount = 0;
        for (thread = work->runner.threads; thread != &work->runner.threads[8]; thread++)
        {
            if ((*thread) != NULL)
            {
                if ((*thread)->keepAlive != TRUE)
                {
                    HeapFree(HEAP_SYSTEM, (*thread));
                    (*thread) = NULL;
                }
                else
                {
                    (*thread)->keepAlive = FALSE;
                    activeCount++;
                }
            }
        }
    }

    if (activeCount == 0)
    {
        if (work->runner.onFinish != NULL)
            work->runner.onFinish(work);

        return TRUE;
    }

    return FALSE;
}

ScriptThread *CutsceneScript_InitProcessor(CutsceneScript *work, CutsceneScriptOnFinish onFinish)
{
    for (ScriptThread **thread = work->runner.threads; thread != &work->runner.threads[8]; thread++)
    {
        if ((*thread) != NULL)
        {
            HeapFree(HEAP_USER, (*thread));
            (*thread) = NULL;
        }
    }

    // init .data section
    if (work->runner.script->dataSize != 0)
        MI_CpuCopy32((void *)work->runner.script->dataAddr, work->runner.data, work->runner.script->dataSize);

    // init .bss section
    if (work->runner.script->bssSize != 0)
        MI_CpuClear32(&work->runner.data[work->runner.script->dataSize], work->runner.script->bssSize);

    work->runner.onFinish = onFinish;

    return CutsceneScript_InitThread(work, work->runner.script->startAddr + CUTSCENESCRIPT_LOCATION_ROM);
}

ScriptThread *CutsceneScript_InitThread(CutsceneScript *work, u32 pc)
{
    return work->runner.threads[CutsceneScript_AllocThread(work, pc)];
}

CutsceneScriptSection CutsceneScript_GetAddressSection(u32 addr)
{
    return GetCutsceneScriptAddressSection(addr);
}

void *CutsceneScript_GetFunctionParamConstant(CutsceneScript *work, ScriptThread *thread, u32 addr)
{
    return CutsceneScript_GetAddressPointer(work, thread, addr);
}

s32 CutsceneScript_GetFunctionParamRegister(ScriptThread *thread, s32 id)
{
    return thread->registers[id];
}

const char *CutsceneScript_CutsceneScript_GetFunctionParamStringPointer(ScriptThread *thread, CutsceneScript *cutscene, s32 id)
{
    u32 addr = CutsceneScript_GetFunctionParamRegister(thread, id);
    if (addr == 0x00000000)
        return NULL;

    return CutsceneScript_GetFunctionParamConstant(cutscene, NULL, addr);
}

const char *CutsceneScript_GetFunctionParamString(ScriptThread *thread, CutsceneScript *cutscene, s32 id)
{
    return (const char *)CutsceneScript_CutsceneScript_GetFunctionParamStringPointer(thread, cutscene, id);
}

void CutsceneScript_SetRegister(ScriptThread *work, u32 id, s32 value)
{
    work->registers[id] = value;
}

CutsceneScriptResult CutsceneScript_ProcessThread(CutsceneScript *work, ScriptThread *thread)
{
    s32 pc;
    s32 *nextPC;

    s32 *pc_ptr;
    pc_ptr = &pc;

    ScriptCommand *command;

    CutsceneScriptResult result;
    do
    {
        pc = *CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);

        command = CutsceneScript_GetAddressPointer(work, thread, *pc_ptr);
        if (command->param2 != 0)
        {
            nextPC = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
            *nextPC += 3; // 3 * sizeof(s32)
        }
        else if (command->param1 != 0)
        {
            nextPC = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
            *nextPC += 2; // 2 * sizeof(s32)
        }
        else
        {
            nextPC = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
            *nextPC += 1; // 1 * sizeof(s32)
        }

        s32 type = (command->type >> 4) & 0xF;
        s32 id   = command->type & 0xF;
        result   = cutsceneScriptInstructionTable[type][id](work, thread, command);

        if (result == CUTSCENESCRIPT_RESULT_SUSPEND_RETURN)
        {
            *CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC) = pc;
            result                                                          = CUTSCENESCRIPT_RESULT_SUSPEND;
        }

    } while (result == CUTSCENESCRIPT_RESULT_CONTINUE);

    return result;
}

s32 *CutsceneScript_GetRegister(ScriptThread *work, u32 id)
{
    return &work->registers[id];
}

CutsceneScriptSection GetCutsceneScriptAddressSection(u32 addr)
{
    if (addr < CUTSCENESCRIPT_LOCATION_STACK)
        return CUTSCENESCRIPT_SECTION_DATA;

    if (addr < CUTSCENESCRIPT_LOCATION_ROM)
        return CUTSCENESCRIPT_SECTION_STACK;

    return CUTSCENESCRIPT_SECTION_ROM;
}

void *CutsceneScript_GetAddressPointer(CutsceneScript *work, ScriptThread *thread, u32 addr)
{
    u32 section = CutsceneScript_GetAddressSection(addr);

    switch (section)
    {
        case CUTSCENESCRIPT_SECTION_DATA:
            return &work->runner.data[addr];

        case CUTSCENESCRIPT_SECTION_STACK:
            return &thread->data[addr - CUTSCENESCRIPT_LOCATION_STACK];

        case CUTSCENESCRIPT_SECTION_ROM:
            return &work->runner.script->data[addr + CUTSCENESCRIPT_LOCATION_ROM];
    }

    return NULL;
}

void CutsceneScript_PushStack(ScriptThread *work, s32 value)
{
    s32 *sp = CutsceneScript_GetRegister(work, CUTSCENESCRIPT_REGISTER_SP);
    (*sp)--;

    *(s32 *)CutsceneScript_GetAddressPointer(NULL, work, *sp) = value;
}

s32 CutsceneScript_PopStack(ScriptThread *work)
{
    s32 *sp = CutsceneScript_GetRegister(work, CUTSCENESCRIPT_REGISTER_SP);

    return *(s32 *)CutsceneScript_GetAddressPointer(NULL, work, (*sp)++);
}

void *CutsceneScript_GetInstructionParam(s32 type, s32 *param, s32 unknown, CutsceneScript *work, ScriptThread *thread)
{
    s32 *paramPtr = param;
    switch (type & 3)
    {
        case 1:
            // param is a register (index)
            paramPtr = CutsceneScript_GetRegister(thread, *param);
            break;

        case 2:
            // param is a constant (script address)
            paramPtr = CutsceneScript_GetAddressPointer(work, thread, *param);
            break;

        case 3:
            // param is a constant value
            paramPtr = param;
            break;

        case 0:
            paramPtr = NULL;
            break;

        default:
            paramPtr = NULL;
            break;
    }

    s32 *reg;
    switch ((type >> 2) & 3)
    {
        case 1:
            paramPtr = CutsceneScript_GetAddressPointer(work, thread, *paramPtr);
            break;

        case 2:
            reg      = CutsceneScript_GetRegister(thread, (type >> 4));
            paramPtr = CutsceneScript_GetAddressPointer(work, thread, *paramPtr + *reg);
            break;
    }

    return paramPtr;
}

s32 CutsceneScript_AllocThread(CutsceneScript *work, u32 pc)
{
    s32 i = 0;

    ScriptThread **thread;
    for (i = 0; i < (s32)ARRAY_COUNT(work->runner.threads); i++)
    {
        thread = &work->runner.threads[i];

        if (*thread == NULL)
            break;
    }

    if (i >= 8)
        return -1;

    *thread = HeapAllocHead(HEAP_SYSTEM, sizeof(ScriptThread));
    MI_CpuClear32(*thread, sizeof(ScriptThread));

    *CutsceneScript_GetRegister(*thread, CUTSCENESCRIPT_REGISTER_SP) = CUTSCENESCRIPT_LOCATION_STACK + 0x100;
    *CutsceneScript_GetRegister(*thread, CUTSCENESCRIPT_REGISTER_PC) = pc;

    return i;
}

CutsceneScriptResult CutsceneScript_EndCommand_StopThreads(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_STOP_THREADS;
}

CutsceneScriptResult CutsceneScript_EndCommand_Continue(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_EndCommand_Suspend(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_SUSPEND;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Assign(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Add(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) += (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Subtract(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) -= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Multiply(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) *= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Divide(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);
    s32 *reg    = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT);

    (*reg)    = (*value1) % (*value2);
    (*value1) = (*value1) / (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Negate(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1) = -(*value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Increment(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1)++;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_Decrement(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1)--;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ArithmeticCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) >>= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_BitwiseAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) &= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_LogicalAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) != 0 && (*value2) != 0;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_BitwiseOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) |= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_LogicalOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) != 0 || (*value2) != 0;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_XOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) ^= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_BitwiseNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1) = ~(*value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_LogicalNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1) = !(*value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_ShiftL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) <<= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    u32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    u32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) >>= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_RotateL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

#define ROL(x, y) ((unsigned)(x) << (y) | (unsigned)(x) >> 32 - (y))
    (*value1) = ROL((*value1), (*value2));
#undef ROL

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BitwiseCommand_RotateR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

#define ROR(x, y) ((unsigned)(x) >> (y) | (unsigned)(x) << 32 - (y))
    (*value1) = ROR((*value1), (*value2));
#undef ROR

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ComparisonCommand_Equal(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) == (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ComparisonCommand_NotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) != (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ComparisonCommand_Less(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) < (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ComparisonCommand_LessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) <= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ComparisonCommand_Greater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) > (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_ComparisonCommand_GreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) >= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SwitchCommand_Case(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 15, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT);

    (*reg) = (*value1) - (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_SwitchCommand_Default(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 15, work, thread);
    s32 *value2 = CutsceneScript_GetInstructionParam(command->param2, GetScriptParam2(command), 15, work, thread);

    s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT);

    (*reg) = (*value1) & (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchAlways(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
    *reg += *value1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) == 0)
    {
        s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchNotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) != 0)
    {
        s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchGreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) < 0)
    {
        s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchGreater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) <= 0)
    {
        s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchLessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) > 0)
    {
        s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_BranchCommand_BranchLess(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) >= 0)
    {
        s32 *reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FunctionCommand_CallFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);
    s32 *reg    = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);

    CutsceneScript_PushStack(thread, *reg);

    reg = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
    *reg += *value1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FunctionCommand_EndFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 15, work, thread);

    s32 *reg1 = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_SP);
    *reg1 += *value1;

    if (*CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_SP) >= CUTSCENESCRIPT_LOCATION_STACK + 0x100)
        return CUTSCENESCRIPT_RESULT_FINISH;

    s32 *reg2 = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
    *reg2     = CutsceneScript_PopStack(thread);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FunctionCommand_CallFunctionASync(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 8, work, thread);
    s32 *reg    = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);

    u32 pc = *value1 + *reg;

    s32 *pc_ptr;
    pc_ptr = &pc;

    s32 id                                                              = CutsceneScript_AllocThread(work, *pc_ptr);
    *CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT) = id;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_FunctionCommand_End(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_FINISH;
}

CutsceneScriptResult CutsceneScript_EngineCommand_Execute(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s16 *value1      = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 15, work, thread);
    s32 *reg         = CutsceneScript_GetRegister(thread, CUTSCENESCRIPT_REGISTER_SP);
    void *commandPtr = CutsceneScript_GetAddressPointer(work, thread, *reg);

    return work->runner.funcTable[value1[1]][value1[0]](commandPtr, work);
}

CutsceneScriptResult CutsceneScript_StackCommand_Load(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 15, work, thread);

    CutsceneScript_PushStack(thread, *value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_StackCommand_Store(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript_GetInstructionParam(command->param1, GetScriptParam1(command), 3, work, thread);

    *value1 = CutsceneScript_PopStack(thread);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneFadeManager *GetCutsceneSystemFadeManager(CutsceneSystemManager *work)
{
    return work->fadeManager;
}

void InitCutsceneSystemFadeManager(CutsceneSystemManager *work)
{
    MI_CpuClear16(work, sizeof(*work));
    CreateCutsceneFadeManager(work);
}

void ReleaseCutsceneAssetSystem(CutsceneSystemManager *work)
{
    ReleaseCutsceneTextManager(work);
    ReleaseCutsceneAudioManager(work);
    ReleaseCutsceneModelManager(work);
    ReleaseCutsceneBackgroundManager(work);
    ReleaseCutsceneSpriteButtonManager(work);
    ReleaseCutsceneFileSystemManager(work);
    ReleaseCutsceneFadeManager(work);
}

void InitCutsceneFileSystemManager(CutsceneSystemManager *work, u32 handleCount)
{
    CreateCutsceneFileSystemManager(work, handleCount);
}

void *CutsceneFileSystemManager_GetFile(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return work->fileSystemManager->handleList[handleSlot].filePtr;
}

BOOL CutsceneFileSystemManager_CheckSingleReference(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return work->fileSystemManager->handleList[handleSlot].refCount == 1;
}

void CutsceneFileSystemManager_SetNextFileCompressedFlag(CutsceneSystemManager *work, BOOL isCompressed)
{
    work->fileSystemManager->loadCompressedFile = isCompressed != FALSE;
}

BOOL CutsceneFileSystemManager_GetNextFileCompressedFlag(CutsceneSystemManager *work)
{
    return work->fileSystemManager->loadCompressedFile != FALSE;
}

void CutsceneFileSystemManager_SetNextFileASyncLoadFlag(CutsceneSystemManager *work, BOOL loadASync)
{
    work->fileSystemManager->loadASync = loadASync != FALSE;
}

void CutsceneFileSystemManager_MountArchive(CutsceneSystemManager *work, s32 handleSlot, const char *arcName)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    if (work->fileSystemManager->handleList[handleSlot].fsArchive)
        CutsceneFileSystemManager_UnmountArchive(work, handleSlot);

    work->fileSystemManager->handleList[handleSlot].fsArchive = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->fileSystemManager->handleList[handleSlot].fsArchive));
    MI_CpuClear16(work->fileSystemManager->handleList[handleSlot].fsArchive, sizeof(*work->fileSystemManager->handleList[handleSlot].fsArchive));

    NNS_FndMountArchive(&work->fileSystemManager->handleList[handleSlot].fsArchive->arc, arcName, work->fileSystemManager->handleList[handleSlot].filePtr);
    work->fileSystemManager->handleList[handleSlot].fsArchive->name.value = ((CutsceneArchiveName *)arcName)->value;
}

void CutsceneFileSystemManager_UnmountArchive(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    NNS_FndUnmountArchive(&work->fileSystemManager->handleList[handleSlot].fsArchive->arc);

    HeapFree(HEAP_SYSTEM, work->fileSystemManager->handleList[handleSlot].fsArchive);
    work->fileSystemManager->handleList[handleSlot].fsArchive = NULL;
}

NONMATCH_FUNC s32 CutsceneFileSystemManager_AllocFileHandle(CutsceneSystemManager *work, const char *path, s32 fileID)
{
    // https://decomp.me/scratch/ehrrw -> 98.16%
#ifdef NON_MATCHING
    CutsceneFileSystemManager *manager;
    u32 i;

    manager = work->fileSystemManager;
    if (manager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    i = 0;
    for (; i < manager->handleCount; i++)
    {
        if (manager->handleList[i].refCount != 0 || manager->handleList[i].refCount == -1)
        {
            if (path == manager->handleList[i].path && fileID == manager->handleList[i].id)
            {
                if (manager->handleList[i].refCount == -1)
                    manager->handleList[i].refCount = 1;
                else
                    manager->handleList[i].refCount++;

                return CUTSCENESCRIPT_ASSETSLOT_START + i;
            }
        }
    }

    i = 0;
    for (; i < manager->handleCount; i++)
    {
        if (manager->handleList[i].refCount == 0)
        {
            break;
        }
    }

    return CutsceneFileSystemManager_LoadFile(work, i + CUTSCENESCRIPT_ASSETSLOT_START, path, fileID);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r5, [r0, #4]
	mov r3, r2
	ldr r4, [r5, #0x10]
	cmp r4, #0
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr ip, [r5]
	mov r2, #0
	cmp ip, #0
	bls _02156BB0
	ldr r6, [r5, #4]
	mov r4, r2
	mov lr, r6
	mvn r7, #0
_02156B44:
	ldr r8, [lr]
	cmp r8, #0
	bne _02156B5C
	ldr r8, [r6, r4]
	cmp r8, r7
	bne _02156B9C
_02156B5C:
	add r9, r6, r4
	ldr r8, [r9, #4]
	cmp r1, r8
	ldreq r8, [r9, #8]
	cmpeq r3, r8
	bne _02156B9C
	mov r0, #0x18
	mul r3, r2, r0
	ldr r1, [r6, r3]
	sub r0, r0, #0x19
	cmp r1, r0
	moveq r0, #1
	addne r0, r1, #1
	str r0, [r6, r3]
	add r0, r2, #1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02156B9C:
	add r2, r2, #1
	cmp r2, ip
	add lr, lr, #0x18
	add r4, r4, #0x18
	blo _02156B44
_02156BB0:
	cmp ip, #0
	mov r6, #0
	bls _02156BDC
	ldr r4, [r5, #4]
_02156BC0:
	ldr r2, [r4, #0]
	cmp r2, #0
	beq _02156BDC
	add r6, r6, #1
	cmp r6, ip
	add r4, r4, #0x18
	blo _02156BC0
_02156BDC:
	mov r2, r1
	add r1, r6, #1
	bl CutsceneFileSystemManager_LoadFile
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void CutsceneFileSystemManager_ReleaseFile(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    CutsceneArchive *archive = &work->fileSystemManager->handleList[handleSlot];

    archive->refCount--;
    if (archive->refCount == -1)
    {
        if (work->fileSystemManager->asyncFileHandle == handleSlot + CUTSCENESCRIPT_ASSETSLOT_START)
        {
            void *memory = ArchiveFile__JoinThread(&work->fileSystemManager->asyncFileWorker);
            if (memory != NULL)
                HeapFree(HEAP_SYSTEM, memory);

            ArchiveFile__Release(&work->fileSystemManager->asyncFileWorker);
            work->fileSystemManager->asyncFileHandle = 0;
            ArchiveFile__Init(&work->fileSystemManager->asyncFileWorker);
        }

        archive->refCount = 0;
    }

    if (archive->refCount == 0)
        ReleaseCutsceneFileSystemManagerFile(archive);
}

NONMATCH_FUNC s32 CutsceneFileSystemManager_LoadFile(CutsceneSystemManager *work, s32 handleSlot, const char *path, s32 fileID)
{
    // https://decomp.me/scratch/qZwcx -> 99.23%
#ifdef NON_MATCHING
    u32 i;
    u32 handleCount;
    CutsceneArchive *archive;
    BOOL foundHandleSlot;

    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    foundHandleSlot = FALSE;

    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return 0;

    archive = &work->fileSystemManager->handleList[handleSlot];
    ReleaseCutsceneFileSystemManagerFile(archive);

    if (fileID < 0)
    {
        fileID = ARCHIVEFILE_ID_NONE;
        if (path[3] == ':')
        {
            CutsceneArchiveName name = *(CutsceneArchiveName *)path;

            name.text[3] = 0;

            handleCount = work->fileSystemManager->handleCount;
            for (i = 0; i < handleCount; i++)
            {
                if (work->fileSystemManager->handleList[i].refCount != 0 && work->fileSystemManager->handleList[i].fsArchive != NULL
                    && name.value == work->fileSystemManager->handleList[i].fsArchive->name.value)
                {
                    archive->next    = &work->fileSystemManager->handleList[i];
                    archive->filePtr = NNS_FndGetArchiveFileByName(path);
                    foundHandleSlot  = TRUE;
                    work->fileSystemManager->handleList[i].refCount++;
                    break;
                }
            }
        }
    }

    archive->refCount = 1;
    archive->path     = path;
    archive->id       = fileID;

    if (foundHandleSlot == FALSE)
    {
        ArchiveFile *asyncFileWorker = work->fileSystemManager->loadASync != 0 ? &work->fileSystemManager->asyncFileWorker : NULL;
        ArchiveFileFlags flags       = work->fileSystemManager->loadCompressedFile != 0 ? ARCHIVEFILE_FLAG_IS_COMPRESSED : ARCHIVEFILE_FLAG_NONE;

        archive->filePtr = ArchiveFile__Load(path, fileID, NULL, flags, asyncFileWorker);

        if (work->fileSystemManager->loadASync != 0)
        {
            work->fileSystemManager->asyncFileHandle = handleSlot + CUTSCENESCRIPT_ASSETSLOT_START;
            archive->refCount                        = -1;

            return CUTSCENESCRIPT_ASSETSLOT_NONE;
        }
    }

    return handleSlot + CUTSCENESCRIPT_ASSETSLOT_START;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r4, [r10, #4]
	mov r9, r1
	ldr r0, [r4, #0x10]
	mov r8, r2
	cmp r0, #0
	mov r5, #0
	mov r7, r3
	addne sp, sp, #8
	movne r0, r5
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r2, [r4, #4]
	sub r1, r9, #1
	mov r0, #0x18
	mla r4, r1, r0, r2
	mov r0, r4
	bl ReleaseCutsceneFileSystemManagerFile
	cmp r7, #0
	bge _02156D8C
	ldrsb r0, [r8, #3]
	mvn r7, #0
	cmp r0, #0x3a
	bne _02156D8C
	ldr r2, [r10, #4]
	ldr r0, [r8, #0]
	ldr r1, [r2, #0]
	str r0, [sp, #4]
	mov r0, r5
	strb r0, [sp, #7]
	cmp r1, #0
	bls _02156D8C
	ldr ip, [r2, #4]
	ldr r6, [sp, #4]
	mov r2, ip
	mov r3, r0
_02156D1C:
	ldr lr, [r2]
	cmp lr, #0
	addne lr, ip, r3
	ldrne lr, [lr, #0x14]
	cmpne lr, #0
	beq _02156D78
	ldr lr, [lr, #0x68]
	cmp r6, lr
	bne _02156D78
	mov r1, #0x18
	mul r6, r0, r1
	add r1, ip, r6
	mov r0, r8
	str r1, [r4, #0x10]
	bl NNS_FndGetArchiveFileByName
	str r0, [r4, #0xc]
	ldr r0, [r10, #4]
	mov r5, #1
	ldr r1, [r0, #4]
	ldr r0, [r1, r6]
	add r0, r0, #1
	str r0, [r1, r6]
	b _02156D8C
_02156D78:
	add r0, r0, #1
	cmp r0, r1
	add r2, r2, #0x18
	add r3, r3, #0x18
	blo _02156D1C
_02156D8C:
	mov r0, #1
	stmia r4, {r0, r8}
	str r7, [r4, #8]
	cmp r5, #0
	bne _02156E04
	ldr r1, [r10, #4]
	ldr r0, [r1, #0xc]
	cmp r0, #0
	addne r2, r1, #0x14
	ldr r0, [r1, #8]
	moveq r2, #0
	cmp r0, #0
	movne r3, #1
	str r2, [sp]
	moveq r3, #0
	mov r0, r8
	mov r1, r7
	mov r2, #0
	bl ArchiveFile__Load
	str r0, [r4, #0xc]
	ldr r1, [r10, #4]
	ldr r0, [r1, #0xc]
	cmp r0, #0
	beq _02156E04
	str r9, [r1, #0x10]
	mvn r0, #0
	str r0, [r4]
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02156E04:
	mov r0, r9
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void InitCutsceneSpriteButtonManager(CutsceneSystemManager *work, u32 handleCount)
{
    CreateCutsceneSpriteButtonManager(work, handleCount);
    TouchField__Init(&work->spriteButtonManager->touchField);
}

u32 CutsceneSpriteButtonManager_GetSpriteHandleCount(CutsceneSystemManager *work)
{
    return work->spriteButtonManager->handleCount;
}

AnimatorSprite *CutsceneSpriteButtonManager_GetSpriteHandleAnimator(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return &work->spriteButtonManager->handleList[handleSlot].ani;
}

CutsceneTouchArea *CutsceneSpriteButtonManager_GetSpriteHandleTouchArea(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return work->spriteButtonManager->handleList[handleSlot].touchArea;
}

u32 *CutsceneSpriteButtonManager_GetSpriteHandleFlags(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return &work->spriteButtonManager->handleList[handleSlot].flags;
}

s32 CutsceneSpriteButtonManager_AllocSpriteHandle(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow)
{
    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    u32 i           = 0;
    u32 handleCount = work->spriteButtonManager->handleCount;
    for (; i < handleCount; i++)
    {
        if (work->spriteButtonManager->handleList[i].resourceFileHandle == CUTSCENESCRIPT_ASSETSLOT_NONE)
        {
            break;
        }
    }

    return CutsceneSpriteButtonManager_LoadSpriteResource(work, i + CUTSCENESCRIPT_ASSETSLOT_START, path, fileID, useEngineB, animID, paletteRow);
}

s32 CutsceneSpriteButtonManager_LoadSpriteResource(CutsceneSystemManager *work, s32 handleSlot, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    CutsceneSpriteButton *animator = &work->spriteButtonManager->handleList[handleSlot];

    ReleaseCutsceneSpriteButtonManagerSprite(animator, work);

    animator->resourceFileHandle = CutsceneFileSystemManager_AllocFileHandle(work, path, fileID);
    if (animator->resourceFileHandle == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    void *sprite = CutsceneFileSystemManager_GetFile(work, animator->resourceFileHandle);
    if (Sprite__GetFormatFromAnim(sprite, 0) != BAC_FORMAT_PLTT256_2D)
    {
        VRAMPaletteKey vramPalette = useEngineB != GRAPHICS_ENGINE_B ? VRAM_OBJ_PLTT : VRAM_DB_OBJ_PLTT;
        VRAMPixelKey vramPixels    = VRAMSystem__AllocSpriteVram(useEngineB, SpriteUnknown__GetSpriteSize(sprite, useEngineB));

        AnimatorSprite__Init(&animator->ani, sprite, animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, useEngineB, PIXEL_MODE_SPRITE, vramPixels,
                             PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    }
    else
    {
        PaletteMode paletteMode = useEngineB != GRAPHICS_ENGINE_B ? PALETTE_MODE_OBJ : PALETTE_MODE_SUB_OBJ;
        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, SpriteUnknown__GetSpriteSize(sprite, useEngineB));

        AnimatorSprite__Init(&animator->ani, sprite, animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, useEngineB, PIXEL_MODE_SPRITE, vramPixels,
                             paletteMode, NULL, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    }

    animator->ani.cParam.palette = paletteRow;

    return handleSlot + CUTSCENESCRIPT_ASSETSLOT_START;
}

void CutsceneSpriteButtonManager_AddTouchAreaToHandle(CutsceneSystemManager *work, s32 handleSlot, u32 flags, s32 type, CutsceneScript *cutscene)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    CutsceneSpriteButton *animator = &work->spriteButtonManager->handleList[handleSlot];

    if (animator->touchArea == NULL)
    {
        animator->touchArea = HeapAllocHead(HEAP_SYSTEM, sizeof(*animator->touchArea));
        MI_CpuClear16(animator->touchArea, sizeof(*animator->touchArea));
    }

    CutsceneSpriteButtonManager_AddTouchArea_Internal(animator->touchArea, &work->spriteButtonManager->touchField, &animator->ani, flags, cutscene, type);
}

void CutsceneSpriteButtonManager_RemoveTouchAreaFromHandle(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    CutsceneSpriteButton *animator = &work->spriteButtonManager->handleList[handleSlot];

    CutsceneSpriteButtonManager_RemoveTouchArea_Internal(animator->touchArea);

    HeapFree(HEAP_SYSTEM, animator->touchArea);
    animator->touchArea = NULL;
}

void CutsceneSpriteButtonManager_ReleaseSpriteHandle(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    ReleaseCutsceneSpriteButtonManagerSprite(&work->spriteButtonManager->handleList[handleSlot], work);
}

void InitCutsceneBackgroundManager(CutsceneSystemManager *work)
{
    CreateCutsceneBackgroundManager(work);
}

Background *CutsceneBackgroundManager_GetBackgroundHandleBackground(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return &work->backgroundManager->handleList[handleSlot].ani;
}

void *CutsceneBackgroundManager_GetBackgroundHandleFlags(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return &work->backgroundManager->handleList[handleSlot].flags;
}

void *CutsceneBackgroundManager_GetBackgroundFlags(CutsceneSystemManager *work, s32 useEngineB, s32 backgroundID)
{
    return &work->backgroundManager->handleList[backgroundID | (BACKGROUND_COUNT * useEngineB)].flags;
}

s32 CutsceneBackgroundManager_GetBackgroundHandleCount(CutsceneSystemManager *work)
{
    UNUSED(work);
    return GRAPHICS_ENGINE_COUNT * BACKGROUND_COUNT;
}

s32 CutsceneBackgroundManager_LoadBackgroundResource(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u8 bgID)
{
    PixelMode pixelMode;
    u16 screenBaseBlock;
    void *backgroundFile;

    s32 handleSlot = bgID | (BACKGROUND_COUNT * useEngineB);

    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    CutsceneBackground *background = &work->backgroundManager->handleList[handleSlot];
    ReleaseCutsceneBackgroundManagerBackground(background, work);
    background->resourceFileHandle = CutsceneFileSystemManager_AllocFileHandle(work, path, fileID);
    if (background->resourceFileHandle == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    backgroundFile = CutsceneFileSystemManager_GetFile(work, background->resourceFileHandle);
    if (CheckBackgroundIsValid(backgroundFile))
    {
        u32 flags = BACKGROUND_FLAG_LOAD_ALL | BACKGROUND_FLAG_SET_BG_Y | BACKGROUND_FLAG_SET_BG_X;

        u16 width  = GetBackgroundWidth(backgroundFile);
        u16 height = GetBackgroundHeight(backgroundFile);

        BOOL noPixels = FALSE;
        switch (GetBackgroundFormat(backgroundFile))
        {
                // Affine formatted backgrounds
            case BACKGROUND_FORMAT_AFFINE: {
                RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];

                RenderAffineControl *affineControl;
                if (bgID == BACKGROUND_2)
                    affineControl = &gfxControl->affineBG2;
                else
                    affineControl = &gfxControl->affineBG3;

                MTX_Identity22(&affineControl->matrix);
                affineControl->centerX = affineControl->centerY = 0;
                affineControl->x = affineControl->y = 0;
            }
                // fallthrough

                // Text formatted backgrounds
            case BACKGROUND_FORMAT_TEXT_16:
            case BACKGROUND_FORMAT_TEXT_256: {
                RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];

                if (width > BG_DISPLAY_FULL_WIDTH)
                {
                    flags |= BACKGROUND_FLAG_ALIGN_EVEN_WIDTH;
                    width = BG_DISPLAY_FULL_WIDTH;
                }

                if (height > BG_DISPLAY_SINGLE_HEIGHT)
                {
                    flags |= BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT;
                    height = BG_DISPLAY_SINGLE_HEIGHT;
                }

                gfxControl->bgPosition[bgID].x = gfxControl->bgPosition[bgID].y = 0;
            }
            break;

                // background formats without pixels?
            case BACKGROUND_FORMAT_BITMAP_256PLTT:
            case BACKGROUND_FORMAT_BITMAP_DIRECTCOLOR:
            case BACKGROUND_FORMAT_BITMAP_LARGE:
            case BACKGROUND_FORMAT_BITMAP_UNKNOWN: {
                RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];

                if (width > HW_LCD_WIDTH)
                {
                    flags |= BACKGROUND_FLAG_ALIGN_EVEN_WIDTH;
                    width = HW_LCD_WIDTH;
                }

                if (height > HW_LCD_HEIGHT)
                {
                    flags |= BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT;
                    height = HW_LCD_HEIGHT;
                }

                RenderAffineControl *affineControl;
                if (bgID == BACKGROUND_2)
                    affineControl = &gfxControl->affineBG2;
                else
                    affineControl = &gfxControl->affineBG3;

                MTX_Identity22(&affineControl->matrix);
                affineControl->centerX = affineControl->centerY = 0;
                affineControl->x = affineControl->y = 0;

                noPixels = TRUE;
            }
            break;
        }

        InitBackground(&background->ani, backgroundFile, flags, useEngineB, bgID, width, height);
        DrawBackground(&background->ani);

        background->ani.flags |= BACKGROUND_FLAG_DISABLE_PALETTE;

        if (!noPixels)
            background->ani.flags |= BACKGROUND_FLAG_DISABLE_PIXELS;

        if ((flags & (BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT | BACKGROUND_FLAG_ALIGN_EVEN_WIDTH)) == 0)
            background->ani.flags |= BACKGROUND_FLAG_DISABLE_MAPPINGS;

        if (useEngineB == GRAPHICS_ENGINE_A)
            ((GXRgb *)VRAM_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);
        else
            ((GXRgb *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);
    }
    else
    {
        // no clue what this is...
        // there don't seem to be any reference to this in the game's files?

        GetVRAMPixelConfig(useEngineB, bgID, &pixelMode, &screenBaseBlock);

        int baseBlock = 0x4000 * screenBaseBlock;
        CutsceneUnknownBackground__Func_215A124(backgroundFile, VRAMSystem__VRAM_BG[useEngineB] + baseBlock, HW_LCD_WIDTH, HW_LCD_HEIGHT);

        RenderAffineControl *affineControl;
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
        if (bgID == BACKGROUND_2)
            affineControl = &gfxControl->affineBG2;
        else
            affineControl = &gfxControl->affineBG3;

        MTX_Identity22(&affineControl->matrix);
        affineControl->centerX = affineControl->centerY = 0;
        affineControl->x = affineControl->y = 0;
    }

    return handleSlot + CUTSCENESCRIPT_ASSETSLOT_START;
}

void CutsceneModelManager_ReleaseBackgroundHandle(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    ReleaseCutsceneBackgroundManagerBackground(&work->backgroundManager->handleList[handleSlot], work);
}

void InitCutsceneModelManager(CutsceneSystemManager *work, u32 handleCount)
{
    CreateCutsceneModelManager(work, handleCount);
}

s32 CutsceneModelManager_GetModelHandleCount(CutsceneSystemManager *work)
{
    return work->modelManager->handleCount;
}

AnimatorMDL *CutsceneModelManager_GetModelHandleModel(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return &work->modelManager->handleList[handleSlot].ani;
}

s32 CutsceneModelManager_AllocModelHandle(CutsceneSystemManager *work, const char *path, s32 fileID, s32 id)
{
    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    u32 i           = 0;
    u32 handleCount = work->modelManager->handleCount;
    for (; i < handleCount; i++)
    {
        if (work->modelManager->handleList[i].resourceFileHandle[0] == CUTSCENESCRIPT_ASSETSLOT_NONE)
        {
            break;
        }
    }

    return CutsceneModelManager_LoadModelResource(work, i + CUTSCENESCRIPT_ASSETSLOT_START, path, fileID, id);
}

s32 CutsceneModelManager_LoadModelResource(CutsceneSystemManager *work, s32 handleSlot, const char *path, s32 fileID, s32 id)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    CutsceneModel *animator = &work->modelManager->handleList[handleSlot];

    ReleaseCutsceneModelManagerModel(animator, work);
    animator->resourceFileHandle[0] = CutsceneFileSystemManager_AllocFileHandle(work, path, fileID);
    if (animator->resourceFileHandle[0] == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return CUTSCENESCRIPT_ASSETSLOT_NONE;

    void *resMDL = CutsceneFileSystemManager_GetFile(work, animator->resourceFileHandle[0]);

    if (CutsceneFileSystemManager_CheckSingleReference(work, animator->resourceFileHandle[0]))
        NNS_G3dResDefaultSetup(resMDL);

    AnimatorMDL__Init(&animator->ani, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&animator->ani, resMDL, id, FALSE, FALSE);

    return handleSlot + CUTSCENESCRIPT_ASSETSLOT_START;
}

s32 CutsceneModelManager_LoadModelAnimResource(CutsceneSystemManager *work, s32 handleSlot, s32 type, const char *path, s32 fileID, s32 animID, const char *texPath, s32 texFileID)
{
    CutsceneModel *animator;
    void *resource;
    void *texResource;

    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;

    s32 pos = B3D_ANIM_RESOURCE_OFFSET + type;
    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        return FALSE;

    animator = &work->modelManager->handleList[handleSlot];

    if (animator->resourceFileHandle[pos] != CUTSCENESCRIPT_ASSETSLOT_NONE)
        CutsceneFileSystemManager_ReleaseFile(work, animator->resourceFileHandle[pos]);

    animator->resourceFileHandle[pos] = CutsceneFileSystemManager_AllocFileHandle(work, path, fileID);

    if (animator->resourceFileHandle[pos] == CUTSCENESCRIPT_ASSETSLOT_NONE)
        return FALSE;

    resource = CutsceneFileSystemManager_GetFile(work, animator->resourceFileHandle[pos]);

    if (type != B3D_ANIM_PAT_ANIM)
    {
        AnimatorMDL__SetAnimation(&animator->ani, type, resource, animID, NULL);
    }
    else
    {
        if (animator->texResourceFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        {
            CutsceneFileSystemManager_ReleaseFile(work, animator->texResourceFileHandle);
            animator->texResourceFileHandle = CUTSCENESCRIPT_ASSETSLOT_NONE;
        }

        if (texPath != NULL)
        {
            animator->texResourceFileHandle = CutsceneFileSystemManager_AllocFileHandle(work, texPath, texFileID);
            if (animator->texResourceFileHandle == CUTSCENESCRIPT_ASSETSLOT_NONE)
                return FALSE;

            if (CutsceneFileSystemManager_GetNextFileCompressedFlag(work))
                CutsceneFileSystemManager_ReleaseFile(work, animator->resourceFileHandle[pos]);

            texResource = CutsceneFileSystemManager_GetFile(work, animator->texResourceFileHandle);
            if (CutsceneFileSystemManager_CheckSingleReference(work, animator->texResourceFileHandle))
                NNS_G3dResDefaultSetup(texResource);
        }
        else
        {
            texResource = NNS_G3dGetTex(CutsceneFileSystemManager_GetFile(work, animator->resourceFileHandle[0]));
        }

        AnimatorMDL__SetAnimation(&animator->ani, type, resource, animID, texResource);
    }

    return TRUE;
}

void CutsceneModelManager_SetRenderCallback(CutsceneSystemManager *work, s32 type, s32 handleSlot, s32 posY)
{
    CutsceneModelManager_ResetRenderCallback(work);

    CutsceneModelManager *manager = work->modelManager;

    manager->camera.active      = type;
    manager->camera.modelHandle = handleSlot - CUTSCENESCRIPT_ASSETSLOT_START;
    manager->camera.posY        = posY;

    if (manager->camera.config.config.projScaleW != 0)
    {
        manager->camera.matProjPositionY = manager->camera.config.config.projScaleW + MultiplyFX(manager->camera.config.config.projScaleW, (posY / HW_LCD_HEIGHT));
    }
    else
    {
        manager->camera.matProjPositionY = FLOAT_TO_FX32(1.0) + (posY / HW_LCD_HEIGHT);
    }

    AnimatorMDL *animatorMDL         = CutsceneModelManager_GetModelHandleModel(work, handleSlot);
    animatorMDL->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;

    switch (type)
    {
        case 1:
            NNS_G3dRenderObjSetCallBack(&animatorMDL->renderObj, CutsceneModelManager_RenderCallback_Single, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
            if (Camera3D__GetTask() != NULL)
                Camera3D__Destroy();
            break;

        case 2:
            NNS_G3dRenderObjSetCallBack(&animatorMDL->renderObj, CutsceneModelManager_RenderCallback_Single, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
            if (Camera3D__GetTask() == NULL)
                Camera3D__Create();
            break;

        case 3:
            NNS_G3dRenderObjSetCallBack(&animatorMDL->renderObj, CutsceneModelManager_RenderCallback_Double, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
            if (Camera3D__GetTask() == NULL)
                Camera3D__Create();
            break;
    }

    MtxFx43 mtx;
    MI_CpuClear16(&mtx, sizeof(mtx));

    NNS_G3dGePushMtx();
    NNS_G3dGeLoadMtx43(&mtx);
    NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_SYS);
    NNS_G3dGePopMtx(1);

    NNS_G3dGePushMtx();
    mtx.m[3][2] = -FLOAT_TO_FX32(1.0);
    NNS_G3dGeLoadMtx43(&mtx);
    NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_USER);
    NNS_G3dGePopMtx(1);
}

void CutsceneModelManager_ResetRenderCallback(CutsceneSystemManager *work)
{
    CutsceneModelManager *manager = work->modelManager;

    if (manager->camera.active != 0)
    {
        AnimatorMDL *animatorMDL         = CutsceneModelManager_GetModelHandleModel(work, manager->camera.modelHandle + CUTSCENESCRIPT_ASSETSLOT_START);
        animatorMDL->work.matrixOpIDs[0] = MATRIX_OP_NONE;
        NNS_G3dRenderObjResetCallBack(&animatorMDL->renderObj);

        if (manager->camera.active == 2 || (s32)manager->camera.active == 3)
            Camera3D__Destroy();

        manager->camera.active = FALSE;
    }
}

void CutsceneModelManager_LoadDrawState(CutsceneSystemManager *work, void *memory)
{
    LoadDrawState(memory, DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT));

    CutsceneModelManager *manager = work->modelManager;

    GetDrawStateCameraProjection(memory, &manager->camera.config.config);

    manager->camera.config.lookAtUp.y = FLOAT_TO_FX32(1.0);

    if (manager->camera.posY != 0)
    {
        manager->camera.matProjPositionY = manager->camera.config.config.projScaleW + MultiplyFX(manager->camera.config.config.projScaleW, (manager->camera.posY / HW_LCD_HEIGHT));
    }
    else
    {
        manager->camera.matProjPositionY = manager->camera.config.config.projScaleW;
    }
}

void CutsceneModelManager_ReleaseModelHandle(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    ReleaseCutsceneModelManagerModel(&work->modelManager->handleList[handleSlot], work);
}

void InitCutsceneAudioManager(CutsceneSystemManager *work, u32 handleCount)
{
    CreateCutsceneAudioManager(work, handleCount);
}

void InitCutsceneTextManager(CutsceneSystemManager *work, CutsceneScriptTextCommand commandFunc, void (*processFunc)(CutsceneTextWorker *worker),
                             void (*releaseFunc)(CutsceneTextWorker *worker), size_t size)
{
    CreateCutsceneTextManager(work, size);

    CutsceneTextManager *manager = work->textManager;
    manager->commandFunc         = commandFunc;
    manager->processFunc         = processFunc;
    manager->releaseFunc         = releaseFunc;
}

void ProcessCutsceneSystem(CutsceneSystemManager *work)
{
    ProcessCutsceneFadeManager(work);
    ProcessCutsceneFileSystemManager(work);
    ProcessCutsceneSpriteButtonManager(work);
    ProcessCutsceneBackgroundManager(work);
    ProcessCutsceneModelManager(work);
    ProcessCutsceneAudioManager(work);
    ProcessCutsceneTextManager(work);
}

NNSSndHandle *CutsceneAudioManager_GetSoundHandle(CutsceneSystemManager *work, s32 handleSlot)
{
    handleSlot -= CUTSCENESCRIPT_ASSETSLOT_START;
    return work->audioManager->handleList[handleSlot].sndHandle;
}

s32 CutsceneAudioManager_AllocSoundHandle(CutsceneSystemManager *work)
{
    u32 i = 0;
    for (; i < work->audioManager->handleCount; i++)
    {
        if (work->audioManager->handleList[i].isActive == FALSE)
        {
            work->audioManager->handleList[i].isActive = TRUE;
            break;
        }
    }

    return i + CUTSCENESCRIPT_ASSETSLOT_START;
}

void CutsceneAudioManager_ResetSystem(CutsceneSystemManager *work)
{
    u32 prevCount = work->audioManager->handleCount;

    ReleaseCutsceneAudioManager(work);
    CreateCutsceneAudioManager(work, prevCount);
}

void CutsceneAudioManager_StopAllSounds(CutsceneSystemManager *work, s32 fadeFrame)
{
    CutsceneAudioHandle *listPtr = &work->audioManager->handleList[0];
    CutsceneAudioHandle *listEnd = &work->audioManager->handleList[work->audioManager->handleCount];

    for (; listPtr != listEnd; listPtr++)
    {
        if (listPtr->sndHandle != NULL)
            NNS_SndPlayerStopSeq(listPtr->sndHandle, fadeFrame);
    }
}

CutsceneTextWorker *CutsceneTextManager_GetWorker(CutsceneSystemManager *work)
{
    return work->textManager->worker;
}

void CutsceneModelManager_RenderCallback_Single(NNSG3dRS *rs)
{
    s32 node = NNS_G3dRSGetCurrentNodeDescID(rs);

    s32 cameraNodeIdx = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &cameraNodeName);
    if (cameraNodeIdx >= 0 && node == cameraNodeIdx)
    {
        NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_SYS);
    }

    s32 targetNodeIdx = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &targetNodeName);
    if (targetNodeIdx >= 0 && node == targetNodeIdx)
    {
        NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_USER);
    }
}

void CutsceneModelManager_RenderCallback_Double(NNSG3dRS *rs)
{
    s32 node = NNS_G3dRSGetCurrentNodeDescID(rs);

    switch (Camera3D__UseEngineA())
    {
        // case GRAPHICS_ENGINE_B:
        default: {
            s32 cameraNodeIdx = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &camera1NodeName);
            if (cameraNodeIdx >= 0 && node == cameraNodeIdx)
            {
                NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_SYS);
            }

            s32 targetNodeIdx = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &target1NodeName);
            if (targetNodeIdx >= 0 && node == targetNodeIdx)
            {
                NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_USER);
            }
        }
        break;

        case GRAPHICS_ENGINE_A: {
            s32 cameraNodeIdx = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &camera2NodeName);
            if (cameraNodeIdx >= 0 && node == cameraNodeIdx)
            {
                NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_SYS);
            }

            s32 targetNodeIdx = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &target2NodeName);
            if (targetNodeIdx >= 0 && node == targetNodeIdx)
            {
                NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_USER);
            }
        }
        break;
    }
}

void CutsceneModelManager_ConfigureCameraState(CutsceneCamera3D *work)
{
    MtxFx43 mtxLookAt;

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeRestoreMtx(NNS_G3D_MTXSTACK_SYS);
    NNS_G3dGetCurrentMtx(&mtxLookAt, NULL);
    work->config.lookAtTo.x = mtxLookAt.m[3][0];
    work->config.lookAtTo.y = mtxLookAt.m[3][1];
    work->config.lookAtTo.z = mtxLookAt.m[3][2];

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeRestoreMtx(NNS_G3D_MTXSTACK_USER);
    NNS_G3dGetCurrentMtx(&mtxLookAt, NULL);
    work->config.lookAtFrom.x = mtxLookAt.m[3][0];
    work->config.lookAtFrom.y = mtxLookAt.m[3][1];
    work->config.lookAtFrom.z = mtxLookAt.m[3][2];

    if (work->active == 2)
    {
        s32 matProjPositionY;
        if (Camera3D__UseEngineA() != GRAPHICS_ENGINE_A)
            matProjPositionY = -work->matProjPositionY;
        else
            matProjPositionY = work->matProjPositionY;

        work->config.config.matProjPosition.y = matProjPositionY;
    }
    else
    {
        work->config.config.matProjPosition.y = 0;
    }

    Camera3D__LoadState(&work->config);
}

void CreateCutsceneFadeManager(CutsceneSystemManager *work)
{
    work->fadeManager = HeapAllocHead(HEAP_SYSTEM, sizeof(CutsceneFadeManager));
    InitCutsceneFade(work->fadeManager);
}

void ReleaseCutsceneFadeManager(CutsceneSystemManager *work)
{
    HeapFree(HEAP_SYSTEM, work->fadeManager);
    work->fadeManager = NULL;
}

void ProcessCutsceneFadeManager(CutsceneSystemManager *work)
{
    CutsceneFadeManager *fadeManager = work->fadeManager;

    DrawCutsceneFade(fadeManager);
    InitCutsceneFade(fadeManager);
}

void CreateCutsceneFileSystemManager(CutsceneSystemManager *work, u32 handleCount)
{
    work->fileSystemManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->fileSystemManager));

    CutsceneFileSystemManager *manager = work->fileSystemManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->handleCount = handleCount;
    manager->handleList  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->handleList) * handleCount);
    MI_CpuClear32(manager->handleList, sizeof(*manager->handleList) * handleCount);

    ArchiveFile__Init(&manager->asyncFileWorker);
}

void ReleaseCutsceneFileSystemManagerFile(CutsceneArchive *work)
{
    if (work->filePtr != NULL)
    {
        if (work->fsArchive != NULL)
        {
            NNS_FndUnmountArchive(&work->fsArchive->arc);
            HeapFree(HEAP_SYSTEM, work->fsArchive);
        }

        if (work->next == NULL)
        {
            HeapFree(HEAP_USER, work->filePtr);
        }
        else
        {
            work->next->refCount--;

            if (work->next->refCount == 0)
                ReleaseCutsceneFileSystemManagerFile(work->next);
        }

        MI_CpuClear32(work, sizeof(*work));
    }
}

void ReleaseCutsceneFileSystemManager(CutsceneSystemManager *work)
{
    CutsceneFileSystemManager *manager = work->fileSystemManager;

    if (manager != NULL)
    {
        void *memory = ArchiveFile__JoinThread(&manager->asyncFileWorker);
        if (memory != NULL)
            HeapFree(HEAP_USER, memory);

        ArchiveFile__Release(&manager->asyncFileWorker);

        for (CutsceneArchive *archive = &manager->handleList[0]; archive != &manager->handleList[manager->handleCount]; archive++)
        {
            if (archive->refCount != 0)
                ReleaseCutsceneFileSystemManagerFile(archive);
        }

        HeapFree(HEAP_SYSTEM, manager->handleList);
        HeapFree(HEAP_SYSTEM, manager);
        work->fileSystemManager = NULL;
    }
}

void ProcessCutsceneFileSystemManager(CutsceneSystemManager *work)
{
    if (work->fileSystemManager->asyncFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
    {
        if (ArchiveFile__CheckThreadInactive(&work->fileSystemManager->asyncFileWorker))
        {
            CutsceneArchive *archive = &work->fileSystemManager->handleList[work->fileSystemManager->asyncFileHandle - CUTSCENESCRIPT_ASSETSLOT_START];

            archive->filePtr = ArchiveFile__JoinThread(&work->fileSystemManager->asyncFileWorker);
            ArchiveFile__Release(&work->fileSystemManager->asyncFileWorker);

            work->fileSystemManager->asyncFileHandle = CUTSCENESCRIPT_ASSETSLOT_NONE;
            ArchiveFile__Init(&work->fileSystemManager->asyncFileWorker);
        }
    }
}

void CreateCutsceneSpriteButtonManager(CutsceneSystemManager *work, u32 handleCount)
{
    work->spriteButtonManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->spriteButtonManager));

    CutsceneSpriteButtonManager *manager = work->spriteButtonManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->handleCount = handleCount;
    manager->handleList  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->handleList) * handleCount);
    MI_CpuClear32(manager->handleList, sizeof(*manager->handleList) * handleCount);
}

void ReleaseCutsceneSpriteButtonManagerSprite(CutsceneSpriteButton *work, CutsceneSystemManager *manager)
{
    if (work->resourceFileHandle != 0)
    {
        AnimatorSprite__Release(&work->ani);
        CutsceneFileSystemManager_ReleaseFile(manager, work->resourceFileHandle);

        if (work->touchArea != NULL)
        {
            CutsceneSpriteButtonManager_RemoveTouchArea_Internal(work->touchArea);
            HeapFree(HEAP_SYSTEM, work->touchArea);
        }

        MI_CpuClear32(work, sizeof(*work));
    }
}

void ReleaseCutsceneSpriteButtonManager(CutsceneSystemManager *work)
{
    CutsceneSpriteButtonManager *manager = work->spriteButtonManager;

    if (manager != NULL)
    {
        for (CutsceneSpriteButton *spriteButton = &manager->handleList[0]; spriteButton != &manager->handleList[manager->handleCount]; spriteButton++)
        {
            if (spriteButton->resourceFileHandle != 0)
                ReleaseCutsceneSpriteButtonManagerSprite(spriteButton, work);
        }

        HeapFree(HEAP_SYSTEM, manager->handleList);
        HeapFree(HEAP_SYSTEM, manager);
        work->spriteButtonManager = NULL;
    }
}

void ProcessCutsceneSpriteButtonManager(CutsceneSystemManager *work)
{
    CutsceneSpriteButtonManager *manager = work->spriteButtonManager;

    if (manager != NULL)
    {
        CutsceneSpriteButton *spriteButton;
        BOOL screenShook;
        s32 shakeX;
        s32 shakeY;

        if (ShakeScreen(SCREENSHAKE_CUSTOM))
        {
            s32 seed = GetScreenShakeOffsetY();

            shakeX      = FX32_TO_WHOLE(seed);
            shakeY      = FX32_TO_WHOLE(MultiplyFX(ShakeScreen(SCREENSHAKE_CUSTOM)->lifetime, FX32_TO_WHOLE(Task__Unknown204BE48__Func_204C104(seed)) >> 7));
            screenShook = TRUE;
        }
        else
        {
            shakeX      = 0;
            shakeY      = 0;
            screenShook = FALSE;
        }

        for (spriteButton = &manager->handleList[0]; spriteButton != &manager->handleList[manager->handleCount]; spriteButton++)
        {
            if (spriteButton->resourceFileHandle)
            {
                AnimatorSprite__ProcessAnimationFast(&spriteButton->ani);
                if (screenShook == FALSE || (spriteButton->flags & 1) != 0)
                {
                    AnimatorSprite__DrawFrame(&spriteButton->ani);
                }
                else
                {
                    spriteButton->ani.pos.x += shakeX;
                    spriteButton->ani.pos.y += shakeY;
                    AnimatorSprite__DrawFrame(&spriteButton->ani);
                    spriteButton->ani.pos.x -= shakeX;
                    spriteButton->ani.pos.y -= shakeY;
                }
            }
        }

        TouchField__Process(&work->spriteButtonManager->touchField);
    }
}

void CreateCutsceneBackgroundManager(CutsceneSystemManager *work)
{
    work->backgroundManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->backgroundManager));

    CutsceneBackgroundManager *manager = work->backgroundManager;

    MI_CpuClear32(manager, sizeof(*manager));
}

void ReleaseCutsceneBackgroundManagerBackground(CutsceneBackground *work, CutsceneSystemManager *manager)
{
    if (work->resourceFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        CutsceneFileSystemManager_ReleaseFile(manager, work->resourceFileHandle);

    MI_CpuClear32(work, sizeof(*work));
}

void ReleaseCutsceneBackgroundManager(CutsceneSystemManager *work)
{
    CutsceneBackgroundManager *manager = work->backgroundManager;

    if (manager != NULL)
    {
        for (CutsceneBackground *background = &manager->handleList[0]; background != &manager->handleList[(GRAPHICS_ENGINE_COUNT * BACKGROUND_COUNT)]; background++)
        {
            ReleaseCutsceneBackgroundManagerBackground(background, work);
        }

        HeapFree(HEAP_SYSTEM, manager);
        work->backgroundManager = NULL;
    }
}

void ProcessCutsceneBackgroundManager(CutsceneSystemManager *work)
{
    if (work->backgroundManager != NULL)
    {
        u32 i;
        u32 ii;
        CutsceneBackground *background;
        BOOL screenShook;
        s32 shakeX;
        s32 shakeY;

        if (ShakeScreen(SCREENSHAKE_CUSTOM) != NULL)
        {
            s32 seed = GetScreenShakeOffsetY();

            shakeX      = FX32_TO_WHOLE(seed);
            shakeY      = FX32_TO_WHOLE(MultiplyFX(ShakeScreen(SCREENSHAKE_CUSTOM)->lifetime, FX32_TO_WHOLE(Task__Unknown204BE48__Func_204C104(seed)) >> 7));
            screenShook = TRUE;
        }
        else
        {
            shakeX      = 0;
            shakeY      = 0;
            screenShook = FALSE;
        }

        for (i = 0, ii = 0; i < (GRAPHICS_ENGINE_COUNT * BACKGROUND_COUNT); i++, ii++)
        {
            background = &work->backgroundManager->handleList[ii];

            if (background->resourceFileHandle)
            {
                if (screenShook == FALSE || (background->flags & 1) != 0)
                {
                    DrawBackground(&background->ani);
                }
                else
                {
                    if ((background->ani.flags & (BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT)) != 0)
                    {
                        background->ani.position.x -= shakeX;
                        background->ani.position.y -= shakeY;
                        DrawBackground(&background->ani);
                        background->ani.position.x += shakeX;
                        background->ani.position.y += shakeY;
                    }
                    else
                    {
                        RenderCoreGFXControl *gfxControl = *(RenderCoreGFXControl **)((char *)VRAMSystem__GFXControl + (i & BACKGROUND_COUNT));
                        // RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i & BACKGROUND_COUNT]; // does not compile to matching?

                        gfxControl->bgPosition[i & 3].x = -shakeX;
                        gfxControl->bgPosition[i & 3].y = -shakeY;
                    }
                }
            }
            else
            {
                if ((background->flags & 1) == 0)
                {
                    u32 backgroundID   = i & 3;
                    u32 graphicsEngine = i & BACKGROUND_COUNT;

                    Vec2Fx16 *affinePos;
                    RenderCoreGFXControl *gfxControl = *(RenderCoreGFXControl **)((char *)VRAMSystem__GFXControl + graphicsEngine);
                    // RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[graphicsEngine]; // does not compile to matching?

                    gfxControl->bgPosition[backgroundID].x = -shakeX;
                    gfxControl->bgPosition[backgroundID].y = -shakeY;

                    switch (backgroundID)
                    {
                        default:
                            continue;

                        case BACKGROUND_2:
                            affinePos = (Vec2Fx16 *)&gfxControl->affineBG2.x;
                            break;

                        case BACKGROUND_3:
                            affinePos = (Vec2Fx16 *)&gfxControl->affineBG3.x;
                            break;
                    }

                    affinePos->x = -shakeX;
                    affinePos->y = -shakeY;
                }
            }
        }
    }
}

void CreateCutsceneModelManager(CutsceneSystemManager *work, u32 handleCount)
{
    work->modelManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->modelManager));

    CutsceneModelManager *manager = work->modelManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->handleCount = handleCount;
    manager->handleList  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->handleList) * handleCount);
    MI_CpuClear32(manager->handleList, sizeof(*manager->handleList) * handleCount);
}

void ReleaseCutsceneModelManagerModel(CutsceneModel *work, CutsceneSystemManager *manager)
{
    if (work->resourceFileHandle[0] != CUTSCENESCRIPT_ASSETSLOT_NONE)
    {
        for (u32 *animResource = &work->resourceFileHandle[1]; animResource != &work->resourceFileHandle[B3D_RESOURCE_MAX]; animResource++)
        {
            if (*animResource != 0)
            {
                if (CutsceneFileSystemManager_CheckSingleReference(manager, *animResource))
                {
                    NNS_G3dResDefaultRelease(CutsceneFileSystemManager_GetFile(manager, *animResource));
                }
                CutsceneFileSystemManager_ReleaseFile(manager, *animResource);
            }
        }

        if (work->texResourceFileHandle != CUTSCENESCRIPT_ASSETSLOT_NONE)
        {
            if (CutsceneFileSystemManager_CheckSingleReference(manager, work->texResourceFileHandle))
            {
                NNS_G3dResDefaultRelease(CutsceneFileSystemManager_GetFile(manager, work->texResourceFileHandle));
            }

            CutsceneFileSystemManager_ReleaseFile(manager, work->texResourceFileHandle);
        }

        if (CutsceneFileSystemManager_CheckSingleReference(manager, work->resourceFileHandle[0]))
        {
            NNS_G3dResDefaultRelease(CutsceneFileSystemManager_GetFile(manager, work->resourceFileHandle[0]));
        }

        CutsceneFileSystemManager_ReleaseFile(manager, work->resourceFileHandle[0]);

        AnimatorMDL__Release(&work->ani);
        MI_CpuClear32(work, sizeof(*work));
    }
}

void ReleaseCutsceneModelManager(CutsceneSystemManager *work)
{
    CutsceneModelManager *manager = work->modelManager;

    if (manager != NULL)
    {
        for (CutsceneModel *model = &manager->handleList[0]; model != &manager->handleList[manager->handleCount]; model++)
        {
            if (model->resourceFileHandle[0] != CUTSCENESCRIPT_ASSETSLOT_NONE)
                ReleaseCutsceneModelManagerModel(model, work);
        }

        if (work->modelManager->camera.active == 2 || (s32)work->modelManager->camera.active == 3)
        {
            Camera3D__Destroy();
            work->modelManager->camera.active = FALSE;
        }

        HeapFree(HEAP_SYSTEM, manager->handleList);
        HeapFree(HEAP_SYSTEM, manager);
        work->modelManager = NULL;
    }
}

void ProcessCutsceneModelManager(CutsceneSystemManager *work)
{
    CutsceneModelManager *manager = work->modelManager;

    if (manager != NULL)
    {
        if (manager->camera.active == 0)
        {
            for (CutsceneModel *model = &manager->handleList[0]; model != &manager->handleList[manager->handleCount]; model++)
            {
                if (model->resourceFileHandle[0] != CUTSCENESCRIPT_ASSETSLOT_NONE)
                {
                    AnimatorMDL__ProcessAnimation(&model->ani);
                    AnimatorMDL__Draw(&model->ani);
                }
            }
        }
        else
        {
            CutsceneModel *targetModel = &manager->handleList[manager->camera.modelHandle];

            AnimatorMDL__ProcessAnimation(&targetModel->ani);
            AnimatorMDL__Draw(&targetModel->ani);

            CutsceneModelManager_ConfigureCameraState(&manager->camera);

            for (CutsceneModel *model = &manager->handleList[0]; model != targetModel; model++)
            {
                if (model->resourceFileHandle[0] != CUTSCENESCRIPT_ASSETSLOT_NONE)
                {
                    AnimatorMDL__ProcessAnimation(&model->ani);
                    AnimatorMDL__Draw(&model->ani);
                }
            }

            if (targetModel != &manager->handleList[manager->handleCount] && ++targetModel != &manager->handleList[manager->handleCount])
            {
                for (; targetModel != &manager->handleList[manager->handleCount]; targetModel++)
                {
                    if (targetModel->resourceFileHandle[0] != CUTSCENESCRIPT_ASSETSLOT_NONE)
                    {
                        AnimatorMDL__ProcessAnimation(&targetModel->ani);
                        AnimatorMDL__Draw(&targetModel->ani);
                    }
                }
            }
        }
    }
}

void CreateCutsceneAudioManager(CutsceneSystemManager *work, u32 handleCount)
{
    ReleaseAudioSystem();

    work->audioManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->audioManager));

    CutsceneAudioManager *manager = work->audioManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->handleCount = handleCount;
    manager->handleList  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->handleList) * handleCount);
    MI_CpuClear32(manager->handleList, sizeof(*manager->handleList) * handleCount);

    for (CutsceneAudioHandle *handle = &manager->handleList[0]; handle != &manager->handleList[handleCount]; handle++)
    {
        handle->sndHandle = AllocSndHandle();
    }
}

void ReleaseCutsceneAudioManagerHandle(CutsceneAudioHandle *work, CutsceneSystemManager *manager)
{
    if (work->isActive)
    {
        NNS_SndPlayerStopSeq(work->sndHandle, 0);
        NNS_SndHandleReleaseSeq(work->sndHandle);
        work->isActive = FALSE;
    }
}

void ReleaseCutsceneAudioManager(CutsceneSystemManager *work)
{
    CutsceneAudioManager *manager = work->audioManager;

    if (manager != NULL)
    {
        for (CutsceneAudioHandle *handle = &manager->handleList[0]; handle != &manager->handleList[manager->handleCount]; handle++)
        {
            if (handle->sndHandle != NULL)
                ReleaseCutsceneAudioManagerHandle(handle, work);

            FreeSndHandle(handle->sndHandle);
        }

        ReleaseAudioSystem();
        HeapFree(HEAP_SYSTEM, manager->handleList);
        HeapFree(HEAP_SYSTEM, manager);
        work->audioManager = NULL;
    }
}

void ProcessCutsceneAudioManager(CutsceneSystemManager *work)
{
    CutsceneAudioHandle *handle;
    CutsceneAudioManager *manager = work->audioManager;

    if (manager != NULL)
    {
        for (handle = &manager->handleList[0]; handle != &manager->handleList[manager->handleCount]; handle++)
        {
            if (handle->sndHandle != NULL)
            {
                if (!NNS_SndHandleIsValid(handle->sndHandle))
                    ReleaseCutsceneAudioManagerHandle(handle, work);
            }
        }
    }
}

void CreateCutsceneTextManager(CutsceneSystemManager *work, size_t size)
{
    work->textManager = HeapAllocHead(HEAP_SYSTEM, sizeof(CutsceneTextManager));

    CutsceneTextManager *manager = work->textManager;
    MI_CpuClear32(work->textManager, sizeof(*work->textManager));

    manager->worker = HeapAllocHead(HEAP_SYSTEM, size);
    MI_CpuClear32(manager->worker, size);
}

void ReleaseCutsceneTextManager(CutsceneSystemManager *work)
{
    CutsceneTextManager *manager = work->textManager;

    if (manager != NULL)
    {
        if (manager->releaseFunc != NULL)
            manager->releaseFunc(manager->worker);

        if (manager->worker != NULL)
        {
            HeapFree(HEAP_SYSTEM, manager->worker);
            manager->worker = NULL;
        }

        HeapFree(HEAP_SYSTEM, manager);
        work->textManager = NULL;
    }
}

void ProcessCutsceneTextManager(CutsceneSystemManager *work)
{
    if (work->textManager->processFunc != NULL)
        work->textManager->processFunc(work->textManager->worker);
}

void CutsceneDisplay_ConfigureBackgroundText(BOOL useEngineB, u8 backgroundID, s32 screenSize, s32 colorMode, s32 screenBase, s32 charBase)
{
    s32 bgMode;
    s32 id = backgroundID | (useEngineB << 4);

    switch (id)
    {
        case (GRAPHICS_ENGINE_A << 4) | BACKGROUND_0:
            G2_SetBG0Control((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase, GX_BG_EXTPLTT_01);
            break;

        case (GRAPHICS_ENGINE_A << 4) | BACKGROUND_1:
            G2_SetBG1Control((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase, GX_BG_EXTPLTT_01);
            break;

        case (GRAPHICS_ENGINE_A << 4) | BACKGROUND_2:
            bgMode = *((u32 *)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK;

            if (bgMode <= GX_BGMODE_1 || bgMode == GX_BGMODE_3)
            {
                G2_SetBG2ControlText((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            else if (bgMode <= GX_BGMODE_5)
            {
                G2_SetBG2ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            break;

        case (GRAPHICS_ENGINE_A << 4) | BACKGROUND_3:
            bgMode = *((u32 *)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK;

            if (bgMode <= GX_BGMODE_0)
            {
                G2_SetBG3ControlText((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            else if (bgMode <= GX_BGMODE_5)
            {
                G2_SetBG3ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            break;

        case (GRAPHICS_ENGINE_B << 4) | BACKGROUND_0:
            G2S_SetBG0Control((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase, GX_BG_EXTPLTT_01);
            break;

        case (GRAPHICS_ENGINE_B << 4) | BACKGROUND_1:
            G2S_SetBG1Control((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase, GX_BG_EXTPLTT_01);
            break;

        case (GRAPHICS_ENGINE_B << 4) | BACKGROUND_2:
            bgMode = *((u32 *)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK;

            if (bgMode <= GX_BGMODE_1 || bgMode == GX_BGMODE_3)
            {
                G2S_SetBG2ControlText((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            else if (bgMode <= GX_BGMODE_5)
            {
                G2S_SetBG2ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            break;

        case (GRAPHICS_ENGINE_B << 4) | BACKGROUND_3:
            bgMode = *((u32 *)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK;

            if (bgMode <= GX_BGMODE_0)
            {
                G2S_SetBG3ControlText((GXBGScrSizeText)screenSize, (GXBGColorMode)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            else if (bgMode <= GX_BGMODE_5)
            {
                G2S_SetBG3ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)colorMode, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            }
            break;
    }
}

NONMATCH_FUNC void CutsceneDisplay_ConfigureBackgroundExtended(BOOL useEngineB, s32 type, s32 backgroundID, s32 screenSize, s32 areaOver, s32 screenBase, s32 charBase)
{
    // https://decomp.me/scratch/hbB0N -> 92.26%
#ifdef NON_MATCHING
    s32 bgMode;
    s32 id = (type << 4) | backgroundID | (useEngineB << 8);

    bgMode = *((u32 *)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK;

    switch (id)
    {
        case 0x20:
            G2_SetBG2ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)areaOver, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            break;

        case 0x21:
            G2_SetBG2Control256Bmp((GXBGScrSize256Bmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x22:
            G2_SetBG2ControlDCBmp((GXBGScrSizeDcBmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x23:
            G2_SetBG2ControlLargeBmp((GXBGScrSizeLargeBmp)screenSize, (GXBGAreaOver)areaOver);
            break;

        case 0x30:
            G2_SetBG3ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)areaOver, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            break;

        case 0x31:
            G2_SetBG3Control256Bmp((GXBGScrSize256Bmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x32:
            G2_SetBG3ControlDCBmp((GXBGScrSizeDcBmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x120:
            G2S_SetBG2ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)areaOver, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            break;

        case 0x121:
            G2S_SetBG2Control256Bmp((GXBGScrSize256Bmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x122:
            G2S_SetBG2ControlDCBmp((GXBGScrSizeDcBmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x130:
            G2S_SetBG3ControlAffine((GXBGScrSizeAffine)screenSize, (GXBGAreaOver)areaOver, (GXBGScrBase)screenBase, (GXBGCharBase)charBase);
            break;

        case 0x131:
            G2S_SetBG3Control256Bmp((GXBGScrSize256Bmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;

        case 0x132:
            G2S_SetBG3ControlDCBmp((GXBGScrSizeDcBmp)screenSize, (GXBGAreaOver)areaOver, (GXBGBmpScrBase)screenBase);
            break;
    }

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    RenderAffineControl *affineControl;
    if (backgroundID == BACKGROUND_2)
        affineControl = &gfxControl->affineBG2;
    else
        affineControl = &gfxControl->affineBG3;
    MTX_Identity22(&affineControl->matrix);
    affineControl->x = affineControl->y = 0;
    affineControl->centerX = affineControl->centerY = 0;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, =VRAMSystem__DisplayControllers
	mov r4, r1, lsl #4
	orr r4, r4, r0, lsl #8
	ldr r6, [r5, r0, lsl #2]
	orr r5, r2, r4
	cmp r5, #0x120
	ldr lr, [sp, #0x10]
	ldr ip, [sp, #0x14]
	ldr r2, [sp, #0x18]
	ldr r4, [r6, #0]
	bgt _02158DBC
	cmp r5, #0x120
	bge _02158F04
	cmp r5, #0x30
	bgt _02158DA0
	bge _02158E98
	sub r4, r5, #0x20
	cmp r4, #3
	addls pc, pc, r4, lsl #2
	b _02158FD8
_02158D90: // jump table
	b _02158E10 // case 0
	b _02158E34 // case 1
	b _02158E58 // case 2
	b _02158E7C // case 3
_02158DA0:
	cmp r5, #0x31
	bgt _02158DB0
	beq _02158EBC
	b _02158FD8
_02158DB0:
	cmp r5, #0x32
	beq _02158EE0
	b _02158FD8
_02158DBC:
	cmp r5, #0x130
	bgt _02158DEC
	bge _02158F70
	ldr r2, =0x00000121
	cmp r5, r2
	bgt _02158DDC
	beq _02158F28
	b _02158FD8
_02158DDC:
	add r2, r2, #1
	cmp r5, r2
	beq _02158F4C
	b _02158FD8
_02158DEC:
	ldr r2, =0x00000131
	cmp r5, r2
	bgt _02158E00
	beq _02158F94
	b _02158FD8
_02158E00:
	add r2, r2, #1
	cmp r5, r2
	beq _02158FB8
	b _02158FD8
_02158E10:
	ldr r5, =0x0400000C
	ldrh r4, [r5, #0]
	and r4, r4, #0x43
	orr r3, r4, r3, lsl #14
	orr r2, r3, r2, lsl #2
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r5]
	b _02158FD8
_02158E34:
	ldr r4, =0x0400000C
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x80
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158E58:
	ldr r4, =0x0400000C
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x84
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158E7C:
	ldr r4, =0x0400000C
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158E98:
	ldr r5, =0x0400000E
	ldrh r4, [r5, #0]
	and r4, r4, #0x43
	orr r3, r4, r3, lsl #14
	orr r2, r3, r2, lsl #2
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r5]
	b _02158FD8
_02158EBC:
	ldr r4, =0x0400000E
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x80
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158EE0:
	ldr r4, =0x0400000E
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x84
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158F04:
	ldr r5, =0x0400100C
	ldrh r4, [r5, #0]
	and r4, r4, #0x43
	orr r3, r4, r3, lsl #14
	orr r2, r3, r2, lsl #2
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r5]
	b _02158FD8
_02158F28:
	ldr r4, =0x0400100C
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x80
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158F4C:
	ldr r4, =0x0400100C
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x84
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158F70:
	ldr r5, =0x0400100E
	ldrh r4, [r5, #0]
	and r4, r4, #0x43
	orr r3, r4, r3, lsl #14
	orr r2, r3, r2, lsl #2
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r5]
	b _02158FD8
_02158F94:
	ldr r4, =0x0400100E
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x80
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
	b _02158FD8
_02158FB8:
	ldr r4, =0x0400100E
	ldrh r2, [r4, #0]
	and r2, r2, #0x43
	orr r2, r2, r3, lsl #14
	orr r2, r2, #0x84
	orr r2, r2, ip, lsl #8
	orr r2, r2, lr, lsl #13
	strh r2, [r4]
_02158FD8:
	ldr r2, =VRAMSystem__GFXControl
	cmp r1, #2
	ldr r0, [r2, r0, lsl #2]
	addeq r4, r0, #0x28
	addne r4, r0, #0x40
	mov r0, r4
	bl MTX_Identity22_
	mov r0, #0
	strh r0, [r4, #0x12]
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x16]
	strh r0, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void CutsceneDisplay_SetupOBJBank(GXVRamOBJ bank, u16 bankOffset)
{
    switch (bank)
    {
        case GX_VRAM_OBJ_128_A:
        case GX_VRAM_OBJ_128_B:
            VRAMSystem__SetupOBJBank(bank, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x400);
            break;

        case GX_VRAM_OBJ_256_AB:
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_256_AB, GX_OBJVRAMMODE_CHAR_1D_256K, GX_OBJVRAMMODE_BMP_1D_256K, bankOffset, 0x400);
            break;

        case GX_VRAM_OBJ_64_E:
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x400);
            break;

        case GX_VRAM_OBJ_16_F:
        case GX_VRAM_OBJ_16_G:
            VRAMSystem__SetupOBJBank(bank, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x200);
            break;

        case GX_VRAM_OBJ_80_EF:
        case GX_VRAM_OBJ_80_EG:
            VRAMSystem__SetupOBJBank(bank, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x280);
            break;

        case GX_VRAM_OBJ_32_FG:
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x400);
            break;

        case GX_VRAM_OBJ_96_EFG:
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_96_EFG, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x300);
            break;

        case GX_VRAM_SUB_OBJ_NONE:
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x000);
            break;
    }
}

void CutsceneDisplay_SetupSubOBJBank(GXVRamSubOBJ bank, u16 bankOffset)
{
    switch (bank)
    {
        case GX_VRAM_SUB_OBJ_128_D:
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x400);
            break;

        case GX_VRAM_SUB_OBJ_16_I:
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, bankOffset, 0x200);
            break;

        case GX_VRAM_SUB_OBJ_NONE:
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
            break;
    }
}

u32 CutsceneDisplay_GetBankID(s32 a1)
{
    u32 array[] = { 0, 1, 2, 3, 8, 9, 11, 4, 5, 6, 7, 11, 11 };
    return array[BankUnknown__GetBankID(a1)];
}

void InitCutsceneFade(CutsceneFadeManager *work)
{
    MI_CpuClear16(work, sizeof(*work));
}

void ProcessCutsceneFade(CutsceneFadeManager *work, s32 mode, s32 timer)
{
    switch (mode)
    {
        case 1:
        case 2:
        case 3:
            if (mode == 1 || mode == 2)
            {
                if ((work->flags & 1) != 0)
                {
                    if ((work->control[GRAPHICS_ENGINE_A].brightness1 >= RENDERCORE_BRIGHTNESS_DEFAULT || timer < 0)
                        && (work->control[GRAPHICS_ENGINE_A].brightness1 <= RENDERCORE_BRIGHTNESS_DEFAULT || timer > 0))
                    {
                        if (MATH_ABS(timer) > MATH_ABS(work->control[GRAPHICS_ENGINE_A].brightness1))
                        {
                        }
                        else
                        {
                            goto SKIP_BRIGNTNESS_SET_A;
                        }
                    }
                    else
                    {
                        goto SKIP_BRIGNTNESS_SET_A;
                    }
                }
                else
                {
                    work->flags |= 1;
                }

                // TODO: see if this logic can be written to match without the goto!
                work->control[GRAPHICS_ENGINE_A].brightness1 = timer;

            SKIP_BRIGNTNESS_SET_A:
            }

            if (mode == 1 || mode == 3)
            {
                if ((work->flags & 2) != 0)
                {
                    if ((work->control[GRAPHICS_ENGINE_B].brightness1 >= RENDERCORE_BRIGHTNESS_DEFAULT || timer < 0)
                        && (work->control[GRAPHICS_ENGINE_B].brightness1 <= RENDERCORE_BRIGHTNESS_DEFAULT || timer > 0))
                    {
                        if (MATH_ABS(timer) > MATH_ABS(work->control[GRAPHICS_ENGINE_B].brightness1))
                        {
                        }
                        else
                        {
                            goto SKIP_BRIGNTNESS_SET_B;
                        }
                    }
                    else
                    {
                        goto SKIP_BRIGNTNESS_SET_B;
                    }
                }
                else
                {
                    work->flags |= 2;
                }

                // TODO: see if this logic can be written to match without the goto!
                work->control[GRAPHICS_ENGINE_B].brightness1 = timer;

            SKIP_BRIGNTNESS_SET_B:
            }
            break;

        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            work->control[GRAPHICS_ENGINE_A].mode        = mode;
            work->control[GRAPHICS_ENGINE_A].brightness2 = timer;
            break;

        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
            work->control[GRAPHICS_ENGINE_B].mode        = mode;
            work->control[GRAPHICS_ENGINE_B].brightness2 = timer;
            break;
    }
}

RUSH_INLINE void ApplyCutsceneFade(CutsceneFadeManager *work, BOOL useEngineB)
{
    if (useEngineB == FALSE)
    {
        switch (work->control[GRAPHICS_ENGINE_A].mode)
        {
            default:
                return;

            case 4:
                renderCoreGFXControlA.blendManager.blendControl.value      = 0;
                renderCoreGFXControlA.blendManager.blendControl.plane1_BG0 = TRUE;
                break;

            case 5:
                renderCoreGFXControlA.blendManager.blendControl.value      = 0;
                renderCoreGFXControlA.blendManager.blendControl.plane1_BG1 = TRUE;
                break;

            case 6:
                renderCoreGFXControlA.blendManager.blendControl.value      = 0;
                renderCoreGFXControlA.blendManager.blendControl.plane1_BG2 = TRUE;
                break;

            case 7:
                renderCoreGFXControlA.blendManager.blendControl.value      = 0;
                renderCoreGFXControlA.blendManager.blendControl.plane1_BG3 = TRUE;
                break;

            case 8:
                renderCoreGFXControlA.blendManager.blendControl.value      = 0;
                renderCoreGFXControlA.blendManager.blendControl.plane1_OBJ = TRUE;
                break;

            case 9:
                renderCoreGFXControlA.blendManager.blendControl.value           = 0;
                renderCoreGFXControlA.blendManager.blendControl.plane1_Backdrop = TRUE;
                break;
        }

        if (work->control[GRAPHICS_ENGINE_A].brightness2 >= RENDERCORE_BRIGHTNESS_DEFAULT)
        {
            renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_FADEIN;
            renderCoreGFXControlA.blendManager.coefficient.value   = work->control[GRAPHICS_ENGINE_A].brightness2;
        }
        else
        {
            renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_FADEOUT;
            renderCoreGFXControlA.blendManager.coefficient.value   = -work->control[GRAPHICS_ENGINE_A].brightness2;
        }
    }
    else
    {
        switch (work->control[GRAPHICS_ENGINE_B].mode)
        {
            default:
                return;

            case 10:
                renderCoreGFXControlB.blendManager.blendControl.value      = 0;
                renderCoreGFXControlB.blendManager.blendControl.plane1_BG0 = TRUE;
                break;

            case 11:
                renderCoreGFXControlB.blendManager.blendControl.value      = 0;
                renderCoreGFXControlB.blendManager.blendControl.plane1_BG1 = TRUE;
                break;

            case 12:
                renderCoreGFXControlB.blendManager.blendControl.value      = 0;
                renderCoreGFXControlB.blendManager.blendControl.plane1_BG2 = TRUE;
                break;

            case 13:
                renderCoreGFXControlB.blendManager.blendControl.value      = 0;
                renderCoreGFXControlB.blendManager.blendControl.plane1_BG3 = TRUE;
                break;

            case 14:
                renderCoreGFXControlB.blendManager.blendControl.value      = 0;
                renderCoreGFXControlB.blendManager.blendControl.plane1_OBJ = TRUE;
                break;

            case 15:
                renderCoreGFXControlB.blendManager.blendControl.value           = 0;
                renderCoreGFXControlB.blendManager.blendControl.plane1_Backdrop = TRUE;
                break;
        }

        if (work->control[GRAPHICS_ENGINE_B].brightness2 >= RENDERCORE_BRIGHTNESS_DEFAULT)
        {
            renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_FADEIN;
            renderCoreGFXControlB.blendManager.coefficient.value   = work->control[GRAPHICS_ENGINE_B].brightness2;
        }
        else
        {
            renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_FADEOUT;
            renderCoreGFXControlB.blendManager.coefficient.value   = -work->control[GRAPHICS_ENGINE_B].brightness2;
        }
    }
}

void DrawCutsceneFade(CutsceneFadeManager *work)
{
    if ((work->flags & 1) != 0)
        renderCoreGFXControlA.brightness = work->control[GRAPHICS_ENGINE_A].brightness1;

    if ((work->flags & 2) != 0)
        renderCoreGFXControlB.brightness = work->control[GRAPHICS_ENGINE_B].brightness1;

    ApplyCutsceneFade(work, GRAPHICS_ENGINE_A);
    ApplyCutsceneFade(work, GRAPHICS_ENGINE_B);
}

void CutsceneSpriteButtonManager_AddTouchArea_Internal(CutsceneTouchArea *work, TouchField *touchField, AnimatorSprite *animator, u32 flags, CutsceneScript *cutscene, s32 type)
{
    if (work->touchField == NULL)
    {
        work->animator = animator;
        work->dword40  = 0;
        work->cutscene = cutscene;
        work->type     = type;

        if (type != 0)
            TouchField__InitAreaSprite(&work->area, animator, flags, 0, (TouchAreaCallback)CutsceneSpriteButtonManager_TouchAreaCallback, INT_TO_VOID(type));
        else
            TouchField__InitAreaSprite(&work->area, animator, flags, 0, NULL, 0);

        work->touchField = touchField;
        TouchField__AddArea(touchField, &work->area, 0);
    }
}

void CutsceneSpriteButtonManager_RemoveTouchArea_Internal(CutsceneTouchArea *work)
{
    TouchField__RemoveArea(work->touchField, &work->area);
    work->touchField = NULL;
}

void CutsceneSpriteButtonManager_TouchAreaCallback(TouchAreaResponse *response, CutsceneTouchArea *area, void *userData)
{
    TouchAreaResponseFlags flags = area->area.responseFlags;
    AnimatorSprite *animator     = area->animator;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_ENTERED_AREA_2:
            if (area->dword40 && (flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                animator->cParam.palette = area->palette2;
                AnimatorSprite__SetAnimation(animator, area->anim2);
            }
            break;

        case TOUCHAREA_RESPONSE_20000:
            if (area->dword40 && (flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                animator->cParam.palette = area->palette1;
                AnimatorSprite__SetAnimation(animator, area->anim1);
            }
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
            if ((flags & TOUCHAREA_RESPONSE_20) != 0 && (flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                CutsceneScript_InitThread(area->cutscene, VOID_TO_INT(userData));
            }
            break;
    }
}

void InitCutsceneTextSystem(CutsceneTextWorker *work)
{
    FontWindow__Init(&work->fontWindow);
    FontAnimator__Init(&work->fontAnimator);

    work->dword17C = 0;
    work->dword180 = FLOAT_TO_FX32(1.0);
    work->dword184 = FLOAT_TO_FX32(1.0);
    work->dword188 = 0;
    work->dword18C = 0;
    work->dword190 = 0;
}

void DrawCutsceneTextSystem(CutsceneTextWorker *work)
{
    if (work->dword18C)
    {
        if (work->dword190)
        {
            work->dword190 = 0;
        }
        else
        {
            if (work->dword180 == 0)
            {
                FontAnimator__LoadCharacters(&work->fontAnimator, 0);
                work->dword188 = 0;
            }
            else
            {
                if (work->dword180 <= work->dword188)
                {
                    work->dword188 -= work->dword180;
                }
                else
                {
                    if (work->dword188 == 0)
                    {
                        work->dword17C += work->dword184;
                    }
                    else
                    {
                        work->dword17C += (work->dword184 * work->dword180) / (work->dword180 - work->dword188);
                        work->dword188 = 0;
                    }

                    u32 value1 = work->dword17C;
                    u32 value2 = work->dword180;
                    if (work->dword180 <= work->dword17C)
                    {
                        work->dword17C %= work->dword180;
                        FontAnimator__LoadCharacters(&work->fontAnimator, value1 / value2);
                    }
                }
            }
        }
    }

    if (work->files[1] != NULL)
    {
        FontWindow__PrepareSwapBuffer(&work->fontWindow);
        FontAnimator__Draw(&work->fontAnimator);
    }
}

void ReleaseCutsceneTextSystem(CutsceneTextWorker *work)
{
    FontAnimator__Release(&work->fontAnimator);
    FontWindow__Clear(&work->fontWindow);
    FontWindow__Release(&work->fontWindow);

    for (void **file = &work->files[0]; file != &work->files[2]; file++)
    {
        if (*file != NULL)
        {
            HeapFree(HEAP_USER, *file);
            *file = NULL;
        }
    }
}

CutsceneScriptResult ProcessCutsceneTextSystem(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *work)
{
    static const CutsceneScriptTextCommand textCommandTable[] = {
        CutsceneScript_TextCommand_LoadWindow,
        CutsceneScript_TextCommand_ReleaseWindow,
        CutsceneScript_TextCommand_LoadTextSequenceFile,
        CutsceneScript_TextCommand_SetTextSequence,
        CutsceneScript_TextCommand_SetUnknown180,
        CutsceneScript_TextCommand_SetUnknown184,
        CutsceneScript_TextCommand_SetUnknown188,
        CutsceneScript_TextCommand_EnableUnknown18C,
        CutsceneScript_TextCommand_DisableUnknown18C,
        CutsceneScript_TextCommand_ResetLoadedCharacters,
        CutsceneScript_TextCommand_LoadCharacters,
        CutsceneScript_TextCommand_CheckEndOfLine,
        CutsceneScript_TextCommand_AdvanceDialog,
        CutsceneScript_TextCommand_CheckLastDialog,
        CutsceneScript_TextCommand_Draw,
    };

    s32 id = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R0);

    return textCommandTable[id](text, thread, work);
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript_TextCommand_LoadWindow(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    // https://decomp.me/scratch/R0RSe -> 88.50%
#ifdef NON_MATCHING
    s32 useEngineB   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);
    u8 bgID          = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);
    s32 screenBase   = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R3);
    s32 charBase     = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R4);
    const char *path = CutsceneScript_GetFunctionParamString(thread, cutscene, CUTSCENESCRIPT_REGISTER_R5);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R6);
    s32 startX       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R7);
    s32 startY       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R8);
    s32 sizeX        = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R9);
    s32 sizeY        = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R10);
    u8 paletteRow    = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R11);

    CutsceneDisplay_ConfigureBackgroundText(useEngineB, bgID, GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, screenBase, charBase);
    BackgroundUnknown__Func_204CA00(useEngineB, bgID);

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    gfxControl->bgPosition[bgID].x = gfxControl->bgPosition[bgID].y = 0;

    if (text->files[0] != NULL)
        HeapFree(HEAP_USER, text->files[0]);

    if (fileID < 0)
        fileID = ARCHIVEFILE_ID_NONE;

    text->files[0] = ArchiveFile__Load(path, fileID, NULL, ARCHIVEFILE_FLAG_NONE, NULL);
    FontWindow__LoadFromMemory(&text->fontWindow, text->files[0], 0);

    text->alignment = startX % 8;
    text->field_195 = startY % 8;

    FontAnimator__LoadFont1(&text->fontAnimator, &text->fontWindow, 0, startX / TILE_SIZE, startY / TILE_SIZE, (sizeX + 7) / TILE_SIZE - startX / TILE_SIZE,
                            (sizeY + 7) / TILE_SIZE - startY / TILE_SIZE, useEngineB, bgID, paletteRow, 32);
    FontAnimator__LoadMappingsFunc(&text->fontAnimator);
    FontAnimator__LoadPaletteFunc(&text->fontAnimator);
    FontAnimator__ClearPixels(&text->fontAnimator);
    FontAnimator__Draw(&text->fontAnimator);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r9, r1
	mov r10, r0
	mov r0, r9
	mov r1, #1
	mov r6, r2
	bl CutsceneScript_GetFunctionParamRegister
	mov r4, r0
	mov r0, r9
	mov r1, #2
	bl CutsceneScript_GetFunctionParamRegister
	and r5, r0, #0xff
	mov r0, r9
	mov r1, #3
	bl CutsceneScript_GetFunctionParamRegister
	mov r11, r0
	mov r0, r9
	mov r1, #4
	bl CutsceneScript_GetFunctionParamRegister
	str r0, [sp, #0x28]
	mov r1, r6
	mov r0, r9
	mov r2, #5
	bl CutsceneScript_GetFunctionParamString
	str r0, [sp, #0x24]
	mov r0, r9
	mov r1, #6
	bl CutsceneScript_GetFunctionParamRegister
	mov r8, r0
	mov r0, r9
	mov r1, #7
	bl CutsceneScript_GetFunctionParamRegister
	mov r6, r0
	mov r0, r9
	mov r1, #8
	bl CutsceneScript_GetFunctionParamRegister
	mov r7, r0
	mov r0, r9
	mov r1, #9
	bl CutsceneScript_GetFunctionParamRegister
	str r0, [sp, #0x20]
	mov r0, r9
	mov r1, #0xa
	bl CutsceneScript_GetFunctionParamRegister
	str r0, [sp, #0x1c]
	mov r0, r9
	mov r1, #0xb
	bl CutsceneScript_GetFunctionParamRegister
	mov r2, #0
	and r9, r0, #0xff
	ldr r1, [sp, #0x28]
	str r11, [sp]
	str r1, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, r2
	bl CutsceneDisplay_ConfigureBackgroundText
	mov r0, r4
	mov r1, r5
	bl BackgroundUnknown__Func_204CA00
	ldr r0, =VRAMSystem__GFXControl
	mov r1, #0
	ldr r2, [r0, r4, lsl #2]
	add r0, r2, r5, lsl #2
	strh r1, [r0, #2]
	mov r0, r5, lsl #2
	strh r1, [r2, r0]
	ldr r0, [r10, #0x174]
	cmp r0, #0
	beq _02159A04
	bl _FreeHEAP_USER
_02159A04:
	mov r2, #0
	cmp r8, #0
	mvnlt r8, #0
	ldr r0, [sp, #0x24]
	mov r1, r8
	mov r3, r2
	str r2, [sp]
	bl ArchiveFile__Load
	str r0, [r10, #0x174]
	mov r1, r0
	mov r0, r10
	mov r2, #0
	bl FontWindow__LoadFromMemory
	mov r3, r6, lsr #0x1f
	rsb r2, r3, r6, lsl #29
	add r2, r3, r2, ror #29
	ldr r0, [sp, #0x20]
	mov r3, r7, lsr #0x1f
	strb r2, [r10, #0x194]
	rsb r2, r3, r7, lsl #29
	add r2, r3, r2, ror #29
	add r1, r0, #7
	strb r2, [r10, #0x195]
	mov r2, r6, asr #2
	add r2, r6, r2, lsr #29
	mov r6, r1, asr #2
	mov r3, r2, asr #3
	add r1, r1, r6, lsr #29
	ldr r0, [sp, #0x1c]
	rsb r1, r3, r1, asr #3
	mov r1, r1, lsl #0x10
	mov r2, r7, asr #2
	mov r6, r1, lsr #0x10
	mov r1, r3, lsl #0x10
	add r2, r7, r2, lsr #29
	add r0, r0, #7
	mov r3, r1, lsr #0x10
	mov r1, r0, asr #2
	mov r2, r2, asr #3
	add r0, r0, r1, lsr #29
	rsb r1, r2, r0, asr #3
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r6}
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r5, [sp, #0x10]
	mov r1, r10
	str r9, [sp, #0x14]
	mov r4, #0x20
	add r0, r10, #0xb0
	mov r2, #0
	str r4, [sp, #0x18]
	bl FontAnimator__LoadFont1
	add r0, r10, #0xb0
	bl FontAnimator__LoadMappingsFunc
	add r0, r10, #0xb0
	bl FontAnimator__LoadPaletteFunc
	add r0, r10, #0xb0
	bl FontAnimator__ClearPixels
	add r0, r10, #0xb0
	bl FontAnimator__Draw
	mov r0, #1
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

CutsceneScriptResult CutsceneScript_TextCommand_ReleaseWindow(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    if (text->dword18C)
        text->dword18C = 0;

    FontAnimator__Release(&text->fontAnimator);
    FontWindow__Clear(&text->fontWindow);
    FontWindow__Release(&text->fontWindow);

    for (void **file = &text->files[0]; file != &text->files[2]; file++)
    {
        if (*file != NULL)
        {
            HeapFree(HEAP_USER, *file);
            *file = NULL;
        }
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_LoadTextSequenceFile(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    const char *path = CutsceneScript_GetFunctionParamString(thread, cutscene, CUTSCENESCRIPT_REGISTER_R1);
    s32 fileID       = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R2);

    if (text->files[1] != NULL)
        HeapFree(HEAP_USER, text->files[1]);

    ArchiveFileFlags flags = CutsceneFileSystemManager_GetNextFileCompressedFlag(&cutscene->systemManager) ? ARCHIVEFILE_FLAG_IS_COMPRESSED : ARCHIVEFILE_FLAG_NONE;

    if (fileID < 0)
        fileID = ARCHIVEFILE_ID_NONE;

    text->files[1] = ArchiveFile__Load(path, fileID, NULL, flags, NULL);
    FontAnimator__LoadMPCFile(&text->fontAnimator, text->files[1]);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_SetTextSequence(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    u16 id = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    FontAnimator__SetMsgSequence(&text->fontAnimator, id);
    FontAnimator__InitStartPos(&text->fontAnimator, 0, text->alignment);
    FontAnimator__AdvanceLine(&text->fontAnimator, text->field_195);
    text->dword188 = 0;
    text->dword18C = 0;
    text->dword190 = 0;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_SetUnknown180(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    text->dword180 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_SetUnknown184(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    text->dword184 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_SetUnknown188(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    text->dword188 = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_EnableUnknown18C(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    text->dword18C = TRUE;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_DisableUnknown18C(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    text->dword18C = FALSE;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_ResetLoadedCharacters(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    FontAnimator__LoadCharacters(&text->fontAnimator, 0);

    text->dword190 = TRUE;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_LoadCharacters(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    u16 count = CutsceneScript_GetFunctionParamRegister(thread, CUTSCENESCRIPT_REGISTER_R1);

    if (count != 0)
    {
        FontAnimator__LoadCharacters(&text->fontAnimator, count);
        text->dword190 = TRUE;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_CheckEndOfLine(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R1, FontAnimator__IsEndOfLine(&text->fontAnimator) != 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_AdvanceDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    FontAnimator__AdvanceDialog(&text->fontAnimator);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_CheckLastDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    CutsceneScript_SetRegister(thread, CUTSCENESCRIPT_REGISTER_R1, FontAnimator__IsLastDialog(&text->fontAnimator) != 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript_TextCommand_Draw(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
    FontAnimator__ClearPixels(&text->fontAnimator);
    FontAnimator__Draw(&text->fontAnimator);

    text->dword190 = TRUE;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

void CreateCutsceneSystem(void)
{
    cutsceneSystemTask = TaskCreate(CutsceneSystem_Main_Running, CutsceneSystem_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 1, TASK_GROUP(0), CutsceneSystem);

    InitCutsceneSystem(cutsceneSystemTask);
}

void InitCutsceneSystem(Task *task)
{
    CutsceneSystem *work = TaskGetWork(task, CutsceneSystem);

    VRAMSystem__Reset();
    GX_SetBankForLCDC(GX_VRAM_LCDC_ALL);

    MI_DmaFill32(1, (void *)HW_LCDC_VRAM, 0, HW_LCDC_VRAM_SIZE);
    MI_DmaFill32(1, VRAM_BG_PLTT, 0, 2 * (0x100 * sizeof(GXRgb)));
    MI_DmaFill32(1, VRAM_DB_BG_PLTT, 0, 2 * (0x100 * sizeof(GXRgb)));

    DC_InvalidateRange((void *)HW_LCDC_VRAM, HW_LCDC_VRAM_SIZE);
    DC_InvalidateRange(VRAM_BG_PLTT, 2 * (0x100 * sizeof(GXRgb)));
    DC_InvalidateRange(VRAM_DB_BG_PLTT, 2 * (0x100 * sizeof(GXRgb)));

    VRAMSystem__Reset();

    renderCoreGFXControlB.windowManager.visible = renderCoreGFXControlA.windowManager.visible = GX_WNDMASK_NONE;
    renderCoreGFXControlB.blendManager.coefficient.value = renderCoreGFXControlA.blendManager.coefficient.value = RENDERCORE_BRIGHTNESS_DEFAULT;
    renderCoreGFXControlB.blendManager.blendControl.value = renderCoreGFXControlA.blendManager.blendControl.value = 0x00;
    renderCoreGFXControlB.blendManager.blendAlpha.value = renderCoreGFXControlA.blendManager.blendAlpha.value = 0x00;

    u32 e;
    RenderCoreGFXControl *const *gfxControlList = VRAMSystem__GFXControl;
    while (gfxControlList != &VRAMSystem__GFXControl[GRAPHICS_ENGINE_COUNT])
    {
        for (e = 0; e < GRAPHICS_ENGINE_COUNT; e++)
        {
            RenderCoreGFXControl *gfxControl = *gfxControlList;
            RenderAffineControl *affineControl;

            if (e == GRAPHICS_ENGINE_A)
                affineControl = &gfxControl->affineBG2;
            else
                affineControl = &gfxControl->affineBG3;

            MTX_Identity22(&affineControl->matrix);
            affineControl->centerX = affineControl->centerY = affineControl->x = affineControl->y = 0;
        }

        gfxControlList++;
    }

    s32 id       = CutsceneSystem_GetCutsceneID();
    work->script = LoadCutsceneScriptFile(id);
    CreateCutsceneScript(work, TASK_PRIORITY_UPDATE_LIST_START + 16);
    CutsceneScript_InitFileSystemManager(work, 32);
    CutsceneScript_InitSpriteButtonManager(work, 16);
    CutsceneScript_InitBackgroundManager(work);
    CutsceneScript_InitModelManager(work, 32);
    CutsceneScript_InitTextManager(work);
    CutsceneScript_InitAudioManager(work, 8);
    LoadCutsceneScript(work, work->script);
    StartCutsceneScript(work, GetScriptStartParam(id), CutsceneSystem_OnCutsceneFinish);
    CutsceneSystem_LoadCanSkipFlag(GetCutsceneScript(work));
}

void CutsceneSystem_Destructor(Task *task)
{
    CutsceneSystem *work = TaskGetWork(task, CutsceneSystem);
    HeapFree(HEAP_USER, work->script);

    cutsceneSystemTask = NULL;
}

void CutsceneSystem_OnCutsceneFinish(CutsceneScript *work)
{
    SetTaskMainEvent(cutsceneSystemTask, CutsceneSystem_Main_NextSysEvent);

    renderCoreGFXControlA.windowManager.visible = GX_WNDMASK_NONE;
    renderCoreGFXControlB.windowManager.visible = GX_WNDMASK_NONE;

    renderCoreGFXControlA.blendManager.blendAlpha.value = 0x00;
    renderCoreGFXControlB.blendManager.blendAlpha.value = 0x00;

    renderCoreGFXControlA.blendManager.blendControl.value = 0x00;
    renderCoreGFXControlB.blendManager.blendControl.value = 0x00;

    renderCoreGFXControlA.blendManager.coefficient.value = RENDERCORE_BRIGHTNESS_DEFAULT;
    renderCoreGFXControlB.blendManager.coefficient.value = RENDERCORE_BRIGHTNESS_DEFAULT;

    CutsceneSystem_StoreCanSkipFlag(work);
}

s32 CutsceneSystem_GetCutsceneID(void)
{
    return gameState.cutscene.cutsceneID;
}

s32 CutsceneSystem_GetNextSysEvent(void)
{
    return gameState.cutscene.nextSysEvent;
}

void CutsceneSystem_LoadCanSkipFlag(CutsceneScript *work)
{
    s32 *data = CutsceneScript_GetFunctionParamConstant(work, NULL, GetScriptCanSkipFlagIn());

    *data = gameState.cutscene.canSkip;
}

void CutsceneSystem_StoreCanSkipFlag(CutsceneScript *work)
{
    s32 *data = CutsceneScript_GetFunctionParamConstant(work, NULL, GetScriptCanSkipFlagOut());

    gameState.cutscene.canSkip = *data;
}

void CutsceneSystem_Main_Running(void)
{
    CutsceneSystem *work = TaskGetWork(cutsceneSystemTask, CutsceneSystem);
    UNUSED(work);
}

void CutsceneSystem_Main_NextSysEvent(void)
{
    CutsceneSystem *work = TaskGetWork(cutsceneSystemTask, CutsceneSystem);
    DestroyCutsceneScript(work);
    DestroyCurrentTask();

    RequestNewSysEventChange(CutsceneSystem_GetNextSysEvent());
    NextSysEvent();
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A124(void *background, void *vramPixels, s32 displayWidth, s32 displayHeight)
{
    // https://decomp.me/scratch/62CZl -> 79.90%
#ifdef NON_MATCHING
    CutsceneBackgroundUnknown bg;

    bg.fileData = (UnknownBackground *)background;
    bg.width1   = bg.fileData->field_0 / bg.fileData->field_6;
    bg.height1  = bg.fileData->field_2 / bg.fileData->field_6;
    bg.width2   = bg.fileData->field_0 / bg.fileData->field_7;
    bg.height2  = bg.fileData->field_2 / bg.fileData->field_7;

    bg.memory = HeapAllocHead(HEAP_USER, 4 * (bg.width1 * bg.height1 + 2 * bg.width2 * bg.height2));
    s32 size1 = bg.width1 * bg.height1;
    s32 size2 = bg.width2 * bg.height2;

    bg.dword8  = &bg.memory[size1];
    bg.dwordC  = &bg.dword8[size2];
    bg.dword10 = &bg.dwordC[size2];
    bg.dword14 = &bg.dword10[size1];
    bg.dword18 = &bg.dword14[size2];

    CutsceneUnknownBackground__Func_215AE54((void *)&bg.fileData[2], bg.memory);
    CutsceneUnknownBackground__Func_215A248(&bg);
    CutsceneUnknownBackground__Func_215A374(&bg);
    CutsceneUnknownBackground__Func_215A788(&bg);
    CutsceneUnknownBackground__Func_215A9A8(&bg, vramPixels, displayWidth, displayHeight);

    HeapFree(HEAP_USER, bg.memory);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	mov r4, r0
	str r4, [sp]
	mov r6, r1
	ldrh r0, [r4, #0]
	ldrb r1, [r4, #6]
	mov r5, r2
	mov r4, r3
	bl _s32_div_f
	ldr r1, [sp]
	strh r0, [sp, #0x1c]
	ldrh r0, [r1, #2]
	ldrb r1, [r1, #6]
	bl _s32_div_f
	ldr r1, [sp]
	strh r0, [sp, #0x1e]
	ldrh r0, [r1, #0]
	ldrb r1, [r1, #7]
	bl _s32_div_f
	strh r0, [sp, #0x20]
	ldr r1, [sp]
	ldrh r0, [r1, #2]
	ldrb r1, [r1, #7]
	bl _s32_div_f
	strh r0, [sp, #0x22]
	ldrh r3, [sp, #0x1c]
	ldrh r2, [sp, #0x1e]
	ldrh r1, [sp, #0x20]
	ldrh r0, [sp, #0x22]
	mul r2, r3, r2
	mul r0, r1, r0
	add r0, r2, r0, lsl #1
	mov r7, r0, lsl #1
	mov r0, r7, lsl #1
	bl _AllocHeadHEAP_USER
	mov r2, r7
	mov r1, r0
	str r1, [sp, #4]
	ldrh lr, [sp, #0x1c]
	ldrh ip, [sp, #0x1e]
	ldrh r3, [sp, #0x20]
	ldrh r0, [sp, #0x22]
	mul r7, lr, ip
	mul ip, r3, r0
	add r0, r1, r7, lsl #1
	str r0, [sp, #8]
	add r0, r0, ip, lsl #1
	str r0, [sp, #0xc]
	add r0, r0, ip, lsl #1
	add r3, r0, r7, lsl #1
	str r0, [sp, #0x10]
	add r0, r3, ip, lsl #1
	str r3, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, [sp]
	add r0, r0, #0x10
	bl CutsceneUnknownBackground__Func_215AE54
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215A248
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215A374
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215A788
	mov r1, r6
	mov r2, r5
	mov r3, r4
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215A9A8
	ldr r0, [sp, #4]
	bl _FreeHEAP_USER
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A248(CutsceneBackgroundUnknown *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrh r1, [r6, #0x1c]
	ldrh r0, [r6, #0x1e]
	mov r4, #0
	mul r0, r1, r0
	mov r0, r0, lsl #0x10
	movs r5, r0, lsr #0x10
	beq _0215A294
_0215A26C:
	ldr r0, [r6, #4]
	ldr r1, [r6, #0x10]
	add r0, r0, r4, lsl #1
	add r1, r1, r4, lsl #1
	bl CutsceneUnknownBackground__Func_215A2F0
	add r0, r4, #0x10
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r4, r0, lsr #0x10
	bhi _0215A26C
_0215A294:
	ldrh r1, [r6, #0x20]
	ldrh r0, [r6, #0x22]
	mov r5, #0
	mul r0, r1, r0
	mov r0, r0, lsl #0x10
	movs r4, r0, lsr #0x10
	ldmeqia sp!, {r4, r5, r6, pc}
_0215A2B0:
	ldr r0, [r6, #8]
	ldr r1, [r6, #0x14]
	add r0, r0, r5, lsl #1
	add r1, r1, r5, lsl #1
	bl CutsceneUnknownBackground__Func_215A2F0
	ldr r0, [r6, #0xc]
	ldr r1, [r6, #0x18]
	add r0, r0, r5, lsl #1
	add r1, r1, r5, lsl #1
	bl CutsceneUnknownBackground__Func_215A2F0
	add r0, r5, #0x10
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0215A2B0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A2F0(u16 *src, u16 *dst)
{
#ifdef NON_MATCHING
    dst[0]  = src[0];
    dst[1]  = src[2];
    dst[2]  = src[3];
    dst[3]  = src[9];
    dst[4]  = src[1];
    dst[5]  = src[4];
    dst[6]  = src[8];
    dst[7]  = src[10];
    dst[8]  = src[5];
    dst[9]  = src[7];
    dst[10] = src[11];
    dst[11] = src[14];
    dst[12] = src[6];
    dst[13] = src[12];
    dst[14] = src[13];
    dst[15] = src[15];
#else
    // clang-format off
	ldrsh r2, [r0, #0]
	strh r2, [r1]
	ldrsh r2, [r0, #4]
	strh r2, [r1, #2]
	ldrsh r2, [r0, #6]
	strh r2, [r1, #4]
	ldrsh r2, [r0, #0x12]
	strh r2, [r1, #6]
	ldrsh r2, [r0, #2]
	strh r2, [r1, #8]
	ldrsh r2, [r0, #8]
	strh r2, [r1, #0xa]
	ldrsh r2, [r0, #0x10]
	strh r2, [r1, #0xc]
	ldrsh r2, [r0, #0x14]
	strh r2, [r1, #0xe]
	ldrsh r2, [r0, #0xa]
	strh r2, [r1, #0x10]
	ldrsh r2, [r0, #0xe]
	strh r2, [r1, #0x12]
	ldrsh r2, [r0, #0x16]
	strh r2, [r1, #0x14]
	ldrsh r2, [r0, #0x1c]
	strh r2, [r1, #0x16]
	ldrsh r2, [r0, #0xc]
	strh r2, [r1, #0x18]
	ldrsh r2, [r0, #0x18]
	strh r2, [r1, #0x1a]
	ldrsh r2, [r0, #0x1a]
	strh r2, [r1, #0x1c]
	ldrsh r0, [r0, #0x1e]
	strh r0, [r1, #0x1e]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A374(CutsceneBackgroundUnknown *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldrh r0, [r10, #0x1e]
	ldrh r2, [r10, #0x1c]
	mov r7, #0
	mov r1, r0, lsr #2
	mov r0, r2, lsl #0x12
	mov r1, r1, lsl #0x10
	mov r8, r0, lsr #0x10
	movs r5, r1, lsr #0x10
	beq _0215A3F8
	mov r4, r7
_0215A3A4:
	mov r6, r4
	cmp r8, #0
	bls _0215A3E4
	mul r9, r7, r8
_0215A3B4:
	add r0, r6, r9
	mov r2, r0, lsl #0x10
	ldr r0, [r10, #0x10]
	ldr r1, [r10, #4]
	mov r3, r8
	mov r2, r2, lsr #0x10
	bl CutsceneUnknownBackground__Func_215A490
	add r0, r6, #0x40
	mov r0, r0, lsl #0x10
	cmp r8, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhi _0215A3B4
_0215A3E4:
	add r0, r7, #4
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r7, r0, lsr #0x10
	bhi _0215A3A4
_0215A3F8:
	ldrh r0, [r10, #0x22]
	ldrh r2, [r10, #0x20]
	mov r8, #0
	mov r1, r0, lsr #2
	mov r0, r2, lsl #0x12
	mov r1, r1, lsl #0x10
	mov r6, r0, lsr #0x10
	movs r7, r1, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r11, r8
_0215A420:
	mov r9, r11
	cmp r6, #0
	bls _0215A478
	mul r4, r8, r6
_0215A430:
	add r5, r9, r4
	mov r2, r5, lsl #0x10
	ldr r0, [r10, #0x14]
	ldr r1, [r10, #8]
	mov r3, r6
	mov r2, r2, lsr #0x10
	bl CutsceneUnknownBackground__Func_215A490
	mov r2, r5, lsl #0x10
	ldr r0, [r10, #0x18]
	ldr r1, [r10, #0xc]
	mov r2, r2, lsr #0x10
	mov r3, r6
	bl CutsceneUnknownBackground__Func_215A490
	add r0, r9, #0x40
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r9, r0, lsr #0x10
	bhi _0215A430
_0215A478:
	add r0, r8, #4
	mov r0, r0, lsl #0x10
	cmp r7, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _0215A420
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A490(u16 *a1, u16 *a2, s32 a3, s32 a4)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	mov r7, r2
	mov r9, r0
	mov r10, r7, lsl #1
	ldrsh r0, [r9, r10]
	add r5, r9, r7, lsl #1
	mov r6, r3
	strh r0, [sp]
	ldrsh r0, [r5, #0x20]
	add ip, r5, r6, lsl #1
	add r3, ip, r6, lsl #1
	strh r0, [sp, #2]
	ldrsh r0, [r5, #0x40]
	mov r4, r6, lsl #1
	add r2, r3, r6, lsl #1
	strh r0, [sp, #4]
	ldrsh lr, [r5, #0x60]
	add r0, sp, #0
	mov r8, r1
	strh lr, [sp, #6]
	ldrsh lr, [r5, r4]
	mov r1, r0
	strh lr, [sp, #8]
	ldrsh lr, [ip, #0x20]
	strh lr, [sp, #0xa]
	ldrsh lr, [ip, #0x40]
	strh lr, [sp, #0xc]
	ldrsh lr, [ip, #0x60]
	strh lr, [sp, #0xe]
	ldrsh ip, [ip, r4]
	strh ip, [sp, #0x10]
	ldrsh ip, [r3, #0x20]
	strh ip, [sp, #0x12]
	ldrsh ip, [r3, #0x40]
	strh ip, [sp, #0x14]
	ldrsh ip, [r3, #0x60]
	strh ip, [sp, #0x16]
	ldrsh r3, [r3, r4]
	strh r3, [sp, #0x18]
	ldrsh r3, [r2, #0x20]
	strh r3, [sp, #0x1a]
	ldrsh r3, [r2, #0x40]
	strh r3, [sp, #0x1c]
	ldrsh r2, [r2, #0x60]
	strh r2, [sp, #0x1e]
	bl CutsceneUnknownBackground__Func_215A640
	ldrsh r0, [sp]
	add r2, r5, r6, lsl #1
	add r1, r2, r6, lsl #1
	strh r0, [r9, r10]
	ldrsh r3, [sp, #2]
	add r0, r1, r6, lsl #1
	mov r10, #0
	strh r3, [r5, #0x20]
	ldrsh r3, [sp, #4]
	strh r3, [r5, #0x40]
	ldrsh r3, [sp, #6]
	strh r3, [r5, #0x60]
	ldrsh r3, [sp, #8]
	strh r3, [r5, r4]
	ldrsh r3, [sp, #0xa]
	strh r3, [r2, #0x20]
	ldrsh r3, [sp, #0xc]
	strh r3, [r2, #0x40]
	ldrsh r3, [sp, #0xe]
	strh r3, [r2, #0x60]
	ldrsh r3, [sp, #0x10]
	strh r3, [r2, r4]
	ldrsh r2, [sp, #0x12]
	strh r2, [r1, #0x20]
	ldrsh r2, [sp, #0x14]
	strh r2, [r1, #0x40]
	ldrsh r2, [sp, #0x16]
	strh r2, [r1, #0x60]
	ldrsh r2, [sp, #0x18]
	strh r2, [r1, r4]
	ldrsh r1, [sp, #0x1a]
	strh r1, [r0, #0x20]
	ldrsh r1, [sp, #0x1c]
	strh r1, [r0, #0x40]
	ldrsh r1, [sp, #0x1e]
	strh r1, [r0, #0x60]
_0215A5DC:
	mla r0, r6, r10, r7
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	add r0, r9, r4, lsl #1
	add r1, r8, r4, lsl #1
	bl CutsceneUnknownBackground__Func_215A640
	add r1, r4, #0x10
	add r0, r9, r1, lsl #1
	add r1, r8, r1, lsl #1
	bl CutsceneUnknownBackground__Func_215A640
	add r1, r4, #0x20
	add r0, r9, r1, lsl #1
	add r1, r8, r1, lsl #1
	bl CutsceneUnknownBackground__Func_215A640
	add r1, r4, #0x30
	add r0, r9, r1, lsl #1
	add r1, r8, r1, lsl #1
	bl CutsceneUnknownBackground__Func_215A640
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #4
	blo _0215A5DC
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A640(u16 *a1, u16 *a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	mov r4, r1
	bl CutsceneUnknownBackground__Func_215A738
	add r0, r5, #8
	add r1, r4, #8
	bl CutsceneUnknownBackground__Func_215A738
	add r0, r5, #0x10
	add r1, r4, #0x10
	bl CutsceneUnknownBackground__Func_215A738
	add r0, r5, #0x18
	add r1, r4, #0x18
	bl CutsceneUnknownBackground__Func_215A738
	mov r6, #0
	mov r8, r6
	mov r5, r6
_0215A680:
	mov r7, r5
	cmp r6, #0
	ble _0215A6C0
	mov r9, r5
	add ip, r4, r8, lsl #1
	add r1, r4, r6, lsl #1
_0215A698:
	mov lr, r7, lsl #1
	mov r2, r9, lsl #1
	ldrsh r3, [lr, ip]
	ldrsh r0, [r2, r1]
	add r7, r7, #1
	cmp r7, r6
	strh r0, [lr, ip]
	strh r3, [r2, r1]
	add r9, r9, #4
	blt _0215A698
_0215A6C0:
	add r6, r6, #1
	cmp r6, #4
	add r8, r8, #4
	blt _0215A680
	mov r0, r4
	mov r1, r4
	bl CutsceneUnknownBackground__Func_215A738
	add r0, r4, #8
	mov r1, r0
	bl CutsceneUnknownBackground__Func_215A738
	add r0, r4, #0x10
	mov r1, r0
	bl CutsceneUnknownBackground__Func_215A738
	add r0, r4, #0x18
	mov r1, r0
	bl CutsceneUnknownBackground__Func_215A738
	mov r3, #0
_0215A704:
	mov r2, r3, lsl #1
	ldrsh r0, [r4, r2]
	add r3, r3, #1
	cmp r0, #0
	addge r1, r0, #2
	sublt r1, r0, #2
	mov r0, r1, asr #1
	add r0, r1, r0, lsr #30
	mov r0, r0, asr #2
	strh r0, [r4, r2]
	cmp r3, #0x10
	blt _0215A704
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A738(s16 *a1, s16 *a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldrsh ip, [r0, #2]
	ldrsh r2, [r0, #0]
	ldrsh r4, [r0, #4]
	ldrsh lr, [r0, #6]
	add r3, r2, ip
	sub r0, r2, ip
	add r2, r4, r3
	add ip, lr, r2
	sub r3, r3, r4
	sub r2, r0, r4
	add r0, r4, r0
	strh ip, [r1]
	sub r3, r3, lr
	strh r3, [r1, #2]
	add r2, lr, r2
	strh r2, [r1, #4]
	sub r0, r0, lr
	strh r0, [r1, #6]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A788(CutsceneBackgroundUnknown *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldrh r0, [r10, #0x1e]
	mov r8, #0
	mov r7, r8
	cmp r0, #0
	ble _0215A86C
_0215A7A4:
	ldrh r0, [r10, #0x1c]
	mov r6, #0
	cmp r0, #0
	ble _0215A85C
	mov r5, #8
	mov r4, r5
	mov r11, r5
_0215A7C0:
	mla r9, r7, r0, r6
	ldr r0, [r10, #4]
	ldr r1, [r10, #0x10]
	mov r2, r5
	add r0, r0, r8, lsl #1
	add r1, r1, r9, lsl #1
	bl MIi_CpuCopy32
	ldrh r2, [r10, #0x1c]
	ldr r1, [r10, #4]
	add r0, r8, #4
	add r0, r1, r0, lsl #1
	add r9, r9, r2
	ldr r1, [r10, #0x10]
	mov r2, r4
	add r1, r1, r9, lsl #1
	bl MIi_CpuCopy32
	ldrh r2, [r10, #0x1c]
	ldr r1, [r10, #4]
	add r0, r8, #8
	add r0, r1, r0, lsl #1
	add r9, r9, r2
	ldr r1, [r10, #0x10]
	mov r2, r11
	add r1, r1, r9, lsl #1
	bl MIi_CpuCopy32
	ldrh r2, [r10, #0x1c]
	ldr r1, [r10, #4]
	add r0, r8, #0xc
	add r0, r1, r0, lsl #1
	add r3, r9, r2
	ldr r1, [r10, #0x10]
	mov r2, #8
	add r1, r1, r3, lsl #1
	bl MIi_CpuCopy32
	ldrh r0, [r10, #0x1c]
	add r6, r6, #4
	add r8, r8, #0x10
	cmp r6, r0
	blt _0215A7C0
_0215A85C:
	ldrh r0, [r10, #0x1e]
	add r7, r7, #4
	cmp r7, r0
	blt _0215A7A4
_0215A86C:
	ldrh r0, [r10, #0x22]
	mov r5, #0
	mov r6, r5
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215A880:
	ldrh r0, [r10, #0x20]
	mov r7, #0
	cmp r0, #0
	ble _0215A994
	mov r4, #8
	mov r11, r4
_0215A898:
	mla r8, r6, r0, r7
	ldr r0, [r10, #8]
	ldr r1, [r10, #0x14]
	add r0, r0, r5, lsl #1
	add r1, r1, r8, lsl #1
	mov r2, r4
	bl MIi_CpuCopy32
	ldr r0, [r10, #0xc]
	ldr r1, [r10, #0x18]
	add r0, r0, r5, lsl #1
	add r1, r1, r8, lsl #1
	mov r2, r11
	bl MIi_CpuCopy32
	ldrh r1, [r10, #0x20]
	ldr r0, [r10, #8]
	add r9, r5, #4
	add r8, r8, r1
	ldr r1, [r10, #0x14]
	add r0, r0, r9, lsl #1
	mov r2, #8
	add r1, r1, r8, lsl #1
	bl MIi_CpuCopy32
	ldr r0, [r10, #0xc]
	ldr r1, [r10, #0x18]
	add r0, r0, r9, lsl #1
	add r1, r1, r8, lsl #1
	mov r2, #8
	bl MIi_CpuCopy32
	ldrh r1, [r10, #0x20]
	ldr r0, [r10, #8]
	add r9, r5, #8
	add r8, r8, r1
	ldr r1, [r10, #0x14]
	add r0, r0, r9, lsl #1
	mov r2, #8
	add r1, r1, r8, lsl #1
	bl MIi_CpuCopy32
	ldr r0, [r10, #0xc]
	ldr r1, [r10, #0x18]
	add r0, r0, r9, lsl #1
	add r1, r1, r8, lsl #1
	mov r2, #8
	bl MIi_CpuCopy32
	ldrh r1, [r10, #0x20]
	ldr r0, [r10, #8]
	add r9, r5, #0xc
	add r8, r8, r1
	ldr r1, [r10, #0x14]
	add r0, r0, r9, lsl #1
	mov r2, #8
	add r1, r1, r8, lsl #1
	bl MIi_CpuCopy32
	ldr r0, [r10, #0xc]
	ldr r1, [r10, #0x18]
	add r0, r0, r9, lsl #1
	add r1, r1, r8, lsl #1
	mov r2, #8
	bl MIi_CpuCopy32
	ldrh r0, [r10, #0x20]
	add r7, r7, #4
	add r5, r5, #0x10
	cmp r7, r0
	blt _0215A898
_0215A994:
	ldrh r0, [r10, #0x22]
	add r6, r6, #4
	cmp r6, r0
	blt _0215A880
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215A9A8(CutsceneBackgroundUnknown *work, u16 *a2, u32 a3, u32 a4)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r4, r2
	str r3, [sp]
	mov r2, r4, lsl #1
	mov r6, r0
	mov r3, r3
	mul r2, r3, r2
	ldr r3, [r6, #0x10]
	mov r0, #0
	str r3, [sp, #8]
	ldr r3, [r6, #0x14]
	mov r5, r1
	str r3, [sp, #4]
	ldr r11, [r6, #0x18]
	bl MIi_CpuClear16
	ldr r0, [r6, #0]
	ldrh r3, [r6, #0x1c]
	ldrh r1, [r6, #0x1e]
	ldrb r2, [r0, #4]
	ldr r0, [sp, #8]
	mul r1, r3, r1
	bl CutsceneUnknownBackground__Func_215AB20
	ldr r2, [r6, #0]
	ldrh r3, [r6, #0x20]
	ldrh r1, [r6, #0x22]
	ldrb r2, [r2, #5]
	ldr r0, [sp, #4]
	mul r1, r3, r1
	bl CutsceneUnknownBackground__Func_215AB20
	ldr r2, [r6, #0]
	ldrh r3, [r6, #0x20]
	ldrh r1, [r6, #0x22]
	ldrb r2, [r2, #5]
	mov r0, r11
	mul r1, r3, r1
	bl CutsceneUnknownBackground__Func_215AB20
	ldr r1, [r6, #0]
	ldrh r0, [r1, #0]
	ldrh r1, [r1, #2]
	cmp r4, r0
	movhi r4, r0
	ldr r0, [sp]
	cmp r0, r1
	strhi r1, [sp]
	ldr r0, [sp]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0xc]
	addls sp, sp, #0x10
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215AA74:
	ldr r7, [r6, #0]
	ldr r0, [sp, #0xc]
	ldrb r1, [r7, #6]
	bl _u32_div_f
	mov r8, r0
	ldrb r1, [r7, #7]
	ldr r0, [sp, #0xc]
	bl _u32_div_f
	mov r9, r0
	mov r7, #0
	cmp r4, #0
	bls _0215AB00
_0215AAA4:
	ldr r10, [r6, #0]
	mov r0, r7
	ldrb r1, [r10, #7]
	bl _u32_div_f
	ldrh r2, [r6, #0x20]
	ldrb r1, [r10, #6]
	mla r10, r9, r2, r0
	mov r0, r7
	bl _u32_div_f
	ldrh r3, [r6, #0x1c]
	ldr r1, [sp, #4]
	mov r2, r10, lsl #1
	mla r0, r8, r3, r0
	mov r3, r0, lsl #1
	ldr r0, [sp, #8]
	ldrsh r1, [r1, r2]
	ldrsh r2, [r11, r2]
	ldrsh r0, [r0, r3]
	bl CutsceneUnknownBackground__Func_215ADA0
	add r7, r7, #1
	strh r0, [r5], #2
	cmp r7, r4
	blo _0215AAA4
_0215AB00:
	ldr r0, [sp, #0xc]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [sp, #0xc]
	cmp r1, r0
	blo _0215AA74
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215AB20(s16 *a1, u32 a2, s32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	cmp r2, #8
	addls pc, pc, r2, lsl #2
	ldmia sp!, {r3, r4, r5, pc}
_0215AB30: // jump table
	ldmia sp!, {r3, r4, r5, pc} // case 0
	b _0215AB54 // case 1
	b _0215AB8C // case 2
	b _0215ABE0 // case 3
	b _0215AC30 // case 4
	b _0215AC78 // case 5
	b _0215ACC4 // case 6
	b _0215AD10 // case 7
	b _0215AD5C // case 8
_0215AB54:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov r2, r4
	mov r3, #0xff
_0215AB68:
	mov lr, r4, lsl #1
	ldrsh ip, [r0, lr]
	add r4, r4, #1
	cmp ip, #1
	strgeh r3, [r0, lr]
	strlth r2, [r0, lr]
	cmp r4, r1
	blo _0215AB68
	ldmia sp!, {r3, r4, r5, pc}
_0215AB8C:
	mov r5, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r5
	mov ip, #3
_0215ABA0:
	mov r2, r5, lsl #1
	ldrsh r4, [r0, r2]
	cmp r4, #0
	movlt r4, lr
	cmp r4, #3
	movgt r4, ip
	mov r2, r4, lsl #4
	orr r2, r2, r4, lsl #6
	orr r3, r2, r4, lsl #2
	mov r2, r5, lsl #1
	orr r3, r4, r3
	add r5, r5, #1
	strh r3, [r0, r2]
	cmp r5, r1
	blo _0215ABA0
	ldmia sp!, {r3, r4, r5, pc}
_0215ABE0:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r4
	mov ip, #7
_0215ABF4:
	mov r2, r4, lsl #1
	ldrsh r5, [r0, r2]
	cmp r5, #0
	movlt r5, lr
	cmp r5, #7
	movgt r5, ip
	mov r2, r5, lsl #2
	orr r3, r2, r5, lsl #5
	mov r2, r4, lsl #1
	orr r3, r3, r5, asr #1
	add r4, r4, #1
	strh r3, [r0, r2]
	cmp r4, r1
	blo _0215ABF4
	ldmia sp!, {r3, r4, r5, pc}
_0215AC30:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r4
	mov ip, #0xf
_0215AC44:
	mov r2, r4, lsl #1
	ldrsh r3, [r0, r2]
	mov r2, r4, lsl #1
	add r4, r4, #1
	cmp r3, #0
	movlt r3, lr
	cmp r3, #0xf
	movgt r3, ip
	orr r3, r3, r3, lsl #4
	strh r3, [r0, r2]
	cmp r4, r1
	blo _0215AC44
	ldmia sp!, {r3, r4, r5, pc}
_0215AC78:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r4
	mov ip, #0x1f
_0215AC8C:
	mov r2, r4, lsl #1
	ldrsh r5, [r0, r2]
	mov r2, r4, lsl #1
	add r4, r4, #1
	cmp r5, #0
	movlt r5, lr
	cmp r5, #0x1f
	movgt r5, ip
	mov r3, r5, asr #2
	orr r3, r3, r5, lsl #3
	strh r3, [r0, r2]
	cmp r4, r1
	blo _0215AC8C
	ldmia sp!, {r3, r4, r5, pc}
_0215ACC4:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r4
	mov ip, #0x3f
_0215ACD8:
	mov r2, r4, lsl #1
	ldrsh r5, [r0, r2]
	mov r2, r4, lsl #1
	add r4, r4, #1
	cmp r5, #0
	movlt r5, lr
	cmp r5, #0x3f
	movgt r5, ip
	mov r3, r5, asr #4
	orr r3, r3, r5, lsl #2
	strh r3, [r0, r2]
	cmp r4, r1
	blo _0215ACD8
	ldmia sp!, {r3, r4, r5, pc}
_0215AD10:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r4
	mov ip, #0x7f
_0215AD24:
	mov r2, r4, lsl #1
	ldrsh r5, [r0, r2]
	mov r2, r4, lsl #1
	add r4, r4, #1
	cmp r5, #0
	movlt r5, lr
	cmp r5, #0x7f
	movgt r5, ip
	mov r3, r5, asr #6
	orr r3, r3, r5, lsl #1
	strh r3, [r0, r2]
	cmp r4, r1
	blo _0215AD24
	ldmia sp!, {r3, r4, r5, pc}
_0215AD5C:
	mov r4, #0
	cmp r1, #0
	ldmlsia sp!, {r3, r4, r5, pc}
	mov lr, r4
	mov r2, #0xff
_0215AD70:
	mov ip, r4, lsl #1
	ldrsh r3, [r0, ip]
	cmp r3, #0
	strlth lr, [r0, ip]
	mov ip, r4, lsl #1
	ldrsh r3, [r0, ip]
	add r4, r4, #1
	cmp r3, #0xff
	strgth r2, [r0, ip]
	cmp r4, r1
	blo _0215AD70
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215ADA0(s32 a1, s32 a2, s32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub lr, r1, #0x80
	ldr r1, =0x00001C5A
	ldr r3, =0x00000581
	mul r1, lr, r1
	add r1, r1, r0, lsl #12
	mov r1, r1, asr #0xc
	mul ip, lr, r3
	add r3, r1, #4
	sub r4, r2, #0x80
	ldr r1, =0x0000166E
	ldr r2, =0x00000B6C
	mul r1, r4, r1
	add r1, r1, r0, lsl #12
	mov r1, r1, asr #0xc
	add lr, r1, #4
	mul r1, r4, r2
	rsb r0, ip, r0, lsl #12
	sub r0, r0, r1
	mov r0, r0, asr #0xc
	add r0, r0, #4
	movs r2, lr, asr #3
	movmi r2, #0
	cmp r2, #0x1f
	mov r0, r0, asr #3
	movgt r2, #0x1f
	cmp r0, #0
	movlt r0, #0
	cmp r0, #0x1f
	movgt r0, #0x1f
	mov r1, r3, asr #3
	cmp r1, #0
	movlt r1, #0
	cmp r1, #0x1f
	movgt r1, #0x1f
	orr r0, r2, r0, lsl #5
	orr r0, r0, r1, lsl #10
	orr r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215AE54(u8 *a1, u16 *a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	ldr r0, [r9, #4]
	mov r6, #0
	cmp r0, #0
	mov r8, r1
	mov r5, r6
	addls sp, sp, #0xc
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0215AE7C:
	add r2, sp, #8
	mov r1, r5
	add r0, r9, #0x20
	bl CutsceneUnknownBackground__Func_215AF60
	ldr r1, [sp, #8]
	mov r5, r0
	add r0, r9, r1
	ldrb r2, [r0, #8]
	cmp r2, #0
	moveq r0, #1
	streq r0, [sp]
	beq _0215AECC
	add r3, sp, #0
	mov r1, r5
	add r0, r9, #0x20
	bl CutsceneUnknownBackground__Func_215B094
	ldr r1, [sp]
	mov r5, r0
	add r0, r1, #1
	str r0, [sp]
_0215AECC:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215AF30
	ldr r0, [sp]
	mov r7, #0
	cmp r0, #0
	bls _0215AF4C
	add r4, sp, #4
_0215AEEC:
	ldr r2, [sp, #8]
	mov r1, r5
	mov r3, r4
	add r0, r9, #0x20
	bl CutsceneUnknownBackground__Func_215B094
	mov r5, r0
	ldr r0, [sp, #4]
	ldr r1, [sp, #8]
	bl CutsceneUnknownBackground__Func_215B108
	mov r1, r6, lsl #1
	strh r0, [r8, r1]
	ldr r0, [sp]
	add r7, r7, #1
	cmp r7, r0
	add r6, r6, #1
	blo _0215AEEC
	b _0215AF4C
_0215AF30:
	ldr r0, [sp]
	add r1, r8, r6, lsl #1
	mov r2, r0, lsl #1
	mov r0, #0
	bl MIi_CpuClear16
	ldr r0, [sp]
	add r6, r6, r0
_0215AF4C:
	ldr r0, [r9, #4]
	cmp r0, r6, lsl #1
	bhi _0215AE7C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215AF60(s32 a1, s32 a2, u32 *a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r3, r1
	mov r4, r2
	add r0, sp, #0
	mov r1, r5
	mov r2, r3
	bl CutsceneUnknownBackground__Func_215B158
	add r0, sp, #0
	mov r6, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	bne _0215AFB0
	add r5, sp, #0
_0215AF9C:
	mov r0, r5
	add r6, r6, #1
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	beq _0215AF9C
_0215AFB0:
	cmp r6, #5
	addls pc, pc, r6, lsl #2
	b _0215B084
_0215AFBC: // jump table
	b _0215AFD4 // case 0
	b _0215AFE0 // case 1
	b _0215AFEC // case 2
	b _0215AFF8 // case 3
	b _0215B018 // case 4
	b _0215B048 // case 5
_0215AFD4:
	mov r0, #0
	str r0, [r4]
	b _0215B084
_0215AFE0:
	mov r0, #1
	str r0, [r4]
	b _0215B084
_0215AFEC:
	mov r0, #2
	str r0, [r4]
	b _0215B084
_0215AFF8:
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	moveq r0, #3
	streq r0, [r4]
	movne r0, #4
	strne r0, [r4]
	b _0215B084
_0215B018:
	add r0, sp, #0
	mov r5, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	orrne r5, r5, #2
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	orrne r5, r5, #1
	add r0, r5, #5
	str r0, [r4]
	b _0215B084
_0215B048:
	add r0, sp, #0
	mov r5, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	orrne r5, r5, #4
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	orrne r5, r5, #2
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	orrne r5, r5, #1
	add r0, r5, #9
	str r0, [r4]
_0215B084:
	add r0, sp, #0
	bl CutsceneUnknownBackground__Func_215B170
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215B094(s32 a1, u32 a2, u32 a3, s32 *a4)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r9, r1
	mov r8, r2
	add r0, sp, #0
	mov r1, r4
	mov r2, r9
	mov r7, r3
	bl CutsceneUnknownBackground__Func_215B158
	mov r6, #0
	str r6, [r7]
	cmp r8, #0
	mov r5, #1
	bls _0215B0FC
	add r4, sp, #0
_0215B0D4:
	mov r0, r4
	bl CutsceneUnknownBackground__Func_215B180
	cmp r0, #0
	ldrne r0, [r7, #0]
	add r6, r6, #1
	orrne r0, r0, r5
	strne r0, [r7]
	cmp r6, r8
	mov r5, r5, lsl #1
	blo _0215B0D4
_0215B0FC:
	add r0, r9, r8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

s16 CutsceneUnknownBackground__Func_215B108(s32 value, s32 id)
{
    static const u32 maskTable[] = { 0, 1, 3, 7, 0xF, 0x1F, 0x3F, 0x7F, 0xFF, 0x1FF, 0x3FF, 0x7FF, 0xFFF, 0x1FFF, 0x3FFF, 0x7FFF, 0xFFFF };

    if (id == 0)
        return 0;

    u32 mask = mask = id & maskTable[id];
    mask--;
    if ((value & (1 << mask)) != 0)
        return value;

    value |= (1 << mask);
    return -(s16)value;
}

void CutsceneUnknownBackground__Func_215B158(u32 *a1, s32 a2, u32 a3)
{
    a1[0] = a2;
    a1[1] = a3 >> 5;
    a1[2] = a3 & 31;
}

NONMATCH_FUNC u32 CutsceneUnknownBackground__Func_215B170(u32 *a1)
{
#ifdef NON_MATCHING
    return a1[2] + 32 * a1[1];
#else
    // clang-format off
	ldr r1, [r0, #4]
	ldr r0, [r0, #8]
	add r0, r0, r1, lsl #5
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneUnknownBackground__Func_215B180(u32 *a1)
{
#ifdef NON_MATCHING
    if (a1[2] < 31)
    {
        a1[2]++;
    }
    else
    {
        a1[2] = 0;
        a1[1]++;
    }
#else
    // clang-format off
	ldr r2, [r0, #0]
	ldmib r0, {r1, r3}
	ldr r1, [r2, r1, lsl #2]
	mov r2, #1
	cmp r3, #0x1f
	and r2, r1, r2, lsl r3
	addlo r1, r3, #1
	strlo r1, [r0, #8]
	blo _0215B1B8
	mov r1, #0
	str r1, [r0, #8]
	ldr r1, [r0, #4]
	add r1, r1, #1
	str r1, [r0, #4]
_0215B1B8:
	mov r0, r2
	bx lr

// clang-format on
#endif
}