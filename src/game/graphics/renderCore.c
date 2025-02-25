#include <game/graphics/renderCore.h>
#include <game/system/allocator.h>
#include <game/system/task.h>
#include <game/file/cardBackup.h>
#include <game/math/mtMath.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/input/micInput.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/oamSystem.h>
#include <game/file/fsRequest.h>
#include <game/system/sysEvent.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// STATIC FUNCTIONS
// --------------------

// ITCM funcs
void OnVBlank(void);
void OnVAlarmActivated(void *arg);

// Private Funcs
static void InitRenderCore(void);
static void UpdateLoadedOverlays(OverlayControl *state);
static void RefreshSwapBufferFlags(void);
static BOOL OnCardPulledOut(void);
static PMLCDTarget GetLCDTarget(void);

// --------------------
// VARIABLES
// --------------------

extern const OSOwnerInfo ownerInfo;

static s32 dmaRenderCount;
static void (*vBlankCallback)(void);
static RenderCoreFlags renderFlags;
GXDispSelect renderCurrentDisplay;
static u32 vBlankCount;
static u32 targetVBlankCount;
static RenderCoreFlags prevRenderFlags;
static s32 resetParam;
s32 renderDmaNo;

SwapBufferControl renderCoreSwapBuffer;
static OverlayControl overlayState;
static FoldDeviceControl foldControl;
static OSVAlarm vblankAlarm;
static DMAController renderDMAManagers[4];
RenderCoreGFXControl renderCoreGFXControlB;
RenderCoreGFXControl renderCoreGFXControlA;

RenderCoreGFXControl *const VRAMSystem__GFXControl[2] = { &renderCoreGFXControlA, &renderCoreGFXControlB };

// --------------------
// GDB DEBUGGING
// --------------------

#ifdef GDB_DEBUGGING

/* Added to support GDB overlay debugging. */
unsigned long _novlys                         = MAX_OVERLAYS;
struct_overlayTable _ovly_table[MAX_OVERLAYS] = {};

// this does nothing, but needs to be defined for GDB to refresh overlay state automatically.
static void _ovly_debug_event(void) {}

// helper function to mark a specific overlay as unmapped.
static void UnloadOverlayGDB(const FSOverlayID overlayID)
{
    _ovly_table[overlayID].mapped--;
    _ovly_debug_event();
}

// helper function to mark a specific overlay as mapped, and provide its RAM address and size to GDB.
static void LoadOverlayGDB(const FSOverlayID overlayID)
{
    FSOverlayInfo overlayInfo;

    // 1. fetch overlay info to identify vma
    FS_LoadOverlayInfo(&overlayInfo, MI_PROCESSOR_ARM9, overlayID);

    // 2. add entry to _ovly_table
    // note that this is a little hacky. the VMA is correct but the LMA is not exposed by the OverlayManager
    // and the size field is not correct compared to what's stored in the NEF.
    // the standard overlay manager in GDB bases comparisons on VMA and LMA, so it's not viable here.
    // requires a custom GDB build which maps based on section ID and can override section size.
    // see https://github.com/joshua-smith-12/binutils-gdb-nds
    _ovly_table[overlayID].vma  = VOID_TO_INT(overlayInfo.header.ram_address);
    _ovly_table[overlayID].id   = overlayID;
    _ovly_table[overlayID].size = overlayInfo.header.ram_size;
    _ovly_table[overlayID].mapped++;

    _ovly_debug_event();
}
#endif // GDB_DEBUGGING

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/itcm_begin.h>

