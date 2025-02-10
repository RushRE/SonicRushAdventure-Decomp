#ifndef RUSH_CVIMAP_HPP
#define RUSH_CVIMAP_HPP

#include <hub/hubTask.hpp>
#include <hub/cviMapBack.hpp>
#include <hub/cviMapIcon.hpp>
#include <game/graphics/sprite.h>
#include <game/graphics/unknown2056C5C.h>
#include <hub/talkHelpersUnknown.h>
#include <hub/talkHelpersUnknown2.h>

// --------------------
// STRUCTS
// --------------------

class CViMap
{
public:
    CViMap();
    virtual ~CViMap();

    // --------------------
    // VARIABLES
    // --------------------

    CViMapBack mapBack;
    CViMapIcon mapIcon;
    u16 field_7C0;
    u16 field_7C2;
    u16 field_7C4;
    u16 field_7C6;
    u16 field_7C8;
    u16 field_7CA;
    u16 field_7CC;
    u16 field_7CE;
    u16 field_7D0;
    u16 field_7D2;
    s32 field_7D4;
    s32 field_7D8;
    s32 field_7DC;
    s32 field_7E0;
    s32 field_7E4;
    s32 field_7E8;
    s32 field_7EC;
    s32 field_7F0;
    s32 field_7F4;
    s32 field_7F8;
    s32 field_7FC;
    s32 field_800;
    s32 field_804;
    s32 field_808;
    s32 field_80C;
    AnimatorSprite aniMaterialIcon[9];
    AnimatorSprite aniRingIcon;
    AnimatorSprite aniSparkle[8];
    Vec2Fx16 sparklePos[8];
    TalkHelpersUnknown talkUnknown;
    TalkHelpersUnknown2 talkUnknown2;
    Unknown2056FDC unknown;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void ViMap__Create(void);
void ViMap__CreateInternal(void);
void ViMap__Func_215BAF0(void);
void ViMap__Func_215BB28(s32 a1);
void ViMap__Func_215BBAC(u16 x, u16 y);
void ViMap__Func_215BBF4(void);
void ViMap__Func_215BC40(u16 *x, u16 *y);
s32 ViMap__Func_215BC80(void);
s32 ViMap__Func_215BCA0(s32 a1);
void ViMap__Func_215BCE4(u32 a1, s32 a2);
s32 ViMap__Func_215BDCC(void);
void ViMap__Func_215BE14(s32 a1);
void ViMap__Func_215BFC4(s32 a1);
void ViMap__Func_215C0D8(s32 a1);
void ViMap__Func_215C284(s32 a1);
void ViMap__Func_215C408(void);
BOOL ViMap__Func_215C48C(void);
void ViMap__Func_215C4CC(void);
BOOL ViMap__Func_215C4F8(void);
void ViMap__Func_215C524(s32 a1);
void ViMap__Func_215C58C(u16 a1);
void ViMap__Func_215C638(s32 a1);
void ViMap__Func_215C6AC(void);
void ViMap__Func_215C76C(s32 a1);
void ViMap__Func_215C7E0(void);
void ViMap__Func_215C82C(void);
void ViMap__Func_215C84C(s32 a1);
void ViMap__Func_215C878(s16 x, s16 y);
void ViMapPaletteAnimation__Create(void);
void ViMap__Func_215C960(void);
AnimatorSprite *ViMap__Func_215C98C(u16 id);
void ViMap__Func_215C9B4(void);
void ViMap__Func_215CA1C(void);
void ViMap__Func_215CA60(void);
void ViMap__Func_215CA84(void);
void ViMap__Func_215CC14(void);
void ViMap__Func_215CC94(void);
void ViMap__Main(void);
void ViMap__Func_215CDE0(void);
void ViMap__Destructor(Task *task);
void ViMap__Func_215D150(void);
void ViMapPaletteAnimation__Main(void);
void ViMapPaletteAnimation__Destructor(Task *task);
void ViMap__Func_215D214(void);
void ViMap__Func_215D27C(void);
void ViMap__Func_215D2B4(void);
void ViMap__Func_215D374(void);
void ViMap__Func_215D44C(void);
void ViMap__Func_215D4B4(void);
void ViMap__Func_215D604(void);
void ViMap__Func_215D734(void);
void ViMap__Func_215D7B4(void);
void ViMap__Func_215D7D8(void);
void ViMap__Func_215D930(void);
void ViMap__Func_215D9C4(void);
void ViMap__Func_215D9E8(void);
void ViMap__Func_215D9EC(void);
void ViMap__Func_215DA38(void);
void ViMap__Func_215DA68(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAP_HPP