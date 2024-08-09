#ifndef NITRO_GX_GX_LOAD_H
#define NITRO_GX_GX_LOAD_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

// 2D ENGINE

void GX_LoadBGPltt(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBGPltt(const void *pSrc, u32 offset, u32 szByte);

void GX_LoadOBJPltt(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadOBJPltt(const void *pSrc, u32 offset, u32 szByte);

void GX_LoadOAM(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadOAM(const void *pSrc, u32 offset, u32 szByte);

void GX_LoadOBJ(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadOBJ(const void *pSrc, u32 offset, u32 szByte);

void GX_LoadBG0Scr(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG0Scr(const void *pSrc, u32 offset, u32 szByte);
void GX_LoadBG1Scr(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG1Scr(const void *pSrc, u32 offset, u32 szByte);
void GX_LoadBG2Scr(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG2Scr(const void *pSrc, u32 offset, u32 szByte);
void GX_LoadBG3Scr(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG3Scr(const void *pSrc, u32 offset, u32 szByte);

void GX_LoadBG0Char(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG0Char(const void *pSrc, u32 offset, u32 szByte);
void GX_LoadBG1Char(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG1Char(const void *pSrc, u32 offset, u32 szByte);
void GX_LoadBG2Char(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG2Char(const void *pSrc, u32 offset, u32 szByte);
void GX_LoadBG3Char(const void *pSrc, u32 offset, u32 szByte);
void GXS_LoadBG3Char(const void *pSrc, u32 offset, u32 szByte);

// 3D ENGINE

void GX_BeginLoadTex(void);
void GX_LoadTex(const void *pSrc, u32 destSlotAddr, u32 szByte);
void GX_EndLoadTex(void);

void GX_BeginLoadTexPltt(void);
void GX_LoadTexPltt(const void *pSrc, u32 destSlotAddr, u32 szByte);
void GX_EndLoadTexPltt(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_GX_LOAD_H
