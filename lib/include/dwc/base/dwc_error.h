#ifndef DWC_ERROR_H
#define DWC_ERROR_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_ERROR_NONE = 0,
    DWC_ERROR_DS_MEMORY_ANY,
    DWC_ERROR_AUTH_ANY,
    DWC_ERROR_AUTH_OUT_OF_SERVICE,
    DWC_ERROR_AUTH_STOP_SERVICE,
    DWC_ERROR_AC_ANY,
    DWC_ERROR_NETWORK,
    DWC_ERROR_GHTTP_ANY,
    DWC_ERROR_DISCONNECTED,
    DWC_ERROR_FATAL,

    DWC_ERROR_FRIENDS_SHORTAGE,
    DWC_ERROR_NOT_FRIEND_SERVER,
    DWC_ERROR_MO_SC_CONNECT_BLOCK,

    DWC_ERROR_SERVER_FULL,

    DWC_ERROR_ND_ANY,
    DWC_ERROR_ND_HTTP,

    DWC_ERROR_SVL_ANY,
    DWC_ERROR_SVL_HTTP,

    DWC_ERROR_NUM
} DWCError;

typedef enum
{
    DWC_ETYPE_NO_ERROR = 0,
    DWC_ETYPE_LIGHT,
    DWC_ETYPE_SHOW_ERROR,
    DWC_ETYPE_SHUTDOWN_FM,

    DWC_ETYPE_SHUTDOWN_GHTTP,

    DWC_ETYPE_SHUTDOWN_ND,

    DWC_ETYPE_DISCONNECT,

    DWC_ETYPE_FATAL,

    DWC_ETYPE_NUM
} DWCErrorType;

enum
{

    DWC_ECODE_SEQ_LOGIN  = (-60000),
    DWC_ECODE_SEQ_FRIEND = (-70000),
    DWC_ECODE_SEQ_MATCH  = (-80000),
    DWC_ECODE_SEQ_ETC    = (-90000),

    DWC_ECODE_GS_GP    = (-1000),
    DWC_ECODE_GS_PERS  = (-2000),
    DWC_ECODE_GS_STATS = (-3000),
    DWC_ECODE_GS_QR2   = (-4000),
    DWC_ECODE_GS_SB    = (-5000),
    DWC_ECODE_GS_NN    = (-6000),
    DWC_ECODE_GS_GT2   = (-7000),
    DWC_ECODE_GS_HTTP  = (-8000),
    DWC_ECODE_GS_ETC   = (-9000),

    DWC_ECODE_TYPE_NETWORK      = (-10),
    DWC_ECODE_TYPE_SERVER       = (-20),
    DWC_ECODE_TYPE_DNS          = (-30),
    DWC_ECODE_TYPE_DATA         = (-40),
    DWC_ECODE_TYPE_SOCKET       = (-50),
    DWC_ECODE_TYPE_BIND         = (-60),
    DWC_ECODE_TYPE_TIMEOUT      = (-70),
    DWC_ECODE_TYPE_PEER         = (-80),
    DWC_ECODE_TYPE_CONN_OVER    = (-100),
    DWC_ECODE_TYPE_STATS_AUTH   = (-200),
    DWC_ECODE_TYPE_STATS_LOAD   = (-210),
    DWC_ECODE_TYPE_STATS_SAVE   = (-220),
    DWC_ECODE_TYPE_NOT_FRIEND   = (-400),
    DWC_ECODE_TYPE_OTHER        = (-410),
    DWC_ECODE_TYPE_MUCH_FAILURE = (-420),
    DWC_ECODE_TYPE_SC_CL_FAIL   = (-430),
    DWC_ECODE_TYPE_CLOSE        = (-600),
    DWC_ECODE_TYPE_TRANS_HEADER = (-610),
    DWC_ECODE_TYPE_TRANS_BODY   = (-620),
    DWC_ECODE_TYPE_AC_FATAL     = (-700),
    DWC_ECODE_TYPE_OPEN_FILE    = (-800),
    DWC_ECODE_TYPE_INVALID_POST = (-810),
    DWC_ECODE_TYPE_REQ_INVALID  = (-820),
    DWC_ECODE_TYPE_UNSPECIFIED  = (-830),
    DWC_ECODE_TYPE_BUFF_OVER    = (-840),
    DWC_ECODE_TYPE_PARSE_URL    = (-850),
    DWC_ECODE_TYPE_BAD_RESPONSE = (-860),
    DWC_ECODE_TYPE_REJECTED     = (-870),
    DWC_ECODE_TYPE_FILE_RW      = (-880),
    DWC_ECODE_TYPE_INCOMPLETE   = (-890),
    DWC_ECODE_TYPE_TO_BIG       = (-900),
    DWC_ECODE_TYPE_ENCRYPTION   = (-910),

    DWC_ECODE_TYPE_ALLOC      = (-1),
    DWC_ECODE_TYPE_PARAM      = (-2),
    DWC_ECODE_TYPE_SO_SOCKET  = (-3),
    DWC_ECODE_TYPE_NOT_INIT   = (-4),
    DWC_ECODE_TYPE_DUP_INIT   = (-5),
    DWC_ECODE_TYPE_WM_INIT    = (-6),
    DWC_ECODE_TYPE_UNEXPECTED = (-9),

    DWC_ECODE_SEQ_ADDINS = (-30000),

    DWC_ECODE_FUNC_ND = (-1000),

    DWC_ECODE_TYPE_ND_ALLOC   = (-1),
    DWC_ECODE_TYPE_ND_FATAL   = (-9),
    DWC_ECODE_TYPE_ND_BUSY    = (-10),
    DWC_ECODE_TYPE_ND_HTTP    = (-20),
    DWC_ECODE_TYPE_ND_BUFFULL = (-30),
    DWC_ECODE_TYPE_ND_SERVER  = (0)
};

// --------------------
// FUNCTIONS
// --------------------

extern DWCError DWC_GetLastError(int *errorCode);
extern DWCError DWC_GetLastErrorEx(int *errorCode, DWCErrorType *errorType);
extern void DWC_ClearError(void);
extern BOOL DWCi_IsError(void);
extern void DWCi_SetError(DWCError error, int errorCode);

#ifdef __cplusplus
}
#endif

#endif // DWC_ERROR_H