#include <sail/sailRingManager.h>
#include <sail/sailManager.h>
#include <sail/sailCommonObjects.h>
#include <sail/sailAudio.h>
#include <sail/sailPlayer.h>
#include <game/graphics/drawReqTask.h>
#include <stage/core/ringManager.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SailRingManager_Destructor(Task *task);
static void SailRingManager_Main(void);

static void SailRingManager_UpdateRings(SailRingManager *work);
static void SailRingManager_CheckObjectCollisions(SailRingManager *work, StageTask *player);
static void SailRingManager_CollectRing(SailRing *ring, StageTask *player);
static void SailRingManager_DrawRings(SailRingManager *work);
static void LoadSailRingManagerAssets(SailRingManager *work);

// --------------------
// FUNCTIONS
// --------------------

SailRingManager *CreateSailRingManager(void)
{
    Task *task = TaskCreate(SailRingManager_Main, SailRingManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1), SailRingManager);

    SailRingManager *work = TaskGetWork(task, SailRingManager);
    TaskInitWork16(work);

    LoadSailRingManagerAssets(work);

    return work;
}

SailRing *SailRingManager_CreateStageRing(VecFx32 *position)
{
    SailRing *ring;
    u16 ringSlot;

    SailManager *manager         = SailManager__GetWork();
    SailRingManager *ringManager = manager->ringManager;

    for (ringSlot = 0; ringSlot < SAILRINGMANAGER_RING_LIST_SIZE; ringSlot++)
    {
        ring = &ringManager->rings[ringSlot];
        if ((ring->flags & SAILRING_FLAG_ALLOCATED) == 0)
        {
            MI_CpuClear16(ring, sizeof(*ring));

            ring->flags |= SAILRING_FLAG_ALLOCATED;
            ring->position = *position;

            if (SailManager__GetShipType() == SHIP_SUBMARINE)
            {
                ring->position.y -= FLOAT_TO_FX32(16.0);
                ring->timer = 38;
                ring->flags |= SAILRING_FLAG_DISABLE_OBJ_COLLISIONS | SAILRING_FLAG_USE_OWN_VELOCITY;
            }
            else
            {
                ring->position.y -= FLOAT_TO_FX32(0.5);
            }

            return ring;
        }
    }

    return NULL;
}

SailRing *SailRingManager_CreateObjectRing(VecFx32 *position, VecFx32 *velocity)
{
    SailRing *ring;
    u16 ringSlot;

    SailManager *manager         = SailManager__GetWork();
    SailRingManager *ringManager = manager->ringManager;

    for (ringSlot = 0; ringSlot < SAILRINGMANAGER_RING_LIST_SIZE; ringSlot++)
    {
        ring = &ringManager->rings[ringSlot];
        if ((ring->flags & SAILRING_FLAG_ALLOCATED) == 0)
        {
            MI_CpuClear16(ring, sizeof(*ring));

            ring->flags |= SAILRING_FLAG_ALLOCATED;
            ring->position = *position;
            ring->position.y -= FLOAT_TO_FX32(0.5);
            ring->flags |= SAILRING_FLAG_USE_OWN_VELOCITY;
            ring->velocity = *velocity;
            ring->timer    = 60;

            return ring;
        }
    }

    return NULL;
}

void SailRingManager_DestroyRing(SailRing *ring)
{
    ring->flags &= ~SAILRING_FLAG_ALLOCATED;

    SailManager *manager = SailManager__GetWork();
    StageTask *player    = manager->sailPlayer;

    if (player != NULL)
    {
        if (player->objType == SAILSTAGE_OBJ_TYPE_PLAYER)
        {
            SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);
            playerWorker->missedRingCount++;
        }
    }
}

void SailRingManager_Destructor(Task *task)
{
    SailRingManager *work = TaskGetWork(task, SailRingManager);

    AnimatorSprite3D__Release(&work->aniRing);

    work->aniRingSparkle.animatorSprite.vramPalette = NULL;
    AnimatorSprite3D__Release(&work->aniRingSparkle);
}

void SailRingManager_Main(void)
{
    SailRingManager *work = TaskGetWorkCurrent(SailRingManager);

    SailRingManager_UpdateRings(work);
    SailRingManager_DrawRings(work);
}

