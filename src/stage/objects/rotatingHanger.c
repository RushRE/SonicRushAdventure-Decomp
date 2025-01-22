#include <stage/objects/rotatingHanger.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *aActAcGmkRotHan;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC RotatingHanger *RotatingHanger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0xa0
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkRotHan
	bl ObjObjectAction2dBACLoad
	ldr r1, [r4, #0x1a4]
	mov r0, r4
	orr r1, r1, #0x200
	str r1, [r4, #0x1a4]
	mov r1, #0
	mov r2, #0x55
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =RotatingHanger__OnDefend
	mov r0, r4
	str r1, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	mov r1, #0
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	bl StageTask__SetAnimation
	ldr r1, =RotatingHanger__State_Active
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void RotatingHanger__State_Active(RotatingHanger *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x35c]
	cmp r1, #0
	beq _02162050
	ldr r0, [r1, #0x6d8]
	cmp r0, r4
	bne _02162008
	ldr r0, [r1, #0x6f8]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0x4000
	strh r0, [r4, #0x34]
	ldmia sp!, {r4, pc}
_02162008:
	mov r0, #0
	str r0, [r4, #0x35c]
	mov r0, #0x10
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x354]
	orr r0, r0, #1
	str r0, [r4, #0x354]
	ldrh r0, [r4, #0x34]
	cmp r0, #0x8000
	blt _02162040
	rsb r0, r0, #0x10000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	rsb r0, r0, #0
_02162040:
	str r0, [r4, #0x2c]
	mov r0, #0
	str r0, [r4, #0xc8]
	ldmia sp!, {r4, pc}
_02162050:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02162070
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldreq r0, [r4, #0x18]
	biceq r0, r0, #2
	streq r0, [r4, #0x18]
_02162070:
	ldr r0, [r4, #0x354]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r1, #0x100
	bge _021620C0
	ldr r1, [r4, #0xc8]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, #0x80
	bge _021620C0
	mov r0, #0
	strh r0, [r4, #0x34]
	ldr r0, [r4, #0x354]
	bic r0, r0, #1
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_021620C0:
	cmp r0, #0
	ldr r0, [r4, #0xc8]
	blt _021620F8
	cmp r0, #0
	blt _021620E0
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0xc8]
_021620E0:
	ldr r0, [r4, #0xc8]
	mvn r1, #0x3f
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0xc8]
	b _02162120
_021620F8:
	cmp r0, #0
	bge _0216210C
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0xc8]
_0216210C:
	ldr r0, [r4, #0xc8]
	mov r1, #0x40
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0xc8]
_02162120:
	ldr r1, [r4, #0x2c]
	ldr r0, [r4, #0xc8]
	add r0, r1, r0
	str r0, [r4, #0x2c]
	strh r0, [r4, #0x34]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void RotatingHanger__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r1, #0
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	ldrh r2, [r0, #0]
	cmp r2, #1
	ldmneia sp!, {r3, pc}
	ldr r2, [r1, #0x354]
	bic r2, r2, #1
	str r2, [r1, #0x354]
	str r0, [r1, #0x35c]
	ldr r2, [r1, #0x18]
	orr r2, r2, #2
	str r2, [r1, #0x18]
	ldr r3, [r0, #0x48]
	ldr r2, [r1, #0x48]
	cmp r3, r2
	movlt r3, #0
	mov r2, #0x18000
	movge r3, #1
	rsb r2, r2, #0
	bl Player__Gimmick_201CDDC
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}
