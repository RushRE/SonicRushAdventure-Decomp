#ifndef RUSH_STAGECLEAR_H
#define RUSH_STAGECLEAR_H

#include <game/system/task.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void StageClear__Create(void);
NOT_DECOMPILED void StageClear__Destructor(Task *task);
NOT_DECOMPILED void StageClear__InitComponents(void);
NOT_DECOMPILED void StageClear__Destroy(void);
NOT_DECOMPILED void StageClear__Func_2156E34(void);
NOT_DECOMPILED void StageClear__StartFadeOut(void);
NOT_DECOMPILED void StageClear__LoadAssets(void);
NOT_DECOMPILED void StageClear__LoadFiles(void *archive, ...);
NOT_DECOMPILED void StageClear__ReleaseAssets(void);

NOT_DECOMPILED void StageClearPlayer__Create(void);
NOT_DECOMPILED void StageClearPlayer__Destroy(void);
NOT_DECOMPILED void StageClearPlayer__Func_21572C8(void);
NOT_DECOMPILED void StageClearPlayer__Func_2157300(void);

NOT_DECOMPILED void StageClearHeader__Create(void);
NOT_DECOMPILED void StageClearHeader__Destroy(void);

NOT_DECOMPILED void StageClearStageScoreTally__Create(void);
NOT_DECOMPILED void StageClearStageScoreTally__Destroy(void);
NOT_DECOMPILED void StageClearStageScoreTally__Func_2157958(void);
NOT_DECOMPILED void StageClearStageScoreTally__Destructor(Task *task);
NOT_DECOMPILED void StageClearTAScoreTally__Create(void);
NOT_DECOMPILED void StageClearTAScoreTally__Destroy(void);
NOT_DECOMPILED void StageClearStageScoreTally__Func_2157CD8(void);
NOT_DECOMPILED void StageClearStageScoreTally__MoverCallback_Total(void);

NOT_DECOMPILED void StageClearStageRank__Create(void);
NOT_DECOMPILED void StageClearStageRank__Destroy(void);
NOT_DECOMPILED void StageClearTARank__Create(void);
NOT_DECOMPILED void StageClearTARank__Destroy(void);
NOT_DECOMPILED void StageClearStageRank__Destructor(Task *task);

NOT_DECOMPILED void StageClear__PlayRankVoiceClip(void);
NOT_DECOMPILED void StageClear__PlayRankGetSfx(void);
NOT_DECOMPILED void StageClear__GetRankAnim(void);

NOT_DECOMPILED void StageClearBackground__Init(void);
NOT_DECOMPILED void StageClearBackground__Destroy(void);

