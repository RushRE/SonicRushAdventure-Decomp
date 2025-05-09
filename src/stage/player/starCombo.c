#include <stage/player/starCombo.h>
#include <stage/player/scoreBonus.h>
#include <stage/player/trickConfetti.h>

#include <game/graphics/vramSystem.h>
#include <game/audio/audioSystem.h>
#include <game/math/mtMath.h>
#include <game/system/allocator.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/stage/mapSys.h>
#include <stage/core/hud.h>

// --------------------
// VARIABLES
// --------------------

static Task *trickConfetti;
static void *trickAsset;

static VRAMPixelKey starComboVram[8][2];

NOT_DECOMPILED u32 ScoreBonus__DigitBase[];
// static const u32 ScoreBonus__DigitBase[] = { 1, 10, 100, 1000, 10000 };

// --------------------
// FUNCTIONS
// --------------------

// ==============
// STAR COMBO
// ==============

void StarCombo__SpawnConfetti(void)
{
    static const u8 animList[] = { 0, 5, 6, 7, 8, 9, 10, 11 };

    if (trickAsset == NULL)
    {
        AnimatorSpriteDS animator;

        trickAsset = ObjDataLoad(NULL, "/ac_eff_trick.bac", gameArchiveCommon);

        AnimatorSpriteDS__Init(&animator, trickAsset, 0, 0, ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE,
                               VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        animator.cParam[0].palette = 1;
        animator.cParam[1].palette = 1;
        AnimatorSpriteDS__ProcessAnimationFast(&animator);

        for (s32 i = 0; i < 8; i++)
        {
            starComboVram[i][0] = VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2FromAnim(trickAsset, animList[i]));
            starComboVram[i][1] = VRAMSystem__AllocSpriteVram(TRUE, Sprite__GetSpriteSize2FromAnim(trickAsset, animList[i]));

            AnimatorSpriteDS__Init(&animator, trickAsset, animList[i], 0, ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE,
                                   starComboVram[i][0], PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, starComboVram[i][1], PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                                   SPRITE_PRIORITY_0, SPRITE_ORDER_0);
            AnimatorSpriteDS__ProcessAnimationFast(&animator);
        }

        TrickConfetti__Create();
    }
}

void StarCombo__Destroy(void)
{
    TrickConfetti__Destroy();

    if (trickAsset != NULL)
    {
        for (s32 i = 0; i < 8; i++)
        {
            VRAMSystem__FreeSpriteVram(FALSE, starComboVram[i][0]);
            VRAMSystem__FreeSpriteVram(TRUE, starComboVram[i][1]);
        }

        trickAsset = NULL;
    }
}

void StarCombo__PerformTrick(Player *player)
{
    if (trickAsset == NULL || !CheckIsPlayer1(player) || (player->gimmickFlag & PLAYER_GIMMICK_ALLOW_TRICK_COMBO) == 0)
        return;

    StarCombo *manager = player->starComboManager;
    if (manager == NULL)
    {
        manager = StarCombo__Create(player);
        if (manager == NULL)
            return;

        player->starComboManager = manager;
        manager->player          = player;

        if (player->scoreBonus != NULL && player->scoreBonus->starComboManager == NULL)
            player->scoreBonus->starComboManager = manager;
    }

    if (manager->starCount < STARCOMBO_MAX_VISIBLE_STARS)
        StarCombo__InsertStar(manager, manager->starCount);

    if (manager->starCount < STARCOMBO_MAX_TOTAL_STARS)
    {
        manager->starCount++;
        StarCombo__UpdateCombo(manager);
    }

    if (gmCheckMissionType(MISSION_TYPE_PERFORM_TRICKS))
    {
        // completion requirement is to perform [x] tricks in total
        playerGameStatus.missionStatus.totalStarCount++;
    }
    else if (gmCheckMissionType(MISSION_TYPE_PERFORM_COMBOS))
    {
        // completion requirement is to perform [x] tricks in a row
        playerGameStatus.missionStatus.totalStarCount = manager->starCount;
    }
}

void StarCombo__FinishTrickCombo(Player *player, BOOL performTrick)
{
    if (trickAsset != NULL)
    {
        StarCombo *starCombo = player->starComboManager;
        if (starCombo)
        {
            if (CheckIsPlayer1(player) && (player->gimmickFlag & PLAYER_GIMMICK_ALLOW_TRICK_COMBO) != 0)
            {
                if (performTrick)
                    StarCombo__PerformTrick(player);

                if (starCombo->state != StarCombo__State_ComboUpdate)
                {
                    starCombo->digitOffsetY = 0;
                    starCombo->state        = StarCombo__State_ComboSuccess;
                    starCombo->mode         = STARCOMBO_MODE_RISE1;
                    starCombo->timer        = 4;
                }

                starCombo->flags |= STARCOMBO_FLAG_COMBO_SUCCESS;
                starCombo->displayStarCount = starCombo->starCount;

                if (starCombo->displayStarCount > STARCOMBO_MAX_VISIBLE_STARS)
                    starCombo->displayStarCount = STARCOMBO_MAX_VISIBLE_STARS;

                player->starComboCount   = 0;
                player->starComboManager = NULL;
            }
        }
    }
    else
    {
        return;
    }
}

void StarCombo__FailCombo(Player *player)
{
    if (trickAsset != NULL)
    {
        StarCombo *starCombo = player->starComboManager;
        if (starCombo)
        {
            if (CheckIsPlayer1(player))
                starCombo->flags |= STARCOMBO_FLAG_FORCE_COMBO_FAIL;
        }
    }
    else
    {
        return;
    }
}

