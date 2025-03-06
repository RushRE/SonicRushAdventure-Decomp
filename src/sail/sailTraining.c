#include <sail/sailTraining.h>
#include <sail/sailManager.h>
#include <sail/sailPlayer.h>
#include <sail/sailAudio.h>
#include <sail/sailInputPrompts.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED StageTask *SailTrainingDialog__Create(u16 id);
NOT_DECOMPILED u16 SailMessageCommon__Func_21729F4(StageTask *work);
NOT_DECOMPILED void SailTrainingFinishedDialog__Create(BOOL allClear);
NOT_DECOMPILED void SailRetireEvent__CreateFadeOut(void);

// --------------------
// ENUMS
// --------------------

enum SailTrainingMode
{
    SAILTRAINING_MODE_0,
    SAILTRAINING_MODE_1,
    SAILTRAINING_MODE_2,
    SAILTRAINING_MODE_3,
    SAILTRAINING_MODE_4,
    SAILTRAINING_MODE_5,

    SAILTRAINING_MODE_COUNT,
};

// --------------------
// STRUCTS
// --------------------

struct SailTrainingConfig
{
    u8 unknown[SAILTRAINING_MODE_COUNT];
};

// --------------------
// VARIABLES
// --------------------

static const struct SailTrainingConfig sailTrainingUnknown1[SHIP_COUNT] = {
    [SHIP_JET]       = { 0, 0, 3, 6, 9, 11 },
    [SHIP_BOAT]      = { 0, 0, 3, 6, 8, 0 },
    [SHIP_HOVER]     = { 0, 0, 3, 6, 11, 0 },
    [SHIP_SUBMARINE] = { 0, 0, 4, 8, 0, 0 },
};

static const struct SailTrainingConfig sailTrainingUnknown2[SHIP_COUNT] = {
    [SHIP_JET]       = { 0, 2, 5, 8, 11, 17 },
    [SHIP_BOAT]      = { 0, 2, 5, 8, 13, 0 },
    [SHIP_HOVER]     = { 0, 2, 5, 11, 17, 0 },
    [SHIP_SUBMARINE] = { 0, 2, 6, 14, 0, 0 },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SailTraining_Destructor(Task *task);

// Main events
static void SailTraining_Main_Init(void);
static void SailTraining_Main_TrainingActive(void);

// States
static BOOL SailTraining_State_Jet(void);
static BOOL SailTraining_State_Boat(void);
static BOOL SailTraining_State_Hover(void);
static BOOL SailTraining_State_Submarine(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailTraining(void)
{
    SailManager *manager = SailManager__GetWork();

    Task *task = TaskCreate(SailTraining_Main_Init, SailTraining_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1), SailTraining);

    SailTraining *work = TaskGetWork(task, SailTraining);
    TaskInitWork16(work);

    manager->flags |= SAILMANAGER_FLAG_1;

    SailTrainingDialog__Create(0);

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        default:
            work->state = SailTraining_State_Jet;
            break;

        case SHIP_BOAT:
            work->state = SailTraining_State_Boat;
            break;

        case SHIP_HOVER:
            work->state = SailTraining_State_Hover;
            break;

        case SHIP_SUBMARINE:
            work->state = SailTraining_State_Submarine;
            break;
    }
}

void SailTraining_Destructor(Task *task)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);
    UNUSED(work);

    SailManager *manager = SailManager__GetWork();
    manager->flags &= ~SAILMANAGER_FLAG_1;
}

