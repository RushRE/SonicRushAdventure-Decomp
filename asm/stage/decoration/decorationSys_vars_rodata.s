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