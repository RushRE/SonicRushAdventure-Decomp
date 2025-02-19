#include <game/util/spriteButton.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/renderCore.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SpriteButtonInfo_
{
    u8 animID;
    Vec2Fx16 pos;
    TouchAreaCallback callback;
} SpriteButtonInfo;

// --------------------
// FUNCTION DECLS
// --------------------

static void SpriteButton_Main(void);
static void SpriteButton_Destructor(Task *task);
static void SpriteButton_Draw(SpriteButton *work);

static void SpriteButtonTouchAreaResponceHandler(TouchAreaResponse *response, TouchArea *area, SpriteButton *work, s32 id);
static void SpriteButtonTouchAreaCB_YesButton(TouchAreaResponse *response, TouchArea *area, void *context);
static void SpriteButtonTouchAreaCB_NoButton(TouchAreaResponse *response, TouchArea *area, void *context);

// --------------------
// VARIABLES
// --------------------

static Task *spriteButtonTask;

static const SpriteButtonInfo spriteButtonConfig[2] = {
    { .animID = 9, .pos = { 92, 128 }, SpriteButtonTouchAreaCB_YesButton },
    { .animID = 12, .pos = { 164, 128 }, SpriteButtonTouchAreaCB_NoButton },
};

// --------------------
// FUNCTIONS
// --------------------

void InitSpriteButtonConfig(SpriteButtonConfig *config, BOOL useEngineB, SpriteButtonActiveButtons activeButtons)
{
    MI_CpuClear16(config, sizeof(SpriteButtonConfig));
    config->useEngineB    = useEngineB;
    config->activeButtons = activeButtons;
}

