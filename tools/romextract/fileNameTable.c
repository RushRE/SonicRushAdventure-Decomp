#include "romExtract.h"

// --------------------
// STRUCTS
// --------------------

typedef struct FileName_
{
    char* inputName;
    char* outputName;
} FileName;

// --------------------
// VARIABLES
// --------------------

static FileName* fileNameTable;
static uint32_t fileNameTableSize;

// --------------------
// FUNCTIONS
// --------------------

void ReleaseFileNameConversionTable(void)
{
    if (fileNameTable != NULL)
        free(fileNameTable);

    fileNameTable = NULL;
}

void ReadFileNameConversionTable(const char* path)
{
    static const char* prefix = ROM_FILE_ROOT_DIR "/";
    size_t prefixSize = strlen(prefix);

    fileNameTableSize = 0;

    // open file for writing
    FILE* file = fopen(path, "rb");
    if (file == NULL)
        return;

    // allocate buffer
    fseek(file, 0, SEEK_END);
    size_t size = ftell(file);
    fseek(file, 0, SEEK_SET);
    uint8_t* fileData = malloc(size);
    if (fileData == NULL)
        return;

    fread(fileData, size, 1, file);

    // get table size (count the number of lines)
    fileNameTableSize = 0;
    for (uint32_t b = 0; b <= size; b++)
    {
        if (b == size || fileData[b] == '\n')
        {
            fileNameTableSize++;
        }
    }

    fileNameTable = malloc(sizeof(FileName) * fileNameTableSize);
    memset(fileNameTable, 0, sizeof(FileName) * fileNameTableSize);

    uint32_t lastPos = 0;
    uint32_t entryID = 0;
    for (uint32_t b = 0; b <= size; b++)
    {
        if (b == size || fileData[b] == '\n')
        {
            uint32_t lineSize = b - lastPos;

            if (b > 0 && fileData[b - 1] == '\r')
                lineSize--;

            if (entryID >= fileNameTableSize)
            {
#ifdef _DEBUG
                printf("ERROR: FILENAME TABLE IS TOO LARGE\n");
#endif
                break;
            }

            FileName* entry = &fileNameTable[entryID];
            for (uint32_t c = lastPos; c < lastPos + lineSize; c++)
            {
                if (fileData[c] == ',')
                {
                    int stringSize = (c - lastPos);
                    entry->inputName = malloc(stringSize + prefixSize + 1); // + 1 for null terminator
                    memset(entry->inputName, 0, stringSize + prefixSize + 1);
                    memcpy(entry->inputName, prefix, prefixSize);
                    memcpy(entry->inputName + prefixSize, &fileData[lastPos], stringSize);

                    stringSize = lineSize - stringSize - 1; // -1 to get rid of ',' character
                    entry->outputName = malloc(stringSize + prefixSize + 1); // + 1 for null terminator
                    memset(entry->outputName, 0, stringSize + prefixSize + 1);
                    memcpy(entry->outputName, prefix, prefixSize);
                    memcpy(entry->outputName + prefixSize, &fileData[c + 1], stringSize);

                    // printf("Loading new file name for %s => %s\n", entry->inputName, entry->outputName);
                    break;
                }
            }

            lastPos = b + 1; // start after the newline
            entryID++;
        }
    }

    // finish & cleanup
    fclose(file);
    free(fileData);
}

const char* GetConvertedFileName(char* filePath)
{
    if (fileNameTable == NULL)
        return NULL;

    for (uint32_t i = 0; i < fileNameTableSize; i++)
    {
        if (strcmp(filePath, fileNameTable[i].inputName) == 0)
        {
            return fileNameTable[i].outputName;
        }
    }

#ifdef _DEBUG
    printf("FILE NOT FOUND IN TABLE: %s\n", filePath);
#endif

    return NULL;
}