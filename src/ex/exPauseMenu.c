#include <ex/core/exPauseMenu.h>
#include <ex/core/exHUD.h>
#include <game/audio/audioSystem.h>
#include <game/input/padInput.h>

// --------------------
// VARIABLES
// --------------------

struct TEMP_STATIC_VARS
{
    u16 exPauseTask__selectedAction;
    Task *exPauseTask__TaskSingleton;
};

NOT_DECOMPILED struct TEMP_STATIC_VARS exPauseTask__sVars;

// NOT_DECOMPILED void *exPauseTask__selectedAction;
// NOT_DECOMPILED void *exPauseTask__TaskSingleton;

NOT_DECOMPILED u16 exPauseTask__02175DEC[OS_LANGUAGE_CODE_MAX];
NOT_DECOMPILED u16 exPauseTask__02175DF8[2][OS_LANGUAGE_CODE_MAX];
NOT_DECOMPILED u16 exPauseTask__02175E10[2][OS_LANGUAGE_CODE_MAX];

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void _f_ftoi(void);
NOT_DECOMPILED void _f_itof(void);
NOT_DECOMPILED void _fdiv(void);

// ExPauseMenu
NONMATCH_FUNC void exPauseTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	bl GetExTaskWorkCurrent_
	mov r7, r0
	bl GetCurrentTask
	ldr r2, =exPauseTask__sVars
	mov r4, #0x2c
	str r0, [r2, #4]
	sub r1, r4, #0x2d
	mov r0, #0
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0216D984
_0216D924: // jump table
	b _0216D93C // case 0
	b _0216D948 // case 1
	b _0216D954 // case 2
	b _0216D960 // case 3
	b _0216D96C // case 4
	b _0216D978 // case 5
_0216D93C:
	mov r0, #0
	strh r0, [r7]
	b _0216D98C
_0216D948:
	mov r0, #1
	strh r0, [r7]
	b _0216D98C
_0216D954:
	mov r0, #2
	strh r0, [r7]
	b _0216D98C
_0216D960:
	mov r0, #3
	strh r0, [r7]
	b _0216D98C
_0216D96C:
	mov r0, #4
	strh r0, [r7]
	b _0216D98C
_0216D978:
	mov r0, #5
	strh r0, [r7]
	b _0216D98C
_0216D984:
	mov r0, #1
	strh r0, [r7]
_0216D98C:
	ldrh r2, [r7, #0]
	ldr r1, =exPauseTask__02175DEC
	add r0, r7, #0x18
	mov r2, r2, lsl #1
	ldrh r2, [r1, r2]
	mov r1, #8
	strh r2, [r7, #0x18]
	strh r1, [r7, #0x1a]
	bl SetupExHUDSprite
	add r0, r7, #0x98
	mov r1, #0xe000
	bl exDrawReqTask__SetConfigPriority
	mvn r0, #0x23
	strh r0, [r7, #0x80]
	mov r1, #0x3c
	add r0, r7, #0x18
	strh r1, [r7, #0x82]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r7, #0x98
	bl exDrawReqTask__Func_2164218
	ldrb r0, [r7, #0x9a]
	add r1, r7, #0x32
	mov r8, #0
	orr r0, r0, #0x20
	strb r0, [r7, #0x9a]
	add r0, r7, #0x22
	add r11, r0, #0x100
	add r0, r7, #0x1b0
	str r0, [sp, #0xc]
	add r0, r7, #0x230
	str r0, [sp, #0x10]
	add r0, r1, #0x200
	strb r8, [r7, #0x72]
	add r6, r7, #0xa0
	add r5, r7, #0x120
	str r0, [sp, #0x14]
	mvn r4, #0x23
_0216DA20:
	mov r0, #0xc
	mul r0, r8, r0
	str r0, [sp, #8]
	mov r0, #0x88
	mul r9, r8, r0
	ldrh r2, [r7, #0]
	ldr r1, =exPauseTask__02175DF8
	ldr r0, [sp, #8]
	mov r2, r2, lsl #1
	add r1, r1, r0
	ldrh r1, [r2, r1]
	add r10, r7, r9
	add r0, r6, r9
	strh r1, [r10, #0xa0]
	mov r1, #8
	strh r1, [r10, #0xa2]
	bl SetupExHUDSprite
	add r0, r5, r9
	mov r1, #0xe000
	bl exDrawReqTask__SetConfigPriority
	add r1, r10, #0x100
	strh r4, [r1, #8]
	mov r0, #0x48
	strh r0, [r1, #0xa]
	add r0, r6, r9
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r5, r9
	bl exDrawReqTask__Func_21641F0
	ldr r1, =exPauseTask__02175E10
	ldr r0, [sp, #8]
	add r2, r10, #0x100
	add r3, r1, r0
	ldrb r1, [r11, r9]
	ldr r0, [sp, #0xc]
	orr r1, r1, #0x20
	strb r1, [r11, r9]
	mov r1, #0
	strb r1, [r10, #0xfa]
	ldrh r1, [r7, #0]
	add r0, r0, r9
	mov r1, r1, lsl #1
	ldrh r1, [r1, r3]
	strh r1, [r2, #0xb0]
	mov r1, #8
	strh r1, [r2, #0xb2]
	bl SetupExHUDSprite
	ldr r0, [sp, #0x10]
	mov r1, #0xe000
	add r0, r0, r9
	bl exDrawReqTask__SetConfigPriority
	add r1, r10, #0x200
	strh r4, [r1, #0x18]
	mov r0, #0x58
	strh r0, [r1, #0x1a]
	ldr r0, [sp, #0xc]
	add r0, r0, r9
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [sp, #0x10]
	add r0, r0, r9
	bl exDrawReqTask__Func_21641F0
	ldr r0, [sp, #0x14]
	ldrb r2, [r0, r9]
	add r0, r8, #1
	mov r1, r0, lsl #0x10
	mov r8, r1, lsr #0x10
	ldr r0, [sp, #0x14]
	orr r2, r2, #0x20
	strb r2, [r0, r9]
	mov r0, #0
	strb r0, [r10, #0x20a]
	cmp r8, #2
	blo _0216DA20
	mov r0, #1
	strh r0, [r7, #2]
	mov r0, #0
	strh r0, [r7, #4]
	strh r0, [r7, #8]
	strh r0, [r7, #0xa]
	strh r0, [r7, #0xc]
	strh r0, [r7, #0xe]
	strh r0, [r7, #0x10]
	strh r0, [r7, #0x12]
	strh r0, [r7, #6]
	bl GetExTaskCurrent
	ldr r1, =exPauseTask__Main_EnterButtons
	str r1, [r0]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Func8(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =GetExTaskWorkCurrent_
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x18
	bl ReleaseExHUDSprite
	mov r7, #0
	add r6, r4, #0xa0
	add r5, r4, #0x1b0
	mov r4, #0x88
_0216DBC4:
	mul r8, r7, r4
	add r0, r6, r8
	bl ReleaseExHUDSprite
	add r0, r5, r8
	bl ReleaseExHUDSprite
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #2
	blo _0216DBC4
	ldr r0, =exPauseTask__sVars
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Main_EnterButtons(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrsh r0, [r4, #8]
	cmp r0, #0x1000
	blt _0216DC74
	ldrsh r0, [r4, #0xe]
	cmp r0, #0x1000
	bge _0216DCDC
	add r0, r0, #0x800
	strh r0, [r4, #0xe]
	ldrsh r2, [r4, #0xe]
	mvn r1, #0
	mov r0, r1, lsl #0xe
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r5, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x84000
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	strh r0, [r4, #0x80]
	b _0216DCDC
_0216DC74:
	add r0, r0, #0x200
	strh r0, [r4, #8]
	ldrsh r3, [r4, #8]
	mov r1, #2
	mov r0, #0x84000
	mov r2, r3, asr #0x1f
	mov lr, #0
	mov ip, #0x800
_0216DC94:
	add r0, r0, #0x24000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	sub r0, r5, #0x24000
	sub r1, r1, #1
	bne _0216DC94
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	strh r0, [r4, #0x80]
_0216DCDC:
	ldrsh r0, [r4, #6]
	cmp r0, #2
	ble _0216DDD8
	ldrsh r0, [r4, #0xa]
	cmp r0, #0x1000
	blt _0216DD60
	ldrsh r0, [r4, #0x10]
	cmp r0, #0x1000
	bge _0216DDD8
	add r0, r0, #0x800
	strh r0, [r4, #0x10]
	ldrsh r2, [r4, #0x10]
	mvn r1, #0
	mov r0, r1, lsl #0xe
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r5, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x84000
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #2]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x100
	strh r0, [r1, #8]
	b _0216DDD8
_0216DD60:
	add r0, r0, #0x200
	strh r0, [r4, #0xa]
	ldrsh r3, [r4, #0xa]
	mov r1, #2
	mov r0, #0x84000
	mov r2, r3, asr #0x1f
	mov lr, #0
	mov ip, #0x800
_0216DD80:
	add r0, r0, #0x24000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	sub r0, r5, #0x24000
	sub r1, r1, #1
	bne _0216DD80
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #2]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x100
	strh r0, [r1, #8]
_0216DDD8:
	ldrsh r0, [r4, #6]
	cmp r0, #4
	ble _0216DEE0
	ldrsh r0, [r4, #0xc]
	cmp r0, #0x1000
	blt _0216DE64
	ldrsh r0, [r4, #0x12]
	cmp r0, #0x1000
	blt _0216DE04
	bl exPauseTask__Action_Ready
	ldmia sp!, {r4, r5, r6, pc}
_0216DE04:
	add r0, r0, #0x800
	strh r0, [r4, #0x12]
	ldrsh r2, [r4, #0x12]
	mvn r1, #0
	mov r0, r1, lsl #0xe
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r5, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x84000
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #4]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x200
	strh r0, [r1, #0x18]
	b _0216DEE8
_0216DE64:
	add r0, r0, #0x200
	strh r0, [r4, #0xc]
	ldrsh r3, [r4, #0xc]
	mov r1, #2
	mov r0, #0x84000
	mov r2, r3, asr #0x1f
	mov lr, #0
	mov ip, #0x800
_0216DE84:
	add r0, r0, #0x24000
	umull r6, r5, r0, r3
	mla r5, r0, r2, r5
	mov r0, r0, asr #0x1f
	mla r5, r0, r3, r5
	adds r6, r6, ip
	adc r0, r5, lr
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	cmp r1, #0
	sub r0, r5, #0x24000
	sub r1, r1, #1
	bne _0216DE84
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #4]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x200
	strh r0, [r1, #0x18]
	b _0216DEE8
_0216DEE0:
	add r0, r0, #1
	strh r0, [r4, #6]
_0216DEE8:
	bl exPauseTask__Draw
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Action_Ready(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x80
	strh r1, [r0, #0x80]
	mov ip, r1
	mov r3, #0
	mov r1, #0x88
_0216DF1C:
	mla lr, r3, r1, r0
	add r3, r3, #1
	add r2, lr, #0x100
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	strh ip, [r2, #8]
	add r2, lr, #0x200
	strh ip, [r2, #0x18]
	cmp r3, #2
	blo _0216DF1C
	bl GetExTaskCurrent
	ldr r1, =exPauseTask__Main_Selecting
	str r1, [r0]
	bl exPauseTask__Main_Selecting
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Main_Selecting(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr r1, =padInput
	mov r4, r0
	ldrh r0, [r1, #4]
	tst r0, #0x40
	beq _0216DFAC
	mov ip, #0x2d
	sub r1, ip, #0x2e
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r0, #1
	strh r0, [r4, #2]
	mov r0, #0
	strh r0, [r4, #4]
	b _0216E05C
_0216DFAC:
	tst r0, #0x80
	beq _0216DFE4
	mov ip, #0x2d
	sub r1, ip, #0x2e
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #1
	strh r0, [r4, #4]
	b _0216E05C
_0216DFE4:
	tst r0, #1
	beq _0216E01C
	mov r0, #1
	mov ip, #0x2e
	sub r1, ip, #0x2f
	str r0, [r4, #0x14]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl exPauseTask__Action_Select
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216E01C:
	tst r0, #8
	beq _0216E05C
	mov r0, #0
	str r0, [r4, #0x14]
	mov r1, #1
	strh r1, [r4, #2]
	mov ip, #0x2c
	sub r1, ip, #0x2d
	strh r0, [r4, #4]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl exPauseTask__Action_Select
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0216E05C:
	bl exPauseTask__Draw
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Action_Select(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0
	strh r1, [r0, #0xc]
	strh r1, [r0, #0xa]
	mov r1, #0x10
	strh r1, [r0, #6]
	bl GetExTaskCurrent
	ldr r1, =exPauseTask__Main_SelectionMade
	str r1, [r0]
	bl exPauseTask__Main_SelectionMade
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Main_SelectionMade(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0216E144
	ldrsh r0, [r4, #0xc]
	cmp r0, #0x1000
	blt _0216E0E4
	bl GetExTaskCurrent
	ldr r1, =exPauseTask__Main_Exit
	str r1, [r0]
	bl exPauseTask__Main_Exit
	ldmia sp!, {r4, pc}
_0216E0E4:
	add r0, r0, #0x200
	strh r0, [r4, #0xc]
	ldrsh r2, [r4, #0xc]
	mov r0, #0xa0000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, ip, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x80000
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #4]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x200
	strh r0, [r1, #0x18]
	b _0216E1CC
_0216E144:
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _0216E1CC
	ldrsh r0, [r4, #0xa]
	cmp r0, #0x1000
	blt _0216E170
	bl GetExTaskCurrent
	ldr r1, =exPauseTask__Main_Exit
	str r1, [r0]
	bl exPauseTask__Main_Exit
	ldmia sp!, {r4, pc}
_0216E170:
	add r0, r0, #0x200
	strh r0, [r4, #0xa]
	ldrsh r2, [r4, #0xa]
	mov r0, #0xa0000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, ip, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x80000
	bl _f_itof
	ldr r1, =0x45800000
	bl _fdiv
	bl _f_ftoi
	ldrh r2, [r4, #2]
	mov r1, #0x88
	mla r1, r2, r1, r4
	add r1, r1, #0x100
	strh r0, [r1, #8]
_0216E1CC:
	bl exPauseTask__Draw
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Main_Exit(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r1, [r0, #6]
	cmp r1, #0
	suble r1, r1, #1
	strleh r1, [r0, #6]
	ble _0216E254
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _0216E248
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0216E22C
	ldr r0, =exPauseTask__sVars
	mov r1, #1
	strh r1, [r0]
	b _0216E254
_0216E22C:
	ldrh r0, [r0, #4]
	cmp r0, #0
	beq _0216E254
	ldr r0, =exPauseTask__sVars
	mov r1, #2
	strh r1, [r0]
	b _0216E254
_0216E248:
	ldr r0, =exPauseTask__sVars
	mov r1, #1
	strh r1, [r0]
_0216E254:
	bl exPauseTask__Draw
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exPauseTask__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x18
	bl exDrawReqTask__Sprite2D__Animate
	ldrh r1, [r4, #2]
	add r2, r4, #0xa0
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl exDrawReqTask__Sprite2D__Animate
	ldrh r1, [r4, #4]
	add r2, r4, #0x1b0
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl exDrawReqTask__Sprite2D__Animate
	ldrsh r0, [r4, #0x80]
	mov r1, #0x88
	strh r0, [r4, #0x24]
	ldrsh r0, [r4, #0x82]
	strh r0, [r4, #0x26]
	ldrh r0, [r4, #2]
	mla r2, r0, r1, r4
	add r0, r2, #0x100
	ldrsh r0, [r0, #8]
	strh r0, [r2, #0xac]
	ldrh r0, [r4, #2]
	mla r2, r0, r1, r4
	add r0, r2, #0x100
	ldrsh r0, [r0, #0xa]
	strh r0, [r2, #0xae]
	ldrh r0, [r4, #4]
	mla r3, r0, r1, r4
	add r0, r3, #0x200
	ldrsh r2, [r0, #0x18]
	add r0, r3, #0x100
	strh r2, [r0, #0xbc]
	ldrh r0, [r4, #4]
	mla r2, r0, r1, r4
	add r0, r2, #0x200
	ldrsh r1, [r0, #0x1a]
	add r0, r2, #0x100
	strh r1, [r0, #0xbe]
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x1c
	bl AnimatorSprite__DrawFrame
	ldrh r1, [r4, #2]
	add r2, r4, #0xa4
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl AnimatorSprite__DrawFrame
	ldrh r1, [r4, #4]
	add r2, r4, #0x1b4
	mov r0, #0x88
	mla r0, r1, r0, r2
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

BOOL exPauseTask__Create(void)
{
    Task *task = ExTaskCreate(exPauseTask__Main, exPauseTask__Destructor, TASK_PRIORITY_UPDATE_LIST_END - 0, TASK_GROUP(3), 0, EXTASK_TYPE_ALWAYSUPDATE, exPauseTask);

    exPauseTask *work = ExTaskGetWork(task, exPauseTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, exPauseTask__Func8);

	exPauseTask__sVars.exPauseTask__selectedAction = 0;

    return TRUE;
}

u16 exPauseTask__GetSelectedAction(void)
{
	return exPauseTask__sVars.exPauseTask__selectedAction;
}