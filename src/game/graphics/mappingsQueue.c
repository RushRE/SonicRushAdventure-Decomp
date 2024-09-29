#include <game/graphics/mappingsQueue.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>

// --------------------
// STRUCTS
// --------------------

typedef struct MappingsQueueEntry_
{
    struct MappingsQueueEntry_ *next;
    u16 type;
    u16 dstMappingsStride;
    u32 dstMappingsOffset;
    u8 *dstMappingsPtr;
    u16 displayWidth;
    u16 displayHeight;
    u8 *srcMappingsPtr;
    u32 srcMappingsStride;
    u32 srcMappingsOffset;
} MappingsQueueEntry;

// --------------------
// TYPES
// --------------------

typedef void (*MappingsQueueReadFunc)(MappingsQueueEntry *entry);

// --------------------
// FUNCTION DECLS
// --------------------

struct MappingsQueueInfo
{
    u32 _021120DC[2];
    u8 bgTileDimensions[24][2];
    u8 bgTileSize[24];
};

static MappingsQueueEntry *Mappings__AddToList(void);
static void Mappings__ReadMappingsFunc1(MappingsQueueEntry *entry);
static void Mappings__ReadMappingsFunc2(MappingsQueueEntry *entry);

// --------------------
// VARIABLES
// --------------------

static MappingsQueueEntry *mappingsListStart;
static MappingsQueueEntry *mappingsListEnd;

static const MappingsQueueReadFunc readTable[] = { Mappings__ReadMappingsFunc1, Mappings__ReadMappingsFunc2 };

static const struct MappingsQueueInfo mappingsQueueSystem = {
    ._021120DC = {
        HW_BG_VRAM, HW_DB_BG_VRAM
    },

    .bgTileDimensions = {
        [MAPPINGS_MODE_TEXT_256x256_A]  		= { 0x20, 0x20 }, 
		[MAPPINGS_MODE_TEXT_512x256_A]  		= { 0x40, 0x20 }, 
		[MAPPINGS_MODE_TEXT_256x512_A]  		= { 0x20, 0x40 }, 
		[MAPPINGS_MODE_TEXT_512x512_A]  		= { 0x40, 0x40 }, 
		[MAPPINGS_MODE_AFFINE_128x128_A]  		= { 0x10, 0x10 }, 
		[MAPPINGS_MODE_AFFINE_256x256_A]  		= { 0x20, 0x20 }, 
		[MAPPINGS_MODE_AFFINE_512x512_A]  		= { 0x40, 0x40 }, 
		[MAPPINGS_MODE_AFFINE_1024x1024_A]  	= { 0x80, 0x80 }, 
		[MAPPINGS_MODE_256x16PLTT_128x128_A]  	= { 0x10, 0x10 },
	    [MAPPINGS_MODE_256x16PLTT_256x256_A]  	= { 0x20, 0x20 }, 
		[MAPPINGS_MODE_256x16PLTT_512x512_A]  	= { 0x40, 0x40 }, 
		[MAPPINGS_MODE_256x16PLTT_1024x1024_A]  = { 0x80, 0x80 }, 
		[MAPPINGS_MODE_TEXT_256x256_B]  		= { 0x20, 0x20 }, 
		[MAPPINGS_MODE_TEXT_512x256_B]  		= { 0x40, 0x20 }, 
		[MAPPINGS_MODE_TEXT_256x512_B]  		= { 0x20, 0x40 }, 
		[MAPPINGS_MODE_TEXT_512x512_B]  		= { 0x40, 0x40 }, 
		[MAPPINGS_MODE_AFFINE_128x128_B] 		= { 0x10, 0x10 }, 
		[MAPPINGS_MODE_AFFINE_256x256_B] 		= { 0x20, 0x20 },
	    [MAPPINGS_MODE_AFFINE_512x512_B] 		= { 0x40, 0x40 }, 
		[MAPPINGS_MODE_AFFINE_1024x1024_B] 		= { 0x80, 0x80 }, 
		[MAPPINGS_MODE_256x16PLTT_128x128_B] 	= { 0x10, 0x10 }, 
		[MAPPINGS_MODE_256x16PLTT_256x256_B] 	= { 0x20, 0x20 }, 
		[MAPPINGS_MODE_256x16PLTT_512x512_B] 	= { 0x40, 0x40 }, 
		[MAPPINGS_MODE_256x16PLTT_1024x1024_B] 	= { 0x80, 0x80 },
    },

    .bgTileSize = {
        [MAPPINGS_MODE_TEXT_256x256_A]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_512x256_A]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_256x512_A]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_512x512_A]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_AFFINE_128x128_A]  		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_AFFINE_256x256_A]  		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_AFFINE_512x512_A]  		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_AFFINE_1024x1024_A]  	= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_256x16PLTT_128x128_A]  	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_256x16PLTT_256x256_A]  	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_256x16PLTT_512x512_A]  	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_256x16PLTT_1024x1024_A]	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_256x256_B]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_512x256_B]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_256x512_B]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_TEXT_512x512_B]  		= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_AFFINE_128x128_B] 		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_AFFINE_256x256_B] 		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_AFFINE_512x512_B] 		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_AFFINE_1024x1024_B] 		= sizeof(GXScrFmtAffine), 
		[MAPPINGS_MODE_256x16PLTT_128x128_B] 	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_256x16PLTT_256x256_B] 	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_256x16PLTT_512x512_B] 	= sizeof(GXScrFmtText), 
		[MAPPINGS_MODE_256x16PLTT_1024x1024_B] 	= sizeof(GXScrFmtText)
    },
};

