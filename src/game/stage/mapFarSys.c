#include <game/stage/mapFarSys.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/graphics/mappingsQueue.h>
#include <game/text/fontDMAControl.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _s32_div_f(void);
NOT_DECOMPILED void Unknown2051334__Func_2051534(void);

// --------------------
// TYPES
// --------------------

typedef void (*MapFarSysInitFunc)(void);
typedef void (*MapFarSysProcessFunc)(void);
typedef void (*MapFarSysReleaseFunc)(void);

// --------------------
// STRUCTS
// --------------------

typedef struct MapFarSysScroll_
{
    u16 width;
    u16 pos;
} MapFarSysScroll;

struct MapFarSysUnknown
{
    u32 flags;
    Task *task;
    fx32 scrollSpeedY[2];
    Vec2Fx32 scrollSpeed[2];
    int bg1VOfs;
    int field_24;
    int field_28;
    int field_2C;
    int field_30;
    int field_34;
    int field_38;
    int field_3C;
    int field_40;
    int field_44;
    int field_48;
    int field_4C;
    int field_50;
    int field_54;
    int field_58;
    int field_5C;
    int field_60;
    int field_64;
    int field_68;
    int field_6C;
    int field_70;
    int field_74;
    int field_78;
    int field_7C;
    int field_80;
    int field_84;
    int field_88;
    int field_8C;
    int field_90;
    int field_94;
    int field_98;
    int field_9C;
    int field_A0;
    int field_A4;
    int field_A8;
    int field_AC;
    int field_B0;
    int field_B4;
    int field_B8;
    int field_BC;
    int field_C0;
    int field_C4;
    int field_C8;
    int field_CC;
    int field_D0;
    int field_D4;
    int field_D8;
    int field_DC;
    int field_E0;
    int field_E4;
    int field_E8;
    int field_EC;
    int field_F0;
    int field_F4;
    int field_F8;
    int field_FC;
    int field_100;
    int field_104;
    int field_108;
    int field_10C;
    int field_110;
    int field_114;
    int field_118;
    int field_11C;
    int field_120;
    int field_124;
    int field_128;
    int field_12C;
    int field_130;
    int field_134;
    int field_138;
    int field_13C;
    int field_140;
    int field_144;
    int field_148;
    int field_14C;
    int field_150;
    int field_154;
    int field_158;
    int field_15C;
    int field_160;
    int field_164;
    int field_168;
    int field_16C;
    int field_170;
    int field_174;
    int field_178;
    int field_17C;
    int field_180;
    int field_184;
    int field_188;
    int field_18C;
    int field_190;
    int field_194;
    int field_198;
    int field_19C;
    int bg1VOfs_sub;
    int field_1A4;
    int field_1A8;
    int field_1AC;
    int field_1B0;
    int field_1B4;
    int field_1B8;
    int field_1BC;
    int field_1C0;
    int field_1C4;
    int field_1C8;
    int field_1CC;
    int field_1D0;
    int field_1D4;
    int field_1D8;
    int field_1DC;
    int field_1E0;
    int field_1E4;
    int field_1E8;
    int field_1EC;
    int field_1F0;
    int field_1F4;
    int field_1F8;
    int field_1FC;
    int field_200;
    int field_204;
    int field_208;
    int field_20C;
    int field_210;
    int field_214;
    int field_218;
    int field_21C;
    int field_220;
    int field_224;
    int field_228;
    int field_22C;
    int field_230;
    int field_234;
    int field_238;
    int field_23C;
    int field_240;
    int field_244;
    int field_248;
    int field_24C;
    int field_250;
    int field_254;
    int field_258;
    int field_25C;
    int field_260;
    int field_264;
    int field_268;
    int field_26C;
    int field_270;
    int field_274;
    int field_278;
    int field_27C;
    int field_280;
    int field_284;
    int field_288;
    int field_28C;
    int field_290;
    int field_294;
    int field_298;
    int field_29C;
    int field_2A0;
    int field_2A4;
    int field_2A8;
    int field_2AC;
    int field_2B0;
    int field_2B4;
    int field_2B8;
    int field_2BC;
    int field_2C0;
    int field_2C4;
    int field_2C8;
    int field_2CC;
    int field_2D0;
    int field_2D4;
    int field_2D8;
    int field_2DC;
    int field_2E0;
    int field_2E4;
    int field_2E8;
    int field_2EC;
    int field_2F0;
    int field_2F4;
    int field_2F8;
    int field_2FC;
    int field_300;
    int field_304;
    int field_308;
    int field_30C;
    int field_310;
    int field_314;
    int field_318;
    int field_31C;
    int bg1VOfs_2;
    int field_324;
    int field_328;
    int field_32C;
    int field_330;
    int field_334;
    int field_338;
    int field_33C;
    int field_340;
    int field_344;
    int field_348;
    int field_34C;
    int field_350;
    int field_354;
    int field_358;
    int field_35C;
    int field_360;
    int field_364;
    int field_368;
    int field_36C;
    int field_370;
    int field_374;
    int field_378;
    int field_37C;
    int field_380;
    int field_384;
    int field_388;
    int field_38C;
    int field_390;
    int field_394;
    int field_398;
    int field_39C;
    int field_3A0;
    int field_3A4;
    int field_3A8;
    int field_3AC;
    int field_3B0;
    int field_3B4;
    int field_3B8;
    int field_3BC;
    int field_3C0;
    int field_3C4;
    int field_3C8;
    int field_3CC;
    int field_3D0;
    int field_3D4;
    int field_3D8;
    int field_3DC;
    int field_3E0;
    int field_3E4;
    int field_3E8;
    int field_3EC;
    int field_3F0;
    int field_3F4;
    int field_3F8;
    int field_3FC;
    int field_400;
    int field_404;
    int field_408;
    int field_40C;
    int field_410;
    int field_414;
    int field_418;
    int field_41C;
    int field_420;
    int field_424;
    int field_428;
    int field_42C;
    int field_430;
    int field_434;
    int field_438;
    int field_43C;
    int field_440;
    int field_444;
    int field_448;
    int field_44C;
    int field_450;
    int field_454;
    int field_458;
    int field_45C;
    int field_460;
    int field_464;
    int field_468;
    int field_46C;
    int field_470;
    int field_474;
    int field_478;
    int field_47C;
    int field_480;
    int field_484;
    int field_488;
    int field_48C;
    int field_490;
    int field_494;
    int field_498;
    int field_49C;
    int bg1VOfs_sub_2;
    int field_4A4;
    int field_4A8;
    int field_4AC;
    int field_4B0;
    int field_4B4;
    int field_4B8;
    int field_4BC;
    int field_4C0;
    int field_4C4;
    int field_4C8;
    int field_4CC;
    int field_4D0;
    int field_4D4;
    int field_4D8;
    int field_4DC;
    int field_4E0;
    int field_4E4;
    int field_4E8;
    int field_4EC;
    int field_4F0;
    int field_4F4;
    int field_4F8;
    int field_4FC;
    int field_500;
    int field_504;
    int field_508;
    int field_50C;
    int field_510;
    int field_514;
    int field_518;
    int field_51C;
    int field_520;
    int field_524;
    int field_528;
    int field_52C;
    int field_530;
    int field_534;
    int field_538;
    int field_53C;
    int field_540;
    int field_544;
    int field_548;
    int field_54C;
    int field_550;
    int field_554;
    int field_558;
    int field_55C;
    int field_560;
    int field_564;
    int field_568;
    int field_56C;
    int field_570;
    int field_574;
    int field_578;
    int field_57C;
    int field_580;
    int field_584;
    int field_588;
    int field_58C;
    int field_590;
    int field_594;
    int field_598;
    int field_59C;
    int field_5A0;
    int field_5A4;
    int field_5A8;
    int field_5AC;
    int field_5B0;
    int field_5B4;
    int field_5B8;
    int field_5BC;
    int field_5C0;
    int field_5C4;
    int field_5C8;
    int field_5CC;
    int field_5D0;
    int field_5D4;
    int field_5D8;
    int field_5DC;
    int field_5E0;
    int field_5E4;
    int field_5E8;
    int field_5EC;
    int field_5F0;
    int field_5F4;
    int field_5F8;
    int field_5FC;
    int field_600;
    int field_604;
    int field_608;
    int field_60C;
    int field_610;
    int field_614;
    int field_618;
    int field_61C;
    MapFarSysScroll *scroll1[2];
    int field_628;
    MapFarSysScroll *scroll2[2];
    int field_634;
    u16 field_638[2];
    int field_63C;
    int field_640;
    int field_644;
    int field_648;
    int field_64C;
    int field_650;
    int field_654;
    int field_658;
    int field_65C;
    int field_660;
    int field_664;
    int field_668;
    int field_66C;
    int field_670;
    int field_674;
    int field_678;
    int field_67C;
    int field_680;
    int field_684;
    int field_688;
    int field_68C;
    int field_690;
    int field_694;
    int field_698;
    int field_69C;
    int field_6A0;
    int field_6A4;
    int field_6A8;
    int field_6AC;
    int field_6B0;
    int field_6B4;
    int field_6B8;
    int field_6BC;
    int field_6C0;
    int field_6C4;
    int field_6C8;
    int field_6CC;
    int field_6D0;
    int field_6D4;
    int field_6D8;
    int field_6DC;
    int field_6E0;
    int field_6E4;
    int field_6E8;
    int field_6EC;
    int field_6F0;
    int field_6F4;
    int field_6F8;
    int field_6FC;
    int field_700;
    int field_704;
    int field_708;
    int field_70C;
    int field_710;
    int field_714;
    int field_718;
    int field_71C;
    int field_720;
    int field_724;
    int field_728;
    int field_72C;
    int field_730;
    int field_734;
    int field_738;
    int field_73C;
    int field_740;
    int field_744;
    int field_748;
    int field_74C;
    int field_750;
    int field_754;
    int field_758;
    int field_75C;
    int field_760;
    int field_764;
    int field_768;
    int field_76C;
    int field_770;
    int field_774;
    int field_778;
    int field_77C;
    int field_780;
    int field_784;
    int field_788;
    int field_78C;
    int field_790;
    int field_794;
    int field_798;
    int field_79C;
    int field_7A0;
    int field_7A4;
    int field_7A8;
    int field_7AC;
    int field_7B0;
    int field_7B4;
    int field_7B8;
    int field_7BC;
    int field_7C0;
    int field_7C4;
    int field_7C8;
    int field_7CC;
    int field_7D0;
    int field_7D4;
    int field_7D8;
    int field_7DC;
    int field_7E0;
    int field_7E4;
    int field_7E8;
    int field_7EC;
    int field_7F0;
    int field_7F4;
    int field_7F8;
    int field_7FC;
    int field_800;
    int field_804;
    int field_808;
    int field_80C;
    int field_810;
    int field_814;
    int field_818;
    int field_81C;
    int field_820;
    int field_824;
    int field_828;
    int field_82C;
    int field_830;
    int field_834;
    int field_838;
    int field_83C;
    int field_840;
    int field_844;
    int field_848;
    int field_84C;
    int field_850;
    int field_854;
    int field_858;
    int field_85C;
    int field_860;
    int field_864;
    int field_868;
    int field_86C;
    int field_870;
    int field_874;
    int field_878;
    int field_87C;
    int field_880;
    int field_884;
    int field_888;
    int field_88C;
    int field_890;
    int field_894;
    int field_898;
    int field_89C;
    int field_8A0;
    int field_8A4;
    int field_8A8;
    int field_8AC;
    int field_8B0;
    int field_8B4;
    int field_8B8;
    int field_8BC;
    int field_8C0;
    int field_8C4;
    int field_8C8;
    int field_8CC;
    int field_8D0;
    int field_8D4;
    int field_8D8;
    int field_8DC;
    int field_8E0;
    int field_8E4;
    int field_8E8;
    int field_8EC;
    int field_8F0;
    int field_8F4;
    int field_8F8;
    int field_8FC;
    int field_900;
    int field_904;
    int field_908;
    int field_90C;
    int field_910;
    int field_914;
    int field_918;
    int field_91C;
    int field_920;
    int field_924;
    int field_928;
    int field_92C;
    int field_930;
    int field_934;
    int field_938;
    int field_93C;
    int field_940;
    int field_944;
    int field_948;
    int field_94C;
    int field_950;
    int field_954;
    int field_958;
    int field_95C;
    int field_960;
    int field_964;
    int field_968;
    int field_96C;
    int field_970;
    int field_974;
    int field_978;
    int field_97C;
    int field_980;
    int field_984;
    int field_988;
    int field_98C;
    int field_990;
    int field_994;
    int field_998;
    int field_99C;
    int field_9A0;
    int field_9A4;
    int field_9A8;
    int field_9AC;
    int field_9B0;
    int field_9B4;
    int field_9B8;
    int field_9BC;
    int field_9C0;
    int field_9C4;
    int field_9C8;
    int field_9CC;
    int field_9D0;
    int field_9D4;
    int field_9D8;
    int field_9DC;
    int field_9E0;
    int field_9E4;
    int field_9E8;
    int field_9EC;
    int field_9F0;
    int field_9F4;
    int field_9F8;
    int field_9FC;
    int field_A00;
    int field_A04;
    int field_A08;
    int field_A0C;
    int field_A10;
    int field_A14;
    int field_A18;
    int field_A1C;
    int field_A20;
    int field_A24;
    int field_A28;
    int field_A2C;
    int field_A30;
    int field_A34;
    int field_A38;
    int field_A3C;
    int field_A40;
    int field_A44;
    int field_A48;
    int field_A4C;
    int field_A50;
    int field_A54;
    int field_A58;
    int field_A5C;
    int field_A60;
    int field_A64;
    int field_A68;
    int field_A6C;
    int field_A70;
    int field_A74;
    int field_A78;
    int field_A7C;
    int field_A80;
    int field_A84;
    int field_A88;
    int field_A8C;
    int field_A90;
    int field_A94;
    int field_A98;
    int field_A9C;
    int field_AA0;
    int field_AA4;
    int field_AA8;
    int field_AAC;
    int field_AB0;
    int field_AB4;
    int field_AB8;
    int field_ABC;
    int field_AC0;
    int field_AC4;
    int field_AC8;
    int field_ACC;
    int field_AD0;
    int field_AD4;
    int field_AD8;
    int field_ADC;
    int field_AE0;
    int field_AE4;
    int field_AE8;
    int field_AEC;
    int field_AF0;
    int field_AF4;
    int field_AF8;
    int field_AFC;
    int field_B00;
    int field_B04;
    int field_B08;
    int field_B0C;
    int field_B10;
    int field_B14;
    int field_B18;
    int field_B1C;
    int field_B20;
    int field_B24;
    int field_B28;
    int field_B2C;
    int field_B30;
    int field_B34;
    int field_B38;
    int field_B3C;
    int field_B40;
    int field_B44;
    int field_B48;
    int field_B4C;
    int field_B50;
    int field_B54;
    int field_B58;
    int field_B5C;
    int field_B60;
    int field_B64;
    int field_B68;
    int field_B6C;
    int field_B70;
    int field_B74;
    int field_B78;
    int field_B7C;
    int field_B80;
    int field_B84;
    int field_B88;
    int field_B8C;
    int field_B90;
    int field_B94;
    int field_B98;
    int field_B9C;
    int field_BA0;
    int field_BA4;
    int field_BA8;
    int field_BAC;
    int field_BB0;
    int field_BB4;
    int field_BB8;
    int field_BBC;
    int field_BC0;
    int field_BC4;
    int field_BC8;
    int field_BCC;
    int field_BD0;
    int field_BD4;
    int field_BD8;
    int field_BDC;
    int field_BE0;
    int field_BE4;
    int field_BE8;
    int field_BEC;
    int field_BF0;
    int field_BF4;
    int field_BF8;
    int field_BFC;
    int field_C00;
    int field_C04;
    int field_C08;
    int field_C0C;
    int field_C10;
    int field_C14;
    int field_C18;
    int field_C1C;
    int field_C20;
    int field_C24;
    int field_C28;
    int field_C2C;
    int field_C30;
    int field_C34;
    int field_C38;
    int field_C3C;
    int field_C40;
    int field_C44;
    int field_C48;
    int field_C4C;
    int field_C50;
    int field_C54;
    int field_C58;
    int field_C5C;
    int field_C60;
    int field_C64;
    int field_C68;
    int field_C6C;
    int field_C70;
    int field_C74;
    int field_C78;
    int field_C7C;
    int field_C80;
    int field_C84;
    int field_C88;
    int field_C8C;
    int field_C90;
    int field_C94;
    int field_C98;
    int field_C9C;
    int field_CA0;
    int field_CA4;
    int field_CA8;
    int field_CAC;
    int field_CB0;
    int field_CB4;
    int field_CB8;
    int field_CBC;
    int field_CC0;
    int field_CC4;
    int field_CC8;
    int field_CCC;
    int field_CD0;
    int field_CD4;
    int field_CD8;
    int field_CDC;
    int field_CE0;
    int field_CE4;
    int field_CE8;
    int field_CEC;
    int field_CF0;
    int field_CF4;
    int field_CF8;
    int field_CFC;
    int field_D00;
    int field_D04;
    int field_D08;
    int field_D0C;
    int field_D10;
    int field_D14;
    int field_D18;
    int field_D1C;
    int field_D20;
    int field_D24;
    int field_D28;
    int field_D2C;
    int field_D30;
    int field_D34;
    int field_D38;
    int field_D3C;
    int field_D40;
    int field_D44;
    int field_D48;
    int field_D4C;
    int field_D50;
    int field_D54;
    int field_D58;
    int field_D5C;
    int field_D60;
    int field_D64;
    int field_D68;
    int field_D6C;
    int field_D70;
    int field_D74;
    int field_D78;
    int field_D7C;
    int field_D80;
    int field_D84;
    int field_D88;
    int field_D8C;
    int field_D90;
    int field_D94;
    int field_D98;
    int field_D9C;
    int field_DA0;
    int field_DA4;
    int field_DA8;
    int field_DAC;
    int field_DB0;
    int field_DB4;
    int field_DB8;
    int field_DBC;
    int field_DC0;
    int field_DC4;
    int field_DC8;
    int field_DCC;
    int field_DD0;
    int field_DD4;
    int field_DD8;
    int field_DDC;
    int field_DE0;
    int field_DE4;
    int field_DE8;
    int field_DEC;
    int field_DF0;
    int field_DF4;
    int field_DF8;
    int field_DFC;
    int field_E00;
    int field_E04;
    int field_E08;
    int field_E0C;
    int field_E10;
    int field_E14;
    int field_E18;
    int field_E1C;
    int field_E20;
    int field_E24;
    int field_E28;
    int field_E2C;
    int field_E30;
    int field_E34;
    int field_E38;
    int field_E3C;
    int field_E40;
    int field_E44;
    int field_E48;
    int field_E4C;
    int field_E50;
    int field_E54;
    int field_E58;
    int field_E5C;
    int field_E60;
    int field_E64;
    int field_E68;
    int field_E6C;
    int field_E70;
    int field_E74;
    int field_E78;
    int field_E7C;
    int field_E80;
    int field_E84;
    int field_E88;
    int field_E8C;
    int field_E90;
    int field_E94;
    int field_E98;
    int field_E9C;
    int field_EA0;
    int field_EA4;
    int field_EA8;
    int field_EAC;
    int field_EB0;
    int field_EB4;
    int field_EB8;
    int field_EBC;
    int field_EC0;
    int field_EC4;
    int field_EC8;
    int field_ECC;
    int field_ED0;
    int field_ED4;
    int field_ED8;
    int field_EDC;
    int field_EE0;
    int field_EE4;
    int field_EE8;
    int field_EEC;
    int field_EF0;
    int field_EF4;
    int field_EF8;
    int field_EFC;
    int field_F00;
    int field_F04;
    int field_F08;
    int field_F0C;
    int field_F10;
    int field_F14;
    int field_F18;
    int field_F1C;
    int field_F20;
    int field_F24;
    int field_F28;
    int field_F2C;
    int field_F30;
    int field_F34;
    int field_F38;
    int field_F3C;
    int field_F40;
    int field_F44;
    int field_F48;
    int field_F4C;
    int field_F50;
    int field_F54;
    int field_F58;
    int field_F5C;
    int field_F60;
    int field_F64;
    int field_F68;
    int field_F6C;
    int field_F70;
    int field_F74;
    int field_F78;
    int field_F7C;
    int field_F80;
    int field_F84;
    int field_F88;
    int field_F8C;
    int field_F90;
    int field_F94;
    int field_F98;
    int field_F9C;
    int field_FA0;
    int field_FA4;
    int field_FA8;
    int field_FAC;
    int field_FB0;
    int field_FB4;
    int field_FB8;
    int field_FBC;
    int field_FC0;
    int field_FC4;
    int field_FC8;
    int field_FCC;
    int field_FD0;
    int field_FD4;
    int field_FD8;
    int field_FDC;
    int field_FE0;
    int field_FE4;
    int field_FE8;
    int field_FEC;
    int field_FF0;
    int field_FF4;
    int field_FF8;
    int field_FFC;
    int field_1000;
    int field_1004;
    int field_1008;
    int field_100C;
    int field_1010;
    int field_1014;
    int field_1018;
    int field_101C;
    int field_1020;
    int field_1024;
    int field_1028;
    int field_102C;
    int field_1030;
    int field_1034;
    int field_1038;
    int field_103C;
    int field_1040;
    int field_1044;
    int field_1048;
    int field_104C;
    int field_1050;
    int field_1054;
    int field_1058;
    int field_105C;
    int field_1060;
    int field_1064;
    int field_1068;
    int field_106C;
    int field_1070;
    int field_1074;
    int field_1078;
    int field_107C;
    int field_1080;
    int field_1084;
    int field_1088;
    int field_108C;
    int field_1090;
    int field_1094;
    int field_1098;
    int field_109C;
    int field_10A0;
    int field_10A4;
    int field_10A8;
    int field_10AC;
    int field_10B0;
    int field_10B4;
    int field_10B8;
    int field_10BC;
    int field_10C0;
    int field_10C4;
    int field_10C8;
    int field_10CC;
    int field_10D0;
    int field_10D4;
    int field_10D8;
    int field_10DC;
    int field_10E0;
    int field_10E4;
    int field_10E8;
    int field_10EC;
    int field_10F0;
    int field_10F4;
    int field_10F8;
    int field_10FC;
    int field_1100;
    int field_1104;
    int field_1108;
    int field_110C;
    int field_1110;
    int field_1114;
    int field_1118;
    int field_111C;
    int field_1120;
    int field_1124;
    int field_1128;
    int field_112C;
    int field_1130;
    int field_1134;
    int field_1138;
    int field_113C;
    int field_1140;
    int field_1144;
    int field_1148;
    int field_114C;
    int field_1150;
    int field_1154;
    int field_1158;
    int field_115C;
    int field_1160;
    int field_1164;
    int field_1168;
    int field_116C;
    int field_1170;
    int field_1174;
    int field_1178;
    int field_117C;
    int field_1180;
    int field_1184;
    int field_1188;
    int field_118C;
    int field_1190;
    int field_1194;
    int field_1198;
    int field_119C;
    int field_11A0;
    int field_11A4;
    int field_11A8;
    int field_11AC;
    int field_11B0;
    int field_11B4;
    int field_11B8;
    int field_11BC;
    int field_11C0;
    int field_11C4;
    int field_11C8;
    int field_11CC;
    int field_11D0;
    int field_11D4;
    int field_11D8;
    int field_11DC;
    int field_11E0;
    int field_11E4;
    int field_11E8;
    int field_11EC;
    int field_11F0;
    int field_11F4;
    int field_11F8;
    int field_11FC;
    int field_1200;
    int field_1204;
    int field_1208;
    int field_120C;
    int field_1210;
    int field_1214;
    int field_1218;
    int field_121C;
    int field_1220;
    int field_1224;
    int field_1228;
    int field_122C;
    int field_1230;
    int field_1234;
    int field_1238;
    int field_123C;
};

