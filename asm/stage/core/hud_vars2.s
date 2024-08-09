
	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
	
.public bossGaugeNameAnimIDs
bossGaugeNameAnimIDs: // 0x0210EAE0
    .hword 10, 11, 12
	
.public tensionGaugeColors
tensionGaugeColors: // 0x0210EAE6
    .hword 0x7FFF, 0x7E80, 0x29F, 0x1F, 0x35F
// .hword GX_RGB_888(0xF8, 0xF8, 0xF8), GX_RGB_888(0x00, 0xA0, 0xF8), GX_RGB_888(0xF8, 0xA0, 0x00), GX_RGB_888(0xF8, 0x00, 0x00), GX_RGB_888(0xF8, 0xD0, 0x00)
	
.public bossGaugeNameVRAMPixels
bossGaugeNameVRAMPixels: // 0x0210EAF0
    .word 10, 11, 12
	
.public HUD__ringDigitTable
HUD__ringDigitTable: // 0x0210EAFC
    .word 100, 10, 1
	
.public HUD__uiElementAnimID
HUD__uiElementAnimID: // 0x0210EB08
    .hword 1, 2, 0x1E, 0x22, 0x23, 0x24, 0x25, 0x26, 3, 4
	
.public HUD__uiElementPaletteRow
HUD__uiElementPaletteRow: // 0x0210EB1C
    .hword 1, 0, 1, 0, 0, 0, 0, 0, 0, 0
	
.public bossGaugeAnimIDs
bossGaugeAnimIDs: // 0x0210EB30
    .hword 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12