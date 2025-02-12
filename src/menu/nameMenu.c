#include <menu/nameMenu.h>
#include <game/game/gameState.h>
#include <game/save/saveManager.h>
#include <game/audio/sysSound.h>
#include <game/graphics/renderCore.h>
#include <game/file/fsRequest.h>
#include <game/file/fileUnknown.h>
#include <game/file/bundleFileUnknown.h>
#include <game/system/sysEvent.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/util/fontConversion.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/graphics/unknown2056570.h>

// resources
#include <resources/narc/dmni_lz7.h>

#include <nitro/code16.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void BackgroundUnknown__CopyPixels(void *pixels, s32 unitWidth, s32 pivotX, s32 pivotY, u16 xAdvance, u16 lineSize, void *pixels2, u16 pixelWidth, u16 x, u16 y,
                                                  s16 a11);
NOT_DECOMPILED void Unknown2051334__Func_20516B8(void);
NOT_DECOMPILED void Unknown2051334__Func_2051534(void);

typedef char16 (*NameMenuGetCharacterFunc)(s32 x, s32 y);
typedef void (*DrawPageVariantFunc)(NameMenuWorker *work);
typedef void (*ChangePageVariantFunc)(NameMenuWorker *work, BOOL a2);

// --------------------
// VARIABLES
// --------------------

NameMenuWorker *NameMenu__sVars;

NOT_DECOMPILED u16 _021619E4[];
NOT_DECOMPILED u16 _021619F8[];
NOT_DECOMPILED DrawPageVariantFunc NameMenu__DrawPageVariantTable[];
NOT_DECOMPILED s32 _02161A28[];
NOT_DECOMPILED ChangePageVariantFunc NameMenu__ChangePageVariantTable[];
NOT_DECOMPILED NameMenuGetCharacterFunc NameMenu__GetCharacterTable[];
NOT_DECOMPILED u16 _02161A7C[];
NOT_DECOMPILED u16 _02161A84[];
NOT_DECOMPILED u16 _02161A9E[];
NOT_DECOMPILED u16 _02161A94[];
NOT_DECOMPILED u16 _02161AAA[];
NOT_DECOMPILED u16 NameMenu__fontCharOffset[];
NOT_DECOMPILED u16 NameMenu__CharacterTable_JPN_Hiragana[6][12];
NOT_DECOMPILED u16 NameMenu__CharacterTable_JPN_Katakana[6][12];
NOT_DECOMPILED u16 NameMenu__CharacterTable_ENG_Lower[6][12];
NOT_DECOMPILED u16 NameMenu__CharacterTable_ENG_Upper[6][12];
NOT_DECOMPILED u16 NameMenu__CharacterTable_Latin[6][12];
NOT_DECOMPILED u16 NameMenu__CharacterTable_Symbols[6][12];
NOT_DECOMPILED u16 NameMenu__CharacterTable_Icons[6][12];
NOT_DECOMPILED u16 _02161E64[];
NOT_DECOMPILED s32 NameMenu__utfCharOffset[];
NOT_DECOMPILED s32 NameMenu__fontCharPageSize[];
NOT_DECOMPILED u16 _02162034[];
NOT_DECOMPILED u16 _0216219C[];
NOT_DECOMPILED u16 _02162344[];
NOT_DECOMPILED u16 _02162654[];

// --------------------
// FUNCTIONS
// --------------------

void NameMenu__LoadAssets(void)
{
    static const char *archiveList[1] = { "narc/dmni_lz7.narc" };

    NameMenu__sVars = HeapAllocHead(HEAP_SYSTEM, sizeof(NameMenuWorker));
    MI_CpuClear32(NameMenu__sVars, sizeof(NameMenuWorker));

    NameMenu__sVars->isActive = FALSE;
    InitThreadWorker(&NameMenu__sVars->thread, 0);

    NameMenu__sVars->archiveDmni = BundleFileUnknown__LoadFile(archiveList[0], BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);
}

void NameMenu__Create(u32 flags, SavePlayerName *name, FontWindow *fontWindow)
{
    NameMenu__sVars->isActive       = TRUE;
    NameMenu__sVars->flags          = flags;
    NameMenu__sVars->fontWindowPtr  = fontWindow;
    NameMenu__sVars->applyName      = 0;
    NameMenu__sVars->field_14       = 0;
    NameMenu__sVars->menuSelection  = 4;
    NameMenu__sVars->field_34       = 0;
    NameMenu__sVars->selectionTimer = 0;
    MI_CpuClear32(NameMenu__sVars->field_D1C, sizeof(NameMenu__sVars->field_D1C));
    MI_CpuClear32(NameMenu__sVars->field_3C, sizeof(NameMenu__sVars->field_3C));
    NameMenu__sVars->textPageID = 8;

    if (name != NULL)
        MI_CpuCopy16(name, &NameMenu__sVars->name, sizeof(NameMenu__sVars->name));
    else
        MI_CpuFill16(&NameMenu__sVars->name, ' ', sizeof(NameMenu__sVars->name));

    NameMenu__SetupDisplay(NameMenu__sVars);
    NameMenu__InitFontWindow(NameMenu__sVars);

    NameMenu__sVars->task = TaskCreateNoWork(NameMenu__Main_Loading, NameMenu__Destructor, TASK_FLAG_NONE, 0, 0, TASK_GROUP(0), "NameMenu");

    CreateThreadWorker(&NameMenu__sVars->thread, NameMenu__ThreadFunc, NameMenu__sVars, 24);
}

BOOL NameMenu__IsFinished(void)
{
    return !NameMenu__sVars->isActive;
}

BOOL NameMenu__ShouldApplyName(void)
{
    return NameMenu__sVars->applyName;
}

SavePlayerName *NameMenu__GetName(void)
{
    return &NameMenu__sVars->name;
}

void NameMenu__ReleaseAssets(void)
{
    if (NameMenu__sVars->archiveDmni != NULL)
    {
        HeapFree(HEAP_USER, NameMenu__sVars->archiveDmni);
        NameMenu__sVars->archiveDmni = NULL;
    }

    ReleaseThreadWorker(&NameMenu__sVars->thread);
    HeapFree(HEAP_SYSTEM, NameMenu__sVars);

    NameMenu__sVars = NULL;
}

void NameMenu__Init(NameMenuWorker *work)
{
    MI_CpuClearFast(VRAM_DB_BG, 0x10000);

    for (s32 i = 0; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        if (work->name.text[i] == '\0')
        {
            MI_CpuClear16(&work->name.text[i], sizeof(char16) * (SAVEGAME_MAX_NAME_LEN - i));
            break;
        }

        work->name.text[i] = GetFontCharacterFromUTF(work->name.text[i]);

        if (work->name.text[i] == 0xB6) // TODO: figure out what character this is
            work->name.text[i] = '\0';
    }

    work->nameLength = NameMenu__GetNameLength(&work->name, SAVEGAME_MAX_NAME_LEN);
    work->cursorX    = 1;
    work->cursorY    = 0;
    NameMenu__InitAnimators(work);
    NameMenu__InitBackgrounds(work);
    NameMenu__InitUnknown2056570(work);
    NameMenu__InitTouchField(work);
    NameMenu__InitName(work);
}

void NameMenu__SetupDisplay(NameMenuWorker *work)
{
    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;

    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x3000, GX_BG_CHARBASE_0x0c000);

    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x08000);
    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x3000, GX_BG_CHARBASE_0x0c000);

    MI_CpuClear16(&renderCoreGFXControlA.bgPosition, sizeof(renderCoreGFXControlA.bgPosition));
    MI_CpuClear16(&renderCoreGFXControlB.bgPosition, sizeof(renderCoreGFXControlA.bgPosition));

    G2_SetBG0Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(3);
    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_BG3);

    G2S_SetBG0Priority(0);
    G2S_SetBG1Priority(1);
    G2S_SetBG2Priority(2);
    G2S_SetBG3Priority(3);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);

    NameMenu__SetupBlending(work, 0x10);
}

