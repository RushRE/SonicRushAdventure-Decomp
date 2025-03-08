#include <seaMap/seaMapVoyagePathConfig.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapCollision.h>
#include <seaMap/seaMapView.h>
#include <seaMap/seaMapEventManager.h>
#include <seaMap/seaMapCourseChangeView.h>

// --------------------
// MACROS
// --------------------

#define SEAMAPVOYAGEPATHCONFIG_OBJECT_LIST_SIZE 256

// --------------------
// VARIABLES
// --------------------

static BOOL initialized;
static NNSFndList pathNodeList;

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapVoyagePathConfig_AddRootNode(void);
static BOOL SeaMapVoyagePathConfig_AddNodesAtDistance(fx32 curDistance, fx32 prevDistance);
static BOOL SeaMapVoyagePathConfig_AddNodesAlongPath(fx32 curDistance, fx32 curX, fx32 curY, fx32 prevDistance, fx32 prevX, fx32 prevY);
static BOOL SeaMapVoyagePathConfig_AddMapObjectNodesAtEnd(fx32 distance, fx32 x, fx32 y);
static BOOL SeaMapVoyagePathConfig_AddMapObjectNodesAtPos(fx32 distance, fx32 x, fx32 y);
static BOOL SeaMapVoyagePathConfig_AddAttrNode(fx32 distance, fx32 x, fx32 y);
static BOOL SeaMapVoyagePathConfig_AddLVNode(fx32 distance, fx32 x, fx32 y);
static void SeaMapVoyagePathConfig_InitList(void);
static SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_AddNode(SeaMapVoyagePathConfigNode *node);
static void SeaMapVoyagePathConfig_RemoveAllNodes(void);
static SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_FindNodeFromType(u32 type);
static SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_FindNodeFromMapObject(u32 type, CHEVObject *work);
static u8 SeaMapVoyagePathConfig_GetAttribute(fx32 x, fx32 y);
static u8 SeaMapVoyagePathConfig_GetLV(fx32 x, fx32 y);

// --------------------
// FUNCTIONS
// --------------------

BOOL InitSeaMapVoyagePathConfig(void)
{
    if (initialized == FALSE)
    {
        SeaMapVoyagePathConfig_InitList();
        initialized = TRUE;
    }

    ReleaseSeaMapVoyagePathConfig();

    fx32 distance = 0;

    SeaMapVoyagePathConfig_AddRootNode();

    fx32 prevDistance;
    do
    {
        prevDistance = distance;
        distance += FLOAT_TO_FX32(4.0);
    } while (SeaMapVoyagePathConfig_AddNodesAtDistance(distance, prevDistance));
}

void ReleaseSeaMapVoyagePathConfig(void)
{
    SeaMapVoyagePathConfig_RemoveAllNodes();
}

s32 SeaMapVoyagePathConfig_GetNodeCount(void)
{
    return pathNodeList.numObjects;
}

SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_GetNode(u16 id)
{
    NNSFndList *list = &pathNodeList;

    SeaMapVoyagePathConfigNodeLink *next = NULL;

    SeaMapVoyagePathConfigNodeLink *node;
    do
    {
        node = NNS_FndGetNextListObject(list, next);
        next = node;
    } while (id-- != 0);

    return node;
}

void SeaMapVoyagePathConfig_AddRootNode(void)
{
    fx32 y, x;
    SeaMapManager__Func_2045BF8(FLOAT_TO_FX32(0.0), &x, &y);

    SeaMapVoyagePathConfigNode node;
    MI_CpuClear16(&node, sizeof(node));
    node.distance    = FLOAT_TO_FX32(0.0);
    node.type        = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_0;
    node.type0.value = 0;
    SeaMapVoyagePathConfig_AddNode(&node);
    SeaMapVoyagePathConfig_AddAttrNode(FLOAT_TO_FX32(0.0), x, y);
    SeaMapVoyagePathConfig_AddLVNode(FLOAT_TO_FX32(0.0), x, y);
}

