#include <hub/hubHUD.hpp>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/graphics/drawReqTask.h>
#include <hub/hubConfig.h>
#include <hub/hubControl.hpp>

// resources
#include <resources/narc/vi_act_lz7.h>
#include <resources/bb/vi_act_loc/vi_act_loc_eng.h>

// --------------------
// STRUCTS
// --------------------

struct HubHUDUserData
{
    HubHUD *hud;
    u32 id;
};

// --------------------
// VARIABLES
// --------------------

static Task *taskSingleton;

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

RUSH_INLINE BOOL CheckTouchOnEnabled()
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_ON(touchInput.flags))
            return TRUE;
    }

    return FALSE;
}

// --------------------
// FUNCTIONS
// --------------------

void HubHUD::Create(void)
{
    taskSingleton = HubTaskCreate(HubHUD::Main_Idle, HubHUD::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1020, TASK_GROUP(16), HubHUD);

    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    HubHUD::InitGraphics(work);
    work->unknown1 = 7;
}

void HubHUD::Destroy(void)
{
    if (taskSingleton != NULL)
    {
        DestroyTask(taskSingleton);
        taskSingleton = NULL;
    }
}

void HubHUD::ConfigureViewButton(BOOL visible, BOOL enabled)
{
    if (visible == FALSE)
        enabled = FALSE;

    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if (visible)
    {
        work->viewButton.flags |= HubHUD::BUTTONFLAG_VISIBLE;
    }
    else
    {
        work->viewButton.flags &= ~HubHUD::BUTTONFLAG_VISIBLE;
        HubHUD::EnableViewCursor(work);
    }

    HubHUD::SetViewButtonTouchAreaEnabled(work, enabled);
}

BOOL HubHUD::LookAroundEnabled(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    return (work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) != 0;
}

void HubHUD::DisableLookAround(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    work->viewButton.flags &= ~HubHUD::BUTTONFLAG_ACTIVE;
    HubHUD::EnableViewCursor(work);
}

BOOL HubHUD::GetLookAroundBtnLeft(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) == 0)
        return FALSE;

    return (padInput.btnDown & PAD_KEY_LEFT) != 0;
}

BOOL HubHUD::GetLookAroundBtnUp(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) == 0)
        return FALSE;

    return (padInput.btnDown & PAD_KEY_UP) != 0;
}

BOOL HubHUD::GetLookAroundBtnRight(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) == 0)
        return FALSE;

    return (padInput.btnDown & PAD_KEY_RIGHT) != 0;
}

BOOL HubHUD::GetLookAroundBtnDown(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) == 0)
        return FALSE;

    return (padInput.btnDown & PAD_KEY_DOWN) != 0;
}

BOOL HubHUD::GetTouchHeld(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    return work->touchHeld;
}

void HubHUD::GetTouchMove(s16 *x, s16 *y)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if (work->touchHeld)
    {
        if (x != NULL)
            *x = work->touchMove.x;
        if (y != NULL)
            *y = work->touchMove.y;
    }
    else
    {
        if (x != NULL)
            *x = 0;
        if (y != NULL)
            *y = 0;
    }
}

void HubHUD::GetTouchPos(s16 *x, s16 *y)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if (work->touchHeld)
    {
        if (x != NULL)
            *x = work->touchPos.x;
        if (y != NULL)
            *y = work->touchPos.y;
    }
    else
    {
        if (x != NULL)
            *x = 0;
        if (y != NULL)
            *y = 0;
    }
}

void HubHUD::ConfigureMenuButton(BOOL visible, BOOL enabled)
{
    if (visible == FALSE)
        enabled = FALSE;

    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    if (visible)
        work->menuButton.flags |= HubHUD::BUTTONFLAG_VISIBLE;
    else
        work->menuButton.flags &= ~HubHUD::BUTTONFLAG_VISIBLE;

    HubHUD::SetMenuButtonTouchAreaEnabled(work, enabled);
}

BOOL HubHUD::ShouldOpenMainMenu(void)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);
    return work->openMainMenu;
}

