
#include <ex/boss/exBoss.h>

// --------------------
// VARIABLES
// --------------------

static BOOL sIsBossFleeing;

// --------------------
// FUNCTION DECLS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

BOOL ExBoss_IsBossFleeing(void)
{
    return sIsBossFleeing;
}

void ExBoss_SetBossFleeing(BOOL isFleeing)
{
    sIsBossFleeing = isFleeing;
}