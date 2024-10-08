#define REG_SIODATA32_OFFSET 0x120
#define REG_SIODATA32_ADDR   (HW_REG_BASE + REG_SIODATA32_OFFSET)
#define reg_EXI_SIODATA32    (*(REGType32v *)REG_SIODATA32_ADDR)

#define REG_SIOMULTI0_OFFSET 0x120
#define REG_SIOMULTI0_ADDR   (HW_REG_BASE + REG_SIOMULTI0_OFFSET)
#define reg_EXI_SIOMULTI0    (*(REGType16v *)REG_SIOMULTI0_ADDR)

#define REG_SIOMULTI1_OFFSET 0x122
#define REG_SIOMULTI1_ADDR   (HW_REG_BASE + REG_SIOMULTI1_OFFSET)
#define reg_EXI_SIOMULTI1    (*(REGType16v *)REG_SIOMULTI1_ADDR)

#define REG_SIOMULTI2_OFFSET 0x124
#define REG_SIOMULTI2_ADDR   (HW_REG_BASE + REG_SIOMULTI2_OFFSET)
#define reg_EXI_SIOMULTI2    (*(REGType16v *)REG_SIOMULTI2_ADDR)

#define REG_SIOMULTI3_OFFSET 0x126
#define REG_SIOMULTI3_ADDR   (HW_REG_BASE + REG_SIOMULTI3_OFFSET)
#define reg_EXI_SIOMULTI3    (*(REGType16v *)REG_SIOMULTI3_ADDR)

#define REG_SIOCNT_OFFSET 0x128
#define REG_SIOCNT_ADDR   (HW_REG_BASE + REG_SIOCNT_OFFSET)
#define reg_EXI_SIOCNT    (*(REGType16v *)REG_SIOCNT_ADDR)

#define REG_SIOCNT_MULTI_OFFSET 0x128
#define REG_SIOCNT_MULTI_ADDR   (HW_REG_BASE + REG_SIOCNT_MULTI_OFFSET)
#define reg_EXI_SIOCNT_MULTI    (*(REGType16v *)REG_SIOCNT_MULTI_ADDR)

#define REG_SIOCNT_UART_OFFSET 0x128
#define REG_SIOCNT_UART_ADDR   (HW_REG_BASE + REG_SIOCNT_UART_OFFSET)
#define reg_EXI_SIOCNT_UART    (*(REGType16v *)REG_SIOCNT_UART_ADDR)

#define REG_SIOCNT_H_OFFSET 0x12a
#define REG_SIOCNT_H_ADDR   (HW_REG_BASE + REG_SIOCNT_H_OFFSET)
#define reg_EXI_SIOCNT_H    (*(REGType16v *)REG_SIOCNT_H_ADDR)

#define REG_SIOMLT_SEND_OFFSET 0x12a
#define REG_SIOMLT_SEND_ADDR   (HW_REG_BASE + REG_SIOMLT_SEND_OFFSET)
#define reg_EXI_SIOMLT_SEND    (*(REGType16v *)REG_SIOMLT_SEND_ADDR)

#define REG_SIODATA8_OFFSET 0x12a
#define REG_SIODATA8_ADDR   (HW_REG_BASE + REG_SIODATA8_OFFSET)
#define reg_EXI_SIODATA8    (*(REGType16v *)REG_SIODATA8_ADDR)

#define REG_SIOSEL_OFFSET 0x12c
#define REG_SIOSEL_ADDR   (HW_REG_BASE + REG_SIOSEL_OFFSET)
#define reg_EXI_SIOSEL    (*(REGType16v *)REG_SIOSEL_ADDR)

#define REG_RCNT0_L_OFFSET 0x134
#define REG_RCNT0_L_ADDR   (HW_REG_BASE + REG_RCNT0_L_OFFSET)
#define reg_EXI_RCNT0_L    (*(REGType16v *)REG_RCNT0_L_ADDR)

#define REG_RCNT0_H_OFFSET 0x136
#define REG_RCNT0_H_ADDR   (HW_REG_BASE + REG_RCNT0_H_OFFSET)
#define reg_EXI_RCNT0_H    (*(REGType16v *)REG_RCNT0_H_ADDR)

#define REG_RCNT1_OFFSET 0x138
#define REG_RCNT1_ADDR   (HW_REG_BASE + REG_RCNT1_OFFSET)
#define reg_EXI_RCNT1    (*(REGType16v *)REG_RCNT1_ADDR)

#define REG_JOYCNT_OFFSET 0x140
#define REG_JOYCNT_ADDR   (HW_REG_BASE + REG_JOYCNT_OFFSET)
#define reg_EXI_JOYCNT    (*(REGType16v *)REG_JOYCNT_ADDR)

#define REG_JOY_RECV_OFFSET 0x150
#define REG_JOY_RECV_ADDR   (HW_REG_BASE + REG_JOY_RECV_OFFSET)
#define reg_EXI_JOY_RECV    (*(REGType32v *)REG_JOY_RECV_ADDR)

#define REG_JOY_TRANS_OFFSET 0x154
#define REG_JOY_TRANS_ADDR   (HW_REG_BASE + REG_JOY_TRANS_OFFSET)
#define reg_EXI_JOY_TRANS    (*(REGType32v *)REG_JOY_TRANS_ADDR)

#define REG_JOY_STAT_OFFSET 0x158
#define REG_JOY_STAT_ADDR   (HW_REG_BASE + REG_JOY_STAT_OFFSET)
#define reg_EXI_JOY_STAT    (*(REGType16v *)REG_JOY_STAT_ADDR)



