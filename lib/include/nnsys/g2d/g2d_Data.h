#ifndef NNS_G2D_DATA_H
#define NNS_G2D_DATA_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <nitro/types.h>

#include <nnsys/g2d/fmt/g2d_Common_data.h>
#include <nnsys/g2d/fmt/g2d_Anim_data.h>
#include <nnsys/g2d/fmt/g2d_Cell_data.h>
#include <nnsys/g2d/fmt/g2d_MultiCell_data.h>
#include <nnsys/g2d/fmt/g2d_Entity_data.h>
#include <nnsys/g2d/fmt/g2d_Character_data.h>
#include <nnsys/g2d/fmt/g2d_Screen_data.h>
#include <nnsys/g2d/fmt/g2d_Oam_data.h>
#include <nnsys/g2d/fmt/g2d_Font_data.h>
#include <nnsys/g2d/g2d_config.h>

// --------------------
// MACROS
// --------------------

#define NNS_G2D_UNPACK_OFFSET_PTR(ptr, baseOffs) (ptr) = (void *)((u32)(ptr) + (u32)baseOffs)

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_DATA_H