void SailTraining_Main_Init(void)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);

    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    StageTask *player                = SailManager__GetWork()->sailPlayer;
    SailHUD *hud                     = SailManager__GetWork()->hud;
    UNUSED(voyageManager);
    UNUSED(player);
    UNUSED(hud);

    u16 shipType = SailManager__GetShipType();
    UNUSED(shipType);

    if (manager->missionQuota != 0)
    {
        if ((work->flags & SAILTRAINING_FLAG_CREATED_FIRST_DIALOG) == 0 && (manager->flags & SAILMANAGER_FLAG_10) == 0)
        {
            work->sailTrainingDialog = SailTrainingDialog__Create(0xFFFF);
            work->flags |= SAILTRAINING_FLAG_CREATED_FIRST_DIALOG;
        }
    }
    else
    {
        if (work->mode == SAILTRAINING_MODE_0 && (manager->flags & SAILMANAGER_FLAG_10) == 0)
        {
            work->mode++;
            SailTrainingDialog__Create(work->mode);
            SetCurrentTaskMainEvent(SailTraining_Main_TrainingActive);
        }
    }

    if (work->sailTrainingDialog != NULL && (work->sailTrainingDialog->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
    {
        u16 selection            = SailMessageCommon__Func_21729F4(work->sailTrainingDialog);
        work->sailTrainingDialog = NULL;
        if (selection != 0)
        {
            SailTrainingDialog__Create(0xFFFE);
            work->flags |= SAILTRAINING_FLAG_CREATED_GOOD_LUCK_DIALOG;
            manager->nextEvent = 1;
            manager->field_4   = 1;
        }
        else
        {
            work->mode++;
            SailTrainingDialog__Create(work->mode);
        }

        SetCurrentTaskMainEvent(SailTraining_Main_TrainingActive);
    }
}

void SailTraining_Main_TrainingActive(void)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);

    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    StageTask *player                = SailManager__GetWork()->sailPlayer;
    SailHUD *hud                     = SailManager__GetWork()->hud;

    u16 shipType = SailManager__GetShipType();

    if ((work->flags & SAILTRAINING_FLAG_CREATED_GOOD_LUCK_DIALOG) == 0)
    {
        if ((manager->flags & SAILMANAGER_FLAG_2000) == 0)
        {
            if (work->mode < SAILTRAINING_MODE_COUNT)
            {
                voyageManager->field_6C = sailTrainingUnknown1[shipType].unknown[work->mode];
                voyageManager->field_6E = sailTrainingUnknown2[shipType].unknown[work->mode];
            }

            if (work->state())
                manager->flags |= SAILMANAGER_FLAG_2000;

            if ((work->flags & SAILTRAINING_FLAG_FINISHED) != 0 && (manager->flags & SAILMANAGER_FLAG_10) == 0)
            {
                SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX);

                voyageManager->field_6C = 0;
                voyageManager->field_6E = 0;

                if (manager->missionQuota == 0)
                {
                    manager->nextEvent = 0;
                    manager->flags |= SAILMANAGER_FLAG_8;
                    SailRetireEvent__CreateFadeOut();
                }
                else
                {
                    manager->nextEvent = 1;
                    manager->field_4   = 1;
                }

                DestroyCurrentTask();
                return;
            }
        }
        else if ((manager->flags & SAILMANAGER_FLAG_10) == 0)
        {
            if (voyageManager->field_6E)
                SailTrainingFinishedDialog__Create(0);

            if (!voyageManager->field_6E)
            {
                if (sailTrainingUnknown2[shipType].unknown[work->mode] <= (s32)voyageManager->field_24)
                {
                    if ((work->flags & SAILTRAINING_FLAG_FINISHED) != 0)
                    {
                        SailTrainingFinishedDialog__Create(1);
                        manager->flags &= ~SAILMANAGER_FLAG_2000;
                    }
                    else
                    {
                        work->mode++;
                        SailTrainingDialog__Create(work->mode);
                        manager->flags &= ~SAILMANAGER_FLAG_2000;
                    }
                }
            }

            voyageManager->field_6C = 0;
            voyageManager->field_6E = 0;
        }
    }

    // auto-heal player
    if (hud->field_10 == hud->field_28 && hud->field_10 <= FLOAT_TO_FX32(128.0))
        SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX);
}