BOOL SeaMapVoyagePathConfig_AddNodesAtDistance(fx32 curDistance, fx32 prevDistance)
{
    fx32 curY, curX;
    fx32 prevY, prevX;

    SeaMapManager__Func_2045BF8(curDistance, &curX, &curY);
    SeaMapManager__Func_2045BF8(prevDistance, &prevX, &prevY);
    if (SeaMapVoyagePathConfig_AddNodesAlongPath(curDistance, curX, curY, prevDistance, prevX, prevY))
        return FALSE;

    SeaMapVoyagePathConfig_AddAttrNode(curDistance, curX, curY);
    SeaMapVoyagePathConfig_AddLVNode(curDistance, curX, curY);
    return SeaMapVoyagePathConfig_AddMapObjectNodesAtPos(curDistance, curX, curY) == FALSE;
}

BOOL SeaMapVoyagePathConfig_AddNodesAlongPath(fx32 curDistance, fx32 curX, fx32 curY, fx32 prevDistance, fx32 prevX, fx32 prevY)
{
    SeaMapVoyagePathConfigNode node;

    fx32 totalDistance = SeaMapManager__GetTotalDistance();
    if (curDistance >= totalDistance)
    {
        if (SeaMapVoyagePathConfig_AddMapObjectNodesAtEnd(curDistance, curX, curY))
            return TRUE;

        MI_CpuClear16(&node, sizeof(node));
        node.distance   = totalDistance;
        node.type       = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1;
        node.type1.type = SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_END;
        SeaMapVoyagePathConfig_AddNode(&node);
        return TRUE;
    }
    else
    {
        fx16 outY, outX;
        fx16 inY, inX;
        u16 y, x;
        SeaMapManager__Func_2043B60(curX, curY, &outX, &outY);
        SeaMapManager__Func_2043B60(prevX, prevY, &inX, &inY);

        if (SeaMapCollision__HandleCollisions(outX, outY, inX, inY, FALSE, &x, &y))
        {
            MI_CpuClear16(&node, sizeof(node));
            node.distance   = prevDistance;
            node.type       = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1;
            node.type1.type = SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_COLLISION;
            SeaMapVoyagePathConfig_AddNode(&node);
            return TRUE;
        }
    }

    return FALSE;
}

BOOL SeaMapVoyagePathConfig_AddMapObjectNodesAtEnd(fx32 distance, fx32 x, fx32 y)
{
    SeaMapVoyagePathConfigNode node;

    CHEV *objectLayout = SeaMapManager__GetWork()->assets.objectLayout;

    for (u16 i = 0; i < objectLayout->count; i++)
    {
        CHEVObject *mapObject           = &objectLayout->entries[i];
        u32 mapObjectType               = SeaMapEventManager__GetObjectType(mapObject);
        CHEVObjectType *mapObjectConfig = &SeaMapEventManager__ObjectList[mapObjectType];

        if (mapObjectConfig->viewCheck != NULL)
        {
            if (mapObjectType == SEAMAPOBJECT_ISLAND_ICON_1 || mapObjectType == SEAMAPOBJECT_ISLAND_ICON_2)
            {
                if ((mapObject->flags2 & 1) != 0)
                {
                    if (SeaMapManager__GetSaveFlag(mapObject->unlockID) && mapObjectConfig->viewCheck(mapObject, x, y, TRUE))
                    {
                        MI_CpuClear16(&node, sizeof(node));
                        node.distance       = distance;
                        node.type           = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1;
                        node.type1.type     = SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_GOAL;
                        node.type1.unlockID = SeaMapEventManager__Func_2046CE8(mapObject->unlockID);
                        SeaMapVoyagePathConfig_AddNode(&node);
                        return TRUE;
                    }
                }
                else
                {
                    BOOL canAdd = FALSE;

                    switch (mapObject->unlockID)
                    {
                        case 3:
                            if (mapObjectConfig->viewCheck(mapObject, x, y, TRUE))
                            {
                                MI_CpuClear16(&node, sizeof(node));
                                node.type1.unlockID = 1;
                                canAdd              = TRUE;
                            }
                            break;

                        case 14:
                            if (mapObjectConfig->viewCheck(mapObject, x, y, TRUE))
                            {
                                MI_CpuClear16(&node, sizeof(node));
                                node.type1.unlockID = 3;
                                canAdd              = TRUE;
                            }
                            break;

                        case 40:
                            if (mapObjectConfig->viewCheck(mapObject, x, y, TRUE))
                            {
                                MI_CpuClear16(&node, sizeof(node));
                                node.type1.unlockID = 8;
                                canAdd              = TRUE;
                            }
                            break;
                    }

                    if (canAdd)
                    {
                        node.distance   = distance;
                        node.type       = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1;
                        node.type1.type = SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_GOAL;
                        SeaMapVoyagePathConfig_AddNode(&node);
                        return TRUE;
                    }
                }
            }
        }
    }

    return FALSE;
}

