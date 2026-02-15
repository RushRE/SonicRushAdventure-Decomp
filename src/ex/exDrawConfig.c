
#include <ex/system/exDrawReq.h>
#include <ex/system/exDrawFade.h>
#include <game/graphics/drawState.h>
#include <game/math/unknown2066510.h>
#include <ex/system/exSystem.h>
#include <ex/boss/exBoss.h>
#include <ex/system/exUtils.h>

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

    work->nextCamera.projection.fov    = FLOAT_DEG_TO_IDX(0.0);
    work->currentCamera.projection.fov = FLOAT_DEG_TO_IDX(0.0);

    work->nextCamera.projection.nearPlane    = FLOAT_TO_FX32(0.0);
    work->currentCamera.projection.nearPlane = FLOAT_TO_FX32(0.0);

    work->nextCamera.projection.farPlane    = FLOAT_TO_FX32(0.0);
    work->currentCamera.projection.farPlane = FLOAT_TO_FX32(0.0);

    work->nextCamera.projection.aspectRatio    = FLOAT_DEG_TO_IDX(0.0);
    work->currentCamera.projection.aspectRatio = FLOAT_DEG_TO_IDX(0.0);

    work->nextCamera.projection.scaleW    = FLOAT_DEG_TO_IDX(0.0);
    work->currentCamera.projection.scaleW = FLOAT_DEG_TO_IDX(0.0);

    work->nextCamera.projection.position.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.projection.position.y = FLOAT_TO_FX32(0.0);
    work->nextCamera.projection.position.z = FLOAT_TO_FX32(0.0);

    work->currentCamera.projection.position.x = work->nextCamera.projection.position.x;
    work->currentCamera.projection.position.y = work->nextCamera.projection.position.y;
    work->currentCamera.projection.position.z = work->nextCamera.projection.position.z;

    work->nextCamera.view.camPos.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camPos.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camPos.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.view.camPos.x = work->nextCamera.view.camPos.x;
    work->currentCamera.view.camPos.y = work->nextCamera.view.camPos.y;
    work->currentCamera.view.camPos.z = work->nextCamera.view.camPos.z;

    work->nextCamera.view.camTarget.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camTarget.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camTarget.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.view.camTarget.x = work->nextCamera.view.camTarget.x;
    work->currentCamera.view.camTarget.y = work->nextCamera.view.camTarget.y;
    work->currentCamera.view.camTarget.z = work->nextCamera.view.camTarget.z;

    work->nextCamera.view.camUp.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camUp.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camUp.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.view.camUp.x = work->nextCamera.view.camUp.x;
    work->currentCamera.view.camUp.y = work->nextCamera.view.camUp.y;
    work->currentCamera.view.camUp.z = work->nextCamera.view.camUp.z;

    work->nextCamera.view.position.x    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.position.y    = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.position.z    = FLOAT_TO_FX32(0.0);
    work->currentCamera.view.position.x = work->nextCamera.view.position.x;
    work->currentCamera.view.position.y = work->nextCamera.view.position.y;
    work->currentCamera.view.position.z = work->nextCamera.view.position.z;
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
    if (work->nextCamera.projection.fov < FLOAT_DEG_TO_IDX(1.0))
        work->nextCamera.projection.fov = FLOAT_DEG_TO_IDX(1.0);

    if (work->nextCamera.projection.fov > FLOAT_DEG_TO_IDX(89.0))
        work->nextCamera.projection.fov = FLOAT_DEG_TO_IDX(89.0);

    work->currentCamera.projection.fov     = work->nextCamera.projection.fov;
    work->currentCamera.projection.nearPlane    = work->nextCamera.projection.nearPlane;
    work->currentCamera.projection.farPlane     = work->nextCamera.projection.farPlane;
    work->currentCamera.projection.aspectRatio = work->nextCamera.projection.aspectRatio;
    work->currentCamera.projection.scaleW  = work->nextCamera.projection.scaleW;

    work->currentCamera.projection.position.x = work->nextCamera.projection.position.x;
    work->currentCamera.projection.position.y = work->nextCamera.projection.position.y;
    work->currentCamera.projection.position.z = work->nextCamera.projection.position.z;

    work->currentCamera.view.camPos.x = work->nextCamera.view.camPos.x;
    work->currentCamera.view.camPos.y = work->nextCamera.view.camPos.y;
    work->currentCamera.view.camPos.z = work->nextCamera.view.camPos.z;

    work->currentCamera.view.camTarget.x = work->nextCamera.view.camTarget.x;
    work->currentCamera.view.camTarget.y = work->nextCamera.view.camTarget.y;
    work->currentCamera.view.camTarget.z = work->nextCamera.view.camTarget.z;

    work->currentCamera.view.camUp.x = work->nextCamera.view.camUp.x;
    work->currentCamera.view.camUp.y = work->nextCamera.view.camUp.y;
    work->currentCamera.view.camUp.z = work->nextCamera.view.camUp.z;

    work->currentCamera.view.position.x = work->nextCamera.view.position.x;
    work->currentCamera.view.position.y = work->nextCamera.view.position.y;
    work->currentCamera.view.position.z = work->nextCamera.view.position.z;

    SwapBuffer3D_ApplyCameraState(&work->currentCamera);
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
            SwapBuffer3D_SetLight(GX_LIGHTID_0, &config->curLight);

            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_1);
            SwapBuffer3D_SetLight(GX_LIGHTID_1, &config->curLight);

            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_2);
            SwapBuffer3D_SetLight(GX_LIGHTID_2, &config->curLight);

            GetDrawStateLight(GetExSystemDrawState(), &config->curLight, GX_LIGHTID_3);
            SwapBuffer3D_SetLight(GX_LIGHTID_3, &config->curLight);
            return;

        default:
            config->curLight.color = config->nextLight.color;
            break;
    }

    config->curLight.dir.x = config->nextLight.dir.x;
    config->curLight.dir.y = config->nextLight.dir.y;
    config->curLight.dir.z = config->nextLight.dir.z;

    SwapBuffer3D_SetLight(GX_LIGHTID_0, &config->curLight);
    SwapBuffer3D_SetLight(GX_LIGHTID_1, &config->curLight);
    SwapBuffer3D_SetLight(GX_LIGHTID_2, &config->curLight);
    SwapBuffer3D_SetLight(GX_LIGHTID_3, &config->curLight);
}

