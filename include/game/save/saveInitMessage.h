#ifndef RUSH2_SAVEINITMESSAGE_H
#define RUSH2_SAVEINITMESSAGE_H

#include <game/save/saveInitManager.h>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>

// --------------------
// ENUMS
// --------------------

enum GameInitMessageTypes_
{
    GAMEINIT_MSG_REFORMATTING,
    GAMEINIT_MSG_CORRUPTED,
    GAMEINIT_MSG_LOADING,
};
typedef u32 GameInitMessageTypes;

enum FileList_BundleDMWF_LANG
{
    BUNDLE_DMWF_LANG_FILE_FILE_0_NARC,
    BUNDLE_DMWF_LANG_FILE_FILE_1_NARC,
    BUNDLE_DMWF_LANG_FILE_FILE_2_NARC,
    BUNDLE_DMWF_LANG_FILE_FILE_3_NARC,
    BUNDLE_DMWF_LANG_FILE_FILE_4_NARC,
    BUNDLE_DMWF_LANG_FILE_FILE_5_NARC,
    BUNDLE_DMWF_LANG_FILE_FILE_6_NARC
};

enum FileList_BundleDMWF_LANG_FILE_6
{
    ARC_FILE_6_FILE_DMWF_CMN_BAC
};

enum FileList_ArchiveDMBL
{
    ARC_DMBL_FILE_MSG_JPN_MPC,
    ARC_DMBL_FILE_MSG_ENG_MPC,
    ARC_DMBL_FILE_MSG_FRA_MPC,
    ARC_DMBL_FILE_MSG_DEU_MPC,
    ARC_DMBL_FILE_MSG_ITA_MPC,
    ARC_DMBL_FILE_MSG_SPA_MPC
};

// --------------------
// STRUCTS
// --------------------

typedef struct SaveInitMessage_
{
    SaveInitManager *parent;
    void *dmblArchive;
    void *dmwfLangArchive;
    void *fontPtr;
    FontWindow fontWindow;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    AnimatorSprite aniSprite;
} SaveInitMessage;

// --------------------
// FUNCTIONS
// --------------------

void CreateSaveInitMessage(SaveInitManager *parent, GameInitMessageTypes type);

#endif // RUSH2_SAVEINITMESSAGE_H
