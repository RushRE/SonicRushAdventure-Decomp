#ifndef RUSH_PLAYER_H
#define RUSH_PLAYER_H

#include <stage/stageTask.h>
#include <game/audio/audioSystem.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FORWARD DECLS
// --------------------

typedef struct StarCombo_ StarCombo;
typedef struct ScoreBonus_ ScoreBonus;

// --------------------
// CONSTANTS
// --------------------

// maximum player count
#define PLAYER_COUNT (2)

#define PLAYER_INPUT_JUMP (PAD_BUTTON_A | PAD_BUTTON_B)

#define PLAYER_MAX_RINGS       (999)
#define PLAYER_MAX_TOTAL_RINGS (9999)

#define PLAYER_STARTING_LIVES   (2) // 3 lives
#define PLAYER_TIMEATTACK_LIVES (1) // 1 life
#define PLAYER_MAX_LIVES        (99)

#define PLAYER_MAX_SCORE (99999999)

#define PLAYER_SCOREBONUS_TRICK        (200)
#define PLAYER_SCOREBONUS_TRICK_FINISH (400)

#define PLAYER_SCOREBONUS_GRIND_TRICK        (100)
#define PLAYER_SCOREBONUS_GRIND_TRICK_FINISH (200)

#define PLAYER_SCOREBONUS_TRICKFINISHER_H (200)
#define PLAYER_SCOREBONUS_TRICKFINISHER_V (200)

#define PLAYER_SCOREBONUS_RAINBOWDASHRING (400)

#define PLAYER_TENSION_PER_LEVEL (1600)
#define PLAYER_TENSION_LEVEL_MAX (3)

#define PLAYER_START_TENSION (1 * PLAYER_TENSION_PER_LEVEL)
#define PLAYER_TENSION_MAX   (1600 * PLAYER_TENSION_LEVEL_MAX)

#define PLAYER_TENSIONMAX_DURATION   (320)
#define PLAYER_TENSIONCOMBO_DURATION (96)

#define PLAYER_TENSION_HURT_PENALTY (1200)

#define PLAYER_TENSION_TRICK       (160)
#define PLAYER_TENSION_TRICKFINISH (320)

#define PLAYER_TENSION_CHECKPOINT (800)
#define PLAYER_TENSION_ENEMY      (400)

#define PLAYER_TRICK_COOLDOWN       (24)
#define PLAYER_TRICK_COOLDOWN_HYPER (12)

#define PLAYER_GRIND_TRICK2_COOLDOWN (24)
#define PLAYER_GRIND_TRICK3_COOLDOWN (16)

#define PLAYER_INVINCIBLE_DURATION (999)
#define PLAYER_HYPERTRICK_DURATION (SECONDS_TO_FRAMES(20.0))
#define PLAYER_SLOWMO_DURATION     (512)
#define PLAYER_CONFUSION_DURATION  (SECONDS_TO_FRAMES(10.0))

#define PLAYER_BOOST_SCROLL_DELAY (8)
#define PLAYER_BOOST_DURATION     (96)

#define PLAYER_SUPERBOOST_MINIMUM           (80)  // the superboost only requires you to have 80 tension to use
#define PLAYER_SUPERBOOST_COST              (112) // the superboost will drain 112 tension on activation
#define PLAYER_SUPERBOOST_DRAIN_SPEED       (8)   // the superboost will drain 8 tension per frame
#define PLAYER_SUPERBOOST_COOLDOWN_DURATION (8)
#define PLAYER_SUPERBOOST_SFX_FADE_DURATION (16)

#define PLAYER_HOMINGATTACK_DURATION (32)
#define PLAYER_HOMINGATTACK_SPEED    (8) // 8 units/frame

#define PLAYER_SPEEDBONUS_SUPERBOOST (10000)
#define PLAYER_SPEEDBONUS_BOOST      (8000)
#define PLAYER_SPEEDBONUS_RUN        (4000)

#define PLAYER_PACKET_QUEUE_SIZE (4)

#define PLAYER_ANIM_NONE (0xFF)

#define PLAYER_HITPOWER_VULNERABLE (0x00)

#define PLAYER_DEFPOWER_NORMAL OBS_RECT_DEFPOWER_DEFAULT
#define PLAYER_HITPOWER_NORMAL OBS_RECT_HITPOWER_DEFAULT

#define PLAYER_DEFPOWER_INVINCIBLE (0xFF)
#define PLAYER_HITPOWER_INVINCIBLE (0xFE)

#define PLAYER_GRIND_NONE   (0x00)
#define PLAYER_GRIND_ACTIVE (0x80)

#define PLAYER_CLINGWEIGHT_MAX (3)

#define PLAYER_REPLAY_MAX_TIME (AKUTIL_TIME_TO_FRAMES(3, 30, 00) >> 2)

// --------------------
// ENUMS
// --------------------

enum CharacterID_
{
    CHARACTER_SONIC,
    CHARACTER_BLAZE,

    CHARACTER_COUNT,
};
typedef u8 CharacterID;

