	.include "asm/macros.inc"
	.include "global.inc"

	.rodata

.public Boss1__biteDamageDuration
Boss1__biteDamageDuration: // 0x02179984
    .hword 300, 180
	
.public Boss1__chargeDamageDuration
Boss1__chargeDamageDuration: // 0x02179988
    .hword 300, 180
	
.public Boss1__baseDamageTable
Boss1__baseDamageTable: // 0x0217998C
    .hword 0x040, 0x040
	
.public Boss1__healthPhaseTable
Boss1__healthPhaseTable: // 0x02179990
    .hword 0x300, 0x200, 0x100, 0x000

.public Boss1__damageModifier2
Boss1__damageModifier2: // 0x02179998
    .word 0x0800, 0x0800
	
.public Boss1__neckUpVector
Boss1__neckUpVector: // 0x021799A0
    .word 0, 0x1000, 0

.public Boss1__stageUpVector
Boss1__stageUpVector: // 0x021799AC
    .word 0, 0x1000, 0

.public Boss1__attackTablePhase1_1
Boss1__attackTablePhase1_1: // 0x021799B8
    .word 2, 2, 3, 2
	
.public Boss1__attackTablePhase1_2
Boss1__attackTablePhase1_2: // 0x021799C8
    .word 2, 3, 2, 2
	
.public Boss1__idleConfigTable
Boss1__idleConfigTable: // 0x021799D8
    .hword 180, 63
    .hword 180, 63
    .hword 0, 0
    .hword 0, 0

.public Boss1__attackTablePhase2_1
Boss1__attackTablePhase2_1: // 0x021799E8
    .word 3, 2, 3, 2
	
.public Boss1__attackTablePhase4_1
Boss1__attackTablePhase4_1: // 0x021799F8
    .word 4, 2, 3, 2
	
.public Boss1__attackTablePhase2_2
Boss1__attackTablePhase2_2: // 0x02179A08
    .word 3, 2, 2, 2
	
.public Boss1__attackTablePhase4_2
Boss1__attackTablePhase4_2: // 0x02179A18
    .word 4, 3, 2, 2
	
.public Boss1__attackTablePhase3_1
Boss1__attackTablePhase3_1: // 0x02179A28
    .word 4, 2, 3, 2
	
.public Boss1__attackTablePhase3_2
Boss1__attackTablePhase3_2: // 0x02179A38
    .word 4, 3, 2, 2
	
	.data

aZ1AgoPl: // 0x0217A4EC
    .asciz "z1_ago_pl"
    .align 4

aZ1HandPl: // 0x0217A4F8
    .asciz "z1_hand_pl"
    .align 4

aZ1HizaPl: // 0x0217A504
    .asciz "z1_hiza_pl"
    .align 4

aZ1HeadPl: // 0x0217A510
    .asciz "z1_head_pl"
    .align 4

aZ1KutiPl: // 0x0217A51C
    .asciz "z1_kuti_pl"
    .align 4

aZ1UnitPl: // 0x0217A528
    .asciz "z1_unit_pl"
    .align 4

aZ1WeekPl: // 0x0217A534
    .asciz "z1_week_pl"
    .align 4

aZ1TunoPl: // 0x0217A540
    .asciz "z1_tuno_pl"
    .align 4

aZ1JoinPl: // 0x0217A54C
    .asciz "z1_join_pl"
    .align 4

aZ1ArmAPl: // 0x0217A558
    .asciz "z1_arm_a_pl"
    .align 4

aZ1Unit2Pl: // 0x0217A564
    .asciz "z1_unit2_pl"
    .align 4

aZ1ArmBPl: // 0x0217A570
    .asciz "z1_arm_b_pl"
    .align 4

aZ1LegAPl: // 0x0217A57C
    .asciz "z1_leg_a_pl"
    .align 4

aZ1Join2Pl: // 0x0217A588
    .asciz "z1_join2_pl"
    .align 4

aZ1StomacPl: // 0x0217A594
    .asciz "z1_stomac_pl"
    .align 4

aZ1UlegAPl: // 0x0217A5A4
    .asciz "z1_uleg_a_pl"
    .align 4

aZ1BodyAPl: // 0x0217A5B4
    .asciz "z1_body_a_pl"
    .align 4

aZ1UnitBPl: // 0x0217A5C4
    .asciz "z1_unit_b_pl"
    .align 4

aZ1AsimotoPl: // 0x0217A5D4
    .asciz "z1_asimoto_pl"
    .align 4

