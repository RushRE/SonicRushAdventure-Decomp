#include <stage/core/ringManager.h>
#include <game/graphics/vramSystem.h>
#include <game/stage/gameSystem.h>
#include <game/stage/bossHelpers.h>
#include <game/game/gameState.h>
#include <game/object/obj.h>

// --------------------
// FUNCTION DECLS
// --------------------

// List management
static Ring *CreateRingInstance(void);
static void DestroyRingInstance(Ring *ring);
static void AddRingToStageList(Ring *ring);
static void RemoveRingFromStageList(Ring *ring);
static void AddRingToTwinkleList(Ring *ring);
static void RemoveRingFromTwinkleList(Ring *ring);
static void AddRingToAttractList(Ring *ring);
static void RemoveRingFromAttractList(Ring *ring);
static void AddRingToSpillList(Ring *ring);
static void RemoveRingFromSpillList(Ring *ring);

// Task events
static void RingManager_Destructor(Task *task);
static void RingManager_Main(void);

// Stage collision functions
static void RingManager_StageCollide_Flat(Ring *ring); // used for everything except Z4 & Z5 bosses
static void RingManager_StageCollide_Boss(Ring *ring); // used for Z4 & Z5 boss

// Ring drawing functions
static void RingManager_DrawRing_ZoneAct(Ring *ring);      // used for all acts
static void RingManager_DrawRing_BossFlat(Ring *ring);     // used for all bosses except Z2 & Z3 bosses
static void RingManager_DrawRing_BossCircular(Ring *ring); // used for Z2 & Z3 boss

// Ring sparkle drawing functions
static void RingManager_DrawSparkle_ZoneAct(Ring *ring);      // used for all acts
static void RingManager_DrawSparkle_BossFlat(Ring *ring);     // used for all bosses except Z2 & Z3 bosses
static void RingManager_DrawSparkle_BossCircular(Ring *ring); // used for Z2 & Z3 boss

// Rect/Player collision functions
static BOOL RingManager_RectCollide_Flat(OBS_RECT *rect1, OBS_RECT *rect2);     // used for most bosses & all acts
static BOOL RingManager_RectCollide_Circular(OBS_RECT *rect1, OBS_RECT *rect2); // used for Z2 & Z3 boss

// --------------------
// VARIABLES
// --------------------

static Task *sRingManagerTaskSingleton;
RingManager *gRingManagerWork;

static fx32 sStageRingScale   = FLOAT_TO_FX32(1.0);
s16 gSpillRingGravityStrength = FLOAT_TO_FX32(0.0703125);

// --------------------
// FUNCTIONS
// --------------------

