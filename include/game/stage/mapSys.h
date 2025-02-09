#ifndef RUSH_MAP_SYS_H
#define RUSH_MAP_SYS_H

#include <global.h>
#include <game/math/mtMath.h>
#include <game/system/task.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define MAPOBJECT_DESTROYED (0xFF)

// offset of bottom screen camera
#define BOTTOM_SCREEN_CAMERA_OFFSET (HW_LCD_HEIGHT + 80)

#define MAPSYS_WATERLEVEL_NONE (0xFFFF)

// --------------------
// MACROS
// --------------------

#define DestroyMapObject(obj) (obj)->x = MAPOBJECT_DESTROYED

// --------------------
// ENUMS
// --------------------

enum MapSysFlags_
{
    MAPSYS_FLAG_NONE = 0x00,

    MAPSYS_FLAG_UNKNOWN      = 1 << 0,
    MAPSYS_FLAG_LOOKING_UP   = 1 << 1,
    MAPSYS_FLAG_LOOKING_DOWN = 1 << 2,
};
typedef u32 MapSysFlags;

enum MapSysCameraControlFlags_
{
    MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS          = 0x1,
    MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP             = 0x2,
    MAPSYS_CAMERACTRL_FLAG_DISABLE_SCREEN_SWAP      = 0x4,
    MAPSYS_CAMERACTRL_FLAG_USE_SCREEN_SWAP_OVERRIDE = 0x8,
    MAPSYS_CAMERACTRL_FLAG_10                       = 0x10,
    MAPSYS_CAMERACTRL_FLAG_20                       = 0x20,
    MAPSYS_CAMERACTRL_FLAG_40                       = 0x40,
    MAPSYS_CAMERACTRL_FLAG_80                       = 0x80,
    MAPSYS_CAMERACTRL_FLAG_DISABLE_CAM_LOOK         = 0x100,
    MAPSYS_CAMERACTRL_FLAG_200                      = 0x200,
    MAPSYS_CAMERACTRL_FLAG_400                      = 0x400,
    MAPSYS_CAMERACTRL_FLAG_800                      = 0x800,
    MAPSYS_CAMERACTRL_FLAG_1000                     = 0x1000,
    MAPSYS_CAMERACTRL_FLAG_2000                     = 0x2000,
    MAPSYS_CAMERACTRL_FLAG_4000                     = 0x4000,
    MAPSYS_CAMERACTRL_FLAG_8000                     = 0x8000,
    MAPSYS_CAMERACTRL_FLAG_10000                    = 0x10000,
    MAPSYS_CAMERACTRL_FLAG_20000                    = 0x20000,
    MAPSYS_CAMERACTRL_FLAG_40000                    = 0x40000,
    MAPSYS_CAMERACTRL_FLAG_80000                    = 0x80000,
};
typedef u32 MapSysCameraControlFlags;

enum MapSysCameraFlags_
{
    MAPSYS_CAMERA_FLAG_1        = 0x1,
    MAPSYS_CAMERA_FLAG_2        = 0x2,
    MAPSYS_CAMERA_FLAG_4        = 0x4,
    MAPSYS_CAMERA_FLAG_8        = 0x8,
    MAPSYS_CAMERA_FLAG_10       = 0x10,
    MAPSYS_CAMERA_FLAG_20       = 0x20,
    MAPSYS_CAMERA_FLAG_40       = 0x40,
    MAPSYS_CAMERA_FLAG_80       = 0x80,
    MAPSYS_CAMERA_FLAG_100      = 0x100,
    MAPSYS_CAMERA_FLAG_200      = 0x200,
    MAPSYS_CAMERA_FLAG_400      = 0x400,
    MAPSYS_CAMERA_FLAG_800      = 0x800,
    MAPSYS_CAMERA_FLAG_1000     = 0x1000,
    MAPSYS_CAMERA_FLAG_2000     = 0x2000,
    MAPSYS_CAMERA_FLAG_4000     = 0x4000,
    MAPSYS_CAMERA_FLAG_8000     = 0x8000,
    MAPSYS_CAMERA_FLAG_10000    = 0x10000,
    MAPSYS_CAMERA_FLAG_20000    = 0x20000,
    MAPSYS_CAMERA_FLAG_40000    = 0x40000,
    MAPSYS_CAMERA_FLAG_80000    = 0x80000,
    MAPSYS_CAMERA_FLAG_100000   = 0x100000,
    MAPSYS_CAMERA_FLAG_200000   = 0x200000,
    MAPSYS_CAMERA_FLAG_400000   = 0x400000,
    MAPSYS_CAMERA_FLAG_800000   = 0x800000,
    MAPSYS_CAMERA_FLAG_1000000  = 0x1000000,
    MAPSYS_CAMERA_FLAG_2000000  = 0x2000000,
    MAPSYS_CAMERA_FLAG_4000000  = 0x4000000,
    MAPSYS_CAMERA_FLAG_8000000  = 0x8000000,
    MAPSYS_CAMERA_FLAG_10000000 = 0x10000000,
    MAPSYS_CAMERA_FLAG_20000000 = 0x20000000,
    MAPSYS_CAMERA_FLAG_40000000 = 0x40000000,
    MAPSYS_CAMERA_FLAG_80000000 = 0x80000000,
};
typedef u32 MapSysCameraFlags;

