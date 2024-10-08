#ifndef NITRO_SPI_COMMON_PM_COMMON_H
#define NITRO_SPI_COMMON_PM_COMMON_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define REG_PMIC_CTL_ADDR      0
#define REG_PMIC_STAT_ADDR     1
#define REG_PMIC_OP_CTL_ADDR   2
#define REG_PMIC_PGA_GAIN_ADDR 3
#define REG_PMIC_BL_CTL_ADDR   4
#define PMIC_REG_NUMS          5

#define PMIC_CTL_SND_PWR        (1 << 0)
#define PMIC_CTL_SND_VOLCTRL    (1 << 1)
#define PMIC_CTL_BKLT1          (1 << 2)
#define PMIC_CTL_BKLT2          (1 << 3)
#define PMIC_CTL_LED_SW         (1 << 4)
#define PMIC_CTL_LED_SP         (1 << 5)
#define PMIC_CTL_PWR_OFF        (1 << 6)
#define PMIC_STAT_VDET          (1 << 0)
#define PMIC_OP_CTL             (1 << 0)
#define PMIC_PGA_GAIN_SHIFT     0
#define PMIC_PGA_GAIN_MASK      (3 << PMIC_PGA_GAIN_SHIFT)
#define PMIC_BL_CTL_BL_SHIFT    0
#define PMIC_BL_CTL_BL_MASK     (3 << PMIC_BL_CTL_BL_SHIFT)
#define PMIC_BL_CTL_ADPT_SW     (1 << 2)
#define PMIC_BL_CTL_ADPT_DETECT (1 << 3)
#define PMIC_BL_CTL_VERSION     (1 << 6)

#define PMIC_REG_READ     1
#define PMIC_REG_WRITE    0
#define PMIC_REG_OP_SHIFT 7
#define PMIC_REG_OP_MASK  1

#define PM_BAUDRATE_4MHZ   0
#define PM_BAUDRATE_2MHZ   1
#define PM_BAUDRATE_1MHZ   2
#define PM_BAUDRATE_512KHZ 3

#define PM_BAUDRATE_PMIC_DEFAULT PM_BAUDRATE_1MHZ

#define PM_TRIGGER_KEY        (1 << 0)
#define PM_TRIGGER_RTC_ALARM  (1 << 1)
#define PM_TRIGGER_COVER_OPEN (1 << 2)
#define PM_TRIGGER_CARD       (1 << 3)
#define PM_TRIGGER_CARTRIDGE  (1 << 4)

#define PM_PAD_LOGIC_OR  (0 << REG_PAD_KEYCNT_LOGIC_SHIFT)
#define PM_PAD_LOGIC_AND (1 << REG_PAD_KEYCNT_LOGIC_SHIFT)

#define PM_BACKLIGHT_RECOVER_TOP_SHIFT    5
#define PM_BACKLIGHT_RECOVER_BOTTOM_SHIFT 6
#define PM_BACKLIGHT_RECOVER_TOP_ON       (1 << PM_BACKLIGHT_RECOVER_TOP_SHIFT)
#define PM_BACKLIGHT_RECOVER_TOP_OFF      (0 << PM_BACKLIGHT_RECOVER_TOP_SHIFT)
#define PM_BACKLIGHT_RECOVER_BOTTOM_ON    (1 << PM_BACKLIGHT_RECOVER_BOTTOM_SHIFT)
#define PM_BACKLIGHT_RECOVER_BOTTOM_OFF   (0 << PM_BACKLIGHT_RECOVER_BOTTOM_SHIFT)

#define PM_COMMAND_SHIFT     22
#define PM_COMMAND_MASK      0x3c00000
#define PM_REG_OP_ADDR_SHIFT 16
#define PM_REG_OP_ADDR_MASK  0x3f0000
#define PM_REG_OP_DATA_SHIFT 0
#define PM_REG_OP_DATA_MASK  0xffff

#define PM_READING         -1
#define PM_SUCCESS         0
#define PM_BUSY            1
#define PM_INVALID_COMMAND 0xffff
#define PM_RESULT_SUCCESS  0
#define PM_RESULT_BUSY     1
#define PM_RESULT_ERROR    2

#define PM_LED_PATTERN_MAX PM_LED_PATTERN_WIRELESS

// --------------------
// TYPES
// --------------------

typedef u32 PMWakeUpTrigger;
typedef u32 PMLogic;

// --------------------
// ENUMS
// --------------------

enum
{
    PM_UTIL_DUMMY = 0,
    PM_UTIL_LED_ON,
    PM_UTIL_LED_BLINK_HIGH_SPEED,
    PM_UTIL_LED_BLINK_LOW_SPEED,
    PM_UTIL_LCD1_BACKLIGHT_ON,
    PM_UTIL_LCD1_BACKLIGHT_OFF,
    PM_UTIL_LCD2_BACKLIGHT_ON,
    PM_UTIL_LCD2_BACKLIGHT_OFF,
    PM_UTIL_LCD12_BACKLIGHT_ON,
    PM_UTIL_LCD12_BACKLIGHT_OFF,
    PM_UTIL_SOUND_POWER_ON,
    PM_UTIL_SOUND_POWER_OFF,
    PM_UTIL_SOUND_VOL_CTRL_ON,
    PM_UTIL_SOUND_VOL_CTRL_OFF,
    PM_UTIL_FORCE_POWER_OFF,
    PM_UTIL_FORCE_POWER_ON
};

typedef enum
{
    PM_LED_PATTERN_NONE       = 0,
    PM_LED_PATTERN_ON         = 1,
    PM_LED_PATTERN_BLINK_LOW  = 2,
    PM_LED_PATTERN_BLINK_HIGH = 3,
    PM_LED_PATTERN_BLINK1     = 4,
    PM_LED_PATTERN_BLINK2     = 5,
    PM_LED_PATTERN_BLINK3     = 6,
    PM_LED_PATTERN_BLINK4     = 7,
    PM_LED_PATTERN_BLINK5     = 8,
    PM_LED_PATTERN_BLINK6     = 9,
    PM_LED_PATTERN_BLINK8     = 10,
    PM_LED_PATTERN_BLINK10    = 11,
    PM_LED_PATTERN_PATTERN1   = 12,
    PM_LED_PATTERN_PATTERN2   = 13,
    PM_LED_PATTERN_PATTERN3   = 14,
    PM_LED_PATTERN_WIRELESS   = 15
} PMLEDPattern;

typedef enum
{
    PM_LED_NONE       = 0,
    PM_LED_ON         = 1,
    PM_LED_BLINK_LOW  = 2,
    PM_LED_BLINK_HIGH = 3
} PMLEDStatus;

#ifdef __cplusplus
}
#endif

#endif // NITRO_SPI_COMMON_PM_COMMON_H
