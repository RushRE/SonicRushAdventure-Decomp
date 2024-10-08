#include <nitro.h>

#include <nnsys/g2d/g2d_Font.h>
#include <nnsys/g2d/load/g2d_NFT_load.h>
#include <nnsys/g2d/fmt/g2d_Font_data.h>
#include <nnsys/g2d/g2d_config.h>

// --------------------
// FUNCTIONS
// --------------------

static u16 GetGlyphIndex(const NNSG2dFontCodeMap *pMap, u16 c)
{
    u16 index = NNS_G2D_GLYPH_INDEX_NOT_FOUND;

    switch (pMap->mappingMethod)
    {
        case NNS_G2D_MAPMETHOD_DIRECT: {
            u16 offset = pMap->mapInfo[0];
            index      = (u16)(c - pMap->ccodeBegin + offset);
        }
        break;

        case NNS_G2D_MAPMETHOD_TABLE: {
            const int table_index = c - pMap->ccodeBegin;

            index = pMap->mapInfo[table_index];
        }
        break;

        case NNS_G2D_MAPMETHOD_SCAN: {
            const NNSG2dCMapInfoScan *const ws = (NNSG2dCMapInfoScan *)(pMap->mapInfo);
            const NNSG2dCMapScanEntry *st      = &(ws->entries[0]);
            const NNSG2dCMapScanEntry *ed      = &(ws->entries[ws->num - 1]);

            while (st <= ed)
            {
                const NNSG2dCMapScanEntry *md = st + (ed - st) / 2;

                if (md->ccode < c)
                {
                    st = md + 1;
                }
                else if (c < md->ccode)
                {
                    ed = md - 1;
                }
                else
                {
                    index = md->index;
                    break;
                }
            }
        }
        break;

        default:
            break;
    }

    return index;
}

#ifdef NNS_G2D_FONT_USE_OLD_RESOURCE
static inline const NNSG2dCharWidths *GetCharWidthsFromIndex(int widthsSize, const NNSG2dFontWidth *const pWidth, int idx)
{
    return (NNSG2dCharWidths *)((u32)(pWidth->widthTable) + (idx - pWidth->indexBegin) * widthsSize);
}
#else
static inline const NNSG2dCharWidths *GetCharWidthsFromIndex(const NNSG2dFontWidth *const pWidth, int idx)
{
    return (NNSG2dCharWidths *)(pWidth->widthTable) + (idx - pWidth->indexBegin);
}
#endif

#ifdef NNS_G2D_FONT_USE_OLD_RESOURCE
#define NNS_G2D_DEFINE_FONT_INIT_PART_FOR_OLD                                                                                                                                      \
    pFont->isOldVer   = (u16)(result - TRUE);                                                                                                                                      \
    pFont->widthsSize = (u16)(pFont->isOldVer ? sizeof(NNSG2dCharWidthsOld) : sizeof(NNSG2dCharWidths));
#else
#define NNS_G2D_DEFINE_FONT_INIT_PART_FOR_OLD
#endif

void NNS_G2dFontInitAuto(NNSG2dFont *pFont, void *pNftrFile)
{
    const static NNSiG2dSplitCharCallback spliterTable[] = { NNSi_G2dSplitCharUTF8, NNSi_G2dSplitCharUTF16, NNSi_G2dSplitCharShiftJIS, NNSi_G2dSplitChar1Byte };
    NNSG2dFontEncoding encoding;
    BOOL result;

    result   = NNSi_G2dGetUnpackedFont(pNftrFile, &(pFont->pRes));
    encoding = (NNSG2dFontEncoding)pFont->pRes->encoding;

    NNS_G2D_DEFINE_FONT_INIT_PART_FOR_OLD
    pFont->cbCharSpliter = spliterTable[encoding];
}

#define NNS_G2D_DEFINE_FONT_INIT(name, enc, spliter)                                                                                                                               \
    void NNS_G2dFontInit##name(NNSG2dFont *pFont, void *pNftrFile)                                                                                                                 \
    {                                                                                                                                                                              \
        BOOL result;                                                                                                                                                               \
                                                                                                                                                                                   \
        result = NNSi_G2dGetUnpackedFont(pNftrFile, &(pFont->pRes));                                                                                                               \
                                                                                                                                                                                   \
        NNS_G2D_DEFINE_FONT_INIT_PART_FOR_OLD                                                                                                                                      \
        pFont->cbCharSpliter = NNSi_G2dSplitChar##spliter;                                                                                                                         \
    }

