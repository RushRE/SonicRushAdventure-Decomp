#include <nitro/mi.h>
#include <nitro/os.h>
#include <nitro/pxi.h>
#include <nitro/fs.h>

#include "include/rom.h"
#include "include/util.h"
#include "include/command.h"

// --------------------
// VARIABLES
// --------------------

static BOOL is_init = FALSE;

// --------------------
// FUNCTIONS
// --------------------

void FS_Init(u32 default_dma_no)
{
#ifdef FS_IMPLEMENT
    if (!is_init)
    {
        is_init = TRUE;
        FSi_InitRom(default_dma_no);
    }
#else
#pragma unused(default_dma_no)
    CARD_Init();
#endif
}

BOOL FS_IsAvailable(void)
{
    return is_init;
}

void FS_End(void)
{
    OSIntrMode bak_psr = OS_DisableInterrupts();

    if (is_init)
    {
#ifdef FS_IMPLEMENT
        FSi_EndArchive();
        OS_ReleaseLockID((u16)fsi_card_lock_id);
#endif
        is_init = FALSE;
    }

    (void)OS_RestoreInterrupts(bak_psr);
}

#ifdef FS_IMPLEMENT
void FS_InitFile(FSFile *p_file)
{
    p_file->link.next = p_file->link.prev = NULL;
    OS_InitThreadQueue(p_file->queue);
    p_file->arc     = NULL;
    p_file->command = FS_COMMAND_INVALID;
    p_file->stat    = 0;
}

static BOOL FSi_FindPath(FSFile *p_dir, const char *path, FSFileID *p_file_id, FSDirPos *p_dir_pos)
{
    FSDirPos pos;

    if (FSi_IsSlash(MI_ReadByte(path)))
    {

        pos.arc    = current_dir_pos.arc;
        pos.own_id = 0;
        pos.pos    = 0;
        pos.index  = 0;
        ++path;
    }
    else
    {
        int i;

        pos = current_dir_pos;
        for (i = 0; i <= FS_ARCHIVE_NAME_LEN_MAX; ++i)
        {
            u32 c = MI_ReadByte(path + i);
            if (!c || FSi_IsSlash(c))
            {
                break;
            }
            else if (c == ':')
            {
                FSArchive *const p_arc = FS_FindArchive(path, i);
                if (!p_arc)
                {
                    return FALSE;
                }
                else if (!FS_IsArchiveLoaded(p_arc))
                {
                    return FALSE;
                }

                pos.arc    = p_arc;
                pos.pos    = 0;
                pos.index  = 0;
                pos.own_id = 0;
                path += i + 1;

                if (FSi_IsSlash(MI_ReadByte(path)))
                    ++path;
                break;
            }
        }
    }

    p_dir->arc               = pos.arc;
    p_dir->arg.findpath.path = path;
    p_dir->arg.findpath.pos  = pos;

    if (p_dir_pos)
    {
        p_dir->arg.findpath.find_directory = TRUE;
        p_dir->arg.findpath.result.dir     = p_dir_pos;
    }
    else
    {
        p_dir->arg.findpath.find_directory = FALSE;
        p_dir->arg.findpath.result.file    = p_file_id;
    }

    return FSi_SendCommand(p_dir, FS_COMMAND_FINDPATH);
}

static s32 FSi_ReadFileCore(FSFile *p_file, void *dst, s32 len, BOOL async)
{
    const s32 pos  = (s32)p_file->prop.file.pos;
    const s32 rest = (s32)p_file->prop.file.bottom - pos;
    const u32 org  = (u32)len;

    if (len > rest)
        len = rest;
    if (len < 0)
        len = 0;

    p_file->arg.readfile.dst     = dst;
    p_file->arg.readfile.len_org = org;
    p_file->arg.readfile.len     = (u32)(len);

    if (!async)
        p_file->stat |= FS_FILE_STATUS_SYNC;

    (void)FSi_SendCommand(p_file, FS_COMMAND_READFILE);

    if (!async)
    {
        if (FS_WaitAsync(p_file))
            len = (s32)p_file->prop.file.pos - pos;
        else
            len = -1;
    }

    return len;
}

