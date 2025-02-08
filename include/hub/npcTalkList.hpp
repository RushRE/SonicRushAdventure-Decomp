#ifndef RUSH_NPCUNKNOWN_HPP
#define RUSH_NPCUNKNOWN_HPP

#include <game/text/fontWindow.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>
#include <game/text/messageController.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

typedef struct NpcTalkListConfigEntry_
{
    u8 flags;
    u8 field_1;
    u16 field_2;
    u16 sequence;
    u8 field_6;
    u8 field_7;
} NpcTalkListConfigEntry;

typedef struct NpcTalkListEntry_
{
    u16 flags;
    u16 id;
} NpcTalkListEntry;

typedef struct ViTalkListConfig
{
    FontWindow *fontWindow;
    void *mpcFile;
    NpcTalkListEntry *entryList;
    u16 entryCount;
    s16 selection;
    void *vi_fix_loc;
    void *vi_menu;
    void *vi_ms_ret;
    void *nl_cursor_ikari;
    u16 headerAnim;
    u16 field_22;
    u16 windowSizeX;
    u16 windowSizeY;
    u16 field_28;
    u16 field_2A;
} ViTalkListConfig;

typedef struct NpcTalkList_
{
    s32 timer;
    NpcTalkListEntry *entryList;
    u16 entryCount;
    u16 selection2;
    u16 selection;
    u16 field_E;
    s16 field_10;
    s16 field_12;
    u16 field_14;
    s16 field_16;
    ViTalkListConfig listState;
    s32 field_44;
    s32 field_48;
    s32 field_4C;
    FontWindow *fontFile;
    FontWindowAnimator fontWindowAnimator;
    FontWindowMWControl fontWindowMWControl;
    AnimatorSprite aniHeader;
    AnimatorSprite aniButtonUp;
    AnimatorSprite aniButtonDown;
    AnimatorSprite aniBackButton;
    AnimatorSprite aniCursor;
    MessageController msgController;
    void *vramPixels;
    u32 pixelSize;
    void *pixels;
    u16 *mappings;
    NpcTalkListConfigEntry *entries;
    s32 field_388;
    s32 field_38C;
    s32 field_390;
    s16 field_394;
    s16 field_396;
    s32 field_398;
    u16 *mappings2;
    u16 *mappings2_unknown2;
    u16 *field_3A4;
    u16 *mappings2_unknown;
    TouchField touchField;
    TouchArea touchArea1;
    TouchArea touchArea2;
    TouchArea touchArea3;
    s32 field_46C;
    s32 field_470;
    s32 field_474;
    void (*state)(struct NpcTalkList_ *work);
    s32 field_47C;
} NpcTalkList;

#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

// NpcTalkList
NOT_DECOMPILED void NpcUnknown__Func_216EDCC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216EDF8(NpcTalkList *work, ViTalkListConfig *config);
NOT_DECOMPILED void NpcUnknown__Func_216EE98(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216EEC0(NpcTalkList *work, s32 a2, s32 a3);
NOT_DECOMPILED void NpcUnknown__Func_216EF50(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216EF70(NpcTalkList *work);
NOT_DECOMPILED BOOL NpcUnknown__Func_216EF78(NpcTalkList *work);
NOT_DECOMPILED BOOL NpcUnknown__Func_216EF80(NpcTalkList *work);
NOT_DECOMPILED BOOL NpcUnknown__Func_216EF88(NpcTalkList *work);
NOT_DECOMPILED BOOL NpcUnknown__Func_216EFC0(NpcTalkList *work);
NOT_DECOMPILED s32 NpcUnknown__Func_216EFDC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216EFE4(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F4B8(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F5F4(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F6DC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F770(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F7DC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F7E0(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F8F8(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216F9AC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216FA40(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216FD34(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216FD94(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216FE98(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_216FFD8(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170074(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170224(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170278(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21702BC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21702E0(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170378(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21703AC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170448(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_217045C(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170530(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21705A0(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21705A4(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_217062C(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21706C0(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21706EC(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170740(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170794(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21707F0(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170810(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170830(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170860(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_21708D8(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_217092C(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170980(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170A10(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170B3C(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170EC8(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170F6C(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170FC0(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170FF4(NpcTalkList *work);
NOT_DECOMPILED void NpcUnknown__Func_2170FF8(NpcTalkList *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_NPCUNKNOWN_HPP