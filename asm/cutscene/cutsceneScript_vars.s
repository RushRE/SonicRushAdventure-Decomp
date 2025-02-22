	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public CutsceneScript__UnknownEngineCommands
CutsceneScript__UnknownEngineCommands: // 0x0215B1C0
    .word 0
	
.public CutsceneScript__EngineTextCommands
CutsceneScript__EngineTextCommands: // 0x0215B1C4
    .word CutsceneScript__TextFunc__Execute
	
.public CutsceneScript__BackgroundCommands
CutsceneScript__BackgroundCommands: // 0x0215B1C8
    .word CutsceneScript__BackgroundCommand__LoadBBG
    .word CutsceneScript__BackgroundCommand__Func_2154494
    .word CutsceneScript__BackgroundCommand__Func_21544BC
    .word CutsceneScript__BackgroundCommand__Func_2154504
    .word CutsceneScript__BackgroundCommand__Func_215455C
    .word CutsceneScript__BackgroundCommand__Func_21545B0
	
.public CutsceneScript__SystemCommands
CutsceneScript__SystemCommands: // 0x0215B1E0
    .word 0
    .word CutsceneScript__SystemCommand__GetPadInputMask
    .word CutsceneScript__SystemCommand__GetTouchPos
    .word CutsceneScript__SystemCommand__GetGameLanguage
    .word CutsceneScript__SystemCommand__GetVCount
    .word CutsceneScript__SystemCommand__GetBrightness
	
.public CutsceneScript__FileSystemCommands
CutsceneScript__FileSystemCommands: // 0x0215B1F8
    .word CutsceneScript__FileSystemCommand__Func_2153C90
    .word CutsceneScript__FileSystemCommand__Func_2153CE8
    .word CutsceneScript__FileSystemCommand__Func_2153D10
    .word CutsceneScript__FileSystemCommand__MountArchive
    .word CutsceneScript__FileSystemCommand__UnmountArchive
    .word CutsceneScript__FileSystemCommand__Func_2153DAC
    .word CutsceneScript__FileSystemCommand__Func_2153DDC
	
.public CutsceneScript__ModelCommands
CutsceneScript__ModelCommands: // 0x0215B214
    .word CutsceneScript__ModelCommand__LoadMDL
    .word CutsceneScript__ModelCommand__Func_2154684
    .word CutsceneScript__ModelCommand__Func_21546AC
    .word CutsceneScript__ModelCommand__LoadMDL2
    .word CutsceneScript__ModelCommand__LoadAniMDL
    .word CutsceneScript__ModelCommand__Func_215483C
    .word CutsceneScript__ModelCommand__Func_21548A8
    .word CutsceneScript__ModelCommand__Func_21549E4
    .word CutsceneScript__ModelCommand__Func_2154A50
    .word CutsceneScript__ModelCommand__Func_2154ABC
    .word CutsceneScript__ModelCommand__Func_2154B10
    .word CutsceneScript__ModelCommand__Func_2154B64
    .word CutsceneScript__ModelCommand__Func_2154BF8
    .word CutsceneScript__ModelCommand__LoadDrawState
    .word CutsceneScript__ModelCommand__Func_2154CCC
	
.public CutsceneScript__SpriteCommands
CutsceneScript__SpriteCommands: // 0x0215B250
    .word CutsceneScript__SpriteCommand__LoadSprite
    .word CutsceneScript__SpriteCommand__Func_2153EB4
    .word CutsceneScript__SpriteCommand__Func_2153EDC
    .word CutsceneScript__SpriteCommand__LoadSprite2
    .word CutsceneScript__SpriteCommand__SetAnimation
    .word CutsceneScript__SpriteCommand__SetSpritePosition
    .word CutsceneScript__SpriteCommand__SetSpriteVisible
    .word CutsceneScript__SpriteCommand__SetSpriteLoopFlag
    .word CutsceneScript__SpriteCommand__SetSpriteFlip
    .word CutsceneScript__SpriteCommand__SetSpritePriority
    .word CutsceneScript__SpriteCommand__SetSpriteType
    .word CutsceneScript__SpriteCommand__Func_2154240
    .word CutsceneScript__SpriteCommand__GetSpritePosition
    .word CutsceneScript__SpriteCommand__GetSpritePalette
    .word CutsceneScript__SpriteCommand__Func_2154320
    .word CutsceneScript__SpriteCommand__Func_2154384
    .word CutsceneScript__SpriteCommand__Func_21543AC
	
