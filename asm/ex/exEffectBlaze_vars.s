	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public exExEffectBlzFireTaMeTask__ActiveInstanceCount
exExEffectBlzFireTaMeTask__ActiveInstanceCount: // 0x021764E8
	.space 0x02

.public exEffectBlzFireTask__ActiveInstanceCount
exEffectBlzFireTask__ActiveInstanceCount: // 0x021764EA
	.space 0x02

.public exEffectBlzFireShotTask__ActiveInstanceCount
exEffectBlzFireShotTask__ActiveInstanceCount: // 0x021764EC
	.space 0x02

	.align 4

.public exEffectBlzFireTask__FileTable
exEffectBlzFireTask__FileTable: // 0x021764F0
    .space 0x04
	
.public exEffectBlzFireTask__TaskSingleton
exEffectBlzFireTask__TaskSingleton: // 0x021764F4
    .space 0x04
	
.public exEffectBlzFireShotTask__unk_21764F8
exEffectBlzFireShotTask__unk_21764F8: // 0x021764F8
    .space 0x04
	
.public exEffectBlzFireShotTask__unk_21764FC
exEffectBlzFireShotTask__unk_21764FC: // 0x021764FC
    .space 0x04
	
.public exEffectBlzFireShotTask__unk_2176500
exEffectBlzFireShotTask__unk_2176500: // 0x02176500
    .space 0x04
	
.public exExEffectBlzFireTaMeTask__TaskSingleton
exExEffectBlzFireTaMeTask__TaskSingleton: // 0x02176504
    .space 0x04
	
.public exEffectBlzFireShotTask__dword_2176508
exEffectBlzFireShotTask__dword_2176508: // 0x02176508
    .space 0x04
	
.public exExEffectBlzFireTaMeTask__dword_217650C
exExEffectBlzFireTaMeTask__dword_217650C: // 0x0217650C
    .space 0x04
	
.public exExEffectBlzFireTaMeTask__unk_2176510
exExEffectBlzFireTaMeTask__unk_2176510: // 0x02176510
    .space 0x04
	
.public exExEffectBlzFireTaMeTask__unk_2176514
exExEffectBlzFireTaMeTask__unk_2176514: // 0x02176514
    .space 0x04
	
.public exExEffectBlzFireTaMeTask__unk_2176518
exExEffectBlzFireTaMeTask__unk_2176518: // 0x02176518
    .space 0x04

.public exExEffectBlzFireTaMeTask__unk_217651C
exExEffectBlzFireTaMeTask__unk_217651C: // 0x0217651C
    .space 0x04
	
.public exEffectBlzFireShotTask__dword_2176520
exEffectBlzFireShotTask__dword_2176520: // 0x02176520
    .space 0x04
	
.public exEffectBlzFireShotTask__TaskSingleton
exEffectBlzFireShotTask__TaskSingleton: // 0x02176524
    .space 0x04
	
.public exExEffectBlzFireTaMeTask__FileTable
exExEffectBlzFireTaMeTask__FileTable: // 0x02176528
    .space 0x04 * 2
	
.public exEffectBlzFireShotTask__AnimTable
exEffectBlzFireShotTask__AnimTable: // 0x02176530
    .space 0x04 * 4
	
.public exEffectBlzFireShotTask__FileTable
exEffectBlzFireShotTask__FileTable: // 0x02176540
    .space 0x04 * 4

	.data

.public _021744C0
_021744C0:
    .float 0.1, 0.1, 0.1, 1.5, 1.5, 0.0, 0.2, 0.2, 0.2, 2.0, 2.0, 0.0, 0.3, 0.3, 0.3, 3.5
	.float 3.5, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0.0, 0.0, 0.0, 2.5, 2.5
	.float 2.5, 0.0, 0.0, 0.0

aExtraExBb_8: // 0x02174550
	.asciz "/extra/ex.bb"
	.align 4
	
aExeffectblzfir: // 0x02174560
	.asciz "exEffectBlzFireTask"
	.align 4

aExexeffectblzf: // 0x02174574
	.asciz "exExEffectBlzFireTaMeTask"
	.align 4
	
aExeffectblzfir_0: // 0x02174590
	.asciz "exEffectBlzFireShotTask"
	.align 4