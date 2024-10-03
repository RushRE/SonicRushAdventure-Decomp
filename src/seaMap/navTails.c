#include <seaMap/navTails.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>
#include <game/text/messageController.h>
#include <game/graphics/background.h>
#include <game/graphics/drawReqTask.h>
#include <game/save/saveGame.h>

// files
#include <resources/bb/nv.h>
#include <resources/bb/nv/nav_assets.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED BOOL SeaMapEventManager__CheckFeatureUnlocked(s32 id);

// --------------------
// STRUCTS
// --------------------

// --------------------
// VARIABLES
// --------------------

static Task *navTailsTask;

NOT_DECOMPILED void *_0210F648;
NOT_DECOMPILED void *NavTails__FontAniInfo;
NOT_DECOMPILED void *NavTails__ShipAniInfo;
NOT_DECOMPILED void *NavTails__ChartAniInfo;
NOT_DECOMPILED void *_0210F708;

// --------------------
// UNREFERENCED VARS
// --------------------

FORCE_INCLUDE_ARRAY(void *, displayControl_1, 2, { &reg_GX_DISPCNT, &reg_GXS_DB_DISPCNT })

// --------------------
// FUNCTION DECLS
// --------------------

static void NavTails_Main(void);
static void NavTails_Destructor(Task *task);
static void NavTails_Draw(NavTails *work);

// Helpers
static NavTails *GetNavTailsWork(void);
static void SetupDisplayForNavTails(BOOL useEngineB);
static void InitNavTailsSprites(NavTails *work);
static void ReleaseNavTailsSprites(NavTails *work);
static void ReleaseUnknownNavTailsSprites(NavTails *work);
static void SetNavTailsLifeAnimators(NavTails *work, s32 num);
static u8 GetLivesForNavTails(void);
static void SetNewNavTailsBackground(NavTails *work, s32 id);
static void LoadNavTailsFont(NavTails *work, FontWindow *window);
static void SetNavTailsWindowMode(NavTails *work, BOOL enabled);
static s32 GetNavTailsWindowForDialog(NavTails *work);
static void LoadNavTailsAssets(NavTailsAssets *assets);
static void ReleaseNavTailsAssets(NavTailsAssets *assets);
static void LoadNavTailsTailsSprite(NavTailsAssets *assets, u32 id);
static void InitNavTailsBG_Nav(NavTails *work);
static void InitNavTailsBG_Tails(NavTails *work);
static void InitNavTailsBG_MsgWindow(NavTails *work, s32 id);
static void ClearNavTailsBackground(NavTails *work);
static void NavTails_FontCallback(u32 type, FontAnimator *animator, void *context);

// talk states
static void NavTails_StateTalk_Speaking(NavTails *work);
static void NavTails_StateTalk_SpeakDelay(NavTails *work);

