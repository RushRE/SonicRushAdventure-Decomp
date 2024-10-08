#ifndef NITRO_H
#define NITRO_H

// decomp helper macros
// (will be removed when not needed)
#include <nonmatching.h>

// Includes
#include <cw.h>
#include <nitro/types.h>

#include <nitro/init/crt0.h>
#include <nitro/misc.h>

#include <nitro/os.h>
#include <nitro/mi.h>
#include <nitro/pxi.h>
#include <nitro/snd.h>
#include <nitro/pad.h>
#include <nitro/spi.h>
#include <nitro/card.h>
#include <nitro/fs.h>
#include <nitro/rtc.h>
#include <nitro/gx.h>
#include <nitro/wm.h>
#include <nitro/wvr.h>
#include <nitro/ctrdg.h>
#include <nitro/math.h>
#include <nitro/std.h>

#ifdef SDK_ARM9

#include <nitro/fx/fx.h>
#include <nitro/fx/fx_const.h>
#include <nitro/fx/fx_trig.h>
#include <nitro/fx/fx_cp.h>
#include <nitro/fx/fx_vec.h>
#include <nitro/fx/fx_mtx.h>
#include <nitro/cp.h>
#include <nitro/mb.h>
#include <nitro/wbt.h>
#include <nitro/vib.h>

#else // SDK_ARM7
#include <nitro/exi.h>
#endif

#endif // NITRO_H