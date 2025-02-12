#include <stage/core/titleCard.h>
#include <stage/core/hud.h>
#include <stage/core/stageStart.h>
#include <stage/objects/startPlatform.h>
#include <game/graphics/renderCore.h>
#include <game/system/sysEvent.h>
#include <game/object/objDraw.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/drawFadeTask.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapSys.h>
#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct TitleCardAnimConfig_
{
    u8 animID;
    u8 oamOrder;
    u16 flags;
} TitleCardAnimConfig;

// --------------------
// VARIABLES
// --------------------

static void *commonSprites;
static void *archiveStage;
static Task *titleCardTask;

NOT_DECOMPILED TitleCardAnimConfig _0210DFA0[4];
NOT_DECOMPILED TitleCardAnimConfig _0210DFB0[7];
NOT_DECOMPILED Vec2Fx16 _0210DFCC[5];
NOT_DECOMPILED TitleCardAnimConfig _0210DFE0[5];
NOT_DECOMPILED Vec2Fx16 _0210DFF4[5];

// --------------------
// FUNCTIONS
// --------------------

// Assets
void TitleCard__LoadCommonArchive(NNSiFndArchiveHeader *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "sdm", archive);
    commonSprites = NNS_FndGetArchiveFileByName("sdm:/stdm_com.bac");
    NNS_FndUnmountArchive(&arc);
}

void TitleCard__ReleaseCommonArchive(void)
{
    commonSprites = NULL;
}

void TitleCard__LoadStageArchive(NNSiFndArchiveHeader *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "sdm", archive);
    void *filePtr = NNS_FndGetArchiveFileByIndex(&arc, ARC_MAP_FILE_TITLECARD_STAGE);
    archiveStage  = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(filePtr));
    RenderCore_CPUCopyCompressed(filePtr, archiveStage);
    NNS_FndUnmountArchive(&arc);
}

void TitleCard__ReleaseStageArchive(void)
{
    if (archiveStage != NULL)
    {
        HeapFree(HEAP_USER, archiveStage);
        archiveStage = NULL;
    }
}

// Titlecard
void TitleCard__Create(void)
{
    Task *task    = TaskCreate(TitleCard__Main, TitleCard__Destructor, TASK_FLAG_NONE, 2, TASK_PRIORITY_UPDATE_LIST_START + 0x109E, TASK_GROUP(3), TitleCard);
    titleCardTask = task;

    TitleCard *work = TaskGetWork(task, TitleCard);
    TaskInitWork16(work);

    work->progress       = TITLECARD_PROGRESS_WAITING_TITLECARD_START;
    work->state          = TitleCard__State_Init;
    work->nameplateScale = FLOAT_TO_FX32(1.0);

    TitleCard__LoadSprites(work);
    InitGameSystemForStage();
    TitleCard__InitAnimators(work);

    StartPlatform *platform;
    switch (GetStageStartType())
    {
        case STAGESTART_STARTPLATFORM:
            // spawn a start platform
            platform = SpawnStageObject(MAPOBJECT_319, playerGameStatus.spawnPosition.x, playerGameStatus.spawnPosition.y, StartPlatform);
            // UNUSED(platform);
            break;

        case STAGESTART_GROUND:
            CreateStageStart();
            break;

        case STAGESTART_FADEIN:
            work->finishedSequence = TRUE;

            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(1.0));
            gPlayer->playerFlag &= ~PLAYER_FLAG_DISABLE_INPUT_READ;
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
            SetHUDVisible(FALSE);

            RequestSysEventChange(0); // SYSEVENT_STAGE_ACTIVE
            NextSysEvent();
            break;
    }
}

TitleCardProgress TitleCard__GetProgress(void)
{
    if (titleCardTask != NULL)
        return TitleCard__GetWork()->progress;
    else
        return TITLECARD_PROGRESS_INITIAL;
}

void TitleCard__SetAllowContinue(void)
{
    TitleCard *work = TitleCard__GetWork();
    work->flags |= TITLECARD_FLAG_CAN_CONTINUE;
}

void TitleCard__SetFinished(void)
{
    TitleCard *work = TitleCard__GetWork();
    work->flags |= TITLECARD_FLAG_IS_FINISHED;
}

TitleCard *TitleCard__GetWork(void)
{
    return TaskGetWork(titleCardTask, TitleCard);
}

