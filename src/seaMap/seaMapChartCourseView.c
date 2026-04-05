#include <seaMap/seaMapChartCourseView.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapCollision.h>
#include <seaMap/seaMapEventTrigger.h>
#include <seaMap/seaMapPenPalette.h>
#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED const void *word_210FA0C;
NOT_DECOMPILED const void *word_210FA10;
NOT_DECOMPILED const void *word_210FA16;
NOT_DECOMPILED const void *stru_210FA1C;
NOT_DECOMPILED const void *stru_210FA24;
NOT_DECOMPILED const void *stru_210FA2C;
NOT_DECOMPILED const void *stru_210FA34;
NOT_DECOMPILED const void *stru_210FA3C;
NOT_DECOMPILED const void *stru_210FA44;
NOT_DECOMPILED const void *byte_210FA4C;
NOT_DECOMPILED const void *byte_210FA4D;
NOT_DECOMPILED const void *stru_210FA58;
NOT_DECOMPILED const void *stru_210FA68;
NOT_DECOMPILED const void *byte_210FA78;
NOT_DECOMPILED const void *dword_210FA90;
NOT_DECOMPILED const void *dword_210FAB0;
NOT_DECOMPILED const void *dword_210FAD0;
NOT_DECOMPILED const void *dword_210FAF0;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void SeaMapChartCourseView__Create(BOOL useEngineB, ShipType shipType, s32 mode)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	ldr r4, =VRAMSystem__GFXControl
	mov r7, r0
	mov r5, r2
	ldr r6, =gSeaMapViewType
	mov ip, #3
	ldr r3, =gSeaMapViewExitEvent
	mov r2, #0
	ldr r4, [r4, r7, lsl #2]
	str ip, [r6]
	str r2, [r3]
	ldrsh r8, [r4, #0x58]
	mov r6, r1
	bl SeaMapManager__Create
	strh r8, [r4, #0x58]
	bl SeaMapManager__LoadMapBackground
	mov r0, #0xff
	mov r2, #0
	str r0, [sp]
	ldr r0, =0x00000ADC
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =SeaMapChartCourseView__Main
	ldr r1, =SeaMapChartCourseView__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, =gSeaMapTaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, =0x00000ADC
	bl MIi_CpuClear16
	cmp r5, #1
	beq _02040838
	ldr r2, =gSeaMapViewStoredVoyageDist
	mov r3, #0
	ldr r1, =SeaMapCourseChangeView_02134174
	ldr r0, =gameState
	str r3, [r2]
	str r3, [r1]
	str r3, [r0, #0xb0]
_02040838:
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, #1
	bl InitSeaMapView
	cmp r5, #2
	ldrne r1, =SeaMapChartCourseView__State_2041978
	ldrne r0, =SeaMapChartCourseView__Draw_2041440
	bne _02040870
	add r0, r4, #0x1d4
	add r0, r0, #0x800
	bl TouchField__Init
	ldr r1, =SeaMapChartCourseView__State_2042524
	ldr r0, =SeaMapChartCourseView__Draw_20414A0
_02040870:
	str r1, [r4, #0x7c4]
	str r0, [r4, #0x7c8]
	mov r0, r4
	str r5, [r4, #0x7b4]
	bl SeaMapChartCourseView__Func_2040B90
	ldr r1, =dword_210FAD0
	mov r0, r4
	bl SeaMapView_EnableMultipleButtons
	cmp r5, #1
	bne _020408AC
	mov r0, r4
	mov r1, #3
	mov r2, #0
	bl SeaMapView_EnableTouchArea
	b _020408C4
_020408AC:
	cmp r5, #2
	bne _020408C4
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl SeaMapView_EnableTouchArea
_020408C4:
	cmp r5, #2
	mov r0, r4
	bne _020408DC
	mov r1, #2
	bl SeaMapView_SetZoomLevel
	b _020408E4
_020408DC:
	mov r1, #0
	bl SeaMapView_SetZoomLevel
_020408E4:
	bl CreateSeaMapEventManager
	cmp r5, #0
	cmpne r5, #1
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl CreateSeaMapEventManagerDSPopup
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Destroy(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =gSeaMapTaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, =gSeaMapTaskSingleton
	mov r1, #0
	str r1, [r0]
	bl DestroySeaMapEventManager
	bl SeaMapManager__Destroy
	bl DestroyNavTails
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapChartCourseView__Func_2040978(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =gSeaMapTaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, [r0, #0x7cc]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0]
	mov r4, r2
	cmp r0, #0x400000
	ldr r1, [r1, #0x14]
	bhi _020409E4
	cmp r0, #0x400000
	bhs _02040A08
	cmp r0, #0x200000
	beq _02040A50
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_020409E4:
	cmp r0, #0x800000
	bhi _020409F8
	beq _02040AD8
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_020409F8:
	cmp r0, #0x1000000
	beq _02040AA4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02040A08:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, =touchInput
	mov r0, r4
	ldrh r3, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r1, r3, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2040FE8
	cmp r0, #0
	beq _02040A3C
	bl SeaMapView_DrawWIPVoyagePath
_02040A3C:
	mov r0, r4
	mvn r1, #0
	bl SeaMapView_InitTouchCursor
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02040A50:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x700
	ldrh r1, [r0, #0xb0]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	sub r1, r1, #1
	strh r1, [r0, #0xb0]
	ldrh r0, [r0, #0xb0]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	add sp, sp, #8
	str r0, [r4, #0x7ac]
	ldmia sp!, {r3, r4, r5, pc}
_02040AA4:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SeaMapView_CalculateVoyagePath
	bl SeaMapView_DrawFinalizedVoyagePath
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	add sp, sp, #8
	str r0, [r4, #0x7ac]
	ldmia sp!, {r3, r4, r5, pc}
_02040AD8:
	tst r1, #0x800
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, =touchInput
	mov r0, r4
	ldrh r3, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r1, r3, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2040FE8
	cmp r0, #0
	beq _02040B0C
	bl SeaMapView_DrawWIPVoyagePath
_02040B0C:
	mov r0, r4
	mvn r1, #0
	bl SeaMapView_InitTouchCursor
	ldr r0, [r4, #0x79c]
	cmp r0, #0x3000
	addle sp, sp, #8
	ldmleia sp!, {r3, r4, r5, pc}
	ldrsh r0, [r5, #4]
	cmp r0, #0
	ldreqsh r0, [r5, #6]
	cmpeq r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x7ac]
	cmp r0, #0
	bne _02040B78
	mov r1, #2
	mov r0, #0xa
	str r1, [sp]
	sub r1, r0, #0xb
	str r0, [sp, #4]
	ldr r0, [r4, #0x7a8]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #1
	str r0, [r4, #0x7ac]
_02040B78:
	add r0, r4, #0x700
	mov r1, #8
	strh r1, [r0, #0xb0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2040B90(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	mov r7, #0
	ldr r9, =byte_210FA4C
	ldr r5, =VRAMSystem__VRAM_PALETTE_OBJ
	add r8, r10, #0x7d0
	mov r6, r7
	mov r11, #0x800
	mov r4, #4
_02040BB8:
	ldr r0, [r10, #0xc]
	ldrb r1, [r9, #0]
	ldr r0, [r0, #0]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r10, #4]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r10, #4]
	mov r3, r11
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	str r6, [sp, #0xc]
	ldr r1, [r10, #4]
	mov r0, r8
	ldr r1, [r5, r1, lsl #2]
	str r1, [sp, #0x10]
	str r6, [sp, #0x14]
	ldrb r1, [r9, #1]
	str r1, [sp, #0x18]
	ldr r1, [r10, #0xc]
	ldrb r2, [r9], #2
	ldr r1, [r1, #0]
	bl AnimatorSprite__Init
	mov r1, #0
	strh r4, [r8, #0x50]
	mov r0, r8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r8, #0x3c]
	add r7, r7, #1
	orr r0, r0, #0x10
	str r0, [r8, #0x3c]
	cmp r7, #5
	add r8, r8, #0x64
	blo _02040BB8
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2040C54(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	add r5, r0, #0x7d0
	mov r4, #0
_02040C60:
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	cmp r4, #5
	add r5, r5, #0x64
	blo _02040C60
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2040C7C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x790]
	mov r4, #1
	cmp r1, #0
	beq _02040CAC
	cmp r1, #1
	beq _02040CF4
	cmp r1, #2
	beq _02040CFC
	b _02040D04
_02040CAC:
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, =gSeaMapViewExitEvent
	mov r1, #2
	str r1, [r0]
	ldr r0, [r5, #0x7b4]
	cmp r0, #2
	ldreq r0, =SeaMapChartCourseView__State_20431D4
	streq r0, [r5, #0x7c4]
	ldrne r0, =SeaMapChartCourseView__State_2041E30
	strne r0, [r5, #0x7c4]
	b _02040D08
_02040CF4:
	bl SeaMapChartCourseView__Func_20416F0
	b _02040D08
_02040CFC:
	bl SeaMapChartCourseView__Func_2041834
	b _02040D08
_02040D04:
	mov r4, #0
_02040D08:
	mvn r1, #0
	mov r0, r4
	str r1, [r5, #0x790]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2040D28(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl SeaMapManager__GetWork
	bl GetSeaMapEventManagerWork2
	mov r6, r0
	ldr r0, [r6, #0]
	mov r4, #1
	cmp r0, #0
	bne _02040DC8
	mov r2, #2
	mov r0, #0
	sub r1, r0, #1
	str r2, [sp]
	mov ip, #3
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r6, #4]
	str r0, [r5, #0x9c4]
	bl SeaMapEventManager_ClearLastTouchedIcon
	ldr r1, [r5, #0x9c4]
	add r2, sp, #8
	ldrsh r0, [r1, #0xc]
	ldrsh r1, [r1, #0xe]
	add r3, sp, #0xa
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl SeaMapManager__Func_2043B28
	ldrh r0, [sp, #8]
	ldrh r1, [sp, #0xa]
	bl SeaMapManager__AddNode
	ldr r0, [r5, #0x7b4]
	cmp r0, #2
	ldreq r0, =SeaMapChartCourseView__State_2042D14
	streq r0, [r5, #0x7c4]
	ldrne r0, =SeaMapChartCourseView__State_2041A68
	strne r0, [r5, #0x7c4]
	b _02040DCC
_02040DC8:
	mov r4, #0
_02040DCC:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2040DE0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x790]
	mov r4, #1
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _02040EC8
_02040E00: // jump table
	b _02040EC8 // case 0
	b _02040EB0 // case 1
	b _02040EBC // case 2
	b _02040E6C // case 3
	b _02040E14 // case 4
_02040E14:
	mov ip, #2
	mov r0, #0
	sub r1, r0, #1
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r5, #0x7b4]
	cmp r0, #1
	bne _02040E60
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	ldrls r0, =SeaMapChartCourseView__State_2041DD0
	strls r0, [r5, #0x7c4]
	bls _02040ECC
	mov r0, r5
	bl SeaMapChartCourseView__Func_2041048
	b _02040ECC
_02040E60:
	mov r0, r5
	bl SeaMapChartCourseView__Func_2041048
	b _02040ECC
_02040E6C:
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	mov r0, r5
	bl SeaMapChartCourseView__Func_2042208
	ldr r0, [r5, #0x7b4]
	cmp r0, #2
	ldreq r0, =SeaMapChartCourseView__State_2042FA8
	streq r0, [r5, #0x7c4]
	ldrne r0, =SeaMapChartCourseView__State_2041C64
	strne r0, [r5, #0x7c4]
	b _02040ECC
_02040EB0:
	bl SeaMapChartCourseView__Func_20416F0
	bl SeaMapView_DrawFinalizedVoyagePath
	b _02040ECC
_02040EBC:
	bl SeaMapChartCourseView__Func_2041834
	bl SeaMapView_DrawFinalizedVoyagePath
	b _02040ECC
_02040EC8:
	mov r4, #0
_02040ECC:
	mvn r1, #0
	mov r0, r4
	str r1, [r5, #0x790]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2040EEC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x790]
	mov r4, #1
	cmp r0, #6
	beq _02040F14
	cmp r0, #7
	beq _02040F4C
	b _02040F84
_02040F14:
	mov ip, #2
	mov r0, #0
	sub r1, r0, #1
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r0, [r5, #0x9c8]
	cmp r0, #0
	cmpne r0, #1
	ldreq r0, =SeaMapChartCourseView__State_2041A68
	streq r0, [r5, #0x7c4]
	b _02040F88
_02040F4C:
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	ldr r0, =gSeaMapViewExitEvent
	mov r2, #2
	ldr r1, =SeaMapChartCourseView__State_2041E30
	str r2, [r0]
	str r1, [r5, #0x7c4]
	b _02040F88
_02040F84:
	mov r4, #0
_02040F88:
	mvn r1, #0
	mov r0, r4
	str r1, [r5, #0x790]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__SetTouchCallback(SeaMapChartCourseView *work, s32 mode)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	movs r4, r1
	mov r5, r0
	beq _02040FC4
	cmp r4, #1
	beq _02040FD0
	b _02040FD8
_02040FC4:
	ldr r1, =SeaMapChartCourseView__TouchAreaCallback
	bl SeaMapView_SetTouchAreaCallback
	b _02040FD8
_02040FD0:
	ldr r1, =SeaMapView_TouchAreaCallback_Active
	bl SeaMapView_SetTouchAreaCallback
_02040FD8:
	str r4, [r5, #0x9c8]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapChartCourseView__Func_2040FE8(SeaMapChartCourseView *work, u8 x, u8 y)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r0, r1
	mov r1, r2
	add r2, sp, #0
	add r3, sp, #2
	bl SeaMapManager__Func_2043A9C
	ldrh r1, [sp]
	ldrh r2, [sp, #2]
	mov r0, r4
	bl SeaMapView_TryAddVoyagePathNode
	mvn r1, #1
	cmp r0, r1
	addne r1, r1, #1
	cmpne r0, r1
	cmpne r0, #0
	bne _0204103C
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r3, r4, pc}
_0204103C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041048(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x7b4]
	cmp r0, #1
	bne _02041094
	bl SeaMapManager__GetStartNode
	ldrh r5, [r0, #8]
	ldrh r6, [r0, #0xa]
	mov r0, r4
	bl SeaMapView_ClearVoyagePath
	mov r0, r5
	mov r1, r6
	bl SeaMapManager__AddNode
	bl SeaMapView_DrawFinalizedVoyagePath
	mov r0, r4
	mov r1, #3
	mov r2, #0
	bl SeaMapView_EnableTouchArea
	ldmia sp!, {r4, r5, r6, pc}
_02041094:
	ldr r0, [r4, #0x9c4]
	bl SeaMapEventManager_ClearDrawIconButtonState
	mov r0, #0
	str r0, [r4, #0x9c4]
	bl SeaMapEventManager_ClearLastTouchedIcon
	ldr r1, =dword_210FAD0
	mov r0, r4
	bl SeaMapView_EnableMultipleButtons
	mov r0, r4
	bl SeaMapView_ClearVoyagePath
	bl SeaMapView_DrawFinalizedVoyagePath
	ldr r1, =SeaMapView_TouchAreaCallback_Active
	mov r0, r4
	bl SeaMapView_SetTouchAreaCallback
	ldr r0, [r4, #0x7b4]
	cmp r0, #2
	ldrne r0, =SeaMapChartCourseView__State_20419B0
	strne r0, [r4, #0x7c4]
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, #0
	ldr r0, =SeaMapChartCourseView__State_2042C6C
	str r1, [r4, #0xab8]
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041104(int a1, int a2, int a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	mov r4, r2
	bl IsSeaMapViewVoyageInProgress
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	bl SeaMapManager__GetNodeCount
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, sp, #2
	add r1, sp, #0
	bl SeaMapManager__GetLastNodePosition
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	add r2, sp, #6
	add r3, sp, #4
	bl SeaMapManager__Func_2043AD4
	ldrsh r2, [sp, #6]
	cmp r2, #0
	blt _02041184
	cmp r2, #0x100
	bge _02041184
	ldrsh r0, [sp, #4]
	cmp r0, #0
	blt _02041184
	cmp r0, #0xc0
	blt _02041190
_02041184:
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_02041190:
	sub r1, r0, r4
	sub r0, r2, r5
	movs r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, =0x00000F5E
	ldr r3, =0x0000065D
	mov ip, #0
	ble _02041208
	umull lr, r6, r0, r2
	mla r6, r0, ip, r6
	umull r5, r4, r1, r3
	mov r0, r0, asr #0x1f
	mla r6, r0, r2, r6
	adds lr, lr, #0x800
	adc r6, r6, #0
	adds r2, r5, #0x800
	mov r5, lr, lsr #0xc
	mla r4, r1, ip, r4
	mov r0, r1, asr #0x1f
	mla r4, r0, r3, r4
	adc r0, r4, #0
	mov r1, r2, lsr #0xc
	orr r5, r5, r6, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
	b _0204124C
_02041208:
	umull r6, r5, r1, r2
	mla r5, r1, ip, r5
	umull r4, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r5, r1, r2, r5
	adds r6, r6, #0x800
	adc r2, r5, #0
	adds r1, r4, #0x800
	mla lr, r0, r3, lr
	mov r4, r6, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r4, r4, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r4, r1
_0204124C:
	cmp r0, #0x8000
	movgt r0, #1
	movle r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapChartCourseView__Func_2041268(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r0, =touchInput
	add r2, sp, #2
	ldrh r1, [r0, #0x16]
	ldrh r4, [r0, #0x14]
	add r3, sp, #0
	and r1, r1, #0xff
	and r0, r4, #0xff
	bl SeaMapManager__Func_2043B7C
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	mov r2, #1
	bl SeaMapCollision__Collide
	cmp r0, #0
	beq _020413A4
	bl SeaMapManager__GetEndNode
	mov r1, r0
	ldrh r0, [r1, #8]
	ldrh r1, [r1, #0xa]
	add r2, sp, #4
	add r3, sp, #6
	bl SeaMapManager__Func_2043AD4
	ldr r0, =touchInput
	ldrsh r1, [sp, #6]
	ldrh r3, [r0, #0x16]
	ldrh r2, [r0, #0x14]
	ldrsh r0, [sp, #4]
	sub r1, r3, r1
	mov r1, r1, lsl #0xc
	sub r0, r2, r0
	movs r0, r0, lsl #0xc
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, =0x00000F5E
	ldr r3, =0x0000065D
	mov ip, #0
	ble _02041350
	umull lr, r6, r0, r2
	mla r6, r0, ip, r6
	umull r5, r4, r1, r3
	mov r0, r0, asr #0x1f
	mla r6, r0, r2, r6
	adds lr, lr, #0x800
	adc r6, r6, #0
	adds r2, r5, #0x800
	mov r5, lr, lsr #0xc
	mla r4, r1, ip, r4
	mov r0, r1, asr #0x1f
	mla r4, r0, r3, r4
	adc r0, r4, #0
	mov r1, r2, lsr #0xc
	orr r5, r5, r6, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
	b _02041394
_02041350:
	umull r6, r5, r1, r2
	mla r5, r1, ip, r5
	umull r4, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r5, r1, r2, r5
	adds r6, r6, #0x800
	adc r2, r5, #0
	adds r1, r4, #0x800
	mla lr, r0, r3, lr
	mov r4, r6, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r4, r4, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r4, r1
_02041394:
	cmp r0, #0x8000
	addgt sp, sp, #8
	movgt r0, #1
	ldmgtia sp!, {r4, r5, r6, pc}
_020413A4:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x7c4]
	blx r1
	ldr r0, [r4, #0x7cc]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x7c8]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapChartCourseView__Func_2040C54
	ldr r0, [r4, #0x7b4]
	cmp r0, #2
	bne _02041418
	ldr r0, [r4, #0xab0]
	cmp r0, #0
	beq _02041418
	bl SeaMapEventTrigger_RemoveEventListener
_02041418:
	mov r0, r4
	bl ReleaseSeaMapView
	ldr r1, =gSeaMapViewType
	mov r2, #0
	ldr r0, =gSeaMapTaskSingleton
	str r2, [r1]
	str r2, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Draw_2041440(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapChartCourseView__Func_204153C
	mov r0, r4
	bl SeaMapView_ProcessIndicatorFlashTimer
	ldr r0, [r4, #0x9cc]
	cmp r0, #0
	beq _02041468
	mov r0, r4
	bl SeaMapView_DrawIndicators
_02041468:
	mov r0, r4
	bl SeaMapView_ReadPosition
	mov r0, r4
	bl SeaMapView_DrawButtons
	mov r0, r4
	bl SeaMapView_DrawTouchCursor
	mov r0, r4
	bl SeaMapView_DrawPenMarker
	ldr r0, [r4, #0x9d0]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl SeaMapView_SetVoyagePathColors
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Draw_20414A0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r1, r5, #0x1d4
	add r4, r1, #0x800
	bl SeaMapChartCourseView__Func_204153C
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	beq _020414E0
	mov r0, r5
	bl SeaMapView_ProcessIndicatorFlashTimer
	ldr r0, [r5, #0x9cc]
	cmp r0, #0
	beq _020414E0
	mov r0, r5
	bl SeaMapView_DrawIndicators
_020414E0:
	mov r0, r5
	bl SeaMapView_ReadPosition
	mov r0, r5
	bl SeaMapView_DrawButtons
	mov r0, r5
	bl SeaMapView_DrawTouchCursor
	mov r0, r5
	bl SeaMapView_DrawPenMarker
	ldr r0, [r5, #0x9d0]
	cmp r0, #0
	bne _02041514
	mov r0, r5
	bl SeaMapView_SetVoyagePathColors
_02041514:
	ldr r0, [r4, #0xcc]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x28
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x28
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_204153C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	add r0, r5, #0x7d0
	mov r1, #0xe
	strh r1, [r0, #8]
	mov r1, #0xf
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x798]
	mov r1, #8
	mov r0, r0, asr #0xc
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	add r1, r5, #0x34
	movs r4, r0, lsr #0x10
	add r7, r1, #0x800
	mov r6, #0
	beq _020415B0
_02041584:
	mov r0, r6
	add r1, r7, #8
	add r2, r7, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhi _02041584
_020415B0:
	add r0, r5, #0x98
	add r6, r0, #0x800
	mov r0, r4
	add r1, r6, #8
	add r2, r6, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x79c]
	ldr r1, =0x04000280
	mov r2, #0
	strh r2, [r1]
	mov r0, r0, asr #0xc
	str r0, [r1, #0x10]
	mov r0, #8
	str r0, [r1, #0x18]
	str r2, [r1, #0x1c]
_020415F4:
	ldrh r0, [r1, #0]
	tst r0, #0x8000
	bne _020415F4
	ldr r1, =0x040002A0
	ldr r0, [r1, #0]
	sub r1, r1, #0x20
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_02041614:
	ldrh r0, [r1, #0]
	tst r0, #0x8000
	bne _02041614
	ldr r0, =0x040002A8
	mov r1, #8
	ldr r0, [r0, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0xd
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	add r1, r5, #0xfc
	cmp r4, #0
	mov r6, r0, lsr #0x10
	add r7, r1, #0x800
	mov r8, #0
	bls _02041680
_02041654:
	mov r0, r8
	add r1, r7, #8
	add r2, r7, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r4, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _02041654
_02041680:
	cmp r6, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	rsb r0, r6, #0x24
	add r5, r5, #0x960
	mov r1, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	add r1, r5, #8
	add r2, r5, #0xa
	bl SeaMapChartCourseView__Func_20416D8
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_20416D8(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r0, r0, lsl #3
	add r0, r0, #0x1c
	strh r0, [r1]
	mov r0, #8
	strh r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_20416F0(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #0x7c4]
	ldr r1, =SeaMapChartCourseView__State_2041708
	str r2, [r0, #0x7c0]
	str r1, [r0, #0x7c4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041708(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	mov r3, #2
	sub r1, r0, #1
	str r3, [sp]
	mov r3, #0xe
	str r3, [sp, #4]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, =SeaMapChartCourseView__State_204176C
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_204176C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomIn_Intro
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__State_2041794
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041794(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #1
	beq _020417B4
	cmp r0, #2
	beq _020417C4
	b _020417D0
_020417B4:
	mov r0, r4
	mov r1, #0
	bl SeaMapView_SetZoomLevel
	b _020417D0
_020417C4:
	mov r0, r4
	mov r1, #1
	bl SeaMapView_SetZoomLevel
_020417D0:
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	bl SeaMapView_DrawFinalizedVoyagePath
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	ldr r1, =SeaMapChartCourseView__State_2041804
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041804(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomIn_Outro
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7c0]
	mov r0, #1
	str r1, [r4, #0x7c4]
	bl SeaMapManager__EnableTouchField
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041834(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #0x7c4]
	ldr r1, =SeaMapChartCourseView__Func_204184C
	str r2, [r0, #0x7c0]
	str r1, [r0, #0x7c4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_204184C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	mov r3, #2
	sub r1, r0, #1
	str r3, [sp]
	mov r3, #0xf
	str r3, [sp, #4]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, =SeaMapChartCourseView__Func_20418B0
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_20418B0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomOut_Intro
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__Func_20418D8
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_20418D8(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _020418F8
	cmp r0, #1
	beq _02041908
	b _02041914
_020418F8:
	mov r0, r4
	mov r1, #1
	bl SeaMapView_SetZoomLevel
	b _02041914
_02041908:
	mov r0, r4
	mov r1, #2
	bl SeaMapView_SetZoomLevel
_02041914:
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	bl SeaMapView_DrawFinalizedVoyagePath
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	ldr r1, =SeaMapChartCourseView__Func_2041948
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041948(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomOut_Outro
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7c0]
	mov r0, #1
	str r1, [r4, #0x7c4]
	bl SeaMapManager__EnableTouchField
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041978(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView_FadeActiveScreen_ToDefault
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x7b4]
	cmp r0, #1
	ldreq r0, =SeaMapChartCourseView__State_2041A68
	streq r0, [r4, #0x7c4]
	ldrne r0, =SeaMapChartCourseView__State_20419B0
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20419B0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =gSeaMapViewType
	mov r2, #3
	mov r4, r0
	str r2, [r1]
	bl SeaMapView_ResetIndicatorFlashTimer
	ldr r1, =dword_210FAD0
	mov r0, r4
	bl SeaMapView_EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView_SetZoomLevelForZoomButtons
	mov r0, #0x28
	mov r1, #0x258
	bl NavTailsSpeak
	mov r0, #1
	str r0, [r4, #0x9cc]
	ldr r1, =SeaMapChartCourseView__State_2041A18
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041A18(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView_ProcessMapInputs
	mov r0, r4
	bl SeaMapView_ProcessButtonInputs
	bl GetSeaMapEventManagerWork2
	ldr r1, [r0, #0]
	mvn r0, #0
	cmp r1, r0
	mov r0, r4
	beq _02041A60
	bl SeaMapChartCourseView__Func_2040D28
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x7c4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_02041A60:
	bl SeaMapChartCourseView__Func_2040C7C
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041A68(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =gSeaMapViewType
	mov r2, #4
	mov r4, r0
	str r2, [r1]
	bl SeaMapView_ResetIndicatorFlashTimer
	mov r2, #1
	ldr r1, =dword_210FAF0
	mov r0, r4
	str r2, [r4, #0x9cc]
	bl SeaMapView_EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView_SetZoomLevelForZoomButtons
	mov r0, r4
	mov r1, #0
	bl SeaMapChartCourseView__SetTouchCallback
	mov r0, r4
	mov r1, #0
	bl SeaMapView_SetTouchAreaPriority
	ldr r1, =SeaMapChartCourseView__State_2041ADC
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041ADC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetSeaMapEventManagerWork2
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02041B48
	ldr r0, =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #4
	beq _02041B48
	ldrh r1, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	mov r0, r4
	and r1, r1, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2041104
	mov r1, r0
	mov r0, r4
	bl SeaMapChartCourseView__SetTouchCallback
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	beq _02041C4C
	mov r0, r4
	bl SeaMapView_ClearLocalMoveInputs
	b _02041C4C
_02041B48:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02041BFC
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	beq _02041BFC
	mov r0, r4
	bl SeaMapView_ResetIndicatorFlashTimer
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02041C4C
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	str r0, [r4, #0x7ac]
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bne _02041BA4
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r4, pc}
_02041BA4:
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bls _02041C4C
	bl SeaMapManager__GetTotalDistance
	cmp r0, #0x8000
	bge _02041BC8
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r4, pc}
_02041BC8:
	ldr r0, [r4, #0x7b4]
	cmp r0, #1
	bne _02041C4C
	mov r0, r4
	mov r1, #3
	bl IsSeaMapViewTouchAreaActive
	cmp r0, #0
	bne _02041C4C
	mov r0, r4
	mov r1, #3
	mov r2, #1
	bl SeaMapView_EnableTouchArea
	b _02041C4C
_02041BFC:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02041C4C
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _02041C4C
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02041C4C
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041268
	cmp r0, #0
	beq _02041C4C
	bl CheckNavTailsSpeaking
	cmp r0, #0x29
	beq _02041C4C
	mov r0, #0x29
	mov r1, #0x258
	bl NavTailsSpeak
_02041C4C:
	mov r0, r4
	bl SeaMapView_ProcessButtonInputs
	mov r0, r4
	bl SeaMapChartCourseView__Func_2040DE0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041C64(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r4, r0
	mov r2, #0
	ldr r1, =dword_210FA90
	str r2, [r4, #0x9cc]
	bl SeaMapView_EnableMultipleButtons
	ldr r1, [r4, #4]
	add r0, sp, #0
	mov r2, #3
	bl InitSpriteButtonConfig
	ldr r1, [r4, #0x38]
	add r0, sp, #0
	str r1, [sp, #8]
	ldr r6, [r4, #0x3c]
	mov r5, #1
	mov lr, #2
	mov ip, #3
	mov r3, #0
	mov r2, #4
	mov r1, #0x3540
	str r6, [sp, #0xc]
	strh r5, [sp, #0x10]
	strh lr, [sp, #0x12]
	strh ip, [sp, #0x14]
	strb r3, [sp, #0x1c]
	strb r2, [sp, #0x1d]
	strh r1, [sp, #0x16]
	bl CreateSpriteButton
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0x2b
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, =SeaMapChartCourseView__State_2041D04
	str r0, [r4, #0x7c4]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041D04(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl GetSelectedSpriteButton
	cmp r0, #0
	beq _02041D2C
	cmp r0, #1
	beq _02041D70
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02041D2C:
	bl DestroySpriteButton
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	bl SeaMapManager__UpdateGlobalNodeList
	ldr r0, =gSeaMapViewExitEvent
	mov r2, #1
	ldr r1, =SeaMapChartCourseView__State_2041E30
	str r2, [r0]
	add sp, sp, #8
	str r1, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
_02041D70:
	bl DestroySpriteButton
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	mov r0, #0x28
	mov r1, #0x258
	bl NavTailsSpeak
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	cmpne r0, #1
	ldreq r0, =SeaMapChartCourseView__State_2041A68
	streq r0, [r4, #0x7c4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041DD0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =dword_210FAB0
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x9cc]
	bl SeaMapView_EnableMultipleButtons
	ldr r1, =SeaMapView_TouchAreaCallback_Inactive
	mov r0, r4
	bl SeaMapView_SetTouchAreaCallback
	mov r0, r4
	mov r1, #1
	bl SeaMapView_SetTouchAreaPriority
	mov r0, #0x2b
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, =SeaMapChartCourseView__State_2041E24
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041E24(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapChartCourseView__State_2040EEC
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2041E30(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #1
	str r1, [r0, #0x7cc]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041E3C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mov r4, r2
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SeaMapEventManager_GetObjectType
	cmp r0, #2
	cmpne r0, #3
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r0, [r4, #7]
	tst r0, #1
	ldreqsh r0, [r4, #0x10]
	cmpeq r0, #3
	moveq r0, #1
	streq r0, [r5, #0xab8]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041E80(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	add r6, r0, #0x1d4
	add r0, r6, #0x900
	ldrh r3, [r0, #0]
	mov r5, r1
	mov r4, r2
	add r1, r3, #1
	strh r1, [r0]
	cmp r3, #0x258
	blo _02041F18
	bl CheckNavTailsSpeaking
	cmp r4, #0
	mov r2, #0
	bls _02041EEC
_02041EB8:
	mov r1, r2, lsl #1
	ldrh r1, [r5, r1]
	cmp r0, r1
	bne _02041ED8
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	b _02041EEC
_02041ED8:
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	cmp r4, r1, lsr #16
	mov r2, r1, lsr #0x10
	bhi _02041EB8
_02041EEC:
	cmp r4, r2
	movls r2, #0
	mov r0, r2, lsl #1
	ldrh r0, [r5, r0]
	mov r1, #0
	bl NavTailsSpeak
	add r0, r6, #0x900
	mov r1, #0
	strh r1, [r0]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_02041F18:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041F20(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r3, =byte_210FA78
	mov r2, #0xb
	mla r5, r1, r2, r3
	mov r7, #0
	ldr r0, [r0, #0xc]
	mov r8, r7
	ldr r6, [r0, #0]
	mov r4, r7
_02041F44:
	mov r9, r4
_02041F48:
	ldrb r1, [r5, r8]
	mov r0, r6
	add r1, r9, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r7, r0
	add r9, r9, #1
	movlo r7, r0
	cmp r9, #2
	blt _02041F48
	add r8, r8, #1
	cmp r8, #8
	blt _02041F44
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2041F8C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0]
	add r0, r2, #0x1d4
	cmp r3, #0x1000000
	add r2, r0, #0x800
	ldr r0, [r1, #0x14]
	bhi _02041FD0
	cmp r3, #0x1000000
	bhs _02042004
	cmp r3, #0x40000
	bhi _02041FC4
	moveq r0, #1
	streq r0, [r2, #0xd0]
	ldmia sp!, {r3, pc}
_02041FC4:
	cmp r3, #0x400000
	beq _02041FEC
	ldmia sp!, {r3, pc}
_02041FD0:
	cmp r3, #0x2000000
	bhi _02041FE0
	beq _02041FEC
	ldmia sp!, {r3, pc}
_02041FE0:
	cmp r3, #0x8000000
	beq _02042004
	ldmia sp!, {r3, pc}
_02041FEC:
	tst r0, #0x800
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x28
	mov r1, #1
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
_02042004:
	tst r0, #0x800
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x28
	mov r1, #0
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_204201C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x24
	mov r9, r0
	add r0, r9, #0x1d4
	add r5, r0, #0x800
	ldr r2, =byte_210FA78
	mov r8, r1
	mov r0, #0xb
	mla r4, r8, r0, r2
	add r6, r5, #0x28
	ldr r7, [r9, #4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02042080
_0204205C: // jump table
	b _02042074 // case 0
	b _02042074 // case 1
	b _02042074 // case 2
	b _02042074 // case 3
	b _02042074 // case 4
	b _02042074 // case 5
_02042074:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02042084
_02042080:
	mov r0, #1
_02042084:
	ldrb r0, [r4, r0]
	mov r2, #0
	strh r0, [r6, #0xa2]
_02042090:
	add r0, r4, r2
	ldrb r1, [r0, #8]
	add r0, r6, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blt _02042090
	mov r0, r9
	mov r1, r8
	bl SeaMapChartCourseView__Func_2041F20
	mov r1, r0
	mov r0, r7
	bl VRAMSystem__AllocSpriteVram
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	str r7, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r1, [r1, r7, lsl #2]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r0, [r9, #0xc]
	ldrh r2, [r6, #0xa2]
	ldr r1, [r0, #0]
	mov r0, r6
	mov r3, #4
	bl AnimatorSprite__Init
	ldrh r2, [r6, #0x9c]
	mov r1, #0x80
	mov r0, r6
	strh r2, [r6, #0x50]
	strh r1, [r6, #8]
	strh r1, [r6, #0xa]
	mov r1, #0
	add r2, sp, #0x1c
	bl AnimatorSprite__GetBlockData
	ldr r1, =SeaMapChartCourseView__Func_2041F8C
	ldr r2, =TouchField__PointInRect
	stmia sp, {r1, r9}
	add r0, r6, #0x64
	add r1, r6, #8
	add r3, sp, #0x1c
	bl TouchField__InitAreaShape
	mov r0, r5
	add r1, r6, #0x64
	mov r2, #0x10
	bl TouchField__AddArea
	mov r0, r6
	mov r1, #0
	bl SetSpriteButtonState
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2042178(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	add r0, r0, #0x1d4
	add r4, r0, #0x800
	add r0, r4, #0x28
	bl AnimatorSprite__Release
	mov r0, r4
	add r1, r4, #0x8c
	bl TouchField__RemoveArea
	add r1, r4, #0x28
	mov r0, #0
	mov r2, #0xa4
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_20421AC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	add r4, r0, #0x1d4
	ldr r0, [r4, #0x8d8]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	bl SeaMapEventManager_GetObjectFromID
	mov r5, r0
	mov r0, #1
	bl SeaMapEventManager_GetObjectFromID
	mov r1, #0x16
	str r1, [sp]
	ldrsh r1, [r5, #4]
	ldrsh r2, [r0, #2]
	ldrsh r3, [r0, #4]
	ldrsh ip, [r5, #2]
	mov r1, r1, lsl #0xc
	mov r2, r2, lsl #0xc
	mov r0, ip, lsl #0xc
	mov r3, r3, lsl #0xc
	bl CreateSeaMapEventManagerStylusIcon
	str r0, [r4, #0x8d8]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__Func_2042208(SeaMapChartCourseView *work)
{
    // https://decomp.me/scratch/pOFOA -> 76.67%
#ifdef NON_MATCHING
    SeaMapStylusIcon *stylusIcon = work->stylusIcon;
    if (stylusIcon != NULL)
    {
        DestroySeaMapEventManagerStylusIcon(&stylusIcon->objWork);
        work->stylusIcon = NULL;
    }
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	add r4, r0, #0x1d4
	ldr r0, [r4, #0x8d8]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl DestroySeaMapEventManagerStylusIcon
	mov r0, #0
	str r0, [r4, #0x8d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__StartNavTailsTalk(SeaMapChartCourseView *work, SeaMapChartCourseViewNavTailsTalk *seqList, s16 seqCount,
                                                            void (*nextState)(SeaMapChartCourseView *work), s32 a5)
{
    // https://decomp.me/scratch/9PaS1 -> 81.05%
#ifdef NON_MATCHING
    work->navTailsSequenceList  = seqList;
    work->navTailsSequenceCount = seqCount;
    work->nextState             = nextState;
    work->navTailsSequenceID    = 0;
    work->field_9F8             = a5;

    StopStageSfx(work->view.sndHandle);

    work->view.unknown1 = 0;
    work->state          = SeaMapChartCourseView__State_2042278;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1d4
	add ip, r0, #0x800
	str r1, [ip, #0x18]
	strh r2, [ip, #0x1c]
	str r3, [ip, #0x20]
	mov r1, #0
	ldr r0, [sp, #8]
	strh r1, [ip, #0x1e]
	str r0, [ip, #0x24]
	ldr r0, [r4, #0x7a8]
	bl NNS_SndPlayerStopSeq
	mov r1, #0
	ldr r0, =SeaMapChartCourseView__State_2042278
	str r1, [r4, #0x7ac]
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042278(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x1d4
	bl SeaMapView_ClearLocalMoveInputs
	mov r0, r5
	bl SeaMapView_ProcessMapInputs
	ldr r0, [r4, #0x824]
	cmp r0, #0
	ldreq r0, =SeaMapChartCourseView__State_204231C
	streq r0, [r5, #0x7c4]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl CreateSeaMapPenPalette
	mov r1, #1
	str r0, [r4, #0x8e0]
	bl SetSeaMapPenPaletteMode
	mov r1, #1
	ldr r0, =SeaMapChartCourseView__State_20422D4
	str r1, [r5, #0x9d0]
	str r0, [r5, #0x7c4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20422D4(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xab4]
	bl GetSeaMapPenPaletteMode
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042308
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	ldmneia sp!, {r4, pc}
_02042308:
	ldr r0, =SeaMapChartCourseView__State_204231C
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_204231C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x1d4
	add r5, r0, #0x800
	ldrh r2, [r5, #0x1e]
	ldr r3, [r5, #0x18]
	mov r1, #0
	mov r0, r2, lsl #3
	ldrh r0, [r3, r0]
	add r6, r3, r2, lsl #3
	bl NavTailsSpeak
	ldr r1, [r6, #4]
	cmp r1, #2
	movge r0, #0
	strgeh r0, [r5, #0xd4]
	bge _02042370
	mov r0, r4
	bl SeaMapChartCourseView__Func_204201C
	mov r0, #0
	str r0, [r5, #0xd0]
	str r0, [r5, #0xcc]
_02042370:
	ldr r1, =SeaMapChartCourseView__State_2042388
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042388(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	add r0, r6, #0x1d4
	add r4, r0, #0x800
	ldrh r0, [r4, #0x1e]
	ldr r1, [r4, #0x18]
	add r5, r1, r0, lsl #3
	bl CheckNavTailsLastDialog
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #4]
	mov r5, #0
	cmp r0, #2
	bge _0204244C
	ldr r0, [r4, #0xcc]
	cmp r0, #0
	bne _02042400
	mov ip, #4
	sub r1, ip, #5
	mov r0, #2
	str r0, [sp]
	mov r0, r5
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	mov r0, #1
	str r0, [r4, #0xcc]
_02042400:
	mov r0, r4
	bl TouchField__Process
	ldr r0, [r4, #0xd0]
	cmp r0, #0
	beq _02042460
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	mov r0, r6
	bl SeaMapChartCourseView__Func_2042178
	mov r0, #0
	str r0, [r4, #0xcc]
	mov r5, #1
	b _02042460
_0204244C:
	ldrh r1, [r4, #0xd4]
	add r0, r1, #1
	cmp r1, #0x12c
	strh r0, [r4, #0xd4]
	movhi r5, #1
_02042460:
	cmp r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r4, #0x1e]
	add r0, r0, #1
	strh r0, [r4, #0x1e]
	ldrh r1, [r4, #0x1e]
	ldrh r0, [r4, #0x1c]
	cmp r1, r0
	ldrlo r0, =SeaMapChartCourseView__State_204231C
	addlo sp, sp, #8
	strlo r0, [r6, #0x7c4]
	ldmloia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x24]
	cmp r0, #0
	beq _020424BC
	ldr r0, [r4, #0xe0]
	mov r1, #2
	bl SetSeaMapPenPaletteMode
	ldr r0, =SeaMapChartCourseView__State_20424DC
	add sp, sp, #8
	str r0, [r6, #0x7c4]
	ldmia sp!, {r4, r5, r6, pc}
_020424BC:
	ldr r1, [r4, #0x20]
	mov r0, r6
	str r1, [r6, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20424DC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x1d4
	ldr r0, [r4, #0x8e0]
	bl GetSeaMapPenPaletteMode
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r5, #0x9d0]
	ldr r0, [r4, #0x8e0]
	bl DestroySeaMapPenPalette
	mov r0, #0
	str r0, [r4, #0x8e0]
	ldr r1, [r4, #0x820]
	mov r0, r5
	str r1, [r5, #0x7c4]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042524(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =dword_210FAD0
	mov r4, r0
	bl SeaMapView_EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView_SetZoomLevelForZoomButtons
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	bl SeaMapEventManager_GetObjectFromID
	ldrsh r1, [r0, #4]
	ldrsh r2, [r0, #2]
	mov r1, r1, lsl #0xc
	mov r0, r2, lsl #0xc
	bl SetSeaMapViewPosition
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	ldr r1, =SeaMapChartCourseView__State_204258C
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_204258C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView_FadeActiveScreen_ToDefault
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__State_20425AC
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20425AC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, =SeaMapChartCourseView__State_20425D0
	add r1, r0, #0xa00
	mov r3, #0
	strh r3, [r1, #0xd8]
	str r2, [r0, #0x7c4]
	blx r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20425D0(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x1d4
	add r1, r1, #0x900
	ldrh r3, [r1, #4]
	add r2, r3, #1
	strh r2, [r1, #4]
	cmp r3, #0x3c
	ldrhi r1, =SeaMapChartCourseView__State_20425F8
	strhi r1, [r0, #0x7c4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20425F8(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =stru_210FA1C
	mov r2, #1
	ldr r3, =SeaMapChartCourseView__State_204261C
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_204261C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, =SeaMapChartCourseView__State_2042640
	add r1, r0, #0xa00
	mov r3, #0
	strh r3, [r1, #0xd8]
	str r2, [r0, #0x7c4]
	blx r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042640(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x1d4
	add r1, r1, #0x900
	ldrh r3, [r1, #4]
	add r2, r3, #1
	strh r2, [r1, #4]
	cmp r3, #0x1e
	ldrhi r1, =SeaMapChartCourseView__State_2042668
	strhi r1, [r0, #0x7c4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042668(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov ip, #0xe
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	ldr r1, =SeaMapChartCourseView__State_TryZoomIn
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_TryZoomIn(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomIn_Intro
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__State_20426EC
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20426EC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #1
	beq _02042718
	cmp r0, #2
	bne _02042724
	mov r0, r4
	mov r1, #1
	bl SeaMapView_SetZoomLevel
	b _02042724
_02042718:
	mov r0, r4
	mov r1, #0
	bl SeaMapView_SetZoomLevel
_02042724:
	mov r0, #0
	bl SeaMapEventManager_GetObjectFromID
	ldrsh r1, [r0, #4]
	ldrsh r2, [r0, #2]
	mov r1, r1, lsl #0xc
	mov r0, r2, lsl #0xc
	bl SetSeaMapViewPosition
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	ldr r1, =SeaMapChartCourseView__State_ZoomIn
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_ZoomIn(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomIn_Outro
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__State_204261C
	strne r0, [r4, #0x7c4]
	ldreq r0, =SeaMapChartCourseView__State_20427B0
	streq r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20427B0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =stru_210FA58
	mov ip, #1
	ldr r3, =SeaMapChartCourseView__State_20427D8
	mov r2, #2
	str ip, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20427D8(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	add r1, r4, #0x1d4
	add r2, r1, #0x900
	mov r3, #0
	strh r3, [r2]
	str r3, [r1, #0x8fc]
	ldr r2, [r0, #4]
	str r2, [r1, #0x8f0]
	ldr r2, [r0, #8]
	mov r0, #1
	str r2, [r1, #0x8f4]
	bl SeaMapManager__EnableTouchField
	bl CreateSeaMapEventManagerDSPopup
	mov r0, r4
	bl SeaMapView_ResetIndicatorFlashTimer
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0x9cc]
	bl SeaMapView_SetTouchAreaPriority
	ldr r1, =SeaMapChartCourseView__State_2042844
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042844(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl SeaMapManager__GetWork
	mov r4, r0
	mov r0, r5
	bl SeaMapView_ProcessMapInputs
	mov r0, r5
	bl SeaMapView_ProcessButtonInputs
	mov r0, r5
	bl SeaMapChartCourseView__Func_2040DE0
	mov r0, r5
	ldr r1, =word_210FA16
	mov r2, #3
	bl SeaMapChartCourseView__Func_2041E80
	bl SeaMapManager__GetZoomLevel
	ldr r1, [r5, #0xacc]
	cmp r1, r0
	bne _020428F8
	bl SeaMapManager__GetZoomOutScale
	ldr r1, [r5, #0xac4]
	ldmib r4, {r2, ip}
	ldr r3, [r5, #0xac8]
	sub r2, r2, r1
	sub lr, ip, r3
	smull r1, r3, r2, r2
	adds ip, r1, #0x800
	smull r2, r1, lr, lr
	adc r3, r3, #0
	adds r2, r2, #0x800
	mov ip, ip, lsr #0xc
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr ip, ip, r3, lsl #20
	orr r2, r2, r1, lsl #20
	mov r6, r0
	add r0, ip, r2
	bl FX_Sqrt
	smull r2, r1, r0, r6
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r5, #0xad0]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r5, #0xad0]
_020428F8:
	ldr r0, [r4, #4]
	str r0, [r5, #0xac4]
	ldr r0, [r4, #8]
	str r0, [r5, #0xac8]
	bl SeaMapManager__GetZoomLevel
	str r0, [r5, #0xacc]
	ldr r0, [r5, #0xad0]
	cmp r0, #0x258000
	ldmleia sp!, {r4, r5, r6, pc}
	bl DestroySeaMapEventManagerDSPopup
	ldr r0, =SeaMapChartCourseView__State_2042934
	str r0, [r5, #0x7c4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042934(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #0
	mov r4, r0
	bl SeaMapView_SetTouchAreaPriority
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	mov r2, #1
	ldr r1, =stru_210FA3C
	ldr r3, =SeaMapChartCourseView__State_2042978
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042978(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	ldreq r0, =SeaMapChartCourseView__State_20429AC
	ldrne r0, =SeaMapChartCourseView__State_2042B04
	str r0, [r4, #0x7c4]
	ldr r1, [r4, #0x7c4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20429AC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r2, [r0, #4]
	add r1, r4, #0x1d4
	add r2, r2, #0x80000
	str r2, [r1, #0x8f0]
	ldr r0, [r0, #8]
	ldr r2, =SeaMapChartCourseView__State_20429F8
	add r0, r0, #0x60000
	str r0, [r1, #0x8f4]
	add r0, r1, #0x900
	mov r1, #0
	strh r1, [r0, #2]
	mov r0, r4
	str r2, [r4, #0x7c4]
	blx r2
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20429F8(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	mov r0, #0
	add r4, r5, #0x1d4
	bl SeaMapEventManager_GetObjectFromID
	mov r6, r0
	mov r0, #1
	bl SeaMapEventManager_GetObjectFromID
	add r3, r4, #0x900
	ldrsh r1, [r3, #2]
	ldrsh r8, [r6, #2]
	ldrsh r7, [r0, #2]
	ldrsh r6, [r6, #4]
	ldrsh r2, [r0, #4]
	add r0, r1, #0x22
	add r1, r8, r7
	strh r0, [r3, #2]
	ldrsh r0, [r3, #2]
	add r2, r6, r2
	mov r1, r1, asr #1
	cmp r0, #0x1000
	mov r2, r2, asr #1
	blt _02042A64
	mov r6, #0x1000
	ldr r0, =SeaMapChartCourseView__State_2042C04
	strh r6, [r3, #2]
	str r0, [r5, #0x7c4]
_02042A64:
	add r0, r4, #0x900
	ldrsh lr, [r0, #2]
	ldr r0, [r4, #0x8f0]
	mov r3, #2
	mov ip, lr, asr #0x1f
	mov r6, #0
	mov r5, #0x800
_02042A80:
	rsb r7, r0, r1, lsl #12
	umull r9, r8, r7, lr
	mla r8, r7, ip, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, lr, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r3, #0
	add r0, r0, r8
	sub r3, r3, #1
	bne _02042A80
	ldr r1, [r4, #0x8f4]
	mov r3, #2
	mov r5, #0
	mov r4, #0x800
_02042AC4:
	rsb r6, r1, r2, lsl #12
	umull r8, r7, r6, lr
	mla r7, r6, ip, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, lr, r7
	adds r8, r8, r4
	adc r6, r7, r5
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r3, #0
	add r1, r1, r7
	sub r3, r3, #1
	bne _02042AC4
	bl SetSeaMapViewPosition
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042B04(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	ldr r1, =SeaMapChartCourseView__State_2042B34
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042B34(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomIn_Intro
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__State_2042B5C
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042B5C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #0
	mov r4, r0
	bl SeaMapView_SetZoomLevel
	mov r0, #0
	bl SeaMapEventManager_GetObjectFromID
	mov r5, r0
	mov r0, #1
	bl SeaMapEventManager_GetObjectFromID
	ldrsh r2, [r0, #2]
	ldrsh r3, [r5, #2]
	ldrsh r1, [r5, #4]
	ldrsh r0, [r0, #4]
	add r2, r3, r2
	mov r2, r2, asr #1
	add r0, r1, r0
	mov r1, r0, asr #1
	mov r0, r2, lsl #0xc
	mov r1, r1, lsl #0xc
	bl SetSeaMapViewPosition
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	add r0, r4, #0x3b8
	ldr r1, [r4, #4]
	add r0, r0, #0x400
	bl InitSeaMapViewZoomControl
	ldr r1, =SeaMapChartCourseView__State_2042BDC
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042BDC(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	add r0, r0, #0x400
	bl SeaMapView_HandleZoomIn_Outro
	cmp r0, #0
	ldrne r0, =SeaMapChartCourseView__State_2042C04
	strne r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042C04(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =stru_210FA68
	mov ip, #1
	ldr r3, =SeaMapChartCourseView__State_2042C2C
	mov r2, #2
	str ip, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042C2C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, =SeaMapChartCourseView__Func_2041E3C
	mov r1, r4
	bl SeaMapEventTrigger_AddEventListener
	str r0, [r4, #0xab0]
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	bl CreateSeaMapEventManagerDSPopup
	ldr r1, =SeaMapChartCourseView__State_2042C6C
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042C6C(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =gSeaMapViewType
	mov r2, #3
	mov r4, r0
	str r2, [r1]
	bl SeaMapView_ResetIndicatorFlashTimer
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0x9cc]
	bl SeaMapChartCourseView__Func_20421AC
	ldr r1, =SeaMapChartCourseView__State_2042CB0
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042CB0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView_ProcessMapInputs
	mov r0, r4
	bl SeaMapView_ProcessButtonInputs
	bl GetSeaMapEventManagerWork2
	ldr r1, [r0, #0]
	mvn r0, #0
	cmp r1, r0
	mov r0, r4
	beq _02042CF8
	bl SeaMapChartCourseView__Func_2040D28
	cmp r0, #0
	beq _02042CFC
	ldr r1, [r4, #0x7c4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_02042CF8:
	bl SeaMapChartCourseView__Func_2040C7C
_02042CFC:
	ldr r1, =word_210FA0C
	mov r0, r4
	mov r2, #2
	bl SeaMapChartCourseView__Func_2041E80
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042D14(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =gSeaMapViewType
	mov r2, #4
	mov r4, r0
	str r2, [r1]
	bl SeaMapView_ResetIndicatorFlashTimer
	mov r2, #1
	ldr r1, =dword_210FAF0
	mov r0, r4
	str r2, [r4, #0x9cc]
	bl SeaMapView_EnableMultipleButtons
	bl SeaMapManager__GetZoomLevel
	mov r1, r0
	mov r0, r4
	bl SeaMapView_SetZoomLevelForZoomButtons
	mov r0, r4
	mov r1, #0
	bl SeaMapChartCourseView__SetTouchCallback
	mov r0, r4
	mov r1, #0
	bl SeaMapView_SetTouchAreaPriority
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, r4
	bl SeaMapChartCourseView__Func_20421AC
	ldr r1, =SeaMapChartCourseView__State_2042D98
	mov r0, r4
	str r1, [r4, #0x7c4]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042D98(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r5, r4, #0x1d4
	bl GetSeaMapEventManagerWork2
	mov r0, r4
	bl SeaMapView_ProcessMapInputs
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042E08
	ldr r0, =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #4
	beq _02042E08
	ldrh r1, [r0, #0x1c]
	ldrh r2, [r0, #0x1e]
	mov r0, r4
	and r1, r1, #0xff
	and r2, r2, #0xff
	bl SeaMapChartCourseView__Func_2041104
	mov r1, r0
	mov r0, r4
	bl SeaMapChartCourseView__SetTouchCallback
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	beq _02042ED8
	mov r0, r4
	bl SeaMapView_ClearLocalMoveInputs
	b _02042ED8
_02042E08:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042E88
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	beq _02042E88
	mov r0, r4
	bl SeaMapView_ResetIndicatorFlashTimer
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02042ED8
	ldr r0, [r4, #0x7a8]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	str r0, [r4, #0x7ac]
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bne _02042E64
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r3, r4, r5, pc}
_02042E64:
	bl SeaMapManager__GetNodeCount
	cmp r0, #1
	bls _02042ED8
	bl SeaMapManager__GetTotalDistance
	cmp r0, #0x8000
	bge _02042ED8
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041048
	ldmia sp!, {r3, r4, r5, pc}
_02042E88:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02042ED8
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _02042ED8
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	bne _02042ED8
	mov r0, r4
	bl SeaMapChartCourseView__Func_2041268
	cmp r0, #0
	beq _02042ED8
	bl CheckNavTailsSpeaking
	cmp r0, #0x29
	beq _02042ED8
	mov r0, #0x29
	mov r1, #0x258
	bl NavTailsSpeak
_02042ED8:
	ldr r0, [r5, #0x8ec]
	cmp r0, #0
	bne _02042F1C
	ldr r0, [r5, #0x8e4]
	cmp r0, #0
	beq _02042F1C
	mov r1, #1
	mov r0, #0
	str r1, [r5, #0x8ec]
	bl SeaMapManager__EnableTouchField
	mov r2, #1
	ldr r1, =stru_210FA2C
	ldr r3, =SeaMapChartCourseView__State_2042D14
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, r4, r5, pc}
_02042F1C:
	ldr r0, [r5, #0x8e8]
	cmp r0, #0
	bne _02042F6C
	ldr r0, [r4, #0x79c]
	ldr r1, [r4, #0x798]
	bl FX_Div
	ldr r1, =0x00000199
	cmp r0, r1
	bge _02042F6C
	mov r1, #1
	mov r0, #0
	str r1, [r5, #0x8e8]
	bl SeaMapManager__EnableTouchField
	mov r2, #1
	ldr r1, =stru_210FA24
	ldr r3, =SeaMapChartCourseView__State_2042D14
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, r4, r5, pc}
_02042F6C:
	ldr r1, =word_210FA10
	mov r0, r4
	mov r2, #3
	bl SeaMapChartCourseView__Func_2041E80
	mov r0, r4
	bl SeaMapView_ProcessButtonInputs
	mov r0, r4
	bl SeaMapChartCourseView__Func_2040DE0
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2042FA8(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r4, r0
	mov r0, #0
	bl SeaMapManager__EnableTouchField
	ldr r0, [r4, #0xab8]
	cmp r0, #0
	beq _02043050
	mov r2, #0
	ldr r1, =dword_210FA90
	mov r0, r4
	str r2, [r4, #0x9cc]
	bl SeaMapView_EnableMultipleButtons
	ldr r1, [r4, #4]
	add r0, sp, #4
	mov r2, #3
	bl InitSpriteButtonConfig
	ldr r1, [r4, #0x38]
	add r0, sp, #4
	str r1, [sp, #0xc]
	ldr r6, [r4, #0x3c]
	mov r5, #1
	mov lr, #2
	mov ip, #3
	mov r3, #0
	mov r2, #4
	mov r1, #0x3540
	str r6, [sp, #0x10]
	strh r5, [sp, #0x14]
	strh lr, [sp, #0x16]
	strh ip, [sp, #0x18]
	strb r3, [sp, #0x20]
	strb r2, [sp, #0x21]
	strh r1, [sp, #0x1a]
	bl CreateSpriteButton
	mov r0, #0x2b
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, =SeaMapChartCourseView__State_2043080
	add sp, sp, #0x24
	str r0, [r4, #0x7c4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02043050:
	ldr r1, =stru_210FA34
	mov r2, #1
	ldr r3, =SeaMapChartCourseView__State_2042D14
	mov r0, r4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2043080(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl GetSelectedSpriteButton
	cmp r0, #0
	beq _020430A8
	cmp r0, #1
	beq _020430E8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_020430A8:
	bl DestroySpriteButton
	mov r0, #0
	sub r1, r0, #1
	mov r2, #2
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	ldr r0, =gSeaMapViewExitEvent
	mov r2, #1
	ldr r1, =SeaMapChartCourseView__State_2043148
	str r2, [r0]
	add sp, sp, #8
	str r1, [r4, #0x7c4]
	ldmia sp!, {r4, pc}
_020430E8:
	bl DestroySpriteButton
	mov r0, #1
	bl SeaMapManager__EnableTouchField
	mov r0, #0
	sub r1, r0, #1
	mov ip, #2
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	add r0, r4, #0xa00
	mov r1, #0x258
	strh r1, [r0, #0xd4]
	ldr r0, [r4, #0x9c8]
	cmp r0, #0
	cmpne r0, #1
	ldreq r0, =SeaMapChartCourseView__State_2042D14
	streq r0, [r4, #0x7c4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2043148(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #4]
	ldr r0, =VRAMSystem__GFXControl
	mov r1, #0x3f
	ldr r0, [r0, r2, lsl #2]
	sub r2, r1, #0x40
	add r0, r0, #0x20
	bl RenderCore_SetBlendBrightness
	ldr r0, =SeaMapChartCourseView__State_2043180
	str r0, [r4, #0x7c4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_2043180(SeaMapChartCourseView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #4]
	ldr r1, =VRAMSystem__GFXControl
	ldr r2, [r1, r2, lsl #2]
	ldrh r1, [r2, #0x24]
	cmp r1, #4
	addlo r0, r1, #1
	ldrhs r1, =SeaMapChartCourseView__State_20431B0
	strloh r0, [r2, #0x24]
	strhs r1, [r0, #0x7c4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20431B0(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =stru_210FA44
	mov r2, #1
	ldr r3, =SeaMapChartCourseView__State_20431D4
	str r2, [sp]
	bl SeaMapChartCourseView__StartNavTailsTalk
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapChartCourseView__State_20431D4(SeaMapChartCourseView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r11, r0
	bl SeaMapView_FadeActiveScreen_ToTarget
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetTotalDistance
	mov r9, r0
	cmp r9, #0
	mov r10, #0
	ble _0204325C
	add r8, sp, #8
	add r7, sp, #4
	add r6, sp, #2
	add r5, sp, #0
	mov r4, #3
_02043218:
	mov r0, r10
	mov r1, r8
	mov r2, r7
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	mov r2, r6
	mov r3, r5
	bl SeaMapManager__ConvertWorldPosToMapPos
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	mov r2, r4
	mov r3, r4
	bl SeaMapManager__Func_20442C8
	add r10, r10, #0x10000
	cmp r10, r9
	blt _02043218
_0204325C:
	add r1, sp, #8
	add r2, sp, #4
	mov r0, r9
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	add r2, sp, #2
	add r3, sp, #0
	bl SeaMapManager__ConvertWorldPosToMapPos
	mov r2, #3
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	mov r3, r2
	bl SeaMapManager__Func_20442C8
	ldr r1, [r11, #4]
	ldr r0, =VRAMSystem__GFXControl
	ldr r0, [r0, r1, lsl #2]
	add r0, r0, #0x20
	bl RenderCore_DisableBlending
	mov r0, #1
	str r0, [r11, #0x7cc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