#define REG_EXI_SIODATA32_H_SHIFT 16
#define REG_EXI_SIODATA32_H_SIZE  16
#define REG_EXI_SIODATA32_H_MASK  0xffff0000

#define REG_EXI_SIODATA32_L_SHIFT 0
#define REG_EXI_SIODATA32_L_SIZE  16
#define REG_EXI_SIODATA32_L_MASK  0x0000ffff

#ifndef SDK_ASM
#define REG_EXI_SIODATA32_FIELD(h, l) (u32)(((u32)(h) << REG_EXI_SIODATA32_H_SHIFT) | ((u32)(l) << REG_EXI_SIODATA32_L_SHIFT))
#endif

#define REG_EXI_SIOMULTI0_DATA_SHIFT 0
#define REG_EXI_SIOMULTI0_DATA_SIZE  16
#define REG_EXI_SIOMULTI0_DATA_MASK  0xffff

#ifndef SDK_ASM
#define REG_EXI_SIOMULTI0_FIELD(data) (u16)(((u32)(data) << REG_EXI_SIOMULTI0_DATA_SHIFT))
#endif

#define REG_EXI_SIOMULTI1_DATA_SHIFT 0
#define REG_EXI_SIOMULTI1_DATA_SIZE  16
#define REG_EXI_SIOMULTI1_DATA_MASK  0xffff

#ifndef SDK_ASM
#define REG_EXI_SIOMULTI1_FIELD(data) (u16)(((u32)(data) << REG_EXI_SIOMULTI1_DATA_SHIFT))
#endif

#define REG_EXI_SIOMULTI2_DATA_SHIFT 0
#define REG_EXI_SIOMULTI2_DATA_SIZE  16
#define REG_EXI_SIOMULTI2_DATA_MASK  0xffff

#ifndef SDK_ASM
#define REG_EXI_SIOMULTI2_FIELD(data) (u16)(((u32)(data) << REG_EXI_SIOMULTI2_DATA_SHIFT))
#endif

#define REG_EXI_SIOMULTI3_DATA_SHIFT 0
#define REG_EXI_SIOMULTI3_DATA_SIZE  16
#define REG_EXI_SIOMULTI3_DATA_MASK  0xffff

#ifndef SDK_ASM
#define REG_EXI_SIOMULTI3_FIELD(data) (u16)(((u32)(data) << REG_EXI_SIOMULTI3_DATA_SHIFT))
#endif

#define REG_EXI_SIOCNT_CKUP_SHIFT 15
#define REG_EXI_SIOCNT_CKUP_SIZE  1
#define REG_EXI_SIOCNT_CKUP_MASK  0x8000

#define REG_EXI_SIOCNT_I_SHIFT 14
#define REG_EXI_SIOCNT_I_SIZE  1
#define REG_EXI_SIOCNT_I_MASK  0x4000

#define REG_EXI_SIOCNT_MD1_SHIFT 13
#define REG_EXI_SIOCNT_MD1_SIZE  1
#define REG_EXI_SIOCNT_MD1_MASK  0x2000

#define REG_EXI_SIOCNT_BITLEN_SHIFT 12
#define REG_EXI_SIOCNT_BITLEN_SIZE  1
#define REG_EXI_SIOCNT_BITLEN_MASK  0x1000

#define REG_EXI_SIOCNT_START_SHIFT 7
#define REG_EXI_SIOCNT_START_SIZE  1
#define REG_EXI_SIOCNT_START_MASK  0x0080

#define REG_EXI_SIOCNT_TSEND_SHIFT 3
#define REG_EXI_SIOCNT_TSEND_SIZE  1
#define REG_EXI_SIOCNT_TSEND_MASK  0x0008

#define REG_EXI_SIOCNT_TRECV_SHIFT 2
#define REG_EXI_SIOCNT_TRECV_SIZE  1
#define REG_EXI_SIOCNT_TRECV_MASK  0x0004

#define REG_EXI_SIOCNT_SCLOCKHZ_SHIFT 1
#define REG_EXI_SIOCNT_SCLOCKHZ_SIZE  1
#define REG_EXI_SIOCNT_SCLOCKHZ_MASK  0x0002

#define REG_EXI_SIOCNT_SCLOCK_SHIFT 0
#define REG_EXI_SIOCNT_SCLOCK_SIZE  1
#define REG_EXI_SIOCNT_SCLOCK_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_SIOCNT_FIELD(ckup, i, md1, bitlen, start, tsend, trecv, sclockhz, sclock)                                                                                          \
    (u16)(((u32)(ckup) << REG_EXI_SIOCNT_CKUP_SHIFT) | ((u32)(i) << REG_EXI_SIOCNT_I_SHIFT) | ((u32)(md1) << REG_EXI_SIOCNT_MD1_SHIFT)                                             \
          | ((u32)(bitlen) << REG_EXI_SIOCNT_BITLEN_SHIFT) | ((u32)(start) << REG_EXI_SIOCNT_START_SHIFT) | ((u32)(tsend) << REG_EXI_SIOCNT_TSEND_SHIFT)                           \
          | ((u32)(trecv) << REG_EXI_SIOCNT_TRECV_SHIFT) | ((u32)(sclockhz) << REG_EXI_SIOCNT_SCLOCKHZ_SHIFT) | ((u32)(sclock) << REG_EXI_SIOCNT_SCLOCK_SHIFT))
#endif

#define REG_EXI_SIOCNT_MULTI_CKUP_SHIFT 15
#define REG_EXI_SIOCNT_MULTI_CKUP_SIZE  1
#define REG_EXI_SIOCNT_MULTI_CKUP_MASK  0x8000

