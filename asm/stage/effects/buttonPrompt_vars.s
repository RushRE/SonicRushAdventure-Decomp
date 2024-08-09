	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public EffectButtonPrompt__states
EffectButtonPrompt__states: // 0x0210EA54
    .word EffectButtonPrompt__State_DPadUp, EffectButtonPrompt__State_JumpButton

	.data
	
aAcFixKeyLittle: // 0x02119340
	.asciz "/ac_fix_key_little.bac"
	.align 4