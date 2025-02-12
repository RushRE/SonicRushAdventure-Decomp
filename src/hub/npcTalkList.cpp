
#include <hub/npcTalkList.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/graphics/mappingsQueue.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/text/mpc.h>
#include <game/text/fontAnimator.h>

// resources
#include <resources/narc/vi_bg_lz7.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void BackgroundUnknown__Func_204CBF4(void *a1, s32 a2, u16 a3, u16 a4, u16 a5, u16 a6);
NOT_DECOMPILED void BackgroundUnknown__CopyPixels(void *pixels, s32 unitWidth, s32 startX, s32 startY, u16 sizeX, u16 sizeY, void *pixels2, u16 pixelWidth, u16 targetX,
                                                  u16 targetY, u16 a11);

NOT_DECOMPILED void _ZN10HubControl16GetFileFrom_ViBGEt(void);

NOT_DECOMPILED void _ZN11NpcTalkList23UpdateListEntryMappingsEt(void);
NOT_DECOMPILED void _ZN11NpcTalkList28UpdateListBackgroundMappingsEt(void);
NOT_DECOMPILED void _ZN11NpcTalkList21GetVisibleEntryBoundsEmPtS0_(void);
}

// --------------------
// CONSTANTS/MACROS
// --------------------

// display 6 entries + the number of the 7th
#define NPCTALKLIST_VIEW_SIZE (TILE_TO_PIXEL(3 * 6) + TILE_TO_PIXEL(1))

// --------------------
// STRUCTS
// --------------------

struct NpcTalkListSpriteCallbackUserData
{
    NpcTalkList *talkList;
    u32 id;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED const GXRgb NpcTalkList__MissionTextLockedPalette[3];
NOT_DECOMPILED const GXRgb NpcTalkList__MissionTextClearedPalette[3];
NOT_DECOMPILED const GXRgb NpcTalkList__MovieTextLockedPalette[3];
NOT_DECOMPILED const GXRgb NpcTalkList__MovieTextClearedPalette[3];

NOT_DECOMPILED const u16 NpcTalkList__keyRepeatRepeatTime[];
NOT_DECOMPILED const u16 NpcTalkList__keyRepeatInitialTime[];

// static const GXRgb NpcTalkList__MissionTextLockedPalette[3] = { GX_RGB_888(0x70, 0x88, 0xC8), GX_RGB_888(0x38, 0x50, 0x80), GX_RGB_888(0x00, 0x18, 0x38) };
// static const GXRgb NpcTalkList__MissionTextClearedPalette[3] = { GX_RGB_888(0xF8, 0xD8, 0x00), GX_RGB_888(0xC0, 0x98, 0x00), GX_RGB_888(0x20, 0x50, 0x00) };
// static const GXRgb NpcTalkList__MovieTextLockedPalette[3] = { GX_RGB_888(0xC0, 0x58, 0x00), GX_RGB_888(0x78, 0x78, 0x00), GX_RGB_888(0x38, 0x30, 0x00) };
// static const GXRgb NpcTalkList__MovieTextClearedPalette[3] = { GX_RGB_888(0xC0, 0x58, 0x00), GX_RGB_888(0x78, 0x78, 0x00), GX_RGB_888(0x38, 0x30, 0x00) };

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

RUSH_INLINE BOOL CheckTouchPullEnabled()
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_PULL(touchInput.flags))
            return TRUE;
    }

    return FALSE;
}

// --------------------
// FUNCTIONS
// --------------------

// NpcTalkList
void NpcTalkList::Init()
{
    MI_CpuClear32(this, sizeof(*this));

    FontWindowAnimator__Init(&this->fontWindowAnimator);
    FontWindowMWControl__Init(&this->fontWindowMWControl);
}

void NpcTalkList::Load(ViTalkListConfig *config)
{
    this->entryList              = config->entryList;
    this->entryCount             = config->entryCount;
    this->currentSelection       = config->selection;
    this->chosenSelection        = config->selection;
    this->selectedEntry          = NPCTALKLIST_SELECTION_NONE;
    this->numDigitCount          = config->numDigitCount;
    this->fontWindow             = config->fontWindow;
    this->lastHeldTouchSelection = NPCTALKLIST_SELECTION_NONE;

    MI_CpuCopy16(config, &this->listConfig, sizeof(this->listConfig));
    this->InitMappings(config);
    this->InitSprites(config);
    this->InitTouchField(config);
    this->isWindowOpen      = FALSE;
    this->isWindowAnimating = FALSE;
    this->isWindowClosing   = FALSE;

    this->state = NpcTalkList::State_Finished;
}

void NpcTalkList::Release()
{
    this->ReleaseTouchField();
    this->ReleaseList();
    this->ReleaseMappings();
    this->Init();
}

void NpcTalkList::ShowWindow(s32 selection, BOOL flag)
{
    this->EnableKeyRepeat(TRUE);

    this->selectedEntry = NPCTALKLIST_SELECTION_NONE;
    this->SetListWindowVisible(FALSE);
    this->SetListTextVisible(FALSE);

    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 1, 12, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);

    this->isWindowAnimating = TRUE;

    if (flag)
        FontWindowAnimator__Func_20599C4(&this->fontWindowAnimator);
    else
        FontWindowAnimator__Func_20599B4(&this->fontWindowAnimator);

    this->state = NpcTalkList::State_OpenWindow;

    PlayHubSfx(HUB_SFX_V_POPUP);
}

void NpcTalkList::Process()
{
    void (*state)(NpcTalkList *work) = this->state;

    if (state != NULL)
        state(this);

    this->prevState = state;
}

u16 NpcTalkList::GetSelection()
{
    return this->chosenSelection;
}

BOOL NpcTalkList::IsWindowOpen()
{
    return this->isWindowOpen;
}

BOOL NpcTalkList::IsWindowClosing()
{
    return this->isWindowClosing;
}

BOOL NpcTalkList::CheckSelectionMade()
{
    if (this->IsFinished() == FALSE)
        return FALSE;

    if (this->GetSelectedEntry() == (u16)NPCTALKLIST_SELECTION_NONE)
        return FALSE;

    return TRUE;
}

BOOL NpcTalkList::IsFinished()
{
    return this->state == NpcTalkList::State_Finished;
}

u16 NpcTalkList::GetSelectedEntry()
{
    return this->selectedEntry;
}

