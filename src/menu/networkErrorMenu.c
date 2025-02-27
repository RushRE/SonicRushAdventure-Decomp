#include <menu/networkErrorMenu.h>
#include <menu/connectionStatusIcon.h>
#include <network/networkHandler.h>
#include <game/game/gameState.h>
#include <game/file/bundleFileUnknown.h>
#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/system/sysEvent.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/save/corruptSaveWarning.h>
#include <game/save/saveGame.h>
#include <game/util/advancePrompt.h>
#include <game/graphics/background.h>

// resources
#include <resources/bb/dmwf_lang.h>
#include <resources/bb/dmwf_lang/dmwf_lang_eng.h>
#include <resources/narc/dmwf_error_lz7.h>

// --------------------
// MACROS
// --------------------

#define GET_ERROR_CODE(...) -(__VA_ARGS__)

// --------------------
// ENUMS
// --------------------

// error code helpers
enum
{
    DWC_ECODE_SEQ_AUTH     = (-20000),
    DWC_ECODE_SEQ_INTERNET = (-50000),
};

// --------------------
// FUNCTION DECLS
// --------------------

void CreateNetworkErrorMenu(BOOL isDownloadPlayEnd);
void NetworkErrorMenu_Destructor(Task *task);
void NetworkErrorMenu_Main(void);
u16 GetNetworkErrorMenuErrorMessage(void);

// --------------------
// FUNCTIONS
// --------------------

void InitNetworkErrorMenu(void)
{
    CreateNetworkErrorMenu(FALSE);
}

void InitDownloadPlayEndScreen(void)
{
    CreateNetworkErrorMenu(TRUE);
}

void CreateNetworkErrorMenu(BOOL isDownloadPlayEnd)
{
    Task *task;
    NetworkErrorMenu *work;
    s32 i;

#ifndef RUSH_CONTEST
    if (!gameState.displayDWCErrorCode || gameState.displayDWCErrorCode == TRUE && GetMatchManagerStatus() != MATCHMANAGER_STATUS_SERVER_UPDATED)
    {
        RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
        RenderCore_DisableSoftReset(FALSE);
    }

    if (gameState.displayDWCErrorCode == TRUE && !SaveGame__Func_2060458())
    {
        RequestNewSysEventChange(SYSEVENT_CORRUPT_SAVE_WARNING);
        NextSysEvent();
    }
    else
#endif

    {
        SetupDisplayForCorruptSaveWarning();

        task = TaskCreate(NetworkErrorMenu_Main, NetworkErrorMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(1), NetworkErrorMenu);

        work = TaskGetWork(task, NetworkErrorMenu);
        TaskInitWork16(work);

        FSRequestArchive("/narc/dmwf_error_lz7.narc", &work->archiveDmwfError, TRUE);

        void *bgBaseDown   = FileUnknown__GetAOUFile(work->archiveDmwfError, ARCHIVE_DMWF_ERROR_LZ7_FILE_DMWL_ERROR_BASE_DOWN_BBG);
        void *bgBaseUpMark = FileUnknown__GetAOUFile(work->archiveDmwfError, ARCHIVE_DMWF_ERROR_LZ7_FILE_DMWL_ERROR_BASE_UP_MARK_BBG);
        void *bgBaseUp     = FileUnknown__GetAOUFile(work->archiveDmwfError, GetGameLanguage() + ARCHIVE_DMWF_ERROR_LZ7_FILE_DMWL_ERROR_BASE_UP_JPN_BBG);

        VRAMPixelKey vramPixels    = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A]);
        VRAMPaletteKey vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[GRAPHICS_ENGINE_A]);

        Background background;
        InitBackgroundEx(&background, bgBaseDown, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_0, PALETTE_MODE_SPRITE, vramPalette, PIXEL_MODE_SPRITE, vramPixels,
                         MAPPINGS_MODE_TEXT_256x256_A, 0, 30, 0, 0, 32, 24);
        DrawBackground(&background);
        if (!isDownloadPlayEnd)
        {
            InitBackgroundEx(&background, bgBaseUpMark, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_1, PALETTE_MODE_SPRITE, vramPalette, PIXEL_MODE_SPRITE, vramPixels,
                             MAPPINGS_MODE_TEXT_256x256_A, 0, 31, 0, 0, 32, 0x11u);
            DrawBackground(&background);
            InitBackgroundEx(&background, bgBaseUp, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_1, PALETTE_MODE_SPRITE, vramPalette, PIXEL_MODE_SPRITE, vramPixels,
                             MAPPINGS_MODE_TEXT_256x256_A, 0, 31, 0, 17, 32, 7u);
            DrawBackground(&background);
        }
        InitBackgroundEx(&background, bgBaseDown, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_B, BACKGROUND_0, PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[GRAPHICS_ENGINE_B]), PIXEL_MODE_SPRITE, VRAMKEY_TO_ADDR(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B]),
                         MAPPINGS_MODE_TEXT_256x256_B, 0, 29, 0, 0, 32, 24);
        DrawBackground(&background);