void OnVBlank(void)
{
    u32 i;

    DMAController *dmaControl = renderDMAManagers;
    for (i = 0; i < 4; i++, dmaControl++)
    {
        if ((dmaControl->flags & DMACONTROL_FLAG_DISABLE_VBLANK_UPDATE) == 0)
            continue;

        if ((dmaControl->flags & DMACONTROL_FLAG_ENABLE_SWAP_BUFFER) != 0)
        {
            if ((dmaControl->flags & DMACONTROL_FLAG_SWAP_BUFFER) != 0)
                dmaControl->bufferID ^= 1;

            dmaControl->flags &= ~DMACONTROL_FLAG_SWAP_BUFFER;
        }

        u16 buffer = dmaControl->bufferID ^ 1;

        MI_StopDma(i);
        MI_CpuCopy16(dmaControl->dmaSrc[buffer], dmaControl->dmaDest, dmaControl->size);

        if ((dmaControl->size & 3) != 0)
        {
            u32 dmaSrc = dmaControl->size;
            dmaSrc += (size_t)dmaControl->dmaSrc[buffer];
            MI_HBlankDmaCopy16(i, (void *)dmaSrc, dmaControl->dmaDest, dmaControl->size);
        }
        else
        {
            u32 dmaSrc = dmaControl->size;
            dmaSrc += (size_t)dmaControl->dmaSrc[buffer];
            MI_HBlankDmaCopy32(i, (void *)dmaSrc, dmaControl->dmaDest, dmaControl->size);
        }

        dmaControl->flags &= ~DMACONTROL_FLAG_ENABLE_SWAP_BUFFER;
    }

    if ((renderFlags & RENDERCORE_FLAG_UPDATE_WINDOW_PLANE) != 0)
    {
        WindowPlaneManager window;
        void *windowRegister[2] = { (void *)REG_WIN0H_ADDR, (void *)REG_DB_WIN0H_ADDR };

        for (i = 0; i < 2; i++)
        {
            window = VRAMSystem__GFXControl[i]->windowManager;

            if ((window.visible & 1) != 0)
            {
                window.registers.win0Y1 |= 7;
                window.registers.win0Y2 |= 7;
            }

            if ((window.visible & 2) != 0)
            {
                window.registers.win1Y1 |= 7;
                window.registers.win1Y2 |= 7;
            }

            MI_CpuCopy32(&window.registers, windowRegister[i], sizeof(WindowPlaneManagerRegisters));
        }

        OS_CancelVAlarm(&vblankAlarm);
        OS_SetVAlarm(&vblankAlarm, 262, 263, OnVAlarmActivated, NULL);
    }

    vBlankCount++;
    if (vBlankCallback != NULL)
        vBlankCallback();

    OS_SetIrqCheckFlag(OS_IE_V_BLANK);
}

void OnVAlarmActivated(void *arg)
{
    MI_CpuCopy32(&renderCoreGFXControlA.windowManager.registers, &reg_G2_WIN0H, sizeof(WindowPlaneManagerRegisters));
    GX_SetVisibleWnd(renderCoreGFXControlA.windowManager.visible);

    MI_CpuCopy32(&renderCoreGFXControlB.windowManager.registers, &reg_G2S_DB_WIN0H, sizeof(WindowPlaneManagerRegisters));
    GXS_SetVisibleWnd(renderCoreGFXControlB.windowManager.visible);
}

#include <nitro/itcm_end.h>

// Game
void InitGameSystems(u32 dmaNo, u32 defaultDMA, s32 main1HeapSize, s32 main2HeapSize, s32 itcmHeapSize, s32 dtcmHeapSize, s32 audioHeapSize, s32 fsHeapSize)
{
    renderDmaNo = dmaNo;

    OS_SetIrqFunction(OS_IE_V_BLANK, OnVBlank);
    OS_EnableIrqMask(TRUE);
    GX_VBlankIntr(TRUE);
    OS_EnableInterrupts();
    OS_EnableIrq();

    GX_SetBankForLCDC(GX_VRAM_LCDC_ALL);
    MI_CpuClearFast((void *)HW_LCDC_VRAM, HW_LCDC_VRAM_SIZE);
    GX_DisableBankForLCDC();
    MI_CpuFillFast((void *)HW_OAM, 0xC0, HW_OAM_SIZE);
    MI_CpuClearFast((void *)HW_PLTT, HW_PLTT_SIZE);

    InitRenderCore();
    InitAllocatorSystem(main1HeapSize, main2HeapSize, itcmHeapSize, dtcmHeapSize);
    InitFSRequestSystem(fsHeapSize, defaultDMA);
    InitAudioSystem(audioHeapSize);
    InitPadInputSystem();
    InitTouchInputSystem();
    InitMicInputSystem();
    InitTaskSystem();
    InitVRAMSystem();
    InitPaletteQueueSystem();
    InitPixelsQueueSystem();
    InitMappingsQueueSystem();
    InitQueueSystem();
    InitOAMSystem();
    InitMtMath();
    InitCardBackupSystem();
    InitDrawReqSystem();

    CARD_SetPulledOutCallback(OnCardPulledOut);

    OS_GetOwnerInfo((OSOwnerInfo *)&ownerInfo);
}

