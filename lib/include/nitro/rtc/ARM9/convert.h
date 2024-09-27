#ifndef NITRO_RTC_CONVERT_H
#define NITRO_RTC_CONVERT_H

#include <nitro/types.h>
#include <nitro/rtc/ARM9/api.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

s32 RTC_ConvertDateToDay(const RTCDate *date);
s32 RTCi_ConvertTimeToSecond(const RTCTime *time);
s64 RTC_ConvertDateTimeToSecond(const RTCDate *date, const RTCTime *time);

void RTC_ConvertDayToDate(RTCDate *date, s32 day);
void RTCi_ConvertSecondToTime(RTCTime *time, s32 sec);
void RTC_ConvertSecondToDateTime(RTCDate *date, RTCTime *time, s64 sec);

RTCWeek RTC_GetDayOfWeek(RTCDate *date);

#ifdef __cplusplus
}
#endif

#endif // NITRO_RTC_CONVERT_H