void NpcTalkList::InitSprites(ViTalkListConfig *config)
{
    FontWindowAnimator__Init(&this->fontWindowAnimator);
    FontWindowAnimator__Load1(&this->fontWindowAnimator, HubControl::GetField54(), 0, config->windowSizeX, config->windowSizeY, PIXEL_TO_TILE(0), PIXEL_TO_TILE(0),
                              PIXEL_TO_TILE(HW_LCD_WIDTH), PIXEL_TO_TILE(HW_LCD_HEIGHT), GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_3, 960, 1023);
    FontWindowMWControl__Init(&this->fontWindowMWControl);
    FontWindowMWControl__Load(&this->fontWindowMWControl, HubControl::GetField54(), 0, config->windowFrame, 25, 16, GRAPHICS_ENGINE_A, SPRITE_PRIORITY_1, SPRITE_ORDER_31,
                              PALETTE_ROW_5);

    void *sprHUDLoc         = config->sprMapLocHUD;
    VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprHUDLoc, config->headerAnim));
    AnimatorSprite__Init(&this->aniHeader, sprHUDLoc, config->headerAnim, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_30);
    this->aniHeader.pos.x          = 8;
    this->aniHeader.pos.y          = 8;
    this->aniHeader.cParam.palette = PALETTE_ROW_12;

    void *sprMenu = config->sprMenu;
    vramPixels    = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprMenu, 2));
    AnimatorSprite__Init(&this->aniButtonUp, sprMenu, 2, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_30);
    this->aniButtonUp.pos.x          = (HW_LCD_WIDTH - 32);
    this->aniButtonUp.pos.y          = 32;
    this->aniButtonUp.cParam.palette = PALETTE_ROW_13;

    sprMenu    = config->sprMenu;
    vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprMenu, 5));
    AnimatorSprite__Init(&this->aniButtonDown, sprMenu, 5, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_30);
    this->aniButtonDown.pos.x          = (HW_LCD_WIDTH - 32);
    this->aniButtonDown.pos.y          = 96;
    this->aniButtonDown.cParam.palette = PALETTE_ROW_14;

    void *sprBackButton = config->sprBackButton;
    vramPixels          = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1(sprBackButton));
    AnimatorSprite__Init(&this->aniBackButton, sprBackButton, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, (u16 *)VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_1, SPRITE_ORDER_30);
    this->aniBackButton.pos.x          = (HW_LCD_WIDTH - 20);
    this->aniBackButton.pos.y          = 172;
    this->aniBackButton.cParam.palette = PALETTE_ROW_15;

    void *sprCursor = config->sprCursor;
    vramPixels      = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprCursor, 1));
    AnimatorSprite__Init(&this->aniCursor, sprCursor, 1, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, (u16 *)VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    this->aniBackButton.cParam.palette = PALETTE_ROW_8;

    this->listTextPixelSize  = 0x6400;
    this->listTextVRAMPixels = (u8 *)VRAM_BG + 0x1000;
    this->listTextPixels     = (void *)HeapAllocHead(HEAP_USER, this->listTextPixelSize);
    this->listTextMappings   = (GXScrText32x32 *)HeapAllocHead(HEAP_USER, sizeof(GXScrText32x32));

    MessageController__Init(&this->msgController);
    MessageController__SetFont(&this->msgController, FontWindow__GetFont(this->fontWindow));
    MessageController__LoadMPCFile(&this->msgController, config->mpcFile);
    MessageController__Setup(&this->msgController, this->listTextPixels, VRAM_BACKGROUND_32x32_WIDTH - 7, VRAM_BACKGROUND_32x32_HEIGHT, 0, 0, 0);
    MessageController__SetClearPixelCallback(&this->msgController, NpcTalkList::PixelClearCallback, this);

    this->entries = (NpcTalkListConfigEntry *)HeapAllocHead(HEAP_SYSTEM, sizeof(NpcTalkListConfigEntry) * this->entryCount);

    s32 i;
    s32 scrollPos = 0;
    for (i = 0; i < this->entryCount; i++)
    {
        this->entries[i].flags = NPCTALKLISTENTRY_FLAG_NONE;

        if ((this->entryList[i].flags & NPCTALKLISTENTRY_FLAG_UNLOCKED) != 0)
            this->entries[i].flags |= NPCTALKLISTENTRY_FLAG_UNLOCKED;

        if ((this->entryList[i].flags & NPCTALKLISTENTRY_FLAG_ATTEMPTED) != 0)
            this->entries[i].flags |= NPCTALKLISTENTRY_FLAG_ATTEMPTED;

        if ((this->entryList[i].flags & NPCTALKLISTENTRY_FLAG_CLEARED) != 0)
            this->entries[i].flags |= NPCTALKLISTENTRY_FLAG_CLEARED;

        this->entries[i].sequence  = this->entryList[i].id;
        this->entries[i].lineCount = MPC__GetDialogLineCount(config->mpcFile, this->entries[i].sequence, 0);
        this->entries[i].scrollPos = scrollPos;

        scrollPos += TILE_TO_PIXEL(2) * this->entries[i].lineCount;
        scrollPos += TILE_TO_PIXEL(1);
    }

    this->scrollPosLimit = scrollPos - NPCTALKLIST_VIEW_SIZE;
    if (this->scrollPosLimit >= scrollPos)
        this->scrollPosLimit = 0;

    this->scrollPos = this->entries[this->currentSelection].scrollPos;
    if (this->scrollPos > this->scrollPosLimit)
        this->scrollPos = this->scrollPosLimit;

    this->InitListTextGraphics();
    this->unknownFlag = FALSE;
}

void NpcTalkList::InitMappings(ViTalkListConfig *config)
{
    if (config->windowFrame == FONTWINDOWMW_FILL_MISSION)
        ((GXRgb *)VRAM_BG_PLTT)[65] = GX_RGB_888(0x00, 0x30, 0x50);
    else
        ((GXRgb *)VRAM_BG_PLTT)[65] = GX_RGB_888(0x58, 0x50, 0x00);

    // init list window tiles
    MI_CpuFill32((u8 *)VRAM_BG + 0x8800, 0x00000000, sizeof(GXCharFmt16)); // point all pixels (4-bit) to palette color 0
    MI_CpuFill32((u8 *)VRAM_BG + 0x8820, 0x11111111, sizeof(GXCharFmt16)); // point all pixels (4-bit) to palette color 1

    // init tile region
    MI_CpuFill16((u8 *)VRAM_BG + 0x8000, VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), sizeof(GXScrText32x32));

    this->listEntryMappings        = (GXScrText32x32 *)HeapAllocHead(HEAP_USER, sizeof(GXScrText32x32));
    this->listEntryMapping_EntryBG = (GXScrFmtText *)HeapAllocHead(HEAP_USER, VRAM_BACKGROUND_32x32_WIDTH * sizeof(GXScrFmtText));
    this->listEntryMapping_Unknown = (GXScrFmtText *)HeapAllocHead(HEAP_USER, VRAM_BACKGROUND_32x32_WIDTH * sizeof(GXScrFmtText));
    this->listEntryMapping_Blank   = (GXScrFmtText *)HeapAllocHead(HEAP_USER, VRAM_BACKGROUND_32x32_WIDTH * sizeof(GXScrFmtText));

    MI_CpuFill32(this->listEntryMappings, VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4)),
                 sizeof(GXScrText32x32));

    MI_CpuFill16(this->listEntryMapping_EntryBG, VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), 2 * sizeof(GXScrFmtText));
    MI_CpuFill16(&this->listEntryMapping_EntryBG[2], VRAM_SCRFMT_TEXT(65, FALSE, FALSE, PALETTE_ROW_4), 25 * sizeof(GXScrFmtText));
    MI_CpuFill16(&this->listEntryMapping_EntryBG[VRAM_BACKGROUND_32x32_WIDTH - 5], VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), 5 * sizeof(GXScrFmtText));

    MI_CpuFill16(this->listEntryMapping_Unknown, VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), 2 * sizeof(GXScrFmtText));
    MI_CpuFill16(&this->listEntryMapping_Unknown[2], VRAM_SCRFMT_TEXT(66, FALSE, FALSE, PALETTE_ROW_4), 25 * sizeof(GXScrFmtText));
    MI_CpuFill16(&this->listEntryMapping_Unknown[VRAM_BACKGROUND_32x32_WIDTH - 5], VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), 5 * sizeof(GXScrFmtText));

    MI_CpuFill32(this->listEntryMapping_Blank, VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4), VRAM_SCRFMT_TEXT(64, FALSE, FALSE, PALETTE_ROW_4)),
                 VRAM_BACKGROUND_32x32_WIDTH * sizeof(GXScrFmtText));
}

