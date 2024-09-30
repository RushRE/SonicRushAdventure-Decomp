#include <game/object/objRect.h>
#include <game/math/mtMath.h>
#include <stage/stageTask.h>
#include <game/object/objectManager.h>

// --------------------
// STRUCTS
// --------------------

struct OBS_RECT_MANAGER
{
    u8 ucNoHit;
    u16 resist_all_num;
    u16 resist_all_num_nx;
    u32 ulFlagBackD;
    u32 ulFlagBackA;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED struct OBS_RECT_MANAGER _obj_user_rect_man;

NOT_DECOMPILED u16 _obj_user_flag_nx[OBS_RECT_GROUP_COUNT];
NOT_DECOMPILED u16 _obj_user_flag[OBS_RECT_GROUP_COUNT];

NOT_DECOMPILED OBS_RECT_WORK *_obj_user_resist[OBS_RECT_REGISTER_MAX];
NOT_DECOMPILED OBS_RECT_WORK *_obj_user_resist_nx[OBS_RECT_REGISTER_MAX];

NOT_DECOMPILED u8 _obj_user_resist_num_nx[OBS_RECT_GROUP_COUNT];
NOT_DECOMPILED u8 _obj_user_resist_num[OBS_RECT_GROUP_COUNT];

// --------------------
// INLINE FUNCTIONS
// --------------------

/*
RUSH_INLINE BOOL OBM_LINE_AND_LINE(s32 x0, s32 w0, s32 x1, s32 w1)
{
    if (x0 <= x1 && x0 + w0 >= x1)
        return TRUE;

    return x0 >= x1 && x1 + w1 >= x0;
}*/

#define OBM_LINE_AND_LINE(x0, w0, x1, w1) (((x0) <= (x1) && (x0) + (w0) >= (x1)) || ((x0) >= (x1) && (x1) + (w1) >= (x0)))
#define OBM_POINT_IN_LINE(x0, w0, x1)     ((x0) <= (x1) && (x0) + (w0) >= (x1))

// --------------------
// FUNCTIONS
// --------------------

void ObjRect__SetBox2D(OBS_RECT *rect, s16 left, s16 top, s16 right, s16 bottom)
{
    rect->left   = left;
    rect->top    = top;
    rect->right  = right;
    rect->bottom = bottom;
    rect->back   = -16;
    rect->front  = 16;

    if (rect->right < rect->left)
    {
        XOR_SWAP(rect->left, rect->right);
    }

    if (rect->bottom < rect->top)
    {
        XOR_SWAP(rect->top, rect->bottom);
    }

    VEC_Set(&rect->pos, 0, 0, 0);
}

void ObjRect__SetBox3D(OBS_RECT *rect, s16 left, s16 top, s16 back, s16 right, s16 bottom, s16 front)
{
    rect->left   = left;
    rect->top    = top;
    rect->right  = right;
    rect->bottom = bottom;
    rect->back   = back;
    rect->front  = front;

    if (rect->right < rect->left)
    {
        XOR_SWAP(rect->left, rect->right);
    }

    if (rect->bottom < rect->top)
    {
        XOR_SWAP(rect->top, rect->bottom);
    }

    if (rect->front < rect->back)
    {
        XOR_SWAP(rect->back, rect->front);
    }

    VEC_Set(&rect->pos, 0, 0, 0);
}

void ObjRect__SetBox(OBS_RECT_WORK *work, s16 left, s16 top, s16 right, s16 bottom)
{
    work->flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    ObjRect__SetBox2D(&work->rect, left, top, right, bottom);
}

void ObjRect__SetAttackStat(OBS_RECT_WORK *work, u16 atkFlag, u16 atkPower)
{
    work->flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->hitFlag  = atkFlag;
    work->hitPower = atkPower;
    work->flag &= ~OBS_RECT_WORK_FLAG_200;
    work->flag &= ~OBS_RECT_WORK_FLAG_10000;
}

void ObjRect__SetDefenceStat(OBS_RECT_WORK *work, u16 defFlag, u16 defPower)
{
    work->flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->defFlag  = defFlag;
    work->defPower = defPower;
    work->flag &= ~OBS_RECT_WORK_FLAG_100;
}

void ObjRect__HitAgain(OBS_RECT_WORK *work)
{
    if ((work->flag & OBS_RECT_WORK_FLAG_400) == 0)
    {
        work->flag &= ~OBS_RECT_WORK_FLAG_100;
        work->flag &= ~OBS_RECT_WORK_FLAG_200;
    }
}

void ObjRect__CheckInit(void)
{
    MI_CpuClear8(_obj_user_resist, sizeof(_obj_user_resist));
    MI_CpuClear8(_obj_user_resist_nx, sizeof(_obj_user_resist_nx));

    MI_CpuClear8(_obj_user_resist_num, sizeof(_obj_user_resist_num));
    MI_CpuClear8(_obj_user_resist_num_nx, sizeof(_obj_user_resist_num_nx));

    MI_CpuClear8(_obj_user_flag, sizeof(_obj_user_flag));
    MI_CpuClear8(_obj_user_flag_nx, sizeof(_obj_user_flag_nx));

    _obj_user_rect_man.resist_all_num    = 0;
    _obj_user_rect_man.resist_all_num_nx = 0;
    _obj_user_rect_man.ulFlagBackA       = 0;
    _obj_user_rect_man.ulFlagBackD       = 0;
    _obj_user_rect_man.ucNoHit           = FALSE;
}

void ObjRect__CheckOut(void)
{
    MI_CpuCopy8(_obj_user_resist_nx, _obj_user_resist, sizeof(_obj_user_resist));
    MI_CpuClear8(_obj_user_resist_nx, sizeof(_obj_user_resist_nx));

    MI_CpuCopy8(_obj_user_resist_num_nx, _obj_user_resist_num, sizeof(_obj_user_resist_num));
    MI_CpuClear8(_obj_user_resist_num_nx, sizeof(_obj_user_resist_num_nx));

    MI_CpuCopy8(_obj_user_flag_nx, _obj_user_flag, sizeof(_obj_user_flag));
    MI_CpuClear8(_obj_user_flag_nx, sizeof(_obj_user_flag_nx));

    _obj_user_rect_man.resist_all_num    = _obj_user_rect_man.resist_all_num_nx;
    _obj_user_rect_man.resist_all_num_nx = 0;

    for (u16 g = 0; g < (_obj_user_rect_man.resist_all_num - 1); g++)
    {
        for (u16 i = (u16)(_obj_user_rect_man.resist_all_num - 1); i > g; i--)
        {
            if ((s32)(_obj_user_resist[i]->groupFlags & 0xFF) < (s32)(_obj_user_resist[i - 1]->groupFlags & 0xFF))
            {
                OBS_RECT_WORK *work     = _obj_user_resist[i - 1];
                _obj_user_resist[i - 1] = _obj_user_resist[i];
                _obj_user_resist[i]     = work;
            }
        }
    }
}

void ObjRect__Register(OBS_RECT_WORK *work)
{
    if ((work->flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) == 0)
        return;

    for (u16 g = 0; g < OBS_RECT_GROUP_COUNT; g++)
    {
        if ((work->groupFlags & (1 << g)) == 0)
            continue;

        if (_obj_user_rect_man.resist_all_num_nx >= OBS_RECT_REGISTER_MAX)
            return;

        _obj_user_resist_nx[_obj_user_rect_man.resist_all_num_nx] = work;
        _obj_user_flag_nx[g] |= work->groupFlags;
        _obj_user_resist_num_nx[g]++;
        _obj_user_rect_man.resist_all_num_nx++;
        break;
    }
}

void ObjRect__CheckAllGroup(void)
{
    u16 i;
    u16 atkGroupOffset;
    u16 defGroupOffset;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_20000) != 0)
        ObjRect__CheckOut();

    _obj_user_rect_man.ulFlagBackA = 0;
    _obj_user_rect_man.ulFlagBackD = 0;
    _obj_user_rect_man.ucNoHit     = FALSE;

    u16 count = _obj_user_rect_man.resist_all_num;
    for (i = 0; i < count; i++)
    {
        if (_obj_user_resist[i] != NULL && (_obj_user_resist[i]->flag & OBS_RECT_WORK_FLAG_400) != 0)
            _obj_user_resist[i]->flag &= ~OBS_RECT_WORK_FLAG_20000;
    }

    atkGroupOffset = 0;
    for (i = 0; i < OBS_RECT_GROUP_COUNT; i++)
    {
        defGroupOffset = 0;
        for (u8 j = 0; j < OBS_RECT_GROUP_COUNT; j++)
        {
            if (_obj_user_resist_num[j] != 0 && (_obj_user_flag[i] & (0x100 << j)) != 0)
                ObjRect__CheckGroup(&_obj_user_resist[atkGroupOffset], &_obj_user_resist[defGroupOffset], _obj_user_resist_num[i], _obj_user_resist_num[j], j);

            defGroupOffset += _obj_user_resist_num[j];
        }
        atkGroupOffset += _obj_user_resist_num[i];
    }

    count = _obj_user_rect_man.resist_all_num;
    for (i = 0; i < count; i++)
    {
        if (_obj_user_resist[i] != NULL)
        {
            if ((_obj_user_resist[i]->flag & OBS_RECT_WORK_FLAG_10000) != 0)
            {
                _obj_user_resist[i]->flag |= OBS_RECT_WORK_FLAG_200;
                _obj_user_resist[i]->flag &= ~OBS_RECT_WORK_FLAG_10000;
            }

            if ((_obj_user_resist[i]->flag & OBS_RECT_WORK_FLAG_400) != 0 && (_obj_user_resist[i]->flag & OBS_RECT_WORK_FLAG_20000) == 0)
                _obj_user_resist[i]->flag &= ~OBS_RECT_WORK_FLAG_40000;
        }
    }

    if ((g_obj.flag & OBJECTMANAGER_FLAG_20000) == 0)
        ObjRect__CheckOut();
}

