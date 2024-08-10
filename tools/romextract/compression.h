#pragma once

#include "global.h"

// --------------------
// FUNCTIONS
// --------------------

uint8_t* TryDecompress(uint8_t* fileData, size_t fileSize, uint8_t* compression, size_t *uncompressedSize);

uint8_t* ReadLZ77(uint8_t* compressedData, size_t uncompressedSize);
uint8_t* ReadHuff(uint8_t* compressedData, uint8_t compression, size_t compressedSize, size_t uncompressedSize);
uint8_t* ReadRLE(uint8_t* compressedData, size_t uncompressedSize);