#include <stage/boss/bossFX.h>

// INFO: this file is a bossFX.c wrapper for the Boss2 overlay

// variable order for Boss2 overlay
#ifndef NON_MATCHING
FORCE_INCLUDE_VARIABLE(static u16, _UNUSED_BOSS_FX, 0) // unused/unknown variable

u16 RexRage_ReferenceCount;
u16 TitanFlashC_ReferenceCount;
u16 RexHead_ReferenceCount;
u16 RexBite_ReferenceCount;
u16 HitB_ReferenceCount;
u16 WhaleTsunami2_ReferenceCount;
u16 WhaleTsunami1_ReferenceCount;
u16 TitanFlashG_ReferenceCount;
u16 HitA_ReferenceCount;
u16 PirateLand_ReferenceCount;

// Note: CondorImpact_ReferenceCount comes above WhaleSplashB_ReferenceCount in Boss2 overlay
u16 CondorImpact_ReferenceCount;
u16 WhaleSplashB_ReferenceCount;
#endif

#include "bossFX.c"