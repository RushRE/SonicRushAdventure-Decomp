	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public exGameSystemTask__singleton
exGameSystemTask__singleton: // 0x0217741C
	.space 0x04

	.data
	
aExgamesystemta: // 0x02175D60
	.asciz "exGameSystemTask"