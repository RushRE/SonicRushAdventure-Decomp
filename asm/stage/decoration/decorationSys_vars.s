	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public DecorationSys__rangeTable
DecorationSys__rangeTable: // 0x0218766C
    .hword 0x32, 0x40
	
.public DecorationSys__offsetTable
DecorationSys__offsetTable: // 0x02187670
    .hword 0xFC00, 0xFB00
	
.public DecorationSys__rectList
DecorationSys__rectList: // 0x02187674
    .byte 0xD0, 0xE0, 0, 0
	.byte 0xEC, 0xEC, 0x14, 0
	.byte 0, 0xF0, 0x10, 0x10
	.byte 0xF0, 0xF0, 0x10, 0
	.byte 0x10, 0xD0, 0x30, 0
	.byte 4, 0xE0, 0x20, 0xF8
	.byte 8, 0, 0x30, 0x30
	.byte 8, 8, 0x1A, 0x20
	.byte 0, 0xE0, 0x10, 0
	.byte 0, 0xD0, 0x20, 0
	.byte 0, 0xE0, 0x20, 0

.public DecorationSys__initTable
DecorationSys__initTable: // 0x021876A0
    .word 0
	.word DecorationSys__InitFunc_21538D0
	.word DecorationSys__InitFunc_2154030
	.word DecorationSys__InitFunc_2154150
	.word DecorationSys__InitFunc_2154194
	.word DecorationSys__InitFunc_2154294
	.word DecorationSys__InitFunc_21543E8
	.word DecorationSys__InitFunc_2154478
	.word DecorationSys__InitFunc_2154510
	.word DecorationSys__InitFunc_2154C90
	.word DecorationSys__InitFunc_2154D2C

.public _021876CC
_021876CC: // 0x021876CC
    .byte 0, 1, 2, 0, 1, 2, 0, 1

.public _021876D4
_021876D4: // 0x021876D4
    .byte 0x17, 0, 3, 3, 0x48, 0, 9, 0, 0x17, 0, 4, 4, 0x48
	.byte 0, 0xA, 0, 0x17, 0, 5, 5, 0x48, 0, 0xB, 0

// DecorAsset[]
.public decorAssets
decorAssets: // 0x021876EC
	.word aActAcGmkFlipmu_1
	.hword 0
	.align 4

	.word aActAcDecGrassB
	.hword 1
	.align 4

	.word aActAcDecFlwBac
	.hword 2
	.align 4

	.word aActAcDecKinoko
	.hword 3
	.align 4

	.word aActAcDecKinoko_0
	.hword 4
	.align 4

	.word aActAcDecPalmBa
	.hword 5
	.align 4

	.word aActAcDecPipeFl
	.hword 6
	.align 4

	.word aActAcEffWaterB_2
	.hword 7
	.align 4

	.word aActAcDecSuimen
	.hword 8
	.align 4

	.word aActAcDecBigLea
	.hword 9
	.align 4

	.word aActAcDecFlwTub
	.hword 0xA
	.align 4

	.word aActAcDecMoBac
	.hword 0xB
	.align 4

	.word aActAcDecGstTre
	.hword 0xC
	.align 4

	.word aActAcDecCloudB
	.hword 0xD
	.align 4

	.word aActAcDecPipeSt
	.hword 0
	.align 4

	.word aActAcDecDecopi
	.hword 1
	.align 4

	.word aActAcDecChimne
	.hword 2
	.align 4

	.word aActAcDecCoralB_0
	.hword 0
	.align 4

	.word aActAcDecBoatBa
	.hword 0
	.align 4

	.word aActAcDecCannon
	.hword 1
	.align 4

	.word aActAcDecMastBa
	.hword 2
	.align 4

	.word aActAcDecRudder
	.hword 3
	.align 4

	.word aActAcDecRopeBa
	.hword 4
	.align 4

	.word aActAcDecAnchor
	.hword 5
	.align 4

	.word aActAcGmkBarrel_0
	.hword 6
	.align 4

	.word aActAcDecSailBa
	.hword 7
	.align 4

	.word aActAcDecTrampo
	.hword 8
	.align 4

	.word aActAcDecSakuBa_0
	.hword 9
	.align 4

	.word aActAcDecIcicle
	.hword 0
	.align 4

	.word aActAcDecIceTre_0
	.hword 1
	.align 4

	.word aActAcDecThunde
	.hword 0
	.align 4

	.word aActAcDecCloudS
	.hword 1
	.align 4

	.word aActAcDecGrass6
	.hword 2
	.align 4

	.word aActAcDecFallin
	.hword 0
	.align 4

	.word aActAcDecLeafWa
	.hword 1
	.align 4

	.word aActAcDecKojima
	.hword 0
	.align 4

