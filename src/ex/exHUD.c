#include <ex/core/exHUD.h>
#include <ex/system/exSystem.h>
#include <ex/system/exTimeGameplay.h>
#include <ex/core/exTutorialMessage.h>
#include <ex/boss/exBoss.h>

// Resources
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static Task *exHUDBossGaugeTaskSingleton;
static Task *exHUDTimeTaskSingleton;
static Task *exHUDRingTaskSingleton;
static Task *exHUDLifeTaskSingleton;
static Task *exHUDAdminTaskSingleton;
static struct exFixTimeTaskWorker exHUDTimeWorker;

static u16 exHUDTimeDigits1[10] = { EX_ACTCOM_ANI_COMMON_DIGIT_0, EX_ACTCOM_ANI_COMMON_DIGIT_1, EX_ACTCOM_ANI_COMMON_DIGIT_2, EX_ACTCOM_ANI_COMMON_DIGIT_3,
                                    EX_ACTCOM_ANI_COMMON_DIGIT_4, EX_ACTCOM_ANI_COMMON_DIGIT_5, EX_ACTCOM_ANI_COMMON_DIGIT_6, EX_ACTCOM_ANI_COMMON_DIGIT_7,
                                    EX_ACTCOM_ANI_COMMON_DIGIT_8, EX_ACTCOM_ANI_COMMON_DIGIT_9 };

static u16 exHUDLifeDigits[10] = { EX_ACTCOM_ANI_LIFE_DIGIT_0, EX_ACTCOM_ANI_LIFE_DIGIT_1, EX_ACTCOM_ANI_LIFE_DIGIT_2, EX_ACTCOM_ANI_LIFE_DIGIT_3, EX_ACTCOM_ANI_LIFE_DIGIT_4,
                                   EX_ACTCOM_ANI_LIFE_DIGIT_5, EX_ACTCOM_ANI_LIFE_DIGIT_6, EX_ACTCOM_ANI_LIFE_DIGIT_7, EX_ACTCOM_ANI_LIFE_DIGIT_8, EX_ACTCOM_ANI_LIFE_DIGIT_9 };

static u16 exHUDRingDigits1[10] = { EX_ACTCOM_ANI_COMMON_DIGIT_0, EX_ACTCOM_ANI_COMMON_DIGIT_1, EX_ACTCOM_ANI_COMMON_DIGIT_2, EX_ACTCOM_ANI_COMMON_DIGIT_3,
                                    EX_ACTCOM_ANI_COMMON_DIGIT_4, EX_ACTCOM_ANI_COMMON_DIGIT_5, EX_ACTCOM_ANI_COMMON_DIGIT_6, EX_ACTCOM_ANI_COMMON_DIGIT_7,
                                    EX_ACTCOM_ANI_COMMON_DIGIT_8, EX_ACTCOM_ANI_COMMON_DIGIT_9 };

static u16 exHUDTimeDigits2[10] = {
    EX_ACTCOM_ANI_ALERT_DIGIT_0, EX_ACTCOM_ANI_ALERT_DIGIT_1, EX_ACTCOM_ANI_ALERT_DIGIT_2, EX_ACTCOM_ANI_ALERT_DIGIT_3, EX_ACTCOM_ANI_ALERT_DIGIT_4,
    EX_ACTCOM_ANI_ALERT_DIGIT_5, EX_ACTCOM_ANI_ALERT_DIGIT_6, EX_ACTCOM_ANI_ALERT_DIGIT_7, EX_ACTCOM_ANI_ALERT_DIGIT_8, EX_ACTCOM_ANI_ALERT_DIGIT_9
};

