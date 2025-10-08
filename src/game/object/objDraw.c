#include <game/object/objDraw.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/sprite.h>
#include <game/graphics/drawReqTask.h>
#include <game/system/allocator.h>

// --------------------
// STRUCTS
// --------------------

struct ObjDrawManager
{
    s8 managedRowStart;
    s8 managedRowEnd;
};

typedef struct ObjDrawPaletteRow_
{
    s16 flags;
    s16 refCount;
} ObjDrawPaletteRow;

// --------------------
// VARIABLES
// --------------------

static struct ObjDrawManager objDrawManager;
static ObjDrawPaletteRow objDrawPaletteRow[32];

GXRgb objDrawPalette1[0x100];
GXRgb objDrawPalette2[0x100];

// --------------------
// FUNCTIONS
// --------------------

void ObjDrawInit(void)
{
    objDrawManager.managedRowStart = 0;
    objDrawManager.managedRowEnd   = 15;

    MI_CpuClear8(objDrawPalette2, sizeof(objDrawPalette2));
    MI_CpuClear8(objDrawPalette1, sizeof(objDrawPalette1));

    ObjDrawInitRows();
}

void ObjDrawInitRows(void)
{
    MI_CpuClear8(objDrawPaletteRow, sizeof(objDrawPaletteRow));
}

void ObjDrawSetManagedRows(u8 managedRowStart, u8 managedRowEnd)
{
    objDrawManager.managedRowStart = managedRowStart;
    objDrawManager.managedRowEnd   = managedRowEnd;
}

void ObjDrawReleaseSpritePalette(u8 row)
{
    if ((row & 0xF) >= objDrawManager.managedRowStart && (row & 0xF) < objDrawManager.managedRowEnd)
    {
        if (objDrawPaletteRow[row].refCount != 0)
            objDrawPaletteRow[row].refCount--;

        if (objDrawPaletteRow[row].refCount == 0)
            objDrawPaletteRow[row].flags = 0;
    }
}

u8 ObjDrawReleaseSprite(u8 id)
{
    if (id >= OBJDRAW_SPRITE_FLAG_USE_ENGINE_B)
    {
        for (s8 r = objDrawManager.managedRowStart + 16; r < objDrawManager.managedRowEnd + 16; r++)
        {
            if (id == objDrawPaletteRow[r].flags)
            {
                if (objDrawPaletteRow[r].refCount != 0)
                    objDrawPaletteRow[r].refCount--;

                if (objDrawPaletteRow[r].refCount == 0)
                    objDrawPaletteRow[r].flags = 0;
            }
        }
    }
    else
    {
        for (s8 r = objDrawManager.managedRowStart; r < objDrawManager.managedRowEnd; r++)
        {
            if (id == objDrawPaletteRow[r].flags)
            {
                if (objDrawPaletteRow[r].refCount != 0)
                    objDrawPaletteRow[r].refCount--;

                if (objDrawPaletteRow[r].refCount == 0)
                    objDrawPaletteRow[r].flags = 0;
            }
        }
    }

    return id;
}

