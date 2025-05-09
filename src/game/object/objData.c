#include <game/object/objData.h>
#include <game/system/allocator.h>
#include <game/file/fsRequest.h>
#include <game/graphics/sprite.h>
#include <game/graphics/drawReqTask.h>
#include <stage/stageTask.h>
#include <game/graphics/spritePaletteAnimation.h>
#include <game/object/objectManager.h>

// --------------------
// VARIABLES
// --------------------

char archiveNameBuffer[0x40];

u16 (*getSpriteGfxSize[])(void *filePtr) = { Sprite__GetSpriteSize1, Sprite__GetSpriteSize2, Sprite__GetSpriteSize3, Sprite__GetSpriteSize4 };

// --------------------
// FUNCTIONS
// --------------------

void *ObjDataSearchArchive(const char *path, NNSiFndArchiveHeader *archivePtr)
{
    NNSFndArchive archive;

    STD_CopyString(archiveNameBuffer, "obj:");
    STD_ConcatenateString(archiveNameBuffer, path);

    NNS_FndMountArchive(&archive, "obj", archivePtr);
    void *fileData = NNS_FndGetArchiveFileByName(archiveNameBuffer);
    NNS_FndUnmountArchive(&archive);

    return fileData;
}

void *ObjDataSet(OBS_DATA_WORK *work, void *fileData)
{
    work->fileData = fileData;
    work->referenceCount++;

    return work->fileData;
}

void *ObjDataLoad(OBS_DATA_WORK *work, const char *path, NNSiFndArchiveHeader *archive)
{
    if (work == NULL)
    {
        // search the archive if it exists, otherwise read straight from the file path
        if (archive != NULL)
        {
            return ObjDataSearchArchive(path, archive);
        }
        else
        {
            return FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
        }
    }
    else
    {
        if (work->fileData == NULL)
        {
            // search the archive if it exists, otherwise read straight from the file path
            if (archive != NULL)
            {
                work->fileData = ObjDataSearchArchive(path, archive);
                if (work->fileData == NULL)
                    return NULL;

                work->referenceCount++;
                work->referenceCount |= OBJDATA_FLAG_USES_ARCHIVE;
            }
            else
            {
                work->fileData = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
                work->referenceCount++;
            }
        }
        else
        {
            work->referenceCount++;
        }

        return work->fileData;
    }
}

void ObjDataRelease(OBS_DATA_WORK *work)
{
    if (work->referenceCount == 0 || work->fileData == NULL)
        return;

    work->referenceCount--;

    if (work->referenceCount == 0)
    {
        HeapFree(HEAP_USER, work->fileData);
        work->fileData = NULL;
    }

    // is this broken? this should use AND, instead of comparing right?
    if (work->referenceCount == OBJDATA_FLAG_USES_ARCHIVE)
    {
        work->fileData       = NULL;
        work->referenceCount = 0;
    }
}

// Graphics allocation internal actions
VRAMPixelKey ObjActionAllocSprite(OBS_GFX_REF *ref, BOOL useEngineB, size_t size)
{
    if (ref->vramPixels == NULL && size != OBJ_DATA_GFX_NONE)
        ref->vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, size);

    ref->referenceCount++;
    return ref->vramPixels;
}

void ObjActionReleaseSprite(OBS_GFX_REF *ref, BOOL useEngineB)
{
    if (ref->vramPixels == NULL)
        return;

    ref->referenceCount--;
    if (ref->referenceCount != 0)
        return;

    VRAMSystem__FreeSpriteVram(useEngineB, ref->vramPixels);

    ref->vramPixels = NULL;
}

VRAMPixelKey ObjActionAllocTexture(OBS_GFX_REF *ref, size_t size)
{
    if (ref->vramPixels == NULL && size != OBJ_DATA_GFX_NONE)
        ref->vramPixels = VRAMSystem__AllocTexture(size, FALSE);

    ref->referenceCount++;
    return ref->vramPixels;
}

VRAMPixelKey ObjActionAllocPalette(OBS_GFX_REF *ref, size_t size)
{
    if (ref->vramPixels == NULL && size != OBJ_DATA_GFX_NONE)
        ref->vramPixels = VRAMSystem__AllocPalette(size, FALSE);

    ref->referenceCount++;
    return ref->vramPixels;
}

void ObjActionReleaseTexture(Animator3D *work, OBS_GFX_REF *ref)
{
    if (ref->vramPixels == OBJ_DATA_GFX_NONE)
        return;

    ref->referenceCount--;
    if (ref->referenceCount != 0)
        return;

    Animator3D__Release(work);

    ref->vramPixels = OBJ_DATA_GFX_NONE;
}

void ObjActionLoadArchiveFile(OBS_DATA_WORK *work, const char *path, NNSiFndArchiveHeader *archive)
{
    if (work->referenceCount != 0)
        return;

    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "obj", archive);

    void *fileData = ObjDataLoad(work, path, archive);
    STD_CopyString(archiveNameBuffer, "obj:");
    STD_ConcatenateString(archiveNameBuffer, path);

    u32 fileSize   = FSRequestFileSize(archiveNameBuffer);
    work->fileData = HeapAllocHead(HEAP_USER, fileSize);
    work->referenceCount &= ~OBJDATA_FLAG_USES_ARCHIVE;
    MI_CpuCopy32(fileData, work->fileData, fileSize);

    NNS_FndUnmountArchive(&arc);
}

