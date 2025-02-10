#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <hub/cviEvtCmn.hpp>

// resources
#include <resources/bb/vi_msg/vi_msg_eng.h>
#include <resources/narc/vi_msg_ctrl_lz7.h>

// --------------------
// VARIABLES
// --------------------

static const ViTalkPurchaseMsgConfig ovl05_021721EC = {
    .fileID        = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF,
    .interactionID = 9,
};

static const ViTalkPurchaseMsgConfig ovl05_021721E8 = { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 6 };

static const ViTalkPurchaseMsgConfig decorationTalkConfig[] = {
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 0 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 2 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 4 },
};

FORCE_INCLUDE_ARRAY(ViTalkPurchaseMsgConfig, ovl05_021721F0, 3,
                    {
                        { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .interactionID = 0 },
                        { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .interactionID = 1 },
                        { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .interactionID = 2 },
                    })

static const OptionsMessageConfig optionsMessageConfig = { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_OP_MCF, .msgTextID = { 0, 1, 2, 3, 4, 5, 0 } };

static const ViTalkPurchaseMsgConfig ovl05_02172218[] = {
    { .fileID = CVIEVTCMN_RESOURCE_NONE, .interactionID = CVIEVTCMN_RESOURCE_NONE },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 1 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 3 }, { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 5 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 7 },
};

static const ViTalkPurchaseMsgConfig ovl05_0217222C[] = {
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 0 },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 2 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 4 },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 6 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 8 },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 10 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 12 }, { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 14 },
};

static const AnnounceConfig announcementConfig[] = {
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 5 },         { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 9 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 13 },        { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 17 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 21 },        { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DECO_MPC, .sequence = 8 },          { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 25 },        { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DECO_MPC, .sequence = 12 },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DECO_MPC, .sequence = 16 },         { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    { .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },       { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_MISSION_BASE_MPC, .sequence = 9 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_MISSION_BASE_MPC, .sequence = 10 }, { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 9 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 9 },           { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 14 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 14 },          { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 19 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 19 },          { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 24 },
    { .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 24 },
};

static const NpcMsgInfo npcTalkConfig[] = {
    { .msgCtrlFile = CVIEVTCMN_RESOURCE_NONE, .msgTextID1 = CVIEVTCMN_RESOURCE_NONE, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .msgTextID1 = 0, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .msgTextID1 = 2, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .msgTextID1 = 4, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .msgTextID1 = 6, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .msgTextID1 = 8, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .msgTextID1 = 3, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .msgTextID1 = 4, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = CVIEVTCMN_RESOURCE_NONE, .msgTextID1 = CVIEVTCMN_RESOURCE_NONE, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF, .msgTextID1 = 10, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_CRP_MCF, .msgTextID1 = 9, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = CVIEVTCMN_RESOURCE_NONE, .msgTextID1 = CVIEVTCMN_RESOURCE_NONE, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_CRP_MCF, .msgTextID1 = 15, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .msgTextID1 = 1, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_RAC_MCF, .msgTextID1 = 25, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .msgTextID1 = 10, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .msgTextID1 = 3, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = CVIEVTCMN_RESOURCE_NONE, .msgTextID1 = CVIEVTCMN_RESOURCE_NONE, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF, .msgTextID1 = 16, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF, .msgTextID1 = 19, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF, .msgTextID1 = 22, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_ADV_MCF, .msgTextID1 = 18, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = CVIEVTCMN_RESOURCE_NONE, .msgTextID1 = CVIEVTCMN_RESOURCE_NONE, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = CVIEVTCMN_RESOURCE_NONE, .msgTextID1 = CVIEVTCMN_RESOURCE_NONE, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_ADV_MCF, .msgTextID1 = 12, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .msgTextID1 = 5, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_CRP_MCF, .msgTextID1 = 12, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_ADV_MCF, .msgTextID1 = 15, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF, .msgTextID1 = 13, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF, .msgTextID1 = 25, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 1, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 3, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 5, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 7, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 9, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 11, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 13, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .msgTextID1 = 15, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .msgTextID1 = 7, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
    { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_TAILS_MCF, .msgTextID1 = 7, .msgTextID2 = CVIEVTCMN_RESOURCE_NONE, .msgTextID3 = CVIEVTCMN_RESOURCE_NONE },
};

// --------------------
// FUNCTIONS
// --------------------

const NpcMsgInfo *HubConfig__GetNpcMessageInfo(s32 id)
{
    return &npcTalkConfig[id];
}

const ViTalkPurchaseMsgConfig *HubConfig__Func_2152B1C(s32 id)
{
    return &ovl05_02172218[id];
}

const ViTalkPurchaseMsgConfig *HubConfig__Func_2152B2C(void)
{
    return &ovl05_021721EC;
}

const ViTalkPurchaseMsgConfig *HubConfig__Func_2152B38(s32 id)
{
    return &decorationTalkConfig[id];
}

const ViTalkPurchaseMsgConfig *HubConfig__Func_2152B48(s32 id)
{
    return &ovl05_0217222C[id];
}

const ViTalkPurchaseMsgConfig *HubConfig__Func_2152B58(void)
{
    return &ovl05_021721E8;
}

const AnnounceConfig *HubConfig__GetAnnounceConfig(s32 id)
{
    return &announcementConfig[id];
}

const OptionsMessageConfig *HubConfig__GetOptionsMessageInfo(void)
{
    return &optionsMessageConfig;
}