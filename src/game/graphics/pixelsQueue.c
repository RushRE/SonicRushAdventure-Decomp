#include <game/graphics/pixelsQueue.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

enum PixelQueueType_
{
    PIXEL_QUEUE_TYPE_SPRITE,
    PIXEL_QUEUE_TYPE_TEXTURE,
    PIXEL_QUEUE_TYPE_BACKGROUND,
    PIXEL_QUEUE_TYPE_UNKNOWN,

    PIXEL_QUEUE_TYPE_COUNT,
};
typedef u32 PixelQueueType;

// --------------------
// STRUCTS
// --------------------

typedef struct PixelsQueueEntry_
{
    struct PixelsQueueEntry_ *next;
    PixelQueueType type;
    PixelMode mode;
    VRAMAddress vramPixels;
    void *srcPixelsPtr;
    size_t pixelByteSize;
    u16 srcPixelStride;
    u16 dstPixelStride;
    u16 displayWidth;
    u16 displayHeight;
} PixelsQueueEntry;

// assert that the size will fit in the "base" struct
STATIC_ASSERT(sizeof(PixelsQueueEntry) <= sizeof(QueueEntry), PIXEL_QUEUE_ENTRY_IS_TOO_BIG);

// --------------------
// TYPES
// --------------------

typedef void (*PixelsQueueReadFunc)(PixelsQueueEntry *input, void *output);

// --------------------
// FUNCTION DECLS
// --------------------

static PixelsQueueEntry *AddPixelQueueEntry(PixelMode mode);
static void LoadPixels_Uncompressed(PixelsQueueEntry *input, void *output);
static void LoadPixels_Compressed(PixelsQueueEntry *input, void *output);
static void LoadPixels_Background(PixelsQueueEntry *input, void *output);
static void LoadPixels_Unknown(PixelsQueueEntry *input, void *output);

// --------------------
// VARIABLES
// --------------------

static PixelsQueueEntry *spriteListStart;
static PixelsQueueEntry *spriteListEnd;

static PixelsQueueEntry *textureListEnd;
static PixelsQueueEntry *textureListStart;

const u8 pixelFormatShift[BAC_FORMAT_COUNT] = {
    [BAC_FORMAT_PLTT16_2D]  = 5, // GX_TEXFMT_PLTT16
    [BAC_FORMAT_PLTT256_2D] = 6, // GX_TEXFMT_PLTT256
    [BAC_FORMAT_DIRECT_2D]  = 7, // GX_TEXFMT_DIRECT
    [BAC_FORMAT_PLTT4_3D]   = 4, // GX_TEXFMT_PLTT4
    [BAC_FORMAT_PLTT16_3D]  = 5, // GX_TEXFMT_PLTT16
    [BAC_FORMAT_PLTT256_3D] = 6, // GX_TEXFMT_PLTT256
    [BAC_FORMAT_DIRECT_3D]  = 7, // GX_TEXFMT_DIRECT
    [BAC_FORMAT_A3I5_3D]    = 6, // GX_TEXFMT_A3I5
    [BAC_FORMAT_A5I3_3D]    = 6, // GX_TEXFMT_A5I3
    [BAC_FORMAT_COMP4x4_3D] = 4  // GX_TEXFMT_COMP4x4
};

static PixelsQueueReadFunc const pixelsReadTable[PIXEL_QUEUE_TYPE_COUNT] = { [PIXEL_QUEUE_TYPE_SPRITE]     = LoadPixels_Uncompressed,
                                                                             [PIXEL_QUEUE_TYPE_TEXTURE]    = LoadPixels_Compressed,
                                                                             [PIXEL_QUEUE_TYPE_BACKGROUND] = LoadPixels_Background,
                                                                             [PIXEL_QUEUE_TYPE_UNKNOWN]    = LoadPixels_Unknown };

