#ifndef RUSH_CVIHUBAREAPREVIEW_HPP
#define RUSH_CVIHUBAREAPREVIEW_HPP

#include <hub/hubControl.hpp>

// --------------------
// STRUCTS
// --------------------

class CViHubAreaPreview
{
public:
    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(HubControl *parent);
    static void Func_2158C04(HubControl *parent);
    static void Main(void);
    static void Destructor(Task *task);
};

#endif // RUSH_CVIHUBAREAPREVIEW_HPP