#include <game/stage/eventManager.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/graphics/renderCore.h>
#include <stage/core/ringManager.h>
#include <stage/core/decorationSys.h>
#include <stage/core/ringBattleManager.h>

// Object Includes
#include <stage/player/playerSpawn.h>

// Gimmicks
#include <stage/objects/startPlatform.h>
#include <stage/objects/itembox.h>
#include <stage/objects/checkpoint.h>
#include <stage/objects/dashPanel.h>
#include <stage/objects/dashRing.h>
#include <stage/objects/spikes.h>
#include <stage/objects/spring.h>
#include <stage/objects/planeRing.h>
#include <stage/objects/missionFlag.h>
#include <stage/objects/medal.h>
#include <stage/objects/flagChange.h>
#include <stage/objects/springboard.h>
#include <stage/objects/waterLevelTrigger.h>
#include <stage/objects/waterRunTrigger.h>
#include <stage/objects/ringButton.h>
#include <stage/objects/jumpbox.h>
#include <stage/objects/goalChest.h>
#include <stage/objects/playerSnowboard.h>
#include <stage/objects/tutorial.h>
#include <stage/objects/icicle.h>
#include <stage/objects/flipboard.h>
#include <stage/objects/iceBlock.h>
#include <stage/objects/halfpipe.h>
#include <stage/objects/fireHazard.h>
#include <stage/objects/hoverCrystal.h>
#include <stage/objects/crumblingFloor.h>
#include <stage/objects/breakableObject.h>
#include <stage/objects/breakableWall.h>
#include <stage/objects/platform.h>
#include <stage/objects/diveStand.h>
#include <stage/objects/bouncyMushroom.h>
#include <stage/objects/springCrystal.h>
#include <stage/objects/steamFan.h>
#include <stage/objects/winch.h>
#include <stage/objects/bgUnknownTrigger.h>
#include <stage/objects/avalanche.h>
#include <stage/objects/ghostTree.h>
#include <stage/objects/stalactite.h>
#include <stage/objects/timerShutter.h>
#include <stage/objects/slingshot.h>
#include <stage/objects/fallingAnchor.h>
#include <stage/objects/floatingFountain.h>
#include <stage/objects/dolphin.h>
#include <stage/objects/bungee.h>
#include <stage/objects/springRope.h>
#include <stage/objects/balloon.h>
#include <stage/objects/corkscrewPath.h>
#include <stage/objects/rotatingHanger.h>
#include <stage/objects/swingRope.h>
#include <stage/objects/tripleGrindRail.h>
#include <stage/objects/pipe.h>
#include <stage/objects/popSteam.h>
#include <stage/objects/dreamWing.h>
#include <stage/objects/largePiston.h>
#include <stage/objects/cameraBoundsTrigger.h>
#include <stage/objects/rotateCrane.h>
#include <stage/objects/truck.h>
#include <stage/objects/anchorRope.h>
#include <stage/objects/barrel.h>
#include <stage/objects/trampoline.h>
#include <stage/objects/pirateShip.h>
#include <stage/objects/cannon.h>
#include <stage/objects/waterGun.h>

// Enemies
#include <stage/enemies/robot.h>
#include <stage/enemies/jetpackRobot.h>
#include <stage/enemies/angler.h>
#include <stage/enemies/crab.h>
#include <stage/enemies/ghost.h>
#include <stage/enemies/snowflakeHead.h>
#include <stage/enemies/snowball.h>
#include <stage/enemies/glider.h>
#include <stage/enemies/pirate.h>
#include <stage/enemies/fireSkull.h>
#include <stage/enemies/divebat.h>
#include <stage/enemies/skymoon.h>

// Bosses
#include <stage/boss/boss1.h>
#include <stage/boss/boss2.h>
#include <stage/boss/boss3.h>
#include <stage/boss/boss4.h>
#include <stage/boss/boss5.h>
#include <stage/boss/boss6.h>
#include <stage/boss/boss7.h>
#include <stage/boss/bossF.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED EventManagerStaticVars EventManager__sVars;

NOT_DECOMPILED void *viewOffset;
NOT_DECOMPILED void *_02134020;
NOT_DECOMPILED void *_02134022;
NOT_DECOMPILED void *objectSpawnFunc2;
NOT_DECOMPILED void *objectSpawnFunc4;
NOT_DECOMPILED void *objectSpawnFunc;
NOT_DECOMPILED void *objectSpawnFunc3;
NOT_DECOMPILED void *eventManagerTask;
NOT_DECOMPILED void *eventManagerArchive;
NOT_DECOMPILED void *objectLayout;
NOT_DECOMPILED void *ringLayout;
NOT_DECOMPILED void *decorLayout;

NOT_DECOMPILED void (*Map__CreateObjectLists[3])(EventManager *work, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
NOT_DECOMPILED void *gm_evemgr_create_size_tbl;

// --------------------
// ENUMS
// --------------------

enum EventManagerAllocFlag_
{
    EVENTMANAGER_ALLOC_EVENT_USER = 0 << 0,
    EVENTMANAGER_ALLOC_RING_USER  = 0 << 1,
    EVENTMANAGER_ALLOC_DECOR_USER = 0 << 2,

    EVENTMANAGER_ALLOC_EVENT_SYSTEM = 1 << 0,
    EVENTMANAGER_ALLOC_RING_SYSTEM  = 1 << 1,
    EVENTMANAGER_ALLOC_DECOR_SYSTEM = 1 << 2,
};

// --------------------
// VARIABLES
// --------------------

const CreateDecorationFunc stageDecorationSpawnList[MAPDECOR_COUNT] = {
    [MAPDECOR_0]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_1]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_2]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_3]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_4]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_5]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_6]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_7]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_8]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_9]   = (CreateDecorationFunc)NULL,
    [MAPDECOR_10]  = (CreateDecorationFunc)NULL,
    [MAPDECOR_11]  = (CreateDecorationFunc)NULL,
    [MAPDECOR_12]  = (CreateDecorationFunc)NULL,
    [MAPDECOR_13]  = (CreateDecorationFunc)NULL,
    [MAPDECOR_14]  = (CreateDecorationFunc)NULL,
    [MAPDECOR_15]  = (CreateDecorationFunc)NULL,
    [MAPDECOR_16]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_17]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_18]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_19]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_20]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_21]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_22]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_23]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_24]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_25]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_26]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_27]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_28]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_29]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_30]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_31]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_32]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_33]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_34]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_35]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_36]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_37]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_38]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_39]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_40]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_41]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_42]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_43]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_44]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_45]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_46]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_47]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_48]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_49]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_50]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_51]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_52]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_53]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_54]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_55]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_56]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_57]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_58]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_59]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_60]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_61]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_62]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_63]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_64]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_65]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_66]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_67]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_68]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_69]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_70]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_71]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_72]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_73]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_74]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_75]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_76]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_77]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_78]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_79]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_80]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_81]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_82]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_83]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_84]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_85]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_86]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_87]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_88]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_89]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_90]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_91]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_92]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_93]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_94]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_95]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_96]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_97]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_98]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_99]  = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_100] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_101] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_102] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_103] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_104] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_105] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_106] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_107] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_108] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_109] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_110] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_111] = (CreateDecorationFunc)DecorationSys__CreateUnknown2153118,
    [MAPDECOR_112] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_113] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_114] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_115] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_116] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_117] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_118] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_119] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_120] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_121] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_122] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_123] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_124] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_125] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_126] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_127] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_128] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_129] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_130] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_131] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_132] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_133] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_134] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_135] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_136] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_137] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_138] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_139] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_140] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_141] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_142] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_143] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_144] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_145] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_146] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_147] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_148] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_149] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_150] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_151] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_152] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_153] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_154] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_155] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_156] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_157] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_158] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_159] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_160] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_161] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_162] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_163] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_164] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_165] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_166] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_167] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_168] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_169] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_170] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_171] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_172] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_173] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_174] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_175] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_176] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_177] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_178] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_179] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_180] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_181] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_182] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_183] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_184] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_185] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_186] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_187] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_188] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_189] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_190] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_191] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_192] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_193] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_194] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_195] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_196] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_197] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_198] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_199] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_200] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_201] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_202] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_203] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_204] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_205] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_206] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_207] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_208] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_209] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_210] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_211] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_212] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_213] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_214] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_215] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_216] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_217] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_218] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_219] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_220] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_221] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_222] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_223] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_224] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_225] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_226] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_227] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_228] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_229] = (CreateDecorationFunc)NULL,
    [MAPDECOR_230] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_231] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_232] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_233] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_234] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_235] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_236] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_237] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_238] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_239] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_240] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_241] = (CreateDecorationFunc)DecorationSys__CreateUnknown2152D9C,
    [MAPDECOR_242] = (CreateDecorationFunc)DecorationSys__CreateUnknown2152D9C,
    [MAPDECOR_243] = (CreateDecorationFunc)DecorationSys__CreateUnknown2152D9C,
    [MAPDECOR_244] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_245] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_246] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_247] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_248] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_249] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_250] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_251] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_252] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_253] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_254] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_255] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_256] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_257] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_258] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_259] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_260] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_261] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_262] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_263] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_264] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_265] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_266] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_267] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_268] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_269] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_270] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_271] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_272] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_273] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_274] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_275] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_276] = (CreateDecorationFunc)DecorationSys__CreateUnknown21547D4,
    [MAPDECOR_277] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_278] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_279] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_280] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_281] = (CreateDecorationFunc)DecorationSys__CreateUnknown21547D4,
    [MAPDECOR_282] = (CreateDecorationFunc)DecorationSys__CreateUnknown21547D4,
    [MAPDECOR_283] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_284] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_285] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_286] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_287] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_288] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_289] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_290] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_291] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_292] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_293] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_294] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_295] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_296] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_297] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_298] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_299] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_300] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_301] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_302] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_303] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
    [MAPDECOR_304] = (CreateDecorationFunc)DecorationSys__CreateCommonDecor,
};

