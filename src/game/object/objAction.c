#include <game/object/objAction.h>
#include <stage/stageTask.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/drawReqTask.h>
#include <game/object/objectManager.h>

// --------------------
// FUNCTIONS
// --------------------

// Asset loading object actions
void ObjObjectAction2dBACLoad(StageTask *work, OBS_ACTION2D_BAC_WORK *obj_2d, const char *filePath, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive, u16 gfxSize)
{
    if (obj_2d == NULL)
    {
        if (work->obj_2d != NULL)
        {
            obj_2d = work->obj_2d;
        }
        else
        {
            obj_2d = HeapAllocHead(HEAP_USER, sizeof(*obj_2d));
            MI_CpuClear8(obj_2d, sizeof(*obj_2d));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_OBJ_2D;
        }
    }

    work->obj_2d = obj_2d;
    work->flag &= ~STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE;
    work->obj_2d->fileWork = file;

    work->obj_2d->ani.flags = ANIMATORSPRITEDS_FLAG_NONE;
    if ((work->flag & STAGE_TASK_FLAG_400000) != 0)
        work->obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_A;

    if ((work->flag & STAGE_TASK_FLAG_800000) != 0)
        work->obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    ObjAction2dBACLoad(&work->obj_2d->ani, filePath, gfxSize, file, archive);

    if (file != NULL)
    {
        if (CheckDataUsesArchive(file))
            work->flag |= STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE;
    }
}

void ObjAction3dNNModelLoad(StageTask *work, OBS_ACTION3D_NN_WORK *obj_3d, const char *path, s32 id, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive)
{
    if (obj_3d == NULL)
    {
        if (work->obj_3d != NULL)
        {
            obj_3d = work->obj_3d;
        }
        else
        {
            obj_3d = HeapAllocHead(HEAP_USER, sizeof(*obj_3d));
            MI_CpuClear8(obj_3d, sizeof(*obj_3d));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_OBJ_3D;
        }
    }

    work->obj_3d = obj_3d;
    AnimatorMDL__Init(&obj_3d->ani, ANIMATOR_FLAG_NONE);

    if (archive != NULL)
        obj_3d->flags |= OBJ_ACTION_FLAG_USING_ARCHIVE;

    // load file from archive
    NNSG3dResFileHeader *resource = (NNSG3dResFileHeader *)ObjDataLoad(file, path, archive);

    // as a backup, try loading the file from the root directory instead!
    if (resource == NULL && archive != NULL)
    {
        obj_3d->flags &= ~OBJ_ACTION_FLAG_USING_ARCHIVE;
        resource = (NNSG3dResFileHeader *)ObjDataLoad(file, path, NULL);
    }

    if (resource != NULL)
    {
        obj_3d->resources[B3D_RESOURCE_MODEL] = resource;

        if (file != NULL)
        {
            obj_3d->file[B3D_RESOURCE_MODEL] = file;
            if (file->referenceCount == 1)
                NNS_G3dResDefaultSetup(resource);
        }

        if (resource != NULL)
            AnimatorMDL__SetResource(&obj_3d->ani, resource, id, FALSE, FALSE);
    }
}

