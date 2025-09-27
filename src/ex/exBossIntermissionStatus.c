
#include <ex/boss/exBoss.h>

// --------------------
// VARIABLES
// --------------------

static BOOL ExBoss_isBossFleeing;

// --------------------
// FUNCTION DECLS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

BOOL ExBoss_IsBossFleeing(void)
{
    return ExBoss_isBossFleeing;
}

void ExBoss_SetBossFleeing(BOOL isFleeing)
{
    ExBoss_isBossFleeing = isFleeing;
}