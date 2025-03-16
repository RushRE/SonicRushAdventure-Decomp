	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public SteamPipe__dword_2188390
SteamPipe__dword_2188390: // 0x02188390
    .word 0xA000, 0xA000      
	
.public SteamPipe__dword_2188398
SteamPipe__dword_2188398: // SteamPipe__dword_2188398
    .word 0x800, 0x800        
	
.public FlowerPipe__dword_21883A0
FlowerPipe__dword_21883A0: // FlowerPipe__dword_21883A0
    .word 0, 0                
	
.public FlowerPipe__dword_21883A8
FlowerPipe__dword_21883A8: // FlowerPipe__dword_21883A8
    .word 0x10000, 0x20000

	.data
	
.public FlowerPipe__dword_2188F2C
FlowerPipe__dword_2188F2C:
	.word 0xFFFFA800, 0xFFFFA000, 0xFFFF9800, 0xFFFFA000, 0xFFFFA800

.public FlowerPipe__dword_2188F40
FlowerPipe__dword_2188F40:
	.word 0x5000, 0x5800, 0x6000, 0x6800, 0x7000

.public FlowerPipe__dword_2188F54
FlowerPipe__dword_2188F54:
	.word 0xFFFFD000, 0xFFFFD800, 0, 0x2800, 0x3000

.public FlowerPipe__dword_2188F68
FlowerPipe__dword_2188F68:
	.word 0xFFFFA000, 0xFFFF9000, 0xFFFFA000, 0xFFFF9000, 0xFFFFA000

aActAcGmkPipeFl_0: // 0x02188F7C
	.asciz "/act/ac_gmk_pipe_flw.bac"
	.align 4
	
aActAcGmkPipeSt: // 0x02188F98
	.asciz "/act/ac_gmk_pipe_steam.bac"
	.align 4