enum PlayerFlags_
{
    PLAYER_FLAG_USER_FLAG               = 1 << 0, // misc user flag
    PLAYER_FLAG_ALLOW_TRICKS            = 1 << 1,
    PLAYER_FLAG_FINISHED_TRICK_COMBO    = 1 << 2,
    PLAYER_FLAG_DISABLE_TRICK_FINISHER  = 1 << 3,
    PLAYER_FLAG_VS_IS_ATTACKING_PLAYER  = 1 << 4, // used for vs battle communications
    PLAYER_FLAG_VS_DO_LOSE_RING_EFFECT  = 1 << 5, // used for vs battle communications
    PLAYER_FLAG_DISABLE_HOMING_ATTACK   = 1 << 6,
    PLAYER_FLAG_SUPERBOOST              = 1 << 7,
    PLAYER_FLAG_BOOST                   = 1 << 8,
    PLAYER_FLAG_TAIL_IS_ACTIVE          = 1 << 9,
    PLAYER_FLAG_DEATH                   = 1 << 10,
    PLAYER_FLAG_CHECK_WALL_CRUSH        = 1 << 11,
    PLAYER_FLAG_DISABLE_OBJ_CRUSH_CHECK = 1 << 12,
    PLAYER_FLAG_DISABLE_CAMERA_OFFSET   = 1 << 13,
    PLAYER_FLAG_TRICK_SUCCESS           = 1 << 14,
    PLAYER_FLAG_TRICK_SPECIAL_ACTIVE    = 1 << 15,
    PLAYER_FLAG_VS_DO_ATTACK_RECOIL     = 1 << 16, // used for vs battle communications
    PLAYER_FLAG_SUPERBOOST_UNKNOWN      = 1 << 17,
    PLAYER_FLAG_USED_INFINITE_TENSION   = 1 << 18,
    PLAYER_FLAG_SLOWMO                  = 1 << 19,
    PLAYER_FLAG_DISABLE_TENSION_DRAIN   = 1 << 20,
    PLAYER_FLAG_DISABLE_INPUT_READ      = 1 << 21,
    PLAYER_FLAG_DISABLE_TENSION_CHANGE  = 1 << 22,
    PLAYER_FLAG_HAS_GAME_OVER           = 1 << 23, // Used in prior games, unused in Sonic Rush Adventure. A "Game Over: just sends the player back to southern island
    PLAYER_FLAG_FINISHED_STAGE          = 1 << 24,
    PLAYER_FLAG_2000000                 = 1 << 25,
    PLAYER_FLAG_IN_WATER                = 1 << 26,
    PLAYER_FLAG_SLOPE_FORCE_APPLIED     = 1 << 27,
    PLAYER_FLAG_SHIELD_REGULAR          = 1 << 28,
    PLAYER_FLAG_SHIELD_MAGNET           = 1 << 29,
    PLAYER_FLAG_VS_QUEUED_PLAYER_HIT    = 1 << 30,
    PLAYER_FLAG_MODEL_CHANGED           = 1 << 31,

    // Helpers
    PLAYER_FLAG_SHIELD_ANY = PLAYER_FLAG_SHIELD_REGULAR | PLAYER_FLAG_SHIELD_MAGNET,
};
typedef u32 PlayerFlags;

enum PlayerGimmickFlags_
{
    PLAYER_GIMMICK_FORCE_SURFACE_ATTACH                = 1 << 0,
    PLAYER_GIMMICK_FORCE_SURFACE_ATTACH_FLIP           = 1 << 1,
    PLAYER_GIMMICK_CHECK_GRIND_COLLISIONS              = 1 << 2,
    PLAYER_GIMMICK_CHECK_SUPERBOOST_END_DURING_GIMMICK = 1 << 3,
    PLAYER_GIMMICK_CAM_FOCUS_GIMMICK_X                 = 1 << 4,
    PLAYER_GIMMICK_CAM_FOCUS_GIMMICK_Y                 = 1 << 5,
    PLAYER_GIMMICK_SNAP_CAM_FOCUS_TO_GIMMICK_X         = 1 << 6,
    PLAYER_GIMMICK_SNAP_CAM_FOCUS_TO_GIMMICK_Y         = 1 << 7,
    PLAYER_GIMMICK_ENABLE_Z_MOVEMENT                   = 1 << 8,
    PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_X       = 1 << 9,
    PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_Y       = 1 << 10,
    PLAYER_GIMMICK_SNOWBOARD                           = 1 << 11,
    PLAYER_GIMMICK_ATTACHED_TO_WALL                    = 1 << 12,
    PLAYER_GIMMICK_UNKNOWN                             = 1 << 13,
    PLAYER_GIMMICK_4000                                = 1 << 14,
    PLAYER_GIMMICK_8000                                = 1 << 15,
    PLAYER_GIMMICK_USE_WATER_GRIND_SPARK               = 1 << 16,
    PLAYER_GIMMICK_HIDE_SUPERBOOST                     = 1 << 17,
    PLAYER_GIMMICK_DISABLE_RINGS_ON_PLANE_B            = 1 << 18,
    PLAYER_GIMMICK_WAS_ATTACHED_TO_WALL                = 1 << 19,
    PLAYER_GIMMICK_CONTOLLED_BY_GIMMICK                = 1 << 20,
    PLAYER_GIMMICK_IS_CREATED                          = 1 << 21,
    PLAYER_GIMMICK_WARP                                = 1 << 22,
    PLAYER_GIMMICK_2P_IS_ON_PLANE_B                    = 1 << 23,
    PLAYER_GIMMICK_ALLOW_TRICK_COMBO                   = 1 << 24,
    PLAYER_GIMMICK_WANT_GRAVITY_RESET                  = 1 << 25,
    PLAYER_GIMMICK_USE_CAMERA_CENTER_OFFSET            = 1 << 26,
    PLAYER_GIMMICK_USE_GIMMICK_BOUNDS_X                = 1 << 27,
    PLAYER_GIMMICK_USE_GIMMICK_BOUNDS_Y                = 1 << 28,
    PLAYER_GIMMICK_DISABLE_Z_AUTO_RETURN               = 1 << 29, // prevent z pos from returning to 0.0
    PLAYER_GIMMICK_40000000                            = 1 << 30,
    PLAYER_GIMMICK_80000000                            = 1 << 31,