const CreateObjectFunc stageObjectSpawnList[MAPOBJECT_COUNT] = {
    // Stage Enemies
    [MAPOBJECT_0]   = (CreateObjectFunc)CreateRobot,
    [MAPOBJECT_1]   = (CreateObjectFunc)CreateRobot,
    [MAPOBJECT_2]   = (CreateObjectFunc)CreateRobot,
    [MAPOBJECT_3]   = (CreateObjectFunc)CreateRobot,
    [MAPOBJECT_4]   = (CreateObjectFunc)CreateRobot,
    [MAPOBJECT_5]   = (CreateObjectFunc)CreateJetpackRobot,
    [MAPOBJECT_6]   = (CreateObjectFunc)CreateAngler,
    [MAPOBJECT_7]   = (CreateObjectFunc)CreateAngler,
    [MAPOBJECT_8]   = (CreateObjectFunc)CreateCrab,
    [MAPOBJECT_9]   = (CreateObjectFunc)CreateGhost,
    [MAPOBJECT_10]  = (CreateObjectFunc)CreateSnowflakeHead,
    [MAPOBJECT_11]  = (CreateObjectFunc)CreateSnowball,
    [MAPOBJECT_12]  = (CreateObjectFunc)CreateGlider,
    [MAPOBJECT_13]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_14]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_15]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_16]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_17]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_18]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_19]  = (CreateObjectFunc)CreatePirate,
    [MAPOBJECT_20]  = (CreateObjectFunc)CreateFireSkull,
    [MAPOBJECT_21]  = (CreateObjectFunc)CreateDiveBat,
    [MAPOBJECT_22]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_23]  = (CreateObjectFunc)CreateSkymoon,
    [MAPOBJECT_24]  = (CreateObjectFunc)CreateSkymoon,
    [MAPOBJECT_25]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_26]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_27]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_28]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_29]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_30]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_31]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_32]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_33]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_34]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_35]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_36]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_37]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_38]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_39]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_40]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_41]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_42]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_43]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_44]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_45]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_46]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_47]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_48]  = (CreateObjectFunc)CreateItemBox,
    [MAPOBJECT_49]  = (CreateObjectFunc)CreateItemBox,
    [MAPOBJECT_50]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_51]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_52]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_53]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_54]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_55]  = (CreateObjectFunc)NULL,
    [MAPOBJECT_56]  = (CreateObjectFunc)BossFStage__Create,
    [MAPOBJECT_57]  = (CreateObjectFunc)Boss7Stage__Create,
    [MAPOBJECT_58]  = (CreateObjectFunc)Boss6Stage__Create,
    [MAPOBJECT_59]  = (CreateObjectFunc)Boss5Stage__Create,
    [MAPOBJECT_60]  = (CreateObjectFunc)Boss4Stage__Create,
    [MAPOBJECT_61]  = (CreateObjectFunc)Boss3Stage__Create,
    [MAPOBJECT_62]  = (CreateObjectFunc)Boss2Stage__Create,
    [MAPOBJECT_63]  = (CreateObjectFunc)Boss1Stage__Create,
    
    // Stage Interactables
    [MAPOBJECT_64]  = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_65]  = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_66]  = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_67]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_68]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_69]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_70]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_71]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_72]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_73]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_74]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_75]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_76]  = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_77]  = (CreateObjectFunc)CreateSpikes,
    [MAPOBJECT_78]  = (CreateObjectFunc)CreateSpikes,
    [MAPOBJECT_79]  = (CreateObjectFunc)CreateSpikes,
    [MAPOBJECT_80]  = (CreateObjectFunc)CreateSpikes,
    [MAPOBJECT_81]  = (CreateObjectFunc)CreateBouncyMushroom,
    [MAPOBJECT_82]  = (CreateObjectFunc)CreateBouncyMushroom,
    [MAPOBJECT_83]  = (CreateObjectFunc)CreateBouncyMushroom,
    [MAPOBJECT_84]  = (CreateObjectFunc)PopSteam__Create,
    [MAPOBJECT_85]  = (CreateObjectFunc)PopSteam__Create,
    [MAPOBJECT_86]  = (CreateObjectFunc)PopSteam__Create,
    [MAPOBJECT_87]  = (CreateObjectFunc)PopSteam__Create,
    [MAPOBJECT_88]  = (CreateObjectFunc)LargePiston__Create,
    [MAPOBJECT_89]  = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_90]  = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_91]  = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_92]  = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_93]  = (CreateObjectFunc)CreateSpikes,
    [MAPOBJECT_94]  = (CreateObjectFunc)CreateSpikes,
    [MAPOBJECT_95]  = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_96]  = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_97]  = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_98]  = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_99]  = (CreateObjectFunc)CreateDashRingRainbow,
    [MAPOBJECT_100] = (CreateObjectFunc)CreateDashRingRainbow,
    [MAPOBJECT_101] = (CreateObjectFunc)CreateDashRingRainbow,
    [MAPOBJECT_102] = (CreateObjectFunc)CreateDashRingRainbow,
    [MAPOBJECT_103] = (CreateObjectFunc)CreateSpringboard,
    [MAPOBJECT_104] = (CreateObjectFunc)CreateCorkscrewPath,
    [MAPOBJECT_105] = (CreateObjectFunc)CreateCorkscrewPath,
    [MAPOBJECT_106] = (CreateObjectFunc)CreateDashRing,
    [MAPOBJECT_107] = (CreateObjectFunc)CreateDashRing,
    [MAPOBJECT_108] = (CreateObjectFunc)CreateDashRing,
    [MAPOBJECT_109] = (CreateObjectFunc)CreateDashRing,
    [MAPOBJECT_110] = (CreateObjectFunc)CreateCheckpoint,
    [MAPOBJECT_111] = (CreateObjectFunc)BreakableObject__Create,
    [MAPOBJECT_112] = (CreateObjectFunc)RotatingHanger__Create,
    [MAPOBJECT_113] = (CreateObjectFunc)CreateGoalChest,
    [MAPOBJECT_114] = (CreateObjectFunc)CreatePlayerSpawn,
    [MAPOBJECT_115] = (CreateObjectFunc)PipeFlow__Create,
    [MAPOBJECT_116] = (CreateObjectFunc)PipeFlow__Create,
    [MAPOBJECT_117] = (CreateObjectFunc)PipeFlow__Create,
    [MAPOBJECT_118] = (CreateObjectFunc)SwingRope__Create,
    [MAPOBJECT_119] = (CreateObjectFunc)BreakableWall__Create,
    [MAPOBJECT_120] = (CreateObjectFunc)TripleGrindRailSpring__Create,
    [MAPOBJECT_121] = (CreateObjectFunc)TripleGrindRail__Create,
    [MAPOBJECT_122] = (CreateObjectFunc)TripleGrindRailEntity__Create,
    [MAPOBJECT_123] = (CreateObjectFunc)TripleGrindRailEntity__Create,
    [MAPOBJECT_124] = (CreateObjectFunc)BreakableWall__Create,
    [MAPOBJECT_125] = (CreateObjectFunc)CreateWaterLevelTrigger,
    [MAPOBJECT_126] = (CreateObjectFunc)CreateWaterRunTrigger,
    [MAPOBJECT_127] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_128] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_129] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_130] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_131] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_132] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_133] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_134] = (CreateObjectFunc)PipeSteam__Create,
    [MAPOBJECT_135] = (CreateObjectFunc)CreateSteamFan,
    [MAPOBJECT_136] = (CreateObjectFunc)DreamWing__Create,
    [MAPOBJECT_137] = (CreateObjectFunc)DreamWingPart__Create,
    [MAPOBJECT_138] = (CreateObjectFunc)CameraBoundsTrigger__Create,
    [MAPOBJECT_139] = (CreateObjectFunc)CreateIcicle,
    [MAPOBJECT_140] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_141] = (CreateObjectFunc)CreateFlipboard,
    [MAPOBJECT_142] = (CreateObjectFunc)CreateLoseSnowboardTrigger,
    [MAPOBJECT_143] = (CreateObjectFunc)DiveStand__Create,
    [MAPOBJECT_144] = (CreateObjectFunc)CreateIceBlock,
    [MAPOBJECT_145] = (CreateObjectFunc)CreateHalfpipe,
    [MAPOBJECT_146] = (CreateObjectFunc)CreateHalfpipe,
    [MAPOBJECT_147] = (CreateObjectFunc)CreateHalfpipe,
    [MAPOBJECT_148] = (CreateObjectFunc)CreateGhostTree,
    [MAPOBJECT_149] = (CreateObjectFunc)DiveStand__Create,
    [MAPOBJECT_150] = (CreateObjectFunc)CreateBGUnknownTrigger,
    [MAPOBJECT_151] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_152] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_153] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_154] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_155] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_156] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_157] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_158] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_159] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_160] = (CreateObjectFunc)CreateStalactite,
    [MAPOBJECT_161] = (CreateObjectFunc)CreateStalactite,
    [MAPOBJECT_162] = (CreateObjectFunc)CreateSpringCrystal,
    [MAPOBJECT_163] = (CreateObjectFunc)CreateSpringCrystal,
    [MAPOBJECT_164] = (CreateObjectFunc)CreateSpringCrystal,
    [MAPOBJECT_165] = (CreateObjectFunc)CreateSpringCrystal,
    [MAPOBJECT_166] = (CreateObjectFunc)RotateCrane__Create,
    [MAPOBJECT_167] = (CreateObjectFunc)RotateCrane__Create,
    [MAPOBJECT_168] = (CreateObjectFunc)RotateCrane__Create,
    [MAPOBJECT_169] = (CreateObjectFunc)RotateCrane__Create,
    [MAPOBJECT_170] = (CreateObjectFunc)CreateWinch,
    [MAPOBJECT_171] = (CreateObjectFunc)LargePiston__Create,
    [MAPOBJECT_172] = (CreateObjectFunc)LargePiston__Create,
    [MAPOBJECT_173] = (CreateObjectFunc)Truck__Create,
    [MAPOBJECT_174] = (CreateObjectFunc)TruckBarrier__Create,
    [MAPOBJECT_175] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_176] = (CreateObjectFunc)CreatePlaneRing,
    [MAPOBJECT_177] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_178] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_179] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_180] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_181] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_182] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_183] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_184] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_185] = (CreateObjectFunc)Truck3DTrigger__Create,
    [MAPOBJECT_186] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_187] = (CreateObjectFunc)Platform__Create,
    [MAPOBJECT_188] = (CreateObjectFunc)Platform__Create,
    [MAPOBJECT_189] = (CreateObjectFunc)Platform__Create,
    [MAPOBJECT_190] = (CreateObjectFunc)Platform__Create,
    [MAPOBJECT_191] = (CreateObjectFunc)NULL,
    [MAPOBJECT_192] = (CreateObjectFunc)NULL,
    [MAPOBJECT_193] = (CreateObjectFunc)NULL,
    [MAPOBJECT_194] = (CreateObjectFunc)CreateAvalanche,
    [MAPOBJECT_195] = (CreateObjectFunc)CreateAvalanche,
    [MAPOBJECT_196] = (CreateObjectFunc)CreateAvalancheTree,
    [MAPOBJECT_197] = (CreateObjectFunc)AnchorRope__Create,
    [MAPOBJECT_198] = (CreateObjectFunc)Barrel__Create,
    [MAPOBJECT_199] = (CreateObjectFunc)Trampoline__Create,
    [MAPOBJECT_200] = (CreateObjectFunc)Trampoline__Create,
    [MAPOBJECT_201] = (CreateObjectFunc)PirateShip__Create,
    [MAPOBJECT_202] = (CreateObjectFunc)CannonField__Create,
    [MAPOBJECT_203] = (CreateObjectFunc)Cannon__Create,
    [MAPOBJECT_204] = (CreateObjectFunc)CannonRing__Create,
    [MAPOBJECT_205] = (CreateObjectFunc)CreateTutorial,
    [MAPOBJECT_206] = (CreateObjectFunc)CreateTutorialCheckpoint,
    [MAPOBJECT_207] = (CreateObjectFunc)BreakableObject__Create,
    [MAPOBJECT_208] = (CreateObjectFunc)AnchorRope__Create,
    [MAPOBJECT_209] = (CreateObjectFunc)CreateJumpBox,
    [MAPOBJECT_210] = (CreateObjectFunc)CreateTimerShutter,
    [MAPOBJECT_211] = (CreateObjectFunc)CreateSlingshot,
    [MAPOBJECT_212] = (CreateObjectFunc)CreateSlingshot,
    [MAPOBJECT_213] = (CreateObjectFunc)CreateFallingAnchor,
    [MAPOBJECT_214] = (CreateObjectFunc)CreateDolphin,
    [MAPOBJECT_215] = (CreateObjectFunc)CreateFloatingFountain,
    [MAPOBJECT_216] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_217] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_218] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_219] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_220] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_221] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_222] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_223] = (CreateObjectFunc)CreateDolphinHoop,
    [MAPOBJECT_224] = (CreateObjectFunc)CreateFireHazard,
    [MAPOBJECT_225] = (CreateObjectFunc)CreateFireHazard,
    [MAPOBJECT_226] = (CreateObjectFunc)CreateFireHazard,
    [MAPOBJECT_227] = (CreateObjectFunc)CreateFireHazard,
    [MAPOBJECT_228] = (CreateObjectFunc)CreateHoverCrystal,
    [MAPOBJECT_229] = (CreateObjectFunc)CreateBalloonSpawner,
    [MAPOBJECT_230] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_231] = (CreateObjectFunc)CreateCrumblingFloor,
    [MAPOBJECT_232] = (CreateObjectFunc)CreateCrumblingFloor,
    [MAPOBJECT_233] = (CreateObjectFunc)CreateCrumblingFloor,
    [MAPOBJECT_234] = (CreateObjectFunc)WaterGun__Create,
    [MAPOBJECT_235] = (CreateObjectFunc)WaterGun__Create,
    [MAPOBJECT_236] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_237] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_238] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_239] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_240] = (CreateObjectFunc)CreateJumpBox,
    [MAPOBJECT_241] = (CreateObjectFunc)CreateFlagChange,
    [MAPOBJECT_242] = (CreateObjectFunc)CreatePlaneSwitchSpring,
    [MAPOBJECT_243] = (CreateObjectFunc)CreatePlaneSwitchSpring,
    [MAPOBJECT_244] = (CreateObjectFunc)CreatePlaneSwitchSpring,
    [MAPOBJECT_245] = (CreateObjectFunc)CreatePlaneSwitchSpring,
    [MAPOBJECT_246] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_247] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_248] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_249] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_250] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_251] = (CreateObjectFunc)WaterGrindTrigger__Create,
    [MAPOBJECT_252] = (CreateObjectFunc)CreateMissionFlag,
    [MAPOBJECT_253] = (CreateObjectFunc)CreateMedal,
    [MAPOBJECT_254] = (CreateObjectFunc)CreateBungee,
    [MAPOBJECT_255] = (CreateObjectFunc)CreateSpringRope,
    [MAPOBJECT_256] = (CreateObjectFunc)CreateRingButton,
    [MAPOBJECT_257] = (CreateObjectFunc)CreateRingButton,
    [MAPOBJECT_258] = (CreateObjectFunc)CreateRingBattleManagerObject,
    [MAPOBJECT_259] = (CreateObjectFunc)CreateFlagChange,

    // "Internal" Objects
    [MAPOBJECT_260] = (CreateObjectFunc)Boss5MapChunk__Create,
    [MAPOBJECT_261] = (CreateObjectFunc)Boss5Icicle2__Create,
    [MAPOBJECT_262] = (CreateObjectFunc)Boss5FreezeArea__Create,
    [MAPOBJECT_263] = (CreateObjectFunc)Boss5Unknown2174578__Create,
    [MAPOBJECT_264] = (CreateObjectFunc)Boss5Unknown2174200__Create,
    [MAPOBJECT_265] = (CreateObjectFunc)Boss5Core__Create,
    [MAPOBJECT_266] = (CreateObjectFunc)Boss5Unknown21748C4__Create,
    [MAPOBJECT_267] = (CreateObjectFunc)Boss5EnemyFish__Create,
    [MAPOBJECT_268] = (CreateObjectFunc)Boss5LifeSupport__Create,
    [MAPOBJECT_269] = (CreateObjectFunc)Boss5Shutter__Create,
    [MAPOBJECT_270] = (CreateObjectFunc)CreateCheckpoint,
    [MAPOBJECT_271] = (CreateObjectFunc)Boss5Battery__Create,
    [MAPOBJECT_272] = (CreateObjectFunc)CreateSpikes2,
    [MAPOBJECT_273] = (CreateObjectFunc)CreateSpikes2,
    [MAPOBJECT_274] = (CreateObjectFunc)CreateSpikes2,
    [MAPOBJECT_275] = (CreateObjectFunc)CreateSpikes2,
    [MAPOBJECT_276] = (CreateObjectFunc)CreateStageRing2D,
    [MAPOBJECT_277] = (CreateObjectFunc)Boss1__Create,
    [MAPOBJECT_278] = (CreateObjectFunc)Boss2__Create,
    [MAPOBJECT_279] = (CreateObjectFunc)Boss2Arm__Create,
    [MAPOBJECT_280] = (CreateObjectFunc)Boss2Drop__Create,
    [MAPOBJECT_281] = (CreateObjectFunc)Boss2Ball__Create,
    [MAPOBJECT_282] = (CreateObjectFunc)Boss2Bomb__Create,
    [MAPOBJECT_283] = (CreateObjectFunc)Boss2Wave__Create,
    [MAPOBJECT_284] = (CreateObjectFunc)Boss4__Create,
    [MAPOBJECT_285] = (CreateObjectFunc)Boss4Core__Create,
    [MAPOBJECT_286] = (CreateObjectFunc)Boss4Ship__Create,
    [MAPOBJECT_287] = (CreateObjectFunc)Boss4Pulley__Create,
    [MAPOBJECT_288] = (CreateObjectFunc)Boss4FireColumn__Create,
    [MAPOBJECT_289] = (CreateObjectFunc)Boss4FireBall__Create,
    [MAPOBJECT_290] = (CreateObjectFunc)Boss5__Create,
    [MAPOBJECT_291] = (CreateObjectFunc)Boss5Sea__Create,
    [MAPOBJECT_292] = (CreateObjectFunc)Boss5Missile__Create,
    [MAPOBJECT_293] = (CreateObjectFunc)CreateBoss5Icicle,
    [MAPOBJECT_294] = (CreateObjectFunc)Boss5PlayerFreezeEffect__Create,
    [MAPOBJECT_295] = (CreateObjectFunc)Boss5EnemyFish2__Create,
    [MAPOBJECT_296] = (CreateObjectFunc)Boss6__Create,
    [MAPOBJECT_297] = (CreateObjectFunc)Boss6Platform__Create,
    [MAPOBJECT_298] = (CreateObjectFunc)Boss6EnemyA__Create,
    [MAPOBJECT_299] = (CreateObjectFunc)Boss6EnemyB__Create,
    [MAPOBJECT_300] = (CreateObjectFunc)Boss6Missile__Create,
    [MAPOBJECT_301] = (CreateObjectFunc)Boss6Ring__Create,
    [MAPOBJECT_302] = (CreateObjectFunc)Boss3__Create,
    [MAPOBJECT_303] = (CreateObjectFunc)Boss3Arm__Create,
    [MAPOBJECT_304] = (CreateObjectFunc)Boss3SplatInk__Create,
    [MAPOBJECT_305] = (CreateObjectFunc)Boss3DimInk__Create,
    [MAPOBJECT_306] = (CreateObjectFunc)Boss3InkSmoke__Create,
    [MAPOBJECT_307] = (CreateObjectFunc)Boss3ScreenSplatInk__Create,
    [MAPOBJECT_308] = (CreateObjectFunc)Boss7Whisker__Create,
    [MAPOBJECT_309] = (CreateObjectFunc)Boss7Rocket__Create,
    [MAPOBJECT_310] = (CreateObjectFunc)Boss7Unknown__Create,
    [MAPOBJECT_311] = (CreateObjectFunc)Boss7Johnny__Create,
    [MAPOBJECT_312] = (CreateObjectFunc)Boss7Saw__Create,
    [MAPOBJECT_313] = (CreateObjectFunc)BossF__Create,
    [MAPOBJECT_314] = (CreateObjectFunc)BossFArm__Create,
    [MAPOBJECT_315] = (CreateObjectFunc)BossFBodyCannon__Create,
    [MAPOBJECT_316] = (CreateObjectFunc)BossFShipCannon__Create,
    [MAPOBJECT_317] = (CreateObjectFunc)BossFMissileGreen__Create,
    [MAPOBJECT_318] = (CreateObjectFunc)BossFMissileRed__Create,
    [MAPOBJECT_319] = (CreateObjectFunc)CreateStartPlatform,
    [MAPOBJECT_320] = (CreateObjectFunc)CreatePlayerSnowboard,
    [MAPOBJECT_321] = (CreateObjectFunc)CreateFallingStalactite,
    [MAPOBJECT_322] = (CreateObjectFunc)Truck3DRing__Create,
    [MAPOBJECT_323] = (CreateObjectFunc)Truck3DItemBox__Create,
    [MAPOBJECT_324] = (CreateObjectFunc)TruckBomb3D__Create,
    [MAPOBJECT_325] = (CreateObjectFunc)TruckSpike3D__Create,
    [MAPOBJECT_326] = (CreateObjectFunc)TruckLava3D__Create,
    [MAPOBJECT_327] = (CreateObjectFunc)PirateShipCannonBall__Create,
    [MAPOBJECT_328] = (CreateObjectFunc)CannonPath__Create,
    [MAPOBJECT_329] = (CreateObjectFunc)NULL,
    [MAPOBJECT_330] = (CreateObjectFunc)CreateSlingshotRock,
    [MAPOBJECT_331] = (CreateObjectFunc)CreateTimerShutterWater,
    [MAPOBJECT_332] = (CreateObjectFunc)Platform__Create,
    [MAPOBJECT_333] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_334] = (CreateObjectFunc)CreateDashPanel,
    [MAPOBJECT_335] = (CreateObjectFunc)CreateSpring,
    [MAPOBJECT_336] = (CreateObjectFunc)CreateSpringRopeSpring,
    [MAPOBJECT_337] = (CreateObjectFunc)CreateSpringRopeBase,
    [MAPOBJECT_338] = (CreateObjectFunc)CreateBalloon,
    [MAPOBJECT_339] = (CreateObjectFunc)CreateAnglerShot,
    [MAPOBJECT_340] = (CreateObjectFunc)CreateGhostBomb,
    [MAPOBJECT_341] = (CreateObjectFunc)CreateSnowballShot,
    [MAPOBJECT_342] = (CreateObjectFunc)CreateBazookaPirateShot,
    [MAPOBJECT_343] = (CreateObjectFunc)CreateBallChainPirateBall,
    [MAPOBJECT_344] = (CreateObjectFunc)CreateBombPirateBomb,
    [MAPOBJECT_345] = (CreateObjectFunc)CreateSkeletonPirateBone,
    [MAPOBJECT_346] = (CreateObjectFunc)CreateHoverBomberPirateBomb,
    [MAPOBJECT_347] = (CreateObjectFunc)CreateHoverGunnerPirateShot,
    [MAPOBJECT_348] = (CreateObjectFunc)CreateDiveBat,
    [MAPOBJECT_349] = (CreateObjectFunc)CreateSkymoonLaser,
};

