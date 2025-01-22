#include <stage/player/player.h>
#include <stage/gameObject.h>
#include <game/system/allocator.h>
#include <game/input/padInput.h>
#include <game/object/obj.h>
#include <game/object/objPacket.h>
#include <game/math/mtMath.h>
#include <game/system/system.h>
#include <game/game/gameState.h>
#include <game/audio/spatialAudio.h>
#include <game/object/objectManager.h>
#include <game/graphics/paletteQueue.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapSys.h>
#include <game/stage/eventManager.h>
#include <game/system/sysEvent.h>
#include <stage/core/bgmManager.h>
#include <stage/core/ringManager.h>
#include <stage/core/hud.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/screenShake.h>
#include <game/save/saveGame.h>
#include <game/util/akUtil.h>

// Related Objects
#include <stage/player/starCombo.h>
#include <stage/player/scoreBonus.h>
#include <stage/objects/playerSnowboard.h>

// Effects
#include <stage/effects/waterSplash.h>
#include <stage/effects/waterWake.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/brakeDust.h>
#include <stage/effects/spindashDust.h>
#include <stage/effects/flameDust.h>
#include <stage/effects/flameJet.h>
#include <stage/effects/hummingTop.h>
#include <stage/effects/boost.h>
#include <stage/effects/playerTrail.h>
#include <stage/effects/shield.h>
#include <stage/effects/grind.h>
#include <stage/effects/trickSparkle.h>
#include <stage/effects/invincible.h>
#include <stage/effects/snowSmoke.h>
#include <stage/effects/drownAlert.h>
#include <stage/effects/playerIcon.h>
#include <stage/effects/battleAttack.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void DecorationSys__Release(void);

// --------------------
// VARIABLES
// --------------------

u8 playerCount;
static Task *curJingle;
static fx32 startingPosY;
void *playerArchive;
static fx32 startingPosZ;
static fx32 startingPosX;

OBS_DATA_WORK animationWork;
OBS_DATA_WORK snowboardWork;
static OBS_DATA_WORK spriteWork;
OBS_DATA_WORK playerWork[CHARACTER_COUNT];

// clang-format off
static const char *playerModelPath[CHARACTER_COUNT] = 
{ 
    [CHARACTER_SONIC] = "son.nsbmd", 
    [CHARACTER_BLAZE] = "blz.nsbmd" 
};
// clang-format on

extern const struct PlayerPhysicsTable playerPhysicsTable[CHARACTER_COUNT];

extern const u8 *playerModelAnimForAction[CHARACTER_COUNT];
extern const u8 *playerModelIndexForAction[CHARACTER_COUNT];
extern const u8 *playerSpriteAnimForAction[CHARACTER_COUNT];
extern const u8 *playerTailAnimForAction[CHARACTER_COUNT];

// --------------------
// INLINE FUNCTIONS
// --------------------

// extra macro for specific cases where the inline function won't match!
#define PlayPlayerSfxEx(seqPlayer, sfx) PlaySfxEx(seqPlayer, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQARC_GAME_SE, sfx)

RUSH_INLINE fx32 GetPlayerAnimSpeed(Player *player)
{
    if (player->hyperTrickTimer != 0)
        return FLOAT_TO_FX32(2.5);
    else
        return FLOAT_TO_FX32(1.0);
}

RUSH_INLINE void ApplyPlayerTensionPenalty(Player *player)
{
    if (player->trickStateRef != NULL)
    {
        player->tensionPenalty = player->trickStateRef->param.tensionPenalty;

        if (player->trickStateRef->param.tensionPenalty < 0xFF)
            player->trickStateRef->param.tensionPenalty++;

        player->trickStateRef = NULL;
    }
}

RUSH_INLINE void ChangePlayerKeyMap(Player *work)
{
    const u16 keyMaps[4] = { PAD_KEY_UP, PAD_KEY_DOWN, PAD_KEY_LEFT, PAD_KEY_RIGHT };

    u16 rand = mtMathRand() & 3;

    work->keyMap.up    = keyMaps[++rand & 3];
    work->keyMap.down  = keyMaps[++rand & 3];
    work->keyMap.left  = keyMaps[++rand & 3];
    work->keyMap.right = keyMaps[++rand & 3];
}

RUSH_INLINE void FinishMission(Player *player)
{
    const enum SND_ZONE_SEQARC_GAME_SE voiceFinishMission[CHARACTER_COUNT] = { SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COOL, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TA };

    player->inputKeyDown = player->inputKeyPress = player->inputKeyRepeat = PAD_INPUT_NONE_MASK;
    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE;

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.25));
    PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], voiceFinishMission[player->characterID]);
    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GALLERY_MAX);
}

RUSH_INLINE void HandlePlayerTrickSuccess2(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_SUCCESS1);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_SUCCESS1_SNOWBOARD);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_TRICK_SUCCESS1);
    }

    Player__GiveTension(player, PLAYER_TENSION_TRICK >> player->tensionPenalty);

    const enum SND_ZONE_SEQARC_GAME_SE voiceTrickSuccess[CHARACTER_COUNT] = {
        [CHARACTER_SONIC] = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YEA, [CHARACTER_BLAZE] = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FUN
    };
    PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], voiceTrickSuccess[player->characterID]);

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_SUC2);
    NNS_SndPlayerSetVolume(&player->seqPlayers[PLAYER_SEQPLAYER_GRINDTRICKSUCCES], AUDIOMANAGER_VOLUME_MAX >> player->tensionPenalty);
}

RUSH_INLINE void HandlePlayerTrickSuccessBonus(Player *player)
{
    const s32 sfxPerformTrick[CHARACTER_COUNT] = { [CHARACTER_SONIC] = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ERIAL_SPIN, [CHARACTER_BLAZE] = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_ERIAL_SPIN };

    PlayPlayerSfxEx(NULL, sfxPerformTrick[player->characterID]);

    Player__GiveScore(player, PLAYER_SCOREBONUS_TRICK);
    StarCombo__PerformTrick(player);
}

RUSH_INLINE void HandlePlayerTrickFinish(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH_SNOWBOARD);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_TRICK_FINISH);
    }

    player->playerFlag |= PLAYER_FLAG_FINISHED_TRICK_COMBO;
    Player__GiveTension(player, PLAYER_TENSION_TRICKFINISH >> player->tensionPenalty);

    const enum SND_ZONE_SEQARC_GAME_SE voicePerformTrick[][CHARACTER_COUNT] = {
        [CHARACTER_SONIC] = { SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ALL_RIGHT, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COOL },
        [CHARACTER_BLAZE] = { SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YOSHI, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TA },
    };

    PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], voicePerformTrick[player->characterID][mtMathRand() & 1]);

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GALLERY_MAX);
    NNS_SndPlayerSetVolume(&player->seqPlayers[PLAYER_SEQPLAYER_GRINDTRICKSUCCES], AUDIOMANAGER_VOLUME_MAX >> player->tensionPenalty);

    Player__GiveScore(player, PLAYER_SCOREBONUS_TRICK_FINISH);
    StarCombo__FinishTrickCombo(player, TRUE);
}

RUSH_INLINE void HandlePlayerTrickSuccess1(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_SUCCESS2);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_SUCCESS2_SNOWBOARD);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_TRICK_SUCCESS2);
    }

    Player__GiveTension(player, PLAYER_TENSION_TRICK >> player->tensionPenalty);

    const enum SND_ZONE_SEQARC_GAME_SE voicePerformTrick[][CHARACTER_COUNT] = {
        [CHARACTER_SONIC] = { SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YAHOO, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OK },
        [CHARACTER_BLAZE] = { SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YA_BL, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HA },
    };

    PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], voicePerformTrick[player->characterID][mtMathRand() & 1]);

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_SUC1);
    NNS_SndPlayerSetVolume(&player->seqPlayers[PLAYER_SEQPLAYER_GRINDTRICKSUCCES], AUDIOMANAGER_VOLUME_MAX >> player->tensionPenalty);
}

// --------------------
// FUNCTIONS
// --------------------

void LoadPlayerAssets(void)
{
    ObjActionLoadArchiveFile(&playerWork[CHARACTER_SONIC], playerModelPath[CHARACTER_SONIC], playerArchive);
    ObjActionLoadArchiveFile(&playerWork[CHARACTER_BLAZE], playerModelPath[CHARACTER_BLAZE], playerArchive);

    ObjActionLoadModelTextures(&playerWork[CHARACTER_SONIC], NULL);
    ObjActionLoadModelTextures(&playerWork[CHARACTER_BLAZE], NULL);

    ObjActionLoadArchiveFile(&spriteWork, "ac_ply.bac", playerArchive);
    ObjActionLoadArchiveFile(&animationWork, "plycom.nsbca", playerArchive);

    HeapFree(HEAP_USER, playerArchive);
    playerArchive = NULL;
}

void ReleasePlayerAssets(void)
{
    ObjDataRelease(&playerWork[CHARACTER_SONIC]);
    ObjDataRelease(&playerWork[CHARACTER_BLAZE]);
    ObjDataRelease(&animationWork);
    ObjDataRelease(&spriteWork);

    if (playerArchive != NULL)
    {
        HeapFree(HEAP_USER, playerArchive);
        playerArchive = NULL;
    }
}

// Admin Tasks
Player *Player__Create(CharacterID characterID, u16 aidIndex)
{
    Task *task;
    Player *work;
    GameState *state;
    u32 idx;

    idx   = 0;
    state = GetGameState();

    task = CreateStageTask(Player__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1100, TASK_GROUP(1), Player);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, Player);
    TaskInitWork16(work);

    // static var config
    work->controlID = playerCount;
    work->cameraID  = playerCount;
    playerCount++;

    // character config
    work->aidIndex    = aidIndex;
    work->characterID = characterID;

    // key mappings
    work->keyMap.right = PAD_KEY_RIGHT;
    work->keyMap.left  = PAD_KEY_LEFT;
    work->keyMap.up    = PAD_KEY_UP;
    work->keyMap.down  = PAD_KEY_DOWN;
    work->keyMap.A     = PAD_BUTTON_A;
    work->keyMap.B     = PAD_BUTTON_B;

    // stage object config
    work->objWork.objType = STAGE_OBJ_TYPE_PLAYER;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    work->objWork.taskRef = task;
    work->objWork.scale.x = work->objWork.scale.y = work->objWork.scale.z = FLOAT_TO_FX32(1.0);
    SetTaskOutFunc(&work->objWork, Player__Draw);
    SetTaskInFunc(&work->objWork, Player__In_Default);
    SetTaskSpriteCallback(&work->objWork, Player__SpriteCallback_Default);
    SetTaskLastFunc(&work->objWork, Player__Last_Default);
    work->objWork.displayFlag |= DISPLAY_FLAG_800;

    ObjAction3dNNModelLoad(&work->objWork, &work->aniPlayerModel, playerModelPath[characterID], 1, &playerWork[characterID], NULL);

    u16 oldNodeCount = work->aniPlayerModel.ani.renderObj.resMdl->info.numNode;
    AnimatorMDL__SetResource(&work->objWork.obj_3d->ani, work->objWork.obj_3d->resources[B3D_RESOURCE_MODEL], 0, FALSE, FALSE);
    if (oldNodeCount > work->aniPlayerModel.ani.renderObj.resMdl->info.numNode)
        idx = 1;

    work->objWork.displayFlag |= DISPLAY_FLAG_APPLY_CAMERA_CONFIG;
    VEC_Set(&work->aniPlayerModel.ani.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));
    work->aniPlayerModel.ani.work.translation2.y = -FLOAT_TO_FX32(16.0);
    work->aniPlayerModel.ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    work->aniPlayerModel.ani.work.matrixOpIDs[1] = MATRIX_OP_IDENTITY;
    work->aniPlayerModel.ani.work.matrixOpIDs[2] = MATRIX_OP_LOAD_MTX43_TRANSLATE_SCALE_VEC;

    ObjAction3dNNMotionLoad(&work->objWork, &work->aniPlayerModel, "plycom.nsbca", &animationWork, NULL);
    work->aniPlayerModel.ani.renderObj.recJntAnm = work->aniPlayerModel.ani.jntAnimResult =
        NNS_G3dAllocRecBufferJnt(&heapSystemAllocator, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(work->aniPlayerModel.resources[B3D_RESOURCE_MODEL]), idx));
    work->aniPlayerModel.ani.renderObj.recMatAnm = work->aniPlayerModel.ani.matAnimResult =
        NNS_G3dAllocRecBufferMat(&heapSystemAllocator, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(work->aniPlayerModel.resources[B3D_RESOURCE_MODEL]), idx));

    switch (characterID)
    {
        // case CHARACTER_SONIC:
        default:
            break;

        case CHARACTER_BLAZE:
            AnimatorMDL__Init(&work->aniTailModel.ani, ANIMATOR_FLAG_NONE);

            NNSG3dResFileHeader *resource                    = ObjDataLoad(&playerWork[characterID], playerModelPath[characterID], NULL);
            work->aniTailModel.resources[B3D_RESOURCE_MODEL] = resource;
            work->aniTailModel.file[B3D_RESOURCE_MODEL]      = &playerWork[characterID];

            AnimatorMDL__SetResource(&work->aniTailModel.ani, resource, 2, FALSE, FALSE);
            work->aniTailModel.ani.work.scale.x = work->aniTailModel.ani.work.scale.y = work->aniTailModel.ani.work.scale.z = FLOAT_TO_FX32(3.3);
            work->aniTailModel.ani.work.translation2.y                                                                      = -FLOAT_TO_FX32(16.0);
            work->aniTailModel.ani.work.matrixOpIDs[0]                                                                      = MATRIX_OP_FLUSH_VP;
            work->aniTailModel.ani.work.matrixOpIDs[1]                                                                      = MATRIX_OP_IDENTITY;
            work->aniTailModel.ani.work.matrixOpIDs[2]                                                                      = MATRIX_OP_LOAD_MTX43_TRANSLATE_SCALE_VEC;

            work->aniTailModel.resources[B3D_RESOURCE_JOINT_ANIM] = ObjDataLoad(&animationWork, "plycom.nsbca", NULL);
            work->aniTailModel.file[B3D_RESOURCE_JOINT_ANIM]      = &animationWork;

            work->aniTailModel.ani.renderObj.recJntAnm = work->aniTailModel.ani.jntAnimResult =
                NNS_G3dAllocRecBufferJnt(&heapSystemAllocator, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(work->aniTailModel.resources[B3D_RESOURCE_MODEL]), idx));
            work->aniTailModel.ani.renderObj.recMatAnm = work->aniTailModel.ani.matAnimResult =
                NNS_G3dAllocRecBufferMat(&heapSystemAllocator, NNS_G3dGetMdlByIdx(NNS_G3dGetMdlSet(work->aniTailModel.resources[B3D_RESOURCE_MODEL]), idx));
            break;
    }

    if (IsSnowboardStage())
    {
        ObjDataLoad(&snowboardWork, "/mod/plybd.nsbca", gameArchiveStage);
        work->snowboardAnims = (NNSG3dResFileHeader *)snowboardWork.fileData;
    }

    ObjDraw__PaletteTex__Init(playerWork[characterID].fileData, &work->paletteTex);

    ObjObjectAction2dBACLoad(&work->objWork, &work->aniPlayerSprite, "/act/ac_ply.bac", &spriteWork, NULL, OBJ_DATA_GFX_NONE);
    work->aniPlayerSprite.ani.work.oamOrder = SPRITE_ORDER_13;
    work->aniPlayerSprite.ani.screensToDraw |= (SCREEN_DRAW_A | SCREEN_DRAW_3 | SCREEN_DRAW_4);

    work->onLandGround     = Player__OnLandGround;
    work->actionGroundMove = Player__OnGroundMove;
    work->actionCrouch     = Player__Action_Crouch;
    work->actionJump       = Player__Action_Jump;

    if (characterID == CHARACTER_BLAZE)
        work->actionRButtonAir = Player__Action_FlameHover;
    else
        work->actionRButtonAir = Player__Action_HomingAttack_Sonic;

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) == 0 || CheckIsPlayer1(work))
    {
        StageTask__InitCollider(&work->objWork, &work->colliders[0], 0, STAGE_TASK_COLLIDER_FLAGS_DYNAMIC_HITBOX);
        StageTask__InitCollider(&work->objWork, &work->colliders[1], 1, STAGE_TASK_COLLIDER_FLAGS_DYNAMIC_HITBOX);
    }
    else
    {
        StageTask__InitCollider(&work->objWork, &work->colliders[1], 1, STAGE_TASK_COLLIDER_FLAGS_DYNAMIC_HITBOX);
        StageTask__InitCollider(&work->objWork, &work->colliders[2], 2, STAGE_TASK_COLLIDER_FLAGS_DYNAMIC_HITBOX);
        work->playerFlag |= PLAYER_FLAG_DISABLE_PRESSURE_CHECK;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;
    }

    Player__InitState(work);
    ObjRect__SetOnDefend(&work->colliders[0], Player__OnDefend_Regular);

    if ((state->gameFlag & GAME_FLAG_40) != 0 && CheckIsPlayer1(work))
    {
        work->rings                 = state->recallRingExtraLife;
        work->ringStageCount        = state->recallRings;
        playerGameStatus.stageTimer = state->recallTime;

        switch (state->recallShield)
        {
            case PLAYER_RECALLSHIELD_REGULAR:
                work->playerFlag |= PLAYER_FLAG_SHIELD_REGULAR;
                CreateEffectRegularShieldForPlayer(work);
                break;

            case PLAYER_RECALLSHIELD_MAGNET:
                work->playerFlag |= PLAYER_FLAG_SHIELD_MAGNET;
                CreateEffectMagnetShieldForPlayer(work);
                break;

            default:
                break;
        }

        work->tension            = state->recallTension;
        work->objWork.position.x = state->recallPosition.x;
        work->objWork.position.y = state->recallPosition.y;
        work->gimmickFlag |= PLAYER_GIMMICK_200000;
        work->blinkTimer            = work->hurtInvulnDuration;
        work->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
    }
    else
    {
        if (playerGameStatus.spawnPosition.x == 0 && playerGameStatus.spawnPosition.y == 0)
        {
            playerGameStatus.spawnPosition.x = FLOAT_TO_FX32(40.0);
            playerGameStatus.spawnPosition.y = FLOAT_TO_FX32(120.0);
        }

        work->objWork.position.x = playerGameStatus.spawnPosition.x;
        work->objWork.position.y = playerGameStatus.spawnPosition.y;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

        if (!IsBossStage())
            work->tension = PLAYER_START_TENSION;

        if (Player__UseUpsideDownGravity(work->objWork.position.x, work->objWork.position.y))
            work->objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
    }

    if (CheckIsPlayer1(work))
    {
        startingPosX = FX32_TO_WHOLE(work->objWork.position.x);
        startingPosY = FX32_TO_WHOLE(work->objWork.position.y);
        startingPosZ = FX32_TO_WHOLE(work->objWork.position.z);
    }

    work->onLandGround(work);

    if (IsBossStage())
        work->objWork.displayFlag &= ~(DISPLAY_FLAG_800 | DISPLAY_FLAG_APPLY_CAMERA_CONFIG);

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
        work->rings = 1;

    if (gmCheckMissionType(MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING))
        work->rings = state->missionQuota;

    if (!CheckIsPlayer1(work))
        CreateEffectPlayerIcon(work);

    if (gmCheckStage(STAGE_TUTORIAL))
        work->playerFlag |= (PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_DISABLE_TENSION_DRAIN);

    return work;
}

void Player__Gimmick_200EE68(Player *work)
{
    GameState *state = GetGameState();

    work->playerFlag &= ~PLAYER_GIMMICK_200000;
    if (state->gameMode != GAMEMODE_VS_BATTLE && (work->gimmickFlag & PLAYER_GIMMICK_400000) == 0)
    {
        playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_PLAYER_DIED;
        playerGameStatus.field_20 |= 1;
    }
    else
    {
        MapSys__Func_2008714();
        work->gimmickFlag |= PLAYER_GIMMICK_200000;

        mapCamera.camera[work->cameraID].flags |= MAPSYS_CAMERA_FLAG_1;
        mapCamera.camera[work->cameraID].flags |= MAPSYS_CAMERA_FLAG_2;

        work->objWork.position.x = playerGameStatus.spawnPosition.x;
        work->objWork.position.y = playerGameStatus.spawnPosition.y;
        if ((work->gimmickFlag & PLAYER_GIMMICK_400000) == 0)
        {
            work->slomoTimer      = 0;
            work->objWork.fallDir = 0;
            work->confusionTimer  = 0;
            work->keyMap.up       = PAD_KEY_UP;
            work->keyMap.down     = PAD_KEY_DOWN;
            work->keyMap.left     = PAD_KEY_LEFT;
            work->keyMap.right    = PAD_KEY_RIGHT;
            work->playerFlag &= ~(PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR);
            work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
            work->tensionMaxTimer     = 0;
            work->unknownTimer        = 0;
            work->invincibleTimer     = 0;
            work->blinkTimer          = 0;
            work->itemBoxDisableTimer = 0;
            work->hyperTrickTimer     = 0;
            ObjDraw__PaletteTex__Process(&work->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
            work->rings = 0;

            if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
            {
                work->rings      = 1;
                work->blinkTimer = 180;
            }
        }
        else
        {
            work->gimmickFlag &= ~PLAYER_GIMMICK_200000;

            work->objWork.position.x = work->warpDestPos.x;
            work->objWork.position.y = work->warpDestPos.y;
            work->objWork.position.z = 0;

            work->warpDestPos.x = 0;
            work->warpDestPos.y = 0;

            work->itemBoxDisableTimer = work->blinkTimer = work->hurtInvulnDuration;
        }

        if (CheckIsPlayer1(work) && !IsBossStage())
        {
            DestroyPlayerSnowboard();
            work->gimmickFlag &= ~PLAYER_GIMMICK_SNOWBOARD;
            if (IsSnowboardActive())
            {
                SpawnLostPlayerSnowboard(0);
                Player__Action_EnableSnowboard(work, 1);
            }
        }

        g_obj.flag &= ~OBJECTMANAGER_FLAG_400;
        g_obj.scroll.x = g_obj.scroll.y = 0;

        work->playerFlag &= ~(PLAYER_FLAG_SUPERBOOST | PLAYER_FLAG_BOOST | PLAYER_FLAG_800 | PLAYER_FLAG_DISABLE_PRESSURE_CHECK | PLAYER_FLAG_DISABLE_INPUT_READ);
        work->gimmickFlag &=
            ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_40 | PLAYER_GIMMICK_80 | PLAYER_GIMMICK_100 | PLAYER_GIMMICK_200 | PLAYER_GIMMICK_400 | PLAYER_GIMMICK_1000
              | PLAYER_GIMMICK_2000 | PLAYER_GIMMICK_80000 | PLAYER_GIMMICK_BUNGEE | PLAYER_GIMMICK_4000000 | PLAYER_GIMMICK_8000000 | PLAYER_GIMMICK_20000000);

        MapSys__Func_20091D0(work->cameraID);
        MapSys__Func_20091F0(work->cameraID);

        work->comboTensionTimer      = 0;
        work->comboTensionMultiplier = 0;
        work->grindID                = 0;
        work->grindPrevRide          = 0;
        work->gimmickFlag &= ~PLAYER_GIMMICK_4;
        work->boostTimer      = 0;
        work->objWork.scale.x = work->objWork.scale.y = work->objWork.scale.z = FLOAT_TO_FX32(1.0);
        Player__InitState(work);
        Player__InitGimmick(work, FALSE);
    }
}

void Player__InitState(Player *player)
{
    SetTaskInFunc(&player->objWork, Player__In_Default);
    SetTaskSpriteCallback(&player->objWork, Player__SpriteCallback_Default);

    player->objWork.hitboxRect.left   = -7;
    player->objWork.hitboxRect.right  = 7;
    player->objWork.hitboxRect.top    = -12;
    player->objWork.hitboxRect.bottom = 13;
    ObjRect__SetGroupFlags(&player->colliders[0], 1, 2);
    player->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
    player->colliders[0].flag |= OBS_RECT_WORK_FLAG_20;

    if (!player->blinkTimer)
    {
        // player hitbox: world hitbox
        ObjRect__SetAttackStat(&player->colliders[0], 1, PLAYER_HITPOWER_NORMAL);
        ObjRect__SetDefenceStat(&player->colliders[0], 0, PLAYER_DEFPOWER_NORMAL);
    }

    if (!gmCheckVsBattleFlag() || CheckIsPlayer1(player))
    {
        // player hitbox: vsPlayer hitbox for player 1 (active player)
        ObjRect__SetGroupFlags(&player->colliders[1], 1, 2);
        player->colliders[1].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100 | OBS_RECT_WORK_FLAG_8);
        player->colliders[1].flag |= OBS_RECT_WORK_FLAG_20;
        ObjRect__SetAttackStat(&player->colliders[1], 0, PLAYER_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&player->colliders[1], ~0, PLAYER_DEFPOWER_INVINCIBLE);
    }
    else
    {
        // player hitbox: vsPlayer hitbox for player 2 (rival player)
        ObjRect__SetGroupFlags(&player->colliders[1], 2, 1);
        player->colliders[1].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100 | OBS_RECT_WORK_FLAG_8);
        player->colliders[1].flag |= OBS_RECT_WORK_FLAG_20;
        ObjRect__SetAttackStat(&player->colliders[1], 0, PLAYER_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&player->colliders[1], ~0, PLAYER_DEFPOWER_INVINCIBLE);
    }

    Player__InitPhysics(player);
    player->objWork.dir.x               = 0;
    player->objWork.dir.y               = 0;
    player->objWork.dir.z               = 0;
    player->objWork.groundVel           = 0;
    player->objWork.velocity.x          = 0;
    player->objWork.velocity.y          = 0;
    player->objWork.velocity.z          = 0;
    player->trickFinishHorizFreezeTimer = 0;

    if ((player->gimmickFlag & PLAYER_GIMMICK_100) == 0)
        player->objWork.position.z = 0;
    player->objWork.rideObj = NULL;

    if ((player->gimmickFlag & (PLAYER_GIMMICK_400 | PLAYER_GIMMICK_200)) == 0)
    {
        player->gimmickObj                     = 0;
        player->gimmickCamOffsetX              = 0;
        player->gimmickCamOffsetY              = 0;
        player->gimmickCamGimmickCenterOffsetX = 0;
        player->gimmickCamGimmickCenterOffsetY = 0;
        player->gimmickFlag &= ~(PLAYER_GIMMICK_8 | PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_40 | PLAYER_GIMMICK_80 | PLAYER_GIMMICK_4000000);
    }

    player->gimmick.value1          = 0;
    player->gimmick.value2          = 0;
    player->gimmick.value3          = 0;
    player->gimmick.value4          = 0;
    player->boostEndTimer           = 0;
    player->superBoostCooldownTimer = 0;
    player->starComboCount          = 0;
    player->activeTopSpeed          = 0;
    player->blazeHoverTimer         = 120;
    player->cameraJumpPosY          = 0;

    if ((player->grindID & PLAYER_GRIND_ACTIVE) != 0)
        player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;

    player->gimmickFlag &= ~(PLAYER_GIMMICK_1 | PLAYER_GIMMICK_2 | PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_40000 | PLAYER_GIMMICK_400000 | PLAYER_GIMMICK_20000000);
    player->playerFlag &= ~(PLAYER_FLAG_USER_FLAG | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_DISABLE_TRICK_FINISHER
                            | PLAYER_FLAG_DISABLE_HOMING_ATTACK | PLAYER_FLAG_DEATH | PLAYER_FLAG_2000 | PLAYER_FLAG_TRICK_SUCCESS | PLAYER_FLAG_8000 | PLAYER_FLAG_SLOWMO
                            | PLAYER_FLAG_DISABLE_TENSION_DRAIN | PLAYER_FLAG_DISABLE_TENSION_CHANGE);

    player->objWork.flag &= ~(STAGE_TASK_FLAG_NO_OBJ_COLLISION);
    player->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    player->objWork.displayFlag &= ~(DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED);
    if (!IsBossStage())
        player->objWork.displayFlag |= DISPLAY_FLAG_APPLY_CAMERA_CONFIG;

    player->objWork.moveFlag &=
        ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR | STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING | STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL
          | STAGE_TASK_MOVE_FLAG_IN_AIR | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS
          | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_RESET_FLOW);
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_200000 | STAGE_TASK_MOVE_FLAG_80000 | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_IDLE_ACCELERATION
                                | STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;

    if (player->objWork.obj_3d != NULL)
        player->objWork.obj_3d->ani.ratioMultiplier = FLOAT_TO_FX32(0.125);

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRIND);
    FadeOutPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
    ReleasePlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
}

void Player__SaveStartingPosition(fx32 x, fx32 y, fx32 z)
{
    startingPosX = FX32_TO_WHOLE(x);
    startingPosY = FX32_TO_WHOLE(y);
    startingPosZ = FX32_TO_WHOLE(z);

    if ((gameState.gameFlag & GAME_FLAG_REPLAY_GHOST_ACTIVE) != 0 && gPlayerList[1] != NULL)
    {
        gPlayerList[1]->objWork.position.x = x;
        gPlayerList[1]->objWork.position.y = y;
        gPlayerList[1]->objWork.position.z = z;
    }
}

void Player__InitGimmick(Player *player, BOOL allowTricks)
{
    player->gimmickObj                     = NULL;
    player->gimmickCamOffsetX              = 0;
    player->gimmickCamOffsetY              = 0;
    player->gimmickCamGimmickCenterOffsetX = 0;
    player->gimmickCamGimmickCenterOffsetY = 0;
    player->gimmick.value1                 = 0;
    player->gimmick.value2                 = 0;
    player->gimmick.value3                 = 0;
    player->gimmick.value4                 = 0;
    player->trickFinishHorizFreezeTimer    = 0;
    player->objWork.dir.x                  = FLOAT_DEG_TO_IDX(0.0);
    player->objWork.dir.y                  = FLOAT_DEG_TO_IDX(0.0);

    if (!allowTricks)
    {
        player->starComboCount = 0;
        player->gimmickFlag &= ~PLAYER_GIMMICK_ALLOW_TRICK_COMBO;
    }

    if ((player->grindID & PLAYER_GRIND_ACTIVE) != 0)
    {
        player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
        player->grindID = PLAYER_GRIND_NONE;
    }

    ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_Regular);
    player->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);

    player->playerFlag &= ~(PLAYER_FLAG_USER_FLAG | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_2000
                            | PLAYER_FLAG_TRICK_SUCCESS | PLAYER_FLAG_8000 | PLAYER_FLAG_SLOWMO | PLAYER_FLAG_DISABLE_TENSION_DRAIN);

    player->gimmickFlag &=
        ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_40 | PLAYER_GIMMICK_80 | PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_40000 | PLAYER_GIMMICK_4000000);

    player->objWork.displayFlag &= ~(DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_NO_DRAW);

    player->objWork.moveFlag &=
        ~(STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS
          | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_RESET_FLOW);
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_200000 | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_IDLE_ACCELERATION | STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION
                                | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;

    if (!IsBossStage())
        player->objWork.displayFlag |= DISPLAY_FLAG_APPLY_CAMERA_CONFIG;

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRIND);
}

