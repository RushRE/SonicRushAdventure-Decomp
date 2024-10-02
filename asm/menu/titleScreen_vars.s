	.include "asm/macros.inc"
	.include "global.inc"

    .bss

.public TitleScreenRenderCallbackList
TitleScreenRenderCallbackList: // 0x02162E8C
    .space 16 * 4 * 0x04
	.align 4

.public TitleScreenRenderCallbackCount
TitleScreenRenderCallbackCount: // 0x02162F8C
    .space 0x02
	.align 4