struct MapFarSysStaticVars
{
    void *asset;
    s32 bbgTileCount;
    struct MapFarSysUnknown *scrollControl;
    u32 flags;
};

// --------------------
// VARIABLES
// --------------------

static struct MapFarSysStaticVars MapFarSys__sVars;

NOT_DECOMPILED const void *_0210E074;
NOT_DECOMPILED const void *_0210E07A;
NOT_DECOMPILED const void *_0210E080;
NOT_DECOMPILED const void *_0210E086;
NOT_DECOMPILED const void *_0210E08C;
NOT_DECOMPILED const void *_0210E092;
NOT_DECOMPILED const void *_0210E094;
NOT_DECOMPILED const void *_0210E0A4;
NOT_DECOMPILED const void *_0210E0B4;
NOT_DECOMPILED const void *_0210E0B6;
NOT_DECOMPILED const void *_0210E0C6;
NOT_DECOMPILED const void *_0210E0C8;
NOT_DECOMPILED const void *_0210E0D8;
NOT_DECOMPILED const void *_0210E0F0;
NOT_DECOMPILED const void *_0210E108;
NOT_DECOMPILED const void *_0210E120;
NOT_DECOMPILED const void *_0210E130;
NOT_DECOMPILED const void *_0210E140;
NOT_DECOMPILED const void *_0210E160;
NOT_DECOMPILED const void *_0210E184;
NOT_DECOMPILED const void *_0210E1AC;
NOT_DECOMPILED const void *_0210E1D4;
NOT_DECOMPILED const void *_0210E23C;
NOT_DECOMPILED const void *_0210E2A4;
NOT_DECOMPILED const void *_0210E30C;

