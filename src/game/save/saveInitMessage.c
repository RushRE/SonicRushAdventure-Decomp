#include <game/save/saveInitMessage.h>
#include <game/system/allocator.h>
#include <game/system/system.h>
#include <game/system/sysEvent.h>
#include <game/graphics/renderCore.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>
#include <game/file/fileUnknown.h>
#include <game/game/gameState.h>
#include <game/input/padInput.h>

// resources
#include <resources/bb/dmwf_lang.h>
#include <resources/bb/dmwf_lang/cmn.h>
#include <resources/narc/dmbl_lz7.h>

// --------------------
// ENUMS
// --------------------

enum SaveInitMsgSequences
{
    SAVEINIT_MSGSEQ_REFORMATTING,
    SAVEINIT_MSGSEQ_DATA_IS_CORRUPT,
    SAVEINIT_MSGSEQ_LOADING,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SaveInitMessage_Destructor(Task *task);
static void SaveInitMessage_Main_PrepareOpenWindow(void);
static void SaveInitMessage_Main_OpeningWindow(void);
static void SaveInitMessage_Main_DisplayMessage(void);
static void SaveInitMessage_Main_PrepareCloseWindow(void);
static void SaveInitMessage_Main_ClosingWindow(void);
static void SaveInitMessage_Main_Finished(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateSaveInitMessage(SaveInitManager *parent, GameInitMessageTypes type)
{
    Task *task = TaskCreate(SaveInitMessage_Main_PrepareOpenWindow, SaveInitMessage_Destructor, TASK_FLAG_NONE, 0, 0x3000, TASK_GROUP(1), SaveInitMessage);
    // no null checks, this task is that important!!

    SaveInitMessage *work = TaskGetWork(task, SaveInitMessage);
    TaskInitWork16(work);
    work->parent = parent;

    FSRequestArchive("/narc/dmbl_lz7.narc", &work->dmblArchive, FALSE);
    work->fontPtr = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
    GetCompressedFileFromBundle("/bb/dmwf_lang.bb", BUNDLE_DMWF_LANG_FILE_RESOURCES_BB_DMWF_LANG_CMN_NARC, &work->dmwfLangArchive, FALSE);

    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fontPtr, 1);
    FontWindowAnimator__Init(&work->fontWindowAnimator);
    FontWindowAnimator__Load1(&work->fontWindowAnimator, &work->fontWindow, 0, 0, 2, 0, 7, 32, 10, 0, 0, 1, 1, 0);
    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont1(&work->fontAnimator, &work->fontWindow, 0, 1, 9, 30, 4, 0, 1, 0, 1);

    FontAnimator__LoadMPCFile(&work->fontAnimator, FileUnknown__GetAOUFile(work->dmblArchive, ARCHIVE_DMBL_LZ7_FILE_MSG_JPN_MPC + GetGameLanguage()));

    switch (type)
    {
        case GAMEINIT_MSG_REFORMATTING:
            FontAnimator__SetMsgSequence(&work->fontAnimator, SAVEINIT_MSGSEQ_REFORMATTING);
            break;

        case GAMEINIT_MSG_CORRUPTED:
            FontAnimator__SetMsgSequence(&work->fontAnimator, SAVEINIT_MSGSEQ_DATA_IS_CORRUPT);
            break;

        case GAMEINIT_MSG_LOADING:
            FontAnimator__SetMsgSequence(&work->fontAnimator, SAVEINIT_MSGSEQ_LOADING);
            break;
    }

    FontAnimator__SetDialog(&work->fontAnimator, 0);
    FontAnimator__InitStartPos(&work->fontAnimator, 1, 0);
    FontAnimator__LoadMappingsFunc(&work->fontAnimator);
    FontAnimator__LoadPaletteFunc(&work->fontAnimator);

    void *spriteFile = FileUnknown__GetAOUFile(work->dmwfLangArchive, ARCHIVE_CMN_FILE_DMWF_CMN_BAC);

    AnimatorSprite__Init(&work->aniSprite, spriteFile, 0, ANIMATOR_FLAG_DISABLE_LOOPING, 0, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(spriteFile)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniSprite.palette = 0;
    work->aniSprite.pos.x   = 128;
    work->aniSprite.pos.y   = 116;
}

void SaveInitMessage_Destructor(Task *task)
{
    SaveInitMessage *work = TaskGetWork(task, SaveInitMessage);

    AnimatorSprite__Release(&work->aniSprite);
    FontAnimator__Release(&work->fontAnimator);
    FontWindowAnimator__Release(&work->fontWindowAnimator);
    FontWindow__Release(&work->fontWindow);
    HeapFree(HEAP_USER, work->fontPtr);
    HeapFree(HEAP_USER, work->dmwfLangArchive);
    HeapFree(HEAP_USER, work->dmblArchive);
}

void SaveInitMessage_Main_PrepareOpenWindow(void)
{
    SaveInitMessage *work = TaskGetWorkCurrent(SaveInitMessage);

    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 1, 10, 10, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);

    SetCurrentTaskMainEvent(SaveInitMessage_Main_OpeningWindow);
}

void SaveInitMessage_Main_OpeningWindow(void)
{
    SaveInitMessage *work = TaskGetWorkCurrent(SaveInitMessage);

    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);
        FontAnimator__LoadCharacters(&work->fontAnimator, 0);

        work->parent->messageReady = TRUE;
        SetCurrentTaskMainEvent(SaveInitMessage_Main_DisplayMessage);
    }
}

void SaveInitMessage_Main_DisplayMessage(void)
{
    SaveInitMessage *work = TaskGetWorkCurrent(SaveInitMessage);

    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);
    AnimatorSprite__ProcessAnimationFast(&work->aniSprite);
    AnimatorSprite__DrawFrame(&work->aniSprite);

    if (work->parent->messageFinished)
        SetCurrentTaskMainEvent(SaveInitMessage_Main_PrepareCloseWindow);
}

void SaveInitMessage_Main_PrepareCloseWindow(void)
{
    SaveInitMessage *work = TaskGetWorkCurrent(SaveInitMessage);

    FontAnimator__ClearPixels(&work->fontAnimator);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 4, 10, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    SetCurrentTaskMainEvent(SaveInitMessage_Main_ClosingWindow);
}

void SaveInitMessage_Main_ClosingWindow(void)
{
    SaveInitMessage *work = TaskGetWorkCurrent(SaveInitMessage);

    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimator);
        SetCurrentTaskMainEvent(SaveInitMessage_Main_Finished);
    }
}

void SaveInitMessage_Main_Finished(void)
{
    SaveInitMessage *work = TaskGetWorkCurrent(SaveInitMessage);

    FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);

    work->parent->messageReady = FALSE;
    DestroyCurrentTask();
}
