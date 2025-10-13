#include <stage/objects/itembox.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <stage/effects/explosion.h>
#include <stage/core/ringBattleManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_Type mapObject->left

// --------------------
// FUNCTION DECLS
// --------------------

// ItemBox
static void ItemBox_Destructor(Task *task);
static void ItemBox_State_Floating(ItemBox *work);
static void ItemBox_State_RandomVS(ItemBox *work);
static void ItemBox_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void ItemBox_Draw(void);

// ItemBoxReward
static void ItemBoxReward_Destructor(Task *task);
static void ItemBoxReward_State_Active(ItemBoxReward *work);

// --------------------
// ENUMS
// --------------------

#define ITEMBOX_ANI_TYPE_START 1

enum ItemBoxObjectFlags
{
    ITEMBOX_OBJFLAG_NONE,

    ITEMBOX_OBJFLAG_NOT_IN_VS_MODE = 1 << 0,
};

enum ItemBoxType
{
    ITEMBOX_TYPE_RINGS_RANDOM,
    ITEMBOX_TYPE_RINGS_5,
    ITEMBOX_TYPE_EXTRA_LIFE,
    ITEMBOX_TYPE_MAX_TENSION,
    ITEMBOX_TYPE_TENSION_UP,
    ITEMBOX_TYPE_INVINCIBILITY,
    ITEMBOX_TYPE_REGULAR_SHIELD,
    ITEMBOX_TYPE_MAGNET_SHIELD,
    ITEMBOX_TYPE_HYPER_TRICK,
    ITEMBOX_TYPE_SLOWDOWN,
    ITEMBOX_TYPE_CONFUSION,
    ITEMBOX_TYPE_TENSION_SWAP,
    ITEMBOX_TYPE_GRAB,

    ITEMBOX_TYPE_COUNT,
};

enum ItemBoxAnimID
{
    // Box anim ids
    ITEMBOX_ANI_BOX,

    // Powerup anim ids
    ITEMBOX_ANI_RINGS_RANDOM   = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_RINGS_RANDOM,
    ITEMBOX_ANI_RINGS_5        = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_RINGS_5,
    ITEMBOX_ANI_EXTRA_LIFE     = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_EXTRA_LIFE,
    ITEMBOX_ANI_MAX_TENSION    = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_MAX_TENSION,
    ITEMBOX_ANI_TENSION_UP     = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_TENSION_UP,
    ITEMBOX_ANI_INVINCIBILITY  = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_INVINCIBILITY,
    ITEMBOX_ANI_REGULAR_SHIELD = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_REGULAR_SHIELD,
    ITEMBOX_ANI_MAGNET_SHIELD  = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_MAGNET_SHIELD,
    ITEMBOX_ANI_HYPER_TRICK    = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_HYPER_TRICK,
    ITEMBOX_ANI_SLOWDOWN       = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_SLOWDOWN,
    ITEMBOX_ANI_CONFUSION      = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_CONFUSION,
    ITEMBOX_ANI_TENSION_SWAP   = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_TENSION_SWAP,
    ITEMBOX_ANI_GRAB           = ITEMBOX_ANI_TYPE_START + ITEMBOX_TYPE_GRAB,
};

// --------------------
// VARIABLES
// --------------------

static Task *itemBoxRewardTask;

static const u8 ringAmountTable[8]   = { 1, 5, 10, 30, 50, 10, 30, 5 };
static const u8 ringAmountTableVS[8] = { 1, 5, 10, 30, 1, 10, 30, 5 };

static u8 vsRandomTable[8] = { ITEMBOX_TYPE_RINGS_RANDOM, ITEMBOX_TYPE_SLOWDOWN,     ITEMBOX_TYPE_RINGS_RANDOM, ITEMBOX_TYPE_CONFUSION,
                               ITEMBOX_TYPE_RINGS_RANDOM, ITEMBOX_TYPE_TENSION_SWAP, ITEMBOX_TYPE_RINGS_RANDOM, ITEMBOX_TYPE_GRAB };

static const u8 rewardDrawFlagTable[16] = { 116, 116, 2, 2, 2, 2, 31, 31, 2, 31, 2, 2, 2, 0, 0, 0 };

// --------------------
// FUNCTIONS
// --------------------

