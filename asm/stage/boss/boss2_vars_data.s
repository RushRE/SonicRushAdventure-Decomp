	.include "asm/macros.inc"
	.include "global.inc"

	.data

aTopPl: // 0x0217A720
    .asciz "top_pl"
    .align 4

aEyePl: // 0x0217A728
    .asciz "eye_pl"
    .align 4

aFacePl: // 0x0217A730
    .asciz "face_pl"
    .align 4

aSideBPl: // 0x0217A738
    .asciz "side_b_pl"
    .align 4

aBallAHit: // 0x0217A744
    .asciz "ball_a_hit"
    .align 4

aBallBHit: // 0x0217A750
    .asciz "ball_b_hit"
    .align 4

aBallCHit: // 0x0217A75C
    .asciz "ball_c_hit"
    .align 4

aHTamaAPl: // 0x0217A768
    .asciz "h_tama_a_pl"
    .align 4

aHTamaBPl: // 0x0217A774
    .asciz "h_tama_b_pl"
    .align 4

aHTamaCPl: // 0x0217A780
    .asciz "h_tama_c_pl"
    .align 4

.public Boss2Ball__paletteNames
Boss2Ball__paletteNames: // 0x0217A78C
    .word aHTamaAPl           // "h_tama_a_pl"
	.word aHTamaBPl           // "h_tama_b_pl"
	.word aHTamaCPl           // "h_tama_c_pl"

.public Boss2__paletteNames
Boss2__paletteNames: // 0x0217A798
    .word aEyePl              // "eye_pl"
	.word aFacePl             // "face_pl"
	.word aSetuzokuMekaPl     // "setuzoku_meka_pl"
	.word aSideBPl            // "side_b_pl"
	.word aSideMeka1Pl        // "side_meka1_pl"
	.word aSideMeka2Pl        // "side_meka2_pl"
	.word aSideMeka3Pl        // "side_meka3_pl"
	.word aTopPl              // "top_pl"

aSideMeka2Pl: // 0x0217A7B8
    .asciz "side_meka2_pl"
    .align 4

aSideMeka3Pl: // 0x0217A7C8
    .asciz "side_meka3_pl"
    .align 4

aSideMeka1Pl: // 0x0217A7D8
    .asciz "side_meka1_pl"
    .align 4

aSetuzokuMekaPl: // 0x0217A7E8
    .asciz "setuzoku_meka_pl"
    .align 4