void HubHUD::InitGraphics(HubHUD *work)
{
    work->sprViFix    = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_FIX_BAC);
    work->sprViFixLoc = HubControl::GetFileFrom_ViActLoc(ARCHIVE_VI_ACT_LOC_ENG_FILE_VI_FIX_LOC_BAC);

    HubHUD::InitViewButtons(work);
    HubHUD::InitMenuButton(work);
    HubHUD::InitTouchField(work);

    work->touchHeld = FALSE;
}

void HubHUD::InitViewButtons(HubHUD *work)
{
    MI_CpuClear32(&work->viewButton, sizeof(work->viewButton));

    VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3(work->sprViFix));
    AnimatorSprite__Init(&work->viewButton.aniButton, work->sprViFix, 0, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE,
                         VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->viewButton.aniButton.cParam.palette = PALETTE_ROW_0;
    work->viewButton.aniButton.colorCount     = 16;

    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(work->sprViFix, 3));
    AnimatorSprite__Init(&work->viewButton.aniArrow, work->sprViFix, 3, ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                         vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->viewButton.aniArrow.cParam.palette = PALETTE_ROW_1;
    work->viewButton.aniArrow.colorCount     = 16;
}

void HubHUD::InitMenuButton(HubHUD *work)
{
    work->openMainMenu = FALSE;
    work->unknown2     = 0;

    MI_CpuClear32(&work->menuButton, sizeof(work->menuButton));

    AnimatorSprite *aniButtonA = &work->menuButton.aniSprite[GRAPHICS_ENGINE_A];
    VRAMPixelKey vramPixels    = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1(work->sprViFixLoc));
    AnimatorSprite__Init(aniButtonA, work->sprViFixLoc, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    aniButtonA->cParam.palette = PALETTE_ROW_2;
    aniButtonA->colorCount     = 16;

    AnimatorSprite *aniButtonB = &work->menuButton.aniSprite[GRAPHICS_ENGINE_B];
    vramPixels                 = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3(work->sprViFixLoc));
    AnimatorSprite__Init(aniButtonB, work->sprViFixLoc, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    aniButtonB->cParam.palette = PALETTE_ROW_2;
    aniButtonB->colorCount     = 16;
}

void HubHUD::InitTouchField(HubHUD *work)
{
    TouchField__Init(&work->touchField);
    work->touchField.delayDuration1 = 0;

    TouchField__InitAreaShape(&work->touchArea[0], NULL, TouchField__PointInRect, NULL, HubHUD::TouchAreaCallback_ViewButton, NULL);
    work->touchAreaEnabled[0] = FALSE;

    TouchField__InitAreaShape(&work->touchArea[1], NULL, TouchField__PointInRect, NULL, HubHUD::TouchAreaCallback_MenuButton, NULL);
    work->touchAreaEnabled[1] = FALSE;

    HubHUD::SetAllTouchAreasDisabled(work);
}

void HubHUD::Release(HubHUD *work)
{
    HubHUD::ReleaseTouchField(work);
    HubHUD::ReleaseMenuButtons(work);
    HubHUD::ReleaseViewButtons(work);
}

void HubHUD::ReleaseViewButtons(HubHUD *work)
{
    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->viewButton.animators); i++)
    {
        AnimatorSprite__Release(&work->viewButton.animators[i]);
        MI_CpuClear32(&work->viewButton.animators[i], sizeof(work->viewButton.animators[i]));
    }
}

void HubHUD::ReleaseMenuButtons(HubHUD *work)
{
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        AnimatorSprite__Release(&work->menuButton.aniSprite[i]);
        MI_CpuClear32(&work->menuButton.aniSprite[i], sizeof(work->menuButton.aniSprite[i]));
    }
}

void HubHUD::ReleaseTouchField(HubHUD *work)
{
    MI_CpuClear32(&work->touchField, sizeof(work->touchField));
    MI_CpuClear32(work->touchArea, sizeof(work->touchArea));
    MI_CpuClear32(work->touchAreaFlags, sizeof(work->touchAreaFlags));
}