// DecorInfo[]
.public decorInfo
decorInfo: // 0x0218780C
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0x80, 0, 0, 0 // DecorInfo
	.byte 0, 0, 1, 1, 0xE, 0, 0, 0 // DecorInfo
	.byte 0, 0, 2, 2, 0xE, 0, 1, 0 // DecorInfo
	.byte 0, 1, 2, 2, 0xE, 0, 1, 0 // DecorInfo
	.byte 1, 0, 2, 2, 0xF, 0xFF, 2, 0 // DecorInfo
	.byte 1, 1, 2, 2, 0xF, 0xFF, 2, 0 // DecorInfo
	.byte 1, 0, 3, 3, 0xF, 0xFF, 3, 0 // DecorInfo
	.byte 1, 1, 3, 3, 0xF, 0xFF, 3, 0 // DecorInfo
	.byte 1, 0, 4, 4, 0xF, 0xFF, 4, 0 // DecorInfo
	.byte 1, 1, 4, 4, 0xF, 0xFF, 4, 0 // DecorInfo
	.byte 1, 0, 0, 0, 0xF, 0, 5, 0 // DecorInfo
	.byte 1, 1, 0, 0, 0xF, 0, 5, 0 // DecorInfo
	.byte 1, 0, 1, 1, 0xF, 0, 6, 0 // DecorInfo
	.byte 1, 1, 1, 1, 0xF, 0, 6, 0 // DecorInfo
	.byte 2, 0, 0, 0, 0x10, 0, 7, 0 // DecorInfo
	.byte 2, 1, 0, 0, 0x10, 0, 7, 0 // DecorInfo
	.byte 4, 0, 0, 0, 0x12, 0, 8, 0 // DecorInfo
	.byte 4, 0, 1, 1, 0x12, 0, 9, 0 // DecorInfo
	.byte 4, 0, 2, 2, 0x12, 0, 0xA, 0 // DecorInfo
	.byte 3, 8, 0, 0, 0x11, 0, 0xB, 0 // DecorInfo
	.byte 3, 9, 0, 0, 0x11, 0, 0xB, 0 // DecorInfo
	.byte 3, 0, 1, 1, 0x11, 0, 0xC, 0 // DecorInfo
	.byte 3, 1, 1, 1, 0x11, 0, 0xC, 0 // DecorInfo
	.byte 3, 0, 2, 2, 0x11, 0, 0xD, 0 // DecorInfo
	.byte 3, 1, 2, 2, 0x11, 0, 0xD, 0 // DecorInfo
	.byte 3, 0, 3, 3, 0x11, 0, 0xE, 0 // DecorInfo
	.byte 3, 1, 3, 3, 0x11, 0, 0xE, 0 // DecorInfo
	.byte 3, 0, 4, 4, 0x11, 0, 0xF, 0 // DecorInfo
	.byte 3, 1, 4, 4, 0x11, 0, 0xF, 0 // DecorInfo
	.byte 3, 0, 5, 5, 0x11, 0, 0x10, 0 // DecorInfo
	.byte 3, 1, 5, 5, 0x11, 0, 0x10, 0 // DecorInfo
	.byte 5, 0, 0, 0, 0x13, 0, 0x11, 0 // DecorInfo
	.byte 5, 1, 0, 0, 0x13, 0, 0x11, 0 // DecorInfo
	.byte 6, 8, 0, 0, 9, 1, 0x12, 0 // DecorInfo
	.byte 6, 9, 0, 0, 9, 1, 0x12, 0 // DecorInfo
	.byte 6, 8, 1, 1, 9, 0, 0x13, 0 // DecorInfo
	.byte 6, 9, 1, 1, 9, 1, 0x13, 0 // DecorInfo
	.byte 6, 8, 2, 2, 9, 0, 0x14, 0 // DecorInfo
	.byte 6, 9, 2, 2, 9, 0, 0x14, 0 // DecorInfo
	.byte 6, 8, 3, 3, 9, 0, 0x15, 0 // DecorInfo
	.byte 6, 9, 3, 3, 9, 0, 0x15, 0 // DecorInfo
	.byte 6, 8, 4, 4, 9, 0, 0x16, 0 // DecorInfo
	.byte 6, 9, 4, 4, 9, 0, 0x16, 0 // DecorInfo
	.byte 6, 8, 5, 5, 9, 0xFF, 0x17, 0 // DecorInfo
	.byte 6, 9, 5, 5, 9, 0xFF, 0x17, 0 // DecorInfo
	.byte 1, 0, 5, 5, 0xF, 0, 0x18, 0 // DecorInfo
	.byte 1, 1, 5, 5, 0xF, 0, 0x18, 0 // DecorInfo
	.byte 1, 0, 6, 6, 0xF, 0, 0x19, 0 // DecorInfo
	.byte 1, 1, 6, 6, 0xF, 0, 0x19, 0 // DecorInfo
	.byte 7, 0x40, 3, 3, 0x21, 0xFF, 0x1A, 0xA // DecorInfo
	.byte 8, 8, 0, 0, 0x16, 0, 0x1B, 0 // DecorInfo
	.byte 9, 0, 0, 0, 0x18, 0, 0x1C, 0 // DecorInfo
	.byte 9, 0, 1, 1, 0x18, 0, 0x1D, 0 // DecorInfo
	.byte 9, 0, 2, 2, 0x18, 0, 0x1E, 0 // DecorInfo
	.byte 9, 1, 2, 2, 0x18, 0, 0x1E, 0 // DecorInfo
	.byte 9, 0, 3, 3, 0x18, 0, 0x1F, 0 // DecorInfo
	.byte 9, 1, 3, 3, 0x18, 0, 0x1F, 0 // DecorInfo
	.byte 9, 0, 4, 4, 0x18, 0, 0x20, 0 // DecorInfo
	.byte 9, 1, 4, 4, 0x18, 0, 0x20, 0 // DecorInfo
	.byte 9, 8, 5, 5, 0x18, 0, 0x21, 0 // DecorInfo
	.byte 9, 9, 5, 5, 0x18, 0, 0x21, 0 // DecorInfo
	.byte 9, 8, 6, 6, 0x18, 0, 0x22, 0 // DecorInfo
	.byte 9, 9, 6, 6, 0x18, 0, 0x22, 0 // DecorInfo
	.byte 5, 8, 1, 1, 0x13, 0, 0x23, 0 // DecorInfo
	.byte 5, 8, 2, 2, 0x13, 0, 0x24, 0 // DecorInfo
	.byte 5, 8, 3, 3, 0x13, 0, 0x25, 0 // DecorInfo
	.byte 5, 8, 4, 4, 0x13, 0, 0x26, 0 // DecorInfo
	.byte 2, 8, 1, 1, 0x10, 0, 0x27, 0 // DecorInfo
	.byte 2, 9, 1, 1, 0x10, 0, 0x27, 0 // DecorInfo
	.byte 3, 8, 0, 6, 0x19, 0, 0xB, 0 // DecorInfo
	.byte 3, 9, 0, 6, 0x19, 0, 0xB, 0 // DecorInfo
	.byte 3, 0, 2, 6, 0x19, 0, 0xD, 0 // DecorInfo
	.byte 3, 1, 2, 6, 0x19, 0, 0xD, 0 // DecorInfo
	.byte 3, 0, 4, 6, 0x19, 0, 0xF, 0 // DecorInfo
	.byte 3, 1, 4, 6, 0x19, 0, 0xF, 0 // DecorInfo
	.byte 3, 0, 5, 6, 0x19, 0, 0x10, 0 // DecorInfo
	.byte 3, 1, 5, 6, 0x19, 0, 0x10, 0 // DecorInfo
	.byte 4, 0, 0, 3, 0x1A, 0, 8, 0 // DecorInfo
	.byte 4, 0, 1, 3, 0x1A, 0, 9, 0 // DecorInfo
	.byte 4, 0, 2, 3, 0x1A, 0, 0xA, 0 // DecorInfo
	.byte 4, 0, 0, 4, 0x1B, 0, 8, 0 // DecorInfo
	.byte 4, 0, 1, 4, 0x1B, 0, 9, 0 // DecorInfo
	.byte 4, 0, 2, 4, 0x1B, 0, 0xA, 0 // DecorInfo
	.byte 0xA, 8, 0, 0, 0x1C, 0, 0x28, 0 // DecorInfo
	.byte 0xA, 9, 0, 0, 0x1C, 0, 0x28, 0 // DecorInfo
	.byte 0xA, 8, 1, 1, 0x1C, 0, 0x29, 0 // DecorInfo
	.byte 0xA, 8, 2, 2, 0x1C, 0, 0x2A, 0 // DecorInfo
	.byte 0, 0, 1, 4, 0x1D, 0, 0, 0 // DecorInfo
	.byte 0, 0, 2, 4, 0x1D, 0, 1, 0 // DecorInfo
	.byte 0, 1, 2, 4, 0x1D, 0, 1, 0 // DecorInfo
	.byte 0xB, 0x14, 0, 0, 0xA, 0, 0x2B, 0 // DecorInfo
	.byte 0xB, 0x14, 1, 1, 0xA, 0, 0x2C, 0 // DecorInfo
	.byte 0xB, 0x14, 2, 2, 0xA, 0, 0x2D, 0 // DecorInfo
	.byte 0xB, 0x1C, 0, 0, 0xA, 0, 0x2B, 0 // DecorInfo
	.byte 0xB, 0x1C, 1, 1, 0xA, 0, 0x2C, 0 // DecorInfo
	.byte 0xB, 0x1C, 2, 2, 0xA, 0, 0x2D, 0 // DecorInfo
	.byte 0, 0, 0, 0, 0, 0, 0, 0 // DecorInfo
	.byte 0xE, 8, 0, 0, 0x26, 0, 0, 0 // DecorInfo
	.byte 0xE, 8, 1, 1, 0x26, 0, 1, 0 // DecorInfo
	.byte 0xE, 8, 2, 2, 0x26, 0, 2, 0 // DecorInfo
	.byte 0xE, 8, 3, 3, 0x26, 0, 3, 0 // DecorInfo
	.byte 0xE, 8, 4, 4, 0x26, 0, 4, 0 // DecorInfo
	.byte 0xE, 8, 5, 5, 0x26, 0, 5, 0 // DecorInfo
	.byte 0xE, 8, 6, 6, 0x26, 0, 6, 0 // DecorInfo
	.byte 0xE, 8, 7, 7, 0x26, 0, 7, 0 // DecorInfo
	.byte 0xE, 8, 8, 8, 0x26, 0, 8, 0 // DecorInfo
	.byte 0xE, 8, 9, 9, 0x26, 0, 9, 0 // DecorInfo
	.byte 0xE, 8, 0xA, 0xA, 0x26, 0, 0xA, 0 // DecorInfo
	.byte 0xE, 8, 0xB, 0xB, 0x26, 0, 0xB, 0 // DecorInfo
	.byte 0xE, 8, 0xC, 0xC, 0x26, 0, 0xC, 0 // DecorInfo
	.byte 0xE, 8, 0xD, 0xD, 0x26, 0, 0xD, 0 // DecorInfo
	.byte 0xE, 8, 0xE, 0xE, 0x26, 0, 0xE, 0 // DecorInfo
	.byte 0xE, 8, 0xF, 0xF, 0x26, 0, 0xF, 0 // DecorInfo
	.byte 0xC, 0, 0, 0, 0x27, 0, 0x2E, 0 // DecorInfo
	.byte 0xC, 1, 0, 0, 0x27, 0, 0x2E, 0 // DecorInfo
	.byte 0xC, 0, 1, 1, 0x27, 0, 0x2F, 0 // DecorInfo
	.byte 0xC, 1, 1, 1, 0x27, 0, 0x2F, 0 // DecorInfo
	.byte 0xC, 0, 2, 2, 0x27, 0, 0x30, 0 // DecorInfo
	.byte 0xC, 1, 2, 2, 0x27, 0, 0x30, 0 // DecorInfo
	.byte 0xC, 0, 3, 3, 0x27, 0, 0x31, 3 // DecorInfo
	.byte 0xC, 1, 3, 3, 0x27, 0, 0x31, 3 // DecorInfo
	.byte 0xC, 0, 4, 4, 0x27, 0, 0x32, 0 // DecorInfo
	.byte 0xC, 1, 4, 4, 0x27, 0, 0x32, 0 // DecorInfo
	.byte 0xF, 8, 0, 0, 0x2E, 0, 0x10, 0 // DecorInfo
	.byte 0xF, 8, 1, 1, 0x2E, 0, 0x11, 0 // DecorInfo
	.byte 0xF, 8, 2, 2, 0x2E, 0, 0x12, 0 // DecorInfo
	.byte 0xF, 8, 3, 3, 0x2E, 0, 0x13, 0 // DecorInfo
	.byte 0xF, 8, 4, 4, 0x2E, 0, 0x14, 0 // DecorInfo
	.byte 0xF, 9, 4, 4, 0x2E, 0, 0x14, 0 // DecorInfo
	.byte 0xF, 0xA, 4, 4, 0x2E, 0, 0x14, 0 // DecorInfo
	.byte 0xF, 0xB, 4, 4, 0x2E, 0, 0x14, 0 // DecorInfo
	.byte 0xF, 8, 5, 5, 0x2E, 0, 0x15, 0 // DecorInfo
	.byte 0xF, 9, 5, 5, 0x2E, 0, 0x15, 0 // DecorInfo
	.byte 0xF, 8, 6, 6, 0x2E, 0, 0x16, 0 // DecorInfo
	.byte 0xF, 0xA, 6, 6, 0x2E, 0, 0x16, 0 // DecorInfo
	.byte 0xF, 8, 7, 7, 0x2E, 0, 0x17, 0 // DecorInfo
	.byte 0xF, 8, 8, 8, 0x2E, 0, 0x18, 0 // DecorInfo
	.byte 0xF, 8, 0xB, 0xB, 0x2E, 0, 0x19, 0 // DecorInfo
	.byte 0xF, 9, 0xB, 0xB, 0x2E, 0, 0x19, 0 // DecorInfo
	.byte 0xF, 8, 0xC, 0xC, 0x2E, 0, 0x1A, 0 // DecorInfo
	.byte 0xF, 0xA, 0xC, 0xC, 0x2E, 0, 0x1A, 0 // DecorInfo
	.byte 0xF, 8, 9, 9, 0x2E, 0, 0x1B, 0 // DecorInfo
	.byte 0xF, 0xA, 9, 9, 0x2E, 0, 0x1B, 0 // DecorInfo
	.byte 0xF, 8, 0xA, 0xA, 0x2E, 0, 0x1C, 0 // DecorInfo
	.byte 0xF, 9, 0xA, 0xA, 0x2E, 0, 0x1C, 0 // DecorInfo
	.byte 0x10, 0, 0, 0, 0x2F, 0, 0x1D, 0 // DecorInfo
	.byte 0x10, 0, 1, 1, 0x2F, 0, 0x1E, 0 // DecorInfo
	.byte 0x10, 0, 2, 2, 0x2F, 0, 0x1F, 0 // DecorInfo
	.byte 0x10, 1, 2, 2, 0x2F, 0, 0x1F, 0 // DecorInfo
	.byte 0x10, 0, 3, 3, 0x2F, 0, 0x20, 0 // DecorInfo
	.byte 0x10, 1, 3, 3, 0x2F, 0, 0x20, 0 // DecorInfo
	.byte 0x10, 0, 4, 4, 0x2F, 0, 0x21, 0 // DecorInfo
	.byte 0x10, 1, 4, 4, 0x2F, 0, 0x21, 0 // DecorInfo
	.byte 0x10, 0, 5, 5, 0x2F, 0, 0x22, 0 // DecorInfo
	.byte 0x10, 0, 6, 6, 0x2F, 0, 0x23, 0 // DecorInfo
	.byte 0x10, 0, 7, 7, 0x2F, 0, 0x24, 0 // DecorInfo
	.byte 0x1C, 0, 0, 0, 0x3D, 0, 0, 7 // DecorInfo
	.byte 0x1C, 1, 0, 0, 0x3D, 0, 0, 7 // DecorInfo
	.byte 0x1C, 8, 0, 0, 0x3D, 0, 0, 7 // DecorInfo
	.byte 0x1C, 9, 0, 0, 0x3D, 0, 0, 7 // DecorInfo
	.byte 0x1C, 0, 1, 1, 0x3D, 0, 1, 7 // DecorInfo
	.byte 0x1C, 0, 2, 2, 0x3D, 0, 2, 7 // DecorInfo
	.byte 0x1D, 8, 1, 1, 0x3F, 0, 3, 8 // DecorInfo
	.byte 0x1D, 0x20, 1, 1, 0x3F, 0, 3, 8 // DecorInfo
	.byte 0x1D, 8, 0, 0, 0x3E, 0, 4, 8 // DecorInfo
	.byte 0x1D, 0x20, 0, 0, 0x3E, 0, 4, 8 // DecorInfo
	.byte 0x1D, 8, 2, 2, 0x40, 0, 5, 0 // DecorInfo
	.byte 0x1D, 9, 2, 2, 0x40, 0, 5, 0 // DecorInfo
	.byte 0x1D, 0x20, 2, 2, 0x40, 0, 5, 0 // DecorInfo
	.byte 0x1D, 0x21, 2, 2, 0x40, 0, 5, 0 // DecorInfo
	.byte 0x11, 8, 0, 0, 0x41, 0, 0, 0 // DecorInfo
	.byte 0x11, 8, 1, 1, 0x41, 0, 1, 0 // DecorInfo
	.byte 0x11, 0, 2, 2, 0x42, 0, 2, 0 // DecorInfo
	.byte 0x11, 1, 2, 2, 0x42, 0, 2, 0 // DecorInfo
	.byte 0x11, 0, 3, 3, 0x42, 0, 3, 0 // DecorInfo
	.byte 0x11, 1, 3, 3, 0x42, 0, 3, 0 // DecorInfo
	.byte 0x11, 0, 4, 4, 0x42, 0, 4, 0 // DecorInfo
	.byte 0x11, 1, 4, 4, 0x42, 0, 4, 0 // DecorInfo
	.byte 0x11, 0, 5, 5, 0x42, 0, 5, 0 // DecorInfo
	.byte 0x11, 1, 5, 5, 0x42, 0, 5, 0 // DecorInfo
	.byte 0x11, 0, 2, 6, 0x43, 0, 2, 1 // DecorInfo
	.byte 0x11, 1, 2, 6, 0x43, 0, 2, 1 // DecorInfo
	.byte 0x11, 0, 3, 6, 0x43, 0, 3, 1 // DecorInfo
	.byte 0x11, 1, 3, 6, 0x43, 0, 3, 1 // DecorInfo
	.byte 0x11, 0, 4, 6, 0x43, 0, 4, 1 // DecorInfo
	.byte 0x11, 1, 4, 6, 0x43, 0, 4, 1 // DecorInfo
	.byte 0x11, 0, 5, 6, 0x43, 0, 5, 1 // DecorInfo
	.byte 0x11, 1, 5, 6, 0x43, 0, 5, 1 // DecorInfo
	.byte 0x11, 4, 7, 7, 0x44, 0, 6, 0 // DecorInfo
	.byte 0x11, 5, 7, 7, 0x44, 0, 6, 0 // DecorInfo
	.byte 0x11, 4, 8, 8, 0x44, 0, 7, 0 // DecorInfo
	.byte 0x11, 5, 8, 8, 0x44, 0, 7, 0 // DecorInfo
	.byte 0x11, 8, 9, 9, 0x45, 0, 8, 0 // DecorInfo
	.byte 0x11, 9, 9, 9, 0x45, 0, 8, 0 // DecorInfo
	.byte 0x11, 8, 0xA, 0xA, 0x45, 0, 9, 0 // DecorInfo
	.byte 0x11, 9, 0xA, 0xA, 0x45, 0, 9, 0 // DecorInfo
	.byte 0x11, 8, 0xB, 0xB, 0x45, 0, 0xA, 0 // DecorInfo
	.byte 0x11, 9, 0xB, 0xB, 0x45, 0, 0xA, 0 // DecorInfo
	.byte 0x11, 0, 0xC, 0xC, 0x42, 0, 0xB, 0 // DecorInfo
	.byte 0x11, 1, 0xC, 0xC, 0x42, 0, 0xB, 0 // DecorInfo
	.byte 0x11, 0, 0xD, 0xD, 0x42, 0, 0xC, 0 // DecorInfo
	.byte 0x11, 1, 0xD, 0xD, 0x42, 0, 0xC, 0 // DecorInfo
	.byte 0x11, 0, 0xC, 6, 0x43, 0, 0xB, 1 // DecorInfo
	.byte 0x11, 1, 0xC, 6, 0x43, 0, 0xB, 1 // DecorInfo
	.byte 0x11, 0, 0xD, 6, 0x43, 0, 0xC, 1 // DecorInfo
	.byte 0x11, 1, 0xD, 6, 0x43, 0, 0xC, 1 // DecorInfo
	.byte 0x11, 0, 0xE, 0xE, 0x42, 0, 0xD, 0 // DecorInfo
	.byte 0x11, 1, 0xE, 0xE, 0x42, 0, 0xD, 0 // DecorInfo
	.byte 0x11, 0, 0xF, 0xF, 0x42, 0, 0xE, 0 // DecorInfo
	.byte 0x11, 1, 0xF, 0xF, 0x42, 0, 0xE, 0 // DecorInfo
	.byte 0x11, 0, 0xE, 6, 0x43, 0, 0xD, 1 // DecorInfo
	.byte 0x11, 1, 0xE, 6, 0x43, 0, 0xD, 1 // DecorInfo
	.byte 0x11, 0, 0xF, 6, 0x43, 0, 0xE, 1 // DecorInfo
	.byte 0x11, 1, 0xF, 6, 0x43, 0, 0xE, 1 // DecorInfo
	.byte 0x12, 0, 0, 0, 0x46, 0, 0, 0 // DecorInfo
	.byte 0x13, 0, 0, 0, 0x47, 0, 1, 0 // DecorInfo
	.byte 0x14, 0, 0, 0, 0x48, 0, 2, 0 // DecorInfo
	.byte 0x14, 1, 0, 0, 0x48, 0, 2, 0 // DecorInfo
	.byte 0x14, 2, 0, 0, 0x48, 0, 2, 0 // DecorInfo
	.byte 0x14, 3, 0, 0, 0x48, 0, 2, 0 // DecorInfo
	.byte 0x14, 0, 1, 1, 0x48, 0, 3, 0 // DecorInfo
	.byte 0x14, 1, 1, 1, 0x48, 0, 3, 0 // DecorInfo
	.byte 0x14, 2, 1, 1, 0x48, 0, 3, 0 // DecorInfo
	.byte 0x14, 3, 1, 1, 0x48, 0, 3, 0 // DecorInfo
	.byte 0x15, 0, 0, 0, 0x49, 0, 4, 0 // DecorInfo
	.byte 0x16, 8, 0, 0, 0x48, 0, 5, 0 // DecorInfo
	.byte 0x17, 0, 0, 0, 0, 0, 6, 0 // DecorInfo
	.byte 0x17, 0, 1, 0, 1, 0, 7, 0 // DecorInfo
	.byte 0x17, 0, 2, 0, 2, 0, 8, 0 // DecorInfo
	.byte 0x11, 4, 0x10, 0x10, 0x42, 0, 3, 0 // DecorInfo
	.byte 0x11, 5, 0x10, 0x10, 0x42, 0, 3, 0 // DecorInfo
	.byte 0x11, 4, 0x11, 0x11, 0x42, 0, 4, 0 // DecorInfo
	.byte 0x11, 5, 0x11, 0x11, 0x42, 0, 4, 0 // DecorInfo
	.byte 0x11, 4, 0x12, 0x12, 0x42, 0, 5, 0 // DecorInfo
	.byte 0x11, 5, 0x12, 0x12, 0x42, 0, 5, 0 // DecorInfo
	.byte 0x11, 4, 0x13, 0x13, 0x42, 0, 0xB, 0 // DecorInfo
	.byte 0x11, 5, 0x13, 0x13, 0x42, 0, 0xB, 0 // DecorInfo
	.byte 0x18, 0, 5, 5, 0x5E, 0, 0xC, 0 // DecorInfo
	.byte 0x18, 0, 4, 4, 0x54, 0, 0xD, 0 // DecorInfo
	.byte 0x19, 0x40, 0, 0, 0x58, 0, 0xE, 0xA // DecorInfo
	.byte 0x1A, 0, 0, 0, 0x59, 0, 0xF, 0 // DecorInfo
	.byte 0x1A, 1, 0, 0, 0x59, 0, 0xF, 0 // DecorInfo
	.byte 0x1A, 0, 1, 1, 0x59, 0, 0x10, 0 // DecorInfo
	.byte 0x1A, 1, 1, 1, 0x59, 0, 0x10, 0 // DecorInfo
	.byte 0x1A, 2, 1, 1, 0x59, 0, 0x10, 0 // DecorInfo
	.byte 0x1A, 3, 1, 1, 0x59, 0, 0x10, 0 // DecorInfo
	.byte 0xD, 0x20, 0, 0, 0x60, 0, 0x33, 2 // DecorInfo
	.byte 0xD, 0x20, 1, 1, 0x60, 0, 0x34, 2 // DecorInfo
	.byte 0xE, 9, 0, 0, 0x26, 0, 0, 0 // DecorInfo
	.byte 0xE, 9, 1, 1, 0x26, 0, 1, 0 // DecorInfo
	.byte 0xE, 9, 2, 2, 0x26, 0, 2, 0 // DecorInfo
	.byte 0xE, 9, 3, 3, 0x26, 0, 3, 0 // DecorInfo
	.byte 0xE, 9, 4, 4, 0x26, 0, 4, 0 // DecorInfo
	.byte 0xE, 9, 5, 5, 0x26, 0, 5, 0 // DecorInfo
	.byte 0xE, 9, 6, 6, 0x26, 0, 6, 0 // DecorInfo
	.byte 0xE, 9, 7, 7, 0x26, 0, 7, 0 // DecorInfo
	.byte 0x1E, 0x40, 0, 0, 0x66, 0, 0, 0xA // DecorInfo
	.byte 0x1F, 8, 0, 0, 6, 0, 1, 5 // DecorInfo
	.byte 0x1F, 8, 1, 1, 6, 0, 2, 5 // DecorInfo
	.byte 0x1F, 0x20, 2, 2, 6, 0, 3, 6 // DecorInfo
	.byte 0x1F, 0x20, 3, 3, 6, 0, 4, 6 // DecorInfo
	.byte 0, 0, 0, 0, 0, 0, 0, 0 // DecorInfo
	.byte 0x21, 0x40, 0, 0, 0x5D, 0, 0, 0xA // DecorInfo
	.byte 0x21, 0x40, 1, 1, 0x5D, 0, 1, 0xA // DecorInfo
	.byte 0x21, 0x40, 2, 2, 0x5D, 0xFF, 2, 0xA // DecorInfo
	.byte 0x22, 0x40, 0, 0, 0x5F, 0, 3, 0xA // DecorInfo
	.byte 0, 0, 0, 0, 0, 0, 0, 0 // DecorInfo
	.byte 0, 0, 0, 0, 0, 0, 0, 0 // DecorInfo
	.byte 0x20, 8, 0, 0, 0x68, 0, 5, 0 // DecorInfo
	.byte 0x20, 8, 1, 1, 0x68, 0, 6, 0 // DecorInfo
	.byte 0x20, 0, 2, 2, 0x68, 0, 7, 0 // DecorInfo
	.byte 0x20, 1, 2, 2, 0x68, 0, 7, 0 // DecorInfo
	.byte 0x20, 0, 3, 3, 0x68, 0, 8, 0 // DecorInfo
	.byte 0x20, 0, 4, 4, 0x68, 0, 9, 0 // DecorInfo
	.byte 0x18, 0, 7, 7, 0x54, 0, 0x11, 0 // DecorInfo
	.byte 0x1B, 8, 0, 0, 0x59, 0, 0x12, 1 // DecorInfo
	.byte 0x1B, 9, 0, 0, 0x59, 0, 0x12, 1 // DecorInfo
	.byte 0x1B, 8, 1, 1, 0x59, 0, 0x13, 1 // DecorInfo
	.byte 0x1B, 9, 1, 1, 0x59, 0, 0x13, 1 // DecorInfo
	.byte 0x1B, 8, 2, 2, 0x59, 0, 0x14, 1 // DecorInfo
	.byte 0x23, 0, 0, 0, 0x6E, 0, 0, 0 // DecorInfo
	.byte 0x23, 1, 0, 0, 0x6E, 0, 0, 0 // DecorInfo
	.byte 0xC, 0, 5, 5, 0x27, 1, 0x35, 4 // DecorInfo
	.byte 0x1E, 0x84, 0, 0, 0x66, 0, 0, 9 // DecorInfo
	.byte 0x19, 0x84, 0, 0, 0x58, 0, 0xE, 9 // DecorInfo
	.byte 7, 0xC, 3, 3, 0x21, 0xFF, 0x1A, 9 // DecorInfo
	.byte 0x21, 0x84, 0, 0, 0x5D, 0, 0, 9 // DecorInfo
	.byte 0x21, 0x84, 1, 1, 0x5D, 0, 1, 9 // DecorInfo
	.byte 0x21, 0x84, 2, 2, 0x5D, 0xFF, 2, 9 // DecorInfo
	.byte 0x22, 0x84, 0, 0, 0x5F, 0, 3, 9 // DecorInfo

	.data

