#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

void GX_LoadBGPltt(const void *pSrc, u32 offset, u32 szByte)
{
    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(HW_BG_PLTT + offset), szByte);
}

void GXS_LoadBGPltt(const void *pSrc, u32 offset, u32 szByte)
{
    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(HW_DB_BG_PLTT + offset), szByte);
}

void GX_LoadOBJPltt(const void *pSrc, u32 offset, u32 szByte)
{
    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(HW_OBJ_PLTT + offset), szByte);
}

void GXS_LoadOBJPltt(const void *pSrc, u32 offset, u32 szByte)
{
    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(HW_DB_OBJ_PLTT + offset), szByte);
}

void GX_LoadOAM(const void *pSrc, u32 offset, u32 szByte)
{
    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(HW_OAM + offset), szByte);
}

void GXS_LoadOAM(const void *pSrc, u32 offset, u32 szByte)
{
    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(HW_DB_OAM + offset), szByte);
}

void GX_LoadOBJ(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetOBJCharPtr();

    GX_RegionCheck_OBJ(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadOBJ(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetOBJCharPtr();

    GX_RegionCheck_SubOBJ(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG0Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG0ScrPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG0Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG0ScrPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG1Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG1ScrPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG1Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG1ScrPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG2Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG2ScrPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG2Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG2ScrPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG3Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG3ScrPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG3Scr(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG3ScrPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy16(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG0Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG0CharPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG0Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG0CharPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG1Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG1CharPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG1Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG1CharPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG2Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG2CharPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG2Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG2CharPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GX_LoadBG3Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2_GetBG3CharPtr();

    GX_RegionCheck_BG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}

void GXS_LoadBG3Char(const void *pSrc, u32 offset, u32 szByte)
{
    u32 ptr;

    ptr = (u32)G2S_GetBG3CharPtr();

    GX_RegionCheck_SubBG(ptr + offset, ptr + offset + szByte);

    GXi_DmaCopy32(GXi_DmaId, pSrc, (void *)(ptr + offset), szByte);
}