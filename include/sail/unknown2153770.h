#ifndef RUSH_SAILUNKNOWN2153770_H
#define RUSH_SAILUNKNOWN2153770_H

#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailUnknown2153770_
{
  u16 field_0;
} SailUnknown2153770;

// --------------------
// FUNCTIONS
// --------------------

SailUnknown2153770 *SailUnknown2153770__Create(void);

void SailUnknown2153770__Destructor(Task *task);
void SailUnknown2153770__Main(void);

#endif // !RUSH_SAILUNKNOWN2153770_H