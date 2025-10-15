#include <game/stage/mapSys.h>
#include <game/stage/mapFarSys.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/graphics/mappingsQueue.h>
#include <game/object/objectManager.h>
#include <stage/core/waterSurface.h>

// --------------------
// TYPES
// --------------------

typedef void (*MapFarSysLoadBossMapFunc)(void *archive);
typedef void (*MapFarSysLoadBossTilesFunc)(void *archive);

// --------------------
// VARIABLES
// --------------------

static Task *mapSystemTask;
MapSysFiles mapSysFiles;
MapSysCameraSys mapCamera;

static MapFarSysLoadBossTilesFunc const MapSys__ZoneLoadBossTilesTable[ZONE_COUNT] = {
    [ZONE_PLANT_KINGDOM] = MapSys__LoadBossTiles_Zone1,  [ZONE_MACHINE_LABYRINTH] = MapSys__LoadBossTiles_Zone2, [ZONE_CORAL_CAVE] = MapSys__LoadBossTiles_Zone3,
    [ZONE_HAUNTED_SHIP] = MapSys__LoadBossTiles_Zone4,   [ZONE_BLIZZARD_PEAKS] = MapSys__LoadBossTiles_Zone5,    [ZONE_SKY_BABYLON] = MapSys__LoadBossTiles_Zone6,
    [ZONE_PIRATES_ISLAND] = MapSys__LoadBossTiles_Zone7, [ZONE_BIG_SWELL] = MapSys__LoadBossTiles_ZoneF,         [ZONE_HIDDEN_ISLAND] = NULL,
};

static MapFarSysLoadBossMapFunc const MapSys__ZoneLoadBossMapTable[ZONE_COUNT] = {
    [ZONE_PLANT_KINGDOM] = MapSys__LoadBossMap_Zone1,  [ZONE_MACHINE_LABYRINTH] = MapSys__LoadBossMap_Zone2, [ZONE_CORAL_CAVE] = MapSys__LoadBossMap_Zone3,
    [ZONE_HAUNTED_SHIP] = MapSys__LoadBossMap_Zone4,   [ZONE_BLIZZARD_PEAKS] = MapSys__LoadBossMap_Zone5,    [ZONE_SKY_BABYLON] = MapSys__LoadBossMap_Zone6,
    [ZONE_PIRATES_ISLAND] = MapSys__LoadBossMap_Zone7, [ZONE_BIG_SWELL] = MapSys__LoadBossMap_ZoneF,         [ZONE_HIDDEN_ISLAND] = NULL,
};

// --------------------
// FUNCTIONS
// --------------------

// MapSys
void MapSys__Init(void)
{
    u32 width  = mapCamera.camControl.width;
    u32 height = mapCamera.camControl.height;
    MI_CpuClear16(&mapCamera, sizeof(mapCamera));
    mapCamera.camControl.width  = width;
    mapCamera.camControl.height = height;

    mapSystemTask = NULL;
}

void MapSys__Create(void)
{
    MapSys *work;

    GameState *state = GetGameState();

    MI_CpuClear16(&mapCamera, sizeof(mapCamera));
    MapSys__InitStageBounds();

    mapCamera.camera[0].waterLevel = mapCamera.camera[1].waterLevel = MAPSYS_WATERLEVEL_NONE;

    if (IsBossStage())
    {
        switch (gameState.stageID)
        {
            case STAGE_Z2B:
                mapCamera.camControl.bossArenaRadius = 0x1187BC;
                mapCamera.camControl.bossArenaLeft   = 0x40000;
                mapCamera.camControl.bossArenaRight  = 0x722543;
                break;

            case STAGE_Z3B:
                mapCamera.camControl.bossArenaRadius = 0x107FC0;
                mapCamera.camControl.bossArenaLeft   = 0x40000;
                mapCamera.camControl.bossArenaRight  = 0x6BAA99;
                break;

            case STAGE_Z5B:
                MapSys__SetupBoss_Zone5();
                break;
        }
    }
    else
    {
        if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0 && state->vsBattleType == VSBATTLE_RINGS)
        {
            MapSys__InitBoundsForVSRings();
            mapCamera.camera[1].targetPlayerID = 1;

            g_obj.flag &= ~OBJECTMANAGER_FLAG_USE_DUAL_CAMERAS;
        }
        else
        {
            MapSys__InitBoundsForStage();
            g_obj.flag |= OBJECTMANAGER_FLAG_USE_DUAL_CAMERAS;
        }

        g_obj.cameraFunc = MapSys__GetCameraPositionCB;
    }

    if (!IsBossStage())
    {
        mapSystemTask = TaskCreate(MapSys__Main_Zone, MapSys__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1080, TASK_GROUP(3), MapSys);

        work = TaskGetWork(mapSystemTask, MapSys);
        TaskInitWork16(work);

        work->stateCamLook = MapSys__HandleCameraLookUpDown;
    }
    else
    {
        mapSystemTask = TaskCreate(MapSys__Main_Boss, MapSys__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1080, TASK_GROUP(3), MapSys);

        work = TaskGetWork(mapSystemTask, MapSys);
        TaskInitWork16(work);

        work->stateCamLook = NULL;
    }

    InitWaterSurface();
    MapFarSys__BuildBG();
}