static s32 FSi_WriteFileCore(FSFile *p_file, const void *src, s32 len, BOOL async)
{
    const s32 pos  = (s32)p_file->prop.file.pos;
    const s32 rest = (s32)p_file->prop.file.bottom - pos;
    const u32 org  = (u32)len;

    if (len > rest)
        len = rest;
    if (len < 0)
        len = 0;

    p_file->arg.writefile.src     = src;
    p_file->arg.writefile.len_org = org;
    p_file->arg.writefile.len     = (u32)(len);

    if (!async)
        p_file->stat |= FS_FILE_STATUS_SYNC;

    (void)FSi_SendCommand(p_file, FS_COMMAND_WRITEFILE);

    if (!async)
    {
        if (FS_WaitAsync(p_file))
            len = (s32)p_file->prop.file.pos - pos;
        else
            len = -1;
    }

    return len;
}

BOOL FS_ConvertPathToFileID(FSFileID *p_file_id, const char *path)
{
    FSFile dir;
    FS_InitFile(&dir);

    if (!FSi_FindPath(&dir, path, p_file_id, NULL))
        return FALSE;

    return TRUE;
}

BOOL FS_OpenFileDirect(FSFile *p_file, FSArchive *p_arc, u32 image_top, u32 image_bottom, u32 file_index)
{
    p_file->arc                       = p_arc;
    p_file->arg.openfiledirect.index  = file_index;
    p_file->arg.openfiledirect.top    = image_top;
    p_file->arg.openfiledirect.bottom = image_bottom;

    if (!FSi_SendCommand(p_file, FS_COMMAND_OPENFILEDIRECT))
        return FALSE;

    p_file->stat |= FS_FILE_STATUS_IS_FILE;
    p_file->stat &= ~FS_FILE_STATUS_IS_DIR;

    return TRUE;
}

BOOL FS_OpenFileFast(FSFile *p_file, FSFileID file_id)
{
    if (!file_id.arc)
        return FALSE;

    p_file->arc                 = file_id.arc;
    p_file->arg.openfilefast.id = file_id;

    if (!FSi_SendCommand(p_file, FS_COMMAND_OPENFILEFAST))
        return FALSE;

    p_file->stat |= FS_FILE_STATUS_IS_FILE;
    p_file->stat &= ~FS_FILE_STATUS_IS_DIR;

    return TRUE;
}

BOOL FS_OpenFile(FSFile *p_file, const char *path)
{
    FSFileID id;
    return (FS_ConvertPathToFileID(&id, path) && FS_OpenFileFast(p_file, id));
}

BOOL FS_CloseFile(FSFile *p_file)
{
    if (!FSi_SendCommand(p_file, FS_COMMAND_CLOSEFILE))
        return FALSE;

    p_file->arc     = NULL;
    p_file->command = FS_COMMAND_INVALID;
    p_file->stat &= ~(FS_FILE_STATUS_IS_FILE | FS_FILE_STATUS_IS_DIR);

    return TRUE;
}

BOOL FS_GetPathName(FSFile *p_file, char *buf, u32 len)
{
    if (p_file->command != FS_COMMAND_GETPATH)
    {
        p_file->arg.getpath.total_len = 0;
        p_file->arg.getpath.dir_id    = 0;
    }

    p_file->arg.getpath.buf     = (u8 *)buf;
    p_file->arg.getpath.buf_len = len;

    return FSi_SendCommand(p_file, FS_COMMAND_GETPATH);
}

s32 FS_GetPathLength(FSFile *p_file)
{
    return FS_GetPathName(p_file, NULL, 0) ? p_file->arg.getpath.total_len : -1;
}

