#ifndef RUSH_BOSS6_H
#define RUSH_BOSS6_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss6Stage_ Boss6Stage;
typedef struct Boss6_ Boss6;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss6Stage_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

struct Boss6_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss6Stage *Boss6Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss6 *Boss6__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss6Platform__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6EnemyA__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6EnemyB__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6Missile__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6Ring__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

NOT_DECOMPILED fx32 Boss6Stage__GetScrollSpeed(void);
NOT_DECOMPILED void Boss6Stage__PlayerDraw(void);
NOT_DECOMPILED void Boss6Stage__DrawPlayer(void);
NOT_DECOMPILED void Boss6Stage__Func_2154EB4(void);
NOT_DECOMPILED void Boss6Stage__LoadAssets(void);
NOT_DECOMPILED void Boss6Stage__Func_2154FE4(void);
NOT_DECOMPILED void Boss6Stage__Func_21550CC(void);
NOT_DECOMPILED void Boss6Stage__Func_2155220(void);
NOT_DECOMPILED void Boss6Enemy__OnDefend_2155270(void);
NOT_DECOMPILED void Boss6Stage__FindStoodPlatform(void);
NOT_DECOMPILED void Boss6Stage__Func_215532C(void);
NOT_DECOMPILED void Boss6Stage__Func_2155354(void);
NOT_DECOMPILED void Boss6Stage__Func_2155390(void);
NOT_DECOMPILED void Boss6Stage__Func_215553C(void);
NOT_DECOMPILED void Boss6Stage__Func_2155580(void);
NOT_DECOMPILED void Boss6Stage__Func_21555CC(void);
NOT_DECOMPILED void Boss6Stage__Func_215566C(void);
NOT_DECOMPILED void Boss6Stage__Func_2155744(void);
NOT_DECOMPILED void Boss6Stage__Func_215577C(void);
NOT_DECOMPILED void Boss6Stage__Func_21557FC(void);
NOT_DECOMPILED void Boss6Stage__Func_2155820(void);
NOT_DECOMPILED void Boss6Stage__Func_2155830(void);
NOT_DECOMPILED void Boss6Stage__Func_2155848(void);
NOT_DECOMPILED void Boss6Stage__Func_2155854(void);
NOT_DECOMPILED void Boss6Stage__Func_2155880(void);
NOT_DECOMPILED void Boss6Stage__Func_21558D8(void);
NOT_DECOMPILED void Boss6Stage__Func_21558E8(void);
NOT_DECOMPILED void Boss6Stage__Func_21558F0(void);
NOT_DECOMPILED void Boss6Stage__GetPhase(void);
NOT_DECOMPILED void Boss6Stage__GetBossDmg(void);
NOT_DECOMPILED void Boss6Stage__GetDamageMultiplier(void);
NOT_DECOMPILED void Boss6Stage__Func_2155A78(void);
NOT_DECOMPILED void Boss6Stage__Func_2155AB8(void);
NOT_DECOMPILED void Boss6Stage__Func_2155B40(void);
NOT_DECOMPILED void Boss6Stage__Func_2155B80(void);
NOT_DECOMPILED void Boss6Stage__Func_2155BBC(void);
NOT_DECOMPILED void Boss6Stage__Func_2155C00(void);
NOT_DECOMPILED void Boss6Stage__Func_2155C88(void);
NOT_DECOMPILED void Boss6Stage__Func_2155CCC(void);
NOT_DECOMPILED void Boss6Stage__Func_2155D70(void);
NOT_DECOMPILED void Boss6Stage__Func_2155D8C(void);
NOT_DECOMPILED void Boss6Stage__Func_2155DEC(void);
NOT_DECOMPILED void Boss6Stage__Func_2155E04(void);
NOT_DECOMPILED void Boss6Stage__Func_2155E1C(void);
NOT_DECOMPILED void Boss6Stage__Func_2155E38(void);
NOT_DECOMPILED void Boss6Stage__Func_2155EB4(void);
NOT_DECOMPILED void Boss6Stage__Func_2155FAC(void);
NOT_DECOMPILED void Boss6Stage__Func_21560A0(void);
NOT_DECOMPILED void Boss6Stage__Func_2156148(void);
NOT_DECOMPILED void Boss6Stage__InitChunkList(void);
NOT_DECOMPILED void Boss6Stage__HandleStageChunks(void);
NOT_DECOMPILED void Boss6Stage__DrawStage(void);
NOT_DECOMPILED void Boss6Stage__HandleChunkAngle(void);
NOT_DECOMPILED void Boss6Stage__HandleHUDSwitch(void);
NOT_DECOMPILED void Boss6Stage__State_21565D8(void);
NOT_DECOMPILED void Boss6Stage__Destructor(void);
NOT_DECOMPILED void Boss6Stage__Draw(void);
NOT_DECOMPILED void Boss6Stage__State2_2156834(void);
NOT_DECOMPILED void Boss6Stage__State2_21569B4(void);
NOT_DECOMPILED void Boss6__Func_21569D0(void);
NOT_DECOMPILED void Boss6__Func_2156A00(void);
NOT_DECOMPILED void Boss6__Func_2156ACC(void);
NOT_DECOMPILED void Boss6__Func_2156BD0(void);
NOT_DECOMPILED void Boss6__State_2156D34(void);
NOT_DECOMPILED void Boss6__Destructor(void);
NOT_DECOMPILED void Boss6__Draw(void);
NOT_DECOMPILED void Boss6__Func_2156FDC(void);
NOT_DECOMPILED void Boss6__Collide(void);
NOT_DECOMPILED void Boss6__OnDefend_215708C(void);
NOT_DECOMPILED void Boss6__Func_215727C(void);
NOT_DECOMPILED void Boss6__Action_215746C(void);
NOT_DECOMPILED void Boss6__Action_2157484(void);
NOT_DECOMPILED void Boss6__Action_21574C8(void);
NOT_DECOMPILED void ovl02_21575D0(void);
NOT_DECOMPILED void Boss6__Action_2157610(void);
NOT_DECOMPILED void Boss6__Action_2157630(void);
NOT_DECOMPILED void Boss6__Action_2157650(void);
NOT_DECOMPILED void Boss6__Action_Die(void);
NOT_DECOMPILED void Boss6__State2_2157690(void);
NOT_DECOMPILED void Boss6__State2_21576B0(void);
NOT_DECOMPILED void Boss6__State2_2157700(void);
NOT_DECOMPILED void Boss6__State2_2157750(void);
NOT_DECOMPILED void Boss6__Func_21578F0(void);
NOT_DECOMPILED void Boss6__Func_2157994(void);
NOT_DECOMPILED void Boss6__Func_2157A1C(void);
NOT_DECOMPILED void Boss6__Func_2157AB4(void);
NOT_DECOMPILED void Boss6__Func_2157B84(void);
NOT_DECOMPILED void Boss6__Func_2157BCC(void);
NOT_DECOMPILED void Boss6__State2_2157C4C(void);
NOT_DECOMPILED void Boss6__State2_2157C64(void);
NOT_DECOMPILED void Boss6__State2_2157CB0(void);
NOT_DECOMPILED void Boss6__State2_2157CDC(void);
NOT_DECOMPILED void Boss6__State2_2157E2C(void);
NOT_DECOMPILED void Boss6__State2_2157E6C(void);
NOT_DECOMPILED void Boss6__Func_2157ED8(void);
NOT_DECOMPILED void Boss6__Func_2157F68(void);
NOT_DECOMPILED void Boss6__Func_2157FA8(void);
NOT_DECOMPILED void Boss6__Func_2158040(void);
NOT_DECOMPILED void Boss6__Func_2158080(void);
NOT_DECOMPILED void Boss6__State2_21580AC(void);
NOT_DECOMPILED void Boss6__State2_21580BC(void);
NOT_DECOMPILED void Boss6__State2_2158118(void);
NOT_DECOMPILED void Boss6__State2_215815C(void);
NOT_DECOMPILED void Boss6__State2_215817C(void);
NOT_DECOMPILED void Boss6__State2_2158224(void);
NOT_DECOMPILED void Boss6__State2_2158280(void);
NOT_DECOMPILED void Boss6__State2_21582D0(void);
NOT_DECOMPILED void Boss6__State2_2158374(void);
NOT_DECOMPILED void Boss6__State2_2158464(void);
NOT_DECOMPILED void Boss6__State2_21585FC(void);
NOT_DECOMPILED void Boss6__State2_21586BC(void);
NOT_DECOMPILED void Boss6__State2_215884C(void);
NOT_DECOMPILED void Boss6__State2_21588B4(void);
NOT_DECOMPILED void Boss6__State2_2158C18(void);
NOT_DECOMPILED void Boss6__State2_2158D3C(void);
NOT_DECOMPILED void Boss6__State2_2158F28(void);
NOT_DECOMPILED void Boss6__Func_2159018(void);
NOT_DECOMPILED void Boss6__State2_2159218(void);
NOT_DECOMPILED void Boss6__State2_2159250(void);
NOT_DECOMPILED void Boss6__State2_21592CC(void);
NOT_DECOMPILED void Boss6__State2_21593BC(void);
NOT_DECOMPILED void Boss6__State2_21594B4(void);
NOT_DECOMPILED void Boss6__State2_2159508(void);
NOT_DECOMPILED void Boss6__State2_2159624(void);
NOT_DECOMPILED void Boss6__Func_2159834(void);
NOT_DECOMPILED void Boss6__Func_2159948(void);
NOT_DECOMPILED void Boss6__State2_21599E0(void);
NOT_DECOMPILED void Boss6__State2_2159A80(void);
NOT_DECOMPILED void Boss6__State2_2159AA4(void);
NOT_DECOMPILED void Boss6__State2_2159B68(void);
NOT_DECOMPILED void Boss6__State2_2159CF8(void);
NOT_DECOMPILED void Boss6__State2_2159D70(void);
NOT_DECOMPILED void Boss6__State2_2159DB4(void);
NOT_DECOMPILED void Boss6__State2_2159ED8(void);
NOT_DECOMPILED void Boss6__State2_2159FAC(void);
NOT_DECOMPILED void Boss6__State2_215A014(void);
NOT_DECOMPILED void Boss6__State2_215A150(void);
NOT_DECOMPILED void Boss6__State2_215A1E4(void);
NOT_DECOMPILED void Boss6__State2_215A294(void);
NOT_DECOMPILED void Boss6Platform__GetOtherPlatform(void);
NOT_DECOMPILED void Boss6Platform__State_215A2C4(void);
NOT_DECOMPILED void Boss6Platform__Destructor(void);
NOT_DECOMPILED void Boss6Platform__Draw(void);
NOT_DECOMPILED void Boss6Platform__Action_215A550(void);
NOT_DECOMPILED void Boss6Platform__Action_215A598(void);
NOT_DECOMPILED void Boss6Platform__Action_215A5B8(void);
NOT_DECOMPILED void Boss6Platform__Action_215A5D8(void);
NOT_DECOMPILED void Boss6Platform__Action_215A618(void);
NOT_DECOMPILED void Boss6Platform__State2_215A668(void);
NOT_DECOMPILED void Boss6Platform__State2_215A694(void);
NOT_DECOMPILED void Boss6Platform__Func_215A7AC(void);
NOT_DECOMPILED void Boss6Platform__Func_215A818(void);
NOT_DECOMPILED void Boss6Platform__Func_215A85C(void);
NOT_DECOMPILED void Boss6Platform__State2_215AA0C(void);
NOT_DECOMPILED void Boss6Platform__State2_215AA28(void);
NOT_DECOMPILED void Boss6Platform__State2_215AA38(void);
NOT_DECOMPILED void Boss6Platform__State2_215AA54(void);
NOT_DECOMPILED void Boss6Platform__Func_215AA64(void);
NOT_DECOMPILED void Boss6Platform__State2_215AAE8(void);
NOT_DECOMPILED void Boss6Platform__State2_215AB08(void);
NOT_DECOMPILED void Boss6Platform__State2_215AC80(void);
NOT_DECOMPILED void Boss6Platform__State2_215ACB0(void);
NOT_DECOMPILED void Boss6Platform__State2_215ADF4(void);
NOT_DECOMPILED void Boss6Platform__State2_215AE54(void);
NOT_DECOMPILED void Boss6Platform__State2_215AEF4(void);
NOT_DECOMPILED void Boss6Platform__State2_215AF20(void);
NOT_DECOMPILED void Boss6Platform__State2_215AFF0(void);
NOT_DECOMPILED void Boss6Platform__State2_215B050(void);
NOT_DECOMPILED void Boss6Platform__State2_215B12C(void);
NOT_DECOMPILED void Boss6Platform__Func_215B284(void);
NOT_DECOMPILED void Boss6Platform__State2_215B308(void);
NOT_DECOMPILED void Boss6Platform__State2_215B320(void);
NOT_DECOMPILED void Boss6Platform__State2_215B3D4(void);
NOT_DECOMPILED void Boss6Platform__State2_215B570(void);
NOT_DECOMPILED void Boss6Platform__State2_215B610(void);
NOT_DECOMPILED void Boss6Platform__State2_215B644(void);
NOT_DECOMPILED void Boss6Platform__State2_215B6B4(void);
NOT_DECOMPILED void Boss6Platform__State2_215B778(void);
NOT_DECOMPILED void Boss6__SpawnEnemyA(void);
NOT_DECOMPILED void Boss6EnemyA__State_215B928(void);
NOT_DECOMPILED void Boss6EnemyA__Action_215B938(void);
NOT_DECOMPILED void Boss6EnemyA__State2_215B950(void);
NOT_DECOMPILED void Boss6EnemyA__State2_215B9BC(void);
NOT_DECOMPILED void Boss6__SpawnEnemyB(void);
NOT_DECOMPILED void Boss6EnemyB__State_215BA88(void);
NOT_DECOMPILED void Boss6EnemyB__Destructor(void);
NOT_DECOMPILED void Boss6EnemyB__Draw(void);
NOT_DECOMPILED void Boss6EnemyB__Action_215BBA0(void);
NOT_DECOMPILED void Boss6EnemyB__Action_215BBB8(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BBD8(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BC6C(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BCE0(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BCF8(void);
NOT_DECOMPILED void ovl02_215BCFC(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BD4C(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BDA8(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BDB8(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BE14(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BE24(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BE74(void);
NOT_DECOMPILED void Boss6EnemyB__Func_215BED8(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BF50(void);
NOT_DECOMPILED void Boss6EnemyB__State2_215BFA0(void);
NOT_DECOMPILED void Boss6__SpawnMissile(void);
NOT_DECOMPILED void Boss6Missile__Func_215C10C(void);
NOT_DECOMPILED void Boss6Missile__Func_215C1C4(void);
NOT_DECOMPILED void Boss6Missile__State_215C32C(void);
NOT_DECOMPILED void Boss6Missile__Collide(void);
NOT_DECOMPILED void Boss6Missile__OnHit(void);
NOT_DECOMPILED void Boss6Missile__Action_215C494(void);
NOT_DECOMPILED void Boss6Missile__Action_215C4AC(void);
NOT_DECOMPILED void Boss6Missile__State2_215C4C4(void);
NOT_DECOMPILED void Boss6Missile__State2_215C6A0(void);
NOT_DECOMPILED void Boss6Missile__State2_215C7B8(void);
NOT_DECOMPILED void Boss6__SpawnRing(void);
NOT_DECOMPILED void Boss6Ring__State_215C810(void);
NOT_DECOMPILED void Boss6Ring__Draw(void);
NOT_DECOMPILED void Boss6Ring__OnDefend(void);

#endif // RUSH_BOSS6_H