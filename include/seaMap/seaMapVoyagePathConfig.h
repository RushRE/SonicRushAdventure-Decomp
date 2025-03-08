#ifndef RUSH_SEAMAPVOYAGEPATHCONFIG_H
#define RUSH_SEAMAPVOYAGEPATHCONFIG_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapVoyagePathConfigNodeType_
{
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_0,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_2,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_3,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE_4,
};
typedef s32 SeaMapVoyagePathConfigNodeType;

enum SeaMapVoyagePathConfigNodeType1Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_END, // didn't find island
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_GOAL, // found destination
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_COLLISION, // can't continue voyage marker
};
typedef s32 SeaMapVoyagePathConfigNodeType1Type;

enum SeaMapVoyagePathConfigNodeType2Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_0,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_1,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_2,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_3,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_4,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_5,
};
typedef s32 SeaMapVoyagePathConfigNodeType2Type;

enum SeaMapVoyagePathConfigNodeType3Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_0,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_1,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_2,
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_3,
};
typedef s32 SeaMapVoyagePathConfigNodeType3Type;

enum SeaMapVoyagePathConfigNodeType4Type_
{
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE4TYPE_RIVAL_RACE, 
    SEAMAPVOYAGEPATHCONFIGNODE_TYPE4TYPE_UNKNOWN,
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
            s32 unlockID;
        } type1;

        struct
        {
            SeaMapVoyagePathConfigNodeType2Type attribute;
        } type2;

        struct
        {
            SeaMapVoyagePathConfigNodeType3Type lv;
        } type3;

        struct
        {
            SeaMapVoyagePathConfigNodeType4Type type;
            CHEVObject *chevRef;
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
