#ifndef DWC_RNK_H
#define DWC_RNK_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define DWC_RNK_DATA_MAX     768
#define DWC_RNK_CATEGORY_MAX 100

#define DWC_RNK_ORDER_ASC 0
#define DWC_RNK_ORDER_DES 1

#define DWC_RNK_GET_MAX     10
#define DWC_RNK_FRIENDS_MAX 64

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_RNK_SUCCESS = 0,
    DWC_RNK_IN_ERROR,

    DWC_RNK_ERROR_INVALID_PARAMETER,

    DWC_RNK_ERROR_INIT_ALREADYINITIALIZED,
    DWC_RNK_ERROR_INIT_INVALID_INITDATASIZE,
    DWC_RNK_ERROR_INIT_INVALID_INITDATA,
    DWC_RNK_ERROR_INIT_INVALID_USERDATA,

    DWC_RNK_ERROR_PUT_NOTREADY,
    DWC_RNK_ERROR_PUT_INVALID_KEY,
    DWC_RNK_ERROR_PUT_NOMEMORY,

    DWC_RNK_ERROR_GET_NOTREADY,
    DWC_RNK_ERROR_GET_INVALID_KEY,
    DWC_RNK_ERROR_GET_NOMEMORY,

    DWC_RNK_ERROR_CANCEL_NOTASK,

    DWC_RNK_PROCESS_NOTASK,

    DWC_RNK_ERROR_INVALID_MODE,
    DWC_RNK_ERROR_NOTCOMPLETED,
    DWC_RNK_ERROR_EMPTY_RESPONSE
} DWCRnkError;

typedef enum
{
    DWC_RNK_STATE_NOTREADY = 0,

    DWC_RNK_STATE_INITIALIZED,
    DWC_RNK_STATE_PUT_ASYNC,
    DWC_RNK_STATE_GET_ASYNC,
    DWC_RNK_STATE_COMPLETED,

    DWC_RNK_STATE_ERROR
} DWCRnkState;

typedef enum
{
    DWC_RNK_REGION_JP = 0x01,
    DWC_RNK_REGION_US = 0x02,
    DWC_RNK_REGION_EU = 0x04,

    DWC_RNK_REGION_ALL = 0x07
} DWCRnkRegion;

typedef enum
{
    DWC_RNK_GET_MODE_ORDER,
    DWC_RNK_GET_MODE_TOPLIST,
    DWC_RNK_GET_MODE_NEAR,
    DWC_RNK_GET_MODE_FRIENDS
} DWCRnkGetMode;

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 order;
    s32 pid;
    s32 score;
    DWCRnkRegion region;
    u32 lastupdate;

    u32 size;
    void *userdata;
} DWCRnkData;

typedef struct
{
    u32 size;

    union
    {

        struct
        {
            u32 sort;

            u32 since;
        } order;

        struct
        {
            u32 sort;

            u32 limit;
            u32 since;
        } toplist;

        struct
        {
            u32 sort;

            u32 limit;
            u32 since;
        } near;

        struct
        {
            u32 sort;

            u32 limit;
            u32 since;
            s32 friends[DWC_RNK_FRIENDS_MAX];
        } friends;

        u32 data;
    };
} DWCRnkGetParam;

// --------------------
// FUNCTIONS
// --------------------

DWCRnkError DWC_RnkInitialize(const char *initdata, const DWCUserData *userdata);
DWCRnkError DWC_RnkShutdown();
DWCRnkError DWC_RnkPutScoreAsync(u32 category, DWCRnkRegion region, s32 score, void *data, u32 size);
DWCRnkError DWC_RnkGetScoreAsync(DWCRnkGetMode mode, u32 category, DWCRnkRegion region, DWCRnkGetParam *param);
DWCRnkError DWC_RnkCancelProcess();
DWCRnkError DWC_RnkProcess();
DWCRnkState DWC_RnkGetState();
DWCRnkError DWC_RnkResGetRow(DWCRnkData *out, u32 index);
DWCRnkError DWC_RnkResGetRowCount(u32 *count);
DWCRnkError DWC_RnkResGetOrder(u32 *order);
DWCRnkError DWC_RnkResGetTotal(u32 *total);

#ifdef __cplusplus
}
#endif

#endif // DWC_RNK_H