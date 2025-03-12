#ifndef RUSH_SAILFISH_H
#define RUSH_SAILFISH_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailFish(SailEventManagerObject *mapObject);
StageTask *CreateSailIslandFish(StageTask *work);
void CreateSailFishForSegment(SailVoyageSegment *voyageSegment);
void CreateSailFishForDestination(StageTask *parent);

#endif // !RUSH_SAILFISH_H