#define REG_EXI_SIOCNT_MULTI_I_SHIFT 14
#define REG_EXI_SIOCNT_MULTI_I_SIZE  1
#define REG_EXI_SIOCNT_MULTI_I_MASK  0x4000

#define REG_EXI_SIOCNT_MULTI_MD1_SHIFT 13
#define REG_EXI_SIOCNT_MULTI_MD1_SIZE  1
#define REG_EXI_SIOCNT_MULTI_MD1_MASK  0x2000

#define REG_EXI_SIOCNT_MULTI_MD0_SHIFT 12
#define REG_EXI_SIOCNT_MULTI_MD0_SIZE  1
#define REG_EXI_SIOCNT_MULTI_MD0_MASK  0x1000

#define REG_EXI_SIOCNT_MULTI_START_SHIFT 7
#define REG_EXI_SIOCNT_MULTI_START_SIZE  1
#define REG_EXI_SIOCNT_MULTI_START_MASK  0x0080

#define REG_EXI_SIOCNT_MULTI_ERROR_SHIFT 6
#define REG_EXI_SIOCNT_MULTI_ERROR_SIZE  1
#define REG_EXI_SIOCNT_MULTI_ERROR_MASK  0x0040

#define REG_EXI_SIOCNT_MULTI_MULTIID_SHIFT 4
#define REG_EXI_SIOCNT_MULTI_MULTIID_SIZE  2
#define REG_EXI_SIOCNT_MULTI_MULTIID_MASK  0x0030

#define REG_EXI_SIOCNT_MULTI_SDMON_SHIFT 3
#define REG_EXI_SIOCNT_MULTI_SDMON_SIZE  1
#define REG_EXI_SIOCNT_MULTI_SDMON_MASK  0x0008

#define REG_EXI_SIOCNT_MULTI_SIMON_SHIFT 2
#define REG_EXI_SIOCNT_MULTI_SIMON_SIZE  1
#define REG_EXI_SIOCNT_MULTI_SIMON_MASK  0x0004

#define REG_EXI_SIOCNT_MULTI_BAUD_SHIFT 0
#define REG_EXI_SIOCNT_MULTI_BAUD_SIZE  2
#define REG_EXI_SIOCNT_MULTI_BAUD_MASK  0x0003

#ifndef SDK_ASM
#define REG_EXI_SIOCNT_MULTI_FIELD(ckup, i, md1, md0, start, error, multiid, sdmon, simon, baud)                                                                                   \
    (u16)(((u32)(ckup) << REG_EXI_SIOCNT_MULTI_CKUP_SHIFT) | ((u32)(i) << REG_EXI_SIOCNT_MULTI_I_SHIFT) | ((u32)(md1) << REG_EXI_SIOCNT_MULTI_MD1_SHIFT)                           \
          | ((u32)(md0) << REG_EXI_SIOCNT_MULTI_MD0_SHIFT) | ((u32)(start) << REG_EXI_SIOCNT_MULTI_START_SHIFT) | ((u32)(error) << REG_EXI_SIOCNT_MULTI_ERROR_SHIFT)               \
          | ((u32)(multiid) << REG_EXI_SIOCNT_MULTI_MULTIID_SHIFT) | ((u32)(sdmon) << REG_EXI_SIOCNT_MULTI_SDMON_SHIFT) | ((u32)(simon) << REG_EXI_SIOCNT_MULTI_SIMON_SHIFT)       \
          | ((u32)(baud) << REG_EXI_SIOCNT_MULTI_BAUD_SHIFT))
#endif

#define REG_EXI_SIOCNT_UART_CKUP_SHIFT 15
#define REG_EXI_SIOCNT_UART_CKUP_SIZE  1
#define REG_EXI_SIOCNT_UART_CKUP_MASK  0x8000

#define REG_EXI_SIOCNT_UART_MD1_SHIFT 13
#define REG_EXI_SIOCNT_UART_MD1_SIZE  1
#define REG_EXI_SIOCNT_UART_MD1_MASK  0x2000

#define REG_EXI_SIOCNT_UART_MD0_SHIFT 12
#define REG_EXI_SIOCNT_UART_MD0_SIZE  1
#define REG_EXI_SIOCNT_UART_MD0_MASK  0x1000

#define REG_EXI_SIOCNT_UART_RECVEF_SHIFT 11
#define REG_EXI_SIOCNT_UART_RECVEF_SIZE  1
#define REG_EXI_SIOCNT_UART_RECVEF_MASK  0x0800

#define REG_EXI_SIOCNT_UART_SENDEF_SHIFT 10
#define REG_EXI_SIOCNT_UART_SENDEF_SIZE  1
#define REG_EXI_SIOCNT_UART_SENDEF_MASK  0x0400

#define REG_EXI_SIOCNT_UART_PARITYEF_SHIFT 9
#define REG_EXI_SIOCNT_UART_PARITYEF_SIZE  1
#define REG_EXI_SIOCNT_UART_PARITYEF_MASK  0x0200

#define REG_EXI_SIOCNT_UART_FIFOEF_SHIFT 8
#define REG_EXI_SIOCNT_UART_FIFOEF_SIZE  1
#define REG_EXI_SIOCNT_UART_FIFOEF_MASK  0x0100

#define REG_EXI_SIOCNT_UART_DATALEN_SHIFT 7
#define REG_EXI_SIOCNT_UART_DATALEN_SIZE  1
#define REG_EXI_SIOCNT_UART_DATALEN_MASK  0x0080

#define REG_EXI_SIOCNT_UART_ERROR_SHIFT 6
#define REG_EXI_SIOCNT_UART_ERROR_SIZE  1
#define REG_EXI_SIOCNT_UART_ERROR_MASK  0x0040

