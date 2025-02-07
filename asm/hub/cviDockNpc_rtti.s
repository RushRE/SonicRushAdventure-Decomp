	.include "asm/macros.inc"
	.include "global.inc"

.public _ZTVN10__cxxabiv117__class_type_infoE
.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.data

.public _ZTI11CVi3dObject_0
_ZTI11CVi3dObject_0: // 0x02173874
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CVi3dObject

.public _ZTI10CViDockNpc
_ZTI10CViDockNpc: // 0x0217387C
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8, _ZTS10CViDockNpc, _ZTI11CVi3dObject

.public _ZTS10CViDockNpc
_ZTS10CViDockNpc: // 0x02173888
	.asciz "10CViDockNpc"
	.align 4

.public _ZTV10CViDockNpc
_ZTV10CViDockNpc: // 0x02173898
    .word 0, _ZTI10CViDockNpc
    .word _ZN10CViDockNpcD0Ev, _ZN10CViDockNpcD1Ev