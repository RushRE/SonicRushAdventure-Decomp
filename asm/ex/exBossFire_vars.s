	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

// .public exBossFireBlueTask__ActiveInstanceCount
.public exBossFireTask__sVars
exBossFireTask__sVars: // 0x02176108
    .space 0x02

.public exBossFireRedTask__ActiveInstanceCount
exBossFireRedTask__ActiveInstanceCount: // 0x0217610A
    .space 0x02

	.align 4

.public exBossFireRedTask__unk_217610C
exBossFireRedTask__unk_217610C: // 0x0217610C
    .space 0x04
	
.public exBossFireRedTask__TaskSingleton
exBossFireRedTask__TaskSingleton: // 0x02176110
    .space 0x04
	
.public exBossFireBlueTask__TaskSingleton
exBossFireBlueTask__TaskSingleton: // 0x02176114
    .space 0x04
	
.public exBossFireRedTask__dword_2176118
exBossFireRedTask__dword_2176118: // 0x02176118
    .space 0x04
	
.public exBossFireRedTask__unk_217611C
exBossFireRedTask__unk_217611C: // 0x0217611C
    .space 0x04
	
.public exBossFireBlueTask__unk_2176120
exBossFireBlueTask__unk_2176120: // 0x02176120
    .space 0x04
	
.public exBossFireRedTask__unk_2176124
exBossFireRedTask__unk_2176124: // 0x02176124
    .space 0x04
	
.public exBossFireRedTask__unk_2176128
exBossFireRedTask__unk_2176128: // 0x02176128
    .space 0x04
	
.public exBossFireBlueTask__dword_217612C
exBossFireBlueTask__dword_217612C: // 0x0217612C
    .space 0x04
	
.public exBossFireBlueTask__unk_2176130
exBossFireBlueTask__unk_2176130: // 0x02176130
    .space 0x04
	
.public exBossFireBlueTask__unk_2176134
exBossFireBlueTask__unk_2176134: // 0x02176134
    .space 0x04
	
.public exBossFireBlueTask__unk_2176138
exBossFireBlueTask__unk_2176138: // 0x02176138
    .space 0x04
	
.public exBossFireRedTask__FileTable
exBossFireRedTask__FileTable: // 0x0217613C
    .space 0x04 * 4
	
.public exBossFireRedTask__AnimTable
exBossFireRedTask__AnimTable: // 0x0217614C
    .space 0x04 * 4
	
.public exBossFireBlueTask__AnimTable
exBossFireBlueTask__AnimTable: // 0x0217615C
    .space 0x04 * 4
	
.public exBossFireBlueTask__FileTable
exBossFireBlueTask__FileTable: // 0x0217616C
    .space 0x04 * 4
	
	.data
	
aExtraExBb_3: // 0x0217406C
	.asciz "/extra/ex.bb"
	.align 4