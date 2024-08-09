#ifndef RUSH2_NAVTAILS_H
#define RUSH2_NAVTAILS_H

#include <global.h>
#include <game/system/task.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindow.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

typedef struct NavTailsAssets_
{
    void *archiveNv;
    void *sprNav;
    void *bgNav;
    void *bgMsgWindow[4];
    void *mpcText;
    void *bgTails;
    u32 tailsSpriteID;
} NavTailsAssets;

typedef struct NavTails_
{
    BOOL useEngineB;
    NavTailsAssets assets;
    struct NavTailsDMA
    {
        u32 tailsBackgroundID;
        u8 buffer[2][HW_LCD_HEIGHT * 2];
        u16 updateID;
        u16 timer;
    } dma;
    void (*stateTalk)(struct NavTails_ *work);
    void (*stateDMA)(struct NavTails_ *work);
    u32 field_33C;
    u8 lives;
    s32 windowMode;
    s32 messageWindowID;
    FontWindow *fontWindow;
    BOOL usingFontWindowPtr;
    FontWindow _fontWindow;
    FontAnimator fontAnimator;
    void *fontFileData;
    u16 speakDelay;
    u16 speakDuration;
    AnimatorSprite aniWindowElements[3];
    AnimatorSprite aniPlayerIcon;
    AnimatorSprite aniShipIcon[4];
    AnimatorSprite aniLifeNumbers[2];
    AnimatorSprite aniChart[27];
    AnimatorSprite aniUnknown[5];
} NavTails;

// --------------------
// FUNCTIONS
// --------------------

void CreateNavTails(BOOL useEngineB, s32 a2, FontWindow *window);
void DestroyNavTails(void);
BOOL IsNavTailsActive(void);
void NavTailsSpeak(u16 msgSequence, u16 duration);
u16 CheckNavTailsSpeaking(void);
BOOL CheckNavTailsLastDialog(void);

#endif // RUSH2_NAVTAILS_H