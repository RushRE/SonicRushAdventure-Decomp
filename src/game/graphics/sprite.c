#include <game/graphics/sprite.h>
#include <game/graphics/tileHelpers.h>
#include <game/graphics/renderCore.h>
#include <game/system/allocator.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/oamSystem.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/math/mtMath.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// CONSTANTS
// --------------------

#define MAX_AFFINE_OAM_COUNT 0x20

#define MIN_SCALE_VALUE               FLOAT_TO_FX32(0.00830078125) // 0x22
#define MAX_ANIMATOR_AFFINE_OAM_COUNT 4

// These masks add an extra bit for both X & Y.. not sure why?
#define ATTR0_MASK_NOT_Y ~(SPRITE_OAM_ATTR0_Y | 0x100)
#define ATTR1_MASK_NOT_X ~(SPRITE_OAM_ATTR1_X | 0x200)

// --------------------
// FILE ENUMS
// --------------------

enum
{
    BAC_FRAME_FLAG_NONE = 0x00,

    // If set, the tile index will not advance after displaying the frame
    // This means the frame will use the same set of graphics as the previous one (possibly with a different index though!)
    BAC_FRAME_FLAG_NO_TILE_ADVANCE = 1 << 0,
};

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
    u16 flags;
    s16 left;
    s16 top;
    s16 right;
    s16 bottom;
    Vec2Fx16 center;
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

    GXRgb colors[1];
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
// ENUMS
// --------------------

enum BACOamShape
{
    BAC_OAM_SHAPE_8x8,
    BAC_OAM_SHAPE_16x16,
    BAC_OAM_SHAPE_32x32,
    BAC_OAM_SHAPE_64x64,
    BAC_OAM_SHAPE_16x8,
    BAC_OAM_SHAPE_32x8,
    BAC_OAM_SHAPE_32x16,
    BAC_OAM_SHAPE_64x32,
    BAC_OAM_SHAPE_8x16,
    BAC_OAM_SHAPE_8x32,
    BAC_OAM_SHAPE_16x32,
    BAC_OAM_SHAPE_32x64,

    BAC_OAM_SHAPE_COUNT,
};

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

extern u8 pixelFormatShift[BAC_FORMAT_COUNT];

static const u16 formatPaletteColorCount[BAC_FORMAT_COUNT] = {
    [BAC_FORMAT_PLTT16_2D]  = 16,  // GX_TEXFMT_PLTT16
    [BAC_FORMAT_PLTT256_2D] = 256, // GX_TEXFMT_PLTT256
    [BAC_FORMAT_DIRECT_2D]  = 0,   // GX_TEXFMT_DIRECT
    [BAC_FORMAT_PLTT4_3D]   = 4,   // GX_TEXFMT_PLTT4
    [BAC_FORMAT_PLTT16_3D]  = 16,  // GX_TEXFMT_PLTT16
    [BAC_FORMAT_PLTT256_3D] = 256, // GX_TEXFMT_PLTT256
    [BAC_FORMAT_DIRECT_3D]  = 0,   // GX_TEXFMT_DIRECT
    [BAC_FORMAT_A3I5_3D]    = 32,  // GX_TEXFMT_A3I5
    [BAC_FORMAT_A5I3_3D]    = 8,   // GX_TEXFMT_A5I3
    [BAC_FORMAT_COMP4x4_3D] = 0    // GX_TEXFMT_COMP4x4
};

static const u16 formatShapeTileCount[BAC_OAM_SHAPE_COUNT] = {
    [BAC_OAM_SHAPE_8x8]   = PIXEL_TO_TILE(8) * PIXEL_TO_TILE(8),   // BAC_OAM_SHAPE_8x8
    [BAC_OAM_SHAPE_16x16] = PIXEL_TO_TILE(16) * PIXEL_TO_TILE(16), // BAC_OAM_SHAPE_16x16
    [BAC_OAM_SHAPE_32x32] = PIXEL_TO_TILE(32) * PIXEL_TO_TILE(32), // BAC_OAM_SHAPE_32x32
    [BAC_OAM_SHAPE_64x64] = PIXEL_TO_TILE(64) * PIXEL_TO_TILE(64), // BAC_OAM_SHAPE_64x64
    [BAC_OAM_SHAPE_16x8]  = PIXEL_TO_TILE(16) * PIXEL_TO_TILE(8),  // BAC_OAM_SHAPE_16x8
    [BAC_OAM_SHAPE_32x8]  = PIXEL_TO_TILE(32) * PIXEL_TO_TILE(8),  // BAC_OAM_SHAPE_32x8
    [BAC_OAM_SHAPE_32x16] = PIXEL_TO_TILE(32) * PIXEL_TO_TILE(16), // BAC_OAM_SHAPE_32x16
    [BAC_OAM_SHAPE_64x32] = PIXEL_TO_TILE(64) * PIXEL_TO_TILE(32), // BAC_OAM_SHAPE_64x32
    [BAC_OAM_SHAPE_8x16]  = PIXEL_TO_TILE(8) * PIXEL_TO_TILE(16),  // BAC_OAM_SHAPE_8x16
    [BAC_OAM_SHAPE_8x32]  = PIXEL_TO_TILE(8) * PIXEL_TO_TILE(32),  // BAC_OAM_SHAPE_8x32
    [BAC_OAM_SHAPE_16x32] = PIXEL_TO_TILE(16) * PIXEL_TO_TILE(32), // BAC_OAM_SHAPE_16x32
    [BAC_OAM_SHAPE_32x64] = PIXEL_TO_TILE(32) * PIXEL_TO_TILE(64)  // BAC_OAM_SHAPE_32x64
};

static const u32 initValuesCacheAffineSpriteIndices[]           = { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF };
static const u32 initValuesCacheAffineSpriteIndicesDSRotoZoom[] = { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF };

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

static const BACFrameFunc frameGroupFuncList[SPRITE_BLOCK_COUNT] = {
    [SPRITE_BLOCK_END_FRAME]                 = (BACFrameFunc)BAC_FrameGroupFunc_EndFrame,
    [SPRITE_BLOCK_SPRITE_MAPPINGS]           = (BACFrameFunc)BAC_FrameGroupFunc_FrameAssembly,
    [SPRITE_BLOCK_SPRITE_GRAPHICS]           = (BACFrameFunc)BAC_FrameGroupFunc_SpriteParts,
    [SPRITE_BLOCK_SPRITE_PALETTE]            = (BACFrameFunc)BAC_FrameGroupFunc_Palette,
    [SPRITE_BLOCK_END_ANIMATION]             = (BACFrameFunc)BAC_FrameGroupFunc_EndAnimation,
    [SPRITE_BLOCK_UNUSED1]                   = (BACFrameFunc)BAC_FrameGroupFunc_Unused_5,
    [SPRITE_BLOCK_CALLBACK1]                 = (BACFrameFunc)BAC_FrameGroupFunc_Callback_6,
    [SPRITE_BLOCK_CALLBACK2]                 = (BACFrameFunc)BAC_FrameGroupFunc_Callback_7,
    [SPRITE_BLOCK_CALLBACK3]                 = (BACFrameFunc)BAC_FrameGroupFunc_Callback_8,
    [SPRITE_BLOCK_END_ANIMATION_CHANGE_ANIM] = (BACFrameFunc)BAC_FrameGroupFunc_EndAnimation_ChangeAnim,
    [SPRITE_BLOCK_UNUSED2]                   = (BACFrameFunc)BAC_FrameGroupFunc_Unused_10,
    [SPRITE_BLOCK_UNUSED3]                   = (BACFrameFunc)BAC_FrameGroupFunc_Unused_11,
};

static const u16 spriteShapeSizes3D[2 * BAC_OAM_SHAPE_COUNT] = {
    [(2 * BAC_OAM_SHAPE_8x8) + 0] = GX_TEXSIZE_S8,    [(2 * BAC_OAM_SHAPE_8x8) + 1] = GX_TEXSIZE_T8,    // BAC_OAM_SHAPE_8x8
    [(2 * BAC_OAM_SHAPE_16x16) + 0] = GX_TEXSIZE_S16, [(2 * BAC_OAM_SHAPE_16x16) + 1] = GX_TEXSIZE_T16, // BAC_OAM_SHAPE_16x16
    [(2 * BAC_OAM_SHAPE_32x32) + 0] = GX_TEXSIZE_S32, [(2 * BAC_OAM_SHAPE_32x32) + 1] = GX_TEXSIZE_T32, // BAC_OAM_SHAPE_32x32
    [(2 * BAC_OAM_SHAPE_64x64) + 0] = GX_TEXSIZE_S64, [(2 * BAC_OAM_SHAPE_64x64) + 1] = GX_TEXSIZE_T64, // BAC_OAM_SHAPE_64x64
    [(2 * BAC_OAM_SHAPE_16x8) + 0] = GX_TEXSIZE_S16,  [(2 * BAC_OAM_SHAPE_16x8) + 1] = GX_TEXSIZE_T8,   // BAC_OAM_SHAPE_16x8
    [(2 * BAC_OAM_SHAPE_32x8) + 0] = GX_TEXSIZE_S32,  [(2 * BAC_OAM_SHAPE_32x8) + 1] = GX_TEXSIZE_T8,   // BAC_OAM_SHAPE_32x8
    [(2 * BAC_OAM_SHAPE_32x16) + 0] = GX_TEXSIZE_S32, [(2 * BAC_OAM_SHAPE_32x16) + 1] = GX_TEXSIZE_T16, // BAC_OAM_SHAPE_32x16
    [(2 * BAC_OAM_SHAPE_64x32) + 0] = GX_TEXSIZE_S64, [(2 * BAC_OAM_SHAPE_64x32) + 1] = GX_TEXSIZE_T32, // BAC_OAM_SHAPE_64x32
    [(2 * BAC_OAM_SHAPE_8x16) + 0] = GX_TEXSIZE_S8,   [(2 * BAC_OAM_SHAPE_8x16) + 1] = GX_TEXSIZE_T16,  // BAC_OAM_SHAPE_8x16
    [(2 * BAC_OAM_SHAPE_8x32) + 0] = GX_TEXSIZE_S8,   [(2 * BAC_OAM_SHAPE_8x32) + 1] = GX_TEXSIZE_T32,  // BAC_OAM_SHAPE_8x32
    [(2 * BAC_OAM_SHAPE_16x32) + 0] = GX_TEXSIZE_S16, [(2 * BAC_OAM_SHAPE_16x32) + 1] = GX_TEXSIZE_T32, // BAC_OAM_SHAPE_16x32
    [(2 * BAC_OAM_SHAPE_32x64) + 0] = GX_TEXSIZE_S32, [(2 * BAC_OAM_SHAPE_32x64) + 1] = GX_TEXSIZE_T64, // BAC_OAM_SHAPE_32x64
};

