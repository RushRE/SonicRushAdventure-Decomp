#ifndef RUSH_CVIDOCK_HPP
#define RUSH_CVIDOCK_HPP

#include <global.h>

#ifdef __cplusplus
#include <hub/hubTask.hpp>
#include <hub/cviDockBack.hpp>
#include <hub/cviDockNpcGroup.hpp>
#include <hub/cvi3dObject.hpp>
#include <hub/cviDockPlayer.hpp>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

class CViDock
{
public:
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

void ViDock__Create(void);
void ViDock__CreateInternal(void);
void ViDock__Func_215DB9C(void);
void ViDock__Func_215DBC8(s32 a1);
void ViDock__Func_215DC80(s32 a1, s32 a2);
BOOL ViDock__Func_215DD00(void);
void ViDock__Func_215DD2C(void);
void ViDock__Func_215DD64(s32 a1, s32 a2);
void ViDock__Func_215DE40(s32 a1);
void ViDock__Func_215DEF4(void);
void ViDock__Func_215DF64(s32 a1);
void ViDock__Func_215DF84(void);
BOOL ViDock__Func_215DFA0(void);
s32 ViDock__Func_215DFE4(void);
BOOL ViDock__Func_215E000(void);
void ViDock__Func_215E02C(s32 *id, s32 *param);
s32 ViDock__Func_215E06C(void);
void ViDock__Func_215E098(void);
s32 ViDock__GetTalkingNpc(void);
void ViDock__Func_215E104(s32 a1);
void ViDock__Func_215E178(void);
void ViDock__Func_215E340(s32 a1, s32 a2);
void ViDock__Func_215E410(void);
BOOL ViDock__Func_215E4A0(void);
void ViDock__Func_215E4BC(s32 a1);
void ViDock__Func_215E4DC(void);
void ViDock__Func_215E578(BOOL a1);
void ViDock__Func_215E658(s32 a1);
void ViDock__Func_215E678(CViDock *work);
void ViDock__Func_215E6E4(CViDock *work);
void ViDock__Func_215E754(void);
void ViDock__Func_215E81C(void);
void ViDock__Func_215E830(void);
void ViDock__Func_215E9F4(void);
void ViDock__Func_215EA7C(void);
void ViDock__Func_215EA8C(void);
void ViDock__Func_215EAF4(void);
void ViDock__Func_215EB04(void);
void ViDock__Func_215EC44(void);
void ViDock__Func_215EC58(void);
void ViDock__Func_215ED0C(void);
void ViDock__Func_215EE58(void);
void ViDock__Func_215EE7C(void);
void ViDock__Func_215EEA0(void);
void ViDock__Func_215EF3C(void);
void ViDock__Func_215EF40(void);
void ViDock__Func_215F1A8(void);
void ViDock__Func_215F6C8(void);
void ViDock__Func_215F8E8(void);
void ViDock__Main(void);
void ViDock__Func_215F998(void);
void ViDock__Func_215F9CC(void);
void ViDock__Func_215FD48(void);
void ViDock__Func_215FE00(void);
void ViDock__Func_215FE34(void);
void ViDock__Func_215FE68(void);
void ViDock__Destructor(Task *task);
void ViDock__Func_215FF6C(void);
void ViDock__Func_215FFC0(void);
void ViDock__Func_215FFF4(void);

#ifdef __cplusplus
}
#endif

#endif

#endif // RUSH_CVIDOCK_HPP