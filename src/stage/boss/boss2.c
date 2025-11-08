#include <stage/boss/boss2.h>
#include <stage/boss/bossPlayerHelpers.h>
#include <stage/core/hud.h>
#include <stage/core/titleCard.h>
#include <stage/core/bgmManager.h>
#include <stage/core/ringManager.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/stage/bossArena.h>
#include <game/audio/spatialAudio.h>
#include <game/stage/mapFarSys.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/background.h>
#include <game/object/objectManager.h>
#include <game/math/unknown2066510.h>

// resources
#include <resources/narc/z2boss_act_lz7.h>

// --------------------
// CONSTANTS
// --------------------

#define MTXSTACK_BOSS2_BODY_TOP    NNS_G3D_MTXSTACK_SYS
#define MTXSTACK_BOSS2_BODY_MID    NNS_G3D_MTXSTACK_USER
#define MTXSTACK_BOSS2_BODY_BOTTOM (NNS_G3D_MTXSTACK_USER - 1)
#define MTXSTACK_BOSS2_WEAK        (NNS_G3D_MTXSTACK_USER - 2)

#define MTXSTACK_BOSS2BALL_BALL_HIT NNS_G3D_MTXSTACK_SYS

#define MTXSTACK_BOSS2ARM_ARM_BALL NNS_G3D_MTXSTACK_SYS

// --------------------
// ENUMS
// --------------------

enum Boss2JointAniID
{
    ANI_JNT_bs2_body_fw0,
    ANI_JNT_bs2_arm_fw0,
    ANI_JNT_bs2_drop_fw0,
    ANI_JNT_bs2_balla_fw0,
    ANI_JNT_bs2_ballb_fw0,
    ANI_JNT_bs2_ballc_fw0,
    ANI_JNT_bs2_body_gura0,
    ANI_JNT_bs2_drop_gura0,
    ANI_JNT_bs2_body_gura1,
    ANI_JNT_bs2_drop_gura1,
    ANI_JNT_bs2_body_gura2,
    ANI_JNT_bs2_drop_gura2,
    ANI_JNT_bs2_body_gura3,
    ANI_JNT_bs2_drop_gura3,
    ANI_JNT_bs2_body_gura4,
    ANI_JNT_bs2_drop_gura4,
    ANI_JNT_bs2_body_gura5,
    ANI_JNT_bs2_drop_gura5,
    ANI_JNT_bs2_body_zako0,
    ANI_JNT_bs2_drop_zako0,
    ANI_JNT_bs2_body_zako1,
    ANI_JNT_bs2_drop_zako1,
    ANI_JNT_bs2_body_zako2,
    ANI_JNT_bs2_drop_zako2,
    ANI_JNT_bs2_body_dmg0,
    ANI_JNT_bs2_body_dmg1,
    ANI_JNT_bs2_body_down0,
    ANI_JNT_bs2_body_down1,
    ANI_JNT_bs2_body_down2,
    ANI_JNT_bs2_body_down3,
    ANI_JNT_bs2_body_down4,
    ANI_JNT_bs2_body_down5,
    ANI_JNT_bs2_body_down6,
    ANI_JNT_bs2_body_exp0,
    ANI_JNT_bs2_balla_ratk0,
    ANI_JNT_bs2_ballb_ratk0,
    ANI_JNT_bs2_ballc_ratk0,
    ANI_JNT_bs2_balla_ratk1,
    ANI_JNT_bs2_ballb_ratk1,
    ANI_JNT_bs2_ballc_ratk1,
    ANI_JNT_bs2_balla_pendf0,
    ANI_JNT_bs2_ballb_pendf0,
    ANI_JNT_bs2_ballc_pendf0,
    ANI_JNT_bs2_balla_pendf1,
    ANI_JNT_bs2_ballb_pendf1,
    ANI_JNT_bs2_ballc_pendf1,
    ANI_JNT_bs2_balla_pendb0,
    ANI_JNT_bs2_ballb_pendb0,
    ANI_JNT_bs2_ballc_pendb0,
    ANI_JNT_bs2_balla_pendb1,
    ANI_JNT_bs2_ballb_pendb1,
    ANI_JNT_bs2_ballc_pendb1,
    ANI_JNT_bs2_spka_0,
    ANI_JNT_bs2_spkb_0,
    ANI_JNT_bs2_spkc_0,
    ANI_JNT_bs2_spka_1,
    ANI_JNT_bs2_spkb_1,
    ANI_JNT_bs2_spkc_1,
    ANI_JNT_bs2_spka_2,
    ANI_JNT_bs2_spkb_2,
    ANI_JNT_bs2_spkc_2,
    ANI_JNT_bs2_spka_3,
    ANI_JNT_bs2_spkb_3,
    ANI_JNT_bs2_spkc_3,
};

enum Boss2VizAniID
{
    ANI_VIZ_bs2_spka_0,
    ANI_VIZ_bs2_spkb_0,
    ANI_VIZ_bs2_spkc_0,

    ANI_VIZ_bs2_spka_1,
    ANI_VIZ_bs2_spkb_1,
    ANI_VIZ_bs2_spkc_1,

    ANI_VIZ_bs2_spka_2,
    ANI_VIZ_bs2_spkb_2,
    ANI_VIZ_bs2_spkc_2,

    ANI_VIZ_bs2_spka_3,
    ANI_VIZ_bs2_spkb_3,
    ANI_VIZ_bs2_spkc_3,
};

enum Boss2PalAniID
{
    BOSS2_PALANI_IDLE,
    BOSS2_PALANI_HIT,
};

enum Boss2BallPalAniID
{
    BOSS2BALL_PALANI_INACTIVE,
    BOSS2BALL_PALANI_SPIKED,
    BOSS2BALL_PALANI_VULNERABLE,
};

// --------------------
// STRUCTS
// --------------------

struct Boss2BallConfig
{
    u16 spikeDuration;
    u16 vulnerableDuration;
};

struct Boss2TimerConfig
{
    u16 baseValue;
    u16 range;
};

// --------------------
// VARIABLES
// --------------------

#ifdef NON_MATCHING

static const struct Boss2BallConfig Boss2__ballActionConfigTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT] =
{
	[BOSS2_PHASE_1] =
	{
		[BOSS2_BALL_S] = { .spikeDuration = SECONDS_TO_FRAMES(0.0), .vulnerableDuration = SECONDS_TO_FRAMES(0.0) },
    	[BOSS2_BALL_M] = { .spikeDuration = SECONDS_TO_FRAMES(0.0), .vulnerableDuration = SECONDS_TO_FRAMES(0.0) },
    	[BOSS2_BALL_L] = { .spikeDuration = SECONDS_TO_FRAMES(0.0), .vulnerableDuration = SECONDS_TO_FRAMES(0.0) },
	},
    
	[BOSS2_PHASE_2] =
	{
    	[BOSS2_BALL_S] = { .spikeDuration = SECONDS_TO_FRAMES(1.0), .vulnerableDuration = SECONDS_TO_FRAMES(3.0) },
    	[BOSS2_BALL_M] = { .spikeDuration = SECONDS_TO_FRAMES(0.0), .vulnerableDuration = SECONDS_TO_FRAMES(0.0) },
    	[BOSS2_BALL_L] = { .spikeDuration = SECONDS_TO_FRAMES(0.0), .vulnerableDuration = SECONDS_TO_FRAMES(0.0) },
	},
    
	[BOSS2_PHASE_3] =
	{
    	[BOSS2_BALL_S] = { .spikeDuration = SECONDS_TO_FRAMES(1.0), .vulnerableDuration = SECONDS_TO_FRAMES(3.0) },
    	[BOSS2_BALL_M] = { .spikeDuration = SECONDS_TO_FRAMES(2.0), .vulnerableDuration = SECONDS_TO_FRAMES(3.0) },
    	[BOSS2_BALL_L] = { .spikeDuration = SECONDS_TO_FRAMES(0.0), .vulnerableDuration = SECONDS_TO_FRAMES(0.0) },
	},
    
	[BOSS2_PHASE_4] =
	{
    	[BOSS2_BALL_S] = { .spikeDuration = SECONDS_TO_FRAMES(1.0), .vulnerableDuration = SECONDS_TO_FRAMES(3.0) },
    	[BOSS2_BALL_M] = { .spikeDuration = SECONDS_TO_FRAMES(2.0), .vulnerableDuration = SECONDS_TO_FRAMES(3.0) },
    	[BOSS2_BALL_L] = { .spikeDuration = SECONDS_TO_FRAMES(3.0), .vulnerableDuration = SECONDS_TO_FRAMES(3.0) },
	}
};

static const u16 Boss2__ballBaseDamageTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT] = {
    [BOSS2_PHASE_1] = { 0x20, 0x30, 0x80 },
    [BOSS2_PHASE_2] = { 0x20, 0x30, 0x80 },
    [BOSS2_PHASE_3] = { 0x20, 0x30, 0x80 },
    [BOSS2_PHASE_4] = { 0x20, 0x30, 0x80 },
};

static const s16 Boss2__ballTargetAngleVelocityTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT] = {
    [BOSS2_PHASE_1] = { 0x60, 0x40, 0x20 },
    [BOSS2_PHASE_2] = { 0x80, 0x60, 0x40 },
    [BOSS2_PHASE_3] = { 0xA0, 0x80, 0x60 },
    [BOSS2_PHASE_4] = { 0xC0, 0xA0, 0x80 },
};

static const fx16 ballWeights_Normal[BOSS2_BALL_COUNT] = {
    [BOSS2_BALL_S] = FLOAT_TO_FX32(4.0),
    [BOSS2_BALL_M] = FLOAT_TO_FX32(2.6),
    [BOSS2_BALL_L] = FLOAT_TO_FX32(2.0),
};

static const s16 phaseHealthThreshold[BOSS2_PHASE_COUNT - 1] = {
    [BOSS2_PHASE_2 - 1] = 0x3A0,
    [BOSS2_PHASE_3 - 1] = 0x280,
    [BOSS2_PHASE_4 - 1] = 0x140,
};

static const fx16 ballWeights_Heavy[BOSS2_BALL_COUNT] = {
    [BOSS2_BALL_S] = FLOAT_TO_FX32(3.0),
    [BOSS2_BALL_M] = FLOAT_TO_FX32(2.0),
    [BOSS2_BALL_L] = FLOAT_TO_FX32(1.5),
};

static const s32 Boss2__activeArmCountTable[BOSS2_PHASE_COUNT] = {
    [BOSS2_PHASE_1] = (1) - 1,
    [BOSS2_PHASE_2] = (2) - 1,
    [BOSS2_PHASE_3] = (3) - 1,
    [BOSS2_PHASE_4] = (3) - 1,
};

static const fx32 baseDamageTable[DIFFICULTY_COUNT] = { [DIFFICULTY_EASY] = FLOAT_TO_FX32(1.0), [DIFFICULTY_NORMAL] = FLOAT_TO_FX32(1.0) };

static const struct Boss2TimerConfig Boss2__dropAttackConfigTable[DIFFICULTY_COUNT][BOSS2_PHASE_COUNT] =
{
	[DIFFICULTY_EASY] =
	{
		[BOSS2_PHASE_1] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_2] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_3] = { .baseValue = 360, .range = (256) - 1 },
    	[BOSS2_PHASE_4] = { .baseValue = 300, .range = (256) - 1 },
	},

	[DIFFICULTY_NORMAL] =
	{
		[BOSS2_PHASE_1] = { .baseValue = 300, .range = (512) - 1 },
    	[BOSS2_PHASE_2] = { .baseValue = 300, .range = (256) - 1 },
    	[BOSS2_PHASE_3] = { .baseValue = 240, .range = (256) - 1 },
    	[BOSS2_PHASE_4] = { .baseValue = 180, .range = (256) - 1 },
	},
};

static const struct Boss2TimerConfig Boss2__bombSpawnConfigTable[DIFFICULTY_COUNT][BOSS2_PHASE_COUNT] =
{
	[DIFFICULTY_EASY] =
	{
		[BOSS2_PHASE_1] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_2] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_3] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_4] = { .baseValue = 300, .range = (128) - 1 },
	},

	[DIFFICULTY_NORMAL] =
	{
		[BOSS2_PHASE_1] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_2] = { .baseValue = 0, .range = 0 },
    	[BOSS2_PHASE_3] = { .baseValue = 240, .range = (256) - 1 },
    	[BOSS2_PHASE_4] = { .baseValue = 180, .range = (256) - 1 },
	},
};

static const fx32 Boss2__ballHitFXScaleTable[BOSS2_BALL_COUNT] = {
    [BOSS2_BALL_S] = FLOAT_TO_FX32(4.0),
    [BOSS2_BALL_M] = FLOAT_TO_FX32(6.0),
    [BOSS2_BALL_L] = FLOAT_TO_FX32(8.0),
};

static const char *Boss2Ball__paletteNames[BOSS2_BALL_COUNT] = {
    [BOSS2_BALL_S] = "h_tama_a_pl",
    [BOSS2_BALL_M] = "h_tama_b_pl",
    [BOSS2_BALL_L] = "h_tama_c_pl",
};

static const char *Boss2__paletteNames[] = {
    "eye_pl", "face_pl", "setuzoku_meka_pl", "side_b_pl", "side_meka1_pl", "side_meka2_pl", "side_meka3_pl", "top_pl",
};

#else

static const fx16 ballWeights_Normal[BOSS2_BALL_COUNT] = {
    [BOSS2_BALL_S] = FLOAT_TO_FX32(4.0),
    [BOSS2_BALL_M] = FLOAT_TO_FX32(2.6),
    [BOSS2_BALL_L] = FLOAT_TO_FX32(2.0),
};

static const s16 phaseHealthThreshold[BOSS2_PHASE_COUNT - 1] = {
    [BOSS2_PHASE_2 - 1] = HUD_BOSS_HEALTH_PERCENT(0.90625),
    [BOSS2_PHASE_3 - 1] = HUD_BOSS_HEALTH_PERCENT(0.625),
    [BOSS2_PHASE_4 - 1] = HUD_BOSS_HEALTH_PERCENT(0.3125),
};

static const fx16 ballWeights_Heavy[BOSS2_BALL_COUNT] = {
    [BOSS2_BALL_S] = FLOAT_TO_FX32(3.0),
    [BOSS2_BALL_M] = FLOAT_TO_FX32(2.0),
    [BOSS2_BALL_L] = FLOAT_TO_FX32(1.5),
};

static const fx32 baseDamageTable[DIFFICULTY_COUNT] = {
    [DIFFICULTY_EASY]   = FLOAT_TO_FX32(1.0),
    [DIFFICULTY_NORMAL] = FLOAT_TO_FX32(1.0),
};

NOT_DECOMPILED const struct Boss2BallConfig Boss2__ballActionConfigTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT];

NOT_DECOMPILED const u16 Boss2__ballBaseDamageTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT];

NOT_DECOMPILED const s16 Boss2__ballTargetAngleVelocityTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT];

NOT_DECOMPILED const s32 Boss2__activeArmCountTable[BOSS2_PHASE_COUNT];

NOT_DECOMPILED const struct Boss2TimerConfig Boss2__dropAttackConfigTable[DIFFICULTY_COUNT][BOSS2_PHASE_COUNT];
NOT_DECOMPILED const struct Boss2TimerConfig Boss2__bombSpawnConfigTable[DIFFICULTY_COUNT][BOSS2_PHASE_COUNT];

NOT_DECOMPILED const fx32 Boss2__ballHitFXScaleTable[BOSS2_BALL_COUNT];

NOT_DECOMPILED const char *Boss2Ball__paletteNames[BOSS2_BALL_COUNT];
NOT_DECOMPILED const char *Boss2__paletteNames[];

NOT_DECOMPILED const VecFx32 Boss2Stage_StageState_Init_Part1_camUp;
NOT_DECOMPILED const VecFx32 Boss2Stage_StageState_Init_Part2_camUp;
NOT_DECOMPILED const fx32 Boss2Ball_DrawBall_offset[BOSS2_BALL_COUNT];

NOT_DECOMPILED const HitboxRect Boss2__ballHitboxes[BOSS2_BALL_COUNT];
NOT_DECOMPILED const char *Boss2__ballNames[BOSS2_BALL_COUNT];
NOT_DECOMPILED const fx32 Boss2__ballScales[BOSS2_BALL_COUNT];

#endif

static void (*originalPlayerDrawFunc)(void);
static Task *bossStageTaskSingleton;

// --------------------
// FUNCTION DECLS
// --------------------

// Boss2 Helpers
static void DrawBossStagePlayer(void);
static void LoadBossAssets(Boss2Assets *assets);

// Boss2Stage
static Boss2Phase GetBossPhase(Boss2Stage *work);
static fx32 GetBossBaseDamage(Boss2Stage *work, s32 ballType);
static fx32 GetBallBaseDamage(Boss2Stage *work, s32 ballType);
static u16 GetBallImpactDamage(Boss2Stage *work, s32 ballType);
static fx32 GetBallHitFXScale(Boss2Stage *work, s32 ballType);
static s16 GetBallTargetAngleVelocity(Boss2Stage *work, s32 ballType);
static fx16 GetBallWeight(Boss2Stage *work, s32 ballType);
static void ConfigureBallActions(Boss2Stage *work, s32 ballType, u16 *spikeDuration, u16 *vulnerableDuration);
static u16 GetBossDropAttackInterval(Boss2Stage *work);
static u16 GetBossBombSpawnInterval(Boss2Stage *work);
static void ConfigureBossActions(Boss2Stage *work);
static void ConfigureBossStageCamera(Boss2Stage *work);
static void ConfigureBossCamera1(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up);
static void ConfigureBossCamera2(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up);
static u16 GetBallsOnTopScreen(Boss2Stage *work, Boss2Ball **balls);
static void HandleBossCamera(Boss2Stage *work);
static void Boss2Stage_State_Active(Boss2Stage *work);
static void Boss2Stage_Destructor(Task *task);
static void Boss2Stage_Draw(void);
static void Boss2_Collide(void);
static void Boss2_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss2Stage_StageState_Init_Part1(Boss2Stage *work);
static void Boss2Stage_StageState_Init_Part2(Boss2Stage *work);
static void Boss2Stage_StageState_Idle(Boss2Stage *work);

