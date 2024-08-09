#include <game/graphics/paletteQueue.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>

// --------------------
// ENUMS
// --------------------

enum PaletteQueueType_
{
    PALETTE_QUEUE_TYPE_UNCOMPRESSED,
    PALETTE_QUEUE_TYPE_COMPRESSED,

    PALETTE_QUEUE_TYPE_COUNT,
};
typedef u32 PaletteQueueType;

// --------------------
// STRUCTS
// --------------------

typedef struct PaletteQueueEntry_
{
    struct PaletteQueueEntry_ *next;
    PaletteQueueType type;
    PaletteMode mode;
    VRAMAddress dstPalette;
    void *srcPalette;
    u16 colorCount;
} PaletteQueueEntry;

// assert that the size will fit in the "base" struct
STATIC_ASSERT(sizeof(PaletteQueueEntry) <= sizeof(QueueEntry), PALETTE_QUEUE_ENTRY_IS_TOO_BIG);

// --------------------
// TYPES
// --------------------

typedef void (*PaletteQueueReadFunc)(PaletteQueueEntry *entry, void *output);

// --------------------
// STRUCTS (Part 2)
// --------------------

struct PaletteQueueInfo
{
    PaletteQueueReadFunc readTable[PALETTE_QUEUE_TYPE_COUNT];
    u16 _0211200C[32];
    u16 _0211204C[32];
    u16 _0211208C[32];
};

// --------------------
// FUNCTION DECLS
// --------------------

static PaletteQueueEntry *AddPaletteQueueEntry(PaletteMode mode);
static void LoadPalette_Uncompressed(PaletteQueueEntry *entry, void *output);
static void LoadPalette_Compressed(PaletteQueueEntry *entry, void *output);

// --------------------
// VARIABLES
// --------------------

static PaletteQueueEntry *spriteListStart;
static PaletteQueueEntry *textureListEnd;
static PaletteQueueEntry *textureListStart;
static PaletteQueueEntry *spriteListEnd;
static PaletteQueueEntry *backgroundListStart;
static PaletteQueueEntry *backgroundListEnd;

static const struct PaletteQueueInfo paletteQueueSystem = {
    .readTable = {
        [PALETTE_QUEUE_TYPE_UNCOMPRESSED] = LoadPalette_Uncompressed, [PALETTE_QUEUE_TYPE_COMPRESSED] = LoadPalette_Compressed
    },

    ._0211200C = {
        0, 0x4D, 0x99, 0xE6, 0x132, 0x17F, 0x1CB, 0x218, 0x264,
	    0x2B1, 0x2FD, 0x34A, 0x396, 0x3E3, 0x42F, 0x47C, 0x4C8,
	    0x515, 0x561, 0x5AE, 0x5FA, 0x647, 0x693, 0x6E0, 0x72D,
	    0x779, 0x7C6, 0x812, 0x85F, 0x8AB, 0x8F8, 0x944, 
    },

    ._0211204C = {
        0, 0x96, 0x12C, 0x1C3, 0x259, 0x2EF, 0x385, 0x41B, 0x4B1,
	    0x548, 0x5DE, 0x674, 0x70A, 0x7A0, 0x836, 0x8CD, 0x963,
	    0x9F9, 0xA8F, 0xB25, 0xBBB, 0xC52, 0xCE8, 0xD7E, 0xE14,
	    0xEAA, 0xF40, 0xFD7, 0x106D, 0x1103, 0x1199, 0x1230,
    },

    ._0211208C = {
        0, 0x1D, 0x3B, 0x58, 0x75, 0x93, 0xB0, 0xCD, 0xEA,
	    0x108, 0x128, 0x142, 0x160, 0x17D, 0x19A, 0x1B8, 0x1D5,
	    0x1F2, 0x210, 0x22D, 0x24A, 0x267, 0x285, 0x2A2, 0x2BF,
	    0x2DD, 0x2FA, 0x317, 0x335, 0x352, 0x36F, 0x38C,
    },
};

// --------------------
// FUNCTIONS
// --------------------