static const u8 EventManager__StageAllocFlags[STAGE_COUNT] = {
    [STAGE_Z11]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z12]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_TUTORIAL]          = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z1B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z21]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_SYSTEM | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z22]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_SYSTEM | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z2B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z31]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z32]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_1]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z3B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z41]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_SYSTEM,
    [STAGE_Z42]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_SYSTEM,
    [STAGE_Z4B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z51]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_SYSTEM | EVENTMANAGER_ALLOC_DECOR_SYSTEM,
    [STAGE_Z52]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z5B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z61]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_SYSTEM | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z62]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_2]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z6B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z71]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_SYSTEM | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z72]               = EVENTMANAGER_ALLOC_EVENT_SYSTEM | EVENTMANAGER_ALLOC_RING_SYSTEM | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_Z7B]               = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_BOSS_FINAL]        = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_3]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_4]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_5]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_6]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_7]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_8]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_9]   = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_10]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_11]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_12]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_13]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_14]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_15]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_16]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_VS1] = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_VS2] = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_VS3] = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_VS4] = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_R1]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_R2]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
    [STAGE_HIDDEN_ISLAND_R3]  = EVENTMANAGER_ALLOC_EVENT_USER | EVENTMANAGER_ALLOC_RING_USER | EVENTMANAGER_ALLOC_DECOR_USER,
};

