#include <hub/npcPurchase.hpp>
#include <hub/cviMap.hpp>
#include <hub/hubControl.hpp>

// resources
#include <resources/narc/vi_act_lz7.h>

// --------------------
// FUNCTIONS
// --------------------

void NpcPurchase::Init()
{
    this->state = NpcPurchase::STATE_INACTIVE;

    FontWindowAnimator__Init(&this->fontWindowAnimator);

    MI_CpuClear16(&this->aniMaterialFrame, sizeof(this->aniMaterialFrame));
    MI_CpuClear16(&this->aniRingCountFrame, sizeof(this->aniRingCountFrame));
    MI_CpuClear16(this->aniNumbers, sizeof(this->aniNumbers));
    MI_CpuClear32(this->paletteColors, sizeof(this->paletteColors));
}

void NpcPurchase::Load(u16 backgroundID, u16 a3, u16 a4, u16 a5, u16 hudPaletteRow, u16 materialPaletteRow)
{
    this->Release();

    this->backgroundID       = backgroundID;
    this->materialPaletteRow = materialPaletteRow;

    GetSpriteSizeFunc getSpriteSize;
    GetSpriteSizeFromAnimFunc getSpriteSizeFromAnim;
    switch (GXS_GetOBJVRamModeChar())
    {
        case GX_OBJVRAMMODE_CHAR_1D_256K:
            getSpriteSize         = Sprite__GetSpriteSize4;
            getSpriteSizeFromAnim = Sprite__GetSpriteSize4FromAnim;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            getSpriteSize         = Sprite__GetSpriteSize3;
            getSpriteSizeFromAnim = Sprite__GetSpriteSize3FromAnim;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            getSpriteSize         = Sprite__GetSpriteSize2;
            getSpriteSizeFromAnim = Sprite__GetSpriteSize2FromAnim;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_32K:
            getSpriteSize         = Sprite__GetSpriteSize1;
            getSpriteSizeFromAnim = Sprite__GetSpriteSize1FromAnim;
            break;
    }

    AnimatorSprite *aniMaterial;
    s32 t;
    s32 matrialTopX;
    s32 matrialBottomX;

    void *sprMaterial   = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_MAT32_256_BAC);
    u32 sprMaterialSize = getSpriteSize(sprMaterial);

    u16 *paletteColors = this->paletteColors;
    t                  = 0;
    matrialTopX        = 16;
    matrialBottomX     = 0;
    for (; t < SAVE_MATERIAL_COUNT; t++)
    {
        aniMaterial = ViMap__Func_215C98C(t);

        AnimatorSprite__SetAnimation(aniMaterial, t);
        aniMaterial->paletteMode = PALETTE_MODE_SPRITE;
        aniMaterial->vramPalette = paletteColors;
        aniMaterial->oamPriority = SPRITE_PRIORITY_0;
        aniMaterial->oamOrder    = SPRITE_ORDER_1;

        if (t < SAVE_MATERIAL_SILVER)
        {
            aniMaterial->pos.x = matrialTopX;
            aniMaterial->pos.y = 114;
        }
        else
        {
            aniMaterial->pos.x = matrialBottomX - 164;
            aniMaterial->pos.y = 150;
        }

        if (t == 0)
        {
            aniMaterial->flags          = ANIMATOR_FLAG_NONE;
            aniMaterial->cParam.palette = PALETTE_ROW_0;
        }
        else
        {
            aniMaterial->flags          = ANIMATOR_FLAG_DISABLE_PALETTES;
            aniMaterial->cParam.palette = materialPaletteRow;
        }

        matrialTopX += 36;
        matrialBottomX += 36;
    }

    void *sprMaterialFrame   = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_BD_MAT_FRAME_BAC);
    u32 sprMaterialFrameSize = getSpriteSize(sprMaterialFrame);

    AnimatorSprite *aniMaterialFrame = &this->aniMaterialFrame;
    AnimatorSprite__Init(aniMaterialFrame, sprMaterialFrame, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, sprMaterialFrameSize), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_2);
    aniMaterialFrame->cParam.palette = hudPaletteRow + PALETTE_ROW_0;

    void *sprMenu   = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_VI_MENU_BAC);
    u32 sprMenuSize = getSpriteSizeFromAnim(sprMenu, 0);

    AnimatorSprite *aniRingCountFrame = &this->aniRingCountFrame;
    AnimatorSprite__Init(&this->aniRingCountFrame, sprMenu, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, sprMenuSize), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    aniRingCountFrame->pos.x          = 160;
    aniRingCountFrame->pos.y          = 144;
    aniRingCountFrame->cParam.palette = hudPaletteRow + PALETTE_ROW_1;

    AnimatorSprite *aniDigit;
    void *sprNumbers  = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_NUMBER_BAC);
    u32 sprNumberSize = getSpriteSize(sprNumbers);

    aniDigit = &this->aniNumbers[0];
    s32 i    = 0;
    for (i = 0; i < 10; i++)
    {
        AnimatorSprite__Init(aniDigit, sprNumbers, i, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, sprNumberSize),
                             PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        aniDigit->cParam.palette = hudPaletteRow + PALETTE_ROW_2;

        aniDigit++;
    }

    aniDigit = &this->aniNumbers[0];
    aniDigit += 10;
    for (i = 10; i < 20; i++)
    {
        AnimatorSprite__Init(aniDigit, sprNumbers, i, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, sprNumberSize),
                             PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        aniDigit->cParam.palette = hudPaletteRow + PALETTE_ROW_3;

        aniDigit++;
    }

    FontWindowAnimator__Init(&this->fontWindowAnimator);
    FontWindowAnimator__Load1(&this->fontWindowAnimator, HubControl::GetField54(), 0, 0, 1, 0, 13, 26, 11, GRAPHICS_ENGINE_B, backgroundID, a5, a3, a4);

    for (t = 0; t < SAVE_MATERIAL_COUNT; t++)
    {
        if (!NpcPurchase::HasMaterial(t))
        {
            MI_CpuFill16(&this->aniMaterialNum[t], 0xFFFF, sizeof(this->aniMaterialNum[t]));
        }
        else
        {
            s32 slot;

            s32 count = NpcPurchase::GetMaterialCount(t);
            if (count > SAVEGAME_MATERIAL_MAX)
                count = SAVEGAME_MATERIAL_MAX;

            for (slot = 1; slot >= 0; slot--)
            {
                s32 div                       = FX_DivS32(count, 10);
                this->aniMaterialNum[t][slot] = count - 10 * div;
                count                         = div;

                if (slot < 1 && this->aniMaterialNum[t][slot] == 0)
                    this->aniMaterialNum[t][slot] = 0xFFFF;
            }

            if (this->aniMaterialNum[t][1] == 0xFFFF)
            {
                this->aniMaterialNum[t][1] = this->aniMaterialNum[t][0];
                this->aniMaterialNum[t][0] = -1;
            }
        }
    }

    s32 ringCount = NpcPurchase::GetRingCount();
    if (ringCount > SAVEGAME_RING_MAX)
        ringCount = SAVEGAME_RING_MAX;

    for (s32 r = 5; r >= 0; r--)
    {
        s32 div                  = FX_DivS32(ringCount, 10);
        this->aniRingCountNum[r] = ringCount - 10 * div;
        ringCount                = div;
    }

    this->state = NpcPurchase::STATE_READY;
}

