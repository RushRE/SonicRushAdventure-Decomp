#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

static u32 sTexLCDCBlk1       = 0;
static u32 sSzTexBlk1         = 0;
static u32 sTexLCDCBlk2       = 0;
static GXVRamTex sTex         = (GXVRamTex)(0);
static GXVRamTexPltt sTexPltt = (GXVRamTexPltt)(0);
static u32 sTexPlttLCDCBlk    = 0;

static const struct
{
    u16 blk1;   // 12 bit shift
    u16 blk2;   // 12 bit shift
    u16 szBlk1; // 12 bit shift
} sTexStartAddrTable[16] = {
    { 0, 0, 0 },                                                                                                  // GX_VRAM_TEX_NONE
    { (u16)(HW_LCDC_VRAM_A >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_0_A
    { (u16)(HW_LCDC_VRAM_B >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_0_B
    { (u16)(HW_LCDC_VRAM_A >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_01_AB
    { (u16)(HW_LCDC_VRAM_C >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_0_C
    { (u16)(HW_LCDC_VRAM_A >> 12), (u16)(HW_LCDC_VRAM_C >> 12), (u16)(HW_VRAM_A_SIZE >> 12) },                    // GX_VRAM_TEX_01_AC
    { (u16)(HW_LCDC_VRAM_B >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_01_BC
    { (u16)(HW_LCDC_VRAM_A >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_012_ABC
    { (u16)(HW_LCDC_VRAM_D >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_0_D
    { (u16)(HW_LCDC_VRAM_A >> 12), (u16)(HW_LCDC_VRAM_D >> 12), (u16)(HW_VRAM_A_SIZE >> 12) },                    // GX_VRAM_TEX_01_AD
    { (u16)(HW_LCDC_VRAM_B >> 12), (u16)(HW_LCDC_VRAM_D >> 12), (u16)(HW_VRAM_B_SIZE >> 12) },                    // GX_VRAM_TEX_01_BD
    { (u16)(HW_LCDC_VRAM_A >> 12), (u16)(HW_LCDC_VRAM_D >> 12), (u16)((HW_VRAM_A_SIZE + HW_VRAM_B_SIZE) >> 12) }, // GX_VRAM_TEX_012_ABD
    { (u16)(HW_LCDC_VRAM_C >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_01_CD
    { (u16)(HW_LCDC_VRAM_A >> 12), (u16)(HW_LCDC_VRAM_C >> 12), (u16)(HW_VRAM_A_SIZE >> 12) },                    // GX_VRAM_TEX_012_ACD
    { (u16)(HW_LCDC_VRAM_B >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_012_BCD
    { (u16)(HW_LCDC_VRAM_A >> 12), 0, 0 },                                                                        // GX_VRAM_TEX_0123_ABCD
};

static const u16 sTexPlttStartAddrTable[8] = {
    0,                           // GX_VRAM_TEXPLTT_NONE
    (u16)(HW_LCDC_VRAM_E >> 12), // GX_VRAM_TEXPLTT_0123_E
    (u16)(HW_LCDC_VRAM_F >> 12), // GX_VRAM_TEXPLTT_0_F
    (u16)(HW_LCDC_VRAM_E >> 12), // GX_VRAM_TEXPLTT_01234_EF
    (u16)(HW_LCDC_VRAM_G >> 12), // GX_VRAM_TEXPLTT_0_G
    0,                           // forbidden(GX_VRAM_TEXPLTT_0_EG)
    (u16)(HW_LCDC_VRAM_F >> 12), // GX_VRAM_TEXPLTT_01_FG
    (u16)(HW_LCDC_VRAM_E >> 12)  // GX_VRAM_TEXPLTT_012345_EFG
};

// --------------------
// FUNCTIONS
// --------------------

void GX_BeginLoadTex(void)
{
    // Texture slots to LCDC
    sTex = GX_ResetBankForTex();

    sTexLCDCBlk1 = (u32)(sTexStartAddrTable[sTex].blk1 << 12);
    sTexLCDCBlk2 = (u32)(sTexStartAddrTable[sTex].blk2 << 12);
    sSzTexBlk1   = (u32)(sTexStartAddrTable[sTex].szBlk1 << 12);
}

void GX_LoadTex(const void *pSrc, u32 destSlotAddr, u32 szByte)
{
    void *pLCDC;

    if (0 == sTexLCDCBlk2)
    {
        // continuous on LCDC address space
        pLCDC = (void *)(sTexLCDCBlk1 + destSlotAddr);
    }
    else
    {
        // two discontinuous blocks on LCDC address space
        if (destSlotAddr + szByte < sSzTexBlk1)
        {
            pLCDC = (void *)(sTexLCDCBlk1 + destSlotAddr);
        }
        else if (destSlotAddr >= sSzTexBlk1)
        {
            pLCDC = (void *)(sTexLCDCBlk2 + destSlotAddr - sSzTexBlk1);
        }
        else
        {
            // cross the boundary
            void *pLCDC2 = (void *)sTexLCDCBlk2;
            u32 sz       = sSzTexBlk1 - destSlotAddr;
            pLCDC        = (void *)(sTexLCDCBlk1 + destSlotAddr);

            GXi_DmaCopy32(GXi_DmaId, pSrc, pLCDC, sz);
            GXi_DmaCopy32Async(GXi_DmaId, (void *)((u8 *)pSrc + sz), pLCDC2, szByte - sz, NULL, NULL);
            return;
        }
    }

    // DMA Transfer
    GXi_DmaCopy32Async(GXi_DmaId, pSrc, pLCDC, szByte, NULL, NULL);
}

void GX_EndLoadTex(void)
{
    GXi_WaitDma(GXi_DmaId);

    GX_SetBankForTex(sTex);

    sTexLCDCBlk1 = sTexLCDCBlk2 = sSzTexBlk1 = 0;
    sTex                                     = (GXVRamTex)0;
}

void GX_BeginLoadTexPltt(void)
{
    sTexPltt = GX_ResetBankForTexPltt();

    sTexPlttLCDCBlk = (u32)(sTexPlttStartAddrTable[sTexPltt >> 4] << 12);
}

void GX_LoadTexPltt(const void *pSrc, u32 destSlotAddr, u32 szByte)
{
    GXi_DmaCopy32Async(GXi_DmaId, pSrc, (void *)(sTexPlttLCDCBlk + destSlotAddr), szByte, NULL, NULL);
}

void GX_EndLoadTexPltt(void)
{
    GXi_WaitDma(GXi_DmaId);

    GX_SetBankForTexPltt(sTexPltt);

    sTexPltt        = (GXVRamTexPltt)0;
    sTexPlttLCDCBlk = 0;
}