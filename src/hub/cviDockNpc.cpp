#include <hub/cviDockNpc.hpp>
#include <hub/hubConfig.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/math/cppMath.hpp>
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
    u8 size;
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

NOT_DECOMPILED void _ZN10CViDockNpc7ReleaseEv(void);

NOT_DECOMPILED void _ZNK8CVector317ToConstVecFx32RefEv(void);

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

    this->Release();
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
	bl _ZN10CViDockNpc7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// NONMATCH_FUNC CViDockNpc::~CViDockNpc()
NONMATCH_FUNC void _ZN10CViDockNpcD0Ev(CViDockNpc *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CViDockNpc7ReleaseEv
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
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CViDockNpc7ReleaseEv
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void CViDockNpc::Init(s32 type, VecFx32 &position, u16 angle, BOOL snapToAngle)
{
    this->Release();

    this->npcType = type;
    this->type    = HubConfig__GetNpcConfig(type)->type;

    const ViDockNpcAssetInfo *config = &resConfigFileTable[this->type];

    this->model     = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resModelFileTable[config->modelIndex], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);
    this->aniJoints = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resJointAnimFileTable[config->animIndex], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    if (config->materialAnim != CVIDOCKNPC_RESOURCE_NONE)
        this->aniMaterial = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resMatAnimFileTable[config->materialAnim], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    // NOTE: is this bugged? shouldn't it utilise a unique table instead of 'resMatAnimFileTable'?
    if (config->visibilityAnim != CVIDOCKNPC_RESOURCE_NONE)
        this->aniVisibility = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resMatAnimFileTable[config->visibilityAnim], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    // NOTE: is this bugged? shouldn't it utilise a unique table instead of 'resMatAnimFileTable'?
    if (config->textureAnim != CVIDOCKNPC_RESOURCE_NONE)
        this->aniTexture = BundleFileUnknown__LoadFileFromBundle(dockNpcAssets[0].path, resMatAnimFileTable[config->textureAnim], BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);

    this->size = npcHitboxSizeTable[config->size];

    if (config->ani2_Tail == CVIDOCKNPC_RESOURCE_NONE)
    {
        this->SetResources(this->model, 0, FALSE, FALSE, this->aniJoints, NULL, this->aniMaterial, this->aniTexture, this->aniVisibility, 0xFFFF);
        this->SetJointAnimForBody(config->ani2_1, TRUE, FALSE, FALSE, FALSE);
    }
    else
    {
        this->SetResources(this->model, 0, FALSE, FALSE, this->aniJoints, NULL, this->aniMaterial, this->aniTexture, this->aniVisibility, 1);
        this->SetJointAnimForBody(config->ani2_1, TRUE, FALSE, FALSE, FALSE);
        this->SetJointAnimForTail(config->ani2_Tail, TRUE, FALSE, FALSE, FALSE);
    }

    if (this->aniMaterial != NULL)
        this->SetPatternAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

    if (this->aniVisibility != NULL)
        this->SetVisibilityAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

    if (this->aniTexture != NULL)
        this->SetTextureAnimForBody(0, TRUE, FALSE, FALSE, FALSE);

    this->position = position;

    this->targetTurnAngle  = angle;
    this->currentTurnAngle = this->targetTurnAngle;
    this->flags |= CVi3dObject::FLAG_TURNING;
    this->turnSpeed    = FLOAT_DEG_TO_IDX(8.0);
    this->initialAngle = angle;
    this->snapToAngle  = snapToAngle;
}

void CViDockNpc::Release()
{
    CVi3dObject::Release();

    if (this->model != NULL)
    {
        HeapFree(HEAP_USER, this->model);
        this->model = NULL;
    }

    if (this->aniJoints != NULL)
    {
        HeapFree(HEAP_USER, this->aniJoints);
        this->aniJoints = NULL;
    }

    if (this->aniMaterial != NULL)
    {
        HeapFree(HEAP_USER, this->aniMaterial);
        this->aniMaterial = NULL;
    }

    if (this->aniVisibility != NULL)
    {
        HeapFree(HEAP_USER, this->aniVisibility);
        this->aniVisibility = NULL;
    }

    if (this->aniTexture != NULL)
    {
        HeapFree(HEAP_USER, this->aniTexture);
        this->aniTexture = NULL;
    }

    this->talkActionType  = CVIDOCKNPCTALK_INVALID;
    this->talkActionParam = 0;
    this->talkCount       = -1;
    this->size.x          = FLOAT_TO_FX32(0.0);
    this->size.y          = FLOAT_TO_FX32(0.0);
    this->size.z          = FLOAT_TO_FX32(0.0);
    this->initialAngle    = 0;
    this->type            = ARRAY_COUNT(resConfigFileTable) + 1;
}

