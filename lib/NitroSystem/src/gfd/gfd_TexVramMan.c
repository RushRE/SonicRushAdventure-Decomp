#include <nnsys/gfd/VramManager/gfd_VramMan.h>
#include <nnsys/gfd/VramManager/gfd_TexVramMan_Types.h>

// --------------------
// FUNCTION DECLS
// --------------------

static NNSGfdTexKey AllocTexVram_(u32 szByte, BOOL is4x4comp, u32 opt);
static int FreeTexVram_(NNSGfdTexKey memKey);

// --------------------
// VARIABLES
// --------------------

NNSGfdFuncAllocTexVram NNS_GfdDefaultFuncAllocTexVram = AllocTexVram_;
NNSGfdFuncFreeTexVram NNS_GfdDefaultFuncFreeTexVram   = FreeTexVram_;

// --------------------
// FUNCTIONS
// --------------------

static NNSGfdTexKey AllocTexVram_(u32 szByte, BOOL is4x4comp, u32 opt)
{
    return NNS_GFD_ALLOC_ERROR_TEXKEY;
}

static int FreeTexVram_(NNSGfdTexKey memKey)
{
    return -1;
}
