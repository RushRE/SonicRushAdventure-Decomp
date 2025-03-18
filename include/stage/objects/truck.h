#ifndef RUSH_TRUCK_H
#define RUSH_TRUCK_H

#include <stage/gameObject.h>
#include <game/graphics/paletteAnimation.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Truck3DObject_
{
    GameObjectTask gameWork;
    VecFx32 position;
} Truck3DObject;

typedef struct Truck3DUnknown_
{
    u8 objectType[4];
    u16 count[3];
    u8 field_A;
    u8 field_B;
    Truck3DObject *objectPtr[16];
    s32 field_4C;
    s32 field_50;
    s32 field_54;
    s32 field_58;
    s32 field_5C;
    s32 field_60;
    s32 field_64;
    s32 field_68;
    s32 field_6C;
    s32 field_70;
    s32 field_74;
    VecFx32 field_78[2];
    s32 field_90;
    s32 field_94;
    s32 field_98;
    s16 field_9C;
    s16 field_9E;
    s32 field_A0;
    s16 field_A4;
    s16 field_A6;
    s32 field_A8;
    u8 field_AC;
    u8 field_AD;
    u8 trackFlags;
    u8 field_AF;
    u8 field_B0;
    u8 field_B1;
    u8 field_B2;
    u8 field_B3;
    s32 field_B4;
    s32 field_B8;
    s32 field_BC;
    s32 field_C0;
    s32 field_C4;
    s32 field_C8;
    s32 field_CC;
    s32 field_D0;
    s32 field_D4;
    s32 field_D8;
    s32 field_DC;
    s32 field_E0;
    s32 field_E4;
    s32 field_E8;
    s32 field_EC;
    s32 field_F0;
    s32 field_F4;
    s32 field_F8;
    s32 field_FC;
    s32 field_100;
    s32 field_104;
    s32 field_108;
    s32 field_10C;
    s32 field_110;
    s32 field_114;
    s32 field_118;
    s32 field_11C;
    s32 field_120;
    s32 field_124;
    s32 field_128;
    s32 field_12C;
    s32 field_130;
    s32 field_134;
    s32 field_138;
    s32 field_13C;
    s32 field_140;
    s32 field_144;
    s32 field_148;
    s32 field_14C;
    s32 field_150;
    s32 field_154;
    s32 field_158;
    s32 field_15C;
    s32 field_160;
    s32 field_164;
    s32 field_168;
    s32 field_16C;
    s32 field_170;
    s32 field_174;
    s32 field_178;
    s32 field_17C;
    s32 field_180;
    s32 field_184;
    s32 field_188;
    s32 field_18C;
    s32 field_190;
    s32 field_194;
    s32 field_198;
    s32 field_19C;
    s32 field_1A0;
    s32 field_1A4;
    s32 field_1A8;
    s32 field_1AC;
    s32 field_1B0;
    s32 field_1B4;
    s32 field_1B8;
    s32 field_1BC;
    s32 field_1C0;
    s32 field_1C4;
    s32 field_1C8;
    s32 field_1CC;
    s32 field_1D0;
    s32 field_1D4;
    s32 field_1D8;
    s32 field_1DC;
    s32 field_1E0;
    s32 field_1E4;
    s32 field_1E8;
    s32 field_1EC;
    s32 field_1F0;
    s32 field_1F4;
    s32 field_1F8;
    s32 field_1FC;
    s32 field_200;
    s32 field_204;
    s32 field_208;
    s32 field_20C;
    s32 field_210;
    s32 field_214;
    s32 field_218;
    s32 field_21C;
    s32 field_220;
    s32 field_224;
    s32 field_228;
    s32 field_22C;
    s32 field_230;
    s32 field_234;
    s32 field_238;
    s32 field_23C;
    s32 field_240;
    s32 field_244;
    s32 field_248;
    s32 field_24C;
    s32 field_250;
    s32 field_254;
    s32 field_258;
    s32 field_25C;
    s32 field_260;
    s16 field_264;
    s16 field_266;
    s32 field_268;
    s32 field_26C;
    s32 field_270;
    s32 field_274;
    s32 field_278;
    s32 field_27C;
    s32 field_280;
    s32 field_284;
    s32 field_288;
    s32 field_28C;
    s32 field_290;
    s32 field_294;
    s32 field_298;
    s32 field_29C;
    s32 field_2A0;
    s32 field_2A4;
    s32 field_2A8;
    s32 field_2AC;
    s32 field_2B0;
    s32 field_2B4;
    s32 field_2B8;
    s32 field_2BC;
    s32 field_2C0;
    s32 field_2C4;
    s32 field_2C8;
    s32 field_2CC;
    s32 field_2D0;
    s32 field_2D4;
    s32 field_2D8;
    s32 field_2DC;
    s32 field_2E0;
    s32 field_2E4;
    s32 field_2E8;
    s32 field_2EC;
    s32 field_2F0;
    s32 field_2F4;
    s32 field_2F8;
    s32 field_2FC;
    s32 field_300;
    s32 field_304;
    s32 field_308;
    s32 field_30C;
    s32 field_310;
    s32 field_314;
    s32 field_318;
    s32 field_31C;
    s32 field_320;
    s32 field_324;
    s32 field_328;
    s32 field_32C;
    s32 field_330;
    s32 field_334;
    s32 field_338;
    s32 field_33C;
    s32 field_340;
    s32 field_344;
    s32 field_348;
    s32 field_34C;
    s32 field_350;
    s32 field_354;
    s32 field_358;
    s32 field_35C;
    s32 field_360;
    s32 field_364;
    s32 field_368;
    s32 field_36C;
    s32 field_370;
    s32 field_374;
    s32 field_378;
    s32 field_37C;
    s32 field_380;
    s32 field_384;
    s32 field_388;
    s32 field_38C;
    s32 field_390;
    s32 field_394;
    s32 field_398;
    s32 field_39C;
    s32 field_3A0;
    s32 field_3A4;
    s32 field_3A8;
    s32 field_3AC;
    s32 field_3B0;
    s32 field_3B4;
    s32 field_3B8;
    s32 field_3BC;
    s32 field_3C0;
    s32 field_3C4;
    s32 field_3C8;
    s32 field_3CC;
    s32 field_3D0;
    s32 field_3D4;
    s32 field_3D8;
    s32 field_3DC;
    s32 field_3E0;
    s32 field_3E4;
    s32 field_3E8;
    s32 field_3EC;
    s32 field_3F0;
    s32 field_3F4;
    s32 field_3F8;
    s32 field_3FC;
    s32 field_400;
    s32 field_404;
    s32 field_408;
    s32 field_40C;
    s32 field_410;
    s32 field_414;
    s16 field_418;
    s16 field_41A;
    s32 field_41C;
    s32 field_420;
    s32 field_424;
    s32 field_428;
    s32 field_42C;
    s32 field_430;
    s32 field_434;
    s32 field_438;
    s32 field_43C;
    s32 field_440;
    s32 field_444;
    s32 field_448;
    s32 field_44C;
    s32 field_450;
    s32 field_454;
    s32 field_458;
    s32 field_45C;
    s32 field_460;
    s32 field_464;
    s32 field_468;
    s32 field_46C;
    s32 field_470;
    s32 field_474;
    s32 field_478;
    s32 field_47C;
    s32 field_480;
    s32 field_484;
    s32 field_488;
    s32 field_48C;
    s32 field_490;
    s32 field_494;
    s32 field_498;
    s32 field_49C;
    s32 field_4A0;
    s32 field_4A4;
    s32 field_4A8;
    s32 field_4AC;
    s32 field_4B0;
    s32 field_4B4;
    s32 field_4B8;
    s32 field_4BC;
    s32 field_4C0;
    s32 field_4C4;
    s32 field_4C8;
    s32 field_4CC;
    s32 field_4D0;
    s32 field_4D4;
    s32 field_4D8;
    s32 field_4DC;
    s32 field_4E0;
    s32 field_4E4;
    s32 field_4E8;
    s32 field_4EC;
    s32 field_4F0;
    s32 field_4F4;
    s32 field_4F8;
    s32 field_4FC;
    s32 field_500;
    s32 field_504;
    s32 field_508;
    s32 field_50C;
    s32 field_510;
    s32 field_514;
    s32 field_518;
    s32 field_51C;
    s32 field_520;
    s32 field_524;
    s32 field_528;
    s32 field_52C;
    s32 field_530;
    s32 field_534;
    s32 field_538;
    s32 field_53C;
    s32 field_540;
    s32 field_544;
    s32 field_548;
    s32 field_54C;
    s32 field_550;
    s32 field_554;
    s32 field_558;
    s32 field_55C;
    s32 field_560;
    s32 field_564;
    s32 field_568;
    s32 field_56C;
    s32 field_570;
    s32 field_574;
    s32 field_578;
    s32 field_57C;
    s32 field_580;
    s32 field_584;
    s32 field_588;
    s32 field_58C;
    s32 field_590;
    s32 field_594;
    s32 field_598;
    s32 field_59C;
    s32 field_5A0;
    s32 field_5A4;
    s32 field_5A8;
    s32 field_5AC;
    s32 field_5B0;
    s32 field_5B4;
    s32 field_5B8;
    s32 field_5BC;
    s32 field_5C0;
    s32 field_5C4;
    s32 field_5C8;
    s32 field_5CC;
} Truck3DUnknown;

