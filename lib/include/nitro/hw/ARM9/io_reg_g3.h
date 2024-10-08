#define REG_MTX_MODE_OFFSET 0x440
#define REG_MTX_MODE_ADDR   (HW_REG_BASE + REG_MTX_MODE_OFFSET)
#define reg_G3_MTX_MODE     (*(REGType32v *)REG_MTX_MODE_ADDR)

#define REG_MTX_PUSH_OFFSET 0x444
#define REG_MTX_PUSH_ADDR   (HW_REG_BASE + REG_MTX_PUSH_OFFSET)
#define reg_G3_MTX_PUSH     (*(REGType32v *)REG_MTX_PUSH_ADDR)

#define REG_MTX_POP_OFFSET 0x448
#define REG_MTX_POP_ADDR   (HW_REG_BASE + REG_MTX_POP_OFFSET)
#define reg_G3_MTX_POP     (*(REGType32v *)REG_MTX_POP_ADDR)

#define REG_MTX_STORE_OFFSET 0x44c
#define REG_MTX_STORE_ADDR   (HW_REG_BASE + REG_MTX_STORE_OFFSET)
#define reg_G3_MTX_STORE     (*(REGType32v *)REG_MTX_STORE_ADDR)

#define REG_MTX_RESTORE_OFFSET 0x450
#define REG_MTX_RESTORE_ADDR   (HW_REG_BASE + REG_MTX_RESTORE_OFFSET)
#define reg_G3_MTX_RESTORE     (*(REGType32v *)REG_MTX_RESTORE_ADDR)

#define REG_MTX_IDENTITY_OFFSET 0x454
#define REG_MTX_IDENTITY_ADDR   (HW_REG_BASE + REG_MTX_IDENTITY_OFFSET)
#define reg_G3_MTX_IDENTITY     (*(REGType32v *)REG_MTX_IDENTITY_ADDR)

#define REG_MTX_LOAD_4x4_OFFSET 0x458
#define REG_MTX_LOAD_4x4_ADDR   (HW_REG_BASE + REG_MTX_LOAD_4x4_OFFSET)
#define reg_G3_MTX_LOAD_4x4     (*(REGType32v *)REG_MTX_LOAD_4x4_ADDR)

#define REG_MTX_LOAD_4x3_OFFSET 0x45c
#define REG_MTX_LOAD_4x3_ADDR   (HW_REG_BASE + REG_MTX_LOAD_4x3_OFFSET)
#define reg_G3_MTX_LOAD_4x3     (*(REGType32v *)REG_MTX_LOAD_4x3_ADDR)

#define REG_MTX_MULT_4x4_OFFSET 0x460
#define REG_MTX_MULT_4x4_ADDR   (HW_REG_BASE + REG_MTX_MULT_4x4_OFFSET)
#define reg_G3_MTX_MULT_4x4     (*(REGType32v *)REG_MTX_MULT_4x4_ADDR)

#define REG_MTX_MULT_4x3_OFFSET 0x464
#define REG_MTX_MULT_4x3_ADDR   (HW_REG_BASE + REG_MTX_MULT_4x3_OFFSET)
#define reg_G3_MTX_MULT_4x3     (*(REGType32v *)REG_MTX_MULT_4x3_ADDR)

#define REG_MTX_MULT_3x3_OFFSET 0x468
#define REG_MTX_MULT_3x3_ADDR   (HW_REG_BASE + REG_MTX_MULT_3x3_OFFSET)
#define reg_G3_MTX_MULT_3x3     (*(REGType32v *)REG_MTX_MULT_3x3_ADDR)

#define REG_MTX_SCALE_OFFSET 0x46c
#define REG_MTX_SCALE_ADDR   (HW_REG_BASE + REG_MTX_SCALE_OFFSET)
#define reg_G3_MTX_SCALE     (*(REGType32v *)REG_MTX_SCALE_ADDR)

#define REG_MTX_TRANS_OFFSET 0x470
#define REG_MTX_TRANS_ADDR   (HW_REG_BASE + REG_MTX_TRANS_OFFSET)
#define reg_G3_MTX_TRANS     (*(REGType32v *)REG_MTX_TRANS_ADDR)

#define REG_COLOR_OFFSET 0x480
#define REG_COLOR_ADDR   (HW_REG_BASE + REG_COLOR_OFFSET)
#define reg_G3_COLOR     (*(REGType32v *)REG_COLOR_ADDR)

#define REG_NORMAL_OFFSET 0x484
#define REG_NORMAL_ADDR   (HW_REG_BASE + REG_NORMAL_OFFSET)
#define reg_G3_NORMAL     (*(REGType32v *)REG_NORMAL_ADDR)

#define REG_TEXCOORD_OFFSET 0x488
#define REG_TEXCOORD_ADDR   (HW_REG_BASE + REG_TEXCOORD_OFFSET)
#define reg_G3_TEXCOORD     (*(REGType32v *)REG_TEXCOORD_ADDR)

#define REG_VTX_16_OFFSET 0x48c
#define REG_VTX_16_ADDR   (HW_REG_BASE + REG_VTX_16_OFFSET)
#define reg_G3_VTX_16     (*(REGType32v *)REG_VTX_16_ADDR)

#define REG_VTX_10_OFFSET 0x490
#define REG_VTX_10_ADDR   (HW_REG_BASE + REG_VTX_10_OFFSET)
#define reg_G3_VTX_10     (*(REGType32v *)REG_VTX_10_ADDR)

#define REG_VTX_XY_OFFSET 0x494
#define REG_VTX_XY_ADDR   (HW_REG_BASE + REG_VTX_XY_OFFSET)
#define reg_G3_VTX_XY     (*(REGType32v *)REG_VTX_XY_ADDR)

#define REG_VTX_XZ_OFFSET 0x498
#define REG_VTX_XZ_ADDR   (HW_REG_BASE + REG_VTX_XZ_OFFSET)
#define reg_G3_VTX_XZ     (*(REGType32v *)REG_VTX_XZ_ADDR)

#define REG_VTX_YZ_OFFSET 0x49c
#define REG_VTX_YZ_ADDR   (HW_REG_BASE + REG_VTX_YZ_OFFSET)
#define reg_G3_VTX_YZ     (*(REGType32v *)REG_VTX_YZ_ADDR)

#define REG_VTX_DIFF_OFFSET 0x4a0
#define REG_VTX_DIFF_ADDR   (HW_REG_BASE + REG_VTX_DIFF_OFFSET)
#define reg_G3_VTX_DIFF     (*(REGType32v *)REG_VTX_DIFF_ADDR)

#define REG_POLYGON_ATTR_OFFSET 0x4a4
#define REG_POLYGON_ATTR_ADDR   (HW_REG_BASE + REG_POLYGON_ATTR_OFFSET)
#define reg_G3_POLYGON_ATTR     (*(REGType32v *)REG_POLYGON_ATTR_ADDR)

#define REG_TEXIMAGE_PARAM_OFFSET 0x4a8
#define REG_TEXIMAGE_PARAM_ADDR   (HW_REG_BASE + REG_TEXIMAGE_PARAM_OFFSET)
#define reg_G3_TEXIMAGE_PARAM     (*(REGType32v *)REG_TEXIMAGE_PARAM_ADDR)

#define REG_TEXPLTT_BASE_OFFSET 0x4ac
#define REG_TEXPLTT_BASE_ADDR   (HW_REG_BASE + REG_TEXPLTT_BASE_OFFSET)
#define reg_G3_TEXPLTT_BASE     (*(REGType32v *)REG_TEXPLTT_BASE_ADDR)

#define REG_DIF_AMB_OFFSET 0x4c0
#define REG_DIF_AMB_ADDR   (HW_REG_BASE + REG_DIF_AMB_OFFSET)
#define reg_G3_DIF_AMB     (*(REGType32v *)REG_DIF_AMB_ADDR)

#define REG_SPE_EMI_OFFSET 0x4c4
#define REG_SPE_EMI_ADDR   (HW_REG_BASE + REG_SPE_EMI_OFFSET)
#define reg_G3_SPE_EMI     (*(REGType32v *)REG_SPE_EMI_ADDR)

#define REG_LIGHT_VECTOR_OFFSET 0x4c8
#define REG_LIGHT_VECTOR_ADDR   (HW_REG_BASE + REG_LIGHT_VECTOR_OFFSET)
#define reg_G3_LIGHT_VECTOR     (*(REGType32v *)REG_LIGHT_VECTOR_ADDR)