// --------------------
// FUNCTION DECLS
// --------------------

// static void EventManager__Destructor(Task *task);
// static void EventManager__Main(void);
//
// static void EventManager__State_Init(EventManager *work);
// static void EventManager__State_SingleScr(EventManager *work);
// static void EventManager__State_MultiScr(EventManager *work);
// static void EventManager__State_Boss(EventManager *work);
//
// static void EventManager__CreateAllEvents(EventManager *work);
// static void EventManager__CreateEventsInRect(EventManager *work, s32 id, s32 flags);
// static void EventManager__CreateEventLCD(EventManager *work, s32 id, s32 flags);
// static void EventManager__CreateStageObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
// static void EventManager__CreateRingObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
// static void EventManager__CreateDecorObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);

// --------------------
// FUNCTIONS
// --------------------

void EventManager__Init(void)
{
    // Nothin'
}

void EventManager__Create(void)
{
    Task *task = TaskCreate(EventManager__Main, EventManager__Destructor, TASK_FLAG_NONE, 0, 0x1090, TASK_GROUP(3), EventManager);

    EventManager *work = TaskGetWork(task, EventManager);

    EventManager__sVars.task       = task;
    EventManager__sVars.viewOffset = 256;
    EventManager__sVars.field_0    = 16;
    EventManager__sVars.field_4    = 256;

    TaskInitWork8(work);

    work->state = EventManager__State_Init;
}

