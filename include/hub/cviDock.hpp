#ifndef RUSH_CVIDOCK_HPP
#define RUSH_CVIDOCK_HPP

#include <global.h>

// --------------------
// STRUCTS
// --------------------

enum DockArea_
{
    DOCKAREA_BASE,
    DOCKAREA_BASE_NEXT,
    DOCKAREA_JET,
    DOCKAREA_SHIP,
    DOCKAREA_BOAT,
    DOCKAREA_SUBMARINE,
    DOCKAREA_BEACH,
    DOCKAREA_DRILL,

    DOCKAREA_COUNT,
    DOCKAREA_NONE    = DOCKAREA_COUNT,
    DOCKAREA_INVALID = DOCKAREA_NONE + 1,
};
typedef u32 DockArea;


#ifdef __cplusplus

// --------------------
// STRUCTS
// --------------------

class CViDock
{
public:
    CViDock();
    virtual ~CViDock();

    // --------------------
    // VARIABLES
    // --------------------

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

NOT_DECOMPILED void ViDock__Create(void);
NOT_DECOMPILED void ViDock__CreateInternal(void);
NOT_DECOMPILED void ViDock__Func_215DB9C(void);
NOT_DECOMPILED void ViDock__Func_215DBC8(s32 a1);
NOT_DECOMPILED void ViDock__Func_215DC80(s32 a1, s32 a2);
NOT_DECOMPILED BOOL ViDock__Func_215DD00(void);
NOT_DECOMPILED void ViDock__Func_215DD2C(void);
NOT_DECOMPILED void ViDock__Func_215DD64(s32 a1, s32 a2);
NOT_DECOMPILED void ViDock__Func_215DE40(s32 a1);
NOT_DECOMPILED void ViDock__Func_215DEF4(void);
NOT_DECOMPILED void ViDock__Func_215DF64(s32 a1);
NOT_DECOMPILED void ViDock__Func_215DF84(void);
NOT_DECOMPILED BOOL ViDock__Func_215DFA0(void);
NOT_DECOMPILED s32 ViDock__Func_215DFE4(void);
NOT_DECOMPILED BOOL ViDock__Func_215E000(void);
NOT_DECOMPILED void ViDock__Func_215E02C(s32 *id, s32 *param);
NOT_DECOMPILED s32 ViDock__Func_215E06C(void);
NOT_DECOMPILED void ViDock__Func_215E098(void);
NOT_DECOMPILED s32 ViDock__Func_215E0CC(void);
NOT_DECOMPILED void ViDock__Func_215E104(s32 a1);
NOT_DECOMPILED void ViDock__Func_215E178(void);
NOT_DECOMPILED void ViDock__Func_215E340(s32 a1, s32 a2);
NOT_DECOMPILED void ViDock__Func_215E410(void);
NOT_DECOMPILED BOOL ViDock__Func_215E4A0(void);
NOT_DECOMPILED void ViDock__Func_215E4BC(s32 a1);
NOT_DECOMPILED void ViDock__Func_215E4DC(void);
NOT_DECOMPILED void ViDock__Func_215E578(BOOL a1);
NOT_DECOMPILED void ViDock__Func_215E658(s32 a1);
NOT_DECOMPILED void ViDock__Func_215E678(void);
NOT_DECOMPILED void ViDock__Func_215E6E4(void);
NOT_DECOMPILED void ViDock__Func_215E754(void);
NOT_DECOMPILED void ViDock__Func_215E81C(void);
NOT_DECOMPILED void ViDock__Func_215E830(void);
NOT_DECOMPILED void ViDock__Func_215E9F4(void);
NOT_DECOMPILED void ViDock__Func_215EA7C(void);
NOT_DECOMPILED void ViDock__Func_215EA8C(void);
NOT_DECOMPILED void ViDock__Func_215EAF4(void);
NOT_DECOMPILED void ViDock__Func_215EB04(void);
NOT_DECOMPILED void ViDock__Func_215EC44(void);
NOT_DECOMPILED void ViDock__Func_215EC58(void);
NOT_DECOMPILED void ViDock__Func_215ED0C(void);
NOT_DECOMPILED void ViDock__Func_215EE58(void);
NOT_DECOMPILED void ViDock__Func_215EE7C(void);
NOT_DECOMPILED void ViDock__Func_215EEA0(void);
NOT_DECOMPILED void ViDock__Func_215EF3C(void);
NOT_DECOMPILED void ViDock__Func_215EF40(void);
NOT_DECOMPILED void ViDock__Func_215F1A8(void);
NOT_DECOMPILED void ViDock__Func_215F6C8(void);
NOT_DECOMPILED void ViDock__Func_215F8E8(void);
NOT_DECOMPILED void ViDock__Main(void);
NOT_DECOMPILED void ViDock__Func_215F998(void);
NOT_DECOMPILED void ViDock__Func_215F9CC(void);
NOT_DECOMPILED void ViDock__Func_215FD48(void);
NOT_DECOMPILED void ViDock__Func_215FE00(void);
NOT_DECOMPILED void ViDock__Func_215FE34(void);
NOT_DECOMPILED void ViDock__Func_215FE68(void);
NOT_DECOMPILED void ViDock__Destructor(void);
NOT_DECOMPILED void ViDock__Func_215FF6C(void);
NOT_DECOMPILED void ViDock__Func_215FFC0(void);
NOT_DECOMPILED void ViDock__Func_215FFF4(void);

#ifdef __cplusplus
}
#endif

#endif

#endif // RUSH_CVIDOCK_HPP