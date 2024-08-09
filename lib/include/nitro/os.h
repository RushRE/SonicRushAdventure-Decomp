#ifndef NITRO_OS_H
#define NITRO_OS_H

#include <nitro/os/context.h>
#include <nitro/os/system.h>
#include <nitro/os/systemWork.h>
#include <nitro/os/thread.h>
#include <nitro/os/mutex.h>
#include <nitro/os/interrupt.h>
#include <nitro/os/systemCall.h>
#include <nitro/os/spinLock.h>
#include <nitro/os/printf.h>
#include <nitro/os/init.h>
#include <nitro/os/exception.h>
#include <nitro/os/valarm.h>
#include <nitro/os/emulator.h>
#include <nitro/os/tick.h>
#include <nitro/os/alarm.h>
#include <nitro/os/ownerInfo.h>
#include <nitro/os/common/entropy.h>
#include <nitro/os/irqHandler.h>

#ifdef SDK_ARM9
#include <nitro/os/cache.h>
#include <nitro/os/protectionRegion.h>
#include <nitro/os/protectionUnit.h>
#include <nitro/os/ARM9/vramExclusive.h>
#endif // SDK_ARM9

#endif // NITRO_OS_H
