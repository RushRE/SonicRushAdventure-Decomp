#include <seaMap/seaMapView.h>
#include <game/game/gameState.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <seaMap/seaMapEventManager.h>
#include <seaMap/seaMapCollision.h>

// --------------------
// STRUCTS
// --------------------

struct SeaMapView_CursorAnimInfo
{
    u8 anim;
    u8 paletteRow;
};

struct SeaMap__AnimInfo
{
    u8 animIDs[6];
    u8 field_8;
    u8 field_9;
    u8 oamOrder;
    u8 field_B;
    u32 spriteSlot;
    s16 x;
    s16 y;
    u8 paletteRows[3];
};

struct SeaMap__AnimInfo2
{
    u8 animID;
    u8 oamOrder;
    u32 spriteSlot;
    s16 x;
    s16 y;
    u8 paletteRows[3];
};

struct SeaMap__TouchCallbackInfo
{
    u16 priority;
    TouchAreaCallback callback;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *dword_210F76C;
NOT_DECOMPILED struct SeaMapView_CursorAnimInfo byte_210F774[];
NOT_DECOMPILED GXRgb byte_210F77A[];
NOT_DECOMPILED u16 word_210F782[];
NOT_DECOMPILED fx32 SeaMapView__VoyageDistance[SHIP_COUNT];
NOT_DECOMPILED struct SeaMap__TouchCallbackInfo stru_210F7A4[];
NOT_DECOMPILED struct SeaMap__AnimInfo stru_210F7E4[];
NOT_DECOMPILED struct SeaMap__AnimInfo2 stru_210F82C[];

// --------------------
// FUNCTIONS
// --------------------

u32 SeaMapView__GetMode(void)
{
    return SeaMapView__sVars.mode;
}

s32 SeaMapView__Func_203DCB4(void)
{
    return SeaMapView__sVars.unknown1;
}

BOOL SeaMapView__IsActive(void)
{
    return SeaMapView__sVars.singleton != NULL;
}

void SeaMapView__SetViewPosition(s32 x, s32 y)
{
    SeaMapView *work = SeaMapView__GetWork();

    work->position.x = x - (HW_LCD_CENTER_X * SeaMapManager__GetZoomInScale());
    work->position.y = y - (HW_LCD_CENTER_Y * SeaMapManager__GetZoomInScale());

    work->moveDist2.x = work->moveDist2.y = 0;
}

TouchArea *SeaMapView__GetTouchArea(void)
{
    SeaMapView *work = TaskGetWork(SeaMapView__sVars.singleton, SeaMapView);

    return &work->touchArea;
}

BOOL SeaMapView__Func_203DD44(void)
{
    SeaMapView *work = SeaMapView__GetWork();

    return work->currentVoyageDist <= FLOAT_TO_FX32(1.0);
}

void SeaMapView__InitZoomControl(SeaMapViewZoomControl *work, BOOL useEngineB)
{
    MI_CpuClear16(work, sizeof(*work));

    work->useEngineB = useEngineB;
}

BOOL SeaMapView__CanZoomIn(SeaMapViewZoomControl *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    switch (work->mode)
    {
        default:
        case 0:
            MI_CpuClear16(&gfxControl->windowManager, sizeof(gfxControl->windowManager));
            gfxControl->windowManager.visible                     = TRUE;
            gfxControl->windowManager.registers.win0X1            = 0;
            gfxControl->windowManager.registers.win0Y1            = 0;
            gfxControl->windowManager.registers.win0X2            = 0;
            gfxControl->windowManager.registers.win0Y2            = -64;
            gfxControl->windowManager.registers.win0InPlane.value = GX_PLANEMASK_ALL | 0xFF;
            gfxControl->windowManager.registers.winOutPlane.value = GX_PLANEMASK_NONE;
            RenderCore_DisableWindowPlaneUpdate(TRUE);
            work->mode = 1;
            // FallThrough

        case 1:
            gfxControl->windowManager.registers.win0X1 += 12;
            gfxControl->windowManager.registers.win0Y1 += 9;
            gfxControl->windowManager.registers.win0X2 -= 12;
            gfxControl->windowManager.registers.win0Y2 -= 9;

            if (gfxControl->windowManager.registers.win0X1 < gfxControl->windowManager.registers.win0X2
                && gfxControl->windowManager.registers.win0Y1 < gfxControl->windowManager.registers.win0Y2)
                return FALSE;

            gfxControl->windowManager.registers.win0X1 = gfxControl->windowManager.registers.win0X2;
            gfxControl->windowManager.registers.win0Y1 = gfxControl->windowManager.registers.win0Y2;
            RenderCore_DisableWindowPlaneUpdate(FALSE);
            if (work->useEngineB == GRAPHICS_ENGINE_A)
                GX_SetVisiblePlane(GX_PLANEMASK_NONE);
            else
                GXS_SetVisiblePlane(GX_PLANEMASK_NONE);
            work->mode = 2;
            // FallThrough

        case 2:
            return TRUE;
    }
}

BOOL SeaMapView__HandleZoomIn(SeaMapViewZoomControl *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    switch (work->mode)
    {
        default:
        case 0:
            MI_CpuClear16(&gfxControl->windowManager, sizeof(gfxControl->windowManager));
            gfxControl->windowManager.visible                     = TRUE;
            gfxControl->windowManager.registers.win0X1            = 0;
            gfxControl->windowManager.registers.win0Y1            = 0;
            gfxControl->windowManager.registers.win0X2            = 0;
            gfxControl->windowManager.registers.win0Y2            = -64;
            gfxControl->windowManager.registers.win0InPlane.value = GX_PLANEMASK_NONE;
            gfxControl->windowManager.registers.winOutPlane.value = GX_PLANEMASK_ALL | 0xFF;
            RenderCore_DisableWindowPlaneUpdate(TRUE);
            if (work->useEngineB == GRAPHICS_ENGINE_A)
                GX_SetVisiblePlane(GX_PLANEMASK_ALL);
            else
                GXS_SetVisiblePlane(GX_PLANEMASK_ALL);
            work->mode = 1;
            // FallThrough

        case 1:
            gfxControl->windowManager.registers.win0X1 += 12;
            gfxControl->windowManager.registers.win0Y1 += 9;
            gfxControl->windowManager.registers.win0X2 -= 12;
            gfxControl->windowManager.registers.win0Y2 -= 9;

            if (gfxControl->windowManager.registers.win0X1 < gfxControl->windowManager.registers.win0X2
                && gfxControl->windowManager.registers.win0Y1 < gfxControl->windowManager.registers.win0Y2)
                return FALSE;

            gfxControl->windowManager.visible = FALSE;
            RenderCore_DisableWindowPlaneUpdate(FALSE);
            work->mode = 2;
            // FallThrough

        case 2:
            return TRUE;
    }
}

BOOL SeaMapView__CanZoomOut(SeaMapViewZoomControl *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    switch (work->mode)
    {
        default:
        case 0:
            MI_CpuClear16(&gfxControl->windowManager, sizeof(gfxControl->windowManager));
            gfxControl->windowManager.registers.win0X1            = HW_LCD_CENTER_X;
            gfxControl->windowManager.registers.win0Y1            = HW_LCD_CENTER_Y;
            gfxControl->windowManager.registers.win0X2            = HW_LCD_CENTER_X;
            gfxControl->windowManager.registers.win0Y2            = HW_LCD_CENTER_Y;
            gfxControl->windowManager.registers.win0InPlane.value = GX_PLANEMASK_NONE;
            gfxControl->windowManager.registers.winOutPlane.value = GX_PLANEMASK_ALL | 0xFF;
            gfxControl->windowManager.registers.win0X1 -= 12;
            gfxControl->windowManager.registers.win0Y1 -= 9;
            gfxControl->windowManager.registers.win0X2 += 12;
            gfxControl->windowManager.registers.win0Y2 += 9;
            work->mode = 1;
            return FALSE;

        case 1:
            gfxControl->windowManager.visible = TRUE;
            gfxControl->windowManager.registers.win0X1 -= 12;
            gfxControl->windowManager.registers.win0Y1 -= 9;
            gfxControl->windowManager.registers.win0X2 += 12;
            gfxControl->windowManager.registers.win0Y2 += 9;
            if (gfxControl->windowManager.registers.win0Y1 <= 6)
                RenderCore_DisableWindowPlaneUpdate(TRUE);

            if (gfxControl->windowManager.registers.win0X1 < gfxControl->windowManager.registers.win0X2
                && gfxControl->windowManager.registers.win0Y1 < gfxControl->windowManager.registers.win0Y2)
                return FALSE;

            gfxControl->windowManager.registers.win0X1 = 0;
            gfxControl->windowManager.registers.win0X2 = -1;
            gfxControl->windowManager.registers.win0Y1 = 0;
            gfxControl->windowManager.registers.win0Y2 = -64;
            RenderCore_DisableWindowPlaneUpdate(FALSE);
            if (work->useEngineB == GRAPHICS_ENGINE_A)
                GX_SetVisiblePlane(GX_PLANEMASK_NONE);
            else
                GXS_SetVisiblePlane(GX_PLANEMASK_NONE);
            work->mode = 2;
            // FallThrough

        case 2:
            return TRUE;
    }
}

BOOL SeaMapView__HandleZoomOut(SeaMapViewZoomControl *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    switch (work->mode)
    {
        default:
        case 0:
            MI_CpuClear16(&gfxControl->windowManager, sizeof(gfxControl->windowManager));
            gfxControl->windowManager.visible                     = TRUE;
            gfxControl->windowManager.registers.win0X1            = HW_LCD_CENTER_X;
            gfxControl->windowManager.registers.win0Y1            = HW_LCD_CENTER_Y;
            gfxControl->windowManager.registers.win0X2            = HW_LCD_CENTER_X;
            gfxControl->windowManager.registers.win0Y2            = HW_LCD_CENTER_Y;
            gfxControl->windowManager.registers.win0InPlane.value = GX_PLANEMASK_ALL | 0xFF;
            gfxControl->windowManager.registers.winOutPlane.value = GX_PLANEMASK_NONE;
            RenderCore_DisableWindowPlaneUpdate(TRUE);
            if (work->useEngineB == GRAPHICS_ENGINE_A)
                GX_SetVisiblePlane(GX_PLANEMASK_ALL);
            else
                GXS_SetVisiblePlane(GX_PLANEMASK_ALL);
            work->mode = 1;
            // FallThrough

        case 1:
            gfxControl->windowManager.registers.win0X1 -= 12;
            gfxControl->windowManager.registers.win0Y1 -= 9;
            gfxControl->windowManager.registers.win0X2 += 12;
            gfxControl->windowManager.registers.win0Y2 += 9;

            if (gfxControl->windowManager.registers.win0X1 < gfxControl->windowManager.registers.win0X2
                && gfxControl->windowManager.registers.win0Y1 < gfxControl->windowManager.registers.win0Y2)
                return FALSE;

            gfxControl->windowManager.visible = FALSE;
            RenderCore_DisableWindowPlaneUpdate(FALSE);
            work->mode = 2;
            // FallThrough

        case 2:
            return TRUE;
    }
}

SeaMapView *SeaMapView__GetWork(void)
{
    SeaMapView *work = TaskGetWork(SeaMapView__sVars.singleton, SeaMapView);

    return work;
}

void SeaMapView__InitView(SeaMapView *work, BOOL useEngineB, ShipType shipType, BOOL allocateSprites)
{
    SeaMapManager *manager;
    u32 i;
    s32 language = GetGameLanguage();

    HitboxRect rect;
    struct SeaMap__AnimInfo *info;
    struct SeaMap__AnimInfo2 *info2;
    struct SeaMap__TouchCallbackInfo *touchInfo;
    SpriteButtonAnimator *aniButton;

    manager = SeaMapManager__GetWork();

    MI_CpuClear16(work, sizeof(*work));

    work->useEngineB       = useEngineB;
    work->assets           = &SeaMapManager__GetWork()->assets;
    work->selectedButton   = -1;
    work->targetBrightness = VRAMSystem__GFXControl[useEngineB]->brightness;

    if ((s32)shipType < SHIP_COUNT)
    {
        work->currentVoyageDist = work->totalVoyageDist = FX32_FROM_WHOLE(SeaMapView__VoyageDistance[shipType]);
    }
    SeaMapView__Func_203FE44(work);

    AnimatorSprite *aniPenMarker = &work->aniPenMarker;
    AnimatorSprite__Init(aniPenMarker, work->assets->sprChCommon, 38, ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK,
                         work->useEngineB, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(work->useEngineB, Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, 38)),
                         PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_6);
    aniPenMarker->cParam.alpha = PALETTE_ROW_4;