static const Vec2U16 spriteShapeSizes2D[BAC_OAM_SHAPE_COUNT] = {
    [BAC_OAM_SHAPE_8x8]   = { 0x08, 0x08 }, // BAC_OAM_SHAPE_8x8
    [BAC_OAM_SHAPE_16x16] = { 0x10, 0x10 }, // BAC_OAM_SHAPE_16x16
    [BAC_OAM_SHAPE_32x32] = { 0x20, 0x20 }, // BAC_OAM_SHAPE_32x32
    [BAC_OAM_SHAPE_64x64] = { 0x40, 0x40 }, // BAC_OAM_SHAPE_64x64
    [BAC_OAM_SHAPE_16x8]  = { 0x10, 0x08 }, // BAC_OAM_SHAPE_16x8
    [BAC_OAM_SHAPE_32x8]  = { 0x20, 0x08 }, // BAC_OAM_SHAPE_32x8
    [BAC_OAM_SHAPE_32x16] = { 0x20, 0x10 }, // BAC_OAM_SHAPE_32x16
    [BAC_OAM_SHAPE_64x32] = { 0x40, 0x20 }, // BAC_OAM_SHAPE_64x32
    [BAC_OAM_SHAPE_8x16]  = { 0x08, 0x10 }, // BAC_OAM_SHAPE_8x16
    [BAC_OAM_SHAPE_8x32]  = { 0x08, 0x20 }, // BAC_OAM_SHAPE_8x32
    [BAC_OAM_SHAPE_16x32] = { 0x10, 0x20 }, // BAC_OAM_SHAPE_16x32
    [BAC_OAM_SHAPE_32x64] = { 0x20, 0x40 }, // BAC_OAM_SHAPE_32x64
};