    // Helpers
    PLAYER_GIMMICK_CAM_FOCUS_GIMMICK_XY           = PLAYER_GIMMICK_CAM_FOCUS_GIMMICK_X | PLAYER_GIMMICK_CAM_FOCUS_GIMMICK_Y,
    PLAYER_GIMMICK_SNAP_CAM_FOCUS_TO_GIMMICK_XY   = PLAYER_GIMMICK_SNAP_CAM_FOCUS_TO_GIMMICK_X | PLAYER_GIMMICK_SNAP_CAM_FOCUS_TO_GIMMICK_Y,
    PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_XY = PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_X | PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_Y,
    PLAYER_GIMMICK_USE_GIMMICK_BOUNDS_XY          = PLAYER_GIMMICK_USE_GIMMICK_BOUNDS_X | PLAYER_GIMMICK_USE_GIMMICK_BOUNDS_Y,
};
typedef u32 PlayerGimmickFlags;

enum PlayerAction_
{
    PLAYER_ACTION_TURNING,
    PLAYER_ACTION_IDLE,
    PLAYER_ACTION_CROUCH,
    PLAYER_ACTION_CROUCH_EXIT,
    PLAYER_ACTION_BRAKE1_01,
    PLAYER_ACTION_BRAKE1_02,
    PLAYER_ACTION_BRAKE1_03,
    PLAYER_ACTION_BRAKE2_01,
    PLAYER_ACTION_BRAKE2_02,
    PLAYER_ACTION_BRAKE2_03,
    PLAYER_ACTION_PUSH_01,
    PLAYER_ACTION_PUSH_02,
    PLAYER_ACTION_BALANCE_FORWARD,
    PLAYER_ACTION_BALANCE_BACKWARD,
    PLAYER_ACTION_HURT_KNOCKBACK,
    PLAYER_ACTION_HURT_TUMBLE,
    PLAYER_ACTION_DEATH_01,
    PLAYER_ACTION_DEATH_02,
    PLAYER_ACTION_HOMING_ATTACK,
    PLAYER_ACTION_JUMPFALL,
    PLAYER_ACTION_AIRRISE,
    PLAYER_ACTION_AIRFALL_01,
    PLAYER_ACTION_AIRFALL_02,
    PLAYER_ACTION_AIRFORWARD_01,
    PLAYER_ACTION_AIRFORWARD_02,
    PLAYER_ACTION_JUMPDASH_01,
    PLAYER_ACTION_JUMPDASH_02,
    PLAYER_ACTION_GRIND,
    PLAYER_ACTION_1C,
    PLAYER_ACTION_GRINDTRICK_1,
    PLAYER_ACTION_GRINDTRICK_2,
    PLAYER_ACTION_GRINDTRICK_3_01,
    PLAYER_ACTION_GRINDTRICK_3_02,
    PLAYER_ACTION_GRINDTRICK_3_03,
    PLAYER_ACTION_LOOKUP_01,
    PLAYER_ACTION_LOOKUP_02,
    PLAYER_ACTION_24,
    PLAYER_ACTION_HANG_ROT,
    PLAYER_ACTION_MUSHROOM_BOUNCE,
    PLAYER_ACTION_ROPE_SWING,
    PLAYER_ACTION_GRIND2,
    PLAYER_ACTION_DREAMWING,
    PLAYER_ACTION_PISTON_01,
    PLAYER_ACTION_PISTON_02,
    PLAYER_ACTION_STEAM_FAN,
    PLAYER_ACTION_TRUCK_CROUCH,
    PLAYER_ACTION_ICICLE,
    PLAYER_ACTION_ICE_SLIDE,
    PLAYER_ACTION_30,
    PLAYER_ACTION_DIVING_BOARD,
    PLAYER_ACTION_CRANE,
    PLAYER_ACTION_ANCHOR_ROPE,
    PLAYER_ACTION_START_01,
    PLAYER_ACTION_START_02,
    PLAYER_ACTION_START_03,
    PLAYER_ACTION_TRAMPOLINE,
    PLAYER_ACTION_DOLPHIN_RIDE,
    PLAYER_ACTION_HOVER_CRYSTAL,
    PLAYER_ACTION_BALLOON_RIDE,
    PLAYER_ACTION_WATERGUN_01,
    PLAYER_ACTION_WATERGUN_02,
    PLAYER_ACTION_BUNGEE,
    PLAYER_ACTION_START_SNOWBOARD,
    PLAYER_ACTION_3F,
    PLAYER_ACTION_IDLE_SNOWBOARD,
    PLAYER_ACTION_WALK_SNOWBOARD,
    PLAYER_ACTION_JUMP_SNOWBOARD_01,
    PLAYER_ACTION_JUMP_SNOWBOARD_02,
    PLAYER_ACTION_JUMPFALL_SNOWBOARD,
    PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_01,
    PLAYER_ACTION_TRICK_FINISH_V_SNOWBOARD_02,
    PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01,
    PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_02,
    PLAYER_ACTION_RAINBOWDASHRING_SNOWBOARD,
    PLAYER_ACTION_TRICK_SUCCESS1_SNOWBOARD,
    PLAYER_ACTION_TRICK_SUCCESS2_SNOWBOARD,
    PLAYER_ACTION_TRICK_FINISH_SNOWBOARD,
    PLAYER_ACTION_AIRRISE_SNOWBOARD,
    PLAYER_ACTION_AIRFALL_SNOWBOARD_01,
    PLAYER_ACTION_AIRFALL_SNOWBOARD_02,
    PLAYER_ACTION_AIRFORWARD_SNOWBOARD_01,
    PLAYER_ACTION_AIRFORWARD_SNOWBOARD_02,
    PLAYER_ACTION_JUMPDASH_SNOWBOARD_01,
    PLAYER_ACTION_JUMPDASH_SNOWBOARD_02,
    PLAYER_ACTION_GRIND_SNOWBOARD,
    PLAYER_ACTION_GRINDTRICK_SNOWBOARD_1,
    PLAYER_ACTION_GRINDTRICK_SNOWBOARD_2,
    PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_01,
    PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_02,
    PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_03,
    PLAYER_ACTION_HURT_SNOWBOARD,
    PLAYER_ACTION_DIVING_BOARD_SNOWBOARD,
    PLAYER_ACTION_ROLL,
    PLAYER_ACTION_SPINDASH,
    PLAYER_ACTION_SPINDASH_CHARGE,
    PLAYER_ACTION_FLAMEHOVER,
    PLAYER_ACTION_TRICK_FINISH_V_01,
    PLAYER_ACTION_TRICK_FINISH_V_02,
    PLAYER_ACTION_TRICK_FINISH_V_03,
    PLAYER_ACTION_TRICK_FINISH_V_04,
    PLAYER_ACTION_TRICK_FINISH_H_01,
    PLAYER_ACTION_TRICK_FINISH_H_02,
    PLAYER_ACTION_RAINBOWDASHRING,
    PLAYER_ACTION_TRICK_SUCCESS1,
    PLAYER_ACTION_TRICK_SUCCESS2,
    PLAYER_ACTION_TRICK_FINISH,
    PLAYER_ACTION_WALK1,
    PLAYER_ACTION_WALK2,
    PLAYER_ACTION_WALK3,
    PLAYER_ACTION_WALK4,
    PLAYER_ACTION_WALK5,
    PLAYER_ACTION_WALK6,
    PLAYER_ACTION_GOAL1,
    PLAYER_ACTION_GOAL2,
    PLAYER_ACTION_TOUCH_REACT,
    PLAYER_ACTION_73,
    PLAYER_ACTION_74,
    PLAYER_ACTION_75,
    PLAYER_ACTION_76,
    PLAYER_ACTION_77,
    PLAYER_ACTION_BOSS5FREEZE,
    PLAYER_ACTION_BOSS6_RUN,

