#include <seaMap/seaMapCutscene.h>
#include <seaMap/seaMapView.h>
#include <game/graphics/renderCore.h>
#include <game/audio/audioSystem.h>
#include <game/system/sysEvent.h>
#include <game/game/gameState.h>
#include <game/input/padInput.h>
#include <game/file/binaryBundle.h>

// resources
#include <resources/bb/tkdm_down.h>

// --------------------
// TYPES
// --------------------

typedef void (*SeaMapCutsceneStateFunc)(SeaMapCutscene *work);

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapCutscene_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData);
static void InitDisplayForSeaMapCutscene(void);
static void SeaMapCutscene_Main_FadeIn(void);
static void SeaMapCutscene_Main_Active(void);
static void SeaMapCutscene_Main_FadeOut(void);
static void SeaMapCutscene_Destructor(Task *task);
static CHEVObject *GetIslandIconForSeaMapCutscene(void);

// Coral Cave states
static void SeaMapCutscene_State_InitCoralCave(SeaMapCutscene *work);
static void SeaMapCutscene_StateAlways_CoralCave(SeaMapCutscene *work);
static void SeaMapCutscene_State_WaitForCoralCaveAppear(SeaMapCutscene *work);
static void SeaMapCutscene_State_CoralCaveAppear(SeaMapCutscene *work);
static void SeaMapCutscene_State_CoralCaveAppeared(SeaMapCutscene *work);

// Sky Babylon states
static void SeaMapCutscene_State_InitSkyBabylon(SeaMapCutscene *work);
static void SeaMapCutscene_StateAlways_SkyBabylon(SeaMapCutscene *work);
static void SeaMapCutscene_State_WaitForSkyBabylonAppear(SeaMapCutscene *work);
static void SeaMapCutscene_State_SkyBabylonAppear(SeaMapCutscene *work);
static void SeaMapCutscene_State_SkyBabylonAppeared(SeaMapCutscene *work);
static void SeaMapCutscene_State_SkyBabylonBoatLaunch(SeaMapCutscene *work);
static void SeaMapCutscene_State_BoatBounceUpwardsTowardsSkyBabylon(SeaMapCutscene *work);
static void SeaMapCutscene_State_BoatLaunchingToSkyBabylon(SeaMapCutscene *work);
static void SeaMapCutscene_State_LaunchedToSkyBabylon(SeaMapCutscene *work);

// --------------------
// VARIABLES
// --------------------

static const u16 sprPressStartTextFiles[8] = {
    [OS_LANGUAGE_JAPANESE] = BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_MSG_JPN_BAC, [OS_LANGUAGE_ENGLISH] = BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_MSG_ENG_BAC,
    [OS_LANGUAGE_FRENCH] = BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_MSG_FRA_BAC,   [OS_LANGUAGE_GERMAN] = BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_MSG_DEU_BAC,
    [OS_LANGUAGE_ITALIAN] = BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_MSG_ITA_BAC,  [OS_LANGUAGE_SPANISH] = BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_MSG_SPA_BAC,
};