void EventManager__Release(void)
{
    if (EventManager__sVars.archive != NULL)
    {
        HeapFree(HEAP_USER, EventManager__sVars.archive);
        EventManager__sVars.archive = NULL;
    }
}

void EventManager__LoadObjectLayout(void)
{
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "EVE", EventManager__sVars.archive);

    u8 allocFlag = EventManager__StageAllocFlags[gameState.stageID];

    void *eventFile = NNS_FndGetArchiveFileByIndex(&arc, ARC_EVE_FILE_EVENTS);
    if ((allocFlag & EVENTMANAGER_ALLOC_EVENT_SYSTEM) != 0)
        EventManager__sVars.objectLayout = HeapAllocHead(HEAP_SYSTEM, MI_GetUncompressedSize(eventFile));
    else
        EventManager__sVars.objectLayout = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(eventFile));

    RenderCore_CPUCopyCompressed(eventFile, EventManager__sVars.objectLayout);

    void *ringFile = NNS_FndGetArchiveFileByIndex(&arc, ARC_EVE_FILE_RINGS);
    if ((allocFlag & EVENTMANAGER_ALLOC_RING_SYSTEM) != 0)
        EventManager__sVars.ringLayout = HeapAllocHead(HEAP_SYSTEM, MI_GetUncompressedSize(ringFile));
    else
        EventManager__sVars.ringLayout = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(ringFile));

    RenderCore_CPUCopyCompressed(ringFile, EventManager__sVars.ringLayout);

    void *decorFile = NNS_FndGetArchiveFileByIndex(&arc, ARC_EVE_FILE_DECOR);
    if ((allocFlag & EVENTMANAGER_ALLOC_DECOR_SYSTEM) != 0)
        EventManager__sVars.decorLayout = HeapAllocHead(HEAP_SYSTEM, MI_GetUncompressedSize(decorFile));
    else
        EventManager__sVars.decorLayout = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(decorFile));

    RenderCore_CPUCopyCompressed(decorFile, EventManager__sVars.decorLayout);
    NNS_FndUnmountArchive(&arc);
}

void EventManager__ReleaseObjectLayout(void)
{
    u8 allocFlag = EventManager__StageAllocFlags[gameState.stageID];

    if (EventManager__sVars.objectLayout != NULL)
    {
        if ((allocFlag & EVENTMANAGER_ALLOC_EVENT_SYSTEM) != 0)
            HeapFree(HEAP_SYSTEM, EventManager__sVars.objectLayout);
        else
            HeapFree(HEAP_USER, EventManager__sVars.objectLayout);

        EventManager__sVars.objectLayout = NULL;
    }

    if (EventManager__sVars.ringLayout != NULL)
    {
        if ((allocFlag & EVENTMANAGER_ALLOC_RING_SYSTEM) != 0)
            HeapFree(HEAP_SYSTEM, EventManager__sVars.ringLayout);
        else
            HeapFree(HEAP_USER, EventManager__sVars.ringLayout);

        EventManager__sVars.ringLayout = NULL;
    }

    if (EventManager__sVars.decorLayout != NULL)
    {
        if ((allocFlag & EVENTMANAGER_ALLOC_DECOR_SYSTEM) != 0)
            HeapFree(HEAP_SYSTEM, EventManager__sVars.decorLayout);
        else
            HeapFree(HEAP_USER, EventManager__sVars.decorLayout);

        EventManager__sVars.decorLayout = NULL;
    }
}

void EventManager__CreateEventEnforce(void)
{
    u16 blockWidth  = ((mapCamera.camControl.width - 1) >> 8) + 1;
    u16 blockHeight = ((mapCamera.camControl.height - 1) >> 8) + 1;
    s32 width       = mapCamera.camControl.width;
    s32 height      = mapCamera.camControl.height;
    width--;
    height--;

    EventManager *work = TaskGetWork(EventManager__sVars.task, EventManager);

    ViewRect r_on;
    r_on.left   = 0;
    r_on.right  = width;
    r_on.top    = 0;
    r_on.bottom = height;

    for (u16 by = 0; by < blockHeight; by++)
    {
        for (u16 bx = 0; bx < blockWidth; bx++)
        {
            EventManager__CreateStageObjects(work, bx, by, &r_on, NULL, 0x08);
        }
    }
}

