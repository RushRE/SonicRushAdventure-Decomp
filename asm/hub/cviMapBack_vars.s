	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
	
.public ovl05_02172F1C
ovl05_02172F1C: // 0x02172F1C
    .hword 128, 114
	.hword 208, 40
	.hword 160, 201
	.hword 204, 146
	.hword 76, 170
	.hword 236, 122
	.hword 0, 0
	.hword 112, 0
	.hword 93, 95
	.hword 0, 80
	.hword 50, 36
	.hword 80, 80
	.hword 0, 0
	.hword 128, 160
	.hword 128, 160

.public ovl05_02172F58
ovl05_02172F58: // 0x02172F58
    .hword 140, 122
	.hword 228, 52
	.hword 168, 209
	.hword 204, 122
	.hword 76, 146
	.hword 236, 98
	.hword 72, 24
	.hword 136, 16
	.hword 101, 103
	.hword 56, 112
	.hword 54, 44
	.hword 94, 95
	.hword 16, 80
	.hword 140, 176
	.hword 140, 176
	
.public ovl05_02172F94
ovl05_02172F94: // 0x02172F94
    .word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word ViMapBack__Func_2162CB8
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word ViMapBack__Func_2162E90
	.word 0
	.word 0
	
.public ovl05_02172FD0
ovl05_02172FD0: // 0x02172FD0
    .word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word ViMapBack__Func_2162E54
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word ViMapBack__Func_2162F2C
	.word 0
	.word 0

.public ViMapBack__OamOrderList
ViMapBack__OamOrderList: // 0x0217300C
	.byte 30, 30, 30, 29, 30, 30, 30, 30, 30, 30, 30, 30, 29, 0, 0, 0

aBbViMapBackBb: // 0x0217301C
	.asciz "bb/vi_map_back.bb"
	.align 4