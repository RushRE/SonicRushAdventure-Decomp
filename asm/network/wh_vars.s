	.include "asm/macros.inc"
	.include "global.inc"

    .bss

.public whConfig_sChannelBusyRatio
whConfig_sVars: // 0x02136400
	.space 0x02

.public whConfig_sConnectBitmap
whConfig_sConnectBitmap: // 0x02136402
	.space 0x02

.public whConfig_sChannelIndex
whConfig_sChannelIndex: // 0x02136404
	.space 0x02

.public whConfig_wmMaxParentSize
whConfig_wmMaxParentSize: // 0x02136406
	.space 0x02

.public whConfig_sMyAid
whConfig_sMyAid: // 0x02136408
	.space 0x02

.public whConfig_sChannel
whConfig_sChannel: // 0x0213640A
	.space 0x02

.public whConfig_wmMinDataSize
whConfig_wmMinDataSize: // 0x0213640C
	.space 0x02

.public whConfig_sChannelBitmap
whConfig_sChannelBitmap: // 0x0213640E
	.space 0x02

.public whConfig_wmMaxChildCount
whConfig_wmMaxChildCount: // 0x02136410
	.space 0x02

.public whConfig_sAutoConnectFlag
whConfig_sAutoConnectFlag: // 0x02136412
	.space 0x02

.public whConfig_wmMaxChildSize
whConfig_wmMaxChildSize: // 0x02136414
	.space 0x02
	.align 4

.public whConfig_dword_2136418
whConfig_dword_2136418: // 0x02136418
	.space 0x04

.public whConfig_sSysState
whConfig_sSysState: // 0x0213641C
	.space 0x04

.public whConfig_whAllocFunc
whConfig_whAllocFunc: // 0x02136420
	.space 0x04

.public whConfig_sReceiverFunc
whConfig_sReceiverFunc: // 0x02136424
	.space 0x04

.public whConfig_sScanCallback
whConfig_sScanCallback: // 0x02136428
	.space 0x04

.public whConfig_sConnectMode
whConfig_sConnectMode: // 0x0213642C
	.space 0x04

.public whConfig_sParentWEPKeyGenerator
whConfig_sParentWEPKeyGenerator: // 0x02136430
	.space 0x04

.public whConfig_sRecvBufferSize
whConfig_sRecvBufferSize: // 0x02136434
	.space 0x04

.public whConfig_sPictoCatchFlag
whConfig_sPictoCatchFlag: // 0x02136438
	.space 0x04

.public whConfig_sRand
whConfig_sRand: // 0x0213643C
	.space 0x04

.public whConfig_whFreeFunc
whConfig_whFreeFunc: // 0x02136440
	.space 0x04

.public whConfig_wh_trace
whConfig_wh_trace: // 0x02136444
	.space 0x04

.public whConfig_sSendBufferSize
whConfig_sSendBufferSize: // 0x02136448
	.space 0x04

.public whConfig_sErrCode
whConfig_sErrCode: // 0x0213644C
	.space 0x04

.public whConfig_sJudgeAcceptFunc
whConfig_sJudgeAcceptFunc: // 0x02136450
	.space 0x04

.public whConfig_dword_2136454
whConfig_dword_2136454: // 0x02136454
	.space 0x04

.public whConfig_dword_2136458
whConfig_dword_2136458: // 0x02136458
	.space 0x04

.public whConfig_dword_213645C
whConfig_dword_213645C: // 0x0213645C
	.space 0x04


.public sWEPKey
sWEPKey: // 0x02136460
	.space 16 * 0x02
	
.public sScanParam
sScanParam: // 0x02136480
	.space 0x20 // WMScanParam
	
.public sParentParam
sParentParam: // 0x021364A0
	.space 0x40 // WMParentParam
	
.public sBssDesc
sBssDesc: // 0x021364E0
	.space 0xC0 // WMBssDesc
	
.public sDataSet
sDataSet: // 0x021365A0
	.space 0x200 // WMDataSet
	
.public sWMKeySetBuf
sWMKeySetBuf: // 0x021367A0
	.space 0x820 // WMKeySetBuf
	
.public sWMDataSharingInfo
sWMDataSharingInfo: // 0x02136FC0
	.space 0x820 // WMDataSharingInfo
	
.public sConnectionSsid
sConnectionSsid: // 0x021377E0
	.space 32 * 0x01
	
.public sSendBuffer
sSendBuffer: // 0x02137800
	.space 544 * 0x01
	
.public sRecvBuffer
sRecvBuffer: // 0x02137A20
	.space 0x480 * 0x01
	
