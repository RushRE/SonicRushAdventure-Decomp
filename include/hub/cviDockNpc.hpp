#ifndef RUSH_CVIDOCKNPC_HPP
#define RUSH_CVIDOCKNPC_HPP

#include <hub/cvi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockNpc : public CVi3dObject
{

public:
    // CViDockNpc();
    // virtual ~CViDockNpc();

    // --------------------
    // VARIABLES
    // --------------------
    
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

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void _ZN10CViDockNpcC1Ev();
NOT_DECOMPILED void _ZN10CViDockNpcD0Ev();
NOT_DECOMPILED void _ZN10CViDockNpcD1Ev();

void ViDockNpc__LoadAssets(CViDockNpc *work);
void ViDockNpc__Func_2166F10(CViDockNpc *work);
void ViDockNpc__Func_2166FCC(CViDockNpc *work);
void ViDockNpc__Func_2167068(CViDockNpc *work);
BOOL ViDockNpc__Func_216710C(CViDockNpc *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
BOOL ViDockNpc__Func_2167244(CViDockNpc *work, VecFx32 *position, s32 a3, s32 a4, BOOL *flag);
BOOL ViDockNpc__Func_216737C(CViDockNpc *work, s32 a2);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKNPC_HPP
