	.include "asm/macros.inc"
	.include "global.inc"

.public _ZTVN10__cxxabiv117__class_type_infoE
.public _ZTVN10__cxxabiv120__si_class_type_infoE

    .data	

.public _ZTI11CVi3dObject
_ZTI11CVi3dObject: // 0x02173820
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CVi3dObject

.public _ZTI13CViDockPlayer
_ZTI13CViDockPlayer: // 0x02173828
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8, _ZTS13CViDockPlayer, _ZTI11CVi3dObject

.public _ZTS11CVi3dObject
_ZTS11CVi3dObject: // 0x02173834
	.asciz "11CVi3dObject"
	.align 4

.public _ZTV13CViDockPlayer
_ZTV13CViDockPlayer: // 0x02173844
    .word 0, _ZTI13CViDockPlayer
    .word _ZN13CViDockPlayerD0Ev, _ZN13CViDockPlayerD1Ev
    
.public _ZTS13CViDockPlayer
_ZTS13CViDockPlayer: // 0x02173854
	.asciz "13CViDockPlayer"
	.align 4