void CViDockNpc::SetAngleForTalking(u16 angle)
{
    if (this->snapToAngle)
        this->targetTurnAngle = angle;

    this->SetJointAnimForBody(resConfigFileTable[this->type].ani1_1, TRUE, TRUE, FALSE, FALSE);

    if (resConfigFileTable[this->type].ani1_Tail != CVIDOCKNPC_RESOURCE_NONE)
        this->SetJointAnimForTail(resConfigFileTable[this->type].ani1_Tail, TRUE, TRUE, FALSE, FALSE);
}

void CViDockNpc::SetAngleForIdle()
{
    if (this->snapToAngle)
        this->targetTurnAngle = this->initialAngle;

    this->SetJointAnimForBody(resConfigFileTable[this->type].ani2_1, TRUE, TRUE, FALSE, FALSE);

    if (resConfigFileTable[this->type].ani2_Tail != CVIDOCKNPC_RESOURCE_NONE)
        this->SetJointAnimForTail(resConfigFileTable[this->type].ani2_Tail, TRUE, TRUE, FALSE, FALSE);
}

BOOL CViDockNpc::HandlePlayerSolidCollisions(VecFx32 *prevPlayerPos, const VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, fx32 scale)
{
    *newPlayerPos = *curPlayerPos;

    if (prevPlayerPos->x == curPlayerPos->x && prevPlayerPos->y == curPlayerPos->y && prevPlayerPos->z == curPlayerPos->z)
        return FALSE;

    s32 centerX = MultiplyFX(this->size.x, scale);
    s32 centerY = MultiplyFX(this->size.z, scale);
    s32 x1      = this->position.ToConstVecFx32Ref().x - centerX;
    s32 x2      = this->position.ToConstVecFx32Ref().x + centerX;
    s32 z1      = this->position.ToConstVecFx32Ref().z - centerY;
    s32 z2      = this->position.ToConstVecFx32Ref().z + centerY;

    if (curPlayerPos->x <= x1 || curPlayerPos->x >= x2 || curPlayerPos->z <= z1 || curPlayerPos->z >= z2)
        return FALSE;

    if (prevPlayerPos->x <= x1)
    {
        newPlayerPos->x = x1;
    }
    else if (prevPlayerPos->x >= x2)
    {
        newPlayerPos->x = x2;
    }
    else if (prevPlayerPos->z <= z1)
    {
        newPlayerPos->z = z1;
    }
    else if (prevPlayerPos->z >= z2)
    {
        newPlayerPos->z = z2;
    }

    return TRUE;
}

NONMATCH_FUNC BOOL CViDockNpc::CheckPlayerInTalkRange(VecFx32 *playerPos, u16 playerAngle, fx32 scale, BOOL *canTalk)
{
    // https://decomp.me/scratch/6CdR9 -> 98.08%
#ifdef NON_MATCHING
    fx32 x = this->position.ToConstVecFx32Ref().x - playerPos->x;
    fx32 z = this->position.ToConstVecFx32Ref().z - playerPos->z;

    fx32 radius = MultiplyFX(x, x) + MultiplyFX(z, z);

    const VecFx32 *size = &npcHitboxSizeTable[resConfigFileTable[this->type].size];
    fx32 scaledSize     = MultiplyFX(MATH_MAX(size->x, size->z), scale);
    scaledSize += (scaledSize >> 1);

    if (radius <= MultiplyFX(scaledSize, scaledSize))
    {
        if (x * SinFX(playerAngle) < 0 || z * CosFX(playerAngle) < 0)
        {
            if (canTalk != NULL)
                *canTalk = FALSE;
        }
        else
        {
            if (canTalk != NULL)
                *canTalk = TRUE;
        }

        return TRUE;
    }

    return FALSE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r0
	mov r8, r1
	add r0, r9, #8
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	bl _ZNK8CVector317ToConstVecFx32RefEv
	ldr r2, [r0, #0]
	ldr r1, [r8, #0]
	add r0, r9, #8
	sub r4, r2, r1
	bl _ZNK8CVector317ToConstVecFx32RefEv
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

BOOL CViDockNpc::Allow3dArrow(VecFx32 &position)
{
    UNUSED(position);

    return TRUE;
}
