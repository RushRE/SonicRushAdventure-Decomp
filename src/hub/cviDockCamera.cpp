#include <hub/cviDockCamera.hpp>
#include <hub/cviDock.hpp>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/graphics/swapBuffer3D.h>
#include <hub/hubConfig.h>
#include <game/math/unknown2051334.h>

// --------------------
// FUNCTIONS
// --------------------

void CViDockCamera::Init(DockArea dockArea, s32 type)
{
    if (dockArea >= DOCKAREA_NONE)
        dockArea = DOCKAREA_INVALID;

    MI_CpuClear32(this, sizeof(*this));

    this->type         = type;
    this->area         = dockArea;
    this->lerpDuration = 0;
    if (this->area < DOCKAREA_NONE)
    {
        const CViDockBackAreaConfig *config = HubConfig__GetDockBackInfo(this->area);

        this->drawState = ReadFileFromBundle("bb/vi_dock.bb", config->resDrawState, BINARYBUNDLE_AUTO_ALLOC_HEAD);
        CViDockCamera::InitState(&this->initialState, this->area, this->type);
        this->initialState.fov = this->GetFOV();
        CViDockCamera::InitLights(this->lights, this->area, this->drawState, this->type);
        CViDockCamera::InitBounds(&this->bounds, this->area);
        this->Process();
    }
}

void CViDockCamera::Release()
{
    if (this->drawState != NULL)
    {
        HeapFree(HEAP_USER, this->drawState);
        this->drawState = NULL;
    }

    this->area = DOCKAREA_INVALID;
}

void CViDockCamera::SetType(s32 type)
{
    this->type = type;
}

void CViDockCamera::SetCamTarget(const VecFx32 *camTarget)
{
    this->initialState.camTarget.x = camTarget->x;
    this->initialState.camTarget.y = camTarget->y;
    this->initialState.camTarget.z = camTarget->z;
}

void CViDockCamera::MoveToPosition(VecFx32 *camTarget, u16 duration, VecFx32 *camDirection, fx32 scale, BOOL flag)
{
    MI_CpuCopy32(&this->targetState, &this->state2, sizeof(this->state2));

    this->state1.camTarget.x = camTarget->x;
    this->state1.camTarget.y = camTarget->y;
    this->state1.camTarget.z = camTarget->z;

    if (flag)
        this->state1.camTarget.x += MultiplyFX(FLOAT_TO_FX32(3.0), scale);
    this->state1.camTarget.y += MultiplyFX(FLOAT_TO_FX32(10.0), scale);
    this->state1.camPosZ = MultiplyFX(FLOAT_TO_FX32(24.0), scale);
    this->state1.angle1  = FLOAT_DEG_TO_IDX(350.005);

    u16 newAngle = this->state2.angle2;
    if (camDirection->z < 0)
    {
        u16 currentAngle = Math__Func_207B1A4(camDirection->x);
        if (currentAngle < FLOAT_DEG_TO_IDX(90.0))
        {
            u16 targetAngle;
            if (flag)
                targetAngle = FLOAT_DEG_TO_IDX(70.0);
            else
                targetAngle = FLOAT_DEG_TO_IDX(60.0);

            if (currentAngle >= targetAngle)
            {
                newAngle = this->initialState.angle2 + (currentAngle - targetAngle);
            }
        }
        else
        {
            u16 targetAngle;
            if (flag)
                targetAngle = FLOAT_DEG_TO_IDX(130.0);
            else
                targetAngle = FLOAT_DEG_TO_IDX(120.0);

            if (currentAngle <= targetAngle)
            {
                newAngle = this->initialState.angle2 + (currentAngle - targetAngle);
            }
        }
    }

    this->state1.angle2  = newAngle;
    this->state1.fov = FLOAT_DEG_TO_IDX(20.0);
    this->lerpDuration   = duration;
    this->lerpTimer      = 0;
    this->flags          = CViDockCamera::FLAG_MOVE_TO_NEW;
}

