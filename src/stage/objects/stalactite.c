#include <stage/objects/stalactite.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>
#include <game/graphics/screenShake.h>
#include <game/object/obj.h>

// --------------------
// ENUMS
// --------------------

enum StalactiteAnimIDs
{
    STALACTITE_ANI_0,
    STALACTITE_ANI_1,
    STALACTITE_ANI_2,
    STALACTITE_ANI_3,
    STALACTITE_ANI_4,
    STALACTITE_ANI_5,
    STALACTITE_ANI_6,
    STALACTITE_ANI_7,
};

enum StalactiteFlags
{
    STALACTITE_FLAG_NONE,

    STALACTITE_FLAG_SHAKING = 1 << 0,
    STALACTITE_FLAG_BROKEN  = 1 << 1,
};

enum FallingStalactiteFlags
{
    FALLINGSTALACTITE_FLAG_NONE,

    FALLINGSTALACTITE_FLAG_SHAKING = 1 << 0,
    FALLINGSTALACTITE_FLAG_FALLING = 1 << 1,
    FALLINGSTALACTITE_FLAG_LANDED  = 1 << 2,
};

enum StalactiteVisibleFlags
{
    STALACTITE_VISIBLE_FLAG_NONE,

    STALACTITE_VISIBLE_FLAG_HIDE_WEAKPOINT = 1 << 0,
};

// --------------------
// VARIABLES
// --------------------

static u8 particleTypeTable[8] = { 0, 1, 2, 0, 1, 2, 0, 1 };

// --------------------
// FUNCTION DECLS
// --------------------

static void Stalactite_Destructor(Task *task);
static void Stalactite_State_Active(Stalactite *work);
static void Stalactite_StateWeakPoint_Hit(Stalactite *work);
static void Stalactite_StateWeakPoint_Falling(Stalactite *work);
static void Stalactite_Draw(void);
static void Stalactite_Collide(void);
static void Stalactite_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void CreateStalactiteParticle(Stalactite *work, fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type);

static void FallingStalactite_State_Shake(FallingStalactite *work);
static void FallingStalactite_State_Fall(FallingStalactite *work);
static void FallingStalactite_Collide(void);

// --------------------
// FUNCTIONS
// --------------------

