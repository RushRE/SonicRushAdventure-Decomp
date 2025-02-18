#include <hub/cviMapBack.hpp>
#include <game/system/allocator.h>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <hub/hubConfig.h>
#include <hub/hubControl.hpp>

// resources
#include <resources/bb/vi_map_back.h>
#include <resources/narc/vi_act_lz7.h>
#include <resources/narc/vi_bg_lz7.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZdlPv(void);

NOT_DECOMPILED void BackgroundUnknown__Func_204CB98(void *ptr1, u16 width1, u16 startX1, u16 startY1, u16 sizeX1, u16 sizeY1, void *ptr2, u16 width2, u16 sizeX2, u16 sizeY2,
                                                    u16 a1);
NOT_DECOMPILED void BackgroundUnknown__Func_204CB40(void *ptr1, u16 width1, u16 startX1, u16 startY1, u16 sizeX1, u16 sizeY1, void *ptr2, u16 width2, u16 sizeX2, u16 sizeY2,
                                                    u16 a1);

NOT_DECOMPILED fx32 Unknown2051334__Func_2051534(fx32 start, fx32 end, fx32 progress, s32 duration, fx32 speed);

NOT_DECOMPILED void _ZN13CViMapVmiFile7ReleaseEv(CViMapVmiFile *work);
NOT_DECOMPILED void _ZN13CViMapVmpFile7ReleaseEv(CViMapVmpFile *work);
NOT_DECOMPILED void _ZN13CViMapVmcFile7ReleaseEv(CViMapVmcFile *work);

NOT_DECOMPILED void *_ZN13CViMapVmcFile9GetPixelsEv(CViMapVmcFile *work);

NOT_DECOMPILED u16 _ZN13CViMapVmiFile13GetImageCountEv(CViMapVmiFile *work);
NOT_DECOMPILED u16 _ZN13CViMapVmiFile18GetImageTileHeightEt(CViMapVmiFile *work, u16 id);
NOT_DECOMPILED u16 _ZN13CViMapVmiFile17GetImageTileWidthEt(CViMapVmiFile *work, u16 id);
NOT_DECOMPILED u16 _ZN13CViMapVmiFile18GetImageTileStartYEt(CViMapVmiFile *work, u16 id);
NOT_DECOMPILED u16 _ZN13CViMapVmiFile18GetImageTileStartXEt(CViMapVmiFile *work, u16 id);

NOT_DECOMPILED void _ZN10CViMapBack7ReleaseEv(CViMapBack *work);
NOT_DECOMPILED void _ZN10CViMapBack16ReleaseImageFileEv(CViMapBack *work);
NOT_DECOMPILED void _ZN10CViMapBack12ReleaseImageEt(CViMapBack *work, u16 id);
NOT_DECOMPILED BOOL _ZN10CViMapBack16CheckImageLoadedEt(CViMapBack *work, u16 id);
NOT_DECOMPILED void _ZN10CViMapBack19LoadImagePixelsFileEt(CViMapBack *work, u16 id);
NOT_DECOMPILED void _ZN10CViMapBack9LoadImageEt(CViMapBack *work, u16 id);
NOT_DECOMPILED void _ZN10CViMapBack20GetSpriteDecorOffsetEPsS0_(CViMapBack *work, s16 *x, s16 *y);
NOT_DECOMPILED void _ZN10CViMapBack23GetSpriteDecorOffsetAltEPsS0_(CViMapBack *work, s16 *x, s16 *y);
}

// --------------------
// TYPES
// --------------------

typedef void (*SpriteDecorConfigFunc)(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset);

// --------------------
// STRUCTS
// --------------------

struct CViMapBackAssetBundle
{
    const char path[20];
};

// --------------------
// VARIABLES
// --------------------

// 	FORCE_INCLUDE_ARRAY(const u16, unusedArr, 6, { 50, 16, 8, 0, 100, 0 });
//
// 	static const Vec2Fx16 viMapBackSpriteDecorPositionList[] = {
// 	    /*[CVIMAPBACK_DECORSPRITE_RADIO_TOWER]          =*/ { 128, 114 },
// 		/*[CVIMAPBACK_DECORSPRITE_BALLOON]              =*/ { 208, 40 },
// 		/*[CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH]     =*/ { 160, 201 },
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_1]          =*/ { 204, 146 },
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_2]          =*/ { 76, 170 },
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_3]          =*/ { 236, 122 },
// 		/*[CVIMAPBACK_DECORSPRITE_SEAGULL]              =*/ { 0, 0 },
// 		/*[CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM]        =*/ { 112, 0 },
// 	    /*[CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL]       =*/ { 93, 95 },
// 		/*[CVIMAPBACK_DECORSPRITE_DINOSAUR]             =*/ { 0, 80 },
// 		/*[CVIMAPBACK_DECORSPRITE_FLAG]                 =*/ { 50, 36 },
// 		/*[CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL]       =*/ { 80, 80 },
// 		/*[CVIMAPBACK_DECORSPRITE_WHALE]                =*/ { 0, 0 },
// 		/*[CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN]        =*/ { 128, 160 },
// 		/*[CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN] =*/ { 128, 160 },
// 	};
//
// 	static const Vec2Fx16 viMapBackSpriteDecorAltPositionList[] = {
// 	    /*[CVIMAPBACK_DECORSPRITE_RADIO_TOWER]          =*/ { 140, 122 },
// 		/*[CVIMAPBACK_DECORSPRITE_BALLOON]              =*/ { 228, 52 },
// 		/*[CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH]     =*/ { 168, 209 },
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_1]          =*/ { 204, 122 },
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_2]          =*/ { 76, 146 },
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_3]          =*/ { 236, 98 },
// 		/*[CVIMAPBACK_DECORSPRITE_SEAGULL]              =*/ { 72, 24 },
// 		/*[CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM]        =*/ { 136, 16 },
// 	    /*[CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL]       =*/ { 101, 103 },
// 		/*[CVIMAPBACK_DECORSPRITE_DINOSAUR]             =*/ { 56, 112 },
// 		/*[CVIMAPBACK_DECORSPRITE_FLAG]                 =*/ { 54, 44 },
// 		/*[CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL]       =*/ { 94, 95 },
// 		/*[CVIMAPBACK_DECORSPRITE_WHALE]                =*/ { 16, 80 },
// 		/*[CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN]        =*/ { 140, 176 },
// 		/*[CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN] =*/ { 140, 176 },
// 	};
//
// 	static const SpriteDecorConfigFunc ViMapBack__spriteDecorConfig1[] = {
// 	    /*[CVIMAPBACK_DECORSPRITE_RADIO_TOWER]          =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_BALLOON]              =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH]     =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_1]          =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_2]          =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_PALM_TREE_3]          =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_SEAGULL]              =*/ CViMapBack::SpriteDecorConfig1_Seagull,
// 		/*[CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM]        =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL]       =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_DINOSAUR]             =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_FLAG]                 =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL]       =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_WHALE]                =*/ CViMapBack::SpriteDecorConfig1_Whale,
// 		/*[CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN]        =*/ NULL,
// 		/*[CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN] =*/ NULL,
// 	};
//
// 	static const SpriteDecorConfigFunc ViMapBack__spriteDecorConfig2[] = {
// 	    /*[CVIMAPBACK_DECORSPRITE_RADIO_TOWER]          =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_BALLOON]              =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH]     =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_PALM_TREE_1]          =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_PALM_TREE_2]          =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_PALM_TREE_3]          =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_SEAGULL]              =*/ CViMapBack::SpriteDecorConfig2_Seagull,
// 	    /*[CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM]        =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL]       =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_DINOSAUR]             =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_FLAG]                 =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL]       =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_WHALE]                =*/ CViMapBack::SpriteDecorConfig2_Whale,
// 	    /*[CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN]        =*/ NULL,
// 	    /*[CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN] =*/ NULL,
// 	};

NOT_DECOMPILED const Vec2Fx16 viMapBackSpriteDecorPositionList[CVIMAPBACK_DECORSPRITE_COUNT];
NOT_DECOMPILED const Vec2Fx16 viMapBackSpriteDecorAltPositionList[CVIMAPBACK_DECORSPRITE_COUNT];