// clang-format off
static u8 tileSizes[PIXEL_MODE_COUNT] = 
{ 
    [PIXEL_MODE_SPRITE]                 = 0,
    [PIXEL_MODE_TEXTURE]                = 0,
    [PIXEL_MODE_BG_TEXT_256x256]        = 1,
    [PIXEL_MODE_BG_TEXT_512x256]        = 1,
    [PIXEL_MODE_BG_TEXT_256x512]        = 1,
    [PIXEL_MODE_BG_TEXT_512x512]        = 1,
    [PIXEL_MODE_BG_LARGEBMP_512x1024]   = 1,
    [PIXEL_MODE_BG_LARGEBMP_1024x512]   = 1,
    [PIXEL_MODE_BG_DCBMP_128x128]       = 2,
    [PIXEL_MODE_BG_DCBMP_256x256]       = 2,
    [PIXEL_MODE_BG_DCBMP_512x256]       = 2,
    [PIXEL_MODE_BG_DCBMP_512x512]       = 2
};

static u16 backgroundSizes[PIXEL_MODE_COUNT][2] = 
{ 
    [PIXEL_MODE_SPRITE]                 = { 0, 0 },
    [PIXEL_MODE_TEXTURE]                = { 0, 0 },
    [PIXEL_MODE_BG_TEXT_256x256]        = { 0x80, 0x80 },
    [PIXEL_MODE_BG_TEXT_512x256]        = { 0x100, 0x100 },
    [PIXEL_MODE_BG_TEXT_256x512]        = { 0x200, 0x100 },
    [PIXEL_MODE_BG_TEXT_512x512]        = { 0x200, 0x200 },
    [PIXEL_MODE_BG_LARGEBMP_512x1024]   = { 0x200, 0x400 },
    [PIXEL_MODE_BG_LARGEBMP_1024x512]   = { 0x400, 0x200 },
    [PIXEL_MODE_BG_DCBMP_128x128]       = { 0x80, 0x80 },
    [PIXEL_MODE_BG_DCBMP_256x256]       = { 0x100, 0x100 },
    [PIXEL_MODE_BG_DCBMP_512x256]       = { 0x200, 0x100 },
    [PIXEL_MODE_BG_DCBMP_512x512]       = { 0x200, 0x200 } 
};
// clang-format on

// --------------------
// FUNCTIONS
// --------------------

// Management
void InitPixelsQueueSystem(void)
{
    spriteListStart = NULL;
    spriteListEnd   = NULL;

    textureListStart = NULL;
    textureListEnd   = NULL;
}

// Queueing
void ProcessSpritePixelQueue(void)
{
    PixelsQueueEntry *entry = spriteListStart;
    while (entry)
    {
        pixelsReadTable[entry->type](entry, entry->vramPixels.address);
        FreeQueueEntry((QueueEntry *)spriteListStart);

        entry           = spriteListStart->next;
        spriteListStart = entry;
        if (spriteListStart == NULL)
            spriteListEnd = NULL;
    }
}

void ProcessTexturePixelQueue(void)
{
    if (textureListStart == NULL)
        return;

    GXVRamTex sTex = GX_ResetBankForTex();

    PixelsQueueEntry *entry = textureListStart;
    while (entry)
    {
        u32 key    = (entry->vramPixels.location & 0x7FFFF);
        u32 offset = key >> 17;

        void *vram = textureBankManager.location[offset];
        vram += key;
        vram -= offset << 17;

        pixelsReadTable[entry->type](entry, vram);

        FreeQueueEntry((QueueEntry *)textureListStart);

        entry            = textureListStart->next;
        textureListStart = entry;
        if (textureListStart == NULL)
            textureListEnd = NULL;
    }
    GX_SetBankForTex(sTex);
}

void QueueUncompressedPixels(void *pixels, size_t pixelByteSize, PixelMode mode, void *vramPixels)
{
    PixelsQueueEntry *entry = AddPixelQueueEntry(mode);
    if (HeapNull != entry)
    {
        entry->mode               = mode;
        entry->vramPixels.address = vramPixels;
        entry->type               = PIXEL_QUEUE_TYPE_SPRITE;
        entry->srcPixelsPtr       = pixels;
        entry->pixelByteSize      = pixelByteSize;
    }
}

