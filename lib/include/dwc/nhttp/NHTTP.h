#ifndef NHTTP_NHTTP_H
#define NHTTP_NHTTP_H

#include <nitro.h>
#include <nitroWiFi.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define NHTTP_COMMTHREAD_STACK (8 * 1024)

#define NHTTP_HTTP_PORT  80
#define NHTTP_HTTPS_PORT 443

#define NHTTP_STR_HTTPVER "1.1"

#define NHTTP_HDRRECVBUF_INILEN 1024

#define NHTTP_HDRRECVBUF_BLOCKSHIFT 9
#define NHTTP_HDRRECVBUF_BLOCKLEN   (1 << NHTTP_HDRRECVBUF_BLOCKSHIFT)
#define NHTTP_HDRRECVBUF_BLOCKMASK  (NHTTP_HDRRECVBUF_BLOCKLEN - 1)

// --------------------
// ENUMS
// --------------------

typedef enum
{
    NHTTP_ERROR_NONE,
    NHTTP_ERROR_ALLOC,
    NHTTP_ERROR_TOOMANYREQ,
    NHTTP_ERROR_SOCKET,
    NHTTP_ERROR_DNS,
    NHTTP_ERROR_CONNECT,
    NHTTP_ERROR_BUFFULL,
    NHTTP_ERROR_HTTPPARSE,
    NHTTP_ERROR_CANCELED,
    NHTTP_ERROR_NITROSDK,
    NHTTP_ERROR_NITROWIFI,
    NHTTP_ERROR_UNKNOWN,
    NHTTP_ERROR_MAX
} NHTTPError;

typedef enum
{
    NHTTP_REQMETHOD_GET,
    NHTTP_REQMETHOD_POST,
    NHTTP_REQMETHOD_HEAD,
    NHTTP_REQMETHOD_MAX
} NHTTPReqMethod;

// --------------------
// TYPES
// --------------------

typedef struct _NHTTPRes NHTTPRes;
typedef struct _NHTTPReq NHTTPReq;
typedef void *(*NHTTPAlloc)(u32 size, int align);
typedef void (*NHTTPFree)(void *ptr);
typedef void (*NHTTPCleanupCallback)(void);
typedef void (*NHTTPReqCallback)(NHTTPError error, NHTTPRes *res, void *param);

// --------------------
// FUNCTIONS
// --------------------

BOOL NHTTP_Startup(NHTTPAlloc alloc, NHTTPFree free, u32 threadprio);
void NHTTP_CleanupAsync(NHTTPCleanupCallback callback);
NHTTPError NHTTP_GetError(void);

NHTTPReq *NHTTP_CreateRequest(char *url, NHTTPReqMethod method, char *buf, u32 len, NHTTPReqCallback callback, void *param);
void NHTTP_DestroyRequest(NHTTPReq *req);
BOOL NHTTP_AddHeaderField(NHTTPReq *req, char *label, char *value);
BOOL NHTTP_AddPostDataAscii(NHTTPReq *req, char *label, char *value);
BOOL NHTTP_AddPostDataBinary(NHTTPReq *req, char *label, char *value, u32 length);
BOOL NHTTP_SetCAChain(NHTTPReq *req, SOCCaInfo **cainfo, int calength);

int NHTTP_SendRequestAsync(NHTTPReq *req);
BOOL NHTTP_CancelRequestAsync(int id);
BOOL NHTTP_GetProgress(u32 *received, u32 *contentlen);
void NHTTP_DestroyResponse(NHTTPRes *res);
int NHTTP_GetHeaderField(NHTTPRes *res, char *label, char **value);
int NHTTP_GetHeaderAll(NHTTPRes *res, char **value);
int NHTTP_GetBodyAll(NHTTPRes *res, char **value);

#ifdef __cplusplus
}
#endif

#endif // NHTTP_NHTTP_H
