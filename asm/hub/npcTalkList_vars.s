	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public NpcTalkList__keyRepeatRepeatTime
NpcTalkList__keyRepeatRepeatTime: // 0x021731C4
	.hword 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

.public NpcTalkList__MissionTextLockedPalette
NpcTalkList__MissionTextLockedPalette: // 0x021731DC
    .hword 0x662E, 0x4147, 0x1C60
	
.public NpcTalkList__MissionTextClearedPalette
NpcTalkList__MissionTextClearedPalette: // 0x021731E2
    .hword 0x37F, 0x278, 0x144 
	
.public NpcTalkList__MovieTextLockedPalette
NpcTalkList__MovieTextLockedPalette: // 0x021731E8
    .hword 0x178, 0x1EF, 0xC7 
	
.public NpcTalkList__MovieTextClearedPalette
NpcTalkList__MovieTextClearedPalette: // 0x021731EE
    .hword 0x178, 0x1EF, 0xC7
	
.public NpcTalkList__keyRepeatInitialTime
NpcTalkList__keyRepeatInitialTime: // 0x021731F4
	.hword 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20
