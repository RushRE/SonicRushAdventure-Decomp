#include "romExtract.h"
#include "compression.h"
#include "fileExtract.h"
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

typedef struct ROMHeader_
{
    uint8_t gameTitle[12];
    uint8_t gameCode[4];
    uint8_t makerCode[2];
    uint8_t unitCode;
    uint8_t encryptionSeed;
    uint8_t size;
    uint8_t reserved[7];
    uint8_t reserved2;
    uint8_t ROMregion;
    uint8_t ROMversion;
    uint8_t internalFlags;
    uint32_t ARM9romOffset;
    uint32_t ARM9entryAddress;
    uint32_t ARM9ramAddress;
    uint32_t ARM9size;
    uint32_t ARM7romOffset;
    uint32_t ARM7entryAddress;
    uint32_t ARM7ramAddress;
    uint32_t ARM7size;
    uint32_t fileNameTableOffset;
    uint32_t fileNameTableSize;
    uint32_t FAToffset;
    uint32_t FATsize;
    uint32_t ARM9overlayOffset;
    uint32_t ARM9overlaySize;
    uint32_t ARM7overlayOffset;
    uint32_t ARM7overlaySize;
    uint32_t flagsRead;
    uint32_t flagsInit;
    uint32_t bannerOffset;
    uint16_t secureCRC16;
    uint16_t ROMtimeout;
    uint32_t ARM9autoload;
    uint32_t ARM7autoload;
    uint64_t secureDisable;
    uint32_t ROMsize;
    uint32_t headerSize;
    uint32_t reserved3;
    uint8_t reserved4[8];
    uint16_t NANDEndRomArea;
    uint16_t NANDStartRWArea;
    uint8_t reserved5[24];
    uint8_t reserved6[16];
    uint8_t logo[156];
    uint16_t logoCRC16;
    uint16_t headerCRC16;
    uint32_t debug_romOffset;
    uint32_t debug_size;
    uint32_t debug_ramAddress;
    uint32_t reserved7;
} ROMHeader;

typedef struct ROMFAT_
{
    uint32_t offset; // start offset
    uint32_t size;   // end offset - start offset
} ROMFAT;

typedef struct ROMDirectory_
{
    char *name;
    uint16_t id;

    uint32_t tableOffset;
    uint16_t idFirstFile;
    uint16_t idParentFolder;
} ROMDirectory;

// --------------------
// VARIABLES
// --------------------

static ROMHeader romHeader;

// --------------------
// FUNCTIONS
// --------------------

#if defined _MSC_VER
static void fatal_error(const char *message, ...)
#elif defined __GNUC__
static void noreturn __attribute__((format(printf, 1, 2))) fatal_error(const char *message, ...)
#endif
{
    va_list va_args;
    va_start(va_args, message);
    fputs("Error: ", stderr);
    vfprintf(stderr, message, va_args);
    fputc('\n', stderr);
    va_end(va_args);
    exit(EXIT_FAILURE);
}

