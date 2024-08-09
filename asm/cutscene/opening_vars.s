	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public Opening__RenderCallbackList
Opening__RenderCallbackList: // 0x02162F90
    .space 16 * 0x10
	.align 4

.public Opening__RenderCallbackCount
Opening__RenderCallbackCount: // 0x02163090
    .space 0x02
	.align 4

	.rodata

.public OpeningBlazeNameSprite__LetterAniList
OpeningBlazeNameSprite__LetterAniList: // 0x021616FC
    .hword 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 16, 0
	
.public Opening__animOffsetList
Opening__animOffsetList: // 0x02161714
    .word 0, 8, 16, 25, 40, 49

.public Opening__sceneTypeList
Opening__sceneTypeList: // 0x0216172C
	.word 0, 0, 0, 0, 1, 0

.public OpeningSonicNameSprite__LetterAniList
OpeningSonicNameSprite__LetterAniList: // 0x02161744
    .hword 0, 1, 2, 3, 4, 5, 6, 7, 6, 7, 8, 9, 7, 6, 10, 9

.public OpeningBlazeNameSprite__LetterPositions
OpeningBlazeNameSprite__LetterPositions: // 0x02161764
	.hword 0xD4, 0xC8
	.hword 0xD4, 0xEC
	.hword 0xD4, 0x110
	.hword 0xD4, 0x137
	.hword 0xD4, 0x15A
	.hword 0xAC, 0x11B
	.hword 0xAC, 0x129
	.hword 0xAC, 0x138
	.hword 0xAC, 0x150
	.hword 0xAC, 0x160
	.hword 0xAC, 0x170

.public OpeningSonicNameSprite__LetterPositions
OpeningSonicNameSprite__LetterPositions: // 0x02161790
	.hword 0x2C, 0xB4
	.hword 0x2C, 0x8E
	.hword 0x2C, 0x67
	.hword 0x2C, 0x3E
	.hword 0x2C, 0x2C
	.hword 0x54, 0xA7
	.hword 0x54, 0x9A
	.hword 0x54, 0x8C
	.hword 0x54, 0x78
	.hword 0x54, 0x6A
	.hword 0x54, 0x5F
	.hword 0x54, 0x50
	.hword 0x54, 0x41
	.hword 0x54, 0x35
	.hword 0x54, 0x28
	.hword 0x54, 0x18

.public Opening__sceneAnimatorList
Opening__sceneAnimatorList: // 0x021617D0
    .word 0, 2, 3, 4, 5, 6, 7, 9, 0, 0, 0, 0, 0, 0, 0
	.word 0, 3, 4, 5, 6, 7, 9, 10, 0, 0, 0, 0, 0, 0, 0
	.word 0, 1, 3, 4, 5, 6, 7, 9, 10, 0, 0, 0, 0, 0, 0
	.word 0, 1, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16
	.word 0, 3, 4, 5, 6, 7, 9, 10, 8, 0, 0, 0, 0, 0, 0
