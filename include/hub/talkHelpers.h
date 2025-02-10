#ifndef RUSH_TALKHELPERS_H
#define RUSH_TALKHELPERS_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum TalkInteraction
{
    TALKINTERACTION_TAILS,
    TALKINTERACTION_MARINE,
    TALKINTERACTION_BLAZE,
    TALKINTERACTION_TABBY,
    TALKINTERACTION_COLONEL,
    TALKINTERACTION_SETTER,
    TALKINTERACTION_COLONEL_2,
    TALKINTERACTION_7,
    TALKINTERACTION_8,
    TALKINTERACTION_TAILS_2,
    TALKINTERACTION_MARINE_2,
    TALKINTERACTION_TABBY_2,
    TALKINTERACTION_KYLOK,
    TALKINTERACTION_COLONEL_3,
    TALKINTERACTION_GARDON,
    TALKINTERACTION_NORMAN,
    TALKINTERACTION_COLONEL_4,
    TALKINTERACTION_DAIKUN,
    TALKINTERACTION_COLONEL_5,
    TALKINTERACTION_DAIKUN_2,
    TALKINTERACTION_TABBY_3,
    TALKINTERACTION_MUZY,

    TALKINTERACTION_COUNT,
};

// --------------------
// FUNCTIONS
// --------------------

// TalkHelpers
u16 TalkHelpers__GetInteractionCtrl(s32 id);
u16 TalkHelpers__GetInteractionText1(s32 id);
u16 TalkHelpers__GetInteractionText2(s32 id);
u16 TalkHelpers__GetInteractionText3(s32 id);
u16 TalkHelpers__GetInteractionText4(s32 id);
u16 TalkHelpers__GetInteraction0ID(s32 id);

#ifdef __cplusplus
}
#endif

#endif // RUSH_TALKHELPERS_H