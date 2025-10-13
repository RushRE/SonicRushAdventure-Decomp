#include <stage/enemies/divebat.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_xRange mapObject->width

// --------------------
// CONSTANTS
// --------------------

#define DIVEBAT_INSTANCE_MAX 16

// --------------------
// ENUMS
// --------------------

enum DiveBatObjectFlags
{
    DIVEBAT_OBJFLAG_NONE,

    DIVEBAT_OBJFLAG_TYPE_MASK = 0x3,

    DIVEBAT_OBJFLAG_40 = (1 << 6),
};

enum DiveBatInstanceFlags_
{
    DIVEBAT_INSTANCEFLAG_NONE,

    DIVEBAT_INSTANCEFLAG_SHOULD_ATTACK = (1 << 0),
};
typedef u8 DiveBatInstanceFlags;

enum DiveBatType
{
    DIVEBAT_TYPE_NONE = 0xFF,
};

enum DiveBatAnimID
{
    DIVEBAT_ANI_FLYING,
    DIVEBAT_ANI_ATTACKING,
    DIVEBAT_ANI_TURNING,
};

// --------------------
// STRUCTS
// --------------------

struct DiveBatInstance
{
    EnemyDiveBat *entity;
    u8 count;
    DiveBatInstanceFlags flags;
    s16 timer;
};

// --------------------
// VARIABLES
// --------------------

static struct DiveBatInstance instanceList[3];

static Vec2U16 childPositions[] = {
    { FLOAT_TO_FX32(6.9677734375), FLOAT_TO_FX32(2.48291015625) },
    { FLOAT_TO_FX32(1.879638671875), FLOAT_TO_FX32(9.741455078125) },
    { FLOAT_TO_FX32(2.0966796875), FLOAT_TO_FX32(4.2314453125) },
};

// --------------------
// STRUCTS
// --------------------

static void EnemyDiveBat_Destructor(Task *task);
static EnemyDiveBat *CreateDiveBatChild(MapObject *mapObject);
static void EnemyDiveBat_Action_InitParent(EnemyDiveBat *work);
static void EnemyDiveBat_State_Parent(EnemyDiveBat *work);
static void EnemyDiveBat_Draw_Parent(void);
static void EnemyDiveBat_Action_Init(EnemyDiveBat *work);
static void EnemyDiveBat_State_Moving(EnemyDiveBat *work);
static void EnemyDiveBat_Action_Turn(EnemyDiveBat *work);
static void EnemyDiveBat_State_Turning(EnemyDiveBat *work);
static void EnemyDiveBat_Action_Attack(EnemyDiveBat *work);
static void EnemyDiveBat_State_Attacking(EnemyDiveBat *work);
static void EnemyDiveBat_Action_FinishAttack(EnemyDiveBat *work);
static void EnemyDiveBat_State_FinishAttack(EnemyDiveBat *work);
static void EnemyDiveBat_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE u16 DiveBatRand(EnemyDiveBat *work)
{
    work->randSeed = (u32)(1663525 * (s32)work->randSeed + 1013904223);
    return (u16)(work->randSeed >> 16);
}

// --------------------
// FUNCTIONS
// --------------------