static u16 exHUDRingDigits2[10] = {
    EX_ACTCOM_ANI_ALERT_DIGIT_0, EX_ACTCOM_ANI_ALERT_DIGIT_1, EX_ACTCOM_ANI_ALERT_DIGIT_2, EX_ACTCOM_ANI_ALERT_DIGIT_3, EX_ACTCOM_ANI_ALERT_DIGIT_4,
    EX_ACTCOM_ANI_ALERT_DIGIT_5, EX_ACTCOM_ANI_ALERT_DIGIT_6, EX_ACTCOM_ANI_ALERT_DIGIT_7, EX_ACTCOM_ANI_ALERT_DIGIT_8, EX_ACTCOM_ANI_ALERT_DIGIT_9
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExTimeHUD
static void ExTimeHUD_Main_Init(void);
static void ExTimeHUD_TaskUnknown(void);
static void ExTimeHUD_Destructor(void);
static void ExTimeHUD_Main_Active(void);
static BOOL CreateExTimeHUD(void);
static void DestroyExTimeHUD(void);

// ExRingCountHUD
static void ExRingCountHUD_Main_Init(void);
static void ExRingCountHUD_TaskUnknown(void);
static void ExRingCountHUD_Destructor(void);
static void ExRingCountHUD_Main_Active(void);
static BOOL CreateExRingCountHUD(void);
static void DestroyExRingCountHUD(void);

// ExLifeCountHUD
static void ExLifeCountHUD_Main_Init(void);
static void ExLifeCountHUD_TaskUnknown(void);
static void ExLifeCountHUD_Destructor(void);
static void ExLifeCountHUD_Main_Active(void);
static BOOL CreateExLifeCountHUD(void);
static void DestroyExLifeCountHUD(void);

// ExBossLifeGaugeHUD
static void ExBossLifeGaugeHUD_Main_Init(void);
static void ExBossLifeGaugeHUD_TaskUnknown(void);
static void ExBossLifeGaugeHUD_Destructor(void);
static void ExBossLifeGaugeHUD_Main_HealthIdle(void);
static void ExBossLifeGaugeHUD_Main_HealthChanging(void);
static BOOL CreateExBossLifeGaugeHUD(void);
static void DestroyExBossLifeGaugeHUD(void);

// ExHUD
static void ExHUD_Main_Init(void);
static void ExHUD_TaskUnknown(void);
static void ExHUD_Destructor(void);
static void ExHUD_Main_WaitForCommonHUD(void);
static void ExHUD_Action_CreateCommonHUD(void);
static void ExHUD_Main_WaitForBossHUD(void);
static void ExHUD_Action_CreateBossHUD(void);
static void ExHUD_Main_Idle(void);

// --------------------
// FUNCTIONS
// --------------------

void SetupExHUDSprite(EX_ACTION_BAC2D_WORK *work)
{
    u16 prevAnim   = work->sprite.anim;
    u16 paletteRow = work->sprite.paletteRow;
    exDrawReqTask__InitSprite2D(work);
    work->sprite.anim = prevAnim;

    void *spriteFile = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);
    AnimatorSprite__Init(&work->sprite.animator, spriteFile, prevAnim, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                         PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize2FromAnim(spriteFile, prevAnim)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_A]), SPRITE_PRIORITY_1, SPRITE_ORDER_0);
    work->sprite.animator.palette = work->sprite.paletteRow = paletteRow;
    work->sprite.pos.x                                      = 128;
    work->sprite.pos.y                                      = 96;
    work->sprite.rotation                                   = FLOAT_DEG_TO_IDX(0.0);
    work->sprite.scale.x                                    = FLOAT_TO_FX32(1.0);
    work->sprite.scale.y                                    = FLOAT_TO_FX32(1.0);
    work->sprite.animator.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
}

void ReleaseExHUDSprite(EX_ACTION_BAC2D_WORK *work)
{
    AnimatorSprite__Release(&work->sprite.animator);
}

void ExTimeHUD_Main_Init(void)
{
    exFixTimeTask *work = ExTaskGetWorkCurrent(exFixTimeTask);

    exHUDTimeTaskSingleton = GetCurrentTask();

    CreateExTimeGameplay();
    work->worker = &exHUDTimeWorker;

    work->worker->aniTimeText.sprite.anim       = EX_ACTCOM_ANI_TIME_TEXT;
    work->worker->aniTimeText.sprite.paletteRow = PALETTE_ROW_2;
    SetupExHUDSprite(&work->worker->aniTimeText);
    exDrawReqTask__SetConfigPriority(&work->worker->aniTimeText.config, 0xE000);
    work->worker->aniTimeText.sprite.pos.x            = 0;
    work->worker->aniTimeText.sprite.pos.y            = 0;
    work->worker->aniTimeText.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniTimeText);
    exDrawReqTask__Func_21641F0(&work->worker->aniTimeText.config);

    for (u16 i = 0; i < 2; i++)
    {
        if (i)
        {
            work->worker->aniComma1[i].sprite.anim = EX_ACTCOM_ANI_ALERT_COMMA_1;
        }
        else
        {
            work->worker->aniComma1[i].sprite.anim = EX_ACTCOM_ANI_COMMA_1;
        }

        work->worker->aniComma1[i].sprite.paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->worker->aniComma1[i]);
        exDrawReqTask__SetConfigPriority(&work->worker->aniComma1[i].config, 0xE000);
        work->worker->aniComma1[i].sprite.pos.x            = 0;
        work->worker->aniComma1[i].sprite.pos.y            = 0;
        work->worker->aniComma1[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniComma1[i]);

        if (i)
            exDrawReqTask__Func_2164218(&work->worker->aniComma1[i].config);
        else
            exDrawReqTask__Func_21641F0(&work->worker->aniComma1[i].config);

        if (i)
            work->worker->aniComma2[i].sprite.anim = EX_ACTCOM_ANI_ALERT_COMMA_2;
        else
            work->worker->aniComma2[i].sprite.anim = EX_ACTCOM_ANI_COMMA_2;

        work->worker->aniComma2[i].sprite.paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->worker->aniComma2[i]);
        exDrawReqTask__SetConfigPriority(&work->worker->aniComma2[i].config, 0xE000);
        work->worker->aniComma2[i].sprite.pos.x            = 0;
        work->worker->aniComma2[i].sprite.pos.y            = 0;
        work->worker->aniComma2[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniComma2[i]);

        if (i)
            exDrawReqTask__Func_2164218(&work->worker->aniComma2[i].config);
        else
            exDrawReqTask__Func_21641F0(&work->worker->aniComma2[i].config);

        for (u16 j = 0; j < 10; j++)
        {
            if (i)
                work->worker->aniDigit[i][j].sprite.anim = exHUDTimeDigits2[j];
            else
                work->worker->aniDigit[i][j].sprite.anim = exHUDTimeDigits1[j];

            work->worker->aniDigit[i][j].sprite.paletteRow = PALETTE_ROW_2;
            SetupExHUDSprite(&work->worker->aniDigit[i][j]);
            exDrawReqTask__SetConfigPriority(&work->worker->aniDigit[i][j].config, 0xE001);
            work->worker->aniDigit[i][j].sprite.pos.x            = 0;
            work->worker->aniDigit[i][j].sprite.pos.y            = 0;
            work->worker->aniDigit[i][j].config.field_2.value_20 = TRUE;
            exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniDigit[i][j]);

            if (i)
                exDrawReqTask__Func_2164218(&work->worker->aniDigit[i][j].config);
            else
                exDrawReqTask__Func_21641F0(&work->worker->aniDigit[i][j].config);
        }
    }

    work->worker->isWarning         = 0;
    work->worker->minutePos.x       = 179;
    work->worker->minutePos.y       = 13;
    work->worker->tenSecondsPos.x   = 199;
    work->worker->tenSecondsPos.y   = 13;
    work->worker->secondsPos.x      = 211;
    work->worker->secondsPos.y      = 13;
    work->worker->frameCounterPos.x = 232;
    work->worker->frameCounterPos.y = 13;
    work->worker->centisecondsPos.x = 244;
    work->worker->centisecondsPos.y = 13;

    SetCurrentExTaskMainEvent(ExTimeHUD_Main_Active);
}