    PLAYER_ACTION_COUNT,
};
typedef s16 PlayerAction;

enum PlayerRecallShieldType
{
    PLAYER_RECALLSHIELD_NONE,
    PLAYER_RECALLSHIELD_REGULAR,
    PLAYER_RECALLSHIELD_MAGNET,
};

enum PlayerControlID_
{
    PLAYER_CONTROL_P1,
    PLAYER_CONTROL_P2,
};
typedef u8 PlayerControlID;

enum PlayerSeqPlayerID_
{
    PLAYER_SEQPLAYER_COMMON,
    PLAYER_SEQPLAYER_GRIND,
    PLAYER_SEQPLAYER_SUPERBOOST,
    PLAYER_SEQPLAYER_GRINDTRICKSUCCES,

    PLAYER_SEQPLAYER_COUNT,
};

// used by player for Player__State_FollowParent
enum PlayerChildFlag
{
    PLAYER_CHILDFLAG_NONE = 0x00,

    PLAYER_CHILDFLAG_CAN_JUMP               = 1 << 0,
    PLAYER_CHILDFLAG_FOLLOW_PREV_POS        = 1 << 1,
    PLAYER_CHILDFLAG_FORCE_JUMP_ACTION      = 1 << 2,
    PLAYER_CHILDFLAG_FORCE_LAUNCH_ACTION    = 1 << 3,
    PLAYER_CHILDFLAG_FINISH_TRICK_COMBO     = 1 << 4,
    PLAYER_CHILDFLAG_DISABLE_TRICK_FINISHER = 1 << 5,
    PLAYER_CHILDFLAG_INHERIT_SHAKE_TIMER    = 1 << 6,
};

// used by the parent for Player__State_FollowParent
enum PlayerParentFlag
{
    PLAYER_PARENTFLAG_NONE = 0x00,

    PLAYER_PARENTFLAG_RELEASE_WITH_VELOCITY  = 1 << 0,
    PLAYER_PARENTFLAG_RELEASE_WITH_GROUNDVEL = 1 << 1,
    PLAYER_PARENTFLAG_RELEASE_WITH_MOVE      = 1 << 2,
};

// --------------------
// STRUCTS
// --------------------

struct PlayerPhysicsTable
{
    fx32 acceleration;
    fx32 topSpeed;
    fx32 deceleration;
    fx32 rollingVelocity;
    fx32 rollingAcceleration;
    fx32 rollingTopSpeed;
    fx32 rollingDeceleration;
    fx32 topSpeed_Boost;
    fx32 acceleration_SuperBoost;
    fx32 topSpeed_SuperBoost;
    fx32 deceleration_SuperBoost;
    fx32 minBoostVelocity;
    fx32 slopeTopSpeedAccel;
    s16 airTimer;
    s16 hurtInvulnDuration;
    s16 boostActivationTime;
    u16 surfaceStickTimer;
    fx32 slopeAcceleration;
    fx32 maxSlopeSpeed;
    fx32 rollSlopeAcceleration;
    fx32 jumpStrength;
    fx32 gravityStrength;
    fx32 terminalVelocity;
    fx32 pushCap;
};

struct PlayerSendPacket
{
    VecFx32 position;
    u16 displayFlag;
    s16 animAdvance2D;
    u8 actionState;
    u8 dirZ;
    u8 dirX;
    u8 dirY;
    u32 moveFlag;
    u32 playerFlag;
    u32 gimmickFlag;
    s16 moveX;
    s16 moveY;
    Vec2Fx32 cameraDispPos;
    s32 stageTimer;
};

