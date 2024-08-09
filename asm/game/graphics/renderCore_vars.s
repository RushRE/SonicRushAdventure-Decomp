	.include "asm/macros.inc"
	.include "global.inc"

    .rodata
	
.public VRAMSystem__VRAM_BG
VRAMSystem__VRAM_BG: // 0x02111FA8
	// VRAM_BG_A, VRAM_BG_B
    .word 0x6000000, 0x6200000
	
.public VRAMSystem__VRAM_OBJ
VRAMSystem__VRAM_OBJ: // 0x02111FB0
	// VRAM_OBJ_A, VRAM_OBJ_B
	.word 0x6400000, 0x6600000

.public VRAMSystem__BGControllers
VRAMSystem__BGControllers: // 0x02111FB8
	// reg_G2_BG0CNT, reg_G2_BG1CNT, reg_G2_BG2CNT, reg_G2_BG3CNT, reg_G2S_DB_BG0CNT, reg_G2S_DB_BG1CNT, reg_G2S_DB_BG2CNT, reg_G2S_DB_BG3CNT
    .word 0x4000008, 0x400000A, 0x400000C, 0x400000E, 0x4001008, 0x400100A, 0x400100C, 0x400100E