	.include "asm/macros.inc"
	.include "global.inc"

    .public aMwm

	.text
    
    arm_func_start FontWindow__Init
FontWindow__Init: // 0x02057FD0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontFile__Init
	mov r1, #0
	str r1, [r4, #0x8c]
	str r1, [r4, #0x90]
	add r0, r4, #0x98
	strh r1, [r4, #0x94]
	bl FontDMAControl__Init
	add r1, r4, #0xa8
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear32
	mov r0, #0
	str r0, [r4, #0xac]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindow__Init

	arm_func_start FontWindow__LoadFromMemory
FontWindow__LoadFromMemory: // 0x02058010
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r1
	mov r5, r2
	bl FontWindow__Release
	str r6, [r4, #0x8c]
	mov r0, #0
	str r0, [r4, #0x90]
	ldr r1, [r4, #0x8c]
	cmp r1, #0
	beq _02058044
	mov r0, r4
	bl FontFile__InitFromHeader
_02058044:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x98
	mov r3, #1
	bl FontDMAControl__InitWithParams
	cmp r5, #0
	beq _02058098
	ldr r0, _020580A4 // =0x0211997C
	mvn r1, #0
	ldr r0, [r0]
	bl FSRequestFileSync
	mov r5, r0
	ldr r0, [r5]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xa8]
	mov r1, r0
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
_02058098:
	mov r0, #0
	str r0, [r4, #0xac]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020580A4: .word 0x0211997C
	arm_func_end FontWindow__LoadFromMemory

	arm_func_start FontWindow__LoadFromFile
FontWindow__LoadFromFile: // 0x020580A8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl FontWindow__Release
	mov r0, #0
	str r0, [r4, #0x8c]
	movs r1, r7
	str r7, [r4, #0x90]
	beq _020580E0
	mov r0, r4
	mov r2, r6
	bl FontFile__InitFromPath
_020580E0:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x98
	mov r3, #1
	bl FontDMAControl__InitWithParams
	cmp r5, #0
	beq _02058134
	ldr r0, _02058140 // =0x0211997C
	mvn r1, #0
	ldr r0, [r0]
	bl FSRequestFileSync
	mov r5, r0
	ldr r0, [r5]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xa8]
	mov r1, r0
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
_02058134:
	mov r0, #0
	str r0, [r4, #0xac]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02058140: .word 0x0211997C
	arm_func_end FontWindow__LoadFromFile

	arm_func_start FontWindow__Load_mw_frame
FontWindow__Load_mw_frame: // 0x02058144
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02058184 // =aNarcMwFrameLz7
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r5, #0xac]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02058184: .word aNarcMwFrameLz7
	arm_func_end FontWindow__Load_mw_frame

	arm_func_start FontWindow__Release
FontWindow__Release: // 0x02058188
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontFile__Release
	mov r0, #0
	str r0, [r4, #0x8c]
	str r0, [r4, #0x90]
	add r0, r4, #0x98
	bl FontDMAControl__Release
	ldr r0, [r4, #0xa8]
	cmp r0, #0
	beq _020581C0
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xa8]
_020581C0:
	ldr r0, [r4, #0xac]
	cmp r0, #0
	beq _020581D8
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xac]
_020581D8:
	mov r0, r4
	bl FontWindow__Init
	ldmia sp!, {r4, pc}
	arm_func_end FontWindow__Release

	arm_func_start FontWindow__LoadFromFile2
FontWindow__LoadFromFile2: // 0x020581E4
	stmdb sp!, {r3, lr}
	mov r3, #0
	str r3, [r0, #0x8c]
	str r1, [r0, #0x90]
	cmp r1, #0
	bne _02058204
	bl FontFile__Release
	ldmia sp!, {r3, pc}
_02058204:
	bl FontFile__InitFromPath
	ldmia sp!, {r3, pc}
	arm_func_end FontWindow__LoadFromFile2

	arm_func_start FontWindow__Clear
FontWindow__Clear: // 0x0205820C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontFile__Release
	mov r0, #0
	str r0, [r4, #0x8c]
	str r0, [r4, #0x90]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindow__Clear

	arm_func_start FontWindow__LoadWinSimple
FontWindow__LoadWinSimple: // 0x02058228
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0xa8]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, _02058278 // =0x0211997C
	mvn r1, #0
	ldr r0, [r0]
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r5, #0xa8]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02058278: .word 0x0211997C
	arm_func_end FontWindow__LoadWinSimple

	arm_func_start FontWindow__SetDMA
FontWindow__SetDMA: // 0x0205827C
	strh r1, [r0, #0x94]
	bx lr
	arm_func_end FontWindow__SetDMA

	arm_func_start FontWindow__PrepareSwapBuffer
FontWindow__PrepareSwapBuffer: // 0x02058284
	ldr ip, _02058290 // =FontDMAControl__PrepareSwapBuffer
	add r0, r0, #0x98
	bx ip
	.align 2, 0
_02058290: .word FontDMAControl__PrepareSwapBuffer
	arm_func_end FontWindow__PrepareSwapBuffer

	arm_func_start FontWindow__GetFont
FontWindow__GetFont: // 0x02058294
	ldr r1, [r0, #0x8c]
	cmp r1, #0
	ldreq r1, [r0, #0x90]
	cmpeq r1, #0
	moveq r0, #0
	bx lr
	arm_func_end FontWindow__GetFont

	arm_func_start FontWindow__Func_20582AC
FontWindow__Func_20582AC: // 0x020582AC
	add r0, r0, #0x98
	bx lr
	arm_func_end FontWindow__Func_20582AC

	arm_func_start FontWindow__GetFileFromArchive
FontWindow__GetFileFromArchive: // 0x020582B4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	add r0, r0, r1, lsl #2
	mov r4, r2
	ldr r2, [r0, #0xa8]
	cmp r2, #0
	addeq sp, sp, #0x68
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02058318 // =aMwm
	add r0, sp, #0
	bl NNS_FndMountArchive
	cmp r0, #0
	addeq sp, sp, #0x68
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, sp, #0
	mov r1, r4
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02058318: .word aMwm
	arm_func_end FontWindow__GetFileFromArchive

	arm_func_start FontWindow__GetMWBackground
FontWindow__GetMWBackground: // 0x0205831C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r2, [r0, #0xac]
	mov r4, r1
	cmp r2, #0
	addeq sp, sp, #0x68
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02058380 // =aMwm
	add r0, sp, #0
	bl NNS_FndMountArchive
	cmp r0, #0
	addeq sp, sp, #0x68
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r1, r4, lsl #1
	add r0, sp, #0
	add r1, r1, #1
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02058380: .word aMwm
	arm_func_end FontWindow__GetMWBackground

	arm_func_start FontWindow__GetMWPaletteAnimation
FontWindow__GetMWPaletteAnimation: // 0x02058384
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r2, [r0, #0xac]
	mov r4, r1
	cmp r2, #0
	addeq sp, sp, #0x68
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _020583E4 // =aMwm
	add r0, sp, #0
	bl NNS_FndMountArchive
	cmp r0, #0
	addeq sp, sp, #0x68
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, sp, #0
	mov r1, r4, lsl #1
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_020583E4: .word aMwm
	arm_func_end FontWindow__GetMWPaletteAnimation

	.data
	
_0211997C: // 0x0211997C
	.word aNarcWinSimpleL

aNarcWinSimpleL: // 0x02119980
	.asciz "narc/win_simple_lz7.narc"
	.align 4
	
aNarcMwFrameLz7: // 0x0211999C
	.asciz "narc/mw_frame_lz7.narc"
	.align 4

.public aMwm
aMwm: // 0x021199B4
	.asciz "mwm"
