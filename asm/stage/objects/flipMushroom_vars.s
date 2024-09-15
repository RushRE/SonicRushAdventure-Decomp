	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public FlipMushroom__collisionOffset
FlipMushroom__collisionOffset: // 0x021883F0
	.hword 0xFFA0, 0xFFF2
	.hword 0xFFB2, 0xFFB0
	.hword 0xFFB8, 0xFFB0

.public FlipMushroom__collisionSize
FlipMushroom__collisionSize: // 0x021883FC
	.hword 0xC0, 0x18
	.hword 0x98, 0x98
	.hword 0x98, 0x98

.public FlipMushroom__hitboxList
FlipMushroom__hitboxList: // 0x02188408
	.hword -108, -24, 108, 0
	.hword 0, 0, 0, 0
	.hword 0, 0, 0, 0
	.hword 0, 0, 0, 0
	.hword -84, 18, -50, 52
	.hword -50, -16, -16, 18
	.hword -16, -50, 18, -16
	.hword 18, -84, 52, -50
	.hword -52, -84, -18, -50
	.hword -18, -50, 16, -16
	.hword 16, -16, 50, 18
	.hword 50, 18, 84, 52

.public FlipMushroom__stru_2188468
FlipMushroom__stru_2188468: // 0x02188468
	.word 0xFFFAC000, 0xFFFE0000, 0x2A000, 0, 0xFFFFEE00, 0x3000, 0x600, 0
	.hword 0x1F, 0x1F

	.word 0xFFFB5000, 0x2B000, 0x1F800, 0xFFFE0800, 0xFFFFF361, 0x2200, 0x435, 0
	.hword 0xF, 0xF

	.word 0x4B000, 0x2B000, 0xFFFE0800, 0xFFFE0800, 0xC9F, 0x2200, 0xFFFFFBCB, 0
	.hword 0xF, 0xF

	.data
	
.public flipMushCollisionList
flipMushCollisionList:
	.word aDfGmkFlipmushU
	.word aDfGmkFlipmushU_0
	.word aDfGmkFlipmushU_1

aDfGmkFlipmushU: // 0x02188FF8
	.asciz "/df/gmk_flipmush_u.df"
	.align 4
	
aDfGmkFlipmushU_1: // 0x02189010
	.asciz "/df/gmk_flipmush_ur.df"
	.align 4
	
aDfGmkFlipmushU_0: // 0x02189028
	.asciz "/df/gmk_flipmush_ul.df"
	.align 4
	
aActAcGmkFlipmu_0: // 0x02189040
	.asciz "/act/ac_gmk_flipmush.bac"
	.align 4