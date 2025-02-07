#include <hub/cviDockNpcGroup.hpp>
#include <hub/cviDockNpcTalk.hpp>
#include <hub/cviSailPrompt.hpp>
#include <hub/cviTalkPurchase.hpp>
#include <hub/cviTalkMissionList.hpp>
#include <hub/npcUnknown.hpp>
#include <hub/npcCutsceneViewer.hpp>
#include <hub/npcRetry.hpp>

// --------------------
// VARIABLES
// --------------------

// TODO: figure how to get these to compile
CViDockNpcGroupTalk ViDockNpcGroup__talkAction = { 32 };

DockNpcGroupFunc ViDockNpcGroup__talkActionTable[11] = {
    CreateViDockNpcTalk,           ViSailPrompt__Create, ViTalkPurchase__Create,    ViTalkMissionList__Create, CViDockNpcGroup::Func_2168764, ViTalkMissionList__Func_216B6B4,
    CViDockNpcGroup::Func_2168798, NpcUnknown__Create,   NpcCutsceneViewer__Create, NpcRetry::Create,          CViDockNpcGroup::Func_216879C,
};