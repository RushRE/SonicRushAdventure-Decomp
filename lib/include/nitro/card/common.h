#ifndef NITRO_CARD_COMMON_H
#define NITRO_CARD_COMMON_H

#include <nitro/misc.h>
#include <nitro/types.h>
#include <nitro/hw/io_reg.h>
#include <nitro/mi/dma.h>
#include <nitro/os.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CARD_BACKUP_TYPE_DEVICE_SHIFT  0
#define CARD_BACKUP_TYPE_DEVICE_MASK   0xFF
#define CARD_BACKUP_TYPE_DEVICE_EEPROM 1
#define CARD_BACKUP_TYPE_DEVICE_FLASH  2
#define CARD_BACKUP_TYPE_DEVICE_FRAM   3
#define CARD_BACKUP_TYPE_SIZEBIT_SHIFT 8
#define CARD_BACKUP_TYPE_SIZEBIT_MASK  0xFF
#define CARD_BACKUP_TYPE_VENDER_SHIFT  16
#define CARD_BACKUP_TYPE_VENDER_MASK   0xFF
#define CARD_BACKUP_TYPE_DEFINE(type, size, vender)                                                                                                                                \
    (((CARD_BACKUP_TYPE_DEVICE_##type) << CARD_BACKUP_TYPE_DEVICE_SHIFT) | ((size) << CARD_BACKUP_TYPE_SIZEBIT_SHIFT) | ((vender) << CARD_BACKUP_TYPE_VENDER_SHIFT))

#define CARD_THREAD_PRIORITY_DEFAULT 4

#define CARD_RETRY_COUNT_MAX 10

#define CARD_PXI_COMMAND_MASK        0x0000003f
#define CARD_PXI_COMMAND_SHIFT       0
#define CARD_PXI_COMMAND_PARAM_MASK  0x01ffffc0
#define CARD_PXI_COMMAND_PARAM_SHIFT 6

#define CARD_PXI_COMMAND_TERMINATE  0x0001
#define CARD_PXI_COMMAND_PULLED_OUT 0x0011

// --------------------
// ENUMS
// --------------------

typedef enum
{
    CARD_RESULT_SUCCESS = 0,
    CARD_RESULT_FAILURE,
    CARD_RESULT_INVALID_PARAM,
    CARD_RESULT_UNSUPPORTED,
    CARD_RESULT_TIMEOUT,
    CARD_RESULT_ERROR,
    CARD_RESULT_NO_RESPONSE,
    CARD_RESULT_CANCELED
} CARDResult;

typedef enum
{
    CARD_BACKUP_TYPE_EEPROM_4KBITS   = CARD_BACKUP_TYPE_DEFINE(EEPROM, 9, 0),
    CARD_BACKUP_TYPE_EEPROM_64KBITS  = CARD_BACKUP_TYPE_DEFINE(EEPROM, 13, 0),
    CARD_BACKUP_TYPE_EEPROM_512KBITS = CARD_BACKUP_TYPE_DEFINE(EEPROM, 16, 0),
    CARD_BACKUP_TYPE_FLASH_2MBITS    = CARD_BACKUP_TYPE_DEFINE(FLASH, 18, 0),
    CARD_BACKUP_TYPE_FLASH_4MBITS    = CARD_BACKUP_TYPE_DEFINE(FLASH, 19, 0),
    CARD_BACKUP_TYPE_FLASH_8MBITS    = CARD_BACKUP_TYPE_DEFINE(FLASH, 20, 0),
    CARD_BACKUP_TYPE_FRAM_256KBITS   = CARD_BACKUP_TYPE_DEFINE(FRAM, 15, 0),
    CARD_BACKUP_TYPE_NOT_USE         = 0
} CARDBackupType;

typedef enum
{
    CARD_REQ_INIT = 0,
    CARD_REQ_ACK,
    CARD_REQ_IDENTIFY,
    CARD_REQ_READ_ID,
    CARD_REQ_READ_ROM,
    CARD_REQ_WRITE_ROM,
    CARD_REQ_READ_BACKUP,
    CARD_REQ_WRITE_BACKUP,
    CARD_REQ_PROGRAM_BACKUP,
    CARD_REQ_VERIFY_BACKUP,
    CARD_REQ_ERASE_PAGE_BACKUP,
    CARD_REQ_ERASE_SECTOR_BACKUP,
    CARD_REQ_ERASE_CHIP_BACKUP,
    CARD_REQ_MAX
} CARDRequest;

typedef enum
{
    CARD_REQUEST_MODE_RECV,
    CARD_REQUEST_MODE_SEND,
    CARD_REQUEST_MODE_SEND_VERIFY,
    CARD_REQUEST_MODE_SPECIAL
} CARDRequestMode;

// --------------------
// FUNCTIONS
// --------------------

void CARD_Init(void);

BOOL CARD_IsAvailable(void);
BOOL CARD_IsEnabled(void);

void CARD_CheckEnabled(void);
void CARD_Enable(BOOL enable);

u32 CARD_GetThreadPriority(void);
u32 CARD_SetThreadPriority(u32 prior);

CARDResult CARD_GetResultCode(void);
const u8 *CARD_GetRomHeader(void);

void CARD_GetCacheFlushThreshold(u32 *icache, u32 *dcache);
void CARD_SetCacheFlushThreshold(u32 icache, u32 dcache);

BOOL CARD_IdentifyBackup(CARDBackupType type);
u32 CARD_GetBackupTotalSize(void);
u32 CARD_GetBackupSectorSize(void);
u32 CARD_GetBackupPageSize(void);

CARDBackupType CARD_GetCurrentBackupType(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_CARD_COMMON_H