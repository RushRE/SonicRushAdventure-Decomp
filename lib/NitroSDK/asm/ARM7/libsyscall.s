	.include "asm/macros.inc"
	.include "global.inc"

	.text
    
    thumb_func_start SVC_SoftReset
SVC_SoftReset: // 0x038044E4
	swi 0
	bx lr
	thumb_func_end SVC_SoftReset

	thumb_func_start SVC_WaitByLoop
SVC_WaitByLoop: // 0x038044E8
	swi 3
	bx lr
	thumb_func_end SVC_WaitByLoop

	thumb_func_start SVC_WaitIntr
SVC_WaitIntr: // 0x038044EC
	ldr r2, _038044F8 // =0x04000000
	mov ip, r2
	mov r2, #0
	swi 4
	bx lr
	.align 2, 0
_038044F8: .word 0x04000000
	thumb_func_end SVC_WaitIntr

	thumb_func_start SVC_WaitVBlankIntr
SVC_WaitVBlankIntr: // 0x038044FC
	mov r2, #0
	swi 5
	bx lr
	thumb_func_end SVC_WaitVBlankIntr

	non_word_aligned_thumb_func_start SVC_Halt
SVC_Halt: // 0x03804502
	swi 6
	bx lr
	thumb_func_end SVC_Halt

	non_word_aligned_thumb_func_start SVC_Stop
SVC_Stop: // 0x03804506
	swi 7
	bx lr
	thumb_func_end SVC_Stop

	non_word_aligned_thumb_func_start SVC_SoundBias
SVC_SoundBias: // 0x0380450A
	swi 8
	bx lr
	thumb_func_end SVC_SoundBias

	non_word_aligned_thumb_func_start SVC_SoundBiasSet
SVC_SoundBiasSet: // 0x0380450E
	mov r1, r0
	mov r0, #1
	swi 8
	bx lr
	thumb_func_end SVC_SoundBiasSet

	non_word_aligned_thumb_func_start SVC_SoundBiasReset
SVC_SoundBiasReset: // 0x03804516
	mov r1, r0
	mov r0, #0
	swi 8
	bx lr
	thumb_func_end SVC_SoundBiasReset

	non_word_aligned_thumb_func_start SVC_Div
SVC_Div: // 0x0380451E
	swi 9
	bx lr
	thumb_func_end SVC_Div

	non_word_aligned_thumb_func_start SVC_DivRem
SVC_DivRem: // 0x03804522
	swi 9
	mov r0, r1
	bx lr
	thumb_func_end SVC_DivRem

	thumb_func_start SVC_CpuSet
SVC_CpuSet: // 0x03804528
	swi 0xb
	bx lr
	thumb_func_end SVC_CpuSet

	thumb_func_start SVC_CpuFastSet
SVC_CpuFastSet: // 0x0380452C
	swi 0xc
	bx lr
	thumb_func_end SVC_CpuFastSet

	thumb_func_start SVC_Sqrt
SVC_Sqrt: // 0x03804530
	swi 0xd
	bx lr
	thumb_func_end SVC_Sqrt

	thumb_func_start SVC_GetCRC16
SVC_GetCRC16: // 0x03804534
	swi 0xe
	bx lr
	thumb_func_end SVC_GetCRC16

	thumb_func_start SVC_IsDebugger
SVC_IsDebugger: // 0x03804538
	swi 0xf
	bx lr
	thumb_func_end SVC_IsDebugger

	thumb_func_start SVC_BitUnPack
SVC_BitUnPack: // 0x0380453C
	swi 0x10
	bx lr
	thumb_func_end SVC_BitUnPack

	thumb_func_start SVC_LZ77UnCompWram
SVC_LZ77UnCompWram: // 0x03804540
	swi 0x11
	bx lr
	thumb_func_end SVC_LZ77UnCompWram

	thumb_func_start SVC_LZ77UnCompVramWithReadCB
SVC_LZ77UnCompVramWithReadCB: // 0x03804544
	swi 0x12
	bx lr
	thumb_func_end SVC_LZ77UnCompVramWithReadCB

	thumb_func_start SVC_HuffUnCompWithReadCB
SVC_HuffUnCompWithReadCB: // 0x03804548
	swi 0x13
	bx lr
	thumb_func_end SVC_HuffUnCompWithReadCB

	thumb_func_start SVC_RLUnCompWram
SVC_RLUnCompWram: // 0x0380454C
	swi 0x14
	bx lr
	thumb_func_end SVC_RLUnCompWram

	thumb_func_start SVC_RLUnCompVramWithReadCB
SVC_RLUnCompVramWithReadCB: // 0x03804550
	swi 0x15
	bx lr
	thumb_func_end SVC_RLUnCompVramWithReadCB

	thumb_func_start SVC_GetSineTable
SVC_GetSineTable: // 0x03804554
	swi 0x1a
	bx lr
	thumb_func_end SVC_GetSineTable

	thumb_func_start SVC_GetPitchTable
SVC_GetPitchTable: // 0x03804558
	swi 0x1b
	bx lr
	thumb_func_end SVC_GetPitchTable

	thumb_func_start SVC_GetVolumeTable
SVC_GetVolumeTable: // 0x0380455C
	swi 0x1c
	bx lr
	thumb_func_end SVC_GetVolumeTable