void Player__InitPhysics(Player *player)
{
    player->acceleration = playerPhysicsTable[player->characterID].acceleration;

    if (IsBossStage())
        player->topSpeed = playerPhysicsTable[player->characterID].topSpeed >> 1;
    else
        player->topSpeed = playerPhysicsTable[player->characterID].topSpeed;

    player->spdThresholdWalk  = player->topSpeed * 0.15;
    player->spdThresholdJog   = player->topSpeed * 0.3;
    player->spdThresholdRun   = player->topSpeed * 0.5;
    player->spdThresholdDash  = player->topSpeed * 0.7;
    player->spdThresholdBoost = player->topSpeed * 0.9;

    player->deceleration              = playerPhysicsTable[player->characterID].deceleration;
    player->initialSpindashPower      = playerPhysicsTable[player->characterID].rollingVelocity;
    player->spindashChargePower       = playerPhysicsTable[player->characterID].rollingAcceleration;
    player->spindashTopSpeed          = playerPhysicsTable[player->characterID].rollingTopSpeed;
    player->rollingDeceleration       = playerPhysicsTable[player->characterID].rollingDeceleration;
    player->topSpeed_Boost            = playerPhysicsTable[player->characterID].topSpeed_Boost;
    player->acceleration_SuperBoost   = playerPhysicsTable[player->characterID].acceleration_SuperBoost;
    player->topSpeed_SuperBoost       = playerPhysicsTable[player->characterID].topSpeed_SuperBoost;
    player->deceleration_SuperBoost   = playerPhysicsTable[player->characterID].deceleration_SuperBoost;
    player->minBoostVelocity          = playerPhysicsTable[player->characterID].minBoostVelocity;
    player->slopeTopSpeedAccel        = playerPhysicsTable[player->characterID].slopeTopSpeedAccel;
    player->jumpForce                 = playerPhysicsTable[player->characterID].jumpStrength;
    player->airTimer                  = playerPhysicsTable[player->characterID].airTimer;
    player->hurtInvulnDuration        = playerPhysicsTable[player->characterID].hurtInvulnDuration;
    player->surfaceStickTimer         = playerPhysicsTable[player->characterID].surfaceStickTimer;
    player->objWork.slopeDirection    = FLOAT_TO_FX32(2.0);
    player->objWork.slopeAcceleration = playerPhysicsTable[player->characterID].slopeAcceleration;
    player->objWork.maxSlopeSpeed     = playerPhysicsTable[player->characterID].maxSlopeSpeed;
    player->objWork.gravityStrength   = playerPhysicsTable[player->characterID].gravityStrength;
    player->objWork.terminalVelocity  = playerPhysicsTable[player->characterID].terminalVelocity;
    player->objWork.pushCap           = playerPhysicsTable[player->characterID].pushCap;

    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
    {
        if (!IsBossStage())
            player->jumpForce = (player->jumpForce >> 1) + (player->jumpForce >> 2);

        if (!IsBossStage())
            player->objWork.gravityStrength >>= 1;
    }

    if (player->clingWeight != 0)
    {
        player->acceleration >>= player->clingWeight;
        player->topSpeed >>= player->clingWeight;
        player->initialSpindashPower >>= player->clingWeight;
        player->spindashChargePower >>= player->clingWeight;
        player->spindashTopSpeed >>= player->clingWeight;
        player->slopeTopSpeedAccel >>= player->clingWeight;
        player->jumpForce >>= player->clingWeight;
        player->objWork.slopeAcceleration >>= player->clingWeight;
        player->objWork.maxSlopeSpeed >>= player->clingWeight;
        player->objWork.pushCap >>= player->clingWeight;
    }
}

void Player__Action_Blank(Player *player)
{
    Player__InitState(player);
    Player__InitGimmick(player, FALSE);
    SetTaskState(&player->objWork, Player__State_Blank);
}

void Player__State_Blank(Player *work)
{
    // Empty
}

void Player__Action_Intangible(Player *player)
{
    Player__InitState(player);
    Player__InitGimmick(player, FALSE);
    SetTaskCollideFunc(&player->objWork, Player__Collide_Intangible);
    SetTaskState(&player->objWork, Player__State_Intangible);
}

void Player__RemoveCollideEvent(Player *player)
{
    SetTaskCollideFunc(&player->objWork, NULL);
}

void Player__State_Intangible(Player *work)
{
    // Empty
}

void Player__Collide_Intangible(void)
{
    // Empty
}

void Player__GiveRings(Player *player, s16 count)
{
    s32 prevRings = player->rings;

    player->rings += count;
    player->rings = ClampS32(player->rings, 0, PLAYER_MAX_RINGS);

    player->ringStageCount += count;
    player->ringStageCount = ClampS32(player->ringStageCount, 0, PLAYER_MAX_TOTAL_RINGS);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RING);

    // check if game mode is STAGE_SELECT or DEMO
    if (gameState.gameMode - 1 > 2)
    {
        for (s32 i = 100; i <= 900; i = (s16)(i + 100))
        {
            if (prevRings < i && player->rings >= i)
                Player__GiveLife(player, 1);
        }
    }
}

void Player__GiveLife(Player *player, u8 count)
{
    // check if game mode is STAGE_SELECT, MISSION or DEMO
    // TODO: is there a way to make this cleaner to read?
    if (gameState.gameMode - 1 > 1)
    {
        playerGameStatus.lives += count;
        playerGameStatus.lives = MATH_MIN(playerGameStatus.lives, (u32)PLAYER_MAX_LIVES);

        PlayTrack(NULL, 3, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQ_SEQ_1UP);
    }
}

void Player__GiveTension(Player *player, s32 amount)
{
    if (gmCheckVsBattleFlag() && amount == PLAYER_TENSION_MAX)
    {
        if (CheckIsPlayer1(player))
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_SUC1);

        CreateEffectBattleAttack(player, EFFECTBATTLEATTACK_TENSION_GAIN);
    }

    if ((player->playerFlag & PLAYER_FLAG_DISABLE_TENSION_CHANGE) == 0)
    {
        if (amount < 0)
        {
            if (player->tensionMaxTimer)
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TMAX_BONUS);
                ObjDraw__PaletteTex__Process(&player->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
            }

            player->tensionMaxTimer = 0;
        }

        player->tension += amount;

        if (player->tensionMaxTimer == 0)
        {
            if (player->tension >= PLAYER_TENSION_MAX)
            {
                player->tensionMaxTimer = PLAYER_TENSIONMAX_DURATION;
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TENSION_GAUGE);
            }
        }
        else
        {
            if (amount > 0)
            {
                player->tensionMaxTimer = PLAYER_TENSIONMAX_DURATION;
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TMAX_TRICK);
            }
        }

        player->tension = ClampS32(player->tension, 0, PLAYER_TENSION_MAX);
    }
}

void Player__GiveComboTension(Player *player, s32 amount)
{
    if (player->comboTensionTimer == 0)
        player->comboTensionMultiplier = 0;

    s16 awardTension = ClampS32((s16)(amount + (amount >> 1) * player->comboTensionMultiplier), 0, PLAYER_TENSION_MAX - 1);

    Player__GiveTension(player, awardTension);

    player->comboTensionTimer = PLAYER_TENSIONCOMBO_DURATION;
    player->comboTensionMultiplier++;
}

void Player__GiveInvincibility(Player *player)
{
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MUTEKI);
    PlayPlayerJingle(player, SND_ZONE_SEQ_SEQ_MUTEKI);

    player->waterTimer      = 0;
    player->invincibleTimer = PLAYER_INVINCIBLE_DURATION;

    CreateEffectInvincible(player);
}

void Player__GiveRegularShield(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_SHIELD_ANY) == 0)
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BARRIER);
        CreateEffectRegularShieldForPlayer(player);
    }

    player->playerFlag |= PLAYER_FLAG_SHIELD_REGULAR;
}

void Player__GiveMagnetShield(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_SHIELD_MAGNET) == 0)
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BARRIER);
        CreateEffectMagnetShieldForPlayer(player);
    }

    player->playerFlag |= PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR;
}

void Player__GiveHyperTrickEffect(Player *player)
{
    if (player->hyperTrickTimer == 0)
    {
        player->objWork.obj_3d->ani.speedMultiplier  = (player->objWork.obj_3d->ani.speedMultiplier << 1) + (player->objWork.obj_3d->ani.speedMultiplier >> 1);
        player->objWork.obj_2d->ani.work.animAdvance = player->objWork.obj_3d->ani.speedMultiplier;

        if (playerTailAnimForAction[player->characterID])
            player->aniTailModel.ani.speedMultiplier = player->objWork.obj_3d->ani.speedMultiplier;
    }

    player->hyperTrickTimer = PLAYER_HYPERTRICK_DURATION;
}

void Player__GiveSlowdownEffect(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_SLOWMO) == 0)
    {
        CreateEffectBattleAttack(player, EFFECTBATTLEATTACK_SLOWMO);
        player->slomoTimer = PLAYER_SLOWMO_DURATION;
    }
}

void Player__GiveConfusionEffect(Player *player)
{
    CreateEffectBattleAttack(player, EFFECTBATTLEATTACK_CONFUSION);
    player->confusionTimer = PLAYER_CONFUSION_DURATION;
}

void Player__DepleteTension(Player *player)
{
    if (CheckIsPlayer1(player))
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_MISS);

    CreateEffectBattleAttack(player, EFFECTBATTLEATTACK_TENSION_DRAIN);
    Player__GiveTension(player, -PLAYER_TENSION_MAX);
    UpdateTensionGaugeHUD(player->tension >> 4, TRUE);
}

void Player__ApplyWarpEfect(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
    {
        if ((gPlayerList[1]->gimmickFlag & PLAYER_GIMMICK_800000) != 0)
            player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
        else
            player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;

        player->warpDestPos.x = gPlayerList[1]->objWork.position.x;
        player->warpDestPos.y = gPlayerList[1]->objWork.position.y;
        Player__Action_Warp(player);
    }
}

void Player__ChangeAction(Player *player, PlayerAction action)
{
    s16 lastAction = player->actionState;
    u8 characterID = player->characterID;
    fx32 animSpeed = GetPlayerAnimSpeed(player);

    player->actionState = action;
    player->objWork.displayFlag &= ~(DISPLAY_FLAG_DID_FINISH | DISPLAY_FLAG_DISABLE_LOOPING);

    player->colliders[0].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
    player->colliders[1].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;

    if (player->objWork.obj_3d != NULL)
    {
        if (playerModelIndexForAction[characterID][lastAction] != playerModelIndexForAction[characterID][action])
        {
            struct NNSG3dJntAnmResult_ *recJntAnm = player->aniPlayerModel.ani.renderObj.recJntAnm;
            struct NNSG3dMatAnmResult_ *recMatAnm = player->aniPlayerModel.ani.renderObj.recMatAnm;

            AnimatorMDL__SetResource(&player->objWork.obj_3d->ani, player->objWork.obj_3d->resources[B3D_RESOURCE_MODEL], playerModelIndexForAction[characterID][action], FALSE,
                                     FALSE);
            player->objWork.displayFlag &= ~DISPLAY_FLAG_400;

            player->aniPlayerModel.ani.renderObj.recJntAnm = recJntAnm;
            player->aniPlayerModel.ani.renderObj.recMatAnm = recMatAnm;
            player->playerFlag |= PLAYER_FLAG_80000000;
        }

        if (CheckIsPlayer1(player) && (player->objWork.displayFlag & DISPLAY_FLAG_400) != 0)
            player->objWork.obj_3d->ani.animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        else
            player->objWork.obj_3d->ani.animFlags[B3D_ANIM_JOINT_ANIM] &= ~ANIMATORMDL_FLAG_BLEND_ANIMATIONS;

        if (action < PLAYER_ACTION_START_SNOWBOARD || action > PLAYER_ACTION_HURT_SNOWBOARD)
            AnimatorMDL__SetAnimation(&player->objWork.obj_3d->ani, B3D_RESOURCE_MODEL, player->objWork.obj_3d->resources[1], playerModelAnimForAction[characterID][action], NULL);
        else
            AnimatorMDL__SetAnimation(&player->objWork.obj_3d->ani, B3D_RESOURCE_MODEL, player->snowboardAnims, playerModelAnimForAction[characterID][action], NULL);

        player->objWork.obj_3d->ani.speedMultiplier = animSpeed;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_400;
    }

    if (playerTailAnimForAction[characterID] != NULL)
    {
        if (playerTailAnimForAction[characterID][action] != PLAYER_ANIM_NONE)
        {
            player->playerFlag |= PLAYER_FLAG_TAIL_IS_ACTIVE;

            if (action < PLAYER_ACTION_START_SNOWBOARD || action > PLAYER_ACTION_HURT_SNOWBOARD)
                AnimatorMDL__SetAnimation(&player->aniTailModel.ani, B3D_RESOURCE_MODEL, player->aniTailModel.resources[B3D_RESOURCE_JOINT_ANIM], playerTailAnimForAction[characterID][action], NULL);
            else
                AnimatorMDL__SetAnimation(&player->aniTailModel.ani, B3D_RESOURCE_MODEL, player->snowboardAnims, playerTailAnimForAction[characterID][action], NULL);

            if (CheckIsPlayer1(player) && (player->objWork.displayFlag & DISPLAY_FLAG_400) != 0)
                player->aniTailModel.ani.animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
            else
                player->aniTailModel.ani.animFlags[B3D_ANIM_JOINT_ANIM] &= ~ANIMATORMDL_FLAG_BLEND_ANIMATIONS;

            player->aniTailModel.ani.speedMultiplier = animSpeed;
        }
        else
        {
            player->playerFlag &= ~PLAYER_FLAG_TAIL_IS_ACTIVE;
        }
    }

    AnimatorSpriteDS *animator2D = &player->objWork.obj_2d->ani;
    animator2D->work.animAdvance = animSpeed;
    AnimatorSpriteDS__SetAnimation(animator2D, playerSpriteAnimForAction[characterID][action]);
}

void Player__SetAnimFrame(Player *player, fx32 frame)
{
    if (frame < 0 || frame >= NNS_G3dAnmObjGetNumFrame(player->objWork.obj_3d->ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]))
    {
        frame = NNS_G3dAnmObjGetNumFrame(player->objWork.obj_3d->ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]) - 1;
    }

    NNS_G3dAnmObjSetFrame(player->objWork.obj_3d->ani.currentAnimObj[B3D_ANIM_JOINT_ANIM], frame);

    if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
        NNS_G3dAnmObjSetFrame(player->aniTailModel.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM], frame);
}

void Player__SetAnimSpeedFromVelocity(Player *player, fx32 velocity)
{
    fx32 animSpeed;

    if (player->characterID == CHARACTER_BLAZE)
    {
        animSpeed = MATH_ABS(velocity >> 1);
    }
    else
    {
        animSpeed = MATH_ABS((velocity >> 3) + (velocity >> 2));
    }

    if (animSpeed <= FLOAT_TO_FX32(1.0))
        animSpeed = FLOAT_TO_FX32(1.0);

    if (animSpeed >= FLOAT_TO_FX32(8.0))
        animSpeed = FLOAT_TO_FX32(8.0);

    if (player->hyperTrickTimer != 0)
        animSpeed = (animSpeed << 1) + (animSpeed >> 1);

    player->objWork.obj_2d->ani.work.animAdvance = animSpeed;

    if (player->objWork.obj_3d != NULL)
        player->objWork.obj_3d->ani.speedMultiplier = animSpeed;

    if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
        player->aniTailModel.ani.speedMultiplier = animSpeed;
}

void Player__UseDashPanel(Player *player, fx32 velX, fx32 velY)
{
    player->overSpeedLimitTimer = 128;

    if (velX < 0)
        player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    else
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
    {
        if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && player->objWork.velocity.x > velX
            || (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && player->objWork.velocity.x < velX)
            player->objWork.velocity.x = velX;

        if (MATH_ABS(player->objWork.velocity.y) < MATH_ABS(velY))
            player->objWork.velocity.y = velY;
    }
    else
    {
        switch (((player->objWork.dir.z + FLOAT_DEG_TO_IDX(45.0f)) & 0xC000) >> 6)
        {
            case 0:
            case 2:
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && player->objWork.groundVel > velX
                    || (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && player->objWork.groundVel < velX)
                    player->objWork.groundVel = velX;

                if (MATH_ABS(player->objWork.velocity.y) < MATH_ABS(velY))
                {
                    player->objWork.velocity.y = velY;

                    if (velY < 0)
                        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
                }
                break;

            case 1:
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && player->objWork.groundVel > velY
                    || (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && player->objWork.groundVel < velY)
                    player->objWork.groundVel = velY;

                if (MATH_ABS(player->objWork.velocity.x) < MATH_ABS(velX))
                    player->objWork.velocity.x = velX;
                break;

            case 3:
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && player->objWork.groundVel > -velY
                    || (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && player->objWork.groundVel < -velY)
                {
                    player->objWork.groundVel = -velY;
                }

                if (MATH_ABS(player->objWork.velocity.x) < MATH_ABS(velX))
                    player->objWork.velocity.x = velX;
                break;
        }
    }

    Player__Action_Boost(player);
}

void Player__HandleStartWalkAnimation(Player *player)
{
    fx32 velocity = MATH_ABS(player->objWork.groundVel);

    PlayerAction action;
    if (velocity < player->spdThresholdWalk)
    {
        action = PLAYER_ACTION_WALK1;
    }
    else if (velocity < player->spdThresholdJog)
    {
        action = PLAYER_ACTION_WALK2;
    }
    else if (velocity < player->spdThresholdRun)
    {
        action = PLAYER_ACTION_WALK3;
    }
    else if (velocity < player->spdThresholdDash)
    {
        action = PLAYER_ACTION_WALK4;
    }
    else
    {
        if ((player->playerFlag & (PLAYER_FLAG_BOOST | PLAYER_FLAG_SUPERBOOST)) != 0)
        {
            if (velocity < player->spdThresholdBoost)
                action = PLAYER_ACTION_WALK5;
            else
                action = PLAYER_ACTION_WALK6;
        }
        else
        {
            action = PLAYER_ACTION_WALK4;
        }
    }

    Player__ChangeAction(player, action);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
}

void Player__HandleActiveWalkAnimation(Player *player)
{
    fx32 velocity = MATH_ABS(player->objWork.groundVel);

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if (player->actionState < PLAYER_ACTION_WALK1 || player->actionState > PLAYER_ACTION_WALK6)
        {
            Player__ChangeAction(player, PLAYER_ACTION_WALK1);
        }

        if (player->actionState == PLAYER_ACTION_WALK1 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0 && velocity >= player->spdThresholdWalk)
        {
            Player__ChangeAction(player, PLAYER_ACTION_WALK2);
        }

        if (player->actionState == PLAYER_ACTION_WALK2 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            if (velocity >= player->spdThresholdJog)
                Player__ChangeAction(player, PLAYER_ACTION_WALK3);
            else
                Player__ChangeAction(player, PLAYER_ACTION_WALK1);
        }

        if (player->actionState == PLAYER_ACTION_WALK3 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            if (velocity >= player->spdThresholdRun)
                Player__ChangeAction(player, PLAYER_ACTION_WALK4);
            else
                Player__ChangeAction(player, PLAYER_ACTION_WALK2);
        }

        if ((player->playerFlag & (PLAYER_FLAG_BOOST | PLAYER_FLAG_SUPERBOOST)) != 0)
        {
            if (player->actionState == PLAYER_ACTION_WALK4 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                if (velocity >= player->spdThresholdDash)
                    Player__ChangeAction(player, PLAYER_ACTION_WALK5);
                else
                    Player__ChangeAction(player, PLAYER_ACTION_WALK3);
            }

            if (player->actionState == PLAYER_ACTION_WALK5 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                if (velocity >= player->spdThresholdBoost)
                    Player__ChangeAction(player, PLAYER_ACTION_WALK6);
                else
                    Player__ChangeAction(player, PLAYER_ACTION_WALK4);
            }

            if (player->actionState == PLAYER_ACTION_WALK6 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0 && velocity < player->spdThresholdBoost)
            {
                Player__ChangeAction(player, PLAYER_ACTION_WALK5);
            }
        }
        else if (player->actionState == PLAYER_ACTION_WALK4 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0 && velocity < player->spdThresholdDash)
        {
            Player__ChangeAction(player, PLAYER_ACTION_WALK3);
        }

        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }
}

BOOL Player__HandleFallOffSurface(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        Player__InitPhysics(player);
        return TRUE;
    }

    if (player->surfaceStickTimer)
    {
        player->surfaceStickTimer--;
    }
    else
    {
        if (((player->objWork.dir.z + FLOAT_DEG_TO_IDX(90.0)) & 0x8000) == 0 && player->objWork.dir.z != FLOAT_DEG_TO_IDX(270.0))
            return FALSE;

        if (MATH_ABS(player->objWork.groundVel) >= FLOAT_TO_FX32(1.875))
            return FALSE;

        Player__InitPhysics(player);
        return TRUE;
    }

    return FALSE;
}

void Player__Action_LandOnGround(Player *player, fx32 dirZ)
{
    Player__InitPhysics(player);

    player->trickStateRef = NULL;
    player->playerFlag &= ~(PLAYER_FLAG_8000 | PLAYER_FLAG_TRICK_SUCCESS);
    player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_IN_AIR | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES);
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
    player->blazeHoverTimer             = SECONDS_TO_FRAMES(2.0);
    player->trickFinishHorizFreezeTimer = 0;

    if ((player->gimmickFlag & PLAYER_GIMMICK_1) == 0 && (player->objWork.collisionFlag & STAGE_TASK_COLLISION_FLAG_1) != 0)
        player->objWork.dir.z = 0;

    if ((player->actionState < PLAYER_ACTION_GRIND || player->actionState > PLAYER_ACTION_GRINDTRICK_3_03)
        && (player->actionState < PLAYER_ACTION_GRIND_SNOWBOARD || player->actionState > PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_03))
    {
        if (player->grindID != PLAYER_GRIND_NONE && (player->grindPrevRide & 2) != 0)
        {
            player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
            player->objWork.flag |= (player->grindPrevRide & 1);
            player->grindPrevRide = PLAYER_GRIND_NONE;
        }
        player->grindID = PLAYER_GRIND_NONE;
    }

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if (dirZ)
        {
            player->objWork.groundVel += MultiplyFX(player->objWork.move.x, CosFX((u16)dirZ));
            player->objWork.groundVel += MultiplyFX(player->objWork.move.y, SinFX((u16)dirZ));

            if (StageTask__ObjectDirFallReverseCheck(player->objWork.fallDir))
                player->objWork.groundVel = -player->objWork.groundVel;
        }
        else
        {
            if (MATH_ABS(player->objWork.groundVel) < MATH_ABS(player->objWork.velocity.x))
                player->objWork.groundVel = player->objWork.velocity.x;

            player->objWork.groundVel += MultiplyFX(MATH_ABS(player->objWork.velocity.x), SinFX(player->objWork.dir.z));
        }
    }
    else
    {
        if (MATH_ABS(player->objWork.groundVel) < MATH_ABS(player->objWork.velocity.x))
            player->objWork.groundVel = player->objWork.velocity.x;

        player->objWork.groundVel += MultiplyFX(MATH_ABS(player->objWork.velocity.x), SinFX(player->objWork.dir.z));
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
    }

    player->activeTopSpeed = MATH_ABS(player->objWork.groundVel);
    if (player->activeTopSpeed > player->objWork.maxSlopeSpeed)
        player->activeTopSpeed = player->objWork.maxSlopeSpeed;

    player->objWork.velocity.x = 0;
    player->objWork.velocity.y = 0;

    if (dirZ)
        player->objWork.dir.z = dirZ;

    if ((player->gimmickFlag & PLAYER_GIMMICK_1000) == 0)
        player->objWork.dir.x = 0;

    player->cameraJumpPosY = 0;

    FadeOutPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
    ReleasePlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
}

void Player__Action_RainbowDashRing(Player *player)
{
    player->objWork.dir.z = FX_Atan2Idx(player->objWork.velocity.y, player->objWork.velocity.x) + FLOAT_DEG_TO_IDX(90.0);

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_RAINBOWDASHRING);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_RAINBOWDASHRING_SNOWBOARD);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_RAINBOWDASHRING);
    }

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DASH_CIRCLE);

    if (player->starComboManager == NULL)
        player->starComboCount = 0;

    ApplyPlayerTensionPenalty(player);

    Player__GiveScore(player, PLAYER_SCOREBONUS_RAINBOWDASHRING);
}

void Player__ApplySlopeForces(Player *player, GameObjectTask *other)
{
    u32 angle = player->objWork.dir.z;
    if (other != NULL)
        angle = other->objWork.dir.z;

    player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, MultiplyFX(player->objWork.slopeAcceleration, SinFX(angle)), player->objWork.maxSlopeSpeed);
    player->playerFlag |= PLAYER_FLAG_SLOPE_FORCE_APPLIED;
}

void Player__OnLandGround(Player *player)
{
    if (player->objWork.groundVel != FLOAT_TO_FX32(0.0))
    {
        player->actionGroundMove(player);
    }
    else
    {
        if (player->actionState != PLAYER_ACTION_TURNING)
        {
            if ((player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0
                || ((player->actionState != PLAYER_ACTION_AIRFORWARD_01 && player->actionState != PLAYER_ACTION_TRICK_SUCCESS1)
                    && (player->actionState != PLAYER_ACTION_TRICK_SUCCESS2 && player->actionState != PLAYER_ACTION_TRICK_FINISH)))
            {
                player->objWork.displayFlag |= DISPLAY_FLAG_400;
            }
        }

        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            Player__ChangeAction(player, PLAYER_ACTION_IDLE);
        }
        else
        {
            Player__ChangeAction(player, PLAYER_ACTION_IDLE_SNOWBOARD);
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_IDLE);
        }

        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
        SetTaskState(&player->objWork, Player__State_GroundIdle);
    }
}

void Player__OnGroundMove(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if (((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && (player->inputKeyDown & PAD_KEY_RIGHT) != 0)
            || ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && (player->inputKeyDown & PAD_KEY_LEFT) != 0))
            Player__ChangeAction(player, PLAYER_ACTION_TURNING);
        else
            Player__HandleStartWalkAnimation(player);

        if (player->actionState == PLAYER_ACTION_TURNING)
        {
            if ((player->inputKeyDown & PAD_KEY_LEFT) != 0)
            {
                player->playerFlag |= PLAYER_FLAG_USER_FLAG;
            }
            else if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                player->playerFlag &= ~PLAYER_FLAG_USER_FLAG;
            }
        }
    }
    else
    {
        if (player->actionState != PLAYER_ACTION_WALK_SNOWBOARD)
        {
            Player__ChangeAction(player, PLAYER_ACTION_WALK_SNOWBOARD);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_WALK);
        }

        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    }

    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, Player__State_GroundMove);
    Player__HandleGroundMovement(player);
}

void Player__Action_Launch(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_JUMPFALL);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_JUMPFALL_SNOWBOARD);
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_JUMPFALL);
    }

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, Player__State_Air);

    player->objWork.velocity.x = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
    player->objWork.velocity.y = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));
    ObjRect__SetAttackStat(&player->colliders[1], 0, PLAYER_HITPOWER_VULNERABLE);

    player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
    player->playerFlag |= PLAYER_FLAG_USER_FLAG;
    player->objWork.userTimer  = 0;
    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;
}

void Player__PerformTrick(Player *player)
{
    ApplyPlayerTensionPenalty(player);

    if ((player->playerFlag & PLAYER_FLAG_TRICK_SUCCESS) != 0 && (player->objWork.userWork & (PAD_BUTTON_A | PAD_BUTTON_X)) != 0)
    {
        // finish trick
        HandlePlayerTrickFinish(player);
    }
    else
    {
        if ((player->objWork.userWork & PAD_BUTTON_B) == 0)
            return;

        player->playerFlag |= PLAYER_FLAG_TRICK_SUCCESS;

        if (player->actionState == PLAYER_ACTION_TRICK_SUCCESS1 || player->actionState == PLAYER_ACTION_TRICK_SUCCESS1_SNOWBOARD)
        {
            // success 1
            HandlePlayerTrickSuccess1(player);
        }
        else
        {
            // success 2
            HandlePlayerTrickSuccess2(player);
        }

        HandlePlayerTrickSuccessBonus(player);
    }

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    StarCombo__DisplayConfetti(player);

    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;
}

void Player__Action_Grind(Player *player)
{
    player->grindID &= ~PLAYER_GRIND_ACTIVE;
    Player__InitGimmick(player, FALSE);

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_GRIND);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_GRIND_SNOWBOARD);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_GRIND);
    }

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->playerFlag &= ~(PLAYER_FLAG_8000 | PLAYER_FLAG_TRICK_SUCCESS);
    player->grindID |= PLAYER_GRIND_ACTIVE;
    player->grindPrevRide = PLAYER_GRIND_NONE;
    SetTaskState(&player->objWork, Player__State_Grinding);

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        if (MATH_ABS(player->objWork.velocity.x) < MATH_ABS(player->objWork.groundVel))
            player->objWork.velocity.x = player->objWork.groundVel;
    }

    Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));

    if (player->objWork.groundVel > -FLOAT_TO_FX32(2.0) && player->objWork.groundVel < FLOAT_TO_FX32(2.0))
    {
        if (player->objWork.groundVel < FLOAT_TO_FX32(0.0))
        {
            // clamp grind speed to a minimum of -2.0 if moving left
            player->objWork.groundVel = -FLOAT_TO_FX32(2.0);
        }
        else if (player->objWork.groundVel > FLOAT_TO_FX32(0.0))
        {
            // clamp grind speed to a minimum of 2.0 if moving right
            player->objWork.groundVel = FLOAT_TO_FX32(2.0);
        }
        else
        {
            // clamp grind speed to a minimum of (-)2.0 based on the player facing direction if not moving
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                player->objWork.groundVel = -FLOAT_TO_FX32(2.0);
            else
                player->objWork.groundVel = FLOAT_TO_FX32(2.0);
        }
    }

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRIND);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRIND, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GRIND);

    player->objWork.userTimer = 0;
    player->objWork.userWork  = 0;

    CreateEffectGrindSparkForPlayer(player);
}

