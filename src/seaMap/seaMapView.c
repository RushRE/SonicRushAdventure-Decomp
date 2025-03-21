#include <seaMap/seaMapView.h>
#include <game/game/gameState.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <seaMap/seaMapEventManager.h>
#include <seaMap/seaMapCollision.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *dword_210F76C;
NOT_DECOMPILED void *byte_210F774;
NOT_DECOMPILED void *byte_210F77C;
NOT_DECOMPILED void *word_210F782;
NOT_DECOMPILED void *SeaMapView__VoyageDistance;
NOT_DECOMPILED void *stru_210F7A4;
NOT_DECOMPILED void *stru_210F7E4;
NOT_DECOMPILED void *stru_210F82C;

// --------------------
// FUNCTIONS
// --------------------

u32 SeaMapView__GetMode(void)
{
    return SeaMapView__sVars.mode;
}

s32 SeaMapView__Func_203DCB4(void)
{
    return SeaMapView__sVars.unknown1;
}

BOOL SeaMapView__IsActive(void)
{
    return SeaMapView__sVars.singleton != NULL;
}

void SeaMapView__SetViewPosition(s32 x, s32 y)
{
    SeaMapView *work = SeaMapView__GetWork();

    work->position.x  = x - (HW_LCD_CENTER_X * SeaMapManager__GetZoomInScale());
    work->position.y  = y - (HW_LCD_CENTER_Y * SeaMapManager__GetZoomInScale());

    work->moveDist2.x = work->moveDist2.y = 0;
}

TouchArea *SeaMapView__GetTouchArea(void)
{
    SeaMapView *work = TaskGetWork(SeaMapView__sVars.singleton, SeaMapView);

    return &work->touchArea;
}

BOOL SeaMapView__Func_203DD44(void)
{
    SeaMapView *work = SeaMapView__GetWork();

    return work->currentVoyageDist <= FLOAT_TO_FX32(1.0);
}

void SeaMapView__InitZoomControl(SeaMapViewZoomControl *work, BOOL useEngineB)
{
    MI_CpuClear16(work, sizeof(*work));

    work->useEngineB = useEngineB;
}

