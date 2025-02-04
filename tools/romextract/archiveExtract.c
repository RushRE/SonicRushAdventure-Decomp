#include "fileExtract.h"
#include "romExtract.h"
#include "compression.h"
#include "stringUtils.h"

#if defined _MSC_VER
#include <direct.h>

#define MakeDirectory(path) mkdir(path)

#pragma warning(disable : 4996) // disable "mkdir is deprecated" warning
#elif defined __GNUC__
#include <sys/types.h>
#include <sys/stat.h>

#define MakeDirectory(path) mkdir(path, 0700)

#endif

// --------------------
// STRUCTS
// --------------------

struct ArciveFile
{
    char *name;
    char *path;
    uint8_t compression;
    bool isDir;
    bool freePath;
};

struct BundleFileEntry
{
    uint32_t offset;
    uint32_t size;
};

struct BundleHeader
{
    uint32_t signature;
    uint32_t fileCount;
    struct BundleFileEntry files[1];
};

// --------------------
// FUNCTIONS
// --------------------

static const char *GetExtensionFromFile(uint8_t *fileData)
{
    uint32_t signature = (fileData[0] << 24) | (fileData[1] << 16) | (fileData[2] << 8) | (fileData[3] << 0);

    switch (signature)
    {
        case 0x4E415243: // 'NARC'
            return "narc";

        case 0x42420000: // 'BB\0\0'
            return "bb";

        case 0x42424700: // 'BBG\0'
            return "bbg";

        case 0x42414300: // 'BAC\0'
            return "bac";

        case 0x23425041: // '#BPA'
            return "bpa";

        case 0x4D504300: // 'MPC\0'
            return "mpc";

        case 0x234D4346: // '#MCF'
            return "mcf";

        case 0x42534400: // 'BSD\0'
            return "bsd";

        case 0x424D4430: // 'BMD0'
            return "nsbmd";

        case 0x42434130: // 'BCA0'
            return "nsbca";

        case 0x424D4130: // 'BMA0'
            return "nsbma";

        case 0x42544130: // 'BTA0'
            return "nsbta";

        case 0x42564130: // 'BVA0'
            return "nsbva";

        case 0x42545030: // 'BTP0'
            return "nsbtp";

        default:
            return "bin";
    }
}

static void WriteArchiveFileList(char *path, struct ArciveFile *fileList, uint32_t fileCount, uint8_t compression)
{
    size_t bufferSize = snprintf(NULL, 0, "%s.arclst", path);

    char *filePath = malloc(bufferSize + 1);
    snprintf(filePath, bufferSize + 1, "%s.arclst", path);

    FILE *file = fopen(filePath, "wb");
    if (file != NULL)
    {
        char buffer[0x100];

        char *name = GetFileName(path);

        fputc('{', file);
        fputc('\n', file);

        snprintf(buffer, sizeof(buffer), "  \"compression\": %d,\n", compression);
        fwrite(buffer, strlen(buffer), 1, file);

        snprintf(buffer, sizeof(buffer), "  \"stripNames\": %s,\n", "false");
        fwrite(buffer, strlen(buffer), 1, file);

        snprintf(buffer, sizeof(buffer), "  \"name\": \"%s\",\n", name);
        fwrite(buffer, strlen(buffer), 1, file);

        snprintf(buffer, sizeof(buffer), "  \"files\": [\n");
        fwrite(buffer, strlen(buffer), 1, file);

        for (uint32_t f = 0; f < fileCount; f++)
        {
            snprintf(buffer, sizeof(buffer), "    {\n");
            fwrite(buffer, strlen(buffer), 1, file);

            snprintf(buffer, sizeof(buffer), "      \"sourcePath\": \"%s\",\n", fileList[f].path);
            fwrite(buffer, strlen(buffer), 1, file);

            if (fileList[f].isDir)
            {
                snprintf(buffer, sizeof(buffer), "      \"outputPath\": \"%s\",\n", fileList[f].path);
                fwrite(buffer, strlen(buffer), 1, file);
            }
            else
            {
                snprintf(buffer, sizeof(buffer), "      \"outputPath\": \"%s\",\n", fileList[f].name);
                fwrite(buffer, strlen(buffer), 1, file);
            }

            snprintf(buffer, sizeof(buffer), "      \"compression\": %d,\n", fileList[f].compression);
            fwrite(buffer, strlen(buffer), 1, file);

            snprintf(buffer, sizeof(buffer), "      \"isDirectory\": %s\n", fileList[f].isDir ? "true" : "false");
            fwrite(buffer, strlen(buffer), 1, file);

            snprintf(buffer, sizeof(buffer), "    }");
            fwrite(buffer, strlen(buffer), 1, file);

            if (f + 1 < fileCount)
                fputc(',', file);

            fputc('\n', file);
        }

        snprintf(buffer, sizeof(buffer), "  ]\n");
        fwrite(buffer, strlen(buffer), 1, file);

        fputc('}', file);

        fclose(file);

        if (name != NULL)
            free(name);
    }

    if (filePath != NULL)
        free(filePath);
}

