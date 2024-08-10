#pragma once

#include "global.h"

// --------------------
// CONSTANTS
// --------------------

// resources/etc
// change this if you want a different extract directory!
#define ROM_FILE_ROOT_DIR "resources"

// --------------------
// FUNCTIONS
// --------------------

void ExtractROM(const char* romPath, const char* fileTablePath);
void ExtractFile(char* path, uint8_t* fileData, size_t size, uint8_t compression, bool isROMFile);

void ReadFileNameConversionTable(const char* path);
const char* GetConvertedFileName(char* filePath);
void ReleaseFileNameConversionTable(void);