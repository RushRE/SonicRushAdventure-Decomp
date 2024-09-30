	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public _02161514
_02161514: // 0x02161514
    .byte 190, 180, 170, 160, 150, 140, 130, 120
	
.public _0216151C
_0216151C: // 0x0216151C
    .byte 15, 20, 25, 30, 35, 40, 45, 50
	
.public _02161524
_02161524: // 0x02161524
    .word 10000, 15000, 20000, 25000, 30000, 34000, 38000, 42000, 45000

.public _02161548
_02161548: // 0x02161548
    .word 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000

    .data
    
aNarcPldm6700Lz: // 0x021629D4
	.asciz "/narc/pldm_67_00_lz7.narc"
	.align 4

aNarcCldmExLz7N: // 0x021629F0
	.asciz "/narc/cldm_ex_lz7.narc"
	.align 4