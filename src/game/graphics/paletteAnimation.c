#include <game/graphics/paletteAnimation.h>
#include <game/graphics/paletteQueue.h>
#include <game/math/mtMath.h>

// --------------------
// MACROS
// --------------------

#define GetFrameFromAnimation(anim, frameID) ((PaletteAnimationFrame *)&(anim)->frameData[(anim)->frameSize * (frameID)])

// --------------------
// ENUMS
// --------------------

enum AnimatorBPASysFlags_
{
    ANIMATORBPA_SYSFLAG_CAN_DRAW    = 1 << 0,
    ANIMATORBPA_SYSFLAG_IS_READY    = 1 << 1,
    ANIMATORBPA_SYSFLAG_REACHED_END = 1 << 2, // finished a loop
};

// --------------------
// STRUCTS
// --------------------

typedef struct PaletteAnimFile_
{
    u32 signature;
    u32 count;
    u32 offsets[1];
} PaletteAnimFile;

typedef struct PaletteAnimation_
{
    u16 duration;
    u8 offset;
    u8 colorCount;
    u16 frameCount;
    u16 frameSize;
    u8 frameData[1];
} PaletteAnimation;

typedef struct PaletteAnimationFrame_
{
    u16 duration;
    u16 unknown;
    u16 colors[1];
} PaletteAnimationFrame;

// --------------------
// FUNCTION DECLS
// --------------------

u16 GetPaletteAnimationDuration(PaletteAnimFile *fileData, u16 animID);
u16 GetPaletteAnimationFrameCount(PaletteAnimFile *fileData, u16 animID);
u16 GetPaletteAnimationFrameDuration(PaletteAnimFile *fileData, u16 animID, u16 frameID);
void SetPaletteAnimationLastFrame(PaletteAnimator *animator);
u16 GetPaletteAnimationRemainingDuration(PaletteAnimator *animator, u16 advance, PaletteAnimation *anim);
PaletteAnimation *GetPaletteAnimation(PaletteAnimFile *fileData, u16 animID);

// --------------------
// FUNCTIONS
// --------------------

void InitPaletteAnimationSystem(void)
{
    // Nothing
}

void InitPaletteAnimator(PaletteAnimator *animator, void *fileData, u16 animID, AnimatorBPAFlags flags, PaletteMode paletteMode, VRAMPaletteKey dstPalettePtr)
{
    MI_CpuClear32(animator, sizeof(PaletteAnimator));

    animator->userFlags     = flags;
    animator->sysFlags      = ANIMATORBPA_SYSFLAG_IS_READY;
    animator->animID        = animID;
    animator->drawFrameID   = ANIMATORBPA_INVALID_FRAME;
    animator->timer         = FLOAT_TO_FX32(0.0);
    animator->speed         = FLOAT_TO_FX32(1.0);
    animator->frameID       = 0;
    animator->frameDuration = GetPaletteAnimationFrameDuration(fileData, animID, 0);
    animator->paletteMode   = paletteMode;
    animator->dstPalettePtr = dstPalettePtr;
    animator->fileData      = fileData;
}

void ReleasePaletteAnimator(PaletteAnimator *animator)
{
    MI_CpuClear32(animator, sizeof(PaletteAnimator));
}

void SetPaletteAnimation(PaletteAnimator *animator, u16 animID)
{
    animator->userFlags &= ~(ANIMATORBPA_FLAG_PAUSED | ANIMATORBPA_FLAG_DID_LOOP);
    animator->sysFlags = ANIMATORBPA_SYSFLAG_IS_READY;

    animator->animID        = animID;
    animator->drawFrameID   = ANIMATORBPA_INVALID_FRAME;
    animator->timer         = FLOAT_TO_FX32(0.0);
    animator->frameID       = 0;
    animator->frameDuration = GetPaletteAnimationFrameDuration(animator->fileData, animID, 0);
}

void AnimatePalette(PaletteAnimator *animator)
{
    if ((animator->sysFlags & ANIMATORBPA_SYSFLAG_IS_READY) != 0)
    {
        animator->sysFlags &= ~ANIMATORBPA_SYSFLAG_IS_READY;
        animator->sysFlags |= ANIMATORBPA_SYSFLAG_CAN_DRAW;
        animator->drawFrameID = animator->frameID;
    }
    else
    {
        animator->drawFrameID = ANIMATORBPA_INVALID_FRAME;
    }

    if ((animator->sysFlags & ANIMATORBPA_SYSFLAG_REACHED_END) != 0)
    {
        animator->sysFlags &= ~ANIMATORBPA_SYSFLAG_REACHED_END;
        animator->userFlags |= ANIMATORBPA_FLAG_DID_LOOP;
    }

    if ((animator->userFlags & ANIMATORBPA_FLAG_PAUSED) == 0)
    {
        PaletteAnimation *anim = GetPaletteAnimation(animator->fileData, animator->animID);

        fx32 speed    = animator->speed;
        fx32 duration = FX32_FROM_WHOLE(anim->duration);
        if (speed >= duration)
        {
            animator->sysFlags |= ANIMATORBPA_SYSFLAG_REACHED_END;
            if ((animator->userFlags & ANIMATORBPA_FLAG_CAN_LOOP) == 0)
            {
                SetPaletteAnimationLastFrame(animator);
                return;
            }
            speed -= duration * FX_DivS32(speed, duration);
        }

        u16 prev = FX32_TO_WHOLE(animator->timer);
        animator->timer += speed;
        u16 advance = (u16)((u16)FX32_TO_WHOLE(animator->timer) - prev);

        if (animator->timer >= duration - FLOAT_TO_FX32(1.0))
        {
            animator->sysFlags |= ANIMATORBPA_SYSFLAG_REACHED_END;
            if ((animator->userFlags & ANIMATORBPA_FLAG_CAN_LOOP) == 0)
            {
                SetPaletteAnimationLastFrame(animator);
                return;
            }
        }

        if (animator->timer >= duration)
            animator->timer -= duration;

        if (animator->frameDuration > advance)
        {
            animator->frameDuration -= advance;
        }
        else
        {
            while (advance)
            {
                // looping...
                advance = GetPaletteAnimationRemainingDuration(animator, advance, anim);
            }
            animator->sysFlags |= ANIMATORBPA_SYSFLAG_IS_READY;
        }
    }
}

