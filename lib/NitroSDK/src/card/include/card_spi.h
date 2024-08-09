#ifndef _NITRO_CARD_SPI_H
#define _NITRO_CARD_SPI_H

// --------------------
// CONSTANTS
// --------------------

#define CSPI_CONTINUOUS_ON  0x0040
#define CSPI_CONTINUOUS_OFF 0x0000

#define COMM_WRITE_STATUS  0x01
#define COMM_PROGRAM_PAGE  0x02
#define COMM_READ_ARRAY    0x03
#define COMM_WRITE_DISABLE 0x04
#define COMM_READ_STATUS   0x05
#define COMM_WRITE_ENABLE  0x06

#define COMM_PAGE_WRITE           0x0A
#define COMM_PAGE_ERASE           0xDB
#define COMM_SECTOR_ERASE         0xD8
#define COMM_CHIP_ERASE           0xC7
#define CARDFLASH_READ_BYTES_FAST 0x0B
#define CARDFLASH_DEEP_POWDOWN    0xB9
#define CARDFLASH_WAKEUP          0xAB

#define COMM_STATUS_WIP_BIT   0x01
#define COMM_STATUS_WEL_BIT   0x02
#define COMM_STATUS_BP0_BIT   0x04
#define COMM_STATUS_BP1_BIT   0x08
#define COMM_STATUS_BP2_BIT   0x10
#define COMM_STATUS_WPBEN_BIT 0x80

// --------------------
// FUNCTIONS
// --------------------

void CARDi_IdentifyBackupCore(CARDBackupType type);

#endif // _NITRO_CARD_SPI_H
