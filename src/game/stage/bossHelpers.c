#include <game/stage/bossHelpers.h>
#include <game/graphics/drawState.h>
#include <game/stage/stageAssets.h>
#include <game/input/padInput.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BossHelpersRenderCallbackConfig_
{
    void *resMdl;
    u16 nodeDesc;
    u16 mtxStore;
    void (*func)(NNSG3dRS *context, void *userData);
    void *userData;
} BossHelpersRenderCallbackConfig;

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED BossHelpersRenderCallbackConfig BossHelpers__RenderCallbackList[16];
NOT_DECOMPILED u16 BossHelpers__RenderCallbackCount;

// --------------------
// FUNCTIONS
// --------------------

void BossHelpers__Unknown2038AEC__Init(Unknown2038AEC *work, void *ptr, s32 id)
{
    MI_CpuClear16(work, sizeof(*work));

    work->startPtr = ptr;
    work->curPtr   = ptr;
    work->id       = id;
    work->timer    = *(u16 *)ptr;
}

void BossHelpers__Unknown2038AEC__Func_2038B24(Unknown2038AEC *work)
{
    // Nothing.
}

NONMATCH_FUNC u32 BossHelpers__Unknown2038AEC__Func_2038B28(Unknown2038AEC *work)
{
    // https://decomp.me/scratch/8Ejv4 -> 56.90%
#ifdef NON_MATCHING
    if (work->timer == 0xFFFF)
        return 2;

    if (work->timer != 0)
    {
        work->timer--;
        return 0;
    }

    work->prevPtr = work->curPtr;
    work->curPtr  = &((u8 *)work->curPtr)[work->id];
    work->timer   = *(u16 *)work->curPtr;
    return 1;
#else
    // clang-format off
	ldrh r2, [r0, #0x10]
	ldr r1, =0x0000FFFF
	cmp r2, r1
	moveq r0, #2
	bxeq lr
	cmp r2, #0
	subne r1, r2, #1
	strneh r1, [r0, #0x10]
	movne r0, #0
	bxne lr
	ldr r1, [r0, #4]
	str r1, [r0, #8]
	ldr r2, [r0, #4]
	ldr r1, [r0, #0xc]
	add r1, r2, r1
	str r1, [r0, #4]
	ldrh r1, [r1, #0]
	strh r1, [r0, #0x10]
	mov r0, #1
	bx lr

// clang-format on
#endif
}

void *BossHelpers__Unknown2038AEC__Func_2038B7C(Unknown2038AEC *work)
{
    return work->prevPtr;
}

void BossHelpers__SetPaletteAnimation(PaletteAnimator *animator, u16 anim, BOOL canLoop)
{
    SetPaletteAnimation(animator, anim);

    if (canLoop)
        animator->userFlags |= ANIMATORBPA_FLAG_CAN_LOOP;
    else
        animator->userFlags &= ~ANIMATORBPA_FLAG_CAN_LOOP;
}

void BossHelpers__SetPaletteAnimations(PaletteAnimator *animators, u32 animatorCount, u16 anim, BOOL canLoop)
{
    for (u16 a = 0; a < animatorCount; a++)
    {
        BossHelpers__SetPaletteAnimation(&animators[a], anim, canLoop);
    }
}

void BossHelpers__SetAnimation(AnimatorMDL *work, B3DAnimationTypes type, NNSG3dResFileHeader *resource, u32 animID, const NNSG3dResTex *texResource, BOOL canLoop)
{
    AnimatorMDL__SetAnimation(work, type, resource, animID, texResource);

    if (canLoop)
        work->animFlags[type] |= ANIMATORMDL_FLAG_CAN_LOOP;
    else
        work->animFlags[type] &= ~ANIMATORMDL_FLAG_CAN_LOOP;

    work->speed[type] = FLOAT_TO_FX32(1.0);
}

BOOL BossHelpers__IsAnimFinished(AnimatorMDL *work, B3DAnimationTypes type)
{
    return work->animFlags[type] & ANIMATORMDL_FLAG_FINISHED;
}

void BossHelpers__ReleaseAnimation(OBS_ACTION3D_NN_WORK *work)
{
    if (work->file[B3D_RESOURCE_MODEL] != NULL)
    {
        ObjDataRelease(work->file[B3D_RESOURCE_MODEL]);
        work->file[B3D_RESOURCE_MODEL] = NULL;
    }

    for (s32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if (work->file[B3D_ANIM_RESOURCE_OFFSET + i] != NULL)
        {
            ObjDataRelease(work->file[B3D_ANIM_RESOURCE_OFFSET + i]);
            work->file[B3D_ANIM_RESOURCE_OFFSET + i] = NULL;
        }
    }
}

s32 BossHelpers__Arena__WrapBounds(fx32 x, fx32 start, fx32 end)
{
    s32 length = end - start;

    while (start > x || x >= end)
    {
        if (start > x)
        {
            x += length;
        }
        else if (end <= x)
        {
            x -= length;
        }
    }

    return x;
}

u16 BossStage_GetCirclePos(fx32 position, fx32 start, fx32 end, fx32 radius, s32 *x, s32 *z)
{
    BossHelpers__Arena__WrapBounds(position, start, end);
    u16 angle = 16 * FX_Div(position - start, end - start);
    BossHelpers__Arena__GetXZPos(angle, radius, x, z);

    return angle;
}

void BossHelpers__Arena__GetXZPos(u16 angle, fx32 radius, fx32 *x, fx32 *z)
{
    *x = MultiplyFX(radius, SinFX((s32)angle));
    *z = MultiplyFX(radius, CosFX((s32)angle));
}

void BossHelpers__Arena__GetPosition(fx32 *position, fx32 start, fx32 end, fx32 radius, fx32 x, fx32 z)
{
    u16 angle = BossHelpers__Arena__ATan2(x, z);
    *position = start + (MultiplyFX(end - start, angle >> 4));
}

u16 BossHelpers__Arena__GetAngle(fx32 position, fx32 start, fx32 end)
{
    fx32 wrappedPos = BossHelpers__Arena__WrapBounds(position, start, end);

    return 16 * FX_Div(wrappedPos - start, end - start);
}

u16 BossHelpers__Arena__ATan2(fx32 y, fx32 x)
{
    return FX_Atan2Idx(y, x);
}

u16 BossHelpers__Arena__GetObjectDrawMtx(StageTask *work, AnimatorMDL *animator, fx32 start, fx32 end, fx32 radius)
{
    work->position.x = BossHelpers__Arena__WrapBounds(work->position.x, start, end);

    u16 angle = BossStage_GetCirclePos(work->position.x, start, end, radius, &animator->work.translation.x, &animator->work.translation.z);

    animator->work.translation.y = -work->position.y;

    u16 angleOffset;
    if ((work->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        angleOffset = -FLOAT_DEG_TO_IDX(90.0);
    else
        angleOffset = FLOAT_DEG_TO_IDX(90.0);

    MTX_RotY33(animator->work.rotation.nnMtx, SinFX((s32)(u16)(angleOffset + angle)), CosFX((s32)(u16)(angleOffset + angle)));

    return angle;
}

u16 BossHelpers__Arena__GetPlayerDrawMtx(Player *player, fx32 start, fx32 end, fx32 radius)
{
    u16 angle = BossHelpers__Arena__GetObjectDrawMtx(&player->objWork, &player->aniPlayerModel.ani, start, end, radius);

    if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
    {
        player->aniTailModel.ani.work.scale        = player->aniPlayerModel.ani.work.scale;
        player->aniTailModel.ani.work.rotation     = player->aniPlayerModel.ani.work.rotation;
        player->aniTailModel.ani.work.translation  = player->aniPlayerModel.ani.work.translation;
        player->aniTailModel.ani.work.translation2 = player->aniPlayerModel.ani.work.translation2;
    }

    return angle;
}

void BossHelpers__Model__InitSystem(void)
{
    BossHelpers__RenderCallbackCount = 0;
}

NONMATCH_FUNC void BossHelpers__Model__Init(void *resMdl, const char *jointName, u16 matrixID, void (*renderCallback)(NNSG3dRS *context, void *userData), void *context)
{
    // https://decomp.me/scratch/WSl5n -> 63.45%
#ifdef NON_MATCHING
    BossHelpersRenderCallbackConfig *callback = &BossHelpers__RenderCallbackList[BossHelpers__RenderCallbackCount++];

    callback->resMdl   = resMdl;
    callback->nodeDesc = BossHelpers__FindJointByName(resMdl, jointName);
    callback->mtxStore = matrixID;
    callback->func     = renderCallback;
    callback->userData = context;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr ip, =BossHelpers__RenderCallbackCount
	ldr r6, =BossHelpers__RenderCallbackList
	ldrh r7, [ip]
	mov r5, r0
	mov r4, r2
	add r2, r7, #1
	strh r2, [ip]
	mov r9, r3
	add r8, r6, r7, lsl #4
	bl BossHelpers__FindJointByName
	str r5, [r6, r7, lsl #4]
	strh r0, [r8, #4]
	strh r4, [r8, #6]
	ldr r0, [sp, #0x20]
	str r9, [r8, #8]
	str r0, [r8, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void BossHelpers__Model__SetMatrixMode(s32 id, FXMatrix43 *mtx)
{
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeRestoreMtx(id);
    NNS_G3dGetCurrentMtx(mtx->nnMtx, NULL);
}

NONMATCH_FUNC void BossHelpers__Model__RenderCallback(NNSG3dRS *rs)
{
    // https://decomp.me/scratch/HvFBX -> 92.89%
#ifdef NON_MATCHING
    u16 c;
    BossHelpersRenderCallbackConfig *callback;

    NNSG3dRenderObj *renderObj;
    renderObj = rs->pRenderObj;

    void *resMdl = renderObj->resMdl;
    for (c = 0; c < BossHelpers__RenderCallbackCount; c++)
    {
        callback = &BossHelpers__RenderCallbackList[c];
        if (callback->resMdl == resMdl)
        {
            if (callback->nodeDesc == NNS_G3dRSGetCurrentNodeDescID(rs))
                break;
        }
    }

    if (c != BossHelpers__RenderCallbackCount)
    {
        if (callback->func != NULL)
            callback->func(rs, callback->userData);

        NNS_G3dGeStoreMtx(callback->mtxStore);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r1, =BossHelpers__RenderCallbackCount
	ldr r2, [r0, #4]
	ldrh r5, [r1, #0]
	ldr lr, [r2, #4]
	ldr r3, =BossHelpers__RenderCallbackList
	cmp r5, #0
	mov ip, #0
	bls _02039064
	mvn r2, #0
_02039024:
	ldr r1, [r3, ip, lsl #4]
	add r4, r3, ip, lsl #4
	cmp r1, lr
	bne _02039050
	ldr r1, [r0, #8]
	tst r1, #0x10
	ldrneb r6, [r0, #0xae]
	ldrh r1, [r4, #4]
	moveq r6, r2
	cmp r1, r6
	beq _02039064
_02039050:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	cmp r5, r1, lsr #16
	mov ip, r1, lsr #0x10
	bhi _02039024
_02039064:
	cmp ip, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r4, #8]
	cmp r2, #0
	beq _02039084
	ldr r1, [r4, #0xc]
	blx r2
_02039084:
	ldrh r3, [r4, #6]
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

void BossHelpers__Collision__HandleColliderSimple(OBS_RECT_WORK *collider, fx32 x, fx32 y, fx32 z)
{
    if (collider->parent != NULL)
    {
        collider->rect.pos.x = FX32_TO_WHOLE(x - collider->parent->position.x);
        collider->rect.pos.y = FX32_TO_WHOLE(y - collider->parent->position.y);
        collider->rect.pos.z = FX32_TO_WHOLE(z - collider->parent->position.z);
    }
    else
    {
        collider->rect.pos.x = FX32_TO_WHOLE(x);
        collider->rect.pos.y = FX32_TO_WHOLE(y);
        collider->rect.pos.z = FX32_TO_WHOLE(z);
    }

    StageTask__HandleCollider(collider->parent, collider);
}

void BossHelpers__Collision__InitArenaCollider(OBS_RECT_WORK *srcCollider, OBS_RECT_WORK *dstCollider, fx32 x, fx32 y, fx32 start, fx32 end, fx32 radius)
{
    BossHelpers__Collision__HandleColliderSimple(srcCollider, x, y, FLOAT_TO_FX32(0.0));

    *dstCollider = *srcCollider;

    if (x < (start + end) >> 1)
        dstCollider->rect.pos.x += FX32_TO_WHOLE(end - start);
    else
        dstCollider->rect.pos.x -= FX32_TO_WHOLE(end - start);

    StageTask__HandleCollider(dstCollider->parent, dstCollider);
}

void BossHelpers__Collision__HandleArenaCollider(OBS_RECT_WORK *srcCollider, OBS_RECT_WORK *dstCollider, VecFx32 *translation, fx32 start, fx32 end, fx32 radius)
{
    fx32 position;

    BossHelpers__Arena__GetPosition(&position, start, end, radius, translation->x, translation->z);
    BossHelpers__Collision__InitArenaCollider(srcCollider, dstCollider, position, -translation->y, start, end, radius);
}

BOOL BossHelpers__Player__IsAlive(Player *player)
{
    switch (player->actionState)
    {
        case PLAYER_ACTION_DEATH_01:
        case PLAYER_ACTION_DEATH_02:
            return FALSE;

        default:
            return TRUE;
    }
}

void BossHelpers__Player__LockControl(Player *player)
{
    player->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ;

    player->inputKeyDown   = PAD_INPUT_NONE_MASK;
    player->inputKeyPress  = PAD_INPUT_NONE_MASK;
    player->inputKeyRepeat = PAD_INPUT_NONE_MASK;
}

void BossHelpers__Player__UnlockControl(Player *player)
{
    player->playerFlag &= ~PLAYER_FLAG_DISABLE_INPUT_READ;
}

u16 BossHelpers__Math__Func_2039264(u16 currentAngle, u16 targetAngle, u16 step)
{
    if (currentAngle != targetAngle)
    {
        s16 distance = targetAngle - currentAngle;

        if (distance > 0)
        {
            if (step < distance)
                currentAngle += step;
            else
                currentAngle = targetAngle;
        }
        else
        {
            if (step < -distance)
                currentAngle -= step;
            else
                currentAngle = targetAngle;
        }
    }

    return currentAngle;
}

s32 BossHelpers__Math__Func_20392BC(s32 position, s32 center, s32 angle, s32 angleStepSmall, s32 angleStepLarge, s32 angleRange, s32 largeStepThreshold)
{
    s32 radius = center - position;

    if (MATH_ABS(radius) < largeStepThreshold)
    {
        if (angle < 0)
        {
            if (angleStepLarge < -angle)
                angle += angleStepLarge;
            else
                angle = 0;
        }
        else if (angle > 0)
        {
            if (angleStepLarge < angle)
                angle -= angleStepLarge;
            else
                angle = 0;
        }
    }
    else
    {
        if (angle >= 0 && radius > 0)
        {
            angle += angleStepSmall;
        }
        else if (angle <= 0 && radius < 0)
        {
            angle -= angleStepSmall;
        }
        else
        {
            if (angle > 0)
                angle -= angleStepLarge;
            else
                angle += angleStepLarge;
        }
    }

    return MTM_MATH_CLIP_2(angle, -angleRange, angleRange);
}

s16 BossHelpers__Math__Func_2039360(s32 curPos, s32 targetPos, s16 angle, s16 angleStepSmall, s16 angleStepLarge, u16 angleRange, u16 largeStepThreshold)
{
    u16 distance        = (s16)targetPos - (s16)curPos;
    u16 distanceWrapped = distance - FLOAT_DEG_TO_IDX(180.0);

    if (MT_MATH_MIN(distance, distanceWrapped) < largeStepThreshold)
    {
        if (angle < FLOAT_DEG_TO_IDX(0.0))
        {
            if (angleStepLarge < -angle)
                angle += angleStepLarge;
            else
                angle = FLOAT_DEG_TO_IDX(0.0);
        }
        else if (angle > FLOAT_DEG_TO_IDX(0.0))
        {
            if (angleStepLarge < angle)
                angle -= angleStepLarge;
            else
                angle = FLOAT_DEG_TO_IDX(0.0);
        }
    }
    else
    {
        if (angle >= FLOAT_DEG_TO_IDX(0.0) && distance < FLOAT_DEG_TO_IDX(180.0))
        {
            angle += angleStepSmall;
        }
        else if (angle <= FLOAT_DEG_TO_IDX(0.0) && distance > FLOAT_DEG_TO_IDX(180.0))
        {
            angle -= angleStepSmall;
        }
        else if (angle > FLOAT_DEG_TO_IDX(0.0) && distance > FLOAT_DEG_TO_IDX(180.0))
        {
            angle -= angleStepLarge;
        }
        else if (angle < FLOAT_DEG_TO_IDX(0.0) && distance < FLOAT_DEG_TO_IDX(180.0))
        {
            angle += angleStepLarge;
        }
    }

    return MTM_MATH_CLIP_2(angle, -angleRange, distanceWrapped = angleRange);
}

void BossHelpers__InitBoss5Blending(GraphicsEngine useEngineB)
{
    RenderCoreGFXControl *gfxControl = &GetSwapBuffer3DWork()->gfxControl[useEngineB];

    gfxControl->blendManager.blendControl.value      = 0x00;
    gfxControl->blendManager.blendControl.plane1_BG0 = TRUE;

    gfxControl->blendManager.blendControl.plane2_BG1 = TRUE;
    gfxControl->blendManager.blendControl.plane2_BG2 = TRUE;
    gfxControl->blendManager.blendControl.plane2_BG3 = TRUE;
    gfxControl->blendManager.blendControl.plane2_OBJ = TRUE;
}

void BossHelpers__InitLights(BossLight *config)
{
    MI_CpuClear16(config, sizeof(*config));

    for (s32 l = 0; l < 3; l++)
    {
        GetDrawStateLight(GetStageDrawState(), &config->modifiedLights[l], (GXLightId)l);
        config->initialLights[l] = config->modifiedLights[l];
    }
}

void BossHelpers__ProcessLights(BossLight *config)
{
    s32 l;

    if (config->brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        for (l = 0; l < 3; l++)
        {
            BrightenColors(&config->modifiedLights[l].color, &config->initialLights[l].color, 1, config->brightness);
        }
    }
    else if (config->brightness < RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        for (l = 0; l < 3; l++)
        {
            DarkenColors(&config->modifiedLights[l].color, &config->initialLights[l].color, 1, -config->brightness);
        }
    }
    else
    {
        for (l = 0; l < 3; l++)
        {
            config->initialLights[l] = config->modifiedLights[l];
        }
    }
}

void BossHelpers__ApplyModifiedLights(BossLight *config)
{
    for (s32 i = 0; i < GX_LIGHTID_3; i++)
    {
        SwapBuffer3D_SetLight((GXLightId)i, &config->modifiedLights[i]);
    }
}

void BossHelpers__RevertModifiedLights(BossLight *config)
{
    for (s32 i = 0; i < GX_LIGHTID_3; i++)
    {
        SwapBuffer3D_SetLight((GXLightId)i, &config->initialLights[i]);
    }
}

u32 BossHelpers__FindJointByName(NNSG3dResMdl *resMdl, const char *jointName)
{
    NNSG3dResName resName;

    MI_CpuFill8(resName.name, 0, sizeof(resName));
    STD_CopyString(resName.name, jointName);
    return NNS_G3dGetResDictIdxByName(&resMdl->nodeInfo.dict, &resName);
}