void ExtractFile(char *path, uint8_t *fileData, size_t size, uint8_t compression, bool isROMFile)
{
    uint32_t signature = (fileData[0] << 24) | (fileData[1] << 16) | (fileData[2] << 8) | (fileData[3] << 0);

    bool noArchiveHeader = strcmp(path, ROM_FILE_ROOT_DIR "/dwc/utility.bin") == 0;

    if (noArchiveHeader)
        signature = 0x4E415243; // headerless archive

    switch (signature)
    {
        case 0x4E415243: // 'NARC'
        {
            char *dir = GetPathWithoutExtension(path);

            (void)MakeDirectory(dir);

            if (noArchiveHeader)
            {
                // TODO: properly extract archive
                // ExtractArchiveHeaderless(path, fileData, compression, isROMFile);

                FILE *file = fopen(path, "wb");
                if (file == NULL)
                    return;

                fwrite(fileData, size, 1, file);

                fclose(file);
            }
            else
            {
                ExtractArchive(path, fileData, compression, isROMFile);
            }

            if (dir != NULL)
                free(dir);
        }
        break;

        case 0x42420000: // 'BB\0\0'
        {
            char *dir = GetPathWithoutExtension(path);

            (void)MakeDirectory(dir);
            ExtractBundle(path, fileData);

            if (dir != NULL)
                free(dir);
        }
        break;

        default: {
            char *pathBuffer;
            FILE *file;

            if (isROMFile && compression != 0xFF)
            {
                char *ext = GetFileExtension(path);

                size_t bufferSize = snprintf(NULL, 0, "%s", path) + 8; // extra space for extension later
                pathBuffer        = (char *)malloc(bufferSize + 1);
                snprintf(pathBuffer, bufferSize + 1, "%s", path);
                pathBuffer[strlen(path) - strlen(ext) - 1] = 0; // trim extension

                char *suffix = &pathBuffer[strlen(path) - strlen(ext) - 5];
                if (strcmp(suffix, "_lz7") == 0)
                {
                    pathBuffer[strlen(path) - strlen(ext) - 5] = 0; // trim "_lz7"
                }

                char *packFilePath;
                bufferSize   = snprintf(NULL, 0, "%s.pckf", pathBuffer);
                packFilePath = (char *)malloc(bufferSize + 1);
                snprintf(packFilePath, bufferSize + 1, "%s.pckf", pathBuffer);

                file = fopen(packFilePath, "wb");
                if (file != NULL)
                {
                    char buffer[0x100];

                    fputc('{', file);
                    fputc('\n', file);

                    snprintf(buffer, sizeof(buffer), "  \"sourcePath\": \"%s.%s\",\n", pathBuffer, ext);
                    fwrite(buffer, strlen(buffer), 1, file);

                    snprintf(buffer, sizeof(buffer), "  \"outputPath\": \"%s\",\n", path);
                    fwrite(buffer, strlen(buffer), 1, file);

                    snprintf(buffer, sizeof(buffer), "  \"compression\": %d\n", compression);
                    fwrite(buffer, strlen(buffer), 1, file);

                    fputc('}', file);

                    fclose(file);
                }

                // add extension
                strcat(pathBuffer, ".");
                strcat(pathBuffer, ext);

                free(packFilePath);
            }
            else
            {
                pathBuffer = path;
            }

            file = fopen(pathBuffer, "wb");
            if (file == NULL)
                return;

            fwrite(fileData, size, 1, file);

            fclose(file);

            if (pathBuffer != NULL && pathBuffer != path)
                free(pathBuffer);
        }
        break;
    }
}

static void ExtractROMFile(char *path, FILE *romFile, uint32_t offset, uint32_t size)
{
    // allocate buffer
    uint8_t *fileData = malloc(size);
    if (fileData == NULL)
        return;

    // read from rom
    memset(fileData, 0, size);
    {
        uint32_t romAddr = ftell(romFile);
        fseek(romFile, offset, SEEK_SET);
        fread(fileData, size, 1, romFile);
        fseek(romFile, romAddr, SEEK_SET);
    }

    uint8_t compression;
    size_t uncompressedSize;
    uint8_t *uncompressedData = TryDecompress(fileData, size, &compression, &uncompressedSize);

    if (uncompressedData == NULL)
    {
        uncompressedData = fileData;
        uncompressedSize = size;

        fileData = NULL;
    }

    ExtractFile(path, uncompressedData, uncompressedSize, compression, true);

    if (uncompressedData != NULL)
        free(uncompressedData);

    // finish & cleanup
    if (fileData != NULL)
        free(fileData);
}

ROMFAT *ReadFileAddressTable(FILE *romFile, uint32_t fatOffset, uint32_t fatSize)
{
    uint32_t count = fatSize / 0x08;

    if (count == 0)
        return NULL;

    ROMFAT *fileAddressTable = malloc(count * sizeof(ROMFAT));

    fseek(romFile, fatOffset, SEEK_SET);
    for (uint32_t i = 0; i < count; i++)
    {
        ROMFAT *file = &fileAddressTable[i];

        if (fread(file, 1, sizeof(*file), romFile) != sizeof(ROMFAT))
        {
            fatal_error("error reading the File Address");
        }

        file->size -= file->offset;
    }

    return fileAddressTable;
}

