#ifndef RUSH_SEAMAPCOMMON_H
#define RUSH_SEAMAPCOMMON_H

#include <global.h>
#include <game/input/touchInput.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum ShipType_
{
    SHIP_JET,
    SHIP_BOAT,
    SHIP_HOVER,
    SHIP_SUBMARINE,

    SHIP_COUNT,

    // rarely-used values for magma hurricane
    SHIP_DRILL = SHIP_COUNT,
    SHIP_COUNT_DRILL,

    SHIP_MENU = SHIP_COUNT, // SeaMap menu
};
typedef u32 ShipType;

enum ShipLevel_
{
    SHIP_LEVEL_0,
    SHIP_LEVEL_1,
    SHIP_LEVEL_2,

    SHIP_LEVEL_MAX = SHIP_LEVEL_2,
};
typedef u32 ShipLevel;

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapManagerNode_
{
    NNSFndLink link;
    TouchPos position;
    fx32 distance;
} SeaMapManagerNode;

typedef struct SeaMapManagerNodeGroup_
{
    NNSFndLink link;
    SeaMapManagerNode entryList[64];
    u16 entryCount;
} SeaMapManagerNodeGroup;

typedef struct SeaMapManagerNodeList_
{
    NNSFndList nodes;
    NNSFndList groups;
} SeaMapManagerNodeList;

#ifdef __cplusplus
}
#endif

#endif // RUSH_SEAMAPCOMMON_H