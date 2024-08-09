#ifndef NITRO_STD_STRING_H
#define NITRO_STD_STRING_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// MACROS
// --------------------

#define STD_StrCpy     STD_CopyString
#define STD_StrLCpy    STD_CopyLString
#define STD_StrStr     STD_SearchString
#define STD_StrLen     STD_GetStringLength
#define STD_StrCat     STD_ConcatenateString
#define STD_StrCmp     STD_CompareString
#define STD_StrNCmp    STD_CompareNString

// --------------------
// FUNCTIONS
// --------------------

extern char * STD_CopyString(char * destp, const char * srcp);
extern int STD_CopyLString(char * destp, const char * srcp, int siz);
extern char * STD_SearchString(const char * srcp, const char * str);
extern int STD_GetStringLength(const char * str);
extern char * STD_ConcatenateString(char * str1, const char * str2);
extern int STD_CompareString(const char * str1, const char * str2);
extern int STD_CompareNString(const char * str1, const char * str2, int len);

#ifdef __cplusplus
}
#endif

#endif // NITRO_STD_STRING_H