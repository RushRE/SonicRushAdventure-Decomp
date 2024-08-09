#ifndef RUSH2_CORRUPTSAVEWARNING_H
#define RUSH2_CORRUPTSAVEWARNING_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>

// --------------------
// ENUMS
// --------------------

enum FileList_ArchiveDM_SAVE_ERROR
{
    ARC_DM_SAVE_ERROR_FILE_DMCMN_FIX_NEXT_BAC,
    ARC_DM_SAVE_ERROR_FILE_DM_SAVE_ERROR_JPN_MPC,
    ARC_DM_SAVE_ERROR_FILE_DM_SAVE_ERROR_ENG_MPC,
    ARC_DM_SAVE_ERROR_FILE_DM_SAVE_ERROR_FRA_MPC,
    ARC_DM_SAVE_ERROR_FILE_DM_SAVE_ERROR_DEU_MPC,
    ARC_DM_SAVE_ERROR_FILE_DM_SAVE_ERROR_ITA_MPC,
    ARC_DM_SAVE_ERROR_FILE_DM_SAVE_ERROR_SPA_MPC
};

// --------------------
// STRUCTS
// --------------------

typedef struct CorruptSaveWarning_
{
    void *fontPtr;
    void *archive;
    FontWindow fontWindow;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    AnimatorSprite aniButtonPrompt;
} CorruptSaveWarning;

// --------------------
// FUNCTIONS
// --------------------

void CreateCorruptSaveWarning(void);

#endif // RUSH2_CORRUPTSAVEWARNING_H