.public sWmBuffer
sWmBuffer: // 0x02137EA0
	.space 0xF00 * 0x01

	.data

.public aNA
aNA: // 0x02119F0C
	.asciz "N/A"
	.align 4

aWhSysstateIdle: // 0x02119F10
	.asciz "WH_SYSSTATE_IDLE"
	.align 4

aWhSysstateBusy: // 0x02119F24
	.asciz "WH_SYSSTATE_BUSY"
	.align 4

aWhSysstateStop: // 0x02119F38
	.asciz "WH_SYSSTATE_STOP"
	.align 4

aWhSysstateErro: // 0x02119F4C
	.asciz "WH_SYSSTATE_ERROR"
	.align 4

aWmErrcodeFaile: // 0x02119F60
	.asciz "WM_ERRCODE_FAILED"
	.align 4

aWmErrcodeSucce: // 0x02119F74
	.asciz "WM_ERRCODE_SUCCESS"
	.align 4

aWmErrcodeNoDat: // 0x02119F88
	.asciz "WM_ERRCODE_NO_DATA"
	.align 4

aWmErrcodeTimeo: // 0x02119F9C
	.asciz "WM_ERRCODE_TIMEOUT"
	.align 4

aWmStatecodeMpI: // 0x02119FB0
	.asciz "WM_STATECODE_MP_IND"
	.align 4

aWhErrcodeNoRad: // 0x02119FC4
	.asciz "WH_ERRCODE_NO_RADIO"
	.align 4

aWmErrcodeNoChi: // 0x02119FD8
	.asciz "WM_ERRCODE_NO_CHILD"
	.align 4

aWmErrcodeNoEnt: // 0x02119FEC
	.asciz "WM_ERRCODE_NO_ENTRY"
	.align 4

aWmErrcodeDcfTe: // 0x0211A000
	.asciz "WM_ERRCODE_DCF_TEST"
	.align 4

aWmStatecodeDcf: // 0x0211A014
	.asciz "WM_STATECODE_DCF_IND"
	.align 4

aWmStatecodeUnk: // 0x0211A02C
	.asciz "WM_STATECODE_UNKNOWN"
	.align 4

aWhSysstateScan: // 0x0211A044
	.asciz "WH_SYSSTATE_SCANNING"
	.align 4

aWmErrcodeOpera: // 0x0211A05C
	.asciz "WM_ERRCODE_OPERATING"
	.align 4

aWmStatecodeMpS: // 0x0211A074
	.asciz "WM_STATECODE_MP_START"
	.align 4

aWmErrcodeNoDat_0: // 0x0211A08C
	.asciz "WM_ERRCODE_NO_DATASET"
	.align 4

aWmErrcodeFifoE: // 0x0211A0A4
	.asciz "WM_ERRCODE_FIFO_ERROR"
	.align 4

aWmErrcodeWmDis: // 0x0211A0BC
	.asciz "WM_ERRCODE_WM_DISABLE"
	.align 4

aWhSysstateConn: // 0x0211A0D4
	.asciz "WH_SYSSTATE_CONNECTED"
	.align 4

aWmStatecodeMpe: // 0x0211A0EC
	.asciz "WM_STATECODE_MPEND_IND"
	.align 4

aWmStatecodeMpa: // 0x0211A104
	.asciz "WM_STATECODE_MPACK_IND"
	.align 4

aWmStatecodeDcf_0: // 0x0211A11C
	.asciz "WM_STATECODE_DCF_START"
	.align 4

aWmStatecodePor: // 0x0211A134
	.asciz "WM_STATECODE_PORT_SEND"
	.align 4

aWmStatecodePor_0: // 0x0211A14C
	.asciz "WM_STATECODE_PORT_RECV"
	.align 4

aWmStatecodePor_1: // 0x0211A164
	.asciz "WM_STATECODE_PORT_INIT"
	.align 4

aWmErrcodeSendF: // 0x0211A17C
	.asciz "WM_ERRCODE_SEND_FAILED"
	.align 4

aWmErrcodeFlash: // 0x0211A194
	.asciz "WM_ERRCODE_FLASH_ERROR"
	.align 4

aWhSysstateKeys: // 0x0211A1AC
	.asciz "WH_SYSSTATE_KEYSHARING"
	.align 4

aWmStatecodeCon: // 0x0211A1C4
	.asciz "WM_STATECODE_CONNECTED"
	.align 4

aWmStatecodeFif: // 0x0211A1DC
	.asciz "WM_STATECODE_FIFO_ERROR"
	.align 4

