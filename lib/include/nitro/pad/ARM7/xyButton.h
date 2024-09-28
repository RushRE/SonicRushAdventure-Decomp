#ifndef NITRO_PAD_XYBUTTON_H
#define NITRO_PAD_XYBUTTON_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// VARIABLES
// --------------------

extern BOOL PADi_XYButtonAvailable;

// --------------------
// FUNCTIONS
// --------------------

BOOL PAD_InitXYButton(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline BOOL PAD_IsXYButtonAvailable(void)
{
    return PADi_XYButtonAvailable;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_PAD_XYBUTTON_H
