#include <game/util/spriteButton.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/renderCore.h>

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
    cursorSprite = ReadFileFromBundle("/bb/nl.bb", BUNDLE_NL_FILE_FILE_0_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
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
    static u16 fileIDForLanguage[] = { BUNDLE_NL_FILE_FILE_2_BAC, BUNDLE_NL_FILE_FILE_3_BAC, BUNDLE_NL_FILE_FILE_4_BAC, BUNDLE_NL_FILE_FILE_5_BAC,
                                       BUNDLE_NL_FILE_FILE_6_BAC, BUNDLE_NL_FILE_FILE_7_BAC, BUNDLE_NL_FILE_FILE_0_BAC };

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
    touchpadSprite = ReadFileFromBundle("/bb/nl.bb", BUNDLE_NL_FILE_FILE_8_BAC, BINARYBUNDLE_AUTO_ALLOC_HEAD);
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