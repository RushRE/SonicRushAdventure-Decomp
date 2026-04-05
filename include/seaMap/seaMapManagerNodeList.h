#ifndef RUSH_SEAMAPMANAGERNODELIST_H
#define RUSH_SEAMAPMANAGERNODELIST_H

#include <global.h>
#include <seaMap/seaMapCommon.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define SEAMAPMANAGER_NODEGROUP_NODE_COUNT 64

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapManagerNode_
{
    NNSFndLink link;
    TouchPos position;
    fx32 distance;
} SeaMapManagerNode;

typedef struct SeaMapManagerNodeGroup_
{
    NNSFndLink link;
    SeaMapManagerNode nodeList[SEAMAPMANAGER_NODEGROUP_NODE_COUNT];
    u16 nodeCount;
} SeaMapManagerNodeGroup;

typedef struct SeaMapManagerNodeList_
{
    NNSFndList nodes;
    NNSFndList groups;
} SeaMapManagerNodeList;

// --------------------
// FUNCTIONS
// --------------------

void InitSeaMapManagerNodeList(SeaMapManagerNodeList *work);
void ReleaseSeaMapManagerNodeList(SeaMapManagerNodeList *work);
void SeaMapManagerNodeList_CopyList(SeaMapManagerNodeList *list1, SeaMapManagerNodeList *list2);
fx32 SeaMapManagerNodeList_GetNodeDistance(SeaMapManagerNode *node);
SeaMapManagerNodeGroup *SeaMapManagerNodeList_AddNodeGroup(SeaMapManagerNodeList *list);
u32 SeaMapManagerNodeList_RemoveLastNodeGroup(SeaMapManagerNodeList *list);
SeaMapManagerNodeGroup *SeaMapManagerNodeList_GetLastNodeGroup(SeaMapManagerNodeList *list);
u16 SeaMapManagerNodeList_GetGroupAvailableNodeCount(SeaMapManagerNodeList *list);
SeaMapManagerNode *SeaMapManagerNodeList_AddNode(SeaMapManagerNodeList *list);
u32 SeaMapManagerNodeList_RemoveLastNode(SeaMapManagerNodeList *list);
void SeaMapManagerNodeList_RemoveAllNodes(SeaMapManagerNodeList *list);
void SeaMapManagerNodeList_CompressNodeList(SeaMapManagerNodeList *list, u32 count);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SEAMAPMANAGERNODELIST_H