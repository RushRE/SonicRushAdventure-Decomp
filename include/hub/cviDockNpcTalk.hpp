#ifndef RUSH_CVIDOCKNPCTALK_HPP
#define RUSH_CVIDOCKNPCTALK_HPP

#include <hub/cviEvtCmn.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockNpcTalk
{
public:
    // CViDockNpcTalk();
    // virtual ~CViDockNpcTalk();

    // --------------------
    // VARIABLES
    // --------------------

    u16 messageID;
    u16 field_2;
    CViEvtCmnTalk viEvtCmnTalk;

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

NOT_DECOMPILED void CreateViDockNpcTalk(s32 messageID);
NOT_DECOMPILED void ViDockNpcTalk__Create(s32 messageID);
NOT_DECOMPILED void ViDockNpcTalk__CreateInternal(void);
NOT_DECOMPILED void ViDockNpcTalk__Func_21689D0(void);
NOT_DECOMPILED void ViDockNpcTalk__Main(void);
NOT_DECOMPILED void ViDockNpcTalk__Destructor(void);
NOT_DECOMPILED void ViDockNpcTalk__Func_2168C0C(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKNPCTALK_HPP