Stalactite *CreateStalactite(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(Stalactite_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Stalactite);
    if (task == HeapNull)
        return NULL;

    Stalactite *work = TaskGetWork(task, Stalactite);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->availableParticleCount = STALACTITE_PARTICLE_COUNT;
    for (s32 i = 0; i < STALACTITE_PARTICLE_COUNT; i++)
    {
        work->particleList[i] = &work->particleStorage[i];
    }
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_stalactite.bac", GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 52, GetObjectSpriteRef(OBJDATAWORK_160));
    if ((GetObjectSpriteRef(OBJDATAWORK_160)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) > 1)
        work->gameWork.objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    if (mapObject->id == MAPOBJECT_160)
        ObjActionAllocSpritePalette(&work->gameWork.objWork, STALACTITE_ANI_0, 5);
    else
        ObjActionAllocSpritePalette(&work->gameWork.objWork, STALACTITE_ANI_7, 45);
    StageTask__SetAnimation(&work->gameWork.objWork, STALACTITE_ANI_0);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    AnimatorSpriteDS *aniWeakPoint = &work->aniWeakPoint;
    ObjAction2dBACLoad(aniWeakPoint, "/act/ac_gmk_stalactite.bac", 56, GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage);
    aniWeakPoint->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniWeakPoint->cParam[0].palette = aniWeakPoint->cParam[1].palette = aniWeakPoint->work.cParam.palette;
    aniWeakPoint->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(aniWeakPoint, STALACTITE_ANI_1);
    StageTask__SetOAMOrder(&aniWeakPoint->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniWeakPoint->work, SPRITE_PRIORITY_2);

    OBS_DATA_WORK *sprDebris;
    u32 aniFlags = ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS *aniDebris;
    u32 id;
    s32 i;
    if ((GetObjectSpriteRef(OBJDATAWORK_164)->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) != 0)
        aniFlags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    sprDebris = GetObjectDataWork(OBJDATAWORK_159);
    aniDebris = &work->aniDebris[0];
    i         = 0;
    id        = OBJDATAWORK_164;
    for (; i < 3; i++)
    {
        ObjAction2dBACLoad(aniDebris, "/act/ac_gmk_stalactite.bac", 0, sprDebris, gameArchiveStage);
        ObjActionAllocSpriteDS(aniDebris, Sprite__GetSpriteSize2FromAnim(sprDebris->fileData, i + STALACTITE_ANI_4), GetObjectSpriteRef(id));
        aniDebris->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
        aniDebris->cParam[0].palette = aniDebris->cParam[1].palette = aniDebris->work.cParam.palette;
        aniDebris->work.flags |= aniFlags;
        AnimatorSpriteDS__SetAnimation(aniDebris, i + STALACTITE_ANI_4);
        AnimatorSpriteDS__ProcessAnimationFast(aniDebris);
        StageTask__SetOAMOrder(&aniDebris->work, SPRITE_ORDER_12);
        StageTask__SetOAMPriority(&aniDebris->work, SPRITE_PRIORITY_0);

        aniDebris++;
        id += 2;
    }

    if (mapObject->id == MAPOBJECT_160)
    {
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -62, -206, 62, -158);
        ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~2, 0);
    }
    else
    {
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -40, -104, 40, 152);
        ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    }
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Stalactite_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_stalactite_bottom.df", GetObjectDataWork(OBJDATAWORK_171), gameArchiveStage);
    StageTaskCollisionObj *collisionWork0 = &work->gameWork.collisionObject.work;
    collisionWork0->parent                = &work->gameWork.objWork;
    collisionWork0->width                 = 104;
    collisionWork0->height                = 104;
    collisionWork0->ofst_x                = -104;
    collisionWork0->ofst_y                = -256;

    StageTaskCollisionObj *collisionWork1 = &work->collisionWork1;
    collisionWork1->parent                = &work->gameWork.objWork;
    collisionWork1->diff_data             = work->gameWork.collisionObject.work.diff_data;
    collisionWork1->width                 = 104;
    collisionWork1->height                = 104;
    collisionWork1->ofst_x                = -104;
    collisionWork1->ofst_y                = -256;

    SetTaskOutFunc(&work->gameWork.objWork, Stalactite_Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Stalactite_Collide);
    SetTaskState(&work->gameWork.objWork, Stalactite_State_Active);

    FallingStalactite *fallingStalactite = SpawnStageObjectEx(MAPOBJECT_321, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y - 0xA0000, FallingStalactite, 0,
                                                              0, 0, 0, 0, mapObject->id - MAPOBJECT_160);

    work->fallingStalactite = fallingStalactite;
    if (work->fallingStalactite != NULL)
        fallingStalactite->gameWork.objWork.parentObj = &work->gameWork.objWork;

    return work;
}

FallingStalactite *CreateFallingStalactite(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), FallingStalactite);
    if (task == HeapNull)
        return NULL;

    FallingStalactite *work = TaskGetWork(task, FallingStalactite);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.gravityStrength += FLOAT_TO_FX32(0.0625);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_stalactite.bac", GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage, 66);
    if (type)
        ObjActionAllocSpritePalette(&work->gameWork.objWork, STALACTITE_ANI_7, 45);
    else
        ObjActionAllocSpritePalette(&work->gameWork.objWork, STALACTITE_ANI_0, 5);
    StageTask__SetAnimation(&work->gameWork.objWork, STALACTITE_ANI_3);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    ObjObjectCollisionDifSet(&work->gameWork.objWork, "/df/gmk_stalactite_drop.df", GetObjectDataWork(OBJDATAWORK_170), gameArchiveStage);
    StageTaskCollisionObj *collisionWork0 = &work->gameWork.collisionObject.work;
    collisionWork0->parent                = &work->gameWork.objWork;
    collisionWork0->width                 = 40;
    collisionWork0->height                = 40;
    collisionWork0->ofst_x                = -40;
    collisionWork0->ofst_y                = 56;

    StageTaskCollisionObj *collisionWork1 = &work->collisionWork1;
    collisionWork1->parent                = &work->gameWork.objWork;
    collisionWork1->diff_data             = work->gameWork.collisionObject.work.diff_data;
    collisionWork1->width                 = 40;
    collisionWork1->height                = 40;
    collisionWork1->ofst_x                = -40;
    collisionWork1->ofst_y                = 56;

    StageTaskCollisionObj *collisionWork2 = &work->collisionWork2;
    collisionWork2->parent                = &work->gameWork.objWork;
    collisionWork2->diff_data             = StageTask__DefaultDiffData;
    collisionWork2->width                 = 48;
    collisionWork2->height                = 48;
    collisionWork2->ofst_x                = -48;
    collisionWork2->ofst_y                = 8;

    StageTaskCollisionObj *collisionWork3 = &work->collisionWork3;
    collisionWork3->parent                = &work->gameWork.objWork;
    collisionWork3->diff_data             = StageTask__DefaultDiffData;
    collisionWork3->width                 = 48;
    collisionWork3->height                = 48;
    collisionWork3->ofst_x                = 0;
    collisionWork3->ofst_y                = 8;

    ObjRect__SetGroupFlags(&work->gameWork.colliders[0], 1, 2);
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -42, 0, 42, 86);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 2, 64);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~0, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_20;

    SetTaskCollideFunc(&work->gameWork.objWork, FallingStalactite_Collide);
    SetTaskState(&work->gameWork.objWork, FallingStalactite_State_Shake);

    return work;
}

