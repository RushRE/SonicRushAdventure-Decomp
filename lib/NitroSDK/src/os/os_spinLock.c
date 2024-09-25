#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#define OSi_LOCKID_INITIAL_FLAG_0 0xffffffff
#define OSi_LOCKID_INITIAL_FLAG_1 0xffff0000

#ifdef SDK_ARM9
#define OSi_ANYP_LOCK_ID_FLAG  HW_LOCK_ID_FLAG_MAIN
#define OSi_ANYP_LOCK_ID_START OS_MAINP_LOCK_ID_START
#else
#define OSi_ANYP_LOCK_ID_FLAG  HW_LOCK_ID_FLAG_SUB
#define OSi_ANYP_LOCK_ID_START OS_SUBP_LOCK_ID_START
#endif

// --------------------
// FUNCTION DECLS
// --------------------

static s32 OSi_DoLockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void), BOOL disableFiq);
static s32 OSi_DoUnlockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void), BOOL disableFIQ);
static s32 OSi_DoTryLockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void), BOOL disableFIQ);

static void OSi_AllocateCartridgeBus(void);
static void OSi_FreeCartridgeBus(void);

static void OSi_AllocateCardBus(void);
static void OSi_FreeCardBus(void);

static void OSi_WaitByLoop(void);

// --------------------
// FUNCTIONS
// --------------------

static inline void OSi_WaitByLoop(void)
{
    SVC_WaitByLoop(0x1000 / 4);
}

void OS_InitLock(void)
{
    static BOOL isInitialized = FALSE;
    OSLockWord *lockp;

    if (isInitialized)
        return;

    isInitialized = TRUE;

    lockp = (OSLockWord *)HW_INIT_LOCK_BUF;

#ifdef SDK_ARM9
    {
        lockp->lockFlag = 0;
        (void)OS_LockByWord(OS_MAINP_SYSTEM_LOCK_ID - 1, lockp, NULL);

        while (lockp->extension != 0)
        {
            OSi_WaitByLoop();
        }

        ((u32 *)OSi_ANYP_LOCK_ID_FLAG)[0] = OSi_LOCKID_INITIAL_FLAG_0;
        ((u32 *)OSi_ANYP_LOCK_ID_FLAG)[1] = OSi_LOCKID_INITIAL_FLAG_1;

        MI_CpuClear32((void *)HW_SHARED_LOCK_BUF, HW_CTRDG_LOCK_BUF - HW_SHARED_LOCK_BUF);

        MIi_SetCardProcessor(MI_PROCESSOR_ARM7);

        MIi_SetCartridgeProcessor(MI_PROCESSOR_ARM7);

        (void) OS_UnlockByWord(OS_MAINP_SYSTEM_LOCK_ID - 1, lockp, NULL);
        (void) OS_LockByWord(OS_MAINP_SYSTEM_LOCK_ID, lockp, NULL);
    }

#else // SDK_ARM7
    {
        lockp->extension = 0;
        while (lockp->ownerID != OS_MAINP_SYSTEM_LOCK_ID)
        {
            OSi_WaitByLoop();
        }

        ((u32 *)OSi_ANYP_LOCK_ID_FLAG)[0] = OSi_LOCKID_INITIAL_FLAG_0;
        ((u32 *)OSi_ANYP_LOCK_ID_FLAG)[1] = OSi_LOCKID_INITIAL_FLAG_1;

        lockp->extension = OS_SUBP_SYSTEM_LOCK_ID;
    }
#endif
}

static s32 OSi_DoLockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void), BOOL disableFiq)
{
    s32 lastLockFlag;

    while ((lastLockFlag = OSi_DoTryLockByWord(lockID, lockp, ctrlFuncp, disableFiq)) > OS_LOCK_SUCCESS)
    {
        OSi_WaitByLoop();
    }

    return lastLockFlag;
}

s32 OS_LockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void))
{
    return OSi_DoLockByWord(lockID, lockp, ctrlFuncp, FALSE);
}

static s32 OSi_DoUnlockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void), BOOL disableFIQ)
{
    OSIntrMode lastInterrupts;

    if (lockID != lockp->ownerID)
    {
        return OS_UNLOCK_ERROR;
    }

    lastInterrupts = (disableFIQ) ? OS_DisableInterrupts_IrqAndFiq() : OS_DisableInterrupts();

    lockp->ownerID = 0;
    if (ctrlFuncp)
    {
        ctrlFuncp();
    }
    lockp->lockFlag = 0;

    if (disableFIQ)
    {
        (void) OS_RestoreInterrupts_IrqAndFiq(lastInterrupts);
    }
    else
    {
        (void) OS_RestoreInterrupts(lastInterrupts);
    }

    return OS_UNLOCK_SUCCESS;
}

s32 OS_UnlockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void))
{
    return OSi_DoUnlockByWord(lockID, lockp, ctrlFuncp, FALSE);
}

