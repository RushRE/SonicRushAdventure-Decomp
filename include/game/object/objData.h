#ifndef RUSH_OBJ_DATA_H
#define RUSH_OBJ_DATA_H

#include <global.h>
#include <game/graphics/vramSystem.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FORWARD DECLS
// --------------------

struct Animator3D_;
struct AnimatorSpriteDS_;
struct StageTask_;

// --------------------
// CONSTANTS
// --------------------

#define OBJDATA_FLAG_USES_ARCHIVE  (0x8000)
#define OBJDATA_FLAG_REFCOUNT_MASK (~OBJDATA_FLAG_USES_ARCHIVE)

#define OBJ_DATA_GFX_AUTO (0xFFFF)
#define OBJ_DATA_GFX_NONE (0x0000)

// --------------------
// STRUCTS
// --------------------

typedef struct OBS_GFX_REF_
{
    VRAMPixelKey vramPixels;
    u16 referenceCount;
} OBS_GFX_REF;

typedef struct OBS_SPRITE_REF_
{
    OBS_GFX_REF engineRef[2];
} OBS_SPRITE_REF;

typedef struct OBS_TEXTURE_REF_
{
    OBS_GFX_REF texture;
    OBS_GFX_REF palette;
} OBS_TEXTURE_REF;

typedef struct OBS_DATA_WORK_
{
    void *fileData;
    u16 referenceCount;
} OBS_DATA_WORK;

// --------------------
// VARIABLES
// --------------------

extern u16 (*getSpriteGfxSize[])(void *filePtr);

// --------------------
// FUNCTIONS
// --------------------

// file management
void *ObjDataSearchArchive(const char *path, NNSiFndArchiveHeader *archive);
void *ObjDataSet(OBS_DATA_WORK *work, void *fileData);
void *ObjDataLoad(OBS_DATA_WORK *work, const char *path, NNSiFndArchiveHeader *archive);
void ObjDataRelease(OBS_DATA_WORK *work);

// Graphics allocation internal actions
VRAMPixelKey ObjActionAllocSprite(OBS_GFX_REF *ref, BOOL useEngineB, size_t size);
void ObjActionReleaseSprite(OBS_GFX_REF *ref, BOOL useEngineB);
VRAMPixelKey ObjActionAllocTexture(OBS_GFX_REF *ref, size_t size);
VRAMPixelKey ObjActionAllocPalette(OBS_GFX_REF *ref, size_t size);
void ObjActionReleaseTexture(struct Animator3D_ *work, OBS_GFX_REF *ref);

void ObjActionLoadArchiveFile(OBS_DATA_WORK *work, const char *path, NNSiFndArchiveHeader *archive);
void ObjActionLoadModelTextures(OBS_DATA_WORK *work, const char *path);
void ObjActionAllocSpriteDS(struct AnimatorSpriteDS_ *animator, size_t size, OBS_SPRITE_REF *ref);
void ObjActionReleaseSpriteDS(OBS_SPRITE_REF *ref);
void ObjAction2dBACLoad(struct AnimatorSpriteDS_ *work, const char *path, u16 gfxSize, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive);
void ObjAction2dBACRelease(OBS_DATA_WORK *work, struct AnimatorSpriteDS_ *animator);
void ObjActionAllocSpritePalette(struct StageTask_ *work, u16 animID, s16 flags);
void ObjActionReleaseSpritePalette(struct StageTask_ *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckDataUsesArchive(OBS_DATA_WORK *work)
{
    return (work->referenceCount & OBJDATA_FLAG_USES_ARCHIVE) != 0;
}

#ifdef __cplusplus
}
#endif

#endif // RUSH_OBJ_DATA_H