aWhSysstateData: // 0x0211A1F4
	.asciz "WH_SYSSTATE_DATASHARING"
	.align 4

aWhErrcodeDisco: // 0x0211A20C
	.asciz "WH_ERRCODE_DISCONNECTED"
	.align 4

aWmStatecodeSca: // 0x0211A224
	.asciz "WM_STATECODE_SCAN_START"
	.align 4

aWmStatecodeBea: // 0x0211A23C
	.asciz "WM_STATECODE_BEACON_LOST"
	.align 4

aWmStatecodeBea_0: // 0x0211A258
	.asciz "WM_STATECODE_BEACON_RECV"
	.align 4

aWmStatecodeRea: // 0x0211A274
	.asciz "WM_STATECODE_REASSOCIATE"
	.align 4

aWmStatecodeInf: // 0x0211A290
	.asciz "WM_STATECODE_INFORMATION"
	.align 4

aWmErrcodeIlleg: // 0x0211A2AC
	.asciz "WM_ERRCODE_ILLEGAL_STATE"
	.align 4

aWmErrcodeInval: // 0x0211A2C8
	.asciz "WM_ERRCODE_INVALID_PARAM"
	.align 4

aWmErrcodeWlLen: // 0x0211A2E4
	.asciz "WM_ERRCODE_WL_LENGTH_ERR"
	.align 4

aWhSysstateConn_0: // 0x0211A300
	.asciz "WH_SYSSTATE_CONNECT_FAIL"
	.align 4

aWmStatecodeBea_1: // 0x0211A31C
	.asciz "WM_STATECODE_BEACON_SENT"
	.align 4

aWmStatecodeDis: // 0x0211A338
	.asciz "WM_STATECODE_DISCONNECTED"
	.align 4

aWmStatecodeDis_0: // 0x0211A354
	.asciz "WM_STATECODE_DISASSOCIATE"
	.align 4

aWmStatecodeAut: // 0x0211A370
	.asciz "WM_STATECODE_AUTHENTICATE"
	.align 4

aWmErrcodeOverM: // 0x0211A38C
	.asciz "WM_ERRCODE_OVER_MAX_ENTRY"
	.align 4

aWmStatecodePar: // 0x0211A3A8
	.asciz "WM_STATECODE_PARENT_START"
	.align 4

aWmStatecodePar_0: // 0x0211A3C4
	.asciz "WM_STATECODE_PARENT_FOUND"
	.align 4

aWmErrcodeSendQ: // 0x0211A3E0
	.asciz "WM_ERRCODE_SEND_QUEUE_FULL"
	.align 4

aWhSysstateMeas: // 0x0211A3FC
	.asciz "WH_SYSSTATE_MEASURECHANNEL"
	.align 4

aWmStatecodeCon_0: // 0x0211A418
	.asciz "WM_STATECODE_CONNECT_START"
	.align 4

aWmErrcodeWlInv: // 0x0211A434
	.asciz "WM_ERRCODE_WL_INVALID_PARAM"
	.align 4

aWhErrcodeParen: // 0x0211A450
	.asciz "WH_ERRCODE_PARENT_NOT_FOUND"
	.align 4

aWmErrcodeInval_0: // 0x0211A46C
	.asciz "WM_ERRCODE_INVALID_POLLBITMAP"
	.align 4

aWmStatecodePar_1: // 0x0211A48C
	.asciz "WM_STATECODE_PARENT_NOT_FOUND"
	.align 4

aWmStatecodeDis_1: // 0x0211A4AC
	.asciz "WM_STATECODE_DISCONNECTED_FROM_MYSELF"
	.align 4

.public WH__sStateNames
WH__sStateNames: // 0x0211A4D4
	.word aWhSysstateStop     // "WH_SYSSTATE_STOP"
	.word aWhSysstateIdle     // "WH_SYSSTATE_IDLE"
	.word aWhSysstateScan     // "WH_SYSSTATE_SCANNING"
	.word aWhSysstateBusy     // "WH_SYSSTATE_BUSY"
	.word aWhSysstateConn     // "WH_SYSSTATE_CONNECTED"
	.word aWhSysstateData     // "WH_SYSSTATE_DATASHARING"
	.word aWhSysstateKeys     // "WH_SYSSTATE_KEYSHARING"
	.word aWhSysstateMeas     // "WH_SYSSTATE_MEASURECHANNEL"
	.word aWhSysstateConn_0   // "WH_SYSSTATE_CONNECT_FAIL"
	.word aWhSysstateErro     // "WH_SYSSTATE_ERROR"

