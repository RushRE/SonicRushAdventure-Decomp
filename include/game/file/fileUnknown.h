#ifndef RUSH_FILEUNKNOWN_H
#define RUSH_FILEUNKNOWN_H

#include <global.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>

// --------------------
// CONSTANTS
// --------------------

#define FILEUNKNOWN_AUTO_ALLOC_HEAD ((void *)(size_t)0)
#define FILEUNKNOWN_AUTO_ALLOC_TAIL ((void *)(size_t)-1)

// --------------------
// FUNCTIONS
// --------------------

void *ArchiveFileUnknown__LoadFile(const char *path, void *memory);
void *ArchiveFileUnknown__LoadFileFromArchive(const char *path, u16 id, void *memory);
void *ArchiveFileUnknown__GetFileFromMemArchive(void *archive, u16 id, void *memory);

void *FileUnknown__GetAOUFile(void *archive, u16 id);
size_t FileUnknown__GetAOUFileSize(void *archive, u16 id);

#endif // RUSH_FILEUNKNOWN_H
