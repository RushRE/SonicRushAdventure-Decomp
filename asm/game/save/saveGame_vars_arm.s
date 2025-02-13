	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public _021107B4
_021107B4: // 0x021107B4
    .hword 0x4D, 0xFFFF, 0x4E, 0xFFFF, 0x4F

.public _021107BE
_021107BE: // 0x021107BE
    .hword 0, 1, 1, 1, 0

.public _021107C8
_021107C8: // 0x021107C8
    .hword 3, 3, 0, 0xA, 0, 1 // SaveGame::Unknown2119CCC

.public _021107D4
_021107D4: // 0x021107D4
    .hword 5, 0x10, 0, 0x28, 0, 1 // SaveGame::Unknown2119CCC

.public _021107E0
_021107E0: // 0x021107E0
    .hword 0xB, 0xE, 0, 0x1E, 0, 1 // SaveGame::Unknown2119CCC

.public _021107EC
_021107EC: // 0x021107EC
    .hword 3, 6, 0, 0xD, 0, 1 // SaveGame::Unknown2119CCC

.public _021107F8
_021107F8: // 0x021107F8
    .hword 2, 1, 0, 0x10, 0, 1 // SaveGame::Unknown2119CCC

.public _02110804
_02110804: // 0x02110804
    .hword 0, 1, 0, 0x38, 0, 1 // SaveGame::Unknown2119CCC

.public _02110810
_02110810: // 0x02110810
    .hword 2, 3, 0, 0x31, 0, 1 // SaveGame::Unknown2119CCC

.public _0211081C
_0211081C: // 0x0211081C
    .hword 6, 0, 0, 0x11, 0, 1 // SaveGame::Unknown2119CCC

.public _02110828
_02110828: // 0x02110828
    .hword 3, 0xB, 0, 0x20, 0, 1 // SaveGame::Unknown2119CCC

.public _02110834
_02110834: // 0x02110834
    .hword 5, 3, 0, 0xB, 0, 1 // SaveGame::Unknown2119CCC

.public _02110840
_02110840: // 0x02110840
    .hword 5, 6, 0, 0xE, 0, 1 // SaveGame::Unknown2119CCC

.public _0211084C
_0211084C: // 0x0211084C
    .hword 5, 0x12, 9, 0, 0, 1

.public _02110858
_02110858: // 0x02110858
    .hword 5, 0x14, 0, 0x2D, 0, 1

.public _02110864
_02110864: // 0x02110864
    .hword 3, 0x17, 0, 0x3E, 0, 1 // SaveGame::Unknown2119CCC

.public _02110870
_02110870: // 0x02110870
    .hword 3, 4, 0, 0xC, 0, 1 // SaveGame::Unknown2119CCC

.public _0211087C
_0211087C: // 0x0211087C
    .hword 3, 0x13, 9, 0, 0, 1 // SaveGame::Unknown2119CCC

.public _02110888
_02110888: // 0x02110888
    .hword 3, 9, 9, 0, 0, 1 // SaveGame::Unknown2119CCC

.public _02110894
_02110894: // 0x02110894
    .hword 3, 0x15, 0, 0x3A, 0, 1 // SaveGame::Unknown2119CCC

.public _021108A0
_021108A0: // 0x021108A0
    .hword 3, 0xE, 0, 0x26, 0, 1 // SaveGame::Unknown2119CCC

.public _021108AC
_021108AC: // 0x021108AC
    .byte 0xB, 0, 0xC, 0, 0, 0, 0x2A, 0, 0, 0, 1, 0

.public _021108B8
_021108B8: // 0x021108B8
    .hword 2, 2, 0, 0x25, 0, 1 // SaveGame::Unknown2119CCC

.public _021108C4
_021108C4: // 0x021108C4
    .hword 3, 0xD, 0, 0x21, 0, 1 // SaveGame::Unknown2119CCC

.public _021108D0
_021108D0: // 0x021108D0
    .hword 3, 0x10, 0, 0x27, 0, 1 // SaveGame::Unknown2119CCC

