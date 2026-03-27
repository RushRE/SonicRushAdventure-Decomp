#ifndef RUSH_PIPE_H
#define RUSH_PIPE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Pipe_
{
    GameObjectTask gameWork;
} Pipe;
typedef Pipe FlowerPipe; // from Plant Kingdom
typedef Pipe SteamPipe;  // from Machine Labyrinth

// --------------------
// ENUMS
// --------------------

enum PipeType
{
    PIPE_TYPE_FLOWER,
    PIPE_TYPE_STEAM,
    PIPE_TYPE_COUNT
};

// --------------------
// FUNCTIONS
// --------------------

FlowerPipe *FlowerPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
SteamPipe *SteamPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void Pipe__State_PlayerNotEntered(Pipe *work);
void Pipe__OnDefend_Exit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void FlowerPipe__OnDefend_Enter(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void FlowerPipe__OnDefend_Exit_FreezePlayerBeforeLaunch(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void FlowerPipe__OnDefend_Exit_LaunchSeedsAndPetals(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void SteamPipe__State_WaitToCloseEntrance(SteamPipe *work);
void SteamPipe__State_Exit_WaitToShowSteamAndDust(SteamPipe *work);
void SteamPipe__State_Exit_PlayerLaunchedOut(SteamPipe *work);
void SteamPipe__OnDefend_Enter(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SteamPipe__OnDefend_Exit_FreezePlayerAndOpenDoor(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_PIPE_H