#define REG_LIGHT_COLOR_OFFSET 0x4cc
#define REG_LIGHT_COLOR_ADDR   (HW_REG_BASE + REG_LIGHT_COLOR_OFFSET)
#define reg_G3_LIGHT_COLOR     (*(REGType32v *)REG_LIGHT_COLOR_ADDR)

#define REG_SHININESS_OFFSET 0x4d0
#define REG_SHININESS_ADDR   (HW_REG_BASE + REG_SHININESS_OFFSET)
#define reg_G3_SHININESS     (*(REGType32v *)REG_SHININESS_ADDR)

#define REG_BEGIN_VTXS_OFFSET 0x500
#define REG_BEGIN_VTXS_ADDR   (HW_REG_BASE + REG_BEGIN_VTXS_OFFSET)
#define reg_G3_BEGIN_VTXS     (*(REGType32v *)REG_BEGIN_VTXS_ADDR)

#define REG_END_VTXS_OFFSET 0x504
#define REG_END_VTXS_ADDR   (HW_REG_BASE + REG_END_VTXS_OFFSET)
#define reg_G3_END_VTXS     (*(REGType32v *)REG_END_VTXS_ADDR)

#define REG_SWAP_BUFFERS_OFFSET 0x540
#define REG_SWAP_BUFFERS_ADDR   (HW_REG_BASE + REG_SWAP_BUFFERS_OFFSET)
#define reg_G3_SWAP_BUFFERS     (*(REGType32v *)REG_SWAP_BUFFERS_ADDR)

#define REG_VIEWPORT_OFFSET 0x580
#define REG_VIEWPORT_ADDR   (HW_REG_BASE + REG_VIEWPORT_OFFSET)
#define reg_G3_VIEWPORT     (*(REGType32v *)REG_VIEWPORT_ADDR)

#define REG_BOX_TEST_OFFSET 0x5c0
#define REG_BOX_TEST_ADDR   (HW_REG_BASE + REG_BOX_TEST_OFFSET)
#define reg_G3_BOX_TEST     (*(REGType32v *)REG_BOX_TEST_ADDR)

#define REG_POS_TEST_OFFSET 0x5c4
#define REG_POS_TEST_ADDR   (HW_REG_BASE + REG_POS_TEST_OFFSET)
#define reg_G3_POS_TEST     (*(REGType32v *)REG_POS_TEST_ADDR)

#define REG_VEC_TEST_OFFSET 0x5c8
#define REG_VEC_TEST_ADDR   (HW_REG_BASE + REG_VEC_TEST_OFFSET)
#define reg_G3_VEC_TEST     (*(REGType32v *)REG_VEC_TEST_ADDR)

#define REG_G3_MTX_MODE_M_SHIFT 0
#define REG_G3_MTX_MODE_M_SIZE  2
#define REG_G3_MTX_MODE_M_MASK  0x00000003

#ifndef SDK_ASM
#define REG_G3_MTX_MODE_FIELD(m) (u32)(((u32)(m) << REG_G3_MTX_MODE_M_SHIFT))
#endif

#define REG_G3_MTX_POP_S_SHIFT 5
#define REG_G3_MTX_POP_S_SIZE  1
#define REG_G3_MTX_POP_S_MASK  0x00000020

#define REG_G3_MTX_POP_INT_SHIFT 0
#define REG_G3_MTX_POP_INT_SIZE  5
#define REG_G3_MTX_POP_INT_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_MTX_POP_FIELD(s, int) (u32)(((u32)(s) << REG_G3_MTX_POP_S_SHIFT) | ((u32)(int) << REG_G3_MTX_POP_INT_SHIFT))
#endif

#define REG_G3_MTX_STORE_INDEX_SHIFT 0
#define REG_G3_MTX_STORE_INDEX_SIZE  5
#define REG_G3_MTX_STORE_INDEX_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_MTX_STORE_FIELD(index) (u32)(((u32)(index) << REG_G3_MTX_STORE_INDEX_SHIFT))
#endif

#define REG_G3_MTX_RESTORE_INDEX_SHIFT 0
#define REG_G3_MTX_RESTORE_INDEX_SIZE  5
#define REG_G3_MTX_RESTORE_INDEX_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_MTX_RESTORE_FIELD(index) (u32)(((u32)(index) << REG_G3_MTX_RESTORE_INDEX_SHIFT))
#endif

#define REG_G3_MTX_LOAD_4x4_S_SHIFT 31
#define REG_G3_MTX_LOAD_4x4_S_SIZE  1
#define REG_G3_MTX_LOAD_4x4_S_MASK  0x80000000

#define REG_G3_MTX_LOAD_4x4_INTEGER_M44_SHIFT 12
#define REG_G3_MTX_LOAD_4x4_INTEGER_M44_SIZE  19
#define REG_G3_MTX_LOAD_4x4_INTEGER_M44_MASK  0x7ffff000

#define REG_G3_MTX_LOAD_4x4_DECIMAL_M44_SHIFT 0
#define REG_G3_MTX_LOAD_4x4_DECIMAL_M44_SIZE  12
#define REG_G3_MTX_LOAD_4x4_DECIMAL_M44_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_LOAD_4x4_FIELD(s, integer_m44, decimal_m44)                                                                                                                                         \
    (u32)(((u32)(s) << REG_G3_MTX_LOAD_4x4_S_SHIFT) | ((u32)(integer_m44) << REG_G3_MTX_LOAD_4x4_INTEGER_M44_SHIFT) | ((u32)(decimal_m44) << REG_G3_MTX_LOAD_4x4_DECIMAL_M44_SHIFT))
#endif

#define REG_G3_MTX_LOAD_4x3_S_SHIFT 31
#define REG_G3_MTX_LOAD_4x3_S_SIZE  1
#define REG_G3_MTX_LOAD_4x3_S_MASK  0x80000000

#define REG_G3_MTX_LOAD_4x3_INTEGER_M43_SHIFT 12
#define REG_G3_MTX_LOAD_4x3_INTEGER_M43_SIZE  19
#define REG_G3_MTX_LOAD_4x3_INTEGER_M43_MASK  0x7ffff000

#define REG_G3_MTX_LOAD_4x3_DECIMAL_M43_SHIFT 0
#define REG_G3_MTX_LOAD_4x3_DECIMAL_M43_SIZE  12
#define REG_G3_MTX_LOAD_4x3_DECIMAL_M43_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_LOAD_4x3_FIELD(s, integer_m43, decimal_m43)                                                                                                                                         \
    (u32)(((u32)(s) << REG_G3_MTX_LOAD_4x3_S_SHIFT) | ((u32)(integer_m43) << REG_G3_MTX_LOAD_4x3_INTEGER_M43_SHIFT) | ((u32)(decimal_m43) << REG_G3_MTX_LOAD_4x3_DECIMAL_M43_SHIFT))
#endif

#define REG_G3_MTX_MULT_4x4_S_SHIFT 31
#define REG_G3_MTX_MULT_4x4_S_SIZE  1
#define REG_G3_MTX_MULT_4x4_S_MASK  0x80000000

#define REG_G3_MTX_MULT_4x4_INTEGER_M44_SHIFT 12
#define REG_G3_MTX_MULT_4x4_INTEGER_M44_SIZE  19
#define REG_G3_MTX_MULT_4x4_INTEGER_M44_MASK  0x7ffff000

#define REG_G3_MTX_MULT_4x4_DECIMAL_M44_SHIFT 0
#define REG_G3_MTX_MULT_4x4_DECIMAL_M44_SIZE  12
#define REG_G3_MTX_MULT_4x4_DECIMAL_M44_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_MULT_4x4_FIELD(s, integer_m44, decimal_m44)                                                                                                                                         \
    (u32)(((u32)(s) << REG_G3_MTX_MULT_4x4_S_SHIFT) | ((u32)(integer_m44) << REG_G3_MTX_MULT_4x4_INTEGER_M44_SHIFT) | ((u32)(decimal_m44) << REG_G3_MTX_MULT_4x4_DECIMAL_M44_SHIFT))
#endif

#define REG_G3_MTX_MULT_4x3_S_SHIFT 31
#define REG_G3_MTX_MULT_4x3_S_SIZE  1
#define REG_G3_MTX_MULT_4x3_S_MASK  0x80000000

#define REG_G3_MTX_MULT_4x3_INTEGER_M43_SHIFT 12
#define REG_G3_MTX_MULT_4x3_INTEGER_M43_SIZE  19
#define REG_G3_MTX_MULT_4x3_INTEGER_M43_MASK  0x7ffff000

