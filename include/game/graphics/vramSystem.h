#ifndef RUSH_VRAMSYSTEM_H
#define RUSH_VRAMSYSTEM_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

// so we can type these without needing casts every single time
#define VRAM_BG_PLTT    ((VRAMPaletteKey)VRAMKEY_TO_ADDR(HW_BG_PLTT))
#define VRAM_DB_BG_PLTT ((VRAMPaletteKey)VRAMKEY_TO_ADDR(HW_DB_BG_PLTT))

#define VRAM_OBJ_PLTT    ((VRAMPaletteKey)VRAMKEY_TO_ADDR(HW_OBJ_PLTT))
#define VRAM_DB_OBJ_PLTT ((VRAMPaletteKey)VRAMKEY_TO_ADDR(HW_DB_OBJ_PLTT))

#define VRAM_BG    ((void *)HW_BG_VRAM)
#define VRAM_DB_BG ((void *)HW_DB_BG_VRAM)

#define VRAM_OBJ    ((void *)HW_OBJ_VRAM)
#define VRAM_DB_OBJ ((void *)HW_DB_OBJ_VRAM)

#define VRAMSYSTEM_FLAG_ALLOCATED 0x80000000

// --------------------
// MACROS
// --------------------

#define VRAMKEY_TO_ADDR(key) (void *)(size_t)(key)
#define VRAMKEY_TO_KEY(key)  (size_t)(void *)(key)

// --------------------
// ENUMS
// --------------------

enum GraphicsEngine_
{
    GRAPHICS_ENGINE_A,
    GRAPHICS_ENGINE_B,

    GRAPHICS_ENGINE_COUNT,
};
typedef u32 GraphicsEngine;

enum PaletteRow_
{
    PALETTE_ROW_0,
    PALETTE_ROW_1,
    PALETTE_ROW_2,
    PALETTE_ROW_3,
    PALETTE_ROW_4,
    PALETTE_ROW_5,
    PALETTE_ROW_6,
    PALETTE_ROW_7,
    PALETTE_ROW_8,
    PALETTE_ROW_9,
    PALETTE_ROW_10,
    PALETTE_ROW_11,
    PALETTE_ROW_12,
    PALETTE_ROW_13,
    PALETTE_ROW_14,
    PALETTE_ROW_15,
};
typedef u16 PaletteRow;

// --------------------
// TYPES
// --------------------

typedef void *VRAMPixelKey;
typedef void *VRAMPaletteKey;

// --------------------
// ENUMS
// --------------------

enum VRAMMode_
{
    VRAM_MODE_0,
    VRAM_MODE_1,
    VRAM_MODE_2,
};
typedef u32 VRAMMode;

// --------------------
// STRUCTS
// --------------------

struct VRAMOBJBankManager
{
    void *location[3];
};

struct VRAMBGBankManager
{
    void *location[4];
};

struct VRAMBGExtPalBankManager
{
    void *location[4];
};

struct VRAMOBJExtPalBankManager
{
    void *location[1];
};

struct VRAMTextureBankManager
{
    void *location[4];
};

struct VRAMTexturePalBankManager
{
    void *location[6];
};

// --------------------
// VARUAVKES
// --------------------

extern u16 objBankShift[2];
extern u16 objBmpUse256K[2];

extern struct VRAMOBJExtPalBankManager objExtPalBankManager[2];
extern struct VRAMOBJBankManager objBankManager[2];

extern struct VRAMBGBankManager bgBankManager[2];
extern struct VRAMBGExtPalBankManager bgExtPalBankManager[2];

extern struct VRAMTextureBankManager textureBankManager;
extern struct VRAMTexturePalBankManager texturePalBankManager;

// --------------------
// FUNCTIONS
// --------------------

void InitVRAMSystem(void);
void VRAMSystem__Init(VRAMMode mode);
void VRAMSystem__Reset(void);

void VRAMSystem__SetupBGBank(GXVRamBG bank);
void VRAMSystem__SetupOBJBank(GXVRamOBJ bank, GXOBJVRamModeChar charMode, GXOBJVRamModeBmp bmpMode, u16 bankOffset, u16 tileCount);
void VRAMSystem__SetupBGExtPalBank(GXVRamBGExtPltt bank);
void VRAMSystem__SetupOBJExtPalBank(GXVRamOBJExtPltt bank);
void VRAMSystem__SetupSubBGBank(GXVRamSubBG bank);
void VRAMSystem__SetupSubOBJBank(GXVRamSubOBJ bank, GXOBJVRamModeChar charMode, GXOBJVRamModeBmp bmpMode, u16 bankOffset, u16 tileCount);
void VRAMSystem__SetupSubBGExtPalBank(GXVRamSubBGExtPltt bank);
void VRAMSystem__SetupSubOBJExtPalBank(GXVRamSubOBJExtPltt bank);
void VRAMSystem__SetupTextureBank(GXVRamTex bank);
void VRAMSystem__SetupTexturePalBank(GXVRamTexPltt bank);

void VRAMSystem__InitSpriteBuffer(BOOL useEngineB);
VRAMPixelKey VRAMSystem__AllocSpriteVram(BOOL useEngineB, size_t size);
void VRAMSystem__FreeSpriteVram(BOOL useEngineB, VRAMPixelKey key);

void VRAMSystem__InitTextureBuffer(void);
VRAMPixelKey VRAMSystem__AllocTexture(size_t size, BOOL is4x4comp);
void VRAMSystem__FreeTexture(VRAMPixelKey key);
u32 VRAMSystem__GetTextureUnknown(void);
void VRAMSystem__InitPaletteBuffer(void);
VRAMPaletteKey VRAMSystem__AllocPalette(size_t size, BOOL is4pltt);
void VRAMSystem__FreePalette(VRAMPaletteKey key);
u32 VRAMSystem__GetPaletteUnknown(void);
void *VRAMSystem__GetTexturePaletteAddr(s32 id);
NNSGfdTexKey VRAMSystem__AllocTexVram(u32 szByte, BOOL is4x4comp, u32 opt);
int VRAMSystem__FreeTexVram(NNSGfdTexKey texKey);
NNSGfdPlttKey VRAMSystem__AllocPlttVram(u32 szByte, BOOL is4pltt, u32 opt);
int VRAMSystem__FreePlttVram(NNSGfdPlttKey plttKey);
VRAMPixelKey VRAMSystem__AllocTexFunc_4x4Comp(size_t size, s32 id);
VRAMPixelKey VRAMSystem__AllocTexFunc_Normal(size_t size, s32 id);
VRAMPaletteKey VRAMSystem__AllocPalFunc(size_t size, s32 id, u16 *palettePtr, u32 paletteSize, u32 shift);

#ifdef __cplusplus
}
#endif

#endif // RUSH_VRAMSYSTEM_H
