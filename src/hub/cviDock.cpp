#include <hub/cviDock.hpp>
#include <hub/cviMapIcon.hpp>
#include <hub/hubConfig.h>
#include <hub/hubState.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <hub/hubAudio.h>
#include <hub/hubControl.hpp>
#include <game/graphics/unknown2056570.h>
#include <game/file/fileUnknown.h>
#include <seaMap/seaMapManager.h>
#include <game/math/unknown2051334.h>

// resources
#include <resources/bb/vi_msg/vi_msg_eng.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN15CViDockNpcGroupC1Ev(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry(void);
NOT_DECOMPILED void _ZnwmPv(void);
NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZN10HubControl12TouchEnabledEv(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup4DrawER7VecFx32(void);
NOT_DECOMPILED void _ZN11CVi3dObject4DrawEv(void);

NOT_DECOMPILED void _ZN11CViDockBack8DrawDockEttt(void);
NOT_DECOMPILED void _ZN11CViDockBack10DrawShadowEP9CViShadowlll(void);

NOT_DECOMPILED void _ZN13CViDockPlayer12SetMoveAngleEti(void);

NOT_DECOMPILED void _ZNK8CVector317ToConstVecFx32RefEv(void);
NOT_DECOMPILED void _ZN8CVector39MagnitudeEPlPKS_(void);
NOT_DECOMPILED void _ZN8CVector39NormalizeEv(void);

NOT_DECOMPILED void _ZN8CVector3C1Ev(void);

NOT_DECOMPILED void _ZN13CViDockCamera15SetDrawPipelineEv(CViDockCamera *work);
}

// --------------------
// VARIABLES
// --------------------

static Task *taskSingleton;

// static const u16 ovl05_02172EB4[] = { 224, 111, 247, 123, 255, 127, 247, 123 };
NOT_DECOMPILED const u16 ovl05_02172EB4[];

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckTouchPushEnabled()
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_PUSH(touchInput.flags))
            return TRUE;
    }

    return FALSE;
}

// --------------------
// FUNCTION DECLS
// --------------------

static Task *CViDock__CreateInternal(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group);
static void CViDock__DestroyInternal(Task *task);

// --------------------
// FUNCTIONS
// --------------------

void CViDock::Create(void)
{
    // TODO: use 'HubTaskCreate' when 'CViDock__CreateInternal' matches
    // taskSingleton = HubTaskCreate(CViDock::Main_Init, CViDock::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1030, TASK_GROUP(16), CViDock);
    taskSingleton = CViDock__CreateInternal(CViDock::Main_Init, CViDock::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1030, TASK_GROUP(16));

    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->area                = CViDock::AREA_INVALID;
    work->type                = CViDock::TYPE_INVALID;
    work->nextArea            = CViDock::AREA_INVALID;
    work->playerInputEnabled  = FALSE;
    work->nextAreaLoaded      = FALSE;
    work->charactersEnabled   = TRUE;
    work->talkActionType      = CVIDOCKNPCTALK_INVALID;
    work->talkActionParam     = 0;
    work->talkNpc             = 0;
    work->field_1470          = 0;
    work->environmentSfxTimer = 0;
    work->isThreadBusy        = FALSE;
    InitThreadWorker(&work->thread, 0x1000);
    CViDock::Init(work);
}

// TODO: should match when constructors are decompiled for 'CViDockPlayer' 'CViDockNpcGroup', 'CViShadow' && 'CViDockBack'
NONMATCH_FUNC Task *CViDock__CreateInternal(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	ldr r4, =0x00001BF8
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, r4
	bl _ZnwmPv
	movs r4, r0
	beq _0215DB8C
	add r0, r4, #0xf8
	bl _ZN11CViDockBackC1Ev
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	bl _ZN13CViDockPlayerC1Ev
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroupC1Ev
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadowC1Ev
_0215DB8C:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void CViDock::Destroy(void)
{
    if (taskSingleton != NULL)
    {
        DestroyTask(taskSingleton);
        taskSingleton = NULL;
    }
}

void CViDock::InitForPlayerControl(s32 area)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDock::ReleaseUnknown(work);
    CViDock::ReleaseFontWindow(work);
    CViDock::ReleaseNpcGroup(work);
    CViDock::ReleaseDockDrawState(work);
    CViDock::ReleaseDockBack(work);

    work->area     = area;
    work->type     = CViDock::TYPE_DOCK;
    work->nextArea = area;

    CViDock::InitPlayer(work, CViDock::AREA_INVALID);
    CViDock::InitDockBack(work, FALSE);
    CViDock::InitDockCamera(work);
    CViDock::InitNpcs(work);

    work->shadow.alpha        = HubConfig__GetDockStageConfig(work->area)->shadowAlpha;
    work->environmentSfxTimer = 0;

    work->camera.SetType(CViDockCamera::TYPE_DOCK);

    SetTaskMainEvent(taskSingleton, CViDock::Main_PlayerActive);
}

void CViDock::InitForDockChange(s32 nextArea, s32 area)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDock::InitForInactive();

    if (area >= CViDock::AREA_COUNT)
        area = nextArea;

    work->area                = area;
    work->nextArea            = nextArea;
    work->type                = CViDock::TYPE_DOCK;
    work->environmentSfxTimer = 0;
    work->isThreadBusy        = TRUE;

    CreateThreadWorker(&work->thread, CViDock::ThreadFunc, work, 24);
    SetTaskMainEvent(taskSingleton, CViDock::Main_ChangingArea);
}

BOOL CViDock::CheckThreadIdle(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    return work->isThreadBusy == FALSE;
}

void CViDock::ReturnPlayerControl(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->camera.SetType(CViDockCamera::TYPE_DOCK);

    SetTaskMainEvent(taskSingleton, CViDock::Main_PlayerActive);
}

void CViDock::InitForPreview(DockArea dockArea, BOOL waitForLoad)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDock::ReleaseUnknown(work);
    CViDock::ReleaseFontWindow(work);
    CViDock::ReleaseNpcGroup(work);
    CViDock::ReleaseDockDrawState(work);
    CViDock::ReleaseDockBack(work);

    work->area                = dockArea;
    work->type                = CViDock::TYPE_PREVIEW;
    work->nextArea            = CViDock::AREA_INVALID;
    work->environmentSfxTimer = 0;

    if (!waitForLoad)
    {
        CViDock::InitDockBack(work, FALSE);
        CViDock::InitDockCamera(work);
    }

    work->shadow.alpha = HubConfig__GetDockStageConfig(work->area)->shadowAlpha;
    work->camera.SetType(CViDockCamera::TYPE_PREVIEW);

    if (waitForLoad)
    {
        SetTaskMainEvent(taskSingleton, CViDock::Main_InitForPreviewDockChange);
        work->nextAreaLoaded = FALSE;
    }
    else
    {
        SetTaskMainEvent(taskSingleton, CViDock::Main_DockPreview);
    }
}