typedef struct PlayerGhostFrame_
{
    u8 x;
    u8 y;
    struct
    {
        s8 z : 4;
        u8 angle : 4;
    };
    u8 action;
} PlayerGhostFrame;

typedef struct PlayerBoost_
{
    StageTask objWork;

    s32 field_168;
    s32 field_16C;
    s32 field_170;
    s32 field_174;
    s32 field_178;
    s32 field_17C;
    s32 field_180;
    s32 field_184;
    s32 field_188;
    s32 field_18C;
    s32 field_190;
    s32 field_194;
    s32 field_198;
    s32 field_19C;
    s32 field_1A0;
    s32 field_1A4;
    OBS_RECT_WORK collider;
} PlayerBoost;

typedef struct PlayerJingle_
{
    NNSSndHandle *sndHandle;
    u16 nextTrack;
    struct Player_ *player;
} PlayerJingle;

typedef struct Player_
{
    StageTask objWork;

    OBS_ACTION3D_NN_WORK aniPlayerModel;
    OBS_ACTION3D_NN_WORK aniTailModel;
    OBS_ACTION2D_BAC_WORK aniPlayerSprite;
    OBS_RECT_WORK colliders[3];
    CharacterID characterID;
    PlayerControlID controlID;
    u8 aidIndex;
    u8 cameraID;
    s16 actionState;
    s16 trickCooldownTimer;
    PlayerFlags playerFlag;
    PlayerGimmickFlags gimmickFlag;
    fx32 spindashPower;
    void (*actionGroundIdle)(struct Player_ *player);
    void (*actionGroundMove)(struct Player_ *player);
    void (*actionCrouch)(struct Player_ *player);
    void (*actionJump)(struct Player_ *player);
    void (*actionRButtonAir)(struct Player_ *player);
    s16 tension;
    s16 overSpeedLimitTimer;
    s32 noSpdDownTimer;
    fx32 acceleration;
    fx32 topSpeed;
    fx32 deceleration;
    fx32 initialSpindashPower;
    fx32 spindashChargePower;
    fx32 spindashTopSpeed;
    fx32 rollingDeceleration;
    fx32 topSpeed_Boost;
    fx32 acceleration_SuperBoost;
    fx32 topSpeed_SuperBoost;
    fx32 deceleration_SuperBoost;
    fx32 minBoostVelocity;
    fx32 slopeTopSpeedAccel;
    fx32 jumpForce;
    fx32 activeTopSpeed;
    s16 airTimer;
    s16 hurtInvulnDuration;
    fx32 spdThresholdWalk;
    fx32 spdThresholdJog;
    fx32 spdThresholdRun;
    fx32 spdThresholdDash;
    fx32 spdThresholdBoost;
    NNSSndHandle seqPlayers[PLAYER_SEQPLAYER_COUNT];
    VecFx32 afterImagePos[2];
    s16 boostTimer;
    s16 rings;
    s16 ringStageCount;
    s16 blinkTimer;
    s16 invincibleTimer;
    s16 tensionMaxTimer;
    s16 comboTensionTimer;
    s16 comboTensionMultiplier;
    u16 pressureTimer;
    s16 multiNoHitTimer;
    s16 confusionTimer;
    s16 slomoTimer;
    s16 itemBoxDisableTimer;
    s16 waterTimer;
    s16 inputLock;
    u16 _unused_69A;
    s16 hyperTrickTimer;
    s16 afterImageTimer;
    s16 trickFinishHorizFreezeTimer;
    fx32 trickFinishHorizXVelocity;
    u8 surfaceStickTimer;
    u8 boostEndTimer;
    u8 superBoostCooldownTimer;
    s8 cameraScrollDelay;
    Vec2Fx32 cameraOffset;
    Vec2Fx32 cameraVelocity;
    u32 cameraJumpPosY;
    StarCombo *starComboManager;
    ScoreBonus *scoreBonus;
    u8 starComboCount;
    u8 tensionPenalty;
    GameObjectTask *homingTarget;
    s16 blazeHoverTimer;
    s16 axelTornadoFXSpawnTimer;
    MapObject *trickStateRef;
    GameObjectTask *gimmickObj;
    s16 gimmickCamOffsetX;
    s16 gimmickCamOffsetY;
    s16 gimmickCamCenterOffsetX;
    s16 gimmickCamCenterOffsetY;
    s16 gimmickCamGimmickCenterOffsetX;
    s16 gimmickCamGimmickCenterOffsetY;
    s16 gimmickMapLimitLeft;
    s16 gimmickMapLimitRight;
    s16 gimmickMapLimitTop;
    s16 gimmickMapLimitBottom;

    union
    {
        // Common values
        struct
        {
            s32 value1;
            s32 value2;
            s32 value3;
            s32 value4;
        };

// split off gimmick structs into their own file, for the sake of this file's readability
#include <stage/player/playerGimmickStructs.h>
    } gimmick;

    NNSG3dResFileHeader *snowboardAnims;
    s16 clingWeight;
    s16 prevClingWeight;
    Vec2Fx32 warpDestPos;
    u8 grindID;
    u8 grindPrevRide;
    PaletteTexture paletteTex;
    u16 inputKeyDown;
    u16 inputKeyPress;
    u16 inputKeyRepeat;
    struct
    {
        u16 right;
        u16 left;
        u16 up;
        u16 down;
        u16 A;
        u16 B;
    } keyMap;
    u32 stageTimerStore;
    struct PlayerSendPacket sendPacketList[PLAYER_PACKET_QUEUE_SIZE];
    Vec2Fx32 cameraDispPosStore;
    s16 sendPacketID;
} Player;

// --------------------
// VARIABLES
// --------------------

extern void *playerArchive;