ItemBox *CreateItemBox(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    ItemBox *work;

    s16 boxType = (mapObject->id - MAPOBJECT_48);

    u16 gfxSize[2] = { 8, 8 };
    u16 animIDs[2] = { ITEMBOX_ANI_BOX, ITEMBOX_ANI_BOX };

    if (gameState.gameMode == GAMEMODE_MISSION)
    {
        if ((gameState.missionType == MISSION_TYPE_COLLECT_RINGS || gameState.missionType == MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING)
            && ((u8)mapObjectParam_Type == ITEMBOX_TYPE_RINGS_RANDOM || (u8)mapObjectParam_Type == ITEMBOX_TYPE_RINGS_5))
        {
            DestroyMapObject(mapObject);
            return NULL;
        }

        // remove lives in mission mode!
        if (mapObjectParam_Type == ITEMBOX_TYPE_EXTRA_LIFE)
        {
            DestroyMapObject(mapObject);
            return NULL;
        }
    }
    else if (gameState.gameMode == GAMEMODE_VS_BATTLE && (mapObject->flags & ITEMBOX_OBJFLAG_NOT_IN_VS_MODE) != 0)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    task = CreateStageTask(ItemBox_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), ItemBox);
    if (task == HeapNull)
        return NULL;

    if ((u32)mapObjectParam_Type >= ITEMBOX_TYPE_COUNT)
        mapObjectParam_Type = ITEMBOX_TYPE_RINGS_RANDOM;

    // extra lives become max tension in time attack!
    if (gameState.gameMode == GAMEMODE_TIMEATTACK && mapObjectParam_Type == ITEMBOX_TYPE_EXTRA_LIFE)
        mapObjectParam_Type = ITEMBOX_TYPE_MAX_TENSION;

    work = TaskGetWork(task, ItemBox);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/ac_itm_box.bac", GetObjectDataWork(OBJDATAWORK_70), gameArchiveCommon, gfxSize[boxType]);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, animIDs[boxType], 115);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_24);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, animIDs[boxType]);
    if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y))
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
        work->gameWork.objWork.fallDir = FLOAT_DEG_TO_IDX(180.0);
    }

    AnimatorSpriteDS *ani = &work->aniContents;
    ObjAction2dBACLoad(ani, "/ac_itm_box.bac", 2, GetObjectDataWork(OBJDATAWORK_70), gameArchiveCommon);
    ani->work.cParam.palette =
        ObjDrawAllocSpritePalette(GetObjectDataWork(OBJDATAWORK_70)->fileData, ITEMBOX_ANI_TYPE_START + mapObjectParam_Type, rewardDrawFlagTable[mapObjectParam_Type]);
    ani->cParam[0].palette = ani->cParam[1].palette = ani->work.cParam.palette;
    ani->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    StageTask__SetOAMOrder(&ani->work, SPRITE_ORDER_24);
    StageTask__SetOAMPriority(&ani->work, SPRITE_PRIORITY_2);
    AnimatorSpriteDS__SetAnimation(&work->aniContents, ITEMBOX_ANI_TYPE_START + mapObjectParam_Type);
    SetTaskOutFunc(&work->gameWork.objWork, ItemBox_Draw);
    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], ItemBox_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    if (gmCheckVsBattleFlag())
    {
        SetTaskState(&work->gameWork.objWork, ItemBox_State_RandomVS);
    }
    else if (mapObject->id == MAPOBJECT_49)
    {
        SetTaskState(&work->gameWork.objWork, ItemBox_State_Floating);
    }

    if (gmCheckRingBattle())
    {
        AddItemBoxToRingBattleManager(work);
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    }

    return work;
}

