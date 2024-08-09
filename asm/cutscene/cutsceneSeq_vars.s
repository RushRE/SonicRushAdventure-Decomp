	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public CutsceneSeq__FuncTable1
CutsceneSeq__FuncTable1: // 0x0215B1C0
    .word 0  
	
.public CutsceneSeq__FuncTable2
CutsceneSeq__FuncTable2: // 0x0215B1C4
    .word CutsceneSeq__FuncTable2__Func_21552D4
	
.public CutsceneSeq__FuncTable3
CutsceneSeq__FuncTable3: // 0x0215B1C8
    .word CutsceneSeq__FuncTable3__LoadBBG, CutsceneSeq__FuncTable3__Func_2154494
    .word CutsceneSeq__FuncTable3__Func_21544BC, CutsceneSeq__FuncTable3__Func_2154504
    .word CutsceneSeq__FuncTable3__Func_215455C, CutsceneSeq__FuncTable3__Func_21545B0
	
.public CutsceneSeq__FuncTable4
CutsceneSeq__FuncTable4: // 0x0215B1E0
    .word 0, CutsceneSeq__FuncTable4__Func_2152C1C, CutsceneSeq__FuncTable4__Func_2152CC0
    .word CutsceneSeq__FuncTable4__Func_2152D3C, CutsceneSeq__FuncTable4__Func_2152D94
    .word CutsceneSeq__FuncTable4__Func_2152DF0
	
.public CutsceneSeq__FuncTable6
CutsceneSeq__FuncTable6: // 0x0215B1F8
    .word CutsceneSeq__FuncTable6__Func_2153C90, CutsceneSeq__FuncTable6__Func_2153CE8
    .word CutsceneSeq__FuncTable6__Func_2153D10, CutsceneSeq__FuncTable6__MountArchive
    .word CutsceneSeq__FuncTable6__UnmountArchive, CutsceneSeq__FuncTable6__Func_2153DAC
    .word CutsceneSeq__FuncTable6__Func_2153DDC
	
.public CutsceneSeq__FuncTable7
CutsceneSeq__FuncTable7: // 0x0215B214
    .word CutsceneSeq__FuncTable7__LoadMDL, CutsceneSeq__FuncTable7__Func_2154684
    .word CutsceneSeq__FuncTable7__Func_21546AC, CutsceneSeq__FuncTable7__LoadMDL2
    .word CutsceneSeq__FuncTable7__LoadAniMDL, CutsceneSeq__FuncTable7__Func_215483C
    .word CutsceneSeq__FuncTable7__Func_21548A8, CutsceneSeq__FuncTable7__Func_21549E4
    .word CutsceneSeq__FuncTable7__Func_2154A50, CutsceneSeq__FuncTable7__Func_2154ABC
    .word CutsceneSeq__FuncTable7__Func_2154B10, CutsceneSeq__FuncTable7__Func_2154B64
    .word CutsceneSeq__FuncTable7__Func_2154BF8, CutsceneSeq__FuncTable7__LoadDrawState
    .word CutsceneSeq__FuncTable7__Func_2154CCC
	
.public CutsceneSeq__FuncTable8
CutsceneSeq__FuncTable8: // 0x0215B250
    .word CutsceneSeq__FuncTable8__LoadSprite, CutsceneSeq__FuncTable8__Func_2153EB4
    .word CutsceneSeq__FuncTable8__Func_2153EDC, CutsceneSeq__FuncTable8__LoadSprite2
    .word CutsceneSeq__FuncTable8__SetAnimation, CutsceneSeq__FuncTable8__Func_2154014
    .word CutsceneSeq__FuncTable8__Func_215406C, CutsceneSeq__FuncTable8__Func_21540C0
    .word CutsceneSeq__FuncTable8__Func_2154114, CutsceneSeq__FuncTable8__Func_215418C
    .word CutsceneSeq__FuncTable8__Func_21541FC, CutsceneSeq__FuncTable8__Func_2154240
    .word CutsceneSeq__FuncTable8__Func_2154294, CutsceneSeq__FuncTable8__Func_21542E4
    .word CutsceneSeq__FuncTable8__Func_2154320, CutsceneSeq__FuncTable8__Func_2154384
    .word CutsceneSeq__FuncTable8__Func_21543AC
	
.public CutsceneSeq__SndCommands
CutsceneSeq__SndCommands: // 0x0215B294
    .word CutsceneSeq__SndCommand__LoadSndArc, CutsceneSeq__SndCommand__SetVolume
    .word CutsceneSeq__SndCommand__Func_2154DD8, CutsceneSeq__SndCommand__LoadSndArcGroup
    .word CutsceneSeq__SndCommand__LoadSndArcSeq, CutsceneSeq__SndCommand__LoadSndArcWaveArc
    .word CutsceneSeq__SndCommand__LoadSndArcSeqArc, CutsceneSeq__SndCommand__PlayTrack
    .word CutsceneSeq__SndCommand__PlayTrackEx, CutsceneSeq__SndCommand__PlaySequence
    .word CutsceneSeq__SndCommand__PlaySequenceEx, CutsceneSeq__SndCommand__PlayVoiceClip
    .word CutsceneSeq__SndCommand__PlayVoiceClipEx, CutsceneSeq__SndCommand__Func_21551CC
    .word CutsceneSeq__SndCommand__Func_2155214, CutsceneSeq__SndCommand__Func_215523C
    .word CutsceneSeq__SndCommand__Func_215528C
	
