#ifndef NITRO_CARD_ROM_H
#define NITRO_CARD_ROM_H

#include <nitro/misc.h>
#include <nitro/types.h>
#include <nitro/hw/io_reg.h>
#include <nitro/mi/dma.h>
#include <nitro/mi/exMemory.h>
#include <nitro/os.h>
#include <nitro/card/common.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define CARD_ROM_PAGE_SIZE 512

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 offset;
    u32 length;
} CARDRomRegion;

typedef struct
{
    char game_name[12];
    u32 game_code;
    u16 maker_code;
    u8 product_id;
    u8 device_type;
    u8 device_size;
    u8 reserved_A[9];
    u8 game_version;
    u8 property;

    void *main_rom_offset;
    void *main_entry_address;
    void *main_ram_address;
    u32 main_size;
    void *sub_rom_offset;
    void *sub_entry_address;
    void *sub_ram_address;
    u32 sub_size;

    CARDRomRegion fnt;
    CARDRomRegion fat;

    CARDRomRegion main_ovt;
    CARDRomRegion sub_ovt;

    u8 rom_param_A[8];
    u32 banner_offset;
    u16 secure_crc;
    u8 rom_param_B[2];

    void *main_autoload_done;
    void *sub_autoload_done;

    u8 rom_param_C[8];
    u32 rom_size;
    u32 header_size;
    u8 reserved_B[0x38];

    u8 logo_data[0x9C];
    u16 logo_crc;
    u16 header_crc;

} CARDRomHeader;

// --------------------
// FUNCTIONS
// --------------------

void CARD_LockRom(u16 lock_id);
void CARD_UnlockRom(u16 lock_id);
void CARDi_ReadRom(u32 dma, const void *src, void *dst, u32 len, MIDmaCallback callback, void *arg, BOOL is_async);
void CARD_WaitRomAsync(void);
BOOL CARD_TryWaitRomAsync(void);
u32 CARDi_ReadRomID(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE const CARDRomRegion *CARD_GetRomRegionFNT(void)
{
    return (const CARDRomRegion *)((const u8 *)HW_ROM_HEADER_BUF + 0x40);
}

SDK_INLINE const CARDRomRegion *CARD_GetRomRegionFAT(void)
{
    return (const CARDRomRegion *)((const u8 *)HW_ROM_HEADER_BUF + 0x48);
}

SDK_INLINE const CARDRomRegion *CARD_GetRomRegionOVT(MIProcessor target)
{
    return (target == MI_PROCESSOR_ARM9) ? (const CARDRomRegion *)((const u8 *)HW_ROM_HEADER_BUF + 0x50) : (const CARDRomRegion *)((const u8 *)HW_ROM_HEADER_BUF + 0x58);
}

SDK_INLINE void CARD_ReadRomAsync(u32 dma, const void *src, void *dst, u32 len, MIDmaCallback callback, void *arg)
{
    CARDi_ReadRom(dma, src, dst, len, callback, arg, TRUE);
}

SDK_INLINE void CARD_ReadRom(u32 dma, const void *src, void *dst, u32 len)
{
    CARDi_ReadRom(dma, src, dst, len, NULL, NULL, FALSE);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_CARD_ROM_H
