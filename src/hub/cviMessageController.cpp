#include <hub/cviMessageController.hpp>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CVIMESSAGECONTROLLER_INVALID          0xFFFF
#define CVIMESSAGECONTROLLER_PAGE_ACTION_MASK 0x8000

// --------------------
// STRUCTS
// --------------------

struct MessageControlHeader
{
    u8 signature[4];
    u16 mpcFile;
    u16 interactionCount;
    u16 pageCount;
    u16 actionCount;
    u32 interactionOffset;
    u32 pageOffset;
    u32 actionOffset;
    u32 _padding[2];
};

struct MessageControlInteraction
{
    u16 pages[4];
};

struct MessageControlPage
{
    u16 nameAnimation;
    u16 sequenceID;
    u16 sequenceUnknown;
    u16 unknown;
    u16 nextPage[4];
};

struct MessageControlAction
{
    u16 action;
    u16 selection;
};

struct MessageControlInteractionBlock
{
    MessageControlInteraction interactions[1];
};

struct MessageControlPageBlock
{
    MessageControlPage pages[1];
};

struct MessageControlActionBlock
{
    MessageControlAction actions[1];
};

// --------------------
// HELPER MACROS
// --------------------

#define GetFile(filePtr)                ((MessageControlHeader *)filePtr)
#define GetMPCInteractionBlock(filePtr) ((MessageControlInteractionBlock *)&((u8 *)filePtr)[GetFile(filePtr)->interactionOffset])
#define GetMPCPageBlock(filePtr)        ((MessageControlPageBlock *)&((u8 *)filePtr)[GetFile(filePtr)->pageOffset])
#define GetMPCActionBlock(filePtr)      ((MessageControlActionBlock *)&((u8 *)filePtr)[GetFile(filePtr)->actionOffset])

// --------------------
// FUNCTIONS
// --------------------

void CViMessageController::SetControlFile(void *ctrlFile)
{
    this->controlFile   = ctrlFile;
    this->interactionID = CVIMESSAGECONTROLLER_INVALID;
    this->pageID        = CVIMESSAGECONTROLLER_INVALID;
}

u16 CViMessageController::GetTextFileIndex()
{
    return GetFile(this->controlFile)->mpcFile;
}

void CViMessageController::SetInteraction(u16 id)
{
    this->interactionID = id;
    this->pageID        = CVIMESSAGECONTROLLER_INVALID;
}

NONMATCH_FUNC u16 CViMessageController::GetPageCount()
{
    // https://decomp.me/scratch/37pJ7 -> 99.44%
#ifdef NON_MATCHING
    s32 i;

    for (i = 0; i < 4; i++)
    {
        if (GetMPCInteractionBlock(this->controlFile)->interactions[this->interactionID].pages[i] == CVIMESSAGECONTROLLER_INVALID)
            break;
    }

    return i;
#else
    // clang-format off
	ldr r2, [r0, #0]
	ldrh r0, [r0, #4]
	ldr r1, [r2, #0xc]
	mov r3, #0
	add r1, r2, r1
	add r2, r1, r0, lsl #3
	ldr r0, =0x0000FFFF
_02152BD4:
	mov r1, r3, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r0
	beq _02152BF0
	add r3, r3, #1
	cmp r3, #4
	blt _02152BD4
_02152BF0:
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr

// clang-format on
#endif
}

void CViMessageController::SetPageID(u16 pageID)
{
    this->pageID = GetMPCInteractionBlock(this->controlFile)->interactions[this->interactionID].pages[pageID];
}

BOOL CViMessageController::CheckPageHasNameAnim()
{
    return GetMPCPageBlock(this->controlFile)->pages[this->pageID].nameAnimation != CVIMESSAGECONTROLLER_INVALID;
}

u16 CViMessageController::GetPageNameAnim()
{
    return GetMPCPageBlock(this->controlFile)->pages[this->pageID].nameAnimation;
}

u16 CViMessageController::GetPageSequence()
{
    return GetMPCPageBlock(this->controlFile)->pages[this->pageID].sequenceID;
}

s32 CViMessageController::CheckPageHasSequenceUnknown()
{
    return GetMPCPageBlock(this->controlFile)->pages[this->pageID].sequenceUnknown != CVIMESSAGECONTROLLER_INVALID;
}

u16 CViMessageController::GetPageSequenceUnknown()
{
    return GetMPCPageBlock(this->controlFile)->pages[this->pageID].sequenceUnknown;
}

void CViMessageController::AdvancePage(s32 id)
{
    u16 *nextPage = GetMPCPageBlock(this->controlFile)->pages[this->pageID].nextPage;

    if (this->CheckPageHasSequenceUnknown() == FALSE)
    {
        this->pageID = nextPage[0];
    }
    else
    {
        this->pageID = nextPage[id];
    }
}

BOOL CViMessageController::CheckPageActionEnabled()
{
    if (this->pageID == CVIMESSAGECONTROLLER_INVALID)
        return FALSE;

    return this->pageID >= CVIMESSAGECONTROLLER_PAGE_ACTION_MASK;
}

s32 CViMessageController::GetPageActionType()
{
    u16 id = this->pageID - CVIMESSAGECONTROLLER_PAGE_ACTION_MASK;
    return GetMPCActionBlock(this->controlFile)->actions[id].action;
}

s32 CViMessageController::GetPageActionSelection()
{
    u16 id = this->pageID - CVIMESSAGECONTROLLER_PAGE_ACTION_MASK;
    return GetMPCActionBlock(this->controlFile)->actions[id].selection;
}

BOOL CViMessageController::CheckPageHasActions()
{
    return this->pageID >= CVIMESSAGECONTROLLER_PAGE_ACTION_MASK;
}
