#ifndef RUSH_VSMENU_H
#define RUSH_VSMENU_H

#include <game/system/task.h>
#include <game/input/touchField.h>
#include <game/text/fontWindow.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void VSMenu__Create(void);
NOT_DECOMPILED void VSMenu__Func_21667F0(u16 a1);
NOT_DECOMPILED void VSMenu__SetNetworkMessageSequence(u16 seq);
NOT_DECOMPILED void VSMenu__CheckNetworkMessageMain(void);
NOT_DECOMPILED FontWindow *VSMenu__GetFontWindow(void);
NOT_DECOMPILED void VSMenu__Func_216685C(void);
NOT_DECOMPILED void VSMenu__Func_2166874(void);
NOT_DECOMPILED TouchField *VSMenu__GetUnknownTouchField(void);
NOT_DECOMPILED void VSMenu__SetTouchCallback(TouchAreaCallback callback, void *userData);
NOT_DECOMPILED TouchAreaResponseFlags VSMenu__GetUnknownTouchResponseFlags(void);
NOT_DECOMPILED void VSMenu__GetYesNoButton(void);
NOT_DECOMPILED void VSMenu__Destructor(Task *task);
NOT_DECOMPILED void VSMenu__ChangeEvent(void);
NOT_DECOMPILED void VSMenu__LoadAssets(void);
NOT_DECOMPILED void VSMenu__Destroy(void);
NOT_DECOMPILED void VSMenu__LoadMenuAssets(void);
NOT_DECOMPILED void VSMenu__ReleaseMenuAssets(void);

NOT_DECOMPILED void VSMenuHeader__Create(void);
NOT_DECOMPILED void VSMenuHeader__Destroy(void);

NOT_DECOMPILED void VSMenuBackButton__Create(void);
NOT_DECOMPILED void VSMenuBackButton__Destroy(void);

NOT_DECOMPILED void VSMenuBackground__Create(void);
NOT_DECOMPILED void VSMenuBackground__UpdateMain(void);
NOT_DECOMPILED void VSMenuBackground__UpdateSub(void);
NOT_DECOMPILED void VSMenuBackground__Destroy(void);

