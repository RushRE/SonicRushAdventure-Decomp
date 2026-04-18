#include <seaMap/objects/seaMapIslandIcon.h>
#include <seaMap/objects/seaMapIslandDrawIcon.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapView.h>
#include <seaMap/sailSeaMapView.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// VARIABLES
// --------------------

extern const SaveProgress sIslandProgressUnlockList[];

// --------------------
// FUNCTION DECLS
// --------------------

void SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Elipse(Vec2Fx16 *pos, HitboxRect *rect);
void SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Rect(Vec2Fx16 *pos, HitboxRect *rect);
void CreateSparklesForSeaMapIslandIcon(SeaMapLayoutObject *mapObject);

static void SeaMapIslandIcon_EventCallback(SeaMapEventTriggerType type, void *work, void *eventData, void *param);
static void SeaMapIslandIcon_Main_Sailing(void);
static void SeaMapIslandIcon_Main_ChartCourse(void);
static void SeaMapIslandIcon_Destructor(Task *task);
static BOOL IsSeaMapIslandIconVisibleOnVoyage(SeaMapLayoutObject *mapObject);

// --------------------
// FUNCTIONS
// --------------------

void SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Elipse(Vec2Fx16 *pos, HitboxRect *rect)
{
    u16 bottom;
    u16 right;
    u16 top;
    u16 left;

    left   = (rect->left + pos->x + 4) & ~7;
    top    = (rect->top + pos->y + 4) & ~7;
    right  = (rect->right + pos->x + 4) & ~7;
    bottom = (rect->bottom + pos->y + 4) & ~7;

    SeaMapManager__Func_2043BEC(left, top, &left, &top);
    SeaMapManager__Func_2043BEC(right, bottom, &right, &bottom);
    SeaMapManager__DiscoverMap_Elipse((left + right) >> 1, (top + bottom) >> 1, (right - left + 1) >> 1, (bottom - top + 1) >> 1);

    SeaMapManager__EnableDrawFlags(SEAMAPMANAGER_DRAWFLAG_MAPMASK);
}

void SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Rect(Vec2Fx16 *pos, HitboxRect *rect)
{
    u16 bottom;
    u16 right;
    u16 top;
    u16 left;

    left   = (rect->left + pos->x + 4) & ~7;
    top    = (rect->top + pos->y + 4) & ~7;
    right  = (rect->right + pos->x + 4) & ~7;
    bottom = (rect->bottom + pos->y + 4) & ~7;

    SeaMapManager__Func_2043BEC(left, top, &left, &top);
    SeaMapManager__Func_2043BEC(right, bottom, &right, &bottom);
    SeaMapManager__DiscoverMap_Rect(left, top, right, bottom);

    SeaMapManager__EnableDrawFlags(SEAMAPMANAGER_DRAWFLAG_MAPMASK);
}

void CreateSparklesForSeaMapIslandIcon(SeaMapLayoutObject *mapObject)
{
    s32 type;
    if (mapObject->id >= SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM && mapObject->id <= SEAMAPMANAGER_DISCOVER_DEEP_CORE)
        type = SEAMAPOBJECT_SPARKLES_MAJOR_ISLAND;
    else
        type = SEAMAPOBJECT_SPARKLES_MINOR_ISLAND;

    SeaMapEventManager_CreateObject(type, mapObject->position.x, mapObject->position.y, 0, NULL, 0);
}

