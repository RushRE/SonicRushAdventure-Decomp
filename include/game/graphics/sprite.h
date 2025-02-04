#ifndef RUSH_ANIMATORSPRITE_H
#define RUSH_ANIMATORSPRITE_H

#include <global.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/graphics/vramSystem.h>
#include <game/math/mtMath.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define ANIMATOR3D_MATRIXOP_COUNT 8

// --------------------
// TYPES
// --------------------

typedef struct BACFrameGroupBlockHeader_ BACFrameGroupBlockHeader;
typedef struct AnimatorSprite_ AnimatorSprite;

typedef void (*SpriteFrameCallback)(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData);

// --------------------
// ENUMS
// --------------------

enum AnimatorFlags_
{
    ANIMATOR_FLAG_NONE = 0,

    ANIMATOR_FLAG_DISABLE_DRAW                = 0x1,
    ANIMATOR_FLAG_DID_LOOP                    = 0x2,
    ANIMATOR_FLAG_DISABLE_LOOPING             = 0x4,
    ANIMATOR_FLAG_DISABLE_SPRITE_PARTS        = 0x8,
    ANIMATOR_FLAG_DISABLE_PALETTES            = 0x10,
    ANIMATOR_FLAG_UNCOMPRESSED_PIXELS         = 0x20,
    ANIMATOR_FLAG_UNCOMPRESSED_PALETTES       = 0x40,
    ANIMATOR_FLAG_FLIP_X                      = 0x80,
    ANIMATOR_FLAG_FLIP_Y                      = 0x100,
    ANIMATOR_FLAG_ENABLE_SCALE                = 0x200,
    ANIMATOR_FLAG_ENABLE_MOSAIC               = 0x400,
    ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK = 0x800,
    ANIMATOR_FLAG_FORCE_AFFINE                = 0x1000,
    ANIMATOR_FLAG_USE_FRAME_REMAINDER         = 0x2000,
    ANIMATOR_FLAG_UNKNOWN_14                  = 0x4000,
    ANIMATOR_FLAG_UNKNOWN_15                  = 0x8000,
    ANIMATOR_FLAG_UNKNOWN_16                  = 0x10000,
    ANIMATOR_FLAG_UNKNOWN_17                  = 0x20000,
    ANIMATOR_FLAG_UNKNOWN_18                  = 0x40000,
    ANIMATOR_FLAG_UNKNOWN_19                  = 0x80000,
    ANIMATOR_FLAG_UNKNOWN_20                  = 0x100000,
    ANIMATOR_FLAG_UNKNOWN_21                  = 0x200000,
    ANIMATOR_FLAG_UNKNOWN_22                  = 0x400000,
    ANIMATOR_FLAG_UNKNOWN_23                  = 0x800000,
    ANIMATOR_FLAG_UNKNOWN_24                  = 0x1000000,
    ANIMATOR_FLAG_UNKNOWN_25                  = 0x2000000,
    ANIMATOR_FLAG_UNKNOWN_26                  = 0x4000000,
    ANIMATOR_FLAG_UNKNOWN_27                  = 0x8000000,
    ANIMATOR_FLAG_UNKNOWN_28                  = 0x10000000,
    ANIMATOR_FLAG_UNKNOWN_29                  = 0x20000000,
    ANIMATOR_FLAG_DID_FINISH                  = 0x40000000,
    ANIMATOR_FLAG_USE_GFX_INDEX               = 0x80000000,
};
typedef u32 AnimatorFlags;

enum AnimatorMDLFlags_
{
    ANIMATORMDL_FLAG_NONE = 0,

    ANIMATORMDL_FLAG_STOPPED          = 1 << 0,
    ANIMATORMDL_FLAG_CAN_LOOP         = 1 << 1,
    ANIMATORMDL_FLAG_BLEND_ANIMATIONS = 1 << 2,
    ANIMATORMDL_FLAG_3                = 1 << 3,
    ANIMATORMDL_FLAG_4                = 1 << 4,
    ANIMATORMDL_FLAG_5                = 1 << 5,
    ANIMATORMDL_FLAG_6                = 1 << 6,
    ANIMATORMDL_FLAG_7                = 1 << 7,
    ANIMATORMDL_FLAG_8                = 1 << 8,
    ANIMATORMDL_FLAG_9                = 1 << 9,
    ANIMATORMDL_FLAG_10               = 1 << 10,
    ANIMATORMDL_FLAG_11               = 1 << 11,
    ANIMATORMDL_FLAG_12               = 1 << 12,
    ANIMATORMDL_FLAG_13               = 1 << 13,
    ANIMATORMDL_FLAG_BLENDING_PAUSED  = 1 << 14,
    ANIMATORMDL_FLAG_FINISHED         = 1 << 15,
};
typedef u16 AnimatorMDLFlags;