void Stalactite_Destructor(Task *task)
{
    Stalactite *work = TaskGetWork(task, Stalactite);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_159), &work->aniWeakPoint);

    s32 i;
    AnimatorSpriteDS *aniDebris = &work->aniDebris[0];
    u32 id                      = OBJDATAWORK_164;
    for (i = 0; i < 3; i++)
    {
        ObjActionReleaseSpriteDS(GetObjectSpriteRef(id));
        aniDebris->vramPixels[0] = NULL;
        aniDebris->vramPixels[1] = NULL;

        ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_159), aniDebris);

        aniDebris++;
        id += 2;
    }

    GameObject__Destructor(task);
}

void Stalactite_State_Active(Stalactite *work)
{
    StalactiteParticle *particle;
    StalactiteParticle *prev = NULL;

    if (work->stateWeakPoint != NULL)
        work->stateWeakPoint(work);

    particle = work->particleListStart;
    while (particle != NULL)
    {
        if (particle->velocity.y < FLOAT_TO_FX32(15.0))
        {
            particle->velocity.y += FLOAT_TO_FX32(0.1640625);
            if (particle->velocity.y > FLOAT_TO_FX32(15.0))
                particle->velocity.y = FLOAT_TO_FX32(15.0);
        }

        particle->velocity.x = ObjSpdDownSet(particle->velocity.x, particle->velocity.x >> 8);
        particle->position.x += particle->velocity.x;
        particle->position.y += particle->velocity.y;

        if (StageTask__ViewOutCheck(particle->position.x, particle->position.y, 256, 0, 0, 0, 0))
        {
            StalactiteParticle *next = particle->next;
            if (prev != NULL)
                prev->next = next;
            else
                work->particleListStart = next;
            particle->next = NULL;

            work->particleList[work->availableParticleCount] = particle;
            particle                                         = next;
            work->availableParticleCount++;
        }
        else
        {
            prev     = particle;
            particle = particle->next;
        }
    }
}

void Stalactite_StateWeakPoint_Hit(Stalactite *work)
{
    work->gameWork.objWork.userTimer++;

    switch (work->gameWork.objWork.userTimer)
    {
        case 45:
            work->gameWork.objWork.userFlag |= STALACTITE_FLAG_SHAKING;
            break;

        case 100:
            work->gameWork.objWork.userFlag |= STALACTITE_FLAG_BROKEN;
            work->gameWork.flags |= STALACTITE_VISIBLE_FLAG_HIDE_WEAKPOINT;

            work->gameWork.collisionObject.work.parent = NULL;
            work->gameWork.collisionObject.work.flag |= STAGE_TASK_OBJCOLLISION_FLAG_100;

            work->collisionWork1.parent = NULL;
            work->collisionWork1.flag |= STAGE_TASK_OBJCOLLISION_FLAG_100;

            work->stateWeakPoint = Stalactite_StateWeakPoint_Falling;

            for (s32 i = 0; i < 16; i++)
            {
                fx32 velX   = FX32_FROM_WHOLE(mtMathRandRange2(-64, 64));
                fx32 velY   = FX32_FROM_WHOLE(-mtMathRandRepeat(4));
                u32 offsetY = (mtMathRand());
                offsetY <<= 16 + 10;
                offsetY >>= 16 - 2;

                CreateStalactiteParticle(work, work->gameWork.objWork.position.x + velX, work->gameWork.objWork.position.y - FLOAT_TO_FX32(208.0) + offsetY, velX >> 4, velY,
                                         particleTypeTable[i & 7]);
            }

            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STALACT_FALL);
            return;
    }

    if (work->gameWork.objWork.userTimer >= 45 && (work->gameWork.objWork.userTimer & 1) != 0)
        work->gameWork.flags ^= STALACTITE_VISIBLE_FLAG_HIDE_WEAKPOINT;

    work->gameWork.objWork.userWork--;
    if ((work->gameWork.objWork.userWork & 0xFFFF) == 0)
    {
        fx32 type   = mtMathRandRepeat(8);
        u32 offsetY = mtMathRand();
        offsetY <<= 16 + 10;
        offsetY >>= 16 - 2;
        fx32 offsetX = FX32_FROM_WHOLE(mtMathRandRange2(-64, 64));

        CreateStalactiteParticle(work, work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y - FLOAT_TO_FX32(208.0) + offsetY, FLOAT_TO_FX32(0.0),
                                 FLOAT_TO_FX32(0.0), particleTypeTable[type]);

        u32 value = (work->gameWork.objWork.userWork >> 16) - 1;
        if (value < 2)
            value = 2;
        work->gameWork.objWork.userWork = (value << 0) | (value << 16);
    }
}