    work->allocateSprites = allocateSprites;
    if (allocateSprites)
    {
        SeaMapView__AllocateSprites(work);

        aniButton = work->buttonAnimators;
        for (i = 0; i < 8; i++)
        {
            if (i < 5)
            {
                info2 = &stru_210F82C[i];

                aniButton->animID = info2->animID;
                for (u32 r = 0; r < 3; r++)
                {
                    aniButton->paletteRow[r] = info2->paletteRows[r];
                }

                AnimatorSprite__Init(&aniButton->animator, work->assets->sprChCommon, aniButton->animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, useEngineB, PIXEL_MODE_SPRITE,
                                     work->vramPixels[info2->spriteSlot], PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[useEngineB]), SPRITE_PRIORITY_0,
                                     info2->oamOrder);
                aniButton->animator.cParam.palette = aniButton->paletteRow[0];
                aniButton->animator.pos.x          = info2->x;
                aniButton->animator.pos.y          = info2->y;
            }
            else
            {
                info = &stru_210F7E4[i - 5];

                aniButton->animID = info->animIDs[language];
                for (u32 r = 0; r < 3; r++)
                {
                    aniButton->paletteRow[r] = info->paletteRows[r];
                }

                AnimatorSprite__Init(&aniButton->animator, work->assets->sprChCommon, info->animIDs[GetGameLanguage()], ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, useEngineB,
                                     PIXEL_MODE_SPRITE, work->vramPixels[info->spriteSlot], PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[useEngineB]),
                                     SPRITE_PRIORITY_0, info->oamOrder);
                aniButton->animator.cParam.palette = aniButton->paletteRow[0];
                aniButton->animator.pos.x          = info->x;
                aniButton->animator.pos.y          = info->y;
            }

