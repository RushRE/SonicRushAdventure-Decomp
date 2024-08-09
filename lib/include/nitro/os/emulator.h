#ifndef NITRO_OS_EMULATOR_H
#define NITRO_OS_EMULATOR_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL OS_IsRunOnEmulator(void);
u32 OS_GetConsoleType(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_EMULATOR_H
