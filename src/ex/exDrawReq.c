#include <ex/system/exDrawReq.h>
#include <ex/system/exDrawFade.h>
#include <game/graphics/drawState.h>
#include <game/math/unknown2066510.h>
#include <ex/system/exSystem.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/player/exPlayerHelpers.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED exDrawReqTaskLightConfig exDrawFadeTask__lightConfig;

NOT_DECOMPILED exDrawFadeUnknown exDrawFadeTask__cameraConfigB;
NOT_DECOMPILED exDrawFadeUnknown exDrawFadeTask__cameraConfigA;

NOT_DECOMPILED u32 exDrawFadeTask__word_2176444;
NOT_DECOMPILED u32 exDrawFadeTask__word_2176448;
NOT_DECOMPILED u16 exDrawReqTask__word_217644C;
NOT_DECOMPILED u32 exDrawReqTask__unk_2176450;
NOT_DECOMPILED u32 exDrawReqTask__dword_2176454;
NOT_DECOMPILED u32 exDrawReqTask__Value_2176458;
NOT_DECOMPILED u32 exDrawReqTask__dword_217645C;
NOT_DECOMPILED u32 exDrawReqTask__unk_2176460;

NOT_DECOMPILED void *aExdrawfadetask;
NOT_DECOMPILED void *aExdrawreqtask;

// --------------------
// FUNCTION DECLS
// --------------------

