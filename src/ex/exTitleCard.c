#include <ex/core/exTitleCard.h>
#include <ex/core/exTutorialMessage.h>
#include <ex/core/exHUD.h>
#include <ex/system/exSystem.h>
#include <game/audio/audioSystem.h>
#include <game/input/padInput.h>

// --------------------
// VARIABLES
// --------------------

struct TEMP_STATIC_VARS
{
    void *exMsgTitleTask__TaskSingleton;
    void *exMsgTutorialTask__TaskSingleton;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21775C0;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177648;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21776D0;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177758;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21777E0;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177868;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21778F0;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177978;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177A00;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177A88;
    EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177B10;
};

NOT_DECOMPILED struct TEMP_STATIC_VARS exMsgTitleTask__sVars;

// NOT_DECOMPILED void *exMsgTitleTask__TaskSingleton;
NOT_DECOMPILED void *exMsgTutorialTask__TaskSingleton;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21775C0;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177648;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21776D0;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177758;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21777E0;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177868;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_21778F0;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177978;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177A00;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177A88;
NOT_DECOMPILED EX_ACTION_BAC2D_WORK exMsgTitleTask__byte_2177B10;

static u16 exTutorialMessageTextAnims[EXPLAYER_CHARACTER_COUNT][OS_LANGUAGE_CODE_MAX] = {
    [EXPLAYER_CHARACTER_SONIC] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_JPN,
                                   [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_ENG,
                                   [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_FRA,
                                   [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_DEU,
                                   [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_ITA,
                                   [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_SPA },

    [EXPLAYER_CHARACTER_BLAZE] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_JPN,
                                   [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_ENG,
                                   [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_FRA,
                                   [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_DEU,
                                   [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_ITA,
                                   [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_SPA },
};

static u16 exTutorialMessageTextScrollLimit[EXPLAYER_CHARACTER_COUNT][OS_LANGUAGE_CODE_MAX] = {
    [EXPLAYER_CHARACTER_SONIC] = { [OS_LANGUAGE_JAPANESE] = 392,
                                   [OS_LANGUAGE_ENGLISH]  = 488,
                                   [OS_LANGUAGE_FRENCH]   = 472,
                                   [OS_LANGUAGE_GERMAN]   = 496,
                                   [OS_LANGUAGE_ITALIAN]  = 432,
                                   [OS_LANGUAGE_SPANISH]  = 432 },

    [EXPLAYER_CHARACTER_BLAZE] = { [OS_LANGUAGE_JAPANESE] = 376,
                                   [OS_LANGUAGE_ENGLISH]  = 368,
                                   [OS_LANGUAGE_FRENCH]   = 392,
                                   [OS_LANGUAGE_GERMAN]   = 352,
                                   [OS_LANGUAGE_ITALIAN]  = 400,
                                   [OS_LANGUAGE_SPANISH]  = 384 },
};

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _f_ftoi(void);
NOT_DECOMPILED void _f_itof(void);
NOT_DECOMPILED void _fdiv(void);

// --------------------
// FUNCTION DECLS
// --------------------

// ExTutorialMessage
static u16 GetExTutorialMessageLanguage(void);
static void ExTutorialMessage_Main_Init(void);
static void ExTutorialMessage_TaskUnknown(void);
static void ExTutorialMessage_Destructor(void);
static void ExTutorialMessage_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

// ExTutorialMessage
u16 GetExTutorialMessageLanguage(void)
{
    s32 id = 0;
    switch (*RenderCore_GetLanguagePtr())
    {
        case OS_LANGUAGE_JAPANESE:
            id = 0;
            break;

        case OS_LANGUAGE_ENGLISH:
            id = 1;
            break;

        case OS_LANGUAGE_FRENCH:
            id = 2;
            break;

        case OS_LANGUAGE_GERMAN:
            id = 3;
            break;

        case OS_LANGUAGE_ITALIAN:
            id = 4;
            break;

        case OS_LANGUAGE_SPANISH:
            id = 5;
            break;

        default:
            id = 1;
            break;
    }

    return id;
}

void ExTutorialMessage_Main_Init(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);

    exMsgTitleTask__sVars.exMsgTutorialTask__TaskSingleton = GetCurrentTask();

    work->language     = GetExTutorialMessageLanguage();
    work->playerWorker = exPlayerAdminTask__GetUnknown2();

    for (u16 i = 0; i < EXPLAYER_CHARACTER_COUNT; i++)
    {
        work->aniMessage[i].sprite.anim       = exTutorialMessageTextAnims[i][work->language];
        work->aniMessage[i].sprite.paletteRow = PALETTE_ROW_3;
        SetupExHUDSprite(&work->aniMessage[i]);
        exDrawReqTask__SetConfigPriority(&work->aniMessage[i].config, 0xE002);
        work->aniMessage[i].sprite.pos.x            = 0;
        work->aniMessage[i].sprite.pos.y            = 0;
        work->aniMessage[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniMessage[i]);
        exDrawReqTask__Func_21641F0(&work->aniMessage[i].config);
    }

    work->aniBorder.sprite.anim       = EX_ACTCOM_ANI_TUTORIAL_TEXT_BACKDROP;
    work->aniBorder.sprite.paletteRow = PALETTE_ROW_3;
    SetupExHUDSprite(&work->aniBorder);
    exDrawReqTask__SetConfigPriority(&work->aniBorder.config, 0xE001);
    work->aniBorder.sprite.pos.x            = 0;
    work->aniBorder.sprite.pos.y            = 0;
    work->aniBorder.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniBorder);
    exDrawReqTask__Func_21641F0(&work->aniBorder.config);
    work->aniBorder.sprite.field_78 = 5;

    work->scrollPos = 128;

    SetCurrentExTaskMainEvent(ExTutorialMessage_Main_Active);
}

void ExTutorialMessage_TaskUnknown(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);
    UNUSED(work);

    if (GetExSystemFlag_2178650())
        DestroyCurrentExTask();
}

void ExTutorialMessage_Destructor(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);

    ReleaseExHUDSprite(&work->aniMessage[EXPLAYER_CHARACTER_SONIC]);
    ReleaseExHUDSprite(&work->aniMessage[EXPLAYER_CHARACTER_BLAZE]);
    ReleaseExHUDSprite(&work->aniBorder);

    exMsgTitleTask__sVars.exMsgTutorialTask__TaskSingleton = NULL;
}

void ExTutorialMessage_Main_Active(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);

    u8 character = EXPLAYER_CHARACTER_SONIC;
    if (work->playerWorker->activeCharacter.value_1)
        character = EXPLAYER_CHARACTER_BLAZE;

    exDrawReqTask__Sprite2D__Animate(&work->aniMessage[character]);
    exDrawReqTask__Sprite2D__Animate(&work->aniBorder);

    s32 scrollLimit = exTutorialMessageTextScrollLimit[character][work->language];

    if (work->scrollPos <= -(scrollLimit - 128))
        work->scrollPos = 128;
    else
        work->scrollPos--;

    work->aniMessage[character].sprite.pos.x = work->scrollPos;
    exDrawReqTask__AddRequest(&work->aniMessage[character], &work->aniMessage[character].config);

    work->aniMessage[character].sprite.pos.x -= scrollLimit;
    exDrawReqTask__AddRequest(&work->aniMessage[character], &work->aniMessage[character].config);
    work->aniMessage[character].sprite.pos.x += scrollLimit;

    work->aniMessage[character].sprite.pos.x += scrollLimit;
    exDrawReqTask__AddRequest(&work->aniMessage[character], &work->aniMessage[character].config);
    work->aniMessage[character].sprite.pos.x -= scrollLimit;

    exDrawReqTask__AddRequest(&work->aniBorder, &work->aniBorder.config);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExTutorialMessage(void)
{
    Task *task =
        ExTaskCreate(ExTutorialMessage_Main_Init, ExTutorialMessage_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exMsgTutorialTask);

    exMsgTutorialTask *work = ExTaskGetWork(task, exMsgTutorialTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExTutorialMessage_TaskUnknown);

    return TRUE;
}

void DestroyExTutorialMessage(void)
{
    if (exMsgTitleTask__sVars.exMsgTutorialTask__TaskSingleton != NULL)
        DestroyExTask(exMsgTitleTask__sVars.exMsgTutorialTask__TaskSingleton);
}

// ExTitleCard
NONMATCH_FUNC void exMsgTitleTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exMsgTitleTask__sVars
	ldr r2, =exMsgTitleTask__byte_2177B10
	str r0, [r1]
	ldr r1, =exMsgTitleTask__byte_2177A88
	str r2, [r4, #8]
	ldr r0, =exMsgTitleTask__byte_21776D0
	str r1, [r4, #0xc]
	ldr r1, =exMsgTitleTask__byte_2177A00
	str r0, [r4, #0x10]
	ldr r0, =exMsgTitleTask__byte_21777E0
	str r1, [r4, #0x14]
	ldr r1, =exMsgTitleTask__byte_21775C0
	str r0, [r4, #0x18]
	ldr r0, =exMsgTitleTask__byte_2177648
	str r1, [r4, #0x1c]
	ldr r1, =exMsgTitleTask__byte_2177978
	str r0, [r4, #0x20]
	ldr r0, =exMsgTitleTask__byte_21778F0
	str r1, [r4, #0x24]
	ldr r1, =exMsgTitleTask__byte_2177758
	str r0, [r4, #0x28]
	ldr r0, =exMsgTitleTask__byte_2177868
	str r1, [r4, #0x2c]
	str r0, [r4, #0x30]
	ldr r0, [r4, #8]
	mov r1, #0x41
	strh r1, [r0]
	ldr r0, [r4, #8]
	mov r1, #4
	strh r1, [r0, #2]
	ldr r0, [r4, #8]
	bl SetupExHUDSprite
	ldr r0, [r4, #8]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #8]
	mov r1, #0
	strh r1, [r0, #0x68]
	ldr r0, [r4, #8]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #8]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #8]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0xc]
	mov r1, #0x4b
	strh r1, [r0]
	ldr r0, [r4, #0xc]
	mov r1, #6
	strh r1, [r0, #2]
	ldr r0, [r4, #0xc]
	bl SetupExHUDSprite
	ldr r0, [r4, #0xc]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0
	ldr r0, [r4, #0xc]
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0xc]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0xc]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0xc]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r2, #0x42
	ldr r0, [r4, #0x10]
	mov r1, #5
	strh r2, [r0]
	ldr r0, [r4, #0x10]
	strh r1, [r0, #2]
	ldr r0, [r4, #0x10]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x10]
	ldr r1, =0x0000E001
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #0x10]
	mov r1, #0x80
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x10]
	mov r1, #0x60
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x10]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x10]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0x14]
	mov r1, #0x43
	strh r1, [r0]
	ldr r0, [r4, #0x14]
	mov r1, #6
	strh r1, [r0, #2]
	ldr r0, [r4, #0x14]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x14]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #0x14]
	mov r1, #0
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x14]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x14]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x14]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0x18]
	mov r1, #0x44
	strh r1, [r0]
	ldr r0, [r4, #0x18]
	mov r1, #6
	strh r1, [r0, #2]
	ldr r0, [r4, #0x18]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x18]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0
	ldr r0, [r4, #0x18]
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x18]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x18]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x18]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r2, #0x45
	ldr r0, [r4, #0x1c]
	mov r1, #6
	strh r2, [r0]
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #2]
	ldr r0, [r4, #0x1c]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x1c]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x1c]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x1c]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r2, #0x46
	ldr r0, [r4, #0x20]
	mov r1, #6
	strh r2, [r0]
	ldr r0, [r4, #0x20]
	strh r1, [r0, #2]
	ldr r0, [r4, #0x20]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x20]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #0x20]
	mov r1, #0
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x20]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x20]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x20]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0x24]
	mov r1, #0x47
	strh r1, [r0]
	ldr r0, [r4, #0x24]
	mov r1, #6
	strh r1, [r0, #2]
	ldr r0, [r4, #0x24]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x24]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #0x24]
	mov r1, #0
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x24]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x24]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x24]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r2, #0x48
	ldr r0, [r4, #0x28]
	mov r1, #6
	strh r2, [r0]
	ldr r0, [r4, #0x28]
	strh r1, [r0, #2]
	ldr r0, [r4, #0x28]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x28]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0
	ldr r0, [r4, #0x28]
	strh r1, [r0, #0x68]
	ldr r0, [r4, #0x28]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x28]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r4, #0x28]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r0, #0x1e
	strh r0, [r4]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Main_216CCF4
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func8(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =GetExTaskWorkCurrent_
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x30]
	bl ReleaseExHUDSprite
	ldr r0, =exMsgTitleTask__sVars
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Main_216CCF4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0]
	sub r1, r2, #1
	strh r1, [r0]
	cmp r2, #0
	bgt _0216CD18
	bl exMsgTitleTask__Func_216CD28
	ldmia sp!, {r3, pc}
_0216CD18:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216CD28(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov lr, #0x80
	ldr r0, [r4, #8]
	sub r6, lr, #0xe0
	strh lr, [r0, #0x68]
	ldr r0, [r4, #8]
	ldr ip, =0x00001CCD
	strh r6, [r0, #0x6a]
	ldr r1, [r4, #8]
	mov r0, #0
	str ip, [r1, #0x6c]
	ldr r2, [r4, #8]
	sub r1, r0, #1
	str ip, [r2, #0x70]
	ldr r3, [r4, #0x10]
	mov r2, r1
	strh lr, [r3, #0x68]
	ldr r5, [r4, #0x10]
	add lr, lr, #0x92
	strh r6, [r5, #0x6a]
	ldr r5, [r4, #0x10]
	mov r3, r1
	str ip, [r5, #0x6c]
	ldr r5, [r4, #0x10]
	str ip, [r5, #0x70]
	stmia sp, {r0, lr}
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #2]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Main_216CDC8
	str r1, [r0]
	bl exMsgTitleTask__Main_216CDC8
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Main_216CDC8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x10]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0216CE14
	tst r0, #2
	bne _0216CE14
	tst r0, #0x400
	bne _0216CE14
	tst r0, #0x800
	bne _0216CE14
	tst r0, #8
	beq _0216CE1C
_0216CE14:
	bl exMsgTitleTask__Func_216D564
	ldmia sp!, {r3, r4, r5, pc}
_0216CE1C:
	ldr r1, [r4, #8]
	ldrh r0, [r1, #0x74]
	add r0, r0, #0x11
	add r0, r0, #0x1100
	strh r0, [r1, #0x74]
	ldr r1, [r4, #0x10]
	ldrh r0, [r1, #0x74]
	add r0, r0, #0x11
	add r0, r0, #0x1100
	strh r0, [r1, #0x74]
	ldr r1, [r4, #8]
	ldrsh r0, [r1, #0x6a]
	cmp r0, #0x50
	bge _0216CE6C
	add r0, r0, #4
	strh r0, [r1, #0x6a]
	ldr r1, [r4, #0x10]
	ldrsh r0, [r1, #0x6a]
	add r0, r0, #4
	strh r0, [r1, #0x6a]
_0216CE6C:
	ldrsh r0, [r4, #2]
	ldr r1, =0xFFFFF334
	mvn r2, #0
	add r0, r0, #0x5b
	strh r0, [r4, #2]
	ldrsh r0, [r4, #2]
	ldr r3, [r4, #8]
	umull ip, r5, r0, r1
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	adds ip, ip, #0x800
	mla r5, r0, r1, r5
	adc r0, r5, #0
	mov r5, ip, lsr #0xc
	orr r5, r5, r0, lsl #20
	add r0, r5, #0xcc
	add r0, r0, #0x1c00
	str r0, [r3, #0x6c]
	ldrsh r0, [r4, #2]
	ldr r3, [r4, #8]
	umull ip, r5, r0, r1
	adds ip, ip, #0x800
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r1, r5
	adc r0, r5, #0
	mov r5, ip, lsr #0xc
	orr r5, r5, r0, lsl #20
	add r0, r5, #0xcc
	add r0, r0, #0x1c00
	str r0, [r3, #0x70]
	ldrsh r0, [r4, #2]
	ldr r3, [r4, #0x10]
	umull ip, r5, r0, r1
	adds ip, ip, #0x800
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r1, r5
	adc r0, r5, #0
	mov r5, ip, lsr #0xc
	orr r5, r5, r0, lsl #20
	add r0, r5, #0xcc
	add r0, r0, #0x1c00
	str r0, [r3, #0x6c]
	ldrsh ip, [r4, #2]
	ldr r3, [r4, #0x10]
	mov r0, ip, asr #0x1f
	umull r5, lr, ip, r1
	mla lr, ip, r2, lr
	mla lr, r0, r1, lr
	adds r1, r5, #0x800
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xcc
	add r0, r0, #0x1c00
	str r0, [r3, #0x70]
	ldrsh r0, [r4, #2]
	cmp r0, #0x1000
	blt _0216CF64
	bl exMsgTitleTask__Func_216CF94
	ldmia sp!, {r3, r4, r5, pc}
_0216CF64:
	ldr r0, [r4, #8]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x10]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216CF94(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr ip, =0x00000113
	mov r4, r0
	sub r1, ip, #0x114
	mov r0, #0
	stmia sp, {r0, ip}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #8]
	mov ip, #0x80
	strh ip, [r0, #0x68]
	ldr r0, [r4, #8]
	mov r3, #0x50
	strh r3, [r0, #0x6a]
	ldr r0, [r4, #8]
	mov r2, #0x1000
	str r2, [r0, #0x6c]
	ldr r0, [r4, #8]
	str r2, [r0, #0x70]
	ldr r1, [r4, #8]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r0, [r4, #0x10]
	strh ip, [r0, #0x68]
	ldr r0, [r4, #0x10]
	strh r3, [r0, #0x6a]
	ldr r0, [r4, #0x10]
	str r2, [r0, #0x6c]
	ldr r0, [r4, #0x10]
	str r2, [r0, #0x70]
	ldr r1, [r4, #0x10]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0xc]
	ldrsh r1, [r1, #0x68]
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0xc]
	ldrsh r1, [r1, #0x6a]
	sub r1, r1, #0x30
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0xc]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x14]
	ldrsh r1, [r1, #0x68]
	add r1, r1, #0x20
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x14]
	ldrsh r1, [r1, #0x6a]
	add r1, r1, #0x1c
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0x14]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x18]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #0x4c
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x18]
	ldrsh r1, [r1, #0x6a]
	add r1, r1, #0x33
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0x18]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x1c]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #0x34
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x1c]
	ldrsh r1, [r1, #0x6a]
	add r1, r1, #0x33
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0x1c]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x20]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #0x1c
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x20]
	ldrsh r1, [r1, #0x6a]
	add r1, r1, #0x33
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0x20]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x24]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #4
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x24]
	ldrsh r1, [r1, #0x6a]
	add r1, r1, #0x33
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0x24]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x28]
	ldrsh r1, [r1, #0x68]
	add r1, r1, #0x14
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x28]
	ldrsh r1, [r1, #0x6a]
	add r1, r1, #0x33
	strh r1, [r0, #0x6a]
	ldr r1, [r4, #0x28]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Func_216D1D0
	str r1, [r0]
	bl exMsgTitleTask__Func_216D1D0
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D1D0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x10]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0xc]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x14]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x18]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x1c]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x20]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x24]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x28]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0216D254
	tst r0, #2
	bne _0216D254
	tst r0, #0x400
	bne _0216D254
	tst r0, #0x800
	bne _0216D254
	tst r0, #8
	beq _0216D25C
_0216D254:
	bl exMsgTitleTask__Func_216D564
	ldmia sp!, {r4, pc}
_0216D25C:
	ldr r0, [r4, #0x28]
	bl exDrawReqTask__Sprite2D__IsAnimFinished
	cmp r0, #0
	beq _0216D274
	bl exMsgTitleTask__Func_216D300
	ldmia sp!, {r4, pc}
_0216D274:
	bl GetExTutorialMessageLanguage
	cmp r0, #0
	bne _0216D28C
	ldr r0, [r4, #0xc]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
_0216D28C:
	ldr r0, [r4, #0x14]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x18]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x1c]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x20]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x24]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x28]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #8]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x10]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D300(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0
	strh r1, [r0, #4]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Func_216D328
	str r1, [r0]
	bl exMsgTitleTask__Func_216D328
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D328(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, =padInput
	mov r4, r0
	ldrh r0, [r1, #4]
	tst r0, #1
	bne _0216D364
	tst r0, #2
	bne _0216D364
	tst r0, #0x400
	bne _0216D364
	tst r0, #0x800
	bne _0216D364
	tst r0, #8
	beq _0216D36C
_0216D364:
	bl exMsgTitleTask__Func_216D564
	ldmia sp!, {r4, r5, r6, pc}
_0216D36C:
	ldr r0, [r4, #8]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x10]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0xc]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x14]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x18]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x1c]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x20]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x24]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x28]
	bl exDrawReqTask__Sprite2D__Animate
	ldrsh r1, [r4, #4]
	mov r0, #0x100000
	rsb r0, r0, #0
	add r1, r1, #0x66
	strh r1, [r4, #4]
	ldrsh r3, [r4, #4]
	mov r1, #2
	mov lr, #0
	mov r2, r3, asr #0x1f
	mov ip, #0x800
_0216D3DC:
	sub r0, r0, #0x80000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	add r0, r5, #0x80000
	sub r1, r1, #1
	bne _0216D3DC
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldr r1, [r4, #8]
	strh r0, [r1, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x10]
	ldrsh r1, [r1, #0x68]
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0xc]
	ldrsh r1, [r1, #0x68]
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x14]
	ldrsh r1, [r1, #0x68]
	add r1, r1, #0x20
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x18]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #0x4c
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x1c]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #0x34
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x20]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #0x1c
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x24]
	ldrsh r1, [r1, #0x68]
	sub r1, r1, #4
	strh r1, [r0, #0x68]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x28]
	ldrsh r1, [r1, #0x68]
	add r1, r1, #0x14
	strh r1, [r0, #0x68]
	ldrsh r0, [r4, #4]
	cmp r0, #0x1000
	blt _0216D4D4
	bl exMsgTitleTask__Func_216D564
	ldmia sp!, {r4, r5, r6, pc}
_0216D4D4:
	bl GetExTutorialMessageLanguage
	cmp r0, #0
	bne _0216D4EC
	ldr r0, [r4, #0xc]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
_0216D4EC:
	ldr r0, [r4, #0x14]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x18]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x1c]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x20]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x24]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x28]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #8]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x10]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D564(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x10]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0xc]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x14]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x18]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x1c]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x20]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x24]
	bl ReleaseExHUDSprite
	ldr r0, [r4, #0x28]
	bl ReleaseExHUDSprite
	mov r2, #0x4a
	ldr r0, [r4, #0x2c]
	mov r1, #7
	strh r2, [r0]
	ldr r0, [r4, #0x2c]
	strh r1, [r0, #2]
	ldr r0, [r4, #0x2c]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x2c]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	mov r2, #0x80
	ldr r0, [r4, #0x2c]
	mov r1, #0x60
	strh r2, [r0, #0x68]
	ldr r0, [r4, #0x2c]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x2c]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r1, [r4, #0x2c]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r0, [r4, #0x2c]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r2, #0x49
	ldr r0, [r4, #0x30]
	mov r1, #7
	strh r2, [r0]
	ldr r0, [r4, #0x30]
	strh r1, [r0, #2]
	ldr r0, [r4, #0x30]
	bl SetupExHUDSprite
	ldr r0, [r4, #0x30]
	mov r1, #0xe000
	add r0, r0, #0x80
	bl exDrawReqTask__SetConfigPriority
	mov r2, #0x80
	ldr r0, [r4, #0x30]
	mov r1, #0x60
	strh r2, [r0, #0x68]
	ldr r0, [r4, #0x30]
	strh r1, [r0, #0x6a]
	ldr r0, [r4, #0x30]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r1, [r4, #0x30]
	ldrb r0, [r1, #0x82]
	orr r0, r0, #0x20
	strb r0, [r1, #0x82]
	ldr r0, [r4, #0x30]
	add r0, r0, #0x80
	bl exDrawReqTask__Func_21641F0
	mov r0, #0x2d
	strh r0, [r4]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Func_216D6B0
	str r1, [r0]
	bl exMsgTitleTask__Func_216D6B0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D6B0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x2c]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x2c]
	bl exDrawReqTask__Sprite2D__IsAnimFinished
	cmp r0, #0
	beq _0216D6DC
	bl exMsgTitleTask__Func_216D6F8
	ldmia sp!, {r4, pc}
_0216D6DC:
	ldr r0, [r4, #0x2c]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D6F8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0
	strh r1, [r0]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Func_216D720
	str r1, [r0]
	bl exMsgTitleTask__Func_216D720
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D720(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0]
	sub r1, r2, #1
	strh r1, [r0]
	cmp r2, #0
	bgt _0216D744
	bl exMsgTitleTask__Func_216D760
	ldmia sp!, {r3, pc}
_0216D744:
	ldr r0, [r0, #0x2c]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D760(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x2c]
	bl ReleaseExHUDSprite
	bl GetExSystemStatus
	mov r1, #4
	strb r1, [r0, #3]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Func_216D794
	str r1, [r0]
	bl exMsgTitleTask__Func_216D794
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D794(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x30]
	bl exDrawReqTask__Sprite2D__Animate
	ldr r0, [r4, #0x30]
	bl exDrawReqTask__Sprite2D__IsAnimFinished
	cmp r0, #0
	beq _0216D7C0
	bl exMsgTitleTask__Func_216D7DC
	ldmia sp!, {r4, pc}
_0216D7C0:
	ldr r0, [r4, #0x30]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D7DC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x78
	strh r1, [r0]
	bl GetExTaskCurrent
	ldr r1, =exMsgTitleTask__Func_216D804
	str r1, [r0]
	bl exMsgTitleTask__Func_216D804
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTitleTask__Func_216D804(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0]
	sub r1, r2, #1
	strh r1, [r0]
	cmp r2, #0
	bgt _0216D830
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
_0216D830:
	ldr r0, [r0, #0x30]
	add r1, r0, #0x80
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

BOOL exMsgTitleTask__Create(void)
{
    Task *task = ExTaskCreate(exMsgTitleTask__Main, exMsgTitleTask__Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exMsgTitleTask);

    exMsgTitleTask *work = ExTaskGetWork(task, exMsgTitleTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, exMsgTitleTask__Func8);

    return TRUE;
}

Task *exMsgTitleTask__GetTask(void)
{
    return exMsgTitleTask__sVars.exMsgTitleTask__TaskSingleton;
}