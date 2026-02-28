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
NOT_DECOMPILED void Boss5__LoadAssets(void);
NOT_DECOMPILED void Boss5__InitCountdownSprites(void);
NOT_DECOMPILED void Boss5__ReleaseCountdownSprites(void);
NOT_DECOMPILED void Boss5Stage__UpdateNumberSprites(void);
NOT_DECOMPILED void Boss5Stage__DrawSprites(void);
NOT_DECOMPILED void Boss5Stage__ViewOutCheck(void);
NOT_DECOMPILED void Boss5Stage__ViewCheck(void);
NOT_DECOMPILED void Boss5EnemyFish2__Draw(void);
NOT_DECOMPILED void Boss5Stage__DrawCommonObject(void);
NOT_DECOMPILED void Boss5Stage__ResetLifeSupports(void);
NOT_DECOMPILED void Boss5Stage__DestroyedLifeSupport(void);
NOT_DECOMPILED void Boss5Stage__RemoveLifeSupport(void);
NOT_DECOMPILED void Boss5Stage__GetHeightMasks(void);
NOT_DECOMPILED void Boss5Stage__CheckCanSpawn(void);
NOT_DECOMPILED void Boss5Stage__AddEnemy(void);
NOT_DECOMPILED void Boss5Stage__RemoveEnemy(void);
NOT_DECOMPILED void Boss5__GetBossPhase(void);
NOT_DECOMPILED void Boss5__Func_2175AA8(void);
NOT_DECOMPILED void Boss5__Func_2175AF4(void);
NOT_DECOMPILED void Boss5Stage__GetCountdownDuration(void);
NOT_DECOMPILED void Boss5Stage__Func_2175B48(void);
NOT_DECOMPILED void Boss5__Func_2175B6C(void);
NOT_DECOMPILED void Boss5__Func_2175BB8(void);
NOT_DECOMPILED void Boss5MapChunk__State_Active(void);
NOT_DECOMPILED void Boss5MapChunk__Draw(void);
NOT_DECOMPILED void Boss5MissileLauncher__State_2175C20(void);
NOT_DECOMPILED void Boss5Battery__State_2175CA8(void);
NOT_DECOMPILED void Boss5Missile__Destructor(void);
NOT_DECOMPILED void Boss5Missile__OnHit(void);
NOT_DECOMPILED void Boss5IcicleSpawner__State_2175D7C(void);
NOT_DECOMPILED void Boss5Icicle2__State_2175DD0(void);
NOT_DECOMPILED void Boss5FreezeArea__OnDefend(void);
NOT_DECOMPILED void Boss5Unknown21748C4__State_2175F48(void);
NOT_DECOMPILED void Boss5EnemyFish__State_21760A0(void);
NOT_DECOMPILED void Boss5EnemyFish__OnDefend(void);
NOT_DECOMPILED void Boss5EnemyFish2__State_2176288(void);
NOT_DECOMPILED void Boss5EnemyFish2__Destructor(void);
NOT_DECOMPILED void Boss5EnemyFish2__OnDefend(void);
NOT_DECOMPILED void Boss5Stage__SpawnFish(void);
NOT_DECOMPILED void Boss5LifeSupport__Destructor(void);
NOT_DECOMPILED void Boss5Stage__CheckCanSpawnLifeSupport(void);
NOT_DECOMPILED void Boss5__Func_2176560(void);
NOT_DECOMPILED void Boss5LifeSupport__OnDefend(void);
NOT_DECOMPILED void Boss5Shutter__Destructor(void);
NOT_DECOMPILED void Boss5PlayerFreezeEffect__State_Active(void);
NOT_DECOMPILED void Boss5Unknown2176760__Create(void);
NOT_DECOMPILED void Boss5Unknown2176760__State_2176810(void);
NOT_DECOMPILED void Boss5Unknown2176760__Destructor(void);
NOT_DECOMPILED void Boss5Core__State_Active(void);
NOT_DECOMPILED void Boss5Core__Destructor(void);
NOT_DECOMPILED void Boss5Core__Draw(void);
NOT_DECOMPILED void Boss5Core__OnDefend(void);
NOT_DECOMPILED void Boss5Stage__Func_2176AE4(void);
NOT_DECOMPILED void Boss5__Func_2176B24(void);
NOT_DECOMPILED void Boss5__Func_2176B64(void);
NOT_DECOMPILED void Boss5__Func_2176BC4(void);
NOT_DECOMPILED void Boss5__Func_2176C54(void);
NOT_DECOMPILED void Boss5__Func_2176DC4(void);
NOT_DECOMPILED void Boss5__Func_2176DD0(void);
NOT_DECOMPILED void Boss5Stage__State_2176DDC(void);
NOT_DECOMPILED void Boss5Stage__Destructor(void);
NOT_DECOMPILED void Boss5Stage__Draw(void);
NOT_DECOMPILED void Boss5__StageState_2177018(void);
NOT_DECOMPILED void Boss5__StageState_2177188(void);
NOT_DECOMPILED void Boss5__StageState_21771A8(void);
NOT_DECOMPILED void Boss5__Func_21772CC(void);
NOT_DECOMPILED void Boss5Sea__State_Active(void);
NOT_DECOMPILED void Boss5Sea__Destructor(void);
NOT_DECOMPILED void Boss5Sea__Draw(void);
NOT_DECOMPILED void Boss5__Func_21773FC(void);
NOT_DECOMPILED void Boss5__GetSeaLevel(void);
NOT_DECOMPILED void Boss5__GetFrame(void);
NOT_DECOMPILED void Boss5__SetAnimation(void);
NOT_DECOMPILED void Boss5__IsAnimFinished(void);
NOT_DECOMPILED void Boss5__PlayHitPaletteAnim(void);
NOT_DECOMPILED void Boss5__Func_2177518(void);
NOT_DECOMPILED void Boss5__DisableCollider(void);
NOT_DECOMPILED void Boss5__EnableCollider(void);
NOT_DECOMPILED void Boss5__State_Active(void);
NOT_DECOMPILED void Boss5__Destructor(void);
NOT_DECOMPILED void Boss5__Draw(void);
NOT_DECOMPILED void Boss5__Collide(void);
NOT_DECOMPILED void Boss5__OnDefend_WeakPoint(void);
NOT_DECOMPILED void Boss5__OnDefend_MouthEntry(void);
NOT_DECOMPILED void Boss5__Func_217786C(void);
NOT_DECOMPILED void Boss5__Func_2177870(void);
NOT_DECOMPILED void Boss5__Func_2177890(void);
NOT_DECOMPILED void Boss5__Func_21778F0(void);
NOT_DECOMPILED void Boss5__Func_2177908(void);
NOT_DECOMPILED void Boss5__Action_Init(void);
NOT_DECOMPILED void Boss5__Action_CirclePlayer(void);
NOT_DECOMPILED void Boss5__Action_Bite_0(void);
NOT_DECOMPILED void Boss5__Action_Bite_1(void);
NOT_DECOMPILED void Boss5__Action_LaunchAttack(void);
NOT_DECOMPILED void Boss5__Action_OpenMouth(void);
NOT_DECOMPILED void Boss5__Action_HurtEject(void);
NOT_DECOMPILED void Boss5__Action_EnterMouth(void);
NOT_DECOMPILED void Boss5__Action_InsideBody(void);
NOT_DECOMPILED void Boss5__Action_CountdownEject(void);
NOT_DECOMPILED void Boss5__Action_Deactivate(void);
NOT_DECOMPILED void Boss5__Action_Destroy(void);
NOT_DECOMPILED void Boss5__BossState_Init(void);
NOT_DECOMPILED void Boss5__Func_2177BB4(void);
NOT_DECOMPILED void Boss5__Func_2177C98(void);
NOT_DECOMPILED void Boss5__BossState_2177D7C(void);
NOT_DECOMPILED void Boss5__BossState_2177DC4(void);
NOT_DECOMPILED void Boss5__BossState_2177E0C(void);
NOT_DECOMPILED void Boss5__BossState_2177E24(void);
NOT_DECOMPILED void Boss5__BossState_2177EB0(void);
NOT_DECOMPILED void Boss5__BossState_2177EFC(void);
NOT_DECOMPILED void Boss5__BossState_2177F40(void);
NOT_DECOMPILED void Boss5__BossState_2177FFC(void);
NOT_DECOMPILED void Boss5__BossState_2178020(void);
NOT_DECOMPILED void Boss5__BossState_217822C(void);
NOT_DECOMPILED void Boss5__BossState_21783B8(void);
NOT_DECOMPILED void Boss5__BossState_2178418(void);
NOT_DECOMPILED void Boss5__BossState_2178444(void);
NOT_DECOMPILED void Boss5__BossState_2178478(void);
NOT_DECOMPILED void Boss5__BossState_21784E4(void);
NOT_DECOMPILED void Boss5__BossState_2178500(void);
NOT_DECOMPILED void Boss5__BossState_21785A4(void);
NOT_DECOMPILED void Boss5__BossState_21785C0(void);
NOT_DECOMPILED void Boss5__BossState_21785DC(void);
NOT_DECOMPILED void Boss5__BossState_2178600(void);
NOT_DECOMPILED void Boss5__BossState_2178680(void);
NOT_DECOMPILED void Boss5__BossState_2178684(void);
NOT_DECOMPILED void Boss5__BossState_21786E4(void);
NOT_DECOMPILED void Boss5__BossState_2178700(void);
NOT_DECOMPILED void Boss5__BossState_2178734(void);
NOT_DECOMPILED void Boss5__BossState_2178754(void);
NOT_DECOMPILED void Boss5__BossState_21787AC(void);
NOT_DECOMPILED void Boss5__BossState_21787DC(void);
NOT_DECOMPILED void Boss5__BossState_2178808(void);
NOT_DECOMPILED void Boss5__BossState_2178820(void);
NOT_DECOMPILED void Boss5__BossState_2178878(void);
NOT_DECOMPILED void Boss5__BossState_2178898(void);
NOT_DECOMPILED void Boss5__BossState_21788B8(void);
NOT_DECOMPILED void Boss5__BossState_21788FC(void);
NOT_DECOMPILED void Boss5__BossState_2178984(void);
NOT_DECOMPILED void Boss5__BossState_2178B44(void);
NOT_DECOMPILED void Boss5__BossState_2178B80(void);
NOT_DECOMPILED void Boss5__BossState_2178BAC(void);
NOT_DECOMPILED void Boss5__BossState_2178BF0(void);
NOT_DECOMPILED void Boss5__BossState_2178C08(void);
NOT_DECOMPILED void Boss5__BossState_2178CD4(void);
NOT_DECOMPILED void Boss5__BossState_2178D18(void);
NOT_DECOMPILED void Boss5__BossState_2178D38(void);
NOT_DECOMPILED void Boss5__BossState_2178DA0(void);
NOT_DECOMPILED void Boss5__BossState_2178E0C(void);
NOT_DECOMPILED void Boss5__BossState_2178E30(void);
NOT_DECOMPILED void Boss5__BossState_2178E50(void);
NOT_DECOMPILED void Boss5__BossState_2178F30(void);
NOT_DECOMPILED void Boss5__BossState_21790A0(void);
NOT_DECOMPILED void Boss5__BossState_21790D0(void);
NOT_DECOMPILED void Boss5__BossState_217911C(void);
NOT_DECOMPILED void Boss5__BossState_21791A0(void);
NOT_DECOMPILED void Boss5__BossState_2179218(void);
NOT_DECOMPILED void Boss5__BossState_2179248(void);
NOT_DECOMPILED void Boss5__BossState_2179264(void);
NOT_DECOMPILED void Boss5__BossState_217928C(void);
NOT_DECOMPILED void Boss5__BossState_21792E0(void);
NOT_DECOMPILED void Boss5__BossState_2179340(void);
NOT_DECOMPILED void Boss5__BossState_2179364(void);
NOT_DECOMPILED void Boss5__BossState_21793AC(void);
NOT_DECOMPILED void Boss5__BossState_21793C8(void);
NOT_DECOMPILED void Boss5__BossState_21793E4(void);
NOT_DECOMPILED void Boss5__BossState_2179400(void);
NOT_DECOMPILED void Boss5__BossState_2179464(void);
NOT_DECOMPILED void Boss5__BossState_2179480(void);
NOT_DECOMPILED void Boss5__BossState_21794C4(void);
NOT_DECOMPILED void Boss5__Func_217953C(void);
NOT_DECOMPILED void Boss5__BossState_2179584(void);
NOT_DECOMPILED void Boss5__BossState_2179640(void);
NOT_DECOMPILED void Boss5__BossState_21796D0(void);
NOT_DECOMPILED void Boss5__BossState_2179750(void);
NOT_DECOMPILED void Boss5__BossState_2179848(void);
NOT_DECOMPILED void Boss5__BossState_21798E0(void);
NOT_DECOMPILED void Boss5__BossState_2179974(void);

#endif // RUSH_BOSS5_H