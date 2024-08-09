#ifndef RUSH2_GAMEOBJECT_H
#define RUSH2_GAMEOBJECT_H

#include <stage/stageTask.h>
#include <stage/player/player.h>

// --------------------
// CONSTANTS
// --------------------

#define GAMEOBJECT_TEMPLIST_SIZE 40

// --------------------
// ENUMS
// --------------------

enum GameObjectPacketType_
{
    GAMEOBJECT_PACKET_NONE,
    GAMEOBJECT_PACKET_1,
    GAMEOBJECT_PACKET_DESTROYED,
    GAMEOBJECT_PACKET_OBJ_COLLISION,
    GAMEOBJECT_PACKET_4,
    GAMEOBJECT_PACKET_5,
    GAMEOBJECT_PACKET_6,
    GAMEOBJECT_PACKET_SLOWDOWN,
    GAMEOBJECT_PACKET_CONFUSION,
    GAMEOBJECT_PACKET_TENSION_SWAP,
    GAMEOBJECT_PACKET_GRAB,
};
typedef u8 GameObjectPacketType;

// --------------------
// STRUCTS
// --------------------

struct GameObjectTask_
{
    StageTask objWork;

    OBS_ACTION2D_BAC_WORK animator;
    OBS_RECT_WORK colliders[3];
    StageTaskCollisionWork collisionObject;
    NNSSndHandle *sndHandle;
    MapObject *mapObject;
    u8 mapObjectX;
    u8 health;
    u8 field_346;
    u8 field_347;
    Vec2Fx32 originPos;
    s16 blinkTimer;
    s16 field_352;
    u32 flags;
    u16 field_358;
    u16 field_35A;
    StageTask *parent;
    u32 field_360;
};

// --------------------
// VARIABLES
// --------------------

extern u8 StageTask__DefaultDiffData[512];

// --------------------
// FUNCTIONS
// --------------------

void GameObject__InitFromObject(GameObjectTask *work, MapObject *mapObject, fx32 x, fx32 y);
void GameObject__Destructor(Task *task);
void GameObject__SetAnimation(GameObjectTask *work, u16 animID);
GameObjectTask *GameObject__SpawnObject(s32 id, fx32 x, fx32 y, u16 flags, s8 left, s8 top, u8 width, u8 height, u8 param);
void GameObject__ProcessRecievedPackets_ItemBox(void);
void GameObject__ProcessRecievedPackets_Unknown(void);
void GameObject__SendPacket(GameObjectTask *work, Player *player, GameObjectPacketType type);
void GameObject__SpawnExplosion(GameObjectTask *work);
void GameObject__Func_20277C8(GameObjectTask *work);
void GameObject__OnDefend_Enemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void GameObject__In_Default(void);
void GameObject__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, GameObjectTask *work);
void GameObject__Collide_Default(void);
void GameObject__BadnikBounce(GameObjectTask *work, Player *player);
void GameObject__State_2027F5C(GameObjectTask *work);
s16 GameObject__GetNextTempObjID(void);
void GameObject__ReleaseTempObj(MapObject *obj);
void GameObject__ProcessRecievedPackets(GameObjectTask *work);
s32 GameObject__BadnikBreak(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2, GameObjectPacketType type);
void GameObject__Func_20282A8(VecFx32 *inputPos, VecFx32 *outputPos, MtxFx33 *mtx, BOOL setFrustum);

#endif // RUSH2_GAMEOBJECT_H