#define REG_EXI_SIOCNT_UART_RECV_SHIFT 5
#define REG_EXI_SIOCNT_UART_RECV_SIZE  1
#define REG_EXI_SIOCNT_UART_RECV_MASK  0x0020

#define REG_EXI_SIOCNT_UART_SEND_SHIFT 4
#define REG_EXI_SIOCNT_UART_SEND_SIZE  1
#define REG_EXI_SIOCNT_UART_SEND_MASK  0x0010

#define REG_EXI_SIOCNT_UART_PARITYCNT_SHIFT 3
#define REG_EXI_SIOCNT_UART_PARITYCNT_SIZE  1
#define REG_EXI_SIOCNT_UART_PARITYCNT_MASK  0x0008

#define REG_EXI_SIOCNT_UART_CTS_SHIFT 2
#define REG_EXI_SIOCNT_UART_CTS_SIZE  1
#define REG_EXI_SIOCNT_UART_CTS_MASK  0x0004

#define REG_EXI_SIOCNT_UART_BAUD_SHIFT 0
#define REG_EXI_SIOCNT_UART_BAUD_SIZE  2
#define REG_EXI_SIOCNT_UART_BAUD_MASK  0x0003

#ifndef SDK_ASM
#define REG_EXI_SIOCNT_UART_FIELD(ckup, md1, md0, recvef, sendef, parityef, fifoef, datalen, error, recv, send, paritycnt, cts, baud)                                              \
    (u16)(((u32)(ckup) << REG_EXI_SIOCNT_UART_CKUP_SHIFT) | ((u32)(md1) << REG_EXI_SIOCNT_UART_MD1_SHIFT) | ((u32)(md0) << REG_EXI_SIOCNT_UART_MD0_SHIFT)                          \
          | ((u32)(recvef) << REG_EXI_SIOCNT_UART_RECVEF_SHIFT) | ((u32)(sendef) << REG_EXI_SIOCNT_UART_SENDEF_SHIFT) | ((u32)(parityef) << REG_EXI_SIOCNT_UART_PARITYEF_SHIFT)    \
          | ((u32)(fifoef) << REG_EXI_SIOCNT_UART_FIFOEF_SHIFT) | ((u32)(datalen) << REG_EXI_SIOCNT_UART_DATALEN_SHIFT) | ((u32)(error) << REG_EXI_SIOCNT_UART_ERROR_SHIFT)        \
          | ((u32)(recv) << REG_EXI_SIOCNT_UART_RECV_SHIFT) | ((u32)(send) << REG_EXI_SIOCNT_UART_SEND_SHIFT) | ((u32)(paritycnt) << REG_EXI_SIOCNT_UART_PARITYCNT_SHIFT)          \
          | ((u32)(cts) << REG_EXI_SIOCNT_UART_CTS_SHIFT) | ((u32)(baud) << REG_EXI_SIOCNT_UART_BAUD_SHIFT))
#endif

#define REG_EXI_SIOCNT_H_RFFUL_SHIFT 15
#define REG_EXI_SIOCNT_H_RFFUL_SIZE  1
#define REG_EXI_SIOCNT_H_RFFUL_MASK  0x8000

#define REG_EXI_SIOCNT_H_TFEMP_SHIFT 14
#define REG_EXI_SIOCNT_H_TFEMP_SIZE  1
#define REG_EXI_SIOCNT_H_TFEMP_MASK  0x4000

#ifndef SDK_ASM
#define REG_EXI_SIOCNT_H_FIELD(rfful, tfemp) (u16)(((u32)(rfful) << REG_EXI_SIOCNT_H_RFFUL_SHIFT) | ((u32)(tfemp) << REG_EXI_SIOCNT_H_TFEMP_SHIFT))
#endif

#define REG_EXI_SIOMLT_SEND_DATA_SHIFT 0
#define REG_EXI_SIOMLT_SEND_DATA_SIZE  16
#define REG_EXI_SIOMLT_SEND_DATA_MASK  0xffff

#ifndef SDK_ASM
#define REG_EXI_SIOMLT_SEND_FIELD(data) (u16)(((u32)(data) << REG_EXI_SIOMLT_SEND_DATA_SHIFT))
#endif

#define REG_EXI_SIODATA8_DATA_SHIFT 0
#define REG_EXI_SIODATA8_DATA_SIZE  8
#define REG_EXI_SIODATA8_DATA_MASK  0x00ff

#ifndef SDK_ASM
#define REG_EXI_SIODATA8_FIELD(data) (u16)(((u32)(data) << REG_EXI_SIODATA8_DATA_SHIFT))
#endif

#define REG_EXI_SIOSEL_SEL_SHIFT 0
#define REG_EXI_SIOSEL_SEL_SIZE  1
#define REG_EXI_SIOSEL_SEL_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_SIOSEL_FIELD(sel) (u16)(((u32)(sel) << REG_EXI_SIOSEL_SEL_SHIFT))
#endif

#define REG_EXI_RCNT0_L_RE1_SHIFT 15
#define REG_EXI_RCNT0_L_RE1_SIZE  1
#define REG_EXI_RCNT0_L_RE1_MASK  0x8000

#define REG_EXI_RCNT0_L_RE0_SHIFT 14
#define REG_EXI_RCNT0_L_RE0_SIZE  1
#define REG_EXI_RCNT0_L_RE0_MASK  0x4000

#define REG_EXI_RCNT0_L_I_SHIFT 8
#define REG_EXI_RCNT0_L_I_SIZE  1
#define REG_EXI_RCNT0_L_I_MASK  0x0100