// Boss2
static void Boss2_State_Active(Boss2 *work);
static void Boss2_Destructor(Task *task);
static void Boss2_Draw(void);
static BOOL CheckBossCanDraw(Boss2 *work);
static void Boss2_BodyMidCallback(NNSG3dRS *context, void *userData);
static void Boss2_BodyBottomCallback(NNSG3dRS *context, void *userData);
static void Boss2_Action_Init(Boss2 *work);
static void Boss2_Action_Idle(Boss2 *work);
static void Boss2_Action_Hit(Boss2 *work);
static void Boss2_Action_Deactivated(Boss2 *work);
static void Boss2_Action_Destroy(Boss2 *work);
static void Boss2_BossState_Init(Boss2 *work);
static void Boss2_BossState_InitIdle(Boss2 *work);
static void Boss2_BossState_Idle(Boss2 *work);
static void Boss2_BossState_InitHit(Boss2 *work);
static void Boss2_BossState_StartHitImpact(Boss2 *work);
static void Boss2_BossState_HitImpact(Boss2 *work);
static void Boss2_BossState_StartHitRecoil(Boss2 *work);
static void Boss2_BossState_HitRecoil(Boss2 *work);
static void Boss2_BossState_InitDeactivated(Boss2 *work);
static void Boss2_BossState_StartDeactivatedHit(Boss2 *work);
static void Boss2_BossState_DeactivatedHit(Boss2 *work);
static void Boss2_BossState_StartDeactivatedFallStart(Boss2 *work);
static void Boss2_BossState_DeactivatedFallStart(Boss2 *work);
static void Boss2_BossState_StartDeactivatedFallLoop(Boss2 *work);
static void Boss2_BossState_DeactivatedFallLoop(Boss2 *work);
static void Boss2_BossState_StartDeactivatedFallLand(Boss2 *work);
static void Boss2_BossState_DeactivatedFallLand(Boss2 *work);
static void Boss2_BossState_StartDeactivated(Boss2 *work);
static void Boss2_BossState_Deactivated(Boss2 *work);
static void Boss2_BossState_StartDeactivateRevive(Boss2 *work);
static void Boss2_BossState_DeactivateRevive(Boss2 *work);
static void Boss2_BossState_StartDeactivateRise(Boss2 *work);
static void Boss2_BossState_DeactivateRise(Boss2 *work);
static void Boss2_BossState_StartDeactivateRegainArms(Boss2 *work);
static void Boss2_BossState_DeactivateRegainArms(Boss2 *work);
static void Boss2_BossState_InitDestroyed(Boss2 *work);
static void Boss2_BossState_PrepareCameraForDestroyed(Boss2 *work);
static void Boss2_BossState_StartDestroyedShock(Boss2 *work);
static void Boss2_BossState_DestroyedShock(Boss2 *work);
static void Boss2_BossState_StartExplode(Boss2 *work);
static void Boss2_BossState_Explode(Boss2 *work);
static void Boss2_BossState_ShowResultsScreen(Boss2 *work);

// Boss2Drop
static void Boss2Drop_State_Active(Boss2Drop *work);
static void Boss2Drop_Destructor(Task *task);
static void Boss2Drop_Draw(void);
static void Boss2Drop_Action_Attached(Boss2Drop *work);
static void Boss2Drop_Action_Drop(Boss2Drop *work);
static void Boss2Drop_DropState_InitAttach(Boss2Drop *work);
static void Boss2Drop_DropState_Attached(Boss2Drop *work);
static void Boss2Drop_DropState_InitDrop(Boss2Drop *work);
static void Boss2Drop_DropState_TelegraphDrop(Boss2Drop *work);
static void Boss2Drop_DropState_DimLighting(Boss2Drop *work);
static void Boss2Drop_DropState_CreateDropFX(Boss2Drop *work);
static void Boss2Drop_DropState_DropFall(Boss2Drop *work);
static void Boss2Drop_DropState_DropLand(Boss2Drop *work);
static void Boss2Drop_DropState_BrightenLights(Boss2Drop *work);
static void Boss2Drop_DropState_StartWobbleAnim(Boss2Drop *work);
static void Boss2Drop_DropState_WobbleAnim(Boss2Drop *work);
static void Boss2Drop_DropState_WaitForRise(Boss2Drop *work);
static void Boss2Drop_DropState_Rising(Boss2Drop *work);
static void Boss2Drop_DropState_StartReattach(Boss2Drop *work);
static void Boss2Drop_DropState_Reattach(Boss2Drop *work);

// Boss2Arm
static void Boss2Arm_State_Active(Boss2Arm *work);
static void Boss2Arm_Destructor(Task *task);
static void Boss2Arm_Draw(void);
static BOOL CheckBossArmCanDraw(Boss2Arm *work);
static void Boss2Arm_Action_Inactive(Boss2Arm *work);
static void Boss2Arm_Action_Appear(Boss2Arm *work);
static void Boss2Arm_Action_FetchBall(Boss2Arm *work);
static void Boss2Arm_Action_Attach(Boss2Arm *work, u16 angle, s16 angleVelocity);
static void Boss2Arm_Action_Detattach(Boss2Arm *work);
static void Boss2Arm_ArmState_Inactive(Boss2Arm *work);
static void Boss2Arm_Action_PrepareForAppear(Boss2Arm *work);
static void Boss2Arm_ArmState_OrbitBody(Boss2Arm *work);
static void Boss2Arm_ArmState_FetchBall(Boss2Arm *work);
static void Boss2Arm_ArmState_PrepareAttach(Boss2Arm *work);
static void Boss2Arm_ArmState_RiseForAttach(Boss2Arm *work);
static void Boss2Arm_ArmState_Attaching(Boss2Arm *work);
static void Boss2Arm_Action_InitAttached(Boss2Arm *work);
static void Boss2Arm_Action_Attached(Boss2Arm *work);
static void Boss2Arm_Action_PrepareDetattach(Boss2Arm *work);
static void Boss2Arm_Action_DetattachFall(Boss2Arm *work);

// Boss2Ball
static void Boss2Ball_State_Active(Boss2Ball *work);
static void Boss2Ball_Destructor(Task *task);
static void Boss2Ball_Draw(void);
static void Boss2Ball_DrawBall(Boss2Ball *work);
static void Boss2Ball_Collide(void);
static void Boss2Ball_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void UpdateBallTransform(Boss2Ball *work);
static void Boss2Ball_Action_Inactive(Boss2Ball *work);
static void Boss2Ball_Action_Idle(Boss2Ball *work);
static void Boss2Ball_Action_Hit(Boss2Ball *work, Boss2BallDirection direction, fx32 force);
static void Boss2Ball_Action_HitRecoil(Boss2Ball *work);
static void Boss2Ball_BallState_Inactive(Boss2Ball *work);
static void Boss2Ball_BallState_InitIdle(Boss2Ball *work);
static void Boss2Ball_BallState_Idle(Boss2Ball *work);
static void Boss2Ball_BallState_InitHit(Boss2Ball *work);
static void Boss2Ball_BallState_Hit(Boss2Ball *work);
static void Boss2Ball_BallState_InitHitRecoil(Boss2Ball *work);
static void Boss2Ball_BallState_HitRecoil(Boss2Ball *work);