u8 ObjDrawAllocSpritePalette(void *fileData, u16 animID, s16 flags)
{
    s8 managedRowStart = objDrawManager.managedRowStart;
    s8 managedRowEnd   = objDrawManager.managedRowEnd;
    if ((flags & (OBJDRAW_SPRITE_FLAG_USE_ENGINE_B | OBJDRAW_SPRITE_FLAG_USE_ENGINE_A)) != 0 && (flags & OBJDRAW_SPRITE_FLAG_USE_ENGINE_B) != 0)
    {
        managedRowStart += 16;
        managedRowEnd += 16;
    }

    if ((flags & (OBJDRAW_SPRITE_FLAG_4000 | OBJDRAW_SPRITE_FLAG_2000 | OBJDRAW_SPRITE_FLAG_1000 | OBJDRAW_SPRITE_FLAG_8000)) == 0)
    {
		// check if id has already been allocated and return that row if so
        for (s8 i = managedRowStart; i < managedRowEnd; i++)
        {
            if (objDrawPaletteRow[i].flags == flags)
            {
                objDrawPaletteRow[i].refCount++;
                return i & 0xF;
            }
        }
    }

	// try to allocate a new palette row!
    s8 r = managedRowStart;
    for (; r < managedRowEnd; r++)
    {
        if (objDrawPaletteRow[r].refCount == 0)
        {
            objDrawPaletteRow[r].refCount++;
            break;
        }
    }

    if (r >= managedRowEnd)
    {
		// use the last row as a failsafe if a row can't be allocated
        return (r - 1) & 0xF;
    }
    else
    {
		// initialize palette row!
        objDrawPaletteRow[r].flags = flags;

        if ((flags & (OBJDRAW_SPRITE_FLAG_USE_ENGINE_B | OBJDRAW_SPRITE_FLAG_USE_ENGINE_A)) != 0)
        {
            if ((flags & OBJDRAW_SPRITE_FLAG_USE_ENGINE_A) != 0)
                ObjDraw__TintSprite(fileData, animID, r, FALSE);

            if ((flags & OBJDRAW_SPRITE_FLAG_USE_ENGINE_B) != 0)
                ObjDraw__TintSprite(fileData, animID, r - 16, TRUE);
        }
        else
        {
            u8 row = r;
            ObjDraw__TintSprite(fileData, animID, row, FALSE);
            ObjDraw__TintSprite(fileData, animID, row, TRUE);
        }

        return r & 0xF;
    }
}

