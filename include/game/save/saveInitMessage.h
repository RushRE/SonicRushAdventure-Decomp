#ifndef RUSH_SAVEINITMESSAGE_H
#define RUSH_SAVEINITMESSAGE_H

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

#endif // RUSH_SAVEINITMESSAGE_H
