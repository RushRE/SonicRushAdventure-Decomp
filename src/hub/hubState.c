#include <hub/hubState.h>
#include <game/game/gameState.h>

// --------------------
// FUNCTIONS
// --------------------

// HubState
void ResetHubState(void)
{
    struct GameTalkState *hub = &gameState.talk;
    MI_CpuClear32(&hub->state, sizeof(hub->state));
    
    hub->state.hubStartAction = 0;
    hub->state.hubType = -1;
    hub->state.hubArea = -1;
}

void HubState__SetHubType(u8 type)
{
    gameState.talk.state.hubType = type;
}

u8 HubState__GetHubType(void)
{
    return gameState.talk.state.hubType;
}

void HubState__SetHubArea(u8 area)
{
    gameState.talk.state.hubArea = area;
}

u8 HubState__GetHubArea(void)
{
    return gameState.talk.state.hubArea;
}

void HubState__SetPlayerState(s32 id, VecFx32 *pos, u16 angle)
{
    MI_CpuClear32(&gameState.talk.state.field_E0[id], sizeof(gameState.talk.state.field_E0[id]));

    gameState.talk.state.field_E0[id].field_E |= 1;
    gameState.talk.state.field_E0[id].translation = *pos;
    gameState.talk.state.field_E0[id].rotationY   = angle;
}

BOOL HubState__CheckHasPlayerState(s32 id)
{
    if ((gameState.talk.state.field_E0[id].field_E & 1) != 0)
        return TRUE;
    else
        return FALSE;
}

VecFx32 *HubState__GetPlayerPosition(s32 id)
{
    return &gameState.talk.state.field_E0[id].translation;
}

u16 HubState__GetPlayerAngle(s32 id)
{
    return gameState.talk.state.field_E0[id].rotationY;
}

void HubState__SetNpcState(s32 id, VecFx32 *pos, u16 angle, s32 unknown)
{
    MI_CpuClear32(&gameState.talk.state.field_14[id], sizeof(gameState.talk.state.field_14[id]));

    gameState.talk.state.field_14[id].flags |= 1;
    gameState.talk.state.field_14[id].translation = *pos;
    gameState.talk.state.field_14[id].field_C     = angle;
    gameState.talk.state.field_14[id].field_10    = -1;
}

BOOL HubState__CheckHasNpcState(s32 id)
{
    if ((gameState.talk.state.field_14[id].flags & 1) != 0)
        return TRUE;
    else
        return FALSE;
}

VecFx32 *HubState__GetNpcPosition(s32 id)
{
    return &gameState.talk.state.field_14[id].translation;
}

s32 HubState__GetNpcAngle(s32 id)
{
    return gameState.talk.state.field_14[id].field_C;
}

s32 HubState__GetNpcUnknown(s32 id)
{
    return gameState.talk.state.field_14[id].field_10;
}

u8 HubState__GetHubStartAction(void)
{
    return gameState.talk.state.hubStartAction;
}
