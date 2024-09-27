#ifndef NITRO_FS_FILE_H
#define NITRO_FS_FILE_H

#include <nitro/fs/archive.h>

#ifdef __cplusplus
extern "C"
{
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
void FS_End(void);

u32 FS_GetDefaultDMA(void);
u32 FS_SetDefaultDMA(u32 dma_no);
u32 FS_TryLoadTable(void *p_mem, u32 size);

void FS_InitFile(FSFile *p_file);
BOOL FS_OpenFile(FSFile *p_file, const char *path);
BOOL FS_OpenFileFast(FSFile *p_file, FSFileID file_id);
BOOL FS_ConvertPathToFileID(FSFileID *p_file_id, const char *path);
BOOL FS_CloseFile(FSFile *p_file);
BOOL FS_GetPathName(FSFile *p_file, char *buf, u32 len);
s32 FS_GetPathLength(FSFile *p_file);

s32 FS_ReadFile(FSFile *p_file, void *dst, s32 len);
s32 FS_ReadFileAsync(FSFile *p_file, void *dst, s32 len);
s32 FS_WriteFile(FSFile *p_file, const void *src, s32 len);
s32 FS_WriteFileAsync(FSFile *p_file, const void *src, s32 len);
BOOL FS_WaitAsync(FSFile *p_file);
void FS_CancelFile(FSFile *p_file);
BOOL FS_SeekFile(FSFile *p_file, s32 offset, FSSeekFileMode origin);

BOOL FS_ChangeDir(const char *path);
BOOL FS_FindDir(FSFile *p_dir, const char *path);
BOOL FS_ReadDir(FSFile *p_dir, FSDirEntry *p_entry);
BOOL FS_TellDir(const FSFile *p_dir, FSDirPos *p_pos);
BOOL FS_SeekDir(FSFile *p_dir, const FSDirPos *p_pos);
BOOL FS_RewindDir(FSFile *p_dir);
BOOL FS_OpenFileDirect(FSFile *p_file, FSArchive *p_arc, u32 image_top, u32 image_bottom, u32 file_index);

BOOL FS_CreateFileFromRom(FSFile *p_file, u32 offset, u32 size);
BOOL FS_CreateFileFromMemory(FSFile *p_file, void *buf, u32 size);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE u32 FS_GetTableSize(void)
{
    return FS_TryLoadTable(NULL, 0);
}

SDK_INLINE BOOL FS_LoadTable(void *p_mem, u32 size)
{
    return (FS_TryLoadTable(p_mem, size) <= size) ? TRUE : FALSE;
}

SDK_INLINE void *FS_UnloadTable(void)
{
    FSArchive *const p_arc = FS_FindArchive("rom", 3);
    return FS_UnloadArchiveTables(p_arc);
}

SDK_INLINE BOOL FS_IsBusy(volatile const FSFile *p_file)
{
    return p_file->stat & FS_FILE_STATUS_BUSY ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsCanceling(volatile const FSFile *p_file)
{
    return (p_file->stat & FS_FILE_STATUS_CANCEL) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsSucceeded(volatile const FSFile *p_file)
{
    return (p_file->error == FS_RESULT_SUCCESS) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsFile(volatile const FSFile *p_file)
{
    return (p_file->stat & FS_FILE_STATUS_IS_FILE) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsDir(volatile const FSFile *p_file)
{
    return (p_file->stat & FS_FILE_STATUS_IS_DIR) ? TRUE : FALSE;
}

SDK_INLINE BOOL FS_IsFileSyncMode(const volatile FSFile *p)
{
    return (p->stat & FS_FILE_STATUS_SYNC) ? TRUE : FALSE;
}

SDK_INLINE FSResult FS_GetResultCode(volatile const FSFile *p_file)
{
    return p_file->error;
}

SDK_INLINE u32 FS_GetLength(const FSFile *p_file)
{
    return p_file->prop.file.bottom - p_file->prop.file.top;
}

SDK_INLINE u32 FS_GetPosition(const FSFile *p_file)
{
    return p_file->prop.file.pos - p_file->prop.file.top;
}

SDK_INLINE BOOL FS_SeekFileToBegin(FSFile *p_file)
{
    return FS_SeekFile(p_file, 0, FS_SEEK_SET);
}

SDK_INLINE BOOL FS_SeekFileToEnd(FSFile *p_file)
{
    return FS_SeekFile(p_file, 0, FS_SEEK_END);
}

SDK_INLINE FSArchive *FS_GetAttachedArchive(const FSFile *p_file)
{
    return p_file->arc;
}

SDK_INLINE u32 const FS_GetFileImageTop(volatile const FSFile *p_file)
{
    return p_file->prop.file.top;
}

SDK_INLINE u32 FS_GetFileImageBottom(const FSFile *p_file)
{
    return p_file->prop.file.bottom;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_FILE_H
