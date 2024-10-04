#include <game/graphics/bankUnknown.h>

// --------------------
// FUNCTIONS
// --------------------

BankUnknownBank BankUnknown__GetBankID(u32 bank)
{
    if ((bank & GX_GetBankForBG()) != 0)
        return BANKUNKNOWN_BANK_BG;

    if ((bank & GX_GetBankForOBJ()) != 0)
        return BANKUNKNOWN_BANK_OBJ;

    if ((bank & GX_GetBankForBGExtPltt()) != 0)
        return BANKUNKNOWN_BANK_BG_EXT_PLTT;

    if ((bank & GX_GetBankForOBJExtPltt()) != 0)
        return BANKUNKNOWN_BANK_OBJ_EXT_PLTT;

    if ((bank & GX_GetBankForTex()) != 0)
        return BANKUNKNOWN_BANK_TEX;

    if ((bank & GX_GetBankForTexPltt()) != 0)
        return BANKUNKNOWN_BANK_TEX_PLTT;

    if ((bank & GX_GetBankForClearImage()) != 0)
        return BANKUNKNOWN_BANK_CLEAR_IMAGE;

    if ((bank & GX_GetBankForSubBG()) != 0)
        return BANKUNKNOWN_BANK_SUB_BG;

    if ((bank & GX_GetBankForSubOBJ()) != 0)
        return BANKUNKNOWN_BANK_SUB_OBJ;

    if ((bank & GX_GetBankForSubBGExtPltt()) != 0)
        return BANKUNKNOWN_BANK_SUB_BG_EXT_PLTT;

    if ((bank & GX_GetBankForSubOBJExtPltt()) != 0)
        return BANKUNKNOWN_BANK_SUB_OBJ_EXT_PLTT;

    if ((bank & GX_GetBankForARM7()) != 0)
        return BANKUNKNOWN_BANK_ARM7;
        
    if ((bank & GX_GetBankForLCDC()) != 0)
        return BANKUNKNOWN_BANK_LCDC;

    return BANKUNKNOWN_BANK_NONE;
}