void ObjAction3dNNMotionLoad(StageTask *work, OBS_ACTION3D_NN_WORK *obj_3d, const char *path, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive)
{
    B3DAnimationTypes type = B3D_ANIM_JOINT_ANIM;

    if (obj_3d == NULL)
    {
        if (work->obj_3d != NULL)
        {
            obj_3d = work->obj_3d;
        }
        else
        {
            obj_3d = HeapAllocHead(HEAP_USER, sizeof(*obj_3d));
            MI_CpuClear8(obj_3d, sizeof(*obj_3d));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_OBJ_3D;
        }
    }

    s16 len        = STD_GetStringLength(path);
    u16 identifier = (u16)((s8)path[len - 1]) | ((s8)path[len - 2] << 8);
    switch (identifier)
    {
        case 'ca':
            // for whatever reason this is done at the start of the function instead
            // type = B3D_ANIM_JOINT_ANIM;
            break;

        case 'ma':
            type = B3D_ANIM_MAT_ANIM;
            break;

        case 'tp':
            type = B3D_ANIM_PAT_ANIM;
            break;

        case 'ta':
            type = B3D_ANIM_TEX_ANIM;
            break;

        case 'va':
            type = B3D_ANIM_VIS_ANIM;
            break;
    }

    if (archive != NULL)
    {
        obj_3d->flags |= (B3D_ANIM_RESOURCE_OFFSET + 1) << type;
    }
    else
    {
        obj_3d->flags &= ~((B3D_ANIM_RESOURCE_OFFSET + 1) << type);
    }

    NNSG3dResFileHeader *resource = (NNSG3dResFileHeader *)ObjDataLoad(file, path, archive);

    if (resource == NULL && archive)
    {
        obj_3d->flags &= ~((B3D_ANIM_RESOURCE_OFFSET + 1) << type);
        resource = (NNSG3dResFileHeader *)ObjDataLoad(file, path, NULL);
    }

    obj_3d->resources[B3D_ANIM_RESOURCE_OFFSET + type] = resource;

    if (resource != NULL && file != NULL)
    {
        obj_3d->file[B3D_ANIM_RESOURCE_OFFSET + type] = file;
        if (file->referenceCount == 1)
            NNS_G3dResDefaultSetup(resource);
    }
}

void ObjAction3dESEffectLoad(StageTask *work, OBS_ACTION3D_ES_WORK *es_work, const char *path, s32 mdlID, u16 shpID, u16 matID, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive)
{
    if (es_work == NULL)
    {
        es_work = HeapAllocHead(HEAP_USER, sizeof(*es_work));
        MI_CpuClear8(es_work, sizeof(*es_work));
        work->flag |= STAGE_TASK_FLAG_ALLOCATED_OBJ_3DES;
    }

    if (work->obj_3des != NULL)
    {
        OBS_ACTION3D_ES_WORK *objWork = work->obj_3des;
        while (TRUE)
        {
            if (objWork->next == NULL)
            {
                objWork->next = es_work;
                break;
            }

            objWork = objWork->next;
        }
    }
    else
    {
        work->obj_3des = es_work;
    }

    AnimatorShape3D__Init(&es_work->ani, ANIMATOR_FLAG_NONE);

    if (archive != NULL)
        es_work->flags |= OBJ_ACTION_FLAG_USING_ARCHIVE;

    // load file from archive
    NNSG3dResFileHeader *resource = (NNSG3dResFileHeader *)ObjDataLoad(file, path, archive);

    // as a backup, try loading the file from the root directory instead!
    if (resource == NULL && archive != NULL)
    {
        es_work->flags &= ~OBJ_ACTION_FLAG_USING_ARCHIVE;
        resource = (NNSG3dResFileHeader *)ObjDataLoad(file, path, NULL);
    }

    if (resource != NULL)
    {
        es_work->resource = resource;

        if (file != NULL)
        {
            es_work->fileWork = file;
            if (file->referenceCount == 1)
                NNS_G3dResDefaultSetup(resource);
        }

        if (resource != NULL)
            AnimatorShape3D__SetResource(&es_work->ani, resource, mdlID, matID, shpID);
    }
}

void ObjObjectAction3dBACLoad(StageTask *work, OBS_ACTION3D_BAC_WORK *obj_2d, const char *path, u16 textureSize, u16 paletteSize, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive)
{
    void *resource;
    VRAMPixelKey textureRef = OBJ_DATA_GFX_NONE;
    VRAMPaletteKey paletteRef = OBJ_DATA_GFX_NONE;

    if (obj_2d == NULL)
    {
        if (work->obj_2dIn3d != NULL)
        {
            obj_2d = work->obj_2dIn3d;
        }
        else
        {
            obj_2d = HeapAllocHead(HEAP_USER, sizeof(*obj_2d));
            MI_CpuClear8(obj_2d, sizeof(*obj_2d));
            work->flag |= STAGE_TASK_FLAG_ALLOCATED_OBJ_2DIN3D;
        }
    }

    work->obj_2dIn3d = obj_2d;

    if (archive != NULL)
        obj_2d->flags |= OBJ_ACTION_FLAG_USING_ARCHIVE;

    obj_2d->fileWork = file;

    // load file from archive
    resource = ObjDataLoad(obj_2d->fileWork, path, archive);

    // as a backup, try loading the file from the root directory instead!
    if (resource == NULL && archive != NULL)
    {
        work->flag &= ~STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE;
        resource = ObjDataLoad(obj_2d->fileWork, path, NULL);
    }

    if (resource != NULL)
    {
        obj_2d->fileData = resource;

        if (textureSize != 0)
        {
            if (textureSize == OBJ_DATA_GFX_AUTO)
                textureSize = Sprite__GetTextureSize(resource);

            textureRef = VRAMSystem__AllocTexture(textureSize, FALSE);
        }

        if (paletteSize != 0)
        {
            if (paletteSize == OBJ_DATA_GFX_AUTO)
                paletteSize = Sprite__GetPaletteSize(resource);

            paletteRef = VRAMSystem__AllocPalette(paletteSize, FALSE);
        }

        AnimatorSprite3D__Init(&obj_2d->ani, ANIMATOR_FLAG_NONE, resource, 0, ANIMATOR_FLAG_NONE, textureRef, paletteRef);
    }
}