BOOL SailTraining_State_Jet(void)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);

    SailManager *manager             = SailManager__GetWork();
    SailPlayer *playerWorker         = NULL;
    StageTask *player                = SailManager__GetWork()->sailPlayer;
    SailHUD *hud                     = SailManager__GetWork()->hud;
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (hud == NULL)
        return FALSE;

    if (player != NULL)
        playerWorker = GetStageTaskWorker(player, SailPlayer);

    if (playerWorker == NULL)
        return FALSE;

    if ((manager->flags & SAILMANAGER_FLAG_1) != 0)
        return FALSE;

    switch (work->mode)
    {
        case SAILTRAINING_MODE_0:
            break;

        case SAILTRAINING_MODE_1:
            if (TOUCH_HAS_PUSH(touchInput.flags))
                work->timer = 0;

            if (TOUCH_HAS_ON(touchInput.flags))
            {
                work->timer++;
                if (work->timer > 60)
                {
                    work->timer     = 0;
                    work->jet.rings = playerWorker->rings;
                    return TRUE;
                }
            }
            break;

        case SAILTRAINING_MODE_2:
            if (TOUCH_HAS_ON(touchInput.flags))
            {
                if (touchInput.prev.x - touchInput.on.x > 4)
                    work->jet.flags |= 1;

                if (touchInput.prev.x - touchInput.on.x < -4)
                    work->jet.flags |= 2;

                if (work->jet.rings < playerWorker->rings)
                    work->timer++;

                work->jet.rings = playerWorker->rings;

                if (work->jet.flags == (1 | 2) && work->timer >= 10)
                {
                    work->jet.rings = 0;
                    work->timer     = 0;
                    work->jet.flags = 0;
                    return TRUE;
                }
            }
            break;

        case SAILTRAINING_MODE_3:
            if ((work->jet.flags & 2) == 0)
            {
                CreateSailStylusPrompt();
                work->jet.flags |= 2;
            }

            if (work->timer >= 3)
            {
                work->timer++;
                if (work->timer > 20)
                {
                    work->timer = 0;
                    return TRUE;
                }
            }
            else
            {
                if ((player->userFlag & SAILPLAYER_FLAG_4) != 0 && (work->jet.rings & SAILPLAYER_FLAG_4) == 0)
                    work->timer++;

                work->jet.rings = player->userFlag;
            }
            break;

        case SAILTRAINING_MODE_4:
            if ((work->jet.flags & 1) == 0)
            {
                CreateSailButtonPrompts();
                work->jet.flags |= 1;
            }

            if ((player->userFlag & SAILPLAYER_FLAG_BOOST) == 0 && playerWorker->boost <= FLOAT_TO_FX32(30.0))
                SailPlayer__GiveBoost(player, SAILPLAYER_BOOST_START);

            if (playerWorker->enemyDefeatCount > 0)
            {
                work->timer++;
                if (work->timer > 28)
                {
                    work->timer = 0;
                    return TRUE;
                }
            }
            break;

        case SAILTRAINING_MODE_5:
            if (voyageManager->voyagePos >= FLOAT_TO_FX32(2000.0))
            {
                work->flags |= SAILTRAINING_FLAG_FINISHED;
                SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX);
                return TRUE;
            }
            break;
    }

    return FALSE;
}

BOOL SailTraining_State_Boat(void)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);

    SailManager *manager             = SailManager__GetWork();
    SailPlayer *playerWorker         = NULL;
    StageTask *player                = SailManager__GetWork()->sailPlayer;
    SailHUD *hud                     = SailManager__GetWork()->hud;
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (hud == NULL)
        return FALSE;

    if (player)
        playerWorker = GetStageTaskWorker(player, SailPlayer);

    if (playerWorker == NULL)
        return FALSE;

    if ((manager->flags & SAILMANAGER_FLAG_1) != 0)
        return FALSE;

    switch (work->mode)
    {
        case SAILTRAINING_MODE_0:
            break;

        case SAILTRAINING_MODE_1:
            manager->flags |= SAILMANAGER_FLAG_400000;
            playerWorker->selectedWeapon = 0;

            if (work->boat.rings < playerWorker->field_1B3)
                work->timer++;

            work->boat.rings = playerWorker->field_1B3;

            if (work->timer >= 1)
                work->quota++;

            if (work->quota > 15)
            {
                work->timer      = 0;
                work->quota      = 0;
                work->boat.flags = 0;
                work->boat.rings = playerWorker->field_1B4;
                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_2:
            if (playerWorker->selectedWeapon != 1)
                SailAudio__PlaySpatialSequence(0, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_WEAPON, 0);

            playerWorker->selectedWeapon = 1;

            if (work->boat.rings < playerWorker->field_1B4)
                work->timer++;

            work->boat.rings = playerWorker->field_1B4;

            if (work->timer >= 4)
                work->quota++;

            if (work->quota > 10)
            {
                work->timer      = 0;
                work->quota      = 0;
                work->boat.rings = playerWorker->rings;
                work->boat.flags &= ~2;
                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_3:
            if ((work->boat.flags & 2) == 0)
            {
                CreateSailStylusPrompt2();
                work->boat.flags |= 2;
            }

            if (playerWorker->selectedWeapon != 2)
                SailAudio__PlaySpatialSequence(0, SND_SAIL_SEQARC_ARC_VOYAGE_SE_SEQ_SE_WEAPON, 0);

            playerWorker->selectedWeapon = 2;

            if (work->boat.rings < playerWorker->rings)
                work->timer++;

            work->boat.rings = playerWorker->rings;

            if (work->timer >= 30)
            {
                work->timer = 0;
                work->boat.flags &= ~1;
                work->boat.flags &= ~2;

                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_4:
            manager->flags &= ~SAILMANAGER_FLAG_400000;
            if (work->timer == 0)
            {
                playerWorker->selectedWeapon = 0;
                work->timer++;
            }

            if (playerWorker->selectedWeapon == 1)
                work->boat.flags |= 1;

            if (playerWorker->selectedWeapon == 2)
                work->boat.flags |= 2;

            if (voyageManager->voyagePos >= FLOAT_TO_FX32(1600.0))
            {
                if ((work->boat.flags & 1) != 0 && (work->boat.flags & 2) != 0)
                {
                    work->flags |= SAILTRAINING_FLAG_FINISHED;
                    SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX);
                    return TRUE;
                }
            }
            break;
    }

    return FALSE;
}

BOOL SailTraining_State_Hover(void)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);

    SailManager *manager             = SailManager__GetWork();
    SailPlayer *playerWorker         = NULL;
    StageTask *player                = SailManager__GetWork()->sailPlayer;
    SailHUD *hud                     = SailManager__GetWork()->hud;
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (hud == NULL)
        return FALSE;

    if (player)
        playerWorker = GetStageTaskWorker(player, SailPlayer);

    if (playerWorker == NULL)
        return FALSE;

    if ((manager->flags & SAILMANAGER_FLAG_1) != 0)
        return FALSE;

    switch (work->mode)
    {
        case SAILTRAINING_MODE_0:
            break;

        case SAILTRAINING_MODE_1:
            if (TOUCH_HAS_ON(touchInput.flags))
            {
                if (touchInput.prev.x - touchInput.on.x > 4)
                    work->hover.flags |= 1;

                if (touchInput.prev.x - touchInput.on.x < -4)
                    work->hover.flags |= 2;

                if (work->hover.rings < playerWorker->rings)
                    +work->timer++;

                work->hover.rings = playerWorker->rings;

                if (work->hover.flags == 3 && work->timer > 10)
                {
                    work->timer       = 0;
                    work->hover.flags = 0;
                    work->hover.rings = playerWorker->field_1B0;
                    return TRUE;
                }
            }
            break;

        case SAILTRAINING_MODE_2:
            if ((s32)work->hover.rings < playerWorker->field_1B0)
                work->timer++;

            work->hover.rings = playerWorker->field_1B0;

            if (work->timer >= 3)
            {
                work->timer       = 0;
                work->hover.flags = 0;
                work->hover.rings = playerWorker->field_1B2;
                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_3:
            if (work->hover.rings < playerWorker->field_1B2)
                work->timer++;

            work->hover.rings = playerWorker->field_1B2;

            if (work->timer >= 3)
            {
                work->timer       = 0;
                work->hover.flags = 0;
                work->hover.rings = 0;
                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_4:
            if (voyageManager->voyagePos >= FLOAT_TO_FX32(2112.0))
            {
                work->flags |= SAILTRAINING_FLAG_FINISHED;
                SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX);
                return TRUE;
            }
            break;
    }

    return FALSE;
}

