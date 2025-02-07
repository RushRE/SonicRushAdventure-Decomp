	.include "asm/macros.inc"
	.include "global.inc"

.public _ZTVN10__cxxabiv117__class_type_infoE
.public _ZTVN10__cxxabiv120__si_class_type_infoE

    .data	

.public _ZTI11CVi3dObject_1
_ZTI11CVi3dObject_1: // 0x021738A8
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CVi3dObject

.public _ZTI9CViShadow
_ZTI9CViShadow: // 0x021738B0
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS9CViShadow

.public _ZTI10CVi3dArrow
_ZTI10CVi3dArrow: // 0x021738B8
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8, _ZTS10CVi3dArrow, _ZTI11CVi3dObject

.public _ZTS9CViShadow
_ZTS9CViShadow: // 0x021738C4
	.asciz "9CViShadow"
	.align 4

.public _ZTS10CVi3dArrow
_ZTS10CVi3dArrow: // 0x021738D0
	.asciz "10CVi3dArrow"
	.align 4

.public _ZTV11CVi3dObject
_ZTV11CVi3dObject: // 0x021738E0
    .word 0, _ZTI11CVi3dObject
_021738E8: // 0x021738E8
    .word _ZN11CVi3dObjectD0Ev, _ZN11CVi3dObjectD1Ev

.public _ZTV10CVi3dArrow
_ZTV10CVi3dArrow: // 0x021738F0
    .word 0, _ZTI10CVi3dArrow
    .word _ZN10CVi3dArrowD0Ev, _ZN10CVi3dArrowD1Ev

.public _ZTV9CViShadow
_ZTV9CViShadow: // 0x02173900
    .word 0, _ZTI9CViShadow
    .word _ZN9CViShadowD0Ev, _ZN9CViShadowD1Ev