void BreakItemBox(ItemBox *work, Player *player, s32 type)
{
    s16 ringTableIndex;
    s16 ringAmount;

    switch (type)
    {
        case ITEMBOX_TYPE_RINGS_RANDOM:
            ringTableIndex = mtMathRandRepeat(8);

            if (gmCheckRingBattle())
                ringAmount = ringAmountTableVS[ringTableIndex];
            else
                ringAmount = ringAmountTable[ringTableIndex];

            Player__GiveRings(player, ringAmount);
            break;

        case ITEMBOX_TYPE_RINGS_5:
            Player__GiveRings(player, 5);
            break;

        case ITEMBOX_TYPE_EXTRA_LIFE:
            Player__GiveLife(player, 1);
            break;

        case ITEMBOX_TYPE_MAX_TENSION:
            Player__GiveTension(player, PLAYER_TENSION_MAX);
            break;

        case ITEMBOX_TYPE_TENSION_UP:
            Player__GiveTension(player, 1 * PLAYER_TENSION_PER_LEVEL);
            break;

        case ITEMBOX_TYPE_INVINCIBILITY:
            Player__GiveInvincibility(player);
            break;

        case ITEMBOX_TYPE_REGULAR_SHIELD:
            Player__GiveRegularShield(player);
            break;

        case ITEMBOX_TYPE_MAGNET_SHIELD:
            Player__GiveMagnetShield(player);
            break;

        case ITEMBOX_TYPE_HYPER_TRICK:
            Player__GiveHyperTrickEffect(player);
            break;

        case ITEMBOX_TYPE_SLOWDOWN:
            GameObject__SendPacket(&work->gameWork, player, GAMEOBJECT_PACKET_SLOWDOWN);
            Player__GiveSlowdownEffect(gPlayerList[1]);
            break;

        case ITEMBOX_TYPE_CONFUSION:
            GameObject__SendPacket(&work->gameWork, player, GAMEOBJECT_PACKET_CONFUSION);
            Player__GiveConfusionEffect(gPlayerList[1]);
            break;

        case ITEMBOX_TYPE_TENSION_SWAP:
            Player__GiveTension(player, PLAYER_TENSION_MAX);
            Player__DepleteTension(gPlayerList[1]);
            GameObject__SendPacket(&work->gameWork, player, GAMEOBJECT_PACKET_TENSION_SWAP);
            break;

        case ITEMBOX_TYPE_GRAB:
            GameObject__SendPacket(&work->gameWork, player, GAMEOBJECT_PACKET_GRAB);
            break;
    }

    if (gmCheckRingBattle())
    {
        if (work->gameWork.mapObjectParam_Type < ITEMBOX_TYPE_SLOWDOWN || work->gameWork.mapObjectParam_Type > ITEMBOX_TYPE_GRAB)
            GameObject__SendPacket(&work->gameWork, player, GAMEOBJECT_PACKET_OBJ_COLLISION);
    }
}

void CreateItemBoxReward(s32 type)
{
    ItemBoxReward *work;
    void *nullValue;
    OBS_ACTION2D_BAC_WORK *aniWork;
    u8 value;
    s32 id;

    if (itemBoxRewardTask != NULL)
    {
        work = TaskGetWork(itemBoxRewardTask, ItemBoxReward);

        work->objWork.flag &= ~STAGE_TASK_FLAG_DESTROYED;

        id      = ITEMBOX_ANI_TYPE_START + type;
        aniWork = work->objWork.obj_2d;
        if (aniWork->ani.work.animID != id)
        {
            value = rewardDrawFlagTable[type];
            if (rewardDrawFlagTable[aniWork->ani.work.animID - 1] != value)
            {
                ObjDrawReleaseSpritePalette(aniWork->ani.work.cParam.palette);
                aniWork->ani.work.cParam.palette      = ObjDrawAllocSpritePalette(GetObjectDataWork(OBJDATAWORK_70)->fileData, id, value);
                aniWork->ani.cParam[0].palette = aniWork->ani.cParam[1].palette = aniWork->ani.work.cParam.palette;
                aniWork->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
            }
        }

        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    }
    else
    {
        itemBoxRewardTask = CreateStageTask(ItemBoxReward_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), ItemBoxReward);

        nullValue = HeapNull;
        if (itemBoxRewardTask == nullValue)
            return;

        work = TaskGetWork(itemBoxRewardTask, ItemBoxReward);
        TaskInitWork8(work);

        work->objWork.flag |= STAGE_TASK_FLAG_NO_VRAM_B | STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_SCALE | DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_SCREEN_RELATIVE;

        ObjObjectAction2dBACLoad(&work->objWork, &work->aniReward, "/ac_itm_box.bac", GetObjectFileWork(OBJDATAWORK_70), gameArchiveCommon, 2);

        id = ITEMBOX_ANI_TYPE_START + type;
        ObjActionAllocSpritePalette(&work->objWork, id, rewardDrawFlagTable[type]);
        StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_6);
        StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    }

    StageTask__SetAnimation(&work->objWork, id);

    work->objWork.userTimer  = 128;
    work->objWork.position.x = FLOAT_TO_FX32(128.0);
    work->objWork.position.y = FLOAT_TO_FX32(167.0);
    work->objWork.velocity.y = FLOAT_TO_FX32(2.0);

    SetTaskState(&work->objWork, ItemBoxReward_State_Active);
}