void UpdateGameLoop(void)
{
    if (CARD_IsPulledOut())
    {
        RenderCore_StopAllDMAs();
        CARD_TerminateForPulledOut();
    }

    UpdatePadInput();
    UpdateTouchInput();
    UpdateMicInput();

    if ((renderFlags & RENDERCORE_FLAG_DISABLE_SOFT_RESET) == 0 && (padInput.btnDown & PAD_INPUT_SOFT_RESET) == PAD_INPUT_SOFT_RESET)
        RenderCore_PerformSoftReset();

    RenderCore_HandleDeviceFold();
    RefreshSwapBufferFlags();
    UpdateLoadedOverlays(&overlayState);
    RunUpdateTaskList();
    ProcessFSRequests();

    if ((renderFlags & RENDERCORE_FLAG_DISABLE_OAM_RESET) == 0)
    {
        OAMSystem__PrepareNewFrame(FALSE);
        OAMSystem__PrepareNewFrame(TRUE);
    }

    for (u32 i = 0; i < 4; i++)
    {
        renderDMAManagers[i].flags |= DMACONTROL_FLAG_ENABLE_SWAP_BUFFER;
    }

    prevRenderFlags = renderFlags;
}

// RenderCore
void UpdateDrawLoop(void)
{
    u32 i;

    RenderCoreFlags prevFlags = prevRenderFlags;
    GX_SetDispSelect(renderCurrentDisplay);

    // Update Engine A
    RenderCoreGFXControl *control;
    {
        control = &renderCoreGFXControlA;
        DC_StoreRange(control, sizeof(RenderCoreGFXControl));
        DC_WaitWriteBufferEmpty();
        MI_DmaCopy32(renderDmaNo, control->bgPosition, &reg_G2_BG0OFS, sizeof(control->bgPosition));
        if ((prevFlags & RENDERCORE_FLAG_UPDATE_WINDOW_PLANE) == 0)
        {
            MI_DmaCopy32(renderDmaNo, &control->windowManager.registers, &reg_G2_WIN0H, sizeof(control->windowManager.registers));
            GX_SetVisibleWnd(control->windowManager.visible);
        }
        MI_DmaCopy16(renderDmaNo, &control->blendManager, &reg_G2_BLDCNT, sizeof(control->blendManager));
        GX_SetMasterBrightness(control->brightness);
        reg_G2_MOSAIC = control->mosaicSize;
        G2_SetBG2Affine(&control->affineBG2.matrix, control->affineBG2.centerX, control->affineBG2.centerY, control->affineBG2.x, control->affineBG2.y);
        G2_SetBG3Affine(&control->affineBG3.matrix, control->affineBG3.centerX, control->affineBG3.centerY, control->affineBG3.x, control->affineBG3.y);
        if ((prevFlags & RENDERCORE_FLAG_DISABLE_OAM_RESET) == 0)
        {
            OAMSystem__CopyToVRAM(FALSE);
        }
    }

    // Update Engine B
    {
        control = &renderCoreGFXControlB;
        DC_StoreRange(control, sizeof(RenderCoreGFXControl));
        DC_WaitWriteBufferEmpty();
        MI_DmaCopy32(renderDmaNo, control->bgPosition, &reg_G2S_DB_BG0OFS, sizeof(control->bgPosition));
        if ((prevFlags & RENDERCORE_FLAG_UPDATE_WINDOW_PLANE) == 0)
        {
            MI_DmaCopy32(renderDmaNo, &control->windowManager.registers, &reg_G2S_DB_WIN0H, sizeof(control->windowManager.registers));
            GXS_SetVisibleWnd(control->windowManager.visible);
        }
        MI_DmaCopy16(renderDmaNo, &control->blendManager, &reg_G2S_DB_BLDCNT, sizeof(control->blendManager));
        GXS_SetMasterBrightness(control->brightness);
        reg_G2S_DB_MOSAIC = control->mosaicSize;
        G2S_SetBG2Affine(&control->affineBG2.matrix, control->affineBG2.centerX, control->affineBG2.centerY, control->affineBG2.x, control->affineBG2.y);
        G2S_SetBG3Affine(&control->affineBG3.matrix, control->affineBG3.centerX, control->affineBG3.centerY, control->affineBG3.x, control->affineBG3.y);
        if ((prevFlags & RENDERCORE_FLAG_DISABLE_OAM_RESET) == 0)
        {
            OAMSystem__CopyToVRAM(TRUE);
        }
    }

    // Update DMAs
    DMAController *dmaControl = renderDMAManagers;
    for (i = 0; i < 4; i++)
    {
        if ((dmaControl->flags & DMACONTROL_FLAG_DISABLE_VBLANK_UPDATE) != 0)
            MIi_CpuCopy16(dmaControl->dmaSrc[dmaControl->bufferID ^ 1], dmaControl->dmaDest, dmaControl->size);

        dmaControl++;
    }

    // Update game logic components
    ProcessTexturePaletteQueue();
    ProcessTexturePixelQueue();
    ProcessBackgroundPaletteQueue();
    ProcessSpritePaletteQueue();
    Mappings__ReadList();
    ProcessSpritePixelQueue();

    RunRenderTaskList();
    ClearTaskLists();

    NNS_SndMain();

    // Finish
    MI_WaitDma(renderDmaNo);
    dmaRenderCount++;
}

