#ifndef ARCHIVEPACK_H
#define ARCHIVEPACK_H

#include "global.h"

#ifdef __cplusplus
extern "C" {
#endif

char* GetFileExtension(char* path);
char* GetFileDirectory(char* path);
unsigned char* ReadWholeFile(char* path, unsigned int* size);

void PackBundle(char *inputPath, char *inputDir, char *archiveDir);
void PackArchive(char *inputPath, char *inputDir, char *archiveDir);
void PackFile(char* inputPath, char* inputDir, char* archiveDir);

#ifdef __cplusplus
}
#endif

#endif // ARCHIVEPACK_H
