#include <sail/sailAssetLoader.h>
#include <sail/sailManager.h>
#include <game/object/objData.h>
#include <game/object/objectManager.h>
#include <game/graphics/sprite.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void LoadSailSprite3DAsset(const char *filePath, s16 id, u16 animID);
static void ReleaseSailSprite3DAsset(s16 id);
static void SailAssetLoader_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

void LoadSailSprite3DAsset(const char *filePath, s16 id, u16 animID)
{
    void *archive = SailManager__GetArchive();

    u16 textureSize = Sprite__GetTextureSizeFromAnim(ObjDataSearchArchive(filePath, archive), animID);
    u16 paletteSize = Sprite__GetPaletteSizeFromAnim(ObjDataSearchArchive(filePath, archive), animID);

    VRAMPixelKey vramPixels    = ObjActionAllocTexture(GetObjectGraphicsRef(id), textureSize);
    VRAMPaletteKey vramPalette = ObjActionAllocPalette(GetObjectGraphicsRef(id + 1), paletteSize);

    AnimatorSprite3D aniSprite3D;
    AnimatorSprite3D__Init(&aniSprite3D, ANIMATOR_FLAG_NONE, ObjDataSearchArchive(filePath, archive), animID, ANIMATOR_FLAG_NONE, vramPixels, vramPalette);
    AnimatorSprite3D__ProcessAnimationFast(&aniSprite3D);
}

void ReleaseSailSprite3DAsset(s16 id)
{
    AnimatorSprite3D aniSprite3D;
    MI_CpuClear8(&aniSprite3D, sizeof(aniSprite3D));

    aniSprite3D.work.type                  = ANIMATOR3D_SPRITE;
    aniSprite3D.animatorSprite.vramPixels  = VRAMKEY_TO_ADDR(GetObjectGraphicsRef(id)->vramPixels);
    aniSprite3D.animatorSprite.vramPalette = VRAMKEY_TO_ADDR(GetObjectGraphicsRef(id + 1)->vramPixels);

    ObjActionReleaseTexture(&aniSprite3D.work, GetObjectGraphicsRef(id));
    ObjActionReleaseTexture(&aniSprite3D.work, GetObjectGraphicsRef(id + 1));
}

void InitSailAssets(void)
{
    void *archive = SailManager__GetArchive();

    TaskCreateNoWork(NULL, SailAssetLoader_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(4), "SailAssetLoader");

    NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_water00.nsbmd", archive));
    NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_water01.nsbmd", archive));
    NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_water02.nsbmd", archive));
    NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_stone.nsbmd", archive));
    NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_goal.nsbmd", archive));

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_jet.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_joh.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bob.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_shark.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bird.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_boost01.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_boost02.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_jump.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_dash.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_trick.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_seagull.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_circle.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_ice.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_chaos.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            break;

        case SHIP_BOAT:
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_sailer.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_boat01.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_boat02.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_boat03.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bigbob01.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bigbob02.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_cruiser.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_cruiser02.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bird.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_missile.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_seagull.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_ice.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_flash.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bazooka.nsbmd", archive));
            break;

        case SHIP_HOVER:
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_hover.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bob.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_shark.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bird.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_trick.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_seagull.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_ice.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_hover1.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_hover2.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_water09.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_boat01.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_boat02.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bullet1.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bullet2.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_bullet3.nsbmd", archive));
            break;

        case SHIP_SUBMARINE:
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_submarine.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_sub_water.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_boat02.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_s_depth.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_b_shark.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_sub_fish.nsbmd", archive));
            NNS_G3dResDefaultSetup(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            break;
    }

    LoadSailSprite3DAsset("sb_mine.bac", OBJDATAWORK_54, 0);
    for (u16 i = 0; i < 3; i++)
    {
        LoadSailSprite3DAsset("sb_cloud.bac", 2 * i + OBJDATAWORK_56, i);
    }

    switch (SailManager__GetShipType())
    {
        case SHIP_BOAT:
            LoadSailSprite3DAsset("sb_shell.bac", OBJDATAWORK_62, 0);
            LoadSailSprite3DAsset("sb_shell.bac", OBJDATAWORK_64, 1);
            LoadSailSprite3DAsset("sb_fire.bac", OBJDATAWORK_107, 0);
            break;

        case SHIP_HOVER:
            LoadSailSprite3DAsset("sb_shell.bac", OBJDATAWORK_62, 0);
            LoadSailSprite3DAsset("sb_shell.bac", OBJDATAWORK_64, 1);
            break;
    }
}

void SailAssetLoader_Destructor(Task *task)
{
    void *archive = SailManager__GetArchive();

    NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_water00.nsbmd", archive));
    NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_water01.nsbmd", archive));
    NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_water02.nsbmd", archive));
    NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_stone.nsbmd", archive));
    NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_goal.nsbmd", archive));

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_jet.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_joh.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bob.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_shark.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bird.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_boost01.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_boost02.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_jump.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_dash.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_trick.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_seagull.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_circle.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_ice.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_chaos.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            break;

        case SHIP_BOAT:
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_sailer.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_boat01.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_boat02.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_boat03.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bigbob01.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bigbob02.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_cruiser.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_cruiser02.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bird.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_missile.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_seagull.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_ice.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_flash.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bazooka.nsbmd", archive));
            break;

        case SHIP_HOVER:
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_hover.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bob.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_shark.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bird.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_trick.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_seagull.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_ice.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_hover1.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_hover2.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_water09.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_boat01.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_boat02.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bullet1.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bullet2.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_bullet3.nsbmd", archive));
            break;

        case SHIP_SUBMARINE:
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_submarine.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_sub_water.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_boat02.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_s_depth.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_b_shark.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_torpedo.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_sub_fish.nsbmd", archive));
            NNS_G3dResDefaultRelease(ObjDataSearchArchive("sb_buoy.nsbmd", archive));
            break;
    }

    ReleaseSailSprite3DAsset(OBJDATAWORK_54);
    for (u16 i = 0; i < 3; i++)
    {
        ReleaseSailSprite3DAsset(2 * i + OBJDATAWORK_56);
    }

    switch (SailManager__GetShipType())
    {
        case SHIP_BOAT:
            ReleaseSailSprite3DAsset(OBJDATAWORK_62);
            ReleaseSailSprite3DAsset(OBJDATAWORK_64);
            ReleaseSailSprite3DAsset(OBJDATAWORK_107);
            break;

        case SHIP_HOVER:
            ReleaseSailSprite3DAsset(OBJDATAWORK_62);
            ReleaseSailSprite3DAsset(OBJDATAWORK_64);
            break;
    }
}