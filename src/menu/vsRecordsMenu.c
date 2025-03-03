#include <menu/vsRecordsMenu.h>
#include <menu/vsMenu.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/file/fileUnknown.h>
#include <game/text/fontAnimator.h>
#include <game/math/unknown2051334.h>
#include <game/util/fontConversion.h>
#include <game/audio/sysSound.h>
#include <game/input/padInput.h>
#include <game/save/saveGame.h>

// resources
#include <resources/narc/dmwf_vsrec_lz7.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void CreateVSRecordsMenu(VSRecordsMenuHandle *config);
static void InitVSRecordsMenuDisplay(VSRecordsMenu *work);
static void InitVSRecordsMenuSprites(VSRecordsMenu *work);
static void InitVSRecordsMenuUnknown(VSRecordsMenu *work);
static void ReleaseVSRecordsMenu(VSRecordsMenu *work);
static void ReleaseVSRecordsMenuDisplay(VSRecordsMenu *work);
static void ReleaseVSRecordsMenuSprites(VSRecordsMenu *work);
static void ReleaseVSRecordsMenuUnknown(VSRecordsMenu *work);
static void VSRecordsMenu_Main_EnterRecords(void);
static void VSRecordsMenu_Main_ExitRecords(void);
static void VSRecordsMenu_Main_DisplayRecords(void);
static void VSRecordsMenu_Destructor(Task *task);
static void SetVSRecordsMenuDigitsEnabled(BOOL enabled);
static void InitVSRecordsMenuDigits(VSRecordsMenu *work, u16 type);
static void EnableVSRecordsMenuTouchArea(BOOL enabled);
static BOOL CheckVSRecordsMenuBackButtonTouchPressed(void);
static void VSRecordsMenu_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData);
static u16 VSRecordsMenu_GetWirelessRaceRecord(SaveVsRecordType type);
static u16 VSRecordsMenu_GetWirelessRingBattleRecord(SaveVsRecordType type);
static u16 VSRecordsMenu_GetNetworkRaceRecord(SaveVsRecordType type);
static u16 VSRecordsMenu_GetNetworkRingBattleRecord(SaveVsRecordType type);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE Unknown2056570 *GetUnknownFromType(VSRecordsMenu *work, u16 type)
{
    return (Unknown2056570 *)work->digitUnknown + type;
}

// --------------------
// FUNCTIONS
// --------------------

void InitVSRecordsMenuHandle(VSRecordsMenuHandle *work)
{
    MI_CpuClear32(work, sizeof(*work));

    work->vsRecordsMenu = NULL;
    work->archive       = ArchiveFileUnknown__LoadFile("narc/dmwf_vsrec_lz7.narc", FILEUNKNOWN_AUTO_ALLOC_HEAD);
}

void ReleaseVSRecordsMenuHandle(VSRecordsMenuHandle *work)
{
    if (work->archive != NULL)
    {
        HeapFree(HEAP_USER, work->archive);
        work->archive = NULL;
    }
}

void CreateVSRecordsMenuFromHandle(VSRecordsMenuHandle *work)
{
    return CreateVSRecordsMenu(work);
}

BOOL CheckVSRecordsMenuHandleTaskActive(VSRecordsMenuHandle *work)
{
    return work->vsRecordsMenu == NULL;
}

void CreateVSRecordsMenu(VSRecordsMenuHandle *config)
{
    config->vsRecordsMenu =
        TaskCreate(VSRecordsMenu_Main_EnterRecords, VSRecordsMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10, TASK_GROUP(0), VSRecordsMenu);
    VSMenu__SetNetworkMessageSequence(0xFFFF);

    VSRecordsMenu *work = TaskGetWork(config->vsRecordsMenu, VSRecordsMenu);
    TaskInitWork32(work);

    work->assets     = config;
    work->timer      = 0;
    work->fontWindow = VSMenu__GetFontWindow();

    EnableVSRecordsMenuTouchArea(FALSE);

    InitVSRecordsMenuDisplay(work);
    InitVSRecordsMenuSprites(work);
    InitVSRecordsMenuUnknown(work);
}

void InitVSRecordsMenuDisplay(VSRecordsMenu *work)
{
    SetVSRecordsMenuDigitsEnabled(FALSE);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x04000);

    MI_CpuClearFast(((u8 *)VRAM_BG) + 0x4000, 0x20);  // clear vram char region
    MI_CpuClearFast(((u8 *)VRAM_BG) + 0x2000, 0x600); // clear vram scr region

    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
}

