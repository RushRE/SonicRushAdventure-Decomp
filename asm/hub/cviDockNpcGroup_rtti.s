	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE	
    
    .public _ZN15CViDockNpcGroupD0Ev
    .public _ZN15CViDockNpcGroupD1Ev

    .data
.public _ZTI15CViDockNpcGroup
_ZTI15CViDockNpcGroup: // 0x02173938
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS15CViDockNpcGroup
	
.public _ZTV15CViDockNpcGroup
_ZTV15CViDockNpcGroup: // 0x02173940
    .word 0, _ZTI15CViDockNpcGroup
    .word _ZN15CViDockNpcGroupD0Ev, _ZN15CViDockNpcGroupD1Ev

.public _ZTS15CViDockNpcGroup
_ZTS15CViDockNpcGroup: // 0x02173950
	.asciz "15CViDockNpcGroup"
	.align 4