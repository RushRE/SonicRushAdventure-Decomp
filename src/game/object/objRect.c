#include <game/object/objRect.h>
#include <game/math/mtMath.h>
#include <stage/stageTask.h>
#include <game/object/objectManager.h>

// --------------------
// CONSTANTS
// --------------------

#define OBM_DEFAULT_DEPTH 16

// --------------------
// VARIABLES
// --------------------

static u16 curGroupFlagList[OBS_RECT_GROUP_COUNT];
static u16 nextGroupFlagList[OBS_RECT_GROUP_COUNT];

static OBS_RECT_WORK *nextGroupRectList[OBS_RECT_REGISTER_MAX];
static OBS_RECT_WORK *curGroupRectList[OBS_RECT_REGISTER_MAX];

static u8 curGroupListCount[OBS_RECT_GROUP_COUNT];
static u8 nextGroupListCount[OBS_RECT_GROUP_COUNT];

static u8 calledNoHit;
static u16 nextTotalRegCount;
static u16 curTotalRegCount;
static u32 prevAttackerFlag;
static u32 prevDefenderFlag;

// --------------------
// INLINE FUNCTIONS
// --------------------

#define OBM_LINE_AND_LINE(x0, w0, x1, w1) (((s32)(x0) <= (s32)(x1) && (s32)(x0) + (s32)(w0) >= (s32)(x1)) || ((s32)(x0) >= (s32)(x1) && (s32)(x1) + (s32)(w1) >= (s32)(x0)))
#define OBM_POINT_IN_LINE(x0, w0, x1)     ((s32)(x0) <= (s32)(x1) && (s32)(x0) + (s32)(w0) >= (s32)(x1))

// --------------------
// FUNCTIONS
// --------------------

void ObjRect__SetBox2D(OBS_RECT *rect, s16 left, s16 top, s16 right, s16 bottom)
{
    rect->left   = left;
    rect->top    = top;
    rect->right  = right;
    rect->bottom = bottom;
    rect->back   = -OBM_DEFAULT_DEPTH;
    rect->front  = OBM_DEFAULT_DEPTH;

    if (rect->right < rect->left)
    {
        MTM_MATH_SWAP(rect->left, rect->right);
    }

    if (rect->bottom < rect->top)
    {
        MTM_MATH_SWAP(rect->top, rect->bottom);
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
        MTM_MATH_SWAP(rect->left, rect->right);
    }

    if (rect->bottom < rect->top)
    {
        MTM_MATH_SWAP(rect->top, rect->bottom);
    }

    if (rect->front < rect->back)
    {
        MTM_MATH_SWAP(rect->back, rect->front);
    }

    VEC_Set(&rect->pos, 0, 0, 0);
}

void ObjRect__SetBox(OBS_RECT_WORK *work, s16 left, s16 top, s16 right, s16 bottom)
{
    work->flag |= OBS_RECT_WORK_FLAG_ENABLED;
    ObjRect__SetBox2D(&work->rect, left, top, right, bottom);
}

void ObjRect__SetAttackStat(OBS_RECT_WORK *work, OBS_RECT_WORKAttribute attribute, u16 power)
{
    work->flag |= OBS_RECT_WORK_FLAG_ENABLED;
    work->hitFlag  = attribute;
    work->hitPower = power;
    work->flag &= ~OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME;
    work->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME;
}

void ObjRect__SetDefenceStat(OBS_RECT_WORK *work, OBS_RECT_WORKAttribute attribute, u16 power)
{
    work->flag |= OBS_RECT_WORK_FLAG_ENABLED;
    work->defFlag  = attribute;
    work->defPower = power;
    work->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;
}

void ObjRect__HitAgain(OBS_RECT_WORK *work)
{
    if ((work->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) == 0)
    {
        work->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;
        work->flag &= ~OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME;
    }
}