// dma states
static void NavTails_StateDMA_Idle(NavTails *work);
static void NavTails_StateDMA_PrepareChange(NavTails *work);
static void NavTails_StateDMA_HideOldBackground(NavTails *work);
static void NavTails_StateDMA_LoadNewTailsSprite(NavTails *work);
static void NavTails_StateDMA_ShowNewBackground(NavTails *work);
static void NavTails_StateDMA_EndChange(NavTails *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateNavTails(BOOL useEngineB, s32 a2, FontWindow *window)
{
    Task *task   = TaskCreate(NavTails_Main, NavTails_Destructor, TASK_FLAG_NONE, 0, 0x100, TASK_SCOPE_0, NavTails);
    navTailsTask = task;

    NavTails *work = TaskGetWork(task, NavTails);
    TaskInitWork16(work);

    work->useEngineB = useEngineB;
    work->field_33C  = a2;
    work->stateTalk  = NavTails_StateTalk_Speaking;
    work->stateDMA   = NavTails_StateDMA_Idle;

    LoadNavTailsAssets(&work->assets);
    SetupDisplayForNavTails(useEngineB);
    InitNavTailsSprites(work);
    LoadNavTailsFont(work, window);
    LoadNavTailsTailsSprite(&work->assets, 1);
    work->dma.tailsBackgroundID = 1;
    InitNavTailsBG_Nav(work);
    InitNavTailsBG_Tails(work);
    InitNavTailsBG_MsgWindow(work, 0);
}

void DestroyNavTails(void)
{
    if (IsNavTailsActive())
    {
        DestroyTask(navTailsTask);
        navTailsTask = NULL;
    }
}

BOOL IsNavTailsActive(void)
{
    return navTailsTask != NULL;
}

void NavTailsSpeak(u16 msgSequence, u16 duration)
{
    NavTails *work = GetNavTailsWork();

    if (msgSequence != FontAnimator__GetCurrentSequence(&work->fontAnimator))
    {
        FontAnimator__SetMsgSequence(&work->fontAnimator, msgSequence);
        work->speakDelay    = 0;
        work->speakDuration = duration;

        if (msgSequence != NAVTAILS_MSGSEQ_NONE)
        {
            if (work->windowMode)
            {
                if (work->messageWindowID != GetNavTailsWindowForDialog(work))
                {
                    InitNavTailsBG_MsgWindow(work, GetNavTailsWindowForDialog(work));
                }
            }
        }
        else
        {
            SetNavTailsWindowMode(work, 0);
        }

        ReleaseUnknownNavTailsSprites(work);

        work->stateTalk = NavTails_StateTalk_SpeakDelay;
        work->stateTalk(work);
    }
}

u16 CheckNavTailsSpeaking(void)
{
    NavTails *work = GetNavTailsWork();
    return MessageController__GetCurrentSequence(&work->fontAnimator.msgControl);
}

BOOL CheckNavTailsLastDialog(void)
{
    NavTails *work = GetNavTailsWork();
    return FontAnimator__IsLastDialog(&work->fontAnimator);
}

void NavTails_Main(void)
{
    NavTails *work = TaskGetWorkCurrent(NavTails);

    work->stateTalk(work);
    work->stateDMA(work);

    if (!work->usingFontWindowPtr)
        FontWindow__PrepareSwapBuffer(work->fontWindow);

    NavTails_Draw(work);
}

void NavTails_Destructor(Task *task)
{
    NavTails *work = TaskGetWork(task, NavTails);

    RenderCore_StopDMA(1);
    ReleaseNavTailsAssets(&work->assets);
    ReleaseNavTailsSprites(work);
    FontAnimator__Release(&work->fontAnimator);

    if (!work->usingFontWindowPtr)
        FontWindow__Release(work->fontWindow);

    if (work->fontFileData != NULL)
        HeapFree(HEAP_USER, work->fontFileData);

    navTailsTask = NULL;
}

void NavTails_Draw(NavTails *work)
{
    s32 i;

    AnimatorSprite__DrawFrame(&work->aniWindowElements[0]);

    for (i = 0; i < 4; i++)
    {
        AnimatorSprite__DrawFrame(&work->aniShipIcon[i]);
    }

    AnimatorSprite__ProcessAnimationFast(&work->aniWindowElements[1]);
    AnimatorSprite__DrawFrame(&work->aniWindowElements[1]);
    AnimatorSprite__DrawFrame(&work->aniPlayerIcon);

    if (work->lives != GetLivesForNavTails())
    {
        SetNavTailsLifeAnimators(work, GetLivesForNavTails());
    }

    AnimatorSprite__DrawFrame(&work->aniWindowElements[2]);
    AnimatorSprite__DrawFrame(&work->aniLifeNumbers[0]);
    AnimatorSprite__DrawFrame(&work->aniLifeNumbers[1]);

    for (i = 0; i < 27; i++)
    {
        AnimatorSprite__DrawFrame(&work->aniChart[i]);
    }

    for (i = 0; i < 5; i++)
    {
        if (work->aniUnknown[i].vramPixels != NULL)
            AnimatorSprite__DrawFrame(&work->aniUnknown[i]);
    }
}

NavTails *GetNavTailsWork(void)
{
    return TaskGetWork(navTailsTask, NavTails);
}

NONMATCH_FUNC void SetupDisplayForNavTails(BOOL useEngineB){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =VRAMSystem__GFXControl
	movs r5, r0
	ldr r4, [r1, r5, lsl #2]
	bne _0203C9E8
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl GX_SetGraphicsMode
	ldr r0, =0x04000008
	ldrh r1, [r0, #0]
	and r1, r1, #0x43
	orr r1, r1, #0x2000
	strh r1, [r0]
	ldrh r1, [r0, #2]
	and r1, r1, #0x43
	orr r1, r1, #0x2100
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	and r1, r1, #0x43
	orr r1, r1, #0x284
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	and r1, r1, #0x43
	orr r1, r1, #0x308
	strh r1, [r0, #6]
	ldrh r1, [r0, #0]
	bic r1, r1, #3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r0, #6]
	bl GX_GetBankForOBJ
	mov ip, #0x200
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	b _0203CA8C
_0203C9E8:
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, =0x04001008
	ldrh r1, [r0, #0]
	and r1, r1, #0x43
	orr r1, r1, #0x2000
	strh r1, [r0]
	ldrh r1, [r0, #2]
	and r1, r1, #0x43
	orr r1, r1, #0x2100
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	and r1, r1, #0x43
	orr r1, r1, #0x284
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	and r1, r1, #0x43
	orr r1, r1, #0x308
	strh r1, [r0, #6]
	ldrh r1, [r0, #0]
	bic r1, r1, #3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r0, #6]
	bl GX_GetBankForSubOBJ
	mov ip, #0x200
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	str ip, [sp]
	bl VRAMSystem__SetupSubOBJBank
_0203CA8C:
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear32
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	add r1, r4, #0x5a
	mov r0, #0
	mov r2, #2
	bl MIi_CpuClear16
	cmp r5, #0
	bne _0203CAEC
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1c00
	str r0, [r1]
	ldmia sp!, {r3, r4, r5, pc}
_0203CAEC:
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1c00
	str r0, [r1]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void InitNavTailsSprites(NavTails *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	ldr r5, [r10, #8]
	ldr r4, [r10, #0]
	mov r0, r5
	mov r1, #8
	add r6, r10, #0x4d0
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r10, #0]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #3
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0x10
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r5
	mov r2, #8
	bl AnimatorSprite__Init
	mov r0, #4
	strh r0, [r6, #0x50]
	mov r0, #8
	strh r0, [r6, #8]
	mov r0, #0x64
	strh r0, [r6, #0xa]
	mov r0, r6
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r10, #0x134
	add r6, r0, #0x400
	mov r0, r5
	mov r1, #9
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r2, [r10, #0]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #3
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0xe
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r5
	mov r2, #9
	ldr r7, [r10, #0x33c]
	ldr r3, =_0210F648
	ldr r3, [r3, r7, lsl #2]
	bl AnimatorSprite__Init
	mov r0, #4
	strh r0, [r6, #0x50]
	ldr r1, [r10, #0x33c]
	cmp r1, #4
	beq _0203CC60
	ldr r0, =0x0210F67E
	mov r1, r1, lsl #3
	ldrsh r1, [r0, r1]
	ldr r0, =0x0210F680
	add r1, r1, #8
	strh r1, [r6, #8]
	ldr r1, [r10, #0x33c]
	mov r1, r1, lsl #3
	ldrsh r0, [r0, r1]
	add r0, r0, #0x64
	strh r0, [r6, #0xa]
_0203CC60:
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r2, r10, #0x198
	mov r0, r5
	mov r1, #0x31
	add r6, r2, #0x400
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r10, #0]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #3
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0xf
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r5
	mov r2, #0x31
	bl AnimatorSprite__Init
	mov r0, #5
	strh r0, [r6, #0x50]
	mov r0, #0x46
	strh r0, [r6, #8]
	mov r0, #0xb4
	mov r1, #0
	strh r0, [r6, #0xa]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r10, #0x1fc
	add r6, r0, #0x400
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	movne r7, #0xb
	moveq r7, #0xa
	mov r0, r5
	mov r1, r7
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	mov r2, r7
	ldr r7, [r10, #0]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #3
	ldr r7, [r0, r7, lsl #2]
	mov r0, #0xf
	str r7, [sp, #0x10]
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r6
	mov r1, r5
	bl AnimatorSprite__Init
	mov r0, #5
	strh r0, [r6, #0x50]
	mov r0, #0x36
	strh r0, [r6, #8]
	mov r0, #0xae
	mov r1, #0
	strh r0, [r6, #0xa]
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r7, #0
	ldr r8, =NavTails__ShipAniInfo
	add r9, r10, #0x660
	mov r11, r7
_0203CDA8:
	ldrh r6, [r8, #0]
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__IsShipUnlocked
	cmp r0, #0
	addeq r0, r6, #1
	moveq r0, r0, lsl #0x10
	moveq r6, r0, lsr #0x10
	mov r0, r5
	mov r1, r6
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	stmia sp, {r4, r11}
	str r0, [sp, #8]
	str r11, [sp, #0xc]
	ldr r3, [r10, #0]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r2, r6
	ldr r3, [r1, r3, lsl #2]
	mov r0, r9
	str r3, [sp, #0x10]
	mov r3, #3
	str r3, [sp, #0x14]
	mov r3, #0xd
	str r3, [sp, #0x18]
	mov r1, r5
	mov r3, r11
	bl AnimatorSprite__Init
	ldrh r2, [r8, #2]
	mov r1, #0
	mov r0, r9
	strh r2, [r9, #0x50]
	ldrsh r3, [r8, #4]
	mov r2, r1
	add r3, r3, #8
	strh r3, [r9, #8]
	ldrsh r3, [r8, #6]
	add r3, r3, #0x64
	strh r3, [r9, #0xa]
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r8, r8, #8
	add r9, r9, #0x64
	cmp r7, #4
	blt _0203CDA8
	mov r9, #0
	ldr r11, =VRAMSystem__VRAM_PALETTE_OBJ
	add r7, r10, #0x7f0
	mov r8, #0x4c
	mov r6, r9
_0203CE78:
	mov r0, r5
	mov r1, #0x27
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	stmia sp, {r4, r6}
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	ldr r1, [r10, #0]
	mov r0, r7
	ldr r2, [r11, r1, lsl #2]
	mov r1, r5
	str r2, [sp, #0x10]
	mov r2, #3
	str r2, [sp, #0x14]
	mov r2, #0xf
	str r2, [sp, #0x18]
	mov r2, #0x27
	mov r3, r6
	bl AnimatorSprite__Init
	mov r0, #5
	strh r0, [r7, #0x50]
	strh r8, [r7, #8]
	mov r0, #0xb4
	add r9, r9, #1
	strh r0, [r7, #0xa]
	add r7, r7, #0x64
	add r8, r8, #8
	cmp r9, #2
	blt _0203CE78
	bl GetLivesForNavTails
	mov r1, r0
	mov r0, r10
	bl SetNavTailsLifeAnimators
	mov r9, #0
	add r0, r10, #0xb8
	ldr r7, =NavTails__ChartAniInfo
	add r8, r0, #0x800
	mov r6, r9
	mov r11, r9
_0203CF1C:
	ldrh r1, [r7, #0]
	mov r0, r5
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	stmia sp, {r4, r6}
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	ldr r2, [r10, #0]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r0, r8
	ldr r2, [r1, r2, lsl #2]
	mov r1, r5
	str r2, [sp, #0x10]
	mov r2, #3
	str r2, [sp, #0x14]
	mov r2, #0x10
	str r2, [sp, #0x18]
	ldrh r2, [r7, #0]
	mov r3, r6
	bl AnimatorSprite__Init
	ldrh r2, [r7, #2]
	mov r0, r8
	mov r1, r11
	strh r2, [r8, #0x50]
	mov r2, r11
	bl AnimatorSprite__ProcessAnimation
	ldr r0, =_0210F708
	ldr r0, [r0, r9, lsl #2]
	bl SeaMapEventManager__CheckFeatureUnlocked
	cmp r0, #0
	ldreq r0, [r8, #0x3c]
	add r9, r9, #1
	orreq r0, r0, #1
	streq r0, [r8, #0x3c]
	cmp r9, #0x1b
	add r7, r7, #4
	add r8, r8, #0x64
	blt _0203CF1C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void ReleaseNavTailsSprites(NavTails *work)
{
    s32 i;

    for (i = 0; i < 3; i++)
    {
        AnimatorSprite__Release(&work->aniWindowElements[i]);
    }

    AnimatorSprite__Release(&work->aniPlayerIcon);

    for (i = 0; i < 4; i++)
    {
        AnimatorSprite__Release(&work->aniShipIcon[i]);
    }

    for (i = 0; i < 2; i++)
    {
        AnimatorSprite__Release(&work->aniLifeNumbers[i]);
    }

    for (i = 0; i < 27; i++)
    {
        AnimatorSprite__Release(&work->aniChart[i]);
    }

    ReleaseUnknownNavTailsSprites(work);
}

void ReleaseUnknownNavTailsSprites(NavTails *work)
{
    for (s32 i = 0; i < 5; i++)
    {
        AnimatorSprite__Release(&work->aniUnknown[i]);
    }

    MI_CpuClear16(work->aniUnknown, sizeof(work->aniUnknown));
}

void SetNavTailsLifeAnimators(NavTails *work, s32 num)
{
    u16 digit1 = FX_DivS32(num, 10) + 39;
    AnimatorSprite__SetAnimation(&work->aniLifeNumbers[0], digit1);
    AnimatorSprite__ProcessAnimationFast(&work->aniLifeNumbers[0]);

    u32 digit2 = (num + 39);
    digit2 -= 10 * (digit1 - 39);
    AnimatorSprite__SetAnimation(&work->aniLifeNumbers[1], digit2);
    AnimatorSprite__ProcessAnimationFast(&work->aniLifeNumbers[1]);

    work->lives = num;
}

u8 GetLivesForNavTails(void)
{
    return saveGame.stage.status.lives;
}

void SetNewNavTailsBackground(NavTails *work, s32 id)
{
    if (id != work->dma.tailsBackgroundID)
    {
        work->dma.tailsBackgroundID = id;
        work->stateDMA              = NavTails_StateDMA_PrepareChange;
    }
}

void LoadNavTailsFont(NavTails *work, FontWindow *window)
{
    if (window != NULL)
    {
        work->fontWindow         = window;
        work->usingFontWindowPtr = TRUE;
    }
    else
    {
        work->fontWindow         = &work->_fontWindow;
        work->usingFontWindowPtr = FALSE;

        FontWindow__Init(work->fontWindow);
        work->fontFileData = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
        FontWindow__LoadFromMemory(work->fontWindow, work->fontFileData, FALSE);
    }

    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont1(&work->fontAnimator, work->fontWindow, 0, 0, 0, 20, 10, work->useEngineB, BACKGROUND_0, 15, 296);
    FontAnimator__LoadMPCFile(&work->fontAnimator, work->assets.mpcText);
    FontAnimator__SetCallbackType(&work->fontAnimator, 8);
    ClearNavTailsBackground(work);
    FontAnimator__LoadMappingsFunc(&work->fontAnimator);
    FontAnimator__LoadPaletteFunc(&work->fontAnimator);
    FontAnimator__SetCallback(&work->fontAnimator, NavTails_FontCallback, work);
}

void SetNavTailsWindowMode(NavTails *work, BOOL enabled)
{
    if (enabled)
    {
        if (work->useEngineB == FALSE)
        {
            GX_SetVisiblePlane(GX_GetVisiblePlane() | (GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
        else
        {
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() | (GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
    }
    else
    {
        if (work->useEngineB == FALSE)
        {
            GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
        else
        {
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
    }

    work->windowMode = enabled;
}

s32 GetNavTailsWindowForDialog(NavTails *work)
{
    u32 seqCount          = FontAnimator__GetSequenceDialogCount(&work->fontAnimator);
    u32 requiredLineCount = 0;

    for (u16 i = 0; i < seqCount; i++)
    {
        u32 lineCount = FontAnimator__GetDialogLineCount(&work->fontAnimator, i);
        if (requiredLineCount < lineCount)
            requiredLineCount = lineCount;
    }

    switch (requiredLineCount)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            return 0;

        case 4:
            return 1;

        case 5:
            return 2;
    }

    return 0;
}

void LoadNavTailsAssets(NavTailsAssets *assets)
{
    NNSFndArchive arc;

    MI_CpuClear16(assets, sizeof(*assets));

    GetCompressedFileFromBundle("bb/nv.bb", BUNDLE_NV_FILE_RESOURCES_BB_NV_NAV_ASSETS_NARC, &assets->archiveNv, TRUE);
    NNS_FndMountArchive(&arc, "nv", assets->archiveNv);

    assets->sprNav = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_NAV_ASSETS_FILE_NV_BAC);
    assets->bgNav  = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_NAV_ASSETS_FILE_NV_BG_BBG);
    for (s32 i = 0; i < 4; i++)
    {
        assets->bgMsgWindow[i] = NNS_FndGetArchiveFileByIndex(&arc, i + ARCHIVE_NAV_ASSETS_FILE_NV_MSG_WIN_3_BBG);
    }

    s32 textFileID;
    switch (GetGameLanguage())
    {
        case OS_LANGUAGE_JAPANESE:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_JPN_MPC;
            break;

        case OS_LANGUAGE_ENGLISH:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_ENG_MPC;
            break;

        case OS_LANGUAGE_FRENCH:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_FRA_MPC;
            break;

        case OS_LANGUAGE_GERMAN:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_DEU_MPC;
            break;

        case OS_LANGUAGE_ITALIAN:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_ITA_MPC;
            break;

        case OS_LANGUAGE_SPANISH:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_SPA_MPC;
            break;
    }

    assets->mpcText = NNS_FndGetArchiveFileByIndex(&arc, textFileID);
    NNS_FndUnmountArchive(&arc);
}

void ReleaseNavTailsAssets(NavTailsAssets *assets)
{
    HeapFree(HEAP_USER, assets->archiveNv);

    if (assets->bgTails != NULL)
    {
        HeapFree(HEAP_USER, assets->bgTails);
        assets->bgTails = NULL;
    }

    MI_CpuClear16(assets, sizeof(*assets));
}

void LoadNavTailsTailsSprite(NavTailsAssets *assets, u32 id)
{
    static u16 const tailsBackgroundFileID[7] = { BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_1_BBG, BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_2_BBG,
                                                  BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_3_BBG, BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_4_BBG,
                                                  BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_5_BBG, BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_6_BBG,
                                                  BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_7_BBG };

    if (assets->tailsSpriteID != id)
    {
        if (assets->bgTails != NULL)
        {
            HeapFree(HEAP_USER, assets->bgTails);
            assets->bgTails = NULL;
        }

        assets->bgTails       = ReadFileFromBundle("bb/nv.bb", tailsBackgroundFileID[id], BINARYBUNDLE_AUTO_ALLOC_HEAD);
        assets->tailsSpriteID = id;
    }
}

void InitNavTailsBG_Nav(NavTails *work)
{
    Background background;

    void *bgAsset = work->assets.bgNav;
    InitBackground(&background, bgAsset, BACKGROUND_FLAG_LOAD_ALL, work->useEngineB, BACKGROUND_3,
                   GetBackgroundWidth(bgAsset), GetBackgroundHeight(bgAsset));
    DrawBackground(&background);
}

void InitNavTailsBG_Tails(NavTails *work)
{
    Background background;

    void *bgAsset = work->assets.bgTails;
    InitBackground(&background, bgAsset, BACKGROUND_FLAG_LOAD_MAPPINGS_PIXELS | BACKGROUND_FLAG_DISABLE_PALETTE, work->useEngineB, BACKGROUND_2,
                   GetBackgroundWidth(bgAsset), GetBackgroundHeight(bgAsset));
    DrawBackground(&background);
}

void InitNavTailsBG_MsgWindow(NavTails *work, s32 id)
{
    static Vec2U16 const messageWindowPos[4] = {
        { -12, -16 },
        { -12, -16 },
        { -12, -16 },
        { -12, -16 },
    };

    Background background;

    void *bgAsset = work->assets.bgMsgWindow[id];
    InitBackground(&background, bgAsset, BACKGROUND_FLAG_LOAD_MAPPINGS_PIXELS | BACKGROUND_FLAG_DISABLE_PALETTE, work->useEngineB, BACKGROUND_1,
                   GetBackgroundWidth(bgAsset), GetBackgroundHeight(bgAsset));
    background.vramPixels = background.vramPixels + 0x2000;
    DrawBackground(&background);

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    gfxControl->bgPosition[0].x = messageWindowPos[id].x;
    gfxControl->bgPosition[0].y = messageWindowPos[id].y;
    work->messageWindowID       = id;
}

void ClearNavTailsBackground(NavTails *work)
{
    MappingsMode mappingsMode;
    u16 screenBaseA;
    u16 screenBaseBlock;

    GetVRAMTileConfig(work->useEngineB, BACKGROUND_0, &mappingsMode, &screenBaseA, &screenBaseBlock);

    int baseBlock = 0x10000 * screenBaseA + 0x800 * screenBaseBlock;
    MI_CpuFill16(VRAMSystem__VRAM_BG[work->useEngineB] + baseBlock, 0x100, 0x800);
}

NONMATCH_FUNC void NavTails_FontCallback(u32 type, FontAnimator *animator, void *context)
{
#ifdef NON_MATCHING
    NavTails *work = (NavTails *)context;

    BOOL useEngineB = work->useEngineB;

    if (type < 10 || type > 14)
    {
        if (type >= 15 && type <= 20)
            SetNewNavTailsBackground(work, type - 14);
    }
    else
    {
        u32 id = type - 10;

        NavTailsAnimConfig3 *config = &NavTails__FontAniInfo[id];
        AnimatorSprite *ani         = &context->aniChart[type + 17];

        AnimatorSprite__Init(ani, work->assets.sprNav, NavTails__FontAniInfo[id].animID, ANIMATOR_FLAG_NONE, useEngineB, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize1FromAnim(work->assets.sprNav, NavTails__FontAniInfo[id].animID)), PALETTE_MODE_SPRITE,
                             VRAMSystem__VRAM_PALETTE_OBJ[useEngineB], SPRITE_PRIORITY_0, SPRITE_ORDER_10);
        ani->palette = config->paletteRow;
        AnimatorSprite__ProcessAnimationFast(ani);

        FontAnimator__GetMsgPosition(animator, &ani->pos.x, &ani->pos.y);
        ani->pos.x -= VRAMSystem__GFXControl[useEngineB].bgPosition[0].x;
        ani->pos.y -= VRAMSystem__GFXControl[useEngineB].bgPosition[0].y;
        FontAnimator__AdvanceXPos(animator, config->advance);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r3, r0
	mov r8, r1
	cmp r3, #0xa
	ldr r7, [r2, #0]
	ldr r4, [r2, #8]
	blo _0203D898
	cmp r3, #0xe
	bhi _0203D898
	sub r3, r3, #0xa
	mov r0, #6
	mul r9, r3, r0
	ldr r10, =NavTails__FontAniInfo
	add r2, r2, #0x344
	add r6, r2, #0x1000
	mov r2, #0x64
	ldrh r1, [r10, r9]
	mov r0, r4
	add r5, r10, r9
	mla r6, r3, r2, r6
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r7
	bl VRAMSystem__AllocSpriteVram
	str r7, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, r4
	ldr r4, [r0, r7, lsl #2]
	str r3, [sp, #0xc]
	str r4, [sp, #0x10]
	mov r2, #0xa
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	ldrh r2, [r10, r9]
	mov r0, r6
	bl AnimatorSprite__Init
	ldrh r2, [r5, #2]
	mov r1, #0
	mov r0, r6
	strh r2, [r6, #0x50]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, =VRAMSystem__GFXControl
	mov r0, r8
	ldr r4, [r1, r7, lsl #2]
	add r1, r6, #8
	add r2, r6, #0xa
	bl FontAnimator__GetMsgPosition
	ldrsh r2, [r6, #8]
	ldrh r1, [r4, #0]
	mov r0, r8
	sub r1, r2, r1
	strh r1, [r6, #8]
	ldrh r1, [r4, #2]
	ldrsh r2, [r6, #0xa]
	sub r1, r2, r1
	strh r1, [r6, #0xa]
	ldrsh r1, [r5, #4]
	bl FontAnimator__AdvanceXPos
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_0203D898:
	cmp r3, #0xf
	addlo sp, sp, #0x1c
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r3, #0x14
	addhi sp, sp, #0x1c
	ldmhiia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r2
	sub r1, r3, #0xe
	bl SetNewNavTailsBackground
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void NavTails_StateTalk_Speaking(NavTails *work)
{
    if (work->windowMode != 0 && work->speakDuration != 0)
    {
        work->speakDuration--;
        if (work->speakDuration == 0)
        {
            if (CheckNavTailsSpeaking())
            {
                NavTailsSpeak(NAVTAILS_MSGSEQ_NONE, 1);
            }
            else
            {
                SetNavTailsWindowMode(work, 0);
                ReleaseUnknownNavTailsSprites(work);
            }
        }
    }
}

void NavTails_StateTalk_SpeakDelay(NavTails *work)
{
    if (work->speakDelay == 0)
    {
        FontAnimator__LoadCharacters(&work->fontAnimator, 1);
        FontAnimator__Draw(&work->fontAnimator);

        if (CheckNavTailsSpeaking() && work->windowMode == 0)
        {
            InitNavTailsBG_MsgWindow(work, GetNavTailsWindowForDialog(work));
            SetNavTailsWindowMode(work, 1);
        }

        work->speakDelay = 0;
        if (FontAnimator__IsLastDialog(&work->fontAnimator))
            work->stateTalk = NavTails_StateTalk_Speaking;
    }
    else
    {
        work->speakDelay--;
    }
}

void NavTails_StateDMA_Idle(NavTails *work)
{
    // Do Nothing.
}

void NavTails_StateDMA_PrepareChange(NavTails *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];
    RenderCore_SetWnd0InsidePlane(&gfxControl->windowManager, GX_WND_PLANEMASK_OBJ | GX_WND_PLANEMASK_BG3 | GX_WND_PLANEMASK_BG2 | GX_WND_PLANEMASK_BG1 | GX_WND_PLANEMASK_BG0,
                                  TRUE);
    RenderCore_SetWndOutsidePlane(&gfxControl->windowManager, GX_WND_PLANEMASK_OBJ | GX_WND_PLANEMASK_BG3 | GX_WND_PLANEMASK_BG1 | GX_WND_PLANEMASK_BG0, TRUE);
    RenderCore_SetWindow0Position(&gfxControl->windowManager, 128, 0, HW_LCD_WIDTH, HW_LCD_HEIGHT);
    gfxControl->windowManager.visible = TRUE;

    u32 windowRegisters[2] = { REG_WIN0H_ADDR, REG_DB_WIN0H_ADDR };

    RenderCore_StopDMA(1);
    MI_CpuFill16(work->dma.buffer, 0x8000, sizeof(work->dma.buffer));
    RenderCore_PrepareDMA(1, &work->dma.buffer[0], work->dma.buffer[1], (void *)windowRegisters[work->useEngineB], ARRAY_COUNT(windowRegisters));

    struct NavTailsDMA *dma = &work->dma;
    dma->updateID           = 0;
    dma->timer              = 0;

    work->stateDMA = NavTails_StateDMA_HideOldBackground;
}

void NavTails_StateDMA_HideOldBackground(NavTails *work)
{
    u16 *dmaSrc      = RenderCore_GetDMASrc(1);
    BOOL changeState = FALSE;

    struct NavTailsDMA *dma = &work->dma;

    dma->timer++;
    if (dma->timer != 0)
    {
        dma->updateID++;
        if (dma->updateID < 8)
        {
            for (s32 i = 0; i < HW_LCD_HEIGHT; i++)
            {
                if (dma->updateID < (i & 7))
                    dmaSrc[i] = 0x8000;
                else
                    dmaSrc[i] = 0x8081;
            }
        }
        else
        {
            MI_CpuFill16(dmaSrc, 0x8081, sizeof(dma->buffer[0]));
            changeState = TRUE;
        }

        dma->timer = 0;
        RenderCore_PrepareDMASwapBuffer(1);
    }

    if (changeState)
        work->stateDMA = NavTails_StateDMA_LoadNewTailsSprite;
}

void NavTails_StateDMA_LoadNewTailsSprite(NavTails *work)
{
    LoadNavTailsTailsSprite(&work->assets, work->dma.tailsBackgroundID);
    InitNavTailsBG_Tails(work);

    struct NavTailsDMA *dma = &work->dma;
    dma->updateID           = 0;
    dma->timer              = 0;

    work->stateDMA = NavTails_StateDMA_ShowNewBackground;
}

void NavTails_StateDMA_ShowNewBackground(NavTails *work)
{
    u16 *dmaSrc      = RenderCore_GetDMASrc(1);
    BOOL changeState = FALSE;

    struct NavTailsDMA *dma = &work->dma;

    dma->timer++;
    if (dma->timer != 0)
    {
        dma->updateID++;
        if (dma->updateID < 8)
        {
            for (s32 i = 0; i < HW_LCD_HEIGHT; i++)
            {
                if (dma->updateID <= 7 - (i & 7))
                    dmaSrc[i] = 0x8081;
                else
                    dmaSrc[i] = 0x8000;
            }
        }
        else
        {
            MI_CpuFill16(dmaSrc, 0x8000, sizeof(dma->buffer[0]));
            changeState = TRUE;
        }

        dma->timer = 0;
        RenderCore_PrepareDMASwapBuffer(1);
    }

    if (changeState)
        work->stateDMA = NavTails_StateDMA_EndChange;
}

void NavTails_StateDMA_EndChange(NavTails *work)
{
    RenderCore_StopDMA(1);

    VRAMSystem__GFXControl[work->useEngineB]->windowManager.visible = 0x00;
    work->stateDMA                                                  = NavTails_StateDMA_Idle;
}

// --------------------
// UNREFERENCED VARS
// --------------------

FORCE_INCLUDE_ARRAY(void *, displayControl_2, 2, { &reg_GX_DISPCNT, &reg_GXS_DB_DISPCNT })