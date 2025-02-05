#include <hub/cviDockNpcGroup.hpp>
#include <hub/missionHelpers.h>
#include <game/util/cppHelpers.hpp>
#include <game/game/gameState.h>

#include <hub/cvi3dObject.hpp>
#include <hub/cviDockNpc.hpp>
#include <hub/cviDockNpcTalk.hpp>

// --------------------
// VARIABLES
// --------------------

static u32 selection;

extern CViDockNpcGroupTalk ViDockNpcGroup__talkAction;
extern DockNpcGroupFunc ViDockNpcGroup__talkActionTable[];

extern "C"
{
    NOT_DECOMPILED void _Znwm(void);
    NOT_DECOMPILED void _ZdlPv(void);
    NOT_DECOMPILED void _ZN10CViDockNpcC1Ev(void);
    NOT_DECOMPILED void _ZN10CViDockNpcD1Ev(void);
}

// --------------------
// FUNCTIONS
// --------------------

CViDockNpcGroup::CViDockNpcGroup()
{
    this->npcListSize  = 0;
    this->npcListStart = NULL;
    this->npcListEnd   = NULL;
}

CViDockNpcGroup::~CViDockNpcGroup()
{
    ClearNpcList();
}

void CViDockNpcGroup::ClearNpcList()
{
    viArrow.Func_2168358();

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

NONMATCH_FUNC CViDockNpc *CViDockNpcGroup::AddNpc()
{
#ifdef NON_MATCHING
    CViDockNpc *newNpc = new CViDockNpc;

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

    return newNpc;
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

NONMATCH_FUNC void CViDockNpcGroup::RemoveNpc(CViDockNpc *npc)
{
#ifdef NON_MATCHING
    if (npc->prev != NULL)
        npc->prev->next = npc->next;
    else
        npcListStart = npc->next;

    if (npc->next != NULL)
        npc->next->prev = npc->prev;
    else
        npcListEnd = npc->prev;

    if (npc != NULL)
    {
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
	bl _ZN10CViDockNpcD1Ev
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
    viArrow.LoadAssets();
}

void CViDockNpcGroup::Animate()
{
    CViDockNpc *npc = npcListStart;

    if (npc == NULL)
        npc = NULL;

    while (npc != NULL)
    {
        npc->ProcessAnimation();

        npc = GetNextNpc(npc);
    }

    viArrow.ProcessAnimation();
}

void CViDockNpcGroup::Draw(s32 a2)
{
    CViDockNpc *npc = npcListStart;

    if (npc == NULL)
        npc = NULL;

    while (npc != NULL)
    {
        if ((s32)npc->npcType == 7 || npc->npcType == 8)
        {
            if (ViDockNpc__Func_216737C(npc, a2))
            {
                CPPHelpers__VEC_Copy_Alt(&viArrow.translation1, CPPHelpers__Func_2085F9C(&npc->translation1));
                viArrow.Draw();
            }
        }

        npc = GetNextNpc(npc);
    }
}

CViDockNpc *CViDockNpcGroup::Func_2168608(VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5)
{
    CViDockNpc *npc = npcListStart;

    if (npc == NULL)
        npc = NULL;

    while (npc != NULL)
    {
        if (ViDockNpc__Func_216710C(npc, a2, a3, a4, a5))
        {
            return npc;
        }

        npc = GetNextNpc(npc);
    }

    return NULL;
}

CViDockNpc *CViDockNpcGroup::Func_2168674(VecFx32 *a2, s32 a3, s32 a4, BOOL *a5, CViDockNpc *startNpc)
{
    CViDockNpc *npc;

    if (startNpc != NULL)
    {
        npc = GetNextNpc(startNpc);
    }
    else
    {
        npc = npcListStart;
        if (npc == NULL)
            npc = NULL;
    }

    while (npc != NULL)
    {
        if (ViDockNpc__Func_2167244(npc, a2, a3, a4, a5))
        {
            return npc;
        }

        npc = GetNextNpc(npc);
    }

    return NULL;
}

void CViDockNpcGroup::RunAction(s32 id, s32 param)
{
    ViDockNpcGroup__talkAction.action = 32;

    ViDockNpcGroup__talkActionTable[id](param);
}

u32 CViDockNpcGroup::GetTalkAction(void)
{
    return ViDockNpcGroup__talkAction.action;
}

u32 CViDockNpcGroup::GetSelection(void)
{
    return selection;
}

void CViDockNpcGroup::SetTalkAction(u32 value)
{
    ViDockNpcGroup__talkAction.action = value;
}

void CViDockNpcGroup::SetSelection(s32 value)
{
    selection = value;
}

void CViDockNpcGroup::Func_2168764(s32 param)
{
    u16 talkParam;

    if (gameState.missionFlag == FALSE)
    {
        talkParam = 7;
    }
    else
    {
        talkParam = 6;
        MissionHelpers__Func_2153E4C(MissionHelpers__GetMissionID());
    }

    CreateViDockNpcTalk(talkParam);
}

void CViDockNpcGroup::Func_2168798(s32 param)
{
    // nothing
}

void CViDockNpcGroup::Func_216879C(s32 param)
{
    ViDockNpcGroup__talkAction.action = param;
}