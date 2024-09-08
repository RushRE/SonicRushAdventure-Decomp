#ifndef RUSH2_PIRATE_H
#define RUSH2_PIRATE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyPirate_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    s32 field_3A4;
    s32 field_3A8;
    void (*onInit)(struct EnemyPirate_ *work);
    void (*onDetect)(struct EnemyPirate_ *work);
    s32 xMin;
    s32 field_3B8;
    s32 xMax;
    s32 field_3C0;
    s16 field_3C4;
    u16 type;
    s32 field_3C8;
    s32 field_3CC;

    union EnemyPirateUnknown2
    {
        struct EnemyPirateUnknown2Config13
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown13;

        struct EnemyPirateUnknown2Config14
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown14;

        struct EnemyPirateUnknown2Config15
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown15;

        struct EnemyPirateUnknown2Config16
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown16;

        struct EnemyPirateUnknown2Config17
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown17;

        struct EnemyPirateUnknown2Config18
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown18;

        struct EnemyPirateUnknown2Config19
        {
            u16 anim;
            u16 field_2;
            u16 field_4;
            u16 field_6;
            u16 field_8;
            u16 field_A;
            u16 field_C;
            u16 field_E;
            u32 field_10;
        } unknown19;
    } field_3D0;

    struct EnemyPirateUnknown
    {
        u16 anim;
        u16 duration;
        u16 field_4;
        u16 field_6;
        void (*state)(struct EnemyPirate_ *work);
    } config;

    void *field_3F0;
} EnemyPirate;

typedef struct EnemyBazookaPirateShot_
{
    GameObjectTask gameWork;
} EnemyBazookaPirateShot;

typedef struct EnemyBallChainPirateBall_
{
    GameObjectTask gameWork;
    GameObjectTask childWork;
    void (*onUnknown)(struct EnemyBallChainPirateBall_ *work);
    u16 field_6CC;
    u16 field_6CE;
    u16 field_6D0;
    u16 field_6D2;
    Vec2Fx32 field_6D4;
    s32 field_6DC;
} EnemyBallChainPirateBall;

typedef struct EnemyBombPirateBomb_
{
    GameObjectTask gameWork;
    u16 field_364;
} EnemyBombPirateBomb;

typedef struct EnemySkeletonPirateBone_
{
    GameObjectTask gameWork;
    u16 field_364;
    u16 field_366;
} EnemySkeletonPirateBone;

typedef struct EnemyHoverBomberPirateBomb_
{
    GameObjectTask gameWork;
} EnemyHoverBomberPirateBomb;

typedef struct EnemyHoverGunnerPirateShot_
{
    GameObjectTask gameWork;
} EnemyHoverGunnerPirateShot;

// --------------------
// FUNCTIONS
// --------------------

EnemyPirate *EnemyPirate__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyBazookaPirateShot *EnemyBazookaPirateShot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyBallChainPirateBall *EnemyBallChainPirateBall__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyBombPirateBomb *EnemyBombPirateBomb__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemySkeletonPirateBone *EnemySkeletonPirateBone__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyHoverBomberPirateBomb *EnemyHoverBomberPirateBomb__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemyHoverGunnerPirateShot *EnemyHoverGunnerPirateShot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyPirate__Func_215A000(EnemyPirate *work);
void EnemyPirate__Func_215A028(EnemyPirate *work);
void EnemyBallChainPirateBall__Destructor(Task *task);
void EnemyPirate__Func_215A0D0(EnemyPirate *work);
void EnemyBallChainPirateBall__State_215A198(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Draw_215A224(void);
void EnemyPirate__OnInit_215A36C(EnemyPirate *work);
void EnemyPirate__State_215A3A4(EnemyPirate *work);
void EnemyPirate__OnInit_215A618(EnemyPirate *work);
void EnemyPirate__OnInit_215A674(EnemyPirate *work);
void EnemyPirate__State_215A6AC(EnemyPirate *work);
void EnemyPirate__OnDetect_215A714(EnemyPirate *work);
void EnemyPirate__State_215A768(EnemyPirate *work);
void EnemyPirate__State_215A7A4(EnemyPirate *work);
void EnemyPirate__State_215A7D0(EnemyPirate *work);
void EnemyPirate__State_215A828(EnemyPirate *work);
void EnemyPirate__State_215A8CC(EnemyPirate *work);
void EnemyPirate__Func_215AA2C(EnemyPirate *work);
void EnemyBazookaPirateShot__State_215AB70(EnemyBazookaPirateShot *work);
void EnemyBazookaPirateShot__State_215AB9C(EnemyBazookaPirateShot *work);
void EnemyBallChainPirateBall__Unknown_215AC34(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215ACBC(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215AE0C(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215AEE0(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215AFD0(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215B170(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215B18C(EnemyBallChainPirateBall *work);
void EnemyBallChainPirateBall__Unknown_215B1B8(EnemyBallChainPirateBall *work);
void EnemyBombPirateBomb__State_215B218(EnemyBombPirateBomb *work);
void EnemyBombPirateBomb__State_215B2B4(EnemyBombPirateBomb *work);
void EnemyBombPirateBomb__State_215B388(EnemyBombPirateBomb *work);
void EnemySkeletonPirateBone__State_215B434(EnemySkeletonPirateBone *work);
void EnemySkeletonPirateBone__State_215B4C8(EnemySkeletonPirateBone *work);
void EnemyHoverBomberPirateBomb__State_215B4F4(EnemyHoverBomberPirateBomb *work);
void EnemyHoverBomberPirateBomb__State_215B528(EnemyHoverBomberPirateBomb *work);
void EnemyHoverGunnerPirateShot__State_215B5C0(EnemyHoverGunnerPirateShot *work);
void EnemyHoverGunnerPirateShot__State_215B5EC(EnemyHoverGunnerPirateShot *work);
void EnemyBazookaPirateShot__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyBombPirateBomb__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemySkeletonPirateBone__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyHoverBomberPirateBomb__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyPirate__OnDefend_215B83C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void EnemyPirate__OnDefend_215B8C4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH2_PIRATE_H