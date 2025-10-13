#include <sail/sailInputPrompts.h>
#include <sail/sailManager.h>
#include <sail/sailHUD.h>
#include <sail/sailPlayer.h>
#include <sail/sailCommonObjects.h>
#include <game/file/binaryBundle.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>

// resources
#include <resources/bb/sb.h>

// --------------------
// ENUMS
// --------------------

enum SailButtonPromptAni
{
    SAILBUTTONPROMPT_ANI_DPAD_IDLE,
    SAILBUTTONPROMPT_ANI_DPAD_LEFT,
    SAILBUTTONPROMPT_ANI_DPAD_UP,
    SAILBUTTONPROMPT_ANI_DPAD_RIGHT,
    SAILBUTTONPROMPT_ANI_DPAD_DOWN,
    SAILBUTTONPROMPT_ANI_BUTTON_A,
    SAILBUTTONPROMPT_ANI_BUTTON_B,
    SAILBUTTONPROMPT_ANI_BUTTON_Y,
    SAILBUTTONPROMPT_ANI_BUTTON_L,
    SAILBUTTONPROMPT_ANI_BUTTON_R,
    SAILBUTTONPROMPT_ANI_ARROW_RIGHT,
    SAILBUTTONPROMPT_ANI_NDICATOR_LEFT,
    SAILBUTTONPROMPT_ANI_NDICATOR_RIGHT,
};