.public _021108DC
_021108DC: // 0x021108DC
    .hword 0, 1, 1, 4, 1, 1, 0

.public _021108EA
_021108EA: // 0x021108EA
    .hword 0x44, 0x45, 0x47, 0x48, 0x49, 0x4B, 0x4C

.public _021108F8
_021108F8: // 0x021108F8
    .hword 3, 0xA, 0, 0x16, 0, 1 // SaveGame::Unknown2119CCC
    .hword 3, 0xA, 0, 0x18, 0, 1 // SaveGame::Unknown2119CCC

.public _02110910
_02110910: // 0x02110910
    .hword 5, 0xD, 0, 0x22, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 0xD, 0, 0x23, 0, 1 // SaveGame::Unknown2119CCC

.public _02110928
_02110928: // 0x02110928
    .hword 3, 0x15, 5, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0, 0, 0, 0x32, 0, 1 // SaveGame::Unknown2119CCC

.public _02110940
_02110940: // 0x02110940
    .hword 0, 0, 4, 0, 0, 0 // SaveGame::Unknown2119CCC
    .hword 0, 0, 0, 7, 0, 1 // SaveGame::Unknown2119CCC

.public SaveGame__hiddenIslandList
SaveGame__hiddenIslandList: // 0x02110958
    .hword 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38

.public SaveGame__UnknownTable1
SaveGame__UnknownTable1: // 0x02110974
    .word SaveGame__UpdateProgress1_Func_205CB60
    .word SaveGame__UpdateProgress1_Func_205CBC4
    .word SaveGame__UpdateProgress1_Func_205CBD0
    .word SaveGame__UpdateProgress1_Func_205CBDC
    .word SaveGame__UpdateProgress1_Func_205CBE8
    .word SaveGame__UpdateProgress1_Func_205CBF4
    .word SaveGame__UpdateProgress1_Func_205CC04
    .word SaveGame__UpdateProgress1_Func_205CC3C

.public _02110994
_02110994: // 0x02110994
    .hword 5, 0xA, 0, 0x1A, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 0xA, 4, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0, 0, 0, 0x1B, 0, 1 // SaveGame::Unknown2119CCC

.public SaveGame__UnknownTable2
SaveGame__UnknownTable2: // 0x021109B8
    .word SaveGame__UpdateProgress2_Type0
    .word SaveGame__UpdateProgress2_Type1
    .word SaveGame__UpdateProgress2_Type2
    .word SaveGame__UpdateProgress2_Type3
    .word SaveGame__UpdateProgress2_Type4
    .word SaveGame__UpdateProgress2_Type5
    .word SaveGame__UpdateProgress2_Type6
    .word SaveGame__UpdateProgress2_Type7
    .word SaveGame__UpdateProgress2_Type8
    .word SaveGame__UpdateProgress2_Type9
    .word SaveGame__UpdateProgress2_Type10
    .word SaveGame__UpdateProgress2_Type11

.public SaveGame__ProgressCheckTable
SaveGame__ProgressCheckTable: // 0x021109E8
    .word SaveGame__ProgressCheck_Type0
    .word SaveGame__ProgressCheck_Type1
    .word SaveGame__ProgressCheck_Type2
    .word SaveGame__ProgressCheck_Type3
    .word SaveGame__ProgressCheck_Type4
    .word SaveGame__ProgressCheck_Type5
    .word SaveGame__ProgressCheck_Type6
    .word SaveGame__ProgressCheck_Type7
    .word SaveGame__ProgressCheck_Type8
    .word SaveGame__ProgressCheck_Type9
    .word SaveGame__ProgressCheck_Type10
    .word SaveGame__ProgressCheck_Type11

.public _02110A18
_02110A18: // 0x02110A18
    .byte 5, 0, 0x13, 0, 0, 0, 0x2B, 0, 0, 0, 1, 0, 5, 0, 0x13
    .byte 0, 6, 0, 1, 0, 0, 0, 1, 0, 5, 0, 0x13, 0, 0, 0, 0x2C
    .byte 0, 0, 0, 1, 0, 5, 0, 0x13, 0, 7, 0, 0x11, 0, 0, 0
    .byte 1, 0