BOOL FS_WaitAsync(FSFile *p_file)
{
    BOOL is_owner      = FALSE;
    OSIntrMode bak_psr = OS_DisableInterrupts();

    if (FS_IsBusy(p_file))
    {
        is_owner = !(p_file->stat & (FS_FILE_STATUS_SYNC | FS_FILE_STATUS_OPERATING));
        if (is_owner)
        {
            p_file->stat |= FS_FILE_STATUS_SYNC;
            do
            {
                OS_SleepThread(p_file->queue);
            } while (!(p_file->stat & FS_FILE_STATUS_OPERATING));
        }
        else
        {
            do
            {
                OS_SleepThread(p_file->queue);
            } while (FS_IsBusy(p_file));
        }
    }
    (void)OS_RestoreInterrupts(bak_psr);

    if (is_owner)
    {
        return FSi_ExecuteSyncCommand(p_file);
    }

    return FS_IsSucceeded(p_file);
}

void FS_CancelFile(FSFile *p_file)
{
    OSIntrMode bak_psr = OS_DisableInterrupts();

    if (FS_IsBusy(p_file))
    {
        p_file->stat |= FS_FILE_STATUS_CANCEL;
        p_file->arc->flag |= FS_ARCHIVE_FLAG_CANCELING;
    }

    (void)OS_RestoreInterrupts(bak_psr);
}

s32 FS_ReadFileAsync(FSFile *p_file, void *dst, s32 len)
{
    return FSi_ReadFileCore(p_file, dst, len, TRUE);
}

s32 FS_ReadFile(FSFile *p_file, void *dst, s32 len)
{
    return FSi_ReadFileCore(p_file, dst, len, FALSE);
}

s32 FS_WriteFileAsync(FSFile *p_file, const void *src, s32 len)
{
    return FSi_WriteFileCore(p_file, src, len, TRUE);
}

s32 FS_WriteFile(FSFile *p_file, const void *src, s32 len)
{
    return FSi_WriteFileCore(p_file, src, len, FALSE);
}

BOOL FS_SeekFile(FSFile *p_file, s32 offset, FSSeekFileMode origin)
{
    switch (origin)
    {
        case FS_SEEK_SET:
            offset += p_file->prop.file.top;
            break;

        case FS_SEEK_CUR:
            offset += p_file->prop.file.pos;
            break;

        case FS_SEEK_END:
            offset += p_file->prop.file.bottom;
            break;

        default:
            return FALSE;
    }

    if (offset < (s32)p_file->prop.file.top)
        offset = (s32)p_file->prop.file.top;

    if (offset > (s32)p_file->prop.file.bottom)
        offset = (s32)p_file->prop.file.bottom;

    p_file->prop.file.pos = (u32)offset;

    return TRUE;
}

BOOL FS_SeekDir(FSFile *p_dir, const FSDirPos *p_pos)
{
    p_dir->arc             = p_pos->arc;
    p_dir->arg.seekdir.pos = *p_pos;

    if (!FSi_SendCommand(p_dir, FS_COMMAND_SEEKDIR))
        return FALSE;

    p_dir->stat |= FS_FILE_STATUS_IS_DIR;
    return TRUE;
}

BOOL FS_ReadDir(FSFile *p_dir, FSDirEntry *p_entry)
{
    p_dir->arg.readdir.p_entry     = p_entry;
    p_dir->arg.readdir.skip_string = FALSE;

    return FSi_SendCommand(p_dir, FS_COMMAND_READDIR);
}

BOOL FS_FindDir(FSFile *p_dir, const char *path)
{
    FSDirPos pos;

    if (!FSi_FindPath(p_dir, path, NULL, &pos))
        return FALSE;

    return FS_SeekDir(p_dir, &pos);
}

BOOL FS_ChangeDir(const char *path)
{
    FSDirPos pos;
    FSFile dir;

    FS_InitFile(&dir);

    if (!FSi_FindPath(&dir, path, NULL, &pos))
        return FALSE;

    current_dir_pos = pos;
    return TRUE;
}

BOOL FS_TellDir(const FSFile *p_dir, FSDirPos *p_pos)
{
    *p_pos = p_dir->prop.dir.pos;
    return TRUE;
}

BOOL FS_RewindDir(FSFile *p_dir)
{
    FSDirPos pos;

    pos.arc    = p_dir->arc;
    pos.own_id = p_dir->prop.dir.pos.own_id;
    pos.pos    = 0;
    pos.index  = 0;

    return FS_SeekDir(p_dir, &pos);
}
#endif
