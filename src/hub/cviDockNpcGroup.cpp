#include <hub/cviDockNpcGroup.hpp>
#include <hub/missionConfig.h>
#include <hub/hubConfig.h>
#include <game/math/cppMath.hpp>
#include <game/game/gameState.h>

#include <hub/cvi3dObject.hpp>
#include <hub/cviDockNpc.hpp>
#include <hub/cviDockNpcTalk.hpp>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void *_ZTV15CViDockNpcGroup;

NOT_DECOMPILED void _Znwm(void);
NOT_DECOMPILED void _ZdlPv(void);

NOT_DECOMPILED void _ZN15CViDockNpcGroup12ClearNpcListEv(void);
}

// --------------------
// FUNCTIONS
// --------------------

#ifdef NON_MATCHING
CViDockNpcGroup::CViDockNpcGroup()
#else
// CViDockNpcGroup::CViDockNpcGroup()
NONMATCH_FUNC void _ZN15CViDockNpcGroupC1Ev()
#endif
{
    // will match when CVi3dArrow constructor is decompiled
#ifdef NON_MATCHING
    this->npcListSize  = 0;
    this->npcListStart = NULL;
    this->npcListEnd   = NULL;
#else
    // clang-format off
    stmdb sp!, {r4, lr}
    mov r4, r0
    ldr r1, =_ZTV15CViDockNpcGroup+0x08
    add r0, r4, #0x10
    str r1, [r4]
    bl _ZN10CVi3dArrowC1Ev
    mov r1, #0
    str r1, [r4, #4]
    str r1, [r4, #8]
    mov r0, r4
    str r1, [r4, #0xc]
    ldmia sp!, {r4, pc}
// clang-format on
#endif
}

#ifdef NON_MATCHING
CViDockNpcGroup::~CViDockNpcGroup()
#else
// CViDockNpcGroup::~CViDockNpcGroup()
NONMATCH_FUNC void _ZN15CViDockNpcGroupD0Ev()
#endif
{
    // will match when CVi3dArrow constructor is decompiled
#ifdef NON_MATCHING
    this->ClearNpcList();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV15CViDockNpcGroup+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN15CViDockNpcGroup12ClearNpcListEv
	add r0, r4, #0x10
	bl _ZN10CVi3dArrowD0Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

#ifndef NON_MATCHING
// CViDockNpcGroup::~CViDockNpcGroup()
NONMATCH_FUNC void _ZN15CViDockNpcGroupD1Ev()
{
#ifdef NON_MATCHING
    this->ClearNpcList();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV15CViDockNpcGroup+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN15CViDockNpcGroup12ClearNpcListEv
	add r0, r4, #0x10
	bl _ZN10CVi3dArrowD0Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}
#endif

void CViDockNpcGroup::ClearNpcList()
{
    npcArrow.Release();

    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        RemoveNpc(entry);

        entry = GetFirstNpc();
    }
}

NONMATCH_FUNC CViDockNpcGroupEntry *CViDockNpcGroup::AddNpc()
{
    // will match when CViDockNpc constructor is decompiled
#ifdef NON_MATCHING
    CViDockNpcGroupEntry *newEntry = new CViDockNpcGroupEntry;

    if (npcListStart != NULL)
    {
        newEntry->next = NULL;
        newEntry->prev = npcListEnd;

        npcListEnd->next = newEntry;
    }
    else
    {
        newEntry->next = NULL;
        newEntry->prev = NULL;

        npcListStart = newEntry;
    }

    npcListEnd = newEntry;
    npcListSize++;

    return newEntry;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0x340
	bl _Znwm
	movs r4, r0
	beq _02168488
	bl _ZN10CViDockNpcC1Ev
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

NONMATCH_FUNC void CViDockNpcGroup::RemoveNpc(CViDockNpcGroupEntry *entry)
{
    // will match when CViDockNpc destructor is decompiled
#ifdef NON_MATCHING
    if (entry->prev != NULL)
        entry->prev->next = entry->next;
    else
        npcListStart = entry->next;

    if (entry->next != NULL)
        entry->next->prev = entry->prev;
    else
        npcListEnd = entry->prev;

    delete entry;

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
	bl _ZN10CViDockNpcD0Ev
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

CViDockNpcGroupEntry *CViDockNpcGroup::GetNextNpc(CViDockNpcGroupEntry *npc)
{
    CViDockNpcGroupEntry *next = npc->next;

    if (next == NULL)
        return NULL;

    return next;
}

void CViDockNpcGroup::Init()
{
    npcArrow.Init();
}

void CViDockNpcGroup::Process()
{
    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        entry->npc.Process();

        entry = GetNextNpc(entry);
    }

    npcArrow.Process();
}

void CViDockNpcGroup::Draw(VecFx32 &position)
{
    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        if ((s32)entry->npc.npcType == CVIDOCK_NPC_BASENEXT_HOURGLASS || entry->npc.npcType == CVIDOCK_NPC_BASENEXT_OLDDS)
        {
            if (entry->npc.Allow3dArrow(position))
            {
                npcArrow.position = entry->npc.position.ToConstVecFx32Ref();
                npcArrow.Draw();
            }
        }

        entry = GetNextNpc(entry);
    }
}

CViDockNpcGroupEntry *CViDockNpcGroup::HandlePlayerSolidCollisions(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, fx32 scale)
{
    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        if (entry->npc.HandlePlayerSolidCollisions(prevPlayerPos, curPlayerPos, newPlayerPos, scale))
        {
            return entry;
        }

        entry = GetNextNpc(entry);
    }

    return NULL;
}

CViDockNpcGroupEntry *CViDockNpcGroup::FindNpcInTalkRange(VecFx32 *playerPos, u16 playerAngle, fx32 scale, BOOL *canTalk, CViDockNpcGroupEntry *startNpc)
{
    CViDockNpcGroupEntry *entry;

    if (startNpc != NULL)
    {
        entry = GetNextNpc(startNpc);
    }
    else
    {
        entry = GetFirstNpc();
    }

    while (entry != NULL)
    {
        if (entry->npc.CheckPlayerInTalkRange(playerPos, playerAngle, scale, canTalk))
        {
            return entry;
        }

        entry = GetNextNpc(entry);
    }

    return NULL;
}