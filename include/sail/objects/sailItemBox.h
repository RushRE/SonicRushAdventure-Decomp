#ifndef RUSH_SAILITEMBOX_H
#define RUSH_SAILITEMBOX_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailItemBox(SailEventManagerObject *mapObject);
StageTask *CreateSailItemBoxCase(StageTask *parent);
StageTask *CreateSailItemBoxRewardText(StageTask *parent, u32 type);

#endif // !RUSH_SAILITEMBOX_H