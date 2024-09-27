#include <nitro/cht.h>
#include <nitro/mi.h>
#include <nonmatching.h>

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u16 magicNumber;
    u8 ver;
    u8 platform;

    union
    {
        struct
        {
            u16 high;
            u16 low;
        };
        u32 value;
    } ggid;
} GameInfoHeader;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC BOOL CHT_IsPictochatParent(const WMBssDesc *pWmBssDesc)
{
    // https://decomp.me/scratch/ge2te -> 97.44%
#ifdef NON_MATCHING
    GameInfoHeader info;

    if (pWmBssDesc == NULL)
        return FALSE;

    if (pWmBssDesc->gameInfoLength == 0)
        return FALSE;

    MI_CpuCopy8(pWmBssDesc->gameInfo.userGameInfo, &info, sizeof(info));
    DC_StoreRange(&info, sizeof(info));

    if (pWmBssDesc->gameInfo.ggid == 0x00000000)
    {
        if (info.magicNumber == 0x2348 || info.magicNumber == 0xBD8A)
        {
            if (info.ggid.low == 4)
            {
                return TRUE;
            }
        }
    }

    return FALSE;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrh r0, [r4, #0x3c]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r1, sp, #0
	add r0, r4, #0x50
	mov r2, #8
	bl MI_CpuCopy8
	add r0, sp, #0
	mov r1, #8
	bl DC_StoreRange
	ldr r0, [r4, #0x44]
	cmp r0, #0
	bne _020FCE40
	ldrh r1, [sp]
	ldr r0, =0x00002348
	cmp r1, r0
	beq _020FCE28
	ldrh r1, [sp]
	ldr r0, =0x0000BD8A
	cmp r1, r0
	bne _020FCE40
_020FCE28:
	ldrh r0, [sp, #6]
	cmp r0, #4
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020FCE40:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
// clang-format on
#endif
}