enum FileList_ArchiveMap
{
    ARC_MAP_FILE_CAMERAZONES,
    ARC_MAP_FILE_PALETTE,
    ARC_MAP_FILE_LAYOUTA,
    ARC_MAP_FILE_LAYOUTB,
    ARC_MAP_FILE_TITLECARD_STAGE,
};

enum FileList_ArchiveRaw
{
    ARC_RAW_FILE_ATTRIBUTES,
    ARC_RAW_FILE_CHUNKS,
    ARC_RAW_FILE_TILESET,
    ARC_RAW_FILE_HEIGHTMASKS,
    ARC_RAW_FILE_ANGLES,
};

enum MapObjectIDs
{
    MAPOBJECT_0,
    MAPOBJECT_1,
    MAPOBJECT_2,
    MAPOBJECT_3,
    MAPOBJECT_4,
    MAPOBJECT_5,
    MAPOBJECT_6,
    MAPOBJECT_7,
    MAPOBJECT_8,
    MAPOBJECT_9,
    MAPOBJECT_10,
    MAPOBJECT_11,
    MAPOBJECT_12,
    MAPOBJECT_13,
    MAPOBJECT_14,
    MAPOBJECT_15,
    MAPOBJECT_16,
    MAPOBJECT_17,
    MAPOBJECT_18,
    MAPOBJECT_19,
    MAPOBJECT_20,
    MAPOBJECT_21,
    MAPOBJECT_22,
    MAPOBJECT_23,
    MAPOBJECT_24,
    MAPOBJECT_25,
    MAPOBJECT_26,
    MAPOBJECT_27,
    MAPOBJECT_28,
    MAPOBJECT_29,
    MAPOBJECT_30,
    MAPOBJECT_31,
    MAPOBJECT_32,
    MAPOBJECT_33,
    MAPOBJECT_34,
    MAPOBJECT_35,
    MAPOBJECT_36,
    MAPOBJECT_37,
    MAPOBJECT_38,
    MAPOBJECT_39,
    MAPOBJECT_40,
    MAPOBJECT_41,
    MAPOBJECT_42,
    MAPOBJECT_43,
    MAPOBJECT_44,
    MAPOBJECT_45,
    MAPOBJECT_46,
    MAPOBJECT_47,
    MAPOBJECT_48,
    MAPOBJECT_49,
    MAPOBJECT_50,
    MAPOBJECT_51,
    MAPOBJECT_52,
    MAPOBJECT_53,
    MAPOBJECT_54,
    MAPOBJECT_55,
    MAPOBJECT_56,
    MAPOBJECT_57,
    MAPOBJECT_58,
    MAPOBJECT_59,
    MAPOBJECT_60,
    MAPOBJECT_61,
    MAPOBJECT_62,
    MAPOBJECT_63,
    MAPOBJECT_64,
    MAPOBJECT_65,
    MAPOBJECT_66,
    MAPOBJECT_67,
    MAPOBJECT_68,
    MAPOBJECT_69,
    MAPOBJECT_70,
    MAPOBJECT_71,
    MAPOBJECT_72,
    MAPOBJECT_73,
    MAPOBJECT_74,
    MAPOBJECT_75,
    MAPOBJECT_76,
    MAPOBJECT_77,
    MAPOBJECT_78,
    MAPOBJECT_79,
    MAPOBJECT_80,
    MAPOBJECT_81,
    MAPOBJECT_82,
    MAPOBJECT_83,
    MAPOBJECT_84,
    MAPOBJECT_85,
    MAPOBJECT_86,
    MAPOBJECT_87,
    MAPOBJECT_88,
    MAPOBJECT_89,
    MAPOBJECT_90,
    MAPOBJECT_91,
    MAPOBJECT_92,
    MAPOBJECT_93,
    MAPOBJECT_94,
    MAPOBJECT_95,
    MAPOBJECT_96,
    MAPOBJECT_97,
    MAPOBJECT_98,
    MAPOBJECT_99,
    MAPOBJECT_100,
    MAPOBJECT_101,
    MAPOBJECT_102,
    MAPOBJECT_103,
    MAPOBJECT_104,
    MAPOBJECT_105,
    MAPOBJECT_106,
    MAPOBJECT_107,
    MAPOBJECT_108,
    MAPOBJECT_109,
    MAPOBJECT_110,
    MAPOBJECT_111,
    MAPOBJECT_112,
    MAPOBJECT_113,
    MAPOBJECT_114,
    MAPOBJECT_115,
    MAPOBJECT_116,
    MAPOBJECT_117,
    MAPOBJECT_118,
    MAPOBJECT_119,
    MAPOBJECT_120,
    MAPOBJECT_121,
    MAPOBJECT_122,
    MAPOBJECT_123,
    MAPOBJECT_124,
    MAPOBJECT_125,
    MAPOBJECT_126,
    MAPOBJECT_127,
    MAPOBJECT_128,
    MAPOBJECT_129,
    MAPOBJECT_130,
    MAPOBJECT_131,
    MAPOBJECT_132,
    MAPOBJECT_133,
    MAPOBJECT_134,
    MAPOBJECT_135,
    MAPOBJECT_136,
    MAPOBJECT_137,
    MAPOBJECT_138,
    MAPOBJECT_139,
    MAPOBJECT_140,
    MAPOBJECT_141,
    MAPOBJECT_142,
    MAPOBJECT_143,
    MAPOBJECT_144,
    MAPOBJECT_145,
    MAPOBJECT_146,
    MAPOBJECT_147,
    MAPOBJECT_148,
    MAPOBJECT_149,
    MAPOBJECT_150,
    MAPOBJECT_151,
    MAPOBJECT_152,
    MAPOBJECT_153,
    MAPOBJECT_154,
    MAPOBJECT_155,
    MAPOBJECT_156,
    MAPOBJECT_157,
    MAPOBJECT_158,
    MAPOBJECT_159,
    MAPOBJECT_160,
    MAPOBJECT_161,
    MAPOBJECT_162,
    MAPOBJECT_163,
    MAPOBJECT_164,
    MAPOBJECT_165,
    MAPOBJECT_166,
    MAPOBJECT_167,
    MAPOBJECT_168,
    MAPOBJECT_169,
    MAPOBJECT_170,
    MAPOBJECT_171,
    MAPOBJECT_172,
    MAPOBJECT_173,
    MAPOBJECT_174,
    MAPOBJECT_175,
    MAPOBJECT_176,
    MAPOBJECT_177,
    MAPOBJECT_178,
    MAPOBJECT_179,
    MAPOBJECT_180,
    MAPOBJECT_181,
    MAPOBJECT_182,
    MAPOBJECT_183,
    MAPOBJECT_184,
    MAPOBJECT_185,
    MAPOBJECT_186,
    MAPOBJECT_187,
    MAPOBJECT_188,
    MAPOBJECT_189,
    MAPOBJECT_190,
    MAPOBJECT_191,
    MAPOBJECT_192,
    MAPOBJECT_193,
    MAPOBJECT_194,
    MAPOBJECT_195,
    MAPOBJECT_196,
    MAPOBJECT_197,
    MAPOBJECT_198,
    MAPOBJECT_199,
    MAPOBJECT_200,
    MAPOBJECT_201,
    MAPOBJECT_202,
    MAPOBJECT_203,
    MAPOBJECT_204,
    MAPOBJECT_205,
    MAPOBJECT_206,
    MAPOBJECT_207,
    MAPOBJECT_208,
    MAPOBJECT_209,
    MAPOBJECT_210,
    MAPOBJECT_211,
    MAPOBJECT_212,
    MAPOBJECT_213,
    MAPOBJECT_214,
    MAPOBJECT_215,
    MAPOBJECT_216,
    MAPOBJECT_217,
    MAPOBJECT_218,
    MAPOBJECT_219,
    MAPOBJECT_220,
    MAPOBJECT_221,
    MAPOBJECT_222,
    MAPOBJECT_223,
    MAPOBJECT_224,
    MAPOBJECT_225,
    MAPOBJECT_226,
    MAPOBJECT_227,
    MAPOBJECT_228,
    MAPOBJECT_229,
    MAPOBJECT_230,
    MAPOBJECT_231,
    MAPOBJECT_232,
    MAPOBJECT_233,
    MAPOBJECT_234,
    MAPOBJECT_235,
    MAPOBJECT_236,
    MAPOBJECT_237,
    MAPOBJECT_238,
    MAPOBJECT_239,
    MAPOBJECT_240,
    MAPOBJECT_241,
    MAPOBJECT_242,
    MAPOBJECT_243,
    MAPOBJECT_244,
    MAPOBJECT_245,
    MAPOBJECT_246,
    MAPOBJECT_247,
    MAPOBJECT_248,
    MAPOBJECT_249,
    MAPOBJECT_250,
    MAPOBJECT_251,
    MAPOBJECT_252,
    MAPOBJECT_253,
    MAPOBJECT_254,
    MAPOBJECT_255,
    MAPOBJECT_256,
    MAPOBJECT_257,
    MAPOBJECT_258,
    MAPOBJECT_259,
    MAPOBJECT_260,
    MAPOBJECT_261,
    MAPOBJECT_262,
    MAPOBJECT_263,
    MAPOBJECT_264,
    MAPOBJECT_265,
    MAPOBJECT_266,
    MAPOBJECT_267,
    MAPOBJECT_268,
    MAPOBJECT_269,
    MAPOBJECT_270,
    MAPOBJECT_271,
    MAPOBJECT_272,
    MAPOBJECT_273,
    MAPOBJECT_274,
    MAPOBJECT_275,
    MAPOBJECT_276,
    MAPOBJECT_277,
    MAPOBJECT_278,
    MAPOBJECT_279,
    MAPOBJECT_280,
    MAPOBJECT_281,
    MAPOBJECT_282,
    MAPOBJECT_283,
    MAPOBJECT_284,
    MAPOBJECT_285,
    MAPOBJECT_286,
    MAPOBJECT_287,
    MAPOBJECT_288,
    MAPOBJECT_289,
    MAPOBJECT_290,
    MAPOBJECT_291,
    MAPOBJECT_292,
    MAPOBJECT_293,
    MAPOBJECT_294,
    MAPOBJECT_295,
    MAPOBJECT_296,
    MAPOBJECT_297,
    MAPOBJECT_298,
    MAPOBJECT_299,
    MAPOBJECT_300,
    MAPOBJECT_301,
    MAPOBJECT_302,
    MAPOBJECT_303,
    MAPOBJECT_304,
    MAPOBJECT_305,
    MAPOBJECT_306,
    MAPOBJECT_307,
    MAPOBJECT_308,
    MAPOBJECT_309,
    MAPOBJECT_310,
    MAPOBJECT_311,
    MAPOBJECT_312,
    MAPOBJECT_313,
    MAPOBJECT_314,
    MAPOBJECT_315,
    MAPOBJECT_316,
    MAPOBJECT_317,
    MAPOBJECT_318,
    MAPOBJECT_319,
    MAPOBJECT_320,
    MAPOBJECT_321,
    MAPOBJECT_322,
    MAPOBJECT_323,
    MAPOBJECT_324,
    MAPOBJECT_325,
    MAPOBJECT_326,
    MAPOBJECT_327,
    MAPOBJECT_328,
    MAPOBJECT_329,
    MAPOBJECT_330,
    MAPOBJECT_331,
    MAPOBJECT_332,
    MAPOBJECT_333,
    MAPOBJECT_334,
    MAPOBJECT_335,
    MAPOBJECT_336,
    MAPOBJECT_337,
    MAPOBJECT_338,
    MAPOBJECT_339,
    MAPOBJECT_340,
    MAPOBJECT_341,
    MAPOBJECT_342,
    MAPOBJECT_343,
    MAPOBJECT_344,
    MAPOBJECT_345,
    MAPOBJECT_346,
    MAPOBJECT_347,
    MAPOBJECT_348,
    MAPOBJECT_349,