enum BACAnimFormat_
{
    BAC_FORMAT_INDEXED4_2D,
    BAC_FORMAT_INDEXED8_2D,
    BAC_FORMAT_RGBA_2D,
    BAC_FORMAT_INDEXED2_3D,
    BAC_FORMAT_INDEXED4_3D,
    BAC_FORMAT_INDEXED8_3D,
    BAC_FORMAT_RGBA_3D,
    BAC_FORMAT_A3I5_TRANSLUCENT_3D,
    BAC_FORMAT_A5I3_TRANSLUCENT_3D,
    BAC_FORMAT_BLOCK_COMPRESSED_3D,

    BAC_FORMAT_COUNT,
};
typedef u16 BACAnimFormat;

enum SpriteBlockIDs
{
    // block types
    SPRITE_BLOCK_END_FRAME,
    SPRITE_BLOCK_SPRITE_MAPPINGS,
    SPRITE_BLOCK_SPRITE_GRAPHICS,
    SPRITE_BLOCK_SPRITE_PALETTE,
    SPRITE_BLOCK_END_ANIMATION,
    SPRITE_BLOCK_UNUSED1,
    SPRITE_BLOCK_CALLBACK1,
    SPRITE_BLOCK_CALLBACK2,
    SPRITE_BLOCK_CALLBACK3,
    SPRITE_BLOCK_END_ANIMATION_CHANGE_ANIM,
    SPRITE_BLOCK_UNUSED2,
    SPRITE_BLOCK_UNUSED3,

    // how many block types there are
    SPRITE_BLOCK_COUNT,

    // All rush games assign the callback2 block to hitboxes
    SPRITE_BLOCK_HITBOX = SPRITE_BLOCK_CALLBACK2,
};

enum ScreenDrawFlags_
{
    SCREEN_DRAW_NONE = 0,

    SCREEN_DRAW_A = 1 << 0,
    SCREEN_DRAW_B = 1 << 1,
    SCREEN_DRAW_2 = 1 << 2, // Functionality unknown
    SCREEN_DRAW_3 = 1 << 3, // Functionality unknown
    SCREEN_DRAW_4 = 1 << 4, // Functionality unknown

    SCREEN_DRAW_AB = SCREEN_DRAW_A | SCREEN_DRAW_B,
};
typedef u32 ScreenDrawFlags;

enum MatrixOpTypes_
{
    MATRIX_OP_NONE,
    MATRIX_OP_IDENTITY,
    MATRIX_OP_RESTORE_MTX,
    MATRIX_OP_FLUSH_P,
    MATRIX_OP_FLUSH_VP,
    MATRIX_OP_FLUSH_WVP,
    MATRIX_OP_SET_MATRIX_MODE,
    MATRIX_OP_FLUSH_P_CAMERA3D,
    MATRIX_OP_FLUSH_VP_CAMERA3D,
    MATRIX_OP_FLUSH_WVP_CAMERA3D,
    MATRIX_OP_IDENTITY_SCALE,
    MATRIX_OP_COPY_MTX33_TO_43,
    MATRIX_OP_IDENTITY_TRANSLATE,
    MATRIX_OP_IDENTITY_TRANSLATE2,
    MATRIX_OP_LOAD_MTX43_SCALE_VEC,
    MATRIX_OP_LOAD_MTX43_TRANSLATE_SCALE_VEC,
    MATRIX_OP_LOAD_MTX43,
    MATRIX_OP_LOAD_CAMERA_MTX43,
    MATRIX_OP_LOAD_CAMERA_MTX33,
    MATRIX_OP_SCALE_VEC,
    MATRIX_OP_MULT_MTX_33,
    MATRIX_OP_TRANSLATE_VEC,
    MATRIX_OP_TRANSLATE_VEC2,
    MATRIX_OP_MULT_MTX43_SCALE_VEC,
    MATRIX_OP_MULT_MTX43_TRANSLATE_SCALE_VEC,
    MATRIX_OP_MULT_MTX43,
    MATRIX_OP_MULT_CAMERA_MTX43,
    MATRIX_OP_MULT_CAMERA_MTX33,
    MATRIX_OP_SET_CAMERA_ROT_43,
    MATRIX_OP_SET_CAMERA_ROT_33,
    MATRIX_OP_CALLBACK,
};
typedef u8 MatrixOpTypes;