u32 RenderCore_GetTargetVBlankCount(void)
{
    return targetVBlankCount;
}

void RenderCore_SetTargetVBlankCount(u32 target)
{
    targetVBlankCount = target;
}

void RenderCore_WaitVBlank(void)
{
    while (targetVBlankCount > vBlankCount)
    {
        OS_WaitVBlankIntr();
    }

    if ((GX_GetPower() & GX_POWER_3D) != 0 && (renderFlags & RENDERCORE_FLAG_DISABLE_SWAP_BUFFERS) == 0)
        G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);

    OS_WaitVBlankIntr();
    vBlankCount = 0;
}

void RenderCore_SetVBlankCallback(void (*callback)(void))
{
    vBlankCallback = callback;
}

void RenderCore_PerformSoftReset(void)
{
    GX_SetMasterBrightness(RENDERCORE_BRIGHTNESS_WHITE);
    GXS_SetMasterBrightness(RENDERCORE_BRIGHTNESS_WHITE);

    if ((overlayState.flags & OVERLAYCONTROL_FLAG_OVERLAY_LOADED) != 0)
        FS_UnloadOverlay(MI_PROCESSOR_ARM9, overlayState.prevID);

    OS_ResetSystem(resetParam | RENDERCORE_RESETPARAM_FLAG);
}

u32 RenderCore_GetResetParam(void)
{
    return resetParam;
}