SeaMapObject *CreateSeaMapIslandIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    SeaMapObject tempObject;
    MI_CpuClear16(&tempObject, sizeof(tempObject));
    InitSeaMapEventManagerObject(&tempObject, NULL, objectType, mapObject);

    if ((mapObject->usrFlags & SEAMAPISLANDICON_FLAG_DISCOVERABLE_VIA_VOYAGE) == 0)
    {
        if (IsSeaMapIslandIconVisibleOnVoyage(mapObject))
            SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_CHART_MAP, mapObject, NULL);

        if (SeaMapEventManager_CheckIslandDiscovered(mapObject->id) == FALSE)
            return NULL;

        if (mapObject->type == SEAMAPOBJECT_ISLAND_ICON_ELIPSE)
            SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Elipse(&mapObject->position, &mapObject->box);
        else
            SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Rect(&mapObject->position, &mapObject->box);

        SeaMapEventManager_SetObjectAsActive(&tempObject);
        return NULL;
    }
    else if (SeaMapManager__GetSaveFlag(mapObject->id) == FALSE)
    {
        Task *task;
        switch (GetSeaMapViewType())
        {
            case SEAMAPVIEW_TYPE_SAILING:
                task = TaskCreate(SeaMapIslandIcon_Main_Sailing, SeaMapIslandIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1),
                                  SeaMapIslandIcon);
                break;

            case SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION:
            case SEAMAPVIEW_TYPE_CHART_COURSE_DRAWING:
                task = TaskCreate(SeaMapIslandIcon_Main_ChartCourse, SeaMapIslandIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1),
                                  SeaMapIslandIcon);
                break;

            default:
                SeaMapEventManager_SetObjectAsActive(&tempObject);
                return NULL;
        }

        SeaMapIslandIcon *work = TaskGetWork(task, SeaMapIslandIcon);
        TaskInitWork16(work);

        InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);
        if (GetSeaMapViewType() == SEAMAPVIEW_TYPE_SAILING)
            work->eventListener = SeaMapEventTrigger_AddEventListener(SeaMapIslandIcon_EventCallback, work);
        SeaMapEventManager_SetObjectAsActive(&work->objWork);

        return &work->objWork;
    }
    else
    {
        if (mapObject->type == SEAMAPOBJECT_ISLAND_ICON_ELIPSE)
            SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Elipse(&mapObject->position, &mapObject->box);
        else
            SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Rect(&mapObject->position, &mapObject->box);

        SeaMapEventManager_SetObjectAsActive(&tempObject);
        return NULL;
    }
}

void SeaMapIslandIcon_EventCallback(SeaMapEventTriggerType type, void *workOpaque, void *eventData, void *param)
{
    SeaMapIslandIcon *work = (SeaMapIslandIcon *)workOpaque;

    if (type == SEAMAPEVENTTRIGGER_EVENT_ISLAND_DISCOVERY)
    {
        s32 targetIslandID             = VOID_TO_INT(eventData);
        SeaMapManagerSaveFlag id = SeaMapEventManager_GetLandableIslandID(targetIslandID);
        if (id == work->objWork.mapObject->id)
        {
            work->wasIslandDiscovered = TRUE;
        }
    }
}

void SeaMapIslandIcon_Main_Sailing(void)
{
    SeaMapIslandIcon *work = TaskGetWorkCurrent(SeaMapIslandIcon);

    SeaMapLayoutObject *mapObject = work->objWork.mapObject;
    if (SeaMapEventManager_CheckVisible(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        SeaMapEventManager_SetObjectAsInactive(&work->objWork);
        DestroyCurrentTask();
    }
    else
    {
        fx32 y;
        fx32 x;
        SailSeaMapView_GetPosition(&x, &y);
        if (SeaMapEventManager_GetObjectType(work->objWork.mapObject) == SEAMAPOBJECT_ISLAND_ICON_ELIPSE)
        {
            fx32 centerY;
            fx32 centerX;
            fx32 height;
            fx32 width;

            SeaMapEventManager_GetViewElipse(&mapObject->box, mapObject->position.x, mapObject->position.y, &centerX, &centerY, &width, &height);
            if (SeaMapEventManager_PointInViewElipse(centerX, centerY, width, height, x, y))
            {
                SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_SAIL_MAP, mapObject, NULL);
                if (work->wasIslandDiscovered)
                {
                    CreateSparklesForSeaMapIslandIcon(mapObject);
                    SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Elipse(&mapObject->position, &mapObject->box);
                    SeaMapManager__SetSaveFlag(mapObject->id, TRUE);
                    DestroyCurrentTask();
                }
            }
        }
        else
        {
            ViewRect viewRect;

            SeaMapEventManager_GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
            if (SeaMapEventManager_PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y))
            {
                SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_SAIL_MAP, mapObject, NULL);
                if (work->wasIslandDiscovered)
                {
                    CreateSparklesForSeaMapIslandIcon(mapObject);
                    SeaMapIslandDrawIcon_MarkMapDiscoveryArea_Rect(&mapObject->position, &mapObject->box);
                    SeaMapManager__SetSaveFlag(mapObject->id, TRUE);
                    DestroyCurrentTask();
                }
            }
        }
    }
}