void LoadExDrawCameraConfig_1(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_1;

    work->nextCamera.projection.fov     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.projection.nearPlane    = FLOAT_TO_FX32(1.0);
    work->nextCamera.projection.farPlane     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.projection.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.projection.scaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.view.camPos.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camPos.y = -FLOAT_TO_FX32(38.5);
    work->nextCamera.view.camPos.z = FLOAT_TO_FX32(308.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.view.camTarget.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(0.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.view.camTarget.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(0.0);
    }

    work->nextCamera.view.camUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.view.camUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawCameraConfig_2(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_2;

    work->nextCamera.projection.fov     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.projection.nearPlane    = FLOAT_TO_FX32(1.0);
    work->nextCamera.projection.farPlane     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.projection.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.projection.scaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.view.camPos.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camPos.y = -FLOAT_TO_FX32(38.5);
    work->nextCamera.view.camPos.z = FLOAT_TO_FX32(308.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.view.camTarget.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(0.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.view.camTarget.x = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(0.0);
    }

    work->nextCamera.view.camUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.view.camUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawCameraConfig_3(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_3;

    work->nextCamera.projection.fov     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.projection.nearPlane    = FLOAT_TO_FX32(1.0);
    work->nextCamera.projection.farPlane     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.projection.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.projection.scaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.view.camPos.x = FLOAT_TO_FX32(500.0);
    work->nextCamera.view.camPos.y = -FLOAT_TO_FX32(40.0);
    work->nextCamera.view.camPos.z = FLOAT_TO_FX32(290.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.view.camTarget.x = FLOAT_TO_FX32(6.4);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(64.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.view.camTarget.x = FLOAT_TO_FX32(6.4);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(64.0);
    }

    work->nextCamera.view.camUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.view.camUp.z = FLOAT_TO_FX32(0.0);
}

void LoadExDrawCameraConfig_4(ExDrawCameraConfig *work)
{
    work->type = EXDRAW_CAMERACONFIG_4;

    work->nextCamera.projection.fov     = FLOAT_DEG_TO_IDX(7.0);
    work->nextCamera.projection.nearPlane    = FLOAT_TO_FX32(1.0);
    work->nextCamera.projection.farPlane     = FLOAT_TO_FX32(2048.0);
    work->nextCamera.projection.aspectRatio = FLOAT_DEG_TO_IDX(30.0);
    work->nextCamera.projection.scaleW  = FLOAT_TO_FX32(1.0);

    work->nextCamera.view.camPos.x = -FLOAT_TO_FX32(500.0);
    work->nextCamera.view.camPos.y = -FLOAT_TO_FX32(40.0);
    work->nextCamera.view.camPos.z = FLOAT_TO_FX32(290.0);

    if (work->useEngineB == GRAPHICS_ENGINE_A)
    {
        work->nextCamera.view.camTarget.x = -FLOAT_TO_FX32(6.4);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(128.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(64.0);
    }
    else if (work->useEngineB == GRAPHICS_ENGINE_B)
    {
        work->nextCamera.view.camTarget.x = -FLOAT_TO_FX32(6.4);
        work->nextCamera.view.camTarget.y = FLOAT_TO_FX32(0.0);
        work->nextCamera.view.camTarget.z = FLOAT_TO_FX32(64.0);
    }

    work->nextCamera.view.camUp.x = FLOAT_TO_FX32(0.0);
    work->nextCamera.view.camUp.y = FLOAT_TO_FX32(1.0);
    work->nextCamera.view.camUp.z = FLOAT_TO_FX32(0.0);
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