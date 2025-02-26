
#ifndef RUSH_FONTWINDOW_H
#define RUSH_FONTWINDOW_H

#include <game/text/fontFile.h>
#include <game/text/fontDMAControl.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct FontWindow_
{
    FontFile font;
    void *fontFileData;
    const char *filePath;
    u16 dmaID;
    char field_96;
    char field_97;
    FontDMAControl dmaControl;
    void *archives[2];
} FontWindow;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontWindow__Init(FontWindow *work);
NOT_DECOMPILED void FontWindow__LoadFromMemory(FontWindow *work, void *fontData, BOOL loadWinSimple);
NOT_DECOMPILED void FontWindow__LoadFromFile(FontWindow *work, const char *path, u32 mode, BOOL loadWinSimple);
NOT_DECOMPILED void FontWindow__Load_mw_frame(FontWindow *work);
NOT_DECOMPILED void FontWindow__Release(FontWindow *work);
NOT_DECOMPILED void FontWindow__LoadFromFile2(FontWindow *work, const char *path, u32 mode);
NOT_DECOMPILED void FontWindow__Clear(FontWindow *work);
NOT_DECOMPILED void FontWindow__LoadWinSimple(FontWindow *window);
NOT_DECOMPILED void FontWindow__SetDMA(FontWindow *result, u16 id);
NOT_DECOMPILED void FontWindow__PrepareSwapBuffer(FontWindow *work);
NOT_DECOMPILED void *FontWindow__GetFont(FontWindow *result);
NOT_DECOMPILED FontDMAControl *FontWindow__Func_20582AC(FontWindow *work);
NOT_DECOMPILED void *FontWindow__GetFileFromArchive(FontWindow *work, u32 archiveID, u32 fileID);
NOT_DECOMPILED void *FontWindow__GetMWBackground(FontWindow *work, u32 fileID);
NOT_DECOMPILED void *FontWindow__GetMWPaletteAnimation(FontWindow *work, u32 id);

#ifdef __cplusplus
}
#endif

#endif // RUSH_FONTWINDOW_H