NONMATCH_FUNC void StarCombo__InitScoreBonus(Player *player, s32 score)
{
    // https://decomp.me/scratch/LJJxd -> 93.10%
#ifdef NON_MATCHING
    ScoreBonus *scoreBonus;
    s32 d;
    s32 delay;

    if (trickAsset == NULL || !CheckIsPlayer1(player))
        return;

    scoreBonus = player->scoreBonus;
    if (scoreBonus == NULL)
    {
        if (score == 0)
            return;

        scoreBonus = ScoreBonus__Create();
        if (scoreBonus == NULL)
            return;

        player->scoreBonus           = scoreBonus;
        scoreBonus->player           = player;
        scoreBonus->starComboManager = player->starComboManager;
    }
    else
    {
        scoreBonus->starComboManager = player->starComboManager;

        if (score == 0)
        {
            // destroy score bonus NOW.
            scoreBonus->flags |= 1;
            player->scoreBonus     = NULL;
            player->starComboCount = 0;
            return;
        }
    }

    scoreBonus->displayScore = scoreBonus->score;
    scoreBonus->score += score;
    if (scoreBonus->score > PLAYER_MAX_SCORE)
        scoreBonus->score = PLAYER_MAX_SCORE;

    for (d = 0, delay = 8; d < 5; d++)
    {
        scoreBonus->digitDelay[d] = delay;
        delay += 2;
    }

    scoreBonus->comboCancelTimer = 16;
    scoreBonus->positionY        = 0;

    if (scoreBonus->score >= 2000)
        scoreBonus->scale = FLOAT_TO_FX32(1.5);
    else
        scoreBonus->scale = FLOAT_TO_FX32(1.0);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =trickAsset
	mov r5, r0
	ldr r2, [r2, #0]
	mov r4, r1
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrb r1, [r5, #0x5d1]
	cmp r1, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0x6c4]
	cmp r1, #0
	bne _02032A2C
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl ScoreBonus__Create
	movs r1, r0
	ldmeqia sp!, {r3, r4, r5, pc}
	str r1, [r5, #0x6c4]
	str r5, [r1, #4]
	ldr r0, [r5, #0x6c0]
	str r0, [r1, #8]
	b _02032A58
_02032A2C:
	ldr r0, [r5, #0x6c0]
	cmp r4, #0
	str r0, [r1, #8]
	bne _02032A58
	ldr r2, [r1, #0]
	mov r0, #0
	orr r2, r2, #1
	str r2, [r1]
	str r0, [r5, #0x6c4]
	strb r0, [r5, #0x6c8]
	ldmia sp!, {r3, r4, r5, pc}
_02032A58:
	ldr r2, [r1, #0xc]
	ldr r0, =0x0001869F
	str r2, [r1, #0x10]
	ldr r2, [r1, #0xc]
	mov r3, #8
	add r2, r2, r4
	str r2, [r1, #0xc]
	cmp r2, r0
	strhi r0, [r1, #0xc]
	mov r2, #0
_02032A80:
	add r0, r1, r2, lsl #1
	add r2, r2, #1
	strh r3, [r0, #0x18]
	cmp r2, #5
	add r3, r3, #2
	blt _02032A80
	mov r0, #0x10
	strh r0, [r1, #0x22]
	mov r0, #0
	str r0, [r1, #0x24]
	ldr r0, [r1, #0xc]
	cmp r0, #0x7d0
	movhs r0, #0x1800
	strhs r0, [r1, #0x14]
	movlo r0, #0x1000
	strlo r0, [r1, #0x14]
	ldmia sp!, {r3, r4, r5, pc}
// clang-format on
#endif
}

void StarCombo__DisplayConfetti(Player *player)
{
    static const s8 StarCombo__ConfettiAnimIDs[] = { 0, 1, 2, 3, 4, 5, 0, 1, 0, 1, 2, 3, 4, 5, 2, 3 };

    TrickConfettiParticle *particle;
    if (trickConfetti && player->tensionPenalty <= 2)
    {
        TrickConfetti *work = TaskGetWork(trickConfetti, TrickConfetti);

        s32 particleCount = player->starComboCount != 0 ? player->starComboCount + 4 : 8 >> player->tensionPenalty;

        s16 velX = 0x7FFF - FLOAT_TO_FX32(4.0);
        s16 velY = 0x7FFF - FLOAT_TO_FX32(7.0);

        for (s32 i = 0; i < particleCount; i++)
        {
            particle = TrickConfetti__RemoveLastParticle(work);
            if (particle == NULL)
                break;

            particle->position.x = (u16)(mtMathRand() << 8) << 4; // Rand(0, HW_LCD_WIDTH) << 4
            particle->position.y = FLOAT_TO_FX32(HW_LCD_HEIGHT);

            particle->velocity.x = velX - mtMathRandRepeat(0x8000);             // 4.0 - Rand(0.0, 8.0)
            particle->velocity.y = (velY & mtMathRand()) - FLOAT_TO_FX32(7.5); // Rand(0.0, 1.5) - 7.5;

            particle->animID        = StarCombo__ConfettiAnimIDs[mtMathRandRepeat(16)];
            particle->flags = MapSys__GetDispSelect() != GX_DISP_SELECT_SUB_MAIN;
        }
    }
}

void StarCombo__SetStarAnimation(AnimatorSpriteDS *work, u16 anim)
{
    static const u8 animVramMap[] = { 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 0xFF };

    u8 id = animVramMap[anim];

    work->vramPixels[0] = starComboVram[id][0];
    work->vramPixels[1] = starComboVram[id][1];
    AnimatorSpriteDS__SetAnimation(work, anim);
}

StarCombo *StarCombo__Create(Player *player)
{
    u32 flags;
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        flags = ANIMATORSPRITEDS_FLAG_NONE;
    else
        flags = ANIMATORSPRITEDS_FLAG_DISABLE_B;

    Task *task = TaskCreate(StarCombo__Main, StarCombo__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), StarCombo);
    if (task == HeapNull)
        return NULL;

    StarCombo *work = TaskGetWork(task, StarCombo);
    TaskInitWork16(work);

    s32 i;
    AnimatorSpriteDS *aniStar = work->starAnimators;
    for (i = 0; i < STARCOMBO_MAX_VISIBLE_STARS; i++)
    {
        AnimatorSpriteDS__Init(aniStar, trickAsset, STARCOMBO_ANIM_IDLE, flags,
                               ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, PIXEL_MODE_SPRITE,
                               starComboVram[0][0], PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, starComboVram[0][1], PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                               SPRITE_PRIORITY_0, SPRITE_ORDER_5);
        aniStar->cParam[0].palette = 1;
        aniStar->cParam[1].palette = 1;

        aniStar++;
    }

    work->digit2Position.x = FLOAT_TO_FX32(HW_LCD_HEIGHT + 16);
    work->digit2Position.y = FLOAT_TO_FX32(48.0);
    work->digit1Position.x = FLOAT_TO_FX32(HW_LCD_HEIGHT + 16);
    work->digit1Position.y = FLOAT_TO_FX32(48.0);
    work->digitScale       = FLOAT_TO_FX32(1.0);

    return work;
}

void StarCombo__Destructor(Task *task)
{
    StarCombo *work = TaskGetWork(task, StarCombo);
    UNUSED(work);
}

void StarCombo__Main(void)
{
    s32 i;
    StarCombo *work = TaskGetWorkCurrent(StarCombo);

    if ((work->flags & (STARCOMBO_FLAG_COMBO_SUCCESS | STARCOMBO_FLAG_COMBO_FAIL)) == 0
        && (work->player->starComboCount == 0 || (work->flags & STARCOMBO_FLAG_FORCE_COMBO_FAIL) != 0))
    {
        work->flags |= STARCOMBO_FLAG_COMBO_FAIL;
        work->player->starComboManager = NULL;

        for (i = 0; i < STARCOMBO_MAX_VISIBLE_STARS; i++)
        {
            if (work->starStates[i] != NULL)
            {
                work->starStates[i]  = StarCombo__StateStar_ComboFailDelay;
                work->stars[i].timer = mtMathRandRepeat(8);
                StarCombo__SetStarAnimation(&work->starAnimators[i], STARCOMBO_ANIM_IDLE);
                work->starAnimators[i].work.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;
            }
        }
    }

    for (i = 0; i < STARCOMBO_MAX_VISIBLE_STARS; i++)
    {
        if (work->starStates[i])
            work->starStates[i](work, i);
    }

    if (work->state)
        work->state(work);

    if ((work->flags & STARCOMBO_FLAG_DESTROYED) != 0)
    {
        DestroyCurrentTask();
    }
    else
    {
        // Draw stars
        AnimatorSpriteDS *starAni = work->starAnimators;
        StarComboStar *star       = work->stars;
        for (i = 0; i < STARCOMBO_MAX_VISIBLE_STARS; i++, starAni++, star++)
        {
            if ((work->flags & (STARCOMBO_FLAG_STAR_VISIBLE_1 << i)) == 0)
                continue;

            starAni->position[0].x = FX32_TO_WHOLE(star->position.x);
            starAni->position[0].y = FX32_TO_WHOLE(star->position.y);

            if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) == 0)
            {
                starAni->position[1].x = starAni->position[0].x;
                starAni->position[1].y = starAni->position[0].y - (HW_LCD_HEIGHT + 80);
            }
            else
            {
                starAni->position[1].x = HW_LCD_WIDTH + 32;
                starAni->position[1].y = HW_LCD_HEIGHT + 32;
            }

            AnimatorSpriteDS__ProcessAnimation(starAni, NULL, NULL);
            AnimatorSpriteDS__DrawFrame(starAni);
        }

        if ((work->flags & STARCOMBO_FLAG_DISPLAY_STAR_COUNT) != 0)
        {
            // Draw the first digit
            if (TRUE)
            {
                AnimatorSpriteDS *aniDigit1 = GetHUDTimeNumAnimator(FX_ModS32(work->starCount, 10), FALSE);
                aniDigit1->flags    = ANIMATORSPRITEDS_FLAG_DISABLE_B;
                aniDigit1->position[0].x    = FX32_TO_WHOLE(work->digit1Position.x + work->digitROffsetX);
                aniDigit1->position[0].y    = FX32_TO_WHOLE(work->digit1Position.y + work->digitOffsetY);

                if (work->starCount >= 20)
                {
                    aniDigit1->position[0].x += 5;
                }
                else if (work->starCount >= 10)
                {
                    aniDigit1->position[0].x += 3;
                }

                if (work->digitScale == FX_ONE)
                {
                    aniDigit1->work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
                    AnimatorSpriteDS__DrawFrame(aniDigit1);
                }
                else
                {
                    aniDigit1->work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
                    AnimatorSpriteDS__DrawFrameRotoZoom(aniDigit1, work->digitScale, work->digitScale, FLOAT_DEG_TO_IDX(0.0));
                }
            }

            // Draw a second digit if needed
            if (work->starCount >= 10)
            {
                AnimatorSpriteDS *aniDigit2 = GetHUDTimeNumAnimator(FX_DivS32(work->starCount, 10), FALSE);
                aniDigit2->position[0].x    = FX32_TO_WHOLE(work->digit2Position.x + work->digitLOffsetX);
                aniDigit2->position[0].y    = FX32_TO_WHOLE(work->digit2Position.y + work->digitOffsetY);

                if (work->starCount >= 20)
                {
                    aniDigit2->position[0].x -= 5;
                }
                else if (work->starCount >= 10)
                {
                    aniDigit2->position[0].x -= 3;
                }

                if (work->digitScale == FX_ONE)
                {
                    aniDigit2->work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
                    AnimatorSpriteDS__DrawFrame(aniDigit2);
                }
                else
                {
                    aniDigit2->work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
                    AnimatorSpriteDS__DrawFrameRotoZoom(aniDigit2, work->digitScale, work->digitScale, 0);
                }
            }
        }
    }
}

void StarCombo__UpdateCombo(StarCombo *work)
{
    work->state = StarCombo__State_ComboUpdate;
    work->mode  = STARCOMBO_MODE_RISE1;
    work->timer = 2;
    work->flags &= ~STARCOMBO_FLAG_DISPLAY_STAR_COUNT;
}

void StarCombo__State_ComboUpdate(StarCombo *work)
{
    work->timer--;

    if (work->timer <= 0)
    {
        switch (work->mode)
        {
            case STARCOMBO_MODE_RISE1:
                work->mode++;
                work->flags |= STARCOMBO_FLAG_DISPLAY_STAR_COUNT;
                work->digitOffsetY = FLOAT_TO_FX32(3.0);
                work->timer        = 1;
                break;

            case STARCOMBO_MODE_RISE2:
                work->mode++;
                work->digitOffsetY = FLOAT_TO_FX32(2.0);
                work->timer        = 1;
                break;

            case STARCOMBO_MODE_RISE3:
                work->mode++;
                work->digitOffsetY = FLOAT_TO_FX32(1.0);
                work->timer        = 2;
                break;

            case STARCOMBO_MODE_ADVANCE_STATE:
                work->digitOffsetY = 0;
                if ((work->flags & STARCOMBO_FLAG_COMBO_SUCCESS) != 0)
                {
                    work->state = StarCombo__State_ComboSuccess;
                    work->mode  = STARCOMBO_MODE_RISE1;
                    work->timer = 4;
                }
                else
                {
                    work->state = NULL;
                }
                break;

            default:
                break;
        }
    }
}

void StarCombo__State_ComboSuccess(StarCombo *work)
{
    work->timer--;

    switch (work->mode)
    {
        case 0: // scale in
            work->digitScale += FLOAT_TO_FX32(0.25);
            if (work->starCount >= 10)
            {
                work->digitLOffsetX -= FLOAT_TO_FX32(1.5);
                work->digitROffsetX += FLOAT_TO_FX32(1.5);
            }

            if (work->timer <= 0)
            {
                work->mode++;
                work->digitScale = FLOAT_TO_FX32(2.0);
                work->timer      = 70;
            }
            break;

        case 1: // wait (show big combo number)
            if (work->timer <= 0)
            {
                work->mode++; // STARCOMBO_MODE_RISE3
                work->timer = 4;
            }
            break;

        case 2: // scale out
            work->digitScale -= FLOAT_TO_FX32(0.5);
            if (work->timer <= 0)
            {
                work->flags &= ~STARCOMBO_FLAG_DISPLAY_STAR_COUNT;
                work->digitScale = FX_ONE;
                work->state      = NULL;
            }
            break;
    }
}

void StarCombo__State_ComboFailWait(StarCombo *work)
{
    work->timer--;
    if (work->timer == 0)
        work->state = StarCombo__State_ComboFailed;
}

void StarCombo__State_ComboFailed(StarCombo *work)
{
    work->flags ^= STARCOMBO_FLAG_DISPLAY_STAR_COUNT;

    work->digitVelocity += FLOAT_TO_FX32(0.5);
    if (work->digitVelocity > FLOAT_TO_FX32(8.0))
        work->digitVelocity = FLOAT_TO_FX32(8.0);

    work->digit2Position.y += work->digitVelocity;
    if (work->digit2Position.y >= FLOAT_TO_FX32(HW_LCD_HEIGHT + 16))
    {
        work->state = NULL;
        work->flags |= STARCOMBO_FLAG_DESTROYED;
    }

    work->digit1Position.y = work->digit2Position.y;
}

void StarCombo__InsertStar(StarCombo *work, s32 id)
{
    const fx32 START_X = -FLOAT_TO_FX32(16.0);
    const fx32 DEST_X  = FLOAT_TO_FX32(HW_LCD_HEIGHT + 16);
    const fx32 DEST_Y  = FLOAT_TO_FX32(48.0);

    // you could remove the extra -(360.0 / STARCOMBO_MAX_VISIBLE_STARS) if you did (id - 1), but thats not what they did so that's not how it is here!
    u16 angle = (s32)(u16)(FLOAT_DEG_TO_IDX(270.0) - id * FLOAT_DEG_TO_IDX(360.0 / STARCOMBO_MAX_VISIBLE_STARS) - FLOAT_DEG_TO_IDX(360.0 / STARCOMBO_MAX_VISIBLE_STARS));

    work->starStates[id] = StarCombo__StateStar_EnterStar;
    StarComboStar *star  = &work->stars[id];

    star->startPosition.x = START_X;
    star->position.x      = START_X;
    star->position.y = star->startPosition.y = FX32_FROM_WHOLE((mtMathRandRepeat(32) + 1) << 4); // (Rand(0, 32) + 1) << 4

    star->targetPosition.x = (24 * CosFX(angle)) + DEST_X;
    star->targetPosition.y = (24 * SinFX(angle)) + DEST_Y;

    work->flags |= STARCOMBO_FLAG_STAR_VISIBLE_1 << id;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STAR_INSERT);
}

void StarCombo__StateStar_EnterStar(StarCombo *work, s32 id)
{
    StarComboStar *star = &work->stars[id];

    // Go from A->B in 16 frames
    star->percent += FLOAT_TO_FX32(1.0 / 16.0);
    if (star->percent < FLOAT_TO_FX32(1.0))
    {
        star->position.x = mtLerp(star->percent, star->startPosition.x, star->targetPosition.x);
        star->position.y = mtLerp(star->percent, star->startPosition.y, star->targetPosition.y);
    }
    else
    {
        work->starStates[id] = StarCombo__StateStar_ComboActiveSpin;
        star->position.x     = star->targetPosition.x;
        star->position.y     = star->targetPosition.y;
        StarCombo__SetStarAnimation(&work->starAnimators[id], STARCOMBO_ANIM_ACTIVE_SPIN);
        work->starAnimators[id].work.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;
    }
}

void StarCombo__StateStar_ComboActiveSpin(StarCombo *work, s32 id)
{
    s32 i;

    if (work->starAnimators[id].work.animID == STARCOMBO_ANIM_ACTIVE_SPIN)
    {
        if ((work->starAnimators[id].work.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
        {
            if (id == (STARCOMBO_MAX_VISIBLE_STARS - 1))
            {
                for (i = 0; i < STARCOMBO_MAX_VISIBLE_STARS; i++)
                {
                    StarCombo__SetStarAnimation(&work->starAnimators[i], STARCOMBO_ANIM_SPIN_ALLSTARS);
                    work->starAnimators[i].work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
                }
            }
            else
            {
                StarCombo__SetStarAnimation(&work->starAnimators[id], STARCOMBO_ANIM_SPIN_AVAILSTAR);
                work->starAnimators[id].work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
            }
            work->starAnimators[id].work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
        }
    }
    else if ((work->flags & STARCOMBO_FLAG_COMBO_SUCCESS) != 0 && id == work->displayStarCount - 1)
    {
        StarComboStar *star = work->stars;

        for (i = 0; i < STARCOMBO_MAX_VISIBLE_STARS; i++, star++)
        {
            if (work->starStates[i] == NULL)
                continue;

            work->starStates[i] = StarCombo__StateStar_ComboSuccessSpin;
            StarCombo__SetStarAnimation(&work->starAnimators[i], STARCOMBO_ANIM_SUCCESS_SPIN);
            work->starAnimators[i].work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;

            // ~210 degrees (decimal is added to fix some rounding issues)
            star->angle = FLOAT_DEG_TO_IDX(210.00366) - (FLOAT_DEG_TO_IDX(360.0 / STARCOMBO_MAX_VISIBLE_STARS) * i);
        }

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STAR_TURN);
    }
}

void StarCombo__StateStar_ComboSuccessSpin(StarCombo *work, s32 id)
{
    StarComboStar *star = &work->stars[id];

    u32 changed = star->angle < FLOAT_DEG_TO_IDX(90.0);

    star->spinSpeed += FLOAT_DEG_TO_IDX(0.703125);
    if (star->spinSpeed > FLOAT_DEG_TO_IDX(22.5))
        star->spinSpeed = FLOAT_DEG_TO_IDX(22.5);

    star->angle += star->spinSpeed;
    star->angleDistance += star->spinSpeed;

    // once the star passed 90 degrees and it's spun for over ~240 degrees, fling it!
    if ((star->angleDistance >= FLOAT_DEG_TO_IDX(239.8974609375) && star->angle >= FLOAT_DEG_TO_IDX(90.0)) && changed)
    {
        work->starStates[id] = StarCombo__StateStar_EnterTensionGauge;
        star->position.x = star->startPosition.x = 24 * CosFX(FLOAT_DEG_TO_IDX(90.0)) + FLOAT_TO_FX32(HW_LCD_HEIGHT + 16);
        star->position.y = star->startPosition.y = 24 * SinFX(FLOAT_DEG_TO_IDX(90.0)) + FLOAT_TO_FX32(48.0);
        star->targetPosition.x                   = FLOAT_TO_FX32(16.0);
        star->targetPosition.y                   = FLOAT_TO_FX32(40.0);
        star->percent                            = FLOAT_TO_FX32(0.0);
    }
    else
    {
        star->position.x = 24 * CosFX(star->angle) + FLOAT_TO_FX32(HW_LCD_HEIGHT + 16);
        star->position.y = 24 * SinFX(star->angle) + FLOAT_TO_FX32(48.0);
    }
}

void StarCombo__StateStar_EnterTensionGauge(StarCombo *work, s32 id)
{
    StarComboStar *star = &work->stars[id];

    // Go from A->B in 16 frames
    star->percent += FLOAT_TO_FX32(1.0 / 16.0);
    if (star->percent < FLOAT_TO_FX32(1.0))
    {
        star->position.x = mtLerp(star->percent, star->startPosition.x, star->targetPosition.x);
        star->position.y = mtLerp(star->percent, star->startPosition.y, star->targetPosition.y);
    }
    else
    {
        work->starStates[id] = StarCombo__StateStar_ExitStar;
        StarCombo__SetStarAnimation(&work->starAnimators[id], STARCOMBO_ANIM_EXITSTAR);
        work->starAnimators[id].work.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;
        star->position.x = star->targetPosition.x + FX32_FROM_WHOLE(mtMathRandRepeat(16) - 7); // Rand(-8, 8)
        star->position.y = star->targetPosition.y + FX32_FROM_WHOLE(mtMathRandRepeat(16) - 7); // Rand(-8, 8)
        Player__GiveTension(work->player, STARCOMBO_STAR_AWARD_TENSION);
    }
}

void StarCombo__StateStar_ExitStar(StarCombo *work, s32 id)
{
    StarComboStar *star = &work->stars[id];

    if ((work->starAnimators[id].work.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
    {
        work->starStates[id] = NULL;
        work->flags &= ~(STARCOMBO_FLAG_STAR_VISIBLE_1 << id);

        if (id == work->displayStarCount - 1)
            work->flags |= STARCOMBO_FLAG_DESTROYED;
    }
}

void StarCombo__StateStar_ComboFailDelay(StarCombo *work, s32 id)
{
    StarComboStar *star = &work->stars[id];

    star->timer--;
    if (star->timer <= 0)
    {
        u32 visibleStarCount = work->starCount;
        work->starStates[id] = StarCombo__StateStar_ComboFailFall;

        if (visibleStarCount >= STARCOMBO_MAX_VISIBLE_STARS)
            visibleStarCount = STARCOMBO_MAX_VISIBLE_STARS;

        work->failedStarCount++;
        if (work->failedStarCount >= (u32)(u16)visibleStarCount)
        {
            work->state = StarCombo__State_ComboFailWait;
            work->timer = 4;
        }
    }
}

void StarCombo__StateStar_ComboFailFall(StarCombo *work, s32 id)
{
    StarComboStar *star = &work->stars[id];

    // flicker
    work->flags ^= STARCOMBO_FLAG_STAR_VISIBLE_1 << id;

    // fall
    star->fallVelocity += FLOAT_TO_FX32(0.5);
    if (star->fallVelocity > FLOAT_TO_FX32(8.0))
        star->fallVelocity = FLOAT_TO_FX32(8.0);

    star->position.y += star->fallVelocity;
    if (star->position.y >= FLOAT_TO_FX32(HW_LCD_HEIGHT + 16))
        work->starStates[id] = NULL;
}

// ==============
// SCORE BONUS
// ==============

ScoreBonus *ScoreBonus__Create(void)
{
    Task *task = TaskCreate(ScoreBonus__Main, ScoreBonus__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), ScoreBonus);
    if (task == HeapNull)
        return NULL;

    ScoreBonus *work = TaskGetWork(task, ScoreBonus);
    TaskInitWork16(work);
    return work;
}

NONMATCH_FUNC void ScoreBonus__Main(void)
{
    // https://decomp.me/scratch/Of0D8 -> 94.35%
#ifdef NON_MATCHING
    s32 i;
    BOOL isActive;

    ScoreBonus *work = TaskGetWorkCurrent(ScoreBonus);
    isActive         = TRUE;

    if ((work->flags & 1) != 0)
    {
        Task__DestroyFirst();
        return;
    }

    if (work->displayScore < work->score)
    {
        if (((work->score - work->displayScore) >> 2) != 0)
            work->displayScore += ((work->score - work->displayScore) >> 2);
        else
            work->displayScore = work->score;
    }

    for (i = 0; i < SCOREBONUS_DIGIT_COUNT; i++)
    {
        if (work->digitDelay[i] == 0)
            continue;

        isActive = FALSE;
        work->digitDelay[i]--;
    }

    if (isActive)
    {
        if (work->scale != FLOAT_TO_FX32(1.0))
        {
            work->scale -= FLOAT_TO_FX32(0.0625);
            if (work->scale < FLOAT_TO_FX32(1.0))
                work->scale = FLOAT_TO_FX32(1.0);
        }

        if (work->score == work->displayScore)
        {
            if (work->comboCancelTimer != 0)
            {
                work->comboCancelTimer--;
            }
            else
            {
                work->positionY -= FLOAT_TO_FX32(1.5);
                if (work->positionY <= -FLOAT_TO_FX32(64.0))
                {
                    Player *player = work->player;
                    if (work->starComboManager == player->starComboManager)
                        player->starComboCount = 0;

                    Task__DestroyFirst();
                    return;
                }
            }
        }
    }

    if ((gameState.gameMode == GAMEMODE_VS_BATTLE || gameState.gameMode == GAMEMODE_MISSION) || (work->positionY <= -FLOAT_TO_FX32(22.0) && (playerGameStatus.stageTimer & 2) != 0))
        return;

    BOOL highScore        = FALSE;
    s32 displayScoreValue = work->displayScore;
    u32 digitBase[]       = { 1, 10, 100, 1000, 10000 };
    u32 flags             = ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK;

    VecFx32 *scalePtr = NULL;
    VecFx32 position;
    VecFx32 scale;
    if (work->scale != FX_ONE)
    {
        scalePtr = &scale;
        scale.x = scale.y = scale.z = work->scale;

        flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    if (work->score >= 2000 && (playerGameStatus.stageTimer & 2) != 0)
    {
        highScore = TRUE;
    }

    s32 digitCount = 0;
    u16 digits[SCOREBONUS_DIGIT_COUNT];
    for (s32 d = (SCOREBONUS_DIGIT_COUNT - 1); d > 0; d--)
    {
        digits[d] = FX_DivS32(displayScoreValue, digitBase[d]);
        displayScoreValue -= digits[d] * digitBase[d];
        if (digits[d] && digitCount < d)
            digitCount = d;
    }
    digits[0] = displayScoreValue;

    Player *player = work->player;
    Vec2Fx32 playerPos;
    playerPos.x = player->objWork.position.x;
    playerPos.y = player->objWork.position.y;

    StageDisplayFlags displayFlag = DISPLAY_FLAG_PAUSED | DISPLAY_FLAG_NO_ANIMATE_CB;

    while (digitCount >= 0)
    {
        s32 offsetX = -9 * digitCount + 22;

        if (work->digitDelay[digitCount] <= 8)
        {

            AnimatorSpriteDS *animator = GetHUDLifeNumAnimator(digits[digitCount], highScore);
            animator->flags    = 0;
            animator->work.flags |= flags;
            position.x = (FX32_FROM_WHOLE(offsetX + work->digitDelay[digitCount])) + playerPos.x;
            position.y = work->positionY + (FX32_FROM_WHOLE(-28 - 2 * work->digitDelay[digitCount])) + playerPos.y;
            StageTask__Draw2DEx(animator, &position, NULL, scalePtr, &displayFlag, NULL, NULL);
        }

        offsetX += 9;
        digitCount--;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, [r5, #0]
	mov r4, #1
	tst r0, #1
	beq _02033B94
	bl DestroyCurrentTask
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02033B94:
	ldr r2, [r5, #0xc]
	ldr r1, [r5, #0x10]
	cmp r1, r2
	bhs _02033BB8
	sub r0, r2, r1
	movs r0, r0, lsr #2
	addne r0, r1, r0
	strne r0, [r5, #0x10]
	streq r2, [r5, #0x10]
_02033BB8:
	mov r3, #0
	mov r0, r3
_02033BC0:
	add r2, r5, r3, lsl #1
	ldrsh r1, [r2, #0x18]
	add r3, r3, #1
	cmp r1, #0
	subne r1, r1, #1
	movne r4, r0
	strneh r1, [r2, #0x18]
	cmp r3, #5
	blt _02033BC0
	cmp r4, #0
	beq _02033C70
	ldr r0, [r5, #0x14]
	cmp r0, #0x1000
	beq _02033C0C
	sub r0, r0, #0x100
	str r0, [r5, #0x14]
	cmp r0, #0x1000
	movlt r0, #0x1000
	strlt r0, [r5, #0x14]
_02033C0C:
	ldr r1, [r5, #0xc]
	ldr r0, [r5, #0x10]
	cmp r1, r0
	bne _02033C70
	ldrsh r0, [r5, #0x22]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r5, #0x22]
	bne _02033C70
	ldr r1, [r5, #0x24]
	mov r0, #0x40000
	sub r1, r1, #0x1800
	rsb r0, r0, #0
	str r1, [r5, #0x24]
	cmp r1, r0
	bgt _02033C70
	ldr r2, [r5, #4]
	ldr r1, [r5, #8]
	ldr r0, [r2, #0x6c0]
	cmp r1, r0
	moveq r0, #0
	streqb r0, [r2, #0x6c8]
	bl DestroyCurrentTask
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02033C70:
	ldr r0, =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #1
	cmpne r0, #3
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x16000
	ldr r1, [r5, #0x24]
	rsb r0, r0, #0
	cmp r1, r0
	bgt _02033CB0
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #2
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02033CB0:
	mov r0, #0
	str r0, [sp, #0x10]
	ldr r4, =ScoreBonus__DigitBase
	ldr r10, [r5, #0x10]
	ldmia r4!, {r0, r1, r2, r3}
	add r6, sp, #0x18
	stmia r6!, {r0, r1, r2, r3}
	ldr r4, [r4, #0]
	mov r8, #0x800
	str r4, [r6]
	ldr r1, [r5, #0x14]
	ldr r0, [sp, #0x10]
	cmp r1, #0x1000
	str r0, [sp, #0xc]
	beq _02033D04
	add r0, sp, #0x2c
	str r0, [sp, #0xc]
	str r1, [sp, #0x34]
	str r1, [sp, #0x30]
	str r1, [sp, #0x2c]
	orr r8, r8, #0x200
_02033D04:
	ldr r0, [r5, #0xc]
	cmp r0, #0x7d0
	blo _02033D24
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #2
	movne r0, #1
	strne r0, [sp, #0x10]
_02033D24:
	mov r9, #0
	mov r7, #4
	add r11, sp, #0x18
	add r4, sp, #0x44
_02033D34:
	ldr r6, [r11, r7, lsl #2]
	mov r0, r10
	mov r1, r6
	bl FX_DivS32
	mov r1, r7, lsl #1
	strh r0, [r4, r1]
	ldrh r1, [r4, r1]
	mul r0, r1, r6
	cmp r1, #0
	sub r10, r10, r0
	beq _02033D68
	cmp r9, r7
	movlt r9, r7
_02033D68:
	sub r7, r7, #1
	cmp r7, #0
	bgt _02033D34
	ldr r1, [r5, #4]
	ldr r0, =0x00001010
	ldr r6, [r1, #0x44]
	ldr r7, [r1, #0x48]
	strh r10, [sp, #0x44]
	str r0, [sp, #0x14]
	cmp r9, #0
	addlt sp, sp, #0x50
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r0, #8
	mul r1, r9, r0
	add r10, r1, #0x16
	sub r11, r0, #0x13
	mov r4, #0
_02033DAC:
	add r0, r5, r9, lsl #1
	ldrsh r0, [r0, #0x18]
	mov r1, r9, lsl #1
	cmp r0, #8
	bgt _02033E2C
	add r0, sp, #0x44
	ldrh r0, [r0, r1]
	ldr r1, [sp, #0x10]
	bl GetHUDLifeNumAnimator
	str r4, [r0, #0x64]
	ldr r1, [r0, #0x3c]
	add ip, r5, r9, lsl #1
	orr r1, r1, r8
	str r1, [r0, #0x3c]
	ldrsh r3, [ip, #0x18]
	add r1, sp, #0x38
	mov r2, r4
	add r3, r10, r3
	add r3, r6, r3, lsl #12
	str r3, [sp, #0x38]
	ldrsh lr, [ip, #0x18]
	ldr ip, [r5, #0x24]
	ldr r3, [sp, #0xc]
	sub lr, r11, lr, lsl #1
	add lr, r7, lr, lsl #12
	add ip, ip, lr
	str ip, [sp, #0x3c]
	add ip, sp, #0x14
	str ip, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	bl StageTask__Draw2DEx
_02033E2C:
	add r10, r10, #9
	subs r9, r9, #1
	bpl _02033DAC
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

void ScoreBonus__Destructor(Task *task)
{
    ScoreBonus *work = TaskGetWork(task, ScoreBonus);

    Player *player = work->player;
    if (player->scoreBonus == work)
        player->scoreBonus = NULL;
}

// ==============
// TRICK CONFETTI
// ==============

void TrickConfetti__Create(void)
{
    static const u8 paletteRows[] = { 0, 0, 0, 1, 1, 1 };

    s32 i;

    Task *task = TaskCreate(TrickConfetti__Main, 0, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), TrickConfetti);
    if (task != HeapNull)
    {
        trickConfetti = task;

        TrickConfetti *work = TaskGetWork(task, TrickConfetti);
        TaskInitWork16(work);

        for (i = 0; i < TRICKCONFETTI_PARTICLE_LIST_SIZE; i++)
        {
            work->activeParticleList[i] = &work->particleStorage[i];
        }

        work->particleCount = TRICKCONFETTI_PARTICLE_LIST_SIZE;
        for (i = 0; i < TRICKCONFETTI_PARTICLE_TYPE_COUNT; i++)
        {
            AnimatorSpriteDS__Init(&work->animators[i], trickAsset, (u16)(i + 6), 0,
                                   ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK,
                                   PIXEL_MODE_SPRITE, starComboVram[i + 2][0], PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, starComboVram[i + 2][1], PALETTE_MODE_SPRITE,
                                   VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_5);

            work->animators[i].work.cParam.palette      = paletteRows[i];
            work->animators[i].cParam[0].palette = work->animators[i].cParam[1].palette = work->animators[i].work.cParam.palette;
        }
    }
}

void TrickConfetti__Destroy(void)
{
    if (trickConfetti != NULL)
    {
        DestroyTask(trickConfetti);
        trickConfetti = NULL;
    }
}

void TrickConfetti__Main(void)
{
    s32 i;
    s32 screenFlags_2;
    s32 screenFlags_1;
    s32 screenID_2;
    s32 screenID_1;
    TrickConfettiParticle *particle;

    TrickConfetti *work = TaskGetWorkCurrent(TrickConfetti);

    particle = work->particleListStart;
    if (particle == NULL)
        return;

    while (particle)
    {
        TrickConfettiParticle *next = particle->next;

        // apply gravity
        particle->velocity.y += FLOAT_TO_FX32(0.1875);

        // apply a bit more gravity when falling downwards
        if (particle->velocity.y > 0)
            particle->velocity.y += FLOAT_TO_FX32(0.09375);

        if (mtMathRandRepeat(32) == 0)
            particle->velocity.x = (s16)-particle->velocity.x;

        if (mtMathRandRepeat(32) == 0)
            particle->velocity.y = 0;

        particle->position.x += particle->velocity.x;
        particle->position.y += particle->velocity.y;

        if (particle->position.y > FLOAT_TO_FX32(HW_LCD_HEIGHT + 4.0))
            TrickConfetti__AddParticle(work, particle);

        particle = next;
    }

    for (i = 0; i < TRICKCONFETTI_PARTICLE_TYPE_COUNT; i++)
    {
        work->animators[i].flags &= ~(ANIMATORSPRITEDS_FLAG_DISABLE_A | ANIMATORSPRITEDS_FLAG_DISABLE_B);
        AnimatorSpriteDS__ProcessAnimationFast(&work->animators[i]);
    }

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) != 0)
    {
        screenFlags_2 = ANIMATORSPRITEDS_FLAG_DISABLE_A;
        screenID_2    = 1;

        screenFlags_1 = ANIMATORSPRITEDS_FLAG_DISABLE_B;
        screenID_1    = 0;
    }
    else
    {
        screenFlags_1 = ANIMATORSPRITEDS_FLAG_DISABLE_A;
        screenID_1    = 1;

        screenFlags_2 = ANIMATORSPRITEDS_FLAG_DISABLE_B;
        screenID_2    = 0;
    }

    for (particle = work->particleListStart; particle != NULL; particle = particle->next)
    {
        AnimatorSpriteDS *animator = &work->animators[particle->animID];

        animator->flags &= ~(ANIMATORSPRITEDS_FLAG_DISABLE_A | ANIMATORSPRITEDS_FLAG_DISABLE_B);

        s32 screen;
        if ((particle->flags & ANIMATORSPRITEDS_FLAG_DISABLE_A) != 0)
        {
            animator->flags |= screenFlags_1;
            screen = screenID_1;
        }
        else
        {
            animator->flags |= screenFlags_2;
            screen = screenID_2;
        }

        animator->position[screen].x = FX32_TO_WHOLE(particle->position.x);
        animator->position[screen].y = FX32_TO_WHOLE(particle->position.y);
        AnimatorSpriteDS__DrawFrame(animator);
    }
}

TrickConfettiParticle *TrickConfetti__RemoveLastParticle(TrickConfetti *work)
{
    if (work->particleCount == 0)
        return NULL;

    work->particleCount--;
    TrickConfettiParticle *activeParticle = work->activeParticleList[work->particleCount];

    if (work->particleListEnd)
    {
        work->particleListEnd->next = activeParticle;
        activeParticle->prev        = work->particleListEnd;
        activeParticle->next        = NULL;
        work->particleListEnd       = activeParticle;
    }
    else
    {
        work->particleListEnd   = activeParticle;
        work->particleListStart = activeParticle;
        activeParticle->prev = activeParticle->next = NULL;
    }

    return activeParticle;
}

void TrickConfetti__AddParticle(TrickConfetti *work, TrickConfettiParticle *particle)
{
    if (work->particleCount != TRICKCONFETTI_PARTICLE_LIST_SIZE)
    {
        if (particle->prev == NULL)
            work->particleListStart = particle->next;
        else
            particle->prev->next = particle->next;

        if (particle->next == NULL)
            work->particleListEnd = particle->prev;
        else
            particle->next->prev = particle->prev;

        work->activeParticleList[work->particleCount] = particle;
        work->particleCount++;
    }
}