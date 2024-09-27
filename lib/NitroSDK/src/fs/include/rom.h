#ifndef NITRO_FS_ROM_H
#define NITRO_FS_ROM_H

#include <nitro/misc.h>
#include <nitro/types.h>
#include <nitro/fs/file.h>
#include <nitro/fs/archive.h>

// --------------------
// VARIABLES
// --------------------

extern s32 fsi_card_lock_id;

extern CARDRomRegion fsi_ovt9;
extern CARDRomRegion fsi_ovt7;

#if defined(FS_IMPLEMENT)
extern FSArchive fsi_arc_rom;
#endif

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

void FSi_InitRom(u32 default_dma_no);
BOOL FSi_LoadOverlayInfoCore(FSOverlayInfo *p_ovi, MIProcessor target, FSOverlayID id, FSArchive *p_arc, u32 offset_arm9, u32 len_arm9, u32 offset_arm7, u32 len_arm7);

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_ROM_H