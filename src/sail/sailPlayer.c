#include <sail/sailPlayer.h>
#include <sail/sailCommonObjects.h>
#include <sail/sailAudio.h>
#include <game/save/saveGame.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/screenEffect.h>
#include <game/graphics/drawReqTask.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/audio/audioSystem.h>
#include <game/input/replayRecorder.h>
#include <sail/sailDemoPlayer.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SailRetireEvent__CreateFailText(void);
NOT_DECOMPILED void SailRetireEvent__CreateFadeOut(void);
NOT_DECOMPILED void SailClearedEvent__Create(void);
NOT_DECOMPILED void SailJetRaceOpponentWarningHUD__Create(StageTask *player);
NOT_DECOMPILED void SailJetRaceProgressMarkerHUD__Create(BOOL isRival, BOOL isRival2);

NOT_DECOMPILED void EffectUnknown2161638__Create(StageTask *player);
NOT_DECOMPILED void EffectUnknown21614E4__Create(StageTask *player);
NOT_DECOMPILED void EffectUnknown21615C8__Create(void);
NOT_DECOMPILED void EffectUnknown2161544__Create(void);
NOT_DECOMPILED void EffectUnknown21615C8__Create(void);
NOT_DECOMPILED void EffectSailSmoke__Create(void);
NOT_DECOMPILED StageTask *EffectSailSubmarineWater__Create(StageTask *player);
NOT_DECOMPILED void EffectSailWaterSplash__Create(void);
NOT_DECOMPILED void EffectSailWaterSprayBack__Create(StageTask *player);
NOT_DECOMPILED void EffectSailWaterSprayFront__Create(StageTask *player);
NOT_DECOMPILED void EffectSailBoost02__Create(StageTask *player);
NOT_DECOMPILED void EffectSailTrick2__Create(void);
NOT_DECOMPILED void EffectSailTrick4__Create(void);
NOT_DECOMPILED void EffectSailFlash__CreateFromJohnny(StageTask *player);
NOT_DECOMPILED void EffectSailUnknown2162680__Create(StageTask *player);
NOT_DECOMPILED void EffectEffectSailBullet2__Create(StageTask *player, fx32 a2);
NOT_DECOMPILED void EffectSailUnknown21624A0__Create(void);
NOT_DECOMPILED void EffectSailWater09__Create(StageTask *player);
NOT_DECOMPILED void EffectSailBoost__Create(StageTask *player);
NOT_DECOMPILED void EffectSailBazooka__Create(void);
NOT_DECOMPILED void EffectSailHit__Create(VecFx32 *position);
NOT_DECOMPILED void EffectSailWaterSplash2__Create(void);
NOT_DECOMPILED void EffectSailShell__Create(void);
NOT_DECOMPILED void EffectSailUnknown21624A0__Func_2162400(void);
NOT_DECOMPILED void EffectSailFlash2__Create(void);
NOT_DECOMPILED void EffectSailUnknown2162014__Create(void);
NOT_DECOMPILED void EffectSailBomb2__Create(void);
NOT_DECOMPILED void EffectSailCircle__Create(void);

NOT_DECOMPILED void Task__OVL06Unknown2179330__Create(void);
NOT_DECOMPILED void Task__OVL06Unknown2179284__Create(void);
NOT_DECOMPILED void SailUnknown2180190__Create(StageTask *player);

// --------------------
// ENUMS
// --------------------

enum SailPlayerJetAnimationID
{
    SAILPLAYER_JETANI_fw,
    SAILPLAYER_JETANI_jump1,
    SAILPLAYER_JETANI_jump2,
    SAILPLAYER_JETANI_jump3,
    SAILPLAYER_JETANI_jump4,
    SAILPLAYER_JETANI_boost,
    SAILPLAYER_JETANI_dmg,
    SAILPLAYER_JETANI_stop,
    SAILPLAYER_JETANI_brake1,
    SAILPLAYER_JETANI_brake2,
    SAILPLAYER_JETANI_brake3,
    SAILPLAYER_JETANI_trick1,
    SAILPLAYER_JETANI_trick2,
    SAILPLAYER_JETANI_trick3,
    SAILPLAYER_JETANI_trick4,
    SAILPLAYER_JETANI_down,
};

enum SailPlayerBoatAnimationID
{
    SAILPLAYER_BOATANI_fw,
    SAILPLAYER_BOATANI_dmg_s,
    SAILPLAYER_BOATANI_dmg,
    SAILPLAYER_BOATANI_stop,
};

enum SailPlayerHoverAnimationID
{
    SAILPLAYER_HOVERANI_fw,
    SAILPLAYER_HOVERANI_jump1,
    SAILPLAYER_HOVERANI_jump2,
    SAILPLAYER_HOVERANI_jump3,
    SAILPLAYER_HOVERANI_jump4,
    SAILPLAYER_HOVERANI_boost,
    SAILPLAYER_HOVERANI_dmg,
    SAILPLAYER_HOVERANI_stop,
    SAILPLAYER_HOVERANI_spin1,
    SAILPLAYER_HOVERANI_spin2,
};

enum SailPlayerSubmarineAnimationID
{
    SAILPLAYER_SUBMARINEANI_fw,
    SAILPLAYER_SUBMARINEANI_dmg,
    SAILPLAYER_SUBMARINEANI_down,
    SAILPLAYER_SUBMARINEANI_stop,
};

enum SailPlayerRivalAnimationID
{
    SAILPLAYER_RIVALANI_fw,
    SAILPLAYER_RIVALANI_jump1,
    SAILPLAYER_RIVALANI_jump2,
    SAILPLAYER_RIVALANI_jump3,
    SAILPLAYER_RIVALANI_jump4,
    SAILPLAYER_RIVALANI_trick1,
    SAILPLAYER_RIVALANI_trick2,
    SAILPLAYER_RIVALANI_trick3,
    SAILPLAYER_RIVALANI_trick4,
    SAILPLAYER_RIVALANI_boost,
    SAILPLAYER_RIVALANI_brake1,
    SAILPLAYER_RIVALANI_brake2,
    SAILPLAYER_RIVALANI_brake3,
    SAILPLAYER_RIVALANI_dmg,
    SAILPLAYER_RIVALANI_down,
    SAILPLAYER_RIVALANI_stop,
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *aScrewL;
NOT_DECOMPILED void *aScrewR;

// force string alignment when matching
// (it's likely stripped functions/variables caused the order to change)
#ifndef NON_MATCHING
static const char *aSbJetNsbmd_0     = "sb_jet.nsbmd";
static const char *aSbJohNsbca       = "sb_joh.nsbca";
static const char *aSbJohNsbmd_0     = "sb_joh.nsbmd";
static const char *aSbJetNsbca       = "sb_jet.nsbca";
static const char *aSbHoverNsbmd_0   = "sb_hover.nsbmd";
static const char *aSbHoverNsbca     = "sb_hover.nsbca";
static const char *aSbSailerNsbca    = "sb_sailer.nsbca";
static const char *aSbSailerNsbmd_0  = "sb_sailer.nsbmd";
static const char *aSbSubmarineNsb_0 = "sb_submarine.nsbca";
static const char *aSbSubmarineNsb_1 = "sb_submarine.nsbmd";
#endif

// --------------------
// FUNCTIONS
// --------------------

StageTask *SailPlayer__Create(u16 shipType, BOOL isRival)
{
    static const char *sailPlayerAnimList[SHIP_COUNT + 1] = {
        [SHIP_JET]       = "sb_jet.nsbca",       // jetski animations
        [SHIP_BOAT]      = "sb_sailer.nsbca",    // sailboat animations
        [SHIP_HOVER]     = "sb_hover.nsbca",     // hovercraft animations
        [SHIP_SUBMARINE] = "sb_submarine.nsbca", // subarmine animations
        [SHIP_COUNT]     = "sb_joh.nsbca"        // rival animations
    };

    static const char *sailPlayerModelList[SHIP_COUNT + 1] = {
        [SHIP_JET]       = "sb_jet.nsbmd",       // jetski model
        [SHIP_BOAT]      = "sb_sailer.nsbmd",    // sailboat model
        [SHIP_HOVER]     = "sb_hover.nsbmd",     // hovercraft model
        [SHIP_SUBMARINE] = "sb_submarine.nsbmd", // subarmine model
        [SHIP_COUNT]     = "sb_joh.nsbmd"        // rival model
    };

    StageTask *work;
    SailPlayer *worker;
    SailManager *manager;

    manager = SailManager__GetWork();

    work    = CreateStageTaskSimple();
    StageTask__SetType(work, SAILSTAGE_OBJ_TYPE_PLAYER);
    SetTaskDestructorEvent(work->taskRef, SailPlayer__Destructor);
	
    worker = StageTask__AllocateWorker(work, sizeof(SailPlayer));

    if (isRival)
    {
        ObjAction3dNNModelLoad(work, NULL, sailPlayerModelList[SHIP_COUNT], 0, GetObjectFileWork(OBJDATAWORK_100), SailManager__GetArchive());
        ObjAction3dNNMotionLoad(work, NULL, sailPlayerAnimList[SHIP_COUNT], GetObjectFileWork(OBJDATAWORK_101), SailManager__GetArchive());
        SailJetRaceProgressMarkerHUD__Create(isRival, isRival);
        worker->rivalVoiceClipTimer = 120;
    }
    else
    {
        ObjAction3dNNModelLoad(work, NULL, sailPlayerModelList[shipType], 0, GetObjectFileWork(OBJDATAWORK_0), SailManager__GetArchive());
        ObjAction3dNNMotionLoad(work, NULL, sailPlayerAnimList[shipType], GetObjectFileWork(OBJDATAWORK_1), SailManager__GetArchive());

        if (manager->isRivalRace || (manager->flags & SAILMANAGER_FLAG_400) != 0)
            SailJetRaceProgressMarkerHUD__Create(isRival, isRival);
    }

    SailPlayer__ChangeAction(work, SAILPLAYER_ACTION_0);
    work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    ObjDraw__PaletteTex__Init(GetObjectDataWork(OBJDATAWORK_0)->fileData, &worker->paletteTex);

    worker->isRival  = isRival;
    worker->action   = SAILPLAYER_ACTION_INVALID;
    worker->shipType = shipType;

    if (manager->missionType <= MISSION_TYPE_TRAINING && (manager->flags & SAILMANAGER_FLAG_100000) == 0)
        worker->upgradeLevel = SaveGame__GetShipUpgradeStatus(worker->shipType);

    worker->touchPos.x = 128;
    if (manager->isRivalRace != 0 && manager->isRivalRace != 2)
    {
        if (worker->isRival)
            worker->touchPos.x = 170;
        else
            worker->touchPos.x = 85;
    }

    worker->touchPos.y = 96;
    worker->health     = SAILPLAYER_HEALTH_MAX;
    worker->boost      = SAILPLAYER_BOOST_START;

    GameState *state = GetGameState();
    if (!manager->isRivalRace || state->sailStoredShipType == SHIP_JET)
    {
        if (state->sailStoredShipHealth != 0)
            worker->health = state->sailStoredShipHealth;
    }

    worker->boostTapTimer = 64;
    work->userFlag |= SAILPLAYER_FLAG_40;

    if (shipType != SHIP_JET)
        work->userFlag |= SAILPLAYER_FLAG_SHIP_BOAT << (shipType - 1);

    SailObject__Func_21646DC(work);

    SetTaskInFunc(work, SailPlayer__In_Default);
    SetTaskLastFunc(work, SailPlayer__Last_Default);

    work->dir.y = FLOAT_DEG_TO_IDX(180.0);
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gravityStrength  = FLOAT_TO_FX32(0.0068359375);
    work->terminalVelocity = FLOAT_TO_FX32(0.5);
    work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

    worker->sndHandles[0] = AllocSndHandle();
    worker->sndHandles[1] = AllocSndHandle();
    StageTask__InitSeqPlayer(work);

    switch (worker->shipType)
    {
        case SHIP_JET:
        case SHIP_HOVER:
            worker->shipSndHandles[0] = AllocSndHandle();
            worker->field_14          = FLOAT_TO_FX32(8.0);
            worker->field_4.x         = FLOAT_TO_FX32(0.0);
            worker->field_4.y         = FLOAT_TO_FX32(0.5625);
            worker->field_4.z         = FLOAT_TO_FX32(0.0);

            s32 unknown = FLOAT_TO_FX32(0.46875);
            if (worker->shipType == SHIP_HOVER)
                unknown = FLOAT_TO_FX32(0.375);

            SailObject__SetupHitbox(work, worker->colliders, 0);
            SailObject__Func_21658D0(work, 0, unknown, 0);
            ObjRect__SetOnDefend(work->colliderList[0], SailPlayer__OnDefend_JetHover);

            SailObject__SetupHitbox(work, &worker->colliders[1], 1);
            SailObject__Func_21658D0(work, 1, FLOAT_TO_FX32(1.0), NULL);
            worker->colliders[1].atkPower = FLOAT_TO_FX32(128.0);

            SailObject__SetupHitbox(work, &worker->colliders[2], 2);
            SailObject__Func_21658D0(work, 2, FLOAT_TO_FX32(1.625), NULL);
            worker->colliders[2].atkPower = FLOAT_TO_FX32(128.0);

            SailPlayer__ColliderFunc(work, 0);

            work->colliderList[1]->hitPower = 11;
            work->colliderList[2]->hitPower = 11;
            work->colliderList[1]->hitFlag |= 4;
            work->colliderList[2]->hitFlag |= 4;
            work->colliderList[1]->hitFlag &= ~2;
            work->colliderList[2]->hitFlag &= ~2;

            EffectSailWaterSprayBack__Create(work);

            if (worker->shipType == SHIP_HOVER)
                EffectSailWater09__Create(work);
            else
                EffectSailWaterSprayFront__Create(work);
            break;

        case SHIP_BOAT:
            worker->shipSndHandles[1] = AllocSndHandle();
            worker->field_14          = FLOAT_TO_FX32(48.0);
            worker->field_4.x         = FLOAT_TO_FX32(0.0);
            worker->field_4.y         = FLOAT_TO_FX32(3.0);
            worker->field_4.z         = FLOAT_TO_FX32(0.0);

            SailObject__SetupHitbox(work, worker->colliders, 0);
            SailObject__Func_21658D0(work, 0, FLOAT_TO_FX32(9.0), NULL);
            worker->colliders[0].hitCheck.field_24.z = FLOAT_TO_FX32(4.0);
            worker->colliders[0].hitCheck.field_24.y = FLOAT_TO_FX32(2.0);
            ObjRect__SetOnDefend(work->colliderList[0], SailPlayer__OnDefend_Boat);

            NNS_G3dRenderObjSetCallBack(&work->obj_3d->ani.renderObj, SailPlayer__BoatRenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
            EffectSailWaterSprayFront__Create(work);

            worker->weaponAmmo[0] = FLOAT_TO_FX32(6.0);
            worker->weaponAmmo[1] = FLOAT_TO_FX32(3.0);
            worker->weaponAmmo[2] = FLOAT_TO_FX32(1.0);
            worker->dword1D4      = -FLOAT_TO_FX32(1.5);
            break;

        case SHIP_SUBMARINE:
            worker->field_14  = FLOAT_TO_FX32(16.0);
            worker->field_4.x = FLOAT_TO_FX32(0.0);
            worker->field_4.y = FLOAT_TO_FX32(6.0);
            worker->field_4.z = FLOAT_TO_FX32(0.0);
            SailObject__SetupHitbox(work, worker->colliders, 0);
            SailObject__Func_21658D0(work, 0, FLOAT_TO_FX32(6.0), NULL);
            ObjRect__SetOnDefend(work->colliderList[0], SailPlayer__OnDefend_Submarine);

            worker->dword1D4 = -FLOAT_TO_FX32(16.0);

            EffectSailSubmarineWater__Create(work);
            StageTask *effect      = EffectSailSubmarineWater__Create(work);
            effect->parentOffset.x = -effect->parentOffset.x;
            break;
    }

    SailPlayer__Action_BeginVoyage(work);

    if (worker->isRival && manager->isRivalRace == TRUE)
    {
        // load rival controller config
        char rivalControlPath[] = "sbb/sb_joh00.sbj";

        s32 digit = FX_DivS32(manager->rivalRaceID, 10);
        rivalControlPath[11] += manager->rivalRaceID - 10 * digit;
        rivalControlPath[10] += digit;

        worker->sailRival = CreateSailRival(worker, NULL, rivalControlPath);

        ObjRect__SetGroupFlags(work->colliderList[0], 2, 1);
        ObjRect__SetGroupFlags(work->colliderList[1], 2, 1);
        ObjRect__SetGroupFlags(work->colliderList[2], 2, 1);

        work->colliderList[0]->defFlag  = -1;
        work->colliderList[1]->defFlag  = -1;
        work->colliderList[2]->defFlag  = -1;
        work->colliderList[0]->hitPower = 10;

        worker->colliders[0].flags |= 0x200;
        worker->colliders[1].atkPower = FLOAT_TO_FX32(128.0);
        worker->colliders[2].atkPower = FLOAT_TO_FX32(96.0);
    }

    return work;
}

void SailPlayer__ColliderFunc_JetHover(StageTask *work, s32 id)
{
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    OBS_RECT_WORK *collider;
    switch (id)
    {
        case 0:
            if ((work->userFlag & (SAILPLAYER_FLAG_400 | SAILPLAYER_FLAG_BOOST)) == 0)
            {
                collider = StageTask__GetCollider(work, 1);
                collider->flag |= OBS_RECT_WORK_FLAG_800;
            }

            if ((work->userFlag & SAILPLAYER_FLAG_4) == 0)
            {
                collider = StageTask__GetCollider(work, 2);
                collider->flag |= OBS_RECT_WORK_FLAG_800;
            }

            if (worker->blinkTimer == 0 && (work->userFlag & (SAILPLAYER_FLAG_400 | SAILPLAYER_FLAG_4 | SAILPLAYER_FLAG_BOOST)) == 0)
            {
                collider           = StageTask__GetCollider(work, 0);
                collider->defPower = 10;
            }
            break;

        case 1:
            collider           = StageTask__GetCollider(work, 0);
            collider->defPower = 15;
            break;

        case 2:
            collider = StageTask__GetCollider(work, 1);
            collider->flag &= ~OBS_RECT_WORK_FLAG_800;
            ObjRect__HitAgain(collider);

            collider           = StageTask__GetCollider(work, 0);
            collider->defPower = 15;
            break;

        case 3:
            collider = StageTask__GetCollider(work, 2);
            collider->flag &= ~OBS_RECT_WORK_FLAG_800;
            ObjRect__HitAgain(collider);

            collider           = StageTask__GetCollider(work, 0);
            collider->defPower = 15;
            break;
    }
}

void SailPlayer__ColliderFunc_SailerSub(StageTask *work, s32 id)
{
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    OBS_RECT_WORK *collider;
    switch (id)
    {
        case 0:
            if (worker->blinkTimer == 0)
            {
                collider           = StageTask__GetCollider(work, 0);
                collider->defPower = 10;
            }
            break;

        case 1:
            collider           = StageTask__GetCollider(work, 0);
            collider->defPower = 15;
            break;
    }
}

void SailPlayer__ColliderFunc(StageTask *work, s32 id)
{
    typedef void (*ShipFunc)(StageTask * work, s32 id);

    const ShipFunc shipTable[SHIP_COUNT] = { [SHIP_JET]       = SailPlayer__ColliderFunc_JetHover,
                                             [SHIP_BOAT]      = SailPlayer__ColliderFunc_SailerSub,
                                             [SHIP_HOVER]     = SailPlayer__ColliderFunc_JetHover,
                                             [SHIP_SUBMARINE] = SailPlayer__ColliderFunc_SailerSub };

    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);
    shipTable[worker->shipType](work, id);
}

void SailPlayer__RemoveHealth(StageTask *player, s32 amount)
{
    SailPlayer *worker   = GetStageTaskWorker(player, SailPlayer);
    SailManager *manager = SailManager__GetWork();

    if (worker->health == FLOAT_TO_FX32(0.0))
        return;

    if (manager->missionType == MISSION_TYPE_REACH_GOAL)
    {
        if (amount > 0)
            amount <<= 1; // double the health gained
        else
            amount >>= 1; // half the health lost
    }

    // lose half the health if level 1 or higher and in the submarine
    if (SailManager__GetShipType() == SHIP_SUBMARINE && worker->upgradeLevel != SAILPLAYER_UPGRADE_LEVEL_0 && amount > 0)
        amount >>= 1;

    worker->health -= amount;
    worker->healthChange += amount;

    if ((manager->flags & SAILMANAGER_FLAG_FREEZE_ALPHA_TIMER) != 0 && worker->health < 0)
        worker->health = 1;

    if (worker->health < SAILPLAYER_HEALTH_MIN)
        worker->health = SAILPLAYER_HEALTH_MIN;

    if (worker->health > SAILPLAYER_HEALTH_MAX)
        worker->health = SAILPLAYER_HEALTH_MAX;
}

void SailPlayer__GiveBoost(StageTask *player, s32 amount)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    if (!worker->isRival && (!worker->maxBoostTimer || amount >= 0))
    {
        // lose half the boost when ship is level 1 or higher
        if (worker->upgradeLevel != SAILPLAYER_UPGRADE_LEVEL_0 && amount < 0)
            amount >>= 1;

        // gain double the boost when ship is level 2 (or higher?)
        if (worker->upgradeLevel >= SAILPLAYER_UPGRADE_LEVEL_2 && amount > 0)
            amount <<= 1;

        s32 prevBoost = worker->boost;
        worker->boost += amount;

        if (worker->boost < SAILPLAYER_BOOST_MIN)
            worker->boost = SAILPLAYER_BOOST_MIN;

        if (worker->boost >= SAILPLAYER_BOOST_MAX)
        {
            worker->boost = SAILPLAYER_BOOST_MAX;

            if (worker->shipType == SHIP_JET)
            {
                if (worker->maxBoostTimer != 0)
                {
                    if (amount > FLOAT_TO_FX32(2.0))
                    {
                        worker->maxBoostTimer += FX32_TO_WHOLE(2 * amount);
                    }
                    else if (amount > 0)
                    {
                        worker->maxBoostTimer += FX32_TO_WHOLE(amount);
                    }
                }
                else if ((player->userFlag & SAILPLAYER_FLAG_BOOST) == 0)
                {
                    if (prevBoost < worker->boost || prevBoost <= worker->boost && amount >= FLOAT_TO_FX32(10.0))
                        worker->maxBoostTimer = 150;
                }
            }
        }

        if (worker->maxBoostTimer > 200)
            worker->maxBoostTimer = 200;
    }
}

