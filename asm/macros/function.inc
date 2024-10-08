#pragma once

	.macro arm_func_start name
	.type \name,@function
	.balign 4, 0
	.global \name
	.arm
	.endm

	.macro local_arm_func_start name
	.type \name,@function
	.balign 4, 0
	.arm
	.endm

	.macro arm_func_end name
	.size \name, .-\name
	.endm

	.macro thumb_func_start name
	.type \name,@function
	.balign 4, 0
	.global \name
	.thumb
	.endm

	.macro non_word_aligned_thumb_func_start name
	.type \name,@function
	.global \name
	.thumb
	.endm

	.macro thumb_func_end name
	.size \name, .-\name
	.endm

