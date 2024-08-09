#ifndef NITRO_VIB_H
#define NITRO_VIB_H

#include <nitro.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define VIB_PULSE_NUM_MAX 6

#define VIB_ON_TIME_MAX   15
#define VIB_REST_TIME_MIN 15

// --------------------
// TYPES
// --------------------

typedef void (*VIBCartridgePulloutCallback)(void);

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 pulse_num;
    u32 rest_time;
    u32 on_time[VIB_PULSE_NUM_MAX];
    u32 off_time[VIB_PULSE_NUM_MAX];
    u32 repeat_num;
} VIBPulseState;

// --------------------
// FUNCTIONS
// --------------------

BOOL VIB_Init(void);
void VIB_End(void);
void VIB_StartPulse(const VIBPulseState *state);
void VIB_StopPulse(void);
BOOL VIB_IsExecuting(void);
void VIB_SetCartridgePulloutCallback(VIBCartridgePulloutCallback func);
BOOL VIB_IsCartridgeEnabled(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_VIB_H
