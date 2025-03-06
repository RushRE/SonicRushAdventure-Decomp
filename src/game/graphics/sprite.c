#include <game/graphics/sprite.h>
#include <game/graphics/renderCore.h>
#include <game/system/allocator.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/oamSystem.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/math/mtMath.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// FILE STRUCTS
// --------------------

struct BACFile
{
    u8 signature[3];
    u8 version;
    u32 animHeaderOffset;
    u32 animSequenceOffset;
    u32 frameAssemblyOffset;
    u32 paletteOffset;
    u32 spritePixelOffset;
    u32 infoOffset;
};

struct BACInfoAnimBlock
{
    u16 spriteSize_1D_32K;
    u16 spriteSize_1D_64K;
    u16 spriteSize_1D_128K;
    u16 spriteSize_1D_256K;
    u16 unknown4;
    u16 unknown5;
    u16 spriteCount;
    u16 palette3DSize;
    s32 texture3DSize;
};

struct BACAnimHeader
{
    u32 offset;
    BACAnimFormat format;
};

struct BACFrame
{
    u16 spriteCount;
    u16 useGFXIndex;
    s16 left;
    s16 top;
    s16 right;
    s16 bottom;
    Vec2Fx16 hotspot;
    GXOamAttr spriteList[1];
};

struct BACBlockHeader
{
    u32 blockSize;
};

struct BACInfoBlock
{
    struct BACBlockHeader header;

    u16 animCount;
    u16 spriteSize_1D_32K;  // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    u16 spriteSize_1D_64K;  // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    u16 spriteSize_1D_128K; // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    u16 spriteSize_1D_256K; // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    u16 unknown4;           // likely equivalent to the variable of the same name in 'BACInfoAnimBlock', usage is unknown.
    u16 unknown5;           // likely equivalent to the variable of the same name in 'BACInfoAnimBlock', usage is unknown.
    u16 spriteCount;        // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    u16 unknown7;           // unknown. no equivalent in 'BACInfoAnimBlock'
    u16 palette3DSize;      // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    s32 texture3DSize;      // equivalent to the variable of the same name in 'BACInfoAnimBlock', this variable is the largest possible size that fits any frame
    struct BACInfoAnimBlock anims[1];
};

struct BACAnimHeaderBlock
{
    struct BACBlockHeader header;

    struct BACAnimHeader anims[1];
};

struct BACFrameAssemblyBlock
{
    struct BACBlockHeader header;

    struct BACFrame frames[1];
};

struct BACPaletteBlock
{
    struct BACBlockHeader header;

    u16 colors[1];
};

// --------------------
// FRAME STRUCTS
// --------------------

struct BACFrameSpritePart
{
    u32 dataOffset;
    u16 tileCount;
};

typedef struct BACFrameGroupBlock_EndFrame_
{
    BACFrameGroupBlockHeader header;

    u16 animFrameCount;
    u16 frameIndex;
    u16 duration;
} BACFrameGroupBlock_EndFrame;

typedef struct BACFrameGroupBlock_FrameAssembly_
{
    BACFrameGroupBlockHeader header;

    u32 assemblyOffset;
} BACFrameGroupBlock_FrameAssembly;

typedef struct BACFrameGroupBlock_SpriteParts_
{
    BACFrameGroupBlockHeader header;

    struct BACFrameSpritePart *parts;
} BACFrameGroupBlock_SpriteParts;

typedef struct BACFrameGroupBlock_Palette_
{
    BACFrameGroupBlockHeader header;

    u32 paletteOffset;
    u16 unknown;
    u16 colorCount;
} BACFrameGroupBlock_Palette;

typedef struct BACFrameGroupBlock_EndAnimation_
{
    BACFrameGroupBlockHeader header;

    u32 loopPoint;
} BACFrameGroupBlock_EndAnimation;

typedef struct BACFrameGroupBlock_EndAnimation2_
{
    BACFrameGroupBlockHeader header;

    u16 nextAnimation;
    u16 _padding;
} BACFrameGroupBlock_EndAnimation2;

typedef struct
{
    union
    {
        u16 attr0;
        struct
        {
            u16 y : 8;
            u16 rsMode : 2;
            u16 objMode : 2;
            u16 mosaic : 1;
            u16 colorMode : 1;
            u16 shape : 2;
        };
    };

    union
    {
        u16 attr1;
        struct
        {
            u16 x : 9;
            u16 rsParam : 5;
            u16 size : 2;
        };
    };

    union
    {
        u16 attr2;
        struct
        {
            u16 charNo : 10;
            u16 priority : 2;
            u16 cParam : 4;
        };
    };

    u16 _3;
} GXOamAttr2;

// --------------------
// TYPES
// --------------------