static s32 OSi_DoTryLockByWord(u16 lockID, OSLockWord *lockp, void (*ctrlFuncp)(void), BOOL disableFIQ)
{
    s32 lastLockFlag;
    OSIntrMode lastInterrupts;

    lastInterrupts = (disableFIQ) ? OS_DisableInterrupts_IrqAndFiq() : OS_DisableInterrupts();

    lastLockFlag = (s32)MI_SwapWord(lockID, &lockp->lockFlag);

    if (lastLockFlag == OS_LOCK_SUCCESS)
    {
        if (ctrlFuncp)
        {
            ctrlFuncp();
        }
        lockp->ownerID = lockID;
    }

    if (disableFIQ)
    {
        (void) OS_RestoreInterrupts_IrqAndFiq(lastInterrupts);
    }
    else
    {
        (void) OS_RestoreInterrupts(lastInterrupts);
    }

    return lastLockFlag;
}

s32 OS_UnlockCartridge(u16 lockID)
{
    s32 lastLockFlag;

    lastLockFlag = OSi_DoUnlockByWord(lockID, (OSLockWord *)HW_CTRDG_LOCK_BUF, OSi_FreeCartridgeBus, TRUE);

    return lastLockFlag;
}

s32 OS_LockCartridge(u16 lockID)
{
    s32 lastLockFlag;

    // CHANGE: this is OSi_DoLockByWord in NitroSDK 3.2.060901
    lastLockFlag = OSi_DoTryLockByWord(lockID, (OSLockWord *)HW_CTRDG_LOCK_BUF, OSi_AllocateCartridgeBus, TRUE);

    return lastLockFlag;
}

static void OSi_AllocateCartridgeBus(void)
{
#ifdef SDK_ARM9
    MIi_SetCartridgeProcessor(MI_PROCESSOR_ARM9);
#endif
}

static void OSi_FreeCartridgeBus(void)
{
#ifdef SDK_ARM9
    MIi_SetCartridgeProcessor(MI_PROCESSOR_ARM7);
#endif
}

s32 OS_LockCard(u16 lockID)
{
    return OS_LockByWord(lockID, (OSLockWord *)HW_CARD_LOCK_BUF, OSi_AllocateCardBus);
}

s32 OS_UnlockCard(u16 lockID)
{
    return OS_UnlockByWord(lockID, (OSLockWord *)HW_CARD_LOCK_BUF, OSi_FreeCardBus);
}

static void OSi_AllocateCardBus(void)
{
#ifdef SDK_ARM9
    MIi_SetCardProcessor(MI_PROCESSOR_ARM9);
#endif
}

static void OSi_FreeCardBus(void)
{
#ifdef SDK_ARM9
    MIi_SetCardProcessor(MI_PROCESSOR_ARM7);
#endif
}

u16 OS_ReadOwnerOfLockWord(OSLockWord *lockp)
{
    return lockp->ownerID;
}

asm s32 OS_UnLockCartridge(u16 lockID)
{
    // clang-format off
  ldr  r1, =OS_UnlockCartridge
  bx   r1
    // clang-format on
}

#include <nitro/code32.h>
asm s32 OS_GetLockID(void)
{
    // clang-format off
    ldr    r3, =OSi_ANYP_LOCK_ID_FLAG
    ldr    r1, [r3, #0]

#ifdef SDK_ARM9
    clz    r2, r1
#else
    mov    r2, #0
    mov    r0, #0x80000000
_lp1:
    tst    r1, r0
    bne    _ex1
    add    r2, r2, #1
    cmp    r2, #32
    beq    _ex1

    mov    r0, r0, lsr #1
    b      _lp1
 _ex1:
#endif
    cmp    r2, #32

    //---- When there is an empty ID
    movne  r0, #OSi_ANYP_LOCK_ID_START
    bne    @1

    //---- Is there a flag (and empty ID) in the rear 323 bits?
    add    r3, r3, #4
    ldr    r1, [r3, #0]
#ifdef SDK_ARM9
    clz    r2, r1
#else
    mov    r2, #0
    mov    r0, #0x80000000
_lp2:
    tst    r1, r0
    bne    _ex2
    add    r2, r2, #1
    cmp    r2, #32
    beq    _ex2

    mov    r0, r0, lsr #1
    b      _lp2
 _ex2:
#endif
    cmp    r2, #32

    //---- When there is no empty ID
    ldr    r0, =OS_LOCK_ID_ERROR
    bxeq   lr

    //---- When there is an empty ID
    mov    r0, #OSi_ANYP_LOCK_ID_START+32

@1:
    add    r0, r0, r2
    mov    r1, #0x80000000
    mov    r1, r1, lsr r2

    ldr    r2, [r3, #0]
    bic    r2, r2, r1
    str    r2, [r3, #0]

    bx     lr
    // clang-format on
}

asm void OS_ReleaseLockID(register u16 lockID)
{
#pragma unused(lockID)

    // clang-format off
    ldr    r3, =OSi_ANYP_LOCK_ID_FLAG

    cmp    r0, #OSi_ANYP_LOCK_ID_START+32
    addpl  r3, r3, #4

    subpl  r0, r0, #OSi_ANYP_LOCK_ID_START+32
    submi  r0, r0, #OSi_ANYP_LOCK_ID_START

    mov r1, #0x80000000
    mov r1, r1, lsr r0

    ldr    r2, [r3, #0]
    orr    r2, r2, r1
    str    r2, [r3, #0]

    bx     lr
    // clang-format on
}
#include <nitro/codereset.h>