typedef struct Truck_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniTruck;
    AnimatorMDL aniTruckTrack[6];
    AnimatorSprite3D aniRing;
    AnimatorSprite3D aniRingSparkle;
    s32 field_E80;
    Truck3DUnknown trackList[8];
    s16 currentTrackSlot;
    s16 nextTrackSlot;
    s32 field_3D08;
    s32 field_3D0C;
    s32 field_3D10;
    s32 field_3D14;
    s32 field_3D18;
    s16 field_3D1C;
    s16 field_3D1E;
    s32 field_3D20;
    s32 field_3D24;
    s32 field_3D28;
    s32 field_3D2C;
    s16 field_3D30;
    u16 field_3D32;
    s16 field_3D34;
    s16 word3D36;
    VecFx32 field_3D38;
    GXDLInfo gxInfo;
    void *cmdList;
    AnimatorSprite3D aniCandle1;
    AnimatorSprite3D aniCandle2;
    PaletteAnimator palCandle;
} Truck;

typedef struct TruckBarrier_
{
    GameObjectTask gameWork;
} TruckBarrier;

typedef struct Truck3DTrigger_
{
    GameObjectTask gameWork;
} Truck3DTrigger;

typedef struct Truck3DRing_
{
    Truck3DObject trackWork;
    AnimatorSprite3D aniRing;
} Truck3DRing;

