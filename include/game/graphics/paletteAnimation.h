#ifndef RUSH_PALETTEANIMATION_H
#define RUSH_PALETTEANIMATION_H

#include <global.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/vramSystem.h>

// --------------------
// CONSTANTS
// --------------------

#define ANIMATORBPA_INVALID_FRAME 0xFFFF

// --------------------
// ENUMS
// --------------------

enum AnimatorBPAUserFlags_
{
    ANIMATORBPA_FLAG_NONE       = 0x00,

    ANIMATORBPA_FLAG_PAUSED       = 1 << 0, // disable animation
    ANIMATORBPA_FLAG_CAN_LOOP     = 1 << 1,
    ANIMATORBPA_FLAG_NO_DRAW      = 1 << 2,
    ANIMATORBPA_FLAG_LOAD_PALETTE = 1 << 3,
    ANIMATORBPA_FLAG_DID_LOOP     = 1 << 15,
};

typedef u16 AnimatorBPAFlags;
typedef u16 AnimatorBPASysFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct AnimatorBPA_
{
    AnimatorBPAFlags userFlags;
    AnimatorBPASysFlags sysFlags;
    u16 animID;
    u16 drawFrameID;
    fx32 timer;
    fx32 speed;
    u16 frameID;
    u16 frameDuration;
    PaletteMode paletteMode;
    VRAMPaletteKey dstPalettePtr;
    void *fileData;
} PaletteAnimator;

// --------------------
// FUNCTIONS
// --------------------

void InitPaletteAnimationSystem(void);
void InitPaletteAnimator(PaletteAnimator *animator, void *fileData, u16 animID, AnimatorBPAFlags flags, PaletteMode paletteMode, VRAMPaletteKey dstPalettePtr);
void ReleasePaletteAnimator(PaletteAnimator *animator);
void SetPaletteAnimation(PaletteAnimator *animator, u16 animID);
void AnimatePalette(PaletteAnimator *animator);
BOOL CheckPaletteAnimationIsValid(PaletteAnimator *animator);
void DrawAnimatedPalette(PaletteAnimator *animator);
void SetPaletteAnimationSpeed(PaletteAnimator *animator, fx32 speed);
void SetPaletteAnimationTarget(PaletteAnimator *animator, PaletteMode paletteMode, VRAMPaletteKey dstPalettePtr);
BOOL CheckPaletteAnimationLooped(PaletteAnimator *animator);

#endif // RUSH_PALETTEANIMATION_H