void NpcPurchase::Release()
{
    FontWindowAnimator__Release(&this->fontWindowAnimator);
    AnimatorSprite__Release(&this->aniRingCountFrame);

    for (s32 i = 0; i < 20; i++)
    {
        AnimatorSprite__Release(&this->aniNumbers[i]);
    }

    AnimatorSprite__Release(&this->aniMaterialFrame);

    this->state = NpcPurchase::STATE_INACTIVE;
}

void NpcPurchase::Process()
{
    GXRgb unknown[] = { GX_RGB_888(0x40, 0x08, 0x00), GX_RGB_888(0xC0, 0x28, 0x00), GX_RGB_888(0x00, 0x30, 0x50), GX_RGB_888(0x58, 0x50, 0x00) };

    Vec2Fx16 materialCountPos = { 16, 16 };
    Vec2Fx16 ringCountPos     = { 26, 12 };

    s32 i;

    if (this->state == NpcPurchase::STATE_ACTIVE)
    {
        u32 slot;
        AnimatorSprite *aniDigit;
        s32 d;

        FontWindowAnimator__Draw(&this->fontWindowAnimator);

        // Draw material counts
        for (i = 0; i < SAVE_MATERIAL_COUNT; i++)
        {
            AnimatorSprite__DrawFrame(ViMap__Func_215C98C(i));

            this->aniMaterialFrame.pos.x = ViMap__Func_215C98C(i)->pos.x;
            this->aniMaterialFrame.pos.y = ViMap__Func_215C98C(i)->pos.y;
            AnimatorSprite__DrawFrame(&this->aniMaterialFrame);

            s32 digitX = materialCountPos.x;
            for (d = 0; d < 2; d++)
            {
                slot = this->aniMaterialNum[i][d];
                if (slot != 0xFFFF)
                {
                    aniDigit = &this->aniNumbers[slot];

                    aniDigit->pos.x = ViMap__Func_215C98C(i)->pos.x;
                    aniDigit->pos.y = ViMap__Func_215C98C(i)->pos.y;
                    aniDigit->pos.x += digitX;
                    aniDigit->pos.y += materialCountPos.y;
                    AnimatorSprite__DrawFrame(aniDigit);
                }
                digitX += 8;
            }
        }

        AnimatorSprite__DrawFrame(&this->aniRingCountFrame);

        // Draw ring count
        {
            s32 digitX = ringCountPos.x;
            for (d = 0; d < 6; d++)
            {
                slot = this->aniRingCountNum[d];
                if (slot != 0xFFFF)
                {
                    aniDigit = &this->aniNumbers[10 + slot];

                    aniDigit->pos.x = this->aniRingCountFrame.pos.x;
                    aniDigit->pos.y = this->aniRingCountFrame.pos.y;
                    aniDigit->pos.x += digitX;
                    aniDigit->pos.y += ringCountPos.y;
                    AnimatorSprite__DrawFrame(aniDigit);
                }
                digitX += 9;
            }
        }
    }
    else if (this->state == NpcPurchase::STATE_OPENING_WINDOW)
    {
        FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
        FontWindowAnimator__Draw(&this->fontWindowAnimator);

        if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
        {
            FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);

            AnimatorSprite__ProcessAnimationFast(&this->aniMaterialFrame);

            for (i = 0; i < 20; i++)
            {
                AnimatorSprite__ProcessAnimationFast(&this->aniNumbers[i]);
            }

            AnimatorSprite__ProcessAnimationFast(&this->aniRingCountFrame);

            u16 *paletteColors = this->paletteColors;
            for (i = 0; i < SAVE_MATERIAL_COUNT; i++)
            {
                if (!NpcPurchase::HasMaterial(i))
                    MIi_CpuClear16(GX_RGB_888(0x78, 0x78, 0x78), paletteColors, 0x10 * sizeof(GXRgb));

                paletteColors += 0x10;
            }
            QueueUncompressedPalette(this->paletteColors, ARRAY_COUNT(this->paletteColors), PALETTE_MODE_SUB_OBJ,
                                     (this->materialPaletteRow * ARRAY_COUNT(this->paletteColors) * sizeof(GXRgb)));
            this->state = NpcPurchase::STATE_ACTIVE;
        }
    }
    else if (this->state == NpcPurchase::STATE_CLOSING_WINDOW)
    {
        FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
        FontWindowAnimator__Draw(&this->fontWindowAnimator);
        if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
        {
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(1 << this->backgroundID));
            FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);
            this->state = NpcPurchase::STATE_CLOSED_WINDOW;
        }
    }
    else if (this->state == NpcPurchase::STATE_CLOSED_WINDOW)
    {
        FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
        this->state = NpcPurchase::STATE_READY;
    }
}

