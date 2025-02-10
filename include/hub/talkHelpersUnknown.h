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
NOT_DECOMPILED void TalkHelpers__Func_2152F98(void);
NOT_DECOMPILED void TalkHelpersUnknown__Init(void);
NOT_DECOMPILED void TalkHelpers__Func_2153064(void);
NOT_DECOMPILED void TalkHelpers__Func_21530A8(void);
NOT_DECOMPILED void TalkHelpers__Func_215332C(void);
NOT_DECOMPILED void TalkHelpers__Func_2153338(void);
NOT_DECOMPILED void TalkHelpers__Func_2153350(void);
NOT_DECOMPILED void TalkHelpers__Func_2153388(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_TALKHELPERSUNKNOWN_H