void ObjRect__CheckInit(void)
{
    MI_CpuClear8(curGroupRectList, sizeof(curGroupRectList));
    MI_CpuClear8(nextGroupRectList, sizeof(nextGroupRectList));

    MI_CpuClear8(curGroupListCount, sizeof(curGroupListCount));
    MI_CpuClear8(nextGroupListCount, sizeof(nextGroupListCount));

    MI_CpuClear8(curGroupFlagList, sizeof(curGroupFlagList));
    MI_CpuClear8(nextGroupFlagList, sizeof(nextGroupFlagList));

    curTotalRegCount  = 0;
    nextTotalRegCount = 0;
    prevAttackerFlag  = 0;
    prevDefenderFlag  = 0;
    calledNoHit       = FALSE;
}

void ObjRect__CheckOut(void)
{
    MI_CpuCopy8(nextGroupRectList, curGroupRectList, sizeof(curGroupRectList));
    MI_CpuClear8(nextGroupRectList, sizeof(nextGroupRectList));

    MI_CpuCopy8(nextGroupListCount, curGroupListCount, sizeof(curGroupListCount));
    MI_CpuClear8(nextGroupListCount, sizeof(nextGroupListCount));

    MI_CpuCopy8(nextGroupFlagList, curGroupFlagList, sizeof(curGroupFlagList));
    MI_CpuClear8(nextGroupFlagList, sizeof(nextGroupFlagList));

    curTotalRegCount  = nextTotalRegCount;
    nextTotalRegCount = 0;

    for (u16 g = 0; g < (curTotalRegCount - 1); g++)
    {
        for (u16 i = (u16)(curTotalRegCount - 1); i > g; i--)
        {
            if ((s32)(curGroupRectList[i]->groupFlags & 0xFF) < (s32)(curGroupRectList[i - 1]->groupFlags & 0xFF))
            {
                OBS_RECT_WORK *work     = curGroupRectList[i - 1];
                curGroupRectList[i - 1] = curGroupRectList[i];
                curGroupRectList[i]     = work;
            }
        }
    }
}

void ObjRect__Register(OBS_RECT_WORK *work)
{
    if ((work->flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
        return;

    for (u16 g = 0; g < OBS_RECT_GROUP_COUNT; g++)
    {
        if ((work->groupFlags & (1 << g)) == 0)
            continue;

        if (nextTotalRegCount >= OBS_RECT_REGISTER_MAX)
            return;

        nextGroupRectList[nextTotalRegCount] = work;
        nextGroupFlagList[g] |= work->groupFlags;
        nextGroupListCount[g]++;
        nextTotalRegCount++;
        break;
    }
}

void ObjRect__CheckAllGroup(void)
{
    u16 i;
    u16 atkGroupOffset;
    u16 defGroupOffset;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_EARLY_SORT_OBJRECT) != 0)
        ObjRect__CheckOut();

    prevAttackerFlag = 0;
    prevDefenderFlag = 0;
    calledNoHit      = FALSE;

    u16 count = curTotalRegCount;
    for (i = 0; i < count; i++)
    {
        if (curGroupRectList[i] != NULL && (curGroupRectList[i]->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) != 0)
            curGroupRectList[i]->flag &= ~OBS_RECT_WORK_FLAG_SYS_HAD_ATK_THIS_FRAME;
    }

    atkGroupOffset = 0;
    for (i = 0; i < OBS_RECT_GROUP_COUNT; i++)
    {
        defGroupOffset = 0;
        for (u8 j = 0; j < OBS_RECT_GROUP_COUNT; j++)
        {
            if (curGroupListCount[j] != 0 && (curGroupFlagList[i] & (0x100 << j)) != 0)
                ObjRect__CheckGroup(&curGroupRectList[atkGroupOffset], &curGroupRectList[defGroupOffset], curGroupListCount[i], curGroupListCount[j], j);

            defGroupOffset += curGroupListCount[j];
        }
        atkGroupOffset += curGroupListCount[i];
    }

    count = curTotalRegCount;
    for (i = 0; i < count; i++)
    {
        if (curGroupRectList[i] != NULL)
        {
            if ((curGroupRectList[i]->flag & OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME) != 0)
            {
                curGroupRectList[i]->flag |= OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME;
                curGroupRectList[i]->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME;
            }

            if ((curGroupRectList[i]->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) != 0 && (curGroupRectList[i]->flag & OBS_RECT_WORK_FLAG_SYS_HAD_ATK_THIS_FRAME) == 0)
                curGroupRectList[i]->flag &= ~OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER;
        }
    }

    if ((g_obj.flag & OBJECTMANAGER_FLAG_EARLY_SORT_OBJRECT) == 0)
        ObjRect__CheckOut();
}

