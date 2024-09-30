#ifndef RUSH2_TITLESCREEN_H
#define RUSH2_TITLESCREEN_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>

// --------------------
// STRUCTS
// --------------------

typedef struct TitleScreenWorldControl_
{
    void *mdlCutscene[2];
    void *jntAniCutscene;
    void *matAniCutscene;
    s32 field_18;
    void *texAniCutscene;
    void *visAniCutscene;
    void *drawStateCutscene;
    MtxFx43 mat1;
    MtxFx43 mat2;
    Camera3D cameraConfig;
    s32 matrixID;
    AnimatorMDL animators[6];
    s32 flags;
    s32 brightness;
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
    int timer;
    AnimatorSprite aniButton;
} TitleScreenPressStart;

// --------------------
// FUNCTIONS
// --------------------

void TitleScreen__Init(void);
void TitleScreen__Create(void);
void TitleScreen__Func_215619C(void);
void TitleScreen__LoadAssets(void);
void TitleScreen__Func_2156418(void);
void TitleScreen__Func_2156434(void);
void TitleScreen__Func_21566AC(void);
void TitleScreen__Func_21566F0(void);
void TitleScreen__Func_21567C4(void);
void TitleScreen__Func_21567C8(void);
void TitleScreen__Func_21567E0(void);
void TitleScreen__Func_2156818(void);
void TitleScreen__Func_215685C(void);
void TitleScreen__Func_21568B8(void);
void TitleScreen__Func_215690C(void);
void TitleScreen__Func_21569C0(void);
void TitleScreen__Func_2156A10(void);
void TitleScreen__Func_2156A50(void);
void TitleScreen__Destructor(Task *task);
void TitleScreen__Main(void);
void TitleScreen__Main_2156B40(void);
void TitleScreen__Main_2156BA0(void);
void TitleScreen__Main_2156C10(void);
void TitleScreen__Main_2156C38(void);
void TitleScreen__Main_2156CA4(void);

void TitleScreenBackgroundView__Create(void);
void TitleScreenBackgroundView__Destructor(Task *task);
void TitleScreenBackgroundView__Main(void);
void TitleScreenBackgroundView__Main_2156D5C(void);

void TitleScreenCopyrightIcon__Create(void);
void TitleScreenCopyrightIcon__Destructor(Task *task);
void TitleScreenCopyrightIcon__Main(void);
void TitleScreenCopyrightIcon__Main_2156FFC(void);
void TitleScreenCopyrightIcon__Main_21570AC(void);

void TitleScreenPressStart__Create(void);
void TitleScreenPressStart__Destructor(Task *task);
void TitleScreenPressStart__Main(void);
void TitleScreenPressStart__Main_2157254(void);
void TitleScreenPressStart__Main_21572E8(void);
void TitleScreenPressStart__Main_215734C(void);

#endif // RUSH2_TITLESCREEN_H