.public _02188780
_02188780: // 0x02188780
	.byte 0x00, 0x01, 0x04, 0x05
	.align 4

.public _02188784
_02188784: // 0x02188784
	.byte 0x01, 0xCC, 0xFB, 0xD4, 0x0F, 0xE0, 0xFE, 0xE2, 0x13, 0xE9, 0xFB, 0xEB, 0x0E, 0xFA, 0xF3, 0xFC
	.align 4

aActAcEffGrd3lL: // 0x02188794
	.asciz "/act/ac_eff_grd3l_leaf.bac"
	.align 4
	
aActAcDecMoBac: // 0x021887B0
	.asciz "/act/ac_dec_mo.bac"
	.align 4
	
aActAcDecFlwBac: // 0x021887C4
	.asciz "/act/ac_dec_flw.bac"
aActAcDecSailBa: // 0x021887D8
	.asciz "/act/ac_dec_sail.bac"
	.align 4
	
aActAcDecSakuBa_0: // 0x021887F0
	.asciz "/act/ac_dec_saku.bac"
	.align 4
	
aActAcDecPalmBa: // 0x02188808
	.asciz "/act/ac_dec_palm.bac"
	.align 4
	
aActAcDecBoatBa: // 0x02188820
	.asciz "/act/ac_dec_boat.bac"
	.align 4
	