            touchInfo = &stru_210F7A4[i];

            AnimatorSprite__GetBlockData(&aniButton->animator, 0, &rect);
            TouchField__InitAreaShape(&aniButton->touchArea, &aniButton->animator.pos, TouchField__PointInRect, (TouchRectUnknown *)&rect, touchInfo->callback, work);
            TouchField__AddArea(&manager->touchField, &aniButton->touchArea, touchInfo->priority);
            SetSpriteButtonState(aniButton, SPRITE_BUTTON_STATE_IDLE);

            aniButton++;
        }

        Vec2Fx16 pos = { 0 };
        rect.left    = 0;
        rect.top     = 0;
        rect.right   = HW_LCD_WIDTH;
        rect.bottom  = HW_LCD_HEIGHT;
        TouchField__InitAreaShape(&work->touchArea, &pos, TouchField__PointInRect, (TouchRectUnknown *)&rect, SeaMapView__TouchAreaCallback, work);
        TouchField__AddArea(&manager->touchField, &work->touchArea, 8);

        AnimatorSprite *aniTouchCursor = &work->aniTouchCursor;
        AnimatorSprite__Init(aniTouchCursor, GetSpriteButtonCursorSprite(), byte_210F774[0].anim, ANIMATOR_FLAG_NONE, useEngineB, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(useEngineB, SeaMapView__GetCursorSpriteSize()), PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        aniTouchCursor->cParam.palette = byte_210F774[0].paletteRow;
        SeaMapView__InitTouchCursor(work, -1);

        struct SeaMapView_CursorAnimInfo *cursorInfoList = &byte_210F774[1];
        struct SeaMapView_CursorAnimInfo *cursorInfo;
        for (i = 0; i < 2; i++)
        {
            cursorInfo = &cursorInfoList[i];

            AnimatorSprite *aniPadCursor = &work->aniPadCursor[i];
            AnimatorSprite__Init(aniPadCursor, GetSpriteButtonCursorSprite(), cursorInfo->anim, ANIMATOR_FLAG_NONE, useEngineB, PIXEL_MODE_SPRITE,
                                 VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, cursorInfo->anim)), PALETTE_MODE_SPRITE,
                                 VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_0);
            aniPadCursor->cParam.palette = cursorInfo->paletteRow;
            AnimatorSprite__ProcessAnimationFast(aniPadCursor);
        }

        AnimatorSprite *aniTextBorder = &work->aniTextBorder;
        AnimatorSprite__Init(aniTextBorder, work->assets->sprChCommon, 46, ANIMATOR_FLAG_NONE, useEngineB, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, 46)), PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_5);
        aniTextBorder->cParam.palette = PALETTE_ROW_4;
        AnimatorSprite__ProcessAnimationFast(aniTextBorder);

        work->sndHandle = AllocSndHandle();
    }
}

void SeaMapView__ReleaseAssets(SeaMapView *work)
{
    u32 i;
    SeaMapManager *manager = SeaMapManager__GetWork();

    AnimatorSprite__Release(&work->aniPenMarker);
    if (work->allocateSprites)
    {
        AnimatorSprite__Release(&work->aniTextBorder);
        AnimatorSprite__Release(&work->aniTouchCursor);

        for (i = 0; i < 2; i++)
            AnimatorSprite__Release(&work->aniPadCursor[i]);

        SeaMapView__ReleaseSprites(work);
        TouchField__RemoveArea(&manager->touchField, &work->touchArea);

        for (i = 0; i < 8; i++)
            TouchField__RemoveArea(&manager->touchField, &work->buttonAnimators[i].touchArea);

        FreeSndHandle(work->sndHandle);
    }
}

void SeaMapView__Func_203E898(SeaMapView *work)
{
    work->field_7A4 = -30;
}

