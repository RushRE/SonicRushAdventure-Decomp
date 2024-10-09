#include <hub/cviDockNpcGroup.hpp>
#include <game/util/cppHelpers.hpp>
#include <game/game/gameState.h>

// --------------------
// TEMP
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void ViDockNpc__Constructor(CViDockNpc *work);
NOT_DECOMPILED void ViDockNpc__VTableFunc_2166BD8(CViDockNpc *work);
NOT_DECOMPILED void Vi3dObject__ProcessAnimation(Vi3dObject *work);
NOT_DECOMPILED void Vi3dObject__Draw(Vi3dObject *work);
NOT_DECOMPILED BOOL ViDockNpc__Func_216710C(CViDockNpc *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
NOT_DECOMPILED BOOL ViDockNpc__Func_2167244(CViDockNpc *work, VecFx32 *position, s32 a3, s32 a4, BOOL *flag);
NOT_DECOMPILED BOOL ViDockNpc__Func_216737C(void);
NOT_DECOMPILED void CreateViDockNpcTalk(s32 param);
NOT_DECOMPILED void MissionHelpers__Func_2153E4C(s32 id);
NOT_DECOMPILED s32 MissionHelpers__GetMissionID(void);

NOT_DECOMPILED void _Znwm(void);
NOT_DECOMPILED void _ZdlPv(void);

// function refs for asm code
NOT_DECOMPILED void _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc(void); // CViDockNpcGroup::GetNextNpc(CViDockNpc *npc)

#ifdef __cplusplus
}
#endif

// --------------------
// TYPES
// --------------------

typedef s32 (*DockNpcGroupFunc)(s32 param);

// --------------------
// STRUCTS
// --------------------

struct CViDockNpcGroupTalk
{
    u32 action;
};

// --------------------
// VARIABLES
// --------------------

static u32 selection;

NOT_DECOMPILED CViDockNpcGroupTalk ViDockNpcGroup__talkAction;
NOT_DECOMPILED DockNpcGroupFunc _02173968[];

// --------------------
// FUNCTIONS
// --------------------

CViDockNpcGroup::CViDockNpcGroup()
{
    Vi3dArrow__Constructor(&this->viArrow);
    this->npcListSize  = 0;
    this->npcListStart = NULL;
    this->npcListEnd   = NULL;
}

CViDockNpcGroup::~CViDockNpcGroup()
{
    ClearNpcList();
    Vi3dArrow__VTableFunc_2168268(&this->viArrow);
}

void CViDockNpcGroup::ClearNpcList()
{
    Vi3dArrow__Func_2168358(&viArrow);

    CViDockNpc *npc = npcListStart;
    if (npc == NULL)
        npc = NULL;

    while (npc != NULL)
    {
        RemoveNpc(npc);

        npc = npcListStart;
        if (npc == NULL)
            npc = NULL;
    }
}