aActAcDecMastBa: // 0x02188838
	.asciz "/act/ac_dec_mast.bac"
	.align 4
	
aActAcDecRopeBa: // 0x02188850
	.asciz "/act/ac_dec_rope.bac"
	.align 4
	
aActAcEffWaterB_2: // 0x02188868
	.asciz "/act/ac_eff_water.bac"
	.align 4
	
aActAcDecCloudB: // 0x02188880
	.asciz "/act/ac_dec_cloud.bac"
	.align 4
	
aActAcDecGrassB: // 0x02188898
	.asciz "/act/ac_dec_grass.bac"
	.align 4
	
aActAcDecCoralB_0: // 0x021888B0
	.asciz "/act/ac_dec_coral.bac"
	.align 4
	
aActAcGmkBarrel_0: // 0x021888C8
	.asciz "/act/ac_gmk_barrel.bac"
	.align 4
	
aActAcDecKinoko: // 0x021888E0
	.asciz "/act/ac_dec_kinoko.bac"
	.align 4
	
aActAcDecSuimen: // 0x021888F8
	.asciz "/act/ac_dec_suimen.bac"
	.align 4
	
aActAcDecGrass6: // 0x02188910
	.asciz "/act/ac_dec_grass6.bac"
	.align 4
	
aActAcDecIcicle: // 0x02188928
	.asciz "/act/ac_dec_icicle.bac"
	.align 4
	
