#ifndef RUSH2_TUTORIAL_H
#define RUSH2_TUTORIAL_H

#include <stage/gameObject.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindow.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Tutorial_
{
    GameObjectTask gameWork;
    s16 sectionID;
    s16 nextSection;
    u32 sectionFlags;
    fx32 nextSectionWidth;
    fx32 boundsL;
    fx32 boundsR;
    void (*stateScroll)(struct Tutorial_ *work);
    void (*stateTalk)(struct Tutorial_ *work);
    void (*statePlayer)(struct Tutorial_ *work);
    u32 playerActionFlags;
    s32 tensionRefillTimer;
    u32 flags;
    FontWindow fontWindow;
    FontAnimator fontAnimator;
    FontUnknown2058D78 fontUnknown;
    FontWindowAnimator fontWindowAnimator[2];
    FontWindowMWControl fontMWControl;
    Vec2Fx16 characterIconPos;
    AnimatorSpriteDS aniObjectiveIcons[6];
    Vec2Fx16 iconPositions[6][2];
    s8 iconCount[6];
    AnimatorSpriteDS aniNextPrompt;
    void (*stateBtnPrompt)(struct Tutorial_ *work);
    AnimatorSpriteDS aniKeys[3];
    s32 timer;
    u16 promptIconAngle;
    s16 field_CFA;
    Vec2Fx32 promptIconPos;
    s32 selection;
    s32 field_D08;
} Tutorial;

typedef struct TutorialCheckpoint_
{
    GameObjectTask gameWork;
} TutorialCheckpoint;

// --------------------
// FUNCTIONS
// --------------------

Tutorial *CreateTutorial(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
TutorialCheckpoint *CreateTutorialCheckpoint(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

// Misc
void SetTutorialEnemyDestroy(void);
BOOL CheckTutorialInactive(void);

#endif // RUSH2_TUTORIAL_H