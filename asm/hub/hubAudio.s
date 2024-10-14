	.include "asm/macros.inc"
	.include "global.inc"

	.bss

DockHelpers__SndHandle: // 0x02173A40
	.space 0x04

	.text

	arm_func_start DockHelpers__LoadVillageTrack
DockHelpers__LoadVillageTrack: // 0x02154360
	stmdb sp!, {r3, lr}
	bl LoadSysSoundVillage
	bl AllocSndHandle
	ldr r1, _02154378 // =DockHelpers__SndHandle
	str r0, [r1]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154378: .word DockHelpers__SndHandle
	arm_func_end DockHelpers__LoadVillageTrack

	arm_func_start HubAudio__Release
HubAudio__Release: // 0x0215437C
	stmdb sp!, {r4, lr}
	ldr r1, _021543C0 // =DockHelpers__SndHandle
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	beq _021543B0
	bl HubAudio__StopSoundHandle
	ldr r0, _021543C0 // =DockHelpers__SndHandle
	ldr r0, [r0, #0]
	bl FreeSndHandle
	ldr r0, _021543C0 // =DockHelpers__SndHandle
	mov r1, #0
	str r1, [r0]
_021543B0:
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	bl ReleaseSysSound
	ldmia sp!, {r4, pc}
	.align 2, 0
_021543C0: .word DockHelpers__SndHandle
	arm_func_end HubAudio__Release

	arm_func_start HubAudio__PlayVillageTrack
HubAudio__PlayVillageTrack: // 0x021543C4
	ldr ip, _021543D0 // =PlaySysVillageTrack
	mov r0, #0
	bx ip
	.align 2, 0
_021543D0: .word PlaySysVillageTrack
	arm_func_end HubAudio__PlayVillageTrack

	arm_func_start HubAudio__SetTrackVolume
HubAudio__SetTrackVolume: // 0x021543D4
	ldr ip, _021543DC // =SetSysTrackVolume
	bx ip
	.align 2, 0
_021543DC: .word SetSysTrackVolume
	arm_func_end HubAudio__SetTrackVolume

	arm_func_start HubAudio__FadeTrack
HubAudio__FadeTrack: // 0x021543E0
	ldr ip, _021543E8 // =FadeSysTrack
	bx ip
	.align 2, 0
_021543E8: .word FadeSysTrack
	arm_func_end HubAudio__FadeTrack

	arm_func_start HubAudio__PlayItemJingle
HubAudio__PlayItemJingle: // 0x021543EC
	stmdb sp!, {r3, lr}
	bl HubAudio__StopSoundHandle
	ldr r1, _02154428 // =audioManagerSndHeap
	mov r0, #0
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadSeq
	mov r2, #0
	sub r1, r2, #1
	ldr r0, _0215442C // =DockHelpers__SndHandle
	str r2, [sp]
	ldr r0, [r0, #0]
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154428: .word audioManagerSndHeap
_0215442C: .word DockHelpers__SndHandle
	arm_func_end HubAudio__PlayItemJingle

	arm_func_start HubAudio__PlayDecorationJingle
HubAudio__PlayDecorationJingle: // 0x02154430
	stmdb sp!, {r3, lr}
	bl HubAudio__StopSoundHandle
	ldr r1, _0215446C // =audioManagerSndHeap
	mov r0, #1
	ldr r1, [r1, #0]
	bl NNS_SndArcLoadSeq
	mov r2, #1
	sub r1, r2, #2
	ldr r0, _02154470 // =DockHelpers__SndHandle
	str r2, [sp]
	ldr r0, [r0, #0]
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215446C: .word audioManagerSndHeap
_02154470: .word DockHelpers__SndHandle
	arm_func_end HubAudio__PlayDecorationJingle

	arm_func_start HubAudio__StopSoundHandle
HubAudio__StopSoundHandle: // 0x02154474
	stmdb sp!, {r3, lr}
	ldr r0, _021544A8 // =DockHelpers__SndHandle
	ldr r0, [r0, #0]
	cmp r0, #0
	ldrne r1, [r0, #0]
	cmpne r1, #0
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, _021544A8 // =DockHelpers__SndHandle
	ldr r0, [r0, #0]
	bl NNS_SndHandleReleaseSeq
	ldmia sp!, {r3, pc}
	.align 2, 0
_021544A8: .word DockHelpers__SndHandle
	arm_func_end HubAudio__StopSoundHandle

	arm_func_start HubAudio__PlaySfx
HubAudio__PlaySfx: // 0x021544AC
	ldr r1, _021544C0 // =0x02172D04
	mov r0, r0, lsl #1
	ldr ip, _021544C4 // =PlaySysSfx
	ldrh r0, [r1, r0]
	bx ip
	.align 2, 0
_021544C0: .word 0x02172D04
_021544C4: .word PlaySysSfx
	arm_func_end HubAudio__PlaySfx