void RenderCore_CPUCopy(void *input, void *output, u32 length)
{
    u8 *inputPtr  = (u8 *)input;
    u8 *outputPtr = (u8 *)output;
    u32 size      = length;

    if ((((size_t)inputPtr | (size_t)outputPtr) & 3) == 0)
    {
        u32 alignedSize2 = length & ~0x1F;
        if ((length & ~0x1F) != 0)
        {
            MIi_CpuCopyFast((int *)input, output, length & ~0x1F);
            inputPtr += alignedSize2;
            outputPtr += alignedSize2;
            size &= 0x1F;
        }

        u32 alignedSize = size & ~3;
        if ((size & ~3u) != 0)
        {
            MI_CpuCopy32((void *)inputPtr, (void *)outputPtr, size & ~3);
            inputPtr += alignedSize;
            outputPtr += alignedSize;
            size &= 3;
        }
    }

    if ((((size_t)inputPtr | (size_t)outputPtr) & 1) == 0)
    {
        u32 alignedSize = size & ~1;
        if ((size & ~1) != 0)
        {
            MIi_CpuCopy16((const void *)inputPtr, (void *)outputPtr, size & ~1);
            inputPtr += alignedSize;
            outputPtr += alignedSize;
            size &= 1;
        }
    }

    if (size)
        MI_CpuCopy8(inputPtr, outputPtr, size);
}

void RenderCore_DMACopy(const void *srcPixels, void *dstPixels, u32 srcSize)
{
    u8 *srcPixelsPtr = (u8 *)srcPixels;
    u8 *dstPixelsPtr = (u8 *)dstPixels;
    u32 size         = srcSize;

    if ((((size_t)srcPixelsPtr | (size_t)dstPixelsPtr) & 3) == 0)
    {
        u32 alignedSize = srcSize & ~3;

        if (alignedSize != 0)
        {
            MI_DmaCopy32(renderDmaNo, srcPixels, dstPixels, alignedSize);
            srcPixelsPtr += alignedSize;
            dstPixelsPtr += alignedSize;
            size &= 3;
        }
    }

    if (size)
        MI_DmaCopy16(renderDmaNo, srcPixelsPtr, dstPixelsPtr, size);
}

void RenderCore_CPUCopyCompressed(void *input, void *output)
{
    switch (MI_GetCompressionType(input))
    {
        case MI_COMPRESSION_LZ:
            MI_UncompressLZ16(input, output);
            break;

        case MI_COMPRESSION_HUFFMAN:
            MI_UncompressHuffman(input, output);
            break;

        case MI_COMPRESSION_RL:
            MI_UncompressRL16(input, output);
            break;

        default:
            RenderCore_CPUCopy(input + sizeof(MICompressionHeader), output, MI_GetUncompressedSize(input));
            break;
    }

    DC_StoreRange(output, MI_GetUncompressedSize(input));
}

void RenderCore_ChangeOverlay(int overlayID, void (*changeCB)(void))
{
    overlayState.nextID           = overlayID;
    overlayState.onOverlayChanged = changeCB;
}

void RenderCore_PrepareDMA(u32 id, void *src2, void *src1, void *dst, u32 size)
{
    DMAController *dmaControl = &renderDMAManagers[id];

    OSIntrMode enabled    = OS_DisableInterrupts();
    dmaControl->dmaDest   = dst;
    dmaControl->dmaSrc[0] = src2;
    dmaControl->dmaSrc[1] = src1;
    dmaControl->size      = size;
    dmaControl->bufferID  = 0;
    dmaControl->flags     = DMACONTROL_FLAG_DISABLE_VBLANK_UPDATE;
    OS_RestoreInterrupts(enabled);
}

void RenderCore_StopDMA(u32 id)
{
    OSIntrMode enabled          = OS_DisableInterrupts();
    renderDMAManagers[id].flags = DMACONTROL_FLAG_NONE;
    MI_StopDma(id);
    OS_RestoreInterrupts(enabled);
}

void RenderCore_PrepareDMASwapBuffer(u32 id)
{
    DMAController *dmaControl = &renderDMAManagers[id];

    OSIntrMode enabled = OS_DisableInterrupts();
    DC_StoreRange(dmaControl->dmaSrc[dmaControl->bufferID], HW_LCD_HEIGHT * dmaControl->size);
    dmaControl->flags |= DMACONTROL_FLAG_SWAP_BUFFER;
    OS_RestoreInterrupts(enabled);
}

