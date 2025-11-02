#ifndef RUSH_BOSS3_H
#define RUSH_BOSS3_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define BOSS3_STAGE_START  0x40000
#define BOSS3_STAGE_END    0x6BAA99
#define BOSS3_STAGE_RADIUS 0x107FC0

// --------------------
// TYPES
// --------------------

typedef struct Boss3Stage_ Boss3Stage;
typedef struct Boss3_ Boss3;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss3Stage_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

struct Boss3_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss3Stage *Boss3Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss3 *Boss3__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss3Arm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3SplatInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3DimInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3InkSmoke__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3ScreenSplatInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

NOT_DECOMPILED void Boss3__SetInkSplatFlag(void);
NOT_DECOMPILED void Boss3__Func_2161BD0(void);
NOT_DECOMPILED void Boss3__Func_2161C40(void);
NOT_DECOMPILED void Boss3__DrawPlayer(void);
NOT_DECOMPILED void Boss3__Func_2161E28(void);
NOT_DECOMPILED void Boss3__Func_2161E40(void);
NOT_DECOMPILED void Boss3__Func_2161E90(void);
NOT_DECOMPILED void Boss3__Func_2161EE0(void);
NOT_DECOMPILED void Boss3__Func_2161F6C(void);
NOT_DECOMPILED void Boss3__Func_2161FD4(void);
NOT_DECOMPILED void Boss3__Func_2161FF8(void);
NOT_DECOMPILED void Boss3__Func_2162004(void);
NOT_DECOMPILED void Boss3__Func_2162018(void);
NOT_DECOMPILED void Boss3__Func_216202C(void);
NOT_DECOMPILED void Boss3__Func_216208C(void);
NOT_DECOMPILED void Boss3__Func_21622B4(void);
NOT_DECOMPILED void Boss3__Func_2162370(void);
NOT_DECOMPILED void Boss3__Func_216242C(void);
NOT_DECOMPILED void Boss3__Func_21624EC(void);
NOT_DECOMPILED void Boss3__Func_21625C8(void);
NOT_DECOMPILED void Boss3__Func_2162680(void);
NOT_DECOMPILED void Boss3__Func_2162738(void);
NOT_DECOMPILED void Boss3__Func_21627F0(void);
NOT_DECOMPILED void Boss3__Func_21628AC(void);
NOT_DECOMPILED void Boss3__Func_2162918(void);
NOT_DECOMPILED void Boss3__Func_2162990(void);
NOT_DECOMPILED void Boss3__Func_21629DC(void);
NOT_DECOMPILED void Boss3__Func_2162A38(void);
NOT_DECOMPILED void Boss3__Func_2162A54(void);
NOT_DECOMPILED void Boss3__Func_2162A70(void);
NOT_DECOMPILED void Boss3__Func_2162A98(void);
NOT_DECOMPILED void Boss3__Func_2162AB0(void);
NOT_DECOMPILED void Boss3__Func_2162ACC(void);
NOT_DECOMPILED void Boss3__Func_2162AE8(void);
NOT_DECOMPILED void Boss3__Func_2162B04(void);
NOT_DECOMPILED void Boss3__Func_2162B20(void);
NOT_DECOMPILED void Boss3__Func_2162BA8(void);
NOT_DECOMPILED void Boss3__Func_2162BD0(void);
NOT_DECOMPILED void Boss3__Func_2162BF4(void);
NOT_DECOMPILED void Boss3__Func_2162C34(void);
NOT_DECOMPILED void Boss3__Func_2162DE4(void);
NOT_DECOMPILED void Boss3__Func_2162E00(void);
NOT_DECOMPILED void Boss3__Func_2162E38(void);
NOT_DECOMPILED void Boss3__Func_2162EB8(void);
NOT_DECOMPILED void Boss3__Func_2162F10(void);
NOT_DECOMPILED void Boss3Stage__State_2162F18(void);
NOT_DECOMPILED void Boss3__Func_2162F54(void);
NOT_DECOMPILED void Boss3Stage__Draw(void);
NOT_DECOMPILED void Boss3Stage__State_21631E0(void);
NOT_DECOMPILED void Boss3__Func_2163400(void);
NOT_DECOMPILED void Boss3__Func_216341C(void);
NOT_DECOMPILED void Boss3__Func_2163454(void);
NOT_DECOMPILED void Boss3__Func_2163458(void);
NOT_DECOMPILED void Boss3__Func_2163494(void);
NOT_DECOMPILED void Boss3__State_2163604(void);
NOT_DECOMPILED void Boss3__Func_21637F0(void);
NOT_DECOMPILED void Boss3__Draw(void);
NOT_DECOMPILED void Boss3__Func_21639F4(void);
NOT_DECOMPILED void Boss3__Func_2163AF0(void);
NOT_DECOMPILED void Boss3__Func_2163B44(void);
NOT_DECOMPILED void Boss3__Func_2163CC8(void);
NOT_DECOMPILED void Boss3__Func_2163D10(void);
NOT_DECOMPILED void Boss3__Func_2163D7C(void);
NOT_DECOMPILED void Boss3__Func_2163E28(void);
NOT_DECOMPILED void Boss3__Func_2163E64(void);
NOT_DECOMPILED void Boss3__Func_2163EB0(void);
NOT_DECOMPILED void Boss3__Func_2163F00(void);
NOT_DECOMPILED void Boss3__Func_2163F24(void);
NOT_DECOMPILED void Boss3__Func_2163FD8(void);
NOT_DECOMPILED void Boss3__Func_21640A4(void);
NOT_DECOMPILED void Boss3__Func_2164100(void);
NOT_DECOMPILED void Boss3__Func_2164204(void);
NOT_DECOMPILED void Boss3__Func_21643CC(void);
NOT_DECOMPILED void Boss3__Func_2164414(void);
NOT_DECOMPILED void Boss3__Func_2164488(void);
NOT_DECOMPILED void Boss3__Func_21644E4(void);
NOT_DECOMPILED void Boss3__Func_2164580(void);
NOT_DECOMPILED void Boss3__Func_21645EC(void);
NOT_DECOMPILED void Boss3__Func_21646BC(void);
NOT_DECOMPILED void Boss3__Func_21646F8(void);
NOT_DECOMPILED void Boss3__Func_2164728(void);
NOT_DECOMPILED void Boss3__Func_21648B0(void);
NOT_DECOMPILED void Boss3__Func_21649D8(void);
NOT_DECOMPILED void Boss3__Func_2164A18(void);
NOT_DECOMPILED void Boss3__Func_2164B80(void);
NOT_DECOMPILED void Boss3__Func_2164BDC(void);
NOT_DECOMPILED void Boss3__Func_2164C34(void);
NOT_DECOMPILED void Boss3__Func_2164C84(void);
NOT_DECOMPILED void Boss3__Func_2164CC4(void);
NOT_DECOMPILED void Boss3__Func_2164D0C(void);
NOT_DECOMPILED void Boss3__Func_2164DA8(void);
NOT_DECOMPILED void Boss3__Func_2164DE8(void);
NOT_DECOMPILED void Boss3__Func_2164E40(void);
NOT_DECOMPILED void Boss3__Func_2164E5C(void);
NOT_DECOMPILED void Boss3__Func_2164F24(void);
NOT_DECOMPILED void Boss3__Func_2164F40(void);
NOT_DECOMPILED void Boss3__Func_2165020(void);
NOT_DECOMPILED void Boss3__Func_2165084(void);
NOT_DECOMPILED void Boss3__Func_2165130(void);
NOT_DECOMPILED void Boss3__Func_21651EC(void);
NOT_DECOMPILED void Boss3__Func_21652E4(void);
NOT_DECOMPILED void Boss3__Func_216548C(void);
NOT_DECOMPILED void Boss3__Func_21654D4(void);
NOT_DECOMPILED void Boss3__Func_2165548(void);
NOT_DECOMPILED void Boss3__Func_21655B0(void);
NOT_DECOMPILED void Boss3__Func_21656B8(void);
NOT_DECOMPILED void Boss3__Func_216572C(void);
NOT_DECOMPILED void Boss3__Func_21657A4(void);
NOT_DECOMPILED void Boss3__Func_2165870(void);
NOT_DECOMPILED void Boss3__Func_21658B8(void);
NOT_DECOMPILED void Boss3__Func_2165900(void);
NOT_DECOMPILED void Boss3__Func_216592C(void);
NOT_DECOMPILED void Boss3__Func_216597C(void);
NOT_DECOMPILED void Boss3__Func_21659AC(void);
NOT_DECOMPILED void Boss3__Func_21659EC(void);
NOT_DECOMPILED void Boss3__Func_2165A50(void);
NOT_DECOMPILED void Boss3__Func_2165A90(void);
NOT_DECOMPILED void Boss3__Func_2165AAC(void);
NOT_DECOMPILED void Boss3__Func_2165AF0(void);
NOT_DECOMPILED void Boss3__State_2165B2C(void);
NOT_DECOMPILED void Boss3__State_2165C0C(void);
NOT_DECOMPILED void Boss3__State_2165CF0(void);
NOT_DECOMPILED void Boss3__Func_2165D30(void);
NOT_DECOMPILED void Boss3__Func_2165D4C(void);
NOT_DECOMPILED void Boss3__State_2165DD8(void);
NOT_DECOMPILED void Boss3__Func_2165E1C(void);
NOT_DECOMPILED void Boss3__Func_2165E5C(void);
NOT_DECOMPILED void Boss3__Func_2165EC0(void);
NOT_DECOMPILED void Boss3__Func_2165FB0(void);
NOT_DECOMPILED void Boss3__Func_216602C(void);
NOT_DECOMPILED void Boss3__Func_216603C(void);
NOT_DECOMPILED void Boss3__Func_2166088(void);
NOT_DECOMPILED void Boss3__Func_21660DC(void);
NOT_DECOMPILED void Boss3__Func_2166130(void);
NOT_DECOMPILED void Boss3__Func_2166184(void);
NOT_DECOMPILED void Boss3__Func_21661C8(void);
NOT_DECOMPILED void Boss3__Func_2166290(void);
NOT_DECOMPILED void Boss3__Func_2166318(void);
NOT_DECOMPILED void Boss3__Func_216640C(void);
NOT_DECOMPILED void Boss3__Func_2166460(void);
NOT_DECOMPILED void Boss3__Func_216648C(void);
NOT_DECOMPILED void Boss3__Func_21664DC(void);
NOT_DECOMPILED void Boss3__Func_216653C(void);
NOT_DECOMPILED void Boss3__Func_216658C(void);
NOT_DECOMPILED void Boss3__Func_21665CC(void);
NOT_DECOMPILED void Boss3__Func_2166630(void);
NOT_DECOMPILED void Boss3__Func_2166720(void);
NOT_DECOMPILED void Boss3__Func_216678C(void);
NOT_DECOMPILED void Boss3__Func_21667CC(void);
NOT_DECOMPILED void Boss3__Func_21667F8(void);
NOT_DECOMPILED void Boss3__Func_2166848(void);
NOT_DECOMPILED void Boss3__Func_2166888(void);
NOT_DECOMPILED void Boss3__Func_21668C8(void);
NOT_DECOMPILED void Boss3__Func_2166998(void);
NOT_DECOMPILED void Boss3__Func_21669B4(void);
NOT_DECOMPILED void Boss3__Func_21669F4(void);
NOT_DECOMPILED void Boss3__Func_2166A54(void);
NOT_DECOMPILED void Boss3__Func_2166A70(void);
NOT_DECOMPILED void Boss3__Func_2166B34(void);
NOT_DECOMPILED void Boss3__Func_2166B90(void);
NOT_DECOMPILED void Boss3__Func_2166BF4(void);
NOT_DECOMPILED void Boss3__Func_2166C34(void);
NOT_DECOMPILED void Boss3__Func_2166C9C(void);
NOT_DECOMPILED void Boss3__Func_2166CC4(void);
NOT_DECOMPILED void Boss3__Func_2166D60(void);
NOT_DECOMPILED void Boss3__Func_2166EDC(void);
NOT_DECOMPILED void Boss3__Func_2166F18(void);
NOT_DECOMPILED void Boss3__Func_2166F80(void);
NOT_DECOMPILED void Boss3__Func_21670C4(void);
NOT_DECOMPILED void Boss3__Func_2167164(void);
NOT_DECOMPILED void Boss3__Func_2167368(void);
NOT_DECOMPILED void Boss3__Func_2167380(void);
NOT_DECOMPILED void Boss3__Func_2167390(void);
NOT_DECOMPILED void Boss3__Func_21673C0(void);
NOT_DECOMPILED void Boss3__Func_21674F4(void);
NOT_DECOMPILED void Boss3__Func_216759C(void);
NOT_DECOMPILED void Boss3__Func_21675A0(void);
NOT_DECOMPILED void Boss3__Func_216760C(void);
NOT_DECOMPILED void Boss3__Func_216767C(void);
NOT_DECOMPILED void Boss3__Func_216768C(void);
NOT_DECOMPILED void Boss3__Func_216769C(void);
NOT_DECOMPILED void Boss3__Func_2167764(void);
NOT_DECOMPILED void Boss3__Func_2167780(void);
NOT_DECOMPILED void Boss3__Func_2167784(void);
NOT_DECOMPILED void Boss3__Func_21677F4(void);
NOT_DECOMPILED void Boss3__Func_2167810(void);
NOT_DECOMPILED void Boss3__Func_2167970(void);
NOT_DECOMPILED void Boss3__Func_21679AC(void);
NOT_DECOMPILED void Boss3__Func_2167B08(void);
NOT_DECOMPILED void Boss3__Func_2167B48(void);
NOT_DECOMPILED void Boss3__Func_2167BBC(void);
NOT_DECOMPILED void Boss3__Func_2167C44(void);
NOT_DECOMPILED void Boss3__Func_2167CFC(void);
NOT_DECOMPILED void Boss3__Func_2167D18(void);
NOT_DECOMPILED void Boss3__Func_2167DE8(void);
NOT_DECOMPILED void Boss3__Func_2167E0C(void);
NOT_DECOMPILED void Boss3__Func_2167E1C(void);
NOT_DECOMPILED void Boss3__Func_2167E74(void);
NOT_DECOMPILED void Boss3__Func_2167E90(void);
NOT_DECOMPILED void Boss3__Func_2167EE4(void);
NOT_DECOMPILED void Boss3__Func_2167F18(void);
NOT_DECOMPILED void Boss3__Func_2167F80(void);
NOT_DECOMPILED void Boss3__Func_2167FD4(void);
NOT_DECOMPILED void Boss3__Func_2168014(void);
NOT_DECOMPILED void Boss3__Func_21681A8(void);
NOT_DECOMPILED void Boss3__Func_21681EC(void);
NOT_DECOMPILED void Boss3__Func_216821C(void);
NOT_DECOMPILED void Boss3__Func_216822C(void);
NOT_DECOMPILED void Boss3__Func_2168260(void);
NOT_DECOMPILED void Boss3__Func_21682F8(void);
NOT_DECOMPILED void Boss3__Func_2168324(void);
NOT_DECOMPILED void Boss3__Func_21683F0(void);
NOT_DECOMPILED void Boss3__Func_2168414(void);
NOT_DECOMPILED void Boss3__Func_21684EC(void);
NOT_DECOMPILED void Boss3__Func_21684FC(void);
NOT_DECOMPILED void Boss3Arm__State_2168520(void);
NOT_DECOMPILED void Boss3Arm__Destructor_21685FC(void);
NOT_DECOMPILED void Boss3Arm__Draw(void);
NOT_DECOMPILED void Boss3Arm__Collide(void);
NOT_DECOMPILED void Boss3Arm__OnDefend_Regular(void);
NOT_DECOMPILED void Boss3__Func_2168850(void);
NOT_DECOMPILED void Boss3__Func_21688BC(void);
NOT_DECOMPILED void Boss3__Func_2168924(void);
NOT_DECOMPILED void Boss3__Func_216898C(void);
NOT_DECOMPILED void Boss3__Func_2168A04(void);
NOT_DECOMPILED void Boss3__Func_2168A68(void);
NOT_DECOMPILED void Boss3Arm__OnDefend_Weakpoint(void);
NOT_DECOMPILED void Boss3__Func_2168B4C(void);
NOT_DECOMPILED void Boss3__Func_2168BD4(void);
NOT_DECOMPILED void Boss3__Func_2168C60(void);
NOT_DECOMPILED void Boss3__Func_2168CE8(void);
NOT_DECOMPILED void Boss3Arm__OnDefend_2168D6C(void);
NOT_DECOMPILED void Boss3__Func_2168E34(void);
NOT_DECOMPILED void Boss3__Func_2168EDC(void);
NOT_DECOMPILED void Boss3__Func_2168F30(void);
NOT_DECOMPILED void Boss3Arm__Func_2168F84(void);
NOT_DECOMPILED void Boss3Stage__Func_2169164(void);
NOT_DECOMPILED void Boss3__Func_2169194(void);
NOT_DECOMPILED void Boss3__Func_2169214(void);
NOT_DECOMPILED void Boss3__Func_2169218(void);
NOT_DECOMPILED void Boss3__Func_2169290(void);
NOT_DECOMPILED void Boss3__Func_216937C(void);
NOT_DECOMPILED void Boss3__Func_2169478(void);
NOT_DECOMPILED void Boss3__Func_2169494(void);
NOT_DECOMPILED void Boss3__Func_21694D8(void);
NOT_DECOMPILED void Boss3__Func_21694E8(void);
NOT_DECOMPILED void Boss3__Func_2169540(void);
NOT_DECOMPILED void Boss3__Func_21697D0(void);
NOT_DECOMPILED void Boss3__Func_2169800(void);
NOT_DECOMPILED void Boss3__Func_2169868(void);
NOT_DECOMPILED void Boss3__Func_2169900(void);
NOT_DECOMPILED void Boss3__Func_2169934(void);
NOT_DECOMPILED void Boss3__Func_2169978(void);
NOT_DECOMPILED void Boss3__Func_216997C(void);
NOT_DECOMPILED void Boss3__Func_21699E0(void);
NOT_DECOMPILED void Boss3__Func_2169A5C(void);
NOT_DECOMPILED void Boss3__Func_2169AC0(void);
NOT_DECOMPILED void Boss3__Func_2169B3C(void);
NOT_DECOMPILED void Boss3__Func_2169B9C(void);
NOT_DECOMPILED void Boss3__Func_2169BE4(void);
NOT_DECOMPILED void Boss3__Func_2169C18(void);
NOT_DECOMPILED void Boss3__Func_2169D30(void);
NOT_DECOMPILED void Boss3__Func_2169D4C(void);
NOT_DECOMPILED void Boss3__Func_2169DC0(void);
NOT_DECOMPILED void Boss3__Func_2169DCC(void);
NOT_DECOMPILED void Boss3__Func_2169DDC(void);
NOT_DECOMPILED void Boss3__Func_2169E14(void);
NOT_DECOMPILED void Boss3__Func_2169E78(void);
NOT_DECOMPILED void Boss3__Func_2169F14(void);
NOT_DECOMPILED void Boss3__Func_2169F78(void);
NOT_DECOMPILED void Boss3__Func_2169FE4(void);
NOT_DECOMPILED void Boss3__Func_216A040(void);
NOT_DECOMPILED void Boss3__Func_216A09C(void);
NOT_DECOMPILED void Boss3__Func_216A0B4(void);
NOT_DECOMPILED void Boss3__Func_216A128(void);
NOT_DECOMPILED void Boss3__Func_216A178(void);
NOT_DECOMPILED void Boss3__Func_216A1CC(void);
NOT_DECOMPILED void Boss3__Func_216A210(void);
NOT_DECOMPILED void Boss3__Func_216A368(void);
NOT_DECOMPILED void Boss3__Func_216A394(void);
NOT_DECOMPILED void Boss3__Func_216A3C4(void);
NOT_DECOMPILED void Boss3__Func_216A460(void);
NOT_DECOMPILED void Boss3__Func_216A574(void);
NOT_DECOMPILED void Boss3__Func_216A610(void);
NOT_DECOMPILED void Boss3__Func_216A62C(void);
NOT_DECOMPILED void Boss3__Func_216A6F8(void);
NOT_DECOMPILED void Boss3__Func_216A734(void);
NOT_DECOMPILED void Boss3__Func_216A7AC(void);
NOT_DECOMPILED void Boss3__Func_216A8B0(void);
NOT_DECOMPILED void Boss3__Func_216A94C(void);
NOT_DECOMPILED void Boss3__Func_216A9C8(void);
NOT_DECOMPILED void Boss3__Func_216AA70(void);
NOT_DECOMPILED void Boss3__Func_216AAE0(void);
NOT_DECOMPILED void Boss3__Func_216AB34(void);
NOT_DECOMPILED void Boss3__Func_216ABD0(void);
NOT_DECOMPILED void Boss3__Func_216AC5C(void);
NOT_DECOMPILED void Boss3__Func_216AC78(void);
NOT_DECOMPILED void Boss3__Func_216ACDC(void);
NOT_DECOMPILED void Boss3__Func_216AD50(void);
NOT_DECOMPILED void Boss3__Func_216ADB8(void);
NOT_DECOMPILED void Boss3__Func_216ADBC(void);
NOT_DECOMPILED void Boss3__Func_216AE20(void);
NOT_DECOMPILED void Boss3__Func_216AE88(void);
NOT_DECOMPILED void Boss3__Func_216AEEC(void);
NOT_DECOMPILED void Boss3__Func_216AF54(void);
NOT_DECOMPILED void Boss3__Func_216AFB4(void);
NOT_DECOMPILED void Boss3__Func_216AFFC(void);
NOT_DECOMPILED void Boss3__Func_216B054(void);
NOT_DECOMPILED void Boss3__Func_216B138(void);
NOT_DECOMPILED void Boss3__Func_216B154(void);
NOT_DECOMPILED void Boss3__Func_216B1C8(void);
NOT_DECOMPILED void Boss3__Func_216B220(void);
NOT_DECOMPILED void Boss3__Func_216B284(void);
NOT_DECOMPILED void Boss3__Func_216B2C8(void);
NOT_DECOMPILED void Boss3__Func_216B32C(void);
NOT_DECOMPILED void Boss3__Func_216B34C(void);
NOT_DECOMPILED void Boss3__Func_216B3AC(void);
NOT_DECOMPILED void Boss3__Func_216B3F0(void);
NOT_DECOMPILED void Boss3__Func_216B400(void);
NOT_DECOMPILED void Boss3__Func_216B410(void);
NOT_DECOMPILED void Boss3__Func_216B420(void);
NOT_DECOMPILED void Boss3__Func_216B430(void);
NOT_DECOMPILED void Boss3__Func_216B488(void);
NOT_DECOMPILED void Boss3__Func_216B4A4(void);
NOT_DECOMPILED void Boss3__Func_216B4F0(void);
NOT_DECOMPILED void Boss3__Func_216B548(void);
NOT_DECOMPILED void Boss3__Func_216B5B0(void);
NOT_DECOMPILED void Boss3__Func_216B5B4(void);
NOT_DECOMPILED void Boss3__Func_216B618(void);

#endif // RUSH_BOSS3_H