void HubHUD::Main_Idle(void)
{
    HubHUD *work = TaskGetWorkCurrent(HubHUD);

    TouchField__Process(&work->touchField);

    BOOL viewButtonPressed;
    BOOL unknownFlag;

    work->openMainMenu = FALSE;
    work->unknown2     = 0;

    unknownFlag       = FALSE;
    viewButtonPressed = FALSE;

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_VISIBLE) != 0)
    {
        u32 flags = work->touchAreaFlags[0];
        if ((flags & HubHUD::TOUCHAREAFLAG_ENABLED) != 0)
        {
            if (HubControl::Func_2157178())
            {
                if ((flags & HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED) != 0)
                {
                    viewButtonPressed = TRUE;
                    unknownFlag       = TRUE;
                    work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
                }

                if ((flags & HubHUD::TOUCHAREAFLAG_BUTTON_HELD) != 0)
                    unknownFlag = TRUE;
            }

            if ((padInput.btnPress & PAD_BUTTON_X) != 0)
                viewButtonPressed = TRUE;
        }
    }

    if (!viewButtonPressed && (work->menuButton.flags & HubHUD::BUTTONFLAG_VISIBLE) != 0)
    {
        u32 flags = work->touchAreaFlags[1];
        if ((flags & HubHUD::TOUCHAREAFLAG_ENABLED) != 0)
        {
            if (HubControl::Func_2157178())
            {
                if ((flags & HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED) != 0)
                {
                    unknownFlag        = TRUE;
                    work->openMainMenu = TRUE;
                    work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
                }

                if ((flags & HubHUD::TOUCHAREAFLAG_BUTTON_HELD) != 0)
                    unknownFlag = TRUE;
            }

            if ((padInput.btnPress & PAD_BUTTON_Y) != 0)
                work->openMainMenu = TRUE;
        }
    }

    if (viewButtonPressed)
    {
        work->viewButton.flags |= HubHUD::BUTTONFLAG_ACTIVE;
        HubHUD::ConfigureMenuButton(FALSE, TRUE);
        work->touchHeld = FALSE;
        AnimatorSprite__SetAnimation(&work->viewButton.aniButton, 2);
        SetCurrentTaskMainEvent(HubHUD::Main_LookAround);
    }

    HubHUD::ProcessViewButtons(work);
    HubHUD::DrawViewButtons(work);
    HubHUD::ProcessMenuButton(work);
    HubHUD::DrawMenuButton(work);

    if (unknownFlag)
        HubControl::Func_2157154();
}

void HubHUD::Main_LookAround(void)
{
    HubHUD *work = TaskGetWorkCurrent(HubHUD);

    TouchField__Process(&work->touchField);

    BOOL flag = FALSE;

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) == 0)
        flag = TRUE;

    if (HubControl::Func_2157178())
    {
        if ((work->touchAreaFlags[0] & HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED) != 0)
        {
            work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            flag = TRUE;
        }
    }

    if ((padInput.btnPress & (PAD_BUTTON_X | PAD_BUTTON_B)) != 0)
        flag = TRUE;

    if (flag)
    {
        work->viewButton.flags &= ~HubHUD::BUTTONFLAG_ACTIVE;
        HubHUD::ConfigureMenuButton(TRUE, TRUE);
        SetCurrentTaskMainEvent(HubHUD::Main_Idle);
        HubHUD::EnableViewCursor(work);
        work->touchHeld = FALSE;
        AnimatorSprite__SetAnimation(&work->viewButton.aniButton, 0);
    }
    else if (HubControl::Func_2157178() && (work->touchAreaFlags[0] & HubHUD::TOUCHAREAFLAG_BUTTON_HELD) == 0)
    {
        if (work->touchHeld)
        {
            if (CheckTouchOnEnabled())
            {
                u16 touchX        = touchInput.on.x;
                u16 touchY        = touchInput.on.y;
                work->touchMove.x = touchX - work->touchPos.x;
                work->touchMove.y = touchY - work->touchPos.y;
                work->touchPos.x  = touchX;
                work->touchPos.y  = touchY;
            }
            else
            {
                work->touchHeld = FALSE;
            }
        }
        else
        {
            if (CheckTouchPushEnabled())
            {
                work->touchHeld   = TRUE;
                work->touchPos.x  = touchInput.push.x;
                work->touchPos.y  = touchInput.push.y;
                work->touchMove.x = 0;
                work->touchMove.y = 0;
            }
        }
    }
    else
    {
        work->touchHeld = FALSE;
    }

    HubHUD::ProcessViewButtons(work);
    HubHUD::DrawViewButtons(work);

    work->openMainMenu = FALSE;
    work->unknown2     = 0;
}