void LoadUncompressedPixels(void *pixels, size_t pixelByteSize, PixelMode mode, void *vramPixels)
{
    typedef void (*ReadFunc)(void);

    PixelsQueueEntry **listStart;
    PixelsQueueEntry **listEnd;
    PixelsQueueEntry *prevStart;
    PixelsQueueEntry *prevEnd;

    ReadFunc processQueueFunc;
    switch (mode)
    {
        case PIXEL_MODE_SPRITE:
            listStart        = &spriteListStart;
            listEnd          = &spriteListEnd;
            processQueueFunc = ProcessSpritePixelQueue;
            break;

        case PIXEL_MODE_TEXTURE:
            listStart        = &textureListStart;
            listEnd          = &textureListEnd;
            processQueueFunc = ProcessTexturePixelQueue;
            break;
    }

    prevStart = *listStart;
    prevEnd   = *listEnd;

    *listEnd   = NULL;
    *listStart = NULL;

    QueueUncompressedPixels(pixels, pixelByteSize, mode, vramPixels);
    processQueueFunc();

    *listStart = prevStart;
    *listEnd   = prevEnd;
}

void QueueCompressedPixels(void *pixels, PixelMode mode, void *vramPixels)
{
    PixelsQueueEntry *entry = AddPixelQueueEntry(mode);
    if (HeapNull != entry)
    {
        entry->mode               = mode;
        entry->vramPixels.address = vramPixels;
        entry->type               = PIXEL_QUEUE_TYPE_TEXTURE;
        entry->srcPixelsPtr       = pixels;
    }
}

void LoadCompressedPixels(void *pixels, PixelMode mode, void *vramPixels)
{
    typedef void (*ReadFunc)(void);

    PixelsQueueEntry **listStart;
    PixelsQueueEntry **listEnd;
    PixelsQueueEntry *prevStart;
    PixelsQueueEntry *prevEnd;

    ReadFunc processQueueFunc;
    switch (mode)
    {
        case PIXEL_MODE_SPRITE:
            listStart        = &spriteListStart;
            listEnd          = &spriteListEnd;
            processQueueFunc = ProcessSpritePixelQueue;
            break;

        case PIXEL_MODE_TEXTURE:
            listStart        = &textureListStart;
            listEnd          = &textureListEnd;
            processQueueFunc = ProcessTexturePixelQueue;
            break;
    }

    prevStart = *listStart;
    prevEnd   = *listEnd;

    *listEnd   = NULL;
    *listStart = NULL;

    QueueCompressedPixels(pixels, mode, vramPixels);
    processQueueFunc();

    *listStart = prevStart;
    *listEnd   = prevEnd;
}

void QueueBackgroundPixels(void *pixels, s32 x, s32 y, s32 width, PixelMode mode, void *vramPixels, u16 bgPlaceX, u16 bgPlaceY, u16 displayWidth, u16 displayHeight)
{
    PixelsQueueEntry *entry = AddPixelQueueEntry(mode);
    if (HeapNull == entry)
        return;

    s32 index   = mode;
    u16 bgWidth = backgroundSizes[index][0];
    u8 tileSize = tileSizes[index];

    entry->mode               = mode;
    entry->vramPixels.address = &((u8 *)vramPixels)[tileSize * (bgPlaceX + bgPlaceY * bgWidth)];
    entry->dstPixelStride     = bgWidth * tileSize;
    entry->type               = PIXEL_QUEUE_TYPE_BACKGROUND;
    entry->srcPixelsPtr       = pixels;
    entry->pixelByteSize      = tileSize * (x + y * width);
    entry->srcPixelStride     = width * tileSize;
    entry->displayWidth       = displayWidth * tileSize;
    entry->displayHeight      = displayHeight;
}

void QueueCompressedBackgroundPixels(void *pixels, u16 x, u16 y, u16 width, PixelMode mode, void *vramPixels, u16 bgPlaceX, u16 bgPlaceY, u16 displayWidth, u16 displayHeight)
{
    if (MI_GetCompressionType(pixels) == 0)
    {
        QueueBackgroundPixels(pixels + sizeof(MICompressionHeader), x, y, width, mode, vramPixels, bgPlaceX, bgPlaceY, displayWidth, displayHeight);
    }
    else
    {
        s32 index = mode;
        QueueCompressedPixels(pixels, PIXEL_MODE_SPRITE, vramPixels + tileSizes[index] * (bgPlaceX + bgPlaceY * backgroundSizes[index][0]));
    }
}

