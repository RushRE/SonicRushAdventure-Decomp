#ifndef RUSH_BOSSF_H
#define RUSH_BOSSF_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct BossFStage_ BossFStage;
typedef struct BossF_ BossF;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct BossFStage_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

struct BossF_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

BossFStage *BossFStage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
BossF *BossF__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *BossFArm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFBodyCannon__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFShipCannon__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFMissileGreen__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFMissileRed__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

NOT_DECOMPILED void BossF__Func_2168FEC(void);
NOT_DECOMPILED void BossF__Func_2169074(void);
NOT_DECOMPILED void BossF__Func_21690C8(void);
NOT_DECOMPILED void BossF__Func_216911C(void);
NOT_DECOMPILED void BossF__Func_21691B8(void);
NOT_DECOMPILED void BossF__Func_21691F8(void);
NOT_DECOMPILED void BossF__Func_2169244(void);
NOT_DECOMPILED void BossFStage__HandleAudio(void);
NOT_DECOMPILED void BossF__Func_2169490(void);
NOT_DECOMPILED void BossF__Func_21694B8(void);
NOT_DECOMPILED void BossF__Func_2169868(void);
NOT_DECOMPILED void BossF__Func_2169AF8(void);
NOT_DECOMPILED void BossFStage__GetBackground(void);
NOT_DECOMPILED void BossFShipLight__HandleVisibility(void);
NOT_DECOMPILED void BossF__Func_2169EBC(void);
NOT_DECOMPILED void BossF__Func_2169EF4(void);
NOT_DECOMPILED void BossF__Func_2169F6C(void);
NOT_DECOMPILED void BossF__Func_2169F80(void);
NOT_DECOMPILED void BossF__Func_2169FF0(void);
NOT_DECOMPILED void BossFStage__Func_216A014(void);
NOT_DECOMPILED void BossFStage__Func_216A034(void);
NOT_DECOMPILED void BossF__Func_216A054(void);
NOT_DECOMPILED void BossF__Func_216A074(void);
NOT_DECOMPILED void BossF__Func_216A094(void);
NOT_DECOMPILED void BossF__Func_216A0B4(void);
NOT_DECOMPILED void BossF__Func_216A0D4(void);
NOT_DECOMPILED void BossFStage__State2_216A120(void);
NOT_DECOMPILED void BossFStage__State2_216A460(void);
NOT_DECOMPILED void BossFStage__State2_216A6C4(void);
NOT_DECOMPILED void BossF__Func_216AA74(void);
NOT_DECOMPILED void BossF__Func_216ABA8(void);
NOT_DECOMPILED void BossFStage__CreateStageWorker(void);
NOT_DECOMPILED void BossF__Func_216ACCC(void);
NOT_DECOMPILED void BossFStageWorker__State_216ACFC(void);
NOT_DECOMPILED void BossFStage__CreateShipLight(void);
NOT_DECOMPILED void BossFShipLight__State_216AEE4(void);
NOT_DECOMPILED void BossF__Func_216B020(void);
NOT_DECOMPILED void BossF__RenderCallback_BalkanL(void);
NOT_DECOMPILED void BossF__RenderCallback_BalkanR(void);
NOT_DECOMPILED void BossF__Draw(void);
NOT_DECOMPILED void BossF__In(void);
NOT_DECOMPILED void BossF__OnDefend_216B334(void);
NOT_DECOMPILED void BossF__Action_216B664(void);
NOT_DECOMPILED void BossF__State_216B6CC(void);
NOT_DECOMPILED void BossF__Func_216B784(void);
NOT_DECOMPILED void BossF__State_216B808(void);
NOT_DECOMPILED void BossF__Func_216B9F4(void);
NOT_DECOMPILED void BossF__State_216BA80(void);
NOT_DECOMPILED void BossF__Func_216BBD4(void);
NOT_DECOMPILED void BossF__Func_216BD90(void);
NOT_DECOMPILED void BossF__Func_216BE0C(void);
NOT_DECOMPILED void BossF__Func_216BFD4(void);
NOT_DECOMPILED void BossF__Func_216C084(void);
NOT_DECOMPILED void BossF__Func_216C6D0(void);
NOT_DECOMPILED void BossF__Func_216C740(void);
NOT_DECOMPILED void BossF__Func_216C82C(void);
NOT_DECOMPILED void BossF__Func_216CD18(void);
NOT_DECOMPILED void BossF__Func_216CDD8(void);
NOT_DECOMPILED void BossF__Func_216CFA4(void);
NOT_DECOMPILED void BossF__Func_216D268(void);
NOT_DECOMPILED void BossF__Func_216D370(void);
NOT_DECOMPILED void BossF__Func_216D674(void);
NOT_DECOMPILED void BossF__Func_216D6E8(void);
NOT_DECOMPILED void BossF__Func_216D9D4(void);
NOT_DECOMPILED void BossF__Func_216DA54(void);
NOT_DECOMPILED void BossF__Func_216DB04(void);
NOT_DECOMPILED void BossF__Func_216DB64(void);
NOT_DECOMPILED void BossF__Func_216DC58(void);
NOT_DECOMPILED void BossF__Func_216DCB4(void);
NOT_DECOMPILED void BossF__Func_216DF48(void);
NOT_DECOMPILED void BossF__Func_216E0C0(void);
NOT_DECOMPILED void BossF__Func_216E34C(void);
NOT_DECOMPILED void BossF__Func_216E458(void);
NOT_DECOMPILED void BossF__Func_216E740(void);
NOT_DECOMPILED void BossF__Func_216E75C(void);
NOT_DECOMPILED void BossF__Func_216E814(void);
NOT_DECOMPILED void BossF__Func_216E9A8(void);
NOT_DECOMPILED void BossF__Func_216EB58(void);
NOT_DECOMPILED void BossF__Func_216EBA0(void);
NOT_DECOMPILED void BossF__Func_216EC24(void);
NOT_DECOMPILED void BossF__Func_216ECB4(void);
NOT_DECOMPILED void BossF__Func_216ED8C(void);
NOT_DECOMPILED void BossF__Func_216F064(void);
NOT_DECOMPILED void BossF__Func_216F178(void);
NOT_DECOMPILED void BossF__Func_216F37C(void);
NOT_DECOMPILED void BossF__Func_216F408(void);
NOT_DECOMPILED void BossF__Func_216F45C(void);
NOT_DECOMPILED void BossF__Func_216F560(void);
NOT_DECOMPILED void BossF__Func_216F778(void);
NOT_DECOMPILED void BossF__Func_216F810(void);
NOT_DECOMPILED void BossF__Func_216FAC4(void);
NOT_DECOMPILED void BossF__Func_216FB40(void);
NOT_DECOMPILED void BossF__Func_216FC0C(void);
NOT_DECOMPILED void BossF__Func_216FD10(void);
NOT_DECOMPILED void BossF__Func_21700A0(void);
NOT_DECOMPILED void BossF__Func_2170130(void);
NOT_DECOMPILED void BossFShipCannon__Func_217019C(void);
NOT_DECOMPILED void BossFArm__In_Default(void);
NOT_DECOMPILED void BossFArm__RenderCallback_2170488(void);
NOT_DECOMPILED void BossFArm__Draw(void);
NOT_DECOMPILED void BossFArm__OnDefend_2170550(void);
NOT_DECOMPILED void BossFArm__OnHit_21706B4(void);
NOT_DECOMPILED void BossF__Func_21706FC(void);
NOT_DECOMPILED void BossF__Func_217070C(void);
NOT_DECOMPILED void BossF__Func_2170948(void);
NOT_DECOMPILED void BossF__Func_2170A4C(void);
NOT_DECOMPILED void BossF__Func_2170A70(void);
NOT_DECOMPILED void BossF__Func_2170B70(void);
NOT_DECOMPILED void BossF__Func_2170DEC(void);
NOT_DECOMPILED void BossF__Func_2170F0C(void);
NOT_DECOMPILED void BossF__Func_21710A4(void);
NOT_DECOMPILED void BossFBodyCannon__Action_2171108(void);
NOT_DECOMPILED void BossFBodyCannon__State_2171118(void);
NOT_DECOMPILED void BossF__Func_2171294(void);
NOT_DECOMPILED void BossF__Func_21712B4(void);
NOT_DECOMPILED void BossF__Func_2171694(void);
NOT_DECOMPILED void BossF__Func_21716E0(void);
NOT_DECOMPILED void BossF__Func_21717AC(void);
NOT_DECOMPILED void BossF__Func_2171A28(void);
NOT_DECOMPILED void BossF__Func_2171EDC(void);
NOT_DECOMPILED void BossF__Func_2171F00(void);
NOT_DECOMPILED void BossF__Func_2171FE0(void);
NOT_DECOMPILED void BossF__Func_2172034(void);
NOT_DECOMPILED void BossF__Func_2172108(void);
NOT_DECOMPILED void BossF__Func_21722D8(void);
NOT_DECOMPILED void BossF__Func_2172388(void);
NOT_DECOMPILED void BossF__Func_21725AC(void);
NOT_DECOMPILED void BossF__Func_2172618(void);
NOT_DECOMPILED void BossFShipCannon__In_Default(void);
NOT_DECOMPILED void BossFShipCannon__RenderCallback_21726D4(void);
NOT_DECOMPILED void BossFShipCannon__OnDefend_21727C4(void);
NOT_DECOMPILED void BossFShipCannon__OnDefend_2172AD8(void);
NOT_DECOMPILED void BossFShipCannon__Action_2172C1C(void);
NOT_DECOMPILED void BossFShipCannon__State_2172CA0(void);
NOT_DECOMPILED void BossFShipCannon__Func_2172D00(void);
NOT_DECOMPILED void BossFShipCannon__State_2172D10(void);
NOT_DECOMPILED void BossFShipCannon__Func_2172D5C(void);
NOT_DECOMPILED void BossFShipCannon__State_2172E68(void);
NOT_DECOMPILED void BossF__Func_2172ECC(void);
NOT_DECOMPILED void BossFShipCannon__State_2172F08(void);
NOT_DECOMPILED void BossF__Func_2172FD0(void);
NOT_DECOMPILED void BossF__Func_21730A4(void);
NOT_DECOMPILED void BossF__Action_ShieldBreak(void);
NOT_DECOMPILED void BossF__Func_217344C(void);
NOT_DECOMPILED void BossF__Func_2173568(void);
NOT_DECOMPILED void BossF__Func_21736C8(void);
NOT_DECOMPILED void BossF__Func_2173A00(void);
NOT_DECOMPILED void BossF__Func_2173C9C(void);
NOT_DECOMPILED void BossFShipCannon__CreateUnknown_2173D98(void);
NOT_DECOMPILED void BossF__Func_2173EE8(void);
NOT_DECOMPILED void BossFShipCannonUnknown__Func_2173F1C(void);
NOT_DECOMPILED void BossFShipCannonUnknown__State_2173F50(void);
NOT_DECOMPILED void BossFShipCannonUnknown__Func_2174100(void);
NOT_DECOMPILED void BossFShipCannonUnknown__State_217415C(void);
NOT_DECOMPILED void BossF__Func_21741F4(void);
NOT_DECOMPILED void BossFStage__CreateBarrier(void);
NOT_DECOMPILED void BossF__Func_21742E8(void);
NOT_DECOMPILED void BossFBarrier__Action_2174458(void);
NOT_DECOMPILED void BossFBarrier__State_21744C8(void);
NOT_DECOMPILED void BossF__Func_21746D4(void);
NOT_DECOMPILED void BossF__Func_21747DC(void);
NOT_DECOMPILED void BossF__Func_2174870(void);
NOT_DECOMPILED void BossF__Func_217492C(void);
NOT_DECOMPILED void BossF__Func_2174A0C(void);
NOT_DECOMPILED void BossF__Func_2174A78(void);
NOT_DECOMPILED void BossF__Func_2174C18(void);
NOT_DECOMPILED void BossF__Func_2174D00(void);
NOT_DECOMPILED void BossF__Func_2174DE0(void);
NOT_DECOMPILED void BossF__Func_2174ED0(void);
NOT_DECOMPILED void BossF__Func_2174F10(void);
NOT_DECOMPILED void BossF__Func_217517C(void);
NOT_DECOMPILED void BossF__Func_2175238(void);
NOT_DECOMPILED void BossF__Func_21752B4(void);
NOT_DECOMPILED void BossF__Func_21752C4(void);
NOT_DECOMPILED void BossF__Func_21753A8(void);
NOT_DECOMPILED void BossF__Func_21753E4(void);
NOT_DECOMPILED void BossF__Func_21755A0(void);
NOT_DECOMPILED void BossF__Func_21756D4(void);
NOT_DECOMPILED void BossF__Func_217572C(void);
NOT_DECOMPILED void BossF__Func_21757C4(void);
NOT_DECOMPILED void BossF__Func_2175988(void);
NOT_DECOMPILED void BossF__Func_2175AB4(void);
NOT_DECOMPILED void BossF__Func_2175BCC(void);
NOT_DECOMPILED void BossF__Func_2175C7C(void);
NOT_DECOMPILED void BossF__Func_2175D1C(void);
NOT_DECOMPILED void BossF__Func_2175E78(void);
NOT_DECOMPILED void BossF__Func_2175ED4(void);
NOT_DECOMPILED void BossF__Func_2175FF8(void);
NOT_DECOMPILED void BossF__Func_21760C4(void);
NOT_DECOMPILED void BossF__Func_2176174(void);
NOT_DECOMPILED void BossF__Func_2176638(void);
NOT_DECOMPILED void BossF__Func_2176700(void);
NOT_DECOMPILED void BossF__Func_2176800(void);
NOT_DECOMPILED void BossF__Func_2176958(void);
NOT_DECOMPILED void BossF__Func_2176A1C(void);
NOT_DECOMPILED void BossFShipCannon__State_2176A2C(void);
NOT_DECOMPILED void BossF__Func_2176A3C(void);
NOT_DECOMPILED void BossF__Func_2176B60(void);
NOT_DECOMPILED void BossF__Func_2176E90(void);
NOT_DECOMPILED void BossF__Func_2176F8C(void);
NOT_DECOMPILED void BossF__Func_2177040(void);
NOT_DECOMPILED void BossF__Func_21770F0(void);
NOT_DECOMPILED void BossF__Func_2177260(void);
NOT_DECOMPILED void BossF__Func_21772A8(void);
NOT_DECOMPILED void BossF__Func_217739C(void);
NOT_DECOMPILED void BossF__Func_21773FC(void);
NOT_DECOMPILED void BossF__Func_21775D0(void);
NOT_DECOMPILED void BossF__Func_21775E8(void);
NOT_DECOMPILED void BossF__Func_2177740(void);
NOT_DECOMPILED void BossF__Func_2177840(void);
NOT_DECOMPILED void BossF__Func_2177868(void);
NOT_DECOMPILED void BossF__Func_2177A98(void);
NOT_DECOMPILED void BossF__Func_2177B94(void);
NOT_DECOMPILED void BossF__Func_2177CC8(void);
NOT_DECOMPILED void BossF__Func_2177DD8(void);
NOT_DECOMPILED void BossF__Func_2177EEC(void);
NOT_DECOMPILED void BossF__Func_2177F28(void);
NOT_DECOMPILED void BossF__Func_217801C(void);
NOT_DECOMPILED void BossF__Func_2178088(void);
NOT_DECOMPILED void BossF__Func_21781A4(void);
NOT_DECOMPILED void BossF__Func_2178294(void);
NOT_DECOMPILED void BossF__Func_2178390(void);
NOT_DECOMPILED void BossF__Func_21785F4(void);
NOT_DECOMPILED void BossF__Func_21786F8(void);
NOT_DECOMPILED void BossF__PlaySfx(void);

#endif // RUSH_BOSSF_H