// --------------------
// FUNCTIONS
// --------------------

// Loading
void LoadPlayerAssets(void);
void ReleasePlayerAssets(void);

// Admin Tasks
Player *Player__Create(u32 characterID, u16 aidIndex);
void Player__Action_ResetPlayer(Player *work);
void Player__InitState(Player *player);
void Player__SaveStartingPosition(fx32 x, fx32 y, fx32 z);
void Player__InitGimmick(Player *player, BOOL allowTricks);
void Player__InitPhysics(Player *player);
void Player__Action_Blank(Player *player);
void Player__State_Blank(Player *work);
void Player__Action_Intangible(Player *player);
void Player__RemoveCollideEvent(Player *player);
void Player__State_Intangible(Player *work);
void Player__Collide_Intangible(void);
void Player__GiveRings(Player *player, s16 count);
void Player__GiveLife(Player *player, u8 count);
void Player__GiveTension(Player *player, s32 amount);
void Player__GiveComboTension(Player *player, s32 amount);
void Player__GiveInvincibility(Player *player);
void Player__GiveRegularShield(Player *player);
void Player__GiveMagnetShield(Player *player);
void Player__GiveHyperTrickEffect(Player *player);
void Player__GiveSlowdownEffect(Player *player);
void Player__GiveConfusionEffect(Player *player);
void Player__DepleteTension(Player *player);
void Player__ApplyWarpEfect(Player *player);
void Player__ChangeAction(Player *player, PlayerAction action);
void Player__SetAnimFrame(Player *player, fx32 frame);
void Player__SetAnimSpeedFromVelocity(Player *player, fx32 velocity);
void Player__UseDashPanel(Player *player, fx32 velX, fx32 velY);
void Player__HandleStartWalkAnimation(Player *player);
void Player__HandleActiveWalkAnimation(Player *player);
BOOL Player__HandleFallOffSurface(Player *player);
void Player__Action_LandOnGround(Player *player, fx32 dirZ);
void Player__Action_RainbowDashRing(Player *player);
void Player__ApplySlopeForces(Player *player, GameObjectTask *other);
void Player__OnGroundIdle(Player *player);
void Player__OnGroundMove(Player *player);
void Player__Action_Launch(Player *player);
void Player__PerformTrick(Player *player);
void Player__Action_Grind(Player *player);
void Player__Action_Die(Player *player);
void Player__Action_Warp(Player *player);
void Player__Action_DestroyAttackRecoil(Player *player);
void Player__Action_AttackRecoil(Player *player);
void Player__Action_Knockback_NoHurt(Player *player, fx32 velX, fx32 velY);
void Player__Action_FinishMission(Player *player, GameObjectTask *other);
void Player__HandleGroundMovement(Player *player);
void Player__HandleAirMovement(Player *player);
void Player__HandleRollingForces(Player *player);
void Player__OnDefend_Regular(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Player__Hurt(Player *player);
void Player__Action_Boost(Player *player); // sa2-style boost
void Player__Action_StopBoost(Player *player);
void Player__Action_SuperBoost(Player *player); // Rush-style boost
void Player__Action_StopSuperBoost(Player *player);
PlayerBoost *CreatePlayerBoostCollider(Player *player, s16 left, s16 top, s16 right, s16 bottom, s16 timer);
BOOL Player__UseUpsideDownGravity(fx32 x, fx32 y);
void Player__Func_201301C(u16 id);
void Player__SetP2Offset(fx32 x, fx32 y, fx32 z);
s32 Player__GetPlayerCount(void);
void Player__Destructor(Task *task);
void Player__ReadInput(void);
u16 Player__ReadInputFromValue(Player *player, u16 buttonMask);
void Player__Func_20133B8(Player *work);
void Player__Func_2013630(Player *work);
void Player__Func_20138F4(Player *player);
void Player__Func_2013948(Player *player);
void Player__HandleCollisionBounds(Player *player);
void Player__In_Default(void);
void Player__Last_Default(void);
void Player__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, Player *player);
void Player__Draw(void);
void Player__DrawAfterImages(void);