NOT_DECOMPILED void _s32_div_f(void);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void exDrawFadeUnknown__Init(exDrawFadeUnknown *work)
{
#ifdef NON_MATCHING
    MI_CpuClear16(work, sizeof(*work));

    work->camera2.config.projFOV           = 0;
    work->camera.config.projFOV            = 0;

    work->camera2.config.projNear          = 0;
    work->camera.config.projNear           = 0;

    work->camera2.config.projFar           = 0;
    work->camera.config.projFar            = 0;

    work->camera2.config.aspectRatio       = 0;
    work->camera.config.aspectRatio        = 0;

    work->camera2.config.projScaleW        = 0;
    work->camera.config.projScaleW         = 0;
    
    work->camera2.config.matProjPosition.x = 0;
    work->camera2.config.matProjPosition.y = 0;
    work->camera2.config.matProjPosition.z = 0;
    work->camera.config.matProjPosition    = work->camera2.config.matProjPosition;

    work->camera2.lookAtTo.x = 0;
    work->camera2.lookAtTo.y = 0;
    work->camera2.lookAtTo.z = 0;
    work->camera.lookAtTo.x  = work->camera2.lookAtTo.x;
    work->camera.lookAtTo.y  = work->camera2.lookAtTo.y;
    work->camera.lookAtTo.z  = work->camera2.lookAtTo.z;

    work->camera2.lookAtFrom.x = 0;
    work->camera2.lookAtFrom.y = 0;
    work->camera2.lookAtFrom.z = 0;
    work->camera.lookAtFrom.x  = work->camera2.lookAtFrom.x;
    work->camera.lookAtFrom.y  = work->camera2.lookAtFrom.y;
    work->camera.lookAtFrom.z  = work->camera2.lookAtFrom.z;

    work->camera2.lookAtUp.x = 0;
    work->camera2.lookAtUp.y = 0;
    work->camera2.lookAtUp.z = 0;
    work->camera.lookAtUp.x  = work->camera2.lookAtUp.x;
    work->camera.lookAtUp.y  = work->camera2.lookAtUp.y;
    work->camera.lookAtUp.z  = work->camera2.lookAtUp.z;

    work->camera2.position.x = 0;
    work->camera2.position.y = 0;
    work->camera2.position.z = 0;
    work->camera.position.x  = work->camera2.position.x;
    work->camera.position.y  = work->camera2.position.y;
    work->camera.position.z  = work->camera2.position.z;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xa4
	bl MIi_CpuClear16
	mov r1, #0
	strh r1, [r4, #0x50]
	strh r1, [r4]
	str r1, [r4, #0x54]
	str r1, [r4, #4]
	str r1, [r4, #0x58]
	str r1, [r4, #8]
	str r1, [r4, #0x5c]
	str r1, [r4, #0xc]
	str r1, [r4, #0x60]
	str r1, [r4, #0x10]
	str r1, [r4, #0x64]
	str r1, [r4, #0x68]
	str r1, [r4, #0x6c]
	ldr r0, [r4, #0x64]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x68]
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x6c]
	str r0, [r4, #0x1c]
	str r1, [r4, #0x70]
	str r1, [r4, #0x74]
	str r1, [r4, #0x78]
	ldr r0, [r4, #0x70]
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x74]
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x78]
	str r0, [r4, #0x28]
	str r1, [r4, #0x7c]
	str r1, [r4, #0x80]
	str r1, [r4, #0x84]
	ldr r0, [r4, #0x7c]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x80]
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x84]
	str r0, [r4, #0x34]
	str r1, [r4, #0x88]
	str r1, [r4, #0x8c]
	str r1, [r4, #0x90]
	ldr r0, [r4, #0x88]
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x8c]
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x90]
	str r0, [r4, #0x40]
	str r1, [r4, #0x94]
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	ldr r0, [r4, #0x94]
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x98]
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x9c]
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void exDrawReqTask__EntryUnknown2__InitLight(exDrawReqTaskLightConfig *work)
{
    MI_CpuClear16(work, sizeof(*work));

    work->light2.dir.x = 0;
    work->light2.dir.y = 0;
    work->light2.dir.z = 0;

    work->light.dir.x = work->light2.dir.x;
    work->light.dir.y = work->light2.dir.y;
    work->light.dir.z = work->light2.dir.z;

    work->light2.color = GX_RGB_888(0xF8, 0xF8, 0xF8);
    work->light.color  = GX_RGB_888(0xF8, 0xF8, 0xF8);
}

NONMATCH_FUNC void exDrawFadeUnknown__Func_21610F0(exDrawFadeUnknown *work)
{
#ifdef NON_MATCHING
    if (work->camera2.config.projFOV < 0xB6)
        work->camera2.config.projFOV = 0xB6;

    if (work->camera2.config.projFOV > 0x3F49)
        work->camera2.config.projFOV = 0x3F49;

    work->camera.config.projFOV         = work->camera2.config.projFOV;
    work->camera.config.projNear        = work->camera2.config.projNear;
    work->camera.config.projFar         = work->camera2.config.projFar;
    work->camera.config.aspectRatio     = work->camera2.config.aspectRatio;
    work->camera.config.projScaleW      = work->camera2.config.projScaleW;
    work->camera.config.matProjPosition = work->camera2.config.matProjPosition;
    work->camera.lookAtTo               = work->camera2.lookAtTo;
    work->camera.lookAtFrom             = work->camera2.lookAtFrom;
    work->camera.lookAtUp               = work->camera2.lookAtUp;
    work->camera.position               = work->camera2.position;

    Camera3D__LoadState(&work->camera);
#else
    // clang-format off
	ldrh r1, [r0, #0x50]
	ldr ip, =Camera3D__LoadState
	cmp r1, #0xb6
	movlo r1, #0xb6
	strloh r1, [r0, #0x50]
	ldrh r2, [r0, #0x50]
	ldr r1, =0x00003F49
	cmp r2, r1
	strhih r1, [r0, #0x50]
	ldrh r1, [r0, #0x50]
	strh r1, [r0]
	ldr r1, [r0, #0x54]
	str r1, [r0, #4]
	ldr r1, [r0, #0x58]
	str r1, [r0, #8]
	ldr r1, [r0, #0x5c]
	str r1, [r0, #0xc]
	ldr r1, [r0, #0x60]
	str r1, [r0, #0x10]
	ldr r1, [r0, #0x64]
	str r1, [r0, #0x14]
	ldr r1, [r0, #0x68]
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x6c]
	str r1, [r0, #0x1c]
	ldr r1, [r0, #0x70]
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x74]
	str r1, [r0, #0x24]
	ldr r1, [r0, #0x78]
	str r1, [r0, #0x28]
	ldr r1, [r0, #0x7c]
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x80]
	str r1, [r0, #0x30]
	ldr r1, [r0, #0x84]
	str r1, [r0, #0x34]
	ldr r1, [r0, #0x88]
	str r1, [r0, #0x38]
	ldr r1, [r0, #0x8c]
	str r1, [r0, #0x3c]
	ldr r1, [r0, #0x90]
	str r1, [r0, #0x40]
	ldr r1, [r0, #0x94]
	str r1, [r0, #0x44]
	ldr r1, [r0, #0x98]
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x9c]
	str r1, [r0, #0x4c]
	bx ip

// clang-format on
#endif
}

void exDrawReqTask__EntryUnknown2__SetLight(exDrawReqTaskLightConfig *light)
{
    switch (light->type)
    {
        case 1:
            light->light.color = GX_RGB_888(0x00, 0x00, 0xF8);
            break;

        case 2:
            light->light.color = GX_RGB_888(0x00, 0xF8, 0x00);
            break;

        case 3:
            light->light.color = GX_RGB_888(0x00, 0xF8, 0xF8);
            break;

        case 4:
            light->light.color = GX_RGB_888(0xF8, 0x00, 0x00);
            break;

        case 5:
            light->light.color = GX_RGB_888(0xF8, 0x00, 0xF8);
            break;

        case 6:
            light->light.color = GX_RGB_888(0xF8, 0xF8, 0x00);
            break;

        case 7:
            GetDrawStateLight(GetExSystemDrawState(), &light->light, GX_LIGHTID_0);
            Camera3D__SetLight(GX_LIGHTID_0, &light->light);

            GetDrawStateLight(GetExSystemDrawState(), &light->light, GX_LIGHTID_1);
            Camera3D__SetLight(GX_LIGHTID_1, &light->light);

            GetDrawStateLight(GetExSystemDrawState(), &light->light, GX_LIGHTID_2);
            Camera3D__SetLight(GX_LIGHTID_2, &light->light);

            GetDrawStateLight(GetExSystemDrawState(), &light->light, GX_LIGHTID_3);
            Camera3D__SetLight(GX_LIGHTID_3, &light->light);
            return;

        default:
            light->light.color = light->light2.color;
            break;
    }

    light->light.dir.x = light->light2.dir.x;
    light->light.dir.y = light->light2.dir.y;
    light->light.dir.z = light->light2.dir.z;

    Camera3D__SetLight(GX_LIGHTID_0, &light->light);
    Camera3D__SetLight(GX_LIGHTID_1, &light->light);
    Camera3D__SetLight(GX_LIGHTID_2, &light->light);
    Camera3D__SetLight(GX_LIGHTID_3, &light->light);
}

NONMATCH_FUNC void exDrawFadeUnknown__Func_2161314(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #1
	ldr r1, =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	str ip, [r0, #0x54]
	mov r3, #0x800000
	mov r2, #0
	ldr r1, =0x00001555
	str r3, [r0, #0x58]
	str r1, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r2, [r0, #0x70]
	sub r1, r2, #0x26800
	str r1, [r0, #0x74]
	mov r1, #0x134000
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _02161378
	str r2, [r0, #0x7c]
	mov r1, #0x80000
	str r1, [r0, #0x80]
	str r2, [r0, #0x84]
	b _02161388
_02161378:
	cmp r1, #1
	streq r2, [r0, #0x7c]
	streq r2, [r0, #0x80]
	streq r2, [r0, #0x84]
_02161388:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeUnknown__Func_21613A8(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #2
	ldr r1, =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	str ip, [r0, #0x54]
	mov r3, #0x800000
	mov r2, #0
	ldr r1, =0x00001555
	str r3, [r0, #0x58]
	str r1, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r2, [r0, #0x70]
	sub r1, r2, #0x26800
	str r1, [r0, #0x74]
	mov r1, #0x134000
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _0216140C
	str r2, [r0, #0x7c]
	mov r1, #0x80000
	str r1, [r0, #0x80]
	str r2, [r0, #0x84]
	b _0216141C
_0216140C:
	cmp r1, #1
	streq r2, [r0, #0x7c]
	streq r2, [r0, #0x80]
	streq r2, [r0, #0x84]
_0216141C:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeUnknown__Func_216143C(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #3
	ldr r1, =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	str ip, [r0, #0x54]
	mov r2, #0x1f4000
	mov r3, #0x800000
	ldr r1, =0x00001555
	str r3, [r0, #0x58]
	str r1, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r2, [r0, #0x70]
	sub r1, r2, #0x21c000
	str r1, [r0, #0x74]
	sub r1, r2, #0xd2000
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _021614A8
	ldr r2, =0x00006666
	mov r1, #0x80000
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
	b _021614C8
_021614A8:
	cmp r1, #1
	bne _021614C8
	ldr r2, =0x00006666
	mov r1, #0
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
_021614C8:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeUnknown__Func_21614EC(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #4
	ldr r1, =0x000004FA
	strh r2, [r0, #0xa2]
	strh r1, [r0, #0x50]
	mov ip, #0x1000
	mov r1, #0x1f4000
	rsb r1, r1, #0
	str ip, [r0, #0x54]
	mov r3, #0x800000
	ldr r2, =0x00001555
	str r3, [r0, #0x58]
	str r2, [r0, #0x5c]
	str ip, [r0, #0x60]
	str r1, [r0, #0x70]
	add r2, r1, #0x1cc000
	ldr r1, =0x00122000
	str r2, [r0, #0x74]
	str r1, [r0, #0x78]
	ldrh r1, [r0, #0xa0]
	cmp r1, #0
	bne _0216155C
	ldr r2, =0xFFFF999A
	mov r1, #0x80000
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
	b _0216157C
_0216155C:
	cmp r1, #1
	bne _0216157C
	ldr r2, =0xFFFF999A
	mov r1, #0
	str r2, [r0, #0x7c]
	str r1, [r0, #0x80]
	mov r1, #0x40000
	str r1, [r0, #0x84]
_0216157C:
	mov r2, #0
	str r2, [r0, #0x88]
	mov r1, #0x1000
	str r1, [r0, #0x8c]
	str r2, [r0, #0x90]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeUnknown__Func_21615A4(s32 a1, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, =exDrawFadeTask__cameraConfigA
	bl exDrawFadeUnknown__Init
	ldr r1, =0x021763E8
	mov r2, #0
	ldr r0, =exDrawFadeTask__cameraConfigB
	strh r2, [r1, #0x58]
	bl exDrawFadeUnknown__Init
	ldr r0, =exDrawFadeTask__lightConfig
	mov r1, #1
	strh r1, [r0, #0xb4]
	cmp r4, #4
	addls pc, pc, r4, lsl #2
	b _02161644
_021615E0: // jump table
	b _02161644 // case 0
	b _021615F4 // case 1
	b _02161608 // case 2
	b _0216161C // case 3
	b _02161630 // case 4
_021615F4:
	ldr r0, =exDrawFadeTask__cameraConfigA
	bl exDrawFadeUnknown__Func_2161314
	ldr r0, =exDrawFadeTask__cameraConfigB
	bl exDrawFadeUnknown__Func_2161314
	b _02161654
_02161608:
	ldr r0, =exDrawFadeTask__cameraConfigA
	bl exDrawFadeUnknown__Func_21613A8
	ldr r0, =exDrawFadeTask__cameraConfigB
	bl exDrawFadeUnknown__Func_21613A8
	b _02161654
_0216161C:
	ldr r0, =exDrawFadeTask__cameraConfigA
	bl exDrawFadeUnknown__Func_216143C
	ldr r0, =exDrawFadeTask__cameraConfigB
	bl exDrawFadeUnknown__Func_216143C
	b _02161654
_02161630:
	ldr r0, =exDrawFadeTask__cameraConfigA
	bl exDrawFadeUnknown__Func_21614EC
	ldr r0, =exDrawFadeTask__cameraConfigB
	bl exDrawFadeUnknown__Func_21614EC
	b _02161654
_02161644:
	ldr r0, =exDrawFadeTask__cameraConfigA
	bl exDrawFadeUnknown__Func_2161314
	ldr r0, =exDrawFadeTask__cameraConfigB
	bl exDrawFadeUnknown__Func_2161314
_02161654:
	ldr r0, =0x21762E8 // exDrawFadeTask__lightConfig
	bl exDrawReqTask__EntryUnknown2__InitLight
	mov r1, #0
	ldr r0, =exDrawFadeTask__lightConfig
	sub r2, r1, #0x1000
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	ldr r1, =0x00007FFF
	strh r2, [r0, #0xc]
	strh r1, [r0, #0xe]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

exDrawFadeUnknown *exDrawFadeTask__GetUnknownA(void)
{
    return &exDrawFadeTask__cameraConfigA;
}

exDrawFadeUnknown *exDrawFadeTask__GetUnknownB(void)
{
    return &exDrawFadeTask__cameraConfigB;
}

exDrawReqTaskLightConfig *exDrawReqTask__EntryUnknown2__GetLightConfig(void)
{
    return &exDrawFadeTask__lightConfig;
}

void exDrawReqTask__InitSprite2DWorker(ExGraphicsSprite2D *work)
{
    MI_CpuClear8(work, sizeof(*work));

    work->rotation = 0;
    work->pos.x    = 0;
    work->pos.y    = 0;
    work->scale.x  = FLOAT_TO_FX32(1.0);
    work->scale.y  = FLOAT_TO_FX32(1.0);
    work->field_7C = 0;
}

void exDrawReqTask__InitSprite2DConfig(exDrawReqTaskConfig *work)
{
    work->field_0.value_1  = 0;
    work->field_0.value_4  = FALSE;
    work->field_0.value_10 = 0;

    work->flags.value_1  = FALSE;
    work->flags.value_2  = FALSE;
    work->flags.value_4  = FALSE;
    work->flags.value_8  = TRUE;
    work->flags.value_10 = FALSE;
    work->flags.value_20 = 2;

    work->priority = 0;

    work->field_2.value_20 = FALSE;
}

void exDrawReqTask__InitSprite2D(EX_ACTION_BAC2D_WORK *work)
{
    exDrawReqTask__InitSprite2DWorker(&work->sprite);
    exDrawReqTask__InitSprite2DConfig(&work->config);
}

void exDrawReqTask__Sprite2D__HandleTransform(EX_ACTION_BAC2D_WORK *work)
{
    work->sprite.animator.pos.x = work->sprite.pos.x;
    work->sprite.animator.pos.y = work->sprite.pos.y;

    if (work->sprite.scale.x >= FLOAT_TO_FX32(2.0))
        work->sprite.scale.x = FLOAT_TO_FX32(2.0);

    if (work->sprite.scale.y >= FLOAT_TO_FX32(2.0))
        work->sprite.scale.y = FLOAT_TO_FX32(2.0);

    if (work->sprite.scale.x <= -FLOAT_TO_FX32(2.0))
        work->sprite.scale.x = -FLOAT_TO_FX32(2.0);

    if (work->sprite.scale.y <= -FLOAT_TO_FX32(2.0))
        work->sprite.scale.y = -FLOAT_TO_FX32(2.0);
}

NONMATCH_FUNC void exDrawReqTask__Sprite2D__HandleUnknown(EX_ACTION_BAC2D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldrb ip, [r5, #0x80]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, ip, lsl #0x18
	mov r1, r0, lsr #0x1f
	mov r3, r3, lsr #0x1d
	rsb r0, r1, r0, lsl #31
	and r3, r3, #0xff
	add r0, r1, r0, ror #31
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r4, [r2]
	mov r4, r0, lsl #0x10
	bl exHitCheckTask_IsPaused
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r0, [r5, #0x80]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrsh r0, [r5, #0xc]
	ldr r2, =_mt_math_rand
	ldr r1, =0x3C6EF35F
	addne r0, r0, r4, asr #16
	subeq r0, r0, r4, asr #16
	strh r0, [r5, #0xc]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldrsh r0, [r5, #0xe]
	addne r0, r0, r4, asr #16
	subeq r0, r0, r4, asr #16
	strh r0, [r5, #0xe]
	ldrb r1, [r5, #0x80]
	mov r0, r1, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0xff
	and r0, r0, #0xff
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r0, r1, r0, lsr #24
	strb r0, [r5, #0x80]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite2D__Animate(EX_ACTION_BAC2D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r1, [r4, #0x81]
	mov r1, r1, lsl #0x1b
	movs r1, r1, lsr #0x1f
	beq _02161924
	bl exDrawReqTask__Sprite2D__Func_2161B44
_02161924:
	ldrb r0, [r4, #0x81]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #4
	bl AnimatorSprite__ProcessAnimation
	ldrb r0, [r4, #0x81]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r4, pc}
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl exDrawReqTask__Sprite2D__IsAnimFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl exDrawReqTask__Sprite2D__Func_2161B44
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void exDrawReqTask__Sprite2D__HandleOamPriority(EX_ACTION_BAC2D_WORK *work)
{
    if (work->config.priority < 0xA800)
        work->sprite.animator.oamPriority = SPRITE_PRIORITY_1;

    if (work->config.priority >= 0xA800)
        work->sprite.animator.oamPriority = SPRITE_PRIORITY_0;
}

NONMATCH_FUNC void exDrawReqTask__Sprite2D__Draw(EX_ACTION_BAC2D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrb r0, [r4, #0x80]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r5, [r4, #0x78]
	cmp r5, #0
	beq _021619E0
	bl Camera3D__GetWork
	mov r1, r5
	add r0, r0, #0x7c
	mov r2, #0x1f
	bl RenderCore_ChangeBlendAlpha
	mov r0, #1
	str r0, [r4, #0x5c]
_021619E0:
	ldrb r0, [r4, #0x80]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _02161A7C
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161A48
	ldrsh r0, [r4, #0xe]
	add r0, r0, #0xc0
	strh r0, [r4, #0xe]
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161A30
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161A38
_02161A30:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
_02161A38:
	ldrsh r0, [r4, #0xe]
	sub r0, r0, #0xc0
	strh r0, [r4, #0xe]
	b _02161B08
_02161A48:
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161A70
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161B08
_02161A70:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	b _02161B08
_02161A7C:
	cmp r0, #1
	bne _02161AC4
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161B08
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161AB8
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161B08
_02161AB8:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	b _02161B08
_02161AC4:
	cmp r0, #2
	bne _02161B08
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02161B08
	ldrb r0, [r4, #0x82]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161B00
	ldrh r3, [r4, #0x74]
	ldr r1, [r4, #0x6c]
	ldr r2, [r4, #0x70]
	add r0, r4, #4
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02161B08
_02161B00:
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
_02161B08:
	ldrsh r0, [r4, #0x68]
	strh r0, [r4, #0xc]
	ldrsh r0, [r4, #0x6a]
	strh r0, [r4, #0xe]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void exDrawReqTask__Sprite2D__ProcessRequest(EX_ACTION_BAC2D_WORK *work)
{
    exDrawReqTask__Sprite2D__HandleTransform(work);
    exDrawReqTask__Sprite2D__HandleUnknown(work);
    exDrawReqTask__Sprite2D__HandleOamPriority(work);
    exDrawReqTask__Sprite2D__Draw(work);
}

void exDrawReqTask__Sprite2D__Func_2161B44(EX_ACTION_BAC2D_WORK *work)
{
    work->config.flags.value_4  = FALSE;
    work->config.flags.value_2  = TRUE;
    work->config.flags.value_8  = FALSE;
    work->config.flags.value_10 = FALSE;
}

void exDrawReqTask__Sprite2D__Func_2161B6C(EX_ACTION_BAC2D_WORK *work)
{
    work->config.field_0.value_1 = 1;
}

void exDrawReqTask__Sprite2D__Func_2161B80(EX_ACTION_BAC2D_WORK *work)
{
    work->config.field_0.value_1 = 2;
}

BOOL exDrawReqTask__Sprite2D__IsAnimFinished(EX_ACTION_BAC2D_WORK *work)
{
    return work->sprite.animator.animFrameCount == work->sprite.animator.animFrameIndex && work->sprite.animator.frameRemainder <= work->sprite.animator.animAdvance;
}

NONMATCH_FUNC void exDrawReqTask__Model__InitWorker(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	mov r2, #0x370
	bl MI_CpuFill8
	add r0, r4, #4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r1, #0
	strh r1, [r4]
	add r0, r4, #0x300
	strh r1, [r0, #0x2e]
	strh r1, [r0, #0x30]
	strh r1, [r0, #0x32]
	str r1, [r4, #0x334]
	str r1, [r4, #0x338]
	str r1, [r4, #0x33c]
	mov r0, #0x1000
	str r0, [r4, #0x34c]
	str r0, [r4, #0x350]
	str r0, [r4, #0x354]
	str r1, [r4, #0x358]
	str r1, [r4, #0x35c]
	str r1, [r4, #0x360]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__InitConfig(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldrb r2, [r0, #0]
	mov r1, #0
	bic r3, r2, #3
	and r2, r3, #0xff
	bic r4, r2, #4
	and r2, r4, #0xff
	bic r3, r2, #8
	and r2, r3, #0xff
	strb r4, [r0]
	bic r2, r2, #0xf0
	strb r2, [r0]
	ldrb r2, [r0, #1]
	bic r4, r2, #1
	and r2, r4, #0xff
	bic r3, r2, #2
	and r2, r3, #0xff
	bic lr, r2, #4
	and r2, lr, #0xff
	orr ip, r2, #8
	bic r3, ip, #0x10
	and r2, r3, #0xff
	bic r2, r2, #0xe0
	strb lr, [r0, #1]
	orr r2, r2, #0x20
	strb r2, [r0, #1]
	ldrb r2, [r0, #2]
	bic r2, r2, #0x1c
	orr r2, r2, #0x1c
	strb r2, [r0, #2]
	strh r1, [r0, #4]
	ldrb r1, [r0, #2]
	bic r1, r1, #2
	strb r1, [r0, #2]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__InitModel(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl exDrawReqTask__Model__InitWorker
	mov r0, r4
	bl exHitCheckTask_InitHitChecker
	add r0, r4, #0x38c
	bl exDrawReqTask__Model__InitConfig
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__HandleTransform(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x90
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0x2e]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, r4, #0x300
	ldrh r1, [r0, #0x30]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x48
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r4, #0x300
	ldrh r1, [r0, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x6c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotZ33_
	add r0, sp, #0x48
	add r1, sp, #0x24
	add r2, sp, #0
	bl MTX_Concat33
	add r0, sp, #0x6c
	add r1, sp, #0
	add r2, r4, #0x28
	bl MTX_Concat33
	ldr r0, [r4, #0x334]
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x338]
	str r0, [r4, #0x50]
	ldr r0, [r4, #0x33c]
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x34c]
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x350]
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x354]
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x358]
	str r0, [r4, #0x58]
	ldr r0, [r4, #0x35c]
	str r0, [r4, #0x5c]
	ldr r0, [r4, #0x360]
	str r0, [r4, #0x60]
	add sp, sp, #0x90
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__HandlePriority(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x38c]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02161E10
	add r0, r6, #0x38
	add r4, r6, #0x394
	add r5, r0, #0x400
	b _02161E20
_02161E10:
	bl exDrawFadeTask__GetUnknownA
	mov r4, r0
	bl exDrawFadeTask__GetUnknownB
	mov r5, r0
_02161E20:
	ldrb r1, [r6, #2]
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	mov r0, r1, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	mov r0, r1, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	mov r0, r1, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	ldrb r0, [r6, #1]
	mov r2, r0, lsl #0x1c
	movs r2, r2, lsr #0x1f
	bne _02161ED8
	mov r2, r0, lsl #0x1d
	movs r2, r2, lsr #0x1f
	bne _02161ED8
	mov r2, r0, lsl #0x1e
	movs r2, r2, lsr #0x1f
	bne _02161ED8
	mov r1, r1, lsl #0x18
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	ldrb r1, [r6, #3]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r1, r0, lsl #0x19
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _02161ED8
	ldrb r0, [r6, #4]
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	bne _02161ED8
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _02161F18
_02161ED8:
	ldr r1, [r6, #0x354]
	ldr r0, =0x00024C04
	cmp r1, r0
	ble _02161EF8
	ldrb r0, [r6, #0x38c]
	bic r0, r0, #3
	orr r0, r0, #2
	strb r0, [r6, #0x38c]
_02161EF8:
	ldr r1, [r6, #0x354]
	ldr r0, =0x00024C04
	cmp r1, r0
	bgt _02161F18
	ldrb r0, [r6, #0x38c]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r6, #0x38c]
_02161F18:
	ldrb r0, [r6, #0x38c]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _02161F4C
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161F40
	mov r0, r4
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_02161F40:
	mov r0, r5
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_02161F4C:
	cmp r0, #1
	bne _02161F7C
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02161F6C
	mov r0, r5
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_02161F6C:
	ldrb r0, [r6, #0x38c]
	orr r0, r0, #4
	strb r0, [r6, #0x38c]
	ldmia sp!, {r4, r5, r6, pc}
_02161F7C:
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldreqb r0, [r6, #0x38c]
	orreq r0, r0, #4
	streqb r0, [r6, #0x38c]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__HandleUnknown(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldrb ip, [r5, #0x38c]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
	bl exHitCheckTask_IsPaused
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl exDrawReqTask__Func_2164260
	ldrb r0, [r0, #0]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	beq _02162080
	bl exDrawReqTask__Func_2164260
	bl exDrawReqTask__Func_21642BC
	bl exDrawReqTask__Func_2164260
	ldrb r0, [r0, #0]
	ldrb r1, [r5, #0x38c]
	ldr r2, =_mt_math_rand
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1c
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r4, r1, r0, lsr #24
	strb r4, [r5, #0x38c]
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	and ip, r4, #0xff
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
_02162080:
	ldrb r0, [r5, #0x38c]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x68]
	ldr r2, =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x68]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x6c]
	ldr r2, =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x6c]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x70]
	addne r0, r0, r4
	strne r0, [r5, #0x70]
	subeq r0, r0, r4
	streq r0, [r5, #0x70]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__Animate(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldrb r0, [r4, #1]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _021621AC
	add r6, r4, #0x164
	mov r5, #0
_02162184:
	mov r0, r6
	bl AnimatePalette
	mov r0, r6
	bl DrawAnimatedPalette
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	cmp r5, #0xf
	add r6, r6, #0x20
	blt _02162184
_021621AC:
	ldrb r0, [r4, #0x38d]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _021621CC
	mov r1, #0
	add r0, r4, #0x38c
	str r1, [r4, #0x344]
	bl exDrawReqTask__Func_2164238
_021621CC:
	ldrb r0, [r4, #0x38d]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x20
	bl AnimatorMDL__ProcessAnimation
	ldrb r0, [r4, #0x38d]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	beq _02162228
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02162228
	add r0, r4, #0x38c
	bl exDrawReqTask__Func_2164238
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02162228:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__Draw(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x40
	mov r5, r0
	ldrb r1, [r5, #0x38c]
	mov r2, r1, lsl #0x1d
	movs r2, r2, lsr #0x1f
	bicne r0, r1, #4
	addne sp, sp, #0x40
	strneb r0, [r5, #0x38c]
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, =0x04000060
	ldrh r1, [r2, #0]
	bic r1, r1, #0x3000
	orr r1, r1, #8
	strh r1, [r2]
	ldrb r1, [r5, #3]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1f
	beq _021622A4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02162298
	bl Camera3D__UseEngineA
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
	b _02162378
_02162298:
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
	b _02162378
_021622A4:
	ldrb r0, [r5, #1]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02162370
	bl exBossHelpers__GetBossAssets
	mov r4, r0
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
	mov r3, #2
	add r1, sp, #0xc
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r2, #0x1e
	str r2, [sp, #8]
	add r1, sp, #8
	mov r0, #0x14
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x10
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	ldr r0, [sp, #0x34]
	mov r2, #2
	str r0, [r4, #0x380]
	ldr r1, [sp, #0x38]
	mov r0, #0x10
	str r1, [r4, #0x384]
	ldr r3, [sp, #0x3c]
	add r1, sp, #4
	str r3, [r4, #0x388]
	str r2, [sp, #4]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x1d
	str r0, [sp]
	mov r0, #0x14
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x10
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	ldr r1, [sp, #0x34]
	mov r0, #0x3c000
	str r1, [r4, #0x35c]
	ldr r1, [sp, #0x38]
	str r1, [r4, #0x360]
	str r0, [r4, #0x364]
	b _02162378
_02162370:
	add r0, r5, #0x20
	bl AnimatorMDL__Draw
_02162378:
	ldr r0, [r5, #0x350]
	str r0, [r5, #0x68]
	ldr r0, [r5, #0x354]
	str r0, [r5, #0x6c]
	ldr r0, [r5, #0x358]
	str r0, [r5, #0x70]
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__HandleLighting(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl exDrawReqTask__EntryUnknown2__GetLightConfig
	ldrb r1, [r4, #0x38e]
	mov r1, r1, lsl #0x1b
	mov r1, r1, lsr #0x1d
	strb r1, [r0, #0x10]
	bl exDrawReqTask__EntryUnknown2__GetLightConfig
	bl exDrawReqTask__EntryUnknown2__SetLight
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Model__ProcessRequest(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl exDrawReqTask__Model__HandleTransform
	mov r0, r4
	bl exDrawReqTask__Model__HandleLighting
	mov r0, r4
	bl exDrawReqTask__Model__HandleUnknown
	mov r0, r4
	bl exDrawReqTask__Model__HandlePriority
	mov r0, r4
	bl exDrawReqTask__Model__Draw
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exDrawReqTask__Model__IsAnimFinished(EX_ACTION_NN_WORK *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x300
	ldrh r1, [r1, #0x48]
	add r0, r0, r1, lsl #1
	add r0, r0, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #0x8000
	movne r0, #1
	moveq r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__InitTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *position, u16 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r1, #0
	mov r2, #0x1c
	ldrh r5, [r4, #0x20]
	bl MI_CpuFill8
	add r0, r4, #0x1c
	mov r1, #0
	mov r2, #0x250
	bl MI_CpuFill8
	add r0, r4, #0x26c
	mov r1, #0
	mov r2, #6
	bl MI_CpuFill8
	add r0, r4, #0x274
	mov r1, #0
	mov r2, #0xa4
	bl MI_CpuFill8
	add r0, r4, #0x318
	mov r1, #0
	mov r2, #0xa4
	bl MI_CpuFill8
	strh r5, [r4, #0x20]
	add r0, r4, #0x200
	strh r6, [r0, #0x64]
	ldrh r0, [r0, #0x64]
	cmp r0, #1
	beq _021624A8
	cmp r0, #2
	beq _021624B8
	cmp r0, #3
	beq _021624C8
	b _021624D4
_021624A8:
	mov r0, r4
	mov r1, r7
	bl exDrawReqTask__Trail__HandleTrail2
	b _021624D4
_021624B8:
	mov r0, r4
	mov r1, r7
	bl exDrawReqTask__Trail__HandleTrail4
	b _021624D4
_021624C8:
	mov r0, r4
	mov r1, r7
	bl exDrawReqTask__Trail__HandleTrail6
_021624D4:
	ldrb r0, [r4, #0x26d]
	bic r0, r0, #0xe0
	orr r0, r0, #0x80
	strb r0, [r4, #0x26d]
	ldrb r0, [r4, #0x26c]
	bic r0, r0, #8
	strb r0, [r4, #0x26c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__HandleTrail6(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	add ip, r0, #0x1c
	mov r2, #0x2000
	str r2, [ip, #0x23c]
	ldr r5, =0x00007B39
	str r2, [ip, #0x240]
	mov r3, #0
_02162510:
	add r2, r3, #1
	add r4, ip, r3, lsl #1
	mov r3, r2, lsl #0x10
	add r2, r4, #0x100
	mov r3, r3, lsr #0x10
	strh r5, [r2, #0x70]
	cmp r3, #0x1e
	blo _02162510
	mov r5, #0
	mov r4, r5
_02162538:
	add r2, r5, #1
	mov r2, r2, lsl #0x10
	add r3, ip, r5, lsl #2
	mov r5, r2, lsr #0x10
	str r4, [r3, #0x1ac]
	cmp r5, #0x1e
	blo _02162538
	str r4, [ip, #0x24c]
	ldr r2, [r1, #0]
	ldr r3, =FX_SinCosTable_
	str r2, [ip, #0x224]
	ldr r2, [r1, #4]
	mov lr, #2
	str r2, [ip, #0x228]
	ldr r2, [r1, #8]
	str r2, [ip, #0x22c]
	str r4, [ip]
	ldrh r2, [ip, #4]
	add r2, r2, #0x4000
	strh r2, [ip, #4]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #8]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0xc]
	ldr r2, [r1, #8]
	str r2, [ip, #0x10]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0x14]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r3, [r3, r5]
	smull r5, r4, r3, r4
	adds r5, r5, #0x800
	adc r3, r4, #0
	mov r4, r5, lsr #0xc
	orr r4, r4, r3, lsl #20
	add r2, r2, r4
	str r2, [ip, #0x18]
	ldr r2, [r1, #8]
	str r2, [ip, #0x1c]
	ldr r3, [ip, #8]
	ldr r2, [r1, #0]
	sub r2, r3, r2
	str r2, [ip, #0x230]
	ldr r3, [ip, #0xc]
	ldr r2, [r1, #4]
	sub r2, r3, r2
	str r2, [ip, #0x234]
	ldr r2, [ip, #0x10]
	ldr r1, [r1, #8]
	sub r1, r2, r1
	str r1, [ip, #0x238]
	mov r1, #0xc
_021626AC:
	mla r4, lr, r1, ip
	ldr r3, [r4, #-0x10]
	add r2, lr, #1
	str r3, [r4, #8]
	ldr r3, [r4, #-0xc]
	mov r2, r2, lsl #0x10
	str r3, [r4, #0xc]
	ldr r3, [r4, #-8]
	mov lr, r2, lsr #0x10
	str r3, [r4, #0x10]
	cmp lr, #0x1e
	blo _021626AC
	mov r1, #1
	strb r1, [r0]
	ldrb r3, [r0, #3]
	mov r2, #0x2000
	mov r1, #0
	orr r3, r3, #2
	strb r3, [r0, #3]
	str r2, [r0, #0xc]
	str r2, [r0, #0x10]
	str r1, [r0, #0x14]
	add r1, r0, #0x240
	str r1, [r0, #0x18]
	ldrb r1, [r0, #0x26c]
	bic r1, r1, #3
	strb r1, [r0, #0x26c]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__HandleTrail5(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, s32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	cmp r2, #0
	add r4, r0, #0x1c
	beq _0216274C
	cmp r2, #1
	beq _02162754
	cmp r2, #2
	moveq r5, #0x1800
	b _02162758
_0216274C:
	mov r5, #0x1800
	b _02162758
_02162754:
	mov r5, #0x3000
_02162758:
	ldr r1, [r6, #0]
	mov r0, #0x1d
	str r1, [r4, #0x224]
	ldr r1, [r6, #4]
	str r1, [r4, #0x228]
	ldr r1, [r6, #8]
	str r1, [r4, #0x22c]
	mov r1, #0xc
_02162778:
	mla r7, r0, r1, r4
	ldr r2, [r7, #-0x10]
	add r3, r4, r0, lsl #2
	str r2, [r7, #8]
	ldr r2, [r7, #-0xc]
	sub r0, r0, #1
	str r2, [r7, #0xc]
	ldr r2, [r7, #-8]
	mov r0, r0, lsl #0x10
	str r2, [r7, #0x10]
	ldr r2, [r3, #0x1a4]
	mov r0, r0, lsr #0x10
	cmp r2, #1
	subgt r2, r2, #2
	strgt r2, [r3, #0x1ac]
	cmp r0, #0xc
	bhs _02162778
	ldr r0, [r4, #0x68]
	ldr r3, =FX_SinCosTable_
	str r0, [r4, #0x80]
	ldr r0, [r4, #0x6c]
	mov r7, #0x1f
	str r0, [r4, #0x84]
	ldr r1, [r4, #0x70]
	mov r0, r5
	str r1, [r4, #0x88]
	ldr r2, [r4, #0x1cc]
	mov r1, #0x2000
	str r2, [r4, #0x1d4]
	ldr r2, [r4, #0x74]
	str r2, [r4, #0x8c]
	ldr r2, [r4, #0x78]
	str r2, [r4, #0x90]
	ldr r2, [r4, #0x7c]
	str r2, [r4, #0x94]
	ldr r2, [r4, #0x1d0]
	str r2, [r4, #0x1d8]
	ldrh r2, [r4, #4]
	add r2, r2, #0x4000
	strh r2, [r4, #4]
	ldrh ip, [r4, #4]
	ldr r8, [r4, #0x23c]
	ldr r2, [r6, #0]
	mov ip, ip, asr #4
	mov ip, ip, lsl #1
	add ip, ip, #1
	mov ip, ip, lsl #1
	ldrsh ip, [r3, ip]
	smull lr, r8, ip, r8
	adds ip, lr, #0x800
	adc r8, r8, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r8, lsl #20
	add r2, r2, ip
	str r2, [r4, #0x68]
	ldrh lr, [r4, #4]
	ldr ip, [r4, #0x240]
	ldr r2, [r6, #4]
	mov lr, lr, asr #4
	mov lr, lr, lsl #2
	ldrsh lr, [r3, lr]
	smull r8, ip, lr, ip
	adds lr, r8, #0x800
	adc r8, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r8, lsl #20
	add r2, r2, ip
	str r2, [r4, #0x6c]
	ldr r2, [r6, #8]
	str r2, [r4, #0x70]
	str r7, [r4, #0x1cc]
	ldrh lr, [r4, #4]
	ldr ip, [r4, #0x23c]
	ldr r2, [r6, #0]
	mov lr, lr, asr #4
	mov lr, lr, lsl #1
	add lr, lr, #1
	mov lr, lr, lsl #1
	ldrsh lr, [r3, lr]
	smull r7, ip, lr, ip
	adds lr, r7, #0x800
	adc r7, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r7, lsl #20
	sub r2, r2, ip
	str r2, [r4, #0x74]
	ldrh lr, [r4, #4]
	ldr ip, [r4, #0x240]
	ldr r2, [r6, #4]
	mov lr, lr, asr #4
	mov lr, lr, lsl #2
	ldrsh r3, [r3, lr]
	smull lr, ip, r3, ip
	adds lr, lr, #0x800
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	sub r2, r2, ip
	str r2, [r4, #0x78]
	ldr r2, [r6, #8]
	str r2, [r4, #0x7c]
	ldr r2, [r4, #0x1cc]
	str r2, [r4, #0x1d0]
	bl FX_Div
	ldr r1, [r6, #0]
	mov r2, #0x1f
	add r0, r1, r0
	str r0, [r4, #8]
	ldr r1, [r6, #4]
	mov r0, r5
	add r1, r1, r5
	str r1, [r4, #0xc]
	ldr r3, [r6, #8]
	mov r1, #0x2000
	str r3, [r4, #0x10]
	str r2, [r4, #0x1ac]
	bl FX_Div
	ldr r1, [r6, #0]
	mov r2, #0x1f
	sub r0, r1, r0
	str r0, [r4, #0x14]
	ldr r1, [r6, #4]
	mov r0, r5
	add r1, r1, r5
	str r1, [r4, #0x18]
	ldr r3, [r6, #8]
	mov r1, #0x2000
	str r3, [r4, #0x1c]
	str r2, [r4, #0x1b0]
	ldr r2, [r6, #0]
	add r2, r2, r5
	str r2, [r4, #0x20]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	add r0, r2, r0
	str r0, [r4, #0x24]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x28]
	str r1, [r4, #0x1b4]
	ldr r2, [r6, #0]
	mov r1, #0x2000
	sub r2, r2, r5
	str r2, [r4, #0x2c]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	add r0, r2, r0
	str r0, [r4, #0x30]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x34]
	str r1, [r4, #0x1b8]
	ldr r2, [r6, #0]
	mov r1, #0x2000
	add r2, r2, r5
	str r2, [r4, #0x38]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	sub r0, r2, r0
	str r0, [r4, #0x3c]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x40]
	str r1, [r4, #0x1bc]
	ldr r2, [r6, #0]
	mov r1, #0x2000
	sub r2, r2, r5
	str r2, [r4, #0x44]
	bl FX_Div
	ldr r2, [r6, #4]
	mov r1, #0x1f
	sub r0, r2, r0
	str r0, [r4, #0x48]
	ldr r2, [r6, #8]
	mov r0, r5
	str r2, [r4, #0x4c]
	str r1, [r4, #0x1c0]
	mov r1, #0x2000
	bl FX_Div
	ldr r1, [r6, #0]
	add r0, r1, r0
	str r0, [r4, #0x50]
	ldr r0, [r6, #4]
	sub r0, r0, r5
	str r0, [r4, #0x54]
	ldr r0, [r6, #8]
	mov r1, #0x1f
	str r0, [r4, #0x58]
	mov r0, r5
	str r1, [r4, #0x1c4]
	mov r1, #0x2000
	bl FX_Div
	ldr r2, [r6, #0]
	mov r1, #0x1f
	sub r0, r2, r0
	str r0, [r4, #0x5c]
	ldr r0, [r6, #4]
	sub r0, r0, r5
	str r0, [r4, #0x60]
	ldr r0, [r6, #8]
	str r0, [r4, #0x64]
	str r1, [r4, #0x1c8]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__HandleTrail4(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	add ip, r0, #0x1c
	mov r2, #0x8000
	str r2, [ip, #0x23c]
	ldr r6, =0x0000023F
	str r2, [ip, #0x240]
	mov lr, #0
	mov r5, #1
_02162AD4:
	add r2, ip, lr, lsl #1
	add r3, lr, #1
	add r2, r2, #0x100
	mov r3, r3, lsl #0x10
	add r4, ip, lr, lsl #2
	strh r6, [r2, #0x70]
	mov lr, r3, lsr #0x10
	str r5, [r4, #0x1ac]
	cmp lr, #0x1e
	blo _02162AD4
	mov r4, #0
	str r4, [ip, #0x24c]
	ldr r2, [r1, #0]
	ldr r3, =FX_SinCosTable_
	str r2, [ip, #0x224]
	ldr r2, [r1, #4]
	mov lr, #2
	str r2, [ip, #0x228]
	ldr r2, [r1, #8]
	str r2, [ip, #0x22c]
	str r4, [ip]
	ldrh r2, [ip, #4]
	add r2, r2, #0x4000
	strh r2, [ip, #4]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #8]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0xc]
	ldr r2, [r1, #8]
	str r2, [ip, #0x10]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x23c]
	ldr r2, [r1, #0]
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh r5, [r3, r5]
	smull r6, r4, r5, r4
	adds r5, r6, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [ip, #0x14]
	ldrh r5, [ip, #4]
	ldr r4, [ip, #0x240]
	ldr r2, [r1, #4]
	mov r5, r5, asr #4
	mov r5, r5, lsl #2
	ldrsh r3, [r3, r5]
	smull r5, r4, r3, r4
	adds r5, r5, #0x800
	adc r3, r4, #0
	mov r4, r5, lsr #0xc
	orr r4, r4, r3, lsl #20
	add r2, r2, r4
	str r2, [ip, #0x18]
	ldr r2, [r1, #8]
	str r2, [ip, #0x1c]
	ldr r3, [ip, #8]
	ldr r2, [r1, #0]
	sub r2, r3, r2
	str r2, [ip, #0x230]
	ldr r3, [ip, #0xc]
	ldr r2, [r1, #4]
	sub r2, r3, r2
	str r2, [ip, #0x234]
	ldr r2, [ip, #0x10]
	ldr r1, [r1, #8]
	sub r1, r2, r1
	str r1, [ip, #0x238]
	mov r1, #0xc
_02162C58:
	mla r4, lr, r1, ip
	ldr r3, [r4, #-0x10]
	add r2, lr, #1
	str r3, [r4, #8]
	ldr r3, [r4, #-0xc]
	mov r2, r2, lsl #0x10
	str r3, [r4, #0xc]
	ldr r3, [r4, #-8]
	mov lr, r2, lsr #0x10
	str r3, [r4, #0x10]
	cmp lr, #0x1e
	blo _02162C58
	mov r3, #0
	strb r3, [r0]
	ldrb r2, [r0, #5]
	add r1, r0, #0x240
	orr r2, r2, #2
	strb r2, [r0, #5]
	str r3, [r0, #0xc]
	str r3, [r0, #0x10]
	str r3, [r0, #0x14]
	str r1, [r0, #0x18]
	ldrb r1, [r0, #0x26c]
	bic r1, r1, #3
	strb r1, [r0, #0x26c]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__HandleTrail3(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r2, [r1, #0]
	add r3, r0, #0x1c
	str r2, [r3, #0x224]
	ldr r0, [r1, #4]
	mov lr, #0x1d
	str r0, [r3, #0x228]
	ldr r0, [r1, #8]
	mov r2, #0xc
	str r0, [r3, #0x22c]
_02162CF0:
	mla ip, lr, r2, r3
	ldr r0, [ip, #-0x10]
	add r4, r3, lr, lsl #2
	str r0, [ip, #8]
	ldr r0, [ip, #-0xc]
	str r0, [ip, #0xc]
	ldr r0, [ip, #-8]
	str r0, [ip, #0x10]
	ldr r0, [r4, #0x1a4]
	cmp r0, #1
	subgt r0, r0, #2
	strgt r0, [r4, #0x1ac]
	sub r0, lr, #1
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	cmp lr, #4
	bhs _02162CF0
	ldr r2, [r3, #8]
	mov r0, #0x1f
	str r2, [r3, #0x20]
	ldr r4, [r3, #0xc]
	ldr r2, =FX_SinCosTable_
	str r4, [r3, #0x24]
	ldr r4, [r3, #0x10]
	str r4, [r3, #0x28]
	ldr r4, [r3, #0x1ac]
	str r4, [r3, #0x1b4]
	ldr r4, [r3, #0x14]
	str r4, [r3, #0x2c]
	ldr r4, [r3, #0x18]
	str r4, [r3, #0x30]
	ldr r4, [r3, #0x1c]
	str r4, [r3, #0x34]
	ldr r4, [r3, #0x1b0]
	str r4, [r3, #0x1b8]
	str r0, [r3, #0x1ac]
	ldrh r0, [r3, #4]
	add r0, r0, #0x4000
	strh r0, [r3, #4]
	ldrh ip, [r3, #4]
	ldr r4, [r3, #0x23c]
	ldr r0, [r1, #0]
	mov ip, ip, asr #4
	mov ip, ip, lsl #1
	add ip, ip, #1
	mov ip, ip, lsl #1
	ldrsh ip, [r2, ip]
	smull lr, r4, ip, r4
	adds ip, lr, #0x800
	adc r4, r4, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r4, lsl #20
	add r0, r0, ip
	str r0, [r3, #8]
	ldrh r4, [r3, #4]
	ldr r0, [r3, #0x240]
	ldr lr, [r1, #4]
	mov r4, r4, asr #4
	mov r4, r4, lsl #2
	ldrsh r4, [r2, r4]
	smull ip, r0, r4, r0
	adds r4, ip, #0x800
	adc r0, r0, #0
	mov r4, r4, lsr #0xc
	orr r4, r4, r0, lsl #20
	add r0, lr, r4
	str r0, [r3, #0xc]
	ldr r0, [r1, #8]
	str r0, [r3, #0x10]
	ldrh lr, [r3, #4]
	ldr ip, [r3, #0x23c]
	ldr r0, [r1, #0]
	mov lr, lr, asr #4
	mov lr, lr, lsl #1
	add lr, lr, #1
	mov lr, lr, lsl #1
	ldrsh lr, [r2, lr]
	smull r4, ip, lr, ip
	adds lr, r4, #0x800
	adc r4, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r4, lsl #20
	sub r0, r0, ip
	str r0, [r3, #0x14]
	ldrh ip, [r3, #4]
	ldr r0, [r3, #0x240]
	ldr lr, [r1, #4]
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh r2, [r2, ip]
	smull ip, r0, r2, r0
	adds r2, ip, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	sub r0, lr, r2
	str r0, [r3, #0x18]
	ldr r0, [r1, #8]
	str r0, [r3, #0x1c]
	ldr r0, [r3, #0x1ac]
	str r0, [r3, #0x1b0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__HandleTrail2(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0x2800
	add r4, r6, #0x1c
	str r0, [r4, #0x23c]
	sub r0, r0, #0x5800
	mov lr, #0
	ldr ip, =0x000003FF
	mov r5, r1
	str r0, [r4, #0x240]
	mov r3, lr
_02162EB8:
	add r0, r4, lr, lsl #1
	add r1, lr, #1
	add r0, r0, #0x100
	mov r1, r1, lsl #0x10
	add r2, r4, lr, lsl #2
	strh ip, [r0, #0x70]
	mov lr, r1, lsr #0x10
	str r3, [r2, #0x1ac]
	cmp lr, #0x1e
	blo _02162EB8
	mov r0, #1
	str r0, [r4, #0x24c]
	ldr r0, [r5, #0]
	mov r1, #0x2000
	str r0, [r4, #0x224]
	ldr r0, [r5, #4]
	str r0, [r4, #0x228]
	ldr r0, [r5, #8]
	str r0, [r4, #0x22c]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r2, [r5, #0]
	mov r1, #0x2000
	sub r0, r2, r0
	str r0, [r4, #8]
	ldr r2, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0xc]
	ldr r0, [r5, #8]
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r2, [r5, #0]
	mov r1, #2
	add r0, r2, r0
	str r0, [r4, #0x14]
	ldr r2, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0x18]
	ldr r0, [r5, #8]
	str r0, [r4, #0x1c]
	mov r0, #0xc
_02162F68:
	mla r3, r1, r0, r4
	ldr r2, [r3, #-0x10]
	add r1, r1, #1
	str r2, [r3, #8]
	ldr r2, [r3, #-0xc]
	mov r1, r1, lsl #0x10
	str r2, [r3, #0xc]
	ldr r2, [r3, #-8]
	mov r1, r1, lsr #0x10
	str r2, [r3, #0x10]
	cmp r1, #0x1e
	blo _02162F68
	mov r0, #0
	strb r0, [r6]
	ldrb r2, [r6, #5]
	mov r1, #0x1000
	add r0, r6, #0x240
	orr r2, r2, #2
	strb r2, [r6, #5]
	str r1, [r6, #0xc]
	str r1, [r6, #0x10]
	str r1, [r6, #0x14]
	str r0, [r6, #0x18]
	ldrb r0, [r6, #0x26c]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r6, #0x26c]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__HandleTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, u32 type, u32 color)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, [r5, #0]
	add r4, r0, #0x1c
	str r1, [r4, #0x224]
	ldr r0, [r5, #4]
	cmp r2, #3
	str r0, [r4, #0x228]
	ldr r0, [r5, #8]
	str r0, [r4, #0x22c]
	addls pc, pc, r2, lsl #2
	b _02163068
_0216300C: // jump table
	b _0216301C // case 0
	b _02163030 // case 1
	b _02163044 // case 2
	b _02163058 // case 3
_0216301C:
	mov r0, #0x2800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x5800
	str r0, [r4, #0x240]
	b _02163068
_02163030:
	mov r0, #0x1800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x4800
	str r0, [r4, #0x240]
	b _02163068
_02163044:
	mov r0, #0x3800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x7800
	str r0, [r4, #0x240]
	b _02163068
_02163058:
	mov r0, #0x2800
	str r0, [r4, #0x23c]
	sub r0, r0, #0x6800
	str r0, [r4, #0x240]
_02163068:
	cmp r3, #0
	beq _0216307C
	cmp r3, #1
	beq _021630A8
	b _021630D0
_0216307C:
	ldr r3, =0x000003FF
	mov r1, #0
_02163084:
	add r0, r1, #1
	add r2, r4, r1, lsl #1
	mov r1, r0, lsl #0x10
	add r0, r2, #0x100
	mov r1, r1, lsr #0x10
	strh r3, [r0, #0x70]
	cmp r1, #0x1e
	blo _02163084
	b _021630D0
_021630A8:
	ldr r3, =0x00007C1F
	mov r1, #0
_021630B0:
	add r0, r1, #1
	add r2, r4, r1, lsl #1
	mov r1, r0, lsl #0x10
	add r0, r2, #0x100
	mov r1, r1, lsr #0x10
	strh r3, [r0, #0x70]
	cmp r1, #0x1e
	blo _021630B0
_021630D0:
	mov r0, #0x1d
	mov r1, #0xc
_021630D8:
	mla r6, r0, r1, r4
	ldr r2, [r6, #-0x10]
	mov r3, r0, lsr #0x1f
	str r2, [r6, #8]
	ldr lr, [r4, #0x240]
	ldr ip, [r6, #-0xc]
	rsb r2, r3, r0, lsl #31
	add ip, lr, ip
	str ip, [r6, #0xc]
	ldr ip, [r6, #-8]
	adds r2, r3, r2, ror #31
	str ip, [r6, #0x10]
	bne _02163138
	add r3, r4, r0, lsl #2
	cmp r0, #0xa
	ldr r2, [r3, #0x1a4]
	bhs _0216312C
	cmp r2, #0x1d
	addlt r2, r2, #2
	strlt r2, [r3, #0x1ac]
	b _02163138
_0216312C:
	cmp r2, #0
	subgt r2, r2, #2
	strgt r2, [r3, #0x1ac]
_02163138:
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #4
	bhs _021630D8
	ldr r0, [r4, #0x23c]
	mov r1, #0x2000
	bl FX_Div
	ldr r2, [r4, #8]
	mov r1, #0x2000
	sub r0, r2, r0
	str r0, [r4, #0x20]
	ldr r2, [r4, #0xc]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x10]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x1ac]
	str r0, [r4, #0x1b4]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r1, [r4, #0x14]
	mov r2, #0xf
	add r0, r1, r0
	str r0, [r4, #0x2c]
	ldr r3, [r4, #0x18]
	ldr r0, [r4, #0x240]
	mov r1, #0x2000
	add r0, r3, r0
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x1c]
	str r0, [r4, #0x34]
	ldr r0, [r4, #0x1b0]
	str r0, [r4, #0x1b8]
	str r2, [r4, #0x1ac]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r2, [r5, #0]
	mov r1, #0x2000
	sub r0, r2, r0
	str r0, [r4, #8]
	ldr r2, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r2, r0
	str r0, [r4, #0xc]
	ldr r0, [r5, #8]
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x23c]
	bl FX_Div
	ldr r1, [r5, #0]
	add r0, r1, r0
	str r0, [r4, #0x14]
	ldr r1, [r5, #4]
	ldr r0, [r4, #0x240]
	add r0, r1, r0
	str r0, [r4, #0x18]
	ldr r0, [r5, #8]
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x1ac]
	str r0, [r4, #0x1b0]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Trail__ProcessRequest(EX_ACTION_TRAIL_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x118
	ldr r1, =0x02176444
	mov r4, r0
	ldrh r0, [r1, #0]
	add r9, r4, #0x1c
	cmp r0, #0xa
	addlo r0, r0, #1
	addlo sp, sp, #0x118
	strloh r0, [r1]
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl Camera3D__GetTask
	cmp r0, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r2, sp, #0x64
	add r3, sp, #0x34
	add r0, r9, #8
	mov r1, #0x1e
	bl Unknown2066510__Func_2066D18
	ldrb r0, [r4, #0x26c]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq r5, r4, #0x274
	addeq r6, r4, #0x318
	beq _021632B4
	bl exDrawFadeTask__GetUnknownA
	mov r5, r0
	bl exDrawFadeTask__GetUnknownB
	mov r6, r0
_021632B4:
	cmp r5, #0
	cmpne r6, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r0, [r4, #0x26c]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _021632F8
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021632EC
	mov r0, r5
	bl Camera3D__LoadState
	b _0216333C
_021632EC:
	mov r0, r6
	bl Camera3D__LoadState
	b _0216333C
_021632F8:
	cmp r0, #1
	bne _0216331C
	bl Camera3D__UseEngineA
	cmp r0, #0
	addne sp, sp, #0x118
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r6
	bl Camera3D__LoadState
	b _0216333C
_0216331C:
	cmp r0, #2
	bne _0216333C
	bl Camera3D__UseEngineA
	cmp r0, #0
	addeq sp, sp, #0x118
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl Camera3D__LoadState
_0216333C:
	bl NNS_G3dGlbFlushVP
	mov r3, #0x20000000
	add r1, sp, #0x30
	mov r0, #0x2a
	mov r2, #1
	str r3, [sp, #0x30]
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	add r1, sp, #0x2c
	mov r0, #0x10
	str r2, [sp, #0x2c]
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x34
	mov r0, #0x17
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r11, #6
	add r6, r4, #0x200
	ldr r5, =0x000003FF
	mov r8, #0
	add r7, sp, #0x64
	mov r4, r11
_02163394:
	add r0, r9, r8, lsl #2
	ldr r1, [r0, #0x1ac]
	cmp r1, #0
	ble _021635BC
	ldrh r0, [r6, #0x64]
	cmp r0, #1
	beq _021633C4
	cmp r0, #2
	beq _0216340C
	cmp r0, #3
	beq _02163454
	b _02163498
_021633C4:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x8c0
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x28]
	add r1, sp, #0x28
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x24
	str r2, [sp, #0x24]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02163498
_0216340C:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x880
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x20]
	add r1, sp, #0x20
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x1c
	str r2, [sp, #0x1c]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02163498
_02163454:
	ldr r2, [r9, #0x24c]
	mov r0, #0x29
	mov r2, r2, lsl #0x18
	orr r2, r2, #0x880
	orr r1, r2, r1, lsl #16
	str r1, [sp, #0x18]
	add r1, sp, #0x18
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, r8, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0x70]
	mov r0, #0x20
	add r1, sp, #0x14
	str r2, [sp, #0x14]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_02163498:
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, #0x40
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mul r0, r8, r11
	add r3, r7, r0
	ldrsh r1, [r7, r0]
	ldrsh r0, [r3, #2]
	ldrsh r2, [r3, #4]
	and r1, r5, r1, asr #6
	mov r0, r0, asr #6
	mov r2, r2, asr #6
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #12
	mov r2, r2, lsl #0x16
	orr r0, r0, r2, lsr #2
	str r0, [sp, #0xc]
	mov r0, #0x24
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mla r10, r8, r4, r7
	ldrsh r1, [r10, #8]
	ldrsh r0, [r10, #0xa]
	ldrsh r2, [r10, #6]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp, #8]
	mov r0, #0x24
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldrsh r1, [r10, #0x14]
	ldrsh r0, [r10, #0x16]
	ldrsh r2, [r10, #0x12]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp, #4]
	mov r0, #0x24
	add r1, sp, #4
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldrsh r1, [r10, #0xe]
	ldrsh r0, [r10, #0x10]
	ldrsh r2, [r10, #0xc]
	mov r1, r1, asr #6
	mov r0, r0, asr #6
	and r2, r5, r2, asr #6
	mov r1, r1, lsl #0x16
	orr r1, r2, r1, lsr #12
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #2
	str r0, [sp]
	mov r0, #0x24
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x41
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
_021635BC:
	add r0, r8, #2
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x1c
	blo _02163394
	add sp, sp, #0x118
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__InitWorker(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x134
	bl MIi_CpuClear16
	mov r1, #0
	strh r1, [r4]
	add r0, r4, #0x100
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	strh r1, [r0, #0xc]
	str r1, [r4, #0x110]
	str r1, [r4, #0x114]
	str r1, [r4, #0x118]
	mov r0, #0x1000
	str r0, [r4, #0x11c]
	str r0, [r4, #0x120]
	str r0, [r4, #0x124]
	str r1, [r4, #0x128]
	str r1, [r4, #0x12c]
	str r1, [r4, #0x130]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__InitConfig(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrb r2, [r0, #0]
	mov r1, #0
	bic r3, r2, #3
	and r2, r3, #0xff
	bic ip, r2, #4
	and r2, ip, #0xff
	bic r3, r2, #8
	and r2, r3, #0xff
	strb ip, [r0]
	bic r2, r2, #0xf0
	strb r2, [r0]
	ldrb r2, [r0, #1]
	bic lr, r2, #1
	and r2, lr, #0xff
	bic ip, r2, #2
	and r2, ip, #0xff
	bic r3, r2, #4
	and r2, r3, #0xff
	orr r2, r2, #8
	strb lr, [r0, #1]
	bic r2, r2, #0x10
	strb r2, [r0, #1]
	ldrb r2, [r0, #2]
	bic r2, r2, #2
	strb r2, [r0, #2]
	ldrb r2, [r0, #1]
	bic r2, r2, #0xe0
	orr r2, r2, #0x60
	strb r2, [r0, #1]
	strh r1, [r0, #4]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__InitSprite3D(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl exDrawReqTask__Sprite3D__InitWorker
	mov r0, r4
	bl exHitCheckTask_InitHitChecker
	add r0, r4, #0x150
	bl exDrawReqTask__Sprite3D__InitConfig
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__HandleTransform(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x90
	mov r4, r0
	add r0, r4, #0x100
	ldrh r1, [r0, #8]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, r4, #0x100
	ldrh r1, [r0, #0xa]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x48
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, r4, #0x100
	ldrh r1, [r0, #0xc]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x6c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotZ33_
	add r0, sp, #0x48
	add r1, sp, #0x24
	add r2, sp, #0
	bl MTX_Concat33
	add r0, sp, #0x6c
	add r1, sp, #0
	add r2, r4, #0x28
	bl MTX_Concat33
	ldr r0, [r4, #0x110]
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x114]
	str r0, [r4, #0x50]
	ldr r0, [r4, #0x118]
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x11c]
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x120]
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x124]
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x128]
	str r0, [r4, #0x58]
	ldr r0, [r4, #0x12c]
	str r0, [r4, #0x5c]
	ldr r0, [r4, #0x130]
	str r0, [r4, #0x60]
	add sp, sp, #0x90
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__HandlePriority(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x150]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addeq r4, r6, #0x158
	addeq r5, r6, #0x1fc
	beq _02163824
	bl exDrawFadeTask__GetUnknownA
	mov r4, r0
	bl exDrawFadeTask__GetUnknownB
	mov r5, r0
_02163824:
	ldrb r0, [r6, #4]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	bne _02163850
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02163850
	ldrb r0, [r6, #2]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02163890
_02163850:
	ldr r1, [r6, #0x130]
	ldr r0, =0x00024C04
	cmp r1, r0
	ble _02163870
	ldrb r0, [r6, #0x150]
	bic r0, r0, #3
	orr r0, r0, #2
	strb r0, [r6, #0x150]
_02163870:
	ldr r1, [r6, #0x130]
	ldr r0, =0x00024C04
	cmp r1, r0
	bgt _02163890
	ldrb r0, [r6, #0x150]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r6, #0x150]
_02163890:
	ldrb r0, [r6, #0x150]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	bne _021638C4
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021638B8
	mov r0, r4
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_021638B8:
	mov r0, r5
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_021638C4:
	cmp r0, #1
	bne _021638F4
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021638E4
	mov r0, r5
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}
_021638E4:
	ldrb r0, [r6, #0x150]
	orr r0, r0, #4
	strb r0, [r6, #0x150]
	ldmia sp!, {r4, r5, r6, pc}
_021638F4:
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldreqb r0, [r6, #0x150]
	orreq r0, r0, #4
	streqb r0, [r6, #0x150]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl exDrawFadeUnknown__Func_21610F0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__HandleUnknown(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =_mt_math_rand
	mov r5, r0
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldrb ip, [r5, #0x150]
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
	bl exHitCheckTask_IsPaused
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl exDrawReqTask__Func_2164260
	ldrb r0, [r0, #0]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	beq _021639F8
	bl exDrawReqTask__Func_2164260
	bl exDrawReqTask__Func_21642BC
	bl exDrawReqTask__Func_2164260
	ldrb r0, [r0, #0]
	ldrb r1, [r5, #0x150]
	ldr r2, =_mt_math_rand
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1c
	bic r1, r1, #0xf0
	mov r0, r0, lsl #0x1c
	orr r4, r1, r0, lsr #24
	strb r4, [r5, #0x150]
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	and ip, r4, #0xff
	mla r4, r3, r0, r1
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	mov r3, ip, lsl #0x18
	add r0, r1, r0, ror #31
	add r0, r0, r3, lsr #28
	str r4, [r2]
	mov r4, r0, lsl #7
_021639F8:
	ldrb r0, [r5, #0x150]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1c
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x68]
	ldr r2, =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x68]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x6c]
	ldr r2, =_mt_math_rand
	addne r0, r0, r4
	subeq r0, r0, r4
	str r0, [r5, #0x6c]
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str ip, [r2]
	adds r0, r1, r0, ror #31
	ldr r0, [r5, #0x70]
	addne r0, r0, r4
	strne r0, [r5, #0x70]
	subeq r0, r0, r4
	streq r0, [r5, #0x70]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__Animate(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0x151]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02163B0C
	mov r0, #1
	strh r0, [r4, #0xc0]
	mov r1, #0
	add r0, r4, #0x150
	str r1, [r4, #0xe0]
	bl exDrawReqTask__Func_2164238
_02163B0C:
	ldrb r0, [r4, #0x151]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x20
	bl AnimatorSprite3D__ProcessAnimation
	ldrb r0, [r4, #0x151]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r4, pc}
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x150
	bl exDrawReqTask__Func_2164238
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__Draw(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0x150]
	mov r1, r0, lsl #0x1d
	movs r1, r1, lsr #0x1f
	bicne r0, r0, #4
	strneb r0, [r4, #0x150]
	ldmneia sp!, {r4, pc}
	ldr r2, =0x04000060
	add r0, r4, #0x20
	ldrh r1, [r2, #0]
	bic r1, r1, #0x3000
	orr r1, r1, #8
	strh r1, [r2]
	bl AnimatorSprite3D__Draw
	ldr r0, [r4, #0x12c]
	str r0, [r4, #0x68]
	ldr r0, [r4, #0x130]
	str r0, [r4, #0x6c]
	ldr r0, [r4, #0x134]
	str r0, [r4, #0x70]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Sprite3D__ProcessRequest(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1c
	bl exDrawReqTask__Sprite3D__HandleTransform
	bl exDrawReqTask__EntryUnknown2__GetLightConfig
	bl exDrawReqTask__EntryUnknown2__SetLight
	mov r0, r4
	bl exDrawReqTask__Sprite3D__HandleUnknown
	mov r0, r4
	bl exDrawReqTask__Sprite3D__HandlePriority
	mov r0, r4
	bl exDrawReqTask__Sprite3D__Draw
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exDrawReqTask__Sprite3D__IsAnimFinished(EX_ACTION_BAC3D_WORK *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, [r0, #0xec]
	tst r0, #0x40000000
	movne r0, #1
	moveq r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0
	str r1, [r0]
	bl GetExTaskCurrent
	ldr r1, =exDrawFadeTask__Main_2163C48
	str r1, [r0]
	bl exDrawFadeTask__Main_2163C48
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeTask__Func8(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =GetExTaskWorkCurrent_
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeTask__Destructor(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =GetExTaskWorkCurrent_
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeTask__Main_2163C48(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrh r0, [r4, #4]
	add r0, r0, #1
	strh r0, [r4, #4]
	ldrh r1, [r4, #4]
	ldrh r0, [r4, #0xc]
	subs r5, r1, r0
	ldmmiia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0]
	ldrsh r6, [r4, #6]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4]
	beq _02163CA0
	ldrsh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	sub r0, r0, r6
	mul r0, r5, r0
	bl _s32_div_f
	add r6, r6, r0
_02163CA0:
	ldrh r0, [r4, #0xe]
	tst r0, #1
	beq _02163CC8
	mvn r0, #0xf
	cmp r6, r0
	movlt r6, r0
	cmp r6, #0x10
	movgt r6, #0x10
	bl Camera3D__GetWork
	strh r6, [r0, #0x58]
_02163CC8:
	ldrh r0, [r4, #0xe]
	tst r0, #2
	beq _02163CF0
	mvn r0, #0xf
	cmp r6, r0
	movlt r6, r0
	cmp r6, #0x10
	movgt r6, #0x10
	bl Camera3D__GetWork
	strh r6, [r0, #0xb4]
_02163CF0:
	ldrh r0, [r4, #0xa]
	cmp r5, r0
	blt _02163D3C
	ldrh r0, [r4, #0xe]
	tst r0, #1
	beq _02163D14
	bl Camera3D__GetWork
	ldrsh r1, [r4, #8]
	strh r1, [r0, #0x58]
_02163D14:
	ldrh r0, [r4, #0xe]
	tst r0, #2
	beq _02163D2C
	bl Camera3D__GetWork
	ldrsh r1, [r4, #8]
	strh r1, [r0, #0xb4]
_02163D2C:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, pc}
_02163D3C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawFadeTask__Create(s32 brightness, s32 targetBrightness, s32 duration, s32 delay, u32 flags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x10
	movs r6, r2
	mov r8, r0
	mov r7, r1
	mov r5, r3
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0
	str r4, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	ldr r0, =aExdrawfadetask
	ldr r1, =exDrawFadeTask__Destructor
	str r0, [sp, #8]
	ldr r0, =exDrawFadeTask__Main
	mov r2, #0xf000
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r9, r0
	bl GetExTaskWork_
	mov r1, r4
	mov r2, #0x10
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r9
	bl GetExTask
	ldr r2, =exDrawFadeTask__Func8
	mvn r1, #0xf
	cmp r8, r1
	movlt r8, r1
	str r2, [r0, #8]
	cmp r8, #0x10
	movgt r8, #0x10
	mvn r0, #0xf
	cmp r7, r0
	movlt r8, r0
	mov r0, #0
	cmp r7, #0x10
	strh r0, [r4, #4]
	movgt r8, #0x10
	strh r8, [r4, #6]
	strh r7, [r4, #8]
	strh r6, [r4, #0xa]
	ldrh r0, [sp, #0x30]
	strh r5, [r4, #0xc]
	strh r0, [r4, #0xe]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, =0x00076200
	bl _AllocHeadHEAP_USER
	ldr r1, =exDrawReqTask__word_217644C
	str r0, [r1, #0xc]
	bl exDrawReqTask__Func_21641C8
	ldr r0, [r4, #4]
	bl exDrawReqTask__InitUnknown2
	bl exDrawReqTask__InitUnknown3
	bl GetExTaskCurrent
	ldr r1, =exDrawReqTask__Main_Process
	str r1, [r0]
	bl exDrawReqTask__Main_Process
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, =exDrawReqTask__word_217644C
	ldr r0, [r0, #0xc]
	bl _FreeHEAP_USER
	ldr r0, =exDrawReqTask__word_217644C
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Main_Process(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, =exDrawReqTask__word_217644C
	mov r4, r0
	ldr r1, [r1, #8]
	str r1, [r4, #4]
	cmp r1, #0
	beq _02163F74
_02163EE4:
	ldrh r0, [r1, #0]
	cmp r0, #0
	ldrneh r0, [r1, #2]
	cmpne r0, #0
	ldrne r0, [r1, #0xc]
	cmpne r0, #0
	ldrneh r0, [r1, #4]
	cmpne r0, #0
	beq _02163F74
	cmp r0, #2
	bne _02163F20
	add r0, r1, #0x38c
	add r0, r0, #0x400
	bl exDrawReqTask__Sprite2D__ProcessRequest
	b _02163F60
_02163F20:
	cmp r0, #1
	bne _02163F34
	add r0, r1, #0x10
	bl exDrawReqTask__Model__ProcessRequest
	b _02163F60
_02163F34:
	cmp r0, #3
	bne _02163F4C
	add r0, r1, #0xec
	add r0, r0, #0x400
	bl exDrawReqTask__Sprite3D__ProcessRequest
	b _02163F60
_02163F4C:
	cmp r0, #4
	bne _02163F60
	add r0, r1, #0x14
	add r0, r0, #0x800
	bl exDrawReqTask__Trail__ProcessRequest
_02163F60:
	ldr r0, [r4, #4]
	ldr r1, [r0, #8]
	str r1, [r4, #4]
	cmp r1, #0
	bne _02163EE4
_02163F74:
	bl exHitCheckTask_IsPaused
	cmp r0, #0
	beq _02163F8C
	mov r0, #1
	bl EnableExTaskNoUpdate
	b _02163FA4
_02163F8C:
	mov r0, #0
	bl EnableExTaskNoUpdate
	ldr r0, [r4, #4]
	bl exDrawReqTask__InitUnknown2
	bl exDrawReqTask__Func_21641C8
	bl exPlayerHelpers__Func_2152CB4
_02163FA4:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Create(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r0, #0
	str r0, [sp]
	mov r0, #8
	ldr r3, =aExdrawreqtask
	str r0, [sp, #4]
	ldr r0, =exDrawReqTask__Main
	ldr r1, =exDrawReqTask__Destructor
	ldr r2, =0x0000EFFE
	str r3, [sp, #8]
	mov r4, #1
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, =exDrawReqTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__AddRequest(void *work, exDrawReqTaskConfig *config)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	bl CheckExStageFinished
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, =0x0217644C
	ldrh r1, [r0, #0]
	cmp r1, #0xa0
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r1, [r7, #1]
	ldr r6, [r0, #4]
	ldr r4, [r0, #8]
	mov r0, r1, lsl #0x18
	mov r0, r0, lsr #0x1d
	strh r0, [r6, #4]
	ldrh r1, [r6, #4]
	mov r0, r8
	ldr r5, =0x02176454
	bl exHitCheckTask_DoArenaBoundsCheck
	ldrh r0, [r6, #4]
	cmp r0, #2
	bne _021640A8
	add r1, r6, #0x38c
	mov r0, r8
	add r1, r1, #0x400
	mov r2, #0x88
	bl MI_CpuCopy8
	b _02164100
_021640A8:
	cmp r0, #1
	bne _021640C4
	ldr r2, =0x000004DC
	mov r0, r8
	add r1, r6, #0x10
	bl MI_CpuCopy8
	b _02164100
_021640C4:
	cmp r0, #3
	bne _021640E4
	add r1, r6, #0xec
	mov r0, r8
	add r1, r1, #0x400
	mov r2, #0x2a0
	bl MI_CpuCopy8
	b _02164100
_021640E4:
	cmp r0, #4
	bne _02164100
	add r1, r6, #0x14
	mov r0, r8
	add r1, r1, #0x800
	mov r2, #0x3bc
	bl MI_CpuCopy8
_02164100:
	ldr r0, =0x0217644C
	cmp r4, #0
	ldrh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	ldrh r0, [r0, #0]
	strh r0, [r6]
	ldrh r0, [r7, #4]
	strh r0, [r6, #2]
	str r8, [r6, #0xc]
	beq _0216414C
	ldrh r1, [r6, #2]
_02164130:
	ldrh r0, [r4, #2]
	cmp r1, r0
	bhs _0216414C
	add r5, r4, #8
	ldr r4, [r4, #8]
	cmp r4, #0
	bne _02164130
_0216414C:
	str r6, [r5]
	ldr r0, =0x0217644C
	str r4, [r6, #8]
	ldr r1, [r0, #4]
	add r1, r1, #0xbd0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__InitUnknown2(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, =0x0217644C
	mov r6, #0
	mov r4, #0xbd0
_02164184:
	ldr r0, [r5, #0xc]
	mla r0, r6, r4, r0
	bl exDrawReqTask__InitRequest
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xa0
	blo _02164184
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__InitRequest(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #0
	strh r1, [r0]
	strh r1, [r0, #2]
	strh r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_21641C8(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =0x0217644C
	mov r1, #0
	ldr r2, [r0, #0xc]
	str r2, [r0, #4]
	str r1, [r0, #8]
	strh r1, [r0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__SetConfigPriority(exDrawReqTaskConfig *work, u16 priority){
#ifdef NON_MATCHING

#else
    // clang-format off
	strh r1, [r0, #4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_21641F0(exDrawReqTaskConfig *config){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldrb r1, [r0, #1]
	orr r2, r1, #4
	bic r3, r2, #2
	and r1, r3, #0xff
	bic r2, r1, #8
	and r1, r2, #0xff
	strb r3, [r0, #1]
	bic r1, r1, #0x10
	strb r1, [r0, #1]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_2164218(exDrawReqTaskConfig *config){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldrb r1, [r0, #1]
	orr r3, r1, #4
	bic r2, r3, #2
	and r1, r2, #0xff
	orr r1, r1, #8
	bic r1, r1, #0x10
	strb r1, [r0, #1]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_2164238(exDrawReqTaskConfig *config){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldrb r1, [r0, #1]
	bic r2, r1, #4
	and r1, r2, #0xff
	orr r1, r1, #2
	bic r2, r1, #8
	strb r1, [r0, #1]
	and r1, r2, #0xff
	bic r1, r1, #0x10
	strb r1, [r0, #1]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_2164260(exDrawReqTaskConfig *config){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =0x0217645C
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__InitUnknown3(exDrawReqTaskConfig *config){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =MI_CpuFill8
	ldr r0, =0x0217645C
	mov r1, #0
	mov r2, #6
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_2164288(exDrawReqTaskConfig *config)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r4, #0xf
	movhi r0, #0
	ldmhiia sp!, {r4, pc}
	bl exDrawReqTask__Func_2164260
	ldrb r2, [r0, #0]
	mov r1, r4, lsl #0x1c
	bic r2, r2, #0xf0
	orr r1, r2, r1, lsr #24
	strb r1, [r0]
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_21642BC(exDrawReqTaskConfig *config){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldrb r2, [r0, #0]
	mov r1, r2, lsl #0x18
	movs r1, r1, lsr #0x1c
	moveq r0, #1
	bxeq lr
	add r1, r1, #0xff
	and r1, r1, #0xff
	bic r2, r2, #0xf0
	mov r1, r1, lsl #0x1c
	orr r1, r2, r1, lsr #24
	strb r1, [r0]
	mov r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exDrawReqTask__Func_21642F0(exDrawReqTaskConfig *config, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	cmp r1, #7
	bxhi lr
	ldrb r2, [r0, #2]
	mov r1, r1, lsl #0x1d
	bic r2, r2, #0x1c
	orr r1, r2, r1, lsr #27
	strb r1, [r0, #2]
	bx lr

// clang-format on
#endif
}
