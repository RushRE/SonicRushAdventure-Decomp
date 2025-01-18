#ifndef RUSH_BUNDLEFILEUNKNOWN_H
#define RUSH_BUNDLEFILEUNKNOWN_H

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

void *BundleFileUnknown__LoadFile(const char *path, void *memory);
void *BundleFileUnknown__LoadFileFromBundle(const char *bundlePath, u16 id, void *memory);

#endif // RUSH_BUNDLEFILEUNKNOWN_H