// States & Actions
void Player__State_GroundIdle(Player *work);
void Player__State_GroundMove(Player *work);
void Player__Action_Crouch(Player *player);
void Player__State_Crouch(Player *work);
void Player__Action_Roll(Player *player);
void Player__State_Roll(Player *work);
void Player__Action_StartSpindash(Player *player);
void Player__State_Spindash(Player *work);
void Player__Action_Jump(Player *player);
void Player__Action_JumpDash(Player *player);
void Player__State_Air(Player *work);
void Player__State_Death(Player *work);
void Player__State_DeathReset(Player *work);
void Player__State_Warp(Player *work);
void Player__State_Hurt(Player *work);
void Player__State_HurtSnowboard(Player *work);
void Player__State_Grinding(Player *work);
void Player__Action_TrickFinisherVertical(Player *player);
void Player__Action_TrickFinisherHorizontal(Player *player);
void PLayer__PerformGrindTrick(Player *player);
void Player__Action_HomingAttack_Sonic(Player *player);
void Player__State_HomingAttack(Player *work);
void Player__Action_FlameHover(Player *player);
void Player__State_FlameHover(Player *work);
void Player__HandleAirDrag(Player *player);
void Player__HandleZMovement(Player *player);
void Player__HandleLapEventManager(Player *player);
void Player__HandleLapStageWrap(Player *player);
void Player__HandleMaxPush(Player *player);
void Player__HandleForceSurfaceAttach(Player *player);
void Player__HandleTensionDrain(Player *player);
void Player__GiveScore(Player *player, u32 score);
void Player__ApplyClingWeight(Player *player);
BOOL Player__IsBalancing(Player *player, BOOL updateAction);
void Player__FinishTurningSkidding(Player *player);
void Player__HandleSuperBoost(Player *player);
void Player__HandleBoost(Player *player);
void Player__HandleHomingTarget(Player *player);
BOOL Player__HandleGrinding(Player *player);
void Player__HandleWaterEntry(Player *player);
void Player__HandleGravitySwapping(Player *player);
void Player__HandlePressure(Player *player);
void Player__HandleTimeLimits(Player *player);
void Player__HandleMissionComplete(Player *player);
void PlayerBoostCollider_State_ActiveLifetime(PlayerBoost *work);
void SetBoostColliderToTrackPlayer(PlayerBoost *boost);
void PlayerBoostCollider_State_ActiveBoosting(PlayerBoost *work);
void Player__ReceivePacket(Player *player);
void Player__SendPacket(Player *player);
void Player__WriteGhostFrame(Player *player);
void Player__ReadGhostFrame(Player *player);
void PlayPlayerJingle(Player *player, s16 nextTrack);
void PlayerJingle_Destructor(Task *task);
void PlayerJingle_Main(void);
void Player__Action_AllowTrickCombos(Player *player, GameObjectTask *other);
void Player__Action_StageStartSnowboard(Player *player);
void Player__State_StageStartSnowboard(Player *work);
void Player__Action_Spring(Player *player, fx32 velX, fx32 velY);
void Player__Action_GimmickLaunch(Player *player, fx32 velX, fx32 velY);
void Player__Gimmick_201B418(Player *player, fx32 velX, fx32 velY, BOOL allowTricks);
void Player__Action_FollowParent(Player *player, GameObjectTask *other, fx32 offsetX, fx32 offsetY, fx32 offsetZ);
void Player__State_FollowParent(Player *work);
void Player__Action_DashRing(Player *player, fx32 x, fx32 y, fx32 velX, fx32 velY);
void Player__Action_JumpDashLaunch(Player *player, fx32 velX, fx32 velY);
void Player__Action_SpringboardLaunch(Player *player, fx32 velX, fx32 velY);
u16 Player__CheckOnCorkscrewPath(Player *player);
void Player__Action_CorkscrewPath(Player *player, fx32 x, fx32 y, s32 a4, u16 a5);
void Player__State_CorkscrewPath(Player *work);
void Player__HandleCorkscrewPathH(Player *player, s32 a2, s32 a3, s16 a4);
void Player__HandleCorkscrewPathV(Player *player, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6, s32 a7);
void Player__Action_PipeEnter(Player *player, GameObjectTask *other, u16 angle, s32 timer);
void Player__State_PipeTravel(Player *work);
void Player__Action_PipeExit(Player *player, fx32 velocity, BOOL allowTricks, u32 type);
void Player__Action_RotatingHanger(Player *player, GameObjectTask *hanger, fx32 launchForce, BOOL launchUpwards);
void Player__State_RotatingHanger(Player *work);
void Player__Action_SwingRope(Player *player, GameObjectTask *swingRope, s32 radius, s32 angleOffset);
void Player__State_SwingRope(Player *work);
void Player__Action_MushroomBounce(Player *player, fx32 velX, fx32 velY, s32 timer);
void Player__Action_TripleGrindRailStartSpring(Player *player, GameObjectTask *tripleGrindRailSpring, fx32 velX, fx32 velY);
void Player__State_TripleGrindRailStartSpring(Player *work);
void Player__Action_TripleGrindRailEndSpring(Player *player, GameObjectTask *tripleGrindRail);
void Player__State_TripleGrindRailEndSpring(Player *work);
void Player__Gimmick_TripleGrindRail(Player *player);
void Player__State_TripleGrindRail(Player *work);
void Player__HandleRideTripleGrindRail(Player *player);
void Player__OnDefend_TripleGrindRail(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Player__Func_201DD24(Player *player);
void Player__State_201DE24(Player *work);
void Player__Gimmick_WaterRun(Player *player);
void Player__State_WaterRun(Player *work);
void Player__Action_SteamFan(Player *player, GameObjectTask *other, s32 fanRadius);
void Player__State_SteamFan(Player *work);
void Player__Action_PopSteam(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, fx32 speedThreshold, BOOL allowTricks);
void Player__State_PopSteam(Player *work);
void Player__Action_DreamWing(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, s32 burstDelay);
void Player__State_DreamWing(Player *work);
void Player__Action_LargePiston1(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, fx32 velZ, fx32 delay);
void Player__State_LargePiston1(Player *work);
void Player__Action_LargePiston2(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, fx32 velZ, fx32 delay);
void Player__State_LargePiston2(Player *work);
void Player__Action_IcicleGrab(Player *player, GameObjectTask *other, s32 width);
void Player__State_IcicleGrab(Player *work);
void Player__Action_IceSlide(Player *player, s32 _unused);
void Player__State_IceSlide(Player *player);
void Player__State_IceSlideLaunch(Player *work);
void Player__Action_EnableSnowboard(Player *player, s32 type);
void Player__Action_LoseSnowboard(Player *player);
void Player__Action_Flipboard(Player *player, fx32 velX, fx32 velY);
void Player__Action_DiveStandStood(Player *player, GameObjectTask *other);
void Player__UpdateDiveStandState(Player *player);
void Player__HandleDiveStandStood(Player *player);
void Player__State_DiveStand_GroundMove(Player *work);
void Player__State_DiveStand_GroundIdle(Player *work);
void Player__State_DiveStand_Roll(Player *work);
void Player__State_DiveStand_Spindash(Player *work);
void Player__State_DiveStand_Crouch(Player *work);
void Player__Action_DiveStandGrab(Player *player, GameObjectTask *other);
void Player__State_DiveStandGrab(Player *work);
void Player__Action_DiveStandLaunch(Player *player, GameObjectTask *other, fx32 velX, fx32 velY);
void Player__Action_EnterHalfpipe(Player *player, GameObjectTask *other, BOOL flag);
void Player__State_Halfpipe(Player *work);
void Player__Func_2020C00(Player *player, s32 a2);
void Player__Func_2020DB8(Player *player);
void Player__Action_ExitHalfpipe(Player *player);
void Player__Action_GhostTree(Player *player, GameObjectTask *other);
void Player__Action_SpringCrystal(Player *player, fx32 velX, fx32 velY);
void Player__Action_CraneGrab(Player *player, GameObjectTask *other);
void Player__Action_Winch(Player *player, GameObjectTask *other, u32 displayFlag);
void Player__State_Winch(Player *work);
void Player__Action_EnterTruck(Player *player, GameObjectTask *other);
void Player__State_EnterTruck(Player *work);
void Player__Action_TruckLaunch(Player *player, GameObjectTask *other, s32 a3);
void Player__State_TruckRide(Player *work);
void Player__OnDefend_TruckRide(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Player__Func_2021A84(Player *player, GameObjectTask *other);
void Player__Func_2021AE8(Player *player, GameObjectTask *other);
void Player__Func_2021B44(Player *player, GameObjectTask *other);
void Player__Action_AnchorRope(Player *player, GameObjectTask *other);
void Player__State_AnchorRope(Player *work);
void Player__Action_BarrelGrab(Player *player, GameObjectTask *other);
void Player__State_BarrelGrab(Player *work);
void Player__Action_TrampolineLand(Player *player, GameObjectTask *other);
void Player__State_TrampolineLand(Player *work);
void Player__Action_TrampolineBounce(Player *player, fx32 velX, fx32 velY);
void Player__Action_EnterCannon(Player *player, GameObjectTask *other, s32 type);
void Player__State_CannonEnter_FallInto(Player *work);
void Player__State_CannonEnter_WalkInto(Player *work);
void Player__State_CannonEnter_RotateInto(Player *work);
void Player__State_InsideCannon(Player *work);
void Player__Action_FireCannon(Player *player, GameObjectTask *other);
void Player__State_CannonLaunched(Player *work);
void Player__Action_ExitCannonPath(Player *player, GameObjectTask *other);
void Player__Action_EnterCannonRingTrigger(Player *player, u32 type);
void Player__Action_ExitCannonRingTrigger(Player *player, u16 type);
void Player__Gimmick_JumpBox(Player *player, GameObjectTask *other, CharacterID characterID);
void Player__State_JumpBox(Player *work);
void Player__Action_JumpBoxLaunch(Player *player, fx32 velX, fx32 velY);
void Player__Action_JumpBoxPlaneSwitchLaunch(Player *player, fx32 velX, fx32 velY, fx32 velZ);
void Player__State_JumpBoxPlaneSwitchLaunch(Player *work);
void Player__Action_PlaneSwitchSpring(Player *player, fx32 velX, fx32 velY);
void Player__State_PlaneSwitchSpring(Player *work);
void Player_Action_EnterFarPlane(Player *player);
void Player__Action_EnterSlingshot(Player *player, GameObjectTask *other);
void Player__State_Slingshot(Player *work);
void Player__Action_RideDolphin(Player *player, GameObjectTask *dolphin);
void Player__State_DolphinRide(Player *work);
void Player__Action_FinalDolphinHoop(Player *player, GameObjectTask *hoop);
void Player__State_ExitDolphinRide(Player *work);
void Player__LeaveDolphinRide(Player *player);
void Player__OnDefend_DolphinRide(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Player__Action_DolphinHoop(Player *player, GameObjectTask *hoop);
void Player__Action_HoverCrystal(Player *player, GameObjectTask *other, fx32 left, fx32 y, fx32 right);
void Player__State_HoverCrystal(Player *work);
void Player__Action_BalloonRide(Player *player, GameObjectTask *other, fx32 floatSpeed);
void Player__State_BalloonRide(Player *work);
void Player__Action_WaterGun(Player *player, GameObjectTask *other);
void Player__State_WaterGun(Player *work);
void Player__Action_Bungee(Player *player, GameObjectTask *bungee, fx32 startX, fx32 startY);
void Player__State_Bungee(Player *work);
void Player__Action_SpringRope(Player *player, GameObjectTask *springRope, s32 timer);
void Player__State_SpringRope(Player *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

#define CheckPlayerGimmickObj(player, gimmickWork) (((Player *)(player))->gimmickObj == &(gimmickWork)->gameWork)

RUSH_INLINE BOOL CheckIsPlayer1(Player *player)
{
    return player->controlID == PLAYER_CONTROL_P1;
}

RUSH_INLINE void PlayPlayerSfx(Player *player, u32 seqPlayerID, enum SND_ZONE_SEQARC_GAME_SE sfxID)
{
    PlayHandleStageSfx(&player->seqPlayers[seqPlayerID], sfxID);
}

RUSH_INLINE void StopPlayerSfx(Player *player, u32 seqPlayerID)
{
    StopStageSfx(&player->seqPlayers[seqPlayerID]);
}

RUSH_INLINE void FadeOutPlayerSfx(Player *player, u32 seqPlayerID, u32 frames)
{
    FadeOutStageSfx(&player->seqPlayers[seqPlayerID], frames);
}

RUSH_INLINE void ReleasePlayerSfx(Player *player, u32 seqPlayerID)
{
    ReleaseStageSfx(&player->seqPlayers[seqPlayerID]);
}

#ifdef __cplusplus
}
#endif

#endif // RUSH_PLAYER_H