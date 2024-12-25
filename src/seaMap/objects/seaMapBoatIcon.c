#include <seaMap/objects/seaMapBoatIcon.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapBoatIcon_Main(void);
static void SeaMapBoatIcon_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *SeaMapStylusIcon__AnimIDs;

NONMATCH_FUNC SeaMapObject *CreateSeaMapBoatIcon(CHEVObjectType *objectType, CHEVObject *mapObject)
{
#ifdef NON_MATCHING
    SeaMapBoatIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();

    Task *task = TaskCreate(SeaMapBoatIcon_Main, SeaMapBoatIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapBoatIcon);

    work = TaskGetWork(task, SeaMapBoatIcon);
    TaskInitWork16(work);

    SeaMapEventManager__InitMapObject(&work->objWork, task, objectType, mapObject);

    u16 shipAnimIDs[SHIP_COUNT + 1] = { 0, 1, 2, 3, 0 };

    u16 shipType = SeaMapManager__GetWork()->shipType;
    if (shipType >= SHIP_MENU)
        shipType = mapObject->unlockID;
    u16 animID = shipAnimIDs[shipType];

    // Init island sprite
    AnimatorSprite__Init(&work->aniBoat, manager->assets.sprChCommon, animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, animID)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_7);

    work->aniBoat.pos.x   = mapObject->position.x;
    work->aniBoat.pos.y   = mapObject->position.y;
    work->aniBoat.palette = objectType->palette;

    AnimatorSprite__ProcessAnimationFast(&work->aniBoat);

    SeaMapEventManager__SetObjectAsActive(&work->objWork);

    return &work->objWork;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x28
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	ldr r1, =0x00000111
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x74
	ldr r0, =SeaMapBoatIcon_Main
	ldr r1, =SeaMapBoatIcon_Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x74
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl SeaMapEventManager__InitMapObject
	ldr r0, =SeaMapStylusIcon__AnimIDs
	ldrh r1, [r0, #0x1a]
	ldrh r3, [r0, #0x16]
	ldrh r2, [r0, #0x18]
	strh r1, [sp, #0x20]
	ldrh r1, [r0, #0x1c]
	ldrh r0, [r0, #0x1e]
	strh r3, [sp, #0x1c]
	strh r2, [sp, #0x1e]
	strh r1, [sp, #0x22]
	strh r0, [sp, #0x24]
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x194]
	add r0, sp, #0x1c
	cmp r1, #4
	ldrgesh r1, [r6, #0x10]
	mov r1, r1, lsl #1
	ldrh r8, [r0, r1]
	ldr r0, [r5, #0x15c]
	mov r1, r8
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0x158]
	mov ip, #0
	str r1, [sp]
	str ip, [sp, #4]
	str r0, [sp, #8]
	str ip, [sp, #0xc]
	ldr r3, [r5, #0x158]
	ldr r0, =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #7
	ldr r3, [r0, r3, lsl #2]
	mov r2, r8
	str r3, [sp, #0x10]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r5, #0x15c]
	add r0, r4, #0x10
	mov r3, #0x800
	bl AnimatorSprite__Init
	ldrsh r2, [r6, #2]
	mov r1, #0
	add r0, r4, #0x10
	strh r2, [r4, #0x18]
	ldrsh r3, [r6, #4]
	mov r2, r1
	strh r3, [r4, #0x1a]
	ldrh r3, [r7, #2]
	strh r3, [r4, #0x60]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void SeaMapBoatIcon_Main(void)
{
    SeaMapBoatIcon *work = TaskGetWorkCurrent(SeaMapBoatIcon);

    SeaMapEventManager__Func_20474FC(&work->objWork.position, &work->aniBoat.pos);
    AnimatorSprite__DrawFrame(&work->aniBoat);
}

void SeaMapBoatIcon_Destructor(Task *task)
{
    SeaMapBoatIcon *work = TaskGetWork(task, SeaMapBoatIcon);

    AnimatorSprite__Release(&work->aniBoat);

    SeaMapEventManager__SetObjectAsInactive(&work->objWork);
    SeaMapEventManager__DestroyObject(&work->objWork);
}