NONMATCH_FUNC void MapSys__InitCameraForRestart (void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r7, =mapSystemTask
	mov r4, #0
	ldr r0, =0xFFF8FEFB
	ldr r1, [r7, #0x100]
	ldr r5, =mapCamera
	and r0, r1, r0
	ldr r9, =0x0000FFFF
	ldr r6, =0xFFFF0FCF
	str r0, [r7, #0x100]
	mov r8, r4
_02008740:
	ldrsb r0, [r5, #0x46]
	cmp r0, #1
	beq _020087AC
	ldr r0, [r5, #0]
	and r0, r0, r6
	str r0, [r5]
	ldr r0, [r7, #0x150]
	str r0, [r5, #0x58]
	ldr r0, [r7, #0x154]
	str r0, [r5, #0x5c]
	ldr r0, [r7, #0x158]
	str r0, [r5, #0x60]
	ldr r0, [r7, #0x15c]
	str r0, [r5, #0x64]
	bl GetCurrentZoneID
	cmp r0, #0
	bne _02008794
	ldr r0, [r5, #0]
	bic r0, r0, #0x3000000
	str r0, [r5]
	strh r9, [r5, #0x6e]
_02008794:
	strb r8, [r5, #0x6c]
	strb r8, [r5, #0x6b]
	ldrsb r0, [r5, #0x6b]
	strb r0, [r5, #0x6a]
	strb r0, [r5, #0x69]
	strb r0, [r5, #0x68]
_020087AC:
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x70
	blt _02008740
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void MapSys__LoadArchive_RAW(void *archive)
{
    if (!IsBossStage())
        return MapSys__LoadZoneTiles(archive);

    return MapSys__ZoneLoadBossTilesTable[GetCurrentZoneID()](archive);
}

void MapSys__LoadArchive_MAP(void *archive)
{
    if (!IsBossStage())
    {
        MapSys__LoadZoneMap(archive);
    }
    else
    {
        MapSys__ZoneLoadBossMapTable[GetCurrentZoneID()](archive);
    }

    mapCamera.camControl.width  = mapSysFiles.mapLayout[0]->width << 6;
    mapCamera.camControl.height = mapSysFiles.mapLayout[0]->height << 6;
}

void MapSys__Flush(void)
{
    if (mapSysFiles.collisionHeightMasks != NULL)
        HeapFree(HEAP_ITCM, mapSysFiles.collisionHeightMasks);
    mapSysFiles.collisionHeightMasks = NULL;

    if (mapSysFiles.collisionAttributes != NULL)
        HeapFree(HEAP_ITCM, mapSysFiles.collisionAttributes);
    mapSysFiles.collisionAttributes = NULL;

    if (mapSysFiles.collisionAngles != NULL)
        HeapFree(HEAP_ITCM, mapSysFiles.collisionAngles);
    mapSysFiles.collisionAngles = NULL;

    if (mapSysFiles.blockset != NULL)
        HeapFree(HEAP_USER, mapSysFiles.blockset);
    mapSysFiles.blockset = NULL;

    if (mapSysFiles.mapLayout[0] != NULL)
        HeapFree(HEAP_USER, mapSysFiles.mapLayout[0]);
    mapSysFiles.mapLayout[0] = NULL;

    if (mapSysFiles.mapLayout[1] != NULL)
        HeapFree(HEAP_USER, mapSysFiles.mapLayout[1]);
    mapSysFiles.mapLayout[1] = NULL;

    if (mapSysFiles.mapCameraZones != NULL)
        HeapFree(HEAP_USER, mapSysFiles.mapCameraZones);
    mapSysFiles.mapCameraZones = NULL;
}

void MapSys__BuildData(void)
{
    // nothing
}

void MapSys__Release(void)
{
    // nothing
}

NONMATCH_FUNC void MapSys__DrawLayout(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r0, =mapCamera
	str r0, [sp, #0x24]
_02008974:
	ldr r0, [sp, #0x24]
	ldr r0, [r0, #0]
	tst r0, #0x10000000
	bne _02008B18
	ldr r0, [sp, #0x24]
	ldrsh r1, [r0, #0x1c]
	ldr r2, [r0, #4]
	ldr r0, =mapCamera
	add r1, r1, r2, asr #12
	add r0, r0, #0x100
	ldrh r3, [r0, #0x2a]
	ldrh r2, [r0, #0x2c]
	mov r0, r1, lsl #0xa
	mov r11, r0, lsr #0x10
	ldr r0, [sp, #0x24]
	mov r5, r3, asr #6
	mov r4, r2, asr #6
	ldrsh r1, [r0, #0x1e]
	ldr r3, [r0, #8]
	mov r0, r5, lsl #0x10
	str r0, [sp, #0x3c]
	add r0, r1, r3, asr #12
	mov r1, r0, lsl #0xa
	mov r0, r4, lsl #0x10
	str r0, [sp, #0x38]
	mov r0, r1, lsr #0x10
	mov r2, r11, lsl #0x10
	str r0, [sp, #0x20]
	movs r0, r2, asr #0x10
	ldr r0, [sp, #0x20]
	movmi r11, #0
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	movmi r0, #0
	strmi r0, [sp, #0x20]
	mov r0, #0
	str r0, [sp, #0x30]
_02008A08:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _02008A2C
	ldr r0, =mapSystemTask
	ldr r4, [r0, #0x14]
	ldr r0, [sp, #0x24]
	ldr r0, [r0, #0x30]
	str r0, [sp, #0x2c]
	b _02008A40
_02008A2C:
	ldr r0, =mapSystemTask
	ldr r4, [r0, #0x18]
	ldr r0, [sp, #0x24]
	ldr r0, [r0, #0x34]
	str r0, [sp, #0x2c]
_02008A40:
	mov r0, #0
	str r0, [sp, #0x28]
_02008A48:
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x28]
	add r9, r1, r0
	ldr r0, [sp, #0x38]
	cmp r9, r0, lsr #16
	bge _02008B04
	ldr r2, [sp, #0x28]
	ldr r0, [sp, #0x2c]
	mov r1, #0x280
	mla r10, r2, r1, r0
	mov r5, #0
_02008A74:
	ldr r0, [sp, #0x3c]
	add r1, r11, r5
	cmp r1, r0, lsr #16
	bge _02008AE8
	ldr r0, =mapSystemTask
	add r7, r10, r5, lsl #4
	ldr r2, [r0, #0x10]
	ldrh r0, [r4, #0]
	mov r6, #0
	mla r1, r0, r9, r1
	add r0, r4, r1, lsl #1
	ldrh r0, [r0, #4]
	add r8, r2, r0, lsl #7
_02008AA8:
	mov r0, r8
	mov r1, r7
	mov r2, #0x10
	bl MIi_CpuCopy32
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	add r8, r8, #0x10
	add r7, r7, #0x50
	cmp r6, #8
	blo _02008AA8
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #5
	blo _02008A74
_02008AE8:
	ldr r0, [sp, #0x28]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x28]
	cmp r0, #4
	blo _02008A48
_02008B04:
	ldr r0, [sp, #0x30]
	add r0, r0, #1
	str r0, [sp, #0x30]
	cmp r0, #2
	blo _02008A08
_02008B18:
	ldr r0, [sp, #0x34]
	add r0, r0, #1
	str r0, [sp, #0x34]
	cmp r0, #2
	ldr r0, [sp, #0x24]
	add r0, r0, #0x70
	str r0, [sp, #0x24]
	blo _02008974
	mov r9, #0
	ldr r8, =mapCamera
	mov r5, r9
	mov r4, r9
	mov r11, #4
_02008B4C:
	ldr r0, [r8, #0]
	cmp r9, #0
	moveq r10, #0xa
	movne r10, #0x16
	tst r0, #0x10000000
	bne _02008C80
	tst r0, #1
	ldrsh r2, [r8, #0x1c]
	ldr r3, [r8, #4]
	ldrsh r0, [r8, #0x1e]
	ldr r1, [r8, #8]
	add r2, r2, r3, asr #12
	add r0, r0, r1, asr #12
	mov r2, r2, asr #3
	mov r0, r0, asr #3
	and r6, r2, #7
	and r7, r0, #7
	beq _02008C04
	ldr r0, [r8, #0x28]
	ldr r1, [r8, #0x24]
	add r0, r0, #7
	add r1, r1, #7
	stmia sp, {r5, r10}
	mov r0, r0, asr #3
	mov r1, r1, asr #3
	add r0, r0, #1
	str r5, [sp, #8]
	cmp r0, #0x20
	movgt r0, #0x20
	add r1, r1, #1
	cmp r1, #0x28
	movgt r1, #0x28
	str r5, [sp, #0xc]
	mov r1, r1, lsl #0x10
	str r5, [sp, #0x10]
	mov r0, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
	ldr r0, [r8, #0x30]
	mov r1, r6
	mov r2, r7
	mov r3, #0x28
	bl Mappings__ReadMappingsCompressed
_02008C04:
	ldr r0, [r8, #0]
	tst r0, #2
	beq _02008C80
	ldr r0, [r8, #0x28]
	mov r2, r7
	add r0, r0, #7
	mov r0, r0, asr #3
	add r1, r0, #1
	ldr r0, [r8, #0x24]
	cmp r1, #0x20
	add r0, r0, #7
	stmia sp, {r4, r10}
	mov r0, r0, asr #3
	str r4, [sp, #8]
	movgt r1, #0x20
	add r0, r0, #1
	cmp r0, #0x28
	movgt r0, #0x28
	str r11, [sp, #0xc]
	mov r0, r0, lsl #0x10
	str r4, [sp, #0x10]
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r0, r0, lsr #0x10
	str r4, [sp, #0x14]
	str r0, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r8, #0x34]
	mov r1, r6
	mov r3, #0x28
	bl Mappings__ReadMappingsCompressed
_02008C80:
	add r8, r8, #0x70
	add r9, r9, #1
	cmp r9, #2
	blo _02008B4C
	ldr r0, =mapCamera
	ldr r3, =FX_SinCosTable_
	ldrh r1, [r0, #0x2c]
	add r0, sp, #0x40
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_Rot22_
	ldr r1, =mapCamera
	add r0, sp, #0x40
	ldr r2, [r1, #0x24]
	ldr r3, [r1, #0x28]
	mov r1, r0
	bl MTX_ScaleApply22
	ldr r0, =mapCamera
	ldrsh r2, [r0, #0x1c]
	ldr r3, [r0, #4]
	ldr r1, [r0, #0x24]
	add r0, r3, r2, lsl #12
	and r0, r0, #0x7000
	bl FX_Div
	mov r2, r0, lsl #4
	ldr r0, =mapCamera
	ldrsh r3, [r0, #0x1e]
	ldr r4, [r0, #8]
	ldr r1, [r0, #0x28]
	add r0, r4, r3, lsl #12
	and r0, r0, #0x7000
	mov r4, r2, asr #0x10
	bl FX_Div
	ldr r1, =mapCamera
	mov r0, r0, lsl #4
	ldr r1, [r1, #0]
	mov r5, r0, asr #0x10
	tst r1, #1
	beq _02008D5C
	ldr r0, =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0, #0]
	mov r6, #0
	add r7, r0, #0x28
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
_02008D5C:
	ldr r0, =mapCamera
	ldr r0, [r0, #0]
	tst r0, #2
	beq _02008D98
	ldr r0, =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0, #0]
	mov r6, #0
	add r7, r0, #0x40
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
_02008D98:
	ldr r0, =mapCamera
	ldr r3, =FX_SinCosTable_
	ldrh r1, [r0, #0x9c]
	add r0, sp, #0x40
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_Rot22_
	ldr r1, =mapCamera
	add r0, sp, #0x40
	ldr r2, [r1, #0x94]
	ldr r3, [r1, #0x98]
	mov r1, r0
	bl MTX_ScaleApply22
	ldr r0, =mapCamera
	ldrsh r2, [r0, #0x8c]
	ldr r3, [r0, #0x74]
	ldr r1, [r0, #0x94]
	add r0, r3, r2
	and r0, r0, #0x7000
	bl FX_Div
	mov r2, r0, lsl #4
	ldr r0, =mapCamera
	ldrsh r3, [r0, #0x8e]
	ldr r4, [r0, #0x78]
	ldr r1, [r0, #0x98]
	add r0, r4, r3
	and r0, r0, #0x7000
	mov r4, r2, asr #0x10
	bl FX_Div
	ldr r1, =mapCamera
	mov r0, r0, lsl #4
	ldr r1, [r1, #0x70]
	mov r5, r0, asr #0x10
	tst r1, #1
	beq _02008E64
	ldr r0, =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0, #4]
	mov r6, #0
	add r7, r0, #0x28
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
_02008E64:
	ldr r0, =mapCamera
	ldr r0, [r0, #0x70]
	tst r0, #2
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, =VRAMSystem__GFXControl
	add r1, sp, #0x40
	ldr r0, [r0, #4]
	mov r6, #0
	add r7, r0, #0x40
	ldmia r1, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	strh r6, [r7, #0x12]
	strh r6, [r7, #0x10]
	strh r4, [r7, #0x14]
	strh r5, [r7, #0x16]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

BOOL MapSys__GetDispSelect(void)
{
    return GX_GetDispSelect() == GX_DISP_SELECT_MAIN_SUB ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;
}

MapSysCamera *MapSys__GetCameraA(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) != 0)
        return &mapCamera.camera[1];
    else
        return &mapCamera.camera[0];
}

MapSysCamera *MapSys__GetCameraB(void)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) != 0)
        return &mapCamera.camera[0];
    else
        return &mapCamera.camera[1];
}

NONMATCH_FUNC void MapSys__Func_2008F28(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	cmp r0, #0
	bne _02008F64
	ldr r1, =mapSystemTask
	ldr r2, [r1, #0x100]
	tst r2, #2
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, =renderCurrentDisplay
	bic r2, r2, #2
	mov r3, #1
	str r3, [r0]
	orr r0, r2, #0x200
	str r0, [r1, #0x100]
	b _02008F90
_02008F64:
	ldr r1, =mapSystemTask
	ldr r2, [r1, #0x100]
	tst r2, #2
	movne r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, =renderCurrentDisplay
	orr r2, r2, #2
	mov r3, #0
	str r3, [r0]
	orr r0, r2, #0x200
	str r0, [r1, #0x100]
_02008F90:
	ldr r2, =mapCamera
	ldr r3, =mapCamera+0x00000070
	mov ip, #0
_02008F9C:
	add r1, r2, ip, lsl #2
	add r0, r3, ip, lsl #2
	ldr lr, [r1, #4]
	ldr r4, [r0, #4]
	add ip, ip, #1
	eor lr, lr, r4
	str lr, [r1, #4]
	ldr r4, [r0, #4]
	and ip, ip, #0xff
	eor lr, r4, lr
	str lr, [r0, #4]
	ldr r4, [r1, #4]
	cmp ip, #2
	eor r4, r4, lr
	str r4, [r1, #4]
	ldr lr, [r1, #0xc]
	ldr r4, [r0, #0xc]
	eor lr, lr, r4
	str lr, [r1, #0xc]
	ldr r4, [r0, #0xc]
	eor lr, r4, lr
	str lr, [r0, #0xc]
	ldr r4, [r1, #0xc]
	eor r4, r4, lr
	str r4, [r1, #0xc]
	ldr lr, [r1, #0x38]
	ldr r4, [r0, #0x38]
	eor lr, lr, r4
	str lr, [r1, #0x38]
	ldr r4, [r0, #0x38]
	eor lr, r4, lr
	str lr, [r0, #0x38]
	ldr r4, [r1, #0x38]
	eor r4, r4, lr
	str r4, [r1, #0x38]
	ldr lr, [r1, #0x24]
	ldr r4, [r0, #0x24]
	eor r4, lr, r4
	str r4, [r1, #0x24]
	ldr r4, [r0, #0x24]
	ldr lr, [r1, #0x24]
	eor r4, r4, lr
	str r4, [r0, #0x24]
	ldr r0, [r1, #0x24]
	eor r0, r0, r4
	str r0, [r1, #0x24]
	blo _02008F9C
	ldrh ip, [r2, #0x2c]
	ldrh r1, [r3, #0x2c]
	mov r0, #1
	eor ip, ip, r1
	strh ip, [r2, #0x2c]
	ldrh ip, [r2, #0x2c]
	eor r1, r1, ip
	strh r1, [r3, #0x2c]
	ldrh r1, [r3, #0x2c]
	eor r1, ip, r1
	strh r1, [r2, #0x2c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void MapSys__GetPosition(MapSysCamera *camera, fx32 *x, fx32 *y)
{
    *x = camera->disp_pos.x + camera->velocity.x + FX32_FROM_WHOLE(camera->offset.x);
    *y = camera->disp_pos.y + camera->velocity.y + FX32_FROM_WHOLE(camera->offset.y);
}

void MapSys__Func_20090D0(MapSysCamera *camera, fx32 offsetX, fx32 offsetY, fx16 *x, fx16 *y)
{
    fx32 cy;
    fx32 cx;
    MapSys__GetPosition(camera, &cx, &cy);

    *x = FX32_TO_WHOLE(offsetX - cx);
    *y = FX32_TO_WHOLE(offsetY - cy);
}

void MapSys__SetTargetOffsetA(fx32 x, fx32 y)
{
    MapSys__SetTargetOffset(GRAPHICS_ENGINE_A, x, y);
}

void MapSys__SetTargetOffset(s32 id, fx32 x, fx32 y)
{
    mapCamera.camera[id].targetOffset[1].x = x;
    mapCamera.camera[id].targetOffset[1].y = y;

    if ((mapCamera.camera[id].flags & (MAPSYS_CAMERA_FLAG_2000 | MAPSYS_CAMERA_FLAG_1000)) == 0)
    {
        mapCamera.camera[id].targetOffset[0].x = mapCamera.camera[id].targetOffset[1].x;
        mapCamera.camera[id].targetOffset[0].y = mapCamera.camera[id].targetOffset[1].y;
    }
}

void MapSys__Func_2009190(s32 id)
{
    mapCamera.camera[id].flags |= MAPSYS_CAMERA_FLAG_40;
}

void MapSys__Func_20091B0(s32 id)
{
    mapCamera.camera[id].flags |= MAPSYS_CAMERA_FLAG_80;
}

void MapSys__Func_20091D0(s32 id)
{
    mapCamera.camera[id].flags &= ~MAPSYS_CAMERA_FLAG_40;
}

void MapSys__Func_20091F0(s32 id)
{
    mapCamera.camera[id].flags &= ~MAPSYS_CAMERA_FLAG_80;
}

NONMATCH_FUNC s32 MapSys__GetScreenSwapPos(fx32 x)
{
#ifdef NON_MATCHING
    BOOL didHit                    = FALSE;
    MapCameraZones *mapCameraZones = mapSysFiles.mapCameraZones;

    x = MTM_MATH_CLIP(x, 0, FX32_FROM_WHOLE(mapCamera.camControl.width) - 1);

    fx32 screenSwapY = 0;
    fx32 prevScreenSwapY;

    fx32 mapY = 0;
    while (screenSwapY < mapCameraZones->height)
    {
        u32 zone = (mapCameraZones->data[((mapY + (x >> 18)) << 14) >> 16] >> ((2 * (mapY + (x >> 18))) & 7)) & 3;

        if (!didHit && zone != 0)
        {
            if (zone == 1)
                return screenSwapY << 18;

            didHit          = TRUE;
            prevScreenSwapY = screenSwapY;
        }

        if (didHit && zone == 1)
        {
            return (prevScreenSwapY + screenSwapY) << 17;
        }

        screenSwapY++;
        mapY += mapCameraZones->width;
    }

    if (IsBossStage())
    {
        // ???
    }

    return 0;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r1, =mapSystemTask
	mov r3, #0
	cmp r0, #0
	ldr r1, [r1, #0x1c]
	movlt r5, r3
	blt _02009244
	ldr r4, =mapCamera+0x000000E0
	ldrh r4, [r4, #0x4a]
	mov r4, r4, lsl #0xc
	sub r5, r4, #1
	cmp r0, r5
	movle r5, r0
_02009244:
	ldrh lr, [r1, #2]
	ldrh r4, [r1, #0]
	mov r0, #0
	cmp lr, #0
	ble _020092D0
	mov ip, r0
	mov r7, #1
_02009260:
	add r9, ip, r5, asr #18
	mov r6, r9, lsl #0xe
	add r8, r1, r6, lsr #16
	mov r6, r9, lsl #0x1e
	mov r6, r6, lsr #0x1d
	mov r6, r6, lsl #0x10
	ldrb r8, [r8, #4]
	mov r6, r6, lsr #0x10
	cmp r3, #0
	mov r6, r8, asr r6
	and r6, r6, #3
	bne _020092AC
	cmp r6, #0
	beq _020092AC
	cmp r6, #1
	moveq r0, r0, lsl #0x12
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r3, r7
	mov r2, r0
_020092AC:
	cmp r3, #1
	cmpeq r6, #1
	addeq r0, r2, r0
	moveq r0, r0, lsl #0x11
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r0, #1
	cmp r0, lr
	add ip, ip, r4
	blt _02009260
_020092D0:
	bl IsBossStage
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void MapSys__GetCameraPositionCB(fx32 *x, fx32 *y)
{
    MapSys__GetPosition(&mapCamera.camera[0], x, y);
}

void MapSys__LoadZoneTiles(void *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "MAP", archive);

    void *layout = NNS_FndGetArchiveFileByIndex(&arc, ARC_MAP_FILE_LAYOUTA);
    MI_CpuClearFast(VRAM_BG + 0x10000, 0x10000);
    MI_CpuClearFast(VRAM_DB_BG + 0x10000, 0x10000);
    RenderCore_CPUCopyCompressed(layout, VRAM_BG + 0x10000);
    RenderCore_CPUCopyCompressed(layout, VRAM_DB_BG + 0x10000);

    NNS_FndUnmountArchive(&arc);

    MapSys__LoadCollision(archive);
}

void MapSys__LoadZoneMap(void *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "MAP", archive);

    u16 *palette = NNS_FndGetArchiveFileByIndex(&arc, ARC_MAP_FILE_PALETTE);

    LoadCompressedPalette(palette, PALETTE_MODE_BG, VRAMKEY_TO_KEY(0x4000));
    LoadCompressedPalette(palette, PALETTE_MODE_BG, VRAMKEY_TO_KEY(0x6000));
    LoadCompressedPalette(palette, PALETTE_MODE_SUB_BG, VRAMKEY_TO_KEY(0x4000));
    LoadCompressedPalette(palette, PALETTE_MODE_SUB_BG, VRAMKEY_TO_KEY(0x6000));

    NNS_FndUnmountArchive(&arc);

    MapSys__LoadTileLayout(archive);
}

void MapSys__LoadBossTiles_Zone1(void *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "RAW", archive);
    NNS_FndUnmountArchive(&arc);
    MapSys__LoadCollision(archive);
}

void MapSys__LoadBossTiles_Zone2(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossTiles_Zone3(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossTiles_Zone4(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossTiles_Zone5(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossTiles_Zone6(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossTiles_Zone7(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossTiles_ZoneF(void *archive)
{
    MapSys__LoadBossTiles_Zone1(archive);
}

void MapSys__LoadBossMap_Zone1(void *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "MAP", archive);
    NNS_FndUnmountArchive(&arc);
    MapSys__LoadTileLayout(archive);
}

void MapSys__LoadBossMap_Zone2(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadBossMap_Zone3(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadBossMap_Zone4(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadBossMap_Zone5(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadBossMap_Zone6(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadBossMap_Zone7(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadBossMap_ZoneF(void *archive)
{
    MapSys__LoadBossMap_Zone1(archive);
}

void MapSys__LoadCollision(void *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "RAW", archive);

    void *heightMasks                = NNS_FndGetArchiveFileByIndex(&arc, ARC_RAW_FILE_HEIGHTMASKS);
    mapSysFiles.collisionHeightMasks = HeapAllocHead(HEAP_ITCM, MI_GetUncompressedSize(heightMasks));
    RenderCore_CPUCopyCompressed(heightMasks, mapSysFiles.collisionHeightMasks);

    void *attributes                = NNS_FndGetArchiveFileByIndex(&arc, ARC_RAW_FILE_ATTRIBUTES);
    mapSysFiles.collisionAttributes = HeapAllocHead(HEAP_ITCM, MI_GetUncompressedSize(attributes));
    RenderCore_CPUCopyCompressed(attributes, mapSysFiles.collisionAttributes);

    void *angles                = NNS_FndGetArchiveFileByIndex(&arc, ARC_RAW_FILE_ANGLES);
    mapSysFiles.collisionAngles = HeapAllocHead(HEAP_ITCM, MI_GetUncompressedSize(angles));
    RenderCore_CPUCopyCompressed(angles, mapSysFiles.collisionAngles);

    void *chunks         = NNS_FndGetArchiveFileByIndex(&arc, ARC_RAW_FILE_CHUNKS);
    mapSysFiles.blockset = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(chunks));
    RenderCore_CPUCopyCompressed(chunks, mapSysFiles.blockset);

    NNS_FndUnmountArchive(&arc);
}

void MapSys__LoadTileLayout(void *archive)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "MAP", archive);

    void *layoutA            = NNS_FndGetArchiveFileByIndex(&arc, ARC_MAP_FILE_LAYOUTA);
    mapSysFiles.mapLayout[0] = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(layoutA));
    RenderCore_CPUCopyCompressed(layoutA, mapSysFiles.mapLayout[0]);

    void *layoutB            = NNS_FndGetArchiveFileByIndex(&arc, ARC_MAP_FILE_LAYOUTB);
    mapSysFiles.mapLayout[1] = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(layoutB));
    RenderCore_CPUCopyCompressed(layoutB, mapSysFiles.mapLayout[1]);

    void *cameraZones          = NNS_FndGetArchiveFileByIndex(&arc, ARC_MAP_FILE_CAMERAZONES);
    mapSysFiles.mapCameraZones = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(cameraZones));
    RenderCore_CPUCopyCompressed(cameraZones, mapSysFiles.mapCameraZones);

    NNS_FndUnmountArchive(&arc);
}

void MapSys__InitStageBounds(void)
{
    mapCamera.camControl.width  = mapSysFiles.mapLayout[0]->width << 6;
    mapCamera.camControl.height = mapSysFiles.mapLayout[0]->height << 6;

    mapCamera.camControl.bounds.left   = FLOAT_TO_FX32(8.0);
    mapCamera.camControl.bounds.top    = FLOAT_TO_FX32(8.0);
    mapCamera.camControl.bounds.right  = FX32_FROM_WHOLE(mapCamera.camControl.width - 8);
    mapCamera.camControl.bounds.bottom = FX32_FROM_WHOLE(mapCamera.camControl.height - 8);

    MapSysCamera *cameraA      = &mapCamera.camera[0];
    cameraA->screenMappings[0] = HeapAllocHead(HEAP_USER, 0xA00);
    cameraA->screenMappings[1] = HeapAllocHead(HEAP_USER, 0xA00);

    MapSysCamera *cameraB      = &mapCamera.camera[1];
    cameraB->screenMappings[0] = HeapAllocHead(HEAP_USER, 0xA00);
    cameraB->screenMappings[1] = HeapAllocHead(HEAP_USER, 0xA00);
}

void MapSys__InitBoundsForStage(void)
{
    u32 c;

    mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS;
    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_DISABLE_SCREEN_SWAP;
    mapCamera.camControl.field_8 = FLOAT_TO_FX32(80.0);

    mapCamera.camera[0].targetPlayerID = 0;
    mapCamera.camera[1].targetPlayerID = -1;

    mapCamera.camera[0].targetOffset[0].x = FLOAT_TO_FX32(128.0);
    mapCamera.camera[0].targetOffset[0].y = FLOAT_TO_FX32(96.0);

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_DISABLE_SCREEN_SWAP) == 0)
    {
        fx32 spawnX;
        fx32 spawnY;
        if ((gameState.gameFlag & GAME_FLAG_RECALL_ACTIVE) != 0)
        {
            spawnX = gameState.recallPosition.x;
            spawnY = gameState.recallPosition.y;
        }
        else
        {
            spawnX = playerGameStatus.spawnPosition.x;
            spawnY = playerGameStatus.spawnPosition.y;
        }

        if (MapSys__GetScreenSwapPos(spawnX) >= spawnY)
        {
            GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
            renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

            mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP;
            mapCamera.camControl.field_C  = 0;
            mapCamera.camControl.field_10 = FLOAT_TO_FX32(BOTTOM_SCREEN_CAMERA_OFFSET);
        }
        else
        {
            GX_SetDispSelect(GX_DISP_SELECT_SUB_MAIN);
            renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP;
            mapCamera.camControl.field_C  = 0;
            mapCamera.camControl.field_10 = -FLOAT_TO_FX32(BOTTOM_SCREEN_CAMERA_OFFSET);
        }
    }

    MapSysCamera *camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->flags |= MAPSYS_CAMERA_FLAG_8 | MAPSYS_CAMERA_FLAG_4 | MAPSYS_CAMERA_FLAG_ENGINE_B_ENABLED | MAPSYS_CAMERA_FLAG_ENGINE_A_ENABLED;
        camera->flags |= MAPSYS_CAMERA_FLAG_20000 | MAPSYS_CAMERA_FLAG_10000;

        camera->scale.x = FLOAT_TO_FX32(1.0);
        camera->scale.y = FLOAT_TO_FX32(1.0);

        camera->boundsL = mapCamera.camControl.bounds.left;
        camera->boundsT = mapCamera.camControl.bounds.top;
        camera->boundsR = mapCamera.camControl.bounds.right;
        camera->boundsB = mapCamera.camControl.bounds.bottom;

        camera++;
    }
}

void MapSys__InitBoundsForVSRings(void)
{
    u32 c;

    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS;
    mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_DISABLE_SCREEN_SWAP;

    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP;
    mapCamera.camControl.field_C  = 0;
    mapCamera.camControl.field_10 = 0;

    MapSysCamera *camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->flags |= MAPSYS_CAMERA_FLAG_8 | MAPSYS_CAMERA_FLAG_4 | MAPSYS_CAMERA_FLAG_ENGINE_B_ENABLED | MAPSYS_CAMERA_FLAG_ENGINE_A_ENABLED;
        camera->flags |= MAPSYS_CAMERA_FLAG_20000 | MAPSYS_CAMERA_FLAG_10000;

        camera->boundsL = mapCamera.camControl.bounds.left;
        camera->boundsT = mapCamera.camControl.bounds.top;
        camera->boundsR = mapCamera.camControl.bounds.right;
        camera->boundsB = mapCamera.camControl.bounds.bottom;

        camera++;
    }

    mapCamera.camera[0].targetPlayerID    = 0;
    mapCamera.camera[0].targetOffset[0].x = FLOAT_TO_FX32(128.0);
    mapCamera.camera[0].targetOffset[0].y = FLOAT_TO_FX32(96.0);
    mapCamera.camera[0].scale.x           = FLOAT_TO_FX32(1.0);
    mapCamera.camera[0].scale.y           = FLOAT_TO_FX32(1.0);

    MapSysCamera *cameraB      = &mapCamera.camera[1];
    cameraB->targetPlayerID    = 0;
    cameraB->targetOffset[0].x = FLOAT_TO_FX32(128.0);
    cameraB->targetOffset[0].y = FLOAT_TO_FX32(88.0);
    cameraB->scale.x           = FLOAT_TO_FX32(1.0);
    cameraB->scale.y           = FLOAT_TO_FX32(1.0);
}

void MapSys__SetupBoss_Zone5(void)
{
    u32 c;

    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS;
    mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_DISABLE_SCREEN_SWAP;

    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP;
    mapCamera.camControl.field_C  = 0;
    mapCamera.camControl.field_10 = 0;

    MapSysCamera *camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->flags |= MAPSYS_CAMERA_FLAG_8 | MAPSYS_CAMERA_FLAG_4 | MAPSYS_CAMERA_FLAG_ENGINE_B_ENABLED | MAPSYS_CAMERA_FLAG_ENGINE_A_ENABLED;
        camera->flags |= MAPSYS_CAMERA_FLAG_20000 | MAPSYS_CAMERA_FLAG_10000;

        camera->boundsL = mapCamera.camControl.bounds.left;
        camera->boundsT = mapCamera.camControl.bounds.top;
        camera->boundsR = mapCamera.camControl.bounds.right;
        camera->boundsB = mapCamera.camControl.bounds.bottom;

        camera++;
    }

    mapCamera.camera[0].targetPlayerID    = 0;
    mapCamera.camera[0].targetOffset[0].x = FLOAT_TO_FX32(128.0);
    mapCamera.camera[0].targetOffset[0].y = FLOAT_TO_FX32(96.0);
    mapCamera.camera[0].scale.x           = FLOAT_TO_FX32(1.0);
    mapCamera.camera[0].scale.y           = FLOAT_TO_FX32(1.0);

    MapSysCamera *cameraB      = &mapCamera.camera[1];
    cameraB->targetPlayerID    = 0;
    cameraB->targetOffset[0].x = FLOAT_TO_FX32(128.0);
    cameraB->targetOffset[0].y = FLOAT_TO_FX32(88.0);
    cameraB->scale.x           = FLOAT_TO_FX32(1.0);
    cameraB->scale.y           = FLOAT_TO_FX32(1.0);
}

void MapSys__Destructor(Task *task)
{
    for (u32 c = 0; c < 2; c++)
    {
        HeapFree(HEAP_USER, mapCamera.camera[c].screenMappings[0]);
        HeapFree(HEAP_USER, mapCamera.camera[c].screenMappings[1]);
    }

    ReleaseWaterSurface();
    MapFarSys__ReleaseBG();

    mapSystemTask = NULL;
}

void MapSys__Main_Zone(void)
{
    u32 c;

    MapSys *work = TaskGetWorkCurrent(MapSys);

    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_200;
    mapCamera.camControl.prevFlags = mapCamera.camControl.flags;

    mapCamera.camera[0].prev_disp_pos.x = mapCamera.camera[0].disp_pos.x;
    mapCamera.camera[0].prev_disp_pos.y = mapCamera.camera[0].disp_pos.y;

    mapCamera.camera[1].prev_disp_pos.x = mapCamera.camera[1].disp_pos.x;
    mapCamera.camera[1].prev_disp_pos.y = mapCamera.camera[1].disp_pos.y;

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        fx32 value;
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) == 0)
            value = BOTTOM_SCREEN_CAMERA_OFFSET * mapCamera.camera[0].scale.y;
        else
            value = -BOTTOM_SCREEN_CAMERA_OFFSET * mapCamera.camera[0].scale.y;
        mapCamera.camControl.field_10 = value;

        mapCamera.camControl.field_8 = 80 * mapCamera.camera[0].scale.y;
    }

    MapSys__HandleCameraScreenSwap();
    MapSys__HandleCamera(work);
    MapFarSys__ProcessBG();
    ProcessWaterSurface();

    MapSysCamera *camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->disp_pos.x += camera->velocity.x;
        camera->disp_pos.y += camera->velocity.y;

        camera++;
    }

    SetObjCameraPosition(mapCamera.camera[0].disp_pos.x, mapCamera.camera[0].disp_pos.y, mapCamera.camera[1].disp_pos.x, mapCamera.camera[1].disp_pos.y);
    MapSys__DrawLayout();

    camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->velocity.x = camera->velocity.y = 0;
        camera->offset.x = camera->offset.y = 0;

        camera++;
    }
}

void MapSys__Main_Boss(void)
{
    u32 c;

    mapCamera.camControl.prevFlags = mapCamera.camControl.flags;

    MapSys *work = TaskGetWorkCurrent(MapSys);

    mapCamera.camControl.prevFlags = mapCamera.camControl.flags;

    mapCamera.camera[0].prev_disp_pos.x = mapCamera.camera[0].disp_pos.x;
    mapCamera.camera[0].prev_disp_pos.y = mapCamera.camera[0].disp_pos.y;

    mapCamera.camera[1].prev_disp_pos.x = mapCamera.camera[1].disp_pos.x;
    mapCamera.camera[1].prev_disp_pos.y = mapCamera.camera[1].disp_pos.y;

    MapSys__HandleCamera(work);

    MapSysCamera *camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->disp_pos.x += camera->velocity.x;
        camera->disp_pos.y += camera->velocity.y;

        camera++;
    }

    SetObjCameraPosition(mapCamera.camera[0].disp_pos.x, mapCamera.camera[0].disp_pos.y, mapCamera.camera[1].disp_pos.x, mapCamera.camera[1].disp_pos.y);

    camera = &mapCamera.camera[0];
    for (c = 0; c < 2; c++)
    {
        camera->velocity.x = camera->velocity.y = 0;
        camera->offset.x = camera->offset.y = 0;

        camera++;
    }
}

NONMATCH_FUNC void MapSys__HandleCamera(MapSys *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, =mapSystemTask
	mov r6, r0
	ldr r1, [r1, #0x100]
	tst r1, #0x100
	bne _02009D10
	bl MapSys__HandleCamLook
_02009D10:
	ldr r0, =mapSystemTask
	ldr r1, [r0, #0x100]
	tst r1, #0x200
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	tst r1, #1
	beq _02009DBC
	ldr r0, [r0, #0x20]
	ldr r4, =mapCamera
	tst r0, #0x140
	mov r0, r6
	mov r1, #0
	bne _02009D54
	bl MapSys__Func_2009E3C
	mov r0, r6
	mov r1, #0
	bl MapSys__Func_200A780
	b _02009D58
_02009D54:
	bl MapSys__HandleHBounds
_02009D58:
	ldr r0, [r4, #0]
	mov r1, #0
	tst r0, #0x280
	mov r0, r6
	bne _02009D80
	bl MapSys__Func_2009E80
	mov r0, r6
	mov r1, #0
	bl MapSys__Func_200A7E8
	b _02009D84
_02009D80:
	bl MapSys__HandleVBounds
_02009D84:
	ldr r4, =mapCamera+0x00000070
	ldr r0, [r4, #0]
	tst r0, #0x140
	bne _02009DA0
	mov r0, r6
	mov r1, #1
	bl MapSys__Func_200A8D8
_02009DA0:
	ldr r0, [r4, #0]
	tst r0, #0x280
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r6
	mov r1, #1
	bl MapSys__Func_200A910
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02009DBC:
	mov r5, #0
	cmp r5, #2
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r4, =mapCamera
	mov r7, #0x70
_02009DD0:
	mul r8, r5, r7
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl Player__Func_201301C
	ldr r0, [r4, r8]
	mov r1, r5
	tst r0, #0x140
	mov r0, r6
	bne _02009DFC
	bl MapSys__Func_2009E3C
	b _02009E00
_02009DFC:
	bl MapSys__HandleHBounds
_02009E00:
	ldr r0, [r4, r8]
	mov r1, r5
	tst r0, #0x280
	mov r0, r6
	bne _02009E1C
	bl MapSys__Func_200A460
	b _02009E20
_02009E1C:
	bl MapSys__HandleVBounds
_02009E20:
	add r5, r5, #1
	cmp r5, #2
	blt _02009DD0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void MapSys__Func_2009E3C(MapSys *work, s32 id)
{
    if ((mapCamera.camera[id].flags & (MAPSYS_CAMERACTRL_FLAG_10 | MAPSYS_CAMERACTRL_FLAG_4000)) == 0)
        MapSys__FollowTargetX(work, id);

    MapSys__HandleCamBoundsX(work, id);
}

NONMATCH_FUNC void MapSys__Func_2009E80(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, =mapCamera
	mov r7, r1
	mov r1, #0x70
	mla r5, r7, r1, r4
	mov r8, r0
	ldr r0, [r5, #4]
	bl MapSys__GetScreenSwapPos
	ldr r1, =mapSystemTask
	mov r6, r0
	ldr r0, [r1, #0x100]
	tst r0, #8
	ldrne r6, [r1, #0x114]
	tst r0, #0x10000
	beq _0200A2F8
	tst r0, #0x20000
	ldr r2, [r5, #8]
	ldr r1, [r8, #8]
	bne _02009EE8
	add r1, r2, r1
	mov r0, r8
	str r1, [r5, #8]
	bl MapSys__Func_200A948
	mov r0, r8
	bl MapSys__Func_200AAF8
	b _0200A440
_02009EE8:
	add r1, r2, r1
	ldr r0, =mapSystemTask
	str r1, [r5, #8]
	ldr r0, [r0, #0x100]
	ands r2, r0, #2
	beq _02009F18
	ldrsb r1, [r5, #0x46]
	ldr r0, =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	blt _02009F38
_02009F18:
	cmp r2, #0
	bne _0200A020
	ldrsb r1, [r5, #0x46]
	ldr r0, =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	ble _0200A020
_02009F38:
	mov r0, r8
	bl MapSys__Func_200A948
	ldr r0, =mapSystemTask
	ldr r0, [r0, #0x100]
	ands r1, r0, #2
	beq _02009FB4
	ldr r0, [r8, #8]
	cmp r0, #0
	bge _02009FB4
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r0, r1, r0, r6
	ldr r2, [r5, #8]
	cmp r2, r0
	bge _0200A440
	blt _02009F90
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_02009F90:
	ldr r1, =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_02009FB4:
	cmp r1, #0
	bne _0200A440
	ldr r0, [r8, #8]
	cmp r0, #0
	ble _0200A440
	ldr r1, [r5, #0x28]
	mov r0, #0xe8
	mul r2, r1, r0
	ldr r0, [r5, #8]
	sub r1, r6, r2
	cmp r0, r1
	ble _0200A440
	ldr r2, [r5, #0x5c]
	cmp r0, r2
	blt _02009FFC
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_02009FFC:
	ldr r1, =mapSystemTask
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A020:
	cmp r2, #0
	ldr r0, [r8, #8]
	bne _0200A190
	cmp r0, #0
	ble _0200A0D8
	ldr r1, [r5, #0x28]
	mov r0, #0xe8
	mul r2, r1, r0
	ldr r0, [r5, #8]
	sub r1, r6, r2
	cmp r0, r1
	ble _0200A08C
	ldr r2, [r5, #0x5c]
	cmp r0, r2
	blt _0200A068
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_0200A068:
	ldr r1, =mapSystemTask
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A08C:
	mov r0, r8
	bl MapSys__Func_200AA18
	cmp r0, #0
	beq _0200A440
	ldrsb r1, [r5, #0x46]
	ldr r0, =gPlayerList
	ldr r2, [r5, #0x54]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =mapSystemTask
	ldr r3, [r0, #0x48]
	mov r0, r8
	sub r2, r3, r2
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A0D8:
	bge _0200A160
	ldr r0, [r5, #0x28]
	mov r1, #0xe8
	mul r2, r0, r1
	ldr r0, [r5, #8]
	sub r2, r6, r2
	cmp r0, r2
	bge _0200A440
	ldrsb r4, [r5, #0x46]
	ldr r3, =gPlayerList
	ldr r2, [r5, #0x54]
	ldr r3, [r3, r4, lsl #2]
	ldr r3, [r3, #0x48]
	sub r2, r3, r2
	cmp r0, r2
	bge _0200A440
	str r2, [r5, #8]
	ldr r0, [r5, #0x5c]
	cmp r2, r0
	blt _0200A13C
	ldr r0, [r5, #0x28]
	mul r1, r0, r1
	sub r0, r6, r1
	cmp r2, r0
	movle r0, r2
_0200A13C:
	ldr r1, =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A160:
	mov r0, r8
	bl MapSys__Func_200AAF8
	cmp r0, #0
	beq _0200A440
	ldr r1, =mapSystemTask
	mov r0, r8
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0200A190:
	cmp r0, #0
	ble _0200A220
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r2, r1, r0, r6
	ldr r4, [r5, #8]
	cmp r4, r2
	ble _0200A440
	ldrsb r3, [r5, #0x46]
	ldr r2, =gPlayerList
	ldr r1, [r5, #0x54]
	ldr r2, [r2, r3, lsl #2]
	ldr r2, [r2, #0x48]
	sub r2, r2, r1
	cmp r4, r2
	ble _0200A440
	str r2, [r5, #8]
	ldr r1, [r5, #0x28]
	mla r0, r1, r0, r6
	cmp r2, r0
	blt _0200A1FC
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_0200A1FC:
	ldr r1, =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A220:
	bge _0200A2C8
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r0, r1, r0, r6
	ldr r2, [r5, #8]
	cmp r2, r0
	bge _0200A27C
	blt _0200A258
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_0200A258:
	ldr r1, =mapSystemTask
	str r0, [r5, #8]
	ldr r2, [r1, #0x100]
	mov r0, r8
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A27C:
	mov r0, r8
	bl MapSys__Func_200AA18
	cmp r0, #0
	beq _0200A440
	ldrsb r1, [r5, #0x46]
	ldr r0, =gPlayerList
	ldr r2, [r5, #0x54]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =mapSystemTask
	ldr r3, [r0, #0x48]
	mov r0, r8
	sub r2, r3, r2
	str r2, [r5, #8]
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A440
_0200A2C8:
	mov r0, r8
	bl MapSys__Func_200AAF8
	cmp r0, #0
	beq _0200A440
	ldr r1, =mapSystemTask
	mov r0, r8
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0200A2F8:
	tst r0, #4
	bne _0200A434
	tst r0, #2
	ldrsb r1, [r5, #0x46]
	bne _0200A39C
	ldr r0, =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	ble _0200A350
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	mov r0, #1
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r1, [r4, #0xe0]
	str r0, [r4, #0xf0]
	b _0200A440
_0200A350:
	ldr r1, [r5, #0]
	ldr r0, =0x00004020
	tst r1, r0
	bne _0200A440
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	ldr r0, [r5, #0x5c]
	ldr r2, [r5, #8]
	cmp r2, r0
	blt _0200A394
	ldr r1, [r5, #0x28]
	mov r0, #0xe8
	mul r0, r1, r0
	sub r0, r6, r0
	cmp r2, r0
	movle r0, r2
_0200A394:
	str r0, [r5, #8]
	b _0200A440
_0200A39C:
	ldr r0, =gPlayerList
	ldr r0, [r0, r1, lsl #2]
	ldr r0, [r0, #0x48]
	cmp r0, r6
	bge _0200A3E0
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	mov r0, #0
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r1, [r4, #0xe0]
	str r0, [r4, #0xf0]
	b _0200A440
_0200A3E0:
	ldr r1, [r5, #0]
	ldr r0, =0x00004020
	tst r1, r0
	bne _0200A440
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
	ldr r1, [r5, #0x28]
	mov r0, #0x28
	mla r0, r1, r0, r6
	ldr r2, [r5, #8]
	cmp r2, r0
	blt _0200A42C
	mov r0, #0xc0
	mul r0, r1, r0
	ldr r1, [r5, #0x64]
	sub r0, r1, r0
	cmp r2, r0
	movle r0, r2
_0200A42C:
	str r0, [r5, #8]
	b _0200A440
_0200A434:
	mov r0, r8
	mov r1, r7
	bl MapSys__FollowTargetY
_0200A440:
	mov r0, r8
	mov r1, r7
	bl MapSys__Func_200A580
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapSys__Func_200A460(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r2, #0x70
	mul r4, r5, r2
	ldr ip, =mapCamera
	ldr r2, =0x00004020
	ldr r3, [ip, r4]
	mov r6, r0
	tst r3, r2
	add r4, ip, r4
	beq _0200A494
	bl MapSys__Func_200A580
	ldmia sp!, {r4, r5, r6, pc}
_0200A494:
	ldr r2, =mapSystemTask
	ldr r2, [r2, #0x100]
	tst r2, #0x10000
	beq _0200A520
	tst r2, #0x20000
	ldr r3, [r4, #8]
	ldr r2, [r6, #8]
	bne _0200A4C4
	add r2, r3, r2
	str r2, [r4, #8]
	bl MapSys__Func_200AC64
	b _0200A524
_0200A4C4:
	add r2, r3, r2
	str r2, [r4, #8]
	ldr r2, [r6, #8]
	cmp r2, #0
	beq _0200A524
	bl MapSys__Func_200AA84
	cmp r0, #0
	beq _0200A524
	ldrsb r1, [r4, #0x46]
	ldr r0, =gPlayerList
	ldr r2, [r4, #0x54]
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =mapSystemTask
	ldr r3, [r0, #0x48]
	mov r0, r6
	sub r2, r3, r2
	str r2, [r4, #8]
	ldr r2, [r1, #0x100]
	bic r2, r2, #0x10000
	bic r2, r2, #0x20000
	str r2, [r1, #0x100]
	bl MapSys__CamLook_Reset
	b _0200A524
_0200A520:
	bl MapSys__FollowTargetY
_0200A524:
	mov r0, r6
	mov r1, r5
	bl MapSys__Func_200A580
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void MapSys__HandleCamBoundsX(MapSys *work, s32 id)
{
    MapSysCamera *camera = &mapCamera.camera[id];

    // clamp func, neither MTM_MATH_CLIP or MTM_MATH_CLIP_2 got it to match though
    fx32 newPos = camera->boundsL;
    if (camera->disp_pos.x >= newPos)
    {
        newPos = camera->boundsR - (camera->scale.x << 8);
        if (camera->disp_pos.x <= newPos)
        {
            newPos = camera->disp_pos.x;
        }
    }
    camera->disp_pos.x = newPos;
}

NONMATCH_FUNC void MapSys__Func_200A580(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r3, =mapCamera
	mov r0, #0x70
	ldr r2, =mapSystemTask
	mla r0, r1, r0, r3
	ldr r1, [r2, #0x100]
	tst r1, #0x200
	bxne lr
	tst r1, #1
	beq _0200A61C
	tst r1, #2
	bne _0200A5E0
	ldr r1, [r0, #0x5c]
	ldr r3, [r0, #8]
	cmp r3, r1
	blt _0200A5D8
	ldr r2, [r0, #0x28]
	mov r1, #0x1d0
	mul r1, r2, r1
	ldr r2, [r0, #0x64]
	sub r1, r2, r1
	cmp r3, r1
	movle r1, r3
_0200A5D8:
	str r1, [r0, #8]
	bx lr
_0200A5E0:
	ldr ip, [r0, #0x28]
	ldr r2, [r0, #0x5c]
	add r1, ip, ip, lsl #4
	ldr r3, [r0, #8]
	add r1, r2, r1, lsl #4
	cmp r3, r1
	blt _0200A614
	mov r1, #0xc0
	mul r1, ip, r1
	ldr r2, [r0, #0x64]
	sub r1, r2, r1
	cmp r3, r1
	movle r1, r3
_0200A614:
	str r1, [r0, #8]
	bx lr
_0200A61C:
	ldr r1, [r0, #0x5c]
	ldr r3, [r0, #8]
	cmp r3, r1
	blt _0200A648
	ldr r2, [r0, #0x28]
	mov r1, #0xc0
	mul r1, r2, r1
	ldr r2, [r0, #0x64]
	sub r1, r2, r1
	cmp r3, r1
	movle r1, r3
_0200A648:
	str r1, [r0, #8]
	bx lr

// clang-format on
#endif
}

void MapSys__HandleHBounds(MapSys *work, s32 id)
{
    MapSysCamera *camera = &mapCamera.camera[id];
    ViewRect *camBounds  = &mapCamera.camControl.bounds;

    // clamp func, neither MTM_MATH_CLIP or MTM_MATH_CLIP_2 got it to match though
    fx32 newPos = camBounds->left;
    if (camera->disp_pos.x >= newPos)
    {
        newPos = camBounds->right - (camera->scale.x << 8);
        if (camera->disp_pos.x <= newPos)
        {
            newPos = camera->disp_pos.x;
        }
    }
    camera->disp_pos.x = newPos;
}

NONMATCH_FUNC void MapSys__HandleVBounds(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, =mapCamera
	mov r0, #0x70
	mla r2, r1, r0, r2
	ldr r3, =mapSystemTask
	ldr r0, =mapCamera+0x00000130
	ldr r1, [r3, #0x100]
	tst r1, #0x200
	ldmneia sp!, {r3, pc}
	tst r1, #1
	beq _0200A740
	tst r1, #2
	bne _0200A704
	ldr r1, [r0, #4]
	ldr ip, [r2, #8]
	cmp ip, r1
	blt _0200A6FC
	ldr r3, [r2, #0x28]
	mov r1, #0x1d0
	mul r1, r3, r1
	ldr r0, [r0, #0xc]
	sub r1, r0, r1
	cmp ip, r1
	movle r1, ip
_0200A6FC:
	str r1, [r2, #8]
	ldmia sp!, {r3, pc}
_0200A704:
	ldr lr, [r2, #0x28]
	ldr ip, [r0, #4]
	add r1, lr, lr, lsl #4
	ldr r3, [r2, #8]
	add r1, ip, r1, lsl #4
	cmp r3, r1
	blt _0200A738
	mov r1, #0xc0
	mul r1, lr, r1
	ldr r0, [r0, #0xc]
	sub r1, r0, r1
	cmp r3, r1
	movle r1, r3
_0200A738:
	str r1, [r2, #8]
	ldmia sp!, {r3, pc}
_0200A740:
	ldr r1, [r0, #4]
	ldr ip, [r2, #8]
	cmp ip, r1
	blt _0200A76C
	ldr r3, [r2, #0x28]
	mov r1, #0xc0
	mul r1, r3, r1
	ldr r0, [r0, #0xc]
	sub r1, r0, r1
	cmp ip, r1
	movle r1, ip
_0200A76C:
	str r1, [r2, #8]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapSys__Func_200A780(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, =mapCamera
	mov r0, #0x70
	ldr r2, =mapSystemTask
	mla lr, r1, r0, r3
	ldr r0, [r2, #0x100]
	tst r0, #0x200
	ldmneia sp!, {r3, pc}
	ldr ip, [lr]
	tst ip, #0x100000
	ldmeqia sp!, {r3, pc}
	ldrb r2, [lr, #0x20]
	ldr r3, [lr, #0xc]
	ldr r1, [lr, #4]
	add r0, r3, r2, lsl #12
	cmp r1, r0
	strgt r0, [lr, #4]
	ldmgtia sp!, {r3, pc}
	sub r0, r3, r2, lsl #12
	cmp r1, r0
	strlt r0, [lr, #4]
	orrge r0, ip, #0x400000
	strge r0, [lr]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapSys__Func_200A7E8(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, =mapCamera
	mov r0, #0x70
	ldr r2, =mapSystemTask
	mla lr, r1, r0, r3
	ldr r0, [r2, #0x100]
	tst r0, #0x200
	ldmneia sp!, {r3, pc}
	ldr ip, [lr]
	tst ip, #0x200000
	ldmeqia sp!, {r3, pc}
	ldrb r2, [lr, #0x21]
	ldr r3, [lr, #0x10]
	ldr r1, [lr, #8]
	add r0, r3, r2, lsl #12
	cmp r1, r0
	strgt r0, [lr, #8]
	ldmgtia sp!, {r3, pc}
	sub r0, r3, r2, lsl #12
	cmp r1, r0
	strlt r0, [lr, #8]
	orrge r0, ip, #0x800000
	strge r0, [lr]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void MapSys__FollowTargetX(MapSys *work, s32 id)
{
    MapSysCamera *camera = &mapCamera.camera[id];

    if ((camera->flags & MAPSYS_CAMERA_FLAG_10000) != 0)
    {
        camera->disp_pos.x = gPlayerList[camera->targetPlayerID]->objWork.position.x - camera->targetOffset[0].x;
    }
}

void MapSys__FollowTargetY(MapSys *work, s32 id)
{
    MapSysCamera *camera = &mapCamera.camera[id];

    if ((camera->flags & MAPSYS_CAMERA_FLAG_20000) != 0)
    {
        camera->disp_pos.y = gPlayerList[camera->targetPlayerID]->objWork.position.y - camera->targetOffset[0].y;
    }
}

void MapSys__Func_200A8D8(MapSys *work, s32 id)
{
    mapCamera.camera[id].disp_pos.x = mapCamera.camControl.field_C + mapCamera.camera[(id + 1) & 1].disp_pos.x;
}

void MapSys__Func_200A910(MapSys *work, s32 id)
{
    mapCamera.camera[id].disp_pos.y = mapCamera.camControl.field_10 + mapCamera.camera[(id + 1) & 1].disp_pos.y;
}

NONMATCH_FUNC void MapSys__Func_200A948(MapSys *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =mapSystemTask
	ldr r4, =mapCamera
	ldr r0, [r0, #0x100]
	tst r0, #2
	bne _0200A9B0
	ldr r2, [r4, #8]
	ldr r1, [r4, #0x28]
	mov r0, #0xe8
	ldrsb ip, [r4, #0x46]
	ldr r3, =gPlayerList
	mla r0, r1, r0, r2
	ldr r1, [r3, ip, lsl #2]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	ble _0200AA04
	mov r0, #1
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r0, [r4, #0xf0]
	str r1, [r4, #0xe0]
	mov r0, #1
	ldmia sp!, {r4, pc}
_0200A9B0:
	ldr r1, [r4, #0x28]
	mov r0, #0x28
	mul r0, r1, r0
	ldr r1, [r4, #8]
	ldrsb r3, [r4, #0x46]
	ldr r2, =gPlayerList
	sub r0, r1, r0
	ldr r1, [r2, r3, lsl #2]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	bge _0200AA04
	mov r0, #0
	bl MapSys__Func_2008F28
	ldr r1, [r4, #0xe0]
	ldr r0, [r4, #0xf0]
	orr r1, r1, #0x200
	rsb r0, r0, #0
	str r0, [r4, #0xf0]
	str r1, [r4, #0xe0]
	mov r0, #1
	ldmia sp!, {r4, pc}
_0200AA04:
	mov r0, #0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

BOOL MapSys__Func_200AA18(MapSys *work)
{
    MapSysCamera *camera = &mapCamera.camera[0];

    if (work->field_8 >= 0)
        return camera->disp_pos.y + camera->targetOffset[1].y >= gPlayerList[camera->targetPlayerID]->objWork.position.y;
    else
        return camera->disp_pos.y + camera->targetOffset[1].y <= gPlayerList[camera->targetPlayerID]->objWork.position.y;
}

BOOL MapSys__Func_200AA84(MapSys *work, s32 id)
{
    MapSysCamera *camera = &mapCamera.camera[id];

    if (work->field_8 >= 0)
        return camera->disp_pos.y + camera->targetOffset[1].y >= gPlayerList[camera->targetPlayerID]->objWork.position.y;
    else
        return camera->disp_pos.y + camera->targetOffset[1].y <= gPlayerList[camera->targetPlayerID]->objWork.position.y;
}

NONMATCH_FUNC void MapSys__Func_200AAF8(MapSys *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, =mapSystemTask
	ldr r1, =mapCamera
	ldr r2, [r2, #0x100]
	tst r2, #0x200
	movne r0, #0
	ldmneia sp!, {r3, pc}
	tst r2, #2
	bne _0200ABAC
	ands r3, r2, #0x20000
	bne _0200AB30
	ldr r2, [r0, #0]
	tst r2, #2
	bne _0200AB44
_0200AB30:
	cmp r3, #0
	beq _0200AB60
	ldr r0, [r0, #0]
	tst r0, #4
	beq _0200AB60
_0200AB44:
	ldr r2, [r1, #0x5c]
	ldr r0, [r1, #8]
	cmp r0, r2
	bgt _0200ABA4
	str r2, [r1, #8]
	mov r0, #1
	ldmia sp!, {r3, pc}
_0200AB60:
	ldr r2, [r1, #0x28]
	mov r0, #0x60
	ldrsb lr, [r1, #0x46]
	ldr ip, =gPlayerList
	mul r3, r2, r0
	ldr r2, [ip, lr, lsl #2]
	ldr r0, [r1, #8]
	ldr r2, [r2, #0x48]
	sub r2, r2, r3
	cmp r0, r2
	blt _0200ABA4
	ldr r0, [r1, #0x5c]
	str r2, [r1, #8]
	cmp r2, r0
	strlt r0, [r1, #8]
	mov r0, #1
	ldmia sp!, {r3, pc}
_0200ABA4:
	mov r0, #0
	ldmia sp!, {r3, pc}
_0200ABAC:
	ands r3, r2, #0x20000
	bne _0200ABC0
	ldr r2, [r0, #0]
	tst r2, #2
	bne _0200ABD4
_0200ABC0:
	cmp r3, #0
	beq _0200AC28
	ldr r0, [r0, #0]
	tst r0, #4
	beq _0200AC28
_0200ABD4:
	ldr r2, [r1, #0x28]
	mov r0, #0x58
	ldrsb lr, [r1, #0x46]
	ldr ip, =gPlayerList
	mul r3, r2, r0
	ldr ip, [ip, lr, lsl #2]
	ldr r0, [r1, #8]
	ldr ip, [ip, #0x48]
	sub ip, ip, r3
	cmp r0, ip
	bgt _0200AC50
	mov r0, #0xc0
	mul r3, r2, r0
	ldr r2, [r1, #0x64]
	add r0, ip, r3
	cmp r2, r0
	str ip, [r1, #8]
	sublt r0, r2, r3
	strlt r0, [r1, #8]
	mov r0, #1
	ldmia sp!, {r3, pc}
_0200AC28:
	ldr r2, [r1, #0x28]
	mov r0, #0xc0
	mul r3, r2, r0
	ldr r2, [r1, #0x64]
	ldr r0, [r1, #8]
	sub r2, r2, r3
	cmp r0, r2
	strge r2, [r1, #8]
	movge r0, #1
	ldmgeia sp!, {r3, pc}
_0200AC50:
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void MapSys__Func_200AC64(MapSys *work, s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r3, =mapCamera
	mov r2, #0x70
	mla r2, r1, r2, r3
	ldrsb ip, [r2, #0x46]
	ldr r3, =gPlayerList
	ldr r1, =mapSystemTask
	ldr ip, [r3, ip, lsl #2]
	ldr r3, [r1, #0x100]
	ldr r1, [ip, #0x48]
	ands ip, r3, #0x20000
	bne _0200AC9C
	ldr r3, [r0, #0]
	tst r3, #2
	bne _0200ACB0
_0200AC9C:
	cmp ip, #0
	beq _0200ACEC
	ldr r0, [r0, #0]
	tst r0, #4
	beq _0200ACEC
_0200ACB0:
	ldr r0, [r2, #0x5c]
	ldr ip, [r2, #8]
	cmp ip, r0
	strle r0, [r2, #8]
	movle r0, #1
	bxle lr
	ldr r3, [r2, #0x28]
	mov r0, #0xa8
	mul r0, r3, r0
	sub r0, r1, r0
	cmp ip, r0
	bgt _0200AD24
	str r0, [r2, #8]
	mov r0, #1
	bx lr
_0200ACEC:
	ldr r0, [r2, #0x64]
	ldr ip, [r2, #8]
	cmp ip, r0
	strge r0, [r2, #8]
	movge r0, #1
	bxge lr
	ldr r3, [r2, #0x28]
	mov r0, #0x18
	mul r0, r3, r0
	sub r0, r1, r0
	cmp ip, r0
	strge r0, [r2, #8]
	movge r0, #1
	bxge lr
_0200AD24:
	mov r0, #0
	bx lr

// clang-format on
#endif
}

void MapSys__HandleCamLook(MapSys *work)
{
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_DISABLE_CAM_LOOK) == 0)
    {
        if (work->stateCamLook != NULL)
            work->stateCamLook(work);
    }
}

void MapSys__HandleCameraLookUpDown(MapSys *work)
{
    MapSysCamera *camera = &mapCamera.camera[0];

    if ((gPlayerList[mapCamera.camera[0].targetPlayerID]->inputKeyDown & PAD_KEY_UP) != 0
        && (gPlayerList[camera->targetPlayerID]->actionState == PLAYER_ACTION_LOOKUP_01 || gPlayerList[camera->targetPlayerID]->actionState == PLAYER_ACTION_LOOKUP_02))
    {
        work->flags |= MAPSYS_FLAG_LOOKING_UP;
        work->timer         = 0;
        work->stateCamLook = MapSys__CamLook_HandlePlayerLookUpDown;
    }

    if ((gPlayerList[camera->targetPlayerID]->inputKeyDown & PAD_KEY_DOWN) != 0
        && (gPlayerList[camera->targetPlayerID]->actionState == PLAYER_ACTION_CROUCH || gPlayerList[camera->targetPlayerID]->actionState == PLAYER_ACTION_CROUCH_EXIT))
    {
        work->flags |= MAPSYS_FLAG_LOOKING_DOWN;
        work->timer         = 0;
        work->stateCamLook = MapSys__CamLook_HandlePlayerLookUpDown;
    }
}

void MapSys__CamLook_HandlePlayerLookUpDown(MapSys *work)
{
    MapSysCamera *camera = &mapCamera.camera[0];

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_40000) != 0)
    {
        MapSys__CamLook_Reset(work);
        return;
    }

    Player *player = gPlayerList[camera->targetPlayerID];
    if ((player->inputKeyDown & PAD_BUTTON_A) != 0)
    {
        MapSys__CamLook_Reset(work);
        return;
    }

    if (((work->flags & MAPSYS_FLAG_LOOKING_UP) != 0
         && ((player->inputKeyDown & PAD_KEY_UP) == 0 || (player->actionState != PLAYER_ACTION_LOOKUP_01 && player->actionState != PLAYER_ACTION_LOOKUP_02))))
    {
        MapSys__CamLook_Reset(work);
        return;
    }

    if (((work->flags & MAPSYS_FLAG_LOOKING_DOWN) != 0
         && ((player->inputKeyDown & PAD_KEY_DOWN) == 0 || (player->actionState != PLAYER_ACTION_CROUCH && player->actionState != PLAYER_ACTION_CROUCH_EXIT))))
    {
        MapSys__CamLook_Reset(work);
        return;
    }

    work->timer++;
    if (work->timer >= 60)
    {
        work->timer = 0;

        if ((work->flags & MAPSYS_FLAG_LOOKING_UP) != 0)
        {
            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_10000;
            work->field_8       = 0;
            work->stateCamLook = MapSys__CamLook_LookingUp;
        }
        else
        {
            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_10000;
            work->field_8       = 0;
            work->stateCamLook = MapSys__CamLook_LookingDown;
        }
    }
}

void MapSys__CamLook_LookingUp(MapSys *work)
{
    MapSysCamera *camera = &mapCamera.camera[0];

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_40000) != 0)
    {
        work->field_8       = FLOAT_TO_FX32(0.0);
        work->stateCamLook = MapSys__CamLook_LookUpIdle;

        mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_20000;
    }
    else
    {
        Player *player = gPlayerList[camera->targetPlayerID];

        if ((player->inputKeyDown & PAD_KEY_UP) == 0 || (player->actionState != PLAYER_ACTION_LOOKUP_01 && player->actionState != PLAYER_ACTION_LOOKUP_02))
        {
            work->field_8       = FLOAT_TO_FX32(0.0);
            work->stateCamLook = MapSys__CamLook_LookUpIdle;

            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_20000;
        }
        else
        {
            work->field_8 = -MultiplyFX(camera->scale.y, FLOAT_TO_FX32(4.0));
        }
    }
}

void MapSys__CamLook_LookUpIdle(MapSys *work)
{
    mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_20000;

    work->field_8 = MultiplyFX(mapCamera.camera[0].scale.y, FLOAT_TO_FX32(16.0));
}

void MapSys__CamLook_LookingDown(MapSys *work)
{
    MapSysCamera *camera = &mapCamera.camera[0];

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_40000) != 0)
    {
        work->field_8       = FLOAT_TO_FX32(0.0);
        work->stateCamLook = MapSys__CamLook_LookDownIdle;

        mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_20000;
    }
    else
    {
        Player *player = gPlayerList[camera->targetPlayerID];

        if ((player->inputKeyDown & PAD_KEY_DOWN) == 0 || (player->actionState != PLAYER_ACTION_CROUCH && player->actionState != PLAYER_ACTION_CROUCH_EXIT))
        {
            work->field_8       = FLOAT_TO_FX32(0.0);
            work->stateCamLook = MapSys__CamLook_LookDownIdle;

            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_20000;
        }
        else
        {
            work->field_8 = MultiplyFX(camera->scale.y, FLOAT_TO_FX32(4.0));
        }
    }
}

void MapSys__CamLook_LookDownIdle(MapSys *work)
{
    mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_20000;

    work->field_8 = -MultiplyFX(mapCamera.camera[0].scale.y, FLOAT_TO_FX32(16.0));
}

void MapSys__CamLook_Reset(MapSys *work)
{
    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_10000;
    mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_20000;

    work->flags &= ~MAPSYS_FLAG_LOOKING_UP;
    work->flags &= ~MAPSYS_FLAG_LOOKING_DOWN;
    work->timer         = 0;
    work->field_8       = 0;
    work->stateCamLook = MapSys__HandleCameraLookUpDown;
}

void MapSys__HandleCameraScreenSwap(void)
{
    MapSysCameraSys *mapCameraPtr = &mapCamera;

    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) == 0 && (mapCameraPtr->camControl.flags & MAPSYS_CAMERACTRL_FLAG_800) == 0
        && (padInput.btnPress & PAD_BUTTON_SELECT) != 0)
    {
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) != 0)
        {
            renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

            mapCamera.camControl.flags &= ~MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP;
            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_200;
        }
        else
        {
            renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP;
            mapCamera.camControl.flags |= MAPSYS_CAMERACTRL_FLAG_200;
        }
    }
}