void ExTimeHUD_TaskUnknown(void)
{
    exFixTimeTask *work = ExTaskGetWorkCurrent(exFixTimeTask);
    UNUSED(work);
}

void ExTimeHUD_Destructor(void)
{
    exFixTimeTask *work = ExTaskGetWorkCurrent(exFixTimeTask);

    DestroyExTimeGameplay();

    ReleaseExHUDSprite(&work->worker->aniTimeText);
    ReleaseExHUDSprite(&work->worker->aniComma1[0]);
    ReleaseExHUDSprite(&work->worker->aniComma1[1]);
    ReleaseExHUDSprite(&work->worker->aniComma2[0]);
    ReleaseExHUDSprite(&work->worker->aniComma2[1]);

    for (u16 i = 0; i < 10; i++)
    {
        ReleaseExHUDSprite(&work->worker->aniDigit[0][i]);
        ReleaseExHUDSprite(&work->worker->aniDigit[1][i]);
    }

    exHUDTimeTaskSingleton = NULL;
}

void ExTimeHUD_Main_Active(void)
{
    exSysTaskStatus *status;
    exFixTimeTask *work;
    u16 i;
    u16 mode;

    work = ExTaskGetWorkCurrent(exFixTimeTask);

    status = GetExSystemStatus();

    mode = work->worker->isWarning;
    if (status->time.minutes >= 9)
    {
        work->worker->isWarning = 1;
        mode                    = work->worker->isWarning;
    }

    for (i = 0; i < 10; i++)
    {
        exDrawReqTask__Sprite2D__Animate(&work->worker->aniDigit[mode][i]);
    }

    work->worker->aniDigit[mode][status->time.minutes].sprite.pos.x = work->worker->minutePos.x;
    work->worker->aniDigit[mode][status->time.minutes].sprite.pos.y = work->worker->minutePos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.minutes], &work->worker->aniDigit[mode][status->time.minutes].config);

    work->worker->aniDigit[mode][status->time.tenSeconds].sprite.pos.x = work->worker->tenSecondsPos.x;
    work->worker->aniDigit[mode][status->time.tenSeconds].sprite.pos.y = work->worker->tenSecondsPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.tenSeconds], &work->worker->aniDigit[mode][status->time.tenSeconds].config);

    work->worker->aniDigit[mode][status->time.seconds].sprite.pos.x = work->worker->secondsPos.x;
    work->worker->aniDigit[mode][status->time.seconds].sprite.pos.y = work->worker->secondsPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.seconds], &work->worker->aniDigit[mode][status->time.seconds].config);

    work->worker->aniDigit[mode][status->time.frameCounter].sprite.pos.x = work->worker->frameCounterPos.x;
    work->worker->aniDigit[mode][status->time.frameCounter].sprite.pos.y = work->worker->frameCounterPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.frameCounter], &work->worker->aniDigit[mode][status->time.frameCounter].config);

    work->worker->aniDigit[mode][status->time.centiseconds].sprite.pos.x = work->worker->centisecondsPos.x;
    work->worker->aniDigit[mode][status->time.centiseconds].sprite.pos.y = work->worker->centisecondsPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.centiseconds], &work->worker->aniDigit[mode][status->time.centiseconds].config);

    exDrawReqTask__AddRequest(&work->worker->aniComma1[mode], &work->worker->aniComma1[mode].config);
    exDrawReqTask__AddRequest(&work->worker->aniComma2[mode], &work->worker->aniComma2[mode].config);

    exDrawReqTask__Sprite2D__Animate(&work->worker->aniTimeText);
    exDrawReqTask__AddRequest(&work->worker->aniTimeText, &work->worker->aniTimeText.config);

    exDrawReqTask__Sprite2D__Animate(&work->worker->aniComma1[mode]);
    exDrawReqTask__Sprite2D__Animate(&work->worker->aniComma2[mode]);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExTimeHUD(void)
{
    Task *task = ExTaskCreate(ExTimeHUD_Main_Init, ExTimeHUD_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exFixTimeTask);

    exFixTimeTask *work = ExTaskGetWork(task, exFixTimeTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExTimeHUD_TaskUnknown);

    return TRUE;
}

