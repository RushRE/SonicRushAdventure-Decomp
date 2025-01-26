	.include "asm/macros.inc"
	.include "global.inc"

	.bss

// .public exSysTask__Value_2178644
.public exSysTask__sVars
exSysTask__sVars: // 0x02178644
    .space 0x04

.public exSysTask__Singleton
exSysTask__Singleton: // 0x02178648
    .space 0x04
	
.public exSysTask__TaskSingleton
exSysTask__TaskSingleton: // 0x0217864C
    .space 0x04
	
.public exSysTask__Flag_2178650
exSysTask__Flag_2178650: // 0x02178650
    .space 0x04
	
.public exSysTask__Flag_2178654
exSysTask__Flag_2178654: // 0x02178654
    .space 0x04
	
.public exSysTask__Flag_2178658
exSysTask__Flag_2178658: // 0x02178658
    .space 0x01
	
.public exSysTask__unk_2178659
exSysTask__unk_2178659: // 0x02178659
    .space 0x01
	
.public exSysTask__byte_217865A
exSysTask__byte_217865A: // 0x0217865A
    .space 0x01
	
.public exSysTask__byte_217865B
exSysTask__byte_217865B: // 0x0217865B
    .space 0x01
	
.public exSysTask__byte_217865C
exSysTask__byte_217865C: // 0x0217865C
    .space 0x01

	.align 2

.public exSysTask__word_217865E
exSysTask__word_217865E: // 0x0217865E
    .space 0x02
	
exSysTask__dword_2178660: // 0x02178660
    .space 0x04 * 3