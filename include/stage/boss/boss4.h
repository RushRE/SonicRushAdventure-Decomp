#ifndef RUSH_BOSS4_H
#define RUSH_BOSS4_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss4Stage_ Boss4Stage;
typedef struct Boss4_ Boss4;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss4Stage_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

struct Boss4_
{
    GameObjectTask gameWork;

    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss4Stage *Boss4Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss4 *Boss4__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss4Core__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4Ship__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4Pulley__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4FireColumn__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4FireBall__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

NOT_DECOMPILED void Boss4__Func_216C920(void);
NOT_DECOMPILED void Boss4__Func_216C9B0(void);
NOT_DECOMPILED void Boss4__Func_216C9EC(void);
NOT_DECOMPILED void Boss4__Func_216CA0C(void);
NOT_DECOMPILED void Boss4__Func_216CA68(void);
NOT_DECOMPILED void Boss4__Func_216CAC4(void);
NOT_DECOMPILED void Boss4__Func_216CB20(void);
NOT_DECOMPILED void Boss4__Func_216CB7C(void);
NOT_DECOMPILED void Boss4__Func_216CBCC(void);
NOT_DECOMPILED void Boss4__Func_216CC20(void);
NOT_DECOMPILED void Boss4__Func_216CCCC(void);
NOT_DECOMPILED void Boss4__Func_216CD28(void);
NOT_DECOMPILED void Boss4__Func_216CD84(void);
NOT_DECOMPILED void Boss4__Func_216CDAC(void);
NOT_DECOMPILED void Boss4__Func_216CDD8(void);
NOT_DECOMPILED void Boss4__Func_216CE04(void);
NOT_DECOMPILED void Boss4__Func_216CE28(void);
NOT_DECOMPILED void Boss4__Func_216CE80(void);
NOT_DECOMPILED void Boss4__Func_216CEE0(void);
NOT_DECOMPILED void Boss4__Func_216CF28(void);
NOT_DECOMPILED void Boss4__Func_216CF6C(void);
NOT_DECOMPILED void Boss4__Func_216D000(void);
NOT_DECOMPILED void Boss4__Func_216D02C(void);
NOT_DECOMPILED void Boss4__Func_216D064(void);
NOT_DECOMPILED void Boss4__Func_216D090(void);
NOT_DECOMPILED void Boss4__Func_216D0C8(void);
NOT_DECOMPILED void Boss4__Func_216D150(void);
NOT_DECOMPILED void Boss4__Func_216D1F4(void);
NOT_DECOMPILED void Boss4__Func_216D238(void);
NOT_DECOMPILED void Boss4__Func_216D644(void);
NOT_DECOMPILED void Boss4__Func_216D648(void);
NOT_DECOMPILED void Boss4__Func_216D6B4(void);
NOT_DECOMPILED void Boss4__Func_216D93C(void);
NOT_DECOMPILED void Boss4__Func_216D97C(void);
NOT_DECOMPILED void Boss4__Func_216D99C(void);
NOT_DECOMPILED void Boss4__Func_216D9D4(void);
NOT_DECOMPILED void Boss4__Func_216DB28(void);
NOT_DECOMPILED void Boss4__Func_216DB68(void);
NOT_DECOMPILED void Boss4__Func_216DB88(void);
NOT_DECOMPILED void Boss4__Func_216DC60(void);
NOT_DECOMPILED void Boss4__Func_216DDB4(void);
NOT_DECOMPILED void Boss4__Func_216DDE0(void);
NOT_DECOMPILED void Boss4__Func_216DEA4(void);
NOT_DECOMPILED void Boss4__Func_216DEE8(void);
NOT_DECOMPILED void Boss4__Func_216DF24(void);
NOT_DECOMPILED void Boss4__Func_216DF48(void);
NOT_DECOMPILED void Boss4__Func_216DFAC(void);
NOT_DECOMPILED void Boss4__Func_216DFB0(void);
NOT_DECOMPILED void Boss4__Func_216E06C(void);
NOT_DECOMPILED void Boss4__Func_216E118(void);
NOT_DECOMPILED void Boss4__Func_216E13C(void);
NOT_DECOMPILED void Boss4__Func_216E170(void);
NOT_DECOMPILED void ovl01_216E240(void);
NOT_DECOMPILED void Boss4__Func_216E324(void);
NOT_DECOMPILED void Boss4__Func_216E34C(void);
NOT_DECOMPILED void Boss4__Func_216E378(void);
NOT_DECOMPILED void Boss4__Func_216E388(void);
NOT_DECOMPILED void Boss4__Func_216E394(void);
NOT_DECOMPILED void Boss4__Func_216E3C4(void);
NOT_DECOMPILED void Boss4__Func_216E408(void);
NOT_DECOMPILED void Boss4__Func_216E498(void);
NOT_DECOMPILED void Boss4__Func_216E4E0(void);
NOT_DECOMPILED void Boss4__Func_216E51C(void);
NOT_DECOMPILED void Boss4__Func_216E594(void);
NOT_DECOMPILED void Boss4__Func_216E7F4(void);
NOT_DECOMPILED void Boss4__Func_216E850(void);
NOT_DECOMPILED void Boss4__Func_216E860(void);
NOT_DECOMPILED void Boss4__Func_216E870(void);
NOT_DECOMPILED void Boss4__Func_216E880(void);
NOT_DECOMPILED void Boss4__Func_216E890(void);
NOT_DECOMPILED void Boss4__Func_216E8EC(void);
NOT_DECOMPILED void Boss4__Func_216E970(void);
NOT_DECOMPILED void Boss4__Func_216EA08(void);
NOT_DECOMPILED void Boss4__Func_216EA98(void);
NOT_DECOMPILED void Boss4__Func_216EB0C(void);
NOT_DECOMPILED void Boss4__Func_216EB2C(void);
NOT_DECOMPILED void Boss4__Func_216EBC0(void);
NOT_DECOMPILED void Boss4__Func_216EBD8(void);
NOT_DECOMPILED void Boss4__Func_216EC08(void);
NOT_DECOMPILED void Boss4__Func_216EE48(void);
NOT_DECOMPILED void Boss4__Func_216EE98(void);
NOT_DECOMPILED void Boss4__Func_216F06C(void);
NOT_DECOMPILED void Boss4__Func_216F12C(void);
NOT_DECOMPILED void Boss4__Func_216F410(void);
NOT_DECOMPILED void Boss4__Func_216F558(void);
NOT_DECOMPILED void Boss4__Func_216F578(void);
NOT_DECOMPILED void Boss4__Func_216F590(void);
NOT_DECOMPILED void Boss4__Func_216F5EC(void);
NOT_DECOMPILED void Boss4__Func_216F720(void);
NOT_DECOMPILED void Boss4__Func_216F7D4(void);
NOT_DECOMPILED void Boss4__Func_216F864(void);
NOT_DECOMPILED void Boss4__Func_216F9E4(void);
NOT_DECOMPILED void Boss4__Func_216FAA0(void);
NOT_DECOMPILED void Boss4__Func_216FB5C(void);
NOT_DECOMPILED void Boss4__Func_216FB74(void);
NOT_DECOMPILED void Boss4__Func_216FBA4(void);
NOT_DECOMPILED void Boss4__Func_216FBE8(void);
NOT_DECOMPILED void Boss4__Func_216FC24(void);
NOT_DECOMPILED void Boss4__Func_216FC8C(void);
NOT_DECOMPILED void Boss4__Func_216FD08(void);
NOT_DECOMPILED void Boss4__Func_216FD80(void);
NOT_DECOMPILED void Boss4__Func_216FEB0(void);
NOT_DECOMPILED void Boss4__Func_216FF88(void);
NOT_DECOMPILED void Boss4__Func_216FF98(void);
NOT_DECOMPILED void Boss4__Func_216FFA8(void);
NOT_DECOMPILED void Boss4__Func_216FFB8(void);
NOT_DECOMPILED void Boss4__Func_2170000(void);
NOT_DECOMPILED void Boss4__Func_2170048(void);
NOT_DECOMPILED void Boss4__Func_2170090(void);
NOT_DECOMPILED void Boss4__Func_21700D8(void);
NOT_DECOMPILED void Boss4__Func_2170120(void);
NOT_DECOMPILED void Boss4__Func_2170130(void);
NOT_DECOMPILED void Boss4__Func_2170178(void);
NOT_DECOMPILED void Boss4__Func_21701C0(void);
NOT_DECOMPILED void Boss4__Func_21701CC(void);
NOT_DECOMPILED void Boss4__Func_2170220(void);
NOT_DECOMPILED void Boss4__Func_2170228(void);
NOT_DECOMPILED void Boss4__Func_2170234(void);
NOT_DECOMPILED void Boss4__Func_2170240(void);
NOT_DECOMPILED void Boss4__Func_2170258(void);
NOT_DECOMPILED void Boss4__Func_217027C(void);
NOT_DECOMPILED void Boss4__Func_21702C4(void);
NOT_DECOMPILED void Boss4__Func_2170300(void);
NOT_DECOMPILED void Boss4__Func_217033C(void);
NOT_DECOMPILED void Boss4__Func_2170370(void);
NOT_DECOMPILED void Boss4__Func_21703A4(void);
NOT_DECOMPILED void Boss4__Func_21704AC(void);
NOT_DECOMPILED void Boss4__Func_21704D8(void);
NOT_DECOMPILED void Boss4__Func_217051C(void);
NOT_DECOMPILED void Boss4__Func_217055C(void);
NOT_DECOMPILED void Boss4__Func_21705F0(void);
NOT_DECOMPILED void Boss4__Func_2170668(void);
NOT_DECOMPILED void Boss4__Func_2170680(void);
NOT_DECOMPILED void Boss4__Func_217069C(void);
NOT_DECOMPILED void Boss4__Func_217076C(void);
NOT_DECOMPILED void Boss4__Func_217083C(void);
NOT_DECOMPILED void Boss4__Func_2170888(void);
NOT_DECOMPILED void Boss4__Func_21708D0(void);
NOT_DECOMPILED void Boss4__Func_21708E8(void);
NOT_DECOMPILED void Boss4__Func_2170968(void);
NOT_DECOMPILED void Boss4__Func_21709A4(void);
NOT_DECOMPILED void Boss4__Func_21709E8(void);
NOT_DECOMPILED void Boss4__Func_2170A18(void);
NOT_DECOMPILED void Boss4__Func_2170A60(void);
NOT_DECOMPILED void Boss4__Func_2170AA8(void);
NOT_DECOMPILED void Boss4__Func_2170AE8(void);
NOT_DECOMPILED void Boss4__Func_2170B30(void);
NOT_DECOMPILED void Boss4__Func_2170B68(void);
NOT_DECOMPILED void Boss4__Func_2170BA4(void);
NOT_DECOMPILED void Boss4__Func_2170BE0(void);
NOT_DECOMPILED void Boss4__Func_2170BF8(void);
NOT_DECOMPILED void Boss4__Func_2170C20(void);
NOT_DECOMPILED void Boss4__Func_2170F30(void);
NOT_DECOMPILED void Boss4__Func_2170FD4(void);
NOT_DECOMPILED void Boss4__Func_217101C(void);
NOT_DECOMPILED void Boss4__Func_217105C(void);
NOT_DECOMPILED void Boss4__Func_21710FC(void);
NOT_DECOMPILED void Boss4__Func_2171190(void);
NOT_DECOMPILED void Boss4__Func_2171310(void);
NOT_DECOMPILED void Boss4__Func_2171434(void);
NOT_DECOMPILED void Boss4__Func_2171528(void);
NOT_DECOMPILED void Boss4__Func_2171620(void);
NOT_DECOMPILED void Boss4__Func_21717CC(void);
NOT_DECOMPILED void Boss4__Func_2171858(void);
NOT_DECOMPILED void Boss4__Func_2171874(void);
NOT_DECOMPILED void Boss4__Func_217187C(void);
NOT_DECOMPILED void Boss4__Func_21719BC(void);
NOT_DECOMPILED void Boss4__Func_2171A84(void);
NOT_DECOMPILED void Boss4__Func_2171B98(void);
NOT_DECOMPILED void Boss4__Func_2171BCC(void);
NOT_DECOMPILED void Boss4__Func_2171BFC(void);
NOT_DECOMPILED void Boss4__Func_2171C70(void);
NOT_DECOMPILED void Boss4__Func_2171CD0(void);
NOT_DECOMPILED void Boss4__Func_2171D10(void);
NOT_DECOMPILED void Boss4__Func_2171D44(void);
NOT_DECOMPILED void Boss4__Func_2171D5C(void);
NOT_DECOMPILED void Boss4__Func_2171E88(void);
NOT_DECOMPILED void Boss4__Func_2171EB4(void);
NOT_DECOMPILED void Boss4__Func_2171ECC(void);
NOT_DECOMPILED void Boss4__Func_2171EE4(void);
NOT_DECOMPILED void Boss4__Func_2171F10(void);
NOT_DECOMPILED void Boss4__Func_2171F30(void);
NOT_DECOMPILED void Boss4__Func_2171F48(void);
NOT_DECOMPILED void Boss4__Func_2171F60(void);
NOT_DECOMPILED void Boss4__Func_2171F84(void);
NOT_DECOMPILED void Boss4__Func_2171FA4(void);
NOT_DECOMPILED void Boss4__Func_2171FE8(void);
NOT_DECOMPILED void Boss4__Func_2172034(void);
NOT_DECOMPILED void Boss4__Func_2172080(void);
NOT_DECOMPILED void Boss4__Func_2172098(void);
NOT_DECOMPILED void Boss4__Func_21720E8(void);
NOT_DECOMPILED void Boss4__Func_2172134(void);
NOT_DECOMPILED void Boss4__Func_2172158(void);
NOT_DECOMPILED void Boss4__Func_21721A0(void);
NOT_DECOMPILED void Boss4__Func_21721B8(void);
NOT_DECOMPILED void Boss4__Func_21722A4(void);
NOT_DECOMPILED void Boss4__Func_2172358(void);
NOT_DECOMPILED void Boss4__Func_2172468(void);
NOT_DECOMPILED void Boss4__Func_21726AC(void);
NOT_DECOMPILED void Boss4__Func_217291C(void);
NOT_DECOMPILED void Boss4__Func_2172AB4(void);
NOT_DECOMPILED void Boss4__Func_2172C4C(void);
NOT_DECOMPILED void Boss4__Func_2172C54(void);
NOT_DECOMPILED void Boss4__Func_2172D9C(void);
NOT_DECOMPILED void Boss4__Func_2172DE0(void);
NOT_DECOMPILED void Boss4__Func_2172F04(void);
NOT_DECOMPILED void Boss4__Func_2172F94(void);
NOT_DECOMPILED void Boss4__Func_2173044(void);
NOT_DECOMPILED void Boss4__Func_2173174(void);
NOT_DECOMPILED void Boss4__Func_2173330(void);
NOT_DECOMPILED void Boss4__Func_21737C8(void);
NOT_DECOMPILED void Boss4__Func_2173830(void);
NOT_DECOMPILED void Boss4__Func_21738DC(void);
NOT_DECOMPILED void Boss4__Func_21739C0(void);

#endif // RUSH_BOSS4_H