void Player__Action_Die(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) != 0 || (player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) != 0)
        return;

    Player__InitState(player);

    Player__ChangeAction(player, PLAYER_ACTION_DEATH_01);
    player->tensionMaxTimer = 0;
    player->invincibleTimer = 0;
    player->hyperTrickTimer = 0;

    ObjDraw__PaletteTex__Process(&player->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));

    player->playerFlag &= ~PLAYER_FLAG_USED_INFINITE_TENSION;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->objWork.velocity.x = 0;
    player->objWork.groundVel  = 0;
    player->objWork.velocity.y = -player->jumpForce;

    Player__Action_StopBoost(player);
    Player__Action_StopSuperBoost(player);
    player->playerFlag &= ~(PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR);
    SetTaskState(&player->objWork, Player__State_Death);
    player->objWork.userTimer = 0;
    player->waterTimer        = 0;
    player->playerFlag |= PLAYER_FLAG_DEATH;
    ShakeScreen(SCREENSHAKE_D_SHORT);

    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WATER_DEATH);
    else
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEATH);
}

void Player__Action_Warp(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) != 0 || (player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) != 0)
        return;

    Player__InitState(player);
    Player__ChangeAction(player, PLAYER_ACTION_DEATH_01);

    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
    player->objWork.velocity.x    = 0;
    player->objWork.velocity.y    = 0;
    player->objWork.groundVel     = 0;
    Player__Action_StopBoost(player);
    Player__Action_StopSuperBoost(player);

    SetTaskState(&player->objWork, Player__State_Warp);
    player->objWork.userTimer = 0;
    player->objWork.userWork  = 0;
    player->objWork.userFlag  = 0;
    player->waterTimer        = 0;
    player->objWork.scale.x   = FLOAT_TO_FX32(1.0);
    player->objWork.scale.y   = FLOAT_TO_FX32(1.0);
    player->playerFlag |= PLAYER_FLAG_DEATH;

    ShakeScreen(SCREENSHAKE_D_SHORT);
    if (!IsDrawFadeTaskFinished())
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.0));
}

void Player__Action_DestroyAttackRecoil(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
    {
        fx32 velX      = player->objWork.velocity.x;
        fx32 groundVel = player->objWork.groundVel;

        Player__InitState(player);

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        SetTaskState(&player->objWork, Player__State_Air);
        ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);

        player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
        player->objWork.velocity.x = velX;
        player->objWork.groundVel  = groundVel;
        player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
        player->playerFlag |= PLAYER_FLAG_USER_FLAG;
    }

    player->objWork.userTimer  = 0;
    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;
}

void Player__Action_AttackRecoil(Player *player)
{
    Player__InitState(player);
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    if (player->objWork.move.x <= 0)
        player->objWork.velocity.x = FLOAT_TO_FX32(1.5);
    else
        player->objWork.velocity.x = -FLOAT_TO_FX32(1.5);
    player->overSpeedLimitTimer = 24;
    Player__Action_DestroyAttackRecoil(player);
}

void Player__Action_Knockback_NoHurt(Player *player, fx32 velX, fx32 velY)
{
    Player__InitState(player);
    Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);
    player->objWork.velocity.x = velX;
    player->objWork.velocity.y = velY;
    player->objWork.groundVel  = FLOAT_TO_FX32(0.0);

    if (velX < FLOAT_TO_FX32(0.0))
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    else
        player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

    SetTaskState(&player->objWork, Player__State_Hurt);
}

void Player__Action_FinishMission(Player *player, GameObjectTask *other)
{
    GameMode gameMode = gameState.gameMode;

    if ((player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
    {
        if (other != NULL)
        {
            if (gameMode == GAMEMODE_VS_BATTLE && CheckIsPlayer1(player))
                GameObject__SendPacket(other, player, GAMEOBJECT_PACKET_OBJ_COLLISION);

            playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
        }

        if (!gmCheckRaceStage())
        {
            if (!gmCheckRingBattle())
            {
                if (gameMode != GAMEMODE_MISSION || (gameMode == GAMEMODE_MISSION && gameState.missionType == MISSION_TYPE_REACH_GOAL_TIME_LIMIT)
                    || (gameMode == GAMEMODE_MISSION && gameState.missionType == MISSION_TYPE_REACH_GOAL))
                {
                    if (other != NULL)
                    {
                        Player__InitGimmick(player, FALSE);

                        if (StageTaskStateMatches(&player->objWork, Player__State_Roll) || StageTaskStateMatches(&player->objWork, Player__State_Spindash))
                        {
                            player->objWork.groundVel = 0;
                            player->onLandGround(player);
                        }

                        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
                        {
                            if (gameMode == GAMEMODE_VS_BATTLE)
                            {
                                fx32 distance = (other->objWork.position.x - player->objWork.position.x);
                                if (MATH_ABS(distance) < FLOAT_TO_FX32(64.0))
                                {
                                    if (distance >= 0)
                                        player->objWork.velocity.x = (distance - FLOAT_TO_FX32(64.0)) >> 5;
                                    else
                                        player->objWork.velocity.x = (distance + FLOAT_TO_FX32(64.0)) >> 5;
                                }
                            }
                            else
                            {
                                if (player->objWork.fallDir != 0)
                                    player->objWork.velocity.x = -FLOAT_TO_FX32(0.75);
                                else
                                    player->objWork.velocity.x = FLOAT_TO_FX32(0.75);
                            }
                            player->overSpeedLimitTimer = 24;
                            Player__Action_DestroyAttackRecoil(player);
                            player->objWork.velocity.y = -FLOAT_TO_FX32(4.5);
                        }
                        else if (gameMode == GAMEMODE_VS_BATTLE)
                        {
                            player->objWork.groundVel = ClampS32(player->objWork.groundVel, -FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(8.0));
                        }

                        player->gimmickObj = other;
                        player->gimmickFlag |= PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;
                        player->gimmickCamOffsetY = 56;
                    }
                }
                else
                {
                    Player__InitGimmick(player, FALSE);

                    player->objWork.velocity.x  = 0;
                    player->objWork.velocity.y  = 0;
                    player->objWork.groundVel   = 0;
                    player->objWork.dir.z       = 0;
                    player->overSpeedLimitTimer = 24;
                    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
                    Player__Action_DestroyAttackRecoil(player);
                    player->objWork.velocity.y = -FLOAT_TO_FX32(4.5);

                    if (other != NULL)
                    {
                        fx32 distance = (other->objWork.position.x - player->objWork.position.x);
                        if (MATH_ABS(distance) < FLOAT_TO_FX32(64.0))
                        {
                            if (distance >= 0)
                                player->objWork.velocity.x = (distance - FLOAT_TO_FX32(64.0)) >> 5;
                            else
                                player->objWork.velocity.x = (distance + FLOAT_TO_FX32(64.0)) >> 5;
                        }
                        player->gimmickObj = other;
                        player->gimmickFlag |= PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;
                        player->gimmickCamOffsetX = 0;
                        player->gimmickCamOffsetY = 56;
                    }

                    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
                    {
                        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH);
                    }
                    else
                    {
                        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH_SNOWBOARD);
                        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_TRICK_FINISH);
                    }
                }
            }
        }

        if (gameMode == GAMEMODE_VS_BATTLE && !gmCheckRaceStage())
        {
            player->inputKeyDown = player->inputKeyPress = player->inputKeyRepeat = PAD_INPUT_NONE_MASK;

            if (!IsDrawFadeTaskFinished())
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.0));
        }
        else
        {
            if (gameMode == GAMEMODE_MISSION)
            {
                if (gameState.missionType == MISSION_TYPE_REACH_GOAL_TIME_LIMIT || gameState.missionType == MISSION_TYPE_REACH_GOAL)
                {
                    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_80000;
                    player->inputKeyPress  = PAD_INPUT_NONE_MASK;
                    player->inputKeyRepeat = PAD_INPUT_NONE_MASK;
                    player->inputKeyDown &= (PAD_BUTTON_A | PAD_BUTTON_B | PAD_BUTTON_Y);

                    if (player->objWork.fallDir != FLOAT_DEG_TO_IDX(0.0))
                        player->inputKeyDown |= PAD_KEY_LEFT;
                    else
                        player->inputKeyDown |= PAD_KEY_RIGHT;
                }
                else if (gameState.missionType == MISSION_TYPE_FIND_MEDAL)
                {
                    player->inputKeyDown = player->inputKeyPress = player->inputKeyRepeat = PAD_INPUT_NONE_MASK;
                    player->gimmickCamCenterOffsetY                                       = 48;
                }
                else
                {
                    FinishMission(player);
                }

                playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
            }
            else
            {
                player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_80000;
                player->inputKeyPress  = PAD_INPUT_NONE_MASK;
                player->inputKeyRepeat = PAD_INPUT_NONE_MASK;
                player->inputKeyDown &= (PAD_BUTTON_A | PAD_BUTTON_B | PAD_BUTTON_Y);

                if (player->objWork.fallDir != 0)
                    player->inputKeyDown |= PAD_KEY_LEFT;
                else
                    player->inputKeyDown |= PAD_KEY_RIGHT;
            }
        }

        player->playerFlag |= PLAYER_FLAG_FINISHED_STAGE | PLAYER_FLAG_DISABLE_TENSION_CHANGE | PLAYER_FLAG_DISABLE_INPUT_READ;
        player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
        player->tensionMaxTimer       = 0;
        player->invincibleTimer       = 0;
        ObjDraw__PaletteTex__Process(&player->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));

        if (gameMode == GAMEMODE_VS_BATTLE)
        {
            if (CheckIsPlayer1(player) == FALSE)
            {
                Player *playerPtr = gPlayer;
                playerPtr->playerFlag |= PLAYER_FLAG_FINISHED_STAGE | PLAYER_FLAG_DISABLE_TENSION_CHANGE;
                playerPtr->tensionMaxTimer = 0;
                playerPtr->invincibleTimer = 0;
                ObjDraw__PaletteTex__Process(&playerPtr->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
            }
            else
            {
                SendPacketForStageScoreEvent();
            }
        }
    }
}

void Player__HandleGroundMovement(Player *player)
{
    fx32 topSpeed = player->topSpeed;

    if ((player->playerFlag & PLAYER_FLAG_BOOST) != 0)
        topSpeed = player->topSpeed_Boost;

    fx32 acceleration = player->acceleration;
    fx32 deceleration = player->deceleration;
    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        acceleration = player->acceleration_SuperBoost;
        deceleration = player->deceleration_SuperBoost;
        topSpeed     = player->topSpeed_SuperBoost;
    }

    Player__HandleBoost(player);

    if (player->objWork.dir.z != 0)
    {
        fx32 accel = MultiplyFX(player->slopeTopSpeedAccel, SinFX((s32)player->objWork.dir.z));
        if (accel > 0)
            topSpeed += accel;
    }

    if (player->overSpeedLimitTimer != 0)
    {
        deceleration = 0;
    }
    else
    {
        fx32 accel = 0;
        if (MATH_ABS(player->objWork.groundVel) > player->spdThresholdJog)
        {
            fx32 div = FX_Div(MATH_ABS(player->objWork.groundVel) - player->spdThresholdJog, topSpeed - player->spdThresholdJog);
            if (div > FLOAT_TO_FX32(1.0))
                div = FLOAT_TO_FX32(1.0);

            accel = FX32_TO_WHOLE(FLOAT_TO_FX32(0.96875) * div);
        }
        acceleration -= MultiplyFX(acceleration, accel);
    }

    // water effects aren't present in bosses (Z3 boss)
    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
    {
        if (!IsBossStage())
            acceleration >>= 1;

        if (!IsBossStage())
            deceleration >>= 1;
    }

    if (player->activeTopSpeed >= topSpeed)
    {
        if (MATH_ABS(player->objWork.groundVel) >= topSpeed)
        {
            if (player->activeTopSpeed > player->objWork.groundVel)
            {
                player->activeTopSpeed = MATH_ABS(player->objWork.groundVel);
            }

            topSpeed = player->activeTopSpeed;
        }
    }

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if ((player->inputKeyDown & (PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0)
        {
            if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0) // if player is holding right
            {
                if (player->actionState && (player->actionState < PLAYER_ACTION_BRAKE1_01 || player->actionState > PLAYER_ACTION_BRAKE2_03))
                    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

                if (player->objWork.groundVel < 0)
                    player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, deceleration);

                player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, acceleration, topSpeed);
            }
            else // if player is holding left
            {
                if (player->actionState && (player->actionState < PLAYER_ACTION_BRAKE1_01 || player->actionState > PLAYER_ACTION_BRAKE2_03))
                    player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

                if (player->objWork.groundVel > 0)
                    player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, deceleration);

                player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, -acceleration, topSpeed);
            }
        }
        else // if player is holding neither left/right
        {
            player->boostTimer         = 0;
            player->objWork.velocity.x = ClampS32(player->objWork.velocity.x, -topSpeed, topSpeed);

            player->objWork.groundVel = ((player->objWork.groundVel < -topSpeed) ? -topSpeed : ((player->objWork.groundVel > topSpeed) ? topSpeed : player->objWork.groundVel));

            if (((player->objWork.dir.z + FLOAT_DEG_TO_IDX(45.0)) & 0xFF00) <= FLOAT_DEG_TO_IDX(90.0))
            {
                if ((player->playerFlag & PLAYER_FLAG_SLOPE_FORCE_APPLIED) != 0)
                {
                    player->playerFlag &= ~PLAYER_FLAG_SLOPE_FORCE_APPLIED;
                    return;
                }

                player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, deceleration);
            }
        }
    }
    else
    {
        if ((player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0 || !gmCheckMissionType(MISSION_TYPE_FIND_MEDAL))
        {
            if (acceleration < FLOAT_TO_FX32(0.125))
                acceleration = FLOAT_TO_FX32(0.125);

            if ((player->inputKeyDown & PAD_KEY_LEFT) != 0) // if player is holding left
            {
                player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, deceleration);
            }
            else if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0) // if player is holding right
            {
                player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, acceleration, topSpeed);
            }
            else // if player is holding neither left/right
            {
                player->boostTimer = 0;

                fx32 velXMax      = (topSpeed >> 1) + (topSpeed >> 2);
                fx32 groundVelMax = (acceleration >> 1) + (acceleration >> 2);
                if (player->objWork.groundVel < FLOAT_TO_FX32(6.0))
                {
                    player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, groundVelMax, FLOAT_TO_FX32(6.0));
                }
                else if (player->objWork.groundVel > topSpeed)
                {
                    player->objWork.groundVel = -ObjSpdUpSet(-player->objWork.groundVel, acceleration, topSpeed);
                }

                if (player->objWork.velocity.x > velXMax)
                    player->objWork.velocity.x = velXMax;
            }

            if (player->objWork.groundVel < FLOAT_TO_FX32(4.0))
                player->objWork.groundVel = FLOAT_TO_FX32(4.0);
        }
    }

    Player__HandleZMovement(player);
}

void Player__HandleAirMovement(Player *player)
{
    fx32 airAcceleration;
    fx32 grndDeceleration  = player->deceleration;
    fx32 acceleration      = player->acceleration;
    fx32 topSpeed          = player->topSpeed;
    fx32 deceleration      = player->deceleration;
    player->activeTopSpeed = 0;

    if ((player->playerFlag & PLAYER_FLAG_BOOST) != 0)
        topSpeed = player->topSpeed_Boost;

    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        acceleration = player->acceleration_SuperBoost;
        deceleration = player->deceleration_SuperBoost;
        topSpeed     = player->topSpeed_SuperBoost;
    }

    Player__HandleBoost(player);

    if (player->trickFinishHorizFreezeTimer == 0)
    {
        if (((player->objWork.dir.z + FLOAT_DEG_TO_IDX(45.0)) & FLOAT_DEG_TO_IDX(270.0)) != 0 || player->objWork.dir.z == FLOAT_DEG_TO_IDX(315.0))
            deceleration >>= 2;

        if (player->overSpeedLimitTimer)
        {
            airAcceleration = acceleration >> 2;
            deceleration    = 0;
        }
        else
        {
            fx32 accel = 0;
            if (MATH_ABS(player->objWork.velocity.x) > player->spdThresholdJog)
            {
                fx32 div = FX_Div(MATH_ABS(player->objWork.velocity.x) - player->spdThresholdJog, topSpeed - player->spdThresholdJog);
                if (div > FLOAT_TO_FX32(1.0))
                    div = FLOAT_TO_FX32(1.0);

                accel = (FLOAT_TO_FX32(0.96875) * div) >> FX32_SHIFT;
            }

            airAcceleration = acceleration - MultiplyFX(acceleration, accel);
        }

        if ((player->playerFlag & PLAYER_GIMMICK_4000000) != 0)
        {
            if (!IsBossStage())
                airAcceleration >>= 1;

            if (!IsBossStage())
                deceleration >>= 1;
        }

        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            if ((player->inputKeyDown & (PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0)
            {
                if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0) // if player is holding right
                {
                    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

                    if (player->objWork.velocity.x < 0)
                        player->objWork.velocity.x = ObjSpdDownSet(player->objWork.velocity.x, 2 * deceleration);

                    if (player->objWork.groundVel < 0)
                        player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, 2 * grndDeceleration);

                    player->objWork.velocity.x = ObjSpdUpSet(player->objWork.velocity.x, airAcceleration, topSpeed);
                }
                else // if player is holding left
                {
                    player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

                    if (player->objWork.velocity.x > 0)
                        player->objWork.velocity.x = ObjSpdDownSet(player->objWork.velocity.x, 2 * deceleration);

                    if (player->objWork.groundVel > 0)
                        player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, 2 * grndDeceleration);

                    player->objWork.velocity.x = ObjSpdUpSet(player->objWork.velocity.x, -airAcceleration, topSpeed);
                }
            }
            else // if player is holding neither left/right
            {
                player->objWork.velocity.x = ClampS32(player->objWork.velocity.x, -topSpeed, topSpeed);
                player->objWork.groundVel = ((player->objWork.groundVel < -topSpeed) ? -topSpeed : ((player->objWork.groundVel > topSpeed) ? topSpeed : player->objWork.groundVel));

                player->boostTimer         = 0;
                player->objWork.velocity.x = ObjSpdDownSet(player->objWork.velocity.x, deceleration);
                player->objWork.groundVel  = ObjSpdDownSet(player->objWork.groundVel, grndDeceleration);
            }
        }
        else
        {
            if ((player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0 || !gmCheckMissionType(MISSION_TYPE_FIND_MEDAL))
            {
                if (airAcceleration < FLOAT_TO_FX32(0.125))
                    airAcceleration = FLOAT_TO_FX32(0.125);

                if ((player->inputKeyDown & PAD_KEY_LEFT) != 0) // if player is holding left
                {
                    // slow it dowwwn...
                    player->objWork.velocity.x = ObjSpdDownSet(player->objWork.velocity.x, deceleration);
                    if (player->objWork.velocity.x < FLOAT_TO_FX32(4.0))
                        player->objWork.velocity.x = FLOAT_TO_FX32(4.0);
                }
                else if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0) // if player is holding right
                {
                    // go even faster!!
                    player->objWork.velocity.x = ObjSpdUpSet(player->objWork.velocity.x, airAcceleration, topSpeed);
                }
                else // if player is holding neither left/right
                {
                    player->boostTimer = 0;

                    if ((player->playerFlag & PLAYER_FLAG_ALLOW_TRICKS) == 0)
                    {
                        fx32 groundVelMax = (topSpeed >> 1) + (topSpeed >> 2);
                        fx32 velXMax      = (airAcceleration >> 1) + (airAcceleration >> 2);

                        if (player->objWork.velocity.x < FLOAT_TO_FX32(6.0))
                        {
                            player->objWork.velocity.x = ObjSpdUpSet(player->objWork.velocity.x, velXMax, FLOAT_TO_FX32(6.0));
                        }
                        else if (player->objWork.velocity.x > topSpeed)
                        {
                            player->objWork.velocity.x = -ObjSpdUpSet(-player->objWork.velocity.x, airAcceleration, topSpeed);
                        }

                        if (player->objWork.groundVel > groundVelMax)
                            player->objWork.groundVel = groundVelMax;
                    }
                }
            }
        }

        Player__HandleZMovement(player);
    }
}

void Player__HandleRollingForces(Player *player)
{
    if (player->overSpeedLimitTimer != 0)
    {
        player->overSpeedLimitTimer--;
        player->objWork.slopeAcceleration = 0;
    }
    else
    {
        player->objWork.slopeAcceleration = playerPhysicsTable[player->characterID].rollSlopeAcceleration;
        player->objWork.slopeDirection    = FLOAT_TO_FX32(1.0);
    }

    if (player->objWork.groundVel > 0 && (player->inputKeyDown & PAD_KEY_RIGHT) != 0 || player->objWork.groundVel < 0 && (player->inputKeyDown & PAD_KEY_LEFT) != 0)
    {
        player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, player->rollingDeceleration >> 1);
    }
    else if ((player->objWork.groundVel <= 0 || (player->inputKeyDown & PAD_KEY_RIGHT) == 0) && (player->objWork.groundVel >= 0 || (player->inputKeyDown & PAD_KEY_LEFT) == 0))
    {
        player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, player->rollingDeceleration << 1);
    }
    else
    {
        player->objWork.groundVel = ObjSpdDownSet(player->objWork.groundVel, player->rollingDeceleration);
    }
}

void Player__OnDefend_Regular(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player = (Player *)rect2->parent;

    if (player->trickFinishHorizFreezeTimer != 0)
        return;

    if (gmCheckVsBattleFlag() && rect1->parent != NULL && ((Player *)rect1->parent)->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        if ((player->colliders[1].flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) != 0)
        {
            if ((player->playerFlag & PLAYER_FLAG_40000000) == 0)
            {
                if (player->actionState >= PLAYER_ACTION_ROLL && player->actionState <= PLAYER_ACTION_SPINDASH_CHARGE)
                {
                    Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);

                    fx32 animVelocity;
                    if (player->characterID == CHARACTER_BLAZE)
                        animVelocity = FLOAT_TO_FX32(4.0);
                    else
                        animVelocity = FLOAT_TO_FX32(8.0);

                    Player__SetAnimSpeedFromVelocity(player, animVelocity);
                    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }

                Player__Action_AttackRecoil(player);
                player->playerFlag |= PLAYER_FLAG_40000000;
            }
            return;
        }

        if (player->stageTimerStore + 10 >= playerGameStatus.stageTimer)
            return;

        player->playerFlag |= PLAYER_FLAG_DO_ATTACK_RECOIL;
    }

    fx32 velocity;
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
        velocity = player->objWork.velocity.x;
    else
        velocity = player->objWork.groundVel;

    if ((rect1->hitFlag & 8) != 0)
    {
        // play spike sfx
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TOGE);
    }

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        Player__GiveTension(player, -PLAYER_TENSION_HURT_PENALTY);
        UpdateTensionGaugeHUD(player->tension >> 4, TRUE);
    }

    if (!gmCheckStage(STAGE_TUTORIAL))
    {
        if ((rect1->hitFlag & 4) != 0)
        {
            if (player->rings != 0)
            {
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
                CreateLoseRingEffect(player, player->rings);
            }

            Player__Action_Die(player);
            return;
        }

        if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0 && player->rings == 0)
        {
            Player__Action_Die(player);
            return;
        }
    }

    u32 prevFlag = player->gimmickFlag;
    Player__InitState(player);
    player->gimmickFlag |= prevFlag & PLAYER_GIMMICK_40000;

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        if (player->rings != 0)
        {
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
        }

        if (!gmCheckVsBattleFlag())
        {
            CreateLoseRingEffect(player, player->rings);
        }
        else
        {
            CreateLoseRingEffect(player, 10);
            player->playerFlag |= PLAYER_FLAG_DO_LOSE_RING_EFFECT;
        }
    }

    player->playerFlag &= ~(PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR);
    ShakeScreen(SCREENSHAKE_C_SHORT);

    player->blinkTimer            = player->hurtInvulnDuration;
    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if (MATH_ABS(velocity) >= player->spdThresholdRun)
            Player__ChangeAction(player, PLAYER_ACTION_HURT_TUMBLE);
        else
            Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);

        if (MATH_ABS(velocity) < FLOAT_TO_FX32(1.5))
            velocity = 0;

        player->objWork.velocity.x = FLOAT_TO_FX32(1.5);
        player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
        player->objWork.groundVel  = FLOAT_TO_FX32(0.0);

        if (player->actionState == PLAYER_ACTION_HURT_TUMBLE)
        {
            player->objWork.velocity.x = velocity >> 1;
        }
        else
        {
            if (velocity > 0)
            {
                player->objWork.velocity.x = -player->objWork.velocity.x;
            }
            else if (velocity == 0 && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            {
                player->objWork.velocity.x = -player->objWork.velocity.x;
            }
        }

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
        SetTaskState(&player->objWork, Player__State_Hurt);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_HURT_SNOWBOARD);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_HURT);

        player->objWork.velocity.x = velocity >> 2;
        player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
        player->objWork.groundVel  = 0;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
        player->objWork.userTimer = 32;
        SetTaskState(&player->objWork, Player__State_HurtSnowboard);
    }

    switch (player->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OWA);
            break;

        case CHARACTER_BLAZE:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
            break;
    }
}

void Player__Hurt(Player *player)
{
    if (player->trickFinishHorizFreezeTimer != 0 || player->objWork.hitstopTimer != 0)
        return;

    fx32 velocity;
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
        velocity = player->objWork.velocity.x;
    else
        velocity = player->objWork.groundVel;

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        Player__GiveTension(player, -PLAYER_TENSION_HURT_PENALTY);
        UpdateTensionGaugeHUD(player->tension >> 4, 1);
    }

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0 && player->rings == 0)
    {
        Player__Action_Die(player);
    }
    else
    {
        u32 prevFlag = player->gimmickFlag;
        Player__InitState(player);
        player->gimmickFlag |= prevFlag & PLAYER_GIMMICK_40000;

        if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
        {
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
            CreateLoseRingEffect(player, player->rings);
        }

        player->playerFlag &= ~(PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR);
        ShakeScreen(SCREENSHAKE_C_SHORT);

        player->blinkTimer            = player->hurtInvulnDuration;
        player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            if (MATH_ABS(velocity) >= player->spdThresholdRun)
                Player__ChangeAction(player, PLAYER_ACTION_HURT_TUMBLE);
            else
                Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);

            if (MATH_ABS(velocity) < FLOAT_TO_FX32(1.5))
                velocity = 0;

            player->objWork.velocity.x = FLOAT_TO_FX32(1.5);
            player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
            player->objWork.groundVel  = FLOAT_TO_FX32(0.0);

            if (player->actionState == PLAYER_ACTION_HURT_TUMBLE)
            {
                player->objWork.velocity.x = velocity >> 1;
            }
            else
            {
                if (velocity > 0)
                {
                    player->objWork.velocity.x = -player->objWork.velocity.x;
                }
                else if (velocity == 0 && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                {
                    player->objWork.velocity.x = -player->objWork.velocity.x;
                }
            }

            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
            player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
            SetTaskState(&player->objWork, Player__State_Hurt);
        }
        else
        {
            Player__ChangeAction(player, PLAYER_ACTION_HURT_SNOWBOARD);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_HURT);

            player->objWork.velocity.x = velocity >> 2;
            player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
            player->objWork.groundVel  = 0;
            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
            player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
            player->objWork.userTimer = 32;
            SetTaskState(&player->objWork, Player__State_HurtSnowboard);
        }

        switch (player->characterID)
        {
            // case CHARACTER_SONIC:
            default:
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OWA);
                break;

            case CHARACTER_BLAZE:
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
                break;
        }
    }
}

void Player__Action_Boost(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0 && (player->playerFlag & PLAYER_FLAG_BOOST) == 0)
    {
        player->boostEndTimer = 0;
        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
            CreateEffectBoostStartFX(player, 0, 0);

        player->cameraScrollDelay = PLAYER_BOOST_SCROLL_DELAY;
        player->playerFlag |= PLAYER_FLAG_BOOST;
        player->boostTimer = PLAYER_BOOST_DURATION;

        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
        {
            switch (player->characterID)
            {
                // case CHARACTER_SONIC:
                default:
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOAST_ON);
                    break;

                case CHARACTER_BLAZE:
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_BOAST_ON);
                    break;
            }
        }
    }
}

void Player__Action_StopBoost(Player *player)
{
    player->boostEndTimer = 0;
    player->boostTimer    = 0;
    player->playerFlag &= ~PLAYER_FLAG_BOOST;
}

void Player__Action_SuperBoost(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
    {
        if ((g_obj.flag & OBJECTMANAGER_FLAG_400) == 0)
            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_4000;

        if (!player->characterID && (player->gimmickFlag & PLAYER_GIMMICK_100) == 0)
            CreateEffectPlayerTrail(player, FLOAT_TO_FX32(24.0), 10, GX_RGB_888(0x28, 0x28, 0xFF), GX_RGB_888(0x28, 0x28, 0xFF));

        switch (player->characterID)
        {
            // case CHARACTER_SONIC:
            default:
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SUPERBOAST);
                break;

            case CHARACTER_BLAZE:
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_SUPERBOAST);
                break;
        }

        StopPlayerSfx(player, PLAYER_SEQPLAYER_SUPERBOOST);
        player->cameraScrollDelay = 12;
        player->playerFlag |= PLAYER_FLAG_SUPERBOOST_UNKNOWN | PLAYER_FLAG_SUPERBOOST;
        ShakeScreen(SCREENSHAKE_D_SHORT);

        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            if ((player->inputKeyDown & PAD_KEY_LEFT) != 0)
            {
                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            }
            else if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            }
        }

        CreateEffectBoostSuperStartFX(player);
        CreateEffectBoostAura(player);

        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
        {
            if (MATH_ABS(player->objWork.velocity.x) < player->topSpeed_SuperBoost)
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    player->objWork.velocity.x = -player->topSpeed_SuperBoost;
                else
                    player->objWork.velocity.x = player->topSpeed_SuperBoost;
            }
        }
        else
        {
            if (MATH_ABS(player->objWork.groundVel) < player->topSpeed_SuperBoost)
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    player->objWork.groundVel = -player->topSpeed_SuperBoost;
                else
                    player->objWork.groundVel = player->topSpeed_SuperBoost;
            }
        }

        PlayerBoost *boost = CreatePlayerBoostCollider(player, -32, -32, 32, 32, 0);
        ObjRect__SetAttackStat(&boost->collider, 2, 66);
        SetBoostColliderToTrackPlayer(boost);

        if (player->tensionMaxTimer == 0)
        {
            Player__GiveTension(player, -PLAYER_SUPERBOOST_COST);
            UpdateTensionGaugeHUD(player->tension >> 4, TRUE);
        }
        else
        {
            player->playerFlag |= PLAYER_FLAG_USED_INFINITE_TENSION;
        }
    }

    Player__Action_Boost(player);
}