BOOL SailPlayer__HasRetired(StageTask *player)
{
    SailPlayer *worker   = GetStageTaskWorker(player, SailPlayer);
    SailManager *manager = SailManager__GetWork();

    switch (player->objType)
    {
        case 0:
            // SailPlayer
            if (worker->health <= 0)
                return TRUE;

            if ((manager->flags & SAILMANAGER_FLAG_8) != 0)
                return TRUE;
            break;

        case 1:
            // ???
            // if (worker->field_11C <= 0)
            if (*((s32 *)worker + 71) <= 0)
                return TRUE;
            break;
    }

    return FALSE;
}

void SailPlayer__ReachedGoal(StageTask *player)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    player->userFlag &= ~SAILPLAYER_FLAG_IS_HURT;
    worker->chargeTimer = SAILPLAYER_CHARGE_MIN;

    if (worker->shipType == SHIP_HOVER)
    {
        StopStageSfx(worker->shipSndHandles[0]);
        SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGING);
    }

    worker->maxBoostTimer = 0;
    player->userFlag &= ~SAILPLAYER_FLAG_USED_MAX_BOOST;

    ObjDraw__PaletteTex__Process(&worker->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
    SailPlayer__Func_215A41C(player);
    SailPlayer__Action_StopBoost(player);
}

void SailPlayer__Action_BeginVoyage(StageTask *player)
{
    SailPlayer *worker   = GetStageTaskWorker(player, SailPlayer);
    SailManager *manager = SailManager__GetWork();
    SailCamera *camera   = manager->camera;

    SailPlayer__ChangeAction(player, SAILPLAYER_ACTION_0);
    player->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->userWork  = 0;
    player->state     = SailPlayer__State_BeginVoyage;
    worker->speed     = FLOAT_TO_FX32(0.0);

    worker->seaAngle2 = FLOAT_DEG_TO_IDX(135.0);
    if (ObjDispRandRepeat(2) != 0)
        worker->seaAngle2 = -worker->seaAngle2;

    if (!worker->isRival)
    {
        switch (worker->shipType)
        {
            case SHIP_JET:
            case SHIP_HOVER:
                camera->field_20 = -FLOAT_TO_FX32(4.0);
                camera->field_10 = -FLOAT_TO_FX32(4.0);
                break;

            case SHIP_BOAT:
                camera->field_20 = -FLOAT_TO_FX32(16.0);
                camera->field_10 = FLOAT_TO_FX32(16.0);
                break;

            case SHIP_SUBMARINE:
                camera->field_20 = FLOAT_TO_FX32(40.0);
                camera->field_10 = -FLOAT_TO_FX32(24.0);
                camera->field_8  = -FLOAT_TO_FX32(8.0);
                break;
        }
    }
}

void SailPlayer__State_BeginVoyage(StageTask *work)
{
    SailPlayer *worker   = GetStageTaskWorker(work, SailPlayer);
    SailManager *manager = SailManager__GetWork();
    SailCamera *camera   = manager->camera;

    if (!worker->isRival)
    {
        switch (worker->shipType)
        {
            case SHIP_JET:
            case SHIP_HOVER:
                worker->seaAngle2 = ObjShiftSet(worker->seaAngle2, FLOAT_DEG_TO_IDX(0.0), 1, FLOAT_DEG_TO_IDX(6.328125), FLOAT_DEG_TO_IDX(0.0));

                camera->field_20 = ObjShiftSet(camera->field_20, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(0.0));
                camera->field_10 = ObjShiftSet(camera->field_10, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.15625), FLOAT_TO_FX32(0.0));
                break;

            case SHIP_BOAT:
                worker->seaAngle2 = ObjShiftSet(worker->seaAngle2, FLOAT_DEG_TO_IDX(0.0), 1, FLOAT_DEG_TO_IDX(2.8125), FLOAT_DEG_TO_IDX(0.0));

                camera->field_20 = ObjShiftSet(camera->field_20, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.625), FLOAT_TO_FX32(0.0));
                camera->field_10 = ObjShiftSet(camera->field_10, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.3125), FLOAT_TO_FX32(0.0));
                break;

            case SHIP_SUBMARINE:
                worker->seaAngle2 = ObjShiftSet(worker->seaAngle2, FLOAT_DEG_TO_IDX(0.0), 1, FLOAT_DEG_TO_IDX(2.8125), FLOAT_DEG_TO_IDX(0.0));

                camera->field_20 = ObjShiftSet(camera->field_20, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.625), FLOAT_TO_FX32(0.0));
                camera->field_8  = ObjShiftSet(camera->field_8, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.3125), FLOAT_TO_FX32(0.0));
                camera->field_10 = ObjShiftSet(camera->field_10, FLOAT_TO_FX32(0.0), 1, FLOAT_TO_FX32(0.3125), FLOAT_TO_FX32(0.0));
                break;
        }
    }

    if (!worker->isRival)
    {
        VecFx32 lineStart, lineEnd;
        VecFx32 lineDir;

        NNS_G3dScrPosToWorldLine(worker->touchPos.x, worker->touchPos.y, &lineStart, &lineEnd);
        VEC_Subtract(&lineEnd, &lineStart, &lineDir);
        VEC_Normalize(&lineDir, &lineDir);

        VecFx32 result;
        VEC_MultAdd(worker->field_14, &lineDir, &lineStart, &result);
        worker->seaPos.x = result.x;
        worker->seaPos.z = result.z;
    }

    SailPlayer__Func_215BFEC(work);
    SailObject__SetupAnimator3D(work);

    if (worker->shipType == SHIP_JET)
    {
        if (TOUCH_HAS_PUSH(worker->touchFlags))
        {
            if ((manager->flags & SAILMANAGER_FLAG_100) != 0)
            {
                work->userFlag |= SAILPLAYER_FLAG_200;
            }
            else if ((manager->flags & SAILMANAGER_FLAG_80) != 0)
            {
                work->userFlag |= SAILPLAYER_FLAG_100;
            }
        }

        if (!TOUCH_HAS_ON(worker->touchFlags))
        {
            work->userFlag &= ~SAILPLAYER_FLAG_200;
            work->userFlag &= ~SAILPLAYER_FLAG_100;
            work->dir.x = ObjSpdDownSet(work->dir.x, FLOAT_DEG_TO_IDX(2.8125));
        }
        else
        {
            work->dir.x = ObjSpdUpSet(work->dir.x, FLOAT_DEG_TO_IDX(2.8125), FLOAT_DEG_TO_IDX(11.25));
        }
    }

    if ((manager->flags & SAILMANAGER_FLAG_1) == 0)
    {
        if (!work->userWork)
            work->userWork = 1;

        switch (worker->shipType)
        {
            case SHIP_JET:
            case SHIP_HOVER:
                worker->seaAngle2 = 0;

                if ((work->userFlag & SAILPLAYER_FLAG_200) != 0)
                {
                    work->userFlag |= SAILPLAYER_FLAG_80;
                    EffectUnknown2161638__Create(work);
                    worker->speed     = FLOAT_TO_FX32(1.375);
                    worker->field_1E6 = 24;
                }
                else if ((work->userFlag & SAILPLAYER_FLAG_100) != 0)
                {
                    worker->speed = FLOAT_TO_FX32(1.0);
                }

                work->userFlag &= ~SAILPLAYER_FLAG_200;
                work->userFlag &= ~SAILPLAYER_FLAG_100;

                if (!worker->isRival)
                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_GO);

                SailPlayer__Action_RecoverJetHover(work);
                break;

            case SHIP_BOAT:
                worker->seaAngle2 = 0;
                worker->speed     = ObjSpdUpSet(worker->speed, FLOAT_TO_FX32(0.03125), FLOAT_TO_FX32(0.5));

                if (worker->speed == FLOAT_TO_FX32(0.5))
                {
                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_GO);
                    SailPlayer__Action_RecoverBoat(work);
                }
                break;

            case SHIP_SUBMARINE:
                worker->seaAngle2 = 0;
                worker->speed     = ObjSpdUpSet(worker->speed, FLOAT_TO_FX32(0.02783203125), FLOAT_TO_FX32(1.784423828125));

                if (worker->speed == FLOAT_TO_FX32(1.784423828125))
                {
                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_GO);
                    SailPlayer__Action_RecoverSubmarine(work);
                }
                break;
        }
    }
}

