#ifndef RUSH_CVISAILPROMPT_HPP
#define RUSH_CVISAILPROMPT_HPP

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>

// --------------------
// STRUCTS
// --------------------

class CViSailPrompt
{

public:
    // --------------------
    // VARIABLES
    // --------------------
    s32 field_0;
    u16 selection;
    u16 selectionCount;
    u16 field_8;
    u16 field_A;
    s32 timer;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    FontWindowMWControl fontWindowMWControl;
    AnimatorSprite aniCursor;
    void *archive;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void ViSailPrompt__Create(s32 param);
NOT_DECOMPILED void ViSailPrompt__CreateInternal(s32 param);
NOT_DECOMPILED void ViSailPrompt__InitDisplay(CViSailPrompt *work);
NOT_DECOMPILED void ViSailPrompt__InitGraphics(CViSailPrompt *work);
NOT_DECOMPILED void ViSailPrompt__Release(CViSailPrompt *work);
NOT_DECOMPILED void ViSailPrompt__ResetDisplay(CViSailPrompt *work);
NOT_DECOMPILED void ViSailPrompt__ReleaseGraphics(CViSailPrompt *work);
NOT_DECOMPILED void ViSailPrompt__Main(void);
NOT_DECOMPILED void ViSailPrompt__Main_2168E40(void);
NOT_DECOMPILED void ViSailPrompt__Main_2168F4C(void);
NOT_DECOMPILED void ViSailPrompt__Main_21690CC(void);
NOT_DECOMPILED void ViSailPrompt__Main_216933C(void);
NOT_DECOMPILED void ViSailPrompt__Main_21693D0(void);
NOT_DECOMPILED void ViSailPrompt__Main_2169424(void);
NOT_DECOMPILED void ViSailPrompt__Destructor(Task *task);
NOT_DECOMPILED s32 ViSailPrompt__Func_21694F0(CViSailPrompt *work, BOOL usePull);
NOT_DECOMPILED void ViSailPrompt__Func_21695E4(BOOL enabled);
NOT_DECOMPILED void ViSailPrompt__Func_2169638(BOOL enabled);
NOT_DECOMPILED void ViSailPrompt__Func_216968C(CViSailPrompt *work);
NOT_DECOMPILED void ViSailPrompt__Func_21696AC(CViSailPrompt *work);
NOT_DECOMPILED BOOL ViSailPrompt__CheckTrainingDisabled();
NOT_DECOMPILED BOOL ViSailPrompt__Func_21696F0(s32 a1);
NOT_DECOMPILED s32 ViSailPrompt__Func_2169754(s32 a1);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVISAILPROMPT_HPP