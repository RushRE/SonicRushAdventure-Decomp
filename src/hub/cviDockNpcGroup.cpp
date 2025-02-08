#include <hub/cviDockNpcGroup.hpp>
#include <hub/missionHelpers.h>
#include <game/util/cppHelpers.hpp>
#include <game/game/gameState.h>

#include <hub/cvi3dObject.hpp>
#include <hub/cviDockNpc.hpp>
#include <hub/cviDockNpcTalk.hpp>

// --------------------
// FUNCTIONS
// --------------------

CViDockNpcGroup::CViDockNpcGroup()
{
    // TODO: remove this, it will be called implicitly by the compiler when CVi3dArrow::CVi3dArrow is decompiled
    _ZN10CVi3dArrowC1Ev(&this->viArrow);

    this->npcListSize  = 0;
    this->npcListStart = NULL;
    this->npcListEnd   = NULL;
}

CViDockNpcGroup::~CViDockNpcGroup()
{
    ClearNpcList();

    // TODO: remove this, it will be called implicitly by the compiler when CVi3dArrow::~CVi3dArrow is decompiled
    _ZN10CVi3dArrowD0Ev(&this->viArrow);
}

void CViDockNpcGroup::ClearNpcList()
{
    viArrow.Func_2168358();

    CViDockNpcGroupEntry *entry = npcListStart;
    if (entry == NULL)
        entry = NULL;

    while (entry != NULL)
    {
        RemoveNpc(entry);

        entry = npcListStart;
        if (entry == NULL)
            entry = NULL;
    }
}

CViDockNpcGroupEntry *CViDockNpcGroup::AddNpc()
{
    CViDockNpcGroupEntry *newEntry = new CViDockNpcGroupEntry;

    // TODO: remove this when it's properly decompiled
    if (newEntry != NULL)
    {
        _ZN10CViDockNpcC1Ev(&newEntry->npc);
    }

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
}

void CViDockNpcGroup::RemoveNpc(CViDockNpcGroupEntry *entry)
{
    if (entry->prev != NULL)
        entry->prev->next = entry->next;
    else
        npcListStart = entry->next;

    if (entry->next != NULL)
        entry->next->prev = entry->prev;
    else
        npcListEnd = entry->prev;

    if (entry != NULL)
    {
        // TODO: remove this when it's properly decompiled
        _ZN10CViDockNpcD0Ev(&entry->npc);

        delete entry;
    }

    npcListSize--;
}

CViDockNpcGroupEntry *CViDockNpcGroup::GetNextNpc(CViDockNpcGroupEntry *npc)
{
    CViDockNpcGroupEntry *next = npc->next;

    // ???
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
    CViDockNpcGroupEntry *entry = npcListStart;

    if (entry == NULL)
        entry = NULL;

    while (entry != NULL)
    {
        entry->npc.ProcessAnimation();

        entry = GetNextNpc(entry);
    }

    viArrow.ProcessAnimation();
}

void CViDockNpcGroup::Draw(VecFx32 *position)
{
    CViDockNpcGroupEntry *entry = npcListStart;

    if (entry == NULL)
        entry = NULL;

    while (entry != NULL)
    {
        if ((s32)entry->npc.npcType == 7 || entry->npc.npcType == 8)
        {
            if (ViDockNpc__Func_216737C(&entry->npc, position))
            {
                CPPHelpers__VEC_Copy_Alt(&viArrow.translation1, CPPHelpers__Func_2085F9C(&entry->npc.translation1));
                viArrow.Draw();
            }
        }

        entry = GetNextNpc(entry);
    }
}

CViDockNpcGroupEntry *CViDockNpcGroup::Func_2168608(VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5)
{
    CViDockNpcGroupEntry *entry = npcListStart;

    if (entry == NULL)
        entry = NULL;

    while (entry != NULL)
    {
        if (ViDockNpc__Func_216710C(&entry->npc, a2, a3, a4, a5))
        {
            return entry;
        }

        entry = GetNextNpc(entry);
    }

    return NULL;
}

CViDockNpcGroupEntry *CViDockNpcGroup::Func_2168674(VecFx32 *a2, s32 a3, s32 a4, BOOL *a5, CViDockNpcGroupEntry *startNpc)
{
    CViDockNpcGroupEntry *entry;

    if (startNpc != NULL)
    {
        entry = GetNextNpc(startNpc);
    }
    else
    {
        entry = npcListStart;
        if (entry == NULL)
            entry = NULL;
    }

    while (entry != NULL)
    {
        if (ViDockNpc__Func_2167244(&entry->npc, a2, a3, a4, a5))
        {
            return entry;
        }

        entry = GetNextNpc(entry);
    }

    return NULL;
}