void SeaMapIslandIcon_Main_ChartCourse(void)
{
    SeaMapIslandIcon *work = TaskGetWorkCurrent(SeaMapIslandIcon);

    SeaMapLayoutObject *mapObject = work->objWork.mapObject;
    if (SeaMapEventManager_CheckVisible(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        SeaMapEventManager_SetObjectAsInactive(&work->objWork);
        DestroyCurrentTask();
    }
    else
    {
        if (IsSeaMapIslandIconVisibleOnVoyage(mapObject))
            SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_CHART_MAP, mapObject, NULL);
    }
}

void SeaMapIslandIcon_Destructor(Task *task)
{
    SeaMapIslandIcon *work = TaskGetWork(task, SeaMapIslandIcon);

    if (work->eventListener)
        SeaMapEventTrigger_RemoveEventListener(work->eventListener);

    DestroySeaMapEventManagerObject(&work->objWork);
}

BOOL IsSeaMapIslandIconVisibleOnVoyage(SeaMapLayoutObject *mapObject)
{
    SeaMapManagerNode *curNode;

    if (SeaMapEventManager_GetObjectType(mapObject) == SEAMAPOBJECT_ISLAND_ICON_ELIPSE)
    {
        fx32 centerY;
        fx32 centerX;
        fx32 height;
        fx32 width;
        fx32 y;
        fx32 x;

        SeaMapEventManager_GetViewElipse(&mapObject->box, mapObject->position.x, mapObject->position.y, &centerX, &centerY, &width, &height);

        curNode = SeaMapManager__GetStartNode();
        while (curNode)
        {
            SeaMapManager__GetPosition2(curNode->position.x, curNode->position.y, &x, &y);
            if (SeaMapEventManager_PointInViewElipse(centerX, centerY, width, height, x, y))
                return TRUE;

            curNode = SeaMapManager__GetNextNode(curNode);
        }
    }
    else
    {
        fx32 y;
        fx32 x;
        ViewRect viewRect;
        SeaMapEventManager_GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);

        curNode = SeaMapManager__GetStartNode();
        while (curNode)
        {
            SeaMapManager__GetPosition2(curNode->position.x, curNode->position.y, &x, &y);
            if (SeaMapEventManager_PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y))
                return TRUE;

            curNode = SeaMapManager__GetNextNode(curNode);
        }
    }

    return FALSE;
}

BOOL SeaMapIslandIcon_ArrivalCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL ignoreDiscoveryCheck)
{
    if ((mapObject->usrFlags & SEAMAPISLANDICON_FLAG_DISCOVERABLE_VIA_VOYAGE) != 0)
    {
        if (ignoreDiscoveryCheck || SeaMapManager__GetSaveFlag(mapObject->id) == FALSE)
        {
            if (SeaMapEventManager_GetObjectType(mapObject) == SEAMAPOBJECT_ISLAND_ICON_ELIPSE)
                return SeaMapEventManager_ViewElipseCheck(mapObject, x, y);

            return SeaMapEventManager_ViewRectCheck(mapObject, x, y);
        }
    }
    else
    {
        if (sIslandProgressUnlockList[mapObject->id] <= SaveGame__GetGameProgress())
        {
            if (SeaMapEventManager_GetObjectType(mapObject) == SEAMAPOBJECT_ISLAND_ICON_ELIPSE)
                return SeaMapEventManager_ViewElipseCheck(mapObject, x, y);

            return SeaMapEventManager_ViewRectCheck(mapObject, x, y);
        }
    }

    return FALSE;
}
