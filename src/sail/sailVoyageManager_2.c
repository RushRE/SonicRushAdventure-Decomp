#include <sail/sailVoyageManager.h>
#include <sail/sailManager.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapUnknown204A9E4.h>
#include <seaMap/seaMapUnknown204AB60.h>
#include <sail/sailPlayer.h>
#include <game/object/obj.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED u32 _0218BBB4[2];

NOT_DECOMPILED void _ull_mul(void);

NOT_DECOMPILED void SailGoal__Create(void);
NOT_DECOMPILED void SailChaosEmerald__Create(void);
NOT_DECOMPILED void SailGoalText__Create(void);

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

NONMATCH_FUNC void SailVoyageManager__Func_2158028(SailVoyageManager *work, s32 a2)
{
	// https://decomp.me/scratch/AkDuO -> 93.74%
#ifdef NON_MATCHING
    SailManager *manager = SailManager__GetWork();
    StageTask *player    = SailManager__GetWork()->sailPlayer;
    if (player != NULL)
    {
        SailPlayer *playerWorker = GetStageTaskWorker(SailManager__GetWork()->sailPlayer, SailPlayer);
        UNUSED(playerWorker);
    }

    if ((manager->flags & 8) == 0)
    {
        u32 v4;

        switch (a2 - 14)
        {
            case 0:
                break;

            case 1:
            case 10:
            case 11:
                work->dword54 = work->field_58;
                NNS_SndPlayerStopSeq(&defaultTrackPlayer, 0);
				PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SAIL_SEQ_SEQ_DISCOVER);
                manager->flags |= 0x20;
                SailPlayer__Action_ReachedGoal(player);
                v4 = SeaMapEventManager__Func_2046CE8((s16)manager->field_4);
                if ((manager->flags & 0x1000) == 0)
                {
                    if (!SeaMapEventManager__CheckFeatureUnlocked(v4))
                        manager->flags |= 0x80000;
                    SeaMapUnknown204A9E4__RunCallbacks(7, (CHEVObject*)manager->field_4, 0);
                }
                break;

            case 2:
            case 4:
            case 6:
            case 12:
                break;

            case 3:
            case 5:
            case 7:
                break;

            case 8:
                break;

            case 9:
                break;

            case 13:
                break;
        }
    }
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x54
	str r1, [sp, #4]
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	ldr r7, =gameState
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r6, #0
	str r0, [sp, #8]
	cmp r0, #0
	beq _02158052
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	mov r0, #0x49
	lsl r0, r0, #2
	ldr r6, [r1, r0]
_02158052:
	ldr r0, [r4, #0x24]
	mov r2, #8
	mov r1, r0
	tst r1, r2
	beq _0215805E
	b _0215821C
_0215805E:
	ldr r1, [sp, #4]
	sub r1, #0xe
	str r1, [sp, #4]
	cmp r1, #0xd
	bhi _02158138
	ldr r1, [sp, #4]
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	// add pc, r1
_02158076: // jump table
    DCD 0x24448F
    DCD 0x7E00C0
    DCD 0x7E011E
    DCD 0x7E011E
    DCD 0x1A011E
    DCD 0xC00142
    DCD 0x7E00C0
    DCD 0x191016E
	// .hword _0215809C - _02158076 - 2 // case 0
	// .hword _02158138 - _02158076 - 2 // case 1
	// .hword _021580F6 - _02158076 - 2 // case 2
	// .hword _02158196 - _02158076 - 2 // case 3
	// .hword _021580F6 - _02158076 - 2 // case 4
	// .hword _02158196 - _02158076 - 2 // case 5
	// .hword _021580F6 - _02158076 - 2 // case 6
	// .hword _02158196 - _02158076 - 2 // case 7
	// .hword _02158092 - _02158076 - 2 // case 8
	// .hword _021581BA - _02158076 - 2 // case 9
	// .hword _02158138 - _02158076 - 2 // case 10
	// .hword _02158138 - _02158076 - 2 // case 11
	// .hword _021580F6 - _02158076 - 2 // case 12
	// .hword _021581E6 - _02158076 - 2 // case 13
_02158092:
	// lsl r1, r2, #6
	orr r0, r1
	add sp, #0x54
	str r0, [r4, #0x24]
	pop {r4, r5, r6, r7, pc}
_0215809C:
	ldr r3, =_0218BBB4
	add r2, sp, #0xc
	ldmia r3!, {r0, r1}
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	ldr r3, =FX_SinCosTable_
	str r0, [r2]
	ldrh r0, [r5, #0x34]
	asr r0, r0, #4
	lsl r2, r0, #1
	lsl r1, r2, #1
	add r2, r2, #1
	lsl r2, r2, #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x18
	bl MTX_RotY33_
	add r0, sp, #0xc
	add r1, sp, #0x18
	mov r2, r0
	bl MTX_MultVec33
	mov r6, r5
	add r3, sp, #0x3c
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	add r1, sp, #0xc
	str r0, [r3]
	mov r0, r2
	bl VEC_Add
	mov r1, #0
	add r0, sp, #0xc
	strh r1, [r0, #0x3c]
	mov r1, #6
	lsl r1, r1, #6
	add r0, sp, #0x3c
	strh r1, [r0, #0x10]
	ldr r1, [r4, #4]
	str r1, [sp, #0x50]
	bl SailEventManager__LoadObject
_021580F6:
	ldr r0, [r4, #0xc]
	ldr r1, [r5, #0x44]
	cmp r0, #0
	ldr r0, =0xFFF80000
	bne _0215810E
	and r1, r0
	mov r0, #2
	lsl r0, r0, #0x12
	add r0, r1, r0
	bl SailGoalText__Create
	b _0215811A
_0215810E:
	and r1, r0
	mov r0, #2
	lsl r0, r0, #0x12
	add r0, r1, r0
	bl SailChaosEmerald__Create
_0215811A:
	ldr r1, [r5, #0x44]
	ldr r0, =0xFFF80000
	and r1, r0
	mov r0, #2
	lsl r0, r0, #0x12
	add r0, r1, r0
	bl SailGoal__Create
	mov r0, #2
	ldr r1, [r4, #0x24]
	lsl r0, r0, #8
	orr r0, r1
	add sp, #0x54
	str r0, [r4, #0x24]
	pop {r4, r5, r6, r7, pc}
_02158138:
	ldr r0, [r5, #0x58]
	mov r1, #0
	str r0, [r5, #0x54]
	ldr r0, =defaultTrackPlayer
	bl NNS_SndPlayerStopSeq
	mov r0, #5
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	ldr r1, [r4, #0x24]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
	ldr r0, [r4, #4]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	bl SeaMapEventManager__Func_2046CE8
	mov r1, #1
	ldr r2, [r4, #0x24]
	lsl r1, r1, #0xc
	tst r1, r2
	bne _0215821C
	bl SeaMapEventManager__CheckFeatureUnlocked
	cmp r0, #0
	bne _02158188
	mov r0, #2
	ldr r1, [r4, #0x24]
	lsl r0, r0, #0x12
	orr r0, r1
	str r0, [r4, #0x24]
_02158188:
	ldr r1, [r4, #4]
	mov r0, #7
	mov r2, #0
	bl SeaMapUnknown204A9E4__RunCallbacks
	add sp, #0x54
	pop {r4, r5, r6, r7, pc}
_02158196:
	ldr r0, [r5, #0x58]
	str r0, [r5, #0x54]
	ldr r1, [r4, #0x24]
	mov r0, #0x40
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
	cmp r6, #0
	beq _0215821C
	mov r0, #0x6e
	lsl r0, r0, #2
	ldr r0, [r6, r0]
	add r7, #0xac
	add sp, #0x54
	str r0, [r7]
	pop {r4, r5, r6, r7, pc}
_021581BA:
	ldr r0, [r5, #0x58]
	str r0, [r5, #0x54]
	ldr r1, [r4, #0x24]
	lsl r0, r2, #0xb
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
	cmp r6, #0
	beq _021581DC
	mov r0, #0x6e
	lsl r0, r0, #2
	ldr r1, [r6, r0]
	mov r0, r7
	add r0, #0xac
	str r1, [r0]
_021581DC:
	ldr r0, [r5, #0x54]
	add r7, #0xa8
	add sp, #0x54
	str r0, [r7]
	pop {r4, r5, r6, r7, pc}
_021581E6:
	lsl r1, r2, #0x16
	orr r0, r1
	str r0, [r4, #0x24]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02158212
	mov r0, r7
	add r0, #0xb8
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02158212
	cmp r6, #0
	beq _02158212
	mov r0, r7
	add r0, #0xac
	ldr r0, [r0, #0]
	add r7, #0xac
	str r0, [r4, #0x2c]
	mov r0, #0x6e
	lsl r0, r0, #2
	ldr r0, [r6, r0]
	str r0, [r7]
_02158212:
	ldr r0, [r5, #0x58]
	str r0, [r5, #0x54]
	ldr r0, [sp, #8]
	bl SailPlayer__Action_ReachedGoal
_0215821C:
	add sp, #0x54
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailVoyageManager__Func_2158234(SailVoyageManager *work)
{
	// https://decomp.me/scratch/gTH8W -> 80.38%
#ifdef NON_MATCHING
    SailManager *manager = SailManager__GetWork();

    if (SailManager__GetShipType() != SHIP_SUBMARINE && !manager->isRivalRace && !manager->missionType)
    {
        for (u16 i = 0; i < work->field_FE; i++)
        {
            work->field_F4[i] = work->field_CC[i].object->unlockID;
        }
        work->field_FE = 5;

        SeaMapEventManager__Func_2046B14(work->int5C, work->dword60, 0x40000, work->field_CC, &work->field_FE);

        for (u16 j = 0; j < work->field_FE; j++)
        {
            BOOL flag = TRUE;

            for (u16 k = 0; k < work->field_FE; k++)
            {
                if (work->field_F4[k] == work->field_CC[j].object->unlockID)
                    flag = FALSE;

                if (manager->field_4 == work->field_CC[j].object->unlockID)
                    flag = FALSE;
            }

            if (flag)
            {
                SBBObject sbbObject;

                sbbObject.radius   = work->field_0.x;
                sbbObject.field_4  = work->field_0.y;
                sbbObject.field_8  = work->field_0.z;
                sbbObject.type     = 0;
                sbbObject.field_10 = 384;
                sbbObject.field_14 = work->field_CC[j].object->unlockID;
                SailEventManager__LoadObject(&sbbObject);
            }
        }
    }
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	mov r5, r0
	bl SailManager__GetWork
	str r0, [sp, #8]
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02158340
	ldr r0, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _02158340
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x12]
	cmp r0, #0
	bne _02158340
	mov r1, r5
	add r1, #0xfe
	ldrh r4, [r1, #0]
	mov r0, #0
	cmp r4, #0
	bls _02158288
	mov r2, #0x10
_02158266:
	lsl r1, r0, #3
	add r1, r5, r1
	add r1, #0xcc
	ldr r1, [r1, #0]
	ldrsh r3, [r1, r2]
	lsl r1, r0, #1
	add r1, r5, r1
	add r1, #0xf4
	strh r3, [r1]
	mov r1, r5
	add r1, #0xfe
	add r0, r0, #1
	lsl r0, r0, #0x10
	ldrh r4, [r1, #0]
	lsr r0, r0, #0x10
	cmp r0, r4
	blo _02158266
_02158288:
	mov r0, r5
	mov r1, #5
	add r0, #0xfe
	strh r1, [r0]
	mov r0, r5
	add r0, #0xfe
	str r0, [sp]
	mov r2, #1
	mov r3, r5
	ldr r0, [r5, #0x5c]
	ldr r1, [r5, #0x60]
	lsl r2, r2, #0x12
	add r3, #0xcc
	bl SeaMapEventManager__Func_2046B14
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r5
	add r0, #0xfe
	ldrh r0, [r0, #0]
	cmp r0, #0
	bls _02158340
_021582B4:
	mov r1, #1
	mov r0, #0
	cmp r4, #0
	bls _021582EE
	ldr r2, [sp, #4]
	mov r7, r0
	lsl r2, r2, #3
	add r2, r5, r2
	add r2, #0xcc
	ldr r3, [r2, #0]
	mov r2, #0x10
	ldrsh r2, [r3, r2]
	ldr r3, [sp, #8]
	ldr r3, [r3, #4]
_021582D0:
	lsl r6, r0, #1
	add r6, r5, r6
	add r6, #0xf4
	ldrh r6, [r6, #0]
	cmp r6, r2
	bne _021582DE
	mov r1, r7
_021582DE:
	cmp r3, r2
	bne _021582E4
	mov r1, #0
_021582E4:
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	cmp r0, r4
	blo _021582D0
_021582EE:
	cmp r1, #0
	beq _0215832A
	add r0, sp, #0xc
	mov r7, #0
	str r7, [r0]
	str r7, [r0, #4]
	add r3, sp, #0x18
	mov r6, r5
	str r7, [r0, #8]
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	mov r1, #6
	str r0, [r3]
	add r0, sp, #0xc
	strh r7, [r0, #0x18]
	lsl r1, r1, #6
	strh r1, [r0, #0x1c]
	ldr r0, [sp, #4]
	lsl r0, r0, #3
	add r0, r5, r0
	add r0, #0xcc
	ldr r1, [r0, #0]
	mov r0, #0x10
	ldrsh r0, [r1, r0]
	str r0, [sp, #0x2c]
	mov r0, r2
	bl SailEventManager__LoadObject
_0215832A:
	ldr r0, [sp, #4]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #4]
	mov r0, r5
	add r0, #0xfe
	ldrh r1, [r0, #0]
	ldr r0, [sp, #4]
	cmp r0, r1
	blo _021582B4
_02158340:
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SailVoyageManager__LinkSegments(SailVoyageManager *work)
{
    Vec2Fx32 a2 = { 0, 0 };
    Vec2Fx32 a4 = { 0, 0 };

    SailVoyageSegment *firstSegment = work->segmentList;
    firstSegment->field_C.x         = work->field_18;
    firstSegment->field_C.y         = work->field_20;
    firstSegment->field_14          = firstSegment->field_C;
    firstSegment->angle             = work->angle;
    firstSegment->field_4           = 0;
    firstSegment->field_24          = 0;

    a2.x                     = MultiplyFX(-SailVoyageManager__Func_2157B14(firstSegment), SinFX(firstSegment->angle));
    a2.y                     = MultiplyFX(-SailVoyageManager__Func_2157B14(firstSegment), CosFX(firstSegment->angle));
    firstSegment->field_1C.x = firstSegment->field_C.x + a2.x;
    firstSegment->field_1C.y = firstSegment->field_C.y + a2.y;

    a2.x >>= 1;
    a2.y >>= 1;
    firstSegment->field_14.x = firstSegment->field_C.x + a2.x;
    firstSegment->field_14.y = firstSegment->field_C.y + a2.y;

    for (u16 i = 1; i < 0x100; i++)
    {
        s32 prevSlot                   = i - 1;
        SailVoyageSegment *prevSegment = &work->segmentList[prevSlot];
        SailVoyageSegment *segment     = &work->segmentList[(s32)i];

        segment->field_24 = prevSegment->field_24;
        segment->angle    = prevSegment->angle;
        segment->field_C  = prevSegment->field_1C;
        segment->field_24 += SailVoyageManager__Func_2157B14(prevSegment);
        segment->angle += prevSegment->field_4;

        a2.x                = MultiplyFX(-SailVoyageManager__Func_2157B14(segment), SinFX((s32)(u16)(segment->angle + (segment->field_4 >> 1))));
        a2.y                = MultiplyFX(-SailVoyageManager__Func_2157B14(segment), CosFX((s32)(u16)(segment->angle + (segment->field_4 >> 1))));
        segment->field_1C.x = segment->field_C.x + a2.x;
        segment->field_1C.y = segment->field_C.y + a2.y;

        if (segment->field_4 == 0 || segment->field_4 == 0x8000)
        {
            a2.x = MultiplyFX(-SailVoyageManager__Func_2157B14(prevSegment), SinFX(segment->angle));
            a2.y = MultiplyFX(-SailVoyageManager__Func_2157B14(prevSegment), CosFX(segment->angle));
            a2.x >>= 1;
            a2.y >>= 1;

            segment->field_14.x = segment->field_C.x + a2.x;
            segment->field_14.y = segment->field_C.y + a2.y;
        }
        else
        {
            a2.x = MultiplyFX(-SailVoyageManager__Func_2157B14(prevSegment), SinFX(segment->angle));
            a2.y = MultiplyFX(-SailVoyageManager__Func_2157B14(prevSegment), CosFX(segment->angle));
            a2.x += segment->field_C.x;
            a2.y += segment->field_C.y;

            a4.x = MultiplyFX(-SailVoyageManager__Func_2157B14(segment), SinFX((s32)(u16)(segment->angle + segment->field_4)));
            a4.y = MultiplyFX(-SailVoyageManager__Func_2157B14(segment), CosFX((s32)(u16)(segment->angle + segment->field_4)));

            a4.x += segment->field_1C.x;
            a4.y += segment->field_1C.y;
            SailVoyageManager__Func_215868C(&segment->field_C, &a2, &segment->field_1C, &a4, &segment->field_14);
        }

        if (i == work->segmentCount + 1)
            break;
    }
}

NONMATCH_FUNC void SailVoyageManager__Func_215868C(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, Vec2Fx32 *a5){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	mov r6, r2
	ldr r2, [r0, #4]
	ldr r0, [r0, #0]
	asr r5, r2, #4
	ldr r2, [r1, #4]
	str r3, [sp]
	asr r2, r2, #4
	sub r2, r2, r5
	str r2, [sp, #0x20]
	asr r2, r0, #4
	ldr r0, [r1, #0]
	asr r3, r2, #0x1f
	asr r0, r0, #4
	sub r0, r2, r0
	str r0, [sp, #0x24]
	asr r0, r0, #0x1f
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x20]
	ldr r4, [sp, #0x60]
	neg r0, r0
	asr r1, r0, #0x1f
	bl _ull_mul
	str r0, [sp, #0x2c]
	mov r7, r1
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, r0
	mov r3, r1
	mov r0, #2
	ldr r1, [sp, #0x2c]
	mov r5, #0
	lsl r0, r0, #0xa
	add r0, r1, r0
	adc r7, r5
	lsl r1, r7, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	mov r1, #2
	lsl r1, r1, #0xa
	add r2, r2, r1
	adc r3, r5
	lsl r1, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r1
	sub r0, r0, r2
	str r0, [sp, #0x18]
	ldr r0, [r6, #4]
	asr r5, r0, #4
	ldr r0, [sp]
	ldr r0, [r0, #4]
	asr r0, r0, #4
	sub r0, r0, r5
	str r0, [sp, #0x1c]
	ldr r0, [r6, #0]
	asr r2, r0, #4
	ldr r0, [sp]
	asr r3, r2, #0x1f
	ldr r0, [r0, #0]
	asr r0, r0, #4
	sub r6, r2, r0
	ldr r0, [sp, #0x1c]
	asr r7, r6, #0x1f
	neg r0, r0
	asr r1, r0, #0x1f
	bl _ull_mul
	str r0, [sp, #0x30]
	str r1, [sp, #0x10]
	mov r0, r6
	mov r1, r7
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, #2
	ldr r3, [sp, #0x30]
	lsl r2, r2, #0xa
	mov r5, #0
	add r3, r3, r2
	ldr r2, [sp, #0x10]
	adc r2, r5
	str r2, [sp, #0x10]
	lsl r2, r2, #0x14
	lsr r3, r3, #0xc
	orr r3, r2
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	adc r1, r5
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	sub r5, r3, r0
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x28]
	asr r0, r0, #0x1f
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x1c]
	ldr r2, [sp, #0x1c]
	asr r0, r0, #0x1f
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x24]
	ldr r3, [sp, #0x38]
	bl _ull_mul
	str r0, [sp, #0x3c]
	str r1, [sp, #8]
	ldr r2, [sp, #0x20]
	ldr r3, [sp, #0x34]
	mov r0, r6
	mov r1, r7
	bl _ull_mul
	mov ip, r0
	mov r3, r1
	mov r0, #2
	ldr r1, [sp, #0x3c]
	lsl r0, r0, #0xa
	add r2, r1, r0
	ldr r1, [sp, #8]
	ldr r0, =0x00000000
	adc r1, r0
	str r1, [sp, #8]
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, #2
	lsl r0, r0, #0xa
	mov r2, ip
	add r2, r2, r0
	ldr r0, =0x00000000
	adc r3, r0
	lsl r0, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r0
	sub r0, r1, r2
	str r0, [sp, #0x14]
	beq _0215884A
	asr r0, r5, #0x1f
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x18]
	mov r2, r6
	asr r0, r0, #0x1f
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x44]
	mov r3, r7
	bl _ull_mul
	mov r6, r1
	mov r7, r0
	ldr r1, [sp, #0x40]
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x28]
	mov r0, r5
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	ldr r3, =0x00000000
	add r2, r7, r2
	adc r6, r3
	lsl r3, r6, #0x14
	lsr r2, r2, #0xc
	orr r2, r3
	mov r3, #2
	lsl r3, r3, #0xa
	add r3, r0, r3
	ldr r0, =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r3, #0xc
	orr r1, r0
	sub r0, r2, r1
	ldr r1, [sp, #0x14]
	bl FX_Div
	str r0, [r4]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x34]
	ldr r3, [sp, #0x40]
	mov r2, r5
	bl _ull_mul
	mov r6, r0
	mov r5, r1
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x38]
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x44]
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r6, r6, r2
	adc r5, r3
	lsl r5, r5, #0x14
	lsr r6, r6, #0xc
	orr r6, r5
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	sub r0, r6, r1
	ldr r1, [sp, #0x14]
	bl FX_Div
	str r0, [r4, #4]
	ldr r0, [r4, #0]
	lsl r0, r0, #4
	str r0, [r4]
	ldr r0, [r4, #4]
	lsl r0, r0, #4
	str r0, [r4, #4]
_0215884A:
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

u16 SailVoyageManager__Func_2158854(SailVoyageSegment *segment, s32 a2)
{
    SailManager *manager = SailManager__GetWork();

    return segment->angle + MultiplyFX(a2, segment->field_4);
}

NONMATCH_FUNC void SailVoyageManager__Func_2158888(SailVoyageSegment *segment, s32 a2, fx32 *x, fx32 *z)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x40
	mov r4, r0
	mov r7, r1
	str r2, [sp]
	str r3, [sp, #4]
	bl SailManager__GetWork
	mov r0, #1
	lsl r0, r0, #0xc
	sub r0, r0, r7
	asr r5, r0, #0x1f
	mov r1, r5
	mov r2, r0
	mov r3, r5
	str r0, [sp, #0x18]
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsr r6, r2, #0xc
	lsl r0, r1, #0x14
	orr r6, r0
	lsl r0, r7, #1
	ldr r2, [sp, #0x18]
	asr r1, r0, #0x1f
	mov r3, r5
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r5, r2, #0xc
	asr r1, r7, #0x1f
	orr r5, r0
	mov r0, r7
	mov r2, r7
	mov r3, r1
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r0, r0, r2
	adc r1, r3
	lsr r0, r0, #0xc
	lsl r1, r1, #0x14
	str r0, [sp, #0x14]
	orr r0, r1
	add r1, r6, r5
	str r0, [sp, #0x14]
	add r1, r0, r1
	lsl r0, r2, #1
	cmp r1, r0
	beq _02158906
	sub r0, r0, r1
	add r5, r5, r0
_02158906:
	asr r0, r5, #0x1f
	str r0, [sp, #0x1c]
	asr r0, r6, #0x1f
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x14]
	ldr r2, [r4, #0x1c]
	asr r0, r0, #0x1f
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x24]
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0xc]
	str r1, [sp, #0xc]
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x20]
	mov r0, r6
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x14]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x2c]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov ip, r0
	mov r7, r1
	mov r0, #2
	ldr r1, [sp, #0x28]
	lsl r0, r0, #0xa
	add r0, r1, r0
	ldr r2, [sp, #0xc]
	ldr r1, =0x00000000
	adc r2, r1
	str r2, [sp, #0xc]
	lsl r1, r2, #0x14
	lsr r2, r0, #0xc
	orr r2, r1
	mov r0, #2
	ldr r1, [sp, #0x2c]
	lsl r0, r0, #0xa
	add r3, r1, r0
	ldr r1, =0x00000000
	ldr r0, [sp, #0x3c]
	adc r0, r1
	str r0, [sp, #0x3c]
	lsr r1, r3, #0xc
	lsl r0, r0, #0x14
	orr r1, r0
	mov r0, #2
	mov r3, ip
	lsl r0, r0, #0xa
	add r3, r3, r0
	ldr r0, =0x00000000
	adc r7, r0
	lsl r0, r7, #0x14
	lsr r3, r3, #0xc
	orr r3, r0
	add r0, r1, r3
	add r0, r2, r0
	ldr r2, [r4, #0x20]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x24]
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x10]
	mov r7, r1
	str r0, [sp, #0x30]
	ldr r1, [sp, #0x20]
	mov r0, r6
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x18]
	mov r6, r1
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r3, r0
	mov r0, #2
	mov r4, r1
	ldr r2, [sp, #0x30]
	mov r1, #0
	lsl r0, r0, #0xa
	add r2, r2, r0
	adc r7, r1
	lsl r5, r7, #0x14
	lsr r2, r2, #0xc
	orr r2, r5
	ldr r5, [sp, #0x34]
	add r5, r5, r0
	adc r6, r1
	lsl r6, r6, #0x14
	lsr r5, r5, #0xc
	orr r5, r6
	add r3, r3, r0
	adc r4, r1
	lsl r0, r4, #0x14
	lsr r1, r3, #0xc
	orr r1, r0
	add r0, r5, r1
	add r2, r2, r0
	ldr r0, [sp]
	cmp r0, #0
	beq _021589EE
	ldr r1, [sp, #0x10]
	str r1, [r0]
_021589EE:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _021589F6
	str r2, [r0]
_021589F6:
	add sp, #0x40
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

#include <nitro/codereset.h>