.public CutsceneSeq__FuncTable9
CutsceneSeq__FuncTable9: // 0x0215B2D8
    .word CutsceneSeq__FuncTable9__Func_2152E54, CutsceneSeq__FuncTable9__Func_2152E94
    .word CutsceneSeq__FuncTable9__Func_2152ED0, CutsceneSeq__FuncTable9__Func_2152F14
    .word CutsceneSeq__FuncTable9__Func_2152F50, CutsceneSeq__FuncTable9__Func_2152F8C
    .word CutsceneSeq__FuncTable9__Func_2152FA4, CutsceneSeq__FuncTable9__Func_2152FBC
    .word CutsceneSeq__FuncTable9__Func_2153030, CutsceneSeq__FuncTable9__Func_21530BC
    .word CutsceneSeq__FuncTable9__Func_215315C, CutsceneSeq__FuncTable9__Func_215317C
    .word Task__Unknown21531C4__Create, CutsceneSeq__FuncTable9__Func_21532F0
    .word CutsceneSeq__FuncTable9__Func_2153450, CutsceneSeq__FuncTable9__Func_21535D0
    .word CutsceneSeq__FuncTable9__Func_21536E4, CutsceneSeq__FuncTable9__Func_2153734
    .word CutsceneSeq__FuncTable9__Func_2153780, CutsceneSeq__FuncTable9__Func_21537B8
    .word CutsceneSeq__FuncTable9__Func_215383C, CutsceneSeq__FuncTable9__Func_2153980
    .word CutsceneSeq__FuncTable9__Func_2153A30, CutsceneSeq__FuncTable9__Func_2153A54
    .word CutsceneSeq__FuncTable9__Func_2153C24, CutsceneSeq__FuncTable9__Func_2153C48

.public aNodeCamera2_ovl07
aNodeCamera2_ovl07: // 0x0215B340
	.asciz "node_camera2"
	.align 0x10

.public aNodeTarget_ovl07
aNodeTarget_ovl07: // 0x0215B350
	.asciz "node_target"
	.align 0x10

.public aNodeCamera_ovl07
aNodeCamera_ovl07: // 0x0215B360
	.asciz "node_camera"
	.align 0x10

.public aNodeTarget_0_ovl07
aNodeTarget_0_ovl07: // 0x0215B370
	.asciz "node_target"
	.align 0x10

.public aNodeCamera_0_ovl07
aNodeCamera_0_ovl07: // 0x0215B380
	.asciz "node_camera"
	.align 0x10

.public aNodeTarget2_ovl07
aNodeTarget2_ovl07: // 0x0215B390
	.asciz "node_target2"
	.align 0x10

.public _0215B3A0
_0215B3A0: // 0x0215B3A0
	.word 0, 1, 2, 3, 8, 9, 0xB, 4, 5, 6, 7, 0xB, 0xB

.public CutsceneSeq__FuncTable10
CutsceneSeq__FuncTable10: // 0x0215B3D4
    .word CutsceneSeq__FuncTable10__LoadFontFile, CutsceneSeq__FuncTable10__Func_2159B14
    .word CutsceneSeq__FuncTable10__LoadMPCFile, CutsceneSeq__FuncTable10__SetMsgSeq
    .word CutsceneSeq__FuncTable10__Func_2159C68, CutsceneSeq__FuncTable10__Func_2159C88
    .word CutsceneSeq__FuncTable10__Func_2159CA8, CutsceneSeq__FuncTable10__Func_2159CC8
    .word CutsceneSeq__FuncTable10__Func_2159CD8, CutsceneSeq__FuncTable10__Func_2159CE8
    .word CutsceneSeq__FuncTable10__Func_2159D08, CutsceneSeq__FuncTable10__Func_2159D40
    .word CutsceneSeq__FuncTable10__Func_2159D70, CutsceneSeq__FuncTable10__Func_2159D84
    .word CutsceneSeq__FuncTable10__Func_2159DB4

.public _0215B410
_0215B410: // 0x0215B410
	.word 0, 1, 3, 7, 0xF, 0x1F, 0x3F, 0x7F, 0xFF, 0x1FF, 0x3FF
	.word 0x7FF, 0xFFF, 0x1FFF, 0x3FFF, 0x7FFF, 0xFFFF
	
	.data

