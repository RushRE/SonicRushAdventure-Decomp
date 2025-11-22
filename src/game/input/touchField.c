#include <game/input/touchField.h>
#include <game/math/mtMath.h>

// --------------------
// TYPES
// --------------------

typedef void (*TouchResponceCallback)(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL TouchField__ProcessSingle(TouchField *work, TouchArea *area, BOOL doBoundsCheck);
static void TouchField__ResponceCallback_0(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_1(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_2(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_3(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_4(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_5(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_6(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_7(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_8(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_9(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_10(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);
static void TouchField__ResponceCallback_11(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context);

// --------------------
// VARIABLES
// --------------------

static const TouchResponceCallback responceCallbackTable[12] = {
    TouchField__ResponceCallback_0, TouchField__ResponceCallback_1, TouchField__ResponceCallback_2,  TouchField__ResponceCallback_3,
    TouchField__ResponceCallback_4, TouchField__ResponceCallback_5, TouchField__ResponceCallback_6,  TouchField__ResponceCallback_7,
    TouchField__ResponceCallback_8, TouchField__ResponceCallback_9, TouchField__ResponceCallback_10, TouchField__ResponceCallback_11,
};

// --------------------
// FUNCTIONS
// --------------------

void TouchField__Init(TouchField *field)
{
    MI_CpuClear32(field, sizeof(*field));

    field->mode           = TOUCHFIELD_MODE_1;
    field->delayDuration1 = 15;
    field->rectSize1      = 2;
    field->rectSize2      = 4;
    field->delayDuration3 = 20;
    field->delayDuration2 = 2;
}

void TouchField__Process(TouchField *work)
{
    TouchArea *area = work->areaList;

    u32 flags;
    if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_PRESS) != 0)
        flags = TOUCHFIELD_FLAG_HAS_TOUCH_HOLD;
    else
        flags = TOUCHFIELD_FLAG_NONE;

    work->flags = flags;
    if (TOUCH_HAS_ON(touchInput.flags) != 0)
        work->flags |= TOUCHFIELD_FLAG_HAS_TOUCH_PRESS;

    if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_PRESS) != 0 && (work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_HOLD) == 0)
    {
        work->flags |= TOUCHFIELD_FLAG_HAS_TOUCH_START_POS;
        work->touchStartPos.x = touchInput.on.x;
        work->touchStartPos.y = touchInput.on.y;
    }

    if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_PRESS) == 0 && (work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_HOLD) != 0)
        work->flags |= TOUCHFIELD_FLAG_HAS_TOUCH_RELEASE;

    if (area != NULL)
    {
        if (work->mode != TOUCHFIELD_MODE_0)
        {
            do
            {
                TouchField__ProcessSingle(work, area, TRUE);
                area = area->link.next;
            } while (work->areaList != area);
        }
        else
        {
            do
            {
                if (TouchField__ProcessSingle(work, area, TRUE))
                {
                    area = area->link.next;
                    break;
                }

                area = area->link.next;
            } while (work->areaList != area);

            while (work->areaList != area)
            {
                TouchField__ProcessSingle(work, area, FALSE);
                area = area->link.next;
            }
        }
    }
}

void TouchField__InitAreaShape(TouchArea *area, Vec2Fx16 *pos, TouchAreaBoundsCheckFunc boundsCheckFunc, TouchRectUnknown *rect, TouchAreaCallback callback, void *context)
{
    MI_CpuClear8(area, sizeof(*area));

    if (pos != NULL)
    {
        VEC2_Fx16Set(&area->shape.position, pos->x, pos->y);
    }

    area->boundsCheckFunc = boundsCheckFunc;

    if (rect != NULL)
    {
        TouchField__SetHitbox(area, rect);
    }

    TouchField__ResetArea(area);

    area->callback = callback;
    area->context  = context;
}

void TouchField__ResetArea(TouchArea *area)
{
    area->delay             = 0xFFFF;
    area->responseFlags     = TOUCHAREA_RESPONSE_NONE;
    area->prevResponseFlags = TOUCHAREA_RESPONSE_NONE;
}

void TouchField__SetHitbox(TouchArea *area, TouchRectUnknown *rect)
{
    MI_CpuCopy8(rect, &area->sprite.rect, sizeof(TouchRectUnknown));
}

void TouchField__InitAreaSprite(TouchArea *area, void *animator, s32 id, s16 flags, TouchAreaCallback callback, void *context)
{
    MI_CpuClear8(area, sizeof(*area));

    area->sprite.animator        = animator;
    area->sprite.rect.id         = id;
    area->sprite.rect.flags      = flags;
    area->sprite.rect.box.bottom = -1;
    area->sprite.rect.box.right  = area->sprite.rect.box.bottom;

    if ((area->sprite.rect.flags & 1) == 0)
        AnimatorSprite__GetBlockData(animator, id, &area->sprite.rect.box);

    area->boundsCheckFunc = TouchField__PointInAnimator;
    TouchField__ResetArea(area);

    area->callback = callback;
    area->context  = context;
}

void TouchField__SetAreaHitbox(TouchArea *area, HitboxRect *hitbox)
{
    MIi_CpuCopy16(hitbox, &area->shape.hitbox, sizeof(area->shape.hitbox));
}

void TouchField__AddArea(TouchField *manager, TouchArea *area, u32 priority)
{
    area->priority = priority;

    TouchArea *firstArea = manager->areaList;
    TouchArea *lastArea  = manager->areaList;

    if (manager->areaList == NULL)
    {
        // add to start of list (no list exists yet)
        area->link.next   = area;
        area->link.prev   = area;
        manager->areaList = area;
    }
    else
    {
        if (priority == TOUCHAREA_PRIORITY_FIRST)
        {
            // add to start of list (prepend)
            area->link.next = firstArea;

            TouchArea *prev = firstArea->link.prev;

            area->link.prev            = prev;
            prev->link.next            = area;
            area->link.next->link.prev = area->link.prev->link.next;
        }
        else
        {
            // find list pos using priority value

            if (priority < firstArea->priority)
            {
                manager->areaList = area;
            }
            else if (firstArea->priority <= priority)
            {
                do
                {
                    lastArea = lastArea->link.next;
                } while (firstArea != lastArea && lastArea->priority <= priority);
            }

            // insert new area before found area
            area->link.next = lastArea;

            TouchArea *prev = lastArea->link.prev;

            area->link.prev            = prev;
            prev->link.next            = area;
            area->link.next->link.prev = area->link.prev->link.next;
        }
    }
}

void TouchField__RemoveArea(TouchField *field, TouchArea *area)
{
    area->link.next->link.prev = area->link.prev;
    area->link.prev->link.next = area->link.next;

    if (field->areaList == area)
    {
        if (area != area->link.next)
            field->areaList = area->link.next;
        else
            field->areaList = NULL;
    }
}

void TouchField__UpdateAreaPriority(TouchField *field, TouchArea *area, u32 priority)
{
    TouchField__RemoveArea(field, area);
    TouchField__AddArea(field, area, priority);
}

void TouchField__Func_206EA6C(TouchArea *area)
{
    area->responseFlags |= TOUCHAREA_RESPONSE_IN_RECT2;
    area->responseFlags &= ~TOUCHAREA_RESPONSE_CHECK_RECT2;

    if ((area->responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) == 0)
        MI_CpuCopy16(&touchInput.on, &area->touchPos, sizeof(area->touchPos));
}

void TouchField__Func_206EAA4(TouchArea *area)
{
    area->responseFlags &= ~TOUCHAREA_RESPONSE_IN_RECT2;

    if ((area->responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
        area->responseFlags |= TOUCHAREA_RESPONSE_CHECK_RECT2;
}

void TouchField__Func_206EAC4(TouchArea *area1, TouchArea *area2)
{
    TouchField__Func_206EA6C(area1);
    TouchField__Func_206EAA4(area2);
}

NONMATCH_FUNC BOOL TouchField__PointInRect(TouchArea *area)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =touchInput
	ldrsh ip, [r0, #0x24]
	ldrsh r2, [r0, #0x28]
	ldrh r3, [r1, #0x14]
	mov r1, #0
	add r2, ip, r2
	cmp r2, r3
	ldrlesh r2, [r0, #0x2c]
	mov r4, r1
	mov lr, r1
	addle r2, ip, r2
	cmple r3, r2
	movle r4, #1
	cmp r4, #0
	beq _0206EB38
	ldr r2, =touchInput
	ldrsh ip, [r0, #0x26]
	ldrsh r3, [r0, #0x2a]
	ldrh r2, [r2, #0x16]
	add r3, ip, r3
	cmp r3, r2
	movle lr, #1
_0206EB38:
	cmp lr, #0
	beq _0206EB5C
	ldr r2, =touchInput
	ldrsh r3, [r0, #0x26]
	ldrsh r0, [r0, #0x2e]
	ldrh r2, [r2, #0x16]
	add r0, r3, r0
	cmp r2, r0
	movle r1, #1
_0206EB5C:
	cmp r1, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL TouchField__PointInCircle(TouchArea *area)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, =touchInput
	ldrsh r4, [r0, #0x26]
	ldrh r2, [r1, #0x16]
	ldrsh r3, [r0, #0x24]
	ldrh r1, [r1, #0x14]
	sub r2, r4, r2
	mov r2, r2, lsl #0xc
	sub r1, r3, r1
	movs r1, r1, lsl #0xc
	rsbmi r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r2, r1
	ldr r3, =0x00000F5E
	ldr ip, =0x0000065D
	mov lr, #0
	bge _0206EBF8
	umull r7, r6, r1, r3
	mla r6, r1, lr, r6
	umull r5, r4, r2, ip
	mov r1, r1, asr #0x1f
	mla r6, r1, r3, r6
	adds r7, r7, #0x800
	adc r6, r6, #0
	adds r3, r5, #0x800
	mov r5, r7, lsr #0xc
	mla r4, r2, lr, r4
	mov r1, r2, asr #0x1f
	mla r4, r1, ip, r4
	adc r1, r4, #0
	mov r2, r3, lsr #0xc
	orr r5, r5, r6, lsl #20
	b _0206EC34
_0206EBF8:
	umull r7, r6, r2, r3
	mla r6, r2, lr, r6
	umull r5, r4, r1, ip
	mla r4, r1, lr, r4
	mov r2, r2, asr #0x1f
	mov r1, r1, asr #0x1f
	mla r6, r2, r3, r6
	adds r7, r7, #0x800
	adc r3, r6, #0
	adds r2, r5, #0x800
	mla r4, r1, ip, r4
	mov r5, r7, lsr #0xc
	adc r1, r4, #0
	mov r2, r2, lsr #0xc
	orr r5, r5, r3, lsl #20
_0206EC34:
	orr r2, r2, r1, lsl #20
	ldr r0, [r0, #0x28]
	add r1, r5, r2
	cmp r1, r0
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL TouchField__PointInAnimator(TouchArea *area)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, [r4, #0x24]
	ldr r1, [r0, #0x3c]
	tst r1, #1
	beq _0206EC84
	ldrh r1, [r4, #0x2a]
	tst r1, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_0206EC84:
	ldr r1, =0x04000304
	ldrh r1, [r1, #0]
	and r1, r1, #0x8000
	mov r1, r1, asr #0xf
	cmp r1, #1
	bne _0206ECA8
	ldr r1, [r0, #4]
	cmp r1, #1
	bne _0206ECC8
_0206ECA8:
	ldr r1, =0x04000304
	ldrh r1, [r1, #0]
	and r1, r1, #0x8000
	movs r1, r1, asr #0xf
	bne _0206ECD8
	ldr r1, [r0, #4]
	cmp r1, #0
	beq _0206ECD8
_0206ECC8:
	ldrh r1, [r4, #0x2a]
	tst r1, #0x10
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_0206ECD8:
	ldrh r1, [r4, #0x2a]
	tst r1, #2
	bne _0206ED1C
	ldrh r1, [r4, #0x28]
	add r2, r4, #0x2c
	bl AnimatorSprite__GetBlockData
	cmp r0, #0
	beq _0206ED1C
	ldrh r0, [r4, #0x2a]
	tst r0, #4
	beq _0206ED1C
	ldrsh r0, [r4, #0x2c]
	sub r0, r0, #1
	strh r0, [r4, #0x30]
	ldrsh r0, [r4, #0x2e]
	sub r0, r0, #1
	strh r0, [r4, #0x32]
_0206ED1C:
	ldr r3, [r4, #0x24]
	ldr r5, [r3, #0x3c]
	tst r5, #0x100
	beq _0206ED5C
	ldrh r0, [r4, #0x2a]
	tst r0, #0x20
	bne _0206ED5C
	ldrsh r1, [r4, #0x32]
	ldrsh r0, [r4, #0x2e]
	rsb r2, r1, #0
	rsb r1, r0, #0
	mov r0, r2, lsl #0x10
	mov r2, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r2, r2, asr #0x10
	b _0206ED64
_0206ED5C:
	ldrsh r1, [r4, #0x2e]
	ldrsh r2, [r4, #0x32]
_0206ED64:
	tst r5, #0x80
	beq _0206ED9C
	ldrh r0, [r4, #0x2a]
	tst r0, #0x40
	bne _0206ED9C
	ldrsh ip, [r4, #0x30]
	ldrsh r0, [r4, #0x2c]
	rsb ip, ip, #0
	rsb r4, r0, #0
	mov r0, ip, lsl #0x10
	mov r4, r4, lsl #0x10
	mov r5, r0, asr #0x10
	mov r7, r4, asr #0x10
	b _0206EDA4
_0206ED9C:
	ldrsh r5, [r4, #0x2c]
	ldrsh r7, [r4, #0x30]
_0206EDA4:
	ldr r0, =touchInput
	ldrsh lr, [r3, #8]
	ldrh ip, [r0, #0x14]
	mov r0, #0
	add r4, lr, r5
	cmp r4, ip
	addle r4, lr, r7
	mov r6, r0
	cmple ip, r4
	movle r6, #1
	mov r5, r0
	cmp r6, #0
	beq _0206EDF0
	ldr r4, =touchInput
	ldrsh ip, [r3, #0xa]
	ldrh r4, [r4, #0x16]
	add r1, ip, r1
	cmp r1, r4
	movle r5, #1
_0206EDF0:
	cmp r5, #0
	beq _0206EE10
	ldr r1, =touchInput
	ldrsh r3, [r3, #0xa]
	ldrh r4, [r1, #0x16]
	add r1, r3, r2
	cmp r4, r1
	movle r0, #1
_0206EE10:
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

BOOL TouchField__ProcessSingle(TouchField *work, TouchArea *area, BOOL doBoundsCheck)
{
    if ((area->responseFlags & TOUCHAREA_RESPONSE_DISABLED) != 0)
        return FALSE;

    if ((area->responseFlags & TOUCHAREA_RESPONSE_NO_BOUNDS_CHECK) != 0)
        doBoundsCheck = FALSE;

    area->prevResponseFlags = area->responseFlags;

    if (doBoundsCheck && (work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_PRESS) != 0 && area->boundsCheckFunc(area))
    {
        area->responseFlags = area->prevResponseFlags & (TOUCHAREA_RESPONSE_NO_BOUNDS_CHECK | TOUCHAREA_RESPONSE_DISABLED);
        area->responseFlags |= TOUCHAREA_RESPONSE_IN_BOUNDS;
    }
    else
    {
        area->responseFlags = area->prevResponseFlags & (TOUCHAREA_RESPONSE_NO_BOUNDS_CHECK | TOUCHAREA_RESPONSE_DISABLED);
    }

    if ((area->prevResponseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
        area->responseFlags |= TOUCHAREA_RESPONSE_20;

    if ((area->prevResponseFlags & TOUCHAREA_RESPONSE_EXITED_AREA_ALT) != 0)
    {
        area->responseFlags |= (area->prevResponseFlags & TOUCHAREA_RESPONSE_WANT_DELAY);
    }
    else
    {
        area->responseFlags |=
            (area->prevResponseFlags & (TOUCHAREA_RESPONSE_HAS_DELAY | TOUCHAREA_RESPONSE_WANT_DELAY | TOUCHAREA_RESPONSE_CHECK_RECT2 | TOUCHAREA_RESPONSE_IN_RECT2));
    }

    u32 isInBounds = area->responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS;
    if ((area->responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0 || (area->prevResponseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
    {
        if (isInBounds && (area->prevResponseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) == 0)
        {
            area->responseFlags |= TOUCHAREA_RESPONSE_ENTERED_AREA_2;

            u32 flag;
            if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_START_POS) != 0)
                flag = TOUCHAREA_RESPONSE_ENTERED_AREA_ALT;
            else
                flag = TOUCHAREA_RESPONSE_ENTERED_AREA;
            area->responseFlags |= flag;
            area->responseFlags |= TOUCHAREA_RESPONSE_ENTERED_AREA_3;
            area->delay = work->delayDuration3;

            if ((area->responseFlags & TOUCHAREA_RESPONSE_IN_RECT2) == 0)
            {
                MI_CpuCopy16(&touchInput.on, &area->touchPos, sizeof(area->touchPos));
            }
            else
            {
                if (work->rectSize1 <= MATH_ABS((s16)touchInput.on.x - (s16)area->touchPos.x) || work->rectSize1 <= MATH_ABS((s16)touchInput.on.y - (s16)area->touchPos.y))
                {
                    area->responseFlags |= TOUCHAREA_RESPONSE_MOVED_IN_AREA | TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT;
                }
            }
        }
        else
        {
            if (!isInBounds && (area->prevResponseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
            {
                area->responseFlags |= TOUCHAREA_RESPONSE_20000;

                u32 flag;
                if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_RELEASE) != 0)
                    flag = TOUCHAREA_RESPONSE_EXITED_AREA_ALT;
                else
                    flag = TOUCHAREA_RESPONSE_EXITED_AREA;
                area->responseFlags |= flag;

                area->delay = 0xFFFF;
            }
            else
            {
                if (isInBounds)
                {
                    if ((area->prevResponseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
                    {
                        if (work->rectSize1 <= MATH_ABS((s16)touchInput.on.x - (s16)area->touchPos.x) || work->rectSize1 <= MATH_ABS((s16)touchInput.on.y - (s16)area->touchPos.y))
                        {
                            area->responseFlags |= TOUCHAREA_RESPONSE_MOVED_IN_AREA;
                        }

                        if ((area->prevResponseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                        {
                            if (work->rectSize2 <= MATH_ABS((s16)touchInput.on.x - (s16)work->touchStartPos.x)
                                || work->rectSize2 <= MATH_ABS((s16)touchInput.on.y - (s16)work->touchStartPos.y))
                            {
                                area->responseFlags |= TOUCHAREA_RESPONSE_IN_RECT2;
                            }
                        }

                        if ((area->responseFlags & TOUCHAREA_RESPONSE_IN_RECT2) != 0 && (area->responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) != 0)
                        {
                            area->responseFlags |= TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT;
                        }
                    }
                }
            }
        }
    }

    if ((area->responseFlags & TOUCHAREA_RESPONSE_ENTERED_AREA_ALT) != 0)
    {
        if ((area->responseFlags & TOUCHAREA_RESPONSE_WANT_DELAY) != 0 && area->delay != 0xFFFF)
        {
            area->responseFlags |= TOUCHAREA_RESPONSE_100000 | TOUCHAREA_RESPONSE_HAS_DELAY;
            area->responseFlags &= ~TOUCHAREA_RESPONSE_WANT_DELAY;
            area->delay = 0xFFFF;
        }

        if (work->rectSize2 == 0)
            area->responseFlags |= TOUCHAREA_RESPONSE_IN_RECT2;
    }
    else if ((area->responseFlags & TOUCHAREA_RESPONSE_EXITED_AREA_ALT) != 0)
    {
        if ((area->prevResponseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (area->responseFlags & TOUCHAREA_RESPONSE_HAS_DELAY) == 0)
        {
            area->responseFlags |= TOUCHAREA_RESPONSE_40000 | TOUCHAREA_RESPONSE_WANT_DELAY;
            area->delay = work->delayDuration1;
        }
    }
    else if ((area->responseFlags & TOUCHAREA_RESPONSE_IN_RECT2) != 0)
    {
        if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_PRESS) != 0)
        {
            if (work->rectSize1 <= MATH_ABS((s16)touchInput.on.x - (s16)area->touchPos.x) || work->rectSize1 <= MATH_ABS((s16)touchInput.on.y - (s16)area->touchPos.y))
            {
                area->responseFlags |= TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT;
            }
        }

        if ((work->flags & TOUCHFIELD_FLAG_HAS_TOUCH_RELEASE) != 0)
            area->responseFlags |= TOUCHAREA_RESPONSE_EXITED_AREA_ALT;
    }
    else
    {
        if ((area->responseFlags & TOUCHAREA_RESPONSE_ENTERED_AREA) != 0)
        {
            area->responseFlags |= TOUCHAREA_RESPONSE_MOVED_IN_AREA | TOUCHAREA_RESPONSE_CHECK_RECT2;
        }
        else if ((area->prevResponseFlags & TOUCHAREA_RESPONSE_EXITED_AREA) != 0)
        {
            area->responseFlags &= ~(TOUCHAREA_RESPONSE_HAS_DELAY | TOUCHAREA_RESPONSE_CHECK_RECT2);
        }
    }

    if (area->delay != 0xFFFF)
    {
        if (area->delay-- == 0)
        {
            if ((area->responseFlags & TOUCHAREA_RESPONSE_WANT_DELAY) != 0)
            {
                area->responseFlags |= TOUCHAREA_RESPONSE_80000;
                area->responseFlags &= ~TOUCHAREA_RESPONSE_WANT_DELAY;
            }
            else
            {
                area->responseFlags |= TOUCHAREA_RESPONSE_ENTERED_AREA_3;
                area->delay = work->delayDuration2;
            }
        }
    }

    TouchAreaCallback callback = area->callback;
    if (area->callback != NULL)
    {
        u16 i;
        void *arg         = area->context;
        u32 responseFlags = TOUCHAREA_RESPONSE_ENTERED_AREA_2;

        for (i = 0; i < 12; i++)
        {
            if ((area->responseFlags & responseFlags) != 0)
                responceCallbackTable[i](responseFlags, area, callback, arg);

            responseFlags <<= 1;
        }
    }

    if ((area->responseFlags & (TOUCHAREA_RESPONSE_MOVED_IN_AREA | TOUCHAREA_RESPONSE_MOVED_IN_AREA_ALT)) != 0)
        MI_CpuCopy16(&touchInput.on, &area->touchPos, sizeof(area->touchPos));

    return (area->responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0;
}

void TouchField__ResponceCallback_0(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_1(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_2(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_3(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_4(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_5(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_6(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_7(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponse responceState;

    responceState.flags  = response;
    responceState.move.x = (s16)touchInput.on.x - (s16)area->touchPos.x;
    responceState.move.y = (s16)touchInput.on.y - (s16)area->touchPos.y;
    callback(&responceState, area, context);
}

void TouchField__ResponceCallback_8(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_9(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}

void TouchField__ResponceCallback_10(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponse responceState;

    responceState.flags  = response;
    responceState.move.x = (s16)touchInput.on.x - (s16)area->touchPos.x;
    responceState.move.y = (s16)touchInput.on.y - (s16)area->touchPos.y;
    callback(&responceState, area, context);
}

void TouchField__ResponceCallback_11(TouchAreaResponseFlags response, TouchArea *area, TouchAreaCallback callback, void *context)
{
    TouchAreaResponseFlags responceFlags;

    responceFlags = response;
    callback((TouchAreaResponse *)&responceFlags, area, context);
}