static const Animator3DMatrixFunc animator3DDrawCommandList[MATRIX_OP_COUNT] = {
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

static const GXTexFmt gxFormatForSpriteFormat[BAC_FORMAT_COUNT] = {
    [BAC_FORMAT_PLTT16_2D]  = GX_TEXFMT_PLTT16,  // GX_TEXFMT_PLTT16
    [BAC_FORMAT_PLTT256_2D] = GX_TEXFMT_PLTT256, // GX_TEXFMT_PLTT256
    [BAC_FORMAT_DIRECT_2D]  = GX_TEXFMT_DIRECT,  // GX_TEXFMT_DIRECT
    [BAC_FORMAT_PLTT4_3D]   = GX_TEXFMT_PLTT4,   // GX_TEXFMT_PLTT4
    [BAC_FORMAT_PLTT16_3D]  = GX_TEXFMT_PLTT16,  // GX_TEXFMT_PLTT16
    [BAC_FORMAT_PLTT256_3D] = GX_TEXFMT_PLTT256, // GX_TEXFMT_PLTT256
    [BAC_FORMAT_DIRECT_3D]  = GX_TEXFMT_DIRECT,  // GX_TEXFMT_DIRECT
    [BAC_FORMAT_A3I5_3D]    = GX_TEXFMT_A3I5,    // GX_TEXFMT_A3I5
    [BAC_FORMAT_A5I3_3D]    = GX_TEXFMT_A5I3,    // GX_TEXFMT_A5I3
    [BAC_FORMAT_COMP4x4_3D] = GX_TEXFMT_COMP4x4  // GX_TEXFMT_COMP4x4
};

static u8 spriteUnknown[0x40]; // unknown

// --------------------
// HELPER MACROS
// --------------------

#define GetFile(filePtr)                           ((struct BACFile *)filePtr)
#define GetAnimHeaderBlock(filePtr)                ((struct BACAnimHeaderBlock *)&filePtr[GetFile(filePtr)->animHeaderOffset])
#define GetInfoBlock(filePtr)                      ((struct BACInfoBlock *)&filePtr[GetFile(filePtr)->infoOffset])
#define GetSpritePixelsBlock(filePtr, blockOffset) (u8 *)((blockOffset) + (u32)(filePtr + GetFile(filePtr)->spritePixelOffset))
#define GetPaletteBlock(filePtr, blockOffset)      (struct BACPaletteBlock *)((blockOffset) + (u32)(filePtr + GetFile(filePtr)->paletteOffset))

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

RUSH_INLINE s16 OamGetSignedX(GXOamAttr *attr)
{
    u32 attr1                    = attr->attr1;
    const int leftShift          = sizeof(u32) * 8 - GX_OAM_ATTR01_X_SIZE - 1;
    s16 vals16                   = ((attr1 << leftShift) >> 16);
    const int signDuplicateShift = sizeof(u16) * 8 - GX_OAM_ATTR01_X_SIZE - 1;
    return vals16 >> signDuplicateShift;
}

RUSH_INLINE s16 OamGetSignedY(GXOamAttr *attr)
{
    u32 attr0                    = attr->attr0;
    const u32 leftShift          = sizeof(u32) * 8 - GX_OAM_ATTR01_Y_SIZE - 1;
    s16 vals16                   = ((attr0 << leftShift) >> 16);
    const int signDuplicateShift = sizeof(u16) * 8 - GX_OAM_ATTR01_Y_SIZE - 1;
    return vals16 >> signDuplicateShift;
}

RUSH_INLINE VRAMPaletteKey GetSprite3DPaletteVRAM(AnimatorSprite3D *work)
{
    return work->animatorSprite.vramPalette;
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

void AnimatorSprite__DrawFrame(AnimatorSprite *animator)
{
    BOOL useEngineB = animator->useEngineB;
    u16 mosaicFlag  = 0;
    u16 flipFlags   = 0;

    struct BACFrame *frame = GetFrameAssemblyFromAnimator(animator);
    animator->lastSprite   = NULL;
    animator->firstSprite  = NULL;

    if ((animator->flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0 && frame->spriteCount > 0)
    {
        if ((animator->flags & ANIMATOR_FLAG_FLIP_X) != 0)
            flipFlags |= SPRITE_OAM_ATTR1_FLIP_X;

        if ((animator->flags & ANIMATOR_FLAG_FLIP_Y) != 0)
            flipFlags |= SPRITE_OAM_ATTR1_FLIP_Y;

        if ((animator->flags & ANIMATOR_FLAG_ENABLE_MOSAIC) != 0)
            mosaicFlag |= SPRITE_OAM_ATTR0_MOSAIC;

        u16 attr0Flags = (mosaicFlag | (animator->spriteType << SPRITE_OAM_ATTR0_MODE_SHIFT));
        if ((animator->flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) != 0)
        {
            s32 x = animator->pos.x;
            if ((flipFlags & SPRITE_OAM_ATTR1_FLIP_X) != 0)
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
            if ((flipFlags & SPRITE_OAM_ATTR1_FLIP_Y) != 0)
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

        GXOamAttr *sprite = frame->spriteList;
        u16 cParam        = animator->cParam.palette << SPRITE_OAM_ATTR2_CPARAM_SHIFT;

        u32 shapeShift;
        u32 vramLocation;
        s32 shift = 0;

        if ((frame->spriteList[0].attr0 & SPRITE_OAM_ATTR0_MODE) == (SPRITE_OAM_MODE_BITMAPOBJ << SPRITE_OAM_ATTR0_MODE_SHIFT))
        {
            shapeShift   = objBmpUse256K[useEngineB];
            vramLocation = SPRITE_OAM_ATTR2_NAME & ((size_t)(animator->vramPixels - VRAMSystem__VRAM_OBJ[animator->useEngineB]) >> (7 + shapeShift));
        }
        else
        {
            shapeShift   = objBankShift[useEngineB];
            vramLocation = SPRITE_OAM_ATTR2_NAME & ((size_t)(animator->vramPixels - VRAMSystem__VRAM_OBJ[animator->useEngineB]) >> (5 + shapeShift));

            if (GetAnimHeaderBlockFromAnimator(animator)->anims[animator->animID].format != BAC_FORMAT_PLTT16_2D)
            {
                shift = 1;
            }
        }

        u32 shift2 = (u16)((1 << shapeShift) - 1);

        u16 s = 0;
        for (s = 0; s < frame->spriteCount; s++, sprite++)
        {
            GXOamAttr *dst;
            s32 placeX;
            s32 placeY;

            u32 shape = ((sprite->attr0 & SPRITE_OAM_ATTR0_SHAPE) >> SPRITE_OAM_ATTR0_MOSAIC_SHIFT) | ((sprite->attr1 & SPRITE_OAM_ATTR1_SIZE) >> SPRITE_OAM_ATTR1_SIZE_SHIFT);
            const Vec2U16 *shapeSizePtr = &spriteShapeSizes2D[shape];

#define OAM_X ((s16)(((u32)sprite->attr1 << 22) >> 16) >> 6)
#define OAM_Y ((s16)(((u32)sprite->attr0 << 23) >> 16) >> 7)

            if ((flipFlags & SPRITE_OAM_ATTR1_FLIP_X) != 0)
                placeX = animator->pos.x + frame->center.x - OAM_X - shapeSizePtr->x;
            else
                placeX = animator->pos.x - frame->center.x + OAM_X;

            if ((flipFlags & SPRITE_OAM_ATTR1_FLIP_Y) != 0)
                placeY = animator->pos.y + frame->center.y - OAM_Y - shapeSizePtr->y;
            else
                placeY = animator->pos.y - frame->center.y + OAM_Y;

#undef OAM_X
#undef OAM_Y

            if ((animator->flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) != 0 && SpriteDrawBoundsCheck(shapeSizePtr, placeX, placeY) == FALSE)
            {
                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    vramLocation += (formatShapeTileCount[shape] + shift2) >> shapeShift << shift;
                }
            }
            else
            {
                dst = OAMSystem__Alloc(animator->useEngineB, animator->oamOrder);
                if (&oamDefault == dst)
                    return;

                GXOamAttr *first     = animator->firstSprite;
                animator->lastSprite = dst;
                if (first == NULL)
                    animator->firstSprite = dst;

                dst->attr0 = (sprite->attr0 & ATTR0_MASK_NOT_Y) | (placeY & SPRITE_OAM_ATTR0_Y);
                dst->attr0 |= attr0Flags;
                dst->attr1 = (sprite->attr1 & ATTR1_MASK_NOT_X) | (placeX & SPRITE_OAM_ATTR1_X);
                dst->attr1 ^= flipFlags;

                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    dst->attr2 =
                        (vramLocation & SPRITE_OAM_ATTR2_NAME) | (animator->oamPriority << SPRITE_OAM_ATTR2_PRIORITY_SHIFT) | (sprite->attr2 + cParam) & SPRITE_OAM_ATTR2_CPARAM;

                    vramLocation += (formatShapeTileCount[shape] + shift2) >> shapeShift << shift;
                }
                else
                {
                    dst->attr2 = ((sprite->attr2 + vramLocation) & SPRITE_OAM_ATTR2_NAME) | (animator->oamPriority << SPRITE_OAM_ATTR2_PRIORITY_SHIFT)
                                 | ((sprite->attr2 + cParam) & SPRITE_OAM_ATTR2_CPARAM);
                }
            }
        }
    }
}

#if defined(SDK_CW) || defined(__MWERKS__)
// Direct array assignment is NOT standard C, and this macro thus requires another implementation outside of MWCC
#define ARRAY_COPY(targetArr, srcArr) targetArr = srcArr
#else
#define ARRAY_COPY(targetArr, srcArr) memcpy(targetArr, srcArr, sizeof(srcArr))
#endif

// TODO: Lets call this "DrawFrameAffine"
void AnimatorSprite__DrawFrameRotoZoom(AnimatorSprite *animator, fx32 scaleX, fx32 scaleY, s32 rotation)
{
    enum
    {
        NO_FLIP            = 0,
        HFLIP              = 1,
        VFLIP              = 2,
        HVFLIP             = 3,
        FLIP_VARIANT_COUNT = 4
    };

    typedef union
    {
        Vec2U16 v;
        u32 i;
    } Vec2DOrInt;

    MtxFx22 mtx_array_rotated_and_scaled[FLIP_VARIANT_COUNT];
    MtxFx22 mtx_array_affine_params[FLIP_VARIANT_COUNT];
    u32 cacheAffineSpriteIndices[FLIP_VARIANT_COUNT];

    u16 shiftMask;
    u16 paletteOffset;
    MtxFx22 *mtx22_rot_scale_hv;
    u32 *p_sprite2DSize;
    u32 hvFlipBits;
    u16 localFlagAffine;
    u32 shift;
    u32 shiftTileOffset;
    u32 i;
    BOOL useEngineB_1C;
    u32 shape;
    u16 localFlagHV;
    s32 affineSpriteIndex;

    struct BACFrame *frame;
    BOOL useEngineB;
    // Y before X is required for the declaration order (otherwise regalloc swaps them).
    fx32 invScaleY;
    fx32 invScaleX;
    // Likewise, swapping these decreases matching percentage
    GXOamAttr *sprite;
    u32 oamTileOffset;

#define mtx22_rot           mtx_array_rotated_and_scaled[NO_FLIP]
#define mtx22_params_hflip  mtx_array_affine_params[HFLIP]
#define mtx22_rot_hflip     mtx_array_rotated_and_scaled[HFLIP]
#define mtx22_params_vflip  mtx_array_affine_params[VFLIP]
#define mtx22_rot_vflip     mtx_array_rotated_and_scaled[VFLIP]
#define mtx22_params_hvflip mtx_array_affine_params[HVFLIP]
#define mtx22_rot_hvflip    mtx_array_rotated_and_scaled[HVFLIP]
#define mtx22_params_noflip mtx_array_affine_params[NO_FLIP]

    useEngineB      = animator->useEngineB;
    localFlagAffine = 0;
    localFlagHV     = 0;

    frame = GetFrameAssemblyFromAnimator(animator);

    animator->firstSprite = animator->lastSprite = NULL;

    if (animator->flags & ANIMATOR_FLAG_DISABLE_DRAW)
        return;

    if (frame->spriteCount == 0)
        return;

    if (MATH_ABS(scaleX) < MIN_SCALE_VALUE)
        return;

    if (MATH_ABS(scaleY) < MIN_SCALE_VALUE)
        return;

    if ((animator->flags & ANIMATOR_FLAG_FORCE_AFFINE) == 0)
    {
        const s32 totalFinalSpriteCount = OAMSystem__GetOAMAffineOffset(animator->useEngineB) + OAMSystem__GetOAMAffineCount(animator->useEngineB)
                                          + MT_MATH_MIN(frame->spriteCount, MAX_ANIMATOR_AFFINE_OAM_COUNT);

        if (totalFinalSpriteCount >= MAX_AFFINE_OAM_COUNT)
        {
            AnimatorSprite__DrawFrame(animator);
            return;
        }
    }

    invScaleX = FX_Inv(scaleX);
    invScaleY = FX_Inv(scaleY);
    if (rotation == FLOAT_DEG_TO_IDX(0.0))
    {
        if (scaleX > FLOAT_TO_FX32(0.0))
            scaleX -= FLOAT_TO_FX32(0.03125);
        else if (scaleX < FLOAT_TO_FX32(0.0))
            scaleX += FLOAT_TO_FX32(0.03125);

        if (scaleY > FLOAT_TO_FX32(0.0))
            scaleY -= FLOAT_TO_FX32(0.03125);
        else if (scaleY < FLOAT_TO_FX32(0.0))
            scaleY += FLOAT_TO_FX32(0.03125);
    }
    else
    {
        if (scaleX > FLOAT_TO_FX32(0.0))
            scaleX -= FLOAT_TO_FX32(0.03515625);
        else if (scaleX < FLOAT_TO_FX32(0.0))
            scaleX += FLOAT_TO_FX32(0.03515625);

        if (scaleY > FLOAT_TO_FX32(0.0))
            scaleY -= FLOAT_TO_FX32(0.03515625);
        else if (scaleY < FLOAT_TO_FX32(0.0))
            scaleY += FLOAT_TO_FX32(0.03515625);
    }

    MTX_Rot22(&mtx22_rot, SinFX(rotation), CosFX(rotation));
    MTX_ScaleApply22(&mtx22_rot, &mtx22_params_hflip, -invScaleX, invScaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_rot_hflip, -scaleX, scaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_params_vflip, invScaleX, -invScaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_rot_vflip, scaleX, -scaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_params_hvflip, -invScaleX, -invScaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_rot_hvflip, -scaleX, -scaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_params_noflip, invScaleX, invScaleY);
    MTX_ScaleApply22(&mtx22_rot, &mtx22_rot, scaleX, scaleY);

    if ((animator->flags & ANIMATOR_FLAG_FLIP_X) != 0)
        localFlagHV |= SPRITE_OAM_ATTR1_FLIP_X;

    if ((animator->flags & ANIMATOR_FLAG_FLIP_Y) != 0)
        localFlagHV |= SPRITE_OAM_ATTR1_FLIP_Y;

    if ((animator->flags & ANIMATOR_FLAG_ENABLE_MOSAIC) != 0)
        localFlagAffine |= SPRITE_OAM_ATTR0_MOSAIC;

    if ((animator->flags & ANIMATOR_FLAG_ENABLE_SCALE) != 0)
        localFlagAffine |= SPRITE_OAM_EFFECT_NODISPLAY;

    shiftTileOffset = 0;

    localFlagAffine |= (animator->spriteType << SPRITE_OAM_ATTR0_MODE_SHIFT);

    ARRAY_COPY(cacheAffineSpriteIndices, initValuesCacheAffineSpriteIndices);

    paletteOffset = animator->cParam.palette << SPRITE_OAM_ATTR2_CPARAM_SHIFT;

    sprite = &frame->spriteList[0];

    if ((frame->spriteList[0].attr0 & SPRITE_OAM_ATTR0_MODE) == (SPRITE_OAM_MODE_BITMAPOBJ << SPRITE_OAM_ATTR0_MODE_SHIFT))
    {
        shift = objBmpUse256K[useEngineB];

        void const *objBase = VRAMSystem__VRAM_OBJ[animator->useEngineB];

        u32 animatorTilesOffset = animator->vramPixels - objBase;
        oamTileOffset           = SPRITE_OAM_ATTR2_NAME & (animatorTilesOffset >> (shift + 7));
    }
    else
    {
        shift = objBankShift[useEngineB];

        void const *objBase     = VRAMSystem__VRAM_OBJ[animator->useEngineB];
        u32 animatorTilesOffset = animator->vramPixels - objBase;

        oamTileOffset = SPRITE_OAM_ATTR2_NAME & (animatorTilesOffset >> (shift + 5));

        if (GetAnimHeaderBlockFromAnimator(animator)->anims[animator->animID].format != BAC_FORMAT_PLTT16_2D)
            shiftTileOffset = 1;
    }

    shiftMask = (1 << shift) - 1;

    for (i = 0; i < frame->spriteCount; i++, sprite++)
    {
        shape = ((sprite->attr0 & SPRITE_OAM_ATTR0_SHAPE) >> SPRITE_OAM_ATTR0_MOSAIC_SHIFT) | ((sprite->attr1 & SPRITE_OAM_ATTR1_SIZE) >> SPRITE_OAM_ATTR1_SIZE_SHIFT);

        Vec2DOrInt sprite2DSize;
        sprite2DSize.i = ((Vec2DOrInt const *)(&spriteShapeSizes2D[shape]))->i;

        u16 finalFlipsCurrentOAM = (localFlagHV ^ sprite->attr1);

        u32 mtx22AffineParamsIndexCurrentOAM = (finalFlipsCurrentOAM & SPRITE_OAM_ATTR1_FLIP) >> SPRITE_OAM_ATTR1_FLIP_X_SHIFT;

        hvFlipBits         = (localFlagHV & SPRITE_OAM_ATTR1_FLIP) >> SPRITE_OAM_ATTR1_FLIP_X_SHIFT;
        mtx22_rot_scale_hv = &mtx_array_rotated_and_scaled[hvFlipBits];

        s32 framePieceCenterXNonRotated = OamGetSignedX(sprite) - frame->center.x + (sprite2DSize.v.x >> 1);
        s32 framePieceCenterYNonRotated = OamGetSignedY(sprite) - frame->center.y + (sprite2DSize.v.y >> 1);

        fx32 cosRotByXScale      = mtx_array_rotated_and_scaled[hvFlipBits].a[0];
        fx32 minusSinRotByYScale = mtx22_rot_scale_hv->a[2];
        fx32 sinRotByXScale      = mtx22_rot_scale_hv->a[1];
        fx32 cosYScale           = mtx22_rot_scale_hv->a[3];

        s32 xOAM = animator->pos.x - (sprite2DSize.v.x >> 1) +
                   // Get the X of the center of the sprite, rotated and scaled
                   FX32_TO_WHOLE((framePieceCenterXNonRotated * cosRotByXScale) + (framePieceCenterYNonRotated * minusSinRotByYScale));

        s32 yOAM = animator->pos.y - (sprite2DSize.v.y >> 1) +
                   // Get the Y of the center of the sprite, rotated and scaled
                   FX32_TO_WHOLE((framePieceCenterXNonRotated * sinRotByXScale) + (framePieceCenterYNonRotated * cosYScale));

        p_sprite2DSize = &sprite2DSize.i;

        if ((localFlagAffine & SPRITE_OAM_EFFECT_NODISPLAY) != 0)
        {
            xOAM -= (sprite2DSize.v.x >> 1);
            yOAM -= (sprite2DSize.v.y >> 1);

            *p_sprite2DSize <<= 1;
        }

        if ((animator->flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) && !SpriteDrawBoundsCheck(&sprite2DSize.v, xOAM, yOAM))
        {
            if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
            {
                oamTileOffset += ((u32)(formatShapeTileCount[shape] + shiftMask) >> shift) << shiftTileOffset;
            }
        }
        else
        {
            useEngineB_1C = animator->useEngineB;

            affineSpriteIndex = cacheAffineSpriteIndices[mtx22AffineParamsIndexCurrentOAM];
            BOOL addAffineOAMSuccess;

            do
            {
                if (affineSpriteIndex < 0)
                {
                    cacheAffineSpriteIndices[mtx22AffineParamsIndexCurrentOAM] =
                        OAMSystem__AddAffineSprite(useEngineB_1C, mtx_array_affine_params + mtx22AffineParamsIndexCurrentOAM);
                    affineSpriteIndex = cacheAffineSpriteIndices[mtx22AffineParamsIndexCurrentOAM];

                    if (affineSpriteIndex < 0)
                    {
                        addAffineOAMSuccess = FALSE;
                        break;
                    }
                    else
                    {
                        GXOamAffine *dst = (GXOamAffine *)OAMSystem__GetList1(useEngineB_1C);

                        dst += affineSpriteIndex;

                        G2_SetOBJAffine(dst, mtx_array_affine_params + mtx22AffineParamsIndexCurrentOAM);
                    }
                }

                addAffineOAMSuccess = TRUE;
            } while (FALSE);

            affineSpriteIndex = cacheAffineSpriteIndices[mtx22AffineParamsIndexCurrentOAM];
            if (!addAffineOAMSuccess)
            {
                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    oamTileOffset += ((u32)(formatShapeTileCount[shape] + shiftMask) >> shift) << shiftTileOffset;
                }
            }
            else
            {
                GXOamAttr *dst = OAMSystem__Alloc(animator->useEngineB, animator->oamOrder);
                if (&oamDefault == dst)
                    return;

                GXOamAttr *firstSprite = animator->firstSprite;

                animator->lastSprite = dst;
                if (firstSprite == NULL)
                    animator->firstSprite = dst;

                u32 xOAMMasked = xOAM & SPRITE_OAM_ATTR1_X;

                dst->attr0 = (sprite->attr0 & (ATTR0_MASK_NOT_Y)) | (yOAM & SPRITE_OAM_ATTR0_Y) | SPRITE_OAM_EFFECT_AFFINE;
                dst->attr0 |= localFlagAffine;
                dst->attr1 = (sprite->attr1 & (ATTR1_MASK_NOT_X)) | xOAMMasked;
                dst->attr1 = (dst->attr1 & ~SPRITE_OAM_ATTR1_RSPARAM) | (affineSpriteIndex << SPRITE_OAM_ATTR1_AFFINE_SHIFT);

                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    u32 tileOffsetAndOamPriority = (oamTileOffset & SPRITE_OAM_ATTR2_NAME) | (animator->oamPriority << SPRITE_OAM_ATTR2_PRIORITY_SHIFT);
                    u32 colorParam               = (sprite->attr2 + paletteOffset) & SPRITE_OAM_ATTR2_CPARAM;

                    dst->attr2 = tileOffsetAndOamPriority | colorParam;

                    oamTileOffset += ((u32)(formatShapeTileCount[shape] + shiftMask) >> shift) << shiftTileOffset;
                }
                else
                {
                    u32 tileOffsetAndOamPriority = ((sprite->attr2 + oamTileOffset) & SPRITE_OAM_ATTR2_NAME) | (animator->oamPriority << SPRITE_OAM_ATTR2_PRIORITY_SHIFT);

                    dst->attr2 = tileOffsetAndOamPriority | ((sprite->attr2 + paletteOffset) & SPRITE_OAM_ATTR2_CPARAM);
                }
            }
        }
    }
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
void AnimatorSpriteDS__Init(AnimatorSpriteDS *animator, void *fileData, u16 animID, AnimatorSpriteDSFlags flagsDS, AnimatorFlags flags, PixelMode spriteMode0,
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
    animator->flags              = flagsDS;

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
    for (u32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
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

RUSH_INLINE void CallAnimatorSpriteDrawFrameForEngine(AnimatorSpriteDS *animator, int engineIndex)
{
    animator->work.useEngineB     = engineIndex;
    animator->work.pos.x          = animator->position[engineIndex].x;
    animator->work.pos.y          = animator->position[engineIndex].y;
    animator->work.pixelMode      = animator->pixelMode[engineIndex];
    animator->work.vramPixels     = animator->vramPixels[engineIndex];
    animator->work.paletteMode    = animator->paletteMode[engineIndex];
    animator->work.vramPalette    = animator->vramPalette[engineIndex];
    animator->work.cParam.palette = animator->cParam[engineIndex].palette;
    AnimatorSprite__DrawFrame(&animator->work);
    animator->firstSprite[engineIndex] = animator->work.firstSprite;
    animator->lastSprite[engineIndex]  = animator->work.lastSprite;
}

RUSH_INLINE BOOL AnimatorVisibleOnScreen(AnimatorSpriteDS *animator, struct BACFrame *frame, int engineIndex)
{
    // The posX and posY temporaries are necessary for 100% match.
    if ((animator->work.flags & ANIMATOR_FLAG_FLIP_X))
    {
        fx16 posX = animator->position[engineIndex].x;
        if (((posX - frame->left) <= 0) || ((posX - frame->right) >= HW_LCD_WIDTH))
        {
            return FALSE;
        }
    }
    else
    {
        fx16 posX = animator->position[engineIndex].x;
        if (((posX + frame->right) <= 0) || ((posX + frame->left) >= HW_LCD_WIDTH))
        {
            return FALSE;
        }
    }
    if ((animator->work.flags & ANIMATOR_FLAG_FLIP_Y))
    {
        fx16 posY = animator->position[engineIndex].y;
        if (((posY - frame->top) <= 0) || ((posY - frame->bottom) >= HW_LCD_HEIGHT))
        {
            return FALSE;
        }
    }
    else
    {
        fx16 posY = animator->position[engineIndex].y;
        if (((posY + frame->bottom) <= 0) || ((posY + frame->top) >= HW_LCD_HEIGHT))
        {
            return FALSE;
        }
    }
    return TRUE;
}

RUSH_INLINE void DisableDrawForEngineIfInvisible(AnimatorSpriteDS *animator, struct BACFrame *frame, int engineIndex, AnimatorSpriteDSFlags *screensDrawFlag)
{
    if (!AnimatorVisibleOnScreen(animator, frame, engineIndex))
    {
        int doNotDrawOnEngine = 1;
        *screensDrawFlag |= (doNotDrawOnEngine << engineIndex);
    }
}

void AnimatorSpriteDS__DrawFrame(AnimatorSpriteDS *animator)
{
    enum
    {
        ANIMATORSPRITE_DRAWFRAME_HFLIP          = SPRITE_OAM_ATTR1_FLIP_X,
        ANIMATORSPRITE_DRAWFRAME_VFLIP          = SPRITE_OAM_ATTR1_FLIP_Y,
        ANIMATORSPRITE_DRAWFRAMEROTOZOOM_SCALE  = 0x200,
        ANIMATORSPRITE_DRAWFRAMEROTOZOOM_MOSAIC = SPRITE_OAM_ATTR0_MOSAIC,
    };
    AnimatorSpriteDSFlags screensDrawFlag;
    struct BACFrame *frame;
    GXOamAttr *currentSprite;
    int engineIndex;
    u32 vramLocation[GRAPHICS_ENGINE_COUNT];
    u32 shift[GRAPHICS_ENGINE_COUNT];
    u32 shiftMask[GRAPHICS_ENGINE_COUNT];
    u16 paletteOffset[GRAPHICS_ENGINE_COUNT];
    u16 flagAffine = 0;
    u16 flagFlip   = 0;
    u32 sp_18;
    u16 i;
    Vec2U16 const *shapeSize;
    s32 offsetX;
    s32 offsetY;

    screensDrawFlag                          = animator->flags;
    frame                                    = GetFrameAssemblyFromAnimator(&animator->work);
    animator->firstSprite[GRAPHICS_ENGINE_A] = animator->firstSprite[GRAPHICS_ENGINE_B] = NULL;
    animator->lastSprite[GRAPHICS_ENGINE_A] = animator->lastSprite[GRAPHICS_ENGINE_B] = NULL;
    if (animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW)
    {
        return;
    }
    if (frame->spriteCount == 0)
    {
        return;
    }
    if (animator->work.flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK)
    {
        if ((screensDrawFlag & ANIMATORSPRITEDS_FLAG_DISABLE_A) == 0)
        {
            DisableDrawForEngineIfInvisible(animator, frame, GRAPHICS_ENGINE_A, &screensDrawFlag);
        }
        if ((screensDrawFlag & ANIMATORSPRITEDS_FLAG_DISABLE_B) == 0)
        {
            DisableDrawForEngineIfInvisible(animator, frame, GRAPHICS_ENGINE_B, &screensDrawFlag);
        }
    }
    screensDrawFlag &= ANIMATORSPRITEDS_FLAG_DISABLE_AB;
    if (screensDrawFlag == ANIMATORSPRITEDS_FLAG_DISABLE_AB)
    {
        return;
    }
    if ((screensDrawFlag == ANIMATORSPRITEDS_FLAG_DISABLE_A) == 0)
    {
        if ((screensDrawFlag == ANIMATORSPRITEDS_FLAG_DISABLE_B) != 0)
        {
            CallAnimatorSpriteDrawFrameForEngine(animator, GRAPHICS_ENGINE_A);
            return;
        }
    }
    else
    {
        CallAnimatorSpriteDrawFrameForEngine(animator, GRAPHICS_ENGINE_B);
        return;
    }
    if (animator->work.flags & ANIMATOR_FLAG_FLIP_X)
    {
        flagFlip |= ANIMATORSPRITE_DRAWFRAME_HFLIP;
    }
    if (animator->work.flags & ANIMATOR_FLAG_FLIP_Y)
    {
        flagFlip |= ANIMATORSPRITE_DRAWFRAME_VFLIP;
    }
    if (animator->work.flags & ANIMATOR_FLAG_ENABLE_MOSAIC)
    {
        flagAffine |= ANIMATORSPRITE_DRAWFRAMEROTOZOOM_MOSAIC;
    }
    flagAffine |= (animator->work.spriteType << GX_OAM_ATTR01_MODE_SHIFT);
    paletteOffset[GRAPHICS_ENGINE_A] = animator->cParam[GRAPHICS_ENGINE_A].palette << GX_OAM_ATTR2_CPARAM_SHIFT;
    paletteOffset[GRAPHICS_ENGINE_B] = animator->cParam[GRAPHICS_ENGINE_B].palette << GX_OAM_ATTR2_CPARAM_SHIFT;
    sp_18                            = 0;
    currentSprite                    = &frame->spriteList[0];
    if ((frame->spriteList[0].attr0 & GX_OAM_ATTR01_MODE_MASK) == (GX_OAM_MODE_BITMAPOBJ << GX_OAM_ATTR01_MODE_SHIFT))
    {
        u32 diffA                       = animator->vramPixels[GRAPHICS_ENGINE_A] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_A];
        vramLocation[GRAPHICS_ENGINE_A] = GX_OAM_ATTR2_NAME_MASK & (diffA >> (objBmpUse256K[GRAPHICS_ENGINE_A] + 7));
        u32 diffB                       = animator->vramPixels[GRAPHICS_ENGINE_B] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_B];
        vramLocation[GRAPHICS_ENGINE_B] = GX_OAM_ATTR2_NAME_MASK & (diffB >> (objBmpUse256K[GRAPHICS_ENGINE_B] + 7));
        shift[GRAPHICS_ENGINE_A]        = objBmpUse256K[GRAPHICS_ENGINE_A];
        shift[GRAPHICS_ENGINE_B]        = objBmpUse256K[GRAPHICS_ENGINE_B];
    }
    else
    {
        u32 diffA                       = animator->vramPixels[GRAPHICS_ENGINE_A] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_A];
        vramLocation[GRAPHICS_ENGINE_A] = GX_OAM_ATTR2_NAME_MASK & (diffA >> (objBankShift[GRAPHICS_ENGINE_A] + 5));
        u32 diffB                       = animator->vramPixels[GRAPHICS_ENGINE_B] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_B];
        vramLocation[GRAPHICS_ENGINE_B] = GX_OAM_ATTR2_NAME_MASK & (diffB >> (objBankShift[GRAPHICS_ENGINE_B] + 5));
        shift[GRAPHICS_ENGINE_A]        = objBankShift[GRAPHICS_ENGINE_A];
        shift[GRAPHICS_ENGINE_B]        = objBankShift[GRAPHICS_ENGINE_B];
        if (GetAnimHeaderBlockFromAnimator(&animator->work)->anims[animator->work.animID].format != BAC_FORMAT_PLTT16_2D)
        {
            sp_18 = 1;
        }
    }
    shiftMask[GRAPHICS_ENGINE_A] = (u16)((1 << shift[GRAPHICS_ENGINE_A]) - 1);
    shiftMask[GRAPHICS_ENGINE_B] = (u16)((1 << shift[GRAPHICS_ENGINE_B]) - 1);

    for (i = 0; i < frame->spriteCount; i++, currentSprite++)
    {
        u32 shape = ((currentSprite->attr0 & SPRITE_OAM_ATTR0_SHAPE) >> (SPRITE_OAM_ATTR0_SHAPE_SHIFT - 2))
                    | ((currentSprite->attr1 & SPRITE_OAM_ATTR1_SIZE) >> SPRITE_OAM_ATTR1_SIZE_SHIFT);
        shapeSize = &spriteShapeSizes2D[shape];
        if (flagFlip & ANIMATORSPRITE_DRAWFRAME_HFLIP)
        {
            offsetX = frame->center.x - OamGetSignedX(currentSprite) - shapeSize->x;
        }
        else
        {
            offsetX = -1 * frame->center.x + OamGetSignedX(currentSprite);
        }
        if (flagFlip & ANIMATORSPRITE_DRAWFRAME_VFLIP)
        {
            offsetY = frame->center.y - OamGetSignedY(currentSprite) - shapeSize->y;
        }
        else
        {
            offsetY = -1 * frame->center.y + OamGetSignedY(currentSprite);
        }
        for (engineIndex = 0; engineIndex < GRAPHICS_ENGINE_COUNT; engineIndex++)
        {
            u32 xOAM = animator->position[engineIndex].x + offsetX;
            u32 yOAM = animator->position[engineIndex].y + offsetY;

            if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) && !SpriteDrawBoundsCheck(shapeSize, xOAM, yOAM))
            {
                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    vramLocation[engineIndex] += ((formatShapeTileCount[shape] + shiftMask[engineIndex]) >> shift[engineIndex]) << sp_18;
                }
            }
            else
            {
                GXOamAttr *oam;
                oam = OAMSystem__Alloc(engineIndex, animator->work.oamOrder);
                if (&oamDefault == oam)
                {
                    return;
                }
                GXOamAttr *first                  = animator->firstSprite[engineIndex];
                animator->lastSprite[engineIndex] = oam;
                if (first == NULL)
                {
                    animator->firstSprite[engineIndex] = oam;
                }
                oam->attr0 = (currentSprite->attr0 & (ATTR0_MASK_NOT_Y)) | (yOAM & SPRITE_OAM_ATTR0_Y);
                oam->attr0 |= flagAffine;
                oam->attr1 = (currentSprite->attr1 & (ATTR1_MASK_NOT_X)) | (xOAM & SPRITE_OAM_ATTR1_X);
                oam->attr1 ^= flagFlip;
                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    oam->attr2 = (vramLocation[engineIndex] & GX_OAM_ATTR2_NAME_MASK) | (animator->work.oamPriority << GX_OAM_ATTR2_PRIORITY_SHIFT)
                                 | ((currentSprite->attr2 + paletteOffset[engineIndex]) & GX_OAM_ATTR2_CPARAM_MASK);

                    vramLocation[engineIndex] += ((formatShapeTileCount[shape] + shiftMask[engineIndex]) >> shift[engineIndex]) << sp_18;
                }
                else
                {
                    oam->attr2 = ((currentSprite->attr2 + vramLocation[engineIndex]) & GX_OAM_ATTR2_NAME_MASK) | (animator->work.oamPriority << GX_OAM_ATTR2_PRIORITY_SHIFT)
                                 | ((currentSprite->attr2 + paletteOffset[engineIndex]) & GX_OAM_ATTR2_CPARAM_MASK);
                }
            }
        }
    }
}