// Graphics allocation object actions
void ObjObjectActionAllocSprite(StageTask *work, size_t size, OBS_SPRITE_REF *ref)
{
    OBS_ACTION2D_BAC_WORK *actionWork = work->obj_2d;

    u32 gfxSize = size;
    if (work->obj_2d == NULL)
        return;

    work->obj_2d->spriteRef = ref;
    if (size == OBJ_DATA_GFX_AUTO)
    {
        if (work->obj_2d->fileWork)
            gfxSize = getSpriteGfxSize[g_obj.spriteMode](work->obj_2d->fileWork->fileData);
    }

    work->obj_2d->ani.vramPixels[0] = ObjActionAllocSprite(&ref->engineRef[0], FALSE, gfxSize);
    work->obj_2d->ani.vramPixels[1] = ObjActionAllocSprite(&ref->engineRef[1], TRUE, gfxSize);
}

void ObjObjectActionAllocTexture(StageTask *work, size_t texSize, size_t palSize, OBS_TEXTURE_REF *ref)
{
    OBS_ACTION3D_BAC_WORK *actionWork = work->obj_2dIn3d;

    actionWork->textureRef                     = ref;
    actionWork->ani.animatorSprite.vramPixels  = ObjActionAllocTexture(&ref->texture, texSize);
    actionWork->ani.animatorSprite.vramPalette = ObjActionAllocPalette(&ref->palette, palSize);
}

void ObjObjectActionReleaseGfxRefs(StageTask *work)
{
    if (work->obj_2d != NULL)
    {
        if (work->obj_2d->spriteRef != NULL)
        {
            ObjActionReleaseSprite(&work->obj_2d->spriteRef->engineRef[0], FALSE);
            ObjActionReleaseSprite(&work->obj_2d->spriteRef->engineRef[1], TRUE);
            work->obj_2d->ani.vramPixels[0] = NULL;
            work->obj_2d->ani.vramPixels[1] = NULL;
        }
        else
        {
            if (work->obj_2d->ani.vramPixels[0] != OBJ_DATA_GFX_NONE)
                VRAMSystem__FreeSpriteVram(FALSE, work->obj_2d->ani.vramPixels[0]);
            work->obj_2d->ani.vramPixels[0] = OBJ_DATA_GFX_NONE;

            if (work->obj_2d->ani.vramPixels[1] != OBJ_DATA_GFX_NONE)
                VRAMSystem__FreeSpriteVram(TRUE, work->obj_2d->ani.vramPixels[1]);

            work->obj_2d->ani.vramPixels[1] = OBJ_DATA_GFX_NONE;
        }
    }

    if (work->obj_2dIn3d != NULL)
    {
        if (work->obj_2dIn3d->textureRef != NULL)
        {
            ObjActionReleaseTexture(&work->obj_2dIn3d->ani.work, &work->obj_2dIn3d->textureRef->texture);
            ObjActionReleaseTexture(&work->obj_2dIn3d->ani.work, &work->obj_2dIn3d->textureRef->palette);
        }
        else
        {
            Animator3D__Release(&work->obj_2dIn3d->ani.work);
        }
    }
}