NNS_G2D_DEFINE_FONT_INIT(UTF8, UTF8, UTF8)
NNS_G2D_DEFINE_FONT_INIT(UTF16, UTF16, UTF16)
NNS_G2D_DEFINE_FONT_INIT(ShiftJIS, SJIS, ShiftJIS)
NNS_G2D_DEFINE_FONT_INIT(CP1252, CP1252, 1Byte)

u16 NNS_G2dFontFindGlyphIndex(const NNSG2dFont *pFont, u16 c)
{
    const NNSG2dFontCodeMap *pMap;

    pMap = pFont->pRes->pMap;

    while (pMap != NULL)
    {
        if ((pMap->ccodeBegin <= c) && (c <= pMap->ccodeEnd))
        {
            return GetGlyphIndex(pMap, c);
        }

        pMap = pMap->pNext;
    }

    return NNS_G2D_GLYPH_INDEX_NOT_FOUND;
}

const NNSG2dCharWidths *NNS_G2dFontGetCharWidthsFromIndex(const NNSG2dFont *pFont, u16 idx)
{
    const NNSG2dFontWidth *pWidth;

    pWidth = pFont->pRes->pWidth;

    while (pWidth != NULL)
    {
        if ((pWidth->indexBegin <= idx) && (idx <= pWidth->indexEnd))
        {
#ifdef NNS_G2D_FONT_USE_OLD_RESOURCE
            return GetCharWidthsFromIndex(pFont->widthsSize, pWidth, idx);
#else
            return GetCharWidthsFromIndex(pWidth, idx);
#endif
        }

        pWidth = pWidth->pNext;
    }

    return &(pFont->pRes->defaultWidth);
}

int NNSi_G2dFontGetStringWidth(const NNSG2dFont *pFont, int hSpace, const void *str, const void **pPos)
{
    int width       = 0;
    const void *pos = str;
    u16 c;
    NNSiG2dSplitCharCallback getNextChar;

    getNextChar = NNSi_G2dFontGetSpliter(pFont);

    while ((c = getNextChar((const void **)&pos)) != 0)
    {
        if (c == '\n')
        {
            break;
        }

        width += NNS_G2dFontGetCharWidth(pFont, c) + hSpace;
    }

    if (pPos != NULL)
    {
        *pPos = (c == '\n') ? pos : NULL;
    }
    if (width > 0)
    {
        width -= hSpace;
    }
    return width;
}

int NNSi_G2dFontGetTextHeight(const NNSG2dFont *pFont, int vSpace, const void *txt)
{
    const void *pos     = txt;
    int lines           = 1;
    NNSG2dTextRect rect = { 0, 0 };
    u16 c;
    NNSiG2dSplitCharCallback getNextChar;

    getNextChar = NNSi_G2dFontGetSpliter(pFont);

    while ((c = getNextChar((const void **)&pos)) != 0)
    {
        if (c == '\n')
        {
            lines++;
        }
    }

    return lines * (NNS_G2dFontGetLineFeed(pFont) + vSpace) - vSpace;
}

int NNSi_G2dFontGetTextWidth(const NNSG2dFont *pFont, int hSpace, const void *txt)
{
    int width = 0;

    while (txt != NULL)
    {
        const int line_width = NNSi_G2dFontGetStringWidth(pFont, hSpace, txt, &txt);
        if (line_width > width)
        {
            width = line_width;
        }
    }

    return width;
}

NNSG2dTextRect NNSi_G2dFontGetTextRect(const NNSG2dFont *pFont, int hSpace, int vSpace, const void *txt)
{
    int lines           = 1;
    NNSG2dTextRect rect = { 0, 0 };

    while (txt != NULL)
    {
        const int width = NNSi_G2dFontGetStringWidth(pFont, hSpace, txt, &txt);
        if (width > rect.width)
        {
            rect.width = width;
        }
        lines++;
    }

    rect.height = ((lines - 1) * (NNS_G2dFontGetLineFeed(pFont) + vSpace) - vSpace);

    return rect;
}