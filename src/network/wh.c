#include <game/network/wh.h>
#include <game/network/wfs.h>
#include <nitro/cht.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct TEMP_SVARS
{
    u16 sChannelBusyRatio;
    u16 sConnectBitmap;
    u16 sChannelIndex;
    u16 wmMaxParentSize;
    u16 sMyAid;
    u16 sChannel;
    u16 wmMinDataSize;
    u16 sChannelBitmap;
    u16 wmMaxChildCount;
    u16 sAutoConnectFlag;
    u16 wmMaxChildSize;
    u32 dword_2136418;
    WHSysState sSysState;
    void *(*whAllocFunc)(u32 size);
    void *sReceiverFunc;
    u32 sScanCallback;
    u32 sConnectMode;
    u32 sParentWEPKeyGenerator;
    u32 sRecvBufferSize;
    u32 sPictoCatchFlag;
    u32 sRand;
    void (*whFreeFunc)(void *mem);
    void (*wh_trace)(const char *, ...);
    u32 sSendBufferSize;
    WMErrCode sErrCode;
    void *sJudgeAcceptFunc;
    u32 dword_2136454;
    u32 dword_2136458;
    u32 dword_213645C;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED struct TEMP_SVARS whConfig_sVars;

NOT_DECOMPILED u16 whConfig_sChannelBusyRatio;
NOT_DECOMPILED u16 whConfig_sConnectBitmap;
NOT_DECOMPILED u16 whConfig_sChannelIndex;
NOT_DECOMPILED u16 whConfig_wmMaxParentSize;
NOT_DECOMPILED u16 whConfig_sMyAid;
NOT_DECOMPILED u16 whConfig_sChannel;
NOT_DECOMPILED u16 whConfig_wmMinDataSize;
NOT_DECOMPILED u16 whConfig_sChannelBitmap;
NOT_DECOMPILED u16 whConfig_wmMaxChildCount;
NOT_DECOMPILED u16 whConfig_sAutoConnectFlag;
NOT_DECOMPILED u16 whConfig_wmMaxChildSize;
NOT_DECOMPILED u32 whConfig_dword_2136418;
NOT_DECOMPILED WHSysState whConfig_sSysState;
NOT_DECOMPILED void *(*whConfig_whAllocFunc)(u32 size);
NOT_DECOMPILED void *whConfig_sReceiverFunc;
NOT_DECOMPILED u32 whConfig_sScanCallback;
NOT_DECOMPILED u32 whConfig_sConnectMode;
NOT_DECOMPILED u32 whConfig_sParentWEPKeyGenerator;
NOT_DECOMPILED u32 whConfig_sRecvBufferSize;
NOT_DECOMPILED u32 whConfig_sPictoCatchFlag;
NOT_DECOMPILED u32 whConfig_sRand;
NOT_DECOMPILED void (*whConfig_whFreeFunc)(void *mem);
NOT_DECOMPILED void (*whConfig_wh_trace)(char *, ...);
NOT_DECOMPILED u32 whConfig_sSendBufferSize;
NOT_DECOMPILED WMErrCode whConfig_sErrCode;
NOT_DECOMPILED void *whConfig_sJudgeAcceptFunc;
NOT_DECOMPILED u32 whConfig_dword_2136454;
NOT_DECOMPILED u32 whConfig_dword_2136458;
NOT_DECOMPILED u32 whConfig_dword_213645C;

NOT_DECOMPILED void *sWEPKey;
NOT_DECOMPILED void *sScanParam;
NOT_DECOMPILED void *sParentParam;
NOT_DECOMPILED void *sBssDesc;
NOT_DECOMPILED void *sDataSet;
NOT_DECOMPILED void *sWMKeySetBuf;
NOT_DECOMPILED void *sWMDataSharingInfo;
NOT_DECOMPILED void *sConnectionSsid;
NOT_DECOMPILED void *sSendBuffer;
NOT_DECOMPILED void *sRecvBuffer;
NOT_DECOMPILED void *sWmBuffer;

NOT_DECOMPILED const char aNA[];
NOT_DECOMPILED const char aWhSysstateIdle[];
NOT_DECOMPILED const char aWhSysstateBusy[];
NOT_DECOMPILED const char aWhSysstateStop[];
NOT_DECOMPILED const char aWhSysstateErro[];
NOT_DECOMPILED const char aWmErrcodeFaile[];
NOT_DECOMPILED const char aWmErrcodeSucce[];
NOT_DECOMPILED const char aWmErrcodeNoDat[];
NOT_DECOMPILED const char aWmErrcodeTimeo[];
NOT_DECOMPILED const char aWmStatecodeMpI[];
NOT_DECOMPILED const char aWhErrcodeNoRad[];
NOT_DECOMPILED const char aWmErrcodeNoChi[];
NOT_DECOMPILED const char aWmErrcodeNoEnt[];
NOT_DECOMPILED const char aWmErrcodeDcfTe[];
NOT_DECOMPILED const char aWmStatecodeDcf[];
NOT_DECOMPILED const char aWmStatecodeUnk[];
NOT_DECOMPILED const char aWhSysstateScan[];
NOT_DECOMPILED const char aWmErrcodeOpera[];
NOT_DECOMPILED const char aWmStatecodeMpS[];
NOT_DECOMPILED const char aWmErrcodeNoDat_0[];
NOT_DECOMPILED const char aWmErrcodeFifoE[];
NOT_DECOMPILED const char aWmErrcodeWmDis[];
NOT_DECOMPILED const char aWhSysstateConn[];
NOT_DECOMPILED const char aWmStatecodeMpe[];
NOT_DECOMPILED const char aWmStatecodeMpa[];
NOT_DECOMPILED const char aWmStatecodeDcf_0[];
NOT_DECOMPILED const char aWmStatecodePor[];
NOT_DECOMPILED const char aWmStatecodePor_0[];
NOT_DECOMPILED const char aWmStatecodePor_1[];
NOT_DECOMPILED const char aWmErrcodeSendF[];
NOT_DECOMPILED const char aWmErrcodeFlash[];
NOT_DECOMPILED const char aWhSysstateKeys[];
NOT_DECOMPILED const char aWmStatecodeCon[];
NOT_DECOMPILED const char aWmStatecodeFif[];
NOT_DECOMPILED const char aWhSysstateData[];
NOT_DECOMPILED const char aWhErrcodeDisco[];
NOT_DECOMPILED const char aWmStatecodeSca[];
NOT_DECOMPILED const char aWmStatecodeBea[];
NOT_DECOMPILED const char aWmStatecodeBea_0[];
NOT_DECOMPILED const char aWmStatecodeRea[];
NOT_DECOMPILED const char aWmStatecodeInf[];
NOT_DECOMPILED const char aWmErrcodeIlleg[];
NOT_DECOMPILED const char aWmErrcodeInval[];
NOT_DECOMPILED const char aWmErrcodeWlLen[];
NOT_DECOMPILED const char aWhSysstateConn_0[];
NOT_DECOMPILED const char aWmStatecodeBea_1[];
NOT_DECOMPILED const char aWmStatecodeDis[];
NOT_DECOMPILED const char aWmStatecodeDis_0[];
NOT_DECOMPILED const char aWmStatecodeAut[];
NOT_DECOMPILED const char aWmErrcodeOverM[];
NOT_DECOMPILED const char aWmStatecodePar[];
NOT_DECOMPILED const char aWmStatecodePar_0[];
NOT_DECOMPILED const char aWmErrcodeSendQ[];
NOT_DECOMPILED const char aWhSysstateMeas[];
NOT_DECOMPILED const char aWmStatecodeCon_0[];
NOT_DECOMPILED const char aWmErrcodeWlInv[];
NOT_DECOMPILED const char aWhErrcodeParen[];
NOT_DECOMPILED const char aWmErrcodeInval_0[];
NOT_DECOMPILED const char aWmStatecodePar_1[];
NOT_DECOMPILED const char aWmStatecodeDis_1[];

NOT_DECOMPILED const char *WH__sStateNames[10];
NOT_DECOMPILED const char *WH__errnames[23];
NOT_DECOMPILED const char *WH__statenames[27];

NOT_DECOMPILED const char aNA_0[];
NOT_DECOMPILED const char aS[];
NOT_DECOMPILED const char aS_0[];
NOT_DECOMPILED const char aWhCallbackforw[];
NOT_DECOMPILED const char aStartparentNew[];
NOT_DECOMPILED const char aStartparentChi[];
NOT_DECOMPILED const char aStartparentChi_0[];
NOT_DECOMPILED const char aUnknownIndicat[];
NOT_DECOMPILED const char aWhStateinstart[];
NOT_DECOMPILED const char aWhStateinendpa[];
NOT_DECOMPILED const char aWhStateinendpa_0[];
NOT_DECOMPILED const char aRecvBufferSize[];
NOT_DECOMPILED const char aSendBufferSize[];
NOT_DECOMPILED const char aWfsInitchildCa[];
NOT_DECOMPILED const char aWhStateoutstar[];
NOT_DECOMPILED const char aPictochatParen[];
NOT_DECOMPILED const char aNotMyParentGgi[];
NOT_DECOMPILED const char aNotReceiveEntr[];
NOT_DECOMPILED const char aParentFind[];
NOT_DECOMPILED const char aWhStateoutends[];
NOT_DECOMPILED const char aWhStateoutsetc[];
NOT_DECOMPILED const char aWhStateinstart_0[];
NOT_DECOMPILED const char aConnectToParen[];
NOT_DECOMPILED const char aWhStateinstart_1[];
NOT_DECOMPILED const char aDisconnectedFr[];
NOT_DECOMPILED const char aUnknownStateDS[];
NOT_DECOMPILED const char aWhStateinstart_2[];
NOT_DECOMPILED const char aWhStateoutstar_0[];
NOT_DECOMPILED const char aWhStateinsetmp[];
NOT_DECOMPILED const char aChannelDBratio[];
NOT_DECOMPILED const char aDecidedChannel[];
NOT_DECOMPILED const char aWfsInitparentC[];
NOT_DECOMPILED const char aUnknownConnect[];
NOT_DECOMPILED const char aWmNotInitializ[];
NOT_DECOMPILED const char aWhStepdatashar[];
NOT_DECOMPILED const char aAlreadyWhSysst[];
NOT_DECOMPILED const char aWhFinalizeStat[];

// --------------------
// MACROS
// --------------------

#define TRACE_CALL                                                                                                                                                                 \
    if (whConfig_sVars.wh_trace)                                                                                                                                                   \
    whConfig_sVars.wh_trace

// --------------------
// FUNCTIONS
// --------------------

const char *WH_GetWMErrCodeName(WMErrCode code)
{
    if (WM_ERRCODE_SUCCESS <= code && code < ARRAY_COUNT(WH__errnames))
    {
        return WH__errnames[code];
    }
    else
    {
        return aNA_0;
    }
}

const char *WH_GetWMStateCodeName(u32 state)
{
    if (state < ARRAY_COUNT(WH__statenames))
    {
        return WH__statenames[state];
    }
    else
    {
        return aNA_0;
    }
}

void WH_ChangeSysState(WHSysState state)
{
    TRACE_CALL(aS, WH__sStateNames[whConfig_sVars.sSysState]);
    whConfig_sVars.sSysState = state;
    TRACE_CALL(aS_0, WH__sStateNames[whConfig_sVars.sSysState]);
}

void WH_SetError(WMErrCode error)
{
    if (whConfig_sVars.sSysState == WH_SYSSTATE_ERROR || whConfig_sVars.sSysState == WH_SYSSTATE_FATAL)
        return;

    whConfig_sVars.sErrCode = error;
}

void *WH_Alloc(s32 unknown, size_t size, void *ptr)
{
    if (ptr == NULL)
        return whConfig_sVars.whAllocFunc((size + 3) & ~3);

    whConfig_sVars.whFreeFunc(ptr);
    return NULL;
}

NONMATCH_FUNC void WH_Free(WMStartParentCallback *context)
{
#ifdef NON_MATCHING
    if (context->apiid == WM_APIID_START_MP && context->wlCmdID == WM_ERRCODE_SEND_QUEUE_FULL)
    {
        TRACE_CALL(aWhCallbackforw);

        WFS_Start();
    }
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #0]
	cmp r1, #0xe
	ldmneia sp!, {r3, pc}
	ldrh r0, [r0, #4]
	cmp r0, #0xa
	ldmneia sp!, {r3, pc}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _02069CD4
	ldr r0, =aWhCallbackforw
	blx r1
_02069CD4:
	bl WFS_Start
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInSetParentParam(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =WH_StateOutSetParentParam
	ldr r1, =sParentParam
	bl WM_SetParentParameter
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutSetParentParam(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02069D44
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069D44:
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x30]
	cmp r0, #0
	beq _02069D6C
	bl WH_StateInSetParentWEPKey
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069D6C:
	bl WH_StateInStartParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInSetParentWEPKey(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r1, =whConfig_sVars
	ldr r0, =sWEPKey
	ldr r2, [r1, #0x30]
	ldr r1, =sParentParam
	blx r2
	mov r1, r0
	ldr r0, =WH_StateOutSetParentWEPKey
	ldr r2, =sWEPKey
	bl WM_SetWEPKey
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutSetParentWEPKey(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02069E08
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069E08:
	bl WH_StateInStartParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartParent(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	sub r0, r0, #4
	cmp r0, #2
	movls r0, #1
	ldmlsia sp!, {r3, pc}
	ldr r0, =WH_StateOutStartParent
	bl WM_StartParent
	cmp r0, #2
	beq _02069E58
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_02069E58:
	ldr r1, =whConfig_sVars
	mov r0, #0
	strh r0, [r1, #8]
	mov r0, #1
	strh r0, [r1, #2]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutStartParent(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrh r1, [r4, #0x10]
	ldrh r0, [r4, #2]
	mov r2, #1
	mov r2, r2, lsl r1
	cmp r0, #0
	mov r5, r2, lsl #0x10
	beq _02069EAC
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069EAC:
	ldrh r3, [r4, #8]
	cmp r3, #7
	bgt _02069EDC
	bge _02069EF8
	cmp r3, #2
	bgt _02069FF0
	cmp r3, #0
	blt _02069FF0
	beq _02069FD8
	cmp r3, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	b _02069FF0
_02069EDC:
	cmp r3, #9
	bgt _02069EEC
	beq _02069F84
	b _02069FF0
_02069EEC:
	cmp r3, #0x1a
	beq _02069FBC
	b _02069FF0
_02069EF8:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02069F10
	ldr r0, =aStartparentNew
	blx r2
_02069F10:
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x50]
	cmp r1, #0
	beq _02069F54
	mov r0, r4
	blx r1
	cmp r0, #0
	bne _02069F54
	ldrh r1, [r4, #0x10]
	mov r0, #0
	bl WM_Disconnect
	cmp r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069F54:
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x2c]
	sub r0, r0, #6
	cmp r0, #1
	bhi _02069F70
	mov r0, r4
	bl WH_Free
_02069F70:
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #2]
	orr r1, r1, r5, lsr #16
	strh r1, [r0, #2]
	ldmia sp!, {r3, r4, r5, pc}
_02069F84:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02069F9C
	ldr r0, =aStartparentChi
	blx r2
_02069F9C:
	ldr r1, =whConfig_sVars
	mvn r2, r5, lsr #16
	ldrh r3, [r1, #2]
	mov r0, r4
	and r2, r3, r2
	strh r2, [r1, #2]
	bl WH_Free
	ldmia sp!, {r3, r4, r5, pc}
_02069FBC:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, =aStartparentChi_0
	blx r2
	ldmia sp!, {r3, r4, r5, pc}
_02069FD8:
	bl WH_StateInStartParentMP
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069FF0:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, =aUnknownIndicat
	mov r1, r3
	blx r2
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartParentMP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #5
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	mov r0, #4
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	ldr r1, =whConfig_sVars
	ldrh r0, [r0, #0xb6]
	ldr r3, [r1, #0x48]
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r2}
	ldr r1, [r1, #0x34]
	ldr r0, =WH_StateOutStartParentMP
	mov r2, r1, lsl #0x10
	ldr r1, =sRecvBuffer
	ldr r3, =sSendBuffer
	mov r2, r2, lsr #0x10
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutStartParentMP(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206A0F4
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A0F4:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206A1F4
_0206A108: // jump table
	b _0206A118 // case 0
	ldmia sp!, {r3, pc} // case 1
	b _0206A1F4 // case 2
	b _0206A1F4 // case 3
_0206A118:
	ldr r2, =whConfig_sVars
	ldr r1, [r2, #0x2c]
	cmp r1, #2
	bne _0206A170
	ldr r0, [r2, #0x1c]
	cmp r0, #4
	bne _0206A164
	bl WH_StateInStartParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A158
	ldr r0, =aWhStateinstart
	blx r1
_0206A158:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A164:
	cmp r0, #6
	bne _0206A1E8
	ldmia sp!, {r3, pc}
_0206A170:
	cmp r1, #4
	bne _0206A1CC
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, =sWMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206A1C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1C0:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1CC:
	cmp r1, #6
	bne _0206A1DC
	bl WH_Free
	b _0206A1E8
_0206A1DC:
	cmp r1, #7
	bne _0206A1E8
	bl WH_Free
_0206A1E8:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1F4:
	ldr r1, =whConfig_sVars
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartParentKeyShare(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #6
	bl WH_ChangeSysState
	ldr r0, =sWMKeySetBuf
	mov r1, #0xd
	bl WM_StartKeySharing
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndParentKeyShare(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =sWMKeySetBuf
	bl WM_EndKeySharing
	cmp r0, #0
	beq _0206A278
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A278:
	bl WH_StateInEndParentMP
	cmp r0, #0
	bne _0206A2A8
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A29C
	ldr r0, =aWhStateinendpa
	blx r1
_0206A29C:
	bl WH_Reset
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A2A8:
	mov r0, #1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndParentMP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =WH_StateOutEndParentMP
	bl WM_EndMP
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutEndParentMP(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A308
	bl WH_SetError
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206A308:
	bl WH_StateInEndParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A32C
	ldr r0, =aWhStateinendpa_0
	blx r1
_0206A32C:
	bl WH_Reset
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndParent(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =WH_StateOutEndParent
	bl WM_EndParent
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutEndParent(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A37C
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206A37C:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_ChildConnectAuto(WHStartScanCallbackFunc callback, int mode, const u8 *macAddr, u16 channel)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r7, r0
	mov r5, r2
	mov r4, r3
	cmp r6, #7
	bne _0206A410
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, =whConfig_sVars
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, =whConfig_sVars
	str r1, [r0, #0x34]
	b _0206A440
_0206A410:
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #0x10]
	ldrh r2, [r0, #0xc]
	add r1, r1, #1
	mul r1, r2, r1
	add r1, r1, #0x59
	bic r1, r1, #0x1f
	mov r3, r1, lsl #1
	add r1, r2, #0x21
	str r3, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206A440:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206A45C
	ldr r1, [r0, #0x34]
	ldr r0, =aRecvBufferSize
	blx r2
_0206A45C:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206A478
	ldr r1, [r0, #0x48]
	ldr r0, =aSendBufferSize
	blx r2
_0206A478:
	mov r0, #2
	bl WH_ChangeSysState
	ldr r0, =sBssDesc+0x00000020
	mov r3, #1
	strh r3, [r0, #0x16]
	ldrh r2, [r5, #4]
	ldr r0, =whConfig_sVars
	mov r1, #0
	strh r2, [r0, #0x8c]
	ldrh r2, [r5, #2]
	cmp r6, #7
	strh r2, [r0, #0x8a]
	ldrh r2, [r5, #0]
	strh r2, [r0, #0x88]
	str r6, [r0, #0x2c]
	str r7, [r0, #0x28]
	strh r4, [r0, #4]
	strh r1, [r0, #0x84]
	strh r3, [r0, #0x12]
	bne _0206A4F8
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A4DC
	ldr r0, =aWfsInitchildCa
	blx r1
_0206A4DC:
	mov r1, #0
	ldr r2, =WH_Alloc
	mov r3, r1
	mov r0, #1
	bl WFS_InitChild
	mov r0, #1
	bl WFS_SetDebugMode
_0206A4F8:
	bl WH_StateInStartScan
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StartScan(WHStartScanCallbackFunc callback, const u8 *macAddr, u16 channel)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, =whConfig_sVars
	mov r5, r0
	ldr r0, [r3, #0x1c]
	mov r4, r1
	mov r6, r2
	cmp r0, #1
	beq _0206A558
	bl OS_Terminate
	movs r0, #0
_0206A558:
	mov r0, #2
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	mov r1, #0
	str r5, [r0, #0x28]
	strh r6, [r0, #4]
	strh r1, [r0, #0x84]
	strh r1, [r0, #0x12]
	ldrh r1, [r4, #4]
	strh r1, [r0, #0x8c]
	ldrh r1, [r4, #2]
	strh r1, [r0, #0x8a]
	ldrh r1, [r4, #0]
	strh r1, [r0, #0x88]
	bl WH_StateInStartScan
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartScan(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #2
	beq _0206A5D0
	bl OS_Terminate
	movs r0, #0
_0206A5D0:
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0206A5EC
	mov r0, #3
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A5EC:
	cmp r0, #0
	bne _0206A604
	mov r0, #0x16
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A604:
	ldr r1, =whConfig_sVars
	ldrh r2, [r1, #4]
	cmp r2, #0
	bne _0206A648
	mov ip, #1
	mov r3, ip
_0206A61C:
	ldrh r2, [r1, #0x84]
	add r2, r2, #1
	strh r2, [r1, #0x84]
	ldrh r2, [r1, #0x84]
	cmp r2, #0x10
	strhih ip, [r1, #0x84]
	ldrh r2, [r1, #0x84]
	sub r2, r2, #1
	tst r0, r3, lsl r2
	bne _0206A64C
	b _0206A61C
_0206A648:
	strh r2, [r1, #0x84]
_0206A64C:
	bl WM_GetDispersionScanPeriod
	ldr r2, =whConfig_sVars
	ldr r3, =sBssDesc
	strh r0, [r2, #0x86]
	ldr r0, =WH_StateOutStartScan
	ldr r1, =sScanParam
	str r3, [r2, #0x80]
	bl WM_StartScan
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutStartScan(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206A6C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A6C0:
	ldr ip, =whConfig_sVars
	ldr r0, [ip, #0x1c]
	cmp r0, #2
	beq _0206A6F8
	mov r0, #0
	strh r0, [ip, #0x12]
	bl WH_StateInEndScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A6F8:
	ldrh r0, [r4, #8]
	cmp r0, #3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	cmp r0, #4
	beq _0206A890
	cmp r0, #5
	bne _0206A890
	ldr r0, [ip, #0x44]
	cmp r0, #0
	beq _0206A754
	ldrb r1, [r4, #0xd]
	ldr r0, =aWhStateoutstar
	str r1, [sp]
	ldrb r1, [r4, #0xe]
	str r1, [sp, #4]
	ldrb r1, [r4, #0xf]
	str r1, [sp, #8]
	ldrb r1, [r4, #0xa]
	ldrb r2, [r4, #0xb]
	ldrb r3, [r4, #0xc]
	ldr ip, [ip, #0x44]
	blx ip
_0206A754:
	ldr r0, =sBssDesc
	mov r1, #0xc0
	bl DC_InvalidateRange
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _0206A7B8
	ldr r0, =sBssDesc
	bl CHT_IsPictochatParent
	cmp r0, #0
	beq _0206A7B8
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A798
	ldr r0, =aPictochatParen
	blx r1
_0206A798:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x28]
	cmp r2, #0
	beq _0206A890
	ldr r0, =sBssDesc
	mov r1, r4
	blx r2
	b _0206A890
_0206A7B8:
	ldrh r0, [r4, #0x36]
	mov r1, #0
	cmp r0, #0x10
	blo _0206A7D4
	ldrh r0, [r4, #0x38]
	cmp r0, #1
	moveq r1, #1
_0206A7D4:
	cmp r1, #0
	beq _0206A7F0
	ldr r0, =whConfig_sVars
	ldr r2, [r4, #0x3c]
	ldr r1, [r0, #0xa8]
	cmp r2, r1
	beq _0206A80C
_0206A7F0:
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A890
	ldr r0, =aNotMyParentGgi
	blx r1
	b _0206A890
_0206A80C:
	ldrb r1, [r4, #0x43]
	and r1, r1, #3
	cmp r1, #1
	ldr r1, [r0, #0x44]
	beq _0206A834
	cmp r1, #0
	beq _0206A890
	ldr r0, =aNotReceiveEntr
	blx r1
	b _0206A890
_0206A834:
	cmp r1, #0
	beq _0206A844
	ldr r0, =aParentFind
	blx r1
_0206A844:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x28]
	cmp r2, #0
	beq _0206A860
	ldr r0, =sBssDesc
	mov r1, r4
	blx r2
_0206A860:
	ldr r0, =whConfig_sVars
	ldrh r0, [r0, #0x12]
	cmp r0, #0
	beq _0206A890
	bl WH_StateInEndScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A890:
	bl WH_StateInStartScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_EndScan(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =whConfig_sVars
	ldr r0, [r1, #0x1c]
	cmp r0, #2
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r2, #0
	mov r0, #3
	strh r2, [r1, #0x12]
	bl WH_ChangeSysState
	mov r0, #1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndScan(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =WH_StateOutEndScan
	bl WM_EndScan
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutEndScan(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A940
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206A940:
	mov r0, #1
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #0x12]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0206A97C
	bl WH_StateInSetChildWEPKey
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A97C:
	bl WH_StateInStartChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A9A0
	ldr r0, =aWhStateoutends
	blx r1
_0206A9A0:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInSetChildWEPKey(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r1, =whConfig_sVars
	ldr r0, =sWEPKey
	ldr r2, [r1, #0x18]
	ldr r1, =sBssDesc
	blx r2
	mov r1, r0
	ldr r0, =WH_StateOutSetChildWEPKey
	ldr r2, =sWEPKey
	bl WM_SetWEPKey
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutSetChildWEPKey(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AA34
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AA34:
	bl WH_StateInStartChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AA58
	ldr r0, =aWhStateoutsetc
	blx r1
_0206AA58:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartChild(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #5
	bne _0206AAA8
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AAA0
	ldr r0, =aWhStateinstart_0
	blx r1
_0206AAA0:
	mov r0, #1
	ldmia sp!, {r3, pc}
_0206AAA8:
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	ldr r1, =sBssDesc
	ldr r0, [r0, #0x18]
	ldr r2, =sConnectionSsid
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	ldr r0, =WH_StateOutStartChild
	mov r3, #1
	str ip, [sp]
	bl WM_StartConnectEx
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutStartChild(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206AB74
	bl WH_SetError
	ldrh r0, [r4, #2]
	cmp r0, #0xc
	bne _0206AB40
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB40:
	cmp r0, #0xb
	bne _0206AB54
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB54:
	cmp r0, #1
	bne _0206AB68
	mov r0, #8
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB68:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB74:
	ldrh r0, [r4, #8]
	cmp r0, #8
	ldmeqia sp!, {r4, pc}
	cmp r0, #7
	bne _0206ABE8
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ABA0
	ldr r0, =aConnectToParen
	blx r1
_0206ABA0:
	mov r0, #4
	bl WH_ChangeSysState
	bl WH_StateInStartChildMP
	cmp r0, #0
	bne _0206ABD8
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ABCC
	ldr r0, =aWhStateinstart_1
	blx r1
_0206ABCC:
	mov r0, #3
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206ABD8:
	ldrh r1, [r4, #0xa]
	ldr r0, =whConfig_sVars
	strh r1, [r0, #8]
	ldmia sp!, {r4, pc}
_0206ABE8:
	cmp r0, #6
	ldmeqia sp!, {r4, pc}
	cmp r0, #9
	bne _0206AC38
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	bne _0206AC0C
	bl WFS_End
_0206AC0C:
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AC24
	ldr r0, =aDisconnectedFr
	blx r1
_0206AC24:
	mov r0, #0x14
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AC38:
	cmp r0, #0x1a
	bne _0206AC58
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	bl WFS_End
	ldmia sp!, {r4, pc}
_0206AC58:
	ldr r1, =whConfig_sVars
	ldr r1, [r1, #0x44]
	cmp r1, #0
	beq _0206AC84
	bl WH_GetWMStateCodeName
	ldr r3, =whConfig_sVars
	mov r2, r0
	ldrh r1, [r4, #8]
	ldr r3, [r3, #0x44]
	ldr r0, =aUnknownStateDS
	blx r3
_0206AC84:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartChildMP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r2, =whConfig_sVars
	mov r3, #1
	ldr r1, [r2, #0x48]
	ldr r0, =WH_StateOutStartChildMP
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	stmia sp, {r1, r3}
	ldr r2, [r2, #0x34]
	ldr r1, =sRecvBuffer
	mov r2, r2, lsl #0x10
	ldr r3, =sSendBuffer
	mov r2, r2, lsr #0x10
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutStartChildMP(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206AD44
	cmp r1, #0xf
	cmpne r1, #9
	cmpne r1, #0xd
	ldmeqia sp!, {r3, pc}
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AD44:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206AE40
_0206AD58: // jump table
	b _0206AD68 // case 0
	b _0206AE40 // case 1
	ldmia sp!, {r3, pc} // case 2
	ldmia sp!, {r3, pc} // case 3
_0206AD68:
	ldr r2, =whConfig_sVars
	ldr r1, [r2, #0x2c]
	cmp r1, #3
	bne _0206ADB8
	ldr r0, [r2, #0x1c]
	cmp r0, #6
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	bne _0206AE34
	bl WH_StateInStartChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ADB0
	ldr r0, =aWhStateinstart_2
	blx r1
_0206ADB0:
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206ADB8:
	cmp r1, #5
	bne _0206AE28
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, =sWMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206AE04
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AE04:
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AE1C
	ldr r0, =aWhStateoutstar_0
	blx r1
_0206AE1C:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE28:
	cmp r1, #7
	bne _0206AE34
	bl WH_Free
_0206AE34:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE40:
	ldr r1, =whConfig_sVars
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInStartChildKeyShare(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #6
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #6
	bl WH_ChangeSysState
	ldr r0, =sWMKeySetBuf
	mov r1, #0xd
	bl WM_StartKeySharing
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndChildKeyShare(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #6
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =sWMKeySetBuf
	bl WM_EndKeySharing
	cmp r0, #0
	beq _0206AF08
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206AF08:
	bl WH_StateInEndChildMP
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndChildMP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =WH_StateOutEndChildMP
	bl WM_EndMP
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutEndChildMP(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AF70
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AF70:
	bl WH_StateInEndChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInEndChild(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =WH_StateOutEndChild
	mov r1, #0
	bl WM_Disconnect
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	bl WH_Reset
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutEndChild(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AFD8
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206AFD8:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInReset(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =WH_StateOutReset
	bl WM_Reset
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutReset(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #2]
	cmp r1, #0
	beq _0206B03C
	mov r0, #9
	bl WH_ChangeSysState
	ldrh r0, [r4, #2]
	bl WH_SetError
	ldmia sp!, {r4, pc}
_0206B03C:
	ldr r1, =whConfig_sVars
	ldr r1, [r1, #0x2c]
	sub r1, r1, #6
	cmp r1, #1
	bhi _0206B054
	bl WH_Free
_0206B054:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInSetMPData(void *data, u16 datasize, WHSendCallbackFunc callback)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, =whConfig_sVars
	mov r6, r0
	mov r5, r1
	ldr r1, [r3, #0x48]
	ldr r0, =sSendBuffer
	mov r4, r2
	bl DC_FlushRange
	ldr r0, =0x0000FFFF
	mov ip, #0xe
	str r0, [sp]
	ldr r0, =WH_StateOutSetMPData
	mov r1, r4
	mov r2, r6
	mov r3, r5
	str ip, [sp, #4]
	mov ip, #2
	str ip, [sp, #8]
	bl WM_SetMPDataToPortEx
	cmp r0, #2
	beq _0206B0F0
	ldr r1, =whConfig_sVars
	ldr r1, [r1, #0x44]
	cmp r1, #0
	beq _0206B0E4
	bl WH_GetWMErrCodeName
	ldr r2, =whConfig_sVars
	mov r1, r0
	ldr r2, [r2, #0x44]
	ldr r0, =aWhStateinsetmp
	blx r2
_0206B0E4:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, pc}
_0206B0F0:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutSetMPData(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	cmpne r0, #0xf
	beq _0206B130
	bl WH_SetError
	ldmia sp!, {r4, pc}
_0206B130:
	ldr r1, [r4, #0x20]
	cmp r1, #0
	beq _0206B14C
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	blx r1
_0206B14C:
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x2c]
	sub r0, r0, #6
	cmp r0, #1
	ldmhiia sp!, {r4, pc}
	mov r0, r4
	bl WH_Free
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_PortReceiveCallback(void *arg)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r1, r0
	ldrh r0, [r1, #2]
	cmp r0, #0
	beq _0206B18C
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206B18C:
	ldr r0, =whConfig_sVars
	ldr r3, [r0, #0x24]
	cmp r3, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r1, #4]
	cmp r0, #0x15
	bne _0206B1BC
	ldrh r0, [r1, #0x12]
	ldrh r2, [r1, #0x10]
	ldr r1, [r1, #0xc]
	blx r3
	ldmia sp!, {r3, pc}
_0206B1BC:
	cmp r0, #9
	ldmneia sp!, {r3, pc}
	ldrh r0, [r1, #0x12]
	mov r1, #0
	mov r2, r1
	blx r3
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutEnd(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206B1F8
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B1F8:
	mov r0, #0
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetGgid(u32 ggid){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =whConfig_sVars
	str r0, [r1, #0xa8]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetSsid(const void *ssid, u32 length)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r4, #0x18
	movhi r4, #0x18
	ldr r1, =sConnectionSsid
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, =sConnectionSsid
	rsb r2, r4, #0x18
	add r0, r0, r4
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetUserGameInfo(u16 *userGameInfo, u16 length){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, =whConfig_sVars
	str r0, [r2, #0xa0]
	strh r1, [r2, #0xa4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetMaxChildCount(u16 count){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =whConfig_sVars
	strh r0, [r1, #0x10]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetMinDataSize(u16 size){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =whConfig_sVars
	strh r0, [r1, #0xc]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetMaxParentChildSize(u16 parentSize, u16 childSize){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, =whConfig_sVars
	strh r0, [r2, #6]
	strh r1, [r2, #0x14]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC u16 WH_GetConnectBitmap(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =whConfig_sVars
	ldrh r0, [r0, #2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC WHSysState WH_GetSystemState(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC u32 WH_GetErrorCode(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x4c]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC BOOL WH_StartMeasureChannel(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	add r0, sp, #0
	bl OS_GetMacAddress
	ldr r1, =0x027FFC3C
	ldrh r0, [sp]
	ldr r2, [r1, #0]
	ldrh r1, [sp, #2]
	add r0, r0, r2
	ldrh r2, [sp, #4]
	add r1, r1, r0
	ldr r0, =0x00010DCD
	add r1, r2, r1
	mul r0, r1, r0
	add r0, r0, #0x39
	ldr r1, =whConfig_sVars
	add r0, r0, #0x3000
	str r0, [r1, #0x3c]
	mov r0, #0
	strh r0, [r1, #0xa]
	mov r2, #0x65
	mov r0, #3
	strh r2, [r1]
	bl WH_ChangeSysState
	mov r0, #1
	bl WH_StateInMeasureChannel
	cmp r0, #0x18
	bne _0206B350
	mov r0, #0x18
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206B350:
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInMeasureChannel(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0206B3B0
	mov r0, #3
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #3
	ldmia sp!, {r4, pc}
_0206B3B0:
	cmp r0, #0
	bne _0206B3D0
	mov r0, #0x16
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0x18
	ldmia sp!, {r4, pc}
_0206B3D0:
	sub r1, r4, #1
	mov r2, #1
	tst r0, r2, lsl r1
	bne _0206B404
_0206B3E0:
	add r1, r4, #1
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	cmp r4, #0x10
	movhi r0, #0x18
	ldmhiia sp!, {r4, pc}
	sub r1, r4, #1
	tst r0, r2, lsl r1
	beq _0206B3E0
_0206B404:
	ldr r0, =WH_StateOutMeasureChannel
	mov r1, r4
	bl WHi_MeasureChannel
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutMeasureChannel(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206B444
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206B444:
	ldr r0, =whConfig_sVars
	ldr r3, [r0, #0x44]
	cmp r3, #0
	beq _0206B464
	ldrh r1, [r4, #8]
	ldrh r2, [r4, #0xa]
	ldr r0, =aChannelDBratio
	blx r3
_0206B464:
	ldr r0, =whConfig_sVars
	ldrh r3, [r4, #0xa]
	ldrh r1, [r0, #0]
	ldrh ip, [r4, #8]
	cmp r1, r3
	bls _0206B494
	sub r1, ip, #1
	mov r2, #1
	mov r1, r2, lsl r1
	strh r3, [r0]
	strh r1, [r0, #0xe]
	b _0206B4AC
_0206B494:
	bne _0206B4AC
	ldrh r3, [r0, #0xe]
	sub r1, ip, #1
	mov r2, #1
	orr r1, r3, r2, lsl r1
	strh r1, [r0, #0xe]
_0206B4AC:
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_StateInMeasureChannel
	cmp r0, #0x18
	bne _0206B4D0
	mov r0, #7
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206B4D0:
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WHi_MeasureChannel(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r3, r1
	mov ip, #0x1e
	mov r1, #3
	mov r2, #0x11
	str ip, [sp]
	bl WM_MeasureChannel
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u16 WH_GetMeasureChannel(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #7
	beq _0206B524
	bl OS_Terminate
_0206B524:
	mov r0, #1
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	ldrh r0, [r0, #0xe]
	bl WHi_SelectChannel
	ldr r1, =whConfig_sVars
	strh r0, [r1, #0xa]
	ldr r2, [r1, #0x44]
	cmp r2, #0
	beq _0206B558
	ldrh r1, [r1, #0xa]
	ldr r0, =aDecidedChannel
	blx r2
_0206B558:
	ldr r0, =whConfig_sVars
	ldrh r0, [r0, #0xa]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WHi_SelectChannel(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r3, #0
	mov r1, r3
	mov lr, r3
	mov ip, #1
_0206B580:
	tst r0, ip, lsl lr
	beq _0206B5A0
	add r3, lr, #1
	add r2, r1, #1
	mov r1, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, asr #0x10
	mov r1, r2, lsr #0x10
_0206B5A0:
	add r2, lr, #1
	mov r2, r2, lsl #0x10
	mov lr, r2, asr #0x10
	cmp lr, #0x10
	blt _0206B580
	cmp r1, #1
	movls r0, r3
	ldmlsia sp!, {r3, pc}
	ldr ip, =whConfig_sVars
	ldr r3, =0x00010DCD
	ldr lr, [ip, #0x3c]
	mov r2, #0
	mul r3, lr, r3
	add r3, r3, #0x39
	add lr, r3, #0x3000
	and r3, lr, #0xff
	mul r3, r1, r3
	mov r1, r3, lsl #8
	str lr, [ip, #0x3c]
	mov r3, r1, lsr #0x10
_0206B5F0:
	tst r0, #1
	beq _0206B61C
	cmp r3, #0
	bne _0206B610
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	ldmia sp!, {r3, pc}
_0206B610:
	sub r1, r3, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_0206B61C:
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r0, r0, lsl #0xf
	mov r2, r1, asr #0x10
	cmp r2, #0x10
	mov r0, r0, lsr #0x10
	blt _0206B5F0
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL WH_Initialize(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r3, =whConfig_sVars
	mov r1, #0
	str r1, [r3, #0x34]
	str r1, [r3, #0x48]
	str r1, [r3, #0x24]
	strh r1, [r3, #8]
	mov r0, #1
	strh r0, [r3, #2]
	str r1, [r3, #0x4c]
	str r1, [r3, #0xa0]
	ldr r0, =sConnectionSsid
	mov r2, #0x18
	strh r1, [r3, #0xa4]
	bl MI_CpuFill8
	ldr r3, =whConfig_sVars
	mov r1, #0
	ldr r0, =sWMDataSharingInfo
	mov r2, #0x820
	str r1, [r3, #0x50]
	bl MI_CpuFill8
	ldr r0, =sDataSet
	mov r1, #0
	mov r2, #0x200
	bl MI_CpuFill8
	ldr r0, =sWMKeySetBuf
	mov r1, #0
	mov r2, #0x820
	bl MI_CpuFill8
	bl WH_StateInInitialize
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_IndicateHandler(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #8
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	bl OS_Terminate
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateInInitialize(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =sWmBuffer
	ldr r1, =WH_StateOutInitialize
	mov r2, #2
	bl WM_Initialize
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_StateOutInitialize(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206B768
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B768:
	ldr r0, =WH_IndicateHandler
	bl WM_SetIndCallback
	cmp r0, #0
	beq _0206B788
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B788:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_ParentConnect(WHConnectMode mode, u16 tgid, u16 channel)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, =whConfig_sVars
	mov r6, r0
	ldr r0, [r3, #0x1c]
	mov r5, r1
	mov r4, r2
	cmp r0, #1
	beq _0206B7C4
	bl OS_Terminate
	movs r0, #0
_0206B7C4:
	cmp r6, #6
	bne _0206B838
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, =whConfig_sVars
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, =whConfig_sVars
	str r1, [r0, #0x34]
	b _0206B870
_0206B838:
	ldr r0, =whConfig_sVars
	ldrh r2, [r0, #0xc]
	ldrh r1, [r0, #0x10]
	add r3, r2, #0xe
	mul ip, r3, r1
	add r1, r1, #1
	mul r1, r2, r1
	add r2, ip, #0x29
	bic r2, r2, #0x1f
	mov r2, r2, lsl #1
	add r1, r1, #0x27
	str r2, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206B870:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B88C
	ldr r1, [r0, #0x34]
	ldr r0, =aRecvBufferSize
	blx r2
_0206B88C:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B8A8
	ldr r1, [r0, #0x48]
	ldr r0, =aSendBufferSize
	blx r2
_0206B8A8:
	ldr r1, =whConfig_sVars
	mov r0, #3
	str r6, [r1, #0x2c]
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	strh r5, [r0, #0xac]
	strh r4, [r0, #0xd2]
	bl WM_GetDispersionBeaconPeriod
	ldr r1, =whConfig_sVars
	cmp r6, #6
	strh r0, [r1, #0xb8]
	bne _0206B8EC
	ldrh r0, [r1, #6]
	strh r0, [r1, #0xd4]
	ldrh r0, [r1, #0x14]
	strh r0, [r1, #0xd6]
	b _0206B908
_0206B8EC:
	ldrh r0, [r1, #0x10]
	ldrh r2, [r1, #0xc]
	add r0, r0, #1
	mul r0, r2, r0
	add r0, r0, #4
	strh r0, [r1, #0xd4]
	strh r2, [r1, #0xd6]
_0206B908:
	ldr r0, =whConfig_sVars
	cmp r6, #6
	ldrh r1, [r0, #0x10]
	moveq r2, #1
	movne r2, #0
	strh r1, [r0, #0xb0]
	ldr r0, =whConfig_sVars
	mov r1, #0
	strh r2, [r0, #0xb6]
	strh r1, [r0, #0xb2]
	mov r2, #1
	strh r2, [r0, #0xae]
	cmp r6, #2
	movne r2, r1
	ldr r0, =whConfig_sVars
	cmp r6, #6
	strh r2, [r0, #0xb4]
	addls pc, pc, r6, lsl #2
	b _0206B9C4
_0206B954: // jump table
	b _0206B9B8 // case 0
	b _0206B9C4 // case 1
	b _0206B9B8 // case 2
	b _0206B9C4 // case 3
	b _0206B9B8 // case 4
	b _0206B9C4 // case 5
	b _0206B970 // case 6
_0206B970:
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206B984
	ldr r0, =aWfsInitparentC
	blx r1
_0206B984:
	ldr r0, =whConfig_sVars
	mov r1, #0
	ldrh r0, [r0, #6]
	ldr r2, =WH_Alloc
	mov r3, r1
	stmia sp, {r0, r1}
	mov r0, #1
	str r0, [sp, #8]
	bl WFS_InitParent
	mov r0, #1
	bl WFS_SetDebugMode
	mov r0, #0
	bl WFS_EnableSync
_0206B9B8:
	bl WH_StateInSetParentParam
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_0206B9C4:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B9E0
	ldr r0, =aUnknownConnect
	mov r1, r6
	blx r2
_0206B9E0:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_ChildConnect(WHConnectMode mode, WMBssDesc *bssDesc)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =whConfig_sVars
	mov r5, r0
	ldr r0, [r2, #0x1c]
	mov r4, r1
	cmp r0, #1
	beq _0206BA28
	bl OS_Terminate
	movs r0, #0
_0206BA28:
	cmp r5, #7
	bne _0206BA9C
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, =whConfig_sVars
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, =whConfig_sVars
	str r1, [r0, #0x34]
	b _0206BACC
_0206BA9C:
	ldr r0, =whConfig_sVars
	ldrh r1, [r0, #0x10]
	ldrh r2, [r0, #0xc]
	add r1, r1, #1
	mul r1, r2, r1
	add r1, r1, #0x59
	bic r1, r1, #0x1f
	mov r3, r1, lsl #1
	add r1, r2, #0x21
	str r3, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206BACC:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BAE8
	ldr r1, [r0, #0x34]
	ldr r0, =aRecvBufferSize
	blx r2
_0206BAE8:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BB04
	ldr r1, [r0, #0x48]
	ldr r0, =aSendBufferSize
	blx r2
_0206BB04:
	ldr r1, =whConfig_sVars
	mov r0, #3
	str r5, [r1, #0x2c]
	bl WH_ChangeSysState
	cmp r5, #7
	addls pc, pc, r5, lsl #2
	b _0206BBB4
_0206BB20: // jump table
	b _0206BBB4 // case 0
	b _0206BB74 // case 1
	b _0206BBB4 // case 2
	b _0206BB74 // case 3
	b _0206BBB4 // case 4
	b _0206BB74 // case 5
	b _0206BBB4 // case 6
	b _0206BB40 // case 7
_0206BB40:
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206BB58
	ldr r0, =aWfsInitchildCa
	blx r1
_0206BB58:
	mov r1, #0
	ldr r2, =WH_Alloc
	mov r3, r1
	mov r0, #1
	bl WFS_InitChild
	mov r0, #1
	bl WFS_SetDebugMode
_0206BB74:
	ldr r1, =sBssDesc
	mov r0, r4
	mov r2, #0xc0
	bl MI_CpuCopy8
	ldr r0, =sBssDesc
	mov r1, #0xc0
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0206BBAC
	bl WH_StateInSetChildWEPKey
	ldmia sp!, {r3, r4, r5, pc}
_0206BBAC:
	bl WH_StateInStartChild
	ldmia sp!, {r3, r4, r5, pc}
_0206BBB4:
	ldr r0, =whConfig_sVars
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BBD0
	ldr r0, =aUnknownConnect
	mov r1, r5
	blx r2
_0206BBD0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetJudgeAcceptFunc(WHJudgeAcceptFunc func){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =whConfig_sVars
	str r0, [r1, #0x50]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SetReceiver(WHReceiverFunc func)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, =whConfig_sVars
	ldr r1, =WH_PortReceiveCallback
	str r0, [r2, #0x24]
	mov r0, #0xe
	mov r2, #0
	bl WM_SetPortCallback
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, =aWmNotInitializ
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_SendData(void *data, u16 datasize, WHSendCallbackFunc callback){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =WH_StateInSetMPData
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC const void *WH_GetSharedDataAdr(u16 aid){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =WM_GetSharedDataAddress
	mov r2, r0
	ldr r0, =sWMDataSharingInfo
	ldr r1, =sDataSet
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC BOOL WH_StepDS(void *data)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, r0
	ldr r0, =sWMDataSharingInfo
	ldr r2, =sDataSet
	bl WM_StepDataSharing
	mov r4, r0
	cmp r4, #7
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	cmp r4, #5
	bne _0206BCD8
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206BCC8
	ldr r0, =aWhStepdatashar
	blx r1
_0206BCC8:
	mov r0, r4
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r4, pc}
_0206BCD8:
	cmp r4, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_Reset(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl WFS_End
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #5
	bne _0206BD2C
	ldr r0, =sWMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BD2C
	bl WH_SetError
_0206BD2C:
	bl WH_StateInReset
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void WH_Finalize(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r1, [r0, #0x1c]
	cmp r1, #1
	bne _0206BD78
	ldr r1, [r0, #0x44]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, =aAlreadyWhSysst
	blx r1
	ldmia sp!, {r3, pc}
_0206BD78:
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BD8C
	ldr r0, =aWhFinalizeStat
	blx r2
_0206BD8C:
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #2
	bne _0206BDB0
	bl WH_EndScan
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BDB0:
	cmp r0, #6
	cmpne r0, #5
	cmpne r0, #4
	mov r0, #3
	beq _0206BDD0
	bl WH_ChangeSysState
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BDD0:
	bl WH_ChangeSysState
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0206BDE8: // jump table
	b _0206BE7C // case 0
	b _0206BE38 // case 1
	b _0206BE4C // case 2
	b _0206BE08 // case 3
	b _0206BE64 // case 4
	b _0206BE20 // case 5
	b _0206BE60 // case 6
	b _0206BE1C // case 7
_0206BE08:
	bl WH_StateInEndChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE1C:
	bl WFS_End
_0206BE20:
	ldr r0, =sWMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BE38
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE38:
	bl WH_StateInEndChildMP
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE4C:
	bl WH_StateInEndParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE60:
	bl WFS_End
_0206BE64:
	ldr r0, =sWMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BE7C
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE7C:
	bl WH_StateInEndParentMP
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL WH_End(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =whConfig_sVars
	ldr r0, [r0, #0x1c]
	cmp r0, #1
	beq _0206BEB8
	bl OS_Terminate
_0206BEB8:
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, =WH_StateOutEnd
	bl WM_End
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u8 WH_GetCurrentAid(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =whConfig_sVars
	ldrh r0, [r0, #8]
	bx lr

// clang-format on
#endif
}