NONMATCH_FUNC BOOL SeaMapView__CanZoomIn(SeaMapViewZoomControl *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5, #0]
	ldr r1, =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203DDB4
	cmp r0, #1
	beq _0203DDFC
	cmp r0, #2
	beq _0203DE98
_0203DDB4:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r2, #0
	strb r2, [r4, #0x11]
	strb r2, [r4, #0x15]
	strb r2, [r4, #0x10]
	mov r1, #0xc0
	strb r1, [r4, #0x14]
	mov r1, #0xff
	strb r1, [r4, #0x18]
	strb r2, [r4, #0x1a]
	bl RenderCore_DisableWindowPlaneUpdate
	mov r0, #1
	strh r0, [r5, #4]
_0203DDFC:
	ldrb r0, [r4, #0x11]
	add r0, r0, #0xc
	strb r0, [r4, #0x11]
	ldrb r0, [r4, #0x15]
	add r0, r0, #9
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x10]
	sub r0, r0, #0xc
	strb r0, [r4, #0x10]
	ldrb r0, [r4, #0x14]
	sub r0, r0, #9
	strb r0, [r4, #0x14]
	ldrb r2, [r4, #0x10]
	ldrb r0, [r4, #0x11]
	cmp r0, r2
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	strb r2, [r4, #0x11]
	ldrb r1, [r4, #0x14]
	mov r0, #0
	strb r1, [r4, #0x15]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _0203DE80
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	str r0, [r1]
	b _0203DE90
_0203DE80:
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	str r0, [r1]
_0203DE90:
	mov r0, #2
	strh r0, [r5, #4]
_0203DE98:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__HandleZoomIn(SeaMapViewZoomControl *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5, #0]
	ldr r1, =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203DED8
	cmp r0, #1
	beq _0203DF58
	cmp r0, #2
	beq _0203DFBC
_0203DED8:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r2, #0
	strb r2, [r4, #0x11]
	strb r2, [r4, #0x15]
	strb r2, [r4, #0x10]
	mov r1, #0xc0
	strb r1, [r4, #0x14]
	strb r2, [r4, #0x18]
	mov r1, #0xff
	strb r1, [r4, #0x1a]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _0203DF3C
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	b _0203DF50
_0203DF3C:
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
_0203DF50:
	mov r0, #1
	strh r0, [r5, #4]
_0203DF58:
	ldrb r0, [r4, #0x11]
	add r0, r0, #0xc
	strb r0, [r4, #0x11]
	ldrb r0, [r4, #0x15]
	add r0, r0, #9
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x10]
	sub r0, r0, #0xc
	strb r0, [r4, #0x10]
	ldrb r0, [r4, #0x14]
	sub r0, r0, #9
	strb r0, [r4, #0x14]
	ldrb r1, [r4, #0x11]
	ldrb r0, [r4, #0x10]
	cmp r1, r0
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r4, #0x1c]
	bl RenderCore_DisableWindowPlaneUpdate
	mov r0, #2
	strh r0, [r5, #4]
_0203DFBC:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__CanZoomOut(SeaMapViewZoomControl *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5, #0]
	ldr r1, =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203DFFC
	cmp r0, #1
	beq _0203E070
	cmp r0, #2
	beq _0203E130
_0203DFFC:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r1, #0x80
	strb r1, [r4, #0x11]
	mov r0, #0x60
	strb r0, [r4, #0x15]
	strb r1, [r4, #0x10]
	strb r0, [r4, #0x14]
	mov r0, #0
	strb r0, [r4, #0x18]
	mov r1, #0xff
	strb r1, [r4, #0x1a]
	ldrb r2, [r4, #0x11]
	mov r1, #1
	sub r2, r2, #0xc
	strb r2, [r4, #0x11]
	ldrb r2, [r4, #0x15]
	sub r2, r2, #9
	strb r2, [r4, #0x15]
	ldrb r2, [r4, #0x10]
	add r2, r2, #0xc
	strb r2, [r4, #0x10]
	ldrb r2, [r4, #0x14]
	add r2, r2, #9
	strb r2, [r4, #0x14]
	strh r1, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
_0203E070:
	mov r0, #1
	str r0, [r4, #0x1c]
	ldrb r1, [r4, #0x11]
	sub r1, r1, #0xc
	strb r1, [r4, #0x11]
	ldrb r1, [r4, #0x15]
	sub r1, r1, #9
	strb r1, [r4, #0x15]
	ldrb r1, [r4, #0x10]
	add r1, r1, #0xc
	strb r1, [r4, #0x10]
	ldrb r1, [r4, #0x14]
	add r1, r1, #9
	strb r1, [r4, #0x14]
	ldrb r1, [r4, #0x15]
	cmp r1, #6
	bhi _0203E0B8
	bl RenderCore_DisableWindowPlaneUpdate
_0203E0B8:
	ldrb r1, [r4, #0x11]
	ldrb r0, [r4, #0x10]
	cmp r1, r0
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	mov r0, #0
	strb r0, [r4, #0x11]
	mov r1, #0xff
	strb r1, [r4, #0x10]
	strb r0, [r4, #0x15]
	mov r1, #0xc0
	strb r1, [r4, #0x14]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _0203E118
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	str r0, [r1]
	b _0203E128
_0203E118:
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	str r0, [r1]
_0203E128:
	mov r0, #2
	strh r0, [r5, #4]
_0203E130:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__HandleZoomOut(SeaMapViewZoomControl *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5, #0]
	ldr r1, =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203E170
	cmp r0, #1
	beq _0203E1F4
	cmp r0, #2
	beq _0203E258
_0203E170:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r2, #0x80
	strb r2, [r4, #0x11]
	mov r1, #0x60
	strb r1, [r4, #0x15]
	strb r2, [r4, #0x10]
	strb r1, [r4, #0x14]
	mov r1, #0xff
	strb r1, [r4, #0x18]
	mov r1, #0
	strb r1, [r4, #0x1a]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _0203E1D8
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	b _0203E1EC
_0203E1D8:
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
_0203E1EC:
	mov r0, #1
	strh r0, [r5, #4]
_0203E1F4:
	ldrb r0, [r4, #0x11]
	sub r0, r0, #0xc
	strb r0, [r4, #0x11]
	ldrb r0, [r4, #0x15]
	sub r0, r0, #9
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x10]
	add r0, r0, #0xc
	strb r0, [r4, #0x10]
	ldrb r0, [r4, #0x14]
	add r0, r0, #9
	strb r0, [r4, #0x14]
	ldrb r1, [r4, #0x11]
	ldrb r0, [r4, #0x10]
	cmp r1, r0
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r4, #0x1c]
	bl RenderCore_DisableWindowPlaneUpdate
	mov r0, #2
	strh r0, [r5, #4]
_0203E258:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

SeaMapView *SeaMapView__GetWork(void)
{
    SeaMapView *work = TaskGetWork(SeaMapView__sVars.singleton, SeaMapView);

    return work;
}

NONMATCH_FUNC void SeaMapView__InitView(SeaMapView *work, BOOL useEngineB, ShipType shipType, BOOL allocateSprites)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x38
	mov r9, r0
	mov r8, r1
	mov r4, r2
	mov r5, r3
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0203E2D4
_0203E2AC: // jump table
	b _0203E2C4 // case 0
	b _0203E2C4 // case 1
	b _0203E2C4 // case 2
	b _0203E2C4 // case 3
	b _0203E2C4 // case 4
	b _0203E2C4 // case 5
_0203E2C4:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	str r0, [sp, #0x20]
	b _0203E2DC
_0203E2D4:
	mov r0, #1
	str r0, [sp, #0x20]
_0203E2DC:
	bl SeaMapManager__GetWork
	str r0, [sp, #0x28]
	ldr r2, =0x000007B4
	mov r1, r9
	mov r0, #0
	bl MIi_CpuClear16
	str r8, [r9, #4]
	bl SeaMapManager__GetWork
	add r0, r0, #0x15c
	ldr r1, =VRAMSystem__GFXControl
	str r0, [r9, #0xc]
	mvn r2, #0
	ldr r0, [r1, r8, lsl #2]
	str r2, [r9, #0x790]
	ldrsh r0, [r0, #0x58]
	cmp r4, #4
	strh r0, [r9, #8]
	bge _0203E338
	ldr r0, =SeaMapView__VoyageDistance
	ldr r0, [r0, r4, lsl #2]
	mov r0, r0, lsl #0xc
	str r0, [r9, #0x798]
	str r0, [r9, #0x79c]
_0203E338:
	mov r0, r9
	bl SeaMapView__Func_203FE44
	ldr r0, [r9, #0xc]
	add r2, r9, #0x164
	ldr r0, [r0, #0]
	mov r1, #0x26
	add r4, r2, #0x400
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r9, #4]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r9, #4]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r9, #4]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #6
	ldr r2, [r0, r2, lsl #2]
	mov r0, r4
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r9, #0xc]
	ldr r3, =0x00000814
	ldr r1, [r1, #0]
	mov r2, #0x26
	bl AnimatorSprite__Init
	mov r0, #4
	cmp r5, #0
	strh r0, [r4, #0x50]
	addeq sp, sp, #0x38
	str r5, [r9]
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r9
	bl SeaMapView__AllocateSprites
	mov r0, #0
	ldr r6, =stru_210F82C
	ldr r10, =stru_210F7A4
	str r0, [sp, #0x24]
	mov r11, r0
	add r5, r9, #0x44
_0203E3E4:
	ldr r0, [sp, #0x24]
	mov r2, #0
	cmp r0, #5
	bhs _0203E484
	ldrb r0, [r6, #0]
	strh r0, [r5, #0xa2]
_0203E3FC:
	add r0, r6, r2
	ldrb r1, [r0, #0xc]
	add r0, r5, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blo _0203E3FC
	str r8, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r0, [r6, #4]
	ldr r2, =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0x30]
	ldr r7, [r2, r8, lsl #2]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r7, [sp, #0x10]
	str r1, [sp, #0x14]
	ldrb r1, [r6, #1]
	mov r0, r5
	mov r3, #0x800
	str r1, [sp, #0x18]
	ldr r1, [r9, #0xc]
	ldrh r2, [r5, #0xa2]
	ldr r1, [r1, #0]
	bl AnimatorSprite__Init
	ldrh r0, [r5, #0x9c]
	strh r0, [r5, #0x50]
	ldrsh r0, [r6, #8]
	strh r0, [r5, #8]
	ldrsh r0, [r6, #0xa]
	strh r0, [r5, #0xa]
	b _0203E55C
_0203E484:
	ldr r1, =stru_210F7E4
	sub r0, r11, #0x78
	add r4, r1, r0
	ldr r0, [sp, #0x20]
	ldrb r0, [r0, r4]
	strh r0, [r5, #0xa2]
_0203E49C:
	add r0, r4, r2
	ldrb r1, [r0, #0x14]
	add r0, r5, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blo _0203E49C
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0203E4F0
_0203E4CC: // jump table
	b _0203E4E4 // case 0
	b _0203E4E4 // case 1
	b _0203E4E4 // case 2
	b _0203E4E4 // case 3
	b _0203E4E4 // case 4
	b _0203E4E4 // case 5
_0203E4E4:
	bl RenderCore_GetLanguagePtr
	ldrb r2, [r0, #0]
	b _0203E4F4
_0203E4F0:
	mov r2, #1
_0203E4F4:
	str r8, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r0, [r4, #0xc]
	ldr r3, =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r9, r0, lsl #2
	ldr r7, [r3, r8, lsl #2]
	ldr r3, [r0, #0x30]
	mov r0, r5
	str r3, [sp, #8]
	str r1, [sp, #0xc]
	str r7, [sp, #0x10]
	str r1, [sp, #0x14]
	ldrb r1, [r4, #8]
	mov r3, #0x800
	str r1, [sp, #0x18]
	ldrb r2, [r4, r2]
	ldr r1, [r9, #0xc]
	ldr r1, [r1, #0]
	bl AnimatorSprite__Init
	ldrh r0, [r5, #0x9c]
	strh r0, [r5, #0x50]
	ldrsh r0, [r4, #0x10]
	strh r0, [r5, #8]
	ldrsh r0, [r4, #0x12]
	strh r0, [r5, #0xa]
_0203E55C:
	add r2, sp, #0x30
	mov r0, r5
	mov r1, #0
	bl AnimatorSprite__GetBlockData
	ldr r1, [r10, #4]
	ldr r2, =TouchField__PointInRect
	stmia sp, {r1, r9}
	add r0, r5, #0x64
	add r1, r5, #8
	add r3, sp, #0x30
	bl TouchField__InitAreaShape
	ldr r0, [sp, #0x28]
	ldrh r2, [r10], #8
	add r0, r0, #0x13c
	add r1, r5, #0x64
	bl TouchField__AddArea
	mov r0, r5
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [sp, #0x24]
	add r5, r5, #0xa4
	add r0, r0, #1
	add r6, r6, #0x10
	add r11, r11, #0x18
	str r0, [sp, #0x24]
	cmp r0, #8
	blo _0203E3E4
	mov r5, #0
	add r1, sp, #0x2c
	mov r4, #0x100
	mov r3, #0xc0
	strh r3, [sp, #0x36]
	add r0, r9, #0x358
	ldr r2, =SeaMapView__TouchAreaCallback
	strh r5, [r1]
	strh r5, [r1, #2]
	strh r5, [sp, #0x30]
	strh r5, [sp, #0x32]
	strh r4, [sp, #0x34]
	str r2, [sp]
	ldr r2, =TouchField__PointInRect
	add r3, sp, #0x30
	add r0, r0, #0x400
	str r9, [sp, #4]
	bl TouchField__InitAreaShape
	ldr r0, [sp, #0x28]
	add r1, r9, #0x358
	add r0, r0, #0x13c
	add r1, r1, #0x400
	mov r2, #8
	bl TouchField__AddArea
	add r0, r9, #0x1c8
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	add r4, r0, #0x400
	ldr r0, [r1, r8, lsl #2]
	str r0, [sp, #0x1c]
	bl GetSpriteButtonCursorSprite
	mov r5, r0
	bl SeaMapView__GetCursorSpriteSize
	mov r1, r0
	mov r0, r8
	bl VRAMSystem__AllocSpriteVram
	str r8, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	ldr r2, =byte_210F774
	str r3, [sp, #0x18]
	ldrb r2, [r2, #0]
	mov r1, r5
	mov r0, r4
	bl AnimatorSprite__Init
	ldr r1, =byte_210F774
	mov r0, r9
	ldrb r2, [r1, #1]
	mvn r1, #0
	strh r2, [r4, #0x50]
	bl SeaMapView__InitTouchCursor
	mov r10, #0
	add r0, r9, #0x22c
	ldr r5, =0x0210F776
	add r6, r0, #0x400
	mov r11, r10
_0203E6B8:
	bl GetSpriteButtonCursorSprite
	ldr r1, [r9, #0xc]
	mov r4, r0
	ldr r0, [r1, #0]
	ldrb r1, [r5, #0]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r8
	bl VRAMSystem__AllocSpriteVram
	stmia sp, {r8, r11}
	str r0, [sp, #8]
	str r11, [sp, #0xc]
	str r7, [sp, #0x10]
	str r11, [sp, #0x14]
	str r11, [sp, #0x18]
	ldrb r2, [r5, #0]
	mov r1, r4
	mov r0, r6
	mov r3, r11
	bl AnimatorSprite__Init
	ldrb r2, [r5, #1]
	mov r1, #0
	mov r0, r6
	strh r2, [r6, #0x50]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r10, r10, #1
	add r5, r5, #2
	add r6, r6, #0x64
	cmp r10, #2
	blo _0203E6B8
	ldr r0, [r9, #0xc]
	add r2, r9, #0x2f4
	ldr r0, [r0, #0]
	mov r1, #0x2e
	add r4, r2, #0x400
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r8
	bl VRAMSystem__AllocSpriteVram
	str r8, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, #5
	str r0, [sp, #0x18]
	ldr r1, [r9, #0xc]
	mov r0, r4
	ldr r1, [r1, #0]
	mov r2, #0x2e
	bl AnimatorSprite__Init
	mov r1, #0
	mov r0, #4
	strh r0, [r4, #0x50]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	bl AllocSndHandle
	str r0, [r9, #0x7a8]
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ReleaseAssets(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl SeaMapManager__GetWork
	add r1, r5, #0x164
	mov r4, r0
	add r0, r1, #0x400
	bl AnimatorSprite__Release
	ldr r0, [r5, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, #0x2f4
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r5, #0x1c8
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r5, #0x22c
	add r7, r0, #0x400
	mov r6, #0
_0203E838:
	mov r0, r7
	bl AnimatorSprite__Release
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x64
	blo _0203E838
	mov r0, r5
	bl SeaMapView__ReleaseSprites
	add r1, r5, #0x358
	add r0, r4, #0x13c
	add r1, r1, #0x400
	bl TouchField__RemoveArea
	add r6, r5, #0xa8
	mov r7, #0
_0203E870:
	mov r1, r6
	add r0, r4, #0x13c
	bl TouchField__RemoveArea
	add r7, r7, #1
	cmp r7, #8
	add r6, r6, #0xa4
	blo _0203E870
	ldr r0, [r5, #0x7a8]
	bl FreeSndHandle
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203E898(SeaMapView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r0, r0, #0x700
	mvn r1, #0x1d
	strh r1, [r0, #0xa4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203E8A8(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0203E8CC
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	bne _0203E8DC
_0203E8CC:
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0xf0
	beq _0203E8E8
_0203E8DC:
	mov r0, r4
	bl SeaMapView__Func_203E898
	ldmia sp!, {r4, pc}
_0203E8E8:
	add r0, r4, #0x700
	ldrsh r1, [r0, #0xa4]
	add r1, r1, #1
	strh r1, [r0, #0xa4]
	ldrsh r1, [r0, #0xa4]
	cmp r1, #0xff
	movgt r1, #0
	strgth r1, [r0, #0xa4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203E914(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	ldr r0, [r5, #0x79c]
	ldr r1, [r5, #0x798]
	bl FX_Div
	mov r4, r0
	mov r0, #0x1000
	mov r1, #3
	bl FX_DivS32
	mov r6, r0
	mov r0, r4
	mov r1, r6
	bl FX_Div
	mov r7, r0, asr #0xc
	cmp r7, #3
	addhs r0, r5, #0x700
	movhs r1, #0x3e0
	bhs _0203EA40
	mul r0, r7, r6
	mov r1, r6
	sub r0, r4, r0
	bl FX_Div
	ldr r1, =byte_210F77C
	mov r2, r7, lsl #1
	ldrh r6, [r1, r2]
	ldr r1, =0x0210F77A
	mov r0, r0, lsl #0x10
	ldrh r9, [r1, r2]
	mov r2, r6, asr #0xa
	and r7, r2, #0x1f
	mov r3, r9, asr #0xa
	and r2, r6, #0x1f
	mov r1, r6, asr #5
	and r6, r1, #0x1f
	mov r1, r7, lsl #0x10
	mov r8, r9, asr #5
	mov r2, r2, lsl #0x10
	and r3, r3, #0x1f
	mov r6, r6, lsl #0x10
	mov r7, r2, lsr #4
	mov r2, r6, lsr #4
	mov r1, r1, lsr #4
	mov r6, r0, asr #0x10
	and lr, r9, #0x1f
	sub r0, r1, r3, lsl #12
	and ip, r8, #0x1f
	sub r1, r7, lr, lsl #12
	sub r7, r2, ip, lsl #12
	smull r2, r9, r0, r6
	adds r2, r2, #0x800
	smull r8, r0, r1, r6
	adc r9, r9, #0
	adds r1, r8, #0x800
	mov r2, r2, lsr #0xc
	orr r2, r2, r9, lsl #20
	add r2, r2, r3, lsl #12
	smull r6, r3, r7, r6
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r6, r6, #0x800
	add r7, r1, lr, lsl #12
	adc r0, r3, #0
	mov r1, r6, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, ip, lsl #12
	mov r0, r0, asr #0xc
	mov r0, r0, lsl #0x10
	mov r2, r2, asr #0xc
	mov r3, r0, lsr #0xb
	mov r1, r7, lsl #4
	mov r0, r2, lsl #0x10
	orr r1, r3, r1, lsr #16
	orr r1, r1, r0, lsr #6
	add r0, r5, #0x700
_0203EA40:
	strh r1, [r0, #0xa0]
	add r1, r5, #0x700
	ldrh lr, [r1, #0xa0]
	ldr r2, =VRAMSystem__VRAM_PALETTE_BG
	add r0, r5, #0x7a0
	mov r3, lr, asr #5
	and r3, r3, #0x1f
	mov r6, lr, asr #0xa
	and ip, r6, #0x1f
	mov r3, r3, asr #1
	and r6, lr, #0x1f
	mov r3, r3, lsl #5
	mov ip, ip, asr #1
	orr r3, r3, r6, asr #1
	orr r3, r3, ip, lsl #10
	strh r3, [r1, #0xa2]
	ldr r3, [r5, #4]
	mov r1, #1
	ldr r3, [r2, r3, lsl #2]
	mov r2, #0
	add r3, r3, #0xfe
	add r3, r3, #0x100
	bl QueueUncompressedPalette
	ldr r2, [r5, #4]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r5, #0x7a0
	ldr r2, [r1, r2, lsl #2]
	mov r1, #1
	add r3, r2, #0x9c
	mov r2, #0
	bl LoadUncompressedPalette
	add r0, r5, #0xa2
	ldr r2, [r5, #4]
	ldr r1, =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r0, #0x700
	ldr r2, [r1, r2, lsl #2]
	mov r1, #1
	add r3, r2, #0x9e
	mov r2, #0
	bl LoadUncompressedPalette
	ldr r0, =0x00000B34
	mov r1, #0
	umull r3, r2, r4, r0
	mla r2, r4, r1, r2
	mov r1, r4, asr #0x1f
	mla r2, r1, r0, r2
	adds r1, r3, #0x800
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xcc
	add r0, r0, #0x400
	str r0, [r5, #0x59c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__GetCursorSpriteSize(void *spriteFile)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetSpriteButtonCursorSprite
	ldr r1, =byte_210F774
	ldrb r1, [r1, #0]
	bl Sprite__GetSpriteSize1FromAnim
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__InitTouchCursor(SeaMapView *work, s32 mode)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	add r0, r0, #0x1c8
	mvn r2, #0
	cmp r1, r2
	add r4, r0, #0x400
	bne _0203EB70
	ldr r0, [r4, #0x3c]
	orr r0, r0, #1
	str r0, [r4, #0x3c]
	ldmia sp!, {r3, r4, r5, pc}
_0203EB70:
	ldr r2, =byte_210F774
	mov r0, r4
	add r5, r2, r1, lsl #1
	ldrb r1, [r2, r1, lsl #1]
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x3c]
	mov r1, #0
	bic r0, r0, #1
	str r0, [r4, #0x3c]
	ldrb r3, [r5, #1]
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #0x50]
	bl AnimatorSprite__ProcessAnimation
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__AllocateSprites(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	add r1, r8, #0x30
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear32
	mov r5, #0
	ldr r6, =stru_210F82C
	ldr r4, =dword_210F76C
	mov r7, r5
_0203EBD8:
	cmp r5, #5
	mov r0, r8
	mov r1, r5
	bhs _0203EBF4
	bl SeaMapView__Func_203ECA0
	ldr r1, [r6, #4]
	b _0203EC00
_0203EBF4:
	bl SeaMapView__Func_203ECF4
	add r1, r4, r7
	ldr r1, [r1, #0xc]
_0203EC00:
	add r2, r8, r1, lsl #2
	ldr r1, [r2, #0x30]
	add r5, r5, #1
	cmp r1, r0
	strlo r0, [r2, #0x30]
	cmp r5, #8
	add r6, r6, #0x10
	add r7, r7, #0x18
	blo _0203EBD8
	mov r4, #0
_0203EC28:
	add r0, r8, r4, lsl #2
	ldr r1, [r0, #0x30]
	cmp r1, #0
	beq _0203EC48
	ldr r0, [r8, #4]
	bl VRAMSystem__AllocSpriteVram
	add r1, r8, r4, lsl #2
	str r0, [r1, #0x30]
_0203EC48:
	add r4, r4, #1
	cmp r4, #5
	blo _0203EC28
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ReleaseSprites(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, #0
	mov r6, r0
	mov r4, r5
_0203EC70:
	add r0, r6, r5, lsl #2
	ldr r1, [r0, #0x30]
	cmp r1, #0
	beq _0203EC90
	ldr r0, [r6, #4]
	bl VRAMSystem__FreeSpriteVram
	add r0, r6, r5, lsl #2
	str r4, [r0, #0x30]
_0203EC90:
	add r5, r5, #1
	cmp r5, #5
	blo _0203EC70
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u32 SeaMapView__Func_203ECA0(SeaMapView *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0xc]
	ldr r4, =stru_210F82C
	mov r5, r1
	ldrb r1, [r4, r5, lsl #4]
	ldr r0, [r0, #0]
	bl Sprite__GetSpriteSize1FromAnim
	ldrb r1, [r4, r5, lsl #4]
	mov r4, r0
	ldr r2, [r6, #0xc]
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2, #0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r4, r0
	movlo r4, r0
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u32 SeaMapView__Func_203ECF4(SeaMapView *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r3, =stru_210F7E4
	sub r2, r1, #5
	mov r1, #0x18
	mla r4, r2, r1, r3
	mov r5, #0
	mov r7, r0
	mov r6, r5
_0203ED14:
	ldrb r0, [r4, r6]
	ldr r2, [r7, #0xc]
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2, #0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r5, r0
	movlo r5, r0
	ldr r0, [r7, #0xc]
	ldrb r1, [r4, r6]
	ldr r0, [r0, #0]
	bl Sprite__GetSpriteSize1FromAnim
	cmp r5, r0
	add r6, r6, #1
	movlo r5, r0
	cmp r6, #8
	blo _0203ED14
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__IsButtonActive(SeaMapView *work, s32 id){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #0xa4
	mla r0, r1, r2, r0
	ldr r0, [r0, #0x80]
	tst r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__IsTouchAreaActive(SeaMapView *work, s32 id){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #0xa4
	mla r0, r1, r2, r0
	ldr r0, [r0, #0xbc]
	tst r0, #0x40
	moveq r0, #1
	movne r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__EnableTouchArea(SeaMapView *work, s32 id, BOOL enabled)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	add r3, r0, #0x44
	mov r0, #0xa4
	mla r4, r1, r0, r3
	cmp r2, #0
	mov r0, r4
	beq _0203EDD4
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [r4, #0x78]
	bic r0, r0, #0x40
	str r0, [r4, #0x78]
	ldmia sp!, {r4, pc}
_0203EDD4:
	mov r1, #2
	bl SetSpriteButtonState
	ldr r0, [r4, #0x78]
	orr r0, r0, #0x40
	str r0, [r4, #0x78]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__EnableButton(SeaMapView *work, s32 id, BOOL enabled)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	add r3, r0, #0x44
	mov r0, #0xa4
	mla r4, r1, r0, r3
	cmp r2, #0
	beq _0203EE50
	cmp r1, #5
	bge _0203EE20
	ldr r0, =stru_210F82C
	add r0, r0, r1, lsl #4
	ldrsh r5, [r0, #8]
	ldrsh r6, [r0, #0xa]
	b _0203EE38
_0203EE20:
	ldr r2, =stru_210F7E4
	sub r1, r1, #5
	mov r0, #0x18
	mla r0, r1, r0, r2
	ldrsh r5, [r0, #0x10]
	ldrsh r6, [r0, #0x12]
_0203EE38:
	ldr r1, [r4, #0x3c]
	mov r0, r4
	bic r1, r1, #1
	str r1, [r4, #0x3c]
	bl AnimatorSprite__ProcessFrame
	b _0203EE64
_0203EE50:
	ldr r0, [r4, #0x3c]
	ldr r5, =0x000003E7
	orr r0, r0, #1
	mov r6, r5
	str r0, [r4, #0x3c]
_0203EE64:
	mov r0, r4
	mov r1, r5
	mov r2, r6
	bl SetSpriteButtonPosition
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__EnableMultipleButtons(SeaMapView *work, const u32 *states)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
_0203EE94:
	ldr r2, [r5, r4, lsl #2]
	mov r0, r6
	mov r1, r4
	bl SeaMapView__EnableButton
	add r4, r4, #1
	cmp r4, #8
	blo _0203EE94
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__SetButtonMode(SeaMapView *work, s32 mode)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mov r1, #1
	mov r4, r0
	mov r2, r1
	bl SeaMapView__EnableButton
	mov r0, r4
	mov r1, #2
	mov r2, #1
	bl SeaMapView__EnableButton
	cmp r5, #0
	beq _0203EEF8
	cmp r5, #1
	beq _0203EF2C
	cmp r5, #2
	beq _0203EF60
	ldmia sp!, {r3, r4, r5, pc}
_0203EEF8:
	add r0, r4, #0xe8
	mov r1, #2
	bl SetSpriteButtonState
	ldr r1, [r4, #0x160]
	add r0, r4, #0x18c
	orr r1, r1, #0x40
	str r1, [r4, #0x160]
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [r4, #0x204]
	bic r0, r0, #0x40
	str r0, [r4, #0x204]
	ldmia sp!, {r3, r4, r5, pc}
_0203EF2C:
	add r0, r4, #0xe8
	mov r1, #0
	bl SetSpriteButtonState
	ldr r1, [r4, #0x160]
	add r0, r4, #0x18c
	bic r1, r1, #0x40
	str r1, [r4, #0x160]
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [r4, #0x204]
	bic r0, r0, #0x40
	str r0, [r4, #0x204]
	ldmia sp!, {r3, r4, r5, pc}
_0203EF60:
	add r0, r4, #0xe8
	mov r1, #0
	bl SetSpriteButtonState
	ldr r1, [r4, #0x160]
	add r0, r4, #0x18c
	bic r1, r1, #0x40
	str r1, [r4, #0x160]
	mov r1, #2
	bl SetSpriteButtonState
	ldr r0, [r4, #0x204]
	orr r0, r0, #0x40
	str r0, [r4, #0x204]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ProcessButtons(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0203EFB8
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
_0203EFB8:
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r6, =word_210F782
	ldr r5, =padInput
	mov r7, #0
_0203EFD4:
	mov r0, r4
	mov r1, r7
	bl SeaMapView__IsButtonActive
	cmp r0, #0
	beq _0203F014
	mov r0, r4
	mov r1, r7
	bl SeaMapView__IsTouchAreaActive
	cmp r0, #0
	beq _0203F014
	mov r0, r7, lsl #1
	ldrh r1, [r5, #4]
	ldrh r0, [r6, r0]
	tst r1, r0
	strne r7, [r4, #0x790]
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
_0203F014:
	add r7, r7, #1
	cmp r7, #8
	blo _0203EFD4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__SetZoomLevel(SeaMapView *work, s32 level)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, r0
	mov r9, r1
	bl SeaMapView__SetButtonMode
	ldr r5, [r4, #0x10]
	ldr r6, [r4, #0x14]
	bl SeaMapManager__GetZoomInScale
	ldr r1, [r4, #0x10]
	add r7, r1, r0, lsl #7
	bl SeaMapManager__GetZoomInScale
	ldr r2, [r4, #0x14]
	mov r1, #0x60
	mla r8, r0, r1, r2
	mov r0, r9
	bl SeaMapManager__SetZoomLevel
	bl SeaMapManager__GetZoomInScale
	sub r7, r7, r0, lsl #7
	bl SeaMapManager__GetZoomInScale
	mov r1, #0x60
	mul r1, r0, r1
	sub r8, r8, r1
	bl SeaMapManager__GetZoomOutScale
	sub r1, r7, r5
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r4, #0x18]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r4, #0x18]
	bl SeaMapManager__GetZoomOutScale
	sub r1, r8, r6
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r4, #0x1c]
	orr r1, r1, r0, lsl #20
	add r1, r2, r1
	mov r0, #0xf
	str r1, [r4, #0x1c]
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ProcessPadInputs(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	beq _0203F1C8
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0203F114
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	bne _0203F1C8
_0203F114:
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	beq _0203F1C8
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0xf0
	beq _0203F1C8
	bl SeaMapManager__GetZoomInScale
	mov r2, #0
	mov r1, #0x6000
	umull r5, r3, r0, r1
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	str r2, [r4, #0x24]
	ldr r0, =padInput
	str r2, [r4, #0x20]
	adds r5, r5, #0x800
	ldrh r1, [r0, #0]
	adc r2, r3, #0
	mov r0, r5, lsr #0xc
	tst r1, #0x20
	ldrne r1, [r4, #0x10]
	orr r0, r0, r2, lsl #20
	subne r1, r1, r0
	strne r1, [r4, #0x10]
	ldr r1, =padInput
	ldrh r1, [r1, #0]
	tst r1, #0x10
	ldrne r1, [r4, #0x10]
	addne r1, r1, r0
	strne r1, [r4, #0x10]
	ldr r1, =padInput
	ldrh r1, [r1, #0]
	tst r1, #0x40
	ldrne r1, [r4, #0x14]
	subne r1, r1, r0
	strne r1, [r4, #0x14]
	ldr r1, =padInput
	ldrh r1, [r1, #0]
	tst r1, #0x80
	ldrne r1, [r4, #0x14]
	addne r0, r1, r0
	strne r0, [r4, #0x14]
_0203F1C8:
	bl SeaMapManager__GetZoomInScale
	ldr r2, [r4, #0x18]
	ldr r5, [r4, #0x10]
	smull r3, r2, r0, r2
	adds r3, r3, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r5, r3
	str r2, [r4, #0x10]
	ldr r3, [r4, #0x1c]
	ldr ip, [r4, #0x14]
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r3, r3, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	add r3, ip, r5
	mov r1, #0
	str r3, [r4, #0x14]
	str r1, [r4, #0x1c]
	str r1, [r4, #0x18]
	ldr r3, [r4, #0x20]
	ldr ip, [r4, #0x10]
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r3, r3, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	add r3, ip, r5
	str r3, [r4, #0x10]
	ldr r3, [r4, #0x24]
	ldr ip, [r4, #0x14]
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r3, r5, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, ip, r3
	str r0, [r4, #0x14]
	ldr r5, [r4, #0x20]
	ldr r0, =0x00000CCC
	mov r3, r5, asr #0x1f
	umull lr, ip, r5, r0
	mla ip, r5, r1, ip
	adds r5, lr, #0x800
	mla ip, r3, r0, ip
	adc r3, ip, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	str r5, [r4, #0x20]
	ldr ip, [r4, #0x24]
	mov r2, #0x800
	umull r5, lr, ip, r0
	mla lr, ip, r1, lr
	mov r1, ip, asr #0x1f
	mla lr, r1, r0, lr
	adds r1, r5, #0x800
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x24]
	ldr r0, [r4, #0x20]
	sub r3, r2, #0x20800
	cmp r0, r3
	movlt r0, r3
	blt _0203F2DC
	cmp r0, #0x20000
	movgt r0, #0x20000
_0203F2DC:
	str r0, [r4, #0x20]
	mov r0, #0x20000
	ldr r1, [r4, #0x24]
	rsb r0, r0, #0
	cmp r1, r0
	movlt r1, r0
	blt _0203F300
	cmp r1, #0x20000
	movgt r1, #0x20000
_0203F300:
	str r1, [r4, #0x24]
	ldr r0, [r4, #0x20]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0xcc
	movlt r0, #0
	strlt r0, [r4, #0x20]
	ldr r0, [r4, #0x24]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0xcc
	movlt r0, #0
	strlt r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203F344(SeaMapView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #0
	str r1, [r0, #0x24]
	str r1, [r0, #0x20]
	str r1, [r0, #0x2c]
	str r1, [r0, #0x28]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203F35C(SeaMapView *work, BOOL flag)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	cmp r1, #0
	movne r4, #3
	mov r5, r0
	moveq r4, #8
	bl SeaMapManager__GetWork
	add r1, r5, #0x358
	mov r2, r4
	add r0, r0, #0x13c
	add r1, r1, #0x400
	bl TouchField__UpdateAreaPriority
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__SetTouchAreaCallback(SeaMapView *work, TouchAreaCallback callback){
#ifdef NON_MATCHING

#else
    // clang-format off
	str r1, [r0, #0x764]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__TouchAreaCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__TouchAreaCallback(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0]
	ldr r1, [r1, #0x14]
	cmp r3, #0x400000
	beq _0203F3C0
	cmp r3, #0x800000
	beq _0203F438
	cmp r3, #0x1000000
	beq _0203F3E0
	ldmia sp!, {r3, pc}
_0203F3C0:
	mov r1, #0
	str r1, [r2, #0x24]
	str r1, [r2, #0x20]
	str r1, [r2, #0x2c]
	mov r0, r2
	str r1, [r2, #0x28]
	bl SeaMapView__InitTouchCursor
	ldmia sp!, {r3, pc}
_0203F3E0:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	ldr r0, [r2, #0x28]
	mvn r1, #0
	str r0, [r2, #0x20]
	ldr r0, [r2, #0x2c]
	str r0, [r2, #0x24]
	ldr r0, [r2, #0x20]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x3000
	movlt r0, #0
	strlt r0, [r2, #0x20]
	ldr r0, [r2, #0x24]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x3000
	movlt r0, #0
	strlt r0, [r2, #0x24]
	mov r0, r2
	bl SeaMapView__InitTouchCursor
	ldmia sp!, {r3, pc}
_0203F438:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	ldrsh r1, [r0, #4]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x28]
	ldrsh r1, [r0, #6]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x2c]
	ldrsh r1, [r0, #4]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x18]
	ldrsh r0, [r0, #6]
	rsb r0, r0, #0
	mov r0, r0, lsl #0xc
	str r0, [r2, #0x1c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__OnButtonPressed(TouchAreaResponse *response, TouchArea *touchArea, void *userData, u32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0]
	ldr r1, [r1, #0x14]
	cmp r0, #0x1000000
	bhi _0203F4B8
	bhs _0203F4F4
	cmp r0, #0x40000
	bhi _0203F4AC
	streq r3, [r2, #0x790]
	ldmia sp!, {r3, pc}
_0203F4AC:
	cmp r0, #0x400000
	beq _0203F4D4
	ldmia sp!, {r3, pc}
_0203F4B8:
	cmp r0, #0x2000000
	bhi _0203F4C8
	beq _0203F4D4
	ldmia sp!, {r3, pc}
_0203F4C8:
	cmp r0, #0x8000000
	beq _0203F4F4
	ldmia sp!, {r3, pc}
_0203F4D4:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	add r1, r2, #0x44
	mov r0, #0xa4
	mla r0, r3, r0, r1
	mov r1, #1
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
_0203F4F4:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	add r1, r2, #0x44
	mov r0, #0xa4
	mla r0, r3, r0, r1
	mov r1, #0
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback1(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #0
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback2(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #1
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback3(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #2
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback4(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #3
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback5(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #4
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback6(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #5
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback7(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #6
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__ButtonCallback8(TouchAreaResponse *response, TouchArea *touchArea, void *userData){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SeaMapView__OnButtonPressed
	mov r3, #7
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawPenMarker(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	add r0, r0, #0x164
	add r4, r0, #0x400
	bl SeaMapManager__GetNodeCount
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapManager__GetEndNode
	mov r1, r0
	ldrh r0, [r1, #8]
	ldrh r1, [r1, #0xa]
	add r2, r4, #8
	add r3, r4, #0xa
	bl SeaMapManager__Func_2043AD4
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawButtons(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	add r5, r0, #0x44
	mov r4, #0
	add r0, r0, #0x2f4
	add r6, r0, #0x400
	mov r7, r4
_0203F5FC:
	ldr r0, [r5, #0x3c]
	tst r0, #1
	bne _0203F640
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	cmp r4, #5
	blo _0203F640
	ldrsh r1, [r5, #8]
	mov r0, r6
	strh r1, [r6, #8]
	ldrsh r1, [r5, #0xa]
	strh r1, [r6, #0xa]
	bl AnimatorSprite__DrawFrame
_0203F640:
	add r4, r4, #1
	cmp r4, #8
	add r5, r5, #0xa4
	blo _0203F5FC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawTouchCursor(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, =touchInput
	ldrh r0, [r1, #0x12]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	ldrh r2, [r1, #0x14]
	add r0, r4, #0x1c8
	add r0, r0, #0x400
	strh r2, [r0, #8]
	ldrh r1, [r1, #0x16]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawPadCursors(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x700
	ldrsh r0, [r0, #0xa4]
	cmp r0, #0
	ldmltia sp!, {r3, r4, r5, pc}
	mov r0, r0, asr #5
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x22c
	add r4, r0, #0x400
	ldr r0, [r4, #0x3c]
	tst r0, #1
	bne _0203F718
	bic r0, r0, #0x100
	str r0, [r4, #0x3c]
	mov r0, #0x80
	strh r0, [r4, #8]
	mov r1, #0x20
	mov r0, r4
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x3c]
	mov r1, #0x80
	orr r0, r0, #0x100
	str r0, [r4, #0x3c]
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0x90
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
_0203F718:
	add r4, r5, #0x690
	ldr r0, [r4, #0x3c]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	bic r0, r0, #0x80
	str r0, [r4, #0x3c]
	mov r0, #0x20
	strh r0, [r4, #8]
	mov r1, #0x60
	mov r0, r4
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x3c]
	mov r1, #0xe0
	orr r0, r0, #0x80
	str r0, [r4, #0x3c]
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0x60
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203F770(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	ldr r1, [r4, #0x14]
	bl SeaMapManager__Func_2043974
	bl SeaMapManager__GetXPos
	str r0, [r4, #0x10]
	bl SeaMapManager__GetYPos
	str r0, [r4, #0x14]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__FadeToBlack(SeaMapView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #4]
	ldr r0, =VRAMSystem__GFXControl
	ldr r2, [r0, r1, lsl #2]
	ldrsh r1, [r2, #0x58]
	cmp r1, #0
	bge _0203F7CC
	rsb r0, r1, #0
	cmp r0, #1
	addgt r0, r1, #1
	strgth r0, [r2, #0x58]
	movle r0, #0
	strleh r0, [r2, #0x58]
	b _0203F7E4
_0203F7CC:
	ble _0203F7E4
	cmp r1, #1
	subgt r0, r1, #1
	strgth r0, [r2, #0x58]
	movle r0, #0
	strleh r0, [r2, #0x58]
_0203F7E4:
	ldrsh r0, [r2, #0x58]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__FadeActiveScreen(SeaMapView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #4]
	ldr r1, =VRAMSystem__GFXControl
	ldrsh r3, [r0, #8]
	ldr ip, [r1, r2, lsl #2]
	ldrsh r2, [ip, #0x58]
	cmp r2, r3
	bge _0203F830
	sub r1, r3, r2
	cmp r1, #1
	addgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
	b _0203F848
_0203F830:
	ble _0203F848
	sub r1, r2, r3
	cmp r1, #1
	subgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
_0203F848:
	ldrsh r1, [r0, #8]
	ldrsh r0, [ip, #0x58]
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SeaMapView__FadeOtherScreen(SeaMapView *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #4]
	ldrsh r3, [r0, #8]
	cmp r1, #0
	ldreq ip, =renderCoreGFXControlB
	ldrne ip, =renderCoreGFXControlA
	ldrsh r2, [ip, #0x58]
	cmp r2, r3
	bge _0203F89C
	sub r1, r3, r2
	cmp r1, #1
	addgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
	b _0203F8B4
_0203F89C:
	ble _0203F8B4
	sub r1, r2, r3
	cmp r1, #1
	subgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
_0203F8B4:
	ldrsh r1, [r0, #8]
	ldrsh r0, [ip, #0x58]
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawVoyagePath(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl SeaMapManager__ClearUnknownPtr
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _0203F8FC
	cmp r0, #1
	beq _0203F904
	cmp r0, #2
	beq _0203F90C
	b _0203F910
_0203F8FC:
	bl SeaMapView__DrawVoyagePath_Zoom0
	b _0203F910
_0203F904:
	bl SeaMapView__DrawVoyagePath_Zoom1
	b _0203F910
_0203F90C:
	bl SeaMapView__DrawVoyagePath_Zoom2
_0203F910:
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawVoyagePath_Zoom0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	addlo sp, sp, #4
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl SeaMapManager__GetStartNode
	mov r7, r0
	bl SeaMapManager__GetNextNode
	mov r6, #2
	mov r8, r0
	mov r5, r6
	mov r4, r6
_0203F950:
	str r6, [sp]
	ldrh r0, [r7, #8]
	ldrh r1, [r7, #0xa]
	ldrh r2, [r8, #8]
	ldrh r3, [r8, #0xa]
	bl SeaMapManager__DrawNodeLine2
	ldrh r0, [r7, #8]
	ldrh r1, [r7, #0xa]
	mov r2, r5
	bl SeaMapManager__DrawNodeLine
	ldrh r0, [r8, #8]
	ldrh r1, [r8, #0xa]
	mov r2, r4
	bl SeaMapManager__DrawNodeLine
	mov r0, r8
	mov r7, r8
	bl SeaMapManager__GetNextNode
	movs r8, r0
	bne _0203F950
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawVoyagePath_Zoom1(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapManager__GetStartNode
	mov r4, r0
	bl SeaMapManager__GetNextNode
	ldrh r1, [r4, #0xa]
	ldrh r2, [r4, #8]
	mov r4, r0
	mov r1, r1, lsl #0xf
	mov r0, r2, lsl #0xf
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r5, #1
_0203F9E0:
	ldrh r2, [r4, #8]
	ldrh r3, [r4, #0xa]
	mov r2, r2, lsl #0xf
	mov r3, r3, lsl #0xf
	mov r6, r2, lsr #0x10
	mov r7, r3, lsr #0x10
	mov r2, r6
	mov r3, r7
	str r5, [sp]
	bl SeaMapManager__DrawNodeLine2
	mov r0, r4
	bl SeaMapManager__GetNextNode
	movs r4, r0
	mov r0, r6
	mov r1, r7
	bne _0203F9E0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__DrawVoyagePath_Zoom2(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SeaMapManager__GetStartNode
	mov r4, r0
	bl SeaMapManager__GetNextNode
	mov r6, r0
	ldrh r0, [r4, #8]
	mov r1, #3
	bl FX_DivS32
	mov r2, r0, lsl #0x10
	ldrh r0, [r4, #0xa]
	mov r1, #3
	mov r7, r2, lsr #0x10
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r5, #3
	mov r8, r0, lsr #0x10
	mov r11, r5
	mov r4, #1
_0203FA78:
	ldrh r0, [r6, #8]
	mov r1, r5
	bl FX_DivS32
	mov r2, r0, lsl #0x10
	ldrh r0, [r6, #0xa]
	mov r1, r11
	mov r9, r2, lsr #0x10
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r0, r7
	mov r1, r8
	mov r2, r9
	mov r3, r10
	str r4, [sp]
	bl SeaMapManager__DrawNodeLine2
	mov r0, r6
	bl SeaMapManager__GetNextNode
	movs r6, r0
	mov r7, r9
	mov r8, r10
	bne _0203FA78
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203FAD4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _0203FAF8
	cmp r0, #1
	beq _0203FB00
	cmp r0, #2
	beq _0203FB08
	ldmia sp!, {r3, pc}
_0203FAF8:
	bl SeaMapView__Func_203FB10
	ldmia sp!, {r3, pc}
_0203FB00:
	bl SeaMapView__Func_203FB78
	ldmia sp!, {r3, pc}
_0203FB08:
	bl SeaMapView__Func_203FBE8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203FB10(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, pc}
	bl SeaMapManager__GetEndNode
	mov r5, r0
	bl SeaMapManager__GetPrevNode
	mov r1, #2
	str r1, [sp]
	mov r4, r0
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	ldrh r2, [r5, #8]
	ldrh r3, [r5, #0xa]
	bl SeaMapManager__DrawNodeLine2
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r2, #2
	bl SeaMapManager__DrawNodeLine
	ldrh r0, [r5, #8]
	ldrh r1, [r5, #0xa]
	mov r2, #2
	bl SeaMapManager__DrawNodeLine
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203FB78(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	addlo sp, sp, #4
	ldmloia sp!, {r3, r4, pc}
	bl SeaMapManager__GetEndNode
	mov r4, r0
	bl SeaMapManager__GetPrevNode
	mov r1, #1
	str r1, [sp]
	ldrh r1, [r0, #0xa]
	ldrh ip, [r0, #8]
	ldrh r2, [r4, #8]
	ldrh r3, [r4, #0xa]
	mov r0, ip, lsl #0xf
	mov r1, r1, lsl #0xf
	mov r2, r2, lsl #0xf
	mov r3, r3, lsl #0xf
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r3, r3, lsr #0x10
	bl SeaMapManager__DrawNodeLine2
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203FBE8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapManager__GetEndNode
	mov r5, r0
	bl SeaMapManager__GetPrevNode
	mov r4, r0
	ldrh r0, [r4, #8]
	mov r1, #3
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	ldrh r0, [r4, #0xa]
	mov r1, #3
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	ldrh r0, [r5, #8]
	mov r1, #3
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldrh r0, [r5, #0xa]
	mov r1, #3
	bl FX_DivS32
	mov r1, r4
	mov r2, r7
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r6
	mov ip, #1
	str ip, [sp]
	bl SeaMapManager__DrawNodeLine2
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 SeaMapView__Func_203FC7C(SeaMapView *work, u16 a2, u16 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	mov r5, r0
	strh r1, [sp, #0x18]
	add r0, sp, #0x14
	add r1, sp, #0x16
	strh r2, [sp, #0x1a]
	mov r4, #0
	bl SeaMapManager__GetLastNodePosition
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x14]
	cmp r1, r0
	ldreqh r2, [sp, #0x16]
	ldreqh r1, [sp, #0x1a]
	cmpeq r2, r1
	addeq sp, sp, #0x28
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r1, [sp, #0x1a]
	add r2, sp, #0x10
	add r3, sp, #0x12
	bl SeaMapManager__Func_2043BB4
	ldrh r0, [sp, #0x14]
	ldrh r1, [sp, #0x16]
	add r2, sp, #0xc
	add r3, sp, #0xe
	bl SeaMapManager__Func_2043BB4
	mov r0, #1
	str r0, [sp]
	add r1, sp, #0x10
	add r0, sp, #0x12
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	ldrh r2, [sp, #0xc]
	ldrh r3, [sp, #0xe]
	bl SeaMapCollision__HandleCollisions
	cmp r0, #0
	beq _0203FD58
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	add r2, sp, #0x18
	add r3, sp, #0x1a
	mvn r4, #0
	bl SeaMapManager__Func_2043BD0
	ldrh r1, [sp, #0x14]
	ldrh r0, [sp, #0x18]
	cmp r1, r0
	ldrneh r1, [sp, #0x16]
	ldrneh r0, [sp, #0x1a]
	cmpne r1, r0
	addeq sp, sp, #0x28
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
_0203FD58:
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x1a]
	bl SeaMapManager__AddNode
	bl SeaMapManager__GetEndNode
	ldr r1, [r5, #0x79c]
	ldr r0, [r0, #0xc]
	cmp r1, r0
	bge _0203FE0C
	ldrh r3, [sp, #0x18]
	ldrh r0, [sp, #0x14]
	ldrh r2, [sp, #0x1a]
	ldrh r1, [sp, #0x16]
	sub r3, r3, r0
	mov r4, r3, lsl #0xc
	sub r1, r2, r1
	mov r3, r1, lsl #0xc
	add r0, sp, #0x1c
	mov r2, #0
	mov r1, r0
	str r4, [sp, #0x1c]
	str r3, [sp, #0x20]
	str r2, [sp, #0x24]
	bl VEC_Normalize
	ldr r1, [sp, #0x1c]
	ldr r0, [r5, #0x79c]
	ldrh r3, [sp, #0x14]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1, asr #12
	strh r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	ldr r1, [r5, #0x79c]
	ldrh r4, [sp, #0x16]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r4, r2, asr #12
	mov r0, #0
	strh r1, [sp, #0x1a]
	sub r4, r0, #2
_0203FE0C:
	bl SeaMapManager__RemoveNode
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x1a]
	bl SeaMapManager__AddNode
	bl SeaMapManager__GetEndNode
	ldr r1, [r5, #0x79c]
	ldr r0, [r0, #0xc]
	subs r0, r1, r0
	str r0, [r5, #0x79c]
	movmi r0, #0
	strmi r0, [r5, #0x79c]
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203FE44(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__RemoveAllNodes
	ldr r0, =SeaMapView__sVars
	ldr r1, [r4, #0x798]
	ldr r0, [r0, #0xc]
	subs r0, r1, r0
	str r0, [r4, #0x79c]
	movmi r0, #0
	strmi r0, [r4, #0x79c]
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x94]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SeaMapView__Func_203FE80(SeaMapView *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x700
	ldrh r0, [r0, #0x94]
	bl SeaMapManager__Func_2045E58
	bl SeaMapManager__GetNodeCount
	add r1, r4, #0x700
	strh r0, [r1, #0x94]
	bl SeaMapManager__GetTotalDistance
	ldr r1, =SeaMapView__sVars
	ldr r2, [r4, #0x798]
	ldr r1, [r1, #0xc]
	sub r1, r2, r1
	subs r0, r1, r0
	str r0, [r4, #0x79c]
	movmi r0, #0
	strmi r0, [r4, #0x79c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}