static void WriteBundleFileList(char *path, struct ArciveFile *fileList, uint32_t fileCount)
{
    size_t bufferSize = snprintf(NULL, 0, "%s.bblst", path);

    char *filePath = malloc(bufferSize + 1);
    snprintf(filePath, bufferSize + 1, "%s.bblst", path);

    FILE *file = fopen(filePath, "wb");
    if (file != NULL)
    {
        char buffer[0x100];

        char *name = GetFileName(path);

        fputc('{', file);
        fputc('\n', file);

        snprintf(buffer, sizeof(buffer), "  \"name\": \"%s\",\n", name);
        fwrite(buffer, strlen(buffer), 1, file);

        snprintf(buffer, sizeof(buffer), "  \"files\": [\n");
        fwrite(buffer, strlen(buffer), 1, file);

        for (uint32_t f = 0; f < fileCount; f++)
        {
            snprintf(buffer, sizeof(buffer), "    {\n");
            fwrite(buffer, strlen(buffer), 1, file);

            snprintf(buffer, sizeof(buffer), "      \"sourcePath\": \"%s\",\n", fileList[f].path);
            fwrite(buffer, strlen(buffer), 1, file);

            snprintf(buffer, sizeof(buffer), "      \"compression\": %d\n", fileList[f].compression);
            fwrite(buffer, strlen(buffer), 1, file);

            snprintf(buffer, sizeof(buffer), "    }");
            fwrite(buffer, strlen(buffer), 1, file);

            if (f + 1 < fileCount)
                fputc(',', file);

            fputc('\n', file);
        }

        snprintf(buffer, sizeof(buffer), "  ]\n");
        fwrite(buffer, strlen(buffer), 1, file);

        fputc('}', file);

        fclose(file);

        if (name != NULL)
            free(name);
    }

    if (filePath != NULL)
        free(filePath);
}

