	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.public _ZN11CViDockBackC1Ev
	.public _ZN11CViDockBackD0Ev
	.public _ZN11CViDockBackD1Ev

    .public _ZN11CViDockBack12Collide_BaseEP7VecFx32PKS0_S1_PiS4_Pm
    .public _ZN11CViDockBack16Collide_BaseNextEP7VecFx32PKS0_S1_PiS4_Pm
	.public _ZN11CViDockBack11Collide_JetEP7VecFx32PKS0_S1_PiS4_Pm
    .public _ZN11CViDockBack12Collide_BoatEP7VecFx32PKS0_S1_PiS4_Pm
	.public _ZN11CViDockBack13Collide_HoverEP7VecFx32PKS0_S1_PiS4_Pm
    .public _ZN11CViDockBack17Collide_SubmarineEP7VecFx32PKS0_S1_PiS4_Pm
	.public _ZN11CViDockBack13Collide_BeachEP7VecFx32PKS0_S1_PiS4_Pm
    .public _ZN11CViDockBack18CheckExitArea_BaseEPK7VecFx32
    .public _ZN11CViDockBack22CheckExitArea_BaseNextEPK7VecFx32
	.public _ZN11CViDockBack17CheckExitArea_JetEPK7VecFx32
    .public _ZN11CViDockBack18CheckExitArea_BoatEPK7VecFx32
	.public _ZN11CViDockBack19CheckExitArea_HoverEPK7VecFx32
    .public _ZN11CViDockBack23CheckExitArea_SubmarineEPK7VecFx32
	.public _ZN11CViDockBack19CheckExitArea_BeachEPK7VecFx32
    .public _ZN11CViDockBack23PlayerSpawnConfig_BeachEP7VecFx32Ptl
    .public _ZN11CViDockBack27PlayerSpawnConfig_SubmarineEP7VecFx32Ptl
	.public _ZN11CViDockBack23PlayerSpawnConfig_HoverEP7VecFx32Ptl
    .public _ZN11CViDockBack22PlayerSpawnConfig_BoatEP7VecFx32Ptl
	.public _ZN11CViDockBack21PlayerSpawnConfig_JetEP7VecFx32Ptl
    .public _ZN11CViDockBack26PlayerSpawnConfig_BaseNextEP7VecFx32Ptl
	.public _ZN11CViDockBack22PlayerSpawnConfig_BaseEP7VecFx32Ptl
    .public _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .public _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
	.public _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .public _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
	.public _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .public _ZN11CViDockBack22GetGroundPos_SubmarineEPK7VecFx32
	.public _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .public _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
    .public _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
	.public _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
    .public _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
	.public _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
    .public _ZN11CViDockBack20DrawShadow_SubmarineEP9CViShadowlll
	.public _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll

	.data

.public _ZTI11CViDockBack
_ZTI11CViDockBack: // 0x0217376C
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CViDockBack

.public handleCollisionsForArea
handleCollisionsForArea: // 0x02173774
    .word _ZN11CViDockBack12Collide_BaseEP7VecFx32PKS0_S1_PiS4_Pm
    .word _ZN11CViDockBack16Collide_BaseNextEP7VecFx32PKS0_S1_PiS4_Pm
	.word _ZN11CViDockBack11Collide_JetEP7VecFx32PKS0_S1_PiS4_Pm
    .word _ZN11CViDockBack12Collide_BoatEP7VecFx32PKS0_S1_PiS4_Pm
	.word _ZN11CViDockBack13Collide_HoverEP7VecFx32PKS0_S1_PiS4_Pm
    .word _ZN11CViDockBack17Collide_SubmarineEP7VecFx32PKS0_S1_PiS4_Pm
	.word _ZN11CViDockBack13Collide_BeachEP7VecFx32PKS0_S1_PiS4_Pm

.public checkAreaExitForArea
checkAreaExitForArea: // 0x02173790
    .word _ZN11CViDockBack18CheckExitArea_BaseEPK7VecFx32
    .word _ZN11CViDockBack22CheckExitArea_BaseNextEPK7VecFx32
	.word _ZN11CViDockBack17CheckExitArea_JetEPK7VecFx32
    .word _ZN11CViDockBack18CheckExitArea_BoatEPK7VecFx32
	.word _ZN11CViDockBack19CheckExitArea_HoverEPK7VecFx32
    .word _ZN11CViDockBack23CheckExitArea_SubmarineEPK7VecFx32
	.word _ZN11CViDockBack19CheckExitArea_BeachEPK7VecFx32

.public getPlayerSpawnConfigForArea
getPlayerSpawnConfigForArea: // 0x021737AC
	.word _ZN11CViDockBack22PlayerSpawnConfig_BaseEP7VecFx32Ptl
    .word _ZN11CViDockBack26PlayerSpawnConfig_BaseNextEP7VecFx32Ptl
	.word _ZN11CViDockBack21PlayerSpawnConfig_JetEP7VecFx32Ptl
    .word _ZN11CViDockBack22PlayerSpawnConfig_BoatEP7VecFx32Ptl
	.word _ZN11CViDockBack23PlayerSpawnConfig_HoverEP7VecFx32Ptl
    .word _ZN11CViDockBack27PlayerSpawnConfig_SubmarineEP7VecFx32Ptl
    .word _ZN11CViDockBack23PlayerSpawnConfig_BeachEP7VecFx32Ptl

.public getGroundPosForDockArea
getGroundPosForDockArea: // 0x021737C8
    .word _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .word _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
	.word _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .word _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
	.word _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32
    .word _ZN11CViDockBack22GetGroundPos_SubmarineEPK7VecFx32
	.word _ZN11CViDockBack19GetGroundPos_CommonEPK7VecFx32

.public drawShadowForArea
drawShadowForArea: // 0x021737E4
    .word _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
    .word _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
	.word _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
    .word _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
	.word _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll
    .word _ZN11CViDockBack20DrawShadow_SubmarineEP9CViShadowlll
	.word _ZN11CViDockBack17DrawShadow_CommonEP9CViShadowlll

.public _ZTS11CViDockBack
_ZTS11CViDockBack: // 0x02173800
	.asciz "11CViDockBack"
	.align 4

.public _ZTV11CViDockBack
_ZTV11CViDockBack: // 0x02173810
    .word 0, _ZTI11CViDockBack
    .word _ZN11CViDockBackD0Ev, _ZN11CViDockBackD1Ev