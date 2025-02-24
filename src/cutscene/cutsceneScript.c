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

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _s32_div_f(void);
NOT_DECOMPILED void _u32_div_f(void);

NOT_DECOMPILED void BackgroundUnknown__Func_204CA00(void);

// --------------------
// CONSTANTS
// --------------------

#define CUTSCENESCRIPT_LOCATION_DATA  0x00000000
#define CUTSCENESCRIPT_LOCATION_STACK 0x70000000
#define CUTSCENESCRIPT_LOCATION_ROM   0x80000000

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
    void *archive;
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
    u16 field_48;
    u16 palette;
    CutsceneScript *cutscene;
    u32 dword50;
};

struct CutsceneSpriteButton_
{
    u32 field_0;
    AnimatorSprite ani;
    CutsceneTouchArea *touchArea;
    u32 field_6C;
};

struct CutsceneBackground_
{
    u32 field_0;
    Background ani;
    u32 field_4C;
};

struct CutsceneCamera3D_
{
    BOOL active;
    s32 field_4;
    Camera3D config;
    s32 field_58;
    u32 dword5C;
};

struct CutsceneModel_
{
    u32 field_0[B3D_RESOURCE_MAX];
    u32 field_18;
    AnimatorMDL ani;
    u32 field_160;
};

struct CutsceneAudioHandle_
{
    BOOL isActive;
    NNSSndHandle *handle;
};

struct CutsceneFadeManager_
{
    u32 flags;
    CutsceneFader control[2];
};

struct CutsceneFileSystemManager_
{
    s32 count;
    CutsceneArchive *archiveList;
    u32 field_8;
    u32 field_C;
    u32 field_10;
    ArchiveFile file;
};

struct CutsceneSpriteButtonManager_
{
    s32 count;
    CutsceneSpriteButton *list;
    TouchField touchField;
};

struct CutsceneBackgroundManager_
{
    CutsceneBackground renderers[8];
};

struct CutsceneModelManager_
{
    s32 count;
    CutsceneModel *list;
    CutsceneCamera3D camera;
};

struct CutsceneAudioManager_
{
    int handleCount;
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

static Task *cutsceneAssetSystemTask;

extern CutsceneScriptEngineCommand *CutsceneScript__EngineCommandTable[];
extern CutsceneScriptControlCommand *CutsceneScript__InstructionTable[];

static const NNSG3dResName camera2NodeName = { "node_camera2" };
static const NNSG3dResName target2NodeName = { "node_target2" };
static const NNSG3dResName target1NodeName = { "node_target" };
static const NNSG3dResName cameraNodeName  = { "node_camera" };
static const NNSG3dResName targetNodeName  = { "node_target" };
static const NNSG3dResName camera1NodeName = { "node_camera" };

// --------------------
// FUNCTIONS
// --------------------

void CutsceneScript__Create(CutsceneAssetSystem *parent, u32 priority)
{
    Task *task           = TaskCreate(CutsceneScript__Main, CutsceneScript__Destructor, TASK_FLAG_NONE, 0, priority, TASK_GROUP(0), CutsceneScript);
    parent->cutsceneTask = task;

    parent->cutscene = TaskGetWork(task, CutsceneScript);
    TaskInitWork16(parent->cutscene);

    CutsceneScript__InitFadeManager(&parent->cutscene->systemManager);
    parent->cutscene->status = CUTSCENESCRIPT_STATUS_IDLE;

    StartSamplingTouchInput(1);
}

void CutsceneAssetSystem__Destroy(CutsceneAssetSystem *work)
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

    CutsceneSystemManager__Release(&work->cutscene->systemManager);
    ShakeScreen(SCREENSHAKE_STOP);
    CutsceneAssetSystem__Release(work->cutscene);
    DestroyTask(work->cutsceneTask);
}

CutsceneScript *CutsceneAssetSystem__GetCutsceneScript(CutsceneAssetSystem *work)
{
    return work->cutscene;
}

void CutsceneScript__InitFileSystemManager(CutsceneAssetSystem *work, u32 count)
{
    CutsceneFileSystemManager__Init(&work->cutscene->systemManager, count);
}

void CutsceneScript__InitSpriteButtonManager(CutsceneAssetSystem *work, u32 count)
{
    CutsceneSpriteButtonManager__Init(&work->cutscene->systemManager, count);
}

void CutsceneScript__InitBackgroundManager(CutsceneAssetSystem *work)
{
    CutsceneBackgroundManager__Init(&work->cutscene->systemManager);
}

void CutsceneScript__InitModelManager(CutsceneAssetSystem *work, u32 count)
{
    CutsceneModelManager__Init(&work->cutscene->systemManager, count);

    // it'd be cleaner to do something like 'GX_SetPower(GX_GetPower() | GX_POWER_3D);', but that's not what they did unfortunately
    reg_GX_POWCNT |= GX_POWER_3D;
}

void CutsceneScript__InitAudioManager(CutsceneAssetSystem *work, u32 count)
{
    CutsceneAudioManager__Init(&work->cutscene->systemManager, count);
}

void CutsceneScript__InitTextManager(CutsceneAssetSystem *work)
{
    CutsceneTextManager__Init(&work->cutscene->systemManager, CutsceneTextWorker__Process, CutsceneTextWorker__Draw, CutsceneTextWorker__Release, sizeof(CutsceneTextWorker));

    CutsceneTextWorker *worker = CutsceneScript__GetTextWorker(work);
    MI_CpuClear16(worker, sizeof(*worker));
    CutsceneTextWorker__Init(worker);
}

CutsceneTextWorker *CutsceneScript__GetTextWorker(CutsceneAssetSystem *work)
{
    return CutsceneTextManager__GetWorker(&work->cutscene->systemManager);
}

void CutsceneScript__LoadScript(CutsceneAssetSystem *work, CutsceneScriptHeader *script)
{
    CutsceneScript__LoadScriptFile(work->cutscene, script, CutsceneScript__EngineCommandTable, 0);
    work->cutscene->status = CUTSCENESCRIPT_STATUS_LOADING;
}

void CutsceneScript__StartScript(CutsceneAssetSystem *work, s32 startParam, CutsceneScriptOnFinish onFinish)
{
    CutsceneScript__InitScriptWorker(work->cutscene, onFinish);

    s32 *data = CutsceneScript__GetFunctionParamConstant(work->cutscene, NULL, CUTSCENESCRIPT_LOCATION_DATA + 0x00);
    *data     = startParam;

    work->cutscene->status = CUTSCENESCRIPT_STATUS_READY;
}

void CutsceneScript__Destructor(Task *task)
{
    CutsceneScript *work = TaskGetWork(task, CutsceneScript);
    CutsceneAssetSystem__Release(work);
}

void CutsceneFadeTask__Destructor(Task *task)
{
    CutsceneFadeTask *work = TaskGetWork(task, CutsceneFadeTask);

    if (work->taskInfo != NULL)
        work->taskInfo->task = NULL;
}

