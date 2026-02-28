	.include "asm/macros.inc"
	.include "global.inc"

.public BossArena__explosionFXSpawnTime

	.bss

.public Boss3Stage__TaskSingleton
Boss3Stage__TaskSingleton: // 0x0217AF88
	.space 0x04

.public Boss3__PlayerDrawFunc
Boss3__PlayerDrawFunc: // 0x0217AF8C
	.space 0x04

.public Boss3__Unused217AF90
Boss3__Unused217AF90: // 0x0217AF8C
	.space 0x20

	.rodata
	
.public _02179D9C
_02179D9C: // 0x02179D9C
    .byte 0, 1, 2, 3

.public _02179DA0
_02179DA0: // 0x02179DA0
    .hword 3, 9
	
.public _02179DA4
_02179DA4: // 0x02179DA4
    .hword 0x5555, 0x5555, 0x5555

.public _02179DAA
_02179DAA: // 0x02179DAA
	.hword 0, 1, 2

.public _02179DB0
_02179DB0: // 0x02179DB0
    .hword 0x333, 0x200, 0xCC

.public _02179DB6
_02179DB6: // 0x02179DB6
    .hword 0x5999, 0x5999, 0x4CCC
	
.public _02179DBC
_02179DBC: // 0x02179DBC
    .hword 0xE3, 0x111, 0x13E, 0x16C
	
.public _02179DC4
_02179DC4: // 0x02179DC4
    .hword 0x30, 0x30, 0x30, 0x30
	
.public _02179DCC
_02179DCC: // 0x02179DCC
    .word 0x1000, 0xCCC
	
.public _02179DD4
_02179DD4: // 0x02179DD4
    .hword 136, 136, 136, 136
	
.public _02179DDC
_02179DDC: // 0x02179DDC
    .hword 182, 182, 182, 182
	
.public _02179DE4
_02179DE4: // 0x02179DE4
    .hword 60, 60, 60, 60
	
.public _02179DEC
_02179DEC: // 0x02179DEC
    .hword 27, 26, 25, 24

.public _02179DF4
_02179DF4: // 0x02179DF4
    .hword 50, 110, 25, 80, 1, 0
	
.public _02179E00
_02179E00: // 0x02179E00
    .word 0, 0x1000, 0

.public _02179E0C
_02179E0C: // 0x02179E0C
    .hword 0xFFFF, 0
    .hword 0xB332, 0x4CCC
    .hword 0x4CCC, 0xB332
    .hword 0, 0xFFFF
	
.public _02179E1C
_02179E1C: // 0x02179E1C
    .word 0x333, 0x666, 0x999, 0xCCC
	
.public _02179E2C
_02179E2C: // 0x02179E2C
    .hword 3, 3
    .hword 3, 3
    .hword 3, 4
    .hword 3, 4
	
.public _02179E3C
_02179E3C: // 0x02179E3C
    .word 0x2000, 0xAAA, 0xFFFFF556, 0xFFFFE000
	
.public _02179E4C
_02179E4C: // 0x02179E4C
    .hword 0x3333, 0xCCCC
	.hword 0x4CCC, 0xB332
	.hword 0x6666, 0x9999
	.hword 0x7FFF, 0x7FFF
	
.public _02179E5C
_02179E5C: // 0x02179E5C
    .hword 0x4CCC, 0x7FFF
	.hword 0x3333, 0x6666
	.hword 0x6666, 0x6666
	.hword 0x7FFF, 0x3333
	.hword 0x4CCC, 0x9999
	.hword 0x3333, 0x3333

.public _02179E74
_02179E74: // 0x02179E74
    .word 0xD0000, 0xF000, 0
	.word 0xD7000, 0xF000, 0xFFF29000
	.word 0xFFF74000, 0xF000, 0xFFF74000
	.word 0xFFF29000, 0xF000, 0xD7000
	.word 0x96000, 0xF000, 0x104000
	
	.data

.public _0217A82C
_0217A82C: // 0x0217A82C
    .hword 0x2000, 0xE000
	
.public _0217A830
_0217A830: // 0x0217A830
    .hword 0xFFE8, 0xFFF0, 0x18, 0x18
	
.public _0217A838
_0217A838: // 0x0217A838
    .hword 0x6000, 0xE000, 0x2000, 0xA000
	
.public _0217A840
_0217A840: // 0x0217A840
    .hword 0xFFE8, 0xFFE8, 0x18, 0x18

.public _0217A848
_0217A848: // 0x0217A848
    .hword 0xFFF0, 0xFFF0, 0x10, 0x10

.public _0217A850
_0217A850: // 0x0217A850
	.hword 0, 0, 0, 0

.public _0217A858
_0217A858: // 0x0217A858
    .word _0217A970, _0217AA18, _0217AA18, _0217AA18

.public _0217A868
_0217A868: // 0x0217A868
    .hword 0xFFE6, 0xFFE8, 0x1A, 0xFFF8
    .hword 0xFFE2, 0xFFCE, 0x1E, 0x18
    .hword 0xFFE1, 0xFFF8, 0x1F, 0x18

.public _0217A880
_0217A880: // 0x0217A880
    .hword 0xFFCE, 0xFFE2, 0x10, 0xFFE8
    .hword 0xFFCE, 0xFFE2, 0x18, 0x1E
    .hword 0xFFEC, 0xFFE8, 0x14, 0x1F

