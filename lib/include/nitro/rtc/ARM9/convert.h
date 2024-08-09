#ifndef NITRO_RTC_CONVERT_H
#define NITRO_RTC_CONVERT_H

#include <nitro/types.h>
#include <nitro/rtc/ARM9/api.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

s64 RTC_ConvertDateTimeToSecond(const RTCDate *date, const RTCTime *time);
s32 RTC_ConvertDateToDay(const RTCDate *date);
void RTC_ConvertSecondToDateTime(RTCDate *date, RTCTime *time, s64 sec);

#ifdef __cplusplus
}
#endif

#endif // NITRO_RTC_CONVERT_H
