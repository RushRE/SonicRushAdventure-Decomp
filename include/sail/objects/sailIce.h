#ifndef RUSH_SAILICE_H
#define RUSH_SAILICE_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailIce(SailEventManagerObject *mapObject);
void CreateSailIceForSegment(SailVoyageSegment *voyageSegment, s32 a2);

#endif // !RUSH_SAILICE_H