#define REG_EXI_RCNT0_L_DIR_SO_SHIFT 7
#define REG_EXI_RCNT0_L_DIR_SO_SIZE  1
#define REG_EXI_RCNT0_L_DIR_SO_MASK  0x0080

#define REG_EXI_RCNT0_L_DIR_SI_SHIFT 6
#define REG_EXI_RCNT0_L_DIR_SI_SIZE  1
#define REG_EXI_RCNT0_L_DIR_SI_MASK  0x0040

#define REG_EXI_RCNT0_L_DIR_SD_SHIFT 5
#define REG_EXI_RCNT0_L_DIR_SD_SIZE  1
#define REG_EXI_RCNT0_L_DIR_SD_MASK  0x0020

#define REG_EXI_RCNT0_L_DIR_SC_SHIFT 4
#define REG_EXI_RCNT0_L_DIR_SC_SIZE  1
#define REG_EXI_RCNT0_L_DIR_SC_MASK  0x0010

#define REG_EXI_RCNT0_L_DATA_SO_SHIFT 3
#define REG_EXI_RCNT0_L_DATA_SO_SIZE  1
#define REG_EXI_RCNT0_L_DATA_SO_MASK  0x0008

#define REG_EXI_RCNT0_L_DATA_SI_SHIFT 2
#define REG_EXI_RCNT0_L_DATA_SI_SIZE  1
#define REG_EXI_RCNT0_L_DATA_SI_MASK  0x0004

#define REG_EXI_RCNT0_L_DATA_SD_SHIFT 1
#define REG_EXI_RCNT0_L_DATA_SD_SIZE  1
#define REG_EXI_RCNT0_L_DATA_SD_MASK  0x0002

#define REG_EXI_RCNT0_L_DATA_SC_SHIFT 0
#define REG_EXI_RCNT0_L_DATA_SC_SIZE  1
#define REG_EXI_RCNT0_L_DATA_SC_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_RCNT0_L_FIELD(re1, re0, i, dir_so, dir_si, dir_sd, dir_sc, data_so, data_si, data_sd, data_sc)                                                                     \
    (u16)(((u32)(re1) << REG_EXI_RCNT0_L_RE1_SHIFT) | ((u32)(re0) << REG_EXI_RCNT0_L_RE0_SHIFT) | ((u32)(i) << REG_EXI_RCNT0_L_I_SHIFT)                                            \
          | ((u32)(dir_so) << REG_EXI_RCNT0_L_DIR_SO_SHIFT) | ((u32)(dir_si) << REG_EXI_RCNT0_L_DIR_SI_SHIFT) | ((u32)(dir_sd) << REG_EXI_RCNT0_L_DIR_SD_SHIFT)                    \
          | ((u32)(dir_sc) << REG_EXI_RCNT0_L_DIR_SC_SHIFT) | ((u32)(data_so) << REG_EXI_RCNT0_L_DATA_SO_SHIFT) | ((u32)(data_si) << REG_EXI_RCNT0_L_DATA_SI_SHIFT)                \
          | ((u32)(data_sd) << REG_EXI_RCNT0_L_DATA_SD_SHIFT) | ((u32)(data_sc) << REG_EXI_RCNT0_L_DATA_SC_SHIFT))
#endif

#if !defined(SDK_TS)

#define REG_EXI_RCNT0_H_DIR_R7_SHIFT 15
#define REG_EXI_RCNT0_H_DIR_R7_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R7_MASK  0x8000

#define REG_EXI_RCNT0_H_DIR_R6_SHIFT 14
#define REG_EXI_RCNT0_H_DIR_R6_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R6_MASK  0x4000

#define REG_EXI_RCNT0_H_DIR_R5_SHIFT 13
#define REG_EXI_RCNT0_H_DIR_R5_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R5_MASK  0x2000

#define REG_EXI_RCNT0_H_DIR_R4_SHIFT 12
#define REG_EXI_RCNT0_H_DIR_R4_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R4_MASK  0x1000

#define REG_EXI_RCNT0_H_DIR_R3_SHIFT 11
#define REG_EXI_RCNT0_H_DIR_R3_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R3_MASK  0x0800

#define REG_EXI_RCNT0_H_DIR_R2_SHIFT 10
#define REG_EXI_RCNT0_H_DIR_R2_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R2_MASK  0x0400

#define REG_EXI_RCNT0_H_DIR_R1_SHIFT 9
#define REG_EXI_RCNT0_H_DIR_R1_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R1_MASK  0x0200

#define REG_EXI_RCNT0_H_DIR_R0_SHIFT 8
#define REG_EXI_RCNT0_H_DIR_R0_SIZE  1
#define REG_EXI_RCNT0_H_DIR_R0_MASK  0x0100

#define REG_EXI_RCNT0_H_DATA_R7_SHIFT 7
#define REG_EXI_RCNT0_H_DATA_R7_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R7_MASK  0x0080

#define REG_EXI_RCNT0_H_DATA_R6_SHIFT 6
#define REG_EXI_RCNT0_H_DATA_R6_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R6_MASK  0x0040

#define REG_EXI_RCNT0_H_DATA_R5_SHIFT 5
#define REG_EXI_RCNT0_H_DATA_R5_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R5_MASK  0x0020

#define REG_EXI_RCNT0_H_DATA_R4_SHIFT 4
#define REG_EXI_RCNT0_H_DATA_R4_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R4_MASK  0x0010

#define REG_EXI_RCNT0_H_DATA_R3_SHIFT 3
#define REG_EXI_RCNT0_H_DATA_R3_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R3_MASK  0x0008

#define REG_EXI_RCNT0_H_DATA_R2_SHIFT 2
#define REG_EXI_RCNT0_H_DATA_R2_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R2_MASK  0x0004

