#include <hub/cviDockBack.hpp>
#include <hub/cviDock.hpp>
#include <hub/cvi3dObject.hpp>
#include <game/math/cppMath.hpp>
#include <game/system/threadWorker.h>
#include <game/unknown/unknown2085404.h>
#include <game/file/bundleFileUnknown.h>
#include <hub/hubConfig.h>
#include <game/math/unknown2051334.h>

// --------------------
// STRUCTS
// --------------------

struct CViDockBackAssetBundle
{
    const char path[16];
};

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void *_ZTV11CViDockBack;

NOT_DECOMPILED void _ZdlPv(void);

NOT_DECOMPILED void _ZN11CViDockBack7ReleaseEv(void);
}

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED fx32 (*getGroundPosForDockArea[CViDock::AREA_COUNT])(const VecFx32 *pos);
NOT_DECOMPILED void (*drawShadowForArea[CViDock::AREA_COUNT])(CViShadow *work, fx32 scale, fx32 x, fx32 z);
NOT_DECOMPILED BOOL (*checkAreaExitForArea[CViDock::AREA_COUNT])(const VecFx32 *pos);
NOT_DECOMPILED BOOL (*handleCollisionsForArea[CViDock::AREA_COUNT])(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5,
                                                                    u32 *area);
NOT_DECOMPILED void (*getPlayerSpawnConfigForArea[CViDock::AREA_COUNT])(VecFx32 *position, u16 *angle, s32 area);

/*
static fx32 (*getGroundPosForDockArea[CViDock::AREA_COUNT])(const VecFx32 *pos) = {
    CViDockBack::GetGroundPos_Common, CViDockBack::GetGroundPos_Common,    CViDockBack::GetGroundPos_Common, CViDockBack::GetGroundPos_Common,
    CViDockBack::GetGroundPos_Common, CViDockBack::GetGroundPos_Submarine, CViDockBack::GetGroundPos_Common,
};

static void (*drawShadowForArea[CViDock::AREA_COUNT])(CViShadow *work, fx32 scale, fx32 x, fx32 z) = {
    CViDockBack::DrawShadow_Common, CViDockBack::DrawShadow_Common,    CViDockBack::DrawShadow_Common, CViDockBack::DrawShadow_Common,
    CViDockBack::DrawShadow_Common, CViDockBack::DrawShadow_Submarine, CViDockBack::DrawShadow_Common,
};

static BOOL (*checkAreaExitForArea[CViDock::AREA_COUNT])(const VecFx32 *pos) = {
    CViDockBack::CheckExitArea_Base,  CViDockBack::CheckExitArea_BaseNext,  CViDockBack::CheckExitArea_Jet,   CViDockBack::CheckExitArea_Boat,
    CViDockBack::CheckExitArea_Hover, CViDockBack::CheckExitArea_Submarine, CViDockBack::CheckExitArea_Beach,
};

static BOOL (*handleCollisionsForArea[CViDock::AREA_COUNT])(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area) = {
    CViDockBack::Collide_Base,  CViDockBack::Collide_BaseNext,  CViDockBack::Collide_Jet,   CViDockBack::Collide_Boat,
    CViDockBack::Collide_Hover, CViDockBack::Collide_Submarine, CViDockBack::Collide_Beach,
};

static void (*getPlayerSpawnConfigForArea[CViDock::AREA_COUNT])(VecFx32 *position, u16 *angle, s32 area) = {
    CViDockBack::PlayerSpawnConfig_Base,  CViDockBack::PlayerSpawnConfig_BaseNext,  CViDockBack::PlayerSpawnConfig_Jet,   CViDockBack::PlayerSpawnConfig_Boat,
    CViDockBack::PlayerSpawnConfig_Hover, CViDockBack::PlayerSpawnConfig_Submarine, CViDockBack::PlayerSpawnConfig_Beach,
};
*/

static const CViDockBackAssetBundle dockBackAssets[1] = { { "bb/vi_dock.bb" } };

// --------------------
// FUNCTIONS
// --------------------

