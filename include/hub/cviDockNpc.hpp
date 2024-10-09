#ifndef RUSH2_CVIDOCKNPC_HPP
#define RUSH2_CVIDOCKNPC_HPP

#include <hub/vi3dArrow.hpp>
#include <hub/cviDockNpc.hpp>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

class CViDockNpc : public Vi3dObject
{

public:
    s32 npcType;
    s32 field_304;
    s32 field_308;
    s32 field_30C;
    u16 field_310;
    u16 assetType;
    void *model;
    void *aniJoints;
    void *aniMaterial;
    void *aniVisibility;
    void *aniTexture;
    s32 field_328;
    s32 field_32C;
    s32 field_330;
    s32 field_334;
    CViDockNpc *next;
    CViDockNpc *prev;
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
}
#endif

#endif // RUSH2_CVIDOCKNPC_HPP