// Boss2BallSpikeWorker
static void EnableBallSpikes(Boss2BallSpikeWorker *worker);
static void DisableBallSpikes(Boss2BallSpikeWorker *worker);
static void Boss2Ball_Action_EnableSpikes(Boss2BallSpikeWorker *worker);
static void Boss2Ball_Action_DisableSpikes(Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_StartInactive(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_Inactive(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_StartActive(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_SpikesActive(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_Retracting(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_Retracted(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_Vulnerable(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_StartExtendSpikes(Boss2Ball *work, Boss2BallSpikeWorker *worker);
static void Boss2Ball_SpikeState_ExtendSpikes(Boss2Ball *work, Boss2BallSpikeWorker *worker);

// Boss2Bomb
static Boss2Bomb *SpawnBombEnemy(Boss2Stage *work, fx32 moveSpeed, BOOL flipped);
static void Boss2Bomb_State_Active(Boss2Bomb *work);
static void Boss2Bomb_Destructor(Task *task);
static void Boss2Bomb_Draw(void);
static void Boss2Bomb_Collide(void);
static void Boss2Bomb_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss2Bomb_Action_Spawn(Boss2Bomb *work);
static void Boss2Bomb_Action_Destroy(Boss2Bomb *work);
static void Boss2Bomb_BombState_StartFalling(Boss2Bomb *work);
static void Boss2Bomb_BombState_Falling(Boss2Bomb *work);
static void Boss2Bomb_BombState_Landed(Boss2Bomb *work);
static void Boss2Bomb_BombState_MoveDelay(Boss2Bomb *work);
static void Boss2Bomb_BombState_DecideEntryAngle(Boss2Bomb *work);
static void Boss2Bomb_BombState_EnterArena(Boss2Bomb *work);
static void Boss2Bomb_BombState_StartMoving(Boss2Bomb *work);
static void Boss2Bomb_BombState_Moving(Boss2Bomb *work);
static void Boss2Bomb_BombState_Destroy(Boss2Bomb *work);
static void Boss2Bomb_BombState_Inactive(Boss2Bomb *work);

// Boss2Wave
static void Boss2Wave_State_Active(Boss2Wave *work);
static void Boss2Wave_Destructor(Task *task);
static void Boss2Wave_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

Boss2Stage *CreateBoss2Stage(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    NNSFndArchive arc;

    bossStageTaskSingleton = CreateStageTask(Boss2Stage_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Stage);

    Boss2Stage *work = TaskGetWork(bossStageTaskSingleton, Boss2Stage);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss2Stage_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Stage_Draw);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                       | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->health       = HUD_BOSS_HEALTH_MAX;
    work->groundHeight = -y;
    work->stageState   = Boss2Stage_StageState_Init_Part1;

    LoadBossAssets(&work->assets);

    BossHelpers__InitLights(&work->lightConfig);
    BossHelpers__Model__InitSystem();

    AnimatorMDL *aniStage00 = &work->aniStage[0];
    AnimatorMDL__Init(aniStage00, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniStage00, bossAssetFiles[6].fileData, 0, FALSE, FALSE);
    aniStage00->work.translation.x = FLOAT_TO_FX32(0.0);
    aniStage00->work.translation.y = -y;
    aniStage00->work.translation.z = FLOAT_TO_FX32(0.0);
    aniStage00->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniStage00->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniStage00->work.scale.z       = FLOAT_TO_FX32(3.3);

    AnimatorMDL *aniStage01 = &work->aniStage[1];
    AnimatorMDL__Init(aniStage01, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniStage01, bossAssetFiles[7].fileData, 0, FALSE, FALSE);
    aniStage01->work.translation = aniStage00->work.translation;
    aniStage01->work.scale       = aniStage00->work.scale;

    work->boss        = SpawnStageObject(MAPOBJECT_278, x, y, Boss2);
    work->boss->stage = work;

    work->drop        = SpawnStageObject(MAPOBJECT_280, x, y, Boss2Drop);
    work->drop->stage = work;

    for (s32 i = 0; i < BOSS2_BALL_COUNT; i++)
    {
        work->arms[i]        = SpawnStageObjectParam(MAPOBJECT_279, x, y, Boss2Arm, i);
        work->arms[i]->stage = work;

        work->balls[i]        = SpawnStageObjectParam(MAPOBJECT_281, x, y, Boss2Ball, i);
        work->balls[i]->stage = work;
    }

    s16 angleDir;
    if (mtMathRandRepeat(2) != 0)
        angleDir = -1;
    else
        angleDir = 1;
    Boss2Arm_Action_Attach(work->arms[0], 0, angleDir);
    Boss2Ball_Action_Idle(work->balls[0]);
    Boss2Ball_Action_EnableSpikes(&work->balls[0]->spikeWorker);

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMD));
    NNS_FndUnmountArchive(&arc);

    InitSpatialAudioConfig();

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_MANUAL;

    return work;
}

Boss2 *CreateBoss2(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    NNSFndArchive arc;

    Task *task = CreateStageTask(Boss2_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2);

    Boss2 *work = TaskGetWork(task, Boss2);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, FLOAT_TO_FX32(0.0), y - FLOAT_TO_FX32(585.0));

    SetTaskState(&work->gameWork.objWork, Boss2_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2_Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss2_Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->activeArmCount = 0;
    work->bodyMiddlePos  = FLOAT_TO_FX32(11.75);
    work->bodyBottomPos  = FLOAT_TO_FX32(11.75);
    work->angle          = FLOAT_DEG_TO_IDX(69.08203125);

    LoadBossAssets(&work->assets);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -8, -8, 8, 8);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Boss2_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    AnimatorMDL *aniBody = &work->aniBody;
    AnimatorMDL__Init(aniBody, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniBody, bossAssetFiles[0].fileData, 0, FALSE, FALSE);
    aniBody->work.scale.x        = FLOAT_TO_FX32(3.3);
    aniBody->work.scale.y        = FLOAT_TO_FX32(3.3);
    aniBody->work.scale.z        = FLOAT_TO_FX32(3.3);
    aniBody->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;

    NNS_G3dRenderObjSetCallBack(&aniBody->renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "body", MTXSTACK_BOSS2_BODY_TOP, NULL, NULL);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "body_a", MTXSTACK_BOSS2_BODY_MID, Boss2_BodyMidCallback, work);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "body_b", MTXSTACK_BOSS2_BODY_BOTTOM, Boss2_BodyBottomCallback, work);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "weak", MTXSTACK_BOSS2_WEAK, NULL, NULL);

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
    {
        InitPaletteAnimator(&work->aniPalette[i], NNS_FndGetArchiveFileByIndex(&arc, i + ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_EYE_BPA), 0, ANIMATORBPA_FLAG_NONE, 5,
                            VRAMKEY_TO_ADDR(Asset3DSetup__PaletteFromName(NNS_G3dGetTex(bossAssetFiles[0].fileData), Boss2__paletteNames[i])));
    }
    BossHelpers__SetPaletteAnimations(work->aniPalette, (s32)ARRAY_COUNT(work->aniPalette), BOSS2_PALANI_IDLE, FALSE);
    NNS_FndUnmountArchive(&arc);

    Boss2_Action_Init(work);

    return work;
}

Boss2Arm *CreateBoss2Arm(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Task *task = CreateStageTask(Boss2Arm_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Arm);

    Boss2Arm *work = TaskGetWork(task, Boss2Arm);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss2Arm_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Arm_Draw);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->type                = type;
    work->maxAngleVelocity    = FLOAT_DEG_TO_IDX(5.625);
    work->targetAngleVelocity = Boss2__ballTargetAngleVelocityTable[BOSS2_PHASE_1][type];

    LoadBossAssets(&work->assets);

    AnimatorMDL *aniArm = &work->animator;
    AnimatorMDL__Init(aniArm, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniArm, bossAssetFiles[1].fileData, 0, FALSE, FALSE);
    aniArm->work.translation.x  = FLOAT_TO_FX32(0.0);
    aniArm->work.translation.y  = FLOAT_TO_FX32(0.0);
    aniArm->work.translation.z  = FLOAT_TO_FX32(0.0);
    aniArm->work.scale.x        = FLOAT_TO_FX32(3.3);
    aniArm->work.scale.y        = FLOAT_TO_FX32(3.3);
    aniArm->work.scale.z        = FLOAT_TO_FX32(3.3);
    aniArm->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    NNS_G3dRenderObjSetCallBack(&aniArm->renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(aniArm->renderObj.resMdl, "arm_ball", MTXSTACK_BOSS2ARM_ARM_BALL, NULL, NULL);

    Boss2Arm_Action_Inactive(work);

    return work;
}

Boss2Drop *CreateBoss2Drop(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Task *task = CreateStageTask(Boss2Drop_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Drop);

    Boss2Drop *work = TaskGetWork(task, Boss2Drop);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.terminalVelocity = FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, Boss2Drop_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Drop_Draw);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    LoadBossAssets(&work->assets);

    AnimatorMDL *aniDrop = &work->aniDrop;
    AnimatorMDL__Init(aniDrop, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(&work->aniDrop, bossAssetFiles[2].fileData, 0, FALSE, FALSE);
    aniDrop->work.translation.x = FLOAT_TO_FX32(0.0);
    aniDrop->work.translation.y = FLOAT_TO_FX32(0.0);
    aniDrop->work.translation.z = FLOAT_TO_FX32(0.0);
    aniDrop->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniDrop->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniDrop->work.scale.z       = FLOAT_TO_FX32(3.3);

    Boss2Drop_Action_Attached(work);

    return work;
}

NONMATCH_FUNC Boss2Ball *CreateBoss2Ball(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    // will match when 'ballHitboxes', 'ballNames' & 'ballScale' is decompiled
#ifdef NON_MATCHING
    NNSFndArchive arc;

    Task *task = CreateStageTask(Boss2Ball_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Ball);

    Boss2Ball *work = TaskGetWork(task, Boss2Ball);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss2Ball_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Ball_Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss2Ball_Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                       | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->sndHandle               = AllocSndHandle();
    work->type                    = type;
    work->spikeWorker.actionState = BOSS2BALLSPIKES_ACTION_RETRACTED;
    work->spikeWorker.spikeState  = Boss2Ball_SpikeState_Retracted;

    DisableBallSpikes(&work->spikeWorker);

    LoadBossAssets(&work->assets);

    const HitboxRect ballHitboxes[BOSS2_BALL_COUNT] = {
        [BOSS2_BALL_S] = { -16, -16, 16, 16 },
        [BOSS2_BALL_M] = { -24, -24, 24, 24 },
        [BOSS2_BALL_L] = { -32, -32, 32, 32 },
    };
    const HitboxRect *curHitbox = &ballHitboxes[type];

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, curHitbox->left, curHitbox->top, curHitbox->right, curHitbox->bottom);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Boss2Ball_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, (s32)curHitbox->left, (s32)curHitbox->top, curHitbox->right, curHitbox->bottom);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    AnimatorMDL *aniBall = &work->aniBall;
    AnimatorMDL__Init(aniBall, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBall, bossAssetFiles[3].fileData, type, FALSE, FALSE);
    aniBall->work.translation.x = FLOAT_TO_FX32(0.0);
    aniBall->work.translation.y = FLOAT_TO_FX32(0.0);
    aniBall->work.translation.z = FLOAT_TO_FX32(0.0);
    aniBall->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniBall->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniBall->work.scale.z       = FLOAT_TO_FX32(3.3);

    const char *ballNames[BOSS2_BALL_COUNT] = {
        [BOSS2_BALL_S] = "ball_a_hit",
        [BOSS2_BALL_M] = "ball_b_hit",
        [BOSS2_BALL_L] = "ball_c_hit",
    };
    aniBall->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    NNS_G3dRenderObjSetCallBack(&aniBall->renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(aniBall->renderObj.resMdl, ballNames[type], MTXSTACK_BOSS2BALL_BALL_HIT, NULL, NULL);

    AnimatorMDL *aniSpike = &work->spikeWorker.aniSpike;
    AnimatorMDL__Init(aniSpike, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniSpike, bossAssetFiles[4].fileData, type, FALSE, FALSE);
    aniSpike->work.translation.x = FLOAT_TO_FX32(0.0);
    aniSpike->work.translation.y = FLOAT_TO_FX32(0.0);
    aniSpike->work.translation.z = FLOAT_TO_FX32(0.0);
    aniSpike->work.scale.x       = FLOAT_TO_FX32(1.0);
    aniSpike->work.scale.y       = FLOAT_TO_FX32(1.0);
    aniSpike->work.scale.z       = FLOAT_TO_FX32(1.0);

    const fx32 ballScale[BOSS2_BALL_COUNT] = {
        [BOSS2_BALL_S] = FLOAT_TO_FX32(26.4),
        [BOSS2_BALL_M] = FLOAT_TO_FX32(46.1973),
        [BOSS2_BALL_L] = FLOAT_TO_FX32(65.9961),
    };

    AnimatorMDL *aniBallD = &work->aniBallD;
    AnimatorMDL__Init(aniBallD, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBallD, bossAssetFiles[3].fileData, 3, FALSE, FALSE);
    aniBallD->work.translation.x = FLOAT_TO_FX32(0.0);
    aniBallD->work.translation.y = FLOAT_TO_FX32(0.0);
    aniBallD->work.translation.z = FLOAT_TO_FX32(0.0);
    aniBallD->work.scale.x       = ballScale[type];
    aniBallD->work.scale.y       = FLOAT_TO_FX32(329.9805);
    aniBallD->work.scale.z       = ballScale[type];

    AnimatorMDL *aniBallM = &work->aniBallM;
    AnimatorMDL__Init(aniBallM, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBallM, bossAssetFiles[3].fileData, 4, FALSE, FALSE);
    work->aniBallM.work.matrixOpIDs[0] = MATRIX_OP_NONE;
    work->aniBallM.work.translation.x  = FLOAT_TO_FX32(0.0);
    work->aniBallM.work.translation.y  = FLOAT_TO_FX32(0.0);
    work->aniBallM.work.translation.z  = FLOAT_TO_FX32(0.0);
    work->aniBallM.work.scale.x        = ballScale[type];
    work->aniBallM.work.scale.y        = FLOAT_TO_FX32(329.9805);
    work->aniBallM.work.scale.z        = ballScale[type];

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    InitPaletteAnimator(&work->aniPalette[0], NNS_FndGetArchiveFileByIndex(&arc, type + ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_BALL_A_BPA), 0, ANIMATORBPA_FLAG_CAN_LOOP, 5,
                        VRAMKEY_TO_ADDR(Asset3DSetup__PaletteFromName(NNS_G3dGetTex(bossAssetFiles[3].fileData), Boss2Ball__paletteNames[type])));
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2BALL_PALANI_INACTIVE, FALSE);
    NNS_FndUnmountArchive(&arc);

    Boss2Ball_Action_Inactive(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xa4
	mov r6, #0x1500
	mov r7, r0
	str r6, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	str r0, [sp, #4]
	ldr r6, =0x00000988
	ldr r0, =StageTask_Main
	ldr r1, =Boss2Ball_Destructor
	mov r2, #0
	mov r8, r3
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r6, r0
	ldr r2, =0x00000988
	mov r0, #0
	mov r1, r6
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r5
	mov r3, r4
	mov r0, r6
	bl GameObject__InitFromObject
	ldr r1, =Boss2Ball_State_Active
	ldr r0, =Boss2Ball_Draw
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, =Boss2Ball_Collide
	str r0, [r6, #0x108]
	ldr r0, [r6, #0x18]
	orr r0, r0, #0x10
	str r0, [r6, #0x18]
	ldr r0, [r6, #0x1c]
	orr r0, r0, #0xa300
	str r0, [r6, #0x1c]
	bl AllocSndHandle
	str r0, [r6, #0x984]
	str r8, [r6, #0x37c]
	mov r0, #3
	str r0, [r6, #0x384]
	ldr r1, =Boss2Ball_SpikeState_Retracted
	add r0, r6, #0x380
	str r1, [r6, #0x380]
	bl DisableBallSpikes
	add r0, r6, #0x364
	bl LoadBossAssets
	ldr r4, =Boss2__ballHitboxes
	add r3, sp, #0x24
	mov r2, #6
_0215B838:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0215B838
	add r5, sp, #0x24
	add r0, r6, #0x218
	mov r1, #2
	mov r2, #0
	mov r4, r8, lsl #3
	add r7, r5, r8, lsl #3
	bl ObjRect__SetAttackStat
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x218
	bl ObjRect__SetDefenceStat
	ldrsh r1, [r7, #6]
	add r0, r6, #0x218
	str r1, [sp]
	ldrsh r1, [r5, r4]
	ldrsh r2, [r7, #2]
	ldrsh r3, [r7, #4]
	bl ObjRect__SetBox2D
	ldr r1, =Boss2Ball_OnDefend
	str r6, [r6, #0x234]
	str r1, [r6, #0x23c]
	ldr r2, [r6, #0x230]
	add r0, r6, #0x258
	orr r2, r2, #0x80
	bic r2, r2, #4
	str r2, [r6, #0x230]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r6, #0x258
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldrsh r1, [r7, #6]
	add r0, r6, #0x258
	str r1, [sp]
	ldrsh r1, [r5, r4]
	ldrsh r2, [r7, #2]
	ldrsh r3, [r7, #4]
	bl ObjRect__SetBox2D
	str r6, [r6, #0x274]
	ldr r0, [r6, #0x270]
	add r4, r6, #0x1b8
	bic r0, r0, #4
	str r0, [r6, #0x270]
	add r0, r4, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r4, #0x400
	mov r2, r8
	bl AnimatorMDL__SetResource
	mov r5, #0
	str r5, [r4, #0x448]
	str r5, [r4, #0x44c]
	ldr r0, =0x000034CC
	str r5, [r4, #0x450]
	str r0, [r4, #0x418]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x420]
	ldr r0, =Boss2__ballNames
	add r3, sp, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	mov r2, r5
	strb r0, [r4, #0x40a]
	mov r5, #3
	ldr r1, =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	add r1, sp, #0x18
	ldr r0, [r4, #0x494]
	ldr r1, [r1, r8, lsl #2]
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	add r0, r6, #0x394
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x20]
	add r0, r6, #0x394
	mov r2, r8
	bl AnimatorMDL__SetResource
	mov r4, #0
	str r4, [r6, #0x3dc]
	str r4, [r6, #0x3e0]
	str r4, [r6, #0x3e4]
	mov r0, #0x1000
	str r0, [r6, #0x3ac]
	str r0, [r6, #0x3b0]
	str r0, [r6, #0x3b4]
	ldr r0, =Boss2__ballScales
	add r3, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r5, r6, #0x2fc
	mov r1, r4
	add r0, r5, #0x400
	bl AnimatorMDL__Init
	mov r3, r4
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r5, #0x400
	mov r2, #3
	bl AnimatorMDL__SetResource
	mov r1, r4
	str r1, [r5, #0x448]
	str r1, [r5, #0x44c]
	str r1, [r5, #0x450]
	add r0, sp, #0xc
	ldr r4, [r0, r8, lsl #2]
	ldr r2, =0x00149FB0
	str r4, [r5, #0x418]
	str r2, [r5, #0x41c]
	add r0, r6, #0x840
	str r4, [r5, #0x420]
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r6, #0x840
	mov r2, #4
	bl AnimatorMDL__SetResource
	mov r0, #0
	strb r0, [r6, #0x84a]
	str r0, [r6, #0x888]
	str r0, [r6, #0x88c]
	str r0, [r6, #0x890]
	ldr r0, =0x00149FB0
	str r4, [r6, #0x858]
	str r0, [r6, #0x85c]
	ldr r0, =gameArchiveStage
	str r4, [r6, #0x860]
	ldr r2, [r0, #0]
	ldr r1, =0x0217A7FC // =aExec
	add r0, sp, #0x3c
	bl NNS_FndMountArchive
	add r0, sp, #0x3c
	add r1, r8, #9
	bl NNS_FndGetArchiveFileByIndex
	ldr r1, =bossAssetFiles
	mov r4, r0
	ldr r0, [r1, #0x18]
	bl NNS_G3dGetTex
	ldr r1, =Boss2Ball__paletteNames
	ldr r1, [r1, r8, lsl #2]
	bl Asset3DSetup__PaletteFromName
	mov r2, #5
	str r2, [sp]
	str r0, [sp, #4]
	add r0, r6, #0x198
	mov r1, r4
	add r0, r0, #0x400
	mov r2, #0
	mov r3, #2
	bl InitPaletteAnimator
	add r0, r6, #0x198
	mov r2, #0
	add r0, r0, #0x400
	mov r1, #1
	mov r3, r2
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0x3c
	bl NNS_FndUnmountArchive
	mov r0, r6
	bl Boss2Ball_Action_Inactive
	mov r0, r6
	add sp, sp, #0xa4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

Boss2Bomb *CreateBoss2Bomb(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Task *task = CreateStageTask(Boss2Bomb_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Bomb);

    Boss2Bomb *work = TaskGetWork(task, Boss2Bomb);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.terminalVelocity = FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, Boss2Bomb_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Bomb_Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss2Bomb_Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    LoadBossAssets(&work->assets);

    StageTask__SetHitbox(&work->gameWork.objWork, -8, -20, 8, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], 2, 64);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], 1, 64);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -15, -24, 15, 0);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Boss2Bomb_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    AnimatorMDL *aniBomb = &work->aniBomb;
    AnimatorMDL__Init(aniBomb, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBomb, bossAssetFiles[5].fileData, 0, FALSE, FALSE);
    aniBomb->work.scale.x = FLOAT_TO_FX32(3.3);
    aniBomb->work.scale.y = FLOAT_TO_FX32(3.3);
    aniBomb->work.scale.z = FLOAT_TO_FX32(3.3);

    Boss2Bomb_Action_Spawn(work);

    return work;
}

Boss2Wave *CreateBoss2Wave(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    NNSFndArchive arc;

    Task *task = CreateStageTask(Boss2Wave_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Wave);

    Boss2Wave *work = TaskGetWork(task, Boss2Wave);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.terminalVelocity = FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, Boss2Wave_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Wave_Draw);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    AnimatorMDL *aniWave = &work->aniWave;
    AnimatorMDL__Init(aniWave, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniWave, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMD), 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniWave, B3D_ANIM_JOINT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBCA), 0, NULL);
    AnimatorMDL__SetAnimation(aniWave, B3D_ANIM_MAT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMA), 0, NULL);
    AnimatorMDL__SetAnimation(aniWave, B3D_ANIM_VIS_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBVA), 0, NULL);
    aniWave->work.translation.y = -y;
    aniWave->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniWave->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniWave->work.scale.z       = FLOAT_TO_FX32(3.3);
    aniWave->speedMultiplier    = FLOAT_TO_FX32(0.4);
    NNS_FndUnmountArchive(&arc);

    return work;
}

void DrawBossStagePlayer(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BossHelpers__Arena__GetPlayerDrawMtx(work, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
        originalPlayerDrawFunc();
    }
}

void LoadBossAssets(Boss2Assets *assets)
{
    NNSFndArchive arc;

    assets->background = MapFarSys__GetAsset();

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    assets->jointAnims = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_NSBCA);
    assets->visAnims   = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_NSBVA);
    NNS_FndUnmountArchive(&arc);
}

Boss2Phase GetBossPhase(Boss2Stage *work)
{
    s16 health = work->health;

    Boss2Phase p = BOSS2_PHASE_1;
    for (; p < BOSS2_PHASE_COUNT - 1; p++)
    {
        if (phaseHealthThreshold[p] < health)
            break;
    }

    return p;
}

fx32 GetBossBaseDamage(Boss2Stage *work, s32 ballType)
{
    UNUSED(work);
    UNUSED(ballType);

    return baseDamageTable[gameState.difficulty];
}

fx32 GetBallBaseDamage(Boss2Stage *work, s32 ballType)
{
    return Boss2__ballBaseDamageTable[GetBossPhase(work)][ballType];
}

u16 GetBallImpactDamage(Boss2Stage *work, s32 ballType)
{
    return FX32_TO_WHOLE(GetBossBaseDamage(work, ballType) * GetBallBaseDamage(work, ballType));
}

fx32 GetBallHitFXScale(Boss2Stage *work, s32 ballType)
{
    return Boss2__ballHitFXScaleTable[ballType];
}

s16 GetBallTargetAngleVelocity(Boss2Stage *work, s32 ballType)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return Boss2__ballTargetAngleVelocityTable[BOSS2_PHASE_4][ballType];
    }
    else
    {
        return Boss2__ballTargetAngleVelocityTable[GetBossPhase(work)][ballType];
    }
}

fx16 GetBallWeight(Boss2Stage *work, s32 ballType)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return ballWeights_Heavy[ballType];
    }
    else
    {
        return ballWeights_Normal[ballType];
    }
}

void ConfigureBallActions(Boss2Stage *work, s32 ballType, u16 *spikeDuration, u16 *vulnerableDuration)
{
    const struct Boss2BallConfig *config;

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        config = &Boss2__ballActionConfigTable[BOSS2_PHASE_4][ballType];
    }
    else
    {
        config = &Boss2__ballActionConfigTable[GetBossPhase(work)][ballType];
    }

    *spikeDuration      = config->spikeDuration;
    *vulnerableDuration = config->vulnerableDuration;
}

u16 GetBossDropAttackInterval(Boss2Stage *work)
{
    const struct Boss2TimerConfig *config;

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        config = &Boss2__dropAttackConfigTable[gameState.difficulty][BOSS2_PHASE_4];
    }
    else
    {
        config = &Boss2__dropAttackConfigTable[gameState.difficulty][GetBossPhase(work)];
    }

    return config->baseValue + (mtMathRand() & config->range);
}

u16 GetBossBombSpawnInterval(Boss2Stage *work)
{
    const struct Boss2TimerConfig *config;

    Boss2Phase phase = GetBossPhase(work);
    UNUSED(phase);

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        config = &Boss2__bombSpawnConfigTable[gameState.difficulty][BOSS2_PHASE_4];
    }
    else
    {
        config = &Boss2__bombSpawnConfigTable[gameState.difficulty][GetBossPhase(work)];
    }

    return config->baseValue + (mtMathRand() & config->range);
}

void ConfigureBossActions(Boss2Stage *work)
{
    if (work->boss->dropActionTimer == 0)
        work->boss->dropActionTimer = GetBossDropAttackInterval(work);

    if (work->boss->bombSpawnTimer == 0)
        work->boss->bombSpawnTimer = GetBossBombSpawnInterval(work);

    for (s32 i = 0; i < BOSS2_BALL_COUNT; i++)
    {
        work->arms[i]->targetAngleVelocity = GetBallTargetAngleVelocity(work, work->arms[i]->type);
    }
}

void ConfigureBossStageCamera(Boss2Stage *work)
{
    VecFx32 cam1Target0, cam1Target1, cam1Up;
    VecFx32 cam2Target0, cam2Target1, cam2Up;

    VecFx32 camPos;
    VecFx32 camTarget;

    Boss2Ball *balls[3];

    BossArena__SetAngleTarget(BossArena__GetCamera(0), BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END));

    Camera3D *cameraConfig = BossArena__GetCameraConfig2(BossArena__GetCamera(0));
    u16 ballCount          = GetBallsOnTopScreen(work, balls);

    if (ballCount)
    {
        camTarget.x = FLOAT_TO_FX32(0.0);
        camTarget.y = FLOAT_TO_FX32(0.0);
        camTarget.z = FLOAT_TO_FX32(0.0);

        for (u16 i = 0; i < ballCount; i++)
        {
            Boss2Ball *ball = balls[i];

            camTarget.x += ball->mtxBallCenter.translation.x;
            camTarget.y += ball->mtxBallCenter.translation.y;
            camTarget.z += ball->mtxBallCenter.translation.z;
        }

        camTarget.x = FX_DivS32(camTarget.x, ballCount);
        camTarget.y = FX_DivS32(camTarget.y, ballCount);
        camTarget.z = FX_DivS32(camTarget.z, ballCount);

        camTarget.x = cameraConfig->camTarget.x + MultiplyFX(FLOAT_TO_FX32(0.3), camTarget.x - cameraConfig->camTarget.x);
        camTarget.y = cameraConfig->camTarget.y + MultiplyFX(FLOAT_TO_FX32(0.05), camTarget.y - cameraConfig->camTarget.y);
        camTarget.z = cameraConfig->camTarget.z + MultiplyFX(FLOAT_TO_FX32(0.3), camTarget.z - cameraConfig->camTarget.z);

        VecFx32 camConfigLocalPos;
        VecFx32 camLocalPos;
        VecFx32 camDir;
        VecFx32 distance;
        VEC_Subtract(&cameraConfig->camTarget, &cameraConfig->camPos, &camConfigLocalPos);
        VEC_Subtract(&camTarget, &cameraConfig->camPos, &camLocalPos);
        VEC_Normalize(&camLocalPos, &camDir);
        VEC_Subtract(&camLocalPos, &camConfigLocalPos, &distance);

        fx32 magnitude = MultiplyFX(FLOAT_TO_FX32(0.3), VEC_Mag(&distance));
        camPos.x       = camTarget.x - camLocalPos.x - MultiplyFX(camDir.x, magnitude);
        camPos.y       = camTarget.y;
        camPos.z       = camTarget.z - camLocalPos.z - MultiplyFX(camDir.z, magnitude);
    }
    else
    {
        camPos    = cameraConfig->camPos;
        camTarget = cameraConfig->camTarget;
    }

    BossArena__Func_2039AD4(&camPos, &camTarget, &cameraConfig->camUp, FLOAT_TO_FX32(350.0), FLOAT_TO_FX32(1.3333), &cam1Target0, &cam1Target1, &cam1Up, &cam2Target0, &cam2Target1,
                            &cam2Up);
    ConfigureBossCamera1(work, &cam1Target0, &cam1Target1, &cam1Up);
    ConfigureBossCamera2(work, &cam2Target0, &cam2Target1, &cam2Up);
}

void ConfigureBossCamera1(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up)
{
    BossArenaCamera *camera = BossArena__GetCamera(1);

    BossArena__SetCameraType(camera, BOSSARENACAMERA_TYPE_0);
    BossArena__SetUpVector(camera, up);
    BossArena__SetTracker1TargetPos(camera, target1->x, target1->y, target1->z);
    BossArena__SetTracker0TargetPos(camera, target0->x, target0->y, target0->z);
    BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
    BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
}

void ConfigureBossCamera2(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up)
{
    BossArenaCamera *camera = BossArena__GetCamera(2);

    BossArena__SetCameraType(camera, BOSSARENACAMERA_TYPE_0);
    BossArena__SetUpVector(camera, up);
    BossArena__SetTracker1TargetPos(camera, target1->x, target1->y, target1->z);
    BossArena__SetTracker0TargetPos(camera, target0->x, target0->y, target0->z);
    BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
    BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
}

u16 GetBallsOnTopScreen(Boss2Stage *work, Boss2Ball **balls)
{
    s32 i;
    u16 count = 0;

    for (i = 0; i < BOSS2_BALL_COUNT; i++)
    {
        Boss2Ball *ball = work->balls[i];
        if (ball->actionState == BOSS2BALL_ACTION_HIT && ball->hitImpactForce > FLOAT_TO_FX32(6.0))
        {
            balls[count] = ball;
            count++;
        }
    }

    return count;
}

void HandleBossCamera(Boss2Stage *work)
{
    FXMatrix43 mtxView;

    Camera3D *config = BossArena__GetCameraConfig2(BossArena__GetCamera(1));

    MTX_LookAt(&config->camPos, &config->camUp, &config->camTarget, mtxView.nnMtx);
    InitSpatialAudioMatrix(&mtxView.mtx33);
    SetSpatialAudioOriginPosition(&gPlayer->aniPlayerModel.ani.work.translation);
}

void Boss2Stage_State_Active(Boss2Stage *work)
{
    BossHelpers__ProcessLights(&work->lightConfig);
    HandleBossCamera(work);

    work->stageState(work);
}

void Boss2Stage_Destructor(Task *task)
{
    NNSFndArchive arc;

    Boss2Stage *work = TaskGetWork(task, Boss2Stage);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniStage); i++)
    {
        AnimatorMDL__Release(&work->aniStage[i]);
    }

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMD));
    NNS_FndUnmountArchive(&arc);

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_AUTO;

    bossStageTaskSingleton = NULL;

    GameObject__Destructor(task);
}

void Boss2Stage_Draw(void)
{
    Boss2Stage *work = TaskGetWorkCurrent(Boss2Stage);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BossHelpers__RevertModifiedLights(&work->lightConfig);
        AnimatorMDL__Draw(&work->aniStage[0]);
        AnimatorMDL__Draw(&work->aniStage[1]);
        BossHelpers__ApplyModifiedLights(&work->lightConfig);
    }
}

void Boss2_Collide(void)
{
    Boss2 *work = TaskGetWorkCurrent(Boss2);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    if ((work->gameWork.colliders[0].flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
        return;

    BossHelpers__Collision__HandleArenaCollider(work->gameWork.colliders, &work->worldCollider, &work->mtxWeakPoint.translation, BOSS2_STAGE_START, BOSS2_STAGE_END,
                                                BOSS2_STAGE_RADIUS);
}

void Boss2_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss2 *boss    = (Boss2 *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    boss->stage->health = HUD_BOSS_HEALTH_NONE;
    UpdateBossHealthHUD(boss->stage->health);
    Boss2_Action_Destroy(boss);
}

NONMATCH_FUNC void Boss2Stage_StageState_Init_Part1(Boss2Stage *work)
{
    // will match when 'Boss2Stage_StageState_Init_Part1_camUp' is decompiled
#ifdef NON_MATCHING
    VecFx32 camUp = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    CameraConfig config;
    MI_CpuClear16(&config, sizeof(config));
    config.projFOV     = FLOAT_DEG_TO_IDX(30.0);
    config.projNear    = FLOAT_TO_FX32(1.0);
    config.projFar     = FLOAT_TO_FX32(2560.0);
    config.aspectRatio = FLOAT_TO_FX32(1.3333);
    config.projScaleW  = FLOAT_TO_FX32(0.8);

    BossArena__SetType(BOSSARENA_TYPE_4);

    BossArenaCamera *camera0 = BossArena__GetCamera(0);
    BossArena__SetCameraType(camera0, BOSSARENACAMERA_TYPE_1);
    BossArena__SetCameraConfig(camera0, &config);
    BossArena__SetTracker1TargetWork(camera0, &gPlayer->objWork, 0, &gPlayer->objWork);
    BossArena__SetTracker1TargetPos(camera0, 0, work->groundHeight + 0x118000, 0);
    BossArena__SetTracker1Speed(camera0, 1024, 0);
    BossArena__SetTracker1UseObj3D(camera0, TRUE);
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__SetAmplitudeXZTarget(camera0, 1024000);
    BossArena__SetAmplitudeXZSpeed(camera0, 512);
    BossArena__ApplyAmplitudeXZTarget(camera0);
    BossArena__SetAmplitudeYTarget(camera0, -122880);
    BossArena__ApplyAmplitudeYTarget(camera0);
    BossArena__SetAngleTarget(camera0, BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END));
    BossArena__ApplyAngleTarget(camera0);
    BossArena__DoProcess();
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__UpdateTracker0TargetPos(camera0);
    ConfigureBossStageCamera(work);
    BossArena__DoProcess();
    ConfigureBossStageCamera(work);

    BossArenaCamera *camera1 = BossArena__GetCamera(1);
    BossArena__SetCameraConfig(camera1, &config);
    BossArena__SetUpVector(camera1, &camUp);
    BossArena__UpdateTracker1TargetPos(camera1);
    BossArena__UpdateTracker0TargetPos(camera1);

    BossArenaCamera *camera2 = BossArena__GetCamera(2);
    BossArena__SetCameraConfig(camera2, &config);
    BossArena__SetUpVector(camera2, &camUp);
    BossArena__UpdateTracker1TargetPos(camera2);
    BossArena__UpdateTracker0TargetPos(camera2);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_23);

    BossArena__SetBackgroundType(BOSSARENABACKGROUND_TYPE_3D);

    BossArenaUnknown4A8 *unknown = BossArena__GetField4A8();
    unknown->background          = work->assets.background;
    unknown->backgroundID        = BACKGROUND_1;
    unknown->screenBaseA         = 0;
    unknown->screenBaseBlock     = 0;

    void *background = GetBackgroundPixels(work->assets.background);
    LoadCompressedPixels(background, PIXEL_MODE_SPRITE, VRAMSystem__VRAM_BG[0] + 0x4000);
    LoadCompressedPalette(GetBackgroundPalette(work->assets.background), PALETTE_MODE_SPRITE, VRAMSystem__VRAM_PALETTE_BG[0]);

    BossArena__SetBoundsX(0, -160);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG1);

    Camera3D__Create();
    Camera3DTask *camera3D_A = Camera3D__GetWork();
    Camera3DTask *camera3D_B = Camera3D__GetWork();

    camera3D_A->gfxControl[0].blendManager.blendControl.value = camera3D_B->gfxControl[1].blendManager.blendControl.value = 0x00;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane1_BG0 = camera3D_B->gfxControl[1].blendManager.blendControl.plane1_BG0 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_BG1 = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_BG1 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_BG2 = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_BG2 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_BG3 = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_BG3 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_OBJ = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_OBJ = TRUE;

    originalPlayerDrawFunc = gPlayer->objWork.ppOut;
    SetTaskOutFunc(&gPlayer->objWork, DrawBossStagePlayer);
    gPlayer->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    UpdateBossHealthHUD(work->health);
    SetHUDActiveScreen(1);

    work->stageState = Boss2Stage_StageState_Init_Part2;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	ldr r1, =Boss2Stage_StageState_Init_Part1_camUp
	add r3, sp, #0x20
	mov r5, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r4, =0x00001555
	mov r3, #0x1000
	sub r1, r3, #0x334
	mov r2, #0xa00000
	mov r0, #4
	str r3, [sp, #4]
	strh r4, [sp]
	str r2, [sp, #8]
	str r4, [sp, #0xc]
	str r1, [sp, #0x10]
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	ldr r1, =gPlayer
	mov r0, r4
	ldr r1, [r1, #0]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r5, #0x39c]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	add r2, r2, #0x118000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	mov r1, #0xfa000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x1e000
	mov r0, r4
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, =gPlayer
	ldr r2, =BOSS2_STAGE_END
	ldr r0, [r0, #0]
	mov r1, #BOSS2_STAGE_START
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, r0
	mov r0, r4
	bl BossArena__SetAngleTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	bl BossArena__DoProcess
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r5
	bl ConfigureBossStageCamera
	bl BossArena__DoProcess
	mov r0, r5
	bl ConfigureBossStageCamera
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, r0
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	ldr r2, =0x0400000A
	mov r0, #2
	ldrh r1, [r2, #0]
	and r1, r1, #0x43
	orr r1, r1, #4
	orr r1, r1, #0x6000
	strh r1, [r2]
	bl BossArena__SetBackgroundType
	bl BossArena__GetField4A8
	ldr r2, [r5, #0x364]
	mov r1, #1
	str r2, [r0, #4]
	strb r1, [r0, #0x14]
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r0, [r5, #0x364]
	bl GetBackgroundPixels
	ldr r2, =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2, #0]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2, #0]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0xa0
	bl BossArena__SetBoundsX
	mov r2, #0x4000000
	ldr r0, [r2, #0]
	and r0, r0, #0x1f00
	mov r0, r0, lsr #8
	ldr r1, [r2, #0]
	orr r0, r0, #2
	bic r1, r1, #0x1f00
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bl Camera3D__Create
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0
	strh r1, [r0, #0x7c]
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	ldr r3, =DrawBossStagePlayer
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x200
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x400
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x800
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	ldr r2, =gPlayer
	orr r1, r1, #0x1000
	strh r1, [r0, #0x7c]
	ldrh r0, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1f
	bic r1, r1, #0x1000
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #19
	strh r0, [r4, #0x20]
	ldr ip, [r2]
	ldr r1, =originalPlayerDrawFunc
	ldr r4, [ip, #0xfc]
	add r0, r5, #0x300
	str r4, [r1]
	str r3, [ip, #0xfc]
	ldr r2, [r2, #0]
	ldr r1, [r2, #0x20]
	orr r1, r1, #0x2000
	str r1, [r2, #0x20]
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, =Boss2Stage_StageState_Init_Part2
	str r0, [r5, #0x394]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Stage_StageState_Init_Part2(Boss2Stage *work)
{
    // will match when 'camUp' / 'Boss2Stage_StageState_Init_Part2_camUp' is decompiled
#ifdef NON_MATCHING
    VecFx32 camUp = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    BossArena__SetType(BOSSARENA_TYPE_4);

    BossArenaCamera *camera0 = BossArena__GetCamera(0);
    BossArena__SetCameraType(camera0, BOSSARENACAMERA_TYPE_1);
    BossArena__SetTracker1TargetWork(camera0, &gPlayer->objWork, 0, &gPlayer->objWork);
    BossArena__SetTracker1TargetPos(camera0, 0, work->groundHeight + FLOAT_TO_FX32(279.0), 0);
    BossArena__SetTracker1Speed(camera0, 1024, 0);
    BossArena__SetTracker1UseObj3D(camera0, TRUE);
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__SetAmplitudeXZTarget(camera0, 1024000);
    BossArena__SetAmplitudeXZSpeed(camera0, 512);
    BossArena__ApplyAmplitudeXZTarget(camera0);
    BossArena__SetAmplitudeYTarget(camera0, -122880);
    BossArena__ApplyAmplitudeYTarget(camera0);
    BossArena__SetAngleTarget(camera0, BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END));
    BossArena__ApplyAngleTarget(camera0);
    BossArena__DoProcess();
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__UpdateTracker0TargetPos(camera0);
    ConfigureBossStageCamera(work);
    BossArena__DoProcess();
    ConfigureBossStageCamera(work);

    BossArenaCamera *camera1 = BossArena__GetCamera(1);
    BossArena__SetUpVector(camera1, &camUp);
    BossArena__UpdateTracker1TargetPos(camera1);
    BossArena__UpdateTracker0TargetPos(camera1);

    BossArenaCamera *camera2 = BossArena__GetCamera(2);
    BossArena__SetUpVector(camera2, &camUp);
    BossArena__UpdateTracker1TargetPos(camera2);
    BossArena__UpdateTracker0TargetPos(camera2);

    work->stageState = Boss2Stage_StageState_Idle;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, =Boss2Stage_StageState_Init_Part2_camUp
	add r3, sp, #0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	ldr r1, =gPlayer
	mov r0, r5
	ldr r1, [r1, #0]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r4, #0x39c]
	mov r1, #0
	mov r0, r5
	mov r3, r1
	add r2, r2, #0x118000
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0xfa000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x1e000
	mov r0, r5
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, =gPlayer
	ldr r2, =BOSS2_STAGE_END
	ldr r0, [r0, #0]
	mov r1, #BOSS2_STAGE_START
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAngleTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__DoProcess
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r4
	bl ConfigureBossStageCamera
	bl BossArena__DoProcess
	mov r0, r4
	bl ConfigureBossStageCamera
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	add r1, sp, #0
	bl BossArena__SetUpVector
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	ldr r0, =Boss2Stage_StageState_Idle
	str r0, [r4, #0x394]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void Boss2Stage_StageState_Idle(Boss2Stage *work)
{
    if (work->hasCameraOverride == FALSE)
        ConfigureBossStageCamera(work);

    BossArena__SetNextPos(BossArena__GetCamera(1), MultiplyFX(GetScreenShakeOffsetX(), FLOAT_TO_FX32(1.0)), MultiplyFX(GetScreenShakeOffsetY(), FLOAT_TO_FX32(1.0)),
                          FLOAT_TO_FX32(0.0));
    BossArena__SetNextPos(BossArena__GetCamera(2), MultiplyFX(GetScreenShakeOffsetX(), FLOAT_TO_FX32(1.0)), MultiplyFX(GetScreenShakeOffsetY(), FLOAT_TO_FX32(1.0)),
                          FLOAT_TO_FX32(0.0));
}

void Boss2_State_Active(Boss2 *work)
{
    switch (work->activeArmCount)
    {
        case 0:
            if (work->bodyBottomPos < FLOAT_TO_FX32(11.75))
                work->bodyBottomPos += FLOAT_TO_FX32(0.3);
            else if (work->bodyMiddlePos < FLOAT_TO_FX32(11.75))
                work->bodyMiddlePos += FLOAT_TO_FX32(0.3);
            break;

        case 1:
            if (work->bodyMiddlePos > FLOAT_TO_FX32(0.0))
                work->bodyMiddlePos -= FLOAT_TO_FX32(0.3);

            if (work->bodyBottomPos < FLOAT_TO_FX32(11.75))
                work->bodyBottomPos += FLOAT_TO_FX32(0.3);
            break;

        case 2:
            if (work->bodyMiddlePos > FLOAT_TO_FX32(0.0))
                work->bodyMiddlePos -= FLOAT_TO_FX32(0.3);
            else if (work->bodyBottomPos > FLOAT_TO_FX32(0.0))
                work->bodyBottomPos -= FLOAT_TO_FX32(0.3);
            break;
    }

    work->bossState(work);
}

void Boss2_Destructor(Task *task)
{
    Boss2 *work = TaskGetWork(task, Boss2);

    AnimatorMDL__Release(&work->aniBody);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
        ReleasePaletteAnimator(&work->aniPalette[i]);

    GameObject__Destructor(task);
}

void Boss2_Draw(void)
{
    Boss2 *work = TaskGetWorkCurrent(Boss2);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BOOL canDraw = CheckBossCanDraw(work);

        AnimatorMDL *aniBody = &work->aniBody;

        VEC_Set(&aniBody->work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);

        MTX_RotY33(aniBody->work.rotation.nnMtx, SinFX(work->angle), CosFX(work->angle));

        AnimatorMDL__ProcessAnimation(aniBody);

        if (canDraw)
        {
            AnimatorMDL__Draw(aniBody);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_BODY_TOP, &work->mtxBody[0]);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_BODY_MID, &work->mtxBody[1]);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_BODY_BOTTOM, &work->mtxBody[2]);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_WEAK, &work->mtxWeakPoint);
        }

        for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
        {
            AnimatePalette(&work->aniPalette[i]);
            DrawAnimatedPalette(&work->aniPalette[i]);
        }
    }
}

BOOL CheckBossCanDraw(Boss2 *work)
{
    BOOL canDraw = FALSE;

    if (work->prevCanDraw)
    {
        switch (work->actionState)
        {
            case BOSS2_ACTION_DEACTIVATE:
            case BOSS2_ACTION_DESTROYED:
                canDraw = TRUE;
                break;

            default:
                if (Camera3D__UseEngineA())
                    canDraw = TRUE;
                break;
        }
    }
    else
    {
        canDraw           = TRUE;
        work->prevCanDraw = canDraw;
    }

    return canDraw;
}

void Boss2_BodyMidCallback(NNSG3dRS *context, void *userData)
{
    Boss2 *work = (Boss2 *)userData;

    NNS_G3dGeTranslate(FLOAT_TO_FX32(0.0), MTM_MATH_CLIP(work->bodyMiddlePos, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(11.75)), FLOAT_TO_FX32(0.0));
}

void Boss2_BodyBottomCallback(NNSG3dRS *context, void *userData)
{
    Boss2 *work = (Boss2 *)userData;

    NNS_G3dGeTranslate(FLOAT_TO_FX32(0.0), MTM_MATH_CLIP(work->bodyBottomPos, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(11.75)), FLOAT_TO_FX32(0.0));
}

void Boss2_Action_Init(Boss2 *work)
{
    work->actionState = BOSS2_ACTION_INIT;

    work->bossState = Boss2_BossState_Init;
    work->bossState(work);
}

void Boss2_Action_Idle(Boss2 *work)
{
    work->actionState = BOSS2_ACTION_IDLE;

    work->bossState = Boss2_BossState_InitIdle;
    work->bossState(work);
}

void Boss2_Action_Hit(Boss2 *work)
{
    work->actionState = BOSS2_ACTION_HIT;

    work->bossState = Boss2_BossState_InitHit;
    work->bossState(work);
}

void Boss2_Action_Deactivated(Boss2 *work)
{
    work->actionState = BOSS2_ACTION_DEACTIVATE;

    work->bossState = Boss2_BossState_InitDeactivated;
    work->bossState(work);
}

void Boss2_Action_Destroy(Boss2 *work)
{
    work->actionState = BOSS2_ACTION_DESTROYED;

    work->bossState = Boss2_BossState_InitDestroyed;
    work->bossState(work);
}

void Boss2_BossState_Init(Boss2 *work)
{
    Boss2_Action_Idle(work);
}

void Boss2_BossState_InitIdle(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_fw0, NULL, TRUE);

    work->bossState = Boss2_BossState_Idle;
}

void Boss2_BossState_Idle(Boss2 *work)
{
    u16 angle = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END);

    s16 angleDist = ((s16)work->angle - (s16)angle);
    if (MATH_ABS(angleDist) > FLOAT_DEG_TO_IDX(45.0))
        work->tryLookAtPlayer = TRUE;

    if (work->tryLookAtPlayer)
    {
        work->angle = BossHelpers__Math__Func_2039264(work->angle, angle, FLOAT_DEG_TO_IDX(0.52734375));

        angleDist = ((s16)work->angle - (s16)angle);
        if (MATH_ABS(angleDist) < FLOAT_DEG_TO_IDX(5.0))
            work->tryLookAtPlayer = FALSE;
    }

    if (work->dropActionTimer != 0)
    {
        if (work->stage->drop->actionState == BOSS2DROP_ACTION_ATTACHED)
        {
            work->dropActionTimer--;
            if (work->dropActionTimer == 0)
            {
                Boss2Drop_Action_Drop(work->stage->drop);
                work->dropActionTimer = GetBossDropAttackInterval(work->stage);
            }
        }
    }

    if (work->bombSpawnTimer != 0)
    {
        if (work->stage->bomb == NULL && work->stage->drop->actionState == BOSS2DROP_ACTION_ATTACHED)
        {
            work->bombSpawnTimer--;

            if (work->bombSpawnTimer == 0)
            {
                BOOL flipped;
                if (mtMathRandRepeat(2) != 0)
                    flipped = TRUE;
                else
                    flipped = FALSE;
                SpawnBombEnemy(work->stage, FLOAT_TO_FX32(1.5), flipped);

                work->bombSpawnTimer = GetBossBombSpawnInterval(work->stage);

                if (work->dropActionTimer != 0)
                {
                    if (work->dropActionTimer < SECONDS_TO_FRAMES(2.0))
                        work->dropActionTimer += SECONDS_TO_FRAMES(2.0);
                }
            }
        }
    }
}

void Boss2_BossState_InitHit(Boss2 *work)
{
    work->bossState = Boss2_BossState_StartHitImpact;
}

void Boss2_BossState_StartHitImpact(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_dmg0, NULL, FALSE);
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2_PALANI_HIT, TRUE);

    work->bossState = Boss2_BossState_HitImpact;
}

void Boss2_BossState_HitImpact(Boss2 *work)
{
    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->bossState = Boss2_BossState_StartHitRecoil;
}

void Boss2_BossState_StartHitRecoil(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_dmg1, NULL, FALSE);

    work->bossState = Boss2_BossState_HitRecoil;
}

void Boss2_BossState_HitRecoil(Boss2 *work)
{
    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
    {
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2_PALANI_IDLE, FALSE);
        Boss2_Action_Idle(work);
    }
}

void Boss2_BossState_InitDeactivated(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    action->radius = 0;

    work->bossState = Boss2_BossState_StartDeactivatedHit;
}

void Boss2_BossState_StartDeactivatedHit(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_dmg0, NULL, FALSE);
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2_PALANI_HIT, TRUE);

    work->bossState = Boss2_BossState_DeactivatedHit;
}

void Boss2_BossState_DeactivatedHit(Boss2 *work)
{
    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->bossState = Boss2_BossState_StartDeactivatedFallStart;
}

void Boss2_BossState_StartDeactivatedFallStart(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down0, NULL, FALSE);

    work->bossState = Boss2_BossState_DeactivatedFallStart;
}

void Boss2_BossState_DeactivatedFallStart(Boss2 *work)
{
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(4.0);

    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->bossState = Boss2_BossState_StartDeactivatedFallLoop;
}

void Boss2_BossState_StartDeactivatedFallLoop(Boss2 *work)
{
    work->gameWork.objWork.userWork = work->activeArmCount;
    work->activeArmCount            = 0;

    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down1, NULL, TRUE);

    work->bossState = Boss2_BossState_DeactivatedFallLoop;
}

void Boss2_BossState_DeactivatedFallLoop(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    fx32 targetY = -FLOAT_TO_FX32(70.0) - work->stage->groundHeight;

    action->radius += FLOAT_TO_FX32(2.5);
    if (action->radius > FLOAT_TO_FX32(120.0))
        action->radius = FLOAT_TO_FX32(120.0);

    BossHelpers__Arena__GetXZPos(work->angle, action->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    if (work->gameWork.objWork.position.y >= targetY)
    {
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = targetY;

        work->bossState = Boss2_BossState_StartDeactivatedFallLand;
    }
}

void Boss2_BossState_StartDeactivatedFallLand(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down2, NULL, FALSE);
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2_PALANI_IDLE, FALSE);

    ShakeScreenEx(0xA000, 0x3000, 227);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_LAND);

    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;

    work->bossState = Boss2_BossState_DeactivatedFallLand;
}

void Boss2_BossState_DeactivatedFallLand(Boss2 *work)
{
    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->bossState = Boss2_BossState_StartDeactivated;
}

void Boss2_BossState_StartDeactivated(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down3, 0, TRUE);

    work->gameWork.objWork.userTimer = BOSS2_DEACTIVATE_TIME;

    work->bossState = Boss2_BossState_Deactivated;
}

void Boss2_BossState_Deactivated(Boss2 *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
        work->bossState = Boss2_BossState_StartDeactivateRevive;
}

void Boss2_BossState_StartDeactivateRevive(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down4, NULL, FALSE);

    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->stage->health = BOSS2_REACTIVATE_HEALTH;

    UpdateBossHealthHUD(work->stage->health);

    work->bossState = Boss2_BossState_DeactivateRevive;
}

void Boss2_BossState_DeactivateRevive(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    action->radius -= FLOAT_TO_FX32(2.5);
    if (action->radius < FLOAT_TO_FX32(0.0))
        action->radius = FLOAT_TO_FX32(0.0);

    BossHelpers__Arena__GetXZPos(work->angle, action->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.0);

    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->bossState = Boss2_BossState_StartDeactivateRise;
}

void Boss2_BossState_StartDeactivateRise(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down5, NULL, TRUE);

    work->bossState = Boss2_BossState_DeactivateRise;
    work->bossState(work);
}

void Boss2_BossState_DeactivateRise(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    fx32 targetY = work->stage->gameWork.objWork.position.y - FLOAT_TO_FX32(585.0);

    action->radius -= FLOAT_TO_FX32(2.5);
    if (action->radius < FLOAT_TO_FX32(0.0))
        action->radius = FLOAT_TO_FX32(0.0);

    BossHelpers__Arena__GetXZPos(work->angle, action->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.0);

    if (work->gameWork.objWork.position.y <= targetY && action->radius == 0)
    {
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = targetY;

        work->bossState = Boss2_BossState_StartDeactivateRegainArms;
    }
}

void Boss2_BossState_StartDeactivateRegainArms(Boss2 *work)
{
    work->activeArmCount = work->gameWork.objWork.userWork;

    for (s32 i = 0; i <= work->activeArmCount; i++)
        Boss2Arm_Action_FetchBall(work->stage->arms[i]);

    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_body_down6, NULL, FALSE);
    work->bossState = Boss2_BossState_DeactivateRegainArms;
}

void Boss2_BossState_DeactivateRegainArms(Boss2 *work)
{
    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        Boss2_Action_Idle(work);
}

void Boss2_BossState_InitDestroyed(Boss2 *work)
{
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    MI_CpuClear16(action, sizeof(*action));

    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
    StopStageBGM();

    Player__Action_Blank(gPlayer);
    gPlayer->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    Player__ChangeAction(gPlayer, PLAYER_ACTION_HOMING_ATTACK);
    gPlayer->blinkTimer = 0;
    BossHelpers__Player__LockControl(gPlayer);

    work->aniBody.speedMultiplier = FLOAT_TO_FX32(0.0);

    EnableObjectManagerFlag2();
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;
    work->stage->gameWork.objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    for (s32 i = 0; i < 3; i++)
        Boss2Arm_Action_Inactive(work->stage->arms[i]);

    ShakeScreenEx(0x5000, 0x3000, 0x2AA);
    gPlayer->objWork.shakeTimer = FLOAT_TO_FX32(16.0);

    // Create explode impact fx
    BossFX__CreatePendulumExplode2(BOSSFX3D_FLAG_NONE, gPlayer->aniPlayerModel.ani.work.translation.x, gPlayer->aniPlayerModel.ani.work.translation.y,
                                   gPlayer->aniPlayerModel.ani.work.translation.z);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SHOCK_L);

    action->timer   = 0;
    work->bossState = Boss2_BossState_PrepareCameraForDestroyed;
}

void Boss2_BossState_PrepareCameraForDestroyed(Boss2 *work)
{
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    UNUSED(Camera3D__GetWork());

    action->timer++;
    if (action->timer == SECONDS_TO_FRAMES(1.5))
    {
        BossArenaCamera *camera        = BossArena__GetCamera(2);
        work->stage->hasCameraOverride = TRUE;

        VecFx32 translation = gPlayer->aniPlayerModel.ani.work.translation;

        translation.x >>= 1;
        translation.z >>= 1;
        BossArena__SetTracker1TargetWork(camera, NULL, NULL, NULL);
        BossArena__SetTracker1TargetPos(camera, translation.x, translation.y, translation.z);

        translation = gPlayer->aniPlayerModel.ani.work.translation;
        u16 angle   = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END) - FLOAT_DEG_TO_IDX(60.0);

        translation.y += FLOAT_TO_FX32(50.0);
        translation.x += MultiplyFX(FLOAT_TO_FX32(180.0), SinFX((s32)angle));
        translation.z += MultiplyFX(FLOAT_TO_FX32(180.0), CosFX((s32)angle));
        BossArena__SetTracker0TargetPos(camera, translation.x, translation.y, translation.z);

        BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.05), FLOAT_TO_FX32(0.05));
        BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.05), FLOAT_TO_FX32(0.05));

        work->bossState = Boss2_BossState_StartDestroyedShock;
    }
}

void Boss2_BossState_StartDestroyedShock(Boss2 *work)
{
    Camera3DTask *camera3D = Camera3D__GetWork();

    MI_CpuClear16(&camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager, sizeof(camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager));
    camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
    camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane1_BG0 = TRUE;
    camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.value |= GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ;

    work->action.destroyed.timer = 0;
    work->bossState              = Boss2_BossState_DestroyedShock;
}

void Boss2_BossState_DestroyedShock(Boss2 *work)
{
    Boss2Stage *stage                   = work->stage;
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    Camera3DTask *camera3D = Camera3D__GetWork();

    // dim the lights
    if (stage->lightConfig.brightness != RENDERCORE_BRIGHTNESS_BLACK && ++action->lightDimTimer > 1)
    {
        action->lightDimTimer = 0;
        stage->lightConfig.brightness--;
    }

    // brighten the blending
    if (camera3D->gfxControl[0].blendManager.coefficient.value < RENDERCORE_BRIGHTNESS_WHITE && ++action->brightnessTimer > 2)
    {
        action->brightnessTimer = 0;
        camera3D->gfxControl[0].blendManager.coefficient.value++;
    }

    // create explosion "shock" fx
    for (s32 i = 0; i < 3; i++)
    {
        if (action->timer == BossArena__explosionFXSpawnTime[i])
        {
            BossFX__CreatePendulumExplode0(BOSSFX3D_FLAG_NONE, work->mtxWeakPoint.translation.x, work->mtxWeakPoint.translation.y, work->mtxWeakPoint.translation.z);
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TODOME_EFFECT);
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_ENGINEB_ONLY | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(2.0));
            ShakeScreenEx(0x3000, 0x3000, 0x600);
        }
    }

    if (action->timer++ > SECONDS_TO_FRAMES(4))
        work->bossState = Boss2_BossState_StartExplode;
}

void Boss2_BossState_StartExplode(Boss2 *work)
{
    BossFX3D *effect        = BossFX__CreatePendulumExplode1(BOSSFX3D_FLAG_NONE, MultiplyFX(FLOAT_TO_FX32(0.7), work->mtxWeakPoint.translation.x), work->mtxWeakPoint.translation.y,
                                                             MultiplyFX(FLOAT_TO_FX32(0.7), work->mtxWeakPoint.translation.z));
    effect->objWork.scale.x = FLOAT_TO_FX32(3.0);
    effect->objWork.scale.y = FLOAT_TO_FX32(3.0);
    effect->objWork.scale.z = FLOAT_TO_FX32(3.0);
    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(0.333251953125);

    ShakeScreenEx(0xA000, 0x3000, 227);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_EXPLOSION);

    work->action.destroyed.timer = 0;

    work->bossState = Boss2_BossState_Explode;
    work->bossState(work);
}

void Boss2_BossState_Explode(Boss2 *work)
{
    Boss2Stage *stage                   = work->stage;
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    Camera3DTask *camera3D = Camera3D__GetWork();

    BOOL doneLights = FALSE;
    BOOL doneFading = FALSE;

    if (stage->lightConfig.brightness == RENDERCORE_BRIGHTNESS_DEFAULT)
        doneLights = TRUE;
    else
        stage->lightConfig.brightness++;

    if (camera3D->gfxControl[GRAPHICS_ENGINE_A].brightness < RENDERCORE_BRIGHTNESS_WHITE)
    {
        if (action->timer > SECONDS_TO_FRAMES(3.0) && ++action->fadeOutTimer > 3)
        {
            camera3D->gfxControl[GRAPHICS_ENGINE_A].brightness++;
            camera3D->gfxControl[GRAPHICS_ENGINE_B].brightness++;
            action->fadeOutTimer = 0;
        }
    }
    else
    {
        doneFading = TRUE;
    }

    action->timer++;

    if (doneLights && doneFading)
        work->bossState = Boss2_BossState_ShowResultsScreen;
}

void Boss2_BossState_ShowResultsScreen(Boss2 *work)
{
    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
}

void Boss2Drop_State_Active(Boss2Drop *work)
{
    work->dropState(work);
}

void Boss2Drop_Destructor(Task *task)
{
    Boss2Drop *work = TaskGetWork(task, Boss2Drop);

    AnimatorMDL__Release(&work->aniDrop);

    GameObject__Destructor(task);
}

void Boss2Drop_Draw(void)
{
    Boss2Drop *work = TaskGetWorkCurrent(Boss2Drop);

    Boss2 *boss = work->stage->boss;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        if (work->isAttached)
        {
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

            work->gameWork.objWork.position.x = boss->mtxBody[2].translation.x;
            work->gameWork.objWork.position.y = -boss->mtxBody[2].translation.y;
            work->gameWork.objWork.position.z = boss->mtxBody[2].translation.z;

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);
        }
        else
        {
            work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        }

        AnimatorMDL *aniDrop = &work->aniDrop;
        VEC_Set(&aniDrop->work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);

        AnimatorMDL__ProcessAnimation(aniDrop);
        AnimatorMDL__Draw(aniDrop);
    }
}

void Boss2Drop_Action_Attached(Boss2Drop *work)
{
    work->actionState = BOSS2DROP_ACTION_ATTACHED;

    work->dropState = Boss2Drop_DropState_InitAttach;
    work->dropState(work);
}

void Boss2Drop_Action_Drop(Boss2Drop *work)
{
    work->actionState    = BOSS2DROP_ACTION_DROP;
    work->playedSteamSfx = FALSE;

    work->dropState = Boss2Drop_DropState_InitDrop;
    work->dropState(work);
}

void Boss2Drop_DropState_InitAttach(Boss2Drop *work)
{
    work->isAttached = TRUE;

    work->dropState = Boss2Drop_DropState_Attached;
}

void Boss2Drop_DropState_Attached(Boss2Drop *work)
{
    work->aniDrop.work.rotation = work->stage->boss->mtxBody[2].mtx33;

    work->aniDrop.work.rotation.m[0][0] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[0][0]);
    work->aniDrop.work.rotation.m[0][1] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[0][1]);
    work->aniDrop.work.rotation.m[0][2] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[0][2]);
    work->aniDrop.work.rotation.m[1][0] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[1][0]);
    work->aniDrop.work.rotation.m[1][1] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[1][1]);
    work->aniDrop.work.rotation.m[1][2] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[1][2]);
    work->aniDrop.work.rotation.m[2][0] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[2][0]);
    work->aniDrop.work.rotation.m[2][1] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[2][1]);
    work->aniDrop.work.rotation.m[2][2] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[2][2]);
}

void Boss2Drop_DropState_InitDrop(Boss2Drop *work)
{
    work->isAttached = TRUE;

    work->dropState = Boss2Drop_DropState_TelegraphDrop;
}

void Boss2Drop_DropState_TelegraphDrop(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura0, NULL, FALSE);

    work->gameWork.objWork.userTimer = SECONDS_TO_FRAMES(1.0);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_STEAM);

    work->dropState = Boss2Drop_DropState_DimLighting;
}

void Boss2Drop_DropState_DimLighting(Boss2Drop *work)
{
    if (work->stage->lightConfig.brightness >= (RENDERCORE_BRIGHTNESS_BLACK / 2) && (work->gameWork.objWork.userTimer & 1) == 0)
        work->stage->lightConfig.brightness--;

    if (work->gameWork.objWork.userTimer != 0)
        work->gameWork.objWork.userTimer--;

    if ((work->aniDrop.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0 && work->gameWork.objWork.userTimer == 0)
        work->dropState = Boss2Drop_DropState_CreateDropFX;
}

void Boss2Drop_DropState_CreateDropFX(Boss2Drop *work)
{
    BossFX__CreatePendulumDrop(BOSSFX3D_FLAG_NONE, work->aniDrop.work.translation.x, work->aniDrop.work.translation.y - FLOAT_TO_FX32(50.0), work->aniDrop.work.translation.z);

    work->pendulumFallFX = BossFX__CreatePendulumFall(BOSSFX3D_FLAG_NONE, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);

    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura1, NULL, TRUE);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(32.0);

    work->isAttached = FALSE;

    work->dropState = Boss2Drop_DropState_DropFall;
    work->dropState(work);
}

void Boss2Drop_DropState_DropFall(Boss2Drop *work)
{
    Boss2Stage *stage = TaskGetWork(bossStageTaskSingleton, Boss2Stage);

    fx32 targetY = -stage->groundHeight;
    targetY -= FLOAT_TO_FX32(120.0);

    if (targetY <= work->gameWork.objWork.position.y)
    {
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = targetY;

        if (work->pendulumFallFX != NULL)
        {
            QueueDestroyStageTask(&work->pendulumFallFX->objWork);
            work->pendulumFallFX = NULL;
        }

        work->dropState = Boss2Drop_DropState_DropLand;
    }

    if (work->pendulumFallFX != NULL)
    {
        work->pendulumFallFX->objWork.position = work->gameWork.objWork.position;

        work->pendulumFallFX->objWork.position.y -= FLOAT_TO_FX32(50.0);
    }
}

void Boss2Drop_DropState_DropLand(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura2, NULL, FALSE);
    work->gameWork.objWork.userTimer = SECONDS_TO_FRAMES(2.0);

    if (work->playedSteamSfx == FALSE)
    {
        BossFX__CreatePendulumSmoke(BOSSFX3D_FLAG_NONE, work->aniDrop.work.translation.x, work->stage->groundHeight, work->aniDrop.work.translation.z);

        Boss2Wave *wave = SpawnStageObject(MAPOBJECT_283, 0, -FLOAT_TO_FX32(5.0) - work->stage->groundHeight, Boss2Wave);
        UNUSED(wave);

        ShakeScreenEx(0x5000, 0x3000, 170);
        work->playedSteamSfx = TRUE;
    }

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_STEAM);

    work->dropState = Boss2Drop_DropState_BrightenLights;
}

void Boss2Drop_DropState_BrightenLights(Boss2Drop *work)
{
    if (work->stage->lightConfig.brightness != RENDERCORE_BRIGHTNESS_DEFAULT && (work->gameWork.objWork.userTimer & 1) == 0)
        work->stage->lightConfig.brightness++;

    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
        work->dropState = Boss2Drop_DropState_StartWobbleAnim;
}

void Boss2Drop_DropState_StartWobbleAnim(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura3, NULL, FALSE);

    work->dropState = Boss2Drop_DropState_WobbleAnim;
}

void Boss2Drop_DropState_WobbleAnim(Boss2Drop *work)
{
    if ((work->aniDrop.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->dropState = Boss2Drop_DropState_WaitForRise;
}

void Boss2Drop_DropState_WaitForRise(Boss2Drop *work)
{
    switch (work->stage->boss->actionState)
    {
        case BOSS2_ACTION_IDLE:
        case BOSS2_ACTION_HIT:
            BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura4, NULL, TRUE);
            work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(10.0);
            work->dropState                   = Boss2Drop_DropState_Rising;
            break;
    }
}

void Boss2Drop_DropState_Rising(Boss2Drop *work)
{
    Boss2 *boss = work->stage->boss;

    switch (boss->actionState)
    {
        default:
            BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura1, NULL, TRUE);

            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

            work->dropState = Boss2Drop_DropState_DropFall;
            break;

        case BOSS2_ACTION_IDLE:
        case BOSS2_ACTION_HIT:
            if (work->gameWork.objWork.position.y <= boss->mtxBody[2].translation.y)
            {
                work->gameWork.objWork.position.y = boss->gameWork.objWork.position.y;
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

                work->dropState = Boss2Drop_DropState_StartReattach;
            }
            break;
    }
}

void Boss2Drop_DropState_StartReattach(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_drop_gura5, NULL, FALSE);

    work->isAttached = TRUE;
    work->dropState  = Boss2Drop_DropState_Reattach;
}

void Boss2Drop_DropState_Reattach(Boss2Drop *work)
{
    if ((work->aniDrop.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        Boss2Drop_Action_Attached(work);
}

void Boss2Arm_State_Active(Boss2Arm *work)
{
    if (work->isAttached)
    {
        Boss2 *boss = work->stage->boss;

        if (work->isRotating)
        {
            work->angleVelocity = MTM_MATH_CLIP_3(work->angleVelocity, -work->maxAngleVelocity, work->maxAngleVelocity);

            if (work->angleVelocity > 0)
            {
                if (work->angleVelocity < work->targetAngleVelocity)
                {
                    work->angleVelocity += MultiplyFX(FLOAT_DEG_TO_IDX(0.67017), (work->targetAngleVelocity - work->angleVelocity));
                }
                else if (work->angleVelocity > work->targetAngleVelocity)
                {
                    work->angleVelocity -= MultiplyFX(FLOAT_DEG_TO_IDX(0.67017), (work->angleVelocity - work->targetAngleVelocity));
                }
            }
            else if (work->angleVelocity < 0)
            {
                if (work->angleVelocity < -work->targetAngleVelocity)
                {
                    work->angleVelocity += MultiplyFX(FLOAT_DEG_TO_IDX(0.67017), -(work->targetAngleVelocity + work->angleVelocity));
                }
                else if (work->angleVelocity > -work->targetAngleVelocity)
                {
                    work->angleVelocity -= MultiplyFX(FLOAT_DEG_TO_IDX(0.67017), (work->angleVelocity + work->targetAngleVelocity));
                }
            }

            work->angle += work->angleVelocity;
        }

        MTX_RotY33(work->animator.work.rotation.nnMtx, SinFX(work->angle), CosFX(work->angle));

        work->animator.work.translation = boss->mtxBody[work->type].translation;
    }
    else
    {
        VEC_Set(&work->animator.work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);
    }

    work->armState(work);
}

void Boss2Arm_Destructor(Task *task)
{
    Boss2Arm *work = TaskGetWork(task, Boss2Arm);

    AnimatorMDL__Release(&work->animator);

    GameObject__Destructor(task);
}

void Boss2Arm_Draw(void)
{
    Boss2Arm *work = TaskGetWorkCurrent(Boss2Arm);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BOOL canDraw = CheckBossArmCanDraw(work);

        AnimatorMDL__ProcessAnimation(&work->animator);

        if (canDraw)
        {
            AnimatorMDL__Draw(&work->animator);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2ARM_ARM_BALL, &work->mtxArmBall);
        }
    }
}

BOOL CheckBossArmCanDraw(Boss2Arm *work)
{
    BOOL canDraw = FALSE;

    if (work->prevCanDraw)
    {
        switch (work->actionState)
        {
            case BOSS2ARM_ACTION_INACTIVE:
                canDraw = FALSE;
                break;

            case BOSS2ARM_ACTION_APPEAR:
            case BOSS2ARM_ACTION_FETCH_BALL:
            case BOSS2ARM_ACTION_DETATTACH:
                canDraw = TRUE;
                break;

            default:
                if (Camera3D__UseEngineA())
                    canDraw = TRUE;
                break;
        }
    }
    else
    {
        canDraw           = TRUE;
        work->prevCanDraw = canDraw;
    }

    return canDraw;
}

void Boss2Arm_Action_Inactive(Boss2Arm *work)
{
    work->actionState = BOSS2ARM_ACTION_INACTIVE;

    work->armState = Boss2Arm_ArmState_Inactive;
}

void Boss2Arm_Action_Appear(Boss2Arm *work)
{
    work->actionState = BOSS2ARM_ACTION_APPEAR;

    work->armState = Boss2Arm_Action_PrepareForAppear;
}

void Boss2Arm_Action_FetchBall(Boss2Arm *work)
{
    work->actionState = BOSS2ARM_ACTION_FETCH_BALL;

    work->armState = Boss2Arm_ArmState_PrepareAttach;
}

void Boss2Arm_Action_Attach(Boss2Arm *work, u16 angle, s16 angleVelocity)
{
    work->actionState = BOSS2ARM_ACTION_ATTACH;

    work->isRotating    = TRUE;
    work->angle         = angle;
    work->angleVelocity = angleVelocity;

    work->armState = Boss2Arm_Action_InitAttached;
    work->armState(work);
}

void Boss2Arm_Action_Detattach(Boss2Arm *work)
{
    work->actionState = BOSS2ARM_ACTION_DETATTACH;

    work->armState = Boss2Arm_Action_PrepareDetattach;
    work->armState(work);
}

void Boss2Arm_ArmState_Inactive(Boss2Arm *work)
{
    work->isRotating = FALSE;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
}

void Boss2Arm_Action_PrepareForAppear(Boss2Arm *work)
{
    work->isAttached = FALSE;

    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    work->angle         = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END) - FLOAT_DEG_TO_IDX(105.0);
    work->angleVelocity = FLOAT_DEG_TO_IDX(11.25);
    work->radius        = FLOAT_TO_FX32(500.0);

    work->armState = Boss2Arm_ArmState_OrbitBody;
}

void Boss2Arm_ArmState_OrbitBody(Boss2Arm *work)
{
    Boss2 *boss = work->stage->boss;

    BOOL done = FALSE;

    work->radius -= FLOAT_TO_FX32(2.0);
    if (work->radius < FLOAT_TO_FX32(250.0))
    {
        work->radius = FLOAT_TO_FX32(250.0);
        done         = TRUE;
    }

    BossHelpers__Arena__GetXZPos(work->angle, work->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);
    work->gameWork.objWork.position.y = -boss->mtxBody[work->type].translation.y;

    work->angleVelocity -= FLOAT_DEG_TO_IDX(0.088);
    if (work->angleVelocity < FLOAT_DEG_TO_IDX(4.21875))
        work->angleVelocity = FLOAT_DEG_TO_IDX(4.21875);

    work->angle += work->angleVelocity;

    FXMatrix33 mtxRot;
    MTX_RotX33(work->animator.work.rotation.nnMtx, SinFX(FLOAT_DEG_TO_IDX(319.922)), CosFX(FLOAT_DEG_TO_IDX(319.922)));
    MTX_RotY33(mtxRot.nnMtx, SinFX(work->angle), CosFX(work->angle));
    MTX_Concat33(work->animator.work.rotation.nnMtx, mtxRot.nnMtx, work->animator.work.rotation.nnMtx);

    if (done)
        work->armState = Boss2Arm_ArmState_FetchBall;
}

void Boss2Arm_ArmState_FetchBall(Boss2Arm *work)
{
    work->radius += FLOAT_TO_FX32(2.0);
    if (work->radius > FLOAT_TO_FX32(450.0))
        work->radius = FLOAT_TO_FX32(450.0);

    BossHelpers__Arena__GetXZPos(work->angle, work->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    work->gameWork.objWork.velocity.y += FLOAT_TO_FX32(0.1);
    if (work->gameWork.objWork.velocity.y > FLOAT_TO_FX32(8.0))
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(8.0);

    work->angleVelocity += FLOAT_DEG_TO_IDX(0.044);
    if (work->angleVelocity > FLOAT_DEG_TO_IDX(5.625))
        work->angleVelocity = FLOAT_DEG_TO_IDX(5.625);

    work->angle += work->angleVelocity;

    FXMatrix33 mtxRot;
    MTX_RotX33(work->animator.work.rotation.nnMtx, SinFX(FLOAT_DEG_TO_IDX(319.922)), CosFX(FLOAT_DEG_TO_IDX(319.922)));

    u32 angle = (u32)((FLOAT_DEG_TO_IDX(180.0) * -FX_Div(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(5.0)))) >> 16;
    MTX_RotZ33(mtxRot.nnMtx, SinFX(angle), CosFX(angle));
    MTX_Concat33(work->animator.work.rotation.nnMtx, mtxRot.nnMtx, work->animator.work.rotation.nnMtx);

    MTX_RotY33(mtxRot.nnMtx, SinFX(work->angle), CosFX(work->angle));
    MTX_Concat33(work->animator.work.rotation.nnMtx, mtxRot.nnMtx, work->animator.work.rotation.nnMtx);

    if (work->gameWork.objWork.position.y > FLOAT_TO_FX32(800.0))
    {
        work->gameWork.objWork.position.y = FLOAT_TO_FX32(800.0);
        Boss2Arm_Action_FetchBall(work);
    }
}

void Boss2Arm_ArmState_PrepareAttach(Boss2Arm *work)
{
    Boss2Ball *ball = work->stage->balls[work->type];

    work->isAttached = FALSE;

    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    work->stage->balls[work->type]->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    work->gameWork.objWork.position.y = FLOAT_TO_FX32(1000.0);

    work->angle =
        BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END) + FLOAT_DEG_TO_IDX(135.0) + mtMathRandRepeat(FLOAT_DEG_TO_IDX(90.0));
    work->radius = FLOAT_TO_FX32(400.0);

    MTX_RotY33(work->animator.work.rotation.nnMtx, SinFX((s32)(u16)(work->angle - FLOAT_DEG_TO_IDX(90.0))), CosFX((s32)(u16)(work->angle - FLOAT_DEG_TO_IDX(90.0))));

    Boss2Ball_BallState_InitIdle(ball);
    Boss2Ball_Action_DisableSpikes(&ball->spikeWorker);
    ball->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    work->armState = Boss2Arm_ArmState_RiseForAttach;
}

void Boss2Arm_ArmState_RiseForAttach(Boss2Arm *work)
{
    Boss2 *boss = work->stage->boss;

    BOOL isIdle = FALSE;

    BossHelpers__Arena__GetXZPos(work->angle, work->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    fx32 velocity = MultiplyFX(FLOAT_TO_FX32(0.1), (work->gameWork.objWork.position.y + boss->mtxBody[work->type].translation.y));
    if (velocity > FLOAT_TO_FX32(8.0))
        velocity = FLOAT_TO_FX32(8.0);

    if (velocity < FLOAT_TO_FX32(0.009765625))
        isIdle = TRUE;

    work->gameWork.objWork.velocity.y = -velocity;

    if (isIdle)
        work->armState = Boss2Arm_ArmState_Attaching;
}

void Boss2Arm_ArmState_Attaching(Boss2Arm *work)
{
    BOOL done = FALSE;

    work->radius -= FLOAT_TO_FX32(10.0);
    if (work->radius < FLOAT_TO_FX32(0.0))
    {
        work->radius = FLOAT_TO_FX32(0.0);
        done         = TRUE;
    }

    BossHelpers__Arena__GetXZPos(work->angle, work->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    if (done)
    {
        Boss2Ball_Action_EnableSpikes(&work->stage->balls[work->type]->spikeWorker);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PENDULUM_HIT);

        s16 nextDir;
        if (mtMathRandRepeat(2) != 0)
            nextDir = 1;
        else
            nextDir = -1;
        Boss2Arm_Action_Attach(work, work->angle - FLOAT_DEG_TO_IDX(90.0), nextDir);
    }
}

void Boss2Arm_Action_InitAttached(Boss2Arm *work)
{
    work->maxAngleVelocity = 0x400;
    work->isAttached       = TRUE;

    Boss2Ball *ball = work->stage->balls[work->type];
    EnableBallSpikes(&ball->spikeWorker);
    ball->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    work->armState = Boss2Arm_Action_Attached;
}

void Boss2Arm_Action_Attached(Boss2Arm *work)
{
    // Do nothing
}

void Boss2Arm_Action_PrepareDetattach(Boss2Arm *work)
{
    work->radius     = FLOAT_TO_FX32(0.0);
    work->isAttached = FALSE;

    work->gameWork.objWork.position.x = work->animator.work.translation.x;
    work->gameWork.objWork.position.y = -work->animator.work.translation.y;
    work->gameWork.objWork.position.z = work->animator.work.translation.z;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(5.0);
    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);

    work->stage->balls[work->type]->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    work->armState = Boss2Arm_Action_DetattachFall;
}

void Boss2Arm_Action_DetattachFall(Boss2Arm *work)
{
    work->radius += FLOAT_TO_FX32(2.0);

    if (work->radius > BOSS2_STAGE_RADIUS || work->gameWork.objWork.position.y > FLOAT_TO_FX32(1500.0))
    {
        work->radius = BOSS2_STAGE_RADIUS;

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->stage->balls[work->type]->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

        work->gameWork.objWork.position.y = FLOAT_TO_FX32(1500.0);
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    }

    BossHelpers__Arena__GetXZPos(work->angle + FLOAT_DEG_TO_IDX(90.0), work->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);
}

// TODO: uncomment when attempting to match static variable order
/*
FORCE_INCLUDE_ARRAY(const fx32, Boss2__Unused2179CBC, 3,
                    {
                        0x3000, 0x4000, 0x5000
                    })
*/

void Boss2Ball_State_Active(Boss2Ball *work)
{
    ConfigureBallActions(work->stage, work->type, &work->spikeWorker.spikeDuration, &work->spikeWorker.vulnerableDuration);

    work->ballState(work);
    work->spikeWorker.spikeState(work, &work->spikeWorker);
}

void Boss2Ball_Destructor(Task *task)
{
    Boss2Ball *work = TaskGetWork(task, Boss2Ball);

    AnimatorMDL__Release(&work->aniBall);
    AnimatorMDL__Release(&work->aniBallD);
    AnimatorMDL__Release(&work->aniBallM);
    AnimatorMDL__Release(&work->spikeWorker.aniSpike);

    ReleasePaletteAnimator(&work->aniPalette[0]);

    FreeSndHandle(work->sndHandle);

    GameObject__Destructor(task);
}

void Boss2Ball_Draw(void)
{
    Boss2Ball *work = TaskGetWorkCurrent(Boss2Ball);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        PaletteAnimator *aniPalette;
        AnimatorMDL *aniSpike;
        AnimatorMDL *aniBall;

        aniBall = &work->aniBall;
        AnimatorMDL__ProcessAnimation(aniBall);
        AnimatorMDL__Draw(aniBall);

        BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2BALL_BALL_HIT, &work->mtxBallCenter);

        aniSpike                       = &work->spikeWorker.aniSpike;
        aniSpike->work.mtxRotTranslate = work->mtxBallCenter;

        AnimatorMDL__ProcessAnimation(aniSpike);
        AnimatorMDL__Draw(aniSpike);

        Boss2Ball_DrawBall(work);

        aniPalette = &work->aniPalette[0];
        AnimatePalette(aniPalette);
        DrawAnimatedPalette(aniPalette);
    }
}

NONMATCH_FUNC void Boss2Ball_DrawBall(Boss2Ball *work)
{
    // will match when 'offset' / 'Boss2Ball_DrawBall_offset' is decompiled
#ifdef NON_MATCHING
    AnimatorMDL *aniBallD = &work->aniBallD;

    const fx32 offset[BOSS2_BALL_COUNT] = {
        [BOSS2_BALL_S] = FLOAT_TO_FX32(26.4),
        [BOSS2_BALL_M] = FLOAT_TO_FX32(46.1973),
        [BOSS2_BALL_L] = FLOAT_TO_FX32(65.9961),
    };

    aniBallD->work.translation = work->mtxBallCenter.translation;

    fx32 position;
    BossHelpers__Arena__GetPosition(&position, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, aniBallD->work.translation.x, aniBallD->work.translation.z);
    BossStage_GetCirclePos(position, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, &aniBallD->work.translation.x, &aniBallD->work.translation.z);

    aniBallD->work.translation.y -= offset[work->type];

    AnimatorMDL__Draw(aniBallD);
    AnimatorMDL__Draw(&work->aniBallM);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r0
	add r0, r5, #0x2fc
	ldr r1, =Boss2Ball_DrawBall_offset
	add r4, r0, #0x400
	add ip, sp, #0xc
	ldmia r1, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	add r3, r5, #0xfc
	add r0, r3, #0x400
	add r3, r4, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	ldr r2, =BOSS2_STAGE_END
	str r1, [sp]
	ldr ip, [r4, #0x50]
	ldr r3, =BOSS2_STAGE_RADIUS
	add r0, sp, #8
	mov r1, #BOSS2_STAGE_START
	str ip, [sp, #4]
	bl BossHelpers__Arena__GetPosition
	add r0, r4, #0x48
	str r0, [sp]
	add r0, r4, #0x50
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	ldr r2, =BOSS2_STAGE_END
	ldr r3, =BOSS2_STAGE_RADIUS
	mov r1, #BOSS2_STAGE_START
	bl BossStage_GetCirclePos
	ldr r2, [r5, #0x37c]
	add r1, sp, #0xc
	ldr r3, [r4, #0x4c]
	ldr r1, [r1, r2, lsl #2]
	mov r0, r4
	sub r1, r3, r1
	str r1, [r4, #0x4c]
	bl AnimatorMDL__Draw
	add r0, r5, #0x840
	bl AnimatorMDL__Draw
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Boss2Ball_Collide(void)
{
    Boss2Ball *work = TaskGetWorkCurrent(Boss2Ball);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    if (work->invincibleTimer > 0)
    {
        work->invincibleTimer--;
    }
    else
    {
        for (s32 i = 0; i < 2; i++)
        {
            OBS_RECT_WORK *colliderSrc = &work->gameWork.colliders[i];
            OBS_RECT_WORK *colliderDst = &work->worldCollider[i];

            colliderSrc->flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            colliderDst->flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

            if ((colliderSrc->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            {
                BossHelpers__Collision__HandleArenaCollider(colliderSrc, colliderDst, &work->mtxBallCenter.translation, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
            }
        }
    }
}

NONMATCH_FUNC void Boss2Ball_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // https://decomp.me/scratch/MDWLZ -> 80.82%
#ifdef NON_MATCHING
    Boss2Ball *ball = (Boss2Ball *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        fx32 position;
        BossHelpers__Arena__GetPosition(&position, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, ball->mtxBallCenter.translation.x, ball->mtxBallCenter.translation.z);

        fx32 y = -ball->mtxBallCenter.translation.y;

        s32 dir;
        if (ball->hitImpactForce > FLOAT_TO_FX32(4.0))
        {
            dir = ball->direction;
        }
        else
        {
            if (MATH_ABS(player->objWork.velocity.x) > FLOAT_TO_FX32(0.03125))
                dir = player->objWork.velocity.x <= FLOAT_TO_FX32(0.0) ? BOSS2BALL_DIR_FORWARD : BOSS2BALL_DIR_BACKWARD;
            else
                dir = position < player->objWork.position.x ? BOSS2BALL_DIR_FORWARD : BOSS2BALL_DIR_BACKWARD;
        }

        fx32 velX = player->objWork.velocity.x;
        if (dir != BOSS2BALL_DIR_BACKWARD)
        {
            velX = MATH_MIN(velX, 0);
        }
        else
        {
            velX = MATH_MAX(velX, 0);
        }

        fx32 velY = player->objWork.velocity.y;
        velY      = MATH_MIN(velY, 0);

        velY = MATH_ABS(velY);
        velX = MATH_ABS(velX);

        fx32 playerForce = MultiplyFX(0xB50, velX) + MultiplyFX(0xB50, velY);
        if (playerForce < 0xB33)
            playerForce = 0xB33;

        fx16 weight = GetBallWeight(ball->stage, ball->type);
        Boss2Ball_Action_Hit(ball, dir, MultiplyFX(playerForce, weight));

        if (y < player->objWork.position.y)
        {
            player->objWork.flow.y     = (y + FX32_FROM_WHOLE(rect2->rect.bottom)) - (player->objWork.position.y + FX32_FROM_WHOLE(rect1->rect.top));
            player->objWork.velocity.y = FLOAT_TO_FX32(1.0);
        }
        else
        {
            player->objWork.flow.y     = (y + FX32_FROM_WHOLE(rect2->rect.top)) - (player->objWork.position.y + FX32_FROM_WHOLE(rect1->rect.bottom));
            player->objWork.velocity.y = -FLOAT_TO_FX32(4.0);
        }

        if (dir == 0)
            player->objWork.velocity.x = -FLOAT_TO_FX32(8.0);
        else
            player->objWork.velocity.x = FLOAT_TO_FX32(8.0);

        fx32 x, z;
        BossStage_GetCirclePos(player->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, &x, &z);

        BossFX__CreateHitB(BOSSFX3D_FLAG_NONE, x, -player->objWork.position.y, z);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PENDULUM_HIT);

        ball->invincibleTimer = 4;

        for (s32 i = 0; i < 2; i++)
        {
            ball->gameWork.colliders[i].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            ball->worldCollider[i].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r8, r0
	ldr r5, [r8, #0x1c]
	mov r7, r1
	ldrh r0, [r5, #0]
	ldr r4, [r7, #0x1c]
	cmp r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, [r4, #0x4fc]
	ldr r2, =BOSS2_STAGE_END
	str r1, [sp]
	ldr r1, [r4, #0x504]
	ldr r3, =BOSS2_STAGE_RADIUS
	str r1, [sp, #4]
	add r0, sp, #8
	mov r1, #BOSS2_STAGE_START
	bl BossHelpers__Arena__GetPosition
	ldr r0, [r4, #0x500]
	rsb r0, r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x590]
	cmp r0, #0x4000
	ldrgt r6, [r4, #0x58c]
	bgt _0215F6C8
	ldr r0, [r5, #0x98]
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r1, #0x80
	ble _0215F6B4
	cmp r0, #0
	movle r6, #1
	movgt r6, #0
	b _0215F6C8
_0215F6B4:
	ldr r1, [sp, #8]
	ldr r0, [r5, #0x44]
	cmp r1, r0
	movlt r6, #1
	movge r6, #0
_0215F6C8:
	cmp r6, #0
	ldr r10, [r5, #0x98]
	beq _0215F6E0
	cmp r10, #0
	movgt r10, #0
	b _0215F6E8
_0215F6E0:
	cmp r10, #0
	movlt r10, #0
_0215F6E8:
	ldr r0, [r5, #0x9c]
	mov r1, #0xb50
	cmp r0, #0
	movgt r0, #0
	cmp r10, #0
	rsblt r10, r10, #0
	cmp r0, #0
	rsblt r0, r0, #0
	umull r9, lr, r10, r1
	mov r2, #0
	mla lr, r10, r2, lr
	umull ip, r3, r0, r1
	mla r3, r0, r2, r3
	mov r10, r10, asr #0x1f
	mov r0, r0, asr #0x1f
	adds r9, r9, #0x800
	mla lr, r10, r1, lr
	adc r10, lr, #0
	adds r2, ip, #0x800
	mla r3, r0, r1, r3
	mov r9, r9, lsr #0xc
	adc r0, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	orr r9, r9, r10, lsl #20
	sub r0, r1, #0x1d
	add r9, r9, r2
	cmp r9, r0
	movlt r9, r0
	ldr r0, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	bl GetBallWeight
	smull r1, r0, r9, r0
	adds r1, r1, #0x800
	adc r3, r0, #0
	mov r2, r1, lsr #0xc
	mov r0, r4
	mov r1, r6
	orr r2, r2, r3, lsl #20
	bl Boss2Ball_Action_Hit
	ldr r0, [r5, #0x48]
	ldr r9, [sp, #0xc]
	cmp r9, r0
	bge _0215F7B8
	ldrsh r3, [r7, #8]
	ldrsh r2, [r8, #2]
	mov r1, #0x1000
	add r3, r9, r3, lsl #12
	add r0, r0, r2, lsl #12
	sub r0, r3, r0
	str r0, [r5, #0xb4]
	b _0215F7D8
_0215F7B8:
	ldrsh r3, [r7, #2]
	ldrsh r2, [r8, #8]
	mov r1, #0x4000
	add r3, r9, r3, lsl #12
	add r0, r0, r2, lsl #12
	sub r0, r3, r0
	str r0, [r5, #0xb4]
	rsb r1, r1, #0
_0215F7D8:
	mov r0, #0x8000
	str r1, [r5, #0x9c]
	cmp r6, #0
	rsbeq r0, r0, #0
	str r0, [r5, #0x98]
	add r1, sp, #0x10
	str r1, [sp]
	add r0, sp, #0x18
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	ldr r2, =BOSS2_STAGE_END
	ldr r3, =BOSS2_STAGE_RADIUS
	mov r1, #BOSS2_STAGE_START
	bl BossStage_GetCirclePos
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x10]
	rsb r2, r0, #0
	ldr r3, [sp, #0x18]
	mov r0, #0
	str r2, [sp, #0x14]
	bl BossFX__CreateHitB
	mov r5, #0x9c
	sub r1, r5, #0x9d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	add r0, r4, #0x500
	mov r1, #4
	strh r1, [r0, #0x88]
	mov r2, #0
_0215F858:
	add r1, r4, r2, lsl #6
	ldr r0, [r1, #0x230]
	add r2, r2, #1
	orr r0, r0, #0x800
	str r0, [r1, #0x230]
	ldr r0, [r1, #0x520]
	cmp r2, #2
	orr r0, r0, #0x800
	str r0, [r1, #0x520]
	blt _0215F858
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void UpdateBallTransform(Boss2Ball *work)
{
    Boss2Arm *arm = work->stage->arms[work->type];

    AnimatorMDL *aniBall    = &work->aniBall;
    FXMatrix33 *mtxRotation = &work->aniBall.work.rotation;

    aniBall->work.rotation = arm->mtxArmBall.mtx33;

    VEC_Set(&mtxRotation->row[1], FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));
    VEC_CrossProduct(&mtxRotation->row[0], &mtxRotation->row[1], &mtxRotation->row[2]);
    VEC_Normalize(&mtxRotation->row[2], &mtxRotation->row[2]);
    VEC_CrossProduct(&mtxRotation->row[1], &mtxRotation->row[2], &mtxRotation->row[0]);

    work->aniBall.work.translation = arm->mtxArmBall.translation;
}

void Boss2Ball_Action_Inactive(Boss2Ball *work)
{
    work->actionState = BOSS2BALL_ACTION_INACTIVE;

    work->ballState = Boss2Ball_BallState_Inactive;
    work->ballState(work);
}

void Boss2Ball_Action_Idle(Boss2Ball *work)
{
    work->actionState = BOSS2BALL_ACTION_IDLE;

    work->ballState = Boss2Ball_BallState_InitIdle;
    work->ballState(work);
}

void Boss2Ball_Action_Hit(Boss2Ball *work, Boss2BallDirection direction, fx32 force)
{
    Boss2Arm *arm = work->stage->arms[work->type];

    work->actionState = BOSS2BALL_ACTION_HIT;
    work->direction   = direction;

    if (arm->isRotating)
    {
        fx32 speed = 0;

        if (direction != BOSS2BALL_DIR_BACKWARD && arm->angleVelocity > 0)
        {
            if (arm->angleVelocity > arm->targetAngleVelocity)
                speed = MultiplyFX(FLOAT_TO_FX32(100.0), (arm->angleVelocity - arm->targetAngleVelocity));
        }
        else if (direction == BOSS2BALL_DIR_BACKWARD && arm->angleVelocity < 0)
        {
            if (arm->angleVelocity < -arm->targetAngleVelocity)
                speed = MultiplyFX(FLOAT_TO_FX32(100.0), -(arm->targetAngleVelocity + arm->angleVelocity));
        }

        work->hitImpactForce = force + MultiplyFX(speed, FLOAT_TO_FX32(0.8));
    }
    else
    {
        fx32 speed = work->hitImpactForce;

        work->hitImpactForce = MultiplyFX(speed, FLOAT_TO_FX32(0.8));
        work->hitImpactForce += force;
    }

    work->ballState = Boss2Ball_BallState_InitHit;
    work->ballState(work);
}

void Boss2Ball_Action_HitRecoil(Boss2Ball *work)
{
    work->actionState = BOSS2BALL_ACTION_HIT_RECOIL;

    work->hitImpactForce = FLOAT_TO_FX32(0.0);
    work->hitVelocity    = FLOAT_TO_FX32(0.0);

    work->ballState = Boss2Ball_BallState_InitHitRecoil;
    work->ballState(work);
}

void Boss2Ball_BallState_Inactive(Boss2Ball *work)
{
    work->gameWork.objWork.position.y = -FLOAT_TO_FX32(1000.0);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    DisableBallSpikes(&work->spikeWorker);
}

void Boss2Ball_BallState_InitIdle(Boss2Ball *work)
{
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    BossHelpers__SetAnimation(&work->aniBall, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_balla_fw0 + work->type, NULL, FALSE);

    work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    EnableBallSpikes(&work->spikeWorker);

    work->ballState = Boss2Ball_BallState_Idle;
}

void Boss2Ball_BallState_Idle(Boss2Ball *work)
{
    UpdateBallTransform(work);
}

void Boss2Ball_BallState_InitHit(Boss2Ball *work)
{
    Boss2Arm *arm = work->stage->arms[work->type];

    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    arm->isRotating = FALSE;

    Boss2Ball_Action_EnableSpikes(&work->spikeWorker);
    DisableBallSpikes(&work->spikeWorker);

    work->hitVelocity = work->hitImpactForce;

    s32 anim;
    if (work->direction != BOSS2BALL_DIR_BACKWARD)
        anim = ANI_JNT_bs2_balla_pendf0;
    else
        anim = ANI_JNT_bs2_balla_pendb0;
    BossHelpers__SetAnimation(&work->aniBall, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, anim + work->type, NULL, FALSE);
    work->aniBall.speedMultiplier = FLOAT_TO_FX32(0.0);

    work->ballState = Boss2Ball_BallState_Hit;
}

void Boss2Ball_BallState_Hit(Boss2Ball *work)
{
    NNSG3dAnmObj *animObj = work->aniBall.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    if (work->hitVelocity < -FLOAT_TO_FX32(6.0))
        work->hitVelocity = -FLOAT_TO_FX32(6.0);

    animObj->frame += work->hitVelocity;
    work->hitVelocity -= FLOAT_TO_FX32(0.15);

    fx32 frame = animObj->frame;
    if (frame <= FLOAT_TO_FX32(0.0))
    {
        Boss2Arm *arm = work->stage->arms[work->type];

        animObj->frame = FLOAT_TO_FX32(0.0);

        arm->isRotating    = TRUE;
        arm->angleVelocity = MATH_ABS(arm->angleVelocity);
        arm->angleVelocity += (s16)MultiplyFX(work->hitImpactForce, FLOAT_TO_FX32(0.01));
        if (work->direction == BOSS2BALL_DIR_BACKWARD)
            arm->angleVelocity = -arm->angleVelocity;

        work->hitImpactForce          = FLOAT_TO_FX32(0.0);
        work->aniBall.speedMultiplier = FLOAT_TO_FX32(1.0);
        work->hitImpactForce          = MATH_ABS(work->hitVelocity);

        Boss2Ball_Action_Idle(work);
    }
    else if (NNS_G3dAnmObjGetNumFrame(animObj) <= (frame - 1))
    {
        Boss2Stage *stage = work->stage;

        u32 prevPhase = GetBossPhase(stage);
        work->stage->health -= GetBallImpactDamage(stage, work->type);
        u32 curPhase = GetBossPhase(stage);

        s32 newArmCount = Boss2__activeArmCountTable[curPhase];
        if (Boss2__activeArmCountTable[prevPhase] < newArmCount)
        {
            work->stage->boss->activeArmCount = newArmCount;
            Boss2Arm_Action_Appear(work->stage->arms[newArmCount]);
            ConfigureBossActions(stage);
        }

        if (prevPhase != curPhase && curPhase >= BOSS2_PHASE_4)
            ChangeBossBGMVariant(1);

        if (work->stage->health > HUD_BOSS_HEALTH_NONE)
        {
            work->aniBall.speedMultiplier = FLOAT_TO_FX32(1.0);
            Boss2_Action_Hit(work->stage->boss);
            Boss2Ball_Action_HitRecoil(work);
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_DAMAGE);
        }
        else
        {
            if (work->stage->boss->actionState != BOSS2_ACTION_DEACTIVATE)
            {
                s32 phase = GetBossPhase(stage);

                u16 a;
                u16 count = Boss2__activeArmCountTable[phase] + 1;
                for (a = 0; a < count; a++)
                {
                    Boss2Arm_Action_Detattach(work->stage->arms[a]);
                }

                Boss2_Action_Deactivated(work->stage->boss);
                stage->health = HUD_BOSS_HEALTH_MIN;
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TODOME_HIT);
            }

            Boss2Ball_Action_HitRecoil(work);
        }

        UpdateBossHealthHUD(stage->health);

        BossFX3D *hitFX = BossFX__CreateHitA(BOSSFX3D_FLAG_NONE, work->mtxBallCenter.translation.x, work->mtxBallCenter.translation.y, work->mtxBallCenter.translation.z);

        fx32 scale             = GetBallHitFXScale(stage, work->type);
        hitFX->objWork.scale.x = scale;
        hitFX->objWork.scale.y = scale;
        hitFX->objWork.scale.z = scale;
    }
    else
    {
        UpdateBallTransform(work);
    }
}

void Boss2Ball_BallState_InitHitRecoil(Boss2Ball *work)
{
    Boss2Arm *arm = work->stage->arms[work->type];

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    Boss2Ball_Action_EnableSpikes(&work->spikeWorker);
    DisableBallSpikes(&work->spikeWorker);
    arm->isRotating = TRUE;

    arm->angleVelocity = mtMathRandRepeat(2) == 0 ? -0x800 : 0x800;

    work->gameWork.objWork.userTimer = mtMathRandRepeat(16) + 30;

    s32 anim;
    if (work->direction != BOSS2BALL_DIR_BACKWARD)
        anim = ANI_JNT_bs2_balla_pendf1;
    else
        anim = ANI_JNT_bs2_balla_pendb1;
    BossHelpers__SetAnimation(&work->aniBall, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, anim + work->type, NULL, FALSE);

    work->ballState = Boss2Ball_BallState_HitRecoil;
}

void Boss2Ball_BallState_HitRecoil(Boss2Ball *work)
{
    Boss2Arm *arm = work->stage->arms[work->type];

    UpdateBallTransform(work);

    if (work->gameWork.objWork.userTimer > 0)
    {
        work->gameWork.objWork.userTimer--;

        arm->maxAngleVelocity = 0x800;

        s16 angleVelocity = 0x800;
        if (arm->angleVelocity <= 0)
            angleVelocity = -0x800;

        arm->angleVelocity = angleVelocity;
    }
    else
    {
        arm->maxAngleVelocity = 0x400;
    }

    if ((work->aniBall.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0 && work->gameWork.objWork.userTimer == 0)
    {
        Boss2Ball_Action_Idle(work);
    }
}

void EnableBallSpikes(Boss2BallSpikeWorker *worker)
{
    worker->disableSpikes = FALSE;
}

void DisableBallSpikes(Boss2BallSpikeWorker *worker)
{
    worker->disableSpikes = TRUE;
}

void Boss2Ball_Action_EnableSpikes(Boss2BallSpikeWorker *worker)
{
    worker->spikeState = Boss2Ball_SpikeState_Retracted;
}

void Boss2Ball_Action_DisableSpikes(Boss2BallSpikeWorker *worker)
{
    worker->spikeState = Boss2Ball_SpikeState_StartInactive;
}

void Boss2Ball_SpikeState_StartInactive(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    worker->actionState = BOSS2BALLSPIKES_ACTION_INACTIVE;

    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_spka_1 + work->type, NULL, TRUE);
    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_VIS_ANIM, work->assets.visAnims, ANI_VIZ_bs2_spka_1 + work->type, NULL, TRUE);

    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    if (work->aniPalette[0].animID != BOSS2BALL_PALANI_SPIKED)
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2BALL_PALANI_INACTIVE, FALSE);

    worker->spikeState = Boss2Ball_SpikeState_Inactive;
}

void Boss2Ball_SpikeState_Inactive(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    // Do nothing
}

void Boss2Ball_SpikeState_StartActive(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    worker->actionState = BOSS2BALLSPIKES_ACTION_EXTENDED;

    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_spka_0 + work->type, NULL, TRUE);
    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_VIS_ANIM, work->assets.visAnims, ANI_VIZ_bs2_spka_0 + work->type, NULL, TRUE);

    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_ENABLED;

    if (work->aniPalette[0].animID != BOSS2BALL_PALANI_SPIKED)
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2BALL_PALANI_SPIKED, TRUE);

    PlayHandleStageSfx(work->sndHandle, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TOGE_APPEAR);
    ProcessSpatialVoiceClip(work->sndHandle, &work->mtxBallCenter.translation);

    worker->timer = 0;

    worker->spikeState = Boss2Ball_SpikeState_SpikesActive;
    worker->spikeState(work, worker);
}

void Boss2Ball_SpikeState_SpikesActive(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    if (worker->disableSpikes == FALSE && worker->spikeDuration != 0)
    {
        worker->timer++;
        if (worker->timer > worker->spikeDuration)
            worker->spikeState = Boss2Ball_SpikeState_Retracting;
    }
}

void Boss2Ball_SpikeState_Retracting(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    worker->actionState = BOSS2BALLSPIKES_ACTION_RETRACTING;

    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_spka_3 + work->type, NULL, FALSE);
    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_VIS_ANIM, work->assets.visAnims, ANI_VIZ_bs2_spka_3 + work->type, NULL, FALSE);

    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;
    work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    if (work->aniPalette[0].animID != BOSS2BALL_PALANI_VULNERABLE)
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2BALL_PALANI_VULNERABLE, TRUE);

    // BUG? This shouldn't activate this state, shouldn't it let the "retracting" animation play out instead of snapping to "retracted" animation?
    worker->spikeState = Boss2Ball_SpikeState_Retracted;
}

void Boss2Ball_SpikeState_Retracted(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    worker->actionState = BOSS2BALLSPIKES_ACTION_RETRACTED;

    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_spka_1 + work->type, NULL, TRUE);
    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_VIS_ANIM, work->assets.visAnims, ANI_VIZ_bs2_spka_1 + work->type, NULL, TRUE);

    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;
    work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    if (work->aniPalette[0].animID != BOSS2BALL_PALANI_VULNERABLE)
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2BALL_PALANI_VULNERABLE, TRUE);

    worker->timer = 0;

    worker->spikeState = Boss2Ball_SpikeState_Vulnerable;
    worker->spikeState(work, worker);
}

void Boss2Ball_SpikeState_Vulnerable(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    if (worker->disableSpikes == FALSE && worker->vulnerableDuration != 0)
    {
        worker->timer++;
        if (worker->timer > worker->vulnerableDuration)
            worker->spikeState = Boss2Ball_SpikeState_StartExtendSpikes;
    }
}

void Boss2Ball_SpikeState_StartExtendSpikes(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    worker->actionState = BOSS2BALLSPIKES_ACTION_EXTENDING;

    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, ANI_JNT_bs2_spka_2 + work->type, NULL, FALSE);
    BossHelpers__SetAnimation(&worker->aniSpike, B3D_ANIM_VIS_ANIM, work->assets.visAnims, ANI_VIZ_bs2_spka_2 + work->type, NULL, FALSE);

    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;
    work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    if (work->aniPalette[0].animID != BOSS2BALL_PALANI_VULNERABLE)
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), BOSS2BALL_PALANI_VULNERABLE, TRUE);

    worker->spikeState = Boss2Ball_SpikeState_ExtendSpikes;
}

void Boss2Ball_SpikeState_ExtendSpikes(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    if ((worker->aniSpike.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        worker->spikeState = Boss2Ball_SpikeState_StartActive;
}

Boss2Bomb *SpawnBombEnemy(Boss2Stage *work, fx32 moveSpeed, BOOL flipped)
{
    Boss2Bomb *bomb = SpawnStageObject(MAPOBJECT_282, FLOAT_TO_FX32(0.0), -work->boss->mtxBody[2].translation.y, Boss2Bomb);

    bomb->gameWork.objWork.parentObj = &work->gameWork.objWork;
    bomb->stage                      = work;
    bomb->moveSpeed                  = MATH_ABS(moveSpeed);

    if (flipped)
    {
        bomb->moveSpeed = -bomb->moveSpeed;
        bomb->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    work->bomb = bomb;

    return bomb;
}

void Boss2Bomb_State_Active(Boss2Bomb *work)
{
    work->bombState(work);
}

void Boss2Bomb_Destructor(Task *task)
{
    Boss2Bomb *work = TaskGetWork(task, Boss2Bomb);

    AnimatorMDL__Release(&work->aniBomb);

    GameObject__Destructor(task);
}

void Boss2Bomb_Draw(void)
{
    Boss2Bomb *work = TaskGetWorkCurrent(Boss2Bomb);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        if (work->disableBossStageWrap == FALSE)
        {
            BossHelpers__Arena__GetObjectDrawMtx(&work->gameWork.objWork, &work->aniBomb, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
        }
        else
        {
            VEC_Set(&work->aniBomb.work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);
        }

        AnimatorMDL__ProcessAnimation(&work->aniBomb);
        AnimatorMDL__Draw(&work->aniBomb);
    }
}

void Boss2Bomb_Collide(void)
{
    Boss2Bomb *work = TaskGetWorkCurrent(Boss2Bomb);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    if ((work->gameWork.colliders[0].flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
        return;

    BossHelpers__Collision__InitArenaCollider(&work->gameWork.colliders[0], &work->worldCollider, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y,
                                              BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
}

void Boss2Bomb_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss2Bomb *bomb = (Boss2Bomb *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    bomb->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
    bomb->worldCollider.flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
    Boss2Bomb_Action_Destroy(bomb);
    Player__Action_DestroyAttackRecoil(player);
}

void Boss2Bomb_Action_Spawn(Boss2Bomb *work)
{
    work->actionState = BOSS2BOMB_ACTION_FALL;

    work->bombState = Boss2Bomb_BombState_StartFalling;
    work->bombState(work);
}

void Boss2Bomb_Action_Destroy(Boss2Bomb *work)
{
    work->actionState = BOSS2BOMB_ACTION_DESTROY;

    work->bombState = Boss2Bomb_BombState_Destroy;
    work->bombState(work);
}

void Boss2Bomb_BombState_StartFalling(Boss2Bomb *work)
{
    work->disableBossStageWrap = TRUE;

    work->bombState = Boss2Bomb_BombState_Falling;
}

void Boss2Bomb_BombState_Falling(Boss2Bomb *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        work->bombState = Boss2Bomb_BombState_Landed;
}

void Boss2Bomb_BombState_Landed(Boss2Bomb *work)
{
    work->gameWork.objWork.userTimer = SECONDS_TO_FRAMES(1.0);

    work->bombState = Boss2Bomb_BombState_MoveDelay;
    work->bombState(work);
}

void Boss2Bomb_BombState_MoveDelay(Boss2Bomb *work)
{
    work->gameWork.objWork.userTimer--;

    if (work->gameWork.objWork.userTimer == 0)
        work->bombState = Boss2Bomb_BombState_DecideEntryAngle;
}

NONMATCH_FUNC void Boss2Bomb_BombState_DecideEntryAngle(Boss2Bomb *work)
{
    // https://decomp.me/scratch/XdCQn -> 50.45%
#ifdef NON_MATCHING
    work->radius = FLOAT_TO_FX32(0.0);

    UNUSED(mtMathRand());

    work->angle = FLOAT_DEG_TO_IDX(90.0);
    MTX_RotY33(work->aniBomb.work.rotation.nnMtx, SinFX(FLOAT_DEG_TO_IDX(45.0)), CosFX(FLOAT_DEG_TO_IDX(45.0)));

    work->bombState = Boss2Bomb_BombState_EnterArena;
    work->bombState(work);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r1, #0
	mov r3, #0x4000
	mov r0, r3, asr #4
	mov r5, r0, lsl #1
	str r1, [r4, #0x38c]
	ldr ip, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r6, [ip]
	ldr r1, =0x3C6EF35F
	add r2, r5, #1
	mla r7, r6, r0, r1
	str r7, [ip]
	add ip, r4, #0x300
	ldr lr, =FX_SinCosTable_
	mov r1, r5, lsl #1
	mov r0, r2, lsl #1
	ldrsh r2, [lr, r0]
	ldrsh r1, [lr, r1]
	add r0, r4, #0x3f4
	strh r3, [ip, #0x88]
	bl MTX_RotY33_
	ldr r1, =Boss2Bomb_BombState_EnterArena
	mov r0, r4
	str r1, [r4, #0x374]
	blx r1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Boss2Bomb_BombState_EnterArena(Boss2Bomb *work)
{
    work->radius += FLOAT_TO_FX32(3.0);

    BOOL isDone = FALSE;
    if (work->radius >= BOSS2_STAGE_RADIUS)
    {
        isDone       = TRUE;
        work->radius = BOSS2_STAGE_RADIUS;
    }

    BossHelpers__Arena__GetXZPos(work->angle, work->radius, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    if (isDone)
    {
        work->disableBossStageWrap = FALSE;
        BossHelpers__Arena__GetPosition(&work->gameWork.objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, work->gameWork.objWork.position.x,
                                        work->gameWork.objWork.position.z);

        work->gameWork.objWork.position.z = FLOAT_TO_FX32(0.0);

        work->bombState = Boss2Bomb_BombState_StartMoving;
    }
}

void Boss2Bomb_BombState_StartMoving(Boss2Bomb *work)
{
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;

    work->timer = SECONDS_TO_FRAMES(2.0);

    work->bombState = Boss2Bomb_BombState_Moving;
}

void Boss2Bomb_BombState_Moving(Boss2Bomb *work)
{
    if (work->timer != 0)
    {
        work->timer--;

        if (work->timer == 0)
            work->gameWork.objWork.velocity.x = work->moveSpeed;
        else
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    }
}

void Boss2Bomb_BombState_Destroy(Boss2Bomb *work)
{
    Boss2Stage *stage = (Boss2Stage *)work->gameWork.objWork.parentObj;
    if (stage != NULL)
        stage->bomb = NULL;

    QueueDestroyStageTask(&work->gameWork.objWork);

    BossFX__CreateBomb(BOSSFX2D_FLAG_NONE, work->aniBomb.work.translation.x, work->aniBomb.work.translation.y + FLOAT_TO_FX32(32.0), work->aniBomb.work.translation.z);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_BOMB);

    work->bombState = Boss2Bomb_BombState_Inactive;
}

void Boss2Bomb_BombState_Inactive(Boss2Bomb *work)
{
    // Do nothing
}

void Boss2Wave_State_Active(Boss2Wave *work)
{
    fx32 frame = work->aniWave.currentAnimObj[0]->frame;
    if (frame >= FLOAT_TO_FX32(27.0) && frame < FLOAT_TO_FX32(29.0) && BossHelpers__Player__IsAlive(gPlayer))
    {
        if ((gPlayer->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 && gPlayer->blinkTimer == 0)
            Player__Hurt(gPlayer);
    }

    if ((work->aniWave.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME;
}

void Boss2Wave_Destructor(Task *task)
{
    Boss2Wave *work = TaskGetWork(task, Boss2Wave);

    AnimatorMDL__Release(&work->aniWave);

    GameObject__Destructor(task);
}

void Boss2Wave_Draw(void)
{
    Boss2Wave *work = TaskGetWorkCurrent(Boss2Wave);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        AnimatorMDL__ProcessAnimation(&work->aniWave);
        AnimatorMDL__Draw(&work->aniWave);
    }
}