BOOL SailTraining_State_Submarine(void)
{
    SailTraining *work = TaskGetWorkCurrent(SailTraining);

    SailManager *manager             = SailManager__GetWork();
    SailPlayer *playerWorker         = NULL;
    StageTask *player                = SailManager__GetWork()->sailPlayer;
    SailHUD *hud                     = SailManager__GetWork()->hud;
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (hud == NULL)
        return FALSE;

    if (player)
        playerWorker = GetStageTaskWorker(player, SailPlayer);

    if (playerWorker == NULL)
        return FALSE;

    if ((manager->flags & SAILMANAGER_FLAG_1) != 0)
        return FALSE;

    switch (work->mode)
    {
        case SAILTRAINING_MODE_0:
            break;

        case SAILTRAINING_MODE_1:
            if (work->submarine.enemyDefeatCount < playerWorker->enemyDefeatCount)
                work->timer++;

            work->submarine.enemyDefeatCount = playerWorker->enemyDefeatCount;

            if (work->timer >= 1)
                work->quota++;

            if (work->quota > 10)
            {
                work->timer                      = 0;
                work->quota                      = 0;
                work->submarine.flags            = 0;
                work->submarine.enemyDefeatCount = playerWorker->enemyDefeatCount;
                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_2:
            if (work->submarine.enemyDefeatCount < playerWorker->enemyDefeatCount)
                work->timer++;

            work->submarine.enemyDefeatCount = playerWorker->enemyDefeatCount;

            if (work->timer >= 2)
                work->quota++;

            if (work->quota > 10)
            {
                work->timer                      = 0;
                work->quota                      = 0;
                work->submarine.flags            = 0;
                work->submarine.enemyDefeatCount = playerWorker->enemyDefeatCount;
                return TRUE;
            }
            break;

        case SAILTRAINING_MODE_3:
            if (voyageManager->voyagePos >= FLOAT_TO_FX32(1408.0))
            {
                work->flags |= SAILTRAINING_FLAG_FINISHED;
                SailPlayer__AddHealth(player, SAILPLAYER_HEALTH_MAX);
                return TRUE;
            }
            break;
    }

    return FALSE;
}