EnemyDiveBat *CreateDiveBat(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    u32 priority;
    if (mapObject->id == MAPOBJECT_348)
        priority = 0x14FF;
    else
        priority = 0x1500;

    Task *task = CreateStageTask(EnemyDiveBat_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + priority, TASK_GROUP(2), EnemyDiveBat);
    if (task == HeapNull)
        return NULL;

    EnemyDiveBat *work = TaskGetWork(task, EnemyDiveBat);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_divebat.bac", GetObjectDataWork(OBJDATAWORK_23), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, DIVEBAT_ANI_FLYING, 112);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjRect__SetBox2D(&work->colliderDetect.rect, -96, 0, -16, 98);
    ObjRect__SetAttackStat(&work->colliderDetect, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->colliderDetect, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetGroupFlags(&work->colliderDetect, 2, 1);
    work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;
    ObjRect__SetOnDefend(&work->colliderDetect, EnemyDiveBat_OnDefend_Detect);
    work->colliderDetect.parent = &work->gameWork.objWork;

    work->originPos.x = work->gameWork.objWork.position.x;
    work->originPos.y = work->gameWork.objWork.position.y;

    work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(mapObjectParam_xMin);
    work->xMax = work->xMin + FX32_FROM_WHOLE(mapObjectParam_xRange);

    work->randSeed = (work->gameWork.objWork.position.x << 16) | (u16)work->gameWork.objWork.position.y;

    if ((mapObject->flags & DIVEBAT_OBJFLAG_40) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (mapObject->id == MAPOBJECT_348)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;

        work->type = type;

        work->gameWork.objWork.position.x = work->gameWork.objWork.position.y = FLOAT_TO_FX32(0.0);
    }
    else
    {
        if ((mapObject->flags & DIVEBAT_OBJFLAG_TYPE_MASK) != 0)
        {
            EnemyDiveBat *child = CreateDiveBatChild(mapObject);
            if (child)
            {
                work->type = child->type;
                EnemyDiveBat_Action_InitParent(work);
                return work;
            }
        }

        work->type = DIVEBAT_TYPE_NONE;
    }

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    EnemyDiveBat_Action_Init(work);

    return work;
}

void EnemyDiveBat_Destructor(Task *task)
{
    EnemyDiveBat *work = TaskGetWork(task, EnemyDiveBat);

    if (work->gameWork.mapObject->id == MAPOBJECT_348)
    {
        if (instanceList[work->type].entity == work)
            instanceList[work->type].entity = NULL;
    }
    else
    {
        if (work->type != DIVEBAT_TYPE_NONE && instanceList[work->type].count != 0)
        {
            instanceList[work->type].count--;
        }
    }
    GameObject__Destructor(task);
}

EnemyDiveBat *CreateDiveBatChild(MapObject *mapObject)
{
    u8 type = (mapObject->flags & DIVEBAT_OBJFLAG_TYPE_MASK) - 1;

    EnemyDiveBat *child;
    if (instanceList[type].count || instanceList[type].entity != NULL && (instanceList[type].entity->gameWork.objWork.flag & 4) == 0)
    {
        if (instanceList[type].count >= DIVEBAT_INSTANCE_MAX)
            return NULL;

        child = instanceList[type].entity;
    }
    else
    {
        child = SpawnStageObjectEx(MAPOBJECT_348, childPositions[type].x, childPositions[type].y, EnemyDiveBat, mapObject->flags, mapObject->left, mapObject->top, mapObject->width,
                                   mapObject->height, type);
        if (child == NULL)
            return NULL;

        instanceList[type].entity = child;
        instanceList[type].timer  = 0;
        instanceList[type].flags  = DIVEBAT_INSTANCEFLAG_NONE;
    }

    instanceList[type].count++;

    return child;
}

void EnemyDiveBat_Action_InitParent(EnemyDiveBat *work)
{
    SetTaskOutFunc(&work->gameWork.objWork, EnemyDiveBat_Draw_Parent);

    SetTaskState(&work->gameWork.objWork, EnemyDiveBat_State_Parent);
}

void EnemyDiveBat_State_Parent(EnemyDiveBat *work)
{
    EnemyDiveBat *enemy = instanceList[work->type].entity;

    if (enemy != NULL)
    {
        if ((instanceList[work->type].flags & DIVEBAT_INSTANCEFLAG_SHOULD_ATTACK) != 0)
        {
            EnemyDiveBat_Action_Attack(work);
        }
        else
        {
            work->gameWork.objWork.position.x  = work->originPos.x + (enemy->gameWork.objWork.position.x - enemy->originPos.x);
            work->gameWork.objWork.position.y  = work->originPos.y + (enemy->gameWork.objWork.position.y - enemy->originPos.y);
            work->gameWork.objWork.displayFlag = (enemy->gameWork.objWork.displayFlag & ~DISPLAY_FLAG_DISABLE_DRAW) | DISPLAY_FLAG_DISABLE_UPDATE;

            work->gameWork.colliders[0] = enemy->gameWork.colliders[0];
            work->gameWork.colliders[1] = enemy->gameWork.colliders[1];

            if (StageTaskStateMatches(&enemy->gameWork.objWork, EnemyDiveBat_State_Moving) && enemy->gameWork.objWork.userWork == 0)
                StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);

            if ((enemy->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DIVE_FLUTTER);
                ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            }
        }
    }
}

