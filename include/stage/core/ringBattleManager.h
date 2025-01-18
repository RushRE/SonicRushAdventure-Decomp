#ifndef RUSH_RINGBATTLEMANAGER_H
#define RUSH_RINGBATTLEMANAGER_H

#include <stage/gameObject.h>
#include <stage/objects/ringButton.h>
#include <stage/objects/itembox.h>

// --------------------
// CONSTANTS
// --------------------

#define RINGBATTLEMANAGER_ITEM_LIST_SIZE 32

// --------------------
// STRUCTS
// --------------------

typedef struct RingBattleManager_
{
  u32 ringButtonRandSeed;
  u32 itemBoxRandSeed;
  u32 buttonActivateDelay;
  u32 timer;
  u16 ringButtonCount;
  u16 itemBoxCount;
  u16 activateButtonCount;
  u16 activateItemBoxCount;
  u16 inactiveItemBoxCount;
  RingButton *ringButtonList[RINGBATTLEMANAGER_ITEM_LIST_SIZE];
  ItemBox *itemBoxList[RINGBATTLEMANAGER_ITEM_LIST_SIZE];
  u16 buttonActivateDelayOffset;
} RingBattleManager;

// --------------------
// FUNCTIONS
// --------------------

void CreateRingBattleManager(void);
void AddButtonToRingBattleManager(RingButton *button);
void AddItemBoxToRingBattleManager(ItemBox *itemBox);
void RingBattleManager_OnButtonActivated(RingButton *button);
GameObjectTask *CreateRingBattleManagerObject(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_RINGBATTLEMANAGER_H