#include <hub/cviMapIcon.hpp>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/graphics/drawReqTask.h>
#include <hub/hubConfig.h>
#include <hub/hubControl.hpp>

// resources
#include <resources/narc/vi_act_lz7.h>

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckTouchPushEnabled()
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_PUSH(touchInput.flags))
            return TRUE;
    }

    return FALSE;
}

// --------------------
// FUNCTIONS
// --------------------

CViMapIcon::CViMapIcon()
{
    this->sprIcon = NULL;

    MI_CpuClear32(&this->aniIconOutline, sizeof(this->aniCursor));
    MI_CpuClear32(&this->aniIconCenter, sizeof(this->aniCursor));
    MI_CpuClear32(&this->aniSonicMarker, sizeof(this->aniCursor));
    MI_CpuClear32(&this->aniCursor, sizeof(this->aniCursor));

    this->Release();
}

CViMapIcon::~CViMapIcon()
{
    this->Release();
}

void CViMapIcon::Init(BOOL useEngineB)
{
    this->Release();

    VRAMPaletteKey vramPalette = useEngineB == GRAPHICS_ENGINE_A ? VRAM_OBJ_PLTT : VRAM_DB_OBJ_PLTT;

    this->sprIcon = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_ICON_BAC);

    VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize3FromAnim(this->sprIcon, 0));
    AnimatorSprite__Init(&this->aniSonicMarker, this->sprIcon, 0, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_LOOPING,
                         useEngineB, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_2, SPRITE_ORDER_16);
    this->aniSonicMarker.cParam.palette = PALETTE_ROW_4;
    AnimatorSprite__ProcessAnimationFast(&this->aniSonicMarker);
    this->aniSonicMarker.flags &= ~(ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS);

    this->LoadIconConfig();

    vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize3FromAnim(this->sprIcon, 1));
    AnimatorSprite__Init(&this->aniIconOutline, this->sprIcon, 1, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS, useEngineB, PIXEL_MODE_SPRITE,
                         vramPixels, PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_2, SPRITE_ORDER_17);
    this->aniIconOutline.cParam.palette = PALETTE_ROW_5;
    this->aniIconOutline.colorCount     = 16;
    AnimatorSprite__ProcessAnimationFast(&this->aniIconOutline);
    this->aniIconOutline.flags &= ~(ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS);
    this->aniIconOutline.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize3FromAnim(this->sprIcon, 2));
    AnimatorSprite__Init(&this->aniIconCenter, this->sprIcon, 2, ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES, useEngineB, PIXEL_MODE_SPRITE, vramPixels,
                         PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_2, SPRITE_ORDER_18);
    this->aniIconCenter.cParam.palette = PALETTE_ROW_5;
    this->aniIconCenter.colorCount     = 16;
    AnimatorSprite__ProcessAnimationFast(&this->aniIconCenter);
    this->aniIconCenter.flags &= ~(ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS);
    this->aniIconCenter.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    vramPixels = VRAMSystem__AllocSpriteVram(useEngineB, Sprite__GetSpriteSize3FromAnim(this->sprIcon, 3));
    AnimatorSprite__Init(&this->aniCursor, this->sprIcon, 3, ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES, useEngineB, PIXEL_MODE_SPRITE, vramPixels,
                         PALETTE_MODE_SPRITE, vramPalette, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    this->aniCursor.cParam.palette = PALETTE_ROW_5;
    this->aniCursor.colorCount     = 16;
    AnimatorSprite__ProcessAnimationFast(&this->aniCursor);
    this->aniCursor.flags &= ~(ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS);
    this->aniCursor.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
}

void CViMapIcon::Release()
{
    AnimatorSprite__Release(&this->aniCursor);
    AnimatorSprite__Release(&this->aniIconCenter);
    AnimatorSprite__Release(&this->aniIconOutline);
    AnimatorSprite__Release(&this->aniSonicMarker);

    MI_CpuClear32(&this->aniIconCenter, sizeof(this->aniIconCenter));
    MI_CpuClear32(&this->aniIconOutline, sizeof(this->aniIconOutline));
    MI_CpuClear32(&this->aniSonicMarker, sizeof(this->aniSonicMarker));
    MI_CpuClear32(&this->aniCursor, sizeof(this->aniCursor));

    this->sprIcon         = NULL;
    this->worldPosition.x = 0;
    this->worldPosition.y = 0;
    MI_CpuClear32(this->iconList, sizeof(this->iconList));
    this->flags              = 0x00;
    this->mapArea            = MAPAREA_INVALID;
    this->prevMarkerPos.x    = 0;
    this->prevMarkerPos.y    = 0;
    this->markerMoveDuration = 0;
    this->markerMoveTimer    = 0;
}

void CViMapIcon::Configure(u8 id, BOOL enabled)
{
    if (enabled)
        this->flags |= (1 << id);
    else
        this->flags &= ~(1 << id);
}

