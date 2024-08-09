	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start BundleFileUnknown__LoadFile
BundleFileUnknown__LoadFile: // 0x02051264
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mvn r1, #0
	bl FSRequestFileSync
	mov r4, r0
	cmp r5, #0
	bne _02051294
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r5, r0
	b _020512B0
_02051294:
	mvn r0, #0
	cmp r5, r0
	bne _020512B0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	mov r5, r0
_020512B0:
	mov r0, r4
	mov r1, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BundleFileUnknown__LoadFile

	arm_func_start BundleFileUnknown__LoadFileFromBundle
BundleFileUnknown__LoadFileFromBundle: // 0x020512CC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r2
	mvn r2, #0
	bl ReadFileFromBundle
	mov r4, r0
	cmp r5, #0
	bne _020512FC
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r5, r0
	b _02051318
_020512FC:
	mvn r0, #0
	cmp r5, r0
	bne _02051318
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	mov r5, r0
_02051318:
	mov r0, r4
	mov r1, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BundleFileUnknown__LoadFileFromBundle