void ObjDraw__TintSprite(void *fileData, u16 animID, u8 row, BOOL useEngineB)
{
    AnimatorSprite animator;

    if (useEngineB == FALSE)
    {
        AnimatorSprite__Init(&animator, fileData, animID, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES, FALSE, PIXEL_MODE_SPRITE, NULL, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                             SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    }
    else
    {
        AnimatorSprite__Init(&animator, fileData, animID, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES, TRUE, PIXEL_MODE_SPRITE, NULL, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                             SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    }

    animator.cParam.palette = row & 0xF;
    animator.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    AnimatorSprite__ProcessAnimationFast(&animator);

    row &= 0xF;
    s32 c = row * 16;

    MI_CpuCopy8(&((GXRgb *)animator.vramPalette)[16 * animator.cParam.palette], &objDrawPalette2[c], 0x10 * sizeof(GXRgb));

    for (; c < ((row + 1) * 16); c++)
    {
        objDrawPalette1[c] = ObjDraw__TintColor(objDrawPalette2[c], -10, -1, 0);
    }
}

NONMATCH_FUNC GXRgb ObjDraw__TintColor(GXRgb inputColor, s16 iR, s16 iG, s16 iB)
{
    // https://decomp.me/scratch/fJd4a -> 79.70%
#ifdef NON_MATCHING
    s16 r = iR + ((inputColor & GX_RGB_R_MASK) >> GX_RGB_R_SHIFT);
    s16 g = iG + ((inputColor & GX_RGB_G_MASK) >> GX_RGB_G_SHIFT);
    s16 b = iB + ((inputColor & GX_RGB_B_MASK) >> GX_RGB_B_SHIFT);

    return GX_RGB(MATH_CLAMP(r, 0, 31), MATH_CLAMP(g, 0, 31), MATH_CLAMP(b, 0, 31));
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	and ip, r0, #0x1f
	add lr, ip, r1
	and ip, r0, #0x3e0
	and r1, r0, #0x7c00
	add r1, r3, r1, asr #10
	mov r0, lr, lsl #0x10
	mov r3, r0, asr #0x10
	add r2, r2, ip, asr #5
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	cmp r3, #0x1f
	mov r0, r0, asr #0x10
	mov r1, r1, asr #0x10
	movgt r3, #0x1f
	bgt _02075428
	cmp r3, #0
	movlt r3, #0
_02075428:
	cmp r0, #0x1f
	movgt r0, #0x1f
	bgt _0207543C
	cmp r0, #0
	movlt r0, #0
_0207543C:
	cmp r1, #0x1f
	movgt r1, #0x1f
	bgt _02075450
	cmp r1, #0
	movlt r1, #0
_02075450:
	orr r0, r3, r0, lsl #5
	orr r0, r0, r1, lsl #10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void ObjDraw__TintPaletteRow(u32 row, s16 iR, s16 iG, s16 iB)
{
    ObjDraw__TintPaletteColors(row, 1, 15, iR, iG, iB);
}

NONMATCH_FUNC void ObjDraw__TintPaletteColors(u32 row, u32 start, u32 end, s16 iR, s16 iG, s16 iB)
{
    // https://decomp.me/scratch/kL4Iw -> 83.56%
#ifdef NON_MATCHING
    u32 palettePos     = 16 * row;
    GXRgb *palettePtr2 = &objDrawPalette1[palettePos];
    GXRgb *palettePtr1 = &objDrawPalette2[palettePos];

    for (u32 c = start; c <= end; c++)
    {
        palettePtr2[c] = ObjDraw__TintColor(palettePtr1[c], iR, iG, iB);
    }

    if (row < 0x10)
        QueueUncompressedPalette(palettePtr2, 16, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_OBJ_PLTT)[palettePos]));
    else
        QueueUncompressedPalette(palettePtr2, 16, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_DB_OBJ_PLTT)[palettePos]));
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	str r0, [sp]
	mov r0, r0
	mov r11, r0, lsl #4
	ldr r4, =objDrawPalette2
	ldr r0, =objDrawPalette1
	add r5, r4, r11, lsl #1
	mov r10, r1
	mov r9, r2
	mov r8, r3
	cmp r10, r9
	add r4, r0, r11, lsl #1
	ldr r7, [sp, #0x28]
	ldr r6, [sp, #0x2c]
	bhi _020754F0
_020754C4:
	mov r0, r10, lsl #1
	ldrh r0, [r5, r0]
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl ObjDraw__TintColor
	mov r1, r10, lsl #1
	add r10, r10, #1
	strh r0, [r4, r1]
	cmp r10, r9
	bls _020754C4
_020754F0:
	ldr r0, [sp]
	mov r2, #0
	cmp r0, #0x10
	mov r0, r11, lsl #1
	bhs _0207551C
	add r1, r0, #0x200
	add r3, r1, #0x5000000
	mov r0, r4
	mov r1, #0x10
	bl QueueUncompressedPalette
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0207551C:
	add r1, r0, #0x600
	add r3, r1, #0x5000000
	mov r0, r4
	mov r1, #0x10
	bl QueueUncompressedPalette
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDraw__PaletteTex__Init(NNSG3dResFileHeader *fileData, PaletteTexture *paletteTex)
{
#ifdef NON_MATCHING
    GXVRamTexPltt sTexPltt = GX_ResetBankForTexPltt();

    paletteTex->texture = NNS_G3dGetTex(fileData);

    paletteTex->palettePtr1 = (u16 *)HeapAllocHead(HEAP_USER, NNS_G3dPlttGetRequiredSize(paletteTex->texture));
    paletteTex->palettePtr2 = (u16 *)HeapAllocHead(HEAP_USER, NNS_G3dPlttGetRequiredSize(paletteTex->texture));

    u32 id    = Asset3DSetup__GetTexPaletteLocation(paletteTex->texture, 0) >> 14;
    u8 *addr  = (u8 *)VRAMSystem__GetTexturePaletteAddr(id);
    void *dst = &addr[Asset3DSetup__GetTexPaletteLocation(paletteTex->texture, 0) + -0x4000 * id];
    MI_CpuCopy8(dst, paletteTex->palettePtr2, NNS_G3dPlttGetRequiredSize(paletteTex->texture));

    GX_SetBankForTexPltt(sTexPltt);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	bl GX_ResetBankForTexPltt
	mov r5, r0
	mov r0, r4
	bl NNS_G3dGetTex
	str r0, [r7, #8]
	bl NNS_G3dPlttGetRequiredSize
	bl _AllocHeadHEAP_USER
	str r0, [r7]
	ldr r0, [r7, #8]
	bl NNS_G3dPlttGetRequiredSize
	bl _AllocHeadHEAP_USER
	str r0, [r7, #4]
	ldr r0, [r7, #8]
	mov r1, #0
	bl Asset3DSetup__GetTexPaletteLocation
	mov r6, r0, lsr #0xe
	and r0, r6, #0xff
	bl VRAMSystem__GetTexturePaletteAddr
	mov r4, r0
	ldr r0, [r7, #8]
	mov r1, #0
	bl Asset3DSetup__GetTexPaletteLocation
	add r0, r4, r0
	sub r4, r0, r6, lsl #14
	ldr r0, [r7, #8]
	bl NNS_G3dPlttGetRequiredSize
	mov r2, r0
	ldr r1, [r7, #4]
	mov r0, r4
	bl MI_CpuCopy8
	mov r0, r5
	bl GX_SetBankForTexPltt
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void ObjDraw__PaletteTex__Release(PaletteTexture *paletteTex)
{
    if (paletteTex->palettePtr1 != NULL)
        HeapFree(HEAP_USER, paletteTex->palettePtr1);

    if (paletteTex->palettePtr2 != NULL)
        HeapFree(HEAP_USER, paletteTex->palettePtr2);
}

void ObjDraw__PaletteTex__Process(PaletteTexture *paletteTex, s16 iR, s16 iG, s16 iB)
{
    u16 *palettePtr1 = paletteTex->palettePtr1;
    u16 *palettePtr2 = paletteTex->palettePtr2;

    for (u32 i = 0; i < NNS_G3dPlttGetRequiredSize(paletteTex->texture) >> 1; ++i)
    {
        palettePtr1[i] = ObjDraw__TintColor(palettePtr2[i], iR, iG, iB);
    }

    QueueUncompressedPalette(palettePtr1, NNS_G3dPlttGetRequiredSize(paletteTex->texture) >> 1, PALETTE_MODE_TEXTURE,
                             VRAMKEY_TO_KEY(Asset3DSetup__GetTexPaletteLocation(paletteTex->texture, 0)));
}

u8 ObjDrawGetRowForID(u8 id)
{
    u16 managedRowStart = objDrawManager.managedRowStart;
    u16 managedRowEnd   = objDrawManager.managedRowEnd;
    if ((id & OBJDRAW_SPRITE_FLAG_USE_ENGINE_B) != 0)
    {
        managedRowStart += 16;
        managedRowEnd += 16;
    }

    for (s16 i = managedRowStart; i < managedRowEnd; i++)
    {
        if (id == objDrawPaletteRow[i].flags)
        {
            return i & 0xF;
        }
    }

    return 0;
}

NONMATCH_FUNC GXRgb *ObjDrawGetPaletteForID(u8 id)
{
    // https://decomp.me/scratch/92sZN -> 58.93%
#ifdef NON_MATCHING
    u16 managedRowStart = objDrawManager.managedRowStart;
    u16 managedRowEnd   = objDrawManager.managedRowEnd;
    if ((id & OBJDRAW_SPRITE_FLAG_USE_ENGINE_B) != 0)
    {
        managedRowStart += 16;
        managedRowEnd += 16;
    }

    s16 i = managedRowStart;
    for (; i < managedRowEnd; i++)
    {
        if (id == objDrawPaletteRow[i].flags)
        {
            break;
        }
    }

    if (i == managedRowEnd)
        return NULL;

    s8 row = (u8)(16 * i);
    if (row < 16)
    {
        return &((GXRgb *)VRAM_OBJ_PLTT)[row];
    }
    else
    {
        return &((GXRgb *)VRAM_DB_OBJ_PLTT)[row];
    }
#else
    // clang-format off
	ldr r1, =objDrawManager
	tst r0, #0x800
	ldrsb r3, [r1, #0]
	ldrsb ip, [r1, #1]
	beq _02075730
	add r1, r3, #0x10
	add r2, ip, #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, lsr #0x10
	mov ip, r2, lsr #0x10
_02075730:
	mov r1, r3, lsl #0x10
	cmp ip, r1, asr #16
	mov r3, r1, asr #0x10
	ble _02075768
	ldr r2, =objDrawPaletteRow
_02075744:
	mov r1, r3, lsl #2
	ldrsh r1, [r2, r1]
	cmp r0, r1
	beq _02075768
	add r1, r3, #1
	mov r1, r1, lsl #0x10
	cmp ip, r1, asr #16
	mov r3, r1, asr #0x10
	bgt _02075744
_02075768:
	cmp ip, r3
	moveq r0, #0
	bxeq lr
	mov r0, r3, lsl #0x1c
	cmp r3, #0x10
	mov r0, r0, lsr #0x18
	bge _02075794
	mov r0, r0, lsl #1
	add r0, r0, #0x200
	add r0, r0, #0x5000000
	bx lr
_02075794:
	mov r0, r0, lsl #1
	add r0, r0, #0x600
	add r0, r0, #0x5000000
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC GXRgb *ObjDraw__GetHWPaletteRow(u8 id)
{
#ifdef NON_MATCHING
    u8 row = id << 4;
    if (row >= 16)
    {
        return &((GXRgb *)VRAM_DB_OBJ_PLTT)[row];
    }
    else
    {
        return &((GXRgb *)VRAM_OBJ_PLTT)[row];
    }
#else
    // clang-format off
	cmp r0, #0x10
	mov r0, r0, lsl #0x1c
	movhs r0, r0, lsr #0x18
	movhs r0, r0, lsl #1
	addhs r0, r0, #0x600
	addhs r0, r0, #0x5000000
	bxhs lr
	mov r0, r0, lsr #0x18
	mov r0, r0, lsl #1
	add r0, r0, #0x200
	add r0, r0, #0x5000000
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDraw__ChangeColors(GXRgb *colorDst, GXRgb *colorSrc1, GXRgb *colorSrc2, s32 count, u16 tint)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r7, #0
	cmp r3, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r6, [sp, #0x28]
	mov r4, #0x1f
	mov lr, r7
	mov r5, r7
_020757FC:
	mov r9, r7, lsl #1
	ldrh r8, [r1, r9]
	ldrh r9, [r2, r9]
	and ip, r8, #0x1f
	and r10, r9, #0x1f
	sub r10, r10, ip
	mul r10, r6, r10
	adds r10, ip, r10, asr #12
	movmi r10, r5
	bmi _0207582C
	cmp r10, #0x1f
	movgt r10, r4
_0207582C:
	and r11, r9, #0x3e0
	and ip, r8, #0x3e0
	mov r11, r11, asr #5
	sub r11, r11, ip, asr #5
	mul r11, r6, r11
	mov r11, r11, asr #0xc
	orr r10, r5, r10
	adds r11, r11, ip, asr #5
	mov r10, r10, lsl #0x10
	movmi r11, lr
	bmi _02075860
	cmp r11, #0x1f
	movgt r11, #0x1f
_02075860:
	mov ip, r11, lsl #5
	orr r10, ip, r10, lsr #16
	and ip, r8, #0x7c00
	and r8, r9, #0x7c00
	mov r8, r8, asr #0xa
	sub r8, r8, ip, asr #10
	mul r8, r6, r8
	mov r8, r8, asr #0xc
	adds r8, r8, ip, asr #10
	mov r10, r10, lsl #0x10
	movmi r8, #0
	bmi _02075898
	cmp r8, #0x1f
	movgt r8, #0x1f
_02075898:
	mov r8, r8, lsl #0xa
	orr r9, r8, r10, lsr #16
	add r8, r7, #1
	mov r8, r8, lsl #0x10
	cmp r3, r8, lsr #16
	mov r7, r7, lsl #1
	strh r9, [r0, r7]
	mov r7, r8, lsr #0x10
	bgt _020757FC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void ObjDraw__TintColorArray(GXRgb *colorDst, GXRgb *colorSrc, s16 iR, s16 iG, s16 iB, s16 count)
{
    for (u16 i = 0; i < count; i++)
    {
        colorDst[i] = ObjDraw__TintColor(colorSrc[i], iR, iG, iB);
    }
}
