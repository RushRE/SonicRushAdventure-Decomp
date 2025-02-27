
#include <menu/connectionStatusIcon.h>
#include <game/file/archiveFile.h>
#include <game/graphics/pixelsQueue.h>
#include <game/graphics/spriteUnknown.h>
#include <network/wirelessManager.h>
#include <network/networkHandler.h>

// resources
#include <resources/narc/dmcmn_antenna_lz7.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void StageClear__LoadFiles(void *archive, ...);


// --------------------
// STRUCTS
// --------------------

enum ConnectionStatusIconAnimID
{
	CONNECTIONSTATUSICON_ANI_ICON,
	CONNECTIONSTATUSICON_ANI_LEVEL_0,
	CONNECTIONSTATUSICON_ANI_LEVEL_1,
	CONNECTIONSTATUSICON_ANI_LEVEL_2,
	CONNECTIONSTATUSICON_ANI_LEVEL_3,
	CONNECTIONSTATUSICON_ANI_UNKNOWN,
};

// --------------------
// STRUCTS
// --------------------

typedef struct ConnectionStatusIconStaticVars_
{
    Task *task;
    void *archive;
    void *sprIcon;
} ConnectionStatusIconStaticVars;

// --------------------
// VARIABLES
// --------------------

static ConnectionStatusIconStaticVars *staticVars;

// --------------------
// FUNCTION DECLS
// --------------------

static void ConnectionStatusIcon_Destructor(Task *task);
static u16 GetConnectionLinkLevelAnim(ConnectionMode connectionMode);
static void ConnectionStatusIcon_Main(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadConnectionStatusIconAssets(void)
{
    if (staticVars != NULL)
        return;

    staticVars = HeapAllocHead(HEAP_SYSTEM, sizeof(ConnectionStatusIconStaticVars));

    ConnectionStatusIconStaticVars *sVars = staticVars;
    MI_CpuClear32(sVars, sizeof(ConnectionStatusIconStaticVars));
    sVars->archive = ArchiveFile__Load("/narc/dmcmn_antenna_lz7.narc", ARCHIVEFILE_ID_NONE, ARCHIVEFILE_AUTO_ALLOC_HEAD_SYSTEM, ARCHIVEFILE_FLAG_IS_COMPRESSED, NULL);
}

void ReleaseConnectionStatusIconAssets(void)
{
    ConnectionStatusIconStaticVars *sVars = staticVars;

    if (sVars == NULL)
        return;

    DestroyConnectionStatusIcon();

    HeapFree(HEAP_SYSTEM, sVars->archive);
    sVars->archive = NULL;

    HeapFree(HEAP_SYSTEM, staticVars);
    staticVars = NULL;
}

void CreateConnectionStatusIcon(ConnectionMode desiredConnectionMode, BOOL useEngineB, u8 paletteRow, u8 oamPriority, u8 oamOrder, s16 x, s16 y)
{
    ConnectionStatusIcon *work;

    ConnectionMode connectionMode         = desiredConnectionMode;
    ConnectionStatusIconStaticVars *sVars = staticVars;
    BOOL noDraw                           = FALSE;

    if (sVars == NULL)
        return;

    if (desiredConnectionMode == CONNECTION_MODE_AUTO)
    {
        if (WirelessManager__GetField8())
        {
            connectionMode = CONNECTION_MODE_WIRELESS;
        }
        else if (GetINetManagerStatus() != INETMANAGER_STATUS_INACTIVE)
        {
            connectionMode = CONNECTION_MODE_NETWORK;
        }
        else
        {
            connectionMode = CONNECTION_MODE_WIRELESS;
            noDraw         = TRUE;
        }
    }

    if (connectionMode == CONNECTION_MODE_WIRELESS)
        StageClear__LoadFiles(sVars->archive, &sVars->sprIcon, ARCHIVE_DMCMN_ANTENNA_LZ7_FILE_NL_ICON_WIRELESS_BAC, NULL);
    else
        StageClear__LoadFiles(sVars->archive, &sVars->sprIcon, ARCHIVE_DMCMN_ANTENNA_LZ7_FILE_NL_ICON_WIFI_BAC, NULL);

    if (sVars->task == NULL)
    {
        sVars->task = TaskCreate(ConnectionStatusIcon_Main, ConnectionStatusIcon_Destructor, TASK_FLAG_DISABLE_DESTROY, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xEF00, TASK_GROUP(0),
                                 ConnectionStatusIcon);

        work = TaskGetWork(sVars->task, ConnectionStatusIcon);
        TaskInitWork32(work);

        work->connectionMode = connectionMode;
    }
    else
    {
        work = TaskGetWork(sVars->task, ConnectionStatusIcon);
        TaskInitWork32(work);

        work->connectionMode = connectionMode;
        AnimatorSprite__Release(&work->animator);
    }

    SpriteUnknown__InitAnimator(&work->animator, sVars->sprIcon, CONNECTIONSTATUSICON_ANI_LEVEL_0, ANIMATOR_FLAG_NONE, useEngineB, SpriteUnknown__GetSpriteSize(sVars->sprIcon, useEngineB), paletteRow,
                                oamPriority, oamOrder);
    work->animator.pos.x = x;
    work->animator.pos.y = y;
    
    if (noDraw)
        work->animator.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
}

void DestroyConnectionStatusIcon(void)
{
    ConnectionStatusIconStaticVars *sVars = staticVars;

    if (sVars == NULL || sVars->task == NULL)
        return;

    ConnectionStatusIcon *work = TaskGetWork(sVars->task, ConnectionStatusIcon);
    work->shouldDestroy        = TRUE;

    sVars->task = NULL;
}

void ConnectionStatusIcon_Destructor(Task *task)
{
    // not using TaskGetWork for some reason?
    ConnectionStatusIcon *work = TaskGetWorkCurrent(ConnectionStatusIcon);

    AnimatorSprite__Release(&work->animator);
}

u16 GetConnectionLinkLevelAnim(ConnectionMode connectionMode)
{
    WMLinkLevel linkLevel;
    if (connectionMode == CONNECTION_MODE_NETWORK)
        linkLevel = DWC_GetLinkLevel();
    else
        linkLevel = WirelessManager__GetLinkLevel();

    switch (linkLevel)
    {
        case WM_LINK_LEVEL_3:
            return CONNECTIONSTATUSICON_ANI_LEVEL_3;

        case WM_LINK_LEVEL_2:
            return CONNECTIONSTATUSICON_ANI_LEVEL_2;

        case WM_LINK_LEVEL_1:
            return CONNECTIONSTATUSICON_ANI_LEVEL_1;
    }

    return CONNECTIONSTATUSICON_ANI_LEVEL_0;
}

void ConnectionStatusIcon_Main(void)
{
    ConnectionStatusIcon *work;
    ConnectionStatusIconStaticVars *sVars;

    sVars = staticVars;
    work  = TaskGetWorkCurrent(ConnectionStatusIcon);

    if (work->shouldDestroy)
    {
        DestroyCurrentTask();
        return;
    }

    if (sVars == NULL)
    {
        DestroyCurrentTask();
        return;
    }

    u16 linkLevel = GetConnectionLinkLevelAnim(work->connectionMode);

    if (work->animator.animID != linkLevel)
        AnimatorSprite__SetAnimation(&work->animator, linkLevel);

    AnimatorSprite__ProcessAnimationFast(&work->animator);
    AnimatorSprite__DrawFrame(&work->animator);
}
