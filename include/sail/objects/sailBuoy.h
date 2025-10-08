#ifndef RUSH_SAILBUOY_H
#define RUSH_SAILBUOY_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailBuoy(SailEventManagerObject *mapObject);
void CreateSailBuoyForSegment(SailVoyageSegment *voyageSegment);
void CreateSailBuoyForGoal(SailVoyageSegment *voyageSegment);

#endif // !RUSH_SAILBUOY_H