aActAcDecCannon: // 0x02188940
	.asciz "/act/ac_dec_cannon.bac"
	.align 4
	
aActAcDecRudder: // 0x02188958
	.asciz "/act/ac_dec_rudder.bac"
	.align 4
	
aActAcDecThunde: // 0x02188970
	.asciz "/act/ac_dec_thunder.bac"
	.align 4
	
aActAcDecKinoko_0: // 0x02188988
	.asciz "/act/ac_dec_kinoko2.bac"
	.align 4
	
aActAcDecChimne: // 0x021889A0
	.asciz "/act/ac_dec_chimney.bac"
	.align 4
	
aActAcGmkFlipmu_1: // 0x021889B8
	.asciz "/act/ac_gmk_flipmush.bac"
	.align 4
	
aActAcDecIceTre_0: // 0x021889D4
	.asciz "/act/ac_dec_ice_tree.bac"
	.align 4
	
aActAcDecPipeFl: // 0x021889F0
	.asciz "/act/ac_dec_pipe_flw.bac"
	.align 4
	
aActAcDecBigLea: // 0x02188A0C
	.asciz "/act/ac_dec_big_leaf.bac"
	.align 4
	
aActAcDecFlwTub: // 0x02188A28
	.asciz "/act/ac_dec_flw_tubo.bac"
	.align 4
	
aActAcDecGstTre: // 0x02188A44
	.asciz "/act/ac_dec_gst_tree.bac"
	.align 4
	
aActAcDecDecopi: // 0x02188A60
	.asciz "/act/ac_dec_decopipe.bac"
	.align 4
	
aActAcDecCloudS: // 0x02188A7C
	.asciz "/act/ac_dec_cloud_st6.bac"
	.align 4
	
aActAcDecTrampo: // 0x02188A98
	.asciz "/act/ac_dec_trampoline.bac"
	.align 4
	
aActAcDecLeafWa: // 0x02188AB4
	.asciz "/act/ac_dec_leaf_water.bac"
	.align 4
	
aActAcDecPipeSt: // 0x02188AD0
	.asciz "/act/ac_dec_pipe_steam.bac"
	.align 4
	
aActAcDecKojima: // 0x02188AEC
	.asciz "/act/ac_dec_kojima_palm.bac"
	.align 4
	
aActAcDecFallin: // 0x02188B08
	.asciz "/act/ac_dec_falling_water.bac"
	.align 4
	
aActAcDecAnchor: // 0x02188B28
	.asciz "/act/ac_dec_anchor_rope3d.bac"
	.align 4