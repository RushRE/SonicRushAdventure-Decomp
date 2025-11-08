#include <stage/boss/boss1.h>
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
#include <resources/narc/z1boss_act_lz7.h>

// --------------------
// CONSTANTS
// --------------------

#define MTXSTACK_WEAK NNS_G3D_MTXSTACK_SYS
#define MTXSTACK_BODY_NECK NNS_G3D_MTXSTACK_USER

// --------------------
// ENUMS
// --------------------

enum Boss1Anims
{
    ANI_bs1_body_fw0,
    ANI_bs1_body_fw1,
    ANI_bs1_body_walkl0,
    ANI_bs1_body_walkl1,
    ANI_bs1_body_walkl2,
    ANI_bs1_body_walkr0,
    ANI_bs1_body_walkr1,
    ANI_bs1_body_walkr2,
    ANI_bs1_body_bite0,
    ANI_bs1_body_bite1,
    ANI_bs1_body_bite2,
    ANI_bs1_body_bite3,
    ANI_bs1_body_bite4,
    ANI_bs1_body_bitel2,
    ANI_bs1_body_bitel3,
    ANI_bs1_body_bitel4,
    ANI_bs1_body_biter2,
    ANI_bs1_body_biter3,
    ANI_bs1_body_biter4,
    ANI_bs1_body_btwkl0,
    ANI_bs1_body_btwkl1,
    ANI_bs1_body_btwkl2,
    ANI_bs1_body_btwkr0,
    ANI_bs1_body_btwkr1,
    ANI_bs1_body_btwkr2,
    ANI_bs1_body_dmgbt0,
    ANI_bs1_body_dmgbt1,
    ANI_bs1_body_dmgbt2,
    ANI_bs1_body_dmgbtl0,
    ANI_bs1_body_dmgbtl1,
    ANI_bs1_body_dmgbtl2,
    ANI_bs1_body_dmgbtr0,
    ANI_bs1_body_dmgbtr1,
    ANI_bs1_body_dmgbtr2,
    ANI_bs1_body_tk0,
    ANI_bs1_body_tk1,
    ANI_bs1_body_tk2,
    ANI_bs1_body_jmp0,
    ANI_bs1_body_jmp1,
    ANI_bs1_body_jmp2,
    ANI_bs1_body_dmgt0,
    ANI_bs1_body_dmgt1,
    ANI_bs1_body_dmgt2,
    ANI_bs1_body_dmgt3,
    ANI_bs1_body_drop0,
    ANI_bs1_body_drop1,
    ANI_bs1_body_drop2,
    ANI_bs1_body_drop3,
    ANI_bs1_body_head0,
    ANI_bs1_body_head1,
    ANI_bs1_body_head2,
    ANI_bs1_body_head3,
    ANI_bs1_body_head4,
    ANI_bs1_body_hdwkl0,
    ANI_bs1_body_hdwkl1,
    ANI_bs1_body_hdwkl2,
    ANI_bs1_body_hdwkr0,
    ANI_bs1_body_hdwkr1,
    ANI_bs1_body_hdwkr2,
    ANI_bs1_body_dmghd0,
    ANI_bs1_body_dmghd1,
    ANI_bs1_body_dmghd2,
    ANI_bs1_body_down0,
    ANI_bs1_body_down1,
    ANI_bs1_body_down2,
    ANI_bs1_body_downt0,
    ANI_bs1_body_downt1,
    ANI_bs1_body_downt2,
    ANI_bs1_body_exp0,
    ANI_bs1_body_exptk0,

    ANI_bs1_stage_01,
};

enum Boss1ColliderMode_
{
    BOSS1_COLLIDER_NONE,
    BOSS1_COLLIDER_BITE_ATTACK,
    BOSS1_COLLIDER_BITE_IDLE,
    BOSS1_COLLIDER_CHARGE,
    BOSS1_COLLIDER_HEADSLAM_ATTACK,
    BOSS1_COLLIDER_HEADSLAM_IDLE,
    BOSS1_COLLIDER_DEACTIVATED,
    BOSS1_COLLIDER_CHARGE_DEACTIVATED,
};
typedef u32 Boss1ColliderMode;

// --------------------
// STRUCTS
// --------------------

typedef struct Boss1IdleConfig_
{
    u16 duration;
    u16 extraRange;
} Boss1IdleConfig;

// --------------------
// VARIABLES
// --------------------

static Task *Boss1Stage__Singleton;

NOT_DECOMPILED const u16 Boss1__biteDamageDuration[DIFFICULTY_COUNT];
NOT_DECOMPILED const u16 Boss1__chargeDamageDuration[DIFFICULTY_COUNT];
NOT_DECOMPILED const u16 Boss1__baseDamageTable[DIFFICULTY_COUNT];
NOT_DECOMPILED const s16 Boss1__healthPhaseTable[BOSS1_PHASE_COUNT];
NOT_DECOMPILED const fx32 Boss1__damageModifier2[DIFFICULTY_COUNT];
NOT_DECOMPILED const VecFx32 Boss1__neckUpVector;
NOT_DECOMPILED const VecFx32 Boss1__stageUpVector;
NOT_DECOMPILED const s32 Boss1__attackTablePhase1_1[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase1_2[4];
NOT_DECOMPILED const Boss1IdleConfig Boss1__idleConfigTable[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase2_1[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase4_1[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase2_2[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase4_2[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase3_1[4];
NOT_DECOMPILED const s32 Boss1__attackTablePhase3_2[4];

static const fx32 chargeKnockbackPower[BOSS1_HIT_COMBO_MAX + 1] = { FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.9), FLOAT_TO_FX32(0.8),
                                                                    FLOAT_TO_FX32(0.7), FLOAT_TO_FX32(0.6), FLOAT_TO_FX32(0.5) };

static const fx32 chargeRecoilPower[BOSS1_HIT_COMBO_MAX + 1] = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.2),
                                                                 FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.5) };

static const fx32 damageModifierTable[BOSS1_HIT_COMBO_MAX + 1] = { FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.75), FLOAT_TO_FX32(0.5),
                                                                   FLOAT_TO_FX32(0.4), FLOAT_TO_FX32(0.3),  FLOAT_TO_FX32(0.2) };

static const s32 dropUnknownTable[5] = { FLOAT_TO_FX32(16.169921875), FLOAT_TO_FX32(16.169921875), FLOAT_TO_FX32(329.669921875), FLOAT_TO_FX32(1303.169921875),
                                         FLOAT_TO_FX32(0.0) };

static const s32 biteTypes[BOSS1_PHASE_COUNT][4] = {
    [BOSS1_PHASE_1] = { 0, 0, 0, 0 },
    [BOSS1_PHASE_2] = { 0, 0, 1, 2 },
    [BOSS1_PHASE_3] = { 0, 1, 2, 3 },
    [BOSS1_PHASE_4] = { 1, 2, 3, 3 },
};

static const fx32 knockbackPower[BOSS1_PHASE_COUNT][BOSS1_HIT_COMBO_MAX + 1] = {
    [BOSS1_PHASE_1] = { FLOAT_TO_FX32(0.8), FLOAT_TO_FX32(2.4), FLOAT_TO_FX32(2.4), FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(4.0) },
    [BOSS1_PHASE_2] = { FLOAT_TO_FX32(0.8), FLOAT_TO_FX32(2.4), FLOAT_TO_FX32(2.4), FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(4.0) },
    [BOSS1_PHASE_3] = { FLOAT_TO_FX32(1.6), FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(2.8), FLOAT_TO_FX32(2.8), FLOAT_TO_FX32(2.8) },
    [BOSS1_PHASE_4] = { FLOAT_TO_FX32(1.6), FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(2.0), FLOAT_TO_FX32(2.8), FLOAT_TO_FX32(2.8), FLOAT_TO_FX32(2.8) },
};

static const Boss1ChargeConfig chargeConfigTable[DIFFICULTY_COUNT][BOSS1_PHASE_COUNT] =
{	
    [DIFFICULTY_EASY] = {
        [BOSS1_PHASE_1] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.06),
	        .topSpeed   = FLOAT_TO_FX32(2.6),
        },
	
        [BOSS1_PHASE_2] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.07),
	        .topSpeed   = FLOAT_TO_FX32(2.8),
        },
	
        [BOSS1_PHASE_3] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.08),
	        .topSpeed   = FLOAT_TO_FX32(3.0),
        },
	
        [BOSS1_PHASE_4] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.09),
	        .topSpeed   = FLOAT_TO_FX32(3.2),
        },
    },

    [DIFFICULTY_NORMAL] = {
        [BOSS1_PHASE_1] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.08),
	        .topSpeed   = FLOAT_TO_FX32(3.0),
        },
    
        [BOSS1_PHASE_2] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.1),
	        .topSpeed   = FLOAT_TO_FX32(3.5),
        },
    
        [BOSS1_PHASE_3] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.13),
	        .topSpeed   = FLOAT_TO_FX32(4.0),
        },
    
        [BOSS1_PHASE_4] = {
	        .duration   = 360,
	        .accel      = FLOAT_TO_FX32(0.15),
	        .topSpeed   = FLOAT_TO_FX32(4.5),
        },
    },
};

static const Boss1BiteConfig biteConfig[DIFFICULTY_COUNT][BOSS1_PHASE_COUNT] =
{	
    [DIFFICULTY_EASY] = {
        [BOSS1_PHASE_1] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 60,
            .bite3Duration = 300,
            .animSpeed = FLOAT_TO_FX32(0.3)
        },
	
        [BOSS1_PHASE_2] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 50,
            .bite3Duration = 240,
            .animSpeed = FLOAT_TO_FX32(0.4)
        },
	
        [BOSS1_PHASE_3] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 40,
            .bite3Duration = 120,
            .animSpeed = FLOAT_TO_FX32(0.5)
        },
	
        [BOSS1_PHASE_4] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 30,
            .bite3Duration = 90,
            .animSpeed = FLOAT_TO_FX32(0.6)
        },
    },

    [DIFFICULTY_NORMAL] = {
        [BOSS1_PHASE_1] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 60,
            .bite3Duration = 150,
            .animSpeed = FLOAT_TO_FX32(0.4)
        },
    
        [BOSS1_PHASE_2] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 50,
            .bite3Duration = 120,
            .animSpeed = FLOAT_TO_FX32(0.6)
        },
    
        [BOSS1_PHASE_3] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 40,
            .bite3Duration = 90,
            .animSpeed = FLOAT_TO_FX32(0.8)
        },
    
        [BOSS1_PHASE_4] = {
            .duration1 = 90,
            .duration2 = 180,
            .duration3 = 30,
            .bite3Duration = 60,
            .animSpeed = FLOAT_TO_FX32(1.0)
        },
    },
};

static const Boss1HeadSlamConfig headSlamTable[DIFFICULTY_COUNT][BOSS1_PHASE_COUNT] =
{	
    [DIFFICULTY_EASY] = {
        [BOSS1_PHASE_1] = {
	        .duration1      = 120,
	        .duration2      = 300,
	        .duration3      = 60,
	        .idleDuration   = 150,
	        .animSpeed      = FLOAT_TO_FX32(0.5),
        },
	
        [BOSS1_PHASE_2] = {
	        .duration1      = 120,
	        .duration2      = 300,
	        .duration3      = 60,
	        .idleDuration   = 150,
	        .animSpeed      = FLOAT_TO_FX32(0.5),
        },
	
        [BOSS1_PHASE_3] = {
	        .duration1      = 120,
	        .duration2      = 300,
	        .duration3      = 60,
	        .idleDuration   = 150,
	        .animSpeed      = FLOAT_TO_FX32(0.5),
        },
	
        [BOSS1_PHASE_4] = {
	        .duration1      = 90,
	        .duration2      = 270,
	        .duration3      = 45,
	        .idleDuration   = 120,
	        .animSpeed      = FLOAT_TO_FX32(0.7),
        },
    },

    [DIFFICULTY_NORMAL] = {
        [BOSS1_PHASE_1] = {
	        .duration1      = 90,
	        .duration2      = 210,
	        .duration3      = 60,
	        .idleDuration   = 120,
	        .animSpeed      = FLOAT_TO_FX32(0.8),
        },
    
        [BOSS1_PHASE_2] = {
	        .duration1      = 90,
	        .duration2      = 210,
	        .duration3      = 60,
	        .idleDuration   = 120,
	        .animSpeed      = FLOAT_TO_FX32(0.8),
        },
    
        [BOSS1_PHASE_3] = {
	        .duration1      = 90,
	        .duration2      = 210,
	        .duration3      = 60,
	        .idleDuration   = 120,
	        .animSpeed      = FLOAT_TO_FX32(0.8),
        },
    
        [BOSS1_PHASE_4] = {
	        .duration1      = 90,
	        .duration2      = 210,
	        .duration3      = 45,
	        .idleDuration   = 90,
	        .animSpeed      = FLOAT_TO_FX32(1.2),
        },
    },
};

NOT_DECOMPILED s32 *Boss1__attackTablesPhase3[4];
NOT_DECOMPILED s32 *Boss1__attackTablesPhase1[4];
NOT_DECOMPILED s32 **Boss1__attackTablesForPhase[4];
NOT_DECOMPILED s32 *Boss1__attackTablesPhase2[4];
NOT_DECOMPILED s32 *Boss1__attackTablesPhase4[4];
NOT_DECOMPILED const char *Boss1__paletteNameTable[24];
NOT_DECOMPILED const char *aZ1UlegSidePl;
NOT_DECOMPILED const char *Boss1__path_none;
NOT_DECOMPILED const char *aBoss1Nsbca;
NOT_DECOMPILED const char *aBoss1Nsbva;
NOT_DECOMPILED const char *aBodyNeck;
NOT_DECOMPILED const char *aWeak;
NOT_DECOMPILED const char *aExc_2;

// --------------------
// FUNCTION DECLS
// --------------------

static void Boss1Stage__GetBackground(void **background);
static Boss1Phase Boss1Stage__GetBossPhase(Boss1Stage *work);
static u16 Boss1Stage__GetBaseDamageValue(void);
static fx32 Boss1Stage__GetDamageModifier(Boss1Stage *work);
static fx32 Boss1Stage__GetDmgMultiplier2(Boss1Stage *work);
static u16 Boss1Stage__GetIdleDuration(Boss1Stage *work);
static s32 Boss1Stage__GetBiteType(Boss1Stage *work);
static const Boss1BiteConfig *Boss1Stage__GetBiteConfig(Boss1Stage *work);
static u16 Boss1Stage__GetBiteDamageDuration(Boss1Stage *work);
static fx32 Boss1Stage__GetKnockbackPower(Boss1Stage *work);
static const Boss1ChargeConfig *Boss1Stage__GetChargeConfig(Boss1Stage *work);
static fx32 Boss1Stage__GetChargeKnockbackPower(Boss1Stage *work);
static fx32 Boss1Stage__GetChargeRecoilPower(Boss1Stage *work);
static const Boss1HeadSlamConfig *Boss1Stage__GetHeadSlamConfig(Boss1Stage *work);
static u16 Boss1Stage__GetChargeDamageDuration(Boss1Stage *work);
static void Boss1Stage__HandlePlayer(Boss1Stage *work);
static void Boss1Stage__ResetHitCount(Boss1Stage *work);
static u16 Boss1Stage__IncrementHitCount(Boss1Stage *work);
static u32 Boss1Stage__GetHitComboCount(Boss1Stage *work);
static u32 Boss1Stage__GetCappedComboCount(Boss1Stage *work);
static void Boss1Stage__SetupAnimators(Boss1Stage *work);
static void Boss1Stage__HandleDrop(Boss1Stage *work);
static void Boss1Stage__DrawStagePart(Boss1Stage *work, fx32 y, Boss1StagePart type);
static void Boss1Stage__DrawStage(Boss1Stage *work);
static void Boss1Stage__Action_Drop(Boss1Stage *work);
static void Boss1Stage__Func_21556BC(Boss1Stage *work);
static void Boss1Stage__Func_21556E0(Boss1Stage *work);
static void Boss1Stage__Func_21556F8(Boss1Stage *work);
static void Boss1Stage__Func_2155758(Boss1Stage *work);
static void Boss1Stage__HandleCamera(Boss1Stage *work);
static void Boss1Stage__State_Active(Boss1Stage *work);
static void Boss1Stage__Destructor(Task *task);
static void Boss1Stage__Draw(void);
static void Boss1Stage__StageState_Init(Boss1Stage *work);
static void Boss1Stage__StageState_Idle(Boss1Stage *work);
static void Boss1__Func_2155CA8(Boss1Unknown *work);
static void Boss1__Func_2155CF8(Boss1Unknown *work);
static s32 Boss1__Func_2155D14(Boss1Unknown *work);
static void Boss1__Func_2155D64(Boss1Unknown *work, fx32 *x, fx32 *z, u16 *angle);
static void Boss1__Func_2155FB0(s32 type, u32 *anim1, u32 *anim2, u32 *anim3, u32 *anim4, u32 *anim5, u32 *anim6, u32 *anim7);
static void Boss1__Func_2156094(Boss1 *work, u32 anim1, u32 anim2, u32 anim3, u32 anim4, u32 anim5, u32 anim6, u32 anim7);
static BOOL Boss1__Func_21563B4(Boss1 *work);
static BOOL Boss1__Func_2156568(Boss1 *work);
static void Boss1__NeckRenderCallback(NNSG3dRS *context, void *userData);
static fx32 Boss1__GetFrame(Boss1 *work);
static void Boss1__SetAnimation(Boss1 *work, u16 animID, BOOL playOnce);
static BOOL Boss1__CheckAnimFinished(Boss1 *work);
static void Boss1__EnableAnimBlending(Boss1 *work);
static void Boss1__HandleRotation(Boss1 *work);
static void Boss1__ConfigureCollider(Boss1 *work, Boss1ColliderMode mode);
static void Boss1__HandleCameraOrientation(Boss1 *work);
static u16 Boss1__GetPlayerBounceAngle(OBS_RECT_WORK *collider, fx32 bossX, fx32 bossY, Player *player, u16 angleRange, u16 angle);
static s32 Boss1__GetNextAttack(Boss1Stage *stage, Boss1AttackConfig *state);
static void Boss1__ConfigureNeck(Boss1 *work, BOOL enabled);
static void Boss1__Action_Hit(Boss1 *work);
static void Boss1__HandlePalette(Boss1 *work);

// Boss object logic
static void Boss1__State_Active(Boss1 *work);
static void Boss1__Destructor(Task *task);
static void Boss1__Draw(void);
static void Boss1__Collide(void);