#ifdef NON_MATCHING
CViDockBack::CViDockBack()
#else
// NONMATCH_FUNC CViDockBack::CViDockBack()
NONMATCH_FUNC void _ZN11CViDockBackC1Ev(CViDockBack *work)
#endif
{
    // will match when 'CVi3dObject' constructor is decompiled
#ifdef NON_MATCHING
    this->resModelDock     = HeapAllocHead(HEAP_USER, KiB(128));
    this->resJointAnimDock = HeapAllocHead(HEAP_USER, KiB(8));
    this->resModelShip     = HeapAllocHead(HEAP_USER, KiB(256));
    this->resJointAnimShip = HeapAllocHead(HEAP_USER, KiB(8));
    this->resTextureAnim   = HeapAllocHead(HEAP_USER, KiB(8));
    this->resPatternAnim   = HeapAllocHead(HEAP_USER, KiB(2));

    this->dockVisible = FALSE;
    this->shipVisible = FALSE;
    this->shipLoaded  = FALSE;

    InitThreadWorker(&this->threadWorker.thread, 0x800);

    this->Release();
#else
    // clang-format off
    stmdb sp!, {r4, lr}
    mov r4, r0
    ldr r1, =_ZTV11CViDockBack+0x08
    add r0, r4, #8
    str r1, [r4]
    bl _ZN11CVi3dObjectC2Ev
    add r0, r4, #0x308
    bl _ZN11CVi3dObjectC2Ev
    add r0, r4, #0x208
    add r0, r0, #0x400
    bl _ZN11CVi3dObjectC2Ev
    add r0, r4, #0x920
    bl _ZN11CVi3dObjectC2Ev
    mov r0, #0x20000
    bl _AllocHeadHEAP_USER
    str r0, [r4, #0x90c]
    mov r0, #0x2000
    bl _AllocHeadHEAP_USER
    str r0, [r4, #0x910]
    mov r0, #0x40000
    bl _AllocHeadHEAP_USER
    str r0, [r4, #0xc24]
    mov r0, #0x2000
    bl _AllocHeadHEAP_USER
    str r0, [r4, #0xc28]
    mov r0, #0x2000
    bl _AllocHeadHEAP_USER
    str r0, [r4, #0x914]
    mov r0, #0x800
    bl _AllocHeadHEAP_USER
    str r0, [r4, #0x918]
    mov r0, #0
    str r0, [r4, #0x908]
    str r0, [r4, #0xc20]
    str r0, [r4, #0x91c]
    add r0, r4, #0x2c
    add r0, r0, #0xc00
    mov r1, #0x800
    bl InitThreadWorker
    mov r0, r4
    bl _ZN11CViDockBack7ReleaseEv
    mov r0, r4
    ldmia sp!, {r4, pc}
// clang-format on
#endif
}

#ifdef NON_MATCHING
CViDockBack::~CViDockBack()
#else
// CViDockBack::~CViDockBack()
NONMATCH_FUNC void _ZN11CViDockBackD0Ev(CViDockBack *work)
#endif
{
    // will match when 'CVi3dObject' destructor is decompiled
#ifdef NON_MATCHING
    this->Release();

    ReleaseThreadWorker(&this->threadWorker.thread);

    HeapFree(HEAP_USER, this->resPatternAnim);
    HeapFree(HEAP_USER, this->resTextureAnim);
    HeapFree(HEAP_USER, this->resJointAnimShip);
    HeapFree(HEAP_USER, this->resModelShip);
    HeapFree(HEAP_USER, this->resJointAnimDock);
    HeapFree(HEAP_USER, this->resModelDock);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CViDockBack+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CViDockBack7ReleaseEv
	add r0, r4, #0x2c
	add r0, r0, #0xc00
	bl ReleaseThreadWorker
	ldr r0, [r4, #0x918]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x914]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc28]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc24]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x910]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x90c]
	bl _FreeHEAP_USER
	add r0, r4, #0x920
	bl _ZN11CVi3dObjectD0Ev
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl _ZN11CVi3dObjectD0Ev
	add r0, r4, #0x308
	bl _ZN11CVi3dObjectD0Ev
	add r0, r4, #8
	bl _ZN11CVi3dObjectD0Ev
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

#ifndef NON_MATCHING
NONMATCH_FUNC void _ZN11CViDockBackD1Ev(CViDockBack *work)
{
    // will match when 'CVi3dObject' destructor is decompiled
#ifdef NON_MATCHING
    this->Release();

    ReleaseThreadWorker(&this->threadWorker.thread);

    HeapFree(HEAP_USER, this->resPatternAnim);
    HeapFree(HEAP_USER, this->resTextureAnim);
    HeapFree(HEAP_USER, this->resJointAnimShip);
    HeapFree(HEAP_USER, this->resModelShip);
    HeapFree(HEAP_USER, this->resJointAnimDock);
    HeapFree(HEAP_USER, this->resModelDock);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CViDockBack+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CViDockBack7ReleaseEv
	add r0, r4, #0x2c
	add r0, r0, #0xc00
	bl ReleaseThreadWorker
	ldr r0, [r4, #0x918]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x914]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc28]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc24]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x910]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x90c]
	bl _FreeHEAP_USER
	add r0, r4, #0x920
	bl _ZN11CVi3dObjectD0Ev
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl _ZN11CVi3dObjectD0Ev
	add r0, r4, #0x308
	bl _ZN11CVi3dObjectD0Ev
	add r0, r4, #8
	bl _ZN11CVi3dObjectD0Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}
#endif

void CViDockBack::Init(s32 dockArea, BOOL noAssetRelease, BOOL disableAnimations)
{
    if (noAssetRelease == FALSE)
        this->Release();

    this->dockArea = dockArea;
    if (dockArea < DOCKAREA_NONE)
    {
        const CViDockBackAreaConfig *config = HubConfig__GetDockBackInfo(dockArea);
        if (disableAnimations == FALSE)
        {
            void *resJointAnimDock;
            void *resPatternAnim;
            void *resTextureAnim;

            resTextureAnim   = NULL;
            resPatternAnim   = NULL;
            resJointAnimDock = NULL;

            BundleFileUnknown__LoadFileFromBundle(dockBackAssets[0].path, config->resModelDock, this->resModelDock);

            if (config->resJointAnimDock != CVI3DOBJECT_RESOURCE_NONE)
            {
                BundleFileUnknown__LoadFileFromBundle(dockBackAssets[0].path, config->resJointAnimDock, this->resJointAnimDock);
                resJointAnimDock = this->resJointAnimDock;
            }

            if (config->resTextureAnimDock != CVI3DOBJECT_RESOURCE_NONE)
            {
                BundleFileUnknown__LoadFileFromBundle(dockBackAssets[0].path, config->resTextureAnimDock, this->resTextureAnim);
                resTextureAnim = this->resTextureAnim;
            }

            if (config->resPatternAnimDock != CVI3DOBJECT_RESOURCE_NONE)
            {
                BundleFileUnknown__LoadFileFromBundle(dockBackAssets[0].path, config->resPatternAnimDock, this->resPatternAnim);
                resPatternAnim = this->resPatternAnim;
            }

            if (this->dockArea != DOCKAREA_BEACH)
            {
                this->objDockEnvironment.SetResources(this->resModelDock, 0, FALSE, FALSE, resJointAnimDock, NULL, NULL, resPatternAnim, resTextureAnim, CVI3DOBJECT_RESOURCE_NONE);

                if (config->resJointAnimDock != CVI3DOBJECT_RESOURCE_NONE)
                    this->objDockEnvironment.SetJointAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

                if (config->resTextureAnimDock != CVI3DOBJECT_RESOURCE_NONE)
                    this->objDockEnvironment.SetVisibilityAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

                if (config->resPatternAnimDock != CVI3DOBJECT_RESOURCE_NONE)
                    this->objDockEnvironment.SetTextureAnimForBody(0, TRUE, FALSE, FALSE, FALSE);
            }
            else
            {
                this->objDockEnvironment.SetResources(this->resModelDock, 0, FALSE, FALSE, resJointAnimDock, NULL, NULL, resPatternAnim, resTextureAnim, CVI3DOBJECT_RESOURCE_NONE);

                this->objDockWater.SetResources(&this->objDockEnvironment, 1, FALSE, FALSE, CVI3DOBJECT_RESOURCE_NONE);
                this->objDockWater.SetJointAnimForBody(0, TRUE, FALSE, FALSE, FALSE);
                this->objDockWater.SetTextureAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

                this->objDockWetSand.SetResources(&this->objDockEnvironment, 2, FALSE, FALSE, CVI3DOBJECT_RESOURCE_NONE);
                this->objDockWetSand.SetJointAnimForBody(1, TRUE, FALSE, FALSE, FALSE);
            }

            this->dockVisible = TRUE;
        }

        if (config->resModelShip != CVI3DOBJECT_RESOURCE_NONE)
        {
            void *resJointAnim = NULL;
            BundleFileUnknown__LoadFileFromBundle(dockBackAssets[0].path, config->resModelShip, this->resModelShip);

            if (disableAnimations == FALSE)
            {
                if (config->resJointAnimShip != CVI3DOBJECT_RESOURCE_NONE)
                {
                    BundleFileUnknown__LoadFileFromBundle(dockBackAssets[0].path, config->resJointAnimShip, this->resJointAnimShip);
                    resJointAnim = this->resJointAnimShip;
                }
            }

            this->objDockShip.SetResources(this->resModelShip, 0, FALSE, FALSE, resJointAnim, NULL, NULL, NULL, NULL, CVI3DOBJECT_RESOURCE_NONE);

            if (disableAnimations == FALSE)
            {
                if (config->resJointAnimShip != CVI3DOBJECT_RESOURCE_NONE)
                    this->objDockShip.SetJointAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

                CVector3 a1(0, config->shipPosY, 0);
                this->objDockShip.position = a1.ToVecFx32Ref();
            }

            this->shipLoaded = TRUE;
        }
        else
        {
            this->shipLoaded = FALSE;
        }

        this->shipVisible = TRUE;
    }
}

void CViDockBack::SetArea(s32 area)
{
    this->Release();

    this->dockArea = area;

    this->threadWorker.parent = this;
    this->threadWorker.area   = area;
    CreateThreadWorker(&this->threadWorker.thread, CViDockBack::ThreadFunc, &this->threadWorker, 20);
}

BOOL CViDockBack::IsThreadIdle()
{
    return IsThreadWorkerFinished(&this->threadWorker.thread);
}

void CViDockBack::Release()
{
    JoinThreadWorker(&this->threadWorker.thread);

    if (this->dockVisible)
    {
        this->objDockEnvironment.Release();
        this->objDockWater.Release();
        this->objDockWetSand.Release();
        this->dockVisible = FALSE;
    }

    if (this->shipVisible)
    {
        this->objDockShip.Release();
        this->shipVisible = FALSE;
    }

    this->shipLoaded = FALSE;
    this->dockArea   = DOCKAREA_INVALID;
}

void CViDockBack::Process()
{
    if (this->dockVisible)
    {
        this->objDockEnvironment.Process();
        if (this->dockArea == DOCKAREA_BEACH)
        {
            this->objDockWater.Process();
            this->objDockWetSand.Process();
        }
    }

    if (this->shipLoaded && this->shipVisible)
        this->objDockShip.Process();
}

void CViDockBack::SetShipPosition(fx32 y)
{
    VecFx32 translation;
    translation.x = this->objDockShip.position.ToConstVecFx32Ref().x;
    translation.y = y;
    translation.z = this->objDockShip.position.ToConstVecFx32Ref().z;

    this->objDockShip.position = translation;
}

void CViDockBack::SetShipScale(fx32 scale)
{
    VecFx32 scaleVec;
    scaleVec.x = scaleVec.y = scaleVec.z = scale;

    this->objDockShip.scale = scaleVec;
}

void CViDockBack::DrawDock(u16 rotationY, u16 rotationX, u16 rotationZ)
{
    if (this->dockVisible)
    {
        this->objDockEnvironment.targetTurnAngle = rotationY;
        this->objDockEnvironment.rotationX       = rotationX;
        this->objDockEnvironment.rotationZ       = rotationZ;
        this->objDockEnvironment.Draw();

        if (this->dockArea == DOCKAREA_BEACH)
        {
            this->objDockWater.targetTurnAngle = rotationY;
            this->objDockWater.rotationX       = rotationX;
            this->objDockWater.rotationZ       = rotationZ;
            this->objDockWater.Draw();

            this->objDockWetSand.targetTurnAngle = rotationY;
            this->objDockWetSand.rotationX       = rotationX;
            this->objDockWetSand.rotationZ       = rotationZ;
            this->objDockWetSand.Draw();
        }
    }

    if (this->shipLoaded && this->shipVisible)
    {
        this->objDockShip.targetTurnAngle = rotationY;
        this->objDockShip.rotationX       = rotationX;
        this->objDockShip.rotationZ       = rotationZ;
        this->objDockShip.Draw();
    }
}

BOOL CViDockBack::ProcessCollision(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    return handleCollisionsForArea[this->dockArea](prevPlayerPos, curPlayerPos, newPlayerPos, isSailPrompt, a5, area);
}

BOOL CViDockBack::DidExitArea(VecFx32 pos)
{
    return checkAreaExitForArea[this->dockArea](&pos);
}

fx32 CViDockBack::GetFloorPosition(VecFx32 pos)
{
    return getGroundPosForDockArea[this->dockArea](&pos);
}

void CViDockBack::DrawShadow(CViShadow *shadow, fx32 scale, fx32 x, fx32 z)
{
    drawShadowForArea[this->dockArea](shadow, scale, x, z);
}

void CViDockBack::GetPlayerSpawnConfig(s32 id, VecFx32 *position, u16 *angle, s32 area)
{
    getPlayerSpawnConfigForArea[id](position, angle, area);
}

NONMATCH_FUNC BOOL CViDockBack::Collide_Base(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    // https://decomp.me/scratch/ytRAy -> 93.62%
#ifdef NON_MATCHING
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_BASE;

    fx32 x1 = curPlayerPos->x;
    fx32 x0 = prevPlayerPos->x;
    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = curPlayerPos->x;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 z0   = prevPlayerPos->z;
        fx32 outX = curPlayerPos->x;
        fx32 z1   = curPlayerPos->z;
        fx32 outZ = curPlayerPos->z;

        if (z0 > FLOAT_TO_FX32(19.0))
        {
            if (outZ > FLOAT_TO_FX32(26.0))
                outZ = FLOAT_TO_FX32(26.0);

            if (outX < -FLOAT_TO_FX32(2.0))
            {
                if (outZ > FLOAT_TO_FX32(23.0))
                {
                    outX = -FLOAT_TO_FX32(2.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(23.0), -FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(19.0));
                }
            }
            else
            {
                if (outX > FLOAT_TO_FX32(2.0))
                {
                    if (outZ > FLOAT_TO_FX32(23.0))
                    {
                        outX = FLOAT_TO_FX32(2.0);
                    }
                    else
                    {
                        Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(19.0), FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(23.0));
                    }
                }
            }
        }
        else if (x0 < -FLOAT_TO_FX32(10.0))
        {
            if (outZ > FLOAT_TO_FX32(19.0))
                outZ = FLOAT_TO_FX32(19.0);

            if (outZ < FLOAT_TO_FX32(12.0))
                outZ = FLOAT_TO_FX32(12.0);

            if (outX < -FLOAT_TO_FX32(15.0))
                outX = -FLOAT_TO_FX32(15.0);
        }
        else if (x0 < FLOAT_TO_FX32(8.0))
        {
            if (outZ > FLOAT_TO_FX32(19.0))
            {
                if (outX < -FLOAT_TO_FX32(6.0) || outX > FLOAT_TO_FX32(6.0))
                {
                    outZ = FLOAT_TO_FX32(19.0);
                }
                else
                {
                    if (outX < -FLOAT_TO_FX32(2.0))
                    {
                        Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(23.0), -FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(19.0));
                    }
                    else if (outX > FLOAT_TO_FX32(2.0))
                    {
                        Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(19.0), FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(23.0));
                    }
                }
            }

            if (outZ < FLOAT_TO_FX32(5.0))
                outZ = FLOAT_TO_FX32(5.0);

            if (outZ < FLOAT_TO_FX32(12.0) && outX < -FLOAT_TO_FX32(10.0))
                outX = -FLOAT_TO_FX32(10.0);
        }
        else if (z0 > FLOAT_TO_FX32(4.0))
        {
            if (outZ > FLOAT_TO_FX32(19.0))
                outZ = FLOAT_TO_FX32(19.0);

            if (outX > FLOAT_TO_FX32(16.0))
            {
                if (outZ > FLOAT_TO_FX32(8.0))
                {
                    outX = FLOAT_TO_FX32(16.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, 81920, FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(8.0));
                }
            }

            if (outZ < FLOAT_TO_FX32(5.0) && outX < FLOAT_TO_FX32(9.0))
                outX = FLOAT_TO_FX32(9.0);
        }
        else if (x0 > FLOAT_TO_FX32(16.0))
        {
            if (outX > FLOAT_TO_FX32(25.0))
                outX = FLOAT_TO_FX32(25.0);

            if (outZ > FLOAT_TO_FX32(4.0))
            {
                if (outX > FLOAT_TO_FX32(20.0))
                {
                    outZ = FLOAT_TO_FX32(4.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(8.0));
                }
            }

            if (outZ < -FLOAT_TO_FX32(2.0))
            {
                if (outX > FLOAT_TO_FX32(20.0))
                {
                    outZ = -FLOAT_TO_FX32(2.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(16.0), -FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(20.0), -FLOAT_TO_FX32(2.0));
                }
            }
        }
        else
        {
            if (outX < FLOAT_TO_FX32(9.0))
                outX = FLOAT_TO_FX32(9.0);

            if (outZ < -FLOAT_TO_FX32(6.0))
                outZ = -FLOAT_TO_FX32(6.0);

            if (outZ < -FLOAT_TO_FX32(2.0))
            {
                if (outZ < -FLOAT_TO_FX32(6.0))
                {
                    outX = FLOAT_TO_FX32(16.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(16.0), -FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(20.0), -FLOAT_TO_FX32(2.0));
                }
            }
        }

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;

        if (newPlayerPos->x >= FLOAT_TO_FX32(23.0) && area != NULL)
            *area = DOCKAREA_BASE_NEXT;
    }

    return collided;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	mov r6, r2
	ldr r2, [sp, #0x30]
	ldr r5, [sp, #0x34]
	mov r4, #0
	cmp r3, #0
	strne r4, [r3]
	mov r7, r1
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	cmp r5, #0
	movne r1, #0
	strne r1, [r5]
	ldr ip, [r7]
	ldr r2, [r0, #0]
	cmp r2, ip
	ldreq r3, [r0, #4]
	ldreq r1, [r7, #4]
	cmpeq r3, r1
	ldreq r3, [r0, #8]
	ldreq r1, [r7, #8]
	cmpeq r3, r1
	bne _02164CC0
	str ip, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [r7, #8]
	str r0, [r6, #8]
	b _02165090
_02164CC0:
	ldr r0, [r0, #8]
	str ip, [sp, #0x14]
	ldr r1, [r7, #8]
	cmp r0, #0x13000
	str r1, [sp, #0x10]
	ble _02164D80
	cmp r1, #0x1a000
	movgt r0, #0x1a000
	strgt r0, [sp, #0x10]
	mov r3, #0x2000
	ldr r0, [sp, #0x14]
	rsb r3, r3, #0
	cmp r0, r3
	bge _02164D34
	ldr r1, [sp, #0x10]
	cmp r1, #0x17000
	strgt r3, [sp, #0x14]
	bgt _0216503C
	mov r2, #0x17000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x1d000
	str ip, [sp, #8]
	mov ip, #0x13000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _0216503C
_02164D34:
	cmp r0, #0x2000
	ble _0216503C
	ldr r1, [sp, #0x10]
	cmp r1, #0x17000
	movgt r0, #0x2000
	strgt r0, [sp, #0x14]
	bgt _0216503C
	mov r2, #0x6000
	str r2, [sp]
	mov r2, #0x13000
	str r2, [sp, #4]
	mov ip, #0x2000
	str ip, [sp, #8]
	mov ip, #0x17000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _0216503C
_02164D80:
	mov r3, #0xa000
	rsb r3, r3, #0
	cmp r2, r3
	bge _02164DC4
	cmp r1, #0x13000
	movgt r0, #0x13000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	cmp r0, #0xc000
	movlt r0, #0xc000
	strlt r0, [sp, #0x10]
	mov r0, #0xf000
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	b _0216503C
_02164DC4:
	cmp r2, #0x8000
	bge _02164EA0
	cmp r1, #0x13000
	ble _02164E6C
	add r0, r3, #0x4000
	cmp ip, r0
	blt _02164DE8
	cmp ip, #0x6000
	ble _02164DF4
_02164DE8:
	mov r0, #0x13000
	str r0, [sp, #0x10]
	b _02164E6C
_02164DF4:
	add r0, r3, #0x8000
	cmp ip, r0
	bge _02164E34
	mov r2, r0
	mov r0, #0x17000
	str r2, [sp]
	str r0, [sp, #4]
	sub lr, r0, #0x1d000
	mov r0, ip
	add r2, sp, #0x14
	add r3, sp, #0x10
	str lr, [sp, #8]
	mov ip, #0x13000
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02164E6C
_02164E34:
	cmp ip, #0x2000
	ble _02164E6C
	mov r0, #0x6000
	str r0, [sp]
	mov r0, #0x13000
	str r0, [sp, #4]
	mov lr, #0x2000
	mov r0, ip
	add r2, sp, #0x14
	add r3, sp, #0x10
	str lr, [sp, #8]
	mov ip, #0x17000
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02164E6C:
	ldr r0, [sp, #0x10]
	cmp r0, #0x5000
	movlt r0, #0x5000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0xc000
	bge _0216503C
	mov r0, #0xa000
	ldr r1, [sp, #0x14]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	b _0216503C
_02164EA0:
	cmp r0, #0x4000
	ble _02164F1C
	cmp r1, #0x13000
	movgt r0, #0x13000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	cmp r0, #0x10000
	ble _02164F00
	ldr r1, [sp, #0x10]
	cmp r1, #0x8000
	movgt r0, #0x10000
	strgt r0, [sp, #0x14]
	bgt _02164F00
	mov r2, #0x14000
	str r2, [sp]
	mov r2, #0x4000
	str r2, [sp, #4]
	mov ip, #0x10000
	str ip, [sp, #8]
	mov ip, #0x8000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02164F00:
	ldr r0, [sp, #0x10]
	cmp r0, #0x5000
	ldrlt r0, [sp, #0x14]
	cmplt r0, #0x9000
	movlt r0, #0x9000
	strlt r0, [sp, #0x14]
	b _0216503C
_02164F1C:
	cmp r2, #0x10000
	ble _02164FCC
	ldr r1, [sp, #0x10]
	cmp ip, #0x19000
	movgt r0, #0x19000
	strgt r0, [sp, #0x14]
	cmp r1, #0x4000
	ble _02164F7C
	ldr r0, [sp, #0x14]
	cmp r0, #0x14000
	movgt r0, #0x4000
	strgt r0, [sp, #0x10]
	bgt _02164F7C
	mov r2, #0x14000
	str r2, [sp]
	mov r2, #0x4000
	str r2, [sp, #4]
	mov ip, #0x10000
	str ip, [sp, #8]
	mov ip, #0x8000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02164F7C:
	mov ip, #0x2000
	ldr r1, [sp, #0x10]
	rsb ip, ip, #0
	cmp r1, ip
	bge _0216503C
	ldr r0, [sp, #0x14]
	cmp r0, #0x14000
	strgt ip, [sp, #0x10]
	bgt _0216503C
	mov r2, #0x10000
	str r2, [sp]
	sub r2, r2, #0x16000
	str r2, [sp, #4]
	mov r2, #0x14000
	str r2, [sp, #8]
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _0216503C
_02164FCC:
	cmp ip, #0x9000
	movlt r0, #0x9000
	strlt r0, [sp, #0x14]
	mov r0, #0x6000
	mov r2, #0x2000
	ldr r1, [sp, #0x10]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x10]
	ldr r1, [sp, #0x10]
	rsb r2, r2, #0
	cmp r1, r2
	bge _0216503C
	sub r0, r2, #0x4000
	cmp r1, r0
	mov r0, #0x10000
	strlt r0, [sp, #0x14]
	blt _0216503C
	str r0, [sp]
	sub r0, r0, #0x16000
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r0, [sp, #0x14]
	add r2, sp, #0x14
	add r3, sp, #0x10
	bl Unknown2051334__Func_2051450
_0216503C:
	ldr r0, [sp, #0x14]
	str r0, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [sp, #0x10]
	str r0, [r6, #8]
	ldr r2, [r6, #0]
	ldr r0, [r7, #0]
	cmp r2, r0
	ldreq r1, [r6, #4]
	ldreq r0, [r7, #4]
	cmpeq r1, r0
	ldreq r1, [r6, #8]
	ldreq r0, [r7, #8]
	cmpeq r1, r0
	movne r4, #1
	cmp r2, #0x17000
	blt _02165090
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
_02165090:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL CViDockBack::Collide_BaseNext(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    // https://decomp.me/scratch/iQo2Y -> 97.87%
#ifdef NON_MATCHING
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_BASE_NEXT;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = curPlayerPos->x;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 outX;
        fx32 outZ;
        fx32 x0;

        x0   = prevPlayerPos->x;
        outX = curPlayerPos->x;
        outZ = curPlayerPos->z;

        if (outZ < -FLOAT_TO_FX32(3.0))
            outZ = -FLOAT_TO_FX32(3.0);

        if (outZ > FLOAT_TO_FX32(16.0))
            outZ = FLOAT_TO_FX32(16.0);

        if (outX > FLOAT_TO_FX32(14.0))
            outX = FLOAT_TO_FX32(14.0);

        if (x0 < -FLOAT_TO_FX32(14.0))
        {
            if (outZ > FLOAT_TO_FX32(3.0))
            {
                if (outX < -FLOAT_TO_FX32(18.0))
                {
                    outZ = FLOAT_TO_FX32(3.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(14.0), FLOAT_TO_FX32(7.0), -FLOAT_TO_FX32(18.0), FLOAT_TO_FX32(3.0));
                }
            }
        }
        else if (outX < -FLOAT_TO_FX32(14.0))
        {
            if (outZ > FLOAT_TO_FX32(3.0))
            {
                if (outZ > FLOAT_TO_FX32(7.0))
                {
                    outX = -FLOAT_TO_FX32(14.0);
                }
                else
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(14.0), FLOAT_TO_FX32(7.0), -FLOAT_TO_FX32(18.0), FLOAT_TO_FX32(3.0));
                }
            }
        }

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;

        if (newPlayerPos->x <= -FLOAT_TO_FX32(22.0) && area != NULL)
            *area = DOCKAREA_BASE;
    }

    return collided;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	mov r6, r2
	ldr r2, [sp, #0x30]
	ldr r5, [sp, #0x34]
	mov r4, #0
	cmp r3, #0
	strne r4, [r3]
	mov r7, r1
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	cmp r5, #0
	movne r1, #1
	strne r1, [r5]
	ldr ip, [r7]
	ldr r1, [r0, #0]
	cmp r1, ip
	ldreq r3, [r0, #4]
	ldreq r2, [r7, #4]
	cmpeq r3, r2
	ldreq r2, [r0, #8]
	ldreq r0, [r7, #8]
	cmpeq r2, r0
	bne _02165118
	str ip, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [r7, #8]
	str r0, [r6, #8]
	b _0216525C
_02165118:
	str ip, [sp, #0x14]
	ldr r2, [r7, #8]
	mov r0, #0x3000
	rsb r0, r0, #0
	str r2, [sp, #0x10]
	cmp r2, r0
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	mov r3, #0xe000
	cmp r0, #0x10000
	movgt r0, #0x10000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	rsb r3, r3, #0
	cmp r0, #0xe000
	movgt r0, #0xe000
	strgt r0, [sp, #0x14]
	cmp r1, r3
	bge _021651B4
	ldr r1, [sp, #0x10]
	cmp r1, #0x3000
	ble _02165200
	ldr r0, [sp, #0x14]
	sub r2, r3, #0x4000
	cmp r0, r2
	movlt r0, #0x3000
	strlt r0, [sp, #0x10]
	blt _02165200
	mov r2, #0x7000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x19000
	str ip, [sp, #8]
	mov ip, #0x3000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02165200
_021651B4:
	ldr r0, [sp, #0x14]
	cmp r0, r3
	bge _02165200
	ldr r1, [sp, #0x10]
	cmp r1, #0x3000
	ble _02165200
	cmp r1, #0x7000
	strgt r3, [sp, #0x14]
	bgt _02165200
	mov r2, #0x7000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x19000
	str ip, [sp, #8]
	mov ip, #0x3000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165200:
	ldr r0, [sp, #0x14]
	str r0, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [sp, #0x10]
	str r0, [r6, #8]
	ldr r2, [r6, #0]
	ldr r0, [r7, #0]
	cmp r2, r0
	ldreq r1, [r6, #4]
	ldreq r0, [r7, #4]
	cmpeq r1, r0
	ldreq r1, [r6, #8]
	ldreq r0, [r7, #8]
	cmpeq r1, r0
	mov r0, #0x16000
	rsb r0, r0, #0
	movne r4, #1
	cmp r2, r0
	bgt _0216525C
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
_0216525C:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL CViDockBack::Collide_Jet(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    // https://decomp.me/scratch/sFudn -> 98.95%
#ifdef NON_MATCHING
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_JET;

    fx32 x1 = curPlayerPos->x;
    fx32 x0 = prevPlayerPos->x;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = curPlayerPos->x;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 z0   = prevPlayerPos->z;
        fx32 outX = curPlayerPos->x;
        fx32 outZ = curPlayerPos->z;

        if (z0 > FLOAT_TO_FX32(47.0))
        {
            if (outZ > FLOAT_TO_FX32(94.0))
                outZ = FLOAT_TO_FX32(94.0);

            if (outX < -FLOAT_TO_FX32(33.0))
                outX = -FLOAT_TO_FX32(33.0);

            if (outX > -FLOAT_TO_FX32(26.0))
            {
                if (outZ <= FLOAT_TO_FX32(55.0))
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(47.0), -FLOAT_TO_FX32(26.0), FLOAT_TO_FX32(55.0));
                }
                else
                {
                    outX = -FLOAT_TO_FX32(26.0);
                }
            }
        }
        else
        {
            if (x1 < -FLOAT_TO_FX32(33.0))
                outX = -FLOAT_TO_FX32(33.0);

            if (outX > FLOAT_TO_FX32(32.0))
                outX = FLOAT_TO_FX32(32.0);

            if (outZ < FLOAT_TO_FX32(18.0))
            {
                outZ = FLOAT_TO_FX32(18.0);

                if (a5 != NULL)
                    *a5 = TRUE;
            }

            if (outX > -FLOAT_TO_FX32(26.0) && outZ > FLOAT_TO_FX32(47.0))
            {
                if (outX <= -FLOAT_TO_FX32(20.0))
                {
                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(47.0), -FLOAT_TO_FX32(26.0), FLOAT_TO_FX32(55.0));
                }
                else
                {
                    outZ = FLOAT_TO_FX32(47.0);
                }
            }

            if (x0 <= FLOAT_TO_FX32(10.0))
            {
                if (outX > FLOAT_TO_FX32(10.0))
                {
                    if (outZ < FLOAT_TO_FX32(29.0))
                        outX = FLOAT_TO_FX32(10.0);
                }
            }
            else
            {
                if (outZ < FLOAT_TO_FX32(29.0))
                    outZ = FLOAT_TO_FX32(29.0);
            }
        }

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;
    }

    if (newPlayerPos->z <= FLOAT_TO_FX32(18.0) && newPlayerPos->x >= -FLOAT_TO_FX32(10.0) && newPlayerPos->x <= FLOAT_TO_FX32(5.0))
    {
        if (isSailPrompt != NULL)
            *isSailPrompt = TRUE;
    }
    else
    {
        if (a5 != NULL)
            *a5 = FALSE;
    }

    return collided;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x18
	ldr r6, [sp, #0x38]
	mov r8, r2
	movs r7, r3
	mov r4, #0
	strne r4, [r7]
	ldr r2, [sp, #0x3c]
	mov r9, r1
	cmp r6, #0
	movne r1, #0
	strne r1, [r6]
	cmp r2, #0
	movne r1, #2
	strne r1, [r2]
	ldr r1, [r9, #0]
	ldr r5, [r0, #0]
	cmp r5, r1
	ldreq r3, [r0, #4]
	ldreq r2, [r9, #4]
	cmpeq r3, r2
	ldreq r3, [r0, #8]
	ldreq r2, [r9, #8]
	cmpeq r3, r2
	bne _021652E4
	str r1, [r8]
	ldr r0, [r9, #4]
	str r0, [r8, #4]
	ldr r0, [r9, #8]
	str r0, [r8, #8]
	b _02165478
_021652E4:
	ldr r2, [r0, #8]
	str r1, [sp, #0x14]
	ldr r0, [r9, #8]
	cmp r2, #0x2f000
	str r0, [sp, #0x10]
	ble _0216536C
	cmp r0, #0x5e000
	movgt r0, #0x5e000
	strgt r0, [sp, #0x10]
	mov r0, #0x21000
	mov r5, #0x1a000
	ldr r1, [sp, #0x14]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	rsb r5, r5, #0
	cmp r0, r5
	ble _02165438
	ldr r1, [sp, #0x10]
	cmp r1, #0x37000
	strgt r5, [sp, #0x14]
	bgt _02165438
	add r2, r5, #0x6000
	str r2, [sp]
	mov r2, #0x2f000
	str r2, [sp, #4]
	str r5, [sp, #8]
	mov r5, #0x37000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str r5, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02165438
_0216536C:
	mov r0, #0x21000
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	cmp r0, #0x20000
	movgt r0, #0x20000
	strgt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0x12000
	bge _021653AC
	mov r0, #0x12000
	str r0, [sp, #0x10]
	cmp r6, #0
	movne r0, #1
	strne r0, [r6]
_021653AC:
	mov ip, #0x1a000
	ldr r0, [sp, #0x14]
	rsb ip, ip, #0
	cmp r0, ip
	ldrgt r1, [sp, #0x10]
	cmpgt r1, #0x2f000
	ble _02165400
	add r2, ip, #0x6000
	cmp r0, r2
	movgt r0, #0x2f000
	strgt r0, [sp, #0x10]
	bgt _02165400
	str r2, [sp]
	mov r2, #0x2f000
	str r2, [sp, #4]
	str ip, [sp, #8]
	mov ip, #0x37000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165400:
	cmp r5, #0xa000
	bgt _02165428
	ldr r0, [sp, #0x14]
	cmp r0, #0xa000
	ble _02165438
	ldr r0, [sp, #0x10]
	cmp r0, #0x1d000
	movlt r0, #0xa000
	strlt r0, [sp, #0x14]
	b _02165438
_02165428:
	ldr r0, [sp, #0x10]
	cmp r0, #0x1d000
	movlt r0, #0x1d000
	strlt r0, [sp, #0x10]
_02165438:
	ldr r0, [sp, #0x14]
	str r0, [r8]
	ldr r0, [r9, #4]
	str r0, [r8, #4]
	ldr r0, [sp, #0x10]
	str r0, [r8, #8]
	ldr r1, [r8, #0]
	ldr r0, [r9, #0]
	cmp r1, r0
	ldreq r1, [r8, #4]
	ldreq r0, [r9, #4]
	cmpeq r1, r0
	ldreq r1, [r8, #8]
	ldreq r0, [r9, #8]
	cmpeq r1, r0
	movne r4, #1
_02165478:
	ldr r0, [r8, #8]
	cmp r0, #0x12000
	bgt _021654B0
	mov r0, #0xa000
	ldr r1, [r8, #0]
	rsb r0, r0, #0
	cmp r1, r0
	blt _021654B0
	cmp r1, #0x5000
	bgt _021654B0
	cmp r7, #0
	movne r0, #1
	strne r0, [r7]
	b _021654BC
_021654B0:
	cmp r6, #0
	movne r0, #0
	strne r0, [r6]
_021654BC:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

BOOL CViDockBack::Collide_Boat(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_BOAT;

    fx32 x1 = curPlayerPos->x;
    fx32 x0 = prevPlayerPos->x;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = curPlayerPos->x;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 z0   = prevPlayerPos->z;
        fx32 outX = curPlayerPos->x;
        fx32 outZ = curPlayerPos->z;

        if (x0 < -FLOAT_TO_FX32(25.0))
        {
            if (x1 < -FLOAT_TO_FX32(144.0))
                outX = -FLOAT_TO_FX32(144.0);

            if (outZ > FLOAT_TO_FX32(118.0))
                outZ = FLOAT_TO_FX32(118.0);

            if (outZ < FLOAT_TO_FX32(71.0))
                outZ = FLOAT_TO_FX32(71.0);

            if (outZ < FLOAT_TO_FX32(77.0) && outX > -FLOAT_TO_FX32(62.0) && outX < -FLOAT_TO_FX32(38.0))
            {
                if (x0 <= -FLOAT_TO_FX32(62.0))
                {
                    outX = -FLOAT_TO_FX32(62.0);
                }
                else if (x0 >= -FLOAT_TO_FX32(38.0))
                {
                    outX = -FLOAT_TO_FX32(38.0);
                }
                else
                {
                    outZ = FLOAT_TO_FX32(77.0);
                }
            }
        }
        else
        {
            if (x0 > FLOAT_TO_FX32(25.0))
            {
                if (x1 > FLOAT_TO_FX32(144.0))
                    outX = FLOAT_TO_FX32(144.0);

                if (outZ > FLOAT_TO_FX32(118.0))
                    outZ = FLOAT_TO_FX32(118.0);

                if (outZ < FLOAT_TO_FX32(71.0))
                    outZ = FLOAT_TO_FX32(71.0);

                if (outZ < FLOAT_TO_FX32(77.0) && outX > FLOAT_TO_FX32(46.0) && outX < FLOAT_TO_FX32(70.0))
                {
                    if (x0 <= FLOAT_TO_FX32(46.0))
                    {
                        outX = FLOAT_TO_FX32(46.0);
                    }
                    else if (x0 >= FLOAT_TO_FX32(70.0))
                    {
                        outX = FLOAT_TO_FX32(70.0);
                    }
                    else
                    {
                        outZ = FLOAT_TO_FX32(77.0);
                    }
                }
            }
            else
            {
                if (z0 > FLOAT_TO_FX32(118.0))
                {
                    if (x1 < -FLOAT_TO_FX32(11.0))
                    {
                        if (outZ <= FLOAT_TO_FX32(124.0))
                        {
                            Unknown2051334__Func_2051450(x1, outZ, &outX, &outZ, -FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0), -FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0));
                        }
                        else
                        {
                            outX = -FLOAT_TO_FX32(11.0);
                        }
                    }

                    if (outX > FLOAT_TO_FX32(11.0))
                    {
                        if (outZ <= FLOAT_TO_FX32(124.0))
                        {
                            Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0), FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0));
                        }
                        else
                        {
                            outX = FLOAT_TO_FX32(11.0);
                        }
                    }

                    if (outZ > FLOAT_TO_FX32(134.0))
                        outZ = FLOAT_TO_FX32(134.0);
                }
                else
                {
                    if (z0 > FLOAT_TO_FX32(77.0))
                    {
                        if (outZ > FLOAT_TO_FX32(118.0))
                        {
                            if (x1 < -FLOAT_TO_FX32(17.0) || x1 > FLOAT_TO_FX32(17.0))
                            {
                                outZ = FLOAT_TO_FX32(118.0);
                            }
                            else
                            {
                                if (x1 < -FLOAT_TO_FX32(11.0))
                                {
                                    Unknown2051334__Func_2051450(x1, outZ, &outX, &outZ, -FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0), -FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0));
                                }
                                else if (x1 > FLOAT_TO_FX32(11.0))
                                {
                                    Unknown2051334__Func_2051450(x1, outZ, &outX, &outZ, FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0), FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0));
                                }
                            }
                        }
                    }
                    else
                    {
                        if (outZ < FLOAT_TO_FX32(49.0))
                        {
                            if (a5)
                                *a5 = TRUE;

                            outZ = FLOAT_TO_FX32(49.0);
                        }

                        BOOL flip = FALSE;
                        if (outX < 0)
                        {
                            outX = -outX;
                            flip = TRUE;
                        }

                        if (MultiplyFX(-FLOAT_TO_FX32(22.0), (outX - FLOAT_TO_FX32(25.0))) - MultiplyFX(-FLOAT_TO_FX32(16.0), (outZ - FLOAT_TO_FX32(71.0))) < 0)
                        {
                            Unknown2051334__Func_2051334(FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(71.0), FLOAT_TO_FX32(9.0), FLOAT_TO_FX32(49.0), outX, outZ, &outX, &outZ);
                        }

                        if (flip)
                            outX = -outX;
                    }
                }
            }
        }

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;
    }

    if (newPlayerPos->z <= FLOAT_TO_FX32(49.0))
    {
        if (isSailPrompt != NULL)
            *isSailPrompt = TRUE;
    }
    else
    {
        if (a5 != NULL)
            *a5 = FALSE;
    }

    return collided;
}

BOOL CViDockBack::Collide_Hover(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_HOVER;

    fx32 x1 = curPlayerPos->x;
    fx32 x0 = prevPlayerPos->x;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = x1;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 z0   = prevPlayerPos->z;
        fx32 outX = curPlayerPos->x;
        fx32 outZ = curPlayerPos->z;

        if (x0 < -FLOAT_TO_FX32(25.0))
        {
            if (x1 < -FLOAT_TO_FX32(124.0))
                outX = -FLOAT_TO_FX32(124.0);

            if (outZ > FLOAT_TO_FX32(118.0))
                outZ = FLOAT_TO_FX32(118.0);

            if (outZ < FLOAT_TO_FX32(71.0))
                outZ = FLOAT_TO_FX32(71.0);

            if (outZ < FLOAT_TO_FX32(77.0) && outX > -FLOAT_TO_FX32(62.0) && outX < -FLOAT_TO_FX32(38.0))
            {
                if (x0 <= -FLOAT_TO_FX32(62.0))
                {
                    outX = -FLOAT_TO_FX32(62.0);
                }
                else if (x0 >= -FLOAT_TO_FX32(38.0))
                {
                    outX = -FLOAT_TO_FX32(38.0);
                }
                else
                {
                    outZ = FLOAT_TO_FX32(77.0);
                }
            }
        }
        else
        {
            if (x0 > FLOAT_TO_FX32(25.0))
            {
                if (x1 > FLOAT_TO_FX32(84.0))
                    outX = FLOAT_TO_FX32(84.0);

                if (outZ > FLOAT_TO_FX32(118.0))
                    outZ = FLOAT_TO_FX32(118.0);

                if (outZ < FLOAT_TO_FX32(71.0))
                    outZ = FLOAT_TO_FX32(71.0);

                if (outZ < FLOAT_TO_FX32(77.0) && outX > FLOAT_TO_FX32(46.0) && outX < FLOAT_TO_FX32(70.0))
                {
                    if (x0 <= FLOAT_TO_FX32(46.0))
                    {
                        outX = FLOAT_TO_FX32(46.0);
                    }
                    else if (x0 >= FLOAT_TO_FX32(70.0))
                    {
                        outX = FLOAT_TO_FX32(70.0);
                    }
                    else
                    {
                        outZ = FLOAT_TO_FX32(77.0);
                    }
                }
            }
            else
            {
                if (z0 > FLOAT_TO_FX32(118.0))
                {
                    if (x1 < -FLOAT_TO_FX32(11.0))
                    {
                        if (outZ <= FLOAT_TO_FX32(124.0))
                        {
                            Unknown2051334__Func_2051450(x1, outZ, &outX, &outZ, -FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0), -FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0));
                        }
                        else
                        {
                            outX = -FLOAT_TO_FX32(11.0);
                        }
                    }

                    if (outX > FLOAT_TO_FX32(11.0))
                    {
                        if (outZ <= FLOAT_TO_FX32(124.0))
                        {
                            Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0), FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0));
                        }
                        else
                        {
                            outX = FLOAT_TO_FX32(11.0);
                        }
                    }

                    if (outZ > FLOAT_TO_FX32(134.0))
                        outZ = FLOAT_TO_FX32(134.0);
                }
                else
                {
                    if (z0 > FLOAT_TO_FX32(77.0))
                    {
                        if (outZ > FLOAT_TO_FX32(118.0))
                        {
                            if (x1 < -FLOAT_TO_FX32(17.0) || x1 > FLOAT_TO_FX32(17.0))
                            {
                                outZ = FLOAT_TO_FX32(118.0);
                            }
                            else
                            {
                                if (x1 < -FLOAT_TO_FX32(11.0))
                                {
                                    Unknown2051334__Func_2051450(x1, outZ, &outX, &outZ, -FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0), -FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0));
                                }
                                else if (x1 > FLOAT_TO_FX32(11.0))
                                {
                                    Unknown2051334__Func_2051450(x1, outZ, &outX, &outZ, FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(118.0), FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(124.0));
                                }
                            }
                        }
                    }
                    else
                    {
                        if (outZ < FLOAT_TO_FX32(49.0))
                        {
                            if (a5 != NULL)
                                *a5 = TRUE;

                            outZ = FLOAT_TO_FX32(49.0);
                        }

                        BOOL flip = FALSE;
                        if (outX < 0)
                        {
                            outX = -outX;
                            flip = TRUE;
                        }

                        if (MultiplyFX(-FLOAT_TO_FX32(22.0), (outX - FLOAT_TO_FX32(25.0))) - MultiplyFX(-FLOAT_TO_FX32(16.0), (outZ - FLOAT_TO_FX32(71.0))) < 0)
                        {
                            Unknown2051334__Func_2051334(FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(71.0), FLOAT_TO_FX32(9.0), FLOAT_TO_FX32(49.0), outX, outZ, &outX, &outZ);
                        }

                        if (flip)
                            outX = -outX;
                    }
                }
            }
        }

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;
    }

    if (newPlayerPos->z <= FLOAT_TO_FX32(49.0))
    {
        if (isSailPrompt != NULL)
            *isSailPrompt = TRUE;
    }
    else
    {
        if (a5 != NULL)
            *a5 = FALSE;
    }

    return collided;
}

NONMATCH_FUNC BOOL CViDockBack::Collide_Submarine(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    // https://decomp.me/scratch/Fgcs0 -> 91.21%
#ifdef NON_MATCHING
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_SUBMARINE;

    fx32 x1 = curPlayerPos->x;
    fx32 x0 = prevPlayerPos->x;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = curPlayerPos->x;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 z0   = prevPlayerPos->z;
        fx32 outX = curPlayerPos->x;
        fx32 outZ = curPlayerPos->z;

        if (z0 >= FLOAT_TO_FX32(30.0) && z0 <= FLOAT_TO_FX32(60.0))
            outZ = z0 + ((outZ - z0) >> 1);

        if (x0 < -FLOAT_TO_FX32(25.0))
        {
            if (outX < -FLOAT_TO_FX32(84.0))
                outX = -FLOAT_TO_FX32(84.0);

            if (outZ > FLOAT_TO_FX32(118.0))
                outZ = FLOAT_TO_FX32(118.0);

            if (outZ < FLOAT_TO_FX32(71.0))
                outZ = FLOAT_TO_FX32(71.0);

            if (outZ < FLOAT_TO_FX32(77.0) && outX > -FLOAT_TO_FX32(62.0) && outX < -FLOAT_TO_FX32(38.0))
            {
                if (x0 <= -FLOAT_TO_FX32(62.0))
                {
                    outX = -FLOAT_TO_FX32(62.0);
                }
                else if (x0 >= -FLOAT_TO_FX32(38.0))
                {
                    outX = -FLOAT_TO_FX32(38.0);
                }
                else
                {
                    outZ = FLOAT_TO_FX32(77.0);
                }
            }
        }
        else
        {
            if (x0 > FLOAT_TO_FX32(25.0))
            {
                if (outX > FLOAT_TO_FX32(84.0))
                    outX = FLOAT_TO_FX32(84.0);

                if (outZ > FLOAT_TO_FX32(118.0))
                    outZ = FLOAT_TO_FX32(118.0);

                if (outZ < FLOAT_TO_FX32(71.0))
                    outZ = FLOAT_TO_FX32(71.0);

                if (outZ < FLOAT_TO_FX32(77.0) && outX > FLOAT_TO_FX32(46.0) && outX < FLOAT_TO_FX32(70.0))
                {
                    if (x0 <= FLOAT_TO_FX32(46.0))
                    {
                        outX = FLOAT_TO_FX32(46.0);
                    }
                    else if (x0 >= FLOAT_TO_FX32(70.0))
                    {
                        outX = FLOAT_TO_FX32(70.0);
                    }
                    else
                    {
                        outZ = FLOAT_TO_FX32(77.0);
                    }
                }
            }
            else
            {
                if (z0 > FLOAT_TO_FX32(118.0))
                {
                    if (outX < -FLOAT_TO_FX32(9.0))
                    {
                        if (outZ <= FLOAT_TO_FX32(124.0))
                        {
                            Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(9.0), FLOAT_TO_FX32(124.0), -FLOAT_TO_FX32(14.0), FLOAT_TO_FX32(118.0));
                        }
                        else
                        {
                            outX = -FLOAT_TO_FX32(9.0);
                        }
                    }

                    if (outX > FLOAT_TO_FX32(9.0))
                    {
                        if (outZ <= FLOAT_TO_FX32(124.0))
                        {
                            Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(14.0), FLOAT_TO_FX32(118.0), FLOAT_TO_FX32(9.0), FLOAT_TO_FX32(124.0));
                        }
                        else
                        {
                            outX = FLOAT_TO_FX32(9.0);
                        }
                    }

                    if (outZ > FLOAT_TO_FX32(134.0))
                        outZ = FLOAT_TO_FX32(134.0);
                }
                else
                {
                    if (z0 > FLOAT_TO_FX32(77.0))
                    {
                        if (outZ > FLOAT_TO_FX32(118.0))
                        {
                            if (outX < -FLOAT_TO_FX32(14.0) || outX > FLOAT_TO_FX32(14.0))
                            {
                                outZ = FLOAT_TO_FX32(118.0);
                            }
                            else
                            {
                                if (outX < -FLOAT_TO_FX32(9.0))
                                {
                                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(9.0), FLOAT_TO_FX32(124.0), -FLOAT_TO_FX32(14.0), FLOAT_TO_FX32(118.0));
                                }
                                else if (outX > FLOAT_TO_FX32(9.0))
                                {
                                    Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, FLOAT_TO_FX32(14.0), FLOAT_TO_FX32(118.0), FLOAT_TO_FX32(9.0), FLOAT_TO_FX32(124.0));
                                }
                            }
                        }
                    }
                    else
                    {
                        if (z0 < FLOAT_TO_FX32(71.0))
                        {
                            if (outX < -FLOAT_TO_FX32(10.0))
                                outX = -FLOAT_TO_FX32(10.0);

                            if (outX > FLOAT_TO_FX32(10.0))
                                outX = FLOAT_TO_FX32(10.0);

                            if (outZ < FLOAT_TO_FX32(10.0))
                            {
                                if (a5 != NULL)
                                    *a5 = TRUE;

                                outZ = FLOAT_TO_FX32(10.0);
                            }
                        }
                        else
                        {
                            if ((outX < -FLOAT_TO_FX32(10.0) || outX > FLOAT_TO_FX32(10.0)) && outZ < FLOAT_TO_FX32(71.0))
                                outZ = FLOAT_TO_FX32(71.0);
                        }
                    }
                }
            }
        }

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;
    }

    if (newPlayerPos->z <= FLOAT_TO_FX32(10.0))
    {
        if (isSailPrompt != NULL)
            *isSailPrompt = TRUE;
    }
    else
    {
        if (a5 != NULL)
            *a5 = FALSE;
    }

    return collided;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	ldr r5, [sp, #0x30]
	mov r7, r2
	movs r6, r3
	mov r4, #0
	strne r4, [r6]
	ldr r2, [sp, #0x34]
	mov r8, r1
	cmp r5, #0
	movne r1, #0
	strne r1, [r5]
	cmp r2, #0
	movne r1, #5
	strne r1, [r2]
	ldr ip, [r8]
	ldr r1, [r0, #0]
	cmp r1, ip
	ldreq r3, [r0, #4]
	ldreq r2, [r8, #4]
	cmpeq r3, r2
	ldreq r3, [r0, #8]
	ldreq r2, [r8, #8]
	cmpeq r3, r2
	bne _02165DDC
	str ip, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [r8, #8]
	str r0, [r7, #8]
	b _02166124
_02165DDC:
	ldr r3, [r0, #8]
	str ip, [sp, #0x14]
	ldr r0, [r8, #8]
	cmp r3, #0x1e000
	str r0, [sp, #0x10]
	blt _02165E04
	cmp r3, #0x3c000
	suble r0, r0, r3
	addle r0, r3, r0, asr #1
	strle r0, [sp, #0x10]
_02165E04:
	mov r2, #0x19000
	rsb r2, r2, #0
	cmp r1, r2
	bge _02165E90
	ldr r3, [sp, #0x14]
	sub r0, r2, #0x3b000
	cmp r3, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x4d000
	bge _021660E4
	mov r2, #0x3e000
	ldr r3, [sp, #0x14]
	rsb r2, r2, #0
	cmp r3, r2
	ble _021660E4
	add r0, r2, #0x18000
	cmp r3, r0
	bge _021660E4
	cmp r1, r2
	strle r2, [sp, #0x14]
	ble _021660E4
	cmp r1, r0
	strge r0, [sp, #0x14]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x10]
	b _021660E4
_02165E90:
	cmp r1, #0x19000
	ble _02165F10
	ldr r0, [sp, #0x14]
	cmp r0, #0x54000
	movgt r0, #0x54000
	strgt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x4d000
	bge _021660E4
	ldr r0, [sp, #0x14]
	cmp r0, #0x2e000
	ble _021660E4
	cmp r0, #0x46000
	bge _021660E4
	cmp r1, #0x2e000
	movle r0, #0x2e000
	strle r0, [sp, #0x14]
	ble _021660E4
	cmp r1, #0x46000
	movge r0, #0x46000
	strge r0, [sp, #0x14]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x10]
	b _021660E4
_02165F10:
	cmp r3, #0x76000
	ble _02165FC8
	ldr r0, [sp, #0x14]
	add r1, r2, #0x10000
	cmp r0, r1
	bge _02165F68
	ldr r1, [sp, #0x10]
	cmp r1, #0x7c000
	addgt r0, r2, #0x10000
	strgt r0, [sp, #0x14]
	bgt _02165F68
	add r3, r2, #0x10000
	mov r2, #0x7c000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x8a000
	str ip, [sp, #8]
	mov ip, #0x76000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165F68:
	ldr r0, [sp, #0x14]
	cmp r0, #0x9000
	ble _02165FB4
	ldr r1, [sp, #0x10]
	cmp r1, #0x7c000
	movgt r0, #0x9000
	strgt r0, [sp, #0x14]
	bgt _02165FB4
	mov r2, #0xe000
	str r2, [sp]
	mov r2, #0x76000
	str r2, [sp, #4]
	mov ip, #0x9000
	str ip, [sp, #8]
	mov ip, #0x7c000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165FB4:
	ldr r0, [sp, #0x10]
	cmp r0, #0x86000
	movgt r0, #0x86000
	strgt r0, [sp, #0x10]
	b _021660E4
_02165FC8:
	cmp r3, #0x4d000
	ble _02166070
	ldr r1, [sp, #0x10]
	cmp r1, #0x76000
	ble _021660E4
	ldr r0, [sp, #0x14]
	add r3, r2, #0xb000
	cmp r0, r3
	blt _02165FF4
	cmp r0, #0xe000
	ble _02166000
_02165FF4:
	mov r0, #0x76000
	str r0, [sp, #0x10]
	b _021660E4
_02166000:
	add r3, r2, #0x10000
	cmp r0, r3
	bge _02166038
	mov r2, #0x7c000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x8a000
	str ip, [sp, #8]
	mov ip, #0x76000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _021660E4
_02166038:
	cmp r0, #0x9000
	ble _021660E4
	mov r2, #0xe000
	str r2, [sp]
	mov r2, #0x76000
	str r2, [sp, #4]
	mov ip, #0x9000
	str ip, [sp, #8]
	mov ip, #0x7c000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _021660E4
_02166070:
	cmp r3, #0x47000
	bge _021660BC
	ldr r1, [sp, #0x14]
	add r0, r2, #0xf000
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	cmp r0, #0xa000
	movgt r0, #0xa000
	strgt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0xa000
	bge _021660E4
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
	mov r0, #0xa000
	str r0, [sp, #0x10]
	b _021660E4
_021660BC:
	ldr r1, [sp, #0x14]
	add r0, r2, #0xf000
	cmp r1, r0
	blt _021660D4
	cmp r1, #0xa000
	ble _021660E4
_021660D4:
	ldr r0, [sp, #0x10]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x10]
_021660E4:
	ldr r0, [sp, #0x14]
	str r0, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [sp, #0x10]
	str r0, [r7, #8]
	ldr r1, [r7, #0]
	ldr r0, [r8, #0]
	cmp r1, r0
	ldreq r1, [r7, #4]
	ldreq r0, [r8, #4]
	cmpeq r1, r0
	ldreq r1, [r7, #8]
	ldreq r0, [r8, #8]
	cmpeq r1, r0
	movne r4, #1
_02166124:
	ldr r0, [r7, #8]
	cmp r0, #0xa000
	bgt _02166140
	cmp r6, #0
	movne r0, #1
	strne r0, [r6]
	b _0216614C
_02166140:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
_0216614C:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

BOOL CViDockBack::Collide_Beach(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area)
{
    BOOL collided = FALSE;

    if (isSailPrompt != NULL)
        *isSailPrompt = FALSE;

    if (a5 != NULL)
        *a5 = FALSE;

    if (area != NULL)
        *area = DOCKAREA_BEACH;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
    {
        newPlayerPos->x = curPlayerPos->x;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = curPlayerPos->z;
    }
    else
    {
        fx32 outX = curPlayerPos->x;
        fx32 outZ = curPlayerPos->z;

        if (outX < FLOAT_TO_FX32(17.0) && outZ > FLOAT_TO_FX32(10.0) && outZ < FLOAT_TO_FX32(18.0))
        {
            if (outZ < FLOAT_TO_FX32(14.0))
                Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(14.0), -FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(10.0));
            else
                Unknown2051334__Func_2051450(outX, outZ, &outX, &outZ, -FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(18.0), -FLOAT_TO_FX32(17.0), FLOAT_TO_FX32(14.0));
        }

        if (outZ < FLOAT_TO_FX32(7.0))
            outZ = FLOAT_TO_FX32(7.0);

        if (outX > FLOAT_TO_FX32(20.0))
            outX = FLOAT_TO_FX32(20.0);

        if (outX < -FLOAT_TO_FX32(20.0))
            outX = -FLOAT_TO_FX32(20.0);

        newPlayerPos->x = outX;
        newPlayerPos->y = curPlayerPos->y;
        newPlayerPos->z = outZ;

        if (newPlayerPos->x != curPlayerPos->x || newPlayerPos->y != curPlayerPos->y || newPlayerPos->z != curPlayerPos->z)
            collided = TRUE;
    }

    return collided;
}

BOOL CViDockBack::CheckExitArea_Base(const VecFx32 *pos)
{
    return pos->z >= FLOAT_TO_FX32(24.0);
}

BOOL CViDockBack::CheckExitArea_BaseNext(const VecFx32 *pos)
{
    return FALSE;
}

BOOL CViDockBack::CheckExitArea_Jet(const VecFx32 *pos)
{
    return pos->z >= FLOAT_TO_FX32(80.0);
}

BOOL CViDockBack::CheckExitArea_Boat(const VecFx32 *pos)
{
    return pos->z >= FLOAT_TO_FX32(126.0);
}

BOOL CViDockBack::CheckExitArea_Hover(const VecFx32 *pos)
{
    return pos->z >= FLOAT_TO_FX32(126.0);
}

BOOL CViDockBack::CheckExitArea_Submarine(const VecFx32 *pos)
{
    return pos->z >= FLOAT_TO_FX32(126.0);
}

BOOL CViDockBack::CheckExitArea_Beach(const VecFx32 *pos)
{
    return pos->z >= FLOAT_TO_FX32(62.0);
}

void CViDockBack::PlayerSpawnConfig_Base(VecFx32 *position, u16 *angle, s32 area)
{
    if (area == 1)
    {
        position->x = FLOAT_TO_FX32(20.0);
        position->y = FLOAT_TO_FX32(0.0);
        position->z = FLOAT_TO_FX32(0.5);

        *angle = FLOAT_DEG_TO_IDX(270.0);
    }
    else
    {
        position->x = FLOAT_TO_FX32(0.0);
        position->y = FLOAT_TO_FX32(0.0);
        position->z = FLOAT_TO_FX32(19.0);

        *angle = FLOAT_DEG_TO_IDX(180.0);
    }
}

void CViDockBack::PlayerSpawnConfig_BaseNext(VecFx32 *position, u16 *angle, s32 area)
{
    position->x = -FLOAT_TO_FX32(16.0);
    position->y = FLOAT_TO_FX32(0.0);
    position->z = FLOAT_TO_FX32(0.0);

    *angle = FLOAT_DEG_TO_IDX(90.0);
}

void CViDockBack::PlayerSpawnConfig_Jet(VecFx32 *position, u16 *angle, s32 area)
{
    position->x = -FLOAT_TO_FX32(30.0);
    position->y = FLOAT_TO_FX32(0.0);
    position->z = FLOAT_TO_FX32(70.0);

    *angle = FLOAT_DEG_TO_IDX(180.0);
}

void CViDockBack::PlayerSpawnConfig_Boat(VecFx32 *position, u16 *angle, s32 area)
{
    position->x = FLOAT_TO_FX32(0.0);
    position->y = FLOAT_TO_FX32(0.0);
    position->z = FLOAT_TO_FX32(110.0);

    *angle = FLOAT_DEG_TO_IDX(180.0);
}

void CViDockBack::PlayerSpawnConfig_Hover(VecFx32 *position, u16 *angle, s32 area)
{
    position->x = FLOAT_TO_FX32(0.0);
    position->y = FLOAT_TO_FX32(0.0);
    position->z = FLOAT_TO_FX32(110.0);

    *angle = FLOAT_DEG_TO_IDX(180.0);
}

void CViDockBack::PlayerSpawnConfig_Submarine(VecFx32 *position, u16 *angle, s32 area)
{
    position->x = FLOAT_TO_FX32(0.0);
    position->y = FLOAT_TO_FX32(0.0);
    position->z = FLOAT_TO_FX32(110.0);

    *angle = FLOAT_DEG_TO_IDX(180.0);
}

void CViDockBack::PlayerSpawnConfig_Beach(VecFx32 *position, u16 *angle, s32 area)
{
    position->x = FLOAT_TO_FX32(0.0);
    position->y = FLOAT_TO_FX32(0.0);
    position->z = FLOAT_TO_FX32(55.0);

    *angle = FLOAT_DEG_TO_IDX(180.0);
}

fx32 CViDockBack::GetGroundPos_Common(const VecFx32 *pos)
{
    return FLOAT_TO_FX32(0.0);
}

fx32 CViDockBack::GetGroundPos_Submarine(const VecFx32 *pos)
{
    if (pos->z >= FLOAT_TO_FX32(60.0))
        return FLOAT_TO_FX32(0.0);

    if (pos->z >= FLOAT_TO_FX32(30.0))
        return FX_DivS32(26 * (FLOAT_TO_FX32(60.0) - pos->z), 30);

    return FLOAT_TO_FX32(26.0);
}

void CViDockBack::DrawShadow_Common(CViShadow *work, fx32 scale, fx32 x, fx32 z)
{
    work->scale = scale;

    VecFx32 position;
    position.x = x;
    position.y = FLOAT_TO_FX32(0.0);
    position.z = z;

    position.y = CViDockBack::GetGroundPos_Common(&position);

    work->Draw(position);
}

void CViDockBack::DrawShadow_Submarine(CViShadow *work, fx32 scale, fx32 x, fx32 z)
{
    work->scale = scale;

    VecFx32 position;
    position.x = x;
    position.y = FLOAT_TO_FX32(0.0);
    position.z = z;

    position.y = CViDockBack::GetGroundPos_Submarine(&position);

    work->Draw(position);
}

void CViDockBack::ThreadFunc(void *arg)
{
    CViDockBack::ThreadWorker *work = (CViDockBack::ThreadWorker *)arg;

    u32 prio = CARD_SetThreadPriority(20);
    work->parent->Init(work->area, TRUE, FALSE);
    CARD_SetThreadPriority(prio);
}