.public WH__errnames
WH__errnames:  // 0x0211A4FC
    .word aWmErrcodeSucce 	  // "WM_ERRCODE_SUCCESS"
	.word aWmErrcodeFaile     // "WM_ERRCODE_FAILED"
	.word aWmErrcodeOpera     // "WM_ERRCODE_OPERATING"
	.word aWmErrcodeIlleg     // "WM_ERRCODE_ILLEGAL_STATE"
	.word aWmErrcodeWmDis     // "WM_ERRCODE_WM_DISABLE"
	.word aWmErrcodeNoDat_0   // "WM_ERRCODE_NO_DATASET"
	.word aWmErrcodeInval     // "WM_ERRCODE_INVALID_PARAM"
	.word aWmErrcodeNoChi     // "WM_ERRCODE_NO_CHILD"
	.word aWmErrcodeFifoE     // "WM_ERRCODE_FIFO_ERROR"
	.word aWmErrcodeTimeo     // "WM_ERRCODE_TIMEOUT"
	.word aWmErrcodeSendQ     // "WM_ERRCODE_SEND_QUEUE_FULL"
	.word aWmErrcodeNoEnt     // "WM_ERRCODE_NO_ENTRY"
	.word aWmErrcodeOverM     // "WM_ERRCODE_OVER_MAX_ENTRY"
	.word aWmErrcodeInval_0   // "WM_ERRCODE_INVALID_POLLBITMAP"
	.word aWmErrcodeNoDat     // "WM_ERRCODE_NO_DATA"
	.word aWmErrcodeSendF     // "WM_ERRCODE_SEND_FAILED"
	.word aWmErrcodeDcfTe     // "WM_ERRCODE_DCF_TEST"
	.word aWmErrcodeWlInv     // "WM_ERRCODE_WL_INVALID_PARAM"
	.word aWmErrcodeWlLen     // "WM_ERRCODE_WL_LENGTH_ERR"
	.word aWmErrcodeFlash     // "WM_ERRCODE_FLASH_ERROR"
	.word aWhErrcodeDisco     // "WH_ERRCODE_DISCONNECTED"
	.word aWhErrcodeParen     // "WH_ERRCODE_PARENT_NOT_FOUND"
	.word aWhErrcodeNoRad     // "WH_ERRCODE_NO_RADIO"

.public WH__statenames
WH__statenames: // 0x0211A558
	.word aWmStatecodePar 	 // "WM_STATECODE_PARENT_START"
	.word aNA                // "N/A"
	.word aWmStatecodeBea_1  // "WM_STATECODE_BEACON_SENT"
	.word aWmStatecodeSca    // "WM_STATECODE_SCAN_START"
	.word aWmStatecodePar_1  // "WM_STATECODE_PARENT_NOT_FOUND"
	.word aWmStatecodePar_0  // "WM_STATECODE_PARENT_FOUND"
	.word aWmStatecodeCon_0  // "WM_STATECODE_CONNECT_START"
	.word aWmStatecodeCon    // "WM_STATECODE_CONNECTED"
	.word aWmStatecodeBea    // "WM_STATECODE_BEACON_LOST"
	.word aWmStatecodeDis    // "WM_STATECODE_DISCONNECTED"
	.word aWmStatecodeMpS    // "WM_STATECODE_MP_START"
	.word aWmStatecodeMpe    // "WM_STATECODE_MPEND_IND"
	.word aWmStatecodeMpI    // "WM_STATECODE_MP_IND"
	.word aWmStatecodeMpa    // "WM_STATECODE_MPACK_IND"
	.word aWmStatecodeDcf_0  // "WM_STATECODE_DCF_START"
	.word aWmStatecodeDcf    // "WM_STATECODE_DCF_IND"
	.word aWmStatecodeBea_0  // "WM_STATECODE_BEACON_RECV"
	.word aWmStatecodeDis_0  // "WM_STATECODE_DISASSOCIATE"
	.word aWmStatecodeRea    // "WM_STATECODE_REASSOCIATE"
	.word aWmStatecodeAut    // "WM_STATECODE_AUTHENTICATE"
	.word aWmStatecodePor    // "WM_STATECODE_PORT_SEND"
	.word aWmStatecodePor_0  // "WM_STATECODE_PORT_RECV"
	.word aWmStatecodeFif    // "WM_STATECODE_FIFO_ERROR"
	.word aWmStatecodeInf    // "WM_STATECODE_INFORMATION"
	.word aWmStatecodeUnk    // "WM_STATECODE_UNKNOWN"
	.word aWmStatecodePor_1  // "WM_STATECODE_PORT_INIT"
	.word aWmStatecodeDis_1  // "WM_STATECODE_DISCONNECTED_FROM_MYSELF"

