#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/system/sysEvent.h>
#include <game/file/cardBackup.h>
#include <game/graphics/renderCore.h>
#include <seaMap/seaMapManager.h>

// --------------------
// CONSTANTS
// --------------------

#define SAVEGAME_FILE_SIGNATURE "sonic_rush2"

// --------------------
// TYPES
// --------------------

typedef void (*SaveGameCallback)(SaveGame *saveGame, SaveBlockFlags blockFlags);

// --------------------
// STRUCTS
// --------------------

typedef struct SaveIOBlockHeader_
{
    u32 checksum;
    u32 writeCount;
} SaveIOBlockHeader;

typedef struct SaveIOBlock_
{
    SaveIOBlockHeader header;
    u8 data[1];
} SaveIOBlock;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED const char *aSonicRush2;

// --------------------
// VARIABLES
// --------------------

const SaveGameCallback SaveGame__SaveCallbacks[1]  = { SaveGame__SaveCallback_OnlineProfile };
const SaveGameCallback SaveGame__LoadCallbacks[1]  = { SaveGame__LoadCallback_Unknown };
const SaveGameCallback SaveGame__ClearCallbacks[3] = { SeaMapManager__SaveClearCallback_Chart, SaveGame__ClearCallback_Stage, SaveGame__ClearCallback_Common };

const size_t savedataBlockSizes[9] = { 0x00,
                                       sizeof(saveGame.system),
                                       sizeof(saveGame.stage),
                                       sizeof(saveGame.chart),
                                       sizeof(saveGame.timeAttack),
                                       sizeof(saveGame.vikingCup),
                                       sizeof(saveGame.vsRecords),
                                       sizeof(saveGame.onlineProfile),
                                       sizeof(saveGame.leaderboards) };

const size_t _02110DDC[9] = { 0x00, 0x00, 0x80, 0x400, 0x1200, 0x1B00, 0x1D80, 0x1E00, 0x2600 };

const size_t savedataBlockOffsets[9] = { 0x00,
                                         offsetof(SaveGame, system),
                                         offsetof(SaveGame, stage),
                                         offsetof(SaveGame, chart),
                                         offsetof(SaveGame, timeAttack),
                                         offsetof(SaveGame, vikingCup),
                                         offsetof(SaveGame, vsRecords),
                                         offsetof(SaveGame, onlineProfile),
                                         offsetof(SaveGame, leaderboards) };

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

BOOL SaveGame__InitSaveSize(void)
{
    return InitCardBackupSize();
}

void SaveGame__ClearData(SaveGame *work, SaveBlockFlags flags)
{
    if ((flags & SAVE_BLOCK_FLAG_ALL) == SAVE_BLOCK_FLAG_ALL)
    {
        MI_CpuClear16(work, sizeof(SaveGame));
    }
    else
    {
        for (s32 b = 0; b < SAVE_BLOCK_COUNT; b++)
        {
            if (((1 << b) & flags) != 0)
                MI_CpuClear16((u8 *)work + savedataBlockOffsets[b], savedataBlockSizes[b]);
        }
    }

    for (s32 i = 0; i < ARRAY_COUNT(SaveGame__ClearCallbacks); i++)
    {
        SaveGame__ClearCallbacks[i](work, flags);
    }
}