#ifdef RUSH_CONTEST
        void *bgMessage;

        if (isDownloadPlayEnd)
        {
            void *bgEndBaseDown = FileUnknown__GetAOUFile(work->archiveDmwfError, ARCHIVE_DMWF_ERROR_LZ7_FILE_DMWL_END_BASE_DOWN_PL_BBG);

            InitBackgroundEx(&background, bgEndBaseDown, BACKGROUND_FLAG_DISABLE_PIXELS | BACKGROUND_FLAG_DISABLE_MAPPINGS | BACKGROUND_FLAG_LOAD_PALETTE, GRAPHICS_ENGINE_A,
                             BACKGROUND_0, PALETTE_MODE_SPRITE, vramPixels, PIXEL_MODE_SPRITE, vramPalette, MAPPINGS_MODE_, MAPPINGS_MODE_TEXT_256x256_A, 30, 0, 0,
                             BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
            DrawBackground(&background);

            InitBackgroundEx(&background, bgEndBaseDown, BACKGROUND_FLAG_DISABLE_PIXELS | BACKGROUND_FLAG_DISABLE_MAPPINGS | BACKGROUND_FLAG_LOAD_PALETTE, GRAPHICS_ENGINE_B,
                             BACKGROUND_0, PALETTE_MODE_SPRITE, vramPixels, PIXEL_MODE_SPRITE, vramPalette, MAPPINGS_MODE_TEXT_256x256_B, 0, 29, 0, 0, BG_DISPLAY_FULL_WIDTH,
                             BG_DISPLAY_SINGLE_HEIGHT);
            DrawBackground(&background);

            bgMessage = FileUnknown__GetAOUFile(work->archiveDmwfError, GetGameLanguage() + ARCHIVE_DMWF_ERROR_LZ7_FILE_DMWL_END_DL_JPN_BBG);
        }
        else
        {
            bgMessage = FileUnknown__GetAOUFile(work->archiveDmwfError, GetGameLanguage() + ARCHIVE_DMWF_ERROR_LZ7_FILE_DMWL_ERROR_DL_JPN_BBG);
        }

        InitBackgroundEx(&background, bgMessage, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_B, BACKGROUND_1, PALETTE_MODE_SPRITE, vramPixels, PIXEL_MODE_SPRITE, vramPalette,
                         MAPPINGS_MODE_TEXT_256x256_B, 0, 31, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
        DrawBackground(&background);
#else
        work->fontFile        = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
        work->archiveDmwfLang = BundleFileUnknown__LoadFileFromBundle("/bb/dmwf_lang.bb", BUNDLE_DMWF_LANG_FILE_RESOURCES_BB_DMWF_LANG_DMWF_LANG_JPN_NARC + GetGameLanguage(),
                                                                      BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);

        FontWindow__Init(&work->fontWindow);
        FontWindow__LoadFromMemory(&work->fontWindow, work->fontFile, TRUE);

        void *mpc = FileUnknown__GetAOUFile(work->archiveDmwfLang, ARCHIVE_DMWF_LANG_ENG_FILE_DMWF_LANG_MPC);
        u16 windowStartX;
        u16 windowStartY;
        u16 windowSizeX;
        u16 windowSizeY;
        if (gameState.displayDWCErrorCode == FALSE)
        {
            windowStartX = PIXEL_TO_TILE(16);
            windowStartY = PIXEL_TO_TILE(72);
            windowSizeX  = PIXEL_TO_TILE(224);
            windowSizeY  = PIXEL_TO_TILE(48);
        }
        else
        {
            windowStartX = PIXEL_TO_TILE(16);
            windowStartY = PIXEL_TO_TILE(24);
            windowSizeX  = PIXEL_TO_TILE(224);
            windowSizeY  = PIXEL_TO_TILE(144);
        }

        FontAnimator__Init(&work->fontAnimator);
        FontAnimator__LoadFont2(&work->fontAnimator, &work->fontWindow, 8, windowStartX, windowStartY, windowSizeX, windowSizeY, GRAPHICS_ENGINE_B, SPRITE_PRIORITY_0,
                                SPRITE_ORDER_1, PALETTE_ROW_0);
        FontAnimator__LoadMPCFile(&work->fontAnimator, mpc);
        FontAnimator__SetCallbackType(&work->fontAnimator, 1);
        FontAnimator__LoadPaletteFunc2(&work->fontAnimator);
        FontAnimator__SetMsgSequence(&work->fontAnimator, GetNetworkErrorMenuErrorMessage());
        FontAnimator__InitStartPos(&work->fontAnimator, 1, 0);
        FontAnimator__LoadCharacters(&work->fontAnimator, 0);

        if (gameState.displayDWCErrorCode == TRUE)
        {
            FontAnimator__Init(&work->fontAnimator2);
            FontAnimator__LoadFont2(&work->fontAnimator2, &work->fontWindow, 8, PIXEL_TO_TILE(16), PIXEL_TO_TILE(160), PIXEL_TO_TILE(120), PIXEL_TO_TILE(16), GRAPHICS_ENGINE_B,
                                    SPRITE_PRIORITY_0, SPRITE_ORDER_1, PALETTE_ROW_0);
            FontAnimator__LoadMPCFile(&work->fontAnimator2, mpc);
            FontAnimator__SetCallbackType(&work->fontAnimator2, 1);
            FontAnimator__SetMsgSequence(&work->fontAnimator2, 55);
            FontAnimator__InitStartPos(&work->fontAnimator2, 2, 0);
            FontAnimator__LoadCharacters(&work->fontAnimator2, 0);

            s32 errorCode = -gameState.lastDWCError;
            if (-gameState.lastDWCError > 100000)
                errorCode = FX_ModS32(-gameState.lastDWCError, 100000);

            s32 digitPos = 10000;
            for (i = 0; i < 5; i++)
            {
                FontAnimator *fntAniDigit = &work->fntErrorCode[i];

                FontAnimator__Init(fntAniDigit);
                FontAnimator__LoadFont2(fntAniDigit, &work->fontWindow, 8, i + PIXEL_TO_TILE(152), PIXEL_TO_TILE(160), PIXEL_TO_TILE(16), PIXEL_TO_TILE(16), GRAPHICS_ENGINE_B,
                                        SPRITE_PRIORITY_0, SPRITE_ORDER_1, PALETTE_ROW_0);
                FontAnimator__LoadMPCFile(fntAniDigit, mpc);
                FontAnimator__SetCallbackType(fntAniDigit, 1);

                u16 digit = FX_DivS32(errorCode, digitPos);
                errorCode -= digit * digitPos;
                digitPos = FX_DivS32(digitPos, 10);
                FontAnimator__SetMsgSequence(fntAniDigit, digit + DMWF_MSGSEQ_ERRORCODE_DIGIT_0);
                FontAnimator__InitStartPos(fntAniDigit, 1, 0);
                FontAnimator__LoadCharacters(fntAniDigit, 0);
            }
        }
        FontWindowAnimator__Init(&work->fontWindowAnimator);
        FontWindowAnimator__Load1(&work->fontWindowAnimator, &work->fontWindow, 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG,
                                  windowStartX - PIXEL_TO_TILE(8), windowStartY - PIXEL_TO_TILE(16), windowSizeX + PIXEL_TO_TILE(16), windowSizeY + PIXEL_TO_TILE(32),
                                  GRAPHICS_ENGINE_B, BACKGROUND_1, PALETTE_ROW_3, 700, 0);
#endif

        AnimatorSprite__Init(&work->aniNextPrompt, FileUnknown__GetAOUFile(work->archiveDmwfError, ARCHIVE_DMWF_ERROR_LZ7_FILE_DMCMN_FIX_NEXT_BAC), 0,
                             ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, 4), PALETTE_MODE_SPRITE,
                             VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
        work->aniNextPrompt.cParam.palette = PALETTE_ROW_1;
        if (gameState.displayDWCErrorCode == FALSE)
        {
            work->aniNextPrompt.pos.x = 216;
            work->aniNextPrompt.pos.y = 104;
        }
        else
        {
            work->aniNextPrompt.pos.x = 216;
            work->aniNextPrompt.pos.y = 152;
        }
        AnimatorSprite__ProcessAnimationFast(&work->aniNextPrompt);
        work->disableNextPromptTimer = 60;

#ifndef RUSH_CONTEST
        LoadConnectionStatusIconAssets();
        CreateConnectionStatusIcon(CONNECTION_MODE_AUTO, GRAPHICS_ENGINE_B, PALETTE_ROW_2, SPRITE_PRIORITY_0, SPRITE_ORDER_1, 234, 22);
#endif

        GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1);
        GXS_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_OBJ);

        StartSamplingTouchInput(4);
    }
}

