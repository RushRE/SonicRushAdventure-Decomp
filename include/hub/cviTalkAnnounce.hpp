#ifndef RUSH_CVITALKANNOUNCE_HPP
#define RUSH_CVITALKANNOUNCE_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>
#include <hub/hubConfig.h>

// --------------------
// STRUCTS
// --------------------

class CViTalkAnnounce
{

public:
    // --------------------
    // VARIABLES
    // --------------------

    u16 type;
    CViEvtCmnAnnounce eventAnnounce;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Release();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 param);

private:
    static void CreatePrivate(s32 param);
    static void Main(void);
    static void Destructor(Task *task);
    static BOOL IsItemAnnouncement(u16 type);
};

#endif // RUSH_CVITALKANNOUNCE_HPP