void Player__Action_StopSuperBoost(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        if (player->blinkTimer == 0 && player->invincibleTimer == 0 && (player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
            player->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;

        player->superBoostCooldownTimer = PLAYER_SUPERBOOST_COOLDOWN_DURATION;

        FadeOutPlayerSfx(player, PLAYER_SEQPLAYER_SUPERBOOST, PLAYER_SUPERBOOST_SFX_FADE_DURATION);
        ReleasePlayerSfx(player, PLAYER_SEQPLAYER_SUPERBOOST);

        player->playerFlag &= ~PLAYER_FLAG_SUPERBOOST;
    }
}

PlayerBoost *CreatePlayerBoostCollider(Player *player, s16 left, s16 top, s16 right, s16 bottom, s16 timer)
{
    Task *task = CreateStageTaskFast(TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1101, TASK_GROUP(1), PlayerBoost);
    if (task == HeapNull)
        return NULL;

    PlayerBoost *work = TaskGetWork(task, PlayerBoost);
    TaskInitWork16(work);

    work->objWork.objType = STAGE_OBJ_TYPE_EFFECT;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->objWork.position.x = player->objWork.position.x;
    work->objWork.position.y = player->objWork.position.y;
    work->objWork.position.z = player->objWork.position.z;
    VEC_SetSingle(&work->objWork.scale, FLOAT_TO_FX32(1.0));
    work->objWork.parentObj = &player->objWork;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT;
    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
        ObjRect__SetGroupFlags(&work->collider, 1, 2);
    else
        ObjRect__SetGroupFlags(&work->collider, 2, 1);

    work->collider.onDefend = NULL;
    work->collider.flag |= OBS_RECT_WORK_FLAG_20;
    ObjRect__SetAttackStat(&work->collider, 2, 64);
    ObjRect__SetBox(&work->collider, left, top, right, bottom);

    if ((work->objWork.parentObj->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    SetTaskState(&work->objWork, PlayerBoostCollider_State_ActiveLifetime);
    work->objWork.userTimer = timer;

    return work;
}

BOOL Player__UseUpsideDownGravity(fx32 x, fx32 y)
{
    UNUSED(x);
    UNUSED(y);
    // leftover from rush's dead line gravity swapping gimmick

    return FALSE;
}

void Player__Func_201301C(s32 id)
{
    if (gmCheckVsBattleFlag() && id != 0 && (mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) == 0)
    {
        Player *player = gPlayerList[id];

        mapCamera.camera[player->cameraID].disp_pos.x = player->cameraDispPosStore.x;
        mapCamera.camera[player->cameraID].disp_pos.y = player->cameraDispPosStore.y;
    }
}

void Player__SetP2Offset(fx32 x, fx32 y, fx32 z)
{
    if (playerCount >= PLAYER_COUNT)
    {
        gPlayerList[1]->objWork.offset.x = x;
        gPlayerList[1]->objWork.offset.y = y;
        gPlayerList[1]->objWork.offset.z = z;
    }
}

s32 Player__GetPlayerCount(void)
{
    return playerCount;
}

void Player__Destructor(Task *task)
{
    Player *work;

    GameState *state = GetGameState();
    work             = TaskGetWork(task, Player);

    ObjDraw__PaletteTex__Process(&work->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
    ProcessTexturePaletteQueue();

    ReleasePlayerSfx(work, PLAYER_SEQPLAYER_COMMON);
    ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRIND);
    ReleasePlayerSfx(work, PLAYER_SEQPLAYER_SUPERBOOST);
    ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);

    if ((state->gameFlag & GAME_FLAG_40) != 0 && CheckIsPlayer1(work))
    {
        state->recallRingExtraLife = work->rings;
        state->recallRings         = work->ringStageCount;
        state->recallShield        = PLAYER_RECALLSHIELD_NONE;
        state->recallTime          = playerGameStatus.stageTimer;

        if ((work->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) != 0)
            state->recallShield = PLAYER_RECALLSHIELD_REGULAR;

        if ((work->playerFlag & PLAYER_FLAG_SHIELD_MAGNET) != 0)
            state->recallShield = PLAYER_RECALLSHIELD_MAGNET;

        state->recallTension    = work->tension;
        state->recallPosition.x = work->objWork.position.x;
        if (work->objWork.fallDir != 0)
            state->recallPosition.y = work->objWork.position.y - FLOAT_TO_FX32(280.0);
        else
            state->recallPosition.y = work->objWork.position.y + FLOAT_TO_FX32(280.0);
    }

    ObjDraw__PaletteTex__Release(&work->paletteTex);

    switch (work->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            break;

        case CHARACTER_BLAZE:
            AnimatorMDL__Release(&work->aniTailModel.ani);
            ObjDataRelease(work->aniTailModel.file[B3D_RESOURCE_MODEL]);
            ObjDataRelease(work->aniTailModel.file[B3D_RESOURCE_JOINT_ANIM]);
            break;
    }

    if (IsSnowboardStage())
        ObjDataRelease(&snowboardWork);

    playerCount--;
    StageTask_Destructor(task);

    if (IsSnowboardStage())
        DestroyPlayerSnowboard();
}

void Player__ReadInput(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    if (CheckIsPlayer1(work) && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_DISABLE_PLAYER_INPUTS) == 0)
        ReadPadInput(&playerGameStatus.input, GetPadButtonMask());

    if (work->inputLock != 0)
    {
        work->inputLock--;
        work->inputKeyDown   = PAD_INPUT_NONE_MASK;
        work->inputKeyPress  = PAD_INPUT_NONE_MASK;
        work->inputKeyRepeat = PAD_INPUT_NONE_MASK;
    }
    else
    {
        if ((work->playerFlag & PLAYER_FLAG_DISABLE_INPUT_READ) == 0 && CheckIsPlayer1(work))
        {
            work->inputKeyDown   = Player__ReadInputFromValue(work, playerGameStatus.input.btnDown);
            work->inputKeyPress  = Player__ReadInputFromValue(work, playerGameStatus.input.btnPress);
            work->inputKeyRepeat = Player__ReadInputFromValue(work, playerGameStatus.input.btnPressRepeat);
        }
    }
}

u16 Player__ReadInputFromValue(Player *player, u16 buttonMask)
{
    u16 mask = buttonMask & ~(PAD_BUTTON_A | PAD_BUTTON_B | PAD_KEY_RIGHT | PAD_KEY_LEFT | PAD_KEY_UP | PAD_KEY_DOWN);

    if ((buttonMask & PAD_KEY_RIGHT) != 0)
        mask |= player->keyMap.right;

    if ((buttonMask & PAD_KEY_LEFT) != 0)
        mask |= player->keyMap.left;

    if ((buttonMask & PAD_KEY_UP) != 0)
        mask |= player->keyMap.up;

    if ((buttonMask & PAD_KEY_DOWN) != 0)
        mask |= player->keyMap.down;

    if ((buttonMask & PAD_BUTTON_A) != 0)
        mask |= player->keyMap.A;

    if ((buttonMask & PAD_BUTTON_B) != 0)
        mask |= player->keyMap.B;

    return mask;
}

NONMATCH_FUNC void Player__Func_20133B8(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldrb r0, [r5, #0x5d1]
	mov r4, #4
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0x6d8]
	cmp r0, #0
	bne _020133F8
	ldr r1, [r5, #0x5dc]
	add r0, r5, #0x600
	bic r1, r1, #0x4000000
	str r1, [r5, #0x5dc]
	mov r1, #0
	strh r1, [r0, #0xe4]
	strh r1, [r0, #0xe6]
_020133F8:
	bl MapSys__GetDispSelect
	cmp r0, #0
	movne r3, #0x58
	ldr r0, [r5, #0x5dc]
	moveq r3, #0x60
	mov r2, #0x80
	tst r0, #0x800
	subne r0, r2, #0x20
	movne r0, r0, lsl #0x10
	movne r2, r0, asr #0x10
	add r0, r5, #0x600
	ldrsb r0, [r0, #0xab]
	cmp r0, #0
	beq _02013458
	sub r0, r0, #1
	strb r0, [r5, #0x6ab]
	ldr r6, [r5, #0x6b4]
	ldr r0, [r5, #0xbc]
	ldr r4, [r5, #0x6b8]
	ldr r1, [r5, #0xc0]
	add r0, r6, r0, lsl #4
	add r1, r4, r1, lsl #4
	mov r4, #2
	b _020134BC
_02013458:
	ldr r0, [r5, #0x114]
	mov ip, #0
	mov lr, ip
	cmp r0, #0
	ldrne ip, [r0, #0xbc]
	ldr r1, [r5, #0x44]
	ldrne lr, [r0, #0xc0]
	ldr r0, [r5, #0x48]
	ldr r6, [r5, #0x8c]
	sub r1, r1, ip
	sub r6, r6, r1
	ldr r1, [r5, #0x90]
	sub r0, r0, lr
	sub r1, r1, r0
	movs r0, r6, lsl #4
	rsbmi r6, r0, #0
	movpl r6, r0
	cmp r6, #0x10000
	mov r1, r1, lsl #3
	movlt r0, #0
	cmp r1, #0
	rsblt r6, r1, #0
	movge r6, r1
	cmp r6, #0x28000
	movlt r1, #0
_020134BC:
	ldr r6, [r5, #0x5dc]
	tst r6, #0x800
	bne _0201351C
	ldr r6, [r5, #0x5d8]
	tst r6, #0x80
	addeq ip, r5, #0x600
	ldreqsb r6, [ip, #0xab]
	cmpeq r6, #0
	beq _0201351C
	cmp r0, #0x58000
	movgt r0, #0x58000
	bgt _020134FC
	mov ip, #0x58000
	rsb ip, ip, #0
	cmp r0, ip
	movlt r0, ip
_020134FC:
	cmp r1, #0x16000
	movgt r1, #0x16000
	bgt _02013554
	mov ip, #0x48000
	rsb ip, ip, #0
	cmp r1, ip
	movlt r1, ip
	b _02013554
_0201351C:
	cmp r0, #0x2c000
	movgt r0, #0x2c000
	bgt _02013538
	mov ip, #0x2c000
	rsb ip, ip, #0
	cmp r0, ip
	movlt r0, ip
_02013538:
	cmp r1, #0xb000
	movgt r1, #0xb000
	bgt _02013554
	mov ip, #0x24000
	rsb ip, ip, #0
	cmp r1, ip
	movlt r1, ip
_02013554:
	str r0, [r5, #0x6b4]
	str r1, [r5, #0x6b8]
	ldr r0, [r5, #0x5d8]
	tst r0, #0x2000
	beq _02013584
	ldr r0, [r5, #0x6ac]
	sub r0, r0, r0, asr #2
	str r0, [r5, #0x6ac]
	ldr r0, [r5, #0x6b0]
	sub r0, r0, r0, asr #2
	str r0, [r5, #0x6b0]
	b _02013618
_02013584:
	ldr r0, [r5, #0x5dc]
	tst r0, #0x4000000
	add r0, r5, #0x600
	beq _020135E0
	ldrsh ip, [r0, #0xe0]
	ldrsh r1, [r0, #0xe4]
	ldr r6, [r5, #0x6ac]
	ldr lr, [r5, #0x6b4]
	add r1, ip, r1
	sub ip, lr, r6
	add r1, ip, r1, lsl #12
	add r1, r6, r1, asr r4
	str r1, [r5, #0x6ac]
	ldrsh r1, [r0, #0xe2]
	ldrsh r0, [r0, #0xe6]
	ldr lr, [r5, #0x6b0]
	ldr ip, [r5, #0x6b8]
	add r0, r1, r0
	sub r1, ip, lr
	add r0, r1, r0, lsl #12
	add r0, lr, r0, asr r4
	str r0, [r5, #0x6b0]
	b _02013618
_020135E0:
	ldr lr, [r5, #0x6ac]
	ldr r1, [r5, #0x6b4]
	ldrsh ip, [r0, #0xe0]
	sub r1, r1, lr
	add r1, r1, ip, lsl #12
	add r1, lr, r1, asr r4
	str r1, [r5, #0x6ac]
	ldr lr, [r5, #0x6b0]
	ldr r1, [r5, #0x6b8]
	ldrsh ip, [r0, #0xe2]
	sub r0, r1, lr
	add r0, r0, ip, lsl #12
	add r0, lr, r0, asr r4
	str r0, [r5, #0x6b0]
_02013618:
	ldr r0, [r5, #0x6ac]
	ldr r1, [r5, #0x6b0]
	add r0, r0, r2, lsl #12
	add r1, r1, r3, lsl #12
	bl MapSys__SetTargetOffsetA
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__Func_2013630(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrb r1, [r5, #0x5d1]
	cmp r1, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0x5dc]
	tst r1, #0x10
	beq _02013790
	ldrb r0, [r5, #0x5d3]
	mov r1, #0x70
	ldr r2, =mapCamera
	smulbb r1, r0, r1
	ldr r1, [r2, r1]
	tst r1, #0x40
	bne _02013670
	bl MapSys__Func_2009190
_02013670:
	ldr r2, [r5, #0x6d8]
	cmp r2, #0
	beq _02013778
	add r0, r5, #0x600
	ldrsh r1, [r0, #0xdc]
	ldr r0, [r5, #0x5dc]
	ldr r2, [r2, #0x44]
	add r1, r1, #0x80
	tst r0, #0x40
	sub r4, r2, r1, lsl #12
	beq _020136B4
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, =mapCamera+0x00000004
	smulbb r0, r2, r0
	str r4, [r1, r0]
	b _020137B8
_020136B4:
	ldr r0, =g_obj
	mov r3, #0
	ldr r0, [r0, #0x28]
	tst r0, #0x400
	beq _02013700
	mov r0, #0x2000
	str r0, [sp]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, =mapCamera+0x00000004
	smulbb r0, r2, r0
	ldr r0, [r1, r0]
	mov r1, r4
	mov r2, #4
	bl ObjShiftSet
	ldrb r3, [r5, #0x5d3]
	mov r1, #0x70
	ldr r2, =mapCamera+0x00000004
	b _02013734
_02013700:
	mov r0, #0x1000
	str r0, [sp]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, =mapCamera+0x00000004
	smulbb r0, r2, r0
	ldr r0, [r1, r0]
	mov r1, r4
	mov r2, #4
	bl ObjShiftSet
	ldrb r3, [r5, #0x5d3]
	ldr r2, =mapCamera+0x00000004
	mov r1, #0x70
_02013734:
	smulbb r1, r3, r1
	str r0, [r2, r1]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	mov r1, #0x2000
	smulbb r2, r2, r0
	ldr r0, =mapCamera+0x00000004
	rsb r1, r1, #0
	ldr r0, [r0, r2]
	and r2, r4, r1
	and r0, r0, r1
	cmp r2, r0
	bne _020137B8
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #0x40
	str r0, [r5, #0x5dc]
	b _020137B8
_02013778:
	ldr r1, [r5, #0x5dc]
	mov r0, r5
	bic r1, r1, #0x50
	str r1, [r5, #0x5dc]
	bl Player__Func_20138F4
	b _020137B8
_02013790:
	bic r1, r1, #0x40
	str r1, [r5, #0x5dc]
	ldrb r3, [r5, #0x5d3]
	mov r1, #0x70
	ldr r2, =mapCamera
	smulbb r1, r3, r1
	ldr r1, [r2, r1]
	tst r1, #0x40
	beq _020137B8
	bl Player__Func_20138F4
_020137B8:
	ldr r0, [r5, #0x5dc]
	tst r0, #0x20
	beq _020138B4
	ldrb r0, [r5, #0x5d3]
	mov r1, #0x70
	ldr r2, =mapCamera
	smulbb r1, r0, r1
	ldr r1, [r2, r1]
	tst r1, #0x80
	bne _020137E4
	bl MapSys__Func_20091B0
_020137E4:
	ldr r2, [r5, #0x6d8]
	cmp r2, #0
	beq _0201389C
	add r0, r5, #0x600
	ldrsh r1, [r0, #0xde]
	ldr r0, [r5, #0x5dc]
	ldr r2, [r2, #0x48]
	add r1, r1, #0x60
	tst r0, #0x80
	sub r4, r2, r1, lsl #12
	beq _02013828
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, =mapCamera+0x00000008
	smulbb r0, r2, r0
	str r4, [r1, r0]
	ldmia sp!, {r3, r4, r5, pc}
_02013828:
	mov r0, #0x1000
	str r0, [sp]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, =mapCamera+0x00000008
	smulbb r0, r2, r0
	ldr r0, [r1, r0]
	mov r1, r4
	mov r2, #4
	mov r3, #0
	bl ObjShiftSet
	ldrb r2, [r5, #0x5d3]
	mov r1, #0x70
	ldr r3, =mapCamera+0x00000008
	smulbb r2, r2, r1
	str r0, [r3, r2]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x2000
	rsb r0, r0, #0
	smulbb r1, r2, r1
	ldr r1, [r3, r1]
	and r2, r4, r0
	and r0, r1, r0
	cmp r2, r0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #0x80
	str r0, [r5, #0x5dc]
	ldmia sp!, {r3, r4, r5, pc}
_0201389C:
	ldr r1, [r5, #0x5dc]
	mov r0, r5
	bic r1, r1, #0xa0
	str r1, [r5, #0x5dc]
	bl Player__Func_2013948
	ldmia sp!, {r3, r4, r5, pc}
_020138B4:
	bic r0, r0, #0x80
	str r0, [r5, #0x5dc]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, =mapCamera
	smulbb r0, r2, r0
	ldr r0, [r1, r0]
	tst r0, #0x80
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl Player__Func_2013948
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Player__Func_20138F4(Player *player)
{
    MapSys__GetDispSelect();

    fx32 offset = FLOAT_TO_FX32(128.0);
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
        offset -= FLOAT_TO_FX32(32.0);

    player->cameraOffset.x = -(mapCamera.camera[player->cameraID].disp_pos.x - (player->objWork.position.x - offset));
    MapSys__Func_20091D0(player->cameraID);
}

void Player__Func_2013948(Player *player)
{
    fx32 offset;
    if (MapSys__GetDispSelect() != GX_DISP_SELECT_SUB_MAIN)
        offset = FLOAT_TO_FX32(88.0);
    else
        offset = FLOAT_TO_FX32(96.0);

    player->cameraOffset.y = -(mapCamera.camera[player->cameraID].disp_pos.y - (player->objWork.position.y - offset));
    MapSys__Func_20091F0(player->cameraID);
}

void Player__HandleCollisionBounds(Player *player)
{
    if (CheckIsPlayer1(player) && !IsBossStage())
    {
        if ((player->gimmickFlag & PLAYER_GIMMICK_200) != 0)
        {
            if (player->gimmickObj != NULL)
            {
                stageCollision.left  = FX32_TO_WHOLE(player->gimmickObj->objWork.position.x) - 108;
                stageCollision.right = FX32_TO_WHOLE(player->gimmickObj->objWork.position.x) + 108;
            }
            else
            {
                player->gimmickFlag &= ~PLAYER_GIMMICK_200;

                stageCollision.left  = 0;
                stageCollision.right = stageCollision.blockWidth << 6;
            }
        }
        else
        {
            if ((player->gimmickFlag & PLAYER_GIMMICK_8000000) != 0)
            {
                stageCollision.left  = player->gimmickMapLimitLeft;
                stageCollision.right = player->gimmickMapLimitTop;
            }
            else
            {
                stageCollision.left  = 0;
                stageCollision.right = stageCollision.blockWidth << 6;
            }
        }

        if ((player->gimmickFlag & PLAYER_GIMMICK_400) != 0)
        {
            if (player->gimmickObj != NULL)
            {
                stageCollision.top    = FX32_TO_WHOLE(player->gimmickObj->objWork.position.y) - 88;
                stageCollision.bottom = FX32_TO_WHOLE(player->gimmickObj->objWork.position.y) + 88;
            }
            else
            {
                player->gimmickFlag &= ~PLAYER_GIMMICK_400;

                stageCollision.top    = 0;
                stageCollision.bottom = stageCollision.blockHeight << 6;
            }
        }
        else
        {
            if ((player->gimmickFlag & PLAYER_GIMMICK_10000000) != 0)
            {
                stageCollision.top    = player->gimmickMapLimitRight;
                stageCollision.bottom = player->gimmickMapLimitBottom;
            }
            else
            {
                stageCollision.top    = 0;
                stageCollision.bottom = stageCollision.blockHeight << 6;
            }
        }
    }
}

void Player__In_Default(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    if (gameState.gameMode == GAMEMODE_TIMEATTACK)
        Player__WriteGhostFrame(work);

    Player__ReceivePacket(work);
    Player__ReadGhostFrame(work);

    if ((work->gimmickFlag & PLAYER_GIMMICK_200000) != 0)
    {
        work->gimmickFlag &= ~PLAYER_GIMMICK_200000;

        s32 left, top, right, bottom;
        if (work->objWork.position.y > MapSys__GetScreenSwapPos(work->objWork.position.x))
        {
            // bottom screen
            left   = FX32_TO_WHOLE(work->objWork.position.x) - HW_LCD_WIDTH;
            top    = FX32_TO_WHOLE(work->objWork.position.y) - ((2 * HW_LCD_HEIGHT) + 96);
            right  = FX32_TO_WHOLE(work->objWork.position.x) + HW_LCD_WIDTH;
            bottom = FX32_TO_WHOLE(work->objWork.position.y) + ((1 * HW_LCD_HEIGHT) + 96);
        }
        else
        {
            // top screen
            left   = FX32_TO_WHOLE(work->objWork.position.x) - HW_LCD_WIDTH;
            top    = FX32_TO_WHOLE(work->objWork.position.y) - ((1 * HW_LCD_HEIGHT) + 96);
            right  = FX32_TO_WHOLE(work->objWork.position.x) + HW_LCD_WIDTH;
            bottom = FX32_TO_WHOLE(work->objWork.position.y) + ((2 * HW_LCD_HEIGHT) + 96);
        }

        left   = ClampS32(left, 0x0000, 0xFFFF);
        top    = ClampS32(top, 0x0000, 0xFFFF);
        right  = ClampS32(right, 0x0000, 0xFFFF);
        bottom = ClampS32(bottom, 0x0000, 0xFFFF);

        EventManager__CreateEventsUnknown(left, top, right, bottom);
    }

    Player__HandleCollisionBounds(work);
    Player__HandleGravitySwapping(work);
    Player__ReadInput();

    if (work->gimmickObj && IsStageTaskDestroyed(&work->gimmickObj->objWork))
        work->gimmickObj = NULL;

    if (work->grindID != PLAYER_GRIND_NONE)
    {
        if ((work->actionState < PLAYER_ACTION_GRIND || work->actionState > PLAYER_ACTION_GRINDTRICK_3_03) && (work->gimmickFlag & PLAYER_GIMMICK_4) == 0
            && (work->grindPrevRide & 2) != 0)
        {
            work->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
            work->objWork.flag |= work->grindPrevRide & 1;
            work->grindPrevRide = PLAYER_GRIND_NONE;
            if ((work->grindID & PLAYER_GRIND_ACTIVE) == 0)
                work->grindID = PLAYER_GRIND_NONE;
        }

        work->gimmickFlag &= ~PLAYER_GIMMICK_4;
    }

    if (work->overSpeedLimitTimer != 0)
        work->overSpeedLimitTimer--;

    if (work->unknownTimer != 0)
        work->unknownTimer--;

    if (work->comboTensionTimer != 0)
        work->comboTensionTimer--;

    if (work->confusionTimer)
    {
        if ((work->confusionTimer & 0x7F) == 0)
        {
            ChangePlayerKeyMap(work);
        }

        work->confusionTimer--;
        if (work->confusionTimer == 0)
        {
            work->keyMap.up   = PAD_KEY_UP;
            work->keyMap.down = PAD_KEY_DOWN;
            if (Player__UseUpsideDownGravity(work->objWork.position.x, work->objWork.position.y))
            {
                work->keyMap.left  = PAD_KEY_RIGHT;
                work->keyMap.right = PAD_KEY_LEFT;
            }
            else
            {
                work->keyMap.left  = PAD_KEY_LEFT;
                work->keyMap.right = PAD_KEY_RIGHT;
            }
        }
    }

    if (work->slomoTimer != 0)
    {
        work->slomoTimer--;

        work->topSpeed              = playerPhysicsTable[work->characterID].topSpeed >> 2;
        work->topSpeed_SuperBoost   = playerPhysicsTable[work->characterID].topSpeed_SuperBoost >> 1;
        work->objWork.maxSlopeSpeed = playerPhysicsTable[work->characterID].maxSlopeSpeed >> 2;
        work->minBoostVelocity      = playerPhysicsTable[work->characterID].minBoostVelocity >> 2;

        if (work->slomoTimer == 0)
        {
            work->topSpeed              = playerPhysicsTable[work->characterID].topSpeed;
            work->topSpeed_SuperBoost   = playerPhysicsTable[work->characterID].topSpeed_SuperBoost;
            work->objWork.maxSlopeSpeed = playerPhysicsTable[work->characterID].maxSlopeSpeed;
            work->minBoostVelocity      = playerPhysicsTable[work->characterID].minBoostVelocity;
        }
    }

    if (work->itemBoxDisableTimer != 0)
        work->itemBoxDisableTimer--;

    if (work->blinkTimer != 0)
    {
        work->blinkTimer--;

        if ((work->blinkTimer & 2) != 0)
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
        else
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;

        work->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
        if (work->blinkTimer == 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            if ((work->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
                work->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;
        }
    }

    if (CheckIsPlayer1(work))
    {
        if (work->tensionMaxTimer != 0)
        {
            if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
                work->tensionMaxTimer--;

            if ((work->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
            {
                if (work->tensionMaxTimer == 0)
                {
                    EnableHUDTensionMaxEffect(FALSE);
                    ObjDraw__PaletteTex__Process(&work->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
                    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TMAX_BONUS);
                }
                else
                {
                    EnableHUDTensionMaxEffect(TRUE);

                    if ((playerGameStatus.stageTimer & 0x40) != 0)
                    {
                        u8 color = ((playerGameStatus.stageTimer >> 1) & 0x1F);

                        u32 r = color << 8;
                        u32 g = ((u32)color >> 1) << 8;
                        u32 b = -((u32)color >> 1) << 8;

                        ObjDraw__PaletteTex__Process(&work->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                    else
                    {
                        u8 color = (playerGameStatus.stageTimer >> 1) & 0x1F;

                        u32 r = ((0x1F - color)) << 8;
                        u32 g = ((u32)(0x1F - color) >> 1) << 8;
                        u32 b = -((u32)(0x1F - color) >> 1) << 8;

                        ObjDraw__PaletteTex__Process(&work->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                }
            }
        }
        else
        {
            EnableHUDTensionMaxEffect(FALSE);
        }
    }

    if (work->invincibleTimer != 0)
    {
        work->waterTimer = 0;
        work->invincibleTimer--;

        work->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
        work->colliders[0].hitPower = PLAYER_HITPOWER_INVINCIBLE;
        work->colliders[0].hitFlag |= 2;

        if ((work->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
        {
            if ((playerGameStatus.stageTimer & 0xE) == 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
            {
                ObjDraw__PaletteTex__Process(&work->paletteTex, GX_COLOR_FROM_888(0xFF), GX_COLOR_FROM_888(0xFF), GX_COLOR_FROM_888(0xFF));
            }
            else
            {
                if (work->tensionMaxTimer == 0)
                    ObjDraw__PaletteTex__Process(&work->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
            }
        }

        if (work->invincibleTimer == 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;

            if ((work->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
                work->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;
            work->colliders[0].hitPower = PLAYER_HITPOWER_NORMAL;
            work->colliders[0].hitFlag &= ~2;

            ObjDraw__PaletteTex__Process(&work->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
        }
    }

    if (work->hyperTrickTimer != 0)
    {
        work->hyperTrickTimer--;
        if (work->hyperTrickTimer == 0)
        {
            if ((!StageTaskStateMatches(&work->objWork, Player__State_Spindash) && !StageTaskStateMatches(&work->objWork, Player__State_Roll)
                 && !StageTaskStateMatches(&work->objWork, Player__State_GroundMove))
                || (work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
            {
                work->objWork.obj_3d->ani.speedMultiplier  = FLOAT_TO_FX32(1.0);
                work->objWork.obj_2d->ani.work.animAdvance = work->objWork.obj_3d->ani.speedMultiplier;

                if (playerTailAnimForAction[work->characterID] != NULL)
                    work->aniTailModel.ani.speedMultiplier = FLOAT_TO_FX32(1.0);
            }
            else
            {
                if (work->actionState == PLAYER_ACTION_HOMING_ATTACK)
                {
                    fx32 velocity;
                    if (work->characterID == CHARACTER_BLAZE)
                        velocity = FLOAT_TO_FX32(4.0);
                    else
                        velocity = FLOAT_TO_FX32(8.0);
                    Player__SetAnimSpeedFromVelocity(work, velocity);
                }
            }
        }
    }

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0 && (work->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0
        && FX32_TO_WHOLE(work->objWork.position.y) >= mapCamera.camControl.height - 26)
    {
        Player__Action_Die(work);
    }

    Player__HandleWaterEntry(work);
    Player__HandleHomingTarget(work);
    Player__HandleGroundCollisions(work);
    Player__HandleSuperBoost(work);
    Player__HandleGrinding(work);
    Player__HandleTensionDrain(work);
    Player__HandleMaxPush(work);
    Player__HandleMissionComplete(work);
    Player__HandlePressure(work);
    Player__HandleTimeLimits(work);
}

void Player__Last_Default(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    if (work->tensionMaxTimer == 0 && (work->playerFlag & PLAYER_FLAG_USED_INFINITE_TENSION) != 0)
    {
        Player__GiveTension(work, -PLAYER_TENSION_PER_LEVEL);
        work->playerFlag &= ~PLAYER_FLAG_USED_INFINITE_TENSION;
    }

    HandleRingMagnetEffect(work);
    Player__Func_2013630(work);
    Player__Func_20133B8(work);

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0 && (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_4000) == 0)
        work->overSpeedLimitTimer = 0;

    if ((work->gimmickObj == NULL || (work->gimmickFlag & PLAYER_GIMMICK_8) != 0) && (work->playerFlag & PLAYER_FLAG_SUPERBOOST_UNKNOWN) == 0)
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_4000;

    if ((work->playerFlag & PLAYER_FLAG_SUPERBOOST_UNKNOWN) != 0)
        work->playerFlag &= ~PLAYER_FLAG_SUPERBOOST_UNKNOWN;

    if (gmCheckGameMode(GAMEMODE_VS_BATTLE) && CheckIsPlayer1(work))
    {
        if (gameState.vsBattleType == VSBATTLE_RINGS)
        {
            if (playerGameStatus.stageTimer >= AKUTIL_TIME_TO_FRAMES(2, 00, 00) && IsDrawFadeTaskFinished())
            {
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
                return;
            }
        }
        else if (playerGameStatus.stageTimer >= AKUTIL_TIME_TO_FRAMES(9, 59, 99) && IsDrawFadeTaskFinished())
        {
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
            return;
        }
    }

    if ((work->gimmickFlag & PLAYER_GIMMICK_1000) != 0)
    {
        work->gimmickFlag &= ~PLAYER_GIMMICK_1000;
        work->gimmickFlag |= PLAYER_GIMMICK_80000;

        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    }
    else if ((work->gimmickFlag & PLAYER_GIMMICK_80000) != 0)
    {
        work->gimmickFlag &= ~PLAYER_GIMMICK_BUNGEE;
        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        {
            work->objWork.position.z = ObjSpdDownSet(work->objWork.position.z, FLOAT_TO_FX32(2.0));
            work->objWork.velocity.z = ObjSpdDownSet(work->objWork.velocity.z, FLOAT_TO_FX32(0.5));
        }
    }

    if ((work->playerFlag & PLAYER_GIMMICK_2000000) != 0)
    {
        work->objWork.gravityStrength  = playerPhysicsTable[work->characterID].gravityStrength;
        work->objWork.terminalVelocity = playerPhysicsTable[work->characterID].terminalVelocity;

        work->playerFlag &= ~PLAYER_GIMMICK_2000000;

        if ((work->playerFlag & PLAYER_FLAG_IN_WATER) != 0 && !IsBossStage())
            work->objWork.gravityStrength >>= 1;
    }

    if ((work->gimmickFlag & PLAYER_GIMMICK_2000) != 0)
    {
        work->gimmickFlag &= ~PLAYER_GIMMICK_2000;
        work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    }

    if ((work->gimmickFlag & PLAYER_GIMMICK_10000) != 0)
    {
        work->gimmickFlag &= ~PLAYER_GIMMICK_10000;
        work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    }

    if ((work->gimmickFlag & PLAYER_GIMMICK_40000) != 0 && gmCheckVsBattleFlag() && CheckIsPlayer1(work))
    {
        StageTask *objWork = &work->gimmickObj->objWork;

        s32 left, top, right, bottom;

        left   = FX32_TO_WHOLE(objWork->position.x) - (HW_LCD_WIDTH - 68);
        top    = FX32_TO_WHOLE(objWork->position.y) - ((2 * HW_LCD_HEIGHT) + 80);
        right  = FX32_TO_WHOLE(objWork->position.x) + (HW_LCD_WIDTH - 68);
        bottom = FX32_TO_WHOLE(objWork->position.y) + ((1 * HW_LCD_HEIGHT) + 80);

        left   = ClampS32(left, 0x0000, 0xFFFF);
        top    = ClampS32(top, 0x0000, 0xFFFF);
        right  = ClampS32(right, 0x0000, 0xFFFF);
        bottom = ClampS32(bottom, 0x0000, 0xFFFF);

        EventManager__CreateEventsUnknown(left, top, right, bottom);
    }

    if (work->prevClingWeight != 0 && work->clingWeight == 0)
        Player__InitPhysics(work);

    work->prevClingWeight = work->clingWeight;
    work->clingWeight     = 0;

    Player__SendPacket(work);
    work->playerFlag &= ~(PLAYER_FLAG_DO_LOSE_RING_EFFECT | PLAYER_FLAG_DO_ATTACK_RECOIL);

    if ((work->colliders[1].flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) == 0 && (work->playerFlag & PLAYER_FLAG_40000000) != 0)
    {
        work->playerFlag &= ~PLAYER_FLAG_40000000;
        if (CheckIsPlayer1(work))
            work->stageTimerStore = playerGameStatus.stageTimer;
    }

    Player__HandleLapEventManager(work);

    if (CheckIsPlayer1(work))
        SetSpatialAudioOriginPosition(&work->objWork.position);
}

void Player__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, Player *player)
{
    if (block->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        if (block->id <= 1)
        {
            player->colliders[block->id].parent = &player->objWork;
            ObjRect__SetBox3D(&player->colliders[block->id].rect, block->hitbox.left, block->hitbox.top, -4, block->hitbox.right, block->hitbox.bottom, 4);
        }
    }
}

void Player__Draw(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    if ((work->playerFlag & PLAYER_FLAG_IN_WATER) != 0 && !IsBossStage())
    {
        NNS_G3dGlbLightColor(GX_LIGHTID_0, GX_RGB_888(0xA8, 0xB8, 0xF8));
        NNS_G3dGlbLightColor(GX_LIGHTID_1, GX_RGB_888(0x40, 0x50, 0x88));
        NNS_G3dGlbLightColor(GX_LIGHTID_2, GX_RGB_888(0x00, 0x10, 0x40));
    }

    StageTask__Draw3D(&work->objWork, &work->objWork.obj_3d->ani.work);

    if ((work->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
        StageTask__Draw3D(&work->objWork, &work->aniTailModel.ani.work);

    if ((work->playerFlag & PLAYER_FLAG_IN_WATER) != 0 && !IsBossStage())
        InitStageLightConfig();

    if (!IsBossStage() && CheckIsPlayer1(work))
        Player__DrawAfterImages();

    StageDisplayFlags oldFlags = work->objWork.displayFlag;
    work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
    work->objWork.displayFlag = oldFlags;
}

void Player__DrawAfterImages(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    u32 displayFlag = work->objWork.displayFlag;

    if (work->objWork.obj_3d != NULL)
    {
        if (CheckIsPlayer1(work) && work->invincibleTimer == 0)
        {
            if ((GX_GetVCount() < 60 || (work->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) != 0 || (GetSystemFrameCounter() & 3) == 0)
                && (work->trickFinishHorizFreezeTimer != 0
                    || (StageTaskStateMatches(&work->objWork, Player__State_HomingAttack) || (work->playerFlag & PLAYER_FLAG_BOOST) != 0)
                           && (work->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0))
            {
                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        NNS_G3dGlbLightColor(GX_LIGHTID_0, GX_RGB_888(0x10, 0x60, 0xC0));
                        NNS_G3dGlbLightColor(GX_LIGHTID_1, GX_RGB_888(0x10, 0x60, 0xC0));
                        NNS_G3dGlbLightColor(GX_LIGHTID_2, GX_RGB_888(0x10, 0x60, 0xC0));
                        break;

                    case CHARACTER_BLAZE:
                        NNS_G3dGlbLightColor(GX_LIGHTID_0, GX_RGB_888(0xC0, 0xA0, 0x30));
                        NNS_G3dGlbLightColor(GX_LIGHTID_1, GX_RGB_888(0xC0, 0xA0, 0x30));
                        NNS_G3dGlbLightColor(GX_LIGHTID_2, GX_RGB_888(0xC0, 0xA0, 0x30));
                        break;
                }

                work->objWork.displayFlag |= DISPLAY_FLAG_NO_ANIMATE_CB | DISPLAY_FLAG_PAUSED;
                if ((work->playerFlag & PLAYER_FLAG_80000000) != 0)
                {
                    work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_ANIMATE_CB;
                    work->playerFlag &= ~PLAYER_FLAG_80000000;
                }

                if ((work->afterImageTimer & 1) != 0)
                {
                    if ((work->afterImageTimer & 2) != 0)
                    {
                        if (MATH_ABS(work->objWork.position.x - work->afterImagePos[0].x) >= FLOAT_TO_FX32(2.0)
                            || MATH_ABS(work->objWork.position.y - work->afterImagePos[0].y) >= FLOAT_TO_FX32(2.0))
                        {
                            StageTask__Draw3DEx(&work->aniPlayerModel.ani.work, &work->afterImagePos[0], &work->objWork.dir, &work->objWork.scale, &work->objWork.displayFlag, NULL,
                                                NULL, NULL);
                        }
                    }
                    else
                    {
                        if (MATH_ABS(work->objWork.position.x - work->afterImagePos[1].x) >= FLOAT_TO_FX32(2.0)
                            || MATH_ABS(work->objWork.position.y - work->afterImagePos[1].y) >= FLOAT_TO_FX32(2.0))
                        {
                            StageTask__Draw3DEx(&work->aniPlayerModel.ani.work, &work->afterImagePos[1], &work->objWork.dir, &work->objWork.scale, &work->objWork.displayFlag, NULL,
                                                NULL, NULL);
                        }
                    }
                }
                else
                {
                    if (MATH_ABS(work->objWork.position.x - work->objWork.prevPosition.x) >= FLOAT_TO_FX32(2.0)
                        || MATH_ABS(work->objWork.position.y - work->objWork.prevPosition.y) >= FLOAT_TO_FX32(2.0))
                    {
                        StageTask__Draw3DEx(&work->aniPlayerModel.ani.work, &work->objWork.prevPosition, &work->objWork.dir, &work->objWork.scale, &work->objWork.displayFlag, NULL,
                                            NULL, NULL);
                    }
                }

                InitStageLightConfig();
                work->afterImageTimer++;
                work->objWork.displayFlag = displayFlag;
            }

            work->afterImagePos[1].x = work->afterImagePos[0].x;
            work->afterImagePos[1].y = work->afterImagePos[0].y;
            work->afterImagePos[1].z = work->afterImagePos[0].z;

            work->afterImagePos[0].x = work->objWork.prevPosition.x;
            work->afterImagePos[0].y = work->objWork.prevPosition.y;
            work->afterImagePos[0].z = work->objWork.prevPosition.z;
        }
    }
}

// States & Actions
void Player__State_GroundIdle(Player *work)
{
    if (work->actionState == PLAYER_ACTION_CROUCH_EXIT && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        Player__ChangeAction(work, PLAYER_ACTION_IDLE);
        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    if ((work->inputKeyDown & PAD_KEY_UP) == 0)
    {
        if (work->actionState >= PLAYER_ACTION_LOOKUP_01 && work->actionState <= PLAYER_ACTION_LOOKUP_02)
        {
            work->objWork.displayFlag |= DISPLAY_FLAG_400;
            Player__ChangeAction(work, PLAYER_ACTION_IDLE);
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }

    if ((work->gimmickFlag & (PLAYER_GIMMICK_1000 | PLAYER_GIMMICK_SNOWBOARD | PLAYER_GIMMICK_100)) == 0 && (work->inputKeyDown & PAD_KEY_UP) != 0)
    {
        if (work->actionState < PLAYER_ACTION_LOOKUP_01 || work->actionState > PLAYER_ACTION_LOOKUP_02)
        {
            Player__ChangeAction(work, PLAYER_ACTION_LOOKUP_01);
        }
        else
        {
            if (work->actionState == PLAYER_ACTION_LOOKUP_01 && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                Player__ChangeAction(work, PLAYER_ACTION_LOOKUP_02);
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
    }
    else
    {
        if (work->actionState >= PLAYER_ACTION_BALANCE_FORWARD && work->actionState <= PLAYER_ACTION_BALANCE_BACKWARD)
        {
            if (CheckIsPlayer1(work) && !Player__IsBalancing(work, FALSE))
            {
                work->objWork.displayFlag |= DISPLAY_FLAG_400;
                Player__ChangeAction(work, PLAYER_ACTION_IDLE);
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
        else
        {
            if (work->actionState == PLAYER_ACTION_IDLE && Player__IsBalancing(work, TRUE))
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }

    if (Player__HandleFallOffSurface(work))
    {
        work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
        Player__Action_Launch(work);
    }
    else
    {
        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0 && work->actionJump != NULL)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
            work->actionJump(work);
        }
        else
        {
            if ((work->gimmickFlag & (PLAYER_GIMMICK_1000 | PLAYER_GIMMICK_SNOWBOARD | PLAYER_GIMMICK_100)) == 0 && (work->inputKeyDown & PAD_KEY_DOWN) != 0
                && work->actionCrouch != NULL)
            {
                work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
                work->actionCrouch(work);
            }
            else
            {
                if (((work->objWork.dir.z + FLOAT_DEG_TO_IDX(45.0)) & 0xFF00) >= FLOAT_DEG_TO_IDX(90.0))
                    Player__ApplySlopeForces(work, NULL);

                // if player is trying to move..
                if ((work->inputKeyDown & (PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0 || work->objWork.groundVel != 0)
                {
                    // and the player's direction matches their velocity...
                    if (((work->gimmickFlag & PLAYER_GIMMICK_40000) == 0 || (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) == 0
                         || ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 || (work->inputKeyDown & PAD_KEY_LEFT) == 0)
                                && ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 || (work->inputKeyDown & PAD_KEY_RIGHT) == 0)))
                    {
                        // and theyre not pushing on the stage boundaries.... (unless it's allowed!)
                        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_H) == 0
                            || (stageCollision.left + 14 < FX32_TO_WHOLE(work->objWork.position.x) || (work->inputKeyDown & PAD_KEY_LEFT) == 0)
                                   && (FX32_TO_WHOLE(work->objWork.position.x) < stageCollision.right - 14 || (work->inputKeyDown & PAD_KEY_RIGHT) == 0))
                        {
                            // just move!
                            if (work->actionGroundMove != NULL)
                            {
                                work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
                                work->actionGroundMove(work);
                                return;
                            }
                        }
                    }
                }

                Player__HandleZMovement(work);

                if ((work->gimmickFlag & PLAYER_GIMMICK_100) != 0 && work->objWork.velocity.z != 0 && work->actionGroundMove != NULL)
                {
                    work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
                    work->actionGroundMove(work);
                }
                else
                {
                    if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
                    {
                        // check if player touched sonic/blaze with the stylus
                        if (ObjTouchCheck(&work->objWork, work->colliders))
                        {
                            Player__ChangeAction(work, PLAYER_ACTION_TOUCH_REACT);
                            work->objWork.userTimer = 0;

                            if (work->characterID != CHARACTER_SONIC)
                                work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
                        }

                        if (work->actionState == PLAYER_ACTION_TOUCH_REACT)
                        {
                            if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                            {
                                work->objWork.displayFlag |= DISPLAY_FLAG_400;
                                Player__ChangeAction(work, PLAYER_ACTION_IDLE);
                                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                            }
                        }
                    }
                }
            }
        }
    }
}

void Player__State_GroundMove(Player *work)
{
    if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if (work->actionState < PLAYER_ACTION_BRAKE1_01 || work->actionState > PLAYER_ACTION_BRAKE2_03)
        {
            if ((work->inputKeyDown & PAD_KEY_LEFT) != 0 && work->objWork.groundVel >= FLOAT_TO_FX32(2.0)
                || (work->inputKeyDown & PAD_KEY_RIGHT) != 0 && work->objWork.groundVel <= FLOAT_TO_FX32(-2.0))
            {
                StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);

                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BREAK);
                        break;

                    case CHARACTER_BLAZE:
                        PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_BREAK);
                        break;
                }

                if (MATH_ABS(work->objWork.groundVel) > FLOAT_TO_FX32(7.0))
                    Player__ChangeAction(work, PLAYER_ACTION_BRAKE2_01);
                else
                    Player__ChangeAction(work, PLAYER_ACTION_BRAKE1_01);
            }
        }
        else if (work->actionState == PLAYER_ACTION_BRAKE1_01)
        {
            if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                Player__ChangeAction(work, PLAYER_ACTION_BRAKE1_02);
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
        else if (work->actionState == PLAYER_ACTION_BRAKE2_01)
        {
            if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                Player__ChangeAction(work, PLAYER_ACTION_BRAKE2_02);
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
        else if (work->actionState == PLAYER_ACTION_BRAKE1_02 || work->actionState == PLAYER_ACTION_BRAKE2_02)
        {
            if ((work->objWork.groundVel <= FLOAT_TO_FX32(0.0) || (work->inputKeyDown & PAD_KEY_LEFT) == 0)
                && (work->objWork.groundVel >= FLOAT_TO_FX32(0.0) || (work->inputKeyDown & PAD_KEY_RIGHT) == 0))
            {
                StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);

                if (work->actionState == PLAYER_ACTION_BRAKE1_02)
                    Player__ChangeAction(work, PLAYER_ACTION_BRAKE1_03);
                else
                    Player__ChangeAction(work, PLAYER_ACTION_BRAKE2_03);
            }
        }

        if (work->actionState == PLAYER_ACTION_TURNING || work->actionState >= PLAYER_ACTION_BRAKE1_01 && work->actionState <= PLAYER_ACTION_BRAKE2_03)
        {
            if ((work->inputKeyDown & PAD_KEY_LEFT) != 0)
            {
                work->playerFlag |= PLAYER_FLAG_USER_FLAG;
            }
            else if ((work->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                work->playerFlag &= ~PLAYER_FLAG_USER_FLAG;
            }
        }
    }

    if (Player__HandleFallOffSurface(work))
    {
        Player__FinishTurningSkidding(work);
        Player__Action_Launch(work);
        return;
    }

    if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        if (work->actionState == PLAYER_ACTION_TURNING)
        {
            if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                Player__FinishTurningSkidding(work);

                if (work->objWork.groundVel == FLOAT_TO_FX32(0.0) && work->objWork.velocity.z == FLOAT_TO_FX32(0.0))
                {
                    work->onLandGround(work);
                    return;
                }

                Player__HandleStartWalkAnimation(work);
            }
        }
        else
        {

            if (!(((work->gimmickFlag & PLAYER_GIMMICK_40000) != 0 || (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) == 0)
                  || (((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 || (work->inputKeyDown & PAD_KEY_LEFT) == 0)
                      && ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 || (work->inputKeyDown & PAD_KEY_RIGHT) == 0)))
                && (FX32_TO_WHOLE(work->objWork.position.x) > stageCollision.left + 14 && FX32_TO_WHOLE(work->objWork.position.x) < stageCollision.right - 14))
            {
                switch (work->actionState)
                {
                    default:
                        Player__ChangeAction(work, PLAYER_ACTION_PUSH_01);
                        break;

                    case PLAYER_ACTION_PUSH_01:
                    case PLAYER_ACTION_PUSH_02:
                        if (work->actionState == PLAYER_ACTION_PUSH_01 && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                        {
                            Player__ChangeAction(work, PLAYER_ACTION_PUSH_02);
                            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                        }
                        break;
                }
            }
            else
            {
                if (work->objWork.groundVel == FLOAT_TO_FX32(0.0) && work->objWork.velocity.z == FLOAT_TO_FX32(0.0))
                {
                    Player__FinishTurningSkidding(work);
                    work->onLandGround(work);
                    return;
                }

                if ((work->actionState < PLAYER_ACTION_BRAKE1_01 || work->actionState > PLAYER_ACTION_BRAKE2_03)
                    || ((work->actionState == PLAYER_ACTION_BRAKE1_03 || work->actionState == PLAYER_ACTION_BRAKE2_03)
                        && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0))
                {
                    Player__FinishTurningSkidding(work);
                    Player__HandleActiveWalkAnimation(work);
                }
            }
        }
    }

    Player__HandleGroundMovement(work);

    if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0 && work->actionJump != NULL)
    {
        Player__FinishTurningSkidding(work);
        work->actionJump(work);
    }
    else
    {
        if ((work->gimmickFlag & (PLAYER_GIMMICK_SNOWBOARD | PLAYER_GIMMICK_100)) == 0 && ((work->inputKeyDown & PAD_KEY_DOWN) != 0 && work->actionCrouch != NULL))
        {
            Player__FinishTurningSkidding(work);
            work->actionCrouch(work);
        }
        else
        {
            if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
                Player__SetAnimSpeedFromVelocity(work, work->objWork.groundVel);

            if (work->actionState >= PLAYER_ACTION_BRAKE1_01 && work->actionState <= PLAYER_ACTION_BRAKE2_03)
            {
                if ((g_obj.flag & OBJECTMANAGER_FLAG_400) == 0 && (work->objWork.userTimer & 7) == 0)
                {
                    CreateEffectBrakeDustForPlayer(work);
                    if ((work->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
                    {
                        if ((mtMathRand() & 1) == 0)
                            CreateEffectWaterBubbleForPlayer(work, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[work->cameraID].waterLevel);
                    }
                }

                work->objWork.userTimer++;
            }

            if ((g_obj.flag & OBJECTMANAGER_FLAG_400) == 0 && work->characterID == CHARACTER_BLAZE)
            {
                if (work->spdThresholdJog < MATH_ABS(work->objWork.groundVel) && (work->playerFlag & PLAYER_FLAG_BOOST) == 0
                    && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0 && (playerGameStatus.stageTimer & 3) == 0)
                {
                    CreateEffectFlameDustForPlayer(work);
                }
            }

            if (GetCurrentZoneID() == ZONE_BLIZZARD_PEAKS && GetSysEventList()->currentEventID == SYSEVENT_STAGE_ACTIVE)
            {
                if (MATH_ABS(work->objWork.groundVel) >= work->spdThresholdRun && (playerGameStatus.stageTimer & 7) == 0)
                {
                    CreateLargeEffectSnowSmokeForPlayer(work);
                }
                else
                {
                    if (MATH_ABS(work->objWork.groundVel) >= work->spdThresholdWalk && (playerGameStatus.stageTimer & 0xF) == 0)
                        CreateSmallEffectSnowSmokeForPlayer(work);
                }
            }
        }
    }
}

void Player__Action_Crouch(Player *player)
{
    if (player->objWork.groundVel > FLOAT_TO_FX32(0.5) || player->objWork.groundVel < -FLOAT_TO_FX32(0.5))
    {
        Player__Action_Roll(player);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_CROUCH);
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
        SetTaskState(&player->objWork, Player__State_Crouch);
        player->objWork.groundVel  = 0;
        player->objWork.velocity.x = 0;
    }
}

void Player__State_Crouch(Player *work)
{
    if (((work->objWork.dir.z + FLOAT_DEG_TO_IDX(67.5)) & 0xFF00) >= FLOAT_DEG_TO_IDX(135.0))
        Player__ApplySlopeForces(work, NULL);

    if (Player__HandleFallOffSurface(work))
    {
        Player__Action_Launch(work);
    }
    else
    {
        if (work->objWork.groundVel > FLOAT_TO_FX32(0.5) || work->objWork.groundVel < -FLOAT_TO_FX32(0.5))
        {
            Player__Action_Roll(work);
        }
        else
        {
            if ((work->objWork.groundVel == FLOAT_TO_FX32(0.0) && work->objWork.velocity.x == FLOAT_TO_FX32(0.0)) && (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
            {
                Player__Action_StartSpindash(work);
            }
            else if ((work->inputKeyDown & PAD_KEY_DOWN) == 0)
            {
                work->onLandGround(work);
            }
        }
    }
}

void Player__Action_Roll(Player *player)
{
    Player__ChangeAction(player, PLAYER_ACTION_ROLL);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, Player__State_Roll);

    ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);
    player->colliders[1].onDefend = NULL;
    player->colliders[1].flag &= ~OBS_RECT_WORK_FLAG_8;

    player->objWork.slopeAcceleration = playerPhysicsTable[player->characterID].rollSlopeAcceleration;
    player->objWork.slopeDirection    = FLOAT_TO_FX32(1.0);

    switch (player->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPIN);
            break;

        case CHARACTER_BLAZE:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BURST);
            break;
    }
}

void Player__State_Roll(Player *work)
{
    if (Player__HandleFallOffSurface(work))
    {
        Player__InitPhysics(work);
        Player__Action_Launch(work);
    }
    else
    {
        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0 && work->actionJump != NULL)
        {
            if (work->overSpeedLimitTimer >= 20)
                work->overSpeedLimitTimer = 20;

            Player__InitPhysics(work);
            work->actionJump(work);
        }
        else
        {
            Player__HandleRollingForces(work);

            if (work->objWork.groundVel < FLOAT_TO_FX32(0.5) && work->objWork.groundVel > -FLOAT_TO_FX32(0.5))
            {
                work->objWork.groundVel = 0;
                Player__InitPhysics(work);
                work->onLandGround(work);
            }
            else
            {
                Player__SetAnimSpeedFromVelocity(work, work->objWork.groundVel);
            }
        }
    }
}

void Player__Action_StartSpindash(Player *player)
{
    Player__ChangeAction(player, PLAYER_ACTION_SPINDASH);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, Player__State_Spindash);
    player->spindashPower = player->initialSpindashPower;

    ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);
    player->colliders[1].onDefend = NULL;
    player->colliders[1].flag &= ~OBS_RECT_WORK_FLAG_8;

    player->playerFlag |= PLAYER_FLAG_USER_FLAG;
    if ((player->gimmickFlag & PLAYER_GIMMICK_1000) == 0)
        CreateEffectBigSpindashDust(player);

    switch (player->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPIN);
            break;

        case CHARACTER_BLAZE:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BURST);
            break;
    }
}

void Player__State_Spindash(Player *work)
{
    if (Player__HandleFallOffSurface(work))
    {
        Player__InitPhysics(work);
        Player__Action_Launch(work);
    }
    else
    {
        if (work->actionState == PLAYER_ACTION_SPINDASH_CHARGE && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            Player__ChangeAction(work, PLAYER_ACTION_SPINDASH);
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }

        if ((work->inputKeyDown & PAD_KEY_DOWN) == 0 || work->objWork.groundVel != 0)
        {
            // release spindash

            work->overSpeedLimitTimer = 72;
            work->cameraScrollDelay   = 8;

            fx32 releaseVelocity = MultiplyFX(work->spindashPower, FLOAT_TO_FX32(0.5)) + FLOAT_TO_FX32(8.0);
            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                releaseVelocity = -releaseVelocity;

            if (MATH_ABS(releaseVelocity) > MATH_ABS(work->objWork.groundVel))
                work->objWork.groundVel = releaseVelocity;

            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_4000;
            Player__Action_Roll(work);

            switch (work->characterID)
            {
                // case CHARACTER_SONIC:
                default:
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPINDASH);
                    break;

                case CHARACTER_BLAZE:
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BURST_DASH);
                    break;
            }
        }
        else if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            // charge spindash

            StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);

            switch (work->characterID)
            {
                // case CHARACTER_SONIC:
                default:
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPIN);
                    break;

                case CHARACTER_BLAZE:
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BURST);
                    break;
            }

            Player__ChangeAction(work, PLAYER_ACTION_SPINDASH_CHARGE);
            work->spindashPower = ObjSpdUpSet(work->spindashPower, work->spindashChargePower, work->spindashTopSpeed);

            if ((work->gimmickFlag & PLAYER_GIMMICK_1000) == 0 && (work->playerFlag & PLAYER_FLAG_USER_FLAG) == 0)
                CreateEffectBigSpindashDust(work);

            work->playerFlag |= PLAYER_FLAG_USER_FLAG;
        }
        else if ((work->inputKeyDown & PAD_KEY_UP) != 0)
        {
            // undo spindash

            work->onLandGround(work);
        }
        else
        {
            // spindash idle

            Player__SetAnimSpeedFromVelocity(work, MultiplyFX(work->spindashPower, FLOAT_TO_FX32(0.5)) + FLOAT_TO_FX32(8.0));

            if (work->spindashPower < work->initialSpindashPower >> 1 && (work->playerFlag & PLAYER_FLAG_USER_FLAG) != 0)
            {
                work->objWork.userTimer = 5;
                work->playerFlag &= ~PLAYER_FLAG_USER_FLAG;
            }

            work->spindashPower = ObjSpdDownSet(work->spindashPower, work->spindashPower >> 5);

            if ((work->playerFlag & PLAYER_FLAG_USER_FLAG) == 0)
            {
                if ((work->objWork.userTimer & 0xF) == 0)
                    CreateEffectSmallSpindashDust(work);

                work->objWork.userTimer++;
            }
        }
    }
}

void Player__Action_Jump(Player *player)
{
    u16 oldAngle;

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);

        fx32 velocity;
        if (player->characterID == CHARACTER_BLAZE)
            velocity = FLOAT_TO_FX32(4.0);
        else
            velocity = FLOAT_TO_FX32(8.0);

        Player__SetAnimSpeedFromVelocity(player, velocity);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_JUMP_SNOWBOARD_01);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_JUMP_01);

        oldAngle              = player->objWork.dir.z;
        player->objWork.dir.z = 0;

        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
    }

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        player->cameraJumpPosY = player->objWork.position.y;

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag |= PLAYER_FLAG_8000 | PLAYER_FLAG_IS_ATTACKING_PLAYER;
    SetTaskState(&player->objWork, Player__State_Air);

    player->objWork.velocity.x = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
    player->objWork.velocity.y = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));
    player->objWork.velocity.x += MultiplyFX(player->jumpForce, SinFX(player->objWork.dir.z));
    player->objWork.velocity.y += MultiplyFX(-player->jumpForce, CosFX(player->objWork.dir.z));

    if ((player->gimmickFlag & PLAYER_GIMMICK_1000) != 0)
    {
        player->objWork.velocity.z = player->objWork.velocity.y;
        player->objWork.velocity.y = 0;

        if (player->objWork.position.z < 0)
            player->objWork.velocity.z = -player->objWork.velocity.z;
    }

    ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);
    player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
    player->playerFlag &= ~(PLAYER_FLAG_8000 | PLAYER_FLAG_TRICK_SUCCESS);
    player->objWork.userTimer  = 0;
    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        switch (player->characterID)
        {
            // case CHARACTER_SONIC:
            default:
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMP);
                break;

            case CHARACTER_BLAZE:
                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ACCEL_JUMP);
                break;
        }
    }
    else
    {
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_JUMP);
    }

    FadeOutPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
    ReleasePlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);

    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
    {
        if ((mtMathRand() & 1) != 0)
            CreateEffectWaterBubbleForPlayer(player, 0, 0, mapCamera.camera[player->cameraID].waterLevel);
    }

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
        player->objWork.dir.z = oldAngle;
}

void Player__Action_JumpDash(Player *player)
{
    Player__ChangeAction(player, PLAYER_ACTION_JUMPDASH_01);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, Player__State_Air);

    s32 angle;
    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        angle = FLOAT_DEG_TO_IDX(270.0);
    else
        angle = FLOAT_DEG_TO_IDX(90.0);

    player->objWork.velocity.y = 0;
    player->objWork.velocity.x += MultiplyFX(player->jumpForce, SinFX(angle));
    player->objWork.velocity.y += MultiplyFX(-player->jumpForce, CosFX(angle));
    player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
    player->playerFlag |= PLAYER_FLAG_USER_FLAG;
    player->objWork.userTimer   = 0;
    player->objWork.userWork    = 0;
    player->trickCooldownTimer  = 0;
    player->overSpeedLimitTimer = 12;

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMPDASH);
}

void Player__State_Air(Player *work)
{
    fx32 velocityY = work->objWork.velocity.y;

    if ((work->gimmickFlag & PLAYER_GIMMICK_1000) != 0)
    {
        velocityY = work->objWork.velocity.z;
        if (work->objWork.dir.x > FLOAT_TO_FX32(8.0))
            velocityY = -velocityY;
    }

    Player__HandleAirDrag(work);
    Player__HandleAirMovement(work);

    if (work->objWork.userTimer != 0)
    {
        work->objWork.userTimer--;
        if (work->objWork.userTimer == 0)
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    }

    if ((work->playerFlag & PLAYER_FLAG_USER_FLAG) == 0 && (work->inputKeyDown & PLAYER_INPUT_JUMP) == 0 && velocityY < -FLOAT_TO_FX32(0.25))
    {
        if ((work->gimmickFlag & PLAYER_GIMMICK_1000) != 0)
            work->objWork.velocity.z = 0;
        else
            work->objWork.velocity.y = -FLOAT_TO_FX32(0.015625);
    }

    if (velocityY > 0)
        work->playerFlag |= PLAYER_FLAG_USER_FLAG;

    if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        switch (work->actionState)
        {
            case PLAYER_ACTION_HOMING_ATTACK:
                if (((g_obj.flag & OBJECTMANAGER_FLAG_400) == 0 && work->characterID == CHARACTER_BLAZE) && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0
                    && (playerGameStatus.stageTimer & 7) == 0)
                    CreateEffectFlameDustForPlayer3(work);
                break;

            case PLAYER_ACTION_AIRRISE:
                if (velocityY > FLOAT_TO_FX32(0.25))
                    Player__ChangeAction(work, PLAYER_ACTION_AIRFALL_01);
                break;

            case PLAYER_ACTION_AIRFALL_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_AIRFALL_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;

            case PLAYER_ACTION_AIRFORWARD_01:
            case PLAYER_ACTION_MUSHROOM_BOUNCE:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_400;
                    Player__ChangeAction(work, PLAYER_ACTION_AIRFORWARD_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;

            case PLAYER_ACTION_JUMPDASH_01:
                if (velocityY > FLOAT_TO_FX32(1.75))
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_400;
                    Player__ChangeAction(work, PLAYER_ACTION_JUMPDASH_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;

            case PLAYER_ACTION_TRAMPOLINE:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0 && velocityY > FLOAT_TO_FX32(0.25))
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_400;
                    Player__ChangeAction(work, PLAYER_ACTION_JUMPFALL);
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_V_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_TRICK_FINISH_V_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                }
                else
                {
                    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_V_02:
                if (velocityY > -FLOAT_TO_FX32(0.125))
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_400;
                    Player__ChangeAction(work, PLAYER_ACTION_TRICK_FINISH_V_03);
                }

                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if ((work->axelTornadoFXSpawnTimer & 3) == 0)
                            CreateEffectFlameDustForPlayer2(work);

                        work->axelTornadoFXSpawnTimer++;
                        break;
                }

                break;

            case PLAYER_ACTION_TRICK_FINISH_V_03:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_TRICK_FINISH_V_04);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_H_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_TRICK_FINISH_H_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }

                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if (work->trickFinishHorizFreezeTimer)
                        {
                            work->objWork.displayFlag ^= DISPLAY_FLAG_NO_DRAW;
                            work->objWork.velocity.y = 0;

                            work->trickFinishHorizFreezeTimer--;
                            if (!work->trickFinishHorizFreezeTimer)
                            {
                                work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                                work->objWork.velocity.x   = work->trickFinishHorizXVelocity;
                                work->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                                work->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
                                work->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
                            }
                        }
                        break;
                }

                break;

            case PLAYER_ACTION_TRICK_FINISH_H_02:
                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if (work->trickFinishHorizFreezeTimer != 0)
                        {
                            work->objWork.displayFlag ^= DISPLAY_FLAG_NO_DRAW;
                            work->objWork.velocity.y = 0;

                            work->trickFinishHorizFreezeTimer--;
                            if (work->trickFinishHorizFreezeTimer == 0)
                            {
                                work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                                work->objWork.velocity.x   = work->trickFinishHorizXVelocity;
                                work->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                                work->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
                                work->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
                            }
                        }
                        break;
                }
                break;

            case PLAYER_ACTION_RAINBOWDASHRING:
                if ((playerGameStatus.stageTimer & 7) == 0)
                    CreateEffectTrickSparkleForPlayer(work);

                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_JUMPFALL);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
                break;

            default:
                break;
        }
    }
    else
    {
        switch (work->actionState)
        {
            case PLAYER_ACTION_JUMP_SNOWBOARD_01:
                if (velocityY > FLOAT_TO_FX32(0.25))
                {
                    Player__ChangeAction(work, PLAYER_ACTION_JUMP_SNOWBOARD_02);
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_JUMP_02);
                }
                break;

            case PLAYER_ACTION_JUMP_SNOWBOARD_02:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_JUMPFALL_SNOWBOARD);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_JUMPFALL);
                }
                break;

            case PLAYER_ACTION_AIRRISE_SNOWBOARD:
                if (velocityY > FLOAT_TO_FX32(0.25))
                {
                    Player__ChangeAction(work, PLAYER_ACTION_AIRFALL_SNOWBOARD_01);
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_AIRFALL_01);
                }
                break;

            case PLAYER_ACTION_AIRFALL_SNOWBOARD_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_AIRFALL_SNOWBOARD_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_AIRFALL_02);
                }
                break;

            case PLAYER_ACTION_AIRFORWARD_SNOWBOARD_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_400;
                    Player__ChangeAction(work, PLAYER_ACTION_AIRFORWARD_SNOWBOARD_02);

                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_AIRFALL_02);
                }
                break;

            case PLAYER_ACTION_JUMPDASH_SNOWBOARD_01:
                if (velocityY > FLOAT_TO_FX32(1.75))
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_400;
                    Player__ChangeAction(work, PLAYER_ACTION_JUMPDASH_SNOWBOARD_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_AIRFALL_02);
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_TRICK_FINISH_V_02);
                }
                else
                {
                    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_02:

                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if ((work->axelTornadoFXSpawnTimer & 3) == 0)
                            CreateEffectFlameDustForPlayer2(work);

                        work->axelTornadoFXSpawnTimer++;
                        break;
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01:
                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_02);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_TRICK_FINISH_H_02);
                }

                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if (work->trickFinishHorizFreezeTimer)
                        {
                            work->objWork.displayFlag ^= DISPLAY_FLAG_NO_DRAW;
                            work->objWork.velocity.y = 0;

                            work->trickFinishHorizFreezeTimer--;
                            if (!work->trickFinishHorizFreezeTimer)
                            {
                                work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                                work->objWork.velocity.x   = work->trickFinishHorizXVelocity;
                                work->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                                work->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
                                work->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
                            }
                        }
                        break;
                }
                break;

            case PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_02:
                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if (work->trickFinishHorizFreezeTimer)
                        {
                            work->objWork.displayFlag ^= DISPLAY_FLAG_NO_DRAW;
                            work->objWork.velocity.y = 0;

                            work->trickFinishHorizFreezeTimer--;
                            if (!work->trickFinishHorizFreezeTimer)
                            {
                                work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                                work->objWork.velocity.x   = work->trickFinishHorizXVelocity;
                                work->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                                work->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
                                work->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
                            }
                        }
                        break;
                }
                break;

            case PLAYER_ACTION_RAINBOWDASHRING_SNOWBOARD:
                if ((playerGameStatus.stageTimer & 7) == 0)
                    CreateEffectTrickSparkleForPlayer(work);

                if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                {
                    Player__ChangeAction(work, PLAYER_ACTION_JUMPFALL_SNOWBOARD);
                    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_JUMPFALL);
                }
                break;

            default:
                break;
        }
    }

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        work->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
        Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
        work->starComboCount = 0;

        work->onLandGround(work);
        if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_LANDING);
    }
    else
    {
        if ((work->playerFlag & PLAYER_FLAG_ALLOW_TRICKS) != 0)
        {
            if ((work->playerFlag & PLAYER_FLAG_DISABLE_TRICK_FINISHER) == 0
                && (work->actionState < PLAYER_ACTION_TRICK_FINISH_V_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH_H_02)
                && (work->actionState < PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_02))
            {
                if ((work->inputKeyPress & PAD_BUTTON_R) != 0 && (work->inputKeyDown & PAD_KEY_UP) != 0)
                {
                    Player__Action_TrickFinisherVertical(work);
                    return;
                }

                if ((work->inputKeyPress & PAD_BUTTON_R) != 0)
                {
                    Player__Action_TrickFinisherHorizontal(work);
                    return;
                }
            }

            if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
                work->objWork.userWork = work->inputKeyPress;

            if (work->actionState >= PLAYER_ACTION_TRICK_FINISH_H_01 && work->actionState <= PLAYER_ACTION_TRICK_FINISH
                || work->actionState >= PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_01 && work->actionState <= PLAYER_ACTION_TRICK_FINISH_SNOWBOARD)
            {
                switch (work->characterID)
                {
                    // case CHARACTER_SONIC:
                    default:
                        break;

                    case CHARACTER_BLAZE:
                        if (velocityY < 0)
                        {
                            if ((work->actionState == PLAYER_ACTION_TRICK_FINISH_H_01 || work->actionState == PLAYER_ACTION_TRICK_FINISH_H_02)
                                || (work->actionState == PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01 || work->actionState == PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_02))
                                work->trickCooldownTimer = 0;
                        }
                        break;
                }

                work->trickCooldownTimer++;
                if (work->trickCooldownTimer > 255)
                    work->trickCooldownTimer = 255;
            }

            if ((work->playerFlag & PLAYER_FLAG_FINISHED_TRICK_COMBO) == 0)
            {
                s32 cooldown = work->hyperTrickTimer ? PLAYER_TRICK_COOLDOWN_HYPER : PLAYER_TRICK_COOLDOWN;

                if (work->trickCooldownTimer > cooldown
                    || (work->actionState < PLAYER_ACTION_TRICK_FINISH_H_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH)
                           && (work->actionState < PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH_SNOWBOARD))
                {
                    if (work->objWork.userWork)
                    {
                        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                        work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                        work->colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
                        Player__PerformTrick(work);
                    }
                }
            }
        }
        else
        {
            if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0 && work->actionState <= PLAYER_ACTION_AIRFORWARD_02 || work->actionState == PLAYER_ACTION_HOMING_ATTACK)
            {
                if ((work->inputKeyPress & PAD_BUTTON_R) && work->actionRButtonAir != NULL)
                {
                    if ((work->gimmickFlag & PLAYER_GIMMICK_1000) == 0)
                        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

                    work->actionRButtonAir(work);
                }
            }
        }
    }
}

void Player__State_Death(Player *player)
{
    player->objWork.userTimer++;
    if (player->actionState == PLAYER_ACTION_DEATH_01 && (player->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_DEATH_02);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    if (player->objWork.userTimer == 60)
    {
        if (IsBossStage())
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.25));
        else
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
    }

    if (player->objWork.userTimer >= 60 && IsDrawFadeTaskFinished() && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE) == 0)
    {
        playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_NO_MORE_STAGEFINISHEVENTS;

        if (gameState.gameMode == GAMEMODE_VS_BATTLE)
        {
            Player__Gimmick_200EE68(player);

            if (gmCheckRaceStage())
            {
                playerGameStatus.playerLapCounter[player->controlID] = playerGameStatus.playerTargetLaps[player->controlID];
                player->playerFlag |= PLAYER_GIMMICK_400;
            }

            player->gimmickFlag &= ~PLAYER_GIMMICK_200000;
            SetTaskState(&player->objWork, Player__State_DeathReset);
            player->objWork.userTimer = 0;
        }
        else
        {
            player->playerFlag &= ~DISPLAY_FLAG_400;

            Player__Gimmick_200EE68(player);

            if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_PLAYER_DIED) == 0)
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));

            player->onLandGround(player);
        }
    }
}

void Player__State_DeathReset(Player *player)
{
    player->objWork.userTimer++;
    if (player->objWork.userTimer >= 2)
    {
        player->gimmickFlag |= PLAYER_GIMMICK_200000;

        if (GetCurrentZoneID() == ZONE_PLANT_KINGDOM)
        {
            mapCamera.camera[0].flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
            mapCamera.camera[0].waterLevel = MAPSYS_WATERLEVEL_NONE;

            mapCamera.camera[1].flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
            mapCamera.camera[1].waterLevel = MAPSYS_WATERLEVEL_NONE;
        }
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));

        player->playerFlag &= ~PLAYER_FLAG_DEATH;
        player->onLandGround(player);
    }
}

void Player__State_Warp(Player *work)
{
    work->objWork.userTimer++;

    if (work->objWork.userWork <= 1)
    {
        if (work->objWork.userTimer >= 8 && work->objWork.userTimer < 60)
        {
            work->objWork.scale.x = ObjShiftSet(work->objWork.scale.x, FLOAT_TO_FX32(0.00390625), 2, FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(0.03125));
            work->objWork.scale.y = ObjShiftSet(work->objWork.scale.y, FLOAT_TO_FX32(4.0), 2, FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.03125));
        }

        if (work->objWork.scale.x == FLOAT_TO_FX32(0.00390625) && work->objWork.scale.y == FLOAT_TO_FX32(4.0))
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    }

    s32 state = work->objWork.userWork;
    switch (state)
    {
        case 0:
            if (work->objWork.userTimer == 56)
            {
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(8.0));
                work->objWork.userWork++;
            }
            break;

        case 1:
            if (IsDrawFadeTaskFinished())
            {
                if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
                {
                    if (!gmCheckRingBattle())
                    {
                        if (!gmCheckRaceStage())
                        {
                            DestroyTaskGroup(TASK_GROUP(2));
                            DecorationSys__Release();
                        }
                    }
                }

                work->objWork.userWork++;
            }
            break;

        case 2:
            if (work->objWork.userTimer >= 60)
            {
                work->playerFlag &= ~PLAYER_FLAG_DEATH;
                work->gimmickFlag |= PLAYER_GIMMICK_400000;

                // swap players!
                Player__Gimmick_200EE68(work);

                work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

                SetTaskState(&work->objWork, Player__State_Warp);

                work->objWork.userWork = state;
                work->objWork.userWork++;
                work->objWork.userTimer = 0;
            }
            break;

        case 3:
            work->objWork.userTimer++;
            if (work->objWork.userTimer >= 2)
            {
                work->gimmickFlag |= PLAYER_GIMMICK_200000;

                if (GetCurrentZoneID() == ZONE_PLANT_KINGDOM)
                {
                    mapCamera.camera[0].flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
                    mapCamera.camera[0].waterLevel = MAPSYS_WATERLEVEL_NONE;

                    mapCamera.camera[1].flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
                    mapCamera.camera[1].waterLevel = MAPSYS_WATERLEVEL_NONE;
                }

                work->objWork.userWork++;
            }
            break;

        case 4:
        default:
            if (GetCurrentZoneID() == ZONE_PLANT_KINGDOM)
            {
                mapCamera.camera[0].flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
                mapCamera.camera[0].waterLevel = MAPSYS_WATERLEVEL_NONE;

                mapCamera.camera[1].flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
                mapCamera.camera[1].waterLevel = MAPSYS_WATERLEVEL_NONE;
            }

            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(8.0));
            work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
            work->onLandGround(work);
            break;
    }
}

void Player__State_Hurt(Player *work)
{
    Player__HandleAirDrag(work);

    if ((work->objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0 && (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        work->colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;
        Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
        work->onLandGround(work);
    }
}

void Player__State_HurtSnowboard(Player *work)
{
    work->objWork.dir.z += FLOAT_DEG_TO_IDX(22.5);

    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0)
    {
        work->objWork.dir.z = 0;
        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
            work->onLandGround(work);
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_LANDING);
        }
        else
        {
            fx32 velX = work->objWork.velocity.x;
            Player__Action_Launch(work);
            work->objWork.velocity.x = velX;
        }
    }
}

void Player__State_Grinding(Player *work)
{
    s32 angleStore = work->objWork.dir.z;

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0 && (work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        work->objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;

    if (work->objWork.groundVel == FLOAT_TO_FX32(0.0))
    {
        if (work->objWork.dir.z == FLOAT_DEG_TO_IDX(0.0) || work->objWork.dir.z == FLOAT_DEG_TO_IDX(180.0))
        {
            work->objWork.groundVel = FLOAT_TO_FX32(0.0625);
            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.groundVel = -work->objWork.groundVel;
        }
    }

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        StopPlayerSfx(work, PLAYER_SEQPLAYER_GRIND);
        FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
        ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);

        work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
        work->grindID = PLAYER_GRIND_NONE;
        Player__Gimmick_201BAC0(work, work->objWork.groundVel, -FLOAT_TO_FX32(5.0));

        if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            switch (work->characterID)
            {
                // case CHARACTER_SONIC:
                default:
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMP);
                    break;

                case CHARACTER_BLAZE:
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ACCEL_JUMP);
                    break;
            }
        }
        else
        {
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_JUMP);
        }
    }
    else
    {
        work->objWork.dir.z = 0;
        if (Player__HandleFallOffSurface(work))
        {
            StopPlayerSfx(work, PLAYER_SEQPLAYER_GRIND);
            FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
            ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
            work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
            work->grindID = PLAYER_GRIND_NONE;
            Player__Action_Launch(work);
            return;
        }

        work->objWork.dir.z = angleStore;

        if ((work->inputKeyPress & PAD_BUTTON_B) != 0)
        {
            if ((work->inputKeyDown & (PAD_KEY_DOWN | PAD_KEY_UP)) != 0)
            {
                StopPlayerSfx(work, PLAYER_SEQPLAYER_GRIND);
                FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
                ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);

                work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
                if ((work->inputKeyDown & PAD_KEY_UP) != 0)
                {
                    if ((work->objWork.collisionFlag & (STAGE_TASK_COLLISION_FLAG_GRIND_RAIL | STAGE_TASK_COLLISION_FLAG_1))
                        == (STAGE_TASK_COLLISION_FLAG_GRIND_RAIL | STAGE_TASK_COLLISION_FLAG_1))
                    {
                        work->grindID = PLAYER_GRIND_NONE;
                        Player__Gimmick_201BAC0(work, work->objWork.groundVel, -FLOAT_TO_FX32(7.0));
                        Player__Action_RainbowDashRing(work);
                        return;
                    }

                    if (work->actionJump != NULL)
                    {
                        work->actionJump(work);
                        return;
                    }
                }
                else
                {
                    Player__Action_Launch(work);
                    return;
                }
            }
        }
        else if ((work->inputKeyPress & PAD_BUTTON_A) != 0)
        {
            // player jumped off the rail
            StopPlayerSfx(work, PLAYER_SEQPLAYER_GRIND);
            FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
            ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);

            if ((work->objWork.collisionFlag & (STAGE_TASK_COLLISION_FLAG_GRIND_RAIL | STAGE_TASK_COLLISION_FLAG_1))
                == (STAGE_TASK_COLLISION_FLAG_GRIND_RAIL | STAGE_TASK_COLLISION_FLAG_1))
            {
                work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
                work->grindID = PLAYER_GRIND_NONE;
                Player__Gimmick_201BAC0(work, work->objWork.groundVel, -FLOAT_TO_FX32(7.0));
                Player__Action_RainbowDashRing(work);
                return;
            }

            if (work->actionJump != NULL)
            {
                work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
                work->actionJump(work);
                return;
            }
        }

        if ((work->objWork.collisionFlag & STAGE_TASK_COLLISION_FLAG_GRIND_RAIL) == 0 && work->onLandGround != NULL)
        {
            // end grinding (not on grind rail)
            StopPlayerSfx(work, PLAYER_SEQPLAYER_GRIND);
            FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
            ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
            work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
            work->grindID = PLAYER_GRIND_NONE;
            work->onLandGround(work);
        }
        else
        {
            s32 accel = MultiplyFX(FLOAT_TO_FX32(0.15625), SinFX((s32)work->objWork.dir.z));

            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && accel > 0)
            {
                accel >>= 2;
                if (work->overSpeedLimitTimer)
                    accel = 0;
            }

            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && accel < 0)
            {
                accel >>= 2;
                if (work->overSpeedLimitTimer)
                    accel = 0;
            }

            work->objWork.groundVel += accel;

            if (work->objWork.groundVel > 0)
            {
                work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            }
            else if (work->objWork.groundVel < 0)
            {
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            }

            // apply acceleration
            if ((work->inputKeyDown & PAD_KEY_LEFT) != 0)
            {
                if (work->objWork.groundVel < 0 || work->objWork.groundVel > FLOAT_TO_FX32(2.0))
                    work->objWork.groundVel -= FLOAT_TO_FX32(0.0625);
            }
            else if ((work->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                if (work->objWork.groundVel > 0 || work->objWork.groundVel < -FLOAT_TO_FX32(2.0))
                    work->objWork.groundVel += FLOAT_TO_FX32(0.0625);
            }

            switch (work->actionState)
            {
                case PLAYER_ACTION_GRINDTRICK_3_01:
                    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                    {
                        Player__ChangeAction(work, PLAYER_ACTION_GRINDTRICK_3_02);
                        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    }
                    break;

                case PLAYER_ACTION_GRINDTRICK_3_02:
                    work->objWork.userWork++;
                    if (work->objWork.userWork >= 32 && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                    {
                        Player__ChangeAction(work, PLAYER_ACTION_GRINDTRICK_3_03);
                        work->objWork.userWork = 0;
                    }
                    break;

                case PLAYER_ACTION_GRINDTRICK_3_03:
                    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                    {
                        FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
                        ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
                        Player__ChangeAction(work, PLAYER_ACTION_GRIND);
                        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    }
                    break;

                case PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_01:
                    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                    {
                        Player__ChangeAction(work, PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_02);
                        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                        ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_02);
                    }
                    break;

                case PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_02:
                    work->objWork.userWork++;
                    if (work->objWork.userWork >= 32 && (work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                    {
                        Player__ChangeAction(work, PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_03);
                        work->objWork.userWork = 0;
                        ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_03);
                    }
                    break;

                case PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_03:
                    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                    {
                        FadeOutPlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
                        ReleasePlayerSfx(work, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
                        Player__ChangeAction(work, PLAYER_ACTION_GRIND_SNOWBOARD);
                        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                        ChangePlayerSnowboardAction(work, PLAYERSNOWBOARD_ACTION_WALK);
                    }
                    break;
            }

            if (work->actionState >= PLAYER_ACTION_GRIND && work->actionState <= PLAYER_ACTION_GRINDTRICK_2
                || work->actionState >= PLAYER_ACTION_GRIND_SNOWBOARD && work->actionState <= PLAYER_ACTION_GRINDTRICK_SNOWBOARD_2)
            {

                switch (work->actionState)
                {
                    case PLAYER_ACTION_GRINDTRICK_1:
                    case PLAYER_ACTION_GRINDTRICK_2:
                    case PLAYER_ACTION_GRINDTRICK_SNOWBOARD_1:
                    case PLAYER_ACTION_GRINDTRICK_SNOWBOARD_2:
                        work->trickCooldownTimer++;
                        work->trickCooldownTimer &= 0xFF;
                        break;
                }

                if ((work->inputKeyPress & (PAD_BUTTON_B | PAD_BUTTON_R)) != 0)
                    work->objWork.userTimer = 1;

                if (((work->actionState == PLAYER_ACTION_GRIND || work->actionState == PLAYER_ACTION_GRIND_SNOWBOARD)
                     || ((work->actionState == PLAYER_ACTION_GRINDTRICK_1 || work->actionState == PLAYER_ACTION_GRINDTRICK_SNOWBOARD_1)
                         && work->trickCooldownTimer > PLAYER_GRIND_TRICK2_COOLDOWN)
                     || ((work->actionState == PLAYER_ACTION_GRINDTRICK_2 || work->actionState == PLAYER_ACTION_GRINDTRICK_SNOWBOARD_2)
                         && work->trickCooldownTimer > PLAYER_GRIND_TRICK3_COOLDOWN)))
                {
                    if (work->objWork.userTimer != 0)
                        PLayer__PerformGrindTrick(work);
                }
            }
        }
    }
}

void Player__Action_TrickFinisherVertical(Player *player)
{
    ApplyPlayerTensionPenalty(player);

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH_V_01);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_01);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_TRICK_FINISH_V_01);
    }

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->playerFlag |= PLAYER_FLAG_8000;
    SetTaskState(&player->objWork, Player__State_Air);

    switch (player->characterID)
    {
        case CHARACTER_SONIC:
            if ((player->inputKeyDown & (PAD_KEY_LEFT | PAD_KEY_RIGHT)) == 0 || (player->objWork.velocity.x > 0 && (player->inputKeyDown & PAD_KEY_LEFT) != 0)
                || (player->objWork.velocity.x < 0 && (player->inputKeyDown & PAD_KEY_RIGHT) != 0))
            {
                player->objWork.velocity.x = 0;
                player->objWork.groundVel  = 0;
            }
            player->objWork.velocity.y = -(player->jumpForce + (player->jumpForce >> 2));

            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HOP_JUMP);
            PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], (mtMathRand() & 3) + SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YEA);
            break;

        case CHARACTER_BLAZE:
            ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);

            player->axelTornadoFXSpawnTimer = 0;
            player->cameraScrollDelay       = 6;
            player->objWork.velocity.y      = -2 * player->jumpForce;
            ShakeScreen(SCREENSHAKE_B_SHORT);

            if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                player->objWork.groundVel = player->objWork.velocity.x = MATH_ABS(player->objWork.velocity.x);
            }
            else if ((player->inputKeyDown & PAD_KEY_LEFT) != 0)
            {
                player->objWork.groundVel = player->objWork.velocity.x = -MATH_ABS(player->objWork.velocity.x);
            }
            else
            {
                player->objWork.groundVel = player->objWork.velocity.x = 0;
            }

            CreateEffectFlameJetForPlayer(player);

            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ACCEL_TORNADO);
            PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], (mtMathRand() & 3) + SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FUN);
            break;
    }

    player->playerFlag &= ~(PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_USER_FLAG);
    player->playerFlag |= PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_USER_FLAG;
    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;

    Player__GiveScore(player, PLAYER_SCOREBONUS_TRICKFINISHER_V);

    if (player->starComboManager == NULL)
        player->starComboCount = 0;

    StarCombo__FinishTrickCombo(player, TRUE);
}

void Player__Action_TrickFinisherHorizontal(Player *player)
{
    u16 angle = 0;

    ApplyPlayerTensionPenalty(player);

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH_H_01);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_TRICK_FINISH_H_01);
    }

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->playerFlag |= PLAYER_FLAG_8000;
    SetTaskState(&player->objWork, Player__State_Air);

    player->objWork.velocity.y = 0;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_USER_FLAG;

    switch (player->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                angle -= FLOAT_DEG_TO_IDX(90.0);
            else
                angle += FLOAT_DEG_TO_IDX(90.0);

            fx32 xVelocity = MultiplyFX(2 * player->jumpForce, SinFX((s32)angle));
            if ((xVelocity > 0 && player->objWork.velocity.x < 0) || (xVelocity < 0 && player->objWork.velocity.x > 0))
                player->objWork.velocity.x = 0;
            player->objWork.velocity.x += xVelocity;

            ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);
            CreateEffectHummingTopForPlayer(player);

            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HUMMING_TOP);

            PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], (mtMathRand() & 3) + SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YEA);
            player->overSpeedLimitTimer = 12;
            break;

        case CHARACTER_BLAZE:
            player->trickFinishHorizXVelocity = player->objWork.velocity.x;
            player->objWork.velocity.x        = 2 * player->topSpeed_SuperBoost;
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                player->objWork.velocity.x = -player->objWork.velocity.x;

            if (MATH_ABS(player->trickFinishHorizXVelocity) < FLOAT_TO_FX32(3.0))
                player->trickFinishHorizXVelocity = player->objWork.velocity.x >> 3;
            player->objWork.hitstopTimer        = FLOAT_TO_FX32(4.0);
            player->objWork.shakeTimer          = FLOAT_TO_FX32(4.0);
            player->overSpeedLimitTimer         = 16;
            player->trickFinishHorizFreezeTimer = 16;
            CreateEffectFlameJetForPlayer(player);

            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STEP_JUMP);

            PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], (mtMathRand() & 3) + SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FUN);
            break;
    }

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_4000;
    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;

    Player__GiveScore(player, PLAYER_SCOREBONUS_TRICKFINISHER_H);

    if (player->starComboManager == NULL)
        player->starComboCount = 0;

    StarCombo__FinishTrickCombo(player, TRUE);
}

