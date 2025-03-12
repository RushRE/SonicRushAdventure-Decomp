#ifndef RUSH_SAILROCK_H
#define RUSH_SAILROCK_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailRock(SailEventManagerObject *mapObject);
void CreateSailRockForSegment(SailVoyageSegment *voyageSegment, s32 a2);

#endif // !RUSH_SAILROCK_H