	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public exBossEffectHomingTask__ActiveInstanceCount
exBossEffectHomingTask__ActiveInstanceCount: // 0x02175FC4
	.space 0x02

.public exBossEffectFireTask__ActiveInstanceCount
exBossEffectFireTask__ActiveInstanceCount: // 0x02175FC6
    .space 0x02
	
.public exBossEffectShotTask__ActiveInstanceCount
exBossEffectShotTask__ActiveInstanceCount: // 0x02175FC8
    .space 0x02

.public exBossEffectHitTask__ActiveInstanceCount
exBossEffectHitTask__ActiveInstanceCount: // 0x02175FCA
    .space 0x02

.public exBossEffectFireBallTask__ActiveInstanceCount
exBossEffectFireBallTask__ActiveInstanceCount: // 0x02175FCC
    .space 0x02

.public exBossEffectFireBallShotTask__ActiveInstanceCount
exBossEffectFireBallShotTask__ActiveInstanceCount: // 0x02175FCE
    .space 0x02

	.align 4

.public exBossEffectHitTask__unk_2175FD0
exBossEffectHitTask__unk_2175FD0: // 0x02175FD0
    .space 0x04

.public exBossEffectHitTask__unk_2175FD4
exBossEffectHitTask__unk_2175FD4: // 0x02175FD4
    .space 0x04

.public exBossEffectFireBallShotTask__unk_2175FD8
exBossEffectFireBallShotTask__unk_2175FD8: // 0x02175FD8
    .space 0x04

.public exBossEffectHitTask__unk_2175FDC
exBossEffectHitTask__unk_2175FDC: // 0x02175FDC
    .space 0x04

.public exBossEffectShotTask__dword_2175FE0
exBossEffectShotTask__dword_2175FE0: // 0x02175FE0
    .space 0x04

.public exBossEffectShotTask__unk_2175FE4
exBossEffectShotTask__unk_2175FE4: // 0x02175FE4
    .space 0x04

.public exBossEffectFireTask__TaskSingleton
exBossEffectFireTask__TaskSingleton: // 0x02175FE8
    .space 0x04

.public exBossEffectFireTask__unk_2175FEC
exBossEffectFireTask__unk_2175FEC: // 0x02175FEC
    .space 0x04

.public exBossEffectFireTask__unk_2175FF0
exBossEffectFireTask__unk_2175FF0: // 0x02175FF0
    .space 0x04
	
.public exBossEffectFireBallTask__dword_2175FF4
exBossEffectFireBallTask__dword_2175FF4: // 0x02175FF4
    .space 0x04

.public exBossEffectFireTask__Ptr_2175FF8
exBossEffectFireTask__Ptr_2175FF8: // 0x02175FF8
    .space 0x04

.public exBossEffectFireTask__unk_2175FFC
exBossEffectFireTask__unk_2175FFC: // 0x02175FFC
    .space 0x04

.public exBossEffectHitTask__unk_2176000
exBossEffectHitTask__unk_2176000: // 0x02176000
    .space 0x04

.public exBossEffectShotTask__unk_2176004
exBossEffectShotTask__unk_2176004: // 0x02176004
    .space 0x04

.public exBossEffectShotTask__TaskSingleton
exBossEffectShotTask__TaskSingleton: // 0x02176008
    .space 0x04

.public exBossEffectShotTask__unk_217600C
exBossEffectShotTask__unk_217600C: // 0x0217600C
    .space 0x04

.public exBossEffectFireBallShotTask__unk_2176010
exBossEffectFireBallShotTask__unk_2176010: // 0x02176010
    .space 0x04

.public exBossEffectShotTask__unk_2176014
exBossEffectShotTask__unk_2176014: // 0x02176014
    .space 0x04

.public exBossEffectShotTask__unk_2176018
exBossEffectShotTask__unk_2176018: // 0x02176018
    .space 0x04

.public exBossEffectShotTask__dword_217601C
exBossEffectShotTask__dword_217601C: // 0x0217601C
    .space 0x04

.public exBossEffectHitTask__dword_2176020
exBossEffectHitTask__dword_2176020: // 0x02176020
    .space 0x04

.public exBossEffectHomingTask__unk_2176024
exBossEffectHomingTask__unk_2176024: // 0x02176024
    .space 0x04

.public exBossEffectHomingTask__TaskSingleton
exBossEffectHomingTask__TaskSingleton: // 0x02176028
    .space 0x04

.public exBossEffectHomingTask__unk_217602C
exBossEffectHomingTask__unk_217602C: // 0x0217602C
    .space 0x04

.public exBossEffectHomingTask__dword_2176030
exBossEffectHomingTask__dword_2176030: // 0x02176030
    .space 0x04

.public exBossEffectHomingTask__unk_2176034
exBossEffectHomingTask__unk_2176034: // 0x02176034
    .space 0x04