void DestroyExTimeHUD(void)
{
    if (exHUDTimeTaskSingleton != NULL)
        DestroyExTask(exHUDTimeTaskSingleton);
}

void ExRingCountHUD_Main_Init(void)
{
    exFixRingTask *work = ExTaskGetWorkCurrent(exFixRingTask);

    exHUDRingTaskSingleton = GetCurrentTask();

    work->aniRingBackdrop.sprite.anim       = EX_ACTCOM_ANI_RINGS_BACKDROP;
    work->aniRingBackdrop.sprite.paletteRow = PALETTE_ROW_1;
    SetupExHUDSprite(&work->aniRingBackdrop);
    exDrawReqTask__SetConfigPriority(&work->aniRingBackdrop.config, 0xE000);
    work->aniRingBackdrop.sprite.pos.x            = 0;
    work->aniRingBackdrop.sprite.pos.y            = 0;
    work->aniRingBackdrop.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniRingBackdrop);

    exDrawReqTask__Func_21641F0(&work->aniRingBackdrop.config);

    u16 i;
    for (i = 0; i < ARRAY_COUNT(work->aniNumbers); i++)
    {
        work->aniNumbers[i].sprite.anim       = exHUDRingDigits1[i];
        work->aniNumbers[i].sprite.paletteRow = EX_ACTCOM_ANI_2;
        SetupExHUDSprite(&work->aniNumbers[i]);
        exDrawReqTask__SetConfigPriority(&work->aniNumbers[i].config, 0xE001);
        work->aniNumbers[i].sprite.pos.x            = 0;
        work->aniNumbers[i].sprite.pos.y            = 0;
        work->aniNumbers[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniNumbers[i]);
        exDrawReqTask__Func_21641F0(&work->aniNumbers[i].config);
    }

    for (i = 0; i < ARRAY_COUNT(work->aniNumbersWarning); i++)
    {
        work->aniNumbersWarning[i].sprite.anim       = exHUDRingDigits2[i];
        work->aniNumbersWarning[i].sprite.paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->aniNumbersWarning[i]);
        exDrawReqTask__SetConfigPriority(&work->aniNumbersWarning[i].config, 0xE001);
        work->aniNumbersWarning[i].sprite.pos.x            = 0;
        work->aniNumbersWarning[i].sprite.pos.y            = 0;
        work->aniNumbersWarning[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniNumbersWarning[i]);
        exDrawReqTask__Func_2164218(&work->aniNumbersWarning[i].config);
    }

    work->digit1Pos.x   = 23;
    work->digit1Pos.y   = 16;
    work->digit2Pos.x   = 33;
    work->digit2Pos.y   = 16;
    work->digit3Pos.x   = 43;
    work->digit3Pos.y   = 16;
    work->ringLossTimer = SECONDS_TO_FRAMES(1.0);

    SetCurrentExTaskMainEvent(ExRingCountHUD_Main_Active);
}

void ExRingCountHUD_TaskUnknown(void)
{
    exFixRingTask *work = ExTaskGetWorkCurrent(exFixRingTask);
    UNUSED(work);
}

void ExRingCountHUD_Destructor(void)
{
    exFixRingTask *work = ExTaskGetWorkCurrent(exFixRingTask);

    ReleaseExHUDSprite(&work->aniRingBackdrop);
    for (u16 i = 0; i < 10; i++)
    {
        ReleaseExHUDSprite(&work->aniNumbers[i]);
        ReleaseExHUDSprite(&work->aniNumbersWarning[i]);
    }

    exHUDRingTaskSingleton = NULL;
}

