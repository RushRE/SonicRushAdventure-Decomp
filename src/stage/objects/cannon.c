#include <stage/objects/cannon.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/sailboatBazookaSmoke.h>
#include <stage/effects/unknown202C414.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *CannonPath__dword_218A394;

NOT_DECOMPILED void *aModGmkCannonNs;
NOT_DECOMPILED void *aActAcGmkDashCt_0;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC CannonField *CannonField__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, =0x000005EC
	ldr r0, =StageTask_Main
	ldr r1, =CannonField__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, =0x000005EC
	mov r7, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, [r7, #0x1c]
	mov r0, #0xa5
	orr r1, r1, #0x2100
	str r1, [r7, #0x1c]
	bl GetObjectFileWork
	ldr r2, =gameArchiveStage
	ldr r1, =aModGmkCannonNs
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r8, #0
	mov r10, r0
	add r9, r7, #0x364
	mov r6, r8
	mov r5, r8
	ldr r4, =0x000034CC
	b _0217AB14
_0217AAD8:
	mov r0, r9
	mov r1, r6
	bl AnimatorMDL__Init
	mov r2, r8, lsl #0x10
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp]
	mov r3, r5
	bl AnimatorMDL__SetResource
	str r4, [r9, #0x18]
	str r4, [r9, #0x1c]
	str r4, [r9, #0x20]
	add r8, r8, #1
	add r9, r9, #0x144
_0217AB14:
	cmp r8, #2
	blt _0217AAD8
	ldr r0, [r7, #0x20]
	mvn r4, #0x37
	orr r0, r0, #0x300
	str r0, [r7, #0x20]
	mov r0, #0x2000
	strh r0, [r7, #0x32]
	str r7, [r7, #0x234]
	add r0, r7, #0x218
	add r1, r4, #0x18
	sub r2, r4, #0x28
	mov r3, #0x20
	str r4, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r7, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r7, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r2, #0x50
	ldr r0, =CannonField__OnDefend
	mov r1, #0
	str r0, [r7, #0x23c]
	ldr r3, [r7, #0x230]
	ldr r0, =StageTask__DefaultDiffData
	orr r3, r3, #0x400
	str r3, [r7, #0x230]
	str r1, [r7, #0x13c]
	str r7, [r7, #0x2d8]
	str r0, [r7, #0x2fc]
	add r0, r7, #0x300
	mov r1, #0x28
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x60
	add r0, r7, #0x200
	strh r1, [r0, #0xf0]
	sub r2, r2, #0x9a
	ldr r1, =CannonField__Draw
	strh r2, [r0, #0xf2]
	mov r0, r7
	str r1, [r7, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC Cannon *Cannon__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
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
	mov r4, #0x590
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
	mov r2, #0x590
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa5
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, =aModGmkCannonNs
	mov r3, #2
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x20]
	ldr r0, =0x000025A3
	orr r1, r1, #0x200
	str r1, [r4, #0x20]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	mov r0, #0
	str r0, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	add r3, r4, #0x2d8
	ldr r7, =StageTask__DefaultDiffData
	mov r1, #0x180
	str r7, [r3, #0x24]
	strh r1, [r3, #0x30]
	mov r6, #8
	strh r6, [r3, #0x32]
	sub r2, r6, #0xc8
	strh r2, [r3, #0x18]
	strh r0, [r3, #0x1a]
	str r4, [r4, #0x4e0]
	add r1, r4, #0x4e0
	str r7, [r1, #0x24]
	mov r5, #0x10
	strh r5, [r1, #0x30]
	mov r3, #0x78
	strh r3, [r1, #0x32]
	strh r2, [r1, #0x18]
	strh r6, [r1, #0x1a]
	str r4, [r4, #0x538]
	add r1, r4, #0x138
	add r2, r1, #0x400
	str r7, [r2, #0x24]
	strh r5, [r2, #0x30]
	strh r3, [r2, #0x32]
	mov r1, #0xb0
	strh r1, [r2, #0x18]
	strh r6, [r2, #0x1a]
	ldr r2, =Cannon__State_217B7A8
	ldr r1, =Cannon__Collide
	str r2, [r4, #0xf4]
	str r1, [r4, #0x108]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CannonPath *CannonPath__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x000010F6
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3a8
	ldr r0, =StageTask_Main
	ldr r1, =CannonPath__Destructor
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
	mov r2, #0x3a8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x1c]
	ldr r1, =CannonPath__State_217B868
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r0, =CannonPath__dword_218A394
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0]
	str r1, [r0, #8]
	ldrsb r0, [r7, #7]
	ldr r1, =0x000016C1
	mov r0, r0, lsl #0x12
	sub r0, r0, #0x80000
	str r0, [r4, #0x378]
	cmp r0, #0x40000
	movlt r0, #0x40000
	strlt r0, [r4, #0x378]
	ldr r0, [r4, #0x378]
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x378]
	add r0, r0, #0x80000
	str r0, [r4, #0x378]
	ldr r0, [r4, #0x37c]
	bl FX_Div
	ldrsb r2, [r7, #6]
	mov r1, r0
	mov r0, r2, lsl #0x12
	bl FX_Div
	str r0, [r4, #0x38c]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC fx32 CannonPath__GetOffsetZ(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =CannonPath__dword_218A394
	ldr r0, [r0, #4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC CannonRing *CannonRing__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r4, r2
	mov r2, #0
	str r3, [sp]
	mov r5, #2
	str r5, [sp, #4]
	mov r5, #0x570
	ldr r0, =StageTask_Main
	ldr r1, =CannonRing__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl GetTaskWork_
	mov r5, r0
	mov r1, #0
	mov r2, #0x570
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r7
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r0, [r5, #0x1c]
	add r1, r5, #0x500
	orr r0, r0, #0x2100
	str r0, [r5, #0x1c]
	ldr r2, [r5, #0x20]
	mov r0, #0xa6
	orr r2, r2, #0x104
	str r2, [r5, #0x20]
	ldrh r2, [r7, #4]
	and r2, r2, #3
	strh r2, [r1, #0x6c]
	bl GetObjectFileWork
	ldr r2, =gameArchiveStage
	ldr r1, =aActAcGmkDashCt_0
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x800
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	add r0, r5, #0x364
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0x36e]
	mov r0, #7
	mov r1, #0
	strb r0, [r5, #0x36f]
	add r0, r5, #0x364
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r5, #0x430]
	mov r1, #0
	orr r0, r0, #0x10
	str r0, [r5, #0x430]
	mov r0, #0x200
	add r6, r5, #0x68
	bl VRAMSystem__AllocTexture
	mov r7, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	stmia sp, {r1, r7}
	str r0, [sp, #8]
	add r0, r5, #0x500
	ldrh r3, [r0, #0x6c]
	mov r2, r4
	add r0, r6, #0x400
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	mov r1, #0
	strb r0, [r6, #0x40a]
	mov r0, #7
	strb r0, [r6, #0x40b]
	mov r2, r1
	add r0, r6, #0x400
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r6, #0x4cc]
	mov r3, #0x80
	orr r1, r1, #0x10
	str r1, [r6, #0x4cc]
	ldr r0, =CannonRing__Draw_217BC38
	sub r1, r3, #0x88
	str r0, [r5, #0xfc]
	str r5, [r5, #0x234]
	add r0, r5, #0x218
	sub r2, r3, #0x100
	str r3, [sp]
	mov r3, #4
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r5, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =CannonRing__OnDefend_217BD90
	mov r0, #0x80
	str r1, [r5, #0x23c]
	str r5, [r5, #0x274]
	mov r1, #4
	str r0, [sp]
	add r0, r5, #0x258
	sub r2, r1, #0x84
	mov r3, #8
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r5, #0x258
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r5, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =CannonRing__OnDefend_217BE24
	mov r0, r5
	str r1, [r5, #0x27c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonField__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	add r5, r0, #0x364
	mov r4, #0
_0217B14C:
	mov r0, r5
	bl AnimatorMDL__Release
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x144
	blt _0217B14C
	mov r0, #0xa5
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r6
	bl GameObject__Destructor
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonField__State_217B17C(Cannon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x5c
	mov r6, r0
	ldr r5, [r6, #0x35c]
	ldr r0, [r5, #0x6d8]
	cmp r0, r6
	movne r0, #0
	addne sp, sp, #0x5c
	strne r0, [r6, #0xf4]
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r1, [r6, #0x28]
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _0217B464
_0217B1B4: // jump table
	b _0217B1C8 // case 0
	b _0217B1F0 // case 1
	b _0217B208 // case 2
	b _0217B240 // case 3
	b _0217B268 // case 4
_0217B1C8:
	ldr r0, [r5, #0x24]
	tst r0, #1
	addeq sp, sp, #0x5c
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	add r0, r1, #1
	str r0, [r6, #0x28]
	mov r0, #0x4000
	add sp, sp, #0x5c
	str r0, [r6, #4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B1F0:
	ldr r0, [r6, #4]
	add sp, sp, #0x5c
	cmp r0, #0
	addeq r0, r1, #1
	streq r0, [r6, #0x28]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B208:
	ldrh r0, [r6, #0x30]
	add r0, r0, #0x100
	strh r0, [r6, #0x30]
	ldrh r0, [r6, #0x30]
	cmp r0, #0x2800
	addlo sp, sp, #0x5c
	ldmloia sp!, {r3, r4, r5, r6, pc}
	ldr r1, [r6, #0x28]
	mov r0, #0x4000
	add r1, r1, #1
	str r1, [r6, #0x28]
	add sp, sp, #0x5c
	str r0, [r6, #4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B240:
	ldr r0, [r6, #4]
	cmp r0, #0
	addne sp, sp, #0x5c
	ldmneia sp!, {r3, r4, r5, r6, pc}
	add r0, r1, #1
	str r0, [r6, #0x28]
	mov r0, #0
	add sp, sp, #0x5c
	str r0, [r6, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B268:
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	cmp r0, #8
	addlt sp, sp, #0x5c
	str r0, [r6, #0x2c]
	ldmltia sp!, {r3, r4, r5, r6, pc}
	ldr r3, [r6, #0x340]
	mov r1, #0
	ldrsb r2, [r3, #6]
	mov r0, #0x148
	str r2, [sp]
	ldrsb r2, [r3, #7]
	str r2, [sp, #4]
	ldrb r2, [r3, #8]
	str r2, [sp, #8]
	ldrb r2, [r3, #9]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	ldrh r3, [r3, #4]
	ldr r1, [r5, #0x44]
	ldr r2, [r5, #0x48]
	bl GameObject__SpawnObject
	movs r4, r0
	bne _0217B2E0
	mov r0, #0
	str r0, [r6, #0xf4]
	str r0, [r5, #0x6d8]
	add sp, sp, #0x5c
	str r0, [r6, #0x35c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B2E0:
	str r5, [r4, #0x35c]
	ldrh r3, [r6, #0x30]
	ldrh r2, [r6, #0x32]
	add r0, r4, #0x300
	add r1, r6, #0x44
	strh r3, [r0, #0x70]
	strh r2, [r0, #0x72]
	ldrh r2, [r6, #0x34]
	add r3, r4, #0x364
	strh r2, [r0, #0x74]
	ldrh r0, [r6, #0x30]
	strh r0, [r4, #0x34]
	ldrh r0, [r6, #0x32]
	sub r0, r0, #0x4000
	strh r0, [r4, #0x32]
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0x38
	bl MTX_Identity33_
	add r0, r4, #0x300
	ldrh r1, [r0, #0x70]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x14
	sub r1, r1, #0x4000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, sp, #0x38
	add r1, sp, #0x14
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x300
	ldrh r1, [r0, #0x72]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x14
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x38
	add r1, sp, #0x14
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x14
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotZ33_
	add r0, sp, #0x38
	add r1, sp, #0x14
	mov r2, r0
	bl MTX_Concat33
	mov r0, #0
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	sub r3, r0, #0xa000
	add r0, r4, #0x380
	add r1, sp, #0x38
	mov r2, r0
	str r3, [r4, #0x388]
	bl MTX_MultVec33
	mov r0, r5
	mov r1, r4
	bl Player__Action_PRCannon
	mov r1, #0
	ldr r4, =CannonField__State_217B474
	str r1, [r6, #0x35c]
	mov r0, r6
	sub r2, r1, #0x28000
	mov r3, #0x1e000
	str r4, [r6, #0xf4]
	bl EffectSailboatBazookaSmoke__Create
_0217B464:
	add sp, sp, #0x5c
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonField__State_217B474(Cannon *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =CannonPath__dword_218A394
	ldr r1, [r1, #4]
	str r1, [r0, #0x58]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void CannonField__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x44
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, =CannonPath__dword_218A394
	ldr r2, [r4, #0x20]
	ldr r0, [r1, #4]
	str r2, [sp, #0x10]
	cmp r0, #0
	bicne r0, r2, #0x200
	strne r0, [sp, #0x10]
	add r0, r4, #0x388
	bl MTX_Identity33_
	ldrh r1, [r4, #0x30]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x20
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, r4, #0x388
	add r1, sp, #0x20
	mov r2, r0
	bl MTX_Concat33
	ldrh r1, [r4, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x20
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r4, #0x388
	add r1, sp, #0x20
	mov r2, r0
	bl MTX_Concat33
	ldr r2, [r4, #0x44]
	ldr r1, [r4, #0x50]
	ldr r0, =CannonPath__dword_218A394
	add r1, r2, r1
	str r1, [sp, #0x14]
	ldr r2, [r4, #0x48]
	ldr r1, [r0, #4]
	ldr r0, [r4, #0x54]
	sub r2, r2, #0x27000
	add r0, r2, r0
	str r0, [sp, #0x18]
	ldr r2, [r4, #0x4c]
	add r0, sp, #0x10
	add r1, r2, r1
	str r1, [sp, #0x1c]
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	add r0, r4, #0x364
	add r1, sp, #0x14
	mov r3, r2
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add r0, r4, #0xa8
	add r5, r0, #0x400
	add r0, r5, #0x24
	bl MTX_Identity33_
	ldrh r1, [r4, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x20
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r5, #0x24
	add r1, sp, #0x20
	mov r2, r0
	bl MTX_Concat33
	ldr r2, [r4, #0x44]
	ldr r1, [r4, #0x50]
	ldr r0, =CannonPath__dword_218A394
	add r1, r2, r1
	str r1, [sp, #0x14]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x54]
	ldr r0, [r0, #4]
	add r1, r2, r1
	str r1, [sp, #0x18]
	ldr r1, [r4, #0x4c]
	mov r2, #0
	add r1, r1, r0
	str r1, [sp, #0x1c]
	add r0, sp, #0x10
	stmia sp, {r0, r2}
	str r2, [sp, #8]
	add r1, sp, #0x14
	mov r0, r5
	mov r3, r2
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonField__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh r2, [r5, #0]
	cmp r2, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r2, [r4, #0x48]
	ldr r3, [r5, #0x48]
	sub r6, r2, #0x4a000
	add r3, r3, #0xd000
	cmp r3, r6
	bgt _0217B718
	ldr r2, [r5, #0x1c]
	tst r2, #1
	beq _0217B6E0
	mov r0, r5
	mov r1, r4
	mov r2, #1
	bl Player__Gimmick_2022108
	b _0217B77C
_0217B6E0:
	ldr r3, [r4, #0x44]
	ldr r6, [r5, #0x44]
	sub r2, r3, #0x8000
	cmp r2, r6
	addle r2, r3, #0x8000
	cmple r6, r2
	bgt _0217B710
	mov r0, r5
	mov r1, r4
	mov r2, #0
	bl Player__Gimmick_2022108
	b _0217B77C
_0217B710:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217B718:
	ldr r7, [r4, #0x44]
	ldr r6, [r5, #0x44]
	sub ip, r7, #0x10000
	add lr, r6, #0x6000
	cmp lr, ip
	ble _0217B740
	sub lr, r6, #0x6000
	add ip, r7, #0x18000
	cmp lr, ip
	blt _0217B774
_0217B740:
	ldr ip, [r5, #0x1c]
	tst ip, #0x10
	beq _0217B76C
	sub r2, r2, #0x3a000
	cmp r3, r2
	blt _0217B76C
	mov r0, r5
	mov r1, r4
	mov r2, #2
	bl Player__Gimmick_2022108
	b _0217B77C
_0217B76C:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217B774:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217B77C:
	mov r2, #0
	str r2, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, =CannonField__State_217B17C
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	str r5, [r4, #0x35c]
	str r2, [r4, #0x28]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Cannon__State_217B7A8(Cannon *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =CannonPath__dword_218A394
	ldr r1, [r1, #0]
	cmp r1, #0x1f4000
	ldreq r1, [r0, #0x20]
	orreq r1, r1, #0x20
	streq r1, [r0, #0x20]
	bxeq lr
	str r1, [r0, #0x58]
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x20
	str r1, [r0, #0x20]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Cannon__Collide(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r4, pc}
	bl StageTask__ViewCheck_Default
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x2d8]
	cmp r0, #0
	beq _0217B814
	add r0, r4, #0x2d8
	bl ObjCollisionObjectRegist
_0217B814:
	ldr r0, [r4, #0x4e0]
	cmp r0, #0
	beq _0217B828
	add r0, r4, #0x4e0
	bl ObjCollisionObjectRegist
_0217B828:
	ldr r0, [r4, #0x538]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x138
	add r0, r0, #0x400
	bl ObjCollisionObjectRegist
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonPath__Destructor(Task *task){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =CannonPath__dword_218A394
	mov r2, #0
	str r2, [r1, #4]
	str r2, [r1]
	ldr ip, =GameObject__Destructor
	str r2, [r1, #8]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void CannonPath__State_217B868(Cannon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, r0
	ldr ip, [r4, #0x35c]
	ldr r0, [ip, #0x6d8]
	cmp r0, r4
	beq _0217B8A4
	ldr r1, [r4, #0x18]
	ldr r0, =CannonPath__dword_218A394
	orr r1, r1, #4
	str r1, [r4, #0x18]
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0]
	str r1, [r0, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217B8A4:
	add r3, r4, #0x44
	add r5, r4, #0x8c
	ldmia r3, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [r4, #0x28]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217B8C4: // jump table
	b _0217B8D8 // case 0
	b _0217B92C // case 1
	b _0217B9E0 // case 2
	b _0217BA8C // case 3
	b _0217BA98 // case 4
_0217B8D8:
	ldr r1, [r3, #0]
	ldr r0, [r4, #0x380]
	add r0, r1, r0
	str r0, [r3]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x384]
	add r0, r1, r0
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x4c]
	ldr r0, [r4, #0x388]
	add r0, r1, r0
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x368]
	ldr r1, [r4, #0x48]
	sub r0, r0, #0x60000
	cmp r1, r0
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217B92C:
	ldr r2, [r3, #0]
	ldr r1, [r4, #0x380]
	ldr r0, =CannonPath__dword_218A394
	add r1, r2, r1
	str r1, [r3]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x384]
	add r1, r2, r1
	str r1, [r4, #0x48]
	ldr r2, [r4, #0x4c]
	ldr r1, [r4, #0x388]
	add r1, r2, r1
	str r1, [r4, #0x4c]
	ldr r1, [r0, #4]
	add r2, r1, #0xa000
	str r2, [r0, #4]
	ldr r1, [r4, #0x4c]
	rsb r1, r1, #0x23000
	cmp r2, r1
	strge r1, [r0, #4]
	ldr r0, =CannonPath__dword_218A394
	ldr r1, [r0, #4]
	str r1, [r0]
	ldr r1, [r4, #0x368]
	ldr r2, [r4, #0x48]
	sub r1, r1, #0xc0000
	cmp r2, r1
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r1, [r4, #0x28]
	mov r2, #0x23000
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r3, [r4, #0x368]
	mov r1, #0x1f4000
	sub r3, r3, #0xc0000
	str r3, [r4, #0x48]
	stmia r0, {r1, r2}
	mov r2, #0
	str r2, [r4, #0x4c]
	mov r1, #1
	str r1, [r0, #8]
	mov r0, r4
	str r2, [r4, #0x24]
	bl EffectUnknown202C414__Create
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217B9E0:
	ldr r0, [r3, #0]
	add r0, r0, #0xc1
	add r0, r0, #0x1600
	str r0, [r3]
	ldr r0, [r4, #0x378]
	sub r1, r0, #0xc1
	sub r1, r1, #0x1600
	str r1, [r4, #0x378]
	ldr r0, [r4, #0x37c]
	cmp r1, r0
	bgt _0217BA1C
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x38c]
	add r0, r1, r0
	str r0, [r4, #0x48]
_0217BA1C:
	ldr r0, [r4, #0x378]
	cmp r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r4, #0x28]
	add r5, r4, #0x39c
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r1, [r4, #0x44]
	add r0, r4, #0x44
	add r1, r1, #0x80000
	str r1, [r4, #0x390]
	ldr r1, [r4, #0x48]
	mov r3, #0
	add r1, r1, #0x79000
	str r1, [r4, #0x394]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	add r0, r4, #0x300
	strh r3, [r0, #0x76]
	ldr r1, =CannonPath__dword_218A394
	sub r0, r3, #0x190000
	ldr r2, [r1, #4]
	add r2, r2, #0x190000
	str r2, [r4, #0x4c]
	stmib r1, {r0, r3}
	mov r0, #1
	str r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217BA8C:
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217BA98:
	add r0, r4, #0x300
	ldrsh r1, [r0, #0x76]
	mov r2, #3
	mov r6, #0
	add r1, r1, #0x44
	strh r1, [r0, #0x76]
	ldrsh r1, [r0, #0x76]
	mov r5, #0x800
	cmp r1, #0x1000
	movge r1, #0x1000
	strgeh r1, [r0, #0x76]
	add r0, r4, #0x300
	ldrsh lr, [r0, #0x76]
	ldr r1, [r4, #0x390]
	ldr r0, [r4, #0x39c]
	mov r3, lr, asr #0x1f
_0217BAD8:
	sub r7, r1, r0
	umull r9, r8, r7, lr
	mla r8, r7, r3, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, lr, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r2, #0
	add r0, r0, r8
	sub r2, r2, #1
	bne _0217BAD8
	str r0, [r4, #0x44]
	add r0, r4, #0x300
	ldrsh lr, [r0, #0x76]
	ldr r1, [r4, #0x394]
	ldr r0, [r4, #0x3a0]
	mov r3, lr, asr #0x1f
	mov r2, #1
	mov r6, #0
	mov r5, #0x800
_0217BB30:
	sub r7, r1, r0
	umull r9, r8, r7, lr
	mla r8, r7, r3, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, lr, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r2, #0
	add r0, r0, r8
	sub r2, r2, #1
	bne _0217BB30
	str r0, [r4, #0x48]
	add r0, r4, #0x300
	ldrsh r2, [r0, #0x76]
	mov r5, #0
	mov r0, #1
	mov r1, r2, asr #0x1f
	mov lr, r5
	mov r3, #0x800
_0217BB84:
	add r5, r5, #0x190000
	umull r7, r6, r5, r2
	mla r6, r5, r1, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, r2, r6
	adds r7, r7, r3
	adc r5, r6, lr
	mov r6, r7, lsr #0xc
	orr r6, r6, r5, lsl #20
	cmp r0, #0
	sub r5, r6, #0x190000
	sub r0, r0, #1
	bne _0217BB84
	ldr r0, =CannonPath__dword_218A394
	add r2, r4, #0x300
	str r5, [r0, #4]
	str r5, [r0]
	ldrsh r0, [r2, #0x76]
	cmp r0, #0x1000
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r3, #0x1000
	mov r0, ip
	mov r1, r4
	strh r3, [r2, #0x76]
	bl Player__Func_2022C40
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonRing__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x364
	bl AnimatorSprite3D__Release
	add r0, r4, #0x68
	add r0, r0, #0x400
	bl AnimatorSprite3D__Release
	mov r0, #0xa6
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonRing__Draw_217BC38(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	ldr r5, =mapCamera
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, =CannonPath__dword_218A394
	ldr r2, [r4, #0x20]
	ldr r1, [r0, #8]
	bic r2, r2, #4
	str r2, [sp, #0x10]
	cmp r1, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r8, [r5, #4]
	ldr r3, [r4, #0x44]
	cmp r3, r8
	addlt sp, sp, #0x20
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r1, r8, #0x100000
	cmp r3, r1
	addgt sp, sp, #0x20
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov lr, #0x800
	mov r2, #0
	sub r7, r3, r8
	sub r9, lr, #0x1700
	sub ip, r2, #1
	umull r3, r1, r7, r9
	sub r10, lr, #0x5300
	adds lr, lr, r7, lsl #12
	ldr r5, [r5, #8]
	mla r1, r7, ip, r1
	mov r6, r7, asr #0x1f
	mov ip, r6, lsl #0xc
	mla r1, r6, r9, r1
	orr ip, ip, r7, lsr #20
	mov lr, lr, lsr #0xc
	adc r9, ip, #0
	orr lr, lr, r9, lsl #20
	add r8, r8, lr
	str r8, [sp, #0x14]
	adds r8, r3, #0x800
	adc r1, r1, #0
	mov r8, r8, lsr #0xc
	add r5, r5, #0xf1000
	orr r8, r8, r1, lsl #20
	add r8, r5, r8
	sub r3, r2, #1
	umull r5, r1, r7, r10
	mla r1, r7, r3, r1
	mla r1, r6, r10, r1
	str r8, [sp, #0x18]
	adds r3, r5, #0x800
	ldr r5, [r0, #4]
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	add r3, r5, #0x258000
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	str r0, [sp, #0x1c]
	add r0, r4, #0x20
	stmia sp, {r0, r2}
	str r2, [sp, #8]
	add r1, sp, #0x14
	mov r3, r2
	str r2, [sp, #0xc]
	add r0, r4, #0x364
	bl StageTask__Draw3DEx
	ldr r0, [r4, #0x24]
	tst r0, #2
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r2, #0
	add r0, sp, #0x10
	stmia sp, {r0, r2}
	add r0, r4, #0x68
	str r2, [sp, #8]
	add r1, sp, #0x14
	mov r3, r2
	add r0, r0, #0x400
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonRing__OnDefend_217BD90(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldr r1, [r4, #0x340]
	add r0, r4, #0x500
	ldrh r2, [r1, #4]
	ldrh r1, [r0, #0x6c]
	mov r0, r5
	tst r2, #0x80
	orrne r1, r1, #0x80000000
	bl Player__Func_2022CD4
	mov r0, #0
	str r0, [r4, #0x234]
	ldr r1, [r4, #0x230]
	add r0, r4, #0xf8
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	ldr r2, [r4, #0x24]
	add r1, r4, #0x500
	orr r2, r2, #1
	str r2, [r4, #0x24]
	ldrh r1, [r1, #4]
	add r0, r0, #0x400
	add r1, r1, #3
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CannonRing__OnDefend_217BE24(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0, #0]
	cmp r1, #1
	ldmneia sp!, {r4, pc}
	add r1, r4, #0x500
	ldrh r1, [r1, #0x6c]
	bl Player__Func_2022D24
	mov r0, #0
	str r0, [r4, #0x274]
	ldr r0, [r4, #0x270]
	orr r0, r0, #0x800
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x24]
	orr r0, r0, #2
	str r0, [r4, #0x24]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}