void PLayer__PerformGrindTrick(Player *player)
{
    player->tensionPenalty = 0;

    if (player->actionState == PLAYER_ACTION_GRINDTRICK_1 || player->actionState == PLAYER_ACTION_GRINDTRICK_SNOWBOARD_1)
    {
        // performing the second trick!

        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            Player__ChangeAction(player, PLAYER_ACTION_GRINDTRICK_2);
        }
        else
        {
            Player__ChangeAction(player, PLAYER_ACTION_GRINDTRICK_SNOWBOARD_2);
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_GRINDTRICK_2);
        }

        Player__GiveTension(player, PLAYER_TENSION_TRICK);

        switch (player->characterID)
        {
            // case CHARACTER_SONIC:
            default:
                if ((mtMathRand() & 1) != 0)
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YAHOO);
                else
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OK);

                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GRIND_BODY);
                break;

            case CHARACTER_BLAZE:
                if ((mtMathRand() & 1) != 0)
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YA_BL);
                else
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HA);

                PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_GRIND_BODY);
                break;
        }

        PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_SUC2);
    }
    else
    {
        if (player->actionState == PLAYER_ACTION_GRINDTRICK_2 || player->actionState == PLAYER_ACTION_GRINDTRICK_SNOWBOARD_2)
        {
            // performing the third and final trick!

            if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
            {
                Player__ChangeAction(player, PLAYER_ACTION_GRINDTRICK_3_01);
            }
            else
            {
                Player__ChangeAction(player, PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_01);
                ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_GRINDTRICK_3_01);
            }

            // x2 tension for completing the chain!
            Player__GiveTension(player, PLAYER_TENSION_TRICKFINISH);

            switch (player->characterID)
            {
                // case CHARACTER_SONIC:
                default:
                    if ((mtMathRand() & 1) != 0)
                        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ALL_RIGHT);
                    else
                        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COOL);

                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GRIND_DERIVE);
                    break;

                case CHARACTER_BLAZE:
                    if ((mtMathRand() & 1) != 0)
                        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YOSHI);
                    else
                        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TA);

                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_GRIND_DERIVE);
                    break;
            }

            StopPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GALLERY_MAX);

            // give the player a lol boost as a reward!
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                player->objWork.groundVel -= FLOAT_TO_FX32(0.125);
            else
                player->objWork.groundVel += FLOAT_TO_FX32(0.125);

            player->objWork.userWork = 0;
            Player__GiveScore(player, PLAYER_SCOREBONUS_GRIND_TRICK_FINISH);
        }
        else
        {
            // performing the first trick!

            if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
            {
                Player__ChangeAction(player, PLAYER_ACTION_GRINDTRICK_1);
            }
            else
            {
                Player__ChangeAction(player, PLAYER_ACTION_GRINDTRICK_SNOWBOARD_1);
                ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_GRINDTRICK_1);
            }

            Player__GiveTension(player, PLAYER_TENSION_TRICK);

            switch (player->characterID)
            {
                // case CHARACTER_SONIC:
                default:
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_YEA);
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GRIND_BODY);
                    break;

                case CHARACTER_BLAZE:
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FUN);
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_GRIND_BODY);
                    break;
            }

            PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_SUC1);
        }
    }

    player->playerFlag |= PLAYER_FLAG_8000;
    StarCombo__DisplayConfetti(player);
    Player__GiveScore(player, PLAYER_SCOREBONUS_GRIND_TRICK);
    player->objWork.userTimer  = 0;
    player->trickCooldownTimer = 0;
}

