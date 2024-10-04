#ifndef RUSH2_FILEUNKNOWN_H
#define RUSH2_FILEUNKNOWN_H

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

NOT_DECOMPILED void *ArchiveFileUnknown__LoadFile(const char *filePath, void *memory);
NOT_DECOMPILED void *ArchiveFileUnknown__LoadFileFromArchive(const char *filePath, u32 id, void *memory);
NOT_DECOMPILED void *ArchiveFileUnknown__GetFileFromMemArchive(void *archive, u32 id, void *memory);

NOT_DECOMPILED void *FileUnknown__GetAOUFile(void *archive, u16 id);
NOT_DECOMPILED size_t FileUnknown__GetAOUFileSize(void *archive, u16 id);

#endif // RUSH2_FILEUNKNOWN_H
