#ifndef NITRO_RTC_H
#define NITRO_RTC_H

#include <nitro/rtc/type.h>
#include <nitro/rtc/fifo.h>

#ifdef SDK_ARM7
// #include <nitro/rtc/ARM7/control.h>
// #include <nitro/rtc/ARM7/instruction.h>
// #include <nitro/rtc/ARM7/gpio.h>
#else
#include <nitro/rtc/ARM9/api.h>
#include <nitro/rtc/ARM9/convert.h>
#endif

#endif // NITRO_RTC_H
