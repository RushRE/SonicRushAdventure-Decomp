#include <ex/core/exRingManager.h>
#include <ex/system/exSystem.h>
#include <game/audio/audioSystem.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *exEffectRingTask__ActiveInstanceCount;
NOT_DECOMPILED void *exEffectLoopRingTask__TaskSingleton2;
NOT_DECOMPILED void *exEffectRingTask__TaskSingleton;
NOT_DECOMPILED void *exEffectRingAdminTask__TaskSingleton;
NOT_DECOMPILED void *exEffectLoopRingTask__TaskSingleton;
NOT_DECOMPILED void *exEffectLoopRingTask__Animator;
	
NOT_DECOMPILED void *exEffectRingAdmin__UnknownTable2;
NOT_DECOMPILED void *exEffectRingAdmin__UnknownTable;
    
NOT_DECOMPILED void *_02174744;
NOT_DECOMPILED void *_021747A4;
NOT_DECOMPILED void *_02174804;
NOT_DECOMPILED void *_02174888;
NOT_DECOMPILED void *_0217490C;
NOT_DECOMPILED void *_02174B34;
NOT_DECOMPILED void *_02174D5C;
NOT_DECOMPILED void *_02174F84;
NOT_DECOMPILED void *_021751AC;
NOT_DECOMPILED void *_021753D4;
NOT_DECOMPILED void *_021755FC;
NOT_DECOMPILED void *_0217592C;
    
NOT_DECOMPILED void *aExeffectloopri;
NOT_DECOMPILED void *aExeffectringta;
NOT_DECOMPILED void *aExeffectringad;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _f_ftoi(void);
NOT_DECOMPILED void _f_sub(void);
NOT_DECOMPILED void _fadd(void);
NOT_DECOMPILED void _f_mul(void);
NOT_DECOMPILED void _fgr(void);

// --------------------
// FUNCTIONS
// --------------------