void SailRingManager_UpdateRings(SailRingManager *work)
{
    VecFx32 *unknownPos = SailVoyageManager__GetVoyageUnknownPos();

    SailRing *ring;
    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        for (u16 r = 0; r < SAILRINGMANAGER_RING_LIST_SIZE; r++)
        {
            ring = &work->rings[r];
            if ((ring->flags & SAILRING_FLAG_ALLOCATED) != 0)
            {
                if ((ring->flags & SAILRING_FLAG_USE_OWN_VELOCITY) != 0)
                {
                    VEC_Add(&ring->position, &ring->velocity, &ring->position);

                    ring->velocity.y += FLOAT_TO_FX32(0.03173828125); // gravity

                    if (ring->velocity.y > FLOAT_TO_FX32(0.625))
                        ring->velocity.y = FLOAT_TO_FX32(0.625);
                }
                else
                {
                    VEC_Subtract(&ring->position, unknownPos, &ring->position);
                }
            }
        }
    }
    else
    {
        unknownPos->z = MultiplyFX(FLOAT_TO_FX32(1.5), unknownPos->z);

        VecFx32 position = *unknownPos;

        for (u16 r = 0; r < SAILRINGMANAGER_RING_LIST_SIZE; r++)
        {
            ring = &work->rings[r];
            if ((ring->flags & SAILRING_FLAG_ALLOCATED) != 0 && (ring->flags & SAILRING_FLAG_IS_SPARKLE) == 0)
            {
                if ((ring->flags & SAILRING_FLAG_USE_OWN_VELOCITY) != 0)
                {
                    position = *unknownPos;

                    ring->timer--;
                    if (ring->timer <= 16 && ring->timer >= 8)
                        position.z = MultiplyFX(position.z, ((ring->timer - 8) * FLOAT_TO_FX32(0.125)));

                    if (ring->timer == 9)
                        ring->flags &= ~SAILRING_FLAG_DISABLE_OBJ_COLLISIONS;

                    if (ring->timer <= 0 && ring->timer >= -8)
                        position.z = MultiplyFX(position.z, (MATH_ABS(ring->timer) * FLOAT_TO_FX32(0.125)));

                    if (ring->timer > 8 || ring->timer < 0)
                        VEC_Subtract(&ring->position, &position, &ring->position);
                }
                else
                {
                    VEC_Subtract(&ring->position, unknownPos, &ring->position);
                }
            }
        }
    }
}