void InitPaletteQueueSystem(void)
{
    spriteListStart     = NULL;
    spriteListEnd       = NULL;
    textureListStart    = NULL;
    textureListEnd      = NULL;
    backgroundListStart = NULL;
    backgroundListEnd   = NULL;
}

void ProcessSpritePaletteQueue(void)
{
    PaletteQueueEntry *entry = spriteListStart;
    while (entry)
    {
        paletteQueueSystem.readTable[entry->type](entry, entry->dstPalette.address);
        FreeQueueEntry((QueueEntry *)spriteListStart);

        entry           = spriteListStart->next;
        spriteListStart = entry;
        if (spriteListStart == NULL)
            spriteListEnd = NULL;
    }
}

void ProcessTexturePaletteQueue(void)
{
    if (textureListStart == NULL)
        return;

    GXVRamTexPltt sTexPltt = GX_ResetBankForTexPltt();

    PaletteQueueEntry *entry = textureListStart;
    while (entry)
    {
        u32 key    = (entry->dstPalette.location & 0x1FFFF);
        u32 offset = key >> 14;

        void *vram = texturePalBankManager.location[offset];
        vram += key;
        vram -= offset << 14;

        paletteQueueSystem.readTable[entry->type](entry, vram);

        FreeQueueEntry((QueueEntry *)textureListStart);

        entry            = textureListStart->next;
        textureListStart = entry;
        if (textureListStart == NULL)
            textureListEnd = NULL;
    }
    GX_SetBankForTexPltt(sTexPltt);
}

void ProcessBackgroundPaletteQueue(void)
{
    GXVRamBGExtPltt sBGExtPltt;
    GXVRamOBJExtPltt sOBJExtPltt;
    GXVRamSubBGExtPltt sSubBGExtPltt;
    GXVRamSubOBJExtPltt sSubOBJExtPltt;

    s32 flags = 0;

    u32 key;
    u32 offset;
    void *vram;

    if (backgroundListStart == NULL)
        return;

    PaletteQueueEntry *entry = backgroundListStart;
    while (entry)
    {
        vram = NULL;

        switch (entry->mode)
        {
            case PALETTE_MODE_BG:
                key    = (entry->dstPalette.location);
                offset = key >> 13;

                vram = (void *)(size_t)key;
                vram += (size_t)bgExtPalBankManager[0].location[offset];
                vram -= offset << 13;

                if ((flags & 2) == 0)
                {
                    sBGExtPltt = GX_ResetBankForBGExtPltt();
                    flags |= 2;
                }
                break;

            case PALETTE_MODE_OBJ:
                key    = (entry->dstPalette.location);
                offset = key >> 13;

                vram = (void *)(size_t)key;
                vram += (size_t)objExtPalBankManager[0].location[offset];
                vram -= offset << 13;

                if ((flags & 4) == 0)
                {
                    sOBJExtPltt = GX_ResetBankForOBJExtPltt();
                    flags |= 4;
                }
                break;

            case PALETTE_MODE_SUB_BG:
                key    = (entry->dstPalette.location);
                offset = key >> 13;

                vram = (void *)(size_t)key;
                vram += (size_t)bgExtPalBankManager[1].location[offset];
                vram -= offset << 13;

                if ((flags & 8) == 0)
                {
                    sSubBGExtPltt = GX_ResetBankForSubBGExtPltt();
                    flags |= 8;
                }
                break;

            case PALETTE_MODE_SUB_OBJ:
                key    = (entry->dstPalette.location);
                offset = key >> 13;

                vram = (void *)(size_t)key;
                vram += (size_t)objExtPalBankManager[1].location[offset];
                vram -= offset << 13;

                if ((flags & 0x10) == 0)
                {
                    sSubOBJExtPltt = GX_ResetBankForSubOBJExtPltt();
                    flags |= 0x10;
                }
                break;

            default:
                break;
        }

        paletteQueueSystem.readTable[entry->type](entry, vram);
        FreeQueueEntry((QueueEntry *)backgroundListStart);

        entry               = backgroundListStart->next;
        backgroundListStart = entry;
        if (backgroundListStart == NULL)
            backgroundListEnd = NULL;
    }

    if ((flags & 2) != 0)
        GX_SetBankForBGExtPltt(sBGExtPltt);

    if ((flags & 4) != 0)
        GX_SetBankForOBJExtPltt(sOBJExtPltt);

    if ((flags & 8) != 0)
        GX_SetBankForSubBGExtPltt(sSubBGExtPltt);

    if ((flags & 0x10) != 0)
        GX_SetBankForSubOBJExtPltt(sSubOBJExtPltt);
}