void CViDockCamera::ReturnToInitialPosition(u16 duration)
{
    MI_CpuCopy32(&this->targetState, &this->state2, sizeof(this->state2));
    MI_CpuClear32(&this->state1, sizeof(this->state1));

    this->lerpDuration = duration;
    this->lerpTimer    = 0;
    this->flags        = CViDockCamera::FLAG_RETURN_TO_INITIAL;
}

void CViDockCamera::Process()
{
    if (this->lerpDuration == 0)
    {
        MI_CpuCopy32(&this->initialState, &this->targetState, sizeof(this->targetState));

        if (this->type == CViDockCamera::TYPE_DOCK)
            this->ApplyBounds(&this->targetState);
    }
    else
    {
        if (this->lerpTimer >= this->lerpDuration)
        {
            if ((this->flags & CViDockCamera::FLAG_RETURN_TO_INITIAL) != 0)
            {
                MI_CpuCopy32(&this->initialState, &this->targetState, sizeof(this->targetState));

                if (this->type == CViDockCamera::TYPE_DOCK)
                    this->ApplyBounds(&this->targetState);
            }
            else
            {
                MI_CpuCopy32(&this->state1, &this->targetState, sizeof(this->targetState));
            }

            if ((this->flags & CViDockCamera::FLAG_MOVE_TO_NEW) == 0)
            {
                this->lerpDuration = 0;
                this->flags        = CViDockCamera::FLAG_NONE;
            }
        }
        else
        {
            s32 posProgress;
            s32 duration;

            duration          = 32 * this->lerpDuration;
            posProgress       = 32 * this->lerpTimer;
            s32 angleProgress = Unknown2051334__Func_2051600(duration, posProgress, FLOAT_TO_FX32(2.0));

            if ((this->flags & CViDockCamera::FLAG_RETURN_TO_INITIAL) != 0)
            {
                MI_CpuCopy32(&this->initialState, &this->targetState, sizeof(this->targetState));

                this->ApplyBounds(&this->targetState);
                CViDockCamera::HandleLerp(&this->state2, &this->targetState, posProgress, angleProgress, duration, &this->targetState);
            }
            else
            {
                CViDockCamera::HandleLerp(&this->state2, &this->state1, posProgress, angleProgress, duration, &this->targetState);
            }

            this->lerpTimer++;
        }
    }

    this->camTarget.x = this->targetState.camTarget.x;
    this->camTarget.y = this->targetState.camTarget.y;
    this->camTarget.z = this->targetState.camTarget.z;

    this->camPos.x = FLOAT_TO_FX32(0.0);
    this->camPos.y = FLOAT_TO_FX32(0.0);
    this->camPos.z = this->targetState.camPosZ;

    this->camUp.x = FLOAT_TO_FX32(0.0);
    this->camUp.y = FLOAT_TO_FX32(1.0);
    this->camUp.z = FLOAT_TO_FX32(0.0);

    this->fov = this->targetState.fov;

    FXMatrix33 mtx;
    FXMatrix33 mtx2;
    MTX_RotX33(mtx.nnMtx, SinFX(this->targetState.angle1), CosFX(this->targetState.angle1));
    MTX_RotY33(mtx2.nnMtx, SinFX((s32)(u16)(this->targetState.angle2 - FLOAT_DEG_TO_IDX(180.0))), CosFX((s32)(u16)(this->targetState.angle2 - FLOAT_DEG_TO_IDX(180.0))));
    MTX_Concat33(mtx.nnMtx, mtx2.nnMtx, mtx.nnMtx);
    MTX_MultVec33(&this->camPos, mtx.nnMtx, &this->camPos);
    MTX_MultVec33(&this->camUp, mtx.nnMtx, &this->camUp);
    VEC_Add(&this->camPos, &this->camTarget, &this->camPos);
}

