#include <stage/core/pauseMenu.h>
#include <game/stage/gameSystem.h>
#include <stage/core/hud.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/drawFadeTask.h>
#include <game/input/replayRecorder.h>
#include <game/object/objData.h>
#include <game/save/saveGame.h>
#include <game/system/sysEvent.h>

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL CreatePauseMenu(void);
static void ReleasePauseMenuSprites(PauseMenu *work);
static void PauseMenu_Destructor(Task *task);
static void PauseMenu_Main_Appear(void);
static void PauseMenu_Main_Navigate(void);
static void PauseMenu_Main_Selected(void);
static void PauseMenu_Main_DoAction(void);
static void PauseMenu_Draw(PauseMenu *work);

// --------------------
// FUNCTIONS
// --------------------

void TryOpenPauseMenu(void)
{
    if (gmCheckVsBattleFlag() || gameState.gameMode == GAMEMODE_TIMEATTACK && (gameState.gameFlag & GAME_FLAG_REPLAY_STARTED) != 0)
        return;

    if (Camera3D__GetTask() != NULL)
    {
        Camera3DTask *bossCamera         = Camera3D__GetWork();
        RenderCoreGFXControl *gfxControl = &bossCamera->gfxControl[GetHUDActiveScreen()];

        if (gfxControl->brightness != 0)
            return;

        if ((gfxControl->blendManager.blendControl.effect & BLENDTYPE_FADEIN) != 0 && gfxControl->blendManager.brightness != RENDERCORE_BRIGHTNESS_DEFAULT
            && gfxControl->blendManager.blendControl.plane1_OBJ != FALSE)
            return;
    }
    else
    {
        if (renderCoreGFXControlA.brightness != 0 || renderCoreGFXControlB.brightness != 0)
        {
            return;
        }
    }

    if (GetSysEventList()->currentEventID != SYSEVENT_TITLECARD && CreatePauseMenu())
    {
        if (!CheckTaskPaused(NULL))
            DrawReqTask__Create(2, TRUE, TRUE, TRUE);

        padInput.btnPress = PAD_INPUT_NONE_MASK;

        for (s32 i = 3; i <= 8; i++)
        {
            NNS_SndPlayerPauseByPlayerNo(i, TRUE);
        }

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PAUSE);
    }
}

BOOL CreatePauseMenu(void)
{
    static u8 spriteSizes[PAUSEMENU_ANIMATOR_COUNT][OS_LANGUAGE_CODE_MAX] = {
        [OS_LANGUAGE_JAPANESE] = { 8, 8, 4, 3, 3, 2 }, [OS_LANGUAGE_ENGLISH] = { 8, 8, 4, 3, 3, 2 }, [OS_LANGUAGE_FRENCH] = { 8, 8, 4, 3, 3, 2 },
        [OS_LANGUAGE_GERMAN] = { 8, 8, 4, 2, 3, 2 },   [OS_LANGUAGE_ITALIAN] = { 8, 8, 4, 3, 2, 2 }, [OS_LANGUAGE_SPANISH] = { 8, 8, 4, 3, 3, 3 },
    };

    u32 language = GetGameLanguage();

    Task *task = TaskCreate(PauseMenu_Main_Appear, PauseMenu_Destructor, TASK_FLAG_NONE, 3, 0x7100u, TASK_GROUP(4) | TASK_GROUP(2), PauseMenu);
    if (task == HeapNull)
        return FALSE;

    PauseMenu *work = TaskGetWork(task, PauseMenu);
    TaskInitWork16(work);

    work->selectedButton  = -1;
    work->buttonAction[0] = PAUSEMENU_ACTION_PAUSE;

    if (gameState.gameMode == GAMEMODE_TIMEATTACK)
    {
        work->buttonAction[1] = PAUSEMENU_ACTION_CONTINUE;
        work->buttonAction[2] = PAUSEMENU_ACTION_RESTART;
        work->buttonAction[3] = PAUSEMENU_ACTION_BACK;
        work->buttonCount     = 4;
    }
    else if (gameState.stageID == STAGE_TUTORIAL && !SaveGame__HasBeatenTutorial())
    {
        work->buttonAction[1] = PAUSEMENU_ACTION_CONTINUE;
        work->buttonCount     = 2;
    }
    else
    {
        work->buttonAction[1] = PAUSEMENU_ACTION_CONTINUE;
        work->buttonAction[2] = PAUSEMENU_ACTION_BACK;
        work->buttonCount     = 3;
    }

    s32 i;
    s32 textAnim;

    void *spriteFile   = ObjDataLoad(NULL, "ac_pause.bac", gameArchiveCommon);
    u8 *locSpriteSizes = spriteSizes[language];
    textAnim           = PAUSEMENU_ACTION_COUNT * language;
    for (i = 0; i < PAUSEMENU_ANIMATOR_COUNT; i++)
    {
        u8 size = *(locSpriteSizes++);
        s32 aniID;
        if (i <= PAUSEMENU_ANIMATOR_BACKPLATE2)
            aniID = i;
        else
            aniID = textAnim;

        AnimatorSpriteDS__Init(&work->animators[i], spriteFile, (u16)aniID, 2, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(0, size),
                               PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);

        work->animators[i].cParam[0].palette = work->animators[i].cParam[1].palette = work->animators[i].work.palette = 2;

        AnimatorSpriteDS__ProcessAnimationFast(&work->animators[i]);

        textAnim++;
    }

    work->animators[2].work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
    work->buttonPosition[0].x = -FLOAT_TO_FX32(64.0);
    work->buttonPosition[0].y = FLOAT_TO_FX32(56.0);

    fx32 buttonY;
    s32 b;
    for (b = 0, buttonY = FLOAT_TO_FX32(64.0); b < PAUSEMENU_MAX_BUTTON_COUNT; b++)
    {
        work->buttonPosition[b].x = -FLOAT_TO_FX32(64.0);
        work->buttonPosition[b].y = buttonY;

        buttonY += FLOAT_TO_FX32(16.0);
    }

    return TRUE;
}

