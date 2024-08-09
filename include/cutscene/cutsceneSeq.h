#ifndef RUSH2_CUTSCENESEQ_H
#define RUSH2_CUTSCENESEQ_H

#include <game/system/task.h>
#include <game/cutscene/ayk.h>

// --------------------
// TYPES
// --------------------

// forward decls.
typedef struct CutsceneSeq_ CutsceneSeq;
typedef struct AYKSequence_ AYKSequence;

// types
typedef s32 (*CutsceneSeqCommandFunc1)(void *a1, CutsceneSeq *work);
typedef s32 (*CutsceneSeqCommandFunc2)(CutsceneSeq *work, AYKSequence *aykSeq, void *command);

typedef void (*CutsceneSeqOnFinish)(CutsceneSeq *work);

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct AYKSequence_
{
    s32 values[16];
    s32 data[256];
    BOOL keepAlive;
};

typedef struct Unknown2156918_
{
    void *unknown2157E58;
    void *field_4;
    void *touchFieldManager;
    void *backgroundManager;
    void *modelManager;
    void *handleManager;
    void *field_18;
} Unknown2156918;

struct CutsceneSeq_
{
    struct CutsceneSeqAYK
    {
        AYKSequence *sequences[8];
        u32 data[1024];
        AYKHeader *header;
        CutsceneSeqCommandFunc1 **funcTable;
        CutsceneSeqOnFinish onFinish;
    } ayk;

    s32 status;
    Unknown2156918 unknown2156918;
    Task *taskUnknown21531C4;
};

typedef struct CutsceneAssetSystem_
{
    Task *cutsceneSeqTask;
    CutsceneSeq *cutsceneSeqWork;
    void *ayk;
} CutsceneAssetSystem;

// --------------------
// FUNCTIONS
// --------------------

