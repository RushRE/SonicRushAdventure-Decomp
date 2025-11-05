#ifndef RUSH_TITLESCREEN_H
#define RUSH_TITLESCREEN_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// ENUMS
// --------------------

enum TitleScreenFlags_
{
    TITLESCREEN_FLAG_NONE = 0x00,

    TITLESCREEN_FLAG_START_PRESSED         = 1 << 0,
    TITLESCREEN_FLAG_BEGIN_FADE_OUT        = 1 << 1,
    TITLESCREEN_FLAG_USE_PRESS_START_TIMER = 1 << 2,
    TITLESCREEN_FLAG_CREATE_PRESS_START    = 1 << 3,
    TITLESCREEN_FLAG_SHOW_COPYRIGHT        = 1 << 4,
    TITLESCREEN_FLAG_SHOW_TRADEMARK        = 1 << 5,
    TITLESCREEN_FLAG_INIT_DEMO             = 1 << 6,
    TITLESCREEN_FLAG_DISABLE_PRESS_START   = 1 << 7,
};
typedef u32 TitleScreenFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct TitleScreenWorldControl_
{
    void *mdlCutscene[2];
    void *jntAniCutscene;
    void *matAniCutscene;
    void *unknown;
    void *texAniCutscene;
    void *visAniCutscene;
    void *drawStateCutscene;
    FXMatrix43 mtxCamera;
    FXMatrix43 mtxTarget;
    Camera3D cameraConfig;
    fx32 matProjPositionY;

    // allow each array index to be named
    union
    {
        struct
        {
            AnimatorMDL aniCamera;
            AnimatorMDL aniSea;
            AnimatorMDL aniSkybox;
            AnimatorMDL aniIsland;
            AnimatorMDL aniLensFlare;
            AnimatorMDL aniSparkles;
        };

        AnimatorMDL animators[6];
    };

    TitleScreenFlags flags;
    fx32 brightness;
    s32 timer;
    s32 touchSkipDelay;
    Background background;
} TitleScreenWorldControl;

typedef struct TitleScreen_
{
    void *archiveTitleScreen;
    void *archiveOpeningCutscene;
    TitleScreenWorldControl worldControl;
} TitleScreen;

typedef struct TitleScreenBackgroundView_
{
    TitleScreen *parent;
} TitleScreenBackgroundView;

typedef struct TitleScreenCopyrightIcon_
{
    TitleScreen *parent;
    s32 timer;
    AnimatorSprite aniCopyright;
    AnimatorSprite aniTrademark;
} TitleScreenCopyrightIcon;

typedef struct TitleScreenPressStart_
{
    TitleScreen *parent;
    s32 timer;
    AnimatorSprite aniButton;
} TitleScreenPressStart;

// --------------------
// FUNCTIONS
// --------------------

void InitTitleScreen(void);

#endif // RUSH_TITLESCREEN_H