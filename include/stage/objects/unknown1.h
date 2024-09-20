#ifndef RUSH2_OBJECTUNKNOWN1_H
#define RUSH2_OBJECTUNKNOWN1_H

#include <stage/gameObject.h>
#include <game/stage/mapSys.h>

// --------------------
// STRUCTS
// --------------------

typedef struct ObjectUnknown1_
{
    GameObjectTask gameWork;
  Vec2Fx32 field_364;
} ObjectUnknown1;

// --------------------
// FUNCTIONS
// --------------------

ObjectUnknown1 *ObjectUnknown1__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void ObjectUnknown1__State_216BD64(ObjectUnknown1 *work);
void ObjectUnknown1__Func_216BDFC(ObjectUnknown1 *work, struct MapSysCamera *camera);

#endif // RUSH2_OBJECTUNKNOWN1_H