void Player__Action_HomingAttack_Sonic(Player *player)
{
    GameObjectTask *target = player->homingTarget;
    if (target == NULL)
    {
        Player__Action_JumpDash(player);
        return;
    }

    fx32 distX = target->objWork.position.x - player->objWork.position.x;
    fx32 distY = target->objWork.position.y - player->objWork.position.y;

    u16 angle = FX_Atan2Idx(distY, distX);
    angle += player->objWork.fallDir;

    s32 lengthSquared = FX32_TO_WHOLE(distX) * FX32_TO_WHOLE(distX) + FX32_TO_WHOLE(distY) * FX32_TO_WHOLE(distY);

    if (angle >= FX_DEG_TO_IDX(FLOAT_TO_FX32(180.0)) || lengthSquared >= FLOAT_TO_FX32(8.0))
    {
        Player__Action_JumpDash(player);
        return;
    }

    Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);
    Player__SetAnimSpeedFromVelocity(player, FLOAT_TO_FX32(8.0));
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    player->playerFlag |= PLAYER_FLAG_DISABLE_HOMING_ATTACK;
    player->objWork.dir.z = 0;
    SetTaskState(&player->objWork, Player__State_HomingAttack);
    player->objWork.userTimer = PLAYER_HOMINGATTACK_DURATION;
    ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);
    player->playerFlag &= ~(PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HOMING);
}

