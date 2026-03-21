#include <game/unknown/unknown2085404.h>
#include <game/system/allocator.h>

// --------------------
// VARIABLES
// --------------------

struct Unknown2085404Manager sUnknown2085404Manager;

// --------------------
// FUNCTIONS
// --------------------

void InitUnknown2085404System(void)
{
    sUnknown2085404Manager.unknown1 = NULL;
    sUnknown2085404Manager.unknown2 = NULL;

    sUnknown2085404Manager.unknown2 = HeapAllocHead(HEAP_SYSTEM, sizeof(struct Unknown2085404Unknown2));
    MI_CpuClear32(sUnknown2085404Manager.unknown2, sizeof(struct Unknown2085404Unknown2));

    sUnknown2085404Manager.unknown1 = HeapAllocHead(HEAP_SYSTEM, sizeof(struct Unknown2085404Unknown1));
    MI_CpuClear32(sUnknown2085404Manager.unknown1, sizeof(struct Unknown2085404Unknown1));

    sUnknown2085404Manager.unknown1->unknownList1Size = 16;
    if (sizeof(Unknown2085404Unknown1_Entry1) * sUnknown2085404Manager.unknown1->unknownList1Size)
        sUnknown2085404Manager.unknown1->unknownList1 = HeapAllocHead(HEAP_SYSTEM, sizeof(Unknown2085404Unknown1_Entry1) * sUnknown2085404Manager.unknown1->unknownList1Size);
    else
        sUnknown2085404Manager.unknown1->unknownList1 = NULL;

    sUnknown2085404Manager.unknown1->unknownList2Size = 16;
    if (sizeof(Unknown2085404Unknown1_Entry2) * sUnknown2085404Manager.unknown1->unknownList2Size)
    {
        sUnknown2085404Manager.unknown1->unknownList2 = HeapAllocHead(HEAP_SYSTEM, sizeof(Unknown2085404Unknown1_Entry2) * sUnknown2085404Manager.unknown1->unknownList2Size);
    }
    else
    {
        sUnknown2085404Manager.unknown1->unknownList2 = NULL;
    }

    sUnknown2085404Manager.unknown1->field_0  = sUnknown2085404Manager.unknown1->unknownList1Size;
    sUnknown2085404Manager.unknown1->field_4  = 0;
    sUnknown2085404Manager.unknown1->field_8  = 0;
    sUnknown2085404Manager.unknown1->field_C  = FX_ONE;
    sUnknown2085404Manager.unknown1->field_10 = FX_ONE;
    sUnknown2085404Manager.unknown1->field_14 = 0;
}