enum SailStylusPromptAni
{
    SAILSTYLUSPROMPT_ANI_STYLUS_IDLE,
    SAILSTYLUSPROMPT_ANI_STYLUS_MOVING,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void CreateSailButtonPromptIcon(u16 anim, fx32 posX);
static void SailButtonPromptIcon_State_Active(StageTask *work);

static void SailStylusPrompt_State_Active(StageTask *work);

static void SailStylusPrompt2_State_Active(StageTask *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailButtonPrompts(void)
{
    CreateSailButtonPromptIcon(SAILBUTTONPROMPT_ANI_BUTTON_L, FLOAT_TO_FX32(96.0));        // L
    CreateSailButtonPromptIcon(SAILBUTTONPROMPT_ANI_BUTTON_R, FLOAT_TO_FX32(160.0));       // R
    CreateSailButtonPromptIcon(SAILBUTTONPROMPT_ANI_NDICATOR_LEFT, FLOAT_TO_FX32(136.0));  // <-
    CreateSailButtonPromptIcon(SAILBUTTONPROMPT_ANI_NDICATOR_RIGHT, FLOAT_TO_FX32(184.0)); // ->
}

void CreateSailButtonPromptIcon(u16 anim, fx32 posX)
{
    SailManager *manager = SailManager__GetWork();
    UNUSED(manager);

    StageTask *work = CreateStageTaskEx_(TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(1));

    if (GetObjectDataWork(OBJDATAWORK_74)->fileData == NULL)
    {
        void *memory                                = ReadFileFromBundle("bb/sb.bb", BUNDLE_SB_FILE_RESOURCES_BB_SB_SB_BUTTON_PROMPT_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
        GetObjectDataWork(OBJDATAWORK_74)->fileData = memory;
    }

    ObjObjectAction2dBACLoad(work, NULL, NULL, GetObjectDataWork(OBJDATAWORK_74), NULL, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(work, SAILBUTTONPROMPT_ANI_DPAD_IDLE, 1050);
    StageTask__SetAnimation(work, anim);
    StageTask__SetAnimatorPriority(work, SPRITE_PRIORITY_1);
    SailObject_SetAnimSpeed(work, FLOAT_TO_FX32(1.0));

    work->position.x = posX;
    work->position.y = FLOAT_TO_FX32(38.0);

    work->state = SailButtonPromptIcon_State_Active;

    work->displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;
    work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
}

void SailButtonPromptIcon_State_Active(StageTask *work)
{
    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailManager *sailManager         = SailManager__GetWork();

    StageTask *player = sailManager->sailPlayer;
    if ((manager->flags & SAILMANAGER_FLAG_2000) != 0)
    {
        SailHUD__Func_2174BA4(TRUE);
        DestroyStageTask(work);
    }
    else if (voyageManager->voyagePos >= FLOAT_TO_FX32(1096.0))
    {
        work->displayFlag &= ~DISPLAY_FLAG_DISABLE_UPDATE;
        work->displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
        SailHUD__Func_2174BA4(FALSE);

        if ((player->userFlag & SAILPLAYER_FLAG_BOOST) != 0)
        {
            work->displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;
        }
        else
        {
            if ((work->displayFlag & DISPLAY_FLAG_DISABLE_LOOPING) == 0)
            {
                StageTask__SetAnimation(work, StageTask__GetAnimID(work));
            }
            work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }
}

void CreateSailStylusPrompt(void)
{
    SailManager *manager = SailManager__GetWork();
    UNUSED(manager);

    StageTask *work = CreateStageTaskEx_(TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(1));

    // NOTE: should this be using 'OBJDATAWORK_74'? would it not make more sense to use 'OBJDATAWORK_75'?
    if (GetObjectDataWork(OBJDATAWORK_74)->fileData == NULL)
    {
        void *memory                                = ReadFileFromBundle("bb/sb.bb", BUNDLE_SB_FILE_RESOURCES_BB_SB_SB_STYLUS_PROMPT_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
        GetObjectDataWork(OBJDATAWORK_75)->fileData = memory;
    }

    ObjObjectAction2dBACLoad(work, NULL, NULL, GetObjectDataWork(OBJDATAWORK_75), NULL, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE, 75);
    StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE);
    StageTask__SetAnimatorPriority(work, SPRITE_PRIORITY_1);
    SailObject_SetAnimSpeed(work, FLOAT_TO_FX32(1.0));

    work->position.x = FLOAT_TO_FX32(38.0);
    work->position.y = FLOAT_TO_FX32(38.0);

    work->state = SailStylusPrompt_State_Active;

    work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
}

void SailStylusPrompt_State_Active(StageTask *work)
{
    SailManager *manager     = SailManager__GetWork();
    SailManager *sailManager = SailManager__GetWork();
    UNUSED(sailManager);

    StageTask *player        = SailManager__GetWork()->sailPlayer;
    SailPlayer *playerWorker = GetStageTaskWorker(player, SailPlayer);

    if ((player->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
    {
        work->userTimer++;
        if (work->userTimer == 2)
        {
            work->displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
            work->position.x = FX32_FROM_WHOLE(playerWorker->field_1DC) + FLOAT_TO_FX32(128.0);
            work->position.y = FLOAT_TO_FX32(140.0);
        }

        if (work->userTimer == 10)
        {
            StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_MOVING);
            work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            work->shakeTimer = FLOAT_TO_FX32(4.0);
        }

        if (work->userTimer >= 14 && work->userTimer < 28)
            work->velocity.y = ObjSpdUpSet(work->velocity.y, -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(10.0));

        if (work->userTimer == 28)
            work->velocity.y = FLOAT_TO_FX32(0.0);

        if (work->userTimer == 30)
            StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE);

        if (work->userTimer == 68)
        {
            work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
            work->userTimer = 0;
        }
    }
    else
    {
        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->userTimer  = 0;
        work->velocity.y = FLOAT_TO_FX32(0.0);

        if (StageTask__GetAnimID(work) != SAILSTYLUSPROMPT_ANI_STYLUS_IDLE)
            StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE);
    }

    if ((manager->flags & SAILMANAGER_FLAG_2000) != 0)
        DestroyStageTask(work);
}

void CreateSailStylusPrompt2(void)
{
    SailManager *manager = SailManager__GetWork();
    UNUSED(manager);

    StageTask *work = CreateStageTaskEx_(TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(1));

    // NOTE: should this be using 'OBJDATAWORK_74'? would it not make more sense to use 'OBJDATAWORK_75'?
    if (GetObjectDataWork(OBJDATAWORK_74)->fileData == NULL)
    {
        void *memory                                = ReadFileFromBundle("bb/sb.bb", BUNDLE_SB_FILE_RESOURCES_BB_SB_SB_STYLUS_PROMPT_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
        GetObjectDataWork(OBJDATAWORK_75)->fileData = memory;
    }

    ObjObjectAction2dBACLoad(work, NULL, NULL, GetObjectDataWork(OBJDATAWORK_75), NULL, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE, 75);
    StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE);
    StageTask__SetAnimatorPriority(work, SPRITE_PRIORITY_1);
    SailObject_SetAnimSpeed(work, FLOAT_TO_FX32(1.0));

    work->position.x = FLOAT_TO_FX32(38.0);
    work->position.y = FLOAT_TO_FX32(38.0);

    work->state = SailStylusPrompt2_State_Active;

    work->userTimer = 0;
    work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
}

void SailStylusPrompt2_State_Active(StageTask *work)
{
    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    SailManager *sailManager         = SailManager__GetWork();
    UNUSED(voyageManager);
    UNUSED(sailManager);

    work->userTimer++;
    if (work->userTimer == 1)
    {
        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->velocity.x = FLOAT_TO_FX32(0.0);
        work->velocity.y = FLOAT_TO_FX32(0.0);

        if (StageTask__GetAnimID(work) != SAILSTYLUSPROMPT_ANI_STYLUS_IDLE)
            StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE);
    }

    if (work->userTimer == 16)
    {
        work->displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
        work->position.x = FLOAT_TO_FX32(32.0);
        work->position.y = FLOAT_TO_FX32(140.0);
    }

    if (work->userTimer == 24)
    {
        StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_MOVING);
        work->displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        work->shakeTimer = FLOAT_TO_FX32(4.0);
    }

    if (work->userTimer >= 28 && work->userTimer < 60)
    {
        work->velocity.x = ObjSpdUpSet(work->velocity.x, FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(8.0));
        work->velocity.y = ObjSpdUpSet(work->velocity.y, -FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(2.0));
    }

    if (work->userTimer == 60)
    {
        work->velocity.x = 0;
        work->velocity.y = 0;
    }

    if (work->userTimer == 68)
        StageTask__SetAnimation(work, SAILSTYLUSPROMPT_ANI_STYLUS_IDLE);

    if (work->userTimer == 80)
    {
        work->displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->userTimer = 0;
    }

    if ((manager->flags & SAILMANAGER_FLAG_2000) != 0)
        DestroyStageTask(work);
}