.public CutsceneScript__SoundCommands
CutsceneScript__SoundCommands: // 0x0215B294
    .word CutsceneScript__SoundCommand_LoadSndArc
    .word CutsceneScript__SoundCommand_SetVolume
    .word CutsceneScript__SoundCommand_MoveVolume
    .word CutsceneScript__SoundCommand_LoadSndArcGroup
    .word CutsceneScript__SoundCommand_LoadSndArcSeq
    .word CutsceneScript__SoundCommand_LoadSndArcSeqArc
    .word CutsceneScript__SoundCommand_LoadSndArcBank
    .word CutsceneScript__SoundCommand_PlayTrack
    .word CutsceneScript__SoundCommand_PlayTrackEx
    .word CutsceneScript__SoundCommand_PlaySequence
    .word CutsceneScript__SoundCommand_PlaySequenceEx
    .word CutsceneScript__SoundCommand_PlayVoiceClip
    .word CutsceneScript__SoundCommand_PlayVoiceClipEx
    .word CutsceneScript__SoundCommand_FadeSeq
    .word CutsceneScript__SoundCommand_FadeAllSeq
    .word CutsceneScript__SoundCommand_SetTrackPan
    .word CutsceneScript__SoundCommand_SetPlayerPriority
	
.public CutsceneScript__ScreenCommands
CutsceneScript__ScreenCommands: // 0x0215B2D8
    .word CutsceneScript__ScreenCommand__InitVRAMSystem
    .word CutsceneScript__ScreenCommand__SetupBGBank
    .word CutsceneScript__ScreenCommand__SetupOBJBank
    .word CutsceneScript__ScreenCommand__SetupBGExtPalBank
    .word CutsceneScript__ScreenCommand__SetupOBJExtPalBank
    .word CutsceneScript__ScreenCommand__SetupTextureBank
    .word CutsceneScript__ScreenCommand__SetupTexturePalBank
    .word CutsceneScript__ScreenCommand__SetGraphicsMode
    .word CutsceneScript__ScreenCommand__SetBackgroundControlText
    .word CutsceneScript__ScreenCommand__SetBackgroundControlAffine
    .word CutsceneScript__ScreenCommand__SetCurrentDisplay
    .word CutsceneScript__ScreenCommand__ProcessFadeTask
    .word CutsceneScript__ScreenCommand__CreateFadeTask
    .word CutsceneScript__ScreenCommand__SetVisiblePlane
    .word CutsceneScript__ScreenCommand__SetBackgroundPriority
    .word CutsceneScript__ScreenCommand__SetBlendPlane
    .word CutsceneScript__ScreenCommand__SetBlendEffect
    .word CutsceneScript__ScreenCommand__SetBlendAlpha
    .word CutsceneScript__ScreenCommand__SetBlendCoefficient
    .word CutsceneScript__ScreenCommand__SetWindowVisible
    .word CutsceneScript__ScreenCommand__SetWindowPlane
    .word CutsceneScript__ScreenCommand__SetWindowPosition
    .word CutsceneScript__ScreenCommand__Unknown
    .word CutsceneScript__ScreenCommand__SetCapture
    .word CutsceneScript__ScreenCommand__ShakeScreen1
    .word CutsceneScript__ScreenCommand__ShakeScreen2

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

.public CutsceneScript__TextCommands
CutsceneScript__TextCommands: // 0x0215B3D4
    .word CutsceneScript__TextCommand__LoadFontFile
    .word CutsceneScript__TextCommand__Func_2159B14
    .word CutsceneScript__TextCommand__LoadMPCFile
    .word CutsceneScript__TextCommand__SetMsgSeq
    .word CutsceneScript__TextCommand__Func_2159C68
    .word CutsceneScript__TextCommand__Func_2159C88
    .word CutsceneScript__TextCommand__Func_2159CA8
    .word CutsceneScript__TextCommand__Func_2159CC8
    .word CutsceneScript__TextCommand__Func_2159CD8
    .word CutsceneScript__TextCommand__LoadCharacters
    .word CutsceneScript__TextCommand__LoadCharactersConditional
    .word CutsceneScript__TextCommand__IsEndOfLine
    .word CutsceneScript__TextCommand__AdvanceDialog
    .word CutsceneScript__TextCommand__IsLastDialog
    .word CutsceneScript__TextCommand__Draw

.public _0215B410
_0215B410: // 0x0215B410
	.word 0, 1, 3, 7, 0xF, 0x1F, 0x3F, 0x7F, 0xFF, 0x1FF, 0x3FF
	.word 0x7FF, 0xFFF, 0x1FFF, 0x3FFF, 0x7FFF, 0xFFFF
	
	.data

.public CutsceneScript__EngineCommandTable
CutsceneScript__EngineCommandTable: // 0x0215B460
    .word CutsceneScript__SystemCommands
    .word CutsceneScript__ScreenCommands
    .word CutsceneScript__FileSystemCommands
    .word CutsceneScript__SpriteCommands
    .word CutsceneScript__BackgroundCommands
    .word CutsceneScript__ModelCommands
    .word CutsceneScript__SoundCommands
    .word CutsceneScript__EngineTextCommands
    .word CutsceneScript__UnknownEngineCommands

