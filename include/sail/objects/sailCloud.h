#ifndef RUSH_SAILCLOUD_H
#define RUSH_SAILCLOUD_H

#include <sail/sailCommonObjects.h>

// --------------------
// ENUMS
// --------------------

enum SailSkyCloudType
{
    SAILSKYCLOUD_TYPE_0,
    SAILSKYCLOUD_TYPE_1,
};

// --------------------
// FUNCTIONS
// --------------------

void CreateSailFogCloudsForVoyage(void);
StageTask *CreateSailFogCloud(SailEventManagerObject *mapObject);
StageTask *CreateSailSkyCloud(s32 type);

#endif // !RUSH_SAILCLOUD_H