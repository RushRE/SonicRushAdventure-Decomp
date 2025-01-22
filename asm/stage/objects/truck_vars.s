	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
	
.public Truck__byte_21885A4
Truck__byte_21885A4: // 0x021885A4
	.byte 2, 4, 1, 6, 3, 7

.public Truck__stru_21885AA
Truck__stru_21885AA: // 0x021885AA
	.hword 0x4000, 0x00000, 0xC000

.public Truck__stru_21885B0
Truck__stru_21885B0: // 0x021885B0
	.word 0x200000, 0x200000, 0x200000

.public Truck__stru_21885BC
Truck__stru_21885BC: // 0x021885BC
	.word 0x00000, 0x00000
	.word 0x40000, 0x00000
	.word 0x00000, 0x40000
	.word 0x40000, 0x40000

.public Truck__stru_21885DC
Truck__stru_21885DC: // 0x021885DC
	.word -0x30000, 0x5000, -0x50000
	.word  0x30000, 0x5000, -0x50000
	.word -0x30000, 0x5000,  0x50000
	.word  0x30000, 0x5000,  0x50000

.public Truck__TruckJewelPositionTable
Truck__TruckJewelPositionTable: // 0x0218860C
	.word -0x14000, -0xD000,   0xA000
	.word -0x8000,  -0x12000,  0x7000
	.word -0x4000,  -0xB000,   0x0000
	.word -0x14000, -0x14000,  0x0000
	.word -0xD000,  -0x15000, -0x7000
	.word -0xE000,  -0x14000,  0x0000
	.word -0xC000,  -0x19000, -0x8000
	.word -0xE000,  -0xD000,  -0xA000

.public Truck__stru_218866C
Truck__stru_218866C: // 0x0218866C
	.word -0x258000, 0x4000,  0x64000,  -0x1E000, 0x4000,  0x64000
	.word -0x258000, 0x4000, -0x32000,  -0x1E000, 0x4000, -0x32000
	.word -0x258000, 0x4000, -0x384000, -0x14000, 0x4000, -0x3C000
	.word  0x258000, 0x4000, -0x384000,  0x14000, 0x4000, -0x3C000
	.word  0x258000, 0x4000, -0x32000,   0x1E000, 0x4000, -0x32000
	.word  0x258000, 0x4000,  0x64000,   0x1E000, 0x4000,  0x64000

.public Truck__TruckJewelTypeTable
Truck__TruckJewelTypeTable: // 0x021886FC
	.byte 3, 4, 2, 0, 2, 0, 1, 1

.public Truck__TruckJewelFlagTable
Truck__TruckJewelFlagTable: // 0x02188704
	.byte 0, 0, 0, 1, 1, 0, 1, 0

	.data

.public Truck__stru_21895C0
Truck__stru_21895C0: // 0x021895C0
	.word -0x1C417, -0x64000
	.word -0x37F78, -0x871DB
	.word -0x5B153, -0xA2D3B
	.word -0xBF153, -0xBF153
	.word  0x00000, -0x76000
	.word  0x00000, -0x96000
	.word  0x00000, -0xB6000
	.word  0x00000, -0x96000
	.word  0x1C417, -0x64000
	.word  0x37F78, -0x871DB
	.word  0x5B153, -0xA2D3B
	.word  0xBF153, -0xBF153

aActAcGmkTruckB_0: // 0x02189620
	.asciz "/act/ac_gmk_truck.bac"
	.align 4
	
aModGmkTruckNsb: // 0x02189638
	.asciz "/mod/gmk_truck.nsbmd"
	.align 4
	
aActAcItmRing3d_0: // 0x02189650
	.asciz "/act/ac_itm_ring3d.bac"
	.align 4
	
aActAcGmkTruckC: // 0x02189668
	.asciz "/act/ac_gmk_truck_candle3d.bac"
	.align 4
	
aBpaGmkTruckCan: // 0x02189688
	.asciz "/bpa/gmk_truck_candle.bpa"
	.align 4
	
aActAcItmBox3dB: // 0x021896A4
	.asciz "/act/ac_itm_box3d.bac"
	.align 4
	
aActAcGmkTruckB_1: // 0x021896BC
	.asciz "/act/ac_gmk_truck_bomb3d.bac"
	.align 4
	
aActAcGmkTruckS: // 0x021896DC
	.asciz "/act/ac_gmk_truck_spike3d.bac"
	.align 4
	
aActAcGmkTruckL: // 0x021896FC
	.asciz "/act/ac_gmk_truck_lava.bac"
	.align 4
	
aBpaGmkTruckLav: // 0x02189718
	.asciz "/bpa/gmk_truck_lava.bpa"
	.align 4