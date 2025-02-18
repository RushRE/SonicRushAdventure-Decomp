	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl
.public VRAMSystem__VRAM_PALETTE_OBJ
.public VRAMSystem__VRAM_PALETTE_BG

	.bss
	
.public SeaMapCourseChangeView__02134174
SeaMapCourseChangeView__02134174: // 0x02134174
    .space 0x04

.public SeaMapView__sVars
SeaMapView__sVars: // 0x02134178
    .space 0x04

.public seaMapViewMode
seaMapViewMode: // 0x02134178
    .space 0x04

.public seaMapViewUnknown1
seaMapViewUnknown1: // 0x02134178
    .space 0x04

.public seaMapViewUnknown2
seaMapViewUnknown2: // 0x02134178
    .space 0x04

	.rodata

.public dword_210F76C
dword_210F76C: // 0x0210F76C
	.word 0x1F, 0x20

.public byte_210F774
byte_210F774: // byte_210F774
	.byte 0, 0, 1, 0, 2, 0, 0x1F, 0

.public byte_210F77C
byte_210F77C: // byte_210F77C
	.byte 0x1F, 2, 0xFF, 3, 0xE0, 3

.public word_210F782
word_210F782: // word_210F782
	// .hword PAD_BUTTON_B, PAD_BUTTON_R, PAD_BUTTON_L, 0, 0, 0, 0, 0, 0
	.hword 2, 0x100, 0x200, 0x000, 0x000, 0x000, 0x000, 0x000, 0x000

.public SeaMapView__VoyageDistance
SeaMapView__VoyageDistance: // SeaMapView__VoyageDistance
	.word 0x58, 0xB0, 0x90, 0xB0

.public stru_210F7A4
stru_210F7A4: // stru_210F7A4
    .hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback1	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback2	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback3	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback4	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback5	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback6	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback7	// callback

	.hword 0                   			// priority
	.align 4
	.word SeaMapView__ButtonCallback8	// callback

.public stru_210F7E4
stru_210F7E4: // 0x0210F7E4
	.byte 47, 56, 65, 74, 83, 92// animIDs
	.byte 0, 0
	.byte 4                   // oamOrder
	.byte 0                   // field_9
	.byte 0                   // field_A
	.byte 0                   // field_B
	.word 2                   // vramPixels
	.hword 0x80               // x
	.hword 0x52               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

	.byte 50, 59, 68, 77, 86, 95// animIDs
	.byte 0, 0
	.byte 4                   // oamOrder
	.byte 0                   // field_9
	.byte 0                   // field_A
	.byte 0                   // field_B
	.word 3                   // vramPixels
	.hword 0x80               // x
	.hword 0x72               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

	.byte 53, 62, 71, 80, 89, 98// animIDs
	.byte 0, 0
	.byte 4                   // oamOrder
	.byte 0                   // field_9
	.byte 0                   // field_A
	.byte 0                   // field_B
	.word 2                   // vramPixels
	.hword 0x80               // x
	.hword 0x52               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

.public stru_210F82C
stru_210F82C: // stru_210F82C
    .byte 4                   // animID
	.byte 4                   // oamOrder
	.align 4
	.word 1                   // vramPixels
	.hword 0x10               // x
	.hword 0xB0               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

	.byte 0x10                // animID
	.byte 4                   // oamOrder
	.align 4
	.word 0                   // vramPixels
	.hword 0xF0               // x
	.hword 0xB0               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

	.byte 0x13                // animID
	.byte 4                   // oamOrder
	.align 4
	.word 4                   // vramPixels
	.hword 0xD0               // x
	.hword 0xB0               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

	.byte 0xD                 // animID
	.byte 4                   // oamOrder
	.align 4
	.word 2                   // vramPixels
	.hword 0x50               // x
	.hword 0xB4               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0

	.byte 0xA                 // animID
	.byte 4                   // oamOrder
	.align 4
	.word 3                   // vramPixels
	.hword 0x94               // x
	.hword 0xB4               // y
	.byte 1, 2, 3             // paletteRows
	.byte 0