	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.text

	arm_func_start ViDockBack__Constructor
ViDockBack__Constructor: // 0x02164410
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _021644BC // =_ZTV11CViDockBack+0x08
	add r0, r4, #8
	str r1, [r4]
	bl Vi3dObject__Constructor
	add r0, r4, #0x308
	bl Vi3dObject__Constructor
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl Vi3dObject__Constructor
	add r0, r4, #0x920
	bl Vi3dObject__Constructor
	mov r0, #0x20000
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x90c]
	mov r0, #0x2000
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x910]
	mov r0, #0x40000
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xc24]
	mov r0, #0x2000
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xc28]
	mov r0, #0x2000
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x914]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x918]
	mov r0, #0
	str r0, [r4, #0x908]
	str r0, [r4, #0xc20]
	str r0, [r4, #0x91c]
	add r0, r4, #0x2c
	add r0, r0, #0xc00
	mov r1, #0x800
	bl InitThreadWorker
	mov r0, r4
	bl ViDockBack__Func_2164968
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021644BC: .word _ZTV11CViDockBack+0x08
	arm_func_end ViDockBack__Constructor

	arm_func_start ViDockBack__VTableFunc_21644C0
ViDockBack__VTableFunc_21644C0: // 0x021644C0
	stmdb sp!, {r4, lr}
	ldr r1, _0216453C // =_ZTV11CViDockBack+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockBack__Func_2164968
	add r0, r4, #0x2c
	add r0, r0, #0xc00
	bl ReleaseThreadWorker
	ldr r0, [r4, #0x918]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x914]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc28]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc24]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x910]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x90c]
	bl _FreeHEAP_USER
	add r0, r4, #0x920
	bl Vi3dObject__VTableFunc_21675D4
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl Vi3dObject__VTableFunc_21675D4
	add r0, r4, #0x308
	bl Vi3dObject__VTableFunc_21675D4
	add r0, r4, #8
	bl Vi3dObject__VTableFunc_21675D4
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216453C: .word _ZTV11CViDockBack+0x08
	arm_func_end ViDockBack__VTableFunc_21644C0

	arm_func_start ViDockBack__VTableFunc_2164540
ViDockBack__VTableFunc_2164540: // 0x02164540
	stmdb sp!, {r4, lr}
	ldr r1, _021645C4 // =_ZTV11CViDockBack+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockBack__Func_2164968
	add r0, r4, #0x2c
	add r0, r0, #0xc00
	bl ReleaseThreadWorker
	ldr r0, [r4, #0x918]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x914]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc28]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xc24]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x910]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x90c]
	bl _FreeHEAP_USER
	add r0, r4, #0x920
	bl Vi3dObject__VTableFunc_21675D4
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl Vi3dObject__VTableFunc_21675D4
	add r0, r4, #0x308
	bl Vi3dObject__VTableFunc_21675D4
	add r0, r4, #8
	bl Vi3dObject__VTableFunc_21675D4
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021645C4: .word _ZTV11CViDockBack+0x08
	arm_func_end ViDockBack__VTableFunc_2164540

	arm_func_start ViDockBack__LoadAssets
ViDockBack__LoadAssets: // 0x021645C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x28
	mov r9, r0
	mov r4, r1
	mov r8, r3
	cmp r2, #0
	bne _021645E8
	bl ViDockBack__Func_2164968
_021645E8:
	cmp r4, #8
	addge sp, sp, #0x28
	str r4, [r9, #4]
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl05_21529F8
	mov r4, r0
	cmp r8, #0
	bne _02164814
	ldrh r1, [r4, #8]
	ldr r2, [r9, #0x90c]
	mov r7, #0
	ldr r0, _02164910 // =aBbViDockBb_0
	mov r6, r7
	mov r5, r7
	bl BundleFileUnknown__LoadFileFromBundle
	ldrh r1, [r4, #0xa]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _0216464C
	ldr r2, [r9, #0x910]
	ldr r0, _02164910 // =aBbViDockBb_0
	bl BundleFileUnknown__LoadFileFromBundle
	ldr r5, [r9, #0x910]
_0216464C:
	ldrh r1, [r4, #0xc]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _0216466C
	ldr r2, [r9, #0x914]
	ldr r0, _02164910 // =aBbViDockBb_0
	bl BundleFileUnknown__LoadFileFromBundle
	ldr r7, [r9, #0x914]
_0216466C:
	ldrh r1, [r4, #0xe]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _0216468C
	ldr r2, [r9, #0x918]
	ldr r0, _02164910 // =aBbViDockBb_0
	bl BundleFileUnknown__LoadFileFromBundle
	ldr r6, [r9, #0x918]
_0216468C:
	ldr r0, [r9, #4]
	mov r2, #0
	cmp r0, #6
	ldr r0, _02164914 // =0x0000FFFF
	stmia sp, {r2, r5}
	beq _02164750
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r6, [sp, #0x10]
	str r7, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r1, [r9, #0x90c]
	mov r3, r2
	add r0, r9, #8
	bl Vi3dObject__Func_216763C
	ldrh r1, [r4, #0xa]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _021646F4
	mov r1, #0
	str r1, [sp]
	mov r3, r1
	add r0, r9, #8
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
_021646F4:
	ldrh r1, [r4, #0xc]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _02164720
	mov r1, #0
	str r1, [sp]
	mov r3, r1
	add r0, r9, #8
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167A80
_02164720:
	ldrh r1, [r4, #0xe]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _0216480C
	mov r1, #0
	str r1, [sp]
	mov r3, r1
	add r0, r9, #8
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167A0C
	b _0216480C
_02164750:
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r6, [sp, #0x10]
	str r7, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r1, [r9, #0x90c]
	mov r3, r2
	add r0, r9, #8
	bl Vi3dObject__Func_216763C
	ldr r5, _02164914 // =0x0000FFFF
	mov r3, #0
	add r0, r9, #0x308
	add r1, r9, #8
	mov r2, #1
	stmia sp, {r3, r5}
	bl Vi3dObject__Func_2167704
	mov r1, #0
	str r1, [sp]
	mov r3, r1
	add r0, r9, #0x308
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
	mov r1, #0
	str r1, [sp]
	add r0, r9, #0x308
	mov r2, #1
	mov r3, r1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167A0C
	mov r3, #0
	add r0, r9, #0x208
	str r3, [sp]
	mov r1, r5
	str r1, [sp, #4]
	add r0, r0, #0x400
	add r1, r9, #8
	mov r2, #2
	bl Vi3dObject__Func_2167704
	mov r3, #0
	add r0, r9, #0x208
	mov r1, #1
	str r3, [sp]
	add r0, r0, #0x400
	mov r2, r1
	str r3, [sp, #4]
	bl Vi3dObject__Func_2167900
_0216480C:
	mov r0, #1
	str r0, [r9, #0x908]
_02164814:
	ldrh r1, [r4, #4]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _021648F8
	ldr r2, [r9, #0xc24]
	ldr r0, _02164910 // =aBbViDockBb_0
	mov r5, #0
	bl BundleFileUnknown__LoadFileFromBundle
	cmp r8, #0
	bne _0216485C
	ldrh r1, [r4, #6]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _0216485C
	ldr r2, [r9, #0xc28]
	ldr r0, _02164910 // =aBbViDockBb_0
	bl BundleFileUnknown__LoadFileFromBundle
	ldr r5, [r9, #0xc28]
_0216485C:
	mov r2, #0
	stmia sp, {r2, r5}
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r0, _02164914 // =0x0000FFFF
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r1, [r9, #0xc24]
	mov r3, r2
	add r0, r9, #0x920
	bl Vi3dObject__Func_216763C
	cmp r8, #0
	bne _021648EC
	ldrh r1, [r4, #6]
	ldr r0, _02164914 // =0x0000FFFF
	cmp r1, r0
	beq _021648C0
	mov r1, #0
	str r1, [sp]
	mov r3, r1
	add r0, r9, #0x920
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
_021648C0:
	mov r1, #0
	ldr r2, [r4, #0x14]
	add r0, sp, #0x1c
	mov r3, r1
	bl CPPHelpers__VEC_Set
	add r0, sp, #0x1c
	bl CPPHelpers__Func_2085F98
	add r2, r9, #0x128
	mov r1, r0
	add r0, r2, #0x800
	bl CPPHelpers__VEC_Copy_Alt
_021648EC:
	mov r0, #1
	str r0, [r9, #0x91c]
	b _02164900
_021648F8:
	mov r0, #0
	str r0, [r9, #0x91c]
_02164900:
	mov r0, #1
	str r0, [r9, #0xc20]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02164910: .word aBbViDockBb_0
_02164914: .word 0x0000FFFF
	arm_func_end ViDockBack__LoadAssets

	arm_func_start ViDockBack__Func_2164918
ViDockBack__Func_2164918: // 0x02164918
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl ViDockBack__Func_2164968
	add r2, r5, #0x2c
	str r4, [r5, #4]
	str r5, [r5, #0xcf8]
	ldr r1, _02164950 // =ViDockBack__Func_2166540
	add r0, r2, #0xc00
	add r2, r2, #0xc00
	mov r3, #0x14
	str r4, [r5, #0xcfc]
	bl CreateThreadWorker
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02164950: .word ViDockBack__Func_2166540
	arm_func_end ViDockBack__Func_2164918

	arm_func_start ViDockBack__Func_2164954
ViDockBack__Func_2164954: // 0x02164954
	ldr ip, _02164964 // =IsThreadWorkerFinished
	add r0, r0, #0x2c
	add r0, r0, #0xc00
	bx ip
	.align 2, 0
_02164964: .word IsThreadWorkerFinished
	arm_func_end ViDockBack__Func_2164954

	arm_func_start ViDockBack__Func_2164968
ViDockBack__Func_2164968: // 0x02164968
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x2c
	add r0, r0, #0xc00
	bl JoinThreadWorker
	ldr r0, [r4, #0x908]
	cmp r0, #0
	beq _021649AC
	add r0, r4, #8
	bl Vi3dObject__Func_21677C4
	add r0, r4, #0x308
	bl Vi3dObject__Func_21677C4
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl Vi3dObject__Func_21677C4
	mov r0, #0
	str r0, [r4, #0x908]
_021649AC:
	ldr r0, [r4, #0xc20]
	cmp r0, #0
	beq _021649C8
	add r0, r4, #0x920
	bl Vi3dObject__Func_21677C4
	mov r0, #0
	str r0, [r4, #0xc20]
_021649C8:
	mov r0, #0
	str r0, [r4, #0x91c]
	mov r0, #9
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}
	arm_func_end ViDockBack__Func_2164968

	arm_func_start ViDockBack__Func_21649DC
ViDockBack__Func_21649DC: // 0x021649DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x908]
	cmp r0, #0
	beq _02164A18
	add r0, r4, #8
	bl Vi3dObject__Func_2167ADC
	ldr r0, [r4, #4]
	cmp r0, #6
	bne _02164A18
	add r0, r4, #0x308
	bl Vi3dObject__Func_2167ADC
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl Vi3dObject__Func_2167ADC
_02164A18:
	ldr r0, [r4, #0x91c]
	cmp r0, #0
	ldrne r0, [r4, #0xc20]
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x920
	bl Vi3dObject__Func_2167ADC
	ldmia sp!, {r4, pc}
	arm_func_end ViDockBack__Func_21649DC

	arm_func_start ViDockBack__Func_2164A38
ViDockBack__Func_2164A38: // 0x02164A38
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	add r0, r5, #0x128
	add r0, r0, #0x800
	mov r4, r1
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	add r0, r5, #0x128
	str r1, [sp]
	str r4, [sp, #4]
	add r0, r0, #0x800
	bl CPPHelpers__Func_2085F9C
	ldr r2, [r0, #8]
	add r0, r5, #0x128
	add r1, sp, #0
	add r0, r0, #0x800
	str r2, [sp, #8]
	bl CPPHelpers__VEC_Copy_Alt
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end ViDockBack__Func_2164A38

	arm_func_start ViDockBack__Func_2164A8C
ViDockBack__Func_2164A8C: // 0x02164A8C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	str r1, [sp, #8]
	str r1, [sp, #4]
	str r1, [sp]
	add r1, sp, #0
	add r0, r0, #0x940
	bl CPPHelpers__VEC_Copy_Alt
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ViDockBack__Func_2164A8C

	arm_func_start ViDockBack__Func_2164AB4
ViDockBack__Func_2164AB4: // 0x02164AB4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #0x908]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp r0, #0
	beq _02164B28
	strh r6, [r7, #0x40]
	strh r5, [r7, #0x48]
	strh r4, [r7, #0x4a]
	add r0, r7, #8
	bl Vi3dObject__Func_2167B98
	ldr r0, [r7, #4]
	cmp r0, #6
	bne _02164B28
	add r1, r7, #0x300
	strh r6, [r1, #0x40]
	strh r5, [r1, #0x48]
	add r0, r7, #0x308
	strh r4, [r1, #0x4a]
	bl Vi3dObject__Func_2167B98
	add r1, r7, #0x600
	strh r6, [r1, #0x40]
	add r0, r7, #0x208
	strh r5, [r1, #0x48]
	add r0, r0, #0x400
	strh r4, [r1, #0x4a]
	bl Vi3dObject__Func_2167B98
_02164B28:
	ldr r0, [r7, #0x91c]
	cmp r0, #0
	ldrne r0, [r7, #0xc20]
	cmpne r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r1, r7, #0x900
	strh r6, [r1, #0x58]
	strh r5, [r1, #0x60]
	add r0, r7, #0x920
	strh r4, [r1, #0x62]
	bl Vi3dObject__Func_2167B98
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ViDockBack__Func_2164AB4

	arm_func_start ViDockBack__Func_2164B58
ViDockBack__Func_2164B58: // 0x02164B58
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr lr, [sp, #0x14]
	ldr ip, [sp, #0x18]
	str lr, [sp]
	str ip, [sp, #4]
	ldr lr, [r0, #4]
	ldr ip, _02164B98 // =_02173774
	mov r0, r1
	mov r1, r2
	mov r2, r3
	ldr r3, [sp, #0x10]
	ldr ip, [ip, lr, lsl #2]
	blx ip
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164B98: .word _02173774
	arm_func_end ViDockBack__Func_2164B58

	arm_func_start ViDockBack__Func_2164B9C
ViDockBack__Func_2164B9C: // 0x02164B9C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #4]
	ldr r1, _02164BC4 // =_02173790
	add r0, sp, #0xc
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldmia sp!, {r3, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02164BC4: .word _02173790
	arm_func_end ViDockBack__Func_2164B9C

	arm_func_start ViDockBack__Func_2164BC8
ViDockBack__Func_2164BC8: // 0x02164BC8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #4]
	ldr r1, _02164BF0 // =_021737C8
	add r0, sp, #0xc
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldmia sp!, {r3, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02164BF0: .word _021737C8
	arm_func_end ViDockBack__Func_2164BC8

	arm_func_start ViDockBack__Func_2164BF4
ViDockBack__Func_2164BF4: // 0x02164BF4
	stmdb sp!, {r3, lr}
	ldr lr, [r0, #4]
	ldr ip, _02164C1C // =_021737E4
	mov r0, r1
	mov r1, r2
	mov r2, r3
	ldr r3, [sp, #8]
	ldr ip, [ip, lr, lsl #2]
	blx ip
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164C1C: .word _021737E4
	arm_func_end ViDockBack__Func_2164BF4

	arm_func_start ViDockBack__Func_2164C20
ViDockBack__Func_2164C20: // 0x02164C20
	stmdb sp!, {r3, lr}
	ldr ip, _02164C40 // =_021737AC
	ldr ip, [ip, r0, lsl #2]
	mov r0, r1
	mov r1, r2
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164C40: .word _021737AC
	arm_func_end ViDockBack__Func_2164C20

	arm_func_start ViDockBack__Func_2164C44
ViDockBack__Func_2164C44: // 0x02164C44
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	mov r6, r2
	ldr r2, [sp, #0x30]
	ldr r5, [sp, #0x34]
	mov r4, #0
	cmp r3, #0
	strne r4, [r3]
	mov r7, r1
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	cmp r5, #0
	movne r1, #0
	strne r1, [r5]
	ldr ip, [r7]
	ldr r2, [r0, #0]
	cmp r2, ip
	ldreq r3, [r0, #4]
	ldreq r1, [r7, #4]
	cmpeq r3, r1
	ldreq r3, [r0, #8]
	ldreq r1, [r7, #8]
	cmpeq r3, r1
	bne _02164CC0
	str ip, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [r7, #8]
	str r0, [r6, #8]
	b _02165090
_02164CC0:
	ldr r0, [r0, #8]
	str ip, [sp, #0x14]
	ldr r1, [r7, #8]
	cmp r0, #0x13000
	str r1, [sp, #0x10]
	ble _02164D80
	cmp r1, #0x1a000
	movgt r0, #0x1a000
	strgt r0, [sp, #0x10]
	mov r3, #0x2000
	ldr r0, [sp, #0x14]
	rsb r3, r3, #0
	cmp r0, r3
	bge _02164D34
	ldr r1, [sp, #0x10]
	cmp r1, #0x17000
	strgt r3, [sp, #0x14]
	bgt _0216503C
	mov r2, #0x17000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x1d000
	str ip, [sp, #8]
	mov ip, #0x13000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _0216503C
_02164D34:
	cmp r0, #0x2000
	ble _0216503C
	ldr r1, [sp, #0x10]
	cmp r1, #0x17000
	movgt r0, #0x2000
	strgt r0, [sp, #0x14]
	bgt _0216503C
	mov r2, #0x6000
	str r2, [sp]
	mov r2, #0x13000
	str r2, [sp, #4]
	mov ip, #0x2000
	str ip, [sp, #8]
	mov ip, #0x17000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _0216503C
_02164D80:
	mov r3, #0xa000
	rsb r3, r3, #0
	cmp r2, r3
	bge _02164DC4
	cmp r1, #0x13000
	movgt r0, #0x13000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	cmp r0, #0xc000
	movlt r0, #0xc000
	strlt r0, [sp, #0x10]
	mov r0, #0xf000
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	b _0216503C
_02164DC4:
	cmp r2, #0x8000
	bge _02164EA0
	cmp r1, #0x13000
	ble _02164E6C
	add r0, r3, #0x4000
	cmp ip, r0
	blt _02164DE8
	cmp ip, #0x6000
	ble _02164DF4
_02164DE8:
	mov r0, #0x13000
	str r0, [sp, #0x10]
	b _02164E6C
_02164DF4:
	add r0, r3, #0x8000
	cmp ip, r0
	bge _02164E34
	mov r2, r0
	mov r0, #0x17000
	str r2, [sp]
	str r0, [sp, #4]
	sub lr, r0, #0x1d000
	mov r0, ip
	add r2, sp, #0x14
	add r3, sp, #0x10
	str lr, [sp, #8]
	mov ip, #0x13000
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02164E6C
_02164E34:
	cmp ip, #0x2000
	ble _02164E6C
	mov r0, #0x6000
	str r0, [sp]
	mov r0, #0x13000
	str r0, [sp, #4]
	mov lr, #0x2000
	mov r0, ip
	add r2, sp, #0x14
	add r3, sp, #0x10
	str lr, [sp, #8]
	mov ip, #0x17000
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02164E6C:
	ldr r0, [sp, #0x10]
	cmp r0, #0x5000
	movlt r0, #0x5000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0xc000
	bge _0216503C
	mov r0, #0xa000
	ldr r1, [sp, #0x14]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	b _0216503C
_02164EA0:
	cmp r0, #0x4000
	ble _02164F1C
	cmp r1, #0x13000
	movgt r0, #0x13000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	cmp r0, #0x10000
	ble _02164F00
	ldr r1, [sp, #0x10]
	cmp r1, #0x8000
	movgt r0, #0x10000
	strgt r0, [sp, #0x14]
	bgt _02164F00
	mov r2, #0x14000
	str r2, [sp]
	mov r2, #0x4000
	str r2, [sp, #4]
	mov ip, #0x10000
	str ip, [sp, #8]
	mov ip, #0x8000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02164F00:
	ldr r0, [sp, #0x10]
	cmp r0, #0x5000
	ldrlt r0, [sp, #0x14]
	cmplt r0, #0x9000
	movlt r0, #0x9000
	strlt r0, [sp, #0x14]
	b _0216503C
_02164F1C:
	cmp r2, #0x10000
	ble _02164FCC
	ldr r1, [sp, #0x10]
	cmp ip, #0x19000
	movgt r0, #0x19000
	strgt r0, [sp, #0x14]
	cmp r1, #0x4000
	ble _02164F7C
	ldr r0, [sp, #0x14]
	cmp r0, #0x14000
	movgt r0, #0x4000
	strgt r0, [sp, #0x10]
	bgt _02164F7C
	mov r2, #0x14000
	str r2, [sp]
	mov r2, #0x4000
	str r2, [sp, #4]
	mov ip, #0x10000
	str ip, [sp, #8]
	mov ip, #0x8000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02164F7C:
	mov ip, #0x2000
	ldr r1, [sp, #0x10]
	rsb ip, ip, #0
	cmp r1, ip
	bge _0216503C
	ldr r0, [sp, #0x14]
	cmp r0, #0x14000
	strgt ip, [sp, #0x10]
	bgt _0216503C
	mov r2, #0x10000
	str r2, [sp]
	sub r2, r2, #0x16000
	str r2, [sp, #4]
	mov r2, #0x14000
	str r2, [sp, #8]
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _0216503C
_02164FCC:
	cmp ip, #0x9000
	movlt r0, #0x9000
	strlt r0, [sp, #0x14]
	mov r0, #0x6000
	mov r2, #0x2000
	ldr r1, [sp, #0x10]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x10]
	ldr r1, [sp, #0x10]
	rsb r2, r2, #0
	cmp r1, r2
	bge _0216503C
	sub r0, r2, #0x4000
	cmp r1, r0
	mov r0, #0x10000
	strlt r0, [sp, #0x14]
	blt _0216503C
	str r0, [sp]
	sub r0, r0, #0x16000
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r0, [sp, #0x14]
	add r2, sp, #0x14
	add r3, sp, #0x10
	bl Unknown2051334__Func_2051450
_0216503C:
	ldr r0, [sp, #0x14]
	str r0, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [sp, #0x10]
	str r0, [r6, #8]
	ldr r2, [r6, #0]
	ldr r0, [r7, #0]
	cmp r2, r0
	ldreq r1, [r6, #4]
	ldreq r0, [r7, #4]
	cmpeq r1, r0
	ldreq r1, [r6, #8]
	ldreq r0, [r7, #8]
	cmpeq r1, r0
	movne r4, #1
	cmp r2, #0x17000
	blt _02165090
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
_02165090:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ViDockBack__Func_2164C44

	arm_func_start ViDockBack__Func_216509C
ViDockBack__Func_216509C: // 0x0216509C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	mov r6, r2
	ldr r2, [sp, #0x30]
	ldr r5, [sp, #0x34]
	mov r4, #0
	cmp r3, #0
	strne r4, [r3]
	mov r7, r1
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	cmp r5, #0
	movne r1, #1
	strne r1, [r5]
	ldr ip, [r7]
	ldr r1, [r0, #0]
	cmp r1, ip
	ldreq r3, [r0, #4]
	ldreq r2, [r7, #4]
	cmpeq r3, r2
	ldreq r2, [r0, #8]
	ldreq r0, [r7, #8]
	cmpeq r2, r0
	bne _02165118
	str ip, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [r7, #8]
	str r0, [r6, #8]
	b _0216525C
_02165118:
	str ip, [sp, #0x14]
	ldr r2, [r7, #8]
	mov r0, #0x3000
	rsb r0, r0, #0
	str r2, [sp, #0x10]
	cmp r2, r0
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	mov r3, #0xe000
	cmp r0, #0x10000
	movgt r0, #0x10000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	rsb r3, r3, #0
	cmp r0, #0xe000
	movgt r0, #0xe000
	strgt r0, [sp, #0x14]
	cmp r1, r3
	bge _021651B4
	ldr r1, [sp, #0x10]
	cmp r1, #0x3000
	ble _02165200
	ldr r0, [sp, #0x14]
	sub r2, r3, #0x4000
	cmp r0, r2
	movlt r0, #0x3000
	strlt r0, [sp, #0x10]
	blt _02165200
	mov r2, #0x7000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x19000
	str ip, [sp, #8]
	mov ip, #0x3000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02165200
_021651B4:
	ldr r0, [sp, #0x14]
	cmp r0, r3
	bge _02165200
	ldr r1, [sp, #0x10]
	cmp r1, #0x3000
	ble _02165200
	cmp r1, #0x7000
	strgt r3, [sp, #0x14]
	bgt _02165200
	mov r2, #0x7000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x19000
	str ip, [sp, #8]
	mov ip, #0x3000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165200:
	ldr r0, [sp, #0x14]
	str r0, [r6]
	ldr r0, [r7, #4]
	str r0, [r6, #4]
	ldr r0, [sp, #0x10]
	str r0, [r6, #8]
	ldr r2, [r6, #0]
	ldr r0, [r7, #0]
	cmp r2, r0
	ldreq r1, [r6, #4]
	ldreq r0, [r7, #4]
	cmpeq r1, r0
	ldreq r1, [r6, #8]
	ldreq r0, [r7, #8]
	cmpeq r1, r0
	mov r0, #0x16000
	rsb r0, r0, #0
	movne r4, #1
	cmp r2, r0
	bgt _0216525C
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
_0216525C:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ViDockBack__Func_216509C

	arm_func_start ViDockBack__Func_2165268
ViDockBack__Func_2165268: // 0x02165268
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x18
	ldr r6, [sp, #0x38]
	mov r8, r2
	movs r7, r3
	mov r4, #0
	strne r4, [r7]
	ldr r2, [sp, #0x3c]
	mov r9, r1
	cmp r6, #0
	movne r1, #0
	strne r1, [r6]
	cmp r2, #0
	movne r1, #2
	strne r1, [r2]
	ldr r1, [r9, #0]
	ldr r5, [r0, #0]
	cmp r5, r1
	ldreq r3, [r0, #4]
	ldreq r2, [r9, #4]
	cmpeq r3, r2
	ldreq r3, [r0, #8]
	ldreq r2, [r9, #8]
	cmpeq r3, r2
	bne _021652E4
	str r1, [r8]
	ldr r0, [r9, #4]
	str r0, [r8, #4]
	ldr r0, [r9, #8]
	str r0, [r8, #8]
	b _02165478
_021652E4:
	ldr r2, [r0, #8]
	str r1, [sp, #0x14]
	ldr r0, [r9, #8]
	cmp r2, #0x2f000
	str r0, [sp, #0x10]
	ble _0216536C
	cmp r0, #0x5e000
	movgt r0, #0x5e000
	strgt r0, [sp, #0x10]
	mov r0, #0x21000
	mov r5, #0x1a000
	ldr r1, [sp, #0x14]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	rsb r5, r5, #0
	cmp r0, r5
	ble _02165438
	ldr r1, [sp, #0x10]
	cmp r1, #0x37000
	strgt r5, [sp, #0x14]
	bgt _02165438
	add r2, r5, #0x6000
	str r2, [sp]
	mov r2, #0x2f000
	str r2, [sp, #4]
	str r5, [sp, #8]
	mov r5, #0x37000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str r5, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02165438
_0216536C:
	mov r0, #0x21000
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	cmp r0, #0x20000
	movgt r0, #0x20000
	strgt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0x12000
	bge _021653AC
	mov r0, #0x12000
	str r0, [sp, #0x10]
	cmp r6, #0
	movne r0, #1
	strne r0, [r6]
_021653AC:
	mov ip, #0x1a000
	ldr r0, [sp, #0x14]
	rsb ip, ip, #0
	cmp r0, ip
	ldrgt r1, [sp, #0x10]
	cmpgt r1, #0x2f000
	ble _02165400
	add r2, ip, #0x6000
	cmp r0, r2
	movgt r0, #0x2f000
	strgt r0, [sp, #0x10]
	bgt _02165400
	str r2, [sp]
	mov r2, #0x2f000
	str r2, [sp, #4]
	str ip, [sp, #8]
	mov ip, #0x37000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165400:
	cmp r5, #0xa000
	bgt _02165428
	ldr r0, [sp, #0x14]
	cmp r0, #0xa000
	ble _02165438
	ldr r0, [sp, #0x10]
	cmp r0, #0x1d000
	movlt r0, #0xa000
	strlt r0, [sp, #0x14]
	b _02165438
_02165428:
	ldr r0, [sp, #0x10]
	cmp r0, #0x1d000
	movlt r0, #0x1d000
	strlt r0, [sp, #0x10]
_02165438:
	ldr r0, [sp, #0x14]
	str r0, [r8]
	ldr r0, [r9, #4]
	str r0, [r8, #4]
	ldr r0, [sp, #0x10]
	str r0, [r8, #8]
	ldr r1, [r8, #0]
	ldr r0, [r9, #0]
	cmp r1, r0
	ldreq r1, [r8, #4]
	ldreq r0, [r9, #4]
	cmpeq r1, r0
	ldreq r1, [r8, #8]
	ldreq r0, [r9, #8]
	cmpeq r1, r0
	movne r4, #1
_02165478:
	ldr r0, [r8, #8]
	cmp r0, #0x12000
	bgt _021654B0
	mov r0, #0xa000
	ldr r1, [r8, #0]
	rsb r0, r0, #0
	cmp r1, r0
	blt _021654B0
	cmp r1, #0x5000
	bgt _021654B0
	cmp r7, #0
	movne r0, #1
	strne r0, [r7]
	b _021654BC
_021654B0:
	cmp r6, #0
	movne r0, #0
	strne r0, [r6]
_021654BC:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ViDockBack__Func_2165268

	arm_func_start ViDockBack__Func_21654C8
ViDockBack__Func_21654C8: // 0x021654C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r5, [sp, #0x48]
	mov r7, r2
	movs r6, r3
	mov r4, #0
	strne r4, [r6]
	ldr r2, [sp, #0x4c]
	mov r8, r1
	cmp r5, #0
	movne r1, #0
	strne r1, [r5]
	cmp r2, #0
	movne r1, #3
	strne r1, [r2]
	ldr r9, [r8, #0]
	ldr r2, [r0, #0]
	cmp r2, r9
	ldreq r3, [r0, #4]
	ldreq r1, [r8, #4]
	cmpeq r3, r1
	ldreq r3, [r0, #8]
	ldreq r1, [r8, #8]
	cmpeq r3, r1
	bne _02165544
	str r9, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [r8, #8]
	str r0, [r7, #8]
	b _021658E0
_02165544:
	ldr r0, [r0, #8]
	mov r3, #0x19000
	str r9, [sp, #0x1c]
	ldr r1, [r8, #8]
	rsb r3, r3, #0
	str r1, [sp, #0x18]
	cmp r2, r3
	bge _021655DC
	sub r0, r3, #0x77000
	cmp r9, r0
	strlt r0, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x4d000
	bge _021658A0
	mov r1, #0x3e000
	ldr r3, [sp, #0x1c]
	rsb r1, r1, #0
	cmp r3, r1
	ble _021658A0
	add r0, r1, #0x18000
	cmp r3, r0
	bge _021658A0
	cmp r2, r1
	strle r1, [sp, #0x1c]
	ble _021658A0
	cmp r2, r0
	strge r0, [sp, #0x1c]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x18]
	b _021658A0
_021655DC:
	cmp r2, #0x19000
	ble _02165658
	cmp r9, #0x90000
	movgt r0, #0x90000
	strgt r0, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x4d000
	bge _021658A0
	ldr r0, [sp, #0x1c]
	cmp r0, #0x2e000
	ble _021658A0
	cmp r0, #0x46000
	bge _021658A0
	cmp r2, #0x2e000
	movle r0, #0x2e000
	strle r0, [sp, #0x1c]
	ble _021658A0
	cmp r2, #0x46000
	movge r0, #0x46000
	strge r0, [sp, #0x1c]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x18]
	b _021658A0
_02165658:
	cmp r0, #0x76000
	ble _02165708
	add r0, r3, #0xe000
	cmp r9, r0
	bge _021656A8
	cmp r1, #0x7c000
	strgt r0, [sp, #0x1c]
	bgt _021656A8
	mov r2, r0
	mov r0, #0x7c000
	str r2, [sp]
	str r0, [sp, #4]
	sub r10, r0, #0x8d000
	mov r0, r9
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r10, [sp, #8]
	mov r9, #0x76000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_021656A8:
	ldr r0, [sp, #0x1c]
	cmp r0, #0xb000
	ble _021656F4
	ldr r1, [sp, #0x18]
	cmp r1, #0x7c000
	movgt r0, #0xb000
	strgt r0, [sp, #0x1c]
	bgt _021656F4
	mov r2, #0x11000
	str r2, [sp]
	mov r2, #0x76000
	str r2, [sp, #4]
	mov r9, #0xb000
	str r9, [sp, #8]
	mov r9, #0x7c000
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_021656F4:
	ldr r0, [sp, #0x18]
	cmp r0, #0x86000
	movgt r0, #0x86000
	strgt r0, [sp, #0x18]
	b _021658A0
_02165708:
	cmp r0, #0x4d000
	ble _021657B4
	cmp r1, #0x76000
	ble _021658A0
	add r0, r3, #0x8000
	cmp r9, r0
	blt _0216572C
	cmp r9, #0x11000
	ble _02165738
_0216572C:
	mov r0, #0x76000
	str r0, [sp, #0x18]
	b _021658A0
_02165738:
	add r0, r3, #0xe000
	cmp r9, r0
	bge _02165778
	mov r2, r0
	mov r0, #0x7c000
	str r2, [sp]
	str r0, [sp, #4]
	sub r10, r0, #0x8d000
	mov r0, r9
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r10, [sp, #8]
	mov r9, #0x76000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _021658A0
_02165778:
	cmp r9, #0xb000
	ble _021658A0
	mov r0, #0x11000
	str r0, [sp]
	mov r0, #0x76000
	str r0, [sp, #4]
	mov r10, #0xb000
	mov r0, r9
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r10, [sp, #8]
	mov r9, #0x7c000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _021658A0
_021657B4:
	cmp r1, #0x31000
	bge _021657D0
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
	mov r0, #0x31000
	str r0, [sp, #0x18]
_021657D0:
	ldr r0, [sp, #0x1c]
	mov r3, #0x16000
	cmp r0, #0
	rsblt r0, r0, #0
	strlt r0, [sp, #0x1c]
	ldr r0, [sp, #0x1c]
	mov r2, #0x800
	sub r10, r0, #0x19000
	sub ip, r2, #0x10800
	mvn r2, #0
	rsb r3, r3, #0
	str r0, [sp, #0x14]
	umull r0, lr, r10, r3
	mov r11, #0
	movlt r11, #1
	adds r0, r0, #0x800
	mla lr, r10, r2, lr
	mov r9, r10, asr #0x1f
	mla lr, r9, r3, lr
	str r2, [sp, #0x10]
	ldr r1, [sp, #0x18]
	adc r2, lr, #0
	sub lr, r1, #0x47000
	mov r0, r0, lsr #0xc
	orr r0, r0, r2, lsl #20
	ldr r2, [sp, #0x10]
	umull r10, r9, lr, ip
	mla r9, lr, r2, r9
	mov r3, lr, asr #0x1f
	mla r9, r3, ip, r9
	adds r3, r10, #0x800
	adc r2, r9, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	subs r0, r0, r3
	bpl _02165890
	ldr r0, [sp, #0x14]
	add r9, sp, #0x18
	str r0, [sp]
	str r1, [sp, #4]
	add r0, sp, #0x1c
	str r0, [sp, #8]
	mov r0, #0x19000
	mov r1, #0x47000
	mov r2, #0x9000
	mov r3, #0x31000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051334
_02165890:
	cmp r11, #0
	ldrne r0, [sp, #0x1c]
	rsbne r0, r0, #0
	strne r0, [sp, #0x1c]
_021658A0:
	ldr r0, [sp, #0x1c]
	str r0, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [sp, #0x18]
	str r0, [r7, #8]
	ldr r1, [r7, #0]
	ldr r0, [r8, #0]
	cmp r1, r0
	ldreq r1, [r7, #4]
	ldreq r0, [r8, #4]
	cmpeq r1, r0
	ldreq r1, [r7, #8]
	ldreq r0, [r8, #8]
	cmpeq r1, r0
	movne r4, #1
_021658E0:
	ldr r0, [r7, #8]
	cmp r0, #0x31000
	bgt _021658FC
	cmp r6, #0
	movne r0, #1
	strne r0, [r6]
	b _02165908
_021658FC:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
_02165908:
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ViDockBack__Func_21654C8

	arm_func_start ViDockBack__Func_2165914
ViDockBack__Func_2165914: // 0x02165914
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r5, [sp, #0x48]
	mov r7, r2
	movs r6, r3
	mov r4, #0
	strne r4, [r6]
	ldr r2, [sp, #0x4c]
	mov r8, r1
	cmp r5, #0
	movne r1, #0
	strne r1, [r5]
	cmp r2, #0
	movne r1, #4
	strne r1, [r2]
	ldr r9, [r8, #0]
	ldr r2, [r0, #0]
	cmp r2, r9
	ldreq r3, [r0, #4]
	ldreq r1, [r8, #4]
	cmpeq r3, r1
	ldreq r3, [r0, #8]
	ldreq r1, [r8, #8]
	cmpeq r3, r1
	bne _02165990
	str r9, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [r8, #8]
	str r0, [r7, #8]
	b _02165D2C
_02165990:
	ldr r0, [r0, #8]
	mov r3, #0x19000
	str r9, [sp, #0x1c]
	ldr r1, [r8, #8]
	rsb r3, r3, #0
	str r1, [sp, #0x18]
	cmp r2, r3
	bge _02165A28
	sub r0, r3, #0x63000
	cmp r9, r0
	strlt r0, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x4d000
	bge _02165CEC
	mov r1, #0x3e000
	ldr r3, [sp, #0x1c]
	rsb r1, r1, #0
	cmp r3, r1
	ble _02165CEC
	add r0, r1, #0x18000
	cmp r3, r0
	bge _02165CEC
	cmp r2, r1
	strle r1, [sp, #0x1c]
	ble _02165CEC
	cmp r2, r0
	strge r0, [sp, #0x1c]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x18]
	b _02165CEC
_02165A28:
	cmp r2, #0x19000
	ble _02165AA4
	cmp r9, #0x54000
	movgt r0, #0x54000
	strgt r0, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x18]
	ldr r0, [sp, #0x18]
	cmp r0, #0x4d000
	bge _02165CEC
	ldr r0, [sp, #0x1c]
	cmp r0, #0x2e000
	ble _02165CEC
	cmp r0, #0x46000
	bge _02165CEC
	cmp r2, #0x2e000
	movle r0, #0x2e000
	strle r0, [sp, #0x1c]
	ble _02165CEC
	cmp r2, #0x46000
	movge r0, #0x46000
	strge r0, [sp, #0x1c]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x18]
	b _02165CEC
_02165AA4:
	cmp r0, #0x76000
	ble _02165B54
	add r0, r3, #0xe000
	cmp r9, r0
	bge _02165AF4
	cmp r1, #0x7c000
	strgt r0, [sp, #0x1c]
	bgt _02165AF4
	mov r2, r0
	mov r0, #0x7c000
	str r2, [sp]
	str r0, [sp, #4]
	sub r10, r0, #0x8d000
	mov r0, r9
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r10, [sp, #8]
	mov r9, #0x76000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165AF4:
	ldr r0, [sp, #0x1c]
	cmp r0, #0xb000
	ble _02165B40
	ldr r1, [sp, #0x18]
	cmp r1, #0x7c000
	movgt r0, #0xb000
	strgt r0, [sp, #0x1c]
	bgt _02165B40
	mov r2, #0x11000
	str r2, [sp]
	mov r2, #0x76000
	str r2, [sp, #4]
	mov r9, #0xb000
	str r9, [sp, #8]
	mov r9, #0x7c000
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165B40:
	ldr r0, [sp, #0x18]
	cmp r0, #0x86000
	movgt r0, #0x86000
	strgt r0, [sp, #0x18]
	b _02165CEC
_02165B54:
	cmp r0, #0x4d000
	ble _02165C00
	cmp r1, #0x76000
	ble _02165CEC
	add r0, r3, #0x8000
	cmp r9, r0
	blt _02165B78
	cmp r9, #0x11000
	ble _02165B84
_02165B78:
	mov r0, #0x76000
	str r0, [sp, #0x18]
	b _02165CEC
_02165B84:
	add r0, r3, #0xe000
	cmp r9, r0
	bge _02165BC4
	mov r2, r0
	mov r0, #0x7c000
	str r2, [sp]
	str r0, [sp, #4]
	sub r10, r0, #0x8d000
	mov r0, r9
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r10, [sp, #8]
	mov r9, #0x76000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02165CEC
_02165BC4:
	cmp r9, #0xb000
	ble _02165CEC
	mov r0, #0x11000
	str r0, [sp]
	mov r0, #0x76000
	str r0, [sp, #4]
	mov r10, #0xb000
	mov r0, r9
	add r2, sp, #0x1c
	add r3, sp, #0x18
	str r10, [sp, #8]
	mov r9, #0x7c000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02165CEC
_02165C00:
	cmp r1, #0x31000
	bge _02165C1C
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
	mov r0, #0x31000
	str r0, [sp, #0x18]
_02165C1C:
	ldr r0, [sp, #0x1c]
	mov r3, #0x16000
	cmp r0, #0
	rsblt r0, r0, #0
	strlt r0, [sp, #0x1c]
	ldr r0, [sp, #0x1c]
	mov r2, #0x800
	sub r10, r0, #0x19000
	sub ip, r2, #0x10800
	mvn r2, #0
	rsb r3, r3, #0
	str r0, [sp, #0x14]
	umull r0, lr, r10, r3
	mov r11, #0
	movlt r11, #1
	adds r0, r0, #0x800
	mla lr, r10, r2, lr
	mov r9, r10, asr #0x1f
	mla lr, r9, r3, lr
	str r2, [sp, #0x10]
	ldr r1, [sp, #0x18]
	adc r2, lr, #0
	sub lr, r1, #0x47000
	mov r0, r0, lsr #0xc
	orr r0, r0, r2, lsl #20
	ldr r2, [sp, #0x10]
	umull r10, r9, lr, ip
	mla r9, lr, r2, r9
	mov r3, lr, asr #0x1f
	mla r9, r3, ip, r9
	adds r3, r10, #0x800
	adc r2, r9, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	subs r0, r0, r3
	bpl _02165CDC
	ldr r0, [sp, #0x14]
	add r9, sp, #0x18
	str r0, [sp]
	str r1, [sp, #4]
	add r0, sp, #0x1c
	str r0, [sp, #8]
	mov r0, #0x19000
	mov r1, #0x47000
	mov r2, #0x9000
	mov r3, #0x31000
	str r9, [sp, #0xc]
	bl Unknown2051334__Func_2051334
_02165CDC:
	cmp r11, #0
	ldrne r0, [sp, #0x1c]
	rsbne r0, r0, #0
	strne r0, [sp, #0x1c]
_02165CEC:
	ldr r0, [sp, #0x1c]
	str r0, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [sp, #0x18]
	str r0, [r7, #8]
	ldr r1, [r7, #0]
	ldr r0, [r8, #0]
	cmp r1, r0
	ldreq r1, [r7, #4]
	ldreq r0, [r8, #4]
	cmpeq r1, r0
	ldreq r1, [r7, #8]
	ldreq r0, [r8, #8]
	cmpeq r1, r0
	movne r4, #1
_02165D2C:
	ldr r0, [r7, #8]
	cmp r0, #0x31000
	bgt _02165D48
	cmp r6, #0
	movne r0, #1
	strne r0, [r6]
	b _02165D54
_02165D48:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
_02165D54:
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ViDockBack__Func_2165914

	arm_func_start ViDockBack__Func_2165D60
ViDockBack__Func_2165D60: // 0x02165D60
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	ldr r5, [sp, #0x30]
	mov r7, r2
	movs r6, r3
	mov r4, #0
	strne r4, [r6]
	ldr r2, [sp, #0x34]
	mov r8, r1
	cmp r5, #0
	movne r1, #0
	strne r1, [r5]
	cmp r2, #0
	movne r1, #5
	strne r1, [r2]
	ldr ip, [r8]
	ldr r1, [r0, #0]
	cmp r1, ip
	ldreq r3, [r0, #4]
	ldreq r2, [r8, #4]
	cmpeq r3, r2
	ldreq r3, [r0, #8]
	ldreq r2, [r8, #8]
	cmpeq r3, r2
	bne _02165DDC
	str ip, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [r8, #8]
	str r0, [r7, #8]
	b _02166124
_02165DDC:
	ldr r3, [r0, #8]
	str ip, [sp, #0x14]
	ldr r0, [r8, #8]
	cmp r3, #0x1e000
	str r0, [sp, #0x10]
	blt _02165E04
	cmp r3, #0x3c000
	suble r0, r0, r3
	addle r0, r3, r0, asr #1
	strle r0, [sp, #0x10]
_02165E04:
	mov r2, #0x19000
	rsb r2, r2, #0
	cmp r1, r2
	bge _02165E90
	ldr r3, [sp, #0x14]
	sub r0, r2, #0x3b000
	cmp r3, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x4d000
	bge _021660E4
	mov r2, #0x3e000
	ldr r3, [sp, #0x14]
	rsb r2, r2, #0
	cmp r3, r2
	ble _021660E4
	add r0, r2, #0x18000
	cmp r3, r0
	bge _021660E4
	cmp r1, r2
	strle r2, [sp, #0x14]
	ble _021660E4
	cmp r1, r0
	strge r0, [sp, #0x14]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x10]
	b _021660E4
_02165E90:
	cmp r1, #0x19000
	ble _02165F10
	ldr r0, [sp, #0x14]
	cmp r0, #0x54000
	movgt r0, #0x54000
	strgt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0x76000
	movgt r0, #0x76000
	strgt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0x4d000
	bge _021660E4
	ldr r0, [sp, #0x14]
	cmp r0, #0x2e000
	ble _021660E4
	cmp r0, #0x46000
	bge _021660E4
	cmp r1, #0x2e000
	movle r0, #0x2e000
	strle r0, [sp, #0x14]
	ble _021660E4
	cmp r1, #0x46000
	movge r0, #0x46000
	strge r0, [sp, #0x14]
	movlt r0, #0x4d000
	strlt r0, [sp, #0x10]
	b _021660E4
_02165F10:
	cmp r3, #0x76000
	ble _02165FC8
	ldr r0, [sp, #0x14]
	add r1, r2, #0x10000
	cmp r0, r1
	bge _02165F68
	ldr r1, [sp, #0x10]
	cmp r1, #0x7c000
	addgt r0, r2, #0x10000
	strgt r0, [sp, #0x14]
	bgt _02165F68
	add r3, r2, #0x10000
	mov r2, #0x7c000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x8a000
	str ip, [sp, #8]
	mov ip, #0x76000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165F68:
	ldr r0, [sp, #0x14]
	cmp r0, #0x9000
	ble _02165FB4
	ldr r1, [sp, #0x10]
	cmp r1, #0x7c000
	movgt r0, #0x9000
	strgt r0, [sp, #0x14]
	bgt _02165FB4
	mov r2, #0xe000
	str r2, [sp]
	mov r2, #0x76000
	str r2, [sp, #4]
	mov ip, #0x9000
	str ip, [sp, #8]
	mov ip, #0x7c000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02165FB4:
	ldr r0, [sp, #0x10]
	cmp r0, #0x86000
	movgt r0, #0x86000
	strgt r0, [sp, #0x10]
	b _021660E4
_02165FC8:
	cmp r3, #0x4d000
	ble _02166070
	ldr r1, [sp, #0x10]
	cmp r1, #0x76000
	ble _021660E4
	ldr r0, [sp, #0x14]
	add r3, r2, #0xb000
	cmp r0, r3
	blt _02165FF4
	cmp r0, #0xe000
	ble _02166000
_02165FF4:
	mov r0, #0x76000
	str r0, [sp, #0x10]
	b _021660E4
_02166000:
	add r3, r2, #0x10000
	cmp r0, r3
	bge _02166038
	mov r2, #0x7c000
	str r3, [sp]
	str r2, [sp, #4]
	sub ip, r2, #0x8a000
	str ip, [sp, #8]
	mov ip, #0x76000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _021660E4
_02166038:
	cmp r0, #0x9000
	ble _021660E4
	mov r2, #0xe000
	str r2, [sp]
	mov r2, #0x76000
	str r2, [sp, #4]
	mov ip, #0x9000
	str ip, [sp, #8]
	mov ip, #0x7c000
	add r2, sp, #0x14
	add r3, sp, #0x10
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _021660E4
_02166070:
	cmp r3, #0x47000
	bge _021660BC
	ldr r1, [sp, #0x14]
	add r0, r2, #0xf000
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	cmp r0, #0xa000
	movgt r0, #0xa000
	strgt r0, [sp, #0x14]
	ldr r0, [sp, #0x10]
	cmp r0, #0xa000
	bge _021660E4
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
	mov r0, #0xa000
	str r0, [sp, #0x10]
	b _021660E4
_021660BC:
	ldr r1, [sp, #0x14]
	add r0, r2, #0xf000
	cmp r1, r0
	blt _021660D4
	cmp r1, #0xa000
	ble _021660E4
_021660D4:
	ldr r0, [sp, #0x10]
	cmp r0, #0x47000
	movlt r0, #0x47000
	strlt r0, [sp, #0x10]
_021660E4:
	ldr r0, [sp, #0x14]
	str r0, [r7]
	ldr r0, [r8, #4]
	str r0, [r7, #4]
	ldr r0, [sp, #0x10]
	str r0, [r7, #8]
	ldr r1, [r7, #0]
	ldr r0, [r8, #0]
	cmp r1, r0
	ldreq r1, [r7, #4]
	ldreq r0, [r8, #4]
	cmpeq r1, r0
	ldreq r1, [r7, #8]
	ldreq r0, [r8, #8]
	cmpeq r1, r0
	movne r4, #1
_02166124:
	ldr r0, [r7, #8]
	cmp r0, #0xa000
	bgt _02166140
	cmp r6, #0
	movne r0, #1
	strne r0, [r6]
	b _0216614C
_02166140:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
_0216614C:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ViDockBack__Func_2165D60

	arm_func_start ViDockBack__Func_2166158
ViDockBack__Func_2166158: // 0x02166158
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x18
	mov r5, r2
	ldr r2, [sp, #0x28]
	mov r4, #0
	cmp r3, #0
	strne r4, [r3]
	mov r6, r1
	cmp r2, #0
	movne r1, #0
	strne r1, [r2]
	ldr r2, [sp, #0x2c]
	cmp r2, #0
	movne r1, #6
	strne r1, [r2]
	ldr ip, [r6]
	ldr r1, [r0, #0]
	cmp r1, ip
	ldreq r2, [r0, #4]
	ldreq r1, [r6, #4]
	cmpeq r2, r1
	ldreq r1, [r0, #8]
	ldreq r0, [r6, #8]
	cmpeq r1, r0
	bne _021661D4
	str ip, [r5]
	ldr r0, [r6, #4]
	str r0, [r5, #4]
	ldr r0, [r6, #8]
	str r0, [r5, #8]
	b _021662DC
_021661D4:
	str ip, [sp, #0x14]
	ldr r1, [r6, #8]
	cmp ip, #0x11000
	str r1, [sp, #0x10]
	bge _02166268
	cmp r1, #0xa000
	ble _02166268
	cmp r1, #0x12000
	bge _02166268
	cmp r1, #0xe000
	add r3, sp, #0x10
	bge _02166238
	mov r2, #0x11000
	rsb r2, r2, #0
	mov r0, #0xe000
	str r2, [sp]
	str r0, [sp, #4]
	sub lr, r0, #0x22000
	mov r0, ip
	add r2, sp, #0x14
	str lr, [sp, #8]
	mov ip, #0xa000
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
	b _02166268
_02166238:
	mov r2, #0x14000
	rsb r2, r2, #0
	mov r0, #0x12000
	str r2, [sp]
	str r0, [sp, #4]
	sub lr, r0, #0x23000
	mov r0, ip
	add r2, sp, #0x14
	str lr, [sp, #8]
	mov ip, #0xe000
	str ip, [sp, #0xc]
	bl Unknown2051334__Func_2051450
_02166268:
	ldr r0, [sp, #0x10]
	cmp r0, #0x7000
	movlt r0, #0x7000
	strlt r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	cmp r0, #0x14000
	movgt r0, #0x14000
	strgt r0, [sp, #0x14]
	mov r0, #0x14000
	ldr r1, [sp, #0x14]
	rsb r0, r0, #0
	cmp r1, r0
	strlt r0, [sp, #0x14]
	ldr r0, [sp, #0x14]
	str r0, [r5]
	ldr r0, [r6, #4]
	str r0, [r5, #4]
	ldr r0, [sp, #0x10]
	str r0, [r5, #8]
	ldr r1, [r5, #0]
	ldr r0, [r6, #0]
	cmp r1, r0
	ldreq r1, [r5, #4]
	ldreq r0, [r6, #4]
	cmpeq r1, r0
	ldreq r1, [r5, #8]
	ldreq r0, [r6, #8]
	cmpeq r1, r0
	movne r4, #1
_021662DC:
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ViDockBack__Func_2166158

	arm_func_start ViDockBack__Func_21662E8
ViDockBack__Func_21662E8: // 0x021662E8
	ldr r0, [r0, #8]
	cmp r0, #0x18000
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end ViDockBack__Func_21662E8

	arm_func_start ViDockBack__Func_21662FC
ViDockBack__Func_21662FC: // 0x021662FC
	mov r0, #0
	bx lr
	arm_func_end ViDockBack__Func_21662FC

	arm_func_start ViDockBack__Func_2166304
ViDockBack__Func_2166304: // 0x02166304
	ldr r0, [r0, #8]
	cmp r0, #0x50000
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end ViDockBack__Func_2166304

	arm_func_start ViDockBack__Func_2166318
ViDockBack__Func_2166318: // 0x02166318
	ldr r0, [r0, #8]
	cmp r0, #0x7e000
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end ViDockBack__Func_2166318

	arm_func_start ViDockBack__Func_216632C
ViDockBack__Func_216632C: // 0x0216632C
	ldr r0, [r0, #8]
	cmp r0, #0x7e000
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end ViDockBack__Func_216632C

	arm_func_start ViDockBack__Func_2166340
ViDockBack__Func_2166340: // 0x02166340
	ldr r0, [r0, #8]
	cmp r0, #0x7e000
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end ViDockBack__Func_2166340

	arm_func_start ViDockBack__Func_2166354
ViDockBack__Func_2166354: // 0x02166354
	ldr r0, [r0, #8]
	cmp r0, #0x3e000
	movge r0, #1
	movlt r0, #0
	bx lr
	arm_func_end ViDockBack__Func_2166354

	arm_func_start ViDockBack__Func_2166368
ViDockBack__Func_2166368: // 0x02166368
	cmp r2, #1
	bne _02166394
	mov r2, #0x14000
	str r2, [r0]
	mov r2, #0
	str r2, [r0, #4]
	mov r2, #0x800
	str r2, [r0, #8]
	mov r0, #0xc000
	strh r0, [r1]
	bx lr
_02166394:
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	mov r2, #0x13000
	str r2, [r0, #8]
	mov r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_2166368

	arm_func_start ViDockBack__Func_21663B4
ViDockBack__Func_21663B4: // 0x021663B4
	mov r2, #0x10000
	rsb r2, r2, #0
	str r2, [r0]
	mov r2, #0
	str r2, [r0, #4]
	str r2, [r0, #8]
	mov r0, #0x4000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_21663B4

	arm_func_start ViDockBack__Func_21663D8
ViDockBack__Func_21663D8: // 0x021663D8
	mov r2, #0x1e000
	rsb r2, r2, #0
	str r2, [r0]
	mov r2, #0
	str r2, [r0, #4]
	mov r2, #0x46000
	str r2, [r0, #8]
	mov r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_21663D8

	arm_func_start ViDockBack__Func_2166400
ViDockBack__Func_2166400: // 0x02166400
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	mov r2, #0x6e000
	str r2, [r0, #8]
	mov r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_2166400

	arm_func_start ViDockBack__Func_2166420
ViDockBack__Func_2166420: // 0x02166420
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	mov r2, #0x6e000
	str r2, [r0, #8]
	mov r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_2166420

	arm_func_start ViDockBack__Func_2166440
ViDockBack__Func_2166440: // 0x02166440
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	mov r2, #0x6e000
	str r2, [r0, #8]
	mov r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_2166440

	arm_func_start ViDockBack__Func_2166460
ViDockBack__Func_2166460: // 0x02166460
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	mov r2, #0x37000
	str r2, [r0, #8]
	mov r0, #0x8000
	strh r0, [r1]
	bx lr
	arm_func_end ViDockBack__Func_2166460

	arm_func_start ViDockBack__Func_2166480
ViDockBack__Func_2166480: // 0x02166480
	mov r0, #0
	bx lr
	arm_func_end ViDockBack__Func_2166480

	arm_func_start ViDockBack__Func_2166488
ViDockBack__Func_2166488: // 0x02166488
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #8]
	cmp r0, #0x3c000
	movge r0, #0
	ldmgeia sp!, {r3, pc}
	cmp r0, #0x1e000
	movlt r0, #0x1a000
	ldmltia sp!, {r3, pc}
	rsb r1, r0, #0x3c000
	mov r0, #0x1a
	mul r0, r1, r0
	mov r1, #0x1e
	bl FX_DivS32
	ldmia sp!, {r3, pc}
	arm_func_end ViDockBack__Func_2166488

	arm_func_start ViDockBack__Func_21664C0
ViDockBack__Func_21664C0: // 0x021664C0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	str r1, [r4, #0x10]
	mov r1, #0
	add r0, sp, #0
	str r1, [sp, #4]
	str r2, [sp]
	str r3, [sp, #8]
	bl ViDockBack__Func_2166480
	str r0, [sp, #4]
	add r1, sp, #0
	mov r0, r4
	bl ViShadow__Func_2167F00
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViDockBack__Func_21664C0

	arm_func_start ViDockBack__Func_2166500
ViDockBack__Func_2166500: // 0x02166500
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	str r1, [r4, #0x10]
	mov r1, #0
	add r0, sp, #0
	str r1, [sp, #4]
	str r2, [sp]
	str r3, [sp, #8]
	bl ViDockBack__Func_2166488
	str r0, [sp, #4]
	add r1, sp, #0
	mov r0, r4
	bl ViShadow__Func_2167F00
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViDockBack__Func_2166500

	arm_func_start ViDockBack__Func_2166540
ViDockBack__Func_2166540: // 0x02166540
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0x14
	bl CARD_SetThreadPriority
	mov r4, r0
	ldr r0, [r5, #0xcc]
	ldr r1, [r5, #0xd0]
	mov r2, #1
	mov r3, #0
	bl ViDockBack__LoadAssets
	mov r0, r4
	bl CARD_SetThreadPriority
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDockBack__Func_2166540

	.data

.public _ZTI11CViDockBack
_ZTI11CViDockBack: // 0x0217376C
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CViDockBack

_02173774: // 0x02173774
    .word ViDockBack__Func_2164C44, ViDockBack__Func_216509C
	.word ViDockBack__Func_2165268, ViDockBack__Func_21654C8
	.word ViDockBack__Func_2165914, ViDockBack__Func_2165D60
	.word ViDockBack__Func_2166158

_02173790: // 0x02173790
    .word ViDockBack__Func_21662E8, ViDockBack__Func_21662FC
	.word ViDockBack__Func_2166304, ViDockBack__Func_2166318
	.word ViDockBack__Func_216632C, ViDockBack__Func_2166340
	.word ViDockBack__Func_2166354

_021737AC: // 0x021737AC
    .word ViDockBack__Func_2166368, ViDockBack__Func_21663B4
	.word ViDockBack__Func_21663D8, ViDockBack__Func_2166400
	.word ViDockBack__Func_2166420, ViDockBack__Func_2166440
	.word ViDockBack__Func_2166460

_021737C8: // 0x021737C8
    .word ViDockBack__Func_2166480, ViDockBack__Func_2166480
	.word ViDockBack__Func_2166480, ViDockBack__Func_2166480
	.word ViDockBack__Func_2166480, ViDockBack__Func_2166488
	.word ViDockBack__Func_2166480

_021737E4: // 0x021737E4
    .word ViDockBack__Func_21664C0, ViDockBack__Func_21664C0
	.word ViDockBack__Func_21664C0, ViDockBack__Func_21664C0
	.word ViDockBack__Func_21664C0, ViDockBack__Func_2166500
	.word ViDockBack__Func_21664C0

.public _ZTS11CViDockBack
_ZTS11CViDockBack: // 0x02173800
	.asciz "11CViDockBack"
	.align 4

.public _ZTV11CViDockBack
_ZTV11CViDockBack: // 0x02173810
    .word 0, _ZTI11CViDockBack
    .word ViDockBack__VTableFunc_21644C0, ViDockBack__VTableFunc_2164540