void LoadCompressedBackgroundPixels(void *pixels, u16 x, u16 y, u16 width, PixelMode mode, void *vramPixels, u16 bgPlaceX, u16 bgPlaceY, u16 displayWidth, u16 displayHeight)
{
    PixelsQueueEntry *prevStart;
    PixelsQueueEntry *prevEnd;

    prevStart = spriteListStart;
    prevEnd   = spriteListEnd;

    spriteListEnd   = NULL;
    spriteListStart = NULL;

    QueueCompressedBackgroundPixels(pixels, x, y, width, mode, vramPixels, bgPlaceX, bgPlaceY, displayWidth, displayHeight);
    ProcessSpritePixelQueue();

    spriteListStart = prevStart;
    spriteListEnd   = prevEnd;
}

void ClearPixelsQueue(void)
{
    for (QueueEntry *entry = (QueueEntry *)spriteListStart; entry != NULL;)
    {
        FreeQueueEntry(entry);

        entry           = (QueueEntry *)spriteListStart->next;
        spriteListStart = (PixelsQueueEntry *)entry;
    }
    spriteListEnd = NULL;

    for (QueueEntry *entry = (QueueEntry *)textureListStart; entry != NULL;)
    {
        FreeQueueEntry(entry);

        entry            = (QueueEntry *)textureListStart->next;
        textureListStart = (PixelsQueueEntry *)entry;
    }
    textureListEnd = NULL;
}

PixelsQueueEntry *AddPixelQueueEntry(PixelMode mode)
{
    PixelsQueueEntry *entry = (PixelsQueueEntry *)AllocQueueEntry();
    if (HeapNull != entry)
    {
        PixelsQueueEntry **listStart;
        PixelsQueueEntry **listEnd;

        switch (mode)
        {
            case PIXEL_MODE_TEXTURE:
                listStart = &textureListStart;
                listEnd   = &textureListEnd;
                break;

            // case PIXEL_MODE_SPRITE:
            default:
                listStart = &spriteListStart;
                listEnd   = &spriteListEnd;
                break;
        }

        if (*listStart == NULL)
            *listStart = entry;
        else
            (*listEnd)->next = entry;

        *listEnd    = entry;
        entry->next = NULL;
    }

    return entry;
}

// Internal
void LoadPixels_Uncompressed(PixelsQueueEntry *input, void *output)
{
    RenderCore_DMACopy(input->srcPixelsPtr, output, input->pixelByteSize);
}

void LoadPixels_Compressed(PixelsQueueEntry *input, void *output)
{
    RenderCore_CPUCopyCompressed(input->srcPixelsPtr, output);
}

void LoadPixels_Background(PixelsQueueEntry *input, void *output)
{
    void *srcPixels = input->srcPixelsPtr + input->pixelByteSize;
    void *dstPixels = input->vramPixels.address;

    if ((input->displayWidth & 1) != 0 || ((size_t)srcPixels & 1) != 0 || ((size_t)dstPixels & 1) != 0 || (input->srcPixelStride & 1) != 0 || (input->dstPixelStride & 1) != 0)
    {
        while (input->displayHeight-- != 0)
        {
            MI_CpuCopy8(srcPixels, dstPixels, input->displayWidth);
            srcPixels += input->srcPixelStride;
            dstPixels += input->dstPixelStride;
        }
    }
    else
    {
        while (input->displayHeight-- != 0)
        {
            RenderCore_DMACopy(srcPixels, dstPixels, input->displayWidth);
            srcPixels += input->srcPixelStride;
            dstPixels += input->dstPixelStride;
        }
    }
}

void LoadPixels_Unknown(PixelsQueueEntry *input, void *output)
{
    UNUSED(input);
    UNUSED(output);
    // Nothin'
}