void QueueUncompressedPalette(void *srcPalettePtr, u16 colorCount, PaletteMode mode, size_t dest)
{
    PaletteQueueEntry *entry = AddPaletteQueueEntry(mode);
    if (HeapNull != entry)
    {
        entry->mode                = mode;
        entry->dstPalette.location = dest;
        entry->type                = PALETTE_QUEUE_TYPE_UNCOMPRESSED;
        entry->srcPalette          = srcPalettePtr;
        entry->colorCount          = colorCount;
    }
}

void LoadUncompressedPalette(void *srcPalettePtr, u16 colorCount, PaletteMode mode, size_t dest)
{
    typedef void (*ReadFunc)(void);

    PaletteQueueEntry **listStart;
    PaletteQueueEntry **listEnd;
    PaletteQueueEntry *prevStart;
    PaletteQueueEntry *prevEnd;

    ReadFunc processQueueFunc;
    switch (mode)
    {
        case PALETTE_MODE_SPRITE:
            listStart        = &spriteListStart;
            listEnd          = &spriteListEnd;
            processQueueFunc = ProcessSpritePaletteQueue;
            break;

        case PALETTE_MODE_TEXTURE:
            listStart        = &textureListStart;
            listEnd          = &textureListEnd;
            processQueueFunc = ProcessTexturePaletteQueue;
            break;

        default:
            listStart        = &backgroundListStart;
            listEnd          = &backgroundListEnd;
            processQueueFunc = ProcessBackgroundPaletteQueue;
            break;
    }

    prevStart = *listStart;
    prevEnd   = *listEnd;

    *listEnd   = NULL;
    *listStart = NULL;

    QueueUncompressedPalette(srcPalettePtr, colorCount, mode, dest);
    processQueueFunc();

    *listStart = prevStart;
    *listEnd   = prevEnd;
}

void QueueCompressedPalette(void *srcPalettePtr, PaletteMode mode, size_t dest)
{
    PaletteQueueEntry *entry = AddPaletteQueueEntry(mode);
    if (HeapNull != entry)
    {
        entry->mode                = mode;
        entry->dstPalette.location = dest;
        entry->type                = PALETTE_QUEUE_TYPE_COMPRESSED;
        entry->srcPalette          = srcPalettePtr;
    }
}

void LoadCompressedPalette(void *srcPalettePtr, PaletteMode mode, size_t dest)
{
    typedef void (*ReadFunc)(void);

    PaletteQueueEntry **listStart;
    PaletteQueueEntry **listEnd;
    PaletteQueueEntry *prevStart;
    PaletteQueueEntry *prevEnd;

    ReadFunc processQueueFunc;
    switch (mode)
    {
        case PALETTE_MODE_SPRITE:
            listStart        = &spriteListStart;
            listEnd          = &spriteListEnd;
            processQueueFunc = ProcessSpritePaletteQueue;
            break;

        case PALETTE_MODE_TEXTURE:
            listStart        = &textureListStart;
            listEnd          = &textureListEnd;
            processQueueFunc = ProcessTexturePaletteQueue;
            break;

        default:
            listStart        = &backgroundListStart;
            listEnd          = &backgroundListEnd;
            processQueueFunc = ProcessBackgroundPaletteQueue;
            break;
    }

    prevStart = *listStart;
    prevEnd   = *listEnd;

    *listEnd   = NULL;
    *listStart = NULL;

    QueueCompressedPalette(srcPalettePtr, mode, dest);
    processQueueFunc();

    *listStart = prevStart;
    *listEnd   = prevEnd;
}

