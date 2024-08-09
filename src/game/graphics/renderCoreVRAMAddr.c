#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

const OSOwnerInfo ownerInfo = { 0 };

// TODO: these seem to require every reference to them to be in C code before they can be organised properly?
/*
const void* VRAMSystem__BGControllers[2][4] = { { (void *)REG_BG0CNT_ADDR, (void *)REG_BG1CNT_ADDR, (void *)REG_BG2CNT_ADDR, (void *)REG_BG3CNT_ADDR },
                                                { (void *)REG_DB_BG0CNT_ADDR, (void *)REG_DB_BG1CNT_ADDR, (void *)REG_DB_BG2CNT_ADDR, (void *)REG_DB_BG3CNT_ADDR } };

const void* VRAMSystem__VRAM_BG[2]          = { (void *)HW_BG_VRAM, (void *)HW_DB_BG_VRAM };
const void* VRAMSystem__VRAM_OBJ[2]         = { (void *)HW_OBJ_VRAM, (void *)HW_DB_OBJ_VRAM };
*/