void *RenderCore_GetDMASrc(u32 id)
{
    return renderDMAManagers[id].dmaSrc[renderDMAManagers[id].bufferID];
}

FoldDeviceMode RenderCore_GetNextFoldMode(void)
{
    return foldControl.nextMode;
}

void RenderCore_SetNextFoldMode(FoldDeviceMode mode)
{
    foldControl.nextMode = mode;
}

void RenderCore_HandleDeviceFold(void)
{
    if (PAD_DetectFold())
    {
        if (foldControl.isFolded != TRUE)
        {
            foldControl.isFolded = TRUE;
            foldControl.target   = GetLCDTarget();
        }
        else
        {
            if (foldControl.mode == foldControl.nextMode && foldControl.nextMode != 0)
                return;
        }

        switch (foldControl.nextMode)
        {
            case FOLD_TOGGLE_SLEEP:
                PM_GoSleepMode(PM_TRIGGER_COVER_OPEN | PM_TRIGGER_CARD, PM_PAD_LOGIC_OR, PAD_INPUT_NONE_MASK);
                break;

            case FOLD_TOGGLE_POWER:
                PM_SetLCDPower(PM_LCD_POWER_OFF);
                break;

            case FOLD_TOGGLE_BACKLIGHT:
                while (!PM_SetLCDPower(PM_LCD_POWER_ON))
                {
                    // Waiting for it...
                }

                PM_SetBackLight(PM_LCD_ALL, PM_BACKLIGHT_OFF);
                break;
        }

        foldControl.mode = foldControl.nextMode;
    }
    else
    {
        if (!foldControl.isFolded)
            return;

        foldControl.isFolded = FALSE;

        switch (foldControl.mode)
        {
            case FOLD_TOGGLE_SLEEP:
                while (!PM_SetLCDPower(PM_LCD_POWER_ON))
                {
                    // Waiting for it...
                }

                if (foldControl.target != PM_LCD_INVALID)
                    PM_SetBackLight(foldControl.target, PM_BACKLIGHT_ON);

                GX_DispOn();
                GXS_DispOn();
                break;

            case FOLD_TOGGLE_POWER:
                while (!PM_SetLCDPower(PM_LCD_POWER_ON))
                {
                    // Waiting for it...
                }

                if (foldControl.target == PM_LCD_INVALID)
                    return;

                PM_SetBackLight(foldControl.target, PM_BACKLIGHT_ON);
                break;

            case FOLD_TOGGLE_BACKLIGHT:
                if (foldControl.target == PM_LCD_INVALID)
                    return;

                PM_SetBackLight(foldControl.target, PM_BACKLIGHT_ON);
                break;
        }
    }
}

const u8 *RenderCore_GetLanguagePtr(void)
{
    return &ownerInfo.language;
}

u32 RenderCore_GetDMARenderCount(void)
{
    return dmaRenderCount;
}

void RenderCore_DisableSoftReset(BOOL enabled)
{
    if (enabled)
        renderFlags |= RENDERCORE_FLAG_DISABLE_SOFT_RESET;
    else
        renderFlags &= ~RENDERCORE_FLAG_DISABLE_SOFT_RESET;
}

u32 RenderCore_GetSoftResetDisabled(void)
{
    return renderFlags & RENDERCORE_FLAG_DISABLE_SOFT_RESET;
}

void RenderCore_DisableSwapBuffers(BOOL enabled)
{
    if (enabled)
        renderFlags |= RENDERCORE_FLAG_DISABLE_SWAP_BUFFERS;
    else
        renderFlags &= ~RENDERCORE_FLAG_DISABLE_SWAP_BUFFERS;
}