RUSH_INLINE void CallAnimatorSpriteDrawFrameForEngine__RotoZoomVariant(AnimatorSpriteDS *animator, GraphicsEngine engineIndex)
{
    animator->work.useEngineB     = engineIndex;
    animator->work.pos.x          = animator->position[engineIndex].x;
    animator->work.pos.y          = animator->position[engineIndex].y;
    animator->work.pixelMode      = animator->pixelMode[engineIndex];
    animator->work.vramPixels     = animator->vramPixels[engineIndex];
    animator->work.paletteMode    = animator->paletteMode[engineIndex];
    animator->work.vramPalette    = animator->vramPalette[engineIndex];
    animator->work.cParam.palette = animator->cParam[engineIndex].palette;
    AnimatorSprite__DrawFrame(&animator->work);
}

RUSH_INLINE void CallAnimatorSpriteDrawFrameRotoZoomForEngine(AnimatorSpriteDS *animator, GraphicsEngine engineIndex, fx32 scaleX, fx32 scaleY, s32 rotation)
{
    animator->work.useEngineB     = engineIndex;
    animator->work.pos.x          = animator->position[engineIndex].x;
    animator->work.pos.y          = animator->position[engineIndex].y;
    animator->work.pixelMode      = animator->pixelMode[engineIndex];
    animator->work.vramPixels     = animator->vramPixels[engineIndex];
    animator->work.paletteMode    = animator->paletteMode[engineIndex];
    animator->work.vramPalette    = animator->vramPalette[engineIndex];
    animator->work.cParam.palette = animator->cParam[engineIndex].palette;
    AnimatorSprite__DrawFrameRotoZoom(&animator->work, scaleX, scaleY, rotation);
    animator->firstSprite[engineIndex] = animator->work.firstSprite;
    animator->lastSprite[engineIndex]  = animator->work.lastSprite;
}

