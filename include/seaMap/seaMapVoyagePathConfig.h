#ifndef RUSH_SEAMAPVOYAGEPATHCONFIG_H
#define RUSH_SEAMAPVOYAGEPATHCONFIG_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapVoyagePathConfigNodeType_
{
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_0,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_ISLAND_ARRIVAL,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_ATTRIBUTE,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_LV,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_ENCOUNTER,
};
typedef s32 SeaMapVoyagePathConfigNodeType;

enum SeaMapVoyagePathConfigNodeType1Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_ARRIVAL_END, // didn't find island
    SEAMAPVOYAGEPATHCONFIGNODE_ARRIVAL_GOAL, // found destination
    SEAMAPVOYAGEPATHCONFIGNODE_ARRIVAL_COLLISION, // can't continue voyage marker
};
typedef s32 SeaMapVoyagePathConfigNodeType1Type;

enum SeaMapVoyagePathConfigNodeAttribute_
{
    SEAMAPVOYAGEPATHCONFIGNODE_ATTRIBUTE_0,
    SEAMAPVOYAGEPATHCONFIGNODE_ATTRIBUTE_1,
    SEAMAPVOYAGEPATHCONFIGNODE_ATTRIBUTE_2,
    SEAMAPVOYAGEPATHCONFIGNODE_ATTRIBUTE_3,
    SEAMAPVOYAGEPATHCONFIGNODE_ATTRIBUTE_4,
    SEAMAPVOYAGEPATHCONFIGNODE_ATTRIBUTE_5,
};
typedef s32 SeaMapVoyagePathConfigNodeAttribute;

enum SeaMapVoyagePathConfigNodeType3Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_LV_0,
    SEAMAPVOYAGEPATHCONFIGNODE_LV_1,
    SEAMAPVOYAGEPATHCONFIGNODE_LV_2,
    SEAMAPVOYAGEPATHCONFIGNODE_LV_3,
};
typedef s32 SeaMapVoyagePathConfigNodeType3Type;

enum SeaMapVoyagePathConfigNodeType4Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_ENCOUNTER_RIVAL_RACE, 
    SEAMAPVOYAGEPATHCONFIGNODE_ENCOUNTER_UNKNOWN,
};
typedef s32 SeaMapVoyagePathConfigNodeType4Type;

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapVoyagePathConfigNode_
{
    fx32 distance;
    SeaMapVoyagePathConfigNodeType type;

    union
    {

        struct
        {
            s32 value;
        } type0;

        struct
        {
            SeaMapVoyagePathConfigNodeType1Type type;
            s32 id;
        } type1;

        struct
        {
            SeaMapVoyagePathConfigNodeAttribute attribute;
        } type2;

        struct
        {
            SeaMapVoyagePathConfigNodeType3Type lv;
        } type3;

        struct
        {
            SeaMapVoyagePathConfigNodeType4Type type;
            SeaMapLayoutObject *seaMapObject;
        } type4;
    };

    s32 field_10;
} SeaMapVoyagePathConfigNode;

typedef struct SeaMapVoyagePathConfigNodeLink_
{
    NNSFndLink link;
    SeaMapVoyagePathConfigNode node;
} SeaMapVoyagePathConfigNodeLink;

// --------------------
// FUNCTIONS
// --------------------

BOOL InitSeaMapVoyagePathConfig(void);
void ReleaseSeaMapVoyagePathConfig(void);
s32 SeaMapVoyagePathConfig_GetNodeCount(void);
SeaMapVoyagePathConfigNodeLink *SeaMapVoyagePathConfig_GetNode(u16 id);

void SeaMapVoyagePathConfig_StoreShipState(fx32 x, fx32 y, fx32 distance);

#endif // RUSH_SEAMAPVOYAGEPATHCONFIG_H