static const SeaMapCutsceneStateFunc startStateForType[] = {
    SeaMapCutscene_State_InitCoralCave,
    SeaMapCutscene_State_InitSkyBabylon,
};

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapCutscene(void)
{
    Task *task;
    SeaMapCutscene *work;

    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sb1/sound_data.sdat");
    NNS_SndArcLoadSeqArc(SND_SAIL_SEQARC_ARC_VOYAGE_SE, audioManagerSndHeap);
    NNS_SndArcLoadBank(SND_SAIL_BANK_BANK_VOYAGE_SE, audioManagerSndHeap);

    InitDisplayForSeaMapCutscene();

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    RenderCoreGFXControl *gfxControlA = VRAMSystem__GFXControl[GRAPHICS_ENGINE_A];
    gfxControlA->brightness           = RENDERCORE_BRIGHTNESS_BLACK;

    RenderCoreGFXControl *gfxControlB = VRAMSystem__GFXControl[GRAPHICS_ENGINE_B];
    gfxControlB->brightness           = RENDERCORE_BRIGHTNESS_BLACK;

    task = TaskCreate(SeaMapCutscene_Main_FadeIn, SeaMapCutscene_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFF, TASK_GROUP(0), SeaMapCutscene);

    work = TaskGetWork(task, SeaMapCutscene);
    TaskInitWork16(work);

    work->flags       = 0;
    work->brightness  = gfxControlA->brightness;
    work->stateActive = startStateForType[SeaMapManager__GetUnknown1()];

    TouchField__Init(&work->touchField);
    work->touchField.mode      = FALSE;
    work->touchField.rectSize2 = 0;

    work->bgCutscene          = ReadFileFromBundle("bb/tkdm_down.bb", BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_BG_BBG, BINARYBUNDLE_AUTO_ALLOC_HEAD);
    work->sprPressStartButton = ReadFileFromBundle("bb/tkdm_down.bb", BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_CMN_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
    work->sprPressStartText   = ReadFileFromBundle("bb/tkdm_down.bb", sprPressStartTextFiles[GetGameLanguage()], BINARYBUNDLE_AUTO_ALLOC_HEAD);

    seaMapViewMode     = 2;
    seaMapViewUnknown1 = 0;

    SeaMapManager__Create(FALSE, SHIP_MENU, FALSE);

    gfxControlA->brightness = work->brightness;
    SeaMapManager__EnableTouchField(FALSE);
    SeaMapManager__Func_2043D08();
    SeaMapEventManager__Create();

    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);

    gfxControlB->bgPosition[BACKGROUND_0].x = 0;
    gfxControlB->bgPosition[BACKGROUND_0].y = 0;

    Background background;
    InitBackground(&background, work->bgCutscene, BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    AnimatorSprite__Init(&work->aniPressStart, work->sprPressStartText, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, 0x40), PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_B]),
                         SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniPressStart.cParam.palette = PALETTE_ROW_0;

    AnimatorSprite__Init(&work->aniPressStartButton, work->sprPressStartButton, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetUnknown6(work->sprPressStartButton)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_B]), SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniPressStartButton.cParam.palette = PALETTE_ROW_1;

    HitboxRect rect;
    AnimatorSprite__GetBlockData(&work->aniPressStartButton, 0, &rect);
    TouchField__InitAreaShape(&work->touchArea, &work->aniPressStartButton.pos, TouchField__PointInRect, (TouchRectUnknown *)&rect, SeaMapCutscene_TouchAreaCallback, work);
    TouchField__AddArea(&work->touchField, &work->touchArea, 0);

    work->stateActive(work);

    ResetTouchInput();
}

void SeaMapCutscene_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData)
{
    SeaMapCutscene *work = (SeaMapCutscene *)userData;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_40000:
            if (work->aniPressStartButton.animID != 1)
            {
                AnimatorSprite__SetAnimation(&work->aniPressStartButton, 1);
                work->aniPressStartButton.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
                PlaySailSfx(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_T_DECIDE);
            }
            break;
    }
}

void InitDisplayForSeaMapCutscene(void)
{
    VRAMSystem__Reset();
    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_A);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    GX_SetVisiblePlane(GX_PLANEMASK_ALL);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
}

void SeaMapCutscene_Main_FadeIn(void)
{
    SeaMapCutscene *work = TaskGetWorkCurrent(SeaMapCutscene);

    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness--;
        renderCoreGFXControlB.brightness--;
    }
    else if (renderCoreGFXControlA.brightness < RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness++;
        renderCoreGFXControlB.brightness++;
    }
    else
    {
        SetCurrentTaskMainEvent(SeaMapCutscene_Main_Active);
    }

    work->stateAlways(work);
}

void SeaMapCutscene_Main_Active(void)
{
    SeaMapCutscene *work = TaskGetWorkCurrent(SeaMapCutscene);

    TouchField__Process(&work->touchField);

    work->stateActive(work);
    work->stateAlways(work);

    AnimatorSprite__ProcessAnimationFast(&work->aniPressStart);

    work->pressStartFlashTimer++;

    if ((work->aniPressStart.flags & ANIMATOR_FLAG_DISABLE_DRAW) != 0)
    {
        // wait 96 frames when the button is hidden
        if (work->pressStartFlashTimer >= 96)
            work->pressStartFlashTimer = 0;
    }
    else
    {
        // wait 64 frames when the button is visible
        if (work->pressStartFlashTimer >= 64)
            work->pressStartFlashTimer = 0;
    }

    if (work->pressStartFlashTimer == 0)
        work->aniPressStart.flags ^= ANIMATOR_FLAG_DISABLE_DRAW;

    AnimatorSprite__DrawFrame(&work->aniPressStart);

    AnimatorSprite__ProcessAnimationFast(&work->aniPressStartButton);
    AnimatorSprite__DrawFrame(&work->aniPressStartButton);

    if (work->aniPressStartButton.animID == 1)
    {
        if (work->pressedStartTimer++ > 30)
            SetCurrentTaskMainEvent(SeaMapCutscene_Main_FadeOut);
    }
    else
    {
        if ((padInput.btnPress & PAD_BUTTON_START) != 0)
        {
            AnimatorSprite__SetAnimation(&work->aniPressStartButton, 1);
            work->aniPressStartButton.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
            PlaySailSfx(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_T_DECIDE);
        }
    }
}