#define REG_G3_MTX_MULT_4x3_DECIMAL_M43_SHIFT 0
#define REG_G3_MTX_MULT_4x3_DECIMAL_M43_SIZE  12
#define REG_G3_MTX_MULT_4x3_DECIMAL_M43_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_MULT_4x3_FIELD(s, integer_m43, decimal_m43)                                                                                                                                         \
    (u32)(((u32)(s) << REG_G3_MTX_MULT_4x3_S_SHIFT) | ((u32)(integer_m43) << REG_G3_MTX_MULT_4x3_INTEGER_M43_SHIFT) | ((u32)(decimal_m43) << REG_G3_MTX_MULT_4x3_DECIMAL_M43_SHIFT))
#endif

#define REG_G3_MTX_MULT_3x3_S_SHIFT 31
#define REG_G3_MTX_MULT_3x3_S_SIZE  1
#define REG_G3_MTX_MULT_3x3_S_MASK  0x80000000

#define REG_G3_MTX_MULT_3x3_INTEGER_M33_SHIFT 12
#define REG_G3_MTX_MULT_3x3_INTEGER_M33_SIZE  19
#define REG_G3_MTX_MULT_3x3_INTEGER_M33_MASK  0x7ffff000

#define REG_G3_MTX_MULT_3x3_DECIMAL_M33_SHIFT 0
#define REG_G3_MTX_MULT_3x3_DECIMAL_M33_SIZE  12
#define REG_G3_MTX_MULT_3x3_DECIMAL_M33_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_MULT_3x3_FIELD(s, integer_m33, decimal_m33)                                                                                                                                         \
    (u32)(((u32)(s) << REG_G3_MTX_MULT_3x3_S_SHIFT) | ((u32)(integer_m33) << REG_G3_MTX_MULT_3x3_INTEGER_M33_SHIFT) | ((u32)(decimal_m33) << REG_G3_MTX_MULT_3x3_DECIMAL_M33_SHIFT))
#endif

#define REG_G3_MTX_SCALE_S_SHIFT 31
#define REG_G3_MTX_SCALE_S_SIZE  1
#define REG_G3_MTX_SCALE_S_MASK  0x80000000

#define REG_G3_MTX_SCALE_INTEGER_SCALE_SHIFT 12
#define REG_G3_MTX_SCALE_INTEGER_SCALE_SIZE  19
#define REG_G3_MTX_SCALE_INTEGER_SCALE_MASK  0x7ffff000

#define REG_G3_MTX_SCALE_DECIMAL_SCALE_SHIFT 0
#define REG_G3_MTX_SCALE_DECIMAL_SCALE_SIZE  12
#define REG_G3_MTX_SCALE_DECIMAL_SCALE_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_SCALE_FIELD(s, integer_scale, decimal_scale)                                                                                                                                        \
    (u32)(((u32)(s) << REG_G3_MTX_SCALE_S_SHIFT) | ((u32)(integer_scale) << REG_G3_MTX_SCALE_INTEGER_SCALE_SHIFT) | ((u32)(decimal_scale) << REG_G3_MTX_SCALE_DECIMAL_SCALE_SHIFT))
#endif

#define REG_G3_MTX_TRANS_S_SHIFT 31
#define REG_G3_MTX_TRANS_S_SIZE  1
#define REG_G3_MTX_TRANS_S_MASK  0x80000000

#define REG_G3_MTX_TRANS_INTEGER_TRANSLATE_SHIFT 12
#define REG_G3_MTX_TRANS_INTEGER_TRANSLATE_SIZE  19
#define REG_G3_MTX_TRANS_INTEGER_TRANSLATE_MASK  0x7ffff000

#define REG_G3_MTX_TRANS_DECIMAL_TRANSLATE_SHIFT 0
#define REG_G3_MTX_TRANS_DECIMAL_TRANSLATE_SIZE  12
#define REG_G3_MTX_TRANS_DECIMAL_TRANSLATE_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_MTX_TRANS_FIELD(s, integer_translate, decimal_translate)                                                                                                                                \
    (u32)(((u32)(s) << REG_G3_MTX_TRANS_S_SHIFT) | ((u32)(integer_translate) << REG_G3_MTX_TRANS_INTEGER_TRANSLATE_SHIFT) | ((u32)(decimal_translate) << REG_G3_MTX_TRANS_DECIMAL_TRANSLATE_SHIFT))
#endif

#define REG_G3_COLOR_BLUE_SHIFT 10
#define REG_G3_COLOR_BLUE_SIZE  5
#define REG_G3_COLOR_BLUE_MASK  0x00007c00

#define REG_G3_COLOR_GREEN_SHIFT 5
#define REG_G3_COLOR_GREEN_SIZE  5
#define REG_G3_COLOR_GREEN_MASK  0x000003e0

#define REG_G3_COLOR_RED_SHIFT 0
#define REG_G3_COLOR_RED_SIZE  5
#define REG_G3_COLOR_RED_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_COLOR_FIELD(blue, green, red) (u32)(((u32)(blue) << REG_G3_COLOR_BLUE_SHIFT) | ((u32)(green) << REG_G3_COLOR_GREEN_SHIFT) | ((u32)(red) << REG_G3_COLOR_RED_SHIFT))
#endif

#define REG_G3_NORMAL_SZ_SHIFT 29
#define REG_G3_NORMAL_SZ_SIZE  1
#define REG_G3_NORMAL_SZ_MASK  0x20000000

#define REG_G3_NORMAL_NZ_SHIFT 20
#define REG_G3_NORMAL_NZ_SIZE  9
#define REG_G3_NORMAL_NZ_MASK  0x1ff00000

#define REG_G3_NORMAL_SY_SHIFT 19
#define REG_G3_NORMAL_SY_SIZE  1
#define REG_G3_NORMAL_SY_MASK  0x00080000

#define REG_G3_NORMAL_NY_SHIFT 10
#define REG_G3_NORMAL_NY_SIZE  9
#define REG_G3_NORMAL_NY_MASK  0x0007fc00

#define REG_G3_NORMAL_SX_SHIFT 9
#define REG_G3_NORMAL_SX_SIZE  1
#define REG_G3_NORMAL_SX_MASK  0x00000200

#define REG_G3_NORMAL_NX_SHIFT 0
#define REG_G3_NORMAL_NX_SIZE  9
#define REG_G3_NORMAL_NX_MASK  0x000001ff

#ifndef SDK_ASM
#define REG_G3_NORMAL_FIELD(sz, nz, sy, ny, sx, nx)                                                                                                                                                    \
    (u32)(((u32)(sz) << REG_G3_NORMAL_SZ_SHIFT) | ((u32)(nz) << REG_G3_NORMAL_NZ_SHIFT) | ((u32)(sy) << REG_G3_NORMAL_SY_SHIFT) | ((u32)(ny) << REG_G3_NORMAL_NY_SHIFT)                                \
          | ((u32)(sx) << REG_G3_NORMAL_SX_SHIFT) | ((u32)(nx) << REG_G3_NORMAL_NX_SHIFT))
#endif

#define REG_G3_TEXCOORD_ST_SHIFT 31
#define REG_G3_TEXCOORD_ST_SIZE  1
#define REG_G3_TEXCOORD_ST_MASK  0x80000000

#define REG_G3_TEXCOORD_INTEGER_SHIFT 20
#define REG_G3_TEXCOORD_INTEGER_SIZE  11
#define REG_G3_TEXCOORD_INTEGER_MASK  0x7ff00000

#define REG_G3_TEXCOORD_DECIMAL_T_SHIFT 16
#define REG_G3_TEXCOORD_DECIMAL_T_SIZE  4
#define REG_G3_TEXCOORD_DECIMAL_T_MASK  0x000f0000

#define REG_G3_TEXCOORD_SS_SHIFT 15
#define REG_G3_TEXCOORD_SS_SIZE  1
#define REG_G3_TEXCOORD_SS_MASK  0x00008000

#define REG_G3_TEXCOORD_INTEGER_S_SHIFT 4
#define REG_G3_TEXCOORD_INTEGER_S_SIZE  11
#define REG_G3_TEXCOORD_INTEGER_S_MASK  0x00007ff0

#define REG_G3_TEXCOORD_DECIMAL_S_SHIFT 0
#define REG_G3_TEXCOORD_DECIMAL_S_SIZE  4
#define REG_G3_TEXCOORD_DECIMAL_S_MASK  0x0000000f

