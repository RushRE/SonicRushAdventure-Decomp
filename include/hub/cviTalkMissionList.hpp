#ifndef RUSH_CVITALKMISSIONLIST_HPP
#define RUSH_CVITALKMISSIONLIST_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/graphics/unknown2056570.h>
#include <hub/npcTalkList.hpp>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

class CViTalkMissionList
{

public:
    // --------------------
    // VARIABLES
    // --------------------

    CViEvtCmnTalk viEvtCmnTalk;
    void *mpcFile;
    u16 missionCount;
    u16 selection;
    s32 field_4C0;
    s32 field_4C4;
    s32 field_4C8;
    s32 field_4CC;
    s32 field_4D0;
    s32 field_4D4;
    s32 field_4D8;
    s32 field_4DC;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    Unknown2056570 unknown;
    void *unknownData;
    AnimatorSprite aniMissionStatus;
    AnimatorSprite aniMissionNumBackdrop;
    AnimatorSprite aniMissionStatusBackdrop;
    AnimatorSprite aniCharacterName;
    AnimatorSprite aniCharacterCircle;
    AnimatorSprite aniCharacterPortrait;
    NpcTalkList npcTalk;
    NpcTalkListEntry *missionList;
    Thread thread;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void ViTalkMissionList__Create(s32 param);
void ViTalkMissionList__ThreadFunc(void *arg);
void ViTalkMissionList__InitDisplay(void);
void ViTalkMissionList__InitSprites(CViTalkMissionList *work);
void ViTalkMissionList__InitList(CViTalkMissionList *work);
void ViTalkMissionList__Release(CViTalkMissionList *work);
void ViTalkMissionList__ResetDisplay(CViTalkMissionList *work);
void ViTalkMissionList__ReleaseGraphics(CViTalkMissionList *work);
void ViTalkMissionList__ReleaseList(CViTalkMissionList *work);
void ViTalkMissionList__Main(void);
void ViTalkMissionList__Main_216A99C(void);
void ViTalkMissionList__Main_216AA38(void);
void ViTalkMissionList__Main_216AB10(void);
void ViTalkMissionList__Main_216AC78(void);
void ViTalkMissionList__Main_216AD1C(void);
void ViTalkMissionList__Main_216AD94(void);
void ViTalkMissionList__Func_216AE2C(void);
void ViTalkMissionList__Destructor(Task *task);
void ViTalkMissionList__DrawBackground(CViTalkMissionList *work, s32 a2);
void ViTalkMissionList__Draw(CViTalkMissionList *work);
BOOL ViTalkMissionList__ReleaseThread(CViTalkMissionList *work);
void ViTalkMissionList__Func_216B418(CViTalkMissionList *work);
void ViTalkMissionList__Func_216B448(CViTalkMissionList *work);
void ViTalkMissionList__Func_216B4C4(BOOL enabled);
void ViTalkMissionList__Func_216B518(BOOL enabled);
void ViTalkMissionList__Func_216B570(BOOL enabled);
void ViTalkMissionList__Func_216B5C4(BOOL enabled);
void ViTalkMissionList__InitWindow(CViTalkMissionList *work, s32 y);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVITALKMISSIONLIST_HPP
