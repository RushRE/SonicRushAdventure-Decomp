#ifndef RUSH_TITLECARD_H
#define RUSH_TITLECARD_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

enum TitleCardProgress_
{
    TITLECARD_PROGRESS_INITIAL,
    TITLECARD_PROGRESS_WAITING_TITLECARD_START,
    TITLECARD_PROGRESS_SHOWING_TITLE_CARD,
    TITLECARD_PROGRESS_SHOWING_READY_TEXT,
    TITLECARD_PROGRESS_WAITING_TITLECARD_COMPLETE,
    TITLECARD_PROGRESS_SHOWING_GO_TEXT,
};
typedef s32 TitleCardProgress;

enum TitleCardFlags_
{
    TITLECARD_FLAG_DRAW_NAMEPLATE         = 1 << 0,
    TITLECARD_FLAG_DRAW_JP_ZONE_NAME      = 1 << 1,
    TITLECARD_FLAG_DRAW_ACT_NUM           = 1 << 2,
    TITLECARD_FLAG_DRAW_PLAYER_NAME       = 1 << 3,
    TITLECARD_FLAG_DRAW_READY_TEXT        = 1 << 4,
    TITLECARD_FLAG_DRAW_GO_TEXT           = 1 << 5,
    TITLECARD_FLAG_USE_ROTOZOOM_NAMEPLATE = 1 << 6,
    TITLECARD_FLAG_CAN_CONTINUE           = 1 << 7,
    TITLECARD_FLAG_IS_FINISHED            = 1 << 8,

    TITLECARD_FLAG_LOADED_READYGO_SPRITES = 1 << 30,
    TITLECARD_FLAG_LOADED_MAIN_SPRITES    = 1 << 31,
};
typedef u32 TitleCardFlags;

enum TitleCardCommonAnimID
{
    TITLECARD_ANI_GO_TEXT,
    TITLECARD_ANI_READY_TEXT,

    TITLECARD_ANI_NAMELETTER_S,
    TITLECARD_ANI_NAMELETTER_O,
    TITLECARD_ANI_NAMELETTER_N,
    TITLECARD_ANI_NAMELETTER_I,
    TITLECARD_ANI_NAMELETTER_C,

    TITLECARD_ANI_NAMELETTER_B,
    TITLECARD_ANI_NAMELETTER_L,
    TITLECARD_ANI_NAMELETTER_A,
    TITLECARD_ANI_NAMELETTER_Z,
    TITLECARD_ANI_NAMELETTER_E,
};

enum TitleCardStageAnimID
{
    TITLECARD_STAGEANI_NAMEPLATE,
    TITLECARD_STAGEANI_ZONEICON,
    TITLECARD_STAGEANI_SUBTITLE,
    TITLECARD_STAGEANI_ACTNUM,
};

enum FileList_ArchiveTitleCardStage
{
    ARC_STDM_FILE_STAGE_SPRITES,
};

// --------------------
// STRUCTS
// --------------------

typedef struct TitleCard_
{
    void *commonSprites;
    void *zoneSprites;
    TitleCardProgress progress;
    void (*state)(struct TitleCard_ *work);
    BOOL finishedSequence;
    s32 timer;
    TitleCardFlags flags;
    AnimatorSprite aniNameplate[2];
    fx32 nameplateScale;
    u16 nameplateRotation;
    AnimatorSprite aniActBanner[2];
    AnimatorSprite aniNameLetters[5];
    u16 nameLetterCount;
    Vec2Fx16 *nameLetterPositions;
    AnimatorSprite aniGo;
    AnimatorSprite aniReady;
    s16 field_478;
    u16 timer2;
    u16 field_47C;
    s16 field_47E;
} TitleCard;

// --------------------
// FUNCTIONS
// --------------------

// Assets
void TitleCard__LoadCommonArchive(NNSiFndArchiveHeader *archive);
void TitleCard__ReleaseCommonArchive(void);
void TitleCard__LoadStageArchive(NNSiFndArchiveHeader *archive);
void TitleCard__ReleaseStageArchive(void);

// Titlecard
void TitleCard__Create(void);
TitleCardProgress TitleCard__GetProgress(void);
void TitleCard__SetAllowContinue(void);
void TitleCard__SetFinished(void);
TitleCard *TitleCard__GetWork(void);
void TitleCard__LoadSprites(TitleCard *work);
void TitleCard__InitAnimators(TitleCard *work);
void TitleCard__DestroyAnimators(TitleCard *work);
void TitleCard__InitReadyGoAnimators(TitleCard *work);
void TitleCard__DestroyReadyGoAnimators(TitleCard *work);
BOOL TitleCard__CheckIsFinished(TitleCard *work);
void TitleCard__Main(void);
void TitleCard__Destructor(Task *task);
void TitleCard__Draw(TitleCard *work);
void TitleCard__State_Init(TitleCard *work);
void TitleCard__State_AwaitInitialContinue(TitleCard *work);
void TitleCard__State_BeginEnterNameplate(TitleCard *work);
void TitleCard__State_EnterNameplate(TitleCard *work);
void TitleCard__State_BeginShowPlayerName(TitleCard *work);
void TitleCard__State_ShowPlayerName(TitleCard *work);
void TitleCard__State_BeginNameplateExit(TitleCard *work);
void TitleCard__State_ExitNameplate(TitleCard *work);
void TitleCard__State_FinishExitNameplate(TitleCard *work);
void TitleCard__State_BeginShowReadyText(TitleCard *work);
void TitleCard__State_ShowReadyText(TitleCard *work);
void TitleCard__State_AwaitFurtherContinue(TitleCard *work);
void TitleCard__State_BeginShowGoText(TitleCard *work);
void TitleCard__State_ShowGoText(TitleCard *work);

#endif // RUSH_TITLECARD_H