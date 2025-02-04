
#ifndef RUSH_FONTDMACONTROL_H
#define RUSH_FONTDMACONTROL_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct FontDMAControl_
{
    u32 flags;
    u8 useEngineB;
    u8 bgID;
    u8 dmaID;
    void *dataPtr2;
    void *dataPtr1;
} FontDMAControl;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontDMAControl__Init(FontDMAControl *work);
NOT_DECOMPILED void FontDMAControl__InitWithParams(FontDMAControl *work, u8 useEngineB, u8 bgID, u32 flags);
NOT_DECOMPILED void FontDMAControl__Release(FontDMAControl *work);
NOT_DECOMPILED void FontDMAControl__Func_2051BE8(FontDMAControl *work, u8 useEngineB, u8 bgID);
NOT_DECOMPILED void FontDMAControl__Func_2051BF4(FontDMAControl *work, s32 id);
NOT_DECOMPILED void FontDMAControl__Func_2051C90(FontDMAControl *work);
NOT_DECOMPILED void FontDMAControl__PrepareSwapBuffer(FontDMAControl *work);
NOT_DECOMPILED void FontDMAControl__Func_2051CD8(FontDMAControl *work, int a2, int a3, u16 a4);
NOT_DECOMPILED void FontDMAControl__Func_2051D60(FontDMAControl *work, int a2, int a3, u16 a4);
NOT_DECOMPILED void FontDMAControl__Func_2051DF0(FontDMAControl *work, int a2, int a3, int a4, u16 a5);
NOT_DECOMPILED void FontDMAControl__Func_2051EB4(FontDMAControl *work, int a2, int a3, u16 a4);
NOT_DECOMPILED void FontDMAControl__Func_2051F68(FontDMAControl *work, int a2, int a3, int a4, int a5, int a6, unsigned int a7, int a8, unsigned int a9, int a10);
NOT_DECOMPILED void FontDMAControl__Func_20520B0(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10);
NOT_DECOMPILED void FontDMAControl__Func_2052174(u8 a1, int a2);

#ifdef __cplusplus
}
#endif

#endif // RUSH_FONTDMACONTROL_H
