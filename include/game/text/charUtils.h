
#ifndef RUSH_CHARUTILS_H
#define RUSH_CHARUTILS_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// MACROS
// --------------------

// as far as I'm aware: MWCC is unable to properly compile unicode character constants?
// so for those cases, let's use this macro to keep the code as readable as possible!
#define UNICODE_CHAR(char, charCode) (charCode)

#ifdef __cplusplus
}
#endif

#endif // RUSH_CHARUTILS_H
