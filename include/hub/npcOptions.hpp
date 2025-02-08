#ifndef RUSH_NPCOPTIONS_HPP
#define RUSH_NPCOPTIONS_HPP

#include <game/system/task.h>
#include <game/system/threadWorker.h>
#include <hub/cviEvtCmn.hpp>

// --------------------
// STRUCTS
// --------------------

class NpcOptions
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    CViEvtCmnTalk viEvtCmnTalk;
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

// NpcOptions
NOT_DECOMPILED void NpcOptions__Create(s32 param);
NOT_DECOMPILED void NpcOptions__CreateInternal(void);
NOT_DECOMPILED void NpcOptions__ThreadFunc(void *arg);
NOT_DECOMPILED void NpcOptions__Func_216DDE0(NpcOptions *work);
NOT_DECOMPILED void NpcOptions__Func_216DDEC(NpcOptions *work);
NOT_DECOMPILED void NpcOptions__Func_216DE20(NpcOptions *work);
NOT_DECOMPILED void NpcOptions__Main(void);
NOT_DECOMPILED void NpcOptions__Main_216DE94(void);
NOT_DECOMPILED void NpcOptions__Main_216DFE0(void);
NOT_DECOMPILED void NpcOptions__Main_216E0B8(void);
NOT_DECOMPILED void NpcOptions__Main_216E190(void);
NOT_DECOMPILED void NpcOptions__Destructor(Task *task);
NOT_DECOMPILED void NpcOptions__Func_216E24C(void);
NOT_DECOMPILED BOOL NpcOptions__GetDifficulty(void);
NOT_DECOMPILED BOOL NpcOptions__GetTimeLimit(void);
NOT_DECOMPILED void NpcOptions__EnableNormalMode(BOOL enabled);
NOT_DECOMPILED void NpcOptions__EnableTimeLimit(BOOL enabled);

#ifdef __cplusplus
}
#endif

#endif // RUSH_NPCOPTIONS_HPP