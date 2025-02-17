#include <hub/cviMapBack.hpp>
#include <game/system/allocator.h>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <hub/hubConfig.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZdlPv(void);

NOT_DECOMPILED void _ZN10HubControl13GetSpriteFileEt(void);
NOT_DECOMPILED void _ZN10HubControl17GetBackgroundFileEt(void);

NOT_DECOMPILED void BackgroundUnknown__Func_204CB98(void);
NOT_DECOMPILED void BackgroundUnknown__Func_204CB40(void);

NOT_DECOMPILED void Unknown2051334__Func_2051534(void);
}

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *ovl05_02172F1C;
NOT_DECOMPILED void *ovl05_02172F58;
NOT_DECOMPILED void *ovl05_02172F94;
NOT_DECOMPILED void *ovl05_02172FD0;
NOT_DECOMPILED void *ViMapBack__OamOrderList;
NOT_DECOMPILED void *aBbViMapBackBb;

NOT_DECOMPILED void *_ZTI13CViMapVmiFile;
NOT_DECOMPILED void *_ZTI13CViMapVmcFile;
NOT_DECOMPILED void *_ZTI13CViMapVmpFile;
NOT_DECOMPILED void *_ZTI10CViMapBack;
NOT_DECOMPILED void *_ZTS10CViMapBack;
NOT_DECOMPILED void *_ZTV13CViMapVmcFile;
NOT_DECOMPILED void *_ZTS13CViMapVmcFile;
NOT_DECOMPILED void *_ZTV13CViMapVmpFile;
NOT_DECOMPILED void *_ZTI13CViMapVmcFile;
NOT_DECOMPILED void *_ZTV13CViMapVmiFile;
NOT_DECOMPILED void *_ZTV10CViMapBack;
NOT_DECOMPILED void *_ZTS13CViMapVmiFile;

// --------------------
// FUNCTIONS
// --------------------