#ifndef SDK_ASM
#define REG_G3_TEXCOORD_FIELD(st, integer, decimal_t, ss, integer_s, decimal_s)                                                                                                                        \
    (u32)(((u32)(st) << REG_G3_TEXCOORD_ST_SHIFT) | ((u32)(integer) << REG_G3_TEXCOORD_INTEGER_SHIFT) | ((u32)(decimal_t) << REG_G3_TEXCOORD_DECIMAL_T_SHIFT)                                          \
          | ((u32)(ss) << REG_G3_TEXCOORD_SS_SHIFT) | ((u32)(integer_s) << REG_G3_TEXCOORD_INTEGER_S_SHIFT) | ((u32)(decimal_s) << REG_G3_TEXCOORD_DECIMAL_S_SHIFT))
#endif

#define REG_G3_VTX_16_SY_SHIFT 31
#define REG_G3_VTX_16_SY_SIZE  1
#define REG_G3_VTX_16_SY_MASK  0x80000000

#define REG_G3_VTX_16_INT_Y_SHIFT 28
#define REG_G3_VTX_16_INT_Y_SIZE  3
#define REG_G3_VTX_16_INT_Y_MASK  0x70000000

#define REG_G3_VTX_16_DECIMAL_Y_SHIFT 16
#define REG_G3_VTX_16_DECIMAL_Y_SIZE  12
#define REG_G3_VTX_16_DECIMAL_Y_MASK  0x0fff0000

#define REG_G3_VTX_16_SX_SHIFT 15
#define REG_G3_VTX_16_SX_SIZE  1
#define REG_G3_VTX_16_SX_MASK  0x00008000

#define REG_G3_VTX_16_INT_X_SHIFT 12
#define REG_G3_VTX_16_INT_X_SIZE  3
#define REG_G3_VTX_16_INT_X_MASK  0x00007000

#define REG_G3_VTX_16_DECIMAL_X_SHIFT 0
#define REG_G3_VTX_16_DECIMAL_X_SIZE  12
#define REG_G3_VTX_16_DECIMAL_X_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_VTX_16_FIELD(sy, int_y, decimal_y, sx, int_x, decimal_x)                                                                                                                                \
    (u32)(((u32)(sy) << REG_G3_VTX_16_SY_SHIFT) | ((u32)(int_y) << REG_G3_VTX_16_INT_Y_SHIFT) | ((u32)(decimal_y) << REG_G3_VTX_16_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_VTX_16_SX_SHIFT)            \
          | ((u32)(int_x) << REG_G3_VTX_16_INT_X_SHIFT) | ((u32)(decimal_x) << REG_G3_VTX_16_DECIMAL_X_SHIFT))
#endif

#define REG_G3_VTX_10_SZ_SHIFT 29
#define REG_G3_VTX_10_SZ_SIZE  1
#define REG_G3_VTX_10_SZ_MASK  0x20000000

#define REG_G3_VTX_10_INT_Z_SHIFT 26
#define REG_G3_VTX_10_INT_Z_SIZE  3
#define REG_G3_VTX_10_INT_Z_MASK  0x1c000000

#define REG_G3_VTX_10_DECIMAL_Z_SHIFT 20
#define REG_G3_VTX_10_DECIMAL_Z_SIZE  6
#define REG_G3_VTX_10_DECIMAL_Z_MASK  0x03f00000

#define REG_G3_VTX_10_SY_SHIFT 19
#define REG_G3_VTX_10_SY_SIZE  1
#define REG_G3_VTX_10_SY_MASK  0x00080000

#define REG_G3_VTX_10_INT_Y_SHIFT 16
#define REG_G3_VTX_10_INT_Y_SIZE  3
#define REG_G3_VTX_10_INT_Y_MASK  0x00070000

#define REG_G3_VTX_10_DECIMAL_Y_SHIFT 10
#define REG_G3_VTX_10_DECIMAL_Y_SIZE  6
#define REG_G3_VTX_10_DECIMAL_Y_MASK  0x0000fc00

#define REG_G3_VTX_10_SX_SHIFT 9
#define REG_G3_VTX_10_SX_SIZE  1
#define REG_G3_VTX_10_SX_MASK  0x00000200

#define REG_G3_VTX_10_INT_X_SHIFT 6
#define REG_G3_VTX_10_INT_X_SIZE  3
#define REG_G3_VTX_10_INT_X_MASK  0x000001c0

#define REG_G3_VTX_10_DECIMAL_X_SHIFT 0
#define REG_G3_VTX_10_DECIMAL_X_SIZE  6
#define REG_G3_VTX_10_DECIMAL_X_MASK  0x0000003f

#ifndef SDK_ASM
#define REG_G3_VTX_10_FIELD(sz, int_z, decimal_z, sy, int_y, decimal_y, sx, int_x, decimal_x)                                                                                                          \
    (u32)(((u32)(sz) << REG_G3_VTX_10_SZ_SHIFT) | ((u32)(int_z) << REG_G3_VTX_10_INT_Z_SHIFT) | ((u32)(decimal_z) << REG_G3_VTX_10_DECIMAL_Z_SHIFT) | ((u32)(sy) << REG_G3_VTX_10_SY_SHIFT)            \
          | ((u32)(int_y) << REG_G3_VTX_10_INT_Y_SHIFT) | ((u32)(decimal_y) << REG_G3_VTX_10_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_VTX_10_SX_SHIFT) | ((u32)(int_x) << REG_G3_VTX_10_INT_X_SHIFT)    \
          | ((u32)(decimal_x) << REG_G3_VTX_10_DECIMAL_X_SHIFT))
#endif

#define REG_G3_VTX_XY_SY_SHIFT 31
#define REG_G3_VTX_XY_SY_SIZE  1
#define REG_G3_VTX_XY_SY_MASK  0x80000000

#define REG_G3_VTX_XY_INT_Y_SHIFT 28
#define REG_G3_VTX_XY_INT_Y_SIZE  3
#define REG_G3_VTX_XY_INT_Y_MASK  0x70000000

#define REG_G3_VTX_XY_DECIMAL_Y_SHIFT 16
#define REG_G3_VTX_XY_DECIMAL_Y_SIZE  12
#define REG_G3_VTX_XY_DECIMAL_Y_MASK  0x0fff0000

#define REG_G3_VTX_XY_SX_SHIFT 15
#define REG_G3_VTX_XY_SX_SIZE  1
#define REG_G3_VTX_XY_SX_MASK  0x00008000

#define REG_G3_VTX_XY_INT_X_SHIFT 12
#define REG_G3_VTX_XY_INT_X_SIZE  3
#define REG_G3_VTX_XY_INT_X_MASK  0x00007000

#define REG_G3_VTX_XY_DECIMAL_X_SHIFT 0
#define REG_G3_VTX_XY_DECIMAL_X_SIZE  12
#define REG_G3_VTX_XY_DECIMAL_X_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_VTX_XY_FIELD(sy, int_y, decimal_y, sx, int_x, decimal_x)                                                                                                                                \
    (u32)(((u32)(sy) << REG_G3_VTX_XY_SY_SHIFT) | ((u32)(int_y) << REG_G3_VTX_XY_INT_Y_SHIFT) | ((u32)(decimal_y) << REG_G3_VTX_XY_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_VTX_XY_SX_SHIFT)            \
          | ((u32)(int_x) << REG_G3_VTX_XY_INT_X_SHIFT) | ((u32)(decimal_x) << REG_G3_VTX_XY_DECIMAL_X_SHIFT))
#endif

#define REG_G3_VTX_XZ_SZ_SHIFT 31
#define REG_G3_VTX_XZ_SZ_SIZE  1
#define REG_G3_VTX_XZ_SZ_MASK  0x80000000

#define REG_G3_VTX_XZ_INT_Z_SHIFT 28
#define REG_G3_VTX_XZ_INT_Z_SIZE  3
#define REG_G3_VTX_XZ_INT_Z_MASK  0x70000000

#define REG_G3_VTX_XZ_DECIMAL_Z_SHIFT 16
#define REG_G3_VTX_XZ_DECIMAL_Z_SIZE  12
#define REG_G3_VTX_XZ_DECIMAL_Z_MASK  0x0fff0000

#define REG_G3_VTX_XZ_SX_SHIFT 15
#define REG_G3_VTX_XZ_SX_SIZE  1
#define REG_G3_VTX_XZ_SX_MASK  0x00008000