RingManager *CreateRingManager(void)
{
    Task *task = TaskCreate(RingManager_Main, RingManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(3), RingManager);
    if (task == HeapNull)
        return NULL;

    sRingManagerTaskSingleton = task;

    gRingManagerWork = TaskGetWork(task, RingManager);
    TaskInitWork16(gRingManagerWork);

    gRingManagerWork->gPlayerCount = 1;
    if (gmCheckVsBattleFlag())
        gRingManagerWork->gPlayerCount = PLAYER_COUNT;

    Ring *ringStorage = gRingManagerWork->ringListStorage;
    for (s32 i = 0; i < RINGMANAGER_RING_LIST_COUNT; i++)
    {
        gRingManagerWork->ringList[i] = &ringStorage[i];
    }

    sStageRingScale = FLOAT_TO_FX32(1.0);

    if (gmCheckStage(STAGE_Z2B) || gmCheckStage(STAGE_Z3B))
        gRingManagerWork->rectCollideFunc = RingManager_RectCollide_Circular;
    else
        gRingManagerWork->rectCollideFunc = RingManager_RectCollide_Flat;

    if (gmCheckStage(STAGE_Z4B) || gmCheckStage(STAGE_Z5B))
        gRingManagerWork->stageCollideFunc = RingManager_StageCollide_Boss;
    else
        gRingManagerWork->stageCollideFunc = RingManager_StageCollide_Flat;

    if (gameState.stageID == STAGE_Z6B)
        gRingManagerWork->penaltyMultiplier = FLOAT_TO_FX32(2.0);

    if (IsBossStage())
    {
        switch (gameState.stageID)
        {
            case STAGE_Z2B:
                gRingManagerWork->drawRing    = RingManager_DrawRing_BossCircular;
                gRingManagerWork->drawSparkle = RingManager_DrawSparkle_BossCircular;
                break;

            case STAGE_Z3B:
                gRingManagerWork->drawRing    = RingManager_DrawRing_BossCircular;
                gRingManagerWork->drawSparkle = RingManager_DrawSparkle_BossCircular;
                break;

            default:
                gRingManagerWork->drawRing    = RingManager_DrawRing_BossFlat;
                gRingManagerWork->drawSparkle = RingManager_DrawSparkle_BossFlat;
                break;
        }

        void *spriteFile = ObjDataLoad(NULL, "/ac_itm_ring3d.bac", gameArchiveCommon);

        AnimatorSprite3D *ani = &gRingManagerWork->aniRing3D;
        AnimatorSprite3D__Init(ani, ANIMATOR_FLAG_NONE, spriteFile, RING_ANI_RING,
                               ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK,
                               VRAMSystem__AllocTexture(128, FALSE), VRAMSystem__AllocPalette(16, FALSE));
        ani->work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
        ani->work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
        ani->work.scale.x = ani->work.scale.y = ani->work.scale.z = FLOAT_TO_FX32(1.0);
        AnimatorSprite3D__ProcessAnimationFast(ani);
        ani->animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

        ani = &gRingManagerWork->aniRingSparkle3D;
        AnimatorSprite3D__Init(ani, ANIMATOR_FLAG_NONE, spriteFile, RING_ANI_SPARKLE,
                               ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS,
                               VRAMSystem__AllocTexture(768, FALSE), VRAMSystem__AllocPalette(16, FALSE));
        ani->work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
        ani->work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
        ani->work.scale.x = ani->work.scale.y = ani->work.scale.z = FLOAT_TO_FX32(1.0);
        AnimatorSprite3D__ProcessAnimationFast(ani);
        ani->animatorSprite.flags |= ANIMATOR_FLAG_USE_FRAME_REMAINDER | ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    }
    else
    {
        gRingManagerWork->drawRing    = RingManager_DrawRing_ZoneAct;
        gRingManagerWork->drawSparkle = RingManager_DrawSparkle_ZoneAct;

        void *spriteFile = ObjDataLoad(NULL, "/ac_itm_ring.bac", gameArchiveCommon);

        AnimatorSpriteDS *ani = &gRingManagerWork->aniRing;
        AnimatorSpriteDS__Init(ani, spriteFile, RING_ANI_RING, 0, ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK,
                               PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, 2), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE,
                               VRAMSystem__AllocSpriteVram(TRUE, 2), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_1, SPRITE_ORDER_11);
        ani->cParam[0].palette = PALETTE_ROW_2;
        ani->cParam[1].palette = PALETTE_ROW_2;

        ani = &gRingManagerWork->aniRingSparkle;
        AnimatorSpriteDS__Init(ani, spriteFile, RING_ANI_SPARKLE, 0, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES,
                               PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, 16), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE,
                               VRAMSystem__AllocSpriteVram(TRUE, 16), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_1, SPRITE_ORDER_11);
        ani->cParam[0].palette = PALETTE_ROW_2;
        ani->cParam[1].palette = PALETTE_ROW_2;

        AnimatorSpriteDS__ProcessAnimationFast(ani);
        ani->work.flags |= ANIMATOR_FLAG_USE_FRAME_REMAINDER | ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

        ObjDraw__TintSprite(spriteFile, RING_ANI_RING, 2, FALSE);
        ObjDraw__TintSprite(spriteFile, RING_ANI_RING, 2, TRUE);
    }

    return gRingManagerWork;
}

Ring *CreateSpillRing(fx32 x, fx32 y, fx32 z, fx32 velocityX, fx32 velocityY, RingFlag flag)
{
    if (gRingManagerWork == NULL)
        return NULL;

    Ring *ring = CreateRingInstance();
    if (ring == NULL)
        return NULL;

    ring->position.x = x;
    ring->position.y = y;
    ring->position.z = z;

    ring->velocity.x = velocityX;
    ring->velocity.y = velocityY;

    ring->scale.x = ring->scale.y = ring->scale.z = FLOAT_TO_FX32(1.0);

    ring->timer = RINGMANAGER_RING_SPILL_LIFETIME + mtMathRandRepeat(32);
    ring->flag  = flag;

    ring->eveRef     = NULL;
    ring->ductObject = NULL;

    if (Player__UseUpsideDownGravity(x, y))
        ring->flag |= RING_FLAG_REVERSE_GRAVITY;
    else
        ring->flag &= ~RING_FLAG_REVERSE_GRAVITY;

    AddRingToSpillList(ring);

    return ring;
}

Ring *CreateStageRing3D(MapRing *mapRing, fx32 x, fx32 y, fx32 z)
{
    if (gRingManagerWork == NULL)
        return NULL;

    if (gmCheckMissionType(MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING))
    {
        if (mapRing)
            DestroyMapObject(mapRing);

        return NULL;
    }

    Ring *ring = CreateRingInstance();
    if (ring == NULL)
        return NULL;

    ring->position.x = x;
    ring->position.y = y;
    ring->position.z = z;

    ring->velocity.x = 0;
    ring->velocity.y = 0;

    ring->scale.x = ring->scale.y = ring->scale.z = sStageRingScale;

    ring->timer = 0;
    ring->flag  = RING_FLAG_NONE;

    if (mapRing)
        DestroyMapObject(mapRing);

    ring->eveRef     = mapRing;
    ring->ductObject = NULL;

    if (Player__UseUpsideDownGravity(x, y))
        ring->flag |= RING_FLAG_REVERSE_GRAVITY;

    AddRingToStageList(ring);

    return ring;
}

Ring *CreateStageRing2D(MapRing *ring, fx32 x, fx32 y)
{
    CreateStageRing3D(ring, x, y, 0);
    return NULL;
}