static MapFarSysProcessFunc MapFarSys__ProcessTable[STAGE_COUNT] = {
    [STAGE_Z11]               = MapFarSys__Process_Z1,
    [STAGE_Z12]               = MapFarSys__Process_Z1,
    [STAGE_TUTORIAL]          = MapFarSys__Process_Z1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = MapFarSys__Process_Z2,
    [STAGE_Z22]               = MapFarSys__Process_Z2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = MapFarSys__Process_Z3,
    [STAGE_Z32]               = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_1]   = MapFarSys__Process_Z9,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = MapFarSys__Process_Z4,
    [STAGE_Z42]               = MapFarSys__Process_Z4,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = MapFarSys__Process_Z5,
    [STAGE_Z52]               = MapFarSys__Process_Z5,
    [STAGE_Z5B]               = MapFarSys__Process_Z9,
    [STAGE_Z61]               = MapFarSys__Process_Z6,
    [STAGE_Z62]               = MapFarSys__Process_Z6,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = MapFarSys__Process_Z7,
    [STAGE_Z72]               = MapFarSys__Process_Z7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_4]   = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_5]   = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_6]   = MapFarSys__Process_Z1,
    [STAGE_HIDDEN_ISLAND_7]   = MapFarSys__Process_Z1,
    [STAGE_HIDDEN_ISLAND_8]   = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_9]   = MapFarSys__Process_Z2,
    [STAGE_HIDDEN_ISLAND_10]  = MapFarSys__Process_Z2,
    [STAGE_HIDDEN_ISLAND_11]  = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_12]  = MapFarSys__Process_Z5,
    [STAGE_HIDDEN_ISLAND_13]  = MapFarSys__Process_Z5,
    [STAGE_HIDDEN_ISLAND_14]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_15]  = MapFarSys__Process_Z4,
    [STAGE_HIDDEN_ISLAND_16]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_VS1] = MapFarSys__Process_Z1,
    [STAGE_HIDDEN_ISLAND_VS2] = MapFarSys__Process_Z2,
    [STAGE_HIDDEN_ISLAND_VS3] = MapFarSys__Process_Z3,
    [STAGE_HIDDEN_ISLAND_VS4] = MapFarSys__Process_Z4,
    [STAGE_HIDDEN_ISLAND_R1]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_R2]  = MapFarSys__Process_Z9,
    [STAGE_HIDDEN_ISLAND_R3]  = MapFarSys__Process_Z9,
};

static MapFarSysInitFunc MapFarSys__BuildTable[STAGE_COUNT] = {
    [STAGE_Z11]               = MapFarSys__Build_Z1,
    [STAGE_Z12]               = MapFarSys__Build_Z1,
    [STAGE_TUTORIAL]          = MapFarSys__Build_Z1,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = MapFarSys__Build_Z2,
    [STAGE_Z22]               = MapFarSys__Build_Z2,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = MapFarSys__Build_Z3,
    [STAGE_Z32]               = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_1]   = MapFarSys__Build_Z9,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = MapFarSys__Build_Z4,
    [STAGE_Z42]               = MapFarSys__Build_Z4,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = MapFarSys__Build_Z5,
    [STAGE_Z52]               = MapFarSys__Build_Z5,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = MapFarSys__Build_Z6,
    [STAGE_Z62]               = MapFarSys__Build_Z6,
    [STAGE_HIDDEN_ISLAND_2]   = MapFarSys__Build_Z9,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = MapFarSys__Build_Z7,
    [STAGE_Z72]               = MapFarSys__Build_Z7,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_4]   = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_5]   = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_6]   = MapFarSys__Build_Z1,
    [STAGE_HIDDEN_ISLAND_7]   = MapFarSys__Build_Z1,
    [STAGE_HIDDEN_ISLAND_8]   = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_9]   = MapFarSys__Build_Z2,
    [STAGE_HIDDEN_ISLAND_10]  = MapFarSys__Build_Z2,
    [STAGE_HIDDEN_ISLAND_11]  = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_12]  = MapFarSys__Build_Z5,
    [STAGE_HIDDEN_ISLAND_13]  = MapFarSys__Build_Z5,
    [STAGE_HIDDEN_ISLAND_14]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_15]  = MapFarSys__Build_Z4,
    [STAGE_HIDDEN_ISLAND_16]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_VS1] = MapFarSys__Build_Z1,
    [STAGE_HIDDEN_ISLAND_VS2] = MapFarSys__Build_Z2,
    [STAGE_HIDDEN_ISLAND_VS3] = MapFarSys__Build_Z3,
    [STAGE_HIDDEN_ISLAND_VS4] = MapFarSys__Build_Z4,
    [STAGE_HIDDEN_ISLAND_R1]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_R2]  = MapFarSys__Build_Z9,
    [STAGE_HIDDEN_ISLAND_R3]  = MapFarSys__Build_Z9,
};