NONMATCH_FUNC SaveErrorTypes SaveGame__SaveData(SaveGame *work, SaveBlockFlags flags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0xcc
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #1
	lsl r0, r0, #0xa
	str r1, [sp, #4]
	bl _AllocHeadHEAP_USER
	ldr r1, =0xEDB88320
	str r0, [sp, #0x48]
	bl MATHi_CRC32InitTableRev
	ldr r0, [sp, #4]
	mov r1, #1
	bic r0, r1
	str r0, [sp, #4]
	mov r0, #0xc
	mov r5, #0
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, r5
	mov r1, r4
	mov r2, #0xc
	bl ReadFromCardBackup
	cmp r0, #0
	beq _0205D978
	ldr r1, =aSonicRush2
	mov r0, r4
	mov r2, #0xc
	bl STD_CompareNString
	cmp r0, #0
	bne _0205D96E
	mov r0, #1
	b _0205D970
_0205D96E:
	mov r0, r5
_0205D970:
	cmp r0, #0
	bne _0205D97A
	mov r5, #1
	b _0205D97A
_0205D978:
	mov r5, #2
_0205D97A:
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r5, #0
	beq _0205D99E
	cmp r5, #1
	beq _0205D98E
	cmp r5, #2
	beq _0205D998
	b _0205D99E
_0205D98E:
	ldr r0, [sp, #4]
	mov r1, #1
	orr r0, r1
	str r0, [sp, #4]
	b _0205D99E
_0205D998:
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DE5E
_0205D99E:
	ldr r0, [sp, #4]
	mov r1, #1
	mov r5, r0
	and r5, r1
	beq _0205D9D0
	mov r0, #0
	add r1, sp, #0xc0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r1, =aSonicRush2
	add r0, sp, #0xc0
	mov r2, #0xc
	bl STD_CopyLStringZeroFill
	mov r0, #0
	add r1, sp, #0xc0
	mov r2, #0xc
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205D9D0
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DE5E
_0205D9D0:
	mov r4, #0
	ldr r6, =SaveGame__SaveCallbacks
	b _0205D9E2
_0205D9D6:
	lsl r2, r4, #2
	ldr r0, [sp]
	ldr r1, [sp, #4]
	ldr r2, [r6, r2]
	blx r2
	add r4, r4, #1
_0205D9E2:
	cmp r4, #1
	blo _0205D9D6
	cmp r5, #0
	beq _0205DABC
	mov r0, #1
	str r0, [sp, #0x3c]
	str r0, [sp, #0x40]
_0205D9F0:
	mov r0, #1
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x40]
	ldr r1, =savedataBlockSizes
	lsl r0, r0, #2
	ldr r4, [r1, r0]
	ldr r1, =savedataBlockOffsets
	lsl r5, r4, #1
	add r5, #8
	str r0, [sp, #8]
	ldr r7, [r1, r0]
	mov r0, r5
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r5
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0x78]
	sub r0, r0, #1
	str r0, [sp, #0x7c]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x7c
	add r2, sp, #0x78
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x7c
	add r2, r2, r7
	mov r3, r4
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x7c]
	mov r5, #0
	mvn r0, r0
	str r0, [r6]
	mov r0, r6
	str r0, [sp, #0x4c]
	add r0, #8
	str r5, [r6, #4]
	str r0, [sp, #0x4c]
_0205DA4C:
	ldr r0, [sp]
	mov r2, r4
	ldr r1, [sp, #0x4c]
	mul r2, r5
	add r1, r1, r2
	add r0, r0, r7
	mov r2, r4
	bl MIi_CpuCopy16
	add r5, r5, #1
	cmp r5, #2
	blt _0205DA4C
	ldr r1, =_02110DDC
	ldr r0, [sp, #8]
	lsl r7, r4, #1
	ldr r4, [r1, r0]
	mov r5, #0
	add r7, #8
_0205DA70:
	lsl r0, r5, #0x10
	lsr r1, r0, #0x10
	mov r0, #0x37
	lsl r0, r0, #8
	mul r0, r1
	add r0, #0x80
	add r0, r4, r0
	mov r1, r6
	mov r2, r7
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DA8E
	mov r0, #0
	str r0, [sp, #0x44]
_0205DA8E:
	add r5, r5, #1
	cmp r5, #4
	blo _0205DA70
	mov r0, r6
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x44]
	cmp r0, #0
	bne _0205DAA4
	mov r0, #0
	str r0, [sp, #0x3c]
_0205DAA4:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	cmp r0, #9
	blt _0205D9F0
	ldr r0, [sp, #0x3c]
	cmp r0, #0
	beq _0205DAB6
	b _0205DE5E
_0205DAB6:
	mov r0, #1
	str r0, [sp, #0x18]
	b _0205DE5E
_0205DABC:
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #1
	str r0, [sp, #0x1c]
	b _0205DE56
_0205DAC6:
	ldr r0, [sp, #0x1c]
	mov r1, #1
	lsl r1, r0
	ldr r0, [sp, #4]
	tst r0, r1
	bne _0205DAD4
	b _0205DE50
_0205DAD4:
	ldr r0, [sp, #0x1c]
	mov r6, #0x37
	lsl r7, r0, #2
	ldr r0, =_02110DDC
	mov r4, #0
	ldr r0, [r0, r7]
	add r5, sp, #0xa0
	str r0, [sp, #0x10]
	lsl r6, r6, #8
	b _0205DB0A
_0205DAE8:
	mov r1, r4
	mul r1, r6
	ldr r0, [sp, #0x10]
	add r1, #0x80
	add r0, r0, r1
	lsl r1, r4, #3
	add r1, r5, r1
	mov r2, #8
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205DB04
	mov r0, #0
	b _0205DB10
_0205DB04:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205DB0A:
	cmp r4, #4
	blo _0205DAE8
	mov r0, #1
_0205DB10:
	cmp r0, #0
	bne _0205DB18
	mov r0, #2
	b _0205DE3E
_0205DB18:
	mov r4, #0
	add r2, sp, #0xa0
	add r1, sp, #0x90
_0205DB1E:
	lsl r0, r4, #3
	add r3, r2, r0
	lsl r0, r4, #2
	str r3, [r1, r0]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, #4
	blo _0205DB1E
	mov r2, #0
_0205DB32:
	mov r5, #0
_0205DB34:
	mov r0, #0
	mov ip, r0
	lsl r6, r5, #2
	add r0, sp, #0x90
	add r4, r0, r6
	ldr r3, [r4, #4]
	ldr r0, [r0, r6]
	ldr r1, [r3, #4]
	ldr r6, [r0, #4]
	cmp r6, r1
	bls _0205DB50
	mov r1, #1
	mov ip, r1
	b _0205DB5C
_0205DB50:
	cmp r6, r1
	bne _0205DB5C
	cmp r0, r3
	bls _0205DB5C
	mov r1, #1
	mov ip, r1
_0205DB5C:
	mov r1, ip
	cmp r1, #0
	beq _0205DB66
	str r3, [r4]
	str r0, [r4, #4]
_0205DB66:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	cmp r5, #3
	blt _0205DB34
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	cmp r2, #3
	blt _0205DB32
	ldr r0, =savedataBlockSizes
	mov r6, #0
	ldr r5, [r0, r7]
	lsl r0, r5, #1
	str r0, [sp, #0xc]
	add r0, #8
	str r0, [sp, #0xc]
	str r0, [sp, #0x14]
	sub r0, #8
	str r0, [sp, #0x14]
_0205DB8E:
	ldr r0, [sp, #0xc]
	bl _AllocHeadHEAP_USER
	str r0, [sp, #0x24]
	mov r0, #0
	beq _0205DB9C
	str r0, [r0]
_0205DB9C:
	mov r0, #0x37
	lsl r0, r0, #8
	mov r1, r6
	mul r1, r0
	ldr r0, [sp, #0x10]
	add r1, #0x80
	add r0, r0, r1
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0xc]
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205DBBA
	mov r4, #2
	b _0205DC52
_0205DBBA:
	ldr r0, [sp, #0x14]
	mov r1, #2
	bl FX_DivS32
	mov r4, #0
	str r0, [sp, #0x30]
	mov r0, r4
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x24]
	str r0, [sp, #0x50]
	add r0, #8
	str r0, [sp, #0x50]
_0205DBD2:
	ldr r0, [sp, #0x24]
	add r1, sp, #0x70
	ldr r0, [r0, #0]
	add r2, sp, #0x74
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x24]
	mov r3, #4
	ldr r0, [r0, #4]
	str r0, [sp, #0x74]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x70]
	ldr r0, [sp, #0x48]
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp, #0x30]
	ldr r3, [sp, #0x28]
	ldr r0, [sp, #0x48]
	mul r3, r2
	ldr r2, [sp, #0x50]
	add r1, sp, #0x70
	add r2, r2, r3
	ldr r3, [sp, #0x30]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x70]
	mvn r1, r0
	ldr r0, [sp, #0x2c]
	cmp r0, r1
	bne _0205DC16
	ldr r0, [sp, #0x28]
	mov r1, #1
	lsl r1, r0
	orr r4, r1
_0205DC16:
	ldr r0, [sp, #0x28]
	add r0, r0, #1
	str r0, [sp, #0x28]
	cmp r0, #2
	blo _0205DBD2
	mov r0, #0
	beq _0205DC26
	str r4, [r0]
_0205DC26:
	cmp r4, #0
	bne _0205DC2E
	mov r4, #4
	b _0205DC52
_0205DC2E:
	cmp r4, #3
	beq _0205DC50
	mov r4, #3
	b _0205DC52
_0205DC50:
	mov r4, #0
_0205DC52:
	ldr r0, [sp, #0x24]
	bl _FreeHEAP_USER
	lsl r1, r6, #2
	add r0, sp, #0x80
	str r4, [r0, r1]
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	cmp r6, #4
	blo _0205DB8E
	mov r2, #0
	add r1, sp, #0x80
	b _0205DC80
_0205DC6E:
	lsl r0, r2, #2
	ldr r0, [r1, r0]
	cmp r0, #2
	bne _0205DC7A
	mov r0, #2
	b _0205DE3E
_0205DC7A:
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
_0205DC80:
	cmp r2, #4
	blo _0205DC6E
	mov r2, #0
	add r0, sp, #0x80
	mov r3, #3
	b _0205DCAA
_0205DC8C:
	sub r1, r3, r2
	lsl r1, r1, #2
	ldr r4, [r0, r1]
	cmp r4, #0
	beq _0205DC9A
	cmp r4, #3
	bne _0205DCA4
_0205DC9A:
	add r0, sp, #0x90
	ldr r0, [r0, r1]
	ldr r0, [r0, #4]
	str r0, [sp, #0x38]
	b _0205DCAE
_0205DCA4:
	add r1, r2, #1
	lsl r1, r1, #0x10
	lsr r2, r1, #0x10
_0205DCAA:
	cmp r2, #4
	blo _0205DC8C
_0205DCAE:
	cmp r2, #4
	bne _0205DD5A
	mov r0, #1
	str r0, [sp, #0x20]
	ldr r0, =savedataBlockOffsets
	lsl r4, r5, #1
	add r4, #8
	ldr r7, [r0, r7]
	mov r0, r4
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r4
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0x6c]
	sub r0, r0, #1
	str r0, [sp, #0x68]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x68
	add r2, sp, #0x6c
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp]
	ldr r0, [sp, #0x48]
	add r1, sp, #0x68
	add r2, r2, r7
	mov r3, r5
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x68]
	mov r4, #0
	mvn r0, r0
	str r0, [r6]
	mov r0, r6
	str r0, [sp, #0x54]
	add r0, #8
	str r4, [r6, #4]
	str r0, [sp, #0x54]
_0205DD04:
	ldr r0, [sp]
	mov r2, r5
	ldr r1, [sp, #0x54]
	mul r2, r4
	add r1, r1, r2
	add r0, r0, r7
	mov r2, r5
	bl MIi_CpuCopy16
	add r4, r4, #1
	cmp r4, #2
	blt _0205DD04
	mov r4, #0
	mov r7, #0x37
	mov r5, r4
	lsl r7, r7, #8
_0205DD24:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	mov r1, r0
	mul r1, r7
	ldr r0, [sp, #0x10]
	add r1, #0x80
	add r0, r0, r1
	ldr r2, [sp, #0xc]
	mov r1, r6
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DD40
	str r5, [sp, #0x20]
_0205DD40:
	add r4, r4, #1
	cmp r4, #4
	blo _0205DD24
	mov r0, r6
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x20]
	cmp r0, #0
	bne _0205DD56
	mov r0, #1
	b _0205DE3E
_0205DD56:
	mov r0, #0
	b _0205DE3E
_0205DD5A:
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r0, =savedataBlockOffsets
	lsl r6, r5, #1
	ldr r0, [r0, r7]
	add r6, #8
	str r0, [sp, #0x58]
	mov r0, r6
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, r6
	bl MIi_CpuClear16
	ldr r0, [sp, #0x38]
	add r1, sp, #0x64
	add r0, r0, #1
	str r0, [sp, #0x60]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x64]
	ldr r0, [sp, #0x48]
	add r2, sp, #0x60
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r3, [sp]
	ldr r2, [sp, #0x58]
	ldr r0, [sp, #0x48]
	add r2, r3, r2
	add r1, sp, #0x64
	mov r3, r5
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x64]
	mov r6, #0
	mvn r0, r0
	str r0, [r4]
	ldr r0, [sp, #0x38]
	add r0, r0, #1
	str r0, [r4, #4]
	mov r0, r4
	str r0, [sp, #0x5c]
	add r0, #8
	str r0, [sp, #0x5c]
_0205DDB8:
	ldr r1, [sp]
	ldr r0, [sp, #0x58]
	mov r2, r5
	add r0, r1, r0
	ldr r1, [sp, #0x5c]
	mul r2, r6
	add r1, r1, r2
	mov r2, r5
	bl MIi_CpuCopy16
	add r6, r6, #1
	cmp r6, #2
	blt _0205DDB8
	mov r5, #0
	add r6, sp, #0x90
	b _0205DE28
_0205DDD8:
	lsl r0, r5, #2
	mov r3, #0
	ldr r1, [r6, r0]
	b _0205DDF0
_0205DDE0:
	lsl r2, r3, #3
	add r0, sp, #0xa0
	add r0, r0, r2
	cmp r0, r1
	beq _0205DDF4
	add r0, r3, #1
	lsl r0, r0, #0x10
	lsr r3, r0, #0x10
_0205DDF0:
	cmp r3, #4
	blo _0205DDE0
_0205DDF4:
	lsl r1, r3, #2
	add r0, sp, #0x80
	ldr r0, [r0, r1]
	cmp r0, #0
	beq _0205DE02
	cmp r0, #3
	bne _0205DE22
_0205DE02:
	ldr r0, =_02110DDC
	mov r1, #0x37
	lsl r1, r1, #8
	mul r1, r3
	ldr r0, [r0, r7]
	add r1, #0x80
	add r0, r0, r1
	ldr r2, [sp, #0xc]
	mov r1, r4
	bl WriteToCardBackup
	cmp r0, #0
	beq _0205DE22
	mov r0, #1
	str r0, [sp, #0x34]
	b _0205DE2C
_0205DE22:
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
_0205DE28:
	cmp r5, #4
	blo _0205DDD8
_0205DE2C:
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x34]
	cmp r0, #0
	bne _0205DE3C
	mov r0, #1
	b _0205DE3E
_0205DE3C:
	mov r0, #0
_0205DE3E:
	cmp r0, #1
	beq _0205DE48
	cmp r0, #2
	beq _0205DE4C
	b _0205DE50
_0205DE48:
	str r0, [sp, #0x18]
	b _0205DE50
_0205DE4C:
	str r0, [sp, #0x18]
	b _0205DE5E
_0205DE50:
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
_0205DE56:
	ldr r0, [sp, #0x1c]
	cmp r0, #9
	bge _0205DE5E
	b _0205DAC6
_0205DE5E:
	ldr r0, [sp, #0x48]
	cmp r0, #0
	beq _0205DE68
	bl _FreeHEAP_USER
_0205DE68:
	ldr r0, [sp, #0x18]
	add sp, #0xcc
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC SaveErrorTypes SaveGame__SaveData2(SaveGame *work)
{
	// fully matching, just needs 'aSonicRush2' to be decompiled to be completed
#ifdef NON_MATCHING
    SaveErrorTypes error     = SAVE_ERROR_NONE;
    MATHCRC32Table *crcTable = HeapAllocHead(HEAP_USER, sizeof(MATHCRC32Table));

    void *signature;
    u16 headerError;

    MATH_CRC32InitTable(crcTable);

    headerError = 0; // no issue!
    signature   = HeapAllocHead(HEAP_USER, sizeof(SAVEGAME_FILE_SIGNATURE));

    if (ReadFromCardBackup(0, signature, sizeof(SAVEGAME_FILE_SIGNATURE)))
    {
        s32 valid = STD_CompareNString(signature, SAVEGAME_FILE_SIGNATURE, sizeof(SAVEGAME_FILE_SIGNATURE)) == 0;

        if (valid == 0)
        {
            headerError = 1; // invalid signature
        }
    }
    else
    {
        headerError = 2; // can't read signature
    }

    HeapFree(HEAP_USER, signature);

    s32 new_var4 = 0;
    if (headerError != 0 && headerError != 1 && headerError == 2)
    {
        error = SAVE_ERROR_CANT_LOAD;
    }
    else
    {
        char signatureW[sizeof(SAVEGAME_FILE_SIGNATURE)];
        MI_CpuClear16(signatureW, sizeof(SAVEGAME_FILE_SIGNATURE));
        STD_CopyLStringZeroFill(signatureW, SAVEGAME_FILE_SIGNATURE, sizeof(SAVEGAME_FILE_SIGNATURE));

        u8 new_var2 = new_var4; // this is needed to trick the compiler into compiling the 'id < 1' loop
        if (WriteToCardBackup(0, signatureW, sizeof(SAVEGAME_FILE_SIGNATURE)) == FALSE)
        {
            error = SAVE_ERROR_CANT_LOAD;
        }
        else
        {
            u32 id;
            for (id = new_var2; id < 1; id++)
            {
                SaveGame__SaveCallbacks[id](work, SAVE_BLOCK_FLAG_UNKNOWN | SAVE_BLOCK_FLAG_ALL);
            }

            BOOL success;
            s32 b;
            BOOL blockSuccess;

            blockSuccess = TRUE;
            for (b = 1; b < 9; b++)
            {
                success = TRUE;

                size_t size   = savedataBlockSizes[b];
                size_t offset = savedataBlockOffsets[b];

                size_t blockByteSize;
                size_t blockWriteSize;
                blockByteSize  = size << 1;
                blockWriteSize = blockByteSize + sizeof(SaveIOBlockHeader);

                SaveIOBlock *block = (SaveIOBlock *)HeapAllocHead(HEAP_USER, blockWriteSize);
                MI_CpuClear16(block, blockWriteSize);

                MATHCRC32Context context;
                u32 writeCount;
                writeCount = 0;
                context    = -1;
                MATH_CRC32Update(crcTable, &context, &writeCount, sizeof(writeCount));
                MATH_CRC32Update(crcTable, &context, (u8 *)work + offset, size);

                block->header.checksum   = ~context;
                block->header.writeCount = 0;
                u8 *save_ptr             = (u8 *)work;
                s32 i;
                for (i = 0; i < 2; i++)
                {
                    MI_CpuCopy16(save_ptr + offset, &block->data[size * i], size);
                }

                for (u32 s = 0; s < 4; s++)
                {
                    if (!WriteToCardBackup(_02110DDC[b] + (0x3700 * (u16)s + 0x80), block, sizeof(SaveIOBlockHeader) + 2 * size))
                        success = FALSE;
                }

                HeapFree(HEAP_USER, block);
                if (!success)
                    blockSuccess = FALSE;
            }

            if (!blockSuccess)
                error = SAVE_ERROR_INVALID_FORMAT;
        }
    }

    if (crcTable != NULL)
        HeapFree(HEAP_USER, crcTable);

    return error;
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x34
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #1
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, =0xEDB88320
	str r0, [sp, #0x14]
	bl MATHi_CRC32InitTableRev
	mov r0, #0xc
	mov r5, #0
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, r5
	mov r1, r4
	mov r2, #0xc
	bl ReadFromCardBackup
	cmp r0, #0
	beq _0205DEC6
	ldr r1, =aSonicRush2
	mov r0, r4
	mov r2, #0xc
	bl STD_CompareNString
	cmp r0, #0
	bne _0205DEBC
	mov r0, #1
	b _0205DEBE
_0205DEBC:
	mov r0, r5
_0205DEBE:
	cmp r0, #0
	bne _0205DEC8
	mov r5, #1
	b _0205DEC8
_0205DEC6:
	mov r5, #2
_0205DEC8:
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r5, #0
	beq _0205DEE0
	cmp r5, #1
	beq _0205DEE0
	cmp r5, #2
	bne _0205DEE0
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DFEE
_0205DEE0:
	mov r0, #0
	add r1, sp, #0x28
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r1, =aSonicRush2
	add r0, sp, #0x28
	mov r2, #0xc
	bl STD_CopyLStringZeroFill
	mov r0, #0
	add r1, sp, #0x28
	mov r2, #0xc
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DF08
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205DFEE
_0205DF08:
	mov r5, #0
	ldr r6, =0x000001FF
	ldr r4, =SaveGame__SaveCallbacks
	b _0205DF1C
_0205DF10:
	lsl r2, r5, #2
	ldr r0, [sp]
	ldr r2, [r4, r2]
	mov r1, r6
	blx r2
	add r5, r5, #1
_0205DF1C:
	cmp r5, #1
	blo _0205DF10
	mov r0, #1
	str r0, [sp, #8]
	str r0, [sp, #0xc]
_0205DF26:
	mov r0, #1
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	ldr r1, =savedataBlockSizes
	lsl r0, r0, #2
	ldr r4, [r1, r0]
	ldr r1, =savedataBlockOffsets
	lsl r5, r4, #1
	add r5, #8
	str r0, [sp, #4]
	ldr r7, [r1, r0]
	mov r0, r5
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	mov r1, r6
	mov r2, r5
	bl MIi_CpuClear16
	mov r0, #0
	str r0, [sp, #0x20]
	sub r0, r0, #1
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	add r1, sp, #0x24
	add r2, sp, #0x20
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp]
	ldr r0, [sp, #0x14]
	add r1, sp, #0x24
	add r2, r2, r7
	mov r3, r4
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x24]
	mov r5, #0
	mvn r0, r0
	str r0, [r6]
	mov r0, r6
	str r0, [sp, #0x1c]
	add r0, #8
	str r5, [r6, #4]
	str r0, [sp, #0x1c]
_0205DF82:
	ldr r0, [sp]
	mov r2, r4
	ldr r1, [sp, #0x1c]
	mul r2, r5
	add r1, r1, r2
	add r0, r0, r7
	mov r2, r4
	bl MIi_CpuCopy16
	add r5, r5, #1
	cmp r5, #2
	blt _0205DF82
	ldr r1, =_02110DDC
	ldr r0, [sp, #4]
	lsl r7, r4, #1
	ldr r4, [r1, r0]
	mov r5, #0
	add r7, #8
_0205DFA6:
	lsl r0, r5, #0x10
	lsr r1, r0, #0x10
	mov r0, #0x37
	lsl r0, r0, #8
	mul r0, r1
	add r0, #0x80
	add r0, r4, r0
	mov r1, r6
	mov r2, r7
	bl WriteToCardBackup
	cmp r0, #0
	bne _0205DFC4
	mov r0, #0
	str r0, [sp, #0x10]
_0205DFC4:
	add r5, r5, #1
	cmp r5, #4
	blo _0205DFA6
	mov r0, r6
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bne _0205DFDA
	mov r0, #0
	str r0, [sp, #8]
_0205DFDA:
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #9
	blt _0205DF26
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _0205DFEE
	mov r0, #1
	str r0, [sp, #0x18]
_0205DFEE:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _0205DFF8
	bl _FreeHEAP_USER
_0205DFF8:
	ldr r0, [sp, #0x18]
	add sp, #0x34
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC SaveErrorTypes SaveGame__LoadData(SaveGame *work, u32 *corruptFlags, u32 *otherFlags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x94
	str r1, [sp, #4]
	str r0, [sp]
	ldr r0, [sp, #4]
	mov r1, #0
	str r1, [r0]
	mov r0, r2
	str r1, [r0]
	mov r0, #1
	lsl r0, r0, #0xa
	str r2, [sp, #8]
	bl _AllocHeadHEAP_USER
	ldr r1, =0xEDB88320
	str r0, [sp, #0x44]
	bl MATHi_CRC32InitTableRev
	ldr r0, =0x00001A68
	bl _AllocHeadHEAP_USER
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x10]
	ldr r2, =0x00001A68
	mov r0, #0
	bl MIi_CpuClear16
	mov r5, #0
	ldr r6, =0x000001FE
	ldr r4, =SaveGame__ClearCallbacks
	b _0205E066
_0205E05A:
	lsl r2, r5, #2
	ldr r0, [sp, #0x10]
	ldr r2, [r4, r2]
	mov r1, r6
	blx r2
	add r5, r5, #1
_0205E066:
	cmp r5, #3
	blo _0205E05A
	mov r0, #0xc
	mov r7, #0
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, r7
	mov r1, r4
	mov r2, #0xc
	bl ReadFromCardBackup
	cmp r0, #0
	beq _0205E09E
	ldr r1, =aSonicRush2
	mov r0, r4
	mov r2, #0xc
	bl STD_CompareNString
	cmp r0, #0
	bne _0205E094
	mov r0, #1
	b _0205E096
_0205E094:
	mov r0, r7
_0205E096:
	cmp r0, #0
	bne _0205E0A0
	mov r7, #1
	b _0205E0A0
_0205E09E:
	mov r7, #2
_0205E0A0:
	mov r0, r4
	bl _FreeHEAP_USER
	cmp r7, #0
	beq _0205E0B4
	cmp r7, #1
	beq _0205E0B2
	cmp r7, #2
	bne _0205E0B4
_0205E0B2:
	b _0205E3F6
_0205E0B4:
	mov r0, #1
	str r0, [sp, #0x40]
	b _0205E3EE
_0205E0BA:
	ldr r0, [sp, #0x40]
	mov r5, #0
	lsl r1, r0, #2
	ldr r0, =_02110DDC
	str r5, [sp, #0x14]
	ldr r0, [r0, r1]
	mov r4, r5
	str r0, [sp, #0x38]
	ldr r0, =savedataBlockSizes
	add r6, sp, #0x64
	ldr r0, [r0, r1]
	str r0, [sp, #0x3c]
	ldr r0, =savedataBlockOffsets
	ldr r0, [r0, r1]
	str r0, [sp, #0x48]
	b _0205E100
_0205E0DA:
	mov r0, #0x37
	lsl r0, r0, #8
	mov r1, r4
	mul r1, r0
	ldr r0, [sp, #0x38]
	add r1, #0x80
	add r0, r0, r1
	lsl r1, r4, #3
	add r1, r6, r1
	mov r2, #8
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E0FA
	mov r0, #0
	b _0205E106
_0205E0FA:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205E100:
	cmp r4, #4
	blo _0205E0DA
	mov r0, #1
_0205E106:
	cmp r0, #0
	bne _0205E110
	mov r0, #2
	str r0, [sp, #0x14]
	b _0205E3AA
_0205E110:
	mov r4, #0
	add r2, sp, #0x64
	add r1, sp, #0x84
_0205E116:
	lsl r0, r4, #3
	add r3, r2, r0
	lsl r0, r4, #2
	str r3, [r1, r0]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, #4
	blo _0205E116
	mov r5, #0
_0205E12A:
	mov r1, #0
_0205E12C:
	mov r0, #0
	mov ip, r0
	lsl r6, r1, #2
	add r0, sp, #0x84
	add r0, r0, r6
	add r2, sp, #0x84
	ldr r4, [r0, #4]
	ldr r2, [r2, r6]
	ldr r3, [r4, #4]
	ldr r6, [r2, #4]
	cmp r6, r3
	bls _0205E14A
	mov r3, #1
	mov ip, r3
	b _0205E156
_0205E14A:
	cmp r6, r3
	bne _0205E156
	cmp r2, r4
	bls _0205E156
	mov r3, #1
	mov ip, r3
_0205E156:
	mov r3, ip
	cmp r3, #0
	beq _0205E160
	str r4, [r0]
	str r2, [r0, #4]
_0205E160:
	add r0, r1, #1
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r1, #3
	blt _0205E12C
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	cmp r5, #3
	blt _0205E12A
	ldr r0, [sp, #0x3c]
	lsl r0, r0, #1
	str r0, [sp, #0x1c]
	add r0, #8
	str r0, [sp, #0x1c]
	bl _AllocHeadHEAP_USER
	mov r5, r0
	ldr r0, [sp, #0x1c]
	mov r4, #0
	str r0, [sp, #0xc]
	sub r0, #8
	str r0, [sp, #0xc]
	mov r0, r5
	str r0, [sp, #0x4c]
	add r0, #8
	str r0, [sp, #0x4c]
	b _0205E2A0
_0205E198:
	mov r0, #3
	sub r0, r0, r4
	lsl r0, r0, #0x10
	lsr r2, r0, #0xe
	add r0, sp, #0x84
	mov r1, #0
	ldr r0, [r0, r2]
	b _0205E1B8
_0205E1A8:
	lsl r3, r1, #3
	add r2, sp, #0x64
	add r2, r2, r3
	cmp r2, r0
	beq _0205E1BC
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E1B8:
	cmp r1, #4
	blo _0205E1A8
_0205E1BC:
	mov r0, #0x37
	mov r2, r1
	lsl r0, r0, #8
	mul r2, r0
	ldr r0, [sp, #0x38]
	add r2, #0x80
	add r0, r0, r2
	ldr r2, [sp, #0x1c]
	mov r1, r5
	mov r6, #0
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E1DE
	mov r0, #2
	str r0, [sp, #0x18]
	b _0205E24E
_0205E1DE:
	ldr r0, [sp, #0xc]
	mov r1, #2
	bl FX_DivS32
	str r0, [sp, #0x28]
	mov r0, r6
	str r0, [sp, #0x20]
_0205E1EC:
	ldr r0, [r5, #0]
	add r1, sp, #0x54
	str r0, [sp, #0x24]
	ldr r0, [r5, #4]
	add r2, sp, #0x58
	str r0, [sp, #0x58]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x54]
	ldr r0, [sp, #0x44]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp, #0x28]
	ldr r3, [sp, #0x20]
	ldr r0, [sp, #0x44]
	mul r3, r2
	ldr r2, [sp, #0x4c]
	add r1, sp, #0x54
	add r2, r2, r3
	ldr r3, [sp, #0x28]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x54]
	mvn r1, r0
	ldr r0, [sp, #0x24]
	cmp r0, r1
	bne _0205E22C
	ldr r0, [sp, #0x20]
	mov r1, #1
	lsl r1, r0
	orr r6, r1
_0205E22C:
	ldr r0, [sp, #0x20]
	add r0, r0, #1
	str r0, [sp, #0x20]
	cmp r0, #2
	blo _0205E1EC
	cmp r6, #0
	bne _0205E240
	mov r0, #4
	str r0, [sp, #0x18]
	b _0205E24E
_0205E240:
	cmp r6, #3
	beq _0205E24A
	mov r0, #3
	str r0, [sp, #0x18]
	b _0205E24E
_0205E24A:
	mov r0, #0
	str r0, [sp, #0x18]
_0205E24E:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _0205E258
	cmp r0, #3
	bne _0205E292
_0205E258:
	mov r1, #0
	mov r0, #1
	b _0205E26C
_0205E25E:
	mov r2, r0
	lsl r2, r1
	tst r2, r6
	bne _0205E270
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E26C:
	cmp r1, #2
	blo _0205E25E
_0205E270:
	ldr r0, [sp, #0x3c]
	mov r2, r5
	add r2, #8
	mul r1, r0
	add r0, r2, r1
	ldr r2, [sp, #0x10]
	ldr r1, [sp, #0x48]
	add r1, r2, r1
	ldr r2, [sp, #0x3c]
	bl MIi_CpuCopy16
	ldr r0, [sp, #0x18]
	cmp r0, #3
	bne _0205E2A6
	mov r0, #3
	str r0, [sp, #0x14]
	b _0205E2A6
_0205E292:
	cmp r0, #4
	bne _0205E29A
	mov r0, #3
	str r0, [sp, #0x14]
_0205E29A:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205E2A0:
	cmp r4, #4
	bhs _0205E2A6
	b _0205E198
_0205E2A6:
	cmp r4, #4
	bne _0205E2B0
	mov r0, #4
	str r0, [sp, #0x14]
	b _0205E3AA
_0205E2B0:
	mov r0, r5
	str r0, [sp, #0x50]
	add r0, #8
	str r0, [sp, #0x50]
	b _0205E3A6
_0205E2BA:
	mov r0, #3
	sub r0, r0, r4
	lsl r0, r0, #0x10
	lsr r2, r0, #0xe
	add r0, sp, #0x84
	mov r1, #0
	ldr r0, [r0, r2]
	b _0205E2DA
_0205E2CA:
	lsl r3, r1, #3
	add r2, sp, #0x64
	add r2, r2, r3
	cmp r2, r0
	beq _0205E2DE
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
_0205E2DA:
	cmp r1, #4
	blo _0205E2CA
_0205E2DE:
	mov r0, #0
	beq _0205E2E4
	str r0, [r0]
_0205E2E4:
	mov r0, #0x37
	mov r2, r1
	lsl r0, r0, #8
	mul r2, r0
	ldr r0, [sp, #0x38]
	add r2, #0x80
	add r0, r0, r2
	ldr r2, [sp, #0x1c]
	mov r1, r5
	bl ReadFromCardBackup
	cmp r0, #0
	bne _0205E324
	mov r0, #2
	b _0205E396
_0205E324:
	ldr r0, [sp, #0xc]
	mov r1, #2
	bl FX_DivS32
	mov r6, #0
	str r0, [sp, #0x34]
	mov r0, r6
	str r0, [sp, #0x2c]
_0205E334:
	ldr r0, [r5, #0]
	add r1, sp, #0x5c
	str r0, [sp, #0x30]
	ldr r0, [r5, #4]
	add r2, sp, #0x60
	str r0, [sp, #0x60]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #0x5c]
	ldr r0, [sp, #0x44]
	mov r3, #4
	bl MATHi_CRC32UpdateRev
	ldr r2, [sp, #0x34]
	ldr r3, [sp, #0x2c]
	ldr r0, [sp, #0x44]
	mul r3, r2
	ldr r2, [sp, #0x50]
	add r1, sp, #0x5c
	add r2, r2, r3
	ldr r3, [sp, #0x34]
	bl MATHi_CRC32UpdateRev
	ldr r0, [sp, #0x5c]
	mvn r1, r0
	ldr r0, [sp, #0x30]
	cmp r0, r1
	bne _0205E374
	ldr r0, [sp, #0x2c]
	mov r1, #1
	lsl r1, r0
	orr r6, r1
_0205E374:
	ldr r0, [sp, #0x2c]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	cmp r0, #2
	blo _0205E334
	mov r0, #0
	beq _0205E384
	str r6, [r0]
_0205E384:
	cmp r6, #0
	bne _0205E38C
	mov r0, #4
	b _0205E396
_0205E38C:
	cmp r6, #3
	beq _0205E394
	mov r0, #3
	b _0205E396
_0205E394:
	mov r0, #0
_0205E396:
	sub r0, r0, #3
	cmp r0, #1
	bhi _0205E3A0
	mov r0, #3
	str r0, [sp, #0x14]
_0205E3A0:
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
_0205E3A6:
	cmp r4, #4
	blo _0205E2BA
_0205E3AA:
	cmp r5, #0
	beq _0205E3B4
	mov r0, r5
	bl _FreeHEAP_USER
_0205E3B4:
	ldr r0, [sp, #0x14]
	cmp r0, #2
	bne _0205E3BE
	mov r7, #2
	b _0205E3F6
_0205E3BE:
	cmp r0, #3
	bne _0205E3D4
	ldr r0, [sp, #8]
	mov r1, #1
	ldr r2, [r0, #0]
	ldr r0, [sp, #0x40]
	lsl r1, r0
	ldr r0, [sp, #8]
	orr r1, r2
	str r1, [r0]
	b _0205E3E8
_0205E3D4:
	cmp r0, #4
	bne _0205E3E8
	ldr r0, [sp, #4]
	mov r1, #1
	ldr r2, [r0, #0]
	ldr r0, [sp, #0x40]
	lsl r1, r0
	ldr r0, [sp, #4]
	orr r1, r2
	str r1, [r0]
_0205E3E8:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
_0205E3EE:
	ldr r0, [sp, #0x40]
	cmp r0, #9
	bge _0205E3F6
	b _0205E0BA
_0205E3F6:
	cmp r7, #1
	beq _0205E3FE
	cmp r7, #2
	bne _0205E428
_0205E3FE:
	ldr r1, [sp, #4]
	mov r0, #0
	str r0, [r1]
	ldr r1, [sp, #8]
	ldr r2, =0x00001A68
	str r0, [r1]
	ldr r1, [sp, #0x10]
	bl MIi_CpuClear16
	mov r4, #0
	ldr r6, =0x000001FE
	ldr r5, =SaveGame__ClearCallbacks
	b _0205E424
_0205E418:
	lsl r2, r4, #2
	ldr r0, [sp, #0x10]
	ldr r2, [r5, r2]
	mov r1, r6
	blx r2
	add r4, r4, #1
_0205E424:
	cmp r4, #3
	blo _0205E418
_0205E428:
	mov r4, #1
	ldr r6, =savedataBlockOffsets
	mov r5, r4
_0205E42E:
	ldr r0, [sp, #4]
	ldr r1, [r0, #0]
	mov r0, r5
	lsl r0, r4
	tst r0, r1
	bne _0205E44E
	lsl r2, r4, #2
	ldr r3, [r6, r2]
	ldr r0, [sp, #0x10]
	ldr r1, [sp]
	add r0, r0, r3
	add r1, r1, r3
	ldr r3, =savedataBlockSizes
	ldr r2, [r3, r2]
	bl MIi_CpuCopy16
_0205E44E:
	add r4, r4, #1
	cmp r4, #9
	blt _0205E42E
	mov r4, #0
	ldr r5, =SaveGame__LoadCallbacks
	b _0205E464
_0205E45A:
	lsl r1, r4, #2
	ldr r0, [sp]
	ldr r1, [r5, r1]
	blx r1
	add r4, r4, #1
_0205E464:
	cmp r4, #1
	blo _0205E45A
	ldr r0, [sp, #0x44]
	cmp r0, #0
	beq _0205E472
	bl _FreeHEAP_USER
_0205E472:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _0205E47C
	bl _FreeHEAP_USER
_0205E47C:
	mov r0, r7
	add sp, #0x94
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

#include <nitro/codereset.h>