NOT_DECOMPILED const SpriteDecorConfigFunc ViMapBack__spriteDecorConfig1[CVIMAPBACK_DECORSPRITE_COUNT];
NOT_DECOMPILED const SpriteDecorConfigFunc ViMapBack__spriteDecorConfig2[CVIMAPBACK_DECORSPRITE_COUNT];

static const u8 ViMapBack__OamOrderList[] = { SPRITE_ORDER_30, SPRITE_ORDER_30, SPRITE_ORDER_30, SPRITE_ORDER_29, SPRITE_ORDER_30, SPRITE_ORDER_30,
                                              SPRITE_ORDER_30, SPRITE_ORDER_30, SPRITE_ORDER_30, SPRITE_ORDER_30, SPRITE_ORDER_30, SPRITE_ORDER_30,
                                              SPRITE_ORDER_29, SPRITE_ORDER_0,  SPRITE_ORDER_0,  SPRITE_ORDER_0 };

static const CViMapBackAssetBundle mapBackAssets[1] = { { "bb/vi_map_back.bb" } };

NOT_DECOMPILED void *_ZTI13CViMapVmiFile;
NOT_DECOMPILED void *_ZTI13CViMapVmcFile;
NOT_DECOMPILED void *_ZTI13CViMapVmpFile;
NOT_DECOMPILED void *_ZTI10CViMapBack;
NOT_DECOMPILED void *_ZTS10CViMapBack;
NOT_DECOMPILED void *_ZTV13CViMapVmcFile;
NOT_DECOMPILED void *_ZTS13CViMapVmcFile;
NOT_DECOMPILED void *_ZTV13CViMapVmpFile;
NOT_DECOMPILED void *_ZTI13CViMapVmcFile;
NOT_DECOMPILED void *_ZTV13CViMapVmiFile;
NOT_DECOMPILED void *_ZTV10CViMapBack;
NOT_DECOMPILED void *_ZTS13CViMapVmiFile;

// --------------------
// FUNCTIONS
// --------------------

