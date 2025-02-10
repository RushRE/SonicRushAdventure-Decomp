	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public ViMap__TaskSingleton
ViMap__TaskSingleton: // 0x02173A4C
	.space 0x04
	
.public ViMapPaletteAnimation__Singleton
ViMapPaletteAnimation__Singleton: // 0x02173A50
	.space 0x04

	.data

aBpaViMapBpa: // 0x02173684
	.asciz "bpa/vi_map.bpa"
	.align 4