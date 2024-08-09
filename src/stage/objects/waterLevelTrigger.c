#include <stage/objects/waterLevelTrigger.h>
#include <game/stage/mapSys.h>
#include <game/stage/gameSystem.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// used in Spikes
#define mapObjectParam_waterLevelDigit1 mapObject->left
#define mapObjectParam_waterLevelDigit2 mapObject->top
#define mapObjectParam_waterLevelDigit3 mapObject->width

// --------------------
// ENUMS
// --------------------

enum WaterLevelTriggerObjectFlags
{
    WATERLEVELTRIGGER_OBJFLAG_1  = 1 << 0,
    WATERLEVELTRIGGER_OBJFLAG_2  = 1 << 1,
    WATERLEVELTRIGGER_OBJFLAG_4  = 1 << 2,
    WATERLEVELTRIGGER_OBJFLAG_8  = 1 << 3,
    WATERLEVELTRIGGER_OBJFLAG_10 = 1 << 4,
    WATERLEVELTRIGGER_OBJFLAG_20 = 1 << 5,
};

enum WaterLevelTriggerActivateMode
{
    WATERLEVELTRIGGER_MODE_RESET,
    WATERLEVELTRIGGER_MODE_SET,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void WaterLevelTrigger_State_Active(WaterLevelTrigger *work);
static void WaterLevelTrigger_SetupWaterLevel(fx32 x, u16 waterLevel, u16 flags, s8 *targetPlayers);

// --------------------
// FUNCTIONS
// --------------------

WaterLevelTrigger *CreateWaterLevelTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    WaterLevelTrigger *work;

    u32 waterLevel = 10000 * mapObjectParam_waterLevelDigit1 + 100 * mapObjectParam_waterLevelDigit2 + mapObjectParam_waterLevelDigit3;
    if (waterLevel > 0xFFFF)
        waterLevel = 0xFFFF;

    s8 targetPlayers[2];
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        targetPlayers[1] = mapCamera.camera[0].targetPlayerID;
        targetPlayers[0] = mapCamera.camera[0].targetPlayerID;
    }
    else
    {
        targetPlayers[0] = mapCamera.camera[0].targetPlayerID;
        targetPlayers[1] = mapCamera.camera[1].targetPlayerID;
    }

    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, WaterLevelTrigger);

    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, WaterLevelTrigger);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;

    work->waterLevel       = waterLevel;
    work->targetPlayers[0] = targetPlayers[0];
    work->targetPlayers[1] = targetPlayers[1];

    if ((mapObject->flags & (WATERLEVELTRIGGER_OBJFLAG_4 | WATERLEVELTRIGGER_OBJFLAG_8)) != 0)
        WaterLevelTrigger_SetupWaterLevel(x, waterLevel, mapObject->flags, targetPlayers);
    else
        SetTaskState(&work->gameWork.objWork, WaterLevelTrigger_State_Active);

    return work;
}

NONMATCH_FUNC void WaterLevelTrigger_State_Active(WaterLevelTrigger *work)
{
    // https://decomp.me/scratch/ITQjP -> 98.79%
    // register issues near 'mode'
#ifdef NON_MATCHING
    for (s32 i = 0; i < 2; i++)
    {
        struct MapSysCamera *camera = &mapCamera.camera[i];

        if (work->targetPlayers[i] >= 0)
        {
            u32 mode;
            if (gPlayerList[work->targetPlayers[i]]->objWork.position.x < work->gameWork.objWork.position.x)
                mode = (work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_1) != 0 ? WATERLEVELTRIGGER_MODE_SET : WATERLEVELTRIGGER_MODE_RESET;
            else
                mode = (work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_1) != 0 ? WATERLEVELTRIGGER_MODE_RESET : WATERLEVELTRIGGER_MODE_SET;

            switch (mode)
            {
                // case WATERLEVELTRIGGER_MODE_SET:
                default:
                    camera->flags |= MAPSYS_CAMERA_FLAG_1000000;
                    camera->waterLevel = work->waterLevel;

                    if ((work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_10) != 0)
                        camera->flags |= MAPSYS_CAMERA_FLAG_2000000;
                    break;

                case WATERLEVELTRIGGER_MODE_RESET:
                    if ((work->gameWork.mapObject->flags & WATERLEVELTRIGGER_OBJFLAG_20) == 0)
                    {
                        camera->flags &= ~(MAPSYS_CAMERA_FLAG_1000000 | MAPSYS_CAMERA_FLAG_2000000);
                        camera->waterLevel = 0xFFFF;
                    }
                    break;
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, #0
	mov r2, #1
	ldr r5, =mapCamera
	ldr lr, =gPlayerList
	ldr r8, =0x0000FFFF
	add r6, r0, #0x300
	mov r1, r4
	mov r3, r2
	mov ip, r4
_02165030:
	add r7, r0, r4
	add r7, r7, #0x300
	ldrsb r7, [r7, #0x64]
	cmp r7, #0
	blt _021650D0
	ldr r9, [lr, r7, lsl #2]
	ldr r7, [r0, #0x44]
	ldr r9, [r9, #0x44]
	cmp r9, r7
	ldr r7, [r0, #0x340]
	ldrh r9, [r7, #4]
	bge _02165070
	tst r9, #1
	movne r7, ip
	moveq r7, r3
	b _0216507C
_02165070:
	tst r9, #1
	movne r7, r2
	moveq r7, r1
_0216507C:
	cmp r7, #0
	beq _021650B8
	ldr r7, [r5]
	orr r7, r7, #0x1000000
	str r7, [r5]
	ldrh r7, [r6, #0x66]
	strh r7, [r5, #0x6e]
	ldr r7, [r0, #0x340]
	ldrh r7, [r7, #4]
	tst r7, #0x10
	beq _021650D0
	ldr r7, [r5]
	orr r7, r7, #0x2000000
	str r7, [r5]
	b _021650D0
_021650B8:
	tst r9, #0x20
	bne _021650D0
	ldr r7, [r5]
	bic r7, r7, #0x3000000
	str r7, [r5]
	strh r8, [r5, #0x6e]
_021650D0:
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x70
	blt _02165030
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

void WaterLevelTrigger_SetupWaterLevel(fx32 x, u16 waterLevel, u16 flags, s8 *targetPlayers)
{
    for (s32 i = 0; i < 2; i++)
    {
        struct MapSysCamera *camera = &mapCamera.camera[i];

        s8 targetPlayer = targetPlayers[i];
        if (targetPlayer >= 0)
        {
            if (x >= gPlayerList[targetPlayer]->objWork.position.x - FLOAT_TO_FX32(64.0) && x <= gPlayerList[targetPlayer]->objWork.position.x + FLOAT_TO_FX32(64.0))
            {
                camera->flags |= MAPSYS_CAMERA_FLAG_1000000;
                camera->waterLevel = waterLevel;

                camera->flags &= ~MAPSYS_CAMERA_FLAG_2000000;
                if ((flags & WATERLEVELTRIGGER_OBJFLAG_10) != 0)
                    camera->flags |= MAPSYS_CAMERA_FLAG_2000000;
            }
        }
    }
}