void ExRingCountHUD_Main_Active(void)
{
    exFixRingTask *work = ExTaskGetWorkCurrent(exFixRingTask);

    exSysTaskStatus *status = GetExSystemStatus();

    exDrawReqTask__Sprite2D__Animate(&work->aniRingBackdrop);
    exDrawReqTask__AddRequest(&work->aniRingBackdrop, &work->aniRingBackdrop.config);

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED && GetExSystemStatus()->state != EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED
        && GetExSystemStatus()->state != EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
    {
        if (status->rings != 0)
        {
            if (work->ringLossTimer-- < 0)
            {
                work->ringLossTimer = SECONDS_TO_FRAMES(1.0);
                if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
                    status->rings--;
            }
        }
        else
        {
            work->ringLossTimer = SECONDS_TO_FRAMES(1.0);
        }
    }

    s32 digit1;
    s32 digit2;
    s32 digit3;

    digit3 = status->rings % 10;
    digit2 = (status->rings % 100 - digit3) / 10;
    digit1 = (status->rings % 1000 - (digit3 + digit2)) / 100;

    if (digit1 == 0 && digit2 == 0)
    {
        for (s16 i = 0; i < (u32)ARRAY_COUNT(work->aniNumbersWarning); i++)
        {
            exDrawReqTask__Sprite2D__Animate(&work->aniNumbersWarning[i]);
        }

        work->aniNumbersWarning[digit1].sprite.pos.x = work->digit1Pos.x;
        work->aniNumbersWarning[digit1].sprite.pos.y = work->digit1Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbersWarning[digit1], &work->aniNumbersWarning[digit1].config);

        work->aniNumbersWarning[digit2].sprite.pos.x = work->digit2Pos.x;
        work->aniNumbersWarning[digit2].sprite.pos.y = work->digit2Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbersWarning[digit2], &work->aniNumbersWarning[digit2].config);

        work->aniNumbersWarning[digit3].sprite.pos.x = work->digit3Pos.x;
        work->aniNumbersWarning[digit3].sprite.pos.y = work->digit3Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbersWarning[digit3], &work->aniNumbersWarning[digit3].config);
    }
    else
    {
        for (s16 i = 0; i < (u32)ARRAY_COUNT(work->aniNumbers); i++)
        {
            exDrawReqTask__Sprite2D__Animate(&work->aniNumbers[i]);
        }

        work->aniNumbers[digit1].sprite.pos.x = work->digit1Pos.x;
        work->aniNumbers[digit1].sprite.pos.y = work->digit1Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbers[digit1], &work->aniNumbers[digit1].config);

        work->aniNumbers[digit2].sprite.pos.x = work->digit2Pos.x;
        work->aniNumbers[digit2].sprite.pos.y = work->digit2Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbers[digit2], &work->aniNumbers[digit2].config);

        work->aniNumbers[digit3].sprite.pos.x = work->digit3Pos.x;
        work->aniNumbers[digit3].sprite.pos.y = work->digit3Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbers[digit3], &work->aniNumbers[digit3].config);
    }

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExRingCountHUD(void)
{
    Task *task = ExTaskCreate(ExRingCountHUD_Main_Init, ExRingCountHUD_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1801, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exFixRingTask);

    exFixRingTask *work = ExTaskGetWork(task, exFixRingTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExRingCountHUD_TaskUnknown);

    return TRUE;
}

void DestroyExRingCountHUD(void)
{
    if (exHUDRingTaskSingleton != NULL)
        DestroyExTask(exHUDRingTaskSingleton);
}

void ExLifeCountHUD_Main_Init(void)
{
    exFixRemainderTask *work = ExTaskGetWorkCurrent(exFixRemainderTask);

    exHUDLifeTaskSingleton = GetCurrentTask();

    work->aniPlayerIcon.sprite.anim       = EX_ACTCOM_ANI_LIVES_BACKDROP;
    work->aniPlayerIcon.sprite.paletteRow = PALETTE_ROW_0;
    SetupExHUDSprite(&work->aniPlayerIcon);
    exDrawReqTask__SetConfigPriority(&work->aniPlayerIcon.config, 0xE000);
    work->aniPlayerIcon.sprite.pos.x            = 0;
    work->aniPlayerIcon.sprite.pos.y            = 0;
    work->aniPlayerIcon.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniPlayerIcon);

    work->aniX.sprite.anim       = EX_ACTCOM_ANI_LIVES_X;
    work->aniX.sprite.paletteRow = PALETTE_ROW_2;
    SetupExHUDSprite(&work->aniX);
    exDrawReqTask__SetConfigPriority(&work->aniX.config, 0xE001);
    work->aniX.sprite.pos.x            = 0;
    work->aniX.sprite.pos.y            = 0;
    work->aniX.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniX);

    for (u16 i = 0; i < ARRAY_COUNT(work->aniNumbers); i++)
    {
        work->aniNumbers[i].sprite.anim       = exHUDLifeDigits[i];
        work->aniNumbers[i].sprite.paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->aniNumbers[i]);
        exDrawReqTask__SetConfigPriority(&work->aniNumbers[i].config, 0xE001);
        work->aniNumbers[i].sprite.pos.x            = 0;
        work->aniNumbers[i].sprite.pos.y            = 0;
        work->aniNumbers[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniNumbers[i]);
    }

    work->digit1Pos.x = 40;
    work->digit1Pos.y = 182;
    work->digit2Pos.x = 47;
    work->digit2Pos.y = 182;

    SetCurrentExTaskMainEvent(ExLifeCountHUD_Main_Active);
}

void ExLifeCountHUD_TaskUnknown(void)
{
    exFixRemainderTask *work = ExTaskGetWorkCurrent(exFixRemainderTask);
    UNUSED(work);
}