enum Animator2DTypes_
{
    ANIMATOR2D_NONE,
    ANIMATOR2D_SPRITE,
    ANIMATOR2D_SPRITE_DS,
};
typedef u32 Animator2DTypes;

enum Animator3DTypes_
{
    ANIMATOR3D_NONE,
    ANIMATOR3D_MODEL,
    ANIMATOR3D_SHAPE,
    ANIMATOR3D_SPRITE,
};
typedef u32 Animator3DTypes;

enum B3DAnimationTypes_
{
    B3D_ANIM_JOINT_ANIM,
    B3D_ANIM_MAT_ANIM,
    B3D_ANIM_PAT_ANIM,
    B3D_ANIM_TEX_ANIM,
    B3D_ANIM_VIS_ANIM,

    B3D_ANIM_MAX,
};
typedef u32 B3DAnimationTypes;

enum B3DAnimationFlags_
{
    B3D_ANIM_FLAG_JOINT_ANIM = 1 << B3D_ANIM_JOINT_ANIM,
    B3D_ANIM_FLAG_MAT_ANIM   = 1 << B3D_ANIM_MAT_ANIM,
    B3D_ANIM_FLAG_PAT_ANIM   = 1 << B3D_ANIM_PAT_ANIM,
    B3D_ANIM_FLAG_TEX_ANIM   = 1 << B3D_ANIM_TEX_ANIM,
    B3D_ANIM_FLAG_VIS_ANIM   = 1 << B3D_ANIM_VIS_ANIM,
};
typedef u32 B3DAnimationFlags;

enum B3DResourceTypes_
{
    // because model is index 0, we offset all anim ids by 1!
    B3D_ANIM_RESOURCE_OFFSET = 1,

    B3D_RESOURCE_MODEL = 0,

    B3D_RESOURCE_JOINT_ANIM = B3D_ANIM_RESOURCE_OFFSET + B3D_ANIM_JOINT_ANIM,
    B3D_RESOURCE_MAT_ANIM   = B3D_ANIM_RESOURCE_OFFSET + B3D_ANIM_MAT_ANIM,
    B3D_RESOURCE_PAT_ANIM   = B3D_ANIM_RESOURCE_OFFSET + B3D_ANIM_PAT_ANIM,
    B3D_RESOURCE_TEX_ANIM   = B3D_ANIM_RESOURCE_OFFSET + B3D_ANIM_TEX_ANIM,
    B3D_RESOURCE_VIS_ANIM   = B3D_ANIM_RESOURCE_OFFSET + B3D_ANIM_VIS_ANIM,

    B3D_RESOURCE_MAX,
};
typedef u32 B3DResourceTypes;

enum B3DResourceFlags_
{
    B3D_RESOURCE_FLAG_MODEL      = 1 << B3D_RESOURCE_MODEL,
    B3D_RESOURCE_FLAG_JOINT_ANIM = 1 << B3D_RESOURCE_JOINT_ANIM,
    B3D_RESOURCE_FLAG_MAT_ANIM   = 1 << B3D_RESOURCE_MAT_ANIM,
    B3D_RESOURCE_FLAG_PAT_ANIM   = 1 << B3D_RESOURCE_PAT_ANIM,
    B3D_RESOURCE_FLAG_TEX_ANIM   = 1 << B3D_RESOURCE_TEX_ANIM,
    B3D_RESOURCE_FLAG_VIS_ANIM   = 1 << B3D_RESOURCE_VIS_ANIM,
};
typedef u32 B3DResourceFlags;

enum SpritePriority_
{
    SPRITE_PRIORITY_0,
    SPRITE_PRIORITY_1,
    SPRITE_PRIORITY_2,
    SPRITE_PRIORITY_3,
};
typedef u8 SpritePriority;

