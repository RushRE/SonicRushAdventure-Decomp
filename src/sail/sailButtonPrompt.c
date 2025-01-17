#include <sail/sailButtonPrompt.h>
#include <sail/sailManager.h>
#include <sail/sailHUD.h>
#include <game/file/binaryBundle.h>
#include <game/object/objectManager.h>

// resources
#include <resources/bb/sb.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SailObject__SetAnimSpeed(StageTask *work, fx32 speed);

// --------------------
// FUNCTION DECLS
// --------------------

static void CreateSailButtonPromptIcon(u16 anim, fx32 posX);
static void SailButtonPromptIcon_State_Active(StageTask *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailButtonPrompts(void)
{
    CreateSailButtonPromptIcon(8, FLOAT_TO_FX32(96.0));  // L
    CreateSailButtonPromptIcon(9, FLOAT_TO_FX32(160.0));  // R
    CreateSailButtonPromptIcon(11, FLOAT_TO_FX32(136.0)); // <-
    CreateSailButtonPromptIcon(12, FLOAT_TO_FX32(184.0)); // ->
}

void CreateSailButtonPromptIcon(u16 anim, fx32 posX)
{
    SailManager *manager = SailManager__GetWork();
    UNUSED(manager);

    StageTask *work = CreateStageTaskEx_(TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(1));

    if (GetObjectDataWork(OBJDATAWORK_74)->fileData == NULL)
    {
        void *memory                                = ReadFileFromBundle("bb/sb.bb", BUNDLE_SB_FILE_RESOURCES_BB_SB_FILE_25_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
        GetObjectDataWork(OBJDATAWORK_74)->fileData = memory;
    }

    ObjObjectAction2dBACLoad(work, NULL, NULL, GetObjectDataWork(OBJDATAWORK_74), NULL, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(work, 0, 1050);
    StageTask__SetAnimation(work, anim);
    StageTask__SetAnimatorPriority(work, 1);
    SailObject__SetAnimSpeed(work, FLOAT_TO_FX32(1.0));

    work->position.x = posX;
    work->position.y = FLOAT_TO_FX32(38.0);

    work->state = SailButtonPromptIcon_State_Active;

    work->displayFlag |= DISPLAY_FLAG_NO_ANIMATE_CB;
    work->displayFlag |= DISPLAY_FLAG_NO_DRAW;
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
        work->displayFlag &= ~DISPLAY_FLAG_NO_ANIMATE_CB;
        work->displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
        SailHUD__Func_2174BA4(FALSE);

        if ((player->userFlag & 1) != 0)
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