BOOL SeaMapVoyagePathConfig_AddMapObjectNodesAtPos(fx32 distance, fx32 x, fx32 y)
{
    SeaMapVoyagePathConfigNode node;

    CHEV *objectLayout = SeaMapManager__GetWork()->assets.objectLayout;

    for (u16 i = 0; i < objectLayout->count; i++)
    {
        CHEVObject *mapObject           = &objectLayout->entries[i];
        u32 mapObjectType               = SeaMapEventManager__GetObjectType(mapObject);
        CHEVObjectType *mapObjectConfig = &SeaMapEventManager__ObjectList[mapObjectType];

        if (mapObjectConfig->viewCheck != NULL)
        {
            if (mapObjectType == SEAMAPOBJECT_ISLAND_ICON_1 || mapObjectType == SEAMAPOBJECT_ISLAND_ICON_2)
            {
                if ((mapObject->flags2 & 1) != 0)
                {
                    if (mapObjectConfig->viewCheck(mapObject, x, y, FALSE))
                    {
                        MI_CpuClear16(&node, sizeof(node));
                        node.distance       = distance;
                        node.type           = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1;
                        node.type1.type     = SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_GOAL;
                        node.type1.unlockID = SeaMapEventManager__Func_2046CE8(mapObject->unlockID);
                        SeaMapVoyagePathConfig_AddNode(&node);
                        return TRUE;
                    }
                }
            }
            else
            {
                s32 type;
                switch (mapObjectType)
                {
                    case SEAMAPOBJECT_UNKNOWN:
                        type = SEAMAPVOYAGEPATHCONFIGNODE_TYPE4TYPE_UNKNOWN;
                        break;

                    case SEAMAPOBJECT_JOHNNY_ICON:
                        type = SEAMAPVOYAGEPATHCONFIGNODE_TYPE4TYPE_RIVAL_RACE;
                        break;
                }

                if (SeaMapVoyagePathConfig_FindNodeFromMapObject(type, mapObject) == NULL && mapObjectConfig->viewCheck(mapObject, x, y, FALSE))
                {
                    MI_CpuClear16(&node, sizeof(node));
                    node.type          = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_4;
                    node.type4.chevRef = mapObject;
                    node.distance      = distance;
                    node.type4.type    = type;
                    SeaMapVoyagePathConfig_AddNode(&node);
                }
            }
        }
    }

    return FALSE;
}

BOOL SeaMapVoyagePathConfig_AddAttrNode(fx32 distance, fx32 x, fx32 y)
{
    u8 attribute = SeaMapVoyagePathConfig_GetAttribute(x, y);

    SeaMapVoyagePathConfigNodeLink *foundObject = SeaMapVoyagePathConfig_FindNodeFromType(SEAMAPVOYAGEPATHCONFIGNODE_TYPE_2);
    if (foundObject == NULL || foundObject->node.type2.attribute != attribute)
    {
        SeaMapVoyagePathConfigNode node;
        MI_CpuClear16(&node, sizeof(node));
        node.distance        = distance;
        node.type            = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_2;
        node.type2.attribute = attribute;
        SeaMapVoyagePathConfig_AddNode(&node);

        return TRUE;
    }

    return FALSE;
}