enum SpriteOrder_
{
    SPRITE_ORDER_0,
    SPRITE_ORDER_1,
    SPRITE_ORDER_2,
    SPRITE_ORDER_3,
    SPRITE_ORDER_4,
    SPRITE_ORDER_5,
    SPRITE_ORDER_6,
    SPRITE_ORDER_7,
    SPRITE_ORDER_8,
    SPRITE_ORDER_9,
    SPRITE_ORDER_10,
    SPRITE_ORDER_11,
    SPRITE_ORDER_12,
    SPRITE_ORDER_13,
    SPRITE_ORDER_14,
    SPRITE_ORDER_15,
    SPRITE_ORDER_16,
    SPRITE_ORDER_17,
    SPRITE_ORDER_18,
    SPRITE_ORDER_19,
    SPRITE_ORDER_20,
    SPRITE_ORDER_21,
    SPRITE_ORDER_22,
    SPRITE_ORDER_23,
    SPRITE_ORDER_24,
    SPRITE_ORDER_25,
    SPRITE_ORDER_26,
    SPRITE_ORDER_27,
    SPRITE_ORDER_28,
    SPRITE_ORDER_29,
    SPRITE_ORDER_30,
    SPRITE_ORDER_31,
};
typedef u8 SpriteOrder;

// --------------------
// STRUCTS
// --------------------

// TODO: probably move this to collision area?
typedef struct HitboxRect_
{
    s16 left;
    s16 top;
    s16 right;
    s16 bottom;
} HitboxRect;

struct BACFrameGroupBlockHeader_
{
    u16 blockID;
    u16 blockSize;
};

typedef struct BACFrameGroupBlock_Hitbox_
{
    BACFrameGroupBlockHeader header;

    u16 id;
    u16 unused;
    HitboxRect hitbox;
} BACFrameGroupBlock_Hitbox;

struct AnimatorSprite_
{
    Animator2DTypes type;
    u32 useEngineB;
    Vec2Fx16 pos;
    u16 animID;
    u16 animFrameIndex;
    u16 animFrameCount;
    u8 *fileData;
    u8 *animHeaders;
    u8 *frameAssembly;
    u8 *animSequences;
    u32 animSequenceOffset;
    u32 prevAnimSequenceOffset;
    u32 assemblyOffset;
    u32 frameTimer;
    fx32 frameRemainder;
    fx32 animAdvance;
    AnimatorFlags flags;
    PixelMode pixelMode;
    VRAMPixelKey vramPixels;
    PaletteMode paletteMode;
    VRAMPaletteKey vramPalette;

    union CParam
    {
        u16 palette;
        u16 alpha;
    } cParam;

    u16 paletteOffset;
    u16 colorCount;
    SpritePriority oamPriority;
    SpriteOrder oamOrder;
    GXOamMode spriteType;
    GXOamAttr *firstSprite;
    GXOamAttr *lastSprite;
};

typedef struct AnimatorSpriteDS_
{
    AnimatorSprite work;

    ScreenDrawFlags screensToDraw;
    Vec2Fx16 position[2];
    PixelMode pixelMode[2];
    VRAMPixelKey vramPixels[2];
    PaletteMode paletteMode[2];
    VRAMPaletteKey vramPalette[2];

    union
    {
        u16 palette;
        u16 alpha;
    } cParam[2];

    GXOamAttr *firstSprite[2];
    GXOamAttr *lastSprite[2];
} AnimatorSpriteDS;

typedef struct Animator3D_
{
    Animator3DTypes type;
    AnimatorFlags flags;
    u16 field_8;
    MatrixOpTypes matrixOpIDs[ANIMATOR3D_MATRIXOP_COUNT];
    void (*matrixCallback)(struct Animator3D_ *animator);
    VecFx32 scale;
    MtxFx33 matrix33;
    VecFx32 translation;
    VecFx32 translation2;
    MtxFx43 matrix43;
} Animator3D;

typedef struct AnimatorMDL_
{
    Animator3D work;

    NNSG3dRenderObj renderObj;
    NNSG3dAnmObj *currentAnimObj[B3D_ANIM_MAX];
    NNSG3dAnmObj *prevAnimObj[B3D_ANIM_MAX];
    AnimatorMDLFlags animFlags[B3D_ANIM_MAX];
    fx32 speedMultiplier;
    fx32 speed[B3D_ANIM_MAX];
    s16 ratioMultiplier;
    s16 ratio[B3D_ANIM_MAX];
    NNSG3dJntAnmResult *jntAnimResult;
    NNSG3dMatAnmResult *matAnimResult;
} AnimatorMDL;

typedef struct AnimatorShape3D_
{
    Animator3D work;

    NNSG3dResMdl *pResMdl;
    u32 matID;
    u32 shpID;
    u32 sendMat;
} AnimatorShape3D;