void ReleasePauseMenuSprites(PauseMenu *work)
{
    for (s32 i = 0; i < PAUSEMENU_ANIMATOR_COUNT; i++)
    {
        AnimatorSpriteDS__Release(&work->animators[i]);
        work->animators[i].vramPixels[0] = NULL;
    }
}

void PauseMenu_Destructor(Task *task)
{
    PauseMenu *work = TaskGetWork(task, PauseMenu);

    ReleasePauseMenuSprites(work);

    for (s32 i = 3; i <= 8; i++)
    {
        NNS_SndPlayerPauseByPlayerNo(i, FALSE);
    }
}

void PauseMenu_Main_Appear(void)
{
    PauseMenu *work = TaskGetWorkCurrent(PauseMenu);

    for (s32 i = 0; i < work->buttonCount; i++)
    {
        if (i == (PAUSEMENU_ACTION_PAUSE - 2) || work->buttonLerpPercent[i - 1] >= FLOAT_TO_FX32(0.25))
        {
            if (work->buttonLerpPercent[i] < FLOAT_TO_FX32(1.0))
            {
                work->buttonLerpPercent[i] += FLOAT_TO_FX32(0.125);

                if (work->buttonLerpPercent[i] >= FLOAT_TO_FX32(1.0))
                {
                    work->buttonLerpPercent[i] = FLOAT_TO_FX32(1.0);
                    work->buttonPosition[i].x  = FLOAT_TO_FX32(100.0);
                }
                else
                {
                    work->buttonPosition[i].x = mtLerpEx2(work->buttonLerpPercent[i], -FLOAT_TO_FX32(64.0), FLOAT_TO_FX32(100.0), 2);
                }
            }
            else
            {
                if (work->buttonPosition[i].x != FLOAT_TO_FX32(96.0))
                {
                    work->buttonPosition[i].x -= FLOAT_TO_FX32(2.0);

                    if (work->buttonPosition[i].x < FLOAT_TO_FX32(96.0))
                        work->buttonPosition[i].x = FLOAT_TO_FX32(96.0);
                }
            }
        }
    }

    if (work->buttonLerpPercent[work->buttonCount - 1] == FLOAT_TO_FX32(1.0) && work->buttonPosition[work->buttonCount - 1].x == FLOAT_TO_FX32(96.0))
    {
        SetCurrentTaskMainEvent(PauseMenu_Main_Navigate);
        work->selectedButton = 0;
    }

    PauseMenu_Draw(work);
}

void PauseMenu_Main_Navigate(void)
{
    PauseMenu *work;

    BOOL changeState = FALSE;
    u16 btnPress     = padInput.btnPress;

    work = TaskGetWorkCurrent(PauseMenu);

    if ((btnPress & (PAD_BUTTON_START | PAD_BUTTON_B)) != 0)
    {
        work->selectedButton = 0;
        changeState          = TRUE;
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PAUSE);
    }
    else if ((btnPress & PAD_BUTTON_A) != 0)
    {
        changeState = TRUE;
        if (work->selectedButton == 0)
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PAUSE);
        else
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DECISION);
    }
    else if ((btnPress & PAD_KEY_UP) != 0)
    {
        work->selectedButton--;
        if (work->selectedButton < 0)
        {
            work->selectedButton = 0;
        }
        else
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CURSOL);
        }
    }
    else if ((btnPress & PAD_KEY_DOWN) != 0)
    {
        work->selectedButton++;
        if (work->selectedButton >= work->buttonCount - 1)
        {
            work->selectedButton = work->buttonCount - 2;
        }
        else
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CURSOL);
        }
    }

    if (changeState)
    {
        SetCurrentTaskMainEvent(PauseMenu_Main_Selected);
        MI_CpuClear16(work->buttonLerpPercent, sizeof(work->buttonLerpPercent));
    }

    PauseMenu_Draw(work);
}

