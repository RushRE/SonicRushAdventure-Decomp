#ifndef NITRO_FS_FILE_H
#define NITRO_FS_FILE_H

#include <nitro/fs/archive.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define FS_FILE_STATUS_BUSY      0x00000001
#define FS_FILE_STATUS_CANCEL    0x00000002
#define FS_FILE_STATUS_SYNC      0x00000004
#define FS_FILE_STATUS_ASYNC     0x00000008
#define FS_FILE_STATUS_IS_FILE   0x00000010
#define FS_FILE_STATUS_IS_DIR    0x00000020
#define FS_FILE_STATUS_OPERATING 0x00000040

#define FS_FILE_NAME_MAX 127

#define FS_DMA_NOT_USE ((u32)~0)

// --------------------
// ENUMS
// --------------------

typedef enum FSSeekFileMode
{
    FS_SEEK_SET = 0,
    FS_SEEK_CUR,
    FS_SEEK_END
} FSSeekFileMode;

// --------------------
// FORWARD DECLS
// --------------------

struct FSFile;

typedef struct
{
    struct FSArchive *arc;
    u16 own_id;
    u16 index;
    u32 pos;
} FSDirPos;

typedef struct
{
    struct FSArchive *arc;
    u32 file_id;
} FSFileID;

typedef struct
{
    union
    {
        FSFileID file_id;
        FSDirPos dir_id;
    };
    u32 is_directory;
    u32 name_len;
    char name[FS_FILE_NAME_MAX + 1];
} FSDirEntry;

typedef struct
{
    FSDirPos pos;
} FSSeekDirInfo;

typedef struct
{
    FSDirEntry *p_entry;
    BOOL skip_string;
} FSReadDirInfo;

typedef struct
{
    FSDirPos pos;
    const char *path;
    BOOL find_directory;
    union
    {
        FSFileID *file;
        FSDirPos *dir;
    } result;
} FSFindPathInfo;

typedef struct
{
    u8 *buf;
    u32 buf_len;
    u16 total_len;
    u16 dir_id;
} FSGetPathInfo;

typedef struct
{
    FSFileID id;
} FSOpenFileFastInfo;

typedef struct
{
    u32 top;
    u32 bottom;
    u32 index;
} FSOpenFileDirectInfo;

typedef struct
{
    u32 reserved;
} FSCloseFileInfo;

typedef struct
{
    void *dst;
    u32 len_org;
    u32 len;
} FSReadFileInfo;

typedef struct
{
    const void *src;
    u32 len_org;
    u32 len;
} FSWriteFileInfo;

typedef struct FSFile
{
    FSFileLink link;
    struct FSArchive *arc;
    u32 stat;
    FSCommandType command;
    FSResult error;
    OSThreadQueue queue[1];
    union
    {
        struct
        {
            u32 own_id;
            u32 top;
            u32 bottom;
            u32 pos;
        } file;

        struct
        {
            FSDirPos pos;
            u32 parent;
        } dir;
    } prop;
    union
    {
        FSReadFileInfo readfile;
        FSWriteFileInfo writefile;
        FSSeekDirInfo seekdir;
        FSReadDirInfo readdir;
        FSFindPathInfo findpath;
        FSGetPathInfo getpath;
        FSOpenFileFastInfo openfilefast;
        FSOpenFileDirectInfo openfiledirect;
        FSCloseFileInfo closefile;
    } arg;
} FSFile;

// --------------------
// FUNCTIONS
// --------------------

void FS_Init(u32 default_dma_no);
BOOL FS_IsAvailable(void);
void FS_InitFile(FSFile *p_file);
int FSi_ReadFileCore(FSFile *p_file, void *dst, s32 len, BOOL async);
BOOL FS_ConvertPathToFileID(FSFileID *p_file_id, const char *path);
BOOL FS_OpenFileDirect(FSFile *p_file, FSArchive *p_arc, u32 image_top, u32 image_bottom, u32 file_index);
BOOL FS_OpenFileFast(FSFile *p_file, FSFileID file_id);
BOOL FS_OpenFile(FSFile *p_file, const char *path);
BOOL FS_CloseFile(FSFile *p_file);
BOOL FS_WaitAsync(FSFile *p_file);
int FS_ReadFileAsync(FSFile *p_file, void *dst, s32 len);
int FS_ReadFile(FSFile *p_file, void *dst, s32 len);
BOOL FS_SeekFile(FSFile *p_file, s32 offset, FSSeekFileMode origin);
BOOL FS_ChangeDir(const char *path);
u32 FS_SetDefaultDMA(u32 dma_no);

u32 FS_TryLoadTable(void *p_mem, u32 maxsize);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE u32 const FS_GetFileImageTop(volatile const FSFile *p_file)
{
    return p_file->prop.file.top;
}

SDK_INLINE u32 const FS_GetLength(volatile const FSFile *p_file)
{
    return p_file->prop.file.bottom - p_file->prop.file.top;
}

SDK_INLINE BOOL FS_IsCanceling(volatile const FSFile *p_file)
{
    return (p_file->stat & FS_FILE_STATUS_CANCEL) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsFileSyncMode(volatile const FSFile *p_file)
{
    return (p_file->stat & FS_FILE_STATUS_SYNC) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsBusy(volatile const FSFile *p_file)
{
    return p_file->stat & FS_FILE_STATUS_BUSY ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsSucceeded(volatile const FSFile *p_file)
{
    return (p_file->error == FS_RESULT_SUCCESS) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsDir(volatile const FSFile *p_file)
{
    return (p_file->stat & FS_FILE_STATUS_IS_DIR) ? TRUE : FALSE;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_FILE_H