typedef struct AnimatorSprite3D_
{
    Animator3D work;

    AnimatorSprite animatorSprite;
    u32 polygonAttr; // G3_POLYGON_ATTR
    u16 field_F8;
    u8 field_FA;
    u8 field_FB;
    u16 field_FC;
    u8 field_FE;
    u8 field_FF;
    u16 color;
    u8 field_102;
    u8 field_103;
} AnimatorSprite3D;

// --------------------
// FUNCTIONS
// --------------------

// Common
void InitSpriteSystem(void);

// AnimatorSprite
// clang-format off
void AnimatorSprite__Init(AnimatorSprite *animator, void *fileData, u16 animID, AnimatorFlags flags, BOOL useEngineB, 
                          PixelMode pixelMode, VRAMPixelKey vramPixels, PaletteMode paletteMode, VRAMPaletteKey vramPalette, 
                          SpritePriority oamPriority, SpriteOrder oamOrder);
// clang-format on
void AnimatorSprite__Release(AnimatorSprite *animator);
void AnimatorSprite__SetAnimation(AnimatorSprite *animator, u16 animID);
void AnimatorSprite__ProcessAnimation(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
void AnimatorSprite__AnimateManual(AnimatorSprite *animator, fx32 advance, SpriteFrameCallback callback, void *userData);
void AnimatorSprite__ProcessFrame(AnimatorSprite *animator);
void AnimatorSprite__DrawFrame(AnimatorSprite *animator);
void AnimatorSprite__DrawFrameRotoZoom(AnimatorSprite *animator, fx32 scaleX, fx32 scaleY, s32 rotation);
BOOL AnimatorSprite__GetBlockData(AnimatorSprite *animator, s32 id, void *data);

// AnimatorSpriteDS
// clang-format off
void AnimatorSpriteDS__Init(AnimatorSpriteDS *animator, void *fileData, u16 animID, ScreenDrawFlags screensToDraw, AnimatorFlags flags, 
                            PixelMode spriteMode0, VRAMPixelKey vramPixels0, PaletteMode paletteMode0, VRAMPaletteKey vramPalette0, 
                            PixelMode spriteMode1, VRAMPixelKey vramPixels1, PaletteMode paletteMode1, VRAMPaletteKey vramPalette1, 
                            SpritePriority oamPriority, SpriteOrder oamOrder);
// clang-format on
void AnimatorSpriteDS__Release(AnimatorSpriteDS *animator);
void AnimatorSpriteDS__SetAnimation(AnimatorSpriteDS *animator, u16 animID);
void AnimatorSpriteDS__ProcessAnimation(AnimatorSpriteDS *animator, SpriteFrameCallback callback, void *userData);
void AnimatorSpriteDS__AnimateManual(AnimatorSpriteDS *animator, fx32 advance, SpriteFrameCallback callback, void *userData);
void AnimatorSpriteDS__ProcessFrame(AnimatorSpriteDS *animator);
void AnimatorSpriteDS__DrawFrame(AnimatorSpriteDS *animator);
void AnimatorSpriteDS__DrawFrameRotoZoom(AnimatorSpriteDS *animator, fx32 scaleX, fx32 scaleY, s32 rotation);
void Sprite__InitUnknown(void);
void AnimatorSpriteDS__SetAnimation2(AnimatorSpriteDS *animator, u16 animID);

// AnimatorMDL
void AnimatorMDL__Init(AnimatorMDL *animator, AnimatorFlags flags);
void AnimatorMDL__Release(AnimatorMDL *animator);
void AnimatorMDL__SetResource(AnimatorMDL *animator, const NNSG3dResFileHeader *resource, u32 idx, BOOL setJoint, BOOL setMaterial);
void AnimatorMDL__SetAnimation(AnimatorMDL *animator, B3DAnimationTypes type, const NNSG3dResFileHeader *resource, u32 animID, const NNSG3dResTex *texResource);
void AnimatorMDL__ProcessAnimation(AnimatorMDL *animator);
void AnimatorMDL__Draw(AnimatorMDL *animator);

// AnimatorShape3D
void AnimatorShape3D__Init(AnimatorShape3D *animator, AnimatorFlags flags);
void AnimatorShape3D__SetResource(AnimatorShape3D *animator, NNSG3dResFileHeader *resource, u32 mdlID, u32 matID, u32 shpID);
void AnimatorShape3D__Release(AnimatorShape3D *animator);
void AnimatorShape3D__ProcessAnimation(AnimatorShape3D *animator);
void AnimatorShape3D__Draw(AnimatorShape3D *animator);

// AnimatorSprite3D
void AnimatorSprite3D__Init(AnimatorSprite3D *animator, u32 flags3D, void *fileData, u16 animID, AnimatorFlags flags, VRAMPixelKey vramPixels, VRAMPaletteKey vramPalette);
void AnimatorSprite3D__Release(AnimatorSprite3D *animator);
void AnimatorSprite3D__ProcessAnimation(AnimatorSprite3D *animator, SpriteFrameCallback callback, void *userData);
void AnimatorSprite3D__Draw(AnimatorSprite3D *animator);

// BAC
BACAnimFormat Sprite__GetFormatFromAnim(void *filePtr, u16 animID);
u16 Sprite__GetSpriteSize1FromAnim(void *filePtr, u16 animID);
u16 Sprite__GetSpriteSize1(void *filePtr);
u16 Sprite__GetSpriteSize2FromAnim(void *filePtr, u16 animID);
u16 Sprite__GetSpriteSize2(void *filePtr);
u16 Sprite__GetSpriteSize3FromAnim(void *filePtr, u16 animID);
u16 Sprite__GetSpriteSize3(void *filePtr);
u16 Sprite__GetSpriteSize4FromAnim(void *filePtr, u16 animID);
u16 Sprite__GetSpriteSize4(void *filePtr);
u16 Sprite__GetUnknown6(void *filePtr);
u16 Sprite__GetPaletteSizeFromAnim(void *filePtr, u16 animID);
u16 Sprite__GetPaletteSize(void *filePtr);
u32 Sprite__GetTextureSizeFromAnim(void *filePtr, u16 animID);
u32 Sprite__GetTextureSize(void *filePtr);
BOOL Sprite__Is3DFormat(AnimatorSprite *animator);

// Animation Helpers
BOOL Sprite__Animate(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
BOOL Sprite__AnimateDS(AnimatorSpriteDS *animator, SpriteFrameCallback callback, void *userData);
void Sprite__AnimateManual(AnimatorSprite *animator, fx32 advance, SpriteFrameCallback callback, void *userData);

// --------------------
// INLINE FUNCTIONS
// --------------------

// Process animation without any callbacks
RUSH_INLINE void AnimatorSprite__ProcessAnimationFast(AnimatorSprite *animator)
{
    AnimatorSprite__ProcessAnimation(animator, NULL, NULL);
}

// Process animation without any callbacks
RUSH_INLINE void AnimatorSpriteDS__ProcessAnimationFast(AnimatorSpriteDS *animator)
{
    AnimatorSpriteDS__ProcessAnimation(animator, NULL, NULL);
}

// Process animation without any callbacks
RUSH_INLINE void AnimatorSprite3D__ProcessAnimationFast(AnimatorSprite3D *animator)
{
    AnimatorSprite3D__ProcessAnimation(animator, NULL, NULL);
}

// Animate manual without any callbacks
RUSH_INLINE void AnimatorSprite__AnimateManualFast(AnimatorSprite *animator, fx32 advance)
{
    AnimatorSprite__AnimateManual(animator, advance, NULL, NULL);
}

// Animate manual without any callbacks
RUSH_INLINE void AnimatorSpriteDS__AnimateManualFast(AnimatorSpriteDS *animator, fx32 advance)
{
    AnimatorSpriteDS__AnimateManual(animator, advance, NULL, NULL);
}

RUSH_INLINE void Animator3D__Process(Animator3D *animator)
{
    switch (animator->type)
    {
        case ANIMATOR3D_MODEL:
            AnimatorMDL__ProcessAnimation((AnimatorMDL *)animator);
            break;

        case ANIMATOR3D_SHAPE:
            AnimatorShape3D__ProcessAnimation((AnimatorShape3D *)animator);
            break;

        case ANIMATOR3D_SPRITE:
            AnimatorSprite3D__ProcessAnimation((AnimatorSprite3D *)animator, NULL, NULL);
            break;
    }
}

RUSH_INLINE void Animator3D__Release(Animator3D *animator)
{
    switch (animator->type)
    {
        case ANIMATOR3D_MODEL:
            AnimatorMDL__Release((AnimatorMDL *)animator);
            break;

        case ANIMATOR3D_SHAPE:
            AnimatorShape3D__Release((AnimatorShape3D *)animator);
            break;

        case ANIMATOR3D_SPRITE:
            AnimatorSprite3D__Release((AnimatorSprite3D *)animator);
            break;
    }
}


#ifdef __cplusplus
}
#endif

#endif // RUSH_ANIMATORSPRITE_H
