	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
	
.public _0210EA44
_0210EA44: // 0x0210EA44
    .byte 0x3D, 0x21
	.align 4

.public EffectButtonPrompt_animIDs
EffectButtonPrompt_animIDs:
	.hword 1, 0
	.align 4

	.data

aNsbta: // 0x02118F8C
	.asciz ".nsbta"
	.align 4

aNsbva: // 0x02118F94
	.asciz ".nsbva"
	.align 4

aNsbca: // 0x02118F9C
	.asciz ".nsbca"
	.align 4

aNsbtp: // 0x02118FA4
	.asciz ".nsbtp"
	.align 4

aNsbma: // 0x02118FAC
	.asciz ".nsbma"
	.align 4

	.data

// TODO: move this? probably not supposed to be here!!
.public _02118FB4
_02118FB4: // 0x02118FB4
	.word aActAcEffIceKir, aActAcEffWaterK

.public _02118FBC
_02118FBC: // 0x02118FBC
	.word aNsbca, aNsbma, aNsbtp, aNsbta, aNsbva

.public _02118FD0
_02118FD0:
	.hword 0x1D, 0x16, 0x20, 9, 0x1D, 0x24, 0x16, 0x20, 9, 0x24

aActAcEffIceKir: // 0x02118FE4
	.asciz "/act/ac_eff_ice_kira.bac"
	.align 4
	
aActAcEffWaterK: // 0x02119000
	.asciz "/act/ac_eff_water_kira.bac"
	.align 4
	
aNsbmd: // 0x0211901C
	.asciz ".nsbmd"
	.align 4