NOT_DECOMPILED void StageClearMaterialReward__Create(void);
NOT_DECOMPILED void StageClearMaterialReward__Destroy(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Func_21588D4(void);

NOT_DECOMPILED void Task__OVL03Unknown215896C__Create(void);

NOT_DECOMPILED void StageClear__Func_2158A48(void);
NOT_DECOMPILED void StageClear__GetMaterialAnim(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Func_2158A8C(void);
NOT_DECOMPILED void StageClear__GiveMaterial(void);

NOT_DECOMPILED void StageClearTimeAttackRankList__Create(void);
NOT_DECOMPILED void StageClearTimeAttackRankList__Destroy(void);

NOT_DECOMPILED void Task__Unknown2158C6C__LoadAssets(void);
NOT_DECOMPILED void Task__Unknown2158C6C__ReleaseAssets(void);
NOT_DECOMPILED void Task__OVL03Unknown2158C6C__Create(void);
NOT_DECOMPILED void StageClear__GetTimeAttackStageID(void);
NOT_DECOMPILED void StageClear__Func_2158CD8(void);
NOT_DECOMPILED void StageClear__Func_2158CE8(void);
NOT_DECOMPILED void StageClear__Func_2158D54(void);

NOT_DECOMPILED void StageClearMover__Create(void);
NOT_DECOMPILED void StageClearMover__Destructor(Task *task);
NOT_DECOMPILED void StageClearHeader__MoverCallback(void);
NOT_DECOMPILED void StageClearStageScoreTally__MoverCallback_Bonus(void);
NOT_DECOMPILED void StageClear__Func_2158F14(void);
NOT_DECOMPILED void StageClear__Func_2158FAC(void);
NOT_DECOMPILED void StageClear__Func_2159068(void);
NOT_DECOMPILED void StageClear__Func_215908C(void);
NOT_DECOMPILED void StageClear__Func_21590C0(void);
NOT_DECOMPILED void StageClear__Func_21590CC(void);
NOT_DECOMPILED void StageClear__Func_2159288(void);
NOT_DECOMPILED void StageClear__GetTrickBonus(void);
NOT_DECOMPILED void StageClear__GetTimeBonus(void);
NOT_DECOMPILED void StageClear__GetRingBonus(void);
NOT_DECOMPILED void StageClear__IsTimeAttack(void);

NOT_DECOMPILED void StageClearMissionClearText__Create(void);
NOT_DECOMPILED void StageClearMissionClearText__Destroy(void);
NOT_DECOMPILED void StageClearMissionClearText__Func_215950C(void);
NOT_DECOMPILED void StageClearMissionClearText__Destructor(Task *task);

NOT_DECOMPILED void StageClear__IsMissionMode(void);
NOT_DECOMPILED void StageClear__Main(void);
NOT_DECOMPILED void StageClear__Main_2159608(void);
NOT_DECOMPILED void StageClearPlayer__Main1(void);
NOT_DECOMPILED void StageClearPlayer__Main2(void);
NOT_DECOMPILED void StageClearHeader__Main1(void);
NOT_DECOMPILED void StageClearHeader__Main2(void);
NOT_DECOMPILED void StageClearStageScoreTally__Main1(void);
NOT_DECOMPILED void StageClearStageScoreTally__Main2(void);
NOT_DECOMPILED void StageClearStageScoreTally__Main3(void);
NOT_DECOMPILED void StageClearStageScoreTally__Main4(void);
NOT_DECOMPILED void StageClearStageRank__Main(void);
NOT_DECOMPILED void StageClearStageRank__Main_Invisible(void);
NOT_DECOMPILED void StageClear__Rank__Main_Appearing(void);
NOT_DECOMPILED void StageClear__Rank__Main_RankGet(void);
NOT_DECOMPILED void StageClear__RankDisplay__Main_Appear(void);
NOT_DECOMPILED void StageClear__RankDisplay__Main_Idle(void);
NOT_DECOMPILED void StageClearMaterialRewardFX__Create(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Main_215A014(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Main_215A070(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Main_215A15C(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Main_215A1C8(void);
NOT_DECOMPILED void StageClear__MaterialRewardFX__Main_215A20C(void);
NOT_DECOMPILED void Task__OVL03Unknown215896C__Main(void);
NOT_DECOMPILED void StageClearMaterialRewardFX__Main2(void);
NOT_DECOMPILED void StageClearMaterialRewardFX__Main1(void);
NOT_DECOMPILED void StageClearTimeAttackRankList__Main(void);
NOT_DECOMPILED void StageClearTimeAttackRankList__Main_215A5C4(void);
NOT_DECOMPILED void StageClearTimeAttackRankList__Main_215A61C(void);
NOT_DECOMPILED void Task__OVL03Unknown2158C6C__Main(void);
NOT_DECOMPILED void Task__Unknown2158C6C__Main_215A748(void);
NOT_DECOMPILED void StageClearMissionClearText__Main1(void);
NOT_DECOMPILED void StageClearMissionClearText__Main_215A84C(void);
NOT_DECOMPILED void StageClearMissionClearText__Main2(void);
NOT_DECOMPILED void StageClearMover__Main(void);

#endif // RUSH_STAGECLEAR_H