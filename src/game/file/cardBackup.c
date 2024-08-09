#include <game/file/cardBackup.h>

// --------------------
// ENUMS
// --------------------

enum CardBackupType_
{
    CARDBACKUP_4KBBITS_EEPROM,  // 512 bytes
    CARDBACKUP_64KBBITS_EEPROM, // 8 kb
    CARDBACKUP_512KBITS_EEPROM, // 64 kb
    CARDBACKUP_2MBITS_FLASH,    // 256 kb

    CARDBACKUP_TYPE_COUNT,
};
typedef u32 CardBackupType;

// --------------------
// VARIABLES
// --------------------

static u16 cardLockID;

static const CARDBackupType backupTypeList[] = { CARD_BACKUP_TYPE_EEPROM_4KBITS, CARD_BACKUP_TYPE_EEPROM_64KBITS, CARD_BACKUP_TYPE_EEPROM_512KBITS, CARD_BACKUP_TYPE_FLASH_2MBITS };

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL InitCardBackupLockID(void);
static BOOL CheckCardBackupType(CardBackupType type);

// --------------------
// FUNCTIONS
// --------------------

void InitCardBackupSystem(void)
{
    if (!InitCardBackupLockID())
        return;

	// There may have been debug code here?
	// it doesn't make much sense to do a return with no result otherwise
}

BOOL InitCardBackupSize(void)
{
    return CheckCardBackupType(CARDBACKUP_512KBITS_EEPROM);
}

BOOL ReadFromCardBackup(void *src, void *dst, size_t size)
{
    u16 lockID = cardLockID;

    if (CARD_GetBackupTotalSize() <= (size_t)src + size)
        return FALSE;

    if (dst == NULL)
        return FALSE;

    if (size == 0)
        return TRUE;

    CARD_LockBackup(lockID);
    BOOL success = CARDi_ReadBackup((size_t)src, (u8 *)dst, size, NULL, NULL, FALSE);
    CARD_UnlockBackup(lockID);
    return success;
}

BOOL WriteToCardBackup(void *dst, void *src, size_t size)
{
    u16 lockID = cardLockID;

    if (CARD_GetBackupTotalSize() <= (size_t)dst + size)
        return FALSE;

    if (src == NULL)
        return FALSE;

    if (size == 0)
        return TRUE;

    CARD_LockBackup(lockID);
    BOOL success = CARDi_ProgramAndVerifyBackup((size_t)dst, (u8 *)src, size, NULL, NULL, FALSE);
    CARD_UnlockBackup(lockID);
    return success;
}

BOOL InitCardBackupLockID(void)
{
    u32 lockID = OS_GetLockID();

    if (lockID == OS_LOCK_ID_ERROR)
        return FALSE;

    cardLockID = lockID;
    return TRUE;
}

BOOL CheckCardBackupType(CardBackupType type)
{
    u16 lockID = cardLockID;

    if (type >= CARDBACKUP_TYPE_COUNT)
        return FALSE;

    CARD_LockBackup(lockID);
    BOOL success = CARD_IdentifyBackup(backupTypeList[type]);
    CARD_UnlockBackup(lockID);
    return success;
}