#define REG_G3_VTX_XZ_INT_X_SHIFT 12
#define REG_G3_VTX_XZ_INT_X_SIZE  3
#define REG_G3_VTX_XZ_INT_X_MASK  0x00007000

#define REG_G3_VTX_XZ_DECIMAL_X_SHIFT 0
#define REG_G3_VTX_XZ_DECIMAL_X_SIZE  12
#define REG_G3_VTX_XZ_DECIMAL_X_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_VTX_XZ_FIELD(sz, int_z, decimal_z, sx, int_x, decimal_x)                                                                                                                                \
    (u32)(((u32)(sz) << REG_G3_VTX_XZ_SZ_SHIFT) | ((u32)(int_z) << REG_G3_VTX_XZ_INT_Z_SHIFT) | ((u32)(decimal_z) << REG_G3_VTX_XZ_DECIMAL_Z_SHIFT) | ((u32)(sx) << REG_G3_VTX_XZ_SX_SHIFT)            \
          | ((u32)(int_x) << REG_G3_VTX_XZ_INT_X_SHIFT) | ((u32)(decimal_x) << REG_G3_VTX_XZ_DECIMAL_X_SHIFT))
#endif

#define REG_G3_VTX_YZ_SZ_SHIFT 31
#define REG_G3_VTX_YZ_SZ_SIZE  1
#define REG_G3_VTX_YZ_SZ_MASK  0x80000000

#define REG_G3_VTX_YZ_INT_Z_SHIFT 28
#define REG_G3_VTX_YZ_INT_Z_SIZE  3
#define REG_G3_VTX_YZ_INT_Z_MASK  0x70000000

#define REG_G3_VTX_YZ_DECIMAL_Z_SHIFT 16
#define REG_G3_VTX_YZ_DECIMAL_Z_SIZE  12
#define REG_G3_VTX_YZ_DECIMAL_Z_MASK  0x0fff0000

#define REG_G3_VTX_YZ_SY_SHIFT 15
#define REG_G3_VTX_YZ_SY_SIZE  1
#define REG_G3_VTX_YZ_SY_MASK  0x00008000

#define REG_G3_VTX_YZ_INT_Y_SHIFT 12
#define REG_G3_VTX_YZ_INT_Y_SIZE  3
#define REG_G3_VTX_YZ_INT_Y_MASK  0x00007000

#define REG_G3_VTX_YZ_DECIMAL_Y_SHIFT 0
#define REG_G3_VTX_YZ_DECIMAL_Y_SIZE  12
#define REG_G3_VTX_YZ_DECIMAL_Y_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_VTX_YZ_FIELD(sz, int_z, decimal_z, sy, int_y, decimal_y)                                                                                                                                \
    (u32)(((u32)(sz) << REG_G3_VTX_YZ_SZ_SHIFT) | ((u32)(int_z) << REG_G3_VTX_YZ_INT_Z_SHIFT) | ((u32)(decimal_z) << REG_G3_VTX_YZ_DECIMAL_Z_SHIFT) | ((u32)(sy) << REG_G3_VTX_YZ_SY_SHIFT)            \
          | ((u32)(int_y) << REG_G3_VTX_YZ_INT_Y_SHIFT) | ((u32)(decimal_y) << REG_G3_VTX_YZ_DECIMAL_Y_SHIFT))
#endif

#define REG_G3_VTX_DIFF_SZ_SHIFT 29
#define REG_G3_VTX_DIFF_SZ_SIZE  1
#define REG_G3_VTX_DIFF_SZ_MASK  0x20000000

#define REG_G3_VTX_DIFF_DECIMAL_Z_SHIFT 20
#define REG_G3_VTX_DIFF_DECIMAL_Z_SIZE  9
#define REG_G3_VTX_DIFF_DECIMAL_Z_MASK  0x1ff00000

#define REG_G3_VTX_DIFF_SY_SHIFT 19
#define REG_G3_VTX_DIFF_SY_SIZE  1
#define REG_G3_VTX_DIFF_SY_MASK  0x00080000

#define REG_G3_VTX_DIFF_DECIMAL_Y_SHIFT 10
#define REG_G3_VTX_DIFF_DECIMAL_Y_SIZE  9
#define REG_G3_VTX_DIFF_DECIMAL_Y_MASK  0x0007fc00

#define REG_G3_VTX_DIFF_SX_SHIFT 9
#define REG_G3_VTX_DIFF_SX_SIZE  1
#define REG_G3_VTX_DIFF_SX_MASK  0x00000200

#define REG_G3_VTX_DIFF_DECIMAL_X_SHIFT 0
#define REG_G3_VTX_DIFF_DECIMAL_X_SIZE  9
#define REG_G3_VTX_DIFF_DECIMAL_X_MASK  0x000001ff

#ifndef SDK_ASM
#define REG_G3_VTX_DIFF_FIELD(sz, decimal_z, sy, decimal_y, sx, decimal_x)                                                                                                                             \
    (u32)(((u32)(sz) << REG_G3_VTX_DIFF_SZ_SHIFT) | ((u32)(decimal_z) << REG_G3_VTX_DIFF_DECIMAL_Z_SHIFT) | ((u32)(sy) << REG_G3_VTX_DIFF_SY_SHIFT)                                                    \
          | ((u32)(decimal_y) << REG_G3_VTX_DIFF_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_VTX_DIFF_SX_SHIFT) | ((u32)(decimal_x) << REG_G3_VTX_DIFF_DECIMAL_X_SHIFT))
#endif

#define REG_G3_POLYGON_ATTR_ID_SHIFT 24
#define REG_G3_POLYGON_ATTR_ID_SIZE  6
#define REG_G3_POLYGON_ATTR_ID_MASK  0x3f000000

#define REG_G3_POLYGON_ATTR_ALPHA_SHIFT 16
#define REG_G3_POLYGON_ATTR_ALPHA_SIZE  5
#define REG_G3_POLYGON_ATTR_ALPHA_MASK  0x001f0000

#define REG_G3_POLYGON_ATTR_FE_SHIFT 15
#define REG_G3_POLYGON_ATTR_FE_SIZE  1
#define REG_G3_POLYGON_ATTR_FE_MASK  0x00008000

#define REG_G3_POLYGON_ATTR_DT_SHIFT 14
#define REG_G3_POLYGON_ATTR_DT_SIZE  1
#define REG_G3_POLYGON_ATTR_DT_MASK  0x00004000

#define REG_G3_POLYGON_ATTR_D1_SHIFT 13
#define REG_G3_POLYGON_ATTR_D1_SIZE  1
#define REG_G3_POLYGON_ATTR_D1_MASK  0x00002000

#define REG_G3_POLYGON_ATTR_FC_SHIFT 12
#define REG_G3_POLYGON_ATTR_FC_SIZE  1
#define REG_G3_POLYGON_ATTR_FC_MASK  0x00001000

#define REG_G3_POLYGON_ATTR_XL_SHIFT 11
#define REG_G3_POLYGON_ATTR_XL_SIZE  1
#define REG_G3_POLYGON_ATTR_XL_MASK  0x00000800

#define REG_G3_POLYGON_ATTR_FR_SHIFT 7
#define REG_G3_POLYGON_ATTR_FR_SIZE  1
#define REG_G3_POLYGON_ATTR_FR_MASK  0x00000080

#define REG_G3_POLYGON_ATTR_BK_SHIFT 6
#define REG_G3_POLYGON_ATTR_BK_SIZE  1
#define REG_G3_POLYGON_ATTR_BK_MASK  0x00000040

#define REG_G3_POLYGON_ATTR_PM_SHIFT 4
#define REG_G3_POLYGON_ATTR_PM_SIZE  2
#define REG_G3_POLYGON_ATTR_PM_MASK  0x00000030

#define REG_G3_POLYGON_ATTR_LE_SHIFT 0
#define REG_G3_POLYGON_ATTR_LE_SIZE  4
#define REG_G3_POLYGON_ATTR_LE_MASK  0x0000000f