.public aNA_0
aNA_0: // 0x0211A5C4
	.asciz "N/A"
    .align 4

aS: // 0x0211A5C8
	.asciz "%s -> "
    .align 4

.public aS_0
aS_0: // 0x211A5D0
	.asciz "%s\n"
    .align 4

aWhCallbackforw: // 0x0211A5D4
	.asciz "WH_CallbackForWFS : WFS_Start\n"
    .align 4

aStartparentNew: // 0x0211A5F4
	.asciz "StartParent - new child (aid 0x%x) connected\n"
    .align 4

aStartparentChi: // 0x0211A624
	.asciz "StartParent - child (aid 0x%x) disconnected\n"
    .align 4

aStartparentChi_0: // 0x0211A654
	.asciz "StartParent - child (aid 0x%x) disconnected from myself\n"
    .align 4

aUnknownIndicat: // 0x0211A690
	.asciz "unknown indicate, state = %d\n"
    .align 4

aWhStateinstart: // 0x0211A6B0
	.asciz "WH_StateInStartParentKeyShare failed\n"
    .align 4

aWhStateinendpa: // 0x0211A6D8
	.asciz "WH_StateInEndParentMP failed\n"
    .align 4

aWhStateinendpa_0: // 0x0211A6F8
	.asciz "WH_StateInEndParent failed\n"
    .align 4

aRecvBufferSize: // 0x0211A714
	.asciz "recv buffer size = %d\n"
    .align 4

aSendBufferSize: // 0x0211A72C
	.asciz "send buffer size = %d\n"
    .align 4

aWfsInitchildCa: // 0x0211A744
	.asciz "WFS_InitChild call\n"
    .align 4

aWhStateoutstar: // 0x0211A758
	.asciz "WH_StateOutStartScan : MAC=%02x%02x%02x%02x%02x%02x "
    .align 4

aPictochatParen: // 0x0211A790
	.asciz "pictochat parent find\n"
    .align 4

aNotMyParentGgi: // 0x0211A7A8
	.asciz "not my parent ggid \n"
    .align 4

aNotReceiveEntr: // 0x0211A7C0
	.asciz "not recieve entry\n"
    .align 4

aParentFind: // 0x0211A7D4
	.asciz "parent find\n"
    .align 4

aWhStateoutends: // 0x0211A7E4
	.asciz "WH_StateOutEndScan : startchild failed\n"
    .align 4

aWhStateoutsetc: // 0x0211A80C
	.asciz "WH_StateOutSetChildWEPKey : startchild failed\n"
    .align 4

aWhStateinstart_0: // 0x0211A83C
	.asciz "WH_StateInStartChild : already connected?\n"
    .align 4

aConnectToParen: // 0x0211A868
	.asciz "Connect to Parent\n"
    .align 4

aWhStateinstart_1: // 0x0211A87C
	.asciz "WH_StateInStartChildMP failed\n"
    .align 4

aDisconnectedFr: // 0x0211A89C
	.asciz "Disconnected from Parent\n"
    .align 4

aUnknownStateDS: // 0x0211A8B8
	.asciz "unknown state %d, %s\n"
    .align 4

aWhStateinstart_2: // 0x0211A8D0
	.asciz "WH_StateInStartChildKeyShare failed\n"
    .align 4

aWhStateoutstar_0: // 0x0211A8F8
	.asciz "WH_StateOutStartChildMP : WM_StartDataSharing OK\n"
    .align 4

aWhStateinsetmp: // 0x0211A92C
	.asciz "WH_StateInSetMPData failed - %s\n"
    .align 4

aChannelDBratio: // 0x0211A950
	.asciz "channel %d bratio = 0x%x\n"
    .align 4

aDecidedChannel: // 0x0211A96C
	.asciz "decided channel = %d\n"
    .align 4

aWfsInitparentC: // 0x0211A984
	.asciz "WFS_InitParent call\n"
    .align 4

aUnknownConnect: // 0x0211A99C
	.asciz "unknown connect mode %d\n"
    .align 4

aWmNotInitializ: // 0x0211A9B8
	.asciz "WM not Initialized\n"
    .align 4

aWhStepdatashar: // 0x0211A9CC
	.asciz "WH_StepDataSharing - Warning No DataSet\n"
    .align 4

aAlreadyWhSysst: // 0x0211A9F8
	.asciz "already WH_SYSSTATE_IDLE\n"
    .align 4

aWhFinalizeStat: // 0x0211AA14
	.asciz "WH_Finalize, state = %d\n"
    .align 4