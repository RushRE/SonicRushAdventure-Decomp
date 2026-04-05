#include <seaMap/seaMapManagerNodeList.h>
#include <seaMap/seaMapCollision.h>
#include <game/system/allocator.h>

// --------------------
// CONSTANTS
// --------------------

#define SEAMAPMANAGER_DISTANCE_REFRESH -1

// --------------------
// VARIABLES
// --------------------

// clang-format off
static const u8 sNodeCollisionSplitTable[SEAMAP_COLLISION_COUNT][64] =
{
    [SEAMAP_COLLISION_0] = 
    {
        0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_1] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_2] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 1,
		0, 0, 0, 0, 0, 0, 1, 1,
		0, 0, 0, 0, 0, 1, 1, 1,
		0, 0, 0, 0, 1, 1, 1, 1,
	    0, 0, 0, 1, 1, 1, 1, 1,
		0, 0, 1, 1, 1, 1, 1, 1,
		0, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1,
    },

    [SEAMAP_COLLISION_3] = 
    {
	    1, 0, 0, 0, 0, 0, 0, 0,
		1, 1, 0, 0, 0, 0, 0, 0,
		1, 1, 1, 0, 0, 0, 0, 0,
		1, 1, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 0, 0, 0,
		1, 1, 1, 1, 1, 1, 0, 0,
		1, 1, 1, 1, 1, 1, 1, 0,
		1, 1, 1, 1, 1, 1, 1, 1,
    },

    [SEAMAP_COLLISION_4] = 
    {
	    1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 0,
		1, 1, 1, 1, 1, 1, 0, 0,
		1, 1, 1, 1, 1, 0, 0, 0,
	    1, 1, 1, 1, 0, 0, 0, 0,
		1, 1, 1, 0, 0, 0, 0, 0,
		1, 1, 0, 0, 0, 0, 0, 0,
		1, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_5] = 
    {
	    1, 1, 1, 1, 1, 1, 1, 1,
		0, 1, 1, 1, 1, 1, 1, 1,
		0, 0, 1, 1, 1, 1, 1, 1,
		0, 0, 0, 1, 1, 1, 1, 1,
	    0, 0, 0, 0, 1, 1, 1, 1,
		0, 0, 0, 0, 0, 1, 1, 1,
		0, 0, 0, 0, 0, 0, 1, 1,
		0, 0, 0, 0, 0, 0, 0, 1,
    },

    [SEAMAP_COLLISION_6] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_7] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_8] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_9] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_10] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_11] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_12] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_13] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_14] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    },

    [SEAMAP_COLLISION_15] = 
    {
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0,
    }
};
// clang-format on

// --------------------
// FUNCTION DECLS
// --------------------

static SeaMapManagerNode *SeaMapManagerNodeList_CopyNodesInternal(SeaMapManagerNodeList *list1, SeaMapManagerNodeList *list2, u32 count);
static BOOL SeaMapManagerNodeList_CompareNodePositions(s32 x1, s32 y1, s32 x2, s32 y2);
static void SeaMapManagerNodeList_Compress_CloseNodes(SeaMapManagerNodeList *list, u32 count);
static void SeaMapManagerNodeList_Compress_SimilarNodeAngles(SeaMapManagerNodeList *list, u32 count);
static void SeaMapManagerNodeList_Compress_SmallNodeAngleCurves(SeaMapManagerNodeList *list, u32 count);
static void SeaMapManagerNodeList_CopySingleNode(SeaMapManagerNode *src, SeaMapManagerNode *dst);

// --------------------
// FUNCTIONS
// --------------------

void InitSeaMapManagerNodeList(SeaMapManagerNodeList *work)
{
    NNS_FND_INIT_LIST(&work->nodes, SeaMapManagerNode, link);
    NNS_FND_INIT_LIST(&work->groups, SeaMapManagerNodeGroup, link);
}

void ReleaseSeaMapManagerNodeList(SeaMapManagerNodeList *work)
{
    SeaMapManagerNodeList_RemoveAllNodes(work);
}

void SeaMapManagerNodeList_CopyList(SeaMapManagerNodeList *list1, SeaMapManagerNodeList *list2)
{
    SeaMapManagerNodeList_CopyNodesInternal(list1, list2, list1->nodes.numObjects);
}

fx32 SeaMapManagerNodeList_GetNodeDistance(SeaMapManagerNode *node)
{
    if (node->distance < 0)
    {
        SeaMapManagerNode *prevNode = (SeaMapManagerNode *)node->link.prevObject;
        if (prevNode != NULL)
        {
            fx32 distY = FX32_FROM_WHOLE(node->position.y - prevNode->position.y);
            fx32 distX = FX32_FROM_WHOLE(node->position.x - prevNode->position.x);

            node->distance = FX_Sqrt(MultiplyFX(distX, distX) + MultiplyFX(distY, distY));
        }
        else
        {
            node->distance = FLOAT_TO_FX32(0.0);
        }
    }

    return node->distance;
}