void SeaMapCutscene_Main_FadeOut(void)
{
    SeaMapCutscene *work = TaskGetWorkCurrent(SeaMapCutscene);

    if (work->brightness < renderCoreGFXControlA.brightness)
    {
        renderCoreGFXControlA.brightness--;
        renderCoreGFXControlB.brightness--;
    }
    else if (work->brightness > renderCoreGFXControlA.brightness)
    {
        renderCoreGFXControlA.brightness++;
        renderCoreGFXControlB.brightness++;
    }
    else
    {
        DestroyCurrentTask();
        SeaMapEventManager__Destroy();
        SeaMapManager__Destroy();
        RequestSysEventChange(0); // SYSEVENT_UPDATE_PROGRESS
        NextSysEvent();
        return;
    }

    work->stateAlways(work);
}

void SeaMapCutscene_Destructor(Task *task)
{
    SeaMapCutscene *work = TaskGetWork(task, SeaMapCutscene);

    AnimatorSprite__Release(&work->aniPressStart);
    AnimatorSprite__Release(&work->aniPressStartButton);

    HeapFree(HEAP_USER, work->bgCutscene);
    HeapFree(HEAP_USER, work->sprPressStartButton);
    HeapFree(HEAP_USER, work->sprPressStartText);

    ReleaseAudioSystem();
}

CHEVObject *GetIslandIconForSeaMapCutscene(void)
{
    CHEV *chev = SeaMapManager__GetWork()->assets.objectLayout;

    for (u16 i = 0; i < chev->count; i++)
    {
        CHEVObject *object = &chev->entries[i];
        s32 type           = SeaMapEventManager__GetObjectType(object);

        if ((s32)type == SEAMAPOBJECT_ISLAND_ICON_1 || type == SEAMAPOBJECT_ISLAND_ICON_2)
        {
            if ((object->flags2 & 1) == 0 && object->unlockID == 14)
                return object;
        }
    }

    return NULL;
}

void SeaMapCutscene_State_InitCoralCave(SeaMapCutscene *work)
{
    SeaMapManager__Func_2043974(FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(280.0));

    work->stateActive = SeaMapCutscene_State_WaitForCoralCaveAppear;
    work->stateAlways = SeaMapCutscene_StateAlways_CoralCave;

    MI_CpuClear16(&work->coralCave, sizeof(work->coralCave));
}

void SeaMapCutscene_StateAlways_CoralCave(SeaMapCutscene *work)
{
    // Do nothing.
}

void SeaMapCutscene_State_WaitForCoralCaveAppear(SeaMapCutscene *work)
{
    if (work->coralCave.timer++ > 60)
        work->stateActive = SeaMapCutscene_State_CoralCaveAppear;
}

void SeaMapCutscene_State_CoralCaveAppear(SeaMapCutscene *work)
{
    CHEVObject *obj        = SeaMapEventManager__GetObjectFromID(3);
    CHEVObject *islandIcon = GetIslandIconForSeaMapCutscene();

    SeaMapEventManager__CreateObject(SEAMAPOBJECT_ISLAND_ICON_1, islandIcon->position.x, islandIcon->position.y, 0, &islandIcon->box, 0);
    SeaMapEventManager__CreateObject(SEAMAPOBJECT_SPARKLES_1, obj->position.x, obj->position.y - 32, 0, NULL, 0);
    SeaMapEventManager__UnlockCoralCave();
    PlaySailSfx(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_GOAL);

    work->coralCave.timer = 0;
    work->stateActive     = SeaMapCutscene_State_CoralCaveAppeared;
}

void SeaMapCutscene_State_CoralCaveAppeared(SeaMapCutscene *work)
{
    if (work->coralCave.timer++ > 180)
        SetCurrentTaskMainEvent(SeaMapCutscene_Main_FadeOut);
}