void ExLifeCountHUD_Destructor(void)
{
    exFixRemainderTask *work = ExTaskGetWorkCurrent(exFixRemainderTask);

    ReleaseExHUDSprite(&work->aniPlayerIcon);
    ReleaseExHUDSprite(&work->aniX);
    for (u16 i = 0; i < ARRAY_COUNT(work->aniNumbers); i++)
    {
        ReleaseExHUDSprite(&work->aniNumbers[i]);
    }

    exHUDLifeTaskSingleton = NULL;
}

void ExLifeCountHUD_Main_Active(void)
{
    exFixRemainderTask *work = ExTaskGetWorkCurrent(exFixRemainderTask);

    exSysTaskStatus *status = GetExSystemStatus();

    s32 lifeDigit2 = status->lives % 10;
    s32 lifeDigit1 = (status->lives % 100 - lifeDigit2) / 10;

    exDrawReqTask__Sprite2D__Animate(&work->aniNumbers[lifeDigit1]);
    exDrawReqTask__Sprite2D__Animate(&work->aniNumbers[lifeDigit2]);
    exDrawReqTask__Sprite2D__Animate(&work->aniX);
    exDrawReqTask__Sprite2D__Animate(&work->aniPlayerIcon);

    EX_ACTION_BAC2D_WORK *aniDigit2           = &work->aniNumbers[lifeDigit1];
    work->aniNumbers[lifeDigit1].sprite.pos.x = work->digit1Pos.x;
    work->aniNumbers[lifeDigit1].sprite.pos.y = work->digit1Pos.y;
    exDrawReqTask__AddRequest(&work->aniNumbers[lifeDigit1], &work->aniNumbers[lifeDigit1].config);

    work->aniNumbers[lifeDigit2].sprite.pos.x = work->digit2Pos.x;
    work->aniNumbers[lifeDigit2].sprite.pos.y = work->digit2Pos.y;
    exDrawReqTask__AddRequest(&work->aniNumbers[lifeDigit2], &work->aniNumbers[lifeDigit2].config);

    exDrawReqTask__AddRequest(&work->aniX, &work->aniX.config);
    exDrawReqTask__AddRequest(&work->aniPlayerIcon, &work->aniPlayerIcon.config);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExLifeCountHUD(void)
{
    Task *task =
        ExTaskCreate(ExLifeCountHUD_Main_Init, ExLifeCountHUD_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exFixRemainderTask);

    exFixRemainderTask *work = ExTaskGetWork(task, exFixRemainderTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExLifeCountHUD_TaskUnknown);

    return TRUE;
}

void DestroyExLifeCountHUD(void)
{
    if (exHUDLifeTaskSingleton != NULL)
        DestroyExTask(exHUDLifeTaskSingleton);
}

void ExBossLifeGaugeHUD_Main_Init(void)
{
    exFixBossLifeGaugeTask *work = ExTaskGetWorkCurrent(exFixBossLifeGaugeTask);

    exHUDBossGaugeTaskSingleton = GetCurrentTask();

    work->boss                          = GetExBossWork();
    work->aniBossName.sprite.anim       = EX_ACTCOM_ANI_BOSSGAUGE_NAME;
    work->aniBossName.sprite.paletteRow = PALETTE_ROW_9;
    SetupExHUDSprite(&work->aniBossName);
    exDrawReqTask__SetConfigPriority(&work->aniBossName.config, 0xE000);
    work->aniBossName.sprite.pos.x            = 57;
    work->aniBossName.sprite.pos.y            = 176;
    work->aniBossName.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniBossName);

    work->aniCapL.sprite.anim       = EX_ACTCOM_ANI_BOSSGAUGE_EDGE;
    work->aniCapL.sprite.paletteRow = PALETTE_ROW_9;
    SetupExHUDSprite(&work->aniCapL);
    exDrawReqTask__SetConfigPriority(&work->aniCapL.config, 0xE000);
    work->aniCapL.sprite.pos.x            = 56;
    work->aniCapL.sprite.pos.y            = 176;
    work->aniCapL.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniCapL);

    work->aniCapR.sprite.anim       = EX_ACTCOM_ANI_BOSSGAUGE_EDGE;
    work->aniCapR.sprite.paletteRow = PALETTE_ROW_9;
    SetupExHUDSprite(&work->aniCapR);
    exDrawReqTask__SetConfigPriority(&work->aniCapR.config, 0xE000);
    work->aniCapR.sprite.pos.x            = HW_LCD_WIDTH - 8;
    work->aniCapR.sprite.pos.y            = 176;
    work->aniCapR.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniCapR);
    work->aniCapR.sprite.animator.flags |= ANIMATOR_FLAG_FLIP_X;

    for (s16 i = 0; i < (s32)ARRAY_COUNT(work->aniLifeGauge); i++)
    {
        work->aniLifeGauge[i].sprite.anim       = i + EX_ACTCOM_ANI_BOSSGAUGE_BAR_0;
        work->aniLifeGauge[i].sprite.paletteRow = PALETTE_ROW_9;
        SetupExHUDSprite(&work->aniLifeGauge[i]);
        exDrawReqTask__SetConfigPriority(&work->aniLifeGauge[i].config, 0xDFFF);
        work->aniLifeGauge[i].sprite.pos.x            = 0;
        work->aniLifeGauge[i].sprite.pos.y            = work->aniCapL.sprite.pos.y;
        work->aniLifeGauge[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniLifeGauge[i]);
    }

    work->boss->maxHealth   = -16 - work->aniCapL.sprite.pos.x + work->aniCapR.sprite.pos.x; // 176 by default, NOTE: if the resolution ever changes, this would break!
    work->boss->health      = work->boss->maxHealth;
    work->totalSegmentCount = work->boss->health / 8;
    work->health            = work->boss->maxHealth;
    work->healthChange      = 0;

    SetCurrentExTaskMainEvent(ExBossLifeGaugeHUD_Main_HealthIdle);
}

