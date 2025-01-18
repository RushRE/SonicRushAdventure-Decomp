#ifndef RUSH_OBJ_ACTION_H
#define RUSH_OBJ_ACTION_H

#include <game/graphics/sprite.h>
#include <game/object/objData.h>

// --------------------
// ENUMS
// --------------------

enum ObjActionFlags_
{
    OBJ_ACTION_FLAG_NONE = 0x00,

    OBJ_ACTION_FLAG_USING_ARCHIVE = 1 << 0,
};
typedef u32 ObjActionFlags;

// --------------------
// STRUCTS
// --------------------

struct StageTask_;

typedef struct OBS_ACTION2D_BAC_WORK_
{
    AnimatorSpriteDS ani;

    OBS_DATA_WORK *fileWork;
    OBS_SPRITE_REF *spriteRef;
    ObjActionFlags flags;
} OBS_ACTION2D_BAC_WORK;

typedef struct OBS_ACTION3D_BAC_WORK_
{
    AnimatorSprite3D ani;

    void *fileData;
    OBS_DATA_WORK *fileWork;
    OBS_TEXTURE_REF *textureRef;
    ObjActionFlags flags;
} OBS_ACTION3D_BAC_WORK;

typedef struct OBS_ACTION3D_NN_WORK_
{
    AnimatorMDL ani;

    NNSG3dResFileHeader *resources[B3D_RESOURCE_MAX];
    OBS_DATA_WORK *file[B3D_RESOURCE_MAX];
    u16 animID;
    ObjActionFlags flags;
} OBS_ACTION3D_NN_WORK;

typedef struct OBS_ACTION3D_ES_WORK_
{
    AnimatorShape3D ani;

    struct OBS_ACTION3D_ES_WORK_ *next;
    NNSG3dResFileHeader *resource;
    OBS_DATA_WORK *fileWork;
    ObjActionFlags flags;
} OBS_ACTION3D_ES_WORK;

// --------------------
// FUNCTIONS
// --------------------

// Asset loading object actions
void ObjObjectAction2dBACLoad(struct StageTask_ *work, OBS_ACTION2D_BAC_WORK *obj_2d, const char *filePath, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive, u16 gfxSize);
void ObjAction3dNNModelLoad(struct StageTask_ *work, OBS_ACTION3D_NN_WORK *obj_3d, const char *path, s32 id, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive);
void ObjAction3dNNMotionLoad(struct StageTask_ *work, OBS_ACTION3D_NN_WORK *obj_3d, const char *path, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive);
void ObjAction3dESEffectLoad(struct StageTask_ *work, OBS_ACTION3D_ES_WORK *es_work, const char *path, s32 mdlID, u16 shpID, u16 matID, OBS_DATA_WORK *file,
                                            NNSiFndArchiveHeader *archive);
void ObjObjectAction3dBACLoad(struct StageTask_ *work, OBS_ACTION3D_BAC_WORK *obj_2d, const char *path, u16 textureSize, u16 paletteSize, OBS_DATA_WORK *file,
                                             NNSiFndArchiveHeader *archive);

// Graphics allocation object actions
void ObjObjectActionAllocSprite(struct StageTask_ *work, size_t size, OBS_SPRITE_REF *ref);
void ObjObjectActionAllocTexture(struct StageTask_ *work, size_t texSize, size_t palSize, OBS_TEXTURE_REF *ref);
void ObjObjectActionReleaseGfxRefs(struct StageTask_ *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void ObjAction3dESEffectSetScale(OBS_ACTION3D_ES_WORK *esWork, fx32 scaleX, fx32 scaleY, fx32 scaleZ)
{
    esWork->ani.work.scale.x = scaleX;
    esWork->ani.work.scale.y = scaleY;
    esWork->ani.work.scale.z = scaleZ;
}

#endif // RUSH_OBJ_ACTION_H