#ifndef SDK_ASM
#define REG_G3_POLYGON_ATTR_FIELD(id, alpha, fe, dt, d1, fc, xl, fr, bk, pm, le)                                                                                                                       \
    (u32)(((u32)(id) << REG_G3_POLYGON_ATTR_ID_SHIFT) | ((u32)(alpha) << REG_G3_POLYGON_ATTR_ALPHA_SHIFT) | ((u32)(fe) << REG_G3_POLYGON_ATTR_FE_SHIFT) | ((u32)(dt) << REG_G3_POLYGON_ATTR_DT_SHIFT)  \
          | ((u32)(d1) << REG_G3_POLYGON_ATTR_D1_SHIFT) | ((u32)(fc) << REG_G3_POLYGON_ATTR_FC_SHIFT) | ((u32)(xl) << REG_G3_POLYGON_ATTR_XL_SHIFT) | ((u32)(fr) << REG_G3_POLYGON_ATTR_FR_SHIFT)      \
          | ((u32)(bk) << REG_G3_POLYGON_ATTR_BK_SHIFT) | ((u32)(pm) << REG_G3_POLYGON_ATTR_PM_SHIFT) | ((u32)(le) << REG_G3_POLYGON_ATTR_LE_SHIFT))
#endif

#define REG_G3_TEXIMAGE_PARAM_TGEN_SHIFT 30
#define REG_G3_TEXIMAGE_PARAM_TGEN_SIZE  2
#define REG_G3_TEXIMAGE_PARAM_TGEN_MASK  0xc0000000

#define REG_G3_TEXIMAGE_PARAM_TR_SHIFT 29
#define REG_G3_TEXIMAGE_PARAM_TR_SIZE  1
#define REG_G3_TEXIMAGE_PARAM_TR_MASK  0x20000000

#define REG_G3_TEXIMAGE_PARAM_TEXFMT_SHIFT 26
#define REG_G3_TEXIMAGE_PARAM_TEXFMT_SIZE  3
#define REG_G3_TEXIMAGE_PARAM_TEXFMT_MASK  0x1c000000

#define REG_G3_TEXIMAGE_PARAM_T_SIZE_SHIFT 23
#define REG_G3_TEXIMAGE_PARAM_T_SIZE_SIZE  3
#define REG_G3_TEXIMAGE_PARAM_T_SIZE_MASK  0x03800000

#define REG_G3_TEXIMAGE_PARAM_V_SIZE_SHIFT 20
#define REG_G3_TEXIMAGE_PARAM_V_SIZE_SIZE  3
#define REG_G3_TEXIMAGE_PARAM_V_SIZE_MASK  0x00700000

#define REG_G3_TEXIMAGE_PARAM_FT_SHIFT 19
#define REG_G3_TEXIMAGE_PARAM_FT_SIZE  1
#define REG_G3_TEXIMAGE_PARAM_FT_MASK  0x00080000

#define REG_G3_TEXIMAGE_PARAM_FS_SHIFT 18
#define REG_G3_TEXIMAGE_PARAM_FS_SIZE  1
#define REG_G3_TEXIMAGE_PARAM_FS_MASK  0x00040000

#define REG_G3_TEXIMAGE_PARAM_RT_SHIFT 17
#define REG_G3_TEXIMAGE_PARAM_RT_SIZE  1
#define REG_G3_TEXIMAGE_PARAM_RT_MASK  0x00020000

#define REG_G3_TEXIMAGE_PARAM_RS_SHIFT 16
#define REG_G3_TEXIMAGE_PARAM_RS_SIZE  1
#define REG_G3_TEXIMAGE_PARAM_RS_MASK  0x00010000

#define REG_G3_TEXIMAGE_PARAM_TEX_ADDR_SHIFT 0
#define REG_G3_TEXIMAGE_PARAM_TEX_ADDR_SIZE  16
#define REG_G3_TEXIMAGE_PARAM_TEX_ADDR_MASK  0x0000ffff

#ifndef SDK_ASM
#define REG_G3_TEXIMAGE_PARAM_FIELD(tgen, tr, texfmt, t_size, v_size, ft, fs, rt, rs, tex_addr)                                                                                                        \
    (u32)(((u32)(tgen) << REG_G3_TEXIMAGE_PARAM_TGEN_SHIFT) | ((u32)(tr) << REG_G3_TEXIMAGE_PARAM_TR_SHIFT) | ((u32)(texfmt) << REG_G3_TEXIMAGE_PARAM_TEXFMT_SHIFT)                                    \
          | ((u32)(t_size) << REG_G3_TEXIMAGE_PARAM_T_SIZE_SHIFT) | ((u32)(v_size) << REG_G3_TEXIMAGE_PARAM_V_SIZE_SHIFT) | ((u32)(ft) << REG_G3_TEXIMAGE_PARAM_FT_SHIFT)                              \
          | ((u32)(fs) << REG_G3_TEXIMAGE_PARAM_FS_SHIFT) | ((u32)(rt) << REG_G3_TEXIMAGE_PARAM_RT_SHIFT) | ((u32)(rs) << REG_G3_TEXIMAGE_PARAM_RS_SHIFT)                                              \
          | ((u32)(tex_addr) << REG_G3_TEXIMAGE_PARAM_TEX_ADDR_SHIFT))
#endif

#define REG_G3_TEXPLTT_BASE_PLTT_BASE_SHIFT 0
#define REG_G3_TEXPLTT_BASE_PLTT_BASE_SIZE  13
#define REG_G3_TEXPLTT_BASE_PLTT_BASE_MASK  0x00001fff

#ifndef SDK_ASM
#define REG_G3_TEXPLTT_BASE_FIELD(pltt_base) (u32)(((u32)(pltt_base) << REG_G3_TEXPLTT_BASE_PLTT_BASE_SHIFT))
#endif

#define REG_G3_DIF_AMB_AMBIENT_BLUE_SHIFT 26
#define REG_G3_DIF_AMB_AMBIENT_BLUE_SIZE  5
#define REG_G3_DIF_AMB_AMBIENT_BLUE_MASK  0x7c000000

#define REG_G3_DIF_AMB_AMBIENT_GREEN_SHIFT 21
#define REG_G3_DIF_AMB_AMBIENT_GREEN_SIZE  5
#define REG_G3_DIF_AMB_AMBIENT_GREEN_MASK  0x03e00000

#define REG_G3_DIF_AMB_AMBIENT_RED_SHIFT 16
#define REG_G3_DIF_AMB_AMBIENT_RED_SIZE  5
#define REG_G3_DIF_AMB_AMBIENT_RED_MASK  0x001f0000

#define REG_G3_DIF_AMB_C_SHIFT 15
#define REG_G3_DIF_AMB_C_SIZE  1
#define REG_G3_DIF_AMB_C_MASK  0x00008000

#define REG_G3_DIF_AMB_DIFFUSE_BLUE_SHIFT 10
#define REG_G3_DIF_AMB_DIFFUSE_BLUE_SIZE  5
#define REG_G3_DIF_AMB_DIFFUSE_BLUE_MASK  0x00007c00

#define REG_G3_DIF_AMB_DIFFUSE_GREEN_SHIFT 5
#define REG_G3_DIF_AMB_DIFFUSE_GREEN_SIZE  5
#define REG_G3_DIF_AMB_DIFFUSE_GREEN_MASK  0x000003e0

#define REG_G3_DIF_AMB_DIFFUSE_RED_SHIFT 0
#define REG_G3_DIF_AMB_DIFFUSE_RED_SIZE  5
#define REG_G3_DIF_AMB_DIFFUSE_RED_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_DIF_AMB_FIELD(ambient_blue, ambient_green, ambient_red, c, diffuse_blue, diffuse_green, diffuse_red)                                                                                    \
    (u32)(((u32)(ambient_blue) << REG_G3_DIF_AMB_AMBIENT_BLUE_SHIFT) | ((u32)(ambient_green) << REG_G3_DIF_AMB_AMBIENT_GREEN_SHIFT) | ((u32)(ambient_red) << REG_G3_DIF_AMB_AMBIENT_RED_SHIFT)         \
          | ((u32)(c) << REG_G3_DIF_AMB_C_SHIFT) | ((u32)(diffuse_blue) << REG_G3_DIF_AMB_DIFFUSE_BLUE_SHIFT) | ((u32)(diffuse_green) << REG_G3_DIF_AMB_DIFFUSE_GREEN_SHIFT)                           \
          | ((u32)(diffuse_red) << REG_G3_DIF_AMB_DIFFUSE_RED_SHIFT))
#endif

#define REG_G3_SPE_EMI_EMISSION_BLUE_SHIFT 26
#define REG_G3_SPE_EMI_EMISSION_BLUE_SIZE  5
#define REG_G3_SPE_EMI_EMISSION_BLUE_MASK  0x7c000000

#define REG_G3_SPE_EMI_EMISSION_GREEN_SHIFT 21
#define REG_G3_SPE_EMI_EMISSION_GREEN_SIZE  5
#define REG_G3_SPE_EMI_EMISSION_GREEN_MASK  0x03e00000