#define REG_EXI_RCNT0_H_DATA_R1_SHIFT 1
#define REG_EXI_RCNT0_H_DATA_R1_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R1_MASK  0x0002

#define REG_EXI_RCNT0_H_DATA_R0_SHIFT 0
#define REG_EXI_RCNT0_H_DATA_R0_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R0_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_RCNT0_H_FIELD(dir_r7, dir_r6, dir_r5, dir_r4, dir_r3, dir_r2, dir_r1, dir_r0, data_r7, data_r6, data_r5, data_r4, data_r3, data_r2, data_r1, data_r0)              \
    (u16)(((u32)(dir_r7) << REG_EXI_RCNT0_H_DIR_R7_SHIFT) | ((u32)(dir_r6) << REG_EXI_RCNT0_H_DIR_R6_SHIFT) | ((u32)(dir_r5) << REG_EXI_RCNT0_H_DIR_R5_SHIFT)                      \
          | ((u32)(dir_r4) << REG_EXI_RCNT0_H_DIR_R4_SHIFT) | ((u32)(dir_r3) << REG_EXI_RCNT0_H_DIR_R3_SHIFT) | ((u32)(dir_r2) << REG_EXI_RCNT0_H_DIR_R2_SHIFT)                    \
          | ((u32)(dir_r1) << REG_EXI_RCNT0_H_DIR_R1_SHIFT) | ((u32)(dir_r0) << REG_EXI_RCNT0_H_DIR_R0_SHIFT) | ((u32)(data_r7) << REG_EXI_RCNT0_H_DATA_R7_SHIFT)                  \
          | ((u32)(data_r6) << REG_EXI_RCNT0_H_DATA_R6_SHIFT) | ((u32)(data_r5) << REG_EXI_RCNT0_H_DATA_R5_SHIFT) | ((u32)(data_r4) << REG_EXI_RCNT0_H_DATA_R4_SHIFT)              \
          | ((u32)(data_r3) << REG_EXI_RCNT0_H_DATA_R3_SHIFT) | ((u32)(data_r2) << REG_EXI_RCNT0_H_DATA_R2_SHIFT) | ((u32)(data_r1) << REG_EXI_RCNT0_H_DATA_R1_SHIFT)              \
          | ((u32)(data_r0) << REG_EXI_RCNT0_H_DATA_R0_SHIFT))
#endif

#elif defined(SDK_TS)

#define REG_EXI_RCNT0_H_DATA_R7_SHIFT 7
#define REG_EXI_RCNT0_H_DATA_R7_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R7_MASK  0x0080

#define REG_EXI_RCNT0_H_DATA_R6_SHIFT 6
#define REG_EXI_RCNT0_H_DATA_R6_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R6_MASK  0x0040

#define REG_EXI_RCNT0_H_DATA_R5_SHIFT 5
#define REG_EXI_RCNT0_H_DATA_R5_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R5_MASK  0x0020

#define REG_EXI_RCNT0_H_DATA_R4_SHIFT 4
#define REG_EXI_RCNT0_H_DATA_R4_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R4_MASK  0x0010

#define REG_EXI_RCNT0_H_DATA_R3_SHIFT 3
#define REG_EXI_RCNT0_H_DATA_R3_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R3_MASK  0x0008

#define REG_EXI_RCNT0_H_DATA_R2_SHIFT 2
#define REG_EXI_RCNT0_H_DATA_R2_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R2_MASK  0x0004

#define REG_EXI_RCNT0_H_DATA_R1_SHIFT 1
#define REG_EXI_RCNT0_H_DATA_R1_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R1_MASK  0x0002

#define REG_EXI_RCNT0_H_DATA_R0_SHIFT 0
#define REG_EXI_RCNT0_H_DATA_R0_SIZE  1
#define REG_EXI_RCNT0_H_DATA_R0_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_RCNT0_H_FIELD(data_r7, data_r6, data_r5, data_r4, data_r3, data_r2, data_r1, data_r0)                                                                              \
    (u16)(((u32)(data_r7) << REG_EXI_RCNT0_H_DATA_R7_SHIFT) | ((u32)(data_r6) << REG_EXI_RCNT0_H_DATA_R6_SHIFT) | ((u32)(data_r5) << REG_EXI_RCNT0_H_DATA_R5_SHIFT)                \
          | ((u32)(data_r4) << REG_EXI_RCNT0_H_DATA_R4_SHIFT) | ((u32)(data_r3) << REG_EXI_RCNT0_H_DATA_R3_SHIFT) | ((u32)(data_r2) << REG_EXI_RCNT0_H_DATA_R2_SHIFT)              \
          | ((u32)(data_r1) << REG_EXI_RCNT0_H_DATA_R1_SHIFT) | ((u32)(data_r0) << REG_EXI_RCNT0_H_DATA_R0_SHIFT))
#endif

#endif

#if !defined(SDK_TS)

#define REG_EXI_RCNT1_DIR_RB_SHIFT 7
#define REG_EXI_RCNT1_DIR_RB_SIZE  1
#define REG_EXI_RCNT1_DIR_RB_MASK  0x0080

#define REG_EXI_RCNT1_DIR_RA_SHIFT 6
#define REG_EXI_RCNT1_DIR_RA_SIZE  1
#define REG_EXI_RCNT1_DIR_RA_MASK  0x0040

#define REG_EXI_RCNT1_DIR_R9_SHIFT 5
#define REG_EXI_RCNT1_DIR_R9_SIZE  1
#define REG_EXI_RCNT1_DIR_R9_MASK  0x0020

#define REG_EXI_RCNT1_DIR_R8_SHIFT 4
#define REG_EXI_RCNT1_DIR_R8_SIZE  1
#define REG_EXI_RCNT1_DIR_R8_MASK  0x0010

