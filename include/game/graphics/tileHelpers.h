#ifndef RUSH_TILEHELPERS_H
#define RUSH_TILEHELPERS_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS/MACROS
// --------------------

#define TILE_SIZE 8

#define ALIGN_UP(size, align) (((size) + ((align) - 1)) & -(align))

// convert from pixel units to tile units
#define PIXEL_TO_TILE(pixelPos) ((pixelPos) / TILE_SIZE)

// convert from tile units to pixel units
#define TILE_TO_PIXEL(tilePos) ((tilePos) * 8)

#ifdef __cplusplus
}
#endif

#endif // RUSH_TILEHELPERS_H
