#ifndef RUSH_TALKHELPERSUNKNOWN_H
#define RUSH_TALKHELPERSUNKNOWN_H

#include <game/graphics/background.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

typedef struct TalkHelpersUnknown_
{
    u32 flags;
    u32 field_4;
    Vec2Fx16 field_8;
    u16 field_C;
    u16 field_E;
    u16 useEngineB;
    u16 bgID;
    u16 field_14;
    u16 field_16;
    u16 *mappings;
    void *field_1C;
    Background *background;
} TalkHelpersUnknown;

// --------------------
// FUNCTIONS
// --------------------

// TalkHelpersUnknown
NOT_DECOMPILED void TalkHelpers__Func_2152F98(TalkHelpersUnknown *work);
NOT_DECOMPILED void TalkHelpersUnknown__Init(TalkHelpersUnknown *work, void *background, u16 flags, u16 useEngineB, u16 bgID, u16 paletteRow);
NOT_DECOMPILED void TalkHelpersUnknown__Release(TalkHelpersUnknown *work);
NOT_DECOMPILED void TalkHelpers__Func_21530A8(TalkHelpersUnknown *work);
NOT_DECOMPILED void TalkHelpers__Func_215332C(TalkHelpersUnknown *work, s16 x, s16 y);
NOT_DECOMPILED void TalkHelpers__Func_2153338(TalkHelpersUnknown *work, s32 a2);
NOT_DECOMPILED void TalkHelpers__Func_2153350(TalkHelpersUnknown *work, s16 a2);
NOT_DECOMPILED void TalkHelpers__Func_2153388(TalkHelpersUnknown *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_TALKHELPERSUNKNOWN_H