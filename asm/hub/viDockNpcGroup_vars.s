	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.data

.public ViDockNpcGroup__talkAction
ViDockNpcGroup__talkAction:
	.word 0x20
	
.public _02173968
_02173968:
	.word CreateViDockNpcTalk
	.word Task__OV05Unknown2168C48__Create
	.word ViTalkPurchase__Create
	.word ViTalkList__Create
	.word _ZN15CViDockNpcGroup12Func_2168764Ev
	.word ViTalkList__Func_216B6B4
	.word _ZN15CViDockNpcGroup12Func_2168798Ev
	.word NpcOptions__Create
	.word NpcViking__Create
	.word NpcMission__Create
	.word _ZN15CViDockNpcGroup12Func_216879CEm