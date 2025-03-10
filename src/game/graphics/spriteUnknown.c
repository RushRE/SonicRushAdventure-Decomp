#include <game/graphics/spriteUnknown.h>

// --------------------
// FUNCTIONS
// --------------------

u32 SpriteUnknown__GetSpriteSizeFromAnim(void *file, BOOL useEngineB, u16 anim)
{
    switch (useEngineB == GRAPHICS_ENGINE_A ? GX_GetOBJVRamModeChar() : GXS_GetOBJVRamModeChar())
    {
            // case GX_OBJVRAMMODE_CHAR_2D:
            //    break;

        case GX_OBJVRAMMODE_CHAR_1D_32K:
            return Sprite__GetSpriteSize1FromAnim(file, anim);

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            return Sprite__GetSpriteSize2FromAnim(file, anim);

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            return Sprite__GetSpriteSize3FromAnim(file, anim);

        case GX_OBJVRAMMODE_CHAR_1D_256K:
            return Sprite__GetSpriteSize4FromAnim(file, anim);
    }

    return 0;
}

u32 SpriteUnknown__GetSpriteSize(void *file, BOOL useEngineB)
{
    switch (useEngineB == GRAPHICS_ENGINE_A ? GX_GetOBJVRamModeChar() : GXS_GetOBJVRamModeChar())
    {
            // case GX_OBJVRAMMODE_CHAR_2D:
            //    break;

        case GX_OBJVRAMMODE_CHAR_1D_32K:
            return Sprite__GetSpriteSize1(file);

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            return Sprite__GetSpriteSize2(file);

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            return Sprite__GetSpriteSize3(file);

        case GX_OBJVRAMMODE_CHAR_1D_256K:
            return Sprite__GetSpriteSize4(file);
    }

    return 0;
}