void PauseMenu_Main_Selected(void)
{
    PauseMenu *work = TaskGetWorkCurrent(PauseMenu);

    s16 action = work->selectedButton + 1;

    if (work->buttonCount <= 2)
        work->buttonLerpPercent[0] = FLOAT_TO_FX32(1.0);

    if (work->buttonLerpPercent[0] != FLOAT_TO_FX32(1.0))
    {
        for (s32 i = 1; i < work->buttonCount; i++)
        {
            if (i != action)
            {
                work->buttonLerpPercent[i] += FLOAT_TO_FX32(0.125);
                if (work->buttonLerpPercent[i] >= FLOAT_TO_FX32(1.0))
                {
                    work->buttonLerpPercent[i] = FLOAT_TO_FX32(1.0);
                    work->buttonPosition[i].x  = FLOAT_TO_FX32(256.0);
                    work->buttonLerpPercent[0] = FLOAT_TO_FX32(1.0);
                }
                else
                {
                    work->buttonPosition[i].x = mtLerpEx(work->buttonLerpPercent[i], FLOAT_TO_FX32(96.0), FLOAT_TO_FX32(256.0), 2);
                }
            }
        }
    }
    else
    {
        work->timer++;
        if (work->timer >= 16)
        {
            if (work->buttonAction[action] == PAUSEMENU_ACTION_CONTINUE)
            {
                DestroyCurrentTask();
                if (CheckTaskPaused(NULL))
                    DrawReqTask__Enable();

                return;
            }
            else
            {
                SetCurrentTaskMainEvent(PauseMenu_Main_DoAction);
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
                work->timer = 0;
            }
        }
    }

    PauseMenu_Draw(work);
}

void PauseMenu_Main_DoAction(void)
{
    PauseMenu *work = TaskGetWorkCurrent(PauseMenu);

    PauseMenuButtonAction action = work->buttonAction[work->selectedButton + 1];
    if (work->timer != 0)
    {
        if (!DrawReqTask__GetEnabled())
        {
            if (action == PAUSEMENU_ACTION_RESTART)
                gameState.gameFlag |= GAME_FLAG_PLAYER_RESTARTED;

            ReleaseGameSystem();
            gameState.gameFlag &= ~(GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_REPLAY_GHOST_ACTIVE | GAME_FLAG_100 | GAME_FLAG_HAS_TIME_OVER);
            DestroyCurrentTask();

            if (action == PAUSEMENU_ACTION_RESTART)
            {
                ChangeEventForPauseMenuAction(TRUE);
            }
            else
            {
                FlushGameSystem(GAMEDATA_LOADPROC_ALL);
                ReleaseGameState();
                ChangeEventForPauseMenuAction(FALSE);
            }

            NextSysEvent();
        }
    }
    else
    {
        if (IsDrawFadeTaskFinished())
        {
            ReleasePauseMenuSprites(work);

            if (CheckTaskPaused(NULL))
                DrawReqTask__Enable();

            SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
            work->timer++;
        }
        else
        {
            PauseMenu_Draw(work);
        }
    }
}

void PauseMenu_Draw(PauseMenu *work)
{
    // Draw paused text
    AnimatorSpriteDS__ProcessAnimationFast(&work->aniPausedText);
    work->aniPausedText.position[0].x = FX32_TO_WHOLE(work->buttonPosition[PAUSEMENU_ACTION_PAUSE - 2].x);
    work->aniPausedText.position[0].y = FX32_TO_WHOLE(work->buttonPosition[PAUSEMENU_ACTION_PAUSE - 2].y);
    AnimatorSpriteDS__DrawFrame(&work->aniPausedText);

    // Draw buttons
    for (s32 i = 1; i < work->buttonCount; i++)
    {
        AnimatorSpriteDS *textAnimator = &work->animators[work->buttonAction[i]];

        textAnimator->position[0].x = FX32_TO_WHOLE(work->buttonPosition[i].x);
        textAnimator->position[0].y = FX32_TO_WHOLE(work->buttonPosition[i].y);

        AnimatorSpriteDS *backplateAnimator;
        if (work->selectedButton + 1 == i)
        {
            backplateAnimator = &work->aniBackplate2;

            backplateAnimator->position[0].x = textAnimator->position[0].x;
            backplateAnimator->position[0].y = textAnimator->position[0].y;

            textAnimator->position[0].x -= 2;
            textAnimator->position[0].y -= 2;
        }
        else
        {
            backplateAnimator = &work->aniBackplate1;

            backplateAnimator->position[0].x = textAnimator->position[0].x;
            backplateAnimator->position[0].y = textAnimator->position[0].y;
        }

        textAnimator->position[0].y += 4;

        AnimatorSpriteDS__DrawFrame(textAnimator);
        AnimatorSpriteDS__DrawFrame(backplateAnimator);
    }
}
