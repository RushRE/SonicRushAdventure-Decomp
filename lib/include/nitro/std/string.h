#ifndef NITRO_STD_STRING_H
#define NITRO_STD_STRING_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// MACROS
// --------------------

#define STD_StrCpy  STD_CopyString
#define STD_StrLCpy STD_CopyLString
#define STD_StrStr  STD_SearchString
#define STD_StrLen  STD_GetStringLength
#define STD_StrCat  STD_ConcatenateString
#define STD_StrCmp  STD_CompareString
#define STD_StrNCmp STD_CompareNString
#define STD_StrLCmp STD_CompareLString

// --------------------
// FUNCTIONS
// --------------------

char *STD_CopyString(char *destp, const char *srcp);
int STD_CopyLStringZeroFill(char *destp, const char *srcp, int n);
int STD_CopyLString(char *destp, const char *srcp, int siz);
char *STD_SearchString(const char *srcp, const char *str);
int STD_GetStringLength(const char *str);
char *STD_ConcatenateString(char *str1, const char *str2);
int STD_CompareString(const char *str1, const char *str2);
int STD_CompareNString(const char *str1, const char *str2, int len);
int STD_CompareLString(const char *str1, const char *str2);
int STD_TSScanf(const char *src, const char *fmt, ...);
int STD_TVSScanf(const char *src, const char *fmt, va_list vlist);
int STD_TSPrintf(char *dst, const char *fmt, ...);
int STD_TVSPrintf(char *dst, const char *fmt, va_list vlist);
int STD_TSNPrintf(char *dst, size_t len, const char *fmt, ...);
int STD_TVSNPrintf(char *dst, size_t len, const char *fmt, va_list vlist);

#ifdef __cplusplus
}
#endif

#endif // NITRO_STD_STRING_H