static MapFarSysReleaseFunc MapFarSys__ReleaseTable[STAGE_COUNT] = {
    [STAGE_Z11]               = NULL,
    [STAGE_Z12]               = NULL,
    [STAGE_TUTORIAL]          = NULL,
    [STAGE_Z1B]               = NULL,
    [STAGE_Z21]               = NULL,
    [STAGE_Z22]               = NULL,
    [STAGE_Z2B]               = NULL,
    [STAGE_Z31]               = NULL,
    [STAGE_Z32]               = NULL,
    [STAGE_HIDDEN_ISLAND_1]   = NULL,
    [STAGE_Z3B]               = NULL,
    [STAGE_Z41]               = NULL,
    [STAGE_Z42]               = NULL,
    [STAGE_Z4B]               = NULL,
    [STAGE_Z51]               = NULL,
    [STAGE_Z52]               = NULL,
    [STAGE_Z5B]               = NULL,
    [STAGE_Z61]               = NULL,
    [STAGE_Z62]               = NULL,
    [STAGE_HIDDEN_ISLAND_2]   = NULL,
    [STAGE_Z6B]               = NULL,
    [STAGE_Z71]               = NULL,
    [STAGE_Z72]               = NULL,
    [STAGE_Z7B]               = NULL,
    [STAGE_BOSS_FINAL]        = NULL,
    [STAGE_HIDDEN_ISLAND_3]   = NULL,
    [STAGE_HIDDEN_ISLAND_4]   = NULL,
    [STAGE_HIDDEN_ISLAND_5]   = NULL,
    [STAGE_HIDDEN_ISLAND_6]   = NULL,
    [STAGE_HIDDEN_ISLAND_7]   = NULL,
    [STAGE_HIDDEN_ISLAND_8]   = NULL,
    [STAGE_HIDDEN_ISLAND_9]   = NULL,
    [STAGE_HIDDEN_ISLAND_10]  = NULL,
    [STAGE_HIDDEN_ISLAND_11]  = NULL,
    [STAGE_HIDDEN_ISLAND_12]  = NULL,
    [STAGE_HIDDEN_ISLAND_13]  = NULL,
    [STAGE_HIDDEN_ISLAND_14]  = NULL,
    [STAGE_HIDDEN_ISLAND_15]  = NULL,
    [STAGE_HIDDEN_ISLAND_16]  = NULL,
    [STAGE_HIDDEN_ISLAND_VS1] = NULL,
    [STAGE_HIDDEN_ISLAND_VS2] = NULL,
    [STAGE_HIDDEN_ISLAND_VS3] = NULL,
    [STAGE_HIDDEN_ISLAND_VS4] = NULL,
    [STAGE_HIDDEN_ISLAND_R1]  = NULL,
    [STAGE_HIDDEN_ISLAND_R2]  = NULL,
    [STAGE_HIDDEN_ISLAND_R3]  = NULL,
};

// --------------------
// FUNCTIONS
// --------------------

// MapFarSys
void MapFarSys__SetAsset(void *asset)
{
    MapFarSys__sVars.asset = asset;
}

void *MapFarSys__GetAsset(void)
{
    return MapFarSys__sVars.asset;
}

void MapFarSys__Release(void)
{
    if (MapFarSys__sVars.asset != NULL)
    {
        HeapFree(HEAP_USER, MapFarSys__sVars.asset);
        MapFarSys__sVars.asset = NULL;
    }
}

