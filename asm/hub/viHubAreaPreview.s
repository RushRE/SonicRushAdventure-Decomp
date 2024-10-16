	.include "asm/macros.inc"
	.include "global.inc"
	
.public HubControl__sVars

	.text

	arm_func_start ViHubAreaPreview__Create
ViHubAreaPreview__Create: // 0x02158BA0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl ViHubAreaPreview__Func_2158C04
	ldr r0, _02158BF8 // =0x00001051
	mov r2, #0
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, _02158BFC // =ViHubAreaPreview__Main
	ldr r1, _02158C00 // =ViHubAreaPreview__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	str r0, [r4, #0x30]
	mov r0, r4
	bl ViHubAreaPreview__Func_215993C
	ldr r1, [r4, #0x14]
	mov r0, r4
	bl ViHubAreaPreview__Func_2159D84
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02158BF8: .word 0x00001051
_02158BFC: .word ViHubAreaPreview__Main
_02158C00: .word ViHubAreaPreview__Destructor
	arm_func_end ViHubAreaPreview__Create

	arm_func_start ViHubAreaPreview__Func_2158C04
ViHubAreaPreview__Func_2158C04: // 0x02158C04
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x30]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl ViDock__Func_215E4A0
	cmp r0, #0
	bne _02158C30
	bl ViDock__Func_215DEF4
	mov r0, #9
	str r0, [r4, #0x18]
_02158C30:
	ldr r0, [r4, #0x30]
	bl DestroyTask
	mov r0, #0
	str r0, [r4, #0x30]
	ldmia sp!, {r4, pc}
	arm_func_end ViHubAreaPreview__Func_2158C04

	arm_func_start ViHubAreaPreview__Main
ViHubAreaPreview__Main: // 0x02158C44
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _02158D08 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	bl ViMap__Func_215BCA0
	ldr r1, [r5, #0x18]
	mov r4, r0
	cmp r4, r1
	beq _02158CE0
	mov r0, r5
	bl ViHubAreaPreview__Func_2159D14
	cmp r0, #0
	beq _02158CFC
	mov r0, r5
	mov r1, r4
	bl ViHubAreaPreview__Func_2159D84
	cmp r4, #7
	bne _02158CA0
	str r4, [r5, #0x18]
	bl ViDock__Func_215DEF4
	b _02158CFC
_02158CA0:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldr r0, [r0, #8]
	str r0, [r5, #0x10]
	cmp r0, #8
	bge _02158CD0
	str r4, [r5, #0x18]
	ldr r0, [r5, #0x10]
	mov r1, #1
	bl ViDock__Func_215DD64
	b _02158CFC
_02158CD0:
	mov r0, #9
	str r0, [r5, #0x18]
	bl ViDock__Func_215DEF4
	b _02158CFC
_02158CE0:
	cmp r1, #7
	beq _02158CF4
	bl ViDock__Func_215E4A0
	cmp r0, #0
	beq _02158CFC
_02158CF4:
	mov r0, r5
	bl ViHubAreaPreview__Func_2159D4C
_02158CFC:
	mov r0, r5
	bl ViHubAreaPreview__Func_215A014
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02158D08: .word HubControl__sVars
	arm_func_end ViHubAreaPreview__Main

	arm_func_start ViHubAreaPreview__Destructor
ViHubAreaPreview__Destructor: // 0x02158D0C
	stmdb sp!, {r3, lr}
	ldr r0, _02158D24 // =HubControl__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	bl ViHubAreaPreview__ReleaseAnimators
	ldmia sp!, {r3, pc}
	.align 2, 0
_02158D24: .word HubControl__sVars
	arm_func_end ViHubAreaPreview__Destructor

	arm_func_start ViHubAreaPreview__Func_2158D28
ViHubAreaPreview__Func_2158D28: // 0x02158D28
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mvn r0, #0xf
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _02158E04
	mov r0, #2
	bl ViMap__Func_215BB28
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _02158D88
	mov r0, #1
	bl HubAudio__Release
	mov r0, #9
	bl LoadSysSound
	mov r0, #0x27
	mov r1, #1
	bl PlaySysTrack
	ldr r0, [r4, #0x1c]
	bl ViMap__Func_215BE14
	b _02158DD8
_02158D88:
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _02158DB4
	bl HubAudio__PlayDecorationJingle
	ldr r0, [r4, #0x20]
	bl ViMap__Func_215BFC4
	mov r0, #0x7f
	add r1, r4, #0x100
	strh r0, [r1, #0x3a]
	bl HubAudio__SetTrackVolume
	b _02158DD8
_02158DB4:
	mov r0, #1
	bl HubAudio__Release
	mov r0, #0xa
	bl LoadSysSound
	mov r0, #0x28
	mov r1, #1
	bl PlaySysTrack
	ldr r0, [r4, #0x24]
	bl ViMap__Func_215C0D8
_02158DD8:
	bl ViDock__Func_215DEF4
	mov r0, #9
	str r0, [r4, #0x18]
	bl ViHubAreaPreview__Func_215ADA0
	add r0, r4, #0x100
	mov r1, #0
	strh r1, [r0, #0x10]
	ldr r1, [r4, #4]
	ldr r0, _02158E10 // =ViHubAreaPreview__Func_2158E14
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
_02158E04:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158E10: .word ViHubAreaPreview__Func_2158E14
	arm_func_end ViHubAreaPreview__Func_2158D28

	arm_func_start ViHubAreaPreview__Func_2158E14
ViHubAreaPreview__Func_2158E14: // 0x02158E14
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _02158E4C
	add r0, r4, #0x100
	ldrh r1, [r0, #0x3a]
	cmp r1, #0x3f
	bls _02158E4C
	sub r1, r1, #1
	strh r1, [r0, #0x3a]
	ldrh r0, [r0, #0x3a]
	bl HubAudio__SetTrackVolume
_02158E4C:
	ldmib r4, {r0, r1}
	sub r0, r1, r0
	cmp r0, #0x1e
	blo _02158E88
	add r0, r4, #0x100
	ldrsh r1, [r0, #0x10]
	add r1, r1, #0x20
	strh r1, [r0, #0x10]
	ldrsh r1, [r0, #0x10]
	cmp r1, #0x1000
	movgt r1, #0x1000
	strgth r1, [r0, #0x10]
	add r0, r4, #0x100
	ldrsh r0, [r0, #0x10]
	bl ViMap__Func_215C284
_02158E88:
	mov r0, #0
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _02158F14
	add r0, r4, #0x100
	ldrsh r0, [r0, #0x10]
	cmp r0, #0x1000
	blt _02158F14
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _02158EC4
	mov r0, #0x3f
	bl HubAudio__SetTrackVolume
_02158EC4:
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _02158EE0
	bl ViMap__Func_215C408
	ldr r0, _02158F20 // =ViHubAreaPreview__Func_2158F28
	bl SetCurrentTaskMainEvent
	b _02158F14
_02158EE0:
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _02158F08
	mov r0, #0
	str r0, [r4, #0x10c]
	ldr r1, [r4, #4]
	ldr r0, _02158F24 // =ViHubAreaPreview__Func_2159084
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	b _02158F14
_02158F08:
	bl ViMap__Func_215C408
	ldr r0, _02158F20 // =ViHubAreaPreview__Func_2158F28
	bl SetCurrentTaskMainEvent
_02158F14:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158F20: .word ViHubAreaPreview__Func_2158F28
_02158F24: .word ViHubAreaPreview__Func_2159084
	arm_func_end ViHubAreaPreview__Func_2158E14

	arm_func_start ViHubAreaPreview__Func_2158F28
ViHubAreaPreview__Func_2158F28: // 0x02158F28
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViMap__Func_215C48C
	cmp r0, #0
	beq _02158F54
	bl ViMap__Func_215C4CC
	mov r1, #0
	ldr r0, _02158F60 // =ViHubAreaPreview__Func_2158F64
	str r1, [r4, #0x10c]
	bl SetCurrentTaskMainEvent
_02158F54:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158F60: .word ViHubAreaPreview__Func_2158F64
	arm_func_end ViHubAreaPreview__Func_2158F28

	arm_func_start ViHubAreaPreview__Func_2158F64
ViHubAreaPreview__Func_2158F64: // 0x02158F64
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r5, #0
	bl ViMap__Func_215C4F8
	cmp r0, #0
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _02158FB0
	bl ViMap__Func_215C4F8
	cmp r0, #0
	beq _02158FD4
	mov r0, #0x10
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	moveq r5, #1
	b _02158FD4
_02158FB0:
	bl ViMap__Func_215C4F8
	cmp r0, #0
	beq _02158FD4
	mov r0, #0
	mov r1, #0x10
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	moveq r5, #1
_02158FD4:
	cmp r5, #0
	beq _02159074
	ldr r0, [r4, #0x10c]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0x10c]
	beq _02159074
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _0215903C
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152994
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldrh r5, [r0, #0x3c]
	mov r0, r5
	bl ViMap__Func_215C524
	mov r0, r5
	bl ViMap__Func_215C638
	bl ViHubAreaPreview__Func_215AE84
	ldr r0, [r4, #0x1c]
	bl ViDock__Func_215DE40
	b _02159064
_0215903C:
	ldr r0, [r4, #0x24]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_21529A8
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__Func_2152960
	ldrh r0, [r0, #0x3c]
	bl ViMap__Func_215C76C
_02159064:
	ldr r1, [r4, #4]
	ldr r0, _02159080 // =ViHubAreaPreview__Func_2159104
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
_02159074:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02159080: .word ViHubAreaPreview__Func_2159104
	arm_func_end ViHubAreaPreview__Func_2158F64

	arm_func_start ViHubAreaPreview__Func_2159084
ViHubAreaPreview__Func_2159084: // 0x02159084
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	cmp r0, #0x3c
	blo _021590F4
	mov r0, #0
	mov r1, #0x10
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _021590F4
	ldr r0, [r4, #0x10c]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0x10c]
	beq _021590F4
	ldr r0, [r4, #0x20]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViMap__Func_215C58C
	bl ViMap__Func_215C6AC
	ldr r1, [r4, #4]
	ldr r0, _02159100 // =ViHubAreaPreview__Func_2159104
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
_021590F4:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159100: .word ViHubAreaPreview__Func_2159104
	arm_func_end ViHubAreaPreview__Func_2159084

	arm_func_start ViHubAreaPreview__Func_2159104
ViHubAreaPreview__Func_2159104: // 0x02159104
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x1c]
	ldr r2, [r4, #4]
	cmp r0, #5
	ldr r1, [r4, #8]
	movlt r6, #0xd2
	addlt r7, r6, #0xf0
	sub r5, r2, r1
	mov r0, #0
	movge r6, #0x78
	movge r7, #0x100
	cmp r5, #0x3c
	bls _02159198
	mov r1, #0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _02159198
	cmp r5, r6
	bls _02159198
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _0215916C
	bl ViDock__Func_215DF84
_0215916C:
	cmp r5, r7
	bls _02159198
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _02159188
	mov r0, #0xc
	bl FadeSysTrack
_02159188:
	ldr r1, [r4, #4]
	ldr r0, _021591A4 // =ViHubAreaPreview__Func_21591A8
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
_02159198:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021591A4: .word ViHubAreaPreview__Func_21591A8
	arm_func_end ViHubAreaPreview__Func_2159104

	arm_func_start ViHubAreaPreview__Func_21591A8
ViHubAreaPreview__Func_21591A8: // 0x021591A8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _021591C4
	bl ViDock__Func_215DF84
_021591C4:
	mvn r0, #0xf
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _021592D0
	bl ViMap__Func_215C7E0
	mov r0, #1
	bl ViMap__Func_215BB28
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _02159200
	mov r1, #1
	bl ViHubAreaPreview__Func_215B470
	b _02159220
_02159200:
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _0215921C
	mov r1, #1
	bl ViHubAreaPreview__Func_215B588
	bl ViHubAreaPreview__Func_215AE84
	b _02159220
_0215921C:
	bl ViHubAreaPreview__Func_215AE84
_02159220:
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	blt _02159244
	ldr r0, [r4, #0x20]
	cmp r0, #7
	beq _02159244
	ldr r0, [r4, #0x24]
	cmp r0, #8
	bge _02159270
_02159244:
	mov r0, #0
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	str r0, [r4, #0xc]
	bl ViMap__Func_215C82C
	ldr r0, [r4, #0x14]
	mov r1, #0
	bl ViMap__Func_215BCE4
	ldr r0, [r4, #0xc]
	bl ViDock__Func_215DBC8
	b _02159290
_02159270:
	bl ViMap__Func_215C82C
	ldr r0, [r4, #0x14]
	mov r1, #0
	bl ViMap__Func_215BCE4
	ldr r0, [r4, #0xc]
	bl ViDock__Func_215DBC8
	mov r0, #1
	bl ViDock__Func_215E578
_02159290:
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _021592AC
	bl HubAudio__StopSoundHandle
	mov r0, #0x7f
	bl HubAudio__SetTrackVolume
	b _021592C0
_021592AC:
	bl ReleaseSysSound
	bl DockHelpers__LoadVillageTrack
	bl HubAudio__PlayVillageTrack
	mov r0, #0x7f
	bl HubAudio__SetTrackVolume
_021592C0:
	ldr r1, [r4, #4]
	ldr r0, _021592DC // =ViHubAreaPreview__Func_21592E0
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
_021592D0:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r4, pc}
	.align 2, 0
_021592DC: .word ViHubAreaPreview__Func_21592E0
	arm_func_end ViHubAreaPreview__Func_21591A8

	arm_func_start ViHubAreaPreview__Func_21592E0
ViHubAreaPreview__Func_21592E0: // 0x021592E0
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r0
	mov r2, #1
	bl ViHubAreaPreview__Func_215AEE0
	cmp r0, #0
	bne _021593E4
	ldr r0, [r4, #0x1c]
	cmp r0, #5
	bge _02159354
	mov r5, #0
_02159314:
	mov r0, r5
	bl ViHubAreaPreview__Func_215B498
	cmp r0, #0
	beq _02159330
	add r5, r5, #1
	cmp r5, #5
	blt _02159314
_02159330:
	ldr r0, [r4, #0x28]
	bl ViDock__Func_215E104
	bl ViDock__Func_215E178
	mov r1, r5
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _021593F0 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	b _021593CC
_02159354:
	ldr r0, [r4, #0x20]
	cmp r0, #0x16
	bge _02159388
	ldr r0, [r4, #0x28]
	bl ViDock__Func_215E104
	bl ViDock__Func_215E178
	ldr r1, [r4, #0x20]
	mov r0, #0
	add r1, r1, #8
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _021593F0 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
	b _021593CC
_02159388:
	ldr r0, [r4, #0x24]
	cmp r0, #8
	bge _021593CC
	add r0, sp, #2
	add r1, sp, #0
	bl SaveGame__GetNextShipUpgrade
	ldr r0, [r4, #0x28]
	bl ViDock__Func_215E104
	bl ViDock__Func_215E178
	ldrh r2, [sp]
	ldrh r1, [sp, #2]
	mov r0, #0
	add r2, r2, #0x1d
	add r1, r2, r1, lsl #1
	bl _ZN15CViDockNpcGroup12Func_21686F8Ell
	ldr r0, _021593F0 // =HubControl__Main_2158160
	bl SetCurrentTaskMainEvent
_021593CC:
	mov r0, #6
	str r0, [r4, #0x1c]
	mov r0, #0x17
	str r0, [r4, #0x20]
	mov r0, #9
	str r0, [r4, #0x24]
_021593E4:
	mov r0, r4
	bl ViHubAreaPreview__Func_2159740
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021593F0: .word HubControl__Main_2158160
	arm_func_end ViHubAreaPreview__Func_21592E0

	arm_func_start ViHubAreaPreview__LoadArchives
ViHubAreaPreview__LoadArchives: // 0x021593F4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, _0215964C // =aNarcViActLz7Na
	mov r1, #0
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #0x34]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02159444
_02159420: // jump table
	b _02159438 // case 0
	b _02159438 // case 1
	b _02159438 // case 2
	b _02159438 // case 3
	b _02159438 // case 4
	b _02159438 // case 5
_02159438:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02159448
_02159444:
	mov r0, #1
_02159448:
	mov r1, r0, lsl #0x10
	ldr r0, _02159650 // =aBbViActLocBb
	mov r1, r1, lsr #0x10
	mvn r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x38]
	mov r1, r0
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _02159654 // =aNarcViBgLz7Nar_ovl05
	mov r1, #0
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #0x3c]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021594CC
_021594A8: // jump table
	b _021594C0 // case 0
	b _021594C0 // case 1
	b _021594C0 // case 2
	b _021594C0 // case 3
	b _021594C0 // case 4
	b _021594C0 // case 5
_021594C0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _021594D0
_021594CC:
	mov r0, #1
_021594D0:
	mov r1, r0, lsl #0x10
	ldr r0, _02159658 // =aBbViBgUpBb
	mov r1, r1, lsr #0x10
	mvn r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x40]
	mov r1, r0
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02159544
_02159520: // jump table
	b _02159538 // case 0
	b _02159538 // case 1
	b _02159538 // case 2
	b _02159538 // case 3
	b _02159538 // case 4
	b _02159538 // case 5
_02159538:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02159548
_02159544:
	mov r0, #1
_02159548:
	mov r1, r0, lsl #0x10
	ldr r0, _0215965C // =aBbViMsgBb
	mov r1, r1, lsr #0x10
	mvn r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x44]
	mov r1, r0
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _02159660 // =aNarcViMsgCtrlL
	mvn r1, #0
	bl FSRequestFileSync
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x48]
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _02159664 // =aFntFontAllFnt_3_ovl05
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0x4c]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02159600
_021595DC: // jump table
	b _021595F4 // case 0
	b _021595F4 // case 1
	b _021595F4 // case 2
	b _021595F4 // case 3
	b _021595F4 // case 4
	b _021595F4 // case 5
_021595F4:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02159604
_02159600:
	mov r0, #1
_02159604:
	mov r1, r0, lsl #0x10
	ldr r0, _02159668 // =aBbTkdmNameBb
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #0x50]
	add r0, r4, #0x54
	bl FontWindow__Init
	ldr r1, [r4, #0x4c]
	add r0, r4, #0x54
	mov r2, #1
	bl FontWindow__LoadFromMemory
	add r0, r4, #0x54
	bl FontWindow__Load_mw_frame
	add r0, r4, #0x54
	mov r1, #1
	bl FontWindow__SetDMA
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215964C: .word aNarcViActLz7Na
_02159650: .word aBbViActLocBb
_02159654: .word aNarcViBgLz7Nar_ovl05
_02159658: .word aBbViBgUpBb
_0215965C: .word aBbViMsgBb
_02159660: .word aNarcViMsgCtrlL
_02159664: .word aFntFontAllFnt_3_ovl05
_02159668: .word aBbTkdmNameBb
	arm_func_end ViHubAreaPreview__LoadArchives

	arm_func_start ViHubAreaPreview__Func_215966C
ViHubAreaPreview__Func_215966C: // 0x0215966C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _0215968C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x44]
_0215968C:
	ldr r0, [r4, #0x48]
	cmp r0, #0
	beq _021596A4
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x48]
_021596A4:
	add r0, r4, #0x54
	bl FontWindow__Release
	ldr r0, [r4, #0x50]
	cmp r0, #0
	beq _021596C4
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x50]
_021596C4:
	ldr r0, [r4, #0x4c]
	cmp r0, #0
	beq _021596DC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x4c]
_021596DC:
	ldr r0, [r4, #0x40]
	cmp r0, #0
	beq _021596F4
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x40]
_021596F4:
	ldr r0, [r4, #0x3c]
	cmp r0, #0
	beq _0215970C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x3c]
_0215970C:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _02159724
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x38]
_02159724:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x34]
	ldmia sp!, {r4, pc}
	arm_func_end ViHubAreaPreview__Func_215966C

	arm_func_start ViHubAreaPreview__Func_2159740
ViHubAreaPreview__Func_2159740: // 0x02159740
	mov r1, #0
	str r1, [r0, #0x2c]
	ldr r1, [r0, #4]
	add r1, r1, #1
	str r1, [r0, #4]
	bx lr
	arm_func_end ViHubAreaPreview__Func_2159740

	arm_func_start ViHubAreaPreview__Func_2159758
ViHubAreaPreview__Func_2159758: // 0x02159758
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	bl TalkHelpers__Func_2152DA0
	cmp r4, #0
	beq _02159788
	mov r0, #0
	bl TalkHelpers__Func_2152DD4
	ldr r0, [r5, #0x14]
	and r0, r0, #0xff
	bl TalkHelpers__Func_2152DF4
	ldmia sp!, {r3, r4, r5, pc}
_02159788:
	mov r0, #1
	bl TalkHelpers__Func_2152DD4
	ldr r0, [r5, #0xc]
	and r0, r0, #0xff
	bl TalkHelpers__Func_2152DF4
	bl ViDock__Func_215E4DC
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViHubAreaPreview__Func_2159758

	arm_func_start ViHubAreaPreview__Func_21597A4
ViHubAreaPreview__Func_21597A4: // 0x021597A4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl GetCurrentTaskWork_
	mov r4, r0
	bl TalkHelpers__Func_2152DA0
	mov r0, #1
	bl TalkHelpers__Func_2152DD4
	cmp r5, #7
	bge _021597D8
	and r0, r5, #0xff
	bl TalkHelpers__Func_2152DF4
	b _021597E4
_021597D8:
	ldr r0, [r4, #0xc]
	and r0, r0, #0xff
	bl TalkHelpers__Func_2152DF4
_021597E4:
	mov r0, #0
	str r0, [r4, #0x120]
	add r0, r4, #0x100
	strh r6, [r0, #0x38]
	ldr r1, [r4, #0]
	ldr r0, _0215980C // =HubControl__Main_2158AB4
	bic r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215980C: .word HubControl__Main_2158AB4
	arm_func_end ViHubAreaPreview__Func_21597A4

	arm_func_start ViHubAreaPreview__Func_2159810
ViHubAreaPreview__Func_2159810: // 0x02159810
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl TalkHelpers__Func_2152DA0
	mov r0, #0
	ldr r1, _0215984C // =0x0000FFFE
	str r0, [r4, #0x120]
	add r0, r4, #0x100
	strh r1, [r0, #0x38]
	ldr r1, [r4, #0]
	ldr r0, _02159850 // =HubControl__Main_2158AB4
	bic r1, r1, #0x10000
	str r1, [r4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215984C: .word 0x0000FFFE
_02159850: .word HubControl__Main_2158AB4
	arm_func_end ViHubAreaPreview__Func_2159810

	arm_func_start ViHubAreaPreview__Func_2159854
ViHubAreaPreview__Func_2159854: // 0x02159854
	cmp r0, #0xe
	addls pc, pc, r0, lsl #2
	b _021598AC
_02159860: // jump table
	b _0215989C // case 0
	b _0215989C // case 1
	b _021598A4 // case 2
	b _0215989C // case 3
	b _021598A4 // case 4
	b _021598A4 // case 5
	b _021598A4 // case 6
	b _0215989C // case 7
	b _0215989C // case 8
	b _0215989C // case 9
	b _0215989C // case 10
	b _0215989C // case 11
	b _021598A4 // case 12
	b _0215989C // case 13
	b _0215989C // case 14
_0215989C:
	mov r0, #1
	bx lr
_021598A4:
	mov r0, #0
	bx lr
_021598AC:
	mov r0, #1
	bx lr
	arm_func_end ViHubAreaPreview__Func_2159854

	arm_func_start ViHubAreaPreview__Func_21598B4
ViHubAreaPreview__Func_21598B4: // 0x021598B4
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0x104]
	bl ViHubAreaPreview__Func_2159854
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #8
	bl FadeSysTrack
	ldmia sp!, {r3, pc}
	arm_func_end ViHubAreaPreview__Func_21598B4

	arm_func_start ViHubAreaPreview__ClearAnimators
ViHubAreaPreview__ClearAnimators: // 0x021598D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r3, r4, #0x100
	mov r0, #9
	strh r0, [r3, #0x3c]
	mov r0, #0
	strh r0, [r3, #0x3e]
	strh r0, [r3, #0x40]
	add r1, r4, #0x144
	mov r2, #0x1f4
	strh r0, [r3, #0x42]
	bl MIi_CpuClear16
	add r1, r4, #0x338
	mov r0, #0
	mov r2, #0x64
	bl MIi_CpuClear16
	add r1, r4, #0x39c
	mov r0, #0
	mov r2, #0xc8
	bl MIi_CpuClear16
	add r0, r4, #0x64
	add r1, r0, #0x400
	mov r0, #0
	mov r2, #0x12c
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}
	arm_func_end ViHubAreaPreview__ClearAnimators

	arm_func_start ViHubAreaPreview__Func_215993C
ViHubAreaPreview__Func_215993C: // 0x0215993C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	str r0, [sp, #0x30]
	bl ViHubAreaPreview__Func_215ABF8
	mov r0, #0xd
	bl HubControl__GetFileFrom_ViAct
	mov r6, r0
	mov r0, #1
	bl HubControl__GetFileFrom_ViActLoc
	mov r7, r0
	ldr r0, [sp, #0x30]
	mov r1, #0
	add r4, r0, #0x338
	mov r0, r6
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r1, _02159C6C // =0x05000200
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r0, #0xf
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, r6
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #0
	strh r0, [r4, #0x50]
	mov r0, r6
	bl Sprite__GetSpriteSize1
	mov r8, #0
	mov r10, r0
	ldr r0, [sp, #0x30]
	ldr r4, _02159C6C // =0x05000200
	add r9, r0, #0x144
	mov r11, r8
	mov r5, r8
_021599E8:
	mov r0, r11
	mov r1, r10
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	str r4, [sp, #0x10]
	mov r0, r9
	str r5, [sp, #0x14]
	and r1, r8, #0xff
	str r1, [sp, #0x18]
	mov r1, r6
	mov r2, r5
	mov r3, r5
	bl AnimatorSprite__Init
	add r8, r8, #1
	strh r8, [r9, #0x50]
	cmp r8, #5
	add r9, r9, #0x64
	blt _021599E8
	mov r0, r6
	bl Sprite__GetSpriteSize1
	mov r10, #0
	mov r9, r0
	ldr r0, [sp, #0x30]
	ldr r4, _02159C6C // =0x05000200
	add r8, r0, #0x39c
	mov r11, r10
	mov r5, r10
_02159A60:
	mov r0, r11
	mov r1, r9
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	add r0, r10, #0xc
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	str r4, [sp, #0x10]
	str r5, [sp, #0x14]
	str r5, [sp, #0x18]
	mov r0, r8
	mov r1, r6
	mov r3, r5
	bl AnimatorSprite__Init
	add r0, r10, #6
	strh r0, [r8, #0x50]
	add r10, r10, #1
	cmp r10, #2
	add r8, r8, #0x64
	blt _02159A60
	mov r0, r7
	bl Sprite__GetSpriteSize1
	mov r10, #0
	ldr r1, [sp, #0x30]
	ldr r5, _02159C6C // =0x05000200
	add r1, r1, #0x64
	mov r9, r0
	add r8, r1, #0x400
	mov r11, r10
	mov r6, r10
	mov r4, #8
_02159AE8:
	mov r0, r11
	mov r1, r9
	bl VRAMSystem__AllocSpriteVram
	str r6, [sp]
	str r6, [sp, #4]
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	mov r0, r10, lsl #0x10
	mov r2, r0, lsr #0x10
	str r6, [sp, #0x14]
	str r6, [sp, #0x18]
	mov r0, r8
	mov r1, r7
	mov r3, r6
	bl AnimatorSprite__Init
	add r10, r10, #1
	strh r4, [r8, #0x50]
	cmp r10, #3
	add r8, r8, #0x64
	blt _02159AE8
	mov r0, #4
	bl HubControl__GetFileFrom_ViBG
	mov r3, #2
	mov r1, r0
	mov r2, #0
	str r3, [sp]
	mov r4, #0x20
	str r4, [sp, #4]
	mov r4, #0x18
	add r0, sp, #0x34
	mov r3, r2
	str r4, [sp, #8]
	bl InitBackground
	add r0, sp, #0x34
	bl DrawBackground
	mov r0, #1
	bl HubControl__GetFileFrom_ViBG
	mov r1, r0
	mov r0, #1
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, r4
	mov r2, #0
	str r0, [sp, #8]
	add r0, sp, #0x34
	mov r3, r2
	bl InitBackground
	add r0, sp, #0x34
	bl DrawBackground
	mov r0, #2
	bl HubControl__GetFileFrom_ViBG
	mov r1, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, r4
	mov r2, #0
	str r0, [sp, #8]
	add r0, sp, #0x34
	mov r3, r2
	bl InitBackground
	add r0, sp, #0x34
	bl DrawBackground
	ldr r0, [sp, #0x30]
	mov r1, #0
	ldr r0, [r0, #0x40]
	bl FileUnknown__GetAOUFile
	mov r3, #2
	mov r1, r0
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r0, #0x5000000
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	mov r0, #0x6000000
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r0, #4
	str r0, [sp, #0x1c]
	mov r0, #5
	str r0, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r0, #0x14
	str r0, [sp, #0x28]
	str r3, [sp, #0x2c]
	add r0, sp, #0x34
	mov r3, r2
	bl InitBackgroundEx
	add r0, sp, #0x34
	bl DrawBackground
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02159C6C: .word 0x05000200
	arm_func_end ViHubAreaPreview__Func_215993C

	arm_func_start ViHubAreaPreview__ReleaseAnimators
ViHubAreaPreview__ReleaseAnimators: // 0x02159C70
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x64
	add r6, r0, #0x400
	mov r5, #0
_02159C84:
	mov r0, r6
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x64
	blt _02159C84
	add r5, r4, #0x39c
	mov r6, #0
_02159CA4:
	mov r0, r5
	bl AnimatorSprite__Release
	add r6, r6, #1
	cmp r6, #2
	add r5, r5, #0x64
	blt _02159CA4
	add r5, r4, #0x144
	mov r6, #0
_02159CC4:
	mov r0, r5
	bl AnimatorSprite__Release
	add r6, r6, #1
	cmp r6, #5
	add r5, r5, #0x64
	blt _02159CC4
	add r0, r4, #0x338
	bl AnimatorSprite__Release
	bl ViHubAreaPreview__Func_215AD34
	mov r0, r4
	bl ViHubAreaPreview__ClearAnimators
	ldr r1, _02159D04 // =renderCoreGFXControlA+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02159D04: .word renderCoreGFXControlA+0x00000020
	arm_func_end ViHubAreaPreview__ReleaseAnimators

	arm_func_start ViHubAreaPreview__Func_2159D08
ViHubAreaPreview__Func_2159D08: // 0x02159D08
	ldr ip, _02159D10 // =ViHubAreaPreview__ReleaseAnimators
	bx ip
	.align 2, 0
_02159D10: .word ViHubAreaPreview__ReleaseAnimators
	arm_func_end ViHubAreaPreview__Func_2159D08

	arm_func_start ViHubAreaPreview__Func_2159D14
ViHubAreaPreview__Func_2159D14: // 0x02159D14
	add r0, r0, #0x100
	ldrsh r1, [r0, #0x42]
	cmp r1, #0x10
	bge _02159D44
	add r1, r1, #2
	strh r1, [r0, #0x42]
	ldrsh r1, [r0, #0x42]
	cmp r1, #0x10
	movgt r1, #0x10
	strgth r1, [r0, #0x42]
	mov r0, #0
	bx lr
_02159D44:
	mov r0, #1
	bx lr
	arm_func_end ViHubAreaPreview__Func_2159D14

	arm_func_start ViHubAreaPreview__Func_2159D4C
ViHubAreaPreview__Func_2159D4C: // 0x02159D4C
	add r0, r0, #0x100
	ldrsh r1, [r0, #0x42]
	cmp r1, #0
	ble _02159D7C
	sub r1, r1, #2
	strh r1, [r0, #0x42]
	ldrsh r1, [r0, #0x42]
	cmp r1, #0
	movlt r1, #0
	strlth r1, [r0, #0x42]
	mov r0, #0
	bx lr
_02159D7C:
	mov r0, #1
	bx lr
	arm_func_end ViHubAreaPreview__Func_2159D4C

	arm_func_start ViHubAreaPreview__Func_2159D84
ViHubAreaPreview__Func_2159D84: // 0x02159D84
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x98
	ldr r3, _0215A004 // =ViHubAreaPreview__npcAnimIDList
	add r5, sp, #0x38
	mov r10, r0
	mov r9, r1
	mov r2, #6
_02159DA0:
	ldrb r1, [r3, #0]
	ldrb r0, [r3, #1]
	add r3, r3, #2
	strb r1, [r5]
	strb r0, [r5, #1]
	add r5, r5, #2
	subs r2, r2, #1
	bne _02159DA0
	ldrb r0, [r3, #0]
	ldr r4, _0215A008 // =ViHubAreaPreview__backgroundFileList
	add r3, sp, #0x30
	strb r0, [r5]
	mov r2, #4
_02159DD4:
	ldrb r1, [r4, #0]
	ldrb r0, [r4, #1]
	add r4, r4, #2
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	bne _02159DD4
	add r3, r10, #0x100
	ldrh r0, [r3, #0x3c]
	cmp r9, r0
	addeq sp, sp, #0x98
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r1, sp, #0x46
	mov r0, #0xff
	mov r2, #0xa
	strh r9, [r3, #0x3c]
	bl MIi_CpuClear16
	cmp r9, #8
	add r4, r10, #0x100
	mov r7, #0
	addge sp, sp, #0x98
	strh r7, [r4, #0x3e]
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _0215A00C // =ViHubAreaPreview__npcCount
	mov r1, r9, lsl #1
	ldrh r6, [r0, r1]
	ldr r0, _0215A010 // =ViHubAreaPreview__npcStartID
	cmp r6, #0
	ldrh r8, [r0, r1]
	ble _02159EC8
	add r0, r10, #0x3e
	add r5, r0, #0x100
	add r11, sp, #0x38
_02159E5C:
	mov r0, r8
	bl ViHubAreaPreview__Func_215B850
	cmp r0, #0
	beq _02159EB0
	mov r0, r8
	bl ViHubAreaPreview__Func_215B858
	cmp r0, #0
	beq _02159EB0
	mov r0, r8
	bl DockHelpers__GetNpcConfig
	ldrh r0, [r0, #0]
	ldrb r2, [r11, r0]
	cmp r2, #0xff
	beq _02159EB0
	ldrh r0, [r4, #0x3e]
	mov r1, r0, lsl #1
	add r0, sp, #0x46
	strh r2, [r0, r1]
	ldrh r0, [r5, #0]
	add r0, r0, #1
	strh r0, [r5]
_02159EB0:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	add r7, r7, #1
	cmp r7, r6
	mov r8, r0, lsr #0x10
	blt _02159E5C
_02159EC8:
	add r0, r10, #0x100
	ldrh r3, [r0, #0x3e]
	mov r6, #0
	sub r1, r3, #1
	cmp r1, #0
	ble _02159F1C
	mov r2, #1
	add r4, sp, #0x46
_02159EE8:
	mov r5, r6, lsl #1
	ldrh r1, [r4, r5]
	cmp r1, #1
	bne _02159F08
	add r3, r4, r5
	ldrh r1, [r3, #2]
	strh r1, [r4, r5]
	strh r2, [r3, #2]
_02159F08:
	ldrh r3, [r0, #0x3e]
	add r6, r6, #1
	sub r1, r3, #1
	cmp r6, r1
	blt _02159EE8
_02159F1C:
	cmp r3, #0
	mov r5, #0
	ble _02159F58
	add r4, r10, #0x144
	add r6, r10, #0x100
	add r7, sp, #0x46
_02159F34:
	mov r0, r5, lsl #1
	ldrh r1, [r7, r0]
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	ldrh r0, [r6, #0x3e]
	add r5, r5, #1
	add r4, r4, #0x64
	cmp r5, r0
	blt _02159F34
_02159F58:
	cmp r9, #7
	mov r1, #0x4000000
	bne _02159F78
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1e00
	str r0, [r1]
	b _02159F88
_02159F78:
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1500
	str r0, [r1]
_02159F88:
	add r1, sp, #0x30
	ldrb r1, [r1, r9]
	ldr r0, [r10, #0x40]
	bl FileUnknown__GetAOUFile
	mov r4, #2
	mov r2, #0
	str r4, [sp]
	str r2, [sp, #4]
	mov r1, #0x5000000
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	mov r1, #0x6000000
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, r0
	str r2, [sp, #0x18]
	mov r0, #4
	str r0, [sp, #0x1c]
	mov r0, #6
	str r0, [sp, #0x20]
	str r4, [sp, #0x24]
	mov r0, #0x14
	str r0, [sp, #0x28]
	add r0, sp, #0x50
	mov r3, r2
	str r4, [sp, #0x2c]
	bl InitBackgroundEx
	add r0, sp, #0x50
	bl DrawBackground
	add sp, sp, #0x98
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215A004: .word ViHubAreaPreview__npcAnimIDList
_0215A008: .word ViHubAreaPreview__backgroundFileList
_0215A00C: .word ViHubAreaPreview__npcCount
_0215A010: .word ViHubAreaPreview__npcStartID
	arm_func_end ViHubAreaPreview__Func_2159D84

	arm_func_start ViHubAreaPreview__Func_215A014
ViHubAreaPreview__Func_215A014: // 0x0215A014
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r1, _0215A2D8 // =renderCoreGFXControlA+0x00000020
	mov r10, r0
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	add r0, r10, #0x100
	ldrsh r0, [r0, #0x42]
	cmp r0, #0
	beq _0215A094
	ldr r1, _0215A2DC // =renderCoreGFXControlA
	mov r0, r0, lsl #0x10
	ldrh r2, [r1, #0x24]
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	bic r2, r2, #0x1f
	orr r0, r2, r0
	strh r0, [r1, #0x24]
	ldrh r3, [r1, #0x20]
	mov r2, #0
	mov r0, #0x5000000
	bic r3, r3, #0xc0
	orr r3, r3, #0xc0
	strh r3, [r1, #0x20]
	ldrh r3, [r1, #0x20]
	bic r3, r3, #1
	orr r3, r3, #1
	strh r3, [r1, #0x20]
	ldrh r3, [r1, #0x20]
	orr r3, r3, #0xa
	strh r3, [r1, #0x20]
	strh r2, [r0]
_0215A094:
	add r0, r10, #0x100
	ldrsh r0, [r0, #0x42]
	mov r1, #0
	add r5, r10, #0x338
	add r0, r0, r0, lsl #1
	mov r3, r0, lsl #0x10
	mov r0, r5
	mov r2, r1
	mov r8, r3, asr #0x10
	bl AnimatorSprite__ProcessAnimation
	add r0, r10, #0x100
	ldrh r1, [r0, #0x3e]
	str r0, [sp]
	mov r0, #0x28
	mul r0, r1, r0
	rsb r0, r0, #0x100
	mov r0, r0, lsl #0x10
	mov r6, #0
	cmp r1, #0
	mov r7, r0, asr #0x10
	ble _0215A194
	add r1, r8, #0x98
	add r0, r10, #0x12c
	mov r1, r1, lsl #0x10
	add r9, r10, #0x144
	add r4, r0, #0x400
	mov r11, r1, asr #0x10
_0215A100:
	mov r1, #0
	strh r7, [r9, #8]
	mov r0, r9
	mov r2, r1
	strh r11, [r9, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r9
	bl AnimatorSprite__DrawFrame
	ldrsh r1, [r9, #8]
	mov r0, r5
	strh r1, [r5, #8]
	ldrsh r1, [r9, #0xa]
	strh r1, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	cmp r8, #0
	ldreqh r0, [r9, #0xc]
	cmpeq r0, #1
	bne _0215A170
	ldrsh r2, [r9, #8]
	mov r1, #0
	mov r0, r4
	strh r2, [r4, #8]
	ldrsh r3, [r9, #0xa]
	mov r2, r1
	strh r3, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_0215A170:
	ldr r0, [sp]
	add r6, r6, #1
	ldrh r1, [r0, #0x3e]
	add r0, r7, #0x28
	mov r0, r0, lsl #0x10
	cmp r6, r1
	mov r7, r0, asr #0x10
	add r9, r9, #0x64
	blt _0215A100
_0215A194:
	add r0, r10, #0x100
	ldrh r0, [r0, #0x3c]
	cmp r0, #0
	bne _0215A2A4
	add r4, r10, #0x400
	mov r3, #0xd8
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #8]
	rsb r6, r8, #4
	strh r6, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldrsh r1, [r4, #8]
	mov r0, r5
	strh r1, [r5, #8]
	ldrsh r1, [r4, #0xa]
	strh r1, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	cmp r8, #0
	bne _0215A220
	ldrsh r1, [r4, #8]
	add r0, r10, #0xc8
	add r7, r0, #0x400
	strh r1, [r7, #8]
	ldrsh r3, [r4, #0xa]
	mov r1, #0
	mov r0, r7
	mov r2, r1
	strh r3, [r7, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	bl AnimatorSprite__DrawFrame
_0215A220:
	bl SaveGame__GetGameProgress
	cmp r0, #3
	blt _0215A2A4
	add r4, r10, #0x39c
	mov r0, #0xb0
	mov r1, #0
	strh r0, [r4, #8]
	mov r0, r4
	mov r2, r1
	strh r6, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldrsh r1, [r4, #8]
	mov r0, r5
	strh r1, [r5, #8]
	ldrsh r1, [r4, #0xa]
	strh r1, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	cmp r8, #0
	bne _0215A2A4
	ldrsh r1, [r4, #8]
	add r0, r10, #0x64
	add r5, r0, #0x400
	strh r1, [r5, #8]
	ldrsh r3, [r4, #0xa]
	mov r1, #0
	mov r0, r5
	mov r2, r1
	strh r3, [r5, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
_0215A2A4:
	add r0, r10, #0x100
	ldrh r1, [r0, #0x3c]
	cmp r1, #7
	bne _0215A2C4
	ldrh r1, [r0, #0x40]
	ldr r0, _0215A2DC // =renderCoreGFXControlA
	mov r1, r1, asr #5
	strh r1, [r0, #0xc]
_0215A2C4:
	add r0, r10, #0x100
	ldrh r1, [r0, #0x40]
	add r1, r1, #1
	strh r1, [r0, #0x40]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215A2D8: .word renderCoreGFXControlA+0x00000020
_0215A2DC: .word renderCoreGFXControlA
	arm_func_end ViHubAreaPreview__Func_215A014

	arm_func_start ViHubAreaPreview__Func_215A2E0
ViHubAreaPreview__Func_215A2E0: // 0x0215A2E0
	stmdb sp!, {r3, lr}
	cmp r1, #0
	beq _0215A388
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0215A2F8: // jump table
	ldmia sp!, {r3, pc} // case 0
	ldmia sp!, {r3, pc} // case 1
	b _0215A310 // case 2
	b _0215A340 // case 3
	b _0215A358 // case 4
	b _0215A370 // case 5
_0215A310:
	bl SaveGame__GetGameProgress
	cmp r0, #3
	bge _0215A328
	mov r0, #0
	bl MultibootManager__Func_2063C60
	ldmia sp!, {r3, pc}
_0215A328:
	mov r0, #1
	bl MultibootManager__Func_2063C60
	ldr r0, _0215A3E8 // =gameState
	mov r1, #1
	strb r1, [r0, #0xdc]
	ldmia sp!, {r3, pc}
_0215A340:
	mov r0, #2
	bl MultibootManager__Func_2063C60
	ldr r0, _0215A3E8 // =gameState
	mov r1, #1
	strb r1, [r0, #0xdc]
	ldmia sp!, {r3, pc}
_0215A358:
	mov r0, #3
	bl MultibootManager__Func_2063C60
	ldr r0, _0215A3E8 // =gameState
	mov r1, #1
	strb r1, [r0, #0xdc]
	ldmia sp!, {r3, pc}
_0215A370:
	mov r0, #4
	bl MultibootManager__Func_2063C60
	ldr r0, _0215A3E8 // =gameState
	mov r1, #1
	strb r1, [r0, #0xdc]
	ldmia sp!, {r3, pc}
_0215A388:
	ldr r1, _0215A3E8 // =gameState
	mov r2, #0
	str r2, [r1, #0x70]
	str r2, [r1, #0x74]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0215A3A4: // jump table
	ldmia sp!, {r3, pc} // case 0
	ldmia sp!, {r3, pc} // case 1
	b _0215A3BC // case 2
	b _0215A3C4 // case 3
	b _0215A3D0 // case 4
	b _0215A3DC // case 5
_0215A3BC:
	str r2, [r1, #0xa0]
	ldmia sp!, {r3, pc}
_0215A3C4:
	mov r0, #1
	str r0, [r1, #0xa0]
	ldmia sp!, {r3, pc}
_0215A3D0:
	mov r0, #2
	str r0, [r1, #0xa0]
	ldmia sp!, {r3, pc}
_0215A3DC:
	mov r0, #3
	str r0, [r1, #0xa0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215A3E8: .word gameState
	arm_func_end ViHubAreaPreview__Func_215A2E0

	arm_func_start ViHubAreaPreview__Func_215A3EC
ViHubAreaPreview__Func_215A3EC: // 0x0215A3EC
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	add r0, r0, #1
	bl SaveGame__SetGameProgress
	ldmia sp!, {r3, pc}
	arm_func_end ViHubAreaPreview__Func_215A3EC

	arm_func_start ViHubAreaPreview__Func_215A400
ViHubAreaPreview__Func_215A400: // 0x0215A400
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r4, r0
	cmp r4, #0xf
	movge r4, #0
	cmp r4, #0xe
	addls pc, pc, r4, lsl #2
	b _0215A4B8
_0215A420: // jump table
	b _0215A45C // case 0
	b _0215A4B8 // case 1
	b _0215A468 // case 2
	b _0215A4B8 // case 3
	b _0215A4B8 // case 4
	b _0215A4B8 // case 5
	b _0215A4B8 // case 6
	b _0215A478 // case 7
	b _0215A488 // case 8
	b _0215A498 // case 9
	b _0215A4A4 // case 10
	b _0215A4B8 // case 11
	b _0215A4AC // case 12
	b _0215A4B8 // case 13
	b _0215A4B8 // case 14
_0215A45C:
	mov r0, r1
	bl SaveGame__Func_205B9F0
	b _0215A4B8
_0215A468:
	ldr r0, _0215A514 // =gameState+0x00000100
	mov r1, #0
	strh r1, [r0, #0x54]
	b _0215A4B8
_0215A478:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViHubAreaPreview__Func_215B8FC
	b _0215A4B8
_0215A488:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViHubAreaPreview__Func_215B92C
	b _0215A4B8
_0215A498:
	mov r0, r1
	bl MissionHelpers__StartMission
	b _0215A4B8
_0215A4A4:
	bl ViHubAreaPreview__Func_215B958
	b _0215A4B8
_0215A4AC:
	ldr r0, _0215A518 // =gameState
	mov r1, #0
	str r1, [r0, #0xc4]
_0215A4B8:
	bl HubControl__Func_21572B8
	ldr ip, _0215A51C // =HubControl__EventList
	add r3, sp, #0
	mov r2, #7
_0215A4C8:
	ldrh r1, [ip]
	ldrh r0, [ip, #2]
	add ip, ip, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0215A4C8
	ldrh r2, [ip]
	add r0, sp, #0
	mov r1, r4, lsl #1
	strh r2, [r3]
	ldrsh r0, [r0, r1]
	cmp r0, #0
	blt _0215A508
	bl RequestNewSysEventChange
_0215A508:
	bl NextSysEvent
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A514: .word gameState+0x00000100
_0215A518: .word gameState
_0215A51C: .word HubControl__EventList
	arm_func_end ViHubAreaPreview__Func_215A400

	arm_func_start ViHubAreaPreview__Func_215A520
ViHubAreaPreview__Func_215A520: // 0x0215A520
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r1, _0215A840 // =renderCoreGFXControlA
	ldrsh r0, [r1, #0x58]
	cmp r0, #0
	ldrgt r0, _0215A844 // =renderCoreGFXControlB
	movgt r2, #0x10
	mvnle r2, #0xf
	strh r2, [r1, #0x58]
	ldrle r0, _0215A844 // =renderCoreGFXControlB
	ldr r1, _0215A840 // =renderCoreGFXControlA
	strh r2, [r0, #0x58]
	ldrsh r1, [r1, #0x58]
	ldr r0, _0215A848 // =0x0400006C
	bl GXx_SetMasterBrightness_
	ldr r1, _0215A844 // =renderCoreGFXControlB
	ldr r0, _0215A84C // =0x0400106C
	ldrsh r1, [r1, #0x58]
	bl GXx_SetMasterBrightness_
	ldr r2, _0215A850 // =0x04000304
	ldr r0, _0215A854 // =0xFFFFFDF1
	ldrh r1, [r2, #0]
	and r0, r1, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [r2]
	ldrh r0, [r2, #0]
	orr r0, r0, #0xc
	strh r0, [r2]
	bl ViHubAreaPreview__Func_215B3D0
	mov r3, #0x4000000
	ldr r1, [r3, #0]
	mov r0, #1
	bic r1, r1, #0x38000000
	str r1, [r3]
	ldr r2, [r3, #0]
	mov r1, #0
	bic r2, r2, #0x7000000
	str r2, [r3]
	mov r2, r0
	bl GX_SetGraphicsMode
	ldr r1, _0215A858 // =renderCoreSwapBuffer
	mov r0, #0
	mov r2, #1
	stmib r1, {r0, r2}
	ldr ip, _0215A85C // =0x04000060
	ldr r2, _0215A860 // =0xFFFFCFFD
	ldrh r3, [ip]
	ldr lr, _0215A864 // =0x0000CFFB
	mov r1, r0
	and r2, r3, r2
	strh r2, [ip]
	ldrh r4, [ip]
	mov r2, r0
	mov r3, r0
	bic r4, r4, #0x3000
	orr r4, r4, #0x10
	strh r4, [ip]
	ldrh r4, [ip]
	and r4, r4, lr
	strh r4, [ip]
	ldrh lr, [ip]
	bic lr, lr, #0x3000
	orr lr, lr, #8
	strh lr, [ip]
	ldrh lr, [ip]
	bic lr, lr, #0x3000
	orr lr, lr, #0x20
	strh lr, [ip]
	bl G3X_SetFog
	mov r0, #0
	ldr r2, _0215A868 // =0x00007FFF
	mov r1, r0
	mov r3, r0
	str r0, [sp]
	bl G3X_SetClearColor
	ldr r0, _0215A858 // =renderCoreSwapBuffer
	ldr r1, [r0, #8]
	ldr r0, [r0, #4]
	ldr r2, _0215A86C // =0x04000540
	orr r3, r0, r1, lsl #1
	ldr r1, _0215A870 // =0x0400000A
	ldr r0, _0215A874 // =0xBFFF0000
	str r3, [r2]
	str r0, [r2, #0x40]
	ldrh r3, [r1, #0]
	ldr r2, _0215A840 // =renderCoreGFXControlA
	mov r0, #0
	and r3, r3, #0x43
	orr r3, r3, #8
	orr r3, r3, #0x1000
	strh r3, [r1]
	strh r0, [r2]
	strh r0, [r2, #2]
	strh r0, [r2, #4]
	strh r0, [r2, #6]
	strh r0, [r2, #8]
	strh r0, [r2, #0xa]
	strh r0, [r2, #0xc]
	strh r0, [r2, #0xe]
	sub ip, r1, #2
	ldrh r3, [ip]
	mov r2, #0x4000000
	bic r3, r3, #3
	orr r3, r3, #3
	strh r3, [ip]
	ldrh r3, [r1, #0]
	bic r3, r3, #3
	orr r3, r3, #1
	strh r3, [r1]
	ldrh r3, [r1, #2]
	bic r3, r3, #3
	orr r3, r3, #2
	strh r3, [r1, #2]
	ldrh r3, [r1, #4]
	bic r3, r3, #3
	strh r3, [r1, #4]
	ldr r1, [r2, #0]
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1100
	str r1, [r2]
	bl GXS_SetGraphicsMode
	ldr r3, _0215A878 // =0x04001008
	ldr r0, _0215A87C // =0x0000548C
	ldrh ip, [r3]
	add r1, r0, #0x190
	ldr r2, _0215A844 // =renderCoreGFXControlB
	and r0, ip, #0x43
	orr r0, r0, #0x8c
	orr r0, r0, #0x5400
	strh r0, [r3]
	ldrh ip, [r3, #2]
	mov r0, #0
	and ip, ip, #0x43
	orr r1, ip, r1
	strh r1, [r3, #2]
	strh r0, [r2]
	strh r0, [r2, #2]
	strh r0, [r2, #4]
	strh r0, [r2, #6]
	strh r0, [r2, #8]
	strh r0, [r2, #0xa]
	strh r0, [r2, #0xc]
	strh r0, [r2, #0xe]
	ldrh r1, [r3, #4]
	bic r1, r1, #3
	strh r1, [r3, #4]
	ldrh r2, [r3, #6]
	sub ip, r3, #8
	mov r1, #0x6000000
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r3, #6]
	ldrh lr, [r3]
	mov r2, #0x80000
	bic lr, lr, #3
	orr lr, lr, #2
	strh lr, [r3]
	ldrh lr, [r3, #2]
	bic lr, lr, #3
	orr lr, lr, #3
	strh lr, [r3, #2]
	ldr r3, [ip]
	bic r3, r3, #0x1f00
	orr r3, r3, #0x1300
	str r3, [ip]
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x6200000
	mov r2, #0x20000
	bl MIi_CpuClearFast
	ldr r1, _0215A880 // =renderCoreGFXControlA+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r1, _0215A884 // =renderCoreGFXControlB+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r1, _0215A844 // =renderCoreGFXControlB
	ldr r0, _0215A840 // =renderCoreGFXControlA
	ldrh r3, [r1, #0x20]
	mov r2, #0
	str r2, [r0, #0x1c]
	orr r0, r3, #0x100
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #0x200
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x22]
	bic r0, r0, #0x1f
	orr r0, r0, #0x10
	strh r0, [r1, #0x22]
	ldrh r0, [r1, #0x22]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1000
	strh r0, [r1, #0x22]
	str r2, [r1, #0x1c]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215A840: .word renderCoreGFXControlA
_0215A844: .word renderCoreGFXControlB
_0215A848: .word 0x0400006C
_0215A84C: .word 0x0400106C
_0215A850: .word 0x04000304
_0215A854: .word 0xFFFFFDF1
_0215A858: .word renderCoreSwapBuffer
_0215A85C: .word 0x04000060
_0215A860: .word 0xFFFFCFFD
_0215A864: .word 0x0000CFFB
_0215A868: .word 0x00007FFF
_0215A86C: .word 0x04000540
_0215A870: .word 0x0400000A
_0215A874: .word 0xBFFF0000
_0215A878: .word 0x04001008
_0215A87C: .word 0x0000548C
_0215A880: .word renderCoreGFXControlA+0x00000020
_0215A884: .word renderCoreGFXControlB+0x00000020
	arm_func_end ViHubAreaPreview__Func_215A520

	arm_func_start ViHubAreaPreview__Func_215A888
ViHubAreaPreview__Func_215A888: // 0x0215A888
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _0215A95C // =renderCoreGFXControlA
	mov r1, #0
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	strh r1, [r0, #0xc]
	ldr r3, _0215A960 // =0x04000008
	strh r1, [r0, #0xe]
	ldrh r1, [r3, #0]
	mov r4, #0x4000000
	ldr r0, _0215A964 // =0x03FF03FF
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r3]
	ldrh r5, [r3, #2]
	mov r1, #0x6000000
	mov r2, #0x1000
	bic r5, r5, #3
	orr r5, r5, #1
	strh r5, [r3, #2]
	ldrh r5, [r3, #4]
	bic r5, r5, #3
	orr r5, r5, #2
	strh r5, [r3, #4]
	ldrh r5, [r3, #6]
	bic r5, r5, #3
	strh r5, [r3, #6]
	ldr lr, [r4]
	ldr ip, [r4]
	and lr, lr, #0x1f00
	mov r5, lr, lsr #8
	bic lr, ip, #0x1f00
	bic ip, r5, #0xe
	orr ip, lr, ip, lsl #8
	str ip, [r4]
	ldrh ip, [r3, #2]
	and ip, ip, #0x43
	orr ip, ip, #8
	orr ip, ip, #0x1000
	strh ip, [r3, #2]
	ldrh ip, [r3, #4]
	and ip, ip, #0x43
	orr ip, ip, #0x100
	strh ip, [r3, #4]
	ldrh ip, [r3, #6]
	and ip, ip, #0x43
	strh ip, [r3, #6]
	bl MIi_CpuClear32
	ldr r1, _0215A968 // =0x06007FE0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A95C: .word renderCoreGFXControlA
_0215A960: .word 0x04000008
_0215A964: .word 0x03FF03FF
_0215A968: .word 0x06007FE0
	arm_func_end ViHubAreaPreview__Func_215A888

	arm_func_start ViHubAreaPreview__Func_215A96C
ViHubAreaPreview__Func_215A96C: // 0x0215A96C
	ldr r1, _0215A9D4 // =0x04000008
	mov r2, #0x4000000
	ldrh r0, [r1, #0]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [r1, #2]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r1, #4]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r1, #4]
	ldrh r0, [r1, #6]
	bic r0, r0, #3
	strh r0, [r1, #6]
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #0xe
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	.align 2, 0
_0215A9D4: .word 0x04000008
	arm_func_end ViHubAreaPreview__Func_215A96C

	arm_func_start ViHubAreaPreview__Func_215A9D8
ViHubAreaPreview__Func_215A9D8: // 0x0215A9D8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _0215AAA4 // =renderCoreGFXControlB
	mov r1, #0
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	ldr ip, _0215AAA8 // =0x0400100E
	strh r1, [r0, #0xc]
	strh r1, [r0, #0xe]
	ldrh r0, [ip]
	sub r3, ip, #2
	sub r4, ip, #6
	bic r0, r0, #3
	strh r0, [ip]
	ldrh r0, [r3, #0]
	sub r6, ip, #4
	sub r5, ip, #0xe
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r3]
	ldrh r2, [r4, #0]
	ldr r0, _0215AAAC // =0x03FF03FF
	mov r1, #0x6200000
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r4]
	ldrh r4, [r6, #0]
	mov r2, #0x1000
	bic r4, r4, #3
	orr r4, r4, #3
	strh r4, [r6]
	ldr r4, [r5, #0]
	ldr lr, [r5]
	and r4, r4, #0x1f00
	mov r6, r4, lsr #8
	bic r4, lr, #0x1f00
	bic lr, r6, #0xc
	orr r4, r4, lr, lsl #8
	str r4, [r5]
	ldrh lr, [r3]
	and lr, lr, #0x43
	orr lr, lr, #0x100
	strh lr, [r3]
	ldrh r3, [ip]
	and r3, r3, #0x43
	strh r3, [ip]
	bl MIi_CpuClear32
	ldr r1, _0215AAB0 // =0x06207FE0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215AAA4: .word renderCoreGFXControlB
_0215AAA8: .word 0x0400100E
_0215AAAC: .word 0x03FF03FF
_0215AAB0: .word 0x06207FE0
	arm_func_end ViHubAreaPreview__Func_215A9D8

	arm_func_start ViHubAreaPreview__Func_215AAB4
ViHubAreaPreview__Func_215AAB4: // 0x0215AAB4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _0215AB74 // =renderCoreGFXControlB
	mov r2, #0
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r1, _0215AB78 // =0x0400100E
	strh r2, [r0, #0xc]
	strh r2, [r0, #0xe]
	ldrh r0, [r1, #0]
	sub r3, r1, #2
	sub r5, r1, #6
	bic r0, r0, #3
	strh r0, [r1]
	ldrh r0, [r3, #0]
	sub ip, r1, #4
	sub r4, r1, #0xe
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r3]
	ldrh r2, [r5, #0]
	ldr r0, _0215AB7C // =0x03FF03FF
	mov r1, #0x6200000
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r5]
	ldrh r5, [ip]
	mov r2, #0x1000
	bic r5, r5, #3
	orr r5, r5, #3
	strh r5, [ip]
	ldr lr, [r4]
	ldr ip, [r4]
	and lr, lr, #0x1f00
	mov r5, lr, lsr #8
	bic lr, ip, #0x1f00
	bic ip, r5, #0xc
	orr ip, lr, ip, lsl #8
	str ip, [r4]
	ldrh ip, [r3]
	and ip, ip, #0x43
	orr ip, ip, #0x100
	strh ip, [r3]
	bl MIi_CpuClear32
	ldr r1, _0215AB80 // =0x06207FE0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215AB74: .word renderCoreGFXControlB
_0215AB78: .word 0x0400100E
_0215AB7C: .word 0x03FF03FF
_0215AB80: .word 0x06207FE0
	arm_func_end ViHubAreaPreview__Func_215AAB4

	arm_func_start ViHubAreaPreview__Func_215AB84
ViHubAreaPreview__Func_215AB84: // 0x0215AB84
	ldr ip, _0215ABF4 // =0x0400100C
	ldrh r0, [ip]
	sub r3, ip, #4
	sub r1, ip, #2
	bic r0, r0, #3
	strh r0, [ip]
	ldrh r0, [ip, #2]
	sub r2, ip, #0xc
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [ip, #2]
	ldrh r0, [r3, #0]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r3]
	ldrh r0, [r1, #0]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #0xc
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	.align 2, 0
_0215ABF4: .word 0x0400100C
	arm_func_end ViHubAreaPreview__Func_215AB84

	arm_func_start ViHubAreaPreview__Func_215ABF8
ViHubAreaPreview__Func_215ABF8: // 0x0215ABF8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0215AD14 // =renderCoreGFXControlA
	mov r0, #0
	strh r0, [r1, #4]
	strh r0, [r1, #6]
	strh r0, [r1, #0xc]
	strh r0, [r1, #0xe]
	ldr ip, _0215AD18 // =0x0400000C
	strh r0, [r1, #8]
	strh r0, [r1, #0xa]
	ldrh r2, [ip]
	ldr r1, _0215AD1C // =0x00000584
	sub r3, ip, #2
	bic r2, r2, #3
	strh r2, [ip]
	ldrh r2, [r3, #0]
	sub r6, ip, #4
	mov r5, #0x4000000
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r3]
	ldrh r2, [ip, #2]
	add lr, r1, #0x108
	ldr r1, _0215AD20 // =0x06001800
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [ip, #2]
	ldrh r4, [r6, #0]
	mov r2, #0x800
	bic r4, r4, #3
	orr r4, r4, #3
	strh r4, [r6]
	ldr r4, [r5, #0]
	bic r4, r4, #0x1f00
	orr r4, r4, #0x1500
	str r4, [r5]
	ldrh r4, [r3, #0]
	and r4, r4, #0x43
	orr r4, r4, #0x184
	orr r4, r4, #0x400
	strh r4, [r3]
	ldrh r3, [ip, #2]
	and r3, r3, #0x43
	orr r3, r3, lr
	strh r3, [ip, #2]
	ldrh r3, [ip]
	and r3, r3, #0x43
	orr r3, r3, #0x400
	strh r3, [ip]
	bl MIi_CpuClearFast
	ldr r1, _0215AD24 // =0x06002000
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	ldr r1, _0215AD28 // =0x06004000
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClearFast
	ldr r1, _0215AD2C // =0x0600C000
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClearFast
	ldr r1, _0215AD30 // =0x06001000
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x6000000
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215AD14: .word renderCoreGFXControlA
_0215AD18: .word 0x0400000C
_0215AD1C: .word 0x00000584
_0215AD20: .word 0x06001800
_0215AD24: .word 0x06002000
_0215AD28: .word 0x06004000
_0215AD2C: .word 0x0600C000
_0215AD30: .word 0x06001000
	arm_func_end ViHubAreaPreview__Func_215ABF8

	arm_func_start ViHubAreaPreview__Func_215AD34
ViHubAreaPreview__Func_215AD34: // 0x0215AD34
	ldr r1, _0215AD9C // =0x04000008
	mov r2, #0x4000000
	ldrh r0, [r1, #0]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1]
	ldrh r0, [r1, #2]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r1, #4]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r1, #4]
	ldrh r0, [r1, #6]
	bic r0, r0, #3
	strh r0, [r1, #6]
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #0xe
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	.align 2, 0
_0215AD9C: .word 0x04000008
	arm_func_end ViHubAreaPreview__Func_215AD34

	arm_func_start ViHubAreaPreview__Func_215ADA0
ViHubAreaPreview__Func_215ADA0: // 0x0215ADA0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x54
	ldr r0, _0215AE78 // =renderCoreGFXControlA
	mov r2, #0
	ldr r3, _0215AE7C // =0x0400000A
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	ldrh r0, [r3, #0]
	sub lr, r3, #2
	mov ip, #0x4000000
	bic r0, r0, #3
	strh r0, [r3]
	ldrh r4, [r3, #2]
	ldr r0, _0215AE80 // =aBbTkdmDownBb_ovl05
	mov r1, #7
	bic r4, r4, #3
	orr r4, r4, #1
	strh r4, [r3, #2]
	ldrh r4, [r3, #4]
	bic r4, r4, #3
	orr r4, r4, #2
	strh r4, [r3, #4]
	ldrh r4, [lr]
	bic r4, r4, #3
	orr r4, r4, #3
	strh r4, [lr]
	ldr r4, [ip]
	bic r4, r4, #0x1f00
	orr r4, r4, #0x200
	str r4, [ip]
	ldrh r4, [r3, #0]
	and r4, r4, #0x43
	orr r4, r4, #0x104
	orr r4, r4, #0x400
	strh r4, [r3]
	bl ReadFileFromBundle
	mov r4, r0
	mov r0, #1
	str r0, [sp]
	mov r2, #0x20
	str r2, [sp, #4]
	mov ip, #0x18
	add r0, sp, #0xc
	mov r1, r4
	mov r2, #0x38
	mov r3, #0
	str ip, [sp, #8]
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r4
	bl _FreeHEAP_USER
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215AE78: .word renderCoreGFXControlA
_0215AE7C: .word 0x0400000A
_0215AE80: .word aBbTkdmDownBb_ovl05
	arm_func_end ViHubAreaPreview__Func_215ADA0

	arm_func_start ViHubAreaPreview__Func_215AE84
ViHubAreaPreview__Func_215AE84: // 0x0215AE84
	ldr r2, _0215AEDC // =0x04000008
	mov r1, #0x4000000
	ldrh r0, [r2, #0]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r2]
	ldrh r0, [r2, #2]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r2, #2]
	ldrh r0, [r2, #4]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r2, #4]
	ldrh r0, [r2, #6]
	bic r0, r0, #3
	strh r0, [r2, #6]
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1100
	str r0, [r1]
	bx lr
	.align 2, 0
_0215AEDC: .word 0x04000008
	arm_func_end ViHubAreaPreview__Func_215AE84

	arm_func_start ViHubAreaPreview__Func_215AEE0
ViHubAreaPreview__Func_215AEE0: // 0x0215AEE0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r2
	mov r6, r1
	mov r1, r5
	bl ViHubAreaPreview__Func_215AF14
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl ViHubAreaPreview__Func_215AFA8
	cmp r4, r0
	movle r4, r0
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ViHubAreaPreview__Func_215AEE0

	arm_func_start ViHubAreaPreview__Func_215AF14
ViHubAreaPreview__Func_215AF14: // 0x0215AF14
	stmdb sp!, {r4, lr}
	ldr r2, _0215AFA0 // =renderCoreGFXControlA
	ldrsh r3, [r2, #0x58]
	cmp r3, r0
	ble _0215AF4C
	sub r1, r3, r1
	strh r1, [r2, #0x58]
	ldrsh r1, [r2, #0x58]
	cmp r1, r0
	ldr r1, _0215AFA0 // =renderCoreGFXControlA
	strlth r0, [r2, #0x58]
	ldrsh r3, [r1, #0x58]
	sub r4, r3, r0
	b _0215AF78
_0215AF4C:
	bge _0215AF74
	add r1, r3, r1
	strh r1, [r2, #0x58]
	ldrsh r1, [r2, #0x58]
	cmp r1, r0
	ldr r1, _0215AFA0 // =renderCoreGFXControlA
	strgth r0, [r2, #0x58]
	ldrsh r3, [r1, #0x58]
	sub r4, r0, r3
	b _0215AF78
_0215AF74:
	mov r4, #0
_0215AF78:
	cmp r3, #0
	rsblt r0, r3, #0
	movge r0, r3
	cmp r0, #0x10
	blt _0215AF98
	ldr r0, _0215AFA4 // =0x0400006C
	mov r1, r3
	bl GXx_SetMasterBrightness_
_0215AF98:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215AFA0: .word renderCoreGFXControlA
_0215AFA4: .word 0x0400006C
	arm_func_end ViHubAreaPreview__Func_215AF14

	arm_func_start ViHubAreaPreview__Func_215AFA8
ViHubAreaPreview__Func_215AFA8: // 0x0215AFA8
	stmdb sp!, {r4, lr}
	ldr r2, _0215B034 // =renderCoreGFXControlB
	ldrsh r3, [r2, #0x58]
	cmp r3, r0
	ble _0215AFE0
	sub r1, r3, r1
	strh r1, [r2, #0x58]
	ldrsh r1, [r2, #0x58]
	cmp r1, r0
	ldr r1, _0215B034 // =renderCoreGFXControlB
	strlth r0, [r2, #0x58]
	ldrsh r3, [r1, #0x58]
	sub r4, r3, r0
	b _0215B00C
_0215AFE0:
	bge _0215B008
	add r1, r3, r1
	strh r1, [r2, #0x58]
	ldrsh r1, [r2, #0x58]
	cmp r1, r0
	ldr r1, _0215B034 // =renderCoreGFXControlB
	strgth r0, [r2, #0x58]
	ldrsh r3, [r1, #0x58]
	sub r4, r0, r3
	b _0215B00C
_0215B008:
	mov r4, #0
_0215B00C:
	cmp r3, #0
	rsblt r0, r3, #0
	movge r0, r3
	cmp r0, #0x10
	blt _0215B02C
	ldr r0, _0215B038 // =0x0400106C
	mov r1, r3
	bl GXx_SetMasterBrightness_
_0215B02C:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B034: .word renderCoreGFXControlB
_0215B038: .word 0x0400106C
	arm_func_end ViHubAreaPreview__Func_215AFA8

	arm_func_start ViHubAreaPreview__Func_215B03C
ViHubAreaPreview__Func_215B03C: // 0x0215B03C
	stmdb sp!, {r3, lr}
	ldr r0, _0215B158 // =renderCoreGFXControlB
	ldr lr, _0215B15C // =0x0400100C
	mov r1, #0
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	ldrh r0, [lr]
	sub ip, lr, #4
	sub r2, lr, #2
	bic r0, r0, #3
	strh r0, [lr]
	ldrh r1, [lr, #2]
	sub r3, lr, #0xc
	mov r0, #5
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [lr, #2]
	ldrh r1, [ip]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [ip]
	ldrh r1, [r2, #0]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r2]
	ldr r2, [r3, #0]
	ldr r1, [r3, #0]
	and r2, r2, #0x1f00
	mov ip, r2, lsr #8
	bic r2, r1, #0x1f00
	bic r1, ip, #0xc
	orr r1, r2, r1, lsl #8
	str r1, [r3]
	bl GXS_SetGraphicsMode
	ldr ip, _0215B15C // =0x0400100C
	ldr r1, _0215B160 // =renderCoreGFXControlA+0x00000020
	ldrh r3, [ip]
	mov r0, #0
	mov r2, #6
	and r3, r3, #0x43
	orr r3, r3, #4
	orr r3, r3, #0x4000
	strh r3, [ip]
	bl MIi_CpuClear16
	ldr r1, _0215B164 // =renderCoreGFXControlB+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r0, _0215B158 // =renderCoreGFXControlB
	ldrh r1, [r0, #0x20]
	bic r1, r1, #0xc0
	orr r1, r1, #0x40
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x20]
	orr r1, r1, #0x104
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x20]
	orr r1, r1, #0x200
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x20]
	orr r1, r1, #0x1000
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x22]
	bic r1, r1, #0x1f
	orr r1, r1, #0x10
	strh r1, [r0, #0x22]
	ldrh r1, [r0, #0x22]
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1000
	strh r1, [r0, #0x22]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B158: .word renderCoreGFXControlB
_0215B15C: .word 0x0400100C
_0215B160: .word renderCoreGFXControlA+0x00000020
_0215B164: .word renderCoreGFXControlB+0x00000020
	arm_func_end ViHubAreaPreview__Func_215B03C

	arm_func_start ViHubAreaPreview__Func_215B168
ViHubAreaPreview__Func_215B168: // 0x0215B168
	stmdb sp!, {r3, lr}
	ldr lr, _0215B240 // =0x0400100C
	mov r0, #0
	ldrh r1, [lr]
	sub ip, lr, #4
	sub r2, lr, #2
	bic r1, r1, #3
	strh r1, [lr]
	ldrh r1, [lr, #2]
	sub r3, lr, #0xc
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [lr, #2]
	ldrh r1, [ip]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [ip]
	ldrh r1, [r2, #0]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r2]
	ldr r2, [r3, #0]
	ldr r1, [r3, #0]
	and r2, r2, #0x1f00
	mov ip, r2, lsr #8
	bic r2, r1, #0x1f00
	bic r1, ip, #0xc
	orr r1, r2, r1, lsl #8
	str r1, [r3]
	bl GXS_SetGraphicsMode
	ldr r1, _0215B244 // =renderCoreGFXControlA+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r1, _0215B248 // =renderCoreGFXControlB+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r0, _0215B24C // =renderCoreGFXControlB
	ldrh r1, [r0, #0x20]
	orr r1, r1, #0x100
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x20]
	orr r1, r1, #0x200
	strh r1, [r0, #0x20]
	ldrh r1, [r0, #0x22]
	bic r1, r1, #0x1f
	orr r1, r1, #0x10
	strh r1, [r0, #0x22]
	ldrh r1, [r0, #0x22]
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1000
	strh r1, [r0, #0x22]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B240: .word 0x0400100C
_0215B244: .word renderCoreGFXControlA+0x00000020
_0215B248: .word renderCoreGFXControlB+0x00000020
_0215B24C: .word renderCoreGFXControlB
	arm_func_end ViHubAreaPreview__Func_215B168

	arm_func_start ViHubAreaPreview__Func_215B250
ViHubAreaPreview__Func_215B250: // 0x0215B250
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215B3A4 // =renderCoreGFXControlB
	ldr r3, _0215B3A8 // =0x0400100C
	mov r0, #0
	strh r0, [r1, #8]
	strh r0, [r1, #0xa]
	ldrh r1, [r3, #0]
	sub lr, r3, #4
	sub ip, r3, #2
	bic r1, r1, #3
	strh r1, [r3]
	ldrh r2, [r3, #2]
	sub r4, r3, #0xc
	ldr r1, _0215B3AC // =renderCoreGFXControlA+0x00000020
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r3, #2]
	ldrh r5, [lr]
	mov r2, #6
	bic r5, r5, #3
	orr r5, r5, #2
	strh r5, [lr]
	ldrh r5, [ip]
	bic r5, r5, #3
	orr r5, r5, #3
	strh r5, [ip]
	ldr lr, [r4]
	ldr ip, [r4]
	and lr, lr, #0x1f00
	mov r5, lr, lsr #8
	bic lr, ip, #0x1f00
	bic ip, r5, #0xc
	orr ip, lr, ip, lsl #8
	str ip, [r4]
	ldrh ip, [r3]
	and ip, ip, #0x43
	orr ip, ip, #4
	strh ip, [r3]
	bl MIi_CpuClear16
	ldr r1, _0215B3B0 // =renderCoreGFXControlB+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r0, _0215B3A4 // =renderCoreGFXControlB
	mov r1, #4
	ldrh r2, [r0, #0x20]
	bic r2, r2, #0xc0
	orr r2, r2, #0x40
	strh r2, [r0, #0x20]
	ldrh r2, [r0, #0x20]
	orr r2, r2, #0x104
	strh r2, [r0, #0x20]
	ldrh r2, [r0, #0x20]
	orr r2, r2, #0x200
	strh r2, [r0, #0x20]
	ldrh r2, [r0, #0x20]
	orr r2, r2, #0x1000
	strh r2, [r0, #0x20]
	ldrh r2, [r0, #0x22]
	bic r2, r2, #0x1f
	orr r2, r2, #0x10
	strh r2, [r0, #0x22]
	ldrh r2, [r0, #0x22]
	bic r2, r2, #0x1f00
	orr r2, r2, #0x1000
	strh r2, [r0, #0x22]
	str r1, [r0, #0x1c]
	ldrb r1, [r0, #0x1a]
	bic r1, r1, #1
	orr r2, r1, #1
	and r1, r2, #0xff
	orr r1, r1, #2
	strb r1, [r0, #0x1a]
	ldrb r1, [r0, #0x1a]
	bic r3, r1, #4
	and r1, r3, #0xff
	orr r1, r1, #0x38
	strb r1, [r0, #0x1a]
	ldrb r1, [r0, #0x1b]
	bic r1, r1, #1
	orr r2, r1, #1
	and r1, r2, #0xff
	orr r1, r1, #0x3e
	strb r1, [r0, #0x1b]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B3A4: .word renderCoreGFXControlB
_0215B3A8: .word 0x0400100C
_0215B3AC: .word renderCoreGFXControlA+0x00000020
_0215B3B0: .word renderCoreGFXControlB+0x00000020
	arm_func_end ViHubAreaPreview__Func_215B250

	arm_func_start ViHubAreaPreview__Func_215B3B4
ViHubAreaPreview__Func_215B3B4: // 0x0215B3B4
	stmdb sp!, {r3, lr}
	bl ViHubAreaPreview__Func_215B168
	ldr r0, _0215B3CC // =renderCoreGFXControlB
	mov r1, #0
	str r1, [r0, #0x1c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B3CC: .word renderCoreGFXControlB
	arm_func_end ViHubAreaPreview__Func_215B3B4

	arm_func_start ViHubAreaPreview__Func_215B3D0
ViHubAreaPreview__Func_215B3D0: // 0x0215B3D0
	stmdb sp!, {r3, lr}
	bl VRAMSystem__Reset
	mov r0, #3
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x20
	bl VRAMSystem__SetupTexturePalBank
	bl VRAMSystem__InitTextureBuffer
	bl VRAMSystem__InitPaletteBuffer
	mov r0, #0x10
	bl VRAMSystem__SetupBGBank
	mov r0, #0x200
	str r0, [sp]
	mov r0, #0x40
	mov r1, #0x10
	mov r2, r0
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r0, #0
	bl VRAMSystem__SetupBGExtPalBank
	mov r0, #0
	bl VRAMSystem__SetupOBJExtPalBank
	mov r0, #0
	bl VRAMSystem__InitSpriteBuffer
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x400
	str r0, [sp]
	mov r0, #8
	ldr r1, _0215B46C // =0x00200010
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0x80
	bl VRAMSystem__SetupSubBGExtPalBank
	mov r0, #0x100
	bl VRAMSystem__SetupSubOBJExtPalBank
	mov r0, #1
	bl VRAMSystem__InitSpriteBuffer
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B46C: .word 0x00200010
	arm_func_end ViHubAreaPreview__Func_215B3D0

	arm_func_start ViHubAreaPreview__Func_215B470
ViHubAreaPreview__Func_215B470: // 0x0215B470
	stmdb sp!, {r3, lr}
	ldr r1, _0215B494 // =ovl05_02172D70
	cmp r0, #0
	ldrb r0, [r1, r0]
	bne _0215B48C
	bl SaveGame__Func_205BBBC
	ldmia sp!, {r3, pc}
_0215B48C:
	bl SaveGame__SetGameProgress
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B494: .word ovl05_02172D70
	arm_func_end ViHubAreaPreview__Func_215B470

	arm_func_start ViHubAreaPreview__Func_215B498
ViHubAreaPreview__Func_215B498: // 0x0215B498
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _0215B4C0
	bl SaveGame__GetGameProgress
	cmp r0, #1
	bne _0215B4C0
	bl SaveGame__Func_205BB18
	cmp r0, #1
	movhs r0, #1
	ldmhsia sp!, {r4, pc}
_0215B4C0:
	bl SaveGame__GetGameProgress
	ldr r1, _0215B4DC // =ovl05_02172D70
	ldrb r1, [r1, r4]
	cmp r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B4DC: .word ovl05_02172D70
	arm_func_end ViHubAreaPreview__Func_215B498

	arm_func_start ViHubAreaPreview__Func_215B4E0
ViHubAreaPreview__Func_215B4E0: // 0x0215B4E0
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	mov r1, r0, lsl #0x10
	ldr r3, _0215B518 // =ovl05_02172D68
	mov r0, #0
_0215B4F4:
	ldrb r2, [r3, #0]
	cmp r2, r1, lsr #16
	ldmeqia sp!, {r3, pc}
	add r0, r0, #1
	cmp r0, #5
	add r3, r3, #1
	blt _0215B4F4
	mov r0, #6
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B518: .word ovl05_02172D68
	arm_func_end ViHubAreaPreview__Func_215B4E0

	arm_func_start ViHubAreaPreview__Func_215B51C
ViHubAreaPreview__Func_215B51C: // 0x0215B51C
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _0215B544
	bl SaveGame__GetGameProgress
	cmp r0, #0
	bne _0215B544
	bl SaveGame__Func_205BB18
	cmp r0, #6
	movls r0, #0
	ldmlsia sp!, {r4, pc}
_0215B544:
	cmp r4, #1
	bne _0215B568
	bl SaveGame__GetGameProgress
	cmp r0, #1
	bne _0215B568
	bl SaveGame__Func_205BB18
	cmp r0, #1
	movhs r0, #1
	ldmhsia sp!, {r4, pc}
_0215B568:
	bl SaveGame__GetGameProgress
	ldr r1, _0215B584 // =ovl05_02172D78
	ldrb r1, [r1, r4]
	cmp r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B584: .word ovl05_02172D78
	arm_func_end ViHubAreaPreview__Func_215B51C

	arm_func_start ViHubAreaPreview__Func_215B588
ViHubAreaPreview__Func_215B588: // 0x0215B588
	stmdb sp!, {r3, lr}
	cmp r0, #7
	bne _0215B5A0
	mov r0, #0x11
	bl SaveGame__SetGameProgress
	ldmia sp!, {r3, pc}
_0215B5A0:
	cmp r0, #0x15
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0215B5AC: // jump table
	ldmia sp!, {r3, pc} // case 0
	b _0215B628 // case 1
	b _0215B634 // case 2
	ldmia sp!, {r3, pc} // case 3
	b _0215B640 // case 4
	b _0215B604 // case 5
	b _0215B64C // case 6
	ldmia sp!, {r3, pc} // case 7
	b _0215B610 // case 8
	ldmia sp!, {r3, pc} // case 9
	b _0215B658 // case 10
	b _0215B664 // case 11
	b _0215B670 // case 12
	b _0215B67C // case 13
	ldmia sp!, {r3, pc} // case 14
	ldmia sp!, {r3, pc} // case 15
	b _0215B688 // case 16
	b _0215B61C // case 17
	b _0215B694 // case 18
	b _0215B6A0 // case 19
	b _0215B6AC // case 20
	b _0215B6B8 // case 21
_0215B604:
	mov r0, #0
	bl SaveGame__SetBoughtInfo
	ldmia sp!, {r3, pc}
_0215B610:
	mov r0, #1
	bl SaveGame__SetBoughtInfo
	ldmia sp!, {r3, pc}
_0215B61C:
	mov r0, #2
	bl SaveGame__SetBoughtInfo
	ldmia sp!, {r3, pc}
_0215B628:
	mov r0, #0x53
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B634:
	mov r0, #0x27
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B640:
	mov r0, #0x5b
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B64C:
	mov r0, #0x63
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B658:
	mov r0, #0x4f
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B664:
	mov r0, #0x59
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B670:
	mov r0, #0x5d
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B67C:
	mov r0, #0x3b
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B688:
	mov r0, #9
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B694:
	mov r0, #0x58
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B6A0:
	mov r0, #0x31
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B6AC:
	mov r0, #0x54
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
_0215B6B8:
	mov r0, #0x55
	bl MissionHelpers__BeatMission
	ldmia sp!, {r3, pc}
	arm_func_end ViHubAreaPreview__Func_215B588

	arm_func_start ViHubAreaPreview__Func_215B6C4
ViHubAreaPreview__Func_215B6C4: // 0x0215B6C4
	stmdb sp!, {r3, lr}
	cmp r0, #0x15
	addls pc, pc, r0, lsl #2
	b _0215B848
_0215B6D4: // jump table
	b _0215B72C // case 0
	b _0215B780 // case 1
	b _0215B78C // case 2
	b _0215B748 // case 3
	b _0215B798 // case 4
	b _0215B75C // case 5
	b _0215B83C // case 6
	b _0215B734 // case 7
	b _0215B768 // case 8
	b _0215B780 // case 9
	b _0215B7A4 // case 10
	b _0215B7B0 // case 11
	b _0215B7BC // case 12
	b _0215B7C8 // case 13
	b _0215B748 // case 14
	b _0215B7D4 // case 15
	b _0215B7F8 // case 16
	b _0215B774 // case 17
	b _0215B7EC // case 18
	b _0215B804 // case 19
	b _0215B810 // case 20
	b _0215B830 // case 21
_0215B72C:
	mov r0, #1
	ldmia sp!, {r3, pc}
_0215B734:
	bl SaveGame__GetGameProgress
	cmp r0, #0x11
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_0215B748:
	bl SaveGame__GetGameProgress
	cmp r0, #0x19
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_0215B75C:
	mov r0, #0
	bl SaveGame__GetBoughtInfo
	ldmia sp!, {r3, pc}
_0215B768:
	mov r0, #1
	bl SaveGame__GetBoughtInfo
	ldmia sp!, {r3, pc}
_0215B774:
	mov r0, #2
	bl SaveGame__GetBoughtInfo
	ldmia sp!, {r3, pc}
_0215B780:
	mov r0, #0x53
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B78C:
	mov r0, #0x27
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B798:
	mov r0, #0x5b
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B7A4:
	mov r0, #0x4f
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B7B0:
	mov r0, #0x59
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B7BC:
	mov r0, #0x5d
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B7C8:
	mov r0, #0x3b
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B7D4:
	mov r0, #0x58
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
_0215B7EC:
	mov r0, #0x58
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B7F8:
	mov r0, #9
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B804:
	mov r0, #0x31
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B810:
	mov r0, #0x55
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #0x54
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B830:
	mov r0, #0x55
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B83C:
	mov r0, #0x63
	bl MissionHelpers__IsMissionBeaten
	ldmia sp!, {r3, pc}
_0215B848:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ViHubAreaPreview__Func_215B6C4

	arm_func_start ViHubAreaPreview__Func_215B850
ViHubAreaPreview__Func_215B850: // 0x0215B850
	mov r0, #1
	bx lr
	arm_func_end ViHubAreaPreview__Func_215B850

	arm_func_start ViHubAreaPreview__Func_215B858
ViHubAreaPreview__Func_215B858: // 0x0215B858
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, _0215B8F8 // =_0217362C
	mov r7, r0
	ldr r4, [r1, r7, lsl #2]
	bl SaveGame__GetGameProgress
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress2
	mov r0, r0, lsl #0x10
	mov r3, #0
	mov r1, r3
	mov r2, r0, lsr #0x10
_0215B894:
	mov r0, r1, lsl #2
	ldrh r0, [r4, r0]
	cmp r5, r0
	blo _0215B8E8
	cmp r7, #0xf
	cmpeq r0, #0x18
	bne _0215B8BC
	cmp r6, #4
	blo _0215B8E8
	b _0215B8D8
_0215B8BC:
	cmp r7, #0x11
	cmpne r7, #0x13
	bne _0215B8D8
	cmp r0, #0x18
	bne _0215B8D8
	cmp r2, #2
	blo _0215B8E8
_0215B8D8:
	add r0, r4, r1, lsl #2
	add r1, r1, #1
	ldrh r3, [r0, #2]
	b _0215B894
_0215B8E8:
	cmp r3, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215B8F8: .word _0217362C
	arm_func_end ViHubAreaPreview__Func_215B858

	arm_func_start ViHubAreaPreview__Func_215B8FC
ViHubAreaPreview__Func_215B8FC: // 0x0215B8FC
	ldr ip, _0215B924 // =gameState+0x000000CC
	mov r3, #0x1c
	mov r2, #1
	ldr r1, _0215B928 // =gameState
	str r0, [ip]
	strh r3, [ip, #4]
	str r2, [ip, #8]
	mov r0, #4
	strb r0, [r1, #0xdc]
	bx lr
	.align 2, 0
_0215B924: .word gameState+0x000000CC
_0215B928: .word gameState
	arm_func_end ViHubAreaPreview__Func_215B8FC

	arm_func_start ViHubAreaPreview__Func_215B92C
ViHubAreaPreview__Func_215B92C: // 0x0215B92C
	ldr ip, _0215B950 // =gameState+0x000000CC
	mov r3, #0x1c
	mov r2, #1
	ldr r1, _0215B954 // =gameState
	str r0, [ip]
	strh r3, [ip, #4]
	str r2, [ip, #8]
	strb r2, [r1, #0xdc]
	bx lr
	.align 2, 0
_0215B950: .word gameState+0x000000CC
_0215B954: .word gameState
	arm_func_end ViHubAreaPreview__Func_215B92C

	arm_func_start ViHubAreaPreview__Func_215B958
ViHubAreaPreview__Func_215B958: // 0x0215B958
	ldr r0, _0215B974 // =gameState
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0, #0x14]
	mov r1, #2
	strh r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0215B974: .word gameState
	arm_func_end ViHubAreaPreview__Func_215B958

	arm_func_start ViHubAreaPreview__Func_215B978
ViHubAreaPreview__Func_215B978: // 0x0215B978
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	add r0, sp, #2
	add r1, sp, #0
	bl SaveGame__GetNextShipUpgrade
	ldrh r0, [sp, #2]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215B9C8
_0215B99C: // jump table
	b _0215B9AC // case 0
	b _0215B9B4 // case 1
	b _0215B9BC // case 2
	b _0215B9C4 // case 3
_0215B9AC:
	mov r4, #0
	b _0215B9C8
_0215B9B4:
	mov r4, #2
	b _0215B9C8
_0215B9BC:
	mov r4, #4
	b _0215B9C8
_0215B9C4:
	mov r4, #6
_0215B9C8:
	ldrh r0, [sp]
	cmp r0, #2
	addeq r4, r4, #1
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViHubAreaPreview__Func_215B978
	
	.rodata

.public ViHubAreaPreview__backgroundFileList
ViHubAreaPreview__backgroundFileList: // ViHubAreaPreview__backgroundFileList
	.byte 1, 3, 4, 5, 6, 8, 7, 2

.public ViHubAreaPreview__npcAnimIDList
ViHubAreaPreview__npcAnimIDList: // ViHubAreaPreview__npcAnimIDList
	.byte 10, 8, 9, 11, 1, 2, 3, 4, 5, 6, 7, 255, 255, 0

.public ViHubAreaPreview__npcCount
ViHubAreaPreview__npcCount: // ViHubAreaPreview__npcCount
	.hword 9, 4, 3, 2, 2, 2, 0, 0

.public ViHubAreaPreview__npcStartID
ViHubAreaPreview__npcStartID: // ViHubAreaPreview__npcStartID
	.hword 0, 9, 13, 16, 18, 20, 0, 0

.public HubControl__EventList
HubControl__EventList: // 0x02172D4A
	.hword 40 		// SYSEVENT_UPDATE_PROGRESS
	.hword 27 		// SYSEVENT_SAILING
	.hword 29 		// SYSEVENT_MAIN_MENU
	.hword 39 		// SYSEVENT_DELETE_SAVE_MENU
	.hword 30 		// SYSEVENT_PLAYER_NAME_MENU
	.hword 23 		// SYSEVENT_VS_JOIN_MENU
	.hword 24 		// SYSEVENT_24
	.hword 34 		// SYSEVENT_CUTSCENE
	.hword 34 		// SYSEVENT_CUTSCENE
	.hword 65535 	// SYSEVENT_INVALID
	.hword 8 		// SYSEVENT_LOAD_STAGE
	.hword 41 		// SYSEVENT_SOUND_TEST
	.hword 43 		// SYSEVENT_VIKING_CUP
	.hword 8 		// SYSEVENT_LOAD_STAGE
	.hword 32 		// SYSEVENT_CORRUPT_SAVE_WARNING

.public ovl05_02172D68
ovl05_02172D68: // 0x02172D68
    .byte 1, 8, 21, 25, 255
	.align 4
	
.public ovl05_02172D70
ovl05_02172D70: // 0x02172D70
    .byte 2, 9, 22, 26, 38, 0, 0, 0
	
.public ovl05_02172D78
ovl05_02172D78: // 0x02172D78
    .byte 0, 2, 9, 22, 26, 0, 38, 0
	
.public ovl05_02172D80
ovl05_02172D80: // 0x02172D80
    .hword 0, 1                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172D88
ovl05_02172D88: // 0x02172D88
    .hword 0, 1                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172D90
ovl05_02172D90: // 0x02172D90
    .hword 0, 1                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172D98
ovl05_02172D98: // 0x02172D98
    .hword 0, 0                // gameProgress
	.hword 36, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DA4
ovl05_02172DA4: // 0x02172DA4
    .hword 0, 0                // gameProgress
	.hword 18, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DB0
ovl05_02172DB0: // 0x02172DB0
    .hword 0, 0                // gameProgress
	.hword 16, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DBC
ovl05_02172DBC: // 0x02172DBC
    .hword 0, 0                // gameProgress
	.hword 16, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DC8
ovl05_02172DC8: // 0x02172DC8
    .hword 0, 0                // gameProgress
	.hword 36, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DD4
ovl05_02172DD4: // 0x02172DD4
    .hword 0, 0                // gameProgress
	.hword 24, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DE0
ovl05_02172DE0: // 0x02172DE0
    .hword 0, 0                // gameProgress
	.hword 3, 1                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DEC
ovl05_02172DEC: // 0x02172DEC
    .hword 0, 0                // gameProgress
	.hword 36, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172DF8
ovl05_02172DF8: // 0x02172DF8
    .hword 0, 0                // gameProgress
	.hword 2, 1                // gameProgress
	.hword 3, 0                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E08
ovl05_02172E08: // 0x02172E08
    .hword 0, 0                // gameProgress
	.hword 2, 1                // gameProgress
	.hword 3, 0                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E18
ovl05_02172E18: // 0x02172E18
    .hword 0, 0                // gameProgress
	.hword 24, 1               // gameProgress
	.hword 36, 0               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E28
ovl05_02172E28: // 0x02172E28
    .hword 0, 0                // gameProgress
	.hword 26, 1               // gameProgress
	.hword 36, 0               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E38
ovl05_02172E38: // 0x02172E38
    .hword 0, 0                // gameProgress
	.hword 11, 1               // gameProgress
	.hword 16, 0               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E48
ovl05_02172E48: // 0x02172E48
    .hword 0, 0                // gameProgress
	.hword 5, 1                // gameProgress
	.hword 6, 0                // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E58
ovl05_02172E58: // 0x02172E58
    .hword 0, 0                // gameProgress
	.hword 10, 1               // gameProgress
	.hword 11, 0               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E68
ovl05_02172E68: // 0x02172E68
    .hword 0, 1                // gameProgress
	.hword 31, 0               // gameProgress
	.hword 36, 1               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E78
ovl05_02172E78: // 0x02172E78
    .hword 0, 0                // gameProgress
	.hword 21, 1               // gameProgress
	.hword 26, 0               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E88
ovl05_02172E88: // 0x02172E88
    .hword 0, 0                // gameProgress
	.hword 26, 1               // gameProgress
	.hword 36, 0               // gameProgress
	.hword 41, 0               // gameProgress

.public ovl05_02172E98
ovl05_02172E98: // 0x02172E98
    .hword 0, 0                // gameProgress
	.hword 6, 1                // gameProgress
	.hword 21, 0               // gameProgress
	.hword 36, 1               // gameProgress
	.hword 41, 0               // gameProgress
	.hword 140, 0              // gameProgress
	.hword 200, 0              // gameProgress

	.data

aNarcViActLz7Na: // 0x0217357C
	.asciz "narc/vi_act_lz7.narc"
	.align 4

aBbViActLocBb: // 0x02173594
	.asciz "bb/vi_act_loc.bb"
	.align 4

aNarcViBgLz7Nar_ovl05: // 0x021735A8
	.asciz "narc/vi_bg_lz7.narc"
	.align 4

aBbViBgUpBb: // 0x021735BC
	.asciz "bb/vi_bg_up.bb"
	.align 4

aBbViMsgBb: // 0x021735CC
	.asciz "bb/vi_msg.bb"
	.align 4

aNarcViMsgCtrlL: // 0x021735DC
	.asciz "narc/vi_msg_ctrl_lz7.narc"
	.align 4

aFntFontAllFnt_3_ovl05: // 0x021735F8
	.asciz "fnt/font_all.fnt"
	.align 4

aBbTkdmNameBb: // 0x0217360C
	.asciz "bb/tkdm_name.bb"
	.align 4

aBbTkdmDownBb_ovl05: // 0x0217361C
	.asciz "bb/tkdm_down.bb"
	.align 4

.public _0217362C
_0217362C: // 0x0217362C
    .word ovl05_02172D80
	.word ovl05_02172E68
	.word ovl05_02172DB0
	.word ovl05_02172E48
	.word ovl05_02172E58
	.word ovl05_02172D90
	.word ovl05_02172E78
	.word ovl05_02172DE0
	.word ovl05_02172D88
	.word ovl05_02172DF8
	.word ovl05_02172E08
	.word ovl05_02172E98
	.word ovl05_02172DA4
	.word ovl05_02172E38
	.word ovl05_02172DBC
	.word ovl05_02172DD4
	.word ovl05_02172DEC
	.word ovl05_02172E18
	.word ovl05_02172E28
	.word ovl05_02172DC8
	.word ovl05_02172E88
	.word ovl05_02172D98