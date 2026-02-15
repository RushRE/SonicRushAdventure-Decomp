#ifndef RUSH_DOORPUZZLE_H
#define RUSH_DOORPUZZLE_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/background.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/swapBuffer3D.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindow.h>
#include <game/text/fontWindowAnimator.h>

// --------------------
// CONSTANTS
// --------------------

#define DOORPUZZLE_STONE_KEY_COUNT 3

// --------------------
// ENUMS
// --------------------

enum DoorPuzzleEvent_
{
    DOORPUZZLE_EVENT_DISCOVERY, // first arrival event
    DOORPUZZLE_EVENT_NO_ACCESS, // returning without having all 3 keys
    DOORPUZZLE_EVENT_HAVE_KEYS, // returning while having all 3 keys

    DOORPUZZLE_EVENT_COUNT,
};
typedef s32 DoorPuzzleEvent;

// --------------------
// STRUCTS
// --------------------

typedef struct DoorPuzzleKeySys_ DoorPuzzleKeySys;
typedef struct DoorPuzzle_ DoorPuzzle;

typedef struct DoorPuzzleBGPillarFlame_
{
    u8 unknown;
    AnimatorSprite aniFire1;
    AnimatorSprite aniFire2;
} DoorPuzzleBGPillarFlame;

typedef struct DoorPuzzleCompleteActivateEffect_
{
    PaletteAnimator aniPalette;
} DoorPuzzleCompleteActivateEffect;

typedef struct DoorPuzzleKey_
{
    Vec2Fx16 pos;
    u16 angle;
    u16 timer;
    s32 unknown;
    u32 flags;
    DoorPuzzleKeySys *parent;
    void (*state)(struct DoorPuzzleKey_ *work);
    void (*stateDraw)(struct DoorPuzzleKey_ *work);
    AnimatorSprite aniSprite;
    PaletteAnimator aniPalette;
} DoorPuzzleKey;

struct DoorPuzzleKeySys_
{
    u32 flags;
    DoorPuzzle *parent;
    NNSSndHandle *seqPlayer;
    DoorPuzzleKey stoneKeys[DOORPUZZLE_STONE_KEY_COUNT];
};

typedef struct DoorPuzzleTouchPrompt_
{
    DoorPuzzleKeySys *parent;
    s32 timer;
    fx32 alpha;
    AnimatorSprite aniTouchPad;
} DoorPuzzleTouchPrompt;

typedef struct DoorPuzzleGraphics_
{
    void *pixels;
    void *mappings;
    void *palette;
} DoorPuzzleGraphics;

typedef struct DoorPuzzleDialogue_
{
    FontWindow fontWindow;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    u16 msgSequence;
    DoorPuzzle *parent;
    void (*state)(struct DoorPuzzleDialogue_ *work);
    void (*stateDraw)(struct DoorPuzzleDialogue_ *work);
    s32 flags;
    s32 timer;
    s32 dialogueMode;
    s32 portraitID;

    // allow each array index to be named
    union
    {
        struct
        {
            AnimatorSprite aniTails;
            AnimatorSprite aniSonic;
            AnimatorSprite aniBlaze;
            AnimatorSprite aniMarine;
        };

        AnimatorSprite aniCharPortrait[4];
    };

    AnimatorSprite aniCutInIcon[DOORPUZZLE_STONE_KEY_COUNT];
    AnimatorSprite aniCutInPanel[DOORPUZZLE_STONE_KEY_COUNT];
    AnimatorSprite aniNextPrompt;
} DoorPuzzleDialogue;

struct DoorPuzzle_
{
    void *archiveDoorPuzzle;
    void *archiveCutscene;
    void *fntAll;
    void *sprCutin;
    Background bgScreen;
    Background bgBase;
    DoorPuzzleGraphics graphics;
    DoorPuzzleEvent eventID;
    u32 flags;
    s32 fadeOutDelay;
    u32 timer;
    s32 mode;
};

// --------------------
// FUNCTIONS
// --------------------

void InitDoorPuzzle(void);

#endif // RUSH_DOORPUZZLE_H