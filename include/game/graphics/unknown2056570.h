#ifndef RUSH2_UNKNOWN2056570_H
#define RUSH2_UNKNOWN2056570_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Unknown2056570_
{
    s32 field_0;
    BOOL useEngineB;
    u16 word8;
    u16 wordA;
    u16 wordC;
    u16 wordE;
    u16 bgID;
    u8 byte12;
    u8 byte13;
    u16 word14;
    u16 word16;
    u16 word18;
    u16 word1A;
    u32 dword1C;
    u32 dword20;
    u32 dword24;
    u32 dword28;
    void *spritePixels;
} Unknown2056570;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void Unknown2056570__Init(Unknown2056570 *work, BOOL useEngineB, u16 a3, s32 a4, u16 a5, u16 a6, u16 a7, u16 a8, s32 a9, s32 a10, s32 a11);
NOT_DECOMPILED void Unknown2056570__Func_2056670(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_2056688(Unknown2056570 *work, void *a2);
NOT_DECOMPILED u16 Unknown2056570__Func_2056824(Unknown2056570 *work);
NOT_DECOMPILED u16 Unknown2056570__Func_205682C(Unknown2056570 *work);
NOT_DECOMPILED void *Unknown2056570__Func_2056834(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_205683C(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_20568B0(Unknown2056570 *work, s32 a2, s32 a3, s32 a4, u16 a5);
NOT_DECOMPILED void Unknown2056570__Func_2056958(Unknown2056570 *work, u32 a2, u32 a3, u32 a4, u16 a5);
NOT_DECOMPILED void Unknown2056570__Func_20569C4(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_2056A58(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_2056A94(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_2056B8C(Unknown2056570 *work);
NOT_DECOMPILED void Unknown2056570__Func_2056C18(Unknown2056570 *work);

#endif // RUSH2_UNKNOWN2056570_H