void CViDockCamera::SetDrawPipeline()
{
    NNS_G3dGlbSetViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);
    LoadDrawState((DrawState *)this->drawState, DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT | DRAWSTATE_PROJECTION | DRAWSTATE_SWAPBUFFERMODE));

    Camera3D camera;
    MI_CpuClear16(&camera, sizeof(camera));
    GetDrawStateCameraProjection((DrawState *)this->drawState, &camera.projection);
    GetDrawStateCameraView((DrawState *)this->drawState, &camera);
    camera.projection.fov = this->fov;
    SwapBuffer3D_ApplyCameraState(&camera);

    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0x00), GX_COLOR_FROM_888(0xFF), 0x7FFF, 0, FALSE);

    if (this->type != CViDockCamera::TYPE_PREVIEW)
    {
        NNS_G3dGlbLookAt(&this->camPos, &this->camUp, &this->camTarget);

        for (s32 i = 0; i < 4; i++)
        {
            NNS_G3dGlbLightVector((GXLightId)i, this->lights[i].dir.x, this->lights[i].dir.y, this->lights[i].dir.z);
            NNS_G3dGlbLightColor((GXLightId)i, this->lights[i].color);
        }
    }
}

void CViDockCamera::InitState(CViDockCamera::State *state, DockArea dockArea, s32 type)
{
    if (dockArea >= DOCKAREA_COUNT)
    {
        MI_CpuClear32(state, sizeof(*state));
    }
    else
    {
        switch (type)
        {
            default: {
                DockArea area = HubConfig__GetDockBackInfo(dockArea)->dockArea;
                if (area < CViDock::AREA_COUNT)
                {
                    const CViDockAreaConfig *config = HubConfig__GetDockStageConfig(area);
                    state->camPosZ                  = config->camPosZ;
                    state->camTarget.x              = FLOAT_TO_FX32(0.0);
                    state->camTarget.y              = FLOAT_TO_FX32(0.0);
                    state->camTarget.z              = FLOAT_TO_FX32(0.0);
                    state->angle1                   = config->camAngle;
                    state->angle2                   = FLOAT_DEG_TO_IDX(180.0);
                    state->fov                  = FLOAT_DEG_TO_IDX(360.0) - 1;
                }
                else
                {
                    state->camPosZ     = FLOAT_TO_FX32(128.0);
                    state->camTarget.x = FLOAT_TO_FX32(0.0);
                    state->camTarget.y = FLOAT_TO_FX32(0.0);
                    state->camTarget.z = FLOAT_TO_FX32(0.0);
                    state->angle1      = FLOAT_DEG_TO_IDX(0.0);
                    state->angle2      = FLOAT_DEG_TO_IDX(180.0);
                    state->fov     = FLOAT_DEG_TO_IDX(360.0) - 1;
                }
            }
            break;

            case CViDockCamera::TYPE_CONSTRUCTION_CUTSCENE:
                state->camPosZ     = FLOAT_TO_FX32(128.0);
                state->camTarget.x = FLOAT_TO_FX32(0.0);
                state->camTarget.y = FLOAT_TO_FX32(0.0);
                state->camTarget.z = FLOAT_TO_FX32(0.0);
                state->angle1      = FLOAT_DEG_TO_IDX(0.0);
                state->angle2      = FLOAT_DEG_TO_IDX(180.0);
                state->fov     = FLOAT_DEG_TO_IDX(360.0) - 1;
                break;
        }
    }
}

void CViDockCamera::InitLights(DirLight *lights, DockArea dockArea, void *drawState, s32 type)
{
    DirLight gxLights[4];
    GetDrawStateLight((DrawState *)drawState, &gxLights[0], GX_LIGHTID_0);
    GetDrawStateLight((DrawState *)drawState, &gxLights[1], GX_LIGHTID_1);
    GetDrawStateLight((DrawState *)drawState, &gxLights[2], GX_LIGHTID_2);
    GetDrawStateLight((DrawState *)drawState, &gxLights[3], GX_LIGHTID_3);
    MI_CpuCopy32(gxLights, lights, sizeof(gxLights));

    switch (type)
    {

        case CViDockCamera::TYPE_DOCK: {
            const CViDockBackAreaConfig *config = HubConfig__GetDockBackInfo(dockArea);

            FXMatrix33 mtx;
            MTX_RotY33(mtx.nnMtx, SinFX(config->dockRotationY), CosFX(config->dockRotationY));

            for (s32 i = 0; i < 4; i++)
            {
                VecFx32 dir;
                dir.x = gxLights[i].dir.x;
                dir.y = gxLights[i].dir.y;
                dir.z = gxLights[i].dir.z;
                MTX_MultVec33(&dir, mtx.nnMtx, &dir);
                lights[i].dir.x = dir.x;
                lights[i].dir.y = dir.y;
                lights[i].dir.z = dir.z;
                lights[i].color = gxLights[i].color;
            }
        }
        break;

        default:
            break;
    }
}