.public _0217A898
_0217A898: // 0x0217A898
    .hword 0, 0, 0, 0
    .hword 0x18E3, 0, 0, 0
    .hword 0x18E3, 0xE71C, 0, 0
	.hword 0x31C7, 0xE71C, 0x18E3, 0

.public _0217A8B8
_0217A8B8: // 0x0217A8B8
    .word 3, 0, 2, 1
    .word 3, 2, 0, 1
    .word 3, 2, 1, 0
	
.public _0217A8E8
_0217A8E8: // 0x0217A8E8
	.word aZ3Atama1Pl         // "z3_atama1_pl"
	.word aZ3Atama2Pl         // "z3_atama2_pl"
	.word aZ3Atama3Pl         // "z3_atama3_pl"
	.word aZ3BodyPl           // "z3_body_pl"
	.word aZ3EyePl            // "z3_eye_pl"
	.word aZ3FmPl             // "z3_fm_pl"
	.word aZ3HandPl           // "z3_hand_pl"
	.word aZ3Htop1Pl          // "z3_htop1_pl"
	.word aZ3Htop2Pl          // "z3_htop2_pl"
	.word aZ3Htop3Pl          // "z3_htop3_pl"
	.word aZ3NeckPl           // "z3_neck_pl"
	.word aZ3OmemePl          // "z3_omeme_pl"
	.word aZ3RPl              // "z3_r_pl"
	.word aZ3SidePl           // "z3_side_pl"
	.word aZ3UnderPl          // "z3_under_pl"
	.word aZ3WeakpPl          // "z3_weakp_pl"

.public _0217A928
_0217A928: // 0x0217A928
    .word 0x107FC0, 0x3C000, 0x83FE0
	.word 0, 0xD2000, 0x107FC0
	.word 0x83FE0, 0x28000, 0
	.word 0x107FC0, 0x6E000, 0
	.word 0x83FE0, 0x14000, 0x107FC0
	.word 0x83FE0, 0xC8000, 0x107FC0

.public _0217A970
_0217A970: // 0x0217A970
    .word Boss3Arm__OnDefend_Regular, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__OnDefend_Regular, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168A68, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168850, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168A68, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_21688BC, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_21688BC, 0, Boss3Arm__Func_2168E34
	.word Boss3Arm__Func_21688BC, 0, Boss3Arm__Func_2168E34
	.word Boss3Arm__Func_2168A68, 0, 0
	.word Boss3Arm__Func_2168924, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168A68, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_216898C, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168A68, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168A04, 0, Boss3Arm__OnDefend_2168D6C

.public _0217AA18
_0217AA18: // 0x0217AA18
    .word Boss3Arm__OnDefend_Weakpoint, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__OnDefend_Weakpoint, 0, Boss3Arm__OnDefend_2168D6C
	.word 0, 0, 0
	.word Boss3Arm__Func_2168B4C, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168B4C, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168BD4, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168BD4, 0, Boss3Arm__Func_2168E34
	.word Boss3Arm__Func_2168BD4, 0, Boss3Arm__Func_2168EDC
	.word Boss3Arm__Func_2168BD4, 0, 0
	.word Boss3Arm__Func_2168C60, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168C60, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168CE8, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168CE8, 0, Boss3Arm__OnDefend_2168D6C
	.word Boss3Arm__Func_2168C60, 0, Boss3Arm__OnDefend_2168D6C

aZ3RPl: // 0x0217AAC0
    .asciz "z3_r_pl"
    .align 4

aZ3FmPl: // 0x0217AAC8
    .asciz "z3_fm_pl"
    .align 4

aZ3EyePl: // 0x0217AAD4
    .asciz "z3_eye_pl"
    .align 4

aZ3BodyPl: // 0x0217AAE0
    .asciz "z3_body_pl"
    .align 4

aZ3HandPl: // 0x0217AAEC
    .asciz "z3_hand_pl"
    .align 4

aZ3SidePl: // 0x0217AAF8
    .asciz "z3_side_pl"
    .align 4

aZ3NeckPl: // 0x0217AB04
    .asciz "z3_neck_pl"
    .align 4

aZ3Htop1Pl: // 0x0217AB10
    .asciz "z3_htop1_pl"
    .align 4

aZ3Htop2Pl: // 0x0217AB1C
    .asciz "z3_htop2_pl"
    .align 4

aZ3Htop3Pl: // 0x0217AB28
    .asciz "z3_htop3_pl"
    .align 4

aZ3OmemePl: // 0x0217AB34
    .asciz "z3_omeme_pl"
    .align 4

aZ3UnderPl: // 0x0217AB40
    .asciz "z3_under_pl"
    .align 4

aZ3WeakpPl: // 0x0217AB4C
    .asciz "z3_weakp_pl"
    .align 4

aZ3Atama1Pl: // 0x0217AB58
    .asciz "z3_atama1_pl"
    .align 4

aZ3Atama2Pl: // 0x0217AB68
    .asciz "z3_atama2_pl"
    .align 4

aZ3Atama3Pl: // 0x0217AB78
    .asciz "z3_atama3_pl"
    .align 4

.public aStage00
aStage00: // 0x0217AB88
    .asciz "stage_00"
    .align 4

.public aExc_3
aExc_3: // 0x0217AB94
    .asciz "exc"
    .align 4

.public aBody_0
aBody_0: // 0x0217AB98
    .asciz "body"
    .align 4

.public aMouth
aMouth: // 0x0217ABA0
    .asciz "mouth"
    .align 4

.public aArmHit
aArmHit: // 0x0217ABA8
    .asciz "arm_hit"
    .align 4
