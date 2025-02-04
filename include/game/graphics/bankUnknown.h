#ifndef RUSH_BANKUNKNOWN_H
#define RUSH_BANKUNKNOWN_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum BankUnknownBank_
{
    BANKUNKNOWN_BANK_BG,
    BANKUNKNOWN_BANK_OBJ,
    BANKUNKNOWN_BANK_BG_EXT_PLTT,
    BANKUNKNOWN_BANK_OBJ_EXT_PLTT,
    BANKUNKNOWN_BANK_TEX,
    BANKUNKNOWN_BANK_TEX_PLTT,
    BANKUNKNOWN_BANK_CLEAR_IMAGE,
    BANKUNKNOWN_BANK_SUB_BG,
    BANKUNKNOWN_BANK_SUB_OBJ,
    BANKUNKNOWN_BANK_SUB_BG_EXT_PLTT,
    BANKUNKNOWN_BANK_SUB_OBJ_EXT_PLTT,
    BANKUNKNOWN_BANK_ARM7,
    BANKUNKNOWN_BANK_LCDC,
    BANKUNKNOWN_BANK_UNKNOWN,
    BANKUNKNOWN_BANK_NONE,
};
typedef u8 BankUnknownBank;

// --------------------
// FUNCTIONS
// --------------------

BankUnknownBank BankUnknown__GetBankID(u32 bank);

#ifdef __cplusplus
}
#endif

#endif // RUSH_BANKUNKNOWN_H