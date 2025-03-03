
#ifndef RUSH_FONTFILE_H
#define RUSH_FONTFILE_H

#include <global.h>
#include <game/graphics/unknown2056570.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// TYPES
// --------------------

struct FontWindow_;

// --------------------
// STRUCTS
// --------------------

typedef struct FontHeader_
{
    u32 signature;
    u8 pixelWidth;
    u8 pixelHeight;
    u16 characterCount;
    u16 block3Count;
    u16 singleCharacterSize;
    u32 charInfoBlockOffset;
    u32 xAdvanceBlockOffset;
    u32 block3Offset;
    u32 charDataBlockOffset;
    u32 charDataBlockSize;
} FontHeader;

typedef struct FontFile_
{
    u32 mode;
    FSFileID fileID;
    FSFile file;
    void *fontFilePtr;
    void *charInfoPtr;
    u8 *charWidthPtr;
    void *block3Ptr;
    s16 curCharID3;
    u16 curCharID1;
    s16 curCharID4;
    u16 curCharID2;
    void *compressedPixelsPtr;
    void *curPixelData;
    void *field_74;
    void *storedPixelData;
    void *charDataPtr;
    u32 fileSize;
    void *fileBuffer;
    void *headerPtr;
} FontFile;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontFile__Init(FontFile *work);
NOT_DECOMPILED void FontFile__InitFromPath(FontFile *work, const char *filePath, s32 mode);
NOT_DECOMPILED void FontFile__InitFromHeader(FontFile *work, void *filePtr);
NOT_DECOMPILED void FontFile__Release(FontFile *work);
NOT_DECOMPILED s32 FontFile__GetPixelWidth(FontFile *work);
NOT_DECOMPILED s32 FontFile__GetPixelHeight(FontFile *work);
NOT_DECOMPILED s32 FontFile__GetPixelWidth2(FontFile *work);
NOT_DECOMPILED void *FontFile__GetPixels(FontFile *work, u32 character);
NOT_DECOMPILED void FontFile__GetCharXAdvance(FontFile *work, u32 character);
NOT_DECOMPILED void FontFile__ReadCharBlock(FontFile *work, u32 character, FSFile *file, void *compressedPixels);
NOT_DECOMPILED void *FontFile__GetPixels0(FontFile *work, u32 character);
NOT_DECOMPILED void *FontFile__GetPixels1(FontFile *work, u32 character);
NOT_DECOMPILED void *FontFile__GetPixels2(FontFile *work, u32 character);
NOT_DECOMPILED void FontFile__GetFileSizeFromID(FSFile *file, FSFileID *fileID, u32 *size);
NOT_DECOMPILED void FontFile__ReadHeaderFromFile(FSFile *file, void *bytes);
NOT_DECOMPILED void FontFile__LoadXAdvanceBlock(FontFile *work);
NOT_DECOMPILED void FontFile__LoadBlock3(FontFile *work);
NOT_DECOMPILED void FontFile__LoadCharDataBlock(FontFile *work);
NOT_DECOMPILED u32 FontFile__GetFileSize(void *filePtr, int mode);
NOT_DECOMPILED void FontFile__InitFromBuffer(FontFile *work, void *filePtr);
NOT_DECOMPILED void FontFile__Func_2052B7C(FontFile *work, u16 character, s32 a3, Unknown2056570 *unknown, u16 a5, s16 a6, s16 a7, s32 a8, s16 a9, s32 a10, s32 a11);
NOT_DECOMPILED void FontFile__Func_2052DD0(FontFile *work, u16 character, s32 a3, Unknown2056570 *unknown, s16 a5, s32 a6, s32 a7, s32 a8, s32 a9);
NOT_DECOMPILED void FontFile__Func_2052F38(void);
NOT_DECOMPILED void FontFile__Func_2053010(FontFile *work, s32 a2, s32 a3, Unknown2056570 *unknown, u16 a5, s16 a6, u16 a7, s32 a8, u16 a9, void *a10, char *a1, ...);
NOT_DECOMPILED void FontFile__Func_20530D8(void);
NOT_DECOMPILED void FontFile__Func_2053140(void);
NOT_DECOMPILED void FontFile__Func_20534F8(void);
NOT_DECOMPILED void FontFile__GetTextHeight(FontFile *work, s32 height, u16 *text);
NOT_DECOMPILED void FontFile__GetLineLength(FontFile *work, s32 height, u16 *text);
NOT_DECOMPILED void FontFile__GetTextWidth(FontFile *work, s32 height, u16 *text);

#ifdef __cplusplus
}
#endif

#endif // RUSH_FONTFILE_H