#define REG_EXI_RCNT1_DATA_RB_SHIFT 3
#define REG_EXI_RCNT1_DATA_RB_SIZE  1
#define REG_EXI_RCNT1_DATA_RB_MASK  0x0008

#define REG_EXI_RCNT1_DATA_RA_SHIFT 2
#define REG_EXI_RCNT1_DATA_RA_SIZE  1
#define REG_EXI_RCNT1_DATA_RA_MASK  0x0004

#define REG_EXI_RCNT1_DATA_R9_SHIFT 1
#define REG_EXI_RCNT1_DATA_R9_SIZE  1
#define REG_EXI_RCNT1_DATA_R9_MASK  0x0002

#define REG_EXI_RCNT1_DATA_R8_SHIFT 0
#define REG_EXI_RCNT1_DATA_R8_SIZE  1
#define REG_EXI_RCNT1_DATA_R8_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_RCNT1_FIELD(dir_rb, dir_ra, dir_r9, dir_r8, data_rb, data_ra, data_r9, data_r8)                                                                                    \
    (u16)(((u32)(dir_rb) << REG_EXI_RCNT1_DIR_RB_SHIFT) | ((u32)(dir_ra) << REG_EXI_RCNT1_DIR_RA_SHIFT) | ((u32)(dir_r9) << REG_EXI_RCNT1_DIR_R9_SHIFT)                            \
          | ((u32)(dir_r8) << REG_EXI_RCNT1_DIR_R8_SHIFT) | ((u32)(data_rb) << REG_EXI_RCNT1_DATA_RB_SHIFT) | ((u32)(data_ra) << REG_EXI_RCNT1_DATA_RA_SHIFT)                      \
          | ((u32)(data_r9) << REG_EXI_RCNT1_DATA_R9_SHIFT) | ((u32)(data_r8) << REG_EXI_RCNT1_DATA_R8_SHIFT))
#endif

#elif defined(SDK_TS)

#define REG_EXI_RCNT1_DIR_RF_SHIFT 15
#define REG_EXI_RCNT1_DIR_RF_SIZE  1
#define REG_EXI_RCNT1_DIR_RF_MASK  0x8000

#define REG_EXI_RCNT1_DIR_RE_SHIFT 14
#define REG_EXI_RCNT1_DIR_RE_SIZE  1
#define REG_EXI_RCNT1_DIR_RE_MASK  0x4000

#define REG_EXI_RCNT1_DIR_RD_SHIFT 13
#define REG_EXI_RCNT1_DIR_RD_SIZE  1
#define REG_EXI_RCNT1_DIR_RD_MASK  0x2000

#define REG_EXI_RCNT1_DIR_RC_SHIFT 12
#define REG_EXI_RCNT1_DIR_RC_SIZE  1
#define REG_EXI_RCNT1_DIR_RC_MASK  0x1000

#define REG_EXI_RCNT1_DATA_RF_SHIFT 11
#define REG_EXI_RCNT1_DATA_RF_SIZE  1
#define REG_EXI_RCNT1_DATA_RF_MASK  0x0800

#define REG_EXI_RCNT1_DATA_RE_SHIFT 10
#define REG_EXI_RCNT1_DATA_RE_SIZE  1
#define REG_EXI_RCNT1_DATA_RE_MASK  0x0400

#define REG_EXI_RCNT1_DATA_RD_SHIFT 9
#define REG_EXI_RCNT1_DATA_RD_SIZE  1
#define REG_EXI_RCNT1_DATA_RD_MASK  0x0200

#define REG_EXI_RCNT1_DATA_RC_SHIFT 8
#define REG_EXI_RCNT1_DATA_RC_SIZE  1
#define REG_EXI_RCNT1_DATA_RC_MASK  0x0100

#define REG_EXI_RCNT1_DIR_RB_SHIFT 7
#define REG_EXI_RCNT1_DIR_RB_SIZE  1
#define REG_EXI_RCNT1_DIR_RB_MASK  0x0080

#define REG_EXI_RCNT1_DIR_RA_SHIFT 6
#define REG_EXI_RCNT1_DIR_RA_SIZE  1
#define REG_EXI_RCNT1_DIR_RA_MASK  0x0040

#define REG_EXI_RCNT1_DIR_R9_SHIFT 5
#define REG_EXI_RCNT1_DIR_R9_SIZE  1
#define REG_EXI_RCNT1_DIR_R9_MASK  0x0020

#define REG_EXI_RCNT1_DIR_R8_SHIFT 4
#define REG_EXI_RCNT1_DIR_R8_SIZE  1
#define REG_EXI_RCNT1_DIR_R8_MASK  0x0010

#define REG_EXI_RCNT1_DATA_RB_SHIFT 3
#define REG_EXI_RCNT1_DATA_RB_SIZE  1
#define REG_EXI_RCNT1_DATA_RB_MASK  0x0008

#define REG_EXI_RCNT1_DATA_RA_SHIFT 2
#define REG_EXI_RCNT1_DATA_RA_SIZE  1
#define REG_EXI_RCNT1_DATA_RA_MASK  0x0004

#define REG_EXI_RCNT1_DATA_R9_SHIFT 1
#define REG_EXI_RCNT1_DATA_R9_SIZE  1
#define REG_EXI_RCNT1_DATA_R9_MASK  0x0002

