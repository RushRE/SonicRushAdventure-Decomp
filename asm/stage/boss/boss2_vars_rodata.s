	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
		
.public Boss2__ballNames
Boss2__ballNames: // 0x02179C80
    .word aBallAHit           // "ball_a_hit"
	.word aBallBHit           // "ball_b_hit"
	.word aBallCHit           // "ball_c_hit"

.public Boss2__ballScales
Boss2__ballScales: // 0x02179C8C
    .word 0x1A660, 0x2E328, 0x41FF0
	
.public Boss2Stage__State2_215C938_camUp
Boss2Stage__State2_215C938_camUp: // 0x02179C98
    .word 0, 0x1000, 0

.public Boss2__hitFXScaleTable
Boss2__hitFXScaleTable: // 0x02179CA4
    .word 0x4000, 0x6000, 0x8000
	
.public Boss2Stage__State2_215CD08_camUp
Boss2Stage__State2_215CD08_camUp: // 0x02179CB0
    .word 0, 0x1000, 0
    
.public Boss2__Unused2179CBC
Boss2__Unused2179CBC: // 0x02179CB0
	.word 0x3000, 0x4000, 0x5000

.public _02179CC8
_02179CC8: // 0x02179CC8
    .word 0x1A660, 0x2E328, 0x41FF0
	
.public Boss2__activeArmCountTable
Boss2__activeArmCountTable: // 0x02179CD4
    .word 0, 1, 2, 2

.public Boss2__ballHitboxes
Boss2__ballHitboxes: // 0x02179CE4
    .hword 0xFFF0, 0xFFF0, 0x10, 0x10
    .hword 0xFFE8, 0xFFE8, 0x18, 0x18
    .hword 0xFFE0, 0xFFE0, 0x20, 0x20

.public Boss2__damageModifierTable
Boss2__damageModifierTable: // 0x02179CFC
    .word 0x300020, 0x200080, 0x800030, 0x300020, 0x200080, 0x800030
	
.public Boss2__spinSpeeds
Boss2__spinSpeeds: // 0x02179D14
    .hword 0x60, 0x40, 0x20, 
    .hword 0x80, 0x60, 0x40, 
    .hword 0xA0, 0x80, 0x60
	.hword 0xC0, 0xA0, 0x80

.public Boss2__UnknownConfig1
Boss2__UnknownConfig1: // 0x02179D2C
    .hword 0, 0
    .hword 0, 0
    .hword 360, 255
    .hword 300, 255

    .hword 300, 511
    .hword 300, 255
    .hword 240, 255
    .hword 180, 255

.public Boss2__UnknownConfig2
Boss2__UnknownConfig2: // 0x02179D4C
    .hword 0, 0
    .hword 0, 0
    .hword 0, 0
    .hword 300, 127
    
    .hword 0, 0
    .hword 0, 0
    .hword 240, 255
    .hword 180, 255

.public Boss2__ballConfigTable
Boss2__ballConfigTable: // 0x02179D6C
    .hword 0, 0
    .hword 0, 0
    .hword 0, 0
    
    .hword 60, 180
    .hword 0, 0
    .hword 0, 0
    
    .hword 60, 180
    .hword 120, 180
    .hword 0, 0
    
    .hword 60, 180
    .hword 120, 180
    .hword 180, 180