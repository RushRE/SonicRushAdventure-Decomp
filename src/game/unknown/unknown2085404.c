#include <game/unknown/unknown2085404.h>
#include <game/system/allocator.h>

// --------------------
// VARIABLES
// --------------------

struct Unknown2085404Manager unknown2085404Manager;

// --------------------
// FUNCTIONS
// --------------------

void InitUnknown2085404System(void)
{
    unknown2085404Manager.unknown1 = NULL;
    unknown2085404Manager.unknown2 = NULL;

    unknown2085404Manager.unknown2 = HeapAllocHead(HEAP_SYSTEM, sizeof(struct Unknown2085404Unknown2));
    MI_CpuClear32(unknown2085404Manager.unknown2, sizeof(struct Unknown2085404Unknown2));

    unknown2085404Manager.unknown1 = HeapAllocHead(HEAP_SYSTEM, sizeof(struct Unknown2085404Unknown1));
    MI_CpuClear32(unknown2085404Manager.unknown1, sizeof(struct Unknown2085404Unknown1));

    unknown2085404Manager.unknown1->unknownList1Size = 16;
    if (sizeof(Unknown2085404Unknown1_Entry1) * unknown2085404Manager.unknown1->unknownList1Size)
        unknown2085404Manager.unknown1->unknownList1 = HeapAllocHead(HEAP_SYSTEM, sizeof(Unknown2085404Unknown1_Entry1) * unknown2085404Manager.unknown1->unknownList1Size);
    else
        unknown2085404Manager.unknown1->unknownList1 = NULL;

    unknown2085404Manager.unknown1->unknownList2Size = 16;
    if (sizeof(Unknown2085404Unknown1_Entry2) * unknown2085404Manager.unknown1->unknownList2Size)
    {
        unknown2085404Manager.unknown1->unknownList2 = HeapAllocHead(HEAP_SYSTEM, sizeof(Unknown2085404Unknown1_Entry2) * unknown2085404Manager.unknown1->unknownList2Size);
    }
    else
    {
        unknown2085404Manager.unknown1->unknownList2 = NULL;
    }

    unknown2085404Manager.unknown1->field_0  = unknown2085404Manager.unknown1->unknownList1Size;
    unknown2085404Manager.unknown1->field_4  = 0;
    unknown2085404Manager.unknown1->field_8  = 0;
    unknown2085404Manager.unknown1->field_C  = FX_ONE;
    unknown2085404Manager.unknown1->field_10 = FX_ONE;
    unknown2085404Manager.unknown1->field_14 = 0;
}