void EnemyDiveBat_Draw_Parent(void)
{
    EnemyDiveBat *work = TaskGetWorkCurrent(EnemyDiveBat);

    StageTask__Draw2D(&work->gameWork.objWork, &instanceList[work->type].entity->gameWork.objWork.obj_2d->ani);
}

void EnemyDiveBat_Action_Init(EnemyDiveBat *work)
{
    GameObject__SetAnimation(&work->gameWork, DIVEBAT_ANI_FLYING);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(1.0);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(1.0);
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.groundVel  = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.userTimer = 0;

    SetTaskState(&work->gameWork.objWork, EnemyDiveBat_State_Moving);
}

void EnemyDiveBat_State_Moving(EnemyDiveBat *work)
{
    BOOL shouldTurn = FALSE;

    if (work->gameWork.mapObject->id == MAPOBJECT_348)
    {
        if (instanceList[work->type].count == 0)
        {
            DestroyStageTask(&work->gameWork.objWork);
            return;
        }

        if (instanceList[work->type].timer != 0)
        {
            instanceList[work->type].timer--;
            if (instanceList[work->type].timer == 0)
                instanceList[work->type].flags |= DIVEBAT_INSTANCEFLAG_SHOULD_ATTACK;
        }
    }
    else if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DIVE_FLUTTER);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }

    if (work->gameWork.objWork.velocity.x <= 0)
    {
        if (work->gameWork.objWork.position.x <= work->xMin)
        {
            shouldTurn = TRUE;
        }
    }
    else
    {
        if (work->gameWork.objWork.position.x >= work->xMax)
        {
            shouldTurn = TRUE;
        }
    }

    if ((playerGameStatus.stageTimer & 3) == 0)
    {
        work->gameWork.objWork.userTimer = DiveBatRand(work) & (FLOAT_TO_FX32(2.0) - 1);

        if ((DiveBatRand(work) & 1) != 0)
            work->gameWork.objWork.userTimer = -work->gameWork.objWork.userTimer;

        if (work->gameWork.objWork.position.y <= work->originPos.y - FLOAT_DEG_TO_IDX(180.0))
        {
            work->gameWork.objWork.userTimer = (FLOAT_TO_FX32(2.0) - 1);
        }
        else if (work->gameWork.objWork.position.y >= work->originPos.y + FLOAT_DEG_TO_IDX(180.0))
        {
            work->gameWork.objWork.userTimer = -(FLOAT_TO_FX32(2.0) - 1);
        }
    }

    work->gameWork.objWork.velocity.y = ObjShiftSet(work->gameWork.objWork.velocity.y, work->gameWork.objWork.userTimer, 1, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.25));

    if (work->gameWork.mapObject->id == MAPOBJECT_21)
    {
        if (work->gameWork.objWork.userWork != 0)
        {
            work->gameWork.objWork.userWork--;
            if (work->gameWork.objWork.userWork == 0)
                work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_ENABLED;
        }

        StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);
    }

    if (shouldTurn)
        EnemyDiveBat_Action_Turn(work);
}

void EnemyDiveBat_Action_Turn(EnemyDiveBat *work)
{
    GameObject__SetAnimation(&work->gameWork, DIVEBAT_ANI_TURNING);

    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

    SetTaskState(&work->gameWork.objWork, EnemyDiveBat_State_Turning);
}

void EnemyDiveBat_State_Turning(EnemyDiveBat *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        EnemyDiveBat_Action_Init(work);
    }
}