OBS_RECT_WORK *ObjRect__RegistGet(u8 group, s16 groupIdx)
{
    s16 index;

    u16 groupOffset = 0;
    for (index = 0; index < OBS_RECT_GROUP_COUNT; index++)
    {
        if ((group & (1 << index)) != 0)
        {
            if (groupIdx < _obj_user_resist_num[index])
                return _obj_user_resist[groupOffset + groupIdx];

            groupIdx -= _obj_user_resist_num[index];
            groupOffset += _obj_user_resist_num[index];
        }
        else
        {
            groupOffset += _obj_user_resist_num[index];
        }
    }

    return NULL;
}

OBS_RECT_WORK *ObjRect__RegistGetNext(u8 group, s16 groupIdx)
{
    s16 index;

    u16 groupOffset = 0;
    for (index = 0; index < OBS_RECT_GROUP_COUNT; index++)
    {
        if ((group & (1 << index)) != 0)
        {
            if (groupIdx < _obj_user_resist_num_nx[index])
                return _obj_user_resist_nx[groupOffset + groupIdx];

            groupIdx -= _obj_user_resist_num_nx[index];
            groupOffset += _obj_user_resist_num_nx[index];
        }
        else
        {
            groupOffset += _obj_user_resist_num_nx[index];
        }
    }

    return NULL;
}