#define REG_G3_SPE_EMI_EMISSION_RED_SHIFT 16
#define REG_G3_SPE_EMI_EMISSION_RED_SIZE  5
#define REG_G3_SPE_EMI_EMISSION_RED_MASK  0x001f0000

#define REG_G3_SPE_EMI_S_SHIFT 15
#define REG_G3_SPE_EMI_S_SIZE  1
#define REG_G3_SPE_EMI_S_MASK  0x00008000

#define REG_G3_SPE_EMI_SPECULAR_BLUE_SHIFT 10
#define REG_G3_SPE_EMI_SPECULAR_BLUE_SIZE  5
#define REG_G3_SPE_EMI_SPECULAR_BLUE_MASK  0x00007c00

#define REG_G3_SPE_EMI_SPECULAR_GREEN_SHIFT 5
#define REG_G3_SPE_EMI_SPECULAR_GREEN_SIZE  5
#define REG_G3_SPE_EMI_SPECULAR_GREEN_MASK  0x000003e0

#define REG_G3_SPE_EMI_SPECULAR_RED_SHIFT 0
#define REG_G3_SPE_EMI_SPECULAR_RED_SIZE  5
#define REG_G3_SPE_EMI_SPECULAR_RED_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_SPE_EMI_FIELD(emission_blue, emission_green, emission_red, s, specular_blue, specular_green, specular_red)                                                                              \
    (u32)(((u32)(emission_blue) << REG_G3_SPE_EMI_EMISSION_BLUE_SHIFT) | ((u32)(emission_green) << REG_G3_SPE_EMI_EMISSION_GREEN_SHIFT) | ((u32)(emission_red) << REG_G3_SPE_EMI_EMISSION_RED_SHIFT)   \
          | ((u32)(s) << REG_G3_SPE_EMI_S_SHIFT) | ((u32)(specular_blue) << REG_G3_SPE_EMI_SPECULAR_BLUE_SHIFT) | ((u32)(specular_green) << REG_G3_SPE_EMI_SPECULAR_GREEN_SHIFT)                       \
          | ((u32)(specular_red) << REG_G3_SPE_EMI_SPECULAR_RED_SHIFT))
#endif

#define REG_G3_LIGHT_VECTOR_LNUM_SHIFT 30
#define REG_G3_LIGHT_VECTOR_LNUM_SIZE  2
#define REG_G3_LIGHT_VECTOR_LNUM_MASK  0xc0000000

#define REG_G3_LIGHT_VECTOR_SZ_SHIFT 29
#define REG_G3_LIGHT_VECTOR_SZ_SIZE  1
#define REG_G3_LIGHT_VECTOR_SZ_MASK  0x20000000

#define REG_G3_LIGHT_VECTOR_DECIMAL_Z_SHIFT 20
#define REG_G3_LIGHT_VECTOR_DECIMAL_Z_SIZE  9
#define REG_G3_LIGHT_VECTOR_DECIMAL_Z_MASK  0x1ff00000

#define REG_G3_LIGHT_VECTOR_SY_SHIFT 19
#define REG_G3_LIGHT_VECTOR_SY_SIZE  1
#define REG_G3_LIGHT_VECTOR_SY_MASK  0x00080000

#define REG_G3_LIGHT_VECTOR_DECIMAL_Y_SHIFT 10
#define REG_G3_LIGHT_VECTOR_DECIMAL_Y_SIZE  9
#define REG_G3_LIGHT_VECTOR_DECIMAL_Y_MASK  0x0007fc00

#define REG_G3_LIGHT_VECTOR_SX_SHIFT 9
#define REG_G3_LIGHT_VECTOR_SX_SIZE  1
#define REG_G3_LIGHT_VECTOR_SX_MASK  0x00000200

#define REG_G3_LIGHT_VECTOR_DECIMAL_X_SHIFT 0
#define REG_G3_LIGHT_VECTOR_DECIMAL_X_SIZE  9
#define REG_G3_LIGHT_VECTOR_DECIMAL_X_MASK  0x000001ff

#ifndef SDK_ASM
#define REG_G3_LIGHT_VECTOR_FIELD(lnum, sz, decimal_z, sy, decimal_y, sx, decimal_x)                                                                                                                   \
    (u32)(((u32)(lnum) << REG_G3_LIGHT_VECTOR_LNUM_SHIFT) | ((u32)(sz) << REG_G3_LIGHT_VECTOR_SZ_SHIFT) | ((u32)(decimal_z) << REG_G3_LIGHT_VECTOR_DECIMAL_Z_SHIFT)                                    \
          | ((u32)(sy) << REG_G3_LIGHT_VECTOR_SY_SHIFT) | ((u32)(decimal_y) << REG_G3_LIGHT_VECTOR_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_LIGHT_VECTOR_SX_SHIFT)                                      \
          | ((u32)(decimal_x) << REG_G3_LIGHT_VECTOR_DECIMAL_X_SHIFT))
#endif

#define REG_G3_LIGHT_COLOR_LNUM_SHIFT 30
#define REG_G3_LIGHT_COLOR_LNUM_SIZE  2
#define REG_G3_LIGHT_COLOR_LNUM_MASK  0xc0000000

#define REG_G3_LIGHT_COLOR_BLUE_SHIFT 10
#define REG_G3_LIGHT_COLOR_BLUE_SIZE  5
#define REG_G3_LIGHT_COLOR_BLUE_MASK  0x00007c00

#define REG_G3_LIGHT_COLOR_GREEN_SHIFT 5
#define REG_G3_LIGHT_COLOR_GREEN_SIZE  5
#define REG_G3_LIGHT_COLOR_GREEN_MASK  0x000003e0

#define REG_G3_LIGHT_COLOR_RED_SHIFT 0
#define REG_G3_LIGHT_COLOR_RED_SIZE  5
#define REG_G3_LIGHT_COLOR_RED_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_G3_LIGHT_COLOR_FIELD(lnum, blue, green, red)                                                                                                                                               \
    (u32)(((u32)(lnum) << REG_G3_LIGHT_COLOR_LNUM_SHIFT) | ((u32)(blue) << REG_G3_LIGHT_COLOR_BLUE_SHIFT) | ((u32)(green) << REG_G3_LIGHT_COLOR_GREEN_SHIFT)                                           \
          | ((u32)(red) << REG_G3_LIGHT_COLOR_RED_SHIFT))
#endif

#define REG_G3_SHININESS_SHININESS3_SHIFT 24
#define REG_G3_SHININESS_SHININESS3_SIZE  8
#define REG_G3_SHININESS_SHININESS3_MASK  0xff000000

#define REG_G3_SHININESS_SHININESS2_SHIFT 16
#define REG_G3_SHININESS_SHININESS2_SIZE  8
#define REG_G3_SHININESS_SHININESS2_MASK  0x00ff0000

#define REG_G3_SHININESS_SHININESS1_SHIFT 8
#define REG_G3_SHININESS_SHININESS1_SIZE  8
#define REG_G3_SHININESS_SHININESS1_MASK  0x0000ff00

#define REG_G3_SHININESS_SHININESS0_SHIFT 0
#define REG_G3_SHININESS_SHININESS0_SIZE  8
#define REG_G3_SHININESS_SHININESS0_MASK  0x000000ff

#ifndef SDK_ASM
#define REG_G3_SHININESS_FIELD(shininess3, shininess2, shininess1, shininess0)                                                                                                                         \
    (u32)(((u32)(shininess3) << REG_G3_SHININESS_SHININESS3_SHIFT) | ((u32)(shininess2) << REG_G3_SHININESS_SHININESS2_SHIFT) | ((u32)(shininess1) << REG_G3_SHININESS_SHININESS1_SHIFT)               \
          | ((u32)(shininess0) << REG_G3_SHININESS_SHININESS0_SHIFT))
#endif

#define REG_G3_BEGIN_VTXS_TYPE_SHIFT 0
#define REG_G3_BEGIN_VTXS_TYPE_SIZE  2
#define REG_G3_BEGIN_VTXS_TYPE_MASK  0x00000003

#ifndef SDK_ASM
#define REG_G3_BEGIN_VTXS_FIELD(type) (u32)(((u32)(type) << REG_G3_BEGIN_VTXS_TYPE_SHIFT))
#endif

#define REG_G3_SWAP_BUFFERS_DP_SHIFT 1
#define REG_G3_SWAP_BUFFERS_DP_SIZE  1
#define REG_G3_SWAP_BUFFERS_DP_MASK  0x00000002

