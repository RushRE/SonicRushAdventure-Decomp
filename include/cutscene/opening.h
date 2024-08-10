#ifndef RUSH2_OPENING_H
#define RUSH2_OPENING_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/background.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// TYPES
// --------------------

typedef struct Opening_ Opening;
typedef void (*OpeningState)(Opening *work);

// --------------------
// ENUMS
// --------------------

enum OpeningFlags_
{
    OPENING_FLAG_NONE = 0,

    OPENING_FLAG_SCENE_COMPLETE       = 1 << 0,
    OPENING_FLAG_IS_FINISHED          = 1 << 1,
    OPENING_FLAG_WAS_SKIPPED          = 1 << 2,
    OPENING_FLAG_CHARACTER_CUTIN_DONE = 1 << 3,
    OPENING_FLAG_ALL_CUTIN_DONE       = 1 << 4,
    OPENING_FLAG_IS_FADING            = 1 << 5,
};
typedef u32 OpeningFlags;

enum OpeningBorderSpriteFlags_
{
    OPENING_BORDER_SPRITE_FLAG_NONE = 0,

    OPENING_BORDER_SPRITE_FLAG_SONIC_DONE = 1 << 0,
};
typedef u32 OpeningBorderSpriteFlags;

enum OpeningNameSpriteFlags_
{
    OPENING_NAME_SPRITE_FLAG_NONE = 0,

    OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS = 1 << 0,
    OPENING_NAME_SPRITE_FLAG_IS_DONE      = 1 << 1,
};
typedef u32 OpeningNameSpriteFlags;

enum OpeningFadeMode_
{
    OPENING_FADE_TO_BLACK,
    OPENING_FADE_FROM_BLACK,
    OPENING_FADE_TO_WHITE,
    OPENING_FADE_FROM_WHITE,
};
typedef u32 OpeningFadeMode;

enum OpeningAnimatorID_
{
    OPENING_ANIMATOR_CAMERA1,
    OPENING_ANIMATOR_CAMERA2,
    OPENING_ANIMATOR_SEAGULL,
    OPENING_ANIMATOR_JETSKI,
    OPENING_ANIMATOR_SONIC,
    OPENING_ANIMATOR_BLAZE,
    OPENING_ANIMATOR_JETSKI_TRAIL,
    OPENING_ANIMATOR_JETSKI_SPLASH,
    OPENING_ANIMATOR_JETSKI_SPLASH2,
    OPENING_ANIMATOR_SEA,
    OPENING_ANIMATOR_SKYBOX,
    OPENING_ANIMATOR_DOLPHIN_TAILS,
    OPENING_ANIMATOR_TAILS,
    OPENING_ANIMATOR_DOLPHIN_MARINE,
    OPENING_ANIMATOR_MARINE,
    OPENING_ANIMATOR_SPLASH_TAILS,
    OPENING_ANIMATOR_SPLASH_MARINE,

    OPENING_ANIMATOR_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct OpeningFadeController_
{
    OpeningFadeMode mode;
    fx32 brightness;
    fx32 fadeSpeed;
} OpeningFadeController;

typedef struct OpeningWorldControl_
{
    void *mdlCutscene[2];
    void *jntAniCutscene;
    void *matAniCutscene;
    void *patAniCutscene;
    void *texAniCutscene;
    void *visAniCutscene;
    void *drawStateCutscene[5];
    MtxFx43 matCamera1;
    MtxFx43 matTarget1;
    MtxFx43 matCamera2;
    MtxFx43 matTarget2;
    Camera3D camera;
    fx32 matProjPosY;
    AnimatorMDL animators[OPENING_ANIMATOR_COUNT];
    PaletteAnimator aniPalette;
    Background bgBase;
    Background bgSonic;
    Background bgBlaze;
} OpeningWorldControl;

struct OpeningBorderControl
{
    s32 sonicPos;
    s32 blazePos;
    s32 timer;
    OpeningBorderSpriteFlags flags;
};

struct Opening_
{
    void *archiveSprites;
    void *archiveCutscene;
    OpeningState stateSequence;
    OpeningState stateScene;
    OpeningFlags flags;
    s32 touchSkipDelay;
    u32 sceneID;
    s32 animatedSceneID;
    s32 cutInSceneID;
    OpeningFadeController fadeControl;
    struct OpeningBorderControl border;
    OpeningWorldControl worldControl;
};

typedef struct OpeningBorderSprite_
{
    Opening *parent;
    AnimatorSprite aniBorder[2];
} OpeningBorderSprite;

typedef struct OpeningSonicNameSprite_
{
    Opening *parent;
    OpeningNameSpriteFlags flags;
    Vec2Fx32 backgroundPosition;
    s32 enterTimer;
    s32 letterTimer;
    s16 nameLetterID;
    s16 subtitleLetterID;
    s32 exitTimer;
    AnimatorSprite aniLetters[16];
} OpeningSonicNameSprite;

typedef struct OpeningBlazeNameSprite_
{
    Opening *parent;
    OpeningNameSpriteFlags flags;
    Vec2Fx32 backgroundPosition;
    s32 enterTimer;
    s32 letterTimer;
    s16 nameLetterID;
    s16 subtitleLetterID;
    s32 exitTimer;
    AnimatorSprite aniLetters[11];
} OpeningBlazeNameSprite;

// --------------------
// FUNCTIONS
// --------------------

void CreateOpening(void);

#endif // RUSH2_OPENING_H