#ifndef RUSH_CVITALKANNOUNCE_HPP
#define RUSH_CVITALKANNOUNCE_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class CViTalkAnnounce
{

public:
    // --------------------
    // VARIABLES
    // --------------------

    u16 type;
    CViEvtCmnAnnounce announce;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void ViTalkAnnounce__Create2(s32 param);
NOT_DECOMPILED void ViTalkAnnounce__Create(void);
NOT_DECOMPILED void ViTalkAnnounce__CreateInternal(void);
NOT_DECOMPILED void ViTalkAnnounce__Release(CViTalkAnnounce *work);
NOT_DECOMPILED void ViTalkAnnounce__Main(void);
NOT_DECOMPILED void ViTalkAnnounce__Destructor(void);
NOT_DECOMPILED void ViTalkAnnounce__Func_216B8FC(void);
NOT_DECOMPILED BOOL ViTalkAnnounce__Func_216B92C(u16 type);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVITALKANNOUNCE_HPP
