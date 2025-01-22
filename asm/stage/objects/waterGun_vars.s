	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public WaterGun__dword_218A3CC
WaterGun__dword_218A3CC: // 0x0218A3CC
	.space 0x04 * 3
	
.public WaterGrindRail__Singleton
WaterGrindRail__Singleton: // 0x0218A3D8
	.space 0x04 * 2 // Task*[2]

	.data
	
.public WaterGrindRail__byte_2189D28
WaterGrindRail__byte_2189D28:
	.byte 8, 17, 16, 51, 49
	.align 4

aActAcGmkWaterG: // 0x02189D30
	.asciz "/act/ac_gmk_water_graind.bac"
	.align 4
	
aDfGmkWaterGrai: // 0x02189D50
	.asciz "/df/gmk_water_graind_gun00.df"
	.align 4
	
aDfGmkWaterGrai_0: // 0x02189D70
	.asciz "/df/gmk_water_graind_gun01.df"
	.align 4