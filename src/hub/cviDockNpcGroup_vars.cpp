#include <hub/cviDockNpcGroup.hpp>

// --------------------
// TEMP
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void CreateViDockNpcTalk(s32 param);
NOT_DECOMPILED void Task__OV05Unknown2168C48__Create(s32 param);
NOT_DECOMPILED void ViTalkPurchase__Create(s32 param);
NOT_DECOMPILED void ViTalkList__Create(s32 param);
NOT_DECOMPILED void ViTalkList__Func_216B6B4(s32 param);
NOT_DECOMPILED void NpcOptions__Create(s32 param);
NOT_DECOMPILED void NpcViking__Create(s32 param);
NOT_DECOMPILED void NpcMission__Create(s32 param);

#ifdef __cplusplus
}
#endif

// --------------------
// VARIABLES
// --------------------

// TODO: figure how to get these to compile
CViDockNpcGroupTalk ViDockNpcGroup__talkAction = { 32 };

DockNpcGroupFunc ViDockNpcGroup__talkActionTable[11] = {
    CreateViDockNpcTalk,           Task__OV05Unknown2168C48__Create, ViTalkPurchase__Create, ViTalkList__Create, CViDockNpcGroup::Func_2168764,
    ViTalkList__Func_216B6B4,      CViDockNpcGroup::Func_2168798,    NpcOptions__Create,     NpcViking__Create,  NpcMission__Create,
    CViDockNpcGroup::Func_216879C,
};