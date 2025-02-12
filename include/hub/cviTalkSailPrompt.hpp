#ifndef RUSH_CVITALKSAILPROMPT_HPP
#define RUSH_CVITALKSAILPROMPT_HPP

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>

// --------------------
// STRUCTS
// --------------------

class CViTalkSailPrompt
{

public:
    // --------------------
    // ENUM
    // --------------------

    enum Type
    {
        TYPE_0,
        TYPE_1,
        TYPE_2,
        TYPE_3,
        TYPE_4,
        TYPE_5,
    };

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
    void InitPromptWindowBackgroundVRAM();
    void InitPromptTextBackgroundVRAM();

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
    static void SetPromptWindowBackgroundVisible(BOOL enabled);
    static void SetPromptTextBackgroundVisible(BOOL enabled);
    static BOOL CheckTrainingDisabled();
    static BOOL IsFirstTimeUsingShip(u16 a1);
    static s32 ShipTypeFromPromptType(u16 a1);
};

#endif // RUSH_CVITALKSAILPROMPT_HPP