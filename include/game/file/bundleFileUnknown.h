#ifndef RUSH2_BUNDLEFILEUNKNOWN_H
#define RUSH2_BUNDLEFILEUNKNOWN_H

#include <global.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>

// --------------------
// CONSTANTS
// --------------------

#define BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD ((void *)(size_t)0)
#define BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL ((void *)(size_t)-1)

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *BundleFileUnknown__LoadFile(const char *path, void *memory);
NOT_DECOMPILED void *BundleFileUnknown__LoadFileFromBundle(const char *path, u32 id, void *memory);

#endif // RUSH2_BUNDLEFILEUNKNOWN_H