void SeaMapView__Func_203E8A8(SeaMapView *work)
{
    if ((IsTouchInputEnabled() && TouchInput__IsTouchOn(&touchInput)) || (padInput.btnDown & (PAD_KEY_DOWN | PAD_KEY_UP | PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0)
    {
        SeaMapView__Func_203E898(work);
    }
    else
    {
        work->field_7A4++;
        if (work->field_7A4 > 255)
            work->field_7A4 = 0;
    }
}

NONMATCH_FUNC void SeaMapView__Func_203E914(SeaMapView *work)
{
	// https://decomp.me/scratch/2Qb7n -> 58.36%
#ifdef NON_MATCHING
    fx32 distancePercent = FX_Div(work->currentVoyageDist, work->totalVoyageDist);
    fx32 oneThirdFX32    = FX_DivS32(FLOAT_TO_FX32(1.0), 3);
    u32 quadrant        = FX32_TO_WHOLE(FX_Div(distancePercent, oneThirdFX32));

    GXRgb color;
    if (quadrant < 3)
    {
        fx32 v7 = FX_Div(distancePercent - quadrant * oneThirdFX32, oneThirdFX32);
        fx32 y  = byte_210F77A[quadrant + 1];
        fx32 x  = byte_210F77A[quadrant];

        color = (32 * ((MultiplyFX(((FX32_FROM_WHOLE((y >> GX_RGB_G_SHIFT) & 0x1F) & 0xFFFFFFF) - FX32_FROM_WHOLE((x >> GX_RGB_G_SHIFT) & 0x1F)), v7) + FX32_FROM_WHOLE((x >> GX_RGB_G_SHIFT) & 0x1F)) >> 12)) & 0x1FFFFF
             | ((16 * (MultiplyFX(((FX32_FROM_WHOLE((y >> GX_RGB_R_SHIFT) & 0x1F) & 0xFFFFFFF) - FX32_FROM_WHOLE((x >> GX_RGB_R_SHIFT) & 0x1F)), v7) + FX32_FROM_WHOLE((x >> GX_RGB_R_SHIFT) & 0x1F))) >> 16)
             | (MultiplyFX(((FX32_FROM_WHOLE((y >> GX_RGB_B_SHIFT) & 0x1F) & 0xFFFFFFF) - FX32_FROM_WHOLE((x >> GX_RGB_B_SHIFT) & 0x1F)), v7) + FX32_FROM_WHOLE((x >> GX_RGB_B_SHIFT) & 0x1F) >> 12 << 10) & 0x3FFFFFF;
    }
    else
    {
        color = 992;
    }

    work->paletteColor1 = color;
    work->paletteColor2 = GX_RGB(((work->paletteColor1 >> GX_RGB_R_SHIFT) & 0x1F) >> 1, ((work->paletteColor1 >> GX_RGB_G_SHIFT) & 0x1F) >> 1,
                                 ((work->paletteColor1 >> GX_RGB_B_SHIFT) & 0x1F) >> 1);

    QueueUncompressedPalette(&work->paletteColor1, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16*)(void*)VRAMSystem__VRAM_PALETTE_BG[work->useEngineB])[255]));
    LoadUncompressedPalette(&work->paletteColor1, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16*)(void*)VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB])[78]));
    LoadUncompressedPalette(&work->paletteColor2, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16*)(void*)VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB])[79]));
    work->aniPenMarker.animAdvance = MultiplyFX(distancePercent, FLOAT_TO_FX32(0.7)) + FLOAT_TO_FX32(0.3);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	ldr r0, [r5, #0x79c]
	ldr r1, [r5, #0x798]
	bl FX_Div
	mov r4, r0
	mov r0, #0x1000
	mov r1, #3
	bl FX_DivS32
	mov r6, r0
	mov r0, r4
	mov r1, r6
	bl FX_Div
	mov r7, r0, asr #0xc
	cmp r7, #3
	addhs r0, r5, #0x700
	movhs r1, #0x3e0
	bhs _0203EA40
	mul r0, r7, r6
	mov r1, r6
	sub r0, r4, r0
	bl FX_Div
	ldr r1, =byte_210F77A+2
	mov r2, r7, lsl #1
	ldrh r6, [r1, r2]
	ldr r1, =byte_210F77A
	mov r0, r0, lsl #0x10
	ldrh r9, [r1, r2]
	mov r2, r6, asr #0xa
	and r7, r2, #0x1f
	mov r3, r9, asr #0xa
	and r2, r6, #0x1f
	mov r1, r6, asr #5
	and r6, r1, #0x1f
	mov r1, r7, lsl #0x10
	mov r8, r9, asr #5
	mov r2, r2, lsl #0x10
	and r3, r3, #0x1f
	mov r6, r6, lsl #0x10
	mov r7, r2, lsr #4
	mov r2, r6, lsr #4
	mov r1, r1, lsr #4
	mov r6, r0, asr #0x10
	and lr, r9, #0x1f
	sub r0, r1, r3, lsl #12
	and ip, r8, #0x1f
	sub r1, r7, lr, lsl #12
	sub r7, r2, ip, lsl #12
	smull r2, r9, r0, r6
	adds r2, r2, #0x800
	smull r8, r0, r1, r6
	adc r9, r9, #0
	adds r1, r8, #0x800
	mov r2, r2, lsr #0xc
	orr r2, r2, r9, lsl #20
	add r2, r2, r3, lsl #12
	smull r6, r3, r7, r6
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r6, r6, #0x800
	add r7, r1, lr, lsl #12
	adc r0, r3, #0
	mov r1, r6, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, ip, lsl #12
	mov r0, r0, asr #0xc
	mov r0, r0, lsl #0x10
	mov r2, r2, asr #0xc
	mov r3, r0, lsr #0xb
	mov r1, r7, lsl #4
	mov r0, r2, lsl #0x10
	orr r1, r3, r1, lsr #16
	orr r1, r1, r0, lsr #6
	add r0, r5, #0x700
_0203EA40:
	strh r1, [r0, #0xa0]
	add r1, r5, #0x700
	ldrh lr, [r1, #0xa0]
	ldr r2, =VRAMSystem__VRAM_PALETTE_BG
	add r0, r5, #0x7a0
	mov r3, lr, asr #5
	and r3, r3, #0x1f
	mov r6, lr, asr #0xa
	and ip, r6, #0x1f
	mov r3, r3, asr #1
	and r6, lr, #0x1f
	mov r3, r3, lsl #5
	mov ip, ip, asr #1
	orr r3, r3, r6, asr #1
	orr r3, r3, ip, lsl #10
	strh r3, [r1, #0xa2]
	ldr r3, [r5, #4]
	mov r1, #1
	ldr r3, [r2, r3, lsl #2]
	mov r2, #0
	add r3, r3, #0xfe
	add r3, r3, #0x100
	bl QueueUncompressedPalette
	ldr r2, [r5, #4]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r5, #0x7a0
	ldr r2, [r1, r2, lsl #2]
	mov r1, #1
	add r3, r2, #0x9c
	mov r2, #0
	bl LoadUncompressedPalette
	add r0, r5, #0xa2
	ldr r2, [r5, #4]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r0, #0x700
	ldr r2, [r1, r2, lsl #2]
	mov r1, #1
	add r3, r2, #0x9e
	mov r2, #0
	bl LoadUncompressedPalette
	ldr r0, =0x00000B34
	mov r1, #0
	umull r3, r2, r4, r0
	mla r2, r4, r1, r2
	mov r1, r4, asr #0x1f
	mla r2, r1, r0, r2
	adds r1, r3, #0x800
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xcc
	add r0, r0, #0x400
	str r0, [r5, #0x59c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

u16 SeaMapView__GetCursorSpriteSize(void)
{
    return Sprite__GetSpriteSize1FromAnim(GetSpriteButtonCursorSprite(), byte_210F774[0].anim);
}

void SeaMapView__InitTouchCursor(SeaMapView *work, s32 mode)
{
    AnimatorSprite *aniCursor = &work->aniTouchCursor;
    if (mode == -1)
    {
        aniCursor->flags |= ANIMATOR_FLAG_DISABLE_DRAW;
    }
    else
    {
        struct SeaMapView_CursorAnimInfo *info = &byte_210F774[mode];
        AnimatorSprite__SetAnimation(&work->aniTouchCursor, info->anim);
        aniCursor->flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        aniCursor->cParam.alpha = info->paletteRow;
        AnimatorSprite__ProcessAnimationFast(aniCursor);
    }
}

void SeaMapView__AllocateSprites(SeaMapView *work)
{
    MI_CpuClear32(work->vramPixels, sizeof(work->vramPixels));

    u32 i;

    struct SeaMap__AnimInfo2 *info2_ptr;
    struct SeaMap__AnimInfo *info_ptr;
    struct SeaMap__AnimInfo *info;
    struct SeaMap__AnimInfo2 *info2;

    for (i = 0; i < 8; i++)
    {
        u32 allocSize;
        u32 allocSlot;

        if (i < 5)
        {
            info2_ptr = &stru_210F82C[i];
            info2     = info2_ptr;
            allocSize = SeaMapView__Func_203ECA0(work, i);
            allocSlot = info2->spriteSlot;
        }
        else
        {
            info_ptr  = &stru_210F7E4[i - 5];
            info      = info_ptr;
            allocSize = SeaMapView__Func_203ECF4(work, i);
            allocSlot = info->spriteSlot;
        }

        if (VOID_TO_INT(work->vramPixels[allocSlot]) < allocSize)
            work->vramPixels[allocSlot] = INT_TO_VOID(allocSize);
    }

    for (i = 0; i < 5; i++)
    {
        size_t allocSize = VOID_TO_INT(work->vramPixels[i]);

        if (allocSize)
            work->vramPixels[i] = VRAMSystem__AllocSpriteVram(work->useEngineB, allocSize);
    }
}

void SeaMapView__ReleaseSprites(SeaMapView *work)
{
    for (u32 i = 0; i < 5; i++)
    {
        if (work->vramPixels[i])
        {
            VRAMSystem__FreeSpriteVram(work->useEngineB, work->vramPixels[i]);
            work->vramPixels[i] = NULL;
        }
    }
}

u32 SeaMapView__Func_203ECA0(SeaMapView *work, s32 id)
{
    struct SeaMap__AnimInfo2 *info2 = &stru_210F82C[id];

    u32 size      = Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, info2->animID);
    u32 allocSize = size;

    size = Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, 1 + info2->animID);
    if (allocSize < size)
        allocSize = size;

    return allocSize;
}

u32 SeaMapView__Func_203ECF4(SeaMapView *work, s32 id)
{
    struct SeaMap__AnimInfo *info = &stru_210F7E4[id - 5];

    u32 allocSize = 0;
    for (u32 i = 0; i < 8; i++)
    {
        u16 size = Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, 1 + info->animIDs[i]);
        if (allocSize < size)
            allocSize = size;

        size = Sprite__GetSpriteSize1FromAnim(work->assets->sprChCommon, info->animIDs[i]);
        if (allocSize < size)
            allocSize = size;
    }

    return allocSize;
}

BOOL SeaMapView__IsButtonActive(SeaMapView *work, s32 id)
{
    return (work->buttonAnimators[id].animator.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0;
}

BOOL SeaMapView__IsTouchAreaActive(SeaMapView *work, s32 id)
{
    return (work->buttonAnimators[id].touchArea.responseFlags & TOUCHAREA_RESPONSE_DISABLED) == 0;
}

void SeaMapView__EnableTouchArea(SeaMapView *work, s32 id, BOOL enabled)
{
    SpriteButtonAnimator *button = &work->buttonAnimators[id];

    if (enabled)
    {
        SetSpriteButtonState(button, SPRITE_BUTTON_STATE_IDLE);
        button->touchArea.responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;
    }
    else
    {
        SetSpriteButtonState(button, SPRITE_BUTTON_STATE_SELECTED);
        button->touchArea.responseFlags |= TOUCHAREA_RESPONSE_DISABLED;
    }
}

void SeaMapView__EnableButton(SeaMapView *work, s32 id, BOOL enabled)
{
    SpriteButtonAnimator *aniButton = &work->buttonAnimators[id];

    s16 x, y;
    if (enabled)
    {
        if (id < 5)
        {
            struct SeaMap__AnimInfo2 *info = &stru_210F82C[id];

            x = info->x;
            y = info->y;
        }
        else
        {
            struct SeaMap__AnimInfo *info = &stru_210F7E4[id - 5];

            x = info->x;
            y = info->y;
        }

        aniButton->animator.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        AnimatorSprite__ProcessFrame(&aniButton->animator);
    }
    else
    {
        x = 999;
        y = 999;
        aniButton->animator.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
    }
    SetSpriteButtonPosition(aniButton, x, y);
}

void SeaMapView__EnableMultipleButtons(SeaMapView *work, const u32 *states)
{
    for (u32 i = 0; i < 8; i++)
        SeaMapView__EnableButton(work, i, states[i]);
}

void SeaMapView__SetButtonMode(SeaMapView *work, s32 mode)
{
    SeaMapView__EnableButton(work, 1, TRUE);
    SeaMapView__EnableButton(work, 2, TRUE);

    switch (mode)
    {
        case 0:
            SetSpriteButtonState(&work->buttonAnimators[1], SPRITE_BUTTON_STATE_SELECTED);
            work->buttonAnimators[1].touchArea.responseFlags |= TOUCHAREA_RESPONSE_DISABLED;

            SetSpriteButtonState(&work->buttonAnimators[2], SPRITE_BUTTON_STATE_IDLE);
            work->buttonAnimators[2].touchArea.responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;
            break;

        case 1:
            SetSpriteButtonState(&work->buttonAnimators[1], SPRITE_BUTTON_STATE_IDLE);
            work->buttonAnimators[1].touchArea.responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;

            SetSpriteButtonState(&work->buttonAnimators[2], SPRITE_BUTTON_STATE_IDLE);
            work->buttonAnimators[2].touchArea.responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;
            break;

        case 2:
            SetSpriteButtonState(&work->buttonAnimators[1], SPRITE_BUTTON_STATE_IDLE);
            work->buttonAnimators[1].touchArea.responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;

            SetSpriteButtonState(&work->buttonAnimators[2], SPRITE_BUTTON_STATE_SELECTED);
            work->buttonAnimators[2].touchArea.responseFlags |= TOUCHAREA_RESPONSE_DISABLED;
            break;
    }
}

void SeaMapView__ProcessButtons(SeaMapView *work)
{
    if ((IsTouchInputEnabled() == FALSE || TouchInput__IsTouchOn(&touchInput) == FALSE) && SeaMapManager__GetWork()->touchFieldActive)
    {
        for (u32 i = 0; i < 8; i++)
        {
            if (SeaMapView__IsButtonActive(work, i) && SeaMapView__IsTouchAreaActive(work, i) && (padInput.btnPress & word_210F782[i]) != 0)
            {
                work->selectedButton = i;
                break;
            }
        }
    }
}

void SeaMapView__SetZoomLevel(SeaMapView *work, s32 mode)
{
    SeaMapView__SetButtonMode(work, mode);

    s32 x1 = work->position.x;
    s32 y1 = work->position.y;

    s32 zoomX = work->position.x + HW_LCD_CENTER_X * SeaMapManager__GetZoomInScale();
    s32 zoomY = work->position.y + HW_LCD_CENTER_Y * SeaMapManager__GetZoomInScale();
    SeaMapManager__SetZoomLevel(mode);
    s32 x2 = zoomX - HW_LCD_CENTER_X * SeaMapManager__GetZoomInScale();
    s32 y2 = zoomY - HW_LCD_CENTER_Y * SeaMapManager__GetZoomInScale();

    work->moveDist2.x += MultiplyFX(x2 - x1, SeaMapManager__GetZoomOutScale());
    work->moveDist2.y += MultiplyFX(y2 - y1, SeaMapManager__GetZoomOutScale());

    SeaMapManager__EnableDrawFlags(15);
}

void SeaMapView__ProcessPadInputs(SeaMapView *work)
{
    if (SeaMapManager__GetWork()->touchFieldActive && (IsTouchInputEnabled() == FALSE || TouchInput__IsTouchOn(&touchInput) == FALSE) && SeaMapManager__GetWork()->touchFieldActive
        && (padInput.btnDown & (PAD_KEY_DOWN | PAD_KEY_UP | PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0)
    {
        fx32 zoomScale       = SeaMapManager__GetZoomInScale();
        fx32 velocity        = MultiplyFX(FLOAT_TO_FX32(6.0), zoomScale);
        work->lastMoveDist.x = work->lastMoveDist.y = 0;

        if ((padInput.btnDown & PAD_KEY_LEFT) != 0)
            work->position.x -= velocity;

        if ((padInput.btnDown & PAD_KEY_RIGHT) != 0)
            work->position.x += velocity;

        if ((padInput.btnDown & PAD_KEY_UP) != 0)
            work->position.y -= velocity;

        if ((padInput.btnDown & PAD_KEY_DOWN) != 0)
            work->position.y += velocity;
    }

    fx32 zoomScale = SeaMapManager__GetZoomInScale();
    work->position.x += MultiplyFX(zoomScale, work->moveDist2.x);
    work->position.y += MultiplyFX(zoomScale, work->moveDist2.y);
    work->moveDist2.x = work->moveDist2.y = 0;
    work->position.x += MultiplyFX(zoomScale, work->lastMoveDist.x);
    work->position.y += MultiplyFX(zoomScale, work->lastMoveDist.y);

    work->lastMoveDist.x = MultiplyFX(work->lastMoveDist.x, FLOAT_TO_FX32(0.8));
    work->lastMoveDist.y = MultiplyFX(work->lastMoveDist.y, FLOAT_TO_FX32(0.8));

    work->lastMoveDist.x = MTM_MATH_CLIP(work->lastMoveDist.x, -FLOAT_TO_FX32(32.0), FLOAT_TO_FX32(32.0));
    work->lastMoveDist.y = MTM_MATH_CLIP(work->lastMoveDist.y, -FLOAT_TO_FX32(32.0), FLOAT_TO_FX32(32.0));

    if (MATH_ABS(work->lastMoveDist.x) < FLOAT_TO_FX32(0.05))
        work->lastMoveDist.x = 0;

    if (MATH_ABS(work->lastMoveDist.y) < FLOAT_TO_FX32(0.05))
        work->lastMoveDist.y = 0;
}

void SeaMapView__Func_203F344(SeaMapView *work)
{
    work->lastMoveDist.x = work->lastMoveDist.y = 0;
    work->moveDist1.x = work->moveDist1.y = 0;
}

void SeaMapView__Func_203F35C(SeaMapView *work, BOOL highPriority)
{
    u32 priority;
    if (highPriority)
        priority = 3;
    else
        priority = 8;

    SeaMapManager *manager = SeaMapManager__GetWork();
    TouchField__UpdateAreaPriority(&manager->touchField, &work->touchArea, priority);
}

void SeaMapView__SetTouchAreaCallback(SeaMapView *work, TouchAreaCallback callback)
{
    work->touchArea.callback = callback;
}

void SeaMapView__TouchAreaCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    // Do nothing.
}

void SeaMapView__TouchAreaCallback(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView *work = (SeaMapView *)userData;

    TouchAreaResponseFlags areaFlags = touchArea->responseFlags;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            work->lastMoveDist.x = work->lastMoveDist.y = 0;
            work->moveDist1.x = work->moveDist1.y = 0;
            SeaMapView__InitTouchCursor(work, 0);
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                work->lastMoveDist.x = work->moveDist1.x;
                work->lastMoveDist.y = work->moveDist1.y;

                if (MATH_ABS(work->lastMoveDist.x) < FLOAT_TO_FX32(3.0))
                    work->lastMoveDist.x = FLOAT_TO_FX32(0.0);

                if (MATH_ABS(work->lastMoveDist.y) < FLOAT_TO_FX32(3.0))
                    work->lastMoveDist.y = FLOAT_TO_FX32(0.0);

                SeaMapView__InitTouchCursor(work, -1);
            }
            break;

        case TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                work->moveDist1.x = FX32_FROM_WHOLE(-response->move.x);
                work->moveDist1.y = FX32_FROM_WHOLE(-response->move.y);
                work->moveDist2.x = FX32_FROM_WHOLE(-response->move.x);
                work->moveDist2.y = FX32_FROM_WHOLE(-response->move.y);
            }
            break;
    }
}

void SeaMapView__OnButtonPressed(TouchAreaResponse *response, TouchArea *touchArea, void *userData, u32 id)
{
    SeaMapView *work = (SeaMapView *)userData;

    TouchAreaResponseFlags areaFlags = touchArea->responseFlags;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_ENTERED_AREA:
        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                SetSpriteButtonState(&work->buttonAnimators[id], SPRITE_BUTTON_STATE_HOVERED);
            }
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA:
        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
            if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
            {
                SetSpriteButtonState(&work->buttonAnimators[id], SPRITE_BUTTON_STATE_IDLE);
            }
            break;

        case TOUCHAREA_RESPONSE_40000:
            work->selectedButton = id;
            break;
    }
}

void SeaMapView__ButtonCallback1(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 0);
}

void SeaMapView__ButtonCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 1);
}

void SeaMapView__ButtonCallback3(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 2);
}

void SeaMapView__ButtonCallback4(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 3);
}

void SeaMapView__ButtonCallback5(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 4);
}