// TODO: Lets call this "DrawFrameAffine"
NONMATCH_FUNC void AnimatorSpriteDS__DrawFrameRotoZoom(AnimatorSpriteDS *animator, fx32 scaleX, fx32 scaleY, s32 rotation)
{
#ifdef NON_MATCHING
    // https://decomp.me/scratch/GbgLX => 99.17%
    enum
    {
        NO_FLIP            = 0,
        HFLIP              = 1,
        VFLIP              = 2,
        HVFLIP             = 3,
        FLIP_VARIANT_COUNT = 4
    };
    enum
    {
        ANIMATORSPRITE_DRAWFRAME_HFLIP          = SPRITE_OAM_ATTR1_FLIP_X,
        ANIMATORSPRITE_DRAWFRAME_VFLIP          = SPRITE_OAM_ATTR1_FLIP_Y,
        ANIMATORSPRITE_DRAWFRAMEROTOZOOM_SCALE  = 0x200,
        ANIMATORSPRITE_DRAWFRAMEROTOZOOM_MOSAIC = 0x1000,
    };
    typedef union
    {
        Vec2U16 v;
        u32 i;
    } Vec2DOrInt;

    MtxFx22 matricesRotationAndScale[FLIP_VARIANT_COUNT];
    MtxFx22 matricesAffineParams[FLIP_VARIANT_COUNT];
    u32 cacheAffineSpriteIndicesBothEngines[GRAPHICS_ENGINE_COUNT * FLIP_VARIANT_COUNT];
    u32 cacheAffineSpriteIndicesInitialValues[GRAPHICS_ENGINE_COUNT * FLIP_VARIANT_COUNT];
    u32 vramLocation[GRAPHICS_ENGINE_COUNT];
    u32 shift[GRAPHICS_ENGINE_COUNT];
    u32 shiftMask[GRAPHICS_ENGINE_COUNT];
    u16 paletteOffset[GRAPHICS_ENGINE_COUNT];
    Vec2DOrInt sprite2DSize;
    u32 *ptrArrayCacheAffineSpriteIndices;
    u16 flagAffine;
    u32 shiftTileOffset;
    u32 i;
    u32 mtx22AffineParamsIndexCurrentOAM;
    s32 baseX;
    s32 baseY;
    s32 xOAMEngine;
    s32 yOAMEngine;
    u16 flagFlip;
    u32 hvFlipBits;
    s32 affineSpriteIndex;
    fx32 invScaleY;
    fx32 invScaleX;
    struct BACFrame *frame;
    GXOamAttr *currentOamAttr;
    MtxFx22 *ptrMatrixAffineParams;
    s32 engineIndex;

#define matrixRotationNoFlip matricesRotationAndScale[NO_FLIP]
#define mtx22ParamsHFlip     matricesAffineParams[HFLIP]
#define mtx22RotHFlip        matricesRotationAndScale[HFLIP]
#define mtx22ParamsVFlip     matricesAffineParams[VFLIP]
#define mtx22RotVFlip        matricesRotationAndScale[VFLIP]
#define mtx22ParamsHVFlip    matricesAffineParams[HVFLIP]
#define mtx22RotHVFlip       matricesRotationAndScale[HVFLIP]
#define mtx22ParamsNoFlip    matricesAffineParams[NO_FLIP]

    frame                                    = GetFrameAssemblyFromAnimator(&animator->work);
    flagAffine                               = 0;
    flagFlip                                 = 0;
    animator->firstSprite[GRAPHICS_ENGINE_A] = animator->firstSprite[GRAPHICS_ENGINE_B] = NULL;
    animator->lastSprite[GRAPHICS_ENGINE_A] = animator->lastSprite[GRAPHICS_ENGINE_B] = NULL;

    if (animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW)
    {
        return;
    }
    if (frame->spriteCount == 0)
    {
        return;
    }
    if (Abs(scaleX) < MIN_SCALE_VALUE)
    {
        return;
    }
    if (Abs(scaleY) < MIN_SCALE_VALUE)
    {
        return;
    }
    if ((animator->flags & ANIMATORSPRITEDS_FLAG_DISABLE_AB) == ANIMATORSPRITEDS_FLAG_DISABLE_AB)
    {
        return;
    }
    if ((animator->work.flags & ANIMATOR_FLAG_FORCE_AFFINE) == 0)
    {
        s32 localSpriteCount = MT_MATH_MIN(frame->spriteCount, MAX_ANIMATOR_AFFINE_OAM_COUNT);
        if (((s32)(OAMSystem__GetOAMAffineOffset(GRAPHICS_ENGINE_A) + OAMSystem__GetOAMAffineCount(GRAPHICS_ENGINE_A) + localSpriteCount) >= (s32)MAX_AFFINE_OAM_COUNT)
            || ((s32)(OAMSystem__GetOAMAffineOffset(GRAPHICS_ENGINE_B) + OAMSystem__GetOAMAffineCount(GRAPHICS_ENGINE_B) + localSpriteCount) >= (s32)MAX_AFFINE_OAM_COUNT))
        {
            CallAnimatorSpriteDrawFrameForEngine__RotoZoomVariant(animator, GRAPHICS_ENGINE_A);
            CallAnimatorSpriteDrawFrameForEngine__RotoZoomVariant(animator, GRAPHICS_ENGINE_B);
            return;
        }
    }
    s32 screenDrawFlag = animator->flags & ANIMATORSPRITEDS_FLAG_DISABLE_AB;
    if (screenDrawFlag != ANIMATORSPRITEDS_FLAG_DISABLE_A)
    {
        if (screenDrawFlag == ANIMATORSPRITEDS_FLAG_DISABLE_B)
        {
            CallAnimatorSpriteDrawFrameRotoZoomForEngine(animator, GRAPHICS_ENGINE_A, scaleX, scaleY, rotation);
            return;
        }
    }
    else
    {
        CallAnimatorSpriteDrawFrameRotoZoomForEngine(animator, GRAPHICS_ENGINE_B, scaleX, scaleY, rotation);
        return;
    }

    invScaleX = FX_Inv(scaleX);
    invScaleY = FX_Inv(scaleY);
    if (rotation == 0)
    {
        if (scaleX > FLOAT_TO_FX32(0.0))
        {
            scaleX -= FLOAT_TO_FX32(0.03125);
        }
        else if (scaleX < FLOAT_TO_FX32(0.0))
        {
            scaleX += FLOAT_TO_FX32(0.03125);
        }
        if (scaleY > FLOAT_TO_FX32(0.0))
        {
            scaleY -= FLOAT_TO_FX32(0.03125);
        }
        else if (scaleY < FLOAT_TO_FX32(0.0))
        {
            scaleY += FLOAT_TO_FX32(0.03125);
        }
    }
    else
    {
        if (scaleX > FLOAT_TO_FX32(0.0))
        {
            scaleX -= FLOAT_TO_FX32(0.03515625);
        }
        else if (scaleX < FLOAT_TO_FX32(0.0))
        {
            scaleX += FLOAT_TO_FX32(0.03515625);
        }
        if (scaleY > FLOAT_TO_FX32(0.0))
        {
            scaleY -= FLOAT_TO_FX32(0.03515625);
        }
        else if (scaleY < FLOAT_TO_FX32(0.0))
        {
            scaleY += FLOAT_TO_FX32(0.03515625);
        }
    }

    MTX_Rot22(&matrixRotationNoFlip, SinFX(rotation), CosFX(rotation));
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22ParamsHFlip, -invScaleX, invScaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22RotHFlip, -scaleX, scaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22ParamsVFlip, invScaleX, -invScaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22RotVFlip, scaleX, -scaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22ParamsHVFlip, -invScaleX, -invScaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22RotHVFlip, -scaleX, -scaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &mtx22ParamsNoFlip, invScaleX, invScaleY);
    MTX_ScaleApply22(&matrixRotationNoFlip, &matrixRotationNoFlip, scaleX, scaleY);
    if ((animator->work.flags & ANIMATOR_FLAG_FLIP_X) != 0)
    {
        flagFlip |= ANIMATORSPRITE_DRAWFRAME_HFLIP;
    }
    if ((animator->work.flags & ANIMATOR_FLAG_FLIP_Y) != 0)
    {
        flagFlip |= ANIMATORSPRITE_DRAWFRAME_VFLIP;
    }
    if ((animator->work.flags & ANIMATOR_FLAG_ENABLE_MOSAIC) != 0)
    {
        flagAffine |= ANIMATORSPRITE_DRAWFRAMEROTOZOOM_MOSAIC;
    }
    if ((animator->work.flags & ANIMATOR_FLAG_ENABLE_SCALE) != 0)
    {
        flagAffine |= ANIMATORSPRITE_DRAWFRAMEROTOZOOM_SCALE;
    }
    flagAffine |= (animator->work.spriteType << SPRITE_OAM_ATTR0_MODE_SHIFT);

    paletteOffset[GRAPHICS_ENGINE_A] = animator->cParam[GRAPHICS_ENGINE_A].palette << SPRITE_OAM_ATTR2_CPARAM_SHIFT;
    paletteOffset[GRAPHICS_ENGINE_B] = animator->cParam[GRAPHICS_ENGINE_B].palette << SPRITE_OAM_ATTR2_CPARAM_SHIFT;

    currentOamAttr  = &frame->spriteList[0];
    shiftTileOffset = 0;

    if ((frame->spriteList[0].attr0 & SPRITE_OAM_ATTR0_MODE) == (SPRITE_OAM_MODE_BITMAPOBJ << SPRITE_OAM_ATTR0_MODE_SHIFT))
    {
        u32 diffA                       = animator->vramPixels[GRAPHICS_ENGINE_A] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_A];
        vramLocation[GRAPHICS_ENGINE_A] = SPRITE_OAM_ATTR2_NAME & (diffA >> (objBmpUse256K[GRAPHICS_ENGINE_A] + 7));
        u32 diffB                       = animator->vramPixels[GRAPHICS_ENGINE_B] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_B];
        vramLocation[GRAPHICS_ENGINE_B] = SPRITE_OAM_ATTR2_NAME & (diffB >> (objBmpUse256K[GRAPHICS_ENGINE_B] + 7));
        shift[GRAPHICS_ENGINE_A]        = objBmpUse256K[GRAPHICS_ENGINE_A];
        shift[GRAPHICS_ENGINE_B]        = objBmpUse256K[GRAPHICS_ENGINE_B];
    }
    else
    {
        u32 diffA                       = animator->vramPixels[GRAPHICS_ENGINE_A] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_A];
        vramLocation[GRAPHICS_ENGINE_A] = SPRITE_OAM_ATTR2_NAME & (diffA >> (objBankShift[GRAPHICS_ENGINE_A] + 5));
        u32 diffB                       = animator->vramPixels[GRAPHICS_ENGINE_B] - VRAMSystem__VRAM_OBJ[GRAPHICS_ENGINE_B];
        vramLocation[GRAPHICS_ENGINE_B] = SPRITE_OAM_ATTR2_NAME & (diffB >> (objBankShift[GRAPHICS_ENGINE_B] + 5));
        shift[GRAPHICS_ENGINE_A]        = objBankShift[GRAPHICS_ENGINE_A];
        shift[GRAPHICS_ENGINE_B]        = objBankShift[GRAPHICS_ENGINE_B];
        if (GetAnimHeaderBlockFromAnimator(&animator->work)->anims[animator->work.animID].format != BAC_FORMAT_PLTT16_2D)
        {
            shiftTileOffset = 1;
        }
    }

    shiftMask[GRAPHICS_ENGINE_A] = (u16)((1 << shift[GRAPHICS_ENGINE_A]) - 1);
    shiftMask[GRAPHICS_ENGINE_B] = (u16)((1 << shift[GRAPHICS_ENGINE_B]) - 1);

    for (i = 0; i < frame->spriteCount; i++, currentOamAttr++)
    {
        ARRAY_COPY(cacheAffineSpriteIndicesInitialValues, initValuesCacheAffineSpriteIndicesDSRotoZoom);
        hvFlipBits = (flagFlip & SPRITE_OAM_ATTR1_FLIP) >> SPRITE_OAM_ATTR1_FLIP_X_SHIFT;

        ARRAY_COPY(cacheAffineSpriteIndicesBothEngines, cacheAffineSpriteIndicesInitialValues);

        u32 shape =
            ((currentOamAttr->attr0 & SPRITE_OAM_ATTR0_SHAPE) >> SPRITE_OAM_ATTR0_MOSAIC_SHIFT) | ((currentOamAttr->attr1 & SPRITE_OAM_ATTR1_SIZE) >> SPRITE_OAM_ATTR1_SIZE_SHIFT);

        sprite2DSize.i       = ((Vec2DOrInt const *)(&spriteShapeSizes2D[shape]))->i;
        u32 *ptrSprite2DSize = &sprite2DSize.i;

        u16 finalFlipsCurrentOAM         = flagFlip ^ currentOamAttr->attr1;
        mtx22AffineParamsIndexCurrentOAM = (finalFlipsCurrentOAM & SPRITE_OAM_ATTR1_FLIP) >> SPRITE_OAM_ATTR1_FLIP_X_SHIFT;

        s32 framePieceCenterXNonRotated = OamGetSignedX(currentOamAttr) - frame->center.x + (sprite2DSize.v.x >> 1);
        s32 framePieceCenterYNonRotated = OamGetSignedY(currentOamAttr) - frame->center.y + (sprite2DSize.v.y >> 1);

        fx32 cosRotByXScale      = matricesRotationAndScale[hvFlipBits].a[0];
        fx32 minusSinRotByYScale = matricesRotationAndScale[hvFlipBits].a[2];
        baseX                    = -(sprite2DSize.v.x >> 1) + FX32_TO_WHOLE((framePieceCenterXNonRotated * cosRotByXScale) + (framePieceCenterYNonRotated * minusSinRotByYScale));

        fx32 sinRotByXScale = matricesRotationAndScale[hvFlipBits].a[1];
        fx32 cosYScale      = matricesRotationAndScale[hvFlipBits].a[3];
        baseY               = -(sprite2DSize.v.y >> 1) + FX32_TO_WHOLE((framePieceCenterXNonRotated * sinRotByXScale) + (framePieceCenterYNonRotated * cosYScale));

        if ((flagAffine & ANIMATORSPRITE_DRAWFRAMEROTOZOOM_SCALE) != 0)
        {
            baseX -= (sprite2DSize.v.x >> 1);
            baseY -= (sprite2DSize.v.y >> 1);
            *ptrSprite2DSize = sprite2DSize.i << 1;
        }
        ptrMatrixAffineParams            = &matricesAffineParams[mtx22AffineParamsIndexCurrentOAM];
        ptrArrayCacheAffineSpriteIndices = &cacheAffineSpriteIndicesBothEngines[mtx22AffineParamsIndexCurrentOAM];
        for (engineIndex = 0; engineIndex < GRAPHICS_ENGINE_COUNT; engineIndex++)
        {
            xOAMEngine = baseX + animator->position[engineIndex].x;
            yOAMEngine = baseY + animator->position[engineIndex].y;
            if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK) && !SpriteDrawBoundsCheck(&sprite2DSize.v, xOAMEngine, yOAMEngine))
            {
                if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                {
                    vramLocation[engineIndex] += ((formatShapeTileCount[shape] + shiftMask[engineIndex]) >> shift[engineIndex]) << shiftTileOffset;
                }
            }
            else
            {
                affineSpriteIndex = ptrArrayCacheAffineSpriteIndices[engineIndex * FLIP_VARIANT_COUNT];
                BOOL addAffineOAMSuccess;
                do
                {
                    if (affineSpriteIndex < 0)
                    {
                        affineSpriteIndex                                                  = OAMSystem__AddAffineSprite(engineIndex, ptrMatrixAffineParams);
                        ptrArrayCacheAffineSpriteIndices[engineIndex * FLIP_VARIANT_COUNT] = affineSpriteIndex;
                        if (affineSpriteIndex < 0)
                        {
                            addAffineOAMSuccess = FALSE;
                            break;
                        }
                        GXOamAffine *res = (GXOamAffine *)OAMSystem__GetList1(engineIndex);
                        res += affineSpriteIndex;
                        G2_SetOBJAffine(res, &matricesAffineParams[mtx22AffineParamsIndexCurrentOAM]);
                    }
                    addAffineOAMSuccess = TRUE;

                } while (FALSE);

                if (!addAffineOAMSuccess)
                {
                    if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                    {
                        vramLocation[engineIndex] += ((formatShapeTileCount[shape] + shiftMask[engineIndex]) >> shift[engineIndex]) << shiftTileOffset;
                    }
                }
                else
                {
                    GXOamAttr *res = OAMSystem__Alloc(engineIndex, animator->work.oamOrder);
                    if (&oamDefault == res)
                    {
                        return;
                    }
                    GXOamAttr *firstSprite            = animator->firstSprite[engineIndex];
                    animator->lastSprite[engineIndex] = res;
                    if (firstSprite == NULL)
                    {
                        animator->firstSprite[engineIndex] = res;
                    }

                    u32 xOAMMasked = xOAMEngine & SPRITE_OAM_ATTR1_X;
                    res->attr0     = (currentOamAttr->attr0 & (ATTR0_MASK_NOT_Y)) | (yOAMEngine & SPRITE_OAM_ATTR0_Y) | SPRITE_OAM_EFFECT_AFFINE;
                    res->attr0 |= flagAffine;
                    res->attr1 = (currentOamAttr->attr1 & (ATTR1_MASK_NOT_X)) | xOAMMasked;
                    res->attr1 = (res->attr1 & ~SPRITE_OAM_ATTR1_RSPARAM) | (affineSpriteIndex << SPRITE_OAM_ATTR1_AFFINE_SHIFT);
                    if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
                    {
                        u32 tileOffsetAndOamPriority = (vramLocation[engineIndex] & SPRITE_OAM_ATTR2_NAME) | (animator->work.oamPriority << SPRITE_OAM_ATTR2_PRIORITY_SHIFT);
                        u32 colorParam               = (currentOamAttr->attr2 + paletteOffset[engineIndex]) & SPRITE_OAM_ATTR2_CPARAM;
                        res->attr2                   = tileOffsetAndOamPriority | colorParam;
                        vramLocation[engineIndex] += ((u32)(formatShapeTileCount[shape] + shiftMask[engineIndex]) >> shift[engineIndex]) << shiftTileOffset;
                    }
                    else
                    {
                        res->attr2 = ((currentOamAttr->attr2 + vramLocation[engineIndex]) & SPRITE_OAM_ATTR2_NAME) | (animator->work.oamPriority << SPRITE_OAM_ATTR2_PRIORITY_SHIFT)
                                     | ((currentOamAttr->attr2 + paletteOffset[engineIndex]) & SPRITE_OAM_ATTR2_CPARAM);
                    }
                }
            }
        }
    }
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
	ldr r5, =initValuesCacheAffineSpriteIndicesDSRotoZoom
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
	ldr r0, =formatShapeTileCount
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
    MI_CpuClear16(&spriteUnknown, sizeof(spriteUnknown));
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

    MTX_Identity33(animator->work.rotation.nnMtx);
    MTX_Identity43(animator->work.matrix43.nnMtx);

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

    MTX_Identity33(animator->work.rotation.nnMtx);
    MTX_Identity43(animator->work.matrix43.nnMtx);

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

    MTX_Identity33(animator->work.rotation.nnMtx);
    MTX_Identity43(animator->work.matrix43.nnMtx);

    AnimatorSprite__Init(&animator->animatorSprite, fileData, animID, flags, 0, PIXEL_MODE_TEXTURE, vramPixels, PALETTE_MODE_TEXTURE, vramPalette, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);

    animator->polygonAttr.polygonMode = GX_POLYGONMODE_MODULATE;
    animator->polygonAttr.noCullBack  = TRUE;
    animator->polygonAttr.noCullFront = TRUE;
    animator->polygonAttr.alpha       = GX_COLOR_FROM_888(0xFF);

    animator->field_F8.unknown = 0x7FFF;
    animator->field_F8.flag    = 1;

    animator->field_FC.unknown = 0x7FFF;

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

