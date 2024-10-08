#ifndef NITRO_HW_SYSTEMCONTROL_H
#define NITRO_HW_SYSTEMCONTROL_H

#define HW_ICACHE_SIZE     0x2000
#define HW_DCACHE_SIZE     0x1000
#define HW_CACHE_LINE_SIZE 32

#define HW_SYSTEM_CLOCK 33514000

#define HW_CPU_CLOCK_ARM7 33513982
#define HW_CPU_CLOCK_ARM9 67027964

#ifdef SDK_ARM7
#define HW_CPU_CLOCK HW_CPU_CLOCK_ARM7
#else
#define HW_CPU_CLOCK HW_CPU_CLOCK_ARM9
#endif

#define HW_PSR_CPU_MODE_MASK 0x1f

#define HW_PSR_USER_MODE  0x10
#define HW_PSR_FIQ_MODE   0x11
#define HW_PSR_IRQ_MODE   0x12
#define HW_PSR_SVC_MODE   0x13
#define HW_PSR_ABORT_MODE 0x17
#define HW_PSR_UNDEF_MODE 0x1b
#define HW_PSR_SYS_MODE   0x1f

#define HW_PSR_ARM_STATE   0x0
#define HW_PSR_THUMB_STATE 0x20

#define HW_PSR_FIQ_DISABLE     0x40
#define HW_PSR_IRQ_DISABLE     0x80
#define HW_PSR_IRQ_FIQ_DISABLE 0xc0

#define HW_PSR_Q_FLAG 0x08000000
#define HW_PSR_V_FLAG 0x10000000
#define HW_PSR_C_FLAG 0x20000000
#define HW_PSR_Z_FLAG 0x40000000
#define HW_PSR_N_FLAG 0x80000000

// Register 1 (Master control)

#define HW_C1_SB1_BITSET 0x00000078

#define HW_C1_ITCM_LOAD_MODE       0x00080000
#define HW_C1_DTCM_LOAD_MODE       0x00020000
#define HW_C1_ITCM_ENABLE          0x00040000
#define HW_C1_DTCM_ENABLE          0x00010000
#define HW_C1_LD_INTERWORK_DISABLE 0x00008000
#define HW_C1_CACHE_ROUND_ROBIN    0x00004000
#define HW_C1_CACHE_PSEUDO_RANDOM  0x00000000
#define HW_C1_EXCEPT_VEC_UPPER     0x00002000
#define HW_C1_EXCEPT_VEC_LOWER     0x00000000
#define HW_C1_ICACHE_ENABLE        0x00001000
#define HW_C1_DCACHE_ENABLE        0x00000004
#define HW_C1_LITTLE_ENDIAN        0x00000000
#define HW_C1_BIG_ENDIAN           0x00000080
#define HW_C1_PROTECT_UNIT_ENABLE  0x00000001

#define HW_C1_ICACHE_ENABLE_SHIFT 12
#define HW_C1_DCACHE_ENABLE_SHIFT 2

// Register 2 (Protection region cache setting)

#define HW_C2_PR0_SFT 0
#define HW_C2_PR1_SFT 1
#define HW_C2_PR2_SFT 2
#define HW_C2_PR3_SFT 3
#define HW_C2_PR4_SFT 4
#define HW_C2_PR5_SFT 5
#define HW_C2_PR6_SFT 6
#define HW_C2_PR7_SFT 7

// Register 3 (Protection region write buffer settings)

#define HW_C3_PR0_SFT 0
#define HW_C3_PR1_SFT 1
#define HW_C3_PR2_SFT 2
#define HW_C3_PR3_SFT 3
#define HW_C3_PR4_SFT 4
#define HW_C3_PR5_SFT 5
#define HW_C3_PR6_SFT 6
#define HW_C3_PR7_SFT 7

#define HW_C5_PERMIT_MASK 0xf

#define HW_C5_PERMIT_NA 0
#define HW_C5_PERMIT_RW 1
#define HW_C5_PERMIT_RO 5