void CViDock::InitForConstructionCutscene(s32 area)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDock::ReleaseUnknown(work);
    CViDock::ReleaseFontWindow(work);
    CViDock::ReleaseNpcGroup(work);
    CViDock::ReleaseDockDrawState(work);
    CViDock::ReleaseDockBack(work);

    work->area                = area;
    work->type                = CViDock::TYPE_CONSTRUCTION_CUTSCENE;
    work->nextArea            = CViDock::AREA_INVALID;
    work->environmentSfxTimer = 0;

    CViDock::InitDockCamera(work);
    CViDock::InitDockBack(work, TRUE);

    work->rotationY = 0;

    CViDock::InitShipConstructCompletedMessage(work);
    CViDock::InitShipConstructedBG(work);
    work->camera.SetType(CViDockCamera::TYPE_CONSTRUCTION_CUTSCENE);
    SetTaskMainEvent(taskSingleton, CViDock::Main_UpgradeShipSpin);
}

void CViDock::InitForInactive(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->environmentSfxTimer = 0;

    CViDock::ReleaseUnknown(work);
    CViDock::ReleaseFontWindow(work);
    CViDock::ReleaseNpcGroup(work);
    CViDock::ReleaseDockDrawState(work);
    CViDock::ReleaseDockBack(work);

    work->area     = CViDock::AREA_INVALID;
    work->type     = CViDock::TYPE_INVALID;
    work->nextArea = CViDock::AREA_INVALID;

    SetTaskMainEvent(taskSingleton, NULL);
}

void CViDock::EnablePlayerInput(BOOL enabled)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->playerInputEnabled = enabled;
}

void CViDock::DrawShipConstructionFontWindow(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDock::DrawFontWindow(work);
}

BOOL CViDock::DidExitArea(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    if (work->disableExitArea)
        return FALSE;

    return work->dockBack.DidExitArea(work->player.position.ToConstVecFx32Ref());
}

s32 CViDock::GetNextArea(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    return work->nextArea;
}

BOOL CViDock::HasActiveTalkAction(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    return work->talkActionType < CVIDOCKNPCTALK_COUNT;
}

void CViDock::GetTalkActionFromTalkingNpc(s32 *type, s32 *param)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    if (type != NULL)
        *type = work->talkActionType;

    if (param != NULL)
        *param = work->talkActionParam;
}

s32 CViDock::GetTalkingNpcTalkCount(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDockNpc *npc = work->talkNpc;
    if (npc != NULL)
        return npc->talkCount;

    return 0;
}

void CViDock::DecrementTalkingNpcTalkCount(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDockNpc *npc = work->talkNpc;
    if (npc != NULL && npc->talkCount != 0)
        npc->talkCount--;
}

s32 CViDock::GetTalkingNpc(void)
{
    if (taskSingleton == NULL)
        return CVIDOCK_NPC_INVALID;

    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    CViDockNpc *npc = work->talkNpc;
    if (npc == NULL)
        return CVIDOCK_NPC_INVALID;

    return npc->npcType;
}

void CViDock::SetTalkingNpc(s32 id)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    const HubNpcSpawnConfig *config = HubConfig__GetNpcConfig(id);

    u16 type = config->type;

    CViDockNpcGroupEntry *entry = work->npcGroup.npcListStart;

    // ???
    if (entry == NULL)
        entry = NULL;

    while (entry != NULL)
    {
        if (type == entry->npc.type)
        {
            work->talkNpc = &entry->npc;
            return;
        }

        entry = work->npcGroup.GetNextNpc(entry);
    }
}

void CViDock::StartTalkingToNpc(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->field_1470         = 1;
    work->movedCamForNpcTalk = FALSE;
    work->player.AllowBored(FALSE);

    if (work->talkNpc != NULL)
    {
        CVector3 playerPos = work->player.position.ToConstVecFx32Ref();
        CVector3 npcPos    = work->talkNpc->position.ToConstVecFx32Ref();

        CVector3 camTarget;
        CVector3 camDirection;

        camTarget = (playerPos - npcPos).Normalize();

        u16 angle = Math__Func_207B1A4(camTarget.z);

        BOOL flag = camTarget.x < 0;
        if (flag)
            angle = 0x10000 - angle;

        work->talkNpc->SetAngleForTalking(angle);
        work->player.SetTurnAngle(angle - 0x7FFF, FALSE);

        camDirection = (npcPos - playerPos);

        camTarget.x = camDirection.x >> 1;
        camTarget.y = camDirection.y >> 1;
        camTarget.z = camDirection.z >> 1;
        camTarget += playerPos;
        camDirection.Normalize();

        work->camTarget    = camTarget.ToVecFx32Ref();
        work->camDirection = camDirection.ToVecFx32Ref();
    }

    SetTaskMainEvent(taskSingleton, CViDock::Main_TalkActive);
}

void CViDock::MoveCameraForNpcTalk(BOOL a1, BOOL a2)
{
    if (taskSingleton == NULL)
        return;

    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    if (work->field_1470 != 0 && work->talkNpc != 0)
    {
        if (work->type != CViDock::TYPE_DOCK || work->area >= CViDock::AREA_COUNT || !HubConfig__GetDockStageConfig(work->area)->allowTalkNpcCameraMove)
            a1 = FALSE;

        if (a1)
        {
            work->camera.MoveToPosition(&work->camTarget, 32, &work->camDirection, HubConfig__GetDockStageConfig(work->area)->scale, a2);
        }
        else
        {
            work->camera.ReturnToInitialPosition(32);
        }

        work->movedCamForNpcTalk = a1;
    }
}

void CViDock::FinishTalkingToNpc(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->field_1470 = 0;

    CViDockNpc *npc = work->talkNpc;
    if (npc != NULL)
    {
        npc->SetAngleForIdle();

        if (work->movedCamForNpcTalk)
            work->camera.ReturnToInitialPosition(32);
    }
    work->talkActionType  = CVIDOCKNPCTALK_INVALID;
    work->talkActionParam = 0;
    work->talkNpc         = NULL;

    work->player.AllowBored(TRUE);
    SetTaskMainEvent(taskSingleton, CViDock::Main_PlayerActive);
}

BOOL CViDock::CheckNextDockAreaLoaded(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    return work->nextAreaLoaded;
}

void CViDock::SetCharactersEnabled(BOOL enabled)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->charactersEnabled = enabled;
}

void CViDock::SaveCharacterStates(void)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    u16 playerAngle          = work->player.currentTurnAngle;
    const VecFx32 &playerPos = work->player.position.ToConstVecFx32Ref();
    HubState__SetPlayerState(0, &playerPos, playerAngle);

    CViDockNpcGroupEntry *entry = work->npcGroup.GetFirstNpc();

    u16 id = 0;
    while (entry != NULL)
    {
        u16 npcAngle          = entry->npc.currentTurnAngle;
        s32 npcTalkCount      = entry->npc.talkCount;
        const VecFx32 &npcPos = entry->npc.position.ToConstVecFx32Ref();
        HubState__SetNpcState(id, &npcPos, npcAngle, npcTalkCount);

        entry = work->npcGroup.GetNextNpc(entry);
        id++;
    }
}