void CreateLoseRingEffect(Player *player, s32 rings)
{
    static const u8 penaltyCap[] = { 3, 4 };

    fx32 velX, velY;
    s32 r;

    s32 spillRingCount = rings;
    fx32 ringAngle     = FLOAT_DEG_TO_IDX(6.375);
    u8 playerID        = player->controlID;

    RingFlag flag = RING_FLAG_IS_SPILLRING | ((playerID << 4) & 0x10);

    if (gRingManagerWork == NULL)
        return;

    if (rings > player->rings)
    {
        spillRingCount = player->rings;
    }
    else if (rings < 0)
    {
        return;
    }

    player->rings -= spillRingCount;
    if (spillRingCount > RINGMANAGER_RING_SPILL_MAX)
        spillRingCount = RINGMANAGER_RING_SPILL_MAX;

    gRingManagerWork->flags |= RINGMANAGER_FLAG_PENALTY_ACTIVE_P1 << playerID;

    if ((player->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B) != 0 && (player->gimmickFlag & PLAYER_GIMMICK_DISABLE_RINGS_ON_PLANE_B) == 0)
        flag |= RING_FLAG_USE_PLANE_B;

    ringAngle += (gRingManagerWork->ringPenaltyCount[playerID] << 8);
    for (r = 0; r < spillRingCount; r++)
    {
        if (ringAngle >= 0)
        {
            s32 ang   = ringAngle >> 8;
            s32 shift = ang >= 6 ? -ang + 9 : ang;

            u16 angle2 = ((s32)ringAngle << 8);
            fx32 sin   = SinFX((s32)(u16)(s32)angle2) << 4 >> shift;
            fx32 cos   = CosFX((s32)(u16)(s32)angle2) << 4 >> shift;
            velX       = sin - (sin >> 2);
            velY       = cos - (cos >> 2);

            ringAngle = (ringAngle + 0x10) | 0x80;
        }

        if (CreateSpillRing(player->objWork.position.x, player->objWork.position.y, 0, velX, velY, flag) != NULL)
        {
            ringAngle = -ringAngle;
            velX      = -velX;
        }
        else
        {
            break;
        }
    }

    if (gRingManagerWork->ringPenaltyCount[playerID] < penaltyCap[gameState.difficulty])
        gRingManagerWork->ringPenaltyCount[playerID]++;
}

RingManager *GetRingManagerWork(void)
{
    return gRingManagerWork;
}

void SetStageRingScale(fx32 scale)
{
    if (!IsBossStage() && scale > FLOAT_TO_FX32(2.0))
        scale = FLOAT_TO_FX32(2.0);

    sStageRingScale = scale;
}

fx32 GetStageRingScale(void)
{
    return sStageRingScale;
}

void HandleRingMagnetEffect(Player *player)
{
    Ring *next;

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_MAGNET) == 0)
    {
        next = gRingManagerWork->attractRingListStart;
        if (next != NULL)
        {
            if (gRingManagerWork->stageListEnd != NULL)
            {
                gRingManagerWork->stageListEnd->next         = next;
                gRingManagerWork->attractRingListStart->prev = gRingManagerWork->stageListEnd;
                gRingManagerWork->stageListEnd               = gRingManagerWork->attractRingListEnd;
            }
            else
            {
                gRingManagerWork->stageListStart = next;
                gRingManagerWork->stageListEnd   = gRingManagerWork->attractRingListEnd;
            }

            gRingManagerWork->attractRingListEnd   = NULL;
            gRingManagerWork->attractRingListStart = gRingManagerWork->attractRingListEnd;
        }
    }
    else
    {
        OBS_RECT rectPlayer;
        OBS_RECT rectRing;

        rectRing.left   = -8;
        rectRing.top    = -16;
        rectRing.right  = 8;
        rectRing.bottom = 0;
        rectRing.front  = 8;
        rectRing.back   = -8;

        rectPlayer.pos.x = FX32_TO_WHOLE(player->objWork.position.x);
        rectPlayer.pos.y = FX32_TO_WHOLE(player->objWork.position.y);
        rectPlayer.pos.z = FX32_TO_WHOLE(player->objWork.position.z);

        rectPlayer.left   = -RINGMANAGER_PLAYER_ATTRACT_SIZE;
        rectPlayer.top    = -RINGMANAGER_PLAYER_ATTRACT_SIZE;
        rectPlayer.right  = RINGMANAGER_PLAYER_ATTRACT_SIZE;
        rectPlayer.bottom = RINGMANAGER_PLAYER_ATTRACT_SIZE;
        rectPlayer.front  = -RINGMANAGER_PLAYER_ATTRACT_SIZE;
        rectPlayer.back   = RINGMANAGER_PLAYER_ATTRACT_SIZE;

        next = gRingManagerWork->stageListStart;
        while (next != NULL)
        {
            Ring *ring = next;
            next       = next->next;

            rectRing.pos.x = FX32_TO_WHOLE(ring->position.x);
            rectRing.pos.y = FX32_TO_WHOLE(ring->position.y);
            rectRing.pos.z = FX32_TO_WHOLE(ring->position.z);
            if (gRingManagerWork->rectCollideFunc(&rectPlayer, &rectRing))
            {
                ring->flag &= ~RING_FLAG_ATTRACT_P2;
                ring->flag |= (player->controlID & 1);
                RemoveRingFromStageList(ring);
                AddRingToAttractList(ring);
            }
        }
    }
}