void MapFarSys__Build(void)
{
    void *background = MapFarSys__GetAsset();

    MapFarSys__sVars.flags &= ~3;

    if (background != NULL && !IsBossStage())
    {
        MI_CpuClear32(VRAM_BG + 0x8000, 0x8000);
        MI_CpuClear32(VRAM_DB_BG + 0x8000, 0x8000);
        MI_CpuClear32(VRAM_BG + 0x4000, 0x2000);
        MI_CpuClear32(VRAM_DB_BG + 0x4000, 0x2000);

        MapFarSys__Func_200B578(background);

        MapFarSys__sVars.flags |= 1;

        ((u16 *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
        ((u16 *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

        if (GetBackgroundFormat(background) == BBG_FORMAT_0)
            MapFarSys__sVars.flags |= 2;
    }
}

void MapFarSys__BuildBG(void)
{
    u16 stageID = gameState.stageID;

    if (MapFarSys__BuildTable[stageID] != NULL)
    {
        MapFarSys__sVars.scrollControl = HeapAllocHead(HEAP_USER, sizeof(*MapFarSys__sVars.scrollControl));
        MI_CpuClear16(MapFarSys__sVars.scrollControl, sizeof(*MapFarSys__sVars.scrollControl));

        MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = 512;

        MapFarSys__BuildTable[stageID]();
    }

    MapFarSys__Func_200B718();
}

void MapFarSys__ReleaseBG(void)
{
    u16 stageID = gameState.stageID;

    RenderCore_StopDMA(0);
    RenderCore_StopDMA(1);

    if (MapFarSys__ReleaseTable[stageID] != NULL)
        MapFarSys__ReleaseTable[stageID]();

    if (MapFarSys__sVars.scrollControl != NULL)
    {
        if (MapFarSys__sVars.scrollControl->task != NULL)
            DestroyTask(MapFarSys__sVars.scrollControl->task);

        HeapFree(HEAP_USER, MapFarSys__sVars.scrollControl);
        MapFarSys__sVars.scrollControl = NULL;
    }
}

NONMATCH_FUNC void MapFarSys__ProcessBG(void)
{
    // https://decomp.me/scratch/erTDB -> 85.83%
#ifdef NON_MATCHING
    u16 stageID = gameState.stageID;

    if ((MapFarSys__sVars.flags & 1) != 0)
    {
        if (MapFarSys__ProcessTable[stageID] != NULL)
            MapFarSys__ProcessTable[stageID]();

        for (u32 c = 0; c <= 1; c++)
        {
            MapSysCamera *camera = &mapCamera.camera[c];

            VRAMSystem__GFXControl[c]->bgPosition[BACKGROUND_1].x = (0x1FF & FX32_TO_WHOLE(camera->bgPos.x));
            VRAMSystem__GFXControl[c]->bgPosition[BACKGROUND_1].y = (u8)(0x1FF & FX32_TO_WHOLE(camera->bgPos.y));
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, =MapFarSys__sVars
	ldr r1, =gameState
	ldr r0, [r0, #0xc]
	ldrh r1, [r1, #0x28]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, =MapFarSys__ProcessTable
	ldr r0, [r0, r1, lsl #2]
	cmp r0, #0
	beq _0200B470
	blx r0
_0200B470:
	ldr r4, =mapCamera
	ldr lr, =VRAMSystem__GFXControl
	ldr r1, =0x000001FF
	mov r5, #0
	mov r0, #0x70
_0200B484:
	mla r3, r5, r0, r4
	ldr r2, [r3, #0x38]
	ldr ip, [lr, r5, lsl #2]
	and r2, r1, r2, asr #12
	strh r2, [ip, #4]
	ldr r3, [r3, #0x3c]
	add r2, r5, #1
	and r3, r1, r3, asr #12
	and r5, r2, #0xff
	strh r3, [ip, #6]
	cmp r5, #1
	bls _0200B484
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void MapFarSys__SetScrollSpeed(s32 id, fx32 x1, fx32 x2)
{
    if (MapFarSys__sVars.scrollControl != NULL)
    {
        MapFarSys__sVars.scrollControl->scrollSpeed[id].x = x1;
        MapFarSys__sVars.scrollControl->scrollSpeed[id].y = x2;
    }
}

void MapFarSys__AdvanceScrollSpeed(s32 id, fx32 move)
{
    if (MapFarSys__sVars.scrollControl != NULL)
        MapFarSys__sVars.scrollControl->scrollSpeed[id].x += move;
}

void MapFarSys__Func_200B524(s32 a1, s32 a2, s32 a3, s8 id)
{
    if (MapFarSys__sVars.scrollControl != NULL && id >= 0 && id < 2)
    {
        if (a3 != MapFarSys__sVars.scrollControl->field_638[id])
        {
            MapFarSys__sVars.scrollControl->field_638[id] = a3;
            MapFarSys__sVars.scrollControl->flags |= 1 << id;
        }
    }
}

NONMATCH_FUNC void MapFarSys__Func_200B578(void *bgFile)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x48
	ldr r5, =_0210E120
	add r4, sp, #0x28
	mov r10, r0
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	mov r0, r10
	bl GetBackgroundFormat
	str r0, [sp, #0x20]
	mov r0, r10
	bl GetBackgroundWidth
	str r0, [sp, #0x24]
	mov r0, r10
	bl GetBackgroundHeight
	mov r6, r0
	mov r5, #0
_0200B5C4:
	mov r0, r10
	bl GetBackgroundPixels
	add r1, sp, #0x28
	ldr r1, [r1, r5, lsl #4]
	bl RenderCore_CPUCopyCompressed
	mov r0, r10
	bl GetBackgroundTileCount
	ldr r1, =MapFarSys__sVars
	str r0, [r1, #4]
	mov r0, r10
	bl GetBackgroundPalette
	ldr r1, [sp, #0x20]
	cmp r1, #0
	beq _0200B608
	cmp r1, #1
	beq _0200B620
	b _0200B634
_0200B608:
	add r2, sp, #0x28
	add r2, r2, r5, lsl #4
	ldr r2, [r2, #4]
	mov r1, #0
	bl LoadCompressedPalette
	b _0200B634
_0200B620:
	add r1, sp, #0x28
	add r1, r1, r5, lsl #4
	ldr r1, [r1, #8]
	mov r2, #0x6200
	bl LoadCompressedPalette
_0200B634:
	mov r0, r10
	bl GetBackgroundMappings
	mov r9, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0x40
	bne _0200B698
	mov r0, r10
	bl GetBackgroundFlag
	add r1, sp, #0x28
	str r0, [sp]
	add r0, r1, r5, lsl #4
	mov r1, #0
	ldr r0, [r0, #0xc]
	mov r3, #0x40
	stmib sp, {r0, r1}
	mov r0, #8
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, r9
	mov r2, r1
	str r6, [sp, #0x1c]
	bl Mappings__ReadMappings
	b _0200B6FC
_0200B698:
	add r0, sp, #0x28
	add r0, r0, r5, lsl #4
	ldr r8, [r0, #0xc]
	mov r7, #0
	mov r4, #8
	mov r11, #0x20
_0200B6B0:
	mov r0, r10
	bl GetBackgroundFlag
	stmia sp, {r0, r8}
	mov r0, #0
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r7, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r1, #0
	str r11, [sp, #0x18]
	mov r0, r9
	mov r2, r1
	mov r3, r11
	str r6, [sp, #0x1c]
	bl Mappings__ReadMappings
	add r0, r7, #0x20
	and r7, r0, #0xff
	cmp r7, #0x40
	blo _0200B6B0
_0200B6FC:
	add r5, r5, #1
	cmp r5, #2
	blt _0200B5C4
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void MapFarSys__Func_200B718(void)
{
    if ((MapFarSys__sVars.flags & 1) != 0)
    {
        mapCamera.camera[0].flags |= MAPSYS_CAMERA_FLAG_4;
        mapCamera.camera[1].flags |= MAPSYS_CAMERA_FLAG_4;
    }
    else
    {
        mapCamera.camera[0].flags &= ~MAPSYS_CAMERA_FLAG_4;
        mapCamera.camera[1].flags &= ~MAPSYS_CAMERA_FLAG_4;

        return;
    }

    if ((MapFarSys__sVars.flags & 2) != 0)
    {
        G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
        G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
    }
    else
    {
        G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
        G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
    }
}

NONMATCH_FUNC void MapFarSys__Build_Z1(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200B81C
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200B834
_0200B81C:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200B834:
	ldr r1, =MapFarSys__sVars
	mov r3, #0x200
	ldr r2, [r1, #8]
	ldr r0, =gameState
	str r3, [r2, #0xc]
	ldr r2, [r1, #8]
	ldr r1, [r2, #0xc]
	str r1, [r2, #8]
	ldrh r0, [r0, #0x28]
	cmp r0, #0
	cmpne r0, #2
	ldmneia sp!, {r3, pc}
	ldr r0, =MapFarSys__sVars
	ldr r3, =0x04000016
	ldr r0, [r0, #8]
	mov ip, #2
	add r1, r0, #0x20
	add r2, r0, #0x320
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, =MapFarSys__sVars
	ldr r3, =0x04001016
	ldr r0, [r0, #8]
	mov ip, #2
	add r1, r0, #0x1a0
	add r2, r0, #0x4a0
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, =gameState
	ldrh r1, [r0, #0x28]
	cmp r1, #0
	bne _0200B904
	ldr r0, [r0, #0x10]
	and r0, r0, #0x420
	cmp r0, #0x420
	bne _0200B8E8
	ldr r0, =MapFarSys__sVars
	ldr r2, =_0210E23C
	ldr r1, [r0, #8]
	str r2, [r1, #0x620]
	ldr r0, [r0, #8]
	str r2, [r0, #0x62c]
	ldmia sp!, {r3, pc}
_0200B8E8:
	ldr r0, =MapFarSys__sVars
	ldr r2, =_0210E1D4
	ldr r1, [r0, #8]
	str r2, [r1, #0x620]
	ldr r0, [r0, #8]
	str r2, [r0, #0x62c]
	ldmia sp!, {r3, pc}
_0200B904:
	ldr r0, =MapFarSys__sVars
	ldr r3, =_0210E30C
	ldr r1, [r0, #8]
	mov r2, #0x1d0
	str r3, [r1, #0x620]
	ldr r1, [r0, #8]
	str r3, [r1, #0x62c]
	ldr r1, [r0, #8]
	str r2, [r1, #0xc]
	ldr r1, [r0, #8]
	ldr r0, [r1, #0xc]
	str r0, [r1, #8]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Build_Z2(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200B998
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200B9B0
_0200B998:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200B9B0:
	ldr r1, =MapFarSys__sVars
	mov r2, #0x1d0
	ldr r0, [r1, #8]
	ldr r3, =0x04000016
	str r2, [r0, #0xc]
	ldr lr, [r1, #8]
	mov ip, #2
	ldr r2, [lr, #0xc]
	mov r0, #0
	str r2, [lr, #8]
	ldr r2, [r1, #8]
	add r1, r2, #0x20
	add r2, r2, #0x320
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, =MapFarSys__sVars
	ldr r3, =0x04001016
	ldr r0, [r0, #8]
	mov ip, #2
	add r1, r0, #0x1a0
	add r2, r0, #0x4a0
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	ldr r0, =MapFarSys__sVars
	ldr r2, =_0210E160
	ldr r1, [r0, #8]
	str r2, [r1, #0x620]
	ldr r0, [r0, #8]
	str r2, [r0, #0x62c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Build_Z3(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BA84
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BA9C
_0200BA84:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BA9C:
	ldr r1, =MapFarSys__sVars
	mov ip, #0x200
	ldr r0, [r1, #8]
	ldr r2, =0x00000C04
	str ip, [r0, #8]
	ldr r3, [r1, #8]
	mov r0, #0
	str ip, [r3, #0xc]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	add r0, r4, #0x204
	mov ip, #4
	ldr r3, =0x04000014
	add r1, r4, #4
	add r2, r0, #0x400
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x104
	mov ip, #4
	ldr r3, =0x04001014
	add r1, r4, #0x304
	add r2, r0, #0x800
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Build_Z4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BB70
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BB88
_0200BB70:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BB88:
	ldr r1, =MapFarSys__sVars
	mov ip, #0x200
	ldr r0, [r1, #8]
	ldr r2, =0x00000604
	str ip, [r0, #8]
	ldr r3, [r1, #8]
	mov r0, #0
	str ip, [r3, #0xc]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	mov ip, #2
	ldr r3, =0x04000014
	add r1, r4, #4
	add r2, r4, #0x304
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x84
	mov ip, #2
	ldr r3, =0x04001014
	add r1, r4, #0x184
	add r2, r0, #0x400
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

void MapFarSys__Build_Z5(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapSysCamera *cameraA = MapSys__GetCameraA();
        cameraA->bgPos.x             = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y             = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = MapSys__GetCameraB();
        cameraB->bgPos.x             = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y             = FLOAT_TO_FX32(BOTTOM_SCREEN_CAMERA_OFFSET);
    }
    else
    {
        MapSysCamera *cameraA = &mapCamera.camera[0];
        cameraA->bgPos.x             = FLOAT_TO_FX32(0.0);
        cameraA->bgPos.y             = FLOAT_TO_FX32(0.0);

        MapSysCamera *cameraB = &mapCamera.camera[1];
        cameraB->bgPos.x             = FLOAT_TO_FX32(0.0);
        cameraB->bgPos.y             = FLOAT_TO_FX32(0.0);
    }

    MapFarSys__sVars.scrollControl->scrollSpeedY[0] = MapFarSys__sVars.scrollControl->scrollSpeedY[1] = FLOAT_TO_FX32(0.125);
}

NONMATCH_FUNC void MapFarSys__Build_Z6(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BCD8
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BCF0
_0200BCD8:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BCF0:
	ldr r1, =MapFarSys__sVars
	mov r3, #0x200
	ldr r0, [r1, #8]
	ldr r2, =0x00000604
	str r3, [r0, #0xc]
	ldr ip, [r1, #8]
	mov r0, #0
	ldr r3, [ip, #0xc]
	str r3, [ip, #8]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	mov ip, #2
	ldr r3, =0x04000014
	add r1, r4, #4
	add r2, r4, #0x304
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x84
	mov ip, #2
	ldr r3, =0x04001014
	add r1, r4, #0x184
	add r2, r0, #0x400
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Build_Z7(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BDC4
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BDDC
_0200BDC4:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BDDC:
	ldr r1, =MapFarSys__sVars
	mov r3, #0x1d0
	ldr r0, [r1, #8]
	ldr r2, =0x00000C04
	str r3, [r0, #0xc]
	ldr ip, [r1, #8]
	mov r0, #0
	ldr r3, [ip, #0xc]
	str r3, [ip, #8]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	add r0, r4, #0x204
	mov ip, #4
	ldr r3, =0x04000014
	add r1, r4, #4
	add r2, r0, #0x400
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x104
	mov ip, #4
	ldr r3, =0x04001014
	add r1, r4, #0x304
	add r2, r0, #0x800
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Build_Z9(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr r0, =mapCamera
	ldr r1, [r0, #0xe0]
	tst r1, #1
	beq _0200BEB4
	bl MapSys__GetCameraA
	mov r1, #0
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	bl MapSys__GetCameraB
	mov r1, #0
	str r1, [r0, #0x38]
	mov r1, #0x110000
	str r1, [r0, #0x3c]
	b _0200BECC
_0200BEB4:
	mov r2, #0
	str r2, [r0, #0x38]
	ldr r1, =mapCamera+0x00000070
	str r2, [r0, #0x3c]
	str r2, [r1, #0x38]
	str r2, [r1, #0x3c]
_0200BECC:
	ldr r1, =MapFarSys__sVars
	mov r3, #0x200
	ldr r0, [r1, #8]
	ldr r2, =0x00000604
	str r3, [r0, #0xc]
	ldr ip, [r1, #8]
	mov r0, #0
	ldr r3, [ip, #0xc]
	str r3, [ip, #8]
	ldr r1, [r1, #8]
	add r1, r1, #0x23c
	add r4, r1, #0x400
	mov r1, r4
	bl MIi_CpuClear32
	mov ip, #2
	ldr r3, =0x04000014
	add r1, r4, #4
	add r2, r4, #0x304
	mov r0, #0
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add r0, r4, #0x84
	mov ip, #2
	ldr r3, =0x04001014
	add r1, r4, #0x184
	add r2, r0, #0x400
	mov r0, #1
	str ip, [sp]
	bl RenderCore_PrepareDMA
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z1(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #0xe
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r2, =mapCamera
	ldr r0, [r0, #8]
	ldr ip, [r2, #0x38]
	ldr r3, [r0, #0x10]
	ldr r1, =gameState
	add r3, ip, r3
	str r3, [r2, #0x38]
	ldr ip, [r2, #0xa8]
	ldr r3, [r0, #0x18]
	add r3, ip, r3
	str r3, [r2, #0xa8]
	ldrh r1, [r1, #0x28]
	cmp r1, #0
	cmpne r1, #2
	ldmneia sp!, {r3, pc}
	cmp r1, #0
	bne _0200C0C8
	ldr r1, =mapCamera
	ldr r2, [r1, #0xe0]
	ldr r1, [r1, #4]
	tst r2, #1
	beq _0200C03C
	cmp r1, #0x600000
	blt _0200BFF0
	ldr r2, =_0210E2A4
	ldr r1, =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200BFF0:
	ldr r1, =gameState
	ldr r1, [r1, #0x10]
	and r1, r1, #0x420
	cmp r1, #0x420
	bne _0200C020
	ldr r2, =_0210E23C
	ldr r1, =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200C020:
	ldr r2, =_0210E1D4
	ldr r1, =MapFarSys__sVars
	str r2, [r0, #0x62c]
	ldr r1, [r1, #8]
	ldr r0, [r1, #0x62c]
	str r0, [r1, #0x620]
	b _0200C0C8
_0200C03C:
	cmp r1, #0x600000
	ldrge r1, =_0210E2A4
	strge r1, [r0, #0x620]
	bge _0200C06C
	ldr r1, =gameState
	ldr r1, [r1, #0x10]
	and r1, r1, #0x420
	cmp r1, #0x420
	ldreq r1, =_0210E23C
	streq r1, [r0, #0x620]
	ldrne r1, =_0210E1D4
	strne r1, [r0, #0x620]
_0200C06C:
	ldr r0, =mapCamera
	ldr r0, [r0, #0x74]
	cmp r0, #0x600000
	blt _0200C090
	ldr r0, =MapFarSys__sVars
	ldr r1, =_0210E2A4
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
	b _0200C0C8
_0200C090:
	ldr r0, =gameState
	ldr r0, [r0, #0x10]
	and r0, r0, #0x420
	cmp r0, #0x420
	bne _0200C0B8
	ldr r0, =MapFarSys__sVars
	ldr r1, =_0210E23C
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
	b _0200C0C8
_0200C0B8:
	ldr r0, =MapFarSys__sVars
	ldr r1, =_0210E1D4
	ldr r0, [r0, #8]
	str r1, [r0, #0x62c]
_0200C0C8:
	bl MapFarSys__ProcessScroll
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z2(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov lr, #0
	mov r0, #0x1d0
	ldr r1, =_0210E094
	ldr r3, =_0210E160
	ldr r6, =MapFarSys__sVars
	mov r4, lr
	mov r2, r0
	mov ip, #1
_0200C10C:
	ldr r7, [r6, #8]
	ldr r5, [r7, #0]
	tst r5, ip, lsl lr
	beq _0200C17C
	add r5, r7, lr, lsl #1
	add r5, r5, #0x600
	ldrh r5, [r5, #0x38]
	cmp r5, #0
	beq _0200C13C
	cmp r5, #1
	beq _0200C154
	b _0200C168
_0200C13C:
	add r5, r7, r4
	str r3, [r5, #0x620]
	ldr r5, [r6, #8]
	add r5, r5, lr, lsl #2
	str r2, [r5, #8]
	b _0200C168
_0200C154:
	add r5, r7, r4
	str r1, [r5, #0x620]
	ldr r5, [r6, #8]
	add r5, r5, lr, lsl #2
	str r0, [r5, #8]
_0200C168:
	ldr r8, [r6, #8]
	mvn r5, ip, lsl lr
	ldr r7, [r8, #0]
	and r5, r7, r5
	str r5, [r8]
_0200C17C:
	add lr, lr, #1
	cmp lr, #2
	add r4, r4, #0xc
	blt _0200C10C
	mov r0, #0xe
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	bl MapFarSys__ProcessScroll
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z3(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r0, =mapCamera
	ldr r1, =MapFarSys__sVars
	ldr r2, [r0, #0xe0]
	ldr r0, [r1, #8]
	tst r2, #1
	movne r10, #0x1d0
	mov r5, #0
	moveq r10, #0xc0
	str r0, [sp, #0x1c]
	cmp r5, #2
	bge _0200C474
	sub r0, r10, #0xe0
	str r0, [sp, #0x18]
_0200C1E8:
	ldr r0, =MapFarSys__sVars
	ldr r1, [r0, #8]
	and r0, r5, #0xff
	add r1, r1, r5, lsl #3
	ldr r7, [r1, #0x10]
	bl RenderCore_GetDMASrc
	mov r6, r0
	ldr r0, =mapCamera
	mov r1, #0x70
	mla r4, r5, r1, r0
	ldr r1, [r4, #8]
	ldr r0, [r0, #0xe0]
	ldrh r9, [r4, #0x6e]
	mov r8, r1, asr #0xc
	tst r0, #1
	beq _0200C234
	bl MapSys__GetCameraA
	cmp r4, r0
	subne r8, r8, #0x110
_0200C234:
	sub r8, r9, r8
	cmp r8, r10
	bge _0200C290
	ldr r0, =mapCamera+0x00000100
	ldrh r0, [r0, #0x2c]
	sub r0, r0, r10
	sub r1, r9, r0
	sub r0, r8, r1
	mov r0, r0, lsl #0xc
	sub r1, r10, r1
	bl FX_DivS32
	mov r1, #0
	mov r3, r0
	str r1, [sp]
	ldr r0, [sp, #0x18]
	add r1, r10, #0x30
	mov r2, #0x1000
	bl Unknown2051334__Func_2051534
	mov r9, r0
	sub r0, r9, r8
	cmp r0, #0x30
	addlt r9, r8, #0x30
	b _0200C294
_0200C290:
	add r9, r8, #0x30
_0200C294:
	bl MapSys__GetCameraA
	cmp r4, r0
	beq _0200C2B0
	ldr r0, =mapCamera
	ldr r0, [r0, #0xe0]
	tst r0, #1
	bne _0200C2B8
_0200C2B0:
	mov r11, #0
	b _0200C2BC
_0200C2B8:
	mov r11, #0x110
_0200C2BC:
	ldr r0, =mapCamera
	ldr r0, [r0, #0xe0]
	tst r0, #1
	beq _0200C2DC
	bl MapSys__GetCameraA
	cmp r0, r4
	subne r8, r8, #0x110
	subne r9, r9, #0x110
_0200C2DC:
	cmp r8, #0
	ble _0200C334
	ldr r1, [r4, #4]
	cmp r8, #0xc0
	add r1, r1, r7, lsl #4
	suble r0, r8, #1
	str r1, [sp]
	mov r1, #0x100
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r1, =_0210E140
	movgt r2, #0xbf
	movle r0, r0, lsl #0x10
	movle r2, r0, lsr #0x10
	rsb r0, r11, #0
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	str r1, [sp, #0xc]
	mov r0, r6
	mov r1, #0
	bl MapFarSys__Func_200D144
_0200C334:
	cmp r8, #0xc0
	bge _0200C39C
	cmp r9, #0
	ble _0200C39C
	ldr r3, [r4, #4]
	cmp r8, #0
	add r3, r3, r7, lsl #4
	str r3, [sp]
	mov r3, #0x100
	str r3, [sp, #4]
	mov r3, #0
	str r3, [sp, #8]
	ldr r3, =_0210E0A4
	movlt r1, #0
	movge r0, r8, lsl #0x10
	movge r1, r0, lsr #0x10
	cmp r9, #0xc0
	suble r0, r9, #1
	str r3, [sp, #0xc]
	mov r3, r8, lsl #0x10
	movgt r2, #0xbf
	movle r0, r0, lsl #0x10
	movle r2, r0, lsr #0x10
	mov r0, r6
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200C39C:
	cmp r9, #0xc0
	bge _0200C3EC
	ldr r2, [r4, #4]
	cmp r9, #0
	add r2, r2, r7, lsl #4
	str r2, [sp]
	mov r2, #0x100
	str r2, [sp, #4]
	mov r2, #0x200
	str r2, [sp, #8]
	ldr r2, =_0210E0D8
	mov r3, r9, lsl #0x10
	str r2, [sp, #0xc]
	movlt r1, #0
	movge r0, r9, lsl #0x10
	movge r1, r0, lsr #0x10
	mov r0, r6
	mov r2, #0xbf
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200C3EC:
	cmp r8, #0xc0
	bge _0200C460
	cmp r8, #0
	rsblt r0, r8, #0
	movlt r1, #0
	movge r0, r8, lsl #0x10
	movge r1, r0, lsr #0x10
	movge r0, #0
	mov r0, r0, lsl #4
	add r4, r0, #0x2000
	mov r2, #0
	stmia sp, {r2, r4}
	sub r0, r1, r9
	mov r2, #0x40
	str r2, [sp, #8]
	mov r2, #0x8000
	str r2, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	ldr r2, [sp, #0x1c]
	mov r3, r0, lsl #0xf
	ldr r4, [r2, #0x63c]
	mov r0, r6
	add r3, r3, r4, lsl #13
	str r3, [sp, #0x14]
	and r1, r1, #0xff
	mov r2, #0xbf
	mov r3, #0
	bl FontDMAControl__Func_20520B0
_0200C460:
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C1E8
_0200C474:
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp, #0x1c]
	str r1, [r0, #0x63c]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r0, =_0210E074
	ldr r1, =MapFarSys__sVars
	ldrh r9, [r0, #0x18]
	ldrh r8, [r0, #0x1a]
	ldrh r7, [r0, #0x1c]
	ldrh r6, [r0, #0x1e]
	ldrh r5, [r0, #0x10]
	ldrh r4, [r0, #0x12]
	ldrh r3, [r0, #0x14]
	ldrh r2, [r0, #0x16]
	ldr r1, [r1, #8]
	mov r0, #0xe
	strh r9, [sp, #0xc]
	strh r8, [sp, #0xe]
	strh r7, [sp, #0x10]
	strh r6, [sp, #0x12]
	strh r5, [sp, #4]
	strh r4, [sp, #6]
	strh r3, [sp, #8]
	strh r2, [sp, #0xa]
	str r1, [sp]
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r1, =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x14
_0200C54C:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	mov r0, r0, lsr #0x10
	strh r2, [r1, r4]
	cmp r0, #4
	blo _0200C54C
	mov r5, #0
	cmp r5, #2
	bge _0200C650
_0200C580:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0xc
_0200C5BC:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200C628
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200C618
	mov r1, r10, lsl #1
	add r0, sp, #0x14
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200C618:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200C628:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #4
	blo _0200C5BC
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C580
_0200C650:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void MapFarSys__Process_Z5(void)
{
    MapFarSys__DoFarScrollX(14);
    MapFarSys__DoFarScrollY();

    mapCamera.camera[0].bgPos.x += MapFarSys__sVars.scrollControl->scrollSpeed[0].x;
    mapCamera.camera[1].bgPos.x += MapFarSys__sVars.scrollControl->scrollSpeed[1].x;
}

NONMATCH_FUNC void MapFarSys__Process_Z6(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	ldr r0, =MapFarSys__sVars
	ldr r3, =_0210E0B4
	ldr r0, [r0, #8]
	add r5, sp, #0x16
	str r0, [sp]
	mov r2, #4
_0200C6E0:
	ldrh r1, [r3, #0]
	ldrh r0, [r3, #2]
	add r3, r3, #4
	strh r1, [r5]
	strh r0, [r5, #2]
	add r5, r5, #4
	subs r2, r2, #1
	bne _0200C6E0
	ldrh r0, [r3, #0]
	ldr r4, =_0210E0C6
	add r3, sp, #4
	strh r0, [r5]
	mov r2, #4
_0200C714:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0200C714
	ldrh r1, [r4, #0]
	mov r0, #0xe
	strh r1, [r3]
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r1, =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x28
_0200C788:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	cmp r0, #9
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	strh r2, [r1, r4]
	blt _0200C788
	mov r5, #0
	cmp r5, #2
	bge _0200C87C
_0200C7B4:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0x16
_0200C7F0:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200C85C
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200C84C
	mov r1, r10, lsl #1
	add r0, sp, #0x28
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200C84C:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200C85C:
	add r10, r10, #1
	cmp r10, #9
	blt _0200C7F0
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200C7B4
_0200C87C:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z7(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r0, =gameState
	ldr r1, =MapFarSys__sVars
	ldr r2, [r0, #0x10]
	ldr r0, [r1, #8]
	str r0, [sp, #0x2c]
	and r0, r2, #0x420
	cmp r0, #0x420
	bne _0200C8E4
	ldr r0, =_0210E1AC
	str r0, [sp, #0x28]
	ldr r0, =_0210E108
	str r0, [sp, #0x24]
	b _0200C8F4
_0200C8E4:
	ldr r0, =_0210E184
	str r0, [sp, #0x28]
	ldr r0, =_0210E0F0
	str r0, [sp, #0x24]
_0200C8F4:
	ldr r1, =mapCamera
	ldr r0, [r1, #0xe0]
	tst r0, #1
	beq _0200C91C
	bl MapSys__GetCameraA
	str r0, [sp, #0x38]
	bl MapSys__GetCameraA
	str r0, [sp, #0x3c]
	mov r7, #0x1d0
	b _0200C92C
_0200C91C:
	ldr r0, =mapCamera+0x00000070
	str r1, [sp, #0x38]
	str r0, [sp, #0x3c]
	mov r7, #0xc0
_0200C92C:
	mov r0, #0x1c
	bl MapFarSys__DoFarScrollX
	ldr r0, =MapFarSys__sVars
	ldr r10, =mapCamera
	ldr r3, [r0, #8]
	rsb r0, r7, #0x1e0
	ldr r2, [r10, #0x38]
	ldr r1, [r3, #0x10]
	str r0, [sp, #0x20]
	add r0, r2, r1
	str r0, [r10, #0x38]
	rsb r0, r7, #0x208
	ldr r2, [r10, #0xa8]
	ldr r1, [r3, #0x18]
	str r0, [sp, #0x1c]
	add r0, r2, r1
	mvn r4, #0xbf
	str r0, [r10, #0xa8]
	add r0, r4, #0xb8
	mov r5, #0
	str r0, [sp, #0x34]
	str r0, [sp, #0x30]
_0200C984:
	add r0, sp, #0x38
	ldr r0, [r0, r5, lsl #2]
	ldrh r9, [r10, #0x6e]
	str r0, [sp, #0x18]
	ldr r3, [r10, #8]
	ldr r0, [r0, #8]
	cmp r9, #0
	sub r8, r3, r0
	beq _0200C9BC
	ldr r2, =mapCamera+0x00000100
	sub r1, r9, #8
	ldrh r2, [r2, #0x2c]
	sub r2, r2, r1
	b _0200C9CC
_0200C9BC:
	ldr r1, =mapCamera+0x00000100
	ldr r9, =0x0000FFFF
	ldrh r1, [r1, #0x2c]
	mov r2, #0
_0200C9CC:
	mov ip, r9, lsl #0xc
	add r11, r0, r7, lsl #12
	sub r6, ip, #0x8000
	cmp r11, r6
	bgt _0200CA00
	ldr r0, [sp, #0x20]
	sub r1, r1, r7
	mul r0, r3, r0
	bl FX_DivS32
	add r0, r8, r0
	str r0, [r10, #0x3c]
	mov r6, #0xbf
	b _0200CAB4
_0200CA00:
	cmp r0, r1, lsl #12
	bge _0200CA58
	rsb r1, r1, r3, asr #12
	rsb r6, r1, #0
	cmp r6, #0
	ble _0200CA48
	sub r1, r9, #8
	sub r9, r1, r0, asr #12
	sub r0, r7, r9
	mov r0, r0, lsl #0x12
	mov r1, r7
	bl FX_DivS32
	mov r1, r9, lsl #0xc
	rsb r1, r1, #0x1e0000
	sub r0, r1, r0
	add r0, r8, r0
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA48:
	rsb r0, r6, #0
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA58:
	cmp r0, ip
	bge _0200CA78
	rsb r0, r1, r3, asr #12
	rsb r6, r0, #0
	rsb r0, r6, #0
	mov r0, r0, lsl #0xc
	str r0, [r10, #0x3c]
	b _0200CAB4
_0200CA78:
	sub r0, r0, r1, lsl #12
	ldr r1, [sp, #0x1c]
	sub r0, r0, #0x8000
	mul r0, r1, r0
	sub r1, r2, #8
	sub r1, r1, r7
	bl FX_DivS32
	add r0, r0, #0x8000
	add r0, r8, r0
	str r0, [r10, #0x3c]
	ldr r0, [sp, #0x18]
	ldr r0, [r0, #8]
	sub r0, r9, r0, asr #12
	sub r0, r0, #8
	sub r6, r0, r8, asr #12
_0200CAB4:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	mov r8, r0
	cmp r6, #0
	ble _0200CB14
	ldr r1, [r10, #0x38]
	cmp r6, #0xbf
	str r1, [sp]
	mov r1, #0x1000
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r1, [sp, #0x28]
	movgt r2, #0xbf
	str r1, [sp, #0xc]
	ldr r3, [r10, #0x3c]
	movle r0, r6, lsl #0x10
	rsb r3, r3, #0
	mov r3, r3, lsl #4
	movle r2, r0, lsr #0x10
	mov r0, r8
	mov r1, #0
	mov r3, r3, asr #0x10
	bl MapFarSys__Func_200D144
_0200CB14:
	cmp r6, #0xc0
	bge _0200CC48
	cmp r6, #0
	bgt _0200CB48
	ldr r0, [r10, #0x3c]
	add r2, r6, #8
	rsb r0, r0, #0
	mov r0, r0, lsl #4
	mov r9, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, #0
	mov r0, r0, asr #0x10
	b _0200CB5C
_0200CB48:
	mov r0, r6, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r9, r0, asr #0x10
	add r0, r1, #8
	and r0, r0, #0xff
_0200CB5C:
	cmp r0, #0
	movlt r0, #0
	blt _0200CB70
	cmp r0, #0xbf
	movgt r0, #0xbf
_0200CB70:
	ldr r2, [r10, #0x38]
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #1
	str r2, [sp]
	mov r2, #0x1000
	str r2, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	ldr r2, [sp, #0x24]
	mov r11, r0, asr #0x10
	str r2, [sp, #0xc]
	mov r0, r8
	mov r2, #0xbf
	mov r3, r9
	bl MapFarSys__Func_200D144
	ldr r0, [sp, #0x30]
	mov r2, #0x1800
	cmp r6, r0
	ldr r0, [sp, #0x2c]
	mov r3, #0x18000
	ldr r0, [r0, #0x63c]
	mov r6, r0, lsl #0xd
	bge _0200CC14
	ldr r0, [sp, #0x34]
	sub r1, r0, r9
	mul r3, r1, r4
	mov r0, r2
	add r2, r0, r1, lsl #6
	mov r0, #0x18000
	adds r3, r0, r3
	movmi r3, #0
	cmp r1, #0x200
	ldrgt r0, =0x017F4000
	bgt _0200CC10
	mov r0, #0x18000
	add r9, r1, #1
	mul r0, r1, r0
	mul r1, r9, r1
	mul r9, r1, r4
	add r0, r0, r9, asr #1
_0200CC10:
	add r6, r6, r0
_0200CC14:
	mov r0, r8
	mov r8, #0
	str r8, [sp]
	str r2, [sp, #4]
	mov r2, #0x40
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	str r4, [sp, #0x10]
	and r1, r11, #0xff
	mov r2, #0xbf
	mov r3, r8
	str r6, [sp, #0x14]
	bl FontDMAControl__Func_20520B0
_0200CC48:
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r10, r10, #0x70
	add r5, r5, #1
	cmp r5, #2
	blt _0200C984
	ldr r0, [sp, #0x2c]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp, #0x2c]
	str r1, [r0, #0x63c]
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Process_Z9(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r0, =_0210E074
	ldr r1, =MapFarSys__sVars
	ldrh r7, [r0, #0xa]
	ldrh r6, [r0, #0xc]
	ldrh r5, [r0, #0xe]
	ldrh r4, [r0, #4]
	ldrh r3, [r0, #6]
	ldrh r2, [r0, #8]
	ldr r1, [r1, #8]
	mov r0, #0xe
	strh r7, [sp, #0xa]
	strh r6, [sp, #0xc]
	strh r5, [sp, #0xe]
	strh r4, [sp, #4]
	strh r3, [sp, #6]
	strh r2, [sp, #8]
	str r1, [sp]
	bl MapFarSys__DoFarScrollX
	bl MapFarSys__DoFarScrollY
	ldr r0, =MapFarSys__sVars
	ldr r1, =mapCamera
	ldr r4, [r0, #8]
	ldr r3, [r1, #0x38]
	ldr r2, [r4, #0x10]
	mov r0, #0
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldr r3, [r1, #0xa8]
	ldr r2, [r4, #0x18]
	add r2, r3, r2
	str r2, [r1, #0xa8]
	ldr r1, [sp]
	add r3, sp, #4
	ldr r5, [r1, #0x63c]
	add r1, sp, #0x10
_0200CD3C:
	mov r4, r0, lsl #1
	ldrsh r2, [r3, r4]
	add r0, r0, #1
	cmp r0, #3
	mul r2, r5, r2
	mov r2, r2, lsr #0xc
	strh r2, [r1, r4]
	blt _0200CD3C
	mov r5, #0
	cmp r5, #2
	bge _0200CE30
_0200CD68:
	and r0, r5, #0xff
	bl RenderCore_GetDMASrc
	ldr r2, =mapCamera
	mov r1, #0x70
	mla r2, r5, r1, r2
	ldr r1, [r2, #0x3c]
	ldr r2, [r2, #0x38]
	mov r1, r1, lsl #4
	mov r2, r2, asr #0xc
	mov r7, #0
	mov r6, r0
	mov r10, r7
	mov r1, r1, lsr #0x10
	mov r4, r2, lsl #0x10
	add r11, sp, #0xa
_0200CDA4:
	mov r0, r10, lsl #1
	ldrh r9, [r11, r0]
	cmp r1, r9
	bhs _0200CE10
	sub r0, r9, r1
	mov r0, r0, lsl #0x10
	add r1, r7, r0, lsr #16
	cmp r1, #0xc0
	mov r8, r0, lsr #0x10
	rsbgt r0, r7, #0xc0
	movgt r0, r0, lsl #0x10
	movgt r8, r0, lsr #0x10
	cmp r8, #0
	beq _0200CE00
	mov r1, r10, lsl #1
	add r0, sp, #0x10
	ldrh r0, [r0, r1]
	add r1, r6, r7, lsl #1
	mov r2, r8, lsl #1
	add r0, r0, r4, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
_0200CE00:
	add r0, r7, r8
	mov r0, r0, lsl #0x10
	mov r1, r9
	mov r7, r0, lsr #0x10
_0200CE10:
	add r10, r10, #1
	cmp r10, #3
	blt _0200CDA4
	and r0, r5, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	add r5, r5, #1
	cmp r5, #2
	blt _0200CD68
_0200CE30:
	ldr r0, [sp]
	ldr r0, [r0, #0x63c]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x63c]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__DoFarScrollX(s32 scrollSpeed)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl CheckStageUsesLaps
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r4, =mapCamera
	ldr r0, [r4, #0x40]
	tst r0, #1
	bne _0200CE8C
	ldr r0, [r4, #4]
	mov r1, r5
	bl _s32_div_f
	str r0, [r4, #0x38]
_0200CE8C:
	ldr r4, =mapCamera+0x00000070
	ldr r0, [r4, #0x40]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #4]
	mov r1, r5
	bl _s32_div_f
	str r0, [r4, #0x38]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__DoFarScrollY(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, =mapCamera
	ldr r0, [r4, #0xe0]
	tst r0, #1
	beq _0200CF48
	bl MapSys__GetCameraA
	mov r5, r0
	bl MapSys__GetCameraB
	ldr r1, =MapFarSys__sVars
	ldr r2, [r5, #0x40]
	ldr r1, [r1, #8]
	mov r6, r0
	tst r2, #1
	ldr r4, [r1, #8]
	bne _0200CF14
	ldr r2, [r5, #8]
	sub r0, r4, #0x1d0
	ldr r1, =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	str r0, [r5, #0x3c]
_0200CF14:
	ldr r0, [r6, #0x40]
	tst r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r2, [r5, #8]
	sub r0, r4, #0x1d0
	ldr r1, =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	add r0, r0, #0x110000
	str r0, [r6, #0x3c]
	ldmia sp!, {r4, r5, r6, pc}
_0200CF48:
	ldr r0, =MapFarSys__sVars
	ldr r1, [r4, #0x40]
	ldr r0, [r0, #8]
	tst r1, #1
	ldr r0, [r0, #8]
	bne _0200CF80
	ldr r2, [r4, #8]
	sub r0, r0, #0x1d0
	ldr r1, =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	str r0, [r4, #0x3c]
_0200CF80:
	ldr r4, =mapCamera+0x00000070
	ldr r0, =MapFarSys__sVars
	ldr r1, [r4, #0x40]
	ldr r0, [r0, #8]
	tst r1, #1
	ldr r0, [r0, #0xc]
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r2, [r4, #8]
	sub r0, r0, #0x1d0
	ldr r1, =mapCamera+0x00000100
	mul r0, r2, r0
	ldrh r1, [r1, #0x2c]
	sub r1, r1, #0xc0
	bl FX_DivS32
	str r0, [r4, #0x3c]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__ProcessScroll(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldr r0, =mapCamera
	mov r4, #0
	ldr r1, [r0, #0x3c]
	str r0, [sp]
	ldr r0, [r0, #0xac]
	mov r1, r1, asr #0xc
	mov r0, r0, asr #0xc
	str r4, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
_0200D000:
	ldr r0, =mapCamera
	mov r1, #0
	ldr r0, [r0, #0xe0]
	tst r0, #1
	beq _0200D024
	ldr r0, =MapFarSys__sVars
	ldr r0, [r0, #8]
	ldr r8, [r0, #0x620]
	b _0200D03C
_0200D024:
	ldr r0, =MapFarSys__sVars
	ldr r3, [r0, #8]
	ldr r0, [sp, #4]
	add r2, r3, r0
	ldr r8, [r2, #0x620]
	add r0, r3, r4, lsl #2
_0200D03C:
	ldr r3, [r0, #8]
	add r0, sp, #8
	ldr r0, [r0, r4, lsl #2]
	b _0200D060
_0200D04C:
	add r2, r1, r2
	cmp r2, r0
	bgt _0200D074
	mov r1, r2
	add r8, r8, #4
_0200D060:
	cmp r1, r3
	bge _0200D074
	ldrh r2, [r8, #2]
	cmp r2, #0
	bne _0200D04C
_0200D074:
	add r0, sp, #8
	ldr r3, [r0, r4, lsl #2]
	ldrh r2, [r8, #0]
	sub r6, r3, r1
	and r0, r4, #0xff
	sub r1, r6, r2
	mov r1, r1, lsl #0x17
	mov r2, r1, lsr #0xb
	ldr r1, [sp]
	mov r7, r6
	str r2, [r1, #0x3c]
	bl RenderCore_GetDMASrc
	ldr r11, =0x000001FF
	mov r9, r0
	mov r5, #0
_0200D0B0:
	ldrh r0, [r8, #2]
	mov r1, r9
	sub r10, r0, r7
	add r0, r5, r10
	cmp r0, #0xc0
	ldrh r0, [r8, #0]
	rsbge r10, r5, #0xc0
	mov r2, r10, lsl #1
	add r0, r6, r0
	and r0, r0, r11
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MIi_CpuClear16
	ldrh r0, [r8, #2]
	add r5, r5, r10
	mov r7, #0
	cmp r5, #0xc0
	sub r6, r6, r0
	add r8, r8, #4
	add r9, r9, r10, lsl #1
	blt _0200D0B0
	and r0, r4, #0xff
	bl RenderCore_PrepareDMASwapBuffer
	ldr r0, [sp, #4]
	add r4, r4, #1
	add r0, r0, #0xc
	str r0, [sp, #4]
	ldr r0, [sp]
	cmp r4, #2
	add r0, r0, #0x70
	str r0, [sp]
	blt _0200D000
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapFarSys__Func_200D144(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r5, #0
	mov r10, r2
	mov r9, r3
	ldr r8, [sp, #0x30]
	ldr r7, [sp, #0x34]
	ldr r11, [sp, #0x38]
	ldr r4, [sp, #0x3c]
	str r0, [sp]
	str r1, [sp, #4]
	cmp r9, r10
	mov r6, r5
	addgt sp, sp, #8
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0200D180:
	ldrh r2, [r4, #0]
	ldr r0, [sp, #4]
	ldrh r1, [r4, #4]
	cmp r9, r0
	mul r0, r1, r2
	mov r0, r0, lsl #0x10
	blt _0200D240
	cmp r6, #0
	moveq r6, r2
	b _0200D228
_0200D1A8:
	smull r1, r0, r8, r7
	ldrh r3, [r4, #2]
	ldrh r2, [r4, #4]
	add r3, r3, r5
	sub r5, r2, r5
	sub r2, r3, r9
	adds r3, r1, #0x800
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	adc r0, r0, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r0, =0x000001FF
	mov r2, r2, lsl #0x17
	and r0, r0, r1, asr #12
	add r1, r9, r5
	cmp r1, r10
	subhi r1, r10, r9
	addhi r5, r1, #1
	ldr r1, [sp]
	orr r0, r0, r2, lsr #7
	add r1, r1, r9, lsl #2
	mov r2, r5, lsl #2
	bl MIi_CpuClear32
	ldrh r1, [r4, #6]
	sub r0, r6, #1
	mov r0, r0, lsl #0x10
	add r9, r9, r5
	add r7, r7, r11
	add r8, r8, r1, lsl #12
	mov r6, r0, lsr #0x10
	mov r5, #0
_0200D228:
	cmp r9, r10
	bgt _0200D238
	cmp r6, #0
	bne _0200D1A8
_0200D238:
	add r4, r4, #8
	b _0200D2B4
_0200D240:
	ldr r3, [sp, #4]
	add r0, r9, r0, lsr #16
	cmp r0, r3
	ble _0200D29C
	mov r0, r3
	sub r5, r0, r9
	mov r0, r5
	bl FX_DivS32
	ldrh r3, [r4, #4]
	ldrh r2, [r4, #6]
	ldrh r1, [r4, #0]
	mul r6, r3, r0
	mov r3, r2, lsl #0xc
	sub r2, r1, r0
	sub r5, r5, r6
	mov r1, r5, lsl #0x10
	mov r2, r2, lsl #0x10
	mla r8, r3, r0, r8
	mla r7, r11, r0, r7
	ldr r9, [sp, #4]
	mov r5, r1, lsr #0x10
	mov r6, r2, lsr #0x10
	b _0200D2B4
_0200D29C:
	ldrh r1, [r4, #6]
	mla r7, r11, r2, r7
	mov r1, r1, lsl #0xc
	mla r8, r1, r2, r8
	mov r9, r0
	add r4, r4, #8
_0200D2B4:
	cmp r9, r10
	ble _0200D180
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
