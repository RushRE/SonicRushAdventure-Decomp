// --------------------
// VARIABLES
// --------------------

// ---------- COMMON ----------
static const GMS_GAMEDAT_LOAD_DATA assetList_CommonAct[2] = { { "/narc/player_lz7.narc", LoadAlloc_FromHead, NULL, PostLoad_InitPlayerArchive },
                                                              { "/narc/act_com_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitCommonArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_CommonBoss[2] = { { "/narc/player_lz7.narc", LoadAlloc_FromHead, NULL, PostLoad_InitPlayerArchive },
                                                               { "/narc/act_com_b_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitCommonArchive } };

static const GMS_GAMEDAT_LOAD_INFO assetList_Common[2] = { { assetList_CommonAct, ARRAY_COUNT(assetList_CommonAct) }, { assetList_CommonBoss, ARRAY_COUNT(assetList_CommonBoss) } };

// ---------- STAGE ----------

// ZONE 1

static const GMS_GAMEDAT_LOAD_DATA assetList_Z11[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z11_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z11_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z11.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z12[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z12_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z12_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z12_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z12/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z1T[STAGE_FILE_COUNT] = { { "/narc/z1t_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z1t_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z1t_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z11.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z1t/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z1B[8] = { { "/narc/z1boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                        { "/narc/z1boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                        { "/narc/z1boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                        { "/narc/z1boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                        { "/bg/z1boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                        { "/snd/z1b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                        { "/mod/boss1_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ1 },
                                                        { "/mod/boss1_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ1 } };

// ZONE 2
static const GMS_GAMEDAT_LOAD_DATA assetList_Z21[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z21_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z21_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z22[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z22_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z22_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z22_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z22/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z2B[14] = { { "/narc/z2boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                         { "/narc/z2boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                         { "/narc/z2boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                         { "/narc/z2boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                         { "/bg/z2boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                         { "/snd/z2b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                         { "/mod/boss2_body_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_arm_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_drop_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_ball_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_spike_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_zako_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_stage_00_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 },
                                                         { "/mod/boss2_stage_01_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ2 } };
// ZONE 3

static const GMS_GAMEDAT_LOAD_DATA assetList_Z31[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z31_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z31_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z32[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z32_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z32_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z32_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z32/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z91[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z91_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z91_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z3B[11] = { { "/narc/z3boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                         { "/narc/z3boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                         { "/narc/z3boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                         { "/narc/z3boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                         { "/bg/z3boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                         { "/snd/z3b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                         { "/mod/boss3_body_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                         { "/mod/boss3_stage_00_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                         { "/mod/boss3_stage_01_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                         { "/mod/boss3_stage_02_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 },
                                                         { "/mod/boss3_stage_03_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ3 } };

// ZONE 4

static const GMS_GAMEDAT_LOAD_DATA assetList_Z41[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z41_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z41_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z41_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z41/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z42[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z42_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z42_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z42_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z42/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z4B[9] = { { "/narc/z4boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                        { "/narc/z4boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                        { "/narc/z4boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                        { "/narc/z4boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                        { "/bg/z4boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                        { "/snd/z4b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                        { "/mod/boss4_body_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ4 },
                                                        { "/mod/boss4_core_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ4 },
                                                        { "/mod/boss4_stage_lz7.nsbmd", LoadAlloc_FromHead, NULL, PostLoad_InitBossAssetsZ4 } };

// ZONE 5

static const GMS_GAMEDAT_LOAD_DATA assetList_Z51[STAGE_FILE_COUNT] = { { "/narc/z51_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z51_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z51_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z51_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z51/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z52[STAGE_FILE_COUNT] = { { "/narc/z52_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z52_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z52_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z52_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z52/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z5B[10] = { { "/narc/z5boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                         { "/narc/z5boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                         { "/narc/z5boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                         { "/narc/z5boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                         { "/bg/z5boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                         { "/snd/z5b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                         { "/mod/boss5_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 },
                                                         { "/mod/boss5_core_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 },
                                                         { "/mod/boss5_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 },
                                                         { "/mod/boss5_map_a_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ5 } };

// ZONE 6

static const GMS_GAMEDAT_LOAD_DATA assetList_Z61[STAGE_FILE_COUNT] = { { "/narc/z61_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z61_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z61_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z61_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z61.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z61/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z62[STAGE_FILE_COUNT] = { { "/narc/z61_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z62_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z62_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z62_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z61.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z62/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z92[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z92_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z92_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z6B[10] = { { "/narc/z6boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                         { "/narc/z6boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                         { "/narc/z6boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                         { "/narc/z6boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                         { "/bg/z6boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                         { "/snd/z6b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                         { "/mod/boss6_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 },
                                                         { "/mod/boss6_zako_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 },
                                                         { "/mod/boss6_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 },
                                                         { "/mod/boss6_sky_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ6 } };

// ZONE 7

static const GMS_GAMEDAT_LOAD_DATA assetList_Z71[STAGE_FILE_COUNT] = { { "/narc/z71_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z71_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z71_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z71_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z71.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z71/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z72[STAGE_FILE_COUNT] = { { "/narc/z71_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z72_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z72_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z72_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z71.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z72/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z7B[8] = { { "/narc/z7boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                        { "/narc/z7boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                        { "/narc/z7boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                        { "/narc/z7boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                        { "/bg/z7boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                        { "/snd/z7b/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                        { "/mod/boss7_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ7 },
                                                        { "/mod/boss7_stage_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZ7 } };

// ZONE F

static const GMS_GAMEDAT_LOAD_DATA assetList_ZFB[9] = { { "/narc/z8boss_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                        { "/narc/z8boss_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                        { "/narc/z8boss_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                        { "/narc/z8boss_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                        { "/bg/z8boss.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                        { "/snd/zfb/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveBoss, PostLoad_InitSoundArchive },
                                                        { "/mod/bossF_body_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZF },
                                                        { "/mod/bossF_arm_l_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZF },
                                                        { "/mod/bossF_arm_r_lz7.nsbmd", LoadAlloc_FromTail, NULL, PostLoad_InitBossAssetsZF } };

// ZONE 9

static const GMS_GAMEDAT_LOAD_DATA assetList_Z93[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z93_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z93_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z94[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z33_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z33_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z95[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/z94_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/z94_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z96[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zm1_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zm1_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z97[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zm2_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zm2_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z98[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zm3_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zm3_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z99[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zm4_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zm4_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z910[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm5_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm5_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z911[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm6_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm6_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z912[STAGE_FILE_COUNT] = { { "/narc/z51_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z51_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm7_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm7_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z51/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z913[STAGE_FILE_COUNT] = { { "/narc/z51_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z51_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm8_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm8_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z51.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z51/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z914[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm9_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm9_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z915[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z41_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm10_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm10_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z41/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_Z916[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                        { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                        { "/narc/zm11_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                        { "/narc/zm11_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                        { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                        { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

// ZONE VS

static const GMS_GAMEDAT_LOAD_DATA assetList_VS1[STAGE_FILE_COUNT] = { { "/narc/z11_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z11_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zv1_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zv1_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z12.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z11/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS2[STAGE_FILE_COUNT] = { { "/narc/z21_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z21_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zv2_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zv2_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z21.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z21/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS3[STAGE_FILE_COUNT] = { { "/narc/z31_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z31_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zv3_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zv3_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z31.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z31/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_VS4[STAGE_FILE_COUNT] = { { "/narc/z41_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                       { "/narc/z41_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                       { "/narc/zv4_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                       { "/narc/zv4_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                       { "/bg/z41.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                       { "/snd/z41/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

// ZONE RACE

static const GMS_GAMEDAT_LOAD_DATA assetList_R1[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                      { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                      { "/narc/zr1_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                      { "/narc/zr1_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                      { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                      { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_R2[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                      { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                      { "/narc/zr2_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                      { "/narc/zr2_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                      { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                      { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_DATA assetList_R3[STAGE_FILE_COUNT] = { { "/narc/z91_act_lz7.narc", LoadAlloc_FromTail, NULL, PostLoad_InitStageArchive },
                                                                      { "/narc/z91_raw.narc", LoadAlloc_FromTail, NULL, PostLoad_InitRawArchive },
                                                                      { "/narc/zr3_map.narc", LoadAlloc_FromTail, NULL, PostLoad_InitMapArchive },
                                                                      { "/narc/zr3_eve.narc", LoadAlloc_FromHead, NULL, PostLoad_InitEveArchive },
                                                                      { "/bg/z91.bbg", LoadAlloc_FromHead, NULL, PostLoad_InitMapFar },
                                                                      { "/snd/z91/sound_data.sdat", LoadAlloc_Snd, PreLoad_SoundArchiveZone, PostLoad_InitSoundArchive } };

static const GMS_GAMEDAT_LOAD_INFO assetList_Stage[STAGE_COUNT] = {
    [STAGE_Z11]               = { assetList_Z11, ARRAY_COUNT(assetList_Z11) },
    [STAGE_Z12]               = { assetList_Z12, ARRAY_COUNT(assetList_Z12) },
    [STAGE_TUTORIAL]          = { assetList_Z1T, ARRAY_COUNT(assetList_Z1T) },
    [STAGE_Z1B]               = { assetList_Z1B, ARRAY_COUNT(assetList_Z1B) },
    [STAGE_Z21]               = { assetList_Z21, ARRAY_COUNT(assetList_Z21) },
    [STAGE_Z22]               = { assetList_Z22, ARRAY_COUNT(assetList_Z22) },
    [STAGE_Z2B]               = { assetList_Z2B, ARRAY_COUNT(assetList_Z2B) },
    [STAGE_Z31]               = { assetList_Z31, ARRAY_COUNT(assetList_Z31) },
    [STAGE_Z32]               = { assetList_Z32, ARRAY_COUNT(assetList_Z32) },
    [STAGE_HIDDEN_ISLAND_1]   = { assetList_Z91, ARRAY_COUNT(assetList_Z91) },
    [STAGE_Z3B]               = { assetList_Z3B, ARRAY_COUNT(assetList_Z3B) },
    [STAGE_Z41]               = { assetList_Z41, ARRAY_COUNT(assetList_Z41) },
    [STAGE_Z42]               = { assetList_Z42, ARRAY_COUNT(assetList_Z42) },
    [STAGE_Z4B]               = { assetList_Z4B, ARRAY_COUNT(assetList_Z4B) },
    [STAGE_Z51]               = { assetList_Z51, ARRAY_COUNT(assetList_Z51) },
    [STAGE_Z52]               = { assetList_Z52, ARRAY_COUNT(assetList_Z52) },
    [STAGE_Z5B]               = { assetList_Z5B, ARRAY_COUNT(assetList_Z5B) },
    [STAGE_Z61]               = { assetList_Z61, ARRAY_COUNT(assetList_Z61) },
    [STAGE_Z62]               = { assetList_Z62, ARRAY_COUNT(assetList_Z62) },
    [STAGE_HIDDEN_ISLAND_2]   = { assetList_Z92, ARRAY_COUNT(assetList_Z92) },
    [STAGE_Z6B]               = { assetList_Z6B, ARRAY_COUNT(assetList_Z6B) },
    [STAGE_Z71]               = { assetList_Z71, ARRAY_COUNT(assetList_Z71) },
    [STAGE_Z72]               = { assetList_Z72, ARRAY_COUNT(assetList_Z72) },
    [STAGE_Z7B]               = { assetList_Z7B, ARRAY_COUNT(assetList_Z7B) },
    [STAGE_BOSS_FINAL]        = { assetList_ZFB, ARRAY_COUNT(assetList_ZFB) },
    [STAGE_HIDDEN_ISLAND_3]   = { assetList_Z93, ARRAY_COUNT(assetList_Z93) },
    [STAGE_HIDDEN_ISLAND_4]   = { assetList_Z94, ARRAY_COUNT(assetList_Z94) },
    [STAGE_HIDDEN_ISLAND_5]   = { assetList_Z95, ARRAY_COUNT(assetList_Z95) },
    [STAGE_HIDDEN_ISLAND_6]   = { assetList_Z96, ARRAY_COUNT(assetList_Z96) },
    [STAGE_HIDDEN_ISLAND_7]   = { assetList_Z97, ARRAY_COUNT(assetList_Z97) },
    [STAGE_HIDDEN_ISLAND_8]   = { assetList_Z98, ARRAY_COUNT(assetList_Z98) },
    [STAGE_HIDDEN_ISLAND_9]   = { assetList_Z99, ARRAY_COUNT(assetList_Z99) },
    [STAGE_HIDDEN_ISLAND_10]  = { assetList_Z910, ARRAY_COUNT(assetList_Z910) },
    [STAGE_HIDDEN_ISLAND_11]  = { assetList_Z911, ARRAY_COUNT(assetList_Z911) },
    [STAGE_HIDDEN_ISLAND_12]  = { assetList_Z912, ARRAY_COUNT(assetList_Z912) },
    [STAGE_HIDDEN_ISLAND_13]  = { assetList_Z913, ARRAY_COUNT(assetList_Z913) },
    [STAGE_HIDDEN_ISLAND_14]  = { assetList_Z914, ARRAY_COUNT(assetList_Z914) },
    [STAGE_HIDDEN_ISLAND_15]  = { assetList_Z915, ARRAY_COUNT(assetList_Z915) },
    [STAGE_HIDDEN_ISLAND_16]  = { assetList_Z916, ARRAY_COUNT(assetList_Z916) },
    [STAGE_HIDDEN_ISLAND_VS1] = { assetList_VS1, ARRAY_COUNT(assetList_VS1) },
    [STAGE_HIDDEN_ISLAND_VS2] = { assetList_VS2, ARRAY_COUNT(assetList_VS2) },
    [STAGE_HIDDEN_ISLAND_VS3] = { assetList_VS3, ARRAY_COUNT(assetList_VS3) },
    [STAGE_HIDDEN_ISLAND_VS4] = { assetList_VS4, ARRAY_COUNT(assetList_VS4) },
    [STAGE_HIDDEN_ISLAND_R1]  = { assetList_R1, ARRAY_COUNT(assetList_R1) },
    [STAGE_HIDDEN_ISLAND_R2]  = { assetList_R2, ARRAY_COUNT(assetList_R2) },
    [STAGE_HIDDEN_ISLAND_R3]  = { assetList_R3, ARRAY_COUNT(assetList_R3) },
};