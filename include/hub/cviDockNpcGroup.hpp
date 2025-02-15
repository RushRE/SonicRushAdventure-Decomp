#ifndef RUSH_CVIDOCKNPCGROUP_HPP
#define RUSH_CVIDOCKNPCGROUP_HPP

#include <hub/cvi3dObject.hpp>
#include <hub/cviDockNpc.hpp>

// --------------------
// TYPES
// --------------------

typedef void (*DockNpcGroupFunc)(s32 param);

// --------------------
// STRUCTS
// --------------------

struct CViDockNpcGroupTalk
{
    u32 action;
};

struct CViDockNpcGroupEntry
{
    CViDockNpc npc;
    CViDockNpcGroupEntry *next;
    CViDockNpcGroupEntry *prev;
};

class CViDockNpcGroup
{
public:
    CViDockNpcGroup();
    virtual ~CViDockNpcGroup();

    // --------------------
    // VARIABLES
    // --------------------

    u32 npcListSize;
    CViDockNpcGroupEntry *npcListStart;
    CViDockNpcGroupEntry *npcListEnd;
    CVi3dArrow viArrow;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void ClearNpcList();
    CViDockNpcGroupEntry *AddNpc();
    void RemoveNpc(CViDockNpcGroupEntry *npc);

    inline CViDockNpcGroupEntry *GetFirstNpc()
    {
        CViDockNpcGroupEntry *start = npcListStart;

        if (start == NULL)
            return NULL;

        return start;
    }

    CViDockNpcGroupEntry *GetNextNpc(CViDockNpcGroupEntry *npc);

    void Init();
    void Process();
    void Draw(VecFx32 *position);
    CViDockNpcGroupEntry *HandlePlayerSolidCollisions(VecFx32 *prevPlayerPos, VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, fx32 scale);
    CViDockNpcGroupEntry *FindNpcInTalkRange(VecFx32 *playerPos, u16 playerAngle, fx32 scale, BOOL *canTalk, CViDockNpcGroupEntry *startNpc);
};

#endif // RUSH_CVIDOCKNPCGROUP_HPP
