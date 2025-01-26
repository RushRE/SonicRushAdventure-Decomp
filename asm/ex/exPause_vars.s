	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public exPauseTask__word_2177B98
exPauseTask__word_2177B98: // 0x02177B98
    .space 0x02

	.align 4
	
.public exPauseTask__TaskSingleton
exPauseTask__TaskSingleton: // 0x02177B9C
    .space 0x04
	
	.data
	
.public exPauseTask__02175DEC
exPauseTask__02175DEC:
	.hword 89, 94, 99, 104, 109, 114
	
.public exPauseTask__02175DF8
exPauseTask__02175DF8:
	.hword 90, 95, 100, 105, 110, 115
	.hword 91, 96, 101, 106, 111, 116
	
.public exPauseTask__02175E10
exPauseTask__02175E10:
	.hword 92, 97, 102, 107, 112, 117
	.hword 93, 98, 103, 108, 113, 118

aExpausetask: // 0x02175E28
	.asciz "exPauseTask"