NONMATCH_FUNC void ObjRect__CheckGroup(OBS_RECT_WORK **atkGroup, OBS_RECT_WORK **defGroup, s32 groupNumAtk, s32 groupNumDef, u8 Index)
{
    // https://decomp.me/scratch/K848o -> 98.73%
    // not sure how to get the registers to match...
#ifdef NON_MATCHING
    s32 atkLeft;
    s32 atkTop;
    s32 defLeft;
    s32 defTop;
    s32 atkBack;
    s32 defBack;
    u16 atkWidth;
    u16 atkHeight;
    u16 defWidth;
    u16 defHeight;
    u16 atkDepth;
    u16 defDepth;

    for (u16 atkIdx = 0; atkIdx < groupNumAtk; atkIdx++)
    {
        OBS_RECT_WORK *attacker = atkGroup[atkIdx];
        if (attacker != NULL && (attacker->flag & OBS_RECT_WORK_FLAG_800) == 0
            && ((attacker->flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) != 0 && ((attacker->groupFlags >> 8) & (1 << Index)) != 0)
            && (attacker->parent == NULL || (attacker->parent->flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0))
        {
            ObjRect__LTBSet(attacker, &atkLeft, &atkTop, &atkBack);
            ObjRect__WHDSet(attacker, &atkWidth, &atkHeight, &atkDepth);

            for (u16 defIdx = 0; defIdx < groupNumDef; defIdx++)
            {
                OBS_RECT_WORK *defender = defGroup[defIdx];
                if (atkGroup[atkIdx] != NULL)
                {
                    if (defender != NULL && defender != attacker
                        && (((defender->flag | attacker->flag) & OBS_RECT_WORK_FLAG_800) == 0 && (defender->flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) != 0
                            && (defender->parent == NULL || (defender->parent->flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)))
                    {
                        ObjRect__LTBSet(defender, &defLeft, &defTop, &defBack);
                        ObjRect__WHDSet(defender, &defWidth, &defHeight, &defDepth);

                        if (((defender->flag | attacker->flag) & OBS_RECT_WORK_FLAG_80000) != 0
                            || (OBM_LINE_AND_LINE(atkLeft, atkWidth, defLeft, defWidth) && OBM_LINE_AND_LINE(atkTop, atkHeight, defTop, defHeight)
                                && OBM_LINE_AND_LINE(atkBack, atkDepth, defBack, defDepth)))
                        {
                            u16 result = ObjRect__CheckFuncCall(attacker, defender);

                            if ((result & 1) != 0)
                            {
                                if ((attacker->flag & OBS_RECT_WORK_FLAG_10000) != 0)
                                {
                                    attacker->flag |= OBS_RECT_WORK_FLAG_200;
                                    attacker->flag &= ~OBS_RECT_WORK_FLAG_10000;
                                }

                                atkGroup[atkIdx] = NULL;
                            }

                            if ((result & 2) != 0)
                            {
                                if ((defender->flag & OBS_RECT_WORK_FLAG_10000) != 0)
                                {
                                    defender->flag |= OBS_RECT_WORK_FLAG_200;
                                    defender->flag &= ~OBS_RECT_WORK_FLAG_10000;
                                }

                                defGroup[defIdx] = NULL;
                            }
                        }
                    }
                }
                else
                {
                    break;
                }
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r10, r0
	mov r0, r2
	str r2, [sp]
	cmp r0, #0
	mov r9, r1
	mov r8, r3
	mov r6, #0
	addle sp, sp, #0x2c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r0, [sp, #0x50]
	str r0, [sp, #4]
_02076078:
	ldr r4, [r10, r6, lsl #2]
	cmp r4, #0
	beq _0207628C
	ldr r0, [r4, #0x18]
	tst r0, #0x800
	bne _0207628C
	tst r0, #4
	beq _0207628C
	ldrh r0, [r4, #0x34]
	mov r1, #1
	mov r2, r0, asr #8
	ldr r0, [sp, #4]
	tst r2, r1, lsl r0
	beq _0207628C
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _020760C8
	ldr r0, [r0, #0x18]
	tst r0, #2
	bne _0207628C
_020760C8:
	add r1, sp, #0x28
	add r2, sp, #0x24
	add r3, sp, #0x18
	mov r0, r4
	bl ObjRect__LTBSet
	add r1, sp, #0x12
	add r2, sp, #0x10
	mov r0, r4
	add r3, sp, #0xa
	bl ObjRect__WHDSet
	cmp r8, #0
	mov r7, #0
	ble _0207628C
	mov r11, r7
_02076100:
	ldr r5, [r9, r7, lsl #2]
	ldr r0, [r10, r6, lsl #2]
	cmp r0, #0
	beq _0207628C
	cmp r5, #0
	cmpne r5, r4
	beq _02076278
	ldr r1, [r5, #0x18]
	ldr r0, [r4, #0x18]
	orr r0, r1, r0
	tst r0, #0x800
	bne _02076278
	tst r1, #4
	beq _02076278
	ldr r0, [r5, #0x1c]
	cmp r0, #0
	beq _02076150
	ldr r0, [r0, #0x18]
	tst r0, #2
	bne _02076278
_02076150:
	mov r0, r5
	add r1, sp, #0x20
	add r2, sp, #0x1c
	add r3, sp, #0x14
	bl ObjRect__LTBSet
	mov r0, r5
	add r1, sp, #0xe
	add r2, sp, #0xc
	add r3, sp, #8
	bl ObjRect__WHDSet
	ldr r1, [r5, #0x18]
	ldr r0, [r4, #0x18]
	orr r0, r1, r0
	tst r0, #0x80000
	bne _02076228
	ldr r2, [sp, #0x20]
	ldr r1, [sp, #0x28]
	cmp r1, r2
	bgt _020761AC
	ldrh r0, [sp, #0x12]
	add r0, r1, r0
	cmp r0, r2
	bge _020761C0
_020761AC:
	cmp r1, r2
	ldrgeh r0, [sp, #0xe]
	addge r0, r2, r0
	cmpge r0, r1
	blt _02076278
_020761C0:
	ldr r2, [sp, #0x1c]
	ldr r1, [sp, #0x24]
	cmp r1, r2
	bgt _020761E0
	ldrh r0, [sp, #0x10]
	add r0, r1, r0
	cmp r0, r2
	bge _020761F4
_020761E0:
	cmp r1, r2
	ldrgeh r0, [sp, #0xc]
	addge r0, r2, r0
	cmpge r0, r1
	blt _02076278
_020761F4:
	ldr r2, [sp, #0x14]
	ldr r1, [sp, #0x18]
	cmp r1, r2
	bgt _02076214
	ldrh r0, [sp, #0xa]
	add r0, r1, r0
	cmp r0, r2
	bge _02076228
_02076214:
	cmp r1, r2
	ldrgeh r0, [sp, #8]
	addge r0, r2, r0
	cmpge r0, r1
	blt _02076278
_02076228:
	mov r0, r4
	mov r1, r5
	bl ObjRect__CheckFuncCall
	tst r0, #1
	beq _02076254
	ldr r1, [r4, #0x18]
	tst r1, #0x10000
	orrne r1, r1, #0x200
	bicne r1, r1, #0x10000
	strne r1, [r4, #0x18]
	str r11, [r10, r6, lsl #2]
_02076254:
	tst r0, #2
	beq _02076278
	ldr r0, [r5, #0x18]
	tst r0, #0x10000
	orrne r0, r0, #0x200
	bicne r0, r0, #0x10000
	strne r0, [r5, #0x18]
	mov r0, #0
	str r0, [r9, r7, lsl #2]
_02076278:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r8, r0, lsr #16
	mov r7, r0, lsr #0x10
	bgt _02076100
_0207628C:
	add r0, r6, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r6, r1, lsr #0x10
	cmp r0, r1, lsr #16
	bgt _02076078
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

void ObjRect__LTBSet(OBS_RECT_WORK *work, fx32 *left, fx32 *top, fx32 *back)
{
    fx32 offset;

    if (work->parent != NULL && (work->flag & OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET) == 0)
    {
        if (left != NULL)
        {
            offset = (((work->parent->displayFlag & DISPLAY_FLAG_FLIP_X) ^ (work->flag & OBS_RECT_WORK_FLAG_FLIP_X)) != 0 ? -work->rect.right : work->rect.left);

            if (work->parent->scale.x != FX_ONE)
                offset = MultiplyFX(offset, work->parent->scale.x);

            *left = FX32_TO_WHOLE(work->parent->position.x) + work->rect.pos.x + offset;
        }

        if (top != NULL)
        {
            offset = (((work->parent->displayFlag & DISPLAY_FLAG_FLIP_Y) ^ (work->flag & OBS_RECT_WORK_FLAG_FLIP_Y)) != 0 ? -work->rect.bottom : work->rect.top);

            if (work->parent->scale.y != FX_ONE)
                offset = MultiplyFX(offset, work->parent->scale.y);

            *top = FX32_TO_WHOLE(work->parent->position.y) + work->rect.pos.y + offset;
        }

        if (back != NULL)
        {
            offset = work->rect.back;

            if (work->parent->scale.z != FX_ONE)
                offset = MultiplyFX(offset, work->parent->scale.z);

            *back = FX32_TO_WHOLE(work->parent->position.z) + work->rect.pos.z + offset;
        }
    }
    else
    {
        if (left != NULL)
        {
            offset = ((work->flag & OBS_RECT_WORK_FLAG_FLIP_X) != 0 ? -work->rect.right : work->rect.left);
            *left  = work->rect.pos.x + offset;
        }

        if (top != NULL)
        {
            offset = ((work->flag & OBS_RECT_WORK_FLAG_FLIP_Y) != 0 ? -work->rect.bottom : work->rect.top);
            *top   = work->rect.pos.y + offset;
        }

        if (back != NULL)
        {
            offset = work->rect.back;
            *back  = work->rect.pos.z + offset;
        }
    }
}

void ObjRect__WHDSet(OBS_RECT_WORK *work, u16 *width, u16 *height, u16 *depth)
{
    if (work->parent != NULL && (work->flag & OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET) == 0)
    {
        if (width != NULL)
        {
            *width = work->rect.right - work->rect.left;
            if (work->parent->scale.x != FX_ONE)
                *width = MultiplyFX(*width, work->parent->scale.x);
        }

        if (height != NULL)
        {
            *height = work->rect.bottom - work->rect.top;
            if (work->parent->scale.y != FX_ONE)
                *height = MultiplyFX(*height, work->parent->scale.y);
        }

        if (depth)
        {
            *depth = work->rect.front - work->rect.back;
            if (work->parent->scale.z != FX_ONE)
                *depth = MultiplyFX(*depth, work->parent->scale.z);
        }
    }
    else
    {
        if (width != NULL)
            *width = work->rect.right - work->rect.left;

        if (height != NULL)
            *height = work->rect.bottom - work->rect.top;

        if (depth != NULL)
            *depth = work->rect.front - work->rect.back;
    }
}

BOOL ObjRect__FlagCheck(u16 ulAtkFlag, u16 usDefFlag, s16 lAtkPower, s16 lDefPower)
{
    return (ulAtkFlag & ~usDefFlag) != 0 && lAtkPower >= lDefPower;
}

u16 ObjRect__CheckFuncCall(OBS_RECT_WORK *attacker, OBS_RECT_WORK *defender)
{
    u16 result = 0;

    _obj_user_rect_man.ulFlagBackA = attacker->flag;
    _obj_user_rect_man.ulFlagBackD = defender->flag;

    if ((attacker->flag & OBS_RECT_WORK_FLAG_200) != 0 && (defender->flag & OBS_RECT_WORK_FLAG_100) != 0)
        return result;

    if (ObjRect__FlagCheck(attacker->hitFlag, defender->defFlag, attacker->hitPower, defender->defPower))
    {
        if (attacker->checkActive != NULL && !attacker->checkActive(attacker, defender))
            return result;

        if (defender->checkActive != NULL && !defender->checkActive(defender, attacker))
            return result;

        if ((defender->flag & (OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_40)) == 0 && (attacker->flag & (OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_40)) == 0)
            attacker->flag |= OBS_RECT_WORK_FLAG_10000;

        if ((defender->flag & (OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_80)) == 0 && (attacker->flag & (OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_80)) == 0)
            defender->flag |= OBS_RECT_WORK_FLAG_100;

        if ((attacker->flag & OBS_RECT_WORK_FLAG_400) == 0 || (attacker->flag & OBS_RECT_WORK_FLAG_40000) == 0)
        {
            if ((attacker->flag & OBS_RECT_WORK_FLAG_400) != 0)
                attacker->flag |= OBS_RECT_WORK_FLAG_40000;

            if (attacker->onAttack != NULL)
                attacker->onAttack(attacker, defender);
        }

        if (_obj_user_rect_man.ucNoHit != FALSE)
        {
            _obj_user_rect_man.ucNoHit = FALSE;
            return result;
        }

        if ((attacker->flag & OBS_RECT_WORK_FLAG_400) != 0)
            attacker->flag |= OBS_RECT_WORK_FLAG_20000;

        if ((defender->flag & OBS_RECT_WORK_FLAG_400) == 0 || (defender->flag & OBS_RECT_WORK_FLAG_40000) == 0)
        {
            if ((defender->flag & OBS_RECT_WORK_FLAG_400) != 0)
                defender->flag |= OBS_RECT_WORK_FLAG_40000;

            if (defender->onDefend != NULL)
                defender->onDefend(attacker, defender);
        }

        if (_obj_user_rect_man.ucNoHit != FALSE)
        {
            _obj_user_rect_man.ucNoHit = FALSE;
            return result;
        }

        if ((defender->flag & OBS_RECT_WORK_FLAG_400) != 0)
            defender->flag |= OBS_RECT_WORK_FLAG_20000;

        if ((attacker->flag & OBS_RECT_WORK_FLAG_20) == 0)
            result |= 1;

        if ((defender->flag & OBS_RECT_WORK_FLAG_20) == 0)
            result |= 2;
    }

    return result;
}

void ObjRect__FuncNoHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    rect1->flag                = _obj_user_rect_man.ulFlagBackA;
    rect2->flag                = _obj_user_rect_man.ulFlagBackD;
    _obj_user_rect_man.ucNoHit = TRUE;
}

NONMATCH_FUNC BOOL ObjRect__RectCheck(OBS_RECT *rect1, OBS_RECT *rect2){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldrsh r8, [r0, #0]
	ldrsh r3, [r0, #6]
	ldr r9, [r0, #0xc]
	ldrsh r7, [r0, #2]
	ldrsh r2, [r0, #8]
	ldr r6, [r0, #0x10]
	sub r3, r3, r8
	sub r2, r2, r7
	ldrsh r5, [r0, #4]
	ldrsh r10, [r0, #0xa]
	ldrsh ip, [r1, #4]
	ldr r4, [r0, #0x14]
	ldr r0, [r1, #0x14]
	sub r11, r10, r5
	sub r10, r10, ip
	ldrsh lr, [r1]
	add r7, r6, r7
	ldrsh r6, [r1, #6]
	add r5, r4, r5
	ldr r4, [r1, #0xc]
	add r0, r0, ip
	sub r6, r6, lr
	ldrsh ip, [r1, #2]
	add r4, r4, lr
	ldrsh lr, [r1, #8]
	add r8, r9, r8
	ldr r9, [r1, #0x10]
	sub r1, lr, ip
	cmp r8, r4
	add r9, r9, ip
	mov r3, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r6, r6, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r11, r11, lsl #0x10
	mov r10, r10, lsl #0x10
	bgt _02076854
	add r3, r8, r3, lsr #16
	cmp r3, r4
	bge _02076864
_02076854:
	cmp r8, r4
	addge r3, r4, r6, lsr #16
	cmpge r3, r8
	blt _020768B4
_02076864:
	cmp r7, r9
	bgt _02076878
	add r2, r7, r2, lsr #16
	cmp r2, r9
	bge _02076888
_02076878:
	cmp r7, r9
	addge r1, r9, r1, lsr #16
	cmpge r1, r7
	blt _020768B4
_02076888:
	cmp r5, r0
	bgt _0207689C
	add r1, r5, r11, lsr #16
	cmp r1, r0
	bge _020768AC
_0207689C:
	cmp r5, r0
	addge r0, r0, r10, lsr #16
	cmpge r0, r5
	blt _020768B4
_020768AC:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020768B4:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

BOOL ObjRect__PointCheck(OBS_RECT_WORK *work, s32 x, s32 y, s32 z)
{
    if ((work->flag & OBS_RECT_WORK_FLAG_IS_ACTIVE) != 0 && (work->flag & OBS_RECT_WORK_FLAG_800) == 0)
    {
        s32 left;
        s32 top;
        s32 back;
        ObjRect__LTBSet(work, &left, &top, &back);

        u16 width;
        u16 height;
        u16 depth;
        ObjRect__WHDSet(work, &width, &height, &depth);

        if (OBM_POINT_IN_LINE(left, width, x) && OBM_POINT_IN_LINE(top, height, y) && OBM_POINT_IN_LINE(back, depth, z))
            return TRUE;
    }

    return FALSE;
}

NONMATCH_FUNC BOOL ObjRect__RectPointCheck(OBS_RECT_WORK *work, s32 x, s32 y, s32 z)
{
#ifdef NON_MATCHING
    return OBM_POINT_IN_LINE(work->rect.left + (work->rect.pos.x >> FX32_SHIFT), (u16)(work->rect.right - work->rect.left), x)
           && OBM_POINT_IN_LINE(work->rect.top + (work->rect.pos.y >> FX32_SHIFT), (u16)(work->rect.bottom - work->rect.top), y)
           && OBM_POINT_IN_LINE(work->rect.back + (work->rect.pos.z >> FX32_SHIFT), (u16)(work->rect.front - work->rect.back), z);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldrsh r8, [r0, #0]
	ldrsh r6, [r0, #6]
	ldr r4, [r0, #0xc]
	ldrsh lr, [r0, #2]
	ldrsh r5, [r0, #8]
	ldr ip, [r0, #0x10]
	sub r7, r6, r8
	sub r6, r5, lr
	add r5, r8, r4
	ldrsh r9, [r0, #4]
	ldrsh r4, [r0, #0xa]
	ldr r8, [r0, #0x14]
	cmp r5, r1
	sub r4, r4, r9
	add r0, lr, ip
	add r8, r9, r8
	mov ip, r7, lsl #0x10
	mov lr, r6, lsl #0x10
	mov r4, r4, lsl #0x10
	bgt _02076A00
	add ip, r5, ip, lsr #16
	cmp ip, r1
	blt _02076A00
	cmp r0, r2
	bgt _02076A00
	add r0, r0, lr, lsr #16
	cmp r0, r2
	blt _02076A00
	cmp r8, r3
	bgt _02076A00
	add r0, r8, r4, lsr #16
	cmp r0, r3
	movge r0, #1
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02076A00:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

s32 ObjRect__CenterX(OBS_RECT_WORK *work)
{
    s32 center = (work->rect.pos.x + ((s32)(work->rect.left + work->rect.right) >> 1)) << FX32_SHIFT;
    if (work->parent != NULL)
        center += work->parent->position.x;

    return center;
}

s32 ObjRect__CenterY(OBS_RECT_WORK *work)
{
    s32 center = (work->rect.pos.y + ((s32)(work->rect.top + work->rect.bottom) >> 1)) << FX32_SHIFT;
    if (work->parent != NULL)
        center += work->parent->position.y;

    return center;
}

NONMATCH_FUNC fx32 ObjRect__HitCenterX(OBS_RECT_WORK *work, OBS_RECT_WORK *attacker)
{
    // https://decomp.me/scratch/XkbpR -> 97.94%
    // misc register mismatches
#ifdef NON_MATCHING
    s32 bounds[4];
    u8 id;
    u8 index;
    u8 id1;
    s32 value1;

    id = 0;
    value1;
    index = 0;
    id1   = 0;

    u16 width;
    ObjRect__LTBSet(work, &bounds[0], NULL, NULL);
    ObjRect__WHDSet(work, &width, NULL, NULL);
    bounds[1] = bounds[0] + width;

    ObjRect__LTBSet(attacker, &bounds[2], NULL, NULL);
    ObjRect__WHDSet(attacker, &width, NULL, NULL);
    bounds[3] = bounds[2] + width;

    // possibly a bug? shouldn't this use 'bounds[0]' instead of '0'
    value1 = 0; // bounds[0];
    index++;

    if (bounds[index] > value1)
    {
        value1 = bounds[index];
        id1    = index;
    }

    index++;
    if (bounds[index] > value1)
    {
        value1 = bounds[index];
        id1    = index;
    }

    index++;
    if (bounds[index] > value1)
    {
        value1 = bounds[index];
        id1    = index;
    }

    u8 index2  = 0;
    s32 value2 = bounds[index2];
    u8 id2     = 0;

    index2++;
    if (bounds[index2] < value2)
    {
        value2 = bounds[index2];
        id2    = index2;
    }

    index2++;
    if (bounds[index2] < value2)
    {
        id2    = index2;
        value2 = bounds[index2];
    }

    index2++;
    if (bounds[index2] < value2)
    {
        id2 = index2;

        // possibly a bug? shouldn't this be "value2" instead of "u8 value2"?
        u8 value2 = bounds[index2];
    }

    u8 i = 0;
    while (TRUE)
    {
        if (id != id1 && id != id2)
        {
            bounds[i] = bounds[id];
            if (i == 0)
                i++;
            else
                break;
        }

        id++;
    }

    s32 size = MATH_ABS(bounds[0] - bounds[1] >> 1);
    return FX32_FROM_WHOLE(bounds[0] > bounds[1] ? size + bounds[1] : size + bounds[0]);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x14
	mov r4, #0
	mov r7, r1
	add r1, sp, #4
	mov r2, r4
	mov r3, r4
	mov r8, r0
	mov r5, r4
	mov r6, r4
	bl ObjRect__LTBSet
	mov r2, r4
	add r1, sp, #0
	mov r0, r8
	mov r3, r2
	bl ObjRect__WHDSet
	ldrh r3, [sp]
	ldr ip, [sp, #4]
	mov r2, r4
	add r3, ip, r3
	str r3, [sp, #8]
	mov r0, r7
	add r1, sp, #0xc
	mov r3, r2
	bl ObjRect__LTBSet
	mov r2, r4
	mov r0, r7
	add r1, sp, #0
	mov r3, r2
	bl ObjRect__WHDSet
	add r1, r5, #1
	and r5, r1, #0xff
	ldrh r2, [sp]
	ldr r3, [sp, #0xc]
	add r1, sp, #4
	add r2, r3, r2
	str r2, [sp, #0x10]
	ldr r1, [r1, r5, lsl #2]
	mov r0, r4
	cmp r1, #0
	movgt r4, r1
	add r2, r5, #1
	movgt r0, r5
	and r5, r2, #0xff
	add r1, sp, #4
	ldr r1, [r1, r5, lsl #2]
	add r2, r5, #1
	cmp r1, r4
	movgt r4, r1
	add r1, sp, #4
	and r2, r2, #0xff
	ldr r1, [r1, r2, lsl #2]
	movgt r0, r5
	cmp r1, r4
	movgt r0, r2
	mov r1, #0
	add r3, r1, #1
	ldr r4, [sp, #4]
	ldr r2, [sp, #8]
	and r3, r3, #0xff
	cmp r2, r4
	addlt r2, sp, #4
	ldrlt r4, [r2, r3, lsl #2]
	movlt r1, r3
	add r3, r3, #1
	add r2, sp, #4
	and r3, r3, #0xff
	ldr r2, [r2, r3, lsl #2]
	cmp r2, r4
	movlt r1, r3
	add r3, r3, #1
	movlt r4, r2
	add r2, sp, #4
	and r3, r3, #0xff
	ldr r2, [r2, r3, lsl #2]
	cmp r2, r4
	movlt r1, r3
	mov r4, #0
	add r3, sp, #4
_02076B9C:
	cmp r4, r0
	cmpne r4, r1
	beq _02076BC0
	ldr r2, [r3, r4, lsl #2]
	cmp r6, #0
	str r2, [r3, r6, lsl #2]
	bne _02076BCC
	add r2, r6, #1
	and r6, r2, #0xff
_02076BC0:
	add r2, r4, #1
	and r4, r2, #0xff
	b _02076B9C
_02076BCC:
	ldr r1, [sp, #8]
	ldr r2, [sp, #4]
	sub r0, r2, r1
	movs r0, r0, asr #1
	rsbmi r0, r0, #0
	cmp r2, r1
	addgt r0, r0, r1
	addle r0, r0, r2
	mov r0, r0, lsl #0xc
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC fx32 ObjRect__HitCenterY(OBS_RECT_WORK *work, OBS_RECT_WORK *attacker)
{
	// should match when the issues with 'ObjRect__HitCenterX' are resolved
#ifdef NON_MATCHING
    s32 bounds[4];
    u8 id;
    u8 index;
    u8 id1;
    s32 value1;

    id = 0;
    value1;
    index = 0;
    id1   = 0;

    u16 height;
    ObjRect__LTBSet(work, NULL, &bounds[0], NULL);
    ObjRect__WHDSet(work, NULL, &height, NULL);
    bounds[1] = bounds[0] + height;

    ObjRect__LTBSet(attacker, NULL, &bounds[0], NULL);
    ObjRect__WHDSet(attacker, NULL, &height, NULL);
    bounds[3] = bounds[2] + height;

    s32 value2 = bounds[index2];
    value1 = bounds[0];
    index++;

    if (bounds[index] > value1)
    {
        value1 = bounds[index];
        id1    = index;
    }

    index++;
    if (bounds[index] > value1)
    {
        value1 = bounds[index];
        id1    = index;
    }

    index++;
    if (bounds[index] > value1)
    {
        value1 = bounds[index];
        id1    = index;
    }

    u8 index2  = 0;
    u8 id2     = 0;

    index2++;
    if (bounds[index2] < value2)
    {
        value2 = bounds[index2];
        id2    = index2;
    }

    index2++;
    if (bounds[index2] < value2)
    {
        id2    = index2;
        value2 = bounds[index2];
    }

    index2++;
    if (bounds[index2] < value2)
    {
        id2 = index2;

        // possibly a bug? shouldn't this be "value2" instead of "u8 value2"?
        u8 value2 = bounds[index2];
    }

    u8 i = 0;
    while (TRUE)
    {
        if (id != id1 && id != id2)
        {
            bounds[i] = bounds[id];
            if (i == 0)
                i++;
            else
                break;
        }

        id++;
    }

    s32 size = MATH_ABS(bounds[0] - bounds[1] >> 1);
    return FX32_FROM_WHOLE(bounds[0] > bounds[1] ? size + bounds[1] : size + bounds[0]);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r4, #0
	mov r6, r1
	add r2, sp, #4
	mov r1, r4
	mov r3, r4
	mov r7, r0
	mov r5, r4
	bl ObjRect__LTBSet
	mov r1, r4
	add r2, sp, #0
	mov r0, r7
	mov r3, r1
	bl ObjRect__WHDSet
	ldrh r2, [sp]
	ldr r3, [sp, #4]
	mov r1, r4
	add r2, r3, r2
	str r2, [sp, #8]
	mov r0, r6
	add r2, sp, #0xc
	mov r3, r1
	bl ObjRect__LTBSet
	mov r1, r4
	mov r0, r6
	add r2, sp, #0
	mov r3, r1
	bl ObjRect__WHDSet
	ldrh r0, [sp]
	ldr r3, [sp, #0xc]
	mov r1, r4
	add r0, r3, r0
	add r3, r4, #1
	and r4, r3, #0xff
	str r0, [sp, #0x10]
	add r3, sp, #4
	ldr r2, [sp, #4]
	ldr r3, [r3, r4, lsl #2]
	mov r0, r2
	cmp r3, r2
	movgt r1, r4
	add r4, r4, #1
	movgt r0, r3
	add r3, sp, #4
	and r4, r4, #0xff
	ldr r3, [r3, r4, lsl #2]
	cmp r3, r0
	movgt r1, r4
	add r4, r4, #1
	movgt r0, r3
	add r3, sp, #4
	and r4, r4, #0xff
	ldr r3, [r3, r4, lsl #2]
	cmp r3, r0
	ldr r3, [sp, #8]
	movgt r1, r4
	cmp r3, r2
	mov r0, #0
	add r4, r0, #1
	and r4, r4, #0xff
	addlt r2, sp, #4
	movlt r0, r4
	ldrlt r2, [r2, r4, lsl #2]
	add r4, r4, #1
	add r3, sp, #4
	and r4, r4, #0xff
	ldr r3, [r3, r4, lsl #2]
	cmp r3, r2
	movlt r0, r4
	add r4, r4, #1
	movlt r2, r3
	add r3, sp, #4
	and r4, r4, #0xff
	ldr r3, [r3, r4, lsl #2]
	cmp r3, r2
	movlt r0, r4
	mov r4, #0
	add r3, sp, #4
_02076D34:
	cmp r4, r1
	cmpne r4, r0
	beq _02076D58
	ldr r2, [r3, r4, lsl #2]
	cmp r5, #0
	str r2, [r3, r5, lsl #2]
	bne _02076D64
	add r2, r5, #1
	and r5, r2, #0xff
_02076D58:
	add r2, r4, #1
	and r4, r2, #0xff
	b _02076D34
_02076D64:
	ldr r1, [sp, #8]
	ldr r2, [sp, #4]
	sub r0, r2, r1
	movs r0, r0, asr #1
	rsbmi r0, r0, #0
	cmp r2, r1
	addgt r0, r0, r1
	addle r0, r0, r2
	mov r0, r0, lsl #0xc
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
// clang-format on
#endif
}
