#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <hub/cviEvtCmn.hpp>

// resources
#include <resources/bb/vi_msg/vi_msg_eng.h>
#include <resources/narc/vi_msg_ctrl_lz7.h>

// --------------------
// VARIABLES
// --------------------

static const HubPurchaseMsgConfig radioTowerPurchaseMsgConfig = {
    .fileID        = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF,
    .interactionID = 9,
};

static const HubPurchaseMsgConfig infoPurchaseMsgConfig = { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 6 };

static const HubPurchaseMsgConfig decorationPurchaseMsgConfig[] = {
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 0 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 2 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_DECO_MCF, .interactionID = 4 },
};

// this appears to be an unused talk config for missions?
// these files point to the text for the "Please select a mission" & related text
FORCE_INCLUDE_ARRAY(HubPurchaseMsgConfig, missionMsgConfig, 3,
                    {
                        { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .interactionID = 0 },
                        { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .interactionID = 1 },
                        { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_MS_MCF, .interactionID = 2 },
                    })

static const HubOptionsMsgConfig optionsMsgConfig = { .msgCtrlFile = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_OP_MCF, .msgTextID = { 0, 1, 2, 3, 4, 5, 0 } };

static const HubPurchaseMsgConfig constructionPurchaseMsgConfig[] = {
    [SHIP_JET]       = { .fileID = CVIEVTCMN_RESOURCE_NONE, .interactionID = CVIEVTCMN_RESOURCE_NONE },
    [SHIP_BOAT]      = { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 1 },
    [SHIP_HOVER]     = { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 3 },
    [SHIP_SUBMARINE] = { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 5 },

    // this goes unused in the final game. There is no dialog when building the magma hurricane.
    [SHIP_DRILL] = { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_BUILD_MCF, .interactionID = 7 },
};

static const HubPurchaseMsgConfig shipUpgradePurchaseMsgConfig[] = {
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 0 },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 2 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 4 },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 6 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 8 },  { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 10 },
    { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 12 }, { .fileID = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_PUP_MCF, .interactionID = 14 },
};

static const HubAnnounceMsgConfig announcementMsgConfig[] = {
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_JET]              =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 5 },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_BOAT]             =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 9 },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_HOVER]            =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 13 },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_SUBMARINE]        =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 17 },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_DRILL]            =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 21 },
    /*[CVITALKANNOUNCE_TYPE_UNUSED5]                   =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED6]                   =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED7]                   =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED8]                   =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED9]                   =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_DECOR_1]                   =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DECO_MPC, .sequence = 8 },
    /*[CVITALKANNOUNCE_TYPE_UNUSED11]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_RADIO_TOWER]      =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_BUILD_MPC, .sequence = 25 },
    /*[CVITALKANNOUNCE_TYPE_DECOR_2]                   =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DECO_MPC, .sequence = 12 },
    /*[CVITALKANNOUNCE_TYPE_UNUSED14]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED15]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED16]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED17]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED18]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED19]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED20]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED21]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_DECOR_3]                   =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_DECO_MPC, .sequence = 16 },
    /*[CVITALKANNOUNCE_TYPE_UNUSED23]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED24]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED25]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNUSED26]                  =*/{ .mpcFile = CVIEVTCMN_RESOURCE_NONE, .sequence = CVIEVTCMN_RESOURCE_NONE },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_MEDAL]            =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_MISSION_BASE_MPC, .sequence = 9 },
    /*[CVITALKANNOUNCE_TYPE_UNLOCKED_NEW_MISSION]      =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_MISSION_BASE_MPC, .sequence = 10 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_JET_LEVEL1]       =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 9 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_JET_LEVEL2]       =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 9 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_BOAT_LEVEL1]      =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 14 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_BOAT_LEVEL2]      =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 14 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_HOVER_LEVEL1]     =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 19 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_HOVER_LEVEL2]     =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 19 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_SUBMARINE_LEVEL1] =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 24 },
    /*[CVITALKANNOUNCE_TYPE_UPGRADED_SUBMARINE_LEVEL2] =*/{ .mpcFile = ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_EV_PUP_MPC, .sequence = 24 },
};

static const HubNpcMsgConfig npcMsgConfig[] = {
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

const HubNpcMsgConfig *HubConfig__GetNpcMsgConfig(s32 id)
{
    return &npcMsgConfig[id];
}

const HubPurchaseMsgConfig *HubConfig__GetConstructionPurchaseMsgConfig(s32 id)
{
    return &constructionPurchaseMsgConfig[id];
}

const HubPurchaseMsgConfig *HubConfig__GetRadioTowerPurchaseMsgConfig(void)
{
    return &radioTowerPurchaseMsgConfig;
}

const HubPurchaseMsgConfig *HubConfig__GetDecorationPurchaseMsgConfig(s32 id)
{
    return &decorationPurchaseMsgConfig[id];
}

const HubPurchaseMsgConfig *HubConfig__GetShipUpgradePurchaseMsgConfig(s32 id)
{
    return &shipUpgradePurchaseMsgConfig[id];
}

const HubPurchaseMsgConfig *HubConfig__GetInfoPurchaseMsgConfig(void)
{
    return &infoPurchaseMsgConfig;
}

const HubAnnounceMsgConfig *HubConfig__GetAnnounceMsgConfig(s32 id)
{
    return &announcementMsgConfig[id];
}

const HubOptionsMsgConfig *HubConfig__GetOptionsMsgConfig(void)
{
    return &optionsMsgConfig;
}