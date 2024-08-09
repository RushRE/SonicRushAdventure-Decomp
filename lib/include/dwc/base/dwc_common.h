#ifndef DWC_COMMON_H
#define DWC_COMMON_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define DWC_COMMONSTR_MAX_KEY_VALUE_LEN 4096

// --------------------
// FUNCTIONS
// --------------------

int DWC_SetCommonKeyValueString(const char *key, const char *value, char *string, char separator);
int DWC_AddCommonKeyValueString(const char *key, const char *value, char *string, char separator);
int DWC_GetCommonValueString(const char *key, char *value, const char *string, char separator);

u32 DWCi_GetMathRand32(u32 max);
u32 DWCi_WStrLen(const u16 *str);

#ifdef __cplusplus
}
#endif

#endif // DWC_COMMON_H