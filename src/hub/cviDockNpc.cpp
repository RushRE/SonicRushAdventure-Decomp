#include <hub/cviDockNpc.hpp>
#include <hub/dockHelpers.h>
#include <game/util/cppHelpers.hpp>
#include <game/file/bundleFileUnknown.h>

// resources
#include <resources/bb/vi_npc.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CVIDOCKNPC_RESOURCE_NONE (u8)(-1)

// --------------------
// ENUMS
// --------------------

enum CViDockNpcResCommonID
{
    CVIDOCKNPC_RESCMN_BLAZE,
    CVIDOCKNPC_RESCMN_TAILS,
    CVIDOCKNPC_RESCMN_MARINE,
    CVIDOCKNPC_RESCMN_NORMAN,
    CVIDOCKNPC_RESCMN_SETTER,
    CVIDOCKNPC_RESCMN_TABBY,
    CVIDOCKNPC_RESCMN_COLONEL,
    CVIDOCKNPC_RESCMN_GARDON,
    CVIDOCKNPC_RESCMN_DAIKUN,
    CVIDOCKNPC_RESCMN_KYLOK,
    CVIDOCKNPC_RESCMN_MUZY,
    CVIDOCKNPC_RESCMN_HOURGLASS,
    CVIDOCKNPC_RESCMN_OLDDS,
};

enum CViDockNpcResTexAniID
{
    CVIDOCKNPC_RESTEXANI_HOURGLASS,
};

enum CViDockNpcResMatAniID
{
    CVIDOCKNPC_RESMATANI_OLDDS,
};

enum CViDockNpcUnknownID
{
    CVIDOCKNPC_SIZE_REGULAR,
    CVIDOCKNPC_SIZE_BIG,
};

// --------------------
// STRUCTS
// --------------------

struct ViDockNpcAssetInfo
{
    u8 modelIndex;
    u8 animIndex;
    u8 materialAnim;
    u8 visibilityAnim;
    u8 textureAnim;
    u8 ani2_1;
    u8 ani1_1;
    u8 unknownID;
    u8 ani2_Tail;
    u8 ani1_Tail;
    u8 __padding1;
    u8 __padding2;
};

struct CViDockNpcAssetBundle
{
    const char path[16];
    u32 unknown;
};

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void *_ZTV10CViDockNpc;

NOT_DECOMPILED void _ZdlPv(void);
}

// --------------------
// VARIABLES
// --------------------

static const u16 resMatAnimFileTable[] = { BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_OLD_DS_NSBMA };

static const VecFx32 npcHitboxSizeTable[] = {
    { FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(6.0) },   // Regular
    { FLOAT_TO_FX32(12.0), FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(12.0) }, // Big
};

static const u16 resModelFileTable[] = {
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_BLZ_NSBMD,       // Blaze
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_TAILS_NSBMD,     // Tails
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_MARINE_NSBMD,    // Marine
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_VIKING_NSBMD,    // Norman
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_SETTER_NSBMD,    // Setter
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_TABBY_NSBMD,     // Tabby
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_COLONEL_NSBMD,   // Colonel
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_GARDON_NSBMD,    // Gardon
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_DAIKUN_NSBMD,    // Daikun
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_KYLOK_NSBMD,     // Kylok
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_MUZY_NSBMD,      // Muzy
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_HOURGLASS_NSBMD, // Hourglass
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_OLD_DS_NSBMD,    // OldDS
};

static const u16 resJointAnimFileTable[] = {
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_BLZ_NSBCA,       // Blaze
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_TAILS_NSBCA,     // Tails
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_MARINE_NSBCA,    // Marine
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_VIKING_NSBCA,    // Norman
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_SETTER_NSBCA,    // Setter
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_TABBY_NSBCA,     // Tabby
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_COLONEL_NSBCA,   // Colonel
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_GARDON_NSBCA,    // Gardon
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_DAIKUN_NSBCA,    // Daikun
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_KYLOK_NSBCA,     // Kylok
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_MUZY_NSBCA,      // Muzy
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_HOURGLASS_NSBCA, // Hourglass
    BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_OLD_DS_NSBCA,    // OldDS
};

