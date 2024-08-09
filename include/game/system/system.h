#ifndef RUSH2_SYSTEM_H
#define RUSH2_SYSTEM_H

#include <global.h>

// --------------------
// FUNCTIONS
// --------------------

void InitSystems(void);
void *GetSystemUnknown(void);
void ResetRenderAffine(void);
u32 GetSystemFrameCounter(void);
void UnknownSystemHandler(void);

#endif // RUSH2_SYSTEM_H