NOT_DECOMPILED void VSMenuNetworkMessage__Func_216718C(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Func_2167214(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Create(void);

NOT_DECOMPILED void VSMenu__InitFontWindow(void);
NOT_DECOMPILED void VSMenu__Func_2167458(void);
NOT_DECOMPILED void VSMenu__Func_2167464(void);
NOT_DECOMPILED void VSMenu__Func_21674C8(void);
NOT_DECOMPILED void VSMenuBackButton__TouchCallback(void);
NOT_DECOMPILED void VSMenu__Func_2167530(void);
NOT_DECOMPILED void VSMenu__Func_21675A0(void);
NOT_DECOMPILED void VSMenu__Func_21675D4(void);
NOT_DECOMPILED void VSMenu__Func_21675E4(void);
NOT_DECOMPILED void VSMenu__Main(void);
NOT_DECOMPILED void VSMenu__Main_216770C(void);
NOT_DECOMPILED void VSMenu__Func_2167860(void);
NOT_DECOMPILED void VSMenu__Main_2167950(void);
NOT_DECOMPILED void VSMenu__Main_GotoHubMenu(void);
NOT_DECOMPILED void VSMenu__Main_GotoVSMenu(void);
NOT_DECOMPILED void VSMenu__Main_2167A10(void);
NOT_DECOMPILED void VSMenu__Main_2167A40(void);
NOT_DECOMPILED void VSMenu__Main_2167A6C(void);
NOT_DECOMPILED void VSMenu__Main_2167B5C(void);
NOT_DECOMPILED void VSMenu__Main_2167C80(void);
NOT_DECOMPILED void VSMenu__Main_2167CD8(void);
NOT_DECOMPILED void VSMenu__Main_2167D34(void);
NOT_DECOMPILED void VSMenu__Main_2167D8C(void);
NOT_DECOMPILED void VSMenu__Main_2167E28(void);
NOT_DECOMPILED void VSMenu__Main_2167F4C(void);
NOT_DECOMPILED void VSMenu__Main_2167FAC(void);
NOT_DECOMPILED void VSMenu__Main_216800C(void);
NOT_DECOMPILED void VSMenu__Main_2168090(void);
NOT_DECOMPILED void VSMenu__Main_21680D8(void);
NOT_DECOMPILED void VSMenu__Main_2168120(void);
NOT_DECOMPILED void VSMenu__Main_21681C8(void);
NOT_DECOMPILED void VSMenu__Main_21681F4(void);
NOT_DECOMPILED void VSMenu__Main_2168290(void);
NOT_DECOMPILED void VSMenu__Main_2168350(void);
NOT_DECOMPILED void VSMenu__Main_2168388(void);
NOT_DECOMPILED void VSMenu__Main_2168424(void);
NOT_DECOMPILED void VSMenu__Main_2168470(void);
NOT_DECOMPILED void VSMenu__Main_21684A8(void);
NOT_DECOMPILED void VSMenu__Main_216851C(void);
NOT_DECOMPILED void VSMenu__Main_2168568(void);
NOT_DECOMPILED void VSMenu__Main_2168618(void);
NOT_DECOMPILED void VSMenu__Main_216865C(void);
NOT_DECOMPILED void VSMenu__Main_216869C(void);
NOT_DECOMPILED void VSMenu__Main_21686B0(void);
NOT_DECOMPILED void VSMenu__Main_21686EC(void);
NOT_DECOMPILED void VSMenu__Main_21687AC(void);
NOT_DECOMPILED void VSMenu__Main_216886C(void);
NOT_DECOMPILED void VSMenu__Main_21688A0(void);
NOT_DECOMPILED void VSMenu__Main_21688D4(void);
NOT_DECOMPILED void VSMenu__Main_21689C8(void);
NOT_DECOMPILED void VSMenu__Main_21689FC(void);
NOT_DECOMPILED void VSMenu__Main_2168A30(void);
NOT_DECOMPILED void VSMenu__Main_2168AFC(void);
NOT_DECOMPILED void VSMenu__Main_2168B84(void);
NOT_DECOMPILED void VSMenu__Main_2168BB4(void);
NOT_DECOMPILED void VSMenu__Main_2168C0C(void);
NOT_DECOMPILED void VSMenu__Main_2168C40(void);
NOT_DECOMPILED void VSMenu__Main_2168CDC(void);
NOT_DECOMPILED void VSMenu__Main_2168D1C(void);
NOT_DECOMPILED void VSMenu__Main_2168D30(void);
NOT_DECOMPILED void VSMenu__Main_2168D60(void);
NOT_DECOMPILED void VSMenu__Main_2168DA4(void);
NOT_DECOMPILED void VSMenu__Main_2168DD4(void);
NOT_DECOMPILED void VSMenu__Main_2168DF4(void);
NOT_DECOMPILED void VSMenu__Main_2168E38(void);
NOT_DECOMPILED void VSMenu__Main_2168E7C(void);
NOT_DECOMPILED void VSMenu__Main_2168EAC(void);
NOT_DECOMPILED void VSMenu__Main_2168F14(void);
NOT_DECOMPILED void VSMenu__Main_2168F30(void);
NOT_DECOMPILED void VSMenu__Main_2168F60(void);
NOT_DECOMPILED void VSMenu__Main_2168F8C(void);
NOT_DECOMPILED void VSMenu__Main_2168FB8(void);
NOT_DECOMPILED void VSMenu__Main_2168FE8(void);
NOT_DECOMPILED void VSMenu__Main_21690B4(void);
NOT_DECOMPILED void VSMenu__Main_21690F0(void);
NOT_DECOMPILED void VSMenu__Main_2169140(void);
NOT_DECOMPILED void VSMenu__Main_2169154(void);
NOT_DECOMPILED void VSMenu__Main_2169188(void);
NOT_DECOMPILED void VSMenu__Main_21691D8(void);
NOT_DECOMPILED void VSMenu__Main_21691F8(void);
NOT_DECOMPILED void VSMenu__Main_2169240(void);
NOT_DECOMPILED void VSMenu__Main_2169288(void);
NOT_DECOMPILED void VSMenu__Main_21692B8(void);
NOT_DECOMPILED void VSMenu__Main_21692F0(void);
NOT_DECOMPILED void VSMenu__Main_2169324(void);
NOT_DECOMPILED void VSMenu__Main_216935C(void);

NOT_DECOMPILED void VSMenuHeader__Main1(void);
NOT_DECOMPILED void VSMenuHeader__Main_2169408(void);
NOT_DECOMPILED void VSMenuHeader__Main_2169490(void);
NOT_DECOMPILED void VSMenuHeader__Main_21694DC(void);
NOT_DECOMPILED void VSMenuHeader__Main2(void);

NOT_DECOMPILED void VSMenuBackButton__Main1(void);
NOT_DECOMPILED void VSMenuBackButton__Main2(void);
NOT_DECOMPILED void VSMenuBackground__Main1(void);
NOT_DECOMPILED void VSMenuBackground__VBlankCallback(void);

NOT_DECOMPILED void VSMenuNetworkMessage__Main1(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Main_2169730(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Main_2169790(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Main_2169874(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Main_21698F4(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Main_21699D8(void);
NOT_DECOMPILED void VSMenuNetworkMessage__Main2(void);

#endif // RUSH_VSMENU_H