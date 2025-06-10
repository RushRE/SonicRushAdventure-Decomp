	.include "asm/macros.inc"
	.include "global.inc"


	.rodata

.public BossArena__CamFuncTable
BossArena__CamFuncTable: // 0x0210F5C4
	.word BossArena__CamFunc_Type0
	.word BossArena__CamFunc_Type1

.public BossArena__MainFuncTable
BossArena__MainFuncTable: // 0x0210F5CC
	.word BossArena__MainFunc_Type0
	.word BossArena__MainFunc_Type1
	.word BossArena__MainFunc_Type2
	.word BossArena__MainFunc_Type3
	.word BossArena__MainFunc_Type4