void ExtractArchiveHeaderless(char *path, uint8_t *archiveData, uint8_t compression, bool isROMFile)
{
    char *prefix = GetPathWithoutExtension(path);

    struct Header
    {
        uint32_t signature;
        uint16_t byteOrderMark;
        uint16_t version;
        uint32_t fileSize;
        uint16_t chunkSize;
        uint16_t chunkCount;
    };

    struct FileAllocationTableEntry
    {
        uint32_t start;
        uint32_t end;
    };

    struct FileAllocationTable
    {
        uint32_t id;
        uint32_t chunkSize;
        uint16_t fileCount;
        uint16_t reserved;
        struct FileAllocationTableEntry files[1];
    };

    struct FileNameTableEntry
    {
        uint32_t offset;
        uint16_t firstFileId;
        uint16_t utility;
    };

    struct FileNameTable
    {
        uint32_t id;
        uint32_t chunkSize;
        struct FileNameTableEntry directories[1];
    };

    struct FileImages
    {
        uint32_t id;
        uint32_t chunkSize;
    };

    struct Header *archive                     = (struct Header *)archiveData;
    struct FileAllocationTable *fileAllocTable = (struct FileAllocationTable *)(archiveData + archive->chunkSize);
    struct FileNameTable *fileNameTable        = (struct FileNameTable *)((uint8_t *)fileAllocTable + fileAllocTable->chunkSize);

    char **directoryPaths = malloc(sizeof(char *) * fileNameTable->directories[0].utility);
    char **directoryNames = malloc(sizeof(char *) * fileNameTable->directories[0].utility);

    directoryPaths[0] = prefix;
    directoryNames[0] = NULL;
    if (!isROMFile)
    {
        compression = 0xFF; // don't write compression for archives inside archives/bundles
    }

    uint32_t fileListCount      = ((fileNameTable->directories[0].utility - 1) + fileAllocTable->fileCount);
    struct ArciveFile *fileList = malloc(fileListCount * sizeof(struct ArciveFile));
    memset(fileList, 0, fileListCount * sizeof(struct ArciveFile));

    uint32_t chunkOffset = (uint32_t)((size_t)fileNameTable - (size_t)archive) + fileNameTable->chunkSize + sizeof(struct FileImages);
    uint32_t fileID      = 0;
    uint32_t listFileID  = 0;
    for (uint32_t d = 0; d < fileNameTable->directories[0].utility; d++)
    {
        char *currentDirPath = directoryPaths[d];
        char *currentDirName = directoryNames[d];

        uint8_t *dirData = (uint8_t *)fileNameTable + sizeof(struct FileNameTableEntry) + fileNameTable->directories[d].offset;

        // id 0 is end of table
        uint8_t id = *dirData++;
        while (id != 0x00)
        {
            if ((id & 0x80) == 0)
            {
                // File
                uint8_t length = (id - 0x80) & 0x7F;

                char *name = malloc(length + 1);
                memset(name, 0, length + 1);
                memcpy(name, dirData, length);
                dirData += length;

                // FAT data
                uint32_t offset = chunkOffset + fileAllocTable->files[fileID].start;
                uint32_t size   = fileAllocTable->files[fileID].end - fileAllocTable->files[fileID].start;

                // Read file contents
                uint8_t *fileData = &archiveData[offset];

                if (true)
                {
                    bool enableDecompress = true;

                    // disable compression on palettes for now
                    const char *ext = GetFileExtension(name);
                    if (ext != NULL && strcmp(ext, "nbfp") == 0)
                    {
                        enableDecompress = false;
                    }

                    size_t uncompressedSize;
                    uint8_t *uncompressedData = NULL;

                    if (enableDecompress)
                    {
                        uncompressedData = TryDecompress(fileData, size, &fileList[listFileID].compression, &uncompressedSize);
                    }

                    if (uncompressedData == NULL)
                    {
                        uncompressedData                 = fileData;
                        uncompressedSize                 = size;
                        fileList[listFileID].compression = 0xFF;

                        fileData = NULL;
                    }

                    size_t bufferSize = snprintf(NULL, 0, "%s/%s", currentDirPath, name);
                    char *filePath    = malloc(bufferSize + 1);
                    snprintf(filePath, bufferSize + 1, "%s/%s", currentDirPath, name);

                    char *localFilePath;
                    if (currentDirName == NULL)
                    {
                        bufferSize    = snprintf(NULL, 0, "%s", name);
                        localFilePath = malloc(bufferSize + 1);
                        snprintf(localFilePath, bufferSize + 1, "%s", name);
                    }
                    else
                    {
                        bufferSize    = snprintf(NULL, 0, "%s/%s", currentDirName, name);
                        localFilePath = malloc(bufferSize + 1);
                        snprintf(localFilePath, bufferSize + 1, "%s/%s", currentDirName, name);
                    }

                    const char *convertedPath = GetConvertedFileName(filePath);
                    if (convertedPath != NULL)
                    {
                        printf("Extracting Archive File => %s\n", convertedPath);
                        ExtractFile((char *)convertedPath, uncompressedData, uncompressedSize, fileList[listFileID].compression, false);

                        fileList[listFileID].name = localFilePath;
                        fileList[listFileID].path = (char *)convertedPath;

                        if (filePath != NULL)
                            free(filePath);
                    }
                    else
                    {
                        printf("Extracting Archive File => %s\n", filePath);
                        ExtractFile(filePath, uncompressedData, uncompressedSize, fileList[listFileID].compression, false);

                        fileList[listFileID].name     = localFilePath;
                        fileList[listFileID].path     = filePath;
                        fileList[listFileID].freePath = true;
                    }

                    if (fileData != NULL && uncompressedData != NULL)
                        free(uncompressedData);
                }

                if (name != NULL)
                    free(name);

                fileID++;
                listFileID++;
            }
            else
            {
                // Directory
                uint8_t length = (id - 0x80) & 0x7F;

                char *name = malloc(length + 1);
                memset(name, 0, length + 1);
                memcpy(name, dirData, length);
                dirData += length;

                uint8_t dirID = ((dirData[0] << 0) | (dirData[1] << 8)) - 0xF000;
                dirData += 2;

                size_t bufferSize     = snprintf(NULL, 0, "%s/%s", currentDirPath, name);
                directoryPaths[dirID] = malloc(bufferSize + 1);
                snprintf(directoryPaths[dirID], bufferSize + 1, "%s/%s", currentDirPath, name);

                if (currentDirName == NULL)
                {
                    bufferSize            = snprintf(NULL, 0, "%s", name);
                    directoryNames[dirID] = malloc(bufferSize + 1);
                    snprintf(directoryNames[dirID], bufferSize + 1, "%s", name);
                }
                else
                {
                    bufferSize            = snprintf(NULL, 0, "%s/%s", currentDirName, name);
                    directoryNames[dirID] = malloc(bufferSize + 1);
                    snprintf(directoryNames[dirID], bufferSize + 1, "%s/%s", currentDirName, name);
                }

                MakeDirectory(directoryPaths[dirID]);

                if (true)
                {
                    size_t bufferSize = snprintf(NULL, 0, "%s", name);

                    fileList[listFileID].path = malloc(bufferSize + 1);
                    snprintf(fileList[listFileID].path, bufferSize + 1, "%s", name);

                    fileList[listFileID].isDir    = true;
                    fileList[listFileID].freePath = true;
                }

                if (name != NULL)
                    free(name);

                listFileID++;
            }

            id = *dirData++;
        }
    }

    WriteArchiveFileList(prefix, fileList, listFileID, compression);

    if (prefix != NULL)
        free(prefix);

    if (directoryPaths != NULL)
    {
        for (uint32_t d = 1; d < fileNameTable->directories[0].utility; d++)
        {
            if (directoryPaths[d] != NULL)
                free(directoryPaths[d]);
        }
        free(directoryPaths);
    }

    if (fileList != NULL)
    {
        for (uint32_t f = 0; f < fileListCount; f++)
        {
            if (fileList[f].freePath && fileList[f].path != NULL)
                free(fileList[f].path);

            if (fileList[f].name != NULL)
                free(fileList[f].name);
        }
        free(fileList);
    }
}