void CViDock::LoadCharacterStates(BOOL loadAngle)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    if (HubState__CheckHasPlayerState(0))
    {
        work->player.position         = *HubState__GetPlayerPosition(0);
        work->player.targetTurnAngle  = HubState__GetPlayerAngle(0);
        work->player.currentTurnAngle = work->player.targetTurnAngle;
    }

    CViDockNpcGroupEntry *entry = work->npcGroup.GetFirstNpc();

    u16 id = 0;
    while (entry != NULL)
    {
        if (HubState__CheckHasNpcState(id))
        {
            entry->npc.position = *HubState__GetNpcPosition(id);

            if (loadAngle)
                entry->npc.targetTurnAngle = HubState__GetNpcAngle(id);

            entry->npc.talkCount = HubState__GetNpcTalkCount(id);
        }

        entry = work->npcGroup.GetNextNpc(entry);
        id++;
    }
}

void CViDock::DisableExitArea(BOOL areaExitDisabled)
{
    CViDock *work = TaskGetWork(taskSingleton, CViDock);

    work->disableExitArea = areaExitDisabled;
}

void CViDock::Init(CViDock *work)
{
    CViDock::InitPlayer(work, CViDock::AREA_INVALID);
    CViDock::InitDockBack(work, FALSE);
    CViDock::InitDockCamera(work);
    CViDock::InitNpcs(work);
    work->shadow.Init();

    FontWindowAnimator__Init(&work->fontWindowAnimator);
    FontAnimator__Init(&work->fontAnimator);

    work->inSailPromptRange = FALSE;
    work->nextAreaLoaded    = TRUE;
    work->disableExitArea   = FALSE;
}

void CViDock::Release(CViDock *work)
{
    ReleaseThreadWorker(&work->thread);

    work->isThreadBusy = FALSE;

    work->shadow.Release();

    CViDock::ReleaseUnknown(work);
    CViDock::ReleaseFontWindow(work);
    CViDock::ReleaseNpcGroup(work);
    CViDock::ReleaseDockDrawState(work);
    CViDock::ReleaseDockBack(work);
    CViDock::ReleasePlayer(work);

    work->inSailPromptRange = FALSE;
    work->nextAreaLoaded    = FALSE;
}

void CViDock::InitPlayer(CViDock *work, s32 area)
{
    work->player.Init();

    if (work->area < CViDock::AREA_COUNT)
    {
        VecFx32 position;
        u16 angle;
        if (work->type == CViDock::TYPE_DOCK)
        {
            CViDockBack::GetPlayerSpawnConfig(work->area, &position, &angle, area);
        }
        else
        {
            position.x = position.y = position.z = 0;
            angle                                = 0;
        }

        work->player.position = position;
        work->player.SetTurnAngle(angle, TRUE);

        position.x = position.y = position.z = HubConfig__GetDockStageConfig(work->area)->scale;
        work->player.scale                   = position;

        work->player.SetTopSpeed(HubConfig__GetDockStageConfig(work->area)->playerTopSpeed);
    }
}

void CViDock::ReleasePlayer(CViDock *work)
{
    work->player.Release();
}