void EnemyDiveBat_Action_Attack(EnemyDiveBat *work)
{
    GameObject__SetAnimation(&work->gameWork, DIVEBAT_ANI_ATTACKING);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    work->returnPos.x = work->gameWork.objWork.position.x;
    work->returnPos.y = work->gameWork.objWork.position.y;

    work->angle = FLOAT_DEG_TO_IDX(90.0);

    SetTaskState(&work->gameWork.objWork, EnemyDiveBat_State_Attacking);

    if (work->gameWork.mapObject->id == MAPOBJECT_21)
    {
        if (work->type != DIVEBAT_TYPE_NONE)
        {
            if ((instanceList[work->type].flags & DIVEBAT_INSTANCEFLAG_SHOULD_ATTACK) == 0 && instanceList[work->type].timer == 0)
                instanceList[work->type].timer = 16;

            SetTaskOutFunc(&work->gameWork.objWork, NULL);

            work->gameWork.objWork.displayFlag &= ~(DISPLAY_FLAG_DISABLE_UPDATE | DISPLAY_FLAG_DISABLE_DRAW);

            if (instanceList[work->type].count != 0)
                instanceList[work->type].count--;

            work->type = DIVEBAT_TYPE_NONE;
        }
    }

    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DIVE_RUSH);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
}

void EnemyDiveBat_State_Attacking(EnemyDiveBat *work)
{
    work->angle += FLOAT_DEG_TO_IDX(2.5);

    if (work->angle > FLOAT_DEG_TO_IDX(180.0))
    {
        EnemyDiveBat_Action_FinishAttack(work);
    }
    else
    {
        work->gameWork.objWork.velocity.x = MultiplyFX(FLOAT_TO_FX32(3.555419921875), CosFX((s32)work->angle));
        work->gameWork.objWork.velocity.y = MultiplyFX(FLOAT_TO_FX32(3.555419921875), SinFX((s32)work->angle));

        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->gameWork.objWork.velocity.x = -work->gameWork.objWork.velocity.x;
    }
}

void EnemyDiveBat_Action_FinishAttack(EnemyDiveBat *work)
{
    GameObject__SetAnimation(&work->gameWork, DIVEBAT_ANI_FLYING);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    work->gameWork.objWork.userTimer = 0;
    work->gravityStrength            = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

    SetTaskState(&work->gameWork.objWork, EnemyDiveBat_State_FinishAttack);
}

void EnemyDiveBat_State_FinishAttack(EnemyDiveBat *work)
{
    if (work->gameWork.objWork.position.y >= work->originPos.y - FLOAT_TO_FX32(8.0) && work->gameWork.objWork.position.y <= work->originPos.y + FLOAT_TO_FX32(8.0))
    {
        EnemyDiveBat_Action_Init(work);
    }
    else
    {
        u16 angle = FX_Atan2Idx(work->returnPos.y - work->gameWork.objWork.position.y, work->returnPos.x - work->gameWork.objWork.position.x);

        work->gameWork.objWork.velocity.x = MultiplyFX(CosFX((s32)angle), FLOAT_TO_FX32(2.0));
        work->gameWork.objWork.velocity.y = MultiplyFX(SinFX((s32)angle), FLOAT_TO_FX32(2.0));

        if ((playerGameStatus.stageTimer & 3) == 0)
        {
            work->gameWork.objWork.userTimer = -(DiveBatRand(work) & (FLOAT_TO_FX32(2.0) - 1));
        }

        work->gravityStrength = ObjShiftSet(work->gravityStrength, work->gameWork.objWork.userTimer, 1, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.25));
        work->gameWork.objWork.velocity.y += work->gravityStrength;
    }
}

void EnemyDiveBat_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyDiveBat *enemy = (EnemyDiveBat *)rect2->parent;
    Player *player      = (Player *)rect1->parent;

    if ((enemy->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) != 0)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || !CheckIsPlayer1(player))
        return;

    enemy->gameWork.objWork.userWork = 60;
    enemy->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    EnemyDiveBat_Action_Attack(enemy);
}
