#ifndef NITRO_RTC_API_H
#define NITRO_RTC_API_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum RTCWeek
{
    RTC_WEEK_SUNDAY = 0,
    RTC_WEEK_MONDAY,
    RTC_WEEK_TUESDAY,
    RTC_WEEK_WEDNESDAY,
    RTC_WEEK_THURSDAY,
    RTC_WEEK_FRIDAY,
    RTC_WEEK_SATURDAY,
    RTC_WEEK_MAX
} RTCWeek;

typedef enum RTCResult
{
    RTC_RESULT_SUCCESS = 0,
    RTC_RESULT_BUSY,
    RTC_RESULT_ILLEGAL_PARAMETER,
    RTC_RESULT_SEND_ERROR,
    RTC_RESULT_INVALID_COMMAND,
    RTC_RESULT_ILLEGAL_STATUS,
    RTC_RESULT_FATAL_ERROR,
    RTC_RESULT_MAX
} RTCResult;

// --------------------
// STRUCT
// --------------------

typedef struct RTCDate
{
    u32 year;
    u32 month;
    u32 day;
    RTCWeek week;
} RTCDate;

typedef struct RTCTime
{
    u32 hour;
    u32 minute;
    u32 second;
} RTCTime;

// --------------------
// TYPES
// --------------------

typedef void (*RTCCallback)(RTCResult result, void *arg);

// --------------------
// FUNCTIONS
// --------------------

void RTC_Init(void);

RTCResult RTC_GetDate(RTCDate *date);
RTCResult RTC_GetDateAsync(RTCDate *date, RTCCallback callback, void *arg);

RTCResult RTC_GetTime(RTCTime *time);
RTCResult RTC_GetTimeAsync(RTCTime *time, RTCCallback callback, void *arg);

RTCResult RTC_GetDateTime(RTCDate *date, RTCTime *time);
RTCResult RTC_GetDateTimeAsync(RTCDate *date, RTCTime *time, RTCCallback callback, void *arg);

#ifdef __cplusplus
}
#endif

#endif // NITRO_RTC_API_H