typedef s32 (*BACFrameFunc)(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
typedef void (*Animator3DMatrixFunc)(Animator3D *animator);

// --------------------
// CONSTANTS
// --------------------

#define FRAME_BREAK    0
#define FRAME_CONTINUE 1

// --------------------
// FUNCTION DECLS
// --------------------

// Callbacks
s32 BAC_FrameGroupFunc_EndFrame(BACFrameGroupBlock_EndFrame *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_FrameAssembly(BACFrameGroupBlock_FrameAssembly *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_SpriteParts(BACFrameGroupBlock_SpriteParts *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Palette(BACFrameGroupBlock_Palette *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_EndAnimation(BACFrameGroupBlock_EndAnimation *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Unused_5(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Callback_6(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Callback_7(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Callback_8(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_EndAnimation_ChangeAnim(BACFrameGroupBlock_EndAnimation2 *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Unused_10(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
s32 BAC_FrameGroupFunc_Unused_11(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);

// Animation3D Helpers
void Animator3D__HandleMatrixOperations(Animator3D *animator, u32 flags);
void Animator3D__MatrixOp_None(Animator3D *animator);
void Animator3D__MatrixOp_Identity(Animator3D *animator);
void Animator3D__MatrixOp_RestoreMtx(Animator3D *animator);
void Animator3D__MatrixOp_FlushP(Animator3D *animator);
void Animator3D__MatrixOp_FlushVP(Animator3D *animator);
void Animator3D__MatrixOp_FlushWVP(Animator3D *animator);
void Animator3D__MatrixOp_SetMatrixMode(Animator3D *animator);
void Animator3D__MatrixOp_FlushP_Camera3D(Animator3D *animator);
void Animator3D__MatrixOp_FlushVP_Camera3D(Animator3D *animator);
void Animator3D__MatrixOp_FlushWVP_Camera3D(Animator3D *animator);
void Animator3D__MatrixOp_IdentityScale(Animator3D *animator);
void Animator3D__MatrixOp_CopyMtx33To43(Animator3D *animator);
void Animator3D__MatrixOp_IdentityTranslate(Animator3D *animator);
void Animator3D__MatrixOp_IdentityTranslate2(Animator3D *animator);
void Animator3D__MatrixOp_IdentityRotateScale(Animator3D *animator);
void Animator3D__MatrixOp_IdentityRotateTranslate2Scale(Animator3D *animator);
void Animator3D__MatrixOp_LoadMtx43(Animator3D *animator);
void Animator3D__MatrixOp_LoadCameraMtx43(Animator3D *animator);
void Animator3D__MatrixOp_LoadCameraMtx33(Animator3D *animator);
void Animator3D__MatrixOp_Scale(Animator3D *animator);
void Animator3D__MatrixOp_Rotate(Animator3D *animator);
void Animator3D__MatrixOp_Translate(Animator3D *animator);
void Animator3D__MatrixOp_Translate2(Animator3D *animator);
void Animator3D__MatrixOp_RotateScale(Animator3D *animator);
void Animator3D__MatrixOp_RotateTranslate2Scale(Animator3D *animator);
void Animator3D__MatrixOp_MultMtx43(Animator3D *animator);
void Animator3D__MatrixOp_MultCameraMtx43(Animator3D *animator);
void Animator3D__MatrixOp_MultCameraMtx33(Animator3D *animator);
void Animator3D__MatrixOp_SetCameraRot4x3(Animator3D *animator);
void Animator3D__MatrixOp_SetCameraRot3x3(Animator3D *animator);
void Animator3D__MatrixOp_Callback(Animator3D *animator);

// --------------------
// VARIABLES
// --------------------

extern u8 pixelFormatShift[];

static const u16 BAC__FormatColorCounts[] = { 0x10, 0x100, 0, 4, 0x10, 0x100, 0, 0x20, 8, 0 };
static const u16 Sprite__ShapeTileCount[] = { 1, 4, 0x10, 0x40, 2, 4, 8, 0x20, 2, 4, 8, 0x20 };

static const u32 _02112144[] = { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF };
static const u32 _02112180[] = { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF };

static const u32 drawListSprite3D[] = {
    GX_PACK_OP(G3OP_TEXCOORD, G3OP_VTX_10, G3OP_TEXCOORD, G3OP_VTX_10),
    GX_PACK_TEXCOORD_PARAM(FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0)),
    GX_PACK_VTX10_PARAM(FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0)),
    GX_PACK_TEXCOORD_PARAM(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0)),
    GX_PACK_VTX10_PARAM(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0)),

    GX_PACK_OP(G3OP_TEXCOORD, G3OP_VTX_10, G3OP_TEXCOORD, G3OP_VTX_10),
    GX_PACK_TEXCOORD_PARAM(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0)),
    GX_PACK_VTX10_PARAM(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0)),
    GX_PACK_TEXCOORD_PARAM(FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0)),
    GX_PACK_VTX10_PARAM(FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0)),
};

// clang-format off

static const BACFrameFunc frameGroupFuncList[SPRITE_BLOCK_COUNT] = 
{
    (BACFrameFunc)BAC_FrameGroupFunc_EndFrame,     
	(BACFrameFunc)BAC_FrameGroupFunc_FrameAssembly,
    (BACFrameFunc)BAC_FrameGroupFunc_SpriteParts,  
	(BACFrameFunc)BAC_FrameGroupFunc_Palette,
    (BACFrameFunc)BAC_FrameGroupFunc_EndAnimation, 
	(BACFrameFunc)BAC_FrameGroupFunc_Unused_5,
    (BACFrameFunc)BAC_FrameGroupFunc_Callback_6,   
	(BACFrameFunc)BAC_FrameGroupFunc_Callback_7,
    (BACFrameFunc)BAC_FrameGroupFunc_Callback_8,   
	(BACFrameFunc)BAC_FrameGroupFunc_EndAnimation_ChangeAnim,
    (BACFrameFunc)BAC_FrameGroupFunc_Unused_10,    
	(BACFrameFunc)BAC_FrameGroupFunc_Unused_11,
};

static const u16 spriteShapeSizes3D[] =
{
    GX_TEXSIZE_S8,  GX_TEXSIZE_T8,
	GX_TEXSIZE_S16, GX_TEXSIZE_T16,
	GX_TEXSIZE_S32, GX_TEXSIZE_T32,
	GX_TEXSIZE_S64, GX_TEXSIZE_T64,
	GX_TEXSIZE_S16, GX_TEXSIZE_T8,
	GX_TEXSIZE_S32, GX_TEXSIZE_T8,
	GX_TEXSIZE_S32, GX_TEXSIZE_T16,
	GX_TEXSIZE_S64, GX_TEXSIZE_T32,
	GX_TEXSIZE_S8,  GX_TEXSIZE_T16,
	GX_TEXSIZE_S8,  GX_TEXSIZE_T32,
	GX_TEXSIZE_S16, GX_TEXSIZE_T32,
	GX_TEXSIZE_S32, GX_TEXSIZE_T64,
};

static const Vec2U16 spriteShapeSizes2D[] =
{
	{ 0x08, 0x08 },
	{ 0x10, 0x10 },
	{ 0x20, 0x20 },
	{ 0x40, 0x40 },
	{ 0x10, 0x08 },
	{ 0x20, 0x08 },
	{ 0x20, 0x10 },
	{ 0x40, 0x20 },
	{ 0x08, 0x10 },
	{ 0x08, 0x20 },
	{ 0x10, 0x20 },
	{ 0x20, 0x40 },
};

// clang-format on

static const Animator3DMatrixFunc animator3DMatrixFuncList[MATRIX_OP_COUNT] = {
    [MATRIX_OP_NONE]                             = Animator3D__MatrixOp_None,
    [MATRIX_OP_IDENTITY]                         = Animator3D__MatrixOp_Identity,
    [MATRIX_OP_RESTORE_MTX]                      = Animator3D__MatrixOp_RestoreMtx,
    [MATRIX_OP_FLUSH_P]                          = Animator3D__MatrixOp_FlushP,
    [MATRIX_OP_FLUSH_VP]                         = Animator3D__MatrixOp_FlushVP,
    [MATRIX_OP_FLUSH_WVP]                        = Animator3D__MatrixOp_FlushWVP,
    [MATRIX_OP_SET_MATRIX_MODE]                  = Animator3D__MatrixOp_SetMatrixMode,
    [MATRIX_OP_FLUSH_P_CAMERA3D]                 = Animator3D__MatrixOp_FlushP_Camera3D,
    [MATRIX_OP_FLUSH_VP_CAMERA3D]                = Animator3D__MatrixOp_FlushVP_Camera3D,
    [MATRIX_OP_FLUSH_WVP_CAMERA3D]               = Animator3D__MatrixOp_FlushWVP_Camera3D,
    [MATRIX_OP_IDENTITY_SCALE]                   = Animator3D__MatrixOp_IdentityScale,
    [MATRIX_OP_COPY_MTX33_TO_43]                 = Animator3D__MatrixOp_CopyMtx33To43,
    [MATRIX_OP_IDENTITY_TRANSLATE]               = Animator3D__MatrixOp_IdentityTranslate,
    [MATRIX_OP_IDENTITY_TRANSLATE2]              = Animator3D__MatrixOp_IdentityTranslate2,
    [MATRIX_OP_IDENTITY_ROTATE_SCALE]            = Animator3D__MatrixOp_IdentityRotateScale,
    [MATRIX_OP_IDENTITY_ROTATE_TRANSLATE2_SCALE] = Animator3D__MatrixOp_IdentityRotateTranslate2Scale,
    [MATRIX_OP_LOAD_MTX43]                       = Animator3D__MatrixOp_LoadMtx43,
    [MATRIX_OP_LOAD_CAMERA_MTX43]                = Animator3D__MatrixOp_LoadCameraMtx43,
    [MATRIX_OP_LOAD_CAMERA_MTX33]                = Animator3D__MatrixOp_LoadCameraMtx33,
    [MATRIX_OP_SCALE]                            = Animator3D__MatrixOp_Scale,
    [MATRIX_OP_ROTATE]                           = Animator3D__MatrixOp_Rotate,
    [MATRIX_OP_TRANSLATE]                        = Animator3D__MatrixOp_Translate,
    [MATRIX_OP_TRANSLATE2]                       = Animator3D__MatrixOp_Translate2,
    [MATRIX_OP_ROTATE_SCALE]                     = Animator3D__MatrixOp_RotateScale,
    [MATRIX_OP_ROTATE_TRANSLATE2_SCALE]          = Animator3D__MatrixOp_RotateTranslate2Scale,
    [MATRIX_OP_MULT_MTX43]                       = Animator3D__MatrixOp_MultMtx43,
    [MATRIX_OP_MULT_CAMERA_MTX43]                = Animator3D__MatrixOp_MultCameraMtx43,
    [MATRIX_OP_MULT_CAMERA_MTX33]                = Animator3D__MatrixOp_MultCameraMtx33,
    [MATRIX_OP_SET_CAMERA_ROT_43]                = Animator3D__MatrixOp_SetCameraRot4x3,
    [MATRIX_OP_SET_CAMERA_ROT_33]                = Animator3D__MatrixOp_SetCameraRot3x3,
    [MATRIX_OP_CALLBACK]                         = Animator3D__MatrixOp_Callback,
};

static const GXTexFmt Sprite__Tex3DFormatForBACFormat[] = { GX_TEXFMT_PLTT16,  GX_TEXFMT_PLTT256, GX_TEXFMT_DIRECT, GX_TEXFMT_PLTT4, GX_TEXFMT_PLTT16,
                                                            GX_TEXFMT_PLTT256, GX_TEXFMT_DIRECT,  GX_TEXFMT_A3I5,   GX_TEXFMT_A5I3,  GX_TEXFMT_COMP4x4 };

static u8 _02143848[0x40]; // unknown

// --------------------
// HELPER MACROS
// --------------------

#define GetFile(filePtr)                           ((struct BACFile *)filePtr)
#define GetAnimHeaderBlock(filePtr)                ((struct BACAnimHeaderBlock *)&filePtr[GetFile(filePtr)->animHeaderOffset])
#define GetInfoBlock(filePtr)                      ((struct BACInfoBlock *)&filePtr[GetFile(filePtr)->infoOffset])
#define GetSpritePixelsBlock(filePtr, blockOffset) ((u8 *)&filePtr[GetFile(filePtr)->spritePixelOffset] + (blockOffset))
#define GetPaletteBlock(filePtr, blockOffset)      ((struct BACPaletteBlock *)(&filePtr[GetFile(filePtr)->paletteOffset] + (blockOffset)))

#define GetAnimHeaderBlockFromAnimator(animator)   ((struct BACAnimHeaderBlock *)(animator)->animHeaders)
#define GetAnimSequenceBlockFromAnimator(animator) ((BACFrameGroupBlockHeader *)&(animator)->animSequences[(animator)->animSequenceOffset])
#define GetFrameAssemblyFromAnimator(animator)     ((struct BACFrame *)&(animator)->frameAssembly[(animator)->assemblyOffset])

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL SpriteDrawBoundsCheck(const Vec2U16 *shapeSizePtr, u32 placeX, u32 placeY)
{
    if (placeX + shapeSizePtr->x >= shapeSizePtr->x + HW_LCD_WIDTH || placeY + shapeSizePtr->y >= shapeSizePtr->y + HW_LCD_HEIGHT)
        return FALSE;

    return TRUE;
}

// --------------------
// FUNCTIONS
// --------------------

// Common
void InitSpriteSystem(void)
{
    Sprite__InitUnknown();
}

// AnimatorSprite
void AnimatorSprite__Init(AnimatorSprite *animator, void *fileData, u16 animID, AnimatorFlags flags, BOOL useEngineB, PixelMode pixelMode, VRAMPixelKey vramPixels,
                          PaletteMode paletteMode, VRAMPaletteKey vramPalette, SpritePriority oamPriority, SpriteOrder oamOrder)
{
    MI_CpuClear32(animator, sizeof(AnimatorSprite));

    animator->type               = ANIMATOR2D_SPRITE;
    animator->fileData           = (u8 *)fileData;
    animator->animHeaders        = &((u8 *)fileData)[GetFile(fileData)->animHeaderOffset];
    animator->frameAssembly      = &((u8 *)fileData)[GetFile(fileData)->frameAssemblyOffset];
    animator->animSequences      = &((u8 *)fileData)[GetFile(fileData)->animSequenceOffset];
    animator->animAdvance        = FLOAT_TO_FX32(1.0);
    animator->animID             = animID;
    animator->flags              = flags;
    animator->useEngineB         = useEngineB;
    animator->pixelMode          = pixelMode;
    animator->vramPixels         = vramPixels;
    animator->paletteMode        = paletteMode;
    animator->vramPalette        = vramPalette;
    animator->oamPriority        = oamPriority;
    animator->oamOrder           = oamOrder;
    animator->animSequenceOffset = animator->prevAnimSequenceOffset = GetAnimHeaderBlockFromAnimator(animator)->anims[animID].offset;
}

void AnimatorSprite__Release(AnimatorSprite *animator)
{
    switch (animator->pixelMode)
    {
        case PIXEL_MODE_SPRITE:
            if (animator->vramPixels != NULL)
                VRAMSystem__FreeSpriteVram(animator->useEngineB, animator->vramPixels);
            break;

        case PIXEL_MODE_TEXTURE:
            VRAMSystem__FreeTexture(animator->vramPixels);
            break;
    }

    if (animator->paletteMode == PALETTE_MODE_TEXTURE)
        VRAMSystem__FreePalette(animator->vramPalette);
}

void AnimatorSprite__SetAnimation(AnimatorSprite *animator, u16 animID)
{
    animator->animID         = animID;
    animator->animFrameIndex = 0;
    animator->frameRemainder = 0;
    animator->frameTimer     = 0;
    animator->animFrameCount = 0;
    animator->flags &= ~(ANIMATOR_FLAG_DID_FINISH | ANIMATOR_FLAG_DID_LOOP);
    animator->animSequenceOffset = GetAnimHeaderBlockFromAnimator(animator)->anims[animID].offset;
}

void AnimatorSprite__ProcessAnimation(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    if ((animator->flags & ANIMATOR_FLAG_DID_LOOP) != 0)
        return;

    animator->flags &= ~ANIMATOR_FLAG_DID_FINISH;
    AnimatorFlags prevFlags = animator->flags;
    if ((animator->flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) != 0)
    {
        animator->flags |= (ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES);

        BOOL notFinished = Sprite__Animate(animator, callback, userData);
        if (notFinished)
        {
            while (animator->frameRemainder <= 0)
            {
                Sprite__Animate(animator, callback, userData);
            }
        }

        animator->flags &= ~(ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES);
        animator->flags |= prevFlags & (ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES);

        if (notFinished)
            AnimatorSprite__ProcessFrame(animator);
    }
    else
    {
        Sprite__Animate(animator, callback, userData);
    }
}

void AnimatorSprite__AnimateManual(AnimatorSprite *animator, fx32 advance, SpriteFrameCallback callback, void *userData)
{
    Sprite__AnimateManual(animator, advance, callback, userData);
    AnimatorSprite__ProcessFrame(animator);
}

void AnimatorSprite__ProcessFrame(AnimatorSprite *animator)
{
    if ((animator->flags & (ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES)) != (ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES))
    {
        AnimatorSprite ani = *animator;

        ani.animSequenceOffset = ani.prevAnimSequenceOffset;
        while ((frameGroupFuncList[GetAnimSequenceBlockFromAnimator(&ani)->blockID])(GetAnimSequenceBlockFromAnimator(&ani), &ani, NULL, NULL) != FRAME_BREAK)
        {
            // looping...
        }
    }
}

NONMATCH_FUNC void AnimatorSprite__DrawFrame(AnimatorSprite *animator)
{
    // https://decomp.me/scratch/u35xb -> 87.79%
#ifdef NON_MATCHING
    BOOL useEngineB = animator->useEngineB;
    u16 mosaicFlag  = 0;
    u16 flipFlags   = 0;

    struct BACFrame *frame = GetFrameAssemblyFromAnimator(animator);
    animator->lastSprite   = NULL;
    animator->firstSprite  = NULL;

    if ((animator->flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0 && frame->spriteCount > 0)
    {
        if ((animator->flags & ANIMATOR_FLAG_FLIP_X) != 0)
            flipFlags |= 0x1000;

        if ((animator->flags & ANIMATOR_FLAG_FLIP_Y) != 0)
            flipFlags |= 0x2000;

        if ((animator->flags & ANIMATOR_FLAG_ENABLE_MOSAIC) != 0)
            mosaicFlag |= (1 << GX_OAM_ATTR01_MOSAIC_SHIFT);

        u16 attr0Flags = (mosaicFlag | (animator->spriteType << GX_OAM_ATTR01_MODE_SHIFT));
        if ((animator->flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) != 0)
        {
            s32 x = animator->pos.x;
            if ((flipFlags & 0x1000) != 0)
            {
                if (x - frame->left <= 0 || x - frame->right >= HW_LCD_WIDTH)
                {
                    return;
                }
            }
            else
            {
                if (x + frame->right <= 0 || x + frame->left >= HW_LCD_WIDTH)
                {
                    return;
                }
            }

            s32 y = animator->pos.y;
            if ((flipFlags & 0x2000) != 0)
            {
                if (y - frame->top <= 0 || y - frame->bottom >= HW_LCD_HEIGHT)
                {
                    return;
                }
            }
            else
            {
                if (y + frame->bottom <= 0 || y + frame->top >= HW_LCD_HEIGHT)
                {
                    return;
                }
            }
        }

        GXOamAttr *spritePtr = frame->spriteList;
        u16 cParam           = animator->cParam.palette << GX_OAM_ATTR2_CPARAM_SHIFT;

        u32 shapeShift;
        u32 vramLocation;
        s32 shift = 0;

        if ((frame->spriteList[0].attr0 & GX_OAM_ATTR01_MODE_MASK) == (GX_OAM_MODE_BITMAPOBJ << GX_OAM_ATTR01_MODE_SHIFT))
        {
            shapeShift   = objBmpUse256K[useEngineB];
            vramLocation = GX_OAM_ATTR2_NAME_MASK & ((size_t)(animator->vramPixels - VRAMSystem__VRAM_OBJ[animator->useEngineB]) >> (7 + shapeShift));
        }
        else
        {
            shapeShift   = objBankShift[useEngineB];
            vramLocation = GX_OAM_ATTR2_NAME_MASK & ((size_t)(animator->vramPixels - VRAMSystem__VRAM_OBJ[animator->useEngineB]) >> (5 + shapeShift));

            if (GetAnimHeaderBlockFromAnimator(animator)->anims[animator->animID].format != 0)
            {
                shift = 1;
            }
        }

        u32 shift2 = (u16)((1 << shapeShift) - 1);

        u16 s = 0;
        for (s = 0; s < frame->spriteCount; s++, spritePtr++)
        {
            GXOamAttr *oam;
            u16 placeX;
            u16 placeY;

            u32 shape                   = ((spritePtr->attr0 & 0xC000) >> 12) | ((spritePtr->attr1 & 0xC000) >> 14);
            const Vec2U16 *shapeSizePtr = &spriteShapeSizes2D[shape];

            if ((flipFlags & 0x1000) != 0)
                placeX = animator->pos.x + frame->hotspot.x - spritePtr->x - shapeSizePtr->x;
            else
                placeX = animator->pos.x - frame->hotspot.x + spritePtr->x;

            if ((flipFlags & 0x2000) != 0)
                placeY = animator->pos.y + frame->hotspot.y - spritePtr->y - shapeSizePtr->y;
            else
                placeY = animator->pos.y - frame->hotspot.y + spritePtr->y;

            if ((animator->flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) != 0 && SpriteDrawBoundsCheck(shapeSizePtr, placeX, placeY) == FALSE)
            {
                if ((frame->useGFXIndex & 1) == 0)
                {
                    vramLocation += (Sprite__ShapeTileCount[shape] + shift2) >> shapeShift << shift;
                }
            }
            else
            {
                oam = OAMSystem__Alloc(animator->useEngineB, animator->oamOrder);
                if (&oamDefault == oam)
                    return;

                GXOamAttr *first     = animator->firstSprite;
                animator->lastSprite = oam;
                if (first == NULL)
                    animator->firstSprite = oam;

                ((GXOamAttr2 *)oam)->y = placeY;
                ((GXOamAttr2 *)oam)->attr0 |= attr0Flags;
                ((GXOamAttr2 *)oam)->x = placeX;
                ((GXOamAttr2 *)oam)->attr1 ^= flipFlags;

                if ((frame->useGFXIndex & 1) == 0)
                {
                    oam->attr2 =
                        (vramLocation & GX_OAM_ATTR2_NAME_MASK) | (animator->oamPriority << GX_OAM_ATTR2_PRIORITY_SHIFT) | (spritePtr->attr2 + cParam) & GX_OAM_ATTR2_CPARAM_MASK;

                    vramLocation += (Sprite__ShapeTileCount[shape] + shift2) >> shapeShift << shift;
                }
                else
                {
                    oam->attr2 = ((spritePtr->attr2 + vramLocation) & GX_OAM_ATTR2_NAME_MASK) | (animator->oamPriority << GX_OAM_ATTR2_PRIORITY_SHIFT)
                                 | ((spritePtr->attr2 + cParam) & GX_OAM_ATTR2_CPARAM_MASK);
                }
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	mov r10, r0
	ldr r0, [r10, #4]
	mov r1, #0
	ldr r4, [r10, #0x1c]
	ldr r3, [r10, #0x2c]
	str r1, [sp]
	str r1, [r10, #0x60]
	str r1, [r10, #0x5c]
	ldr r2, [r10, #0x3c]
	add r5, r4, r3
	tst r2, #1
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r3, [r5, #0]
	cmp r3, #0
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r2, #0x80
	beq _020806E0
	orr r4, r1, #0x1000
	mov r4, r4, lsl #0x10
	mov r4, r4, lsr #0x10
	str r4, [sp]
_020806E0:
	tst r2, #0x100
	beq _020806FC
	ldr r4, [sp]
	orr r4, r4, #0x2000
	mov r4, r4, lsl #0x10
	mov r4, r4, lsr #0x10
	str r4, [sp]
_020806FC:
	tst r2, #0x400
	orrne r1, r1, #0x1000
	movne r1, r1, lsl #0x10
	movne r1, r1, lsr #0x10
	ldr r4, [r10, #0x58]
	tst r2, #0x800
	orr r1, r1, r4, lsl #10
	mov r1, r1, lsl #0x10
	str r1, [sp, #0x18]
	beq _020807EC
	ldr r1, [sp]
	ldrsh r2, [r10, #8]
	tst r1, #0x1000
	beq _02080760
	ldrsh r1, [r5, #4]
	sub r1, r2, r1
	cmp r1, #0
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsh r1, [r5, #8]
	sub r1, r2, r1
	cmp r1, #0x100
	blt _02080788
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02080760:
	ldrsh r1, [r5, #8]
	add r1, r2, r1
	cmp r1, #0
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsh r1, [r5, #4]
	add r1, r2, r1
	cmp r1, #0x100
	addge sp, sp, #0x28
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02080788:
	ldr r1, [sp]
	ldrsh r2, [r10, #0xa]
	tst r1, #0x2000
	beq _020807C4
	ldrsh r1, [r5, #6]
	sub r1, r2, r1
	cmp r1, #0
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsh r1, [r5, #0xa]
	sub r1, r2, r1
	cmp r1, #0xc0
	blt _020807EC
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020807C4:
	ldrsh r1, [r5, #0xa]
	add r1, r2, r1
	cmp r1, #0
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsh r1, [r5, #6]
	add r1, r2, r1
	cmp r1, #0xc0
	addge sp, sp, #0x28
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020807EC:
	ldrh r1, [r5, #0x10]
	ldrh r2, [r10, #0x50]
	add r6, r5, #0x10
	and r1, r1, #0xc00
	cmp r1, #0xc00
	mov r1, r2, lsl #0x1c
	str r1, [sp, #0x1c]
	mov r1, #0
	str r1, [sp, #0x10]
	bne _0208084C
	ldr r1, =objBmpUse256K
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldr r1, [r10, #4]
	ldr r2, [r10, #0x44]
	str r0, [sp, #0x14]
	ldr r0, =VRAMSystem__VRAM_OBJ
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =0x000003FF
	sub r2, r2, r0
	ldr r0, [sp, #0x14]
	add r0, r0, #7
	and r7, r1, r2, lsr r0
	b _0208089C
_0208084C:
	ldr r4, =objBankShift
	mov r0, r0, lsl #1
	ldrh r0, [r4, r0]
	ldrh r1, [r10, #0xc]
	ldr r2, [r10, #0x18]
	str r0, [sp, #0x14]
	add r1, r2, r1, lsl #3
	ldrh r2, [r1, #8]
	ldr r1, [r10, #4]
	ldr r0, =VRAMSystem__VRAM_OBJ
	ldr r4, [r10, #0x44]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =0x000003FF
	sub r4, r4, r0
	ldr r0, [sp, #0x14]
	cmp r2, #0
	add r0, r0, #5
	and r7, r1, r4, lsr r0
	movne r0, #1
	strne r0, [sp, #0x10]
_0208089C:
	ldr r0, [sp, #0x14]
	mov r1, #1
	mov r0, r1, lsl r0
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	str r0, [sp, #0x20]
	mov r0, #0
	cmp r3, #0
	str r0, [sp, #0xc]
	addls sp, sp, #0x28
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	mov r4, #0x200
	and r0, r0, #0x1000
	str r0, [sp, #8]
	ldr r0, [sp]
	rsb r4, r4, #0
	and r0, r0, #0x2000
	str r0, [sp, #4]
	sub r0, r4, #0x200
	str r0, [sp, #0x24]
_020808F0:
	ldrh r3, [r6, #2]
	ldr r0, [sp, #8]
	ldrh r1, [r6, #0]
	cmp r0, #0
	and r0, r3, #0xc000
	mov r0, r0, asr #0xe
	and r2, r1, #0xc000
	orr r11, r0, r2, asr #12
	ldr r0, =spriteShapeSizes2D
	mov r2, r3, lsl #0x16
	add r0, r0, r11, lsl #2
	mov r2, r2, lsr #0x10
	beq _02080944
	ldrsh r9, [r10, #8]
	ldrsh r8, [r5, #0xc]
	ldrh r3, [r0, #0]
	mov r2, r2, lsl #0x10
	add r8, r9, r8
	sub r2, r8, r2, asr #22
	sub r8, r2, r3
	b _02080958
_02080944:
	ldrsh r8, [r10, #8]
	ldrsh r3, [r5, #0xc]
	mov r2, r2, lsl #0x10
	sub r3, r8, r3
	add r8, r3, r2, asr #22
_02080958:
	ldr r2, [sp, #4]
	mov r1, r1, lsl #0x17
	cmp r2, #0
	mov r1, r1, lsr #0x10
	beq _0208098C
	ldrsh r9, [r10, #0xa]
	ldrsh r3, [r5, #0xe]
	ldrh r2, [r0, #2]
	mov r1, r1, lsl #0x10
	add r3, r9, r3
	sub r1, r3, r1, asr #23
	sub r9, r1, r2
	b _020809A0
_0208098C:
	ldrsh r3, [r10, #0xa]
	ldrsh r2, [r5, #0xe]
	mov r1, r1, lsl #0x10
	sub r2, r3, r2
	add r9, r2, r1, asr #23
_020809A0:
	ldr r1, [r10, #0x3c]
	tst r1, #0x800
	beq _02080A1C
	ldrh r1, [r0, #0]
	add r2, r8, r1
	add r1, r1, #0x100
	cmp r2, r1
	bhs _020809D4
	ldrh r0, [r0, #2]
	add r1, r9, r0
	add r0, r0, #0xc0
	cmp r1, r0
	blo _020809DC
_020809D4:
	mov r0, #0
	b _020809E0
_020809DC:
	mov r0, #1
_020809E0:
	cmp r0, #0
	bne _02080A1C
	ldrh r0, [r5, #2]
	tst r0, #1
	bne _02080B14
	ldr r0, =Sprite__ShapeTileCount
	mov r1, r11, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, [sp, #0x20]
	add r1, r1, r0, lsr #16
	ldr r0, [sp, #0x14]
	mov r1, r1, lsr r0
	ldr r0, [sp, #0x10]
	add r7, r7, r1, lsl r0
	b _02080B14
_02080A1C:
	ldrb r1, [r10, #0x57]
	ldr r0, [r10, #4]
	bl OAMSystem__Alloc
	ldr r1, =oamDefault
	cmp r1, r0
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r10, #0x5c]
	and r2, r8, r4, lsr #23
	str r0, [r10, #0x60]
	cmp r1, #0
	streq r0, [r10, #0x5c]
	ldrh r3, [r6, #0]
	and r1, r9, #0xff
	and r3, r3, r4
	orr r1, r3, r1
	strh r1, [r0]
	ldrh r3, [r0, #0]
	ldr r1, [sp, #0x18]
	orr r1, r3, r1, lsr #16
	strh r1, [r0]
	ldrh r3, [r6, #2]
	ldr r1, [sp, #0x24]
	and r1, r3, r1
	orr r1, r1, r2
	strh r1, [r0, #2]
	ldrh r2, [r0, #2]
	ldr r1, [sp]
	eor r1, r2, r1
	strh r1, [r0, #2]
	ldrh r1, [r5, #2]
	tst r1, #1
	bne _02080AEC
	ldr r1, =Sprite__ShapeTileCount
	mov r2, r11, lsl #1
	ldrh r2, [r1, r2]
	ldr r1, [sp, #0x20]
	and r8, r7, r4, lsr #22
	add r2, r2, r1, lsr #16
	ldr r1, [sp, #0x14]
	ldrb r3, [r10, #0x56]
	mov r2, r2, lsr r1
	ldr r1, [sp, #0x10]
	orr r3, r8, r3, lsl #10
	add r7, r7, r2, lsl r1
	ldrh r2, [r6, #4]
	ldr r1, [sp, #0x1c]
	add r1, r2, r1, lsr #16
	and r1, r1, #0xf000
	orr r1, r3, r1
	strh r1, [r0, #4]
	b _02080B14
_02080AEC:
	ldrh r3, [r6, #4]
	ldrb r2, [r10, #0x56]
	add r1, r3, r7
	and r1, r1, r4, lsr #22
	orr r2, r1, r2, lsl #10
	ldr r1, [sp, #0x1c]
	add r1, r3, r1, lsr #16
	and r1, r1, #0xf000
	orr r1, r2, r1
	strh r1, [r0, #4]
_02080B14:
	ldr r0, [sp, #0xc]
	add r6, r6, #8
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r0, [sp, #0xc]
	ldrh r0, [r5, #0]
	cmp r0, r1, lsr #16
	bhi _020808F0
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void AnimatorSprite__DrawFrameRotoZoom(AnimatorSprite *animator, fx32 scaleX, fx32 scaleY, s32 rotation)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xe0
	mov r10, r0
	ldr r4, [r10, #4]
	mov r0, #0
	str r0, [sp, #0x2c]
	ldr r5, [r10, #0x1c]
	ldr r0, [r10, #0x2c]
	ldr r6, [sp, #0x2c]
	mov r9, r1
	str r6, [r10, #0x60]
	ldr r6, [sp, #0x2c]
	mov r8, r2
	str r6, [r10, #0x5c]
	ldr r11, [r10, #0x3c]
	ldr r1, [sp, #0x2c]
	mov r7, r3
	str r1, [sp, #0x14]
	tst r11, #1
	add r5, r5, r0
	addne sp, sp, #0xe0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r6, [r5, #0]
	cmp r6, #0
	addeq sp, sp, #0xe0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r9, #0
	rsblt r0, r9, #0
	movge r0, r9
	cmp r0, #0x22
	addlt sp, sp, #0xe0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, #0
	rsblt r0, r8, #0
	movge r0, r8
	cmp r0, #0x22
	addlt sp, sp, #0xe0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r11, #0x1000
	bne _02080C38
	ldr r0, [r10, #4]
	cmp r6, #4
	movhs r6, #4
	bl OAMSystem__GetOAMAffineOffset
	mov r11, r0
	ldr r0, [r10, #4]
	bl OAMSystem__GetOAMAffineCount
	add r0, r11, r0
	add r0, r6, r0
	cmp r0, #0x20
	blt _02080C38
	mov r0, r10
	bl AnimatorSprite__DrawFrame
	add sp, sp, #0xe0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02080C38:
	mov r0, r9
	bl FX_Inv
	mov r6, r0
	mov r0, r8
	bl FX_Inv
	mov r11, r0
	cmp r7, #0
	bne _02080C7C
	cmp r9, #0
	subgt r9, r9, #0x80
	bgt _02080C68
	addlt r9, r9, #0x80
_02080C68:
	cmp r8, #0
	subgt r8, r8, #0x80
	bgt _02080C9C
	addlt r8, r8, #0x80
	b _02080C9C
_02080C7C:
	cmp r9, #0
	subgt r9, r9, #0x90
	bgt _02080C8C
	addlt r9, r9, #0x90
_02080C8C:
	cmp r8, #0
	subgt r8, r8, #0x90
	bgt _02080C9C
	addlt r8, r8, #0x90
_02080C9C:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0xa0
	bl MTX_Rot22_
	rsb r0, r6, #0
	str r0, [sp, #8]
	ldr r2, [sp, #8]
	add r0, sp, #0xa0
	add r1, sp, #0x70
	mov r3, r11
	bl MTX_ScaleApply22
	rsb r7, r9, #0
	add r0, sp, #0xa0
	add r1, sp, #0xb0
	mov r2, r7
	mov r3, r8
	bl MTX_ScaleApply22
	rsb r0, r11, #0
	str r0, [sp, #0xc]
	ldr r3, [sp, #0xc]
	add r0, sp, #0xa0
	add r1, sp, #0x80
	mov r2, r6
	bl MTX_ScaleApply22
	rsb r0, r8, #0
	str r0, [sp, #4]
	ldr r3, [sp, #4]
	add r0, sp, #0xa0
	add r1, sp, #0xc0
	mov r2, r9
	bl MTX_ScaleApply22
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	add r0, sp, #0xa0
	add r1, sp, #0x90
	bl MTX_ScaleApply22
	ldr r3, [sp, #4]
	mov r2, r7
	add r0, sp, #0xa0
	add r1, sp, #0xd0
	bl MTX_ScaleApply22
	mov r2, r6
	mov r3, r11
	add r0, sp, #0xa0
	add r1, sp, #0x60
	bl MTX_ScaleApply22
	add r0, sp, #0xa0
	mov r2, r9
	mov r3, r8
	mov r1, r0
	bl MTX_ScaleApply22
	ldr r0, [r10, #0x3c]
	tst r0, #0x80
	beq _02080DA8
	ldr r1, [sp, #0x14]
	orr r1, r1, #0x1000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x14]
_02080DA8:
	tst r0, #0x100
	beq _02080DC4
	ldr r1, [sp, #0x14]
	orr r1, r1, #0x2000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x14]
_02080DC4:
	tst r0, #0x400
	beq _02080DE0
	ldr r1, [sp, #0x2c]
	orr r1, r1, #0x1000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x2c]
_02080DE0:
	tst r0, #0x200
	beq _02080DFC
	ldr r0, [sp, #0x2c]
	orr r0, r0, #0x200
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x2c]
_02080DFC:
	ldr r0, =_02112144
	ldr r7, [r10, #0x58]
	add r6, sp, #0x50
	ldmia r0, {r0, r1, r2, r3}
	stmia r6, {r0, r1, r2, r3}
	ldr r0, [sp, #0x2c]
	ldrh r1, [r5, #0x10]
	orr r0, r0, r7, lsl #10
	mov r0, r0, lsl #0x10
	and r1, r1, #0xc00
	ldrh r2, [r10, #0x50]
	mov r0, r0, lsr #0x10
	cmp r1, #0xc00
	str r0, [sp, #0x2c]
	mov r0, r2, lsl #0x1c
	str r0, [sp, #0x40]
	mov r0, #0
	add r6, r5, #0x10
	str r0, [sp, #0x24]
	bne _02080E84
	ldr r0, =objBmpUse256K
	mov r1, r4, lsl #1
	ldrh r0, [r0, r1]
	ldr r1, [r10, #4]
	ldr r2, [r10, #0x44]
	str r0, [sp, #0x28]
	ldr r0, =VRAMSystem__VRAM_OBJ
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =0x000003FF
	sub r2, r2, r0
	ldr r0, [sp, #0x28]
	add r0, r0, #7
	and r7, r1, r2, lsr r0
	b _02080ED4
_02080E84:
	ldrh r0, [r10, #0xc]
	ldr r1, [r10, #0x18]
	ldr r2, =objBankShift
	mov r3, r4, lsl #1
	add r1, r1, r0, lsl #3
	ldrh r0, [r2, r3]
	ldrh r2, [r1, #8]
	ldr r1, [r10, #4]
	str r0, [sp, #0x28]
	ldr r0, =VRAMSystem__VRAM_OBJ
	ldr r3, [r10, #0x44]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =0x000003FF
	sub r3, r3, r0
	ldr r0, [sp, #0x28]
	cmp r2, #0
	add r0, r0, #5
	and r7, r1, r3, lsr r0
	movne r0, #1
	strne r0, [sp, #0x24]
_02080ED4:
	ldr r0, [sp, #0x28]
	mov r1, #1
	mov r0, r1, lsl r0
	ldrh r1, [r5, #0]
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	str r0, [sp, #0x44]
	mov r0, #0
	cmp r1, #0
	str r0, [sp, #0x20]
	addls sp, sp, #0xe0
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x14]
	mov r4, #0x200
	and r0, r0, #0x3000
	mov r0, r0, asr #0xc
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x2c]
	add r1, sp, #0xa0
	and r0, r0, #0x200
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x30]
	rsb r4, r4, #0
	add r0, r1, r0, lsl #4
	str r0, [sp, #0x38]
	sub r0, r4, #0x200
	str r0, [sp, #0x48]
_02080F40:
	ldr r0, [sp, #0x10]
	ldrh r2, [r6, #2]
	cmp r0, #0
	ldrh r3, [r6, #0]
	ldr r0, [sp, #0x30]
	add r1, sp, #0xa0
	ldr r9, [r1, r0, lsl #4]
	and r0, r2, #0xc000
	and r1, r3, #0xc000
	mov r0, r0, asr #0xe
	orr r0, r0, r1, asr #12
	ldr r1, =spriteShapeSizes2D
	str r0, [sp, #0x18]
	ldr r0, [r1, r0, lsl #2]
	ldr r3, [sp, #0x14]
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x38]
	ldr lr, [r0, #8]
	ldr r0, [sp, #0x34]
	str r0, [sp, #0x4c]
	ldrh r1, [r6, #2]
	ldrsh r0, [r5, #0xc]
	ldrh r2, [sp, #0x4c]
	eor r3, r3, r1
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	and r3, r3, #0x3000
	mov r8, r3, asr #0xc
	mov r1, r1, lsl #0x16
	ldrh r3, [r6, #0]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	rsb r0, r0, r1, asr #22
	mov r3, r3, lsl #0x17
	add r1, r0, r2, asr #1
	mov r3, r3, lsr #0x10
	ldrsh ip, [r5, #0xe]
	mov r3, r3, lsl #0x10
	ldrh r0, [sp, #0x4e]
	rsb r3, ip, r3, asr #23
	ldrsh r11, [r10, #8]
	add r3, r3, r0, asr #1
	mul ip, r3, lr
	mla r9, r1, r9, ip
	ldr ip, [sp, #0x38]
	sub r11, r11, r2, asr #1
	ldr ip, [ip, #4]
	add r11, r11, r9, asr #12
	str ip, [sp, #0x3c]
	ldr ip, [sp, #0x38]
	ldrsh r9, [r10, #0xa]
	ldr ip, [ip, #0xc]
	mul ip, r3, ip
	ldr r3, [sp, #0x3c]
	sub r9, r9, r0, asr #1
	mla r3, r1, r3, ip
	add r9, r9, r3, asr #12
	beq _02081040
	sub r9, r9, r0, asr #1
	ldr r0, [sp, #0x34]
	sub r11, r11, r2, asr #1
	mov r1, r0, lsl #1
	add r0, sp, #0x4c
	str r1, [r0]
_02081040:
	ldr r0, [r10, #0x3c]
	tst r0, #0x800
	beq _020810C0
	ldrh r0, [sp, #0x4c]
	add r1, r11, r0
	add r0, r0, #0x100
	cmp r1, r0
	bhs _02081074
	ldrh r0, [sp, #0x4e]
	add r1, r9, r0
	add r0, r0, #0xc0
	cmp r1, r0
	blo _0208107C
_02081074:
	mov r0, #0
	b _02081080
_0208107C:
	mov r0, #1
_02081080:
	cmp r0, #0
	bne _020810C0
	ldrh r0, [r5, #2]
	tst r0, #1
	bne _02081294
	ldr r0, [sp, #0x18]
	mov r1, r0, lsl #1
	ldr r0, =Sprite__ShapeTileCount
	ldrh r1, [r0, r1]
	ldr r0, [sp, #0x44]
	add r1, r1, r0, lsr #16
	ldr r0, [sp, #0x28]
	mov r1, r1, lsr r0
	ldr r0, [sp, #0x24]
	add r7, r7, r1, lsl r0
	b _02081294
_020810C0:
	ldr r0, [r10, #4]
	str r0, [sp, #0x1c]
	add r0, sp, #0x50
	ldr r0, [r0, r8, lsl #2]
	str r0, [sp]
	cmp r0, #0
	bge _0208114C
	add r1, sp, #0x60
	ldr r0, [sp, #0x1c]
	add r1, r1, r8, lsl #4
	bl OAMSystem__AddAffineSprite
	add r1, sp, #0x50
	str r0, [r1, r8, lsl #2]
	str r0, [sp]
	cmp r0, #0
	movlt r0, #0
	blt _02081150
	ldr r0, [sp, #0x1c]
	bl OAMSystem__GetList1
	ldr r1, [sp]
	add r0, r0, r1, lsl #5
	add r1, sp, #0x60
	ldr r3, [r1, r8, lsl #4]
	add r2, r1, r8, lsl #4
	mov r1, r3, asr #4
	strh r1, [r0, #6]
	ldr r1, [r2, #4]
	mov r1, r1, asr #4
	strh r1, [r0, #0xe]
	ldr r1, [r2, #8]
	mov r1, r1, asr #4
	strh r1, [r0, #0x16]
	ldr r1, [r2, #0xc]
	mov r1, r1, asr #4
	strh r1, [r0, #0x1e]
_0208114C:
	mov r0, #1
_02081150:
	cmp r0, #0
	bne _02081190
	ldrh r0, [r5, #2]
	tst r0, #1
	bne _02081294
	ldr r0, [sp, #0x18]
	mov r1, r0, lsl #1
	ldr r0, =Sprite__ShapeTileCount
	ldrh r1, [r0, r1]
	ldr r0, [sp, #0x44]
	add r1, r1, r0, lsr #16
	ldr r0, [sp, #0x28]
	mov r1, r1, lsr r0
	ldr r0, [sp, #0x24]
	add r7, r7, r1, lsl r0
	b _02081294
_02081190:
	ldrb r1, [r10, #0x57]
	ldr r0, [r10, #4]
	bl OAMSystem__Alloc
	ldr r1, =oamDefault
	cmp r1, r0
	addeq sp, sp, #0xe0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r10, #0x5c]
	and r2, r11, r4, lsr #23
	str r0, [r10, #0x60]
	cmp r1, #0
	streq r0, [r10, #0x5c]
	ldrh r3, [r6, #0]
	and r1, r9, #0xff
	and r3, r3, r4
	orr r1, r3, r1
	orr r1, r1, #0x100
	strh r1, [r0]
	ldrh r3, [r0, #0]
	ldr r1, [sp, #0x2c]
	orr r1, r3, r1
	strh r1, [r0]
	ldrh r3, [r6, #2]
	ldr r1, [sp, #0x48]
	and r1, r3, r1
	orr r1, r1, r2
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	bic r2, r1, #0x3e00
	ldr r1, [sp]
	orr r1, r2, r1, lsl #9
	strh r1, [r0, #2]
	ldrh r1, [r5, #2]
	tst r1, #1
	bne _0208126C
	ldr r1, [sp, #0x18]
	and r8, r7, r4, lsr #22
	mov r2, r1, lsl #1
	ldr r1, =Sprite__ShapeTileCount
	ldrb r3, [r10, #0x56]
	ldrh r2, [r1, r2]
	ldr r1, [sp, #0x44]
	orr r3, r8, r3, lsl #10
	add r2, r2, r1, lsr #16
	ldr r1, [sp, #0x28]
	mov r2, r2, lsr r1
	ldr r1, [sp, #0x24]
	add r7, r7, r2, lsl r1
	ldrh r2, [r6, #4]
	ldr r1, [sp, #0x40]
	add r1, r2, r1, lsr #16
	and r1, r1, #0xf000
	orr r1, r3, r1
	strh r1, [r0, #4]
	b _02081294
_0208126C:
	ldrh r3, [r6, #4]
	ldrb r2, [r10, #0x56]
	add r1, r3, r7
	and r1, r1, r4, lsr #22
	orr r2, r1, r2, lsl #10
	ldr r1, [sp, #0x40]
	add r1, r3, r1, lsr #16
	and r1, r1, #0xf000
	orr r1, r2, r1
	strh r1, [r0, #4]
_02081294:
	ldr r0, [sp, #0x20]
	ldrh r1, [r5, #0]
	add r0, r0, #1
	str r0, [sp, #0x20]
	add r6, r6, #8
	cmp r0, r1
	blo _02080F40
	add sp, sp, #0xe0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

BOOL AnimatorSprite__GetBlockData(AnimatorSprite *animator, s32 id, void *data)
{
    u32 offset = animator->prevAnimSequenceOffset;

    while (2) // 2?
    {
        BACFrameGroupBlockHeader *block = (BACFrameGroupBlockHeader *)&animator->animSequences[offset];

        switch (block->blockID)
        {
            case SPRITE_BLOCK_CALLBACK2: {
                BACFrameGroupBlock_Hitbox *hitboxBlock = (BACFrameGroupBlock_Hitbox *)block;

                if (id != hitboxBlock->id)
                    continue;

                MI_CpuCopy16(&hitboxBlock->hitbox, data, sizeof(HitboxRect));
                return TRUE;
            }

            case SPRITE_BLOCK_END_FRAME:
            case SPRITE_BLOCK_END_ANIMATION:
            case SPRITE_BLOCK_END_ANIMATION_CHANGE_ANIM:
                return FALSE;

            case SPRITE_BLOCK_SPRITE_MAPPINGS:
            case SPRITE_BLOCK_SPRITE_GRAPHICS:
            case SPRITE_BLOCK_SPRITE_PALETTE:
            case SPRITE_BLOCK_UNUSED1:
            case SPRITE_BLOCK_CALLBACK1:
            case SPRITE_BLOCK_CALLBACK3:
            default:
                offset += block->blockSize;
                continue;
        }
        break;
    }
}

// AnimatorSpriteDS
void AnimatorSpriteDS__Init(AnimatorSpriteDS *animator, void *fileData, u16 animID, ScreenDrawFlags screensToDraw, AnimatorFlags flags, PixelMode spriteMode0,
                            VRAMPixelKey vramPixels0, PaletteMode paletteMode0, VRAMPaletteKey vramPalette0, PixelMode spriteMode1, VRAMPixelKey vramPixels1,
                            PaletteMode paletteMode1, VRAMPaletteKey vramPalette1, SpritePriority oamPriority, SpriteOrder oamOrder)
{
    MI_CpuClear32(animator, sizeof(AnimatorSpriteDS));

    // Common
    animator->work.type          = ANIMATOR2D_SPRITE_DS;
    animator->work.fileData      = (u8 *)fileData;
    animator->work.animHeaders   = &((u8 *)fileData)[GetFile(fileData)->animHeaderOffset];
    animator->work.frameAssembly = &((u8 *)fileData)[GetFile(fileData)->frameAssemblyOffset];
    animator->work.animSequences = &((u8 *)fileData)[GetFile(fileData)->animSequenceOffset];
    animator->work.animAdvance   = FLOAT_TO_FX32(1.0);
    animator->work.flags         = flags;
    animator->work.animID        = animID;
    animator->work.oamPriority   = oamPriority;
    animator->work.oamOrder      = oamOrder;
    animator->screensToDraw      = screensToDraw;

    // Engine A
    animator->pixelMode[0]   = spriteMode0;
    animator->vramPixels[0]  = vramPixels0;
    animator->paletteMode[0] = paletteMode0;
    animator->vramPalette[0] = vramPalette0;

    // Engine B
    animator->pixelMode[1]   = spriteMode1;
    animator->vramPixels[1]  = vramPixels1;
    animator->paletteMode[1] = paletteMode1;
    animator->vramPalette[1] = vramPalette1;

    // Anim Sequence
    animator->work.animSequenceOffset = GetAnimHeaderBlockFromAnimator(&animator->work)->anims[animID].offset;
}

void AnimatorSpriteDS__Release(AnimatorSpriteDS *animator)
{
    for (u32 i = 0; i < 2; i++)
    {
        switch (animator->pixelMode[i])
        {
            case PIXEL_MODE_SPRITE:
                if (animator->vramPixels[i])
                    VRAMSystem__FreeSpriteVram(i, animator->vramPixels[i]);
                break;

            case PIXEL_MODE_TEXTURE:
                VRAMSystem__FreeTexture(animator->vramPixels[i]);
                break;
        }

        if (animator->paletteMode[i] == PALETTE_MODE_TEXTURE)
            VRAMSystem__FreePalette(animator->vramPalette[i]);
    }
}

void AnimatorSpriteDS__SetAnimation(AnimatorSpriteDS *animator, u16 animID)
{
    AnimatorSprite__SetAnimation(&animator->work, animID);
}

void AnimatorSpriteDS__ProcessAnimation(AnimatorSpriteDS *animator, SpriteFrameCallback callback, void *userData)
{
    if ((animator->work.flags & ANIMATOR_FLAG_DID_LOOP) != 0)
        return;

    animator->work.flags &= ~ANIMATOR_FLAG_DID_FINISH;
    AnimatorFlags prevFlags = animator->work.flags;
    if ((animator->work.flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) != 0)
    {
        animator->work.flags |= (ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES);

        BOOL notFinished = Sprite__AnimateDS(animator, callback, userData);
        if (notFinished)
        {
            while (animator->work.frameRemainder <= 0)
            {
                Sprite__AnimateDS(animator, callback, userData);
            }
        }

        animator->work.flags &= ~(ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES);
        animator->work.flags |= prevFlags & (ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES);

        if (notFinished)
            AnimatorSpriteDS__ProcessFrame(animator);
    }
    else
    {
        Sprite__AnimateDS(animator, callback, userData);
    }
}

void AnimatorSpriteDS__AnimateManual(AnimatorSpriteDS *animator, fx32 advance, SpriteFrameCallback callback, void *userData)
{
    Sprite__AnimateManual(&animator->work, advance, callback, userData);
    AnimatorSpriteDS__ProcessFrame(animator);
}

void AnimatorSpriteDS__ProcessFrame(AnimatorSpriteDS *animator)
{
    AnimatorSprite animatorSprite;
    MI_CpuCopy16(&animator->work, &animatorSprite, sizeof(animatorSprite));

    for (u32 i = 0; i < 2; i++)
    {
        animatorSprite.useEngineB     = i;
        animatorSprite.pixelMode      = animator->pixelMode[i];
        animatorSprite.vramPixels     = animator->vramPixels[i];
        animatorSprite.paletteMode    = animator->paletteMode[i];
        animatorSprite.vramPalette    = animator->vramPalette[i];
        animatorSprite.cParam.palette = animator->cParam[i].palette;
        AnimatorSprite__ProcessFrame(&animatorSprite);
    }
}

NONMATCH_FUNC void AnimatorSpriteDS__DrawFrame(AnimatorSpriteDS *animator)
{
#ifdef NON_MATCHING

#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x48
	mov r10, r0
	ldr r0, [r10, #0x64]
	ldr r4, [r10, #0x1c]
	ldr r3, [r10, #0x2c]
	mov r1, #0
	str r1, [r10, #0x98]
	str r1, [r10, #0x94]
	str r1, [r10, #0xa0]
	str r1, [r10, #0x9c]
	ldr r2, [r10, #0x3c]
	add r6, r4, r3
	str r1, [sp, #0x1c]
	tst r2, #1
	addne sp, sp, #0x48
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r3, [r6, #0]
	cmp r3, #0
	addeq sp, sp, #0x48
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r2, #0x800
	beq _020817C4
	tst r0, #1
	bne _020816F8
	tst r2, #0x80
	ldrsh r5, [r10, #0x68]
	beq _02081668
	ldrsh r4, [r6, #4]
	sub r4, r5, r4
	cmp r4, #0
	ble _02081660
	ldrsh r4, [r6, #8]
	sub r4, r5, r4
	cmp r4, #0x100
	blt _02081690
_02081660:
	mov r4, #0
	b _020816F0
_02081668:
	ldrsh r4, [r6, #8]
	add r4, r5, r4
	cmp r4, #0
	ble _02081688
	ldrsh r4, [r6, #4]
	add r4, r5, r4
	cmp r4, #0x100
	blt _02081690
_02081688:
	mov r4, #0
	b _020816F0
_02081690:
	tst r2, #0x100
	ldrsh r5, [r10, #0x6a]
	beq _020816C4
	ldrsh r4, [r6, #6]
	sub r4, r5, r4
	cmp r4, #0
	ble _020816BC
	ldrsh r4, [r6, #0xa]
	sub r4, r5, r4
	cmp r4, #0xc0
	blt _020816EC
_020816BC:
	mov r4, #0
	b _020816F0
_020816C4:
	ldrsh r4, [r6, #0xa]
	add r4, r5, r4
	cmp r4, #0
	ble _020816E4
	ldrsh r4, [r6, #6]
	add r4, r5, r4
	cmp r4, #0xc0
	blt _020816EC
_020816E4:
	mov r4, #0
	b _020816F0
_020816EC:
	mov r4, #1
_020816F0:
	cmp r4, #0
	orreq r0, r0, #1
_020816F8:
	tst r0, #2
	bne _020817C4
	tst r2, #0x80
	ldrsh r5, [r10, #0x6c]
	beq _02081734
	ldrsh r4, [r6, #4]
	sub r4, r5, r4
	cmp r4, #0
	ble _0208172C
	ldrsh r4, [r6, #8]
	sub r4, r5, r4
	cmp r4, #0x100
	blt _0208175C
_0208172C:
	mov r4, #0
	b _020817BC
_02081734:
	ldrsh r4, [r6, #8]
	add r4, r5, r4
	cmp r4, #0
	ble _02081754
	ldrsh r4, [r6, #4]
	add r4, r5, r4
	cmp r4, #0x100
	blt _0208175C
_02081754:
	mov r4, #0
	b _020817BC
_0208175C:
	tst r2, #0x100
	ldrsh r5, [r10, #0x6e]
	beq _02081790
	ldrsh r4, [r6, #6]
	sub r4, r5, r4
	cmp r4, #0
	ble _02081788
	ldrsh r4, [r6, #0xa]
	sub r4, r5, r4
	cmp r4, #0xc0
	blt _020817B8
_02081788:
	mov r4, #0
	b _020817BC
_02081790:
	ldrsh r4, [r6, #0xa]
	add r4, r5, r4
	cmp r4, #0
	ble _020817B0
	ldrsh r4, [r6, #6]
	add r4, r5, r4
	cmp r4, #0xc0
	blt _020817B8
_020817B0:
	mov r4, #0
	b _020817BC
_020817B8:
	mov r4, #1
_020817BC:
	cmp r4, #0
	orreq r0, r0, #2
_020817C4:
	and r0, r0, #3
	cmp r0, #3
	addeq sp, sp, #0x48
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r0, #1
	beq _02081844
	cmp r0, #2
	bne _020818A4
	mov r0, #0
	str r0, [r10, #4]
	ldrsh r1, [r10, #0x68]
	mov r0, r10
	strh r1, [r10, #8]
	ldrsh r1, [r10, #0x6a]
	strh r1, [r10, #0xa]
	ldr r1, [r10, #0x70]
	str r1, [r10, #0x40]
	ldr r1, [r10, #0x78]
	str r1, [r10, #0x44]
	ldr r1, [r10, #0x80]
	str r1, [r10, #0x48]
	ldr r1, [r10, #0x88]
	str r1, [r10, #0x4c]
	ldrh r1, [r10, #0x90]
	strh r1, [r10, #0x50]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r10, #0x5c]
	add sp, sp, #0x48
	str r0, [r10, #0x94]
	ldr r0, [r10, #0x60]
	str r0, [r10, #0x9c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02081844:
	mov r0, #1
	str r0, [r10, #4]
	ldrsh r1, [r10, #0x6c]
	mov r0, r10
	strh r1, [r10, #8]
	ldrsh r1, [r10, #0x6e]
	strh r1, [r10, #0xa]
	ldr r1, [r10, #0x74]
	str r1, [r10, #0x40]
	ldr r1, [r10, #0x7c]
	str r1, [r10, #0x44]
	ldr r1, [r10, #0x84]
	str r1, [r10, #0x48]
	ldr r1, [r10, #0x8c]
	str r1, [r10, #0x4c]
	ldrh r1, [r10, #0x92]
	strh r1, [r10, #0x50]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r10, #0x5c]
	add sp, sp, #0x48
	str r0, [r10, #0x98]
	ldr r0, [r10, #0x60]
	str r0, [r10, #0xa0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020818A4:
	tst r2, #0x80
	beq _020818C0
	ldr r0, [sp, #0x1c]
	orr r0, r0, #0x1000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
_020818C0:
	tst r2, #0x100
	beq _020818DC
	ldr r0, [sp, #0x1c]
	orr r0, r0, #0x2000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
_020818DC:
	tst r2, #0x400
	orrne r0, r1, #0x1000
	movne r0, r0, lsl #0x10
	movne r1, r0, lsr #0x10
	ldrh r0, [r6, #0x10]
	ldr r5, [r10, #0x58]
	ldrh r4, [r10, #0x90]
	and r0, r0, #0xc00
	ldrh r2, [r10, #0x92]
	orr r5, r1, r5, lsl #10
	cmp r0, #0xc00
	mov r0, r5, lsl #0x10
	mov r4, r4, lsl #0xc
	mov r1, r2, lsl #0xc
	str r0, [sp, #0x24]
	mov r0, #0
	strh r4, [sp, #0x2c]
	strh r1, [sp, #0x2e]
	add r7, r6, #0x10
	str r0, [sp, #0x18]
	bne _02081980
	ldr r4, =objBmpUse256K
	ldr r2, =VRAMSystem__VRAM_OBJ
	ldrh r0, [r4, #0]
	ldr r8, [r10, #0x78]
	ldr r5, [r2, #0]
	ldr r1, =0x000003FF
	sub r8, r8, r5
	add r5, r0, #7
	and r5, r1, r8, lsr r5
	str r5, [sp, #0x40]
	ldrh r8, [r4, #2]
	ldr r5, [r10, #0x7c]
	ldr r4, [r2, #4]
	add r2, r8, #7
	sub r4, r5, r4
	and r1, r1, r4, lsr r2
	str r1, [sp, #0x44]
	str r0, [sp, #0x38]
	str r8, [sp, #0x3c]
	b _020819E8
_02081980:
	ldr r0, =objBankShift
	ldr r4, =VRAMSystem__VRAM_OBJ
	ldrh r1, [r0, #0]
	ldr r8, [r10, #0x78]
	ldr r5, [r4, #0]
	ldr r2, =0x000003FF
	sub r8, r8, r5
	add r5, r1, #5
	and r5, r2, r8, lsr r5
	str r5, [sp, #0x40]
	ldrh r0, [r0, #2]
	ldr r5, [r4, #4]
	ldr r8, [r10, #0x7c]
	add r4, r0, #5
	sub r5, r8, r5
	and r2, r2, r5, lsr r4
	str r2, [sp, #0x44]
	ldrh r2, [r10, #0xc]
	ldr r4, [r10, #0x18]
	str r1, [sp, #0x38]
	add r1, r4, r2, lsl #3
	ldrh r1, [r1, #8]
	str r0, [sp, #0x3c]
	cmp r1, #0
	movne r0, #1
	strne r0, [sp, #0x18]
_020819E8:
	ldr r1, [sp, #0x38]
	mov r2, #1
	ldr r0, [sp, #0x3c]
	mov r1, r2, lsl r1
	mov r0, r2, lsl r0
	sub r2, r1, #1
	sub r1, r0, #1
	mov r0, r2, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x34]
	mov r0, #0
	str r2, [sp, #0x30]
	cmp r3, #0
	str r0, [sp, #0x14]
	addls sp, sp, #0x48
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x1c]
	and r0, r0, #0x1000
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x1c]
	and r0, r0, #0x2000
	str r0, [sp, #8]
_02081A48:
	ldrh r4, [r7, #2]
	ldrh r1, [r7, #0]
	ldr r3, =spriteShapeSizes2D
	and r0, r4, #0xc000
	and r2, r1, #0xc000
	mov r0, r0, asr #0xe
	orr r0, r0, r2, asr #12
	ldr r2, [sp, #0xc]
	cmp r2, #0
	add r2, r3, r0, lsl #2
	str r2, [sp, #0x10]
	mov r2, r4, lsl #0x16
	mov r2, r2, lsr #0x10
	beq _02081AA0
	mov r3, r2, lsl #0x10
	ldr r2, [sp, #0x10]
	ldrsh r4, [r6, #0xc]
	ldrh r2, [r2, #0]
	sub r3, r4, r3, asr #22
	sub r2, r3, r2
	str r2, [sp, #4]
	b _02081AB0
_02081AA0:
	ldrsh r3, [r6, #0xc]
	mov r2, r2, lsl #0x10
	rsb r2, r3, r2, asr #22
	str r2, [sp, #4]
_02081AB0:
	ldr r2, [sp, #8]
	mov r1, r1, lsl #0x17
	cmp r2, #0
	mov r1, r1, lsr #0x10
	beq _02081AE4
	mov r2, r1, lsl #0x10
	ldr r1, [sp, #0x10]
	ldrsh r3, [r6, #0xe]
	ldrh r1, [r1, #2]
	sub r2, r3, r2, asr #23
	sub r1, r2, r1
	str r1, [sp]
	b _02081AF4
_02081AE4:
	ldrsh r2, [r6, #0xe]
	mov r1, r1, lsl #0x10
	rsb r1, r2, r1, asr #23
	str r1, [sp]
_02081AF4:
	mov r1, r0, lsl #1
	ldr r0, =Sprite__ShapeTileCount
	mov r4, #0x200
	ldrh r0, [r0, r1]
	rsb r4, r4, #0
	mov r9, #0
	str r0, [sp, #0x20]
	sub r0, r4, #0x200
	add r5, sp, #0x40
	str r0, [sp, #0x28]
_02081B1C:
	add r0, r10, r9, lsl #2
	ldrsh r3, [r0, #0x68]
	ldrsh r2, [r0, #0x6a]
	ldr r0, [sp, #4]
	ldr r1, [r10, #0x3c]
	add r11, r0, r3
	ldr r0, [sp]
	tst r1, #0x800
	add r8, r0, r2
	beq _02081BC4
	ldr r0, [sp, #0x10]
	ldrh r0, [r0, #0]
	add r1, r11, r0
	add r0, r0, #0x100
	cmp r1, r0
	bhs _02081B74
	ldr r0, [sp, #0x10]
	ldrh r0, [r0, #2]
	add r1, r8, r0
	add r0, r0, #0xc0
	cmp r1, r0
	blo _02081B7C
_02081B74:
	mov r0, #0
	b _02081B80
_02081B7C:
	mov r0, #1
_02081B80:
	cmp r0, #0
	bne _02081BC4
	ldrh r0, [r6, #2]
	tst r0, #1
	bne _02081CE0
	add r1, sp, #0x30
	ldr r3, [r1, r9, lsl #2]
	add r1, sp, #0x38
	ldr r2, [r1, r9, lsl #2]
	ldr r1, [sp, #0x20]
	ldr r0, [r5, r9, lsl #2]
	add r1, r1, r3
	mov r2, r1, lsr r2
	ldr r1, [sp, #0x18]
	add r0, r0, r2, lsl r1
	str r0, [r5, r9, lsl #2]
	b _02081CE0
_02081BC4:
	ldrb r1, [r10, #0x57]
	mov r0, r9
	bl OAMSystem__Alloc
	ldr r1, =oamDefault
	cmp r1, r0
	addeq sp, sp, #0x48
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r2, r10, r9, lsl #2
	ldr r1, [r2, #0x94]
	str r0, [r2, #0x9c]
	cmp r1, #0
	streq r0, [r2, #0x94]
	ldrh r3, [r7, #0]
	and r1, r8, #0xff
	and r2, r11, r4, lsr #23
	and r3, r3, r4
	orr r1, r3, r1
	strh r1, [r0]
	ldrh r3, [r0, #0]
	ldr r1, [sp, #0x24]
	orr r1, r3, r1, lsr #16
	strh r1, [r0]
	ldrh r3, [r7, #2]
	ldr r1, [sp, #0x28]
	and r1, r3, r1
	orr r1, r1, r2
	strh r1, [r0, #2]
	ldrh r2, [r0, #2]
	ldr r1, [sp, #0x1c]
	eor r1, r2, r1
	strh r1, [r0, #2]
	ldrh r1, [r6, #2]
	tst r1, #1
	bne _02081CAC
	ldr r1, [r5, r9, lsl #2]
	ldrb r2, [r10, #0x56]
	and r1, r1, r4, lsr #22
	add r11, sp, #0x38
	orr r8, r1, r2, lsl #10
	mov r2, r9, lsl #1
	add r1, sp, #0x2c
	ldrh r2, [r1, r2]
	ldrh r3, [r7, #4]
	add r1, sp, #0x30
	ldr r1, [r1, r9, lsl #2]
	add r2, r3, r2
	and r2, r2, #0xf000
	orr r2, r8, r2
	strh r2, [r0, #4]
	ldr r0, [sp, #0x20]
	ldr r11, [r11, r9, lsl #2]
	add r0, r0, r1
	mov r1, r0, lsr r11
	ldr r2, [r5, r9, lsl #2]
	ldr r0, [sp, #0x18]
	add r0, r2, r1, lsl r0
	str r0, [r5, r9, lsl #2]
	b _02081CE0
_02081CAC:
	ldrh r2, [r7, #4]
	ldr r1, [r5, r9, lsl #2]
	ldrb r3, [r10, #0x56]
	add r1, r2, r1
	and r1, r1, r4, lsr #22
	orr r1, r1, r3, lsl #10
	mov r8, r9, lsl #1
	add r3, sp, #0x2c
	ldrh r3, [r3, r8]
	add r2, r2, r3
	and r2, r2, #0xf000
	orr r1, r1, r2
	strh r1, [r0, #4]
_02081CE0:
	add r9, r9, #1
	cmp r9, #2
	blt _02081B1C
	ldr r0, [sp, #0x14]
	ldrh r1, [r6, #0]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x14]
	add r7, r7, #8
	bhi _02081A48
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void AnimatorSpriteDS__DrawFrameRotoZoom(AnimatorSpriteDS *animator, fx32 scaleX, fx32 scaleY, s32 rotation)
{
#ifdef NON_MATCHING

#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x120
	mov r10, r0
	ldr r4, [r10, #0x1c]
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r0, [r10, #0x2c]
	ldr r5, [sp, #0x34]
	mov r9, r1
	str r5, [r10, #0x98]
	ldr r5, [sp, #0x34]
	mov r8, r2
	str r5, [r10, #0x94]
	ldr r5, [sp, #0x34]
	mov r7, r3
	str r5, [r10, #0xa0]
	ldr r5, [sp, #0x34]
	add r6, r4, r0
	str r5, [r10, #0x9c]
	ldr r5, [r10, #0x3c]
	ldr r1, [sp, #0x34]
	tst r5, #1
	str r1, [sp, #0x14]
	addne sp, sp, #0x120
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r4, [r6, #0]
	cmp r4, #0
	addeq sp, sp, #0x120
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r9, #0
	rsblt r0, r9, #0
	movge r0, r9
	cmp r0, #0x22
	addlt sp, sp, #0x120
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, #0
	rsblt r0, r8, #0
	movge r0, r8
	cmp r0, #0x22
	addlt sp, sp, #0x120
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r10, #0x64]
	and r0, r0, #3
	cmp r0, #3
	addeq sp, sp, #0x120
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r5, #0x1000
	bne _02081EDC
	mov r0, #0
	cmp r4, #4
	movhs r4, #4
	bl OAMSystem__GetOAMAffineOffset
	mov r5, r0
	mov r0, #0
	bl OAMSystem__GetOAMAffineCount
	add r0, r5, r0
	add r0, r4, r0
	cmp r0, #0x20
	bge _02081E44
	mov r0, #1
	bl OAMSystem__GetOAMAffineOffset
	mov r5, r0
	mov r0, #1
	bl OAMSystem__GetOAMAffineCount
	add r0, r5, r0
	add r0, r4, r0
	cmp r0, #0x20
	blt _02081EDC
_02081E44:
	mov r0, #0
	str r0, [r10, #4]
	ldrsh r1, [r10, #0x68]
	mov r0, r10
	strh r1, [r10, #8]
	ldrsh r1, [r10, #0x6a]
	strh r1, [r10, #0xa]
	ldr r1, [r10, #0x70]
	str r1, [r10, #0x40]
	ldr r1, [r10, #0x78]
	str r1, [r10, #0x44]
	ldr r1, [r10, #0x80]
	str r1, [r10, #0x48]
	ldr r1, [r10, #0x88]
	str r1, [r10, #0x4c]
	ldrh r1, [r10, #0x90]
	strh r1, [r10, #0x50]
	bl AnimatorSprite__DrawFrame
	mov r0, #1
	str r0, [r10, #4]
	ldrsh r1, [r10, #0x6c]
	mov r0, r10
	strh r1, [r10, #8]
	ldrsh r1, [r10, #0x6e]
	strh r1, [r10, #0xa]
	ldr r1, [r10, #0x74]
	str r1, [r10, #0x40]
	ldr r1, [r10, #0x7c]
	str r1, [r10, #0x44]
	ldr r1, [r10, #0x84]
	str r1, [r10, #0x48]
	ldr r1, [r10, #0x8c]
	str r1, [r10, #0x4c]
	ldrh r1, [r10, #0x92]
	strh r1, [r10, #0x50]
	bl AnimatorSprite__DrawFrame
	add sp, sp, #0x120
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02081EDC:
	ldr r0, [r10, #0x64]
	and r0, r0, #3
	cmp r0, #1
	beq _02081F60
	cmp r0, #2
	bne _02081FCC
	mov r0, #0
	str r0, [r10, #4]
	ldrsh r2, [r10, #0x68]
	mov r0, r10
	mov r1, r9
	strh r2, [r10, #8]
	ldrsh r4, [r10, #0x6a]
	mov r2, r8
	mov r3, r7
	strh r4, [r10, #0xa]
	ldr r4, [r10, #0x70]
	str r4, [r10, #0x40]
	ldr r4, [r10, #0x78]
	str r4, [r10, #0x44]
	ldr r4, [r10, #0x80]
	str r4, [r10, #0x48]
	ldr r4, [r10, #0x88]
	str r4, [r10, #0x4c]
	ldrh r4, [r10, #0x90]
	strh r4, [r10, #0x50]
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, [r10, #0x5c]
	add sp, sp, #0x120
	str r0, [r10, #0x94]
	ldr r0, [r10, #0x60]
	str r0, [r10, #0x9c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02081F60:
	mov r0, #1
	str r0, [r10, #4]
	ldrsh r2, [r10, #0x6c]
	mov r0, r10
	mov r1, r9
	strh r2, [r10, #8]
	ldrsh r4, [r10, #0x6e]
	mov r2, r8
	mov r3, r7
	strh r4, [r10, #0xa]
	ldr r4, [r10, #0x74]
	str r4, [r10, #0x40]
	ldr r4, [r10, #0x7c]
	str r4, [r10, #0x44]
	ldr r4, [r10, #0x84]
	str r4, [r10, #0x48]
	ldr r4, [r10, #0x8c]
	str r4, [r10, #0x4c]
	ldrh r4, [r10, #0x92]
	strh r4, [r10, #0x50]
	bl AnimatorSprite__DrawFrameRotoZoom
	ldr r0, [r10, #0x5c]
	add sp, sp, #0x120
	str r0, [r10, #0x98]
	ldr r0, [r10, #0x60]
	str r0, [r10, #0xa0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02081FCC:
	mov r0, r9
	bl FX_Inv
	mov r5, r0
	mov r0, r8
	bl FX_Inv
	mov r4, r0
	cmp r7, #0
	bne _02082010
	cmp r9, #0
	subgt r9, r9, #0x80
	bgt _02081FFC
	addlt r9, r9, #0x80
_02081FFC:
	cmp r8, #0
	subgt r8, r8, #0x80
	bgt _02082030
	addlt r8, r8, #0x80
	b _02082030
_02082010:
	cmp r9, #0
	subgt r9, r9, #0x90
	bgt _02082020
	addlt r9, r9, #0x90
_02082020:
	cmp r8, #0
	subgt r8, r8, #0x90
	bgt _02082030
	addlt r8, r8, #0x90
_02082030:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0xe0
	bl MTX_Rot22_
	rsb r0, r5, #0
	str r0, [sp, #4]
	ldr r2, [sp, #4]
	add r0, sp, #0xe0
	add r1, sp, #0xb0
	mov r3, r4
	bl MTX_ScaleApply22
	rsb r7, r9, #0
	add r0, sp, #0xe0
	add r1, sp, #0xf0
	mov r2, r7
	mov r3, r8
	bl MTX_ScaleApply22
	rsb r0, r4, #0
	str r0, [sp, #8]
	ldr r3, [sp, #8]
	add r0, sp, #0xe0
	add r1, sp, #0xc0
	mov r2, r5
	bl MTX_ScaleApply22
	rsb r11, r8, #0
	add r0, sp, #0xe0
	add r1, sp, #0x100
	mov r2, r9
	mov r3, r11
	bl MTX_ScaleApply22
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	add r0, sp, #0xe0
	add r1, sp, #0xd0
	bl MTX_ScaleApply22
	mov r2, r7
	mov r3, r11
	add r0, sp, #0xe0
	add r1, sp, #0x110
	bl MTX_ScaleApply22
	mov r2, r5
	mov r3, r4
	add r0, sp, #0xe0
	add r1, sp, #0xa0
	bl MTX_ScaleApply22
	add r0, sp, #0xe0
	mov r2, r9
	mov r3, r8
	mov r1, r0
	bl MTX_ScaleApply22
	ldr r0, [r10, #0x3c]
	tst r0, #0x80
	beq _02082138
	ldr r1, [sp, #0x14]
	orr r1, r1, #0x1000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x14]
_02082138:
	tst r0, #0x100
	beq _02082154
	ldr r1, [sp, #0x14]
	orr r1, r1, #0x2000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x14]
_02082154:
	tst r0, #0x400
	beq _02082170
	ldr r1, [sp, #0x34]
	orr r1, r1, #0x1000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x34]
_02082170:
	tst r0, #0x200
	beq _0208218C
	ldr r0, [sp, #0x34]
	orr r0, r0, #0x200
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x34]
_0208218C:
	ldr r4, [r10, #0x58]
	ldr r0, [sp, #0x34]
	ldrh r3, [r10, #0x90]
	ldrh r2, [r10, #0x92]
	ldrh r1, [r6, #0x10]
	orr r0, r0, r4, lsl #10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, r3, lsl #0xc
	mov r2, r2, lsl #0xc
	and r1, r1, #0xc00
	str r0, [sp, #0x34]
	mov r0, #0
	strh r3, [sp, #0x44]
	strh r2, [sp, #0x46]
	cmp r1, #0xc00
	add r7, r6, #0x10
	str r0, [sp, #0x30]
	bne _02082228
	ldr r3, =objBmpUse256K
	ldr r2, =VRAMSystem__VRAM_OBJ
	ldrh r0, [r3, #0]
	ldr r5, [r10, #0x78]
	ldr r4, [r2, #0]
	ldr r1, =0x000003FF
	sub r5, r5, r4
	add r4, r0, #7
	and r4, r1, r5, lsr r4
	str r4, [sp, #0x58]
	ldrh r5, [r3, #2]
	ldr r4, [r10, #0x7c]
	ldr r3, [r2, #4]
	add r2, r5, #7
	sub r3, r4, r3
	and r1, r1, r3, lsr r2
	str r1, [sp, #0x5c]
	str r0, [sp, #0x50]
	str r5, [sp, #0x54]
	b _02082290
_02082228:
	ldr r0, =objBankShift
	ldr r3, =VRAMSystem__VRAM_OBJ
	ldrh r1, [r0, #0]
	ldr r5, [r10, #0x78]
	ldr r4, [r3, #0]
	ldr r2, =0x000003FF
	sub r5, r5, r4
	add r4, r1, #5
	and r4, r2, r5, lsr r4
	str r4, [sp, #0x58]
	ldrh r0, [r0, #2]
	ldr r4, [r3, #4]
	ldr r5, [r10, #0x7c]
	add r3, r0, #5
	sub r4, r5, r4
	and r2, r2, r4, lsr r3
	str r2, [sp, #0x5c]
	ldrh r2, [r10, #0xc]
	ldr r3, [r10, #0x18]
	str r1, [sp, #0x50]
	add r1, r3, r2, lsl #3
	ldrh r1, [r1, #8]
	str r0, [sp, #0x54]
	cmp r1, #0
	movne r0, #1
	strne r0, [sp, #0x30]
_02082290:
	ldr r1, [sp, #0x50]
	mov r2, #1
	ldr r0, [sp, #0x54]
	mov r1, r2, lsl r1
	mov r0, r2, lsl r0
	sub r3, r1, #1
	sub r1, r0, #1
	ldrh r2, [r6, #0]
	mov r0, r3, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x4c]
	mov r0, #0
	str r3, [sp, #0x48]
	cmp r2, #0
	str r0, [sp, #0x2c]
	addls sp, sp, #0x120
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r5, =_02112180
	add r4, sp, #0x60
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r0, [sp, #0x14]
	and r0, r0, #0x3000
	mov r0, r0, asr #0xc
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x34]
	and r0, r0, #0x200
	str r0, [sp, #0xc]
_02082310:
	add r9, sp, #0x60
	add r8, sp, #0x80
	ldmia r9!, {r0, r1, r2, r3}
	stmia r8!, {r0, r1, r2, r3}
	ldr r0, [sp, #0xc]
	ldr r5, =spriteShapeSizes2D
	cmp r0, #0
	ldmia r9, {r0, r1, r2, r3}
	stmia r8, {r0, r1, r2, r3}
	ldrh r1, [r7, #2]
	ldrh r2, [r7, #0]
	ldr r0, [sp, #0x10]
	and r1, r1, #0xc000
	add r4, sp, #0xe0
	and r2, r2, #0xc000
	mov r1, r1, asr #0xe
	orr lr, r1, r2, asr #12
	ldr r8, [r5, lr, lsl #2]
	ldr r1, [sp, #0x10]
	str r8, [sp, #0x40]
	add ip, r4, r1, lsl #4
	ldr r0, [r4, r0, lsl #4]
	ldrh r2, [sp, #0x40]
	ldrh r3, [r7, #2]
	ldr r4, [sp, #0x14]
	ldrsh r1, [r6, #0xc]
	eor r4, r4, r3
	mov r4, r4, lsl #0x10
	mov r3, r3, lsl #0x16
	mov r4, r4, lsr #0x10
	mov r3, r3, lsr #0x10
	and r4, r4, #0x3000
	mov r3, r3, lsl #0x10
	mov r4, r4, asr #0xc
	rsb r1, r1, r3, asr #22
	str r4, [sp, #0x28]
	add r4, r1, r2, asr #1
	mov r5, r2, asr #1
	ldrh r2, [r7, #0]
	ldrh r1, [sp, #0x42]
	ldrsh r9, [r6, #0xe]
	mov r2, r2, lsl #0x17
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	rsb r2, r9, r2, asr #23
	mov r3, r1, asr #1
	add r2, r2, r1, asr #1
	ldr r11, [ip, #8]
	rsb r1, r5, #0
	mul r11, r2, r11
	mla r0, r4, r0, r11
	add r0, r1, r0, asr #12
	ldr r1, [ip, #0xc]
	str r0, [sp, #0x24]
	mul r1, r2, r1
	ldr r0, [ip, #4]
	rsb r9, r3, #0
	mla r0, r4, r0, r1
	add r0, r9, r0, asr #12
	str r0, [sp, #0x20]
	beq _02082428
	ldr r0, [sp, #0x24]
	add r1, sp, #0x40
	sub r0, r0, r5
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x20]
	sub r0, r0, r3
	str r0, [sp, #0x20]
	mov r0, r8, lsl #1
	str r0, [r1]
_02082428:
	ldr r0, [sp, #0x28]
	add r1, sp, #0xa0
	add r8, r1, r0, lsl #4
	add r2, sp, #0x80
	add r0, r2, r0, lsl #2
	str r0, [sp, #0x38]
	mov r4, #0x200
	ldr r0, =Sprite__ShapeTileCount
	mov r1, lr, lsl #1
	ldrh r11, [r0, r1]
	rsb r4, r4, #0
	sub r0, r4, #0x200
	mov r9, #0
	add r5, sp, #0x58
	str r0, [sp, #0x3c]
_02082464:
	add r0, r10, r9, lsl #2
	ldrsh r3, [r0, #0x68]
	ldrsh r2, [r0, #0x6a]
	ldr r0, [sp, #0x24]
	ldr r1, [r10, #0x3c]
	add r0, r0, r3
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x20]
	tst r1, #0x800
	add r0, r0, r2
	str r0, [sp, #0x18]
	beq _02082510
	ldrh r2, [sp, #0x40]
	ldr r0, [sp, #0x1c]
	add r1, r0, r2
	add r0, r2, #0x100
	cmp r1, r0
	bhs _020824C4
	ldrh r2, [sp, #0x42]
	ldr r0, [sp, #0x18]
	add r1, r0, r2
	add r0, r2, #0xc0
	cmp r1, r0
	blo _020824CC
_020824C4:
	mov r0, #0
	b _020824D0
_020824CC:
	mov r0, #1
_020824D0:
	cmp r0, #0
	bne _02082510
	ldrh r0, [r6, #2]
	tst r0, #1
	bne _020826FC
	add r1, sp, #0x48
	ldr r2, [r1, r9, lsl #2]
	add r1, sp, #0x50
	ldr r1, [r1, r9, lsl #2]
	add r2, r11, r2
	mov r2, r2, lsr r1
	ldr r0, [r5, r9, lsl #2]
	ldr r1, [sp, #0x30]
	add r0, r0, r2, lsl r1
	str r0, [r5, r9, lsl #2]
	b _020826FC
_02082510:
	ldr r0, [sp, #0x38]
	ldr r0, [r0, r9, lsl #4]
	str r0, [sp]
	cmp r0, #0
	bge _02082590
	mov r0, r9
	mov r1, r8
	bl OAMSystem__AddAffineSprite
	ldr r1, [sp, #0x38]
	str r0, [sp]
	str r0, [r1, r9, lsl #4]
	cmp r0, #0
	movlt r0, #0
	blt _02082594
	mov r0, r9
	bl OAMSystem__GetList1
	ldr r1, [sp]
	add r2, sp, #0xa0
	add r0, r0, r1, lsl #5
	ldr r1, [sp, #0x28]
	ldr r1, [r2, r1, lsl #4]
	mov r1, r1, asr #4
	strh r1, [r0, #6]
	ldr r1, [r8, #4]
	mov r1, r1, asr #4
	strh r1, [r0, #0xe]
	ldr r1, [r8, #8]
	mov r1, r1, asr #4
	strh r1, [r0, #0x16]
	ldr r1, [r8, #0xc]
	mov r1, r1, asr #4
	strh r1, [r0, #0x1e]
_02082590:
	mov r0, #1
_02082594:
	cmp r0, #0
	bne _020825D4
	ldrh r0, [r6, #2]
	tst r0, #1
	bne _020826FC
	add r1, sp, #0x48
	ldr r2, [r1, r9, lsl #2]
	add r1, sp, #0x50
	ldr r1, [r1, r9, lsl #2]
	add r2, r11, r2
	mov r2, r2, lsr r1
	ldr r0, [r5, r9, lsl #2]
	ldr r1, [sp, #0x30]
	add r0, r0, r2, lsl r1
	str r0, [r5, r9, lsl #2]
	b _020826FC
_020825D4:
	ldrb r1, [r10, #0x57]
	mov r0, r9
	bl OAMSystem__Alloc
	ldr r1, =oamDefault
	cmp r1, r0
	addeq sp, sp, #0x120
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r2, r10, r9, lsl #2
	ldr r1, [r2, #0x94]
	cmp r1, #0
	ldr r1, [sp, #0x18]
	str r0, [r2, #0x9c]
	and r3, r1, #0xff
	ldr r1, [sp, #0x1c]
	streq r0, [r2, #0x94]
	and r2, r1, r4, lsr #23
	ldrh r1, [r7, #0]
	and r1, r1, r4
	orr r1, r1, r3
	orr r1, r1, #0x100
	strh r1, [r0]
	ldrh r3, [r0, #0]
	ldr r1, [sp, #0x34]
	orr r1, r3, r1
	strh r1, [r0]
	ldrh r3, [r7, #2]
	ldr r1, [sp, #0x3c]
	and r1, r3, r1
	orr r1, r1, r2
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	bic r2, r1, #0x3e00
	ldr r1, [sp]
	orr r1, r2, r1, lsl #9
	strh r1, [r0, #2]
	ldrh r1, [r6, #2]
	tst r1, #1
	bne _020826C8
	ldr r1, [r5, r9, lsl #2]
	ldrb r3, [r10, #0x56]
	and r1, r1, r4, lsr #22
	mov ip, r9, lsl #1
	orr r3, r1, r3, lsl #10
	add r1, sp, #0x44
	ldrh r1, [r1, ip]
	ldrh r2, [r7, #4]
	add ip, sp, #0x48
	ldr lr, [ip, r9, lsl #2]
	add r1, r2, r1
	add ip, sp, #0x50
	and r1, r1, #0xf000
	orr r1, r3, r1
	strh r1, [r0, #4]
	ldr ip, [ip, r9, lsl #2]
	add r0, r11, lr
	mov r1, r0, lsr ip
	ldr r2, [r5, r9, lsl #2]
	ldr r0, [sp, #0x30]
	add r0, r2, r1, lsl r0
	str r0, [r5, r9, lsl #2]
	b _020826FC
_020826C8:
	ldrh r3, [r7, #4]
	ldr ip, [r5, r9, lsl #2]
	ldrb r2, [r10, #0x56]
	add ip, r3, ip
	and ip, ip, r4, lsr #22
	orr r2, ip, r2, lsl #10
	mov r1, r9, lsl #1
	add ip, sp, #0x44
	ldrh r1, [ip, r1]
	add r1, r3, r1
	and r1, r1, #0xf000
	orr r1, r2, r1
	strh r1, [r0, #4]
_020826FC:
	add r9, r9, #1
	cmp r9, #2
	blt _02082464
	ldr r0, [sp, #0x2c]
	ldrh r1, [r6, #0]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	add r7, r7, #8
	cmp r0, r1
	blo _02082310
	add sp, sp, #0x120
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

void Sprite__InitUnknown(void)
{
    MI_CpuClear16(&_02143848, sizeof(_02143848));
}

void AnimatorSpriteDS__SetAnimation2(AnimatorSpriteDS *animator, u16 animID)
{
    AnimatorSprite__SetAnimation((AnimatorSprite *)animator, animID);
}

// AnimatorMDL
void AnimatorMDL__Init(AnimatorMDL *animator, AnimatorFlags flags)
{
    MI_CpuClear32(animator, sizeof(AnimatorMDL));

    animator->work.type           = ANIMATOR3D_MODEL;
    animator->work.flags          = flags;
    animator->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_P;
    animator->work.scale.z        = FX_ONE;
    animator->work.scale.y        = FX_ONE;
    animator->work.scale.x        = FX_ONE;

    MTX_Identity33(&animator->work.rotation);
    MTX_Identity43(&animator->work.matrix43);

    for (u32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        animator->speed[i] = FX_ONE;
        animator->ratio[i] = FX_ONE;
    }

    animator->speedMultiplier = FX_ONE;
    animator->ratioMultiplier = FX_ONE;
}

void AnimatorMDL__Release(AnimatorMDL *animator)
{
    for (u32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if (animator->currentAnimObj[i] != NULL)
        {
            NNS_G3dRenderObjRemoveAnmObj(&animator->renderObj, animator->currentAnimObj[i]);
            NNS_G3dFreeAnmObj(&heapSystemAllocator, animator->currentAnimObj[i]);
            animator->currentAnimObj[i] = NULL;
        }

        if (animator->prevAnimObj[i] != NULL)
        {
            NNS_G3dRenderObjRemoveAnmObj(&animator->renderObj, animator->prevAnimObj[i]);
            NNS_G3dFreeAnmObj(&heapSystemAllocator, animator->prevAnimObj[i]);
            animator->prevAnimObj[i] = NULL;
        }
    }

    if (animator->jntAnimResult != NULL)
    {
        if (animator->renderObj.recMatAnm == NULL)
            NNS_G3dRenderObjResetFlag(&animator->renderObj, NNS_G3D_RENDEROBJ_FLAG_RECORD);

        animator->renderObj.recJntAnm = NULL;
        NNS_G3dFreeRecBufferJnt(&heapSystemAllocator, animator->jntAnimResult);
        animator->jntAnimResult = NULL;
    }

    if (animator->matAnimResult != NULL)
    {
        if (animator->renderObj.recJntAnm == NULL)
            NNS_G3dRenderObjResetFlag(&animator->renderObj, NNS_G3D_RENDEROBJ_FLAG_RECORD);

        animator->renderObj.recMatAnm = NULL;
        NNS_G3dFreeRecBufferMat(&heapSystemAllocator, animator->matAnimResult);
        animator->matAnimResult = NULL;
    }
}

void AnimatorMDL__SetResource(AnimatorMDL *animator, const NNSG3dResFileHeader *resource, u32 idx, BOOL setJoint, BOOL setMaterial)
{
    NNS_G3dRenderObjInit(&animator->renderObj, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(resource), idx));

    if (setJoint)
    {
        animator->renderObj.recJntAnm = animator->jntAnimResult = NNS_G3dAllocRecBufferJnt(&heapSystemAllocator, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(resource), idx));
    }

    if (setMaterial)
    {
        animator->renderObj.recMatAnm = animator->matAnimResult = NNS_G3dAllocRecBufferMat(&heapSystemAllocator, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(resource), idx));
    }
}

void AnimatorMDL__SetAnimation(AnimatorMDL *animator, B3DAnimationTypes type, const NNSG3dResFileHeader *resource, u32 animID, const NNSG3dResTex *texResource)
{
    if (animator->prevAnimObj[type] != NULL)
    {
        NNS_G3dRenderObjRemoveAnmObj(&animator->renderObj, animator->prevAnimObj[type]);
        NNS_G3dFreeAnmObj(&heapSystemAllocator, animator->prevAnimObj[type]);
        animator->prevAnimObj[type] = NULL;
    }

    switch (type)
    {
        case B3D_ANIM_JOINT_ANIM:
        case B3D_ANIM_MAT_ANIM:
        case B3D_ANIM_TEX_ANIM:
        case B3D_ANIM_VIS_ANIM:
            if ((animator->animFlags[type] & ANIMATORMDL_FLAG_BLEND_ANIMATIONS) != 0)
            {
                animator->animFlags[type] &= ~ANIMATORMDL_FLAG_BLENDING_PAUSED;
                animator->prevAnimObj[type]    = animator->currentAnimObj[type];
                animator->currentAnimObj[type] = NULL;
                break;
            }
            // fallthrough

        case B3D_ANIM_PAT_ANIM:
            if (animator->currentAnimObj[type] != NULL)
            {
                NNS_G3dRenderObjRemoveAnmObj(&animator->renderObj, animator->currentAnimObj[type]);
                NNS_G3dFreeAnmObj(&heapSystemAllocator, animator->currentAnimObj[type]);
                animator->currentAnimObj[type] = NULL;
            }
            break;

        default:
            break;
    }

    void *anim                     = NNS_G3dGetAnmByIdx(resource, animID);
    animator->currentAnimObj[type] = NNS_G3dAllocAnmObj(&heapSystemAllocator, anim, animator->renderObj.resMdl);
    NNS_G3dAnmObjInit(animator->currentAnimObj[type], anim, animator->renderObj.resMdl, texResource);
    NNS_G3dRenderObjAddAnmObj(&animator->renderObj, animator->currentAnimObj[type]);

    if (animator->prevAnimObj[type] != NULL)
    {
        NNS_G3dAnmObjSetBlendRatio(animator->currentAnimObj[type], FLOAT_TO_FX32(0.0));
        NNS_G3dAnmObjSetBlendRatio(animator->prevAnimObj[type], FLOAT_TO_FX32(1.0));
    }
    animator->animFlags[type] &= ~(ANIMATORMDL_FLAG_FINISHED | ANIMATORMDL_FLAG_STOPPED);
}

void AnimatorMDL__ProcessAnimation(AnimatorMDL *animator)
{
    for (u32 t = 0; t < B3D_ANIM_MAX; t++)
    {
        animator->animFlags[t] &= ~ANIMATORMDL_FLAG_FINISHED;

        if ((animator->animFlags[t] & ANIMATORMDL_FLAG_BLEND_ANIMATIONS) != 0 && animator->prevAnimObj[t] != NULL)
        {
            if ((animator->animFlags[t] & ANIMATORMDL_FLAG_BLENDING_PAUSED) == 0)
            {
                fx32 advance = MultiplyFX(animator->ratioMultiplier, animator->ratio[t]);
                animator->currentAnimObj[t]->ratio += advance;
                animator->prevAnimObj[t]->ratio -= advance;
            }

            if (animator->prevAnimObj[t]->ratio <= 0)
            {
                animator->currentAnimObj[t]->ratio = FLOAT_TO_FX32(1.0);

                animator->animFlags[t] &= ~ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
                animator->animFlags[t] |= ANIMATORMDL_FLAG_BLENDING_PAUSED;
                NNS_G3dRenderObjRemoveAnmObj(&animator->renderObj, animator->prevAnimObj[t]);
                NNS_G3dFreeAnmObj(&heapSystemAllocator, animator->prevAnimObj[t]);
                animator->prevAnimObj[t] = NULL;
            }
        }

        if (animator->currentAnimObj[t] != NULL)
        {
            fx32 numFrame = NNS_G3dAnmObjGetNumFrame(animator->currentAnimObj[t]);

            fx32 advance;
            if ((animator->animFlags[t] & ANIMATORMDL_FLAG_STOPPED) == 0)
            {
                advance = MultiplyFX(animator->speedMultiplier, animator->speed[t]);
                animator->currentAnimObj[t]->frame += advance;
            }

            if (advance > 0)
            {
                if (animator->currentAnimObj[t]->frame >= numFrame)
                {
                    animator->animFlags[t] |= ANIMATORMDL_FLAG_FINISHED;

                    if ((animator->animFlags[t] & ANIMATORMDL_FLAG_CAN_LOOP) != 0)
                        animator->currentAnimObj[t]->frame -= numFrame;
                    else
                        NNS_G3dAnmObjSetFrame(animator->currentAnimObj[t], numFrame - 1);
                }
            }
            else if (advance < 0)
            {
                if (animator->currentAnimObj[t]->frame < 0)
                {
                    animator->animFlags[t] |= ANIMATORMDL_FLAG_FINISHED;

                    if ((animator->animFlags[t] & ANIMATORMDL_FLAG_CAN_LOOP) != 0)
                        animator->currentAnimObj[t]->frame += numFrame;
                    else
                        NNS_G3dAnmObjSetFrame(animator->currentAnimObj[t], 0);
                }
            }
        }
    }

    if (animator->jntAnimResult != NULL || animator->matAnimResult != NULL)
    {
        NNS_G3dRenderObjSetFlag(&animator->renderObj, NNS_G3D_RENDEROBJ_FLAG_RECORD);
        NNS_G3dRenderObjSetFlag(&animator->renderObj, NNS_G3D_RENDEROBJ_FLAG_NOGECMD);
        NNS_G3dDraw(&animator->renderObj);
        NNS_G3dRenderObjResetFlag(&animator->renderObj, NNS_G3D_RENDEROBJ_FLAG_NOGECMD);
        NNS_G3dRenderObjResetFlag(&animator->renderObj, NNS_G3D_RENDEROBJ_FLAG_RECORD);
    }
}

void AnimatorMDL__Draw(AnimatorMDL *animator)
{
    if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
    {
        Animator3D__HandleMatrixOperations(&animator->work, animator->work.flags);
        NNS_G3dDraw(&animator->renderObj);
    }
}

// AnimatorShape3D
void AnimatorShape3D__Init(AnimatorShape3D *animator, AnimatorFlags flags)
{
    MI_CpuClear32(animator, sizeof(AnimatorShape3D));

    animator->work.type           = ANIMATOR3D_SHAPE;
    animator->work.flags          = flags;
    animator->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_P;
    animator->work.scale.z        = FX_ONE;
    animator->work.scale.y        = FX_ONE;
    animator->work.scale.x        = FX_ONE;

    MTX_Identity33(&animator->work.rotation);
    MTX_Identity43(&animator->work.matrix43);

    animator->sendMat = TRUE;
}

void AnimatorShape3D__SetResource(AnimatorShape3D *animator, NNSG3dResFileHeader *resource, u32 idx, u32 matID, u32 shpID)
{
    animator->pResMdl = NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(resource), idx);
    animator->matID   = matID;
    animator->shpID   = shpID;
}

void AnimatorShape3D__Release(AnimatorShape3D *animator)
{
    // Nothing to release!
}

void AnimatorShape3D__ProcessAnimation(AnimatorShape3D *animator)
{
    // Nothing to process?
}

void AnimatorShape3D__Draw(AnimatorShape3D *animator)
{
    if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
    {
        Animator3D__HandleMatrixOperations(&animator->work, animator->work.flags);
        NNS_G3dDraw1Mat1Shp(animator->pResMdl, animator->matID, animator->shpID, animator->sendMat);
    }
}

// AnimatorSprite3D
void AnimatorSprite3D__Init(AnimatorSprite3D *animator, u32 flags3D, void *fileData, u16 animID, AnimatorFlags flags, VRAMPixelKey vramPixels, VRAMPaletteKey vramPalette)
{
    MI_CpuClear32(animator, sizeof(AnimatorSprite3D));

    animator->work.type           = ANIMATOR3D_SPRITE;
    animator->work.flags          = flags3D;
    animator->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_P;
    animator->work.scale.z        = FX_ONE;
    animator->work.scale.y        = FX_ONE;
    animator->work.scale.x        = FX_ONE;

    MTX_Identity33(&animator->work.rotation);
    MTX_Identity43(&animator->work.matrix43);

    AnimatorSprite__Init(&animator->animatorSprite, fileData, animID, flags, 0, PIXEL_MODE_TEXTURE, vramPixels, PALETTE_MODE_TEXTURE, vramPalette, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);

    // set alpha to 0x1F (opaque), set polygon mode (PM) to "MODULATE", set front (FR) & back (BK) faces to not be culled
    animator->polygonAttr =
        ((animator->polygonAttr & ~REG_G3_POLYGON_ATTR_PM_MASK) | (GX_POLYGONMODE_MODULATE << REG_G3_POLYGON_ATTR_PM_SHIFT) | (GX_CULL_NONE << REG_G3_POLYGON_ATTR_BK_SHIFT))
            & ~(GX_COLOR_FROM_888(0xFF) << REG_G3_POLYGON_ATTR_ALPHA_SHIFT)
        | (GX_COLOR_FROM_888(0xFF) << REG_G3_POLYGON_ATTR_ALPHA_SHIFT);

    animator->field_F8 = (animator->field_F8 & ~0x7FFF) | 0x7FFF;
    animator->field_F8 |= 0x8000;

    animator->field_FC = (animator->field_FC & ~0x7FFF) | 0x7FFF;

    animator->color = GX_RGB_888(0xFF, 0xFF, 0xFF);
}

void AnimatorSprite3D__Release(AnimatorSprite3D *animator)
{
    if (animator->animatorSprite.vramPixels != NULL)
    {
        VRAMSystem__FreeTexture(animator->animatorSprite.vramPixels);
        animator->animatorSprite.vramPixels = NULL;
    }

    if (animator->animatorSprite.vramPalette != NULL)
    {
        VRAMSystem__FreePalette(animator->animatorSprite.vramPalette);
        animator->animatorSprite.vramPalette = NULL;
    }
}

void AnimatorSprite3D__ProcessAnimation(AnimatorSprite3D *animator, SpriteFrameCallback callback, void *userData)
{
    AnimatorSprite__ProcessAnimation(&animator->animatorSprite, callback, userData);
}

inline VRAMPaletteKey inline_fn(AnimatorSprite3D *arg0)
{
    return arg0->animatorSprite.vramPalette;
}

NONMATCH_FUNC void AnimatorSprite3D__Draw(AnimatorSprite3D *animator)
{
    // https://decomp.me/scratch/VmSWU -> 98.94%
#ifdef NON_MATCHING
    struct BACFrame *frame;
    GXOamAttr *sprite;
    u32 tileDataPos;
    u32 pixelAddr;
    u16 s;

    if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW) != 0)
        return;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_DISABLE_DRAW) != 0)
        return;

    Animator3D__HandleMatrixOperations(&animator->work, animator->animatorSprite.flags);

    int format   = GetAnimHeaderBlockFromAnimator(&animator->animatorSprite)->anims[animator->animatorSprite.animID].format;
    frame        = GetFrameAssemblyFromAnimator(&animator->animatorSprite);
    u16 oamFlags = 0;

    if (!Sprite__Is3DFormat(&animator->animatorSprite))
        return;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_DISABLE_DRAW) != 0)
        return;

    if (frame->spriteCount == 0)
        return;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_FLIP_X) != 0)
        oamFlags |= 0x1000;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_FLIP_Y) != 0)
        oamFlags |= 0x2000;

    sprite      = frame->spriteList;
    tileDataPos = VRAMKEY_TO_KEY(animator->animatorSprite.vramPixels) & 0x7FFFF;

    MtxFx43 matTranslate;
    MtxFx43 matTexture;
    MTX_Identity43(&matTranslate);
    MTX_Identity43(&matTexture);

    // direct buffer because we use 'animator->polygonAttr' instead of function params
    NNS_G3dGeBufferOP_N(G3OP_POLYGON_ATTR, &animator->polygonAttr, G3OP_POLYGON_ATTR_NPARAMS);
    NNS_G3dGeColor(animator->color);

    u32 paletteAddr = (VRAMKEY_TO_KEY(inline_fn(animator)) & 0x1FFFF) + (animator->animatorSprite.cParam.palette * (16 * sizeof(GXRgb)));
    NNS_G3dGeTexPlttBase(paletteAddr, Sprite__Tex3DFormatForBACFormat[format]);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);

    VecFx32 scale;
    scale.x = FLOAT_TO_FX32(1.0);
    scale.y = -FLOAT_TO_FX32(1.0);
    scale.z = FLOAT_TO_FX32(1.0);
    NNS_G3dGeScaleVec(&scale);

    NNS_G3dGeBegin(GX_BEGIN_QUADS);
    for (s = 0; s < frame->spriteCount; s++, sprite++)
    {
        u32 shape           = ((sprite->attr0 & 0xC000) >> 12) | ((sprite->attr1 & 0xC000) >> 14);
        const Vec2U16 *size = &spriteShapeSizes2D[shape];

        if (oamFlags & 0x1000)
        {
            s32 x       = frame->hotspot.x;
            s32 spriteX = (u16)(sprite->attr1 << 6) << 16 >> 22;
            x           = size->x;
            x           = (frame->hotspot.x - spriteX) - x;

            matTranslate.m[3][0] = FX32_FROM_WHOLE(x);
        }
        else
        {
            s32 x = frame->hotspot.x;
            x     = ((u16)(sprite->attr1 << 6) << 16 >> 22) - x;

            matTranslate.m[3][0] = FX32_FROM_WHOLE(x);
        }

        if (oamFlags & 0x2000)
        {
            matTranslate.m[3][1] = FX32_FROM_WHOLE(frame->hotspot.y - ((u16)(sprite->attr0 << 7) << 16 >> 23) - size->y);
        }
        else
        {
            matTranslate.m[3][1] = FX32_FROM_WHOLE(-frame->hotspot.y + ((u16)(sprite->attr0 << 7) << 16 >> 23));
        }

        if (oamFlags & 0x1000)
        {
            matTexture.m[3][0] = FX32_FROM_WHOLE((size->x - 1) << 4);
            matTexture.m[0][0] = FX32_FROM_WHOLE(-size->x);
        }
        else
        {
            matTexture.m[3][0] = 0;
            matTexture.m[0][0] = FX32_FROM_WHOLE(size->x);
        }

        if (oamFlags & 0x2000)
        {
            matTexture.m[3][1] = (FX32_FROM_WHOLE(size->y - 1) << 4);
            matTexture.m[1][1] = FX32_FROM_WHOLE(-size->y);
        }
        else
        {
            matTexture.m[3][1] = 0;
            matTexture.m[1][1] = FX32_FROM_WHOLE(size->y);
        }

        matTranslate.m[0][0] = FX32_FROM_WHOLE(size->x);
        matTranslate.m[1][1] = FX32_FROM_WHOLE(size->y);

        if ((frame->useGFXIndex & 1) == 0)
        {
            pixelAddr = tileDataPos;
            tileDataPos += Sprite__ShapeTileCount[shape] << pixelFormatShift[format];
        }
        else
        {
            pixelAddr = tileDataPos + ((sprite->attr2 & 0x3FF) << pixelFormatShift[format]);
        }

        NNS_G3dGeTexImageParam(Sprite__Tex3DFormatForBACFormat[format], GX_TEXGEN_TEXCOORD, (GXTexSizeS)spriteShapeSizes3D[2 * shape],
                               (GXTexSizeT)spriteShapeSizes3D[(2 * shape) + 1], GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS, pixelAddr);

        NNS_G3dGeMtxMode(GX_MTXMODE_TEXTURE);
        NNS_G3dGeLoadMtx43(&matTexture);

        NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
        NNS_G3dGePushMtx();
        NNS_G3dGeMultMtx43(&matTranslate);
        NNS_G3dGeSendDL(drawListSprite3D, sizeof(drawListSprite3D));
        NNS_G3dGePopMtx(1);
    }
    NNS_G3dGeEnd();
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x8c
	mov r7, r0
	ldr r1, [r7, #4]
	tst r1, #1
	addne sp, sp, #0x8c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r7, #0xcc]
	tst r1, #1
	addne sp, sp, #0x8c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl Animator3D__HandleMatrixOperations
	ldrh r0, [r7, #0x9c]
	ldr r1, [r7, #0xa8]
	ldr r3, [r7, #0xac]
	add r1, r1, r0, lsl #3
	ldr r2, [r7, #0xbc]
	ldrh r10, [r1, #8]
	add r0, r7, #0x90
	add r4, r3, r2
	mov r9, #0
	bl Sprite__Is3DFormat
	cmp r0, #0
	addeq sp, sp, #0x8c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r7, #0xcc]
	tst r1, #1
	addne sp, sp, #0x8c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r4, #0]
	cmp r0, #0
	addeq sp, sp, #0x8c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r1, #0x80
	orrne r0, r9, #0x1000
	movne r0, r0, lsl #0x10
	movne r9, r0, lsr #0x10
	tst r1, #0x100
	orrne r0, r9, #0x2000
	movne r0, r0, lsl #0x10
	movne r9, r0, lsr #0x10
	ldr r2, [r7, #0xd4]
	ldr r1, =0x0007FFFF
	add r0, sp, #0x5c
	add r5, r4, #0x10
	and r6, r2, r1
	bl MTX_Identity43_
	add r0, sp, #0x2c
	bl MTX_Identity43_
	add r1, r7, #0xf4
	mov r0, #0x29
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r7, #0x100
	ldrh r2, [r0, #0]
	mov r0, #0x20
	add r1, sp, #0x1c
	str r2, [sp, #0x1c]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r0, =Sprite__Tex3DFormatForBACFormat
	ldrh r3, [r7, #0xe0]
	ldr r11, [r0, r10, lsl #2]
	ldr r2, [r7, #0xdc]
	ldr r0, =0x0001FFFF
	cmp r11, #2
	and r0, r2, r0
	moveq r1, #1
	movne r1, #0
	rsb r1, r1, #4
	add r0, r0, r3, lsl #5
	mov r3, r0, lsr r1
	add r1, sp, #0x18
	mov r0, #0x2b
	mov r2, #1
	str r3, [sp, #0x18]
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	add r1, sp, #0x14
	mov r0, #0x10
	str r2, [sp, #0x14]
	bl NNS_G3dGeBufferOP_N
	mov r2, #0x1000
	sub r0, r2, #0x2000
	str r0, [sp, #0x24]
	add r1, sp, #0x20
	str r2, [sp, #0x20]
	str r2, [sp, #0x28]
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	str r2, [sp, #0x10]
	mov r0, #0x40
	add r1, sp, #0x10
	bl NNS_G3dGeBufferOP_N
	ldrh r0, [r4, #0]
	mov r7, #0
	cmp r0, #0
	bls _020833CC
	and r8, r9, #0x1000
	and r9, r9, #0x2000
_0208315C:
	ldrh r1, [r5, #2]
	ldrh r2, [r5, #0]
	cmp r8, #0
	and r0, r1, #0xc000
	and r2, r2, #0xc000
	mov r0, r0, asr #0xe
	orr r0, r0, r2, asr #12
	ldr r2, =spriteShapeSizes2D
	mov r1, r1, lsl #0x16
	add r2, r2, r0, lsl #2
	mov r1, r1, lsr #0x10
	beq _020831AC
	ldrsh ip, [r4, #0xc]
	ldrh r3, [r2, #0]
	mov r1, r1, lsl #0x10
	sub r1, ip, r1, asr #22
	sub r1, r1, r3
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x80]
	b _020831C0
_020831AC:
	ldrsh r3, [r4, #0xc]
	mov r1, r1, lsl #0x10
	rsb r1, r3, r1, asr #22
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x80]
_020831C0:
	cmp r9, #0
	beq _020831F4
	ldrsh r1, [r4, #0xe]
	ldrh r3, [r5, #0]
	ldrh ip, [r2, #2]
	mov r3, r3, lsl #0x17
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	sub r1, r1, r3, asr #23
	sub r1, r1, ip
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x84]
	b _02083214
_020831F4:
	ldrh r1, [r5, #0]
	ldrsh r3, [r4, #0xe]
	mov r1, r1, lsl #0x17
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	rsb r1, r3, r1, asr #23
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x84]
_02083214:
	cmp r8, #0
	beq _0208323C
	ldrh r1, [r2, #0]
	sub r3, r1, #1
	mov r3, r3, lsl #0x10
	str r3, [sp, #0x50]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x2c]
	b _02083250
_0208323C:
	mov r1, #0
	str r1, [sp, #0x50]
	ldrh r1, [r2, #0]
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x2c]
_02083250:
	cmp r9, #0
	beq _02083278
	ldrh r1, [r2, #2]
	sub r3, r1, #1
	mov r3, r3, lsl #0x10
	str r3, [sp, #0x54]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x3c]
	b _0208328C
_02083278:
	mov r1, #0
	str r1, [sp, #0x54]
	ldrh r1, [r2, #2]
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x3c]
_0208328C:
	ldrh r3, [r2, #0]
	ldrh r1, [r2, #2]
	mov r2, r3, lsl #0xc
	str r2, [sp, #0x5c]
	mov r1, r1, lsl #0xc
	str r1, [sp, #0x6c]
	ldrh r1, [r4, #2]
	tst r1, #1
	bne _020832D0
	ldr r2, =Sprite__ShapeTileCount
	mov r3, r0, lsl #1
	ldrh r3, [r2, r3]
	ldr r2, =pixelFormatShift
	mov r1, r6
	ldrb r2, [r2, r10]
	add r6, r6, r3, lsl r2
	b _020832E8
_020832D0:
	ldr r1, =pixelFormatShift
	ldrh r3, [r5, #4]
	ldrb r2, [r1, r10]
	ldr r1, =0x000003FF
	and r1, r3, r1
	add r1, r6, r1, lsl r2
_020832E8:
	mov r1, r1, lsr #3
	orr r1, r1, r11, lsl #26
	orr r2, r1, #0x40000000
	ldr r3, =spriteShapeSizes3D
	mov r1, r0, lsl #2
	add r0, r3, r0, lsl #2
	ldrh r3, [r0, #2]
	ldr r0, =spriteShapeSizes3D
	ldrh ip, [r0, r1]
	mov r0, #0x2a
	add r1, sp, #0xc
	orr r2, r2, ip, lsl #20
	orr r2, r2, r3, lsl #23
	orr r2, r2, #0x20000000
	str r2, [sp, #0xc]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #3
	str r0, [sp, #8]
	mov r0, #0x10
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x17
	add r1, sp, #0x2c
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r0, #1
	str r0, [sp, #4]
	mov r0, #0x10
	add r1, sp, #4
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x19
	add r1, sp, #0x5c
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	ldr r0, =drawListSprite3D
	mov r1, #0x28
	bl NNS_G3dGeSendDL
	mov r0, #1
	str r0, [sp]
	mov r0, #0x12
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0]
	mov r7, r0, lsr #0x10
	add r5, r5, #8
	cmp r1, r0, lsr #16
	bhi _0208315C
_020833CC:
	mov r1, #0
	mov r2, r1
	mov r0, #0x41
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x8c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

// BAC
BACAnimFormat Sprite__GetFormatFromAnim(void *filePtr, u16 animID)
{
    return GetAnimHeaderBlock(filePtr)->anims[animID].format;
}

u16 Sprite__GetSpriteSize1FromAnim(void *filePtr, u16 animID)
{
    return GetInfoBlock(filePtr)->anims[animID].spriteSize_1D_32K;
}

u16 Sprite__GetSpriteSize1(void *filePtr)
{
    return GetInfoBlock(filePtr)->spriteSize_1D_32K;
}

u16 Sprite__GetSpriteSize2FromAnim(void *filePtr, u16 animID)
{
    return GetInfoBlock(filePtr)->anims[animID].spriteSize_1D_64K;
}

u16 Sprite__GetSpriteSize2(void *filePtr)
{
    return GetInfoBlock(filePtr)->spriteSize_1D_64K;
}

u16 Sprite__GetSpriteSize3FromAnim(void *filePtr, u16 animID)
{
    return GetInfoBlock(filePtr)->anims[animID].spriteSize_1D_128K;
}

u16 Sprite__GetSpriteSize3(void *filePtr)
{
    return GetInfoBlock(filePtr)->spriteSize_1D_128K;
}

u16 Sprite__GetSpriteSize4FromAnim(void *filePtr, u16 animID)
{
    return GetInfoBlock(filePtr)->anims[animID].spriteSize_1D_256K;
}

u16 Sprite__GetSpriteSize4(void *filePtr)
{
    return GetInfoBlock(filePtr)->spriteSize_1D_256K;
}

u16 Sprite__GetSpriteCountForFrame(void *filePtr)
{
    return GetInfoBlock(filePtr)->spriteCount;
}

u16 Sprite__GetPaletteSizeFromAnim(void *filePtr, u16 animID)
{
    return GetInfoBlock(filePtr)->anims[animID].palette3DSize;
}

u16 Sprite__GetPaletteSize(void *filePtr)
{
    return GetInfoBlock(filePtr)->palette3DSize;
}

u32 Sprite__GetTextureSizeFromAnim(void *filePtr, u16 animID)
{
    return GetInfoBlock(filePtr)->anims[animID].texture3DSize;
}

u32 Sprite__GetTextureSize(void *filePtr)
{
    return GetInfoBlock(filePtr)->texture3DSize;
}

BOOL Sprite__Is3DFormat(AnimatorSprite *animator)
{
    switch (GetAnimHeaderBlockFromAnimator(animator)->anims[animator->animID].format)
    {
        case BAC_FORMAT_INDEXED2_3D:
        case BAC_FORMAT_INDEXED4_3D:
        case BAC_FORMAT_INDEXED8_3D:
        case BAC_FORMAT_RGBA_3D:
        case BAC_FORMAT_A3I5_TRANSLUCENT_3D:
        case BAC_FORMAT_A5I3_TRANSLUCENT_3D:
        case BAC_FORMAT_BLOCK_COMPRESSED_3D:
            return TRUE;

        default:
            return FALSE;
    }
}

// Animation Helpers
static inline BOOL AnimatorCantLoop(AnimatorSprite *animator)
{
    animator->flags |= ANIMATOR_FLAG_DID_FINISH;
    return (animator->flags & ANIMATOR_FLAG_DISABLE_LOOPING) != 0;
}

BOOL Sprite__Animate(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    if (animator->frameRemainder > 0)
    {
        animator->frameRemainder = animator->frameRemainder - animator->animAdvance;
        animator->frameTimer += animator->animAdvance;

        if (animator->frameRemainder > 0)
            return FALSE;

        if ((animator->flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) == 0)
            animator->frameTimer += animator->frameRemainder;

        if (animator->animFrameIndex == animator->animFrameCount && AnimatorCantLoop(animator) == FALSE)
        {
            animator->flags |= ANIMATOR_FLAG_DID_LOOP;
            return FALSE;
        }
    }

    animator->prevAnimSequenceOffset = animator->animSequenceOffset;
    while ((frameGroupFuncList[GetAnimSequenceBlockFromAnimator(animator)->blockID])(GetAnimSequenceBlockFromAnimator(animator), animator, callback, userData) != FRAME_BREAK)
    {
        // looping...
    }

    return TRUE;
}

BOOL Sprite__AnimateDS(AnimatorSpriteDS *animator, SpriteFrameCallback callback, void *userData)
{
    if (animator->work.frameRemainder > 0)
    {
        animator->work.frameRemainder = animator->work.frameRemainder - animator->work.animAdvance;
        animator->work.frameTimer += animator->work.animAdvance;

        if (animator->work.frameRemainder > 0)
            return FALSE;

        if ((animator->work.flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) == 0)
            animator->work.frameTimer += animator->work.frameRemainder;

        if (animator->work.animFrameIndex == animator->work.animFrameCount && AnimatorCantLoop(&animator->work) == FALSE)
        {
            animator->work.flags |= ANIMATOR_FLAG_DID_LOOP;
            return FALSE;
        }
    }

    animator->work.prevAnimSequenceOffset = animator->work.animSequenceOffset;

    AnimatorSprite tempAnim;
    AnimatorSprite *tempAnimPtr = &tempAnim;
    MI_CpuCopy16(animator, tempAnimPtr, sizeof(tempAnim));

    AnimatorSprite *curAnimator = &animator->work;
    for (u32 i = 0; i < 2; i++)
    {
        if ((animator->screensToDraw & (1 << i)) == 0)
        {
            curAnimator->useEngineB     = i;
            curAnimator->pixelMode      = animator->pixelMode[i];
            curAnimator->vramPixels     = animator->vramPixels[i];
            curAnimator->paletteMode    = animator->paletteMode[i];
            curAnimator->vramPalette    = animator->vramPalette[i];
            curAnimator->cParam.palette = animator->cParam[i].palette;

            while ((frameGroupFuncList[GetAnimSequenceBlockFromAnimator(curAnimator)->blockID])(GetAnimSequenceBlockFromAnimator(curAnimator), curAnimator, callback, userData)
                   != FRAME_BREAK)
            {
                // looping...
            }

            callback    = NULL;
            userData    = NULL;
            curAnimator = tempAnimPtr;
        }
    }

    return TRUE;
}

void Sprite__AnimateManual(AnimatorSprite *animator, fx32 advance, SpriteFrameCallback callback, void *userData)
{
    AnimatorFlags prevFlags = animator->flags;
    animator->flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    while (advance > 0)
    {
        animator->flags &= ~ANIMATOR_FLAG_DID_FINISH;

        s32 remain = animator->frameRemainder;
        if (remain <= advance)
        {
            animator->frameTimer += remain;
            animator->frameRemainder = 0;
            advance -= remain;
        }
        else
        {
            animator->frameRemainder = remain - advance;
            animator->frameTimer += advance;
        }

        if (animator->frameRemainder > 0)
            break;

        animator->prevAnimSequenceOffset = animator->animSequenceOffset;
        while ((frameGroupFuncList[GetAnimSequenceBlockFromAnimator(animator)->blockID])(GetAnimSequenceBlockFromAnimator(animator), animator, callback, userData) != FRAME_BREAK)
        {
            // looping...
        }

        if ((animator->flags & ANIMATOR_FLAG_DID_FINISH) != 0 && (animator->flags & ANIMATOR_FLAG_DISABLE_LOOPING) == 0)
        {
            animator->flags |= ANIMATOR_FLAG_DID_LOOP;
            break;
        }
    }

    animator->flags &= ~(ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS);
    animator->flags |= prevFlags & (ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS);
}

// BAC Callbacks
s32 BAC_FrameGroupFunc_EndFrame(BACFrameGroupBlock_EndFrame *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    animator->animFrameCount = block->animFrameCount;
    animator->animFrameIndex = block->frameIndex;

    if ((animator->flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) != 0)
        animator->frameRemainder = animator->frameRemainder + FX32_FROM_WHOLE(block->duration);
    else
        animator->frameRemainder = FX32_FROM_WHOLE(block->duration);

    animator->animSequenceOffset += block->header.blockSize;
    return FRAME_BREAK;
}

s32 BAC_FrameGroupFunc_FrameAssembly(BACFrameGroupBlock_FrameAssembly *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    u32 assemblyOffset       = block->assemblyOffset;
    animator->assemblyOffset = assemblyOffset;

    if ((GetFrameAssemblyFromAnimator(animator)->useGFXIndex & 1) != 0)
        animator->flags |= ANIMATOR_FLAG_USE_GFX_INDEX;
    else
        animator->flags &= ~ANIMATOR_FLAG_USE_GFX_INDEX;

    animator->animSequenceOffset += block->header.blockSize;
    return FRAME_CONTINUE;
}

NONMATCH_FUNC s32 BAC_FrameGroupFunc_SpriteParts(BACFrameGroupBlock_SpriteParts *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    // https://decomp.me/scratch/Xytta -> 99.19%
    // register mismatch near GetSpritePixelsBlock()
#ifdef NON_MATCHING
    typedef void (*PixelsFunc)(void *pixels, PixelMode mode, void *vramPixels);

    struct BACFrameSpritePart *part;
    s32 offsetThing;
    u16 pos;

    if ((animator->flags & ANIMATOR_FLAG_DISABLE_SPRITE_PARTS) == 0)
    {
        VRAMPixelKey pixelPos;
        PixelsFunc pixelsFunc = ((animator->flags & ANIMATOR_FLAG_UNCOMPRESSED_PIXELS) != 0) ? LoadCompressedPixels : QueueCompressedPixels;

        part     = (struct BACFrameSpritePart *)((u8 *)block + sizeof(BACFrameGroupBlockHeader));
        pixelPos = animator->vramPixels;
        pos      = sizeof(BACFrameGroupBlockHeader);

        switch (animator->pixelMode)
        {
            case PIXEL_MODE_SPRITE:
                if ((GetFrameAssemblyFromAnimator(animator)->spriteList[0].attr0 & GX_OAM_ATTR01_MODE_MASK) == (GX_OAM_MODE_BITMAPOBJ << GX_OAM_ATTR01_MODE_SHIFT))
                    offsetThing = objBmpUse256K[animator->useEngineB]; // bitmap
                else
                    offsetThing = objBankShift[animator->useEngineB]; // non-bitmap
                break;

            default:
                offsetThing = 0;
                break;
        }

        u32 tileSizeShift = offsetThing + pixelFormatShift[GetAnimHeaderBlockFromAnimator(animator)->anims[animator->animID].format];

        for (; pos < block->header.blockSize; pos += sizeof(struct BACFrameSpritePart))
        {
            pixelsFunc(GetSpritePixelsBlock(animator->fileData, part->dataOffset), animator->pixelMode, pixelPos);

            pixelPos += (((((u32)part->tileCount) + (1 << offsetThing)) - 1) >> offsetThing) << (tileSizeShift & 0xFFFFFFFFFFFFFFFF);
            part++;
        }
    }

    animator->animSequenceOffset += block->header.blockSize;
    return FRAME_CONTINUE;
#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r9, r1
	ldr r1, [r9, #0x3c]
	mov r10, r0
	tst r1, #8
	bne _02083A1C
	tst r1, #0x20
	ldrne r8, =LoadCompressedPixels
	ldr r0, [r9, #0x40]
	ldreq r8, =QueueCompressedPixels
	add r4, r10, #4
	cmp r0, #0
	ldr r7, [r9, #0x44]
	mov r6, #4
	bne _0208399C
	ldr r1, [r9, #0x1c]
	ldr r0, [r9, #0x2c]
	add r0, r1, r0
	ldrh r0, [r0, #0x10]
	ldr r1, [r9, #4]
	and r0, r0, #0xc00
	cmp r0, #0xc00
	bne _0208398C
	ldr r0, =objBmpUse256K
	mov r1, r1, lsl #1
	ldrh r5, [r0, r1]
	b _020839A0
_0208398C:
	ldr r0, =objBankShift
	mov r1, r1, lsl #1
	ldrh r5, [r0, r1]
	b _020839A0
_0208399C:
	mov r5, #0
_020839A0:
	ldrh r1, [r9, #0xc]
	ldr r2, [r9, #0x18]
	ldrh r0, [r10, #2]
	add r1, r2, r1, lsl #3
	ldrh r2, [r1, #8]
	ldr r1, =pixelFormatShift
	cmp r0, #4
	ldrb r0, [r1, r2]
	bls _02083A1C
	add r11, r5, r0
_020839C8:
	ldr r2, [r9, #0x14]
	ldr r3, [r4, #0]
	ldr r0, [r2, #0x14]
	ldr r1, [r9, #0x40]
	add r0, r2, r0
	mov r2, r7
	add r0, r3, r0
	blx r8
	ldrh r3, [r4, #4]
	add r0, r6, #8
	mov r1, r0, lsl #0x10
	mov r0, #1
	add r0, r3, r0, lsl r5
	ldrh r2, [r10, #2]
	sub r0, r0, #1
	mov r0, r0, lsr r5
	cmp r2, r1, lsr #16
	add r7, r7, r0, lsl r11
	add r4, r4, #8
	mov r6, r1, lsr #0x10
	bhi _020839C8
_02083A1C:
	ldrh r1, [r10, #2]
	ldr r2, [r9, #0x24]
	mov r0, #FRAME_CONTINUE
	add r1, r2, r1
	str r1, [r9, #0x24]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

NONMATCH_FUNC s32 BAC_FrameGroupFunc_Palette(BACFrameGroupBlock_Palette *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    // https://decomp.me/scratch/hlf1C -> 99.50%
    // register mismatch near GetPaletteBlock()
#ifdef NON_MATCHING
    typedef void (*PaletteFunc)(void *srcPalettePtr, u16 colorCount, PaletteMode mode, size_t dstPalettePtr);

    u8 *paletteData;
    size_t aniPaletteOffset;
    AnimatorFlags *aniFlags;

    aniFlags = &animator->flags;
    if ((animator->flags & ANIMATOR_FLAG_DISABLE_PALETTES) == 0)
    {
        PaletteFunc paletteFunc;
        aniPaletteOffset     = animator->paletteOffset;
        struct BACFile *file = ((struct BACFile *)animator->fileData);
        paletteData          = animator->fileData + file->paletteOffset + block->paletteOffset;
        if (((*aniFlags) & ANIMATOR_FLAG_UNCOMPRESSED_PALETTES) != 0)
            paletteFunc = LoadUncompressedPalette;
        else
            paletteFunc = QueueUncompressedPalette;

        u16 *srcPalettePtr = &((struct BACPaletteBlock *)paletteData)->colors[aniPaletteOffset];

        u16 colorCount = animator->colorCount;
        u16 *destPalettePtr;
        switch (animator->paletteMode)
        {
            case PALETTE_MODE_SPRITE:
                destPalettePtr = &((u16 *)animator->vramPalette)[16 * block->colorCount + 16 * animator->cParam.palette];
                break;

            case PALETTE_MODE_OBJ:
            case PALETTE_MODE_SUB_OBJ:
                destPalettePtr = &((u16 *)animator->vramPalette)[256 * (block->colorCount + animator->cParam.palette)];
                break;

            default:
                destPalettePtr = &((u16 *)animator->vramPalette)[16 * block->colorCount];
                break;
        }

        if (colorCount == 0)
            colorCount = BAC__FormatColorCounts[Sprite__GetFormatFromAnim(animator->fileData, animator->animID)];

        paletteFunc(srcPalettePtr, colorCount, animator->paletteMode, (size_t)destPalettePtr);
    }

    animator->animSequenceOffset += block->header.blockSize;
    return FRAME_CONTINUE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	ldr r1, [r6, #0x3c]
	mov r7, r0
	tst r1, #0x10
	bne _02083B14
	ldr r0, [r6, #0x14]
	tst r1, #0x40
	ldr r1, [r0, #0x10]
	ldr r3, [r7, #4]
	add r1, r0, r1
	add r1, r3, r1
	ldrne r5, =LoadUncompressedPalette
	ldrh r3, [r6, #0x52]
	add r1, r1, #4
	ldr r2, [r6, #0x48]
	ldreq r5, =QueueUncompressedPalette
	add r4, r1, r3, lsl #1
	cmp r2, #0
	ldrh r1, [r6, #0x54]
	beq _02083AAC
	cmp r2, #2
	cmpne r2, #4
	beq _02083AC4
	b _02083ADC
_02083AAC:
	ldrh r3, [r7, #0xa]
	ldrh r2, [r6, #0x50]
	ldr ip, [r6, #0x4c]
	add r2, r3, r2
	add r8, ip, r2, lsl #5
	b _02083AE8
_02083AC4:
	ldrh r3, [r7, #0xa]
	ldrh r2, [r6, #0x50]
	ldr ip, [r6, #0x4c]
	add r2, r3, r2
	add r8, ip, r2, lsl #9
	b _02083AE8
_02083ADC:
	ldrh r2, [r7, #0xa]
	ldr r3, [r6, #0x4c]
	add r8, r3, r2, lsl #5
_02083AE8:
	cmp r1, #0
	bne _02083B04
	ldrh r1, [r6, #0xc]
	bl Sprite__GetFormatFromAnim
	ldr r1, =BAC__FormatColorCounts
	mov r0, r0, lsl #1
	ldrh r1, [r1, r0]
_02083B04:
	ldr r2, [r6, #0x48]
	mov r0, r4
	mov r3, r8
	blx r5
_02083B14:
	ldrh r1, [r7, #2]
	ldr r2, [r6, #0x24]
	mov r0, #FRAME_CONTINUE
	add r1, r2, r1
	str r1, [r6, #0x24]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

s32 BAC_FrameGroupFunc_EndAnimation(BACFrameGroupBlock_EndAnimation *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    animator->animFrameIndex = 0;
    if ((animator->flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) != 0)
        animator->frameTimer = -animator->frameRemainder;
    else
        animator->frameTimer = 0;

    u32 loop                         = block->loopPoint;
    animator->animSequenceOffset     = loop;
    animator->prevAnimSequenceOffset = loop;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_Unused_5(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    animator->animSequenceOffset += block->blockSize;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_Callback_6(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    if (callback)
        callback(block, animator, userData);

    animator->animSequenceOffset += block->blockSize;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_Callback_7(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    if (callback)
        callback(block, animator, userData);

    animator->animSequenceOffset += block->blockSize;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_Callback_8(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    if (callback)
        callback(block, animator, userData);

    animator->animSequenceOffset += block->blockSize;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_EndAnimation_ChangeAnim(BACFrameGroupBlock_EndAnimation2 *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    animator->animFrameIndex = 0;
    if ((animator->flags & ANIMATOR_FLAG_USE_FRAME_REMAINDER) != 0)
        animator->frameTimer = -animator->frameRemainder;
    else
        animator->frameTimer = 0;

    animator->animSequenceOffset = GetAnimHeaderBlockFromAnimator(animator)->anims[block->nextAnimation].offset;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_Unused_10(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    animator->animSequenceOffset += block->blockSize;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_Unused_11(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    animator->animSequenceOffset += block->blockSize;
    return FRAME_CONTINUE;
}

// Animation3D Helpers
void Animator3D__HandleMatrixOperations(Animator3D *animator, u32 flags)
{
    NNS_G3dGlbSetBaseScale(&animator->scale);
    NNS_G3dGlbSetBaseRot(&animator->rotation);
    NNS_G3dGlbSetBaseTrans(&animator->translation);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);

    for (s32 i = 0; i < ANIMATOR3D_MATRIXOP_COUNT && animator->matrixOpIDs[i] != MATRIX_OP_NONE; i++)
    {
        animator3DMatrixFuncList[animator->matrixOpIDs[i]](animator);
    }
}

void Animator3D__MatrixOp_None(Animator3D *animator)
{
    // Nothing!
}

void Animator3D__MatrixOp_Identity(Animator3D *animator)
{
    NNS_G3dGeIdentity();
}

void Animator3D__MatrixOp_RestoreMtx(Animator3D *animator)
{
    NNS_G3dGeRestoreMtx(animator->field_8);
}

void Animator3D__MatrixOp_FlushP(Animator3D *animator)
{
    NNS_G3dGlbFlushP();
}

void Animator3D__MatrixOp_FlushVP(Animator3D *animator)
{
    NNS_G3dGlbFlushVP();
}

void Animator3D__MatrixOp_FlushWVP(Animator3D *animator)
{
    NNS_G3dGlbFlushWVP();
}

void Animator3D__MatrixOp_SetMatrixMode(Animator3D *animator)
{
    Camera3D__SetMatrixMode();
}

void Animator3D__MatrixOp_FlushP_Camera3D(Animator3D *animator)
{
    Camera3D__FlushP();
}

void Animator3D__MatrixOp_FlushVP_Camera3D(Animator3D *animator)
{
    Camera3D__FlushVP();
}

void Animator3D__MatrixOp_FlushWVP_Camera3D(Animator3D *animator)
{
    Camera3D__FlushWVP();
}

void Animator3D__MatrixOp_IdentityScale(Animator3D *animator)
{
    NNS_G3dGeIdentity();
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_CopyMtx33To43(Animator3D *animator)
{
    MtxFx43 matrix;

    MTX_Copy33To43(&animator->rotation, &matrix);
    NNS_G3dGeLoadMtx43(&matrix);
}

void Animator3D__MatrixOp_IdentityTranslate(Animator3D *animator)
{
    NNS_G3dGeIdentity();
    NNS_G3dGeTranslateVec(&animator->translation);
}

void Animator3D__MatrixOp_IdentityTranslate2(Animator3D *animator)
{
    NNS_G3dGeIdentity();
    NNS_G3dGeTranslateVec(&animator->translation2);
}

void Animator3D__MatrixOp_IdentityRotateScale(Animator3D *animator)
{
    NNS_G3dGeLoadMtx43((MtxFx43 *)&animator->rotation);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_IdentityRotateTranslate2Scale(Animator3D *animator)
{
    NNS_G3dGeLoadMtx43((MtxFx43 *)&animator->rotation);
    NNS_G3dGeTranslateVec(&animator->translation2);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_LoadMtx43(Animator3D *animator)
{
    NNS_G3dGeLoadMtx43(&animator->matrix43);
}

void Animator3D__MatrixOp_LoadCameraMtx43(Animator3D *animator)
{
    MtxFx43 matrix;
    Camera3D__CopyMatrix4x3(NNS_G3dGlbGetCameraMtx(), (MtxFx33 *)&matrix);

    matrix.m[3][0] = matrix.m[3][1] = matrix.m[3][2] = FLOAT_TO_FX32(0.0);

    NNS_G3dGeLoadMtx43(&matrix);
}

void Animator3D__MatrixOp_LoadCameraMtx33(Animator3D *animator)
{
    MtxFx43 matrix;
    Camera3D__CopyMatrix3x3(NNS_G3dGlbGetCameraMtx(), (MtxFx33 *)&matrix);

    matrix.m[3][0] = matrix.m[3][1] = matrix.m[3][2] = FLOAT_TO_FX32(0.0);

    NNS_G3dGeLoadMtx43(&matrix);
}

void Animator3D__MatrixOp_Scale(Animator3D *animator)
{
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_Rotate(Animator3D *animator)
{
    NNS_G3dGeMultMtx33(&animator->rotation);
}

void Animator3D__MatrixOp_Translate(Animator3D *animator)
{
    NNS_G3dGeTranslateVec(&animator->translation);
}

void Animator3D__MatrixOp_Translate2(Animator3D *animator)
{
    NNS_G3dGeTranslateVec(&animator->translation2);
}

void Animator3D__MatrixOp_RotateScale(Animator3D *animator)
{
    NNS_G3dGeMultMtx43((MtxFx43 *)&animator->rotation);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_RotateTranslate2Scale(Animator3D *animator)
{
    NNS_G3dGeMultMtx43((MtxFx43 *)&animator->rotation);
    NNS_G3dGeTranslateVec(&animator->translation2);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_MultMtx43(Animator3D *animator)
{
    NNS_G3dGeMultMtx43(&animator->matrix43);
}

void Animator3D__MatrixOp_MultCameraMtx43(Animator3D *animator)
{
    MtxFx33 matrix;
    Camera3D__CopyMatrix4x3(NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGeMultMtx33(&matrix);
}

void Animator3D__MatrixOp_MultCameraMtx33(Animator3D *animator)
{
    MtxFx33 matrix;
    Camera3D__CopyMatrix3x3(NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGeMultMtx33(&matrix);
}

void Animator3D__MatrixOp_SetCameraRot4x3(Animator3D *animator)
{
    MtxFx33 matrix;
    Camera3D__CopyMatrix4x3(NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGlbSetBaseRot(&matrix);
}

void Animator3D__MatrixOp_SetCameraRot3x3(Animator3D *animator)
{
    MtxFx33 matrix;
    Camera3D__CopyMatrix3x3(NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGlbSetBaseRot(&matrix);
}

void Animator3D__MatrixOp_Callback(Animator3D *animator)
{
    animator->matrixCallback(animator);
}