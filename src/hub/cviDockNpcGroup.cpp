#include <hub/cviDockNpcGroup.hpp>
#include <hub/missionConfig.h>
#include <hub/hubConfig.h>
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
    viArrow.Release();

    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        RemoveNpc(entry);

        entry = GetFirstNpc();
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

    if (next == NULL)
        return NULL;

    return next;
}

void CViDockNpcGroup::Init()
{
    viArrow.Init();
}

void CViDockNpcGroup::Process()
{
    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        entry->npc.Process();

        entry = GetNextNpc(entry);
    }

    viArrow.Process();
}

void CViDockNpcGroup::Draw(VecFx32 *position)
{
    CViDockNpcGroupEntry *entry = GetFirstNpc();

    while (entry != NULL)
    {
        if ((s32)entry->npc.npcType == CVIDOCK_NPC_BASENEXT_HOURGLASS || entry->npc.npcType == CVIDOCK_NPC_BASENEXT_OLDDS)
        {
            if (entry->npc.Allow3dArrow(position))
            {
                CPPHelpers__VEC_Copy_Alt(&viArrow.position, CPPHelpers__Func_2085F9C(&entry->npc.position));
                viArrow.Draw();
            }
        }

        entry = GetNextNpc(entry);
    }
}

CViDockNpcGroupEntry *CViDockNpcGroup::HandlePlayerSolidCollisions(VecFx32 *prevPlayerPos, VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, fx32 scale)
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