void ReadFileNameTable(FILE *romFile, uint32_t fntOffset, ROMFAT *fat)
{
    uint16_t numDirs;

    fseek(romFile, fntOffset, SEEK_SET);

    fseek(romFile, 6, SEEK_CUR);                  // skip 6 bytes
    fread(&numDirs, 1, sizeof(numDirs), romFile); // get the total number of directories
    fseek(romFile, fntOffset, SEEK_SET);

    ROMDirectory *directories = malloc(numDirs * sizeof(ROMDirectory));
    memset(directories, 0, numDirs * sizeof(ROMDirectory));
    directories[0].name = ROM_FILE_ROOT_DIR;

    for (uint32_t i = 0; i < numDirs; i++)
    {
#if _DEBUG
        printf("loading directory => (%d) %s\n", i, directories[i].name);
#endif

        fread(&directories[i].tableOffset, 1, sizeof(directories[i].tableOffset), romFile);
        fread(&directories[i].idFirstFile, 1, sizeof(directories[i].idFirstFile), romFile);
        fread(&directories[i].idParentFolder, 1, sizeof(directories[i].idParentFolder), romFile);

        long currOffset = ftell(romFile);
        fseek(romFile, fntOffset + directories[i].tableOffset, SEEK_SET);

        uint8_t id;
        fread(&id, 1, sizeof(id), romFile);
        uint16_t idFile = directories[i].idFirstFile;

        while (id != 0x0)
        {
            if (id < 0x80) // File
            {
                char name[0x80] = { 0 };

                int lengthName = id;
                int nameRemain = 0;
                if (lengthName >= 0x80)
                {
                    nameRemain = lengthName - 0x0F;
                    lengthName = 0x7F;
                }

                fread(name, 1, lengthName, romFile);
                name[lengthName] = 0;

                if (nameRemain > 0)
                    fseek(romFile, nameRemain, SEEK_CUR);

                uint16_t fileID = idFile;
                idFile++;

                // FAT part
                uint32_t offset = fat[fileID].offset;
                uint32_t size   = fat[fileID].size;

                size_t bufferSize = snprintf(NULL, 0, "%s/%s", directories[i].name, name);

                char *path = malloc(bufferSize + 1);
                snprintf(path, bufferSize + 1, "%s/%s", directories[i].name, name);

#if _DEBUG
                printf("loading file @ %d => %s\n", fileID, path);
#endif

                const char *convertedPath = GetConvertedFileName(path);
                if (convertedPath != NULL)
                {
                    printf("Extracting File @ %d => %s\n", fileID, convertedPath);

                    ExtractROMFile((char *)convertedPath, romFile, offset, size);
                }
                else
                {
                    printf("Extracting File @ %d => %s\n", fileID, path);

                    ExtractROMFile(path, romFile, offset, size);
                }

                if (path != NULL)
                    free(path);
            }

            if (id > 0x80) // Directory
            {
                char name[0x80] = { 0 };
                uint16_t directoryID;

                int lengthName = id - 0x80;
                int nameRemain = 0;
                if (lengthName >= 0x80)
                {
                    nameRemain = lengthName - 0x7F;
                    lengthName = 0x7F;
                }

                fread(name, 1, lengthName, romFile);
                name[lengthName] = 0;

                if (nameRemain > 0)
                    fseek(romFile, nameRemain, SEEK_CUR);

                fread(&directoryID, 1, sizeof(directoryID), romFile);
                directoryID &= 0xFFF;

                size_t bufferSize             = snprintf(NULL, 0, "%s/%s", directories[i].name, name);
                directories[directoryID].name = malloc(bufferSize + 1);
                snprintf(directories[directoryID].name, bufferSize + 1, "%s/%s", directories[i].name, name);

                // try to create the directory if it doesn't already exist!
                MakeDirectory(directories[directoryID].name);

#if _DEBUG
                printf("loading directory info for => (%d) %s\n", directoryID, name);
#endif
            }

            fread(&id, 1, sizeof(id), romFile);
        }

        fseek(romFile, currOffset, SEEK_SET);
    }

    if (directories != NULL)
    {
        // first dir has a non-allocated name!
        for (uint32_t i = 1; i < numDirs; i++)
        {
            if (directories[i].name != NULL)
                free(directories[i].name);
        }

        free(directories);
    }
}

void ExtractROM(const char *romPath, const char *fileTablePath)
{
    FILE *romFile = fopen(romPath, "rb");
    if (romFile == NULL)
    {
        fatal_error("unable to open rom '%s'", romPath);
    }

    if (fread(&romHeader, 1, sizeof(romHeader), romFile) != sizeof(romHeader))
    {
        fatal_error("error reading the ROM header");
    }

    ReadFileNameConversionTable(fileTablePath);

    printf("Extracting rom '%s'...\n", romPath);

    ROMFAT *fats = ReadFileAddressTable(romFile, romHeader.FAToffset, romHeader.FATsize);
    if (fats != NULL)
    {
        ReadFileNameTable(romFile, romHeader.fileNameTableOffset, fats);

        free(fats);
    }

    fclose(romFile);

    ReleaseFileNameConversionTable();
}