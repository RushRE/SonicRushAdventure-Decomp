#include <stage/objects/dashRing.h>
#include <game/object/objectManager.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/vramSystem.h>
#include <game/stage/gameSystem.h>

// --------------------
// ENUMS
// --------------------

enum DashRingObjectFlags
{
    DASHRING_OBJFLAG_NONE,

    DASHRING_OBJFLAG_FLIPPED = 1 << 0,
};

enum DashRingAnimID
{
    DASHRING_ANI_HORIZONTAL_FRONT,
    DASHRING_ANI_HORIZONTAL_BACK,
    DASHRING_ANI_VERTICAL_FRONT,
    DASHRING_ANI_VERTICAL_BACK,
    DASHRING_ANI_DIAGONAL_FRONT,
    DASHRING_ANI_DIAGONAL_BACK,
};

// --------------------
// VARIABLES
// --------------------

// clang-format off
const Vec2Fx32 velocityTable[] = {
    {  FLOAT_TO_FX32(8.0),      FLOAT_TO_FX32(0.0) },		// DASHRING_VEL_RIGHT
    {  FLOAT_TO_FX32(5.65625),  FLOAT_TO_FX32(5.65625) },	// DASHRING_VEL_DOWN_RIGHT
    {  FLOAT_TO_FX32(0.0),      FLOAT_TO_FX32(8.0) },		// DASHRING_VEL_DOWN
    { -FLOAT_TO_FX32(5.65625),  FLOAT_TO_FX32(5.65625) },	// DASHRING_VEL_DOWN_LEFT
    { -FLOAT_TO_FX32(8.0),      FLOAT_TO_FX32(0.0) },		// DASHRING_VEL_LEFT
    { -FLOAT_TO_FX32(5.65625), -FLOAT_TO_FX32(5.65625) },	// DASHRING_VEL_UP_LEFT
    {  FLOAT_TO_FX32(0.0),     -FLOAT_TO_FX32(8.0) },		// DASHRING_VEL_UP
    {  FLOAT_TO_FX32(5.65625), -FLOAT_TO_FX32(5.65625) },	// DASHRING_VEL_UP_RIGHT
};
// clang-format on

// --------------------
// FUNCTION DECLS
// --------------------

void DashRing_Destructor(Task *task);
void SetupDashRingObject(DashRing *work);
void DashRing_State_Active(DashRing *work);
void DashRing_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

DashRing *CreateDashRing(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(DashRing_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), DashRing);
    if (task == HeapNull)
        return NULL;

    DashRing *work = TaskGetWork(task, DashRing);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dash_c.bac", GetObjectFileWork(OBJDATAWORK_35), gameArchiveStage, 0);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, DASHRING_ANI_HORIZONTAL_FRONT, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);

    s32 spriteID;
    s32 gfxSize;
    s32 spriteRefID;
    switch (mapObject->id)
    {
        default:
        case MAPOBJECT_106:
            spriteID    = OBJDATAWORK_40;
            gfxSize     = 16;
            spriteRefID = OBJDATAWORK_42;
            break;

        case MAPOBJECT_107:
            spriteID    = OBJDATAWORK_36;
            gfxSize     = 16;
            spriteRefID = OBJDATAWORK_38;
            break;

        case MAPOBJECT_108:
        case MAPOBJECT_109:
            spriteID    = OBJDATAWORK_44;
            gfxSize     = 32;
            spriteRefID = OBJDATAWORK_46;
            break;
    }

    ObjObjectActionAllocSprite(&work->gameWork.objWork, gfxSize, GetObjectFileWork(spriteID));

    OBS_ACTION2D_BAC_WORK *animator = &work->aniRing;
    animator->spriteRef             = GetObjectFileWork(spriteRefID);

    AnimatorSpriteDS__Init(&animator->ani, work->gameWork.objWork.obj_2d->fileWork->fileData, DASHRING_ANI_HORIZONTAL_FRONT, 0,
                           ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE,
                           ObjActionAllocSprite(&animator->spriteRef->engineRef[0], FALSE, gfxSize), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE,
                           ObjActionAllocSprite(&animator->spriteRef->engineRef[1], TRUE, gfxSize), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_ORDER_2, SPRITE_ORDER_23);

    animator->ani.cParam[1].palette = animator->ani.cParam[0].palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    animator->ani.work.cParam.palette                                        = animator->ani.cParam[0].palette;

    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], DashRing_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    ObjRect__SetGroupFlags(&work->gameWork.colliders[1], 0x00, 0x00);

    switch (mapObject->id)
    {
        case MAPOBJECT_106:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_VERTICAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_VERTICAL_BACK);
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                work->velocity = DASHRING_VEL_DOWN;
            }
            else
            {
                work->velocity = DASHRING_VEL_UP;
            }
            break;

        case MAPOBJECT_107:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_HORIZONTAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_HORIZONTAL_BACK);
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                work->velocity = DASHRING_VEL_LEFT;
            }
            else
            {
                work->velocity = DASHRING_VEL_RIGHT;
            }
            break;

        case MAPOBJECT_108:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_DIAGONAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_DIAGONAL_BACK);
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                work->velocity = DASHRING_VEL_DOWN_LEFT;
            }
            else
            {
                work->velocity = DASHRING_VEL_UP_LEFT;
            }
            break;

        case MAPOBJECT_109:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_DIAGONAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_DIAGONAL_BACK);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                work->velocity = DASHRING_VEL_DOWN_RIGHT;
            }
            else
            {
                work->velocity = DASHRING_VEL_UP_RIGHT;
            }
            break;

        default:
            break;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    SetupDashRingObject(work);
    return work;
}