    MAPOBJECT_COUNT,
};

enum MapDecorationIDs
{
    MAPDECOR_0,
    MAPDECOR_1,
    MAPDECOR_2,
    MAPDECOR_3,
    MAPDECOR_4,
    MAPDECOR_5,
    MAPDECOR_6,
    MAPDECOR_7,
    MAPDECOR_8,
    MAPDECOR_9,
    MAPDECOR_10,
    MAPDECOR_11,
    MAPDECOR_12,
    MAPDECOR_13,
    MAPDECOR_14,
    MAPDECOR_15,
    MAPDECOR_16,
    MAPDECOR_17,
    MAPDECOR_18,
    MAPDECOR_19,
    MAPDECOR_20,
    MAPDECOR_21,
    MAPDECOR_22,
    MAPDECOR_23,
    MAPDECOR_24,
    MAPDECOR_25,
    MAPDECOR_26,
    MAPDECOR_27,
    MAPDECOR_28,
    MAPDECOR_29,
    MAPDECOR_30,
    MAPDECOR_31,
    MAPDECOR_32,
    MAPDECOR_33,
    MAPDECOR_34,
    MAPDECOR_35,
    MAPDECOR_36,
    MAPDECOR_37,
    MAPDECOR_38,
    MAPDECOR_39,
    MAPDECOR_40,
    MAPDECOR_41,
    MAPDECOR_42,
    MAPDECOR_43,
    MAPDECOR_44,
    MAPDECOR_45,
    MAPDECOR_46,
    MAPDECOR_47,
    MAPDECOR_48,
    MAPDECOR_49,
    MAPDECOR_50,
    MAPDECOR_51,
    MAPDECOR_52,
    MAPDECOR_53,
    MAPDECOR_54,
    MAPDECOR_55,
    MAPDECOR_56,
    MAPDECOR_57,
    MAPDECOR_58,
    MAPDECOR_59,
    MAPDECOR_60,
    MAPDECOR_61,
    MAPDECOR_62,
    MAPDECOR_63,
    MAPDECOR_64,
    MAPDECOR_65,
    MAPDECOR_66,
    MAPDECOR_67,
    MAPDECOR_68,
    MAPDECOR_69,
    MAPDECOR_70,
    MAPDECOR_71,
    MAPDECOR_72,
    MAPDECOR_73,
    MAPDECOR_74,
    MAPDECOR_75,
    MAPDECOR_76,
    MAPDECOR_77,
    MAPDECOR_78,
    MAPDECOR_79,
    MAPDECOR_80,
    MAPDECOR_81,
    MAPDECOR_82,
    MAPDECOR_83,
    MAPDECOR_84,
    MAPDECOR_85,
    MAPDECOR_86,
    MAPDECOR_87,
    MAPDECOR_88,
    MAPDECOR_89,
    MAPDECOR_90,
    MAPDECOR_91,
    MAPDECOR_92,
    MAPDECOR_93,
    MAPDECOR_94,
    MAPDECOR_95,
    MAPDECOR_96,
    MAPDECOR_97,
    MAPDECOR_98,
    MAPDECOR_99,
    MAPDECOR_100,
    MAPDECOR_101,
    MAPDECOR_102,
    MAPDECOR_103,
    MAPDECOR_104,
    MAPDECOR_105,
    MAPDECOR_106,
    MAPDECOR_107,
    MAPDECOR_108,
    MAPDECOR_109,
    MAPDECOR_110,
    MAPDECOR_111,
    MAPDECOR_112,
    MAPDECOR_113,
    MAPDECOR_114,
    MAPDECOR_115,
    MAPDECOR_116,
    MAPDECOR_117,
    MAPDECOR_118,
    MAPDECOR_119,
    MAPDECOR_120,
    MAPDECOR_121,
    MAPDECOR_122,
    MAPDECOR_123,
    MAPDECOR_124,
    MAPDECOR_125,
    MAPDECOR_126,
    MAPDECOR_127,
    MAPDECOR_128,
    MAPDECOR_129,
    MAPDECOR_130,
    MAPDECOR_131,
    MAPDECOR_132,
    MAPDECOR_133,
    MAPDECOR_134,
    MAPDECOR_135,
    MAPDECOR_136,
    MAPDECOR_137,
    MAPDECOR_138,
    MAPDECOR_139,
    MAPDECOR_140,
    MAPDECOR_141,
    MAPDECOR_142,
    MAPDECOR_143,
    MAPDECOR_144,
    MAPDECOR_145,
    MAPDECOR_146,
    MAPDECOR_147,
    MAPDECOR_148,
    MAPDECOR_149,
    MAPDECOR_150,
    MAPDECOR_151,
    MAPDECOR_152,
    MAPDECOR_153,
    MAPDECOR_154,
    MAPDECOR_155,
    MAPDECOR_156,
    MAPDECOR_157,
    MAPDECOR_158,
    MAPDECOR_159,
    MAPDECOR_160,
    MAPDECOR_161,
    MAPDECOR_162,
    MAPDECOR_163,
    MAPDECOR_164,
    MAPDECOR_165,
    MAPDECOR_166,
    MAPDECOR_167,
    MAPDECOR_168,
    MAPDECOR_169,
    MAPDECOR_170,
    MAPDECOR_171,
    MAPDECOR_172,
    MAPDECOR_173,
    MAPDECOR_174,
    MAPDECOR_175,
    MAPDECOR_176,
    MAPDECOR_177,
    MAPDECOR_178,
    MAPDECOR_179,
    MAPDECOR_180,
    MAPDECOR_181,
    MAPDECOR_182,
    MAPDECOR_183,
    MAPDECOR_184,
    MAPDECOR_185,
    MAPDECOR_186,
    MAPDECOR_187,
    MAPDECOR_188,
    MAPDECOR_189,
    MAPDECOR_190,
    MAPDECOR_191,
    MAPDECOR_192,
    MAPDECOR_193,
    MAPDECOR_194,
    MAPDECOR_195,
    MAPDECOR_196,
    MAPDECOR_197,
    MAPDECOR_198,
    MAPDECOR_199,
    MAPDECOR_200,
    MAPDECOR_201,
    MAPDECOR_202,
    MAPDECOR_203,
    MAPDECOR_204,
    MAPDECOR_205,
    MAPDECOR_206,
    MAPDECOR_207,
    MAPDECOR_208,
    MAPDECOR_209,
    MAPDECOR_210,
    MAPDECOR_211,
    MAPDECOR_212,
    MAPDECOR_213,
    MAPDECOR_214,
    MAPDECOR_215,
    MAPDECOR_216,
    MAPDECOR_217,
    MAPDECOR_218,
    MAPDECOR_219,
    MAPDECOR_220,
    MAPDECOR_221,
    MAPDECOR_222,
    MAPDECOR_223,
    MAPDECOR_224,
    MAPDECOR_225,
    MAPDECOR_226,
    MAPDECOR_227,
    MAPDECOR_228,
    MAPDECOR_229,
    MAPDECOR_230,
    MAPDECOR_231,
    MAPDECOR_232,
    MAPDECOR_233,
    MAPDECOR_234,
    MAPDECOR_235,
    MAPDECOR_236,
    MAPDECOR_237,
    MAPDECOR_238,
    MAPDECOR_239,
    MAPDECOR_240,
    MAPDECOR_241,
    MAPDECOR_242,
    MAPDECOR_243,
    MAPDECOR_244,
    MAPDECOR_245,
    MAPDECOR_246,
    MAPDECOR_247,
    MAPDECOR_248,
    MAPDECOR_249,
    MAPDECOR_250,
    MAPDECOR_251,
    MAPDECOR_252,
    MAPDECOR_253,
    MAPDECOR_254,
    MAPDECOR_255,
    MAPDECOR_256,
    MAPDECOR_257,
    MAPDECOR_258,
    MAPDECOR_259,
    MAPDECOR_260,
    MAPDECOR_261,
    MAPDECOR_262,
    MAPDECOR_263,
    MAPDECOR_264,
    MAPDECOR_265,
    MAPDECOR_266,
    MAPDECOR_267,
    MAPDECOR_268,
    MAPDECOR_269,
    MAPDECOR_270,
    MAPDECOR_271,
    MAPDECOR_272,
    MAPDECOR_273,
    MAPDECOR_274,
    MAPDECOR_275,
    MAPDECOR_276,
    MAPDECOR_277,
    MAPDECOR_278,
    MAPDECOR_279,
    MAPDECOR_280,
    MAPDECOR_281,
    MAPDECOR_282,
    MAPDECOR_283,
    MAPDECOR_284,
    MAPDECOR_285,
    MAPDECOR_286,
    MAPDECOR_287,
    MAPDECOR_288,
    MAPDECOR_289,
    MAPDECOR_290,
    MAPDECOR_291,
    MAPDECOR_292,
    MAPDECOR_293,
    MAPDECOR_294,
    MAPDECOR_295,
    MAPDECOR_296,
    MAPDECOR_297,
    MAPDECOR_298,
    MAPDECOR_299,
    MAPDECOR_300,
    MAPDECOR_301,
    MAPDECOR_302,
    MAPDECOR_303,
    MAPDECOR_304,