.public CutsceneSeq__FuncTableList1
CutsceneSeq__FuncTableList1: // 0x0215B460
    .word CutsceneSeq__FuncTable4, CutsceneSeq__FuncTable9
    .word CutsceneSeq__FuncTable6, CutsceneSeq__FuncTable8
    .word CutsceneSeq__FuncTable3, CutsceneSeq__FuncTable7
    .word CutsceneSeq__SndCommands, CutsceneSeq__FuncTable2
    .word CutsceneSeq__FuncTable1

.public CutsceneSeq__FuncTable11
CutsceneSeq__FuncTable11: // 0x0215B484
	.word 0, CutsceneSeq__CallFuncTable

.public CutsceneSeq__FuncTable12
CutsceneSeq__FuncTable12: // 0x0215B48C
	.word 0, CutsceneSeq__FuncTable12__Func_215636C, CutsceneSeq__FuncTable12__Func_21563D8

.public CutsceneSeq__FuncTable13
CutsceneSeq__FuncTable13: // 0x0215B498
    .word CutsceneSeq__FuncTable13__Func_21559BC, CutsceneSeq__FuncTable13__Func_21559C4
    .word CutsceneSeq__FuncTable13__Func_21559CC

.public CutsceneSeq__FuncTable14
CutsceneSeq__FuncTable14: // 0x0215B4A4
    .word 0, CutsceneSeq__FuncTable14__Func_215689C, CutsceneSeq__FuncTable14__Func_21568D8

.public CutsceneSeq__FuncTable15
CutsceneSeq__FuncTable15: // 0x0215B4B0
    .word 0, CutsceneSeq__FuncTable15__Func_21566CC, CutsceneSeq__FuncTable15__Func_215672C
    .word CutsceneSeq__FuncTable15__Func_21567B4, CutsceneSeq__FuncTable15__Func_2156824

.public CutsceneSeq__FuncTable16
CutsceneSeq__FuncTable16: // 0x0215B4C4
    .word 0
    .word CutsceneSeq__FuncTable16__Func_21560E4, CutsceneSeq__FuncTable16__Func_2156150
    .word CutsceneSeq__FuncTable16__Func_21561BC, CutsceneSeq__FuncTable16__Func_2156228
    .word CutsceneSeq__FuncTable16__Func_2156294, CutsceneSeq__FuncTable16__Func_2156300

.public CutsceneSeq__FuncTable18
CutsceneSeq__FuncTable18: // 0x0215B4E0
    .word CutsceneSeq__FuncTable18__Func_2156444, CutsceneSeq__FuncTable18__Func_215648C
    .word CutsceneSeq__FuncTable18__Func_21564EC, CutsceneSeq__FuncTable18__Func_215654C
    .word CutsceneSeq__FuncTable18__Func_21565AC, CutsceneSeq__FuncTable18__Func_215660C
    .word CutsceneSeq__FuncTable18__Func_215666C

.public CutsceneSeq__FuncTable19
CutsceneSeq__FuncTable19: // 0x0215B4FC
    .word CutsceneSeq__FuncTable19__Func_21559D4, CutsceneSeq__FuncTable19__Func_2155A30
    .word CutsceneSeq__FuncTable19__Func_2155A94, CutsceneSeq__FuncTable19__Func_2155AF8
    .word CutsceneSeq__FuncTable19__Func_2155B5C, CutsceneSeq__FuncTable19__Func_2155BDC
    .word CutsceneSeq__FuncTable19__Func_2155C0C, CutsceneSeq__FuncTable19__Func_2155C3C
    .word CutsceneSeq__FuncTable19__Func_2155C6C

.public CutsceneSeq__FuncTableList2
CutsceneSeq__FuncTableList2: // 0x0215B520
    .word CutsceneSeq__FuncTable13, CutsceneSeq__FuncTable19
    .word CutsceneSeq__FuncTable20, CutsceneSeq__FuncTable16
    .word CutsceneSeq__FuncTable12, CutsceneSeq__FuncTable18
    .word CutsceneSeq__FuncTable15, CutsceneSeq__FuncTable11
    .word CutsceneSeq__FuncTable14

.public CutsceneSeq__FuncTable20
CutsceneSeq__FuncTable20: // 0x0215B544
	.word 0, CutsceneSeq__FuncTable20__Func_2155CD0
	.word CutsceneSeq__FuncTable20__Func_2155D34, CutsceneSeq__FuncTable20__Func_2155DA4
	.word CutsceneSeq__FuncTable20__Func_2155E08, CutsceneSeq__FuncTable20__Func_2155E78
	.word CutsceneSeq__FuncTable20__Func_2155EDC, CutsceneSeq__FuncTable20__Func_2155F0C
	.word CutsceneSeq__FuncTable20__Func_2155F44, CutsceneSeq__FuncTable20__Func_2155FA8
	.word CutsceneSeq__FuncTable20__Func_215600C, CutsceneSeq__FuncTable20__Func_2156078
	