OBS_RECT_WORK *ObjRect__RegistGet(u8 groupMask, s16 groupIdx)
{
    s16 index;

    u16 groupOffset = 0;
    for (index = 0; index < OBS_RECT_GROUP_COUNT; index++)
    {
        if ((groupMask & (1 << index)) != 0)
        {
            if (groupIdx < curGroupListCount[index])
                return curGroupRectList[groupOffset + groupIdx];

            groupIdx -= curGroupListCount[index];
            groupOffset += curGroupListCount[index];
        }
        else
        {
            groupOffset += curGroupListCount[index];
        }
    }

    return NULL;
}

OBS_RECT_WORK *ObjRect__RegistGetNext(u8 groupMask, s16 groupIdx)
{
    s16 index;

    u16 groupOffset = 0;
    for (index = 0; index < OBS_RECT_GROUP_COUNT; index++)
    {
        if ((groupMask & (1 << index)) != 0)
        {
            if (groupIdx < nextGroupListCount[index])
                return nextGroupRectList[groupOffset + groupIdx];

            groupIdx -= nextGroupListCount[index];
            groupOffset += nextGroupListCount[index];
        }
        else
        {
            groupOffset += nextGroupListCount[index];
        }
    }

    return NULL;
}

void ObjRect__CheckGroup(OBS_RECT_WORK **atkGroup, OBS_RECT_WORK **defGroup, s32 groupNumAtk, s32 groupNumDef, u8 index)
{
    int atkLeft;
    int atkTop;
    s32 defLeft;
    s32 defTop;
    int atkBack;
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
        if (attacker != NULL && (attacker->flag & OBS_RECT_WORK_FLAG_NO_HIT_CHECKS) == 0
            && ((attacker->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0 && ((attacker->groupFlags >> 8) & (1 << index)) != 0)
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
                        && (((defender->flag | attacker->flag) & OBS_RECT_WORK_FLAG_NO_HIT_CHECKS) == 0 && (defender->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0
                            && (defender->parent == NULL || (defender->parent->flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)))
                    {
                        ObjRect__LTBSet(defender, &defLeft, &defTop, &defBack);
                        ObjRect__WHDSet(defender, &defWidth, &defHeight, &defDepth);

                        if (((defender->flag | attacker->flag) & OBS_RECT_WORK_FLAG_CHECK_FUNC) != 0
                            || (OBM_LINE_AND_LINE(atkLeft, atkWidth, defLeft, defWidth) && OBM_LINE_AND_LINE(atkTop, atkHeight, defTop, defHeight)
                                && OBM_LINE_AND_LINE(atkBack, atkDepth, defBack, defDepth)))
                        {
                            u16 result = ObjRect__CheckFuncCall(attacker, defender);

                            if ((result & 1) != 0)
                            {
                                if ((attacker->flag & OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME) != 0)
                                {
                                    attacker->flag |= OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME;
                                    attacker->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME;
                                }

                                atkGroup[atkIdx] = NULL;
                            }

                            if ((result & 2) != 0)
                            {
                                if ((defender->flag & OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME) != 0)
                                {
                                    defender->flag |= OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME;
                                    defender->flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME;
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

    prevAttackerFlag = attacker->flag;
    prevDefenderFlag = defender->flag;

    if ((attacker->flag & OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME) != 0 && (defender->flag & OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME) != 0)
        return result;

    if (ObjRect__FlagCheck(attacker->hitFlag, defender->defFlag, attacker->hitPower, defender->defPower))
    {
        if (attacker->checkActive != NULL && !attacker->checkActive(attacker, defender))
            return result;

        if (defender->checkActive != NULL && !defender->checkActive(defender, attacker))
            return result;

        if ((defender->flag & (OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE)) == 0
            && (attacker->flag & (OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE)) == 0)
            attacker->flag |= OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME;

        if ((defender->flag & (OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE)) == 0
            && (attacker->flag & (OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE)) == 0)
            defender->flag |= OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;

        if ((attacker->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) == 0 || (attacker->flag & OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER) == 0)
        {
            if ((attacker->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) != 0)
                attacker->flag |= OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER;

            if (attacker->onAttack != NULL)
                attacker->onAttack(attacker, defender);
        }

        if (calledNoHit != FALSE)
        {
            calledNoHit = FALSE;
            return result;
        }

        if ((attacker->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) != 0)
            attacker->flag |= OBS_RECT_WORK_FLAG_SYS_HAD_ATK_THIS_FRAME;

        if ((defender->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) == 0 || (defender->flag & OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER) == 0)
        {
            if ((defender->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) != 0)
                defender->flag |= OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER;

            if (defender->onDefend != NULL)
                defender->onDefend(attacker, defender);
        }

        if (calledNoHit != FALSE)
        {
            calledNoHit = FALSE;
            return result;
        }

        if ((defender->flag & OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR) != 0)
            defender->flag |= OBS_RECT_WORK_FLAG_SYS_HAD_ATK_THIS_FRAME;

        if ((attacker->flag & OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME) == 0)
            result |= 1;

        if ((defender->flag & OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME) == 0)
            result |= 2;
    }

    return result;
}

void ObjRect__FuncNoHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    rect1->flag = prevAttackerFlag;
    rect2->flag = prevDefenderFlag;
    calledNoHit = TRUE;
}

BOOL ObjRect__RectCheck(OBS_RECT *rect1, OBS_RECT *rect2)
{
    s32 rect1Left, rect1Top;
    s32 rect2Left, rect2Top;
    s32 rect1Back, rect2Back;

    u16 rect1Width, rect1Height;
    u16 rect2Width, rect2Height;
    u16 rect1Depth, rect2Depth;

    rect1Left = rect1->pos.x + rect1->left;
    rect1Top  = rect1->pos.y + rect1->top;
    rect1Back = rect1->pos.z + rect1->back;

    rect2Left = rect2->pos.x + rect2->left;
    rect2Top  = rect2->pos.y + rect2->top;
    rect2Back = rect2->pos.z + rect2->back;

    rect1Width  = rect1->right - rect1->left;
    rect1Height = rect1->bottom - rect1->top;

    rect2Width  = rect2->right - rect2->left;
    rect2Height = rect2->bottom - rect2->top;

    rect1Depth = rect1->front - rect1->back;
    rect2Depth = rect1->front - rect2->back;

    if ((OBM_LINE_AND_LINE(rect1Left, rect1Width, rect2Left, rect2Width)) && (OBM_LINE_AND_LINE(rect1Top, rect1Height, rect2Top, rect2Height))
        && (OBM_LINE_AND_LINE(rect1Back, rect1Depth, rect2Back, rect2Depth)))
    {
        return TRUE;
    }

    return FALSE;
}

BOOL ObjRect__PointCheck(OBS_RECT_WORK *work, s32 x, s32 y, s32 z)
{
    if ((work->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0 && (work->flag & OBS_RECT_WORK_FLAG_NO_HIT_CHECKS) == 0)
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

BOOL ObjRect__RectPointCheck(OBS_RECT_WORK *work, s32 x, s32 y, s32 z)
{
    s32 rectLeft, rectTop;
    s32 pointX, pointY;
    s32 rectBack, pointZ;
    u16 rectWidth, rectHeight;
    u16 rectDepth;

    rectLeft = work->rect.left + work->rect.pos.x;
    rectTop  = work->rect.top + work->rect.pos.y;
    rectBack = work->rect.back + work->rect.pos.z;

    pointX = x;
    pointY = y;
    pointZ = z;

    rectWidth  = work->rect.right - work->rect.left;
    rectHeight = work->rect.bottom - work->rect.top;
    rectDepth  = work->rect.front - work->rect.back;

    if (OBM_POINT_IN_LINE(rectLeft, rectWidth, pointX) && OBM_POINT_IN_LINE(rectTop, rectHeight, pointY) && OBM_POINT_IN_LINE(rectBack, rectDepth, pointZ))
    {
        return TRUE;
    }

    return FALSE;
}

s32 ObjRect__CenterX(OBS_RECT_WORK *work)
{
    s32 center = FX32_FROM_WHOLE(work->rect.pos.x + ((s32)(work->rect.left + work->rect.right) >> 1));
    if (work->parent != NULL)
        center += work->parent->position.x;

    return center;
}

s32 ObjRect__CenterY(OBS_RECT_WORK *work)
{
    s32 center = FX32_FROM_WHOLE(work->rect.pos.y + ((s32)(work->rect.top + work->rect.bottom) >> 1));
    if (work->parent != NULL)
        center += work->parent->position.y;

    return center;
}

fx32 ObjRect__HitCenterX(OBS_RECT_WORK *work, OBS_RECT_WORK *attacker)
{
    s32 maxPos   = 0;
    s32 minPos   = 0;
    s32 finalPos = 0;
    s32 bounds[4];
    u16 width;
    u8 i = 0;
    u8 j = 0;
    u8 idxMax, idxMin;

    ObjRect__LTBSet(work, &bounds[0], NULL, NULL);
    ObjRect__WHDSet(work, &width, NULL, NULL);
    bounds[1] = bounds[0] + width;

    ObjRect__LTBSet(attacker, &bounds[2], NULL, NULL);
    ObjRect__WHDSet(attacker, &width, NULL, NULL);
    bounds[3] = bounds[2] + width;

    if (TRUE)
    {
        // BUG: this should be set, but it isn't?
        // It IS set properly in ObjRect__HitCenterY, so it's likely it was intended to be set here too.
        // maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    if (bounds[i] > maxPos)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    if (bounds[i] > maxPos)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    if (bounds[i] > maxPos)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    i = 0;
    if (TRUE)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    if (bounds[i] < minPos)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    if (bounds[i] < minPos)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    if (bounds[i] < minPos)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    for (i = 0; TRUE; i++)
    {
        if (i != idxMax && i != idxMin)
        {
            bounds[j] = bounds[i];
            if (j != 0)
                break;
            ++j;
        }
    }

    finalPos = MATH_ABS(((bounds[0] - bounds[1]) >> 1));
    if (bounds[0] > bounds[1])
        finalPos += bounds[1];
    else
        finalPos += bounds[0];

    return FX32_FROM_WHOLE(finalPos);
}

fx32 ObjRect__HitCenterY(OBS_RECT_WORK *work, OBS_RECT_WORK *attacker)
{
    s32 maxPos   = 0;
    s32 minPos   = 0;
    s32 finalPos = 0;
    s32 bounds[4];
    u16 width;
    u8 i = 0;
    u8 j = 0;
    u8 idxMax, idxMin;

    ObjRect__LTBSet(work, NULL, &bounds[0], NULL);
    ObjRect__WHDSet(work, NULL, &width, NULL);
    bounds[1] = bounds[0] + width;

    ObjRect__LTBSet(attacker, NULL, &bounds[2], NULL);
    ObjRect__WHDSet(attacker, NULL, &width, NULL);
    bounds[3] = bounds[2] + width;

    if (TRUE)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    if (bounds[i] > maxPos)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    if (bounds[i] > maxPos)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    if (bounds[i] > maxPos)
    {
        maxPos = bounds[i];
        idxMax = i;
    }
    i++;

    i = 0;
    if (TRUE)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    if (bounds[i] < minPos)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    if (bounds[i] < minPos)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    if (bounds[i] < minPos)
    {
        minPos = bounds[i];
        idxMin = i;
    }
    i++;

    for (i = 0; TRUE; i++)
    {
        if (i != idxMax && i != idxMin)
        {
            bounds[j] = bounds[i];
            if (j != 0)
                break;
            ++j;
        }
    }

    finalPos = MATH_ABS(((bounds[0] - bounds[1]) >> 1));
    if (bounds[0] > bounds[1])
        finalPos += bounds[1];
    else
        finalPos += bounds[0];

    return FX32_FROM_WHOLE(finalPos);
}
