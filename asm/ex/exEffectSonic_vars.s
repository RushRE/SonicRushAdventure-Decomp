	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public exEffectBarrierHitTask__ActiveInstanceCount
exEffectBarrierHitTask__ActiveInstanceCount: // 0x02176484
	.space 0x02

.public exEffectBarrierTask__ActiveInstanceCount
exEffectBarrierTask__ActiveInstanceCount: // 0x02176486
	.space 0x02

.public exExEffectSonicBarrierTaMeTask__ActiveInstanceCount
exExEffectSonicBarrierTaMeTask__ActiveInstanceCount: // 0x02176488
	.space 0x02

	.align 4

.public exExEffectSonicBarrierTaMeTask__dword_217648C
exExEffectSonicBarrierTaMeTask__dword_217648C: // 0x0217648C
    .space 0x04
	
.public exEffectBarrierTask__unk_2176490
exEffectBarrierTask__unk_2176490: // 0x02176490
    .space 0x04
	
.public exEffectBarrierTask__unk_2176494
exEffectBarrierTask__unk_2176494: // 0x02176494
    .space 0x04

.public exEffectBarrierHitTask__unk_2176498
exEffectBarrierHitTask__unk_2176498: // 0x02176498
    .space 0x04
	
.public exExEffectSonicBarrierTaMeTask__dword_217649C
exExEffectSonicBarrierTaMeTask__dword_217649C: // 0x0217649C
    .space 0x04
	
.public exEffectBarrierHitTask__dword_21764A0
exEffectBarrierHitTask__dword_21764A0: // 0x021764A0
    .space 0x04
	
.public exExEffectSonicBarrierTaMeTask__unk_21764A4
exExEffectSonicBarrierTaMeTask__unk_21764A4: // 0x021764A4
    .space 0x04
	
.public exEffectBarrierHitTask__TaskSingleton
exEffectBarrierHitTask__TaskSingleton: // 0x021764A8
    .space 0x04
	
.public exEffectBarrierTask__TaskSingleton
exEffectBarrierTask__TaskSingleton: // 0x021764AC
    .space 0x04
	
.public exExEffectSonicBarrierTaMeTask__unk_21764B0
exExEffectSonicBarrierTaMeTask__unk_21764B0: // 0x021764B0
    .space 0x04
	
.public exEffectBarrierTask__dword_21764B4
exEffectBarrierTask__dword_21764B4: // 0x021764B4
    .space 0x04
	
.public exExEffectSonicBarrierTaMeTask__TaskSingleton
exExEffectSonicBarrierTaMeTask__TaskSingleton: // 0x021764B8
    .space 0x04
	
.public exEffectBarrierHitTask__unk_21764BC
exEffectBarrierHitTask__unk_21764BC: // 0x021764BC
    .space 0x04
	
.public exEffectBarrierHitTask__unk_21764C0
exEffectBarrierHitTask__unk_21764C0: // 0x021764C0
    .space 0x04
	
.public exEffectBarrierHitTask__unk_21764C4
exEffectBarrierHitTask__unk_21764C4: // 0x021764C4
    .space 0x04
	
.public exExEffectSonicBarrierTaMeTask__FileTable
exExEffectSonicBarrierTaMeTask__FileTable: // 0x021764C8
    .space 0x04 * 2
	
.public exEffectBarrierHitTask__AnimTable
exEffectBarrierHitTask__AnimTable: // 0x021764D0
    .space 0x04 * 3
	
.public exEffectBarrierHitTask__FileTable
exEffectBarrierHitTask__FileTable: // 0x021764DC
    .space 0x04 * 3

	.data
	
.public _0217441C
_0217441C:
	.float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 0.0, 0.0, 0.0

aExtraExBb_7: // 0x02174464
	.asciz "/extra/ex.bb"
	.align 4
	
aExeffectbarrie: // 0x02174474
	.asciz "exEffectBarrierHitTask"
	.align 4
	
aExeffectbarrie_0: // 0x0217448C
	.asciz "exEffectBarrierTask"
	.align 4

aExexeffectsoni: // 0x021744A0
	.asciz "exExEffectSonicBarrierTaMeTask"
	.align 4