void AnimatorSprite3D__Draw(AnimatorSprite3D *animator)
{
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

    frame      = GetFrameAssemblyFromAnimator(&animator->animatorSprite);
    int format = GetAnimHeaderBlockFromAnimator(&animator->animatorSprite)->anims[animator->animatorSprite.animID].format;

    u16 flipFlags = 0;

    if (!Sprite__Is3DFormat(&animator->animatorSprite))
        return;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_DISABLE_DRAW) != 0)
        return;

    if (frame->spriteCount == 0)
        return;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_FLIP_X) != 0)
        flipFlags |= SPRITE_OAM_ATTR1_FLIP_X;

    if ((animator->animatorSprite.flags & ANIMATOR_FLAG_FLIP_Y) != 0)
        flipFlags |= SPRITE_OAM_ATTR1_FLIP_Y;

    sprite      = frame->spriteList;
    tileDataPos = VRAMKEY_TO_KEY(animator->animatorSprite.vramPixels) & 0x7FFFF;

    FXMatrix43 matTranslate;
    FXMatrix43 matTexture;
    MTX_Identity43(matTranslate.nnMtx);
    MTX_Identity43(matTexture.nnMtx);

    // direct buffer because we use 'animator->polygonAttr' instead of function params
    NNS_G3dGeBufferOP_N(G3OP_POLYGON_ATTR, &animator->polygonAttr.value, G3OP_POLYGON_ATTR_NPARAMS);
    NNS_G3dGeColor(animator->color);

    u32 paletteAddr = (VRAMKEY_TO_KEY(GetSprite3DPaletteVRAM(animator)) & 0x1FFFF) + (animator->animatorSprite.cParam.palette * (16 * sizeof(GXRgb)));
    NNS_G3dGeTexPlttBase(paletteAddr, gxFormatForSpriteFormat[format]);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);

    VecFx32 scale;
    scale.x = FLOAT_TO_FX32(1.0);
    scale.y = -FLOAT_TO_FX32(1.0);
    scale.z = FLOAT_TO_FX32(1.0);
    NNS_G3dGeScaleVec(&scale);

    NNS_G3dGeBegin(GX_BEGIN_QUADS);
    for (s = 0; s < frame->spriteCount; s++, sprite++)
    {
        u32 shape = ((sprite->attr0 & SPRITE_OAM_ATTR0_SHAPE) >> SPRITE_OAM_ATTR0_MOSAIC_SHIFT) | ((sprite->attr1 & SPRITE_OAM_ATTR1_SIZE) >> SPRITE_OAM_ATTR1_SIZE_SHIFT);
        const Vec2U16 *size = &spriteShapeSizes2D[shape];

#define OAM_X ((s16)(((u32)sprite->attr1 << 22) >> 16) >> 6)
#define OAM_Y ((s16)(((u32)sprite->attr0 << 23) >> 16) >> 7)

        if (flipFlags & SPRITE_OAM_ATTR1_FLIP_X)
        {
            matTranslate.translation.x = FX32_FROM_WHOLE(frame->center.x - OAM_X - size->x);
        }
        else
        {
            matTranslate.translation.x = FX32_FROM_WHOLE(-frame->center.x + OAM_X);
        }

        if (flipFlags & SPRITE_OAM_ATTR1_FLIP_Y)
        {
            matTranslate.translation.y = FX32_FROM_WHOLE(frame->center.y - OAM_Y - size->y);
        }
        else
        {
            matTranslate.translation.y = FX32_FROM_WHOLE(-frame->center.y + OAM_Y);
        }

#undef OAM_X
#undef OAM_Y

        if (flipFlags & SPRITE_OAM_ATTR1_FLIP_X)
        {
            matTexture.translation.x = FX32_FROM_WHOLE((size->x - 1) << 4);
            matTexture.m[0][0]       = FX32_FROM_WHOLE(-size->x);
        }
        else
        {
            matTexture.translation.x = FLOAT_TO_FX32(0.0);
            matTexture.m[0][0]       = FX32_FROM_WHOLE(size->x);
        }

        if (flipFlags & SPRITE_OAM_ATTR1_FLIP_Y)
        {
            matTexture.translation.y = (FX32_FROM_WHOLE(size->y - 1) << 4);
            matTexture.m[1][1]       = FX32_FROM_WHOLE(-size->y);
        }
        else
        {
            matTexture.translation.y = FLOAT_TO_FX32(0.0);
            matTexture.m[1][1]       = FX32_FROM_WHOLE(size->y);
        }

        matTranslate.m[0][0] = FX32_FROM_WHOLE(size->x);
        matTranslate.m[1][1] = FX32_FROM_WHOLE(size->y);

        if ((frame->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) == 0)
        {
            pixelAddr = tileDataPos;
            tileDataPos += formatShapeTileCount[shape] << pixelFormatShift[format];
        }
        else
        {
            pixelAddr = tileDataPos + ((sprite->attr2 & SPRITE_OAM_ATTR2_NAME) << pixelFormatShift[format]);
        }

        NNS_G3dGeTexImageParam(gxFormatForSpriteFormat[format], GX_TEXGEN_TEXCOORD, (GXTexSizeS)spriteShapeSizes3D[2 * shape], (GXTexSizeT)spriteShapeSizes3D[(2 * shape) + 1],
                               GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS, pixelAddr);

        NNS_G3dGeMtxMode(GX_MTXMODE_TEXTURE);
        NNS_G3dGeLoadMtx43(matTexture.nnMtx);

        NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
        NNS_G3dGePushMtx();
        NNS_G3dGeMultMtx43(matTranslate.nnMtx);
        NNS_G3dGeSendDL(drawListSprite3D, sizeof(drawListSprite3D));
        NNS_G3dGePopMtx(1);
    }
    NNS_G3dGeEnd();
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
        case BAC_FORMAT_PLTT4_3D:
        case BAC_FORMAT_PLTT16_3D:
        case BAC_FORMAT_PLTT256_3D:
        case BAC_FORMAT_DIRECT_3D:
        case BAC_FORMAT_A3I5_3D:
        case BAC_FORMAT_A5I3_3D:
        case BAC_FORMAT_COMP4x4_3D:
            return TRUE;

        default:
            return FALSE;
    }
}