.public _02110A48
_02110A48: // 0x02110A48
    .hword 1, 0, 2, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 2, 0, 0, 8, 0, 1 // SaveGame::Unknown2119CCC
    .hword 2, 0, 3, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 3, 0, 0, 9, 0, 1 // SaveGame::Unknown2119CCC

.public _02110A78
_02110A78: // 0x02110A78
    .hword 3, 0x15, 5, 1, 0, 0 // SaveGame::Unknown2119CCC
    .hword 3, 0x15, 0, 0x3B, 0, 1 // SaveGame::Unknown2119CCC
    .hword 3, 0x15, 0, 0x3C, 0, 1 // SaveGame::Unknown2119CCC
    .hword 3, 0x15, 0, 0x3D, 0, 1 // SaveGame::Unknown2119CCC

.public _02110AA8
_02110AA8: // 0x02110AA8
    .hword 5, 0x17, 0, 0x3F, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 0x17, 0, 0x40, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 0x17, 0, 0x41, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 0x17, 7, 0x18, 0, 1 // SaveGame::Unknown2119CCC

.public _02110AD8
_02110AD8: // 0x02110AD8
    .hword 5, 9, 0, 0x12, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 9, 0, 0x13, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 9, 6, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 9, 0, 0x14, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 9, 0, 0x15, 0, 1 // SaveGame::Unknown2119CCC
    .hword 5, 9, 7, 7, 0, 1 // SaveGame::Unknown2119CCC

.public _02110B20
_02110B20: // 0x02110B20
    .hword 9, 2, 4, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 6, 2, 3, 0
    .hword 1, 1, 1, 2, 0, 0, 1, 0, 0, 1, 1, 2, 1, 0, 1, 4, 1
    .hword 4, 0, 0, 0, 0, 0

.public _02110B70
_02110B70: // 0x02110B70
    .hword 0xFFFF, 0, 4, 7, 0xB, 0xE, 0x11, 0x15, 0x18, 0xFFFF
    .hword 9, 0x13, 0xFFFF, 0xFFFF, 0xFFFF, 0x19, 0x1A, 0x1B
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0x1C, 0x1D, 0x1E, 0x1F
    .hword 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0xFFFF, 0xFFFF
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF

.public SaveGame__nextStage
SaveGame__nextStage: // 0x02110BC4
    .hword 1, 3, 2, 3, 5, 6, 6, 8, 10, 9, 10, 12, 13, 13, 15
    .hword 16, 16, 18, 20, 19, 20, 22, 23, 23, 24, 25, 26, 27
    .hword 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40
    .hword 41, 42, 0, 0, 0

.public _02110C20
_02110C20: // 0x02110C20
    .byte 3, 0xFF, 0xFF, 1, 3, 0xFF, 0xFF, 2, 0, 0xFF, 0xFF
    .byte 0, 4, 0xFF, 0xFF, 0, 6, 0xFF, 0xFF, 1, 6, 0xFF, 0xFF
    .byte 2, 7, 0xFF, 0xFF, 0, 0xE, 0xFF, 0xFF, 1, 0xE, 0xFF
    .byte 0xFF, 2, 0xD, 0xFF, 0xFF, 0, 0xF, 0xFF, 0xFF, 0, 0x13
    .byte 0xFF, 0xFF, 1, 0x13, 0xFF, 0xFF, 2, 0x14, 0xFF, 0xFF
    .byte 0, 0xFF, 2, 0xFF, 3, 0xFF, 2, 0xFF, 4, 0xFF, 3, 0xFF
    .byte 0, 0xFF, 0xFF, 4, 5, 0xFF, 0xFF, 4, 6, 0xFF, 0xFF
    .byte 3, 0, 0xFF, 0xFF, 5, 0, 0x21, 0xFF, 0xFF, 1, 0x21
    .byte 0xFF, 0xFF, 2, 0x22, 0xFF, 0xFF, 0, 0x23, 0xFF, 0xFF
    .byte 0

