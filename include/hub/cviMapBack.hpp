#ifndef RUSH_CVIMAPBACK_HPP
#define RUSH_CVIMAPBACK_HPP

#include <game/graphics/sprite.h>
#include <game/text/fontDMAControl.h>
#include <hub/hubConfig.h>

// --------------------
// STRUCTS
// --------------------

struct CVmiImageInfo
{
    u16 startX;
    u16 startY;
    u16 width;
    u16 height;
    u16 sortOrder;
    u16 id;
};

struct CVmiFileHeader
{
    u16 imageCount;
    u16 unknown;
    CVmiImageInfo images[1];
};

struct CViMapBackCanvas
{
    GXCharFmt256 pixels[28][36];
};

// Image configuration file (one file for all images)
class CViMapVmiFile
{
    void *vTable;

public:
    // CViMapVmiFile();
    // virtual ~CViMapVmiFile();

    // --------------------
    // VARIABLES
    // --------------------

    CVmiFileHeader *file;
    CVmiImageInfo *images;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    void Release();
    void Load(void *file);
    u16 GetImageCount();
    u16 GetImagePixelStartX(u16 id);
    u16 GetImagePixelStartY(u16 id);
    u16 GetImageTileStartX(u16 id);
    u16 GetImageTileStartY(u16 id);
    u16 GetImagePixelWidth(u16 id);
    u16 GetImagePixelHeight(u16 id);
    u16 GetImageTileWidth(u16 id);
    u16 GetImageTileHeight(u16 id);
    u16 GetSortOrder(u16 id);
};

// Image pixels file (one file per image)
class CViMapVmcFile
{
    void *vTable;

public:
    // CViMapVmcFile();
    // virtual ~CViMapVmcFile();

    // --------------------
    // VARIABLES
    // --------------------

    void *file;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    void Release();
    void Load(void *file);
    void *GetPixels();
};

// Image palette file (one file for all images)
class CViMapVmpFile
{
    void *vTable;

public:
    // CViMapVmpFile();
    // virtual ~CViMapVmpFile();

    // --------------------
    // VARIABLES
    // --------------------

    GXRgb *colors;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    void Release();
    void Load(void *file);
    void *GetColors();
};

class CViMapBack
{
    void *vTable;

public:
    // CViMapBack();
    // virtual ~CViMapBack();

    // --------------------
    // ENUMS
    // --------------------

    enum DecorationFlags
    {
        DECOR_FLAG_NONE = 0x00,

        DECOR_FLAG_ACTIVE = 1 << 0,
    };

    // --------------------
    // VARIABLES
    // --------------------

    CViMapVmiFile vmiFile;
    CViMapVmpFile vmpFile;
    CViMapVmcFile vmcFile;
    void *imageConfigFile;
    void *imagePaletteFile;
    void *currentImagePixelFile;
    s32 imagePixelFileCount;
    void **imagePixelFiles;
    s32 blitImageID;
    u16 blitImageStartX;
    u16 blitImageStartY;
    u16 blitImageWidth;
    u16 blitImageHeight;
    CViMapBackCanvas *canvasPixels;
    u16 *imageSortList;
    s32 imageSortListChunkCount;
    s32 imageSortListCount;
    u32 decorationFlags[CVIMAPBACK_DECORSPRITE_COUNT];
    AnimatorSprite aniDecoration[CVIMAPBACK_DECORSPRITE_ANIM_COUNT];
    u16 decorAnimTimer;
    u16 unknown;
    u16 canvasPaletteRow;
    CViMapBackCanvas *vramPixels;
    GXScrText64x32 *vramMappings;
    s32 mappingStartTile;
    s16 bgIslandPosX;
    s16 bgIslandPosY;
    s32 rippleDeform;
    s32 rippleAngle;
    FontDMAControl fontDmaControl;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void LoadAssets();
    void Release();
    void GetImageSize(u16 id, u16 *startX, u16 *startY, u16 *width, u16 *height);
    void GetImageCenter(u16 id, u16 *x, u16 *y);
    void LoadImage(u16 id);
    void LoadAllImages();
    BOOL CheckImageLoaded(u16 id);
    void ReleaseImage(u16 id);
    void AddActiveImage(u16 id);
    void LoadSortedImagesOntoCanvas();
    void InitImageBlitter(u16 id);
    void InitImageBlitterForHighPriorityImage(u16 id);
    void ReleaseImageBlitter();
    void *GetCanvasPalette();
    void CopyToCanvas(void *pixels, u16 startX, u16 startY, u16 width, u16 height);
    void UpdateCanvasVRAMPalette(u16 paletteRow, u16 unknown);
    void BlitCanvasPixels(void *vramPixels, BOOL queuePixels);
    void UpdateCanvasVRAMMappings(void *vramMappings, s32 startTile);
    void SetDecorationActive(u16 id);
    void ProcessDecorationAnims();
    void DrawAllSpriteDecorations(BOOL a2);
    void DrawSingleSpriteDecoration(u16 id, BOOL a3);
    void DrawNewlyConstructedSpriteDecoration(u16 id, u16 *x, u16 *y, BOOL useAltConfigFunc, BOOL useAltPositions);
    void DrawIslandBackgrounds(s16 x, s16 y);
    void GetIslandPos(s16 *x, s16 *y);
    void SortImages();
    void LoadImagePixelsOntoCanvas(u16 id);
    void BlitImageToCanvas(u16 id, u16 startX, u16 startY, u16 width, u16 height);
    void LoadImagePixelsFile(u16 id);
    void ReleaseImageFile();
    void DrawSpriteDecoration(AnimatorSprite *animator, s16 x, s16 y, s16 scale);
    void GetSpriteDecorOffset(s16 *x, s16 *y);
    void GetSpriteDecorOffsetAlt(s16 *x, s16 *y);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void GetDecorationImagePosition(u16 id, u16 *x, u16 *y);

    static void SpriteDecorConfig1_Seagull(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset);
    static void SpriteDecorConfig2_Seagull(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset);
    static void SpriteDecorConfig1_Whale(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset);
    static void SpriteDecorConfig2_Whale(u16 timer, s16 *x, s16 *y, s16 *oamPriority, u16 *animID, u16 *scale, BOOL *flipX, BOOL *isInvisible, BOOL *useAltOffset);
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

// CViMapVmiFile
void _ZN13CViMapVmiFileC1Ev(CViMapVmiFile *work);
void _ZN13CViMapVmiFileD0Ev(CViMapVmiFile *work);
void _ZN13CViMapVmiFileD1Ev(CViMapVmiFile *work);

// CViMapVmpFile
void _ZN13CViMapVmpFileC1Ev(CViMapVmpFile *work);
void _ZN13CViMapVmpFileD0Ev(CViMapVmpFile *work);
void _ZN13CViMapVmpFileD1Ev(CViMapVmpFile *work);

// CViMapVmcFile
void _ZN13CViMapVmcFileC1Ev(CViMapVmcFile *work);
void _ZN13CViMapVmcFileD0Ev(CViMapVmcFile *work);
void _ZN13CViMapVmcFileD1Ev(CViMapVmcFile *work);

// CViMapBack
void _ZN10CViMapBackC1Ev(CViMapBack *work);
void _ZN10CViMapBackD0Ev(CViMapBack *work);
void _ZN10CViMapBackD1Ev(CViMapBack *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAPBACK_HPP