void SeaMapCutscene_State_InitSkyBabylon(SeaMapCutscene *work)
{
    CHEVObject *obj = SeaMapEventManager__GetObjectFromID(6);
    SeaMapManager__Func_2043974(FX32_FROM_WHOLE(obj->position.x - HW_LCD_CENTER_X), FX32_FROM_WHOLE(obj->position.y - HW_LCD_CENTER_Y));

    work->stateActive = SeaMapCutscene_State_WaitForSkyBabylonAppear;
    work->stateAlways = SeaMapCutscene_StateAlways_SkyBabylon;

    MI_CpuClear16(&work->skyBabylon, sizeof(work->skyBabylon));

    CHEVObject *obj2 = SeaMapEventManager__GetObjectFromID(11);

    s32 unlockID = gameState.sailShipType;
    if (gameState.sailShipType != SHIP_JET && gameState.sailShipType != SHIP_HOVER)
        unlockID = 2;

    work->skyBabylon.boat = SeaMapEventManager__CreateObject(SEAMAPOBJECT_BOAT_ICON, obj2->position.x, obj2->position.y + 8, 0, NULL, unlockID);
}

void SeaMapCutscene_StateAlways_SkyBabylon(SeaMapCutscene *work)
{
    // Do nothing.
}

void SeaMapCutscene_State_WaitForSkyBabylonAppear(SeaMapCutscene *work)
{
    if (work->skyBabylon.timer++ > 60)
        work->stateActive = SeaMapCutscene_State_SkyBabylonAppear;
}

void SeaMapCutscene_State_SkyBabylonAppear(SeaMapCutscene *work)
{
    CHEVObject *obj = SeaMapEventManager__GetObjectFromID(6);

    SeaMapEventManager__UnlockSkyBabylon();
    SeaMapEventManager__CreateObject(SEAMAPOBJECT_SPARKLES_1, obj->position.x, obj->position.y - 32, 0, NULL, 0);
    PlaySailSfx(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_GOAL);

    work->skyBabylon.timer = 0;
    work->stateActive      = SeaMapCutscene_State_SkyBabylonAppeared;
}

void SeaMapCutscene_State_SkyBabylonAppeared(SeaMapCutscene *work)
{
    if (work->skyBabylon.timer++ > 180)
        work->stateActive = SeaMapCutscene_State_SkyBabylonBoatLaunch;
}

void SeaMapCutscene_State_SkyBabylonBoatLaunch(SeaMapCutscene *work)
{
    work->skyBabylon.startPos  = FX32_FROM_WHOLE(work->skyBabylon.boat->position.y);
    work->skyBabylon.targetY   = FX32_FROM_WHOLE(SeaMapEventManager__GetObjectFromID(6)->position.y);
    work->skyBabylon.targetPos = work->skyBabylon.startPos + MultiplyFX(FLOAT_TO_FX32(0.2), work->skyBabylon.targetY - work->skyBabylon.startPos);
    work->skyBabylon.percent   = FLOAT_TO_FX32(0.0);

    work->stateActive = SeaMapCutscene_State_BoatBounceUpwardsTowardsSkyBabylon;
}

void SeaMapCutscene_State_BoatBounceUpwardsTowardsSkyBabylon(SeaMapCutscene *work)
{
    BOOL done = FALSE;

    work->skyBabylon.percent += FLOAT_TO_FX32(1.0 / 60.0);

    if (work->skyBabylon.percent >= FLOAT_TO_FX32(1.0))
    {
        done                     = TRUE;
        work->skyBabylon.percent = FLOAT_TO_FX32(1.0);
    }

    work->skyBabylon.boat->position.y = FX32_TO_WHOLE(mtLerpEx(work->skyBabylon.percent, work->skyBabylon.startPos, work->skyBabylon.targetPos, 2));

    if (done)
    {
        work->skyBabylon.percent = FLOAT_TO_FX32(0.0);
        work->stateActive        = SeaMapCutscene_State_BoatLaunchingToSkyBabylon;
    }
}

void SeaMapCutscene_State_BoatLaunchingToSkyBabylon(SeaMapCutscene *work)
{
    BOOL done = FALSE;

    work->skyBabylon.percent += FLOAT_TO_FX32(1.0 / 50.0);

    if (work->skyBabylon.percent >= FLOAT_TO_FX32(1.0))
    {
        done                     = TRUE;
        work->skyBabylon.percent = FLOAT_TO_FX32(1.0);
    }

    work->skyBabylon.boat->position.y = FX32_TO_WHOLE(work->skyBabylon.targetPos + MultiplyFX(work->skyBabylon.targetY - work->skyBabylon.targetPos, work->skyBabylon.percent));

    if (done)
    {
        work->skyBabylon.timer = 0;
        work->stateActive      = SeaMapCutscene_State_LaunchedToSkyBabylon;
    }
}

void SeaMapCutscene_State_LaunchedToSkyBabylon(SeaMapCutscene *work)
{
    if (work->skyBabylon.timer++ > 60)
        SetCurrentTaskMainEvent(SeaMapCutscene_Main_FadeOut);
}