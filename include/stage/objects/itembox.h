#ifndef RUSH_ITEMBOX_H
#define RUSH_ITEMBOX_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct ItemBox_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniContents;
} ItemBox;

typedef struct ItemBoxReward_
{
    StageTask objWork;
    OBS_ACTION2D_BAC_WORK aniReward;
} ItemBoxReward;

// --------------------
// FUNCTIONS
// --------------------

ItemBox *CreateItemBox(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void BreakItemBox(ItemBox *work, Player *player, s32 type);
void CreateItemBoxReward(s32 type);

#endif // RUSH_ITEMBOX_H