.public exBossEffectHomingTask__unk_2176038
exBossEffectHomingTask__unk_2176038: // 0x02176038
    .space 0x04
	
.public exBossEffectHomingTask__unk_217603C
exBossEffectHomingTask__unk_217603C: // 0x0217603C
    .space 0x04

.public exBossEffectHomingTask__dword_2176040
exBossEffectHomingTask__dword_2176040: // 0x02176040
    .space 0x04

.public exBossEffectHomingTask__unk_2176044
exBossEffectHomingTask__unk_2176044: // 0x02176044
    .space 0x04

.public exBossEffectFireBallTask__TaskSingleton
exBossEffectFireBallTask__TaskSingleton: // 0x02176048
    .space 0x04

.public exBossEffectFireBallTask__unk_217604C
exBossEffectFireBallTask__unk_217604C: // 0x0217604C
    .space 0x04

.public exBossEffectFireTask__Value_2176050
exBossEffectFireTask__Value_2176050: // 0x02176050
    .space 0x04

.public exBossEffectHitTask__dword_2176054
exBossEffectHitTask__dword_2176054: // 0x02176054
    .space 0x04

.public exBossEffectFireBallTask__unk_2176058
exBossEffectFireBallTask__unk_2176058: // 0x02176058
    .space 0x04

.public exBossEffectFireBallTask__Ptr_217605C
exBossEffectFireBallTask__Ptr_217605C: // 0x0217605C
    .space 0x04

.public exBossEffectHitTask__TaskSingleton
exBossEffectHitTask__TaskSingleton: // 0x02176060
    .space 0x04

.public exBossEffectFireBallTask__unk_2176064
exBossEffectFireBallTask__unk_2176064: // 0x02176064
    .space 0x04

.public exBossEffectFireBallShotTask__TaskSingleton
exBossEffectFireBallShotTask__TaskSingleton: // 0x02176068
    .space 0x04

.public exBossEffectFireBallShotTask__unk_217606C
exBossEffectFireBallShotTask__unk_217606C: // 0x0217606C
    .space 0x04

.public exBossEffectFireBallShotTask__unk_2176070
exBossEffectFireBallShotTask__unk_2176070: // 0x02176070
    .space 0x04

.public exBossEffectFireBallShotTask__unk_2176074
exBossEffectFireBallShotTask__unk_2176074: // 0x02176074
    .space 0x04

.public exBossEffectFireBallShotTask__FileTable
exBossEffectFireBallShotTask__FileTable: // 0x02176078
    .space 0x04 * 2

.public exBossEffectHitTask__FileTable
exBossEffectHitTask__FileTable: // 0x02176080
    .space 0x04 * 2

.public exBossEffectShotTask__AnimTable
exBossEffectShotTask__AnimTable: // 0x02176088
    .space 0x04 * 2

.public exBossEffectShotTask__FileTable
exBossEffectShotTask__FileTable: // 0x02176090
    .space 0x04 * 2

.public exBossEffectFireBallShotTask__AnimTable
exBossEffectFireBallShotTask__AnimTable: // 0x02176098
    .space 0x04 * 2

.public exBossEffectHitTask__AnimTable
exBossEffectHitTask__AnimTable: // 0x021760A0
    .space 0x04 * 2

.public exBossEffectHomingTask__FileTable
exBossEffectHomingTask__FileTable: // 0x021760A8
    .space 0x04 * 4

.public exBossEffectFireTask__AnimTable
exBossEffectFireTask__AnimTable: // 0x021760B8
    .space 0x04 * 4

.public exBossEffectFireBallTask__AnimTable
exBossEffectFireBallTask__AnimTable: // 0x021760C8
    .space 0x04 * 4

.public exBossEffectFireTask__FileTable
exBossEffectFireTask__FileTable: // 0x021760D8
    .space 0x04 * 4

.public exBossEffectFireBallTask__FileTable
exBossEffectFireBallTask__FileTable: // 0x021760E8
    .space 0x04 * 4

.public exBossEffectHomingTask__AnimTable
exBossEffectHomingTask__AnimTable: // 0x021760F8
    .space 0x04 * 4

	.data
	
aExtraExBb_2: // 0x02173FC4
	.asciz "/extra/ex.bb"
	.align 4
	
aExbosseffecthi: // 0x02173FD4
	.asciz "exBossEffectHitTask"
	.align 4

aExbosseffectfi_0: // 0x02173FE8
	.asciz "exBossEffectFireBallShotTask"
	.align 4
	
aExbosseffectfi_1: // 0x02174008
	.asciz "exBossEffectFireBallTask"
	.align 4
	
aExbosseffectho: // 0x02174024
	.asciz "exBossEffectHomingTask"
	.align 4
	
aExbosseffectsh: // 0x0217403C
	.asciz "exBossEffectShotTask"
	.align 4
	
aExbosseffectfi: // 0x02174054
	.asciz "exBossEffectFireTask"
	.align 4