Ring *CreateRingInstance(void)
{
    if (gRingManagerWork->usedRingCount >= RINGMANAGER_RING_LIST_COUNT)
        return NULL;

    Ring *ring = gRingManagerWork->ringList[gRingManagerWork->usedRingCount];
    gRingManagerWork->usedRingCount++;
    return ring;
}

void DestroyRingInstance(Ring *ring)
{
    gRingManagerWork->usedRingCount--;
    gRingManagerWork->ringList[gRingManagerWork->usedRingCount] = ring;
}

void AddRingToStageList(Ring *ring)
{
    if (gRingManagerWork->stageListEnd != NULL)
    {
        gRingManagerWork->stageListEnd->next = ring;
        ring->prev                           = gRingManagerWork->stageListEnd;
        ring->next                           = NULL;
        gRingManagerWork->stageListEnd       = ring;
    }
    else
    {
        gRingManagerWork->stageListEnd   = ring;
        gRingManagerWork->stageListStart = gRingManagerWork->stageListEnd;
        ring->next                       = NULL;
        ring->prev                       = NULL;
    }
}

void RemoveRingFromStageList(Ring *ring)
{
    if (ring->prev != NULL)
        ring->prev->next = ring->next;
    else
        gRingManagerWork->stageListStart = ring->next;

    if (ring->next != NULL)
        ring->next->prev = ring->prev;
    else
        gRingManagerWork->stageListEnd = ring->prev;
}

void AddRingToTwinkleList(Ring *ring)
{
    if (gRingManagerWork->twinkleListEnd != NULL)
    {
        gRingManagerWork->twinkleListEnd->next = ring;
        ring->prev                             = gRingManagerWork->twinkleListEnd;
        ring->next                             = NULL;
        gRingManagerWork->twinkleListEnd       = ring;
    }
    else
    {
        gRingManagerWork->twinkleListEnd   = ring;
        gRingManagerWork->twinkleListStart = gRingManagerWork->twinkleListEnd;
        ring->next                         = NULL;
        ring->prev                         = NULL;
    }
}

void RemoveRingFromTwinkleList(Ring *ring)
{
    if (ring->prev != NULL)
        ring->prev->next = ring->next;
    else
        gRingManagerWork->twinkleListStart = ring->next;

    if (ring->next != NULL)
        ring->next->prev = ring->prev;
    else
        gRingManagerWork->twinkleListEnd = ring->prev;
}

void AddRingToAttractList(Ring *ring)
{
    if (gRingManagerWork->attractRingListEnd != NULL)
    {
        gRingManagerWork->attractRingListEnd->next = ring;
        ring->prev                                 = gRingManagerWork->attractRingListEnd;
        ring->next                                 = NULL;
        gRingManagerWork->attractRingListEnd       = ring;
    }
    else
    {
        gRingManagerWork->attractRingListEnd   = ring;
        gRingManagerWork->attractRingListStart = gRingManagerWork->attractRingListEnd;
        ring->next                             = NULL;
        ring->prev                             = NULL;
    }
}

void RemoveRingFromAttractList(Ring *ring)
{
    if (ring->prev != NULL)
        ring->prev->next = ring->next;
    else
        gRingManagerWork->attractRingListStart = ring->next;

    if (ring->next != NULL)
        ring->next->prev = ring->prev;
    else
        gRingManagerWork->attractRingListEnd = ring->prev;
}

void AddRingToSpillList(Ring *ring)
{
    if (gRingManagerWork->spillListEnd != NULL)
    {
        gRingManagerWork->spillListEnd->next = ring;
        ring->prev                           = gRingManagerWork->spillListEnd;
        ring->next                           = NULL;
        gRingManagerWork->spillListEnd       = ring;
    }
    else
    {
        gRingManagerWork->spillListEnd   = ring;
        gRingManagerWork->spillListStart = gRingManagerWork->spillListEnd;
        ring->next                       = NULL;
        ring->prev                       = NULL;
    }
}

void RemoveRingFromSpillList(Ring *ring)
{
    if (ring->prev != NULL)
        ring->prev->next = ring->next;
    else
        gRingManagerWork->spillListStart = ring->next;

    if (ring->next != NULL)
        ring->next->prev = ring->prev;
    else
        gRingManagerWork->spillListEnd = ring->prev;
}

void RingManager_Destructor(Task *task)
{
    for (Ring *ring = gRingManagerWork->stageListStart; ring != NULL; ring = ring->next)
    {
        if (ring->eveRef != NULL)
            ring->eveRef->x = FX32_TO_WHOLE(ring->position.x);
    }

    if (IsBossStage())
    {
        AnimatorSprite3D__Release(&gRingManagerWork->aniRing3D);
        AnimatorSprite3D__Release(&gRingManagerWork->aniRingSparkle3D);
    }
    else
    {
        AnimatorSpriteDS__Release(&gRingManagerWork->aniRing);
        AnimatorSpriteDS__Release(&gRingManagerWork->aniRingSparkle);
    }

    sRingManagerTaskSingleton = NULL;
    gRingManagerWork          = NULL;
}

