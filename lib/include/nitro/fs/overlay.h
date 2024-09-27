#ifndef NITRO_FS_OVERLAY_H
#define NITRO_FS_OVERLAY_H

#include <nitro/mi/exMemory.h>
#include <nitro/fs/file.h>
#include <nitro/card/rom.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// MACROS
// --------------------

// get overlay from lcf file (as extern var)
#define FS_EXTERN_OVERLAY(name) extern u32 SDK_OVERLAY_##name##_ID[1]

// get overlay from lcf file (as u32)
#define FS_OVERLAY_ID(name) ((u32) & (SDK_OVERLAY_##name##_ID))

// --------------------
// TYPES
// --------------------

typedef u32 FSOverlayID;

typedef void (*FSOverlayInitFunc)(void);

// --------------------
// STRUCTS
// --------------------

typedef struct FSOverlayInfoHeader
{
    u32 id;
    u8 *ram_address;
    u32 ram_size;
    u32 bss_size;
    FSOverlayInitFunc *sinit_init;
    FSOverlayInitFunc *sinit_init_end;
    u32 file_id;
    u32 compressed : 24;
    u32 flag : 8;
} FSOverlayInfoHeader;

typedef struct FSOverlayInfo
{
    FSOverlayInfoHeader header;
    MIProcessor target;
    CARDRomRegion file_pos;
} FSOverlayInfo;

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE u8 *const FS_GetOverlayAddress(FSOverlayInfo *p_ovi)
{
    return p_ovi->header.ram_address;
}

SDK_INLINE u32 const FS_GetOverlayImageSize(FSOverlayInfo *p_ovi)
{
    return p_ovi->header.ram_size;
}

SDK_INLINE u32 const FS_GetOverlayTotalSize(FSOverlayInfo *p_ovi)
{
    return p_ovi->header.ram_size + p_ovi->header.bss_size;
}

// --------------------
// FUNCTIONS
// --------------------

void FS_ClearOverlayImage(FSOverlayInfo *p_ovi);
FSFileID FS_GetOverlayFileID(const FSOverlayInfo *p_ovi);
BOOL FSi_LoadOverlayInfoCore(FSOverlayInfo *p_ovi, MIProcessor target, FSOverlayID id, FSArchive *arc, u32 offset_arm9, u32 len_arm9, u32 offset_arm7, u32 len_arm7);
BOOL FS_LoadOverlayInfo(FSOverlayInfo *p_ovi, MIProcessor target, FSOverlayID id);
BOOL FS_LoadOverlayImageAsync(FSOverlayInfo *p_ovi, FSFile *p_file);
BOOL FS_LoadOverlayImage(FSOverlayInfo *p_ovi);
void FS_StartOverlay(FSOverlayInfo *p_ovi);
void FS_EndOverlay(FSOverlayInfo *p_ovi);
BOOL FS_UnloadOverlayImage(FSOverlayInfo *p_ovi);
BOOL FS_LoadOverlay(MIProcessor target, FSOverlayID id);
BOOL FS_UnloadOverlay(MIProcessor target, FSOverlayID id);
void FS_AttachOverlayTable(MIProcessor target, const void *ptr, u32 len);

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_OVERLAY_H