static const struct ViDockNpcAssetInfo resConfigFileTable[] = {
    // Blaze
    { CVIDOCKNPC_RESCMN_BLAZE, CVIDOCKNPC_RESCMN_BLAZE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_TALK,
      CVIDOCKNPC_SIZE_REGULAR, CViDockNpc::ANI_TAIL_IDLE, CViDockNpc::ANI_TAIL_TALK, 0, 0 },

    // Tails
    { CVIDOCKNPC_RESCMN_TAILS, CVIDOCKNPC_RESCMN_TAILS, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_TALK,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Marine
    { CVIDOCKNPC_RESCMN_MARINE, CVIDOCKNPC_RESCMN_MARINE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_TALK,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Norman
    { CVIDOCKNPC_RESCMN_NORMAN, CVIDOCKNPC_RESCMN_NORMAN, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_BIG, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Setter
    { CVIDOCKNPC_RESCMN_SETTER, CVIDOCKNPC_RESCMN_SETTER, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Tabby
    { CVIDOCKNPC_RESCMN_TABBY, CVIDOCKNPC_RESCMN_TABBY, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Colonel
    { CVIDOCKNPC_RESCMN_COLONEL, CVIDOCKNPC_RESCMN_COLONEL, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE,
      CViDockNpc::ANI_IDLE, CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Gardon
    { CVIDOCKNPC_RESCMN_GARDON, CVIDOCKNPC_RESCMN_GARDON, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Daikun
    { CVIDOCKNPC_RESCMN_DAIKUN, CVIDOCKNPC_RESCMN_DAIKUN, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Kylok
    { CVIDOCKNPC_RESCMN_KYLOK, CVIDOCKNPC_RESCMN_KYLOK, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Muzy
    { CVIDOCKNPC_RESCMN_MUZY, CVIDOCKNPC_RESCMN_MUZY, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // Hourglass
    { CVIDOCKNPC_RESCMN_HOURGLASS, CVIDOCKNPC_RESCMN_HOURGLASS, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESTEXANI_HOURGLASS, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE,
      CViDockNpc::ANI_IDLE, CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },

    // OldDS
    { CVIDOCKNPC_RESCMN_OLDDS, CVIDOCKNPC_RESCMN_OLDDS, CVIDOCKNPC_RESMATANI_OLDDS, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, CViDockNpc::ANI_IDLE, CViDockNpc::ANI_IDLE,
      CVIDOCKNPC_SIZE_REGULAR, CVIDOCKNPC_RESOURCE_NONE, CVIDOCKNPC_RESOURCE_NONE, 0, 0 },
};

// TODO: uncomment this when all funcs are decompiled, until then it doesn't seem like the variables want to to align properly?
// static const CViDockNpcAssetBundle dockNpcAssets[1] = { { "bb/vi_npc.bb", 0x400 } };
extern const CViDockNpcAssetBundle dockNpcAssets[1];

// --------------------
// FUNCTIONS
// --------------------

// NONMATCH_FUNC CViDockNpc::CViDockNpc()
NONMATCH_FUNC void _ZN10CViDockNpcC1Ev(CViDockNpc *work)
{
#ifdef NON_MATCHING
    this->model         = NULL;
    this->aniJoints     = NULL;
    this->aniMaterial   = NULL;
    this->aniVisibility = NULL;
    this->aniTexture    = NULL;
    ViDockNpc__ReleaseAssets(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN11CVi3dObjectC1Ev
	ldr r0, =_ZTV10CViDockNpc+0x08
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x314]
	str r1, [r4, #0x318]
	str r1, [r4, #0x31c]
	str r1, [r4, #0x320]
	mov r0, r4
	str r1, [r4, #0x324]
	bl ViDockNpc__ReleaseAssets
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// NONMATCH_FUNC CViDockNpc::~CViDockNpc()
NONMATCH_FUNC void _ZN10CViDockNpcD0Ev(CViDockNpc *work)
{
#ifdef NON_MATCHING
    ViDockNpc__ReleaseAssets(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpc__ReleaseAssets
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// NONMATCH_FUNC CViDockNpc::~CViDockNpc()
NONMATCH_FUNC void _ZN10CViDockNpcD1Ev(CViDockNpc *work)
{
#ifdef NON_MATCHING
    ViDockNpc__ReleaseAssets(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpc__ReleaseAssets
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void ViDockNpc__LoadAssets(CViDockNpc *work, s32 type, VecFx32 *position, u16 angle, BOOL snapToAngle)
{
    ViDockNpc__ReleaseAssets(work);

    work->npcType             = type;
    work->resConfigTableIndex = DockHelpers__GetNpcConfig(type)->field_0;

    const ViDockNpcAssetInfo *config = &resConfigFileTable[work->resConfigTableIndex];

    work->model     = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resModelFileTable[config->modelIndex], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);
    work->aniJoints = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resJointAnimFileTable[config->animIndex], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    if (config->materialAnim != CVIDOCKNPC_RESOURCE_NONE)
        work->aniMaterial = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resMatAnimFileTable[config->materialAnim], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    // NOTE: is this bugged? shouldn't it utilise a unique table instead of 'resMatAnimFileTable'?
    if (config->visibilityAnim != CVIDOCKNPC_RESOURCE_NONE)
        work->aniVisibility = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resMatAnimFileTable[config->visibilityAnim], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    // NOTE: is this bugged? shouldn't it utilise a unique table instead of 'resMatAnimFileTable'?
    if (config->textureAnim != CVIDOCKNPC_RESOURCE_NONE)
        work->aniTexture = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resMatAnimFileTable[config->textureAnim], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    work->size = npcHitboxSizeTable[config->unknownID];

    if (config->ani2_Tail == CVIDOCKNPC_RESOURCE_NONE)
    {
        work->Func_216763C(work->model, 0, FALSE, FALSE, work->aniJoints, NULL, work->aniMaterial, work->aniTexture, work->aniVisibility, 0xFFFF);
        work->Func_2167900(config->ani2_1, TRUE, FALSE, FALSE, FALSE);
    }
    else
    {
        work->Func_216763C(work->model, 0, FALSE, FALSE, work->aniJoints, NULL, work->aniMaterial, work->aniTexture, work->aniVisibility, 1);
        work->Func_2167900(config->ani2_1, TRUE, FALSE, FALSE, FALSE);
        work->Func_2167958(config->ani2_Tail, TRUE, FALSE, FALSE, FALSE);
    }

    if (work->aniMaterial != NULL)
        work->Func_21679B0(0, TRUE, FALSE, FALSE, FALSE);

    if (work->aniVisibility != NULL)
        work->Func_2167A80(0, TRUE, FALSE, FALSE, FALSE);

    if (work->aniTexture != NULL)
        work->Func_2167A0C(0, TRUE, FALSE, FALSE, FALSE);

    CPPHelpers__VEC_Copy_Alt(&work->translation1, position);

    work->targetTurnAngle  = angle;
    work->currentTurnAngle = work->targetTurnAngle;
    work->flags |= CVi3dObject::FLAG_1;
    work->turnSpeed    = FLOAT_DEG_TO_IDX(8.0);
    work->initialAngle = angle;
    work->snapToAngle  = snapToAngle;
}

void ViDockNpc__ReleaseAssets(CViDockNpc *work)
{
    work->Func_21677C4();

    if (work->model != NULL)
    {
        HeapFree(HEAP_USER, work->model);
        work->model = NULL;
    }

    if (work->aniJoints != NULL)
    {
        HeapFree(HEAP_USER, work->aniJoints);
        work->aniJoints = NULL;
    }

    if (work->aniMaterial != NULL)
    {
        HeapFree(HEAP_USER, work->aniMaterial);
        work->aniMaterial = NULL;
    }

    if (work->aniVisibility != NULL)
    {
        HeapFree(HEAP_USER, work->aniVisibility);
        work->aniVisibility = NULL;
    }

    if (work->aniTexture != NULL)
    {
        HeapFree(HEAP_USER, work->aniTexture);
        work->aniTexture = NULL;
    }

    work->field_304           = 12;
    work->field_308           = 0;
    work->field_30C           = -1;
    work->size.x              = FLOAT_TO_FX32(0.0);
    work->size.y              = FLOAT_TO_FX32(0.0);
    work->size.z              = FLOAT_TO_FX32(0.0);
    work->initialAngle        = 0;
    work->resConfigTableIndex = ARRAY_COUNT(resConfigFileTable) + 1;
}

void ViDockNpc__SetState1(CViDockNpc *work, u16 angle)
{
    if (work->snapToAngle)
        work->targetTurnAngle = angle;

    work->Func_2167900(resConfigFileTable[work->resConfigTableIndex].ani1_1, TRUE, TRUE, FALSE, FALSE);

    if (resConfigFileTable[work->resConfigTableIndex].ani1_Tail != CVIDOCKNPC_RESOURCE_NONE)
        work->Func_2167958(resConfigFileTable[work->resConfigTableIndex].ani1_Tail, TRUE, TRUE, FALSE, FALSE);
}

void ViDockNpc__SetState2(CViDockNpc *work)
{
    if (work->snapToAngle)
        work->targetTurnAngle = work->initialAngle;

    work->Func_2167900(resConfigFileTable[work->resConfigTableIndex].ani2_1, TRUE, TRUE, FALSE, FALSE);

    if (resConfigFileTable[work->resConfigTableIndex].ani2_Tail != CVIDOCKNPC_RESOURCE_NONE)
        work->Func_2167958(resConfigFileTable[work->resConfigTableIndex].ani2_Tail, TRUE, TRUE, FALSE, FALSE);
}

BOOL ViDockNpc__Func_216710C(CViDockNpc *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *dest, fx32 a5)
{
    *dest = *a3;

    if (a2->x == a3->x && a2->y == a3->y && a2->z == a3->z)
        return FALSE;

    s32 centerX = MultiplyFX(work->size.x, a5);
    s32 centerY = MultiplyFX(work->size.z, a5);
    s32 x1      = CPPHelpers__Func_2085F9C(&work->translation1)->x - centerX;
    s32 x2      = CPPHelpers__Func_2085F9C(&work->translation1)->x + centerX;
    s32 z1      = CPPHelpers__Func_2085F9C(&work->translation1)->z - centerY;
    s32 z2      = CPPHelpers__Func_2085F9C(&work->translation1)->z + centerY;

    if (a3->x <= x1 || a3->x >= x2 || a3->z <= z1 || a3->z >= z2)
        return FALSE;

    if (a2->x <= x1)
    {
        dest->x = x1;
    }
    else if (a2->x >= x2)
    {
        dest->x = x2;
    }
    else if (a2->z <= z1)
    {
        dest->z = z1;
    }
    else if (a2->z >= z2)
    {
        dest->z = z2;
    }

    return TRUE;
}

NONMATCH_FUNC BOOL ViDockNpc__Func_2167244(CViDockNpc *work, VecFx32 *position, s32 a3, s32 a4, BOOL *flag)
{
    // https://decomp.me/scratch/6CdR9 -> 65.06%
#ifdef NON_MATCHING
    s32 x = CPPHelpers__Func_2085F9C(&work->translation1)->x - position->x;
    s32 z = CPPHelpers__Func_2085F9C(&work->translation1)->z - position->z;

    Unknown217305C *config = &npcHitboxSizeTable[resConfigFileTable[work->resConfigTableIndex].unknownID];

    s32 v12 = MultiplyFX(x, x) + MultiplyFX(z, z);
    s32 v13 = MultiplyFX(MATH_MAX(config->field_0, config->field_8), a4);
    s32 v15 = MultiplyFX(v13 + (v13 >> 1), v13 + (v13 >> 1));

    BOOL result = FALSE;

    if (v12 <= v15)
    {
        if (x * SinFX(a3) >= 0 && z * CosFX(a3) < 0)
        {
            if (flag != NULL)
                *flag = FALSE;
        }
        else
        {
            if (flag != NULL)
                *flag = TRUE;
        }
        result = TRUE;
    }

    return result;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r0
	mov r8, r1
	add r0, r9, #8
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	bl CPPHelpers__Func_2085F9C
	ldr r2, [r0, #0]
	ldr r1, [r8, #0]
	add r0, r9, #8
	sub r4, r2, r1
	bl CPPHelpers__Func_2085F9C
	add r2, r9, #0x300
	ldr r10, [r0, #8]
	ldr r0, [r8, #8]
	smull r3, r1, r4, r4
	sub ip, r10, r0
	adds r3, r3, #0x800
	ldrh r2, [r2, #0x12]
	mov r9, #0xc
	smull lr, r0, ip, ip
	mul r8, r2, r9
	ldr r2, =0x021730AF
	mov r3, r3, lsr #0xc
	ldrb r8, [r2, r8]
	adc r2, r1, #0
	adds r1, lr, #0x800
	smulbb r8, r8, r9
	ldr r9, =npcHitboxSizeTable
	adc r10, r0, #0
	mov r1, r1, lsr #0xc
	add lr, r9, r8
	ldr r0, [r9, r8]
	ldr r8, [lr, #8]
	orr r3, r3, r2, lsl #20
	orr r1, r1, r10, lsl #20
	cmp r0, r8
	movlt r0, r8
	add r1, r3, r1
	smull r3, r2, r0, r6
	adds r3, r3, #0x800
	mov r0, #0
	adc r2, r2, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r6, r3, r3, asr #1
	smull r3, r2, r6, r6
	adds r3, r3, #0x800
	adc r2, r2, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r1, r3
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7, asr #4
	mov r2, r0, lsl #1
	ldr r1, =FX_SinCosTable_
	mov r0, r2, lsl #1
	ldrsh r0, [r1, r0]
	add r2, r2, #1
	mov r2, r2, lsl #1
	muls r0, r4, r0
	ldrsh r0, [r1, r2]
	bmi _0216734C
	muls r0, ip, r0
	bpl _0216735C
_0216734C:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
	b _02167368
_0216735C:
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
_02167368:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

BOOL ViDockNpc__Func_216737C(CViDockNpc *work, VecFx32 *position)
{
    UNUSED(position);

    return TRUE;
}
