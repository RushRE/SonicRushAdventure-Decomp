#include <stage/boss/bossFX.h>

// INFO: this file is a bossFX.c wrapper for the Boss2 overlay

// variable order for Boss2 overlay
#ifndef NON_MATCHING
FORCE_INCLUDE_VARIABLE(static u16, _UNUSED_BOSS_FX, 0) // unused/unknown variable

u16 sRexRageReferenceCount;
u16 sTitanFlashCReferenceCount;
u16 sRexHeadReferenceCount;
u16 sRexBiteReferenceCount;
u16 sHitBReferenceCount;
u16 sWhaleTsunami2ReferenceCount;
u16 sWhaleTsunami1ReferenceCount;
u16 sTitanFlashGReferenceCount;
u16 sHitAReferenceCount;
u16 sPirateLandReferenceCount;

// Note: sCondorImpactReferenceCount comes above sWhaleSplashBReferenceCount in Boss2 overlay
u16 sCondorImpactReferenceCount;
u16 sWhaleSplashBReferenceCount;
#endif

#include "bossFX.c"