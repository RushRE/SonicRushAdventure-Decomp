#ifndef NITRO_FS_COMMAND_H
#define NITRO_FS_COMMAND_H

#include <nitro/misc.h>
#include <nitro/types.h>
#include <nitro/fs/file.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// VARIABLES
// --------------------

extern FSResult (*const(fsi_default_command[]))(FSFile *);
extern FSDirPos current_dir_pos;

// --------------------
// FUNCTIONS
// --------------------

int FSi_StrNICmp(const char *str1, const char *str2, u32 len);
BOOL FSi_SendCommand(FSFile *p_file, FSCommandType command);
FSResult FSi_TranslateCommand(FSFile *p_file, FSCommandType command);
void FSi_ReleaseCommand(FSFile *p_file, FSResult ret);
FSFile *FSi_NextCommand(FSArchive *p_arc);
void FSi_ExecuteAsyncCommand(FSFile *p_file);
BOOL FSi_ExecuteSyncCommand(FSFile *p_file);

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_COMMAND_H