void ExBossLifeGaugeHUD_TaskUnknown(void)
{
    exFixBossLifeGaugeTask *work = ExTaskGetWorkCurrent(exFixBossLifeGaugeTask);
    UNUSED(work);
}

void ExBossLifeGaugeHUD_Destructor(void)
{
    exFixBossLifeGaugeTask *work = ExTaskGetWorkCurrent(exFixBossLifeGaugeTask);

    ReleaseExHUDSprite(&work->aniBossName);
    ReleaseExHUDSprite(&work->aniCapL);
    ReleaseExHUDSprite(&work->aniCapR);
    for (u16 i = 0; i < (s32)ARRAY_COUNT(work->aniLifeGauge); i++)
    {
        ReleaseExHUDSprite(&work->aniLifeGauge[i]);
    }

    exHUDBossGaugeTaskSingleton = NULL;
}

void ExBossLifeGaugeHUD_Main_HealthIdle(void)
{
    s16 i;
    s16 remainLifePos;

    exFixBossLifeGaugeTask *work = ExTaskGetWorkCurrent(exFixBossLifeGaugeTask);

    exSysTaskStatus *status = GetExSystemStatus();
    UNUSED(status);

    exDrawReqTask__Sprite2D__Animate(&work->aniBossName);
    exDrawReqTask__Sprite2D__Animate(&work->aniCapL);
    exDrawReqTask__Sprite2D__Animate(&work->aniCapR);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED
        || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_FLEE_STARTED)
    {
        work->healthChange       = 0;
        work->health             = work->boss->health;
        work->healthSegmentCount = work->boss->health / 8;
        work->healthSegmentPos   = work->boss->health % 8;
    }
    else
    {
        s16 curHealth  = work->boss->health;
        s16 prevHealth = work->health;
        if (prevHealth != curHealth)
        {
            work->healthChange  = prevHealth - curHealth;
            work->health        = work->boss->health;
            work->healthChangeF = work->healthChange;

            SetCurrentExTaskMainEvent(ExBossLifeGaugeHUD_Main_HealthChanging);
            ExBossLifeGaugeHUD_Main_HealthChanging();
            return;
        }

        work->healthSegmentCount = work->boss->health / 8;
        work->healthSegmentPos   = work->boss->health % 8;
    }

    s16 remainLifeAnim = 8 - work->healthSegmentPos;
    for (i = 0; i < (s32)ARRAY_COUNT(work->aniLifeGauge); i++)
    {
        exDrawReqTask__Sprite2D__Animate(&work->aniLifeGauge[i]);
    }

    remainLifePos = 0;
    i             = 0;
    for (; i < work->totalSegmentCount; i++)
    {
        if (i < work->healthSegmentCount)
        {
            work->aniLifeGauge[0].sprite.pos.x = work->aniCapL.sprite.pos.x + 8 * (i + 1);
            exDrawReqTask__AddRequest(work->aniLifeGauge, &work->aniLifeGauge[0].config);
            remainLifePos = i + 1;
        }
        else
        {
            work->aniLifeGauge[8].sprite.pos.x = work->aniCapL.sprite.pos.x + 8 * (i + 1);
            exDrawReqTask__AddRequest(&work->aniLifeGauge[8], &work->aniLifeGauge[8].config);
        }
    }

    if (remainLifeAnim != 8)
    {
        work->aniLifeGauge[remainLifeAnim].sprite.pos.x = work->aniCapL.sprite.pos.x + (s16)(8 * (remainLifePos + 1));
        exDrawReqTask__AddRequest(&work->aniLifeGauge[remainLifeAnim], &work->aniLifeGauge[remainLifeAnim].config);
    }

    exDrawReqTask__AddRequest(&work->aniBossName, &work->aniBossName.config);
    exDrawReqTask__AddRequest(&work->aniCapL, &work->aniCapL.config);
    exDrawReqTask__AddRequest(&work->aniCapR, &work->aniCapR.config);

    RunCurrentExTaskUnknownEvent();
}