void RenderCore_DisableOAMReset(BOOL enabled)
{
    if (enabled)
        renderFlags |= RENDERCORE_FLAG_DISABLE_OAM_RESET;
    else
        renderFlags &= ~RENDERCORE_FLAG_DISABLE_OAM_RESET;
}

void RenderCore_DisableWindowPlaneUpdate(BOOL enabled)
{
    if (enabled)
        renderFlags |= RENDERCORE_FLAG_UPDATE_WINDOW_PLANE;
    else
        renderFlags &= ~RENDERCORE_FLAG_UPDATE_WINDOW_PLANE;
}

void RenderCore_SetWnd0InsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect)
{
    window->registers.win0InPlane.value = plane;
    if (effect)
        window->registers.win0InPlane.effect = TRUE;
}

void RenderCore_SetWnd1InsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect)
{
    window->registers.win1InPlane.value = plane;
    if (effect)
        window->registers.win1InPlane.effect = TRUE;
}

void RenderCore_SetWndOutsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect)
{
    window->registers.winOutPlane.value = plane;
    if (effect)
        window->registers.winOutPlane.effect = TRUE;
}

void RenderCore_SetWndOBJOutsidePlane(WindowPlaneManager *window, /*GXWndPlaneMask*/ u32 plane, BOOL effect)
{
    window->registers.winOBJOutPlane.value = plane;
    if (effect)
        window->registers.winOBJOutPlane.effect = TRUE;
}

void RenderCore_SetWindow0Position(WindowPlaneManager *window, u32 x1, u32 y1, u32 x2, u32 y2)
{
    window->registers.win0X1 = x1;
    window->registers.win0X2 = x2;
    window->registers.win0Y1 = y1;
    window->registers.win0Y2 = y2;
}

void RenderCore_SetWindow1Position(WindowPlaneManager *window, u32 x1, u32 y1, u32 x2, u32 y2)
{
    window->registers.win1X1 = x1;
    window->registers.win1X2 = x2;
    window->registers.win1Y1 = y1;
    window->registers.win1Y2 = y2;
}

void RenderCore_DisableBlending(BlendController *manager)
{
    manager->blendControl.value = REG_G2_BLDCNT_FIELD(GX_PLANEMASK_NONE, BLENDTYPE_NONE, GX_PLANEMASK_NONE);
}

void RenderCore_SetBlendBrightness(u32 addr, int plane, int brightness)
{
    G2x_SetBlendBrightness_(addr, plane, brightness);
}

void RenderCore_SetBlendBrightnessExt(u32 addr, int plane1, int plane2, int ev1, int ev2, int brightness)
{
    G2x_SetBlendBrightnessExt_(addr, plane1, plane2, ev1, ev2, brightness);
}

void RenderCore_ChangeBlendAlpha(BlendController *manager, s32 ev1, s32 ev2)
{
    manager->blendAlpha.ev1 = ev1;
    manager->blendAlpha.ev2 = ev2;
}

void RenderCore_ChangeBlendBrightness(u32 addr, int brightness)
{
    G2x_ChangeBlendBrightness_(addr, brightness);
}

// Private functions

