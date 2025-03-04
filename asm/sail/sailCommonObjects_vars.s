	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public _0218BC58
_0218BC58: // 0x0218BC58
    .word 0, 0x1000, 0

.public _0218BC64
_0218BC64: // 0x0218BC64
    .byte 0x80, 0, 0, 1, 0x80, 0, 0x20, 0, 0x80, 0xFF, 0, 0xFF, 0x80, 0xFF, 0xE0, 0xFF

	.data

aSbLandBac: // 0x0218D2B0
	.asciz "/sb_land.bac"
    .align 4

aSbMineBac_0: // 0x0218D2C0
	.asciz "sb_mine.bac"
    .align 4

aSbBomberBac: // 0x0218D2CC
	.asciz "sb_bomber.bac"
    .align 4

aSbCloudBac_0: // 0x0218D2DC
	.asciz "sb_cloud.bac"
    .align 4

aSbBuoyNsbmd_0: // 0x0218D2EC
	.asciz "sb_buoy.nsbmd"
    .align 4

aSbBuoyNsbca: // 0x0218D2FC
	.asciz "sb_buoy.nsbca"
    .align 4

aSbSeagullBac: // 0x0218D30C
	.asciz "sb_seagull.bac"
    .align 4

aSbSeagullNsbmd_0: // 0x0218D31C
	.asciz "sb_seagull.nsbmd"
    .align 4

aSbStoneNsbmd_0: // 0x0218D330
	.asciz "sb_stone.nsbmd"
    .align 4

aSbIceNsbmd_0: // 0x0218D340
	.asciz "sb_ice.nsbmd"
    .align 4

aSbSubFishNsbmd_0: // 0x0218D350
	.asciz "sb_sub_fish.nsbmd"
    .align 4