NONMATCH_FUNC void NameMenu__InitAnimators(NameMenuWorker *work)
{
    // https://decomp.me/scratch/RQ2N4 -> 96.11%
#ifdef NON_MATCHING
    void *sprCommon = FileUnknown__GetAOUFile(work->archiveDmni, ARCHIVE_DMNI_LZ7_FILE_DMNI_CMN_BAC);
    void *sprLang   = FileUnknown__GetAOUFile(work->archiveDmni, GetGameLanguage() + ARCHIVE_DMNI_LZ7_FILE_DMNI_JPN_BAC);

    GetSpriteSizeFromAnimFunc getSpriteSize;
    switch (GXS_GetOBJVRamModeChar())
    {
        case GX_OBJVRAMMODE_CHAR_1D_32K:
            getSpriteSize = Sprite__GetSpriteSize1FromAnim;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            getSpriteSize = Sprite__GetSpriteSize2FromAnim;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            getSpriteSize = Sprite__GetSpriteSize3FromAnim;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_256K:
            getSpriteSize = Sprite__GetSpriteSize4FromAnim;
            break;
    }

    s32 i                    = 0;
    AnimatorSprite *animator = &work->aniSprites[0];
    u16 *paletteRow          = TEMP._02161A7C;
    u32 animID               = 0;
    for (; i < 4; i++)
    {
        NameMenu__InitAnimator(animator++, sprCommon, TRUE, FALSE, FALSE, getSpriteSize, animID, (*paletteRow), SPRITE_PRIORITY_0, SPRITE_ORDER_8);
        paletteRow++;
        animID += 2;
    }

    i          = 0;
    animator   = &work->aniSprites[4];
    paletteRow = TEMP._02161A84;
    animID     = 8;
    for (; i < 3; i++)
    {
        NameMenu__InitAnimator(&work->aniSprites[i + 4], sprCommon, TRUE, FALSE, FALSE, getSpriteSize, animID, TEMP._02161A84[i], SPRITE_PRIORITY_0, SPRITE_ORDER_8);

        animID += 3;
    }

    i      = 0;
    animID = 17;
    for (; i < 5; i++)
    {
        NameMenu__InitAnimator(&work->aniSprites[i + 7], sprCommon, TRUE, FALSE, TRUE, getSpriteSize, animID, TEMP._02161A8A[i], SPRITE_PRIORITY_0, SPRITE_ORDER_8);
        animID += 2;
    }

    for (i = 0; i < 5; i++)
    {
        NameMenu__InitAnimator(&work->aniSprites[i + 12], sprCommon, TRUE, FALSE, FALSE, getSpriteSize, 27, TEMP._02161A94[i], SPRITE_PRIORITY_0, SPRITE_ORDER_4);
    }

    for (i = 0; i < 2; i++)
    {
        NameMenu__InitAnimator(&work->aniSprites[i + 17], sprCommon, TRUE, FALSE, FALSE, getSpriteSize, i + 28, TEMP._02161A9E[i], SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    }

    NameMenu__InitAnimator(&work->aniSprites[19], sprCommon, TRUE, TRUE, FALSE, getSpriteSize, 30, PALETTE_ROW_2, SPRITE_PRIORITY_3, SPRITE_ORDER_0);
    NameMenu__InitAnimator(&work->aniSprites[20], sprCommon, TRUE, TRUE, FALSE, getSpriteSize, 31, PALETTE_ROW_2, SPRITE_PRIORITY_0, SPRITE_ORDER_4);
    NameMenu__InitAnimator(&work->aniSprites[21], sprCommon, TRUE, FALSE, FALSE, getSpriteSize, 32, PALETTE_ROW_2, SPRITE_PRIORITY_3, SPRITE_ORDER_0);
    NameMenu__InitAnimator(&work->aniSprites[22], sprCommon, TRUE, FALSE, FALSE, getSpriteSize, 33, PALETTE_ROW_3, SPRITE_PRIORITY_3, SPRITE_ORDER_4);

    i      = 0;
    animID = 0;
    for (; i < 3; i++)
    {
        NameMenu__InitAnimator(&work->aniSprites[i + 23], sprLang, TRUE, FALSE, FALSE, getSpriteSize, animID, TEMP._02161AAA[i], SPRITE_PRIORITY_0, SPRITE_ORDER_2);
        animID += 3;
    }

    NameMenu__InitAnimator(&work->aniSprites[26], sprCommon, TRUE, TRUE, FALSE, getSpriteSize, 56, PALETTE_ROW_2, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	mov r1, #0xdf
	lsl r1, r1, #4
	str r0, [sp, #0x18]
	ldr r0, [r0, r1]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x30]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0215F0CE
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215F0BA: // jump table
    DCD 0xA000A
    DCD 0xA000A
    DCD 0xA000A
	// .hword _0215F0C6 - _0215F0BA - 2 // case 0
	// .hword _0215F0C6 - _0215F0BA - 2 // case 1
	// .hword _0215F0C6 - _0215F0BA - 2 // case 2
	// .hword _0215F0C6 - _0215F0BA - 2 // case 3
	// .hword _0215F0C6 - _0215F0BA - 2 // case 4
	// .hword _0215F0C6 - _0215F0BA - 2 // case 5
_0215F0C6:
	bl RenderCore_GetLanguagePtr
	ldrb r2, [r0, #0]
	b _0215F0D0
_0215F0CE:
	mov r2, #1
_0215F0D0:
	mov r1, #0xdf
	ldr r0, [sp, #0x18]
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	add r1, r2, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x2c]
	ldr r0, =0x04001000
	ldr r1, =0x00300010
	ldr r0, [r0, #0]
	mov r2, r0
	ldr r0, =0x00100010
	and r2, r1
	cmp r2, r0
	bgt _0215F0FC
	bge _0215F110
	cmp r2, #0x10
	beq _0215F10C
	b _0215F11A
_0215F0FC:
	ldr r0, =0x00200010
	cmp r2, r0
	bgt _0215F106
	beq _0215F114
	b _0215F11A
_0215F106:
	cmp r2, r1
	beq _0215F118
	b _0215F11A
_0215F10C:
	ldr r7, =Sprite__GetSpriteSize1FromAnim
	b _0215F11A
_0215F110:
	ldr r7, =Sprite__GetSpriteSize2FromAnim
	b _0215F11A
_0215F114:
	ldr r7, =Sprite__GetSpriteSize3FromAnim
	b _0215F11A
_0215F118:
	ldr r7, =Sprite__GetSpriteSize4FromAnim
_0215F11A:
	mov r0, #0
	str r0, [sp, #0x28]
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	ldr r4, =_02161A7C
	ldr r5, [sp, #0x28]
	add r6, r0, r1
_0215F12A:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r4, #0]
	ldr r1, [sp, #0x30]
	mov r2, #1
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, r6
	mov r3, #0
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x28]
	add r6, #0x64
	add r0, r0, #1
	add r4, r4, #2
	add r5, r5, #2
	str r0, [sp, #0x28]
	cmp r0, #4
	blt _0215F12A
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r4, #0
	add r0, r0, r1
	ldr r6, =_02161A7C
	str r4, [sp, #0x1c]
	mov r5, #8
	str r0, [sp, #0x34]
_0215F170:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #8]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, #0x19
	lsl r0, r0, #4
	add r1, r4, r0
	ldr r0, [sp, #0x34]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x1c]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #3
	str r0, [sp, #0x1c]
	cmp r0, #3
	blt _0215F170
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r4, #0
	add r0, r0, r1
	ldr r6, =_02161A7C
	str r4, [sp, #0x20]
	mov r5, #0x11
	str r0, [sp, #0x38]
_0215F1BE:
	mov r0, #1
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #0xe]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, #0xaf
	lsl r0, r0, #2
	add r1, r4, r0
	ldr r0, [sp, #0x38]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x20]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #2
	str r0, [sp, #0x20]
	cmp r0, #5
	blt _0215F1BE
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r6, #0
	add r0, r0, r1
	ldr r5, =_02161A7C
	mov r4, r6
	str r0, [sp, #0x3c]
_0215F20A:
	mov r0, #0
	str r0, [sp]
	str r7, [sp, #4]
	mov r0, #0x1b
	str r0, [sp, #8]
	ldrh r0, [r5, #0x18]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	mov r0, #0x4b
	lsl r0, r0, #4
	add r1, r4, r0
	ldr r0, [sp, #0x3c]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	add r6, r6, #1
	add r4, #0x64
	add r5, r5, #2
	cmp r6, #5
	blt _0215F20A
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	mov r6, #0
	add r0, r0, r1
	ldr r5, =_02161A7C
	mov r4, r6
	str r0, [sp, #0x40]
_0215F24E:
	mov r0, #0
	str r0, [sp]
	mov r0, r6
	add r0, #0x1c
	lsl r0, r0, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r5, #0x22]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #0xc
	str r0, [sp, #0x14]
	ldr r0, =0x000006A4
	add r1, r4, r0
	ldr r0, [sp, #0x40]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	add r6, r6, #1
	add r4, #0x64
	add r5, r5, #2
	cmp r6, #2
	blt _0215F24E
	mov r2, #0
	str r2, [sp]
	str r7, [sp, #4]
	mov r0, #0x1e
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r2, #1
	ldr r1, =0x000009F8
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	mov r2, #0
	str r2, [sp]
	str r7, [sp, #4]
	mov r0, #0x1f
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	mov r2, #1
	ldr r1, =0x00000A5C
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	mov r3, #0
	str r3, [sp]
	mov r1, #0x2b
	str r7, [sp, #4]
	mov r0, #0x20
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x18]
	lsl r1, r1, #6
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	mov r2, #1
	str r3, [sp, #0x14]
	bl NameMenu__InitAnimator
	mov r3, #0
	str r3, [sp]
	str r7, [sp, #4]
	mov r0, #0x21
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	ldr r1, =0x00000B24
	ldr r0, [sp, #0x18]
	mov r2, #1
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	mov r4, #0
	mov r1, #0xa3
	ldr r0, [sp, #0x18]
	lsl r1, r1, #2
	add r0, r0, r1
	ldr r6, =_02161A7C
	str r4, [sp, #0x24]
	mov r5, r4
	str r0, [sp, #0x44]
_0215F326:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #0x2e]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	ldr r0, =0x000008FC
	add r1, r4, r0
	ldr r0, [sp, #0x44]
	add r0, r0, r1
	ldr r1, [sp, #0x2c]
	bl NameMenu__InitAnimator
	ldr r0, [sp, #0x24]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #3
	str r0, [sp, #0x24]
	cmp r0, #3
	blt _0215F326
	mov r1, #0
	str r1, [sp]
	str r7, [sp, #4]
	mov r0, #0x38
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, #1
	ldr r1, =0x00000CB4
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl NameMenu__InitAnimator
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

void NameMenu__InitBackgrounds(NameMenuWorker *work)
{
    InitBackground(&work->backgrounds[0], FileUnknown__GetAOUFile(work->archiveDmni, ARCHIVE_DMNI_LZ7_FILE_DMNI_NAME_BASE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B,
                   BACKGROUND_3, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);

    for (s32 i = 0; i < 7; i++)
    {
        InitBackground(&work->backgrounds[1 + i], FileUnknown__GetAOUFile(work->archiveDmni, i + ARCHIVE_DMNI_LZ7_FILE_DMNI_CODE_HIRA_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B,
                       BACKGROUND_2, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    }
}

void NameMenu__InitUnknown2056570(NameMenuWorker *work)
{
    work->field_E28 = HeapAllocHead(HEAP_USER, 0x6C0);
    MI_CpuClear32(work->field_E28, 0x6C0);

    Unknown2056570__Init(&work->field_DF8, GRAPHICS_ENGINE_B, BACKGROUND_1, 0, 8, 1, 18, 3, work->field_E28, 0, 32);
    Unknown2056570__Func_2056688(&work->field_DF8, 1);

    MI_CpuCopy16(FontAnimator__Palettes[1], &((GXRgb *)VRAM_DB_BG_PLTT)[17], sizeof(FontAnimator__Palettes[1]));

    for (s32 i = 0; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        NameMenu__Func_21600A8(work, i, work->name.text[i]);
    }
}

void NameMenu__InitTouchField(NameMenuWorker *work)
{
    TouchField__Init(&work->touchField);

    work->touchField.mode           = TOUCHFIELD_MODE_0;
    work->touchField.delayDuration1 = 0;

    TouchRectUnknown rect;
    rect.box.left   = 0;
    rect.box.top    = 4;
    rect.box.right  = 68;
    rect.box.bottom = 24;

    Vec2Fx16 pos;
    pos.x = 20;
    pos.y = 160;

    for (s32 i = 0; i < 3; i++)
    {
        TouchField__InitAreaShape(&work->touchAreas[i], &pos, TouchField__PointInRect, &rect, NULL, NULL);
        TouchField__AddArea(&work->touchField, &work->touchAreas[i], TOUCHAREA_PRIORITY_FIRST);

        pos.x += 72;
    }
}

void NameMenu__ThreadFunc(void *arg)
{
    NameMenuWorker *work = (NameMenuWorker *)arg;
    NameMenu__Init(work);
}

void NameMenu__InitAnimator(AnimatorSprite *work, void *fileData, BOOL useEngineB, BOOL disableLooping, BOOL enableScale, GetSpriteSizeFromAnimFunc getSpriteSize, u16 animID,
                            u16 paletteRow, u8 oamPriority, u8 oamOrder)
{
    u32 flags = ANIMATOR_FLAG_NONE;
    void *vramPalette;

    if (disableLooping)
        flags |= ANIMATOR_FLAG_DISABLE_LOOPING;

    if (enableScale)
        flags |= ANIMATOR_FLAG_ENABLE_SCALE;

    if (useEngineB == GRAPHICS_ENGINE_A)
        vramPalette = VRAM_OBJ_PLTT;
    else
        vramPalette = VRAM_DB_OBJ_PLTT;

    AnimatorSprite__Init(work, fileData, animID, flags, useEngineB, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(useEngineB, getSpriteSize(fileData, animID)),
                         PALETTE_MODE_SPRITE, vramPalette, oamPriority, oamOrder);
    work->cParam.palette = paletteRow;
}

void NameMenu__InitFontWindow(NameMenuWorker *work)
{
    Background background;
    InitBackground(&background, FileUnknown__GetAOUFile(work->archiveDmni, ARCHIVE_DMNI_LZ7_FILE_DMNI_NAME_BASE_UP_BBG), BACKGROUND_FLAG_LOAD_ALL, FALSE, BACKGROUND_3,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    FontWindowAnimator fontWindow;
    FontWindowAnimator__Init(&fontWindow);
    FontWindowAnimator__Load1(&fontWindow, work->fontWindowPtr, 0x38, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(24), PIXEL_TO_TILE(56),
                              PIXEL_TO_TILE(208), PIXEL_TO_TILE(64), GRAPHICS_ENGINE_A, BACKGROUND_1, PALETTE_ROW_1, 1, 0);
    FontWindowAnimator__Func_20599C4(&fontWindow);
    FontWindowAnimator__Draw(&fontWindow);
    FontWindowAnimator__Release(&fontWindow);

    FontAnimator fontAnimator;
    void *mpcFile = FileUnknown__GetAOUFile(work->archiveDmni, GetGameLanguage() + ARCHIVE_DMNI_LZ7_FILE_DMNI_MSG_JPN_MPC);
    FontAnimator__Init(&fontAnimator);
    FontAnimator__LoadFont1(&fontAnimator, work->fontWindowPtr, 0x38, PIXEL_TO_TILE(32), PIXEL_TO_TILE(64), PIXEL_TO_TILE(192), PIXEL_TO_TILE(48), GRAPHICS_ENGINE_A, BACKGROUND_0,
                            PALETTE_ROW_0, 256);
    FontAnimator__LoadMappingsFunc(&fontAnimator);
    FontAnimator__LoadPaletteFunc(&fontAnimator);
    FontAnimator__LoadMPCFile(&fontAnimator, mpcFile);
    FontAnimator__SetMsgSequence(&fontAnimator, 4);
    FontAnimator__InitStartPos(&fontAnimator, 1, 0);

    switch (FontAnimator__GetDialogLineCount(&fontAnimator, 0))
    {
        case 1:
            FontAnimator__AdvanceLine(&fontAnimator, 16);
            break;

        case 2:
            FontAnimator__AdvanceLine(&fontAnimator, 8);
            break;
    }

    FontAnimator__LoadCharacters(&fontAnimator, 0);
    FontAnimator__Draw(&fontAnimator);
    FontAnimator__Release(&fontAnimator);
}

void NameMenu__Release(NameMenuWorker *work)
{
    NameMenu__ReleaseTouchField(work);
    NameMenu__ReleaseUnknown2056570(work);
    NameMenu__ReleaseBackgrounds(work);
    NameMenu__ReleaseAnimators(work);
    NameMenu__ResetDisplay(work);

    for (s32 i = 0; i < SAVEGAME_MAX_NAME_LEN; i++)
    {
        work->name.text[i] = NameMenu__GetCharacterFromIndex(work->name.text[i]);
    }
}

void NameMenu__ResetDisplay(NameMenuWorker *work)
{
    NameMenu__SetupBlending(work, 0x10);
}

void NameMenu__ReleaseAnimators(NameMenuWorker *work)
{
    s32 i;

    AnimatorSprite__Release(&work->aniSprites[26]);

    for (i = 2; i >= 0; i--)
    {
        AnimatorSprite__Release(&work->aniSprites[i + 23]);
    }

    AnimatorSprite__Release(&work->aniSprites[22]);
    AnimatorSprite__Release(&work->aniSprites[21]);
    AnimatorSprite__Release(&work->aniSprites[20]);
    AnimatorSprite__Release(&work->aniSprites[19]);

    for (i = 1; i >= 0; i--)
    {
        AnimatorSprite__Release(&work->aniSprites[i + 17]);
    }

    for (i = 4; i >= 0; i--)
    {
        AnimatorSprite__Release(&work->aniSprites[i + 12]);
    }

    for (i = 4; i >= 0; i--)
    {
        AnimatorSprite__Release(&work->aniSprites[i + 7]);
    }

    for (i = 2; i >= 0; i--)
    {
        AnimatorSprite__Release(&work->aniSprites[i + 4]);
    }

    AnimatorSprite *animator = &work->aniSprites[3];
    for (i = 3; i >= 0; i--)
    {
        AnimatorSprite__Release(&work->aniSprites[3 - (3 - i)]);
    }

    MI_CpuClear32(work->aniSprites, sizeof(work->aniSprites));
}

void NameMenu__ReleaseBackgrounds(NameMenuWorker *work)
{
    // Nothing to release
}

void NameMenu__ReleaseUnknown2056570(NameMenuWorker *work)
{
    Unknown2056570__Func_2056670(&work->field_DF8);

    if (work->field_E28 != NULL)
    {
        HeapFree(HEAP_USER, work->field_E28);
        work->field_E28 = NULL;
    }
}

void NameMenu__ReleaseTouchField(NameMenuWorker *work)
{
    MI_CpuClear16(work->touchAreas, sizeof(work->touchAreas));
}

void NameMenu__Main_Loading(void)
{
    if (IsThreadWorkerFinished(&NameMenu__sVars->thread))
    {
        DrawBackground(&NameMenu__sVars->backgrounds[0]);

        NameMenu__SetTextPage(NameMenu__sVars, 2);
        for (s32 i = 0; i < 5; i++)
        {
            NameMenu__SetUnknown(NameMenu__sVars, i, 0);
        }

        NameMenu__sVars->state = NameMenu__State_FadeIn;
        SetCurrentTaskMainEvent(NameMenu__Main_Active);
    }
}

void NameMenu__Main_Active(void)
{
    if (NameMenu__sVars->state != NULL)
    {
        TouchField__Process(&NameMenu__sVars->touchField);
        NameMenu__sVars->state(NameMenu__sVars);
    }
    else
    {
        DestroyCurrentTask();
        NameMenu__sVars->isActive = FALSE;
    }
}

void NameMenu__Destructor(Task *task)
{
    NameMenu__Release(NameMenu__sVars);
}

void NameMenu__State_FadeIn(NameMenuWorker *work)
{
    if (renderCoreGFXControlA.brightness < RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness++;
    }
    else if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness--;
    }

    renderCoreGFXControlB.brightness = renderCoreGFXControlA.brightness;

    if (NameMenu__DrawMenuInitial(work))
    {
        if (VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->brightness == RENDERCORE_BRIGHTNESS_DEFAULT)
        {
            AnimatorSprite__SetAnimation(&work->aniSprites[8], 20);
            work->field_14 = 1;
            work->state    = NameMenu__State_Active;
        }
    }
}

NONMATCH_FUNC void NameMenu__State_Active(NameMenuWorker *work)
{
#ifdef NON_MATCHING
    char16 character      = 0xFFFF;
    BOOL characterChanged = FALSE;
    BOOL confirmPress     = FALSE;
    BOOL backPress        = FALSE;

    if (work->field_3C[0] != 2 && (work->touchAreas[0].responseFlags & TOUCHAREA_RESPONSE_40000) != 0)
    {
        backPress = TRUE;
        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CANCEL);
    }
    else
    {
        if (work->field_3C[1] != 2 && (work->touchAreas[1].responseFlags & TOUCHAREA_RESPONSE_40000) != 0)
        {
            NameMenu__DeleteCharacter(work);
            PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CANCEL);
        }
        else
        {
            if (work->field_3C[2] != 2 && (work->touchAreas[2].responseFlags & TOUCHAREA_RESPONSE_40000) != 0)
            {
                confirmPress = TRUE;
                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
            }
            else
            {
                u16 cursorX;
                u16 cursorY;

                if (NameMenu__GetCursorPositionFromTouch(work, &cursorX, &cursorY))
                {
                    character = NameMenu__GetCharacterTable[work->textPageID](cursorX, cursorY);
                    if (character != 0xFFFF)
                    {
                        NameMenu__SetCharacterSelection(work, cursorX, cursorY);
                        characterChanged = TRUE;
                    }
                }
                else
                {
                    s32 selection = NameMenu__GetMenuSelectionFromTouch(work);
                    if (selection < 3)
                        NameMenu__SetMenuSelection(work, selection);
                }

                if (work->menuSelection >= 3)
                {
                    u32 x = work->cursorX;
                    u32 y = work->cursorY;

                    if ((padInput.btnPressRepeat & PAD_KEY_LEFT) != 0)
                    {

                        do
                        {
                            if (x == 0)
                            {
                                x = 11;
                            }
                            else
                            {
                                x--;
                            }
                        } while (NameMenu__GetCharacterTable[work->textPageID](x, y) == 0xFFFF);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if ((padInput.btnPressRepeat & PAD_KEY_RIGHT) != 0)
                    {
                        do
                        {
                            if (x == 11)
                            {
                                x = 0;
                            }
                            else
                            {
                                x--;
                            }
                        } while (NameMenu__GetCharacterTable[work->textPageID](x, y) == 0xFFFF);

                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if ((padInput.btnPressRepeat & PAD_KEY_UP) != 0)
                    {
                        u32 cursorY;
                        while (TRUE)
                        {
                            cursorY = y;
                            if (y == 0)
                            {
                                y = 5;
                                break;
                            }

                            y--;

                            if (NameMenu__GetCharacterTable[work->textPageID](x, cursorY - 1) != 0xFFFF)
                                break;
                        }

                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if ((padInput.btnPressRepeat & PAD_KEY_DOWN) != 0)
                    {
                        do
                        {
                            y++;
                        } while (y < 5 && NameMenu__GetCharacterTable[work->textPageID](x, y) == 0xFFFF);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if (y < 5)
                    {
                        if (x != work->cursorX || y != work->cursorY)
                        {
                            NameMenu__SetCharacterSelection(work, x, y);
                        }
                    }
                    else
                    {
                        u32 selection;

                        if (x < 4)
                        {
                            selection = 0;
                        }
                        else if (x < 8)
                        {
                            selection = 1;
                        }
                        else
                        {
                            selection = 2;
                        }

                        while (work->field_3C[selection] == 2)
                        {
                            if (selection == 2)
                                selection = 0;
                            else
                                selection++;
                        }

                        NameMenu__SetMenuSelection(work, selection);
                    }
                }
                else
                {
                    s32 selection = work->menuSelection;
                    if ((padInput.btnPressRepeat & PAD_KEY_LEFT) != 0)
                    {
                        do
                        {
                            if (selection == 0)
                                selection = 2;
                            else
                                selection--;

                        } while (work->field_3C[selection] == 2);

                        NameMenu__SetMenuSelection(work, selection);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if ((padInput.btnPressRepeat & PAD_KEY_RIGHT) != 0)
                    {
                        do
                        {
                            if (selection == 2)
                                selection = 0;
                            else
                                selection++;

                        } while (work->field_3C[selection] == 2);

                        NameMenu__SetMenuSelection(work, selection);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if ((padInput.btnPressRepeat & PAD_KEY_UP) != 0)
                    {
                        s32 x = 4 * selection + 1;
                        s32 y = 4;
                        while (NameMenu__GetCharacterTable[work->textPageID](x, y) == 0xFFFF)
                        {
                            if (y == 0)
                                break;

                            y--;
                        }

                        NameMenu__SetCharacterSelection(work, x, y);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }

                    if ((padInput.btnPressRepeat & PAD_KEY_DOWN) != 0)
                    {
                        s32 x = 4 * selection + 1;
                        s32 y = 0;
                        if (NameMenu__GetCharacterTable[work->textPageID](x, y) == 0xFFFF)
                        {
                            do
                            {
                                y++;
                            } while (y < 5 && NameMenu__GetCharacterTable[work->textPageID](x, y) == 0xFFFF);
                        }

                        NameMenu__SetCharacterSelection(work, x, y);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                    }
                }

                s32 page = NameMenu__CheckPageChange(work);
                if (page < 5)
                {
                    NameMenu__UpdateTextPage(work, page);
                    PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                }

                char16 newCharacter;
                if (work->menuSelection >= 3)
                    newCharacter = NameMenu__GetCharacterTable[work->textPageID](work->cursorX, work->cursorY);
                else
                    newCharacter = 0xFFFF;

                if ((padInput.btnPressRepeat & PAD_BUTTON_A) != 0)
                {
                    if (newCharacter < 0xFFFF)
                    {
                        character = newCharacter;
                    }
                    else
                    {
                        switch (work->menuSelection)
                        {
                            case 0:
                                if ((padInput.btnPress & PAD_BUTTON_A) != 0)
                                {
                                    backPress = TRUE;
                                    PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                                }
                                break;

                            case 1:
                                if (work->nameLength > 0)
                                {
                                    NameMenu__DeleteCharacter(work);
                                    PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                                }
                                break;

                            case 2:
                                if ((padInput.btnPress & PAD_BUTTON_A) != 0)
                                {
                                    confirmPress = TRUE;
                                    PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                                }
                                break;
                        }
                    }
                }
                else
                {
                    if ((padInput.btnPressRepeat & PAD_BUTTON_B) != 0)
                    {
                        if (work->nameLength > 0)
                        {
                            NameMenu__DeleteCharacter(work);
                            PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CANCEL);
                        }
                    }
                    else if ((padInput.btnPress & PAD_BUTTON_START) != 0 && work->field_3C[2] != 2)
                    {
                        NameMenu__SetMenuSelection(work, 2);
                        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                    }
                }

                if (character < 392)
                {
                    NameMenu__SetCharacter(work, character);
                    work->field_34 = 16;
                    PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                }
                else
                {
                    switch (character)
                    {
                        case 0xFFFE:
                            if (work->textPageID != 0)
                            {
                                NameMenu__SetTextPage(work, 0);
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;

                        case 0xFFFD:
                            if (work->textPageID != 1)
                            {
                                NameMenu__SetTextPage(work, 1);
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;

                        case 0xFFFC:
                            if (work->textPageID != 2)
                            {
                                NameMenu__SetTextPage(work, 2);
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;

                        case 0xFFFB:
                            if (work->textPageID != 3)
                            {
                                NameMenu__SetTextPage(work, 3);
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;

                        case 0xFFFA:
                            if (NameMenu__Func_215FFE8(work))
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;

                        case 0xFFF9:
                            if (NameMenu__Func_2160028(work))
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;

                        case 0xFFF8:
                            if (NameMenu__Func_2160068(work))
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                            }
                            else if (characterChanged)
                            {
                                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
                            }
                            break;
                    }
                }
            }
        }
    }

    NameMenu__DrawMenu(NameMenu__sVars);

    if (confirmPress)
    {
        work->applyName = TRUE;
        work->field_14  = 0;
        MI_CpuFill32(work->field_3C, 2, sizeof(work->field_3C));
        work->state = NameMenu__State_FadeOut;
    }
    else if (backPress)
    {
        work->applyName = FALSE;
        work->field_14  = 0;
        MI_CpuFill32(work->field_3C, 2, sizeof(work->field_3C));
        work->state = NameMenu__State_FadeOut;
    }
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r4, r0
	ldr r0, =0x0000FFFF
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #4]
	str r0, [sp]
	ldr r0, [r4, #0x3c]
	cmp r0, #2
	beq _0215F9BA
	ldr r0, =0x00000D44
	ldr r1, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0215F9BA
	mov r0, #1
	str r0, [sp, #4]
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215F9BA:
	ldr r0, [r4, #0x40]
	cmp r0, #2
	beq _0215F9DA
	ldr r0, =0x00000D7C
	ldr r1, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0215F9DA
	mov r0, r4
	bl NameMenu__DeleteCharacter
	mov r0, #1
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215F9DA:
	ldr r0, [r4, #0x44]
	cmp r0, #2
	beq _0215F9F8
	ldr r0, =0x00000DB4
	ldr r1, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0215F9F8
	mov r0, #1
	str r0, [sp]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215F9F8:
	add r1, sp, #0x10
	mov r0, r4
	add r1, #2
	add r2, sp, #0x10
	bl NameMenu__GetCursorPositionFromTouch
	cmp r0, #0
	beq _0215FA34
	ldr r2, [r4, #8]
	add r1, sp, #0x10
	lsl r3, r2, #2
	ldr r2, =NameMenu__GetCharacterTable
	ldrh r0, [r1, #2]
	ldrh r1, [r1, #0]
	ldr r2, [r2, r3]
	blx r2
	str r0, [sp, #0xc]
	ldr r1, =0x0000FFFF
	ldr r0, [sp, #0xc]
	cmp r0, r1
	beq _0215FA46
	add r2, sp, #0x10
	ldrh r1, [r2, #2]
	ldrh r2, [r2, #0]
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	mov r0, #1
	str r0, [sp, #8]
	b _0215FA46
_0215FA34:
	mov r0, r4
	bl NameMenu__GetMenuSelectionFromTouch
	mov r1, r0
	cmp r1, #3
	bge _0215FA46
	mov r0, r4
	bl NameMenu__SetMenuSelection
_0215FA46:
	ldr r5, [r4, #0x38]
	cmp r5, #3
	bge _0215FA4E
	b _0215FB86
_0215FA4E:
	ldrh r0, [r4, #0x30]
	add r5, sp, #0x10
	strh r0, [r5, #2]
	ldrh r0, [r4, #0x32]
	strh r0, [r5]
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x20
	tst r0, r1
	beq _0215FA8C
	ldr r7, =NameMenu__GetCharacterTable
	mov r6, #0xb
_0215FA66:
	ldrh r0, [r5, #2]
	cmp r0, #0
	bne _0215FA70
	strh r6, [r5, #2]
	b _0215FA74
_0215FA70:
	sub r0, r0, #1
	strh r0, [r5, #2]
_0215FA74:
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldrh r1, [r5, #0]
	ldr r2, [r7, r2]
	blx r2
	ldr r1, =0x0000FFFF
	cmp r0, r1
	beq _0215FA66
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FA8C:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x10
	tst r0, r1
	beq _0215FAC2
	ldr r7, =NameMenu__GetCharacterTable
	mov r6, #0
	add r5, sp, #0x10
_0215FA9C:
	ldrh r0, [r5, #2]
	cmp r0, #0xb
	bne _0215FAA6
	strh r6, [r5, #2]
	b _0215FAAA
_0215FAA6:
	add r0, r0, #1
	strh r0, [r5, #2]
_0215FAAA:
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldrh r1, [r5, #0]
	ldr r2, [r7, r2]
	blx r2
	ldr r1, =0x0000FFFF
	cmp r0, r1
	beq _0215FA9C
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FAC2:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _0215FAFA
	ldr r6, =NameMenu__GetCharacterTable
	ldr r7, =0x0000FFFF
	add r5, sp, #0x10
_0215FAD2:
	ldrh r0, [r5, #0]
	cmp r0, #0
	bne _0215FAE0
	mov r1, #5
	add r0, sp, #0x10
	strh r1, [r0]
	b _0215FAF4
_0215FAE0:
	sub r0, r0, #1
	strh r0, [r5]
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldrh r1, [r5, #0]
	ldr r2, [r6, r2]
	blx r2
	cmp r0, r7
	beq _0215FAD2
_0215FAF4:
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FAFA:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x80
	tst r0, r1
	beq _0215FB2A
	ldr r6, =NameMenu__GetCharacterTable
	ldr r7, =0x0000FFFF
	add r5, sp, #0x10
_0215FB0A:
	ldrh r0, [r5, #0]
	add r0, r0, #1
	strh r0, [r5]
	ldrh r1, [r5, #0]
	cmp r1, #5
	bhs _0215FB24
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldr r2, [r6, r2]
	blx r2
	cmp r0, r7
	beq _0215FB0A
_0215FB24:
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FB2A:
	add r0, sp, #0x10
	ldrh r2, [r0, #0]
	cmp r2, #5
	bhs _0215FB4A
	ldrh r1, [r0, #2]
	ldrh r0, [r4, #0x30]
	cmp r1, r0
	bne _0215FB42
	ldrh r0, [r4, #0x32]
	cmp r2, r0
	bne _0215FB42
	b _0215FCB0
_0215FB42:
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	b _0215FCB0
_0215FB4A:
	ldrh r0, [r0, #2]
	cmp r0, #4
	bhs _0215FB54
	mov r1, #0
	b _0215FB5E
_0215FB54:
	cmp r0, #8
	bhs _0215FB5C
	mov r1, #1
	b _0215FB5E
_0215FB5C:
	mov r1, #2
_0215FB5E:
	lsl r0, r1, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	bne _0215FB7E
	mov r2, #0
_0215FB6A:
	cmp r1, #2
	bne _0215FB72
	mov r1, r2
	b _0215FB74
_0215FB72:
	add r1, r1, #1
_0215FB74:
	lsl r0, r1, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	beq _0215FB6A
_0215FB7E:
	mov r0, r4
	bl NameMenu__SetMenuSelection
	b _0215FCB0
_0215FB86:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x20
	tst r0, r1
	beq _0215FBB4
	mov r1, #2
_0215FB92:
	cmp r5, #0
	bne _0215FB9A
	mov r5, r1
	b _0215FB9C
_0215FB9A:
	sub r5, r5, #1
_0215FB9C:
	lsl r0, r5, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	beq _0215FB92
	mov r0, r4
	mov r1, r5
	bl NameMenu__SetMenuSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FBB4:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x10
	tst r0, r1
	beq _0215FBE2
	mov r1, #0
_0215FBC0:
	cmp r5, #2
	bne _0215FBC8
	mov r5, r1
	b _0215FBCA
_0215FBC8:
	add r5, r5, #1
_0215FBCA:
	lsl r0, r5, #2
	add r0, r4, r0
	ldr r0, [r0, #0x3c]
	cmp r0, #2
	beq _0215FBC0
	mov r0, r4
	mov r1, r5
	bl NameMenu__SetMenuSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FBE2:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _0215FC3C
	lsl r0, r5, #2
	add r1, r0, #1
	add r0, sp, #0x10
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0]
	ldr r2, [r4, #8]
	ldrh r0, [r0, #2]
	lsl r3, r2, #2
	ldr r2, =NameMenu__GetCharacterTable
	ldr r2, [r2, r3]
	blx r2
	ldr r1, =0x0000FFFF
	cmp r0, r1
	bne _0215FC2A
	ldr r7, =NameMenu__GetCharacterTable
	add r6, sp, #0x10
_0215FC0E:
	ldrh r0, [r6, #0]
	cmp r0, #0
	beq _0215FC2A
	sub r0, r0, #1
	strh r0, [r6]
	ldr r2, [r4, #8]
	ldrh r0, [r6, #2]
	lsl r2, r2, #2
	ldrh r1, [r6, #0]
	ldr r2, [r7, r2]
	blx r2
	ldr r1, =0x0000FFFF
	cmp r0, r1
	beq _0215FC0E
_0215FC2A:
	add r2, sp, #0x10
	ldrh r1, [r2, #2]
	ldrh r2, [r2, #0]
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FC3C:
	ldr r0, =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x80
	tst r0, r1
	beq _0215FCB0
	lsl r0, r5, #2
	add r1, r0, #1
	add r0, sp, #0x10
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0]
	ldr r2, [r4, #8]
	ldrh r0, [r0, #2]
	lsl r3, r2, #2
	ldr r2, =NameMenu__GetCharacterTable
	ldr r2, [r2, r3]
	blx r2
	ldr r1, =0x0000FFFF
	cmp r0, r1
	bne _0215FC9E
	ldr r6, =NameMenu__GetCharacterTable
	b _0215FC80
_0215FC80:
	add r5, sp, #0x10
	mov r7, r1
_0215FC84:
	ldrh r0, [r5, #0]
	add r0, r0, #1
	strh r0, [r5]
	ldrh r1, [r5, #0]
	cmp r1, #5
	bhs _0215FC9E
	ldr r2, [r4, #8]
	ldrh r0, [r5, #2]
	lsl r2, r2, #2
	ldr r2, [r6, r2]
	blx r2
	cmp r0, r7
	beq _0215FC84
_0215FC9E:
	add r2, sp, #0x10
	ldrh r1, [r2, #2]
	ldrh r2, [r2, #0]
	mov r0, r4
	bl NameMenu__SetCharacterSelection
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FCB0:
	mov r0, r4
	bl NameMenu__CheckPageChange
	mov r1, r0
	cmp r1, #5
	bge _0215FCC8
	mov r0, r4
	bl NameMenu__UpdateTextPage
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FCC8:
	ldr r0, [r4, #0x38]
	cmp r0, #3
	blt _0215FCDE
	ldr r2, [r4, #8]
	ldrh r0, [r4, #0x30]
	lsl r3, r2, #2
	ldr r2, =NameMenu__GetCharacterTable
	ldrh r1, [r4, #0x32]
	ldr r2, [r2, r3]
	blx r2
	b _0215FCE0
_0215FCDE:
	ldr r0, =0x0000FFFF
_0215FCE0:
	ldr r2, =padInput
	mov r5, #1
	ldrh r3, [r2, #8]
	mov r1, r3
	tst r1, r5
	beq _0215FD3A
	ldr r1, =0x0000FFFF
	cmp r0, r1
	bhs _0215FCF6
	str r0, [sp, #0xc]
	b _0215FD70
_0215FCF6:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _0215FD06
	cmp r0, #1
	beq _0215FD16
	cmp r0, #2
	beq _0215FD2A
	b _0215FD70
_0215FD06:
	ldrh r0, [r2, #4]
	tst r0, r5
	beq _0215FD70
	mov r0, #0
	str r5, [sp, #4]
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD16:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _0215FD70
	mov r0, r4
	bl NameMenu__DeleteCharacter
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD2A:
	ldrh r0, [r2, #4]
	tst r0, r5
	beq _0215FD70
	mov r0, #0
	str r5, [sp]
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD3A:
	mov r1, #2
	mov r0, r3
	tst r0, r1
	beq _0215FD56
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _0215FD70
	mov r0, r4
	bl NameMenu__DeleteCharacter
	mov r0, r5
	bl PlaySysMenuNavSfx
	b _0215FD70
_0215FD56:
	ldrh r2, [r2, #4]
	mov r0, #8
	tst r0, r2
	beq _0215FD70
	ldr r0, [r4, #0x44]
	cmp r0, #2
	beq _0215FD70
	mov r0, r4
	bl NameMenu__SetMenuSelection
	mov r0, #0
	bl PlaySysMenuNavSfx
_0215FD70:
	mov r1, #0x62
	ldr r0, [sp, #0xc]
	lsl r1, r1, #2
	cmp r0, r1
	bhs _0215FD8E
	ldr r1, [sp, #0xc]
	mov r0, r4
	bl NameMenu__SetCharacter
	mov r0, #0x10
	str r0, [r4, #0x34]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FD8E:
	ldr r1, =0x0000FFF8
	sub r0, r0, r1
	cmp r0, #6
	bls _0215FD98
	b _0215FEA0
_0215FD98:
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215FDA4: // jump table
    DCD 0x540078
    DCD 0xBC00DC
    DCD 0x30009C
    DCD 0x68A0000C
	// .hword _0215FE1E - _0215FDA4 - 2 // case 0
	// .hword _0215FDFA - _0215FDA4 - 2 // case 1
	// .hword _0215FE82 - _0215FDA4 - 2 // case 2
	// .hword _0215FE62 - _0215FDA4 - 2 // case 3
	// .hword _0215FE42 - _0215FDA4 - 2 // case 4
	// .hword _0215FDD6 - _0215FDA4 - 2 // case 5
	// .hword _0215FDB2 - _0215FDA4 - 2 // case 6
_0215FDB2:
	// ldr r0, [r4, #8]
	cmp r0, #0
	beq _0215FDC8
	mov r0, r4
	mov r1, #0
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDC8:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDD6:
	ldr r0, [r4, #8]
	cmp r0, #1
	beq _0215FDEC
	mov r0, r4
	mov r1, #1
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDEC:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FDFA:
	ldr r0, [r4, #8]
	cmp r0, #2
	beq _0215FE10
	mov r0, r4
	mov r1, #2
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE10:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE1E:
	ldr r0, [r4, #8]
	cmp r0, #3
	beq _0215FE34
	mov r0, r4
	mov r1, #3
	bl NameMenu__SetTextPage
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE34:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE42:
	mov r0, r4
	bl NameMenu__Func_215FFE8
	cmp r0, #0
	beq _0215FE54
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE54:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE62:
	mov r0, r4
	bl NameMenu__Func_2160028
	cmp r0, #0
	beq _0215FE74
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE74:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE82:
	mov r0, r4
	bl NameMenu__Func_2160068
	cmp r0, #0
	beq _0215FE94
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _0215FEA0
_0215FE94:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215FEA0
	mov r0, #2
	bl PlaySysMenuNavSfx
_0215FEA0:
	ldr r0, =NameMenu__sVars
	ldr r0, [r0, #0]
	bl NameMenu__DrawMenu
	ldr r0, [sp]
	cmp r0, #0
	beq _0215FECC
	mov r0, #1
	str r0, [r4, #0x10]
	mov r0, #0
	mov r1, r4
	str r0, [r4, #0x14]
	mov r0, #2
	add r1, #0x3c
	mov r2, #0xc
	bl MIi_CpuClear32
	ldr r1, =NameMenu__State_FadeOut
	ldr r0, =0x00000D18
	add sp, #0x14
	str r1, [r4, r0]
	pop {r4, r5, r6, r7, pc}
_0215FECC:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0215FEEA
	mov r0, #0
	str r0, [r4, #0x10]
	mov r1, r4
	str r0, [r4, #0x14]
	mov r0, #2
	add r1, #0x3c
	mov r2, #0xc
	bl MIi_CpuClear32
	ldr r1, =NameMenu__State_FadeOut
	ldr r0, =0x00000D18
	str r1, [r4, r0]
_0215FEEA:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

void NameMenu__State_FadeOut(NameMenuWorker *work)
{
    BOOL done = FALSE;

    s16 brightness = VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->brightness;
    if ((work->flags & 1) != 0)
    {
        brightness++;
        if (brightness >= RENDERCORE_BRIGHTNESS_WHITE)
        {
            brightness = RENDERCORE_BRIGHTNESS_WHITE;
            done       = TRUE;
        }
    }
    else
    {
        brightness--;
        if (brightness <= RENDERCORE_BRIGHTNESS_BLACK)
        {
            brightness = RENDERCORE_BRIGHTNESS_BLACK;
            done       = TRUE;
        }
    }

    renderCoreGFXControlB.brightness = brightness;
    renderCoreGFXControlA.brightness = brightness;

    if (done)
        work->state = NULL;
    else
        NameMenu__DrawMenu(NameMenu__sVars);
}

void NameMenu__SetCharacter(NameMenuWorker *work, char16 character)
{
    s32 pos = work->nameLength;
    if (pos >= SAVEGAME_MAX_NAME_LEN)
        pos = SAVEGAME_MAX_NAME_LEN - 1;
    else
        work->nameLength = pos + 1;

    work->name.text[pos] = character;

    NameMenu__Func_21600A8(work, pos, character);
    NameMenu__InitName(work);
    AnimatorSprite__SetAnimation(&work->aniSprites[19], 30);
}

void NameMenu__DeleteCharacter(NameMenuWorker *work)
{
    if (work->nameLength == 0)
        return;

    u32 pos = work->nameLength - 1;
    work->nameLength--;
    work->name.text[pos] = '\0';

    NameMenu__Func_21600A8(work, pos, 0);
    NameMenu__InitName(work);
    AnimatorSprite__SetAnimation(&work->aniSprites[19], 30);
}

BOOL NameMenu__Func_215FFE8(NameMenuWorker *work)
{
    if (work->nameLength == 0)
        return FALSE;

    u16 pos          = work->nameLength - 1;
    char16 character = NameMenu__Func_2160DDC(work->name.text[pos]);
    if (character == 0xFFFF)
        return FALSE;

    work->name.text[pos] = character;
    NameMenu__Func_21600A8(work, pos, character);
    return TRUE;
}

BOOL NameMenu__Func_2160028(NameMenuWorker *work)
{
    if (work->nameLength == 0)
        return FALSE;

    u16 pos          = work->nameLength - 1;
    char16 character = NameMenu__Func_2160DF8(work->name.text[pos]);
    if (character == 0xFFFF)
        return FALSE;

    work->name.text[pos] = character;
    NameMenu__Func_21600A8(work, pos, character);
    return TRUE;
}

BOOL NameMenu__Func_2160068(NameMenuWorker *work)
{
    if (work->nameLength == 0)
        return FALSE;

    u16 pos          = work->nameLength - 1;
    char16 character = NameMenu__Func_2160E14(work->name.text[pos]);
    if (character == 0xFFFF)
        return FALSE;

    work->name.text[pos] = character;
    NameMenu__Func_21600A8(work, pos, character);
    return TRUE;
}

void NameMenu__Func_21600A8(NameMenuWorker *work, u16 id, char16 character)
{
    void *font = FontWindow__GetFont(work->fontWindowPtr);
    FontFile__GetCharXAdvance(font, character);

    u16 x = 16 * id;

    BackgroundUnknown__CopyPixels(FontFile__GetPixels(font, 0), 2, 0, 0, 0x10, 0x10, work->field_E28, 0x12, x, 4, 0);

    if (character != '\0')
        FontFile__Func_2052B7C(font, character, 0, work->field_E28, 0x12, 3, x, 4, 0, 0, 1);

    Unknown2056570__Func_2056958(&work->field_DF8, 2 * id, 0, 2 * (id + 1) - 1, 2);
}

void NameMenu__DrawCharacterCursor(NameMenuWorker *work)
{
    Unknown2056570__Func_2056A58(&work->field_DF8);
    Unknown2056570__Func_2056A94(&work->field_DF8);

    AnimatorSprite *ani22 = &work->aniSprites[22];
    AnimatorSprite__ProcessAnimationFast(ani22);
    AnimatorSprite__DrawFrame(ani22);

    if (work->field_14)
    {
        s32 pos = work->nameLength;
        if (pos >= SAVEGAME_MAX_NAME_LEN)
            pos = SAVEGAME_MAX_NAME_LEN - 1;

        AnimatorSprite *aniCursor = &work->aniSprites[19];
        aniCursor->pos.x          = 16 * pos + 64;
        aniCursor->pos.y          = 12;
        AnimatorSprite__ProcessAnimationFast(aniCursor);
        AnimatorSprite__DrawFrame(aniCursor);
    }
}

NONMATCH_FUNC void NameMenu__InitName(NameMenuWorker *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	ble _021601B4
	mov r1, #0
	b _021601B6
_021601B4:
	mov r1, #2
_021601B6:
	mov r2, #0
	str r1, [r0, #0x40]
	mov r3, r2
	mov r4, r0
_021601BE:
	ldrh r1, [r4, #0x1c]
	cmp r1, #0
	beq _021601CC
	cmp r1, #0xb6
	beq _021601CC
	mov r2, #1
	b _021601D4
_021601CC:
	add r3, r3, #1
	add r4, r4, #2
	cmp r3, #8
	blt _021601BE
_021601D4:
	cmp r2, #0
	beq _021601E4
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	ble _021601E4
	mov r1, #0
	str r1, [r0, #0x44]
	b _021601E8
_021601E4:
	mov r1, #2
	str r1, [r0, #0x44]
_021601E8:
	ldr r2, [r0, #0x38]
	lsl r1, r2, #2
	add r3, r0, r1
	ldr r1, [r3, #0x3c]
	cmp r1, #2
	blo _021601FE
_021601F4:
	sub r3, r3, #4
	ldr r1, [r3, #0x3c]
	sub r2, r2, #1
	cmp r1, #2
	bhs _021601F4
_021601FE:
	ldr r1, [r0, #0x38]
	cmp r1, r2
	beq _02160210
	ldr r1, =0x00000CB4
	str r2, [r0, #0x38]
	add r0, r0, r1
	mov r1, #0x38
	bl AnimatorSprite__SetAnimation
_02160210:
	pop {r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void NameMenu__Func_2160218(NameMenuWorker *work, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, lr}
	mov r5, r1
	cmp r5, #0x20
	blo _02160224
	mov r0, #0
	pop {r4, r5, r6, pc}
_02160224:
	mov r1, #0xb6
	ldr r0, =0x01C71000
	lsl r1, r1, #0xe
	mov r2, #0x20
	mov r3, r5
	bl Unknown2051334__Func_20516B8
	mov r6, r0
	mov r0, r5
	mov r1, #8
	bl FX_DivS32
	mov r4, r0
	lsl r0, r4, #3
	sub r3, r5, r0
	cmp r3, #4
	blt _0216024A
	mov r0, #8
	sub r3, r0, r3
_0216024A:
	mov r0, #0
	mov r1, r6
	mov r2, #4
	bl Unknown2051334__Func_20516B8
	asr r1, r0, #0xc
	mov r0, #1
	tst r0, r4
	beq _0216025E
	neg r1, r1
_0216025E:
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	pop {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void NameMenu__UpdateTextPage(NameMenuWorker *work, s32 page){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r2, [r0, #8]
	cmp r2, #7
	bge _02160278
	lsl r3, r2, #2
	ldr r2, =_02161A28
	ldr r2, [r2, r3]
	b _0216027A
_02160278:
	mov r2, #6
_0216027A:
	cmp r2, r1
	beq _02160288
	lsl r2, r1, #2
	ldr r1, =_021619E4
	ldr r1, [r1, r2]
	bl NameMenu__SetTextPage
_02160288:
	pop {r3, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void NameMenu__SetTextPage(NameMenuWorker *work, s32 page)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #8]
	mov r6, r1
	cmp r0, r6
	beq _02160356
	cmp r0, #7
	bge _021602AC
	lsl r1, r0, #2
	ldr r0, =_02161A28
	ldr r1, [r0, r1]
	b _021602AE
_021602AC:
	mov r1, #6
_021602AE:
	cmp r6, #7
	bge _021602BA
	ldr r0, =_02161A28
	lsl r2, r6, #2
	ldr r4, [r0, r2]
	b _021602BC
_021602BA:
	mov r4, #6
_021602BC:
	cmp r1, r4
	beq _0216030E
	cmp r1, #5
	bge _021602DE
	mov r0, #0xa3
	add r3, r1, #7
	lsl r1, r1, #1
	lsl r0, r0, #2
	mov r2, #0x64
	add r1, #0x11
	lsl r1, r1, #0x10
	add r0, r5, r0
	mul r2, r3
	add r0, r0, r2
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_021602DE:
	ldr r2, =0x00000D1C
	lsl r0, r4, #2
	add r1, r5, r2
	mov r3, #1
	str r3, [r1, r0]
	sub r2, r2, #4
	ldr r2, [r5, r2]
	cmp r2, #0
	bne _0216030E
	mov r2, #0
	str r2, [r1, r0]
	mov r0, #0xa3
	lsl r0, r0, #2
	add r2, r5, r0
	add r1, r4, #7
	mov r0, #0x64
	mul r0, r1
	lsl r1, r4, #1
	add r1, #0x11
	lsl r1, r1, #0x10
	add r0, r2, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_0216030E:
	ldr r0, =NameMenu__ChangePageVariantTable
	lsl r1, r6, #2
	ldr r2, [r0, r1]
	cmp r2, #0
	beq _0216031E
	mov r0, r5
	mov r1, #1
	blx r2
_0216031E:
	str r6, [r5, #8]
	ldr r0, [r5, #0x38]
	cmp r0, #3
	blt _02160344
	ldr r2, [r5, #8]
	ldrh r0, [r5, #0x30]
	lsl r3, r2, #2
	ldr r2, =NameMenu__GetCharacterTable
	ldrh r1, [r5, #0x32]
	ldr r2, [r2, r3]
	blx r2
	ldr r1, =0x0000FFFF
	cmp r0, r1
	bne _02160344
	mov r0, r5
	mov r1, #1
	mov r2, #0
	bl NameMenu__SetCharacterSelection
_02160344:
	ldr r0, [r5, #8]
	mov r2, r5
	add r1, r0, #1
	mov r0, #0x48
	add r2, #0x4c
	mul r0, r1
	add r0, r2, r0
	bl DrawBackground
_02160356:
	pop {r4, r5, r6, pc}

// clang-format on
#endif
}

void NameMenu__SetCharacterSelection(NameMenuWorker *work, s32 x, s32 y)
{
    work->cursorX       = x;
    work->cursorY       = y;
    work->menuSelection = 4;
    work->field_34      = 0;

    AnimatorSprite__SetAnimation(&work->aniSprites[20], 31);
}

void NameMenu__SetMenuSelection(NameMenuWorker *work, s32 selection)
{
    work->menuSelection = selection;
    AnimatorSprite__SetAnimation(&work->aniSprites[26], 56);
}

void NameMenu__ChangePageVariant_JPN_Hiragana(NameMenuWorker *work, s32 a2)
{
    if (a2)
    {
        AnimatorSprite__SetAnimation(&work->aniSprites[0], 1);
        AnimatorSprite__SetAnimation(&work->aniSprites[1], 2);
    }
}

void NameMenu__ChangePageVariant_JPN_Katakana(NameMenuWorker *work, s32 a2)
{
    if (a2)
    {
        AnimatorSprite__SetAnimation(&work->aniSprites[0], 0);
        AnimatorSprite__SetAnimation(&work->aniSprites[1], 3);
    }
}

void NameMenu__ChangePageVariant_ENG_Lower(NameMenuWorker *work, s32 a2)
{
    if (a2)
    {
        AnimatorSprite__SetAnimation(&work->aniSprites[2], 5);
        AnimatorSprite__SetAnimation(&work->aniSprites[3], 6);
    }
}

void NameMenu__ChangePageVariant_ENG_Upper(NameMenuWorker *work, s32 a2)
{
    if (a2)
    {
        AnimatorSprite__SetAnimation(&work->aniSprites[2], 4);
        AnimatorSprite__SetAnimation(&work->aniSprites[3], 7);
    }
}

void NameMenu__SetUnknown(NameMenuWorker *work, s32 id, BOOL flag)
{
    AnimatorSprite *animator = &work->aniSprites[id + 12];

    if (flag)
    {
        AnimatorSprite__SetAnimation(animator, 27);
    }
    else
    {
        AnimatorSprite__SetAnimation(animator, 27);
        AnimatorSprite__AnimateManual(animator, 0x10000, 0, 0);
    }
}

BOOL NameMenu__DrawMenuInitial(NameMenuWorker *work)
{
    BOOL pageDone    = FALSE;
    BOOL optionsDone = FALSE;

    if (NameMenu__DrawPageVariantTable[work->textPageID] != NULL)
        NameMenu__DrawPageVariantTable[work->textPageID](work);

    NameMenu__DrawCharacterCursor(work);

    if (NameMenu__DrawPageSelectionsInitial(work, work->selectionTimer))
        pageDone = TRUE;

    if (NameMenu__DrawMenuOptionsInitial(work, work->selectionTimer))
        optionsDone = TRUE;

    work->selectionTimer++;

    return pageDone && optionsDone;
}

NONMATCH_FUNC BOOL NameMenu__DrawPageSelectionsInitial(NameMenuWorker *work, s32 timer)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x2c
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, r1
	str r1, [sp, #8]
	cmp r0, #0x2d
	bhs _021604D2
	mov r0, #0
	str r0, [sp, #0x14]
_021604D2:
	mov r0, #0
	str r0, [sp, #0x18]
	mov r1, #0xa3
	str r0, [sp, #0x1c]
	str r0, [sp, #0x10]
	ldr r0, =_021619F8
	ldr r7, [sp, #4]
	str r0, [sp, #0xc]
	lsl r1, r1, #2
	mov r0, r7
	add r0, r0, r1
	str r0, [sp, #0x20]
_021604EA:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x18]
	sub r5, r1, r0
	add r0, r0, #7
	str r0, [sp, #0x18]
	mov r0, #0xaf
	ldr r1, [sp, #0x10]
	lsl r0, r0, #2
	add r1, r1, r0
	ldr r0, [sp, #0x20]
	add r4, r0, r1
	mov r0, #0x4b
	ldr r1, [sp, #0x10]
	lsl r0, r0, #4
	add r1, r1, r0
	ldr r0, [sp, #0x20]
	add r6, r0, r1
	ldr r1, [sp, #0xc]
	mov r0, #0
	ldrsh r0, [r1, r0]
	strh r0, [r6, #8]
	mov r0, #8
	ldrsh r0, [r6, r0]
	strh r0, [r4, #8]
	mov r0, #2
	ldrsh r0, [r1, r0]
	strh r0, [r6, #0xa]
	mov r0, #0xa
	ldrsh r0, [r6, r0]
	cmp r5, #0x30
	strh r0, [r4, #0xa]
	blt _0216054C
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	b _02160606
_0216054C:
	cmp r5, #0
	bge _0216056A
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #1
	lsl r1, r1, #0xa
	mov r0, r4
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02160606
_0216056A:
	cmp r5, #0x10
	bhs _0216059C
	mov r0, #1
	lsl r0, r0, #0xc
	mov r1, #1
	str r0, [sp]
	lsr r0, r0, #2
	lsl r1, r1, #0xc
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	mov r1, #0
	str r0, [sp, #0x24]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [sp, #0x24]
	mov r0, r4
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _021605E4
_0216059C:
	blo _021605E4
	mov r1, r5
	ldr r0, =0x00000D1C
	sub r1, #0x10
	str r1, [r7, r0]
	ldr r1, =0x00000D1C
	ldr r0, [sp, #4]
	ldr r1, [r7, r1]
	bl NameMenu__Func_2160218
	mov r1, #0
	str r0, [sp, #0x28]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r3, [sp, #0x28]
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r3, r3, #0x10
	mov r0, r4
	mov r2, r1
	lsr r3, r3, #0x10
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, =0x00000D1C
	ldr r0, [r7, r0]
	add r1, r0, #1
	ldr r0, =0x00000D1C
	str r1, [r7, r0]
	ldr r0, [r7, r0]
	cmp r0, #0x20
	blo _021605E4
	ldr r0, =0x00000D1C
	mov r1, #0
	str r1, [r7, r0]
_021605E4:
	cmp r5, #8
	bne _021605F2
	ldr r0, [sp, #4]
	ldr r1, [sp, #0x1c]
	mov r2, #1
	bl NameMenu__SetUnknown
_021605F2:
	cmp r5, #8
	blo _02160606
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_02160606:
	ldr r0, [sp, #0x10]
	add r7, r7, #4
	add r0, #0x64
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	add r0, r0, #4
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
	cmp r0, #5
	bge _02160620
	b _021604EA
_02160620:
	ldr r0, [sp, #8]
	cmp r0, #0x15
	blo _02160686
	mov r1, #0x93
	ldr r0, [sp, #4]
	lsl r1, r1, #4
	add r4, r0, r1
	add r1, #0x64
	add r5, r0, r1
	mov r0, #0x28
	strh r0, [r4, #0xa]
	strh r0, [r5, #0xa]
	ldr r0, [sp, #8]
	sub r0, #0x15
	str r0, [sp, #8]
	cmp r0, #0x10
	blo _02160646
	mov r0, #0
	b _0216065C
_02160646:
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [sp]
	ldr r3, [sp, #8]
	mov r0, #0x20
	mov r1, #0
	mov r2, #0x10
	bl Unknown2051334__Func_2051534
	mov r1, #0
	str r1, [sp, #0x14]
_0216065C:
	neg r1, r0
	strh r1, [r4, #8]
	add r0, #0xf0
	mov r1, #0
	strh r0, [r5, #8]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	b _0216068A
_02160686:
	mov r0, #0
	str r0, [sp, #0x14]
_0216068A:
	ldr r0, [sp, #0x14]
	add sp, #0x2c
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL NameMenu__DrawMenuOptionsInitial(NameMenuWorker *work, s32 timer)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #0xc]
	str r1, [sp, #8]
	mov r7, r1
	mov r1, #0xa3
	lsl r1, r1, #2
	add r0, r0, r1
	mov r5, #0x1c
	mov r6, #0x14
	str r0, [sp, #0x10]
_021606B2:
	ldr r0, [sp, #4]
	cmp r5, r0
	bhi _02160704
	ldr r1, [sp, #8]
	ldr r0, =0x000008FC
	add r1, r1, r0
	ldr r0, [sp, #0x10]
	add r4, r0, r1
	ldr r0, [sp, #4]
	strh r6, [r4, #8]
	sub r3, r0, r5
	cmp r3, #8
	blo _021606D0
	mov r0, #0xa0
	b _021606E2
_021606D0:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x40
	mov r1, #0
	mov r2, #8
	bl Unknown2051334__Func_2051534
	add r0, #0xa0
_021606E2:
	strh r0, [r4, #0xa]
	ldrh r0, [r4, #0xc]
	cmp r0, #0
	beq _021606F4
	lsl r1, r7, #0x10
	mov r0, r4
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_021606F4:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02160704:
	add r6, #0x48
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #8]
	add r5, r5, #4
	add r0, #0x64
	str r0, [sp, #8]
	ldr r0, [sp, #0xc]
	add r7, r7, #3
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #3
	blt _021606B2
	ldr r0, [sp, #4]
	cmp r0, #0x30
	blo _0216072A
	add sp, #0x14
	mov r0, #1
	pop {r4, r5, r6, r7, pc}
_0216072A:
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void NameMenu__DrawMenu(NameMenuWorker *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r5, r0
	ldr r1, [r5, #8]
	lsl r2, r1, #2
	ldr r1, =NameMenu__DrawPageVariantTable
	ldr r1, [r1, r2]
	cmp r1, #0
	beq _02160748
	blx r1
_02160748:
	mov r0, r5
	bl NameMenu__DrawPageSelections
	mov r0, r5
	bl NameMenu__DrawCharacterCursor
	mov r0, r5
	bl NameMenu__DrawMenuOptions
	ldr r0, [r5, #0x14]
	cmp r0, #0
	beq _021607E6
	ldr r0, [r5, #0x38]
	cmp r0, #3
	blt _021607E6
	ldr r0, =0x00000A5C
	mov r1, #0
	add r6, r5, r0
	ldrh r0, [r5, #0x30]
	mov r2, r1
	lsl r0, r0, #4
	add r0, #0x20
	strh r0, [r6, #8]
	ldrh r0, [r5, #0x32]
	lsl r0, r0, #4
	add r0, #0x48
	strh r0, [r6, #0xa]
	mov r0, r6
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x34]
	cmp r0, #0
	beq _021607E6
	mov r0, #0x2b
	lsl r0, r0, #6
	add r4, r5, r0
	mov r0, #8
	ldrsh r0, [r6, r0]
	strh r0, [r4, #8]
	mov r0, #0xa
	ldrsh r0, [r6, r0]
	strh r0, [r4, #0xa]
	ldr r0, [r5, #0x34]
	cmp r0, #0x10
	bne _021607B6
	mov r0, #0
	str r0, [r4, #0x58]
	mov r0, r5
	mov r1, #0x10
	bl NameMenu__SetupBlending
	b _021607D6
_021607B6:
	mov r0, #1
	str r0, [r4, #0x58]
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	ldr r3, [r5, #0x34]
	mov r1, #0
	mov r2, r0
	sub r3, r0, r3
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	mov r0, r5
	bl NameMenu__SetupBlending
_021607D6:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_021607E6:
	ldr r0, [r5, #0x34]
	cmp r0, #0
	beq _021607F0
	sub r0, r0, #1
	str r0, [r5, #0x34]
_021607F0:
	add sp, #4
	pop {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

void NameMenu__DrawPageVariants_JPN(NameMenuWorker *work)
{
    AnimatorSprite *ani0 = &work->aniSprites[0];
    AnimatorSprite__ProcessAnimationFast(ani0);
    AnimatorSprite__DrawFrame(ani0);

    AnimatorSprite *ani1 = &work->aniSprites[1];
    AnimatorSprite__ProcessAnimationFast(ani1);
    AnimatorSprite__DrawFrame(ani1);

    char16 character;
    if (work->nameLength > 0)
        character = work->name.text[work->nameLength - 1];
    else
        character = 0;

    {
        AnimatorSprite *animator = &work->aniSprites[4];
        u16 anim;

        if (NameMenu__Func_2160DDC(character) != 0xFFFF)
            anim = 8;
        else
            anim = 10;

        if (anim != animator->animID)
            AnimatorSprite__SetAnimation(animator, anim);

        AnimatorSprite__ProcessAnimationFast(animator);
        AnimatorSprite__DrawFrame(animator);
    }

    {
        AnimatorSprite *animator = &work->aniSprites[5];
        u16 anim;

        if (NameMenu__Func_2160DF8(character) != 0xFFFF)
            anim = 11;
        else
            anim = 13;

        if (anim != animator->animID)
            AnimatorSprite__SetAnimation(animator, anim);

        AnimatorSprite__ProcessAnimationFast(animator);
        AnimatorSprite__DrawFrame(animator);
    }

    {
        AnimatorSprite *animator = &work->aniSprites[6];
        u16 anim;

        if (NameMenu__Func_2160E14(character) != 0xFFFF)
            anim = 14;
        else
            anim = 16;

        if (anim != animator->animID)
            AnimatorSprite__SetAnimation(animator, anim);

        AnimatorSprite__ProcessAnimationFast(animator);
        AnimatorSprite__DrawFrame(animator);
    }
}

void NameMenu__DrawPageVariants_ENG(NameMenuWorker *work)
{
    AnimatorSprite *ani2 = &work->aniSprites[2];
    AnimatorSprite__ProcessAnimationFast(ani2);
    AnimatorSprite__DrawFrame(ani2);

    AnimatorSprite *ani3 = &work->aniSprites[3];
    AnimatorSprite__ProcessAnimationFast(ani3);
    AnimatorSprite__DrawFrame(ani3);
}

NONMATCH_FUNC void NameMenu__DrawPageSelections(NameMenuWorker *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp]
	mov r0, #0
	mov r1, #0xa3
	ldr r5, [sp]
	str r0, [sp, #0xc]
	str r0, [sp, #8]
	mov r0, #0x12
	str r0, [sp, #4]
	lsl r1, r1, #2
	mov r0, r5
	add r0, r0, r1
	ldr r7, =_021619F8
	str r0, [sp, #0x10]
_02160926:
	mov r0, #0xaf
	ldr r1, [sp, #8]
	lsl r0, r0, #2
	add r1, r1, r0
	ldr r0, [sp, #0x10]
	add r4, r0, r1
	mov r0, #0x4b
	ldr r1, [sp, #8]
	lsl r0, r0, #4
	add r1, r1, r0
	ldr r0, [sp, #0x10]
	add r6, r0, r1
	mov r0, #0
	ldrsh r0, [r7, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r4, #8]
	mov r0, #2
	ldrsh r0, [r7, r0]
	strh r0, [r4, #0xa]
	mov r0, #8
	ldrsh r0, [r4, r0]
	strh r0, [r6, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	strh r0, [r6, #0xa]
	mov r0, r6
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x00000D1C
	ldr r0, [r5, r0]
	cmp r0, #0
	bne _02160980
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	b _021609CC
_02160980:
	sub r6, r0, #1
	bne _02160990
	ldr r1, [sp, #4]
	mov r0, r4
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
_02160990:
	ldr r0, [sp]
	mov r1, r6
	bl NameMenu__Func_2160218
	mov r1, #0
	mov r6, r0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r3, r6, #0x10
	mov r0, r4
	mov r2, r1
	lsr r3, r3, #0x10
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, =0x00000D1C
	ldr r0, [r5, r0]
	cmp r0, #0x20
	ldr r0, =0x00000D1C
	bhs _021609C8
	ldr r0, [r5, r0]
	add r1, r0, #1
	ldr r0, =0x00000D1C
	str r1, [r5, r0]
	b _021609CC
_021609C8:
	mov r1, #0
	str r1, [r5, r0]
_021609CC:
	ldr r0, [sp, #8]
	add r7, r7, #4
	add r0, #0x64
	str r0, [sp, #8]
	ldr r0, [sp, #4]
	add r5, r5, #4
	add r0, r0, #2
	str r0, [sp, #4]
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #5
	blt _02160926
	mov r1, #0x93
	ldr r0, [sp]
	lsl r1, r1, #4
	add r4, r0, r1
	mov r1, #0
	strh r1, [r4, #8]
	mov r0, #0x28
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x00000994
	ldr r0, [sp]
	add r4, r0, r1
	mov r0, #0xf0
	strh r0, [r4, #8]
	mov r0, #0x28
	mov r1, #0
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void NameMenu__DrawMenuOptions(NameMenuWorker *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	str r0, [sp]
	mov r0, #0
	mov r1, #0xd3
	str r0, [sp, #0x10]
	str r0, [sp, #0xc]
	ldr r0, [sp]
	lsl r1, r1, #4
	add r7, r0, r1
	str r0, [sp, #8]
	ldr r0, [sp, #0x10]
	sub r1, #0x7c
	str r0, [sp, #4]
	ldr r0, [sp]
	mov r6, #0x14
	add r5, r0, r1
	mov r1, #0xa3
	lsl r1, r1, #2
	add r0, r0, r1
	str r0, [sp, #0x14]
_02160A5E:
	ldr r1, [sp, #0xc]
	ldr r0, =0x000008FC
	add r1, r1, r0
	ldr r0, [sp, #0x14]
	add r4, r0, r1
	ldr r0, [r7, #0x14]
	mov r1, #0xa0
	strh r6, [r4, #8]
	strh r1, [r4, #0xa]
	ldr r1, [sp, #8]
	ldr r1, [r1, #0x3c]
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	cmp r1, #2
	beq _02160A90
	mov r1, #2
	lsl r1, r1, #0xa
	tst r1, r0
	bne _02160A8E
	mov r1, #0x10
	tst r0, r1
	beq _02160A8E
	mov r1, #1
	b _02160A90
_02160A8E:
	mov r1, #0
_02160A90:
	ldr r0, [sp, #4]
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add r0, r1, r0
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	ldrh r0, [r4, #0xc]
	cmp r1, r0
	beq _02160AA8
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02160AA8:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp]
	ldr r1, [r0, #0x38]
	ldr r0, [sp, #0x10]
	cmp r0, r1
	bne _02160ADE
	mov r0, #8
	ldrsh r0, [r4, r0]
	mov r1, #0
	mov r2, r1
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
_02160ADE:
	add r6, #0x48
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #0xc]
	add r7, #0x38
	add r0, #0x64
	str r0, [sp, #0xc]
	ldr r0, [sp, #8]
	add r0, r0, #4
	str r0, [sp, #8]
	ldr r0, [sp, #4]
	add r0, r0, #3
	str r0, [sp, #4]
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #3
	blt _02160A5E
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC BOOL NameMenu__CheckPageChange(NameMenuWorker *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, lr}
	ldr r1, [r0, #8]
	mov r3, #1
	lsl r2, r1, #2
	ldr r1, =_02161A28
	ldr r6, =padInput
	ldr r4, [r1, r2]
	ldrh r1, [r6, #0]
	lsl r3, r3, #8
	mov r5, r4
	mov r2, r1
	and r2, r3
	beq _02160B4A
	ldrh r1, [r6, #4]
	tst r1, r3
	beq _02160B30
	mov r1, #0
	str r1, [r0, #0x48]
_02160B30:
	ldr r2, [r0, #0x48]
	mov r1, #0xf
	tst r1, r2
	bne _02160B42
	cmp r5, #4
	blt _02160B40
	mov r5, #0
	b _02160B42
_02160B40:
	add r5, r5, #1
_02160B42:
	ldr r1, [r0, #0x48]
	add r1, r1, #1
	str r1, [r0, #0x48]
	b _02160B78
_02160B4A:
	cmp r2, #0
	bne _02160B78
	lsl r2, r3, #1
	tst r1, r2
	beq _02160B78
	ldrh r2, [r6, #4]
	lsl r1, r3, #1
	tst r1, r2
	beq _02160B60
	mov r1, #0
	str r1, [r0, #0x48]
_02160B60:
	ldr r2, [r0, #0x48]
	mov r1, #0xf
	tst r1, r2
	bne _02160B72
	cmp r5, #0
	bne _02160B70
	mov r5, #4
	b _02160B72
_02160B70:
	sub r5, r5, #1
_02160B72:
	ldr r1, [r0, #0x48]
	add r1, r1, #1
	str r1, [r0, #0x48]
_02160B78:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160BAE
	ldr r1, =touchInput
	mov r0, #4
	ldrh r2, [r1, #0x12]
	tst r0, r2
	beq _02160BAE
	ldrh r6, [r1, #0x1c]
	ldrh r1, [r1, #0x1e]
	mov r2, #0x11
	mov r3, #0
	sub r1, #0x20
_02160B94:
	sub r0, r6, r2
	cmp r0, #0x2d
	bhs _02160BA2
	cmp r1, #0x20
	bhs _02160BA2
	mov r5, r3
	b _02160BAE
_02160BA2:
	add r2, #0x2d
	lsl r0, r2, #0x10
	add r3, r3, #1
	lsr r2, r0, #0x10
	cmp r3, #5
	blt _02160B94
_02160BAE:
	cmp r5, r4
	bne _02160BB4
	mov r5, #6
_02160BB4:
	mov r0, r5
	pop {r4, r5, r6, pc}

// clang-format on
#endif
}

BOOL NameMenu__GetCursorPositionFromTouch(NameMenuWorker *work, fx16 *x, fx16 *y)
{
    BOOL touchActive;
    if (IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags) != 0)
        touchActive = TRUE;
    else
        touchActive = FALSE;

    if (!touchActive)
        return FALSE;

    u16 touchX = touchInput.push.x;
    u16 touchY = touchInput.push.y;
    if (touchY < 72)
        return FALSE;

    if ((u16)(touchY - 72) >= 80)
        return FALSE;

    if (touchX < 32)
    {
        if (touchX >= 16)
        {
            *x = 0;
            *y = (u16)(touchY - 72) / 16;
            return TRUE;
        }

        return FALSE;
    }
    else
    {
        if ((u16)(touchX - 32) >= 192)
            return FALSE;

        *x = (u16)(touchX - 32) / 16;
        *y = (u16)(touchY - 72) / 16;
        return TRUE;
    }

    return FALSE;
}

NONMATCH_FUNC s32 NameMenu__GetMenuSelectionFromTouch(NameMenuWorker *work)
{
    // https://decomp.me/scratch/NmrHx -> 98.75%
#ifdef NON_MATCHING
    s32 i;

    BOOL touchActive;
    if (IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags) != 0)
        touchActive = TRUE;
    else
        touchActive = FALSE;

    if (!touchActive)
        return 4;

    u16 touchX  = touchInput.push.x;
    u32 touchY  = touchInput.push.y - 164;
    u32 offsetX = 20;
    for (i = 0; i < 3; i++)
    {
        if (work->field_3C[i] != 2 && (u32)(touchX - (u16)offsetX) < 68 && touchY < 20)
        {
            return i;
        }

        offsetX = (u16)(offsetX + 72);
    }

    return 4;
#else
    // clang-format off
	push {r3, r4, r5, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160C56
	ldr r0, =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02160C56
	mov r0, #1
	b _02160C58
_02160C56:
	mov r0, #0
_02160C58:
	cmp r0, #0
	bne _02160C60
	mov r0, #4
	pop {r3, r4, r5, pc}
_02160C60:
	ldr r1, =touchInput
	mov r2, #0x14
	ldrh r3, [r1, #0x1c]
	ldrh r1, [r1, #0x1e]
	mov r0, #0
	sub r1, #0xa4
_02160C6C:
	ldr r5, [r4, #0x3c]
	cmp r5, #2
	beq _02160C80
	lsl r5, r2, #0x10
	lsr r5, r5, #0x10
	sub r5, r3, r5
	cmp r5, #0x44
	bhs _02160C80
	cmp r1, #0x14
	blo _02160C90
_02160C80:
	add r2, #0x48
	lsl r2, r2, #0x10
	add r0, r0, #1
	lsr r2, r2, #0x10
	add r4, r4, #4
	cmp r0, #3
	blt _02160C6C
	mov r0, #4
_02160C90:
	pop {r3, r4, r5, pc}
	nop

// clang-format on
#endif
}

void NameMenu__SetupBlending(NameMenuWorker *work, u16 alpha)
{
    BlendController *control = &VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->blendManager;

    if (alpha >= 16)
    {
        control->blendControl.value = 0;
        control->blendAlpha.value   = 0;
    }
    else
    {
        control->blendControl.value      = 0;
        control->blendControl.plane2_BG2 = TRUE;
        control->blendControl.plane2_BG3 = TRUE;

        control->blendAlpha.value = 0;
        control->blendAlpha.ev1   = alpha;
        control->blendAlpha.ev2   = 16 - alpha;
    }
}

u16 NameMenu__GetCharacter_JPN_Hiragana(s32 x, s32 y)
{
    return NameMenu__CharacterTable_JPN_Hiragana[y][x];
}

u16 NameMenu__GetCharacter_JPN_Katakana(s32 x, s32 y)
{
    return NameMenu__CharacterTable_JPN_Katakana[y][x];
}

u16 NameMenu__GetCharacter_ENG_Lower(s32 x, s32 y)
{
    return NameMenu__CharacterTable_ENG_Lower[y][x];
}

u16 NameMenu__GetCharacter_ENG_Upper(s32 x, s32 y)
{
    return NameMenu__CharacterTable_ENG_Upper[y][x];
}

u16 NameMenu__GetCharacter_Latin(s32 x, s32 y)
{
    return NameMenu__CharacterTable_Latin[y][x];
}

u16 NameMenu__GetCharacter_Symbols(s32 x, s32 y)
{
    return NameMenu__CharacterTable_Symbols[y][x];
}

u16 NameMenu__GetCharacter_Icons(s32 x, s32 y)
{
    return NameMenu__CharacterTable_Icons[y][x];
}

char16 NameMenu__GetCharacterFromIndex(char16 character)
{
    // go through each page to find the font character
    s32 page  = 0;
    s32 count = 56;
    while (page < count)
    {
        s32 nextID = ((page + count) >> 1) + ((page + count) & 1);
        if (NameMenu__utfCharOffset[nextID] <= character)
            page = nextID;
        else
            count = nextID - 1;
    }

    // return font character
    s32 fontChar = character - NameMenu__utfCharOffset[page];
    if (fontChar >= NameMenu__fontCharPageSize[page])
        return ' ';
    else
        return fontChar + NameMenu__fontCharOffset[page];
}

char16 NameMenu__Func_2160DDC(char16 character)
{
    if (character >= 392)
        return 0xFFFF;

    return _02162034[character];
}

char16 NameMenu__Func_2160DF8(char16 character)
{
    if (character >= 392)
        return 0xFFFF;

    return _02162344[character];
}

char16 NameMenu__Func_2160E14(char16 character)
{
    if (character >= 392)
        return 0xFFFF;

    return _02162654[character];
}

u16 NameMenu__GetNameLength(SavePlayerName *name, s32 maxLength)
{
    s32 length;

    s32 startLength = maxLength - 1;
    length          = startLength;

    while (length >= 0)
    {
        if (name->text[length] != '\0')
            break;

        length--;
    }

    return maxLength - (startLength - length);
}

#include <nitro/codereset.h>