void InitRenderCore(void)
{
    renderFlags       = RENDERCORE_FLAG_NONE;
    prevRenderFlags   = RENDERCORE_FLAG_NONE;
    targetVBlankCount = 0;
    vBlankCount       = 0;
    resetParam        = *(u32 *)HW_RESET_PARAMETER_BUF;

    MI_CpuClear16(renderDMAManagers, sizeof(renderDMAManagers));

    MI_CpuClear16(&foldControl, sizeof(foldControl));
    foldControl.mode     = FOLD_TOGGLE_SLEEP;
    foldControl.nextMode = FOLD_TOGGLE_SLEEP;

    // ???
    MtxFx22 matrix;
    MTX_Identity22(&matrix);

    for (u32 i = 0; i < 2; i++)
    {
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i];
        MI_CpuClear16(gfxControl, sizeof(*gfxControl));

        MTX_Identity22(&gfxControl->affineBG2.matrix);
        gfxControl->affineBG2.centerX = gfxControl->affineBG2.centerY = 0;
        gfxControl->affineBG2.x = gfxControl->affineBG2.y = 0;

        MTX_Identity22(&gfxControl->affineBG3.matrix);
        gfxControl->affineBG3.centerX = gfxControl->affineBG3.centerY = 0;
        gfxControl->affineBG3.x = gfxControl->affineBG3.y = 0;
    }

    MI_CpuClear16(&renderCoreSwapBuffer, sizeof(renderCoreSwapBuffer));
    renderCoreSwapBuffer.sortMode   = GX_SORTMODE_AUTO;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    MI_CpuClear32(&overlayState, sizeof(overlayState));
    overlayState.prevID = OVERLAY_NONE;
    overlayState.nextID = OVERLAY_NONE;

    OS_CreateVAlarm(&vblankAlarm);
    dmaRenderCount = 0;
}

void UpdateLoadedOverlays(OverlayControl *state)
{
    if (state->prevID != state->nextID)
    {
        if ((state->flags & OVERLAYCONTROL_FLAG_OVERLAY_LOADED) != 0)
        {
            FS_UnloadOverlay(MI_PROCESSOR_ARM9, state->prevID);
            state->flags &= ~OVERLAYCONTROL_FLAG_OVERLAY_LOADED;

#ifdef GDB_DEBUGGING
            UnloadOverlayGDB(state->prevID);
#endif
        }

#ifdef GDB_DEBUGGING
        LoadOverlayGDB(state->nextID);
#endif

        FS_LoadOverlay(MI_PROCESSOR_ARM9, state->nextID);
        state->prevID = state->nextID;
        state->flags |= OVERLAYCONTROL_FLAG_OVERLAY_LOADED;
    }

    if (state->onOverlayChanged)
    {
        state->onOverlayChanged();
        state->onOverlayChanged = NULL;
    }
}

void RefreshSwapBufferFlags(void)
{
    renderCoreSwapBuffer.flags &= ~(SWAPBUFFER_FLAG_LINE_BUFFER_UNDERFLOW | SWAPBUFFER_FLAG_LIST_RAM_OVERFLOW | SWAPBUFFER_FLAG_MTX_STACK_OVERFLOW);

    if (GX_GetPower() & GX_POWER_3D)
    {
        if (G3X_IsLineBufferUnderflow())
            renderCoreSwapBuffer.flags |= SWAPBUFFER_FLAG_LINE_BUFFER_UNDERFLOW;

        if (G3X_IsListRamOverflow())
            renderCoreSwapBuffer.flags |= SWAPBUFFER_FLAG_LIST_RAM_OVERFLOW;

        s32 overflow;
        if (G3X_IsMtxStackOverflow(&overflow) == 0)
        {
            if (overflow)
                renderCoreSwapBuffer.flags |= SWAPBUFFER_FLAG_MTX_STACK_OVERFLOW;
        }

        G3X_Reset();
        G3X_ResetMtxStack();
    }
}

BOOL OnCardPulledOut(void)
{
    return FALSE;
}

void RenderCore_StopAllDMAs(void)
{
    for (s32 i = 0; i < 4; i++)
    {
        RenderCore_StopDMA((u8)i);
    }
}

PMLCDTarget GetLCDTarget(void)
{
    PMBackLightSwitch bottom;
    PMBackLightSwitch top;

    if (PM_GetBackLight(&bottom, &top) == PM_RESULT_SUCCESS)
    {
        if (bottom == PM_BACKLIGHT_ON && top == PM_BACKLIGHT_ON)
            return PM_LCD_ALL;

        if (bottom == PM_BACKLIGHT_ON)
            return PM_LCD_TOP;

        if (top == PM_BACKLIGHT_ON)
            return PM_LCD_BOTTOM;

        return PM_LCD_INVALID;
    }
    else
    {
        return PM_LCD_ALL;
    }
}
