	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public SaveGame__SaveDataCallbacks
SaveGame__SaveDataCallbacks: // 0x02110DA4
    .word SaveGame__SaveSaveCallback_OnlineProfile

.public SaveGame__LoadDataCallbacks
SaveGame__LoadDataCallbacks: // 0x02110DA8
    .word SaveGame__SaveLoadCallback_Unknown

.public SaveGame__ClearDataCallbacks
SaveGame__ClearDataCallbacks: // 0x02110DAC
    .word SeaMapManager__SaveClearCallback_Chart, SaveGame__SaveClearCallback_Stage, SaveGame__SaveClearCallback_Common

.public savedataBlockSizes
savedataBlockSizes: // 0x02110DB8
    .word 0, 0x28, 0x1A8, 0x6C8, 0x474, 0x12C, 0x18, 0x3C8, 0x850

.public _02110DDC
_02110DDC: // 0x02110DDC
    .word 0, 0, 0x80, 0x400, 0x1200, 0x1B00, 0x1D80, 0x1E00, 0x2600

.public savedataBlockOffsets
savedataBlockOffsets: // 0x02110E00
    .word 0, 0, 0x28, 0x1D0, 0x898, 0xD0C, 0xE38, 0xE50, 0x1218

	.data
	
.public aSonic
aSonic: // 0x2119D78
	// "UTF-16LE", "SONIC"
	// |
	// v
	.byte 0x53, 0x00, 0x4F, 0x00, 0x4E, 0x00, 0x49, 0x00
	.byte 0x43, 0x00, 0x00, 0x00