void InitVSRecordsMenuSprites(VSRecordsMenu *work)
{
    void *sprRecordsFrame = FileUnknown__GetAOUFile(work->assets->archive, ARCHIVE_DMWF_VSREC_LZ7_FILE_DMWF_VSREC_JPN_BAC + GetGameLanguage());

    AnimatorSprite__Init(&work->aniWirelessStats, sprRecordsFrame, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize3FromAnim(sprRecordsFrame, 0)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_3,
                         SPRITE_ORDER_0);
    work->aniWirelessStats.pos.x          = 16;
    work->aniWirelessStats.pos.y          = 48;
    work->aniWirelessStats.cParam.palette = PALETTE_ROW_0;

    AnimatorSprite__Init(&work->aniNetworkStats, sprRecordsFrame, 1, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize3FromAnim(sprRecordsFrame, 1)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_3,
                         SPRITE_ORDER_0);
    work->aniNetworkStats.pos.x          = 16;
    work->aniNetworkStats.pos.y          = 104;
    work->aniNetworkStats.cParam.palette = PALETTE_ROW_0;

    AnimatorSprite__ProcessAnimationFast(&work->aniWirelessStats);
    AnimatorSprite__ProcessAnimationFast(&work->aniNetworkStats);
}

void InitVSRecordsMenuUnknown(VSRecordsMenu *work)
{
    work->digitPixels = HeapAllocHead(HEAP_USER, 2 * 12 * (4 * 0x20));
    MI_CpuClearFast(work->digitPixels, 2 * 12 * (4 * 0x20));

    s32 n, t, r;

    s32 startX;
    s32 currentY;
    s32 startY;
    GXScrFmtText *digitPixels;
    s32 vramTile;

    digitPixels = work->digitPixels;

    currentY = PIXEL_TO_TILE(72);
    n        = 0;
    vramTile = 1 * 0x20;
    for (; n < 2; n++)
    {
        startX = PIXEL_TO_TILE(120);
        startY = currentY;
        for (t = 0; t < 2; t++)
        {
            for (r = 0; r < SAVE_VSRECORD_COUNT; r++)
            {
                Unknown2056570__Init(&work->digitUnknown[n][t][r], GRAPHICS_ENGINE_A, BACKGROUND_2, 0, startX, startY, PIXEL_TO_TILE(32), PIXEL_TO_TILE(16), digitPixels, 0,
                                     vramTile);
                Unknown2056570__Func_2056688(&work->digitUnknown[n][t][r], 0);

                digitPixels += 4 * 0x20;
                vramTile += 8 * 0x20;
                startX += PIXEL_TO_TILE(40);
            }

            startX = PIXEL_TO_TILE(120);
            startY += PIXEL_TO_TILE(16);
        }
        currentY += PIXEL_TO_TILE(56);
    }

    MI_CpuCopy16(FontAnimator__Palettes[1], &((GXRgb *)VRAM_BG_PLTT)[1], sizeof(FontAnimator__Palettes[1]));
}

void ReleaseVSRecordsMenu(VSRecordsMenu *work)
{
    ReleaseVSRecordsMenuUnknown(work);
    ReleaseVSRecordsMenuSprites(work);
    ReleaseVSRecordsMenuDisplay(work);

    work->assets->vsRecordsMenu = NULL;
}

void ReleaseVSRecordsMenuDisplay(VSRecordsMenu *work)
{
    SetVSRecordsMenuDigitsEnabled(FALSE);
    MI_CpuClearFast(((u8 *)VRAM_BG) + 0x2000, 0x600); // clear vram scr region
}

void ReleaseVSRecordsMenuSprites(VSRecordsMenu *work)
{
    AnimatorSprite__Release(&work->aniWirelessStats);
    AnimatorSprite__Release(&work->aniNetworkStats);

    MI_CpuClear32(&work->aniRecords, sizeof(work->aniRecords));
}

void ReleaseVSRecordsMenuUnknown(VSRecordsMenu *work)
{
    for (s32 n = 0; n < 2; n++)
    {
        for (s32 t = 0; t < 2; t++)
        {
            for (s32 r = 0; r < SAVE_VSRECORD_COUNT; r++)
            {
                Unknown2056570__Func_2056670(&work->digitUnknown[n][t][r]);
            }
        }
    }

    if (work->digitPixels != NULL)
    {
        HeapFree(HEAP_USER, work->digitPixels);
        work->digitPixels = NULL;
    }
}

