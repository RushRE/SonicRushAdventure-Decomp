#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#define VIBi_INTR_DELAY_TICK (19)
#define VIBi_BITID           (2)

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 current_pos;
    u32 rest_pos;
    u32 rest_tick;
    u32 on_tick[VIB_PULSE_NUM_MAX];
    u32 off_tick[VIB_PULSE_NUM_MAX];
    BOOL is_enable;
    u32 repeat_num;
    u32 current_count;
    VIBCartridgePulloutCallback cartridge_pullout_callback;
} VIBiPulseInfo;

// --------------------
// FUNCTION DECLS
// --------------------

BOOL VIB_Init(void);
void VIB_End(void);
void VIB_StartPulse(const VIBPulseState *state);
void VIB_StopPulse(void);
BOOL VIB_IsExecuting(void);
void VIB_SetCartridgePulloutCallback(VIBCartridgePulloutCallback func);
BOOL VIB_IsCartridgeEnabled(void);
static inline u32 VIBi_PulseTimeToTicks(u32 pulse_time);
static BOOL VIBi_PulledOutCallbackCartridge(void);
static void VIBi_MotorOnOff(VIBiPulseInfo *pulse_vib);
static void VIBi_SleepCallback(void *);

// --------------------
// VARIABLES
// --------------------

static VIBiPulseInfo pulse_vib ATTRIBUTE_ALIGN(32);
static PMSleepCallbackInfo sc_info;

// --------------------
// FUNCTIONS
// --------------------

BOOL VIB_Init(void)
{
    static BOOL is_initialized;

    if (is_initialized)
    {
        return VIB_IsCartridgeEnabled();
    }

    is_initialized = TRUE;

    if (CTRDGi_IsBitIDAtInit(VIBi_BITID))
    {
        MI_CpuClearFast(&pulse_vib, sizeof(pulse_vib));
        CTRDG_SetPulledOutCallback(VIBi_PulledOutCallbackCartridge);
        PM_SetSleepCallbackInfo(&sc_info, VIBi_SleepCallback, NULL);
        PM_AppendPreSleepCallback(&sc_info);

        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

void VIB_End(void)
{
    VIB_StopPulse();
    PM_DeletePreSleepCallback(&sc_info);
    CTRDG_SetPulledOutCallback(NULL);
}

void VIB_StartPulse(const VIBPulseState *state)
{
    if (!VIB_IsCartridgeEnabled())
        return;

    VIB_StopPulse();
    {
        int i;

        for (i = 0; i < state->pulse_num; i++)
        {
            if (state->on_time[i] == 0)
            {
                return;
            }

            if (state->on_time[i] > VIB_ON_TIME_MAX)
            {
                return;
            }
        }

        for (i = 0; i < state->pulse_num - 1; i++)
        {
            if (state->off_time[i] == 0)
            {
                return;
            }

            if (state->on_time[i] > state->off_time[i])
            {
                return;
            }
        }

        if (state->rest_time < VIB_REST_TIME_MIN)
        {
            return;
        }
    }

    pulse_vib.rest_tick     = VIBi_PulseTimeToTicks(state->rest_time) - VIBi_INTR_DELAY_TICK;
    pulse_vib.repeat_num    = state->repeat_num;
    pulse_vib.current_count = 0;
    pulse_vib.current_pos   = 0;

    {
        u32 i;

        for (i = 0; i < VIB_PULSE_NUM_MAX; i++)
        {
            pulse_vib.on_tick[i]  = VIBi_PulseTimeToTicks(state->on_time[i]) - VIBi_INTR_DELAY_TICK;
            pulse_vib.off_tick[i] = VIBi_PulseTimeToTicks(state->off_time[i]) - VIBi_INTR_DELAY_TICK;
        }
    }

    pulse_vib.rest_pos  = state->pulse_num * 2 - 1;
    pulse_vib.is_enable = TRUE;

    VIBi_MotorOnOff(&pulse_vib);
}

void VIB_StopPulse(void)
{
    if (pulse_vib.is_enable)
    {
        pulse_vib.is_enable = FALSE;
        VIBi_MotorOnOff(&pulse_vib);
    }
}

BOOL VIB_IsExecuting(void)
{
    return pulse_vib.is_enable;
}

void VIB_SetCartridgePulloutCallback(VIBCartridgePulloutCallback func)
{
    pulse_vib.cartridge_pullout_callback = func;
}

BOOL VIB_IsCartridgeEnabled(void)
{
    return CTRDG_IsBitID(VIBi_BITID);
}

static inline u32 VIBi_PulseTimeToTicks(u32 pulse_time)
{
    return ((OS_SYSTEM_CLOCK / 1000) * (pulse_time)) / 64 / 10;
}

static BOOL VIBi_PulledOutCallbackCartridge(void)
{
    VIB_StopPulse();

    if (pulse_vib.cartridge_pullout_callback)
    {
        pulse_vib.cartridge_pullout_callback();
    }

    return FALSE;
}

static void VIBi_MotorOnOff(VIBiPulseInfo *pulse_vib)
{
    DC_FlushRange(pulse_vib, sizeof(VIBiPulseInfo));

    if (pulse_vib->is_enable == TRUE)
    {
        CTRDG_SendToARM7(pulse_vib);
    }
    else
    {
        CTRDG_SendToARM7(NULL);
    }
}

static void VIBi_SleepCallback(void *)
{
    VIB_StopPulse();
}