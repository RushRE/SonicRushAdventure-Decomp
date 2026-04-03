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

static void SpriteButtonTouchAreaResponseHandler(TouchAreaResponse *response, TouchArea *area, SpriteButton *work, s32 id);
static void SpriteButtonTouchAreaCB_YesButton(TouchAreaResponse *response, TouchArea *area, void *context);
static void SpriteButtonTouchAreaCB_NoButton(TouchAreaResponse *response, TouchArea *area, void *context);

// --------------------
// VARIABLES
// --------------------

static Task *sSpriteButtonTaskSingleton;

static const SpriteButtonInfo sButtonConfig[2] = {
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

void CreateSpriteButton(SpriteButtonConfig *config)
{
    Task *task       = TaskCreate(SpriteButton_Main, SpriteButton_Destructor, TASK_FLAG_NONE, 0, 0x64, TASK_GROUP(0), SpriteButton);
    sSpriteButtonTaskSingleton = task;

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
        work->touchFieldPtr->mode = TOUCHFIELD_MODE_0;
    }

    void *sprButton = GetSpriteButtonYesNoButtonSprite();
    if (sprButton == NULL)
    {
        LoadSpriteButtonYesNoButtonSprite(GetGameLanguage());
        sprButton                   = GetSpriteButtonYesNoButtonSprite();
        work->allocatedButtonSprite = 1;
    }

    for (u32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        if ((config->activeButtons & (1 << i)) != 0)
        {
            const SpriteButtonInfo *buttonConfig = &sButtonConfig[i];
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
                                 PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[config->useEngineB]), config->oamPriority, config->oamOrder);

            button->animator.pos.x = buttonConfig->pos.x;
            button->animator.pos.y = buttonConfig->pos.y;

            HitboxRect hitbox;
            AnimatorSprite__GetBlockData(&button->animator, 0, &hitbox);

            TouchField__InitAreaShape(&button->touchArea, &button->animator.pos, TouchField__PointInRect, (TouchRectUnknown*)&hitbox, buttonConfig->callback, work);
            TouchField__AddArea(work->touchFieldPtr, &button->touchArea, 0);
            SetSpriteButtonState(button, SPRITE_BUTTON_STATE_IDLE);
        }
    }
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
    return TaskGetWork(sSpriteButtonTaskSingleton, SpriteButton);
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

    sSpriteButtonTaskSingleton = NULL;
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

void SpriteButtonTouchAreaResponseHandler(TouchAreaResponse *response, TouchArea *area, SpriteButton *work, s32 id)
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
    SpriteButtonTouchAreaResponseHandler(response, area, context, 0);
}

void SpriteButtonTouchAreaCB_NoButton(TouchAreaResponse *response, TouchArea *area, void *context)
{
    SpriteButtonTouchAreaResponseHandler(response, area, context, 1);
}
