	.include "asm/macros.inc"
	.include "global.inc"

	.data

.public Map__CreateObjectLists
Map__CreateObjectLists: // 0x02119580
    .word EventManager__CreateStageObjects
    .word EventManager__CreateRingObjects
    .word EventManager__CreateDecorObjects

.public gm_evemgr_create_size_tbl
gm_evemgr_create_size_tbl: // 0x0211958C
    .word 0x213401E, 0x213401C, 0x2134020
