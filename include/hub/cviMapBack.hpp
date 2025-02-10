#ifndef RUSH_CVIMAPBACK_HPP
#define RUSH_CVIMAPBACK_HPP

#include <game/graphics/sprite.h>
#include <game/text/fontDMAControl.h>

// --------------------
// STRUCTS
// --------------------

struct CVmiFileEntry
{
    u16 width1;
    u16 height1;
    u16 width2;
    u16 height2;
    u16 sortOrder;
    u16 id;
};

class CViMapVmiFile
{
    void *vTable;

public:
    // CViMapVmiFile();
    // virtual ~CViMapVmiFile();

    // --------------------
    // VARIABLES
    // --------------------

    u16 *entryCount;
    CVmiFileEntry *entries;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViMapVmcFile
{
    void *vTable;

public:
    // CViMapVmcFile();
    // virtual ~CViMapVmcFile();

    // --------------------
    // VARIABLES
    // --------------------

    void *file;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViMapVmpFile
{
    void *vTable;

public:
    // CViMapVmpFile();
    // virtual ~CViMapVmpFile();

    // --------------------
    // VARIABLES
    // --------------------

    GXRgb *colors;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViMapBack
{
    void *vTable;

public:
    // CViMapBack();
    // virtual ~CViMapBack();

    // --------------------
    // VARIABLES
    // --------------------

    CViMapVmiFile vmiFile;
    CViMapVmpFile vmpFile;
    CViMapVmcFile vmcFile;
    void *mapVmiFile;
    void *mapVmpFile;
    void *activeVmcFile;
    s32 vmcFileCount;
    u32 *vmcFiles;
    s32 field_34;
    u16 width1;
    u16 height1;
    u16 width2;
    u16 height2;
    u8 *unknownStorage;
    u16 *unknownEntries;
    s32 field_48;
    s32 unknownCount;
    u32 field_50[15];
    AnimatorSprite aniDecoration[13];
    u16 field_5A0;
    u16 field_5A2;
    u16 field_5A4;
    u16 field_5A6;
    s32 field_5A8;
    void *field_5AC;
    s32 field_5B0;
    u16 field_5B4;
    u16 field_5B6;
    s32 field_5B8;
    s32 field_5BC;
    FontDMAControl fontDmaControl;

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

// CViMapVmiFile
void _ZN13CViMapVmiFileC1Ev(CViMapVmiFile *work);
void _ZN13CViMapVmiFileD0Ev(CViMapVmiFile *work);
void _ZN13CViMapVmiFileD1Ev(CViMapVmiFile *work);

void ViMapVmiFile__Func_2161074(CViMapVmiFile *work);
void ViMapVmiFile__Func_2161084(CViMapVmiFile *work, void *file);
u16 ViMapVmiFile__Func_21610A4(CViMapVmiFile *work);
u16 ViMapVmiFile__Func_21610B0(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_21610CC(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_21610E8(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_21610FC(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_2161110(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_216112C(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_2161148(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_216115C(CViMapVmiFile *work, s32 id);
u16 ViMapVmiFile__Func_2161170(CViMapVmiFile *work, s32 id);

// CViMapVmpFile
void _ZN13CViMapVmpFileC1Ev(CViMapVmpFile *work);
void _ZN13CViMapVmpFileD0Ev(CViMapVmpFile *work);
void _ZN13CViMapVmpFileD1Ev(CViMapVmpFile *work);

void ViMapVmpFile__Func_21611EC(CViMapVmpFile *work);
void ViMapVmpFile__Func_21611F8(CViMapVmpFile *work, void *file);
void *ViMapVmpFile__Func_2161210(CViMapVmpFile *work);

// CViMapVmcFile
void _ZN13CViMapVmcFileC1Ev(CViMapVmcFile *work);
void _ZN13CViMapVmcFileD0Ev(CViMapVmcFile *work);
void _ZN13CViMapVmcFileD1Ev(CViMapVmcFile *work);

void ViMapVmcFile__Func_2161280(CViMapVmcFile *work);
void ViMapVmcFile__Func_216128C(CViMapVmcFile *work, void *file);
void *ViMapVmcFile__Func_21612A4(CViMapVmcFile *work);

// CViMapBack
void _ZN10CViMapBackC1Ev(CViMapBack *work);
void _ZN10CViMapBackD0Ev(CViMapBack *work);
void _ZN10CViMapBackD1Ev(CViMapBack *work);

void ViMapBack__LoadAssets(void);
void ViMapBack__Func_2161680(CViMapBack *work);
void ViMapBack__Func_21617E4(void);
void ViMapBack__Func_2161864(void);
void ViMapBack__Func_21618CC(void);
void ViMapBack__Func_2161924(void);
void ViMapBack__Func_2161960(void);
void ViMapBack__Func_2161978(void);
void ViMapBack__Func_21619B0(void);
void ViMapBack__Func_2161A40(void);
void ViMapBack__Func_2161ADC(void);
void ViMapBack__Func_2161BE4(void);
void ViMapBack__Func_2161DC8(void);
void ViMapBack__Func_2161E20(void);
void ViMapBack__Func_2161E30(void);
void ViMapBack__Func_2161F08(void);
void ViMapBack__Func_2161F3C(void);
void ViMapBack__Func_2162010(void);
void ViMapBack__Func_21620FC(void);
void ViMapBack__Func_2162110(void);
void ViMapBack__Func_2162158(void);
void ViMapBack__Func_216233C(void);
void ViMapBack__Func_2162508(void);
void ViMapBack__Func_2162648(void);
void ViMapBack__Func_2162774(void);
void ViMapBack__Func_2162798(void);
void ViMapBack__Func_21627D4(void);
void ViMapBack__Func_2162874(void);
void ViMapBack__Func_2162974(void);
void ViMapBack__Func_2162B90(void);
void ViMapBack__Func_2162BD8(void);
void ViMapBack__Func_2162C04(void);
void ViMapBack__Func_2162C50(void);
void ViMapBack__Func_2162C80(void);
void ViMapBack__Func_2162CB8(void);
void ViMapBack__Func_2162E54(void);
void ViMapBack__Func_2162E90(void);
void ViMapBack__Func_2162F2C(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAPBACK_HPP