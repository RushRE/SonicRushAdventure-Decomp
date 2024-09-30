	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ArchiveFileUnknown__LoadFile
ArchiveFileUnknown__LoadFile: // 0x0205180C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mvn r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4, #0]
	cmp r5, #0
	mov r0, r0, lsr #8
	bne _0205183C
	bl _AllocHeadHEAP_USER
	mov r5, r0
	b _02051850
_0205183C:
	mvn r1, #0
	cmp r5, r1
	bne _02051850
	bl _AllocTailHEAP_USER
	mov r5, r0
_02051850:
	mov r0, r4
	mov r1, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ArchiveFileUnknown__LoadFile

	arm_func_start ArchiveFileUnknown__LoadFileFromArchive
ArchiveFileUnknown__LoadFileFromArchive: // 0x0205186C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r4, r2
	mvn r1, #0
	bl FSRequestFileSync
	mov r5, r0
	mov r1, r6
	mov r2, r4
	bl ArchiveFileUnknown__GetFileFromMemArchive
	mov r4, r0
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ArchiveFileUnknown__LoadFileFromArchive

	arm_func_start ArchiveFileUnknown__GetFileFromMemArchive
ArchiveFileUnknown__GetFileFromMemArchive: // 0x020518A4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0xb0
	mov r6, r0
	ldr r0, [r6, #0]
	mov r5, r1
	mov r0, r0, lsr #8
	mov r7, r2
	bl _AllocTailHEAP_USER
	mov r4, r0
	mov r0, r6
	mov r1, r4
	bl RenderCore_CPUCopyCompressed
	ldr r1, _0205197C // =aAou
	add r0, sp, #0x48
	mov r2, r4
	bl NNS_FndMountArchive
	add r0, sp, #0
	bl FS_InitFile
	mov r2, r5
	add r0, sp, #0
	add r1, sp, #0x48
	bl NNS_FndOpenArchiveFileByIndex
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x24]
	cmp r7, #0
	sub r6, r1, r0
	bne _02051920
	mov r0, r6
	bl _AllocHeadHEAP_USER
	mov r5, r0
	b _0205193C
_02051920:
	mvn r0, #0
	cmp r7, r0
	movne r5, r7
	bne _0205193C
	mov r0, r6
	bl _AllocTailHEAP_USER
	mov r5, r0
_0205193C:
	add r0, sp, #0
	mov r1, r5
	mov r2, r6
	bl FS_ReadFile
	add r0, sp, #0
	bl FS_CloseFile
	add r0, sp, #0x48
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, r7
	mov r1, r6
	bl DC_StoreRange
	mov r0, r5
	add sp, sp, #0xb0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0205197C: .word aAou
	arm_func_end ArchiveFileUnknown__GetFileFromMemArchive

	arm_func_start FileUnknown__GetAOUFile
FileUnknown__GetAOUFile: // 0x02051980
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r1
	mov r2, r0
	ldr r1, _020519C0 // =aAou
	add r0, sp, #0
	bl NNS_FndMountArchive
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
_020519C0: .word aAou
	arm_func_end FileUnknown__GetAOUFile

	arm_func_start FileUnknown__GetAOUFileSize
FileUnknown__GetAOUFileSize: // 0x020519C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0xb0
	mov r4, r1
	mov r2, r0
	ldr r1, _02051A18 // =aAou
	add r0, sp, #0x48
	bl NNS_FndMountArchive
	add r0, sp, #0
	bl FS_InitFile
	add r0, sp, #0
	add r1, sp, #0x48
	mov r2, r4
	bl NNS_FndOpenArchiveFileByIndex
	ldr r2, [sp, #0x28]
	ldr r1, [sp, #0x24]
	add r0, sp, #0x48
	sub r4, r2, r1
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0xb0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02051A18: .word aAou
	arm_func_end FileUnknown__GetAOUFileSize

	.data

aAou: // 0x02119968
	.asciz "aou"
	.align 4
