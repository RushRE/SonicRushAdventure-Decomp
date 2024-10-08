#ifndef G2DI_CHAR_H
#define G2DI_CHAR_H

#ifdef __cplusplus
extern "C"
{
#endif

#ifdef NNS_G2D_UNICODE
#define NNS_G2D_TRANSCODE(str) L##str
typedef wchar_t NNSG2dChar;
#else
#define NNS_G2D_TRANSCODE(str) str
typedef char NNSG2dChar;
#endif

#ifdef __cplusplus
}
#endif

#endif // G2DI_CHAR_H