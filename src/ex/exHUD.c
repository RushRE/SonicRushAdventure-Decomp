#include <ex/exHUD.h>
#include <ex/exSysTask.h>
#include <ex/exTimeGameplay.h>

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

static u16 exHUDTimeDigits1[10] = { EX_ACTCOM_ANI_31, EX_ACTCOM_ANI_32, EX_ACTCOM_ANI_33, EX_ACTCOM_ANI_34, EX_ACTCOM_ANI_35,
                                    EX_ACTCOM_ANI_36, EX_ACTCOM_ANI_37, EX_ACTCOM_ANI_38, EX_ACTCOM_ANI_39, EX_ACTCOM_ANI_40 };

static u16 exHUDLifeDigits[10] = { EX_ACTCOM_ANI_55, EX_ACTCOM_ANI_56, EX_ACTCOM_ANI_57, EX_ACTCOM_ANI_58, EX_ACTCOM_ANI_59,
                                   EX_ACTCOM_ANI_60, EX_ACTCOM_ANI_61, EX_ACTCOM_ANI_62, EX_ACTCOM_ANI_63, EX_ACTCOM_ANI_64 };

static u16 exHUDRingDigits1[10] = { EX_ACTCOM_ANI_31, EX_ACTCOM_ANI_32, EX_ACTCOM_ANI_33, EX_ACTCOM_ANI_34, EX_ACTCOM_ANI_35,
                                    EX_ACTCOM_ANI_36, EX_ACTCOM_ANI_37, EX_ACTCOM_ANI_38, EX_ACTCOM_ANI_39, EX_ACTCOM_ANI_40 };

static u16 exHUDTimeDigits2[10] = { EX_ACTCOM_ANI_43, EX_ACTCOM_ANI_44, EX_ACTCOM_ANI_45, EX_ACTCOM_ANI_46, EX_ACTCOM_ANI_47,
                                    EX_ACTCOM_ANI_48, EX_ACTCOM_ANI_49, EX_ACTCOM_ANI_50, EX_ACTCOM_ANI_51, EX_ACTCOM_ANI_52 };

static u16 exHUDRingDigits2[10] = { EX_ACTCOM_ANI_43, EX_ACTCOM_ANI_44, EX_ACTCOM_ANI_45, EX_ACTCOM_ANI_46, EX_ACTCOM_ANI_47,
                                    EX_ACTCOM_ANI_48, EX_ACTCOM_ANI_49, EX_ACTCOM_ANI_50, EX_ACTCOM_ANI_51, EX_ACTCOM_ANI_52 };

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void exMsgTutorialTask__Create(void);
NOT_DECOMPILED void exMsgTutorialTask__Destroy(void);

NOT_DECOMPILED exBossSysAdminTask *ExBossSysAdminTask__GetBossWork(void);

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
static void ExBossLifeGaugeHUD_Main(void);
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
    u16 prevAnim   = work->anim;
    u16 paletteRow = work->paletteRow;
    exDrawReqTask__InitSprite2D(work);
    work->anim = prevAnim;

    void *spriteFile = exSysTask__LoadExFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);
    AnimatorSprite__Init(&work->animator, spriteFile, prevAnim, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize2FromAnim(spriteFile, prevAnim)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_A]), SPRITE_PRIORITY_1, SPRITE_ORDER_0);
    work->animator.palette = work->paletteRow = paletteRow;
    work->pos.x                               = 128;
    work->pos.y                               = 96;
    work->rotation                            = FLOAT_DEG_TO_IDX(0.0);
    work->scale.x                             = FLOAT_TO_FX32(1.0);
    work->scale.y                             = FLOAT_TO_FX32(1.0);
    work->animator.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
}

void ReleaseExHUDSprite(EX_ACTION_BAC2D_WORK *work)
{
    AnimatorSprite__Release(&work->animator);
}

