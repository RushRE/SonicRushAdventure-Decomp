#ifndef RUSH_UNKNOWN2085404_H
#define RUSH_UNKNOWN2085404_H

#include <global.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Unknown2085404Unknown1_Entry1_
{
    u32 field_0;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
} Unknown2085404Unknown1_Entry1;

typedef struct Unknown2085404Unknown1_Entry2_
{
    s32 field_0;
} Unknown2085404Unknown1_Entry2;

struct Unknown2085404Unknown1
{
    u32 field_0;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    u16 unknownList1Size;
    u16 unknownList2Size;
    Unknown2085404Unknown1_Entry1 *unknownList1;
    Unknown2085404Unknown1_Entry2 *unknownList2;
};

struct Unknown2085404Unknown2
{
    s32 field_0;
};

struct Unknown2085404Manager
{
    struct Unknown2085404Unknown1 *unknown1;
    struct Unknown2085404Unknown2 *unknown2;
};

// --------------------
// VARIABLES
// --------------------

extern struct Unknown2085404Manager unknown2085404Manager;

// --------------------
// FUNCTIONS
// --------------------

void InitUnknown2085404System(void);

#endif // RUSH_UNKNOWN2085404_H