#define HW_C5_PR0_SFT 0
#define HW_C5_PR1_SFT 4
#define HW_C5_PR2_SFT 8
#define HW_C5_PR3_SFT 12
#define HW_C5_PR4_SFT 16
#define HW_C5_PR5_SFT 20
#define HW_C5_PR6_SFT 24
#define HW_C5_PR7_SFT 28

// Register 6 (protection region base address / size)

#define HW_C6_PR_SIZE_MASK 0x0000003e
#define HW_C6_PR_BASE_MASK 0xfffff000

#define HW_C6_PR_SIZE_SHIFT 1
#define HW_C6_PR_BASE_SHIFT 12

#define HW_C6_PR_ENABLE  1
#define HW_C6_PR_DISABLE 0

#define HW_C6_PR_4KB   0x16
#define HW_C6_PR_8KB   0x18
#define HW_C6_PR_16KB  0x1a
#define HW_C6_PR_32KB  0x1c
#define HW_C6_PR_64KB  0x1e
#define HW_C6_PR_128KB 0x20
#define HW_C6_PR_256KB 0x22
#define HW_C6_PR_512KB 0x24
#define HW_C6_PR_1MB   0x26
#define HW_C6_PR_2MB   0x28
#define HW_C6_PR_4MB   0x2a
#define HW_C6_PR_8MB   0x2c
#define HW_C6_PR_16MB  0x2e
#define HW_C6_PR_32MB  0x30
#define HW_C6_PR_64MB  0x32
#define HW_C6_PR_128MB 0x34
#define HW_C6_PR_256MB 0x36
#define HW_C6_PR_512MB 0x38
#define HW_C6_PR_1GB   0x3a
#define HW_C6_PR_2GB   0x3c
#define HW_C6_PR_4GB   0x3e

// Register  7.13 (Instruction cache prefetch)

#define HW_C7_ICACHE_PREFCHP_MASK 0xffffffe0

// Registers 7.10, 7.14 (Cache index operation)

#define HW_C7_ICACHE_INDEX_MASK 0x00000fe0
#define HW_C7_DCACHE_INDEX_MASK 0x000003e0
#define HW_C7_CACHE_SET_NO_MASK 0xc0000000

#define HW_C7_CACHE_INDEX_SHIFT  5
#define HW_C7_CACHE_SET_NO_SHIFT 30

// Register 9.0 (cache lockdown)

#define HW_C9_LOCKDOWN_SET_NO_MASK 0x00000003

#define HW_C9_LOCKDOWN_SET_NO_SHIFT 0

#define HW_C9_LOCKDOWN_LOAD_MODE 0x80000000

// Register 9.1 (TCM base address / size)

#define HW_C9_TCMR_SIZE_MASK 0x0000003e
#define HW_C9_TCMR_BASE_MASK 0xfffff000

#define HW_C9_TCMR_SIZE_SHIFT 1
#define HW_C9_TCMR_BASE_SHIFT 12

#define HW_C9_TCMR_4KB   0x06
#define HW_C9_TCMR_8KB   0x08
#define HW_C9_TCMR_16KB  0x0a
#define HW_C9_TCMR_32KB  0x0c
#define HW_C9_TCMR_64KB  0x0e
#define HW_C9_TCMR_128KB 0x10
#define HW_C9_TCMR_256KB 0x12
#define HW_C9_TCMR_512KB 0x14
#define HW_C9_TCMR_1MB   0x16
#define HW_C9_TCMR_2MB   0x18
#define HW_C9_TCMR_4MB   0x1a
#define HW_C9_TCMR_8MB   0x1c
#define HW_C9_TCMR_16MB  0x1e
#define HW_C9_TCMR_32MB  0x20
#define HW_C9_TCMR_64MB  0x22
#define HW_C9_TCMR_128MB 0x24
#define HW_C9_TCMR_256MB 0x26
#define HW_C9_TCMR_512MB 0x28
#define HW_C9_TCMR_1GB   0x2a
#define HW_C9_TCMR_2GB   0x2c
#define HW_C9_TCMR_4GB   0x2e

#endif // NITRO_HW_SYSTEMCONTROL_H
