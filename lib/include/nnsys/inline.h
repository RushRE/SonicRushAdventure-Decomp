#ifndef NNS_INLINE_H
#define NNS_INLINE_H

#if defined(_MSC_VER) || defined(NNS_FROM_TOOL)
#define NNS_INLINE __inline
#else
#define NNS_INLINE inline
#endif

#endif // NNS_INLINE_H