void RingManager_Main(void)
{
    s32 lastTimer;
    s32 p;
    Ring *ring;
    Ring *next;
    Player *player;
    BOOL collected;

    if ((gRingManagerWork->flags & RINGMANAGER_FLAG_INACTIVE) != 0)
        return;

    OBS_RECT playerRect[PLAYER_COUNT];
    for (p = 0; p < gRingManagerWork->gPlayerCount; p++)
    {
        player                  = gPlayerList[p];
        OBS_RECT_WORK *collider = &player->colliders[0];

        playerRect[p].pos.x = FX32_TO_WHOLE(player->objWork.position.x);
        playerRect[p].pos.y = FX32_TO_WHOLE(player->objWork.position.y);
        playerRect[p].pos.z = FX32_TO_WHOLE(player->objWork.position.z);

        s16 left;
        s16 right;
        if (((player->objWork.displayFlag ^ collider->flag) & DISPLAY_FLAG_FLIP_X) != 0)
        {
            left  = -collider->rect.right;
            right = -collider->rect.left;
        }
        else
        {
            left  = collider->rect.left;
            right = collider->rect.right;
        }

        if (player->objWork.scale.x != FLOAT_TO_FX32(1.0))
        {
            left  = MultiplyFX(left, player->objWork.scale.x);
            right = MultiplyFX(right, player->objWork.scale.x);
        }

        playerRect[p].left  = left;
        playerRect[p].right = right;

        // left => top
        // right => bottom
        // (we have to use the same two variables to get the code to match!)
        if (((player->objWork.displayFlag ^ collider->flag) & DISPLAY_FLAG_FLIP_Y) != 0)
        {
            left  = -collider->rect.bottom;
            right = -collider->rect.top;
        }
        else
        {
            left  = collider->rect.top;
            right = collider->rect.bottom;
        }

        if (player->objWork.scale.y != FLOAT_TO_FX32(1.0))
        {
            left  = MultiplyFX(left, player->objWork.scale.y);
            right = MultiplyFX(right, player->objWork.scale.y);
        }

        playerRect[p].top    = left;
        playerRect[p].bottom = right;

        // left => back
        // right => front
        // (we have to use the same two variables to get the code to match!)
        left  = collider->rect.back;
        right = collider->rect.front;

        if (player->objWork.scale.z != FLOAT_TO_FX32(1.0))
        {
            left  = MultiplyFX(left, player->objWork.scale.z);
            right = MultiplyFX(right, player->objWork.scale.z);
        }

        playerRect[p].back  = left;
        playerRect[p].front = right;
    }

    OBS_RECT ringRect;
    ringRect.left   = -8;
    ringRect.top    = -16;
    ringRect.right  = 8;
    ringRect.bottom = 0;
    ringRect.back   = -8;
    ringRect.front  = 8;

    if (IsBossStage())
        AnimatorSprite3D__ProcessAnimationFast(&gRingManagerWork->aniRing3D);
    else
        AnimatorSpriteDS__ProcessAnimationFast(&gRingManagerWork->aniRing);

    // -------------
    // RING SPARKLES
    // -------------

    if (IsBossStage())
    {
        AnimatorSprite *ani = &gRingManagerWork->aniRingSparkle3D.animatorSprite;
        AnimatorSprite__SetAnimation(ani, 1);

        ring      = gRingManagerWork->twinkleListEnd;
        lastTimer = 0;
        while (ring != NULL)
        {
            fx32 advance = (ring->timer - lastTimer);
            if (advance != 0)
            {
                AnimatorSprite__AnimateManualFast(ani, FX32_FROM_WHOLE(advance));
                lastTimer = ring->timer;
            }

            gRingManagerWork->drawSparkle(ring);

            ring->timer++;
            if (ring->timer >= RINGMANAGER_RING_SPARKLE_LIFETIME)
            {
                RemoveRingFromTwinkleList(ring);
                DestroyRingInstance(ring);
            }

            ring = ring->prev;
        }
    }
    else
    {
        AnimatorSpriteDS *ani = &gRingManagerWork->aniRingSparkle;
        AnimatorSpriteDS__SetAnimation(ani, 1);

        ring      = gRingManagerWork->twinkleListEnd;
        lastTimer = 0;
        while (ring != NULL)
        {
            fx32 advance = (ring->timer - lastTimer);
            if (advance != 0)
            {
                AnimatorSpriteDS__AnimateManual(ani, FX32_FROM_WHOLE(advance), NULL, NULL);
                lastTimer = ring->timer;
            }

            gRingManagerWork->drawSparkle(ring);

            ring->timer++;
            if (ring->timer >= RINGMANAGER_RING_SPARKLE_LIFETIME)
            {
                RemoveRingFromTwinkleList(ring);
                DestroyRingInstance(ring);
            }

            ring = ring->prev;
        }
    }

    // -------------
    // STAGE RINGS
    // -------------

    next = gRingManagerWork->stageListStart;
    while (next)
    {
        ring = next;
        next = next->next;

        if (StageTask__ViewOutCheck(ring->position.x, ring->position.y, 72, 0, 0, 0, 0))
        {
            if (ring->eveRef != NULL)
                ring->eveRef->x = FX32_TO_WHOLE(ring->position.x);

            RemoveRingFromStageList(ring);
            DestroyRingInstance(ring);
        }
        else
        {
            gRingManagerWork->drawRing(ring);

            p         = 0;
            collected = FALSE;
            for (; p < gRingManagerWork->gPlayerCount; p++)
            {
                ringRect.pos.x = FX32_TO_WHOLE(ring->position.x);
                ringRect.pos.y = FX32_TO_WHOLE(ring->position.y);
                ringRect.pos.z = FX32_TO_WHOLE(ring->position.z);

                player = gPlayerList[p];
                if (gRingManagerWork->rectCollideFunc(&playerRect[p], &ringRect))
                {
                    collected = TRUE;
                    Player__GiveRings(player, 1);
                    if (IsBossStage())
                    {
                        if (gRingManagerWork->ringPenaltyCount[p])
                            gRingManagerWork->ringPenaltyCount[p]--;
                    }
                }
            }

            if (collected)
            {
                ring->timer = 0;
                RemoveRingFromStageList(ring);
                AddRingToTwinkleList(ring);
            }
        }
    }

    // -------------
    // ATTRACT RINGS
    // -------------

    next = gRingManagerWork->attractRingListStart;
    while (next)
    {
        ring = next;
        next = next->next;

        if (StageTask__ViewOutCheck(ring->position.x, ring->position.y, 72, 0, 0, 0, 0))
        {
            if (ring->eveRef != NULL)
                ring->eveRef->x = FX32_TO_WHOLE(ring->position.x);

            RemoveRingFromAttractList(ring);
            DestroyRingInstance(ring);
        }
        else
        {
            OBS_RECT *rect = &playerRect[ring->flag & RING_FLAG_ATTRACT_P2];

            fx32 angle       = FX_Atan2Idx(rect->pos.y - FX32_TO_WHOLE(ring->position.y), rect->pos.x - FX32_TO_WHOLE(ring->position.x));
            ring->velocity.x = ObjSpdUpSet(ring->velocity.x, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(31.0));

            ring->position.x += ((ring->velocity.x >> 8) * CosFX((s32)angle)) >> 4;
            ring->position.y += ((ring->velocity.x >> 8) * SinFX((s32)angle)) >> 4;

            fx32 target = FX32_FROM_WHOLE(rect->pos.z);
            if (ring->position.z != target)
            {
                fx32 z = ObjShiftSet(ring->position.z, target, 1, FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(1.0));

                ring->scale.x += (z - ring->position.z) >> 8;
                if (ring->scale.x > FLOAT_TO_FX32(2.0))
                    ring->scale.x = FLOAT_TO_FX32(2.0);

                ring->scale.y = ring->scale.z = ring->scale.x;

                ring->position.z = z;
            }
            gRingManagerWork->drawRing(ring);

            p         = 0;
            collected = FALSE;
            for (; p < gRingManagerWork->gPlayerCount; p++)
            {
                ringRect.pos.x = FX32_TO_WHOLE(ring->position.x);
                ringRect.pos.y = FX32_TO_WHOLE(ring->position.y);
                ringRect.pos.z = FX32_TO_WHOLE(ring->position.z);

                player = gPlayerList[p];
                if (gRingManagerWork->rectCollideFunc(&playerRect[p], &ringRect))
                {
                    collected = TRUE;
                    Player__GiveRings(player, 1);
                }
            }

            if (collected)
            {
                ring->timer = 0;
                RemoveRingFromAttractList(ring);
                AddRingToTwinkleList(ring);
            }
        }
    }

    // -------------
    // SPILLED RINGS
    // -------------

    next = gRingManagerWork->spillListStart;
    while (next)
    {
        ring = next;
        next = next->next;

        if (StageTask__ViewOutCheck(ring->position.x, ring->position.y, 196, 0, 0, 0, 0))
        {
            RemoveRingFromSpillList(ring);
            DestroyRingInstance(ring);
        }
        else
        {
            ring->position.x += ring->velocity.x;

            if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
                ring->position.y -= ring->velocity.y;
            else
                ring->position.y += ring->velocity.y;

            ring->velocity.y += gSpillRingGravityStrength;

            gRingManagerWork->stageCollideFunc(ring);

            ring->timer--;
            if (ring->timer == 0)
            {
                RemoveRingFromSpillList(ring);
                DestroyRingInstance(ring);
            }
            else
            {
                if (ring->timer <= (RINGMANAGER_RING_SPILL_LIFETIME - RINGMANAGER_RING_SPILL_COOLDOWN))
                {
                    p         = 0;
                    collected = FALSE;
                    for (; p < gRingManagerWork->gPlayerCount; p++)
                    {
                        ringRect.pos.x = FX32_TO_WHOLE(ring->position.x);
                        ringRect.pos.y = FX32_TO_WHOLE(ring->position.y);
                        ringRect.pos.z = 0;

                        player = gPlayerList[p];
                        if (gRingManagerWork->rectCollideFunc(&playerRect[p], &ringRect))
                        {
                            collected = TRUE;

                            s32 ringStageCount = player->ringStageCount;
                            Player__GiveRings(player, 1);
                            if (ringStageCount < PLAYER_MAX_RINGS)
                                player->ringStageCount--;

                            if ((gRingManagerWork->flags & (RINGMANAGER_FLAG_PENALTY_ACTIVE_P1 << p)) != 0)
                                gRingManagerWork->flags &= ~(RINGMANAGER_FLAG_PENALTY_ACTIVE_P1 << p);
                        }
                    }

                    if (collected)
                    {
                        ring->timer = 0;
                        RemoveRingFromSpillList(ring);
                        AddRingToTwinkleList(ring);
                    }
                }

                // handle flashing
                if (ring->timer > 32 || (ring->timer & 2) != 0)
                    gRingManagerWork->drawRing(ring);
            }
        }
    }

    // -------------
    // RING PENALTY
    // -------------

    if (gmCheckRingBattle())
    {
        for (p = 0; p < gRingManagerWork->gPlayerCount; p++)
        {
            gRingManagerWork->ringPenaltyCount[p] = 0;
        }
    }
    else
    {
        if (gRingManagerWork->spillListStart == NULL)
        {
            for (p = 0; p < gRingManagerWork->gPlayerCount; p++)
            {
                // clear ring penalty flag if player collected every spilled ring
                if ((gRingManagerWork->flags & (RINGMANAGER_FLAG_PENALTY_ACTIVE_P1 << p)) != 0)
                {
                    gRingManagerWork->ringPenaltyCount[p] = 0;
                    gRingManagerWork->flags &= ~(RINGMANAGER_FLAG_PENALTY_ACTIVE_P1 << p);
                }
            }
        }
    }
}