void ExTimeHUD_Main_Init(void)
{
    exFixTimeTask *work = ExTaskGetWorkCurrent(exFixTimeTask);

    exHUDTimeTaskSingleton = GetCurrentTask();

    CreateExTimeGameplay();
    work->worker = &exHUDTimeWorker;

    work->worker->aniTimeText.anim       = EX_ACTCOM_ANI_18;
    work->worker->aniTimeText.paletteRow = PALETTE_ROW_2;
    SetupExHUDSprite(&work->worker->aniTimeText);
    exDrawReqTask__SetConfigPriority(&work->worker->aniTimeText.config, 0xE000);
    work->worker->aniTimeText.pos.x                   = 0;
    work->worker->aniTimeText.pos.y                   = 0;
    work->worker->aniTimeText.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniTimeText);
    exDrawReqTask__Func_21641F0(&work->worker->aniTimeText.config);

    for (u16 i = 0; i < 2; i++)
    {
        if (i)
        {
            work->worker->aniComma1[i].anim = EX_ACTCOM_ANI_53;
        }
        else
        {
            work->worker->aniComma1[i].anim = EX_ACTCOM_ANI_41;
        }

        work->worker->aniComma1[i].paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->worker->aniComma1[i]);
        exDrawReqTask__SetConfigPriority(&work->worker->aniComma1[i].config, 0xE000);
        work->worker->aniComma1[i].pos.x                   = 0;
        work->worker->aniComma1[i].pos.y                   = 0;
        work->worker->aniComma1[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniComma1[i]);

        if (i)
            exDrawReqTask__Func_2164218(&work->worker->aniComma1[i].config);
        else
            exDrawReqTask__Func_21641F0(&work->worker->aniComma1[i].config);

        if (i)
            work->worker->aniComma2[i].anim = EX_ACTCOM_ANI_54;
        else
            work->worker->aniComma2[i].anim = EX_ACTCOM_ANI_42;

        work->worker->aniComma2[i].paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->worker->aniComma2[i]);
        exDrawReqTask__SetConfigPriority(&work->worker->aniComma2[i].config, 0xE000);
        work->worker->aniComma2[i].pos.x                   = 0;
        work->worker->aniComma2[i].pos.y                   = 0;
        work->worker->aniComma2[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B6C(&work->worker->aniComma2[i]);

        if (i)
            exDrawReqTask__Func_2164218(&work->worker->aniComma2[i].config);
        else
            exDrawReqTask__Func_21641F0(&work->worker->aniComma2[i].config);

        for (u16 j = 0; j < 10; j++)
        {
            if (i)
                work->worker->aniDigit[i][j].anim = exHUDTimeDigits2[j];
            else
                work->worker->aniDigit[i][j].anim = exHUDTimeDigits1[j];

            work->worker->aniDigit[i][j].paletteRow = PALETTE_ROW_2;
            SetupExHUDSprite(&work->worker->aniDigit[i][j]);
            exDrawReqTask__SetConfigPriority(&work->worker->aniDigit[i][j].config, 0xE001);
            work->worker->aniDigit[i][j].pos.x                   = 0;
            work->worker->aniDigit[i][j].pos.y                   = 0;
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
    ExSysTaskStatus *status;
    exFixTimeTask *work;
    u16 i;
    u16 mode;

    work = ExTaskGetWorkCurrent(exFixTimeTask);

    status = exSysTask__GetStatus();

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

    work->worker->aniDigit[mode][status->time.minutes].pos.x = work->worker->minutePos.x;
    work->worker->aniDigit[mode][status->time.minutes].pos.y = work->worker->minutePos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.minutes], &work->worker->aniDigit[mode][status->time.minutes].config);

    work->worker->aniDigit[mode][status->time.tenSeconds].pos.x = work->worker->tenSecondsPos.x;
    work->worker->aniDigit[mode][status->time.tenSeconds].pos.y = work->worker->tenSecondsPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.tenSeconds], &work->worker->aniDigit[mode][status->time.tenSeconds].config);

    work->worker->aniDigit[mode][status->time.seconds].pos.x = work->worker->secondsPos.x;
    work->worker->aniDigit[mode][status->time.seconds].pos.y = work->worker->secondsPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.seconds], &work->worker->aniDigit[mode][status->time.seconds].config);

    work->worker->aniDigit[mode][status->time.frameCounter].pos.x = work->worker->frameCounterPos.x;
    work->worker->aniDigit[mode][status->time.frameCounter].pos.y = work->worker->frameCounterPos.y;
    exDrawReqTask__AddRequest(&work->worker->aniDigit[mode][status->time.frameCounter], &work->worker->aniDigit[mode][status->time.frameCounter].config);

    work->worker->aniDigit[mode][status->time.centiseconds].pos.x = work->worker->centisecondsPos.x;
    work->worker->aniDigit[mode][status->time.centiseconds].pos.y = work->worker->centisecondsPos.y;
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

    work->aniRingBackdrop.anim       = EX_ACTCOM_ANI_17;
    work->aniRingBackdrop.paletteRow = PALETTE_ROW_1;
    SetupExHUDSprite(&work->aniRingBackdrop);
    exDrawReqTask__SetConfigPriority(&work->aniRingBackdrop.config, 0xE000);
    work->aniRingBackdrop.pos.x                   = 0;
    work->aniRingBackdrop.pos.y                   = 0;
    work->aniRingBackdrop.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniRingBackdrop);

    exDrawReqTask__Func_21641F0(&work->aniRingBackdrop.config);

    u16 i;
    for (i = 0; i < 10; i++)
    {
        work->aniNumbers[i].anim       = exHUDRingDigits1[i];
        work->aniNumbers[i].paletteRow = EX_ACTCOM_ANI_2;
        SetupExHUDSprite(&work->aniNumbers[i]);
        exDrawReqTask__SetConfigPriority(&work->aniNumbers[i].config, 0xE001);
        work->aniNumbers[i].pos.x                   = 0;
        work->aniNumbers[i].pos.y                   = 0;
        work->aniNumbers[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniNumbers[i]);
        exDrawReqTask__Func_21641F0(&work->aniNumbers[i].config);
    }

    for (i = 0; i < 10; i++)
    {
        work->aniNumbersWarning[i].anim       = exHUDRingDigits2[i];
        work->aniNumbersWarning[i].paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->aniNumbersWarning[i]);
        exDrawReqTask__SetConfigPriority(&work->aniNumbersWarning[i].config, 0xE001);
        work->aniNumbersWarning[i].pos.x                   = 0;
        work->aniNumbersWarning[i].pos.y                   = 0;
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
    work->ringLossTimer = 60;

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