void NpcPurchase::ProcessGraphics()
{
    FontWindowAnimator__Func_20599B4(&this->fontWindowAnimator);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | (1 << this->backgroundID));

    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);

    for (s32 i = 0; i < SAVE_MATERIAL_COUNT; i++)
    {
        AnimatorSprite__ProcessAnimationFast(ViMap__Func_215C98C(i));
    }

    AnimatorSprite *aniMaterial = ViMap__Func_215C98C(0);
    aniMaterial->flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    ViMap__Func_215C98C(0)->cParam.palette = this->materialPaletteRow;

    this->state = NpcPurchase::STATE_OPENING_WINDOW;
}

BOOL NpcPurchase::IsReady()
{
    return this->state == NpcPurchase::STATE_ACTIVE;
}

void NpcPurchase::CloseWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 4, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);

    this->state = NpcPurchase::STATE_CLOSING_WINDOW;
}

BOOL NpcPurchase::IsActive()
{
    return this->state == NpcPurchase::STATE_READY;
}

BOOL NpcPurchase::HasMaterial(u16 type)
{
    if (type < SAVE_MATERIAL_COUNT)
        return SaveGame__HasMaterial(&saveGame.stage, type);
    else
        return FALSE;
}

u32 NpcPurchase::GetMaterialCount(u16 type)
{
    if (type < SAVE_MATERIAL_COUNT)
        return SaveGame__GetMaterialCount(&saveGame.stage, type);
    else
        return 0;
}

u32 NpcPurchase::GetRingCount(void)
{
    return saveGame.stage.ringCount;
}