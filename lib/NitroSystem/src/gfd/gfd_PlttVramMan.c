#include <nnsys/gfd/VramManager/gfd_VramMan.h>
#include <nnsys/gfd/VramManager/gfd_PlttVramMan_Types.h>

// --------------------
// FUNCTION DECLS
// --------------------

static NNSGfdPlttKey AllocPlttVram_(u32 szByte, BOOL b4Pltt, u32 bAllocFromLo);
static int FreePlttVram_(NNSGfdPlttKey key);

// --------------------
// VARIABLES
// --------------------

NNSGfdFuncAllocPlttVram NNS_GfdDefaultFuncAllocPlttVram = AllocPlttVram_;
NNSGfdFuncFreePlttVram NNS_GfdDefaultFuncFreePlttVram   = FreePlttVram_;

// --------------------
// FUNCTIONS
// --------------------

static NNSGfdPlttKey AllocPlttVram_(u32 szByte, BOOL b4Pltt, u32 bAllocFromLo)
{
    return NNS_GFD_ALLOC_ERROR_PLTTKEY;
}

static int FreePlttVram_(NNSGfdPlttKey key)
{
    return -1;
}