void CutsceneSeq__Create(CutsceneAssetSystem *parent, u32 priority);
void CutsceneAssetSystem__Destroy(CutsceneAssetSystem *work);
CutsceneSeq *CutsceneAssetSystem__GetCutsceneSeq(CutsceneAssetSystem *work);
void CutsceneAssetSystem__Func_2152A74(CutsceneAssetSystem *work, s32 count);
void CutsceneAssetSystem__Func_2152A8C(CutsceneAssetSystem *work, s32 count);
void CutsceneAssetSystem__Func_2152AA4(CutsceneAssetSystem *work);
void CutsceneAssetSystem__Func_2152ABC(CutsceneAssetSystem *work, s32 count);
void CutsceneAssetSystem__Func_2152AE8(CutsceneAssetSystem *work, s32 count);
void CutsceneAssetSystem__Func_2152B00(CutsceneAssetSystem *work);
void CutsceneAssetSystem__Func_2152B68(CutsceneAssetSystem *work);
void CutsceneAssetSystem__StartLoadingAYK(CutsceneAssetSystem *work, AYKHeader *ayk);
void CutsceneAssetSystem__FinishLoadingAYK(CutsceneAssetSystem *work, s32 aykUnknown2, CutsceneSeqOnFinish onFinish);
void CutsceneSeq__Destructor(Task *task);
void Task__Unknown21531C4__Destructor(Task *task);
s32 CutsceneSeq__FuncTable4__Func_2152C1C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable4__Func_2152CC0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable4__Func_2152D3C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable4__Func_2152D94(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable4__Func_2152DF0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152E54(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152E94(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152ED0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152F14(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152F50(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152F8C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152FA4(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2152FBC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153030(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_21530BC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_215315C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_215317C(void *a1, CutsceneSeq *work);
s32 Task__Unknown21531C4__Create(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_21532F0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153450(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_21535D0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_21536E4(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153734(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153780(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_21537B8(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_215383C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153980(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153A30(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153A54(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153C24(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable9__Func_2153C48(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__Func_2153C90(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__Func_2153CE8(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__Func_2153D10(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__MountArchive(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__UnmountArchive(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__Func_2153DAC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable6__Func_2153DDC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__LoadSprite(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2153EB4(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2153EDC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__LoadSprite2(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__SetAnimation(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2154014(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_215406C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_21540C0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2154114(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_215418C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_21541FC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2154240(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2154294(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_21542E4(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2154320(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_2154384(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable8__Func_21543AC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable3__LoadBBG(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable3__Func_2154494(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable3__Func_21544BC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable3__Func_2154504(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable3__Func_215455C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable3__Func_21545B0(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__LoadMDL(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154684(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_21546AC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__LoadMDL2(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__LoadAniMDL(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_215483C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_21548A8(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_21549E4(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154A50(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154ABC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154B10(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154B64(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154BF8(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__LoadDrawState(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable7__Func_2154CCC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__LoadSndArc(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__SetVolume(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__Func_2154DD8(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__LoadSndArcGroup(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__LoadSndArcSeq(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__LoadSndArcWaveArc(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__LoadSndArcSeqArc(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__PlayTrack(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__PlayTrackEx(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__PlaySequence(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__PlaySequenceEx(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__PlayVoiceClip(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__PlayVoiceClipEx(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__Func_21551CC(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__Func_2155214(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__Func_215523C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__SndCommand__Func_215528C(void *a1, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable2__Func_21552D4(void *a1, CutsceneSeq *work);
void CutsceneSeq__Main(void);
void Task__Unknown21531C4__Main(void);
void CutsceneSeq__InitAYK(CutsceneSeq *cutsceneSeq, AYKHeader *ayk, CutsceneSeqCommandFunc1 **funcTable);
void CutsceneAssetSystem__Release(CutsceneSeq *work);
BOOL CutsceneSeq__ProcessSequences(CutsceneSeq *work);
void *CutsceneSeq__InitAYKBlock(CutsceneSeq *work, CutsceneSeqOnFinish onFinish);
AYKSequence *CutsceneSeq__InitAYKSequence(CutsceneSeq *work, u32 offset);
s32 CutsceneSeq__GetAYKCommandLocation(u32 addr);
void *CutsceneSeq__GetAYKCommand_String(CutsceneSeq *work, AYKSequence *seq, u32 addr);
s32 AYKCommand__GetValue(void *command, s32 id);
const char *AYKCommand__GetPath_Internal(void *work, CutsceneSeq *seq, s32 id);
const char *AYKCommand__GetPath(void *work, CutsceneSeq *seq, s32 id);
void AYKCommand__SetValue(AYKSequence *work, u32 id, s32 value);
s32 CutsceneSeq__CallFuncTable2(CutsceneSeq *work, AYKSequence *aykSeq);
s32 *AYKSequence__GetCtrlValue(AYKSequence *work, u32 id);
s32 ovl07_2155770(u32 addr);
void *CutsceneSeq__GetAYKCommand(CutsceneSeq *work, AYKSequence *seq, u32 addr);
void AYKSequence__Func_21557FC(void *a1, s32 value);
s32 AYKSequence__Func_2155834(void *a1);
void *CutsceneSeq__GetAYKCommand_2155864(s32 a1, s32 *a2, s32 a3, CutsceneSeq *work, AYKSequence *a5);
s32 CutsceneSeq__AllocAYKSequence(CutsceneSeq *work, u32 offset);
s32 CutsceneSeq__FuncTable13__Func_21559BC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable13__Func_21559C4(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable13__Func_21559CC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_21559D4(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155A30(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155A94(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155AF8(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155B5C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155BDC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155C0C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155C3C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable19__Func_2155C6C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155CD0(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155D34(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155DA4(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155E08(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155E78(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155EDC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155F0C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155F44(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2155FA8(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_215600C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable20__Func_2156078(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable16__Func_21560E4(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable16__Func_2156150(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable16__Func_21561BC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable16__Func_2156228(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable16__Func_2156294(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable16__Func_2156300(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable12__Func_215636C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable12__Func_21563D8(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_2156444(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_215648C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_21564EC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_215654C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_21565AC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_215660C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable18__Func_215666C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable15__Func_21566CC(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable15__Func_215672C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable15__Func_21567B4(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable15__Func_2156824(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__CallFuncTable(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable14__Func_215689C(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
s32 CutsceneSeq__FuncTable14__Func_21568D8(CutsceneSeq *work, AYKSequence *aykSeq, void *command);
void CutsceneSeq__GetUnknown2157E58(void);
void CutsceneSeq__InitUnknown2156918(Unknown2156918 *work);
void CutsceneAssetSystem__Func_215693C(void);
void ovl07_215697C(void);
void Unknown__GetArchive(void);
void sub_21569A4(void);
void sub_21569CC(void);
void sub_21569E4(void);
void sub_21569FC(void);
void CutsceneSeq__MountArchive(void);
void Unknown__ReleaseArchive(void);
void sub_2156B08(void);
void sub_2156BEC(void);
void sub_2156C88(void);
void CutsceneSeq__AllocTouchField(void);
void sub_2156E2C(void);
void AnimatorManager__GetAnimator(void);
void sub_2156E54(void);
void sub_2156E70(void);
void CutsceneSeq__LoadSpriteFromAYK2(void);
void CutsceneSeq__LoadSpriteFromAYK(void);
void sub_215707C(void);
void sub_21570F4(void);
void sub_2157128(void);
void ovl07_2157150(void);
void sub_215715C(void);
void sub_2157174(void);
void sub_215718C(void);
void sub_21571A4(void);
void CutsceneSeq__LoadBBGFromAYK(void);
void sub_2157430(void);
void sub_2157454(void);
void sub_2157460(void);
void sub_215746C(void);
s32 CutsceneSeq__FuncTable3__LoadMDL(void *a1, CutsceneSeq *work);
void CutsceneSeq__LoadMDLFromAYK(void);
s32 CutsceneSeq__FuncTable7__LoadAniMDLFromAYK(void *a1, CutsceneSeq *work);
void sub_2157738(void);
void sub_215793C(void);
void CutsceneSeq__LoadBSD(void);
void sub_2157A0C(void);
void ovl07_2157A34(void);
void CutsceneAssetSystem__Func_2157A40(void);
void CutsceneSeq__Func_2157A70(Unknown2156918 *work);
NNSSndHandle *Unknown__GetSndHandle(Unknown2156918 *work, s32 id);
s32 Unknown__GetAvailSoundHandle(Unknown2156918 *work);
void sub_2157B08(Unknown2156918 *work);
void sub_2157B2C(void);
void ovl07_2157B70(void);
void G3dRenderObjCallback_2157B7C(void);
void G3dRenderObjCallback_2157C28(void);
void sub_2157D6C(void);
void CutsceneSeq__CreateUnknown2157E58(void);
void CutsceneAssetSystem__Func_2157E74(void);
void CutsceneSeq__Func_2157E90(Unknown2156918 *work);
void sub_2157EAC(void);
void sub_2157F0C(void);
void CutsceneAssetSystem__Func_2157F84(void);
void CutsceneSeq__Func_2158014(Unknown2156918 *work);
void sub_2158088(void);
void sub_21580E0(void);
void CutsceneAssetSystem__Func_2158138(void);
void CutsceneSeq__Func_21581B0(Unknown2156918 *work);
void Unknown__AllocBackgroundManager(void);
void sub_21582F4(void);
void CutsceneAssetSystem__Func_2158328(void);
void CutsceneSeq__Func_2158378(Unknown2156918 *work);
void Unknown__AllocModelManager(void);
void sub_215858C(void);
void CutsceneAssetSystem__Func_215867C(void);
void CutsceneSeq__Func_2158714(Unknown2156918 *work);
void sub_2158828(void);
void sub_21588A8(void);
void CutsceneAssetSystem__Func_21588DC(void);
void CutsceneSeq__Func_2158950(Unknown2156918 *work);
void CutsceneAssetSystem__Func_21589AC(void);
void CutsceneAssetSystem__Func_21589F8(void);
void CutsceneSeq__Func_2158A4C(Unknown2156918 *work);
void sub_2158A6C(void);
void sub_2158D3C(void);
void sub_215902C(void);
void sub_2159188(void);
u32 sub_2159204(s32 a1);
void CutsceneSeq__InitUnknown2157E58(void);
void CutsceneSeq__ProcessUnknown2157E58(void);
void sub_21593A4(void);
void sub_21595C4(void);
void sub_215965C(void);
void sub_215967C(void);
void CutsceneAssetSystem__Func_2159718(void);
void CutsceneAssetSystem__Func_2159750(void);
void CutsceneAssetSystem__Func_215984C(void);
void CutsceneAssetSystem__Func_21598A4(void);
s32 CutsceneSeq__FuncTable10__LoadFontFile(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159B14(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__LoadMPCFile(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__SetMsgSeq(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159C68(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159C88(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159CA8(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159CC8(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159CD8(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159CE8(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159D08(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159D40(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159D70(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159D84(void *a1, void *a2, CutsceneSeq *work);
s32 CutsceneSeq__FuncTable10__Func_2159DB4(void *a1, void *a2, CutsceneSeq *work);
void CutsceneAssetSystem__Create(void);
void CutsceneAssetSystem__Func_2159E28(Task *task);
void CutsceneAssetSystem__Destructor(Task *task);
void CutsceneAssetSystem__OnCutsceneFinish(CutsceneSeq *work);
s32 CutsceneAssetSystem__GetCutsceneID(void);
s32 CutsceneAssetSystem__GetNextSysEvent(void);
void CutsceneAssetSystem__Func_215A080(CutsceneSeq *work);
void CutsceneAssetSystem__Func_215A0B0(CutsceneSeq *work);
void CutsceneAssetSystem__Main(void);
void CutsceneAssetSystem__NextSysEvent(void);
void CutsceneAssetSystem__Func_215A124(void);
void CutsceneAssetSystem__Func_215A248(void);
void CutsceneAssetSystem__Func_215A2F0(void);
void CutsceneAssetSystem__Func_215A374(void);
void CutsceneAssetSystem__Func_215A490(void);
void CutsceneAssetSystem__Func_215A640(void);
void CutsceneAssetSystem__Func_215A738(void);
void CutsceneAssetSystem__Func_215A788(void);
void CutsceneAssetSystem__Func_215A9A8(void);
void CutsceneAssetSystem__Func_215AB20(void);
void CutsceneAssetSystem__Func_215ADA0(void);
void CutsceneAssetSystem__Func_215AE54(void);
void CutsceneAssetSystem__Func_215AF60(void);
void CutsceneAssetSystem__Func_215B094(void);
void CutsceneAssetSystem__Func_215B108(void);
void CutsceneAssetSystem__Func_215B158(void);
void CutsceneAssetSystem__Func_215B170(void);
void CutsceneAssetSystem__Func_215B180(void);

#endif // RUSH2_CUTSCENESEQ_H
