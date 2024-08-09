	.include "asm/macros.inc"
	.include "global.inc"

	.data
	
.public RegularShield__matList
RegularShield__matList:
    .byte 0, 4, 5, 1, 2, 3
	.align 4

.public RegularShield__shpList
RegularShield__shpList:
    .byte 3, 4, 5, 2, 0, 1
	.align 4

.public MagnetShield__matList
MagnetShield__matList:
    .byte 4, 5, 6, 7, 2, 1, 3, 0, 8
	.align 4

.public MagnetShield__shpList
MagnetShield__shpList:
    .byte 1, 2, 3, 4, 5, 6, 0, 7, 8
	.align 4

.public PlayerTrail__mtxIdentity
PlayerTrail__mtxIdentity:
    .word 0x1000, 0, 0, 0, 0x1000, 0, 0, 0, 0x1000