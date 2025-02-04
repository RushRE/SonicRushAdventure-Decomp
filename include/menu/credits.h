#ifndef RUSH_CREDITS_H
#define RUSH_CREDITS_H

#include <game/system/task.h>
#include <game/text/fontWindow.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontAnimator.h>
#include <game/graphics/background.h>
#include <game/graphics/sprite.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum CreditsMode_
{
    CREDITS_MODE_FINAL_BOSS,
    CREDITS_MODE_EXTRA_BOSS,
    CREDITS_MODE_EXTRA_BOSS_STAGE_SELECT,
    CREDITS_MODE_EXTRA_STAGE_NOTIF,
    CREDITS_MODE_MISSION_NOTIF,
};
typedef u32 CreditsMode;

// --------------------
// STRUCTS
// --------------------

typedef struct CreditsScreen_
{
    s32 scrollPos;
    s32 stopBottom;
    s32 stopTop;
    s32 height;
    BackgroundDS background;
} CreditsScreen;

typedef struct CreditsAssets_
{
    void *dmsrArchive;
    void *tkdmArchive;
    void *font;
    s32 type;
} CreditsAssets;

typedef struct Credits_
{
    CreditsAssets assets;
    void (*scrollState)(struct Credits_ *work);
    u32 flags;
    BOOL scrollSpeed;
    s32 delay;
    s32 fadeDelay;
    fx32 bgBrightness;
    s32 congratulationsTimer;
    u32 visibleLetterCount;
    fx32 logoAlpha;
    u32 timer;
    CreditsScreen screens[4];
    AnimatorSpriteDS aniLogos[2];
    AnimatorSpriteDS aniCongratulations;
    AnimatorSprite aniThanksForPlaying[18];
} Credits;

typedef struct CreditsNotification_
{
    Credits *parent;
    s32 type;
    s32 autoCloseTimer;
    s32 timer;
    s32 buttonState;
    FontWindow fontWindow;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    AnimatorSprite aniContinueButton;
} CreditsNotification;

typedef struct WandRoom_
{
    Credits *parent;
    AnimatorMDL aniWandroom;
} WandRoom;

// --------------------
// FUNCTIONS
// --------------------

void InitCreditsEvent(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CREDITS_H