// --------------------
// FUNCTIONS
// --------------------

void InitMappingsQueueSystem(void)
{
    mappingsListStart = NULL;
    mappingsListEnd   = NULL;
}

void Mappings__ReadList(void)
{
    MappingsQueueEntry *entry = mappingsListStart;
    while (entry)
    {
        readTable[entry->type](entry);
        FreeQueueEntry((QueueEntry *)mappingsListStart);

        entry             = mappingsListStart->next;
        mappingsListStart = entry;
        if (mappingsListStart == NULL)
            mappingsListEnd = NULL;
    }
}

NONMATCH_FUNC void Mappings__ReadMappingsCompressed(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX,
                                                    u16 offsetY, u16 displayWidth, u16 displayHeight)
{
    // https://decomp.me/scratch/lQAQP -> 71.20%
#ifdef NON_MATCHING
    void *vramLocation[] = { VRAM_BG, VRAM_DB_BG };

    BOOL useEngineB;
    if ((s32)mode >= MAPPINGS_MODE_TEXT_256x256_A && mode < MAPPINGS_MODE_TEXT_256x256_B)
        useEngineB = FALSE;
    else
        useEngineB = TRUE;

    s32 tileSize = mappingsQueueSystem.bgTileSize[mode];

    if (!flag)
    {
        switch ((s32)mode)
        {
            case MAPPINGS_MODE_TEXT_512x512_A:
            case MAPPINGS_MODE_TEXT_512x512_B:
                if (offsetX < 32 && offsetY + displayHeight > 32)
                {
                    MappingsQueueEntry *entry = Mappings__AddToList();
                    if (HeapNull == entry)
                        return;

                    fx32 y2;
                    u16 offsetY2;
                    u16 displayHeight2;
                    if (offsetY > 32)
                    {
                        y2             = y;
                        offsetY2       = offsetY;
                        displayHeight2 = displayHeight;
                    }
                    else
                    {
                        y2             = (y + 32 - offsetY);
                        displayHeight2 = displayHeight + (32 - offsetY);
                        offsetY2       = 0;
                    }

                    s32 srcMappingsOffset = x + width * y2;
                    s32 v22               = offsetX + displayWidth;
                    if (offsetX + displayWidth > 32)
                        v22 = 32 - offsetX;

                    s32 dstMappingPos = offsetX + 32 * offsetY2;
                    s32 displayWidth2;
                    if (offsetX + displayWidth > 32)
                        displayWidth2 = v22;
                    else
                        displayWidth2 = displayWidth;

                    entry->type              = 0;
                    entry->dstMappingsStride = 64;
                    entry->dstMappingsOffset = sizeof(GXScrFmtText) * (dstMappingPos + 2048);
                    entry->dstMappingsPtr    = &vramLocation[useEngineB][0x10000 * screenBaseA + 0x800 * screenBaseBlock];
                    entry->srcMappingsPtr    = srcMappingsPtr;
                    entry->srcMappingsStride = sizeof(GXScrFmtText) * width;
                    entry->srcMappingsOffset = sizeof(GXScrFmtText) * srcMappingsOffset;
                    entry->displayWidth      = sizeof(GXScrFmtText) * displayWidth2;
                    entry->displayHeight     = displayHeight2;
                }

                if ((offsetX + displayWidth) > 32 && (offsetY + displayHeight) > 32)
                {
                    MappingsQueueEntry *entry = Mappings__AddToList();
                    if (HeapNull == entry)
                        return;

                    u16 v27;
                    u16 v28;
                    u16 v29;
                    if (offsetX > 32)
                    {
                        v27 = x;
                        v28 = offsetX - 32;
                        v29 = displayWidth;
                    }
                    else
                    {
                        v27 = x + 32 - offsetX;
                        v29 = displayWidth - (32 - offsetX);
                        v28 = 0;
                    }

                    u16 v30;
                    u16 v31;
                    u16 v32;
                    if (offsetY > 32)
                    {
                        v30 = y;
                        v31 = offsetY;
                        v32 = displayHeight;
                    }
                    else
                    {
                        v32 = displayHeight - (32 - offsetY);
                        v30 = y + 32 - offsetY;
                        v31 = 0;
                    }

                    entry->type              = 0;
                    entry->dstMappingsStride = 64;
                    entry->dstMappingsOffset = sizeof(GXScrFmtText) * (v28 + 32 * v31 + 3072);
                    entry->dstMappingsPtr    = &vramLocation[useEngineB][0x10000 * screenBaseA + 0x800 * screenBaseBlock];
                    entry->srcMappingsPtr    = srcMappingsPtr;
                    entry->srcMappingsStride = sizeof(GXScrFmtText) * width;
                    entry->srcMappingsOffset = sizeof(GXScrFmtText) * (v27 + width * v30);
                    entry->displayWidth      = sizeof(GXScrFmtText) * v29;
                    entry->displayHeight     = v32;
                }
                // fallthrough

            case MAPPINGS_MODE_TEXT_512x256_A:
            case MAPPINGS_MODE_TEXT_512x256_B:
                if (offsetX < 32 && offsetY < 32)
                {
                    MappingsQueueEntry *entry = Mappings__AddToList();
                    if (HeapNull == entry)
                        return;

                    s32 v36;
                    s32 v37 = offsetX + displayWidth;
                    if (offsetX + displayWidth >= 32)
                        v37 = 32 - offsetX;
                    else
                        v36 = displayWidth;

                    if (offsetX + displayWidth >= 32)
                        v36 = v37;

                    s32 v35;
                    s32 v38 = offsetY + displayHeight;
                    if (offsetY + displayHeight <= 32)
                        v35 = displayHeight;
                    else
                        v38 = 32 - offsetY;

                    if (offsetY + displayHeight > 32)
                        v35 = v38;

                    entry->type              = 0;
                    entry->dstMappingsStride = 64;
                    entry->dstMappingsOffset = sizeof(GXScrFmtText) * (offsetX + 32 * offsetY);
                    entry->dstMappingsPtr    = &vramLocation[useEngineB][0x10000 * screenBaseA + 0x800 * screenBaseBlock];
                    entry->srcMappingsPtr    = srcMappingsPtr;
                    entry->srcMappingsStride = sizeof(GXScrFmtText) * width;
                    entry->srcMappingsOffset = sizeof(GXScrFmtText) * (x + width * y);
                    entry->displayWidth      = sizeof(GXScrFmtText) * v36;
                    entry->displayHeight     = v35;
                }

                if (offsetX + displayWidth > 32 && offsetY < 32)
                {
                    MappingsQueueEntry *entry = Mappings__AddToList();
                    if (HeapNull != entry)
                    {
                        if (offsetX <= 0x20)
                        {
                            x += 32 - offsetX;
                            displayWidth -= (32 - offsetX);
                            offsetX = 0;
                        }
                        else
                        {
                            offsetX -= 32;
                        }

                        if (offsetY + displayHeight > 32)
                            displayHeight = 32 - offsetY;

                        entry->type              = 0;
                        entry->dstMappingsStride = 64;
                        entry->dstMappingsOffset = sizeof(GXScrFmtText) * (offsetX + 32 * offsetY + 1024);
                        entry->dstMappingsPtr    = &vramLocation[useEngineB][0x10000 * screenBaseA + 0x800 * screenBaseBlock];
                        entry->srcMappingsPtr    = srcMappingsPtr;
                        entry->srcMappingsStride = sizeof(GXScrFmtText) * width;
                        entry->srcMappingsOffset = sizeof(GXScrFmtText) * (x + width * y);
                        entry->displayWidth      = sizeof(GXScrFmtText) * displayWidth;
                        entry->displayHeight     = displayHeight;
                    }
                }
                return;
        }
    }

    MappingsQueueEntry *entry = Mappings__AddToList();
    if (HeapNull != entry)
    {
        s32 bgTileWidth          = mappingsQueueSystem.bgTileDimensions[mode][0];
        entry->type              = 0;
        entry->dstMappingsStride = tileSize * bgTileWidth;
        entry->dstMappingsOffset = tileSize * (offsetX + offsetY * bgTileWidth);
        entry->dstMappingsPtr    = &vramLocation[useEngineB][0x10000 * screenBaseA + 0x800 * screenBaseBlock];
        entry->srcMappingsPtr    = srcMappingsPtr;
        entry->srcMappingsStride = tileSize * width;
        entry->srcMappingsOffset = tileSize * (x + width * y);
        entry->displayWidth      = tileSize * displayWidth;
        entry->displayHeight     = displayHeight;
    }
#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r4, =0x021120CC // _021120CC
	ldr r9, [sp, #0x44]
	ldr r5, [r4, #0x10]
	ldr r4, [r4, #0x14]
	str r0, [sp]
	str r2, [sp, #4]
	ldr r0, [sp, #0x48]
	mov r11, r1
	str r0, [sp, #0x48]
	ldr r0, [sp, #0x4c]
	mov r10, r3
	str r0, [sp, #0x4c]
	str r5, [sp, #0x10]
	str r4, [sp, #0x14]
	cmp r9, #0
	ldr r8, [sp, #0x50]
	ldr r7, [sp, #0x54]
	ldr r6, [sp, #0x58]
	ldr r5, [sp, #0x5c]
	blt _0207C604
	cmp r9, #0xc
	movlt r0, #0
	strlt r0, [sp, #8]
	blt _0207C60C
_0207C604:
	mov r0, #1
	str r0, [sp, #8]
_0207C60C:
	ldr r0, [sp, #0x40]
	ldr r1, =mappingsQueueSystem.bgTileSize
	cmp r0, #0
	ldrb r0, [r1, r9]
	str r0, [sp, #0xc]
	bne _0207CA20
	cmp r9, #0xd
	bgt _0207C650
	bge _0207C860
	cmp r9, #3
	bgt _0207CA20
	cmp r9, #1
	blt _0207CA20
	beq _0207C860
	cmp r9, #3
	beq _0207C658
	b _0207CA20
_0207C650:
	cmp r9, #0xf
	bne _0207CA20
_0207C658:
	cmp r8, #0x20
	bhs _0207C748
	add r0, r7, r5
	cmp r0, #0x20
	ble _0207C748
	bl Mappings__AddToList
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r0, r4
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r7, #0x20
	bls _0207C6A0
	ldr r1, [sp, #4]
	mov r2, r7
	mov r0, r5
	b _0207C6C4
_0207C6A0:
	ldr r0, [sp, #4]
	rsb r2, r7, #0x20
	add r0, r0, r2
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	sub r0, r5, r2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, #0
_0207C6C4:
	mla r1, r10, r1, r11
	add r3, r8, r6
	cmp r3, #0x20
	rsbgt r3, r8, #0x20
	add r2, r8, r2, lsl #5
	movle r9, r6
	movgt r3, r3, lsl #0x10
	movgt r9, r3, lsr #0x10
	add r2, r2, #0x800
	mov r3, r2, lsl #1
	mov r2, r1, lsl #1
	mov r1, r9, lsl #1
	mov r9, #0
	strh r9, [r4, #4]
	mov r9, #0x40
	strh r9, [r4, #6]
	str r3, [r4, #8]
	ldr r3, [sp, #0x4c]
	ldr ip, [sp, #8]
	add r9, sp, #0x10
	ldr r9, [r9, ip, lsl #2]
	ldr ip, [sp, #0x48]
	mov r3, r3, lsl #0xb
	add r3, r3, ip, lsl #16
	add r3, r9, r3
	str r3, [r4, #0xc]
	ldr r3, [sp]
	str r3, [r4, #0x14]
	mov r3, r10, lsl #1
	str r3, [r4, #0x18]
	str r2, [r4, #0x1c]
	strh r1, [r4, #0x10]
	strh r0, [r4, #0x12]
_0207C748:
	add r0, r8, r6
	cmp r0, #0x20
	addgt r0, r7, r5
	cmpgt r0, #0x20
	ble _0207C860
	bl Mappings__AddToList
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r0, r4
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, #0x20
	bls _0207C798
	sub r0, r8, #0x20
	mov r0, r0, lsl #0x10
	mov r2, r11
	mov r3, r0, lsr #0x10
	mov r1, r6
	b _0207C7B8
_0207C798:
	rsb r1, r8, #0x20
	add r0, r11, r1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	sub r0, r6, r1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r3, #0
_0207C7B8:
	cmp r7, #0x20
	bls _0207C7D0
	ldr r9, [sp, #4]
	mov ip, r7
	mov r0, r5
	b _0207C7F4
_0207C7D0:
	ldr r9, [sp, #4]
	rsb r0, r7, #0x20
	add r9, r9, r0
	sub r0, r5, r0
	mov r9, r9, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r9, r9, lsr #0x10
	mov r0, r0, lsr #0x10
	mov ip, #0
_0207C7F4:
	add r3, r3, ip, lsl #5
	mla r2, r10, r9, r2
	mov r9, #0
	add r3, r3, #0xc00
	strh r9, [r4, #4]
	mov r9, #0x40
	strh r9, [r4, #6]
	mov r3, r3, lsl #1
	str r3, [r4, #8]
	ldr r3, [sp, #0x4c]
	ldr ip, [sp, #8]
	add r9, sp, #0x10
	ldr r9, [r9, ip, lsl #2]
	ldr ip, [sp, #0x48]
	mov r3, r3, lsl #0xb
	add r3, r3, ip, lsl #16
	add r3, r9, r3
	str r3, [r4, #0xc]
	ldr r3, [sp]
	mov r2, r2, lsl #1
	str r3, [r4, #0x14]
	mov r3, r10, lsl #1
	str r3, [r4, #0x18]
	mov r1, r1, lsl #1
	str r2, [r4, #0x1c]
	strh r1, [r4, #0x10]
	strh r0, [r4, #0x12]
_0207C860:
	cmp r8, #0x20
	cmplo r7, #0x20
	bhs _0207C924
	bl Mappings__AddToList
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r0, r4
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r8, r6
	cmp r0, #0x20
	rsbge r0, r8, #0x20
	movlt r2, r6
	movge r0, r0, lsl #0x10
	movge r2, r0, lsr #0x10
	add r0, r7, r5
	cmp r0, #0x20
	rsbgt r0, r7, #0x20
	movle r1, r5
	movgt r0, r0, lsl #0x10
	movgt r1, r0, lsr #0x10
	mov r0, r2, lsl #1
	mov r2, #0
	strh r2, [r4, #4]
	mov r2, #0x40
	strh r2, [r4, #6]
	add r2, r8, r7, lsl #5
	mov r2, r2, lsl #1
	str r2, [r4, #8]
	ldr r2, [sp, #0x4c]
	add r9, sp, #0x10
	mov r3, r2, lsl #0xb
	ldr r2, [sp, #8]
	ldr r9, [r9, r2, lsl #2]
	ldr r2, [sp, #0x48]
	add r2, r3, r2, lsl #16
	add r2, r9, r2
	str r2, [r4, #0xc]
	ldr r2, [sp]
	str r2, [r4, #0x14]
	mov r2, r10, lsl #1
	str r2, [r4, #0x18]
	ldr r2, [sp, #4]
	mla r2, r10, r2, r11
	mov r2, r2, lsl #1
	str r2, [r4, #0x1c]
	strh r0, [r4, #0x10]
	strh r1, [r4, #0x12]
_0207C924:
	add r0, r8, r6
	cmp r0, #0x20
	addle sp, sp, #0x18
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r7, #0x20
	addhs sp, sp, #0x18
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl Mappings__AddToList
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r0, r4
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, #0x20
	bls _0207C974
	sub r0, r8, #0x20
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	b _0207C994
_0207C974:
	rsb r1, r8, #0x20
	add r0, r11, r1
	sub r1, r6, r1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r6, r1, lsr #0x10
	mov r1, #0
_0207C994:
	add r0, r7, r5
	cmp r0, #0x20
	rsbgt r0, r7, #0x20
	movgt r0, r0, lsl #0x10
	movgt r5, r0, lsr #0x10
	add r2, r1, r7, lsl #5
	ldr r0, [sp, #4]
	mov r8, #0
	mla r1, r10, r0, r11
	ldr r0, [sp, #0x4c]
	add r7, r2, #0x400
	mov r2, r0, lsl #0xb
	strh r8, [r4, #4]
	ldr r0, [sp, #8]
	add r3, sp, #0x10
	ldr r3, [r3, r0, lsl #2]
	ldr r0, [sp, #0x48]
	mov r8, #0x40
	add r0, r2, r0, lsl #16
	strh r8, [r4, #6]
	mov r2, r7, lsl #1
	str r2, [r4, #8]
	add r0, r3, r0
	str r0, [r4, #0xc]
	ldr r0, [sp]
	add sp, sp, #0x18
	str r0, [r4, #0x14]
	mov r0, r10, lsl #1
	str r0, [r4, #0x18]
	mov r0, r1, lsl #1
	str r0, [r4, #0x1c]
	mov r0, r6, lsl #1
	strh r0, [r4, #0x10]
	strh r5, [r4, #0x12]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0207CA20:
	bl Mappings__AddToList
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r0, r4
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, =mappingsQueueSystem.bgTileDimensions
	ldr r1, [sp, #0x4c]
	ldrb r9, [r2, r9, lsl #1]
	mov r3, r1, lsl #0xb
	ldr r2, [sp, #0x48]
	add r1, sp, #0x10
	add r2, r3, r2, lsl #16
	ldr r3, [sp, #8]
	mla r8, r7, r9, r8
	ldr r3, [r1, r3, lsl #2]
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #4]
	mov r7, #0
	mul r9, r1, r9
	strh r7, [r4, #4]
	ldr r1, [sp, #0xc]
	mla r0, r10, r0, r11
	mul r7, r1, r8
	strh r9, [r4, #6]
	ldr r8, [sp, #0xc]
	mul r9, r8, r0
	mov r0, r8
	mul r6, r0, r6
	mul r1, r8, r10
	str r7, [r4, #8]
	add r0, r3, r2
	str r0, [r4, #0xc]
	ldr r0, [sp]
	str r0, [r4, #0x14]
	str r1, [r4, #0x18]
	str r9, [r4, #0x1c]
	strh r6, [r4, #0x10]
	strh r5, [r4, #0x12]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
    // clang-format on
#endif
}

void Mappings__LoadUnknown(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                           u16 displayWidth, u16 displayHeight)
{
    MappingsQueueEntry *prevStart = mappingsListStart;
    MappingsQueueEntry *prevEnd   = mappingsListEnd;

    mappingsListStart = NULL;
    mappingsListEnd   = NULL;

    Mappings__ReadMappingsCompressed(srcMappingsPtr, x, y, width, flag, mode, screenBaseA, screenBaseBlock, offsetX, offsetY, displayWidth, displayHeight);
    Mappings__ReadList();

    mappingsListStart = prevStart;
    mappingsListEnd   = prevEnd;
}

void Mappings__ReadMappings2(void *mappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                             u16 displayWidth, u16 displayHeight)
{
    if (MI_GetCompressionType(mappingsPtr) == 0)
    {
        Mappings__ReadMappingsCompressed(mappingsPtr + sizeof(MICompressionHeader), x, y, width, flag, mode, screenBaseA, screenBaseBlock, offsetX, offsetY, displayWidth,
                                         displayHeight);
    }
    else
    {
        s32 tileSize;

        BOOL useEngineB;
        if ((s32)mode >= MAPPINGS_MODE_TEXT_256x256_A && (s32)mode < MAPPINGS_MODE_TEXT_256x256_B)
            useEngineB = FALSE;
        else
            useEngineB = TRUE;

        void *vramLocation[] = { VRAM_BG, VRAM_DB_BG };

        MappingsQueueEntry *entry = Mappings__AddToList();
        tileSize                  = mappingsQueueSystem.bgTileSize[mode];
        if (HeapNull != entry)
        {
            u8 bgTileWidth           = mappingsQueueSystem.bgTileDimensions[mode][0];
            entry->type              = 1;
            entry->dstMappingsStride = tileSize * bgTileWidth;
            entry->dstMappingsOffset = tileSize * (offsetX + offsetY * bgTileWidth);
            entry->dstMappingsPtr    = &vramLocation[useEngineB][0x10000 * screenBaseA + 0x800 * screenBaseBlock];
            entry->srcMappingsPtr    = mappingsPtr;
            entry->srcMappingsStride = tileSize * width;
            entry->srcMappingsOffset = tileSize * (x + width * y);
            entry->displayWidth      = tileSize * displayWidth;
            entry->displayHeight     = displayHeight;
        }
    }
}

void Mappings__ReadMappings(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                            u16 displayWidth, u16 displayHeight)
{
    MappingsQueueEntry *prevStart = mappingsListStart;
    MappingsQueueEntry *prevEnd   = mappingsListEnd;

    mappingsListStart = NULL;
    mappingsListEnd   = NULL;

    Mappings__ReadMappings2(srcMappingsPtr, x, y, width, flag, mode, screenBaseA, screenBaseBlock, offsetX, offsetY, displayWidth, displayHeight);
    Mappings__ReadList();

    mappingsListStart = prevStart;
    mappingsListEnd   = prevEnd;
}

void Mappings__ClearQueue(void)
{
    for (QueueEntry *entry = (QueueEntry *)mappingsListStart; entry != NULL;)
    {
        FreeQueueEntry(entry);

        entry             = (QueueEntry *)mappingsListStart->next;
        mappingsListStart = (MappingsQueueEntry *)entry;
        if (entry == NULL)
            mappingsListEnd = NULL;
    }
}

static MappingsQueueEntry *Mappings__AddToList(void)
{
    MappingsQueueEntry *entry = (MappingsQueueEntry *)AllocQueueEntry();
    if (entry != HeapNull)
    {
        if (mappingsListStart == NULL)
            mappingsListStart = entry;
        else
            mappingsListEnd->next = entry;

        mappingsListEnd = entry;
        entry->next     = NULL;
    }
    return entry;
}

NONMATCH_FUNC static void Mappings__ReadMappingsFunc1(MappingsQueueEntry *entry)
{
    // TODO: research this func more
#ifdef NON_MATCHING
    u8 *dstMappingsPtr = &entry->dstMappingsPtr[entry->dstMappingsOffset];
    u8 *srcMappingsPtr = &entry->srcMappingsPtr[entry->srcMappingsOffset];
    for (u16 i = (entry->displayHeight - 1); i > 0; i--)
    {
        RenderCore_DMACopy(srcMappingsPtr, dstMappingsPtr, entry->displayWidth);
        srcMappingsPtr += entry->srcMappingsStride;
        dstMappingsPtr += entry->dstMappingsStride;
    }
#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldrh r6, [r0, #0x12]
	ldr r5, [r0, #0xc]
	ldr r4, [r0, #8]
	sub r1, r6, #1
	mov r1, r1, lsl #0x10
	cmp r6, #0
	add r6, r5, r4
	ldr r3, [r0, #0x14]
	ldr r2, [r0, #0x1c]
	ldrh r8, [r0, #0x10]
	ldrh r9, [r0, #6]
	ldr r5, [r0, #0x18]
	add r4, r3, r2
	mov r7, r1, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0207CDDC:
	mov r0, r4
	mov r1, r6
	mov r2, r8
	bl RenderCore_DMACopy
	sub r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r7, #0
	add r4, r4, r5
	add r6, r6, r9
	mov r7, r0, lsr #0x10
	bne _0207CDDC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
    // clang-format on
#endif
}

NONMATCH_FUNC static void Mappings__ReadMappingsFunc2(MappingsQueueEntry *entry)
{
    // TODO: research this func more
#ifdef NON_MATCHING
    if (MI_GetCompressionType(entry->srcMappingsPtr) != 0)
    {
        RenderCore_CPUCopyCompressed(entry->srcMappingsPtr, &entry->dstMappingsPtr[entry->dstMappingsOffset]);
    }
    else
    {
        u32 v2 = (entry->displayHeight - 1);

        u8 *dstMappingsPtr = &entry->dstMappingsPtr[entry->dstMappingsOffset];
        u8 *srcMappingsPtr = &entry->srcMappingsPtr[entry->srcMappingsOffset + sizeof(MICompressionHeader)];
        for (u16 i = v2; i != 0; i--)
        {
            RenderCore_DMACopy(srcMappingsPtr, dstMappingsPtr, entry->displayWidth);
            srcMappingsPtr += entry->srcMappingsStride;
            dstMappingsPtr += entry->dstMappingsStride;
        }
    }
#else
    // clang-format off
    stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r1, r0
	ldr r0, [r1, #0x14]
	ldr r2, [r0]
	tst r2, #0xf0
	beq _0207CE38
	ldr r2, [r1, #0xc]
	ldr r1, [r1, #8]
	add r1, r2, r1
	bl RenderCore_CPUCopyCompressed
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0207CE38:
	ldrh r6, [r1, #0x12]
	ldr r5, [r1, #0xc]
	ldr r4, [r1, #8]
	sub r2, r6, #1
	mov r2, r2, lsl #0x10
	cmp r6, #0
	add r6, r5, r4
	ldr r3, [r1, #0x1c]
	add r0, r0, #4
	ldrh r8, [r1, #0x10]
	ldrh r9, [r1, #6]
	ldr r5, [r1, #0x18]
	add r4, r3, r0
	mov r7, r2, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0207CE74:
	mov r0, r4
	mov r1, r6
	mov r2, r8
	bl RenderCore_DMACopy
	sub r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r7, #0
	add r4, r4, r5
	add r6, r6, r9
	mov r7, r0, lsr #0x10
	bne _0207CE74
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
    // clang-format on
#endif
}