#ifndef RUSH_SEAMAPCUTSCENE_H
#define RUSH_SEAMAPCUTSCENE_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>
#include <seaMap/seaMapEventManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapCutscene_
{
    u32 flags;
    s16 brightness;
    void (*stateActive)(struct SeaMapCutscene_ *work);
    void (*stateAlways)(struct SeaMapCutscene_ *work);

    union
    {
        struct
        {
            u16 timer;
        } coralCave;

        struct
        {
            SeaMapObject *boat;
            s32 startPos;
            s32 targetPos;
            s32 targetY;
            s16 percent;
            u16 timer;
        } skyBabylon;
    };

    u16 pressStartFlashTimer;
    u16 pressedStartTimer;
    TouchField touchField;
    TouchArea touchArea;
    AnimatorSprite aniPressStart;
    AnimatorSprite aniPressStartButton;
    void *bgCutscene;
    void *sprPressStartButton;
    void *sprPressStartText;
} SeaMapCutscene;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapCutscene(void);

#endif // RUSH_SEAMAPCUTSCENE_H