void NpcTalkList::InitTouchField(ViTalkListConfig *config)
{
    TouchRectUnknown touchRect;

    TouchField__Init(&this->touchField);
    this->touchField.mode           = 0;
    this->touchField.delayDuration1 = 0;
    this->touchField.delayDuration3 = 20;
    this->touchField.delayDuration2 = 1;

    touchRect.box.left   = (HW_LCD_WIDTH - 32);
    touchRect.box.top    = 32;
    touchRect.box.right  = (HW_LCD_WIDTH - 8);
    touchRect.box.bottom = 92;
    TouchField__InitAreaShape(&this->touchArea[0], NULL, TouchField__PointInRect, &touchRect, NULL, NULL);
    this->touchAreaEnabled[0] = FALSE;

    touchRect.box.left   = (HW_LCD_WIDTH - 32);
    touchRect.box.top    = 96;
    touchRect.box.right  = (HW_LCD_WIDTH - 8);
    touchRect.box.bottom = 156;
    TouchField__InitAreaShape(&this->touchArea[1], NULL, TouchField__PointInRect, &touchRect, NULL, NULL);
    this->touchAreaEnabled[1] = FALSE;

    TouchField__InitAreaShape(&this->touchArea[2], NULL, TouchField__PointInRect, NULL, NULL, NULL);
    this->touchAreaEnabled[2] = FALSE;

    this->EnableAllTouchAreas(FALSE);
}

void NpcTalkList::ReleaseList()
{
    if (this->entries != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->entries);
        this->entries = NULL;
    }

    if (this->listTextMappings != NULL)
    {
        HeapFree(HEAP_USER, this->listTextMappings);
        this->listTextMappings = NULL;
    }

    if (this->listTextPixels != NULL)
    {
        HeapFree(HEAP_USER, this->listTextPixels);
        this->listTextPixels = NULL;
    }

    MessageController__InitFunc(&this->msgController);
    AnimatorSprite__Release(&this->aniCursor);
    AnimatorSprite__Release(&this->aniBackButton);
    AnimatorSprite__Release(&this->aniButtonDown);
    AnimatorSprite__Release(&this->aniButtonUp);
    AnimatorSprite__Release(&this->aniHeader);
    FontWindowMWControl__Release(&this->fontWindowMWControl);
    FontWindowAnimator__Release(&this->fontWindowAnimator);
}

void NpcTalkList::ReleaseMappings()
{
    if (this->listEntryMapping_Blank != NULL)
    {
        HeapFree(HEAP_USER, this->listEntryMapping_Blank);
        this->listEntryMapping_Blank = NULL;
    }

    if (this->listEntryMapping_EntryBG != NULL)
    {
        HeapFree(HEAP_USER, this->listEntryMapping_EntryBG);
        this->listEntryMapping_EntryBG = NULL;
    }

    if (this->listEntryMapping_Unknown != NULL)
    {
        HeapFree(HEAP_USER, this->listEntryMapping_Unknown);
        this->listEntryMapping_Unknown = NULL;
    }

    if (this->listEntryMappings != NULL)
    {
        HeapFree(HEAP_USER, this->listEntryMappings);
        this->listEntryMappings = NULL;
    }
}

void NpcTalkList::ReleaseTouchField()
{
    // Do nothing.
}

