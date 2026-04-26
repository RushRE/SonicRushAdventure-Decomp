#ifndef RUSH_WFS_H
#define RUSH_WFS_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// TYPES
// --------------------

typedef void (*WFSStateCallback)(void *);

typedef void *(*WFSAllocator)(void *arg, size_t size, void *ptr);

// --------------------
// CONSTANTS
// --------------------

#define WFS_FILE_HANDLE_MAX (WM_NUM_MAX_CHILD * 2)

#define WFS_FILE_CACHE_SIZE (CARD_ROM_PAGE_SIZE * 2)

#define WFS_FILE_CACHE_LINE 2

#define WFS_BITMAP_TO_PARENT 1

// --------------------
// ENUMS
// --------------------

enum WFSState_
{
    WFS_STATE_STOP,
    WFS_STATE_IDLE,
    WFS_STATE_READY,
    WFS_STATE_ERROR,
};
typedef u32 WFSState;

enum WFSiFileStatus_
{
    WFS_FILE_STAT_FREE,
    WFS_FILE_STAT_OPENING,
    WFS_FILE_STAT_ALIVE,
    WFS_FILE_STAT_CLOSING
};
typedef u32 WFSiFileStatus;

// --------------------
// STRUCTS
// --------------------

typedef struct WFSiMessage_
{
    u32 type : 4;
    u32 pck_h : 4;
    u32 flag : 24;
    u32 arg;
    u8 pck_l;
    u8 reserved[3];
} WFSiMessage;

typedef struct WFSiFileList_
{
    struct WFSiFileList_ *next;
    WBTBlockInfoList info;
    FSFile file;

    WFSiFileStatus stat;
    int ref;
    int req_bitmap;

    u32 own_id;
    u32 rom_src;
    u32 rom_len;

    u32 ack_seq;
    int busy_page;
    int last_page;
    int page[WFS_FILE_CACHE_LINE];
    u8 cache[WFS_FILE_CACHE_LINE][WFS_FILE_CACHE_SIZE] ATTRIBUTE_ALIGN(32);
} WFSiFileList;

typedef struct WFSChildContext_
{
    WBTBlockInfoTable block_info_table;
    WBTRecvBufTable recv_buf_table;
    WBTPacketBitmapTable recv_buf_packet_bmp_table;
    WBTBlockInfo block_info[WBT_NUM_OF_AID];
    WMStatus status[1] ATTRIBUTE_ALIGN(32);
    u32 *recv_pkt_bmp_buf;
    u32 base_offset;
    u32 max_file_size;
    u32 block_id;
} WFSChildContext;

typedef struct WFSParentContext_
{
    WFSiMessage recv_msg[WBT_NUM_OF_AID];

    WFSiFileList list[WFS_FILE_HANDLE_MAX];
    WFSiFileList *free_list;
    WFSiFileList *alive_list;
    WFSiFileList *busy_list;

    int ack_bitmap;
    int sync_bitmap;
    BOOL msg_busy;

    int all_bitmap;
    int busy_bitmap;

    BOOL is_changing;
    int busy_count;
    int deny_bitmap;
    int new_packet_size;

    u32 sentFileCount[0x10];

} WFSParentContext;

typedef struct WFSWork_
{
    BOOL is_parent;
    BOOL send_idle;
    BOOL is_running;

    WFSState state;
    WFSStateCallback state_func;
    WFSAllocator alloc_func;
    void *alloc_arg;

    FSFile *target_file;

    u8 *table;
    u32 table_size;

    int parent_packet_size;
    int child_packet_size;

    u16 port;

    u8 padding1[14];

    u8 send_buf[1024] ATTRIBUTE_ALIGN(32);

    union
    {
        WFSParentContext parent[1] ATTRIBUTE_ALIGN(32);
        WFSChildContext child[1] ATTRIBUTE_ALIGN(32);
    } context;
} WFSWork;

// --------------------
// FUNCTIONS
// --------------------

void WFS_InitParent(int port, WFSStateCallback callback, WFSAllocator allocator, void *allocatorArg, int parentPacket, FSFile *rom, BOOL useParentFS);
void WFS_InitChild(int port, WFSStateCallback callback, WFSAllocator allocator, void *allocatorArg);
void WFS_Start(void);
void WFS_End(void);
s32 WFS_GetStatus(void);
u32 WFS_GetCurrentBitmap(void);
u32 WFS_GetSentFileCount(void);
void WFS_EnableSync(u16 syncBitmap);
void WFS_SetDebugMode(BOOL enabled);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WFS_H