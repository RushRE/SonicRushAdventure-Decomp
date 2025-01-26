#include <ex/system/exGameSystem.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/boss/exBoss.h>
#include <ex/player/exPlayer.h>
#include <ex/core/exRingManager.h>
#include <game/audio/audioSystem.h>

// --------------------
// VARIABLES
// --------------------
	
NOT_DECOMPILED void *exGameSystemTask__singleton;
	
NOT_DECOMPILED void *aExgamesystemta;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void exEffectMeteoAdminTask__Create(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Destroy_2168044(void);

// --------------------
// FUNCTIONS
// --------------------

// ExGameSystem
NONMATCH_FUNC void exGameSystemTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r2, =exGameSystemTask__singleton
	mov r1, #0
	str r0, [r2]
	mov r0, r4
	mov r2, #0x10
	bl MI_CpuFill8
	bl GetExSystemStatus
	str r0, [r4, #0xc]
	bl CreateExStage
	bl exPlayerAdminTask__Create
	bl exBossSysAdminTask__Create
	mov r0, #0x16
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	bl GetExTaskCurrent
	ldr r1, =exGameSystemTask__Main_216AB78
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	cmp r1, #0
	ldreqh r1, [r0, #0]
	addeq r1, r1, #1
	streqh r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exEffectRingAdminTask__Destroy
	bl ExBossSysAdminTask__Destroy
	bl exPlayerAdminTask__Destroy_2171730
	bl DestroyExStage
	bl exEffectMeteoAdminTask__Destroy_2168044
	ldr r0, =exGameSystemTask__singleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Main_216AB78(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	bne _0216AB98
	bl exGameSystemTask__Action_216ABA8
	ldmia sp!, {r3, pc}
_0216AB98:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Action_216ABA8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, =exGameSystemTask__Main_216ABD4
	str r1, [r0]
	bl exGameSystemTask__Main_216ABD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Main_216ABD4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ExBossSysAdminTask__Func_215DF1C
	cmp r0, #0
	bne _0216ABF0
	bl exGameSystemTask__Action_216AC00
	ldmia sp!, {r3, pc}
_0216ABF0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Action_216AC00(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exEffectMeteoAdminTask__Create
	bl exEffectRingAdminTask__Create
	mov r0, #0x384
	strh r0, [r4, #4]
	bl GetExTaskCurrent
	ldr r1, =exGameSystemTask__Main_216AC34
	str r1, [r0]
	bl exGameSystemTask__Main_216AC34
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Main_216AC34(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrh r2, [r0, #4]
	sub r1, r2, #1
	strh r1, [r0, #4]
	cmp r2, #0
	bne _0216AC58
	bl exGameSystemTask__Action_216AC68
	ldmia sp!, {r3, pc}
_0216AC58:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Action_216AC68(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exEffectMeteoAdminTask__Destroy_2168044
	mov r1, #0
	mov r0, #1
	strh r1, [r4, #4]
	bl ExBossSysAdminTask__Func_215DF2C
	bl GetExTaskCurrent
	ldr r1, =exGameSystemTask__Main_216ACA0
	str r1, [r0]
	bl exGameSystemTask__Main_216ACA0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Main_216ACA0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	bne _0216ACC0
	bl exGameSystemTask__Action_216ACD0
	ldmia sp!, {r3, pc}
_0216ACC0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Action_216ACD0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, =exGameSystemTask__Main_216ACF0
	str r1, [r0]
	bl exGameSystemTask__Main_216ACF0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Main_216ACF0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x10
	ldr r0, =aExgamesystemta
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exGameSystemTask__Main
	ldr r1, =exGameSystemTask__Destructor
	mov r2, #0x1000
	mov r3, #1
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, =exGameSystemTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exGameSystemTask__Destroy(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =exGameSystemTask__singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}