NONMATCH_FUNC void CViDockNpcGroup::AddNpc()
{
#ifdef NON_MATCHING
    CViDockNpc *newNpc = new CViDockNpc;

    if (newNpc != NULL)
        ViDockNpc__Constructor(newNpc);

    if (npcListStart != NULL)
    {
        newNpc->next = NULL;
        newNpc->prev = npcListEnd;

        npcListEnd->next = newNpc;
    }
    else
    {
        newNpc->next = NULL;
        newNpc->prev = NULL;

        npcListStart = newNpc;
    }

    npcListEnd = newNpc;
    npcListSize++;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0x340
	bl _Znwm
	movs r4, r0
	beq _02168488
	bl ViDockNpc__Constructor
_02168488:
	ldr r0, [r5, #8]
	cmp r0, #0
	mov r0, #0
	streq r0, [r4, #0x338]
	streq r0, [r4, #0x33c]
	streq r4, [r5, #8]
	beq _021684B8
	str r0, [r4, #0x338]
	ldr r0, [r5, #0xc]
	str r0, [r4, #0x33c]
	ldr r0, [r5, #0xc]
	str r4, [r0, #0x338]
_021684B8:
	str r4, [r5, #0xc]
	ldr r1, [r5, #4]
	mov r0, r4
	add r1, r1, #1
	str r1, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CViDockNpcGroup::RemoveNpc(CViDockNpc *npc)
{
#ifdef NON_MATCHING
    CViDockNpc *prev1 = npc->prev;
    CViDockNpc *next1 = npc->next;
    if (prev1 != NULL)
        prev1->next = next1;
    else
        npcListStart = next1;

    CViDockNpc *prev2 = npc->next;
    CViDockNpc *next2 = npc->prev;
    if (prev2 != NULL)
        prev2->prev = next2;
    else
        npcListEnd = next2;

    if (npc != NULL)
    {
        ViDockNpc__VTableFunc_2166BD8(npc);
        delete npc;
    }

    npcListSize--;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	ldr r1, [r4, #0x33c]
	mov r5, r0
	ldr r0, [r4, #0x338]
	cmp r1, #0
	strne r0, [r1, #0x338]
	streq r0, [r5, #8]
	ldr r1, [r4, #0x338]
	ldr r0, [r4, #0x33c]
	cmp r1, #0
	strne r0, [r1, #0x33c]
	streq r0, [r5, #0xc]
	cmp r4, #0
	beq _0216851C
	mov r0, r4
	bl ViDockNpc__VTableFunc_2166BD8
	mov r0, r4
	bl _ZdlPv
_0216851C:
	ldr r0, [r5, #4]
	sub r0, r0, #1
	str r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

CViDockNpc *CViDockNpcGroup::GetNextNpc(CViDockNpc *npc)
{
    CViDockNpc *next = npc->next;

    if (next == NULL)
        next = NULL;

    return next;
}

void CViDockNpcGroup::LoadAssets()
{
    Vi3dArrow__LoadAssets(&viArrow);
}

void CViDockNpcGroup::Func_216854C()
{
    CViDockNpc *npc = npcListStart;

    if (npc == NULL)
        npc = NULL;

    while (npc != NULL)
    {
        Vi3dObject__ProcessAnimation(npc);

        npc = GetNextNpc(npc);
    }

    Vi3dObject__ProcessAnimation(&viArrow);
}

NONMATCH_FUNC void CViDockNpcGroup::Func_2168590(s32 a2)
{
#ifdef NON_MATCHING
    CViDockNpc *npc = npcListStart;

    if (npc == NULL)
        npc = NULL;

    while (npc != NULL)
    {
        if (npc->npcType == 7 || npc->npcType == 8)
        {
            if (ViDockNpc__Func_216737C())
            {
                CPPHelpers__VEC_Copy_Alt(&viArrow.translation1, CPPHelpers__Func_2085F9C(&npc->translation1));
                Vi3dObject__Draw(&viArrow);
            }
        }

        npc = GetNextNpc(npc);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #8]
	mov r5, r1
	cmp r4, #0
	moveq r4, #0
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_021685B0:
	ldr r0, [r4, #0x300]
	cmp r0, #7
	cmpne r0, #8
	bne _021685F0
	mov r0, r4
	mov r1, r5
	bl ViDockNpc__Func_216737C
	cmp r0, #0
	beq _021685F0
	add r0, r4, #8
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, r6, #0x18
	bl CPPHelpers__VEC_Copy_Alt
	add r0, r6, #0x10
	bl Vi3dObject__Draw
_021685F0:
	mov r0, r6
	mov r1, r4
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	movs r4, r0
	bne _021685B0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CViDockNpc *CViDockNpcGroup::Func_2168608(VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5)
{
#ifdef NON_MATCHING
    CViDockNpc *npc = npcListStart;

    if (npc == NULL)
        npc = NULL;

    if (npc == NULL)
        return NULL;

    while (!ViDockNpc__Func_216710C(npc, a2, a3, a4, a5))
    {
        npc = GetNextNpc(npc);

        if (npc == NULL)
            return NULL;
    }

    return npc;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r0
	ldr r4, [r9, #8]
	mov r8, r1
	cmp r4, #0
	moveq r4, #0
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	cmp r4, #0
	beq _0216866C
_02168634:
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	str r5, [sp]
	bl ViDockNpc__Func_216710C
	cmp r0, #0
	movne r0, r4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r9
	mov r1, r4
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	movs r4, r0
	bne _02168634
_0216866C:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC CViDockNpc *CViDockNpcGroup::Func_2168674(VecFx32 *a2, s32 a3, s32 a4, BOOL *a5, CViDockNpc *npc)
{
#ifdef NON_MATCHING
    CViDockNpc *nextNpc;

    if (npc != NULL)
    {
        nextNpc = GetNextNpc(npc);
    }
    else
    {
        nextNpc = npcListStart;
        if (nextNpc == NULL)
            nextNpc = NULL;
    }

    if (nextNpc == NULL)
        return NULL;

    while (!ViDockNpc__Func_2167244(nextNpc, a2, a3, a4, a5))
    {
        nextNpc = GetNextNpc(nextNpc);
        if (nextNpc == NULL)
            return NULL;
    }

    return nextNpc;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r1
	ldr r1, [sp, #0x24]
	mov r9, r0
	mov r7, r2
	mov r6, r3
	cmp r1, #0
	ldr r5, [sp, #0x20]
	beq _021686A4
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	mov r4, r0
	b _021686B0
_021686A4:
	ldr r4, [r9, #8]
	cmp r4, #0
	moveq r4, #0
_021686B0:
	cmp r4, #0
	beq _021686F0
_021686B8:
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	str r5, [sp]
	bl ViDockNpc__Func_2167244
	cmp r0, #0
	movne r0, r4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r9
	mov r1, r4
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	movs r4, r0
	bne _021686B8
_021686F0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

s32 CViDockNpcGroup::Func_21686F8(s32 id, s32 param)
{
    ViDockNpcGroup__talkAction.action = 32;

    return _02173968[id](param);
}

u32 CViDockNpcGroup::Func_2168724(void)
{
    return ViDockNpcGroup__talkAction.action;
}

s32 CViDockNpcGroup::Func_2168734(void)
{
    return selection;
}

void CViDockNpcGroup::Func_2168744(u32 value)
{
    ViDockNpcGroup__talkAction.action = value;
}

void CViDockNpcGroup::Func_2168754(s32 value)
{
    selection = value;
}

void CViDockNpcGroup::Func_2168764(void)
{
    s32 param;

    if (gameState.missionFlag == FALSE)
    {
        param = 7;
    }
    else
    {
        param = 6;
        MissionHelpers__Func_2153E4C(MissionHelpers__GetMissionID());
    }

    CreateViDockNpcTalk(param);
}

void CViDockNpcGroup::Func_2168798(void)
{
    // nothing
}

void CViDockNpcGroup::Func_216879C(u32 value)
{
    ViDockNpcGroup__talkAction.action = value;
}