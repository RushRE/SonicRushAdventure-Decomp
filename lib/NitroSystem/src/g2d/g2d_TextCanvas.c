#include <nitro.h>
#include <string.h>

#undef NNS_G2D_UNICODE
#include <nnsys/g2d/g2d_TextCanvas.h>

// --------------------
// FUNCTIONS
// --------------------

void NNSi_G2dTextCanvasDrawString(const NNSG2dTextCanvas *pTxn, int x, int y, int cl, const void *str, const void **pPos)
{
    const void *pos;
    int linefeed;
    int charSpace;
    const NNSG2dFont *pFont;
    u16 c;
    NNSiG2dSplitCharCallback getNextChar;

    charSpace   = pTxn->hSpace;
    linefeed    = NNS_G2dFontGetLineFeed(pTxn->pFont) + pTxn->vSpace;
    pFont       = pTxn->pFont;
    pos         = str;
    getNextChar = NNSi_G2dFontGetSpliter(pFont);

    while ((c = getNextChar((const void **)&pos)) != 0)
    {
        if (c == '\n')
        {
            break;
        }

        // 1character rendering
        x += NNS_G2dCharCanvasDrawChar(pTxn->pCanvas, pFont, x, y, cl, c);
        x += charSpace;
    }

    if (pPos != NULL)
    {
        *pPos = (c == '\n') ? pos : NULL;
    }
}

void NNSi_G2dTextCanvasDrawTextAlign(const NNSG2dTextCanvas *pTxn, int x, int y, int areaWidth, int cl, u32 flags, const void *txt)
{
    const void *str;
    int linefeed;
    int charSpace;
    const NNSG2dFont *pFont;

    int py;

    charSpace = pTxn->hSpace;
    linefeed  = NNS_G2dFontGetLineFeed(pTxn->pFont) + pTxn->vSpace;
    pFont     = pTxn->pFont;
    str       = txt;

    py = y;

    while (str != NULL)
    {
        int px = x;

        if (flags & NNS_G2D_HORIZONTALALIGN_RIGHT)
        {
            int width = NNS_G2dTextCanvasGetStringWidth(pTxn, str, NULL);
            px += areaWidth - width;
        }
        else if (flags & NNS_G2D_HORIZONTALALIGN_CENTER)
        {
            int width = NNS_G2dTextCanvasGetStringWidth(pTxn, str, NULL);
            px += (areaWidth + 1) / 2 - (width + 1) / 2;
        }

        NNSi_G2dTextCanvasDrawString(pTxn, px, py, cl, str, &str);
        py += linefeed;
    }
}

void NNSi_G2dTextCanvasDrawText(const NNSG2dTextCanvas *pTxn, int x, int y, int cl, u32 flags, const void *txt)
{
    NNSG2dTextRect area;

    // Look for the upper left coordinate
    {
        area = NNS_G2dTextCanvasGetTextRect(pTxn, txt);

        if (flags & NNS_G2D_HORIZONTALORIGIN_CENTER)
        {
            x -= (area.width + 1) / 2;
        }
        else if (flags & NNS_G2D_HORIZONTALORIGIN_RIGHT)
        {
            x -= area.width;
        }

        if (flags & NNS_G2D_VERTICALORIGIN_MIDDLE)
        {
            y -= (area.height + 1) / 2;
        }
        else if (flags & NNS_G2D_VERTICALORIGIN_BOTTOM)
        {
            y -= area.height;
        }
    }

    NNSi_G2dTextCanvasDrawTextAlign(pTxn, x, y, area.width, cl, flags, txt);
}

void NNSi_G2dTextCanvasDrawTextRect(const NNSG2dTextCanvas *pTxn, int x, int y, int w, int h, int cl, u32 flags, const void *txt)
{

    {
        if (flags & NNS_G2D_VERTICALALIGN_BOTTOM)
        {
            int height = NNS_G2dTextCanvasGetTextHeight(pTxn, txt);
            y += h - height;
        }
        else if (flags & NNS_G2D_VERTICALALIGN_MIDDLE)
        {
            int height = NNS_G2dTextCanvasGetTextHeight(pTxn, txt);
            y += (h + 1) / 2 - (height + 1) / 2;
        }
    }

    NNSi_G2dTextCanvasDrawTextAlign(pTxn, x, y, w, cl, flags, txt);
}

void NNSi_G2dTextCanvasDrawTaggedText(const NNSG2dTextCanvas *pTxn, int x, int y, int cl, const void *txt, NNSG2dTagCallback cbFunc, void *cbParam)
{
    const void *pos;
    int linefeed;
    int charSpace;
    const NNSG2dFont *pFont;
    NNSG2dTagCallbackInfo cbInfo;
    u16 c;
    NNSiG2dSplitCharCallback getNextChar;

    int px = x;
    int py = y;

    cbInfo.txn     = *pTxn;
    cbInfo.cbParam = cbParam;

    charSpace   = cbInfo.txn.hSpace;
    pFont       = cbInfo.txn.pFont;
    linefeed    = NNS_G2dFontGetLineFeed(pFont) + cbInfo.txn.vSpace;
    pos         = txt;
    getNextChar = NNSi_G2dFontGetSpliter(pFont);

    while ((c = getNextChar((const void **)&pos)) != 0)
    {
        if (c < ' ')
        {
            if (c == '\n')
            {
                px = x;
                py += linefeed;
            }
            else
            {
                cbInfo.str = (const NNSG2dChar *)pos;
                cbInfo.x   = px;
                cbInfo.y   = py;
                cbInfo.clr = cl;

                cbFunc(c, &cbInfo);

                pos = (const void *)cbInfo.str;
                px  = cbInfo.x;
                py  = cbInfo.y;
                cl  = cbInfo.clr;

                pFont     = cbInfo.txn.pFont;
                charSpace = cbInfo.txn.hSpace;
                linefeed  = NNS_G2dFontGetLineFeed(pFont) + cbInfo.txn.vSpace;
            }

            continue;
        }
        else
        {
            px += NNS_G2dCharCanvasDrawChar(cbInfo.txn.pCanvas, cbInfo.txn.pFont, px, py, cl, c);
            px += charSpace;
        }
    }
}
