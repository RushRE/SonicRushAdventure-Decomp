#ifndef RUSH_VSRECORDSMENU_H
#define RUSH_VSRECORDSMENU_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/text/fontWindow.h>
#include <game/graphics/unknown2056570.h>
#include <game/input/touchField.h>

// --------------------
// STRUCTS
// --------------------

typedef struct VSRecordsMenuHandle_
{
    Task *vsRecordsMenu;
    void *archive;
} VSRecordsMenuHandle;

typedef struct VSRecordsMenu_
{
    VSRecordsMenuHandle *assets;
    u32 timer;
    union
    {
        struct
        {

            AnimatorSprite aniWirelessStats;
            AnimatorSprite aniNetworkStats;
        };

        AnimatorSprite aniRecords[2];
    };
    FontWindow *fontWindow;
    Unknown2056570 digitUnknown[2][2][3];
    GXScrFmtText *digitPixels;
} VSRecordsMenu;

// --------------------
// FUNCTIONS
// --------------------

void InitVSRecordsMenuHandle(VSRecordsMenuHandle *work);
void ReleaseVSRecordsMenuHandle(VSRecordsMenuHandle *work);
void CreateVSRecordsMenuFromHandle(VSRecordsMenuHandle *work);
BOOL CheckVSRecordsMenuHandleTaskActive(VSRecordsMenuHandle *work);

#endif // RUSH_VSRECORDSMENU_H