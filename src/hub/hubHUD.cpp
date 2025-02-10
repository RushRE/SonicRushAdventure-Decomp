#include <hub/hubHUD.hpp>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/graphics/drawReqTask.h>
#include <hub/hubConfig.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZnwmPv(void);

NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViActEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_2157178Ev(void);
NOT_DECOMPILED void _ZN10HubControl20GetFileFrom_ViActLocEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_2157154Ev(void);

NOT_DECOMPILED void Unknown2051334__Func_20516B8(void);
NOT_DECOMPILED void Unknown2051334__Func_2051600(void);
}

// --------------------
// VARIABLES
// --------------------

static Task *HubHUD__TaskSingleton;

// --------------------
// FUNCTIONS
// --------------------

void HubHUD__Create(void)
{
    HubHUD__TaskSingleton = HubTaskCreate(HubHUD__Main, HubHUD__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1020, TASK_GROUP(16), HubHUD);

    HubHUD *work = TaskGetWork(HubHUD__TaskSingleton, HubHUD);

    HubHUD__Func_216040C(work);
    work->field_234 = 7;
}

NONMATCH_FUNC void HubHUD__Func_21600E4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, =HubHUD__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160110(s32 a1, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	ldr r0, =HubHUD__TaskSingleton
	mov r5, r1
	ldr r0, [r0, #0]
	moveq r5, #0
	bl GetTaskWork_
	mov r4, r0
	cmp r6, #0
	beq _02160148
	ldr r0, [r4, #0]
	orr r0, r0, #1
	str r0, [r4]
	b _02160158
_02160148:
	ldr r1, [r4, #0]
	bic r1, r1, #1
	str r1, [r4]
	bl HubHUD__Func_2160AE0
_02160158:
	mov r0, r4
	mov r1, r5
	bl HubHUD__Func_2160D10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_216016C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160194(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0]
	bic r1, r1, #2
	str r1, [r0]
	bl HubHUD__Func_2160AE0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_21601BC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x20
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_21601FC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x40
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_216023C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x10
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_216027C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x80
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_21602BC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x244]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_21602D8(s16 *x, s16 *y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =HubHUD__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	ldr r1, [r0, #0x244]
	cmp r1, #0
	beq _02160324
	cmp r5, #0
	addne r1, r0, #0x200
	ldrnesh r1, [r1, #0x48]
	strneh r1, [r5]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0x200
	ldrsh r0, [r0, #0x4a]
	strh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02160324:
	cmp r5, #0
	movne r0, #0
	strneh r0, [r5]
	cmp r4, #0
	movne r0, #0
	strneh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160344(s16 *x, s16 *y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =HubHUD__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	ldr r1, [r0, #0x244]
	cmp r1, #0
	beq _02160390
	cmp r5, #0
	addne r1, r0, #0x200
	ldrneh r1, [r1, #0x40]
	strneh r1, [r5]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0x200
	ldrh r0, [r0, #0x42]
	strh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02160390:
	cmp r5, #0
	movne r0, #0
	strneh r0, [r5]
	cmp r4, #0
	movne r0, #0
	strneh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_21603B0(s32 x, s32 y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	movs r5, r0
	ldr r0, =HubHUD__TaskSingleton
	mov r4, r1
	ldr r0, [r0, #0]
	moveq r4, #0
	bl GetTaskWork_
	ldr r1, [r0, #0xcc]
	cmp r5, #0
	orrne r1, r1, #1
	biceq r1, r1, #1
	str r1, [r0, #0xcc]
	mov r1, r4
	bl HubHUD__Func_2160CC4
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL HubHUD__Func_21603F0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x238]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_216040C(HubHUD *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	bl _ZN10HubControl17GetFileFrom_ViActEt
	str r0, [r4, #0x24c]
	mov r0, #0
	bl _ZN10HubControl20GetFileFrom_ViActLocEt
	str r0, [r4, #0x250]
	mov r0, r4
	bl HubHUD__Func_2160450
	mov r0, r4
	bl HubHUD__Func_2160538
	mov r0, r4
	bl HubHUD__Func_216062C
	mov r0, #0
	str r0, [r4, #0x244]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160450(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xcc
	bl MIi_CpuClear32
	ldr r0, [r4, #0x24c]
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, =0x05000600
	add r0, r4, #4
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [r4, #0x24c]
	mov r3, #4
	bl AnimatorSprite__Init
	mov r0, #0
	strh r0, [r4, #0x54]
	mov r0, #0x10
	strh r0, [r4, #0x58]
	ldr r0, [r4, #0x24c]
	mov r1, #3
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, =0x05000600
	add r0, r4, #0x68
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [r4, #0x24c]
	mov r2, #3
	mov r3, #0x204
	bl AnimatorSprite__Init
	mov r0, #1
	strh r0, [r4, #0xb8]
	mov r0, #0x10
	strh r0, [r4, #0xbc]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160538(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x238]
	str r0, [r4, #0x23c]
	add r1, r4, #0xcc
	mov r2, #0xd0
	bl MIi_CpuClear32
	ldr r0, [r4, #0x250]
	add r5, r4, #0xd4
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r5
	ldr r1, [r4, #0x250]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #2
	strh r0, [r5, #0x50]
	mov r0, #0x10
	strh r0, [r5, #0x54]
	add r5, r4, #0x138
	ldr r0, [r4, #0x250]
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, =0x05000600
	mov r0, r5
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [r4, #0x250]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #2
	strh r0, [r5, #0x50]
	mov r0, #0x10
	strh r0, [r5, #0x54]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_216062C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x19c
	bl TouchField__Init
	mov r1, #0
	ldr r0, =HubHUD__Func_2160DCC
	strb r1, [r4, #0x1ac]
	str r0, [sp]
	ldr r2, =TouchField__PointInRect
	mov r3, r1
	add r0, r4, #0x1b4
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	ldr r0, =HubHUD__Func_2160EC0
	str r1, [r4, #0x22c]
	str r0, [sp]
	ldr r2, =TouchField__PointInRect
	mov r3, r1
	add r0, r4, #0x1ec
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x230]
	bl HubHUD__Func_2160CA4
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_21606AC(HubHUD *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl HubHUD__Func_216074C
	mov r0, r4
	bl HubHUD__Func_216070C
	mov r0, r4
	bl HubHUD__Func_21606CC
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_21606CC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	add r7, r0, #4
	mov r5, r6
	mov r4, #0x64
_021606E0:
	mov r0, r7
	bl AnimatorSprite__Release
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear32
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x64
	blt _021606E0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_216070C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	add r7, r0, #0xd4
	mov r5, r6
	mov r4, #0x64
_02160720:
	mov r0, r7
	bl AnimatorSprite__Release
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear32
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x64
	blt _02160720
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_216074C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x19c
	mov r0, #0
	mov r2, #0x18
	bl MIi_CpuClear32
	add r1, r4, #0x1b4
	mov r0, #0
	mov r2, #0x70
	bl MIi_CpuClear32
	add r1, r4, #0x224
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x19c
	bl TouchField__Process
	mov r6, #0
	str r6, [r4, #0x238]
	str r6, [r4, #0x23c]
	ldr r0, [r4, #0]
	mov r5, r6
	tst r0, #1
	beq _02160804
	ldr r7, [r4, #0x224]
	tst r7, #1
	beq _02160804
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _021607F4
	tst r7, #4
	beq _021607EC
	ldr r0, [r4, #0x224]
	mov r5, #1
	bic r0, r0, #4
	mov r6, r5
	str r0, [r4, #0x224]
_021607EC:
	tst r7, #2
	movne r6, #1
_021607F4:
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #0x400
	movne r5, #1
_02160804:
	cmp r5, #0
	bne _02160868
	ldr r0, [r4, #0xcc]
	tst r0, #1
	beq _02160868
	ldr r7, [r4, #0x228]
	tst r7, #1
	beq _02160868
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _02160854
	tst r7, #4
	beq _0216084C
	mov r6, #1
	str r6, [r4, #0x238]
	ldr r0, [r4, #0x228]
	bic r0, r0, #4
	str r0, [r4, #0x228]
_0216084C:
	tst r7, #2
	movne r6, #1
_02160854:
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #0x800
	movne r0, #1
	strne r0, [r4, #0x238]
_02160868:
	cmp r5, #0
	beq _021608A4
	ldr r1, [r4, #0]
	mov r0, #0
	orr r2, r1, #2
	mov r1, #1
	str r2, [r4]
	bl HubHUD__Func_21603B0
	mov r2, #0
	add r0, r4, #4
	mov r1, #2
	str r2, [r4, #0x244]
	bl AnimatorSprite__SetAnimation
	ldr r0, =HubHUD__Main_21608DC
	bl SetCurrentTaskMainEvent
_021608A4:
	mov r0, r4
	bl HubHUD__Func_2160AF4
	mov r0, r4
	bl HubHUD__Func_2160B58
	mov r0, r4
	bl HubHUD__Func_2160C08
	mov r0, r4
	bl HubHUD__Func_2160C68
	cmp r6, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl _ZN10HubControl12Func_2157154Ev
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Main_21608DC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x19c
	bl TouchField__Process
	ldr r0, [r4, #0]
	mov r5, #0
	tst r0, #2
	moveq r5, #1
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _02160920
	ldr r0, [r4, #0x224]
	tst r0, #4
	bicne r0, r0, #4
	strne r0, [r4, #0x224]
	movne r5, #1
_02160920:
	ldr r1, =padInput
	ldr r0, =0x00000402
	ldrh r1, [r1, #4]
	tst r1, r0
	movne r5, #1
	cmp r5, #0
	beq _02160978
	ldr r1, [r4, #0]
	mov r0, #1
	bic r2, r1, #2
	mov r1, r0
	str r2, [r4]
	bl HubHUD__Func_21603B0
	ldr r0, =HubHUD__Main
	bl SetCurrentTaskMainEvent
	mov r0, r4
	bl HubHUD__Func_2160AE0
	mov r1, #0
	add r0, r4, #4
	str r1, [r4, #0x244]
	bl AnimatorSprite__SetAnimation
	b _02160A68
_02160978:
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _02160A60
	ldr r0, [r4, #0x224]
	tst r0, #2
	bne _02160A60
	ldr r0, [r4, #0x244]
	cmp r0, #0
	beq _02160A04
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _021609BC
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	movne r0, #1
	bne _021609C0
_021609BC:
	mov r0, #0
_021609C0:
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x244]
	beq _02160A68
	ldr r1, =touchInput
	add r0, r4, #0x200
	ldrh ip, [r1, #0x14]
	ldrh r2, [r0, #0x40]
	ldrh r3, [r1, #0x16]
	sub r1, ip, r2
	strh r1, [r0, #0x48]
	ldrh r1, [r0, #0x42]
	sub r1, r3, r1
	strh r1, [r0, #0x4a]
	strh ip, [r0, #0x40]
	strh r3, [r0, #0x42]
	b _02160A68
_02160A04:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160A24
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _02160A28
_02160A24:
	mov r0, #0
_02160A28:
	cmp r0, #0
	beq _02160A68
	mov r0, #1
	ldr r1, =touchInput
	str r0, [r4, #0x244]
	ldrh r3, [r1, #0x1c]
	add r0, r4, #0x200
	mov r2, #0
	strh r3, [r0, #0x40]
	ldrh r1, [r1, #0x1e]
	strh r1, [r0, #0x42]
	strh r2, [r0, #0x48]
	strh r2, [r0, #0x4a]
	b _02160A68
_02160A60:
	mov r0, #0
	str r0, [r4, #0x244]
_02160A68:
	mov r0, r4
	bl HubHUD__Func_2160AF4
	mov r0, r4
	bl HubHUD__Func_2160B58
	mov r0, #0
	str r0, [r4, #0x238]
	str r0, [r4, #0x23c]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void HubHUD__Destructor(Task *task)
{
    HubHUD *work = TaskGetWork(task, HubHUD);

    HubHUD__Func_21606AC(work);

    HubTaskDestroy<HubHUD>(task);

    HubHUD__TaskSingleton = NULL;
}

NONMATCH_FUNC void HubHUD__Func_2160AE0(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =AnimatorSprite__SetAnimation
	add r0, r0, #0x68
	mov r1, #3
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160AF4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	str r4, [sp]
	ldr r0, [r4, #0]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	str r0, [sp, #4]
	ldr r1, =HubHUD__Func_2160FC0
	add r2, sp, #0
	add r0, r4, #4
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r4, #0]
	tst r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x68
	bl AnimatorSprite__ProcessAnimation
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160B58(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0]
	tst r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, #8
	mov r1, #0x1000
	mov r2, r1
	strh r0, [r4, #0x70]
	mov ip, #0x70
	add r0, r4, #0x68
	mov r3, #0xc000
	strh ip, [r4, #0x72]
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #0x70
	strh r0, [r4, #0x70]
	mov r1, #8
	add r0, r4, #0x68
	strh r1, [r4, #0x72]
	bl AnimatorSprite__DrawFrame
	mov r0, #0xf8
	mov r1, #0x1000
	mov r2, r1
	strh r0, [r4, #0x70]
	mov ip, #0x50
	add r0, r4, #0x68
	mov r3, #0x4000
	strh ip, [r4, #0x72]
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #0x90
	strh r0, [r4, #0x70]
	mov r1, #0x1000
	mov r0, #0xb8
	strh r0, [r4, #0x72]
	add r0, r4, #0x68
	mov r2, r1
	mov r3, #0x8000
	bl AnimatorSprite__DrawFrameRotoZoom
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160C08(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r1, =renderCurrentDisplay
	str r0, [sp]
	ldr r1, [r1, #0]
	cmp r1, #1
	moveq r2, #1
	ldr r1, [r0, #0xcc]
	movne r2, #0
	tst r1, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
	add r1, r0, #0xd4
	mov r0, #0x64
	mla r0, r2, r0, r1
	mov r3, #1
	ldr r1, =HubHUD__Func_2160FC0
	add r2, sp, #0
	str r3, [sp, #4]
	bl AnimatorSprite__ProcessAnimation
	add sp, sp, #8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160C68(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =renderCurrentDisplay
	ldr r1, [r1, #0]
	cmp r1, #1
	moveq r2, #1
	ldr r1, [r0, #0xcc]
	movne r2, #0
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	add r1, r0, #0xd4
	mov r0, #0x64
	mla r0, r2, r0, r1
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160CA4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl HubHUD__Func_2160D10
	mov r0, r4
	mov r1, #0
	bl HubHUD__Func_2160CC4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160CC4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	cmp r1, #0
	mov r4, r0
	mov r1, #1
	beq _02160CE8
	mov r2, r1
	str r1, [r4, #0x228]
	bl HubHUD__Func_2160D40
	ldmia sp!, {r4, pc}
_02160CE8:
	mov r2, #0
	str r2, [r4, #0x228]
	bl HubHUD__Func_2160D40
	add r0, r4, #0xd4
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160D10(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	cmp r1, #0
	mov r1, #0
	beq _02160D30
	mov r2, #1
	str r2, [r0, #0x224]
	bl HubHUD__Func_2160D40
	ldmia sp!, {r3, pc}
_02160D30:
	mov r2, r1
	str r1, [r0, #0x224]
	bl HubHUD__Func_2160D40
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160D40(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	add r0, r5, r4, lsl #2
	cmp r2, #0
	ldr r0, [r0, #0x22c]
	beq _02160D8C
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r1, r5, #0x1b4
	mov r0, #0x38
	mla r1, r4, r0, r1
	ldr r2, =0x0000FFFF
	add r0, r5, #0x19c
	bl TouchField__AddArea
	add r0, r5, r4, lsl #2
	mov r1, #1
	str r1, [r0, #0x22c]
	ldmia sp!, {r4, r5, r6, pc}
_02160D8C:
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0x38
	mul r6, r4, r0
	add r1, r5, #0x1b4
	add r0, r5, #0x19c
	add r1, r1, r6
	bl TouchField__RemoveArea
	add r0, r5, r6
	mov r1, #0
	str r1, [r0, #0x1c8]
	str r1, [r0, #0x1cc]
	add r0, r5, r4, lsl #2
	str r1, [r0, #0x22c]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160DCC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, =HubHUD__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x224]
	ldr r0, [r5, #0x14]
	tst r1, #1
	beq _02160E00
	tst r0, #0x800
	beq _02160E14
_02160E00:
	ldr r0, [r4, #0x224]
	bic r0, r0, #4
	bic r0, r0, #2
	str r0, [r4, #0x224]
	ldmia sp!, {r4, r5, r6, pc}
_02160E14:
	ldr r0, [r6, #0]
	cmp r0, #0x400000
	bhi _02160E30
	bhs _02160E68
	cmp r0, #0x40000
	beq _02160E4C
	ldmia sp!, {r4, r5, r6, pc}
_02160E30:
	cmp r0, #0x2000000
	bhi _02160E40
	beq _02160E68
	ldmia sp!, {r4, r5, r6, pc}
_02160E40:
	cmp r0, #0x8000000
	beq _02160E88
	ldmia sp!, {r4, r5, r6, pc}
_02160E4C:
	orr r0, r1, #4
	bic r2, r0, #2
	add r0, r4, #4
	mov r1, #0
	str r2, [r4, #0x224]
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160E68:
	ldr r1, [r4, #0x224]
	add r0, r4, #4
	bic r1, r1, #4
	orr r2, r1, #2
	mov r1, #1
	str r2, [r4, #0x224]
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160E88:
	bic r0, r1, #4
	bic r0, r0, #2
	str r0, [r4, #0x224]
	bl HubHUD__Func_216016C
	cmp r0, #0
	add r0, r4, #4
	beq _02160EB0
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160EB0:
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160EC0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, =HubHUD__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x228]
	ldr r0, [r5, #0x14]
	tst r1, #1
	beq _02160EF4
	tst r0, #0x800
	beq _02160F08
_02160EF4:
	ldr r0, [r4, #0x228]
	bic r0, r0, #4
	bic r0, r0, #2
	str r0, [r4, #0x228]
	ldmia sp!, {r4, r5, r6, pc}
_02160F08:
	ldr r0, [r6, #0]
	cmp r0, #0x400000
	bhi _02160F24
	bhs _02160F68
	cmp r0, #0x40000
	beq _02160F40
	ldmia sp!, {r4, r5, r6, pc}
_02160F24:
	cmp r0, #0x2000000
	bhi _02160F34
	beq _02160F68
	ldmia sp!, {r4, r5, r6, pc}
_02160F34:
	cmp r0, #0x8000000
	beq _02160F94
	ldmia sp!, {r4, r5, r6, pc}
_02160F40:
	orr r0, r1, #4
	bic r2, r0, #2
	add r0, r4, #0xd4
	mov r1, #0
	str r2, [r4, #0x228]
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160F68:
	ldr r1, [r4, #0x228]
	add r0, r4, #0xd4
	bic r1, r1, #4
	orr r2, r1, #2
	mov r1, #1
	str r2, [r4, #0x228]
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160F94:
	bic r0, r1, #4
	bic r2, r0, #2
	add r0, r4, #0xd4
	mov r1, #0
	str r2, [r4, #0x228]
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void HubHUD__Func_2160FC0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldrh r1, [r0, #0]
	mov r4, r2
	cmp r1, #7
	addne sp, sp, #0x10
	ldmneia sp!, {r4, pc}
	add r1, sp, #0
	add r0, r0, #8
	mov r2, #8
	bl MIi_CpuCopy16
	ldmia r4, {r0, r1}
	add r2, r0, #0x1b4
	mov r0, #0x38
	mla r0, r1, r0, r2
	add r1, sp, #0
	bl TouchField__SetHitbox
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}