u32 SpriteUnknown__GetSpriteSize1FromAnimRange(void *file, u16 firstAnim, u16 lastAnim)
{
    u32 spriteSize = 0;

    for (u16 a = firstAnim; a <= lastAnim; a++)
    {
        u32 size = Sprite__GetSpriteSize1FromAnim(file, a);

        if (spriteSize < size)
            spriteSize = size;
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize1FromAnimList(void *file, u32 *animList)
{
    u32 spriteSize = 0;

    animList++;
    u32 anim = animList[-1];
    while (anim != (u32)-1)
    {
        u32 size = Sprite__GetSpriteSize1FromAnim(file, anim);

        if (spriteSize < size)
            spriteSize = size;

        animList++;
        anim = animList[-1];
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize2FromAnimRange(void *file, u16 firstAnim, u16 lastAnim)
{
    u32 spriteSize = 0;

    for (u16 a = firstAnim; a <= lastAnim; a++)
    {
        u32 size = Sprite__GetSpriteSize2FromAnim(file, a);

        if (spriteSize < size)
            spriteSize = size;
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize2FromAnimList(void *file, u32 *animList)
{
    u32 spriteSize = 0;

    animList++;
    u32 anim = animList[-1];
    while (anim != (u32)-1)
    {
        u32 size = Sprite__GetSpriteSize2FromAnim(file, anim);

        if (spriteSize < size)
            spriteSize = size;

        animList++;
        anim = animList[-1];
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize3FromAnimRange(void *file, u16 firstAnim, u16 lastAnim)
{
    u32 spriteSize = 0;

    for (u16 a = firstAnim; a <= lastAnim; a++)
    {
        u32 size = Sprite__GetSpriteSize3FromAnim(file, a);

        if (spriteSize < size)
            spriteSize = size;
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize3FromAnimList(void *file, u32 *animList)
{
    u32 spriteSize = 0;

    animList++;
    u32 anim = animList[-1];
    while (anim != (u32)-1)
    {
        u32 size = Sprite__GetSpriteSize3FromAnim(file, anim);

        if (spriteSize < size)
            spriteSize = size;

        animList++;
        anim = animList[-1];
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize4FromAnimRange(void *file, u16 firstAnim, u16 lastAnim)
{
    u32 spriteSize = 0;

    for (u16 a = firstAnim; a <= lastAnim; a++)
    {
        u32 size = Sprite__GetSpriteSize4FromAnim(file, a);

        if (spriteSize < size)
            spriteSize = size;
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSize4FromAnimList(void *file, u32 *animList)
{
    u32 spriteSize = 0;

    animList++;
    u32 anim = animList[-1];
    while (anim != (u32)-1)
    {
        u32 size = Sprite__GetSpriteSize4FromAnim(file, anim);

        if (spriteSize < size)
            spriteSize = size;

        animList++;
        anim = animList[-1];
    }

    return spriteSize;
}

u32 SpriteUnknown__GetSpriteSizeFromAnimRange(void *file, BOOL useEngineB, u16 firstAnim, u16 lastAnim)
{
    switch (useEngineB == GRAPHICS_ENGINE_A ? GX_GetOBJVRamModeChar() : GXS_GetOBJVRamModeChar())
    {
            // case GX_OBJVRAMMODE_CHAR_2D:
            //    break;

        case GX_OBJVRAMMODE_CHAR_1D_32K:
            return SpriteUnknown__GetSpriteSize1FromAnimRange(file, firstAnim, lastAnim);

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            return SpriteUnknown__GetSpriteSize2FromAnimRange(file, firstAnim, lastAnim);

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            return SpriteUnknown__GetSpriteSize3FromAnimRange(file, firstAnim, lastAnim);

        case GX_OBJVRAMMODE_CHAR_1D_256K:
            return SpriteUnknown__GetSpriteSize4FromAnimRange(file, firstAnim, lastAnim);
    }

    return 0;
}

u32 SpriteUnknown__GetSpriteSizeFromAnimList(void *file, BOOL useEngineB, u32 *animList)
{
    switch (useEngineB == GRAPHICS_ENGINE_A ? GX_GetOBJVRamModeChar() : GXS_GetOBJVRamModeChar())
    {
            // case GX_OBJVRAMMODE_CHAR_2D:
            //    break;

        case GX_OBJVRAMMODE_CHAR_1D_32K:
            return SpriteUnknown__GetSpriteSize1FromAnimList(file, animList);

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            return SpriteUnknown__GetSpriteSize2FromAnimList(file, animList);

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            return SpriteUnknown__GetSpriteSize3FromAnimList(file, animList);

        case GX_OBJVRAMMODE_CHAR_1D_256K:
            return SpriteUnknown__GetSpriteSize4FromAnimList(file, animList);
    }

    return 0;
}

void SpriteUnknown__InitAnimator(AnimatorSprite *animator, void *fileData, u16 animID, AnimatorFlags flags, BOOL useEngineB, u32 spriteSize, u8 paletteRow, u8 oamPriority,
                                 u8 oamOrder)
{
    if (Sprite__GetFormatFromAnim(fileData, animID) != BAC_FORMAT_PLTT256_2D)
    {
        VRAMPaletteKey vramPalette = useEngineB != GRAPHICS_ENGINE_B ? VRAM_OBJ_PLTT : VRAM_DB_OBJ_PLTT;
        VRAMPixelKey vramPixels    = VRAMSystem__AllocSpriteVram(useEngineB, spriteSize);

        AnimatorSprite__Init(animator, fileData, animID, flags, useEngineB, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, vramPalette, oamPriority, oamOrder);
    }
    else
    {
        PaletteMode paletteMode = useEngineB != GRAPHICS_ENGINE_B ? PALETTE_MODE_OBJ : PALETTE_MODE_SUB_OBJ;
        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, spriteSize);

        AnimatorSprite__Init(animator, fileData, animID, flags, useEngineB, PIXEL_MODE_SPRITE, vramPixels, paletteMode, NULL, oamPriority, oamOrder);
    }

    animator->cParam.palette = paletteRow;
}