void ExtractArchive(char *path, uint8_t *archiveData, uint8_t compression, bool isROMFile)
{
    char *prefix = GetPathWithoutExtension(path);

    struct Header
    {
        uint32_t signature;
        uint16_t byteOrderMark;
        uint16_t version;
        uint32_t fileSize;
        uint16_t chunkSize;
        uint16_t chunkCount;
    };

    struct FileAllocationTableEntry
    {
        uint32_t start;
        uint32_t end;
    };

    struct FileAllocationTable
    {
        uint32_t id;
        uint32_t chunkSize;
        uint16_t fileCount;
        uint16_t reserved;
        struct FileAllocationTableEntry files[1];
    };

    struct FileNameTableEntry
    {
        uint32_t offset;
        uint16_t firstFileId;
        uint16_t utility;
    };

    struct FileNameTable
    {
        uint32_t id;
        uint32_t chunkSize;
        struct FileNameTableEntry directories[1];
    };

    struct FileImages
    {
        uint32_t id;
        uint32_t chunkSize;
    };

    struct Header *archive                     = (struct Header *)archiveData;
    struct FileAllocationTable *fileAllocTable = (struct FileAllocationTable *)(archiveData + archive->chunkSize);
    struct FileNameTable *fileNameTable        = (struct FileNameTable *)((uint8_t *)fileAllocTable + fileAllocTable->chunkSize);

    char **directoryPaths = malloc(sizeof(char *) * fileNameTable->directories[0].utility);
    char **directoryNames = malloc(sizeof(char *) * fileNameTable->directories[0].utility);

    directoryPaths[0] = prefix;
    directoryNames[0] = NULL;
    if (!isROMFile)
    {
        compression = 0xFF; // don't write compression for archives inside archives/bundles
    }

    uint32_t fileListCount      = ((fileNameTable->directories[0].utility - 1) + fileAllocTable->fileCount);
    struct ArciveFile *fileList = malloc(fileListCount * sizeof(struct ArciveFile));
    memset(fileList, 0, fileListCount * sizeof(struct ArciveFile));

    uint32_t chunkOffset = (uint32_t)((size_t)fileNameTable - (size_t)archive) + fileNameTable->chunkSize + sizeof(struct FileImages);
    uint32_t fileID      = 0;
    uint32_t listFileID  = 0;
    for (uint32_t d = 0; d < fileNameTable->directories[0].utility; d++)
    {
        char *currentDirPath = directoryPaths[d];
        char *currentDirName = directoryNames[d];

        uint8_t *dirData = (uint8_t *)fileNameTable + sizeof(struct FileNameTableEntry) + fileNameTable->directories[d].offset;

        // id 0 is end of table
        uint8_t id = *dirData++;
        while (id != 0x00)
        {
            if ((id & 0x80) == 0)
            {
                // File
                uint8_t length = (id - 0x80) & 0x7F;

                char *name = malloc(length + 1);
                memset(name, 0, length + 1);
                memcpy(name, dirData, length);
                dirData += length;

                // FAT data
                uint32_t offset = chunkOffset + fileAllocTable->files[fileID].start;
                uint32_t size   = fileAllocTable->files[fileID].end - fileAllocTable->files[fileID].start;

                // Read file contents
                uint8_t *fileData = &archiveData[offset];

                if (true)
                {
                    bool enableDecompress = true;

                    // disable compression on palettes for now
                    const char *ext = GetFileExtension(name);
                    if (ext != NULL && strcmp(ext, "nbfp") == 0)
                    {
                        enableDecompress = false;
                    }

                    size_t uncompressedSize;
                    uint8_t *uncompressedData = NULL;

                    if (enableDecompress)
                    {
                        uncompressedData = TryDecompress(fileData, size, &fileList[listFileID].compression, &uncompressedSize);
                    }

                    if (uncompressedData == NULL)
                    {
                        uncompressedData                 = fileData;
                        uncompressedSize                 = size;
                        fileList[listFileID].compression = 0xFF;

                        fileData = NULL;
                    }

                    size_t bufferSize = snprintf(NULL, 0, "%s/%s", currentDirPath, name);
                    char *filePath    = malloc(bufferSize + 1);
                    snprintf(filePath, bufferSize + 1, "%s/%s", currentDirPath, name);

                    char *localFilePath;
                    if (currentDirName == NULL)
                    {
                        bufferSize    = snprintf(NULL, 0, "%s", name);
                        localFilePath = malloc(bufferSize + 1);
                        snprintf(localFilePath, bufferSize + 1, "%s", name);
                    }
                    else
                    {
                        bufferSize    = snprintf(NULL, 0, "%s/%s", currentDirName, name);
                        localFilePath = malloc(bufferSize + 1);
                        snprintf(localFilePath, bufferSize + 1, "%s/%s", currentDirName, name);
                    }

                    const char *convertedPath = GetConvertedFileName(filePath);
                    if (convertedPath != NULL)
                    {
                        printf("Extracting Archive File => %s\n", convertedPath);
                        ExtractFile((char *)convertedPath, uncompressedData, uncompressedSize, fileList[listFileID].compression, false);

                        fileList[listFileID].name = localFilePath;
                        fileList[listFileID].path = (char *)convertedPath;

                        if (filePath != NULL)
                            free(filePath);
                    }
                    else
                    {
                        printf("Extracting Archive File => %s\n", filePath);
                        ExtractFile(filePath, uncompressedData, uncompressedSize, fileList[listFileID].compression, false);

                        fileList[listFileID].name     = localFilePath;
                        fileList[listFileID].path     = filePath;
                        fileList[listFileID].freePath = true;
                    }

                    if (fileData != NULL && uncompressedData != NULL)
                        free(uncompressedData);
                }

                if (name != NULL)
                    free(name);

                fileID++;
                listFileID++;
            }
            else
            {
                // Directory
                uint8_t length = (id - 0x80) & 0x7F;

                char *name = malloc(length + 1);
                memset(name, 0, length + 1);
                memcpy(name, dirData, length);
                dirData += length;

                uint8_t dirID = ((dirData[0] << 0) | (dirData[1] << 8)) - 0xF000;
                dirData += 2;

                size_t bufferSize     = snprintf(NULL, 0, "%s/%s", currentDirPath, name);
                directoryPaths[dirID] = malloc(bufferSize + 1);
                snprintf(directoryPaths[dirID], bufferSize + 1, "%s/%s", currentDirPath, name);

                if (currentDirName == NULL)
                {
                    bufferSize            = snprintf(NULL, 0, "%s", name);
                    directoryNames[dirID] = malloc(bufferSize + 1);
                    snprintf(directoryNames[dirID], bufferSize + 1, "%s", name);
                }
                else
                {
                    bufferSize            = snprintf(NULL, 0, "%s/%s", currentDirName, name);
                    directoryNames[dirID] = malloc(bufferSize + 1);
                    snprintf(directoryNames[dirID], bufferSize + 1, "%s/%s", currentDirName, name);
                }

                MakeDirectory(directoryPaths[dirID]);

                if (true)
                {
                    size_t bufferSize = snprintf(NULL, 0, "%s", name);

                    fileList[listFileID].path = malloc(bufferSize + 1);
                    snprintf(fileList[listFileID].path, bufferSize + 1, "%s", name);

                    fileList[listFileID].isDir    = true;
                    fileList[listFileID].freePath = true;
                }

                if (name != NULL)
                    free(name);

                listFileID++;
            }

            id = *dirData++;
        }
    }

    WriteArchiveFileList(prefix, fileList, listFileID, compression);

    if (prefix != NULL)
        free(prefix);

    if (directoryPaths != NULL)
    {
        for (uint32_t d = 1; d < fileNameTable->directories[0].utility; d++)
        {
            if (directoryPaths[d] != NULL)
                free(directoryPaths[d]);
        }
        free(directoryPaths);
    }

    if (fileList != NULL)
    {
        for (uint32_t f = 0; f < fileListCount; f++)
        {
            if (fileList[f].freePath && fileList[f].path != NULL)
                free(fileList[f].path);

            if (fileList[f].name != NULL)
                free(fileList[f].name);
        }
        free(fileList);
    }
}

