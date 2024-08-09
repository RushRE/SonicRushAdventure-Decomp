
#ifndef RUSH2_CONNECTION_STATUS_ICON_H
#define RUSH2_CONNECTION_STATUS_ICON_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

enum ConnectionMode
{
    CONNECTION_MODE_WIRELESS,
    CONNECTION_MODE_NETWORK,
    CONNECTION_MODE_AUTO,
};
typedef u32 ConnectionMode;

enum FileList_ArchiveDMCMN_ANTENNA_LZ7
{
	ARC_DMCMN_ANTENNA_LZ7_FILE_NL_ICON_WIRELESS_BAC,
	ARC_DMCMN_ANTENNA_LZ7_FILE_NL_ICON_WIFI_BAC
};


// --------------------
// STRUCTS
// --------------------

typedef struct ConnectionStatusIcon_
{
  AnimatorSprite animator;
  ConnectionMode connectionMode;
  BOOL shouldDestroy;
} ConnectionStatusIcon;

// --------------------
// FUNCTIONS
// --------------------

void LoadConnectionStatusIconAssets(void);
void ReleaseConnectionStatusIconAssets(void);
void CreateConnectionStatusIcon(ConnectionMode connectionMode, BOOL useEngineB, u8 paletteRow, u8 oamPriority, u8 oamOrder, s16 x, s16 y);
void DestroyConnectionStatusIcon(void);

#endif // RUSH2_CONNECTION_STATUS_ICON_H