// CViMapVmiFile
// CViMapVmiFile::CViMapVmiFile()
NONMATCH_FUNC void _ZN13CViMapVmiFileC1Ev(CViMapVmiFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmiFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmiFile7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmiFile::~CViMapVmiFile()
NONMATCH_FUNC void _ZN13CViMapVmiFileD0Ev(CViMapVmiFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmiFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmiFile7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmiFile::~CViMapVmiFile()
NONMATCH_FUNC void _ZN13CViMapVmiFileD1Ev(CViMapVmiFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmiFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmiFile7ReleaseEv
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CViMapVmiFile::Release()
{
    this->file   = NULL;
    this->images = NULL;
}

void CViMapVmiFile::Load(void *file)
{
    this->Release();

    this->file   = (CVmiFileHeader *)file;
    this->images = ((CVmiFileHeader *)file)->images;
}

u16 CViMapVmiFile::GetImageCount()
{
    return this->file->imageCount;
}

u16 CViMapVmiFile::GetImagePixelStartX(u16 id)
{
    return TILE_SIZE * this->images[id].startX;
}

u16 CViMapVmiFile::GetImagePixelStartY(u16 id)
{
    return TILE_SIZE * this->images[id].startY;
}

u16 CViMapVmiFile::GetImageTileStartX(u16 id)
{
    return this->images[id].startX;
}

u16 CViMapVmiFile::GetImageTileStartY(u16 id)
{
    return this->images[id].startY;
}

u16 CViMapVmiFile::GetImagePixelWidth(u16 id)
{
    return TILE_SIZE * this->images[id].width;
}

u16 CViMapVmiFile::GetImagePixelHeight(u16 id)
{
    return TILE_SIZE * this->images[id].height;
}

u16 CViMapVmiFile::GetImageTileWidth(u16 id)
{
    return this->images[id].width;
}

u16 CViMapVmiFile::GetImageTileHeight(u16 id)
{
    return this->images[id].height;
}

u16 CViMapVmiFile::GetSortOrder(u16 id)
{
    return this->images[id].sortOrder;
}

// CViMapVmpFile
// CViMapVmpFile::CViMapVmpFile()
NONMATCH_FUNC void _ZN13CViMapVmpFileC1Ev(CViMapVmpFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmpFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmpFile7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmpFile::~CViMapVmpFile()
NONMATCH_FUNC void _ZN13CViMapVmpFileD0Ev(CViMapVmpFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmpFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmpFile7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmpFile::~CViMapVmpFile()
NONMATCH_FUNC void _ZN13CViMapVmpFileD1Ev(CViMapVmpFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmpFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmpFile7ReleaseEv
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CViMapVmpFile::Release()
{
    this->colors = NULL;
}

void CViMapVmpFile::Load(void *file)
{
    this->Release();
    this->colors = (u16 *)file;
}

void *CViMapVmpFile::GetColors()
{
    return this->colors;
}

// CViMapVmcFile
// CViMapVmcFile::CViMapVmcFile()
NONMATCH_FUNC void _ZN13CViMapVmcFileC1Ev(CViMapVmcFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmcFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmcFile7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmcFile::~CViMapVmcFile()
NONMATCH_FUNC void _ZN13CViMapVmcFileD0Ev(CViMapVmcFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmcFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmcFile7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmcFile::~CViMapVmcFile()
NONMATCH_FUNC void _ZN13CViMapVmcFileD1Ev(CViMapVmcFile *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmcFile+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN13CViMapVmcFile7ReleaseEv
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CViMapVmcFile::Release()
{
    this->file = NULL;
}

void CViMapVmcFile::Load(void *file)
{
    this->Release();
    this->file = file;
}

void *CViMapVmcFile::GetPixels()
{
    return this->file;
}

// CViMapBack
// CViMapBack::CViMapBack()
NONMATCH_FUNC void _ZN10CViMapBackC1Ev(CViMapBack *work)
{
#ifdef NON_MATCHING
    this->canvasPixels        = NULL;
    this->imageConfigFile     = NULL;
    this->imagePaletteFile    = NULL;
    this->currentImagePixelFile       = NULL;
    this->imageSortList       = NULL;
    this->imagePixelFileCount = 0;
    this->imagePixelFiles     = NULL;
    this->rippleDeform        = 0;
    this->rippleAngle         = 0;

    FontDMAControl__Init(&this->fontDmaControl);
    MI_CpuClear16(this->aniDecoration, sizeof(this->aniDecoration));

    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, =_ZTV10CViMapBack+0x08
	add r0, r4, #4
	str r1, [r4]
	bl _ZN13CViMapVmiFileC1Ev
	add r0, r4, #0x10
	bl _ZN13CViMapVmpFileC1Ev
	add r0, r4, #0x18
	bl _ZN13CViMapVmcFileC1Ev
	mov r1, #0
	str r1, [r4, #0x40]
	str r1, [r4, #0x20]
	str r1, [r4, #0x24]
	str r1, [r4, #0x28]
	str r1, [r4, #0x44]
	str r1, [r4, #0x2c]
	str r1, [r4, #0x30]
	str r1, [r4, #0x5b8]
	add r0, r4, #0x5c0
	str r1, [r4, #0x5bc]
	bl FontDMAControl__Init
	mov r0, #0
	add r1, r4, #0x8c
	ldr r2, =0x00000514
	bl MIi_CpuClear16
	mov r0, r4
	bl _ZN10CViMapBack7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapBack::~CViMapBack()
NONMATCH_FUNC void _ZN10CViMapBackD0Ev(CViMapBack *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViMapBack+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CViMapBack7ReleaseEv
	add r0, r4, #0x18
	bl _ZN13CViMapVmcFileD0Ev
	add r0, r4, #0x10
	bl _ZN13CViMapVmpFileD0Ev
	add r0, r4, #4
	bl _ZN13CViMapVmiFileD0Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapBack::~CViMapBack()
NONMATCH_FUNC void _ZN10CViMapBackD1Ev(CViMapBack *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViMapBack+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CViMapBack7ReleaseEv
	add r0, r4, #0x18
	bl _ZN13CViMapVmcFileD0Ev
	add r0, r4, #0x10
	bl _ZN13CViMapVmpFileD0Ev
	add r0, r4, #4
	bl _ZN13CViMapVmiFileD0Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CViMapBack::LoadAssets()
{
    u16 paletteRow = PALETTE_ROW_0;

    this->Release();

    this->imageConfigFile = HeapAllocHead(HEAP_USER, GetBundleFileSize(mapBackAssets[0].path, BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_CONFIG_VMI));
    ReadFileFromBundle(mapBackAssets[0].path, BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_CONFIG_VMI, this->imageConfigFile);
    this->vmiFile.Load(this->imageConfigFile);

    this->imagePaletteFile = HeapAllocHead(HEAP_USER, GetBundleFileSize(mapBackAssets[0].path, BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_PALETTE_VMP));
    ReadFileFromBundle(mapBackAssets[0].path, BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_PALETTE_VMP, this->imagePaletteFile);
    this->vmpFile.Load(this->imagePaletteFile);

    this->imagePixelFileCount = this->vmiFile.GetImageCount();
    this->imagePixelFiles     = (void **)HeapAllocHead(HEAP_SYSTEM, sizeof(void *) * this->imagePixelFileCount);
    MIi_CpuClear32(0, this->imagePixelFiles, sizeof(void *) * this->imagePixelFileCount);

    Background background;
    InitBackground(&background, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_MAP_SEA_BBG), BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_B, BACKGROUND_1, 0x40u, 0x20u);
    DrawBackground(&background);

    void *sprMapDecor = HubControl::GetSpriteFile(ARCHIVE_VI_ACT_LZ7_FILE_VI_MAP_DECO_BAC);

    for (s32 i = 0; i < CVIMAPBACK_DECORSPRITE_ANIM_COUNT; i++)
    {
        size_t spriteSize;
        const CViMapBackDecorConfig *config = HubConfig__GetMapBackDecorSpriteConfig(i);

        if (i == CVIMAPBACK_DECORSPRITE_ANIM_SEAGULL)
        {
            spriteSize = Sprite__GetSpriteSize3FromAnim(sprMapDecor, config->animID);

            size_t spriteSize1 = Sprite__GetSpriteSize3FromAnim(sprMapDecor, config->animID + 1);
            if (spriteSize < spriteSize1)
                spriteSize = spriteSize1;

            size_t spriteSize2 = Sprite__GetSpriteSize3FromAnim(sprMapDecor, config->animID + 2);
            if (spriteSize < spriteSize2)
                spriteSize = spriteSize2;
        }
        else
        {
            spriteSize = Sprite__GetSpriteSize3FromAnim(sprMapDecor, config->animID);
        }

        if ((config->flags & CVIMAPDECOR_FLAG_USE_SUB_OBJ) != 0)
        {
            AnimatorSprite__Init(&this->aniDecoration[i], sprMapDecor, config->animID, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                                 VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, spriteSize), PALETTE_MODE_SUB_OBJ, NULL, SPRITE_PRIORITY_2, ViMapBack__OamOrderList[i]);
            this->aniDecoration[i].cParam.palette = paletteRow;
            paletteRow++;
        }
        else
        {
            AnimatorSprite__Init(&this->aniDecoration[i], sprMapDecor, config->animID, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                                 VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, spriteSize), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_2, ViMapBack__OamOrderList[i]);
            this->aniDecoration[i].cParam.palette = PALETTE_ROW_8;
        }

        if ((config->flags & CVIMAPDECOR_FLAG_TRANSPARENT) != 0)
            this->aniDecoration[i].spriteType = GX_OAM_MODE_XLU;
    }

    this->aniDecoration[CVIMAPBACK_DECORSPRITE_ANIM_SEAGULL].flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;
    this->aniDecoration[CVIMAPBACK_DECORSPRITE_ANIM_WHALE].flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;

    MI_CpuClear32(this->decorationFlags, sizeof(this->decorationFlags));
    this->decorAnimTimer = 0;

    FontDMAControl__InitWithParams(&this->fontDmaControl, GRAPHICS_ENGINE_B, BACKGROUND_1, 0);
    FontDMAControl__Func_2051BF4(&this->fontDmaControl, 0);

    this->DrawIslandBackgrounds(0, 0);
}

void CViMapBack::Release()
{
    FontDMAControl__Release(&this->fontDmaControl);

    for (s32 i = 0; i < CVIMAPBACK_DECORSPRITE_ANIM_COUNT; i++)
    {
        AnimatorSprite__Release(&this->aniDecoration[i]);
    }
    MI_CpuClear16(this->aniDecoration, sizeof(this->aniDecoration));

    this->vmiFile.Release();
    this->vmpFile.Release();
    this->vmcFile.Release();

    if (this->canvasPixels != NULL)
    {
        HeapFree(HEAP_USER, this->canvasPixels);
        this->canvasPixels = NULL;
    }

    if (this->imageConfigFile != NULL)
    {
        HeapFree(HEAP_USER, this->imageConfigFile);
        this->imageConfigFile = NULL;
    }

    if (this->imagePaletteFile != NULL)
    {
        HeapFree(HEAP_USER, this->imagePaletteFile);
        this->imagePaletteFile = NULL;
    }

    if (this->currentImagePixelFile != NULL)
    {
        HeapFree(HEAP_USER, this->currentImagePixelFile);
        this->currentImagePixelFile = NULL;
    }

    if (this->imageSortList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->imageSortList);
        this->imageSortList = NULL;
    }

    if (this->imagePixelFiles != NULL)
    {
        for (u32 i = 0; i < this->imagePixelFileCount; i++)
        {
            if (this->imagePixelFiles[i] != NULL)
            {
                HeapFree(HEAP_USER, this->imagePixelFiles[i]);
                this->imagePixelFiles[i] = NULL;
            }
        }

        HeapFree(HEAP_SYSTEM, this->imagePixelFiles);
        this->imagePixelFiles = NULL;
    }

    this->imagePixelFileCount     = 0;
    this->imageSortListChunkCount = 0;
    this->imageSortListCount      = 0;
    this->blitImageID             = 0xFFFF;
    this->canvasPaletteRow        = 0;
    this->vramPixels              = NULL;
    this->vramMappings            = NULL;
    this->mappingStartTile        = 0;
}

void CViMapBack::GetImageSize(u16 id, u16 *startX, u16 *startY, u16 *width, u16 *height)
{
    if (startX != NULL)
        *startX = this->vmiFile.GetImageTileStartX(id);

    if (startY != NULL)
        *startY = this->vmiFile.GetImageTileStartY(id);

    if (width != NULL)
        *width = this->vmiFile.GetImageTileWidth(id);

    if (height != NULL)
        *height = this->vmiFile.GetImageTileHeight(id);
}

void CViMapBack::GetImageCenter(u16 id, u16 *x, u16 *y)
{
    if (x != NULL)
        *x = this->vmiFile.GetImagePixelStartX(id) + (this->vmiFile.GetImagePixelWidth(id) >> 1);

    if (y != NULL)
        *y = this->vmiFile.GetImagePixelStartY(id) + (this->vmiFile.GetImagePixelHeight(id) >> 1);
}

void CViMapBack::LoadImage(u16 id)
{
    if (this->CheckImageLoaded(id) == FALSE)
    {
        this->imagePixelFiles[id] = HeapAllocHead(HEAP_USER, GetBundleFileSize(mapBackAssets[0].path, id + BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_VMC));
        ReadFileFromBundle(mapBackAssets[0].path, id + BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_VMC, this->imagePixelFiles[id]);
    }
}

void CViMapBack::LoadAllImages()
{
    for (u32 i = 0; i < this->imagePixelFileCount; i++)
    {
        this->LoadImage(i);
    }
}

BOOL CViMapBack::CheckImageLoaded(u16 id)
{
    return this->imagePixelFiles[id] != NULL;
}

void CViMapBack::ReleaseImage(u16 id)
{
    if (this->CheckImageLoaded(id) && this->imagePixelFiles[id] != NULL)
    {
        HeapFree(HEAP_USER, this->imagePixelFiles[id]);
        this->imagePixelFiles[id] = NULL;
    }
}

void CViMapBack::AddActiveImage(u16 id)
{
    // create a list if it doesn't exist
    if (this->imageSortList == NULL)
    {
        this->imageSortList           = (u16 *)HeapAllocTail(HEAP_SYSTEM, 32 * sizeof(u16));
        this->imageSortListCount      = 0;
        this->imageSortListChunkCount = 1;
    }

    // re-allocate the list if it's bigger than the chunk count
    if (this->imageSortListCount >= 32 * this->imageSortListChunkCount)
    {
        this->imageSortListChunkCount++;

        void *prevSortList  = this->imageSortList;
        this->imageSortList = (u16 *)HeapAllocTail(HEAP_SYSTEM, this->imageSortListChunkCount * 32 * sizeof(u16));
        MIi_CpuCopy16(prevSortList, this->imageSortList, this->imageSortListCount);
        HeapFree(HEAP_SYSTEM, prevSortList);
    }

    this->imageSortList[this->imageSortListCount++] = id;
}

void CViMapBack::LoadSortedImagesOntoCanvas()
{
    this->blitImageID = 0xFFFF;
    this->SortImages();

    this->canvasPixels = (CViMapBackCanvas *)HeapAllocTail(HEAP_USER, sizeof(*this->canvasPixels));
    MI_CpuClearFast(this->canvasPixels, sizeof(*this->canvasPixels));
    for (s32 i = 0; i < this->imageSortListCount; i++)
    {
        this->LoadImagePixelsOntoCanvas(this->imageSortList[i]);
    }
    DC_StoreRange(this->canvasPixels, sizeof(*this->canvasPixels));

    if (this->imageSortList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->imageSortList);
        this->imageSortList = NULL;
    }

    this->imageSortListCount      = 0;
    this->imageSortListChunkCount = 0;
}

void CViMapBack::InitImageBlitter(u16 id)
{
    this->blitImageID = id;
    this->SortImages();
    this->blitImageStartX = this->vmiFile.GetImageTileStartX(id);
    this->blitImageStartY = this->vmiFile.GetImageTileStartY(id);
    this->blitImageWidth  = this->vmiFile.GetImageTileWidth(id);
    this->blitImageHeight = this->vmiFile.GetImageTileHeight(id);

    s32 i;
    size_t size        = this->blitImageHeight * (this->blitImageWidth * sizeof(GXCharFmt256));
    this->canvasPixels = (CViMapBackCanvas *)HeapAllocTail(HEAP_USER, size);
    MI_CpuClearFast(this->canvasPixels, size);
    for (i = 0; i < this->imageSortListCount; i++)
    {
        this->BlitImageToCanvas(this->imageSortList[i], this->blitImageStartX, this->blitImageStartY, this->blitImageWidth, this->blitImageHeight);
    }
    DC_StoreRange(this->canvasPixels, size);

    if (this->imageSortList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->imageSortList);
        this->imageSortList = NULL;
    }

    this->imageSortListCount      = 0;
    this->imageSortListChunkCount = 0;
}

// selected image will be blit to the canvas last
void CViMapBack::InitImageBlitterForHighPriorityImage(u16 id)
{
    s32 i;
    s32 j;

    this->blitImageID = id;
    this->SortImages();
    this->blitImageStartX = this->vmiFile.GetImageTileStartX(id);
    this->blitImageStartY = this->vmiFile.GetImageTileStartY(id);
    this->blitImageWidth  = this->vmiFile.GetImageTileWidth(id);
    this->blitImageHeight = this->vmiFile.GetImageTileHeight(id);

    size_t canvasSize = this->blitImageHeight * (this->blitImageWidth * sizeof(GXCharFmt256));

    this->canvasPixels = (CViMapBackCanvas *)HeapAllocTail(HEAP_USER, canvasSize);
    MI_CpuClearFast(this->canvasPixels, canvasSize);

    CViMapBackCanvas *newCanvas = (CViMapBackCanvas *)HeapAllocTail(HEAP_USER, canvasSize);
    MI_CpuClearFast(newCanvas, canvasSize);

    s32 unknown = 0;
    for (; unknown < this->imageSortListCount; unknown++)
    {
        if (id == this->imageSortList[unknown])
            break;
    }

    for (i = unknown + 1; i < this->imageSortListCount; i++)
    {
        if (id != this->imageSortList[i])
            this->BlitImageToCanvas(this->imageSortList[i], this->blitImageStartX, this->blitImageStartY, this->blitImageWidth, this->blitImageHeight);
    }

    CViMapBackCanvas *oldCanvas = this->canvasPixels;
    this->canvasPixels          = (CViMapBackCanvas *)newCanvas;

    this->BlitImageToCanvas(id, this->blitImageStartX, this->blitImageStartY, this->blitImageWidth, this->blitImageHeight);

    u8 *oldCanvasPtr = (u8 *)oldCanvas;
    for (i = 0; i < canvasSize; i += 4)
    {
        u8 *ptr = &oldCanvasPtr[i];
        if (*((u32 *)ptr) != 0) // check if the next 4 bytes are all 0, skip the check if so!
        {
            for (j = 0; j < 4; j++)
            {
                if (*ptr != 0)
                    ((u8 *)this->canvasPixels)[i + j] = 0;

                ptr++;
            }
        }
    }
    HeapFree(HEAP_USER, oldCanvas);
    DC_StoreRange(this->canvasPixels, canvasSize);

    if (this->imageSortList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->imageSortList);
        this->imageSortList = NULL;
    }
    this->imageSortListCount      = 0;
    this->imageSortListChunkCount = 0;
}

void CViMapBack::ReleaseImageBlitter()
{
    this->ReleaseImageFile();

    if (this->canvasPixels != NULL)
    {
        HeapFree(HEAP_USER, this->canvasPixels);
        this->canvasPixels = NULL;
    }

    if (this->imageSortList != NULL)
    {
        HeapFree(HEAP_SYSTEM, this->imageSortList);
        this->imageSortList = NULL;
    }

    this->imageSortListChunkCount = 0;
    this->imageSortListCount      = 0;
    this->blitImageID             = 0xFFFF;
}

void *CViMapBack::GetCanvasPalette()
{
    return this->vmpFile.GetColors();
}

void CViMapBack::CopyToCanvas(void *pixels, u16 startX, u16 startY, u16 width, u16 height)
{
    if (this->blitImageID >= this->vmiFile.GetImageCount())
    {
        BackgroundUnknown__Func_204CB40(this->canvasPixels, 36, TILE_SIZE * startX, TILE_SIZE * startY, TILE_SIZE * width, TILE_SIZE * height, pixels, width, 0, 0, 0);
    }
    else
    {
        BackgroundUnknown__Func_204CB40(this->canvasPixels, this->blitImageWidth, TILE_SIZE * startX, TILE_SIZE * startY, TILE_SIZE * width, TILE_SIZE * height, pixels, width, 0,
                                        0, 0);
    }
}

void CViMapBack::UpdateCanvasVRAMPalette(u16 paletteRow, u16 unknown)
{
    this->canvasPaletteRow = paletteRow;
    LoadUncompressedPalette(this->vmpFile.GetColors(), 0x100, PALETTE_MODE_SUB_BG, VRAMKEY_TO_KEY(this->canvasPaletteRow * 0x100 * sizeof(GXRgb)));
}

NONMATCH_FUNC void CViMapBack::BlitCanvasPixels(void *vramPixels, BOOL queuePixels)
{
    // https://decomp.me/scratch/inz6i -> 95.94%
#ifdef NON_MATCHING
    this->vramPixels = (CViMapBackCanvas *)vramPixels;

    if (this->blitImageID >= this->vmiFile.GetImageCount())
    {
        if (queuePixels)
            QueueUncompressedPixels(this->canvasPixels, sizeof(CViMapBackCanvas), PIXEL_MODE_SPRITE, (void *)this->vramPixels);
        else
            LoadUncompressedPixels(this->canvasPixels, sizeof(CViMapBackCanvas), PIXEL_MODE_SPRITE, (void *)this->vramPixels);
    }
    else
    {
        s32 y;
        u32 width;
        u8 *srcPixels;
        u8 *dstPixels;

        GXCharFmt256 *dst = &this->vramPixels->pixels[this->blitImageStartY][this->blitImageStartX];
        dstPixels         = (u8 *)dst;

        width     = this->blitImageWidth;
        srcPixels = (u8 *)this->canvasPixels;

        for (y = 0; y < this->blitImageHeight; y++)
        {
            if (queuePixels)
                QueueUncompressedPixels(srcPixels, this->blitImageWidth * sizeof(GXCharFmt256), PIXEL_MODE_SPRITE, dstPixels);
            else
                LoadUncompressedPixels(srcPixels, this->blitImageWidth * sizeof(GXCharFmt256), PIXEL_MODE_SPRITE, dstPixels);

            srcPixels += width * sizeof(GXCharFmt256);
            dstPixels += 36 * sizeof(GXCharFmt256);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	str r1, [r10, #0x5a8]
	add r0, r10, #4
	mov r9, r2
	bl _ZN13CViMapVmiFile13GetImageCountEv
	ldr r1, [r10, #0x34]
	cmp r1, r0
	blt _02161F88
	cmp r9, #0
	ldr r0, [r10, #0x40]
	mov r1, #0xfc00
	ldr r3, [r10, #0x5a8]
	mov r2, #0
	beq _02161F80
	bl QueueUncompressedPixels
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02161F80:
	bl LoadUncompressedPixels
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02161F88:
	ldrh r0, [r10, #0x3a]
	ldrh r1, [r10, #0x3e]
	ldrh r3, [r10, #0x38]
	ldr r2, [r10, #0x5a8]
	add r0, r0, r0, lsl #3
	add r0, r2, r0, lsl #8
	ldrh r5, [r10, #0x3c]
	ldr r7, [r10, #0x40]
	add r8, r0, r3, lsl #6
	mov r6, #0
	cmp r1, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r11, r6
	mov r4, r6
_02161FC0:
	cmp r9, #0
	ldrh r1, [r10, #0x3c]
	mov r0, r7
	beq _02161FE4
	mov r2, r4
	mov r3, r8
	mov r1, r1, lsl #6
	bl QueueUncompressedPixels
	b _02161FF4
_02161FE4:
	mov r2, r11
	mov r3, r8
	mov r1, r1, lsl #6
	bl LoadUncompressedPixels
_02161FF4:
	ldrh r0, [r10, #0x3e]
	add r6, r6, #1
	add r7, r7, r5, lsl #6
	cmp r6, r0
	add r8, r8, #0x900
	blt _02161FC0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CViMapBack::UpdateCanvasVRAMMappings(void *vramMappings, s32 startTile)
{
    // https://decomp.me/scratch/SqvkS -> 98.98%
    // minor register issues
#ifdef NON_MATCHING
    s32 x;
    s32 y;
    GXScrFmtText *mappingsPtr;
    s32 srcRow;
    s32 row;

    this->vramMappings     = (GXScrText64x32 *)vramMappings;
    this->mappingStartTile = startTile;
    MI_CpuFill16(this->vramMappings, VRAM_SCRFMT_TEXT(0, FALSE, FALSE, this->canvasPaletteRow), sizeof(GXScrText64x32));

    mappingsPtr = &this->vramMappings->scr[0][0];
    y           = 0;
    srcRow      = 0;
    row         = 0;
    for (; y < 28; y++)
    {
        for (x = 0; x < 32; x++)
        {
            u16 tile = (x + srcRow) + this->mappingStartTile;
            mappingsPtr[row + x] |= tile;
        }
        srcRow += 36;
        row += 32;
    }

    mappingsPtr = &this->vramMappings->scr[32][0];
    y           = 0;
    srcRow      = 0;
    row         = 0;
    for (; y < 28; y++)
    {
        for (x = 32; x < 36; x++)
        {
            u16 tile = (x + srcRow) + this->mappingStartTile;
            mappingsPtr[row + (x - 32)] |= tile;
        }

        srcRow += 36;
        row += 32;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, r0
	str r1, [r4, #0x5ac]
	str r2, [r4, #0x5b0]
	add r0, r4, #0x500
	ldrh r0, [r0, #0xa4]
	ldr r1, [r4, #0x5ac]
	mov r2, #0x1000
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
	mov ip, #0
	ldr lr, [r4, #0x5ac]
	mov r5, ip
	mov r6, ip
	mov r2, ip
_02162050:
	mov r3, r2
	add r1, lr, r6, lsl #1
_02162058:
	mov r0, r3, lsl #1
	add r7, r3, r5
	ldr r8, [r4, #0x5b0]
	ldrh r9, [r1, r0]
	add r7, r8, r7
	mov r7, r7, lsl #0x10
	orr r7, r9, r7, lsr #16
	add r3, r3, #1
	strh r7, [r1, r0]
	cmp r3, #0x20
	blt _02162058
	add ip, ip, #1
	cmp ip, #0x1c
	add r5, r5, #0x24
	add r6, r6, #0x20
	blt _02162050
	ldr r0, [r4, #0x5ac]
	mov r6, #0
	mov r3, r6
	mov ip, r6
	add r5, r0, #0x800
	mov r2, #0x20
_021620B0:
	mov lr, r2
	add r0, r5, ip, lsl #1
_021620B8:
	add r1, r0, lr, lsl #1
	add r7, lr, r3
	ldr r8, [r4, #0x5b0]
	ldrh r9, [r1, #-0x40]
	add r7, r8, r7
	mov r7, r7, lsl #0x10
	orr r7, r9, r7, lsr #16
	add lr, lr, #1
	strh r7, [r1, #-0x40]
	cmp lr, #0x24
	blt _021620B8
	add r6, r6, #1
	cmp r6, #0x1c
	add r3, r3, #0x24
	add ip, ip, #0x20
	blt _021620B0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void CViMapBack::SetDecorationActive(u16 id)
{
    this->decorationFlags[id] |= CViMapBack::DECOR_FLAG_ACTIVE;
}

void CViMapBack::ProcessDecorationAnims()
{
    for (s32 i = 0; i < CVIMAPBACK_DECORSPRITE_ANIM_COUNT; i++)
    {
        AnimatorSprite__ProcessAnimationFast(&this->aniDecoration[i]);
    }

    this->decorAnimTimer++;
}

void CViMapBack::DrawAllSpriteDecorations(BOOL a2)
{
    AnimatorSprite *aniDecoration;

    for (s32 type = 0; type < CVIMAPBACK_DECORSPRITE_COUNT; type++)
    {
        if ((this->decorationFlags[type] & CViMapBack::DECOR_FLAG_ACTIVE) == 0)
            continue;

        // doesn't do anything, but it does't compile without this
        BOOL flag = FALSE;
        if (type == CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL)
        {
            if ((this->decorationFlags[CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL] & CViMapBack::DECOR_FLAG_ACTIVE) != 0)
            {
                continue;
            }
            else
            {
                flag = TRUE;
            }
        }
        else if (type == CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN)
        {
            if ((this->decorationFlags[CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN] & CViMapBack::DECOR_FLAG_ACTIVE) != 0)
            {
                continue;
            }
            else
            {
                flag = TRUE;
            }
        }

        aniDecoration = &this->aniDecoration[*HubConfig__GetMapBackDecorSpriteAnimator(type)];

        SpriteDecorConfigFunc configureFunc;
        if (a2)
            configureFunc = ViMapBack__spriteDecorConfig2[type];
        else
            configureFunc = ViMapBack__spriteDecorConfig1[type];

        s16 x;
        s16 y;
        s16 oamPriority;
        u16 animID;
        u16 scale;
        BOOL flipX;
        BOOL isInvisible;
        BOOL useAltOffset;
        if (configureFunc == NULL)
        {
            x = viMapBackSpriteDecorPositionList[type].x;
            y = viMapBackSpriteDecorPositionList[type].y;
            this->GetSpriteDecorOffset(&x, &y);
            this->DrawSpriteDecoration(aniDecoration, x, y, FLOAT_TO_FX32(1.0));
        }
        else
        {

            configureFunc(this->decorAnimTimer, &x, &y, &oamPriority, &animID, &scale, &flipX, &isInvisible, &useAltOffset);
            if (animID != 0xFFFF)
            {
                if (aniDecoration->animID != animID || isInvisible)
                    AnimatorSprite__SetAnimation(aniDecoration, animID);

                aniDecoration->oamPriority = oamPriority;
                aniDecoration->flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;

                if (flipX)
                    aniDecoration->flags |= ANIMATOR_FLAG_FLIP_X;
                else
                    aniDecoration->flags &= ~ANIMATOR_FLAG_FLIP_X;

                if (useAltOffset)
                    this->GetSpriteDecorOffsetAlt(&x, &y);
                else
                    this->GetSpriteDecorOffset(&x, &y);

                if (!isInvisible)
                    this->DrawSpriteDecoration(aniDecoration, x, y, scale);
            }
        }
    }
}

void CViMapBack::DrawSingleSpriteDecoration(u16 id, BOOL a3)
{
    AnimatorSprite *aniDecoration;

    if (HubConfig__CheckDecorConstructionIsBackground(id) == FALSE)
    {
        u16 type = *HubConfig__GetMapBackDecorID(id);
        if ((this->decorationFlags[type] & CViMapBack::DECOR_FLAG_ACTIVE) != 0)
        {
            aniDecoration = &this->aniDecoration[*HubConfig__GetMapBackDecorSpriteAnimator(type)];

            SpriteDecorConfigFunc configureFunc;
            if (a3)
                configureFunc = ViMapBack__spriteDecorConfig2[type];
            else
                configureFunc = ViMapBack__spriteDecorConfig1[type];

            s16 x;
            s16 y;
            s16 oamPriority;
            u16 animID;
            u16 scale;
            BOOL flipX;
            BOOL isInvisible;
            BOOL useAltOffset;
            if (configureFunc == NULL)
            {
                x = viMapBackSpriteDecorPositionList[type].x;
                y = viMapBackSpriteDecorPositionList[type].y;
                this->GetSpriteDecorOffset(&x, &y);
                scale = FLOAT_TO_FX32(1.0);
            }
            else
            {
                configureFunc(this->decorAnimTimer, &x, &y, &oamPriority, &animID, &scale, &flipX, &isInvisible, &useAltOffset);

                if (animID == 0xFFFF)
                    return;

                if (aniDecoration->animID != animID || isInvisible)
                    return;

                aniDecoration->oamPriority = oamPriority;
                aniDecoration->flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;

                if (flipX)
                    aniDecoration->flags |= ANIMATOR_FLAG_FLIP_X;
                else
                    aniDecoration->flags &= ~ANIMATOR_FLAG_FLIP_X;

                if (useAltOffset)
                    this->GetSpriteDecorOffsetAlt(&x, &y);
                else
                    this->GetSpriteDecorOffset(&x, &y);
            }

            aniDecoration->spriteType  = GX_OAM_MODE_OBJWND;
            oamPriority                = aniDecoration->oamPriority;
            aniDecoration->oamPriority = 0;
            this->DrawSpriteDecoration(aniDecoration, x, y, scale);
            aniDecoration->oamPriority = oamPriority;
            aniDecoration->spriteType  = GX_OAM_MODE_NORMAL;
        }
    }
}

NONMATCH_FUNC void CViMapBack::DrawNewlyConstructedSpriteDecoration(u16 id, u16 *x, u16 *y, BOOL useAltConfigFunc, BOOL useAltPositions)
{
    // https://decomp.me/scratch/tjEr2 -> 94.25%
    // minor register issues near 'CViMapBack::GetSpriteDecorOffset'
#ifdef NON_MATCHING
    if (HubConfig__CheckDecorConstructionIsBackground(id) == FALSE)
    {
        u16 type = *HubConfig__GetMapBackDecorID(id);
        if ((this->decorationFlags[type] & CViMapBack::DECOR_FLAG_ACTIVE) != 0)
        {
            SpriteDecorConfigFunc configureFunc;
            if (useAltConfigFunc)
                configureFunc = ViMapBack__spriteDecorConfig2[type];
            else
                configureFunc = ViMapBack__spriteDecorConfig1[type];

            s16 oamPriority;
            u16 animID;
            u16 scale;
            BOOL flipX;
            BOOL isInvisible;
            BOOL useAltOffset;
            if (configureFunc == NULL)
            {
                s16 y2;
                s16 x2;
                if (a6)
                {
                    x2 = viMapBackSpriteDecorAltPositionList[type].x;
                    y2 = viMapBackSpriteDecorAltPositionList[type].y;
                }
                else
                {
                    x2 = viMapBackSpriteDecorPositionList[type].x;
                    y2 = viMapBackSpriteDecorPositionList[type].y;
                }

                *x = x2;
                *y = y2;
                this->GetSpriteDecorOffset((s16 *)x, (s16 *)y);
            }
            else
            {
                configureFunc(this->decorAnimTimer, (s16 *)x, (s16 *)y, &oamPriority, &animID, &scale, &flipX, &isInvisible, &useAltOffset);
                if (useAltOffset)
                    this->GetSpriteDecorOffsetAlt((s16 *)x, (s16 *)y);
                else
                    this->GetSpriteDecorOffset((s16 *)x, (s16 *)y);
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	mov r7, r1
	mov r6, r0
	mov r0, r7
	mov r5, r2
	mov r4, r3
	bl HubConfig__CheckDecorConstructionIsBackground
	cmp r0, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r7
	bl HubConfig__GetMapBackDecorID
	ldrh r2, [r0, #0]
	add r0, r6, r2, lsl #2
	ldr r0, [r0, #0x50]
	tst r0, #1
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x40]
	cmp r0, #0
	ldrne r0, =ViMapBack__spriteDecorConfig2
	ldreq r0, =ViMapBack__spriteDecorConfig1
	ldr ip, [r0, r2, lsl #2]
	cmp ip, #0
	bne _021625BC
	ldr r0, [sp, #0x44]
	cmp r0, #0
	ldreq r1, =viMapBackSpriteDecorPositionList
	moveq r2, r2, lsl #2
	ldreq r0, =viMapBackSpriteDecorPositionList+2
	beq _02162594
	ldr r1, =viMapBackSpriteDecorAltPositionList
	ldr r0, =viMapBackSpriteDecorAltPositionList+2
	mov r2, r2, lsl #2
_02162594:
	ldrsh r1, [r1, r2]
	ldrsh r0, [r0, r2]
	mov r2, r4
	strh r1, [r5]
	strh r0, [r4]
	mov r0, r6
	mov r1, r5
	bl _ZN10CViMapBack20GetSpriteDecorOffsetEPsS0_
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021625BC:
	add r0, sp, #0x16
	str r0, [sp]
	add r1, sp, #0x14
	str r1, [sp, #4]
	add r0, sp, #0x24
	str r0, [sp, #8]
	add r1, sp, #0x20
	str r1, [sp, #0xc]
	add r0, sp, #0x1c
	str r0, [sp, #0x10]
	add r0, r6, #0x500
	ldrh r0, [r0, #0xa0]
	add r3, sp, #0x18
	mov r1, r5
	mov r2, r4
	blx ip
	ldr r0, [sp, #0x1c]
	mov r1, r5
	cmp r0, #0
	mov r0, r6
	beq _02162620
	mov r2, r4
	bl _ZN10CViMapBack23GetSpriteDecorOffsetAltEPsS0_
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02162620:
	mov r2, r4
	bl _ZN10CViMapBack20GetSpriteDecorOffsetEPsS0_
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void CViMapBack::DrawIslandBackgrounds(s16 x, s16 y)
{
    this->bgIslandPosX = x;
    this->bgIslandPosY = y;

    s32 background1PosY = (3 * y) >> 2;

    RenderCoreGFXControl *gfxControl       = VRAMSystem__GFXControl[GRAPHICS_ENGINE_B];
    gfxControl->bgPosition[BACKGROUND_0].x = this->bgIslandPosX - 24;
    gfxControl->bgPosition[BACKGROUND_0].y = this->bgIslandPosY - 16;
    gfxControl->bgPosition[BACKGROUND_1].y = background1PosY;

    s32 deformStart;
    if (background1PosY < 96)
    {
        s32 value = ((3 * (this->bgIslandPosX + 128)) >> 2);

        deformStart = 96 - background1PosY;
        value += FX32_TO_WHOLE(this->rippleDeform);

        FontDMAControl__Func_2051CD8(&this->fontDmaControl, 0, deformStart, value);
    }
    else
    {
        deformStart = 0;
    }

    if (deformStart <= (HW_LCD_HEIGHT - 1))
    {
        s32 offset          = FX32_FROM_WHOLE(this->bgIslandPosX) >> 1;
        s32 amplitudeStep   = FX_DivS32(FLOAT_TO_FX32(64.0), 160);
        s32 posAcceleration = FX_DivS32(-FLOAT_TO_FX32(28.0), 160);
        s32 offsetStep      = FX_DivS32(offset, 160);
        FontDMAControl__SetHubWaterRipple(&this->fontDmaControl, deformStart, HW_LCD_HEIGHT - 1, offset, offsetStep, 0, amplitudeStep, FLOAT_TO_FX32(32.0), posAcceleration,
                                          this->rippleAngle);
    }

    FontDMAControl__PrepareSwapBuffer(&this->fontDmaControl);

    this->rippleDeform += 128;
    this->rippleAngle += 4096;
}

void CViMapBack::GetIslandPos(s16 *x, s16 *y)
{
    if (x != NULL)
        *x = this->bgIslandPosX;

    if (y != NULL)
        *y = this->bgIslandPosY;
}

void CViMapBack::GetDecorationImagePosition(u16 id, u16 *x, u16 *y)
{
    if (x != NULL)
        *x = viMapBackSpriteDecorAltPositionList[id].x;

    if (y != NULL)
        *y = viMapBackSpriteDecorAltPositionList[id].y;
}

void CViMapBack::SortImages()
{
    if (this->imageSortListCount != 1)
    {
        for (s32 i = 1; i < this->imageSortListCount; i++)
        {
            for (s32 j = this->imageSortListCount - 1; j >= i; j--)
            {
                if (this->vmiFile.GetSortOrder(this->imageSortList[j]) < this->vmiFile.GetSortOrder(this->imageSortList[j - 1]))
                {
                    u16 temp                   = this->imageSortList[j - 1];
                    this->imageSortList[j - 1] = this->imageSortList[j];
                    this->imageSortList[j]     = temp;
                }
            }
        }
    }
}

void CViMapBack::LoadImagePixelsOntoCanvas(u16 id)
{
    u16 startX = this->vmiFile.GetImageTileStartX(id);
    u16 startY = this->vmiFile.GetImageTileStartY(id);
    u16 width  = this->vmiFile.GetImageTileWidth(id);
    u16 height = this->vmiFile.GetImageTileHeight(id);

    BOOL flag = FALSE;
    if (this->CheckImageLoaded(id) == FALSE)
    {
        this->LoadImage(id);
        flag = TRUE;
    }

    this->LoadImagePixelsFile(id);
    BackgroundUnknown__Func_204CB98(this->vmcFile.GetPixels(), width, 0, 0, TILE_SIZE * width, TILE_SIZE * height, this->canvasPixels, 36, TILE_SIZE * startX, TILE_SIZE * startY,
                                    0);
    this->ReleaseImageFile();

    if (flag)
        this->ReleaseImage(id);
}

NONMATCH_FUNC void CViMapBack::BlitImageToCanvas(u16 id, u16 startX, u16 startY, u16 width, u16 height)
{
    // https://decomp.me/scratch/PO1Ip -> 52.96%
#ifdef NON_MATCHING
    u16 imageTileStartX = this->vmiFile.GetImageTileStartX(id);
    u16 imageTileStartY = this->vmiFile.GetImageTileStartY(id);
    u16 imageTileWidth  = this->vmiFile.GetImageTileWidth(id);
    u16 imageTileHeight = this->vmiFile.GetImageTileHeight(id);

    s32 smallestStartX = startX;
    s32 smallestStartY = startY;
    s32 largestStartX  = imageTileStartX;
    s32 largestStartY  = imageTileStartY;
    s32 newTileWidth   = width;
    s32 newTileHeight  = height;

    if (startX < imageTileStartX)
    {
        newTileWidth   = width - (imageTileStartX - startX);
        smallestStartX = imageTileStartX;
    }
    else if (startX > imageTileStartX)
    {
        largestStartX = startX;
    }

    if ((startX + width) > (imageTileStartX + imageTileWidth))
        newTileWidth -= (startX + width) - (imageTileStartX + imageTileWidth);

    if (newTileWidth <= 0)
        return;

    if (startY < imageTileStartY)
    {
        newTileHeight -= (imageTileStartY - startY);
        smallestStartY = imageTileStartY;
    }
    else if (startY > imageTileStartY)
    {
        largestStartY = startY;
    }

    if ((startY + height) > (imageTileStartY + imageTileHeight))
        newTileHeight -= (startY + height) - (imageTileStartY + imageTileHeight);

    if (newTileHeight <= 0)
        return;

    u16 newSizeX2     = smallestStartX - startX;
    u16 newSizeY2     = smallestStartY - startY;
    u16 newTileStartX = largestStartX - imageTileStartX;
    u16 newTileStartY = largestStartY - imageTileStartY;

    BOOL needsRelease = FALSE;
    if (this->CheckImageLoaded(id) == FALSE)
    {
        this->LoadImage(id);
        needsRelease = TRUE;
    }
    this->LoadImagePixelsFile(id);

    BackgroundUnknown__Func_204CB98(this->vmcFile.GetPixels(), imageTileWidth, TILE_SIZE * newTileStartX, TILE_SIZE * newTileStartY, TILE_SIZE * newTileWidth,
                                    TILE_SIZE * newTileHeight, this->canvasPixels, width, TILE_SIZE * newSizeX2, TILE_SIZE * newSizeY2, 0);

    this->ReleaseImageFile();
    if (needsRelease)
        this->ReleaseImage(id);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	mov r10, r0
	mov r11, r1
	add r0, r10, #4
	mov r9, r2
	mov r8, r3
	bl _ZN13CViMapVmiFile18GetImageTileStartXEt
	mov r4, r0
	mov r1, r11
	add r0, r10, #4
	bl _ZN13CViMapVmiFile18GetImageTileStartYEt
	mov r5, r0
	mov r1, r11
	add r0, r10, #4
	bl _ZN13CViMapVmiFile17GetImageTileWidthEt
	str r0, [sp, #0x2c]
	add r0, r10, #4
	mov r1, r11
	bl _ZN13CViMapVmiFile18GetImageTileHeightEt
	str r9, [sp, #0x28]
	str r8, [sp, #0x24]
	str r4, [sp, #0x20]
	cmp r9, r4
	str r5, [sp, #0x1c]
	ldrh r6, [sp, #0x58]
	ldrh r7, [sp, #0x5c]
	bhs _021629F4
	sub r1, r4, r9
	sub r6, r6, r1
	str r4, [sp, #0x28]
	b _021629FC
_021629F4:
	cmp r9, r4
	strhi r9, [sp, #0x20]
_021629FC:
	ldr r1, [sp, #0x2c]
	add r2, r4, r1
	ldrh r1, [sp, #0x58]
	add r1, r9, r1
	cmp r1, r2
	blt _02162A1C
	subgt r1, r1, r2
	subgt r6, r6, r1
_02162A1C:
	cmp r6, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, r5
	bhs _02162A40
	sub r1, r5, r8
	sub r7, r7, r1
	str r5, [sp, #0x24]
	b _02162A44
_02162A40:
	strhi r8, [sp, #0x1c]
_02162A44:
	add r1, r5, r0
	ldrh r0, [sp, #0x5c]
	add r0, r8, r0
	cmp r0, r1
	blt _02162A60
	subgt r0, r0, r1
	subgt r7, r7, r0
_02162A60:
	cmp r7, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	sub r2, r1, r8
	ldr r1, [sp, #0x20]
	sub r0, r0, r9
	sub r3, r1, r4
	ldr r1, [sp, #0x1c]
	mov r2, r2, lsl #0x10
	sub r4, r1, r5
	mov r1, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x28]
	mov r1, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	str r1, [sp, #0x24]
	mov r1, r3, lsr #0x10
	mov r4, r4, lsl #0x10
	str r1, [sp, #0x20]
	mov r1, r4, lsr #0x10
	str r1, [sp, #0x1c]
	mov r0, r10
	mov r1, r11
	mov r8, #0
	bl _ZN10CViMapBack16CheckImageLoadedEt
	cmp r0, #0
	bne _02162AE4
	mov r0, r10
	mov r1, r11
	bl _ZN10CViMapBack9LoadImageEt
	mov r8, #1
_02162AE4:
	mov r0, r10
	mov r1, r11
	bl _ZN10CViMapBack19LoadImagePixelsFileEt
	add r0, r10, #0x18
	bl _ZN13CViMapVmcFile9GetPixelsEv
	mov r1, r6, lsl #0x13
	mov r1, r1, lsr #0x10
	str r1, [sp]
	mov r1, r7, lsl #0x13
	mov r1, r1, lsr #0x10
	str r1, [sp, #4]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x20]
	mov r1, r1, lsl #0x13
	mov r5, r1, lsr #0x10
	ldr r1, [sp, #0x24]
	ldr r3, [sp, #0x1c]
	mov r1, r1, lsl #0x13
	mov r4, r1, lsr #0x10
	mov r2, r2, lsl #0x13
	mov r3, r3, lsl #0x13
	ldr r1, [sp, #0x2c]
	ldr r6, [r10, #0x40]
	ldrh r7, [sp, #0x58]
	str r6, [sp, #8]
	mov r2, r2, lsr #0x10
	str r7, [sp, #0xc]
	str r5, [sp, #0x10]
	mov r3, r3, lsr #0x10
	mov r6, #0
	str r4, [sp, #0x14]
	str r6, [sp, #0x18]
	bl BackgroundUnknown__Func_204CB98
	mov r0, r10
	bl _ZN10CViMapBack16ReleaseImageFileEv
	cmp r8, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r10
	mov r1, r11
	bl _ZN10CViMapBack12ReleaseImageEt
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void CViMapBack::LoadImagePixelsFile(u16 id)
{
    this->ReleaseImageFile();

    this->currentImagePixelFile = HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(this->imagePixelFiles[id]));
    RenderCore_CPUCopyCompressed(this->imagePixelFiles[id], this->currentImagePixelFile);

    this->vmcFile.Load(this->currentImagePixelFile);
}

void CViMapBack::ReleaseImageFile()
{
    this->vmcFile.Release();

    if (this->currentImagePixelFile != NULL)
    {
        HeapFree(HEAP_USER, this->currentImagePixelFile);
        this->currentImagePixelFile = NULL;
    }
}

void CViMapBack::DrawSpriteDecoration(AnimatorSprite *animator, s16 x, s16 y, s16 scale)
{
    animator->pos.x = x;
    animator->pos.y = y;

    if (scale > FLOAT_TO_FX32(1.0))
        animator->flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    else
        animator->flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;

    if (scale != FLOAT_TO_FX32(1.0))
        AnimatorSprite__DrawFrameRotoZoom(animator, scale, scale, FLOAT_DEG_TO_IDX(0.0));
    else
        AnimatorSprite__DrawFrame(animator);
}

void CViMapBack::GetSpriteDecorOffset(s16 *x, s16 *y)
{
    *x -= this->bgIslandPosX - 24;
    *y -= this->bgIslandPosY - 16;
}

void CViMapBack::GetSpriteDecorOffsetAlt(s16 *x, s16 *y)
{
    *x -= ((3 * this->bgIslandPosX) >> 2) + HW_LCD_CENTER_X;
    *y -= (3 * this->bgIslandPosY) >> 2;
}

void CViMapBack::SpriteDecorConfig1_Seagull(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset)
{
    fx32 startX;
    fx32 startY;
    fx32 endX;
    fx32 endY;
    fx32 speed;

    timer &= 0x1FF;

    if (timer < 128)
    {
        startX = 100;
        startY = 0;
        endX   = 50;
        endY   = 8;

        if (timer < 25)
        {
            *flipX  = FALSE;
            *animID = CVIMAPDECOR_ANI_SEAGULL_TURN;
        }
        else
        {
            *flipX  = TRUE;
            *animID = CVIMAPDECOR_ANI_SEAGULL_FLY;
        }

        speed = FLOAT_TO_FX32(0.5);
    }
    else if (timer < 0x100)
    {
        timer -= 128;

        *flipX = TRUE;

        startX = 50;
        startY = 8;
        endX   = 0;
        endY   = 16;

        if (timer < 103)
        {
            *animID = CVIMAPDECOR_ANI_SEAGULL_FLY;
        }
        else
        {
            *animID = CVIMAPDECOR_ANI_SEAGULL_TURN;
        }

        speed = FLOAT_TO_FX32(1.5);
    }
    else if (timer < 0x180)
    {
        timer -= 256;

        *animID = CVIMAPDECOR_ANI_SEAGULL_FLY;

        startX = 0;
        startY = 16;
        endX   = 50;
        endY   = 8;

        if (timer < 25)
        {
            *flipX  = TRUE;
            *animID = CVIMAPDECOR_ANI_SEAGULL_TURN;
        }
        else
        {
            *flipX  = FALSE;
            *animID = CVIMAPDECOR_ANI_SEAGULL_FLY;
        }

        speed = FLOAT_TO_FX32(0.5);
    }
    else
    {
        timer -= 384;

        *flipX = FALSE;

        startX = 50;
        startY = 8;
        endX   = 100;
        endY   = 0;

        if (timer < 103)
        {
            *animID = CVIMAPDECOR_ANI_SEAGULL_FLY;
        }
        else
        {
            *animID = CVIMAPDECOR_ANI_SEAGULL_TURN;
        }

        speed = FLOAT_TO_FX32(1.5);
    }

    *x            = Unknown2051334__Func_2051534(startX, endX, FLOAT_TO_FX32(0.03125), timer, speed);
    *y            = Unknown2051334__Func_2051534(startY, endY, FLOAT_TO_FX32(0.03125), timer, speed);
    *oamPriority  = SPRITE_PRIORITY_2;
    *isInvisible  = FALSE;
    *useAltOffset = FALSE;
    *scale        = FLOAT_TO_FX32(1.0);
}

void CViMapBack::SpriteDecorConfig2_Seagull(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset)
{
    CViMapBack::SpriteDecorConfig1_Seagull(timer, x, y, oamPriority, animID, scale, flipX, isInvisible, useAltOffset);
}

void CViMapBack::SpriteDecorConfig1_Whale(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset)
{
    timer &= 0x1FF;
    u16 interval = timer & 0xFF;

    if (timer < 0x100)
    {
        *flipX = FALSE;
        *x     = 384;
    }
    else
    {
        *flipX = TRUE;
        *x     = 160;
    }

    if (interval == 0)
        *isInvisible = TRUE;
    else
        *isInvisible = FALSE;

    *y            = 74;
    *oamPriority  = SPRITE_PRIORITY_3;
    *animID       = CVIMAPDECOR_ANI_WHALE;
    *useAltOffset = TRUE;
    *scale        = FLOAT_TO_FX32(1.0);

    if (interval >= 64)
        *animID = -1;
}

void CViMapBack::SpriteDecorConfig2_Whale(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset)
{
    timer &= 0x7F;

    *animID       = -1;
    *isInvisible  = FALSE;
    *flipX        = TRUE;
    *x            = 160;
    *y            = 74;
    *oamPriority  = SPRITE_PRIORITY_3;
    *useAltOffset = TRUE;
    *scale        = FLOAT_TO_FX32(1.0);

    if (timer < 88)
    {
        *animID = CVIMAPDECOR_ANI_WHALE;

        if ((timer & 0x7F) == 0)
            *isInvisible = TRUE;
        else
            *isInvisible = FALSE;
    }
}