void CViMapIcon::SetWorldPosition(u16 x, u16 y)
{
    this->worldPosition.x = x;
    this->worldPosition.y = y;
}

void CViMapIcon::GetIconPosition(MapArea mapArea, u16 *x, u16 *y)
{
    if (x != NULL)
        *x = this->iconList[mapArea].pos.x;

    if (y != NULL)
        *y = this->iconList[mapArea].pos.y;
}

void CViMapIcon::WarpToArea(MapArea mapArea)
{
    this->mapArea            = mapArea;
    this->prevMarkerPos.x    = 0;
    this->prevMarkerPos.y    = 0;
    this->markerMoveDuration = 0;
    this->markerMoveTimer    = 0;
}

void CViMapIcon::TravelToArea(MapArea mapArea)
{
    this->GetSonicMarkerPos(&this->prevMarkerPos.x, &this->prevMarkerPos.y);

    this->mapArea            = mapArea;
    this->markerMoveDuration = 32;
    this->markerMoveTimer    = 0;
}

MapArea CViMapIcon::GetCurrentArea()
{
    return this->mapArea;
}

void CViMapIcon::ProcessPlayerIcon()
{
    if (this->markerMoveTimer < this->markerMoveDuration)
    {
        this->markerMoveTimer++;
        if (this->markerMoveTimer == this->markerMoveDuration)
        {
            this->prevMarkerPos.x    = 0;
            this->prevMarkerPos.y    = 0;
            this->markerMoveDuration = 0;
            this->markerMoveTimer    = 0;
        }
    }
}

void CViMapIcon::Draw()
{
    if ((this->flags & (1 << CViMapIcon::FLAG_SHOW_PLAYER_ICON)) != 0)
    {
        u16 y;
        u16 x;
        this->GetSonicMarkerPos(&x, &y);
        this->DrawSonicMarker(x - this->worldPosition.x, y - this->worldPosition.y);
    }

    if ((this->flags & (1 << CViMapIcon::FLAG_SHOW_ISLAND_ICONS)) != 0)
    {
        for (s32 i = 0; i < (s32)ARRAY_COUNT(this->iconList); i++)
        {
            if ((this->iconList[i].flags & CViMapIcon::Icon::FLAG_ENABLED) != 0)
            {
                this->DrawIcon(this->iconList[i].pos.x - this->worldPosition.x, this->iconList[i].pos.y - this->worldPosition.y);
            }
        }
    }
}

MapArea CViMapIcon::GetAreaFromTouchInput()
{
    if (!CheckTouchPushEnabled() || !HubControl::TouchEnabled())
        return MAPAREA_INVALID;

    s32 i;
    u16 x;
    u16 y;
    MapArea area = MAPAREA_INVALID;

    x = touchInput.push.x;
    y = touchInput.push.y;
    x += this->worldPosition.x;
    y += this->worldPosition.y;
    for (i = 0; i < MAPAREA_COUNT; i++)
    {
        if ((this->iconList[i].flags & CViMapIcon::Icon::FLAG_ENABLED) != 0)
        {
            u16 iconX = this->iconList[i].pos.x;
            u16 iconY = this->iconList[i].pos.y;

            if ((u16)(x - (u16)(iconX - 12)) < 24 && (u16)(y - (u16)(iconY - 12)) < 24)
            {
                area = i;
                break;
            }
        }
    }

    return area;
}

MapArea CViMapIcon::GetAreaFromPadInput()
{
    u16 padBtnMask;
    if (this->markerMoveTimer < this->markerMoveDuration)
        padBtnMask = padInput.btnPress;
    else
        padBtnMask = padInput.btnDown;

    MapArea (*moveFunc)(MapArea mapArea, u16 next);
    if ((padBtnMask & PAD_KEY_LEFT) != 0)
    {
        moveFunc = CViMapIcon::PadMove_Left;
    }
    else if ((padBtnMask & PAD_KEY_UP) != 0)
    {
        moveFunc = CViMapIcon::PadMove_Up;
    }
    else if ((padBtnMask & PAD_KEY_RIGHT) != 0)
    {
        moveFunc = CViMapIcon::PadMove_Right;
    }
    else if ((padBtnMask & PAD_KEY_DOWN) != 0)
    {
        moveFunc = CViMapIcon::PadMove_Down;
    }
    else
    {
        return MAPAREA_INVALID;
    }

    u16 i = 0;
    while (TRUE)
    {
        u16 id = i;
        i++;

        MapArea mapArea = moveFunc(this->mapArea, id);
        if (mapArea >= MAPAREA_COUNT)
            return MAPAREA_INVALID;

        if ((this->iconList[mapArea].flags & CViMapIcon::Icon::FLAG_ENABLED) != 0)
            return mapArea;
    }

    return MAPAREA_INVALID;
}

BOOL CViMapIcon::IsMoving()
{
    return this->markerMoveTimer < this->markerMoveDuration;
}

