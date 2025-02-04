#include <hub/cviDockNpcGroup.hpp>
#include <hub/missionHelpers.h>
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
NOT_DECOMPILED void Vi3dObject__ProcessAnimation(CVi3dObject *work);
NOT_DECOMPILED void Vi3dObject__Draw(CVi3dObject *work);
NOT_DECOMPILED BOOL ViDockNpc__Func_216710C(CViDockNpc *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
NOT_DECOMPILED BOOL ViDockNpc__Func_2167244(CViDockNpc *work, VecFx32 *position, s32 a3, s32 a4, BOOL *flag);
NOT_DECOMPILED BOOL ViDockNpc__Func_216737C(CViDockNpc *work, s32 a2);
NOT_DECOMPILED void CreateViDockNpcTalk(s32 param);

#ifdef __cplusplus
}
#endif

// --------------------
// VARIABLES
// --------------------

static u32 selection;

extern CViDockNpcGroupTalk ViDockNpcGroup__talkAction;
extern DockNpcGroupFunc ViDockNpcGroup__talkActionTable[];

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

CViDockNpc *CViDockNpcGroup::AddNpc()
{
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

    return newNpc;
}

void CViDockNpcGroup::RemoveNpc(CViDockNpc *npc)
{
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
        ViDockNpc__VTableFunc_2166BD8(npc);
        delete npc;
    }

    npcListSize--;
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

void CViDockNpcGroup::Animate()
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
                Vi3dObject__Draw(&viArrow);
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
    s32 talkParam;

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