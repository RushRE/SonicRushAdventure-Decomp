	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss
	
.public exMsgTitleTask__TaskSingleton
exMsgTitleTask__TaskSingleton: // 0x021775B8
    .space 0x04
	
.public exMsgTutorialTask__TaskSingleton
exMsgTutorialTask__TaskSingleton: // 0x021775BC
    .space 0x04

.public exMsgTitleTask__byte_21775C0
exMsgTitleTask__byte_21775C0: // 0x021775C0
	.space 0x88

.public exMsgTitleTask__byte_2177648
exMsgTitleTask__byte_2177648: // 0x02177648
	.space 0x88

.public exMsgTitleTask__byte_21776D0
exMsgTitleTask__byte_21776D0: // 0x021776D0
	.space 0x88

.public exMsgTitleTask__byte_2177758
exMsgTitleTask__byte_2177758: // 0x02177758
	.space 0x88

.public exMsgTitleTask__byte_21777E0
exMsgTitleTask__byte_21777E0: // 0x021777E0
	.space 0x88

.public exMsgTitleTask__byte_2177868
exMsgTitleTask__byte_2177868: // 0x02177868
	.space 0x88

.public exMsgTitleTask__byte_21778F0
exMsgTitleTask__byte_21778F0: // 0x021778F0
	.space 0x88

.public exMsgTitleTask__byte_2177978
exMsgTitleTask__byte_2177978: // 0x02177978
	.space 0x88

.public exMsgTitleTask__byte_2177A00
exMsgTitleTask__byte_2177A00: // 0x02177A00
	.space 0x88

.public exMsgTitleTask__byte_2177A88
exMsgTitleTask__byte_2177A88: // 0x02177A88
	.space 0x88

.public exMsgTitleTask__byte_2177B10
exMsgTitleTask__byte_2177B10: // 0x02177B10
	.space 0x88

	.data
	
aExmsgtitletask: // 0x02175DDC
	.asciz "exMsgTitleTask"