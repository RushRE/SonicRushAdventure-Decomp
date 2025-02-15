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
    hub->state.hubType        = -1;
    hub->state.hubArea        = -1;
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

void HubState__SetPlayerState(s32 id, const VecFx32 *pos, u16 angle)
{
    MI_CpuClear32(&gameState.talk.state.player[id], sizeof(gameState.talk.state.player[id]));

    gameState.talk.state.player[id].flags |= 1;
    gameState.talk.state.player[id].translation = *pos;
    gameState.talk.state.player[id].rotationY   = angle;
}

BOOL HubState__CheckHasPlayerState(s32 id)
{
    if ((gameState.talk.state.player[id].flags & 1) != 0)
        return TRUE;
    else
        return FALSE;
}

VecFx32 *HubState__GetPlayerPosition(s32 id)
{
    return &gameState.talk.state.player[id].translation;
}

u16 HubState__GetPlayerAngle(s32 id)
{
    return gameState.talk.state.player[id].rotationY;
}

void HubState__SetNpcState(s32 id, const VecFx32 *pos, u16 angle, s32 talkCount)
{
    MI_CpuClear32(&gameState.talk.state.npc[id], sizeof(gameState.talk.state.npc[id]));

    gameState.talk.state.npc[id].flags |= 1;
    gameState.talk.state.npc[id].translation = *pos;
    gameState.talk.state.npc[id].rotationY   = angle;
    gameState.talk.state.npc[id].talkCount    = -1;
}

BOOL HubState__CheckHasNpcState(s32 id)
{
    if ((gameState.talk.state.npc[id].flags & 1) != 0)
        return TRUE;
    else
        return FALSE;
}

VecFx32 *HubState__GetNpcPosition(s32 id)
{
    return &gameState.talk.state.npc[id].translation;
}

s32 HubState__GetNpcAngle(s32 id)
{
    return gameState.talk.state.npc[id].rotationY;
}

s32 HubState__GetNpcTalkCount(s32 id)
{
    return gameState.talk.state.npc[id].talkCount;
}

u8 HubState__GetHubStartAction(void)
{
    return gameState.talk.state.hubStartAction;
}
