
#include <ex/system/exDrawReq.h>
#include <ex/system/exDrawFade.h>
#include <game/graphics/drawState.h>
#include <game/math/unknown2066510.h>
#include <ex/system/exSystem.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/player/exPlayerHelpers.h>

// --------------------
// VARIABLES
// --------------------

static ExDrawLightConfig lightConfig;

static ExDrawCameraConfig currentCameraConfigA;
static ExDrawCameraConfig currentCameraConfigB;

// --------------
// FUNCTION DECLS
// --------------

void ApplyExDrawCameraConfig(ExDrawCameraConfig *work);
void SetExDrawLightConfig(ExDrawLightConfig *config);

static void InitExDrawCameraConfig(ExDrawCameraConfig *work);
static void InitExDrawLightConfig(ExDrawLightConfig *work);
static void LoadExDrawCameraConfig_1(ExDrawCameraConfig *work);
static void LoadExDrawCameraConfig_2(ExDrawCameraConfig *work);
static void LoadExDrawCameraConfig_3(ExDrawCameraConfig *work);
static void LoadExDrawCameraConfig_4(ExDrawCameraConfig *work);

// --------------------
// FUNCTIONS
// --------------------

void InitExDrawCameraConfig(ExDrawCameraConfig *work)
{
    MI_CpuClear16(work, sizeof(*work));

    work->nextCamera.config.projFOV    = FLOAT_DEG_TO_IDX(0.0);
    work->currentCamera.config.projFOV = FLOAT_DEG_TO_IDX(0.0);

    work->nextCamera.config.projNear    = FLOAT_TO_FX32(0.0);
    work->currentCamera.config.projNear = FLOAT_TO_FX32(0.0);

    work->nextCamera.config.projFar    = FLOAT_TO_FX32(0.0);
    work->currentCamera.config.projFar = FLOAT_TO_FX32(0.0);

    work->nextCamera.config.aspectRatio    = FLOAT_DEG_TO_IDX(0.0);
    work->currentCamera.config.aspectRatio = FLOAT_DEG_TO_IDX(0.0);

    work->nextCamera.config.projScaleW    = FLOAT_DEG_TO_IDX(0.0);
    work->currentCamera.config.projScaleW = FLOAT_DEG_TO_IDX(0.0);

    work->nextCamera.config.matProjPosition.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.config.matProjPosition.y = FLOAT_TO_FX32(0.0);
    work->nextCamera.config.matProjPosition.z = FLOAT_TO_FX32(0.0);

    work->currentCamera.config.matProjPosition.x = work->nextCamera.config.matProjPosition.x;
    work->currentCamera.config.matProjPosition.y = work->nextCamera.config.matProjPosition.y;
    work->currentCamera.config.matProjPosition.z = work->nextCamera.config.matProjPosition.z;

    work->nextCamera.lookAtTo.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtTo.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtTo.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.lookAtTo.x = work->nextCamera.lookAtTo.x;
    work->currentCamera.lookAtTo.y = work->nextCamera.lookAtTo.y;
    work->currentCamera.lookAtTo.z = work->nextCamera.lookAtTo.z;

    work->nextCamera.lookAtFrom.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtFrom.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtFrom.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.lookAtFrom.x = work->nextCamera.lookAtFrom.x;
    work->currentCamera.lookAtFrom.y = work->nextCamera.lookAtFrom.y;
    work->currentCamera.lookAtFrom.z = work->nextCamera.lookAtFrom.z;

    work->nextCamera.lookAtUp.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtUp.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtUp.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.lookAtUp.x = work->nextCamera.lookAtUp.x;
    work->currentCamera.lookAtUp.y = work->nextCamera.lookAtUp.y;
    work->currentCamera.lookAtUp.z = work->nextCamera.lookAtUp.z;

    work->nextCamera.position.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.position.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.position.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.position.x = work->nextCamera.position.x;
    work->currentCamera.position.y = work->nextCamera.position.y;
    work->currentCamera.position.z = work->nextCamera.position.z;
}

void InitExDrawLightConfig(ExDrawLightConfig *work)
{
    MI_CpuClear16(work, sizeof(*work));

    work->nextLight.dir.x = FLOAT_TO_FX32(0.0);
    work->nextLight.dir.y = FLOAT_TO_FX32(0.0);
    work->nextLight.dir.z = FLOAT_TO_FX32(0.0);

    work->curLight.dir.x = work->nextLight.dir.x;
    work->curLight.dir.y = work->nextLight.dir.y;
    work->curLight.dir.z = work->nextLight.dir.z;

    work->nextLight.color = GX_RGB_888(0xF8, 0xF8, 0xF8);
    work->curLight.color  = GX_RGB_888(0xF8, 0xF8, 0xF8);
}

