
#ifndef RUSH_CVIMAPFILE_HPP
#define RUSH_CVIMAPFILE_HPP

#include <global.h>

// --------------------
// STRUCTS
// --------------------

class CViMapVmiFile
{
public:
    // CViMapVmiFile();
    // virtual ~CViMapVmiFile();

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

class CViMapVmpFile
{
public:
    // CViMapVmpFile();
    // virtual ~CViMapVmpFile();

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

class CViMapVmcFile
{
public:
    // CViMapVmcFile();
    // virtual ~CViMapVmcFile();

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

// CViMapVmiFile
NOT_DECOMPILED void _ZN13CViMapVmiFileC1Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmiFileD0Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmiFileD1Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmiFile7ReleaseEv(void);
NOT_DECOMPILED void ViMapVmiFile__Load(void);
NOT_DECOMPILED void _ZN13CViMapVmiFile13GetImageCountEv(void);
NOT_DECOMPILED void ViMapVmiFile__GetImagePixelStartX(void);
NOT_DECOMPILED void ViMapVmiFile__GetImagePixelStartY(void);
NOT_DECOMPILED void _ZN13CViMapVmiFile18GetImageTileStartXEt(void);
NOT_DECOMPILED void _ZN13CViMapVmiFile18GetImageTileStartYEt(void);
NOT_DECOMPILED void ViMapVmiFile__GetImagePixelWidth(void);
NOT_DECOMPILED void ViMapVmiFile__GetImagePixelHeight(void);
NOT_DECOMPILED void _ZN13CViMapVmiFile17GetImageTileWidthEt(void);
NOT_DECOMPILED void _ZN13CViMapVmiFile18GetImageTileHeightEt(void);
NOT_DECOMPILED void ViMapVmiFile__GetSortOrder(void);

// CViMapVmpFile
NOT_DECOMPILED void _ZN13CViMapVmpFileC1Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmpFileD0Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmpFileD1Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmpFile7ReleaseEv(void);
NOT_DECOMPILED void ViMapVmpFile__Load(void);
NOT_DECOMPILED void ViMapVmpFile__GetColors(void);

// CViMapVmcFile
NOT_DECOMPILED void _ZN13CViMapVmcFileC1Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmcFileD0Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmcFileD1Ev(void);
NOT_DECOMPILED void _ZN13CViMapVmcFile7ReleaseEv(void);
NOT_DECOMPILED void ViMapVmcFile__Load(void);
NOT_DECOMPILED void _ZN13CViMapVmcFile9GetPixelsEv(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAPFILE_HPP