NONMATCH_FUNC void EventManager__CreateEventsUnknown(u16 left, u16 top, u16 right, u16 bottom)
{
    // https://decomp.me/scratch/IPGRN -> 92.43%
#ifdef NON_MATCHING
    s32 width  = mapCamera.camControl.width;
    s32 height = mapCamera.camControl.height;

    EventManager *work = TaskGetWork(EventManager__sVars.task, EventManager);

    width--;
    height--;

    s32 left2 = left;
    if (left2 > width)
        left2 = width;

    s32 top2 = top;
    if (top2 > height)
        top2 = height;

    s32 right2 = right;
    if (right2 <= width)
        width = right2;

    s32 bottom2 = bottom;
    if (bottom2 <= height)
        height = bottom2;

    ViewRect r_on;
    r_on.left   = left2;
    r_on.top    = top2;
    r_on.right  = width;
    r_on.bottom = height;

    for (u8 t = 0; t < 3; t++)
    {
        EventManager__sVars.objectSpawnFunc4 = Map__CreateObjectLists[t];

        for (u16 by = (r_on.top >> 8); by <= (r_on.bottom >> 8); by++)
        {
            for (u16 bx = (r_on.left >> 8); bx <= (r_on.right >> 8); bx++)
            {
                EventManager__sVars.objectSpawnFunc4(work, bx, by, &r_on, NULL, 0xF0);
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r8, =mapCamera+0x00000100
	ldr r4, =EventManager__sVars
	ldrh r9, [r8, #0x2a]
	mov r7, r0
	ldr r0, [r4, #0x18]
	ldrh r10, [r8, #0x2c]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl GetTaskWork_
	sub r1, r9, #1
	mov r8, r0
	cmp r7, r1
	movgt r7, r1
	sub r0, r10, #1
	cmp r6, r0
	movgt r6, r0
	cmp r5, r1
	movle r1, r5
	cmp r4, r0
	movle r0, r4
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r11, #0
_02037E50:
	ldr r0, [sp, #0xc]
	ldr r1, =Map__CreateObjectLists
	mov r0, r0, lsl #8
	ldr r2, [r1, r11, lsl #2]
	ldr r4, =EventManager__sVars
	ldr r1, [sp, #0x14]
	mov r10, r0, lsr #0x10
	str r2, [r4, #0xc]
	cmp r10, r1, asr #8
	bgt _02037EEC
	mov r7, #0
	mov r6, #0xf0
	add r5, sp, #8
_02037E84:
	ldr r0, [sp, #8]
	ldr r1, [sp, #0x10]
	mov r0, r0, lsl #8
	mov r9, r0, lsr #0x10
	cmp r9, r1, asr #8
	bgt _02037ED4
_02037E9C:
	ldr ip, [r4, #0xc]
	str r7, [sp]
	mov r0, r8
	mov r1, r9
	mov r2, r10
	mov r3, r5
	str r6, [sp, #4]
	blx ip
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	ldr r1, [sp, #0x10]
	mov r9, r0, lsr #0x10
	cmp r9, r1, asr #8
	ble _02037E9C
_02037ED4:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	ldr r1, [sp, #0x14]
	mov r10, r0, lsr #0x10
	cmp r10, r1, asr #8
	ble _02037E84
_02037EEC:
	add r0, r11, #1
	and r11, r0, #0xff
	cmp r11, #3
	blo _02037E50
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void *EventManager__GetObjectLayout(void)
{
    return EventManager__sVars.objectLayout;
}

void EventManager__Destructor(Task *task)
{
    EventManager *work = TaskGetWork(task, EventManager);
    UNUSED(work);

    EventManager__sVars.task       = NULL;
    EventManager__sVars.viewOffset = 0;
    EventManager__sVars.field_0    = 0;
    EventManager__sVars.field_4    = 0;
}

void EventManager__Main(void)
{
    EventManager *work = TaskGetWorkCurrent(EventManager);

    if (work->state != NULL)
        work->state(work);

    work->prevPos[0].x = mapCamera.camera[0].disp_pos.x;
    work->prevPos[0].y = mapCamera.camera[0].disp_pos.y;

    work->prevPos[1].x = mapCamera.camera[1].disp_pos.x;
    work->prevPos[1].y = mapCamera.camera[1].disp_pos.y;
}

void EventManager__State_Init(EventManager *work)
{
    if (IsBossStage())
    {
        EventManager__CreateAllEvents(work);
        work->state = EventManager__State_Boss;
    }
    else
    {
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        {
            EventManager__CreateEventLCD(work, 0, 1);
            work->state = EventManager__State_SingleScr;
        }
        else
        {
            EventManager__CreateEventsInRect(work, 0, 1);
            EventManager__CreateEventsInRect(work, 1, 1);
            work->state = EventManager__State_MultiScr;
        }
    }
}

void EventManager__State_SingleScr(EventManager *work)
{
    if (FX32_TO_WHOLE(mapCamera.camera[0].disp_pos.x) != FX32_TO_WHOLE(work->prevPos[0].x) || FX32_TO_WHOLE(mapCamera.camera[0].disp_pos.y) != FX32_TO_WHOLE(work->prevPos[0].y))
    {
        EventManager__CreateEventLCD(work, 0, 5);
    }
}

void EventManager__State_MultiScr(EventManager *work)
{
    if (FX32_TO_WHOLE(mapCamera.camera[0].disp_pos.x) != FX32_TO_WHOLE(work->prevPos[0].x) || FX32_TO_WHOLE(mapCamera.camera[0].disp_pos.y) != FX32_TO_WHOLE(work->prevPos[0].y))
    {
        EventManager__CreateEventsInRect(work, 0, 5);
    }

    if (FX32_TO_WHOLE(mapCamera.camera[1].disp_pos.x) != FX32_TO_WHOLE(work->prevPos[1].x) || FX32_TO_WHOLE(mapCamera.camera[1].disp_pos.y) != FX32_TO_WHOLE(work->prevPos[1].y))
    {
        EventManager__CreateEventsInRect(work, 1, 5);
    }
}

void EventManager__State_Boss(EventManager *work)
{
    EventManager__CreateEventsInRect(work, 0, 5);
}

NONMATCH_FUNC void EventManager__CreateAllEvents(EventManager *work)
{
    // https://decomp.me/scratch/0knyk -> 80.10%
#ifdef NON_MATCHING
    s32 width  = mapCamera.camControl.width;
    s32 height = mapCamera.camControl.height;
    width--;
    height--;

    for (u8 t = 0; t < 3; t++)
    {
        ViewRect r_on;
        r_on.left   = 0;
        r_on.right  = width;
        r_on.top    = 0;
        r_on.bottom = height;

        EventManager__sVars.objectSpawnFunc Map__CreateObjectLists[t];
        for (u16 by = 0; by < blockHeight; by++)
        {
            for (u16 bx = 0; bx < blockWidth; bx++)
            {
                EventManager__sVars.objectSpawnFunc3(work, bx, by, &r_on, NULL, 0x00);
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r1, =mapCamera+0x00000100
	mov r10, r0
	ldrh r0, [r1, #0x2a]
	ldrh r1, [r1, #0x2c]
	mov r7, #0
	sub r0, r0, #1
	str r0, [sp, #8]
	sub r11, r1, #1
_0203811C:
	mov r1, #0
	mov r0, r1, lsl #8
	mov r9, r0, lsr #0x10
	ldr r2, =Map__CreateObjectLists
	ldr r4, =EventManager__sVars
	ldr r0, [r2, r7, lsl #2]
	str r1, [sp, #0xc]
	str r0, [r4, #0x14]
	ldr r0, [sp, #8]
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r11, [sp, #0x18]
	cmp r9, r11, asr #8
	bgt _020381C4
	mov r6, r1
	add r5, sp, #0xc
_0203815C:
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x14]
	mov r0, r0, lsl #8
	mov r8, r0, lsr #0x10
	cmp r8, r1, asr #8
	bgt _020381AC
_02038174:
	ldr ip, [r4, #0x14]
	str r6, [sp]
	mov r0, r10
	mov r1, r8
	mov r2, r9
	mov r3, r5
	str r6, [sp, #4]
	blx ip
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	ldr r1, [sp, #0x14]
	mov r8, r0, lsr #0x10
	cmp r8, r1, asr #8
	ble _02038174
_020381AC:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	ldr r1, [sp, #0x18]
	mov r9, r0, lsr #0x10
	cmp r9, r1, asr #8
	ble _0203815C
_020381C4:
	add r0, r7, #1
	and r7, r0, #0xff
	cmp r7, #3
	blo _0203811C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EventManager__CreateEventsInRect(EventManager *work, s32 id, s32 flags){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r4, =mapCamera
	mov r3, #0x70
	mla r3, r1, r3, r4
	mov r1, r3
	ldr r5, [r3, #8]
	str r3, [sp, #0x14]
	ldr r3, [r1, #0x28]
	mov r1, #0xc0
	mla r4, r3, r1, r5
	ldr r1, [sp, #0x14]
	mov r6, r5, asr #0xc
	ldr r3, [r1, #4]
	ldr r1, [r1, #0x24]
	mov r7, r3, asr #0xc
	add r1, r3, r1, lsl #8
	mov r5, r1, asr #0xc
	mov r3, r4, asr #0xc
	ldr r1, =mapCamera+0x00000100
	str r7, [sp, #0x20]
	str r6, [sp, #0x24]
	str r5, [sp, #0x28]
	str r3, [sp, #0x2c]
	ldrh r3, [r1, #0x2a]
	mov r10, r0
	ldrh r1, [r1, #0x2c]
	sub r0, r3, #1
	str r0, [sp, #0xc]
	sub r0, r1, #1
	str r0, [sp, #8]
	mov r0, #0
	mov r9, r2
	str r0, [sp, #0x18]
_02038270:
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x14]
	ldr r0, [r0, #8]
	ldr r4, [r1, #0x28]
	mov r3, #0xc0
	mla r5, r4, r3, r0
	ldr r3, [sp, #0x14]
	ldr r2, =gm_evemgr_create_size_tbl
	ldr r1, [sp, #0x18]
	ldr r6, [r3, #4]
	ldr r2, [r2, r1, lsl #2]
	ldr r4, [r3, #0x24]
	ldrh r2, [r2, #0]
	add r4, r6, r4, lsl #8
	ldr r1, =Map__CreateObjectLists
	rsb r3, r2, r6, asr #12
	rsb r0, r2, r0, asr #12
	add r8, r2, r4, asr #12
	add r2, r2, r5, asr #12
	str r2, [sp, #0x10]
	ldr r2, [sp, #0x18]
	cmp r3, #0
	ldr r2, [r1, r2, lsl #2]
	ldr r1, =EventManager__sVars
	str r3, [sp, #0x30]
	str r2, [r1, #8]
	ldr r1, [sp, #0x10]
	movle r3, #0
	str r1, [sp, #0x3c]
	ldr r1, [sp, #0xc]
	str r0, [sp, #0x34]
	cmp r0, #0
	movle r0, #0
	mov r0, r0, lsl #8
	str r8, [sp, #0x38]
	cmp r8, r1
	movge r8, r1
	ldr r2, [sp, #0x10]
	ldr r1, [sp, #8]
	mov r7, r0, lsr #0x10
	cmp r2, r1
	strge r1, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r7, r0, asr #8
	bgt _02038398
	mov r0, r3, asr #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r4, =EventManager__sVars
	str r0, [sp, #0x1c]
	add r5, sp, #0x20
	add r11, sp, #0x30
_02038340:
	ldr r6, [sp, #0x1c]
	mov r0, r6
	cmp r0, r8, asr #8
	bgt _02038380
_02038350:
	ldr ip, [r4, #8]
	mov r0, r10
	mov r1, r6
	mov r2, r7
	mov r3, r11
	stmia sp, {r5, r9}
	blx ip
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, r8, asr #8
	ble _02038350
_02038380:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldr r0, [sp, #0x10]
	cmp r7, r0, asr #8
	ble _02038340
_02038398:
	ldr r0, [sp, #0x18]
	add r0, r0, #1
	and r0, r0, #0xff
	str r0, [sp, #0x18]
	cmp r0, #3
	blo _02038270
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EventManager__CreateEventLCD(EventManager *work, s32 id, s32 flags){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r1, =mapCamera+0x00000100
	mov r10, r0
	mov r9, r2
	ldrh r4, [r1, #0x2a]
	ldrh r5, [r1, #0x2c]
	bl MapSys__GetCameraA
	str r0, [sp, #0x14]
	ldr r0, [r0, #4]
	mov r1, #0x1d0
	mov r0, r0, asr #0xc
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x14]
	ldr r2, [r0, #8]
	sub r0, r4, #1
	str r0, [sp, #0xc]
	mov r0, r2, asr #0xc
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	ldr r3, [r0, #4]
	ldr r2, [r0, #0x24]
	sub r0, r5, #1
	str r0, [sp, #8]
	add r0, r3, r2, lsl #8
	mov r0, r0, asr #0xc
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x14]
	ldr r3, [r0, #8]
	ldr r2, [r0, #0x28]
	mov r0, #0
	str r0, [sp, #0x18]
	mla r0, r2, r1, r3
	mov r0, r0, asr #0xc
	str r0, [sp, #0x2c]
_02038458:
	ldr r1, =gm_evemgr_create_size_tbl
	ldr r0, [sp, #0x18]
	ldr r4, =Map__CreateObjectLists
	ldr r1, [r1, r0, lsl #2]
	ldr r0, [sp, #0x14]
	ldrh r2, [r1, #0]
	ldr r3, [r0, #4]
	ldr r1, [sp, #0x18]
	rsb r3, r2, r3, asr #12
	ldr r1, [r4, r1, lsl #2]
	ldr r4, [sp, #0x14]
	str r3, [sp, #0x30]
	ldr r4, [r4, #8]
	ldr r6, =EventManager__sVars
	rsb r4, r2, r4, asr #12
	ldr r5, [sp, #0x14]
	str r4, [sp, #0x34]
	ldr r7, [r5, #4]
	ldr r5, [r5, #0x24]
	str r1, [r6, #0x10]
	add r1, r7, r5, lsl #8
	add r8, r2, r1, asr #12
	ldr r1, [sp, #0x14]
	str r8, [sp, #0x38]
	ldr r5, [r1, #8]
	ldr r1, [r1, #0x28]
	mov r0, #0x1d0
	mla r0, r1, r0, r5
	add r0, r2, r0, asr #12
	str r0, [sp, #0x10]
	str r0, [sp, #0x3c]
	cmp r3, #0
	movle r3, #0
	cmp r4, #0
	ldr r0, [sp, #0xc]
	movle r4, #0
	cmp r8, r0
	movge r8, r0
	ldr r1, [sp, #0x10]
	ldr r0, [sp, #8]
	cmp r1, r0
	strge r0, [sp, #0x10]
	mov r0, r4, lsl #8
	mov r7, r0, lsr #0x10
	ldr r0, [sp, #0x10]
	cmp r7, r0, asr #8
	bgt _02038588
	mov r0, r3, asr #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r4, =EventManager__sVars
	str r0, [sp, #0x1c]
	add r5, sp, #0x20
	add r11, sp, #0x30
_02038530:
	ldr r6, [sp, #0x1c]
	mov r0, r6
	cmp r0, r8, asr #8
	bgt _02038570
_02038540:
	ldr ip, [r4, #0x10]
	mov r0, r10
	mov r1, r6
	mov r2, r7
	mov r3, r11
	stmia sp, {r5, r9}
	blx ip
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, r8, asr #8
	ble _02038540
_02038570:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldr r0, [sp, #0x10]
	cmp r7, r0, asr #8
	ble _02038530
_02038588:
	ldr r0, [sp, #0x18]
	add r0, r0, #1
	and r0, r0, #0xff
	str r0, [sp, #0x18]
	cmp r0, #3
	blo _02038458
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EventManager__CreateStageObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r0, =mapCamera+0x00000100
	mov r10, r1
	ldrh r0, [r0, #0x2a]
	mov r9, r2
	ldr r11, =EventManager__sVars
	sub r0, r0, #1
	mov r0, r0, asr #8
	add r0, r0, #1
	mla r0, r9, r0, r10
	ldr r2, [r11, #0x20]
	mov r0, r0, lsl #0x10
	add r0, r2, r0, lsr #14
	ldr r1, [r0, #4]
	ldr r7, [sp, #0x38]
	ldrh r0, [r2, r1]
	mov r8, r3
	str r0, [sp, #0x10]
	add r0, r2, r1
	add r4, r0, #2
	ldr r0, [sp, #0x10]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0xc]
	addls sp, sp, #0x14
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x3c]
	and r0, r1, #8
	str r0, [sp, #8]
	and r0, r1, #1
	str r0, [sp, #4]
	and r0, r1, #4
	str r0, [sp]
_02038640:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _02038658
	ldrh r0, [r4, #4]
	tst r0, #0x4000
	beq _020387BC
_02038658:
	ldrb r0, [r4, #0]
	cmp r0, #0xff
	beq _020387BC
	add r5, r0, r10, lsl #8
	ldr r0, [sp, #4]
	ldrh r1, [r4, #2]
	cmp r0, #0
	ldrb r0, [r4, #1]
	add r6, r0, r9, lsl #8
	ldr r0, =GameObject__ViewOffsetTable
	ldrb r0, [r0, r1]
	beq _020386C8
	ldr r1, [r8, #0]
	add r1, r1, r0
	cmp r5, r1
	blt _020387BC
	ldr r1, [r8, #8]
	sub r1, r1, r0
	cmp r5, r1
	bgt _020387BC
	ldr r1, [r8, #4]
	add r1, r1, r0
	cmp r6, r1
	blt _020387BC
	ldr r1, [r8, #0xc]
	sub r1, r1, r0
	cmp r6, r1
	bgt _020387BC
_020386C8:
	ldr r1, [sp]
	cmp r1, #0
	beq _02038778
	ldrh r2, [r11, #2]
	mov r1, #3
	sub r0, r2, r0
	bl FX_DivS32
	ldr r1, [r7, #0]
	sub r0, r1, r0
	cmp r5, r0
	ble _02038778
	ldrh r2, [r4, #2]
	ldr r0, =GameObject__ViewOffsetTable
	ldrh r3, [r11, #2]
	ldrb r0, [r0, r2]
	mov r1, #3
	sub r0, r3, r0
	bl FX_DivS32
	ldr r1, [r7, #8]
	add r0, r1, r0
	cmp r5, r0
	bge _02038778
	ldrh r2, [r4, #2]
	ldr r0, =GameObject__ViewOffsetTable
	ldrh r3, [r11, #2]
	ldrb r0, [r0, r2]
	mov r1, #3
	sub r0, r3, r0
	bl FX_DivS32
	ldr r1, [r7, #4]
	sub r0, r1, r0
	cmp r6, r0
	ble _02038778
	ldrh r2, [r4, #2]
	ldr r0, =GameObject__ViewOffsetTable
	ldrh r3, [r11, #2]
	ldrb r0, [r0, r2]
	mov r1, #3
	sub r0, r3, r0
	bl FX_DivS32
	ldr r1, [r7, #0xc]
	add r0, r1, r0
	cmp r6, r0
	blt _020387BC
_02038778:
	ldrh r1, [r4, #2]
	ldr r0, =0x0000015E
	cmp r1, r0
	bhs _020387BC
	ldr r0, =stageObjectSpawnList
	ldr r5, [r0, r1, lsl #2]
	cmp r5, #0
	beq _020387BC
	ldrb r1, [r4, #0]
	ldrb r2, [r4, #1]
	mov r0, r4
	add r1, r1, r10, lsl #8
	add r2, r2, r9, lsl #8
	mov r3, #0
	mov r1, r1, lsl #0xc
	mov r2, r2, lsl #0xc
	blx r5
_020387BC:
	ldr r0, [sp, #0xc]
	add r4, r4, #0xc
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x10]
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #0xc]
	bhi _02038640
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EventManager__CreateRingObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r0, =mapCamera+0x00000100
	mov r9, r1
	ldrh r0, [r0, #0x2a]
	ldr r4, =EventManager__sVars
	mov r8, r2
	sub r0, r0, #1
	mov r0, r0, asr #8
	add r0, r0, #1
	mla r0, r8, r0, r9
	ldr r1, [r4, #0x24]
	mov r0, r0, lsl #0x10
	add r0, r1, r0, lsr #14
	ldr r0, [r0, #4]
	mov r7, r3
	ldrh r5, [r1, r0]
	add r0, r1, r0
	add r4, r0, #2
	mov r6, #0
	cmp r5, #0
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r10, r6
_02038854:
	ldrb r1, [r4, #0]
	cmp r1, #0xff
	beq _020388B8
	ldrb r0, [r4, #1]
	ldr r2, [r7, #0]
	add ip, r1, r9, lsl #8
	cmp ip, r2
	add r3, r0, r8, lsl #8
	blt _020388B8
	ldr r2, [r7, #8]
	cmp ip, r2
	bgt _020388B8
	ldr r2, [r7, #4]
	cmp r3, r2
	blt _020388B8
	ldr r2, [r7, #0xc]
	cmp r3, r2
	bgt _020388B8
	mov r2, r3
	add r1, r1, r9, lsl #8
	mov r0, r4
	mov r3, r10
	mov r1, r1, lsl #0xc
	mov r2, r2, lsl #0xc
	bl CreateStageRing3D
_020388B8:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	add r4, r4, #2
	mov r6, r0, lsr #0x10
	bhi _02038854
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EventManager__CreateDecorObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r0, =mapCamera+0x00000100
	mov r8, r1
	ldrh r0, [r0, #0x2a]
	mov r7, r2
	ldr r5, [sp, #0x30]
	sub r0, r0, #1
	mov r0, r0, asr #8
	add r0, r0, #1
	mla r1, r7, r0, r8
	ldr r0, =EventManager__sVars
	mov r6, r3
	ldr r2, [r0, #0x28]
	mov r0, r1, lsl #0x10
	add r0, r2, r0, lsr #14
	ldr r1, [r0, #4]
	mov r11, #0
	ldrh r0, [r2, r1]
	str r0, [sp, #8]
	add r0, r2, r1
	add r4, r0, #2
	ldr r0, [sp, #8]
	cmp r0, #0
	addls sp, sp, #0xc
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x34]
	and r0, r1, #1
	str r0, [sp, #4]
	and r0, r1, #4
	str r0, [sp]
_02038958:
	ldrb lr, [r4]
	cmp lr, #0xff
	beq _02038A58
	ldr r0, [sp, #4]
	ldrh r9, [r4, #2]
	cmp r0, #0
	ldrb r0, [r4, #1]
	ldr r1, =GameDecoration__ViewOffsetTable
	add r3, lr, r8, lsl #8
	add ip, r0, r7, lsl #8
	ldrb r10, [r1, r9]
	beq _020389C8
	ldr r1, [r6, #0]
	add r1, r1, r10
	cmp r3, r1
	blt _02038A58
	ldr r1, [r6, #8]
	sub r1, r1, r10
	cmp r3, r1
	bgt _02038A58
	ldr r1, [r6, #4]
	add r1, r1, r10
	cmp ip, r1
	blt _02038A58
	ldr r1, [r6, #0xc]
	sub r1, r1, r10
	cmp ip, r1
	bgt _02038A58
_020389C8:
	ldr r1, [sp]
	cmp r1, #0
	beq _02038A20
	ldr r1, =EventManager__sVars
	ldrh r2, [r1, #4]
	ldr r1, [r5, #0]
	sub r2, r2, r10
	sub r1, r1, r2, asr #1
	cmp r3, r1
	ble _02038A20
	ldr r1, [r5, #8]
	add r1, r1, r2, asr #1
	cmp r3, r1
	bge _02038A20
	ldr r1, [r5, #4]
	sub r1, r1, r2, asr #1
	cmp ip, r1
	ble _02038A20
	ldr r1, [r5, #0xc]
	add r1, r1, r2, asr #1
	cmp ip, r1
	blt _02038A58
_02038A20:
	ldr r1, =0x00000131
	cmp r9, r1
	bhs _02038A58
	ldr r1, =stageDecorationSpawnList
	ldr r9, [r1, r9, lsl #2]
	cmp r9, #0
	beq _02038A58
	add r1, lr, r8, lsl #8
	add r0, r0, r7, lsl #8
	mov r2, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	mov r0, r4
	mov r3, #0
	blx r9
_02038A58:
	add r0, r11, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #8]
	add r4, r4, #4
	cmp r0, r1, lsr #16
	mov r11, r1, lsr #0x10
	bhi _02038958
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