void ApplyExDrawCameraConfig(ExDrawCameraConfig *work)
{
    if (work->nextCamera.config.projFOV < FLOAT_DEG_TO_IDX(1.0))
        work->nextCamera.config.projFOV = FLOAT_DEG_TO_IDX(1.0);

    if (work->nextCamera.config.projFOV > FLOAT_DEG_TO_IDX(89.0))
        work->nextCamera.config.projFOV = FLOAT_DEG_TO_IDX(89.0);

    work->currentCamera.config.projFOV     = work->nextCamera.config.projFOV;
    work->currentCamera.config.projNear    = work->nextCamera.config.projNear;
    work->currentCamera.config.projFar     = work->nextCamera.config.projFar;
    work->currentCamera.config.aspectRatio = work->nextCamera.config.aspectRatio;
    work->currentCamera.config.projScaleW  = work->nextCamera.config.projScaleW;

    work->currentCamera.config.matProjPosition.x = work->nextCamera.config.matProjPosition.x;
    work->currentCamera.config.matProjPosition.y = work->nextCamera.config.matProjPosition.y;
    work->currentCamera.config.matProjPosition.z = work->nextCamera.config.matProjPosition.z;

    work->currentCamera.lookAtTo.x = work->nextCamera.lookAtTo.x;
    work->currentCamera.lookAtTo.y = work->nextCamera.lookAtTo.y;
    work->currentCamera.lookAtTo.z = work->nextCamera.lookAtTo.z;

    work->currentCamera.lookAtFrom.x = work->nextCamera.lookAtFrom.x;
    work->currentCamera.lookAtFrom.y = work->nextCamera.lookAtFrom.y;
    work->currentCamera.lookAtFrom.z = work->nextCamera.lookAtFrom.z;

    work->currentCamera.lookAtUp.x = work->nextCamera.lookAtUp.x;
    work->currentCamera.lookAtUp.y = work->nextCamera.lookAtUp.y;
    work->currentCamera.lookAtUp.z = work->nextCamera.lookAtUp.z;

    work->currentCamera.position.x = work->nextCamera.position.x;
    work->currentCamera.position.y = work->nextCamera.position.y;
    work->currentCamera.position.z = work->nextCamera.position.z;

    Camera3D__LoadState(&work->currentCamera);
}

void SetExDrawLightConfig(ExDrawLightConfig *config)
{
    switch (config->type)
    {
        case EXDRAWREQ_LIGHT_BLUE:
            config->curLight.color = GX_RGB_888(0x00, 0x00, 0xF8);
            break;

        case EXDRAWREQ_LIGHT_GREEN:
            config->curLight.color = GX_RGB_888(0x00, 0xF8, 0x00);
            break;

        case EXDRAWREQ_LIGHT_CYAN:
            config->curLight.color = GX_RGB_888(0x00, 0xF8, 0xF8);
            break;

        case EXDRAWREQ_LIGHT_RED:
            config->curLight.color = GX_RGB_888(0xF8, 0x00, 0x00);
            break;

        case EXDRAWREQ_LIGHT_MAGENTA:
            config->curLight.color = GX_RGB_888(0xF8, 0x00, 0xF8);
            break;

        case EXDRAWREQ_LIGHT_YELLOW:
            config->curLight.color = GX_RGB_888(0xF8, 0xF8, 0x00);
            break;

        case EXDRAWREQ_LIGHT_DEFAULT:
            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_0);
            Camera3D__SetLight(GX_LIGHTID_0, &config->curLight);

            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_1);
            Camera3D__SetLight(GX_LIGHTID_1, &config->curLight);

            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_2);
            Camera3D__SetLight(GX_LIGHTID_2, &config->curLight);

            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_3);
            Camera3D__SetLight(GX_LIGHTID_3, &config->curLight);
            return;

        default:
            config->curLight.color = config->nextLight.color;
            break;
    }

    config->curLight.dir.x = config->nextLight.dir.x;
    config->curLight.dir.y = config->nextLight.dir.y;
    config->curLight.dir.z = config->nextLight.dir.z;

    Camera3D__SetLight(GX_LIGHTID_0, &config->curLight);
    Camera3D__SetLight(GX_LIGHTID_1, &config->curLight);
    Camera3D__SetLight(GX_LIGHTID_2, &config->curLight);
    Camera3D__SetLight(GX_LIGHTID_3, &config->curLight);
}