void HubHUD::Destructor(Task *task)
{
    HubHUD *work = TaskGetWork(task, HubHUD);

    HubHUD::Release(work);

    HubTaskDestroy<HubHUD>(task);

    taskSingleton = NULL;
}

void HubHUD::EnableViewCursor(HubHUD *work)
{
    AnimatorSprite__SetAnimation(&work->viewButton.aniArrow, 3);
}

void HubHUD::ProcessViewButtons(HubHUD *work)
{
    HubHUDUserData userData;
    userData.hud = work;

    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_VISIBLE) != 0)
    {
        userData.id = 0;
        AnimatorSprite__ProcessAnimation(&work->viewButton.aniButton, HubHUD::SpriteCallback, &userData);

        if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) != 0)
            AnimatorSprite__ProcessAnimationFast(&work->viewButton.aniArrow);
    }
}

void HubHUD::DrawViewButtons(HubHUD *work)
{
    if ((work->viewButton.flags & HubHUD::BUTTONFLAG_VISIBLE) != 0)
    {
        AnimatorSprite__DrawFrame(&work->viewButton.aniButton);

        if ((work->viewButton.flags & HubHUD::BUTTONFLAG_ACTIVE) != 0)
        {
            work->viewButton.aniArrow.pos.x = 8;
            work->viewButton.aniArrow.pos.y = 112;
            AnimatorSprite__DrawFrameRotoZoom(&work->viewButton.aniArrow, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_DEG_TO_IDX(270.0));

            work->viewButton.aniArrow.pos.x = 112;
            work->viewButton.aniArrow.pos.y = 8;
            AnimatorSprite__DrawFrame(&work->viewButton.aniArrow);

            work->viewButton.aniArrow.pos.x = 248;
            work->viewButton.aniArrow.pos.y = 80;
            AnimatorSprite__DrawFrameRotoZoom(&work->viewButton.aniArrow, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_DEG_TO_IDX(90.0));

            work->viewButton.aniArrow.pos.x = 144;
            work->viewButton.aniArrow.pos.y = 184;
            AnimatorSprite__DrawFrameRotoZoom(&work->viewButton.aniArrow, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_DEG_TO_IDX(180.0));
        }
    }
}

void HubHUD::ProcessMenuButton(HubHUD *work)
{
    HubHUDUserData userData;
    userData.hud = work;

    s32 id = renderCurrentDisplay == GX_DISP_SELECT_MAIN_SUB ? GRAPHICS_ENGINE_B : GRAPHICS_ENGINE_A;

    if ((work->menuButton.flags & HubHUD::BUTTONFLAG_VISIBLE) != 0)
    {
        userData.id = 1;
        AnimatorSprite__ProcessAnimation(&work->menuButton.aniSprite[id], HubHUD::SpriteCallback, &userData);
    }
}

void HubHUD::DrawMenuButton(HubHUD *work)
{
    s32 id = renderCurrentDisplay == GX_DISP_SELECT_MAIN_SUB ? GRAPHICS_ENGINE_B : GRAPHICS_ENGINE_A;

    if ((work->menuButton.flags & HubHUD::BUTTONFLAG_VISIBLE) != 0)
        AnimatorSprite__DrawFrame(&work->menuButton.aniSprite[id]);
}

void HubHUD::SetAllTouchAreasDisabled(HubHUD *work)
{
    HubHUD::SetViewButtonTouchAreaEnabled(work, FALSE);
    HubHUD::SetMenuButtonTouchAreaEnabled(work, FALSE);
}

void HubHUD::SetMenuButtonTouchAreaEnabled(HubHUD *work, BOOL enabled)
{
    if (enabled)
    {
        work->touchAreaFlags[1] = HubHUD::TOUCHAREAFLAG_ENABLED;
        HubHUD::ConfigureTouchArea(work, 1, TRUE);
    }
    else
    {
        work->touchAreaFlags[1] = HubHUD::TOUCHAREAFLAG_NONE;
        HubHUD::ConfigureTouchArea(work, 1, FALSE);
        AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[0], 0);
        AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[1], 0);
    }
}

