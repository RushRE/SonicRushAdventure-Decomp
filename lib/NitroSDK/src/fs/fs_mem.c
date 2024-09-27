#include <nitro.h>

#include "include/util.h"

#ifdef FS_IMPLEMENT

// --------------------
// VARIABLES
// --------------------

static FSArchive fsi_arc_mem;
static BOOL fsi_mem_init;

// --------------------
// FUNCTIONS
// --------------------

static FSResult FSi_MemArchiveProc(FSFile *p_file, FSCommandType cmd)
{
#pragma unused(p_file)

    switch (cmd)
    {
        case FS_COMMAND_SEEKDIR:
        case FS_COMMAND_READDIR:
        case FS_COMMAND_FINDPATH:
        case FS_COMMAND_GETPATH:
        case FS_COMMAND_OPENFILEFAST:
            return FS_RESULT_UNSUPPORTED;

        default:
            return FS_RESULT_PROC_UNKNOWN;
    }
}

static void FSi_InitMem(void)
{
    OSIntrMode bak_cpsr = OS_DisableInterrupts();

    if (!fsi_mem_init || !FS_IsArchiveLoaded(&fsi_arc_mem))
    {
        FS_InitArchive(&fsi_arc_mem);
        FS_SetArchiveProc(&fsi_arc_mem, FSi_MemArchiveProc, (u32)FS_ARCHIVE_PROC_ALL);

        if (!FS_LoadArchive(&fsi_arc_mem, 0, 0, 0, 0, 0, NULL, NULL))
        {
            OS_Terminate();
        }

        fsi_mem_init = TRUE;
    }

    (void)OS_RestoreInterrupts(bak_cpsr);
}

BOOL FS_CreateFileFromMemory(FSFile *p_file, void *buf, u32 size)
{
    FSi_InitMem();
    return FS_OpenFileDirect(p_file, &fsi_arc_mem, (u32)buf, (u32)buf + size, 0);
}
#endif