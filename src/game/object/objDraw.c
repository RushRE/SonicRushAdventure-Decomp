#include <game/object/objDraw.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/sprite.h>
#include <game/graphics/drawReqTask.h>
#include <game/system/allocator.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *ObjDrawValue_21399A8;
NOT_DECOMPILED u32 ObjDrawValue_21399AA[32];
NOT_DECOMPILED GXRgb ObjDraw__Palette1[0x100];
NOT_DECOMPILED GXRgb ObjDraw__Palette2[0x100];

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void ObjDrawInit(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, =ObjDrawValue_21399A8
	mov r1, #0
	ldr r0, =ObjDraw__Palette2
	strb r1, [r3]
	mov ip, #0xf
	mov r2, #0x200
	strb ip, [r3, #1]
	bl MI_CpuFill8
	ldr r0, =ObjDraw__Palette1
	mov r1, #0
	mov r2, #0x200
	bl MI_CpuFill8
	bl ObjDrawFunc_2074F94
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDrawFunc_2074F94(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =MI_CpuFill8
	ldr r0, =ObjDrawValue_21399AA
	mov r1, #0
	mov r2, #0x80
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDrawFunc_2074FB0(u8 a1, u8 a2){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, =ObjDrawValue_21399A8
	strb r0, [r2]
	strb r1, [r2, #1]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDrawReleaseSpritePalette(u8 a1){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =ObjDrawValue_21399A8
	and r3, r0, #0xf
	ldrsb r2, [r1]
	cmp r3, r2
	bxlt lr
	ldrsb r1, [r1, #1]
	cmp r3, r1
	bxge lr
	ldr r2, =0x021399AC
	mov r3, r0, lsl #2
	ldrsh r1, [r2, r3]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r2, r3]
	ldr r1, =0x021399AC
	mov r2, r0, lsl #2
	ldrsh r0, [r1, r2]
	cmp r0, #0
	ldreq r0, =ObjDrawValue_21399AA
	moveq r1, #0
	streqh r1, [r0, r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDrawFunc_2075028(u8 a1){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	cmp r0, #0x800
	blt _020750B0
	ldr r1, =ObjDrawValue_21399A8
	ldrsb r2, [r1]
	ldrsb r1, [r1, #1]
	add r2, r2, #0x10
	mov r2, r2, lsl #0x18
	add r1, r1, #0x10
	mov r4, r2, asr #0x18
	cmp r1, r2, asr #24
	ldmleia sp!, {r4, pc}
	ldr lr, =ObjDrawValue_21399AA
	mov r3, #0
_02075060:
	mov ip, r4, lsl #2
	ldrsh r2, [lr, ip]
	cmp r0, r2
	bne _02075098
	add ip, lr, ip
	ldrsh r2, [ip, #2]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [ip, #2]
	add r2, lr, r4, lsl #2
	ldrsh r2, [r2, #2]
	mov ip, r4, lsl #2
	cmp r2, #0
	streqh r3, [lr, ip]
_02075098:
	add r2, r4, #1
	mov r2, r2, lsl #0x18
	cmp r1, r2, asr #24
	mov r4, r2, asr #0x18
	bgt _02075060
	ldmia sp!, {r4, pc}
_020750B0:
	ldr r1, =ObjDrawValue_21399A8
	ldrsb r4, [r1]
	ldrsb lr, [r1, #1]
	cmp r4, lr
	ldmgeia sp!, {r4, pc}
	ldr ip, =ObjDrawValue_21399AA
	mov r2, #0
_020750CC:
	mov r3, r4, lsl #2
	ldrsh r1, [ip, r3]
	cmp r0, r1
	bne _02075104
	add r3, ip, r3
	ldrsh r1, [r3, #2]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r3, #2]
	add r1, ip, r4, lsl #2
	ldrsh r1, [r1, #2]
	mov r3, r4, lsl #2
	cmp r1, #0
	streqh r2, [ip, r3]
_02075104:
	add r1, r4, #1
	mov r1, r1, lsl #0x18
	cmp lr, r1, asr #24
	mov r4, r1, asr #0x18
	bgt _020750CC
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u8 ObjDrawAllocSpritePalette(void *fileData, u16 animID, s16 flags){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r3, =ObjDrawValue_21399A8
	mov r5, r2
	mov r7, r0
	mov r6, r1
	ands r1, r5, #0xc00
	ldrsb r4, [r3]
	ldrsb r0, [r3, #1]
	beq _02075168
	tst r5, #0x800
	beq _02075168
	add r3, r4, #0x10
	add r2, r0, #0x10
	mov r0, r3, lsl #0x18
	mov r2, r2, lsl #0x18
	mov r4, r0, asr #0x18
	mov r0, r2, asr #0x18
_02075168:
	tst r5, #0xf000
	bne _020751BC
	mov lr, r4
	cmp r4, r0
	bge _020751BC
	ldr r3, =ObjDrawValue_21399AA
_02075180:
	mov ip, lr, lsl #2
	ldrsh r2, [r3, ip]
	cmp r5, r2
	bne _020751A8
	ldr r2, =0x021399AC
	and r0, lr, #0xf
	ldrsh r1, [r2, ip]
	add r1, r1, #1
	strh r1, [r2, ip]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_020751A8:
	add r2, lr, #1
	mov r2, r2, lsl #0x18
	cmp r0, r2, asr #24
	mov lr, r2, asr #0x18
	bgt _02075180
_020751BC:
	cmp r4, r0
	bge _02075204
	ldr r3, =ObjDrawValue_21399AA
_020751C8:
	add r2, r3, r4, lsl #2
	ldrsh r2, [r2, #2]
	mov ip, r4, lsl #2
	cmp r2, #0
	bne _020751F0
	ldr r3, =0x021399AC
	ldrsh r2, [r3, ip]
	add r2, r2, #1
	strh r2, [r3, ip]
	b _02075204
_020751F0:
	add r2, r4, #1
	mov r2, r2, lsl #0x18
	cmp r0, r2, asr #24
	mov r4, r2, asr #0x18
	bgt _020751C8
_02075204:
	cmp r4, r0
	subge r0, r4, #1
	andge r0, r0, #0xf
	ldmgeia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, =ObjDrawValue_21399AA
	mov r2, r4, lsl #2
	strh r5, [r0, r2]
	cmp r1, #0
	beq _02075268
	tst r5, #0x400
	beq _02075244
	mov r0, r7
	mov r1, r6
	and r2, r4, #0xff
	mov r3, #0
	bl ObjDraw__TintSprite
_02075244:
	tst r5, #0x800
	beq _02075294
	sub r2, r4, #0x10
	mov r0, r7
	mov r1, r6
	and r2, r2, #0xff
	mov r3, #1
	bl ObjDraw__TintSprite
	b _02075294
_02075268:
	and r5, r4, #0xff
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, #0
	bl ObjDraw__TintSprite
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, #1
	bl ObjDraw__TintSprite
_02075294:
	and r0, r4, #0xf
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDraw__TintSprite(void *fileData, u16 animID, u8 row, BOOL useEngineB)
{
    // https://decomp.me/scratch/mBUVT -> 85.64%
#ifdef NON_MATCHING
    AnimatorSprite animator;

    if (!useEngineB)
    {
        AnimatorSprite__Init(&animator, fileData, animID, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES, 0, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                             SPRITE_ORDER_0);
    }
    else
    {
        AnimatorSprite__Init(&animator, fileData, animID, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES, 1, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0,
                             SPRITE_ORDER_0);
    }
    animator.palette = row & 0xF;
    animator.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    AnimatorSprite__ProcessAnimationFast(&animator);

    MI_CpuCopy8(&((GXRgb *)animator.vramPalette)[16 * animator.palette], &ObjDraw__Palette2[16 * animator.palette], 0x10 * sizeof(GXRgb));

    s32 start = (16 * (row & 0xF));
    s32 end = start + 1;
    for (s32 c = start; c < end; c++)
    {
        ObjDraw__Palette1[c] = ObjDraw__TintColor(ObjDraw__Palette2[c], 0xFFF6, 0xFFFF, 0x0000);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x80
	cmp r3, #0
	mov r7, r0
	mov r6, r1
	mov r4, r2
	mov r5, #0
	mov r3, #0x40
	bne _02075300
	str r5, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	ldr r0, =0x05000200
	str r5, [sp, #0xc]
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	add r0, sp, #0x1c
	mov r1, r7
	mov r2, r6
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	b _02075334
_02075300:
	mov r0, #1
	str r0, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	ldr r0, =0x05000600
	str r5, [sp, #0xc]
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	add r0, sp, #0x1c
	mov r1, r7
	mov r2, r6
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
_02075334:
	ldr r0, [sp, #0x58]
	and r5, r4, #0xf
	orr r3, r0, #8
	mov r1, #0
	add r0, sp, #0x1c
	mov r2, r1
	strh r5, [sp, #0x6c]
	str r3, [sp, #0x58]
	bl AnimatorSprite__ProcessAnimation
	and r4, r4, #0xf
	ldrh r0, [sp, #0x6c]
	ldr r2, [sp, #0x68]
	ldr r1, =ObjDraw__Palette2
	mov r5, r4, lsl #4
	add r0, r2, r0, lsl #5
	add r1, r1, r5, lsl #1
	mov r2, #0x20
	bl MI_CpuCopy8
	add r4, r4, #1
	cmp r5, r4, lsl #4
	addge sp, sp, #0x80
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r9, =ObjDraw__Palette2
	ldr r6, =ObjDraw__Palette1
	mvn r8, #9
	mov r7, #0
_0207539C:
	mov r0, r5, lsl #1
	ldrh r0, [r9, r0]
	mov r1, r8
	mov r3, r7
	add r2, r8, #9
	bl ObjDraw__TintColor
	mov r1, r5, lsl #1
	add r5, r5, #1
	strh r0, [r6, r1]
	cmp r5, r4, lsl #4
	blt _0207539C
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC GXRgb ObjDraw__TintColor(GXRgb inputColor, s16 iR, s16 iG, s16 iB)
{
#ifdef NON_MATCHING

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
    // https://decomp.me/scratch/kL4Iw -> 83.33%
#ifdef NON_MATCHING
    u32 palettePos     = 16 * row;
    GXRgb *palettePtr1 = &ObjDraw__Palette2[palettePos];
    GXRgb *palettePtr2 = &ObjDraw__Palette1[palettePos];

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
	ldr r4, =ObjDraw__Palette2
	ldr r0, =ObjDraw__Palette1
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

    palTex->texture = NNS_G3dGetTex(fileData);

    palTex->palettePtr1 = (u16 *)HeapAllocHead(HEAP_USER, NNS_G3dPlttGetRequiredSize(palTex->texture));
    palTex->palettePtr2 = (u16 *)HeapAllocHead(HEAP_USER, NNS_G3dPlttGetRequiredSize(palTex->texture));

    u32 id    = Asset3DSetup__GetTexPaletteLocation(palTex->texture, 0) >> 14;
    u8 *addr  = (u8 *)VRAMSystem__GetTexturePaletteAddr(id);
    void *dst = &addr[Asset3DSetup__GetTexPaletteLocation(palTex->texture, 0) + -0x4000 * id];
    MI_CpuCopy8(dst, palTex->palettePtr2, NNS_G3dPlttGetRequiredSize(palTex->texture));

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

NONMATCH_FUNC void ObjDrawFunc_207568C(s32 a1){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =ObjDrawValue_21399A8
	tst r0, #0x800
	ldrsb r3, [r1]
	ldrsb ip, [r1, #1]
	beq _020756B8
	add r1, r3, #0x10
	add r2, ip, #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, lsr #0x10
	mov ip, r2, lsr #0x10
_020756B8:
	mov r1, r3, lsl #0x10
	cmp ip, r1, asr #16
	mov r3, r1, asr #0x10
	ble _020756F4
	ldr r2, =ObjDrawValue_21399AA
_020756CC:
	mov r1, r3, lsl #2
	ldrsh r1, [r2, r1]
	cmp r0, r1
	andeq r0, r3, #0xf
	bxeq lr
	add r1, r3, #1
	mov r1, r1, lsl #0x10
	cmp ip, r1, asr #16
	mov r3, r1, asr #0x10
	bgt _020756CC
_020756F4:
	mov r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ObjDrawFunc_2075704(s32 a1){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =ObjDrawValue_21399A8
	tst r0, #0x800
	ldrsb r3, [r1]
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
	ldr r2, =ObjDrawValue_21399AA
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

NONMATCH_FUNC void ObjDraw__GetHWPaletteRow(u32 a1){
#ifdef NON_MATCHING

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

NONMATCH_FUNC void ObjDraw__ChangeColors(GXRgb *colorDst, GXRgb *colorSrc1, GXRgb *colorSrc2, s32 count, u16 tint){
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

NONMATCH_FUNC void ObjDraw__TintColorArray(GXRgb *colorDst, GXRgb *colorSrc, s16 iR, s16 iG, s16 iB, u16 count)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldrsh r5, [sp, #0x24]
	ldr r6, [sp, #0x20]
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r7, r3
	mov r4, #0
	cmp r5, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020758E8:
	mov r0, r4, lsl #1
	ldrh r0, [r9, r0]
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl ObjDraw__TintColor
	add r1, r4, #1
	mov r2, r4, lsl #1
	mov r1, r1, lsl #0x10
	strh r0, [r10, r2]
	cmp r5, r1, lsr #16
	mov r4, r1, lsr #0x10
	bgt _020758E8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}