// ExRingField
NONMATCH_FUNC void exEffectLoopRingTask__InitRingSprite(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, =0x021765A4
	add r1, r4, #0x20
	mov r2, #0x104
	bl MI_CpuCopy8
	mov r0, #7
	strh r0, [r4, #0x1c]
	mov r0, #4
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x3c000
	mov r0, #0x600
	orr r2, r2, #8
	strb r2, [r4, #4]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	mov r0, #0x1000
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	mov r1, #0x4000
	mov r0, #0
	bic r2, r2, #3
	strb r2, [r4, #0x150]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r0, [r4, #0x14]
	add r0, r4, #0x12c
	ldr r1, =0x02176590
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #0]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectLoopRingTask__SetRingAnim(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	strh r1, [r6, #0x1c]
	ldr r0, =0x02176590
	mov r1, #1
	ldr r0, [r0, #0x10]
	bl Sprite__GetTextureSizeFromAnim
	ldr r1, =0x02176590
	mov r4, r0
	ldr r0, [r1, #0x10]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r5, r0
	mov r0, r4
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r5
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	ldr r2, =0x02176590
	ldrh r3, [r6, #0x1c]
	ldr r2, [r2, #0x10]
	add r0, r6, #0x20
	mov r1, #0
	bl AnimatorSprite3D__Init
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

// ExRingField
NONMATCH_FUNC void exEffectLoopRingTask__Destroy_2168190(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #0x1c]
	cmp r1, #8
	bne _021681A8
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
_021681A8:
	ldr r0, =0x02176590
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectLoopRingTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	bl GetExTaskWorkCurrent_
	mov r6, #0
	mov r0, r6
	bl LoadExSystemFile
	ldr r1, =0x02176590
	str r0, [r1, #0x10]
	bl VRAMSystem__GetPaletteUnknown
	add r6, r0, #0
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =0x02176590
	add r6, r6, r0
	ldr r0, [r1, #0x10]
	mov r1, #1
	bl Sprite__GetTextureSizeFromAnim
	ldr r1, =0x02176590
	mov r4, r0
	ldr r0, [r1, #0x10]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r5, r0
	add r0, r4, r5
	cmp r6, r0
	addlo sp, sp, #0xc
	ldmloia sp!, {r3, r4, r5, r6, pc}
	mov r0, r4
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r5
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	ldr r1, =0x02176590
	ldr r0, =0x021765A4
	ldr r2, [r1, #0x10]
	mov r1, #0
	mov r3, #7
	bl AnimatorSprite3D__Init
	mov r1, #0
	ldr r0, =0x021765A4
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	bl GetCurrentTask
	ldr r1, =0x02176590
	str r0, [r1, #4]
	bl GetExTaskCurrent
	ldr r1, =exEffectLoopRingTask__Main_Animate
	str r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectLoopRingTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectLoopRingTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, =0x021765A4
	bl AnimatorSprite3D__Release
	ldr r0, =0x02176590
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectLoopRingTask__Main_Animate(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, =0x02176590
	ldrsh r0, [r0, #0]
	cmp r0, #0
	beq _0216831C
	mov r1, #0
	ldr r0, =0x021765A4
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
_0216831C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectLoopRingTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2a0
	ldr r0, =aExeffectloopri
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exEffectLoopRingTask__Main
	ldr r1, =exEffectLoopRingTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x2a0
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, =exEffectLoopRingTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// ExRing
NONMATCH_FUNC void exEffectRingTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =0x02176590
	str r0, [r1, #8]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _021683DC
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_021683DC:
	bl GetExTaskCurrent
	ldr r1, =exEffectRingTask__Main_Ring
	str r1, [r0]
	bl exEffectRingTask__Main_Ring
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl exEffectLoopRingTask__Destroy_2168190
	ldr r0, =0x02176590
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingTask__Main_Ring(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #0x140]
	ldr r0, [r4, #4]
	sub r0, r1, r0
	str r0, [r4, #0x140]
	ldrb r0, [r4, #0x16]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0216847C
	bl exEffectRingTask__Action_Collect
	ldmia sp!, {r4, pc}
_0216847C:
	ldr r1, [r4, #0x13c]
	cmp r1, #0x5a000
	bge _021684A4
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ldrgt r1, [r4, #0x140]
	addgt r0, r0, #0x32000
	cmpgt r1, r0
	bgt _021684B4
_021684A4:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021684B4:
	add r0, r4, #0x10
	add r1, r4, #0x160
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x10
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingTask__Action_Collect(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	mov r5, r0
	mov r3, #0x27
	mov r0, #0
	sub r1, r3, #0x28
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldrh r1, [r5, #6]
	ldr r0, =0x000003E7
	cmp r1, r0
	addlo r0, r1, #1
	strloh r0, [r5, #6]
	ldrb r2, [r4, #0x16]
	add r0, r4, #0x10
	mov r1, #8
	bic r2, r2, #1
	strb r2, [r4, #0x16]
	bl exEffectLoopRingTask__SetRingAnim
	add r0, r4, #0x160
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exEffectRingTask__Main_Sparkle
	str r1, [r0]
	bl exEffectRingTask__Main_Sparkle
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingTask__Main_Sparkle(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #0x140]
	ldr r0, [r4, #4]
	sub r0, r1, r0
	str r0, [r4, #0x140]
	ldrb r0, [r4, #0x161]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _021685A0
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021685A0:
	ldr r1, [r4, #0x13c]
	cmp r1, #0x5a000
	bge _021685C8
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ldrgt r1, [r4, #0x140]
	addgt r0, r0, #0x32000
	cmpgt r1, r0
	bgt _021685D8
_021685C8:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021685D8:
	add r0, r4, #0x10
	bl exDrawReqTask__Sprite3D__Animate
	add r0, r4, #0x10
	add r1, r4, #0x160
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exEffectRingTask__Create(fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2b0
	str r1, [sp, #4]
	ldr r0, =aExeffectringta
	ldr r1, =exEffectRingTask__Destructor
	str r0, [sp, #8]
	ldr r0, =exEffectRingTask__Main
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	ldr r7, [sp, #0x2c]
	ldr r6, [sp, #0x38]
	ldr r5, [sp, #0x3c]
	bl ExTaskCreate_
	mov r8, r0
	bl GetExTaskWork_
	mov r1, r4
	mov r2, #0x2b0
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r8
	bl GetExTask
	ldr r1, =exEffectRingTask__Func8
	str r1, [r0, #8]
	add r0, r4, #0x10
	bl exEffectLoopRingTask__InitRingSprite
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0xc]
	addeq sp, sp, #0x10
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	addeq sp, sp, #0x10
	bxeq lr
	mov r2, #1
	add r0, r4, #0x160
	mov r1, #0xa800
	str r2, [r4, #0xc]
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x160
	bl exDrawReqTask__Func_2164218
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x34]
	str r1, [r4, #0x13c]
	str r7, [r4, #0x140]
	stmia r4, {r0, r6}
	str r5, [r4, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr

// clang-format on
#endif
}

// ExRingManager
NONMATCH_FUNC void exEffectRingAdminTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exEffectRingTask__ActiveInstanceCount
	str r0, [r1, #0xc]
	bl exEffectLoopRingTask__Create
	bl exEffectRingAdminTask__InitValues
	mov r0, #0
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	ldrb r2, [r4, #0]
	ldr r0, =exEffectRingAdmin__UnknownTable
	ldrh r1, [r4, #2]
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0xc
	mla r0, r1, r0, r2
	add r3, r4, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrb r1, [r4, #0]
	ldr r0, =0x021746FA
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
	bl GetExTaskCurrent
	ldr r1, =exEffectRingAdminTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingAdminTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingAdminTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, =exEffectRingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingAdminTask__Main_Active(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, pc}
	ldrsh r1, [r4, #8]
	sub r0, r1, #1
	strh r0, [r4, #8]
	cmp r1, #0
	bge _02168C74
	ldr r0, [r4, #0xc]
	mov r1, #0
	mov r2, #0x8c000
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r1, [sp, #8]
	bl _fgr
	ldr r1, [r4, #0xc]
	ldr r0, =0x45800000
	bls _02168830
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0216883C
_02168830:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0216883C:
	bl _f_ftoi
	ldrb r1, [r4, #0x10]
	mov r2, #0
	str r0, [sp, #0xc]
	mov r0, r1, lsl #0x1f
	str r2, [sp, #0x10]
	movs r0, r0, lsr #0x1f
	beq _02168884
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x25800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168884:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _021688BC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x20800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_021688BC:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _021688F4
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1b800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_021688F4:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _0216892C
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x16800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_0216892C:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02168964
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x11800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168964:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _0216899C
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xc800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_0216899C:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _021689D4
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x7800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_021689D4:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02168A0C
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x2800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168A0C:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02168A48
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x2800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168A48:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _02168A84
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x7800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168A84:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _02168AC0
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xc800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168AC0:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _02168AFC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x11800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168AFC:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02168B38
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x16800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168B38:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _02168B74
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1b800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168B74:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _02168BB0
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x20800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168BB0:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02168BEC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x25800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168BEC:
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	ldrh ip, [r4, #2]
	ldrh r0, [r4, #6]
	cmp ip, r0
	bhs _02168C2C
	ldrb r2, [r4, #0]
	ldr r1, =exEffectRingAdmin__UnknownTable
	mov r0, #0xc
	ldr r1, [r1, r2, lsl #2]
	add r3, r4, #8
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02168C74
_02168C2C:
	ldrh r0, [r4, #4]
	mov ip, #0
	ldr r1, =exEffectRingAdmin__UnknownTable
	add r0, r0, #1
	strh r0, [r4, #4]
	strh ip, [r4, #2]
	ldrb r2, [r4, #0]
	mov r0, #0xc
	add r3, r4, #8
	ldr r1, [r1, r2, lsl #2]
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrb r1, [r4, #0]
	ldr r0, =0x021746FA
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
_02168C74:
	bl exEffectRingAdminTask__InitValues
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingAdminTask__InitValues(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r5, #1
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02168D20
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02168D9C
_02168CCC: // jump table
	b _02168D9C // case 0
	b _02168CF8 // case 1
	b _02168CF8 // case 2
	b _02168D9C // case 3
	b _02168CF8 // case 4
	b _02168D9C // case 5
	b _02168CFC // case 6
	b _02168D00 // case 7
	b _02168D08 // case 8
	b _02168D10 // case 9
	b _02168D18 // case 10
_02168CF8:
	mov r5, #0
_02168CFC:
	b _02168D9C
_02168D00:
	mov r5, #2
	b _02168D9C
_02168D08:
	mov r5, #3
	b _02168D9C
_02168D10:
	mov r5, #4
	b _02168D9C
_02168D18:
	mov r5, #5
	b _02168D9C
_02168D20:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02168D9C
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02168D9C
_02168D44: // jump table
	b _02168D9C // case 0
	b _02168D70 // case 1
	b _02168D70 // case 2
	b _02168D9C // case 3
	b _02168D70 // case 4
	b _02168D9C // case 5
	b _02168D78 // case 6
	b _02168D80 // case 7
	b _02168D88 // case 8
	b _02168D90 // case 9
	b _02168D98 // case 10
_02168D70:
	mov r5, #6
	b _02168D9C
_02168D78:
	mov r5, #7
	b _02168D9C
_02168D80:
	mov r5, #8
	b _02168D9C
_02168D88:
	mov r5, #9
	b _02168D9C
_02168D90:
	mov r5, #0xa
	b _02168D9C
_02168D98:
	mov r5, #0xb
_02168D9C:
	ldr r3, =exEffectRingAdmin__UnknownTable2
	ldrb r0, [r3, #0]
	cmp r0, r5
	beq _02168DF0
	mov r2, #0
	strb r5, [r4]
	strh r2, [r4, #2]
	ldrb r1, [r4, #0]
	ldr r0, =exEffectRingAdmin__UnknownTable
	add ip, r4, #8
	ldr r1, [r0, r1, lsl #2]
	mov r0, #0xc
	mla r0, r2, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldrb r1, [r4, #0]
	ldr r0, =0x021746FA
	strb r5, [r3]
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
_02168DF0:
	strb r5, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingAdminTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x14
	ldr r0, =aExeffectringad
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exEffectRingAdminTask__Main
	ldr r1, =exEffectRingAdminTask__Destructor
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x14
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, =exEffectRingAdminTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectRingAdminTask__Destroy(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =exEffectRingTask__ActiveInstanceCount
	ldr r0, [r0, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}