NONMATCH_FUNC void NpcTalkList::InitListTextGraphics()
{
    // https://decomp.me/scratch/srGTE -> 97.36%
#ifdef NON_MATCHING
    u16 mapping = VRAM_SCRFMT_TEXT(128, FALSE, FALSE, PALETTE_ROW_0);
    u16 m       = 0;
    s32 i       = 0;
    s32 j       = 0;
    u16 p       = 0;
    u16 e       = 0;

    for (; i < VRAM_BACKGROUND_32x32_WIDTH; i++)
    {
        MI_CpuFill16(&this->listTextMappings->data16[p], VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), 4);

        j = 0;
        m = p + 2;
        for (; j < VRAM_BACKGROUND_32x32_WIDTH - 7;)
        {
            this->listTextMappings->data16[m] = mapping;
            mapping++;

            j++;
            m++;
        }

        MI_CpuFill16(&this->listTextMappings->data16[m], VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), 10);

        p = m + 5;
    }

    MI_CpuClearFast(this->listTextPixels, this->listTextPixelSize);
    this->GetVisibleEntryBounds(this->scrollPos, &this->firstVisibleEntry, &this->lastVisibleEntry);

    for (e = this->firstVisibleEntry; e <= this->lastVisibleEntry; e++)
    {
        this->UpdateListBackgroundMappings(e);
        this->UpdateListEntryMappings(e);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r9, #0
	ldr r6, =0x000003FF
	mov r10, r0
	mov r7, r9
	mov r8, #0x80
	mov r11, #0xa
	mov r5, #4
	mov r4, r9
_0216F804:
	ldr r1, [r10, #0x380]
	mov r0, r6
	mov r2, r5
	add r1, r1, r9, lsl #1
	bl MIi_CpuClear16
	add r0, r9, #2
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r9, r1, lsr #0x10
_0216F828:
	add r1, r8, #1
	add r2, r9, #1
	add r0, r0, #1
	ldr ip, [r10, #0x380]
	mov r3, r9, lsl #1
	strh r8, [ip, r3]
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	cmp r0, #0x19
	mov r8, r1, lsr #0x10
	mov r9, r2, lsr #0x10
	blt _0216F828
	ldr r1, [r10, #0x380]
	mov r0, r6
	mov r2, r11
	add r1, r1, r9, lsl #1
	bl MIi_CpuClear16
	add r0, r9, #5
	mov r0, r0, lsl #0x10
	add r7, r7, #1
	cmp r7, #0x20
	mov r9, r0, lsr #0x10
	blt _0216F804
	ldr r1, [r10, #0x37c]
	ldr r2, [r10, #0x378]
	mov r0, #0
	bl MIi_CpuClearFast
	add r3, r10, #0x96
	ldr r1, [r10, #0x388]
	mov r0, r10
	add r2, r10, #0x394
	add r3, r3, #0x300
	bl _ZN11NpcTalkList21GetVisibleEntryBoundsEmPtS0_
	add r4, r10, #0x300
	ldrh r5, [r4, #0x94]
	ldrh r0, [r4, #0x96]
	cmp r5, r0
	ldmhiia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216F8C0:
	mov r0, r10
	mov r1, r5
	bl _ZN11NpcTalkList28UpdateListBackgroundMappingsEt
	mov r0, r10
	mov r1, r5
	bl _ZN11NpcTalkList23UpdateListEntryMappingsEt
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x96]
	mov r5, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhs _0216F8C0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void NpcTalkList::UpdateListBorderMappings(u32 scrollPos, u16 entrySize)
{
    u32 scroll = FX_ModS32(scrollPos, VRAM_WINDOW_HEIGHT);
    if (scroll + entrySize > VRAM_WINDOW_HEIGHT)
    {
        BackgroundUnknown__Func_204CBF4(this->listTextPixels, 25, 0, scroll, 200, VRAM_WINDOW_HEIGHT - scroll);
        BackgroundUnknown__Func_204CBF4(this->listTextPixels, 25, 0, 0, 200, entrySize - (VRAM_WINDOW_HEIGHT - scroll));
    }
    else
    {
        BackgroundUnknown__Func_204CBF4(this->listTextPixels, 25, 0, scroll, 200, entrySize);
    }
}

void NpcTalkList::UpdateListBackgroundMappings(u16 id)
{
    NpcTalkListConfigEntry *entry = &this->entries[id];

    s32 scroll = FX_ModS32(entry->scrollPos, VRAM_WINDOW_HEIGHT);
    this->UpdateListBorderMappings(entry->scrollPos, TILE_TO_PIXEL(2) * entry->lineCount + TILE_TO_PIXEL(1));
    this->UpdateListTextMappings(id, scroll, entry->sequence);

    s32 entrySize;
    entrySize = TILE_TO_PIXEL(2) * entry->lineCount;
    entrySize += TILE_TO_PIXEL(1);
    if (scroll + entrySize > VRAM_WINDOW_HEIGHT)
        this->UpdateListTextMappings(id, (scroll - VRAM_WINDOW_HEIGHT), entry->sequence);
}

NONMATCH_FUNC void NpcTalkList::UpdateListTextMappings(s32 id, s16 scroll, u16 sequence)
{
    // https://decomp.me/scratch/Xbqaa -> 75.03%
#ifdef NON_MATCHING
    s32 paletteRow;
    if ((this->entries[id].flags & NPCTALKLISTENTRY_FLAG_CLEARED) != 0)
    {
        paletteRow = PALETTE_ROW_2 << GX_SCRFMT_TEXT_COLORPLTT_SHIFT;
    }
    else if ((this->entries[id].flags & NPCTALKLISTENTRY_FLAG_UNLOCKED) != 0)
    {
        paletteRow = PALETTE_ROW_0 << GX_SCRFMT_TEXT_COLORPLTT_SHIFT;
    }
    else
    {
        paletteRow = PALETTE_ROW_1 << GX_SCRFMT_TEXT_COLORPLTT_SHIFT;
    }

    s32 count      = 2 * this->entries[id].lineCount + 1;
    s32 scrollTile = scroll / 8;
    s32 y          = -1;
    for (s32 i = 0; i < count; i++)
    {
        s32 tile = scrollTile + i;
        if (tile >= 0)
        {
            if (tile >= VRAM_BACKGROUND_32x32_HEIGHT)
                break;

            u16 *listTextMappings = this->listTextMappings->scr[tile];
            u32 mask              = VRAM_SCRFMT_TEXT(1023, TRUE, TRUE, 0);
            if (i == 0)
            {
                for (s32 j = 0; j < VRAM_BACKGROUND_32x32_WIDTH; j++)
                {
                    *listTextMappings &= mask;
                    *listTextMappings |= PALETTE_ROW_5 << GX_SCRFMT_TEXT_COLORPLTT_SHIFT;
                    listTextMappings++;
                }
                y = 8 * scrollTile;
            }
            else
            {
                for (s32 j = 0; j < VRAM_BACKGROUND_32x32_WIDTH; j++)
                {
                    *listTextMappings &= mask;
                    *listTextMappings |= paletteRow;
                    listTextMappings++;
                }
            }
        }
    }

    if (y >= 0)
    {
        BackgroundBlock *pixelBlock = GetBackgroundPixels(HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_MS_NUMBER_BBG));

        // Copy digits into vram
        s32 digitPos = 1;
        s32 v20      = 0;
        for (s32 i = 0; i < this->numDigitCount; i++)
        {
            u16 v22 = 8 * FX_DivS32(FX_ModS32((s16)(id + 1), 10 * digitPos), digitPos);
            digitPos *= 10;
            s32 pos = (this->numDigitCount - (v20 + 1));
            BackgroundUnknown__CopyPixels(pixelBlock->data, 13, v22, 0, 8, 8, this->listTextPixels, 25, 8 * pos, y, 0);
            v20++;
        }

        // "New!" text
        if ((this->entries[id].flags & NPCTALKLISTENTRY_FLAG_ATTEMPTED) != 0)
            BackgroundUnknown__CopyPixels(pixelBlock->data, 13, 80, 0, 24, 8, this->listTextPixels, 25, 8 * this->numDigitCount, y, 0);
    }

    scroll += 8;
    MessageController__SetCallbackValue(&this->msgController, 0);
    MessageController__AdvanceLine(&this->msgController, scroll);
    MessageController__SetSequence(&this->msgController, sequence);
    MessageController__InitStartPos(&this->msgController, 0, 0);
    while (!MessageController__IsEndOfLine(&this->msgController))
    {
        MessageController__SetPosition(&this->msgController, 8, scroll);
        MessageController__Func_205416C(&this->msgController, 0);
        MessageController__AdvanceLineID(&this->msgController);

        scroll += 16;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	mov r10, r0
	ldr r4, [r10, #0x384]
	mov r9, r2
	str r1, [sp, #0x1c]
	ldrb r0, [r4, r1, lsl #3]
	tst r0, #4
	str r3, [sp, #0x20]
	movne r7, #0x2000
	bne _0216FA78
	tst r0, #1
	movne r7, #0
	moveq r7, #0x1000
_0216FA78:
	ldr r0, [sp, #0x1c]
	mov r3, #0
	add r0, r4, r0, lsl #3
	ldrb r1, [r0, #1]
	mov r0, r9, asr #2
	add r0, r9, r0, lsr #29
	mov r1, r1, lsl #1
	add r5, r1, #1
	mov r2, r0, asr #3
	mvn r0, #0
	cmp r5, #0
	str r0, [sp, #0x24]
	ble _0216FB40
	mov r8, r2, lsl #3
	mov r1, r3
	mov r0, r3
_0216FAB8:
	adds r6, r2, r3
	bmi _0216FB34
	cmp r6, #0x20
	bge _0216FB40
	ldr r4, [r10, #0x380]
	cmp r3, #0
	add r6, r4, r6, lsl #6
	ldr r11, =0x00000FFF
	bne _0216FB0C
	mov r4, r1
_0216FAE0:
	ldrh ip, [r6]
	add r4, r4, #1
	cmp r4, #0x20
	and ip, ip, r11
	strh ip, [r6]
	ldrh ip, [r6]
	orr ip, ip, #0x5000
	strh ip, [r6], #2
	blt _0216FAE0
	str r8, [sp, #0x24]
	b _0216FB34
_0216FB0C:
	mov r4, r0
_0216FB10:
	ldrh ip, [r6]
	add r4, r4, #1
	cmp r4, #0x20
	and ip, ip, r11
	strh ip, [r6]
	ldrh ip, [r6]
	orr ip, ip, r7
	strh ip, [r6], #2
	blt _0216FB10
_0216FB34:
	add r3, r3, #1
	cmp r3, r5
	blt _0216FAB8
_0216FB40:
	ldr r0, [sp, #0x24]
	cmp r0, #0
	blt _0216FC8C
	mov r0, #5
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	bl GetBackgroundPixels
	ldr r1, [sp, #0x1c]
	ldrh r7, [r10, #0x12]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r5, r0
	cmp r7, #0
	mov r11, r1, asr #0x10
	mov r6, #1
	mov r8, #0
	ble _0216FC1C
	ldr r0, [sp, #0x24]
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_0216FB8C:
	mov r1, #0xa
	mul r1, r6, r1
	mov r0, r11
	bl FX_ModS32
	mov r1, r6
	bl FX_DivS32
	mov r0, r0, lsl #0x13
	mov r2, r0, lsr #0x10
	mov r0, #0xa
	mul r0, r6, r0
	mov r6, r0
	add r0, r8, #1
	mov r1, #8
	sub r0, r7, r0
	str r1, [sp]
	mov r0, r0, lsl #0x13
	str r1, [sp, #4]
	ldr r1, [r10, #0x37c]
	mov r0, r0, asr #0x10
	mov r0, r0, lsl #0x10
	str r1, [sp, #8]
	mov r1, r0, lsr #0x10
	mov r0, #0x19
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	add r0, r5, #4
	mov r1, #0xd
	mov r3, #0
	bl BackgroundUnknown__CopyPixels
	ldrh r7, [r10, #0x12]
	add r8, r8, #1
	cmp r8, r7
	blt _0216FB8C
_0216FC1C:
	ldr r1, [r10, #0x384]
	ldr r0, [sp, #0x1c]
	ldrb r0, [r1, r0, lsl #3]
	tst r0, #2
	beq _0216FC8C
	mov r0, #0x18
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	mov r0, r7, lsl #0x13
	ldr r2, [r10, #0x37c]
	mov r0, r0, asr #0x10
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x24]
	str r2, [sp, #8]
	mov r2, #0x19
	mov r0, r0, lsl #0x10
	str r2, [sp, #0xc]
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x10]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x14]
	mov r3, #0
	add r0, r5, #4
	mov r1, #0xd
	mov r2, #0x50
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
_0216FC8C:
	add r0, r9, #8
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	add r0, r10, #0x300
	mov r1, #0
	bl MessageController__SetCallbackValue
	mov r1, r9
	add r0, r10, #0x300
	bl MessageController__AdvanceLine
	ldr r1, [sp, #0x20]
	add r0, r10, #0x300
	bl MessageController__SetSequence
	mov r1, #0
	mov r2, r1
	add r0, r10, #0x300
	bl MessageController__InitStartPos
	add r0, r10, #0x300
	bl MessageController__IsEndOfLine
	cmp r0, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r5, #8
	mov r4, #0
_0216FCE8:
	mov r1, r5
	mov r2, r9
	add r0, r10, #0x300
	bl MessageController__SetPosition
	mov r1, r4
	add r0, r10, #0x300
	bl MessageController__Func_205416C
	add r0, r10, #0x300
	bl MessageController__AdvanceLineID
	add r0, r9, #0x10
	mov r1, r0, lsl #0x10
	add r0, r10, #0x300
	mov r9, r1, asr #0x10
	bl MessageController__IsEndOfLine
	cmp r0, #0
	beq _0216FCE8
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s16 NpcTalkList::GetScrollDistance(s32 id, u32 scrollPos)
{
    // https://decomp.me/scratch/Fcd4t -> 97.50%
#ifdef NON_MATCHING
    if (scrollPos == -1)
        scrollPos = this->scrollPos;

    NpcTalkListConfigEntry *entry = &this->entries[id];

    s32 entrySize;
    entrySize = TILE_TO_PIXEL(2) * entry->lineCount;
    entrySize += TILE_TO_PIXEL(1);

    if (scrollPos <= entry->scrollPos)
    {
        s32 entryScrollPos = entry->scrollPos + entrySize;

        if (scrollPos + NPCTALKLIST_VIEW_SIZE >= entryScrollPos)
            return 0;

        return entryScrollPos - (scrollPos + NPCTALKLIST_VIEW_SIZE);
    }

    return -(scrollPos - entry->scrollPos);
#else
    // clang-format off
	mvn r3, #0
	cmp r2, r3
	ldreq r2, [r0, #0x388]
	ldr r0, [r0, #0x384]
	add r1, r0, r1, lsl #3
	ldrb r0, [r1, #1]
	ldrh r1, [r1, #2]
	mov r0, r0, lsl #4
	cmp r2, r1
	add r0, r0, #8
	bhi _0216FD80
	add r1, r1, r0
	add r0, r2, #0x98
	cmp r0, r1
	movhs r0, #0
	sublo r0, r1, r0
	movlo r0, r0, lsl #0x10
	movlo r0, r0, asr #0x10
	bx lr
_0216FD80:
	sub r0, r2, r1
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bx lr

// clang-format on
#endif
}

u16 NpcTalkList::HandleTouchSelectionControl(BOOL usePush)
{
    u16 x;
    u16 y;
    if (usePush)
    {
        if (!CheckTouchPushEnabled())
            return NPCTALKLIST_SELECTION_NONE;

        x = touchInput.push.x;
        y = touchInput.push.y;
    }
    else
    {
        if (!CheckTouchPullEnabled())
            return NPCTALKLIST_SELECTION_NONE;

        x = touchInput.pull.x;
        y = touchInput.pull.y;
    }

    u32 x2 = x - 16;
    u32 y2 = y - 32;
    if (x2 < 200 && y2 < NPCTALKLIST_VIEW_SIZE)
    {
        u32 scrollOffset;
        s32 firstVisibleEntry;
        s32 lastVisibleEntry;

        firstVisibleEntry = (s16)this->firstVisibleEntry;
        lastVisibleEntry  = (s16)this->lastVisibleEntry;
        scrollOffset      = y2 + this->scrollPos;

        for (; firstVisibleEntry <= lastVisibleEntry; firstVisibleEntry++)
        {
            if (scrollOffset - this->entries[firstVisibleEntry].scrollPos < TILE_TO_PIXEL(2) * this->entries[firstVisibleEntry].lineCount + TILE_TO_PIXEL(1))
            {
                return firstVisibleEntry;
            }
        }
    }

    return NPCTALKLIST_SELECTION_NONE;
}

void NpcTalkList::UpdateListBackgroundGraphics(u32 scrollPos)
{
    u16 firstVisibleEntry;
    u16 lastVisibleEntry;
    this->GetVisibleEntryBounds(scrollPos, &firstVisibleEntry, &lastVisibleEntry);

    BOOL changed = FALSE;

    if (firstVisibleEntry < this->firstVisibleEntry)
    {
        changed = TRUE;

        for (u32 i = firstVisibleEntry; i < this->firstVisibleEntry; i++)
        {
            this->UpdateListBackgroundMappings(i);
            this->UpdateListEntryMappings(i);
        }
    }

    if (lastVisibleEntry > this->lastVisibleEntry)
    {
        if (this->lastVisibleEntry + 1u <= lastVisibleEntry)
        {
            changed = TRUE;

            for (u32 i = this->lastVisibleEntry + 1; i <= lastVisibleEntry; i++)
            {
                this->UpdateListBackgroundMappings(i);
                this->UpdateListEntryMappings(i);
            }
        }
    }

    this->firstVisibleEntry = firstVisibleEntry;
    this->lastVisibleEntry  = lastVisibleEntry;

    if (changed)
    {
        DC_StoreRange(this->listTextPixels, this->listTextPixelSize);
        QueueUncompressedPixels(this->listTextPixels, this->listTextPixelSize, 0, VRAMKEY_TO_ADDR(this->listTextVRAMPixels));
        this->ApplyListEntryMappings(TRUE);
        this->ApplyListTextMappings();
    }

    renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = scrollPos - 32;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = scrollPos - 32;
}

void NpcTalkList::GetVisibleEntryBounds(u32 scrollPos, u16 *firstVisibleEntry, u16 *lastVisibleEntry)
{
    u16 i;

    for (i = 0; i < this->entryCount; i++)
    {
        if (this->entries[i].scrollPos >= scrollPos)
        {
            if (i <= 0)
                *firstVisibleEntry = i;
            else
                *firstVisibleEntry = i - 1;

            break;
        }
    }

    for (; i < this->entryCount; i++)
    {
        if (this->entries[i].scrollPos > scrollPos + NPCTALKLIST_VIEW_SIZE)
        {
            break;
        }
    }

    if (i < this->entryCount)
        *lastVisibleEntry = i;
    else
        *lastVisibleEntry = this->entryCount - 1;
}

void NpcTalkList::ApplyListTextGraphics(BOOL uncompressed)
{
    DC_StoreRange(this->listTextPixels, this->listTextPixelSize);
    if (uncompressed)
        QueueUncompressedPixels(this->listTextPixels, this->listTextPixelSize, PIXEL_MODE_SPRITE, this->listTextVRAMPixels);
    else
        LoadUncompressedPixels(this->listTextPixels, this->listTextPixelSize, PIXEL_MODE_SPRITE, this->listTextVRAMPixels);

    DC_StoreRange(this->listTextMappings, sizeof(GXScrText32x32));
    if (uncompressed)
    {
        Mappings__ReadMappingsCompressed(this->listTextMappings, 0, 0, BG_DISPLAY_FULL_WIDTH, 0, MAPPINGS_MODE_TEXT_256x256_A, 0, 0, 0, 0, BG_DISPLAY_FULL_WIDTH,
                                         BG_DISPLAY_SINGLE_HEIGHT_EX);
    }
    else
    {
        Mappings__LoadUnknown(this->listTextMappings, 0, 0, BG_DISPLAY_FULL_WIDTH, 0, MAPPINGS_MODE_TEXT_256x256_A, 0, 0, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT_EX);
    }

    void *bgMsNumber = HubControl::GetFileFrom_ViBG(ARCHIVE_VI_BG_LZ7_FILE_VI_MS_NUMBER_BBG);

    const GXRgb *lockedPalette;
    const GXRgb *clearedPalette;
    if (this->listConfig.windowFrame == FONTWINDOWMW_FILL_MISSION)
    {
        lockedPalette  = NpcTalkList__MissionTextLockedPalette;
        clearedPalette = NpcTalkList__MissionTextClearedPalette;
    }
    else
    {
        lockedPalette  = NpcTalkList__MovieTextLockedPalette;
        clearedPalette = NpcTalkList__MovieTextClearedPalette;
    }

    if (uncompressed)
    {
        QueueUncompressedPalette((void *)FontAnimator__Palettes[1], ARRAY_COUNT(FontAnimator__Palettes[1]), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[1]));
        QueueUncompressedPalette((void *)lockedPalette, ARRAY_COUNT(NpcTalkList__MissionTextLockedPalette), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[17]));
        QueueUncompressedPalette((void *)clearedPalette, ARRAY_COUNT(NpcTalkList__MissionTextLockedPalette), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[33]));
        QueueCompressedPalette((void *)GetBackgroundPalette(bgMsNumber), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[80]));
    }
    else
    {
        LoadUncompressedPalette((void *)FontAnimator__Palettes[1], ARRAY_COUNT(FontAnimator__Palettes[1]), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[1]));
        LoadUncompressedPalette((void *)lockedPalette, ARRAY_COUNT(NpcTalkList__MissionTextLockedPalette), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[17]));
        LoadUncompressedPalette((void *)clearedPalette, ARRAY_COUNT(NpcTalkList__MissionTextLockedPalette), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[33]));
        LoadCompressedPalette((void *)GetBackgroundPalette(bgMsNumber), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_BG_PLTT)[80]));
    }
}

void NpcTalkList::ApplyListTextMappings()
{
    DC_StoreRange(this->listTextMappings, sizeof(GXScrText32x32));
    Mappings__ReadMappingsCompressed(this->listTextMappings, 0, 0, 32, 0, MAPPINGS_MODE_TEXT_256x256_A, 0, 0, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT_EX);
}

void NpcTalkList::ResetListTextBackground()
{
    MI_CpuFill32((u8 *)VRAM_BG, VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0)),
                 2 * sizeof(GXScrText32x32));
    MI_CpuClearFast((u8 *)VRAM_BG + (0x8000 - sizeof(GXCharFmt16)), sizeof(GXCharFmt16));

    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;
}

void NpcTalkList::DrawHeader()
{
    AnimatorSprite__ProcessAnimationFast(&this->aniHeader);
    AnimatorSprite__DrawFrame(&this->aniHeader);
}

void NpcTalkList::DrawSelectionBox(BOOL enabled)
{
    if (this->currentSelection < this->entryCount)
    {
        NpcTalkListConfigEntry *entry = &this->entries[this->currentSelection];

        s16 posY    = entry->scrollPos - this->scrollPos + 40;
        u16 offsetY = TILE_TO_PIXEL(2) * entry->lineCount;

        if (enabled)
            FontWindowMWControl__SetPaletteAnim(&this->fontWindowMWControl, 0);
        else
            FontWindowMWControl__SetPaletteAnim(&this->fontWindowMWControl, 1);

        FontWindowMWControl__SetPosition(&this->fontWindowMWControl, 16, posY);
        FontWindowMWControl__SetOffset(&this->fontWindowMWControl, 200, offsetY);
        FontWindowMWControl__Draw(&this->fontWindowMWControl);
        FontWindowMWControl__CallWindowFunc2(&this->fontWindowMWControl);
    }
}

void NpcTalkList::SetSelectionBoxSelected(BOOL enabled)
{
    if (enabled)
        FontWindowMWControl__SetPaletteAnim(&this->fontWindowMWControl, 0);
    else
        FontWindowMWControl__SetPaletteAnim(&this->fontWindowMWControl, 1);

    FontWindowMWControl__ValidatePaletteAnim(&this->fontWindowMWControl);
}

void NpcTalkList::DrawCursor(BOOL useChosenSelection)
{
    u16 selection;
    if (useChosenSelection)
        selection = this->chosenSelection;
    else
        selection = this->currentSelection;

    if (selection < this->entryCount)
    {
        NpcTalkListConfigEntry *entry = &this->entries[selection];

        s16 cursorStart = entry->scrollPos - this->scrollPos + 40;
        u16 cursorPos   = TILE_TO_PIXEL(2) * entry->lineCount;

        if (cursorStart < 40)
        {
            cursorStart = 40;
        }
        else if (cursorStart + cursorPos > 184)
        {
            cursorStart = 184 - cursorPos;
        }

        this->aniCursor.pos.x = 16;
        this->aniCursor.pos.y = cursorStart + (cursorPos >> 1);
        AnimatorSprite__ProcessAnimationFast(&this->aniCursor);
        AnimatorSprite__DrawFrame(&this->aniCursor);
    }
}

void NpcTalkList::InitCursor()
{
    AnimatorSprite__SetAnimation(&this->aniCursor, 1);
}

void NpcTalkList::DrawUpDownButtons()
{
    u16 buttonUpAnim;
    if (this->currentSelection > 0)
    {
        if ((this->touchArea[0].responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (this->touchArea[0].responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
            buttonUpAnim = 3;
        else
            buttonUpAnim = 2;
    }
    else
    {
        buttonUpAnim = 4;
    }

    if (this->aniButtonUp.animID != buttonUpAnim)
        AnimatorSprite__SetAnimation(&this->aniButtonUp, buttonUpAnim);

    AnimatorSprite__ProcessAnimationFast(&this->aniButtonUp);
    AnimatorSprite__DrawFrame(&this->aniButtonUp);

    u16 buttonDownAnim;
    if (this->currentSelection < this->entryCount - 1)
    {
        if ((this->touchArea[1].responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (this->touchArea[1].responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
            buttonDownAnim = 6;
        else
            buttonDownAnim = 5;
    }
    else
    {
        buttonDownAnim = 7;
    }

    if (this->aniButtonDown.animID != buttonDownAnim)
        AnimatorSprite__SetAnimation(&this->aniButtonDown, buttonDownAnim);

    AnimatorSprite__ProcessAnimationFast(&this->aniButtonDown);
    AnimatorSprite__DrawFrame(&this->aniButtonDown);
}

void NpcTalkList::DrawBackButton()
{
    NpcTalkListSpriteCallbackUserData userData;
    userData.talkList = this;
    userData.id       = 2;

    u16 anim;
    if ((this->touchArea[2].responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (this->touchArea[2].responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
        anim = 1;
    else
        anim = 0;

    if (this->aniBackButton.animID != anim)
        AnimatorSprite__SetAnimation(&this->aniBackButton, anim);

    AnimatorSprite__ProcessAnimation(&this->aniBackButton, NpcTalkList::SpriteCallback, &userData);
    AnimatorSprite__DrawFrame(&this->aniBackButton);
}

void NpcTalkList::PixelClearCallback(void *context)
{
    UNUSED(context);
    // Do nothing.
}

void NpcTalkList::UpdateListEntryMappings(u16 id)
{
    NpcTalkListConfigEntry *entry = &this->entries[id];

    u16 scrollPos = FX_ModS32(entry->scrollPos, VRAM_WINDOW_HEIGHT) >> 3;
    MI_CpuCopyFast(this->listEntryMapping_Blank, this->listEntryMappings->scr[scrollPos], sizeof(this->listEntryMappings->scr[scrollPos]));

    u16 count = 2 * entry->lineCount;
    scrollPos = (scrollPos + 1) & 0x1F;
    for (s32 i = 0; i < count; i++)
    {
        MI_CpuCopyFast(this->listEntryMapping_EntryBG, this->listEntryMappings->scr[scrollPos], sizeof(this->listEntryMappings->scr[scrollPos]));

        scrollPos = (scrollPos + 1) & 0x1F;
    }
}

void NpcTalkList::ApplyListEntryMappings(BOOL uncompressed)
{
    DC_StoreRange(this->listEntryMappings, sizeof(GXScrText32x32));

    if (uncompressed)
        Mappings__ReadMappingsCompressed(this->listEntryMappings, 0, 0, BG_DISPLAY_FULL_WIDTH, 0, MAPPINGS_MODE_TEXT_256x256_A, 0, 16, 0, 0, BG_DISPLAY_FULL_WIDTH,
                                         BG_DISPLAY_SINGLE_HEIGHT_EX);
    else
        Mappings__LoadUnknown(this->listEntryMappings, 0, 0, BG_DISPLAY_FULL_WIDTH, 0, MAPPINGS_MODE_TEXT_256x256_A, 0, 16, 0, 0, BG_DISPLAY_FULL_WIDTH,
                              BG_DISPLAY_SINGLE_HEIGHT_EX);
}

void NpcTalkList::EnableAllTouchAreas(BOOL enabled)
{
    this->EnableUpButtonTouchArea(enabled);
    this->EnableDownButtonTouchArea(enabled);
    this->EnableBackButtonTouchArea(enabled);
}

void NpcTalkList::EnableUpButtonTouchArea(BOOL enabled)
{
    if (this->touchAreaEnabled[0] != enabled)
    {
        if (enabled)
        {
            TouchField__AddArea(&this->touchField, &this->touchArea[0], TOUCHAREA_PRIORITY_FIRST);
        }
        else
        {
            TouchField__RemoveArea(&this->touchField, &this->touchArea[0]);
            TouchField__ResetArea(&this->touchArea[0]);
        }
        this->touchAreaEnabled[0] = enabled;
    }
}

void NpcTalkList::EnableDownButtonTouchArea(BOOL enabled)
{
    if (this->touchAreaEnabled[1] != enabled)
    {
        if (enabled)
        {
            TouchField__AddArea(&this->touchField, &this->touchArea[1], TOUCHAREA_PRIORITY_FIRST);
        }
        else
        {
            TouchField__RemoveArea(&this->touchField, &this->touchArea[1]);
            TouchField__ResetArea(&this->touchArea[1]);
        }
        this->touchAreaEnabled[1] = enabled;
    }
}

void NpcTalkList::EnableBackButtonTouchArea(BOOL enabled)
{
    if (this->touchAreaEnabled[2] != enabled)
    {
        if (enabled)
        {
            TouchField__AddArea(&this->touchField, &this->touchArea[2], TOUCHAREA_PRIORITY_FIRST);
        }
        else
        {
            TouchField__RemoveArea(&this->touchField, &this->touchArea[2]);
            TouchField__ResetArea(&this->touchArea[2]);
        }
        this->touchAreaEnabled[2] = enabled;
    }
}

BOOL NpcTalkList::CheckUpButtonTouchHeld()
{
    if ((this->touchArea[0].responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (this->touchArea[0].responseFlags & TOUCHAREA_RESPONSE_ENTERED_AREA_3) != 0)
        return TRUE;

    return FALSE;
}

BOOL NpcTalkList::CheckDownButtonTouchHeld()
{
    if ((this->touchArea[1].responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (this->touchArea[1].responseFlags & TOUCHAREA_RESPONSE_ENTERED_AREA_3) != 0)
        return TRUE;

    return FALSE;
}

BOOL NpcTalkList::CheckBackButtonTouchHeld()
{
    if (!this->touchAreaEnabled[2])
        return FALSE;

    if ((this->touchArea[2].responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) != 0)
        return FALSE;

    if ((this->touchArea[2].responseFlags & TOUCHAREA_RESPONSE_40000) != 0)
        return TRUE;

    return FALSE;
}

void NpcTalkList::SpriteCallback(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData)
{
    NpcTalkListSpriteCallbackUserData *work = (NpcTalkListSpriteCallbackUserData *)userData;
    BACFrameGroupBlock_Hitbox *blockHitbox  = (BACFrameGroupBlock_Hitbox *)block;

    if (blockHitbox->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        TouchRectUnknown touchRect;
        touchRect.box.left   = blockHitbox->hitbox.left + animator->pos.x;
        touchRect.box.top    = blockHitbox->hitbox.top + animator->pos.y;
        touchRect.box.right  = blockHitbox->hitbox.right + animator->pos.x;
        touchRect.box.bottom = blockHitbox->hitbox.bottom + animator->pos.y;

        TouchField__SetHitbox(&work->talkList->touchArea[work->id], &touchRect);
    }
}

void NpcTalkList::SetListWindowVisible(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2);
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG2);
}

void NpcTalkList::SetListTextVisible(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | (GX_PLANEMASK_BG1 | GX_PLANEMASK_BG3));
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG3));
}

void NpcTalkList::InitWindow(BOOL enabled)
{
    if (enabled)
    {
        renderCoreGFXControlA.windowManager.registers.win0X2 = -1;
        renderCoreGFXControlA.windowManager.registers.win0X1 = 0;
        renderCoreGFXControlA.windowManager.registers.win0Y2 = -72;
        renderCoreGFXControlA.windowManager.registers.win0Y1 = 32;

        renderCoreGFXControlA.windowManager.registers.win0InPlane.plane_BG0 = TRUE;
        renderCoreGFXControlA.windowManager.registers.win0InPlane.plane_BG1 = TRUE;
        renderCoreGFXControlA.windowManager.registers.win0InPlane.plane_BG2 = TRUE;
        renderCoreGFXControlA.windowManager.registers.win0InPlane.plane_BG3 = TRUE;
        renderCoreGFXControlA.windowManager.registers.win0InPlane.plane_OBJ = TRUE;

        renderCoreGFXControlA.windowManager.registers.winOutPlane.plane_BG0 = TRUE;
        renderCoreGFXControlA.windowManager.registers.winOutPlane.plane_BG1 = FALSE;
        renderCoreGFXControlA.windowManager.registers.winOutPlane.plane_BG2 = TRUE;
        renderCoreGFXControlA.windowManager.registers.winOutPlane.plane_BG3 = FALSE;
        renderCoreGFXControlA.windowManager.registers.winOutPlane.plane_OBJ = TRUE;

        renderCoreGFXControlA.windowManager.visible = TRUE;
    }
    else
    {
        renderCoreGFXControlA.windowManager.visible = FALSE;
    }
}

void NpcTalkList::State_OpenWindow(NpcTalkList *work)
{
    work->SetListWindowVisible(TRUE);

    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);

        work->isWindowAnimating = FALSE;
        work->isWindowOpen      = TRUE;
        work->InitWindow(TRUE);

        AnimatorSprite__SetAnimation(&work->aniHeader, work->listConfig.headerAnim);
        FontWindowMWControl__ValidatePaletteAnim(&work->fontWindowMWControl);

        work->InitCursor();

        AnimatorSprite__SetAnimation(&work->aniButtonUp, 2);
        AnimatorSprite__SetAnimation(&work->aniButtonDown, 5);
        AnimatorSprite__SetAnimation(&work->aniBackButton, 0);

        work->ApplyListTextGraphics(TRUE);
        work->ApplyListEntryMappings(TRUE);
        work->UpdateListBackgroundGraphics(work->scrollPos);
        work->SetListTextVisible(TRUE);

        if (work->currentSelection > 0)
            work->EnableUpButtonTouchArea(TRUE);
        else
            work->EnableUpButtonTouchArea(FALSE);

        if (work->currentSelection < work->entryCount - 1)
            work->EnableDownButtonTouchArea(TRUE);
        else
            work->EnableDownButtonTouchArea(FALSE);

        work->EnableBackButtonTouchArea(TRUE);

        work->state = NpcTalkList::State_ListActive;
    }
}

void NpcTalkList::State_ListActive(NpcTalkList *work)
{
    u16 selection;
    u16 touchSelectionPush;
    BOOL confirmPressed;
    BOOL backPressed;
    u16 touchSelectionPull;
    BOOL touchActive;

    confirmPressed = FALSE;
    backPressed    = FALSE;
    touchActive    = IsTouchInputEnabled() && TOUCH_HAS_ON(touchInput.flags);

    work->unknownFlag = FALSE;
    TouchField__Process(&work->touchField);

    work->DrawHeader();
    work->DrawSelectionBox(TRUE);
    work->DrawCursor(FALSE);
    work->DrawUpDownButtons();
    work->DrawBackButton();

    selection          = work->currentSelection;
    touchSelectionPush = work->HandleTouchSelectionControl(TRUE);
    touchSelectionPull = work->HandleTouchSelectionControl(FALSE);
    if ((padInput.btnPress & PAD_BUTTON_A) != 0)
    {
        confirmPressed = TRUE;
    }
    else if ((padInput.btnPress & PAD_BUTTON_B) != 0 || work->CheckBackButtonTouchHeld())
    {
        backPressed = TRUE;
    }
    else if (!touchActive && (padInput.btnPressRepeat & PAD_KEY_UP) != 0 || work->CheckUpButtonTouchHeld())
    {
        if (selection > 0)
        {
            work->lastHeldTouchSelection = NPCTALKLIST_SELECTION_NONE;
            selection--;
        }
    }
    else if (!touchActive && (padInput.btnPressRepeat & PAD_KEY_DOWN) != 0 || work->CheckDownButtonTouchHeld())
    {
        if (selection < work->entryCount - 1)
        {
            work->lastHeldTouchSelection = NPCTALKLIST_SELECTION_NONE;
            selection++;
        }
    }
    else if (touchSelectionPush < work->entryCount)
    {
        selection                    = touchSelectionPush;
        work->lastHeldTouchSelection = touchSelectionPush;
    }
    else
    {
        if (work->lastHeldTouchSelection != (u16)NPCTALKLIST_SELECTION_NONE)
        {
            if (work->lastHeldTouchSelection == touchSelectionPull && work->lastHeldTouchSelection == selection && work->GetScrollDistance(selection, NPCTALKLIST_SELECTION_NONE) == 0)
                confirmPressed = TRUE;
        }
    }

    if (confirmPressed && (work->entries[selection].flags & NPCTALKLISTENTRY_FLAG_UNLOCKED) == 0)
    {
        confirmPressed    = FALSE;
        work->unknownFlag = FALSE;
    }

    if (confirmPressed)
    {
        work->currentSelection       = selection;
        work->chosenSelection        = selection;
        work->selectedEntry          = work->currentSelection;
        work->lastHeldTouchSelection = NPCTALKLIST_SELECTION_NONE;
        work->EnableAllTouchAreas(FALSE);
        PlayHubSfx(HUB_SFX_V_DECIDE);

        work->timer = 0;
        work->SetSelectionBoxSelected(FALSE);

        work->state = NpcTalkList::State_SelectionMade;
    }
    else
    {
        if (backPressed)
        {
            work->selectedEntry          = NPCTALKLIST_SELECTION_NONE;
            work->lastHeldTouchSelection = NPCTALKLIST_SELECTION_NONE;
            work->SetListTextVisible(FALSE);
            work->InitWindow(FALSE);
            FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 4, 12, 0, 0);
            FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
            work->isWindowAnimating = TRUE;
            work->isWindowOpen      = FALSE;
            work->isWindowClosing   = TRUE;
            work->EnableAllTouchAreas(FALSE);

            PlayHubSfx(HUB_SFX_V_CANCELL);

            work->state = NpcTalkList::State_CloseWindow;
        }
        else if (selection != work->currentSelection)
        {
            work->SetSelectionBoxSelected(TRUE);
            work->InitCursor();
            PlayHubSfx(HUB_SFX_CURSOL);

            s32 scrollPos = work->GetScrollDistance(selection, NPCTALKLIST_SELECTION_NONE);
            if (scrollPos != 0)
            {
                work->chosenSelection = selection;
                work->timer           = 0;
                work->scrollPos = work->prevScrollPos = work->scrollPos + scrollPos;
                work->UpdateListBackgroundGraphics(work->scrollPos);
                work->currentSelection = work->chosenSelection;
                work->state            = NpcTalkList::State_ListActive;
            }
            else
            {
                work->currentSelection = selection;
                work->chosenSelection  = selection;
            }
        }

        if (work->currentSelection > 0)
            work->EnableUpButtonTouchArea(TRUE);
        else
            work->EnableUpButtonTouchArea(FALSE);

        if (work->currentSelection < work->entryCount - 1)
            work->EnableDownButtonTouchArea(TRUE);
        else
            work->EnableDownButtonTouchArea(FALSE);
    }
}

void NpcTalkList::State_SelectionMade(NpcTalkList *work)
{
    work->DrawHeader();
    work->DrawSelectionBox(FALSE);
    work->DrawUpDownButtons();
    work->DrawBackButton();

    work->timer++;
    if (work->timer >= 16)
    {
        work->SetListTextVisible(FALSE);
        work->InitWindow(FALSE);

        FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 4, 12, 0, 0);
        FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);

        work->isWindowAnimating = TRUE;
        work->isWindowOpen      = FALSE;
        work->isWindowClosing   = TRUE;

        work->state = NpcTalkList::State_CloseWindow;
    }
}

void NpcTalkList::State_CloseWindow(NpcTalkList *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimator);

        work->SetListWindowVisible(FALSE);
        work->ResetListTextBackground();

        work->state = NpcTalkList::State_ClosedWindow;
    }
}

void NpcTalkList::State_ClosedWindow(NpcTalkList *work)
{
    FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);

    work->isWindowAnimating = FALSE;
    work->isWindowOpen      = FALSE;
    work->isWindowClosing   = FALSE;

    work->EnableKeyRepeat(FALSE);

    work->state = NpcTalkList::State_Finished;
}

void NpcTalkList::State_Finished(NpcTalkList *work)
{
    // Do nothing.
}

NONMATCH_FUNC void NpcTalkList::EnableKeyRepeat(BOOL enabled)
{
    // should match when 'keyRepeatInitialTime' & 'keyRepeatRepeatTime' are decompiled
#ifdef NON_MATCHING
    u16 keyRepeatInitialTime[] = { 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 };
    u16 keyRepeatRepeatTime[]  = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };

    if (enabled)
        InitPadInput(&padInput, keyRepeatInitialTime, keyRepeatRepeatTime);
    else
        InitPadInput(&padInput, NULL, NULL);
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x30
	ldr lr, =NpcTalkList__keyRepeatInitialTime
	add ip, sp, #0x18
	mov r3, #6
_0217100C:
	ldrh r2, [lr]
	ldrh r1, [lr, #2]
	add lr, lr, #4
	strh r2, [ip]
	strh r1, [ip, #2]
	add ip, ip, #4
	subs r3, r3, #1
	bne _0217100C
	ldr lr, =NpcTalkList__keyRepeatRepeatTime
	add ip, sp, #0
	mov r3, #6
_02171038:
	ldrh r2, [lr]
	ldrh r1, [lr, #2]
	add lr, lr, #4
	strh r2, [ip]
	strh r1, [ip, #2]
	add ip, ip, #4
	subs r3, r3, #1
	bne _02171038
	cmp r0, #0
	beq _02171078
	ldr r0, =padInput
	add r1, sp, #0x18
	add r2, sp, #0
	bl InitPadInput
	add sp, sp, #0x30
	ldmia sp!, {r3, pc}
_02171078:
	mov r1, #0
	ldr r0, =padInput
	mov r2, r1
	bl InitPadInput
	add sp, sp, #0x30
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}