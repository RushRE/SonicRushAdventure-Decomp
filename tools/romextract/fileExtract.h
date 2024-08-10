#pragma once

#include "global.h"

// --------------------
// FUNCTIONS
// --------------------

void ExtractArchiveHeaderless(char* path, uint8_t *fileData, uint8_t compression, bool isROMFile);

void ExtractArchive(char* path, uint8_t *fileData, uint8_t compression, bool isROMFile);
void ExtractBundle(char* path, uint8_t *fileData);