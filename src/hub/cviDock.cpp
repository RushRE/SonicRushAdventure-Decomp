#include <hub/cviDock.hpp>
#include <hub/cviMapIcon.hpp>
#include <hub/hubConfig.h>
#include <hub/hubState.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <hub/hubAudio.h>
#include <hub/hubControl.hpp>
#include <game/graphics/unknown2056570.h>
#include <game/file/fileUnknown.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN15CViDockNpcGroupC1Ev(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry(void);
NOT_DECOMPILED void _ZN9CViShadow10LoadAssetsEv(void);
NOT_DECOMPILED void _ZN9CViShadow12Func_2167E9CEv(void);
NOT_DECOMPILED void _ZnwmPv(void);
NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZN10HubControl12Func_2157178Ev(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup10LoadAssetsEv(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup12ClearNpcListEv(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup4DrawEP7VecFx32(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup7AnimateEv(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup6AddNpcEv(void);
NOT_DECOMPILED void _ZN10HubControl10GetField54Ev(void);
NOT_DECOMPILED void _ZN11CVi3dObject4DrawEv(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup12Func_2168674EP7VecFx32llPiP20CViDockNpcGroupEntry(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroupD1Ev(void);
NOT_DECOMPILED void _ZN15CViDockNpcGroup12Func_2168608EP7VecFx32S1_S1_l(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B858El(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B850El(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViMsgEv(void);

NOT_DECOMPILED void Unknown2051334__Func_20514DC(void);
NOT_DECOMPILED void Unknown2051334__Func_20516EC(void);
}

// --------------------
// VARIABLES
// --------------------

static Task *ViDock__TaskSingleton;

NOT_DECOMPILED void *ovl05_02172EB4;
NOT_DECOMPILED void *ovl05_02172EBC;
NOT_DECOMPILED void *ovl05_02172ECA;
NOT_DECOMPILED void *ovl05_02172ED8;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void ViDock__Create(void)
{
    // TODO: should match when constructors are decompiled for 'CViDockPlayer' 'CViDockNpcGroup', 'CViShadow' && 'CViDockBack'
#ifdef NON_MATCHING
    ViDock__TaskSingleton = HubTaskCreate(ViDock__Main, ViDock__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1030, TASK_GROUP(16), HubHUD);

    CViDock *work = TaskGetWork(ViDock__TaskSingleton, CViDock);

    work->hitboxID        = 8;
    work->field_2         = 4;
    work->field_4         = 8;
    work->field_8         = 0;
    work->field_C         = 0;
    work->field_10        = 1;
    work->talkActionID    = 12;
    work->talkActionParam = 0;
    work->field_1468      = 0;
    work->field_1470      = 0;
    work->field_1B24      = 0;
    work->field_1B28      = 0;
    InitThreadWorker(&work->thread, 0x1000);
    ViDock__Func_215E678(work);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, =0x00001030
	mov r2, #0
	ldr r0, =ViDock__Main
	ldr r1, =ViDock__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViDock__CreateInternal
	ldr r1, =ViDock__TaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r2, #8
	add r0, r4, #0x32c
	strh r2, [r4]
	mov r1, #4
	strh r1, [r4, #2]
	str r2, [r4, #4]
	mov r3, #0
	str r3, [r4, #8]
	str r3, [r4, #0xc]
	mov r1, #1
	str r1, [r4, #0x10]
	add r2, r4, #0x1000
	mov r1, #0xc
	str r1, [r2, #0x460]
	str r3, [r2, #0x464]
	str r3, [r2, #0x468]
	str r3, [r2, #0x470]
	str r3, [r2, #0xb24]
	add r0, r0, #0x1800
	mov r1, #0x1000
	str r3, [r2, #0xb28]
	bl InitThreadWorker
	mov r0, r4
	bl ViDock__Func_215E678
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__CreateInternal(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	ldr r4, =0x00001BF8
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, r4
	bl _ZnwmPv
	movs r4, r0
	beq _0215DB8C
	add r0, r4, #0xf8
	bl _ZN11CViDockBackC1Ev
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	bl _ZN13CViDockPlayerC1Ev
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroupC1Ev
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadowC1Ev
_0215DB8C:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void ViDock__Func_215DB9C(void)
{
    if (ViDock__TaskSingleton != NULL)
    {
        DestroyTask(ViDock__TaskSingleton);
        ViDock__TaskSingleton = NULL;
    }
}

NONMATCH_FUNC void ViDock__Func_215DBC8(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	strh r5, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	str r5, [r4, #4]
	mov r0, r4
	mov r1, #8
	bl ViDock__Func_215E754
	mov r0, r4
	mov r1, #0
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
	mov r0, r4
	bl ViDock__Func_215EB04
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	ldrh r2, [r0, #0x34]
	add r0, r4, #0x1400
	mov r1, #0
	strh r2, [r0, #0x5c]
	add r0, r4, #0x1000
	str r1, [r0, #0xb24]
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163A7C
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215F9CC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DC80(s32 a1, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, =ViDock__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215DEF4
	cmp r5, #7
	movge r5, r6
	strh r5, [r4]
	add r0, r4, #0x32c
	str r6, [r4, #4]
	mov r3, #0
	strh r3, [r4, #2]
	add ip, r4, #0x1000
	str r3, [ip, #0xb24]
	mov lr, #1
	ldr r1, =ViDock__Func_215FFF4
	mov r2, r4
	add r0, r0, #0x1800
	mov r3, #0x18
	str lr, [ip, #0xb28]
	bl CreateThreadWorker
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Func_215FFC0
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDock__Func_215DD00(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0xb28]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DD2C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x18
	mov r1, #0
	bl ViMapIcon__Func_2163A7C
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215F9CC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DD64(s32 a1, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, =ViDock__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	strh r6, [r4]
	cmp r5, #0
	mov r0, #1
	strh r0, [r4, #2]
	mov r0, #8
	str r0, [r4, #4]
	mov r1, #0
	add r0, r4, #0x1000
	str r1, [r0, #0xb24]
	bne _0215DDDC
	mov r0, r4
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
_0215DDDC:
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	ldrh r3, [r0, #0x34]
	add r2, r4, #0x1400
	add r0, r4, #0x18
	mov r1, #1
	strh r3, [r2, #0x5c]
	bl ViMapIcon__Func_2163A7C
	cmp r5, #0
	beq _0215DE20
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215FE00
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	mov r0, #0
	str r0, [r4, #0xc]
	ldmia sp!, {r4, r5, r6, pc}
_0215DE20:
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215F998
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DE40(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	strh r5, [r4]
	mov r0, #2
	strh r0, [r4, #2]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, r4
	mov r2, #0
	add r1, r4, #0x1000
	str r2, [r1, #0xb24]
	bl ViDock__Func_215EA8C
	mov r0, r4
	mov r1, #1
	bl ViDock__Func_215E9F4
	mov r1, #0
	add r0, r4, #0x1500
	strh r1, [r0, #0xb8]
	mov r0, r4
	bl ViDock__Func_215ED0C
	mov r0, r4
	bl ViDock__Func_215EEA0
	add r0, r4, #0x18
	mov r1, #2
	bl ViMapIcon__Func_2163A7C
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215FE68
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DEF4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r1, r4, #0x1000
	mov r2, #0
	str r2, [r1, #0xb24]
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	mov r1, #8
	strh r1, [r4]
	mov r0, #4
	strh r0, [r4, #2]
	ldr r0, =ViDock__TaskSingleton
	str r1, [r4, #4]
	ldr r0, [r0, #0]
	mov r1, #0
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DF64(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215DF84(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl ViDock__Func_215EE7C
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDock__Func_215DFA0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x14]
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, r4, #0xf8
	ldmia r1, {r1, r2, r3}
	bl ViDockBack__Func_2164B9C
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViDock__Func_215DFE4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #4]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDock__Func_215E000(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0x460]
	cmp r0, #0xb
	movlt r0, #1
	movge r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E02C(s32 *id, s32 *param)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =ViDock__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	cmp r5, #0
	addne r1, r0, #0x1000
	ldrne r1, [r1, #0x460]
	strne r1, [r5]
	cmp r4, #0
	addne r0, r0, #0x1000
	ldrne r0, [r0, #0x464]
	strne r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViDock__Func_215E06C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0x468]
	cmp r0, #0
	ldrne r0, [r0, #0x30c]
	moveq r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E098(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r1, [r0, #0x468]
	cmp r1, #0
	ldrne r0, [r1, #0x30c]
	cmpne r0, #0
	subne r0, r0, #1
	strne r0, [r1, #0x30c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViDock__GetTalkingNpc(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #0x17
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0x468]
	cmp r0, #0
	moveq r0, #0x17
	ldrne r0, [r0, #0x300]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E104(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r1, r4, lsl #0x10
	mov r5, r0
	mov r0, r1, lsr #0x10
	bl HubConfig__GetNpcConfig
	add r1, r5, #0x1000
	ldr r1, [r1, #0x138]
	ldrh r6, [r0, #0]
	cmp r1, #0
	moveq r1, #0
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r4, r5, #0x130
_0215E148:
	add r0, r1, #0x300
	ldrh r0, [r0, #0x12]
	cmp r6, r0
	addeq r0, r5, #0x1000
	streq r1, [r0, #0x468]
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x1000
	bl _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry
	movs r1, r0
	bne _0215E148
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E178(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1f8
	add r2, r4, #0x1000
	mov r1, #1
	str r1, [r2, #0x470]
	mov r1, #0
	add r0, r0, #0xc00
	str r1, [r2, #0x474]
	bl ViDockPlayer__Func_2166B80
	add r0, r4, #0x1000
	ldr r0, [r0, #0x468]
	cmp r0, #0
	beq _0215E31C
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, sp, #0x3c
	bl CPPHelpers__VEC_SetFromVec_2
	add r0, r4, #0x1000
	ldr r0, [r0, #0x468]
	add r0, r0, #8
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, sp, #0x30
	bl CPPHelpers__VEC_SetFromVec_2
	add r0, sp, #0x24
	bl CPPHelpers__Func_2085EE8
	add r0, sp, #0x18
	bl CPPHelpers__Func_2085EE8
	add r0, sp, #0xc
	add r1, sp, #0x3c
	add r2, sp, #0x30
	bl CPPHelpers__VEC_Subtract_Alt
	add r0, sp, #0xc
	bl CPPHelpers__VEC_Normalize
	mov r1, r0
	add r0, sp, #0x24
	bl CPPHelpers__Func_2085FA8
	ldr r0, [sp, #0x2c]
	bl Math__Func_207B1A4
	mov r5, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0
	movlt r0, #1
	movge r0, #0
	cmp r0, #0
	rsbne r0, r5, #0x10000
	movne r0, r0, lsl #0x10
	movne r5, r0, lsr #0x10
	add r0, r4, #0x1000
	ldr r0, [r0, #0x468]
	mov r1, r5
	bl ViDockNpc__SetState1
	ldr r1, =0xFFFF8001
	add r0, r4, #0x1f8
	add r1, r5, r1
	mov r1, r1, lsl #0x10
	add r0, r0, #0xc00
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ViDockPlayer__Func_21667A8
	add r0, sp, #0
	add r1, sp, #0x30
	add r2, sp, #0x3c
	bl CPPHelpers__VEC_Subtract_Alt
	add r0, sp, #0x18
	add r1, sp, #0
	bl CPPHelpers__Func_2085FA8
	ldr r2, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	mov r2, r2, asr #1
	mov r1, r1, asr #1
	str r1, [sp, #0x28]
	ldr r0, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r2, r0, asr #1
	add r0, sp, #0x24
	add r1, sp, #0x3c
	str r2, [sp, #0x2c]
	bl CPPHelpers__VEC_Add_Alt
	add r0, sp, #0x18
	bl CPPHelpers__VEC_Normalize
	add r0, sp, #0x24
	bl CPPHelpers__Func_2085F98
	ldr r2, [r0, #0]
	add r1, r4, #0x1000
	str r2, [r1, #0x478]
	ldr r2, [r0, #4]
	str r2, [r1, #0x47c]
	ldr r2, [r0, #8]
	add r0, sp, #0x18
	str r2, [r1, #0x480]
	bl CPPHelpers__Func_2085F98
	ldr r2, [r0, #0]
	add r1, r4, #0x1000
	str r2, [r1, #0x484]
	ldr r2, [r0, #4]
	str r2, [r1, #0x488]
	ldr r0, [r0, #8]
	str r0, [r1, #0x48c]
_0215E31C:
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215FD48
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E340(s32 a1, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r2, =ViDock__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1000
	ldr r1, [r0, #0x470]
	cmp r1, #0
	ldrne r0, [r0, #0x468]
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _0215E3B0
	ldrh r0, [r4, #0]
	cmp r0, #7
	bhs _0215E3B0
	bl HubConfig__GetDockStageConfig
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	bne _0215E3B4
_0215E3B0:
	mov r6, #0
_0215E3B4:
	cmp r6, #0
	beq _0215E3F0
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	ldrsh r0, [r0, #0x40]
	add r1, r4, #0x78
	add r2, r4, #0x84
	str r0, [sp]
	add r0, r4, #0x18
	add r1, r1, #0x1400
	add r3, r2, #0x1400
	mov r2, #0x20
	str r5, [sp, #4]
	bl ViMapIcon__Func_2163AA0
	b _0215E3FC
_0215E3F0:
	add r0, r4, #0x18
	mov r1, #0x20
	bl ViMapIcon__Func_2163C3C
_0215E3FC:
	add r0, r4, #0x1000
	str r6, [r0, #0x474]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E410(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x470]
	ldr r0, [r0, #0x468]
	cmp r0, #0
	beq _0215E45C
	bl ViDockNpc__SetState2
	add r0, r4, #0x1000
	ldr r0, [r0, #0x474]
	cmp r0, #0
	beq _0215E45C
	add r0, r4, #0x18
	mov r1, #0x20
	bl ViMapIcon__Func_2163C3C
_0215E45C:
	add r2, r4, #0x1000
	mov r1, #0xc
	add r0, r4, #0x1f8
	str r1, [r2, #0x460]
	mov r3, #0
	str r3, [r2, #0x464]
	add r0, r0, #0xc00
	mov r1, #1
	str r3, [r2, #0x468]
	bl ViDockPlayer__Func_2166B80
	ldr r0, =ViDock__TaskSingleton
	ldr r1, =ViDock__Main_215F9CC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDock__Func_215E4A0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0xc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E4BC(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #0x10]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E4DC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0xe00
	ldrh r4, [r0, #0x32]
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r2, r4
	mov r0, #0
	bl HubState__SetPlayerState
	add r0, r5, #0x1000
	ldr r4, [r0, #0x138]
	mov r6, #0
	cmp r4, #0
	moveq r4, #0
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r5, r5, #0x130
_0215E52C:
	ldrh r7, [r4, #0x3a]
	ldr r8, [r4, #0x30c]
	add r0, r4, #8
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r0, r6
	mov r2, r7
	mov r3, r8
	bl HubState__SetNpcState
	mov r1, r4
	add r0, r5, #0x1000
	bl _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry
	add r1, r6, #1
	movs r4, r0
	mov r0, r1, lsl #0x10
	mov r6, r0, lsr #0x10
	bne _0215E52C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E578(BOOL a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	bl HubState__CheckHasPlayerState
	cmp r0, #0
	beq _0215E5CC
	mov r0, #0
	bl HubState__GetPlayerPosition
	mov r1, r0
	add r0, r5, #0xe00
	bl CPPHelpers__VEC_Copy_Alt
	mov r0, #0
	bl HubState__GetPlayerAngle
	add r1, r5, #0xe00
	strh r0, [r1, #0x30]
	ldrh r0, [r1, #0x30]
	strh r0, [r1, #0x32]
_0215E5CC:
	add r0, r5, #0x1000
	ldr r7, [r0, #0x138]
	mov r6, #0
	cmp r7, #0
	moveq r7, #0
	cmp r7, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r5, r5, #0x130
_0215E5EC:
	mov r0, r6
	bl HubState__CheckHasNpcState
	cmp r0, #0
	beq _0215E630
	mov r0, r6
	bl HubState__GetNpcPosition
	mov r1, r0
	add r0, r7, #8
	bl CPPHelpers__VEC_Copy_Alt
	cmp r4, #0
	beq _0215E624
	mov r0, r6
	bl HubState__GetNpcAngle
	strh r0, [r7, #0x38]
_0215E624:
	mov r0, r6
	bl HubState__GetNpcUnknown
	str r0, [r7, #0x30c]
_0215E630:
	mov r1, r7
	add r0, r5, #0x1000
	bl _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry
	add r1, r6, #1
	movs r7, r0
	mov r0, r1, lsl #0x10
	mov r6, r0, lsr #0x10
	bne _0215E5EC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E658(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #0x14]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E678(CViDock *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #8
	bl ViDock__Func_215E754
	mov r0, r4
	mov r1, #0
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
	mov r0, r4
	bl ViDock__Func_215EB04
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadow10LoadAssetsEv
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Init
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__Init
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x46c]
	mov r0, #1
	str r0, [r4, #0xc]
	str r1, [r4, #0x14]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E6E4(CViDock *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x32c
	add r0, r0, #0x1800
	bl ReleaseThreadWorker
	add r0, r4, #0x48
	add r1, r4, #0x1000
	mov r2, #0
	add r0, r0, #0x1400
	str r2, [r1, #0xb28]
	bl _ZN9CViShadow12Func_2167E9CEv
	mov r0, r4
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	mov r0, r4
	bl ViDock__Func_215E81C
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x46c]
	str r1, [r4, #0xc]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E754(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, r0
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	mov r5, r1
	bl ViDockPlayer__LoadAssets
	ldrh r0, [r4, #0]
	cmp r0, #7
	addhs sp, sp, #0x10
	ldmhsia sp!, {r3, r4, r5, pc}
	ldrh r1, [r4, #2]
	cmp r1, #0
	bne _0215E7A0
	add r1, sp, #4
	add r2, sp, #0
	mov r3, r5
	bl ViDockBack__Func_2164C20
	b _0215E7B4
_0215E7A0:
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #8]
	str r0, [sp, #4]
	strh r0, [sp]
_0215E7B4:
	add r1, sp, #4
	add r0, r4, #0xe00
	bl CPPHelpers__VEC_Copy_Alt
	add r0, r4, #0x1f8
	ldrh r1, [sp]
	add r0, r0, #0xc00
	mov r2, #1
	bl ViDockPlayer__Func_21667A8
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	ldrsh r2, [r0, #0x40]
	add r0, r4, #0x218
	add r1, sp, #4
	str r2, [sp, #0xc]
	str r2, [sp, #8]
	str r2, [sp, #4]
	add r0, r0, #0xc00
	bl CPPHelpers__VEC_Copy_Alt
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	add r2, r4, #0x1f8
	ldr r1, [r0, #0x38]
	add r0, r2, #0xc00
	bl ViDockPlayer__Func_2166B90
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E81C(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =ViDockPlayer__Func_2166748
	add r0, r0, #0x1f8
	add r0, r0, #0xc00
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E830(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x18
	mov r9, r0
	ldr r0, [r9, #8]
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0
	mov r5, r4
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215E874
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	movne r0, #1
	bne _0215E878
_0215E874:
	mov r0, #0
_0215E878:
	cmp r0, #0
	beq _0215E93C
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _0215E93C
	add r0, sp, #0xc
	bl CPPHelpers__Func_2085EE8
	ldr r1, =touchInput
	add r0, r9, #0xe00
	ldrh r7, [r1, #0x14]
	ldrh r8, [r1, #0x16]
	bl CPPHelpers__Func_2085F9C
	add r1, sp, #8
	add r2, sp, #4
	bl NNS_G3dWorldPosToScrPos
	ldr r1, [sp, #8]
	ldr r0, [sp, #4]
	sub r1, r7, r1
	movs r2, r1, lsl #0xc
	sub r0, r8, r0
	mov r1, r0, lsl #0xc
	mov r0, #0
	str r2, [sp, #0xc]
	rsbmi r2, r2, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	cmp r2, #0x40000
	bgt _0215E8FC
	ldr r0, [sp, #0x10]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x30000
	ble _0215E900
_0215E8FC:
	mov r5, #1
_0215E900:
	add r0, sp, #0
	add r1, sp, #0xc
	bl CPPHelpers__VEC_Magnitude
	add r0, sp, #0
	ldr r0, [r0, #0]
	mov r0, r0, asr #0xc
	cmp r0, #4
	blt _0215E93C
	add r0, sp, #0xc
	bl CPPHelpers__VEC_Normalize
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x10]
	bl FX_Atan2Idx
	mov r6, r0
	mov r4, #1
_0215E93C:
	cmp r4, #0
	bne _0215E9C0
	ldr r0, =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x40
	beq _0215E970
	tst r0, #0x20
	movne r6, #0xa000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x6000
	moveq r6, #0x8000
	b _0215E9AC
_0215E970:
	tst r0, #0x80
	beq _0215E994
	tst r0, #0x20
	movne r6, #0xe000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x2000
	moveq r6, #0
	b _0215E9AC
_0215E994:
	tst r0, #0x20
	movne r6, #0xc000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x4000
	mvneq r6, #0
_0215E9AC:
	cmp r6, #0
	blt _0215E9C0
	mov r4, #1
	tst r0, #2
	movne r5, r4
_0215E9C0:
	cmp r4, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r9, #0x1f8
	mov r1, r6, lsl #0x10
	mov r2, r5
	add r0, r0, #0xc00
	mov r1, r1, lsr #0x10
	bl ViDockPlayer__Func_21667BC
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215E9F4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #2]
	mov r4, r1
	mov r1, #9
	cmp r0, #0
	beq _0215EA24
	cmp r0, #1
	beq _0215EA3C
	cmp r0, #2
	beq _0215EA54
	b _0215EA68
_0215EA24:
	ldrh r0, [r5, #0]
	cmp r0, #7
	bhs _0215EA68
	bl HubConfig__GetDockStageConfig
	ldr r1, [r0, #0]
	b _0215EA68
_0215EA3C:
	ldrh r0, [r5, #0]
	cmp r0, #8
	bhs _0215EA68
	bl HubConfig__GetDockUnknownConfig
	ldr r1, [r0, #0]
	b _0215EA68
_0215EA54:
	ldrh r0, [r5, #0]
	cmp r0, #5
	bhs _0215EA68
	bl HubConfig__GetDockMapConfig
	ldr r1, [r0, #0]
_0215EA68:
	mov r3, r4
	add r0, r5, #0xf8
	mov r2, #0
	bl ViDockBack__LoadAssets
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EA7C(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =ViDockBack__Func_2164968
	add r0, r0, #0xf8
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EA8C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	mov r1, #9
	cmp r0, #1
	bne _0215EAC0
	ldrh r0, [r4, #0]
	cmp r0, #8
	bhs _0215EAB8
	bl HubConfig__GetDockUnknownConfig
	ldr r1, [r0, #0]
_0215EAB8:
	mov r2, #1
	b _0215EAE8
_0215EAC0:
	cmp r0, #2
	moveq r1, #0
	moveq r2, #2
	beq _0215EAE8
	ldrh r0, [r4, #0]
	cmp r0, #7
	bhs _0215EAE4
	bl HubConfig__GetDockStageConfig
	ldr r1, [r0, #0]
_0215EAE4:
	mov r2, #0
_0215EAE8:
	add r0, r4, #0x18
	bl ViMapIcon__Func_21639A4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EAF4(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =ViMapIcon__Func_2163A50
	add r0, r0, #0x18
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EB04(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r10, r0
	ldrh r1, [r10, #0]
	cmp r1, #7
	bhs _0215EC28
	ldr r0, =ovl05_02172EBC
	mov r1, r1, lsl #1
	ldrh r11, [r0, r1]
	ldr r0, =ovl05_02172ECA
	mov r4, #0
	ldrh r0, [r0, r1]
	cmp r11, #0
	str r0, [sp, #4]
	ble _0215EC28
	add r0, r10, #0x130
	str r0, [sp, #8]
_0215EB48:
	ldr r0, [sp, #4]
	add r5, r0, r4
	mov r0, r5
	bl _ZN10HubControl12Func_215B850El
	cmp r0, #0
	beq _0215EC1C
	mov r0, r5
	bl _ZN10HubControl12Func_215B858El
	cmp r0, #0
	beq _0215EC1C
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetNpcConfig
	mov r6, r0
	ldr r0, [r6, #8]
	blx r0
	mov r7, r0
	ldr r0, [sp, #8]
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup6AddNpcEv
	ldrsh r1, [r6, #4]
	ldrsh r3, [r6, #6]
	mov r8, r0
	sub r0, r5, #7
	cmp r0, #1
	movhi r9, #1
	add r0, sp, #0xc
	mov r2, #0
	mov r1, r1, lsl #0xc
	mov r3, r3, lsl #0xc
	movls r9, #0
	bl CPPHelpers__VEC_Set
	add r0, sp, #0xc
	bl CPPHelpers__Func_2085F98
	str r9, [sp]
	mov r2, r0
	ldrh r3, [r6, #2]
	mov r1, r5
	mov r0, r8
	bl ViDockNpc__LoadAssets
	ldrh r0, [r10, #0]
	bl HubConfig__GetDockStageConfig
	ldrsh r2, [r0, #0x40]
	add r0, r8, #0x20
	add r1, sp, #0x18
	str r2, [sp, #0x20]
	str r2, [sp, #0x1c]
	str r2, [sp, #0x18]
	bl CPPHelpers__VEC_Copy_Alt
	ldrh r1, [r7, #2]
	ldrh r0, [r7, #0]
	str r0, [r8, #0x304]
	str r1, [r8, #0x308]
_0215EC1C:
	add r4, r4, #1
	cmp r4, r11
	blt _0215EB48
_0215EC28:
	add r0, r10, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup10LoadAssetsEv
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EC44(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =_ZN15CViDockNpcGroup12ClearNpcListEv
	add r0, r0, #0x130
	add r0, r0, #0x1000
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EC58(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x38
	ldrh r4, [r0, #0]
	cmp r4, #7
	addhs sp, sp, #0x38
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, pc}
	ldr r6, =ovl05_02172ED8
	add r5, sp, #0
	mov r4, #0xe
_0215EC80:
	ldrh lr, [r6]
	ldrh ip, [r6, #2]
	add r6, r6, #4
	strh lr, [r5]
	strh ip, [r5, #2]
	add r5, r5, #4
	subs r4, r4, #1
	bne _0215EC80
	ldrh ip, [r0]
	add lr, sp, #0
	mov r0, ip, lsl #3
	ldrsh r0, [lr, r0]
	add ip, lr, ip, lsl #3
	add r0, r3, r0
	cmp r1, r0
	blt _0215ECFC
	ldrsh r0, [ip, #4]
	add r0, r3, r0
	cmp r1, r0
	bgt _0215ECFC
	ldrsh r0, [ip, #2]
	ldr r1, [sp, #0x48]
	add r0, r1, r0
	cmp r2, r0
	blt _0215ECFC
	ldrsh r0, [ip, #6]
	add r0, r1, r0
	cmp r2, r0
	addle sp, sp, #0x38
	movle r0, #1
	ldmleia sp!, {r4, r5, r6, pc}
_0215ECFC:
	mov r0, #0
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215ED0C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r4, r0
	bl _ZN10HubControl17GetFileFrom_ViMsgEv
	mov r1, #0xd
	bl FileUnknown__GetAOUFile
	mov r5, r0
	bl _ZN10HubControl10GetField54Ev
	mov r1, r0
	mov r0, #0x13
	str r0, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r3, #1
	bl FontAnimator__LoadFont2
	add r0, r4, #0xf4
	mov r1, r5
	add r0, r0, #0x1400
	bl FontAnimator__LoadMPCFile
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockMapConfig
	ldrh r1, [r0, #0x12]
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__LoadPaletteFunc2
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	cmp r0, #1
	movne r5, #0x12
	movne r6, #6
	bne _0215EDEC
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #0x10
	bl FontAnimator__AdvanceLine
	mov r5, #0x14
	mov r6, #4
_0215EDEC:
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #0
	bl FontAnimator__LoadCharacters
	bl _ZN10HubControl10GetField54Ev
	mov r2, #0
	mov r1, #2
	stmia sp, {r1, r2, r5}
	mov r1, #0x20
	str r1, [sp, #0xc]
	str r6, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, r0
	str r2, [sp, #0x18]
	mov lr, #1
	add ip, r4, #0x490
	str lr, [sp, #0x1c]
	mov r0, #5
	str r0, [sp, #0x20]
	mov r3, r2
	add r0, ip, #0x1000
	bl FontWindowAnimator__Load2
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Func_20599B4
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EE58(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Release
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__Release
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EE7C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__Draw
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Draw
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EEA0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r0, #0x10000
	mov r1, #0x10
	bl FX_DivS32
	mov r3, #0
	ldr r5, =FX_SinCosTable_
	mov r1, r3
	mov r2, r4
	mov ip, r0, lsl #0x10
_0215EEC8:
	mov r0, r3, asr #4
	mov r6, r0, lsl #1
	add r0, r5, r6, lsl #1
	ldrsh lr, [r0, #2]
	add r0, r2, #0x1000
	add r3, r3, ip, lsr #16
	str lr, [r0, #0x5bc]
	mov lr, r6, lsl #1
	ldrsh lr, [r5, lr]
	mov r3, r3, lsl #0x10
	add r1, r1, #1
	str lr, [r0, #0x5c0]
	cmp r1, #0x10
	mov r3, r3, lsr #0x10
	add r2, r2, #0xc
	blt _0215EEC8
	add r2, r4, #0x1600
	mov r3, #0
	mov r0, #0x1000
	mov r1, #6
	strh r3, [r2, #0x7c]
	bl FX_DivS32
	add r1, r4, #0x1600
	strh r0, [r1, #0x7e]
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x680]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EF3C(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215EF40(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r4, r0
	add r1, r4, #0x1600
	mov r0, #0
	strh r0, [r1, #0x84]
	ldrsh r3, [r1, #0x7c]
	mov r2, #1
_0215EF60:
	add r0, r4, r2, lsl #1
	add r0, r0, #0x1600
	strh r3, [r0, #0x84]
	ldrsh r0, [r1, #0x7e]
	add r2, r2, #1
	cmp r2, #7
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	blt _0215EF60
	add r0, r4, #0x1600
	mov r1, #0x1000
	strh r1, [r0, #0x92]
	ldr r7, =ovl05_02172EB4
	mov r0, #1
	add r1, r4, #0x1000
_0215EFA0:
	ldr r3, [r1, #0x680]
	add r2, r4, r0, lsl #1
	add r3, r3, r0
	mov r3, r3, lsl #0x1e
	mov r3, r3, lsr #0x1d
	ldrh r3, [r7, r3]
	add r2, r2, #0x1600
	add r0, r0, #1
	strh r3, [r2, #0x94]
	cmp r0, #7
	blt _0215EFA0
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x90]
	add r0, r4, #0x1000
	ldr r1, [r0, #0x680]
	rsb r0, r2, #0x1000
	mov r0, r0, lsl #0x10
	and r1, r1, #3
	cmp r1, #3
	mov r7, r0, asr #0x10
	addls pc, pc, r1, lsl #2
	b _0215F034
_0215EFF8: // jump table
	b _0215F008 // case 0
	b _0215F014 // case 1
	b _0215F020 // case 2
	b _0215F02C // case 3
_0215F008:
	ldr r5, =0x00007BF7
	ldr r6, =0x00006FE0
	b _0215F034
_0215F014:
	ldr r5, =0x00006FE0
	ldr r6, =0x00007BF7
	b _0215F034
_0215F020:
	ldr r5, =0x00007BF7
	ldr r6, =0x00007FFF
	b _0215F034
_0215F02C:
	ldr r5, =0x00007FFF
	ldr r6, =0x00007BF7
_0215F034:
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x7e]
	mov r0, r5
	mov r1, r6
	mov r3, r7
	bl Unknown2051334__Func_20516EC
	add r1, r4, #0x1600
	strh r0, [r1, #0x94]
	add r0, r4, #0x1000
	ldr r0, [r0, #0x680]
	add r0, r0, #7
	and r0, r0, #3
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215F0AC
_0215F070: // jump table
	b _0215F080 // case 0
	b _0215F08C // case 1
	b _0215F098 // case 2
	b _0215F0A4 // case 3
_0215F080:
	ldr r5, =0x00007BF7
	ldr r6, =0x00006FE0
	b _0215F0AC
_0215F08C:
	ldr r5, =0x00006FE0
	ldr r6, =0x00007BF7
	b _0215F0AC
_0215F098:
	ldr r5, =0x00007BF7
	ldr r6, =0x00007FFF
	b _0215F0AC
_0215F0A4:
	ldr r5, =0x00007FFF
	ldr r6, =0x00007BF7
_0215F0AC:
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x7e]
	mov r0, r5
	mov r1, r6
	mov r3, r7
	bl Unknown2051334__Func_20516EC
	add r1, r4, #0x1600
	strh r0, [r1, #0xa2]
	ldrsh r2, [r1, #0x7c]
	add r0, r4, #0x27c
	add r3, r0, #0x1400
	add r0, r2, #0x20
	strh r0, [r1, #0x7c]
	ldrsh r2, [r1, #0x7e]
	ldrsh r0, [r1, #0x7c]
	cmp r0, r2
	blt _0215F10C
	ldrsh r1, [r3, #0]
	add r0, r4, #0x1000
	sub r1, r1, r2
	strh r1, [r3]
	ldr r1, [r0, #0x680]
	add r1, r1, #3
	str r1, [r0, #0x680]
_0215F10C:
	add r0, r4, #0x2a4
	add r1, r4, #0x1bc
	add r11, r0, #0x1400
	mov r0, #0
	add r9, r1, #0x1400
	str r0, [sp]
	add r7, sp, #4
	mov r6, r0
	mov r5, r0
_0215F130:
	mov r8, #0
	mov r10, r11
_0215F138:
	add r0, r4, r8, lsl #1
	str r6, [r7]
	str r6, [r7, #4]
	str r6, [r7, #8]
	add r0, r0, #0x1600
	ldrsh r3, [r0, #0x86]
	mov r0, r10
	mov r1, r7
	mov r2, r9
	bl Unknown2051334__Func_20514DC
	add r8, r8, #1
	str r5, [r10, #8]
	cmp r8, #6
	add r10, r10, #0xc
	blt _0215F138
	ldr r0, [sp]
	add r11, r11, #0x48
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #0x10
	add r9, r9, #0xc
	blt _0215F130
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215F1A8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xa0
	mov r5, #0
	mov r10, r0
	sub r4, r5, #0x400000
	mov r3, #0x400000
	mov r2, #0x300000
	mov r1, #0x1000
	add r0, sp, #0x64
	str r5, [sp, #0x94]
	str r5, [sp, #0x98]
	str r4, [sp, #0x9c]
	str r3, [sp, #0x88]
	str r2, [sp, #0x8c]
	str r1, [sp, #0x90]
	bl MTX_Identity33_
	add r0, sp, #0x94
	bl NNS_G3dGlbSetBaseTrans
	add r0, sp, #0x88
	bl NNS_G3dGlbSetBaseScale
	ldr r1, =NNS_G3dGlb+0x000000BC
	add r0, sp, #0x64
	bl MI_Copy36B
	ldr r0, =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #0xa4
	str r1, [r0, #0xfc]
	bl NNS_G3dGlbFlushWVP
	ldr r1, =0x001F00C0
	mov r0, #0x29
	str r1, [sp, #0x60]
	add r1, sp, #0x60
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x20000000
	str r0, [sp, #0x5c]
	mov r0, #0x2a
	add r1, sp, #0x5c
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, r5
	str r0, [sp, #0x58]
	mov r0, #0x2b
	add r1, sp, #0x58
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #2
	str r0, [sp, #0x54]
	mov r0, #0x10
	add r1, sp, #0x54
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, r5
	mov r0, #0x11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	mov r0, r5
	str r0, [sp, #4]
	str r10, [sp]
	mov r8, r10
_0215F298:
	mov r3, #2
	add r1, sp, #0x50
	mov r0, #0x40
	mov r2, #1
	str r3, [sp, #0x50]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x84]
	ldrsh r1, [r0, #0x86]
	cmp r2, r1
	bge _0215F2F4
	ldrh r3, [r0, #0x94]
	add r1, sp, #0x4c
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x4c]
	bl NNS_G3dGeBufferOP_N
	mov r3, #0
	add r1, sp, #0x48
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x48]
	bl NNS_G3dGeBufferOP_N
_0215F2F4:
	ldr r9, [sp]
	mov r7, #0
	mov r6, #0x20
	add r5, sp, #0x44
	mov r4, #1
	mov r11, #0x25
_0215F30C:
	add r0, r10, r7, lsl #1
	add r0, r0, #0x1600
	ldrh r2, [r0, #0x96]
	mov r0, r6
	mov r1, r5
	str r2, [sp, #0x44]
	mov r2, r4
	bl NNS_G3dGeBufferOP_N
	add r0, r9, #0x1000
	ldr r1, [r0, #0x6a8]
	ldr r2, [r0, #0x6a4]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x40]
	mov r0, r11
	add r1, sp, #0x40
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, #0x1000
	ldr r1, [r0, #0x6f0]
	ldr r2, [r0, #0x6ec]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x3c]
	mov r0, #0x25
	add r1, sp, #0x3c
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r7, r7, #1
	add r9, r9, #0xc
	cmp r7, #6
	blt _0215F30C
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x90]
	ldrsh r1, [r0, #0x92]
	cmp r2, r1
	bge _0215F478
	ldrh r3, [r0, #0xa2]
	add r1, sp, #0x38
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x38]
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0x5c0]
	ldr r2, [r0, #0x5bc]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0x34
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x34]
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0x5cc]
	ldr r2, [r0, #0x5c8]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0x30
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x30]
	bl NNS_G3dGeBufferOP_N
_0215F478:
	mov r1, #0
	mov r2, r1
	mov r0, #0x41
	bl NNS_G3dGeBufferOP_N
	ldr r0, [sp, #4]
	add r8, r8, #0xc
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #0xf
	ldr r0, [sp]
	add r0, r0, #0x48
	str r0, [sp]
	blt _0215F298
	mov r3, #2
	add r1, sp, #0x2c
	mov r0, #0x40
	mov r2, #1
	str r3, [sp, #0x2c]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x84]
	ldrsh r1, [r0, #0x86]
	cmp r2, r1
	bge _0215F508
	ldrh r3, [r0, #0x94]
	add r1, sp, #0x28
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x28]
	bl NNS_G3dGeBufferOP_N
	mov r3, #0
	add r1, sp, #0x24
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x24]
	bl NNS_G3dGeBufferOP_N
_0215F508:
	mov r8, r10
	mov r9, #0
	mov r7, #0x20
	add r6, sp, #0x20
	mov r5, #1
	mov r4, #0x25
	add r11, sp, #0x1c
_0215F524:
	add r0, r10, r9, lsl #1
	add r0, r0, #0x1600
	ldrh r2, [r0, #0x96]
	mov r0, r7
	mov r1, r6
	str r2, [sp, #0x20]
	mov r2, r5
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0xae0]
	ldr r2, [r0, #0xadc]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x1c]
	mov r0, r4
	mov r1, r11
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0x6a8]
	ldr r2, [r0, #0x6a4]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x18]
	mov r0, #0x25
	add r1, sp, #0x18
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r9, r9, #1
	add r8, r8, #0xc
	cmp r9, #6
	blt _0215F524
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x90]
	ldrsh r1, [r0, #0x92]
	cmp r2, r1
	bge _0215F690
	ldrh r3, [r0, #0xa2]
	add r1, sp, #0x14
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x14]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1000
	ldr r1, [r0, #0x674]
	ldr r2, [r0, #0x670]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0x10
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x10]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1000
	ldr r1, [r0, #0x5c0]
	ldr r2, [r0, #0x5bc]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0xc
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
_0215F690:
	mov r1, #0
	mov r2, r1
	mov r0, #0x41
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	add r1, sp, #8
	mov r0, #0x12
	str r2, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0xa0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215F6C8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r10, r0
	ldrh r0, [r10, #2]
	mov r11, r1
	str r2, [sp, #4]
	add r0, r0, #0xff
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	mov r4, r3
	movls r5, #0
	bls _0215F728
	ldrh r0, [r10, #0]
	cmp r0, #7
	movhs r5, #0
	bhs _0215F728
	bl HubConfig__GetDockStageConfig
	ldr r0, [r0, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockBackInfo
	ldrh r5, [r0, #0x18]
_0215F728:
	mov r3, #2
	add r1, sp, #0xc
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x18
	bl ViMapIcon__Func_2163EBC
	cmp r4, #0
	beq _0215F784
	mov r2, #0
	mov r1, r5
	mov r3, r2
	add r0, r10, #0xf8
	bl ViDockBack__Func_2164AB4
_0215F784:
	ldrh r0, [r10, #0]
	bl HubConfig__GetDockStageConfig
	ldr r1, [sp, #4]
	ldrsh r7, [r0, #0x40]
	cmp r1, #0
	beq _0215F838
	add r0, r10, #0x1000
	ldr r9, [r0, #0x138]
	cmp r9, #0
	moveq r9, #0
	cmp r9, #0
	beq _0215F838
	mov r0, #0x5000
	umull r3, r2, r7, r0
	mov r1, #0
	mla r2, r7, r1, r2
	mov r1, r7, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r8, r3, lsr #0xc
	cmp r9, #0
	orr r8, r8, r0, lsl #20
	beq _0215F838
	add r4, r10, #0x48
	add r5, r10, #0x130
_0215F7EC:
	add r0, r9, #8
	bl CPPHelpers__Func_2085F9C
	mov r6, r0
	add r0, r9, #8
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r6, #8]
	mov r2, r8
	str r1, [sp]
	ldr r3, [r0, #0]
	add r0, r10, #0xf8
	add r1, r4, #0x1400
	bl ViDockBack__Func_2164BF4
	mov r0, r9
	bl _ZN11CVi3dObject4DrawEv
	add r0, r5, #0x1000
	mov r1, r9
	bl _ZN15CViDockNpcGroup10GetNextNpcEP20CViDockNpcGroupEntry
	movs r9, r0
	bne _0215F7EC
_0215F838:
	cmp r11, #0
	beq _0215F8A4
	add r0, r10, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r4, r0
	add r0, r10, #0xe00
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r4, #8]
	mov r2, #0x5000
	mov r4, #0
	umull r8, r6, r7, r2
	str r1, [sp]
	ldr r3, [r0, #0]
	add r1, r10, #0x48
	mla r6, r7, r4, r6
	mov r5, r7, asr #0x1f
	mla r6, r5, r2, r6
	adds r2, r8, #0x800
	adc r4, r6, #0
	mov r2, r2, lsr #0xc
	add r0, r10, #0xf8
	add r1, r1, #0x1400
	orr r2, r2, r4, lsl #20
	bl ViDockBack__Func_2164BF4
	add r0, r10, #0x1f8
	add r0, r0, #0xc00
	bl _ZN11CVi3dObject4DrawEv
_0215F8A4:
	ldr r0, [sp, #4]
	cmp r0, #0
	cmpne r11, #0
	beq _0215F8CC
	add r0, r10, #0xe00
	bl CPPHelpers__Func_2085F9C
	add r2, r10, #0x130
	mov r1, r0
	add r0, r2, #0x1000
	bl _ZN15CViDockNpcGroup4DrawEP7VecFx32
_0215F8CC:
	mov r2, #1
	add r1, sp, #8
	mov r0, #0x12
	str r2, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215F8E8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	ldreqh r0, [r4, #0]
	cmpeq r0, #6
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x1000
	ldr r1, [r0, #0xb24]
	cmp r1, #0x8c
	bne _0215F920
	mov r0, #7
	bl PlayHubSfx
	b _0215F92C
_0215F920:
	cmp r1, #0
	moveq r1, #0xc8
	streq r1, [r0, #0xb24]
_0215F92C:
	add r0, r4, #0x1000
	ldr r1, [r0, #0xb24]
	sub r1, r1, #1
	str r1, [r0, #0xb24]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163A84
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163C80
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	mov r1, #0x1000
	bl ViDockPlayer__Func_21667D4
	add r0, r4, #0xf8
	bl ViDockBack__Func_21649DC
	mov r0, r4
	mov r1, #1
	mov r2, r1
	mov r3, r1
	bl ViDock__Func_215F6C8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main_215F998(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163C80
	add r0, r4, #0xf8
	bl ViDockBack__Func_21649DC
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, #1
	bl ViDock__Func_215F6C8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main_215F9CC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	bl GetCurrentTaskWork_
	mov r7, r0
	ldrh r0, [r7, #0]
	bl HubConfig__GetDockStageConfig
	mov r4, r0
	mov r0, r7
	bl ViDock__Func_215E830
	ldrh r0, [r7, #0]
	bl HubConfig__GetDockStageConfig
	ldrsh r1, [r0, #0x40]
	add r0, r7, #0x1f8
	add r0, r0, #0xc00
	bl ViDockPlayer__Func_21667D4
	add r0, r7, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r5, r0
	add r0, r7, #0x1f8
	add r0, r0, #0xc00
	bl ViDockPlayer__Func_21667A0
	add r3, sp, #0x20
	mov r1, r0
	str r3, [sp]
	add r0, sp, #0x1c
	str r0, [sp, #4]
	add r3, sp, #0x18
	str r3, [sp, #8]
	mov r2, r5
	add r0, r7, #0xf8
	add r3, sp, #0x24
	bl ViDockBack__Func_2164B58
	add r1, sp, #0x24
	ldmia r1, {r1, r2, r3}
	add r0, r7, #0xf8
	bl ViDockBack__Func_2164BC8
	str r0, [sp, #0x28]
	add r0, r7, #0xe00
	add r1, sp, #0x24
	bl CPPHelpers__VEC_Copy_Alt
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _0215FAAC
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0215FA9C
	add r0, r7, #0x1000
	ldr r0, [r0, #0x46c]
	cmp r0, #0
	movne r0, #0
	strne r0, [sp, #0x20]
_0215FA9C:
	add r0, r7, #0x1000
	mov r1, #1
	str r1, [r0, #0x46c]
	b _0215FAB8
_0215FAAC:
	add r0, r7, #0x1000
	mov r1, #0
	str r1, [r0, #0x46c]
_0215FAB8:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	movne r0, #1
	strne r0, [sp, #0x20]
	add r0, r7, #0xe00
	bl CPPHelpers__Func_2085F9C
	add r1, r7, #0x1f8
	mov r6, r0
	add r0, r1, #0xc00
	bl ViDockPlayer__Func_21667A0
	mov r5, r0
	ldrh r0, [r7, #0]
	bl HubConfig__GetDockStageConfig
	ldrsh r3, [r0, #0x40]
	add r0, r7, #0x130
	mov r1, r5
	str r3, [sp]
	mov r2, r6
	add r0, r0, #0x1000
	add r3, sp, #0x24
	bl _ZN15CViDockNpcGroup12Func_2168608EP7VecFx32S1_S1_l
	cmp r0, #0
	beq _0215FB20
	add r1, sp, #0x24
	add r0, r7, #0xe00
	bl CPPHelpers__VEC_Copy_Alt
_0215FB20:
	add r0, r7, #0xf8
	bl ViDockBack__Func_21649DC
	add r0, r7, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup7AnimateEv
	add r0, r7, #0xe00
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	str r1, [sp, #0x24]
	ldr r1, [r0, #4]
	str r1, [sp, #0x28]
	ldr r0, [r0, #8]
	str r0, [sp, #0x2c]
	ldrh r0, [r7, #0]
	cmp r0, #7
	bhs _0215FB70
	add r0, sp, #0x24
	add r1, r4, #8
	mov r2, r0
	bl VEC_Add
_0215FB70:
	add r1, sp, #0x24
	add r0, r7, #0x18
	bl ViMapIcon__Func_2163A84
	add r0, r7, #0x18
	bl ViMapIcon__Func_2163C80
	mov r0, r7
	bl ViDock__Func_215F8E8
	mov r1, #1
	mov r0, r7
	mov r2, r1
	mov r3, r1
	bl ViDock__Func_215F6C8
	add r0, r7, #0x1000
	mov r1, #0xc
	str r1, [r0, #0x460]
	mov r1, #0
	str r1, [r0, #0x464]
	str r1, [r0, #0x468]
	ldr r1, [sp, #0x20]
	cmp r1, #0
	beq _0215FBDC
	mov r1, #1
	str r1, [r0, #0x460]
	ldrh r1, [r7, #0]
	add sp, sp, #0x30
	str r1, [r0, #0x464]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215FBDC:
	ldr r1, [sp, #0x18]
	cmp r1, #8
	ldrneh r0, [r7, #0]
	cmpne r1, r0
	addne sp, sp, #0x30
	strne r1, [r7, #4]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r9, #0
	mov r8, r9
	add r4, r7, #0x1f8
	add r5, r7, #0x130
	add r11, r7, #0xe00
_0215FC0C:
	add r0, r4, #0xc00
	ldrh r10, [r11, #0x32]
	bl ViDockPlayer__Func_21667A0
	mov r6, r0
	ldrh r0, [r7, #0]
	bl HubConfig__GetDockStageConfig
	add r3, sp, #0x14
	stmia sp, {r3, r8}
	ldrsh r3, [r0, #0x40]
	mov r1, r6
	mov r2, r10
	add r0, r5, #0x1000
	bl _ZN15CViDockNpcGroup12Func_2168674EP7VecFx32llPiP20CViDockNpcGroupEntry
	movs r8, r0
	beq _0215FCF0
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _0215FC64
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	movne r9, #1
_0215FC64:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215FC84
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _0215FC88
_0215FC84:
	mov r0, #0
_0215FC88:
	cmp r0, #0
	beq _0215FCE0
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _0215FCE0
	ldr r0, =touchInput
	ldrh r6, [r0, #0x1c]
	ldrh r10, [r0, #0x1e]
	add r0, r8, #8
	bl CPPHelpers__Func_2085F9C
	add r1, sp, #0x10
	add r2, sp, #0xc
	bl NNS_G3dWorldPosToScrPos
	ldr r3, [sp, #0xc]
	mov r1, r6
	str r3, [sp]
	ldr r3, [sp, #0x10]
	mov r2, r10
	mov r0, r7
	bl ViDock__Func_215EC58
	cmp r0, #0
	movne r9, #1
_0215FCE0:
	cmp r9, #0
	bne _0215FCF0
	cmp r8, #0
	bne _0215FC0C
_0215FCF0:
	cmp r9, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r7, #0x460
	adds r0, r0, #0x1000
	ldrne r1, [r8, #0x304]
	addne r0, r7, #0x1000
	strne r1, [r0, #0x460]
	add r0, r7, #0x64
	adds r0, r0, #0x1400
	ldrne r1, [r8, #0x308]
	addne r0, r7, #0x1000
	strne r1, [r0, #0x464]
	ldr r1, [r8, #0x30c]
	add r0, r7, #0x1000
	add r1, r1, #1
	str r1, [r8, #0x30c]
	str r8, [r0, #0x468]
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main_215FD48(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	ldr r1, [r4, #0x10]
	mov r5, r0
	cmp r1, #0
	beq _0215FD8C
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	mov r1, #0x1000
	bl ViDockPlayer__Func_21667D4
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup7AnimateEv
_0215FD8C:
	add r0, r4, #0xf8
	bl ViDockBack__Func_21649DC
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	str r1, [sp]
	ldr r1, [r0, #4]
	str r1, [sp, #4]
	ldr r0, [r0, #8]
	str r0, [sp, #8]
	ldrh r0, [r4, #0]
	cmp r0, #7
	bhs _0215FDD0
	add r0, sp, #0
	add r1, r5, #8
	mov r2, r0
	bl VEC_Add
_0215FDD0:
	add r1, sp, #0
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163A84
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163C80
	ldr r1, [r4, #0x10]
	mov r0, r4
	mov r2, r1
	mov r3, #1
	bl ViDock__Func_215F6C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main_215FE00(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViDock__Func_215EA8C
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockUnknownConfig
	ldr r1, [r0, #0]
	add r0, r4, #0xf8
	bl ViDockBack__Func_2164918
	ldr r0, =ViDock__Main_215FE34
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main_215FE34(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xf8
	bl ViDockBack__Func_2164954
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, =ViDock__Main_215F998
	bl SetCurrentTaskMainEvent
	mov r0, #1
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Main_215FE68(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r5, r0
	ldrh r0, [r5, #0]
	bl HubConfig__GetDockMapConfig
	mov r4, r0
	add r0, r5, #0x18
	bl ViMapIcon__Func_2163C80
	add r0, r5, #0xf8
	bl ViDockBack__Func_21649DC
	mov r0, r5
	bl ViDock__Func_215EF40
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x10
	add r1, sp, #4
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x15
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	add r0, r5, #0x18
	bl ViMapIcon__Func_2163EBC
	mov r0, r5
	bl ViDock__Func_215F1A8
	ldr r1, [r4, #0xc]
	add r0, r5, #0xf8
	bl ViDockBack__Func_2164A38
	ldr r1, [r4, #8]
	add r0, r5, #0xf8
	bl ViDockBack__Func_2164A8C
	add r1, r5, #0x1500
	ldrh r2, [r4, #0x10]
	ldrh r1, [r1, #0xb8]
	add r0, r5, #0xf8
	mov r3, #0
	bl ViDockBack__Func_2164AB4
	mov r2, #1
	mov r0, #0x12
	add r1, sp, #0
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add r0, r5, #0x1500
	ldrh r1, [r0, #0xb8]
	add r1, r1, #0x100
	strh r1, [r0, #0xb8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Destructor(Task *task)
{
    // TODO: should match when destructors are decompiled for 'CViDockPlayer' 'CViDockNpcGroup', 'CViShadow' && 'CViDockBack'
#ifdef NON_MATCHING
    CViDock *work = TaskGetWork(task, CViDock);

    ViDock__Func_215E6E4(work);

    HubTaskDestroy<CViDock>(task);

    ViDock__TaskSingleton = NULL;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl ViDock__Func_215E6E4
	mov r0, r4
	bl ViDock__Func_215FF6C
	ldr r0, =ViDock__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215FF6C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0215FFB4
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadowD0Ev
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroupD1Ev
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	bl _ZN13CViDockPlayerD0Ev
	add r0, r4, #0xf8
	bl _ZN11CViDockBackD1Ev
	mov r0, r4
	bl _ZdlPv
_0215FFB4:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215FFC0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x32c
	add r0, r0, #0x1800
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r1, r4, #0x1000
	mov r0, #0
	str r0, [r1, #0xb28]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDock__Func_215FFF4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #0]
	ldr r2, [r4, #4]
	strh r2, [r4]
	bl ViDock__Func_215E754
	mov r0, r4
	mov r1, #0
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
	mov r0, r4
	bl ViDock__Func_215EB04
	ldrh r0, [r4, #0]
	bl HubConfig__GetDockStageConfig
	ldrh r1, [r0, #0x34]
	add r0, r4, #0x1400
	strh r1, [r0, #0x5c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}