// CViMapVmiFile
// CViMapVmiFile::CViMapVmiFile()
NONMATCH_FUNC void _ZN13CViMapVmiFileC1Ev(CViMapVmiFile *work)
{
#ifdef NON_MATCHING
    ViMapVmiFile__Func_2161074(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmiFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmiFile__Func_2161074
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmiFile::~CViMapVmiFile()
NONMATCH_FUNC void _ZN13CViMapVmiFileD0Ev(CViMapVmiFile *work)
{
#ifdef NON_MATCHING
    ViMapVmiFile__Func_2161074(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmiFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmiFile__Func_2161074
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmiFile::~CViMapVmiFile()
NONMATCH_FUNC void _ZN13CViMapVmiFileD1Ev(CViMapVmiFile *work)
{
#ifdef NON_MATCHING
    ViMapVmiFile__Func_2161074(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmiFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmiFile__Func_2161074
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void ViMapVmiFile__Func_2161074(CViMapVmiFile *work)
{
    work->entryCount = NULL;
    work->entries    = NULL;
}

void ViMapVmiFile__Func_2161084(CViMapVmiFile *work, void *file)
{
    ViMapVmiFile__Func_2161074(work);

    work->entryCount = (u16 *)file;
    work->entries    = (CVmiFileEntry *)((u8 *)file + 4);
}

u16 ViMapVmiFile__Func_21610A4(CViMapVmiFile *work)
{
    return *work->entryCount;
}

u16 ViMapVmiFile__Func_21610B0(CViMapVmiFile *work, s32 id)
{
    return 8 * work->entries[id].width1;
}

u16 ViMapVmiFile__Func_21610CC(CViMapVmiFile *work, s32 id)
{
    return 8 * work->entries[id].height1;
}

u16 ViMapVmiFile__Func_21610E8(CViMapVmiFile *work, s32 id)
{
    return work->entries[id].width1;
}

u16 ViMapVmiFile__Func_21610FC(CViMapVmiFile *work, s32 id)
{
    return work->entries[id].height1;
}

u16 ViMapVmiFile__Func_2161110(CViMapVmiFile *work, s32 id)
{
    return 8 * work->entries[id].width2;
}

u16 ViMapVmiFile__Func_216112C(CViMapVmiFile *work, s32 id)
{
    return 8 * work->entries[id].height2;
}

u16 ViMapVmiFile__Func_2161148(CViMapVmiFile *work, s32 id)
{
    return work->entries[id].width2;
}

u16 ViMapVmiFile__Func_216115C(CViMapVmiFile *work, s32 id)
{
    return work->entries[id].height2;
}

u16 ViMapVmiFile__Func_2161170(CViMapVmiFile *work, s32 id)
{
    return work->entries[id].sortOrder;
}

// CViMapVmpFile
// CViMapVmpFile::CViMapVmpFile()
NONMATCH_FUNC void _ZN13CViMapVmpFileC1Ev(CViMapVmpFile *work)
{
#ifdef NON_MATCHING
    ViMapVmpFile__Func_21611EC(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmpFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmpFile__Func_21611EC
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmpFile::~CViMapVmpFile()
NONMATCH_FUNC void _ZN13CViMapVmpFileD0Ev(CViMapVmpFile *work)
{
#ifdef NON_MATCHING
    ViMapVmpFile__Func_21611EC(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmpFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmpFile__Func_21611EC
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmpFile::~CViMapVmpFile()
NONMATCH_FUNC void _ZN13CViMapVmpFileD1Ev(CViMapVmpFile *work)
{
#ifdef NON_MATCHING
    ViMapVmpFile__Func_21611EC(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmpFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmpFile__Func_21611EC
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void ViMapVmpFile__Func_21611EC(CViMapVmpFile *work)
{
    work->colors = NULL;
}

void ViMapVmpFile__Func_21611F8(CViMapVmpFile *work, void *file)
{
    ViMapVmpFile__Func_21611EC(work);
    work->colors = (u16 *)file;
}

void *ViMapVmpFile__Func_2161210(CViMapVmpFile *work)
{
    return work->colors;
}

// CViMapVmcFile
// CViMapVmcFile::CViMapVmcFile()
NONMATCH_FUNC void _ZN13CViMapVmcFileC1Ev(CViMapVmcFile *work)
{
#ifdef NON_MATCHING
    ViMapVmcFile__Func_2161280(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmcFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmcFile__Func_2161280
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmcFile::~CViMapVmcFile()
NONMATCH_FUNC void _ZN13CViMapVmcFileD0Ev(CViMapVmcFile *work)
{
#ifdef NON_MATCHING
    ViMapVmcFile__Func_2161280(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmcFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmcFile__Func_2161280
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapVmcFile::~CViMapVmcFile()
NONMATCH_FUNC void _ZN13CViMapVmcFileD1Ev(CViMapVmcFile *work)
{
#ifdef NON_MATCHING
    ViMapVmcFile__Func_2161280(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV13CViMapVmcFile+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapVmcFile__Func_2161280
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void ViMapVmcFile__Func_2161280(CViMapVmcFile *work)
{
    work->file = NULL;
}

void ViMapVmcFile__Func_216128C(CViMapVmcFile *work, void *file)
{
    ViMapVmcFile__Func_2161280(work);
    work->file = file;
}

void *ViMapVmcFile__Func_21612A4(CViMapVmcFile *work)
{
    return work->file;
}

// CViMapBack
// CViMapBack::CViMapBack()
NONMATCH_FUNC void _ZN10CViMapBackC1Ev(CViMapBack *work)
{
#ifdef NON_MATCHING
    this->unknownStorage = NULL;
    this->mapVmiFile     = NULL;
    this->mapVmpFile     = NULL;
    this->activeVmcFile  = NULL;
    this->unknownEntries = NULL;
    this->vmcFileCount   = 0;
    this->vmcFiles       = NULL;
    this->field_5B8      = 0;
    this->field_5BC      = 0;

    FontDMAControl__Init(&this->fontDmaControl);
    MI_CpuClear16(this->aniDecoration, sizeof(this->aniDecoration));

    ViMapBack__Release(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, =_ZTV10CViMapBack+0x08
	add r0, r4, #4
	str r1, [r4]
	bl _ZN13CViMapVmiFileC1Ev
	add r0, r4, #0x10
	bl _ZN13CViMapVmpFileC1Ev
	add r0, r4, #0x18
	bl _ZN13CViMapVmcFileC1Ev
	mov r1, #0
	str r1, [r4, #0x40]
	str r1, [r4, #0x20]
	str r1, [r4, #0x24]
	str r1, [r4, #0x28]
	str r1, [r4, #0x44]
	str r1, [r4, #0x2c]
	str r1, [r4, #0x30]
	str r1, [r4, #0x5b8]
	add r0, r4, #0x5c0
	str r1, [r4, #0x5bc]
	bl FontDMAControl__Init
	mov r0, #0
	add r1, r4, #0x8c
	ldr r2, =0x00000514
	bl MIi_CpuClear16
	mov r0, r4
	bl ViMapBack__Release
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapBack::~CViMapBack()
NONMATCH_FUNC void _ZN10CViMapBackD0Ev(CViMapBack *work)
{
#ifdef NON_MATCHING
    ViMapBack__Release(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViMapBack+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapBack__Release
	add r0, r4, #0x18
	bl _ZN13CViMapVmcFileD0Ev
	add r0, r4, #0x10
	bl _ZN13CViMapVmpFileD0Ev
	add r0, r4, #4
	bl _ZN13CViMapVmiFileD0Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// CViMapBack::~CViMapBack()
NONMATCH_FUNC void _ZN10CViMapBackD1Ev(CViMapBack *work)
{
#ifdef NON_MATCHING
    ViMapBack__Release(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CViMapBack+0x08
	mov r4, r0
	str r1, [r4]
	bl ViMapBack__Release
	add r0, r4, #0x18
	bl _ZN13CViMapVmcFileD0Ev
	add r0, r4, #0x10
	bl _ZN13CViMapVmpFileD0Ev
	add r0, r4, #4
	bl _ZN13CViMapVmiFileD0Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__LoadAssets(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x68
	mov r1, #0
	mov r11, r0
	str r1, [sp, #0x1c]
	bl ViMapBack__Release
	ldr r0, =aBbViMapBackBb
	mov r1, #0
	bl GetBundleFileSize
	bl _AllocHeadHEAP_USER
	str r0, [r11, #0x20]
	mov r2, r0
	ldr r0, =aBbViMapBackBb
	mov r1, #0
	bl ReadFileFromBundle
	ldr r1, [r11, #0x20]
	add r0, r11, #4
	bl ViMapVmiFile__Func_2161084
	ldr r0, =aBbViMapBackBb
	mov r1, #1
	bl GetBundleFileSize
	bl _AllocHeadHEAP_USER
	str r0, [r11, #0x24]
	ldr r0, =aBbViMapBackBb
	ldr r2, [r11, #0x24]
	mov r1, #1
	bl ReadFileFromBundle
	ldr r1, [r11, #0x24]
	add r0, r11, #0x10
	bl ViMapVmpFile__Func_21611F8
	add r0, r11, #4
	bl ViMapVmiFile__Func_21610A4
	str r0, [r11, #0x2c]
	mov r0, r0, lsl #2
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r11, #0x30]
	ldr r2, [r11, #0x2c]
	ldr r1, [r11, #0x30]
	mov r0, #0
	mov r2, r2, lsl #2
	bl MIi_CpuClear32
	mov r0, #0
	bl _ZN10HubControl17GetBackgroundFileEt
	mov r3, #1
	mov r1, r0
	str r3, [sp]
	mov r0, #0x40
	str r0, [sp, #4]
	mov r0, #0x20
	str r0, [sp, #8]
	add r0, sp, #0x20
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x20
	bl DrawBackground
	mov r0, #0xc
	bl _ZN10HubControl13GetSpriteFileEt
	ldr r8, =ViMapBack__OamOrderList
	mov r4, r0
	mov r10, r11
	add r9, r11, #0x8c
	mov r5, #0
_0216149C:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetMapBackConfig
	mov r7, r0
	cmp r5, #4
	mov r0, r4
	ldrh r1, [r7, #2]
	bne _02161508
	bl Sprite__GetSpriteSize3FromAnim
	ldrh r1, [r7, #2]
	mov r6, r0
	mov r0, r4
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize3FromAnim
	ldrh r1, [r7, #2]
	cmp r6, r0
	movlo r6, r0
	add r1, r1, #2
	mov r1, r1, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize3FromAnim
	cmp r6, r0
	movlo r6, r0
	b _02161510
_02161508:
	bl Sprite__GetSpriteSize3FromAnim
	mov r6, r0
_02161510:
	ldrh r0, [r7, #0]
	mov r1, r6
	tst r0, #1
	mov r0, #1
	beq _02161590
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r0, r1
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	ldrb r2, [r8, #0]
	mov r0, r9
	mov r1, r4
	str r2, [sp, #0x18]
	ldrh r2, [r7, #2]
	mov r3, #4
	bl AnimatorSprite__Init
	ldr r0, [sp, #0x1c]
	strh r0, [r10, #0xdc]
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
	b _021615E4
_02161590:
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, =0x05000600
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	ldrb r2, [r8, #0]
	mov r0, r9
	mov r3, #4
	str r2, [sp, #0x18]
	ldrh r2, [r7, #2]
	bl AnimatorSprite__Init
	mov r0, #8
	strh r0, [r10, #0xdc]
_021615E4:
	ldrh r0, [r7, #0]
	add r5, r5, #1
	add r8, r8, #1
	tst r0, #2
	movne r0, #1
	strne r0, [r10, #0xe4]
	add r9, r9, #0x64
	add r10, r10, #0x64
	cmp r5, #0xd
	blt _0216149C
	ldr r0, [r11, #0x258]
	add r1, r11, #0x50
	bic r0, r0, #4
	str r0, [r11, #0x258]
	ldr r2, [r11, #0x4b0]
	mov r0, #0
	bic r3, r2, #4
	mov r2, #0x3c
	str r3, [r11, #0x4b0]
	bl MIi_CpuClear32
	mov r1, #1
	mov r2, r1
	add r4, r11, #0x500
	mov r3, #0
	add r0, r11, #0x5c0
	strh r3, [r4, #0xa0]
	bl FontDMAControl__InitWithParams
	add r0, r11, #0x5c0
	mov r1, #0
	bl FontDMAControl__Func_2051BF4
	mov r1, #0
	mov r0, r11
	mov r2, r1
	bl ViMapBack__Func_2162648
	add sp, sp, #0x68
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Release(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x5c0
	bl FontDMAControl__Release
	add r6, r4, #0x8c
	mov r5, #0
_02161698:
	mov r0, r6
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #0xd
	add r6, r6, #0x64
	blt _02161698
	ldr r2, =0x00000514
	add r1, r4, #0x8c
	mov r0, #0
	bl MIi_CpuClear16
	add r0, r4, #4
	bl ViMapVmiFile__Func_2161074
	add r0, r4, #0x10
	bl ViMapVmpFile__Func_21611EC
	add r0, r4, #0x18
	bl ViMapVmcFile__Func_2161280
	ldr r0, [r4, #0x40]
	cmp r0, #0
	beq _021616F0
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x40]
_021616F0:
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _02161708
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x20]
_02161708:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	beq _02161720
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x24]
_02161720:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02161738
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x28]
_02161738:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _02161750
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x44]
_02161750:
	ldr r0, [r4, #0x30]
	cmp r0, #0
	beq _021617AC
	ldr r0, [r4, #0x2c]
	mov r6, #0
	cmp r0, #0
	bls _0216179C
	mov r5, r6
_02161770:
	ldr r0, [r4, #0x30]
	ldr r0, [r0, r6, lsl #2]
	cmp r0, #0
	beq _0216178C
	bl _FreeHEAP_USER
	ldr r0, [r4, #0x30]
	str r5, [r0, r6, lsl #2]
_0216178C:
	ldr r0, [r4, #0x2c]
	add r6, r6, #1
	cmp r6, r0
	blo _02161770
_0216179C:
	ldr r0, [r4, #0x30]
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x30]
_021617AC:
	mov r1, #0
	str r1, [r4, #0x2c]
	str r1, [r4, #0x48]
	ldr r0, =0x0000FFFF
	str r1, [r4, #0x4c]
	str r0, [r4, #0x34]
	add r0, r4, #0x500
	strh r1, [r0, #0xa4]
	str r1, [r4, #0x5a8]
	str r1, [r4, #0x5ac]
	str r1, [r4, #0x5b0]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_21617E4(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	movs r5, r2
	mov r7, r0
	mov r6, r1
	mov r4, r3
	beq _02161808
	add r0, r7, #4
	bl ViMapVmiFile__Func_21610E8
	strh r0, [r5]
_02161808:
	cmp r4, #0
	beq _02161820
	mov r1, r6
	add r0, r7, #4
	bl ViMapVmiFile__Func_21610FC
	strh r0, [r4]
_02161820:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _02161840
	mov r1, r6
	add r0, r7, #4
	bl ViMapVmiFile__Func_2161148
	ldr r1, [sp, #0x18]
	strh r0, [r1]
_02161840:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, r6
	add r0, r7, #4
	bl ViMapVmiFile__Func_216115C
	ldr r1, [sp, #0x1c]
	strh r0, [r1]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161864(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r6, r2
	mov r8, r0
	mov r7, r1
	mov r5, r3
	beq _0216189C
	add r0, r8, #4
	bl ViMapVmiFile__Func_21610B0
	mov r4, r0
	mov r1, r7
	add r0, r8, #4
	bl ViMapVmiFile__Func_2161110
	add r0, r4, r0, asr #1
	strh r0, [r6]
_0216189C:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r1, r7
	add r0, r8, #4
	bl ViMapVmiFile__Func_21610CC
	mov r4, r0
	mov r1, r7
	add r0, r8, #4
	bl ViMapVmiFile__Func_216112C
	add r0, r4, r0, asr #1
	strh r0, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_21618CC(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl ViMapBack__Func_2161960
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r4, r5, #2
	mov r1, r4, lsl #0x10
	ldr r0, =aBbViMapBackBb
	mov r1, r1, lsr #0x10
	bl GetBundleFileSize
	bl _AllocHeadHEAP_USER
	ldr r2, [r6, #0x30]
	mov r1, r4, lsl #0x10
	str r0, [r2, r5, lsl #2]
	ldr r2, [r6, #0x30]
	ldr r0, =aBbViMapBackBb
	ldr r2, [r2, r5, lsl #2]
	mov r1, r1, lsr #0x10
	bl ReadFileFromBundle
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161924(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	mov r4, #0
	cmp r0, #0
	ldmlsia sp!, {r3, r4, r5, pc}
_0216193C:
	mov r1, r4, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl ViMapBack__Func_21618CC
	ldr r0, [r5, #0x2c]
	add r4, r4, #1
	cmp r4, r0
	blo _0216193C
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161960(CViMapBack *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, [r0, #0x30]
	ldr r0, [r0, r1, lsl #2]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161978(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl ViMapBack__Func_2161960
	cmp r0, #0
	ldrne r0, [r5, #0x30]
	ldrne r0, [r0, r4, lsl #2]
	cmpne r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl _FreeHEAP_USER
	ldr r0, [r5, #0x30]
	mov r1, #0
	str r1, [r0, r4, lsl #2]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_21619B0(CViMapBack *work, u16 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #0x44]
	mov r4, r1
	cmp r0, #0
	bne _021619E4
	mov r0, #0x40
	bl _AllocTailHEAP_SYSTEM
	str r0, [r5, #0x44]
	mov r0, #0
	str r0, [r5, #0x4c]
	mov r0, #1
	str r0, [r5, #0x48]
_021619E4:
	ldr r1, [r5, #0x4c]
	ldr r0, [r5, #0x48]
	cmp r1, r0, lsl #5
	blt _02161A24
	add r0, r0, #1
	str r0, [r5, #0x48]
	ldr r6, [r5, #0x44]
	mov r0, r0, lsl #6
	bl _AllocTailHEAP_SYSTEM
	str r0, [r5, #0x44]
	mov r1, r0
	ldr r2, [r5, #0x4c]
	mov r0, r6
	bl MIi_CpuCopy16
	mov r0, r6
	bl _FreeHEAP_SYSTEM
_02161A24:
	ldr r2, [r5, #0x4c]
	add r0, r2, #1
	str r0, [r5, #0x4c]
	ldr r1, [r5, #0x44]
	mov r0, r2, lsl #1
	strh r4, [r1, r0]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161A40(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =0x0000FFFF
	mov r4, r0
	str r1, [r4, #0x34]
	bl ViMapBack__Func_21627D4
	mov r0, #0xfc00
	bl _AllocTailHEAP_USER
	str r0, [r4, #0x40]
	mov r1, r0
	mov r0, #0
	mov r2, #0xfc00
	bl MIi_CpuClearFast
	ldr r0, [r4, #0x4c]
	mov r5, #0
	cmp r0, #0
	ble _02161AA4
_02161A80:
	ldr r1, [r4, #0x44]
	mov r0, r5, lsl #1
	ldrh r1, [r1, r0]
	mov r0, r4
	bl ViMapBack__Func_2162874
	ldr r0, [r4, #0x4c]
	add r5, r5, #1
	cmp r5, r0
	blt _02161A80
_02161AA4:
	ldr r0, [r4, #0x40]
	mov r1, #0xfc00
	bl DC_StoreRange
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _02161AC8
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x44]
_02161AC8:
	mov r0, #0
	str r0, [r4, #0x4c]
	str r0, [r4, #0x48]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161ADC(CViMapBack *work, u16 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r4, r1
	str r4, [r6, #0x34]
	bl ViMapBack__Func_21627D4
	mov r1, r4
	add r0, r6, #4
	bl ViMapVmiFile__Func_21610E8
	strh r0, [r6, #0x38]
	mov r1, r4
	add r0, r6, #4
	bl ViMapVmiFile__Func_21610FC
	strh r0, [r6, #0x3a]
	mov r1, r4
	add r0, r6, #4
	bl ViMapVmiFile__Func_2161148
	mov r1, r4
	strh r0, [r6, #0x3c]
	add r0, r6, #4
	bl ViMapVmiFile__Func_216115C
	strh r0, [r6, #0x3e]
	ldrh r1, [r6, #0x3e]
	ldrh r0, [r6, #0x3c]
	mov r0, r0, lsl #6
	mul r5, r1, r0
	mov r0, r5
	bl _AllocTailHEAP_USER
	str r0, [r6, #0x40]
	mov r0, #0
	ldr r1, [r6, #0x40]
	mov r2, r5
	bl MIi_CpuClearFast
	mov r4, #0
	ldr r0, [r6, #0x4c]
	cmp r0, #0
	ble _02161BAC
_02161B70:
	ldrh r2, [r6, #0x3c]
	mov r1, r4, lsl #1
	mov r0, r6
	str r2, [sp]
	ldrh r2, [r6, #0x3e]
	str r2, [sp, #4]
	ldr r3, [r6, #0x44]
	ldrh r2, [r6, #0x38]
	ldrh r1, [r3, r1]
	ldrh r3, [r6, #0x3a]
	bl ViMapBack__Func_2162974
	ldr r0, [r6, #0x4c]
	add r4, r4, #1
	cmp r4, r0
	blt _02161B70
_02161BAC:
	ldr r0, [r6, #0x40]
	mov r1, r5
	bl DC_StoreRange
	ldr r0, [r6, #0x44]
	cmp r0, #0
	beq _02161BD0
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r6, #0x44]
_02161BD0:
	mov r0, #0
	str r0, [r6, #0x4c]
	str r0, [r6, #0x48]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161BE4(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	str r7, [r8, #0x34]
	bl ViMapBack__Func_21627D4
	mov r1, r7
	add r0, r8, #4
	bl ViMapVmiFile__Func_21610E8
	strh r0, [r8, #0x38]
	mov r1, r7
	add r0, r8, #4
	bl ViMapVmiFile__Func_21610FC
	strh r0, [r8, #0x3a]
	mov r1, r7
	add r0, r8, #4
	bl ViMapVmiFile__Func_2161148
	strh r0, [r8, #0x3c]
	add r0, r8, #4
	mov r1, r7
	bl ViMapVmiFile__Func_216115C
	strh r0, [r8, #0x3e]
	ldrh r1, [r8, #0x3e]
	ldrh r0, [r8, #0x3c]
	mov r0, r0, lsl #6
	mul r5, r1, r0
	mov r0, r5
	bl _AllocTailHEAP_USER
	str r0, [r8, #0x40]
	mov r0, #0
	ldr r1, [r8, #0x40]
	mov r2, r5
	bl MIi_CpuClearFast
	mov r0, r5
	bl _AllocTailHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r5
	bl MIi_CpuClearFast
	mov r1, #0
	ldr r3, [r8, #0x4c]
	cmp r3, #0
	ble _02161CB4
	ldr r2, [r8, #0x44]
_02161C98:
	mov r0, r1, lsl #1
	ldrh r0, [r2, r0]
	cmp r7, r0
	beq _02161CB4
	add r1, r1, #1
	cmp r1, r3
	blt _02161C98
_02161CB4:
	add r4, r1, #1
	cmp r4, r3
	bge _02161D04
_02161CC0:
	ldr r1, [r8, #0x44]
	mov r0, r4, lsl #1
	ldrh r1, [r1, r0]
	cmp r7, r1
	beq _02161CF4
	ldrh r2, [r8, #0x3c]
	mov r0, r8
	str r2, [sp]
	ldrh r2, [r8, #0x3e]
	str r2, [sp, #4]
	ldrh r2, [r8, #0x38]
	ldrh r3, [r8, #0x3a]
	bl ViMapBack__Func_2162974
_02161CF4:
	ldr r0, [r8, #0x4c]
	add r4, r4, #1
	cmp r4, r0
	blt _02161CC0
_02161D04:
	ldr r4, [r8, #0x40]
	mov r0, r8
	str r6, [r8, #0x40]
	ldrh r2, [r8, #0x3c]
	mov r1, r7
	str r2, [sp]
	ldrh r2, [r8, #0x3e]
	str r2, [sp, #4]
	ldrh r2, [r8, #0x38]
	ldrh r3, [r8, #0x3a]
	bl ViMapBack__Func_2162974
	cmp r5, #0
	mov r7, #0
	bls _02161D88
	mov r1, r7
	mov r2, r7
_02161D44:
	ldr r0, [r4, r7]
	add r6, r4, r7
	cmp r0, #0
	beq _02161D7C
	mov r3, r2
_02161D58:
	ldrb r0, [r6, #0]
	add r6, r6, #1
	cmp r0, #0
	ldrne r0, [r8, #0x40]
	addne r0, r7, r0
	strneb r1, [r3, r0]
	add r3, r3, #1
	cmp r3, #4
	blt _02161D58
_02161D7C:
	add r7, r7, #4
	cmp r7, r5
	blo _02161D44
_02161D88:
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, [r8, #0x40]
	mov r1, r5
	bl DC_StoreRange
	ldr r0, [r8, #0x44]
	cmp r0, #0
	beq _02161DB4
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r8, #0x44]
_02161DB4:
	mov r0, #0
	str r0, [r8, #0x4c]
	str r0, [r8, #0x48]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161DC8(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViMapBack__Func_2162BD8
	ldr r0, [r4, #0x40]
	cmp r0, #0
	beq _02161DEC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x40]
_02161DEC:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _02161E04
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x44]
_02161E04:
	mov r1, #0
	str r1, [r4, #0x48]
	ldr r0, =0x0000FFFF
	str r1, [r4, #0x4c]
	str r0, [r4, #0x34]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161E20(CViMapBack *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =ViMapVmpFile__Func_2161210
	add r0, r0, #0x10
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161E30(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r8, r0
	add r0, r8, #4
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr r4, [sp, #0x38]
	bl ViMapVmiFile__Func_21610A4
	ldr r1, [r8, #0x34]
	cmp r1, r0
	blt _02161EB4
	ldrh r1, [sp, #0x3c]
	mov r0, r4, lsl #0x13
	mov r2, r0, lsr #0x10
	mov r0, r1, lsl #0x13
	str r2, [sp]
	mov r0, r0, lsr #0x10
	stmib sp, {r0, r7}
	str r4, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r1, r6, lsl #0x13
	mov r3, r5, lsl #0x13
	mov r2, r1, lsr #0x10
	ldr r0, [r8, #0x40]
	mov r3, r3, lsr #0x10
	mov r1, #0x24
	bl BackgroundUnknown__Func_204CB40
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02161EB4:
	ldrh r1, [sp, #0x3c]
	mov r0, r4, lsl #0x13
	mov r2, r0, lsr #0x10
	mov r0, r1, lsl #0x13
	str r2, [sp]
	mov r0, r0, lsr #0x10
	stmib sp, {r0, r7}
	str r4, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r2, r6, lsl #0x13
	mov r3, r5, lsl #0x13
	ldrh r1, [r8, #0x3c]
	ldr r0, [r8, #0x40]
	mov r2, r2, lsr #0x10
	mov r3, r3, lsr #0x10
	bl BackgroundUnknown__Func_204CB40
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161F08(CViMapBack *work, u16 a2, u16 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	add r0, r4, #0x10
	strh r1, [r2, #0xa4]
	bl ViMapVmpFile__Func_2161210
	add r1, r4, #0x500
	ldrh r3, [r1, #0xa4]
	mov r1, #0x100
	mov r2, #3
	mov r3, r3, lsl #9
	bl LoadUncompressedPalette
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2161F3C(CViMapBack *work, void *vramPixels, s32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	str r1, [r10, #0x5a8]
	add r0, r10, #4
	mov r9, r2
	bl ViMapVmiFile__Func_21610A4
	ldr r1, [r10, #0x34]
	cmp r1, r0
	blt _02161F88
	cmp r9, #0
	ldr r0, [r10, #0x40]
	mov r1, #0xfc00
	ldr r3, [r10, #0x5a8]
	mov r2, #0
	beq _02161F80
	bl QueueUncompressedPixels
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02161F80:
	bl LoadUncompressedPixels
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02161F88:
	ldrh r0, [r10, #0x3a]
	ldrh r1, [r10, #0x3e]
	ldrh r3, [r10, #0x38]
	ldr r2, [r10, #0x5a8]
	add r0, r0, r0, lsl #3
	add r0, r2, r0, lsl #8
	ldrh r5, [r10, #0x3c]
	ldr r7, [r10, #0x40]
	add r8, r0, r3, lsl #6
	mov r6, #0
	cmp r1, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r11, r6
	mov r4, r6
_02161FC0:
	cmp r9, #0
	ldrh r1, [r10, #0x3c]
	mov r0, r7
	beq _02161FE4
	mov r2, r4
	mov r3, r8
	mov r1, r1, lsl #6
	bl QueueUncompressedPixels
	b _02161FF4
_02161FE4:
	mov r2, r11
	mov r3, r8
	mov r1, r1, lsl #6
	bl LoadUncompressedPixels
_02161FF4:
	ldrh r0, [r10, #0x3e]
	add r6, r6, #1
	add r7, r7, r5, lsl #6
	cmp r6, r0
	add r8, r8, #0x900
	blt _02161FC0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162010(CViMapBack *work, void *vramPixels, s32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, r0
	str r1, [r4, #0x5ac]
	str r2, [r4, #0x5b0]
	add r0, r4, #0x500
	ldrh r0, [r0, #0xa4]
	ldr r1, [r4, #0x5ac]
	mov r2, #0x1000
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
	mov ip, #0
	ldr lr, [r4, #0x5ac]
	mov r5, ip
	mov r6, ip
	mov r2, ip
_02162050:
	mov r3, r2
	add r1, lr, r6, lsl #1
_02162058:
	mov r0, r3, lsl #1
	add r7, r3, r5
	ldr r8, [r4, #0x5b0]
	ldrh r9, [r1, r0]
	add r7, r8, r7
	mov r7, r7, lsl #0x10
	orr r7, r9, r7, lsr #16
	add r3, r3, #1
	strh r7, [r1, r0]
	cmp r3, #0x20
	blt _02162058
	add ip, ip, #1
	cmp ip, #0x1c
	add r5, r5, #0x24
	add r6, r6, #0x20
	blt _02162050
	ldr r0, [r4, #0x5ac]
	mov r6, #0
	mov r3, r6
	mov ip, r6
	add r5, r0, #0x800
	mov r2, #0x20
_021620B0:
	mov lr, r2
	add r0, r5, ip, lsl #1
_021620B8:
	add r1, r0, lr, lsl #1
	add r7, lr, r3
	ldr r8, [r4, #0x5b0]
	ldrh r9, [r1, #-0x40]
	add r7, r8, r7
	mov r7, r7, lsl #0x10
	orr r7, r9, r7, lsr #16
	add lr, lr, #1
	strh r7, [r1, #-0x40]
	cmp lr, #0x24
	blt _021620B8
	add r6, r6, #1
	cmp r6, #0x1c
	add r3, r3, #0x24
	add ip, ip, #0x20
	blt _021620B0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_21620FC(CViMapBack *work, s32 id){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r2, r0, #0x50
	ldr r0, [r2, r1, lsl #2]
	orr r0, r0, #1
	str r0, [r2, r1, lsl #2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162110(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r5, #0
	add r6, r7, #0x8c
	mov r4, r5
_02162124:
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	cmp r5, #0xd
	add r6, r6, #0x64
	blt _02162124
	add r0, r7, #0x500
	ldrh r1, [r0, #0xa0]
	add r1, r1, #1
	strh r1, [r0, #0xa0]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162158(CViMapBack *work, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r10, r0
	mov r11, r1
	mov r9, #0
	add r7, r10, #0x8c
	add r4, r10, #0x500
	add r6, sp, #0x1c
	add r5, sp, #0x1a
_0216217C:
	add r0, r10, r9, lsl #2
	ldr r0, [r0, #0x50]
	tst r0, #1
	beq _02162318
	cmp r9, #8
	bne _021621A4
	ldr r0, [r10, #0x7c]
	tst r0, #1
	bne _02162318
	b _021621B8
_021621A4:
	cmp r9, #0xd
	bne _021621B8
	ldr r0, [r10, #0x88]
	tst r0, #1
	bne _02162318
_021621B8:
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A40
	ldrh r1, [r0, #0]
	mov r0, #0x64
	cmp r11, #0
	mla r8, r1, r0, r7
	ldrne r0, =ovl05_02172FD0
	ldreq r0, =ovl05_02172F94
	ldr ip, [r0, r9, lsl #2]
	cmp ip, #0
	bne _02162234
	ldr r0, =ovl05_02172F1C
	mov r1, r9, lsl #2
	ldrsh r2, [r0, r1]
	add r0, r0, r9, lsl #2
	ldrsh r1, [r0, #2]
	strh r2, [sp, #0x1c]
	mov r0, r10
	strh r1, [sp, #0x1a]
	mov r1, r6
	mov r2, r5
	bl ViMapBack__Func_2162C50
	mov r0, #0x1000
	str r0, [sp]
	ldrsh r2, [sp, #0x1c]
	ldrsh r3, [sp, #0x1a]
	mov r1, r8
	mov r0, r10
	bl ViMapBack__Func_2162C04
	b _02162318
_02162234:
	add r0, sp, #0x16
	str r0, [sp]
	add r0, sp, #0x14
	str r0, [sp, #4]
	add r0, sp, #0x28
	str r0, [sp, #8]
	add r0, sp, #0x24
	str r0, [sp, #0xc]
	add r0, sp, #0x20
	str r0, [sp, #0x10]
	ldrh r0, [r4, #0xa0]
	mov r1, r6
	mov r2, r5
	add r3, sp, #0x18
	blx ip
	ldrh r1, [sp, #0x16]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _02162318
	ldrh r0, [r8, #0xc]
	cmp r0, r1
	ldreq r0, [sp, #0x24]
	cmpeq r0, #0
	beq _0216229C
	mov r0, r8
	bl AnimatorSprite__SetAnimation
_0216229C:
	ldrsh r0, [sp, #0x18]
	mov r1, r6
	strb r0, [r8, #0x56]
	ldr r0, [r8, #0x3c]
	bic r0, r0, #4
	str r0, [r8, #0x3c]
	ldr r0, [sp, #0x28]
	cmp r0, #0
	ldr r0, [r8, #0x3c]
	orrne r0, r0, #0x80
	biceq r0, r0, #0x80
	str r0, [r8, #0x3c]
	ldr r0, [sp, #0x20]
	cmp r0, #0
	mov r0, r10
	beq _021622E8
	mov r2, r5
	bl ViMapBack__Func_2162C80
	b _021622F0
_021622E8:
	mov r2, r5
	bl ViMapBack__Func_2162C50
_021622F0:
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _02162318
	mov r1, r8
	ldrsh r2, [sp, #0x14]
	mov r0, r10
	str r2, [sp]
	ldrsh r2, [sp, #0x1c]
	ldrsh r3, [sp, #0x1a]
	bl ViMapBack__Func_2162C04
_02162318:
	add r9, r9, #1
	cmp r9, #0xf
	blt _0216217C
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_216233C(CViMapBack *work, u16 a2, BOOL a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x2c
	mov r4, r1
	mov r7, r0
	mov r0, r4
	mov r6, r2
	bl HubConfig__CheckDecorConstructionUnknown
	cmp r0, #0
	addne sp, sp, #0x2c
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl HubConfig__Func_2152A20
	ldrh r5, [r0, #0]
	add r0, r7, r5, lsl #2
	ldr r0, [r0, #0x50]
	tst r0, #1
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl HubConfig__Func_2152A40
	ldrh r1, [r0, #0]
	add r2, r7, #0x8c
	mov r0, #0x64
	mla r4, r1, r0, r2
	cmp r6, #0
	ldrne r0, =ovl05_02172FD0
	ldreq r0, =ovl05_02172F94
	ldr ip, [r0, r5, lsl #2]
	cmp ip, #0
	bne _021623EC
	ldr r1, =ovl05_02172F1C
	mov r2, r5, lsl #2
	ldrsh r5, [r1, r2]
	ldr r0, =0x02172F1E
	add r1, sp, #0x1c
	ldrsh r3, [r0, r2]
	add r2, sp, #0x1a
	mov r0, r7
	strh r5, [sp, #0x1c]
	strh r3, [sp, #0x1a]
	bl ViMapBack__Func_2162C50
	mov r0, #0x1000
	strh r0, [sp, #0x14]
	b _021624A8
_021623EC:
	add r0, sp, #0x16
	str r0, [sp]
	add r1, sp, #0x14
	str r1, [sp, #4]
	add r0, sp, #0x28
	str r0, [sp, #8]
	add r1, sp, #0x24
	str r1, [sp, #0xc]
	add r0, sp, #0x20
	str r0, [sp, #0x10]
	add r0, r7, #0x500
	ldrh r0, [r0, #0xa0]
	add r1, sp, #0x1c
	add r2, sp, #0x1a
	add r3, sp, #0x18
	blx ip
	ldrh r1, [sp, #0x16]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	ldreq r0, [sp, #0x24]
	cmpeq r0, #0
	addne sp, sp, #0x2c
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldrsh r0, [sp, #0x18]
	add r1, sp, #0x1c
	add r2, sp, #0x1a
	strb r0, [r4, #0x56]
	ldr r0, [r4, #0x3c]
	bic r0, r0, #4
	str r0, [r4, #0x3c]
	ldr r0, [sp, #0x28]
	cmp r0, #0
	ldr r0, [r4, #0x3c]
	orrne r0, r0, #0x80
	biceq r0, r0, #0x80
	str r0, [r4, #0x3c]
	ldr r0, [sp, #0x20]
	cmp r0, #0
	mov r0, r7
	beq _021624A4
	bl ViMapBack__Func_2162C80
	b _021624A8
_021624A4:
	bl ViMapBack__Func_2162C50
_021624A8:
	mov r0, #2
	str r0, [r4, #0x58]
	ldrb r2, [r4, #0x56]
	mov r1, #0
	mov r0, r7
	strh r2, [sp, #0x18]
	strb r1, [r4, #0x56]
	ldrsh r2, [sp, #0x14]
	mov r1, r4
	str r2, [sp]
	ldrsh r2, [sp, #0x1c]
	ldrsh r3, [sp, #0x1a]
	bl ViMapBack__Func_2162C04
	ldrsh r1, [sp, #0x18]
	mov r0, #0
	strb r1, [r4, #0x56]
	str r0, [r4, #0x58]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162508(CViMapBack *work, u16 a2, u16 *a3, u16 *a4, BOOL a5, BOOL a6)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	mov r7, r1
	mov r6, r0
	mov r0, r7
	mov r5, r2
	mov r4, r3
	bl HubConfig__CheckDecorConstructionUnknown
	cmp r0, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r7
	bl HubConfig__Func_2152A20
	ldrh r2, [r0, #0]
	add r0, r6, r2, lsl #2
	ldr r0, [r0, #0x50]
	tst r0, #1
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x40]
	cmp r0, #0
	ldrne r0, =ovl05_02172FD0
	ldreq r0, =ovl05_02172F94
	ldr ip, [r0, r2, lsl #2]
	cmp ip, #0
	bne _021625BC
	ldr r0, [sp, #0x44]
	cmp r0, #0
	ldreq r1, =ovl05_02172F1C
	moveq r2, r2, lsl #2
	ldreq r0, =0x02172F1E
	beq _02162594
	ldr r1, =ovl05_02172F58
	ldr r0, =0x02172F5A
	mov r2, r2, lsl #2
_02162594:
	ldrsh r1, [r1, r2]
	ldrsh r0, [r0, r2]
	mov r2, r4
	strh r1, [r5]
	strh r0, [r4]
	mov r0, r6
	mov r1, r5
	bl ViMapBack__Func_2162C50
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021625BC:
	add r0, sp, #0x16
	str r0, [sp]
	add r1, sp, #0x14
	str r1, [sp, #4]
	add r0, sp, #0x24
	str r0, [sp, #8]
	add r1, sp, #0x20
	str r1, [sp, #0xc]
	add r0, sp, #0x1c
	str r0, [sp, #0x10]
	add r0, r6, #0x500
	ldrh r0, [r0, #0xa0]
	add r3, sp, #0x18
	mov r1, r5
	mov r2, r4
	blx ip
	ldr r0, [sp, #0x1c]
	mov r1, r5
	cmp r0, #0
	mov r0, r6
	beq _02162620
	mov r2, r4
	bl ViMapBack__Func_2162C80
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02162620:
	mov r2, r4
	bl ViMapBack__Func_2162C50
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162648(CViMapBack *work, s16 a2, s16 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	mov r5, r0
	add r0, r5, #0x500
	strh r1, [r0, #0xb4]
	strh r2, [r0, #0xb6]
	ldrsh r3, [r0, #0xb4]
	ldr r1, =VRAMSystem__GFXControl
	add r4, r2, r2, lsl #1
	ldr r2, [r1, #4]
	sub r1, r3, #0x18
	strh r1, [r2]
	ldrsh r1, [r0, #0xb6]
	mov r3, r4, asr #2
	cmp r3, #0x60
	sub r1, r1, #0x10
	strh r1, [r2, #2]
	strh r3, [r2, #6]
	movge r4, #0
	bge _021626CC
	ldrsh r1, [r0, #0xb4]
	ldr r0, [r5, #0x5b8]
	rsb r4, r3, #0x60
	add r1, r1, #0x80
	add r1, r1, r1, lsl #1
	mov r0, r0, asr #0xc
	add r0, r0, r1, asr #2
	mov r1, r0, lsl #0x10
	mov r3, r1, lsr #0x10
	add r0, r5, #0x5c0
	and r2, r4, #0xff
	mov r1, #0
	bl FontDMAControl__Func_2051CD8
_021626CC:
	cmp r4, #0xbf
	bgt _02162748
	add r0, r5, #0x500
	ldrsh r2, [r0, #0xb4]
	mov r0, #0x40000
	mov r1, #0xa0
	mov r2, r2, lsl #0xc
	mov r8, r2, asr #1
	bl FX_DivS32
	mov r7, r0
	mov r0, #0x1c000
	rsb r0, r0, #0
	mov r1, #0xa0
	bl FX_DivS32
	mov r6, r0
	mov r0, r8
	mov r1, #0xa0
	bl FX_DivS32
	str r0, [sp]
	mov r0, #0
	stmib sp, {r0, r7}
	mov r0, #0x20000
	str r0, [sp, #0xc]
	str r6, [sp, #0x10]
	ldr r2, [r5, #0x5bc]
	and r1, r4, #0xff
	str r2, [sp, #0x14]
	mov r3, r8
	add r0, r5, #0x5c0
	mov r2, #0xbf
	bl FontDMAControl__Func_2051F68
_02162748:
	add r0, r5, #0x5c0
	bl FontDMAControl__PrepareSwapBuffer
	ldr r0, [r5, #0x5b8]
	add r0, r0, #0x80
	str r0, [r5, #0x5b8]
	ldr r0, [r5, #0x5bc]
	add r0, r0, #0x1000
	str r0, [r5, #0x5bc]
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162774(CViMapBack *work, s16 *x, s16 *y){
#ifdef NON_MATCHING

#else
    // clang-format off
	cmp r1, #0
	addne r3, r0, #0x500
	ldrnesh r3, [r3, #0xb4]
	strneh r3, [r1]
	cmp r2, #0
	addne r0, r0, #0x500
	ldrnesh r0, [r0, #0xb6]
	strneh r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162798(CViMapBack *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	cmp r1, #0
	beq _021627B0
	ldr r3, =ovl05_02172F58
	mov ip, r0, lsl #2
	ldrsh r3, [r3, ip]
	strh r3, [r1]
_021627B0:
	cmp r2, #0
	bxeq lr
	ldr r1, =0x02172F5A
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	strh r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_21627D4(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	ldr r0, [r6, #0x4c]
	cmp r0, #1
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r4, #1
	cmp r0, #1
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
_021627F4:
	sub r5, r0, #1
	cmp r5, r4
	blt _02162860
_02162800:
	ldr r1, [r6, #0x44]
	mov r0, r5, lsl #1
	ldrh r1, [r1, r0]
	add r0, r6, #4
	bl ViMapVmiFile__Func_2161170
	ldr r1, [r6, #0x44]
	mov r7, r0
	add r0, r1, r5, lsl #1
	ldrh r1, [r0, #-2]
	add r0, r6, #4
	bl ViMapVmiFile__Func_2161170
	cmp r7, r0
	bhs _02162854
	ldr r0, [r6, #0x44]
	mov r3, r5, lsl #1
	add r2, r0, r5, lsl #1
	ldrh r1, [r2, #-2]
	ldrh r0, [r0, r3]
	strh r0, [r2, #-2]
	ldr r0, [r6, #0x44]
	strh r1, [r0, r3]
_02162854:
	sub r5, r5, #1
	cmp r5, r4
	bge _02162800
_02162860:
	ldr r0, [r6, #0x4c]
	add r4, r4, #1
	cmp r4, r0
	blt _021627F4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162874(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r9, r0
	mov r8, r1
	add r0, r9, #4
	bl ViMapVmiFile__Func_21610E8
	mov r4, r0
	mov r1, r8
	add r0, r9, #4
	bl ViMapVmiFile__Func_21610FC
	mov r5, r0
	mov r1, r8
	add r0, r9, #4
	bl ViMapVmiFile__Func_2161148
	mov r6, r0
	mov r1, r8
	add r0, r9, #4
	bl ViMapVmiFile__Func_216115C
	mov r10, r0
	mov r7, #0
	mov r0, r9
	mov r1, r8
	bl ViMapBack__Func_2161960
	cmp r0, #0
	bne _021628E8
	mov r0, r9
	mov r1, r8
	bl ViMapBack__Func_21618CC
	mov r7, #1
_021628E8:
	mov r0, r9
	mov r1, r8
	bl ViMapBack__Func_2162B90
	add r0, r9, #0x18
	bl ViMapVmcFile__Func_21612A4
	mov r1, r10, lsl #0x13
	mov ip, r1, lsr #0x10
	mov r1, r4, lsl #0x13
	mov r2, r1, lsr #0x10
	mov r1, r5, lsl #0x13
	mov r3, r1, lsr #0x10
	mov r1, r6, lsl #0x13
	mov r1, r1, lsr #0x10
	stmia sp, {r1, ip}
	ldr r5, [r9, #0x40]
	mov r4, #0x24
	str r5, [sp, #8]
	str r4, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r2, #0
	str r3, [sp, #0x14]
	mov r1, r6
	mov r3, r2
	str r2, [sp, #0x18]
	bl BackgroundUnknown__Func_204CB98
	mov r0, r9
	bl ViMapBack__Func_2162BD8
	cmp r7, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r9
	mov r1, r8
	bl ViMapBack__Func_2161978
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162974(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	mov r10, r0
	mov r11, r1
	add r0, r10, #4
	mov r9, r2
	mov r8, r3
	bl ViMapVmiFile__Func_21610E8
	mov r4, r0
	mov r1, r11
	add r0, r10, #4
	bl ViMapVmiFile__Func_21610FC
	mov r5, r0
	mov r1, r11
	add r0, r10, #4
	bl ViMapVmiFile__Func_2161148
	str r0, [sp, #0x2c]
	add r0, r10, #4
	mov r1, r11
	bl ViMapVmiFile__Func_216115C
	str r9, [sp, #0x28]
	str r8, [sp, #0x24]
	str r4, [sp, #0x20]
	cmp r9, r4
	str r5, [sp, #0x1c]
	ldrh r6, [sp, #0x58]
	ldrh r7, [sp, #0x5c]
	bhs _021629F4
	sub r1, r4, r9
	sub r6, r6, r1
	str r4, [sp, #0x28]
	b _021629FC
_021629F4:
	cmp r9, r4
	strhi r9, [sp, #0x20]
_021629FC:
	ldr r1, [sp, #0x2c]
	add r2, r4, r1
	ldrh r1, [sp, #0x58]
	add r1, r9, r1
	cmp r1, r2
	blt _02162A1C
	subgt r1, r1, r2
	subgt r6, r6, r1
_02162A1C:
	cmp r6, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r8, r5
	bhs _02162A40
	sub r1, r5, r8
	sub r7, r7, r1
	str r5, [sp, #0x24]
	b _02162A44
_02162A40:
	strhi r8, [sp, #0x1c]
_02162A44:
	add r1, r5, r0
	ldrh r0, [sp, #0x5c]
	add r0, r8, r0
	cmp r0, r1
	blt _02162A60
	subgt r0, r0, r1
	subgt r7, r7, r0
_02162A60:
	cmp r7, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	sub r2, r1, r8
	ldr r1, [sp, #0x20]
	sub r0, r0, r9
	sub r3, r1, r4
	ldr r1, [sp, #0x1c]
	mov r2, r2, lsl #0x10
	sub r4, r1, r5
	mov r1, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x28]
	mov r1, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	str r1, [sp, #0x24]
	mov r1, r3, lsr #0x10
	mov r4, r4, lsl #0x10
	str r1, [sp, #0x20]
	mov r1, r4, lsr #0x10
	str r1, [sp, #0x1c]
	mov r0, r10
	mov r1, r11
	mov r8, #0
	bl ViMapBack__Func_2161960
	cmp r0, #0
	bne _02162AE4
	mov r0, r10
	mov r1, r11
	bl ViMapBack__Func_21618CC
	mov r8, #1
_02162AE4:
	mov r0, r10
	mov r1, r11
	bl ViMapBack__Func_2162B90
	add r0, r10, #0x18
	bl ViMapVmcFile__Func_21612A4
	mov r1, r6, lsl #0x13
	mov r1, r1, lsr #0x10
	str r1, [sp]
	mov r1, r7, lsl #0x13
	mov r1, r1, lsr #0x10
	str r1, [sp, #4]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x20]
	mov r1, r1, lsl #0x13
	mov r5, r1, lsr #0x10
	ldr r1, [sp, #0x24]
	ldr r3, [sp, #0x1c]
	mov r1, r1, lsl #0x13
	mov r4, r1, lsr #0x10
	mov r2, r2, lsl #0x13
	mov r3, r3, lsl #0x13
	ldr r1, [sp, #0x2c]
	ldr r6, [r10, #0x40]
	ldrh r7, [sp, #0x58]
	str r6, [sp, #8]
	mov r2, r2, lsr #0x10
	str r7, [sp, #0xc]
	str r5, [sp, #0x10]
	mov r3, r3, lsr #0x10
	mov r6, #0
	str r4, [sp, #0x14]
	str r6, [sp, #0x18]
	bl BackgroundUnknown__Func_204CB98
	mov r0, r10
	bl ViMapBack__Func_2162BD8
	cmp r8, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r10
	mov r1, r11
	bl ViMapBack__Func_2161978
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162B90(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl ViMapBack__Func_2162BD8
	ldr r0, [r5, #0x30]
	ldr r0, [r0, r4, lsl #2]
	ldr r0, [r0, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r5, #0x28]
	ldr r0, [r5, #0x30]
	ldr r1, [r5, #0x28]
	ldr r0, [r0, r4, lsl #2]
	bl RenderCore_CPUCopyCompressed
	ldr r1, [r5, #0x28]
	add r0, r5, #0x18
	bl ViMapVmcFile__Func_216128C
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162BD8(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x18
	bl ViMapVmcFile__Func_2161280
	ldr r0, [r4, #0x28]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162C04(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrsh r0, [sp, #8]
	strh r2, [r1, #8]
	strh r3, [r1, #0xa]
	cmp r0, #0x1000
	ldr r0, [r1, #0x3c]
	ldrsh r2, [sp, #8]
	orrgt r0, r0, #0x200
	bicle r0, r0, #0x200
	str r0, [r1, #0x3c]
	cmp r2, #0x1000
	mov r0, r1
	beq _02162C48
	mov r1, r2
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	ldmia sp!, {r3, pc}
_02162C48:
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162C50(CViMapBack *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r0, r0, #0x500
	ldrsh r3, [r0, #0xb4]
	ldrsh ip, [r1]
	sub r3, r3, #0x18
	sub r3, ip, r3
	strh r3, [r1]
	ldrsh r0, [r0, #0xb6]
	ldrsh r1, [r2, #0]
	sub r0, r0, #0x10
	sub r0, r1, r0
	strh r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162C80(CViMapBack *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r0, r0, #0x500
	ldrsh r3, [r0, #0xb4]
	ldrsh ip, [r1]
	add r3, r3, r3, lsl #1
	mov r3, r3, asr #2
	add r3, r3, #0x80
	sub r3, ip, r3
	strh r3, [r1]
	ldrsh r0, [r0, #0xb6]
	ldrsh r1, [r2, #0]
	add r0, r0, r0, lsl #1
	sub r0, r1, r0, asr #2
	strh r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162CB8(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	ldr r4, =0x000001FF
	mov r7, r0
	and r0, r7, r4
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp r7, #0x80
	ldr r3, [sp, #0x28]
	ldr r2, [sp, #0x30]
	bhs _02162D24
	mov r8, #0
	cmp r7, #0x19
	strlo r8, [r2]
	movlo r2, #6
	movhs ip, #1
	strhs ip, [r2]
	movhs r2, #5
	mov r0, #0x64
	mov r1, #0x32
	mov r9, #8
	strh r2, [r3]
	mov r10, #0x800
	b _02162DF0
_02162D24:
	cmp r7, #0x100
	bhs _02162D68
	sub r0, r7, #0x80
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, #1
	str r0, [r2]
	cmp r7, #0x67
	movlo r2, #5
	movhs r2, #6
	mov r0, #0x32
	mov r8, #8
	mov r1, #0
	mov r9, #0x10
	strh r2, [r3]
	mov r10, #0x1800
	b _02162DF0
_02162D68:
	cmp r7, #0x180
	bhs _02162DBC
	sub r0, r7, #0x100
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov ip, #5
	strh ip, [r3]
	mov r0, #0
	cmp r7, #0x19
	strhs r0, [r2]
	mov r8, #0x10
	mov r1, #0x32
	mov r9, #8
	strhsh ip, [r3]
	bhs _02162DB4
	mov ip, #1
	str ip, [r2]
	mov r2, #6
	strh r2, [r3]
_02162DB4:
	mov r10, #0x800
	b _02162DF0
_02162DBC:
	sub r0, r7, #0x180
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r9, #0
	str r9, [r2]
	cmp r7, #0x67
	movlo r2, #5
	movhs r2, #6
	mov r0, #0x32
	mov r8, #8
	mov r1, #0x64
	strh r2, [r3]
	mov r10, #0x1800
_02162DF0:
	mov r3, r7
	str r10, [sp]
	mov r2, #0x80
	bl Unknown2051334__Func_2051534
	strh r0, [r6]
	mov r0, r8
	mov r1, r9
	mov r3, r7
	str r10, [sp]
	mov r2, #0x80
	bl Unknown2051334__Func_2051534
	strh r0, [r5]
	mov r1, #2
	ldr r0, [sp, #0x34]
	strh r1, [r4]
	mov r2, #0
	ldr r1, [sp, #0x38]
	str r2, [r0]
	ldr r0, [sp, #0x2c]
	str r2, [r1]
	mov r1, #0x1000
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162E54(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr ip, [sp, #0x18]
	ldr lr, [sp, #0x1c]
	str ip, [sp]
	ldr ip, [sp, #0x20]
	str lr, [sp, #4]
	ldr lr, [sp, #0x24]
	str ip, [sp, #8]
	ldr ip, [sp, #0x28]
	str lr, [sp, #0xc]
	str ip, [sp, #0x10]
	bl ViMapBack__Func_2162CB8
	add sp, sp, #0x14
	ldmia sp!, {pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162E90(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr lr, =0x000001FF
	ldr r5, [sp, #0x18]
	and r0, r0, lr
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	and r0, lr, #0xff
	cmp lr, #0x100
	movhs lr, #1
	strhs lr, [r5]
	ldr ip, [sp, #0x10]
	ldr r4, [sp, #0x1c]
	movhs lr, #0xa0
	bhs _02162ED4
	mov lr, #0
	str lr, [r5]
	mov lr, #0x180
_02162ED4:
	strh lr, [r1]
	cmp r0, #0
	moveq r1, #1
	movne r1, #0
	str r1, [r4]
	mov r1, #0x4a
	strh r1, [r2]
	mov r1, #3
	strh r1, [r3]
	mov r1, #0xc
	strh r1, [ip]
	ldr r2, [sp, #0x20]
	mov r3, #1
	str r3, [r2]
	cmp r0, #0x40
	ldr r1, [sp, #0x14]
	mov r2, #0x1000
	strh r2, [r1]
	rsbhs r0, r3, #0x10000
	strhsh r0, [ip]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapBack__Func_2162F2C(CViMapBack *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, [sp, #0x10]
	ldr r6, =0x0000FFFF
	ldr r4, [sp, #0x1c]
	strh r6, [r5]
	mov lr, #0
	ldr r6, [sp, #0x18]
	str lr, [r4]
	mov ip, #1
	str ip, [r6]
	mov r6, #0xa0
	strh r6, [r1]
	mov r1, #0x4a
	strh r1, [r2]
	mov r1, #3
	strh r1, [r3]
	ldr r2, [sp, #0x20]
	and r0, r0, #0x7f
	str ip, [r2]
	ldr r1, [sp, #0x14]
	mov r2, #0x1000
	strh r2, [r1]
	cmp r0, #0x58
	ldmhsia sp!, {r4, r5, r6, pc}
	mov r1, #0xc
	strh r1, [r5]
	tst r0, #0x7f
	streq ip, [r4]
	strne lr, [r4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}