void ClearPaletteQueue(void)
{
    for (QueueEntry *entry = (QueueEntry *)spriteListStart; entry != NULL;)
    {
        FreeQueueEntry(entry);

        entry           = (QueueEntry *)spriteListStart->next;
        spriteListStart = (PaletteQueueEntry *)entry;
    }
    spriteListEnd = NULL;

    for (QueueEntry *entry = (QueueEntry *)textureListStart; entry != NULL;)
    {
        FreeQueueEntry(entry);

        entry            = (QueueEntry *)textureListStart->next;
        textureListStart = (PaletteQueueEntry *)entry;
    }
    textureListEnd = NULL;

    for (QueueEntry *entry = (QueueEntry *)backgroundListStart; entry != NULL;)
    {
        FreeQueueEntry(entry);

        entry               = (QueueEntry *)backgroundListStart->next;
        backgroundListStart = (PaletteQueueEntry *)entry;
    }
    backgroundListEnd = NULL;
}

NONMATCH_FUNC void Palette__UnknownFunc9(u16 *colorPtr, u16 *palettePtr, u32 count, u16 a4)
{
    // https://decomp.me/scratch/HPqmJ -> 66.76%
#ifdef NON_MATCHING
    u16 ar = (u16)(a4 << GX_RGB_R_SHIFT);
    u16 ag = (u16)(a4 << GX_RGB_G_SHIFT);
    u16 ab = (u16)(a4 << GX_RGB_B_SHIFT);

    for (u16 i = count - 1; i != 0; i--)
    {
        u16 color = *colorPtr++;
        s32 r     = (color & GX_RGB_R_MASK) + ar;

        if (r > GX_RGB_R_MASK)
            r = (u16)GX_RGB_R_MASK;

        s32 g = (color & GX_RGB_G_MASK) + ag;
        if (g > GX_RGB_G_MASK)
            g = (u16)GX_RGB_G_MASK;

        s32 b = (color & GX_RGB_B_MASK) + ab;
        if (b > GX_RGB_B_MASK)
            b = (u16)GX_RGB_B_MASK;

        *palettePtr = r | g | b | (color & 0x8000);
        palettePtr++;
    }
#else
    // clang-format off
    stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub r4, r2, #1
	mov r4, r4, lsl #0x10
	cmp r2, #0
	mov r6, r3, lsl #0x10
	mov r7, r3, lsl #0x15
	mov r8, r3, lsl #0x1a
	mov r2, r4, lsr #0x10
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov lr, #0x1f
	mov ip, #0x3e0
	mov r3, #0x7c00
_0207C258:
	ldrh r5, [r0]
	add r0, r0, #2
	and r4, r5, #0x1f
	add r9, r4, r6, lsr #16
	and r4, r5, #0x3e0
	add r10, r4, r7, lsr #16
	and r4, r5, #0x7c00
	cmp r9, #0x1f
	movgt r9, lr
	cmp r10, #0x3e0
	movgt r10, ip
	add r4, r4, r8, lsr #16
	cmp r4, #0x7c00
	movgt r4, r3
	orr r10, r9, r10
	sub r9, r2, #1
	orr r4, r4, r10
	and r5, r5, #0x8000
	orr r5, r5, r4
	mov r4, r9, lsl #0x10
	cmp r2, #0
	strh r5, [r1], #2
	mov r2, r4, lsr #0x10
	bne _0207C258
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void Palette__UnknownFunc10(u16 *colorPtr, u16 *palettePtr, u32 count, s32 a4){
#ifdef NON_MATCHING

#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub r4, r2, #1
	mov r5, r4, lsl #0x10
	cmp r2, #0
	mov r4, r3, lsl #0x1a
	mov ip, r3, lsl #0x10
	mov lr, r3, lsl #0x15
	mov r2, r5, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r7, #0
	ldr r3, =0x000003FF
	mov r6, r7
	mov r5, r7
_0207C2F0:
	ldrh r11, [r0]
	add r0, r0, #2
	and r8, r11, #0x1f
	and r9, r11, #0x3e0
	subs r8, r8, ip, lsr #16
	and r10, r11, #0x7c00
	sub r9, r9, lr, lsr #16
	movmi r8, r7
	cmp r9, #0x1f
	movlt r9, r6
	sub r10, r10, r4, lsr #16
	cmp r10, r3
	movlt r10, r5
	orr r9, r8, r9
	sub r8, r2, #1
	orr r9, r10, r9
	and r10, r11, #0x8000
	orr r9, r10, r9
	mov r8, r8, lsl #0x10
	cmp r2, #0
	strh r9, [r1], #2
	mov r2, r8, lsr #0x10
	bne _0207C2F0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void Palette__UnknownFunc11(u16 *result, u16 *colorPtr, u16 *palettePtr, s32 count, u8 a5)
{
#ifdef NON_MATCHING

#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldrb r5, [sp, #0x20]
	sub r4, r3, #1
	mov r4, r4, lsl #0x10
	cmp r3, #0
	mov r6, r5, lsl #0x10
	mov r7, r5, lsl #0x15
	mov r8, r5, lsl #0x1a
	mov r3, r4, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0207C37C:
	ldrh r4, [r0]
	ldrh r5, [r1]
	and ip, r4, #0x1f
	and r9, r5, #0x1f
	cmp ip, r9
	bge _0207C3A4
	add ip, ip, r6, lsr #16
	cmp ip, r9
	movgt ip, r9
	b _0207C3BC
_0207C3A4:
	ble _0207C3B8
	sub ip, ip, r6, lsr #16
	cmp ip, r9
	movlt ip, r9
	b _0207C3BC
_0207C3B8:
	mov ip, r9
_0207C3BC:
	and lr, r4, #0x3e0
	and r9, r5, #0x3e0
	cmp lr, r9
	bge _0207C3DC
	add lr, lr, r7, lsr #16
	cmp lr, r9
	movgt lr, r9
	b _0207C3F4
_0207C3DC:
	ble _0207C3F0
	sub lr, lr, r7, lsr #16
	cmp lr, r9
	movlt lr, r9
	b _0207C3F4
_0207C3F0:
	mov lr, r9
_0207C3F4:
	and r4, r4, #0x7c00
	and r9, r5, #0x7c00
	cmp r4, r9
	bge _0207C414
	add r4, r4, r8, lsr #16
	cmp r4, r9
	movgt r4, r9
	b _0207C42C
_0207C414:
	ble _0207C428
	sub r4, r4, r8, lsr #16
	cmp r4, r9
	movlt r4, r9
	b _0207C42C
_0207C428:
	mov r4, r9
_0207C42C:
	orr lr, ip, lr
	sub ip, r3, #1
	and r5, r5, #0x8000
	orr r4, r4, lr
	orr r4, r5, r4
	mov ip, ip, lsl #0x10
	cmp r3, #0
	strh r4, [r2], #2
	add r0, r0, #2
	add r1, r1, #2
	mov r3, ip, lsr #0x10
	bne _0207C37C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

static PaletteQueueEntry *AddPaletteQueueEntry(PaletteMode mode)
{
    PaletteQueueEntry *entry = (PaletteQueueEntry *)AllocQueueEntry();

    if (entry != HeapNull)
    {
        PaletteQueueEntry **listStart;
        PaletteQueueEntry **listEnd;

        switch (mode)
        {
            case PALETTE_MODE_BG:
            case PALETTE_MODE_OBJ:
            case PALETTE_MODE_SUB_BG:
            case PALETTE_MODE_SUB_OBJ:
                listStart = &backgroundListStart;
                listEnd   = &backgroundListEnd;
                break;

            case PALETTE_MODE_TEXTURE:
                listStart = &textureListStart;
                listEnd   = &textureListEnd;
                break;

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

static void LoadPalette_Uncompressed(PaletteQueueEntry *entry, void *output)
{
    RenderCore_CPUCopy(entry->srcPalette, output, sizeof(u16) * entry->colorCount);
}

static void LoadPalette_Compressed(PaletteQueueEntry *entry, void *output)
{
    RenderCore_CPUCopyCompressed(entry->srcPalette, output);
}