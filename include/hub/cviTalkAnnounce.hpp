#ifndef RUSH_CVITALKANNOUNCE_HPP
#define RUSH_CVITALKANNOUNCE_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>

// --------------------
// STRUCTS
// --------------------

class CViTalkAnnounce
{

public:
    // --------------------
    // ENUMS
    // --------------------

    enum Type
    {
        TYPE_UNLOCKED_JET,
        TYPE_UNLOCKED_BOAT,
        TYPE_UNLOCKED_HOVER,
        TYPE_UNLOCKED_SUBMARINE,
        TYPE_UNLOCKED_DRILL,
        TYPE_5,
        TYPE_6,
        TYPE_7,
        TYPE_8,
        TYPE_9,
        TYPE_DECOR_1,
        TYPE_11,
        TYPE_UNLOCKED_RADIO_TOWER,
        TYPE_DECOR_2,
        TYPE_14,
        TYPE_15,
        TYPE_16,
        TYPE_17,
        TYPE_18,
        TYPE_19,
        TYPE_20,
        TYPE_21,
        TYPE_DECOR_3,
        TYPE_23,
        TYPE_24,
        TYPE_25,
        TYPE_26,
        TYPE_UNLOCKED_NEW_MISSION,
        TYPE_UNLOCKED_MEDAL,
        TYPE_UPGRADED_JET_LEVEL1,
        TYPE_UPGRADED_JET_LEVEL2,
        TYPE_UPGRADED_BOAT_LEVEL1,
        TYPE_UPGRADED_BOAT_LEVEL2,
        TYPE_UPGRADED_HOVER_LEVEL1,
        TYPE_UPGRADED_HOVER_LEVEL2,
        TYPE_UPGRADED_SUBMARINE_LEVEL1,
        TYPE_UPGRADED_SUBMARINE_LEVEL2,

        TYPE_COUNT,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u16 type;
    CViEvtCmnAnnounce announce;

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