BOOL CheckPaletteAnimationIsValid(PaletteAnimator *animator)
{
    return (animator->sysFlags & ANIMATORBPA_SYSFLAG_CAN_DRAW) != 0;
}

void DrawAnimatedPalette(PaletteAnimator *animator)
{
    if (CheckPaletteAnimationIsValid(animator))
    {
        animator->sysFlags &= ~ANIMATORBPA_SYSFLAG_CAN_DRAW;

        if ((animator->userFlags & ANIMATORBPA_FLAG_NO_DRAW) == 0)
        {
            PaletteAnimation *anim = GetPaletteAnimation(animator->fileData, animator->animID);

            u16 colorCount    = anim->colorCount + 1;
            PaletteAnimationFrame *dataPtr = GetFrameFromAnimation(anim, animator->drawFrameID);
            u32 dstOffset     = anim->offset;

            if ((animator->userFlags & ANIMATORBPA_FLAG_LOAD_PALETTE) != 0)
                LoadUncompressedPalette(dataPtr->colors, colorCount, animator->paletteMode, VRAMKEY_TO_KEY(&((u16 *)animator->dstPalettePtr)[dstOffset]));
            else
                QueueUncompressedPalette(dataPtr->colors, colorCount, animator->paletteMode, VRAMKEY_TO_KEY(&((u16 *)animator->dstPalettePtr)[dstOffset]));
        }
    }
}

void SetPaletteAnimationSpeed(PaletteAnimator *animator, fx32 speed)
{
    animator->speed = speed;
}

void SetPaletteAnimationTarget(PaletteAnimator *animator, PaletteMode paletteMode, VRAMPaletteKey dstPalettePtr)
{
    animator->paletteMode   = paletteMode;
    animator->dstPalettePtr = dstPalettePtr;
    animator->sysFlags |= ANIMATORBPA_SYSFLAG_CAN_DRAW;
}

BOOL CheckPaletteAnimationLooped(PaletteAnimator *animator)
{
    return (animator->userFlags & ANIMATORBPA_FLAG_DID_LOOP) != 0;
}

u16 GetPaletteAnimationDuration(PaletteAnimFile *fileData, u16 animID)
{
    return GetPaletteAnimation(fileData, animID)->duration;
}

u16 GetPaletteAnimationFrameCount(PaletteAnimFile *fileData, u16 animID)
{
    return GetPaletteAnimation(fileData, animID)->frameCount;
}

u16 GetPaletteAnimationFrameDuration(PaletteAnimFile *fileData, u16 animID, u16 frameID)
{
    PaletteAnimation *anim = GetPaletteAnimation(fileData, animID);
    return GetFrameFromAnimation(anim, frameID)->duration;
}

void SetPaletteAnimationLastFrame(PaletteAnimator *animator)
{
    animator->userFlags |= ANIMATORBPA_FLAG_PAUSED;
    animator->timer         = FX32_FROM_WHOLE(GetPaletteAnimationDuration(animator->fileData, animator->animID) - 1);
    animator->frameID       = GetPaletteAnimationFrameCount(animator->fileData, animator->animID) - 1;
    animator->frameDuration = 0;
    animator->sysFlags |= ANIMATORBPA_SYSFLAG_IS_READY;
}

u16 GetPaletteAnimationRemainingDuration(PaletteAnimator *animator, u16 advance, PaletteAnimation *anim)
{
    if (animator->frameDuration > advance)
    {
        animator->frameDuration -= advance;
        return 0;
    }

    advance -= animator->frameDuration;
    if (anim == NULL)
        anim = GetPaletteAnimation(animator->fileData, animator->animID);

    // advance frame
    if (animator->frameID < anim->frameCount - 1)
        animator->frameID++;
    else
        animator->frameID = 0;

    // set new duration
    animator->frameDuration = GetFrameFromAnimation(anim, animator->frameID)->duration;

    return advance;
}

PaletteAnimation *GetPaletteAnimation(PaletteAnimFile *fileData, u16 animID)
{
    return (PaletteAnimation *)((u8 *)fileData + fileData->offsets[animID]);
}
