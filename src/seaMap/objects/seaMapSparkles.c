#include <seaMap/objects/seaMapSparkles.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

static const u16 sMinorSparkleAnims[] = { SEAMAP_CHCOM_ANI_140, SEAMAP_CHCOM_ANI_143, SEAMAP_CHCOM_ANI_144, SEAMAP_CHCOM_ANI_147 };
static const u16 sMajorSparkleAnims[] = { SEAMAP_CHCOM_ANI_141, SEAMAP_CHCOM_ANI_142, SEAMAP_CHCOM_ANI_145, SEAMAP_CHCOM_ANI_146 };

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapSparkles_Main(void);
static void SeaMapSparkles_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapSparkles(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    Task *task;
    SeaMapSparkles *work;

    SeaMapManager *manager = SeaMapManager__GetWork();

    task = TaskCreate(SeaMapSparkles_Main, SeaMapSparkles_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapSparkles);

    work = TaskGetWork(task, SeaMapSparkles);
    TaskInitWork16(work);
    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);

    work->useEngineB = manager->useEngineB;
    if (mapObject->type == SEAMAPOBJECT_SPARKLES_MAJOR_ISLAND)
    {
        work->initialVelocity = FLOAT_TO_FX32(3.5);
        work->initialLifeTime = 20;
        work->spriteCount     = 4;
        work->spawnDuration   = 15;
        work->emitterLifeTime = 75;
    }
    else
    {
        work->initialVelocity = FLOAT_TO_FX32(2.5);
        work->initialLifeTime = 15;
        work->spriteCount     = 4;
        work->spawnDuration   = 15;
        work->emitterLifeTime = 75;
    }

    const u16 *animIDs;
    if (SeaMapEventManager_GetObjectType(mapObject) == SEAMAPOBJECT_SPARKLES_MAJOR_ISLAND)
        animIDs = sMajorSparkleAnims;
    else
        animIDs = sMinorSparkleAnims;

    AnimatorSprite aniSprite;
    s32 i;
    for (i = 0; i < work->spriteCount; i++)
    {
        u16 animID = animIDs[i];

        work->vramPixels[i] = VRAMSystem__AllocSpriteVram(work->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, animID));

        AnimatorSprite__Init(&aniSprite, manager->assets.sprChCommon, animID, ANIMATOR_FLAG_NONE, work->useEngineB, PIXEL_MODE_SPRITE, work->vramPixels[i], PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_8);
        aniSprite.cParam.palette = PALETTE_ROW_5;
        AnimatorSprite__ProcessAnimationFast(&aniSprite);
    }

    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapSparkles_Main(void)
{
    SeaMapSparkles *work;
    s32 i;
    AnimatorSprite *aniSparkle;

    work = TaskGetWorkCurrent(SeaMapSparkles);

    u16 count = RenderCore_GetTargetVBlankCount() + 1;
    while (count--)
    {
        u32 timer = ++work->timer;
        if (timer >= work->emitterLifeTime)
        {
            DestroyCurrentTask();
            return;
        }

        if (timer < work->spawnDuration)
        {
            if (work->spawnTimer-- == 0)
            {
                for (i = 0; i < 2; i++)
                {
                    SeaMapManager *manager = SeaMapManager__GetWork();

                    s32 slot = 0;
                    for (; slot < SEAMAPSPARKLES_PARTICLE_COUNT; slot++)
                    {
                        if (work->timers[slot] == 0)
                            break;
                    }

                    work->animIDs[slot] = FX_ModS32(mtMathRand(), work->spriteCount);
                    u16 angle           = (s32)(u16)(mtMathRand() << 12);
                    fx32 radius         = FX32_FROM_WHOLE((mtMathRand() & 0xF) + 8);

                    work->positions[slot].x = MultiplyFX(CosFX((u16)(s32)angle), radius) + FX32_FROM_WHOLE(work->objWork.mapObject->position.x);
                    work->positions[slot].y = MultiplyFX(SinFX((u16)(s32)angle), radius) + FX32_FROM_WHOLE(work->objWork.mapObject->position.y);
                    work->velocity[slot]    = work->initialVelocity;
                    work->angles[slot]      = angle;
                    work->timers[slot]      = work->initialLifeTime;

                    fx32 speedMultiplier = FX_Div(FX32_FROM_WHOLE(work->timer), FX32_FROM_WHOLE(work->spawnDuration));
                    if (speedMultiplier > FLOAT_TO_FX32(1.0))
                        speedMultiplier = FLOAT_TO_FX32(1.0);
                    work->velocity[slot] -= MultiplyFX(speedMultiplier, FLOAT_TO_FX32(0.5));
                    work->timers[slot] += FX32_TO_WHOLE(10 * speedMultiplier);

                    aniSparkle = &work->animators[slot];

                    u16 anim;
                    if (SeaMapEventManager_GetObjectType(work->objWork.mapObject) == SEAMAPOBJECT_SPARKLES_MAJOR_ISLAND)
                    {
                        anim = sMajorSparkleAnims[work->animIDs[slot]];
                    }
                    else
                    {
                        anim = sMinorSparkleAnims[work->animIDs[slot]];
                    }
                    AnimatorSprite__Init(aniSparkle, manager->assets.sprChCommon, anim,
                                         ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_LOOPING, work->useEngineB, PIXEL_MODE_SPRITE,
                                         work->vramPixels[work->animIDs[slot]], PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[work->useEngineB]),
                                         SPRITE_PRIORITY_0, SPRITE_ORDER_8);
                    aniSparkle->cParam.palette = PALETTE_ROW_5;
                }
                work->spawnTimer = 0;
            }
        }
    }

    for (i = 0; i < SEAMAPSPARKLES_PARTICLE_COUNT; i++)
    {
        aniSparkle = &work->animators[i];
        if (work->timers[i] != 0)
        {
            work->timers[i]--;
            work->velocity[i] -= FLOAT_TO_FX32(0.15);
            if (work->velocity[i] < FLOAT_TO_FX32(0.1))
                work->velocity[i] = FLOAT_TO_FX32(0.1);

            work->positions[i].x += MultiplyFX(CosFX((u16)(s32)work->angles[i]), work->velocity[i]);
            work->positions[i].y += MultiplyFX(SinFX((u16)(s32)work->angles[i]), work->velocity[i]);
            SeaMapEventManager_ProcessAnimator(aniSparkle, NULL, NULL);
        }
    }

    for (i = 0; i < SEAMAPSPARKLES_PARTICLE_COUNT; i++)
    {
        aniSparkle = &work->animators[i];
        if (work->timers[i] != 0)
        {
            Vec2Fx16 drawPos;
            drawPos.x = FX32_TO_WHOLE(work->positions[i].x);
            drawPos.y = FX32_TO_WHOLE(work->positions[i].y);
            SeaMapEventManager_GetMapLocalPosition(&drawPos, &aniSparkle->pos);
            AnimatorSprite__DrawFrame(aniSparkle);
        }
    }
}

void SeaMapSparkles_Destructor(Task *task)
{
    SeaMapSparkles *work = TaskGetWork(task, SeaMapSparkles);

    for (s32 i = 0; i < work->spriteCount; i++)
    {
        VRAMSystem__FreeSpriteVram(work->useEngineB, work->vramPixels[i]);
    }

    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);
}