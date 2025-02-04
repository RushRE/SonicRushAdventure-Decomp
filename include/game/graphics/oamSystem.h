
#ifndef RUSH_OAMSYSTEM_H
#define RUSH_OAMSYSTEM_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define OAMSYSTEM_INVALID 0xFFFF

#define OAMSYSTEM_OAM_LIST_SIZE 0x80
#define OAMSYSTEM_OAM_AFFINE_LIST_SIZE (OAMSYSTEM_OAM_LIST_SIZE / 4)

#define OAMSYSTEM_OAM_COUNT 0x20

// --------------------
// STRUCTS
// --------------------

struct OAMManager
{
    u16 count;
    u16 affineCount;
    u16 affineOffset;
    GXOamAttr oamList1[OAMSYSTEM_OAM_LIST_SIZE];
    GXOamAttr oamList2[OAMSYSTEM_OAM_LIST_SIZE];
    GXOamAttr oamList3[OAMSYSTEM_OAM_LIST_SIZE];
    u16 oamOrderMap1[OAMSYSTEM_OAM_COUNT];
    u16 oamOrderMap2[OAMSYSTEM_OAM_COUNT];
};

// --------------------
// VARIABLES
// --------------------

extern GXOamAttr oamDefault;

// --------------------
// FUNCTIONS
// --------------------

void InitOAMSystem(void);
GXOamAttr *OAMSystem__Alloc(BOOL useEngineB, u32 order);
GXOamAttr *OAMSystem__Func_207D624(BOOL useEngineB, GXOamAttr *attr);
u16 OAMSystem__AddAffineSprite(BOOL useEngineB, MtxFx22 *matrix);
void OAMSystem__PrepareNewFrame(BOOL useEngineB);
void OAMSystem__CopyToVRAM(BOOL useEngineB);
u32 OAMSystem__GetOAMCount(BOOL useEngineB);
u32 OAMSystem__GetOAMAffineCount(BOOL useEngineB);
u32 OAMSystem__GetOAMAffineOffset(BOOL useEngineB);
void OAMSystem__SetOAMAffineOffset(BOOL useEngineB, u16 offset);
GXOamAttr *OAMSystem__GetList1(BOOL useEngineB);
GXOamAttr *OAMSystem__GetList2(BOOL useEngineB);
GXOamAttr *OAMSystem__GetList3(BOOL useEngineB);
u32 OAMSystem__GetListMap(BOOL useEngineB, u32 order);

#ifdef __cplusplus
}
#endif

#endif // RUSH_OAMSYSTEM_H