void TitleCard__LoadSprites(TitleCard *work)
{
    work->commonSprites = commonSprites;

    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "sde", archiveStage);
    work->zoneSprites = NNS_FndGetArchiveFileByIndex(&arc, ARC_STDM_FILE_STAGE_SPRITES);
    NNS_FndUnmountArchive(&arc);
}

NONMATCH_FUNC void TitleCard__InitAnimators(TitleCard *work)
{
    // https://decomp.me/scratch/1Vekh -> 98.26%
#ifdef NON_MATCHING
    static TitleCardAnimConfig readyGoTextConfig[] = {
        {
            .animID   = TITLECARD_ANI_READY_TEXT,
            .oamOrder = SPRITE_ORDER_0,
            .flags    = 0x77,
        },

        {
            .animID   = TITLECARD_ANI_GO_TEXT,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x77,
        },
    };

    static TitleCardAnimConfig actBannerConfig[] = {
        {
            .animID   = TITLECARD_STAGEANI_SUBTITLE,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_STAGEANI_ACTNUM,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },
    };

    static TitleCardAnimConfig nameplateConfig[] = {
        {
            .animID   = TITLECARD_STAGEANI_NAMEPLATE,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_STAGEANI_ZONEICON,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },
    };

    static TitleCardAnimConfig sonicNameLetterConfig[] = {
        {
            .animID   = TITLECARD_ANI_NAMELETTER_S,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_O,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_N,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_I,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_C,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },
    };

    static Vec2Fx16 blazeNameLetterPositions[] = {
        { -76, 51 }, { -52, 51 }, { -28, 51 }, { -4, 51 }, { 20, 51 },
    };

    static TitleCardAnimConfig blazeNameLetterConfig[] = {
        {
            .animID   = TITLECARD_ANI_NAMELETTER_B,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_L,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_A,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_Z,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },

        {
            .animID   = TITLECARD_ANI_NAMELETTER_E,
            .oamOrder = SPRITE_ORDER_2,
            .flags    = 0x79,
        },
    };

    static Vec2Fx16 sonicNameLetterPositions[] = {
        { -76, 51 }, { -52, 51 }, { -28, 51 }, { -4, 51 }, { 20, 51 },
    };

    s32 i;
    VRAMPaletteKey vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_A]);

    for (i = 0; i < 2; i++)
    {
        TitleCardAnimConfig *config = &nameplateConfig[i];
        AnimatorSprite *aniNameplate = &work->aniNameplate[i];

        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize2FromAnim(work->zoneSprites, config->animID));
        AnimatorSprite__Init(aniNameplate, work->zoneSprites, config->animID,
                             ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_PALETTES, 0, PIXEL_MODE_SPRITE,
                             vramPixels, PALETTE_MODE_SPRITE, vramPalette,
                             SPRITE_PRIORITY_0, config->oamOrder);
        aniNameplate->cParam.palette = ObjDrawAllocSpritePalette(work->zoneSprites, config->animID, config->flags);
        ObjDraw__TintPaletteColors(aniNameplate->cParam.palette, 0, 15, 0, 0, 0);
        AnimatorSprite__ProcessAnimationFast(aniNameplate);
    }

    for (i = 0; i < 2; i++)
    {
        TitleCardAnimConfig *config = &actBannerConfig[i];
        AnimatorSprite *aniActBanner = &work->aniActBanner[i];

        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize2FromAnim(work->zoneSprites, config->animID));
        AnimatorSprite__Init(aniActBanner, work->zoneSprites, config->animID,
                             ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_PALETTES, 0, PIXEL_MODE_SPRITE,
                             vramPixels, PALETTE_MODE_SPRITE, vramPalette,
                             SPRITE_PRIORITY_0, config->oamOrder);
        aniActBanner->cParam.palette = ObjDrawAllocSpritePalette(work->zoneSprites, config->animID, config->flags);
        ObjDraw__TintPaletteColors(aniActBanner->cParam.palette, 0, 15, 0, 0, 0);
    }

    TitleCardAnimConfig *nameLetterConfig;
    if (gameState.characterID[0] == CHARACTER_SONIC)
    {
        work->nameLetterCount     = 5;
        work->nameLetterPositions = sonicNameLetterPositions;

        nameLetterConfig = sonicNameLetterConfig;
    }
    else
    {
        work->nameLetterCount     = 5;
        work->nameLetterPositions = blazeNameLetterPositions;

        nameLetterConfig = blazeNameLetterConfig;
    }

    for (i = 0; i < work->nameLetterCount; i++)
    {
        AnimatorSprite *aniNameLetter = &work->aniNameLetters[i];

        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize2FromAnim(work->commonSprites, nameLetterConfig[i].animID));
        AnimatorSprite__Init(aniNameLetter, work->commonSprites, nameLetterConfig[i].animID,
                             ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_PALETTES, 0, PIXEL_MODE_SPRITE,
                             vramPixels, PALETTE_MODE_SPRITE,
                             vramPalette, SPRITE_PRIORITY_0, nameLetterConfig[i].oamOrder);
        aniNameLetter->cParam.palette = ObjDrawAllocSpritePalette(work->commonSprites, nameLetterConfig[i].animID, nameLetterConfig[i].flags);
        ObjDraw__TintPaletteColors(aniNameLetter->cParam.palette, 0, 15, 0, 0, 0);
    }

    work->flags |= TITLECARD_FLAG_LOADED_MAIN_SPRITES;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r6, #0
	mov r10, r0
	ldr r9, [r1, r6, lsl #2]
	ldr r7, =_0210DFB0
	add r8, r10, #0x1c
	mov r5, r6
	mov r4, r6
	mov r11, #0xa10
_0200762C:
	ldrb r1, [r7, #0]
	ldr r0, [r10, #4]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r9, [sp, #0x10]
	str r4, [sp, #0x14]
	ldrb r1, [r7, #1]
	mov r0, r8
	mov r3, r11
	str r1, [sp, #0x18]
	ldrb r2, [r7, #0]
	ldr r1, [r10, #4]
	bl AnimatorSprite__Init
	ldrb r1, [r7, #0]
	ldrsh r2, [r7, #2]
	ldr r0, [r10, #4]
	bl ObjDrawAllocSpritePalette
	strh r0, [r8, #0x50]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, #0
	ldrh r0, [r8, #0x50]
	mov r2, #0xf
	mov r3, r1
	bl ObjDraw__TintPaletteColors
	mov r1, #0
	mov r0, r8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r7, r7, #4
	add r8, r8, #0x64
	cmp r6, #2
	blt _0200762C
	mov r8, #0
	ldr r6, =0x0210DFA8
	add r7, r10, #0xec
	mov r5, r8
	mov r4, r8
	mov r11, #0xa10
_020076E8:
	ldrb r1, [r6, #0]
	ldr r0, [r10, #4]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r9, [sp, #0x10]
	str r4, [sp, #0x14]
	ldrb r1, [r6, #1]
	mov r0, r7
	mov r3, r11
	str r1, [sp, #0x18]
	ldrb r2, [r6, #0]
	ldr r1, [r10, #4]
	bl AnimatorSprite__Init
	ldrb r1, [r6, #0]
	ldrsh r2, [r6, #2]
	ldr r0, [r10, #4]
	bl ObjDrawAllocSpritePalette
	strh r0, [r7, #0x50]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, #0
	ldrh r0, [r7, #0x50]
	mov r2, #0xf
	mov r3, r1
	bl ObjDraw__TintPaletteColors
	add r8, r8, #1
	add r6, r6, #4
	add r7, r7, #0x64
	cmp r8, #2
	blt _020076E8
	ldr r0, =gameState
	mov r2, #5
	ldr r0, [r0, #4]
	cmp r0, #0
	add r0, r10, #0x300
	bne _020077A8
	ldr r1, =_0210DFF4
	strh r2, [r0, #0xa8]
	str r1, [r10, #0x3ac]
	ldr r6, =0x0210DFB8
	b _020077B8
_020077A8:
	ldr r1, =_0210DFCC
	strh r2, [r0, #0xa8]
	ldr r6, =_0210DFE0
	str r1, [r10, #0x3ac]
_020077B8:
	add r4, r10, #0x300
	ldrh r0, [r4, #0xa8]
	mov r8, #0
	cmp r0, #0
	ble _02007874
	add r7, r10, #0x1b4
	mov r11, r8
	mov r5, r8
_020077D8:
	ldrb r1, [r6, r8, lsl #2]
	ldr r0, [r10, #0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, r11
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	str r9, [sp, #0x10]
	str r5, [sp, #0x14]
	add r0, r6, r8, lsl #2
	ldrb r1, [r0, #1]
	mov r0, r7
	mov r3, #0xa10
	str r1, [sp, #0x18]
	ldrb r2, [r6, r8, lsl #2]
	ldr r1, [r10, #0]
	bl AnimatorSprite__Init
	add r2, r6, r8, lsl #2
	ldrb r1, [r6, r8, lsl #2]
	ldrsh r2, [r2, #2]
	ldr r0, [r10, #0]
	bl ObjDrawAllocSpritePalette
	strh r0, [r7, #0x50]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, #0
	ldrh r0, [r7, #0x50]
	mov r2, #0xf
	mov r3, r1
	bl ObjDraw__TintPaletteColors
	ldrh r0, [r4, #0xa8]
	add r8, r8, #1
	add r7, r7, #0x64
	cmp r8, r0
	blt _020077D8
_02007874:
	ldr r0, [r10, #0x18]
	orr r0, r0, #TITLECARD_FLAG_LOADED_MAIN_SPRITES
	str r0, [r10, #0x18]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void TitleCard__DestroyAnimators(TitleCard *work)
{
    if ((work->flags & TITLECARD_FLAG_LOADED_MAIN_SPRITES) != 0)
    {
        s32 i;

        for (i = 0; i < 2; i++)
        {
            ObjDrawReleaseSpritePalette(work->aniNameplate[i].cParam.palette);
            AnimatorSprite__Release(&work->aniNameplate[i]);
        }

        for (i = 0; i < 2; i++)
        {
            ObjDrawReleaseSpritePalette(work->aniActBanner[i].cParam.palette);
            AnimatorSprite__Release(&work->aniActBanner[i]);
        }

        for (i = 0; i < work->nameLetterCount; i++)
        {
            ObjDrawReleaseSpritePalette(work->aniNameLetters[i].cParam.palette);
            AnimatorSprite__Release(&work->aniNameLetters[i]);
        }

        work->flags &= ~TITLECARD_FLAG_LOADED_MAIN_SPRITES;
    }
}

NONMATCH_FUNC void TitleCard__InitReadyGoAnimators(TitleCard *work)
{
    // https://decomp.me/scratch/xvHUQ -> 99.40%
#ifdef NON_MATCHING
    AnimatorSprite *aniGo;

    void *vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_A]);

    aniGo                   = &work->aniGo;
    VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2FromAnim(work->commonSprites, 0));
    AnimatorSprite__Init(aniGo, work->commonSprites, TITLECARD_ANI_GO_TEXT, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_PALETTES,
                         0, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    aniGo->cParam.palette = ObjDrawAllocSpritePalette(work->commonSprites, TITLECARD_ANI_GO_TEXT, 0x77);
    ObjDraw__TintPaletteColors(aniGo->cParam.palette, 0, 15, 0, 0, 0);
    aniGo->pos.x = 128;
    aniGo->pos.y = 64;

    AnimatorSprite *aniReady = &work->aniReady;
    vramPixels               = VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2FromAnim(work->commonSprites, 1));
    AnimatorSprite__Init(aniReady, work->commonSprites, TITLECARD_ANI_READY_TEXT,
                         ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_PALETTES, 0, PIXEL_MODE_SPRITE, vramPixels,
                         PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    aniReady->cParam.palette = ObjDrawAllocSpritePalette(work->commonSprites, TITLECARD_ANI_READY_TEXT, 0x77);
    ObjDraw__TintPaletteColors(aniReady->cParam.palette, 0, 15, 0, 0, 0);
    aniReady->pos.x = 128;
    aniReady->pos.y = 64;

    work->flags |= TITLECARD_FLAG_LOADED_READYGO_SPRITES;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r2, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #0
	add r5, r4, #0x3b0
	ldr r6, [r2, r1, lsl #2]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	str r6, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r1, [r4, #0]
	mov r0, r5
	mov r3, #0xa10
	bl AnimatorSprite__Init
	ldr r0, [r4, #0]
	mov r1, #0
	mov r2, #0x77
	bl ObjDrawAllocSpritePalette
	strh r0, [r5, #0x50]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldrh r0, [r5, #0x50]
	mov r2, #0xf
	mov r3, r1
	bl ObjDraw__TintPaletteColors
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x40
	strh r0, [r5, #0xa]
	add r0, r4, #0x14
	add r5, r0, #0x400
	ldr r0, [r4, #0]
	mov r1, #1
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r6, [sp, #0x10]
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r0, r5
	ldr r1, [r4, #0]
	mov r2, #1
	mov r3, #0xa10
	bl AnimatorSprite__Init
	ldr r0, [r4, #0]
	mov r1, #1
	mov r2, #0x77
	bl ObjDrawAllocSpritePalette
	mov r1, #0
	strh r0, [r5, #0x50]
	str r1, [sp]
	str r1, [sp, #4]
	ldrh r0, [r5, #0x50]
	mov r3, r1
	mov r2, #0xf
	bl ObjDraw__TintPaletteColors
	mov r0, #0x80
	strh r0, [r5, #8]
	mov r0, #0x40
	strh r0, [r5, #0xa]
	ldr r0, [r4, #0x18]
	orr r0, r0, #TITLECARD_FLAG_LOADED_READYGO_SPRITES
	str r0, [r4, #0x18]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

void TitleCard__DestroyReadyGoAnimators(TitleCard *work)
{
    if ((work->flags & TITLECARD_FLAG_LOADED_READYGO_SPRITES) != 0)
    {
        ObjDrawReleaseSpritePalette(work->aniReady.cParam.palette);
        AnimatorSprite__Release(&work->aniReady);

        ObjDrawReleaseSpritePalette(work->aniGo.cParam.palette);
        AnimatorSprite__Release(&work->aniGo);

        work->flags &= ~TITLECARD_FLAG_LOADED_READYGO_SPRITES;
    }
}

BOOL TitleCard__CheckIsFinished(TitleCard *work)
{
    if ((work->flags & TITLECARD_FLAG_IS_FINISHED) == 0)
        return FALSE;

    NNS_SndPlayerStopSeqBySeqArcIdx(SND_ZONE_SEQARC_GAME_SE, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TITLE, 0);
    NNS_SndPlayerStopSeqBySeqArcIdx(SND_ZONE_SEQARC_GAME_SE, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SONIC, 0);

    work->state = TitleCard__State_FinishExitNameplate;
    work->state(work);

    return TRUE;
}

void TitleCard__Main(void)
{
    TitleCard *work = TaskGetWorkCurrent(TitleCard);

    work->state(work);

    if (work->finishedSequence == FALSE)
    {
        TitleCard__Draw(work);
    }
    else
    {
        work->timer++;
        if (work->timer > 1)
        {
            DestroyCurrentTask();
            if (IsBossStage())
                LoadHUDAssets();
        }
    }
}

void TitleCard__Destructor(Task *task)
{
    TitleCard *work = TaskGetWork(task, TitleCard);

    TitleCard__DestroyAnimators(work);
    TitleCard__DestroyReadyGoAnimators(work);

    titleCardTask = NULL;
}

void TitleCard__Draw(TitleCard *work)
{
    static const BOOL zoneFlag[ZONE_COUNT] = {
        [ZONE_PLANT_KINGDOM] = FALSE, [ZONE_MACHINE_LABYRINTH] = TRUE, [ZONE_CORAL_CAVE] = FALSE, [ZONE_HAUNTED_SHIP] = TRUE, [ZONE_BLIZZARD_PEAKS] = FALSE,
        [ZONE_SKY_BABYLON] = TRUE,    [ZONE_PIRATES_ISLAND] = TRUE,    [ZONE_BIG_SWELL] = TRUE,   [ZONE_HIDDEN_ISLAND] = TRUE
    };

    s32 i;

    BOOL isVisible = TRUE;
    if (IsBossStage())
    {
        if (!zoneFlag[GetCurrentZoneID()])
        {
            if (!Camera3D__UseEngineA())
            {
                isVisible = FALSE;
            }
        }
        else
        {
            if (Camera3D__UseEngineA())
            {
                isVisible = FALSE;
            }
        }
    }

    AnimatorSprite *aniNamePlate = &work->aniNameplate[0];
    s16 x                        = aniNamePlate->pos.x;
    s16 y                        = aniNamePlate->pos.y;
    if ((work->flags & TITLECARD_FLAG_DRAW_NAMEPLATE) != 0)
    {
        for (i = 0; i < 2; i++)
        {
            if (isVisible)
            {
                if ((work->flags & TITLECARD_FLAG_USE_ROTOZOOM_NAMEPLATE) != 0)
                    AnimatorSprite__DrawFrameRotoZoom(&work->aniNameplate[i], work->nameplateScale, work->nameplateScale, work->nameplateRotation);
                else
                    AnimatorSprite__DrawFrame(&work->aniNameplate[i]);
            }
        }
    }

    if (GetGameLanguage() == OS_LANGUAGE_JAPANESE && (work->flags & TITLECARD_FLAG_DRAW_JP_ZONE_NAME) != 0)
    {
        AnimatorSprite *aniActBanner = &work->aniActBanner[0];

        aniActBanner->pos.x = x;
        aniActBanner->pos.y = y - 48;
        AnimatorSprite__ProcessAnimationFast(aniActBanner);

        if (isVisible)
            AnimatorSprite__DrawFrame(aniActBanner);
    }

    if ((work->flags & TITLECARD_FLAG_DRAW_ACT_NUM) != 0)
    {
        AnimatorSprite *aniActNum = &work->aniActBanner[1];

        aniActNum->pos.x = x + 32;
        aniActNum->pos.y = y + 28;
        AnimatorSprite__ProcessAnimationFast(aniActNum);

        if (isVisible)
            AnimatorSprite__DrawFrame(aniActNum);
    }

    if ((work->flags & TITLECARD_FLAG_DRAW_PLAYER_NAME) != 0)
    {
        for (i = 0; i < work->nameLetterCount; i++)
        {
            AnimatorSprite *aniNameLetter = &work->aniNameLetters[i];

            aniNameLetter->pos.x = x + work->nameLetterPositions[i].x;
            aniNameLetter->pos.y = y + work->nameLetterPositions[i].y;
            AnimatorSprite__ProcessAnimationFast(aniNameLetter);

            if (isVisible)
                AnimatorSprite__DrawFrame(aniNameLetter);
        }
    }

    if ((work->flags & TITLECARD_FLAG_DRAW_GO_TEXT) != 0)
    {
        AnimatorSprite *aniGo = &work->aniGo;

        AnimatorSprite__ProcessAnimationFast(aniGo);

        if (isVisible)
            AnimatorSprite__DrawFrame(aniGo);
    }

    if ((work->flags & TITLECARD_FLAG_DRAW_READY_TEXT) != 0)
    {
        AnimatorSprite *aniReady = &work->aniReady;

        AnimatorSprite__ProcessAnimationFast(aniReady);

        if (isVisible)
            AnimatorSprite__DrawFrame(aniReady);
    }
}

void TitleCard__State_Init(TitleCard *work)
{
    work->state = TitleCard__State_AwaitInitialContinue;
    work->state(work);
}

void TitleCard__State_AwaitInitialContinue(TitleCard *work)
{
    work->progress = TITLECARD_PROGRESS_WAITING_TITLECARD_START;

    if ((work->flags & TITLECARD_FLAG_CAN_CONTINUE) != 0)
    {
        work->flags &= ~TITLECARD_FLAG_CAN_CONTINUE;
        work->state = TitleCard__State_BeginEnterNameplate;
        work->state(work);
    }
}

void TitleCard__State_BeginEnterNameplate(TitleCard *work)
{
    work->progress = TITLECARD_PROGRESS_SHOWING_TITLE_CARD;
    work->flags |= TITLECARD_FLAG_USE_ROTOZOOM_NAMEPLATE | TITLECARD_FLAG_DRAW_NAMEPLATE;
    work->field_478 = 0;
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TITLE);

    work->state = TitleCard__State_EnterNameplate;
    work->state(work);
}

NONMATCH_FUNC void TitleCard__State_EnterNameplate(TitleCard *work)
{
    // https://decomp.me/scratch/zO2eq -> 93.82%
#ifdef NON_MATCHING
    BOOL finished = FALSE;

    if (!TitleCard__CheckIsFinished(work))
    {
        work->field_478 += FLOAT_TO_FX32(0.022216796875);
        if (work->field_478 >= FLOAT_TO_FX32(1.0))
        {
            work->field_478 = FLOAT_TO_FX32(1.0);
            finished        = TRUE;
        }

        s16 x = 128;
        s16 y = FX32_TO_WHOLE(MultiplyFX(FLOAT_TO_FX32(176.0), work->field_478) - FLOAT_TO_FX32(96.0));

        for (s32 i = 0; i < 2; i++)
        {
            AnimatorSprite *aniNameplate = &work->aniNameplate[i];

            aniNameplate->pos.x = x;
            aniNameplate->pos.y = y;
        }

        work->nameplateRotation = FX32_TO_WHOLE(MultiplyFX(-FLOAT_TO_FX32(196608.0), work->field_478) + FLOAT_TO_FX32(196608.0));
        work->nameplateScale    = (MultiplyFX(work->field_478, -FLOAT_TO_FX32(0.8))) + FLOAT_TO_FX32(1.8);

        if (finished)
        {
            work->flags &= ~TITLECARD_FLAG_USE_ROTOZOOM_NAMEPLATE;
            work->state = TitleCard__State_BeginShowPlayerName;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, #0
	bl TitleCard__CheckIsFinished
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x400
	ldrsh r1, [r0, #0x78]
	mov ip, #0
	add r1, r1, #0x5b
	strh r1, [r0, #0x78]
	ldrsh r1, [r0, #0x78]
	cmp r1, #0x1000
	movge r1, #0x1000
	strgeh r1, [r0, #0x78]
	add r0, r5, #0x400
	ldrsh r1, [r0, #0x78]
	mov r0, #0xb0000
	movge r4, #1
	umull r3, r2, r1, r0
	mla r2, r1, ip, r2
	mov r1, r1, asr #0x1f
	mla r2, r1, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	sub r0, r1, #0x60000
	mov r0, r0, lsl #4
	mov r1, r0, asr #0x10
	add r2, r5, #0x1c
	mov r0, #0x80
_02007F80:
	strh r0, [r2, #8]
	add ip, ip, #1
	strh r1, [r2, #0xa]
	cmp ip, #2
	add r2, r2, #0x64
	blt _02007F80
	add r1, r5, #0x400
	ldrsh r3, [r1, #0x78]
	mov r0, #0xd0000000
	mvn r2, #0
	umull lr, ip, r3, r0
	mla ip, r3, r2, ip
	mov r3, r3, asr #0x1f
	mla ip, r3, r0, ip
	adds lr, lr, #0x800
	adc r0, ip, #0
	mov r3, lr, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, r3, #0x30000000
	mov r0, r0, asr #0xc
	strh r0, [r5, #0xe8]
	ldrsh r1, [r1, #0x78]
	ldr r0, =0xFFFFF334
	umull ip, r3, r1, r0
	mla r3, r1, r2, r3
	mov r1, r1, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xcc
	add r0, r0, #0x1c00
	str r0, [r5, #0xe4]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0x18]
	ldr r0, =TitleCard__State_BeginShowPlayerName
	bic r1, r1, #0x40
	str r1, [r5, #0x18]
	str r0, [r5, #0xc]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void TitleCard__State_BeginShowPlayerName(TitleCard *work)
{
    work->flags |= TITLECARD_FLAG_DRAW_PLAYER_NAME | TITLECARD_FLAG_DRAW_ACT_NUM | TITLECARD_FLAG_DRAW_JP_ZONE_NAME;

    work->timer2    = 0;
    work->field_47C = 0;

    work->state = TitleCard__State_ShowPlayerName;
    work->state(work);
}

void TitleCard__State_ShowPlayerName(TitleCard *work)
{
    u32 timer = work->field_47C++;

    if (timer == 15)
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SONIC);

    if (!TitleCard__CheckIsFinished(work) && (work->aniNameLetters[work->nameLetterCount - 1].flags & ANIMATOR_FLAG_DID_FINISH) != 0)
    {
        timer = work->timer2++;
        if (timer > 45)
            work->state = TitleCard__State_BeginNameplateExit;
    }
}

void TitleCard__State_BeginNameplateExit(TitleCard *work)
{
    work->field_478 = 0;

    work->state = TitleCard__State_ExitNameplate;
    work->state(work);
}

NONMATCH_FUNC void TitleCard__State_ExitNameplate(TitleCard *work)
{
    // https://decomp.me/scratch/xldC7 -> 99.14%
#ifdef NON_MATCHING
    s32 i;

    BOOL done = FALSE;

    if (!TitleCard__CheckIsFinished(work))
    {
        work->field_478 += FLOAT_TO_FX32(0.025);

        if (work->field_478 >= FLOAT_TO_FX32(1.0))
        {
            work->field_478 = FLOAT_TO_FX32(1.0);
            done            = TRUE;
        }

        s16 x = FX32_TO_WHOLE(mtLerpEx2(work->field_478, FLOAT_TO_FX32(128.0), -FLOAT_TO_FX32(256.0), 1));
        s16 y = FX32_TO_WHOLE(mtLerpEx2(work->field_478, FLOAT_TO_FX32(80.0), FLOAT_TO_FX32(80.0), 1));

        for (i = 0; i < 2; i++)
        {
            AnimatorSprite *aniNameplate = &work->aniNameplate[i];

            aniNameplate->pos.x = x;
            aniNameplate->pos.y = y;
        }

        if (done)
            work->state = TitleCard__State_FinishExitNameplate;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	mov r4, #0
	bl TitleCard__CheckIsFinished
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r5, #0x400
	ldrsh r1, [r0, #0x78]
	mov r6, #0x100000
	rsb r6, r6, #0
	add r1, r1, #0x66
	strh r1, [r0, #0x78]
	ldrsh r1, [r0, #0x78]
	mov ip, #0
	cmp r1, #0x1000
	movge r1, #0x1000
	strgeh r1, [r0, #0x78]
	add r0, r5, #0x400
	ldrsh r3, [r0, #0x78]
	movge r4, #1
	mov r0, #1
	mov r2, r3, asr #0x1f
	mov r1, #0x800
_02008188:
	sub r6, r6, #0x80000
	umull r8, r7, r6, r3
	mla r7, r6, r2, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, r3, r7
	adds r8, r8, r1
	adc r6, r7, ip
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r0, #0
	add r6, r7, #0x80000
	sub r0, r0, #1
	bne _02008188
	mov r0, r6, lsl #4
	mov r1, r0, asr #0x10
	mov r0, #1
	mov r6, #0x50000
	mov lr, #0
	mov ip, #0x800
_020081D4:
	sub r6, r6, #0x50000
	umull r8, r7, r6, r3
	mla r7, r6, r2, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, r3, r7
	adds r8, r8, ip
	adc r6, r7, lr
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r0, #0
	add r6, r7, #0x50000
	sub r0, r0, #1
	bne _020081D4
	mov r0, r6, lsl #4
	mov r2, r0, asr #0x10
	add r3, r5, #0x1c
	mov r0, #0
_02008218:
	strh r1, [r3, #8]
	add r0, r0, #1
	strh r2, [r3, #0xa]
	cmp r0, #2
	add r3, r3, #0x64
	blt _02008218
	cmp r4, #0
	ldrne r0, =TitleCard__State_FinishExitNameplate
	strne r0, [r5, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void TitleCard__State_FinishExitNameplate(TitleCard *work)
{
    TitleCard__DestroyAnimators(work);

    work->flags &= ~(TITLECARD_FLAG_DRAW_PLAYER_NAME | TITLECARD_FLAG_DRAW_ACT_NUM | TITLECARD_FLAG_DRAW_JP_ZONE_NAME | TITLECARD_FLAG_DRAW_NAMEPLATE);

    work->state = TitleCard__State_BeginShowReadyText;
}

void TitleCard__State_BeginShowReadyText(TitleCard *work)
{
    work->progress = TITLECARD_PROGRESS_SHOWING_READY_TEXT;

    TitleCard__InitReadyGoAnimators(work);

    work->flags |= TITLECARD_FLAG_DRAW_READY_TEXT;
    work->timer2 = 0;

    work->state = TitleCard__State_ShowReadyText;
}

void TitleCard__State_ShowReadyText(TitleCard *work)
{
    if ((work->aniReady.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
    {
        // player start voice clip
        enum SND_ZONE_SEQARC_GAME_SE voiceStageStart = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GO;
        if (gPlayer->characterID != CHARACTER_SONIC)
            voiceStageStart = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_NEVER;

        PlayStageSfx(voiceStageStart);

        work->state = TitleCard__State_AwaitFurtherContinue;
        work->state(work);
    }
}

void TitleCard__State_AwaitFurtherContinue(TitleCard *work)
{
    work->progress = TITLECARD_PROGRESS_WAITING_TITLECARD_COMPLETE;

    if ((work->flags & TITLECARD_FLAG_CAN_CONTINUE) != 0)
    {
        work->flags &= ~TITLECARD_FLAG_CAN_CONTINUE;

        work->state = TitleCard__State_BeginShowGoText;
        work->state(work);
    }
}

void TitleCard__State_BeginShowGoText(TitleCard *work)
{
    work->progress = TITLECARD_PROGRESS_SHOWING_GO_TEXT;

    work->flags = work->flags & ~TITLECARD_FLAG_DRAW_READY_TEXT | TITLECARD_FLAG_DRAW_GO_TEXT;
    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FREEZE_TIME;

    SetHUDVisible(FALSE);

    work->timer2 = 0;
    work->state  = TitleCard__State_ShowGoText;
}

void TitleCard__State_ShowGoText(TitleCard *work)
{
    if ((work->aniReady.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
    {
        u32 timer = work->timer2++;
        if (timer > 120)
            work->finishedSequence = TRUE;
    }
}