void VSRecordsMenu_Main_EnterRecords(void)
{
    VSRecordsMenu *work = TaskGetWorkCurrent(VSRecordsMenu);

    AnimatorSprite__ProcessAnimationFast(&work->aniWirelessStats);
    AnimatorSprite__ProcessAnimationFast(&work->aniNetworkStats);

    if (work->timer < 24)
    {
        s32 offset                   = Unknown2051334__Func_2051534(128, 0, 24, work->timer, FLOAT_TO_FX32(2.0));
        work->aniWirelessStats.pos.x = 16;
        work->aniWirelessStats.pos.y = 48 - offset;
        work->aniNetworkStats.pos.x  = 16;
        work->aniNetworkStats.pos.y  = 104 + offset;

        AnimatorSprite__DrawFrame(&work->aniWirelessStats);
        AnimatorSprite__DrawFrame(&work->aniNetworkStats);
    }
    else
    {
        work->aniWirelessStats.pos.x = 16;
        work->aniWirelessStats.pos.y = 48;
        work->aniNetworkStats.pos.x  = 16;
        work->aniNetworkStats.pos.y  = 104;

        AnimatorSprite__DrawFrame(&work->aniWirelessStats);
        AnimatorSprite__DrawFrame(&work->aniNetworkStats);
    }

    if (work->timer < 12)
        InitVSRecordsMenuDigits(work, work->timer);

    if (work->timer < 24)
    {
        work->timer++;
    }
    else
    {
        SetVSRecordsMenuDigitsEnabled(TRUE);
        EnableVSRecordsMenuTouchArea(TRUE);
        work->timer = 0;
        SetCurrentTaskMainEvent(VSRecordsMenu_Main_DisplayRecords);
    }
}

void VSRecordsMenu_Main_ExitRecords(void)
{
    VSRecordsMenu *work = TaskGetWorkCurrent(VSRecordsMenu);

    AnimatorSprite__ProcessAnimationFast(&work->aniWirelessStats);
    AnimatorSprite__ProcessAnimationFast(&work->aniNetworkStats);

    if (work->timer < 24)
    {
        s32 offset                   = Unknown2051334__Func_2051534(0, 128, 24, work->timer, FLOAT_TO_FX32(0.0));
        work->aniWirelessStats.pos.x = 16;
        work->aniWirelessStats.pos.y = 48 - offset;
        work->aniNetworkStats.pos.x  = 16;
        work->aniNetworkStats.pos.y  = 104 + offset;
        AnimatorSprite__DrawFrame(&work->aniWirelessStats);
        AnimatorSprite__DrawFrame(&work->aniNetworkStats);
    }

    if (work->timer < 24)
        work->timer++;
    else
        DestroyCurrentTask();
}

void VSRecordsMenu_Main_DisplayRecords(void)
{
    VSRecordsMenu *work = TaskGetWorkCurrent(VSRecordsMenu);

    work->aniWirelessStats.pos.x = 16;
    work->aniWirelessStats.pos.y = 48;
    work->aniNetworkStats.pos.x  = 16;
    work->aniNetworkStats.pos.y  = 104;

    AnimatorSprite__ProcessAnimationFast(&work->aniWirelessStats);
    AnimatorSprite__ProcessAnimationFast(&work->aniNetworkStats);

    AnimatorSprite__DrawFrame(&work->aniWirelessStats);
    AnimatorSprite__DrawFrame(&work->aniNetworkStats);

    if ((padInput.btnPress & PAD_BUTTON_B) != 0 || CheckVSRecordsMenuBackButtonTouchPressed())
    {
        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CANCEL);
        SetVSRecordsMenuDigitsEnabled(FALSE);
        EnableVSRecordsMenuTouchArea(FALSE);
        VSMenu__Func_21667F0(0xFFFF);
        work->timer = 0;
        SetCurrentTaskMainEvent(VSRecordsMenu_Main_ExitRecords);
    }
}

void VSRecordsMenu_Destructor(Task *task)
{
    VSRecordsMenu *work = TaskGetWork(task, VSRecordsMenu);

    ReleaseVSRecordsMenu(work);
}

void SetVSRecordsMenuDigitsEnabled(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2);
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG2);
}

