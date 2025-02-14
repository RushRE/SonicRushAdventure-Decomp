#include <hub/cviMapIcon.hpp>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/graphics/drawReqTask.h>
#include <hub/hubConfig.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViActEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_2157178Ev(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B51CEl(void);

}

// --------------------
// FUNCTIONS
// --------------------

CViMapIcon::CViMapIcon()
{
    this->sprIcon = NULL;

    MI_CpuClear32(&this->aniIconOutline, sizeof(this->aniCursor));
    MI_CpuClear32(&this->aniIconCenter, sizeof(this->aniCursor));
    MI_CpuClear32(&this->aniSonicMarker, sizeof(this->aniCursor));
    MI_CpuClear32(&this->aniCursor, sizeof(this->aniCursor));

    ViMapIcon__Release(this);
}

CViMapIcon::~CViMapIcon()
{
    ViMapIcon__Release(this);
}

NONMATCH_FUNC void ViMapIcon__Func_2163058(CViMapIcon *work, BOOL useEngineB)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r5, r1
	mov r6, r0
	bl ViMapIcon__Release
	cmp r5, #0
	ldreq r4, =0x05000200
	mov r0, #0
	ldrne r4, =0x05000600
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r1, #0
	str r0, [r6, #8]
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	str r4, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	mov r0, #0x10
	str r0, [sp, #0x18]
	ldr r1, [r6, #8]
	add r0, r6, #0xd8
	mov r3, #0x64
	bl AnimatorSprite__Init
	mov r1, #4
	add r0, r6, #0x100
	strh r1, [r0, #0x28]
	mov r1, #0
	add r0, r6, #0xd8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r6, #0x114]
	mov r0, r6
	bic r1, r1, #0x60
	str r1, [r6, #0x114]
	bl ViMapIcon__Func_21636C8
	ldr r0, [r6, #8]
	mov r1, #1
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r4, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	mov r0, #0x11
	str r0, [sp, #0x18]
	ldr r1, [r6, #8]
	add r0, r6, #0x10
	mov r2, #1
	mov r3, #0x60
	bl AnimatorSprite__Init
	mov r0, #5
	strh r0, [r6, #0x60]
	mov r0, #0x10
	mov r1, #0
	strh r0, [r6, #0x64]
	add r0, r6, #0x10
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r6, #0x4c]
	mov r1, #2
	bic r0, r0, #0x60
	orr r0, r0, #0x18
	str r0, [r6, #0x4c]
	ldr r0, [r6, #8]
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r4, [sp, #0x10]
	mov r2, #2
	str r2, [sp, #0x14]
	mov r0, #0x12
	str r0, [sp, #0x18]
	ldr r1, [r6, #8]
	add r0, r6, #0x74
	mov r3, #0x30
	bl AnimatorSprite__Init
	mov r0, #5
	strh r0, [r6, #0xc4]
	mov r0, #0x10
	mov r1, #0
	strh r0, [r6, #0xc8]
	add r0, r6, #0x74
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r6, #0xb0]
	mov r1, #3
	bic r0, r0, #0x60
	orr r0, r0, #0x18
	str r0, [r6, #0xb0]
	ldr r0, [r6, #8]
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r4, [sp, #0x10]
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r6, #8]
	add r0, r6, #0x18c
	mov r2, #3
	mov r3, #0x30
	bl AnimatorSprite__Init
	mov r1, #5
	add r0, r6, #0x100
	strh r1, [r0, #0xdc]
	mov r1, #0x10
	strh r1, [r0, #0xe0]
	mov r1, #0
	add r0, r6, #0x18c
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r6, #0x1c8]
	bic r0, r0, #0x60
	orr r0, r0, #0x18
	str r0, [r6, #0x1c8]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Release(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x18c
	bl AnimatorSprite__Release
	add r0, r4, #0x74
	bl AnimatorSprite__Release
	add r0, r4, #0x10
	bl AnimatorSprite__Release
	add r0, r4, #0xd8
	bl AnimatorSprite__Release
	mov r0, #0
	add r1, r4, #0x74
	mov r2, #0x64
	bl MIi_CpuClear32
	mov r0, #0
	add r1, r4, #0x10
	mov r2, #0x64
	bl MIi_CpuClear32
	mov r0, #0
	add r1, r4, #0xd8
	mov r2, #0x64
	bl MIi_CpuClear32
	mov r0, #0
	add r1, r4, #0x18c
	mov r2, #0x64
	bl MIi_CpuClear32
	mov r0, #0
	str r0, [r4, #8]
	strh r0, [r4, #0xc]
	strh r0, [r4, #0xe]
	add r1, r4, #0x14c
	mov r2, #0x40
	bl MIi_CpuClear32
	mov r1, #0
	str r1, [r4, #4]
	mov r0, #9
	str r0, [r4, #0x13c]
	add r0, r4, #0x100
	strh r1, [r0, #0x40]
	strh r1, [r0, #0x42]
	str r1, [r4, #0x144]
	str r1, [r4, #0x148]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163340(CViMapIcon *work, u8 id, BOOL enabled){
#ifdef NON_MATCHING

#else
    // clang-format off
	cmp r2, #0
	ldrne r3, [r0, #4]
	mov r2, #1
	orrne r1, r3, r2, lsl r1
	mvneq r1, r2, lsl r1
	ldreq r2, [r0, #4]
	andeq r1, r2, r1
	str r1, [r0, #4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163364(CViMapIcon *work, u16 x, u16 y){
#ifdef NON_MATCHING

#else
    // clang-format off
	strh r1, [r0, #0xc]
	strh r2, [r0, #0xe]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__GetIconPosition(CViMapIcon *work, u32 area, u16 *x, u16 *y){
#ifdef NON_MATCHING

#else
    // clang-format off
	cmp r2, #0
	beq _02163388
	add ip, r0, r1, lsl #3
	add ip, ip, #0x100
	ldrh ip, [ip, #0x50]
	strh ip, [r2]
_02163388:
	cmp r3, #0
	bxeq lr
	add r0, r0, r1, lsl #3
	add r0, r0, #0x100
	ldrh r0, [r0, #0x52]
	strh r0, [r3]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__SetIconID2(CViMapIcon *work, u32 icon){
#ifdef NON_MATCHING

#else
    // clang-format off
	str r1, [r0, #0x13c]
	add r1, r0, #0x100
	mov r2, #0
	strh r2, [r1, #0x40]
	strh r2, [r1, #0x42]
	str r2, [r0, #0x144]
	str r2, [r0, #0x148]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__SetIconID(CViMapIcon *work, u32 icon)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r2, r5, #0x42
	mov r4, r1
	add r1, r5, #0x140
	add r2, r2, #0x100
	bl ViMapIcon__Func_21637A0
	str r4, [r5, #0x13c]
	mov r0, #0x20
	str r0, [r5, #0x144]
	mov r0, #0
	str r0, [r5, #0x148]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViMapIcon__GetCurrentIcon(CViMapIcon *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, [r0, #0x13c]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163400(CViMapIcon *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #0x148]
	ldr r1, [r0, #0x144]
	cmp r2, r1
	bxhs lr
	add r2, r2, #1
	str r2, [r0, #0x148]
	ldr r1, [r0, #0x144]
	cmp r2, r1
	bxne lr
	add r1, r0, #0x100
	mov r2, #0
	strh r2, [r1, #0x40]
	strh r2, [r1, #0x42]
	str r2, [r0, #0x144]
	str r2, [r0, #0x148]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163440(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #4]
	tst r1, #1
	beq _02163490
	add r1, sp, #0
	add r2, sp, #2
	bl ViMapIcon__Func_21637A0
	ldrh r3, [sp]
	ldrh r1, [r5, #0xc]
	ldrh r2, [sp, #2]
	ldrh r0, [r5, #0xe]
	sub r1, r3, r1
	mov r1, r1, lsl #0x10
	sub r0, r2, r0
	mov r2, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl ViMapIcon__Func_21638A4
_02163490:
	ldr r0, [r5, #4]
	tst r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r4, #0
_021634A0:
	add r1, r5, r4, lsl #3
	ldr r0, [r1, #0x14c]
	tst r0, #1
	beq _021634E4
	add r0, r1, #0x100
	ldrh r3, [r0, #0x50]
	ldrh r1, [r5, #0xc]
	ldrh r2, [r0, #0x52]
	ldrh r0, [r5, #0xe]
	sub r1, r3, r1
	mov r1, r1, lsl #0x10
	sub r0, r2, r0
	mov r2, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl ViMapIcon__Func_2163738
_021634E4:
	add r4, r4, #1
	cmp r4, #8
	blt _021634A0
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViMapIcon__GetIconFromTouchPos(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216351C
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _02163520
_0216351C:
	mov r0, #0
_02163520:
	cmp r0, #0
	beq _02163534
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	bne _0216353C
_02163534:
	mov r0, #9
	ldmia sp!, {r3, r4, r5, pc}
_0216353C:
	ldr r0, =touchInput
	ldrh r1, [r4, #0xc]
	ldrh r3, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	ldrh r0, [r4, #0xe]
	add r1, r3, r1
	mov r3, r1, lsl #0x10
	add r0, r2, r0
	mov ip, r0, lsl #0x10
	mov r0, #9
	mov r1, #0
_02163568:
	add r5, r4, r1, lsl #3
	ldr r2, [r5, #0x14c]
	tst r2, #1
	beq _021635C8
	add r2, r5, #0x100
	ldrh lr, [r2, #0x50]
	ldrh r5, [r2, #0x52]
	sub r2, lr, #0xc
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	rsb r2, r2, r3, lsr #16
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #0x18
	bhs _021635C8
	sub r2, r5, #0xc
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	rsb r2, r2, ip, lsr #16
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #0x18
	movlo r0, r1
	ldmloia sp!, {r3, r4, r5, pc}
_021635C8:
	add r1, r1, #1
	cmp r1, #8
	blt _02163568
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViMapIcon__Func_21635DC(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r1, [r4, #0x148]
	ldr r0, [r4, #0x144]
	cmp r1, r0
	ldrlo r0, =padInput
	ldrloh r0, [r0, #4]
	ldrhs r0, =padInput
	ldrhsh r0, [r0, #0]
	tst r0, #0x20
	ldrne r5, =ViMapIcon__Func_2163904
	bne _02163638
	tst r0, #0x40
	ldrne r5, =ViMapIcon__Func_216392C
	bne _02163638
	tst r0, #0x10
	ldrne r5, =ViMapIcon__Func_2163954
	bne _02163638
	tst r0, #0x80
	ldrne r5, =ViMapIcon__Func_216397C
	bne _02163638
	mov r0, #9
	ldmia sp!, {r4, r5, r6, pc}
_02163638:
	mov r6, #0
_0216363C:
	add r2, r6, #1
	ldr r0, [r4, #0x13c]
	mov r2, r2, lsl #0x10
	mov r1, r6
	mov r6, r2, lsr #0x10
	blx r5
	cmp r0, #8
	movge r0, #9
	ldmgeia sp!, {r4, r5, r6, pc}
	add r1, r4, r0, lsl #3
	ldr r1, [r1, #0x14c]
	tst r1, #1
	beq _0216363C
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViMapIcon__IsMoving(CViMapIcon *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x148]
	ldr r0, [r0, #0x144]
	cmp r1, r0
	movlo r0, #1
	movhs r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_21636A0(CViMapIcon *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =ViMapIcon__Func_21636C8
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_21636AC(CViMapIcon *work, s16 x, s16 y){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r3, r0, #0x100
	strh r1, [r3, #0x94]
	ldr ip, =AnimatorSprite__DrawFrame
	add r0, r0, #0x18c
	strh r2, [r3, #0x96]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_21636C8(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	add r1, r4, #0x14c
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear32
	add r0, r4, #0x52
	add r6, r0, #0x100
	add r7, r4, #0x150
	mov r5, #0
_021636F0:
	mov r0, r5
	bl _ZN10HubControl12Func_215B51CEl
	cmp r0, #0
	beq _02163720
	add ip, r4, r5, lsl #3
	ldr r1, [ip, #0x14c]
	mov r0, r5
	orr r3, r1, #1
	mov r1, r7
	mov r2, r6
	str r3, [ip, #0x14c]
	bl ViMapIcon__Func_21638D0
_02163720:
	add r5, r5, #1
	cmp r5, #8
	add r6, r6, #8
	add r7, r7, #8
	blt _021636F0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163738(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mvn r1, #0xf
	mov r6, r0
	mov r4, r2
	cmp r5, r1
	ldmleia sp!, {r4, r5, r6, pc}
	cmp r5, #0x110
	ldmgeia sp!, {r4, r5, r6, pc}
	cmp r4, r1
	ldmleia sp!, {r4, r5, r6, pc}
	cmp r4, #0xd0
	ldmgeia sp!, {r4, r5, r6, pc}
	strh r5, [r6, #0x7c]
	strh r4, [r6, #0x7e]
	mov r0, #1
	str r0, [r6, #0xcc]
	add r0, r6, #0x74
	bl AnimatorSprite__DrawFrame
	strh r5, [r6, #0x18]
	strh r4, [r6, #0x1a]
	mov r1, #0
	add r0, r6, #0x10
	str r1, [r6, #0x68]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_21637A0(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r1
	ldr r1, [r0, #0x144]
	ldr r5, [r0, #0x148]
	mov r8, r2
	cmp r5, r1
	blo _021637F8
	cmp r9, #0
	beq _021637D8
	ldr r1, [r0, #0x13c]
	add r1, r0, r1, lsl #3
	add r1, r1, #0x100
	ldrh r1, [r1, #0x50]
	strh r1, [r9]
_021637D8:
	cmp r8, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r1, [r0, #0x13c]
	add r0, r0, r1, lsl #3
	add r0, r0, #0x100
	ldrh r0, [r0, #0x52]
	strh r0, [r8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_021637F8:
	ldr r3, [r0, #0x13c]
	add r2, r0, #0x100
	add r0, r0, r3, lsl #3
	add r0, r0, #0x100
	ldrh r4, [r0, #0x50]
	ldrh r3, [r0, #0x52]
	mov r0, r5, lsl #0xc
	mov r6, r4, lsl #0xc
	mov r7, r3, lsl #0xc
	ldrh r5, [r2, #0x40]
	ldrh r4, [r2, #0x42]
	bl FX_DivS32
	smull r2, r1, r0, r0
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	cmp r9, #0
	rsb r0, r2, r0, lsl #1
	mov r2, #0
	mov r1, #0x800
	beq _02163874
	sub r3, r6, r5, lsl #12
	smull ip, r6, r3, r0
	adds r3, ip, r1
	adc r1, r6, r2
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r2, r5, lsl #12
	mov r1, r1, asr #0xc
	strh r1, [r9]
_02163874:
	cmp r8, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	sub r1, r7, r4, lsl #12
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, r4, lsl #12
	mov r0, r0, asr #0xc
	strh r0, [r8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_21638A4(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	strh r1, [r4, #0xe0]
	mov r1, #0
	strh r2, [r4, #0xe2]
	mov r2, r1
	add r0, r4, #0xd8
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xd8
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_21638D0(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r0, r0, lsl #0x10
	mov r5, r1
	mov r0, r0, lsr #0x10
	mov r4, r2
	bl HubConfig__Func_2152960
	cmp r5, #0
	ldrneh r1, [r0, #0]
	strneh r1, [r5]
	cmp r4, #0
	ldrneh r0, [r0, #2]
	strneh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163904(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r0, r0, lsl #0x10
	mov r4, r1
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	cmp r4, #3
	movhs r0, #9
	addlo r0, r0, r4, lsl #2
	ldrlo r0, [r0, #0xc]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_216392C(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r0, r0, lsl #0x10
	mov r4, r1
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	cmp r4, #3
	movhs r0, #9
	addlo r0, r0, r4, lsl #2
	ldrlo r0, [r0, #0x18]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_2163954(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r0, r0, lsl #0x10
	mov r4, r1
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	cmp r4, #3
	movhs r0, #9
	addlo r0, r0, r4, lsl #2
	ldrlo r0, [r0, #0x24]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapIcon__Func_216397C(CViMapIcon *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r0, r0, lsl #0x10
	mov r4, r1
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	cmp r4, #3
	movhs r0, #9
	addlo r0, r0, r4, lsl #2
	ldrlo r0, [r0, #0x30]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}