NONMATCH_FUNC void ExRingCountHUD_Main_Active(void)
{
    // https://decomp.me/scratch/0a5N6 -> 88.08%
    // issues near `status->rings % 10` calculations
#ifdef NON_MATCHING
    exFixRingTask *work = ExTaskGetWorkCurrent(exFixRingTask);

    ExSysTaskStatus *status = exSysTask__GetStatus();

    exDrawReqTask__Sprite2D__Animate(&work->aniRingBackdrop);
    exDrawReqTask__AddRequest(&work->aniRingBackdrop, &work->aniRingBackdrop.config);

    if (exSysTask__GetStatus()->state != EXSYSTASK_STATE_11 && exSysTask__GetStatus()->state != EXSYSTASK_STATE_7 && exSysTask__GetStatus()->state != EXSYSTASK_STATE_9)
    {
        if (status->rings != 0)
        {
            if (work->ringLossTimer-- < 0)
            {
                work->ringLossTimer = 60;
                if (exSysTask__GetStatus()->state != EXSYSTASK_STATE_11)
                    status->rings--;
            }
        }
        else
        {
            work->ringLossTimer = 60;
        }
    }

    s32 digit3 = status->rings % 10;
    s32 digit2 = (s32)(-100 * (status->rings / 100) - -10 * (status->rings / 10)) / 10;
    s32 digit1 = (s32)(-1000 * (status->rings / 1000) - (-10 * (status->rings / 10) + digit2)) / 100;

    if (digit1 == 0 && digit2 == 0)
    {
        for (s16 i = 0; i < 10u; i++)
        {
            exDrawReqTask__Sprite2D__Animate(&work->aniNumbersWarning[i]);
        }

        work->aniNumbersWarning[digit1].pos.x = work->digit1Pos.x;
        work->aniNumbersWarning[digit1].pos.y = work->digit1Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbersWarning[digit1], &work->aniNumbersWarning[digit1].config);

        work->aniNumbersWarning[digit2].pos.x = work->digit2Pos.x;
        work->aniNumbersWarning[digit2].pos.y = work->digit2Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbersWarning[digit2], &work->aniNumbersWarning[digit2].config);

        work->aniNumbersWarning[digit3].pos.x = work->digit3Pos.x;
        work->aniNumbersWarning[digit3].pos.y = work->digit3Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbersWarning[digit3], &work->aniNumbersWarning[digit3].config);
    }
    else
    {
        for (s16 i = 0; i < 10u; i++)
        {
            exDrawReqTask__Sprite2D__Animate(&work->aniNumbers[i]);
        }

        work->aniNumbers[digit1].pos.x = work->digit1Pos.x;
        work->aniNumbers[digit1].pos.y = work->digit1Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbers[digit1], &work->aniNumbers[digit1].config);

        work->aniNumbers[digit2].pos.x = work->digit2Pos.x;
        work->aniNumbers[digit2].pos.y = work->digit2Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbers[digit2], &work->aniNumbers[digit2].config);

        work->aniNumbers[digit3].pos.x = work->digit3Pos.x;
        work->aniNumbers[digit3].pos.y = work->digit3Pos.y;
        exDrawReqTask__AddRequest(&work->aniNumbers[digit3], &work->aniNumbers[digit3].config);
    }

    RunCurrentExTaskUnknownEvent();
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exSysTask__GetStatus
	mov r5, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r4, #0x10
	add r1, r4, #0x90
	bl exDrawReqTask__AddRequest
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02169AD4
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02169AD4
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	beq _02169AD4
	ldrh r0, [r5, #6]
	cmp r0, #0
	beq _02169ACC
	ldrsh r1, [r4, #0]
	sub r0, r1, #1
	strh r0, [r4]
	cmp r1, #0
	bge _02169AD4
	mov r0, #0x3c
	strh r0, [r4]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02169AD4
	ldrh r0, [r5, #6]
	sub r0, r0, #1
	strh r0, [r5, #6]
	b _02169AD4
_02169ACC:
	mov r0, #0x3c
	strh r0, [r4]
_02169AD4:
	ldrh ip, [r5, #6]
	ldr r0, =0x66666667
	ldr r2, =0x51EB851F
	smull r3, r6, r0, ip
	smull r3, r5, r2, ip
	mov r1, ip, lsr #0x1f
	ldr r8, =0x10624DD3
	add r6, r1, r6, asr #2
	mov r7, #0xa
	smull r6, r3, r7, r6
	smull r7, r3, r8, ip
	add r5, r1, r5, asr #5
	mov r8, #0x64
	smull r5, r7, r8, r5
	add r3, r1, r3, asr #6
	mov r8, #0x3e8
	sub r6, ip, r6
	sub r5, ip, r5
	smull r7, r1, r8, r3
	sub r3, r5, r6
	mov r1, r3, lsr #0x1f
	smull r3, r5, r0, r3
	add r5, r1, r5, asr #2
	sub r3, ip, r7
	add r0, r6, r5
	sub r1, r3, r0
	smull r0, r7, r2, r1
	mov r0, r1, lsr #0x1f
	adds r7, r0, r7, asr #5
	cmpeq r5, #0
	mov r9, #0
	bne _02169C34
	add r0, r4, #0x1e8
	add r8, r0, #0x400
_02169B5C:
	mov r0, r8
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, #0xa
	add r8, r8, #0x88
	blo _02169B5C
	mov r0, #0x88
	mul r1, r7, r0
	add r0, r4, r1
	ldrsh r3, [r4, #2]
	add r2, r0, #0x600
	add r0, r4, #0x1e8
	strh r3, [r2, #0x50]
	add r3, r4, #0x268
	ldrsh r7, [r4, #4]
	add r0, r0, #0x400
	add r3, r3, #0x400
	add r0, r0, r1
	add r1, r3, r1
	strh r7, [r2, #0x52]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r7, r5, r0
	add r2, r4, r7
	add r0, r4, #0x1e8
	add r1, r4, #0x268
	add r0, r0, #0x400
	add r1, r1, #0x400
	ldrsh r3, [r4, #6]
	add r2, r2, #0x600
	add r0, r0, r7
	strh r3, [r2, #0x50]
	ldrsh r3, [r4, #8]
	add r1, r1, r7
	strh r3, [r2, #0x52]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r5, r6, r0
	add r2, r4, r5
	add r0, r4, #0x1e8
	add r1, r4, #0x268
	add r0, r0, #0x400
	add r1, r1, #0x400
	ldrsh r3, [r4, #0xa]
	add r2, r2, #0x600
	add r0, r0, r5
	strh r3, [r2, #0x50]
	ldrsh r3, [r4, #0xc]
	add r1, r1, r5
	strh r3, [r2, #0x52]
	bl exDrawReqTask__AddRequest
	b _02169CF4
_02169C34:
	add r8, r4, #0x98
_02169C38:
	mov r0, r8
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, #0xa
	add r8, r8, #0x88
	blo _02169C38
	mov r0, #0x88
	mul r8, r7, r0
	add r0, r4, r8
	ldrsh r1, [r4, #2]
	add r2, r0, #0x100
	add r0, r4, #0x98
	strh r1, [r2]
	ldrsh r3, [r4, #4]
	add r1, r4, #0x118
	add r0, r0, r8
	add r1, r1, r8
	strh r3, [r2, #2]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r7, r5, r0
	add r2, r4, r7
	add r0, r4, #0x98
	add r1, r4, #0x118
	ldrsh r3, [r4, #6]
	add r2, r2, #0x100
	add r0, r0, r7
	strh r3, [r2]
	ldrsh r3, [r4, #8]
	add r1, r1, r7
	strh r3, [r2, #2]
	bl exDrawReqTask__AddRequest
	mov r0, #0x88
	mul r5, r6, r0
	add r2, r4, r5
	add r0, r4, #0x98
	add r1, r4, #0x118
	ldrsh r3, [r4, #0xa]
	add r2, r2, #0x100
	add r0, r0, r5
	strh r3, [r2]
	ldrsh r3, [r4, #0xc]
	add r1, r1, r5
	strh r3, [r2, #2]
	bl exDrawReqTask__AddRequest
_02169CF4:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
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

    work->aniPlayerIcon.anim       = EX_ACTCOM_ANI_16;
    work->aniPlayerIcon.paletteRow = PALETTE_ROW_0;
    SetupExHUDSprite(&work->aniPlayerIcon);
    exDrawReqTask__SetConfigPriority(&work->aniPlayerIcon.config, 0xE000);
    work->aniPlayerIcon.pos.x                   = 0;
    work->aniPlayerIcon.pos.y                   = 0;
    work->aniPlayerIcon.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniPlayerIcon);

    work->aniX.anim       = EX_ACTCOM_ANI_19;
    work->aniX.paletteRow = PALETTE_ROW_2;
    SetupExHUDSprite(&work->aniX);
    exDrawReqTask__SetConfigPriority(&work->aniX.config, 0xE001);
    work->aniX.pos.x                   = 0;
    work->aniX.pos.y                   = 0;
    work->aniX.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniX);

    for (u16 i = 0; i < 10; i++)
    {
        work->aniNumbers[i].anim       = exHUDLifeDigits[i];
        work->aniNumbers[i].paletteRow = PALETTE_ROW_2;
        SetupExHUDSprite(&work->aniNumbers[i]);
        exDrawReqTask__SetConfigPriority(&work->aniNumbers[i].config, 0xE001);
        work->aniNumbers[i].pos.x                   = 0;
        work->aniNumbers[i].pos.y                   = 0;
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
    for (u16 i = 0; i < 10; i++)
    {
        ReleaseExHUDSprite(&work->aniNumbers[i]);
    }

    exHUDLifeTaskSingleton = NULL;
}

void ExLifeCountHUD_Main_Active(void)
{
    exFixRemainderTask *work = ExTaskGetWorkCurrent(exFixRemainderTask);

    ExSysTaskStatus *status = exSysTask__GetStatus();

    s32 lifeDigit2 = status->lives % 10;
    s32 lifeDigit1 = (status->lives % 100 - lifeDigit2) / 10;

    exDrawReqTask__Sprite2D__Animate(&work->aniNumbers[lifeDigit1]);
    exDrawReqTask__Sprite2D__Animate(&work->aniNumbers[lifeDigit2]);
    exDrawReqTask__Sprite2D__Animate(&work->aniX);
    exDrawReqTask__Sprite2D__Animate(&work->aniPlayerIcon);

    EX_ACTION_BAC2D_WORK *aniDigit2    = &work->aniNumbers[lifeDigit1];
    work->aniNumbers[lifeDigit1].pos.x = work->digit1Pos.x;
    work->aniNumbers[lifeDigit1].pos.y = work->digit1Pos.y;
    exDrawReqTask__AddRequest(&work->aniNumbers[lifeDigit1], &work->aniNumbers[lifeDigit1].config);

    work->aniNumbers[lifeDigit2].pos.x = work->digit2Pos.x;
    work->aniNumbers[lifeDigit2].pos.y = work->digit2Pos.y;
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

void ExBossLifeGaugeHUD_Main(void)
{
    exFixBossLifeGaugeTask *work = ExTaskGetWorkCurrent(exFixBossLifeGaugeTask);

    exHUDBossGaugeTaskSingleton = GetCurrentTask();

    work->boss                   = ExBossSysAdminTask__GetBossWork();
    work->aniBossName.anim       = EX_ACTCOM_ANI_30;
    work->aniBossName.paletteRow = PALETTE_ROW_9;
    SetupExHUDSprite(&work->aniBossName);
    exDrawReqTask__SetConfigPriority(&work->aniBossName.config, 0xE000);
    work->aniBossName.pos.x                   = 57;
    work->aniBossName.pos.y                   = 176;
    work->aniBossName.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniBossName);

    work->aniCapL.anim       = EX_ACTCOM_ANI_20;
    work->aniCapL.paletteRow = PALETTE_ROW_9;
    SetupExHUDSprite(&work->aniCapL);
    exDrawReqTask__SetConfigPriority(&work->aniCapL.config, 0xE000);
    work->aniCapL.pos.x                   = 56;
    work->aniCapL.pos.y                   = 176;
    work->aniCapL.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniCapL);

    work->aniCapR.anim       = EX_ACTCOM_ANI_20;
    work->aniCapR.paletteRow = PALETTE_ROW_9;
    SetupExHUDSprite(&work->aniCapR);
    exDrawReqTask__SetConfigPriority(&work->aniCapR.config, 0xE000);
    work->aniCapR.pos.x                   = 248;
    work->aniCapR.pos.y                   = 176;
    work->aniCapR.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniCapR);
    work->aniCapR.animator.flags |= ANIMATOR_FLAG_FLIP_X;

    for (s16 i = 0; i < 9; i++)
    {
        work->aniLifeGauge[i].anim       = i + EX_ACTCOM_ANI_21;
        work->aniLifeGauge[i].paletteRow = PALETTE_ROW_9;
        SetupExHUDSprite(&work->aniLifeGauge[i]);
        exDrawReqTask__SetConfigPriority(&work->aniLifeGauge[i].config, 0xDFFF);
        work->aniLifeGauge[i].pos.x                   = 0;
        work->aniLifeGauge[i].pos.y                   = work->aniCapL.pos.y;
        work->aniLifeGauge[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniLifeGauge[i]);
    }

    work->boss->field_64    = -16 - work->aniCapL.pos.x + work->aniCapR.pos.x;
    work->boss->field_62    = work->boss->field_64;
    work->totalSegmentCount = work->boss->field_62 / 8;
    work->health            = work->boss->field_64;
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
    for (u16 i = 0; i < 9; i++)
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

    ExSysTaskStatus *status = exSysTask__GetStatus();
    UNUSED(status);

    exDrawReqTask__Sprite2D__Animate(&work->aniBossName);
    exDrawReqTask__Sprite2D__Animate(&work->aniCapL);
    exDrawReqTask__Sprite2D__Animate(&work->aniCapR);

    if (exSysTask__GetStatus()->state == EXSYSTASK_STATE_11 || exSysTask__GetStatus()->state == EXSYSTASK_STATE_7 || exSysTask__GetStatus()->state == EXSYSTASK_STATE_9
        || exSysTask__GetStatus()->state == EXSYSTASK_STATE_5)
    {
        work->healthChange       = 0;
        work->health             = work->boss->field_62;
        work->healthSegmentCount = work->boss->field_62 / 8;
        work->healthSegmentPos   = work->boss->field_62 % 8;
    }
    else
    {
        s16 curHealth  = work->boss->field_62;
        s16 prevHealth = work->health;
        if (prevHealth != curHealth)
        {
            work->healthChange  = prevHealth - curHealth;
            work->health        = work->boss->field_62;
            work->healthChangeF = work->healthChange;

            SetCurrentExTaskMainEvent(ExBossLifeGaugeHUD_Main_HealthChanging);
            ExBossLifeGaugeHUD_Main_HealthChanging();
            return;
        }

        work->healthSegmentCount = work->boss->field_62 / 8;
        work->healthSegmentPos   = work->boss->field_62 % 8;
    }

    s16 remainLifeAnim = 8 - work->healthSegmentPos;
    for (i = 0; i < 9; i++)
    {
        exDrawReqTask__Sprite2D__Animate(&work->aniLifeGauge[i]);
    }

    remainLifePos = 0;
    i             = 0;
    for (; i < work->totalSegmentCount; i++)
    {
        if (i < work->healthSegmentCount)
        {
            work->aniLifeGauge[0].pos.x = work->aniCapL.pos.x + 8 * (i + 1);
            exDrawReqTask__AddRequest(work->aniLifeGauge, &work->aniLifeGauge[0].config);
            remainLifePos = i + 1;
        }
        else
        {
            work->aniLifeGauge[8].pos.x = work->aniCapL.pos.x + 8 * (i + 1);
            exDrawReqTask__AddRequest(&work->aniLifeGauge[8], &work->aniLifeGauge[8].config);
        }
    }

    if (remainLifeAnim != 8)
    {
        work->aniLifeGauge[remainLifeAnim].pos.x = work->aniCapL.pos.x + (s16)(8 * (remainLifePos + 1));
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

    ExSysTaskStatus *status = exSysTask__GetStatus();
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
            work->healthSegmentCount = (work->boss->field_62 + work->healthChange) / 8;
            work->healthSegmentPos   = (work->boss->field_62 + work->healthChange) % 8;
        }
        else
        {
            work->healthChange = 0;
            work->health       = work->boss->field_62;
        }

        s16 remainLifeAnim = 8 - work->healthSegmentPos;
        for (i = 0; i < 9; i++)
        {
            exDrawReqTask__Sprite2D__Animate(&work->aniLifeGauge[i]);
        }

        remainLifePos = 0;
        i             = 0;
        for (; i < work->totalSegmentCount; i++)
        {
            if (i < work->healthSegmentCount)
            {
                work->aniLifeGauge[0].pos.x = work->aniCapL.pos.x + 8 * (i + 1);
                exDrawReqTask__AddRequest(work->aniLifeGauge, &work->aniLifeGauge[0].config);
                remainLifePos = i + 1;
            }
            else
            {
                work->aniLifeGauge[8].pos.x = work->aniCapL.pos.x + 8 * (i + 1);
                exDrawReqTask__AddRequest(&work->aniLifeGauge[8], &work->aniLifeGauge[8].config);
            }
        }

        if (remainLifeAnim != 8)
        {
            work->aniLifeGauge[remainLifeAnim].pos.x = work->aniCapL.pos.x + (s16)(8 * (remainLifePos + 1));
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
    Task *task = ExTaskCreate(ExBossLifeGaugeHUD_Main, ExBossLifeGaugeHUD_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR,
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

    ExSysTaskStatus *status = exSysTask__GetStatus();
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

    if (exSysTask__GetStatus()->state == EXSYSTASK_STATE_4)
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
    exMsgTutorialTask__Create();

    SetCurrentExTaskMainEvent(ExHUD_Main_WaitForBossHUD);
    ExHUD_Main_WaitForBossHUD();
}

void ExHUD_Main_WaitForBossHUD(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    if (exSysTask__GetStatus()->state > EXSYSTASK_STATE_4)
        ExHUD_Action_CreateBossHUD();
}

void ExHUD_Action_CreateBossHUD(void)
{
    exFixAdminTask *work = ExTaskGetWorkCurrent(exFixAdminTask);
    UNUSED(work);

    exMsgTutorialTask__Destroy();
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