void Player__State_HomingAttack(Player *work)
{
    if (work->objWork.userTimer == 0)
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->playerFlag &= ~PLAYER_GIMMICK_40;
        Player__Action_Launch(work);
        return;
    }

    work->objWork.userTimer--;

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->playerFlag &= ~PLAYER_GIMMICK_40;

        Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
        work->onLandGround(work);
        if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_LANDING);

        return;
    }

    GameObjectTask *target = work->homingTarget;
    if (target)
    {
        u32 targetAngle = FX_Atan2Idx(target->objWork.position.y - work->objWork.position.y, target->objWork.position.x - work->objWork.position.x);
        targetAngle += work->objWork.fallDir;
        targetAngle = (u16)targetAngle;

        // move towards target at 8 units/frame
        work->objWork.velocity.x = PLAYER_HOMINGATTACK_SPEED * FX_CosIdx((u16)targetAngle);
        work->objWork.velocity.y = PLAYER_HOMINGATTACK_SPEED * FX_SinIdx((u16)targetAngle);

        if (work->objWork.velocity.x < 0)
        {
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        }
        else if (work->objWork.velocity.x > 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        }

        if (MATH_ABS(work->objWork.velocity.x) > FLOAT_TO_FX32(0.0625))
        {
            if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
            {
                work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
                work->playerFlag &= ~PLAYER_FLAG_DISABLE_HOMING_ATTACK;
                Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
                work->onLandGround(work);
            }
        }
    }
}

void Player__Action_FlameHover(Player *player)
{
    if (player->blazeHoverTimer != 0)
    {
        player->objWork.displayFlag |= DISPLAY_FLAG_400;
        Player__ChangeAction(player, PLAYER_ACTION_FLAMEHOVER);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->playerFlag &= ~(PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);

        if ((player->gimmickFlag & PLAYER_GIMMICK_1000) == 0)
            CreateEffectFlameJetForPlayer(player);

        player->objWork.velocity.y = 0;
        if ((player->gimmickFlag & PLAYER_GIMMICK_1000) != 0)
            player->objWork.velocity.z = 0;

        // manual physics override
        player->objWork.gravityStrength  = FLOAT_TO_FX32(0.03125);
        player->objWork.terminalVelocity = FLOAT_TO_FX32(2.125);
        player->acceleration             = FLOAT_TO_FX32(0.1875);
        player->deceleration             = FLOAT_TO_FX32(0.375);
        player->acceleration_SuperBoost  = FLOAT_TO_FX32(0.21875);
        player->deceleration_SuperBoost  = FLOAT_TO_FX32(0.375);

        SetTaskState(&player->objWork, Player__State_FlameHover);

        if (player->objWork.move.y > FLOAT_TO_FX32(0.1875))
        {
            player->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
            player->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
        }

        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TWO_JUMP);
    }
}

void Player__State_FlameHover(Player *work)
{
    if ((work->gimmickFlag & PLAYER_GIMMICK_1000) == 0 && (playerGameStatus.stageTimer & 7) == 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
    {
        CreateEffectFlameJetForPlayer(work);
    }

    if (work->blazeHoverTimer != 0)
        work->blazeHoverTimer--;

    Player__HandleAirDrag(work);
    Player__HandleAirMovement(work);

    if ((work->inputKeyDown & PAD_BUTTON_R) == 0 || work->blazeHoverTimer == 0)
    {
        Player__InitPhysics(work);
        work->objWork.groundVel = work->objWork.velocity.x;
        work->objWork.displayFlag |= DISPLAY_FLAG_400;
        Player__Action_Launch(work);
    }
    else if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        Player__InitPhysics(work);
        Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
        work->onLandGround(work);

        if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_LANDING);
    }
}

void Player__HandleAirDrag(Player *player)
{
    player->objWork.dir.z = ObjRoopMove16((u16)player->objWork.dir.z, 0, FLOAT_TO_FX32(0.125));

    if ((player->gimmickFlag & (PLAYER_GIMMICK_100 | PLAYER_GIMMICK_1000 | PLAYER_GIMMICK_20000000)) == 0)
    {
        player->objWork.position.z = ObjSpdDownSet(player->objWork.position.z, FLOAT_TO_FX32(4.0)) & 0xFFFFF000;
        player->objWork.velocity.z = ObjSpdDownSet(player->objWork.velocity.z, FLOAT_TO_FX32(0.125));
        player->objWork.dir.x      = ObjRoopMove16((u16)player->objWork.dir.x, 0, FLOAT_TO_FX32(0.25));
    }

    if ((player->gimmickFlag & PLAYER_GIMMICK_2000000) == 0)
    {
        if (player->objWork.scale.x != FLOAT_TO_FX32(1.0))
        {
            fx32 value = (player->objWork.scale.x - FLOAT_TO_FX32(1.0));
            player->objWork.scale.x -= value - ObjSpdDownSet(value, FLOAT_TO_FX32(0.03125));
        }

        if (player->objWork.scale.y != FLOAT_TO_FX32(1.0))
        {
            fx32 value = (player->objWork.scale.y - FLOAT_TO_FX32(1.0));
            player->objWork.scale.y -= value - ObjSpdDownSet(value, FLOAT_TO_FX32(0.03125));
        }

        if (player->objWork.scale.z != FLOAT_TO_FX32(1.0))
        {
            fx32 value = (player->objWork.scale.z - FLOAT_TO_FX32(1.0));
            player->objWork.scale.z -= value - ObjSpdDownSet(value, FLOAT_TO_FX32(0.03125));
        }
    }
}

void Player__HandleZMovement(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_100) != 0)
    {
        if (player->objWork.position.z >= FLOAT_TO_FX32(0.0))
        {
            player->objWork.position.z = FLOAT_TO_FX32(0.0);
            player->objWork.velocity.z = FLOAT_TO_FX32(0.0);
        }

        if (player->objWork.position.z <= -FLOAT_TO_FX32(40.0))
        {
            player->objWork.position.z = -FLOAT_TO_FX32(40.0);
            player->objWork.velocity.z = FLOAT_TO_FX32(0.0);
        }

        fx32 acceleration = player->acceleration << 1;
        fx32 deceleration = player->deceleration;
        fx32 topSpeed     = player->topSpeed;
        if ((player->playerFlag & PLAYER_FLAG_BOOST) != 0)
            topSpeed = player->topSpeed_Boost;

        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
        {
            acceleration = player->acceleration_SuperBoost;
            deceleration = player->deceleration_SuperBoost;
            topSpeed     = player->topSpeed_SuperBoost;
        }

        if ((player->inputKeyDown & (PAD_KEY_DOWN | PAD_KEY_UP)) != 0)
        {
            if ((player->inputKeyDown & PAD_KEY_DOWN) != 0)
            {
                if (player->objWork.velocity.z < 0)
                    player->objWork.velocity.z = ObjSpdDownSet(player->objWork.velocity.z, deceleration);

                player->objWork.velocity.z = ObjSpdUpSet(player->objWork.velocity.z, acceleration, topSpeed);
            }
            else
            {
                if (player->objWork.velocity.z > 0)
                    player->objWork.velocity.z = ObjSpdDownSet(player->objWork.velocity.z, deceleration);

                player->objWork.velocity.z = ObjSpdUpSet(player->objWork.velocity.z, -acceleration, topSpeed);
            }
        }
        else
        {
            player->objWork.velocity.z = ObjSpdDownSet(player->objWork.velocity.z, deceleration);
        }
    }
}

void Player__HandleLapEventManager(Player *player)
{
    if (CheckStageUsesLaps())
    {
        fx32 wrapOffset;
        BOOL allowSpawn = FALSE;

        wrapOffset = FX32_FROM_WHOLE(mapCamera.camControl.width) - FLOAT_TO_FX32(256.0);
        if (player->objWork.position.x >= wrapOffset)
        {
            wrapOffset = -(wrapOffset - FLOAT_TO_FX32(256.0));
        }
        else if (player->objWork.position.x < FLOAT_TO_FX32(256.0))
        {
            wrapOffset = (wrapOffset - FLOAT_TO_FX32(256.0));
        }
        else
        {
            return;
        }

        player->objWork.position.x += wrapOffset;
        player->objWork.prevPosition.x += wrapOffset;

        if (CheckIsPlayer1(player))
        {
            startingPosX += FX32_TO_WHOLE(wrapOffset);
            SetPlayerTrailOffset(wrapOffset);
        }

        s32 left  = FX32_TO_WHOLE(player->objWork.position.x) - HW_LCD_WIDTH;
        s32 right = FX32_TO_WHOLE(player->objWork.position.x) + HW_LCD_WIDTH;

        s32 top, bottom;
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) == 0)
        {
            allowSpawn = TRUE;

            if (mapCamera.camera[0].targetPlayerID == player->controlID)
                mapCamera.camera[0].disp_pos.x += wrapOffset;

            if (mapCamera.camera[1].targetPlayerID == player->controlID)
                mapCamera.camera[1].disp_pos.x += wrapOffset;

            top    = FX32_TO_WHOLE(player->objWork.position.y) - ((1 * HW_LCD_HEIGHT) + 96);
            bottom = FX32_TO_WHOLE(player->objWork.position.y) + ((1 * HW_LCD_HEIGHT) + 96);
        }
        else
        {
            if (CheckIsPlayer1(player))
            {
                allowSpawn = TRUE;

                mapCamera.camera[0].disp_pos.x += wrapOffset;
                mapCamera.camera[1].disp_pos.x += wrapOffset;

                if (player->objWork.position.y > MapSys__GetScreenSwapPos(player->objWork.position.x))
                {
                    // bottom screen
                    top    = FX32_TO_WHOLE(player->objWork.position.y) - ((2 * HW_LCD_HEIGHT) + 96);
                    bottom = FX32_TO_WHOLE(player->objWork.position.y) + ((1 * HW_LCD_HEIGHT) + 96);
                }
                else
                {
                    // top screen
                    top    = FX32_TO_WHOLE(player->objWork.position.y) - ((1 * HW_LCD_HEIGHT) + 96);
                    bottom = FX32_TO_WHOLE(player->objWork.position.y) + ((2 * HW_LCD_HEIGHT) + 96);
                }
            }
        }

        if (allowSpawn)
        {
            left   = ClampS32(left, 0x0000, 0xFFFF);
            top    = ClampS32(top, 0x0000, 0xFFFF);
            right  = ClampS32(right, 0x0000, 0xFFFF);
            bottom = ClampS32(bottom, 0x0000, 0xFFFF);

            EventManager__CreateEventsUnknown(left, top, right, bottom);
        }
    }
}

void Player__HandleLapStageWrap(Player *player)
{
    if (CheckStageUsesLaps())
    {
        fx32 wrapBounds = FX32_FROM_WHOLE(mapCamera.camControl.width) - FLOAT_TO_FX32(256.0);

        fx32 wrapOffset;
        if (gPlayer->objWork.position.x <= (mapCamera.camControl.width << (FX32_SHIFT - 1)) && player->objWork.position.x >= wrapBounds - FLOAT_TO_FX32(256.0))
        {
            wrapOffset = -(wrapBounds - FLOAT_TO_FX32(256.0));
        }
        else if (gPlayer->objWork.position.x > (mapCamera.camControl.width << (FX32_SHIFT - 1)) && player->objWork.position.x <= FLOAT_TO_FX32(512.0))
        {
            wrapOffset = (wrapBounds - FLOAT_TO_FX32(256.0));
        }
        else
        {
            return;
        }

        player->objWork.position.x += wrapOffset;
        player->objWork.prevPosition.x += wrapOffset;
    }
}

void Player__HandleMaxPush(Player *player)
{
    if (player->actionState == PLAYER_ACTION_PUSH_02 || (player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_2000000;
        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
            player->objWork.pushCap = player->topSpeed_SuperBoost >> 1;
        else
            player->objWork.pushCap = playerPhysicsTable[player->characterID].pushCap;
    }
    else
    {
        player->objWork.pushCap = playerPhysicsTable[player->characterID].pushCap;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_2000000;
    }
}

void Player__HandleGroundCollisions(Player *player)
{
    if ((player->gimmickFlag & PLAYER_GIMMICK_1) == 0)
        return;

    u16 dir = FLOAT_DEG_TO_IDX(0.0);

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) == 0)
        return;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));
    }
    else
    {
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING) != 0)
        {
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                Player__Action_LandOnGround(player, FLOAT_TO_FX32(6.0));
            else
                Player__Action_LandOnGround(player, FLOAT_TO_FX32(10.0));

            OBS_COL_CHK_DATA pData;
            pData.x    = FX32_TO_WHOLE(player->objWork.position.x);
            pData.y    = FX32_TO_WHOLE(player->objWork.position.y) + player->objWork.hitboxRect.top - 4;
            pData.flag = player->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B;
            pData.vec  = OBJ_COL_VEC_DOWN;
            pData.dir  = &dir;
            pData.attr = 0;

            dir = player->objWork.dir.z;
            ObjDiffCollisionFast(&pData);
            player->objWork.dir.z = dir;
        }
        else
        {
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                {
                    Player__Action_LandOnGround(player, FLOAT_TO_FX32(4.0));
                }
                else
                {
                    Player__Action_LandOnGround(player, FLOAT_TO_FX32(12.0));
                }
            }
            else if ((player->objWork.moveFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                {
                    Player__Action_LandOnGround(player, FLOAT_TO_FX32(12.0));
                }
                else
                {
                    Player__Action_LandOnGround(player, FLOAT_TO_FX32(4.0));
                }
            }
        }
    }

    if ((player->gimmickFlag & PLAYER_GIMMICK_2) != 0)
    {
        player->objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        player->objWork.groundVel = -player->objWork.groundVel;
    }

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
    player->gimmickFlag &= ~(PLAYER_GIMMICK_2 | PLAYER_GIMMICK_1);

    player->onLandGround(player);
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) != 0)
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOARD_LANDING);
}

void Player__HandleTensionDrain(Player *player)
{
    fx32 posX;
    if (GetVSBattlePosition(player) == 1)
    {
        Player *rival;

        fx32 playerX;
        fx32 playerY;

        if (gmCheckRaceBattle())
            playerX = (FX32_FROM_WHOLE(mapCamera.camControl.width) - FLOAT_TO_FX32(512.0)) * (playerGameStatus.playerLapCounter[0] - playerGameStatus.playerLapCounter[1])
                      + gPlayerList[0]->objWork.position.x;
        else
            playerX = gPlayerList[0]->objWork.position.x;

        playerY = gPlayerList[0]->objWork.position.y;

        rival              = gPlayerList[1];
        fx32 x             = MATH_SQUARED(FX32_TO_WHOLE(playerX - rival->objWork.position.x));
        posX               = x;
        fx32 y             = MATH_SQUARED(FX32_TO_WHOLE(playerY - rival->objWork.position.y));
        fx32 rivalDistance = posX + y;

        fx32 tensionPityBonus;
        if (rivalDistance <= FLOAT_TO_FX32(16.0))
        {
            tensionPityBonus = 1;
        }
        else if (rivalDistance <= FLOAT_TO_FX32(64.0))
        {
            tensionPityBonus = 2;
        }
        else
        {
            tensionPityBonus = 3;
        }

        if (player->tension < PLAYER_TENSION_MAX - tensionPityBonus)
            Player__GiveTension(player, tensionPityBonus);
    }

    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0 && !player->tensionMaxTimer && (!player->gimmickObj || (player->gimmickFlag & PLAYER_GIMMICK_8) != 0)
        && (player->playerFlag & PLAYER_FLAG_DISABLE_TENSION_DRAIN) == 0)
    {
        Player__GiveTension(player, -PLAYER_SUPERBOOST_DRAIN_SPEED);
    }
}

void Player__GiveScore(Player *player, u32 score)
{
    // calculate star bonus
    u32 starBonus = 0;
    switch (player->starComboCount)
    {
        case 0:
            starBonus = 0;
            break;

        case 1:
            starBonus = 200;
            break;

        case 2:
            starBonus = 400;
            break;

        // 3+ stars cap out at 600 bonus
        default:
            starBonus = 600;
            break;
    }

    // penalize score
    starBonus >>= player->tensionPenalty;
    score >>= player->tensionPenalty;

    StarCombo__InitScoreBonus(player, starBonus);
    StarCombo__InitScoreBonus(player, score);

    playerGameStatus.trickBonus += score + starBonus;
    playerGameStatus.trickBonus = MATH_MIN(playerGameStatus.trickBonus, PLAYER_MAX_SCORE);

    player->starComboCount++;
}

void Player__ApplyClingWeight(Player *player)
{
    player->clingWeight++;
    if (player->clingWeight > PLAYER_CLINGWEIGHT_MAX)
        player->clingWeight = PLAYER_CLINGWEIGHT_MAX;

    if (player->prevClingWeight != player->clingWeight)
        Player__InitPhysics(player);
}

BOOL Player__IsBalancing(Player *player, BOOL updateAction)
{
    if ((player->objWork.dir.z & 0x7FFF) != 0 || player->objWork.rideObj != NULL)
        return FALSE; // can't collide

    OBS_COL_CHK_DATA colWork;
    colWork.x    = FX32_TO_WHOLE(player->objWork.position.x);
    colWork.y    = FX32_TO_WHOLE(player->objWork.position.y) + player->objWork.hitboxRect.bottom;
    colWork.flag = player->objWork.flag & STAGE_TASK_FLAG_ON_PLANE_B;
    colWork.vec  = OBJ_COL_VEC_UP;
    colWork.dir  = 0;
    colWork.attr = 0;
    if (ObjDiffCollision(&colWork) > 0)
    {
        colWork.x     = FX32_TO_WHOLE(player->objWork.position.x) + player->objWork.hitboxRect.left - 2;
        s32 distanceL = ObjDiffCollision(&colWork);

        colWork.x     = FX32_TO_WHOLE(player->objWork.position.x) + player->objWork.hitboxRect.right + 2;
        s32 distanceR = ObjDiffCollision(&colWork);

        if (distanceL <= 0 && distanceR >= 16)
        {
            if (updateAction)
            {
                player->objWork.displayFlag &= ~DISPLAY_FLAG_400;
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    Player__ChangeAction(player, PLAYER_ACTION_BALANCE_BACKWARD);
                else
                    Player__ChangeAction(player, PLAYER_ACTION_BALANCE_FORWARD);
            }

            // collided on the left only!
            return TRUE;
        }

        if (distanceL >= 16 && distanceR <= 0)
        {
            if (updateAction)
            {
                player->objWork.displayFlag &= ~DISPLAY_FLAG_400;
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    Player__ChangeAction(player, PLAYER_ACTION_BALANCE_FORWARD);
                else
                    Player__ChangeAction(player, PLAYER_ACTION_BALANCE_BACKWARD);
            }

            // collided on the right only!
            return TRUE;
        }
    }

    // didn't collide...
    return FALSE;
}

void Player__FinishTurningSkidding(Player *player)
{
    if (player->actionState >= PLAYER_ACTION_BRAKE1_01 && player->actionState <= PLAYER_ACTION_BRAKE2_03)
        StopPlayerSfx(player, PLAYER_SEQPLAYER_COMMON);

    if (player->actionState == PLAYER_ACTION_TURNING || (player->actionState >= PLAYER_ACTION_BRAKE1_01 && player->actionState <= PLAYER_ACTION_BRAKE2_03))
    {
        if ((player->playerFlag & PLAYER_FLAG_USER_FLAG) != 0)
            player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        else
            player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    }
}

void Player__HandleSuperBoost(Player *player)
{
    if (CheckIsPlayer1(player))
    {
        if ((player->inputKeyPress & PAD_BUTTON_Y) != 0 &&                                                                                   // if player is pressing Y...
            (StageTaskStateMatches(&player->objWork, Player__State_Air) == FALSE || (player->playerFlag & PLAYER_FLAG_ALLOW_TRICKS) == 0) && // ...and isn't in the air
            !IsBossStage() &&                                                                                                                // ...and the stage isn't a boss
            (player->playerFlag & PLAYER_FLAG_DISABLE_TENSION_DRAIN) == 0 &&                                                                 // ...and we CAN drain tension
            ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || Player__CheckOnCorkscrewPath(player)) &&                       // ...and we're not in the air
            player->superBoostCooldownTimer == 0)                                                                                            // ...and we don't have a cooldown
        {
            if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0 && player->tension >= PLAYER_SUPERBOOST_MINIMUM && (player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
                Player__Action_SuperBoost(player);
        }

        if ((!player->gimmickObj || (player->gimmickFlag & PLAYER_GIMMICK_8) != 0) && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0
                && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT) == 0 && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) == 0
                && (player->actionState <= PLAYER_ACTION_HANG_ROT || player->actionState >= PLAYER_ACTION_3D)
            || player->tension == 0)
        {
            if (player->minBoostVelocity > MATH_ABS(player->objWork.move.x) + MATH_ABS(player->objWork.move.y))
            {
                player->boostEndTimer++;
                if (player->boostEndTimer > 8 || player->tension == 0)
                    Player__Action_StopBoost(player);
            }
            else
            {
                player->boostEndTimer = 0;
            }
        }

        if ((player->inputKeyDown & PAD_BUTTON_Y) == 0 || (player->playerFlag & PLAYER_FLAG_BOOST) == 0 || player->tension == 0)
            Player__Action_StopSuperBoost(player);

        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
            player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

        if (player->gimmickObj == NULL)
        {
            if ((player->gimmickFlag & PLAYER_GIMMICK_8) == 0)
            {
                if ((playerGameStatus.stageTimer & 7) == 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
                {
                    if (MATH_ABS(player->objWork.move.x) + MATH_ABS(player->objWork.move.y) > FLOAT_TO_FX32(0.125))
                    {
                        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0 && (player->playerFlag & PLAYER_FLAG_BOOST) != 0
                            && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                        {
                            if ((player->gimmickFlag & PLAYER_GIMMICK_1000) == 0)
                                CreateEffectBoostParticle(player, -FLOAT_TO_FX32(13.0), FLOAT_TO_FX32(13.0));
                            else
                                CreateEffectBoostParticle(player, -FLOAT_TO_FX32(13.0), FLOAT_TO_FX32(0.0));
                        }
                    }
                }

                if ((playerGameStatus.stageTimer & 3) == 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0 && player->characterID == 1
                    && (player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
                {
                    CreateEffectFlameDustForPlayerBlaze(player);
                }
            }
        }

        if (player->superBoostCooldownTimer)
            player->superBoostCooldownTimer--;
    }
}

void Player__HandleBoost(Player *player)
{
    s32 boostActivationTime = playerPhysicsTable[player->characterID].boostActivationTime;

    if (!IsBossStage())
    {
        if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
        {
            player->boostTimer = boostActivationTime;
        }
        else if ((player->inputKeyDown & (PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0)
        {
            if (MATH_ABS(player->objWork.groundVel) >= player->topSpeed && ++player->boostTimer >= boostActivationTime)
            {
                if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                    Player__Action_Boost(player);

                player->boostTimer = boostActivationTime;
            }
        }
    }
}

void Player__HandleHomingTarget(Player *player)
{
    u8 i;
    GameObjectTask *newTarget;
    s32 smallestDist;
    GameObjectTask *prevHomingTarget;

    prevHomingTarget = player->homingTarget;
    newTarget        = NULL;
    smallestDist     = 0x7FFFFFFF;

    if (prevHomingTarget != NULL && IsStageTaskDestroyed(&prevHomingTarget->objWork))
        player->homingTarget = NULL;

    if ((player->playerFlag & PLAYER_FLAG_DISABLE_HOMING_ATTACK) == 0 && !IsBossStage())
    {
        for (i = 0; TRUE; i++)
        {
            OBS_RECT_WORK *rect = ObjRect__RegistGet(2, i);
            if (rect == NULL)
                break; // end of list

            if ((rect->flag & OBS_RECT_WORK_FLAG_800) == 0)
            {
                GameObjectTask *target = (GameObjectTask *)rect->parent;
                if (target != NULL)
                {
                    if (target->objWork.objType == STAGE_OBJ_TYPE_ENEMY)
                    {
                        fx32 distX = FX32_TO_WHOLE(target->objWork.position.x - player->objWork.position.x);
                        fx32 distY = FX32_TO_WHOLE(target->objWork.position.y - player->objWork.position.y);

                        s32 targetDist = MATH_SQUARED(distX) + MATH_SQUARED(distY);
                        if (smallestDist > targetDist)
                        {
                            smallestDist = targetDist;
                            newTarget    = target;
                        }
                    }
                }
            }
        }

        player->homingTarget = newTarget;
    }
}

BOOL Player__HandleGrinding(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0 && (player->objWork.collisionFlag & STAGE_TASK_COLLISION_FLAG_GRIND_RAIL) != 0)
    {
        if ((player->actionState < PLAYER_ACTION_GRIND || player->actionState > PLAYER_ACTION_GRINDTRICK_3_03)
            && (player->actionState < PLAYER_ACTION_GRIND_SNOWBOARD || player->actionState > PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_03))
        {
            Player__Action_Grind(player);
        }
        return TRUE;
    }

    return FALSE;
}

void Player__HandleWaterEntry(Player *player)
{
    if (CheckIsPlayer1(player) == FALSE || (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return;

    if (mapCamera.camera[player->cameraID].waterLevel != 0)
    {
        if (mapCamera.camera[player->cameraID].waterLevel < FX32_TO_WHOLE(player->objWork.position.y))
        {
            if ((player->playerFlag & PLAYER_FLAG_IN_WATER) == 0)
            {
                if (player->invincibleTimer == 0)
                    ChangeStageBGMVariant(TRUE);

                CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(8.0), mapCamera.camera[player->cameraID].waterLevel);
                CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(7.0), mapCamera.camera[player->cameraID].waterLevel);
                CreateEffectWaterBubbleForPlayer(player, -FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(6.0), mapCamera.camera[player->cameraID].waterLevel);

                player->objWork.velocity.y = 0;

                if (playerGameStatus.recallTime + 1 < playerGameStatus.stageTimer)
                {
                    CreateEffectWaterSplashForPlayer(player);
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WATER);
                }
            }

            player->playerFlag |= PLAYER_FLAG_IN_WATER;

            if (!IsBossStage() && (player->playerFlag & PLAYER_FLAG_DEATH) == 0)
                player->waterTimer++;
        }
        else
        {
            if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
            {
                if (player->invincibleTimer == 0)
                    ChangeStageBGMVariant(FALSE);

                if (playerGameStatus.recallTime + 1 < playerGameStatus.stageTimer)
                {
                    CreateEffectWaterSplashForPlayer(player);
                    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WATER);
                }

                player->objWork.gravityStrength  = playerPhysicsTable[player->characterID].gravityStrength;
                player->objWork.terminalVelocity = playerPhysicsTable[player->characterID].terminalVelocity;
            }

            player->playerFlag &= ~PLAYER_FLAG_IN_WATER;
            player->waterTimer = 0;

            return;
        }
    }
    else
    {
        player->playerFlag &= ~PLAYER_FLAG_IN_WATER;
        player->waterTimer = 0;

        return;
    }

    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0 && (playerGameStatus.stageTimer & 0x1F) == 0)
    {
        if ((mtMathRand() & 3) == 0)
            CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[player->cameraID].waterLevel);
    }

    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
    {
        s16 airTimer = player->airTimer - player->waterTimer;

        switch (airTimer)
        {
            case 120:
                CreateEffectDrownAlertForPlayer(player, COUNTDOWNBUBBLE_ANI_BUBBLE_0);
                break;

            case 240:
                CreateEffectDrownAlertForPlayer(player, COUNTDOWNBUBBLE_ANI_BUBBLE_1);
                break;

            case 360:
                CreateEffectDrownAlertForPlayer(player, COUNTDOWNBUBBLE_ANI_BUBBLE_2);
                break;

            case 480:
                CreateEffectDrownAlertForPlayer(player, COUNTDOWNBUBBLE_ANI_BUBBLE_3);
                break;

            case 600:
                CreateEffectDrownAlertForPlayer(player, COUNTDOWNBUBBLE_ANI_BUBBLE_4);
                break;

            case 680:
                PlayPlayerJingle(player, SND_ZONE_SEQ_SEQ_BRETHLESS);
                break;

            case 720:
                CreateEffectDrownAlertForPlayer(player, COUNTDOWNBUBBLE_ANI_BUBBLE_5);
                CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[player->cameraID].waterLevel);
                break;
        }

        if (player->waterTimer > player->airTimer)
        {
            Player__Action_Die(player);

            if (!IsBossStage())
                player->objWork.velocity.y = 0;

            CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[player->cameraID].waterLevel);
            CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(4.0), mapCamera.camera[player->cameraID].waterLevel);
            CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(2.0), mapCamera.camera[player->cameraID].waterLevel);
            CreateEffectWaterBubbleForPlayer(player, -FLOAT_TO_FX32(4.0), -FLOAT_TO_FX32(6.0), mapCamera.camera[player->cameraID].waterLevel);
        }
    }
}