void ObjActionLoadModelTextures(OBS_DATA_WORK *work, const char *path)
{
    NNSG3dResFileHeader *resource = (NNSG3dResFileHeader *)work->fileData;
    if (work->fileData == NULL)
        resource = (NNSG3dResFileHeader *)ObjDataLoad(work, path, NULL);

    NNS_G3dResDefaultSetup(resource);
    work->fileData = HeapAllocHead(HEAP_USER, Asset3DSetup__GetTexSize(resource));

    Asset3DSetup__GetTexture(resource, work->fileData);
    HeapFree(HEAP_USER, resource);
}

void ObjActionAllocSpriteDS(AnimatorSpriteDS *animator, size_t size, OBS_SPRITE_REF *ref)
{
    animator->vramPixels[GRAPHICS_ENGINE_A] = ObjActionAllocSprite(&ref->engineRef[GRAPHICS_ENGINE_A], GRAPHICS_ENGINE_A, size);
    animator->vramPixels[GRAPHICS_ENGINE_B] = ObjActionAllocSprite(&ref->engineRef[GRAPHICS_ENGINE_B], GRAPHICS_ENGINE_B, size);
}

void ObjActionReleaseSpriteDS(OBS_SPRITE_REF *ref)
{
    ObjActionReleaseSprite(&ref->engineRef[GRAPHICS_ENGINE_A], GRAPHICS_ENGINE_A);
    ObjActionReleaseSprite(&ref->engineRef[GRAPHICS_ENGINE_B], GRAPHICS_ENGINE_B);
}

void ObjAction2dBACLoad(AnimatorSpriteDS *work, const char *path, u16 gfxSize, OBS_DATA_WORK *file, NNSiFndArchiveHeader *archive)
{
    void *fileData;
    VRAMPixelKey vramPixelsA = OBJ_DATA_GFX_NONE;
    VRAMPixelKey vramPixelsB = OBJ_DATA_GFX_NONE;

    // load file from archive
    fileData = ObjDataLoad(file, path, archive);

    // as a backup, try loading the file from the root directory instead!
    if (fileData == NULL && archive != NULL)
        fileData = ObjDataLoad(file, path, NULL);

    // if that still failed, lets give up
    if (fileData == NULL)
        return;

    if (gfxSize != OBJ_DATA_GFX_NONE)
    {
        if (gfxSize == OBJ_DATA_GFX_AUTO)
            gfxSize = getSpriteGfxSize[g_obj.spriteMode](fileData);

        if ((work->flags & ANIMATORSPRITEDS_FLAG_DISABLE_A) == 0)
            vramPixelsA = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, gfxSize);

        if ((work->flags & ANIMATORSPRITEDS_FLAG_DISABLE_B) == 0)
            vramPixelsB = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, gfxSize);
    }

    AnimatorSpriteDS__Init(work, fileData, 0, work->flags, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, PIXEL_MODE_SPRITE, vramPixelsA, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                           PIXEL_MODE_SPRITE, vramPixelsB, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
}

void ObjAction2dBACRelease(OBS_DATA_WORK *work, AnimatorSpriteDS *animator)
{
    ObjDataRelease(work);

    if (animator->vramPixels[GRAPHICS_ENGINE_A] != OBJ_DATA_GFX_NONE)
        VRAMSystem__FreeSpriteVram(GRAPHICS_ENGINE_A, animator->vramPixels[0]);

    if (animator->vramPixels[GRAPHICS_ENGINE_B] != OBJ_DATA_GFX_NONE)
        VRAMSystem__FreeSpriteVram(GRAPHICS_ENGINE_B, animator->vramPixels[1]);
}

void ObjActionAllocSpritePalette(StageTask *work, u16 animID, s16 flags)
{
    u16 paletteRow = PALETTE_ROW_0;

    if (work->obj_2d == NULL)
        return;

    if (work->obj_2d->fileWork != NULL && work->obj_2d->fileWork->fileData != NULL)
    {
        paletteRow = ObjDrawAllocSpritePalette(work->obj_2d->fileWork->fileData, animID, flags);
    }
    else if (work->obj_2d->ani.work.fileData != NULL)
    {
        paletteRow = ObjDrawAllocSpritePalette(work->obj_2d->ani.work.fileData, animID, flags);
    }

    work->obj_2d->ani.cParam[GRAPHICS_ENGINE_A].palette = paletteRow;
    work->obj_2d->ani.cParam[GRAPHICS_ENGINE_B].palette = paletteRow;
    work->obj_2d->ani.work.cParam.palette               = paletteRow;

    if ((flags & OBJDRAW_SPRITE_FLAG_USE_ENGINE_B) != 0)
        work->flag |= STAGE_TASK_FLAG_ALLOCATED_SPRITE_PALETTE;

    work->obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
}

void ObjActionReleaseSpritePalette(StageTask *work)
{
    if (work->obj_2d == NULL)
        return;

    if ((work->flag & STAGE_TASK_FLAG_ALLOCATED_PALETTE_ANIM_OLD) != 0)
        ReleaseSpritePalette_OLD(work->obj_2d->ani.cParam[GRAPHICS_ENGINE_A].palette);

    ObjDrawReleaseSpritePalette(work->obj_2d->ani.cParam[GRAPHICS_ENGINE_A].palette);
}