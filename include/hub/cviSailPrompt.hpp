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

    s32 type;
    u16 selection;
    u16 selectionCount;
    u16 touchSelection;
    u32 timer;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    FontWindowMWControl fontWindowMWControl;
    AnimatorSprite aniCursor;
    void *archive;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void InitDisplay();
    void InitGraphics();
    void Release();
    void ResetDisplay();
    void ReleaseGraphics();

    u16 HandleTouchSelectionControl(BOOL usePush);
    void InitBackgroundVRAM();
    void InitBackground2VRAM();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 param);

private:
    static void CreatePrivate(s32 param);
    static void Main_Init(void);
    static void Main_OpeningWindow(void);
    static void Main_ShowingText(void);
    static void Main_SelectionActive(void);
    static void Main_MadeChoice(void);
    static void Main_ClosingWindow(void);
    static void Main_ApplyChoice(void);
    static void Destructor(Task *task);
    static void SetBackground2Visible(BOOL enabled);
    static void SetBackground3Visible(BOOL enabled);
    static BOOL CheckTrainingDisabled();
    static BOOL Func_21696F0(u16 a1);
    static s32 Func_2169754(u16 a1);
};

#endif // RUSH_CVISAILPROMPT_HPP