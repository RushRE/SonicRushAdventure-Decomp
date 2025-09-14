	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public exDrawFadeTask__lightConfig
exDrawFadeTask__lightConfig: // 0x021762E8
	.space 20
	
.public exDrawFadeTask__cameraConfigB
exDrawFadeTask__cameraConfigB: // 0x021762FC
	.space 0xA4

	.align 4
	
.public exDrawFadeTask__cameraConfigA
exDrawFadeTask__cameraConfigA: // 0x021763A0
	.space 0xA4

	.align 4

	.data

aExdrawfadetask: // 0x021743D0
	.asciz "exDrawFadeTask"