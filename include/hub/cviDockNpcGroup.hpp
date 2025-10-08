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
#ifdef NON_MATCHING
public:
    CViDockNpcGroup();
    virtual ~CViDockNpcGroup();
#else
    void *vTable; // TODO: remove this when constructor/destructors are decompiled properly
public:
#endif

    // --------------------
    // VARIABLES
    // --------------------

    u32 npcListSize;
    CViDockNpcGroupEntry *npcListStart;
    CViDockNpcGroupEntry *npcListEnd;
    CVi3dArrow npcArrow;

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
    void Draw(VecFx32 &position);
    CViDockNpcGroupEntry *HandlePlayerSolidCollisions(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, fx32 scale);
    CViDockNpcGroupEntry *FindNpcInTalkRange(VecFx32 *playerPos, u16 playerAngle, fx32 scale, BOOL *canTalk, CViDockNpcGroupEntry *startNpc);
};


#ifndef NON_MATCHING

extern "C"
{

void _ZN15CViDockNpcGroupC1Ev();
void _ZN15CViDockNpcGroupD0Ev();
void _ZN15CViDockNpcGroupD1Ev();

}

#endif

#endif // RUSH_CVIDOCKNPCGROUP_HPP