void ExBossLifeGaugeHUD_Main_HealthChanging(void)
{
    s16 i;
    s16 remainLifePos;

    exFixBossLifeGaugeTask *work = ExTaskGetWorkCurrent(exFixBossLifeGaugeTask);

    exSysTaskStatus *status = GetExSystemStatus();
    UNUSED(status);

    exDrawReqTask__Sprite2D__Animate(&work->aniBossName);
    exDrawReqTask__Sprite2D__Animate(&work->aniCapL);
    exDrawReqTask__Sprite2D__Animate(&work->aniCapR);

    if (work->healthChange == 0x00)
    {
        SetCurrentExTaskMainEvent(ExBossLifeGaugeHUD_Main_HealthIdle);
        ExBossLifeGaugeHUD_Main_HealthIdle();
    }
    else
    {
        work->healthChangeF *= 0.9f;

        if (work->healthChange > 0)
        {
            work->healthChange       = work->healthChangeF;
            work->healthSegmentCount = (work->boss->health + work->healthChange) / 8;
            work->healthSegmentPos   = (work->boss->health + work->healthChange) % 8;
        }
        else
        {
            work->healthChange = 0;
            work->health       = work->boss->health;
        }

        s16 remainLifeAnim = 8 - work->healthSegmentPos;
        for (i = 0; i < (s32)ARRAY_COUNT(work->aniLifeGauge); i++)
        {
            exDrawReqTask__Sprite2D__Animate(&work->aniLifeGauge[i]);
        }

        remainLifePos = 0;
        i             = 0;
        for (; i < work->totalSegmentCount; i++)
        {
            if (i < work->healthSegmentCount)
            {
                work->aniLifeGauge[0].sprite.pos.x = work->aniCapL.sprite.pos.x + 8 * (i + 1);
                exDrawReqTask__AddRequest(work->aniLifeGauge, &work->aniLifeGauge[0].config);
                remainLifePos = i + 1;
            }
            else
            {
                work->aniLifeGauge[8].sprite.pos.x = work->aniCapL.sprite.pos.x + 8 * (i + 1);
                exDrawReqTask__AddRequest(&work->aniLifeGauge[8], &work->aniLifeGauge[8].config);
            }
        }

        if (remainLifeAnim != 8)
        {
            work->aniLifeGauge[remainLifeAnim].sprite.pos.x = work->aniCapL.sprite.pos.x + (s16)(8 * (remainLifePos + 1));
            exDrawReqTask__AddRequest(&work->aniLifeGauge[remainLifeAnim], &work->aniLifeGauge[remainLifeAnim].config);
        }

        exDrawReqTask__AddRequest(&work->aniBossName, &work->aniBossName.config);
        exDrawReqTask__AddRequest(&work->aniCapL, &work->aniCapL.config);
        exDrawReqTask__AddRequest(&work->aniCapR, &work->aniCapR.config);

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExBossLifeGaugeHUD(void)
{
    Task *task = ExTaskCreate(ExBossLifeGaugeHUD_Main_Init, ExBossLifeGaugeHUD_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR,
                              exFixBossLifeGaugeTask);

    exFixBossLifeGaugeTask *work = ExTaskGetWork(task, exFixBossLifeGaugeTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExBossLifeGaugeHUD_TaskUnknown);

    return TRUE;
}

void DestroyExBossLifeGaugeHUD(void)
{
    if (exHUDBossGaugeTaskSingleton != NULL)
        DestroyExTask(exHUDBossGaugeTaskSingleton);
}

void ExHUD_Main_Init(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    exSysTaskStatus *status = GetExSystemStatus();
    UNUSED(status);

    exHUDAdminTaskSingleton = GetCurrentTask();

    SetCurrentExTaskMainEvent(ExHUD_Main_WaitForCommonHUD);
}

void ExHUD_TaskUnknown(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);
}

void ExHUD_Destructor(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    DestroyExLifeCountHUD();
    DestroyExRingCountHUD();
    DestroyExTimeHUD();
    DestroyExBossLifeGaugeHUD();

    exHUDAdminTaskSingleton = NULL;
}

void ExHUD_Main_WaitForCommonHUD(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_ACTIVE)
    {
        ExHUD_Action_CreateCommonHUD();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExHUD_Action_CreateCommonHUD(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    CreateExTimeHUD();
    CreateExRingCountHUD();
    CreateExTutorialMessage();

    SetCurrentExTaskMainEvent(ExHUD_Main_WaitForBossHUD);
    ExHUD_Main_WaitForBossHUD();
}

void ExHUD_Main_WaitForBossHUD(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    if (GetExSystemStatus()->state > EXSYSTASK_STATE_BOSS_ACTIVE)
        ExHUD_Action_CreateBossHUD();
}

void ExHUD_Action_CreateBossHUD(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    DestroyExTutorialMessage();
    CreateExLifeCountHUD();
    CreateExBossLifeGaugeHUD();

    SetCurrentExTaskMainEvent(ExHUD_Main_Idle);
    ExHUD_Main_Idle();
}

void ExHUD_Main_Idle(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);
}

BOOL CreateExHUD(void)
{
    Task *task = ExTaskCreate(ExHUD_Main_Init, ExHUD_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exFixAdminTask);

    exFixAdminTask *work = ExTaskGetWork(task, exFixAdminTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExHUD_TaskUnknown);

    return TRUE;
}

void DestroyExHUD(void)
{
    if (exHUDAdminTaskSingleton != NULL)
        DestroyExTask(exHUDAdminTaskSingleton);
}