void CViDockCamera::InitBounds(CViDockCameraBounds *bounds, DockArea dockArea)
{
    if (dockArea < DOCKAREA_COUNT)
    {
        DockArea area = HubConfig__GetDockBackInfo(dockArea)->dockArea;
        if (area < CViDock::AREA_COUNT)
        {
            const CViDockCameraBounds *config = &HubConfig__GetDockStageConfig(area)->camBounds;

            bounds->min = config->min;
            bounds->max = config->max;
        }
    }
}

u16 CViDockCamera::GetFOV()
{
    ProjectionDisplayConfig config;

    GetDrawStateCameraProjection((DrawState *)this->drawState, &config);
    return config.fov;
}

void CViDockCamera::HandleLerp(CViDockCamera::State *state1, CViDockCamera::State *state2, s32 angleProgress, fx32 posProgress, fx32 duration, CViDockCamera::State *targetState)
{
    if (state1->camTarget.x == state2->camTarget.x)
        targetState->camTarget.x = state1->camTarget.x;
    else
        targetState->camTarget.x = Unknown2051334__Func_20516B8(state1->camTarget.x, state2->camTarget.x, duration, posProgress);

    if (state1->camTarget.y == state2->camTarget.y)
        targetState->camTarget.y = state1->camTarget.y;
    else
        targetState->camTarget.y = Unknown2051334__Func_20516B8(state1->camTarget.y, state2->camTarget.y, duration, posProgress);

    if (state1->camTarget.z == state2->camTarget.z)
        targetState->camTarget.z = state1->camTarget.z;
    else
        targetState->camTarget.z = Unknown2051334__Func_20516B8(state1->camTarget.z, state2->camTarget.z, duration, posProgress);

    if (state1->camPosZ == state2->camPosZ)
        targetState->camPosZ = state1->camPosZ;
    else
        targetState->camPosZ = Unknown2051334__Func_20516B8(state1->camPosZ, state2->camPosZ, duration, posProgress);

    if (state1->angle1 == state2->angle1)
        targetState->angle1 = state1->angle1;
    else
        targetState->angle1 = Unknown2051334__Func_20516B8(state1->angle1, state2->angle1, duration, angleProgress);

    if (state1->angle2 == state2->angle2)
        targetState->angle2 = state1->angle2;
    else
        targetState->angle2 = Unknown2051334__Func_20516B8(state1->angle2, state2->angle2, duration, angleProgress);

    if (state1->fov == state2->fov)
        targetState->fov = state1->fov;
    else
        targetState->fov = Unknown2051334__Func_20516B8(state1->fov, state2->fov, duration, posProgress);
}

void CViDockCamera::ApplyBounds(CViDockCamera::State *state)
{
    if (state->camTarget.x < this->bounds.min.x)
    {
        state->camTarget.x = this->bounds.min.x;
    }
    else if (state->camTarget.x > this->bounds.max.x)
    {
        state->camTarget.x = this->bounds.max.x;
    }

    if (state->camTarget.y < this->bounds.min.y)
    {
        state->camTarget.y = this->bounds.min.y;
    }
    else if (state->camTarget.y > this->bounds.max.y)
    {
        state->camTarget.y = this->bounds.max.y;
    }

    if (state->camTarget.z < this->bounds.min.z)
    {
        state->camTarget.z = this->bounds.min.z;
    }
    else if (state->camTarget.z > this->bounds.max.z)
    {
        state->camTarget.z = this->bounds.max.z;
    }
}