void NetworkErrorMenu_Destructor(Task *task)
{
    NetworkErrorMenu *work = TaskGetWork(task, NetworkErrorMenu);

    ((u16 *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
    ((u16 *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    StopSamplingTouchInput();

#ifndef RUSH_CONTEST
    FontAnimator__Release(&work->fontAnimator);

    if (gameState.displayDWCErrorCode == TRUE)
    {
        FontAnimator__Release(&work->fontAnimator2);

        for (s32 i = 0; i < 5; i++)
        {
            FontAnimator__Release(&work->fntErrorCode[i]);
        }
    }

    FontWindowAnimator__Release(&work->fontWindowAnimator);
    FontWindow__Release(&work->fontWindow);

    if (work->fontFile != NULL)
        HeapFree(HEAP_USER, work->fontFile);

    if (work->archiveDmwfLang != NULL)
        HeapFree(HEAP_USER, work->archiveDmwfLang);

    ReleaseConnectionStatusIconAssets();
#endif

    AnimatorSprite__Release(&work->aniNextPrompt);

    if (work->archiveDmwfError != NULL)
        HeapFree(HEAP_USER, work->archiveDmwfError);
}

void NetworkErrorMenu_Main(void)
{
    NetworkErrorMenu *work = TaskGetWorkCurrent(NetworkErrorMenu);

#ifdef RUSH_CONTEST
    UNUSED(work);
#else
    if (work->aniNextPrompt.animID == ADVANCEPROMPT_ANI_PROMPTING && ((padInput.btnPress & PAD_BUTTON_A) != 0 || IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags)))
    {
        DestroyCurrentTask();

        s32 nextEvent = 0; // SYSEVENT_VS_MENU
        switch (GetSysEventList()->prevEventID)
        {
            case SYSEVENT_19:
            case SYSEVENT_20:
            case SYSEVENT_21:
            case SYSEVENT_22:
            case SYSEVENT_24:
                nextEvent = 1; // SYSEVENT_24
                break;
        }
        RequestSysEventChange(nextEvent);
        NextSysEvent();
    }
    else
    {
        FontWindowAnimator__Draw(&work->fontWindowAnimator);
        FontAnimator__Draw(&work->fontAnimator);

        if (gameState.displayDWCErrorCode == TRUE && gameState.lastDWCError != DWC_ERROR_NONE)
        {
            FontAnimator__Draw(&work->fontAnimator2);

            for (s32 i = 0; i < 5; i++)
            {
                FontAnimator__Draw(&work->fntErrorCode[i]);
            }
        }

        FontWindow__PrepareSwapBuffer(&work->fontWindow);

        if (work->disableNextPromptTimer != 0)
        {
            work->disableNextPromptTimer--;
            if (work->disableNextPromptTimer == 0)
                AnimatorSprite__SetAnimation(&work->aniNextPrompt, ADVANCEPROMPT_ANI_PROMPTING);
        }

        AnimatorSprite__ProcessAnimationFast(&work->aniNextPrompt);
        AnimatorSprite__DrawFrame(&work->aniNextPrompt);
    }
#endif
}

u16 GetNetworkErrorMenuErrorMessage(void)
{
    if (!gameState.displayDWCErrorCode)
        return DMWF_MSGSEQ_COMMUNICATION_FAILED;

    s32 errorCode = -gameState.lastDWCError;

    if (errorCode == GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH + -100 + -1)
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH + -3000) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH + -3000 + -1000) - 1)
        return DMWF_MSGSEQ_EITHER_WIFI_IS_EXPERIENCING_TRAFFIC_OR_SERVICE_IS_DOWN;

    if (errorCode == GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH + -100 + -8))
        return DMWF_MSGSEQ_THIS_WIFI_CONNECTION_ID_HAS_BEEN_REMOVED_DUE_TO_INACTIVITY;

    if (errorCode == GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH + -100 + -10))
        return DMWF_MSGSEQ_WIFI_CONNECTION_SERVICE_HAS_BEEN_DISCONTINUED;

    if (errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -200) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -200 + -100) - 1)
        return DMWF_MSGSEQ_THE_ACCESS_POINT_IS_BUSY;

    if (errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -100) - 1)
        return DMWF_MSGSEQ_NO_ACCESS_POINT_IN_RANGE;

    if (errorCode == GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -100 + -3))
        return DMWF_MSGSEQ_UNABLE_TO_CONNECT_TO_WIFI_USB_CONNECTOR;

    if (errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -000) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -000 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -100) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -100 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -300) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -1000 + -300 + -100) - 1)
    {
        return DMWF_MSGSEQ_NO_COMPATIBLE_ACCESS_POINT_IN_RANGE;
    }

    if (errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -000) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -000 + -4) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -100) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -100 + -4) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -200) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -200 + -4) - 1)
    {
        return DMWF_MSGSEQ_UNABLE_TO_CONNECT_TO_THE_WIFI_CONNECTION;
    }

    if (errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_AUTH + -1000) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -000) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -000 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -100) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -100 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -200) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -200 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -300) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -2000 + -300 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -3000 + -000) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -3000 + -000 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -3000 + -100) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -3000 + -100 + -100) - 1
        || errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -3000 + -200) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_INTERNET + -3000 + -200 + -100) - 1)
    {
        return DMWF_MSGSEQ_UNABLE_TO_CONNECT_TO_WIFI;
    }

    if (errorCode == GET_ERROR_CODE(DWC_ECODE_SEQ_MATCH + DWC_ECODE_TYPE_NOT_FRIEND + DWC_ECODE_TYPE_DNS))
        return DMWF_MSGSEQ_THERE_IS_NO_RESPONCE;

    if (GetMatchManagerStatus() == MATCHMANAGER_STATUS_SERVER_UPDATED)
    {
        if (errorCode >= GET_ERROR_CODE(DWC_ECODE_SEQ_ADDINS + -1000) && errorCode <= GET_ERROR_CODE(DWC_ECODE_SEQ_ADDINS + -1000 + -1000) - 1)
            return DMWF_MSGSEQ_DOWNLOAD_FAILED;

        return DMWF_MSGSEQ_COMMUNICATION_ERROR;
    }

    return DMWF_MSGSEQ_COMMUNICATION_ERROR_YOU_HAVE_BEEN_DISCONNECTED;
}