// Boss Collision
static void Boss1__OnDefend_Bite(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__HandleCoreBiteBounce(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__ChargeAttack_Recoil(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__OnDefend_Core(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__OnDefend_Core_Charging(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__OnDefend_LastHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__OnDefend_Invulnerable(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Boss1__OnDefend_Harmful(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// Boss Actions
static void Boss1__Action_Init(Boss1 *work);
static void Boss1__Action_Idle(Boss1 *work, u16 duration);
static void Boss1__Action_Bite(Boss1 *work, s32 type, const Boss1BiteConfig *config);
static void Boss1__Action_Charge(Boss1 *work, s32 direction, s32 a3);
static void Boss1__Action_HeadSlam(Boss1 *work, const Boss1HeadSlamConfig *config);
static void Boss1__Action_Damage(Boss1 *work, s32 type, u16 duration);
static void Boss1__Action_ChargeDamage(Boss1 *work, u16 duration);
static void Boss1__Action_Jump(Boss1 *work, s32 a2);
static void Boss1__Action_Drop(Boss1 *work);
static void Boss1__Action_Deactivate(Boss1 *work);
static void Boss1__Action_ChargeDeactivate(Boss1 *work, s32 direction);
static void Boss1__Action_Destroy(Boss1 *work);

// Boss States

// Init
static void Boss1__BossState_StartInitWait(Boss1 *work);
static void Boss1__BossState_InitWait(Boss1 *work);
static void Boss1__BossState_StartInit0(Boss1 *work);
static void Boss1__BossState_Init0(Boss1 *work);
static void Boss1__BossState_StartInit1(Boss1 *work);
static void Boss1__BossState_Init1(Boss1 *work);

// Idle
static void Boss1__BossState_StartIdle(Boss1 *work);
static void Boss1__BossState_IdleChooseAttackDelay(Boss1 *work);
static void Boss1__BossState_IdleUnknown(Boss1 *work);
static void Boss1__BossState_IdleChooseAttack(Boss1 *work);

// Bite Attack
static void Boss1__CreateBiteFX(Boss1 *work, struct Boss1ActionBite *config);
static void Boss1__BossState_InitBite(Boss1 *work);
static void Boss1__BossState_StartBite0(Boss1 *work);
static void Boss1__BossState_Bite0(Boss1 *work);
static void Boss1__BossState_StartBite1(Boss1 *work);
static void Boss1__BossState_Bite1(Boss1 *work);
static void Boss1__BossState_StartBite2(Boss1 *work);
static void Boss1__BossState_Bite2(Boss1 *work);
static void Boss1__BossState_StartBite3(Boss1 *work);
static void Boss1__BossState_Bite3(Boss1 *work);
static void Boss1__BossState_StartBite4(Boss1 *work);
static void Boss1__BossState_Bite4(Boss1 *work);
static void Boss1__BossState_StartBite5(Boss1 *work);
static void Boss1__BossState_Bite5(Boss1 *work);

// Charge Attack
static void Boss1__HandleChargeKnockback(Boss1 *work);
static void Boss1__HandleChargeVelocity(Boss1 *work);
static void Boss1__HandleChargeRunSfx(Boss1 *work);
static void Boss1__BossState_InitCharge(Boss1 *work);
static void Boss1__BossState_StartChargeJump0(Boss1 *work);
static void Boss1__BossState_ChargeJump0(Boss1 *work);
static void Boss1__BossState_StartChargeJump1(Boss1 *work);
static void Boss1__BossState_ChargeJump1(Boss1 *work);
static void Boss1__BossState_StartChargeJump2(Boss1 *work);
static void Boss1__BossState_ChargeJump2(Boss1 *work);
static void Boss1__BossState_StartCharge0(Boss1 *work);
static void Boss1__BossState_Charge0(Boss1 *work);
static void Boss1__BossState_StartCharge1(Boss1 *work);
static void Boss1__BossState_Charge1(Boss1 *work);
static void Boss1__BossState_StartCharge2(Boss1 *work);
static void Boss1__BossState_Charge2(Boss1 *work);

// Head Slam Attack
static void Boss1__BossState_InitHeadSlam(Boss1 *work);
static void Boss1__BossState_StartHeadSlam0(Boss1 *work);
static void Boss1__BossState_HeadSlam0(Boss1 *work);
static void Boss1__BossState_StartHeadSlam1(Boss1 *work);
static void Boss1__BossState_HeadSlam1(Boss1 *work);
static void Boss1__BossState_StartHeadSlamDown(Boss1 *work);
static void Boss1__BossState_HeadSlamDown(Boss1 *work);
static void Boss1__BossState_StartHeadSlamIdle(Boss1 *work);
static void Boss1__BossState_HeadSlamIdle(Boss1 *work);
static void Boss1__BossState_StartHeadReturn(Boss1 *work);
static void Boss1__BossState_HeadReturn(Boss1 *work);

// Damaged
static void Boss1__BossState_InitDamage(Boss1 *work);
static void Boss1__BossState_StartDamage0(Boss1 *work);
static void Boss1__BossState_Damage0(Boss1 *work);
static void Boss1__BossState_StartDamage1(Boss1 *work);
static void Boss1__BossState_Damage1(Boss1 *work);
static void Boss1__BossState_StartDamage2(Boss1 *work);
static void Boss1__BossState_Damage2(Boss1 *work);

// Damaged (while using charge attack)
static void Boss1__BossState_InitChargeDamage(Boss1 *work);
static void Boss1__BossState_StartChargeDamage0(Boss1 *work);
static void Boss1__BossState_ChargeDamage0(Boss1 *work);
static void Boss1__BossState_StartChargeDamage1(Boss1 *work);
static void Boss1__BossState_ChargeDamage1(Boss1 *work);
static void Boss1__BossState_StartChargeDamage2(Boss1 *work);
static void Boss1__BossState_ChargeDamage2(Boss1 *work);

// Jump
static void Boss1__BossState_InitJump(Boss1 *work);
static void Boss1__BossState_StartJump0(Boss1 *work);
static void Boss1__BossState_Jump0(Boss1 *work);
static void Boss1__BossState_StartJump1(Boss1 *work);
static void Boss1__BossState_Jump1(Boss1 *work);
static void Boss1__BossState_StartJump2(Boss1 *work);
static void Boss1__BossState_Jump2(Boss1 *work);

// Dropping
static BossFX2D *Boss1__CreateSmokeFX(fx32 x, fx32 y, fx32 z);
static void Boss1__CreateDropSmokeFX(Boss1 *work);
static BOOL Boss1__HandleDropCamera(Boss1 *work);
static void Boss1__BossState_InitDrop(Boss1 *work);
static void Boss1__BossState_StartDrop(Boss1 *work);
static void Boss1__BossState_Drop(Boss1 *work);
static void Boss1__BossState_StartFallDelay(Boss1 *work);
static void Boss1__BossState_FallDelay(Boss1 *work);
static void Boss1__BossState_StartDropFallStart(Boss1 *work);
static void Boss1__BossState_DropFallStart(Boss1 *work);
static void Boss1__BossState_StartDropFall(Boss1 *work);
static void Boss1__BossState_DropFall(Boss1 *work);
static void Boss1__BossState_StartDropLand(Boss1 *work);
static void Boss1__BossState_DropLand(Boss1 *work);
static void Boss1__BossState_StartDropFinish(Boss1 *work);
static void Boss1__BossState_DropFinish(Boss1 *work);

// Deactivate
static void Boss1__BossState_InitDeactivate(Boss1 *work);
static void Boss1__BossState_StartDeactivateStart(Boss1 *work);
static void Boss1__BossState_DeactivateStart(Boss1 *work);
static void Boss1__BossState_StartDeactivate(Boss1 *work);
static void Boss1__BossState_Deactivate(Boss1 *work);
static void Boss1__BossState_StartDeactivateRevive(Boss1 *work);
static void Boss1__BossState_DeactivateRevive(Boss1 *work);

// Deactivate (while using charge attack)
static void Boss1__BossState_InitChargeDeactivate(Boss1 *work);
static void Boss1__BossState_StartChargeDeactivateStart(Boss1 *work);
static void Boss1__BossState_ChargeDeactivateStart(Boss1 *work);
static void Boss1__BossState_StartChargeDeactivate(Boss1 *work);
static void Boss1__BossState_ChargeDeactivate(Boss1 *work);
static void Boss1__BossState_StartChargeDeactivateRevive(Boss1 *work);
static void Boss1__BossState_ChargeDeactivateRevive(Boss1 *work);

// Destroyed
static void Boss1__BossState_InitDestroyed(Boss1 *work);
static void Boss1__BossState_PrepareCameraForDestroyed(Boss1 *work);
static void Boss1__BossState_StartDestroyedShock(Boss1 *work);
static void Boss1__BossState_DestroyedShock(Boss1 *work);
static void Boss1__BossState_StartExplode(Boss1 *work);
static void Boss1__BossState_Explode(Boss1 *work);
static void Boss1__BossState_ShowResultsScreen(Boss1 *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE fx32 GetStageUnknown(Boss1Stage *stage)
{
    return -stage->field_378;
}

RUSH_INLINE void CreateStompSmokeFX(Camera3D *config)
{
    Boss1Stage *stage = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);
    fx32 y            = -(FLOAT_TO_FX32(20.0) + GetStageUnknown(stage));
    y -= FLOAT_TO_FX32(15.0);
    Boss1__CreateSmokeFX(config->camPos.x, y, config->camPos.z);
}

// --------------------
// FUNCTIONS
// --------------------

Boss1Stage *Boss1Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Boss1Stage__Singleton = CreateStageTask(Boss1Stage__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss1Stage);

    Boss1Stage *work = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss1Stage__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss1Stage__Draw);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION | DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_SCREEN_RELATIVE;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                       | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->gameWork.objWork.scale.x = FLOAT_TO_FX32(3.3);
    work->gameWork.objWork.scale.y = FLOAT_TO_FX32(3.3);
    work->gameWork.objWork.scale.z = FLOAT_TO_FX32(3.3);
    work->health                   = HUD_BOSS_HEALTH_MAX;
    work->field_378                = -y;

    Boss1Stage__GetBackground(&work->background);
    Boss1Stage__SetupAnimators(work);
    BossHelpers__InitLights(&work->lightConfig);
    BossHelpers__Model__InitSystem();

    work->boss        = SpawnStageObject(MAPOBJECT_277, x, y, Boss1);
    work->boss->stage = work;

    InitSpatialAudioConfig();
    work->stageState = Boss1Stage__StageState_Init;

    return work;
}

NONMATCH_FUNC Boss1 *Boss1__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    // https://decomp.me/scratch/oipYc -> 97.32%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(Boss1__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss1);

    Boss1 *work = TaskGetWork(task, Boss1);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss1__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss1__Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss1__Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_SCREEN_RELATIVE;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.gravityStrength = FLOAT_TO_FX32(0.25);
    work->gameWork.objWork.scale.x         = FLOAT_TO_FX32(1.0);
    work->gameWork.objWork.scale.y         = FLOAT_TO_FX32(1.0);
    work->gameWork.objWork.scale.z         = FLOAT_TO_FX32(1.0);

    Boss1Stage *stage                 = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);
    fx32 startY                       = FLOAT_TO_FX32(20.0) + GetStageUnknown(stage);
    work->gameWork.objWork.position.x = 0;
    work->gameWork.objWork.position.y = startY;
    work->gameWork.objWork.position.z = 0;
    work->field_698.unknown1          = 0x141BB2;
    work->sndHandle[0]                = AllocSndHandle();
    work->sndHandle[1]                = AllocSndHandle();
    work->sndHandle[2]                = AllocSndHandle();

    OBS_RECT_WORK *bossCollider = &work->bossColliders[0];
    *bossCollider               = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox3D(&bossCollider->rect, -19, -26, -52, 19, -6, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Core);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    bossCollider  = &work->bossColliders[1];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox3D(&bossCollider->rect, -26, -6, -52, 26, 33, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Invulnerable);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    bossCollider  = &work->bossColliders[2];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_BODY | OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_BODY | OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox3D(&bossCollider->rect, -26, -26, -52, 26, 33, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Bite);

    bossCollider  = &work->bossColliders[3];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox3D(&bossCollider->rect, -39, -19, -52, 0, 33, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Core_Charging);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    bossCollider  = &work->bossColliders[4];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox3D(&bossCollider->rect, -72, -132, -52, 66, -66, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Harmful);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    bossCollider  = &work->bossColliders[5];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox3D(&bossCollider->rect, -19, -26, -105, 19, -6, 105);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_LastHit);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    bossCollider  = &work->bossColliders[6];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox3D(&bossCollider->rect, -26, -6, -105, 26, 33, 105);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Invulnerable);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    bossCollider  = &work->bossColliders[7];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox3D(&bossCollider->rect, -33, -33, -52, 33, -13, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_LastHit);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    bossCollider  = &work->bossColliders[8];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox3D(&bossCollider->rect, -66, -13, -52, 33, 46, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Invulnerable);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    bossCollider  = &work->bossColliders[9];
    *bossCollider = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK];
    ObjRect__SetAttackStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(bossCollider, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox3D(&bossCollider->rect, -66, -66, -52, 132, 0, 52);
    bossCollider->parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(bossCollider, Boss1__OnDefend_Harmful);
    bossCollider->flag |= OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    Boss1Stage__GetBackground(&work->background);

    ObjAction3dNNModelLoad(&work->gameWork.objWork, &work->aniBossMain, "", 0, &bossAssetFiles[0], NULL);
    work->gameWork.objWork.obj_3d             = NULL;
    work->aniBossMain.ani.work.scale.x        = FLOAT_TO_FX32(3.3);
    work->aniBossMain.ani.work.scale.y        = FLOAT_TO_FX32(3.3);
    work->aniBossMain.ani.work.scale.z        = FLOAT_TO_FX32(3.3);
    work->aniBossMain.ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    work->aniBossMain.ani.work.matrixOpIDs[1] = MATRIX_OP_NONE;

    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniBossMain, "/boss1.nsbca", NULL, gameArchiveStage);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniBossMain, "/boss1.nsbva", NULL, gameArchiveStage);
    NNS_G3dRenderObjSetCallBack(&work->aniBossMain.ani.renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(work->aniBossMain.ani.renderObj.resMdl, "weak", MTXSTACK_WEAK, NULL, NULL);
    BossHelpers__Model__Init(work->aniBossMain.ani.renderObj.resMdl, "body_neck", MTXSTACK_BODY_NECK, Boss1__NeckRenderCallback, work);

    OBS_ACTION3D_NN_WORK *aniBossSub = &work->aniBossSub1;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, aniBossSub, "", 2, &bossAssetFiles[0], NULL);
    work->gameWork.objWork.obj_3d = NULL;
    aniBossSub->ani.work.scale.x  = FLOAT_TO_FX32(3.3);
    aniBossSub->ani.work.scale.y  = FLOAT_TO_FX32(200.0);
    aniBossSub->ani.work.scale.z  = FLOAT_TO_FX32(3.3);

    aniBossSub = &work->aniBossSub2;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, aniBossSub, "", 1, &bossAssetFiles[0], NULL);
    work->gameWork.objWork.obj_3d       = NULL;
    aniBossSub->ani.work.scale.x        = FLOAT_TO_FX32(3.3);
    aniBossSub->ani.work.scale.y        = FLOAT_TO_FX32(3.3);
    aniBossSub->ani.work.scale.z        = FLOAT_TO_FX32(3.3);
    aniBossSub->ani.work.matrixOpIDs[0] = MATRIX_OP_NONE;

    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    for (s32 i = 0; i < 24; i++)
    {
        InitPaletteAnimator(&work->aniPalette[i], NNS_FndGetArchiveFileByIndex(&arc, i + ARCHIVE_Z1BOSS_ACT_LZ7_FILE_BOSS1_Z1_AGO_BPA), 0, ANIMATORBPA_FLAG_NONE,
                            PALETTE_MODE_TEXTURE, VRAMKEY_TO_ADDR(Asset3DSetup__PaletteFromName(NNS_G3dGetTex(bossAssetFiles[0].fileData), Boss1__paletteNameTable[i])));
    }
    BossHelpers__SetPaletteAnimations(work->aniPalette, 24, 0, 0);
    NNS_FndUnmountArchive(&arc);

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_MANUAL;
    Boss1__Action_Init(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x00000E58
	ldr r0, =StageTask_Main
	ldr r1, =Boss1__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	mov r0, #0
	mov r1, r8
	mov r2, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r8
	bl GameObject__InitFromObject
	ldr r1, =Boss1__State_Active
	ldr r0, =Boss1__Draw
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r0, =Boss1__Collide
	mov r2, #0x400
	str r0, [r8, #0x108]
	ldr r0, [r8, #0x18]
	mov r1, #0x1000
	orr r0, r0, #0x10
	str r0, [r8, #0x18]
	ldr r3, [r8, #0x20]
	ldr r0, =Boss1Stage__Singleton
	orr r3, r3, #0x180
	str r3, [r8, #0x20]
	ldr r3, [r8, #0x1c]
	orr r3, r3, #0x8300
	str r3, [r8, #0x1c]
	str r2, [r8, #0xd8]
	str r1, [r8, #0x38]
	str r1, [r8, #0x3c]
	str r1, [r8, #0x40]
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0x378]
	mov r0, #0
	rsb r1, r1, #0
	add r1, r1, #0x14000
	str r0, [r8, #0x44]
	str r1, [r8, #0x48]
	str r0, [r8, #0x4c]
	ldr r0, =0x00141BB2
	str r0, [r8, #0x698]
	bl AllocSndHandle
	str r0, [r8, #0xe4c]
	bl AllocSndHandle
	str r0, [r8, #0xe50]
	bl AllocSndHandle
	str r0, [r8, #0xe54]
	add r5, r8, #0x218
	add r4, r8, #0x3b4
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	mov r1, #0
	mov r2, r1
	add r0, r8, #0x3b4
	bl ObjRect__SetAttackStat
	add r0, r8, #0x3b4
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r4, #0x34
	mov r0, #0x13
	str r0, [sp]
	sub r0, r0, #0x19
	str r0, [sp, #4]
	add r0, r8, #0x3b4
	sub r1, r4, #0x47
	sub r2, r4, #0x4e
	sub r3, r4, #0x68
	str r4, [sp, #8]
	bl ObjRect__SetBox3D
	ldr r0, =Boss1__OnDefend_Core
	str r8, [r8, #0x3d0]
	str r0, [r8, #0x3d8]
	ldr r0, [r8, #0x3cc]
	add r5, r8, #0x218
	orr r0, r0, #0x400
	str r0, [r8, #0x3cc]
	add r4, r8, #0x3f4
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r0, r8, #0x3f4
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r8, #0x3f4
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r0, #0x1a
	str r0, [sp]
	mov r0, #0x21
	str r0, [sp, #4]
	mov r3, #0x34
	str r3, [sp, #8]
	add r0, r8, #0x3f4
	sub r1, r3, #0x4e
	sub r2, r3, #0x3a
	sub r3, r3, #0x68
	bl ObjRect__SetBox3D
	str r8, [r8, #0x410]
	ldr r0, =Boss1__OnDefend_Invulnerable
	add r5, r8, #0x34
	str r0, [r8, #0x418]
	ldr r0, [r8, #0x40c]
	add r6, r8, #0x218
	orr r0, r0, #0x40
	str r0, [r8, #0x40c]
	add r4, r5, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r0, r5, #0x400
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r5, #0x400
	mov r1, #3
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r4, #0x34
	mov r0, #0x1a
	sub r1, r4, #0x4e
	str r0, [sp]
	mov r0, #0x21
	str r0, [sp, #4]
	mov r2, r1
	add r0, r5, #0x400
	sub r3, r4, #0x68
	str r4, [sp, #8]
	bl ObjRect__SetBox3D
	add r4, r8, #0x74
	ldr r0, =Boss1__OnDefend_Bite
	str r8, [r5, #0x41c]
	str r0, [r5, #0x420]
	add r6, r8, #0x218
	add r5, r4, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	add r0, r4, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x400
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [sp]
	mov r0, #0x21
	str r0, [sp, #4]
	mov r3, #0x34
	str r3, [sp, #8]
	add r0, r4, #0x400
	sub r1, r3, #0x5b
	sub r2, r3, #0x47
	sub r3, r3, #0x68
	bl ObjRect__SetBox3D
	str r8, [r4, #0x41c]
	ldr r0, =Boss1__OnDefend_Core_Charging
	add r5, r8, #0xb4
	str r0, [r4, #0x424]
	ldr r0, [r4, #0x418]
	add r6, r8, #0x218
	orr r0, r0, #0x400
	str r0, [r4, #0x418]
	add r4, r5, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r0, r5, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r5, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r0, #0x42
	str r0, [sp]
	sub r0, r0, #0x84
	str r0, [sp, #4]
	mov r3, #0x34
	str r3, [sp, #8]
	add r0, r5, #0x400
	sub r1, r3, #0x7c
	sub r2, r3, #0xb8
	sub r3, r3, #0x68
	bl ObjRect__SetBox3D
	ldr r0, =Boss1__OnDefend_Harmful
	str r8, [r5, #0x41c]
	str r0, [r5, #0x424]
	ldr r0, [r5, #0x418]
	add r4, r8, #0xf4
	orr r0, r0, #0x40
	str r0, [r5, #0x418]
	add r6, r8, #0x218
	add r5, r4, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	add r0, r4, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x400
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0x13
	str r0, [sp]
	sub r0, r0, #0x19
	str r0, [sp, #4]
	mov r3, #0x69
	str r3, [sp, #8]
	add r0, r4, #0x400
	sub r1, r3, #0x7c
	sub r2, r3, #0x83
	sub r3, r3, #0xd2
	bl ObjRect__SetBox3D
	str r8, [r4, #0x41c]
	ldr r0, =Boss1__OnDefend_LastHit
	add r5, r8, #0x134
	str r0, [r4, #0x424]
	ldr r0, [r4, #0x418]
	add r6, r8, #0x218
	orr r0, r0, #0x400
	str r0, [r4, #0x418]
	add r4, r5, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r0, r5, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r5, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r0, #0x1a
	str r0, [sp]
	mov r0, #0x21
	str r0, [sp, #4]
	mov r3, #0x69
	str r3, [sp, #8]
	add r0, r5, #0x400
	sub r1, r3, #0x83
	sub r2, r3, #0x6f
	sub r3, r3, #0xd2
	bl ObjRect__SetBox3D
	str r8, [r5, #0x41c]
	ldr r0, =Boss1__OnDefend_Invulnerable
	str r0, [r5, #0x424]
	ldr r0, [r5, #0x418]
	add r4, r8, #0x174
	orr r0, r0, #0x40
	str r0, [r5, #0x418]
	add r6, r8, #0x218
	add r5, r4, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	add r0, r4, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x400
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0x21
	str r0, [sp]
	sub r0, r0, #0x2e
	str r0, [sp, #4]
	mov r2, #0x34
	str r2, [sp, #8]
	add r0, r4, #0x400
	sub r1, r2, #0x55
	sub r3, r2, #0x68
	mov r2, r1
	bl ObjRect__SetBox3D
	str r8, [r4, #0x41c]
	ldr r0, =Boss1__OnDefend_LastHit
	add r5, r8, #0x1b4
	str r0, [r4, #0x424]
	ldr r0, [r4, #0x418]
	add r6, r8, #0x218
	orr r0, r0, #0x400
	str r0, [r4, #0x418]
	add r4, r5, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r0, r5, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r5, #0x400
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r0, #0x21
	str r0, [sp]
	mov r0, #0x2e
	str r0, [sp, #4]
	mov r3, #0x34
	str r3, [sp, #8]
	add r0, r5, #0x400
	sub r1, r3, #0x76
	sub r2, r3, #0x41
	sub r3, r3, #0x68
	bl ObjRect__SetBox3D
	str r8, [r5, #0x41c]
	ldr r0, =Boss1__OnDefend_Invulnerable
	add r4, r8, #0x1f4
	str r0, [r5, #0x424]
	ldr r0, [r5, #0x418]
	orr r0, r0, #0x40
	str r0, [r5, #0x418]
	add r6, r8, #0x218
	add r5, r4, #0x400
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	mov r1, #0
	add r0, r4, #0x400
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r1, #0
	add r0, r4, #0x400
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r2, #0x34
	mov r0, #0x84
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	sub r1, r2, #0x76
	str r2, [sp, #8]
	sub r3, r2, #0x68
	add r0, r4, #0x400
	mov r2, r1
	bl ObjRect__SetBox3D
	ldr r1, =Boss1__OnDefend_Harmful
	str r8, [r4, #0x41c]
	str r1, [r4, #0x424]
	ldr r1, [r4, #0x418]
	add r0, r8, #0x364
	orr r1, r1, #0x40
	str r1, [r4, #0x418]
	bl Boss1Stage__GetBackground
	ldr r0, =bossAssetFiles
	mov r3, #0
	stmia sp, {r0, r3}
	ldr r2, =Boss1__path_none
	mov r0, r8
	add r1, r8, #0x9d0
	bl ObjAction3dNNModelLoad
	mov r3, #0
	ldr r1, =0x000034CC
	str r3, [r8, #0x12c]
	str r1, [r8, #0x9e8]
	str r1, [r8, #0x9ec]
	str r1, [r8, #0x9f0]
	mov r0, #4
	strb r0, [r8, #0x9da]
	ldr r1, =gameArchiveStage
	strb r3, [r8, #0x9db]
	ldr r2, [r1, #0]
	mov r0, r8
	str r2, [sp]
	ldr r2, =aBoss1Nsbca
	add r1, r8, #0x9d0
	bl ObjAction3dNNMotionLoad
	ldr r1, =gameArchiveStage
	mov r0, r8
	ldr r2, [r1, #0]
	add r1, r8, #0x9d0
	str r2, [sp]
	ldr r2, =aBoss1Nsbva
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	mov r0, #3
	str r0, [sp]
	ldr r1, =BossHelpers__Model__RenderCallback
	add r0, r8, #0xa60
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r8, #0xa64]
	ldr r1, =aWeak
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	str r8, [sp]
	ldr r0, [r8, #0xa64]
	ldr r1, =aBodyNeck
	ldr r3, =Boss1__NeckRenderCallback
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	ldr r1, =bossAssetFiles
	ldr r2, =Boss1__path_none
	str r1, [sp]
	mov r4, #0
	mov r0, r8
	add r1, r8, #0xb50
	mov r3, #2
	str r4, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r2, r4
	ldr r1, =0x000034CC
	str r2, [r8, #0x12c]
	mov r0, #0xc8000
	str r1, [r8, #0xb68]
	str r0, [r8, #0xb6c]
	str r1, [r8, #0xb70]
	ldr r1, =bossAssetFiles
	add r4, r8, #0xcc
	stmia sp, {r1, r2}
	ldr r2, =Boss1__path_none
	mov r0, r8
	add r1, r4, #0xc00
	mov r3, #1
	bl ObjAction3dNNModelLoad
	mov r2, #0
	ldr r1, =0x000034CC
	str r2, [r8, #0x12c]
	str r1, [r4, #0xc18]
	str r1, [r4, #0xc1c]
	str r1, [r4, #0xc20]
	strb r2, [r4, #0xc0a]
	ldr r2, =gameArchiveStage
	ldr r1, =aExc_2
	ldr r2, [r2, #0]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	ldr r6, =Boss1__paletteNameTable
	ldr r4, =bossAssetFiles
	mov r9, #0
	add r10, r8, #0x6d0
	add r11, sp, #0xc
	mov r5, #5
_02154E24:
	mov r0, r11
	add r1, r9, #9
	bl NNS_FndGetArchiveFileByIndex
	mov r7, r0
	ldr r0, [r4, #0]
	bl NNS_G3dGetTex
	ldr r1, [r6, r9, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r5, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r7
	mov r0, r10
	mov r3, r2
	bl InitPaletteAnimator
	add r9, r9, #1
	add r10, r10, #0x20
	cmp r9, #0x18
	blt _02154E24
	mov r2, #0
	mov r3, r2
	add r0, r8, #0x6d0
	mov r1, #0x18
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	ldr r1, =renderCoreSwapBuffer
	mov r2, #1
	mov r0, r8
	str r2, [r1, #4]
	bl Boss1__Action_Init
	mov r0, r8
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void Boss1Stage__GetBackground(void **background)
{
    *background = MapFarSys__GetAsset();
}

Boss1Phase Boss1Stage__GetBossPhase(Boss1Stage *work)
{
    s16 health = work->health;

    Boss1Phase p = BOSS1_PHASE_1;
    for (; p < BOSS1_PHASE_4; p++)
    {
        if (Boss1__healthPhaseTable[p] < health)
            break;
    }

    return p;
}

u16 Boss1Stage__GetBaseDamageValue(void)
{
    return Boss1__baseDamageTable[gameState.difficulty];
}

fx32 Boss1Stage__GetDamageModifier(Boss1Stage *work)
{
    return damageModifierTable[Boss1Stage__GetCappedComboCount(work)];
}

fx32 Boss1Stage__GetDmgMultiplier2(Boss1Stage *work)
{
    return Boss1__damageModifier2[gameState.difficulty];
}

u16 Boss1Stage__GetIdleDuration(Boss1Stage *work)
{
    const Boss1IdleConfig *config;

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
        config = &Boss1__idleConfigTable[BOSS1_PHASE_4];
    else
        config = &Boss1__idleConfigTable[Boss1Stage__GetBossPhase(work)];

    return config->duration + (config->extraRange & mtMathRand());
}

s32 Boss1Stage__GetBiteType(Boss1Stage *work)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return biteTypes[BOSS1_PHASE_4][mtMathRandRepeat(4)];
    }
    else
    {
        return biteTypes[Boss1Stage__GetBossPhase(work)][mtMathRandRepeat(4)];
    }
}

const Boss1BiteConfig *Boss1Stage__GetBiteConfig(Boss1Stage *work)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return &biteConfig[gameState.difficulty][BOSS1_PHASE_4];
    }
    else
    {
        return &biteConfig[gameState.difficulty][Boss1Stage__GetBossPhase(work)];
    }
}

u16 Boss1Stage__GetBiteDamageDuration(Boss1Stage *work)
{
    return Boss1__biteDamageDuration[gameState.difficulty];
}

fx32 Boss1Stage__GetKnockbackPower(Boss1Stage *work)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return knockbackPower[BOSS1_PHASE_4][Boss1Stage__GetCappedComboCount(work)];
    }
    else
    {
        return knockbackPower[Boss1Stage__GetBossPhase(work)][Boss1Stage__GetCappedComboCount(work)];
    }
}

const Boss1ChargeConfig *Boss1Stage__GetChargeConfig(Boss1Stage *work)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return &chargeConfigTable[gameState.difficulty][BOSS1_PHASE_4];
    }
    else
    {
        return &chargeConfigTable[gameState.difficulty][Boss1Stage__GetBossPhase(work)];
    }
}

fx32 Boss1Stage__GetChargeKnockbackPower(Boss1Stage *work)
{
    return chargeKnockbackPower[Boss1Stage__GetCappedComboCount(work)];
}

fx32 Boss1Stage__GetChargeRecoilPower(Boss1Stage *work)
{
    return chargeRecoilPower[Boss1Stage__GetCappedComboCount(work)];
}

const Boss1HeadSlamConfig *Boss1Stage__GetHeadSlamConfig(Boss1Stage *work)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return &headSlamTable[gameState.difficulty][BOSS1_PHASE_4];
    }
    else
    {
        return &headSlamTable[gameState.difficulty][Boss1Stage__GetBossPhase(work)];
    }
}

u16 Boss1Stage__GetChargeDamageDuration(Boss1Stage *work)
{
    return Boss1__chargeDamageDuration[gameState.difficulty];
}

void Boss1Stage__HandlePlayer(Boss1Stage *work)
{
    if ((gPlayer->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        Boss1Stage__ResetHitCount(work);
}

void Boss1Stage__ResetHitCount(Boss1Stage *work)
{
    work->hitCount = 0;
}

u16 Boss1Stage__IncrementHitCount(Boss1Stage *work)
{
    work->hitCount++;
    return work->hitCount;
}

u32 Boss1Stage__GetHitComboCount(Boss1Stage *work)
{
    return work->hitCount;
}

u32 Boss1Stage__GetCappedComboCount(Boss1Stage *work)
{
    u32 hitCount = Boss1Stage__GetHitComboCount(work);

    if (Boss1Stage__GetHitComboCount(work) > BOSS1_HIT_COMBO_MAX)
        return BOSS1_HIT_COMBO_MAX;

    return Boss1Stage__GetHitComboCount(work);
}

NONMATCH_FUNC void Boss1Stage__SetupAnimators(Boss1Stage *work)
{
    // will match when strings are decompiled
#ifdef NON_MATCHING
    Boss1StageDropControl *control = &work->dropControl;

    control->state = 0;

    for (s32 i = 0; i < BOSS1STAGE_MESH_COUNT; i++)
    {
        OBS_ACTION3D_NN_WORK *animator = &work->dropControl.aniStage[i];
        ObjAction3dNNModelLoad(&work->gameWork.objWork, animator, "", i, &bossAssetFiles[1], NULL);
        work->gameWork.objWork.obj_3d    = NULL;
        animator->ani.work.scale.x       = FLOAT_TO_FX32(1.0);
        animator->ani.work.scale.y       = FLOAT_TO_FX32(1.0);
        animator->ani.work.scale.z       = FLOAT_TO_FX32(1.0);
        animator->ani.work.translation.x = FLOAT_TO_FX32(321.73095703125);
    }

    OBS_ACTION3D_NN_WORK *animator = &work->dropControl.aniStage[1];
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, animator, "/boss1.nsbca", NULL, gameArchiveStage);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, animator, "/boss1.nsbva", NULL, gameArchiveStage);

    BossHelpers__SetAnimation(&animator->ani, B3D_ANIM_JOINT_ANIM, animator->resources[B3D_RESOURCE_JOINT_ANIM], ANI_bs1_stage_01, NULL, FALSE);
    BossHelpers__SetAnimation(&animator->ani, B3D_ANIM_VIS_ANIM, animator->resources[B3D_RESOURCE_VIS_ANIM], ANI_bs1_stage_01, NULL, FALSE);

    control->meshParts[0] = BOSS1STAGE_PART_STAGE_1;
    for (s32 i = 1; i < 7; i++)
    {
        control->meshParts[i] = BOSS1STAGE_PART_DROP_HOLE_1;
    }
    control->field_14 = 0x3E8000;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	mov r8, #0
	ldr r6, =bossAssetFiles+8
	str r8, [r10, #0x3b4]
	add r7, r10, #0x3b4
	add r9, r10, #0x3e8
	mov r5, r8
	mov r4, r8
	mov r11, #0x1000
_02155384:
	str r6, [sp]
	ldr r2, =Boss1__path_none
	mov r0, r10
	mov r1, r9
	mov r3, r8
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	str r4, [r10, #0x12c]
	str r11, [r9, #0x18]
	str r11, [r9, #0x1c]
	add r8, r8, #1
	ldr r0, =0x00141BB2
	str r11, [r9, #0x20]
	str r0, [r9, #0x48]
	cmp r8, #5
	add r9, r9, #0x17c
	blt _02155384
	ldr r0, =gameArchiveStage
	add r5, r10, #0x164
	ldr r6, [r0, #0]
	ldr r2, =aBoss1Nsbca
	mov r0, r10
	mov r3, r4
	add r1, r5, #0x400
	str r6, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r0, =gameArchiveStage
	ldr r2, =aBoss1Nsbva
	ldr r4, [r0, #0]
	mov r0, r10
	add r1, r5, #0x400
	mov r3, #0
	str r4, [sp]
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r5, #0x548]
	add r0, r5, #0x400
	mov r3, #0x46
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, [r5, #0x558]
	add r0, r5, #0x400
	mov r1, #4
	mov r3, #0x46
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [r7, #0x18]
	mov r2, #1
	mov r1, #2
_02155458:
	add r0, r7, r2, lsl #2
	add r2, r2, #1
	str r1, [r0, #0x18]
	cmp r2, #7
	blt _02155458
	mov r0, #0x3e8000
	str r0, [r7, #0x14]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss1Stage__HandleDrop(Boss1Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x3b4]
	add r4, r0, #0x3b4
	cmp r1, #4
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #8]
	ldr r0, [r4, #0xc]
	add r0, r1, r0
	str r0, [r4, #8]
	ldr r1, [r4, #0x10]
	rsb r2, r1, #0
	cmp r0, r2
	blt _021554D4
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_021554D4:
	str r2, [r4, #8]
	ldr r0, [r4, #4]
	add r0, r0, r2
	str r0, [r4, #4]
	ldr r0, [r4, #0]
	cmp r0, #3
	bne _02155534
	ldr r2, [r4, #4]
	ldr r1, =dropUnknownTable
	mov r3, #0
_021554FC:
	add r0, r4, r3, lsl #2
	ldr r0, [r0, #0x18]
	add r3, r3, #1
	ldr r0, [r1, r0, lsl #2]
	cmp r3, #6
	sub r2, r2, r0
	blt _021554FC
	cmp r2, #0
	blt _02155580
	ldr r1, [r4, #4]
	mov r0, #4
	sub r1, r1, r2
	stmia r4, {r0, r1}
	b _02155580
_02155534:
	ldr r1, [r4, #0x14]
	ldr r0, [r4, #4]
	cmp r1, r0
	bgt _02155580
	ldr r1, [r4, #0x18]
	ldr r0, =dropUnknownTable
	ldr r2, [r4, #4]
	ldr r0, [r0, r1, lsl #2]
	mov r3, #1
	sub r0, r2, r0
	str r0, [r4, #4]
_02155560:
	add r1, r4, r3, lsl #2
	ldr r0, [r1, #0x18]
	add r3, r3, #1
	str r0, [r1, #0x14]
	cmp r3, #7
	blt _02155560
	mov r0, #2
	str r0, [r4, #0x30]
_02155580:
	bl GetRingManagerWork
	ldr r2, [r0, #0x36c]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
_02155590:
	ldr r1, [r2, #4]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	str r0, [r2, #4]
	ldr r2, [r2, #0x2c]
	cmp r2, #0
	bne _02155590
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss1Stage__DrawStagePart(Boss1Stage *work, fx32 y, Boss1StagePart type)
{
    Boss1StageDropControl *control = &work->dropControl;
    y += work->field_378;

    Animator3D *ani;
    switch (type)
    {
        case BOSS1STAGE_PART_STAGE_1:
            ani                = &control->aniStage[BOSS1STAGE_MESH_STAGE_1].ani.work;
            ani->translation.y = y;
            StageTask__Draw3D(&work->gameWork.objWork, ani);

            ani                = &control->aniStage[BOSS1STAGE_MESH_SURFACE_FOREST].ani.work;
            ani->translation.y = y;
            StageTask__Draw3D(&work->gameWork.objWork, ani);
            break;

        case BOSS1STAGE_PART_STAGE_2:
            ani                = &control->aniStage[BOSS1STAGE_MESH_STAGE_2].ani.work;
            ani->translation.y = y;
            StageTask__Draw3D(&work->gameWork.objWork, ani);

            ani                = &control->aniStage[BOSS1STAGE_MESH_SURFACE_FOREST].ani.work;
            ani->translation.y = y;
            StageTask__Draw3D(&work->gameWork.objWork, ani);
            break;

        case BOSS1STAGE_PART_DROP_HOLE_1:
        case BOSS1STAGE_PART_DROP_HOLE_2:
            ani                = &control->aniStage[BOSS1STAGE_MESH_DROP_HOLE].ani.work;
            ani->translation.y = y;
            StageTask__Draw3D(&work->gameWork.objWork, ani);
            break;

        case BOSS1STAGE_PART_CAVE:
            ani                = &control->aniStage[BOSS1STAGE_MESH_CAVE].ani.work;
            ani->translation.y = y;
            StageTask__Draw3D(&work->gameWork.objWork, ani);
            break;
    }
}

void Boss1Stage__DrawStage(Boss1Stage *work)
{
    Boss1StageDropControl *control = &work->dropControl;

    fx32 y = control->field_4;
    Boss1Stage__DrawStagePart(work, y, control->meshParts[0]);

    for (s32 i = 1; i < 7; i++)
    {
        y -= dropUnknownTable[control->meshParts[i - 1]];
        Boss1Stage__DrawStagePart(work, y, control->meshParts[i]);
    }
}

void Boss1Stage__Action_Drop(Boss1Stage *work)
{
    work->dropControl.state        = 1;
    work->dropControl.meshParts[0] = BOSS1STAGE_PART_STAGE_2;
}

void Boss1Stage__Func_21556BC(Boss1Stage *work)
{
    work->dropControl.state        = 2;
    work->dropControl.moveOffsetY  = FLOAT_TO_FX32(1.0);
    work->dropControl.moveVelocity = FLOAT_TO_FX32(0.5);
    work->dropControl.field_10     = FLOAT_TO_FX32(100.0);
}

void Boss1Stage__Func_21556E0(Boss1Stage *work)
{
    work->dropControl.state        = 3;
    work->dropControl.meshParts[5] = BOSS1STAGE_PART_DROP_HOLE_2;
    work->dropControl.meshParts[6] = BOSS1STAGE_PART_CAVE;
}

void Boss1Stage__Func_21556F8(Boss1Stage *work)
{
    BossArena__SetNextPos(BossArena__GetCamera(1), GetScreenShakeOffsetX(), GetScreenShakeOffsetY(), FLOAT_TO_FX32(0.0));
    BossArena__SetNextPos(BossArena__GetCamera(2), GetScreenShakeOffsetX(), GetScreenShakeOffsetY(), FLOAT_TO_FX32(0.0));
}

void Boss1Stage__Func_2155758(Boss1Stage *work)
{
    work->field_37C += FLOAT_TO_FX32(0.25);
    BossArena__SetBoundsX(FX32_TO_WHOLE(work->field_37C), -128);
}

void Boss1Stage__HandleCamera(Boss1Stage *work)
{
    Camera3D *config = BossArena__GetCameraConfig2(BossArena__GetCamera(1));

    FXMatrix43 mtxView;
    MTX_LookAt(&config->camPos, &config->camUp, &config->camTarget, mtxView.nnMtx);
    InitSpatialAudioMatrix(&mtxView.mtx33);
}

void Boss1Stage__State_Active(Boss1Stage *work)
{
    if (work->field_370)
        Boss1Stage__Func_2155758(work);

    Boss1Stage__HandleDrop(work);
    Boss1Stage__HandlePlayer(work);
    Boss1Stage__Func_21556F8(work);
    BossHelpers__ProcessLights(&work->lightConfig);
    Boss1Stage__HandleCamera(work);

    work->stageState(work);
}

void Boss1Stage__Destructor(Task *task)
{
    Boss1Stage *work = TaskGetWork(task, Boss1Stage);

    for (s32 i = 0; i < BOSS1STAGE_MESH_COUNT; i++)
    {
        BossHelpers__ReleaseAnimation(&work->dropControl.aniStage[i]);
        AnimatorMDL__Release(&work->dropControl.aniStage[i].ani);
    }

    Boss1Stage__Singleton = NULL;

    GameObject__Destructor(task);
}

void Boss1Stage__Draw(void)
{
    Boss1Stage *work = TaskGetWorkCurrent(Boss1Stage);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BossHelpers__RevertModifiedLights(&work->lightConfig);
        Boss1Stage__DrawStage(work);
        BossHelpers__ApplyModifiedLights(&work->lightConfig);
    }
}

NONMATCH_FUNC void Boss1Stage__StageState_Init(Boss1Stage *work)
{
    // will match when 'camUp' is decompiled
#ifdef NON_MATCHING
    VecFx32 camUp = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    BossArena__SetType(BOSSARENA_TYPE_4);
    BossArena__SetField358(FLOAT_TO_FX32(350.0));
    BossArena__SetField35C(FLOAT_TO_FX32(1.3333));

    CameraConfig config;
    MI_CpuClear16(&config, sizeof(config));
    config.projFOV     = FLOAT_DEG_TO_IDX(20.0);
    config.projNear    = FLOAT_TO_FX32(1.0);
    config.projFar     = FLOAT_TO_FX32(3000.0);
    config.aspectRatio = FLOAT_TO_FX32(1.3333);
    config.projScaleW  = FLOAT_TO_FX32(0.5);

    BossArenaCamera *cameraA = BossArena__GetCamera(1);
    BossArena__SetCameraType(cameraA, BOSSARENACAMERA_TYPE_1);
    BossArena__SetCameraConfig(cameraA, &config);
    BossArena__SetTracker1TargetWork(cameraA, &gPlayer->objWork, NULL, &gPlayer->objWork);
    BossArena__SetTracker1TargetPos(cameraA, FLOAT_TO_FX32(0.0), work->field_378 + FLOAT_TO_FX32(80.0), FLOAT_TO_FX32(0.0));
    BossArena__SetTracker1Speed(cameraA, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(0.0));
    BossArena__SetTracker1UseObj3D(cameraA, 1);
    BossArena__UpdateTracker1TargetPos(cameraA);
    BossArena__SetAmplitudeXZTarget(cameraA, FLOAT_TO_FX32(300.0));
    BossArena__SetAmplitudeXZSpeed(cameraA, FLOAT_TO_FX32(0.05));
    BossArena__ApplyAmplitudeXZTarget(cameraA);
    BossArena__SetAmplitudeYTarget(cameraA, -FLOAT_TO_FX32(20.0));
    BossArena__SetAmplitudeYSpeed(cameraA, FLOAT_TO_FX32(0.05));
    BossArena__ApplyAmplitudeYTarget(cameraA);
    BossArena__ApplyAngleTarget(cameraA);
    BossArena__SetUpVector(cameraA, &camUp);
    BossArena__DoProcess();
    BossArena__UpdateTracker1TargetPos(cameraA);
    BossArena__UpdateTracker0TargetPos(cameraA);

    BossArenaCamera *cameraB = BossArena__GetCamera(2);
    BossArena__SetCameraType(cameraB, BOSSARENACAMERA_TYPE_1);
    BossArena__SetCameraConfig(cameraB, &config);
    BossArena__SetTracker1TargetWork(cameraB, &gPlayer->objWork, NULL, &gPlayer->objWork);
    BossArena__SetTracker1TargetPos(cameraB, FLOAT_TO_FX32(0.0), work->field_378 - FLOAT_TO_FX32(520.0), FLOAT_TO_FX32(0.0));
    BossArena__SetTracker1Speed(cameraB, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(0.0));
    BossArena__SetTracker1UseObj3D(cameraB, 1);
    BossArena__UpdateTracker1TargetPos(cameraB);
    BossArena__SetAmplitudeXZTarget(cameraB, FLOAT_TO_FX32(300.0));
    BossArena__SetAmplitudeXZSpeed(cameraB, FLOAT_TO_FX32(0.05));
    BossArena__ApplyAmplitudeXZTarget(cameraB);
    BossArena__SetAmplitudeYTarget(cameraB, FLOAT_TO_FX32(20.0));
    BossArena__SetAmplitudeYSpeed(cameraB, FLOAT_TO_FX32(0.05));
    BossArena__ApplyAmplitudeYTarget(cameraB);
    BossArena__ApplyAngleTarget(cameraB);
    BossArena__SetUpVector(cameraB, &camUp);
    BossArena__DoProcess();
    BossArena__UpdateTracker1TargetPos(cameraB);
    BossArena__UpdateTracker0TargetPos(cameraB);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_23);

    BossArena__SetBackgroundType(BOSSARENABACKGROUND_TYPE_3D);

    BossArenaUnknown4A8 *unknown = BossArena__GetField4A8();
    unknown->background          = work->background;
    unknown->backgroundID        = BACKGROUND_1;
    unknown->screenBaseA         = 0;
    unknown->screenBaseBlock     = 0;

    LoadCompressedPixels(GetBackgroundPixels(work->background), PIXEL_MODE_SPRITE, VRAMSystem__VRAM_BG[0] + 0x4000);
    LoadCompressedPalette(GetBackgroundPalette(work->background), PALETTE_MODE_SPRITE, VRAMSystem__VRAM_PALETTE_BG[0]);

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

    UpdateBossHealthHUD(work->health);
    SetHUDActiveScreen(0);

    work->field_370  = 1;
    work->stageState = Boss1Stage__StageState_Idle;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	ldr r1, =Boss1__stageUpVector
	add r3, sp, #0x20
	mov r5, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	ldr r0, =0x0015E000
	bl BossArena__SetField358
	ldr r0, =0x00001555
	bl BossArena__SetField35C
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	mov r0, #0x1000
	ldr r1, =0x00000E38
	str r0, [sp, #4]
	ldr r0, =0x00001555
	strh r1, [sp]
	ldr r1, =0x00BB8000
	str r0, [sp, #0xc]
	mov r0, #0x800
	str r0, [sp, #0x10]
	mov r0, #1
	str r1, [sp, #8]
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
	ldr r2, [r5, #0x378]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	add r2, r2, #0x50000
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
	mov r1, #0x12c000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x14000
	mov r0, r4
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	bl BossArena__DoProcess
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
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
	ldr r2, [r5, #0x378]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	sub r2, r2, #0x208000
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
	mov r1, #0x12c000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x14000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	bl BossArena__DoProcess
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
	mov r2, #0x4000000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #2
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
	ldrh r2, [r0, #0x7c]
	add r1, r5, #0x300
	orr r2, r2, #0x800
	strh r2, [r0, #0x7c]
	ldrh r2, [r0, #0x7c]
	ldrh r3, [r4, #0x20]
	mov r2, r2, lsl #0x14
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x800
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #20
	strh r2, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	orr r2, r2, #0x1000
	strh r2, [r0, #0x7c]
	ldrh r0, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1f
	bic r2, r2, #0x1000
	mov r0, r0, lsl #0x1f
	orr r0, r2, r0, lsr #19
	strh r0, [r4, #0x20]
	ldrsh r0, [r1, #0x74]
	bl UpdateBossHealthHUD
	mov r0, #0
	bl SetHUDActiveScreen
	mov r1, #1
	ldr r0, =Boss1Stage__StageState_Idle
	str r1, [r5, #0x370]
	str r0, [r5, #0x36c]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void Boss1Stage__StageState_Idle(Boss1Stage *work)
{
    // Nothin'
}

void Boss1__Func_2155CA8(Boss1Unknown *work)
{
    if (work->unknown1 < 0)
    {
        while (work->unknown1 < 0)
        {
            work->unknown1 += 0x971E68;
        }
    }
    else
    {
        while (work->unknown1 >= 0x971E68)
        {
            work->unknown1 -= 0x971E68;
        }
    }
}

void Boss1__Func_2155CF8(Boss1Unknown *work)
{
    work->unknown1 += work->unknown2;
    Boss1__Func_2155CA8(work);
}

s32 Boss1__Func_2155D14(Boss1Unknown *work)
{
    Boss1__Func_2155CA8(work);

    if (work->unknown1 < 0x283764)
        return 0;

    if (work->unknown1 < 4951860)
        return 1;

    if (work->unknown1 < 0x73C698)
        return 2;

    return 3;
}

void Boss1__Func_2155D64(Boss1Unknown *work, fx32 *x, fx32 *z, u16 *angle)
{
    s16 ang;
    switch (Boss1__Func_2155D14(work))
    {
        case 0:
            *x     = work->unknown1;
            *z     = -FLOAT_TO_FX32(180.0);
            *angle = 0;
            break;

        case 1:
            ang    = FX_Div(work->unknown1 - FLOAT_TO_FX32(643.4619140625), FLOAT_TO_FX32(565.48828125));
            *angle = FX32_TO_WHOLE(MultiplyFX(FX32_FROM_WHOLE(FLOAT_DEG_TO_IDX(180.0)), ang));

            *x = MultiplyFX(FLOAT_TO_FX32(180.0), SinFX(*angle)) + FLOAT_TO_FX32(643.4619140625);
            *z = -MultiplyFX(FLOAT_TO_FX32(180.0), CosFX(*angle));

            *angle = -*angle;
            break;

        case 2:
            *x     = -(work->unknown1 + -FLOAT_TO_FX32(1208.9501953125)) + FLOAT_TO_FX32(643.4619140625);
            *z     = FLOAT_TO_FX32(180.0);
            *angle = FLOAT_DEG_TO_IDX(180.0);
            break;

        case 3:
            ang    = FX_Div(work->unknown1 - FLOAT_TO_FX32(1852.412109375), FLOAT_TO_FX32(565.48828125));
            *angle = FX32_TO_WHOLE(MultiplyFX(FLOAT_TO_FX32(32768.0), ang) + FX32_FROM_WHOLE(FLOAT_DEG_TO_IDX(180.0)));

            *x = MultiplyFX(FLOAT_TO_FX32(180.0), SinFX(*angle));
            *z = -MultiplyFX(FLOAT_TO_FX32(180.0), CosFX(*angle));

            *angle = -*angle;
            break;
    }
}

void Boss1__Func_2155FB0(s32 type, u32 *anim1, u32 *anim2, u32 *anim3, u32 *anim4, u32 *anim5, u32 *anim6, u32 *anim7)
{
    switch (type)
    {
        case 1:
            *anim1 = ANI_bs1_body_fw0;
            *anim2 = ANI_bs1_body_walkl0;
            *anim3 = ANI_bs1_body_walkl1;
            *anim4 = ANI_bs1_body_walkl2;
            *anim5 = ANI_bs1_body_walkr0;
            *anim6 = ANI_bs1_body_walkr1;
            *anim7 = ANI_bs1_body_walkr2;
            break;

        case 2:
            *anim1 = ANI_bs1_body_bite1;
            *anim2 = ANI_bs1_body_btwkl0;
            *anim3 = ANI_bs1_body_btwkl1;
            *anim4 = ANI_bs1_body_btwkl2;
            *anim5 = ANI_bs1_body_btwkr0;
            *anim6 = ANI_bs1_body_btwkr1;
            *anim7 = ANI_bs1_body_btwkr2;
            break;

        case 4:
            *anim1 = ANI_bs1_body_head1;
            *anim2 = ANI_bs1_body_hdwkl0;
            *anim3 = ANI_bs1_body_hdwkl1;
            *anim4 = ANI_bs1_body_hdwkl2;
            *anim5 = ANI_bs1_body_hdwkr0;
            *anim6 = ANI_bs1_body_hdwkr1;
            *anim7 = ANI_bs1_body_hdwkr2;
            break;
    }
}

NONMATCH_FUNC void Boss1__Func_2156094(Boss1 *work, u32 anim1, u32 anim2, u32 anim3, u32 anim4, u32 anim5, u32 anim6, u32 anim7)
{
    // https://decomp.me/scratch/DirKv -> 97.60%
#ifdef NON_MATCHING
    Boss1Unknown *control = &work->field_698;

    if (control->unknown2 != 0)
    {
        if (control->unknown2 > 0)
        {
            switch (control->field_6A0)
            {
                case 0:
                case 3:
                case 4:
                    control->field_6A0 = 1;
                    Boss1__EnableAnimBlending(work);
                    Boss1__SetAnimation(work, anim2, FALSE);
                    break;

                case 1:
                    control->unknown2 = 0;
                    if (Boss1__CheckAnimFinished(work))
                    {
                        control->field_6A0 = 2;
                        Boss1__SetAnimation(work, anim3, TRUE);
                    }
                    break;

                case 5:
                    control->field_6A0 = 6;
                    Boss1__EnableAnimBlending(work);
                    Boss1__SetAnimation(work, anim7, FALSE);
                    break;

                case 6:
                    control->unknown2 = 0;
                    if (Boss1__CheckAnimFinished(work))
                    {
                        control->field_6A0 = 1;
                        Boss1__SetAnimation(work, anim2, FALSE);
                    }
                    break;
            }
        }
        else
        {
            switch (control->field_6A0)
            {
                case 0:
                case 1:
                case 6:
                    control->field_6A0 = 4;
                    Boss1__EnableAnimBlending(work);
                    Boss1__SetAnimation(work, anim5, FALSE);
                    break;

                case 4:
                    control->unknown2 = 0;
                    if (Boss1__CheckAnimFinished(work))
                    {
                        control->field_6A0 = 5;
                        Boss1__SetAnimation(work, anim6, TRUE);
                    }
                    break;

                case 2:
                    control->field_6A0 = 3;
                    Boss1__EnableAnimBlending(work);
                    Boss1__SetAnimation(work, anim4, FALSE);
                    break;

                case 3:
                    control->unknown2 = 0;
                    if (Boss1__CheckAnimFinished(work))
                    {
                        control->field_6A0 = 4;
                        Boss1__SetAnimation(work, anim5, FALSE);
                    }
                    break;
            }
        }

        if (anim3 == work->animID || anim6 == work->animID)
        {
            u32 step = FX32_TO_WHOLE((u32)work->aniBossMain.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame * 16) >> 4;
            if (work->field_E48 != step)
            {
                if (step == 0 || step == 50)
                {
                    PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_WALK);

                    DisableSpatialVolume();
                    ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
                    EnableSpatialVolume();

                    work->field_E48 = step;
                }
            }
        }
        else
        {
            work->field_E48 = 0;
        }
    }
    else
    {
        switch (control->field_6A0)
        {
            case 1:
            case 4:
                control->field_6A0 = 0;
                Boss1__EnableAnimBlending(work);
                Boss1__SetAnimation(work, anim1, TRUE);
                break;

            case 2:
                control->field_6A0 = 3;
                Boss1__EnableAnimBlending(work);
                Boss1__SetAnimation(work, anim4, FALSE);
                break;

            case 5:
                control->field_6A0 = 6;
                Boss1__EnableAnimBlending(work);
                Boss1__SetAnimation(work, anim7, FALSE);
                break;

            case 3:
            case 6:
                if (Boss1__CheckAnimFinished(work))
                {
                    control->field_6A0 = 0;
                    Boss1__SetAnimation(work, anim1, TRUE);
                }
                break;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	add ip, r7, #0x298
	ldr lr, [ip, #0x404]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp lr, #0
	beq _021562EC
	cmp lr, #0
	ldr r1, [r7, #0x6a0]
	ble _02156190
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _02156254
_021560D4: // jump table
	b _021560F0 // case 0
	b _02156110 // case 1
	b _02156254 // case 2
	b _021560F0 // case 3
	b _021560F0 // case 4
	b _02156140 // case 5
	b _02156160 // case 6
_021560F0:
	mov r1, #1
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	mov r0, r7
	mov r1, r5
	mov r2, #0
	bl Boss1__SetAnimation
	b _02156254
_02156110:
	mov r1, #0
	str r1, [ip, #0x404]
	bl Boss1__CheckAnimFinished
	cmp r0, #0
	beq _02156254
	mov r3, #2
	mov r0, r7
	mov r1, r4
	mov r2, #1
	str r3, [r7, #0x6a0]
	bl Boss1__SetAnimation
	b _02156254
_02156140:
	mov r1, #6
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	ldr r1, [sp, #0x2c]
	mov r0, r7
	mov r2, #0
	bl Boss1__SetAnimation
	b _02156254
_02156160:
	mov r1, #0
	str r1, [ip, #0x404]
	bl Boss1__CheckAnimFinished
	cmp r0, #0
	beq _02156254
	mov r3, #1
	mov r0, r7
	mov r1, r5
	mov r2, #0
	str r3, [r7, #0x6a0]
	bl Boss1__SetAnimation
	b _02156254
_02156190:
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _02156254
_0215619C: // jump table
	b _021561B8 // case 0
	b _021561B8 // case 1
	b _02156208 // case 2
	b _02156228 // case 3
	b _021561D8 // case 4
	b _02156254 // case 5
	b _021561B8 // case 6
_021561B8:
	mov r1, #4
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	ldr r1, [sp, #0x24]
	mov r0, r7
	mov r2, #0
	bl Boss1__SetAnimation
	b _02156254
_021561D8:
	mov r1, #0
	str r1, [ip, #0x404]
	bl Boss1__CheckAnimFinished
	cmp r0, #0
	beq _02156254
	ldr r1, [sp, #0x28]
	mov r3, #5
	mov r0, r7
	mov r2, #1
	str r3, [r7, #0x6a0]
	bl Boss1__SetAnimation
	b _02156254
_02156208:
	mov r1, #3
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	ldr r1, [sp, #0x20]
	mov r0, r7
	mov r2, #0
	bl Boss1__SetAnimation
	b _02156254
_02156228:
	mov r1, #0
	str r1, [ip, #0x404]
	bl Boss1__CheckAnimFinished
	cmp r0, #0
	beq _02156254
	ldr r1, [sp, #0x24]
	mov r3, #4
	mov r0, r7
	mov r2, #0
	str r3, [r7, #0x6a0]
	bl Boss1__SetAnimation
_02156254:
	ldr r1, [r7, #0xb4c]
	cmp r4, r1
	ldrne r0, [sp, #0x28]
	cmpne r0, r1
	bne _021562DC
	ldr r0, [r7, #0xab4]
	ldr r1, [r7, #0xe48]
	ldr r0, [r0, #0]
	mov r0, r0, lsl #4
	cmp r1, r0, lsr #16
	mov r4, r0, lsr #0x10
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r4, #0
	cmpne r4, #0x32
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	mov r0, #0x8e
	str r1, [sp]
	sub r1, r0, #0x8f
	str r0, [sp, #4]
	ldr r0, [r7, #0xe50]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r7, #0xe50]
	add r1, r7, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	str r4, [r7, #0xe48]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021562DC:
	mov r0, #0
	add sp, sp, #8
	str r0, [r7, #0xe48]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021562EC:
	ldr r1, [r7, #0x6a0]
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _021563AC
_021562FC: // jump table
	b _021563AC // case 0
	b _02156318 // case 1
	b _0215633C // case 2
	b _02156384 // case 3
	b _02156318 // case 4
	b _02156360 // case 5
	b _02156384 // case 6
_02156318:
	mov r1, #0
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	mov r0, r7
	mov r1, r6
	mov r2, #1
	bl Boss1__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215633C:
	mov r1, #3
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	ldr r1, [sp, #0x20]
	mov r0, r7
	mov r2, #0
	bl Boss1__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02156360:
	mov r1, #6
	str r1, [r7, #0x6a0]
	bl Boss1__EnableAnimBlending
	ldr r1, [sp, #0x2c]
	mov r0, r7
	mov r2, #0
	bl Boss1__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02156384:
	bl Boss1__CheckAnimFinished
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r3, #0
	mov r0, r7
	mov r1, r6
	mov r2, #1
	str r3, [r7, #0x6a0]
	bl Boss1__SetAnimation
_021563AC:
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL Boss1__Func_21563B4(Boss1 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x2c
	mov r4, r0
	ldr r0, [r4, #0x6a4]
	add r5, r4, #0x298
	cmp r0, #0
	addeq sp, sp, #0x2c
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	add r0, r5, #0x400
	bl Boss1__Func_2155D14
	ldr r1, [r4, #0x6a8]
	cmp r1, #0
	beq _021563F4
	cmp r0, #2
	beq _02156400
_021563F4:
	cmp r1, #0
	cmpeq r0, #0
	bne _0215640C
_02156400:
	add sp, sp, #0x2c
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, pc}
_0215640C:
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02156474
_02156418: // jump table
	b _02156428 // case 0
	b _02156458 // case 1
	b _02156440 // case 2
	b _02156468 // case 3
_02156428:
	ldr r1, [r5, #0x400]
	ldr r0, =0x00141BB2
	cmp r1, r0
	movlt r6, #0
	movge r6, #1
	b _02156474
_02156440:
	ldr r1, [r5, #0x400]
	ldr r0, =0x005FAAE6
	cmp r1, r0
	movlt r6, #0
	movge r6, #1
	b _02156474
_02156458:
	cmp r1, #0
	movne r6, #1
	moveq r6, #0
	b _02156474
_02156468:
	cmp r1, #0
	movne r6, #0
	moveq r6, #1
_02156474:
	cmp r6, #0
	ldr r1, [r5, #0x404]
	bne _021564A8
	cmp r1, #0
	ble _02156498
	ldr r0, [r4, #0x6b0]
	sub r0, r1, r0
	str r0, [r5, #0x404]
	b _021564C8
_02156498:
	ldr r0, [r4, #0x6ac]
	sub r0, r1, r0
	str r0, [r5, #0x404]
	b _021564C8
_021564A8:
	cmp r1, #0
	ldrge r0, [r4, #0x6ac]
	addge r0, r1, r0
	strge r0, [r5, #0x404]
	bge _021564C8
	ldr r0, [r4, #0x6b0]
	add r0, r1, r0
	str r0, [r5, #0x404]
_021564C8:
	ldr r1, [r4, #0x6b4]
	ldr r0, [r5, #0x404]
	rsb r2, r1, #0
	cmp r0, r2
	blt _021564E8
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_021564E8:
	str r2, [r5, #0x404]
	add r1, sp, #0x1c
	str r1, [sp]
	add r0, sp, #0x18
	str r0, [sp, #4]
	add r1, sp, #0x14
	str r1, [sp, #8]
	add r0, sp, #0x10
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x3a8]
	add r1, sp, #0x28
	add r2, sp, #0x24
	add r3, sp, #0x20
	bl Boss1__Func_2155FB0
	ldr r1, [sp, #0x1c]
	mov r0, r4
	str r1, [sp]
	ldr r1, [sp, #0x18]
	str r1, [sp, #4]
	ldr r1, [sp, #0x14]
	str r1, [sp, #8]
	ldr r1, [sp, #0x10]
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x20]
	bl Boss1__Func_2156094
	mov r0, #0
	add sp, sp, #0x2c
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL Boss1__Func_2156568(Boss1 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x2c
	mov r7, r0
	add r4, r7, #0x298
	add r0, r4, #0x400
	mov r5, #0
	bl Boss1__Func_2155D14
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _021566DC
_02156590: // jump table
	b _021565A0 // case 0
	b _02156678 // case 1
	b _02156600 // case 2
	b _02156678 // case 3
_021565A0:
	ldr r6, [r4, #0x400]
	ldr r2, [r4, #0x404]
	ldr r0, [r7, #0x6b0]
	ldr r1, =gPlayer
	str r0, [sp]
	ldr r3, [r7, #0x6b4]
	mov r0, r6
	str r3, [sp, #4]
	ldr r3, [r7, #0x6b8]
	str r3, [sp, #8]
	ldr r1, [r1, #0]
	ldr r3, [r7, #0x6ac]
	ldr r1, [r1, #0x44]
	bl BossHelpers__Math__Func_20392BC
	ldr r1, =gPlayer
	str r0, [r4, #0x404]
	ldr r0, [r1, #0]
	ldr r0, [r0, #0x44]
	subs r1, r0, r6
	ldr r0, [r7, #0x6b8]
	rsbmi r1, r1, #0
	cmp r1, r0
	movlt r5, #1
	b _021566DC
_02156600:
	ldr r2, [r4, #0x404]
	ldr ip, [r4, #0x400]
	ldr r1, [r7, #0x6b0]
	ldr r0, =0xFFB470CC
	str r1, [sp]
	ldr r1, [r7, #0x6b4]
	ldr r3, =gPlayer
	str r1, [sp, #4]
	ldr r6, [r7, #0x6b8]
	ldr r1, =0x00283764
	str r6, [sp, #8]
	add r0, ip, r0
	sub r6, r1, r0
	ldr r3, [r3, #0]
	mov r0, r6
	ldr r1, [r3, #0x44]
	ldr r3, [r7, #0x6ac]
	rsb r2, r2, #0
	bl BossHelpers__Math__Func_20392BC
	rsb r1, r0, #0
	ldr r0, =gPlayer
	str r1, [r4, #0x404]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	subs r1, r0, r6
	ldr r0, [r7, #0x6b8]
	rsbmi r1, r1, #0
	cmp r1, r0
	movlt r5, #1
	b _021566DC
_02156678:
	cmp r0, #1
	ldreq r1, =0x0039E34C
	ldr r0, [r4, #0x400]
	ldrne r1, =0x00857280
	cmp r0, r1
	ldr r1, [r4, #0x404]
	bge _021566BC
	cmp r1, #0
	ble _021566AC
	ldr r0, [r7, #0x6b0]
	sub r0, r1, r0
	str r0, [r4, #0x404]
	b _021566DC
_021566AC:
	ldr r0, [r7, #0x6ac]
	sub r0, r1, r0
	str r0, [r4, #0x404]
	b _021566DC
_021566BC:
	cmp r1, #0
	ldrge r0, [r7, #0x6ac]
	addge r0, r1, r0
	strge r0, [r4, #0x404]
	bge _021566DC
	ldr r0, [r7, #0x6b0]
	add r0, r1, r0
	str r0, [r4, #0x404]
_021566DC:
	ldr r1, [r7, #0x6b4]
	ldr r0, [r4, #0x404]
	rsb r2, r1, #0
	cmp r0, r2
	blt _021566FC
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_021566FC:
	str r2, [r4, #0x404]
	add r1, sp, #0x1c
	str r1, [sp]
	add r0, sp, #0x18
	str r0, [sp, #4]
	add r1, sp, #0x14
	str r1, [sp, #8]
	add r0, sp, #0x10
	str r0, [sp, #0xc]
	ldr r0, [r7, #0x3a8]
	add r1, sp, #0x28
	add r2, sp, #0x24
	add r3, sp, #0x20
	bl Boss1__Func_2155FB0
	ldr r1, [sp, #0x1c]
	mov r0, r7
	str r1, [sp]
	ldr r1, [sp, #0x18]
	str r1, [sp, #4]
	ldr r1, [sp, #0x14]
	str r1, [sp, #8]
	ldr r1, [sp, #0x10]
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x20]
	bl Boss1__Func_2156094
	mov r0, r5
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss1__NeckRenderCallback(NNSG3dRS *context, void *userData)
{
#ifdef NON_MATCHING
    Boss1 *boss = (Boss1 *)userData;

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0xa8
	mov r4, r1
	ldr r0, [r4, #0x6c0]
	cmp r0, #0
	addeq sp, sp, #0xa8
	ldmeqia sp!, {r4, pc}
	add r0, sp, #0x78
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	add r0, sp, #0x78
	mov r1, r0
	bl Unknown2066510__NormalizeScale
	ldr r0, =gPlayer
	add r1, sp, #0x9c
	ldr r0, [r0, #0]
	add r2, sp, #0x60
	add r0, r0, #0x1b0
	bl VEC_Subtract
	add r0, sp, #0x60
	mov r1, r0
	bl VEC_Normalize
	add r2, sp, #0x60
	add r0, sp, #0x90
	mov r1, #0x2000
	mov r3, r2
	bl Unknown2066510__Func_2066B94
	ldr r0, =Boss1__neckUpVector
	add r3, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	add r1, sp, #0x60
	add r2, sp, #0x48
	bl VEC_CrossProduct
	add r0, sp, #0x48
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0x60
	add r1, sp, #0x48
	add r2, sp, #0x54
	bl VEC_CrossProduct
	add r0, sp, #0x9c
	add ip, r4, #0x600
	add r3, sp, #0x6c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrsh r0, [ip, #0xc4]
	add r0, r0, #0x44
	strh r0, [ip, #0xc4]
	ldrsh r2, [ip, #0xc4]
	cmp r2, #0x1000
	blt _02156888
	add r4, sp, #0x48
	add lr, sp, #0x18
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	mov r0, #0x1000
	strh r0, [ip, #0xc4]
	b _02156898
_02156888:
	add r0, sp, #0x78
	add r1, sp, #0x48
	add r3, sp, #0x18
	bl Unknown2066510__LerpMtx43
_02156898:
	add r1, sp, #0x18
	mov r0, #0x17
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	ldr r3, =0x000034CC
	add r1, sp, #0
	mov r0, #0x1b
	mov r2, #3
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0xa8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

fx32 Boss1__GetFrame(Boss1 *work)
{
    return work->aniBossMain.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame;
}

void Boss1__SetAnimation(Boss1 *work, u16 animID, BOOL playOnce)
{
    if (playOnce)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    else
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

    BossHelpers__SetAnimation(&work->aniBossMain.ani, B3D_ANIM_JOINT_ANIM, work->aniBossMain.resources[B3D_RESOURCE_JOINT_ANIM], animID, NULL, FALSE);
    BossHelpers__SetAnimation(&work->aniBossMain.ani, B3D_ANIM_VIS_ANIM, work->aniBossMain.resources[B3D_RESOURCE_VIS_ANIM], animID, NULL, FALSE);

    work->aniBossMain.ani.speedMultiplier = FLOAT_TO_FX32(1.0);
    work->animID                          = animID;
}

BOOL Boss1__CheckAnimFinished(Boss1 *work)
{
    return work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH;
}

void Boss1__EnableAnimBlending(Boss1 *work)
{
    work->aniBossMain.ani.animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
    work->aniBossMain.ani.ratio[B3D_ANIM_JOINT_ANIM] = FLOAT_TO_FX32(0.033203125);
}

void Boss1__HandleRotation(Boss1 *work)
{
    u16 angle = (work->angle + work->field_6BE);
    MTX_RotY33(work->aniBossMain.ani.work.rotation.nnMtx, SinFX((s32)angle), CosFX((s32)angle));
}

void Boss1__ConfigureCollider(Boss1 *work, Boss1ColliderMode mode)
{
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    for (s32 i = 0; i < 10; i++)
    {
        work->bossColliders[i].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    }

    switch (mode)
    {
        case BOSS1_COLLIDER_BITE_ATTACK:
        case BOSS1_COLLIDER_HEADSLAM_ATTACK:
            work->bossColliders[2].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            break;

        case BOSS1_COLLIDER_BITE_IDLE:
        case BOSS1_COLLIDER_HEADSLAM_IDLE:
            work->bossColliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            work->bossColliders[1].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            break;

        case BOSS1_COLLIDER_CHARGE:
            work->bossColliders[3].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            work->bossColliders[4].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            break;

        case BOSS1_COLLIDER_DEACTIVATED:
            work->bossColliders[5].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            work->bossColliders[6].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            break;

        case BOSS1_COLLIDER_CHARGE_DEACTIVATED:
            work->bossColliders[7].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            work->bossColliders[8].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            work->bossColliders[9].flag |= OBS_RECT_WORK_FLAG_ENABLED;
            break;
    }
}

NONMATCH_FUNC void Boss1__HandleCameraOrientation(Boss1 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r1, r6, #0x600
	mov r0, #1
	ldrh r4, [r1, #0xbc]
	bl BossArena__GetCamera
	bl BossArena__GetAngleTarget
	ldr r1, =gPlayer
	ldr r2, [r6, #0x44]
	ldr r3, [r1, #0]
	ldr r1, =0x00283764
	ldr r3, [r3, #0x44]
	mov r5, r0
	sub r0, r3, r2
	bl FX_Div
	mov r1, #0x1000
	rsb r1, r1, #0
	cmp r0, r1
	movlt r0, r1
	blt _02156B1C
	cmp r0, #0x1000
	movgt r0, #0x1000
_02156B1C:
	mov r0, r0, lsl #0xd
	add r0, r4, r0, asr #12
	ldr r1, [r6, #0x3a8]
	mov r0, r0, lsl #0x10
	cmp r1, #1
	mov r4, r0, lsr #0x10
	beq _02156B74
	cmp r4, #0x2000
	bls _02156B58
	cmp r4, #0x6000
	bhs _02156B58
	cmp r5, #0x4000
	movlo r4, #0x2000
	movhs r4, #0x6000
	b _02156B74
_02156B58:
	cmp r4, #0xa000
	bls _02156B74
	cmp r4, #0xe000
	bhs _02156B74
	cmp r5, #0xc000
	movlo r4, #0xa000
	movhs r4, #0xe000
_02156B74:
	cmp r4, #0x4000
	bls _02156BAC
	cmp r4, #0xc000
	bhs _02156BAC
	ldr r1, =gPlayer
	mov r3, #0x20
	ldr r0, [r1, #0]
	mov r2, #0x10
	add r0, r0, #0x700
	strh r3, [r0, #0x26]
	ldr r0, [r1, #0]
	add r0, r0, #0x700
	strh r2, [r0, #0x28]
	b _02156BD0
_02156BAC:
	ldr r1, =gPlayer
	mov r3, #0x10
	ldr r0, [r1, #0]
	mov r2, #0x20
	add r0, r0, #0x700
	strh r3, [r0, #0x26]
	ldr r0, [r1, #0]
	add r0, r0, #0x700
	strh r2, [r0, #0x28]
_02156BD0:
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, r4
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, r4
	bl BossArena__SetAngleTarget
	ldr r0, =Boss1Stage__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x378]
	ldr r2, [r6, #0x368]
	rsb r0, r0, #0
	ldr r1, [r6, #0x48]
	add r0, r0, #0x14000
	sub r5, r1, r0
	ldr r0, =0x000004CC
	mov r1, #0
	umull r4, r3, r5, r0
	adds r4, r4, #0x800
	mla r3, r5, r1, r3
	mov r1, r5, asr #0x1f
	mla r3, r1, r0, r3
	adc r1, r3, #0
	mov r3, r4, lsr #0xc
	ldr r0, [r2, #0x3b4]
	orr r3, r3, r1, lsl #20
	cmp r0, #0
	sub r4, r3, #0x14000
	bne _02156C60
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, [r6, #0x6c8]
	add r1, r4, r1
	bl BossArena__SetAmplitudeYTarget
_02156C60:
	ldr r0, [r6, #0x368]
	ldr r0, [r0, #0x3b4]
	cmp r0, #4
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, [r6, #0x6cc]
	add r1, r4, r1
	bl BossArena__SetAmplitudeYTarget
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u16 Boss1__GetPlayerBounceAngle(OBS_RECT_WORK *collider, fx32 bossX, fx32 bossY, Player *player, u16 angleRange, u16 angle)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrsh ip, [r0]
	ldrsh r2, [r0, #6]
	ldr r0, [r0, #0x1c]
	mov ip, ip, lsl #0xc
	mov lr, ip
	cmp r0, #0
	mov r2, r2, lsl #0xc
	beq _02156CCC
	ldr r0, [r0, #0x20]
	tst r0, #1
	rsbne lr, r2, #0
	rsbne r2, ip, #0
_02156CCC:
	add lr, lr, r1
	add ip, r2, r1
	sub r0, ip, lr
	mov r1, r0, asr #1
	ldr r2, [r3, #0x44]
	add r0, lr, ip
	sub r2, r2, r0, asr #1
	rsb r0, r1, #0
	cmp r2, r0
	blt _02156D00
	cmp r2, r1
	movgt r2, r1
	mov r0, r2
_02156D00:
	bl FX_Div
	mov r0, r0, lsl #0x10
	ldrh r1, [sp, #0xc]
	mov r2, r0, asr #0x10
	ldrh ip, [sp, #8]
	mov r0, r1, lsl #0xc
	smull r2, r1, r0, r2
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r0, r1, lsl #4
	mov r1, ip, lsl #0x10
	mov r3, r1, asr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	rsb r2, r3, #0
	cmp r2, r1, asr #16
	mov r1, r1, asr #0x10
	cmplt r1, r3
	ldmgeia sp!, {r3, pc}
	cmp r1, #0
	movgt r0, ip
	rsble r0, ip, #0
	movle r0, r0, lsl #0x10
	movle r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

s32 Boss1__GetNextAttack(Boss1Stage *stage, Boss1AttackConfig *state)
{
    Boss1Phase phase = Boss1Stage__GetBossPhase(stage);
    if (state->attackTable == NULL || state->id >= 4 || phase != state->phase)
    {
        s32 id = mtMathRandRepeat(4);

        state->id    = 0;
        state->phase = phase;

        s32 **tables = Boss1__attackTablesForPhase[state->phase];
        if (state->attackTable == tables[id])
            id = (id + 1) & 3;

        state->attackTable = tables[id];
    }

    return state->attackTable[state->id++];
}

void Boss1__ConfigureNeck(Boss1 *work, BOOL enabled)
{
    if (!work->longNeckActive || !enabled)
    {
        work->longNeckActive     = enabled;
        work->neckMtxLerpPercent = 0;
    }
}

void Boss1__Action_Hit(Boss1 *work)
{
    BossHelpers__SetPaletteAnimations(work->aniPalette, 24, 1, TRUE);
    work->paletteFlashTimer = 120;
}

void Boss1__HandlePalette(Boss1 *work)
{
    if (work->paletteFlashTimer != 0)
    {
        work->paletteFlashTimer--;
        if (work->paletteFlashTimer == 0)
            BossHelpers__SetPaletteAnimations(work->aniPalette, 24, 0, FALSE);
    }
}

void Boss1__State_Active(Boss1 *work)
{
    work->bossState(work);

    if (work->field_694 == 0)
    {
        Boss1__Func_2155CF8(&work->field_698);
        Boss1__Func_2155D64(&work->field_698, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z, &work->angle);
    }

    Boss1__HandleRotation(work);

    if (work->actionState != BOSS1_ACTION_DESTROY)
        Boss1__HandleCameraOrientation(work);

    Boss1__HandlePalette(work);
}

void Boss1__Destructor(Task *task)
{
    Boss1 *work = TaskGetWork(task, Boss1);

    BossHelpers__ReleaseAnimation(&work->aniBossMain);
    AnimatorMDL__Release(&work->aniBossMain.ani);

    BossHelpers__ReleaseAnimation(&work->aniBossSub1);
    AnimatorMDL__Release(&work->aniBossSub1.ani);

    BossHelpers__ReleaseAnimation(&work->aniBossSub2);
    AnimatorMDL__Release(&work->aniBossSub2.ani);

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_AUTO;

    for (s32 i = 0; i < 24; i++)
    {
        ReleasePaletteAnimator(&work->aniPalette[i]);
    }

    FreeSndHandle(work->sndHandle[0]);
    FreeSndHandle(work->sndHandle[1]);
    FreeSndHandle(work->sndHandle[2]);

    GameObject__Destructor(task);
}

void Boss1__Draw(void)
{
    Boss1 *work = TaskGetWorkCurrent(Boss1);

    StageTask__Draw3D(&work->gameWork.objWork, &work->aniBossMain.ani.work);
    BossHelpers__Model__SetMatrixMode(MTXSTACK_WEAK, &work->mtxWeakPoint);
    BossHelpers__Model__SetMatrixMode(MTXSTACK_BODY_NECK, &work->mtxBodyNeck);

    AnimatorMDL *aniSub1        = &work->aniBossSub1.ani;
    aniSub1->work.translation   = work->gameWork.objWork.position;
    aniSub1->work.translation.y = work->stage->field_378 + FLOAT_TO_FX32(5.0);

    aniSub1->work.rotation         = work->aniBossMain.ani.work.rotation;
    aniSub1->work.rotation.m[1][0] = FLOAT_TO_FX32(0.0);
    aniSub1->work.rotation.m[1][1] = FLOAT_TO_FX32(1.0);
    aniSub1->work.rotation.m[1][2] = FLOAT_TO_FX32(0.0);

    VEC_CrossProduct((VecFx32 *)aniSub1->work.rotation.m[1], (VecFx32 *)aniSub1->work.rotation.m[2], (VecFx32 *)aniSub1->work.rotation.m[0]);

    AnimatorMDL__Draw(aniSub1);
    AnimatorMDL__Draw(&work->aniBossSub2.ani);

    for (s32 i = 0; i < 24; i++)
    {
        AnimatePalette(&work->aniPalette[i]);
        DrawAnimatedPalette(&work->aniPalette[i]);
    }
}

void Boss1__Collide(void)
{
    Boss1 *work = TaskGetWorkCurrent(Boss1);

    if (!IsStageTaskDestroyedAny(&work->gameWork.objWork) && (work->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
    {
        fx32 x;
        fx32 y;
        fx32 z;

        y = -work->mtxBodyNeck.m[3][1];
        z = work->mtxBodyNeck.m[3][2];
        x = work->mtxBodyNeck.m[3][0];

        OBS_RECT_WORK *collider = &work->bossColliders[0];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[1];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[2];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[3];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[4];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            StageTask__HandleCollider(collider->parent, collider);

        collider = &work->bossColliders[5];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[6];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[7];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[8];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            BossHelpers__Collision__HandleColliderSimple(collider, x, y, z);

        collider = &work->bossColliders[9];
        if ((collider->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            StageTask__HandleCollider(collider->parent, collider);
    }
}

void Boss1__OnDefend_Bite(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss = (Boss1 *)rect1->parent;

    boss->action.bite.didCollide = TRUE;
}

void Boss1__HandleCoreBiteBounce(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss    = (Boss1 *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    s16 angle = 2
                * (s16)Boss1__GetPlayerBounceAngle(rect2, boss->gameWork.objWork.position.x + FX32_FROM_WHOLE(rect2->rect.pos.x),
                                                   boss->gameWork.objWork.position.y + FX32_FROM_WHOLE(rect2->rect.pos.y), player, 910, FLOAT_DEG_TO_IDX(30.0));

    switch (boss->actionState)
    {
        case BOSS1_ACTION_BITE:
            if (Boss1__Func_2155D14(&boss->field_698) == 2)
            {
                switch (boss->action.bite.type)
                {
                    case 1:
                        angle -= FLOAT_DEG_TO_IDX(30.0);
                        break;

                    case 2:
                        angle += FLOAT_DEG_TO_IDX(30.0);
                        break;
                }
            }
            else
            {
                switch (boss->action.bite.type)
                {
                    case 1:
                        angle += FLOAT_DEG_TO_IDX(30.0);
                        break;

                    case 2:
                        angle -= FLOAT_DEG_TO_IDX(30.0);
                        break;
                }
            }
            break;

        case BOSS1_ACTION_DAMAGE:
            if (Boss1__Func_2155D14(&boss->field_698) == 2)
            {
                switch (boss->action.damage.type)
                {
                    case 1:
                        angle -= FLOAT_DEG_TO_IDX(30.0);
                        break;

                    case 2:
                        angle += FLOAT_DEG_TO_IDX(30.0);
                        break;
                }
            }
            else
            {
                switch (boss->action.damage.type)
                {
                    case 1:
                        angle += FLOAT_DEG_TO_IDX(30.0);
                        break;

                    case 2:
                        angle -= FLOAT_DEG_TO_IDX(30.0);
                        break;
                }
            }
            break;
    }

    angle = MTM_MATH_CLIP_S16(angle, -FLOAT_DEG_TO_IDX(30.0), FLOAT_DEG_TO_IDX(30.0));

    fx32 sin                   = SinFX((s32)(u16)(s32)(s16)(s32)(s16)angle);
    player->objWork.velocity.y = -FLOAT_TO_FX32(4.5);
    player->objWork.velocity.x = MultiplyFX(FLOAT_TO_FX32(2.0), sin);
    player->objWork.velocity.x = MultiplyFX(player->objWork.velocity.x, Boss1Stage__GetKnockbackPower(boss->stage));
}

void Boss1__ChargeAttack_Recoil(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss    = (Boss1 *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    s32 angle = (s16)Boss1__GetPlayerBounceAngle(rect2, boss->gameWork.objWork.position.x + FX32_FROM_WHOLE(rect2->rect.pos.x),
                                                 boss->gameWork.objWork.position.y + FX32_FROM_WHOLE(rect2->rect.pos.y), player, 0, FLOAT_DEG_TO_IDX(75.0))
                >> 1;

    if (boss->action.charge.direction != 0)
        angle += FLOAT_DEG_TO_IDX(37.5);
    else
        angle -= FLOAT_DEG_TO_IDX(37.5);

    fx32 sin                   = SinFX((u16)(s32)(u16)(s32)(s16)angle);
    player->objWork.velocity.y = -FLOAT_TO_FX32(4.0);
    player->objWork.velocity.x = MultiplyFX(FLOAT_TO_FX32(2.5), sin);
    player->objWork.velocity.x = MultiplyFX(player->objWork.velocity.x, Boss1Stage__GetChargeRecoilPower(boss->stage));
    Boss1__HandleChargeKnockback(boss);
}

void Boss1__OnDefend_Core(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss    = (Boss1 *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    fx32 x = boss->gameWork.objWork.position.x + FX32_FROM_WHOLE(rect2->rect.pos.x);
    fx32 y = boss->gameWork.objWork.position.y + FX32_FROM_WHOLE(rect2->rect.pos.y);

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        switch (boss->actionState)
        {
            case BOSS1_ACTION_BITE:
                Boss1__Action_Damage(boss, boss->action.bite.type, Boss1Stage__GetBiteDamageDuration(boss->stage));
                break;

            case BOSS1_ACTION_HEADSLAM:
                Boss1__Action_ChargeDamage(boss, Boss1Stage__GetChargeDamageDuration(boss->stage));
                break;

            case BOSS1_ACTION_DAMAGE:
                s16 duration = boss->action.damage.duration - boss->action.damage.timer;
                if (duration < 0)
                    duration = 0;
                Boss1__Action_Damage(boss, boss->action.damage.type, duration);
                break;

            case BOSS1_ACTION_CHARGE_DAMAGE:
                break;

            default:
                return;
        }

        Player__Action_AttackRecoil(player);
        switch (boss->actionState)
        {
            case BOSS1_ACTION_BITE:
            case BOSS1_ACTION_DAMAGE:
                Boss1__HandleCoreBiteBounce(rect1, rect2);
                break;

            case BOSS1_ACTION_HEADSLAM:
            case BOSS1_ACTION_CHARGE_DAMAGE:
                fx32 sin                   = SinFX((s32)(u16)(s32)(s16)(s32)((s16)(s32)Boss1__GetPlayerBounceAngle(rect2, x, y, player, 0x38E, FLOAT_DEG_TO_IDX(30.0)) << 1));
                player->objWork.velocity.y = -FLOAT_TO_FX32(5.5);
                player->objWork.velocity.x = MultiplyFX(FLOAT_TO_FX32(2.0), sin);
                player->objWork.velocity.x = MultiplyFX(player->objWork.velocity.x, Boss1Stage__GetKnockbackPower(boss->stage));
                break;
        }

        Boss1Phase phase = Boss1Stage__GetBossPhase(boss->stage);
        boss->stage->health -= MultiplyFX(Boss1Stage__GetBaseDamageValue(), Boss1Stage__GetDamageModifier(boss->stage));
        if (boss->stage->health <= HUD_BOSS_HEALTH_NONE)
        {
            boss->stage->health = HUD_BOSS_HEALTH_MIN;
            Boss1__Action_Deactivate(boss);

            if (player->objWork.velocity.x <= 0)
                player->objWork.velocity.x = -FLOAT_TO_FX32(6.0);
            else
                player->objWork.velocity.x = FLOAT_TO_FX32(6.0);

            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TODOME_HIT);
        }
        else
        {
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_DAMAGE);
            NNS_SndPlayerSetTrackPitch(&defaultSfxPlayer, 0xFFFF, Boss1Stage__GetCappedComboCount(boss->stage) << 6);
        }

        if (phase != Boss1Stage__GetBossPhase(boss->stage))
        {
            boss->changedBossPhase = TRUE;

            if (Boss1__Func_2155D14(&boss->field_698) == 0)
                boss->field_6A8 = 1;
            else
                boss->field_6A8 = 0;
        }

        UpdateBossHealthHUD(boss->stage->health);
        Boss1__Action_Hit(boss);
        BossFX__CreateHitA(BOSSFX3D_FLAG_NONE, player->objWork.position.x, -player->objWork.position.y, player->objWork.position.z);
        Boss1Stage__IncrementHitCount(boss->stage);
    }
}

void Boss1__OnDefend_Core_Charging(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss;
    Player *player;

    player = (Player *)rect1->parent;
    boss   = (Boss1 *)rect2->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            Boss1__OnDefend_Invulnerable(rect1, rect2);
        }
        else
        {
            Player__Action_AttackRecoil(player);
            Boss1__ChargeAttack_Recoil(rect1, rect2);

            Boss1Phase phase = Boss1Stage__GetBossPhase(boss->stage);

            fx32 multiplier = Boss1Stage__GetDamageModifier(boss->stage);
            fx32 damage     = Boss1Stage__GetBaseDamageValue();
            boss->stage->health -= MultiplyFX(MultiplyFX(damage, multiplier), Boss1Stage__GetDmgMultiplier2(boss->stage));

            if (boss->stage->health <= HUD_BOSS_HEALTH_NONE)
            {
                boss->stage->health = HUD_BOSS_HEALTH_MIN;

                Boss1__Action_ChargeDeactivate(boss, boss->action.charge.direction);

                if (player->objWork.velocity.x <= 0)
                    player->objWork.velocity.x = -FLOAT_TO_FX32(6.0);
                else
                    player->objWork.velocity.x = FLOAT_TO_FX32(6.0);

                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TODOME_HIT);
            }
            else
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_DAMAGE);
                NNS_SndPlayerSetTrackPitch(&defaultSfxPlayer, 0xFFFF, Boss1Stage__GetCappedComboCount(boss->stage) << 6);
            }

            if (phase != Boss1Stage__GetBossPhase(boss->stage))
            {
                boss->changedBossPhase = TRUE;
                if (Boss1__Func_2155D14(&boss->field_698) == 0)
                    boss->field_6A8 = 1;
                else
                    boss->field_6A8 = 0;
            }

            UpdateBossHealthHUD(boss->stage->health);
            Boss1__Action_Hit(boss);
            BossFX__CreateHitA(BOSSFX3D_FLAG_NONE, player->objWork.position.x, -player->objWork.position.y, player->objWork.position.z);
        }

        Boss1Stage__IncrementHitCount(boss->stage);
    }
}

void Boss1__OnDefend_LastHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss = (Boss1 *)rect2->parent;

    if (rect1->parent->objType == STAGE_OBJ_TYPE_PLAYER)
    {
        boss->stage->health = 0;
        UpdateBossHealthHUD(boss->stage->health);
        Boss1__Action_Destroy(boss);
    }
}

void Boss1__OnDefend_Invulnerable(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player = (Player *)rect1->parent;
    Boss1 *boss    = (Boss1 *)rect2->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        fx32 left  = FX32_FROM_WHOLE(rect2->rect.left);
        fx32 right = FX32_FROM_WHOLE(rect2->rect.right);
        if ((boss->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            left  = -FX32_FROM_WHOLE(rect2->rect.right);
            right = -FX32_FROM_WHOLE(rect2->rect.left);
        }

        fx32 x  = player->objWork.position.x;
        fx32 x2 = boss->mtxBodyNeck.m[3][0];

        if (x2 < x)
        {
            player->objWork.flow.x = x2 + right - (x + FX32_FROM_WHOLE(rect1->rect.left));
            if (player->objWork.flow.x < 0)
                player->objWork.flow.x = 0;
        }
        else
        {
            player->objWork.flow.x = x2 + left - (x + FX32_FROM_WHOLE(rect1->rect.right));
            if (player->objWork.flow.x > 0)
                player->objWork.flow.x = 0;
        }

        if (boss->actionState == BOSS1_ACTION_CHARGE)
        {
            player->overSpeedLimitTimer = 20;

            fx32 velX;
            if ((boss->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                velX = -FLOAT_TO_FX32(4.0);
            else
                velX = FLOAT_TO_FX32(4.0);

            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
                player->objWork.velocity.x = velX;
            else
                player->objWork.groundVel = velX;

            BossFX__CreateHitB(0, player->objWork.position.x, -player->objWork.position.y, player->objWork.position.z);
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UNWEAK);

            if ((boss->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && (boss->gameWork.objWork.velocity.x > 0)
                || (boss->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && (boss->gameWork.objWork.velocity.x < 0))
            {
                boss->gameWork.objWork.velocity.x = MultiplyFX(819, boss->gameWork.objWork.velocity.x);
            }
        }
    }
}

void Boss1__OnDefend_Harmful(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss1 *boss    = (Boss1 *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        Player__Action_AttackRecoil(player);

        if (boss->action.charge.direction != 0)
            player->objWork.velocity.x = FLOAT_TO_FX32(4.0);
        else
            player->objWork.velocity.x = -FLOAT_TO_FX32(4.0);

        player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
        player->objWork.flow.y     = boss->gameWork.objWork.position.y + FX32_FROM_WHOLE(rect2->rect.top) - (player->objWork.position.y + FX32_FROM_WHOLE(rect1->rect.bottom));
        BossFX__CreateHitB(0, player->objWork.position.x, -player->objWork.position.y, player->objWork.position.z);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UNWEAK);

        if (boss->actionState == BOSS1_ACTION_CHARGE)
        {
            if (boss->action.charge.direction != 0)
            {
                if (boss->gameWork.objWork.velocity.x > -FLOAT_TO_FX32(1.0))
                    boss->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(1.0);
            }
            else
            {
                if (boss->gameWork.objWork.velocity.x < FLOAT_TO_FX32(1.0))
                    boss->gameWork.objWork.velocity.x = FLOAT_TO_FX32(1.0);
            }
        }
    }
}

void Boss1__Action_Init(Boss1 *work)
{
    work->actionState = BOSS1_ACTION_INIT;
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);
    work->bossState = Boss1__BossState_StartInitWait;
}

void Boss1__Action_Idle(Boss1 *work, u16 duration)
{
    MI_CpuClear16(&work->action.idle, sizeof(work->action.idle));

    work->action.idle.duration = duration;
    work->actionState           = BOSS1_ACTION_IDLE;

    work->bossState = Boss1__BossState_StartIdle;
    work->bossState(work);
}

void Boss1__Action_Bite(Boss1 *work, s32 type, const Boss1BiteConfig *config)
{
    MI_CpuClear16(&work->action.bite, sizeof(work->action.bite));

    work->action.bite.type   = type;
    work->action.bite.config = config;
    work->actionState         = BOSS1_ACTION_BITE;

    work->bossState = Boss1__BossState_InitBite;
    work->bossState(work);
}

void Boss1__Action_Charge(Boss1 *work, s32 direction, s32 a3)
{
    MI_CpuClear16(&work->action.charge, sizeof(work->action.charge));

    work->action.charge.config    = Boss1Stage__GetChargeConfig(work->stage);
    work->action.charge.direction = direction;
    work->action.charge.field_C   = a3;
    work->actionState              = BOSS1_ACTION_CHARGE;

    work->bossState = Boss1__BossState_InitCharge;
    work->bossState(work);
}

void Boss1__Action_HeadSlam(Boss1 *work, const Boss1HeadSlamConfig *config)
{
    MI_CpuClear16(&work->action.headSlam, sizeof(work->action.headSlam));

    work->action.headSlam.config = config;
    work->actionState             = BOSS1_ACTION_HEADSLAM;

    work->bossState = Boss1__BossState_InitHeadSlam;
    work->bossState(work);
}

void Boss1__Action_Damage(Boss1 *work, s32 type, u16 duration)
{
    struct Boss1ActionDamage *action = &work->action.damage;

    MI_CpuClear16(action, sizeof(work->action.damage));

    action->type     = type;
    action->duration = duration;
    work->actionState = BOSS1_ACTION_DAMAGE;

    work->bossState = Boss1__BossState_InitDamage;
    work->bossState(work);
}

void Boss1__Action_ChargeDamage(Boss1 *work, u16 duration)
{
    MI_CpuClear16(&work->action.chargeDamage, sizeof(work->action.chargeDamage));

    work->action.chargeDamage.duration = duration;
    work->actionState                   = BOSS1_ACTION_CHARGE_DAMAGE;

    work->bossState = Boss1__BossState_InitChargeDamage;
    work->bossState(work);
}

void Boss1__Action_Jump(Boss1 *work, s32 a2)
{
    MI_CpuClear16(&work->action.jump, sizeof(work->action.jump));

    work->action.jump.field_0 = a2;
    work->actionState          = BOSS1_ACTION_JUMP;

    work->bossState = Boss1__BossState_InitJump;
    work->bossState(work);
}

void Boss1__Action_Drop(Boss1 *work)
{
    work->actionState = BOSS1_ACTION_DROP;

    work->bossState = Boss1__BossState_InitDrop;
    work->bossState(work);
}

void Boss1__Action_Deactivate(Boss1 *work)
{
    work->actionState = BOSS1_ACTION_DEACTIVATE;

    work->bossState = Boss1__BossState_InitDeactivate;
    work->bossState(work);
}

void Boss1__Action_ChargeDeactivate(Boss1 *work, s32 direction)
{
    MI_CpuClear16(&work->action.chargeDeactivate, sizeof(work->action.chargeDeactivate));

    work->action.chargeDeactivate.direction = direction;
    work->actionState                        = BOSS1_ACTION_CHARGE_DEACTIVATE;

    work->bossState = Boss1__BossState_InitChargeDeactivate;
    work->bossState(work);
}

void Boss1__Action_Destroy(Boss1 *work)
{
    work->actionState = BOSS1_ACTION_DESTROY;

    work->bossState = Boss1__BossState_InitDestroyed;
    work->bossState(work);
}

// Boss States
void Boss1__BossState_StartInitWait(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_fw0, TRUE);
    work->bossState = Boss1__BossState_InitWait;
}

void Boss1__BossState_InitWait(Boss1 *work)
{
    if (TitleCard__GetProgress() == TITLECARD_PROGRESS_SHOWING_GO_TEXT)
        work->bossState = Boss1__BossState_StartInit0;
}

void Boss1__BossState_StartInit0(Boss1 *work)
{
    work->gameWork.objWork.userTimer = 0;
    work->bossState                  = Boss1__BossState_Init0;
}

void Boss1__BossState_Init0(Boss1 *work)
{
    if (work->gameWork.objWork.userTimer++ > 30)
        work->bossState = Boss1__BossState_StartInit1;
}

void Boss1__BossState_StartInit1(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_fw1, FALSE);
    work->bossState = Boss1__BossState_Init1;
}

void Boss1__BossState_Init1(Boss1 *work)
{
    if (Boss1__GetFrame(work) == FLOAT_TO_FX32(50.0))
    {
        PlayHandleStageSfx(work->sndHandle[0], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_ROAR);
        DisableSpatialVolume();
        ProcessSpatialVoiceClip(work->sndHandle[0], &work->gameWork.objWork.position);
        EnableSpatialVolume();
        ShakeScreenEx(0x1800, 0x3000, 34);
    }

    if (Boss1__CheckAnimFinished(work))
        Boss1__Action_Idle(work, 0);
}

void Boss1__BossState_StartIdle(Boss1 *work)
{
    work->field_694 = 0;
    Boss1__SetAnimation(work, ANI_bs1_body_fw0, TRUE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->field_698.field_6A0 = 0;
    work->field_6AC           = 0x199;
    work->field_6B0           = 0x333;
    work->field_6B4           = 0x3000;
    work->field_6B8           = 0x46000;
    Boss1__ConfigureNeck(work, TRUE);

    if (Boss1Stage__GetBossPhase(work->stage) >= 2 && work->stage->dropControl.state == 0)
    {
        Boss1__Action_Drop(work);
    }
    else
    {
        if (work->changedBossPhase)
            work->bossState = Boss1__BossState_IdleUnknown;
        else
            work->bossState = Boss1__BossState_IdleChooseAttackDelay;
    }
}

void Boss1__BossState_IdleChooseAttackDelay(Boss1 *work)
{
    struct Boss1ActionIdle *action = &work->action.idle;

    Boss1__Func_2156568(work);

    action->timer++;
    if (action->timer >= action->duration)
        work->bossState = Boss1__BossState_IdleChooseAttack;
}

void Boss1__BossState_IdleUnknown(Boss1 *work)
{
    if (Boss1__Func_21563B4(work))
    {
        work->changedBossPhase = FALSE;
        work->bossState        = Boss1__BossState_IdleChooseAttackDelay;
    }
}

void Boss1__BossState_IdleChooseAttack(Boss1 *work)
{
    switch (Boss1__GetNextAttack(work->stage, &work->attackConfig))
    {
        case 2:
            Boss1__Action_Bite(work, Boss1Stage__GetBiteType(work->stage), Boss1Stage__GetBiteConfig(work->stage));
            break;

        case 3:
            u32 chargeDir = mtMathRandRepeat(2) != 0 ? 1 : 0;
            Boss1__Action_Charge(work, chargeDir, mtMathRandRepeat(2) != 0);
            break;

        case 4:
            Boss1__Action_HeadSlam(work, Boss1Stage__GetHeadSlamConfig(work->stage));
            break;
    }
}

void Boss1__CreateBiteFX(Boss1 *work, struct Boss1ActionBite *config)
{
    Boss1Stage *stage = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);

    fx32 y = GetStageUnknown(stage);
    y += FLOAT_TO_FX32(20.0);
    y = -y;
    y += FLOAT_TO_FX32(50.0);

    BossFX3D *effect = BossFX__CreateRexBite(BOSSFX3D_FLAG_NONE, work->mtxBodyNeck.m[3][0], y, FLOAT_TO_FX32(0.0));

    u32 type = config->type;
    if (config->type == 3)
    {
        switch (config->direction - 1)
        {
            case 1 - 1:
                type = 1;
                break;

            case 2 - 1:
                type = 2;
                break;
        }
    }

    FXMatrix33 mtxRotate;
    switch (type)
    {
        case 1:
            MTX_RotZ33(mtxRotate.nnMtx, SinFX(FLOAT_DEG_TO_IDX(315.0)), CosFX(FLOAT_DEG_TO_IDX(315.0)));
            break;

        case 2:
            MTX_RotZ33(mtxRotate.nnMtx, SinFX(FLOAT_DEG_TO_IDX(45.0)), CosFX(FLOAT_DEG_TO_IDX(45.0)));
            break;

        default:
            MTX_Identity33(mtxRotate.nnMtx);
            break;
    }

    MTX_Concat33(mtxRotate.nnMtx, work->aniBossMain.ani.work.rotation.nnMtx, effect->aniModel.ani.work.rotation.nnMtx);
}

void Boss1__BossState_InitBite(Boss1 *work)
{
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->field_698.unknown2  = 0;
    work->field_698.field_6A0 = 0;
    work->field_6AC           = 0x266;
    work->field_6B0           = 0x400;
    work->field_6B4           = 0x3800;
    work->field_6B8           = 0x28000;

    Boss1__ConfigureNeck(work, TRUE);
    work->bossState = Boss1__BossState_StartBite0;
}

void Boss1__BossState_StartBite0(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_bite0, FALSE);
    work->bossState = Boss1__BossState_Bite0;
}

void Boss1__BossState_Bite0(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartBite1;
        work->bossState(work);
    }
}

void Boss1__BossState_StartBite1(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_bite1, TRUE);
    work->bossState = Boss1__BossState_Bite1;
}

void Boss1__BossState_Bite1(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    BOOL done = FALSE;

    if (Boss1__Func_2156568(work))
        action->unknownTimer++;
    else
        action->unknownTimer = 0;

    action->timer++;

    if (action->config->duration2 <= action->timer)
    {
        action->timer = action->config->duration2;
        if (action->unknownTimer != 0)
            done = TRUE;
    }
    else
    {
        if (action->config->duration1 <= action->timer && action->config->duration3 <= action->unknownTimer)
            done = TRUE;
    }

    if (action->config->duration2 - 1 <= action->timer)
        work->field_6B8 = FLOAT_TO_FX32(20.0);

    if (done)
        work->bossState = Boss1__BossState_StartBite2;
}

void Boss1__BossState_StartBite2(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    fx32 animSpeed = action->config->animSpeed;
    u16 anim;
    switch (action->type)
    {
        case 0:
            anim = ANI_bs1_body_bite2;
            break;

        case 1:
            anim = ANI_bs1_body_bitel2;
            break;

        case 2:
            anim = ANI_bs1_body_biter2;
            break;

        case 3:
            switch (action->direction)
            {
                case 0:

                    anim      = ANI_bs1_body_bitel2;
                    animSpeed = FLOAT_TO_FX32(1.0);
                    break;

                case 1:
                    anim      = ANI_bs1_body_biter2;
                    animSpeed = FLOAT_TO_FX32(1.0);
                    break;

                case 2:
                    anim = ANI_bs1_body_bite2;
                    break;
            }

            action->direction++;
            Boss1__EnableAnimBlending(work);
            break;
    }

    Boss1__SetAnimation(work, anim, FALSE);
    work->aniBossMain.ani.speedMultiplier = animSpeed;
    action->field_20                      = animSpeed > FLOAT_TO_FX32(0.5) ? FLOAT_TO_FX32(24.0) : FLOAT_TO_FX32(20.0);

    // TODO: figure this struct out
    *((u32 *)work->aniBossMain.ani.currentAnimObj[0]->resAnm + 2) |= 1;

    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_BITE_ATTACK);
    Boss1__ConfigureNeck(work, FALSE);

    work->field_698.unknown2 = 0;
    action->didCollide       = FALSE;
    action->playedSfx        = FALSE;
    action->createdFX        = FALSE;
    work->bossState          = Boss1__BossState_Bite2;
}

void Boss1__BossState_Bite2(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    fx32 frame = work->aniBossMain.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame;
    if (!action->field_14 && action->field_20 <= frame && (action->type != 3 || action->direction >= 3))
    {
        Boss1__ConfigureCollider(work, BOSS1_COLLIDER_BITE_IDLE);
        action->field_14 = TRUE;
    }

    if (frame < action->field_20)
    {
        Boss1__ConfigureCollider(work, BOSS1_COLLIDER_BITE_ATTACK);
    }
    else
    {
        if (action->type != 3 || action->direction >= 3)
        {
            Boss1__ConfigureCollider(work, BOSS1_COLLIDER_BITE_IDLE);
            if (action->didCollide)
                work->bossColliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
        }
    }

    if (!action->createdFX && frame >= FLOAT_TO_FX32(12.0))
    {
        Boss1__CreateBiteFX(work, action);
        action->createdFX = TRUE;
    }

    if (!action->playedSfx && frame >= FLOAT_TO_FX32(21.0))
    {
        PlayHandleStageSfx(work->sndHandle[2], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_BITE);
        DisableSpatialVolume();
        ProcessSpatialVoiceClip(work->sndHandle[2], &work->gameWork.objWork.position);
        EnableSpatialVolume();
        action->playedSfx = TRUE;
    }

    if (Boss1__CheckAnimFinished(work))
    {
        action->field_14 = 0;

        if (action->type == 3 && action->direction < 3)
        {
            work->bossState = Boss1__BossState_StartBite5;
        }
        else if (action->didCollide)
        {
            work->bossState = Boss1__BossState_StartBite4;
        }
        else
        {
            work->bossState = Boss1__BossState_StartBite3;
        }

        work->bossState(work);
    }
}

void Boss1__BossState_StartBite3(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    action->bite3Timer = 0;

    u16 anim;
    switch (action->type)
    {
        case 0:
            anim = ANI_bs1_body_bite3;
            break;

        case 1:
            anim = ANI_bs1_body_bitel3;
            break;

        case 2:
            anim = ANI_bs1_body_biter3;
            break;

        case 3:
            anim = ANI_bs1_body_bite3;
            break;
    }
    Boss1__SetAnimation(work, anim, TRUE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_BITE_IDLE);

    work->bossState = Boss1__BossState_Bite3;
}

void Boss1__BossState_Bite3(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    if (action->bite3Timer++ > action->config->bite3Duration)
        work->bossState = Boss1__BossState_StartBite4;
}

void Boss1__BossState_StartBite4(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    u16 anim;
    switch (action->type)
    {
        case 0:
            anim = ANI_bs1_body_bite4;
            break;

        case 1:
            anim = ANI_bs1_body_bitel4;
            break;

        case 2:
            anim = ANI_bs1_body_biter4;
            break;

        case 3:
            anim = ANI_bs1_body_bite4;
            break;
    }
    Boss1__SetAnimation(work, anim, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->bossState = Boss1__BossState_Bite4;
}

void Boss1__BossState_Bite4(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

void Boss1__BossState_StartBite5(Boss1 *work)
{
    struct Boss1ActionBite *action = &work->action.bite;

    u16 anim;
    switch (action->direction)
    {
        case 1:
            anim = ANI_bs1_body_bitel4;
            break;

        case 2:
            anim = ANI_bs1_body_biter4;
            break;
    }
    Boss1__SetAnimation(work, anim, FALSE);
    work->aniBossMain.ani.speedMultiplier = FLOAT_TO_FX32(2.0);

    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->bossState = Boss1__BossState_Bite5;
}

void Boss1__BossState_Bite5(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartBite2;
    }
}

void Boss1__HandleChargeKnockback(Boss1 *work)
{
    fx32 x;
    if (work->action.charge.direction != 0)
    {
        x = MTM_MATH_CLIP(work->gameWork.objWork.position.x, -FLOAT_TO_FX32(100.0), FLOAT_TO_FX32(493.4619140625));
    }
    else
    {
        x = MTM_MATH_CLIP(work->gameWork.objWork.position.x, FLOAT_TO_FX32(150.0), FLOAT_TO_FX32(743.4619140625));
    }

    fx32 speed = MTM_MATH_CLIP(FX_Div(x, FLOAT_TO_FX32(593.4619140625)), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0));
    if (work->action.charge.direction == 0)
        speed = FLOAT_TO_FX32(1.0) - speed;

    fx32 velX = MultiplyFX(MultiplyFX(speed, FLOAT_TO_FX32(4.0)), Boss1Stage__GetChargeKnockbackPower(work->stage)) + FLOAT_TO_FX32(1.5);
    if (work->action.charge.direction != 0)
        work->gameWork.objWork.velocity.x = -velX;
    else
        work->gameWork.objWork.velocity.x = velX;
}

void Boss1__HandleChargeVelocity(Boss1 *work)
{
    if (work->action.charge.direction != 0)
        work->gameWork.objWork.velocity.x += work->action.charge.config->accel;
    else
        work->gameWork.objWork.velocity.x -= work->action.charge.config->accel;

    work->gameWork.objWork.velocity.x = MTM_MATH_CLIP_2(work->gameWork.objWork.velocity.x, -work->action.charge.config->topSpeed, work->action.charge.config->topSpeed);
}

void Boss1__HandleChargeRunSfx(Boss1 *work)
{
    fx32 velX;
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        velX = work->gameWork.objWork.velocity.x;
    else
        velX = -work->gameWork.objWork.velocity.x;

    fx32 speed;
    if (velX > 0)
    {
        speed = MultiplyFX(velX, FLOAT_TO_FX32(0.1)) + FLOAT_TO_FX32(0.8);
        if (speed < FLOAT_TO_FX32(1.5))
            speed = FLOAT_TO_FX32(1.5);
    }
    else
    {
        speed = FLOAT_TO_FX32(0.8) - MultiplyFX(velX, FLOAT_TO_FX32(0.15));
        if (speed < FLOAT_TO_FX32(0.1))
            speed = FLOAT_TO_FX32(0.1);
    }
    work->aniBossMain.ani.speedMultiplier = speed;

    work->action.charge.field_30 += speed;
    if (work->action.charge.field_30 >= FLOAT_TO_FX32(13.0))
    {
        work->action.charge.field_30 -= FLOAT_TO_FX32(13.0);
        PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_RUN);
        DisableSpatialVolume();
        ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
        EnableSpatialVolume();
    }
}

void Boss1__BossState_InitCharge(Boss1 *work)
{
    work->field_694          = 1;
    work->field_698.unknown2 = 0;
    Boss1__ConfigureNeck(work, FALSE);
    work->bossState = Boss1__BossState_StartChargeJump0;
}

void Boss1__BossState_StartChargeJump0(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_jmp0, FALSE);
    work->bossState = Boss1__BossState_ChargeJump0;
}

void Boss1__BossState_ChargeJump0(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartChargeJump1;
        work->bossState(work);
    }
}

void Boss1__BossState_StartChargeJump1(Boss1 *work)
{
    struct Boss1ActionCharge *action = &work->action.charge;

    Boss1__SetAnimation(work, ANI_bs1_body_jmp1, TRUE);
    action->startAngle = work->angle;
    action->startPos   = work->gameWork.objWork.position;

    if (action->direction != 0)
    {
        action->endAngle = FLOAT_DEG_TO_IDX(90.0);
        action->endPos.x = -FLOAT_TO_FX32(100.0);
    }
    else
    {
        action->endAngle = -FLOAT_DEG_TO_IDX(90.0);
        action->endPos.x = FLOAT_TO_FX32(743.4619140625);
    }

    Boss1Stage *stage = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);
    action->endPos.y  = FLOAT_TO_FX32(20.0) + GetStageUnknown(stage);
    action->endPos.z  = FLOAT_TO_FX32(0.0);

    action->lerpPercent = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(10.0);

    work->bossState = Boss1__BossState_ChargeJump1;
}

void Boss1__BossState_ChargeJump1(Boss1 *work)
{
    struct Boss1ActionCharge *action = &work->action.charge;

    action->lerpPercent += FLOAT_TO_FX32(0.01318359375);
    if (action->lerpPercent > FLOAT_TO_FX32(1.0))
        action->lerpPercent = FLOAT_TO_FX32(1.0);

    work->gameWork.objWork.position.x = action->startPos.x + MultiplyFX(action->endPos.x - action->startPos.x, action->lerpPercent);
    work->gameWork.objWork.position.z = action->startPos.z + MultiplyFX(action->endPos.z - action->startPos.z, action->lerpPercent);
    work->angle                       = Unknown2066510__LerpAngle(action->startAngle, action->endAngle, action->lerpPercent);

    Boss1__HandleRotation(work);

    if (work->gameWork.objWork.velocity.y >= FLOAT_TO_FX32(0.0) && work->gameWork.objWork.position.y >= action->endPos.y)
    {
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = action->endPos.y;

        if (action->lerpPercent == FLOAT_TO_FX32(1.0))
        {
            VecFx32 ragePos = work->aniBossMain.ani.work.translation;
            BossFX__CreateRexRage(BOSSFX3D_FLAG_NONE, ragePos.x, ragePos.y, ragePos.z);

            ShakeScreenEx(0x4000, 0x3000, 273);
            PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);

            DisableSpatialVolume();
            ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
            EnableSpatialVolume();

            work->bossState = Boss1__BossState_StartChargeJump2;
        }
    }
}

void Boss1__BossState_StartChargeJump2(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_jmp2, FALSE);
    work->bossState = Boss1__BossState_ChargeJump2;
}

void Boss1__BossState_ChargeJump2(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartCharge0;
    }
}

void Boss1__BossState_StartCharge0(Boss1 *work)
{
    if (work->action.charge.direction == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(2.0);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(2.0);

    Boss1__SetAnimation(work, ANI_bs1_body_tk0, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_CHARGE);

    if (work->action.charge.direction != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    work->bossState = Boss1__BossState_Charge0;
}

void Boss1__BossState_Charge0(Boss1 *work)
{
    Boss1__HandleChargeVelocity(work);

    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartCharge1;
    }
}

void Boss1__BossState_StartCharge1(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_tk1, TRUE);

    work->bossState = Boss1__BossState_Charge1;
    work->bossState(work);
}

void Boss1__BossState_Charge1(Boss1 *work)
{
    struct Boss1ActionCharge *action = &work->action.charge;

    BOOL reachedEnd = FALSE;
    BOOL timedOut   = FALSE;

    Boss1__HandleChargeVelocity(work);

    if (action->direction != 0)
    {
        if (work->gameWork.objWork.position.x >= FLOAT_TO_FX32(493.4619140625))
        {
            work->gameWork.objWork.position.x = FLOAT_TO_FX32(493.4619140625);
            reachedEnd                        = TRUE;
        }
    }
    else
    {
        if (work->gameWork.objWork.position.x <= FLOAT_TO_FX32(150.0))
        {
            work->gameWork.objWork.position.x = FLOAT_TO_FX32(150.0);
            reachedEnd                        = TRUE;
        }
    }

    Boss1__HandleChargeRunSfx(work);

    if (work->stage->dropControl.state == 0 && work->changedBossPhase && Boss1Stage__GetBossPhase(work->stage) >= BOSS1_PHASE_3)
        action->timer = action->config->duration;

    if (action->timer < action->config->duration)
        action->timer++;

    if (action->timer >= action->config->duration)
    {
        if (work->gameWork.objWork.velocity.x > -FLOAT_TO_FX32(0.5) && work->gameWork.objWork.velocity.x < FLOAT_TO_FX32(0.5))
            timedOut = TRUE;
    }

    if (timedOut)
    {
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        work->bossState                   = Boss1__BossState_StartCharge2;
    }
    else if (reachedEnd)
    {
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

        if (action->direction != 0)
        {
            if (work->gameWork.objWork.position.x < gPlayer->objWork.position.x)
            {
                BossPlayerHelpers_Action_Boss1ChargeKnockback(gPlayer, -FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(8.0));
            }
        }
        else
        {
            if (work->gameWork.objWork.position.x > gPlayer->objWork.position.x)
            {
                BossPlayerHelpers_Action_Boss1ChargeKnockback(gPlayer, FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(8.0));
            }
        }

        work->bossState = Boss1__BossState_StartCharge2;
    }
}

void Boss1__BossState_StartCharge2(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_tk2, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->bossState = Boss1__BossState_Charge2;
}

void Boss1__BossState_Charge2(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Jump(work, work->action.jump.startPos.z);
    }
}

void Boss1__BossState_InitHeadSlam(Boss1 *work)
{
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->field_698.unknown2  = 0;
    work->field_698.field_6A0 = 0;
    work->field_6AC           = 0x147;
    work->field_6B0           = 0x266;
    work->field_6B4           = 0x2800;
    work->field_6B8           = 0x3C000;
    Boss1__ConfigureNeck(work, FALSE);

    work->bossState = Boss1__BossState_StartHeadSlam0;
}

void Boss1__BossState_StartHeadSlam0(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_head0, FALSE);

    BossArenaCamera *camera = BossArena__GetCamera(2);
    UNUSED(camera);

    BossArena__SetAmplitudeXZTarget(BossArena__GetCamera(1), FLOAT_TO_FX32(230.0));
    work->field_6C8 = -FLOAT_TO_FX32(100.0);

    BossArena__SetAmplitudeXZTarget(BossArena__GetCamera(2), FLOAT_TO_FX32(230.0));
    work->field_6CC = -FLOAT_TO_FX32(100.0);

    work->bossState = Boss1__BossState_HeadSlam0;
}

void Boss1__BossState_HeadSlam0(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartHeadSlam1;
        work->bossState(work);
    }
}

void Boss1__BossState_StartHeadSlam1(Boss1 *work)
{
    work->action.headSlam.idleTimer = 0;

    Boss1__SetAnimation(work, ANI_bs1_body_head1, TRUE);

    work->bossState = Boss1__BossState_HeadSlam1;
}

void Boss1__BossState_HeadSlam1(Boss1 *work)
{
    struct Boss1ActionHeadSlam *action = &work->action.headSlam;

    BOOL done = FALSE;

    if (Boss1__Func_2156568(work))
        action->unknownTimer++;
    else
        action->unknownTimer = 0;

    action->timer++;

    if (action->config->duration2 <= action->timer)
    {
        action->timer = action->config->duration2;
        if (action->unknownTimer != 0)
            done = TRUE;
    }
    else
    {
        if (action->config->duration1 <= action->timer && action->config->duration3 <= action->unknownTimer)
            done = TRUE;
    }

    if (action->config->duration2 - 1 <= action->timer)
        work->field_6B8 = FLOAT_TO_FX32(30.0);

    if (done)
        work->bossState = Boss1__BossState_StartHeadSlamDown;
}

void Boss1__BossState_StartHeadSlamDown(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_head2, FALSE);

    work->aniBossMain.ani.speedMultiplier = work->action.headSlam.config->animSpeed;

    // TODO: figure this struct out
    *((u32 *)work->aniBossMain.ani.currentAnimObj[0]->resAnm + 2) |= 1;

    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_HEADSLAM_ATTACK);
    work->field_698.unknown2 = 0;

    BossArenaCamera *camera = BossArena__GetCamera(2);
    UNUSED(camera);

    BossArena__SetAmplitudeXZTarget(BossArena__GetCamera(1), FLOAT_TO_FX32(300.0));
    work->field_6C8 = FLOAT_TO_FX32(0.0);

    BossArena__SetAmplitudeXZTarget(BossArena__GetCamera(2), FLOAT_TO_FX32(300.0));
    work->field_6CC = FLOAT_TO_FX32(0.0);

    work->bossState = Boss1__BossState_HeadSlamDown;
}

void Boss1__BossState_HeadSlamDown(Boss1 *work)
{
    struct Boss1ActionHeadSlam *action = &work->action.headSlam;

    if (!action->finished && work->aniBossMain.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame >= FLOAT_TO_FX32(25.0))
    {
        Boss1Stage *stage = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);
        BossFX__CreateRexHead(BOSSFX3D_FLAG_NONE, work->mtxBodyNeck.m[3][0], stage->field_378, FLOAT_TO_FX32(0.0));

        ShakeScreenEx(0x6000, 0x3000, 204);
        PlayHandleStageSfx(work->sndHandle[2], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SHOCK_L);

        DisableSpatialVolume();
        ProcessSpatialVoiceClip(work->sndHandle[2], &work->gameWork.objWork.position);
        EnableSpatialVolume();

        action->finished = TRUE;
    }

    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartHeadSlamIdle;
        work->bossState(work);
    }
}

void Boss1__BossState_StartHeadSlamIdle(Boss1 *work)
{
    struct Boss1ActionHeadSlam *action = &work->action.headSlam;
    action->idleTimer                  = 0;

    Boss1__SetAnimation(work, ANI_bs1_body_head3, TRUE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_HEADSLAM_IDLE);

    work->bossState = Boss1__BossState_HeadSlamIdle;
}

void Boss1__BossState_HeadSlamIdle(Boss1 *work)
{
    struct Boss1ActionHeadSlam *action = &work->action.headSlam;
    if (action->idleTimer++ > action->config->idleDuration)
        work->bossState = Boss1__BossState_StartHeadReturn;
}

void Boss1__BossState_StartHeadReturn(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_head4, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->bossState = Boss1__BossState_HeadReturn;
}

void Boss1__BossState_HeadReturn(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

void Boss1__BossState_InitDamage(Boss1 *work)
{
    Boss1__ConfigureNeck(work, FALSE);
    work->bossState = Boss1__BossState_StartDamage0;
}

void Boss1__BossState_StartDamage0(Boss1 *work)
{
    u16 anim;
    switch (work->action.damage.type)
    {
        case 0:
            anim = ANI_bs1_body_dmgbt0;
            break;

        case 1:
            anim = ANI_bs1_body_dmgbtl0;
            break;

        case 2:
            anim = ANI_bs1_body_dmgbtr0;
            break;

        case 3:
            anim = ANI_bs1_body_dmgbt0;
            break;
    }
    Boss1__SetAnimation(work, anim, FALSE);

    work->bossState = Boss1__BossState_Damage0;
}

void Boss1__BossState_Damage0(Boss1 *work)
{
    work->action.damage.timer++;
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartDamage1;
        work->bossState(work);
    }
}

void Boss1__BossState_StartDamage1(Boss1 *work)
{
    u16 anim;
    switch (work->action.damage.type)
    {
        case 0:
            anim = ANI_bs1_body_dmgbt1;
            break;

        case 1:
            anim = ANI_bs1_body_dmgbtl1;
            break;

        case 2:
            anim = ANI_bs1_body_dmgbtr1;
            break;

        case 3:
            anim = ANI_bs1_body_dmgbt1;
            break;
    }
    Boss1__SetAnimation(work, anim, TRUE);

    work->bossState = Boss1__BossState_Damage1;
}

void Boss1__BossState_Damage1(Boss1 *work)
{
    struct Boss1ActionDamage *action = &work->action.damage;

    u32 hitCount = Boss1Stage__GetHitComboCount(work->stage);

    // no lenience timer on normal mode! if the combo resets, then you lose your chance to deal damage!
    if (gameState.difficulty >= DIFFICULTY_NORMAL && hitCount != 0)
        action->timer = action->duration;

    if (work->stage->dropControl.state == 0 && work->changedBossPhase && Boss1Stage__GetBossPhase(work->stage) >= BOSS1_PHASE_3)
    {
        // force hit combo logic to end, it's time to rage!
        hitCount      = 0;
        action->timer = action->duration;
    }

    if (action->timer < action->duration)
    {
        action->timer++;
    }
    else
    {
        // force end combo after 0 or 6 hits once the timer's up
        if (hitCount == 0 || hitCount >= (BOSS1_HIT_COMBO_MAX + 1))
        {
            work->bossState = Boss1__BossState_StartDamage2;
            work->bossState(work);
        }
    }
}

void Boss1__BossState_StartDamage2(Boss1 *work)
{
    u16 anim;
    switch (work->action.damage.type)
    {
        case 0:
            anim = ANI_bs1_body_dmgbt2;
            break;

        case 1:
            anim = ANI_bs1_body_dmgbtl2;
            break;

        case 2:
            anim = ANI_bs1_body_dmgbtr2;
            break;

        case 3:
            anim = ANI_bs1_body_dmgbt2;
            break;
    }
    Boss1__SetAnimation(work, anim, FALSE);

    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);
    PlayHandleStageSfx(work->sndHandle[0], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_ROAR);

    DisableSpatialVolume();
    ProcessSpatialVoiceClip(work->sndHandle[0], &work->gameWork.objWork.position);
    EnableSpatialVolume();

    work->bossState = Boss1__BossState_Damage2;
}

void Boss1__BossState_Damage2(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

void Boss1__BossState_InitChargeDamage(Boss1 *work)
{
    Boss1__ConfigureNeck(work, FALSE);
    work->bossState = Boss1__BossState_StartChargeDamage0;
}

void Boss1__BossState_StartChargeDamage0(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_dmghd0, FALSE);
    work->bossState = Boss1__BossState_ChargeDamage0;
}

void Boss1__BossState_ChargeDamage0(Boss1 *work)
{
    work->action.chargeDamage.timer++;

    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartChargeDamage1;
        work->bossState(work);
    }
}

void Boss1__BossState_StartChargeDamage1(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_dmghd1, TRUE);
    work->bossState = Boss1__BossState_ChargeDamage1;
}

void Boss1__BossState_ChargeDamage1(Boss1 *work)
{
    struct Boss1ActionChargeDamage *action = &work->action.chargeDamage;

    u32 hitCount = Boss1Stage__GetHitComboCount(work->stage);

    // no lenience timer on normal mode! if the combo resets, then you lose your chance to deal damage!
    if (gameState.difficulty >= DIFFICULTY_NORMAL && hitCount != 0)
        action->timer = action->duration;

    if (action->timer < action->duration)
    {
        action->timer++;
    }
    else
    {
        // force end combo after 0 or 6 hits once the timer's up
        if (hitCount == 0 || hitCount >= (BOSS1_HIT_COMBO_MAX + 1))
        {
            work->bossState = Boss1__BossState_StartChargeDamage2;
            work->bossState(work);
        }
    }
}

void Boss1__BossState_StartChargeDamage2(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_dmghd2, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    PlayHandleStageSfx(work->sndHandle[0], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_ROAR);

    DisableSpatialVolume();
    ProcessSpatialVoiceClip(work->sndHandle[0], &work->gameWork.objWork.position);
    EnableSpatialVolume();

    work->bossState = Boss1__BossState_ChargeDamage2;
}

void Boss1__BossState_ChargeDamage2(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

void Boss1__BossState_InitJump(Boss1 *work)
{
    Boss1__ConfigureNeck(work, FALSE);

    work->field_694 = 1;

    work->bossState = Boss1__BossState_StartJump0;
}

void Boss1__BossState_StartJump0(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_jmp0, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->bossState = Boss1__BossState_Jump0;
}

void Boss1__BossState_Jump0(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartJump1;
        work->bossState(work);
    }
}

void Boss1__BossState_StartJump1(Boss1 *work)
{
    struct Boss1ActionJump *action = &work->action.jump;

    Boss1__SetAnimation(work, ANI_bs1_body_jmp1, TRUE);
    action->startAngle = work->angle;
    action->startPos   = work->gameWork.objWork.position;

    if (action->field_0 != 0)
        work->field_698.unknown1 = 0x5FAAE6;
    else
        work->field_698.unknown1 = 0x141BB2;

    Boss1__Func_2155D64(&work->field_698, &action->endPos.x, &action->endPos.z, &action->endAngle);

    Boss1Stage *stage = TaskGetWork(Boss1Stage__Singleton, Boss1Stage);
    action->endPos.y  = FLOAT_TO_FX32(20.0) + GetStageUnknown(stage);

    action->lerpPercent = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(10.0);

    work->bossState = Boss1__BossState_Jump1;
}

void Boss1__BossState_Jump1(Boss1 *work)
{
    struct Boss1ActionJump *action = &work->action.jump;

    action->lerpPercent += FLOAT_TO_FX32(0.01318359375);
    if (action->lerpPercent > FLOAT_TO_FX32(1.0))
        action->lerpPercent = FLOAT_TO_FX32(1.0);

    work->gameWork.objWork.position.x = action->startPos.x + MultiplyFX(action->endPos.x - action->startPos.x, action->lerpPercent);
    work->gameWork.objWork.position.z = action->startPos.z + MultiplyFX(action->endPos.z - action->startPos.z, action->lerpPercent);
    work->angle                       = Unknown2066510__LerpAngle(action->startAngle, action->endAngle, action->lerpPercent);

    Boss1__HandleRotation(work);

    if (work->gameWork.objWork.velocity.y >= FLOAT_TO_FX32(0.0) && work->gameWork.objWork.position.y >= action->endPos.y)
    {
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = action->endPos.y;

        if (action->lerpPercent == FLOAT_TO_FX32(1.0))
        {
            VecFx32 ragePos = work->aniBossMain.ani.work.translation;
            BossFX__CreateRexRage(BOSSFX3D_FLAG_NONE, ragePos.x, ragePos.y, ragePos.z);

            ShakeScreenEx(0x4000, 0x3000, 273);
            PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);

            DisableSpatialVolume();
            ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
            EnableSpatialVolume();

            work->bossState = Boss1__BossState_StartJump2;
        }
    }
}

void Boss1__BossState_StartJump2(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_jmp2, FALSE);
    work->bossState = Boss1__BossState_Jump2;
}

void Boss1__BossState_Jump2(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

BossFX2D *Boss1__CreateSmokeFX(fx32 x, fx32 y, fx32 z)
{
    fx32 smokeX = x + MultiplyFX(FLOAT_TO_FX32(321.73095703125), mtMathRandRepeat(FLOAT_TO_FX32(1.0))) - FLOAT_TO_FX32(160.865478515625);
    fx32 smokeY = y + MultiplyFX(mtMathRandRepeat(FLOAT_TO_FX32(1.0)), FLOAT_TO_FX32(128.0));
    fx32 smokeZ = MultiplyFX(mtMathRandRepeat(FLOAT_TO_FX32(1.0)), FLOAT_TO_FX32(128.0));

    if ((z > 0 && smokeZ > 0) || (z < 0 && smokeZ < 0))
        smokeZ = -smokeZ;

    return BossFX__CreateRexSmoke(BOSSFX2D_FLAG_NONE, smokeX, smokeY, smokeZ);
}

void Boss1__CreateDropSmokeFX(Boss1 *work)
{
    struct Boss1ActionDrop *action = &work->action.drop;

    action->smokeFXTimer++;
    if ((action->smokeFXTimer & 1) == 0)
    {
        s16 speed = (2 * action->lerpPercent);
        if (speed < FLOAT_TO_FX32(1.0))
        {
            Camera3D *config = BossArena__GetCameraConfig2(BossArena__GetCamera(1));

            BossFX2D *effect = Boss1__CreateSmokeFX(config->camPos.x, config->camPos.y, config->camPos.z);
            effect->objWork.position.y -= MultiplyFX(FLOAT_TO_FX32(200.0), speed);
            effect->objWork.velocity.y = -FLOAT_TO_FX32(10.0);
        }
    }
}

NONMATCH_FUNC BOOL Boss1__HandleDropCamera(Boss1 *work)
{
    // https://decomp.me/scratch/R9zQL -> 94.12%
#ifdef NON_MATCHING
    Boss1Stage *stage              = work->stage;
    struct Boss1ActionDrop *action = &work->action.drop;

    BossArenaCamera *cameraA;
    BossArenaCamera *cameraB;

    fx32 cameraYMid;
    fx32 cameraYEnd;
    BOOL done;
    fx32 cameraYStart;

    cameraA = BossArena__GetCamera(1);
    cameraB = BossArena__GetCamera(2);

    done = FALSE;

    cameraYStart = stage->field_378 + FLOAT_TO_FX32(80.0);
    cameraYMid   = stage->field_378 + FLOAT_TO_FX32(680.0);
    cameraYEnd   = stage->field_378 - FLOAT_TO_FX32(520.0);

    action->lerpPercent += FLOAT_TO_FX32(1.0f / 315.0f);
    if (action->lerpPercent >= FLOAT_TO_FX32(1.0))
    {
        action->lerpPercent = FLOAT_TO_FX32(1.0);
        done                = TRUE;
    }

    fx32 z;
    fx32 x;

    BossArena__GetTracker1TargetPos(cameraA, &x, NULL, &z);
    BossArena__SetTracker1TargetPos(cameraA, x, cameraYStart + MultiplyFX((cameraYMid - cameraYStart), action->lerpPercent), z);
    BossArena__SetAmplitudeYTarget(cameraA, MultiplyFX(-FLOAT_TO_FX32(120.0), action->lerpPercent) - FLOAT_TO_FX32(20.0));

    BossArena__GetTracker1TargetPos(cameraB, &x, NULL, &z);
    BossArena__SetTracker1TargetPos(cameraB, x, cameraYEnd + MultiplyFX((cameraYStart - cameraYEnd), action->lerpPercent), z);
    BossArena__SetAmplitudeYTarget(cameraB, MultiplyFX(-FLOAT_TO_FX32(40.0), action->lerpPercent) + FLOAT_TO_FX32(20.0));

    stage->dropControl.field_14 = MultiplyFX(FLOAT_TO_FX32(800.0), action->lerpPercent) + FLOAT_TO_FX32(1000.0);

    return done;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r6, r0
	mov r0, #1
	add r5, r6, #0x36c
	ldr r4, [r6, #0x368]
	bl BossArena__GetCamera
	mov r11, r0
	mov r0, #2
	bl BossArena__GetCamera
	ldr r3, [r4, #0x378]
	add r1, r6, #0x300
	ldrsh r2, [r1, #0x6c]
	mov r6, r0
	mov r9, #0
	add r0, r2, #0xd
	strh r0, [r1, #0x6c]
	ldrsh r0, [r1, #0x6c]
	add r10, r3, #0x50000
	add r7, r3, #0x2a8000
	cmp r0, #0x1000
	movge r0, #0x1000
	sub r8, r3, #0x208000
	strgeh r0, [r5]
	movge r9, #1
	add r1, sp, #0
	add r3, sp, #8
	mov r0, r11
	mov r2, #0
	bl BossArena__GetTracker1TargetPos
	ldrsh r0, [r5, #0]
	sub r2, r7, r10
	ldr r1, [sp]
	smull r3, r0, r2, r0
	adds r2, r3, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	add r2, r10, r2
	ldr r3, [sp, #8]
	str r2, [sp, #4]
	mov r0, r11
	bl BossArena__SetTracker1TargetPos
	ldrsh r7, [r5, #0]
	mov r1, #0x78000
	mvn r2, #0
	rsb r1, r1, #0
	mov r0, r11
	umull ip, r11, r7, r1
	mla r11, r7, r2, r11
	mov r3, r7, asr #0x1f
	adds r2, ip, #0x800
	mla r11, r3, r1, r11
	adc r1, r11, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r1, r2, #0x14000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r6
	add r1, sp, #0
	mov r2, #0
	add r3, sp, #8
	bl BossArena__GetTracker1TargetPos
	ldrsh r2, [r5, #0]
	sub r3, r10, r8
	ldr r1, [sp]
	smull r7, r2, r3, r2
	adds r3, r7, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r8, r3
	ldr r3, [sp, #8]
	mov r0, r6
	str r2, [sp, #4]
	bl BossArena__SetTracker1TargetPos
	mov r0, r6
	ldrsh r6, [r5, #0]
	mov r1, #0x28000
	rsb r1, r1, #0
	mvn r2, #0
	umull r8, r7, r6, r1
	mla r7, r6, r2, r7
	mov r3, r6, asr #0x1f
	adds r2, r8, #0x800
	mla r7, r3, r1, r7
	adc r1, r7, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r2, #0x14000
	bl BossArena__SetAmplitudeYTarget
	ldrsh r5, [r5, #0]
	mov r1, #0x320000
	mov r2, #0
	umull r7, r6, r5, r1
	mla r6, r5, r2, r6
	mov r3, r5, asr #0x1f
	adds r2, r7, #0x800
	mla r6, r3, r1, r6
	adc r1, r6, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r2, #0x3e8000
	mov r0, r9
	str r1, [r4, #0x3c8]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void Boss1__BossState_InitDrop(Boss1 *work)
{
    MI_CpuClear16(&work->action.drop, sizeof(work->action.drop));

    Boss1__ConfigureNeck(work, FALSE);

    playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
    BossHelpers__Player__LockControl(gPlayer);

    work->bossState = Boss1__BossState_StartDrop;
}

void Boss1__BossState_StartDrop(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_drop0, FALSE);
    work->bossState = Boss1__BossState_Drop;
}

NONMATCH_FUNC void Boss1__BossState_Drop(Boss1 *work)
{
    // https://decomp.me/scratch/HgiyU -> 96.02%
#ifdef NON_MATCHING
    VecFx32 translation = work->aniBossMain.ani.work.translation;
    fx32 frame          = FX32_TO_WHOLE(work->aniBossMain.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame);

    switch (FX32_TO_WHOLE(work->aniBossMain.ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame))
    {
        case 35: // stomp.
            ShakeScreenEx(0x4000, 0x3000, 273);
            BossFX__CreateRexRage(BOSSFX3D_FLAG_NONE, translation.x, translation.y, translation.z);
            PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);
            DisableSpatialVolume();
            ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
            EnableSpatialVolume();
            break;

        case 70: // stomp..
            ShakeScreenEx(0x4000, 0x3000, 273);
            BossFX__CreateRexRage(BOSSFX3D_FLAG_NONE, translation.x, translation.y, translation.z);
            PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);
            DisableSpatialVolume();
            ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
            EnableSpatialVolume();
            break;

        case 100: // stomp...
            ShakeScreenEx(0x4000, 0x3000, 273);
            BossFX__CreateRexRage(BOSSFX3D_FLAG_NONE, translation.x, translation.y, translation.z);
            PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);
            DisableSpatialVolume();
            ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
            EnableSpatialVolume();
            break;

        case 150: // crash!!
            ShakeScreenEx(0x8000, 0x3000, 273);
            BossFX__CreateRexHead(BOSSFX3D_FLAG_NONE, translation.x, translation.y, translation.z);
            PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);
            DisableSpatialVolume();
            ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
            EnableSpatialVolume();
            break;
    }

    if (frame >= 35 && frame < 40 || frame >= 70 && frame < 75 || frame >= 100 && frame < 105 || frame >= 150 && frame < 155)
    {
        Camera3D *config = BossArena__GetCameraConfig2(BossArena__GetCamera(1));

        CreateStompSmokeFX(config);
        CreateStompSmokeFX(config);
    }

    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartFallDelay;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	add r0, r5, #0x218
	add r0, r0, #0x800
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0xab4]
	ldr r0, [r0, #0]
	mov r4, r0, asr #0xc
	cmp r4, #0x46
	bgt _0215A054
	bge _0215A0D0
	cmp r4, #0x23
	beq _0215A070
	b _0215A1EC
_0215A054:
	cmp r4, #0x64
	bgt _0215A064
	beq _0215A130
	b _0215A1EC
_0215A064:
	cmp r4, #0x96
	beq _0215A190
	b _0215A1EC
_0215A070:
	ldr r2, =0x00000111
	mov r0, #0x4000
	mov r1, #0x3000
	bl ShakeScreenEx
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateRexRage
	mov r2, #0
	mov r0, #0x92
	sub r1, r0, #0x93
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0xe50]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0xe50]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	b _0215A1EC
_0215A0D0:
	ldr r2, =0x00000111
	mov r0, #0x4000
	mov r1, #0x3000
	bl ShakeScreenEx
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateRexRage
	mov r2, #0
	mov r0, #0x92
	sub r1, r0, #0x93
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0xe50]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0xe50]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	b _0215A1EC
_0215A130:
	ldr r2, =0x00000111
	mov r0, #0x4000
	mov r1, #0x3000
	bl ShakeScreenEx
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateRexRage
	mov r2, #0
	mov r0, #0x92
	sub r1, r0, #0x93
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0xe50]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0xe50]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	b _0215A1EC
_0215A190:
	ldr r2, =0x00000111
	mov r0, #0x8000
	mov r1, #0x3000
	bl ShakeScreenEx
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateRexHead
	mov r2, #0
	mov r0, #0x92
	sub r1, r0, #0x93
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0xe50]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0xe50]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
_0215A1EC:
	cmp r4, #0x23
	blt _0215A1FC
	cmp r4, #0x28
	blt _0215A22C
_0215A1FC:
	cmp r4, #0x46
	blt _0215A20C
	cmp r4, #0x4b
	blt _0215A22C
_0215A20C:
	cmp r4, #0x64
	blt _0215A21C
	cmp r4, #0x69
	blt _0215A22C
_0215A21C:
	cmp r4, #0x96
	blt _0215A294
	cmp r4, #0x9b
	bge _0215A294
_0215A22C:
	mov r0, #1
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	ldr r1, =Boss1Stage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0x378]
	ldr r0, [r4, #0x20]
	rsb r1, r1, #0
	add r1, r1, #0x14000
	rsb r1, r1, #0
	ldr r2, [r4, #0x28]
	sub r1, r1, #0xf000
	bl Boss1__CreateSmokeFX
	ldr r0, =Boss1Stage__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0x378]
	ldr r0, [r4, #0x20]
	rsb r1, r1, #0
	add r1, r1, #0x14000
	rsb r1, r1, #0
	ldr r2, [r4, #0x28]
	sub r1, r1, #0xf000
	bl Boss1__CreateSmokeFX
_0215A294:
	mov r0, r5
	bl Boss1__CheckAnimFinished
	cmp r0, #0
	ldrne r0, =Boss1__BossState_StartFallDelay
	strne r0, [r5, #0x3a4]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void Boss1__BossState_StartFallDelay(Boss1 *work)
{
    Boss1Stage__Action_Drop(work->stage);

    work->action.drop.timer = 0;
    work->bossState         = Boss1__BossState_FallDelay;
}

void Boss1__BossState_FallDelay(Boss1 *work)
{
    struct Boss1ActionDrop *action = &work->action.drop;

    if (action->timer++ != 0)
    {
        work->bossState = Boss1__BossState_StartDropFallStart;
    }
}

void Boss1__BossState_StartDropFallStart(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_drop1, FALSE);
    Boss1Stage__Func_21556BC(work->stage);

    gPlayer->objWork.flow.y -= FLOAT_TO_FX32(8.0);
    gPlayer->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;

    PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GROUND_DESTROY);

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_ENGINEB_ONLY | DRAW_FADE_TASK_FLAG_ENGINEA_ONLY | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS,
                       FLOAT_TO_FX32(0.2));
    ChangeBossBGMVariant(TRUE); // pinch mode!

    work->bossState = Boss1__BossState_DropFallStart;
}

void Boss1__BossState_DropFallStart(Boss1 *work)
{
    gPlayer->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartDropFall;
    }
}

void Boss1__BossState_StartDropFall(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_drop2, TRUE);

    work->bossState = Boss1__BossState_DropFall;
    work->bossState(work);
}

void Boss1__BossState_DropFall(Boss1 *work)
{
    struct Boss1ActionDrop *action = &work->action.drop;

    Boss1__CreateDropSmokeFX(work);

    if (action->timer > 60)
    {
        if (Boss1__HandleDropCamera(work))
        {
            Boss1Stage__Func_21556E0(work->stage);
            work->bossState = Boss1__BossState_StartDropLand;
        }
    }
    else
    {
        action->timer++;
    }
}

void Boss1__BossState_StartDropLand(Boss1 *work)
{
    if (work->stage->dropControl.state == 4)
    {
        Boss1__SetAnimation(work, ANI_bs1_body_drop3, FALSE);
        gPlayer->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

        BossFX__CreateRexHead(BOSSFX3D_FLAG_NONE, work->aniBossMain.ani.work.translation.x, work->aniBossMain.ani.work.translation.y, work->aniBossMain.ani.work.translation.z);

        ShakeScreenEx(0xA000, 0x3000, 227);
        SetHUDActiveScreen(1);

        PlayHandleStageSfx(work->sndHandle[1], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_LAND);
        DisableSpatialVolume();
        ProcessSpatialVoiceClip(work->sndHandle[1], &work->gameWork.objWork.position);
        EnableSpatialVolume();

        work->bossState = Boss1__BossState_DropLand;
    }
}

void Boss1__BossState_DropLand(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartDropFinish;
    }
}

void Boss1__BossState_StartDropFinish(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_fw1, FALSE);

    work->bossState = Boss1__BossState_DropFinish;
}

void Boss1__BossState_DropFinish(Boss1 *work)
{
    if (Boss1__GetFrame(work) == FLOAT_TO_FX32(50.0))
    {
        PlayHandleStageSfx(work->sndHandle[0], SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_ROAR);

        DisableSpatialVolume();
        ProcessSpatialVoiceClip(work->sndHandle[0], &work->gameWork.objWork.position);
        EnableSpatialVolume();

        ShakeScreenEx(0x1800, 0x3000, 34);
    }

    if (Boss1__CheckAnimFinished(work))
    {
        playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
        BossHelpers__Player__UnlockControl(gPlayer);

        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

void Boss1__BossState_InitDeactivate(Boss1 *work)
{
    MI_CpuClear16(&work->action.deactivate, sizeof(work->action.deactivate));

    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->bossState = Boss1__BossState_StartDeactivateStart;
}

void Boss1__BossState_StartDeactivateStart(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_down0, FALSE);

    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->field_698.unknown2          = 0;

    work->bossState = Boss1__BossState_DeactivateStart;
}

void Boss1__BossState_DeactivateStart(Boss1 *work)
{
    work->gameWork.objWork.velocity.x = 0;
    work->field_698.unknown2          = 0;

    if (Boss1__CheckAnimFinished(work))
        work->bossState = Boss1__BossState_StartDeactivate;
}

void Boss1__BossState_StartDeactivate(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_down1, TRUE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_DEACTIVATED);

    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->field_698.unknown2          = 0;

    work->bossState = Boss1__BossState_Deactivate;
}

void Boss1__BossState_Deactivate(Boss1 *work)
{
    work->action.deactivate.timer++;
    if (work->action.deactivate.timer > BOSS1_DEACTIVATE_TIME)
        work->bossState = Boss1__BossState_StartDeactivateRevive;
}

void Boss1__BossState_StartDeactivateRevive(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_down2, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->stage->health = BOSS1_REACTIVATE_HEALTH;
    UpdateBossHealthHUD(work->stage->health);

    work->bossState = Boss1__BossState_DeactivateRevive;
}

void Boss1__BossState_DeactivateRevive(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Idle(work, Boss1Stage__GetIdleDuration(work->stage));
    }
}

void Boss1__BossState_InitChargeDeactivate(Boss1 *work)
{
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);
    work->bossState = Boss1__BossState_StartChargeDeactivateStart;
}

void Boss1__BossState_StartChargeDeactivateStart(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_downt0, FALSE);

    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->field_698.unknown2          = 0;

    work->bossState = Boss1__BossState_ChargeDeactivateStart;
}

void Boss1__BossState_ChargeDeactivateStart(Boss1 *work)
{
    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->field_698.unknown2          = 0;

    if (Boss1__CheckAnimFinished(work))
    {
        work->bossState = Boss1__BossState_StartChargeDeactivate;
    }
}

void Boss1__BossState_StartChargeDeactivate(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_downt1, TRUE);

    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->field_698.unknown2          = 0;

    work->bossState = Boss1__BossState_ChargeDeactivate;
}

void Boss1__BossState_ChargeDeactivate(Boss1 *work)
{
    struct Boss1ActionChargeDeactivate *action = &work->action.chargeDeactivate;

    if (action->timer == 15)
    {
        Boss1__ConfigureCollider(work, BOSS1_COLLIDER_CHARGE_DEACTIVATED);

        if (action->direction != 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    action->timer++;
    if (action->timer > BOSS1_DEACTIVATE_TIME)
        work->bossState = Boss1__BossState_StartChargeDeactivateRevive;
}

void Boss1__BossState_StartChargeDeactivateRevive(Boss1 *work)
{
    Boss1__SetAnimation(work, ANI_bs1_body_downt2, FALSE);
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    work->stage->health = BOSS1_REACTIVATE_HEALTH;
    UpdateBossHealthHUD(work->stage->health);

    work->bossState = Boss1__BossState_ChargeDeactivateRevive;
}

void Boss1__BossState_ChargeDeactivateRevive(Boss1 *work)
{
    if (Boss1__CheckAnimFinished(work))
    {
        Boss1__Action_Jump(work, mtMathRandRepeat(2));
    }
}

void Boss1__BossState_InitDestroyed(Boss1 *work)
{
    struct Boss1ActionDestroyed *action = &work->action.destroyed;

    MI_CpuClear16(action, sizeof(*action));
    Boss1__ConfigureCollider(work, BOSS1_COLLIDER_NONE);

    playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
    StopStageBGM();

    Player__Action_Blank(gPlayer);
    Player__ChangeAction(gPlayer, PLAYER_ACTION_HOMING_ATTACK);
    gPlayer->blinkTimer = 0;
    BossHelpers__Player__LockControl(gPlayer);

    work->aniBossMain.ani.speedMultiplier = FLOAT_TO_FX32(0.0);

    EnableObjectManagerFlag2();
    work->gameWork.objWork.flag |= 0x20;
    work->stage->gameWork.objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    // Create explode impact fx
    BossFX__CreateRexExplode2(BOSSFX3D_FLAG_NONE, gPlayer->objWork.position.x, -gPlayer->objWork.position.y, gPlayer->objWork.position.z);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TYRANNO_BITE);

    action->timer   = 0;
    work->bossState = Boss1__BossState_PrepareCameraForDestroyed;
}

void Boss1__BossState_PrepareCameraForDestroyed(Boss1 *work)
{
    struct Boss1ActionDestroyed *action = &work->action.destroyed;

    action->timer++;
    if (action->timer == SECONDS_TO_FRAMES(1.5))
    {
        BossArenaCamera *camera = BossArena__GetCamera(2);

        VecFx32 translation = work->aniBossMain.ani.work.translation;

        if (work->field_694 != 0)
        {
            if (work->aniBossMain.ani.work.rotation.m[2][0] > 0)
                translation.x += FLOAT_TO_FX32(100.0);
            else
                translation.x -= FLOAT_TO_FX32(100.0);
            translation.y += FLOAT_TO_FX32(60.0);
            BossArena__SetTracker1TargetWork(camera, NULL, NULL, NULL);
            BossArena__SetTracker1TargetPos(camera, translation.x, translation.y, translation.z);
            BossArena__SetAmplitudeXZTarget(camera, FLOAT_TO_FX32(180.0));
            BossArena__SetAmplitudeYTarget(camera, FLOAT_TO_FX32(60.0));
        }
        else
        {
            translation.y += FLOAT_TO_FX32(60.0);
            translation.z = gPlayer->objWork.position.z + MultiplyFX(FLOAT_TO_FX32(0.2), translation.z);
            BossArena__SetTracker1TargetWork(camera, NULL, NULL, NULL);
            BossArena__SetTracker1TargetPos(camera, translation.x, translation.y, translation.z);
            BossArena__SetAmplitudeXZTarget(camera, FLOAT_TO_FX32(180.0));
            BossArena__SetAmplitudeYTarget(camera, FLOAT_TO_FX32(60.0));
            BossArena__SetAngleTarget(camera, BossArena__GetAngleTarget(camera) - FLOAT_DEG_TO_IDX(45.0));
        }

        BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.05), FLOAT_TO_FX32(0.05));
        BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.05), FLOAT_TO_FX32(0.05));

        work->bossState = Boss1__BossState_StartDestroyedShock;
    }
}

void Boss1__BossState_StartDestroyedShock(Boss1 *work)
{
    Camera3DTask *camera3D = Camera3D__GetWork();

    MI_CpuClear16(&camera3D->gfxControl[0].blendManager, sizeof(camera3D->gfxControl[0].blendManager));
    camera3D->gfxControl[0].blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
    camera3D->gfxControl[0].blendManager.blendControl.plane1_BG0 = TRUE;
    camera3D->gfxControl[0].blendManager.blendControl.value |= GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ;

    work->action.destroyed.timer = 0;
    work->bossState              = Boss1__BossState_DestroyedShock;
}

void Boss1__BossState_DestroyedShock(Boss1 *work)
{
    Boss1Stage *stage                   = work->stage;
    struct Boss1ActionDestroyed *action = &work->action.destroyed;

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
            BossFX__CreateRexExplode0(BOSSFX3D_FLAG_NONE, work->mtxBodyNeck.m[3][0], work->mtxBodyNeck.m[3][1], work->mtxBodyNeck.m[3][2]);
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TODOME_EFFECT);
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_ENGINEB_ONLY | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(2.0));
            ShakeScreenEx(0x3000, 0x3000, 0x600);
        }
    }

    if (action->timer++ > SECONDS_TO_FRAMES(3.5))
        work->bossState = Boss1__BossState_StartExplode;
}

void Boss1__BossState_StartExplode(Boss1 *work)
{
    BossFX3D *effect                     = BossFX__CreateRexExplode1(BOSSFX3D_FLAG_NONE, work->mtxBodyNeck.m[3][0], work->mtxBodyNeck.m[3][1], work->mtxBodyNeck.m[3][2]);
    effect->objWork.scale.x              = FLOAT_TO_FX32(2.0);
    effect->objWork.scale.y              = FLOAT_TO_FX32(2.0);
    effect->objWork.scale.z              = FLOAT_TO_FX32(2.0);
    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(0.333251953125);

    ShakeScreenEx(0xA000, 0x3000, 227);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_EXPLOSION);

    work->action.destroyed.timer = 0;

    work->bossState = Boss1__BossState_Explode;
    work->bossState(work);
}

void Boss1__BossState_Explode(Boss1 *work)
{
    Boss1Stage *stage                   = work->stage;
    struct Boss1ActionDestroyed *action = &work->action.destroyed;

    Camera3DTask *camera3D = Camera3D__GetWork();

    BOOL doneLights = FALSE;
    BOOL doneFading = FALSE;

    if (stage->lightConfig.brightness == RENDERCORE_BRIGHTNESS_DEFAULT)
        doneLights = TRUE;
    else
        stage->lightConfig.brightness++;

    if (camera3D->gfxControl[0].brightness < RENDERCORE_BRIGHTNESS_WHITE)
    {
        if (action->timer > SECONDS_TO_FRAMES(3.0) && ++action->fadeOutTimer > 3)
        {
            camera3D->gfxControl[0].brightness++;
            camera3D->gfxControl[1].brightness++;
            action->fadeOutTimer = 0;
        }
    }
    else
    {
        doneFading = TRUE;
    }

    action->timer++;

    if (doneLights && doneFading)
        work->bossState = Boss1__BossState_ShowResultsScreen;
}

void Boss1__BossState_ShowResultsScreen(Boss1 *work)
{
    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
}