SeaMapManagerNode *SeaMapManagerNodeList_CopyNodesInternal(SeaMapManagerNodeList *list1, SeaMapManagerNodeList *list2, u32 count)
{
    SeaMapManagerNode *srcNode = (SeaMapManagerNode *)list1->nodes.headObject;
    for (u16 i = 0; i < count; i++)
    {
        SeaMapManagerNode *dstNode = SeaMapManagerNodeList_AddNode(list2);
        SeaMapManagerNodeList_CopySingleNode(srcNode, dstNode);

        srcNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list1->nodes, srcNode);
    }

    return srcNode;
}

SeaMapManagerNodeGroup *SeaMapManagerNodeList_AddNodeGroup(SeaMapManagerNodeList *list)
{
    SeaMapManagerNodeGroup *nodeGroup = (SeaMapManagerNodeGroup *)HeapAllocHead(HEAP_SYSTEM, sizeof(SeaMapManagerNodeGroup));
    MI_CpuClear16(nodeGroup, sizeof(SeaMapManagerNodeGroup));

    NNS_FndAppendListObject(&list->groups, nodeGroup);

    return nodeGroup;
}

u32 SeaMapManagerNodeList_RemoveLastNodeGroup(SeaMapManagerNodeList *list)
{
    if (list->groups.numObjects != 0)
    {
        SeaMapManagerNodeGroup *nodeGroup = (SeaMapManagerNodeGroup *)list->groups.tailObject;
        NNS_FndRemoveListObject(&list->groups, nodeGroup);
        HeapFree(HEAP_SYSTEM, nodeGroup);
    }

    return list->groups.numObjects;
}

SeaMapManagerNodeGroup *SeaMapManagerNodeList_GetLastNodeGroup(SeaMapManagerNodeList *list)
{
    return (SeaMapManagerNodeGroup *)list->groups.tailObject;
}

u16 SeaMapManagerNodeList_GetGroupAvailableNodeCount(SeaMapManagerNodeList *list)
{
    SeaMapManagerNodeGroup *nodeGroup = SeaMapManagerNodeList_GetLastNodeGroup(list);
    if (nodeGroup == NULL)
        return 0;

    return SEAMAPMANAGER_NODEGROUP_NODE_COUNT - nodeGroup->nodeCount;
}

SeaMapManagerNode *SeaMapManagerNodeList_AddNode(SeaMapManagerNodeList *list)
{
    SeaMapManagerNodeGroup *nodeGroup;
    if (SeaMapManagerNodeList_GetGroupAvailableNodeCount(list))
        nodeGroup = SeaMapManagerNodeList_GetLastNodeGroup(list);
    else
        nodeGroup = SeaMapManagerNodeList_AddNodeGroup(list);

    SeaMapManagerNode *node = &nodeGroup->nodeList[nodeGroup->nodeCount++];

    node->distance = SEAMAPMANAGER_DISTANCE_REFRESH;

    NNS_FndAppendListObject(&list->nodes, node);

    return node;
}

u32 SeaMapManagerNodeList_RemoveLastNode(SeaMapManagerNodeList *list)
{
    if (list->nodes.numObjects > 0)
    {
        NNS_FndRemoveListObject(&list->nodes, list->nodes.tailObject);

        SeaMapManagerNodeGroup *nodeGroup = SeaMapManagerNodeList_GetLastNodeGroup(list);
        nodeGroup->nodeCount--;
        if (nodeGroup->nodeCount == 0)
            SeaMapManagerNodeList_RemoveLastNodeGroup(list);
    }

    return list->nodes.numObjects;
}

void SeaMapManagerNodeList_RemoveAllNodes(SeaMapManagerNodeList *list)
{
    while (SeaMapManagerNodeList_RemoveLastNode(list) > 0)
    {
        // More nodes to delete...
    }
}

void SeaMapManagerNodeList_CopySingleNode(SeaMapManagerNode *src, SeaMapManagerNode *dst)
{
    dst->position.x = src->position.x;
    dst->position.y = src->position.y;
    dst->distance   = src->distance;
}

void SeaMapManagerNodeList_CompressNodeList(SeaMapManagerNodeList *list, u32 count)
{
    // Compress nodes that are close together
    SeaMapManagerNodeList_Compress_CloseNodes(list, count);

    // Compress nodes that have similar angles between them
    SeaMapManagerNodeList_Compress_SimilarNodeAngles(list, count);

    // Compress center nodes that have a small distance + angle between prev/next
    SeaMapManagerNodeList_Compress_SmallNodeAngleCurves(list, count);
    
    // Compress nodes that have similar angles between them... again!
    SeaMapManagerNodeList_Compress_SimilarNodeAngles(list, count);
}