typedef struct Truck3DItemBox_
{
    Truck3DObject trackWork;
    AnimatorSprite3D aniBox;
    AnimatorSprite3D aniIcon;
} Truck3DItemBox;

typedef struct Truck3DBomb_
{
    Truck3DObject trackWork;
    AnimatorSprite3D aniBomb;
} Truck3DBomb;

typedef struct Truck3DSpike_
{
    Truck3DObject trackWork;
    AnimatorSprite3D aniSpike;
} Truck3DSpike;

typedef struct Truck3DLava_
{
    Truck3DObject trackWork;
    PaletteAnimator aniPalette;
    VRAMPixelKey vramTexture;
    VRAMPaletteKey vramPalette;
    GXDLInfo gxdlInfo;
    void *drawData;
} Truck3DLava;

// --------------------
// FUNCTIONS
// --------------------

Truck *Truck__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Truck__Action_PlayerEnter(Player *player, Truck *truck);

TruckBarrier *TruckBarrier__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Truck__Action_Enter3D(Truck *work);

Truck3DTrigger *Truck3DTrigger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Truck__Func_216F760(Truck *work, Truck3DUnknown *trackPart);
void Truck__Func_216FB6C(Truck3DUnknown *work);

Truck3DRing *Truck3DRing__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Truck3DRing__Draw_216FD0C(void);
void Truck3DRing__OnDefend_216FDE8(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

Truck3DItemBox *Truck3DItemBox__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Truck3DItemBox__Destructor(Task *task);
void Truck3DItemBox__State_21700D4(Truck3DItemBox *work);
void Truck3DItemBox__Draw(void);
void Truck3DItemBox__OnDefend_21701EC(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

Truck3DBomb *TruckBomb3D__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void TruckBomb3D__State_217044C(Truck3DBomb *work);
void TruckBomb3D__OnHit_217050C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

Truck3DSpike *TruckSpike3D__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void TruckSpike3D__State_2170714(Truck3DSpike *work);

Truck3DLava *TruckLava3D__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void TruckLava3D__Destructor(Task *task);
void TruckLava3D__Draw_2170B24(void);

void Truck__Destructor(Task *task);
void Truck__State_2170D44(Truck *work);
void Truck__State_2170E10(Truck *work);
void Truck__State_2171064(Truck *work);
void Truck__Func_21711D8(Truck *work);
void Truck__State_2171280(Truck *work);
void Truck__OnDefend_21712A4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Truck__State_2171368(Truck *work);
void Truck__State_2171724(Truck *work);
void Truck__State_2171F98(Truck *work);
void Truck__Draw_21724F4(void);
void Truck3DTrigger__OnDefend_2173030(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Truck__Func_2173204(Truck *work);
void Truck__Func_217322C(Truck *work);
void Truck__Func_2173304(Truck *work);

#endif // RUSH_TRUCK_H