void LoadExDrawCameraConfig_1(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_1;

    work->nextCamera.config.projFOV     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.config.projNear    = FLOAT_TO_FX32(1.0);
    work->nextCamera.config.projFar     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.config.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.config.projScaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.lookAtTo.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtTo.y = -FLOAT_TO_FX32(38.5);
    work->nextCamera.lookAtTo.z = FLOAT_TO_FX32(308.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.lookAtFrom.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(0.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.lookAtFrom.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(0.0);
    }

    work->nextCamera.lookAtUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.lookAtUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawCameraConfig_2(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_2;

    work->nextCamera.config.projFOV     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.config.projNear    = FLOAT_TO_FX32(1.0);
    work->nextCamera.config.projFar     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.config.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.config.projScaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.lookAtTo.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtTo.y = -FLOAT_TO_FX32(38.5);
    work->nextCamera.lookAtTo.z = FLOAT_TO_FX32(308.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.lookAtFrom.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(0.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.lookAtFrom.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(0.0);
    }

    work->nextCamera.lookAtUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.lookAtUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawCameraConfig_3(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_3;

    work->nextCamera.config.projFOV     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.config.projNear    = FLOAT_TO_FX32(1.0);
    work->nextCamera.config.projFar     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.config.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.config.projScaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.lookAtTo.x = FLOAT_TO_FX32(500.0);
    work->nextCamera.lookAtTo.y = -FLOAT_TO_FX32(40.0);
    work->nextCamera.lookAtTo.z = FLOAT_TO_FX32(290.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.lookAtFrom.x = FLOAT_TO_FX32(6.4);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(64.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.lookAtFrom.x = FLOAT_TO_FX32(6.4);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(64.0);
    }

    work->nextCamera.lookAtUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.lookAtUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawCameraConfig_4(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_4;

    work->nextCamera.config.projFOV     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.config.projNear    = FLOAT_TO_FX32(1.0);
    work->nextCamera.config.projFar     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.config.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.config.projScaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.lookAtTo.x = -FLOAT_TO_FX32(500.0);
    work->nextCamera.lookAtTo.y = -FLOAT_TO_FX32(40.0);
    work->nextCamera.lookAtTo.z = FLOAT_TO_FX32(290.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.lookAtFrom.x = -FLOAT_TO_FX32(6.4);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(64.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.lookAtFrom.x = -FLOAT_TO_FX32(6.4);
        work->nextCamera.lookAtFrom.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.lookAtFrom.z = FLOAT_TO_FX32(64.0);
    }

    work->nextCamera.lookAtUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.lookAtUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.lookAtUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawConfig(ExDrawReqTaskCameraConfigType currentCameraType, ExDrawReqLightType lightType)
{
    InitExDrawCameraConfig(&currentCameraConfigA);
    currentCameraConfigA.useEngineB = GRAPHICS_ENGINE_A;

    InitExDrawCameraConfig(&currentCameraConfigB);
    currentCameraConfigB.useEngineB = GRAPHICS_ENGINE_B;

    switch (currentCameraType)
    {
        case EXDRAW_CAMERACONFIG_1:
            LoadExDrawCameraConfig_1(&currentCameraConfigA);
            LoadExDrawCameraConfig_1(&currentCameraConfigB);
            break;

        case EXDRAW_CAMERACONFIG_2:
            LoadExDrawCameraConfig_2(&currentCameraConfigA);
            LoadExDrawCameraConfig_2(&currentCameraConfigB);
            break;

        case EXDRAW_CAMERACONFIG_3:
            LoadExDrawCameraConfig_3(&currentCameraConfigA);
            LoadExDrawCameraConfig_3(&currentCameraConfigB);
            break;

        case EXDRAW_CAMERACONFIG_4:
            LoadExDrawCameraConfig_4(&currentCameraConfigA);
            LoadExDrawCameraConfig_4(&currentCameraConfigB);
            break;

        default:
            LoadExDrawCameraConfig_1(&currentCameraConfigA);
            LoadExDrawCameraConfig_1(&currentCameraConfigB);
            break;
    }
    InitExDrawLightConfig(&lightConfig);

    lightConfig.nextLight.dir.x = FLOAT_TO_FX32(0.0);
    lightConfig.nextLight.dir.y = FLOAT_TO_FX32(0.0);
    lightConfig.nextLight.dir.z = -FLOAT_TO_FX32(1.0);

    lightConfig.nextLight.color = GX_RGB_888(0xFF, 0xFF, 0xFF);
}

ExDrawCameraConfig *GetExDrawCameraConfigA(void)
{
    return &currentCameraConfigA;
}

ExDrawCameraConfig *GetExDrawCameraConfigB(void)
{
    return &currentCameraConfigB;
}

ExDrawLightConfig *GetExDrawLightConfig(void)
{
    return &lightConfig;
}