void ItemBox_Destructor(Task *task)
{
    ItemBox *work = TaskGetWork(task, ItemBox);

    ObjDrawReleaseSpritePalette(work->aniContents.work.cParam.palette);
    ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_70), &work->aniContents);
    GameObject__Destructor(task);
}

void ItemBox_State_Floating(ItemBox *work)
{
    work->gameWork.objWork.userWork += FLOAT_DEG_TO_IDX(1.40625);
    work->gameWork.objWork.offset.y = (65 * SinFX((s32)(u16)work->gameWork.objWork.userWork)) >> 4;
}

void ItemBox_State_RandomVS(ItemBox *work)
{
    MapObject *mapObject = work->gameWork.mapObject;

    work->gameWork.objWork.userTimer++;
    u32 id = (work->gameWork.objWork.userTimer >> 5) & 7;

    if (gmCheckRaceStage() && id > 5)
    {
        id                               = 0;
        work->gameWork.objWork.userTimer = 0;
    }

    AnimatorSpriteDS *ani = &work->aniContents;
    s8 type               = vsRandomTable[id];
    mapObjectParam_Type   = type;

    if (ani->work.animID != ITEMBOX_ANI_TYPE_START + type)
    {
        if (rewardDrawFlagTable[ani->work.animID - 1] != rewardDrawFlagTable[type])
        {
            ObjDrawReleaseSpritePalette(ani->work.cParam.palette);

            ani->work.cParam.palette =
                ObjDrawAllocSpritePalette(GetObjectDataWork(OBJDATAWORK_70)->fileData, ITEMBOX_ANI_TYPE_START + mapObjectParam_Type, rewardDrawFlagTable[mapObjectParam_Type]);
            ani->cParam[0].palette = ani->cParam[1].palette = ani->work.cParam.palette;
            ani->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
        }
        AnimatorSpriteDS__SetAnimation(ani, (u16)(ITEMBOX_ANI_TYPE_START + mapObjectParam_Type));
    }

    if (mapObject->id == MAPOBJECT_49)
        ItemBox_State_Floating(work);
}

void ItemBox_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    ItemBox *itemBox = (ItemBox *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (itemBox == NULL || player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (gmCheckRingBattle())
    {
        if ((itemBox->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) != 0)
            return;

        if (CheckIsPlayer1(player) == FALSE)
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_BREAK);
            CreateEffectExplosion(&itemBox->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_SMALL);
            itemBox->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            itemBox->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

            return;
        }
    }

    if (player->itemBoxDisableTimer != 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_BREAK);
        CreateEffectExplosion(&itemBox->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_SMALL);

        if (gmCheckRingBattle())
        {
            itemBox->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            itemBox->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        }
        else
        {
            QueueDestroyStageTask(&itemBox->gameWork.objWork);
            itemBox->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            itemBox->gameWork.flags |= 0x10000;
        }

        if (player->gimmickObj == NULL)
            Player__Action_DestroyAttackRecoil(player);

        BreakItemBox(itemBox, player, itemBox->gameWork.mapObjectParam_Type);
        CreateItemBoxReward(itemBox->gameWork.mapObjectParam_Type);
    }
}

void ItemBox_Draw(void)
{
    VecU16 dir;
    VecFx32 position;

    ItemBox *work = TaskGetWorkCurrent(ItemBox);

    // Draw Box
    u32 displayFlag = work->gameWork.objWork.displayFlag & ~DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    // Draw Contents
    position = work->gameWork.objWork.position;
    dir      = work->gameWork.objWork.dir;

    position.x += work->gameWork.objWork.offset.x;
    position.y += work->gameWork.objWork.offset.y;

    if (work->gameWork.objWork.fallDir != 0)
        dir.z += work->gameWork.objWork.fallDir;

    StageTask__Draw2DEx(&work->aniContents, &position, &dir, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
}

void ItemBoxReward_Destructor(Task *task)
{
    itemBoxRewardTask = NULL;
    StageTask_Destructor(task);
}

void ItemBoxReward_State_Active(ItemBoxReward *work)
{
    work->objWork.velocity.y = ObjSpdDownSet(work->objWork.velocity.y, FLOAT_TO_FX32(0.125));

    work->objWork.userTimer--;
    if (work->objWork.userTimer < 32)
    {
        if ((work->objWork.userTimer & DISPLAY_FLAG_FLIP_Y) != 0)
            work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
        else
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    }

    if (work->objWork.userTimer <= 0)
        DestroyStageTask(&work->objWork);
}