CutsceneScriptResult CutsceneScript__SystemCommand__GetPadInputMask(ScriptThread *thread, CutsceneScript *work)
{
    s32 inputType  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 buttonMask = CutsceneScript__GetFunctionParamRegister(thread, 2);

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

    AYKCommand__SetRegister(thread, 0, padButtons & buttonMask);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SystemCommand__GetTouchPos(ScriptThread *thread, CutsceneScript *work)
{
    // ???
    s32 inputType  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 buttonMask = CutsceneScript__GetFunctionParamRegister(thread, 2);
    UNUSED(inputType);
    UNUSED(buttonMask);

    if (TOUCH_HAS_ON(touchInput.flags))
    {
        AYKCommand__SetRegister(thread, 0, touchInput.on.x);
        AYKCommand__SetRegister(thread, 1, touchInput.on.y);
    }
    else
    {
        AYKCommand__SetRegister(thread, 0, -1);
        AYKCommand__SetRegister(thread, 1, -1);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SystemCommand__GetGameLanguage(ScriptThread *thread, CutsceneScript *work)
{
    AYKCommand__SetRegister(thread, 0, GetGameLanguage());

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SystemCommand__GetVCount(ScriptThread *thread, CutsceneScript *work)
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

    AYKCommand__SetRegister(thread, 0, value);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SystemCommand__GetBrightness(ScriptThread *thread, CutsceneScript *work)
{
    s32 id   = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 type = CutsceneScript__GetFunctionParamRegister(thread, 2);

    s16 brightness;
    if (type == 0)
    {
        brightness = CutsceneScript__GetFadeManager(&work->systemManager)->control[id].brightness1;
    }
    else
    {
        brightness = VRAMSystem__GFXControl[id]->brightness;
    }

    AYKCommand__SetRegister(thread, 0, brightness);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__InitVRAMSystem(ScriptThread *thread, CutsceneScript *work)
{
    s32 mode = CutsceneScript__GetFunctionParamRegister(thread, 0);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__SetupBGBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamBG bank = (GXVRamBG)CutsceneScript__GetFunctionParamRegister(thread, 1);
        VRAMSystem__SetupBGBank(bank);
    }
    else
    {
        GXVRamSubBG bank = (GXVRamSubBG)CutsceneScript__GetFunctionParamRegister(thread, 1);
        VRAMSystem__SetupSubBGBank(bank);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetupOBJBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamOBJ bank = (GXVRamOBJ)CutsceneScript__GetFunctionParamRegister(thread, 1);
        CutsceneUnknown__Func_215902C(bank, 0);
    }
    else
    {
        GXVRamSubOBJ bank = (GXVRamSubOBJ)CutsceneScript__GetFunctionParamRegister(thread, 1);
        CutsceneUnknown__Func_2159188(bank, 0);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetupBGExtPalBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamBGExtPltt bank = (GXVRamBGExtPltt)CutsceneScript__GetFunctionParamRegister(thread, 1);
        VRAMSystem__SetupBGExtPalBank(bank);
    }
    else
    {
        GXVRamSubBGExtPltt bank = (GXVRamSubBGExtPltt)CutsceneScript__GetFunctionParamRegister(thread, 1);
        VRAMSystem__SetupSubBGExtPalBank(bank);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetupOBJExtPalBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);

    if (useEngineB != GRAPHICS_ENGINE_B)
    {
        GXVRamOBJExtPltt bank = (GXVRamOBJExtPltt)CutsceneScript__GetFunctionParamRegister(thread, 1);
        VRAMSystem__SetupOBJExtPalBank(bank);
    }
    else
    {
        GXVRamSubOBJExtPltt bank = (GXVRamSubOBJExtPltt)CutsceneScript__GetFunctionParamRegister(thread, 1);
        VRAMSystem__SetupSubOBJExtPalBank(bank);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetupTextureBank(ScriptThread *thread, CutsceneScript *work)
{
    GXVRamTex bank = (GXVRamTex)CutsceneScript__GetFunctionParamRegister(thread, 0);
    VRAMSystem__SetupTextureBank(bank);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetupTexturePalBank(ScriptThread *thread, CutsceneScript *work)
{
    GXVRamTexPltt bank = (GXVRamTexPltt)CutsceneScript__GetFunctionParamRegister(thread, 0);
    VRAMSystem__SetupTexturePalBank(bank);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetGraphicsMode(ScriptThread *thread, CutsceneScript *work)
{
    GXBGMode bgModeA = (GXBGMode)CutsceneScript__GetFunctionParamRegister(thread, 0);
    GXBG0As bg0_2d3d = (GXBG0As)CutsceneScript__GetFunctionParamRegister(thread, 1);
    GXBGMode bgModeB = (GXBGMode)CutsceneScript__GetFunctionParamRegister(thread, 2);

    if (bgModeA != (GXBGMode)-1)
        GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, bgModeA, (GXBG0As)(bg0_2d3d != FALSE));

    if (bgModeB != (GXBGMode)-1)
        GXS_SetGraphicsMode(bgModeB);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBackgroundControlText(ScriptThread *thread, CutsceneScript *work)
{
    s32 value1 = CutsceneScript__GetFunctionParamRegister(thread, 0);
    u8 value2  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 value3 = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 value4 = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 value5 = CutsceneScript__GetFunctionParamRegister(thread, 4);
    s32 value6 = CutsceneScript__GetFunctionParamRegister(thread, 5);

    CutsceneUnknown__Func_2158A6C(value1, value2, value3, value4, value5, value6);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBackgroundControlAffine(ScriptThread *thread, CutsceneScript *work)
{
    s32 value1 = CutsceneScript__GetFunctionParamRegister(thread, 0);
    u8 value2  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 value3 = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 value4 = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 value5 = CutsceneScript__GetFunctionParamRegister(thread, 4);
    s32 value6 = CutsceneScript__GetFunctionParamRegister(thread, 5);
    s32 value7 = CutsceneScript__GetFunctionParamRegister(thread, 6);

    CutsceneUnknown__Func_2158D3C(value1, value2, value3, value4, value5, value6, value7);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetCurrentDisplay(ScriptThread *thread, CutsceneScript *work)
{
    renderCurrentDisplay = (GXDispSelect)CutsceneScript__GetFunctionParamRegister(thread, 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__ProcessFadeTask(ScriptThread *thread, CutsceneScript *work)
{
    s32 mode  = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 timer = CutsceneScript__GetFunctionParamRegister(thread, 1);

    CutsceneFadeManager *fadeManager = CutsceneScript__GetFadeManager(&work->systemManager);
    CutsceneFadeTask__Process(fadeManager, mode, timer);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__CreateFadeTask(ScriptThread *thread, CutsceneScript *work)
{
    s32 mode  = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 flags = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 speed = CutsceneScript__GetFunctionParamRegister(thread, 2);

    if (work->taskFade[0].task != NULL)
        DestroyTask(work->taskFade[0].task);

    Task *parent = GetCurrentTask();

    Task *task             = TaskCreate(CutsceneFadeTask__Main, CutsceneFadeTask__Destructor, TASK_FLAG_NONE, 0, parent->priority, TASK_GROUP(0), CutsceneFadeTask);
    work->taskFade[0].task = task;

    CutsceneFadeTask *fadeManager = TaskGetWork(task, CutsceneFadeTask);
    TaskInitWork16(fadeManager);

    fadeManager->taskInfo = &work->taskFade[0];
    fadeManager->manager  = CutsceneScript__GetFadeManager(&work->systemManager);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__SetVisiblePlane(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB     = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 enablePlaneBG0 = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 enablePlaneBG1 = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 enablePlaneBG2 = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 enablePlaneBG3 = CutsceneScript__GetFunctionParamRegister(thread, 4);
    s32 enablePlaneOBJ = CutsceneScript__GetFunctionParamRegister(thread, 5);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBackgroundPriority(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB  = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 bg0Priority = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 bg1Priority = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 bg2Priority = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 bg3Priority = CutsceneScript__GetFunctionParamRegister(thread, 4);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendPlane(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB          = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 id                  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 enablePlaneBG0      = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 enablePlaneBG1      = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 enablePlaneBG2      = CutsceneScript__GetFunctionParamRegister(thread, 4);
    s32 enablePlaneBG3      = CutsceneScript__GetFunctionParamRegister(thread, 5);
    s32 enablePlaneOBJ      = CutsceneScript__GetFunctionParamRegister(thread, 6);
    s32 enablePlaneBackdrop = CutsceneScript__GetFunctionParamRegister(thread, 7);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendEffect(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 effect     = CutsceneScript__GetFunctionParamRegister(thread, 1);

    VRAMSystem__GFXControl[useEngineB]->blendManager.blendControl.effect = effect;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendAlpha(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 ev1        = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 ev2        = CutsceneScript__GetFunctionParamRegister(thread, 2);

    u16 ev_value = ev1 | (ev2 << 8);

    // TODO: this might be able to use 'gfxControl->blendManager.blendAlpha.ev1' & 'gfxControl->blendManager.blendAlpha.ev2'?
    // here's a decomp.me scratch for anyone willing to try: https://decomp.me/scratch/kCVnY
    VRAMSystem__GFXControl[useEngineB]->blendManager.blendAlpha.value = ev_value;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetBlendCoefficient(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 brightness = CutsceneScript__GetFunctionParamRegister(thread, 1);

    VRAMSystem__GFXControl[useEngineB]->blendManager.coefficient.value = brightness;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetWindowVisible(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB     = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 enableWindowW0 = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 enableWindowW1 = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 enableWindowOW = CutsceneScript__GetFunctionParamRegister(thread, 3);

    u32 maskW1 = enableWindowW1 ? GX_WNDMASK_W1 : GX_WNDMASK_NONE;
    u32 maskW0 = enableWindowW0 ? GX_WNDMASK_W0 : GX_WNDMASK_NONE;
    u32 maskOW = enableWindowOW ? GX_WNDMASK_OW : GX_WNDMASK_NONE;

    VRAMSystem__GFXControl[useEngineB]->windowManager.visible = maskW0 | maskW1 | maskOW;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetWindowPlane(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB        = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 id                = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 enablePlaneBG0    = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 enablePlaneBG1    = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 enablePlaneBG2    = CutsceneScript__GetFunctionParamRegister(thread, 4);
    s32 enablePlaneBG3    = CutsceneScript__GetFunctionParamRegister(thread, 5);
    s32 enablePlaneOBJ    = CutsceneScript__GetFunctionParamRegister(thread, 6);
    s32 enablePlaneEffect = CutsceneScript__GetFunctionParamRegister(thread, 7);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__SetWindowPosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 id         = CutsceneScript__GetFunctionParamRegister(thread, 1);
    u8 winX1       = CutsceneScript__GetFunctionParamRegister(thread, 2);
    u8 winY1       = CutsceneScript__GetFunctionParamRegister(thread, 3);
    u8 winX2       = CutsceneScript__GetFunctionParamRegister(thread, 4);
    u8 winY2       = CutsceneScript__GetFunctionParamRegister(thread, 5);

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

CutsceneScriptResult CutsceneScript__ScreenCommand__Unknown(ScriptThread *thread, CutsceneScript *work)
{
    s32 value1 = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 value2 = CutsceneScript__GetFunctionParamRegister(thread, 1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__SetCapture(ScriptThread *thread, CutsceneScript *work)
{
    GXCaptureSrcA a    = (GXCaptureSrcA)CutsceneScript__GetFunctionParamRegister(thread, 0);
    GXCaptureSrcB b    = (GXCaptureSrcB)CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 ev             = CutsceneScript__GetFunctionParamRegister(thread, 2);
    GXCaptureDest dest = (GXCaptureDest)CutsceneScript__GetFunctionParamRegister(thread, 3);

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

    switch (CutsceneUnknown__GetBankID(bank))
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

CutsceneScriptResult CutsceneScript__ScreenCommand__ShakeScreen1(ScriptThread *thread, CutsceneScript *work)
{
    s32 lifetime = CutsceneScript__GetFunctionParamRegister(thread, 0);

    ShakeScreenEx(lifetime, FLOAT_TO_FX32(4.8), 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ScreenCommand__ShakeScreen2(ScriptThread *thread, CutsceneScript *work)
{
    u32 lifetime = CutsceneScript__GetFunctionParamRegister(thread, 0);

    ScreenShake *screenShake = ShakeScreen(SCREENSHAKE_CUSTOM);
    if (screenShake != NULL)
        ShakeScreenEx(0, FLOAT_TO_FX32(4.8), screenShake->lifetime / lifetime);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153C90(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 1);
    s32 fileID       = CutsceneScript__GetFunctionParamRegister(thread, 2);

    s32 id = CutsceneFileSystemManager__Func_2156B08(&work->systemManager, path, fileID);
    if (id == 0)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    AYKCommand__SetRegister(thread, 0, id);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153CE8(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneFileSystemManager__Func_2156BEC(&work->systemManager, CutsceneScript__GetFunctionParamRegister(thread, 0));

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153D10(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneScript__SpriteCommand__Func_2153EDC(thread, work);
    CutsceneScript__BackgroundCommand__Func_21544BC(thread, work);
    CutsceneScript__ModelCommand__Func_21546AC(thread, work);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__MountArchive(ScriptThread *thread, CutsceneScript *work)
{
    s32 id           = CutsceneScript__GetFunctionParamRegister(thread, 0);
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 1);

    CutsceneFileSystemManager__MountArchive(&work->systemManager, id, path);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__UnmountArchive(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);

    CutsceneFileSystemManager__UnmountArchive(&work->systemManager, id);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153DAC(ScriptThread *thread, CutsceneScript *work)
{
    s32 flag = CutsceneScript__GetFunctionParamRegister(thread, 0);

    s32 value;
    if (flag != FALSE)
        value = 1;
    else
        value = 0;
    CutsceneFileSystemManager__Func_21569CC(&work->systemManager, value);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FileSystemCommand__Func_2153DDC(ScriptThread *thread, CutsceneScript *work)
{
    s32 flag = CutsceneScript__GetFunctionParamRegister(thread, 0);

    s32 value;
    if (flag != FALSE)
        value = 1;
    else
        value = 0;
    CutsceneFileSystemManager__Func_21569FC(&work->systemManager, value);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__LoadSprite(ScriptThread *thread, CutsceneScript *work)
{
    s32 useEngineB   = CutsceneScript__GetFunctionParamRegister(thread, 1);
    u16 animID       = CutsceneScript__GetFunctionParamRegister(thread, 2);
    u16 paletteRow   = CutsceneScript__GetFunctionParamRegister(thread, 3);
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 4);
    s32 fileID       = CutsceneScript__GetFunctionParamRegister(thread, 5);

    s32 id = CutsceneSpriteButtonManager__LoadSprite2(&work->systemManager, path, fileID, useEngineB, animID, paletteRow);
    if (id == 0)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    AYKCommand__SetRegister(thread, 0, id);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2153EB4(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);

    CutsceneSpriteButtonManager__Func_2157128(&work->systemManager, id);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2153EDC(ScriptThread *thread, CutsceneScript *work)
{
    u32 count;

    count = CutsceneSpriteButtonManager__Func_2156E2C(&work->systemManager) + 1;

    for (s32 i = 1; i < count; i++)
    {
        CutsceneSpriteButtonManager__Func_2157128(&work->systemManager, i);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__LoadSprite2(ScriptThread *thread, CutsceneScript *work)
{
    s32 id           = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 useEngineB   = CutsceneScript__GetFunctionParamRegister(thread, 1);
    u16 animID       = CutsceneScript__GetFunctionParamRegister(thread, 2);
    u16 paletteRow   = CutsceneScript__GetFunctionParamRegister(thread, 3);
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 4);
    s32 fileID       = CutsceneScript__GetFunctionParamRegister(thread, 5);

    if (CutsceneSpriteButtonManager__LoadSprite(&work->systemManager, id, path, fileID, useEngineB, animID, paletteRow) == FALSE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__SetAnimation(ScriptThread *thread, CutsceneScript *work)
{
    s32 id     = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 animID = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorSprite__SetAnimation(CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id), animID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpritePosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 x  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 y  = CutsceneScript__GetFunctionParamRegister(thread, 2);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);
    animator->pos.x          = x;
    animator->pos.y          = y;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteVisible(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL visible = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);
    if (visible)
        animator->flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
    else
        animator->flags |= ANIMATOR_FLAG_DISABLE_DRAW;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteLoopFlag(ScriptThread *thread, CutsceneScript *work)
{
    s32 id        = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL loopFlag = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);
    if (loopFlag)
        animator->flags &= ~ANIMATOR_FLAG_DID_LOOP;
    else
        animator->flags |= ANIMATOR_FLAG_DID_LOOP;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteFlip(ScriptThread *thread, CutsceneScript *work)
{
    s32 id     = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL flipX = CutsceneScript__GetFunctionParamRegister(thread, 1);
    BOOL flipY = CutsceneScript__GetFunctionParamRegister(thread, 2);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);

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

CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpritePriority(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s16 priority = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s16 order    = CutsceneScript__GetFunctionParamRegister(thread, 2);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);

    if (priority != -1)
        animator->oamPriority = priority;

    if (order != -1)
        animator->oamOrder = order;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__SetSpriteType(ScriptThread *thread, CutsceneScript *work)
{
    s32 id         = CutsceneScript__GetFunctionParamRegister(thread, 0);
    GXOamMode type = (GXOamMode)CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);

    animator->spriteType = type;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2154240(ScriptThread *thread, CutsceneScript *work)
{
    s32 id    = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL flag = CutsceneScript__GetFunctionParamRegister(thread, 1);

    u32 *unknown = CutsceneSpriteButtonManager__Func_2156E70(&work->systemManager, id);

    if (flag)
        *unknown &= ~1;
    else
        *unknown |= 1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__GetSpritePosition(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);

    s16 x = animator->pos.x;
    s16 y = animator->pos.y;
    AYKCommand__SetRegister(thread, 1, x);
    AYKCommand__SetRegister(thread, 2, y);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__GetSpritePalette(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);

    AnimatorSprite *animator = CutsceneSpriteButtonManager__GetAnimator(&work->systemManager, id);

    AYKCommand__SetRegister(thread, 1, animator->cParam.palette);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2154320(ScriptThread *thread, CutsceneScript *work)
{
    s32 id    = CutsceneScript__GetFunctionParamRegister(thread, 0);
    u16 flags = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 type  = CutsceneScript__GetFunctionParamRegister(thread, 2);

    CutsceneSpriteButtonManager__Func_215707C(&work->systemManager, id, flags, type, work);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__Func_2154384(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);

    CutsceneSpriteButtonManager__Func_21570F4(&work->systemManager, id);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SpriteCommand__Func_21543AC(ScriptThread *thread, CutsceneScript *work)
{
    s32 id   = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 mask = CutsceneScript__GetFunctionParamRegister(thread, 1);

    CutsceneTouchArea *touchArea = CutsceneSpriteButtonManager__Func_2156E54(&work->systemManager, id);

    TouchAreaResponseFlags responseFlags = touchArea->area.responseFlags;
    if (mask)
        responseFlags &= mask;

    AYKCommand__SetRegister(thread, 2, responseFlags);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BackgroundCommand__LoadBBG(ScriptThread *thread, CutsceneScript *work)
{
    BOOL useEngineB  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    u8 bgID          = CutsceneScript__GetFunctionParamRegister(thread, 2);
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 3);
    s32 fileID       = CutsceneScript__GetFunctionParamRegister(thread, 4);

    s32 id = CutsceneBackgroundManager__LoadBackground(&work->systemManager, path, fileID, useEngineB, bgID);
    if (id == 0)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    AYKCommand__SetRegister(thread, 0, id);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_2154494(ScriptThread *thread, CutsceneScript *work)
{
    s32 value = CutsceneScript__GetFunctionParamRegister(thread, 0);

    CutsceneBackgroundManager__Func_2157430(&work->systemManager, value);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_21544BC(ScriptThread *thread, CutsceneScript *work)
{
    u32 count;

    count = CutsceneBackgroundManager__Func_21571A4(&work->systemManager) + 1;

    for (s32 i = 1; i < count; i++)
    {
        CutsceneBackgroundManager__Func_2157430(&work->systemManager, i);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_2154504(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 x  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 y  = CutsceneScript__GetFunctionParamRegister(thread, 2);

    Background *bg = CutsceneBackgroundManager__GetBackground(&work->systemManager, id);
    bg->position.x = x;
    bg->position.y = y;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_215455C(ScriptThread *thread, CutsceneScript *work)
{
    s32 id   = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 flag = CutsceneScript__GetFunctionParamRegister(thread, 1);

    u32 *value = CutsceneBackgroundManager__Func_2157174(&work->systemManager, id);

    if (flag)
        *value &= ~1;
    else
        *value |= 1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BackgroundCommand__Func_21545B0(ScriptThread *thread, CutsceneScript *work)
{
    s32 id1  = CutsceneScript__GetFunctionParamRegister(thread, 0);
    u8 id2   = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 flag = CutsceneScript__GetFunctionParamRegister(thread, 2);

    u32 *value = CutsceneBackgroundManager__Func_215718C(&work->systemManager, id1, id2);

    if (flag)
        *value &= ~1;
    else
        *value |= 1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__LoadMDL(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 1);
    s32 fileID       = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 id           = CutsceneScript__GetFunctionParamRegister(thread, 3);

    s32 assetID = CutsceneModelManager__TryLoadModel(&work->systemManager, path, fileID, id);
    if (assetID == 0)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    AYKCommand__SetRegister(thread, 0, assetID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154684(ScriptThread *thread, CutsceneScript *work)
{
    s32 value = CutsceneScript__GetFunctionParamRegister(thread, 0);

    CutsceneModelManager__Func_2157A0C(&work->systemManager, value);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_21546AC(ScriptThread *thread, CutsceneScript *work)
{
    u32 count = CutsceneModelManager__Func_2157460(&work->systemManager);
    CutsceneModelManager__Func_215793C(&work->systemManager);

    for (u32 i = 1; i < count + 1; i++)
    {
        CutsceneModelManager__Func_2157A0C(&work->systemManager, i);
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__LoadMDL2(ScriptThread *thread, CutsceneScript *work)
{
    s32 value1       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 1);
    s32 fileID       = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 id           = CutsceneScript__GetFunctionParamRegister(thread, 3);

    if (CutsceneModelManager__LoadModel(&work->systemManager, value1, path, fileID, id) == FALSE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__LoadAniMDL(ScriptThread *thread, CutsceneScript *work)
{
    s32 value           = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 type            = CutsceneScript__GetFunctionParamRegister(thread, 1);
    const char *path    = CutsceneScript__GetFunctionParamString(thread, work, 2);
    s32 fileID          = CutsceneScript__GetFunctionParamRegister(thread, 3);
    s32 animID          = CutsceneScript__GetFunctionParamRegister(thread, 4);
    const char *texPath = CutsceneScript__GetFunctionParamString(thread, work, 5);
    s32 texFileID       = CutsceneScript__GetFunctionParamRegister(thread, 6);

    if (CutsceneModelManager__LoadModelAnimation(&work->systemManager, value, type, path, fileID, animID, texPath, texFileID) == FALSE)
        return CUTSCENESCRIPT_RESULT_SUSPEND_RETURN;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_215483C(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);
    fx32 x = CutsceneScript__GetFunctionParamRegister(thread, 1);
    fx32 y = CutsceneScript__GetFunctionParamRegister(thread, 2);
    fx32 z = CutsceneScript__GetFunctionParamRegister(thread, 3);

    AnimatorMDL *aniModel  = CutsceneModelManager__GetModel(&work->systemManager, id);
    aniModel->work.scale.x = x;
    aniModel->work.scale.y = y;
    aniModel->work.scale.z = z;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_21548A8(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);
    u16 x  = CutsceneScript__GetFunctionParamRegister(thread, 1);
    u16 y  = CutsceneScript__GetFunctionParamRegister(thread, 2);
    u16 z  = CutsceneScript__GetFunctionParamRegister(thread, 3);

    AnimatorMDL *aniModel = CutsceneModelManager__GetModel(&work->systemManager, id);

    MtxFx33 mtx;
    MtxFx33 mtxTemp;

    MTX_RotY33(&mtx, SinFX((s32)y), CosFX((s32)y));

    MTX_RotX33(&mtxTemp, SinFX((s32)x), CosFX((s32)x));
    MTX_Concat33(&mtx, &mtxTemp, &mtx);

    MTX_RotZ33(&mtxTemp, SinFX((s32)z), CosFX((s32)z));
    MTX_Concat33(&mtx, &mtxTemp, &mtx);

    MI_CpuCopy32(&mtx, &aniModel->work.matrix33, sizeof(MtxFx33));

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_21549E4(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);
    fx32 x = CutsceneScript__GetFunctionParamRegister(thread, 1);
    fx32 y = CutsceneScript__GetFunctionParamRegister(thread, 2);
    fx32 z = CutsceneScript__GetFunctionParamRegister(thread, 3);

    AnimatorMDL *aniModel        = CutsceneModelManager__GetModel(&work->systemManager, id);
    aniModel->work.translation.x = x;
    aniModel->work.translation.y = y;
    aniModel->work.translation.z = z;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154A50(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);
    fx32 x = CutsceneScript__GetFunctionParamRegister(thread, 1);
    fx32 y = CutsceneScript__GetFunctionParamRegister(thread, 2);
    fx32 z = CutsceneScript__GetFunctionParamRegister(thread, 3);

    AnimatorMDL *aniModel         = CutsceneModelManager__GetModel(&work->systemManager, id);
    aniModel->work.translation2.x = x;
    aniModel->work.translation2.y = y;
    aniModel->work.translation2.z = z;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154ABC(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL enabled = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorMDL *aniModel = CutsceneModelManager__GetModel(&work->systemManager, id);
    if (enabled)
        aniModel->work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
    else
        aniModel->work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154B10(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL enabled = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorMDL *aniModel = CutsceneModelManager__GetModel(&work->systemManager, id);
    if (enabled)
        aniModel->work.flags &= ~ANIMATOR_FLAG_DID_LOOP;
    else
        aniModel->work.flags |= ANIMATOR_FLAG_DID_LOOP;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154B64(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    BOOL enabled = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorMDL *aniModel = CutsceneModelManager__GetModel(&work->systemManager, id);

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

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154BF8(ScriptThread *thread, CutsceneScript *work)
{
    s32 value1 = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 value2 = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 value3 = CutsceneScript__GetFunctionParamRegister(thread, 2);

    if (value2 >= 0)
        CutsceneModelManager__Func_2157738(&work->systemManager, value1, value2, value3);
    else
        CutsceneModelManager__Func_215793C(&work->systemManager);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__LoadDrawState(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 0);

    s32 fileID = CutsceneScript__GetFunctionParamRegister(thread, 1);
    if (fileID < 0)
        fileID = ARCHIVEFILE_ID_NONE;

    void *memory = ArchiveFile__Load(path, fileID, NULL, ARCHIVEFILE_FLAG_NONE, NULL);
    CutsceneModelManager__LoadDrawState(&work->systemManager, memory);
    HeapFree(HEAP_USER, memory);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ModelCommand__Func_2154CCC(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 resource = CutsceneScript__GetFunctionParamRegister(thread, 1);

    AnimatorMDL *aniModel = CutsceneModelManager__GetModel(&work->systemManager, id);
    AYKCommand__SetRegister(thread, 2, (aniModel->animFlags[resource] & ANIMATORMDL_FLAG_FINISHED) != 0);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArc(ScriptThread *thread, CutsceneScript *work)
{
    const char *path = CutsceneScript__GetFunctionParamString(thread, work, 0);

    CutsceneAudioManager__Func_2157B08(&work->systemManager);
    LoadAudioSndArc(path);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_SetVolume(ScriptThread *thread, CutsceneScript *work)
{
    s32 musicVolume = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 sfxVolume   = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 voiceVolume = CutsceneScript__GetFunctionParamRegister(thread, 2);

    if (musicVolume != -1)
        SetMusicVolume(musicVolume);

    if (sfxVolume != -1)
        SetSfxVolume(sfxVolume);

    if (voiceVolume != -1)
        SetVoiceVolume(voiceVolume);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_MoveVolume(ScriptThread *thread, CutsceneScript *work)
{
    s32 id     = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 volume = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 frames = CutsceneScript__GetFunctionParamRegister(thread, 2);

    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, id);
    if (frames == -1)
        NNS_SndPlayerSetVolume(handle, volume);
    else
        NNS_SndPlayerMoveVolume(handle, volume, frames);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcGroup(ScriptThread *thread, CutsceneScript *work)
{
    s32 groupNo = CutsceneScript__GetFunctionParamRegister(thread, 0);

    NNS_SndArcLoadGroup(groupNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcSeq(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqNo = CutsceneScript__GetFunctionParamRegister(thread, 0);

    NNS_SndArcLoadSeq(seqNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcSeqArc(ScriptThread *thread, CutsceneScript *work)
{
    s32 waveArcNo = CutsceneScript__GetFunctionParamRegister(thread, 0);

    NNS_SndArcLoadSeqArc(waveArcNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_LoadSndArcBank(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo = CutsceneScript__GetFunctionParamRegister(thread, 0);

    NNS_SndArcLoadBank(seqArcNo, audioManagerSndHeap);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_PlayTrack(ScriptThread *thread, CutsceneScript *work)
{
    s32 id     = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 frames = CutsceneScript__GetFunctionParamRegister(thread, 2);

    u32 handleID         = CutsceneAudioManager__AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, handleID);

    PlayTrack(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, id);
    NNS_SndPlayerMoveVolume(handle, AUDIOMANAGER_VOLUME_MAX, frames);
    AYKCommand__SetRegister(thread, 0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_PlayTrackEx(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 2);
    s32 frames   = CutsceneScript__GetFunctionParamRegister(thread, 3);

    u32 handleID         = CutsceneAudioManager__AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, handleID);

    PlayTrackEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, id);
    NNS_SndPlayerMoveVolume(handle, AUDIOMANAGER_VOLUME_MAX, frames);
    AYKCommand__SetRegister(thread, 0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_PlaySequence(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 1);

    u32 handleID         = CutsceneAudioManager__AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, handleID);

    PlaySfx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, id);
    AYKCommand__SetRegister(thread, 0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_PlaySequenceEx(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 2);

    u32 handleID         = CutsceneAudioManager__AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, handleID);

    PlaySfxEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, id);
    AYKCommand__SetRegister(thread, 0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_PlayVoiceClip(ScriptThread *thread, CutsceneScript *work)
{
    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 1);

    u32 handleID         = CutsceneAudioManager__AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, handleID);

    PlayVoiceClip(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, id);
    AYKCommand__SetRegister(thread, 0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_PlayVoiceClipEx(ScriptThread *thread, CutsceneScript *work)
{
    s32 seqArcNo = CutsceneScript__GetFunctionParamRegister(thread, 1);
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 2);

    u32 handleID         = CutsceneAudioManager__AllocSoundHandle(&work->systemManager);
    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, handleID);

    PlayVoiceClipEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, id);
    AYKCommand__SetRegister(thread, 0, handleID);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_FadeSeq(ScriptThread *thread, CutsceneScript *work)
{
    s32 id        = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 fadeFrame = CutsceneScript__GetFunctionParamRegister(thread, 1);

    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, id);

    FadeOutStageSfx(handle, fadeFrame);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_FadeAllSeq(ScriptThread *thread, CutsceneScript *work)
{
    s32 fadeFrame = CutsceneScript__GetFunctionParamRegister(thread, 0);

    CutsceneAudioManager__StopAllSeq(&work->systemManager, fadeFrame);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_SetTrackPan(ScriptThread *thread, CutsceneScript *work)
{
    s32 id  = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 pan = CutsceneScript__GetFunctionParamRegister(thread, 1);

    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, id);

    NNS_SndPlayerSetTrackPan(handle, 0xFFFF, pan);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__SoundCommand_SetPlayerPriority(ScriptThread *thread, CutsceneScript *work)
{
    s32 id       = CutsceneScript__GetFunctionParamRegister(thread, 0);
    s32 priority = CutsceneScript__GetFunctionParamRegister(thread, 1);

    NNSSndHandle *handle = CutsceneAudioManager__GetSoundHandle(&work->systemManager, id);

    NNS_SndPlayerSetPlayerPriority(handle, priority);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__TextFunc__Execute(ScriptThread *thread, CutsceneScript *work)
{
    CutsceneTextManager *textManager = work->systemManager.textManager;

    return textManager->commandFunc(textManager->worker, thread, work);
}

void CutsceneScript__Main(void)
{
    CutsceneScript *work = TaskGetWorkCurrent(CutsceneScript);

    if (work->status == CUTSCENESCRIPT_STATUS_READY)
    {
        if (CutsceneScript__RunThreads(work))
            work->status = CUTSCENESCRIPT_STATUS_IDLE;
        else
            CutsceneSystemManager__Process(&work->systemManager);
    }
}

void CutsceneFadeTask__Main(void)
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

    CutsceneFadeTask__Process(work->manager, work->mode, FX32_TO_WHOLE(brightness));

    if (work->timer >= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
        DestroyCurrentTask();
}

void CutsceneScript__LoadScriptFile(CutsceneScript *work, CutsceneScriptHeader *script, CutsceneScriptEngineCommand **funcTable, s32 unknown)
{
    MI_CpuClear32(&work->runner, sizeof(work->runner));
    work->runner.script = script;

    // NOTE: this will 100% not work if ported to other architectures where sizeof(s32) != sizeof(void*)
    if (work->runner.script->rodataAddr < (size_t)script)
    {
        work->runner.script->rodataAddr += (size_t)script;
        work->runner.script->dataAddr += (size_t)script;
    }

    work->runner.funcTable = funcTable;
}

void CutsceneAssetSystem__Release(CutsceneScript *work)
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

BOOL CutsceneScript__RunThreads(CutsceneScript *work)
{
    ScriptThread **thread;

    s32 activeCount   = 0;
    BOOL needsDestroy = FALSE;

    for (thread = work->runner.threads; thread != &work->runner.threads[8]; thread++)
    {
        if ((*thread) != NULL)
        {
            CutsceneScriptResult result = CutsceneScript__ExecuteCommand(work, (*thread));
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

ScriptThread *CutsceneScript__InitScriptWorker(CutsceneScript *work, CutsceneScriptOnFinish onFinish)
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

    return CutsceneScript__InitScriptThread(work, work->runner.script->startAddr + CUTSCENESCRIPT_LOCATION_ROM);
}

ScriptThread *CutsceneScript__InitScriptThread(CutsceneScript *work, u32 pc)
{
    return work->runner.threads[CutsceneScript__AllocScriptThread(work, pc)];
}

CutsceneScriptSection CutsceneScript__GetAYKCommandLocation(u32 addr)
{
    return ovl07_2155770(addr);
}

void *CutsceneScript__GetFunctionParamConstant(CutsceneScript *work, ScriptThread *thread, u32 addr)
{
    return CutsceneScript__GetScriptPtr(work, thread, addr);
}

s32 CutsceneScript__GetFunctionParamRegister(ScriptThread *thread, s32 id)
{
    return thread->registers[id];
}

const char *CutsceneScript__GetFunctionParamString_(ScriptThread *thread, CutsceneScript *cutscene, s32 id)
{
    u32 addr = CutsceneScript__GetFunctionParamRegister(thread, id);
    if (addr == 0)
        return NULL;

    return CutsceneScript__GetFunctionParamConstant(cutscene, NULL, addr);
}

const char *CutsceneScript__GetFunctionParamString(ScriptThread *thread, CutsceneScript *cutscene, s32 id)
{
    return (const char *)CutsceneScript__GetFunctionParamString_(thread, cutscene, id);
}

void AYKCommand__SetRegister(ScriptThread *work, u32 id, s32 value)
{
    work->registers[id] = value;
}

CutsceneScriptResult CutsceneScript__ExecuteCommand(CutsceneScript *work, ScriptThread *thread)
{
    s32 pc;
    s32 *nextPC;

    s32 *pc_ptr;
    pc_ptr = &pc;

    ScriptCommand *command;

    CutsceneScriptResult result;
    do
    {
        pc = *CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);

        command = CutsceneScript__GetScriptPtr(work, thread, *pc_ptr);
        if (command->param2 != 0)
        {
            nextPC = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
            *nextPC += 3; // 3 * sizeof(s32)
        }
        else if (command->param1 != 0)
        {
            nextPC = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
            *nextPC += 2; // 2 * sizeof(s32)
        }
        else
        {
            nextPC = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
            *nextPC += 1; // 1 * sizeof(s32)
        }

        s32 type = (command->type >> 4) & 0xF;
        s32 id   = command->type & 0xF;
        result   = CutsceneScript__InstructionTable[type][id](work, thread, command);

        if (result == CUTSCENESCRIPT_RESULT_SUSPEND_RETURN)
        {
            *CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC) = pc;
            result                                                           = CUTSCENESCRIPT_RESULT_SUSPEND;
        }

    } while (result == CUTSCENESCRIPT_RESULT_CONTINUE);

    return result;
}

s32 *CutsceneScript__GetRegister(ScriptThread *work, u32 id)
{
    return &work->registers[id];
}

CutsceneScriptSection ovl07_2155770(u32 addr)
{
    if (addr < CUTSCENESCRIPT_LOCATION_STACK)
        return CUTSCENESCRIPT_SECTION_DATA;

    if (addr < CUTSCENESCRIPT_LOCATION_ROM)
        return CUTSCENESCRIPT_SECTION_STACK;

    return CUTSCENESCRIPT_SECTION_ROM;
}

void *CutsceneScript__GetScriptPtr(CutsceneScript *work, ScriptThread *thread, u32 addr)
{
    u32 section = CutsceneScript__GetAYKCommandLocation(addr);

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

void ScriptThread__PushStack(ScriptThread *work, s32 value)
{
    s32 *sp = CutsceneScript__GetRegister(work, CUTSCENESCRIPT_REGISTER_SP);
    (*sp)--;

    *(s32 *)CutsceneScript__GetScriptPtr(NULL, work, *sp) = value;
}

s32 ScriptThread__PopStack(ScriptThread *work)
{
    s32 *sp = CutsceneScript__GetRegister(work, CUTSCENESCRIPT_REGISTER_SP);

    return *(s32 *)CutsceneScript__GetScriptPtr(NULL, work, (*sp)++);
}

void *CutsceneScript__GetScriptParam(s32 type, s32 *param, s32 unknown, CutsceneScript *work, ScriptThread *thread)
{
    s32 *paramPtr = param;
    switch (type & 3)
    {
        case 1:
            // param is a register (index)
            paramPtr = CutsceneScript__GetRegister(thread, *param);
            break;

        case 2:
            // param is a constant (script address)
            paramPtr = CutsceneScript__GetScriptPtr(work, thread, *param);
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
            paramPtr = CutsceneScript__GetScriptPtr(work, thread, *paramPtr);
            break;

        case 2:
            reg      = CutsceneScript__GetRegister(thread, (type >> 4));
            paramPtr = CutsceneScript__GetScriptPtr(work, thread, *paramPtr + *reg);
            break;
    }

    return paramPtr;
}

s32 CutsceneScript__AllocScriptThread(CutsceneScript *work, u32 pc)
{
    s32 i = 0;

    ScriptThread **thread;
    for (i = 0; i < 8; i++)
    {
        thread = &work->runner.threads[i];

        if (*thread == NULL)
            break;
    }

    if (i >= 8)
        return -1;

    *thread = HeapAllocHead(HEAP_SYSTEM, sizeof(ScriptThread));
    MI_CpuClear32(*thread, sizeof(ScriptThread));

    *CutsceneScript__GetRegister(*thread, CUTSCENESCRIPT_REGISTER_SP) = CUTSCENESCRIPT_LOCATION_STACK + 0x100;
    *CutsceneScript__GetRegister(*thread, CUTSCENESCRIPT_REGISTER_PC) = pc;

    return i;
}

CutsceneScriptResult CutsceneScript__EndCommand_StopThreads(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_STOP_THREADS;
}

CutsceneScriptResult CutsceneScript__EndCommand_Continue(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__EndCommand_Suspend(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_SUSPEND;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Assign(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Add(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) += (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Subtract(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) -= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Multiply(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) *= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Divide(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);
    s32 *reg    = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT);

    (*reg)    = (*value1) % (*value2);
    (*value1) = (*value1) / (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Negate(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1) = -(*value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Increment(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1)++;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_Decrement(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1)--;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ArithmeticCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) >>= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_BitwiseAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) &= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_LogicalAND(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) != 0 && (*value2) != 0;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_BitwiseOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) |= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_LogicalOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) != 0 || (*value2) != 0;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_XOR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) ^= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_BitwiseNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1) = ~(*value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_LogicalNot(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);

    (*value1) = !(*value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_ShiftL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) <<= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_ShiftR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    u32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    u32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) >>= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_RotateL(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

#define ROL(x, y) ((unsigned)(x) << (y) | (unsigned)(x) >> 32 - (y))
    (*value1) = ROL((*value1), (*value2));
#undef ROL

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__BitwiseCommand_RotateR(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

#define ROR(x, y) ((unsigned)(x) >> (y) | (unsigned)(x) << 32 - (y))
    (*value1) = ROR((*value1), (*value2));
#undef ROR

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ComparisonCommand_Equal(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) == (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ComparisonCommand_NotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) != (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ComparisonCommand_Less(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) < (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ComparisonCommand_LessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) <= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ComparisonCommand_Greater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) > (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__ComparisonCommand_GreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    (*value1) = (*value1) >= (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__UnknownCommand_215636C(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 15, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT);

    (*reg) = (*value1) - (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__UnknownCommand_21563D8(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 15, work, thread);
    s32 *value2 = CutsceneScript__GetScriptParam(command->param2, GetScriptParam2(command), 15, work, thread);

    s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT);

    (*reg) = (*value1) & (*value2);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_Branch(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
    *reg += *value1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_IfEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) == 0)
    {
        s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_IfNotEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) != 0)
    {
        s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_IfGreaterEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) < 0)
    {
        s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_IfGreater(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) <= 0)
    {
        s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_IfLessEqual(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) > 0)
    {
        s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__IfCommand_IfLess(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);

    if ((*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT)) >= 0)
    {
        s32 *reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
        *reg += *value1;
    }

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FunctionCommand_CallFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);
    s32 *reg    = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);

    ScriptThread__PushStack(thread, *reg);

    reg = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
    *reg += *value1;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FunctionCommand_EndFunction(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 15, work, thread);

    s32 *reg1 = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_SP);
    *reg1 += *value1;

    if (*CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_SP) >= CUTSCENESCRIPT_LOCATION_STACK + 0x100)
        return CUTSCENESCRIPT_RESULT_FINISH;

    s32 *reg2 = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);
    *reg2     = ScriptThread__PopStack(thread);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FunctionCommand_CallFunctionASync(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 8, work, thread);
    s32 *reg    = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_PC);

    u32 pc = *value1 + *reg;

    s32 *pc_ptr;
    pc_ptr = &pc;

    s32 id                                                               = CutsceneScript__AllocScriptThread(work, *pc_ptr);
    *CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_RESULT) = id;

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__FunctionCommand_End(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    return CUTSCENESCRIPT_RESULT_FINISH;
}

CutsceneScriptResult CutsceneScript__EngineCommand_Execute(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s16 *value1      = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 15, work, thread);
    s32 *reg         = CutsceneScript__GetRegister(thread, CUTSCENESCRIPT_REGISTER_SP);
    void *commandPtr = CutsceneScript__GetScriptPtr(work, thread, *reg);

    return work->runner.funcTable[value1[1]][value1[0]](commandPtr, work);
}

CutsceneScriptResult CutsceneScript__StackCommand_Load(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 15, work, thread);

    ScriptThread__PushStack(thread, *value1);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneScriptResult CutsceneScript__StackCommand_Store(CutsceneScript *work, ScriptThread *thread, ScriptCommand *command)
{
    s32 *value1 = CutsceneScript__GetScriptParam(command->param1, GetScriptParam1(command), 3, work, thread);

    *value1 = ScriptThread__PopStack(thread);

    return CUTSCENESCRIPT_RESULT_CONTINUE;
}

CutsceneFadeManager *CutsceneScript__GetFadeManager(CutsceneSystemManager *work)
{
    return work->fadeManager;
}

void CutsceneScript__InitFadeManager(CutsceneSystemManager *work)
{
    MI_CpuClear16(work, sizeof(*work));
    CutsceneFadeManager__Alloc(work);
}

void CutsceneSystemManager__Release(CutsceneSystemManager *work)
{
    CutsceneTextManager__Release(work);
    CutsceneAudioManager__Release(work);
    CutsceneModelManager__Release(work);
    CutsceneBackgroundManager__Release(work);
    CutsceneSpriteButtonManager__Release(work);
    CutsceneFileSystemManager__Release(work);
    CutsceneFadeManager__Release(work);
}

void CutsceneFileSystemManager__Init(CutsceneSystemManager *work, u32 count)
{
    CutsceneFileSystemManager__Alloc(work, count);
}

void *CutsceneFileSystemManager__GetArchive(CutsceneSystemManager *work, s32 id)
{
    id--;
    return work->fileSystemManager->archiveList[id].archive;
}

BOOL CutsceneFileSystemManager__Func_21569A4(CutsceneSystemManager *work, s32 id)
{
    id--;
    return work->fileSystemManager->archiveList[id].refCount == 1;
}

void CutsceneFileSystemManager__Func_21569CC(CutsceneSystemManager *work, s32 value)
{
    work->fileSystemManager->field_8 = value != FALSE;
}

BOOL CutsceneFileSystemManager__Func_21569E4(CutsceneSystemManager *work)
{
    return work->fileSystemManager->field_8 != FALSE;
}

void CutsceneFileSystemManager__Func_21569FC(CutsceneSystemManager *work, s32 value)
{
    work->fileSystemManager->field_C = value != FALSE;
}

void CutsceneFileSystemManager__MountArchive(CutsceneSystemManager *work, s32 id, const char *arcName)
{
    id--;

    if (work->fileSystemManager->archiveList[id].fsArchive)
        CutsceneFileSystemManager__UnmountArchive(work, id);

    work->fileSystemManager->archiveList[id].fsArchive = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->fileSystemManager->archiveList[id].fsArchive));
    MI_CpuClear16(work->fileSystemManager->archiveList[id].fsArchive, sizeof(*work->fileSystemManager->archiveList[id].fsArchive));

    NNS_FndMountArchive(&work->fileSystemManager->archiveList[id].fsArchive->arc, arcName, work->fileSystemManager->archiveList[id].archive);
    work->fileSystemManager->archiveList[id].fsArchive->name.value = ((CutsceneArchiveName *)arcName)->value;
}

void CutsceneFileSystemManager__UnmountArchive(CutsceneSystemManager *work, s32 id)
{
    id--;
    NNS_FndUnmountArchive(&work->fileSystemManager->archiveList[id].fsArchive->arc);
    HeapFree(HEAP_SYSTEM, work->fileSystemManager->archiveList[id].fsArchive);
    work->fileSystemManager->archiveList[id].fsArchive = NULL;
}

NONMATCH_FUNC s32 CutsceneFileSystemManager__Func_2156B08(CutsceneSystemManager *work, const char *path, s32 fileID)
{
    // https://decomp.me/scratch/ehrrw -> 98.16%
#ifdef NON_MATCHING
    CutsceneFileSystemManager *manager;
    u32 i;

    manager = work->fileSystemManager;
    if (manager->field_10)
        return 0;

    i = 0;
    for (; i < manager->count; i++)
    {
        if (manager->archiveList[i].refCount != 0 || manager->archiveList[i].refCount == -1)
        {
            if (path == manager->archiveList[i].path && fileID == manager->archiveList[i].id)
            {
                if (manager->archiveList[i].refCount == -1)
                    manager->archiveList[i].refCount = 1;
                else
                    manager->archiveList[i].refCount++;

                return 1 + i;
            }
        }
    }

    i = 0;
    for (; i < manager->count; i++)
    {
        if (manager->archiveList[i].refCount == 0)
        {
            break;
        }
    }

    return CutsceneFileSystemManager__Func_2156C88(work, i + 1, path, fileID);
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
	bl CutsceneFileSystemManager__Func_2156C88
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void CutsceneFileSystemManager__Func_2156BEC(CutsceneSystemManager *work, s32 id)
{
    id--;

    CutsceneArchive *archive = &work->fileSystemManager->archiveList[id];
    archive->refCount--;
    if (archive->refCount == -1)
    {
        if (work->fileSystemManager->field_10 == id + 1)
        {
            void *memory = ArchiveFile__JoinThread(&work->fileSystemManager->file);
            if (memory != NULL)
                HeapFree(HEAP_SYSTEM, memory);

            ArchiveFile__Release(&work->fileSystemManager->file);
            work->fileSystemManager->field_10 = 0;
            ArchiveFile__Init(&work->fileSystemManager->file);
        }

        archive->refCount = 0;
    }

    if (archive->refCount == 0)
        CutsceneFileSystemManager__UnmountArchive2(archive);
}

NONMATCH_FUNC s32 CutsceneFileSystemManager__Func_2156C88(CutsceneSystemManager *work, s32 id, const char *path, s32 fileID)
{
    // https://decomp.me/scratch/qZwcx -> 99.23%
#ifdef NON_MATCHING
    u32 i;
    u32 count;
    CutsceneArchive *archive;
    BOOL flag;

    id--;

    flag = FALSE;

    if (work->fileSystemManager->field_10)
        return 0;

    archive = &work->fileSystemManager->archiveList[id];
    CutsceneFileSystemManager__UnmountArchive2(archive);

    if (fileID < 0)
    {
        fileID = -1;
        if (path[3] == ':')
        {
            CutsceneArchiveName name = *(CutsceneArchiveName *)path;

            name.text[3] = 0;

            count = work->fileSystemManager->count;
            for (i = 0; i < count; i++)
            {
                if (work->fileSystemManager->archiveList[i].refCount != 0 && work->fileSystemManager->archiveList[i].fsArchive != NULL
                    && name.value == work->fileSystemManager->archiveList[i].fsArchive->name.value)
                {
                    archive->next    = &work->fileSystemManager->archiveList[i];
                    archive->archive = NNS_FndGetArchiveFileByName(path);
                    flag             = TRUE;
                    work->fileSystemManager->archiveList[i].refCount++;
                    break;
                }
            }
        }
    }

    archive->refCount = 1;
    archive->path     = path;
    archive->id       = fileID;
    if (flag == FALSE)
    {
        ArchiveFile *file      = work->fileSystemManager->field_C != 0 ? &work->fileSystemManager->file : NULL;
        ArchiveFileFlags flags = work->fileSystemManager->field_8 != 0 ? ARCHIVEFILE_FLAG_IS_COMPRESSED : ARCHIVEFILE_FLAG_NONE;

        archive->archive = ArchiveFile__Load(path, fileID, NULL, flags, file);

        if (work->fileSystemManager->field_C != 0)
        {
            work->fileSystemManager->field_10 = id + 1;
            archive->refCount                 = -1;

            return 0;
        }
    }

    return id + 1;
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
	bl CutsceneFileSystemManager__UnmountArchive2
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

void CutsceneSpriteButtonManager__Init(CutsceneSystemManager *work, u32 count)
{
    CutsceneSpriteButtonManager__Alloc(work, count);
    TouchField__Init(&work->spriteButtonManager->touchField);
}

u32 CutsceneSpriteButtonManager__Func_2156E2C(CutsceneSystemManager *work)
{
    return work->spriteButtonManager->count;
}

AnimatorSprite *CutsceneSpriteButtonManager__GetAnimator(CutsceneSystemManager *work, s32 id)
{
    id--;
    return &work->spriteButtonManager->list[id].ani;
}

CutsceneTouchArea *CutsceneSpriteButtonManager__Func_2156E54(CutsceneSystemManager *work, s32 id)
{
    id--;
    return work->spriteButtonManager->list[id].touchArea;
}

u32 *CutsceneSpriteButtonManager__Func_2156E70(CutsceneSystemManager *work, s32 id)
{
    id--;
    return &work->spriteButtonManager->list[id].field_6C;
}

s32 CutsceneSpriteButtonManager__LoadSprite2(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow)
{
    if (work->fileSystemManager->field_10)
        return 0;

    u32 i     = 0;
    u32 count = work->spriteButtonManager->count;
    for (; i < count; i++)
    {
        if (work->spriteButtonManager->list[i].field_0 == 0)
        {
            break;
        }
    }

    return CutsceneSpriteButtonManager__LoadSprite(work, i + 1, path, fileID, useEngineB, animID, paletteRow);
}

s32 CutsceneSpriteButtonManager__LoadSprite(CutsceneSystemManager *work, s32 id, const char *path, s32 fileID, BOOL useEngineB, u16 animID, u16 paletteRow)
{
    id--;

    if (work->fileSystemManager->field_10)
        return 0;

    CutsceneSpriteButton *animator = &work->spriteButtonManager->list[id];

    CutsceneSpriteButtonManager__Func_21580E0(animator, work);

    animator->field_0 = CutsceneFileSystemManager__Func_2156B08(work, path, fileID);
    if (animator->field_0 == 0)
        return 0;

    void *sprite = CutsceneFileSystemManager__GetArchive(work, animator->field_0);
    if (Sprite__GetFormatFromAnim(sprite, 0) != BAC_FORMAT_INDEXED8_2D)
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

    return id + 1;
}

void CutsceneSpriteButtonManager__Func_215707C(CutsceneSystemManager *work, s32 id, u32 flags, s32 type, CutsceneScript *cutscene)
{
    id--;

    CutsceneSpriteButton *animator = &work->spriteButtonManager->list[id];

    if (animator->touchArea == NULL)
    {
        animator->touchArea = HeapAllocHead(HEAP_SYSTEM, sizeof(*animator->touchArea));
        MI_CpuClear16(animator->touchArea, sizeof(*animator->touchArea));
    }

    CutsceneSpriteButtonManager__AddTouchArea(animator->touchArea, &work->spriteButtonManager->touchField, &animator->ani, flags, cutscene, type);
}

void CutsceneSpriteButtonManager__Func_21570F4(CutsceneSystemManager *work, s32 id)
{
    id--;

    CutsceneSpriteButton *animator = &work->spriteButtonManager->list[id];

    CutsceneSpriteButtonManager__RemoveTouchArea(animator->touchArea);

    HeapFree(HEAP_SYSTEM, animator->touchArea);
    animator->touchArea = NULL;
}

void CutsceneSpriteButtonManager__Func_2157128(CutsceneSystemManager *work, s32 id)
{
    id--;

    CutsceneSpriteButtonManager__Func_21580E0(&work->spriteButtonManager->list[id], work);
}

void CutsceneBackgroundManager__Init(CutsceneSystemManager *work)
{
    CutsceneBackgroundManager__Alloc(work);
}

Background *CutsceneBackgroundManager__GetBackground(CutsceneSystemManager *work, s32 id)
{
    id--;
    return &work->backgroundManager->renderers[id].ani;
}

void *CutsceneBackgroundManager__Func_2157174(CutsceneSystemManager *work, s32 id)
{
    id--;
    return &work->backgroundManager->renderers[id].field_4C;
}

void *CutsceneBackgroundManager__Func_215718C(CutsceneSystemManager *work, s32 id1, s32 id2)
{
    return &work->backgroundManager->renderers[id2 | (4 * id1)].field_4C;
}

s32 CutsceneBackgroundManager__Func_21571A4(CutsceneSystemManager *work)
{
    UNUSED(work);
    return GRAPHICS_ENGINE_COUNT * BACKGROUND_COUNT;
}

s32 CutsceneBackgroundManager__LoadBackground(CutsceneSystemManager *work, const char *path, s32 fileID, BOOL useEngineB, u8 bgID)
{
    PixelMode pixelMode;
    u16 screenBaseBlock;
    void *backgroundFile;

    s32 id = bgID | (4 * useEngineB);

    if (work->fileSystemManager->field_10)
        return 0;

    CutsceneBackground *background = &work->backgroundManager->renderers[id];
    CutsceneBackgroundManager__Func_21582F4(background, work);
    background->field_0 = CutsceneFileSystemManager__Func_2156B08(work, path, fileID);
    if (background->field_0 == 0)
        return 0;

    backgroundFile = CutsceneFileSystemManager__GetArchive(work, background->field_0);
    if (CheckBackgroundIsValid(backgroundFile))
    {
        u32 flags = BACKGROUND_FLAG_LOAD_ALL | BACKGROUND_FLAG_SET_BG_Y | BACKGROUND_FLAG_SET_BG_X;

        u16 width  = GetBackgroundWidth(backgroundFile);
        u16 height = GetBackgroundHeight(backgroundFile);

        BOOL noPixels = FALSE;
        switch (GetBackgroundFormat(backgroundFile))
        {
            case BBG_FORMAT_2: {
                RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];

                RenderAffineControl *affineControl;
                if (bgID == BACKGROUND_2)
                    affineControl = &gfxControl->affineA;
                else
                    affineControl = &gfxControl->affineB;

                MTX_Identity22(&affineControl->matrix);
                affineControl->centerX = affineControl->centerY = 0;
                affineControl->x = affineControl->y = 0;
            }
                // fallthrough

            case BBG_FORMAT_0:
            case BBG_FORMAT_1: {
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

            case BBG_FORMAT_3:
            case BBG_FORMAT_4:
            case BBG_FORMAT_5:
            case BBG_FORMAT_6: {
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
                    affineControl = &gfxControl->affineA;
                else
                    affineControl = &gfxControl->affineB;

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
        GetVRAMPixelConfig(useEngineB, bgID, &pixelMode, &screenBaseBlock);

        int baseBlock = 0x4000 * screenBaseBlock;
        CutsceneAssetSystem__Func_215A124(backgroundFile, VRAMSystem__VRAM_BG[useEngineB] + baseBlock, HW_LCD_WIDTH, HW_LCD_HEIGHT);

        RenderAffineControl *affineControl;
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
        if (bgID == BACKGROUND_2)
            affineControl = &gfxControl->affineA;
        else
            affineControl = &gfxControl->affineB;

        MTX_Identity22(&affineControl->matrix);
        affineControl->centerX = affineControl->centerY = 0;
        affineControl->x = affineControl->y = 0;
    }

    return id + 1;
}

void CutsceneBackgroundManager__Func_2157430(CutsceneSystemManager *work, s32 id)
{
    id--;
    CutsceneBackgroundManager__Func_21582F4(&work->backgroundManager->renderers[id], work);
}

void CutsceneModelManager__Init(CutsceneSystemManager *work, u32 count)
{
    CutsceneModelManager__Alloc(work, count);
}

s32 CutsceneModelManager__Func_2157460(CutsceneSystemManager *work)
{
    return work->modelManager->count;
}

AnimatorMDL *CutsceneModelManager__GetModel(CutsceneSystemManager *work, s32 id)
{
    id--;
    return &work->modelManager->list[id].ani;
}

s32 CutsceneModelManager__TryLoadModel(CutsceneSystemManager *work, const char *path, s32 fileID, s32 id)
{
    if (work->fileSystemManager->field_10)
        return 0;

    u32 i     = 0;
    u32 count = work->modelManager->count;
    for (; i < count; i++)
    {
        if (work->modelManager->list[i].field_0[0] == 0)
        {
            break;
        }
    }

    return CutsceneModelManager__LoadModel(work, i + 1, path, fileID, id);
}

s32 CutsceneModelManager__LoadModel(CutsceneSystemManager *work, s32 slot, const char *path, s32 fileID, s32 id)
{
    slot--;

    if (work->fileSystemManager->field_10)
        return 0;

    CutsceneModel *animator = &work->modelManager->list[slot];

    CutsceneModelManager__Func_215858C(animator, work);
    animator->field_0[0] = CutsceneFileSystemManager__Func_2156B08(work, path, fileID);
    if (animator->field_0[0] == 0)
        return 0;

    void *resMDL = CutsceneFileSystemManager__GetArchive(work, animator->field_0[0]);

    if (CutsceneFileSystemManager__Func_21569A4(work, animator->field_0[0]))
        NNS_G3dResDefaultSetup(resMDL);

    AnimatorMDL__Init(&animator->ani, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&animator->ani, resMDL, id, FALSE, FALSE);

    return slot + 1;
}

s32 CutsceneModelManager__LoadModelAnimation(CutsceneSystemManager *work, s32 slot, s32 type, const char *path, s32 fileID, s32 animID, const char *texPath, s32 texFileID)
{
    CutsceneModel *animator;
    void *resource;
    void *texResource;

    slot--;

    s32 pos = B3D_ANIM_RESOURCE_OFFSET + type;
    if (work->fileSystemManager->field_10)
        return FALSE;

    animator = &work->modelManager->list[slot];

    if (animator->field_0[pos] != 0)
        CutsceneFileSystemManager__Func_2156BEC(work, animator->field_0[pos]);

    animator->field_0[pos] = CutsceneFileSystemManager__Func_2156B08(work, path, fileID);

    if (animator->field_0[pos] == 0)
        return FALSE;

    resource = CutsceneFileSystemManager__GetArchive(work, animator->field_0[pos]);

    if (type != B3D_ANIM_PAT_ANIM)
    {
        AnimatorMDL__SetAnimation(&animator->ani, type, resource, animID, NULL);
    }
    else
    {
        if (animator->field_18)
        {
            CutsceneFileSystemManager__Func_2156BEC(work, animator->field_18);
            animator->field_18 = 0;
        }

        if (texPath != NULL)
        {
            animator->field_18 = CutsceneFileSystemManager__Func_2156B08(work, texPath, texFileID);
            if (animator->field_18 == 0)
                return FALSE;

            if (CutsceneFileSystemManager__Func_21569E4(work))
                CutsceneFileSystemManager__Func_2156BEC(work, animator->field_0[pos]);

            texResource = CutsceneFileSystemManager__GetArchive(work, animator->field_18);
            if (CutsceneFileSystemManager__Func_21569A4(work, animator->field_18))
                NNS_G3dResDefaultSetup(texResource);
        }
        else
        {
            texResource = NNS_G3dGetTex(CutsceneFileSystemManager__GetArchive(work, animator->field_0[0]));
        }

        AnimatorMDL__SetAnimation(&animator->ani, type, resource, animID, texResource);
    }

    return TRUE;
}

void CutsceneModelManager__Func_2157738(CutsceneSystemManager *work, s32 type, s32 id, s32 value)
{
    CutsceneModelManager__Func_215793C(work);

    CutsceneModelManager *manager = work->modelManager;

    manager->camera.active   = type;
    manager->camera.field_4  = id - 1;
    manager->camera.field_58 = value;

    if (manager->camera.config.config.projScaleW != 0)
    {
        manager->camera.dword5C = manager->camera.config.config.projScaleW + MultiplyFX(manager->camera.config.config.projScaleW, (value / HW_LCD_HEIGHT));
    }
    else
    {
        manager->camera.dword5C = FLOAT_TO_FX32(1.0) + (value / HW_LCD_HEIGHT);
    }

    AnimatorMDL *animatorMDL         = CutsceneModelManager__GetModel(work, id);
    animatorMDL->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;

    switch (type)
    {
        case 1:
            NNS_G3dRenderObjSetCallBack(&animatorMDL->renderObj, CutsceneModelManager__RenderCallback_Single, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
            if (Camera3D__GetTask() != NULL)
                Camera3D__Destroy();
            break;

        case 2:
            NNS_G3dRenderObjSetCallBack(&animatorMDL->renderObj, CutsceneModelManager__RenderCallback_Single, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
            if (Camera3D__GetTask() == NULL)
                Camera3D__Create();
            break;

        case 3:
            NNS_G3dRenderObjSetCallBack(&animatorMDL->renderObj, CutsceneModelManager__RenderCallback_Double, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
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

void CutsceneModelManager__Func_215793C(CutsceneSystemManager *work)
{
    CutsceneModelManager *manager = work->modelManager;

    if (manager->camera.active != 0)
    {
        AnimatorMDL *animatorMDL         = CutsceneModelManager__GetModel(work, manager->camera.field_4 + 1);
        animatorMDL->work.matrixOpIDs[0] = MATRIX_OP_NONE;
        NNS_G3dRenderObjResetCallBack(&animatorMDL->renderObj);

        if (manager->camera.active == 2 || (s32)manager->camera.active == 3)
            Camera3D__Destroy();

        manager->camera.active = FALSE;
    }
}

void CutsceneModelManager__LoadDrawState(CutsceneSystemManager *work, void *memory)
{
    LoadDrawState(memory, DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT));

    CutsceneModelManager *manager = work->modelManager;

    GetDrawStateCameraProjection(memory, &manager->camera.config.config);

    manager->camera.config.lookAtUp.y = FLOAT_TO_FX32(1.0);

    if (manager->camera.field_58)
    {
        manager->camera.dword5C = manager->camera.config.config.projScaleW + MultiplyFX(manager->camera.config.config.projScaleW, (manager->camera.field_58 / HW_LCD_HEIGHT));
    }
    else
    {
        manager->camera.dword5C = manager->camera.config.config.projScaleW;
    }
}

void CutsceneModelManager__Func_2157A0C(CutsceneSystemManager *work, s32 id)
{
    id--;
    CutsceneModelManager__Func_215858C(&work->modelManager->list[id], work);
}

void CutsceneAudioManager__Init(CutsceneSystemManager *work, u32 count)
{
    CutsceneAudioManager__Alloc(work, count);
}

void CutsceneTextManager__Init(CutsceneSystemManager *work, CutsceneScriptTextCommand commandFunc, void (*processFunc)(CutsceneTextWorker *worker),
                               void (*releaseFunc)(CutsceneTextWorker *worker), size_t size)
{
    CutsceneTextManager__Alloc(work, size);

    CutsceneTextManager *manager = work->textManager;
    manager->commandFunc         = commandFunc;
    manager->processFunc         = processFunc;
    manager->releaseFunc         = releaseFunc;
}

void CutsceneSystemManager__Process(CutsceneSystemManager *work)
{
    CutsceneFadeManager__Process(work);
    CutsceneFileSystemManager__Process(work);
    CutsceneSpriteButtonManager__Process(work);
    CutsceneBackgroundManager__Process(work);
    CutsceneModelManager__Process(work);
    CutsceneAudioManager__Process(work);
    CutsceneTextManager__Process(work);
}

NNSSndHandle *CutsceneAudioManager__GetSoundHandle(CutsceneSystemManager *work, s32 id)
{
    id--;
    return work->audioManager->handleList[id].handle;
}

s32 CutsceneAudioManager__AllocSoundHandle(CutsceneSystemManager *work)
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

    return i + 1;
}

void CutsceneAudioManager__Func_2157B08(CutsceneSystemManager *work)
{
    u32 prevCount = work->audioManager->handleCount;

    CutsceneAudioManager__Release(work);
    CutsceneAudioManager__Alloc(work, prevCount);
}

void CutsceneAudioManager__StopAllSeq(CutsceneSystemManager *work, s32 fadeFrame)
{
    CutsceneAudioHandle *listPtr = &work->audioManager->handleList[0];
    CutsceneAudioHandle *listEnd = &work->audioManager->handleList[work->audioManager->handleCount];

    for (; listPtr != listEnd; listPtr++)
    {
        if (listPtr->handle != NULL)
            NNS_SndPlayerStopSeq(listPtr->handle, fadeFrame);
    }
}

CutsceneTextWorker *CutsceneTextManager__GetWorker(CutsceneSystemManager *work)
{
    return work->textManager->worker;
}

void CutsceneModelManager__RenderCallback_Single(NNSG3dRS *rs)
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

void CutsceneModelManager__RenderCallback_Double(NNSG3dRS *rs)
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

void CutsceneModelManager__Func_2157D6C(CutsceneCamera3D *work)
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
            matProjPositionY = -work->dword5C;
        else
            matProjPositionY = work->dword5C;

        work->config.config.matProjPosition.y = matProjPositionY;
    }
    else
    {
        work->config.config.matProjPosition.y = 0;
    }

    Camera3D__LoadState(&work->config);
}

void CutsceneFadeManager__Alloc(CutsceneSystemManager *work)
{
    work->fadeManager = HeapAllocHead(HEAP_SYSTEM, sizeof(CutsceneFadeManager));
    CutsceneFadeManager__Init(work->fadeManager);
}

void CutsceneFadeManager__Release(CutsceneSystemManager *work)
{
    HeapFree(HEAP_SYSTEM, work->fadeManager);
    work->fadeManager = NULL;
}

void CutsceneFadeManager__Process(CutsceneSystemManager *work)
{
    CutsceneFadeManager *fadeManager = work->fadeManager;

    CutsceneFadeManager__Draw(fadeManager);
    CutsceneFadeManager__Init(fadeManager);
}

void CutsceneFileSystemManager__Alloc(CutsceneSystemManager *work, u32 count)
{
    work->fileSystemManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->fileSystemManager));

    CutsceneFileSystemManager *manager = work->fileSystemManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->count       = count;
    manager->archiveList = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->archiveList) * count);
    MI_CpuClear32(manager->archiveList, sizeof(*manager->archiveList) * count);

    ArchiveFile__Init(&manager->file);
}

void CutsceneFileSystemManager__UnmountArchive2(CutsceneArchive *work)
{
    if (work->archive != NULL)
    {
        if (work->fsArchive != NULL)
        {
            NNS_FndUnmountArchive(&work->fsArchive->arc);
            HeapFree(HEAP_SYSTEM, work->fsArchive);
        }

        if (work->next == NULL)
        {
            HeapFree(HEAP_USER, work->archive);
        }
        else
        {
            work->next->refCount--;

            if (work->next->refCount == 0)
                CutsceneFileSystemManager__UnmountArchive2(work->next);
        }

        MI_CpuClear32(work, sizeof(*work));
    }
}

void CutsceneFileSystemManager__Release(CutsceneSystemManager *work)
{
    CutsceneFileSystemManager *manager = work->fileSystemManager;

    if (manager != NULL)
    {
        void *memory = ArchiveFile__JoinThread(&manager->file);
        if (memory != NULL)
            HeapFree(HEAP_USER, memory);

        ArchiveFile__Release(&manager->file);

        for (CutsceneArchive *archive = &manager->archiveList[0]; archive != &manager->archiveList[manager->count]; archive++)
        {
            if (archive->refCount != 0)
                CutsceneFileSystemManager__UnmountArchive2(archive);
        }

        HeapFree(HEAP_SYSTEM, manager->archiveList);
        HeapFree(HEAP_SYSTEM, manager);
        work->fileSystemManager = NULL;
    }
}

void CutsceneFileSystemManager__Process(CutsceneSystemManager *work)
{
    if (work->fileSystemManager->field_10)
    {
        if (ArchiveFile__CheckThreadInactive(&work->fileSystemManager->file))
        {
            CutsceneArchive *archive = &work->fileSystemManager->archiveList[work->fileSystemManager->field_10 - 1];

            archive->archive = ArchiveFile__JoinThread(&work->fileSystemManager->file);
            ArchiveFile__Release(&work->fileSystemManager->file);

            work->fileSystemManager->field_10 = 0;
            ArchiveFile__Init(&work->fileSystemManager->file);
        }
    }
}

void CutsceneSpriteButtonManager__Alloc(CutsceneSystemManager *work, u32 count)
{
    work->spriteButtonManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->spriteButtonManager));

    CutsceneSpriteButtonManager *manager = work->spriteButtonManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->count = count;
    manager->list  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->list) * count);
    MI_CpuClear32(manager->list, sizeof(*manager->list) * count);
}

void CutsceneSpriteButtonManager__Func_21580E0(CutsceneSpriteButton *work, CutsceneSystemManager *manager)
{
    if (work->field_0 != 0)
    {
        AnimatorSprite__Release(&work->ani);
        CutsceneFileSystemManager__Func_2156BEC(manager, work->field_0);

        if (work->touchArea != NULL)
        {
            CutsceneSpriteButtonManager__RemoveTouchArea(work->touchArea);
            HeapFree(HEAP_SYSTEM, work->touchArea);
        }

        MI_CpuClear32(work, sizeof(*work));
    }
}

void CutsceneSpriteButtonManager__Release(CutsceneSystemManager *work)
{
    CutsceneSpriteButtonManager *manager = work->spriteButtonManager;

    if (manager != NULL)
    {
        for (CutsceneSpriteButton *spriteButton = &manager->list[0]; spriteButton != &manager->list[manager->count]; spriteButton++)
        {
            if (spriteButton->field_0 != 0)
                CutsceneSpriteButtonManager__Func_21580E0(spriteButton, work);
        }

        HeapFree(HEAP_SYSTEM, manager->list);
        HeapFree(HEAP_SYSTEM, manager);
        work->spriteButtonManager = NULL;
    }
}

void CutsceneSpriteButtonManager__Process(CutsceneSystemManager *work)
{
    CutsceneSpriteButtonManager *manager = work->spriteButtonManager;

    if (manager != NULL)
    {
        CutsceneSpriteButton *spriteButton;
        BOOL flag;
        s32 shakeX;
        s32 shakeY;

        if (ShakeScreen(SCREENSHAKE_CUSTOM))
        {
            s32 seed = GetScreenShakeOffsetY();

            shakeX = FX32_TO_WHOLE(seed);
            shakeY = FX32_TO_WHOLE(MultiplyFX(ShakeScreen(SCREENSHAKE_CUSTOM)->lifetime, FX32_TO_WHOLE(Task__Unknown204BE48__Func_204C104(seed)) >> 7));
            flag   = TRUE;
        }
        else
        {
            shakeX = 0;
            shakeY = 0;
            flag   = FALSE;
        }

        for (spriteButton = &manager->list[0]; spriteButton != &manager->list[manager->count]; spriteButton++)
        {
            if (spriteButton->field_0)
            {
                AnimatorSprite__ProcessAnimationFast(&spriteButton->ani);
                if (flag == FALSE || (spriteButton->field_6C & 1) != 0)
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

void CutsceneBackgroundManager__Alloc(CutsceneSystemManager *work)
{
    work->backgroundManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->backgroundManager));

    CutsceneBackgroundManager *manager = work->backgroundManager;

    MI_CpuClear32(manager, sizeof(*manager));
}

void CutsceneBackgroundManager__Func_21582F4(CutsceneBackground *work, CutsceneSystemManager *manager)
{
    if (work->field_0 != 0)
        CutsceneFileSystemManager__Func_2156BEC(manager, work->field_0);

    MI_CpuClear32(work, sizeof(*work));
}

void CutsceneBackgroundManager__Release(CutsceneSystemManager *work)
{
    CutsceneBackgroundManager *manager = work->backgroundManager;

    if (manager != NULL)
    {
        for (CutsceneBackground *background = &manager->renderers[0]; background != &manager->renderers[8]; background++)
        {
            CutsceneBackgroundManager__Func_21582F4(background, work);
        }

        HeapFree(HEAP_SYSTEM, manager);
        work->backgroundManager = NULL;
    }
}

void CutsceneBackgroundManager__Process(CutsceneSystemManager *work)
{
    if (work->backgroundManager != NULL)
    {
        u32 i;
        u32 ii;
        CutsceneBackground *background;
        BOOL flag;
        s32 shakeX;
        s32 shakeY;

        if (ShakeScreen(SCREENSHAKE_CUSTOM) != NULL)
        {
            s32 seed = GetScreenShakeOffsetY();

            shakeX = FX32_TO_WHOLE(seed);
            shakeY = FX32_TO_WHOLE(MultiplyFX(ShakeScreen(SCREENSHAKE_CUSTOM)->lifetime, FX32_TO_WHOLE(Task__Unknown204BE48__Func_204C104(seed)) >> 7));
            flag   = TRUE;
        }
        else
        {
            shakeX = 0;
            shakeY = 0;
            flag   = FALSE;
        }

        for (i = 0, ii = 0; i < 8; i++, ii++)
        {
            background = &work->backgroundManager->renderers[ii];

            if (background->field_0)
            {
                if (flag == FALSE || (background->field_4C & 1) != 0)
                {
                    DrawBackground(&background->ani);
                }
                else
                {
                    if ((background->ani.flags & 0xC0) != 0)
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
                if ((background->field_4C & 1) == 0)
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
                            affinePos = (Vec2Fx16 *)&gfxControl->affineA.x;
                            break;

                        case BACKGROUND_3:
                            affinePos = (Vec2Fx16 *)&gfxControl->affineB.x;
                            break;
                    }

                    affinePos->x = -shakeX;
                    affinePos->y = -shakeY;
                }
            }
        }
    }
}

void CutsceneModelManager__Alloc(CutsceneSystemManager *work, u32 count)
{
    work->modelManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->modelManager));

    CutsceneModelManager *manager = work->modelManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->count = count;
    manager->list  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->list) * count);
    MI_CpuClear32(manager->list, sizeof(*manager->list) * count);
}

void CutsceneModelManager__Func_215858C(CutsceneModel *work, CutsceneSystemManager *manager)
{
    if (work->field_0[0] != 0)
    {
        for (u32 *animResource = &work->field_0[1]; animResource != &work->field_0[B3D_RESOURCE_MAX]; animResource++)
        {
            if (*animResource != 0)
            {
                if (CutsceneFileSystemManager__Func_21569A4(manager, *animResource))
                {
                    NNS_G3dResDefaultRelease(CutsceneFileSystemManager__GetArchive(manager, *animResource));
                }
                CutsceneFileSystemManager__Func_2156BEC(manager, *animResource);
            }
        }

        if (work->field_18 != 0)
        {
            if (CutsceneFileSystemManager__Func_21569A4(manager, work->field_18))
            {
                NNS_G3dResDefaultRelease(CutsceneFileSystemManager__GetArchive(manager, work->field_18));
            }

            CutsceneFileSystemManager__Func_2156BEC(manager, work->field_18);
        }

        if (CutsceneFileSystemManager__Func_21569A4(manager, work->field_0[0]))
        {
            NNS_G3dResDefaultRelease(CutsceneFileSystemManager__GetArchive(manager, work->field_0[0]));
        }

        CutsceneFileSystemManager__Func_2156BEC(manager, work->field_0[0]);

        AnimatorMDL__Release(&work->ani);
        MI_CpuClear32(work, sizeof(*work));
    }
}

void CutsceneModelManager__Release(CutsceneSystemManager *work)
{
    CutsceneModelManager *manager = work->modelManager;

    if (manager != NULL)
    {
        for (CutsceneModel *model = &manager->list[0]; model != &manager->list[manager->count]; model++)
        {
            if (model->field_0[0] != 0)
                CutsceneModelManager__Func_215858C(model, work);
        }

        if (work->modelManager->camera.active == 2 || (s32)work->modelManager->camera.active == 3)
        {
            Camera3D__Destroy();
            work->modelManager->camera.active = FALSE;
        }

        HeapFree(HEAP_SYSTEM, manager->list);
        HeapFree(HEAP_SYSTEM, manager);
        work->modelManager = NULL;
    }
}

void CutsceneModelManager__Process(CutsceneSystemManager *work)
{
    CutsceneModelManager *manager = work->modelManager;

    if (manager != NULL)
    {
        if (manager->camera.active == 0)
        {
            for (CutsceneModel *model = &manager->list[0]; model != &manager->list[manager->count]; model++)
            {
                if (model->field_0[0] != 0)
                {
                    AnimatorMDL__ProcessAnimation(&model->ani);
                    AnimatorMDL__Draw(&model->ani);
                }
            }
        }
        else
        {
            CutsceneModel *targetModel = &manager->list[manager->camera.field_4];

            AnimatorMDL__ProcessAnimation(&targetModel->ani);
            AnimatorMDL__Draw(&targetModel->ani);

            CutsceneModelManager__Func_2157D6C(&manager->camera);

            for (CutsceneModel *model = &manager->list[0]; model != targetModel; model++)
            {
                if (model->field_0[0] != 0)
                {
                    AnimatorMDL__ProcessAnimation(&model->ani);
                    AnimatorMDL__Draw(&model->ani);
                }
            }

            if (targetModel != &manager->list[manager->count] && ++targetModel != &manager->list[manager->count])
            {
                for (; targetModel != &manager->list[manager->count]; targetModel++)
                {
                    if (targetModel->field_0[0] != 0)
                    {
                        AnimatorMDL__ProcessAnimation(&targetModel->ani);
                        AnimatorMDL__Draw(&targetModel->ani);
                    }
                }
            }
        }
    }
}

void CutsceneAudioManager__Alloc(CutsceneSystemManager *work, u32 count)
{
    ReleaseAudioSystem();

    work->audioManager = HeapAllocHead(HEAP_SYSTEM, sizeof(*work->audioManager));

    CutsceneAudioManager *manager = work->audioManager;

    MI_CpuClear32(manager, sizeof(*manager));

    manager->handleCount = count;
    manager->handleList  = HeapAllocHead(HEAP_SYSTEM, sizeof(*manager->handleList) * count);
    MI_CpuClear32(manager->handleList, sizeof(*manager->handleList) * count);

    for (CutsceneAudioHandle *handle = &manager->handleList[0]; handle != &manager->handleList[count]; handle++)
    {
        handle->handle = AllocSndHandle();
    }
}

void CutsceneAudioManager__Func_21588A8(CutsceneAudioHandle *work, CutsceneSystemManager *manager)
{
    if (work->isActive)
    {
        NNS_SndPlayerStopSeq(work->handle, 0);
        NNS_SndHandleReleaseSeq(work->handle);
        work->isActive = FALSE;
    }
}

void CutsceneAudioManager__Release(CutsceneSystemManager *work)
{
    CutsceneAudioManager *manager = work->audioManager;

    if (manager != NULL)
    {
        for (CutsceneAudioHandle *handle = &manager->handleList[0]; handle != &manager->handleList[manager->handleCount]; handle++)
        {
            if (handle->handle != NULL)
                CutsceneAudioManager__Func_21588A8(handle, work);

            FreeSndHandle(handle->handle);
        }

        ReleaseAudioSystem();
        HeapFree(HEAP_SYSTEM, manager->handleList);
        HeapFree(HEAP_SYSTEM, manager);
        work->audioManager = NULL;
    }
}

void CutsceneAudioManager__Process(CutsceneSystemManager *work)
{
    CutsceneAudioHandle *handle;
    CutsceneAudioManager *manager = work->audioManager;

    if (manager != NULL)
    {
        for (handle = &manager->handleList[0]; handle != &manager->handleList[manager->handleCount]; handle++)
        {
            if (handle->handle != NULL)
            {
                if (!NNS_SndHandleIsValid(handle->handle))
                    CutsceneAudioManager__Func_21588A8(handle, work);
            }
        }
    }
}

void CutsceneTextManager__Alloc(CutsceneSystemManager *work, size_t size)
{
    work->textManager = HeapAllocHead(HEAP_SYSTEM, sizeof(CutsceneTextManager));

    CutsceneTextManager *manager = work->textManager;
    MI_CpuClear32(work->textManager, sizeof(*work->textManager));

    manager->worker = HeapAllocHead(HEAP_SYSTEM, size);
    MI_CpuClear32(manager->worker, size);
}

void CutsceneTextManager__Release(CutsceneSystemManager *work)
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

void CutsceneTextManager__Process(CutsceneSystemManager *work)
{
    if (work->textManager->processFunc != NULL)
        work->textManager->processFunc(work->textManager->worker);
}

void CutsceneUnknown__Func_2158A6C(BOOL useEngineB, u8 backgroundID, s32 screenSize, s32 colorMode, s32 screenBase, s32 charBase)
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

NONMATCH_FUNC void CutsceneUnknown__Func_2158D3C(BOOL useEngineB, u8 type, s32 backgroundID, s32 screenSize, s32 areaOver, s32 screenBase, s32 charBase)
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
        affineControl = &gfxControl->affineA;
    else
        affineControl = &gfxControl->affineB;
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

void CutsceneUnknown__Func_215902C(GXVRamOBJ bank, u16 bankOffset)
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

void CutsceneUnknown__Func_2159188(GXVRamSubOBJ bank, u16 bankOffset)
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

u32 CutsceneUnknown__GetBankID(s32 a1)
{
    u32 array[] = { 0, 1, 2, 3, 8, 9, 11, 4, 5, 6, 7, 11, 11 };
    return array[BankUnknown__GetBankID(a1)];
}

void CutsceneFadeManager__Init(CutsceneFadeManager *work)
{
    MI_CpuClear16(work, sizeof(*work));
}

void CutsceneFadeTask__Process(CutsceneFadeManager *work, s32 mode, s32 timer)
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

void CutsceneFadeManager__Draw(CutsceneFadeManager *work)
{
    if ((work->flags & 1) != 0)
        renderCoreGFXControlA.brightness = work->control[GRAPHICS_ENGINE_A].brightness1;

    if ((work->flags & 2) != 0)
        renderCoreGFXControlB.brightness = work->control[GRAPHICS_ENGINE_B].brightness1;

    ApplyCutsceneFade(work, GRAPHICS_ENGINE_A);
    ApplyCutsceneFade(work, GRAPHICS_ENGINE_B);
}

NONMATCH_FUNC void CutsceneSpriteButtonManager__AddTouchArea(CutsceneTouchArea *work, TouchField *touchField, AnimatorSprite *animator, u32 flags, CutsceneScript *cutscene,
                                                             s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r4, [r6, #0x38]
	mov r5, r1
	cmp r4, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	str r2, [r6, #0x3c]
	mov r4, #0
	ldr lr, [sp, #0x1c]
	ldr r1, [sp, #0x18]
	str r4, [r6, #0x40]
	str r1, [r6, #0x4c]
	str lr, [r6, #0x50]
	cmp lr, #0
	beq _02159624
	ldr ip, =CutsceneSpriteButtonManager__TouchAreaCallback
	mov r1, r2
	mov r2, r3
	mov r3, r4
	stmia sp, {ip, lr}
	bl TouchField__InitAreaSprite
	b _0215963C
_02159624:
	mov r1, r2
	mov r2, r3
	str r4, [sp]
	mov r3, r4
	str r4, [sp, #4]
	bl TouchField__InitAreaSprite
_0215963C:
	mov r0, r5
	mov r1, r6
	mov r2, #0
	str r5, [r6, #0x38]
	bl TouchField__AddArea
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneSpriteButtonManager__RemoveTouchArea(CutsceneTouchArea *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x38]
	mov r1, r4
	bl TouchField__RemoveArea
	mov r0, #0
	str r0, [r4, #0x38]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneSpriteButtonManager__TouchAreaCallback(TouchAreaResponse *response, CutsceneTouchArea *area, void *userData)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0]
	ldr ip, [r1, #0x14]
	cmp r3, #0x10000
	ldr r0, [r1, #0x3c]
	beq _021596A8
	cmp r3, #0x20000
	beq _021596D0
	cmp r3, #0x1000000
	beq _021596F8
	ldmia sp!, {r3, pc}
_021596A8:
	ldr r2, [r1, #0x40]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	tst ip, #0x800
	ldmneia sp!, {r3, pc}
	ldrh r2, [r1, #0x4a]
	strh r2, [r0, #0x50]
	ldrh r1, [r1, #0x46]
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r3, pc}
_021596D0:
	ldr r2, [r1, #0x40]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	tst ip, #0x800
	ldmneia sp!, {r3, pc}
	ldrh r2, [r1, #0x48]
	strh r2, [r0, #0x50]
	ldrh r1, [r1, #0x44]
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r3, pc}
_021596F8:
	tst ip, #0x20
	ldmeqia sp!, {r3, pc}
	tst ip, #0x800
	ldmneia sp!, {r3, pc}
	ldr r0, [r1, #0x4c]
	mov r1, r2
	bl CutsceneScript__InitScriptThread
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneTextWorker__Init(CutsceneTextWorker *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontWindow__Init
	add r0, r4, #0xb0
	bl FontAnimator__Init
	mov r1, #0
	str r1, [r4, #0x17c]
	mov r0, #0x1000
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
	str r1, [r4, #0x188]
	str r1, [r4, #0x18c]
	str r1, [r4, #0x190]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneTextWorker__Draw(CutsceneTextWorker *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x18c]
	cmp r0, #0
	beq _0215982C
	ldr r0, [r4, #0x190]
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x190]
	bne _0215982C
	ldr r3, [r4, #0x180]
	cmp r3, #0
	bne _0215979C
	add r0, r4, #0xb0
	mov r1, #0
	bl FontAnimator__LoadCharacters
	mov r0, #0
	str r0, [r4, #0x188]
	b _0215982C
_0215979C:
	ldr r0, [r4, #0x188]
	cmp r3, r0
	subls r0, r0, r3
	strls r0, [r4, #0x188]
	bls _0215982C
	cmp r0, #0
	bne _021597CC
	ldr r1, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	add r0, r1, r0
	str r0, [r4, #0x17c]
	b _021597F0
_021597CC:
	ldr r2, [r4, #0x184]
	sub r1, r3, r0
	mul r0, r2, r3
	bl _u32_div_f
	ldr r2, [r4, #0x17c]
	mov r1, #0
	add r0, r2, r0
	str r0, [r4, #0x17c]
	str r1, [r4, #0x188]
_021597F0:
	ldr r5, [r4, #0x17c]
	ldr r6, [r4, #0x180]
	cmp r6, r5
	bhi _0215982C
	mov r0, r5
	mov r1, r6
	bl _u32_div_f
	str r1, [r4, #0x17c]
	mov r0, r5
	mov r1, r6
	bl _u32_div_f
	mov r1, r0, lsl #0x10
	add r0, r4, #0xb0
	mov r1, r1, lsr #0x10
	bl FontAnimator__LoadCharacters
_0215982C:
	ldr r0, [r4, #0x178]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add r0, r4, #0xb0
	bl FontAnimator__Draw
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneTextWorker__Release(CutsceneTextWorker *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontAnimator__Release
	mov r0, r4
	bl FontWindow__Clear
	mov r0, r4
	bl FontWindow__Release
	add r6, r4, #0x174
	add r5, r4, #0x17c
	cmp r6, r5
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r4, #0
_02159880:
	ldr r0, [r6, #0]
	cmp r0, #0
	beq _02159894
	bl _FreeHEAP_USER
	str r4, [r6]
_02159894:
	add r6, r6, #4
	cmp r6, r5
	bne _02159880
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

CutsceneScriptResult CutsceneTextWorker__Process(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *work)
{
    static const CutsceneScriptTextCommand CutsceneScript__TextCommands[] = {
        CutsceneScript__TextCommand__LoadFontFile,
        CutsceneScript__TextCommand__Func_2159B14,
        CutsceneScript__TextCommand__LoadMPCFile,
        CutsceneScript__TextCommand__SetMsgSeq,
        CutsceneScript__TextCommand__Func_2159C68,
        CutsceneScript__TextCommand__Func_2159C88,
        CutsceneScript__TextCommand__Func_2159CA8,
        CutsceneScript__TextCommand__Func_2159CC8,
        CutsceneScript__TextCommand__Func_2159CD8,
        CutsceneScript__TextCommand__LoadCharacters,
        CutsceneScript__TextCommand__LoadCharactersConditional,
        CutsceneScript__TextCommand__IsEndOfLine,
        CutsceneScript__TextCommand__AdvanceDialog,
        CutsceneScript__TextCommand__IsLastDialog,
        CutsceneScript__TextCommand__Draw,
    };

    s32 id = CutsceneScript__GetFunctionParamRegister(thread, 0);

    return CutsceneScript__TextCommands[id](text, thread, work);
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__LoadFontFile(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r9, r1
	mov r10, r0
	mov r0, r9
	mov r1, #1
	mov r6, r2
	bl CutsceneScript__GetFunctionParamRegister
	mov r4, r0
	mov r0, r9
	mov r1, #2
	bl CutsceneScript__GetFunctionParamRegister
	and r5, r0, #0xff
	mov r0, r9
	mov r1, #3
	bl CutsceneScript__GetFunctionParamRegister
	mov r11, r0
	mov r0, r9
	mov r1, #4
	bl CutsceneScript__GetFunctionParamRegister
	str r0, [sp, #0x28]
	mov r1, r6
	mov r0, r9
	mov r2, #5
	bl CutsceneScript__GetFunctionParamString
	str r0, [sp, #0x24]
	mov r0, r9
	mov r1, #6
	bl CutsceneScript__GetFunctionParamRegister
	mov r8, r0
	mov r0, r9
	mov r1, #7
	bl CutsceneScript__GetFunctionParamRegister
	mov r6, r0
	mov r0, r9
	mov r1, #8
	bl CutsceneScript__GetFunctionParamRegister
	mov r7, r0
	mov r0, r9
	mov r1, #9
	bl CutsceneScript__GetFunctionParamRegister
	str r0, [sp, #0x20]
	mov r0, r9
	mov r1, #0xa
	bl CutsceneScript__GetFunctionParamRegister
	str r0, [sp, #0x1c]
	mov r0, r9
	mov r1, #0xb
	bl CutsceneScript__GetFunctionParamRegister
	mov r2, #0
	and r9, r0, #0xff
	ldr r1, [sp, #0x28]
	str r11, [sp]
	str r1, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, r2
	bl CutsceneUnknown__Func_2158A6C
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

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Func_2159B14(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x18c]
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x18c]
	add r0, r4, #0xb0
	bl FontAnimator__Release
	mov r0, r4
	bl FontWindow__Clear
	mov r0, r4
	bl FontWindow__Release
	add r6, r4, #0x174
	add r5, r4, #0x17c
	cmp r6, r5
	beq _02159B78
	mov r4, #0
_02159B58:
	ldr r0, [r6, #0]
	cmp r0, #0
	beq _02159B6C
	bl _FreeHEAP_USER
	str r4, [r6]
_02159B6C:
	add r6, r6, #4
	cmp r6, r5
	bne _02159B58
_02159B78:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__LoadMPCFile(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r2
	mov r5, r1
	mov r7, r0
	mov r0, r5
	mov r1, r6
	mov r2, #1
	bl CutsceneScript__GetFunctionParamString
	mov r4, r0
	mov r0, r5
	mov r1, #2
	bl CutsceneScript__GetFunctionParamRegister
	mov r5, r0
	ldr r0, [r7, #0x178]
	cmp r0, #0
	beq _02159BC4
	bl _FreeHEAP_USER
_02159BC4:
	add r0, r6, #0x30
	add r0, r0, #0x1000
	bl CutsceneFileSystemManager__Func_21569E4
	cmp r0, #0
	movne r3, #1
	moveq r3, #0
	cmp r5, #0
	mvnlt r5, #0
	mov r2, #0
	mov r0, r4
	mov r1, r5
	str r2, [sp]
	bl ArchiveFile__Load
	str r0, [r7, #0x178]
	mov r1, r0
	add r0, r7, #0xb0
	bl FontAnimator__LoadMPCFile
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__SetMsgSeq(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, #1
	bl CutsceneScript__GetFunctionParamRegister
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r4, #0xb0
	bl FontAnimator__SetMsgSequence
	ldrb r2, [r4, #0x194]
	add r0, r4, #0xb0
	mov r1, #0
	bl FontAnimator__InitStartPos
	ldrb r1, [r4, #0x195]
	add r0, r4, #0xb0
	bl FontAnimator__AdvanceLine
	mov r0, #0
	str r0, [r4, #0x188]
	str r0, [r4, #0x18c]
	str r0, [r4, #0x190]
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Func_2159C68(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, #1
	bl CutsceneScript__GetFunctionParamRegister
	str r0, [r4, #0x180]
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Func_2159C88(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, #1
	bl CutsceneScript__GetFunctionParamRegister
	str r0, [r4, #0x184]
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Func_2159CA8(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, #1
	bl CutsceneScript__GetFunctionParamRegister
	str r0, [r4, #0x188]
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Func_2159CC8(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #1
	str r1, [r0, #0x18c]
	mov r0, r1
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Func_2159CD8(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #0
	str r1, [r0, #0x18c]
	mov r0, #1
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__LoadCharacters(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	mov r1, #0
	bl FontAnimator__LoadCharacters
	mov r0, #1
	str r0, [r4, #0x190]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__LoadCharactersConditional(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, #1
	bl CutsceneScript__GetFunctionParamRegister
	mov r0, r0, lsl #0x10
	movs r1, r0, lsr #0x10
	beq _02159D38
	add r0, r4, #0xb0
	bl FontAnimator__LoadCharacters
	mov r0, #1
	str r0, [r4, #0x190]
_02159D38:
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__IsEndOfLine(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	add r0, r0, #0xb0
	mov r4, r1
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	movne r2, #1
	moveq r2, #0
	mov r0, r4
	mov r1, #1
	bl AYKCommand__SetRegister
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__AdvanceDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r0, r0, #0xb0
	bl FontAnimator__AdvanceDialog
	mov r0, #1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__IsLastDialog(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	add r0, r0, #0xb0
	mov r4, r1
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	movne r2, #1
	moveq r2, #0
	mov r0, r4
	mov r1, #1
	bl AYKCommand__SetRegister
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CutsceneScriptResult CutsceneScript__TextCommand__Draw(CutsceneTextWorker *text, ScriptThread *thread, CutsceneScript *cutscene)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontAnimator__ClearPixels
	add r0, r4, #0xb0
	bl FontAnimator__Draw
	mov r0, #1
	str r0, [r4, #0x190]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void CutsceneAssetSystem__Create(void)
{
    cutsceneAssetSystemTask =
        TaskCreate(CutsceneAssetSystem__Main, CutsceneAssetSystem__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 1, TASK_GROUP(0), CutsceneAssetSystem);

    CutsceneAssetSystem__Func_2159E28(cutsceneAssetSystemTask);
}

void CutsceneAssetSystem__Func_2159E28(Task *task)
{
    CutsceneAssetSystem *work = TaskGetWork(task, CutsceneAssetSystem);

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
    while (gfxControlList != &VRAMSystem__GFXControl[2])
    {
        for (e = 0; e < 2; e++)
        {
            RenderCoreGFXControl *gfxControl = *gfxControlList;
            RenderAffineControl *affineControl;

            if (e == GRAPHICS_ENGINE_A)
                affineControl = &gfxControl->affineA;
            else
                affineControl = &gfxControl->affineB;

            MTX_Identity22(&affineControl->matrix);
            affineControl->centerX = affineControl->centerY = affineControl->x = affineControl->y = 0;
        }

        gfxControlList++;
    }

    s32 id       = CutsceneAssetSystem__GetCutsceneID();
    work->script = LoadCutsceneScript(id);
    CutsceneScript__Create(work, 16);
    CutsceneScript__InitFileSystemManager(work, 32);
    CutsceneScript__InitSpriteButtonManager(work, 16);
    CutsceneScript__InitBackgroundManager(work);
    CutsceneScript__InitModelManager(work, 32);
    CutsceneScript__InitTextManager(work);
    CutsceneScript__InitAudioManager(work, 8);
    CutsceneScript__LoadScript(work, work->script);
    CutsceneScript__StartScript(work, GetScriptStartParam(id), CutsceneAssetSystem__OnCutsceneFinish);
    CutsceneAssetSystem__LoadCanSkipFlag(CutsceneAssetSystem__GetCutsceneScript(work));
}

void CutsceneAssetSystem__Destructor(Task *task)
{
    CutsceneAssetSystem *work = TaskGetWork(task, CutsceneAssetSystem);
    HeapFree(HEAP_USER, work->script);

    cutsceneAssetSystemTask = NULL;
}

void CutsceneAssetSystem__OnCutsceneFinish(CutsceneScript *work)
{
    SetTaskMainEvent(cutsceneAssetSystemTask, CutsceneAssetSystem__NextSysEvent);

    renderCoreGFXControlA.windowManager.visible = GX_WNDMASK_NONE;
    renderCoreGFXControlB.windowManager.visible = GX_WNDMASK_NONE;

    renderCoreGFXControlA.blendManager.blendAlpha.value = 0x00;
    renderCoreGFXControlB.blendManager.blendAlpha.value = 0x00;

    renderCoreGFXControlA.blendManager.blendControl.value = 0x00;
    renderCoreGFXControlB.blendManager.blendControl.value = 0x00;

    renderCoreGFXControlA.blendManager.coefficient.value = RENDERCORE_BRIGHTNESS_DEFAULT;
    renderCoreGFXControlB.blendManager.coefficient.value = RENDERCORE_BRIGHTNESS_DEFAULT;

    CutsceneAssetSystem__StoreCanSkipFlag(work);
}

s32 CutsceneAssetSystem__GetCutsceneID(void)
{
    return gameState.cutscene.cutsceneID;
}

s32 CutsceneAssetSystem__GetNextSysEvent(void)
{
    return gameState.cutscene.nextSysEvent;
}

void CutsceneAssetSystem__LoadCanSkipFlag(CutsceneScript *work)
{
    s32 *data = CutsceneScript__GetFunctionParamConstant(work, NULL, GetScriptCanSkipFlagIn());

    *data = gameState.cutscene.canSkip;
}

void CutsceneAssetSystem__StoreCanSkipFlag(CutsceneScript *work)
{
    s32 *data = CutsceneScript__GetFunctionParamConstant(work, NULL, GetScriptCanSkipFlagOut());

    gameState.cutscene.canSkip = *data;
}

void CutsceneAssetSystem__Main(void)
{
    CutsceneAssetSystem *work = TaskGetWork(cutsceneAssetSystemTask, CutsceneAssetSystem);
    UNUSED(work);
}

void CutsceneAssetSystem__NextSysEvent(void)
{
    CutsceneAssetSystem *work = TaskGetWork(cutsceneAssetSystemTask, CutsceneAssetSystem);
    CutsceneAssetSystem__Destroy(work);
    DestroyCurrentTask();

    RequestNewSysEventChange(CutsceneAssetSystem__GetNextSysEvent());
    NextSysEvent();
}

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A124(void *background, void *vramPixels, s32 displayWidth, s32 displayHeight)
{
#ifdef NON_MATCHING

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
	bl CutsceneAssetSystem__Func_215AE54
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215A248
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215A374
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215A788
	mov r1, r6
	mov r2, r5
	mov r3, r4
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215A9A8
	ldr r0, [sp, #4]
	bl _FreeHEAP_USER
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A248(void)
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
	bl CutsceneAssetSystem__Func_215A2F0
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
	bl CutsceneAssetSystem__Func_215A2F0
	ldr r0, [r6, #0xc]
	ldr r1, [r6, #0x18]
	add r0, r0, r5, lsl #1
	add r1, r1, r5, lsl #1
	bl CutsceneAssetSystem__Func_215A2F0
	add r0, r5, #0x10
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0215A2B0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A2F0(void){
#ifdef NON_MATCHING

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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A374(void)
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
	bl CutsceneAssetSystem__Func_215A490
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
	bl CutsceneAssetSystem__Func_215A490
	mov r2, r5, lsl #0x10
	ldr r0, [r10, #0x18]
	ldr r1, [r10, #0xc]
	mov r2, r2, lsr #0x10
	mov r3, r6
	bl CutsceneAssetSystem__Func_215A490
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A490(void)
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
	bl CutsceneAssetSystem__Func_215A640
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
	bl CutsceneAssetSystem__Func_215A640
	add r1, r4, #0x10
	add r0, r9, r1, lsl #1
	add r1, r8, r1, lsl #1
	bl CutsceneAssetSystem__Func_215A640
	add r1, r4, #0x20
	add r0, r9, r1, lsl #1
	add r1, r8, r1, lsl #1
	bl CutsceneAssetSystem__Func_215A640
	add r1, r4, #0x30
	add r0, r9, r1, lsl #1
	add r1, r8, r1, lsl #1
	bl CutsceneAssetSystem__Func_215A640
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A640(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	mov r4, r1
	bl CutsceneAssetSystem__Func_215A738
	add r0, r5, #8
	add r1, r4, #8
	bl CutsceneAssetSystem__Func_215A738
	add r0, r5, #0x10
	add r1, r4, #0x10
	bl CutsceneAssetSystem__Func_215A738
	add r0, r5, #0x18
	add r1, r4, #0x18
	bl CutsceneAssetSystem__Func_215A738
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
	bl CutsceneAssetSystem__Func_215A738
	add r0, r4, #8
	mov r1, r0
	bl CutsceneAssetSystem__Func_215A738
	add r0, r4, #0x10
	mov r1, r0
	bl CutsceneAssetSystem__Func_215A738
	add r0, r4, #0x18
	mov r1, r0
	bl CutsceneAssetSystem__Func_215A738
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A738(void)
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A788(void)
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215A9A8(void)
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
	bl CutsceneAssetSystem__Func_215AB20
	ldr r2, [r6, #0]
	ldrh r3, [r6, #0x20]
	ldrh r1, [r6, #0x22]
	ldrb r2, [r2, #5]
	ldr r0, [sp, #4]
	mul r1, r3, r1
	bl CutsceneAssetSystem__Func_215AB20
	ldr r2, [r6, #0]
	ldrh r3, [r6, #0x20]
	ldrh r1, [r6, #0x22]
	ldrb r2, [r2, #5]
	mov r0, r11
	mul r1, r3, r1
	bl CutsceneAssetSystem__Func_215AB20
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
	bl CutsceneAssetSystem__Func_215ADA0
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215AB20(void)
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215ADA0(void)
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215AE54(void)
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
	bl CutsceneAssetSystem__Func_215AF60
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
	bl CutsceneAssetSystem__Func_215B094
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
	bl CutsceneAssetSystem__Func_215B094
	mov r5, r0
	ldr r0, [sp, #4]
	ldr r1, [sp, #8]
	bl CutsceneAssetSystem__Func_215B108
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215AF60(void)
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
	bl CutsceneAssetSystem__Func_215B158
	add r0, sp, #0
	mov r6, #0
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	bne _0215AFB0
	add r5, sp, #0
_0215AF9C:
	mov r0, r5
	add r6, r6, #1
	bl CutsceneAssetSystem__Func_215B180
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
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	moveq r0, #3
	streq r0, [r4]
	movne r0, #4
	strne r0, [r4]
	b _0215B084
_0215B018:
	add r0, sp, #0
	mov r5, #0
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	orrne r5, r5, #2
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	orrne r5, r5, #1
	add r0, r5, #5
	str r0, [r4]
	b _0215B084
_0215B048:
	add r0, sp, #0
	mov r5, #0
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	orrne r5, r5, #4
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	orrne r5, r5, #2
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215B180
	cmp r0, #0
	orrne r5, r5, #1
	add r0, r5, #9
	str r0, [r4]
_0215B084:
	add r0, sp, #0
	bl CutsceneAssetSystem__Func_215B170
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneAssetSystem__Func_215B094(void)
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
	bl CutsceneAssetSystem__Func_215B158
	mov r6, #0
	str r6, [r7]
	cmp r8, #0
	mov r5, #1
	bls _0215B0FC
	add r4, sp, #0
_0215B0D4:
	mov r0, r4
	bl CutsceneAssetSystem__Func_215B180
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

s16 CutsceneAssetSystem__Func_215B108(s32 value, s32 id)
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

NONMATCH_FUNC void CutsceneAssetSystem__Func_215B158(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	str r1, [r0]
	mov r1, r2, lsr #5
	str r1, [r0, #4]
	and r1, r2, #0x1f
	str r1, [r0, #8]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneAssetSystem__Func_215B170(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #4]
	ldr r0, [r0, #8]
	add r0, r0, r1, lsl #5
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void CutsceneAssetSystem__Func_215B180(void)
{
#ifdef NON_MATCHING

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