void HubHUD::SetViewButtonTouchAreaEnabled(HubHUD *work, BOOL enabled)
{
    if (enabled)
    {
        work->touchAreaFlags[0] = HubHUD::TOUCHAREAFLAG_ENABLED;
        HubHUD::ConfigureTouchArea(work, 0, TRUE);
    }
    else
    {
        work->touchAreaFlags[0] = HubHUD::TOUCHAREAFLAG_NONE;
        HubHUD::ConfigureTouchArea(work, 0, FALSE);
    }
}

void HubHUD::ConfigureTouchArea(HubHUD *work, s32 id, BOOL enabled)
{
    if (enabled)
    {
        if (work->touchAreaEnabled[id] == FALSE)
        {
            TouchField__AddArea(&work->touchField, &work->touchArea[id], TOUCHAREA_PRIORITY_FIRST);
            work->touchAreaEnabled[id] = TRUE;
        }
    }
    else
    {
        if (work->touchAreaEnabled[id] == TRUE)
        {
            TouchField__RemoveArea(&work->touchField, &work->touchArea[id]);

            work->touchArea[id].responseFlags     = TOUCHAREA_RESPONSE_NONE;
            work->touchArea[id].prevResponseFlags = 0;
            work->touchAreaEnabled[id]            = FALSE;
        }
    }
}

void HubHUD::TouchAreaCallback_ViewButton(TouchAreaResponse *response, TouchArea *area, void *userData)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    TouchAreaResponseFlags responseFlags = area->responseFlags;
    if ((work->touchAreaFlags[0] & HubHUD::TOUCHAREAFLAG_ENABLED) == 0 || (responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) != 0)
    {
        work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
        work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_HELD;
        return;
    }

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_40000:
            work->touchAreaFlags[0] |= HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_HELD;
            AnimatorSprite__SetAnimation(&work->viewButton.aniButton, 0);
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA:
        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            work->touchAreaFlags[0] |= HubHUD::TOUCHAREAFLAG_BUTTON_HELD;
            AnimatorSprite__SetAnimation(&work->viewButton.aniButton, 1);
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA:
            work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            work->touchAreaFlags[0] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_HELD;

            if (HubHUD::LookAroundEnabled())
                AnimatorSprite__SetAnimation(&work->viewButton.aniButton, 2);
            else
                AnimatorSprite__SetAnimation(&work->viewButton.aniButton, 0);
            break;
    }
}

void HubHUD::TouchAreaCallback_MenuButton(TouchAreaResponse *response, TouchArea *area, void *userData)
{
    HubHUD *work = TaskGetWork(taskSingleton, HubHUD);

    TouchAreaResponseFlags responseFlags = area->responseFlags;
    if ((work->touchAreaFlags[1] & HubHUD::TOUCHAREAFLAG_ENABLED) == 0 || (responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) != 0)
    {
        work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
        work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_HELD;
        return;
    }

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_40000:
            work->touchAreaFlags[1] |= HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_HELD;
            AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[GRAPHICS_ENGINE_A], 0);
            AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[GRAPHICS_ENGINE_B], 0);
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA:
        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            work->touchAreaFlags[1] |= HubHUD::TOUCHAREAFLAG_BUTTON_HELD;
            AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[GRAPHICS_ENGINE_A], 1);
            AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[GRAPHICS_ENGINE_B], 1);
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA:
            work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_RELEASED;
            work->touchAreaFlags[1] &= ~HubHUD::TOUCHAREAFLAG_BUTTON_HELD;

            AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[GRAPHICS_ENGINE_A], 0);
            AnimatorSprite__SetAnimation(&work->menuButton.aniSprite[GRAPHICS_ENGINE_B], 0);
            break;
    }
}

void HubHUD::SpriteCallback(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData)
{
    HubHUDUserData *work                   = (HubHUDUserData *)userData;
    BACFrameGroupBlock_Hitbox *blockHitbox = (BACFrameGroupBlock_Hitbox *)block;

    if (blockHitbox->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        TouchRectUnknown touchRect;
        MI_CpuCopy16(&blockHitbox->hitbox, &touchRect.box, sizeof(touchRect.box));
        TouchField__SetHitbox(&work->hud->touchArea[work->id], &touchRect);
    }
}