// Animation Helpers
RUSH_INLINE BOOL AnimatorCantLoop(AnimatorSprite *animator)
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
        if ((animator->flags & (1 << i)) == 0)
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

    if ((GetFrameAssemblyFromAnimator(animator)->flags & BAC_FRAME_FLAG_NO_TILE_ADVANCE) != 0)
        animator->flags |= ANIMATOR_FLAG_USE_GFX_INDEX;
    else
        animator->flags &= ~ANIMATOR_FLAG_USE_GFX_INDEX;

    animator->animSequenceOffset += block->header.blockSize;
    return FRAME_CONTINUE;
}

s32 BAC_FrameGroupFunc_SpriteParts(BACFrameGroupBlock_SpriteParts *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
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
                if ((GetFrameAssemblyFromAnimator(animator)->spriteList[0].attr0 & SPRITE_OAM_ATTR0_MODE) == (GX_OAM_MODE_BITMAPOBJ << SPRITE_OAM_ATTR0_MODE_SHIFT))
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
}

NONMATCH_FUNC s32 BAC_FrameGroupFunc_Palette(BACFrameGroupBlock_Palette *block, AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    // https://decomp.me/scratch/WXns6 -> 99.67%
    // register mismatch inside GetPaletteBlock()
#ifdef NON_MATCHING
    typedef void (*PaletteFunc)(void *srcPalettePtr, u16 colorCount, PaletteMode mode, size_t dstPalettePtr);
    UNUSED(callback);
    UNUSED(userData);

    AnimatorFlags *aniFlags;

    aniFlags = &animator->flags;
    if ((animator->flags & ANIMATOR_FLAG_DISABLE_PALETTES) == 0)
    {
        struct BACPaletteBlock *paletteData = GetPaletteBlock(animator->fileData, block->paletteOffset);
        s32 aniPaletteOffset                = animator->paletteOffset;

        PaletteFunc paletteFunc = ((*aniFlags) & ANIMATOR_FLAG_UNCOMPRESSED_PALETTES) ? LoadUncompressedPalette : QueueUncompressedPalette;

        u16 *srcPalettePtr = &paletteData->colors[aniPaletteOffset];

        u16 colorCount = animator->colorCount;
        u16 *destPalettePtr;
        switch (animator->paletteMode)
        {
            case PALETTE_MODE_SPRITE: {
                destPalettePtr = &((u16 *)animator->vramPalette)[16 * block->colorCount + 16 * animator->cParam.palette];
                break;
            }

            case PALETTE_MODE_OBJ:
            case PALETTE_MODE_SUB_OBJ: {
                destPalettePtr = &((u16 *)animator->vramPalette)[256 * (block->colorCount + animator->cParam.palette)];
                break;
            }

            default: {
                destPalettePtr = &((u16 *)animator->vramPalette)[16 * block->colorCount];
                break;
            }
        }

        if (colorCount == 0)
            colorCount = formatPaletteColorCount[Sprite__GetFormatFromAnim(animator->fileData, animator->animID)];

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
	ldr r1, =formatPaletteColorCount
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
    NNS_G3dGlbSetBaseRot(animator->rotation.nnMtx);
    NNS_G3dGlbSetBaseTrans(&animator->translation);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);

    for (s32 i = 0; i < ANIMATOR3D_MATRIXOP_COUNT && animator->matrixOpIDs[i] != MATRIX_OP_NONE; i++)
    {
        animator3DDrawCommandList[animator->matrixOpIDs[i]](animator);
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
    FXMatrix43 matrix;

    MTX_Copy33To43(animator->rotation.nnMtx, matrix.nnMtx);
    NNS_G3dGeLoadMtx43(matrix.nnMtx);
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
    NNS_G3dGeLoadMtx43(animator->mtxRotTranslate.nnMtx);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_IdentityRotateTranslate2Scale(Animator3D *animator)
{
    NNS_G3dGeLoadMtx43(animator->mtxRotTranslate.nnMtx);
    NNS_G3dGeTranslateVec(&animator->translation2);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_LoadMtx43(Animator3D *animator)
{
    NNS_G3dGeLoadMtx43(animator->matrix43.nnMtx);
}

void Animator3D__MatrixOp_LoadCameraMtx43(Animator3D *animator)
{
    FXMatrix43 matrix;
    Camera3D__CopyMatrix4x3((const FXMatrix43 *)NNS_G3dGlbGetCameraMtx(), &matrix.mtx33);

    matrix.translation.x = matrix.translation.y = matrix.translation.z = FLOAT_TO_FX32(0.0);

    NNS_G3dGeLoadMtx43(matrix.nnMtx);
}

void Animator3D__MatrixOp_LoadCameraMtx33(Animator3D *animator)
{
    FXMatrix43 matrix;
    Camera3D__CopyMatrix3x3((const FXMatrix43 *)NNS_G3dGlbGetCameraMtx(), &matrix.mtx33);

    matrix.translation.x = matrix.translation.y = matrix.translation.z = FLOAT_TO_FX32(0.0);

    NNS_G3dGeLoadMtx43(matrix.nnMtx);
}

void Animator3D__MatrixOp_Scale(Animator3D *animator)
{
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_Rotate(Animator3D *animator)
{
    NNS_G3dGeMultMtx33(animator->rotation.nnMtx);
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
    NNS_G3dGeMultMtx43(animator->mtxRotTranslate.nnMtx);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_RotateTranslate2Scale(Animator3D *animator)
{
    NNS_G3dGeMultMtx43(animator->mtxRotTranslate.nnMtx);
    NNS_G3dGeTranslateVec(&animator->translation2);
    NNS_G3dGeScaleVec(&animator->scale);
}

void Animator3D__MatrixOp_MultMtx43(Animator3D *animator)
{
    NNS_G3dGeMultMtx43(animator->matrix43.nnMtx);
}

void Animator3D__MatrixOp_MultCameraMtx43(Animator3D *animator)
{
    FXMatrix33 matrix;
    Camera3D__CopyMatrix4x3((const FXMatrix43 *)NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGeMultMtx33(matrix.nnMtx);
}

void Animator3D__MatrixOp_MultCameraMtx33(Animator3D *animator)
{
    FXMatrix33 matrix;
    Camera3D__CopyMatrix3x3((const FXMatrix43 *)NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGeMultMtx33(matrix.nnMtx);
}

void Animator3D__MatrixOp_SetCameraRot4x3(Animator3D *animator)
{
    FXMatrix33 matrix;
    Camera3D__CopyMatrix4x3((const FXMatrix43 *)NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGlbSetBaseRot(matrix.nnMtx);
}

void Animator3D__MatrixOp_SetCameraRot3x3(Animator3D *animator)
{
    FXMatrix33 matrix;
    Camera3D__CopyMatrix3x3((const FXMatrix43 *)NNS_G3dGlbGetCameraMtx(), &matrix);
    NNS_G3dGlbSetBaseRot(matrix.nnMtx);
}

void Animator3D__MatrixOp_Callback(Animator3D *animator)
{
    animator->matrixCallback(animator);
}