void Stalactite_StateWeakPoint_Falling(Stalactite *work)
{
    s32 i;
    FallingStalactite *fallingStalactite = work->fallingStalactite;

    if ((fallingStalactite->gameWork.objWork.userFlag & FALLINGSTALACTITE_FLAG_LANDED) != 0)
    {
        work->stateWeakPoint = NULL;
        for (i = 0; i < 10; i++)
        {
            fx32 velX   = FX32_FROM_WHOLE(mtMathRandRange2(-32, 32));
            fx32 velY   = FX32_FROM_WHOLE(-mtMathRandRepeat(8));
            u32 offsetY = FX32_FROM_WHOLE(mtMathRand());
            offsetY <<= 16;
            offsetY >>= 16;

            CreateStalactiteParticle(work, fallingStalactite->gameWork.objWork.position.x + velX, fallingStalactite->gameWork.objWork.position.y + FLOAT_TO_FX32(62.0) + offsetY,
                                     velX >> 4, velY, particleTypeTable[i & 7]);
        }
    }
}

void Stalactite_Draw(void)
{
    Stalactite *work = TaskGetWorkCurrent(Stalactite);

    work->gameWork.objWork.offset.y = -FLOAT_TO_FX32(256.0);

    if ((work->gameWork.flags & STALACTITE_VISIBLE_FLAG_HIDE_WEAKPOINT) == 0)
        StageTask__Draw2D(&work->gameWork.objWork, &work->aniWeakPoint);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    for (StalactiteParticle *particle = work->particleListStart; particle != NULL; particle = particle->next)
    {
        u32 displayFlag = particle->displayFlag | DISPLAY_FLAG_DISABLE_SCALE | DISPLAY_FLAG_DISABLE_ROTATION;
        StageTask__Draw2DEx(&work->aniDebris[particle->type], &particle->position, NULL, NULL, &displayFlag, NULL, NULL);
    }
}

void Stalactite_Collide(void)
{
    Stalactite *work = TaskGetWorkCurrent(Stalactite);

    if (!IsStageTaskDestroyedAny(&work->gameWork.objWork))
    {
        if (work->gameWork.colliders[0].parent != NULL)
            StageTask__HandleCollider(&work->gameWork.objWork, work->gameWork.colliders);

        if (!StageTask__ViewCheck_Default(&work->gameWork.objWork))
        {
            if (work->gameWork.collisionObject.work.parent != NULL)
                ObjCollisionObjectRegist(&work->gameWork.collisionObject.work);

            if (work->collisionWork1.parent != NULL)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                ObjCollisionObjectRegist(&work->collisionWork1);
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            }
        }
    }
}

