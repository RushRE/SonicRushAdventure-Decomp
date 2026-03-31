	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.rodata
	
.public SeaMapStylusIcon_AnimIDs
SeaMapStylusIcon_AnimIDs: // 0x0210FF80
	.hword 125, 126, 127

.public SeaMapSparkles__AnimIDs1
SeaMapSparkles__AnimIDs1: // 0x0210FF86
	.hword 140, 143, 144, 147

.public SeaMapSparkles__AnimIDs2
SeaMapSparkles__AnimIDs2: // 0x0210FF8E
	.hword 141, 142, 145, 146

.public SeaMapBoatIcon__shipAnimIDs
SeaMapBoatIcon__shipAnimIDs: // 0x0210FF96
	.hword 0, 1, 2, 3, 0