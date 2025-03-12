#ifndef RUSH_SAILSEAGULL_H
#define RUSH_SAILSEAGULL_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailUnusedSeagull(SailEventManagerObject *mapObject);
StageTask *CreateSailSeagull(SailEventManagerObject *mapObject);
StageTask *CreateSailIslandSeagull(StageTask *parent);

void CreateSailSeagullForSegment(SailVoyageSegment *voyageSegment);
void CreateSailSeagullForDestination(StageTask *parent);

#endif // !RUSH_SAILSEAGULL_H