aZ1LegjoinPl: // 0x0217A5E4
    .asciz "z1_legjoin_pl"
    .align 4

aZ1Tail2BPl: // 0x0217A5F4
    .asciz "z1_tail2_b_pl"
    .align 4

aZ1AsisakiPl: // 0x0217A604
    .asciz "z1_asisaki_pl"
    .align 4

aZ1SetuzokuPl: // 0x0217A614
    .asciz "z1_setuzoku_pl"
    .align 4

.public Boss1__attackTablesPhase3
Boss1__attackTablesPhase3: // 0x0217A624
    .word Boss1__attackTablePhase3_1
	.word Boss1__attackTablePhase3_1
	.word Boss1__attackTablePhase3_2
	.word Boss1__attackTablePhase3_2

.public Boss1__attackTablesPhase1
Boss1__attackTablesPhase1: // 0x0217A634
    .word Boss1__attackTablePhase1_1
	.word Boss1__attackTablePhase1_1
	.word Boss1__attackTablePhase1_2
	.word Boss1__attackTablePhase1_2

.public Boss1__attackTablesForPhase
Boss1__attackTablesForPhase: // 0x0217A644
    .word Boss1__attackTablesPhase1
	.word Boss1__attackTablesPhase2
	.word Boss1__attackTablesPhase3
	.word Boss1__attackTablesPhase4

.public Boss1__attackTablesPhase2
Boss1__attackTablesPhase2: // 0x0217A654
    .word Boss1__attackTablePhase2_1
	.word Boss1__attackTablePhase2_1
	.word Boss1__attackTablePhase2_2
	.word Boss1__attackTablePhase2_2

.public Boss1__attackTablesPhase4
Boss1__attackTablesPhase4: // 0x0217A664
    .word Boss1__attackTablePhase4_1
	.word Boss1__attackTablePhase4_1
	.word Boss1__attackTablePhase4_2
	.word Boss1__attackTablePhase4_2

.public Boss1__paletteNameTable
Boss1__paletteNameTable: // 0x0217A674
    .word aZ1AgoPl            // "z1_ago_pl"
	.word aZ1ArmAPl           // "z1_arm_a_pl"
	.word aZ1ArmBPl           // "z1_arm_b_pl"
	.word aZ1AsimotoPl        // "z1_asimoto_pl"
	.word aZ1AsisakiPl        // "z1_asisaki_pl"
	.word aZ1BodyAPl          // "z1_body_a_pl"
	.word aZ1HandPl           // "z1_hand_pl"
	.word aZ1HeadPl           // "z1_head_pl"
	.word aZ1HizaPl           // "z1_hiza_pl"
	.word aZ1Join2Pl          // "z1_join2_pl"
	.word aZ1JoinPl           // "z1_join_pl"
	.word aZ1KutiPl           // "z1_kuti_pl"
	.word aZ1LegAPl           // "z1_leg_a_pl"
	.word aZ1LegjoinPl        // "z1_legjoin_pl"
	.word aZ1SetuzokuPl       // "z1_setuzoku_pl"
	.word aZ1StomacPl         // "z1_stomac_pl"
	.word aZ1Tail2BPl         // "z1_tail2_b_pl"
	.word aZ1TunoPl           // "z1_tuno_pl"
	.word aZ1UlegAPl          // "z1_uleg_a_pl"
	.word aZ1UlegSidePl       // "z1_uleg_side_pl"
	.word aZ1Unit2Pl          // "z1_unit2_pl"
	.word aZ1UnitPl           // "z1_unit_pl"
	.word aZ1UnitBPl          // "z1_unit_b_pl"
	.word aZ1WeekPl           // "z1_week_pl"

aZ1UlegSidePl: // 0x0217A6D4
    .asciz "z1_uleg_side_pl"
    .align 4

.public Boss1__path_none
Boss1__path_none: // 0x0217A6E4
    .word 0
	
aBoss1Nsbca: // 0x0217A6E8
    .asciz "/boss1.nsbca"
    .align 4

aBoss1Nsbva: // 0x0217A6F8
    .asciz "/boss1.nsbva"
    .align 4

.public aWeak
aWeak: // 0x0217A708
    .asciz "weak"
    .align 4

aBodyNeck: // 0x0217A710
    .asciz "body_neck"
    .align 4

.public aExc_2
aExc_2: // 0x0217A71C
    .asciz "exc"
    .align 4
