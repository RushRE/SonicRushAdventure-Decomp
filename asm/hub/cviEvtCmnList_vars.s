	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public CViEvtCmnList__keyRepeatRepeatTime
CViEvtCmnList__keyRepeatRepeatTime: // 0x021731C4
	.hword 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

.public CViEvtCmnList__MissionTextLockedPalette
CViEvtCmnList__MissionTextLockedPalette: // 0x021731DC
    .hword 0x662E, 0x4147, 0x1C60
	
.public CViEvtCmnList__MissionTextClearedPalette
CViEvtCmnList__MissionTextClearedPalette: // 0x021731E2
    .hword 0x37F, 0x278, 0x144 
	
.public CViEvtCmnList__MovieTextLockedPalette
CViEvtCmnList__MovieTextLockedPalette: // 0x021731E8
    .hword 0x178, 0x1EF, 0xC7 
	
.public CViEvtCmnList__MovieTextClearedPalette
CViEvtCmnList__MovieTextClearedPalette: // 0x021731EE
    .hword 0x178, 0x1EF, 0xC7
	
.public CViEvtCmnList__keyRepeatInitialTime
CViEvtCmnList__keyRepeatInitialTime: // 0x021731F4
	.hword 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20