BOOL SeaMapVoyagePathConfig_AddLVNode(fx32 distance, fx32 x, fx32 y)
{
    u8 lv = SeaMapVoyagePathConfig_GetLV(x, y);

    SeaMapVoyagePathConfigNodeLink *foundObject = SeaMapVoyagePathConfig_FindNodeFromType(SEAMAPVOYAGEPATHCONFIGNODE_TYPE_3);
    if (foundObject == NULL || foundObject->node.type3.lv != lv)
    {
        SeaMapVoyagePathConfigNode node;
        MI_CpuClear16(&node, sizeof(node));
        node.distance = distance;
        node.type     = SEAMAPVOYAGEPATHCONFIGNODE_TYPE_3;
        node.type3.lv = lv;
        SeaMapVoyagePathConfig_AddNode(&node);

        return TRUE;
    }

    return FALSE;
}

void SeaMapVoyagePathConfig_InitList(void)
{
    NNS_FND_INIT_LIST(&pathNodeList, SeaMapVoyagePathConfigNodeLink, link);
}

SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_AddNode(SeaMapVoyagePathConfigNode *node)
{
    NNSFndList *list = &pathNodeList;

    SeaMapVoyagePathConfigNodeLink *link;
    if (pathNodeList.numObjects < SEAMAPVOYAGEPATHCONFIG_OBJECT_LIST_SIZE)
    {
        link = HeapAllocTail(HEAP_SYSTEM, sizeof(*link));
        NNS_FndAppendListObject(list, link);
    }
    else
    {
        link = list->tailObject;
    }

    MI_CpuCopy16(node, &link->node, sizeof(link->node));

    return link;
}

void SeaMapVoyagePathConfig_RemoveAllNodes(void)
{
    NNSFndList *list = &pathNodeList;

    SeaMapVoyagePathConfigNodeLink *link = pathNodeList.headObject;
    while (link != NULL)
    {
        NNS_FndRemoveListObject(list, link);
        HeapFree(HEAP_SYSTEM, link);

        link = list->headObject;
    }
}

SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_FindNodeFromType(u32 type)
{
    NNSFndList *list = &pathNodeList;

    SeaMapVoyagePathConfigNodeLink *link = pathNodeList.tailObject;

    while (link != NULL)
    {
        if (type == link->node.type)
            break;

        link = NNS_FndGetPrevListObject(list, link);
    }

    return link;
}

SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_FindNodeFromMapObject(u32 type, CHEVObject *work)
{
    NNSFndList *list = &pathNodeList;

    SeaMapVoyagePathConfigNodeLink *link = pathNodeList.tailObject;

    while (link != NULL)
    {
        if (link->node.type == SEAMAPVOYAGEPATHCONFIGNODE_TYPE_4 && link->node.type4.type == type && link->node.type4.chevRef == work)
            break;

        link = NNS_FndGetPrevListObject(list, link);
    }

    return link;
}

u8 SeaMapVoyagePathConfig_GetAttribute(fx32 x, fx32 y)
{
    struct CHAttributes *chat = SeaMapManager__GetWork()->assets.chat;

    s32 sx = FX32_TO_WHOLE(x);
    s32 sy = FX32_TO_WHOLE(y);

    u16 px = sx >> 3;
    u16 py = sy >> 3;

    struct CHAttributeValue *value = &chat->data[py * (chat->header.width >> 1) + (px >> 1)];
    if ((px & 1) != 0)
        return value->value2;
    else
        return value->value1;
}

u8 SeaMapVoyagePathConfig_GetLV(fx32 x, fx32 y)
{
    struct CHLV *chlv = SeaMapManager__GetWork()->assets.chlv;

    s32 sx = FX32_TO_WHOLE(x);
    s32 sy = FX32_TO_WHOLE(y);

    u16 px = sx >> 3;
    u16 py = sy >> 3;

    struct CHLVValue *value = &chlv->data[py * (chlv->header.width >> 2) + (px >> 2)];

    switch (px & 3)
    {
        case 0:
            return value->value1;

        case 1:
            return value->value2;

        case 2:
            return value->value3;

        case 3:
            return value->value4;
    }

    return 0;
}

void SeaMapVoyagePathConfig_StoreShipState(fx32 x, fx32 y, fx32 distance)
{
    SeaMapCourseChangeView_shipPosition.x = x;
    SeaMapCourseChangeView_shipPosition.y = y;

    fx32 prevDistance               = seaMapViewUnknown2;
    seaMapViewUnknown2              = distance;
    SeaMapCourseChangeView_02134174 = prevDistance;
}