NONMATCH_FUNC void CViDock::HandlePlayerMovement(CViDock *work)
{
    // https://decomp.me/scratch/t8Mfr -> 98.94%
#ifdef NON_MATCHING
    if (work->playerInputEnabled)
    {
        BOOL isMoving  = FALSE;
        BOOL isRunning = FALSE;
        s32 angle;

        BOOL touchEnabled = IsTouchInputEnabled() && TOUCH_HAS_ON(touchInput.flags);
        if (touchEnabled && HubControl::TouchEnabled())
        {
            CVector3 vec;

            u16 onX = touchInput.on.x;
            u16 onY = touchInput.on.y;

            int px;
            int py;
            NNS_G3dWorldPosToScrPos(&work->player.position.ToConstVecFx32Ref(), &px, &py);

            vec.x = FX32_FROM_WHOLE(onX - px);
            vec.y = FX32_FROM_WHOLE(onY - py);
            vec.z = 0;

            if (MATH_ABS(vec.x) > FLOAT_TO_FX32(64.0) || MATH_ABS(vec.y) > FLOAT_TO_FX32(48.0))
                isRunning = TRUE;

            s32 magnitude;
            CVector3::Magnitude(&magnitude, &vec);
            if (FX32_TO_WHOLE(magnitude) >= 4)
            {
                vec.Normalize();
                angle    = FX_Atan2Idx(vec.x, vec.y);
                isMoving = TRUE;
            }
        }

        if (isMoving == FALSE)
        {
            if ((padInput.btnDown & PAD_KEY_UP) != 0)
            {
                if ((padInput.btnDown & PAD_KEY_LEFT) != 0)
                {
                    angle = FLOAT_DEG_TO_IDX(225.0);
                }
                else if ((padInput.btnDown & PAD_KEY_RIGHT) != 0)
                {
                    angle = FLOAT_DEG_TO_IDX(135.0);
                }
                else
                {
                    angle = FLOAT_DEG_TO_IDX(180.0);
                }
            }
            else if ((padInput.btnDown & PAD_KEY_DOWN) != 0)
            {
                if ((padInput.btnDown & PAD_KEY_LEFT) != 0)
                {
                    angle = FLOAT_DEG_TO_IDX(315.0);
                }
                else if ((padInput.btnDown & PAD_KEY_RIGHT) != 0)
                {
                    angle = FLOAT_DEG_TO_IDX(45.0);
                }
                else
                {
                    angle = FLOAT_DEG_TO_IDX(0.0);
                }
            }
            else
            {
                if ((padInput.btnDown & PAD_KEY_LEFT) != 0)
                {
                    angle = FLOAT_DEG_TO_IDX(270.0);
                }
                else if ((padInput.btnDown & PAD_KEY_RIGHT) != 0)
                {
                    angle = FLOAT_DEG_TO_IDX(90.0);
                }
                else
                {
                    angle = -1;
                }
            }

            if (angle >= 0)
            {
                isMoving = TRUE;
                if ((padInput.btnDown & PAD_BUTTON_B) != 0)
                    isRunning = TRUE;
            }
        }

        if (isMoving)
            work->player.SetMoveAngle(angle, isRunning);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x18
	mov r9, r0
	ldr r0, [r9, #8]
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0
	mov r5, r4
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215E874
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	movne r0, #1
	bne _0215E878
_0215E874:
	mov r0, #0
_0215E878:
	cmp r0, #0
	beq _0215E93C
	bl _ZN10HubControl12TouchEnabledEv
	cmp r0, #0
	beq _0215E93C
	add r0, sp, #0xc
	bl _ZN8CVector3C1Ev
	ldr r1, =touchInput
	add r0, r9, #0xe00
	ldrh r7, [r1, #0x14]
	ldrh r8, [r1, #0x16]
	bl _ZNK8CVector317ToConstVecFx32RefEv
	add r1, sp, #8
	add r2, sp, #4
	bl NNS_G3dWorldPosToScrPos
	ldr r1, [sp, #8]
	ldr r0, [sp, #4]
	sub r1, r7, r1
	movs r2, r1, lsl #0xc
	sub r0, r8, r0
	mov r1, r0, lsl #0xc
	mov r0, #0
	str r2, [sp, #0xc]
	rsbmi r2, r2, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	cmp r2, #0x40000
	bgt _0215E8FC
	ldr r0, [sp, #0x10]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x30000
	ble _0215E900
_0215E8FC:
	mov r5, #1
_0215E900:
	add r0, sp, #0
	add r1, sp, #0xc
	bl _ZN8CVector39MagnitudeEPlPKS_
	add r0, sp, #0
	ldr r0, [r0, #0]
	mov r0, r0, asr #0xc
	cmp r0, #4
	blt _0215E93C
	add r0, sp, #0xc
	bl _ZN8CVector39NormalizeEv
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x10]
	bl FX_Atan2Idx
	mov r6, r0
	mov r4, #1
_0215E93C:
	cmp r4, #0
	bne _0215E9C0
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x40
	beq _0215E970
	tst r0, #0x20
	movne r6, #0xa000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x6000
	moveq r6, #0x8000
	b _0215E9AC
_0215E970:
	tst r0, #0x80
	beq _0215E994
	tst r0, #0x20
	movne r6, #0xe000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x2000
	moveq r6, #0
	b _0215E9AC
_0215E994:
	tst r0, #0x20
	movne r6, #0xc000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x4000
	mvneq r6, #0
_0215E9AC:
	cmp r6, #0
	blt _0215E9C0
	mov r4, #1
	tst r0, #2
	movne r5, r4
_0215E9C0:
	cmp r4, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r9, #0x1f8
	mov r1, r6, lsl #0x10
	mov r2, r5
	add r0, r0, #0xc00
	mov r1, r1, lsr #0x10
	bl _ZN13CViDockPlayer12SetMoveAngleEti
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void CViDock::InitDockBack(CViDock *work, BOOL noDisableAnimation)
{
    s32 dockArea = DOCKAREA_INVALID;

    switch (work->type)
    {
        case CViDock::TYPE_DOCK:
            if (work->area < CViDock::AREA_COUNT)
                dockArea = HubConfig__GetDockStageConfig(work->area)->dockArea;
            break;

        case CViDock::TYPE_PREVIEW:
            if (work->area < DOCKAREA_COUNT)
                dockArea = HubConfig__GetDockPreviewConfig(work->area)->dockArea;
            break;

        case CViDock::TYPE_CONSTRUCTION_CUTSCENE:
            if (work->area < SHIP_COUNT_DRILL)
                dockArea = HubConfig__GetDockMapConfig(work->area)->dockArea;
            break;
    }

    work->dockBack.Init(dockArea, FALSE, noDisableAnimation);
}

void CViDock::ReleaseDockBack(CViDock *work)
{
    work->dockBack.Release();
}

void CViDock::InitDockCamera(CViDock *work)
{
    s32 area = DOCKAREA_INVALID;

    s32 mode;
    if (work->type == CViDock::TYPE_PREVIEW)
    {
        if (work->area < DOCKAREA_COUNT)
            area = HubConfig__GetDockPreviewConfig(work->area)->dockArea;

        mode = CViDockCamera::TYPE_PREVIEW;
    }
    else if (work->type == CViDock::TYPE_CONSTRUCTION_CUTSCENE)
    {
        area = DOCKAREA_BASE;

        mode = CViDockCamera::TYPE_CONSTRUCTION_CUTSCENE;
    }
    else
    {
        if (work->area < CViDock::AREA_COUNT)
            area = HubConfig__GetDockStageConfig(work->area)->dockArea;

        mode = CViDockCamera::TYPE_DOCK;
    }

    work->camera.Init(area, mode);
}

void CViDock::ReleaseDockDrawState(CViDock *work)
{
    work->camera.Release();
}

void CViDock::InitNpcs(CViDock *work)
{
    static const u16 npcCountForArea[CViDock::AREA_COUNT]     = { 5, 4, 4, 3, 2, 2, 2 };
    static const u16 npcStartTypeForArea[CViDock::AREA_COUNT] = { CVIDOCK_NPC_BASE_TAILS,    CVIDOCK_NPC_BASENEXT_SETTER,   CVIDOCK_NPC_JET_TAILS,  CVIDOCK_NPC_BOAT_COLONEL,
                                                                  CVIDOCK_NPC_HOVER_COLONEL, CVIDOCK_NPC_SUBMARINE_COLONEL, CVIDOCK_NPC_BEACH_TABBY };

    if (work->area < CViDock::AREA_COUNT)
    {
        u16 count     = npcCountForArea[work->area];
        s32 startType = npcStartTypeForArea[work->area];

        for (s32 i = 0; i < count; i++)
        {
            s32 type = startType + i;
            if (HubControl::CanSpawnNpcType(type) && HubControl::CanSpawnNpc(type))
            {
                const HubNpcSpawnConfig *config            = HubConfig__GetNpcConfig(type);
                const HubNpcTalkActionConfig *actionConfig = config->getActionConfig();

                CViDockNpcGroupEntry *entry = work->npcGroup.AddNpc();
                BOOL snapToAngle;
                if (type == CVIDOCK_NPC_BASENEXT_HOURGLASS || type == CVIDOCK_NPC_BASENEXT_OLDDS)
                    snapToAngle = FALSE;
                else
                    snapToAngle = TRUE;

                VecFx32 a2;
                CVector3 a1a(FX32_FROM_WHOLE(config->spawnX), FLOAT_TO_FX32(0.0), FX32_FROM_WHOLE(config->spawnZ));
                entry->npc.Init(type, a1a.ToVecFx32Ref(), config->spawnAngle, snapToAngle);

                a2.x = a2.y = a2.z = HubConfig__GetDockStageConfig(work->area)->scale;
                entry->npc.scale   = a2;

                u32 type  = actionConfig->talkActionType;
                u32 param = actionConfig->talkActionParam;

                entry->npc.talkActionType  = type;
                entry->npc.talkActionParam = param;
            }
        }
    }

    work->npcGroup.Init();
}

void CViDock::ReleaseNpcGroup(CViDock *work)
{
    work->npcGroup.ClearNpcList();
}

BOOL CViDock::CheckTouchRect(CViDock *work, s32 touchX, s32 touchY, int px, int py)
{
    if (work->area >= CViDock::AREA_COUNT)
        return FALSE;

    const HitboxRect areaRects[CViDock::AREA_COUNT] = {
        { -16, -32, 16, 8 }, { -16, -32, 16, 8 }, { -16, -32, 16, 8 }, { -12, -24, 12, 4 }, { -12, -24, 12, 4 }, { -12, -24, 12, 4 }, { -12, -24, 12, 4 },
    };

    const HitboxRect *rect = &areaRects[work->area];
    return touchX >= px + rect->left && touchX <= px + rect->right && touchY >= py + rect->top && touchY <= py + rect->bottom;
}

void CViDock::InitShipConstructCompletedMessage(CViDock *work)
{
    void *msgShipComp = FileUnknown__GetAOUFile(HubControl::GetMsgSequenceArchive(), ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_AN_SHIP_COMP_MPC);
    FontAnimator__LoadFont2(&work->fontAnimator, HubControl::GetFontWindow(), 0, PIXEL_TO_TILE(8), PIXEL_TO_TILE(152), PIXEL_TO_TILE(240), PIXEL_TO_TILE(32), GRAPHICS_ENGINE_A,
                            SPRITE_PRIORITY_0, SPRITE_ORDER_0, PALETTE_ROW_4);
    FontAnimator__LoadMPCFile(&work->fontAnimator, msgShipComp);
    FontAnimator__SetMsgSequence(&work->fontAnimator, HubConfig__GetDockMapConfig(work->area)->msgSeqShipCompleted);
    FontAnimator__InitStartPos(&work->fontAnimator, 1, 0);
    FontAnimator__LoadPaletteFunc2(&work->fontAnimator);

    u16 startY;
    u16 sizeY;
    if (FontAnimator__GetDialogLineCount(&work->fontAnimator, 0) == 1)
    {
        FontAnimator__AdvanceLine(&work->fontAnimator, 16);
        startY = PIXEL_TO_TILE(160);
        sizeY  = PIXEL_TO_TILE(32);
    }
    else
    {
        startY = PIXEL_TO_TILE(144);
        sizeY  = PIXEL_TO_TILE(48);
    }

    FontAnimator__LoadCharacters(&work->fontAnimator, 0);
    FontWindowAnimator__Load2(&work->fontWindowAnimator, HubControl::GetFontWindow(), 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG,
                              PIXEL_TO_TILE(0), startY, PIXEL_TO_TILE(HW_LCD_WIDTH), sizeY, GRAPHICS_ENGINE_A, SPRITE_PRIORITY_0, SPRITE_ORDER_1, PALETTE_ROW_5);
    FontWindowAnimator__Func_20599B4(&work->fontWindowAnimator);
}

void CViDock::ReleaseFontWindow(CViDock *work)
{
    FontWindowAnimator__Release(&work->fontWindowAnimator);
    FontAnimator__Release(&work->fontAnimator);
}

void CViDock::DrawFontWindow(CViDock *work)
{
    FontAnimator__Draw(&work->fontAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
}

void CViDock::InitShipConstructedBG(CViDock *work)
{
    u16 step  = FX_DivS32(FLOAT_TO_FX32(16.0), 16);
    u16 angle = 0;
    for (s32 i = 0; i < 16; i++)
    {
        work->shipConstructBGVertices[i].x = CosFX(angle);
        work->shipConstructBGVertices[i].y = SinFX(angle);

        angle += step;
    }

    work->field_167C = 0;
    work->field_167E = FX_DivS32(FLOAT_TO_FX32(1.0), 6);
    work->field_1680 = 0;
}

void CViDock::ReleaseUnknown(CViDock *work)
{
    // Nothing to do.
}

NONMATCH_FUNC void CViDock::ProcessShipConstructedBG(CViDock *work)
{
    // https://decomp.me/scratch/6UpB7 -> 98.34%
#ifdef NON_MATCHING
    s32 c;

    work->field_1684[0] = 0;

    s16 value = work->field_167C;
    for (c = 1; c < 7; c++)
    {
        work->field_1684[c] = value;

        value += work->field_167E;
    }
    work->field_1684[7] = 4096;

    for (c = 1; c < 7; c++)
    {
        work->colors[c - 1] = ovl05_02172EB4[(work->field_1680 + c) & 3];
    }

    GXRgb color1;
    GXRgb color2;

    s16 value2 = 0x1000 - work->field_1684[6];
    switch (work->field_1680 & 3)
    {
        case 0:
            color1 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            color2 = GX_RGB_888(0x00, 0xF8, 0xD8);
            break;

        case 1:
            color1 = GX_RGB_888(0x00, 0xF8, 0xD8);
            color2 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            break;

        case 2:
            color1 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            color2 = GX_RGB_888(0xFF, 0xFF, 0xFF);
            break;

        case 3:
            color1 = GX_RGB_888(0xFF, 0xFF, 0xFF);
            color2 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            break;
    }
    work->field_1684[8] = Unknown2051334__Func_20516EC(color1, color2, work->field_167E, value2);

    switch ((work->field_1680 + 7) & 3)
    {
        case 0:
            color1 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            color2 = GX_RGB_888(0x00, 0xF8, 0xD8);
            break;

        case 1:
            color1 = GX_RGB_888(0x00, 0xF8, 0xD8);
            color2 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            break;

        case 2:
            color1 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            color2 = GX_RGB_888(0xFF, 0xFF, 0xFF);
            break;

        case 3:
            color1 = GX_RGB_888(0xFF, 0xFF, 0xFF);
            color2 = GX_RGB_888(0xB8, 0xF8, 0xF0);
            break;
    }

    work->colors[6] = Unknown2051334__Func_20516EC(color1, color2, work->field_167E, value2);

    work->field_167C += 32;
    if (work->field_167C >= work->field_167E)
    {
        work->field_167C -= work->field_167E;
        work->field_1680 += 3;
    }

    VecFx32 vec;
    for (s32 v = 0; v < 16; v++)
    {
        VecFx32 *pos = work->field_16A4[v];
        for (s32 i = 0; i < 6; i++)
        {
            vec.x = vec.y = vec.z = 0;

            Unknown2051334__Func_20514DC(&pos[i], &vec, &work->shipConstructBGVertices[v], work->field_1684[i + 1]);
            pos[i].z = 0;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r4, r0
	add r1, r4, #0x1600
	mov r0, #0
	strh r0, [r1, #0x84]
	ldrsh r3, [r1, #0x7c]
	mov r2, #1
_0215EF60:
	add r0, r4, r2, lsl #1
	add r0, r0, #0x1600
	strh r3, [r0, #0x84]
	ldrsh r0, [r1, #0x7e]
	add r2, r2, #1
	cmp r2, #7
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	blt _0215EF60
	add r0, r4, #0x1600
	mov r1, #0x1000
	strh r1, [r0, #0x92]
	ldr r7, =ovl05_02172EB4
	mov r0, #1
	add r1, r4, #0x1000
_0215EFA0:
	ldr r3, [r1, #0x680]
	add r2, r4, r0, lsl #1
	add r3, r3, r0
	mov r3, r3, lsl #0x1e
	mov r3, r3, lsr #0x1d
	ldrh r3, [r7, r3]
	add r2, r2, #0x1600
	add r0, r0, #1
	strh r3, [r2, #0x94]
	cmp r0, #7
	blt _0215EFA0
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x90]
	add r0, r4, #0x1000
	ldr r1, [r0, #0x680]
	rsb r0, r2, #0x1000
	mov r0, r0, lsl #0x10
	and r1, r1, #3
	cmp r1, #3
	mov r7, r0, asr #0x10
	addls pc, pc, r1, lsl #2
	b _0215F034
_0215EFF8: // jump table
	b _0215F008 // case 0
	b _0215F014 // case 1
	b _0215F020 // case 2
	b _0215F02C // case 3
_0215F008:
	ldr r5, =0x00007BF7
	ldr r6, =0x00006FE0
	b _0215F034
_0215F014:
	ldr r5, =0x00006FE0
	ldr r6, =0x00007BF7
	b _0215F034
_0215F020:
	ldr r5, =0x00007BF7
	ldr r6, =0x00007FFF
	b _0215F034
_0215F02C:
	ldr r5, =0x00007FFF
	ldr r6, =0x00007BF7
_0215F034:
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x7e]
	mov r0, r5
	mov r1, r6
	mov r3, r7
	bl Unknown2051334__Func_20516EC
	add r1, r4, #0x1600
	strh r0, [r1, #0x94]
	add r0, r4, #0x1000
	ldr r0, [r0, #0x680]
	add r0, r0, #7
	and r0, r0, #3
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215F0AC
_0215F070: // jump table
	b _0215F080 // case 0
	b _0215F08C // case 1
	b _0215F098 // case 2
	b _0215F0A4 // case 3
_0215F080:
	ldr r5, =0x00007BF7
	ldr r6, =0x00006FE0
	b _0215F0AC
_0215F08C:
	ldr r5, =0x00006FE0
	ldr r6, =0x00007BF7
	b _0215F0AC
_0215F098:
	ldr r5, =0x00007BF7
	ldr r6, =0x00007FFF
	b _0215F0AC
_0215F0A4:
	ldr r5, =0x00007FFF
	ldr r6, =0x00007BF7
_0215F0AC:
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x7e]
	mov r0, r5
	mov r1, r6
	mov r3, r7
	bl Unknown2051334__Func_20516EC
	add r1, r4, #0x1600
	strh r0, [r1, #0xa2]
	ldrsh r2, [r1, #0x7c]
	add r0, r4, #0x27c
	add r3, r0, #0x1400
	add r0, r2, #0x20
	strh r0, [r1, #0x7c]
	ldrsh r2, [r1, #0x7e]
	ldrsh r0, [r1, #0x7c]
	cmp r0, r2
	blt _0215F10C
	ldrsh r1, [r3, #0]
	add r0, r4, #0x1000
	sub r1, r1, r2
	strh r1, [r3]
	ldr r1, [r0, #0x680]
	add r1, r1, #3
	str r1, [r0, #0x680]
_0215F10C:
	add r0, r4, #0x2a4
	add r1, r4, #0x1bc
	add r11, r0, #0x1400
	mov r0, #0
	add r9, r1, #0x1400
	str r0, [sp]
	add r7, sp, #4
	mov r6, r0
	mov r5, r0
_0215F130:
	mov r8, #0
	mov r10, r11
_0215F138:
	add r0, r4, r8, lsl #1
	str r6, [r7]
	str r6, [r7, #4]
	str r6, [r7, #8]
	add r0, r0, #0x1600
	ldrsh r3, [r0, #0x86]
	mov r0, r10
	mov r1, r7
	mov r2, r9
	bl Unknown2051334__Func_20514DC
	add r8, r8, #1
	str r5, [r10, #8]
	cmp r8, #6
	add r10, r10, #0xc
	blt _0215F138
	ldr r0, [sp]
	add r11, r11, #0x48
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #0x10
	add r9, r9, #0xc
	blt _0215F130
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void CViDock::DrawShipConstructedBG(CViDock *work)
{
    s32 i;
    s32 v;

    VecFx32 translation;
    VecFx32 scale;
    MtxFx33 mtxRot;

    translation.x = FLOAT_TO_FX32(0.0);
    translation.y = FLOAT_TO_FX32(0.0);
    translation.z = -FLOAT_TO_FX32(1024.0);

    scale.x = FLOAT_TO_FX32(1024.0);
    scale.y = FLOAT_TO_FX32(768.0);
    scale.z = FLOAT_TO_FX32(1.0);

    MTX_Identity33(&mtxRot);

    NNS_G3dGlbSetBaseTrans(&translation);
    NNS_G3dGlbSetBaseScale(&scale);
    NNS_G3dGlbSetBaseRot(&mtxRot);
    NNS_G3dGlbFlushAlt();

    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, GX_COLOR_FROM_888(0xFF), GX_POLYGON_ATTR_MISC_NONE);
    NNS_G3dGeTexImageParam(GX_TEXFMT_NONE, GX_TEXGEN_NONE, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS, 0x00000000);
    NNS_G3dGeTexPlttBase(0x00000000, GX_TEXFMT_NONE);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGePushMtx();

    for (v = 0; v < 15; v++)
    {
        NNS_G3dGeBegin(GX_BEGIN_TRIANGLE_STRIP);

        if (work->field_1684[0] < work->field_1684[1])
        {
            NNS_G3dGeColor(work->field_1684[8]);
            NNS_G3dGeVtxXY(0, 0);
        }

        for (i = 0; i < 6; i++)
        {
            NNS_G3dGeColor(work->colors[i]);

            NNS_G3dGeVtxXY(work->field_16A4[v + 0][i].x, work->field_16A4[v + 0][i].y);
            NNS_G3dGeVtxXY(work->field_16A4[v + 1][i].x, work->field_16A4[v + 1][i].y);
        }

        if (work->field_1684[6] < work->field_1684[7])
        {
            NNS_G3dGeColor(work->colors[6]);

            NNS_G3dGeVtxXY(work->shipConstructBGVertices[v + 0].x, work->shipConstructBGVertices[v + 0].y);
            NNS_G3dGeVtxXY(work->shipConstructBGVertices[v + 1].x, work->shipConstructBGVertices[v + 1].y);
        }

        NNS_G3dGeEnd();
    }

    {
        NNS_G3dGeBegin(GX_BEGIN_TRIANGLE_STRIP);

        if (work->field_1684[0] < work->field_1684[1])
        {
            NNS_G3dGeColor(work->field_1684[8]);
            NNS_G3dGeVtxXY(0, 0);
        }

        for (i = 0; i < 6; i++)
        {
            NNS_G3dGeColor(work->colors[i]);

            NNS_G3dGeVtxXY(work->field_16A4[15][i].x, work->field_16A4[15][i].y);
            NNS_G3dGeVtxXY(work->field_16A4[0][i].x, work->field_16A4[0][i].y);
        }

        if (work->field_1684[6] < work->field_1684[7])
        {
            NNS_G3dGeColor(work->colors[6]);

            NNS_G3dGeVtxXY(work->shipConstructBGVertices[15].x, work->shipConstructBGVertices[15].y);
            NNS_G3dGeVtxXY(work->shipConstructBGVertices[0].x, work->shipConstructBGVertices[0].y);
        }

        NNS_G3dGeEnd();
    }

    NNS_G3dGePopMtx(1);
}

NONMATCH_FUNC void CViDock::Draw(CViDock *work, BOOL drawPlayer, BOOL drawNpcs, BOOL drawDock)
{
    // https://decomp.me/scratch/tZD63 -> 93.09%
#ifdef NON_MATCHING
    u16 rotationY;
    if (work->type == CViDock::TYPE_PREVIEW || work->type == CViDock::TYPE_CONSTRUCTION_CUTSCENE)
    {
        rotationY = 0;
    }
    else
    {
        if (work->area < CViDock::AREA_COUNT)
        {
            rotationY = HubConfig__GetDockBackInfo(HubConfig__GetDockStageConfig(work->area)->dockArea)->dockRotationY;
        }
        else
        {
            rotationY = 0;
        }
    }

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGePushMtx();

    NNS_G3dGeIdentity();
    work->camera.SetDrawPipeline();
    if (drawDock)
        work->dockBack.DrawDock(rotationY, FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(0.0));

    fx32 scale = HubConfig__GetDockStageConfig(work->area)->scale;
    if (drawNpcs)
    {
        CViDockNpcGroupEntry *entry = work->npcGroup.GetFirstNpc();

        while (entry != NULL)
        {
            fx32 shadowScale = MultiplyFX(0x5000, scale);
            work->dockBack.DrawShadow(&work->shadow, shadowScale, entry->npc.position.ToConstVecFx32Ref().x, entry->npc.position.ToConstVecFx32Ref().z);
            entry->npc.Draw();

            entry = work->npcGroup.GetNextNpc(entry);
        }
    }

    if (drawPlayer)
    {
        fx32 shadowScale = MultiplyFX(0x5000, scale);
        work->dockBack.DrawShadow(&work->shadow, shadowScale, work->player.position.ToConstVecFx32Ref().x, work->player.position.ToConstVecFx32Ref().z);
        work->player.Draw();
    }

    if (drawNpcs && drawPlayer)
    {
        work->npcGroup.Draw(work->player.position.ToConstVecFx32Ref());
    }

    NNS_G3dGePopMtx(1);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r10, r0
	ldrh r0, [r10, #2]
	mov r11, r1
	str r2, [sp, #4]
	add r0, r0, #0xff
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	mov r4, r3
	movls r5, #0
	bls _0215F728
	ldrh r0, [r10, #0]
	cmp r0, #7
	movhs r5, #0
	bhs _0215F728
	bl HubConfig__GetDockStageConfig
	ldr r0, [r0, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockBackInfo
	ldrh r5, [r0, #0x18]
_0215F728:
	mov r3, #2
	add r1, sp, #0xc
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x18
	bl _ZN13CViDockCamera15SetDrawPipelineEv
	cmp r4, #0
	beq _0215F784
	mov r2, #0
	mov r1, r5
	mov r3, r2
	add r0, r10, #0xf8
	bl _ZN11CViDockBack8DrawDockEttt
_0215F784:
	ldrh r0, [r10, #0]
	bl HubConfig__GetDockStageConfig
	ldr r1, [sp, #4]
	ldrsh r7, [r0, #0x40]
	cmp r1, #0
	beq _0215F838
	add r0, r10, #0x1000
	ldr r9, [r0, #0x138]
	cmp r9, #0
	moveq r9, #0
	cmp r9, #0
	beq _0215F838
	mov r0, #0x5000
	umull r3, r2, r7, r0
	mov r1, #0
	mla r2, r7, r1, r2
	mov r1, r7, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r8, r3, lsr #0xc
	cmp r9, #0
	orr r8, r8, r0, lsl #20
	beq _0215F838
	add r4, r10, #0x48
	add r5, r10, #0x130
_0215F7EC:
	add r0, r9, #8
	bl _ZNK8CVector317ToConstVecFx32RefEv
	mov r6, r0
	add r0, r9, #8
	bl _ZNK8CVector317ToConstVecFx32RefEv
	ldr r1, [r6, #8]
	mov r2, r8
	str r1, [sp]
	ldr r3, [r0, #0]
	add r0, r10, #0xf8
	add r1, r4, #0x1400
	bl _ZN11CViDockBack10DrawShadowEP9CViShadowlll
	mov r0, r9
	bl _ZN11CVi3dObject4DrawEv
	add r0, r5, #0x1000
	mov r1, r9
	bl _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry
	movs r9, r0
	bne _0215F7EC
_0215F838:
	cmp r11, #0
	beq _0215F8A4
	add r0, r10, #0xe00
	bl _ZNK8CVector317ToConstVecFx32RefEv
	mov r4, r0
	add r0, r10, #0xe00
	bl _ZNK8CVector317ToConstVecFx32RefEv
	ldr r1, [r4, #8]
	mov r2, #0x5000
	mov r4, #0
	umull r8, r6, r7, r2
	str r1, [sp]
	ldr r3, [r0, #0]
	add r1, r10, #0x48
	mla r6, r7, r4, r6
	mov r5, r7, asr #0x1f
	mla r6, r5, r2, r6
	adds r2, r8, #0x800
	adc r4, r6, #0
	mov r2, r2, lsr #0xc
	add r0, r10, #0xf8
	add r1, r1, #0x1400
	orr r2, r2, r4, lsl #20
	bl _ZN11CViDockBack10DrawShadowEP9CViShadowlll
	add r0, r10, #0x1f8
	add r0, r0, #0xc00
	bl _ZN11CVi3dObject4DrawEv
_0215F8A4:
	ldr r0, [sp, #4]
	cmp r0, #0
	cmpne r11, #0
	beq _0215F8CC
	add r0, r10, #0xe00
	bl _ZNK8CVector317ToConstVecFx32RefEv
	add r2, r10, #0x130
	mov r1, r0
	add r0, r2, #0x1000
	bl _ZN15CViDockNpcGroup4DrawER7VecFx32
_0215F8CC:
	mov r2, #1
	add r1, sp, #8
	mov r0, #0x12
	str r2, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void CViDock::HandleEnvironmentSfx(CViDock *work)
{
    if (work->type == CViDock::TYPE_DOCK && work->area == CViDock::AREA_BEACH)
    {
        if (work->environmentSfxTimer == 140)
        {
            PlayHubSfx(HUB_SFX_WAVE);
        }
        else if (work->environmentSfxTimer == 0)
        {
            work->environmentSfxTimer = 200;
        }

        work->environmentSfxTimer--;
    }
}

void CViDock::Main_Init(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    work->camera.SetCamTarget(&work->player.position.ToConstVecFx32Ref());
    work->camera.Process();
    work->player.Process(FLOAT_TO_FX32(1.0));
    work->dockBack.Process();

    CViDock::Draw(work, TRUE, TRUE, TRUE);
}

void CViDock::Main_DockPreview(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    work->camera.Process();
    work->dockBack.Process();
    CViDock::Draw(work, FALSE, FALSE, TRUE);
}

void CViDock::Main_PlayerActive(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    const CViDockAreaConfig *config = HubConfig__GetDockStageConfig(work->area);
    CViDock::HandlePlayerMovement(work);

    work->player.Process(HubConfig__GetDockStageConfig(work->area)->scale);

    const VecFx32 *curPlayerPos = &work->player.position.ToConstVecFx32Ref();
    VecFx32 *prevPlayerPos      = work->player.GetPrevPosition();

    VecFx32 newPlayerPos;
    BOOL isSailPrompt;
    BOOL flag1;
    u32 area;
    work->dockBack.ProcessCollision(prevPlayerPos, curPlayerPos, &newPlayerPos, &isSailPrompt, &flag1, &area);
    newPlayerPos.y        = work->dockBack.GetFloorPosition(newPlayerPos);
    work->player.position = newPlayerPos;

    if (isSailPrompt)
    {
        if ((padInput.btnPress & PAD_BUTTON_A) == 0 && work->inSailPromptRange)
            isSailPrompt = FALSE;

        work->inSailPromptRange = TRUE;
    }
    else
    {
        work->inSailPromptRange = FALSE;
    }

    if (flag1)
        isSailPrompt = TRUE;

    curPlayerPos  = &work->player.position.ToConstVecFx32Ref();
    prevPlayerPos = work->player.GetPrevPosition();

    if (work->npcGroup.HandlePlayerSolidCollisions(prevPlayerPos, curPlayerPos, &newPlayerPos, HubConfig__GetDockStageConfig(work->area)->scale) != NULL)
        work->player.position = newPlayerPos;

    work->dockBack.Process();
    work->npcGroup.Process();

    const VecFx32 *temp = &work->player.position.ToConstVecFx32Ref();
    newPlayerPos.x      = temp->x;
    newPlayerPos.y      = temp->y;
    newPlayerPos.z      = temp->z;

    if (work->area < CViDock::AREA_COUNT)
        VEC_Add(&newPlayerPos, &config->camOffset, &newPlayerPos);
    work->camera.SetCamTarget(&newPlayerPos);
    work->camera.Process();
    CViDock::HandleEnvironmentSfx(work);
    CViDock::Draw(work, TRUE, TRUE, TRUE);
    work->talkActionType  = CVIDOCKNPCTALK_INVALID;
    work->talkActionParam = 0;
    work->talkNpc         = 0;

    if (isSailPrompt)
    {
        work->talkActionType  = CVIDOCKNPCTALK_SAILPROMPT;
        work->talkActionParam = work->area;
    }
    else
    {
        if (area != CViDock::AREA_INVALID && area != work->area)
        {
            work->nextArea = area;
        }
        else
        {
            CViDockNpcGroupEntry *entry;
            BOOL interacted;

            interacted = FALSE;
            entry      = NULL;
            do
            {
                u16 angle             = work->player.currentTurnAngle;
                VecFx32 *prevPosition = work->player.GetPrevPosition();

                config = HubConfig__GetDockStageConfig(work->area);

                BOOL canTalk;
                entry = work->npcGroup.FindNpcInTalkRange(prevPosition, angle, config->scale, &canTalk, entry);
                if (entry == NULL)
                    break;

                if (canTalk && (padInput.btnPress & PAD_BUTTON_A) != 0)
                    interacted = TRUE;

                if (CheckTouchPushEnabled())
                {
                    if (HubControl::TouchEnabled())
                    {
                        u16 pushX = touchInput.push.x;
                        u16 pushY = touchInput.push.y;

                        int px;
                        int py;
                        NNS_G3dWorldPosToScrPos(&entry->npc.position.ToConstVecFx32Ref(), &px, &py);
                        if (CViDock::CheckTouchRect(work, pushX, pushY, px, py))
                            interacted = TRUE;
                    }
                }
            } while (!interacted && entry != NULL);

            if (interacted)
            {
                // not sure how to match this "properly"...
                // using a simple offset will match it for now I suppose.
                // if anyone reading this would like to try matching it, the scratch is here: https://decomp.me/scratch/MlAsa
#ifdef NON_MATCHING
                if (work->talkActionType != CVIDOCKNPCTALK_NPC)
#else
                if ((u8 *)work + 0x1460)
#endif
                {
                    work->talkActionType = entry->npc.talkActionType;
                }

                // not sure how to match this "properly"...
                // using a simple offset will match it for now I suppose.
                // if anyone reading this would like to try matching it, the scratch is here: https://decomp.me/scratch/MlAsa
#ifdef NON_MATCHING
                if (work->talkActionParam != CVIDOCKNPCTALK_NPC)
#else
                if ((u8 *)work + 0x1464)
#endif
                {
                    work->talkActionParam = entry->npc.talkActionParam;
                }

                entry->npc.talkCount++;
                work->talkNpc = &entry->npc;
            }
        }
    }
}

void CViDock::Main_TalkActive(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    const CViDockAreaConfig *config = HubConfig__GetDockStageConfig(work->area);
    if (work->charactersEnabled)
    {
        work->player.Process(FLOAT_TO_FX32(1.0));
        work->npcGroup.Process();
    }

    work->dockBack.Process();

    const VecFx32 &temp = work->player.position.ToConstVecFx32Ref();
    VecFx32 camTarget;
    camTarget.x = temp.x;
    camTarget.y = temp.y;
    camTarget.z = temp.z;
    if (work->area < CViDock::AREA_COUNT)
        VEC_Add(&camTarget, &config->camOffset, &camTarget);

    work->camera.SetCamTarget(&camTarget);
    work->camera.Process();

    CViDock::Draw(work, work->charactersEnabled, work->charactersEnabled, TRUE);
}

void CViDock::Main_InitForPreviewDockChange(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    CViDock::InitDockCamera(work);
    work->dockBack.SetArea(HubConfig__GetDockPreviewConfig(work->area)->dockArea);
    SetCurrentTaskMainEvent(CViDock::Main_WaitForPreviewDockChanged);
}

void CViDock::Main_WaitForPreviewDockChanged(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    if (work->dockBack.IsThreadIdle())
    {
        SetCurrentTaskMainEvent(CViDock::Main_DockPreview);
        work->nextAreaLoaded = TRUE;
    }
}

void CViDock::Main_UpgradeShipSpin(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    const CViMapAreaConfig *config = HubConfig__GetDockMapConfig(work->area);

    work->camera.Process();
    work->dockBack.Process();
    CViDock::ProcessShipConstructedBG(work);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGePushMtx();
    NNS_G3dGeIdentity();
    work->camera.SetDrawPipeline();
    CViDock::DrawShipConstructedBG(work);
    work->dockBack.SetShipPosition(config->shipPosY);
    work->dockBack.SetShipScale(config->shipScale);
    work->dockBack.DrawDock(work->rotationY, config->rotationX, FLOAT_DEG_TO_IDX(0.0));
    NNS_G3dGePopMtx(1);

    work->rotationY += FLOAT_DEG_TO_IDX(1.40625);
}

void CViDock::Destructor(Task *task)
{
    CViDock *work = TaskGetWork(task, CViDock);

    CViDock::Release(work);

    // TODO: use 'HubTaskDestroy' when CViDock__DestroyInternal matches
    // HubTaskDestroy<CViDock>(task);
    CViDock__DestroyInternal(task);

    taskSingleton = NULL;
}

// TODO: should match when destructors are decompiled for 'CViDockPlayer' 'CViDockNpcGroup', 'CViShadow' && 'CViDockBack'
NONMATCH_FUNC void CViDock__DestroyInternal(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0215FFB4
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadowD0Ev
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroupD0Ev
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	bl _ZN13CViDockPlayerD0Ev
	add r0, r4, #0xf8
	bl _ZN11CViDockBackD0Ev
	mov r0, r4
	bl _ZdlPv
_0215FFB4:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void CViDock::Main_ChangingArea(void)
{
    CViDock *work = TaskGetWorkCurrent(CViDock);

    if (IsThreadWorkerFinished(&work->thread))
    {
        work->isThreadBusy = FALSE;
        SetCurrentTaskMainEvent(NULL);
    }
}

void CViDock::ThreadFunc(void *arg)
{
    CViDock *work = (CViDock *)arg;

    s32 area   = work->area;
    work->area = work->nextArea;

    CViDock::InitPlayer(work, area);
    CViDock::InitDockBack(work, FALSE);
    CViDock::InitDockCamera(work);
    CViDock::InitNpcs(work);

    work->shadow.alpha = HubConfig__GetDockStageConfig(work->area)->shadowAlpha;
}