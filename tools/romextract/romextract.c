#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <stdnoreturn.h>
#include <stdarg.h>

#if defined _MSC_VER
#include <direct.h>

#define MakeDirectory(path) mkdir(path)

#pragma warning(disable : 4996) // disable "mkdir is deprecated" warning
#elif defined __GNUC__
#include <sys/types.h>
#include <sys/stat.h>

#define MakeDirectory(path) mkdir(path, 0700)

#endif

// resources/etc
// change this if you want a different extract directory!
#define ROM_FILE_ROOT_DIR "resources"

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

static ROMHeader romHeader;

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

static void ExtractFile(char *path, FILE *romFile, uint32_t offset, uint32_t size)
{
    // open file for writing
    FILE *file = fopen(path, "wb");
    if (file == NULL)
        return;

    // allocate buffer
    uint8_t *fileData = malloc(size);
    if (fileData == NULL)
        return;

    // read from rom
    memset(fileData, 0, size);
    {
        uint32_t romAddr = ftell(romFile);
        fseek(romFile, offset, SEEK_SET);
        fread(fileData, 1, size, romFile);
        fseek(romFile, romAddr, SEEK_SET);
    }

    // write to disk
    {
        fwrite(fileData, 1, size, file);
    }

    // finish & cleanup
    fclose(file);
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
                printf("loading file (%d) %s\n", fileID, path);
#endif

                ExtractFile(path, romFile, offset, size);

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

int main(int argc, char **argv)
{
    const char *romPath = "baserom.nds";

    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--rom") == 0)
        {
            i++;
            romPath = argv[i];
        }
    }

    // only run the tool if we haven't got a "resources" directory already!
    if (MakeDirectory(ROM_FILE_ROOT_DIR) == 0)
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

        printf("Extracting rom '%s'...\n", romPath);

        ROMFAT *fats = ReadFileAddressTable(romFile, romHeader.FAToffset, romHeader.FATsize);
        if (fats != NULL)
        {
            ReadFileNameTable(romFile, romHeader.fileNameTableOffset, fats);

            free(fats);
        }

        fclose(romFile);
    }
    else
    {
        printf("No need to extract rom. Exiting\n");
    }

    return EXIT_SUCCESS;
}
