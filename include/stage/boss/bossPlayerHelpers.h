#ifndef RUSH2_BOSSPLAYERHELPERS_H
#define RUSH2_BOSSPLAYERHELPERS_H

#include <stage/stageTask.h>
#include <stage/player/player.h>

// --------------------
// FUNCTIONS
// --------------------

void BossPlayerHelpers_Action_Boss1ChargeKnockback(Player *player, fx32 velX, fx32 velY);
void BossPlayerHelpers_Action_SetBoss3DefendEvent(Player *player);
void BossPlayerHelpers_Action_Boss3ArmKnockback(Player *player, fx32 velX, fx32 velY);
void BossPlayerHelpers_Action_TryBoss5Warp(Player *player, fx32 x, fx32 y);
void BossPlayerHelpers_Action_Boss5Freeze(Player *player);
void BossPlayerHelpers_State_Boss1ChargeKnockback(Player *player);
void BossPlayerHelpers_OnDefend_Boss3(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void BossPlayerHelpers_Action_SplatInkGround(Player *player);
void BossPlayerHelpers_State_SplatInkStuck(Player *player);
void BossPlayerHelpers_Action_SplatInkAir(Player *player);
void BossPlayerHelpers_State_SplatInkHit(Player *player);
void BossPlayerHelpers_State_Boss5Frozen(Player *player);
void BossPlayerHelpers_Action_DoBoss5Warp(Player *player);
void BossPlayerHelpers_Action_SetOnLandGround_Boss6(Player *player);
void BossPlayerHelpers_OnLandGround_Boss6(Player *player);
BOOL BossPlayerHelpers_CheckPlayerRidingObj(Player *player);
void BossPlayerHelpers_State_Ground_Boss6(Player *player);

#endif // RUSH2_BOSSPLAYERHELPERS_H
