	.include "asm/macros.inc"
	.include "global.inc"

	.data
	
.public AnchorRope__spriteSizeTable
AnchorRope__spriteSizeTable: // 0x21897E4
	.hword 0x1C, 0x10

.public AnchorRope__modelIDTable
AnchorRope__modelIDTable: // 0x021897E8
	.hword 0, 2

.public AnchorRope__paletteFlagTable
AnchorRope__paletteFlagTable: // 0x021897E8
	.hword 0, 0x48

aModGmkAnchorRo: // 0x021897F0
	.asciz "/mod/gmk_anchor_rope.nsbmd"
	.align 4
	
aActAcGmkAnchor: // 0x0218980C
	.asciz "/act/ac_gmk_anchor_rope.bac"
	.align 4