void SailRingManager_CheckPlayerCollisions(SailRingManager *work, StageTask *player)
{
    SailColliderWorkHitCheckRing ringCollider = { 0 };

    SailRing *ring;
    if (SailManager__GetShipType() == SHIP_BOAT || SailManager__GetShipType() == SHIP_SUBMARINE)
    {
        // Player collects rings via pointer, so check object collisions instead!
        SailRingManager_CheckObjectCollisions(work, player);
    }
    else
    {
        if (player->objType != SAILSTAGE_OBJ_TYPE_PLAYER)
            return;

        SailPlayer *playerWork = GetStageTaskWorker(player, SailPlayer);

        ringCollider.field_24.x = FLOAT_TO_FX32(0.5);

        if ((player->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
            ringCollider.field_24.x <<= 1;

        for (u16 r = 0; r < SAILRINGMANAGER_RING_LIST_SIZE; r++)
        {
            ring = &work->rings[r];

            if ((ring->flags & SAILRING_FLAG_ALLOCATED) != 0 && (ring->flags & SAILRING_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
            {
                ringCollider.field_0   = ring->position;
                ringCollider.field_0.y = -ringCollider.field_0.y;
                ringCollider.field_0.y += FLOAT_TO_FX32(0.25);

                if (SailObject__CheckCollisions(&playerWork->colliders[0].hitCheck, (SailColliderWorkHitCheck *)&ringCollider, ringCollider.field_0.y))
                    SailRingManager_CollectRing(ring, player);
            }
        }
    }
}

void SailRingManager_CheckObjectCollisions(SailRingManager *work, StageTask *object)
{
    SailColliderWorkHitCheckRing ringCollider = { 0 };
    SailColliderWorkHitCheck *colliderPtr;
    SailRing *ring;
    SailManager *manager;
    StageTask *player;
    SailObject *objectWorker;
    u16 r;

    if (object->objType == SAILSTAGE_OBJ_TYPE_PLAYER)
        return;

    objectWorker = GetStageTaskWorker(object, SailObject);

    manager = SailManager__GetWork();
    player  = manager->sailPlayer;

    ringCollider.field_24.x = FLOAT_TO_FX32(1.5);

    colliderPtr = (SailColliderWorkHitCheck *)&ringCollider;
    switch (objectWorker->collider[0].type)
    {
        case 2:
            for (r = 0; r < SAILRINGMANAGER_RING_LIST_SIZE; r++)
            {
                ring = &work->rings[r];
                if ((ring->flags & SAILRING_FLAG_ALLOCATED) != 0 && (ring->flags & SAILRING_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
                {
                    ringCollider.field_0   = ring->position;
                    ringCollider.field_0.y = -ringCollider.field_0.y;
                    ringCollider.field_0.y += FLOAT_TO_FX32(1.0);

                    if (SailObject__Func_2165624(colliderPtr, &objectWorker->collider[0].hitCheck, ringCollider.field_0.y))
                    {
                        object->userFlag |= SAILOBJECT_FLAG_10;
                        ring->flags &= ~SAILRING_FLAG_USE_OWN_VELOCITY;
                        SailRingManager_CollectRing(ring, player);
                    }
                }
            }
            break;

        default:
            for (r = 0; r < SAILRINGMANAGER_RING_LIST_SIZE; r++)
            {
                ring = &work->rings[r];
                if ((ring->flags & SAILRING_FLAG_ALLOCATED) != 0 && (ring->flags & SAILRING_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
                {
                    ringCollider.field_0   = ring->position;
                    ringCollider.field_0.y = -ringCollider.field_0.y;
                    ringCollider.field_0.y += FLOAT_TO_FX32(1.0);

                    if (SailObject__CheckCollisions(colliderPtr, &objectWorker->collider[0].hitCheck, ringCollider.field_0.y))
                    {
                        object->userFlag |= SAILOBJECT_FLAG_10;
                        ring->flags &= ~SAILRING_FLAG_USE_OWN_VELOCITY;
                        SailRingManager_CollectRing(ring, player);
                    }
                }
            }
            break;
    }
}

void SailRingManager_CollectRing(SailRing *ring, StageTask *player)
{
    SailPlayer *playerWorker;
    u16 multiplier = 1;
    SailManager *manager;

    manager = SailManager__GetWork();

    playerWorker = GetStageTaskWorker(player, SailPlayer);

    SailPlayer__AddHealth(player, SAILRINGMANAGER_RING_HEAL_AMOUNT);

    ring->flags |= SAILRING_FLAG_DISABLE_OBJ_COLLISIONS | SAILRING_FLAG_IS_SPARKLE;
    ring->timer      = 0;
    ring->velocity.x = FLOAT_TO_FX32(0.0);
    ring->velocity.y = FLOAT_TO_FX32(0.0);
    ring->velocity.z = FLOAT_TO_FX32(0.0);

    playerWorker->rings++;
    if (playerWorker->rings > SAILPLAYER_MAX_RINGS)
        playerWorker->rings = SAILPLAYER_MAX_RINGS;

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
            SailPlayer__GiveBoost(player, FLOAT_TO_FX32(2.0));
            playerWorker->scoreComboCurrent++;
            playerWorker->trickFinishTimer = 80;
            playerWorker->missedRingCount  = 0;
            break;

        case SHIP_BOAT:
        case SHIP_SUBMARINE:
            playerWorker->scoreComboCurrent++;
            break;
    }

    if (playerWorker->scoreComboCurrent > SAILPLAYER_MAX_SCORE_COMBO)
        playerWorker->scoreComboCurrent = SAILPLAYER_MAX_SCORE_COMBO;

    if (playerWorker->scoreComboBest < playerWorker->scoreComboCurrent)
        playerWorker->scoreComboBest = playerWorker->scoreComboCurrent;

    if ((manager->flags & SAILMANAGER_FLAG_PLAYED_RING_SFX_THIS_FRAME) == 0)
        SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_RING, &ring->position);
    manager->flags |= SAILMANAGER_FLAG_PLAYED_RING_SFX_THIS_FRAME;

    multiplier += FX_DivS32(playerWorker->scoreComboCurrent, 50);

    playerWorker->score += 100 * multiplier;
    if (playerWorker->score > SAILPLAYER_MAX_SCORE)
        playerWorker->score = SAILPLAYER_MAX_SCORE;

    VecFx32 scoreBonusPos = ring->position;
    scoreBonusPos.y       = -scoreBonusPos.y;

    if (multiplier > 9)
        multiplier = 9;

    SailScoreBonus *scoreBonus = SailScoreBonus__CreateWorld(&scoreBonusPos, 100, multiplier);
    scoreBonus->lifeTimer >>= 1;
}

void SailRingManager_DrawRings(SailRingManager *work)
{
    AnimatorSprite3D *aniRing        = &work->aniRing;
    AnimatorSprite3D *aniRingSparkle = &work->aniRingSparkle;
    SailRing *ring;

    VRAMPixelKey vramPixels = aniRingSparkle->animatorSprite.vramPixels;

    aniRing->work.matrixOpIDs[0]        = MATRIX_OP_FLUSH_VP;
    aniRingSparkle->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;

    Animator3D__Process(&aniRing->work);
    Camera3D__CopyMatrix3x3(NNS_G3dGlbGetCameraMtx(), &aniRing->work.rotation);
    aniRingSparkle->work.rotation = aniRing->work.rotation;

    for (u16 r = 0; r < SAILRINGMANAGER_RING_LIST_SIZE; r++)
    {
        ring = &work->rings[r];

        if ((ring->flags & SAILRING_FLAG_ALLOCATED) != 0 && (ring->flags & SAILRING_FLAG_INVISIBLE) == 0)
        {
            if ((ring->flags & SAILRING_FLAG_IS_SPARKLE) != 0)
            {
                aniRingSparkle->work.translation          = ring->position;
                aniRingSparkle->work.translation.y        = -aniRingSparkle->work.translation.y;
                aniRingSparkle->animatorSprite.vramPixels = vramPixels + (ring->timer >> 1) * work->ringTextureSize;

                Animator3D__Draw(&aniRingSparkle->work);

                ring->timer++;
                if (ring->timer >= 12)
                    ring->flags &= ~SAILRING_FLAG_ALLOCATED;
            }
            else
            {
                aniRing->work.translation = ring->position;

                aniRing->work.translation.y = -aniRing->work.translation.y;
                if (ring->timer != 0 && SailManager__GetShipType() != SHIP_SUBMARINE)
                {
                    ring->timer--;
                    if (ring->timer < 16)
                    {
                        // blinking
                        if ((ring->timer & 1) != 0)
                        {
                            Animator3D__Draw(&aniRing->work);
                        }
                    }
                    else
                    {
                        Animator3D__Draw(&aniRing->work);
                    }

                    if (ring->timer == 0)
                        SailRingManager_DestroyRing(ring);
                }
                else
                {
                    Animator3D__Draw(&aniRing->work);
                }
            }

            aniRing->work.matrixOpIDs[0]        = MATRIX_OP_FLUSH_VP_CAMERA3D;
            aniRingSparkle->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP_CAMERA3D;
        }
    }

    aniRingSparkle->animatorSprite.vramPixels = vramPixels;
}

void LoadSailRingManagerAssets(SailRingManager *work)
{
    VRAMPaletteKey vramPalette;
    VRAMPixelKey vramPixels;

    void *sprFile = ObjDataLoad(NULL, "sb_ring.bac", SailManager__GetArchive());

    vramPixels  = VRAMSystem__AllocTexture((u16)Sprite__GetTextureSize(sprFile), FALSE);
    vramPalette = VRAMSystem__AllocPalette((u16)Sprite__GetPaletteSize(sprFile), FALSE);
    AnimatorSprite3D__Init(&work->aniRing, ANIMATOR_FLAG_NONE, sprFile, RING_ANI_RING, ANIMATOR_FLAG_NONE, vramPixels, vramPalette);

    fx32 scale;
    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
        default:
            scale = FLOAT_TO_FX32(0.015625);
            break;

        case SHIP_BOAT:
        case SHIP_SUBMARINE:
            scale = FLOAT_TO_FX32(0.0625);
            break;
    }

    work->aniRing.work.scale.x = scale;
    work->aniRing.work.scale.y = scale;
    work->aniRing.work.scale.z = scale;
    work->aniRing.polygonAttr.enableFog = TRUE;
    AnimatorSprite3D__ProcessAnimationFast(&work->aniRing);
    work->aniRing.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;

    AnimatorSprite3D *aniRingSparkle = &work->aniRingSparkle;

    u16 textureSize       = Sprite__GetTextureSize(sprFile);
    vramPixels            = VRAMSystem__AllocTexture(6 * textureSize, FALSE);
    work->ringTextureSize = textureSize;

    AnimatorSprite3D__Init(aniRingSparkle, ANIMATOR_FLAG_NONE, sprFile, RING_ANI_RING, ANIMATOR_FLAG_NONE, vramPixels, vramPalette);

    aniRingSparkle->work.scale.x = FLOAT_TO_FX32(0.015625);
    aniRingSparkle->work.scale.y = FLOAT_TO_FX32(0.015625);
    aniRingSparkle->work.scale.z = FLOAT_TO_FX32(0.015625);

    Animator2D__SetAnimation(&aniRingSparkle->animatorSprite, RING_ANI_SPARKLE);
    aniRingSparkle->animatorSprite.animAdvance = FLOAT_TO_FX32(1.0);

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
        default:
            scale = FLOAT_TO_FX32(0.015625);
            break;

        case SHIP_BOAT:
        case SHIP_SUBMARINE:
            scale = FLOAT_TO_FX32(0.0625);
            break;
    }

    aniRingSparkle->work.scale.x = scale;
    aniRingSparkle->work.scale.y = scale;
    aniRingSparkle->work.scale.z = scale;

    aniRingSparkle->polygonAttr.enableFog = TRUE;
    for (u16 i = 0; i < 6; i++)
    {
        AnimatorSprite3D__ProcessAnimationFast(aniRingSparkle);
        aniRingSparkle->animatorSprite.vramPixels += textureSize;
    }
    aniRingSparkle->animatorSprite.vramPixels = vramPixels;
}