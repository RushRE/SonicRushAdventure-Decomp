#ifndef RUSH2_SPLASH_SCREEN_H
#define RUSH2_SPLASH_SCREEN_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/background.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// ENUMS
// --------------------

enum FileList_ArchiveDMLG
{
    ARC_DMLG_FILE_CORP_BBG,
    ARC_DMLG_FILE_TEAM_BBG
};

// --------------------
// STRUCTS
// --------------------

typedef struct SplashScreen_
{
    void *archiveLogos;
    s32 field_4;
    s32 timer;
    s32 touchSkipDelay;
    Background bgSega;
    Background bgSonicTeam;
} SplashScreen;

// --------------------
// FUNCTIONS
// --------------------

void CreateSplashScreen(void);

#endif // RUSH2_SPLASH_SCREEN_H