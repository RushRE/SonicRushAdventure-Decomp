	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public BossHelpers__RenderCallbackList
BossHelpers__RenderCallbackList: // 0x02134048
	.space 0x10 * 16

.public BossHelpers__RenderCallbackCount
BossHelpers__RenderCallbackCount: // 0x02134148
	.space 0x02
	.align 4