#define REG_EXI_RCNT1_DATA_R8_SHIFT 0
#define REG_EXI_RCNT1_DATA_R8_SIZE  1
#define REG_EXI_RCNT1_DATA_R8_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_RCNT1_FIELD(dir_rf, dir_re, dir_rd, dir_rc, data_rf, data_re, data_rd, data_rc, dir_rb, dir_ra, dir_r9, dir_r8, data_rb, data_ra, data_r9, data_r8)                \
    (u16)(((u32)(dir_rf) << REG_EXI_RCNT1_DIR_RF_SHIFT) | ((u32)(dir_re) << REG_EXI_RCNT1_DIR_RE_SHIFT) | ((u32)(dir_rd) << REG_EXI_RCNT1_DIR_RD_SHIFT)                            \
          | ((u32)(dir_rc) << REG_EXI_RCNT1_DIR_RC_SHIFT) | ((u32)(data_rf) << REG_EXI_RCNT1_DATA_RF_SHIFT) | ((u32)(data_re) << REG_EXI_RCNT1_DATA_RE_SHIFT)                      \
          | ((u32)(data_rd) << REG_EXI_RCNT1_DATA_RD_SHIFT) | ((u32)(data_rc) << REG_EXI_RCNT1_DATA_RC_SHIFT) | ((u32)(dir_rb) << REG_EXI_RCNT1_DIR_RB_SHIFT)                      \
          | ((u32)(dir_ra) << REG_EXI_RCNT1_DIR_RA_SHIFT) | ((u32)(dir_r9) << REG_EXI_RCNT1_DIR_R9_SHIFT) | ((u32)(dir_r8) << REG_EXI_RCNT1_DIR_R8_SHIFT)                          \
          | ((u32)(data_rb) << REG_EXI_RCNT1_DATA_RB_SHIFT) | ((u32)(data_ra) << REG_EXI_RCNT1_DATA_RA_SHIFT) | ((u32)(data_r9) << REG_EXI_RCNT1_DATA_R9_SHIFT)                    \
          | ((u32)(data_r8) << REG_EXI_RCNT1_DATA_R8_SHIFT))
#endif

#endif

#define REG_EXI_JOYCNT_MOD_SHIFT 7
#define REG_EXI_JOYCNT_MOD_SIZE  1
#define REG_EXI_JOYCNT_MOD_MASK  0x0080

#define REG_EXI_JOYCNT_I_SHIFT 6
#define REG_EXI_JOYCNT_I_SIZE  1
#define REG_EXI_JOYCNT_I_MASK  0x0040

#define REG_EXI_JOYCNT_SEND_SHIFT 2
#define REG_EXI_JOYCNT_SEND_SIZE  1
#define REG_EXI_JOYCNT_SEND_MASK  0x0004

#define REG_EXI_JOYCNT_RECV_SHIFT 1
#define REG_EXI_JOYCNT_RECV_SIZE  1
#define REG_EXI_JOYCNT_RECV_MASK  0x0002

#define REG_EXI_JOYCNT_RESET_SHIFT 0
#define REG_EXI_JOYCNT_RESET_SIZE  1
#define REG_EXI_JOYCNT_RESET_MASK  0x0001

#ifndef SDK_ASM
#define REG_EXI_JOYCNT_FIELD(mod, i, send, recv, reset)                                                                                                                            \
    (u16)(((u32)(mod) << REG_EXI_JOYCNT_MOD_SHIFT) | ((u32)(i) << REG_EXI_JOYCNT_I_SHIFT) | ((u32)(send) << REG_EXI_JOYCNT_SEND_SHIFT)                                             \
          | ((u32)(recv) << REG_EXI_JOYCNT_RECV_SHIFT) | ((u32)(reset) << REG_EXI_JOYCNT_RESET_SHIFT))
#endif

#define REG_EXI_JOY_RECV_RECVDATA_SHIFT 0
#define REG_EXI_JOY_RECV_RECVDATA_SIZE  32
#define REG_EXI_JOY_RECV_RECVDATA_MASK  0xffffffff

#ifndef SDK_ASM
#define REG_EXI_JOY_RECV_FIELD(recvdata) (u32)(((u32)(recvdata) << REG_EXI_JOY_RECV_RECVDATA_SHIFT))
#endif

#define REG_EXI_JOY_TRANS_SENDDATA_SHIFT 0
#define REG_EXI_JOY_TRANS_SENDDATA_SIZE  32
#define REG_EXI_JOY_TRANS_SENDDATA_MASK  0xffffffff

#ifndef SDK_ASM
#define REG_EXI_JOY_TRANS_FIELD(senddata) (u32)(((u32)(senddata) << REG_EXI_JOY_TRANS_SENDDATA_SHIFT))
#endif

#define REG_EXI_JOY_STAT_GEN_SHIFT 4
#define REG_EXI_JOY_STAT_GEN_SIZE  2
#define REG_EXI_JOY_STAT_GEN_MASK  0x0030

#define REG_EXI_JOY_STAT_SSTATUS_SHIFT 3
#define REG_EXI_JOY_STAT_SSTATUS_SIZE  1
#define REG_EXI_JOY_STAT_SSTATUS_MASK  0x0008

#define REG_EXI_JOY_STAT_RSTATUS_SHIFT 1
#define REG_EXI_JOY_STAT_RSTATUS_SIZE  1
#define REG_EXI_JOY_STAT_RSTATUS_MASK  0x0002

#ifndef SDK_ASM
#define REG_EXI_JOY_STAT_FIELD(gen, sstatus, rstatus)                                                                                                                              \
    (u16)(((u32)(gen) << REG_EXI_JOY_STAT_GEN_SHIFT) | ((u32)(sstatus) << REG_EXI_JOY_STAT_SSTATUS_SHIFT) | ((u32)(rstatus) << REG_EXI_JOY_STAT_RSTATUS_SHIFT))
#endif