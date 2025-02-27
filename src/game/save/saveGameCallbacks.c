#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/system/sysEvent.h>
#include <game/file/cardBackup.h>
#include <game/graphics/renderCore.h>
#include <seaMap/seaMapManager.h>
#include <game/text/charUtils.h>

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

void SaveGame__ClearCallback_Common(SaveGame *save, SaveBlockFlags blockFlags)
{
    s32 i;

    if ((blockFlags & SAVE_BLOCK_FLAG_ONLINE_PROFILE) != 0)
    {
        DWC_CreateUserData(&save->onlineProfile.userData, 'A3YJ');

        for (i = 0; i < SAVEGAME_MAX_FRIEND_COUNT; i++)
        {
            DWC_DeleteBuddyFriendData(&save->onlineProfile.friendList[i]);
        }
    }

    if ((blockFlags & SAVE_BLOCK_FLAG_STAGE) != 0)
    {
        for (i = 0; i < SAVE_MATERIAL_COUNT; i++)
        {
            save->stage.materialCount[i] = SAVEGAME_MATERIAL_NONE;
        }

        for (i = 0; i < STAGE_HIDDEN_ISLAND_R1; i++)
        {
            // save->stage.stageRecords[DIFFICULTY_EASY][i].score = 0;
            save->stage.stageRecords[DIFFICULTY_EASY][i].rank = SAVE_STAGE_RANK_C;

            // save->stage.stageRecords[DIFFICULTY_NORMAL][i].score = 0;
            save->stage.stageRecords[DIFFICULTY_NORMAL][i & 0xFFFFFFFF].rank = SAVE_STAGE_RANK_C;
        }
    }

    if ((blockFlags & SAVE_BLOCK_FLAG_SYSTEM) != 0)
    {
        OSOwnerInfo ownerInfo;
        OS_GetOwnerInfo(&ownerInfo);

        if (ownerInfo.nickNameLength == 0)
        {
#if defined(RUSH_JAPAN)
            // BUG: the japanese ROM inccorrectly used a length of 4 characters for the default "SONIC" string,
            // this was corrected in later releases to use the proper length of 5 characters
            SaveGame__SetPlayerName(&save->system.name, L"SONIC", 4);
#else
            SaveGame__SetPlayerName(&save->system.name, L"SONIC", 5);
#endif
        }
        else if (ownerInfo.nickNameLength >= SAVEGAME_MAX_NAME_LEN + 1)
        {
            SaveGame__SetPlayerName(&save->system.name, ownerInfo.nickName, SAVEGAME_MAX_NAME_LEN - 1);
            save->system.name.text[SAVEGAME_MAX_NAME_LEN - 1] = UNICODE_CHAR('…', 0x2026);
        }
        else
        {
            SaveGame__SetPlayerName(&save->system.name, ownerInfo.nickName, ownerInfo.nickNameLength);
        }
    }
}

void SaveGame__SaveCallback_OnlineProfile(SaveGame *save, SaveBlockFlags blockFlags)
{
    if ((blockFlags & SAVE_BLOCK_FLAG_ONLINE_PROFILE) != 0 && DWC_CheckHasProfile(&save->onlineProfile.userData))
    {
        if (DWC_CheckDirtyFlag(&save->onlineProfile.userData))
            DWC_ClearDirtyFlag(&save->onlineProfile.userData);
    }
}

void SaveGame__LoadCallback_Unknown(SaveGame *save, SaveBlockFlags blockFlags)
{
    UNUSED(save);
    UNUSED(blockFlags);

    // Nothing to do.
}

#include <nitro/codereset.h>