#ifndef NITRO_PM_ARM9_H
#define NITRO_PM_ARM9_H

#include <nitro/misc.h>
#include <nitro/types.h>
#include <nitro/spi/common/pm_common.h>
#include <nitro/spi/common/spi_common.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef void (*PMCallback)(u32 result, void *arg);
typedef void (*PMSleepCallback)(void *);

// --------------------
// ENUMS
// --------------------

typedef enum
{
    PM_LCD_TOP    = 0,
    PM_LCD_BOTTOM = 1,
    PM_LCD_ALL    = 2
} PMLCDTarget;

typedef enum
{
    PM_BACKLIGHT_OFF = 0,
    PM_BACKLIGHT_ON  = 1
} PMBackLightSwitch;

typedef enum
{
    PM_BATTERY_HIGH = 0,
    PM_BATTERY_LOW  = 1
} PMBattery;

typedef enum
{
    PM_AMP_OFF = 0,
    PM_AMP_ON  = 1
} PMAmpSwitch;

typedef enum
{
    PM_AMPGAIN_20      = 0,
    PM_AMPGAIN_40      = 1,
    PM_AMPGAIN_80      = 2,
    PM_AMPGAIN_160     = 3,
    PM_AMPGAIN_DEFAULT = PM_AMPGAIN_40
} PMAmpGain;

typedef enum
{
    PM_LCD_POWER_OFF = 0,
    PM_LCD_POWER_ON  = 1
} PMLCDPower;

typedef enum
{
    PM_SOUND_POWER_OFF = 0,
    PM_SOUND_POWER_ON  = 1
} PMSoundPowerSwitch;

typedef enum
{
    PM_SOUND_VOLUME_OFF = 0,
    PM_SOUND_VOLUME_ON  = 1
} PMSoundVolumeSwitch;

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u16 flag;
    u16 padding;
    u16 *buffer;
} PMData16;

typedef struct PMiSleepCallbackInfo PMSleepCallbackInfo;
struct PMiSleepCallbackInfo
{
    PMSleepCallback callback;
    void *arg;
    PMSleepCallbackInfo *next;
};

// --------------------
// FUNCTIONS
// --------------------

void PM_Init(void);

u32 PM_SendUtilityCommandAsync(u32 number, PMCallback callback, void *arg);
u32 PM_SendUtilityCommand(u32 number);

u32 PM_SetBackLightAsync(PMLCDTarget target, PMBackLightSwitch sw, PMCallback callback, void *arg);
u32 PM_SetBackLight(PMLCDTarget target, PMBackLightSwitch status);
u32 PM_ForceToPowerOffAsync(PMCallback callback, void *arg);
u32 PM_ForceToPowerOff(void);
u32 PM_SetAmp(PMAmpSwitch sw);
u32 PM_GetBackLight(PMBackLightSwitch *top, PMBackLightSwitch *bottom);

void PM_GoSleepMode(PMWakeUpTrigger trigger, PMLogic logic, u16 keyPattern);
void PM_AppendPreSleepCallback(PMSleepCallbackInfo *info);
void PM_PrependPreSleepCallback(PMSleepCallbackInfo *info);
void PM_AppendPostSleepCallback(PMSleepCallbackInfo *info);
void PM_PrependPostSleepCallback(PMSleepCallbackInfo *info);

BOOL PM_SetLCDPower(PMLCDPower sw);
PMLCDPower PM_GetLCDPower(void);

u32 PMi_SendLEDPatternCommandAsync(PMLEDPattern pattern, PMCallback callback, void *arg);
u32 PMi_SendLEDPatternCommand(PMLEDPattern pattern);
u32 PM_GetLEDPatternAsync(PMLEDPattern *patternBuf, PMCallback callback, void *arg);
u32 PM_GetLEDPattern(PMLEDPattern *patternBuf);
BOOL PMi_SetLCDPower(PMLCDPower sw, PMLEDStatus led, BOOL skip, BOOL isSync);

void PMi_SendPxiData(u32 data);
void PMi_CommonCallback(PXIFifoTag tag, u32 data, BOOL err);
u32 PMi_SendSleepStart(u16 trigger, u16 keyIntrData);

u32 PMi_WriteRegisterAsync(u16 registerAddr, u16 data, PMCallback callback, void *arg);
u32 PMi_WriteRegister(u16 registerAddr, u16 data);
u32 PMi_SetLEDAsync(PMLEDStatus status, PMCallback callback, void *arg);
u32 PMi_SetLED(PMLEDStatus status);

SDK_INLINE void PM_SetSleepCallbackInfo(PMSleepCallbackInfo *info, PMSleepCallback callback, void *arg)
{
    info->callback = callback;
    info->arg      = arg;
}

SDK_INLINE u32 PM_SetLEDPatternAsync(PMLEDPattern pattern, PMCallback callback, void *arg)
{
    return PMi_SendLEDPatternCommandAsync(pattern, callback, arg);
}

SDK_INLINE u32 PM_SetLEDPattern(PMLEDPattern pattern)
{
    return PMi_SendLEDPatternCommand(pattern);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_PM_ARM9_H