void SeaMapView__ButtonCallback6(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 5);
}

void SeaMapView__ButtonCallback7(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 6);
}

void SeaMapView__ButtonCallback8(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapView__OnButtonPressed(response, touchArea, userData, 7);
}

void SeaMapView__DrawPenMarker(SeaMapView *work)
{
    AnimatorSprite *aniPenMarker = &work->aniPenMarker;
    if (SeaMapManager__GetNodeCount() == 0)
        return;

    SeaMapManagerNode *endNode = SeaMapManager__GetEndNode();

    SeaMapManager__Func_2043AD4(endNode->position.x, endNode->position.y, &aniPenMarker->pos.x, &aniPenMarker->pos.y);
    AnimatorSprite__ProcessAnimationFast(aniPenMarker);
    AnimatorSprite__DrawFrame(aniPenMarker);
}

void SeaMapView__DrawButtons(SeaMapView *work)
{
    u32 i;
    SpriteButtonAnimator *aniButton = work->buttonAnimators;
    AnimatorSprite *aniTextBorder;

    for (i = 0; i < 8; i++)
    {
        if ((aniButton->animator.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
        {
            AnimatorSprite__ProcessAnimationFast(&aniButton->animator);
            AnimatorSprite__DrawFrame(&aniButton->animator);

            aniTextBorder = &work->aniTextBorder;
            if (i >= 5)
            {
                aniTextBorder->pos.x = aniButton->animator.pos.x;
                aniTextBorder->pos.y = aniButton->animator.pos.y;
                AnimatorSprite__DrawFrame(aniTextBorder);
            }
        }

        aniButton++;
    }
}

void SeaMapView__DrawTouchCursor(SeaMapView *work)
{
    if ((IsTouchInputEnabled() == FALSE || TouchInput__IsTouchOn(&touchInput) == FALSE))
        return;

    AnimatorSprite *aniTouchCursor = &work->aniTouchCursor;
    aniTouchCursor->pos.x          = touchInput.on.x;
    aniTouchCursor->pos.y          = touchInput.on.y;
    AnimatorSprite__DrawFrame(aniTouchCursor);
}

void SeaMapView__DrawPadCursors(SeaMapView *work)
{
    if (work->field_7A4 >= 0 && ((work->field_7A4 >> 5) & 1) != 0)
    {
        AnimatorSprite *aniCursor0 = &work->aniPadCursor[0];
        if ((aniCursor0->flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
        {
            aniCursor0->flags &= ~ANIMATOR_FLAG_FLIP_Y;

            aniCursor0->pos.x = HW_LCD_CENTER_X;
            aniCursor0->pos.y = 32;
            AnimatorSprite__DrawFrame(aniCursor0);

            aniCursor0->flags |= ANIMATOR_FLAG_FLIP_Y;
            aniCursor0->pos.x = HW_LCD_CENTER_X;
            aniCursor0->pos.y = HW_LCD_HEIGHT - 48;
            AnimatorSprite__DrawFrame(aniCursor0);
        }

        AnimatorSprite *aniCursor1 = &work->aniPadCursor[1];
        if ((aniCursor1->flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
        {
            aniCursor1->flags &= ~ANIMATOR_FLAG_FLIP_X;

            aniCursor1->pos.x = 32;
            aniCursor1->pos.y = HW_LCD_CENTER_Y;
            AnimatorSprite__DrawFrame(aniCursor1);

            aniCursor1->flags |= ANIMATOR_FLAG_FLIP_X;
            aniCursor1->pos.x = HW_LCD_WIDTH - 32;
            aniCursor1->pos.y = HW_LCD_CENTER_Y;
            AnimatorSprite__DrawFrame(aniCursor1);
        }
    }
}

void SeaMapView__Func_203F770(SeaMapView *work)
{
    SeaMapManager__Func_2043974(work->position.x, work->position.y);

    work->position.x = SeaMapManager__GetXPos();
    work->position.y = SeaMapManager__GetYPos();
}

BOOL SeaMapView__FadeToBlack(SeaMapView *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    if (gfxControl->brightness < 0)
    {
        if (-gfxControl->brightness > 1)
            gfxControl->brightness++;
        else
            gfxControl->brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
    }
    else if (gfxControl->brightness > 0)
    {
        if (gfxControl->brightness > 1)
            gfxControl->brightness--;
        else
            gfxControl->brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
    }

    return gfxControl->brightness == RENDERCORE_BRIGHTNESS_DEFAULT;
}

BOOL SeaMapView__FadeActiveScreen(SeaMapView *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->useEngineB];

    if (gfxControl->brightness < work->targetBrightness)
    {
        if (work->targetBrightness - gfxControl->brightness > 1)
            gfxControl->brightness++;
        else
            gfxControl->brightness = work->targetBrightness;
    }
    else if (gfxControl->brightness > work->targetBrightness)
    {
        if (gfxControl->brightness - work->targetBrightness > 1)
            gfxControl->brightness--;
        else
            gfxControl->brightness = work->targetBrightness;
    }

    return work->targetBrightness == gfxControl->brightness;
}

BOOL SeaMapView__FadeOtherScreen(SeaMapView *work)
{
    RenderCoreGFXControl *gfxControl;
    if (work->useEngineB == GRAPHICS_ENGINE_A)
        gfxControl = &renderCoreGFXControlB;
    else
        gfxControl = &renderCoreGFXControlA;

    if (gfxControl->brightness < work->targetBrightness)
    {
        if (work->targetBrightness - gfxControl->brightness > 1)
            gfxControl->brightness++;
        else
            gfxControl->brightness = work->targetBrightness;
    }
    else if (gfxControl->brightness > work->targetBrightness)
    {
        if (gfxControl->brightness - work->targetBrightness > 1)
            gfxControl->brightness--;
        else
            gfxControl->brightness = work->targetBrightness;
    }

    return work->targetBrightness == gfxControl->brightness;
}

void SeaMapView__DrawVoyagePath(void)
{
    SeaMapManager__ClearUnknownPtr();

    switch (SeaMapManager__GetZoomLevel())
    {
        case 0:
            SeaMapView__DrawVoyagePath_Zoom0();
            break;

        case 1:
            SeaMapView__DrawVoyagePath_Zoom1();
            break;

        case 2:
            SeaMapView__DrawVoyagePath_Zoom2();
            break;
    }

    SeaMapManager__EnableDrawFlags(8);
}

void SeaMapView__DrawVoyagePath_Zoom0(void)
{
    if (SeaMapManager__GetNodeCount() < 2)
        return;

    SeaMapManagerNode *prevNode = SeaMapManager__GetStartNode();
    SeaMapManagerNode *nextNode = SeaMapManager__GetNextNode(prevNode);
    do
    {
        SeaMapManager__DrawNodeLine2(prevNode->position.x, prevNode->position.y, nextNode->position.x, nextNode->position.y, 2);
        SeaMapManager__DrawNodeLine(prevNode->position.x, prevNode->position.y, 2);
        SeaMapManager__DrawNodeLine(nextNode->position.x, nextNode->position.y, 2);

        prevNode = nextNode;
        nextNode = SeaMapManager__GetNextNode(nextNode);
    } while (nextNode);
}

void SeaMapView__DrawVoyagePath_Zoom1(void)
{
    if (SeaMapManager__GetNodeCount() < 2)
        return;

    SeaMapManagerNode *prevNode = SeaMapManager__GetStartNode();
    SeaMapManagerNode *nextNode = SeaMapManager__GetNextNode(prevNode);

    u16 prevX = prevNode->position.x / 2;
    u16 prevY = prevNode->position.y / 2;
    do
    {
        u16 nextX = nextNode->position.x / 2;
        u16 nextY = nextNode->position.y / 2;
        SeaMapManager__DrawNodeLine2(prevX, prevY, nextX, nextY, 1);

        nextNode = SeaMapManager__GetNextNode(nextNode);
        prevX    = nextX;
        prevY    = nextY;
    } while (nextNode);
}

void SeaMapView__DrawVoyagePath_Zoom2(void)
{
    if (SeaMapManager__GetNodeCount() < 2)
        return;

    SeaMapManagerNode *prevNode = SeaMapManager__GetStartNode();
    SeaMapManagerNode *nextNode = SeaMapManager__GetNextNode(prevNode);

    u16 prevX = FX_DivS32(prevNode->position.x, 3);
    u16 prevY = FX_DivS32(prevNode->position.y, 3);
    do
    {
        u16 nextX = FX_DivS32(nextNode->position.x, 3);
        u16 nextY = FX_DivS32(nextNode->position.y, 3);
        SeaMapManager__DrawNodeLine2(prevX, prevY, nextX, nextY, 1);

        nextNode = SeaMapManager__GetNextNode(nextNode);
        prevX    = nextX;
        prevY    = nextY;
    } while (nextNode);
}

void SeaMapView__Func_203FAD4(void)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case 0:
            SeaMapView__Func_203FB10();
            break;

        case 1:
            SeaMapView__Func_203FB78();
            break;

        case 2:
            SeaMapView__Func_203FBE8();
            break;
    }
}

void SeaMapView__Func_203FB10(void)
{
    if (SeaMapManager__GetNodeCount() < 2)
        return;

    SeaMapManagerNode *nextNode = SeaMapManager__GetEndNode();
    SeaMapManagerNode *prevNode = SeaMapManager__GetPrevNode(nextNode);

    SeaMapManager__DrawNodeLine2(prevNode->position.x, prevNode->position.y, nextNode->position.x, nextNode->position.y, 2);
    SeaMapManager__DrawNodeLine(prevNode->position.x, prevNode->position.y, 2);
    SeaMapManager__DrawNodeLine(nextNode->position.x, nextNode->position.y, 2);

    SeaMapManager__EnableDrawFlags(8);
}

void SeaMapView__Func_203FB78(void)
{
    if (SeaMapManager__GetNodeCount() < 2)
        return;

    SeaMapManagerNode *nextNode = SeaMapManager__GetEndNode();
    SeaMapManagerNode *prevNode = SeaMapManager__GetPrevNode(nextNode);

    u16 x1 = prevNode->position.x / 2;
    u16 y1 = prevNode->position.y / 2;
    u16 x2 = nextNode->position.x / 2;
    u16 y2 = nextNode->position.y / 2;
    SeaMapManager__DrawNodeLine2(x1, y1, x2, y2, 1);

    SeaMapManager__EnableDrawFlags(8);
}

void SeaMapView__Func_203FBE8(void)
{
    if (SeaMapManager__GetNodeCount() < 2)
        return;

    SeaMapManagerNode *nextNode = SeaMapManager__GetEndNode();
    SeaMapManagerNode *prevNode = SeaMapManager__GetPrevNode(nextNode);

    u16 x1 = FX_DivS32(prevNode->position.x, 3);
    u16 y1 = FX_DivS32(prevNode->position.y, 3);
    u16 x2 = FX_DivS32(nextNode->position.x, 3);
    u16 y2 = FX_DivS32(nextNode->position.y, 3);
    SeaMapManager__DrawNodeLine2(x1, y1, x2, y2, 1);

    SeaMapManager__EnableDrawFlags(8);
}

NONMATCH_FUNC s32 SeaMapView__Func_203FC7C(SeaMapView *work, u16 x, u16 y)
{
	// https://decomp.me/scratch/9MJ6z -> 87.14%
#ifdef NON_MATCHING
    VecFx32 direction;
    s32 result = 0;
    u16 lastY, lastX;
    u16 outY, outX;
    u16 inY, inX;

    SeaMapManager__GetLastNodePosition(&lastX, &lastY);

    if (lastX == x && lastY == y)
        return 1;

    SeaMapManager__Func_2043BB4(x, y, &outX, &outY);
    SeaMapManager__Func_2043BB4(lastX, lastY, &inX, &inY);
    if (SeaMapCollision__HandleCollisions(outX, outY, inX, inY, TRUE, &outX, &outY))
    {
        result = -1;
        SeaMapManager__Func_2043BD0(outX, outY, &x, &y);

        if (lastX == x || lastY == y)
            return 1;
    }

    SeaMapManager__AddNode(x, y);
    if (work->currentVoyageDist < SeaMapManager__GetEndNode()->distance)
    {
        VEC_Set(&direction, FX32_FROM_WHOLE(x - lastX), FX32_FROM_WHOLE(y - lastY), FLOAT_TO_FX32(0.0));
        VEC_Normalize(&direction, &direction);

        x      = lastX + FX32_FROM_WHOLE(MultiplyFX(direction.x, work->currentVoyageDist));
        y      = lastY + FX32_FROM_WHOLE(MultiplyFX(direction.y, work->currentVoyageDist));
        result = -2;
    }

    SeaMapManager__RemoveNode();
    SeaMapManager__AddNode(x, y);

    work->currentVoyageDist = work->currentVoyageDist - SeaMapManager__GetEndNode()->distance;
    if (work->currentVoyageDist < 0)
        work->currentVoyageDist = 0;

    return result;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	mov r5, r0
	strh r1, [sp, #0x18]
	add r0, sp, #0x14
	add r1, sp, #0x16
	strh r2, [sp, #0x1a]
	mov r4, #0
	bl SeaMapManager__GetLastNodePosition
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x14]
	cmp r1, r0
	ldreqh r2, [sp, #0x16]
	ldreqh r1, [sp, #0x1a]
	cmpeq r2, r1
	addeq sp, sp, #0x28
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r1, [sp, #0x1a]
	add r2, sp, #0x10
	add r3, sp, #0x12
	bl SeaMapManager__Func_2043BB4
	ldrh r0, [sp, #0x14]
	ldrh r1, [sp, #0x16]
	add r2, sp, #0xc
	add r3, sp, #0xe
	bl SeaMapManager__Func_2043BB4
	mov r0, #1
	str r0, [sp]
	add r1, sp, #0x10
	add r0, sp, #0x12
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	ldrh r2, [sp, #0xc]
	ldrh r3, [sp, #0xe]
	bl SeaMapCollision__HandleCollisions
	cmp r0, #0
	beq _0203FD58
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	add r2, sp, #0x18
	add r3, sp, #0x1a
	mvn r4, #0
	bl SeaMapManager__Func_2043BD0
	ldrh r1, [sp, #0x14]
	ldrh r0, [sp, #0x18]
	cmp r1, r0
	ldrneh r1, [sp, #0x16]
	ldrneh r0, [sp, #0x1a]
	cmpne r1, r0
	addeq sp, sp, #0x28
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
_0203FD58:
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x1a]
	bl SeaMapManager__AddNode
	bl SeaMapManager__GetEndNode
	ldr r1, [r5, #0x79c]
	ldr r0, [r0, #0xc]
	cmp r1, r0
	bge _0203FE0C
	ldrh r3, [sp, #0x18]
	ldrh r0, [sp, #0x14]
	ldrh r2, [sp, #0x1a]
	ldrh r1, [sp, #0x16]
	sub r3, r3, r0
	mov r4, r3, lsl #0xc
	sub r1, r2, r1
	mov r3, r1, lsl #0xc
	add r0, sp, #0x1c
	mov r2, #0
	mov r1, r0
	str r4, [sp, #0x1c]
	str r3, [sp, #0x20]
	str r2, [sp, #0x24]
	bl VEC_Normalize
	ldr r1, [sp, #0x1c]
	ldr r0, [r5, #0x79c]
	ldrh r3, [sp, #0x14]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1, asr #12
	strh r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	ldr r1, [r5, #0x79c]
	ldrh r4, [sp, #0x16]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r4, r2, asr #12
	mov r0, #0
	strh r1, [sp, #0x1a]
	sub r4, r0, #2
_0203FE0C:
	bl SeaMapManager__RemoveNode
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x1a]
	bl SeaMapManager__AddNode
	bl SeaMapManager__GetEndNode
	ldr r1, [r5, #0x79c]
	ldr r0, [r0, #0xc]
	subs r0, r1, r0
	str r0, [r5, #0x79c]
	movmi r0, #0
	strmi r0, [r5, #0x79c]
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SeaMapView__Func_203FE44(SeaMapView *work)
{
    SeaMapManager__RemoveAllNodes();

    work->currentVoyageDist = work->totalVoyageDist - SeaMapView__sVars.unknown2;
    if (work->currentVoyageDist < 0)
        work->currentVoyageDist = 0;

    work->nodeCount = 0;
}

void SeaMapView__Func_203FE80(SeaMapView *work)
{
    SeaMapManager__Func_2045E58(work->nodeCount);

    work->nodeCount = SeaMapManager__GetNodeCount();

    work->currentVoyageDist = work->totalVoyageDist - SeaMapView__sVars.unknown2 - SeaMapManager__GetTotalDistance();
    if (work->currentVoyageDist < 0)
        work->currentVoyageDist = 0;
}