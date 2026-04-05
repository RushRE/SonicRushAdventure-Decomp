	.include "asm/macros.inc"
	.include "global.inc"

	.rodata
	
.public word_210FA0C
word_210FA0C: // 0x0210FA0C
	.hword 51, 52

.public word_210FA10
word_210FA10: // 0x0210FA10
	.hword 54, 51, 55

.public word_210FA16
word_210FA16: // 0x0210FA16
	.hword 49, 46, 47

.public stru_210FA1C
stru_210FA1C: // 0x0210FA1C
	.hword 0x2E // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA24
stru_210FA24: // 0x0210FA24
	.hword 0x37 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA2C
stru_210FA2C: // 0x0210FA2C
	.hword 0x39 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA34
stru_210FA34: // 0x0210FA34
	.hword 0x38 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA3C
stru_210FA3C: // 0x0210FA3C
	.hword 0x32 // navTailsSequence
	.align 4
	.word 1                   // dword4

.public stru_210FA44
stru_210FA44: // 0x0210FA44
	.hword 0x3A // navTailsSequence
	.align 4
	.word 2                   // dword4

.public byte_210FA4C
byte_210FA4C: // 0x0210FA4C
	.byte 0x19

.public byte_210FA4D
byte_210FA4D: // 0x0210FA4D
	.byte 3  
	.byte 0x1A
	.byte    3
	.byte 0x1B
	.byte    3
	.byte 0x1C
	.byte    2
	.byte 0x1C
	.byte    2
	.byte    0
	.byte    0

.public stru_210FA58
stru_210FA58: // 0x0210FA58
	.hword 0x2F // navTailsSequence
	.align 4
	.word 0 // dword4
	.hword 0x30 // navTailsSequence
	.align 4
	.word 1 // dword4

.public stru_210FA68
stru_210FA68: // 0x0210FA68
	.hword 0x33 // navTailsSequence
	.align 4
	.word 0 // dword4
	.hword 0x34 // navTailsSequence
	.align 4
	.word 1 // dword4

.public byte_210FA78
byte_210FA78: // 0x0210FA78
	.byte 0x67, 0x6B, 0x6F, 0x73, 0x77, 0x7B, 0, 0, 0xF, 0xF, 0xF
	.byte 0x65, 0x69, 0x6D, 0x71, 0x75, 0x79, 0, 0, 0xF, 0xF, 0xF
	.align 4

.public dword_210FA90
dword_210FA90: // 0x0210FA90
	.word 0, 0, 0, 0, 0, 0, 0, 0

.public dword_210FAB0
dword_210FAB0: // 0x0210FAB0
	.word 0, 0, 0, 0, 0, 0, 1, 1

.public dword_210FAD0
dword_210FAD0: // 0x0210FAD0
	.word 1, 1, 1, 0, 0, 0, 0, 0

.public dword_210FAF0
dword_210FAF0: // 0x0210FAF0
	.word 0, 1, 1, 1, 1, 0, 0, 0, 0x2400600, 0x1200300, 0xC00200