.public _02110C84
_02110C84: // 02110C84
    .hword 0xD, 0, 0, 1, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 0, 2, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 0, 3, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 0, 4, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 4, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 0, 5, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 1, 0, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 0, 6, 0, 1 // SaveGame::Unknown2119CCC
    .hword 0xD, 0, 4, 0, 0, 0 // SaveGame::Unknown2119CCC

.public SaveGame_ShipUnlockProgress
SaveGame_ShipUnlockProgress: // 0x02110CF0
    .word 2, 9, 22, 26

.public _02110D00
_02110D00: // 0x02110D00
    .hword 8, 0, 0, 0x18, 4, 0, 0x1A, 4, 6

.public _02110D12
_02110D12: // 0x02110D12
    .hword 0, 0, 4, 1, 4, 6, 1, 2, 4, 1, 0, 2

.public _02110D2A
_02110D2A: // 0x02110D2A
    .hword 1, 2, 3, 4, 5, 6, 7, 8, 0xA, 0xB, 0xC, 0xE, 0xF, 0x10, 0x11

.public _02110D48
_02110D48: // 0x02110D48
    .hword 2, 5, 0          // SaveGame::Unknown205D65C
    .hword 5, 8, 0          // SaveGame::Unknown205D65C
    .hword 0xE, 0x10, 0     // SaveGame::Unknown205D65C
    .hword 0x12, 0x15, 0    // SaveGame::Unknown205D65C
    .hword 0x17, 0x19, 1    // SaveGame::Unknown205D65C
    .hword 0x17, 0x19, 2    // SaveGame::Unknown205D65C
    .hword 0x1A, 0x23, 0    // SaveGame::Unknown205D65C
    .hword 0x23, 0x24, 0    // SaveGame::Unknown205D65C
    .hword 0xA, 0xE, 0      // SaveGame::Unknown205D65C
    .hword 0x17, 0x19, 3    // SaveGame::Unknown205D65C
    .hword 0x17, 0x19, 4    // SaveGame::Unknown205D65C
    .hword 0x11, 0x12, 0    // SaveGame::Unknown205D65C
    .hword 0x1D, 0x1E, 0    // SaveGame::Unknown205D65C
    .hword 0x1D, 0x1E, 0    // SaveGame::Unknown205D65C
    .hword 0x1D, 0x1E, 0    // SaveGame::Unknown205D65C

	.data
	
.public SaveGame__unknownProgress1Unknown
SaveGame__unknownProgress1Unknown:
	.word 0x00000000, 0x021108A0, 0x021108D0, 0x021107D4, 0x00000000

.public SaveGame__unknownProgress2Unknown
SaveGame__unknownProgress2Unknown:
	.word 0x00000000, 0x21108AC, 0x211087C, 0x2110A18, 0x211084C, 0x2110858, 0x00000000

.public SaveGame__gameProgressUnknown
SaveGame__gameProgressUnknown:
	.word 0x02110C84, 0x02110940, 0x02110A48, 0x021107C8
	.word 0x02110834, 0x02110870, 0x021107EC, 0x02110840
	.word 0x00000000, 0x00000000, 0x021107F8, 0x0211081C
	.word 0x02110888, 0x02110AD8, 0x021108F8, 0x02110994
	.word 0x00000000, 0x021107E0, 0x02110828, 0x021108C4
	.word 0x02110910, 0x00000000, 0x00000000, 0x021108B8
	.word 0x00000000, 0x00000000, 0x00000000, 0x02110810
	.word 0x02110928, 0x02110804, 0x00000000, 0x02110894
	.word 0x02110A78, 0x02110864, 0x02110AA8, 0x00000000 
	.word 0x00000000, 0x00000000, 0x00000000, 0x00000000

aSonicRush2: // 0x02119D6C
	.asciz "sonic_rush2"