void ExtractBundle(char *path, uint8_t *bundleData)
{
    struct BundleHeader *bundle = (struct BundleHeader *)bundleData;

    struct ArciveFile *fileList = malloc(bundle->fileCount * sizeof(struct ArciveFile));
    memset(fileList, 0, sizeof(struct ArciveFile));

    char *prefix = GetPathWithoutExtension(path);

    for (uint32_t f = 0; f < bundle->fileCount; f++)
    {
        uint8_t *fileData = &bundleData[bundle->files[f].offset];

        size_t uncompressedSize;
        uint8_t *uncompressedData = TryDecompress(fileData, bundle->files[f].size, &fileList[f].compression, &uncompressedSize);

        if (uncompressedData == NULL)
        {
            uncompressedData        = fileData;
            uncompressedSize        = bundle->files[f].size;
            fileList[f].compression = 0xFF;

            fileData = NULL;
        }

        size_t bufferSize = snprintf(NULL, 0, "%s/File_%d.%s", prefix, f, GetExtensionFromFile(uncompressedData));

        char *filePath = malloc(bufferSize + 1);
        snprintf(filePath, bufferSize + 1, "%s/File_%d.%s", prefix, f, GetExtensionFromFile(uncompressedData));

        const char *convertedPath = GetConvertedFileName(filePath);
        if (convertedPath != NULL)
        {
            printf("Extracting Bundle File => %s\n", convertedPath);
            ExtractFile((char *)convertedPath, uncompressedData, uncompressedSize, fileList[f].compression, false);

            fileList[f].path = (char *)convertedPath;

            if (filePath != NULL)
                free(filePath);
        }
        else
        {
            printf("Extracting Bundle File => %s\n", filePath);
            ExtractFile(filePath, uncompressedData, uncompressedSize, fileList[f].compression, false);

            fileList[f].path     = filePath;
            fileList[f].freePath = true;
        }

        if (fileData != NULL && uncompressedData != NULL)
            free(uncompressedData);
    }

    WriteBundleFileList(prefix, fileList, bundle->fileCount);

    if (prefix != NULL)
        free(prefix);

    if (fileList != NULL)
    {
        for (uint32_t f = 0; f < bundle->fileCount; f++)
        {
            if (fileList[f].freePath && fileList[f].path != NULL)
                free(fileList[f].path);
        }
        free(fileList);
    }
}