#define REG_G3_SWAP_BUFFERS_XS_SHIFT 0
#define REG_G3_SWAP_BUFFERS_XS_SIZE  1
#define REG_G3_SWAP_BUFFERS_XS_MASK  0x00000001

#ifndef SDK_ASM
#define REG_G3_SWAP_BUFFERS_FIELD(dp, xs) (u32)(((u32)(dp) << REG_G3_SWAP_BUFFERS_DP_SHIFT) | ((u32)(xs) << REG_G3_SWAP_BUFFERS_XS_SHIFT))
#endif

#define REG_G3_VIEWPORT_INTEGER_Y2_SHIFT 24
#define REG_G3_VIEWPORT_INTEGER_Y2_SIZE  8
#define REG_G3_VIEWPORT_INTEGER_Y2_MASK  0xff000000

#define REG_G3_VIEWPORT_INTEGER_X2_SHIFT 16
#define REG_G3_VIEWPORT_INTEGER_X2_SIZE  8
#define REG_G3_VIEWPORT_INTEGER_X2_MASK  0x00ff0000

#define REG_G3_VIEWPORT_INTEGER_Y1_SHIFT 8
#define REG_G3_VIEWPORT_INTEGER_Y1_SIZE  8
#define REG_G3_VIEWPORT_INTEGER_Y1_MASK  0x0000ff00

#define REG_G3_VIEWPORT_INTEGER_X1_SHIFT 0
#define REG_G3_VIEWPORT_INTEGER_X1_SIZE  8
#define REG_G3_VIEWPORT_INTEGER_X1_MASK  0x000000ff

#ifndef SDK_ASM
#define REG_G3_VIEWPORT_FIELD(integer_y2, integer_x2, integer_y1, integer_x1)                                                                                                                          \
    (u32)(((u32)(integer_y2) << REG_G3_VIEWPORT_INTEGER_Y2_SHIFT) | ((u32)(integer_x2) << REG_G3_VIEWPORT_INTEGER_X2_SHIFT) | ((u32)(integer_y1) << REG_G3_VIEWPORT_INTEGER_Y1_SHIFT)                  \
          | ((u32)(integer_x1) << REG_G3_VIEWPORT_INTEGER_X1_SHIFT))
#endif

#define REG_G3_BOX_TEST_SY_SHIFT 31
#define REG_G3_BOX_TEST_SY_SIZE  1
#define REG_G3_BOX_TEST_SY_MASK  0x80000000

#define REG_G3_BOX_TEST_INT_Y_SHIFT 28
#define REG_G3_BOX_TEST_INT_Y_SIZE  3
#define REG_G3_BOX_TEST_INT_Y_MASK  0x70000000

#define REG_G3_BOX_TEST_DECIMAL_Y_SHIFT 16
#define REG_G3_BOX_TEST_DECIMAL_Y_SIZE  12
#define REG_G3_BOX_TEST_DECIMAL_Y_MASK  0x0fff0000

#define REG_G3_BOX_TEST_SX_SHIFT 15
#define REG_G3_BOX_TEST_SX_SIZE  1
#define REG_G3_BOX_TEST_SX_MASK  0x00008000

#define REG_G3_BOX_TEST_INT_X_SHIFT 12
#define REG_G3_BOX_TEST_INT_X_SIZE  3
#define REG_G3_BOX_TEST_INT_X_MASK  0x00007000

#define REG_G3_BOX_TEST_DECIMAL_X_SHIFT 0
#define REG_G3_BOX_TEST_DECIMAL_X_SIZE  12
#define REG_G3_BOX_TEST_DECIMAL_X_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_BOX_TEST_FIELD(sy, int_y, decimal_y, sx, int_x, decimal_x)                                                                                                                              \
    (u32)(((u32)(sy) << REG_G3_BOX_TEST_SY_SHIFT) | ((u32)(int_y) << REG_G3_BOX_TEST_INT_Y_SHIFT) | ((u32)(decimal_y) << REG_G3_BOX_TEST_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_BOX_TEST_SX_SHIFT)    \
          | ((u32)(int_x) << REG_G3_BOX_TEST_INT_X_SHIFT) | ((u32)(decimal_x) << REG_G3_BOX_TEST_DECIMAL_X_SHIFT))
#endif

#define REG_G3_POS_TEST_SY_SHIFT 31
#define REG_G3_POS_TEST_SY_SIZE  1
#define REG_G3_POS_TEST_SY_MASK  0x80000000

#define REG_G3_POS_TEST_INT_Y_SHIFT 28
#define REG_G3_POS_TEST_INT_Y_SIZE  3
#define REG_G3_POS_TEST_INT_Y_MASK  0x70000000

#define REG_G3_POS_TEST_DECIMAL_Y_SHIFT 16
#define REG_G3_POS_TEST_DECIMAL_Y_SIZE  12
#define REG_G3_POS_TEST_DECIMAL_Y_MASK  0x0fff0000

#define REG_G3_POS_TEST_SX_SHIFT 15
#define REG_G3_POS_TEST_SX_SIZE  1
#define REG_G3_POS_TEST_SX_MASK  0x00008000

#define REG_G3_POS_TEST_INT_X_SHIFT 12
#define REG_G3_POS_TEST_INT_X_SIZE  3
#define REG_G3_POS_TEST_INT_X_MASK  0x00007000

#define REG_G3_POS_TEST_DECIMAL_X_SHIFT 0
#define REG_G3_POS_TEST_DECIMAL_X_SIZE  12
#define REG_G3_POS_TEST_DECIMAL_X_MASK  0x00000fff

#ifndef SDK_ASM
#define REG_G3_POS_TEST_FIELD(sy, int_y, decimal_y, sx, int_x, decimal_x)                                                                                                                              \
    (u32)(((u32)(sy) << REG_G3_POS_TEST_SY_SHIFT) | ((u32)(int_y) << REG_G3_POS_TEST_INT_Y_SHIFT) | ((u32)(decimal_y) << REG_G3_POS_TEST_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_POS_TEST_SX_SHIFT)    \
          | ((u32)(int_x) << REG_G3_POS_TEST_INT_X_SHIFT) | ((u32)(decimal_x) << REG_G3_POS_TEST_DECIMAL_X_SHIFT))
#endif

#define REG_G3_VEC_TEST_SZ_SHIFT 29
#define REG_G3_VEC_TEST_SZ_SIZE  1
#define REG_G3_VEC_TEST_SZ_MASK  0x20000000

#define REG_G3_VEC_TEST_DECIMAL_Z_SHIFT 20
#define REG_G3_VEC_TEST_DECIMAL_Z_SIZE  9
#define REG_G3_VEC_TEST_DECIMAL_Z_MASK  0x1ff00000

#define REG_G3_VEC_TEST_SY_SHIFT 19
#define REG_G3_VEC_TEST_SY_SIZE  1
#define REG_G3_VEC_TEST_SY_MASK  0x00080000

#define REG_G3_VEC_TEST_DECIMAL_Y_SHIFT 10
#define REG_G3_VEC_TEST_DECIMAL_Y_SIZE  9
#define REG_G3_VEC_TEST_DECIMAL_Y_MASK  0x0007fc00

#define REG_G3_VEC_TEST_SX_SHIFT 9
#define REG_G3_VEC_TEST_SX_SIZE  1
#define REG_G3_VEC_TEST_SX_MASK  0x00000200

#define REG_G3_VEC_TEST_DECIMAL_X_SHIFT 0
#define REG_G3_VEC_TEST_DECIMAL_X_SIZE  9
#define REG_G3_VEC_TEST_DECIMAL_X_MASK  0x000001ff

#ifndef SDK_ASM
#define REG_G3_VEC_TEST_FIELD(sz, decimal_z, sy, decimal_y, sx, decimal_x)                                                                                                                             \
    (u32)(((u32)(sz) << REG_G3_VEC_TEST_SZ_SHIFT) | ((u32)(decimal_z) << REG_G3_VEC_TEST_DECIMAL_Z_SHIFT) | ((u32)(sy) << REG_G3_VEC_TEST_SY_SHIFT)                                                    \
          | ((u32)(decimal_y) << REG_G3_VEC_TEST_DECIMAL_Y_SHIFT) | ((u32)(sx) << REG_G3_VEC_TEST_SX_SHIFT) | ((u32)(decimal_x) << REG_G3_VEC_TEST_DECIMAL_X_SHIFT))
#endif