DashRing *CreateDashRingRainbow(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(DashRing_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), DashRing);
    if (task == HeapNull)
        return NULL;

    DashRing *work = TaskGetWork(task, DashRing);
    TaskInitWork8(work);

    work->flags |= DASHRING_FLAG_RAINBOW;
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    u16 gfxSize;
    switch (mapObject->id)
    {
        default:
        case MAPOBJECT_99:
            gfxSize = 16;
            break;

        case MAPOBJECT_100:
            gfxSize = 16;
            break;

        case MAPOBJECT_101:
        case MAPOBJECT_102:
            gfxSize = 32;
            break;
    }

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dash_ct.bac", GetObjectFileWork(OBJDATAWORK_48), gameArchiveStage, gfxSize);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, DASHRING_ANI_HORIZONTAL_FRONT, 8);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);

    OBS_ACTION2D_BAC_WORK *animator = &work->aniRing;

    AnimatorSpriteDS__Init(&animator->ani, work->gameWork.objWork.obj_2d->fileWork->fileData, DASHRING_ANI_HORIZONTAL_FRONT, 0,
                           ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, gfxSize),
                           PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(TRUE, gfxSize), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, 2, 23);

    animator->ani.cParam[1].palette = animator->ani.cParam[0].palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    animator->ani.work.cParam.palette                                        = animator->ani.cParam[0].palette;

    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], DashRing_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    ObjRect__SetGroupFlags(&work->gameWork.colliders[1], 0x00, 0x00);

    switch (mapObject->id)
    {
        case MAPOBJECT_99:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_VERTICAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_VERTICAL_BACK);
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                work->velocity = DASHRING_VEL_DOWN;
            }
            else
            {
                work->velocity = DASHRING_VEL_UP;
            }
            break;

        case MAPOBJECT_100:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_HORIZONTAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_HORIZONTAL_BACK);
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                work->velocity = DASHRING_VEL_LEFT;
            }
            else
            {
                work->velocity = DASHRING_VEL_RIGHT;
            }
            break;

        case MAPOBJECT_101:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_DIAGONAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_DIAGONAL_BACK);
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                work->velocity = DASHRING_VEL_DOWN_LEFT;
            }
            else
            {
                work->velocity = DASHRING_VEL_UP_LEFT;
            }
            break;

        case MAPOBJECT_102:
            StageTask__SetAnimation(&work->gameWork.objWork, DASHRING_ANI_DIAGONAL_FRONT);
            AnimatorSpriteDS__SetAnimation(&work->aniRing.ani, DASHRING_ANI_DIAGONAL_BACK);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            if ((mapObject->flags & DASHRING_OBJFLAG_FLIPPED) != 0)
            {
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                work->velocity = DASHRING_VEL_DOWN_RIGHT;
            }
            else
            {
                work->velocity = DASHRING_VEL_UP_RIGHT;
            }
            break;

        default:
            break;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetupDashRingObject(work);
    return work;
}

void DashRing_Destructor(Task *task)
{
    DashRing *work = TaskGetWork(task, DashRing);

    if ((work->flags & DASHRING_FLAG_RAINBOW) == 0)
    {
        ObjActionReleaseSprite(&work->aniRing.spriteRef->engineRef[0], FALSE);
        ObjActionReleaseSprite(&work->aniRing.spriteRef->engineRef[1], TRUE);
    }
    else
    {
        if (work->aniRing.ani.vramPixels[0] != NULL)
            VRAMSystem__FreeSpriteVram(FALSE, work->aniRing.ani.vramPixels[0]);

        if (work->aniRing.ani.vramPixels[1] != NULL)
            VRAMSystem__FreeSpriteVram(TRUE, work->aniRing.ani.vramPixels[1]);
    }

    GameObject__Destructor(task);
}

void SetupDashRingObject(DashRing *work)
{
    SetTaskState(&work->gameWork.objWork, DashRing_State_Active);
}

void DashRing_State_Active(DashRing *work)
{
    StageTask__Draw2D(&work->gameWork.objWork, &work->aniRing.ani);
    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;
}

void DashRing_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player     = (Player *)rect1->parent;
    DashRing *dashRing = (DashRing *)rect2->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && player != NULL)
    {
        Player__Action_DashRing(player, dashRing->gameWork.objWork.position.x, dashRing->gameWork.objWork.position.y, velocityTable[dashRing->velocity].x,
                                velocityTable[dashRing->velocity].y);
        Player__Action_AllowTrickCombos(player, &dashRing->gameWork);

        if ((dashRing->flags & DASHRING_FLAG_RAINBOW) != 0)
        {
            Player__Action_RainbowDashRing(player);
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_DASH);
        }
        else
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DASH_CIRCLE);
        }
    }
}