    MAPDECOR_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct ViewRect_
{
    s32 left;
    s32 top;
    s32 right;
    s32 bottom;
} ViewRect;

typedef struct MapObject_
{
    u8 x;
    u8 y;
    u16 id;
    u16 flags;
    s8 left;
    s8 top;
    u8 width;
    u8 height;

#ifdef __cplusplus
    u8 param[2];
#else
    union
    {
        u16 u16;
        struct
        {
            u8 u8[2];
        };

        struct
        {
            u8 tensionPenalty;
            u8 health;
        };

    } param;
#endif
} MapObject;

typedef struct MapRing_
{
    u8 x;
    u8 y;
} MapRing;

typedef struct MapDecor_
{
    u8 x;
    u8 y;
    u16 id;
} MapDecor;

typedef struct MapLayout_
{
    u16 width;
    u16 height;
    u16 blocks[1]; // C-styled variable length array (width x height blocks)
} MapLayout;

typedef struct MapCameraZones_
{
    u16 width;
    u16 height;
    u8 data[1];
} MapCameraZones;

typedef struct MapSysCamera_
{
    MapSysCameraFlags flags;
    Vec2Fx32 disp_pos;
    Vec2Fx32 prev_disp_pos;
    Vec2Fx32 velocity;
    Vec2Fx16 offset;
    Vec2Fx16 disp_offset;
    Vec2Fx32 scale;
    u16 angle;
    void *screenMappings[2];
    Vec2Fx32 bgPos;
    u32 flags2;
    u8 field_44;
    u8 field_45;
    s8 targetPlayerID;
    u8 field_47;
    Vec2Fx32 targetOffset[2];
    fx32 boundsL;
    fx32 boundsT;
    fx32 boundsR;
    fx32 boundsB;
    u8 field_68;
    u8 field_69;
    u8 field_6A;
    u8 field_6B;
    u8 field_6C;
    u8 field_6D;
    u16 waterLevel;
} MapSysCamera;

typedef struct MapSysCameraControl_
{
    MapSysCameraControlFlags flags;
    MapSysCameraControlFlags prevFlags;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    fx32 screenSwapOverride;
    u32 bossArenaRadius;
    u32 bossArenaLeft;
    u32 bossArenaRight;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    s32 field_30;
    s32 field_34;
    s32 field_38;
    s32 field_3C;
    s32 field_40;
    s32 field_44;
    s16 field_48;
    u16 width;
    u16 height;
    ViewRect bounds;
} MapSysCameraControl;

typedef struct MapSysCameraSys_
{
    MapSysCamera camera[2];
    MapSysCameraControl camControl;
} MapSysCameraSys;

typedef struct MapSysFiles_
{
    void *collisionHeightMasks;
    void *collisionAttributes;
    void *collisionAngles;
    void *blockset;
    MapLayout *mapLayout[2];
    MapCameraZones *mapCameraZones;
} MapSysFiles;

// --------------------
// STRUCTS
// --------------------

typedef struct MapSys_
{
    MapSysFlags flags;
    s16 field_4;
    s16 timer;
    s32 field_8;
    void (*stateCamLook)(struct MapSys_ *work);
} MapSys;

// --------------------
// VARIABLES
// --------------------

extern MapSysFiles mapSysFiles;
extern MapSysCameraSys mapCamera;

// --------------------
// FUNCTIONS
// --------------------

// MapSys
void MapSys__Init(void);
void MapSys__Create(void);
void MapSys__Func_2008714(void);
void MapSys__LoadArchive_RAW(void *archive);
void MapSys__LoadArchive_MAP(void *archive);
void MapSys__Flush(void);
void MapSys__BuildData(void);
void MapSys__Release(void);
void MapSys__DrawLayout(void);
BOOL MapSys__GetDispSelect(void);
MapSysCamera *MapSys__GetCameraA(void);
MapSysCamera *MapSys__GetCameraB(void);
void MapSys__Func_2008F28(s32 id);
void MapSys__GetPosition(MapSysCamera *camera, fx32 *x, fx32 *y);
void MapSys__Func_20090D0(MapSysCamera *camera, fx32 offsetX, fx32 offsetY, fx16 *x, fx16 *y);
void MapSys__SetTargetOffsetA(fx32 x, fx32 y);
void MapSys__SetTargetOffset(s32 id, fx32 x, fx32 y);
void MapSys__Func_2009190(s32 id);
void MapSys__Func_20091B0(s32 id);
void MapSys__Func_20091D0(s32 id);
void MapSys__Func_20091F0(s32 id);
s32 MapSys__GetScreenSwapPos(fx32 x);
void MapSys__GetCameraPositionCB(fx32 *x, fx32 *y);
void MapSys__LoadZoneTiles(void *archive);
void MapSys__LoadZoneMap(void *archive);
void MapSys__LoadBossTiles_Zone1(void *archive);
void MapSys__LoadBossTiles_Zone2(void *archive);
void MapSys__LoadBossTiles_Zone3(void *archive);
void MapSys__LoadBossTiles_Zone4(void *archive);
void MapSys__LoadBossTiles_Zone5(void *archive);
void MapSys__LoadBossTiles_Zone6(void *archive);
void MapSys__LoadBossTiles_Zone7(void *archive);
void MapSys__LoadBossTiles_ZoneF(void *archive);
void MapSys__LoadBossMap_Zone1(void *archive);
void MapSys__LoadBossMap_Zone2(void *archive);
void MapSys__LoadBossMap_Zone3(void *archive);
void MapSys__LoadBossMap_Zone4(void *archive);
void MapSys__LoadBossMap_Zone5(void *archive);
void MapSys__LoadBossMap_Zone6(void *archive);
void MapSys__LoadBossMap_Zone7(void *archive);
void MapSys__LoadBossMap_ZoneF(void *archive);
void MapSys__LoadCollision(void *archive);
void MapSys__LoadTileLayout(void *archive);
void MapSys__InitStageBounds(void);
void MapSys__InitBoundsForStage(void);
void MapSys__InitBoundsForVSRings(void);
void MapSys__SetupBoss_Zone5(void);
void MapSys__Destructor(Task *task);
void MapSys__Main_Zone(void);
void MapSys__Main_Boss(void);
void MapSys__HandleCamera(MapSys *work);
void MapSys__Func_2009E3C(MapSys *work, s32 id);
void MapSys__Func_2009E80(MapSys *work, s32 id);
void MapSys__Func_200A460(MapSys *work, s32 id);
void MapSys__HandleCamBoundsX(MapSys *work, s32 id);
void MapSys__Func_200A580(MapSys *work, s32 id);
void MapSys__HandleHBounds(MapSys *work, s32 id);
void MapSys__HandleVBounds(MapSys *work, s32 id);
void MapSys__Func_200A780(MapSys *work, s32 id);
void MapSys__Func_200A7E8(MapSys *work, s32 id);
void MapSys__FollowTargetX(MapSys *work, s32 id);
void MapSys__FollowTargetY(MapSys *work, s32 id);
void MapSys__Func_200A8D8(MapSys *work, s32 id);
void MapSys__Func_200A910(MapSys *work, s32 id);
void MapSys__Func_200A948(MapSys *work);
BOOL MapSys__Func_200AA18(MapSys *work);
BOOL MapSys__Func_200AA84(MapSys *work, s32 id);
void MapSys__Func_200AAF8(MapSys *work);
void MapSys__Func_200AC64(MapSys *work, s32 id);
void MapSys__HandleCamLook(MapSys *work);
void MapSys__HandleCameraLookUpDown(MapSys *work);
void MapSys__CamLook_HandlePlayerLookUpDown(MapSys *work);
void MapSys__CamLook_LookingUp(MapSys *work);
void MapSys__CamLook_LookUpIdle(MapSys *work);
void MapSys__CamLook_LookingDown(MapSys *work);
void MapSys__CamLook_LookDownIdle(MapSys *work);
void MapSys__CamLook_Reset(MapSys *work);
void MapSys__HandleCameraScreenSwap(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MAP_SYS_H