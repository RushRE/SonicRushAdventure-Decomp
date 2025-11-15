#ifndef RUSH_BOSS5_H
#define RUSH_BOSS5_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss5Stage_ Boss5Stage;
typedef struct Boss5_ Boss5;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss5Stage_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

struct Boss5_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss5Stage *Boss5Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss5 *Boss5__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss5MapChunk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Icicle2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5FreezeArea__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5IcicleSpawner__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5MissileLauncher__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Core__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Unknown21748C4__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5EnemyFish__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5LifeSupport__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Shutter__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Battery__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Sea__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Missile__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *CreateBoss5Icicle(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5PlayerFreezeEffect__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5EnemyFish2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

NOT_DECOMPILED void Boss5__Func_21752C0(void);
NOT_DECOMPILED void Boss5__Func_2175328(void);
NOT_DECOMPILED void Boss5__Func_2175370(void);
NOT_DECOMPILED void Boss5__Func_217552C(void);
NOT_DECOMPILED void Boss5__Func_21755B0(void);
NOT_DECOMPILED void Boss5__Func_21756D4(void);
NOT_DECOMPILED void Boss5__Func_217571C(void);
NOT_DECOMPILED void Boss5__Func_21758A0(void);
NOT_DECOMPILED void Boss5__Func_21758CC(void);
NOT_DECOMPILED void Boss5__Func_2175924(void);
NOT_DECOMPILED void Boss5__Func_217597C(void);
NOT_DECOMPILED void Boss5__Func_217599C(void);
NOT_DECOMPILED void Boss5__Func_21759C4(void);
NOT_DECOMPILED void Boss5__Func_2175A00(void);
NOT_DECOMPILED void Boss5__Func_2175A18(void);
NOT_DECOMPILED void Boss5__Func_2175A38(void);
NOT_DECOMPILED void Boss5__Func_2175A60(void);
NOT_DECOMPILED void Boss5__Func_2175A80(void);
NOT_DECOMPILED void Boss5__Func_2175AA8(void);
NOT_DECOMPILED void Boss5__Func_2175AF4(void);
NOT_DECOMPILED void Boss5__Func_2175B24(void);
NOT_DECOMPILED void Boss5__Func_2175B48(void);
NOT_DECOMPILED void Boss5__Func_2175B6C(void);
NOT_DECOMPILED void Boss5__Func_2175BB8(void);
NOT_DECOMPILED void Boss5__Func_2175BCC(void);
NOT_DECOMPILED void Boss5__Func_2175BD0(void);
NOT_DECOMPILED void Boss5__Func_2175C20(void);
NOT_DECOMPILED void Boss5__Func_2175CA8(void);
NOT_DECOMPILED void Boss5__Func_2175D28(void);
NOT_DECOMPILED void Boss5__Func_2175D40(void);
NOT_DECOMPILED void Boss5__Func_2175D7C(void);
NOT_DECOMPILED void Boss5__Func_2175DD0(void);
NOT_DECOMPILED void Boss5__Func_2175F2C(void);
NOT_DECOMPILED void Boss5__Func_2175F48(void);
NOT_DECOMPILED void Boss5__Func_21760A0(void);
NOT_DECOMPILED void Boss5__Func_217623C(void);
NOT_DECOMPILED void Boss5__Func_2176288(void);
NOT_DECOMPILED void Boss5__Func_2176450(void);
NOT_DECOMPILED void Boss5__Func_2176460(void);
NOT_DECOMPILED void Boss5__Func_21764AC(void);
NOT_DECOMPILED void Boss5__Func_2176528(void);
NOT_DECOMPILED void Boss5__Func_2176540(void);
NOT_DECOMPILED void Boss5__Func_2176560(void);
NOT_DECOMPILED void Boss5__Func_2176648(void);
NOT_DECOMPILED void Boss5__Func_21766D4(void);
NOT_DECOMPILED void Boss5__Func_21766EC(void);
NOT_DECOMPILED void Boss5Unknown2176760__Create__Create(void);
NOT_DECOMPILED void Boss5Unknown2176760__State_2176810(void);
NOT_DECOMPILED void Boss5Unknown2176760__Destructor(void);
NOT_DECOMPILED void Boss5__Func_217696C(void);
NOT_DECOMPILED void Boss5__Func_2176970(void);
NOT_DECOMPILED void Boss5__Func_2176998(void);
NOT_DECOMPILED void Boss5__Func_21769F0(void);
NOT_DECOMPILED void Boss5__Func_2176AE4(void);
NOT_DECOMPILED void Boss5__Func_2176B24(void);
NOT_DECOMPILED void Boss5__Func_2176B64(void);
NOT_DECOMPILED void Boss5__Func_2176BC4(void);
NOT_DECOMPILED void Boss5__Func_2176C54(void);
NOT_DECOMPILED void Boss5__Func_2176DC4(void);
NOT_DECOMPILED void Boss5__Func_2176DD0(void);
NOT_DECOMPILED void Boss5__Func_2176DDC(void);
NOT_DECOMPILED void Boss5__Func_2176E28(void);
NOT_DECOMPILED void Boss5__Func_2176EAC(void);
NOT_DECOMPILED void Boss5__Func_2177018(void);
NOT_DECOMPILED void Boss5__Func_2177188(void);
NOT_DECOMPILED void Boss5__Func_21771A8(void);
NOT_DECOMPILED void Boss5__Func_21772CC(void);
NOT_DECOMPILED void Boss5__Func_21772D8(void);
NOT_DECOMPILED void Boss5__Func_2177370(void);
NOT_DECOMPILED void Boss5__Func_21773A0(void);
NOT_DECOMPILED void Boss5__Func_21773FC(void);
NOT_DECOMPILED void Boss5__Func_217746C(void);
NOT_DECOMPILED void Boss5__Func_2177490(void);
NOT_DECOMPILED void Boss5__Func_217749C(void);
NOT_DECOMPILED void Boss5__Func_21774E8(void);
NOT_DECOMPILED void Boss5__Func_21774F8(void);
NOT_DECOMPILED void Boss5__Func_2177518(void);
NOT_DECOMPILED void Boss5__Func_2177540(void);
NOT_DECOMPILED void Boss5__Func_2177554(void);
NOT_DECOMPILED void Boss5__Func_2177568(void);
NOT_DECOMPILED void Boss5__Func_2177584(void);
NOT_DECOMPILED void Boss5__Func_21775D8(void);
NOT_DECOMPILED void Boss5__Func_2177654(void);
NOT_DECOMPILED void Boss5__Func_21777A8(void);
NOT_DECOMPILED void Boss5__Func_2177858(void);
NOT_DECOMPILED void Boss5__Func_217786C(void);
NOT_DECOMPILED void Boss5__Func_2177870(void);
NOT_DECOMPILED void Boss5__Func_2177890(void);
NOT_DECOMPILED void Boss5__Func_21778F0(void);
NOT_DECOMPILED void Boss5__Func_2177908(void);
NOT_DECOMPILED void Boss5__Func_2177918(void);
NOT_DECOMPILED void Boss5__Func_2177930(void);
NOT_DECOMPILED void Boss5__Func_2177964(void);
NOT_DECOMPILED void Boss5__Func_2177998(void);
NOT_DECOMPILED void Boss5__Func_21779CC(void);
NOT_DECOMPILED void Boss5__Func_2177A10(void);
NOT_DECOMPILED void Boss5__Func_2177A54(void);
NOT_DECOMPILED void Boss5__Func_2177A88(void);
NOT_DECOMPILED void Boss5__Func_2177ACC(void);
NOT_DECOMPILED void Boss5__Func_2177B00(void);
NOT_DECOMPILED void Boss5__Func_2177B34(void);
NOT_DECOMPILED void Boss5__Func_2177B68(void);
NOT_DECOMPILED void Boss5__Func_2177BAC(void);
NOT_DECOMPILED void Boss5__Func_2177BB4(void);
NOT_DECOMPILED void Boss5__Func_2177C98(void);
NOT_DECOMPILED void Boss5__Func_2177D7C(void);
NOT_DECOMPILED void Boss5__Func_2177DC4(void);
NOT_DECOMPILED void Boss5__Func_2177E0C(void);
NOT_DECOMPILED void Boss5__Func_2177E24(void);
NOT_DECOMPILED void Boss5__Func_2177EB0(void);
NOT_DECOMPILED void Boss5__Func_2177EFC(void);
NOT_DECOMPILED void Boss5__Func_2177F40(void);
NOT_DECOMPILED void Boss5__Func_2177FFC(void);
NOT_DECOMPILED void Boss5__Func_2178020(void);
NOT_DECOMPILED void Boss5__Func_217822C(void);
NOT_DECOMPILED void Boss5__Func_21783B8(void);
NOT_DECOMPILED void Boss5__Func_2178418(void);
NOT_DECOMPILED void Boss5__Func_2178444(void);
NOT_DECOMPILED void Boss5__Func_2178478(void);
NOT_DECOMPILED void Boss5__Func_21784E4(void);
NOT_DECOMPILED void Boss5__Func_2178500(void);
NOT_DECOMPILED void Boss5__Func_21785A4(void);
NOT_DECOMPILED void Boss5__Func_21785C0(void);
NOT_DECOMPILED void Boss5__Func_21785DC(void);
NOT_DECOMPILED void Boss5__Func_2178600(void);
NOT_DECOMPILED void Boss5__Func_2178680(void);
NOT_DECOMPILED void Boss5__Func_2178684(void);
NOT_DECOMPILED void Boss5__Func_21786E4(void);
NOT_DECOMPILED void Boss5__Func_2178700(void);
NOT_DECOMPILED void Boss5__Func_2178734(void);
NOT_DECOMPILED void Boss5__Func_2178754(void);
NOT_DECOMPILED void Boss5__Func_21787AC(void);
NOT_DECOMPILED void Boss5__Func_21787DC(void);
NOT_DECOMPILED void Boss5__Func_2178808(void);
NOT_DECOMPILED void Boss5__Func_2178820(void);
NOT_DECOMPILED void Boss5__Func_2178878(void);
NOT_DECOMPILED void Boss5__Func_2178898(void);
NOT_DECOMPILED void Boss5__Func_21788B8(void);
NOT_DECOMPILED void Boss5__Func_21788FC(void);
NOT_DECOMPILED void Boss5__Func_2178984(void);
NOT_DECOMPILED void Boss5__Func_2178B44(void);
NOT_DECOMPILED void Boss5__Func_2178B80(void);
NOT_DECOMPILED void Boss5__Func_2178BAC(void);
NOT_DECOMPILED void Boss5__Func_2178BF0(void);
NOT_DECOMPILED void Boss5__Func_2178C08(void);
NOT_DECOMPILED void Boss5__Func_2178CD4(void);
NOT_DECOMPILED void Boss5__Func_2178D18(void);
NOT_DECOMPILED void Boss5__Func_2178D38(void);
NOT_DECOMPILED void Boss5__Func_2178DA0(void);
NOT_DECOMPILED void Boss5__Func_2178E0C(void);
NOT_DECOMPILED void Boss5__Func_2178E30(void);
NOT_DECOMPILED void Boss5__Func_2178E50(void);
NOT_DECOMPILED void Boss5__Func_2178F30(void);
NOT_DECOMPILED void Boss5__Func_21790A0(void);
NOT_DECOMPILED void Boss5__Func_21790D0(void);
NOT_DECOMPILED void Boss5__Func_217911C(void);
NOT_DECOMPILED void Boss5__Func_21791A0(void);
NOT_DECOMPILED void Boss5__Func_2179218(void);
NOT_DECOMPILED void Boss5__Func_2179248(void);
NOT_DECOMPILED void Boss5__Func_2179264(void);
NOT_DECOMPILED void Boss5__Func_217928C(void);
NOT_DECOMPILED void Boss5__Func_21792E0(void);
NOT_DECOMPILED void Boss5__Func_2179340(void);
NOT_DECOMPILED void Boss5__Func_2179364(void);
NOT_DECOMPILED void Boss5__Func_21793AC(void);
NOT_DECOMPILED void Boss5__Func_21793C8(void);
NOT_DECOMPILED void Boss5__Func_21793E4(void);
NOT_DECOMPILED void Boss5__Func_2179400(void);
NOT_DECOMPILED void Boss5__Func_2179464(void);
NOT_DECOMPILED void Boss5__Func_2179480(void);
NOT_DECOMPILED void Boss5__Func_21794C4(void);
NOT_DECOMPILED void Boss5__Func_217953C(void);
NOT_DECOMPILED void Boss5__Func_2179584(void);
NOT_DECOMPILED void Boss5__Func_2179640(void);
NOT_DECOMPILED void Boss5__Func_21796D0(void);
NOT_DECOMPILED void Boss5__Func_2179750(void);
NOT_DECOMPILED void Boss5__Func_2179848(void);
NOT_DECOMPILED void Boss5__Func_21798E0(void);
NOT_DECOMPILED void Boss5__Func_2179974(void);

#endif // RUSH_BOSS5_H