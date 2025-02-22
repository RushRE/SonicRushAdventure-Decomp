#ifndef NITRO_GX_H
#define NITRO_GX_H

#ifdef SDK_ARM9

#include <nitro/gx/gxcommon.h>
#include <nitro/gx/gxasm.h>
#include <nitro/gx/gxdma.h>
#include <nitro/gx/gx.h>
#include <nitro/gx/gxstate.h>
#include <nitro/gx/gx_bgctrl.h>
#include <nitro/gx/gx_capture.h>
#include <nitro/gx/g2.h>
#include <nitro/gx/g3.h>
#include <nitro/gx/g3x.h>
#include <nitro/gx/g3b.h>
#include <nitro/gx/g3c.h>
#include <nitro/gx/g3imm.h>
#include <nitro/gx/gx_load.h>
#include <nitro/gx/g3_util.h>
#include <nitro/gx/g2_oam.h>
#include <nitro/gx/struct_2d.h>
#include <nitro/gx/gx_vramctrl.h>

#else // SDK_ARM7

#include <nitro/gx/gx_sp.h>

#endif // SDK_ARM9

#endif // NITRO_GX_H