NONMATCH_FUNC void InitVSRecordsMenuDigits(VSRecordsMenu *work, u16 type)
{
    // https://decomp.me/scratch/dDh7D -> 91.28%
#ifdef NON_MATCHING
    if (type < 12)
    {
        Unknown2056570 *unknown = GetUnknownFromType(work, type);

        s32 record;

        if (type < 6)
        {
            if (type < 3)
            {
                record = VSRecordsMenu_GetWirelessRaceRecord(type);
            }
            else
            {
                record = VSRecordsMenu_GetWirelessRingBattleRecord(type - 3);
            }
        }
        else
        {
            if (type < 9)
            {
                record = VSRecordsMenu_GetNetworkRaceRecord(type - 6);
            }
            else
            {
                record = VSRecordsMenu_GetNetworkRingBattleRecord(type - 9);
            }
        }

        if (record > 9999)
            record = 9999;

        FontFile *font = FontWindow__GetFont(work->fontWindow);

        s32 digit0 = record;
        s32 digit1 = record % 1000;
        s32 digit2 = record % 1000 % 100;
        s32 digit3 = record % 1000 % 100 % 10;

        // digit0 /= 1000;
        // digit1 /= 100;
        // digit2 /= 10;

        s32 digits[4];
        digits[0] = digit0;
        digits[1] = digit1;
        digits[2] = digit2;
        digits[3] = digit3;

        s32 character = GetFontCharacterFromUTF('0');
        s32 startY    = 0;
        for (s32 i = 0; i < 4; i++)
        {
            FontFile__Func_2052DD0(font, character + digits[i], 0, unknown, startY, 0, 0, 0, 0);
            startY += 8;
        }
        Unknown2056570__Func_2056B8C(unknown);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	cmp r1, #0xc
	mov r7, r0
	addhs sp, sp, #0x24
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x30
	mul r5, r1, r0
	cmp r1, #6
	add r6, r7, #0xd4
	bhs _021739E8
	cmp r1, #3
	bhs _021739D8
	mov r0, r1
	bl VSRecordsMenu_GetWirelessRaceRecord
	mov r4, r0
	b _02173A0C
_021739D8:
	sub r0, r1, #3
	bl VSRecordsMenu_GetWirelessRingBattleRecord
	mov r4, r0
	b _02173A0C
_021739E8:
	cmp r1, #9
	bhs _02173A00
	sub r0, r1, #6
	bl VSRecordsMenu_GetNetworkRaceRecord
	mov r4, r0
	b _02173A0C
_02173A00:
	sub r0, r1, #9
	bl VSRecordsMenu_GetNetworkRingBattleRecord
	mov r4, r0
_02173A0C:
	ldr r0, =0x0000270F
	cmp r4, r0
	movgt r4, r0
	ldr r0, [r7, #0xd0]
	bl FontWindow__GetFont
	ldr r7, =0x10624DD3
	mov r1, r4, lsr #0x1f
	smull r3, r2, r7, r4
	add r2, r1, r2, asr #6
	mov r1, #0x3e8
	mul r1, r2, r1
	sub r8, r4, r1
	ldr r7, =0x51EB851F
	mov r3, r8, lsr #0x1f
	smull r4, r1, r7, r8
	add r1, r3, r1, asr #5
	mov r3, #0x64
	mul r3, r1, r3
	sub r9, r8, r3
	ldr r4, =0x66666667
	mov r7, r0
	mov r0, r9, lsr #0x1f
	smull r3, r8, r4, r9
	add r8, r0, r8, asr #2
	mov r0, #0xa
	mul r0, r8, r0
	sub r3, r9, r0
	mov r0, #0x30
	str r2, [sp, #0x14]
	str r1, [sp, #0x18]
	str r8, [sp, #0x1c]
	str r3, [sp, #0x20]
	bl GetFontCharacterFromUTF
	mov r9, #0
	mov r8, r0
	mov r10, r9
	mov r4, r9
	add r11, sp, #0x14
_02173AA4:
	mov r0, r10, lsl #0x10
	mov r1, r0, asr #0x10
	ldr r0, [r11, r9, lsl #2]
	stmia sp, {r1, r4}
	add r0, r8, r0
	mov r1, r0, lsl #0x10
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	mov r0, r7
	mov r2, r4
	mov r1, r1, lsr #0x10
	add r3, r6, r5
	str r4, [sp, #0x10]
	bl FontFile__Func_2052DD0
	add r9, r9, #1
	cmp r9, #4
	add r10, r10, #8
	blt _02173AA4
	add r0, r6, r5
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void EnableVSRecordsMenuTouchArea(BOOL enabled)
{
    if (enabled)
        VSMenu__SetTouchCallback(VSRecordsMenu_TouchAreaCallback, NULL);
    else
        VSMenu__SetTouchCallback(NULL, NULL);
}

BOOL CheckVSRecordsMenuBackButtonTouchPressed(void)
{
    return (VSMenu__GetUnknownTouchResponseFlags() & TOUCHAREA_RESPONSE_40000) != 0;
}

void VSRecordsMenu_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData)
{
    // Nothing do be done.
}

u16 VSRecordsMenu_GetWirelessRaceRecord(SaveVsRecordType type)
{
    return SaveGame__GetWirelessRaceRecord(type);
}

u16 VSRecordsMenu_GetWirelessRingBattleRecord(SaveVsRecordType type)
{
    return SaveGame__GetWirelessRingBattleRecord(type);
}

u16 VSRecordsMenu_GetNetworkRaceRecord(SaveVsRecordType type)
{
    return SaveGame__GetNetworkRaceRecord(type);
}

u16 VSRecordsMenu_GetNetworkRingBattleRecord(SaveVsRecordType type)
{
    return SaveGame__GetNetworkRingBattleRecord(type);
}