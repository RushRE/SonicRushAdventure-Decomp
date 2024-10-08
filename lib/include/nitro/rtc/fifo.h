#ifndef NITRO_RTC_COMMON_FIFO_H
#define NITRO_RTC_COMMON_FIFO_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define RTC_PXI_COMMAND_MASK    0x00007f00
#define RTC_PXI_COMMAND_SHIFT   8
#define RTC_PXI_RESULT_BIT_MASK 0x00008000
#define RTC_PXI_RESULT_MASK     0x000000ff
#define RTC_PXI_RESULT_SHIFT    0

#define RTC_PXI_COMMAND_RESET           0x00
#define RTC_PXI_COMMAND_SET_HOUR_FORMAT 0x01
#define RTC_PXI_COMMAND_READ_DATETIME   0x10
#define RTC_PXI_COMMAND_READ_DATE       0x11
#define RTC_PXI_COMMAND_READ_TIME       0x12
#define RTC_PXI_COMMAND_READ_PULSE      0x13
#define RTC_PXI_COMMAND_READ_ALARM1     0x14
#define RTC_PXI_COMMAND_READ_ALARM2     0x15
#define RTC_PXI_COMMAND_READ_STATUS1    0x16
#define RTC_PXI_COMMAND_READ_STATUS2    0x17
#define RTC_PXI_COMMAND_READ_ADJUST     0x18
#define RTC_PXI_COMMAND_READ_FREE       0x19
#define RTC_PXI_COMMAND_WRITE_DATETIME  0x20
#define RTC_PXI_COMMAND_WRITE_DATE      0x21
#define RTC_PXI_COMMAND_WRITE_TIME      0x22
#define RTC_PXI_COMMAND_WRITE_PULSE     0x23
#define RTC_PXI_COMMAND_WRITE_ALARM1    0x24
#define RTC_PXI_COMMAND_WRITE_ALARM2    0x25
#define RTC_PXI_COMMAND_WRITE_STATUS1   0x26
#define RTC_PXI_COMMAND_WRITE_STATUS2   0x27
#define RTC_PXI_COMMAND_WRITE_ADJUST    0x28
#define RTC_PXI_COMMAND_WRITE_FREE      0x29
#define RTC_PXI_COMMAND_INTERRUPT       0x30

// --------------------
// ENUMS
// --------------------

typedef enum RTCPxiResult
{
    RTC_PXI_RESULT_SUCCESS = 0,
    RTC_PXI_RESULT_INVALID_COMMAND,
    RTC_PXI_RESULT_ILLEGAL_STATUS,
    RTC_PXI_RESULT_BUSY,
    RTC_PXI_RESULT_FATAL_ERROR,
    RTC_PXI_RESULT_MAX
} RTCPxiResult;

#ifdef __cplusplus
}
#endif

#endif // NITRO_RTC_COMMON_FIFO_H