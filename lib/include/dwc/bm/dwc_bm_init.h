#ifndef DWC_BM_INIT_H
#define DWC_BM_INIT_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define DWC_BM_INIT_WORK_SIZE 0x700
#define DWC_INIT_WORK_SIZE    0x700

// --------------------
// FUNCTIONS
// --------------------

int DWC_BM_Init(void *work);

#ifdef __cplusplus
}
#endif

#endif // DWC_BM_INIT_H