void RingManager_StageCollide_Flat(Ring *ring)
{
    OBS_COL_CHK_DATA cData;

    s32 collideDistY = 0;

    if ((ring->flag & RING_FLAG_USE_PLANE_B) != 0)
        cData.flag = OBJ_COL_FLAG_USE_PLANE_B;
    else
        cData.flag = OBJ_COL_FLAG_NONE;

    cData.dir  = NULL;
    cData.attr = NULL;
    cData.x    = FX32_TO_WHOLE(ring->position.x);
    cData.y    = FX32_TO_WHOLE(ring->position.y);

    if (ring->velocity.y > FLOAT_TO_FX32(0.0))
    {
        cData.vec    = OBD_COL_DOWN;
        collideDistY = ObjDiffCollisionFast(&cData);
        if (collideDistY < 0)
        {
            if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
                ring->position.y -= FX32_FROM_WHOLE(collideDistY);
            else
                ring->position.y += FX32_FROM_WHOLE(collideDistY);
        }
    }
    else if (ring->velocity.y < FLOAT_TO_FX32(0.0))
    {
        cData.vec    = OBD_COL_UP;
        collideDistY = ObjDiffCollisionFast(&cData);
        if (collideDistY < 0)
        {
            if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
                ring->position.y += FX32_FROM_WHOLE(collideDistY);
            else
                ring->position.y -= FX32_FROM_WHOLE(collideDistY);
        }
    }

    if (collideDistY < 0)
    {
        ring->velocity.y -= (ring->velocity.y >> 2);
        ring->velocity.y = -ring->velocity.y;
    }

    s32 collideDistX = 0;
    cData.y          = FX32_TO_WHOLE(ring->position.y);
    if (ring->velocity.x > 0)
    {
        cData.vec    = OBD_COL_RIGHT;
        collideDistX = ObjDiffCollisionFast(&cData);
        if (collideDistX < 0)
            ring->position.x += FX32_FROM_WHOLE(collideDistX);
    }
    else if (ring->velocity.x < 0)
    {
        cData.vec    = OBD_COL_LEFT;
        collideDistX = ObjDiffCollisionFast(&cData);
        if (collideDistX < 0)
            ring->position.x -= FX32_FROM_WHOLE(collideDistX);
    }

    if (collideDistX < 0)
    {
        ring->velocity.x -= (ring->velocity.x >> 2);
        ring->velocity.x = -ring->velocity.x;
    }
}