.public CutsceneScript__EngineInstructionTable
CutsceneScript__EngineInstructionTable: // 0x0215B484
	.word 0
    .word CutsceneScript__EngineCommand_Execute

.public CutsceneScript__UnknownCommands
CutsceneScript__UnknownCommands: // 0x0215B48C
	.word 0
    .word CutsceneScript__UnknownCommand_215636C
    .word CutsceneScript__UnknownCommand_21563D8

.public CutsceneScript__EndCommands
CutsceneScript__EndCommands: // 0x0215B498
    .word CutsceneScript__EndCommand_StopThreads
    .word CutsceneScript__EndCommand_Continue
    .word CutsceneScript__EndCommand_Suspend

.public CutsceneScript__StackCommands
CutsceneScript__StackCommands: // 0x0215B4A4
    .word 0
    .word CutsceneScript__StackCommand_Load
    .word CutsceneScript__StackCommand_Store

.public CutsceneScript__FunctionCommands
CutsceneScript__FunctionCommands: // 0x0215B4B0
    .word 0
    .word CutsceneScript__FunctionCommand_CallFunction
    .word CutsceneScript__FunctionCommand_EndFunction
    .word CutsceneScript__FunctionCommand_CallFunctionASync
    .word CutsceneScript__FunctionCommand_End

.public CutsceneScript__ComparisonCommands
CutsceneScript__ComparisonCommands: // 0x0215B4C4
    .word 0
    .word CutsceneScript__ComparisonCommand_Equal
    .word CutsceneScript__ComparisonCommand_NotEqual
    .word CutsceneScript__ComparisonCommand_Less
    .word CutsceneScript__ComparisonCommand_LessEqual
    .word CutsceneScript__ComparisonCommand_Greater
    .word CutsceneScript__ComparisonCommand_GreaterEqual

.public CutsceneScript__IfCommands
CutsceneScript__IfCommands: // 0x0215B4E0
    .word CutsceneScript__IfCommand_Branch
    .word CutsceneScript__IfCommand_IfEqual
    .word CutsceneScript__IfCommand_IfNotEqual
    .word CutsceneScript__IfCommand_IfGreaterEqual
    .word CutsceneScript__IfCommand_IfGreater
    .word CutsceneScript__IfCommand_IfLessEqual
    .word CutsceneScript__IfCommand_IfLess

.public CutsceneScript__ArithmeticCommands
CutsceneScript__ArithmeticCommands: // 0x0215B4FC
    .word CutsceneScript__ArithmeticCommand_Assign
    .word CutsceneScript__ArithmeticCommand_Add
    .word CutsceneScript__ArithmeticCommand_Subtract
    .word CutsceneScript__ArithmeticCommand_Multiply
    .word CutsceneScript__ArithmeticCommand_Divide
    .word CutsceneScript__ArithmeticCommand_Negate
    .word CutsceneScript__ArithmeticCommand_Increment
    .word CutsceneScript__ArithmeticCommand_Decrement
    .word CutsceneScript__ArithmeticCommand_ShiftR

.public CutsceneScript__InstructionTable
CutsceneScript__InstructionTable: // 0x0215B520
    .word CutsceneScript__EndCommands
    .word CutsceneScript__ArithmeticCommands
    .word CutsceneScript__BitwiseCommands
    .word CutsceneScript__ComparisonCommands
    .word CutsceneScript__UnknownCommands
    .word CutsceneScript__IfCommands
    .word CutsceneScript__FunctionCommands
    .word CutsceneScript__EngineInstructionTable
    .word CutsceneScript__StackCommands

.public CutsceneScript__BitwiseCommands
CutsceneScript__BitwiseCommands: // 0x0215B544
	.word 0
    .word CutsceneScript__BitwiseCommand_BitwiseAND
	.word CutsceneScript__BitwiseCommand_LogicalAND
    .word CutsceneScript__BitwiseCommand_BitwiseOR
	.word CutsceneScript__BitwiseCommand_LogicalOR
    .word CutsceneScript__BitwiseCommand_XOR
	.word CutsceneScript__BitwiseCommand_BitwiseNot
    .word CutsceneScript__BitwiseCommand_LogicalNot
	.word CutsceneScript__BitwiseCommand_ShiftL
    .word CutsceneScript__BitwiseCommand_ShiftR
	.word CutsceneScript__BitwiseCommand_RotateL
    .word CutsceneScript__BitwiseCommand_RotateR
	