BOOL SeaMapManagerNodeList_CompareNodePositions(s32 x1, s32 y1, s32 x2, s32 y2)
{
    SeaMapCollisionType col;
    u16 mapY;
    u16 mapX;
    s32 otherY1;
    s32 otherX1;
    s32 otherY2;
    s32 otherX2;

    SeaMapManager__GetPosition2(x1, y1, &otherX1, &otherY1);
    SeaMapManager__GetPosition2(x2, y2, &otherX2, &otherY2);
    if ((otherX1 >> 15) != (otherX2 >> 15) || (otherY1 >> 15) != (otherY2 >> 15))
        return TRUE;

    SeaMapManager__Func_2043B60(otherX1, otherY1, &mapX, &mapY);
    col = SeaMapCollision_GetCollisionAtPoint(mapX >> 3, mapY >> 3);

    s32 finalX1 = otherX1 >> 12;
    s32 finalY1 = otherY1 >> 12;
    s32 finalX2 = otherX2 >> 12;
    s32 finalY2 = otherY2 >> 12;
    return sNodeCollisionSplitTable[col][((finalY1 & 7) << 3) + (finalX1 & 7)]
           != sNodeCollisionSplitTable[col][((finalY2 & 7) << 3) + (finalX2 & 7)];
}

void SeaMapManagerNodeList_Compress_CloseNodes(SeaMapManagerNodeList *list, u32 count)
{
    if ((s32)(list->nodes.numObjects - count) <= 1)
        return;

    SeaMapManagerNode *srcFirstNode;
    SeaMapManagerNode *dstNextNode;
    SeaMapManagerNode *dstPrevNode;
    SeaMapManagerNode *srcNextNode;

    SeaMapManagerNodeList nextNodeList;
    InitSeaMapManagerNodeList(&nextNodeList);
    srcFirstNode = SeaMapManagerNodeList_CopyNodesInternal(list, &nextNodeList, count);

    dstNextNode = SeaMapManagerNodeList_AddNode(&nextNodeList);
    SeaMapManagerNodeList_CopySingleNode(srcFirstNode, dstNextNode);

    srcNextNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcFirstNode);
    while (srcNextNode != NULL)
    {
        dstPrevNode = dstNextNode;
        dstNextNode = SeaMapManagerNodeList_AddNode(&nextNodeList);

        SeaMapManagerNodeList_CopySingleNode(srcNextNode, dstNextNode);

        dstNextNode->distance = SEAMAPMANAGER_DISTANCE_REFRESH;
        SeaMapManagerNodeList_GetNodeDistance(dstNextNode);

        // Check if nodes should be combined into one
        srcNextNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcNextNode);
        if (srcNextNode != NULL && dstNextNode->distance < FLOAT_TO_FX32(3.0)
            && SeaMapManagerNodeList_CompareNodePositions(dstPrevNode->position.x, dstPrevNode->position.y, dstNextNode->position.x, dstNextNode->position.y) == FALSE)
        {
            SeaMapManagerNodeList_RemoveLastNode(&nextNodeList);
        }
    }

    ReleaseSeaMapManagerNodeList(list);
    SeaMapManagerNodeList_CopyList(&nextNodeList, list);
    ReleaseSeaMapManagerNodeList(&nextNodeList);
}