void RingManager_StageCollide_Boss(Ring *ring)
{
    OBS_COL_CHK_DATA cData;

    s32 collideDistY = 0;

    if ((ring->flag & RING_FLAG_USE_PLANE_B) != 0)
        cData.flag = OBJ_COL_FLAG_USE_PLANE_B;
    else
        cData.flag = OBJ_COL_FLAG_NONE;

    cData.dir  = NULL;
    cData.attr = NULL;
    cData.x    = FX32_TO_WHOLE(ring->position.x);
    cData.y    = FX32_TO_WHOLE(ring->position.y);

    if (ring->velocity.y > FLOAT_TO_FX32(0.0))
    {
        cData.vec    = OBD_COL_DOWN;
        collideDistY = ObjCollisionFastUnion(&cData);
        if (collideDistY < 0)
        {
            if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
                ring->position.y -= FX32_FROM_WHOLE(collideDistY);
            else
                ring->position.y += FX32_FROM_WHOLE(collideDistY);
        }
    }
    else if (ring->velocity.y < FLOAT_TO_FX32(0.0))
    {
        cData.vec    = OBD_COL_UP;
        collideDistY = ObjCollisionFastUnion(&cData);
        if (collideDistY < 0)
        {
            if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
                ring->position.y += FX32_FROM_WHOLE(collideDistY);
            else
                ring->position.y -= FX32_FROM_WHOLE(collideDistY);
        }
    }

    if (collideDistY < 0)
    {
        ring->velocity.y -= (ring->velocity.y >> 2);

        if (gRingManagerWork->penaltyMultiplier != 0)
        {
            if ((ring->flag & RING_FLAG_IS_SPILLRING) != 0)
            {
                fx32 maxYVelocity = gRingManagerWork->penaltyMultiplier * gRingManagerWork->ringPenaltyCount[0];
                if (ring->velocity.y > maxYVelocity)
                    ring->velocity.y = maxYVelocity;
            }
        }

        ring->velocity.y = -ring->velocity.y;
    }

    s32 collideDistX = 0;
    cData.y          = FX32_TO_WHOLE(ring->position.y);
    if (ring->velocity.x > 0)
    {
        cData.vec    = OBD_COL_RIGHT;
        collideDistX = ObjCollisionFastUnion(&cData);
        if (collideDistX < 0)
            ring->position.x += FX32_FROM_WHOLE(collideDistX);
    }
    else if (ring->velocity.x < 0)
    {
        cData.vec    = OBD_COL_LEFT;
        collideDistX = ObjCollisionFastUnion(&cData);
        if (collideDistX < 0)
            ring->position.x -= FX32_FROM_WHOLE(collideDistX);
    }

    if (collideDistX < 0)
    {
        ring->velocity.x -= (ring->velocity.x >> 2);
        ring->velocity.x = -ring->velocity.x;
    }
}