NONMATCH_FUNC void CreateSpriteButton(SpriteButtonConfig *config)
{
    // https://decomp.me/scratch/NyJfr -> 96.94%
    // registers and such are busted around VRAMSystem__VRAM_PALETTE_OBJ
#ifdef NON_MATCHING
    Task *task       = TaskCreate(SpriteButton_Main, SpriteButton_Destructor, TASK_FLAG_NONE, 0, 0x64, TASK_GROUP(0), SpriteButton);
    spriteButtonTask = task;

    SpriteButton *work = TaskGetWork(task, SpriteButton);
    TaskInitWork16(work);

    MI_CpuCopy16(config, &work->config, sizeof(SpriteButtonConfig));
    work->selectedButton = -1;

    if (config->touchField != NULL)
    {
        work->touchFieldPtr = config->touchField;
    }
    else
    {
        work->touchFieldPtr = &work->touchField;
        TouchField__Init(&work->touchField);
        work->touchFieldPtr->field_C = 0;
    }

    void *sprButton = GetSpriteButtonYesNoButtonSprite();
    if (sprButton == NULL)
    {
        LoadSpriteButtonYesNoButtonSprite(GetGameLanguage());
        sprButton                   = GetSpriteButtonYesNoButtonSprite();
        work->allocatedButtonSprite = 1;
    }

    for (u32 i = 0; i < 2; i++)
    {
        if ((config->activeButtons & (1 << i)) != 0)
        {
            SpriteButtonInfo *buttonConfig = &spriteButtonConfig[i];
            SpriteButtonAnimator *button   = &work->animators[i];

            button->animID = buttonConfig->animID;
            for (u32 r = 0; r < 3; r++)
            {
                button->paletteRow[r] = config->paletteRow[r];
            }

            VRAMPixelKey vramPixels = config->vramPixels[i];
            if (vramPixels == NULL)
            {
                vramPixels = VRAMSystem__AllocSpriteVram(config->useEngineB, GetSpriteButtonSpriteAllocSize(sprButton, i));
            }

            AnimatorSprite__Init(&button->animator, sprButton, button->animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, config->useEngineB, PIXEL_MODE_SPRITE, vramPixels,
                                 PALETTE_MODE_SPRITE, VRAMSystem__VRAM_PALETTE_OBJ[config->useEngineB], config->oamPriority, config->oamOrder);

            button->animator.pos.x = buttonConfig->pos.x;
            button->animator.pos.y = buttonConfig->pos.y;

            TouchRectUnknown rect;
            AnimatorSprite__GetBlockData(&button->animator, 0, &rect.box);

            TouchField__InitAreaShape(&button->touchArea, &button->animator.pos, TouchField__PointInRect, &rect, buttonConfig->callback, work);
            TouchField__AddArea(work->touchFieldPtr, &button->touchArea, 0);
            SetSpriteButtonState(button, SPRITE_BUTTON_STATE_IDLE);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x24
	mov r1, #0x64
	mov r9, r0
	mov r2, #0
	str r1, [sp]
	ldr r0, =SpriteButton_Main
	ldr r1, =SpriteButton_Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0x190
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, =spriteButtonTask
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x190
	bl MIi_CpuClear16
	mov r0, r9
	mov r1, r4
	mov r2, #0x20
	bl MIi_CpuCopy16
	mvn r0, #0
	str r0, [r4, #0x18c]
	ldr r0, [r9, #4]
	cmp r0, #0
	strne r0, [r4, #0x16c]
	bne _02002710
	add r0, r4, #0x170
	str r0, [r4, #0x16c]
	bl TouchField__Init
	ldr r0, [r4, #0x16c]
	mov r1, #0
	str r1, [r0, #0xc]
_02002710:
	bl GetSpriteButtonYesNoButtonSprite
	movs r5, r0
	bne _0200276C
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02002754
_02002730: // jump table
	b _02002748 // case 0
	b _02002748 // case 1
	b _02002748 // case 2
	b _02002748 // case 3
	b _02002748 // case 4
	b _02002748 // case 5
_02002748:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02002758
_02002754:
	mov r0, #1
_02002758:
	bl LoadSpriteButtonYesNoButtonSprite
	bl GetSpriteButtonYesNoButtonSprite
	mov r1, #1
	mov r5, r0
	str r1, [r4, #0x188]
_0200276C:
	ldr r7, =spriteButtonConfig
	add r8, r4, #0x20
	mov r6, #0
_02002778:
	ldr r1, [r9, #0x18]
	mov r0, #1
	tst r1, r0, lsl r6
	beq _02002880
	ldrb r0, [r7, #0]
	mov r2, #0
	strh r0, [r8, #0xa2]
_02002794:
	add r0, r9, r2, lsl #1
	ldrh r1, [r0, #0x10]
	add r0, r8, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blo _02002794
	add r0, r9, r6, lsl #2
	ldr r0, [r0, #8]
	cmp r0, #0
	bne _020027DC
	mov r1, r6, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl GetSpriteButtonSpriteAllocSize
	mov r1, r0
	ldr r0, [r9, #0]
	bl VRAMSystem__AllocSpriteVram
_020027DC:
	ldr r2, [r9, #0]
	mov r1, #0
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r2, [r9, #0]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r0, r8
	ldr r2, [r1, r2, lsl #2]
	mov r1, r5
	str r2, [sp, #0x10]
	ldrb r2, [r9, #0x1c]
	mov r3, #0x800
	str r2, [sp, #0x14]
	ldrb r2, [r9, #0x1d]
	str r2, [sp, #0x18]
	ldrh r2, [r8, #0xa2]
	bl AnimatorSprite__Init
	ldrsh r1, [r7, #2]
	add r2, sp, #0x1c
	mov r0, r8
	strh r1, [r8, #8]
	ldrsh r3, [r7, #4]
	mov r1, #0
	strh r3, [r8, #0xa]
	bl AnimatorSprite__GetBlockData
	ldr r1, [r7, #8]
	ldr r2, =TouchField__PointInRect
	stmia sp, {r1, r4}
	add r0, r8, #0x64
	add r1, r8, #8
	add r3, sp, #0x1c
	bl TouchField__InitAreaShape
	ldr r0, [r4, #0x16c]
	add r1, r8, #0x64
	mov r2, #0
	bl TouchField__AddArea
	mov r0, r8
	mov r1, #0
	bl SetSpriteButtonState
_02002880:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0xc
	add r8, r8, #0xa4
	blo _02002778
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void DestroySpriteButton(void)
{
    SpriteButton *work = GetSpriteButtonWork();
    work->destroyRequested   = TRUE;
}

s32 GetSelectedSpriteButton(void)
{
    SpriteButton *work = GetSpriteButtonWork();
    return work->selectedButton;
}

void SetSpriteButtonPosition(SpriteButtonAnimator *button, s16 x, s16 y)
{
    button->animator.pos.x = x;
    button->animator.pos.y = y;

    button->touchArea.shape.position.x = x;
    button->touchArea.shape.position.y = y;
}

size_t GetSpriteButtonSpriteAllocSize(void *spriteFile, u16 animID)
{
    size_t size = Sprite__GetSpriteSize1FromAnim(spriteFile, (s32)animID);

    size_t size1 = Sprite__GetSpriteSize1FromAnim(spriteFile, animID + 1);
    if (size < size1)
        size = size1;

    size_t size2 = Sprite__GetSpriteSize1FromAnim(spriteFile, animID + 2);
    if (size < size2)
        size = size2;

    return size;
}

void SetSpriteButtonState(SpriteButtonAnimator *button, SpriteButtonState state)
{
    u16 anim;
    switch (state)
    {
        case SPRITE_BUTTON_STATE_IDLE:
            anim = button->animID;
            break;

        case SPRITE_BUTTON_STATE_HOVERED:
            anim = button->animID + 1;
            break;

        case SPRITE_BUTTON_STATE_SELECTED:
            anim = button->animID + 2;
            break;
    }

    AnimatorSprite__SetAnimation(&button->animator, anim);
    button->animator.cParam.palette = button->paletteRow[state];
}

SpriteButton *GetSpriteButtonWork(void)
{
    return TaskGetWork(spriteButtonTask, SpriteButton);
}

void SpriteButton_Main(void)
{
    SpriteButton *work = TaskGetWorkCurrent(SpriteButton);

    if (work->destroyRequested)
    {
        DestroyCurrentTask();
    }
    else
    {
        TouchField__Process(work->touchFieldPtr);
        SpriteButton_Draw(work);
    }
}

void SpriteButton_Destructor(Task *task)
{
    SpriteButton *work = TaskGetWork(task, SpriteButton);

    for (u32 i = 0; i < 2; i++)
    {
        SpriteButtonAnimator *button = &work->animators[i];

        if ((work->config.activeButtons & (1 << i)) != 0)
        {
            if (work->config.vramPixels[i] == NULL)
                VRAMSystem__FreeSpriteVram(work->config.useEngineB, button->animator.vramPixels);

            TouchField__RemoveArea(work->touchFieldPtr, &button->touchArea);
        }
    }

    if (work->allocatedButtonSprite)
        ReleaseSpriteButtonYesNoButtonSprite();

    spriteButtonTask = NULL;
}

void SpriteButton_Draw(SpriteButton *work)
{
    for (u32 i = 0; i < 2; i++)
    {
        if ((work->config.activeButtons & (1 << i)) != 0)
        {
            SpriteButtonAnimator *button = &work->animators[i];

            AnimatorSprite__ProcessAnimationFast(&button->animator);
            AnimatorSprite__DrawFrame(&button->animator);
            QueueUncompressedPalette(&work->config.paletteRow[3], PALETTE_MODE_BG, button->animator.paletteMode,
                                  VRAMKEY_TO_KEY(&((u16 *)button->animator.vramPalette)[16 * button->animator.cParam.palette + PALETTE_ROW_15]));
        }
    }
}

void SpriteButtonTouchAreaResponceHandler(TouchAreaResponse *response, TouchArea *area, SpriteButton *work, s32 id)
{
    TouchAreaResponseFlags flags = area->responseFlags;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_40000:
            work->selectedButton = id;
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
        case TOUCHAREA_RESPONSE_ENTERED_AREA:
            if ((flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                SetSpriteButtonState(&work->animators[id], SPRITE_BUTTON_STATE_HOVERED);
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
        case TOUCHAREA_RESPONSE_EXITED_AREA:
            if ((flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                SetSpriteButtonState(&work->animators[id], SPRITE_BUTTON_STATE_IDLE);
            break;
    }
}

void SpriteButtonTouchAreaCB_YesButton(TouchAreaResponse *response, TouchArea *area, void *context)
{
    SpriteButtonTouchAreaResponceHandler(response, area, context, 0);
}

void SpriteButtonTouchAreaCB_NoButton(TouchAreaResponse *response, TouchArea *area, void *context)
{
    SpriteButtonTouchAreaResponceHandler(response, area, context, 1);
}