void Player__HandleGravitySwapping(Player *player)
{
    if (Player__UseUpsideDownGravity(player->objWork.position.x, player->objWork.position.y))
    {
        if (player->objWork.fallDir == FLOAT_DEG_TO_IDX(0.0))
        {
            if (player->invincibleTimer == 0)
                ChangeStageBGMVariant(TRUE);

            player->objWork.velocity.x = -player->objWork.velocity.x;
            player->objWork.velocity.y = -player->objWork.velocity.y;

            // BUG(?)
            // this should be 180.0?
            // (the original value was 0x80, like rush uses, while everything else uses 0x8000, which is rush adventure's standard)
            player->objWork.dir.z += FLOAT_DEG_TO_IDX(0.703125);

            player->keyMap.left  = PAD_KEY_RIGHT;
            player->keyMap.right = PAD_KEY_LEFT;
        }
        player->objWork.fallDir = FLOAT_DEG_TO_IDX(180.0);
    }
    else
    {
        if (player->objWork.fallDir == FLOAT_DEG_TO_IDX(180.0))
        {
            if (player->invincibleTimer == 0)
                ChangeStageBGMVariant(FALSE);

            player->objWork.velocity.x = -player->objWork.velocity.x;
            player->objWork.velocity.y = -player->objWork.velocity.y;

            player->objWork.dir.z += FLOAT_DEG_TO_IDX(180.0);

            player->keyMap.left  = PAD_KEY_LEFT;
            player->keyMap.right = PAD_KEY_RIGHT;
        }
        player->objWork.fallDir = FLOAT_DEG_TO_IDX(0.0);
    }
}

void Player__HandlePressure(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_800) != 0 && player->objWork.touchObj == NULL)
    {
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0 && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL) != 0)
            Player__Action_Die(player);
    }

    if (player->objWork.touchObj != NULL && (player->playerFlag & PLAYER_FLAG_DISABLE_PRESSURE_CHECK) == 0)
    {
        if (!player->objWork.rideObj && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0
            && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING) != 0 && player->objWork.touchObj->move.y <= 0)
        {
            player->pressureTimer = 0;
        }
        else
        {
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0 && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING) != 0
                || (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0 && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL) != 0)
            {
                Player__Action_Die(player);
            }
            else
            {
                player->pressureTimer = 0;
            }
        }
    }
    else
    {
        player->pressureTimer = 0;
    }
}

void Player__HandleTimeLimits(Player *player)
{
    if (CheckIsPlayer1(player) && gmCheckStage(STAGE_TUTORIAL) == FALSE)
    {
        if (gameState.gameMode == GAMEMODE_VS_BATTLE)
        {
            if (gameState.vsBattleType == VSBATTLE_RINGS)
            {
                if (playerGameStatus.stageTimer >= AKUTIL_TIME_TO_FRAMES(2, 00, 00) && (player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
                {
                    Player__Action_FinishMission(player, NULL);
                    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.5));
                }
            }
            else if (playerGameStatus.stageTimer >= AKUTIL_TIME_TO_FRAMES(9, 59, 99) && (player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
            {
                playerGameStatus.stageTimer = AKUTIL_TIME_TO_FRAMES(10, 00, 00);
                Player__Action_FinishMission(player, NULL);
                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.5));
            }
        }
        else if (gameState.gameMode == GAMEMODE_MISSION && playerGameStatus.missionStatus.stageTimeLimit != 0)
        {
            if (playerGameStatus.stageTimer >= playerGameStatus.missionStatus.stageTimeLimit)
                Player__Action_Die(player);
        }
        else
        {
            if ((saveGame.stage.status.timeLimit == TRUE || gameState.gameMode == GAMEMODE_TIMEATTACK) && playerGameStatus.stageTimer >= AKUTIL_TIME_TO_FRAMES(9, 59, 99))
            {
                playerGameStatus.recallTime = 0;
                gameState.gameFlag |= GAME_FLAG_HAS_TIME_OVER;
                Player__Action_Die(player);
            }
        }

        if (!gmCheckMissionType(MISSION_TYPE_PASS_FLAGS) && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
        {
            s32 timeLimitMin;
            s32 timeLimitMax;

            if (gmCheckRingBattle())
            {
                timeLimitMin = AKUTIL_TIME_TO_FRAMES(1, 40, 00);
                timeLimitMax = AKUTIL_TIME_TO_FRAMES(2, 00, 00);
            }
            else if (gameState.gameMode == GAMEMODE_MISSION && playerGameStatus.missionStatus.stageTimeLimit != 0)
            {
                timeLimitMax = playerGameStatus.missionStatus.stageTimeLimit;
                timeLimitMin = playerGameStatus.missionStatus.stageTimeLimit - AKUTIL_TIME_TO_FRAMES(0, 10, 00);
            }
            else
            {
                timeLimitMin = AKUTIL_TIME_TO_FRAMES(9, 39, 99);
                timeLimitMax = AKUTIL_TIME_TO_FRAMES(9, 59, 99);
            }

            if (playerGameStatus.stageTimer >= timeLimitMin && playerGameStatus.stageTimer <= timeLimitMax)
            {
                if (playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 00, 00)     // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 02, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 04, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 06, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 8, 00)   // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 10, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 12, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 14, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 16, 00)  // !Warning! Time's almost up
                    || playerGameStatus.stageTimer == timeLimitMin + AKUTIL_TIME_TO_FRAMES(0, 18, 00)) // !Warning! Time's almost up
                {
                    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COUNTDOWN);
                }
            }
        }
    }
}

void Player__HandleMissionComplete(Player *player)
{
    if (gameState.gameMode == GAMEMODE_MISSION)
    {
        BOOL finishedMission = FALSE;
        if ((player->playerFlag & (PLAYER_FLAG_DEATH | PLAYER_FLAG_FINISHED_STAGE)) == 0 && GetSysEventList()->currentEventID == SYSEVENT_STAGE_ACTIVE)
        {
            switch (gameState.missionType)
            {
                case MISSION_TYPE_PASS_FLAGS:
                    if (playerGameStatus.missionStatus.passedFlagID >= playerGameStatus.missionStatus.quota)
                        finishedMission = TRUE;
                    break;

                case MISSION_TYPE_COLLECT_RINGS:
                    if (player->rings >= playerGameStatus.missionStatus.quota)
                        finishedMission = TRUE;
                    break;

                case MISSION_TYPE_DEFEAT_ENEMIES:
                    if (playerGameStatus.missionStatus.enemyDefeatCount >= playerGameStatus.missionStatus.quota)
                        finishedMission = TRUE;
                    break;

                case MISSION_TYPE_PERFORM_COMBOS:
                    if (playerGameStatus.missionStatus.totalStarCount >= playerGameStatus.missionStatus.quota)
                    {
                        finishedMission = TRUE;
                        StarCombo__FinishTrickCombo(player, FALSE);
                    }
                    break;

                case MISSION_TYPE_PERFORM_TRICKS:
                    if (playerGameStatus.missionStatus.totalStarCount >= playerGameStatus.missionStatus.quota)
                    {
                        finishedMission = TRUE;
                        StarCombo__FinishTrickCombo(player, FALSE);
                    }
                    break;

                default:
                    break;
            }

            if (finishedMission)
                Player__Action_FinishMission(player, NULL);
        }
    }
}

void PlayerBoostCollider_State_ActiveLifetime(PlayerBoost *work)
{
    if (work->objWork.userTimer != 0)
    {
        work->objWork.userTimer--;
        if (work->objWork.userTimer == 0)
        {
            DestroyStageTask(&work->objWork);
            return;
        }

        StageTask__HandleCollider(&work->objWork, &work->collider);
    }
    else
    {
        if (work->objWork.parentObj != NULL)
        {
            work->objWork.position.x = work->objWork.parentObj->position.x;
            work->objWork.position.y = work->objWork.parentObj->position.y;

            work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            if ((work->objWork.parentObj->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            StageTask__HandleCollider(&work->objWork, &work->collider);
            return;
        }

        DestroyStageTask(&work->objWork);
    }
}

void SetBoostColliderToTrackPlayer(PlayerBoost *boost)
{
    SetTaskState(&boost->objWork, PlayerBoostCollider_State_ActiveBoosting);
}

void PlayerBoostCollider_State_ActiveBoosting(PlayerBoost *work)
{
    // shake the screen on impact
    if ((work->collider.flag & OBS_RECT_WORK_FLAG_200) != 0)
    {
        ShakeScreen(SCREENSHAKE_D_SHORT);
        work->collider.flag &= ~OBS_RECT_WORK_FLAG_200;
    }

    Player *parent = (Player *)work->objWork.parentObj;
    if (parent != NULL)
    {
        // track the parent (player)
        work->objWork.position.x = work->objWork.parentObj->position.x;
        work->objWork.position.y = work->objWork.parentObj->position.y;

        work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        if ((work->objWork.parentObj->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

        if ((parent->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
            DestroyStageTask(&work->objWork);

        StageTask__HandleCollider(&work->objWork, &work->collider);
    }
    else
    {
        DestroyStageTask(&work->objWork);
    }
}

void Player__ReceivePacket(Player *player)
{
    if (!gmCheckVsBattleFlag() || CheckIsPlayer1(player))
        return;

    ObjPacket__Func_2074DB4();

    struct PlayerSendPacket *playerPacket;
    if ((gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) == 0)
    {
        playerPacket = (struct PlayerSendPacket *)ObjPacket__GetRecievedPacketData(GAMEPACKET_PLAYER, player->aidIndex);
    }
    else
    {
        ObjRecievePacket *packet;

        while (TRUE)
        {
            packet = ObjPacket__GetRecievedPacket(GAMEPACKET_PLAYER, player->aidIndex);
            if (packet != NULL)
            {
                if (packet->header.param != playerGameStatus.field_88[player->controlID])
                    continue;

                break;
            }
            else
            {
                if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) != 0)
                {
                    player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_IN_AIR | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT);
                    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
                    player->objWork.velocity.x = player->objWork.position.x - player->objWork.prevPosition.x;
                    player->objWork.velocity.y = player->objWork.position.y - player->objWork.prevPosition.y;

                    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                    {
                        Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));
                        if (player->objWork.groundVel != FLOAT_TO_FX32(0.0))
                        {
                            SetTaskState(&player->objWork, Player__State_GroundMove);
                            Player__HandleGroundMovement(player);
                        }
                        else
                        {
                            SetTaskState(&player->objWork, Player__State_GroundIdle);
                        }
                    }
                    else
                    {
                        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
                        SetTaskState(&player->objWork, Player__State_Air);

                        player->objWork.userTimer  = 0;
                        player->objWork.userWork   = 0;
                        player->trickCooldownTimer = 0;

                        if (player->objWork.velocity.y < 0)
                            player->inputKeyDown |= PLAYER_INPUT_JUMP;
                    }
                }
                else
                {
                    player->objWork.displayFlag ^= DISPLAY_FLAG_NO_ANIMATE_CB;
                }
                player->playerFlag |= PLAYER_FLAG_DISABLE_PRESSURE_CHECK;
                player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;
                return;
            }
        }

        playerPacket = (struct PlayerSendPacket *)packet->data;
    }

    if (playerPacket != NULL)
    {
        player->objWork.prevPosition.x = player->objWork.position.x;
        player->objWork.prevPosition.y = player->objWork.position.y;
        player->objWork.prevPosition.z = player->objWork.position.z;

        player->objWork.position.x = playerPacket->position.x;
        player->objWork.position.y = playerPacket->position.y;
        player->objWork.position.z = playerPacket->position.z;

        player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;

        if ((playerPacket->gimmickFlag & PLAYER_GIMMICK_800000) != 0)
            player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;

        Player__HandleLapStageWrap(player);

        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) == 0)
        {
            MapSys__Func_2009190(player->cameraID);
            MapSys__Func_20091B0(player->cameraID);
            player->cameraDispPosStore.x = playerPacket->cameraDispPos.x;
            player->cameraDispPosStore.y = playerPacket->cameraDispPos.y;
        }

        if ((playerPacket->playerFlag & PLAYER_FLAG_IS_ATTACKING_PLAYER) != 0)
            ObjRect__SetAttackStat(&player->colliders[1], 2, PLAYER_HITPOWER_NORMAL);
        else
            ObjRect__SetAttackStat(&player->colliders[1], 0, 0);

        if ((playerPacket->playerFlag & PLAYER_FLAG_DO_LOSE_RING_EFFECT) != 0)
            CreateLoseRingEffect(player, 10);

        if ((playerPacket->playerFlag & PLAYER_FLAG_DO_ATTACK_RECOIL) != 0 && gPlayer->actionState == PLAYER_ACTION_HOMING_ATTACK)
            Player__Action_AttackRecoil(gPlayer);

        if (player->actionState != playerPacket->actionState)
        {
            player->objWork.displayFlag &= ~DISPLAY_FLAG_400;
            Player__ChangeAction(player, playerPacket->actionState);
            player->objWork.displayFlag |= DISPLAY_FLAG_NO_ANIMATE_CB;
        }

        player->objWork.obj_2d->ani.work.animAdvance = playerPacket->animAdvance2D << 9;
        player->objWork.obj_3d->ani.speedMultiplier  = playerPacket->animAdvance2D << 9;

        if (playerTailAnimForAction[player->characterID] != 0)
            player->aniTailModel.ani.speedMultiplier = playerPacket->animAdvance2D << 9;

        player->objWork.displayFlag &= DISPLAY_FLAG_NO_ANIMATE_CB;
        player->objWork.displayFlag |= playerPacket->displayFlag & ~(DISPLAY_FLAG_NO_ANIMATE_CB | DISPLAY_FLAG_NO_DRAW_EVENT);
        player->objWork.displayFlag ^= DISPLAY_FLAG_NO_ANIMATE_CB;

        player->objWork.dir.z = playerPacket->dirZ << 8;
        player->objWork.dir.x = playerPacket->dirX << 8;
        player->objWork.dir.y = playerPacket->dirY << 8;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_ANY;
        player->objWork.moveFlag = playerPacket->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY;
        player->playerFlag =
            (playerPacket->playerFlag | PLAYER_FLAG_DISABLE_PRESSURE_CHECK) & ~(PLAYER_FLAG_IS_ATTACKING_PLAYER | PLAYER_FLAG_DO_LOSE_RING_EFFECT | PLAYER_FLAG_DO_ATTACK_RECOIL);
        player->gimmickFlag    = playerPacket->gimmickFlag;
        player->objWork.move.x = playerPacket->moveX << 8;
        player->objWork.move.y = playerPacket->moveY << 8;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
        SetTaskState(&player->objWork, NULL);

        if (gmCheckRaceStage() && (player->playerFlag & PLAYER_FLAG_DEATH) != 0)
            playerGameStatus.playerLapCounter[player->controlID] = playerGameStatus.playerTargetLaps[player->controlID];

        if ((mapCamera.camera[0].disp_pos.x - FLOAT_TO_FX32(32.0) < player->objWork.position.x
             && mapCamera.camera[0].disp_pos.x + FLOAT_TO_FX32(288.0) > player->objWork.position.x)
            && (mapCamera.camera[0].disp_pos.y - FLOAT_TO_FX32(32.0) < player->objWork.position.y
                && mapCamera.camera[0].disp_pos.y + FLOAT_TO_FX32(224.0) > player->objWork.position.y))
        {
            player->objWork.obj_3d->ani.work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
            if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                player->aniTailModel.ani.work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        }
        else
        {
            player->objWork.obj_3d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
            if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                player->aniTailModel.ani.work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
        }
    }
}

void Player__SendPacket(Player *player)
{
    if (!gmCheckVsBattleFlag() || !CheckIsPlayer1(player))
        return;

    struct PlayerSendPacket *packet = &player->sendPacketList[player->sendPacketID];

    player->sendPacketID++;
    if (player->sendPacketID >= PLAYER_PACKET_QUEUE_SIZE)
        player->sendPacketID = 0;

    packet->position.x    = player->objWork.position.x;
    packet->position.y    = player->objWork.position.y;
    packet->position.z    = player->objWork.position.z;
    packet->actionState   = player->actionState;
    packet->displayFlag   = player->objWork.displayFlag & ~DISPLAY_FLAG_NO_ANIMATE_CB;
    packet->animAdvance2D = player->objWork.obj_2d->ani.work.animAdvance >> 8;
    packet->dirZ          = player->objWork.dir.z >> 8;
    packet->dirX          = player->objWork.dir.x >> 8;
    packet->dirY          = player->objWork.dir.y >> 8;
    packet->displayFlag   = player->objWork.displayFlag;
    packet->moveFlag      = player->objWork.moveFlag;
    packet->playerFlag    = player->playerFlag & ~(PLAYER_FLAG_40000000 | PLAYER_FLAG_IS_ATTACKING_PLAYER);

    if (player->colliders[1].hitFlag && (player->colliders[1].flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) != 0)
        packet->playerFlag |= PLAYER_FLAG_IS_ATTACKING_PLAYER;

    packet->gimmickFlag = player->gimmickFlag;
    if ((player->objWork.flag & 1) != 0)
        packet->gimmickFlag |= PLAYER_GIMMICK_800000;

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        packet->gimmickFlag &= ~PLAYER_GIMMICK_200000;

    packet->moveX = player->objWork.move.x >> 8;
    packet->moveY = player->objWork.move.y >> 8;

    packet->cameraDispPos.x = mapCamera.camera[0].disp_pos.x;
    packet->cameraDispPos.y = mapCamera.camera[0].disp_pos.y;
    packet->stageTimer      = playerGameStatus.stageTimer;

    ObjSendPacket *packetWork = ObjPacket__SendPacket(packet, GAMEPACKET_PLAYER, 2, sizeof(*packet));
    packetWork->header.param  = playerGameStatus.field_88[PLAYER_CONTROL_P1];

    if ((StageTaskStateMatches(&player->objWork, Player__State_TripleGrindRail) || StageTaskStateMatches(&player->objWork, Player__State_201D874)
         || StageTaskStateMatches(&player->objWork, Player__State_201DE24))
        || (StageTaskStateMatches(&player->objWork, Player__State_201D748) && player->objWork.scale.x != FLOAT_TO_FX32(1.0)))
    {
        packet->displayFlag |= DISPLAY_FLAG_NO_DRAW;
    }
}

void Player__WriteGhostFrame(Player *player)
{
    if (!CheckIsPlayer1(player))
        return;

    if ((playerGameStatus.stageTimer >> 2) >= (PLAYER_REPLAY_MAX_TIME - 1))
        return;

    u32 id = playerGameStatus.stageTimer >> 2;

    if ((playerGameStatus.flags & 1) != 0 && (playerGameStatus.stageTimer & 3) == 0)
    {
        PlayerGhostFrame *ghostBuffer = gameState.playerGhostWrite;

        s16 x             = (s32)MTM_MATH_CLIP_S16((FX32_TO_WHOLE(player->objWork.position.x) - startingPosX), -128, 127);
        ghostBuffer[id].x = x;
        startingPosX += x;

        s16 y             = (s32)MTM_MATH_CLIP_S16((FX32_TO_WHOLE(player->objWork.position.y) - startingPosY), -128, 127);
        ghostBuffer[id].y = y;
        startingPosY += y;

        s16 z             = (s32)MTM_MATH_CLIP_S16((FX32_TO_WHOLE(player->objWork.position.z) - startingPosZ), -16, 15);
        ghostBuffer[id].z = z;
        startingPosZ += (s8)z;

        ghostBuffer[id].angle = FX32_TO_WHOLE(player->objWork.dir.z);

        ghostBuffer[id].action = player->actionState;
        ghostBuffer[id].action |= (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) << 7;

        ghostBuffer[id + 1].action = 0xFF;
    }
}

void Player__ReadGhostFrame(Player *player)
{
    if ((gameState.gameFlag & GAME_FLAG_REPLAY_GHOST_ACTIVE) != 0 && !CheckIsPlayer1(player))
    {
        if ((mapCamera.camera[0].disp_pos.x - FLOAT_TO_FX32(32.0) < player->objWork.position.x
             && mapCamera.camera[0].disp_pos.x + FLOAT_TO_FX32(288.0) > player->objWork.position.x)
            && (mapCamera.camera[0].disp_pos.y - FLOAT_TO_FX32(32.0) < player->objWork.position.y
                && mapCamera.camera[0].disp_pos.y + FLOAT_TO_FX32(256.0) > player->objWork.position.y))
        {
            player->objWork.obj_3d->ani.work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
            if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                player->aniTailModel.ani.work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        }
        else
        {
            player->objWork.obj_3d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
            if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                player->aniTailModel.ani.work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
        }

        if ((playerGameStatus.stageTimer >> 2) >= PLAYER_REPLAY_MAX_TIME || (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        {
            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
            player->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            player->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
            return;
        }

        PlayerGhostFrame *ghostBuffer = gameState.playerGhostRead;
        s32 id                        = (playerGameStatus.stageTimer >> 2);

        if ((playerGameStatus.stageTimer & 1) == 0)
        {
            if (id >= 0 && ghostBuffer[id].action == 0xFF)
            {
                gameState.gameFlag &= ~GAME_FLAG_REPLAY_GHOST_ACTIVE;

                player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
                player->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
                player->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
                return;
            }

            player->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;

            if ((playerGameStatus.stageTimer & 2) == 0)
            {
                if (id >= 0)
                {
                    player->objWork.prevPosition.x = player->objWork.position.x;
                    player->objWork.prevPosition.y = player->objWork.position.y;

                    player->objWork.position.x += FX32_FROM_WHOLE((s8)ghostBuffer[id].x >> 2);
                    player->objWork.position.y += FX32_FROM_WHOLE((s8)ghostBuffer[id].y >> 2);
                    player->objWork.position.z += FX32_FROM_WHOLE((s8)ghostBuffer[id].z >> 2);

                    player->objWork.position.x += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].x - 3 * ((s8)ghostBuffer[id + 1].x >> 2));
                    player->objWork.position.y += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].y - 3 * ((s8)ghostBuffer[id + 1].y >> 2));
                    player->objWork.position.z += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].z - 3 * ((s8)ghostBuffer[id + 1].z >> 2));
                }
            }
            else if (id >= -1)
            {
                if (id == -1)
                {
                    player->objWork.position.x += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].x >> 1);
                    player->objWork.position.y += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].y >> 1);
                    player->objWork.position.z += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].z >> 1);
                }
                else
                {
                    player->objWork.position.x += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].x >> 2);
                    player->objWork.position.y += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].y >> 2);
                    player->objWork.position.z += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].z >> 2);
                }

                player->objWork.position.x += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].x >> 2);
                player->objWork.position.y += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].y >> 2);
                player->objWork.position.z += FX32_FROM_WHOLE((s8)ghostBuffer[id + 1].z >> 2);
            }
        }
        else
        {
            player->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
        }

        if (id < 0)
            id = 0;

        player->objWork.dir.z = (u16)FX32_FROM_WHOLE(ghostBuffer[id].angle);

        if (player->actionState != (ghostBuffer[id].action & 0x7F))
        {
            player->objWork.displayFlag &= ~DISPLAY_FLAG_400;
            Player__ChangeAction(player, (PlayerAction)(ghostBuffer[id].action & 0x7F));

            if (player->actionState >= PLAYER_ACTION_WALK1 && player->actionState <= PLAYER_ACTION_WALK6)
            {
                Player__SetAnimSpeedFromVelocity(
                    player, (MATH_ABS(player->objWork.prevPosition.x - player->objWork.position.x) + MATH_ABS(player->objWork.prevPosition.y - player->objWork.position.y)) >> 2);
            }

            if (player->actionState < PLAYER_ACTION_RAINBOWDASHRING || player->actionState > PLAYER_ACTION_TRICK_FINISH)
            {
                if ((player->actionState != PLAYER_ACTION_CROUCH && player->actionState != PLAYER_ACTION_CROUCH_EXIT)
                    && (player->actionState < PLAYER_ACTION_HURT_KNOCKBACK || player->actionState > PLAYER_ACTION_HURT_TUMBLE))
                {
                    if (player->actionState != PLAYER_ACTION_MUSHROOM_BOUNCE && player->actionState != PLAYER_ACTION_TRAMPOLINE)
                        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }
            }

            if ((ghostBuffer[id].action & 0x80) != 0)
                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            else
                player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        }

        if (player->actionState == PLAYER_ACTION_GRIND2)
            player->objWork.dir.y = -FLOAT_DEG_TO_IDX(90.0);
        else
            player->objWork.dir.y = FLOAT_DEG_TO_IDX(0.0);

        if (player->actionState <= PLAYER_ACTION_JUMPFALL || (player->actionState >= PLAYER_ACTION_HURT_KNOCKBACK && player->actionState <= PLAYER_ACTION_JUMPDASH_02)
            || (player->actionState >= PLAYER_ACTION_FLAMEHOVER && player->actionState <= PLAYER_ACTION_TRICK_FINISH))
        {
            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
            player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        }
        else
        {
            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        }

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
        player->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

void PlayPlayerJingle(Player *player, s16 nextTrack)
{
    PlayerJingle *work;

    if (curJingle == NULL)
    {
        Task *task = TaskCreate(PlayerJingle_Main, PlayerJingle_Destructor, TASK_FLAG_NONE, 3, TASK_PRIORITY_UPDATE_LIST_START + 12, TASK_GROUP(4), PlayerJingle);
        if (task == HeapNull)
            return;

        work = TaskGetWork(task, PlayerJingle);
        TaskInitWork16(work);

        curJingle       = task;
        work->sndHandle = AllocSndHandle();
    }
    else
    {
        work = TaskGetWork(curJingle, PlayerJingle);
    }

    work->player = player;

    if (work->nextTrack != 0)
        StopStageSfx(work->sndHandle);

    work->nextTrack = nextTrack;

    FadeStageBGMToTargetVolume(0, 0, FALSE);
    PlayTrack(work->sndHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, 100, work->nextTrack);
    NNS_SndPlayerSetChannelPriority(work->sndHandle, 80);
}

void PlayerJingle_Destructor(Task *task)
{
    PlayerJingle *work = TaskGetWork(task, PlayerJingle);

    if (work->sndHandle != NULL)
        ReleaseStageSfx(work->sndHandle);

    if (work->sndHandle != NULL)
        FreeSndHandle(work->sndHandle);

    curJingle = NULL;
}

void PlayerJingle_Main(void)
{
    PlayerJingle *work = TaskGetWorkCurrent(PlayerJingle);

    switch (work->nextTrack)
    {
        case SND_ZONE_SEQ_SEQ_MUTEKI:
            if (work->player->invincibleTimer == 90)
            {
                FadeOutStageSfx(work->sndHandle, 90);
                ReleaseStageSfx(work->sndHandle);

                FadeStageBGMToTargetVolume(GetMusicVolume(), 90, FALSE);

                DestroyCurrentTask();
            }
            else if (work->player->invincibleTimer == 0)
            {
                StopStageSfx(work->sndHandle);

                FadeStageBGMToTargetVolume(GetMusicVolume(), 0, FALSE);

                DestroyCurrentTask();
            }
            break;

        case SND_ZONE_SEQ_SEQ_BRETHLESS:
            if (CheckTaskPaused(NULL))
                NNS_SndPlayerPause(work->sndHandle, TRUE);
            else
                NNS_SndPlayerPause(work->sndHandle, FALSE);

            if (work->player->waterTimer == 0)
            {
                StopStageSfx(work->sndHandle);

                StartStageBGM(FALSE);
                ChangeStageBGMVariant((work->player->playerFlag & PLAYER_FLAG_IN_WATER) != 0);

                BOOL inWater = (work->player->playerFlag & PLAYER_FLAG_IN_WATER) != 0;
                s32 volume   = GetMusicVolume();
                FadeStageBGMToTargetVolume(volume, 60, inWater);

                DestroyCurrentTask();
            }
            break;
    }
}

void Player__Action_AllowTrickCombos(Player *player, GameObjectTask *other)
{
    MapObject *trickStateRef = other->mapObject;

    player->trickStateRef = trickStateRef;
    if (trickStateRef->param.tensionPenalty == 0)
    {
        player->gimmickFlag |= PLAYER_GIMMICK_ALLOW_TRICK_COMBO;
    }
    else
    {
        player->gimmickFlag &= ~PLAYER_GIMMICK_ALLOW_TRICK_COMBO;
        player->starComboCount = 0;
        StarCombo__FailCombo(player);
    }
}