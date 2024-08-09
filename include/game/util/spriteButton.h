#ifndef RUSH2_SPRITE_BUTTON_H
#define RUSH2_SPRITE_BUTTON_H

#include <global.h>
#include <game/system/task.h>
#include <game/input/touchField.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

enum SpriteButtonActiveButtons_
{
    SPRITE_BUTTON_ACTIVEBUTTON_NONE = 0,

    SPRITE_BUTTON_ACTIVEBUTTON_YES = 1 << 0,
    SPRITE_BUTTON_ACTIVEBUTTON_NO  = 1 << 1,

    SPRITE_BUTTON_ACTIVEBUTTON_YES_NO = SPRITE_BUTTON_ACTIVEBUTTON_YES | SPRITE_BUTTON_ACTIVEBUTTON_NO,
};
typedef u32 SpriteButtonActiveButtons;

enum SpriteButtonState_
{
    SPRITE_BUTTON_STATE_IDLE,
    SPRITE_BUTTON_STATE_HOVERED,
    SPRITE_BUTTON_STATE_SELECTED,
};
typedef u16 SpriteButtonState;

enum FileList_BundleNL
{
    BUNDLE_NL_FILE_FILE_0_BAC,
    BUNDLE_NL_FILE_FILE_1_BAC,
    BUNDLE_NL_FILE_FILE_2_BAC,
    BUNDLE_NL_FILE_FILE_3_BAC,
    BUNDLE_NL_FILE_FILE_4_BAC,
    BUNDLE_NL_FILE_FILE_5_BAC,
    BUNDLE_NL_FILE_FILE_6_BAC,
    BUNDLE_NL_FILE_FILE_7_BAC,
    BUNDLE_NL_FILE_FILE_8_BAC,
    BUNDLE_NL_FILE_FILE_9_BAC,
    BUNDLE_NL_FILE_FILE_10_BAC,
    BUNDLE_NL_FILE_FILE_11_BAC,
    BUNDLE_NL_FILE_FILE_12_BAC,
    BUNDLE_NL_FILE_FILE_13_BAC
};

// --------------------
// STRUCTS
// --------------------

typedef struct SpriteButtonConfig_
{
    BOOL useEngineB;
    TouchField *touchField;
    VRAMPixelKey vramPixels[2];
    u16 paletteRow[3];
    SpriteButtonActiveButtons activeButtons;
    SpritePriority oamPriority;
    SpriteOrder oamOrder;
} SpriteButtonConfig;

typedef struct SpriteButtonAnimator_
{
    AnimatorSprite animator;
    TouchArea touchArea;
    u16 paletteRow[3];
    u16 animID;
} SpriteButtonAnimator;

typedef struct SpriteButton_
{
    SpriteButtonConfig config;
    SpriteButtonAnimator animators[2];
    BOOL destroyRequested;
    TouchField *touchFieldPtr;
    TouchField touchField;
    BOOL allocatedButtonSprite;
    u32 selectedButton;
} SpriteButton;

// --------------------
// FUNCTIONS
// --------------------

// Assets
void LoadSpriteButtonCursorSprite(void);
void ReleaseSpriteButtonCursorSprite(void);
void *GetSpriteButtonCursorSprite(void);

void LoadSpriteButtonYesNoButtonSprite(s32 language);
void ReleaseSpriteButtonYesNoButtonSprite(void);
void *GetSpriteButtonYesNoButtonSprite(void);

void LoadSpriteButtonTouchpadSprite(void);
void ReleaseSpriteButtonTouchpadSprite(void);
void *GetSpriteButtonTouchpadSprite(void);

// SpriteButton
void InitSpriteButtonConfig(SpriteButtonConfig *config, BOOL useEngineB, SpriteButtonActiveButtons activeButtons);
void CreateSpriteButton(SpriteButtonConfig *config);
void DestroySpriteButton(void);
s32 GetSelectedSpriteButton(void);
void SetSpriteButtonPosition(SpriteButtonAnimator *button, s16 x, s16 y);
size_t GetSpriteButtonSpriteAllocSize(void *spriteFile, u16 animID);
void SetSpriteButtonState(SpriteButtonAnimator *button, SpriteButtonState state);
SpriteButton *GetSpriteButtonWork(void);

#endif // RUSH2_SPRITE_BUTTON_H