void SeaMapManagerNodeList_Compress_SimilarNodeAngles(SeaMapManagerNodeList *list, u32 count)
{
    if ((s32)(list->nodes.numObjects - count) <= 2)
        return;

    SeaMapManagerNode *dstPrevNode;
    SeaMapManagerNode *dstNextNode;
    u16 angle;
    BOOL mergeNodes;
    u16 prevAngle;
    SeaMapManagerNode *srcPrevNode;
    SeaMapManagerNode *srcNextNode;
    SeaMapManagerNode *srcFirstNode;

    SeaMapManagerNodeList nextNodeList;
    InitSeaMapManagerNodeList(&nextNodeList);
    srcFirstNode = SeaMapManagerNodeList_CopyNodesInternal(list, &nextNodeList, count);

    srcPrevNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcFirstNode);

    angle       = FX_Atan2Idx(FX32_FROM_WHOLE(srcPrevNode->position.y - srcFirstNode->position.y), FX32_FROM_WHOLE(srcPrevNode->position.x - srcFirstNode->position.x));
    dstPrevNode = SeaMapManagerNodeList_AddNode(&nextNodeList);
    SeaMapManagerNodeList_CopySingleNode(srcFirstNode, dstPrevNode);

    dstNextNode = SeaMapManagerNodeList_AddNode(&nextNodeList);
    SeaMapManagerNodeList_CopySingleNode(srcPrevNode, dstNextNode);

    srcNextNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcPrevNode);
    do
    {
        mergeNodes = FALSE;
        prevAngle  = angle;
        angle      = FX_Atan2Idx(FX32_FROM_WHOLE(srcNextNode->position.y - srcPrevNode->position.y), FX32_FROM_WHOLE(srcNextNode->position.x - srcPrevNode->position.x));

        if ((u16)MATH_ABS((s16)(u16)(prevAngle - angle)) < FLOAT_DEG_TO_IDX(4.21875)
            && SeaMapManagerNodeList_CompareNodePositions(srcPrevNode->position.x, srcPrevNode->position.y, srcNextNode->position.x, srcNextNode->position.y) == FALSE)
        {
            mergeNodes = TRUE;
        }

        if (mergeNodes)
        {
            dstNextNode->position.x = srcNextNode->position.x;
            dstNextNode->position.y = srcNextNode->position.y;
            dstNextNode->distance   = SEAMAPMANAGER_DISTANCE_REFRESH;
            SeaMapManagerNodeList_GetNodeDistance(dstNextNode);
            angle = FX_Atan2Idx(FX32_FROM_WHOLE(dstNextNode->position.y - dstPrevNode->position.y), FX32_FROM_WHOLE(dstNextNode->position.x - dstPrevNode->position.x));
        }
        else
        {
            dstPrevNode = dstNextNode;
            dstNextNode = SeaMapManagerNodeList_AddNode(&nextNodeList);
            SeaMapManagerNodeList_CopySingleNode(srcNextNode, dstNextNode);
        }

        srcPrevNode = srcNextNode;
        srcNextNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcNextNode);
    } while (srcNextNode != NULL);

    ReleaseSeaMapManagerNodeList(list);
    SeaMapManagerNodeList_CopyList(&nextNodeList, list);
    ReleaseSeaMapManagerNodeList(&nextNodeList);
}

void SeaMapManagerNodeList_Compress_SmallNodeAngleCurves(SeaMapManagerNodeList *list, u32 count)
{
    if ((s32)(list->nodes.numObjects - count) <= 2)
        return;

    SeaMapManagerNode *srcFirstNode;
    SeaMapManagerNode *dstPrevNode;
    SeaMapManagerNode *srcPrevNode;
    SeaMapManagerNode *dstNextNode;
    SeaMapManagerNode *nextNode;
    SeaMapManagerNode *srcNextNode;

    SeaMapManagerNodeList nextNodeList;
    InitSeaMapManagerNodeList(&nextNodeList);
    srcFirstNode = SeaMapManagerNodeList_CopyNodesInternal(list, &nextNodeList, count);

    dstPrevNode = SeaMapManagerNodeList_AddNode(&nextNodeList);
    SeaMapManagerNodeList_CopySingleNode(srcFirstNode, dstPrevNode);

    srcPrevNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcFirstNode);

    dstNextNode = SeaMapManagerNodeList_AddNode(&nextNodeList);
    SeaMapManagerNodeList_CopySingleNode(srcPrevNode, dstNextNode);

    srcNextNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcPrevNode);
    while (srcNextNode != NULL)
    {
        nextNode = SeaMapManagerNodeList_AddNode(&nextNodeList);

        SeaMapManagerNodeList_CopySingleNode(srcNextNode, nextNode);

        u16 anglePrev = FX_Atan2Idx(FX32_FROM_WHOLE(dstNextNode->position.y - dstPrevNode->position.y), FX32_FROM_WHOLE(dstNextNode->position.x - dstPrevNode->position.x));
        u16 angleNext = FX_Atan2Idx(FX32_FROM_WHOLE(nextNode->position.y - dstNextNode->position.y), FX32_FROM_WHOLE(nextNode->position.x - dstNextNode->position.x));

        if ((u16)MATH_ABS((s16)(u16)(anglePrev - angleNext)) > FLOAT_DEG_TO_IDX(90.0)
            && (dstNextNode->distance < FLOAT_TO_FX32(4.4375) || nextNode->distance < FLOAT_TO_FX32(4.4375)))
        {
            SeaMapManagerNodeList_CopySingleNode(nextNode, dstNextNode);

            dstNextNode->distance = SEAMAPMANAGER_DISTANCE_REFRESH;
            SeaMapManagerNodeList_GetNodeDistance(dstNextNode);

            SeaMapManagerNodeList_RemoveLastNode(&nextNodeList);
        }
        else
        {
            dstPrevNode = dstNextNode;
            dstNextNode = nextNode;
        }

        srcNextNode = (SeaMapManagerNode *)NNS_FndGetNextListObject(&list->nodes, srcNextNode);
    }

    ReleaseSeaMapManagerNodeList(list);
    SeaMapManagerNodeList_CopyList(&nextNodeList, list);
    ReleaseSeaMapManagerNodeList(&nextNodeList);
}