void RingManager_DrawRing_ZoneAct(Ring *ring)
{
    StageDisplayFlags displayFlags = DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_DISABLE_UPDATE;
    if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
        displayFlags |= DISPLAY_FLAG_FLIP_Y;

    if (ring->scale.x <= FLOAT_TO_FX32(1.0))
        gRingManagerWork->aniRing.work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
    else
        gRingManagerWork->aniRing.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

    StageTask__Draw2DEx(&gRingManagerWork->aniRing, &ring->position, 0, &ring->scale, &displayFlags, NULL, NULL);
}

void RingManager_DrawRing_BossFlat(Ring *ring)
{
    RingManager *work = gRingManagerWork;

    work->aniRing3D.work.translation.x = ring->position.x;
    work->aniRing3D.work.translation.y = -ring->position.y;
    work->aniRing3D.work.translation.z = ring->position.z;
    AnimatorSprite3D__Draw(&work->aniRing3D);
}

void RingManager_DrawRing_BossCircular(Ring *ring)
{
    RingManager *work = gRingManagerWork;

    work->aniRing3D.work.translation.y = -ring->position.y;

    BossStage_GetCirclePos(ring->position.x, mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight, mapCamera.camControl.bossArenaRadius,
                           &work->aniRing3D.work.translation.x, &work->aniRing3D.work.translation.z);

    AnimatorSprite3D__Draw(&work->aniRing3D);
}

void RingManager_DrawSparkle_ZoneAct(Ring *ring)
{
    StageDisplayFlags displayFlags = DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_DISABLE_UPDATE;
    if ((ring->flag & RING_FLAG_REVERSE_GRAVITY) != 0)
        displayFlags |= DISPLAY_FLAG_FLIP_Y;

    if (ring->scale.x <= FLOAT_TO_FX32(1.0))
        gRingManagerWork->aniRingSparkle.work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
    else
        gRingManagerWork->aniRingSparkle.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

    StageTask__Draw2DEx(&gRingManagerWork->aniRingSparkle, &ring->position, 0, &ring->scale, &displayFlags, NULL, NULL);
}

void RingManager_DrawSparkle_BossFlat(Ring *ring)
{
    RingManager *work = gRingManagerWork;

    work->aniRingSparkle3D.work.translation.x = ring->position.x;
    work->aniRingSparkle3D.work.translation.y = -ring->position.y;
    work->aniRingSparkle3D.work.translation.z = ring->position.z;
    AnimatorSprite3D__Draw(&work->aniRingSparkle3D);
}

void RingManager_DrawSparkle_BossCircular(Ring *ring)
{
    RingManager *work = gRingManagerWork;

    work->aniRingSparkle3D.work.translation.y = -ring->position.y;

    BossStage_GetCirclePos(ring->position.x, mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight, mapCamera.camControl.bossArenaRadius,
                           &work->aniRingSparkle3D.work.translation.x, &work->aniRingSparkle3D.work.translation.z);

    AnimatorSprite3D__Draw(&work->aniRingSparkle3D);
}

BOOL RingManager_RectCollide_Flat(OBS_RECT *rect1, OBS_RECT *rect2)
{
    return ObjRect__RectCheck(rect1, rect2);
}

BOOL RingManager_RectCollide_Circular(OBS_RECT *rect1, OBS_RECT *rect2)
{
    BOOL result = ObjRect__RectCheck(rect1, rect2);
    if (result)
        return result;

    fx32 storeX  = rect2->pos.x;
    rect2->pos.x = FX32_TO_WHOLE(BossHelpers__Arena__WrapBounds(FX32_FROM_WHOLE(storeX), mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight));
    result       = ObjRect__RectCheck(rect1, rect2);
    rect2->pos.x = storeX;

    return result;
}