void Stalactite_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Stalactite *stalactite = (Stalactite *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    BOOL fastFall = FALSE;
    if (stalactite == NULL || player == NULL)
        return;

    // if the player is boosting, remove the delay, just fall!
    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER && player->objWork.parentObj != NULL)
    {
        player = (Player *)player->objWork.parentObj;
        if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
            return;

        fastFall = TRUE;
    }

    stalactite->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    AnimatorSpriteDS__SetAnimation(&stalactite->aniWeakPoint, STALACTITE_ANI_2);
    stalactite->stateWeakPoint             = Stalactite_StateWeakPoint_Hit;
    stalactite->gameWork.objWork.userTimer = 0;
    stalactite->gameWork.objWork.userWork  = (16 << 0) | (16 << 16);

    if (stalactite->gameWork.mapObject->id == MAPOBJECT_160)
    {
        Player__Action_DestroyAttackRecoil(player);
        player->objWork.velocity.x = -player->objWork.velocity.x;
        if (fastFall)
        {
            player->objWork.velocity.x >>= 2;
            stalactite->gameWork.objWork.userTimer = 99;
            stalactite->gameWork.objWork.userFlag |= STALACTITE_FLAG_SHAKING;
        }
    }

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STALACT_BREAK);
}

void CreateStalactiteParticle(Stalactite *work, fx32 x, fx32 y, fx32 velX, fx32 velY, u16 type)
{
    if (work->availableParticleCount != 0)
    {
        u32 rand = mtMathRand();

        work->availableParticleCount--;

        StalactiteParticle *particle = work->particleList[work->availableParticleCount];
        particle->type               = type;
        particle->position.x         = x;
        particle->position.y         = y;
        particle->velocity.x         = velX;
        particle->velocity.y         = velY;

        particle->displayFlag = (((rand & 1) != 0) ? DISPLAY_FLAG_FLIP_X : DISPLAY_FLAG_NONE) | (((rand & 2) != 0) ? DISPLAY_FLAG_FLIP_Y : DISPLAY_FLAG_NONE);

        if (work->particleListStart != NULL)
            particle->next = work->particleListStart;

        work->particleListStart = particle;
    }
}

void FallingStalactite_State_Shake(FallingStalactite *work)
{
    Stalactite *weakpoint = (Stalactite *)work->gameWork.objWork.parentObj;

    if ((work->gameWork.objWork.userFlag & FALLINGSTALACTITE_FLAG_FALLING) == 0 && (weakpoint->gameWork.objWork.userFlag & STALACTITE_FLAG_BROKEN) != 0)
    {
        work->gameWork.objWork.userFlag |= FALLINGSTALACTITE_FLAG_FALLING;
        work->gameWork.objWork.shakeTimer = 0;
        work->gameWork.objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        StageTask__SetHitbox(&work->gameWork.objWork, -32, 0, 32, 64);
        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

        SetTaskState(&work->gameWork.objWork, FallingStalactite_State_Fall);
    }
    else
    {
        if ((work->gameWork.objWork.userFlag & FALLINGSTALACTITE_FLAG_SHAKING) != 0)
        {
            work->gameWork.objWork.offset.x = FX32_FROM_WHOLE(mtMathRandRange2(-2, 2));
            work->gameWork.objWork.offset.y = FX32_FROM_WHOLE(mtMathRandRange2(-2, 2));
        }
        else if ((weakpoint->gameWork.objWork.userFlag & STALACTITE_FLAG_SHAKING) != 0)
        {
            work->gameWork.objWork.userFlag |= FALLINGSTALACTITE_FLAG_SHAKING;
        }
    }
}

void FallingStalactite_State_Fall(FallingStalactite *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
        work->gameWork.objWork.move.x = work->gameWork.objWork.move.y = work->gameWork.objWork.move.z = FLOAT_TO_FX32(0.0);
        ShakeScreen(SCREENSHAKE_D_SHORT);
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        work->gameWork.objWork.userFlag |= FALLINGSTALACTITE_FLAG_LANDED;
        work->gameWork.objWork.state = 0;
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STALACT_LANDING);
    }
}

void FallingStalactite_Collide(void)
{
    FallingStalactite *work = TaskGetWorkCurrent(FallingStalactite);

    if (!IsStageTaskDestroyedAny(&work->gameWork.objWork))
    {
        if (work->gameWork.colliders[0].parent != NULL)
            StageTask__HandleCollider(&work->gameWork.objWork, work->gameWork.colliders);

        if (!StageTask__ViewCheck_Default(&work->gameWork.objWork))
        {
            ObjCollisionObjectRegist(&work->gameWork.collisionObject.work);

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            ObjCollisionObjectRegist(&work->collisionWork1);

            work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            ObjCollisionObjectRegist(&work->collisionWork2);
            ObjCollisionObjectRegist(&work->collisionWork3);
        }
    }
}
