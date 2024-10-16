#include <game/util/spriteButton.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/renderCore.h>

// resources
#include <resources/bb/nl.h>

// --------------------
// VARIABLES
// --------------------

static void *touchpadSprite;
static void *cursorSprite;
static void *buttonSprite;

// --------------------
// FUNCTIONS
// --------------------

void LoadSpriteButtonCursorSprite(void)
{
    cursorSprite = ReadFileFromBundle("/bb/nl.bb", BUNDLE_NL_FILE_RESOURCES_BB_NL_CURSOR_TOUCH_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
}

void ReleaseSpriteButtonCursorSprite(void)
{
    HeapFree(HEAP_USER, cursorSprite);
    cursorSprite = NULL;
}

void *GetSpriteButtonCursorSprite(void)
{
    return cursorSprite;
}

void LoadSpriteButtonYesNoButtonSprite(s32 language)
{
    static u16 fileIDForLanguage[OS_LANGUAGE_CODE_MAX + 1] = {
        [OS_LANGUAGE_JAPANESE] = BUNDLE_NL_FILE_RESOURCES_BB_NL_SPR_BUTTON_JPN_BAC, [OS_LANGUAGE_ENGLISH] = BUNDLE_NL_FILE_RESOURCES_BB_NL_SPR_BUTTON_ENG_BAC,
        [OS_LANGUAGE_FRENCH] = BUNDLE_NL_FILE_RESOURCES_BB_NL_SPR_BUTTON_FRA_BAC,   [OS_LANGUAGE_GERMAN] = BUNDLE_NL_FILE_RESOURCES_BB_NL_SPR_BUTTON_DEU_BAC,
        [OS_LANGUAGE_ITALIAN] = BUNDLE_NL_FILE_RESOURCES_BB_NL_SPR_BUTTON_ITA_BAC,  [OS_LANGUAGE_SPANISH] = BUNDLE_NL_FILE_RESOURCES_BB_NL_SPR_BUTTON_SPA_BAC
    };

    buttonSprite = ReadFileFromBundle("/bb/nl.bb", fileIDForLanguage[language], BINARYBUNDLE_AUTO_ALLOC_HEAD);
}

void ReleaseSpriteButtonYesNoButtonSprite(void)
{
    HeapFree(HEAP_USER, buttonSprite);
    buttonSprite = NULL;
}

void *GetSpriteButtonYesNoButtonSprite(void)
{
    return buttonSprite;
}

void LoadSpriteButtonTouchpadSprite(void)
{
    touchpadSprite = ReadFileFromBundle("/bb/nl.bb", BUNDLE_NL_FILE_RESOURCES_BB_NL_TOUCHPAD_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
}

void ReleaseSpriteButtonTouchpadSprite(void)
{
    HeapFree(HEAP_USER, touchpadSprite);
    touchpadSprite = NULL;
}

void *GetSpriteButtonTouchpadSprite(void)
{
    return touchpadSprite;
}