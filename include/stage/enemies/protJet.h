#ifndef RUSH2_PROTJET_H
#define RUSH2_PROTJET_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyProtJet_
{
    GameObjectTask gameWork;
    void (*onInit)(struct EnemyProtJet_ *work);
    fx32 field_368;
    fx32 yMin;
    fx32 field_370;
    fx32 yMax;
    u16 word378;
    u16 field_37A;
    u16 word37C;
    u16 angle;
    u16 angleSpeed;
    u32 dword384;
    u32 dword388;
    u32 dword38C;
    u32 dword390;
} EnemyProtJet;

// --------------------
// FUNCTIONS
// --------------------

EnemyProtJet *EnemyProtJet__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void EnemyProtJet__InitFlyRange(EnemyProtJet *work);
void EnemyProtJet__OnInit_21563B4(EnemyProtJet *work);
void EnemyProtJet__OnInit_21563E4(EnemyProtJet *work);
void EnemyProtJet__State_2156428(EnemyProtJet *work);
void EnemyProtJet__State_2156468(EnemyProtJet *work);

#endif // RUSH2_PROTJET_H