void CViMapIcon::InitIcons()
{
    this->LoadIconConfig();
}

void CViMapIcon::DrawCursor(s16 x, s16 y)
{
    this->aniCursor.pos.x = x;
    this->aniCursor.pos.y = y;
    AnimatorSprite__DrawFrame(&this->aniCursor);
}

void CViMapIcon::LoadIconConfig()
{
    MI_CpuClear32(this->iconList, sizeof(this->iconList));

    for (s32 i = 0; i < (s32)ARRAY_COUNT(this->iconList); i++)
    {
        if (HubControl::CheckMapIconEnabled(i))
        {
            this->iconList[i].flags |= CViMapIcon::Icon::FLAG_ENABLED;
            CViMapIcon::InitIconPosition(i, &this->iconList[i].pos.x, &this->iconList[i].pos.y);
        }
    }
}

void CViMapIcon::DrawIcon(s16 x, s16 y)
{
    if (x > -16 && x < (HW_LCD_WIDTH + 16) && y > -16 && y < (HW_LCD_HEIGHT + 16))
    {
        this->aniIconCenter.pos.x      = x;
        this->aniIconCenter.pos.y      = y;
        this->aniIconCenter.spriteType = GX_OAM_MODE_XLU;
        AnimatorSprite__DrawFrame(&this->aniIconCenter);

        this->aniIconOutline.pos.x      = x;
        this->aniIconOutline.pos.y      = y;
        this->aniIconOutline.spriteType = GX_OAM_MODE_NORMAL;
        AnimatorSprite__DrawFrame(&this->aniIconOutline);
    }
}

void CViMapIcon::GetSonicMarkerPos(u16 *x, u16 *y)
{
    if (this->markerMoveTimer >= this->markerMoveDuration)
    {
        if (x != NULL)
            *x = this->iconList[this->mapArea].pos.x;

        if (y != NULL)
            *y = this->iconList[this->mapArea].pos.y;
    }
    else
    {
        fx32 prevX   = FX32_FROM_WHOLE(this->prevMarkerPos.x);
        fx32 prevY   = FX32_FROM_WHOLE(this->prevMarkerPos.y);
        fx32 targetX = FX32_FROM_WHOLE(this->iconList[this->mapArea].pos.x);
        fx32 targetY = FX32_FROM_WHOLE(this->iconList[this->mapArea].pos.y);

        fx32 timerPercent = FX_DivS32(FX32_FROM_WHOLE(this->markerMoveTimer), this->markerMoveDuration);
        fx32 movePercent  = (2 * timerPercent) - MultiplyFX(timerPercent, timerPercent);

        if (x != NULL)
            *x = FX32_TO_WHOLE(MultiplyFX(targetX - prevX, movePercent) + prevX);

        if (y != NULL)
            *y = FX32_TO_WHOLE(MultiplyFX(targetY - prevY, movePercent) + prevY);
    }
}

void CViMapIcon::DrawSonicMarker(s16 x, s16 y)
{
    this->aniSonicMarker.pos.x = x;
    this->aniSonicMarker.pos.y = y;

    AnimatorSprite__ProcessAnimationFast(&this->aniSonicMarker);
    AnimatorSprite__DrawFrame(&this->aniSonicMarker);
}

void CViMapIcon::InitIconPosition(MapArea mapArea, u16 *x, u16 *y)
{
    const CViMapAreaIconConfig *config = HubConfig__GetDockMapIconConfig(mapArea);

    if (x != NULL)
        *x = config->position.x;

    if (y != NULL)
        *y = config->position.y;
}

MapArea CViMapIcon::PadMove_Left(MapArea mapArea, u16 next)
{
    const CViMapAreaIconConfig *config = HubConfig__GetDockMapIconConfig(mapArea);

    if (next >= ARRAY_COUNT(config->nextArea_Left))
        return MAPAREA_INVALID;

    return config->nextArea_Left[next];
}

MapArea CViMapIcon::PadMove_Up(MapArea mapArea, u16 next)
{
    const CViMapAreaIconConfig *config = HubConfig__GetDockMapIconConfig(mapArea);

    if (next >= ARRAY_COUNT(config->nextArea_Up))
        return MAPAREA_INVALID;

    return config->nextArea_Up[next];
}

MapArea CViMapIcon::PadMove_Right(MapArea mapArea, u16 next)
{
    const CViMapAreaIconConfig *config = HubConfig__GetDockMapIconConfig(mapArea);

    if (next >= ARRAY_COUNT(config->nextArea_Right))
        return MAPAREA_INVALID;

    return config->nextArea_Right[next];
}

MapArea CViMapIcon::PadMove_Down(MapArea mapArea, u16 next)
{
    const CViMapAreaIconConfig *config = HubConfig__GetDockMapIconConfig(mapArea);

    if (next >= ARRAY_COUNT(config->nextArea_Down))
        return MAPAREA_INVALID;

    return config->nextArea_Down[next];
}