NONMATCH_FUNC void SailPlayer__Action_ReachedGoal(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r4, [r7, #0x124]
	bl SailManager__GetWork
	ldr r2, [r7, #0xf4]
	ldr r1, =SailPlayer__State_ReachedGoal
	ldr r6, =gameState
	mov r5, r0
	cmp r2, r1
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x24]
	tst r1, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r5, #0xc]
	cmp r0, #0
	beq _021599F0
	tst r1, #0x100000
	movne r1, #0
	add r0, r5, #0x500
	moveq r1, #3
	strh r1, [r0, #0xd0]
	mov r0, #0x5c
	bl SailAudio__PlaySequence
_021599F0:
	ldrh r0, [r5, #0x12]
	cmp r0, #6
	moveq r0, #1
	streq r0, [r6, #0x7c]
	mov r0, r7
	bl SailPlayer__ReachedGoal
	bl SailVoyageManager__GetVoyageAngle
	add r0, r0, #0x8000
	strh r0, [r7, #0x32]
	ldr r0, [r7, #0x24]
	orr r0, r0, #8
	str r0, [r7, #0x24]
	ldr r0, [r4, #0x24]
	cmp r0, #0x80
	ldrlt r0, [r7, #0x24]
	orrlt r0, r0, #0x800
	strlt r0, [r7, #0x24]
	ldr r0, [r7, #0x18]
	orr r0, r0, #2
	str r0, [r7, #0x18]
	ldrh r0, [r4, #0]
	cmp r0, #0
	beq _02159A60
	cmp r0, #1
	beq _02159AE0
	cmp r0, #2
	beq _02159AA8
	b _02159AF8
_02159A60:
	ldr r0, [r7, #0x24]
	bic r0, r0, #0x80
	str r0, [r7, #0x24]
	ldr r0, [r7, #0x1c]
	tst r0, #0x10
	bne _02159AF8
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #9
	cmpne r0, #8
	beq _02159AF8
	mov r0, r7
	mov r1, #8
	bl SailPlayer__ChangeAction
	ldr r0, [r7, #0x20]
	bic r0, r0, #4
	str r0, [r7, #0x20]
	b _02159AF8
_02159AA8:
	ldr r1, [r7, #0x24]
	add r0, r4, #0x100
	bic r1, r1, #0x80
	str r1, [r7, #0x24]
	ldrh r0, [r0, #0xc0]
	cmp r0, #0
	beq _02159AD0
	mov r0, r7
	mov r1, #0
	bl SailPlayer__ChangeAction
_02159AD0:
	ldr r0, [r7, #0x20]
	orr r0, r0, #4
	str r0, [r7, #0x20]
	b _02159AF8
_02159AE0:
	mov r0, r7
	mov r1, #0
	bl SailPlayer__ChangeAction
	ldr r0, [r7, #0x20]
	orr r0, r0, #4
	str r0, [r7, #0x20]
_02159AF8:
	mov r1, #0
	str r1, [r7, #0x2c]
	ldr r0, =SailPlayer__State_ReachedGoal
	str r1, [r7, #0x28]
	str r0, [r7, #0xf4]
	add r0, r4, #0x100
	mov r1, #0x100
	strh r1, [r0, #0xc8]
	bl SailClearedEvent__Create
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _02159B44
	ldr r0, [r5, #0x24]
	tst r0, #0x4000
	bne _02159B44
	ldr r0, [r7, #0x138]
	mov r1, #0x52
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_02159B44:
	ldrh r0, [r4, #0]
	mov r2, #0
	cmp r0, #3
	bne _02159B64
	ldr r0, [r4, #0x284]
	mov r1, #0x6c
	bl SailAudio__PlaySpatialSequence
	b _02159B84
_02159B64:
	cmp r0, #0
	ldr r0, [r4, #0x284]
	bne _02159B7C
	mov r1, #0x6b
	bl SailAudio__PlaySpatialSequence
	b _02159B84
_02159B7C:
	mov r1, #0x75
	bl SailAudio__PlaySpatialSequence
_02159B84:
	ldr r0, [r4, #0x284]
	mov r1, #0x7f
	mov r2, #0x3c
	bl NNS_SndPlayerMoveVolume
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_ReachedGoal(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetWork
	ldr r1, [r5, #0x4c]
	mov r5, r0
	cmp r1, #0x30000
	ldr r0, [r4, #0x10]
	blt _02159BF8
	mov r1, #0x46
	bl ObjSpdDownSet
	str r0, [r4, #0x10]
	ldrh r0, [r4, #0]
	cmp r0, #3
	bne _02159C08
	ldr r0, [r4, #0x10]
	mov r1, #0x8c
	bl ObjSpdDownSet
	str r0, [r4, #0x10]
	b _02159C08
_02159BF8:
	mov r1, #0x24
	mov r2, #0x1400
	bl ObjSpdUpSet
	str r0, [r4, #0x10]
_02159C08:
	ldr r0, [r5, #0x24]
	tst r0, #0x40
	bne _02159D34
	ldr r0, [r6, #0x2c]
	cmp r0, #0
	beq _02159D34
	ldr r0, [r6, #0x28]
	mov r1, #0x24
	mov r2, #0x1400
	bl ObjSpdUpSet
	str r0, [r6, #0x28]
	ldrh r2, [r6, #0x32]
	ldr r1, =FX_SinCosTable_
	mov r3, #0
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh ip, [r1, r2]
	add r2, r5, #0x500
	smull lr, ip, r0, ip
	adds lr, lr, #0x800
	adc r0, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r0, lsl #20
	str ip, [r6, #0x98]
	ldrh r0, [r6, #0x32]
	ldr ip, [r6, #0x28]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	smull r1, r0, ip, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0xa0]
	ldrsh r0, [r2, #0xd0]
	cmp r0, #0
	bne _02159D28
	ldrh r0, [r4, #0]
	cmp r0, #0
	cmpne r0, #2
	bne _02159D10
	ldr r0, [r6, #0x2c]
	mov r0, r0, lsl #9
	cmp r0, #0x2800
	ble _02159CE0
	cmp r0, #0x4800
	bge _02159CE0
	ldr r0, [r6, #0x28]
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r6, #0x28]
_02159CE0:
	ldr r0, [r6, #0x2c]
	mov r0, r0, lsl #9
	cmp r0, #0x8000
	bge _02159D28
	ldr r0, [r6, #0x24]
	tst r0, #0x800
	ldrh r0, [r6, #0x32]
	subne r0, r0, #0x200
	strneh r0, [r6, #0x32]
	addeq r0, r0, #0x200
	streqh r0, [r6, #0x32]
	b _02159D28
_02159D10:
	ldrh r0, [r6, #0x32]
	add r0, r0, #0xa0
	strh r0, [r6, #0x32]
	ldrh r0, [r4, #0]
	cmp r0, #1
	streq r3, [r6, #0x28]
_02159D28:
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
_02159D34:
	ldrh r0, [r4, #0]
	cmp r0, #0
	cmpne r0, #2
	bne _02159E3C
	ldr r1, [r5, #0x24]
	ldr r0, =0x00004060
	tst r1, r0
	ldrne r0, [r4, #0x10]
	cmpne r0, #0
	beq _02159D9C
	ldr r7, [r5, #0xa8]
	mov r1, #0
	str r1, [sp]
	ldr r0, [r7, #8]
	mov r2, #1
	mov r3, #0x500
	bl ObjShiftSet
	mov r1, #0
	str r0, [r7, #8]
	str r1, [sp]
	ldr r0, [r7, #0x10]
	sub r1, r1, #0x1800
	mov r2, #1
	mov r3, #0x500
	bl ObjShiftSet
	str r0, [r7, #0x10]
_02159D9C:
	ldr r0, [r6, #0x1c]
	tst r0, #0x10
	beq _02159DD4
	mov r0, r6
	bl SailPlayer__CheckInWater
	cmp r0, #0
	beq _02159E3C
	mov r0, r6
	mov r1, #9
	bl SailPlayer__ChangeAction
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	b _02159E3C
_02159DD4:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #8
	beq _02159DF0
	cmp r0, #0xa
	beq _02159E18
	b _02159E3C
_02159DF0:
	ldr r0, [r6, #0x20]
	tst r0, #8
	beq _02159E3C
	mov r0, r6
	mov r1, #9
	bl SailPlayer__ChangeAction
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	b _02159E3C
_02159E18:
	ldr r0, [r6, #0x20]
	tst r0, #8
	beq _02159E3C
	mov r0, r6
	mov r1, #0
	bl SailPlayer__ChangeAction
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_02159E3C:
	add r0, r4, #0x100
	ldrsh r0, [r0, #0xcc]
	cmp r0, #0
	beq _02159E78
	mov r1, #0x200
	bl ObjSpdDownSet
	add r1, r4, #0x100
	strh r0, [r1, #0xcc]
	ldrsh r0, [r1, #0xcc]
	strh r0, [r6, #0x34]
	ldrh r0, [r4, #0]
	cmp r0, #2
	ldreqsh r0, [r6, #0x34]
	moveq r0, r0, asr #2
	streqh r0, [r6, #0x34]
_02159E78:
	mov r0, r6
	bl SailObject__SetupAnimator3D
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	beq _02159E9C
	add r0, r4, #0x100
	mov r1, #0
	strh r1, [r0, #0xca]
	strh r1, [r0, #0xc8]
_02159E9C:
	ldr r0, [r5, #0x24]
	tst r0, #1
	ldreq r0, [r4, #0x10]
	cmpeq r0, #0
	ldreq r0, [r6, #0x2c]
	cmpeq r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r4, #0x100
	ldrsh r1, [r0, #0xc8]
	mov r1, r1, lsl #1
	strh r1, [r0, #0xc8]
	bl SailRetireEvent__CreateFadeOut
	mov r0, #1
	str r0, [r6, #0x2c]
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	beq _02159EF0
	add r0, r4, #0x100
	mov r1, #0
	strh r1, [r0, #0xca]
	strh r1, [r0, #0xc8]
_02159EF0:
	ldr r0, [r4, #0x284]
	mov r1, #0
	mov r2, #0x3c
	bl NNS_SndPlayerMoveVolume
	ldr r1, [r6, #0x24]
	add r0, r5, #0x500
	orr r1, r1, #0x10
	str r1, [r6, #0x24]
	ldrsh r0, [r0, #0xd0]
	cmp r0, #0
	ldreq r0, [r6, #0x24]
	orreq r0, r0, #0x1000
	streq r0, [r6, #0x24]
	ldrh r0, [r4, #0]
	cmp r0, #0
	beq _02159F40
	cmp r0, #1
	beq _02159F5C
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
_02159F40:
	mov r0, r6
	mov r1, #0xa
	bl SailPlayer__ChangeAction
	ldr r0, [r6, #0x20]
	bic r0, r0, #4
	str r0, [r6, #0x20]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02159F5C:
	mov r0, r6
	bl EffectSailWaterSprayBack__Create
	ldr r0, [r6, #0x24]
	tst r0, #0x1000
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r6
	bl EffectSailWaterSprayBack__Create
	ldr r1, [r0, #0x68]
	rsb r1, r1, #0
	str r1, [r0, #0x68]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Gimmick_DashPanel(StageTask *player, s16 a2, s16 timer)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r3, [r7, #0x24]
	ldr r4, [r7, #0x124]
	orr r3, r3, #0x80
	mov r6, r1
	tst r3, #1
	str r3, [r7, #0x24]
	addeq r1, r4, #0x100
	ldreqsh r1, [r1, #0xe6]
	mov r5, r2
	cmpeq r1, #0
	bne _02159FC8
	bl EffectUnknown2161638__Create
_02159FC8:
	ldr r0, [r4, #0x10]
	cmp r0, #0x1c00
	movlt r0, #0x1c00
	strlt r0, [r4, #0x10]
	add r0, r4, #0x100
	strh r6, [r0, #0xe6]
	strh r5, [r0, #0xe8]
	mov r0, #8
	bl ShakeScreen
	ldrh r0, [r4, #2]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0
	mov r2, r0
	mov r1, #3
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r7, #0x138]
	mov r1, #6
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SailPlayer__ChangeAction(StageTask *player, SailPlayerAction action)
{
    SailPlayer *worker   = GetStageTaskWorker(player, SailPlayer);
    SailManager *manager = SailManager__GetWork();

    switch (worker->shipType)
    {
        case SHIP_JET:
        case SHIP_HOVER:
            if (action >= SAILPLAYER_ACTION_COUNT)
                return; // invalid

            if (worker->isRival && manager->isRivalRace == TRUE)
            {
                if (action >= SAILPLAYER_ACTION_8 && action <= SAILPLAYER_ACTION_10)
                {
                    worker->action = action;
                    return;
                }
            }

            if (worker->shipType == SHIP_HOVER)
            {
                if ((action >= SAILPLAYER_ACTION_8 && action <= SAILPLAYER_ACTION_10) || (action >= SAILPLAYER_ACTION_11 && action <= SAILPLAYER_ACTION_14)
                    || action == SAILPLAYER_ACTION_15)
                {
                    worker->action = action;
                    return;
                }
            }
            break;

        case SHIP_BOAT:
            if (action >= SAILPLAYER_ACTION_4)
                return; // invalid
            break;
    }

    if (worker->action != action)
    {
        switch (action)
        {
            default:
                AnimatorMDL__SetAnimation(&player->obj_3d->ani, B3D_ANIM_JOINT_ANIM, player->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], action, NULL);
                SailObject__SetAnimSpeed(player, FLOAT_TO_FX32(1.0));
                break;

            case SAILPLAYER_ACTION_16:
                AnimatorMDL__SetAnimation(&player->obj_3d->ani, B3D_ANIM_JOINT_ANIM, player->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], SAILPLAYER_HOVERANI_spin1, NULL);
                SailObject__SetAnimSpeed(player, FLOAT_TO_FX32(2.0));
                break;

            case SAILPLAYER_ACTION_17:
                AnimatorMDL__SetAnimation(&player->obj_3d->ani, B3D_ANIM_JOINT_ANIM, player->obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], SAILPLAYER_HOVERANI_spin2, NULL);
                SailObject__SetAnimSpeed(player, FLOAT_TO_FX32(2.0));
                break;
        }
    }

    worker->action = action;
}

void SailPlayer__Destructor(Task *task)
{
    StageTask *work    = TaskGetWork(task, StageTask);
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    if (worker->shipSndHandles[0] != NULL)
        ReleaseStageSfx(worker->shipSndHandles[0]);

    if (worker->shipSndHandles[1] != NULL)
        ReleaseStageSfx(worker->shipSndHandles[1]);

    ReleaseStageSfx(worker->sndHandles[0]);
    ReleaseStageSfx(worker->sndHandles[1]);

    ObjDraw__PaletteTex__Release(&worker->paletteTex);

    StageTask_Destructor(task);
}

void SailPlayer__Action_Boost(StageTask *player)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    if (worker->boost >= FLOAT_TO_FX32(30.0) && worker->boostCooldownTimer == 0)
    {
        if ((player->userFlag & SAILPLAYER_FLAG_BOOST) == 0)
        {
            worker->boostCooldownTimer = 6;
            SailPlayer__GiveBoost(player, -SAILPLAYER_BOOST_ACTIVATE_COST);

            if (!worker->isRival)
            {
                SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BREAK);
                SailAudio__PlaySpatialSequence(player->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BOOST_ON, NULL);
            }
        }

        if (worker->maxBoostTimer != 0)
        {
            if ((player->userFlag & SAILPLAYER_FLAG_USED_MAX_BOOST) == 0 && worker->maxBoostTimer < 90)
                worker->maxBoostTimer = 90;

            player->userFlag |= SAILPLAYER_FLAG_USED_MAX_BOOST;
        }

        if ((player->userFlag & SAILPLAYER_FLAG_BOOST) == 0)
        {
            EffectSailBoost__Create(player);

            if (!worker->isRival)
                EffectUnknown2161638__Create(player);

            EffectSailBoost02__Create(player);
            worker->colliders[1].flags &= ~0x2000;
        }

        worker->overSpdLimitTimer = 45;
        worker->speed             = FLOAT_TO_FX32(2.0);
        player->userFlag |= SAILPLAYER_FLAG_BOOST;

        SailPlayer__ColliderFunc(player, 2);
    }
}

void SailPlayer__Action_StopBoost(StageTask *player)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    if ((player->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
    {
        if (!worker->isRival)
            SailAudio__FadeSequence(worker->shipSndHandles[0]);

        if (!worker->isRival)
            SailAudio__PlaySpatialSequence(player->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BOOST_END, NULL);

        player->userFlag &= ~SAILPLAYER_FLAG_BOOST;

        SailPlayer__ColliderFunc(player, 0);
        if (worker->speed > FLOAT_TO_FX32(1.375))
            worker->speed = FLOAT_TO_FX32(1.375);
    }
}

NONMATCH_FUNC void SailPlayer__Action_215A350(StageTask *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x24]
	ldr r4, [r5, #0x124]
	tst r1, #1
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #0x10
	ldmhsia sp!, {r3, r4, r5, pc}
	tst r1, #0x400
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	bic r3, r1, #2
	mov r2, r0
	mov r1, #0x3c
	str r3, [r5, #0x24]
	bl SailAudio__PlaySpatialSequence
	add r0, r4, #0x200
	ldrh r1, [r0, #0x30]
	ldrh r0, [r0, #0x34]
	sub r0, r1, r0
	cmp r0, #8
	mov r0, r5
	ble _0215A3C8
	mov r1, #0x10
	bl SailPlayer__ChangeAction
	mov r0, r5
	bl EffectSailTrick4__Create
	b _0215A3D8
_0215A3C8:
	mov r1, #0x11
	bl SailPlayer__ChangeAction
	mov r0, r5
	bl EffectSailTrick4__Create
_0215A3D8:
	ldr r0, [r5, #0x20]
	add r2, r4, #0x100
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x400
	str r1, [r5, #0x24]
	ldrh r3, [r2, #0x1c]
	mov r1, #2
	orr r3, r3, #0x2000
	strh r3, [r2, #0x1c]
	bl SailPlayer__ColliderFunc
	add r0, r4, #0x100
	mov r1, #0xd
	strh r1, [r0, #0xf8]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SailPlayer__Func_215A41C(StageTask *player)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    if ((player->userFlag & SAILPLAYER_FLAG_400) != 0)
    {
        player->userFlag &= ~SAILPLAYER_FLAG_400;
        SailPlayer__ColliderFunc(player, 0);
        worker->field_1F8 = 0;
        worker->colliders[1].flags &= ~0x2000;
    }
}

NONMATCH_FUNC void SailPlayer__Action_RecoverJetHover(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x124]
	ldr r0, =SailPlayer__State_RecoverJetHover
	str r0, [r4, #0xf4]
	ldr r1, [r4, #0x24]
	tst r1, #0x400
	ldmneia sp!, {r4, pc}
	add r0, r2, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	bne _0215A4A0
	tst r1, #1
	bne _0215A4A0
	ldr r0, [r2, #0x10]
	cmp r0, #0
	bne _0215A4B0
_0215A4A0:
	mov r0, r4
	mov r1, #0
	bl SailPlayer__ChangeAction
	b _0215A4D4
_0215A4B0:
	bl SailManager__GetShipType
	cmp r0, #2
	mov r0, r4
	bne _0215A4CC
	mov r1, #0
	bl SailPlayer__ChangeAction
	b _0215A4D4
_0215A4CC:
	mov r1, #9
	bl SailPlayer__ChangeAction
_0215A4D4:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_RecoverJetHover(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	add r1, r4, #0x100
	ldrh r2, [r1, #0xc0]
	cmp r2, #0
	bgt _0215A50C
	beq _0215A544
	b _0215A720
_0215A50C:
	sub r2, r2, #8
	cmp r2, #9
	addls pc, pc, r2, lsl #2
	b _0215A720
_0215A51C: // jump table
	b _0215A594 // case 0
	b _0215A60C // case 1
	b _0215A65C // case 2
	b _0215A720 // case 3
	b _0215A720 // case 4
	b _0215A720 // case 5
	b _0215A720 // case 6
	b _0215A720 // case 7
	b _0215A6C4 // case 8
	b _0215A6C4 // case 9
_0215A544:
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	bne _0215A56C
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _0215A56C
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215A578
_0215A56C:
	ldr r0, [r5, #0x1c]
	tst r0, #4
	beq _0215A720
_0215A578:
	mov r0, r5
	mov r1, #8
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0215A720
_0215A594:
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	bne _0215A5BC
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _0215A5BC
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215A5E4
_0215A5BC:
	ldr r0, [r5, #0x1c]
	tst r0, #4
	bne _0215A5E4
	mov r0, r5
	mov r1, #0xa
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0215A720
_0215A5E4:
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _0215A720
	mov r0, r5
	mov r1, #9
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _0215A720
_0215A60C:
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	bne _0215A634
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _0215A634
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215A720
_0215A634:
	ldr r0, [r5, #0x1c]
	tst r0, #4
	bne _0215A720
	mov r0, r5
	mov r1, #0xa
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0215A720
_0215A65C:
	add r1, r4, #0x200
	ldrh r1, [r1, #0x3c]
	tst r1, #1
	bne _0215A69C
	ldr r1, [r5, #0x24]
	tst r1, #1
	bne _0215A69C
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _0215A69C
	mov r1, #8
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0215A720
_0215A69C:
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _0215A720
	mov r0, r5
	mov r1, #0
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _0215A720
_0215A6C4:
	ldrsh r2, [r1, #0xf8]
	sub r2, r2, #1
	strh r2, [r1, #0xf8]
	ldrsh r1, [r1, #0xf8]
	cmp r1, #0
	bne _0215A6E0
	bl SailPlayer__Func_215A41C
_0215A6E0:
	add r0, r4, #0x100
	ldrsh r1, [r0, #0xf8]
	cmp r1, #0
	bgt _0215A720
	mov r1, #0
	strh r1, [r0, #0xf8]
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	tst r0, #8
	beq _0215A720
	mov r0, r5
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
_0215A720:
	mov r0, r5
	bl SailPlayer__Func_215BFEC
	mov r0, r5
	bl SailPlayer__CheckInWater
	mov r0, r5
	bl SailObject__SetupAnimator3D
	ldr r0, [r5, #0x1c]
	tst r0, #4
	bicne r0, r0, #4
	strne r0, [r5, #0x1c]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Gimmick_JumpRamp(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, =SailPlayer__State_JumpRamp
	mov r1, #1
	str r2, [r5, #0xf4]
	ldr r2, [r5, #0x24]
	bic r2, r2, #2
	str r2, [r5, #0x24]
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r5, #0x20]
	add r0, r4, #0x100
	strh r1, [r0, #0xd8]
	ldr r0, [r5, #0x24]
	sub r1, r1, #0x380
	orr r0, r0, #0x8000
	str r0, [r5, #0x24]
	ldr r2, [r5, #0x1c]
	mov r0, r5
	orr r2, r2, #0x10
	bic r2, r2, #1
	str r2, [r5, #0x1c]
	str r1, [r5, #0x9c]
	mov r1, #0x1600
	str r1, [r4, #0x10]
	bl SailPlayer__Func_215BD3C
	mov r0, r5
	bl SailPlayer__Func_215BD3C
	mov r0, r5
	bl SailPlayer__Func_215BD3C
	mov r0, r5
	bl SailPlayer__Func_215BD3C
	mov r0, #0
	str r0, [r5, #0x2c]
	ldrh r1, [r4, #2]
	cmp r1, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r2, r0
	mov r1, #3
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r5, #0x138]
	mov r1, #8
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_JumpRamp(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	add r1, r1, #1
	str r1, [r5, #0x2c]
	tst r1, #3
	beq _0215A844
	cmp r1, #0xa
	bge _0215A844
	bl SailPlayer__Func_215BD3C
	mov r0, r5
	bl SailPlayer__Func_215BD3C
_0215A844:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xd8]
	cmp r0, #0
	beq _0215A968
	add r0, r0, #0xa
	mov r1, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl SailPlayer__ChangeAction
	ldr r1, [r5, #0x20]
	mov r0, r5
	orr r1, r1, #4
	str r1, [r5, #0x20]
	ldr r2, [r5, #0x24]
	mov r1, #3
	orr r2, r2, #4
	str r2, [r5, #0x24]
	bl SailPlayer__ColliderFunc
	mov r0, #0
	str r0, [r4, #0x150]
	str r0, [r4, #0x14c]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	ldr r2, =_obj_disp_rand
	ldr r1, =0x3C6EF35F
	cmp r0, #0xc
	moveq r0, #0x800
	streq r0, [r4, #0x150]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #0xb
	moveq r0, #0x800
	streq r0, [r4, #0x14c]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrh r0, [r4, #2]
	beq _0215A904
	cmp r0, #0
	bne _0215A914
	mov r0, #0x55
	bl SailAudio__PlaySequence
	b _0215A914
_0215A904:
	cmp r0, #0
	bne _0215A914
	mov r0, #0x56
	bl SailAudio__PlaySequence
_0215A914:
	add r0, r4, #0x100
	ldrsh r0, [r0, #0xee]
	cmp r0, #0
	mov r0, #0
	mov r2, r0
	bne _0215A938
	mov r1, #0x67
	bl SailAudio__PlaySpatialSequence
	b _0215A940
_0215A938:
	mov r1, #0x68
	bl SailAudio__PlaySpatialSequence
_0215A940:
	add r0, r4, #0x100
	ldrh r1, [r0, #0xd8]
	mov r0, r5
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl EffectSailTrick2__Create
	add r0, r4, #0x100
	mov r1, #0
	strh r1, [r0, #0xd8]
_0215A968:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xc0]
	cmp r0, #0xe
	addls pc, pc, r0, lsl #2
	b _0215AA08
_0215A97C: // jump table
	b _0215AA08 // case 0
	b _0215A9B8 // case 1
	b _0215A9E4 // case 2
	b _0215AA08 // case 3
	b _0215AA08 // case 4
	b _0215AA08 // case 5
	b _0215AA08 // case 6
	b _0215AA08 // case 7
	b _0215AA08 // case 8
	b _0215AA08 // case 9
	b _0215AA08 // case 10
	b _0215AA08 // case 11
	b _0215AA08 // case 12
	b _0215AA08 // case 13
	b _0215AA08 // case 14
_0215A9B8:
	ldr r1, [r5, #0x9c]
	mvn r0, #0x3f
	cmp r1, r0
	ble _0215AA08
	mov r0, r5
	mov r1, #2
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	bic r0, r0, #4
	str r0, [r5, #0x20]
	b _0215AA08
_0215A9E4:
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _0215AA08
	mov r0, r5
	mov r1, #3
	bl SailPlayer__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
_0215AA08:
	mov r0, r5
	bl SailPlayer__Func_215BFEC
	mov r0, r5
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailPlayer__CheckInWater
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailPlayer__Action_RecoverJetHover
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL SailPlayer__CheckInWater(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x1c]
	ldr r4, [r5, #0x124]
	tst r0, #0x10
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x9c]
	cmp r0, #0
	ble _0215AB08
	add r0, r5, #0x44
	bl SailSea__GetSurfacePosition
	ldr r1, [r5, #0x48]
	cmp r1, r0
	ble _0215AB08
	ldr r1, [r5, #0x1c]
	mov r0, r5
	bic r1, r1, #0x10
	orr r1, r1, #1
	str r1, [r5, #0x1c]
	bl EffectSailWaterSplash2__Create
	ldr r0, [r5, #0x9c]
	mov r2, #0
	mov r0, r0, lsl #1
	str r0, [r4, #0x1d0]
	str r0, [r4, #0x1d4]
	str r2, [r5, #0x9c]
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _0215AAC4
	ldr r0, [r5, #0x138]
	mov r1, #9
	bl SailAudio__PlaySpatialSequence
_0215AAC4:
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _0215AB00
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	beq _0215AB00
	mov r0, #0
	mov r2, r0
	mov r1, #1
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r5, #0x138]
	mov r1, #1
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215AB00:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
_0215AB08:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Func_215AB10(SailColliderWork *rect1, SailColliderWork *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x3c
	mov r8, r0
	mov r7, r1
	ldr r1, [r8, #0x6c]
	ldr r0, [r7, #0x6c]
	ldr r4, [r1, #0x124]
	ldr r5, [r0, #0x124]
	bl SailManager__GetWork
	ldr r1, [r8, #0x6c]
	ldr r2, [r0, #0x98]
	ldr r0, [r1, #0x1c]
	tst r0, #0x10
	addne sp, sp, #0x3c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	orr r0, r0, #4
	str r0, [r1, #0x1c]
	ldr r1, [r5, #0x178]
	ldr r0, [r2, #0x44]
	ldr r3, =FX_SinCosTable_
	subs r6, r1, r0
	ldrh r1, [r2, #0x34]
	ldr r0, [r7, #0x28]
	ldr ip, [r8, #0x28]
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	add r5, r0, ip
	ldrsh r2, [r3, r2]
	add r0, sp, #0x18
	rsbmi r6, r6, #0
	sub r5, r5, #0x100
	bl MTX_RotY33_
	ldr r0, [r8, #0x6c]
	add r1, sp, #0x18
	add r2, sp, #0xc
	add r0, r0, #0x44
	bl MTX_MultVec33
	ldr r0, [r7, #0x6c]
	add r1, sp, #0x18
	add r2, sp, #0
	add r0, r0, #0x44
	bl MTX_MultVec33
	ldr r1, [sp, #0xc]
	ldr r0, [sp]
	ldr r2, [r7, #0x28]
	subs r0, r1, r0
	ldr r1, [r8, #0x28]
	rsbmi r0, r0, #0
	add r1, r2, r1
	bl FX_Div
	mov r0, r0, lsl #0x12
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r1, r0, #1
	ldr r0, =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh r1, [r0, r1]
	mov r0, #0
	smull r2, r1, r5, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r6, r6, r2
	cmp r6, #0
	movgt r6, r0
	ldr r0, [r4, #0x10]
	cmp r0, r6
	strgt r6, [r4, #0x10]
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void SailPlayer__OnDefend_JetHover(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SailColliderWork *colliderPlayer = rect2->userData;
    SailColliderWork *colliderOther  = rect1->userData;

    StageTask *player        = colliderPlayer->stageTask;
    SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);

    if ((colliderOther->flags & 0x4000) != 0)
    {
        SailPlayer__Func_215AB10(colliderPlayer, colliderOther);
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else if ((colliderOther->flags & 0x100) != 0)
    {
        SailPlayer__Gimmick_DashPanel(colliderPlayer->stageTask, 12, 0);
    }
    else if ((player->userFlag & SAILPLAYER_FLAG_IS_HURT) != 0 && (colliderOther->flags & 0x200) != 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        player->hitstopTimer                   = FLOAT_TO_FX32(4.0);
        colliderOther->stageTask->hitstopTimer = FLOAT_TO_FX32(4.0);
        colliderPlayer->stageTask->shakeTimer  = FLOAT_TO_FX32(4.0);
        colliderOther->stageTask->shakeTimer   = FLOAT_TO_FX32(4.0);

        VecFx32 hitPos;
        VEC_Add(&colliderPlayer->stageTask->position, &colliderOther->stageTask->position, &hitPos);
        hitPos.x >>= 1;
        hitPos.y >>= 1;
        hitPos.z >>= 1;
        EffectSailHit__Create(&hitPos);

        if ((colliderOther->flags & 0x200) != 0)
        {
            s32 touchPos;
            s32 otherPos;
            s32 py;

            NNS_G3dWorldPosToScrPos(&colliderPlayer->stageTask->position, &touchPos, &py);
            NNS_G3dWorldPosToScrPos(&colliderOther->stageTask->position, &otherPos, &py);

            if (touchPos < otherPos)
                touchPos -= 64;
            else
                touchPos += 64;

            if (touchPos < 0)
                touchPos = 0;
            else if (touchPos > HW_LCD_WIDTH - 1)
                touchPos = HW_LCD_WIDTH - 1;

            playerWorker->touchPos.x = touchPos;
            SailPlayer__Action_HurtJetHover1(colliderPlayer->stageTask);
        }
        else
        {
            EffectUnknown21614E4__Create(colliderPlayer->stageTask);
            ShakeScreen(SCREENSHAKE_D_LONG);
            SailPlayer__RemoveHealth(colliderPlayer->stageTask, colliderOther->atkPower);

            if (SailPlayer__HasRetired(colliderPlayer->stageTask))
            {
                ShakeScreen(SCREENSHAKE_D_LOOP);
                SailPlayer__Action_RetireJetHover(colliderPlayer->stageTask);
            }
            else
            {
                SailPlayer__Action_HurtJetHover2(colliderPlayer->stageTask);
            }
        }
    }
}

void SailPlayer__Action_HurtJetHover2(StageTask *player)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    SailPlayer__Func_215A41C(player);
    SetTaskState(player, SailPlayer__State_HurtJetHover1);
    SailPlayer__ChangeAction(player, SAILPLAYER_ACTION_6);

    player->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    worker->scoreComboCurrent = 0;
    worker->blinkTimer      = 64;
    player->userFlag |= SAILPLAYER_FLAG_IS_HURT;
    player->userTimer = 32;

    SailPlayer__ColliderFunc(player, 1);

    if (SailManager__GetShipType() != SHIP_HOVER)
        worker->speed >>= 1;

    if (!worker->isRival)
        SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_OWA);

    SailAudio__PlaySpatialSequence(player->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_DAMAGE, NULL);

    if (player->velocity.y < FLOAT_TO_FX32(0.0))
        player->velocity.y = FLOAT_TO_FX32(0.0);
}

void SailPlayer__State_HurtJetHover1(StageTask *work)
{
    SailPlayer__Func_215BFEC(work);
    SailObject__SetupAnimator3D(work);
    SailPlayer__CheckInWater(work);

    work->userTimer--;
    if (work->userTimer == 0)
    {
        work->userFlag &= ~SAILPLAYER_FLAG_IS_HURT;
        SailPlayer__Action_RecoverJetHover(work);
    }
}

void SailPlayer__Action_HurtJetHover1(StageTask *player)
{
    SailPlayer *worker = GetStageTaskWorker(player, SailPlayer);

    SetTaskState(player, SailPlayer__State_HurtJetHover2);
    SailPlayer__ChangeAction(player, SAILPLAYER_ACTION_0);

    player->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->userFlag |= SAILPLAYER_FLAG_IS_HURT;
    player->userTimer = 6;
    worker->field_1EA = 6;
    worker->speed -= worker->speed >> 3;

    if (!worker->isRival)
        SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_OWA);

    SailAudio__PlaySpatialSequence(player->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_DAMAGE, NULL);
}

void SailPlayer__State_HurtJetHover2(StageTask *work)
{
    SailPlayer__Func_215BFEC(work);
    SailObject__SetupAnimator3D(work);
    SailPlayer__CheckInWater(work);

    work->userTimer--;
    if (work->userTimer == 0)
    {
        work->userFlag &= ~SAILPLAYER_FLAG_IS_HURT;
        SailPlayer__Action_RecoverJetHover(work);
    }
}

NONMATCH_FUNC void SailPlayer__Action_RetireJetHover(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	mov r5, r0
	ldr r0, [r5, #0x24]
	tst r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl SailPlayer__ReachedGoal
	ldr r0, =SailPlayer__State_RetireJetHover
	str r0, [r6, #0xf4]
	bl SailManager__GetShipType
	cmp r0, #2
	mov r0, r6
	bne _0215B02C
	mov r1, #0
	bl SailPlayer__ChangeAction
	b _0215B034
_0215B02C:
	mov r1, #0xf
	bl SailPlayer__ChangeAction
_0215B034:
	ldr r0, [r6, #0x20]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldr r0, [r6, #0x24]
	orr r0, r0, #2
	str r0, [r6, #0x24]
	str r1, [r4, #0x10]
	ldr r0, [r6, #0x9c]
	cmp r0, #0
	strlt r1, [r6, #0x9c]
	ldr r1, [r6, #0x18]
	mov r0, #0
	orr r1, r1, #2
	str r1, [r6, #0x18]
	str r0, [r6, #0x2c]
	ldr r0, [r5, #0x24]
	tst r0, #0x10000000
	bne _0215B088
	mov r0, #8
	bl EffectUnknown21615C8__Create
_0215B088:
	bl SailRetireEvent__CreateFailText
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _0215B0A0
	mov r0, #0x54
	bl SailAudio__PlaySequence
_0215B0A0:
	ldr r0, [r6, #0x138]
	mov r1, #0xe
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldrh r0, [r4, #0]
	mov r2, #0
	cmp r0, #2
	ldr r0, [r6, #0x138]
	bne _0215B0D0
	mov r1, #0x3d
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r4, r5, r6, pc}
_0215B0D0:
	mov r1, #0x10
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_RetireJetHover(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	add r0, r5, #0x100
	ldrsh r0, [r0, #0xcc]
	cmp r0, #0
	beq _0215B128
	mov r1, #0x200
	bl ObjSpdDownSet
	add r1, r5, #0x100
	strh r0, [r1, #0xcc]
	ldrsh r0, [r1, #0xcc]
	strh r0, [r4, #0x34]
	ldrh r0, [r5, #0]
	cmp r0, #2
	ldreqsh r0, [r4, #0x34]
	moveq r0, r0, asr #2
	streqh r0, [r4, #0x34]
_0215B128:
	mov r0, r4
	bl SailPlayer__CheckInWater
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	tst r0, #1
	bne _0215B14C
	mov r0, r4
	bl SailPlayer__Func_215BAF0
_0215B14C:
	mov r0, r4
	bl SailObject__SetupAnimator3D
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_RivalReachedGoal(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #8
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl SailPlayer__ReachedGoal
	ldr r1, =SailPlayer__State_RivalReachedGoal
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, #0xf
	bl SailPlayer__ChangeAction
	ldr r1, [r4, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x24]
	orr r1, r1, #2
	str r1, [r4, #0x24]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	str r0, [r4, #0x2c]
	bl SailRetireEvent__CreateFailText
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_RivalReachedGoal(StageTask *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	add r0, r5, #0x100
	ldrsh r0, [r0, #0xcc]
	cmp r0, #0
	beq _0215B20C
	mov r1, #0x200
	bl ObjSpdDownSet
	add r1, r5, #0x100
	strh r0, [r1, #0xcc]
	ldrsh r0, [r1, #0xcc]
	strh r0, [r4, #0x34]
	ldrh r0, [r5, #0]
	cmp r0, #2
	ldreqsh r0, [r4, #0x34]
	moveq r0, r0, asr #2
	streqh r0, [r4, #0x34]
_0215B20C:
	mov r0, r4
	bl SailPlayer__CheckInWater
	mov r0, r4
	bl SailObject__SetupAnimator3D
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void SailPlayer__Action_RecoverBoat(StageTask *player)
{
    SetTaskState(player, SailPlayer__State_RecoverBoat);

    SailPlayer__ChangeAction(player, SAILPLAYER_ACTION_0);
    player->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
}

void SailPlayer__State_RecoverBoat(StageTask *work)
{
    SailObject__SetupAnimator3D(work);
}

NONMATCH_FUNC void SailPlayer__OnDefend_Boat(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	ldr r4, [r1, #0x3c]
	ldr r5, [r0, #0x3c]
	bl SailManager__GetWork
	ldr r2, [r4, #0x6c]
	mov r6, r0
	ldrh r0, [r2, #0]
	mov r7, #0
	mov r1, #0x4000
	cmp r0, #0
	ldreq r7, [r2, #0x124]
	str r1, [r2, #8]
	ldr r0, [r5, #0x6c]
	add r2, sp, #0xc
	str r1, [r0, #8]
	ldr r0, [r4, #0x6c]
	str r1, [r0, #4]
	ldr r0, [r5, #0x6c]
	str r1, [r0, #4]
	ldr r0, [r4, #0x6c]
	ldr r1, [r5, #0x6c]
	add r0, r0, #0x44
	add r1, r1, #0x44
	bl VEC_Add
	ldr r0, [r4, #0x6c]
	add r1, sp, #0
	bl SailObject__Func_2165A9C
	add r0, sp, #0xc
	add r1, sp, #0
	mov r2, r0
	bl VEC_Subtract
	ldr r2, [sp, #0xc]
	ldr r1, [sp, #0x10]
	mov r2, r2, asr #1
	str r2, [sp, #0xc]
	mov r2, r1, asr #1
	ldr r0, [sp, #0x14]
	str r2, [sp, #0x10]
	mov r1, r0, asr #1
	add r0, sp, #0xc
	str r1, [sp, #0x14]
	bl EffectSailHit__Create
	ldr r0, [r6, #0x24]
	tst r0, #0x200
	bne _0215B31C
	ldr r0, [r4, #0x6c]
	ldr r1, [r5, #0x70]
	bl SailPlayer__RemoveHealth
_0215B31C:
	ldr r0, [r4, #0x6c]
	bl SailPlayer__HasRetired
	cmp r0, #0
	beq _0215B350
	ldr r0, [r4, #0x6c]
	add r1, sp, #0xc
	bl EffectUnknown2161544__Create
	mov r0, #9
	bl ShakeScreen
	ldr r0, [r4, #0x6c]
	bl SailPlayer__Action_RetireBoat
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215B350:
	cmp r7, #0
	beq _0215B388
	ldr r0, [r7, #0x210]
	cmp r0, #0x64000
	ble _0215B388
	ldr r0, [r4, #0x6c]
	add r1, sp, #0xc
	bl EffectUnknown2161544__Create
	mov r0, #9
	bl ShakeScreen
	ldr r0, [r4, #0x6c]
	bl SailPlayer__Action_BigHurtBoat
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215B388:
	mov r0, #7
	bl ShakeScreen
	ldr r0, [r4, #0x6c]
	bl SailPlayer__Action_SmallHurtBoat
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_SmallHurtBoat(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x124]
	ldr r2, =SailPlayer__State_HurtBoat
	add r1, r1, #0x100
	str r2, [r4, #0xf4]
	mov r3, #0
	ldr r2, =0x0000FFFF
	strh r3, [r1, #0xc4]
	strh r2, [r1, #0xc0]
	mov r1, #1
	bl SailPlayer__ChangeAction
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x138]
	mov r1, #0x23
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	ands r0, r0, #3
	beq _0215B434
	cmp r0, #1
	beq _0215B440
	mov r0, #0x5e
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B434:
	mov r0, #0x54
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B440:
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	beq _0215B458
	mov r0, #0x5f
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B458:
	mov r0, #0x5e
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_BigHurtBoat(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x124]
	ldr r2, =SailPlayer__State_HurtBoat
	add r1, r1, #0x100
	str r2, [r4, #0xf4]
	mov r2, #0
	strh r2, [r1, #0xc4]
	mov r2, #0x40
	strh r2, [r1, #0xc2]
	ldr r2, [r4, #0x24]
	mov r1, #1
	orr r2, r2, #2
	str r2, [r4, #0x24]
	bl SailPlayer__ColliderFunc
	mov r0, r4
	mov r1, #2
	bl SailPlayer__ChangeAction
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x138]
	mov r1, #0x24
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	beq _0215B4FC
	mov r0, #0x60
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B4FC:
	mov r0, #0x61
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_HurtBoat(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailObject__SetupAnimator3D
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x24]
	mov r0, r4
	bic r1, r1, #2
	str r1, [r4, #0x24]
	bl SailPlayer__Action_RecoverBoat
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_RetireBoat(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r5, [r6, #0x124]
	bl SailManager__GetWork
	mov r4, r0
	ldr r0, [r4, #0x24]
	tst r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x100
	mov r2, #0
	ldr r1, =SailPlayer__State_215B618
	strh r2, [r0, #0xc4]
	mov r0, r6
	str r1, [r6, #0xf4]
	mov r1, #3
	bl SailPlayer__ChangeAction
	ldr r0, [r6, #0x20]
	mov r2, #0
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldr r1, [r6, #0x24]
	mov r0, r6
	orr r1, r1, #2
	str r1, [r6, #0x24]
	str r2, [r5, #0x10]
	ldr r1, [r6, #0x18]
	orr r1, r1, #2
	str r1, [r6, #0x18]
	str r2, [r6, #0x2c]
	bl SailPlayer__Func_215B6B8
	ldr r0, [r4, #0x24]
	tst r0, #0x10000000
	bne _0215B5CC
	mov r0, #8
	bl EffectUnknown21615C8__Create
_0215B5CC:
	bl SailRetireEvent__CreateFailText
	ldr r0, [r6, #0x138]
	mov r1, #0x24
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	beq _0215B5F8
	mov r0, #0x60
	bl SailAudio__PlaySequence
	b _0215B600
_0215B5F8:
	mov r0, #0x61
	bl SailAudio__PlaySequence
_0215B600:
	ldr r0, [r6, #0x138]
	mov r1, #0x26
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_215B618(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	moveq r0, #0x4000
	streq r0, [r4, #4]
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	beq _0215B650
	cmp r0, #0x28
	beq _0215B65C
	cmp r0, #0x30
	beq _0215B680
	b _0215B6A0
_0215B650:
	mov r0, #0
	bl CreateScreenEffect
	b _0215B6A0
_0215B65C:
	mov r1, #0x4000
	mov r0, #4
	str r1, [r4, #4]
	bl ShakeScreen
	mov r0, r4
	bl SailPlayer__Func_215B6B8
	mov r0, #0
	bl CreateScreenEffect
	b _0215B6A0
_0215B680:
	mov r1, #0x4000
	mov r0, #0xe
	str r1, [r4, #4]
	bl ShakeScreen
	mov r0, r4
	bl SailPlayer__Func_215B6B8
	mov r0, #0
	bl CreateScreenEffect
_0215B6A0:
	mov r0, r4
	bl SailObject__SetupAnimator3D
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Func_215B6B8(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r10, r0
	ldr r0, =0x00007FFE
	mvn r4, #0x1000
	sub r0, r0, #0x4000
	str r0, [sp]
	ldr r0, =0x00007FFE
	ldr r5, =0x00196225
	ldr r6, =0x3C6EF35F
	mov r9, #0
	add r11, r0, #0x8000
	add r7, r4, #0x9000
	add r8, sp, #0x28
_0215B6F0:
	ldr r0, =_obj_disp_rand
	ldr r1, [r0, #0]
	add r0, sp, #4
	mla r2, r1, r5, r6
	mov r1, r2, lsr #0x10
	mov r3, r1, lsl #0x10
	ldr r1, =0x00007FFE
	and r3, r1, r3, lsr #16
	rsb r1, r3, r1, lsr #1
	str r1, [sp, #0x28]
	mla r1, r2, r5, r6
	mov r2, r1, lsr #0x10
	mov r3, r2, lsl #0x10
	ldr r2, [sp]
	and r2, r2, r3, lsr #16
	sub r2, r4, r2
	str r2, [sp, #0x2c]
	mla r2, r1, r5, r6
	ldr r1, =_obj_disp_rand
	str r2, [r1]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r11, r1, lsr #16
	sub r1, r7, r1
	str r1, [sp, #0x30]
	ldrh r1, [r10, #0x32]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	ldr r1, =FX_SinCosTable_
	mov r3, r2, lsl #1
	ldrsh r1, [r1, r3]
	ldr r3, =FX_SinCosTable_
	add r2, r3, r2, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	mov r0, r8
	add r1, sp, #4
	mov r2, r8
	bl MTX_MultVec33
	mov r0, r8
	add r1, r10, #0x44
	mov r2, r8
	bl VEC_Add
	mov r0, r10
	mov r1, r8
	bl EffectUnknown2161544__Create
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #2
	blo _0215B6F0
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_RecoverSubmarine(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =SailPlayer__State_RecoverSubmarine
	mov r4, r0
	str r1, [r4, #0xf4]
	mov r1, #0
	bl SailPlayer__ChangeAction
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_RecoverSubmarine(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =SailObject__SetupAnimator3D
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__OnDefend_Submarine(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r5, [r0, #0x3c]
	ldr r4, [r1, #0x3c]
	ldr r0, [r5, #0x6c]
	add r0, r0, #0x44
	bl EffectSailHit__Create
	ldr r0, [r4, #0x6c]
	ldr r1, [r5, #0x70]
	bl SailPlayer__RemoveHealth
	ldr r0, [r4, #0x6c]
	bl SailPlayer__HasRetired
	cmp r0, #0
	ldr r0, [r4, #0x6c]
	beq _0215B86C
	add r1, sp, #0
	bl EffectUnknown2161544__Create
	mov r0, #9
	bl ShakeScreen
	ldr r0, [r4, #0x6c]
	bl SailPlayer__Action_RetireSubmarine
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
_0215B86C:
	bl SailPlayer__Action_HurtSubmarine
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_HurtSubmarine(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x124]
	ldr r2, =SailPlayer__State_HurtSubmarine
	add r1, r1, #0x100
	str r2, [r4, #0xf4]
	mov r3, #0
	ldr r2, =0x0000FFFF
	strh r3, [r1, #0xc4]
	strh r2, [r1, #0xc0]
	mov r1, #1
	bl SailPlayer__ChangeAction
	ldr r1, [r4, #0x24]
	mov r0, #0x20
	orr r1, r1, #2
	str r1, [r4, #0x24]
	ldr r2, [r4, #0x20]
	mov r1, #0x4a
	bic r2, r2, #4
	str r2, [r4, #0x20]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x138]
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	ands r0, r0, #3
	beq _0215B918
	cmp r0, #1
	beq _0215B924
	mov r0, #0x5e
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B918:
	mov r0, #0x54
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B924:
	bl SaveGame__BlazeUnlocked
	cmp r0, #0
	beq _0215B93C
	mov r0, #0x5f
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}
_0215B93C:
	mov r0, #0x5e
	bl SailAudio__PlaySequence
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_HurtSubmarine(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailObject__SetupAnimator3D
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x24]
	mov r0, r4
	bic r1, r1, #2
	str r1, [r4, #0x24]
	bl SailPlayer__Action_RecoverSubmarine
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Action_RetireSubmarine(StageTask *player){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r5, [r6, #0x124]
	bl SailManager__GetWork
	mov r4, r0
	ldr r0, [r4, #0x24]
	tst r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x100
	mov r2, #0
	ldr r1, =SailPlayer__State_RetireSubmarine
	strh r2, [r0, #0xc4]
	mov r0, r6
	str r1, [r6, #0xf4]
	mov r1, #2
	bl SailPlayer__ChangeAction
	ldr r0, [r6, #0x20]
	mov r2, #0
	bic r0, r0, #4
	str r0, [r6, #0x20]
	ldr r1, [r6, #0x24]
	mov r0, r6
	orr r1, r1, #2
	str r1, [r6, #0x24]
	str r2, [r5, #0x10]
	ldr r1, [r6, #0x18]
	orr r1, r1, #2
	str r1, [r6, #0x18]
	str r2, [r6, #0x2c]
	bl SailPlayer__Func_215B6B8
	ldr r0, [r4, #0x24]
	tst r0, #0x10000000
	bne _0215BA1C
	mov r0, #8
	bl EffectUnknown21615C8__Create
_0215BA1C:
	ldr r0, [r6, #0x138]
	mov r1, #0x4b
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldr r0, [r6, #0x138]
	mov r1, #0x4c
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	mov r0, #0x60
	bl SailAudio__PlaySequence
	bl SailRetireEvent__CreateFailText
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__State_RetireSubmarine(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	moveq r0, #0x4000
	streq r0, [r4, #4]
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	beq _0215BA88
	cmp r0, #0x28
	beq _0215BA94
	cmp r0, #0x30
	beq _0215BAB8
	b _0215BAD8
_0215BA88:
	mov r0, #0
	bl CreateScreenEffect
	b _0215BAD8
_0215BA94:
	mov r1, #0x4000
	mov r0, #4
	str r1, [r4, #4]
	bl ShakeScreen
	mov r0, r4
	bl SailPlayer__Func_215B6B8
	mov r0, #0
	bl CreateScreenEffect
	b _0215BAD8
_0215BAB8:
	mov r1, #0x4000
	mov r0, #0xe
	str r1, [r4, #4]
	bl ShakeScreen
	mov r0, r4
	bl SailPlayer__Func_215B6B8
	mov r0, #0
	bl CreateScreenEffect
_0215BAD8:
	mov r0, r4
	bl SailObject__SetupAnimator3D
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Func_215BAF0(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r4, r0
	bl SailManager__GetWork
	ldr r7, =_obj_disp_rand
	ldr r1, =0x00196225
	ldr r3, [r7, #0]
	ldr r2, =0x3C6EF35F
	ldr r6, =0x000007FF
	mla r5, r3, r1, r2
	mla r3, r5, r1, r2
	mla r1, r3, r1, r2
	mov r2, r5, lsr #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	and r3, r6, r3, lsr #16
	rsb ip, r3, #0x400
	mov r2, r2, lsl #0x10
	and r2, r6, r2, lsr #16
	rsb r2, r2, #0x400
	mov r8, r1, lsr #0x10
	mov r5, r0
	mov r0, r8, lsl #0x10
	add r3, r6, #0x1800
	and r0, r3, r0, lsr #16
	rsb r0, r0, #0x1000
	str r0, [sp, #0x2c]
	str r2, [sp, #0x24]
	str ip, [sp, #0x28]
	str r1, [r7]
	ldrh r1, [r4, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x24
	add r1, r4, #0x44
	mov r2, r0
	bl VEC_Add
	add r0, sp, #0x24
	bl EffectSailSmoke__Create
	mov r6, r7
	ldr r1, [r6, #0]
	ldr ip, =0x00196225
	ldr lr, =0x3C6EF35F
	mov r4, r0
	mla r2, r1, ip, lr
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x7f
	str r2, [r6]
	sub r1, r1, #0x200
	str r1, [r4, #0x9c]
	ldr r1, [r6, #0]
	mla r2, r1, ip, lr
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	str r2, [r6]
	add r1, r1, #8
	str r1, [r4, #0xa8]
	ldr r1, [r6, #0]
	mla r2, r1, ip, lr
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xff
	str r2, [r6]
	rsb r1, r1, #0x80
	str r1, [r4, #0x98]
	ldr r1, [r6, #0]
	ldr r2, =0x000007FF
	mla r3, r1, ip, lr
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	str r3, [r6]
	rsb r1, r1, #4
	str r1, [r4, #0xa4]
	ldr r7, [r6, #0]
	mov r3, #0x800
	mla r1, r7, ip, lr
	mov r7, r1, lsr #0x10
	mov r7, r7, lsl #0x10
	mov r7, r7, lsr #0x10
	and r7, r7, #0xff
	str r1, [r6]
	rsb r1, r7, #0x80
	str r1, [r4, #0xa0]
	ldr r8, [r6, #0]
	ldr r1, =0x00005294
	mla r7, r8, ip, lr
	mov r8, r7, lsr #0x10
	mov r8, r8, lsl #0x10
	mov r8, r8, lsr #0x10
	and r8, r8, #7
	str r7, [r6]
	rsb r7, r8, #4
	str r7, [r4, #0xac]
	ldr r8, [r4, #0xa4]
	ldr r7, [r5, #0x34]
	sub r7, r8, r7, asr #8
	str r7, [r4, #0xa4]
	ldr r7, [r4, #0xac]
	ldr r5, [r5, #0x3c]
	sub r5, r7, r5, asr #8
	str r5, [r4, #0xac]
	ldr r7, [r6, #0]
	mla r5, r7, ip, lr
	mov r7, r5, lsr #0x10
	mov r7, r7, lsl #0x10
	and r2, r2, r7, lsr #16
	rsb r7, r2, #0x1000
	mov r2, r7, asr #0x1f
	mov r2, r2, lsl #7
	adds r3, r3, r7, lsl #7
	orr r2, r2, r7, lsr #25
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	str r5, [r6]
	orr r3, r3, r2, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	bl SailObject__Func_2164D10
	mov r0, r4
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Func_215BD3C(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldrh r0, [r4, #0]
	cmp r0, #0
	cmpne r0, #2
	bne _0215BDD4
	mov r2, #0
	sub r1, r2, #0x400
	mov r0, #0x1800
	str r2, [sp, #0x24]
	str r1, [sp, #0x28]
	str r0, [sp, #0x2c]
	ldrh r1, [r5, #0x32]
	ldr r2, =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [r2, r1]
	smull r3, r1, r0, r1
	adds r3, r3, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [sp, #0x24]
	ldrh r1, [r5, #0x32]
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r2, r1]
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x2c]
_0215BDD4:
	add r0, sp, #0x24
	add r1, r5, #0x44
	mov r2, r0
	bl VEC_Add
	add r0, sp, #0x24
	bl EffectSailWaterSplash__Create
	mov r4, r0
	ldr r0, [r4, #0x24]
	ldr r3, =_obj_disp_rand
	orr r0, r0, #1
	str r0, [r4, #0x24]
	ldr r0, [r3, #0]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	mov r6, #8
	mla lr, r0, r1, r2
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and ip, r0, #0xff
	mvn r0, #0x7f
	str lr, [r3]
	sub r0, r0, ip
	str r0, [r4, #0x9c]
	str r6, [r4, #0xa8]
	ldr r3, =_mt_math_rand
	sub r6, r6, #0x18
	ldr r0, [r3, #0]
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xff
	str ip, [r3]
	add r0, r0, #0x180
	str r0, [r4, #0x98]
	str r6, [r4, #0xa4]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r3]
	tst r0, #1
	beq _0215BEA0
	ldr r0, [r4, #0x98]
	rsb r0, r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0xa4]
	rsb r0, r0, #0
	str r0, [r4, #0xa4]
_0215BEA0:
	ldr r3, =_obj_disp_rand
	mov r2, #0x380
	ldr r6, [r3, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	rsb r2, r2, #0
	mla r1, r6, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x7f
	str r1, [r3]
	sub r0, r2, r0
	str r0, [r4, #0xa0]
	ldrh r1, [r5, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r4, #0x98
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	ldrh r0, [r5, #0x32]
	ldr r3, =FX_SinCosTable_
	ldr r1, [r4, #0xa4]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r3, r0]
	ldr lr, =_obj_disp_rand
	mov ip, #0x800
	smull r2, r0, r1, r0
	adds r2, r2, #0x800
	adc r1, r0, #0
	mov r0, r2, lsr #0xc
	orr r0, r0, r1, lsl #20
	str r0, [r4, #0xa4]
	ldrh r2, [r5, #0x32]
	ldr r1, =0x00196225
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r5, [r3, r2]
	ldr r2, =0x3C6EF35F
	sub r3, ip, #1
	smull r6, r5, r0, r5
	adds r6, r6, #0x800
	adc r0, r5, #0
	mov r5, r6, lsr #0xc
	orr r5, r5, r0, lsl #20
	str r5, [r4, #0xac]
	ldr r5, [lr]
	mov r0, r4
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r3, r1, lsr #16
	str r2, [lr]
	rsb r2, r1, #0x1000
	mov r1, r2, asr #0x1f
	mov r1, r1, lsl #7
	adds r3, ip, r2, lsl #7
	orr r1, r1, r2, lsr #25
	adc r1, r1, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Func_215BFEC(StageTask *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r5, #0x24]
	mov r6, r0
	tst r1, #0x10
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldrh r0, [r4, #0]
	cmp r0, #0
	cmpne r0, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	beq _0215C210
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0215C04C
	ldr r1, [r4, #0x254]
	ldr r0, [r4, #0x18]
	subs r0, r1, r0
	rsbmi r0, r0, #0
	b _0215C188
_0215C04C:
	bl SailManager__GetWork
	ldr r1, [r5, #0x24]
	ldr r8, [r5, #0x44]
	ldr r2, [r4, #0x18]
	ldr r7, [r5, #0x4c]
	ldr r3, [r4, #0x20]
	tst r1, #1
	sub r2, r8, r2
	sub r3, r7, r3
	ldr r0, [r0, #0x98]
	beq _0215C0D8
	ldrh r0, [r0, #0x34]
	ldr r7, =FX_SinCosTable_
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r8, r0, lsl #1
	add r0, r8, #1
	mov r1, r0, lsl #1
	mov r0, r8, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r0, [r7, r0]
	smull r1, r7, r2, r1
	adds r2, r1, #0x800
	smull r1, r0, r3, r0
	adc r7, r7, #0
	adds r1, r1, #0x800
	mov r2, r2, lsr #0xc
	adc r0, r0, #0
	mov r3, r1, lsr #0xc
	orr r2, r2, r7, lsl #20
	orr r3, r3, r0, lsl #20
_0215C0D8:
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r3, #0
	rsblt r3, r3, #0
	cmp r2, r3
	ldr r0, =0x00000F5E
	ldr r7, =0x0000065D
	mov r8, #0
	ble _0215C144
	umull r1, lr, r2, r0
	mla lr, r2, r8, lr
	umull ip, r9, r3, r7
	mov r2, r2, asr #0x1f
	mla lr, r2, r0, lr
	adds r1, r1, #0x800
	adc r0, lr, #0
	adds r2, ip, #0x800
	mov ip, r1, lsr #0xc
	mla r9, r3, r8, r9
	mov r1, r3, asr #0x1f
	mla r9, r1, r7, r9
	adc r1, r9, #0
	mov r2, r2, lsr #0xc
	orr ip, ip, r0, lsl #20
	orr r2, r2, r1, lsl #20
	add r0, ip, r2
	b _0215C188
_0215C144:
	umull r1, r9, r3, r0
	mla r9, r3, r8, r9
	mov r3, r3, asr #0x1f
	umull lr, ip, r2, r7
	mla r9, r3, r0, r9
	adds r1, r1, #0x800
	adc r0, r9, #0
	mov r9, r1, lsr #0xc
	mla ip, r2, r8, ip
	mov r1, r2, asr #0x1f
	adds r3, lr, #0x800
	mla ip, r1, r7, ip
	adc r1, ip, #0
	mov r2, r3, lsr #0xc
	orr r9, r9, r0, lsl #20
	orr r2, r2, r1, lsl #20
	add r0, r9, r2
_0215C188:
	cmp r0, #0x200
	ble _0215C210
	add r1, r0, #0x400
	cmp r1, #0x1a00
	movgt r1, #0x1a00
	add r0, r4, #0x100
	strh r1, [r0, #0xcc]
	ldrh r1, [r4, #2]
	cmp r1, #0
	beq _0215C1D0
	ldr r2, [r4, #0x254]
	ldr r1, [r4, #0x18]
	cmp r2, r1
	ble _0215C210
	ldrsh r1, [r0, #0xcc]
	rsb r1, r1, #0
	strh r1, [r0, #0xcc]
	b _0215C210
_0215C1D0:
	ldr r3, [r5, #0x44]
	ldr r0, [r4, #0x18]
	ldr r2, [r5, #0x4c]
	ldr r1, [r4, #0x20]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r5, #0x32]
	bl ObjRoopDiff16
	cmp r0, #0
	ble _0215C210
	add r0, r4, #0x100
	ldrsh r1, [r0, #0xcc]
	rsb r1, r1, #0
	strh r1, [r0, #0xcc]
_0215C210:
	add r0, r4, #0x100
	ldrsh r0, [r0, #0xcc]
	mov r1, #0x200
	strh r0, [r5, #0x34]
	ldrh r0, [r4, #0]
	cmp r0, #2
	ldreqsh r0, [r5, #0x34]
	moveq r0, r0, asr #2
	streqh r0, [r5, #0x34]
	add r0, r4, #0x100
	ldrsh r0, [r0, #0xcc]
	bl ObjSpdDownSet
	add r1, r4, #0x100
	strh r0, [r1, #0xcc]
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0215C3F4
	bl SailManager__GetWork
	ldr r7, [r0, #0x98]
	ldr r8, [r4, #0x25c]
	ldr r2, [r5, #8]
	mov r0, r8, asr #0x13
	mov r0, r0, lsl #0x10
	ldr r3, [r7, #0xc0]
	mov r0, r0, lsr #0x10
	mov r1, #0x28
	mla r6, r0, r1, r3
	cmp r2, #0
	ldreq r1, [r4, #0x10]
	addeq r1, r8, r1
	streq r1, [r4, #0x25c]
	ldr r1, [r4, #0x25c]
	cmp r0, r1, asr #19
	ble _0215C2BC
	ldrh r2, [r6, #2]
	add r1, r4, #0x200
	cmp r0, #0
	strh r2, [r1, #0x60]
	beq _0215C2BC
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	sub r6, r6, #0x28
_0215C2BC:
	ldr r1, [r4, #0x25c]
	cmp r0, r1, asr #19
	bge _0215C2D8
	add r6, r6, #0x28
	ldrh r1, [r6, #2]
	add r0, r4, #0x200
	strh r1, [r0, #0x60]
_0215C2D8:
	mov r0, r6
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r4, #0x25c]
	ldr r2, =0x0007FFFF
	mov r1, r0
	and r0, r3, r2
	bl FX_Div
	mov r8, r0
	mov r0, r6
	mov r1, r8
	bl SailVoyageManager__GetAngleForSegmentPos
	add r1, r4, #0x200
	strh r0, [r1, #0x60]
	mov r0, #0x1000
	str r0, [sp]
	ldr r0, [r4, #0x254]
	ldr r1, [r4, #0x18]
	mov r2, #1
	mov r3, #0x10000
	bl ObjShiftSet
	str r0, [r4, #0x254]
	mov r1, r8
	mov r0, r6
	add r2, r5, #0x44
	add r3, r5, #0x4c
	bl SailVoyageManager__Func_2158888
	add r6, r4, #0x200
	ldrh r2, [r6, #0x60]
	ldr ip, =FX_SinCosTable_
	mov r1, r7
	rsb r2, r2, #0
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r7, [ip, r2]
	ldr r3, [r4, #0x254]
	ldr lr, [r5, #0x44]
	smull r8, r7, r3, r7
	adds r8, r8, #0x800
	adc r3, r7, #0
	mov r7, r8, lsr #0xc
	orr r7, r7, r3, lsl #20
	add r3, lr, r7
	str r3, [r5, #0x44]
	ldrh r6, [r6, #0x60]
	ldr r3, [r4, #0x254]
	add r0, r5, #0x44
	rsb r6, r6, #0
	mov r6, r6, lsl #0x10
	mov r6, r6, lsr #0x10
	mov r6, r6, lsl #0x10
	mov r6, r6, lsr #0x10
	mov r6, r6, asr #4
	mov r6, r6, lsl #2
	ldrsh r6, [ip, r6]
	ldr r4, [r5, #0x4c]
	mov r2, r0
	smull r7, r6, r3, r6
	adds r7, r7, #0x800
	adc r3, r6, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r3, lsl #20
	add r3, r4, r6
	str r3, [r5, #0x4c]
	bl VEC_Subtract
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0215C3F4:
	ldr r0, [r6, #0x24]
	tst r0, #1
	beq _0215C414
	ldr r0, [r4, #0x18]
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x20]
	str r0, [r5, #0x4c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0215C414:
	ldrh r0, [r4, #0]
	cmp r0, #0
	bne _0215C494
	ldrsh r0, [r1, #0xea]
	mov r6, #1
	mov r7, #0x10000
	cmp r0, #0
	mov r8, #0x1000
	beq _0215C448
	mov r7, r8
	mov r6, #3
	mov r8, #0x20
	b _0215C4B0
_0215C448:
	ldrsh r2, [r1, #0xec]
	cmp r2, #0
	beq _0215C46C
	ldr r0, =0x00000444
	mov r6, #2
	smulbb r0, r2, r0
	sub r7, r7, r0
	mov r8, #0x20
	b _0215C4B0
_0215C46C:
	ldrsh r0, [r1, #0xe8]
	cmp r0, #0
	bne _0215C484
	ldr r0, [r5, #0x24]
	tst r0, #1
	beq _0215C4B0
_0215C484:
	mov r6, #2
	mov r7, #0x3c00
	mov r8, #0x28
	b _0215C4B0
_0215C494:
	ldr r0, [r5, #0x24]
	mov r7, #0x6000
	tst r0, #0x400
	mov r8, #0x100
	mov r6, #3
	movne r7, #0x280
	movne r8, #0x40
_0215C4B0:
	str r8, [sp]
	ldr r0, [r5, #0x44]
	ldr r1, [r4, #0x18]
	mov r2, r6
	mov r3, r7
	bl ObjShiftSet
	str r0, [r5, #0x44]
	str r8, [sp]
	ldr r0, [r5, #0x4c]
	ldr r1, [r4, #0x20]
	mov r2, r6
	mov r3, r7
	bl ObjShiftSet
	str r0, [r5, #0x4c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void SailPlayer__HandleTimers(StageTask *work)
{
    SailPlayer *worker   = GetStageTaskWorker(work, SailPlayer);
    SailManager *manager = SailManager__GetWork();

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
            if (worker->missedRingCount > 4)
            {
                if (worker->trickFinishTimer != 0)
                    worker->trickFinishTimer--;
                else
                    worker->scoreComboCurrent = 0;
            }

            if (worker->rivalVoiceClipTimer != 0)
                worker->rivalVoiceClipTimer--;

            if (worker->overSpdLimitTimer != 0)
                worker->overSpdLimitTimer--;

            if (worker->maxBoostTimer)
            {
                worker->maxBoostTimer--;
                if (worker->maxBoostTimer == 0)
                {
                    if ((work->userFlag & SAILPLAYER_FLAG_USED_MAX_BOOST) != 0)
                    {
                        SailPlayer__GiveBoost(work, -FLOAT_TO_FX32(144.0));
                        work->userFlag &= ~SAILPLAYER_FLAG_USED_MAX_BOOST;

                        if (!worker->isRival)
                            SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_NO_ENERGY, NULL);
                    }

                    ObjDraw__PaletteTex__Process(&worker->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
                }
                else
                {
                    if ((manager->timer & 16) != 0)
                    {
                        u8 color = (2 * manager->timer) & 0x1F;

                        u32 r = color << 8;
                        u32 g = ((u32)color >> 1) << 8;
                        u32 b = -((u32)color >> 1) << 8;

                        ObjDraw__PaletteTex__Process(&worker->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                    else
                    {
                        u8 color = (2 * manager->timer) & 0x1F;

                        u32 r = ((0x1F - color)) << 8;
                        u32 g = ((u32)(0x1F - color) >> 1) << 8;
                        u32 b = -((u32)(0x1F - color) >> 1) << 8;

                        ObjDraw__PaletteTex__Process(&worker->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                }
            }

            if (worker->boostCooldownTimer != 0)
                worker->boostCooldownTimer--;

            if (worker->field_1E6 != 0)
            {
                worker->field_1E6--;
                if (worker->field_1E6 == 0)
                    work->userFlag &= ~SAILPLAYER_FLAG_80;
            }

            if (worker->dashPanelTimer != 0)
                worker->dashPanelTimer--;

            if (worker->field_1EC != 0)
                worker->field_1EC--;

            if (worker->field_1EA != 0)
            {
                worker->field_1EA--;
                if (worker->field_1EA == 0)
                    worker->field_1EC = 60;
            }

            if ((work->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
            {
                if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
                    SailPlayer__GiveBoost(work, -SAILPLAYER_BOOST_DRAIN_GROUND);
                else
                    SailPlayer__GiveBoost(work, -SAILPLAYER_BOOST_DRAIN_AIR);

                if (!worker->boost)
                    SailPlayer__Action_StopBoost(work);
            }

            if (worker->shipType == SHIP_HOVER)
            {
                if (worker->chargeTimer >= SAILPLAYER_CHARGE_FULL_POWER)
                {
                    if ((manager->timer & 4) != 0)
                    {
                        u8 color = (8 * manager->timer) & 0x1F;

                        u32 r = color << 8;
                        u32 g = ((u32)color) << 8;
                        u32 b = -((u32)color) << 8;

                        ObjDraw__PaletteTex__Process(&worker->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                    else
                    {
                        u8 color = (8 * manager->timer) & 0x1F;

                        u32 r = ((0x1F - color)) << 8;
                        u32 g = ((0x1F - color)) << 8;
                        u32 b = (-(0x1F - color)) << 8;

                        ObjDraw__PaletteTex__Process(&worker->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                }
                else if (worker->chargeTimer >= SAILPLAYER_CHARGE_POWERED_UP)
                {
                    if ((manager->timer & 8) != 0)
                    {
                        u8 color = (4 * manager->timer) & 0x1F;

                        u32 r = color << 8;
                        u32 g = ((u32)color >> 1) << 8;
                        u32 b = -((u32)color >> 1) << 8;

                        ObjDraw__PaletteTex__Process(&worker->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                    else
                    {
                        u8 color = (4 * manager->timer) & 0x1F;

                        u32 r = ((0x1F - color)) << 8;
                        u32 g = ((u32)(0x1F - color) >> 1) << 8;
                        u32 b = -((u32)(0x1F - color) >> 1) << 8;

                        ObjDraw__PaletteTex__Process(&worker->paletteTex, (s16)r >> 8, (s16)g >> 8, (s16)b >> 8);
                    }
                }
                else
                {
                    ObjDraw__PaletteTex__Process(&worker->paletteTex, GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00), GX_COLOR_FROM_888(0x00));
                }
            }
            break;

        case SHIP_BOAT:
            if (worker->healthChange != 0)
                worker->healthChange -= FLOAT_TO_FX32(0.5);
            break;
    }

    if (worker->blinkTimer != 0)
    {
        worker->blinkTimer--;

        work->displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
        if ((worker->blinkTimer & 1) != 0)
            work->displayFlag |= DISPLAY_FLAG_NO_DRAW;

        if (worker->blinkTimer == 0)
            SailPlayer__ColliderFunc(work, 0);
    }

    SailObject__ShakeScreen(work, FX32_TO_WHOLE(work->shakeTimer));
}

NONMATCH_FUNC void SailPlayer__HandleJetControl(StageTask *work)
{
    // https://decomp.me/scratch/0RnYy -> 99.55%
    // 'work' & 'targetSpeed' registers need to be swapped
#ifdef NON_MATCHING
    fx32 targetSpeed;
    SailPlayer *worker;
    SailManager *manager;
    SailVoyageManager *voyageManager;

    worker        = GetStageTaskWorker(work, SailPlayer);
    manager       = SailManager__GetWork();
    voyageManager = SailManager__GetWork()->voyageManager;

    if (TOUCH_HAS_ON(worker->touchFlags) && !SailPlayer__HasRetired(work))
    {
        if (!worker->isRival && TOUCH_HAS_PUSH(worker->touchFlags))
            SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BREAK);

        if (!worker->field_1EA)
            worker->touchPos.x = worker->touchOn.x;

        worker->touchPos.y = worker->touchOn.y;

        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) == 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        {
            if ((work->userFlag & SAILPLAYER_FLAG_8) == 0)
            {
                fx32 spd = FLOAT_TO_FX32(0.0);

                targetSpeed = FLOAT_TO_FX32(1.25);
                targetSpeed -= MATH_ABS(worker->field_1CC >> 2);

                if (manager->isRivalRace)
                {
                    SailPlayer *rivalWorker = GetStageTaskWorker(manager->rivalJohnny, SailPlayer);

                    if (!worker->isRival && worker->field_1F2)
                    {
                        if ((rivalWorker->racePos.z - voyageManager->voyagePos) > FLOAT_TO_FX32(112.0))
                            spd += FLOAT_TO_FX32(0.1875);
                        else
                            spd += FLOAT_TO_FX32(0.09375);

                        if ((work->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
                            spd += FLOAT_TO_FX32(0.28125);
                    }

                    if (worker->isRival && !worker->field_1F2 && ((voyageManager->segmentCount - 3) < voyageManager->field_24 || manager->raceRank == 0))
                    {
                        if ((voyageManager->voyagePos - rivalWorker->racePos.z) > FLOAT_TO_FX32(112.0))
                            spd += FLOAT_TO_FX32(0.1875);
                        else
                            spd += FLOAT_TO_FX32(0.09375);

                        if ((work->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
                            spd += FLOAT_TO_FX32(0.28125);
                    }
                }

                if (!worker->isRival)
                {
                    spd += 28 * (u16)FX_DivS32(MATH_MIN(worker->scoreComboCurrent, 100), 10);
                    if ((work->userFlag & SAILPLAYER_FLAG_BOOST) != 0 && spd > FLOAT_TO_FX32(0.1875))
                        spd = FLOAT_TO_FX32(0.1875);
                }

                if ((work->userFlag & SAILPLAYER_FLAG_BOOST) != 0 || worker->field_1E6 != 0)
                {
                    fx32 topSpdBoost = spd + FLOAT_TO_FX32(2.0);
                    if (!worker->overSpdLimitTimer)
                    {
                        topSpdBoost -= MATH_ABS(worker->field_1CC >> 2);
                    }

                    if (manager->timer > 500 && manager->isRivalRace == TRUE)
                        topSpdBoost -= FLOAT_TO_FX32(0.015625);

                    if (worker->speed > topSpdBoost)
                        worker->speed = ObjSpdDownSet(worker->speed, FLOAT_TO_FX32(0.029296875));
                    else
                        worker->speed = ObjSpdUpSet(worker->speed, FLOAT_TO_FX32(0.007568359375), topSpdBoost);
                }
                else
                {
                    targetSpeed += spd;

                    fx32 dec;
                    if (worker->speed < FLOAT_TO_FX32(0.3125))
                    {
                        dec = FLOAT_TO_FX32(0.140625);
                    }
                    else if (worker->speed < FLOAT_TO_FX32(0.625))
                    {
                        dec = FLOAT_TO_FX32(0.03515625);
                    }
                    else if (worker->speed < FLOAT_TO_FX32(0.9375))
                    {
                        dec = FLOAT_TO_FX32(0.0087890625);
                    }
                    else if (worker->speed < FLOAT_TO_FX32(1.09375))
                    {
                        dec = FLOAT_TO_FX32(0.00439453125);
                    }
                    else
                    {
                        dec = FLOAT_TO_FX32(0.000732421875);
                    }

                    if (worker->speed > targetSpeed)
                    {
                        worker->speed = ObjSpdDownSet(worker->speed, FLOAT_TO_FX32(0.029296875) - dec);
                        if (worker->speed < targetSpeed)
                            worker->speed = targetSpeed;
                    }
                    else
                    {
                        worker->speed = ObjSpdUpSet(worker->speed, dec, targetSpeed);
                    }

                    if (TOUCH_HAS_PUSH(worker->touchFlags) && !worker->isRival)
                    {
                        SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ACCEL);
                        SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_ACCEL, NULL);
                    }
                }
            }
        }
    }
    else
    {
        if (worker->speed > FLOAT_TO_FX32(0.0) && (work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 && (work->userFlag & SAILPLAYER_FLAG_8) == 0)
        {
            if (TOUCH_HAS_PULL(worker->touchFlags) && !worker->isRival)
            {
                SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BREAK);
                SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_BREAK, 0);
            }

            if ((work->userFlag & SAILPLAYER_FLAG_BOOST) == 0)
                worker->speed = ObjSpdDownSet(worker->speed, FLOAT_TO_FX32(0.01708984375));
        }
    }

    if (worker->speed <= 0)
    {
        if (voyageManager->field_48 > voyageManager->voyagePos)
        {
            worker->speed = FLOAT_TO_FX32(0.0);
            if (!worker->isRival)
            {
                if (worker->shipType == SHIP_HOVER)
                    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_COLLISION_H, NULL);
                else
                    SailAudio__PlaySpatialSequence(work->sequencePlayerPtr, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_COLLISION, NULL);
            }
        }

        SailPlayer__Action_StopBoost(work);
    }

    if (!worker->isRival)
    {
        VecFx32 lineStart, lineEnd;
        VecFx32 lineDir;

        NNS_G3dScrPosToWorldLine(worker->touchPos.x, HW_LCD_HEIGHT * 0.666667f, &lineStart, &lineEnd);
        VEC_Subtract(&lineEnd, &lineStart, &lineDir);
        VEC_Normalize(&lineDir, &lineDir);

        VecFx32 result;
        VEC_MultAdd(worker->field_14, &lineDir, &lineStart, &result);
        worker->seaPos.x = result.x;
        worker->seaPos.z = result.z;
    }

    if ((work->userFlag & SAILPLAYER_FLAG_8) == 0 && !SailPlayer__HasRetired(work))
    {
        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        {
            if (TOUCH_HAS_PUSH(worker->touchFlags) && worker->boostTapTimer > 6)
                worker->boostTapTimer = 0;

            if (worker->boostTapTimer != 0 && TOUCH_HAS_PUSH(worker->touchFlags) && worker->boostTapTimer < 6)
                SailPlayer__Action_Boost(work);

            if ((worker->btnPress & (PAD_BUTTON_L | PAD_BUTTON_R)) != 0)
                SailPlayer__Action_Boost(work);

            worker->boostTapTimer++;
        }

        if (!TOUCH_HAS_ON(worker->touchFlags) && (worker->btnDown & (PAD_BUTTON_L | PAD_BUTTON_R)) == 0)
            SailPlayer__Action_StopBoost(work);

        if ((worker->btnRelease & (PAD_BUTTON_L | PAD_BUTTON_R)) != 0)
            SailPlayer__Action_StopBoost(work);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r6, [r5, #0x124]
	bl SailManager__GetWork
	mov r7, r0
	bl SailManager__GetWork
	add r1, r6, #0x200
	ldrh r1, [r1, #0x3c]
	ldr r8, [r0, #0x98]
	tst r1, #1
	beq _0215CBB4
	mov r0, r5
	bl SailPlayer__HasRetired
	cmp r0, #0
	bne _0215CBB4
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _0215C944
	add r0, r6, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215C944
	mov r0, #0
	mov r2, r0
	mov r1, #3
	bl NNS_SndPlayerStopSeqBySeqArcIdx
_0215C944:
	add r0, r6, #0x100
	ldrsh r0, [r0, #0xea]
	cmp r0, #0
	addeq r0, r6, #0x200
	ldreqh r0, [r0, #0x30]
	streq r0, [r6, #0x24]
	add r0, r6, #0x200
	ldrh r0, [r0, #0x32]
	str r0, [r6, #0x28]
	ldr r0, [r5, #0x1c]
	tst r0, #4
	bne _0215CC30
	tst r0, #0x10
	bne _0215CC30
	ldr r1, [r5, #0x24]
	tst r1, #8
	bne _0215CC30
	add r0, r6, #0x100
	ldrsh r0, [r0, #0xcc]
	mov r4, #0x1400
	mov r9, #0
	movs r2, r0, asr #2
	rsbmi r2, r2, #0
	ldr r0, [r7, #0xc]
	sub r4, r4, r2
	cmp r0, #0
	beq _0215CA4C
	ldrh r2, [r6, #2]
	ldr r0, [r7, #0x8c]
	cmp r2, #0
	ldr r0, [r0, #0x124]
	bne _0215C9F4
	add r3, r6, #0x100
	ldrh r3, [r3, #0xf2]
	cmp r3, #0
	beq _0215C9F4
	ldr ip, [r0, #0x25c]
	ldr r3, [r8, #0x44]
	sub r3, ip, r3
	cmp r3, #0x70000
	addgt r9, r9, #0x300
	addle r9, r9, #0x180
	tst r1, #1
	addne r9, r9, #0x480
_0215C9F4:
	cmp r2, #0
	beq _0215CA4C
	add r2, r6, #0x100
	ldrh r2, [r2, #0xf2]
	cmp r2, #0
	bne _0215CA4C
	ldrh r3, [r8, #0xb8]
	ldrh r2, [r8, #0x24]
	sub r3, r3, #3
	cmp r3, r2
	blt _0215CA2C
	ldrh r2, [r7, #0x28]
	cmp r2, #0
	bne _0215CA4C
_0215CA2C:
	ldr r2, [r8, #0x44]
	ldr r0, [r0, #0x25c]
	sub r0, r2, r0
	cmp r0, #0x70000
	addgt r9, r9, #0x300
	addle r9, r9, #0x180
	tst r1, #1
	addne r9, r9, #0x480
_0215CA4C:
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _0215CA94
	add r0, r6, #0x100
	ldrh r0, [r0, #0xc4]
	mov r1, #0xa
	cmp r0, #0x64
	movhi r0, #0x64
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, #0x1c
	ldr r1, [r5, #0x24]
	mla r9, r2, r0, r9
	tst r1, #1
	beq _0215CA94
	cmp r9, #0x300
	movgt r9, #0x300
_0215CA94:
	tst r1, #1
	addeq r0, r6, #0x100
	ldreqsh r0, [r0, #0xe6]
	cmpeq r0, #0
	beq _0215CB10
	add r0, r6, #0x100
	ldrsh r1, [r0, #0xf0]
	add r2, r9, #0x2000
	cmp r1, #0
	bne _0215CACC
	ldrsh r0, [r0, #0xcc]
	movs r0, r0, asr #2
	rsbmi r0, r0, #0
	sub r2, r2, r0
_0215CACC:
	ldr r0, [r7, #0x1c]
	cmp r0, #0x1f4
	bls _0215CAE4
	ldr r0, [r7, #0xc]
	cmp r0, #1
	subeq r2, r2, #0x40
_0215CAE4:
	ldr r0, [r6, #0x10]
	cmp r0, r2
	ble _0215CB00
	mov r1, #0x78
	bl ObjSpdDownSet
	str r0, [r6, #0x10]
	b _0215CC30
_0215CB00:
	mov r1, #0x1f
	bl ObjSpdUpSet
	str r0, [r6, #0x10]
	b _0215CC30
_0215CB10:
	ldr r0, [r6, #0x10]
	add r4, r4, r9
	cmp r0, #0x500
	movlt r1, #0x240
	blt _0215CB48
	cmp r0, #0xa00
	movlt r1, #0x90
	blt _0215CB48
	cmp r0, #0xf00
	movlt r1, #0x24
	blt _0215CB48
	cmp r0, #0x1180
	movlt r1, #0x12
	movge r1, #3
_0215CB48:
	cmp r0, r4
	ble _0215CB68
	rsb r1, r1, #0x78
	bl ObjSpdDownSet
	str r0, [r6, #0x10]
	cmp r0, r4
	strlt r4, [r6, #0x10]
	b _0215CB74
_0215CB68:
	mov r2, r4
	bl ObjSpdUpSet
	str r0, [r6, #0x10]
_0215CB74:
	add r0, r6, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215CC30
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _0215CC30
	mov r0, #0
	mov r2, r0
	mov r1, #1
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r5, #0x138]
	mov r1, #1
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	b _0215CC30
_0215CBB4:
	ldr r0, [r6, #0x10]
	cmp r0, #0
	ble _0215CC30
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	bne _0215CC30
	ldr r0, [r5, #0x24]
	tst r0, #8
	bne _0215CC30
	add r0, r6, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #8
	beq _0215CC14
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _0215CC14
	mov r0, #0
	mov r2, r0
	mov r1, #3
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r5, #0x138]
	mov r1, #3
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215CC14:
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _0215CC30
	ldr r0, [r6, #0x10]
	mov r1, #0x46
	bl ObjSpdDownSet
	str r0, [r6, #0x10]
_0215CC30:
	ldr r0, [r6, #0x10]
	cmp r0, #0
	bgt _0215CC8C
	ldr r1, [r8, #0x48]
	ldr r0, [r8, #0x44]
	cmp r1, r0
	ble _0215CC84
	mov r2, #0
	str r2, [r6, #0x10]
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _0215CC84
	ldrh r0, [r6, #0]
	cmp r0, #2
	ldr r0, [r5, #0x138]
	bne _0215CC7C
	mov r1, #0x3e
	bl SailAudio__PlaySpatialSequence
	b _0215CC84
_0215CC7C:
	mov r1, #0xf
	bl SailAudio__PlaySpatialSequence
_0215CC84:
	mov r0, r5
	bl SailPlayer__Action_StopBoost
_0215CC8C:
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _0215CCEC
	ldr r0, [r6, #0x24]
	add r2, sp, #0x24
	add r3, sp, #0x18
	mov r1, #0x80
	bl NNS_G3dScrPosToWorldLine
	add r0, sp, #0x18
	add r1, sp, #0x24
	add r2, sp, #0xc
	bl VEC_Subtract
	add r0, sp, #0xc
	mov r1, r0
	bl VEC_Normalize
	ldr r0, [r6, #0x14]
	add r1, sp, #0xc
	add r2, sp, #0x24
	add r3, sp, #0
	bl VEC_MultAdd
	ldr r0, [sp]
	str r0, [r6, #0x18]
	ldr r0, [sp, #8]
	str r0, [r6, #0x20]
_0215CCEC:
	ldr r0, [r5, #0x24]
	tst r0, #8
	addne sp, sp, #0x30
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r5
	bl SailPlayer__HasRetired
	cmp r0, #0
	addne sp, sp, #0x30
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	bne _0215CD8C
	add r0, r6, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215CD3C
	ldr r0, [r6, #0x244]
	cmp r0, #6
	movhi r0, #0
	strhi r0, [r6, #0x244]
_0215CD3C:
	ldr r1, [r6, #0x244]
	cmp r1, #0
	beq _0215CD68
	add r0, r6, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215CD68
	cmp r1, #6
	bhs _0215CD68
	mov r0, r5
	bl SailPlayer__Action_Boost
_0215CD68:
	add r0, r6, #0x200
	ldrh r0, [r0, #0x3e]
	tst r0, #0x300
	beq _0215CD80
	mov r0, r5
	bl SailPlayer__Action_Boost
_0215CD80:
	ldr r0, [r6, #0x244]
	add r0, r0, #1
	str r0, [r6, #0x244]
_0215CD8C:
	add r0, r6, #0x200
	ldrh r1, [r0, #0x3c]
	tst r1, #1
	bne _0215CDB0
	ldrh r0, [r0, #0x42]
	tst r0, #0x300
	bne _0215CDB0
	mov r0, r5
	bl SailPlayer__Action_StopBoost
_0215CDB0:
	add r0, r6, #0x200
	ldrh r0, [r0, #0x40]
	tst r0, #0x300
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r5
	bl SailPlayer__Action_StopBoost
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__HandleBoatControl(StageTask *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xec
	mov r1, #0
	mov r5, r0
	str r1, [sp, #0x34]
	mov r0, r1
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x34]
	str r0, [sp, #0x2c]
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	mov r7, r0
	mov r0, r5
	bl SailPlayer__HasRetired
	cmp r0, #0
	addne sp, sp, #0xec
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r5, #0xf4]
	ldr r0, =SailPlayer__State_ReachedGoal
	cmp r1, r0
	beq _0215D91C
	ldr r0, [r4, #0x10]
	mov r1, #0x80
	mov r2, #0x800
	bl ObjSpdUpSet
	str r0, [r4, #0x10]
	add r6, r4, #0x200
	ldrh r0, [r6, #0x30]
	str r0, [r4, #0x24]
	ldrh r0, [r6, #0x32]
	str r0, [r4, #0x28]
	ldr r0, [r7, #0x24]
	tst r0, #0x400000
	bne _0215CFD8
	ldrh r1, [r6, #0x3c]
	ldrh r0, [r6, #0xe]
	tst r1, #5
	str r0, [sp, #0x28]
	beq _0215CF3C
	mov r10, #0x2a
	mov r9, #0
	mov r8, #0xcc
	add r7, sp, #0x5c
	mov r11, #0xac
_0215CE84:
	add r0, r10, #0x38
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	str r8, [sp]
	mov r0, r7
	mov r1, r10
	mov r2, r11
	bl ObjRect__SetBox2D
	ldrh r1, [r6, #0x30]
	ldrh r2, [r6, #0x32]
	mov r0, r7
	mov r3, #0
	bl ObjRect__RectPointCheck
	cmp r0, #0
	beq _0215CF1C
	add r1, r4, #0x200
	ldrh r0, [r1, #0x3c]
	tst r0, #4
	beq _0215CF10
	ldrh r2, [r1, #0xe]
	mov r0, r9, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r2, r0, lsr #16
	addeq r3, r4, r2, lsl #2
	ldreq r0, [r3, #0x220]
	cmpeq r0, #0
	bne _0215CF08
	ldr r0, [r3, #0x214]
	mov r2, #0
	str r0, [r3, #0x220]
	ldrh r0, [r1, #0xe]
	add r0, r4, r0, lsl #2
	str r2, [r0, #0x214]
_0215CF08:
	add r0, r4, #0x200
	strh r6, [r0, #0xe]
_0215CF10:
	mov r0, #1
	str r0, [sp, #0x2c]
	b _0215CF3C
_0215CF1C:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	cmp r9, #3
	add r0, r10, #0x3a
	mov r0, r0, lsl #0x10
	mov r10, r0, asr #0x10
	blt _0215CE84
_0215CF3C:
	add r0, r4, #0x200
	ldrh r1, [r0, #0x42]
	tst r1, #0x440
	movne r1, #1
	strneh r1, [r0, #0xe]
	add r0, r4, #0x200
	ldrh r1, [r0, #0x42]
	tst r1, #0x820
	movne r1, #0
	strneh r1, [r0, #0xe]
	add r0, r4, #0x200
	ldrh r1, [r0, #0x42]
	tst r1, #0x11
	movne r1, #2
	strneh r1, [r0, #0xe]
	add r0, r4, #0x200
	ldrh r1, [r0, #0x3e]
	tst r1, #0x82
	beq _0215CFB4
	ldrh r1, [r0, #0xe]
	add r3, r4, r1, lsl #2
	ldr r1, [r3, #0x220]
	cmp r1, #0
	bne _0215CFB4
	ldr r2, [r3, #0x214]
	mov r1, #0
	str r2, [r3, #0x220]
	ldrh r0, [r0, #0xe]
	add r0, r4, r0, lsl #2
	str r1, [r0, #0x214]
_0215CFB4:
	add r0, r4, #0x200
	ldrh r1, [r0, #0xe]
	ldr r0, [sp, #0x28]
	cmp r0, r1
	beq _0215CFD8
	ldr r0, [r5, #0x138]
	mov r1, #0x1f
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215CFD8:
	ldr r0, [sp, #0x2c]
	cmp r0, #0
	bne _0215D91C
	add r1, r4, #0x200
	ldrh r3, [r1, #0xe]
	cmp r3, #0
	beq _0215D008
	cmp r3, #1
	beq _0215D38C
	cmp r3, #2
	beq _0215D6F4
	b _0215D900
_0215D008:
	ldrh r0, [r1, #0x3c]
	tst r0, #4
	movne r0, #0
	strneh r0, [r1, #0x2c]
	add r0, r4, #0x200
	ldrh r1, [r0, #0x3c]
	tst r1, #1
	beq _0215D050
	ldrh r1, [r0, #0x2c]
	add r1, r1, #1
	strh r1, [r0, #0x2c]
	ldrh r1, [r0, #0x2c]
	cmp r1, #6
	bls _0215D050
	mov r1, #0
	strh r1, [r0, #0x2c]
	mov r0, #1
	str r0, [sp, #0x30]
_0215D050:
	add r0, r4, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	ldreq r0, [sp, #0x30]
	cmpeq r0, #0
	beq _0215D900
	add r1, r4, #0x200
	ldrh r0, [r1, #0xe]
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x214]
	cmp r0, #0x1000
	blt _0215D900
	ldrh r0, [r1, #0x30]
	ldrh r1, [r1, #0x32]
	add r2, sp, #0xe0
	add r3, sp, #0xd4
	bl NNS_G3dScrPosToWorldLine
	add r1, sp, #0xe0
	add r2, sp, #0xd4
	mov r0, r5
	bl EffectSailUnknown2162014__Create
	cmp r0, #0
	ldrne r1, [r0, #0x124]
	strne r1, [sp, #0x38]
	cmpne r1, #0
	beq _0215D900
	ldrh r3, [r5, #0x32]
	mov r1, #0
	ldr r2, =FX_SinCosTable_
	str r1, [sp, #0x24]
	mov r1, r3, asr #4
	mov r1, r1, lsl #1
	mov r3, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r8, [r2, r3]
	ldrsh r6, [r2, r1]
	mov r2, #0x5000
	umull r1, r9, r8, r2
	adds r10, r1, #0x800
	ldr r1, [sp, #0x24]
	umull r3, r7, r6, r2
	mla r9, r8, r1, r9
	mov r1, r8, asr #0x1f
	mla r9, r1, r2, r9
	adc r8, r9, #0
	mov r1, r10, lsr #0xc
	orr r1, r1, r8, lsl #20
	str r1, [sp, #0x1c]
	adds r1, r3, #0x800
	mov r1, r1, lsr #0xc
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x24]
	mov r3, r6, asr #0x1f
	mla r7, r6, r1, r7
	mla r7, r3, r2, r7
	ldr r1, [sp, #0x18]
	adc r2, r7, #0
	orr r1, r1, r2, lsl #20
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x1c]
	sub r1, r1, #1
	str r1, [sp, #0x3c]
	ldr r3, [sp, #0x38]
	ldr r1, [sp, #0x18]
	ldr r3, [r3, #0x18]
	ldr r11, =0x00000F5E
	str r3, [sp, #0xc]
	ldr r3, [sp, #0x38]
	ldr r6, =0x0000065D
	ldr r3, [r3, #0x10]
	rsb r1, r1, #0
	rsb r2, r2, #0
	str r3, [sp, #8]
_0215D17C:
	ldr r3, [sp, #0xc]
	mov lr, #0
	sub ip, r3, r1
	ldr r3, [sp, #8]
	subs r3, r3, r2
	rsbmi r3, r3, #0
	cmp ip, #0
	rsblt ip, ip, #0
	cmp r3, ip
	ble _0215D1F8
	umull r10, r9, r3, r11
	mla r9, r3, lr, r9
	mov r8, r3, asr #0x1f
	mla r9, r8, r11, r9
	adds r8, r10, #0x800
	mov r3, lr
	adc r3, r9, r3
	mov r9, r8, lsr #0xc
	orr r9, r9, r3, lsl #20
	umull r8, r3, ip, r6
	mov r10, lr
	mla r3, ip, r10, r3
	mov r7, ip, asr #0x1f
	mla r3, r7, r6, r3
	adds r8, r8, #0x800
	mov r7, lr
	adc r3, r3, r7
	mov r7, r8, lsr #0xc
	orr r7, r7, r3, lsl #20
	add r3, r9, r7
	b _0215D248
_0215D1F8:
	umull r10, r9, ip, r11
	mla r9, ip, lr, r9
	mov r8, ip, asr #0x1f
	mla r9, r8, r11, r9
	adds r10, r10, #0x800
	mov r8, lr
	adc r8, r9, r8
	mov r10, r10, lsr #0xc
	orr r10, r10, r8, lsl #20
	mov ip, lr
	umull r9, r8, r3, r6
	mla r8, r3, ip, r8
	mov r7, r3, asr #0x1f
	mla r8, r7, r6, r8
	adds r7, r9, #0x800
	mov r3, lr
	adc r3, r8, r3
	mov r7, r7, lsr #0xc
	orr r7, r7, r3, lsl #20
	add r3, r10, r7
_0215D248:
	cmp r3, #0x5000
	bge _0215D268
	ldr r2, [r0, #0x18]
	mov r1, #1
	str r1, [sp, #0x24]
	orr r1, r2, #2
	str r1, [r0, #0x18]
	b _0215D294
_0215D268:
	ldr r3, [sp, #0x18]
	add r1, r1, r3
	ldr r3, [sp, #0x1c]
	add r2, r2, r3
	ldr r3, [sp, #0x3c]
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	str r3, [sp, #0x3c]
	cmp r3, #3
	blt _0215D17C
_0215D294:
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _0215D900
	ldr r0, [sp, #0x38]
	ldr r6, [r5, #0x44]
	ldr r3, [r0, #0x10]
	ldr r1, [r0, #0x18]
	ldr r2, [r5, #0x4c]
	sub r0, r6, r3
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r6, r0
	bl SailVoyageManager__GetVoyageAngle
	add r0, r0, #0x8000
	mov r1, r0, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl ObjRoopDiff16
	cmp r0, #0
	movgt r0, #1
	strgt r0, [sp, #0x34]
	mov r1, #0x3600
	sub r0, r1, #0x7600
	str r1, [sp, #0xc8]
	str r0, [sp, #0xcc]
	str r0, [sp, #0xd0]
	ldr r0, [sp, #0x34]
	ldr r3, =FX_SinCosTable_
	cmp r0, #0
	rsbne r0, r1, #0
	strne r0, [sp, #0xc8]
	ldrh r1, [r5, #0x32]
	add r0, sp, #0xa4
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0xc8
	add r1, sp, #0xa4
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0xc8
	add r1, r5, #0x44
	mov r2, r0
	bl VEC_Add
	ldr r1, [sp, #0x34]
	add r0, sp, #0xc8
	mov r2, #0
	bl EffectSailFlash2__Create
	mov r0, #0x2000
	str r0, [r5, #4]
	add r0, r4, #0x200
	ldrh r1, [r0, #0xe]
	add r2, r4, #0x214
	ldr r0, [r2, r1, lsl #2]
	sub r0, r0, #0x1000
	str r0, [r2, r1, lsl #2]
	b _0215D900
_0215D38C:
	ldrh r0, [r1, #0x3c]
	tst r0, #4
	beq _0215D900
	add r0, r4, r3, lsl #2
	ldr r2, [r0, #0x214]
	mov r0, #0
	str r0, [sp, #0x20]
	cmp r2, #0x1000
	bge _0215D3C4
	ldr r0, [r5, #0x138]
	ldr r2, [sp, #0x20]
	mov r1, #0x22
	bl SailAudio__PlaySpatialSequence
	b _0215D900
_0215D3C4:
	ldrh r0, [r1, #0x30]
	ldrh r1, [r1, #0x32]
	add r2, sp, #0xe0
	add r3, sp, #0xd4
	bl NNS_G3dScrPosToWorldLine
	mov r3, #0
	add r0, sp, #0xd4
	add r1, sp, #0xe0
	add r2, sp, #0x80
	str r3, [sp, #0x8c]
	str r3, [sp, #0x90]
	str r3, [sp, #0x94]
	bl VEC_Subtract
	add r0, sp, #0x80
	add r1, sp, #0x8c
	add r2, sp, #0x74
	bl VEC_Subtract
	add r0, sp, #0x74
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0xe0
	add r1, sp, #0x74
	add r2, sp, #0x98
	bl EffectSailUnknown21624A0__Func_2162400
	ldrh r0, [r5, #0x32]
	mov r3, #0
	ldr r1, =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r2, r0, lsl #1
	mov r0, r2, lsl #1
	ldrsh r8, [r1, r0]
	add r0, r2, #1
	mov r0, r0, lsl #1
	ldrsh r7, [r1, r0]
	ldr r0, [sp, #0xa0]
	mov r2, #0x5000
	str r0, [sp, #4]
	ldr r0, [sp, #0x98]
	mov r1, r8, asr #0x1f
	str r0, [sp, #0x40]
	umull r9, r0, r8, r2
	mla r0, r8, r3, r0
	mla r0, r1, r2, r0
	adds r8, r9, #0x800
	adc r1, r0, #0
	mov r0, r8, lsr #0xc
	orr r0, r0, r1, lsl #20
	str r0, [sp, #0x14]
	rsb r1, r0, #0
	umull r8, r0, r7, r2
	mla r0, r7, r3, r0
	mov r6, r7, asr #0x1f
	sub lr, r3, #1
	adds r3, r8, #0x800
	mla r0, r6, r2, r0
	adc r2, r0, #0
	mov r0, r3, lsr #0xc
	orr r0, r0, r2, lsl #20
	str r0, [sp, #0x10]
	ldr r7, =0x00000F5E
	ldr r8, =0x0000065D
	rsb r0, r0, #0
_0215D4BC:
	ldr r2, [sp, #4]
	mov r6, #0
	sub r3, r2, r0
	ldr r2, [sp, #0x40]
	subs r2, r2, r1
	rsbmi r2, r2, #0
	cmp r3, #0
	rsblt r3, r3, #0
	cmp r2, r3
	ble _0215D528
	umull ip, r11, r2, r7
	mla r11, r2, r6, r11
	mov r10, r2, asr #0x1f
	mla r11, r10, r7, r11
	adds r6, ip, #0x800
	adc r2, r11, #0
	mov r10, r6, lsr #0xc
	orr r10, r10, r2, lsl #20
	umull r6, r2, r3, r8
	mov r11, #0
	mla r2, r3, r11, r2
	mov r9, r3, asr #0x1f
	mla r2, r9, r8, r2
	mov r3, r11
	adds r6, r6, #0x800
	adc r2, r2, r3
	b _0215D568
_0215D528:
	umull ip, r11, r3, r7
	mla r11, r3, r6, r11
	mov r10, r3, asr #0x1f
	mla r11, r10, r7, r11
	adds r6, ip, #0x800
	adc r3, r11, #0
	mov r10, r6, lsr #0xc
	orr r10, r10, r3, lsl #20
	umull r6, r3, r2, r8
	mov r11, #0
	mla r3, r2, r11, r3
	mov r9, r2, asr #0x1f
	mla r3, r9, r8, r3
	mov r2, r11
	adds r6, r6, #0x800
	adc r2, r3, r2
_0215D568:
	mov r3, r6, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r10, r3
	cmp r2, #0x5000
	movlt r0, #1
	strlt r0, [sp, #0x20]
	blt _0215D5A8
	ldr r2, [sp, #0x10]
	add r0, r0, r2
	ldr r2, [sp, #0x14]
	add r1, r1, r2
	add r2, lr, #1
	mov r2, r2, lsl #0x10
	mov lr, r2, asr #0x10
	cmp lr, #3
	blt _0215D4BC
_0215D5A8:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	bne _0215D900
	ldr r1, [r5, #0x44]
	ldr r0, [sp, #0x40]
	ldr r2, [r5, #0x4c]
	sub r0, r1, r0
	ldr r1, [sp, #4]
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r6, r0
	bl SailVoyageManager__GetVoyageAngle
	add r0, r0, #0x8000
	mov r1, r0, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl ObjRoopDiff16
	cmp r0, #0
	movgt r0, #1
	mov r3, #0x3600
	strgt r0, [sp, #0x34]
	sub r0, r3, #0x7600
	str r0, [sp, #0xcc]
	str r3, [sp, #0xc8]
	add r0, r4, #0x200
	ldrh r2, [r0, #0xc]
	ldr r0, [sp, #0x34]
	mov r1, #0x1600
	cmp r0, #0
	mul r0, r2, r1
	add r0, r0, #0x1080
	str r0, [sp, #0xd0]
	rsbne r0, r3, #0
	strne r0, [sp, #0xc8]
	ldrh r1, [r5, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0xa4
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0xc8
	add r1, sp, #0xa4
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0xc8
	add r1, r5, #0x44
	mov r2, r0
	bl VEC_Add
	add r1, sp, #0xc8
	add r2, sp, #0x98
	mov r0, r5
	bl EffectSailShell__Create
	ldr r1, [sp, #0xcc]
	add r0, sp, #0xc8
	sub r1, r1, #0x1000
	str r1, [sp, #0xcc]
	ldr r1, [sp, #0x34]
	mov r2, #1
	bl EffectSailFlash2__Create
	ldr r1, [sp, #0x34]
	add r0, sp, #0xc8
	bl EffectSailBazooka__Create
	mov r0, #0x4000
	str r0, [r5, #4]
	add r0, r4, #0x200
	ldrh r2, [r0, #0xe]
	add r3, r4, #0x214
	ldr r1, [r3, r2, lsl #2]
	sub r1, r1, #0x1000
	str r1, [r3, r2, lsl #2]
	ldrh r1, [r0, #0xc]
	add r1, r1, #1
	strh r1, [r0, #0xc]
	ldrh r1, [r0, #0xc]
	cmp r1, #3
	movhs r1, #0
	strhsh r1, [r0, #0xc]
	b _0215D900
_0215D6F4:
	ldrh r0, [r1, #0x3c]
	tst r0, #1
	addne r2, r4, r3, lsl #2
	ldrne r2, [r2, #0x214]
	cmpne r2, #0
	beq _0215D880
	ldrh r7, [r1, #0x34]
	ldrh r6, [r1, #0x30]
	ldrh r3, [r1, #0x36]
	ldrh r2, [r1, #0x32]
	sub r1, r7, r6
	mov r1, r1, lsl #0x10
	sub r2, r3, r2
	mov r2, r2, lsl #0x10
	mov r3, r1, asr #0x10
	movs r1, r2, asr #0x10
	rsbmi r1, r1, #0
	cmp r3, #0
	rsblt r3, r3, #0
	add r1, r3, r1
	mov r1, r1, lsl #0x10
	mov r6, r1, lsr #0x10
	cmp r6, #5
	movhi r6, #5
	tst r0, #4
	bne _0215D770
	cmp r6, #0
	beq _0215D8BC
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	beq _0215D8BC
_0215D770:
	add r0, r4, #0x200
	ldrh r1, [r0, #0x2e]
	add r3, r4, #0x214
	add r1, r1, r6
	strh r1, [r0, #0x2e]
	ldrh r2, [r0, #0xe]
	ldr r1, [r3, r2, lsl #2]
	sub r1, r1, r6, lsl #6
	str r1, [r3, r2, lsl #2]
	ldr r1, [r5, #0x24]
	orr r1, r1, #0x20
	str r1, [r5, #0x24]
	ldrh r1, [r0, #0x2e]
	cmp r1, #5
	bhs _0215D7B8
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215D8BC
_0215D7B8:
	add r1, r4, #0x200
	ldrh r0, [r1, #0x30]
	ldrh r1, [r1, #0x32]
	add r2, sp, #0xe0
	add r3, sp, #0xd4
	bl NNS_G3dScrPosToWorldLine
	add r1, sp, #0xe0
	add r2, sp, #0xd4
	mov r0, r5
	bl EffectSailUnknown21624A0__Create
	add r0, r4, #0x200
	mov r3, #0
	strh r3, [r0, #0x2e]
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215D8BC
	add r0, sp, #0xd4
	add r1, sp, #0xe0
	add r2, sp, #0x80
	str r3, [sp, #0x8c]
	str r3, [sp, #0x90]
	str r3, [sp, #0x94]
	bl VEC_Subtract
	add r0, sp, #0x80
	add r1, sp, #0x8c
	add r2, sp, #0x74
	bl VEC_Subtract
	add r0, sp, #0x74
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0xe0
	add r1, sp, #0x74
	add r2, sp, #0x98
	bl EffectSailUnknown21624A0__Func_2162400
	ldr r1, [r5, #0x44]
	ldr r0, [sp, #0x98]
	ldr r2, [r5, #0x4c]
	sub r0, r1, r0
	ldr r1, [sp, #0xa0]
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r6, r0
	bl SailVoyageManager__GetVoyageAngle
	mov r1, r0
	add r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl ObjRoopDiff16
	b _0215D8BC
_0215D880:
	add r0, r4, r3, lsl #2
	ldr r0, [r0, #0x214]
	cmp r0, #0
	bne _0215D8BC
	ldr r1, [r5, #0x24]
	add r0, r4, #0x200
	bic r1, r1, #0x20
	str r1, [r5, #0x24]
	ldrh r0, [r0, #0x3c]
	tst r0, #4
	beq _0215D8BC
	ldr r0, [r5, #0x138]
	mov r1, #0x22
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215D8BC:
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	beq _0215D900
	add r0, r4, #0x200
	ldrh r1, [r0, #0x3c]
	tst r1, #8
	beq _0215D900
	mov r1, #0
	strh r1, [r0, #0x2e]
	ldrh r1, [r0, #0xe]
	add r2, r4, #0x214
	ldr r0, [r2, r1, lsl #2]
	sub r0, r0, #0x400
	str r0, [r2, r1, lsl #2]
	ldr r0, [r5, #0x24]
	bic r0, r0, #0x20
	str r0, [r5, #0x24]
_0215D900:
	add r0, r4, #0x200
	ldrh r0, [r0, #0xe]
	add r1, r4, r0, lsl #2
	ldr r0, [r1, #0x214]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r1, #0x214]
_0215D91C:
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	addne sp, sp, #0xec
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SailManager__GetWork
	ldr r0, [r0, #0xa8]
	add r2, sp, #0xe0
	cmp r0, #0
	ldrne r0, [r0, #0x18]
	add r3, sp, #0xd4
	strne r0, [r4, #0x14]
	mov r0, #0x80
	mov r1, #0x60
	bl NNS_G3dScrPosToWorldLine
	add r0, sp, #0xd4
	add r1, sp, #0xe0
	add r2, sp, #0x50
	bl VEC_Subtract
	add r0, sp, #0x50
	mov r1, r0
	bl VEC_Normalize
	ldr r0, [r4, #0x14]
	add r1, sp, #0x50
	add r2, sp, #0xe0
	add r3, sp, #0x44
	bl VEC_MultAdd
	ldr r0, [sp, #0x44]
	str r0, [r5, #0x44]
	ldr r0, [sp, #0x4c]
	str r0, [r5, #0x4c]
	add sp, sp, #0xec
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SailPlayer__HandleHoverControl2(StageTask *work)
{
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    UNUSED(manager);
    UNUSED(voyageManager);

    if (TOUCH_HAS_ON(worker->touchFlags) && !SailPlayer__HasRetired(work))
    {
        if (!worker->field_1EA)
            worker->touchPos.x = worker->touchOn.x;

        worker->touchPos.y = worker->touchOn.y;
    }

    if (work->state != SailPlayer__State_ReachedGoal && !SailPlayer__HasRetired(work))
        worker->speed = ObjSpdUpSet(worker->speed, FLOAT_TO_FX32(0.0234375), FLOAT_TO_FX32(1.0));

    if (!worker->isRival)
    {
        VecFx32 lineStart, lineEnd;
        VecFx32 lineDir;

        NNS_G3dScrPosToWorldLine(worker->touchPos.x, HW_LCD_HEIGHT * 0.666667f, &lineStart, &lineEnd);
        VEC_Subtract(&lineEnd, &lineStart, &lineDir);
        VEC_Normalize(&lineDir, &lineDir);

        VecFx32 result;
        VEC_MultAdd(worker->field_14, &lineDir, &lineStart, &result);
        worker->seaPos.x = result.x;
        worker->seaPos.z = result.z;
    }
}

void SailPlayer__HandleHoverControl1(StageTask *work)
{
    SailPlayer *worker   = GetStageTaskWorker(work, SailPlayer);
    SailManager *manager = SailManager__GetWork();

    work->userFlag &= ~SAILPLAYER_FLAG_2000;
    if ((work->userFlag & SAILPLAYER_FLAG_8) == 0 && !SailPlayer__HasRetired(work))
    {
        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        {
            if (TOUCH_HAS_ON(worker->touchFlags))
            {
                if (worker->touchPrev.x - worker->touchOn.x > 8 && worker->field_248 > 6)
                    worker->field_248 = 0;

                if (worker->field_248 && worker->touchOn.x - worker->touchPrev.x > 8 && worker->field_248 < 6)
                    SailPlayer__Action_215A350(work);

                if (worker->touchPrev.x - worker->touchOn.x < -8 && worker->field_24C > 6)
                    worker->field_24C = 0;

                if (worker->field_24C != 0 && worker->touchOn.x - worker->touchPrev.x < -8 && worker->field_24C < 6)
                    SailPlayer__Action_215A350(work);
            }

            if ((worker->btnPress & (PAD_BUTTON_L | PAD_BUTTON_R)) != 0)
                SailPlayer__Action_215A350(work);
        }

        if (TOUCH_HAS_ON(worker->touchFlags))
        {
            if (worker->chargeTimer == SAILPLAYER_CHARGE_SFX_START_THRESHOLD)
                SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGE_START, NULL);

            if (worker->chargeTimer == SAILPLAYER_CHARGE_SFX_CHARGE_THRESHOLD)
                SailAudio__PlaySpatialSequence(NULL, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGING, NULL);

            worker->chargeTimer += SAILPLAYER_CHARGE_SPEED;

            if (worker->upgradeLevel != SAILPLAYER_UPGRADE_LEVEL_0)
                worker->chargeTimer += SAILPLAYER_CHARGE_SPEED_UPGRADE;

            if (worker->chargeTimer > SAILPLAYER_CHARGE_MAX)
            {
                if (!SailAudio__CheckSequencePlaying(worker->shipSndHandles[0], SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGE_MAX))
                {
                    SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGING);
                    SailAudio__PlaySpatialSequence(worker->shipSndHandles[0], SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGE_MAX, NULL);
                }

                worker->chargeTimer = SAILPLAYER_CHARGE_MAX;
            }
            else
            {
                if ((manager->flags & SAILMANAGER_FLAG_DISABLE_BTN_PRESS) != 0)
                {
                    SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGING);
                    SailAudio__PlaySpatialSequence(0, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGING, 0);
                }
            }
        }

        if ((TOUCH_HAS_PULL(worker->touchFlags) || !TOUCH_HAS_ON(worker->touchFlags) && worker->chargeTimer != SAILPLAYER_CHARGE_MIN) && worker->field_1F6 >= 4
            && (work->userFlag & SAILPLAYER_FLAG_400) == 0)
        {
            EffectEffectSailBullet2__Create(work, worker->chargeTimer);
            SailAudio__StopSequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_CHARGING);
            worker->field_1F6   = 0;
            worker->chargeTimer = SAILPLAYER_CHARGE_MIN;
            StopStageSfx(worker->shipSndHandles[0]);
        }

        worker->field_1F6++;
        worker->field_248++;
        worker->field_24C++;
    }
}

void SailPlayer__HandleSubmarineControl(StageTask *work)
{
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    if (!SailPlayer__HasRetired(work))
    {
        if (work->state != SailPlayer__State_ReachedGoal)
            worker->speed = ObjSpdUpSet(worker->speed, FLOAT_TO_FX32(0.02783203125), FLOAT_TO_FX32(1.784423828125));

        worker->touchPos.x = worker->touchOn.x;
        worker->touchPos.y = worker->touchOn.y;

        if (TOUCH_HAS_PUSH(worker->touchFlags))
        {
            SailUnknown2180190__Create(work);
            EffectSailUnknown2162680__Create(work);
        }

        if ((work->userFlag & SAILPLAYER_FLAG_10) == 0)
        {
            VecFx32 lineStart, lineEnd;
            VecFx32 lineDir;

            NNS_G3dScrPosToWorldLine(HW_LCD_CENTER_X, HW_LCD_CENTER_Y, &lineStart, &lineEnd);
            VEC_Subtract(&lineEnd, &lineStart, &lineDir);
            VEC_Normalize(&lineDir, &lineDir);

            VecFx32 result;
            VEC_MultAdd(worker->field_14, &lineDir, &lineStart, &result);
            work->position.x = result.x;
            work->position.z = result.z;
        }
    }
}

void SailPlayer__In_Default(void)
{
    StageTask *work    = TaskGetWorkCurrent(StageTask);
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    SailManager *manager = SailManager__GetWork();

    work->userFlag &= ~SAILPLAYER_FLAG_8000;
    SailPlayer__HandleTimers(work);

    if ((manager->flags & SAILMANAGER_FLAG_8) != 0)
        work->userFlag |= SAILPLAYER_FLAG_10;

    SailPlayer__ReadInputs(work);

    if ((manager->flags & SAILMANAGER_FLAG_1) != 0)
    {
        if (((manager->flags & SAILMANAGER_FLAG_FREEZE_ALPHA_TIMER) != 0 || (manager->flags & SAILMANAGER_FLAG_8) != 0) && (work->userFlag & SAILPLAYER_FLAG_8) == 0)
        {
            SailPlayer__Action_StopBoost(work);
            worker->speed = ObjSpdDownSet(worker->speed, FLOAT_TO_FX32(0.0322265625));
        }
    }
    else
    {
        switch (worker->shipType)
        {
            case SHIP_HOVER:
                SailPlayer__HandleHoverControl1(work);
                SailPlayer__HandleHoverControl2(work);
                break;

            case SHIP_JET:
                SailPlayer__HandleJetControl(work);
                break;

            case SHIP_BOAT:
                SailPlayer__HandleBoatControl(work);
                break;

            case SHIP_SUBMARINE:
                SailPlayer__HandleSubmarineControl(work);
                break;
        }
    }
}

void SailPlayer__ReadInputs(StageTask *work)
{
    SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (!worker->isRival)
    {
        worker->touchFlags = touchInput.flags;

        if ((manager->flags & SAILMANAGER_FLAG_1) == 0)
        {
            if ((manager->flags & SAILMANAGER_FLAG_REPLAY_ACTIVE) != 0 && (worker->btnPress & PAD_BUTTON_START) != 0)
                manager->flags |= SAILMANAGER_FLAG_DISABLE_BTN_PRESS;

            worker->touchPrev.x = touchInput.prev.x;
            worker->touchPrev.y = touchInput.prev.y;

            if ((worker->touchFlags & (1 << TOUCH_STATE_HAS_PREV)) == 0)
            {
                worker->touchPrev.x = touchInput.on.x;
                worker->touchPrev.y = touchInput.on.y;
            }

            worker->touchOn.x = touchInput.on.x;
            worker->touchOn.y = touchInput.on.y;

            worker->touchPush.x = touchInput.push.x;
            worker->touchPush.y = touchInput.push.y;

            worker->btnPress   = padInput.btnPress;
            worker->btnDown    = padInput.btnDown;
            worker->btnRelease = padInput.btnRelease;

            if ((manager->flags & SAILMANAGER_FLAG_DISABLE_BTN_PRESS) != 0)
            {
                worker->btnPress = PAD_INPUT_NONE_MASK;
                worker->touchFlags &= ~(1 << TOUCH_STATE_HAS_PUSH);
            }
        }
    }
    else
    {
        manager = SailManager__GetWork();

        worker->btnPress   = PAD_INPUT_NONE_MASK;
        worker->btnRelease = PAD_INPUT_NONE_MASK;
        worker->btnDown    = PAD_INPUT_NONE_MASK;

        if ((manager->flags & SAILMANAGER_FLAG_1) == 0)
        {
            if ((work->userFlag & SAILPLAYER_FLAG_10000) == 0 && worker->rivalVoiceClipTimer == 0)
            {
                work->userFlag |= SAILPLAYER_FLAG_10000;
                SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_FOLLOW); // "Think you can keep up?"
            }
        }

        switch (manager->isRivalRace)
        {
            case 1:
            case 2:
                worker->touchOn.x  = worker->sailRival->touchPosX;
                worker->touchPos.x = worker->touchOn.x;
                worker->seaPos.x   = 160 * ((worker->sailRival->touchPosX - HW_LCD_CENTER_X) >> 1); // touchPos.x ranges from 0-256, with 128 being "0"

                if ((manager->flags & SAILMANAGER_FLAG_1) != 0)
                {
                    worker->racePos.x = worker->seaPos.x;
                }
                else
                {
                    worker->touchFlags = (1 << TOUCH_STATE_HAS_ON);

                    if (worker->sailRival->disablePrevPosTimer)
                        worker->touchFlags &= ~(1 << TOUCH_STATE_HAS_ON);

                    if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_START_BOOST)) != 0)
                    {
                        if (manager->raceRank == 0)
                            SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_YOU); // "Arghh!"

                        worker->btnPress |= PAD_BUTTON_L;
                        worker->btnDown |= PAD_BUTTON_L;
                        SailJetRaceOpponentWarningHUD__Create(work);
                    }

                    if ((work->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
                        worker->btnDown |= PAD_BUTTON_L;

                    if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_STOP_BOOST)) != 0)
                    {
                        worker->btnDown &= ~PAD_BUTTON_L;
                        worker->btnRelease |= PAD_BUTTON_L;
                    }

                    if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_DO_TRICK)) != 0 && StageTaskStateMatches(work, SailPlayer__State_JumpRamp))
                        worker->field_1D8 = 1;

                    if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_JUMP_RAMP)) != 0)
                        SailPlayer__Gimmick_JumpRamp(work);

                    if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_TAKE_DAMAGE)) != 0)
                    {
                        SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_OUCH);
                        SailPlayer__Action_HurtJetHover2(work);
                    }

                    if (MATH_ABS(voyageManager->voyagePos - worker->racePos.z) < FLOAT_TO_FX32(256.0))
                    {
                        if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_DROP_BOMB)) != 0)
                        {
                            SailManager *manager = SailManager__GetWork(); // ???
							UNUSED(manager);

                            VecFx32 position = worker->racePos;

                            SailEventManager__CreateObject2(SailEventManager__CreateObject(13, &position));

                            work->shakeTimer = FLOAT_TO_FX32(4.0);
                            if (worker->rivalVoiceClipTimer == 0)
                            {
                                if (ObjDispRandRepeat(2) != 0)
                                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_KURAE); // "I don't think so!"
                                else
                                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_HORAYO); // "Check this out!"

                                worker->rivalVoiceClipTimer = 60;
                            }
                        }

                        if ((worker->sailRival->actions & SAILRIVAL_GET_ACTION_FLAG(SAILRIVAL_ACTION_LAUNCH_TORPEDO)) != 0)
                        {
                            EffectSailFlash__CreateFromJohnny(work);

                            work->shakeTimer = FLOAT_TO_FX32(4.0);
                            if (worker->rivalVoiceClipTimer == 0)
                            {
                                if (ObjDispRandRepeat(2) != 0)
                                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_KURAE); // "I don't think so!"
                                else
                                    SailAudio__PlaySequence(SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_HORAYO); // "Check this out!"

                                worker->rivalVoiceClipTimer = 60;
                            }
                        }
                    }
                }
                break;

            case 3:
            case 4:
                break;
        }
    }
}

NONMATCH_FUNC void SailPlayer__HandleJetSfx(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	ldrh r0, [r4, #2]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x1c]
	tst r0, #0x10
	beq _0215E388
	ldr r0, [r4, #0x280]
	mov r1, #0
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}
_0215E388:
	bl GetSfxVolume
	ldr r1, [r6, #0x24]
	mov r5, r0, lsl #0xc
	tst r1, #1
	mov r1, #0
	bne _0215E4AC
	ldr r0, [r4, #0x278]
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ldreq r0, [r6, #0xa0]
	cmpeq r0, #0
	ldreq r0, [r6, #0x98]
	cmpeq r0, #0
	mov r0, #0
	bne _0215E410
	mov r2, r0
	mov r1, #2
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r4, #0x280]
	mov r1, #0
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, #0
	ldr r0, [r4, #0x280]
	mov r2, r1
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #2
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}
_0215E410:
	mov r1, r0
	mov r2, r0
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r4, #0x280]
	mov r1, #2
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	bne _0215E440
	ldr r0, [r4, #0x280]
	mov r1, #2
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215E440:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215E474
	ldr r0, [r6, #0x98]
	ldr r1, [r6, #0xa0]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r0, r1, r0
	mov r1, #0x2000
	bl FX_Div
	b _0215E47C
_0215E474:
	mov r1, #0x1400
	bl FX_Div
_0215E47C:
	cmp r0, #0x1000
	movgt r0, #0x1000
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}
_0215E4AC:
	ldr r0, [r4, #0x280]
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #0x278]
	mov r1, #5
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	bne _0215E4D8
	ldr r0, [r4, #0x278]
	mov r1, #5
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215E4D8:
	ldr r0, [r4, #0x10]
	mov r1, #0x2000
	bl FX_Div
	cmp r0, #0x1000
	movgt r0, #0x1000
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	ldr r0, [r4, #0x278]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__HandleBoatSfx(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl GetSfxVolume
	mov r2, r0, asr #1
	ldr r0, [r4, #0x280]
	mov r1, #0x16
	mov r5, r2, lsl #0xc
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	bne _0215E564
	ldr r0, [r4, #0x280]
	mov r1, #0x16
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #1
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
_0215E564:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215E598
	ldr r0, [r6, #0x98]
	ldr r1, [r6, #0xa0]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r0, r1, r0
	mov r1, #0x1000
	bl FX_Div
	b _0215E5A0
_0215E598:
	mov r1, #0x800
	bl FX_Div
_0215E5A0:
	cmp r0, #0x1000
	movgt r0, #0x1000
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__HandleBoatWeaponTimers(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r0, [r4, #0x214]
	cmp r0, #0
	bne _0215E60C
	ldr r0, [r4, #0x220]
	add r0, r0, #0x1000
	str r0, [r4, #0x220]
	cmp r0, #0x6000
	blt _0215E60C
	mov r0, #0
	str r0, [r4, #0x220]
	mov r0, #0x6000
	str r0, [r4, #0x214]
_0215E60C:
	ldr r0, [r4, #0x218]
	cmp r0, #0
	bne _0215E69C
	ldr r1, [r4, #0x224]
	add r0, r4, #0x100
	add r1, r1, #0x1b0
	str r1, [r4, #0x224]
	ldrh r0, [r0, #0xce]
	cmp r0, #2
	ldrhs r0, [r4, #0x224]
	addhs r0, r0, #0x1b0
	strhs r0, [r4, #0x224]
	ldr r0, [r4, #0x224]
	cmp r0, #0x3000
	blt _0215E69C
	mov r2, #0
	str r2, [r4, #0x224]
	mov r0, #0x3000
	str r0, [r4, #0x218]
	ldr r0, [r5, #0x138]
	mov r1, #0x21
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #1
	ldr r0, [r5, #0x138]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	add r0, r4, #0x200
	ldrh r0, [r0, #0xe]
	cmp r0, #1
	beq _0215E69C
	bl GetSfxVolume
	mov r1, r0, asr #2
	ldr r0, [r5, #0x138]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
_0215E69C:
	ldr r0, [r4, #0x21c]
	cmp r0, #0
	bne _0215E72C
	ldr r1, [r4, #0x228]
	add r0, r4, #0x100
	add r1, r1, #0x50
	str r1, [r4, #0x228]
	ldrh r0, [r0, #0xce]
	cmp r0, #2
	ldrhs r0, [r4, #0x228]
	addhs r0, r0, #0x28
	strhs r0, [r4, #0x228]
	ldr r0, [r4, #0x228]
	cmp r0, #0x1000
	blt _0215E72C
	mov r2, #0
	str r2, [r4, #0x228]
	mov r0, #0x1000
	str r0, [r4, #0x21c]
	ldr r0, [r5, #0x138]
	mov r1, #0x21
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #1
	ldr r0, [r5, #0x138]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	add r0, r4, #0x200
	ldrh r0, [r0, #0xe]
	cmp r0, #2
	beq _0215E72C
	bl GetSfxVolume
	mov r1, r0, asr #2
	ldr r0, [r5, #0x138]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
_0215E72C:
	ldr r0, [r4, #0x218]
	cmp r0, #0
	ldrne r0, [r4, #0x21c]
	cmpne r0, #0
	ldr r0, [r5, #0x24]
	bne _0215E7D4
	tst r0, #0x20000000
	orreq r0, r0, #0x20000000
	streq r0, [r5, #0x24]
	ldr r0, [r4, #0x27c]
	mov r1, #0x20
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	bne _0215E774
	ldr r0, [r4, #0x27c]
	mov r1, #0x20
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_0215E774:
	ldr r0, [r4, #0x218]
	cmp r0, #0
	addeq r0, r4, #0x200
	ldreqh r0, [r0, #0xe]
	cmpeq r0, #1
	beq _0215E7A4
	ldr r0, [r4, #0x21c]
	cmp r0, #0
	addeq r0, r4, #0x200
	ldreqh r0, [r0, #0xe]
	cmpeq r0, #2
	bne _0215E7BC
_0215E7A4:
	bl GetSfxVolume
	mov r1, r0, asr #2
	ldr r0, [r4, #0x27c]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r3, r4, r5, pc}
_0215E7BC:
	bl GetSfxVolume
	mov r1, r0, asr #3
	ldr r0, [r4, #0x27c]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r3, r4, r5, pc}
_0215E7D4:
	tst r0, #0x20000000
	ldmeqia sp!, {r3, r4, r5, pc}
	bic r0, r0, #0x20000000
	str r0, [r5, #0x24]
	ldr r0, [r4, #0x27c]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__HandleHoverSfx(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl GetSfxVolume
	ldr r1, [r4, #0x10]
	mov r0, r0, asr #1
	cmp r1, #0
	mov r5, r0, lsl #0xc
	ldreq r0, [r6, #0xa0]
	cmpeq r0, #0
	ldreq r0, [r6, #0x98]
	cmpeq r0, #0
	mov r0, #0
	bne _0215E874
	mov r2, r0
	mov r1, #2
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r4, #0x280]
	mov r1, #0x2f
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x280]
	mov r1, #0x2f
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #2
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}
_0215E874:
	mov r2, r0
	mov r1, #0x2f
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	ldr r0, [r4, #0x280]
	mov r1, #0x31
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	bne _0215E8B8
	ldr r0, [r4, #0x280]
	mov r1, #0x31
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #1
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
_0215E8B8:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215E8EC
	ldr r0, [r6, #0x98]
	ldr r1, [r6, #0xa0]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r0, r1, r0
	mov r1, #0x2000
	bl FX_Div
	b _0215E8F4
_0215E8EC:
	mov r1, #0x1000
	bl FX_Div
_0215E8F4:
	cmp r0, #0x1000
	movgt r0, #0x1000
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__HandleSubmarineSfx(StageTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl GetSfxVolume
	mov r2, r0, asr #1
	ldr r0, [r4, #0x280]
	mov r1, #0x41
	mov r5, r2, lsl #0xc
	bl SailAudio__CheckSequencePlaying
	cmp r0, #0
	bne _0215E974
	ldr r0, [r4, #0x280]
	mov r1, #0x41
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	bl GetSfxVolume
	mov r1, r0, asr #1
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
_0215E974:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _0215E9A8
	ldr r0, [r6, #0x98]
	ldr r1, [r6, #0xa0]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r0, r1, r0
	mov r1, #0x1000
	bl FX_Div
	b _0215E9B0
_0215E9A8:
	ldr r1, =0x00001C8D
	bl FX_Div
_0215E9B0:
	cmp r0, #0x1000
	movgt r0, #0x1000
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, asr #0xc
	ldr r0, [r4, #0x280]
	and r1, r1, #0xff
	bl NNS_SndPlayerSetVolume
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Last_Default(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailManager__GetWork
	mov r6, r0
	ldr r7, =gameState
	bl SailManager__GetWork
	ldr r1, [r6, #0xc]
	ldr r8, [r0, #0x98]
	cmp r1, #0
	beq _0215EAA8
	ldrh r0, [r6, #0x28]
	cmp r0, #0
	beq _0215EA94
	ldr r0, [r4, #0x24]
	tst r0, #1
	addeq r0, r5, #0x100
	ldreqsh r0, [r0, #0xee]
	cmpeq r0, #0
	bne _0215EA94
	ldr r1, [r6, #0x8c]
	ldr r0, [r8, #0x44]
	ldr r1, [r1, #0x124]
	ldr r1, [r1, #0x25c]
	sub r0, r1, r0
	cmp r0, #0x80000
	ble _0215EA94
	sub r0, r0, #0x80000
	cmp r0, #0x80000
	mov r1, #0x400
	bge _0215EA8C
	mov r1, r0, asr #7
	mov r0, r1, asr #0x1f
	mov r2, r0, lsl #0xa
	mov r0, #0x800
	adds r3, r0, r1, lsl #10
	orr r2, r2, r1, lsr #22
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
_0215EA8C:
	mov r0, r4
	bl SailPlayer__GiveBoost
_0215EA94:
	ldr r0, [r6, #0x20]
	tst r0, #0xf
	ldreqh r1, [r6, #0x28]
	addeq r0, r5, #0x100
	streqh r1, [r0, #0xf2]
_0215EAA8:
	ldr r0, [r6, #0xc]
	cmp r0, #1
	bne _0215EAE8
	ldrh r0, [r5, #2]
	cmp r0, #0
	beq _0215EAE8
	ldr r0, [r4, #0x144]
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _0215EAE8
	mov r0, #0x4000
	str r0, [r4, #4]
	ldr r1, [r4, #0x144]
	ldr r0, [r1, #0x18]
	bic r0, r0, #0x200
	str r0, [r1, #0x18]
_0215EAE8:
	ldrh r0, [r5, #2]
	cmp r0, #0
	beq _0215EB1C
	ldr r0, [r4, #0x24]
	tst r0, #1
	beq _0215EB1C
	ldr r0, [r6, #0x1c]
	cmp r0, #0xb4
	bls _0215EB1C
	tst r0, #0xf
	bne _0215EB1C
	mov r0, r4
	bl EffectSailCircle__Create
_0215EB1C:
	ldr r0, [r4, #0x1c]
	tst r0, #0x10
	bne _0215EB30
	mov r0, r4
	bl SailPlayer__Func_215F154
_0215EB30:
	ldr r0, [r4, #0x24]
	tst r0, #8
	bne _0215EB68
	bl SailVoyageManager__GetVoyageAngle
	add r0, r0, #0x8000
	strh r0, [r4, #0x32]
	ldrh r0, [r5, #0]
	cmp r0, #2
	bne _0215EB68
	add r0, r5, #0x100
	ldrh r1, [r4, #0x32]
	ldrsh r0, [r0, #0xcc]
	sub r0, r1, r0
	strh r0, [r4, #0x32]
_0215EB68:
	ldrh r0, [r5, #2]
	cmp r0, #0
	bne _0215EB8C
	bl SailManager__GetWork
	ldr r1, [r0, #0x94]
	cmp r1, #0
	addne r0, r5, #0x100
	ldrnesh r0, [r0, #0xca]
	strneh r0, [r1, #0x12]
_0215EB8C:
	ldrh r0, [r5, #0]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215EE94
_0215EB9C: // jump table
	b _0215EBAC // case 0
	b _0215ECD8 // case 1
	b _0215EC04 // case 2
	b _0215ED24 // case 3
_0215EBAC:
	add r0, r5, #0x200
	ldrh r0, [r0, #0x3c]
	tst r0, #1
	beq _0215EBD4
	ldr r0, [r4, #0x1c]
	tst r0, #0x10
	bne _0215EBD4
	ldr r0, [r4, #0x24]
	tst r0, #2
	beq _0215EBE8
_0215EBD4:
	ldrh r0, [r4, #0x30]
	mov r1, #0x200
	bl ObjSpdDownSet
	strh r0, [r4, #0x30]
	b _0215EBFC
_0215EBE8:
	ldrh r0, [r4, #0x30]
	mov r1, #0x200
	mov r2, #0x800
	bl ObjSpdUpSet
	strh r0, [r4, #0x30]
_0215EBFC:
	mov r0, r4
	bl SailPlayer__HandleJetSfx
_0215EC04:
	ldr r1, [r4, #0x24]
	tst r1, #4
	beq _0215EC30
	ldr r0, [r4, #0x1c]
	tst r0, #1
	beq _0215EC30
	bic r2, r1, #4
	mov r0, r4
	mov r1, #0
	str r2, [r4, #0x24]
	bl SailPlayer__ColliderFunc
_0215EC30:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, [r5, #0x10]
	cmpne r0, #0
	beq _0215EC9C
	ldr r0, [r6, #0x1c]
	tst r0, #3
	bne _0215EC9C
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	bne _0215EC9C
	mov r0, r4
	bl SailPlayer__Func_215BD3C
	mov r0, r4
	bl SailPlayer__Func_215BD3C
	mov r0, r4
	bl SailPlayer__Func_215BD3C
	mov r0, r4
	bl SailPlayer__Func_215BD3C
_0215EC9C:
	mov r0, r4
	add r1, r5, #0x34
	bl SailObject__Func_216524C
	mov r0, r4
	add r1, r5, #0xac
	bl SailObject__Func_216524C
	mov r0, r4
	add r1, r5, #0x124
	bl SailObject__Func_216524C
	ldrh r0, [r5, #0]
	cmp r0, #2
	bne _0215EE94
	mov r0, r4
	bl SailPlayer__HandleHoverSfx
	b _0215EE94
_0215ECD8:
	ldr r0, [r5, #0x10]
	cmp r0, #0
	beq _0215ED10
	ldr r0, [r4, #0x24]
	tst r0, #0x1000
	bne _0215ED00
	add r0, r5, #0x200
	ldrh r1, [r0, #8]
	add r1, r1, #0x800
	strh r1, [r0, #8]
_0215ED00:
	add r0, r5, #0x200
	ldrh r1, [r0, #0xa]
	add r1, r1, #0x800
	strh r1, [r0, #0xa]
_0215ED10:
	mov r0, r4
	bl SailPlayer__HandleBoatSfx
	mov r0, r4
	bl SailPlayer__HandleBoatWeaponTimers
	b _0215EE94
_0215ED24:
	mov r0, #0x1000
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x24]
	tst r0, #8
	bne _0215ED88
	ldr r1, [r8, #0x44]
	mov r0, #0x28
	add r1, r1, #0x30000
	mov r1, r1, asr #0x13
	mul r9, r1, r0
	ldr r10, [r8, #0xc0]
	add r0, r10, r9
	bl SailVoyageManager__GetSegmentSize
	ldr r1, [r8, #0x44]
	ldr r2, =0x0007FFFF
	add r3, r1, #0x30000
	mov r1, r0
	and r0, r3, r2
	bl FX_Div
	mov r1, r0
	add r0, r10, r9
	bl SailVoyageManager__GetAngleForSegmentPos
	ldrh r1, [r8, #0x34]
	sub r0, r0, r1
	strh r0, [r8, #0x3c]
_0215ED88:
	ldr r0, [r6, #0x1c]
	tst r0, #1
	bne _0215EE64
	ldr r0, [r6, #0x24]
	tst r0, #1
	bne _0215EDAC
	ldr r0, [r4, #0x24]
	tst r0, #8
	beq _0215EE64
_0215EDAC:
	add r0, r4, #0x44
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [sp, #4]
	ldr r0, [r4, #0x54]
	mov r1, #0x9600
	add r0, r2, r0
	str r0, [sp, #4]
	ldrh r0, [r4, #0x32]
	ldr ip, =FX_SinCosTable_
	rsb r1, r1, #0
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r8, [ip, r0]
	mvn r2, #0
	ldr r10, [sp]
	umull r0, lr, r8, r1
	adds r0, r0, #0x800
	mov r9, r0, lsr #0xc
	mov r0, r3
	mla lr, r8, r2, lr
	mov r3, r8, asr #0x1f
	mla lr, r3, r1, lr
	adc r3, lr, #0
	orr r9, r9, r3, lsl #20
	add r3, r10, r9
	str r3, [sp]
	ldrh r8, [r4, #0x32]
	ldr r3, [sp, #8]
	mov r8, r8, asr #4
	mov r8, r8, lsl #1
	add r8, r8, #1
	mov r8, r8, lsl #1
	ldrsh r9, [ip, r8]
	umull ip, r10, r9, r1
	mla r10, r9, r2, r10
	mov r8, r9, asr #0x1f
	adds r2, ip, #0x800
	mla r10, r8, r1, r10
	adc r1, r10, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r3, r2
	str r1, [sp, #8]
	bl EffectSailBomb2__Create
_0215EE64:
	mov r0, r4
	bl SailPlayer__HandleSubmarineSfx
	mov r0, r4
	add r1, r5, #0x34
	bl SailObject__Func_216524C
	add r0, r5, #0x100
	ldrh r0, [r0, #0xce]
	cmp r0, #2
	blo _0215EE94
	mov r0, r4
	mvn r1, #0x7f
	bl SailPlayer__RemoveHealth
_0215EE94:
	ldr r0, [r6, #0x24]
	tst r0, #8
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	tst r0, #0x4000
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	tst r0, #0x2000000
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	tst r0, #0x40
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	tst r0, #0x20
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	tst r0, #1
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	tst r0, #0x10000
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	bl DrawReqTask__GetEnabled
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r7, #0x9c]
	tst r0, #1
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r6, #0x24]
	tst r0, #0x8000000
	bne _0215EF34
	add r0, r5, #0x200
	ldrh r0, [r0, #0x3e]
	tst r0, #8
	beq _0215EF34
	bl Task__OVL06Unknown2179284__Create
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_0215EF34:
	bl GetPadReplayState
	cmp r0, #2
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, =0x04000130
	ldr r0, =0x027FFFA8
	ldrh r3, [r1, #0]
	ldrh r2, [r0, #0]
	ldr r0, =0x00002FFF
	ldr r1, =0x00000C0B
	orr r2, r3, r2
	eor r2, r2, r0
	and r0, r2, r0
	mov r0, r0, lsl #0x10
	tst r1, r0, lsr #16
	bne _0215EF84
	bl CheckAnyTouchForSailDemoPlayer
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_0215EF84:
	bl Task__OVL06Unknown2179330__Create
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__BoatRenderCallback(NNSG3dRS *rs)
{
    // https://decomp.me/scratch/zlugs -> 99.03%
	// register mismatch near 'MTX_RotX33'
#ifdef NON_MATCHING
    static const NNSG3dResName nameL = { "screw_l" };
    static const NNSG3dResName nameR = { "screw_r" };

    u32 idxScrewL = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &nameL);
    u32 idxScrewR = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, &nameR);

    NNSG3dRS *rs_copy;
    if ((idxScrewL == NNS_G3dRSGetCurrentNodeDescID(rs_copy = rs)) || (idxScrewR == NNS_G3dRSGetCurrentNodeDescID(rs)))
    {
        StageTask *work = SailManager__GetWork()->sailPlayer;
        SailPlayer *worker = GetStageTaskWorker(work, SailPlayer);

        fx32 posScale = rs->posScale;
        fx32 invPosScale = rs->invPosScale;

        NNS_G3dGeScale(posScale, posScale, posScale);

        if (idxScrewR == NNS_G3dRSGetCurrentNodeDescID(rs))
        {
            NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_SYS);
        }
        else
        {
            NNS_G3dGeStoreMtx(NNS_G3D_MTXSTACK_USER);
        }

        NNS_G3dGeScale(invPosScale, invPosScale, invPosScale);

        MtxFx33 mtx;
        if (idxScrewL == NNS_G3dRSGetCurrentNodeDescID(rs))
        {
            MTX_RotX33(&mtx, SinFX(worker->field_208), CosFX(worker->field_208));
        }
        else
        {
            MTX_RotX33(&mtx, SinFX(worker->field_20A), CosFX(worker->field_20A));
        }

        NNS_G3dGeMultMtx33(&mtx);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x44
	mov r8, r0
	ldr r0, [r8, #4]
	ldr r1, =aScrewL
	ldr r0, [r0, #4]
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
	ldr r2, [r8, #4]
	ldr r1, =aScrewR
	ldr r2, [r2, #4]
	mov r4, r0
	add r0, r2, #0x40
	bl NNS_G3dGetResDictIdxByName
	ldr r1, [r8, #8]
	mov r5, r0
	tst r1, #0x10
	ldrneb r0, [r8, #0xae]
	mvneq r0, #0
	cmp r4, r0
	beq _0215F028
	ldr r0, [r8, #8]
	tst r0, #0x10
	ldrneb r0, [r8, #0xae]
	mvneq r0, #0
	cmp r5, r0
	addne sp, sp, #0x44
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215F028:
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	ldr r0, [r8, #0xe0]
	ldr r6, [r1, #0x124]
	ldr r7, [r8, #0xe4]
	add r1, sp, #0x14
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r8, #8]
	mov r2, #1
	tst r0, #0x10
	ldrneb r0, [r8, #0xae]
	mvneq r0, #0
	cmp r5, r0
	mov r0, #0x13
	bne _0215F08C
	mov r3, #0x1e
	add r1, sp, #4
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	b _0215F09C
_0215F08C:
	mov r3, #0x1d
	add r1, sp, #0
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
_0215F09C:
	add r1, sp, #8
	str r7, [sp, #8]
	str r7, [sp, #0xc]
	str r7, [sp, #0x10]
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r8, #8]
	tst r0, #0x10
	ldrneb r0, [r8, #0xae]
	mvneq r0, #0
	cmp r4, r0
	add r0, r6, #0x200
	bne _0215F104
	ldrh r1, [r0, #8]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x20
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	mov r2, r2, lsl #1
	mov r1, r1, lsl #1
	ldrsh r2, [r3, r2]
	ldrsh r1, [r3, r1]
	bl MTX_RotX33_
	b _0215F130
_0215F104:
	ldrh r1, [r0, #0xa]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x20
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	mov r2, r2, lsl #1
	mov r1, r1, lsl #1
	ldrsh r2, [r3, r2]
	ldrsh r1, [r3, r1]
	bl MTX_RotX33_
_0215F130:
	add r1, sp, #0x20
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailPlayer__Func_215F154(StageTask *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldrh r0, [r4, #0]
	cmp r0, #1
	ldrne r2, [r4, #0x1d0]
	cmpne r2, #0
	beq _0215F1A4
	mov r1, #0
	str r1, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	ldr r0, [r4, #0x1d4]
	mov r3, #2
	bl ObjDiffSet
	str r0, [r4, #0x1d4]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x1d0]
_0215F1A4:
	add r0, r5, #0x44
	bl SailSea__GetSurfacePosition
	str r0, [r5, #0x48]
	ldr r1, [r4, #0x1d4]
	add r0, r0, r1
	str r0, [r5, #0x48]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}
