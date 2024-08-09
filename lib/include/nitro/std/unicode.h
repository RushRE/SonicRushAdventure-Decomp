#ifndef NITRO_STD_UNICODE_H
#define NITRO_STD_UNICODE_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum STDResult
{
    STD_RESULT_SUCCESS,
    STD_RESULT_ERROR,
    STD_RESULT_INVALID_PARAM,
    STD_RESULT_CONVERSION_FAILED
} STDResult;

// --------------------
// TYPES
// --------------------

typedef STDResult (*STDConvertUnicodeCallback)(u16 *dst, int *dst_len, const char *src, int *src_len);
typedef STDResult (*STDConvertSjisCallback)(char *dst, int *dst_len, const u16 *src, int *src_len);

// --------------------
// FUNCTIONS
// --------------------

STDResult STD_ConvertStringSjisToUnicode(u16 *dst, int *dst_len, const char *src, int *src_len, STDConvertUnicodeCallback callback);
STDResult STD_ConvertStringUnicodeToSjis(char *dst, int *dst_len, const u16 *src, int *src_len, STDConvertSjisCallback callback);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE BOOL STD_IsSjisLeadByte(int c)
{
    return ((unsigned int)((((u8)c) ^ 0x20) - 0xA1) < 0x3C);
}

SDK_INLINE BOOL STD_IsSjisTrailByte(int c)
{
    return (c != 0x7F) && ((u8)(c - 0x40) <= (0xFC - 0x40));
}

SDK_INLINE BOOL STD_IsSjisCharacter(const char *s)
{
    return STD_IsSjisLeadByte(s[0]) && STD_IsSjisTrailByte(s[1]);
}

SDK_INLINE int STD_ConvertCharSjisToUnicode(u16 *dst, const char *src)
{
    int src_len   = STD_IsSjisCharacter(src) ? 2 : 1;
    int dst_len   = 1;
    STDResult ret = STD_ConvertStringSjisToUnicode(dst, &dst_len, src, &src_len, NULL);
    return (ret == STD_RESULT_SUCCESS) ? dst_len : -1;
}

SDK_INLINE int STD_ConvertCharUnicodeToSjis(char *dst, u16 src)
{
    int src_len   = 1;
    int dst_len   = 2;
    STDResult ret = STD_ConvertStringUnicodeToSjis(dst, &dst_len, &src, &src_len, NULL);
    return (ret == STD_RESULT_SUCCESS) ? dst_len : -1;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_STD_UNICODE_H
