#ifndef NITRO_OS_COMMON_ENTROPY_H
#define NITRO_OS_COMMON_ENTROPY_H

// --------------------
// CONSTANTS
// --------------------

#define OS_LOW_ENTROPY_DATA_SIZE 32

// --------------------
// FUNCTIONS
// --------------------

void OS_GetLowEntropyData(u32 buffer[OS_LOW_ENTROPY_DATA_SIZE / sizeof(u32)]);

#endif // NITRO_OS_COMMON_ENTROPY_H
