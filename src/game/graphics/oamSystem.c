#include <game/graphics/oamSystem.h>
#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

GXOamAttr oamDefault;

static struct OAMManager oamManagerA;
static struct OAMManager oamManagerB;
static struct OAMManager *const oamManagers[2] = { &oamManagerA, &oamManagerB };

// --------------------
// FUNCTIONS
// --------------------

void InitOAMSystem(void)
{
    for (u32 e = 0; e < 2; e++)
    {
        struct OAMManager *manager = oamManagers[e];

        manager->count        = 0;
        manager->affineCount  = 0;
        manager->affineOffset = 0;

        MI_CpuFill16(manager->oamList1, 0x200, sizeof(manager->oamList1));
        MI_CpuFill16(manager->oamList2, 0x200, sizeof(manager->oamList2));
        MI_CpuFill16(manager->oamList3, 0, sizeof(manager->oamList3));
        MI_CpuFill16(manager->oamOrderMap1, OAMSYSTEM_INVALID, sizeof(manager->oamOrderMap1));
        MI_CpuFill16(manager->oamOrderMap2, OAMSYSTEM_INVALID, sizeof(manager->oamOrderMap2));
    }
}

GXOamAttr *OAMSystem__Alloc(BOOL useEngineB, u32 order)
{
    struct OAMManager *manager = oamManagers[useEngineB];

    if (order >= OAMSYSTEM_OAM_COUNT)
        order = OAMSYSTEM_OAM_COUNT - 1;

    if (manager->count >= OAMSYSTEM_OAM_LIST_SIZE)
    {
        oamDefault._3 = OAMSYSTEM_INVALID;

        return &oamDefault;
    }

    manager->oamList3[manager->count]._3 = OAMSYSTEM_INVALID;

    if (manager->oamOrderMap1[order] == OAMSYSTEM_INVALID)
        manager->oamOrderMap1[order] = manager->count;
    else
        manager->oamList3[manager->oamOrderMap2[order]]._3 = manager->count;

    manager->oamOrderMap2[order] = manager->count;

    return &manager->oamList3[manager->count++];
}

GXOamAttr *OAMSystem__Func_207D624(BOOL useEngineB, GXOamAttr *attr)
{
    if (attr->_3 == OAMSYSTEM_INVALID)
        return 0;
    else
        return &oamManagers[useEngineB]->oamList3[attr->_3];
}

u16 OAMSystem__AddAffineSprite(BOOL useEngineB, MtxFx22 *matrix)
{
    struct OAMManager *manager = oamManagers[useEngineB];

    if (matrix != NULL)
    {
        s16 PA = matrix->_00 >> 4;
        s16 PB = matrix->_01 >> 4;
        s16 PC = matrix->_10 >> 4;
        s16 PD = matrix->_11 >> 4;

        for (u16 i = 0; i < (manager->affineOffset + manager->affineCount); i++)
        {
            GXOamAffine *affine = (GXOamAffine *)&manager->oamList1[4 * i];

            if (affine->PA == PA && affine->PB == PB && affine->PC == PC && affine->PD == PD)
                return i;
        }
    }

    if ((manager->affineOffset + manager->affineCount) < OAMSYSTEM_OAM_AFFINE_LIST_SIZE)
    {
        return (manager->affineOffset + manager->affineCount++);
    }

    return OAMSYSTEM_INVALID;
}

void OAMSystem__PrepareNewFrame(BOOL useEngineB)
{
    struct OAMManager *manager = oamManagers[useEngineB];
    u16 a;
    u32 i;

    GXOamAttr *attr = manager->oamList1;
    for (i = 0; i < OAMSYSTEM_OAM_COUNT; i++)
    {
        for (a = manager->oamOrderMap1[i]; a != OAMSYSTEM_INVALID; attr++)
        {
            MI_CpuCopy16(&manager->oamList3[a], attr, (sizeof(GXOamAttr) - sizeof(u16))); // sizeof == 6 (discards the padding/_3)
            a = manager->oamList3[a]._3;
        }
    }

    manager->count       = 0;
    manager->affineCount = 0;

    MI_CpuFill16(manager->oamOrderMap1, OAMSYSTEM_INVALID, sizeof(manager->oamOrderMap1));
    MI_CpuFill16(manager->oamOrderMap2, OAMSYSTEM_INVALID, sizeof(manager->oamOrderMap2));
}

void OAMSystem__CopyToVRAM(BOOL useEngineB)
{
    static void *const oamAddress[] = { (void *)HW_OAM, (void *)HW_DB_OAM };
    static u32 const oamSize[]      = { HW_OAM_SIZE, HW_DB_OAM_SIZE };

    struct OAMManager *manager = oamManagers[useEngineB];

    DC_StoreRange(manager->oamList1, oamSize[useEngineB]);
    MI_DmaCopy32(renderDmaNo, manager->oamList1, oamAddress[useEngineB], oamSize[useEngineB]);
    MI_CpuCopyFast(manager->oamList2, manager->oamList1, sizeof(manager->oamList1));
}

u32 OAMSystem__GetOAMCount(BOOL useEngineB)
{
    return oamManagers[useEngineB]->count;
}

u16 OAMSystem__GetOAMAffineCount(BOOL useEngineB)
{
    return oamManagers[useEngineB]->affineCount;
}

u16 OAMSystem__GetOAMAffineOffset(BOOL useEngineB)
{
    return oamManagers[useEngineB]->affineOffset;
}

void OAMSystem__SetOAMAffineOffset(BOOL useEngineB, u16 offset)
{
    oamManagers[useEngineB]->affineOffset = offset;
}

GXOamAttr *OAMSystem__GetList1(BOOL useEngineB)
{
    return oamManagers[useEngineB]->oamList1;
}

GXOamAttr *OAMSystem__GetList2(BOOL useEngineB)
{
    return oamManagers[useEngineB]->oamList2;
}

GXOamAttr *OAMSystem__GetList3(BOOL useEngineB)
{
    return oamManagers[useEngineB]->oamList3;
}

u32 OAMSystem__GetListMap(BOOL useEngineB, u32 order)
{
    return oamManagers[useEngineB]->oamOrderMap1[order];
}
