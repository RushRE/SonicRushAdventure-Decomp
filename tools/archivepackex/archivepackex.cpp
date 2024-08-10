#include "archivePack.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include "cJSON.h"

#if defined(_WIN32)
#include <windows.h>
#include <sys/stat.h>
#else
#include <unistd.h>
#include <spawn.h>
#include <sys/wait.h>
#include <time.h>
#include <sys/stat.h>
#include <sys/types.h>

extern char** environ;
#endif

#include <iostream>
#include <filesystem>
#include <unordered_map>
#include <vector>

// --------------------
// STRUCTS
// --------------------

struct FileState
{
    std::time_t modifiedTime;
    bool needsPack;
};

// --------------------
// VARIABLES
// --------------------

static char rootDir[0x100];

// --------------------
// FUNCTIONS
// --------------------

static inline cJSON* GetJSONObject(cJSON* in, const char* name)
{
    return cJSON_GetObjectItemCaseSensitive(in, name);
}

static inline bool GetJSONBool(cJSON* in)
{
    if (!cJSON_IsBool(in))
        return false;

    return cJSON_IsTrue(in);
}

static inline int GetJSONInt(cJSON* in)
{
    if (!cJSON_IsNumber(in))
        return 0;

    return in->valueint;
}

static inline char* GetJSONString(cJSON* in)
{
    if (!cJSON_IsString(in))
        return NULL;

    return in->valuestring;
}

std::time_t GetFileWriteTime(char* filePath)
{
#if defined(_WIN32)
    const std::filesystem::path filename = filePath;

    struct _stat64 fileInfo;
    if (_wstati64(filename.wstring().c_str(), &fileInfo) != 0)
    {
        throw std::runtime_error("Failed to get last write time.");
    }
    return fileInfo.st_mtime;
#else
    struct stat attr;
    stat(filePath, &attr);
    return attr.st_mtime;
#endif
}

static inline size_t GetHash(const char* path)
{
    std::hash<std::string> hasher;
    return hasher(path);
}

static inline bool CheckHash(std::vector<size_t>& hashList, size_t hash)
{
    for (size_t i = 0; i < hashList.size(); i++)
    {
        if (hash == hashList[i])
        {
            return true;
        }
    }

    return false;
}

bool PackArchiveEx(char* inputPath, char* inputDir, std::vector<size_t>& hashList, std::unordered_map<size_t, FileState>& modifiedMap)
{
    unsigned int fileLength;
    unsigned char* jsonString = ReadWholeFile(inputPath, &fileLength);

    cJSON* json = cJSON_Parse((const char*)jsonString);

    if (json == NULL)
    {
        const char* errorPtr = cJSON_GetErrorPtr();
        FATAL_ERROR("Error in line \"%s\"\n", errorPtr);
    }

    size_t hash = GetHash(inputPath);
    FileState state = {};

    state.modifiedTime = GetFileWriteTime(inputPath);

    state.needsPack = false;
    if (modifiedMap.count(hash))
    {
        if (modifiedMap[hash].modifiedTime != state.modifiedTime)
        {
            // file exists and has been updated via another archive, but still needs packing!
            if (modifiedMap[hash].needsPack)
                state.needsPack = true;
        }
    }
    else
    {
        state.needsPack = true;
    }

    cJSON* files = GetJSONObject(json, "files");

    cJSON* file = NULL;
    cJSON_ArrayForEach(file, files)
    {
        if (cJSON_IsObject(file) == false)
        {
            continue;
        }

        char* fileName = GetJSONString(GetJSONObject(file, "sourcePath"));
        const char* ext = GetFileExtension(fileName);
        char* fileDir = GetFileDirectory(fileName);

        if (ext != NULL)
        {
            if (strcmp(ext, "bb") == 0 || strcmp(ext, "narc") == 0)
            {
                const size_t listDirSize = strlen(fileName) + 1;
                const size_t listPathSize = strlen(fileName) + 8;

                char* listDir = (char*)malloc(listDirSize);
                char* listPath = (char*)malloc(listPathSize);

                snprintf(listDir, listDirSize, "%s", fileName);
                listDir[strlen(fileName) - strlen(ext) - 1] = 0; // trim extension

                if (strcmp(ext, "bb") == 0)
                {
                    snprintf(listPath, listPathSize, "%s.bblst", listDir);
                    PackArchiveEx(listPath, fileDir, hashList, modifiedMap);
                }
                else if (strcmp(ext, "narc") == 0)
                {
                    snprintf(listPath, listPathSize, "%s.arclst", listDir);
                    PackArchiveEx(listPath, fileDir, hashList, modifiedMap);
                }

                free(listDir);
                free(listPath);
            }

            if (true)
            {
                size_t fileHash = GetHash(fileName);
                FileState fileState = {};

                fileState.modifiedTime = GetFileWriteTime(fileName);

                if (modifiedMap.count(fileHash))
                {
                    if (modifiedMap[fileHash].modifiedTime != fileState.modifiedTime)
                    {
                        // file has changed, we need to pack!
                        state.needsPack = true;

                        modifiedMap[fileHash].modifiedTime = fileState.modifiedTime;
                    }
                    else
                    {
                        // file exists and has been updated via another archive, but still needs packing!
                        if (modifiedMap[fileHash].needsPack)
                            state.needsPack = true;
                    }
                }
                else
                {
                    // file is new, we need to pack!
                    state.needsPack = true;

                    modifiedMap.emplace(fileHash, fileState);
                }
            }
        }

        free(fileDir);
    }

    // pack archive
    const char* ext = GetFileExtension(inputPath);

    if (ext != NULL)
    {
        if (strcmp(ext, "bblst") == 0 || strcmp(ext, "arclst") == 0 || strcmp(ext, "pckf") == 0)
        {
            size_t hash = GetHash(inputPath);

            // simple hash check so we don't compile the archives multiple times!
            if (!CheckHash(hashList, hash) && state.needsPack)
            {
                // printf("Working for: %s\n", inputPath);

                if (strcmp(ext, "bblst") == 0)
                {
                    PackBundle(inputPath, rootDir, inputDir);
                }
                else if (strcmp(ext, "arclst") == 0)
                {
                    PackArchive(inputPath, rootDir, inputDir);
                }
                else if (strcmp(ext, "pckf") == 0)
                {
                    PackFile(inputPath, rootDir, inputDir);
                }

                hashList.push_back(hash);

                if (modifiedMap.count(hash))
                {
                    // file is old, we need to update it!
                    modifiedMap[hash] = state;
                }
                else
                {
                    // file is new, we need to add it!
                    modifiedMap.emplace(hash, state);
                }
            }
            else
            {
                // printf("No work needed for: %s\n", inputPath);
            }
        }
    }

    cJSON_Delete(json);
    free(jsonString);

    return state.needsPack;
}

void PackDirectory(const char* directoryPath, std::vector<size_t>& hashList, std::unordered_map<size_t, FileState>& modifiedMap)
{
    for (std::filesystem::recursive_directory_iterator i(directoryPath), end; i != end; i++)
    {
        std::string pathStr = i->path().string();
        char* path = (char*)pathStr.c_str();

        if (is_directory(i->path()))
        {
            PackDirectory(i->path().string().c_str(), hashList, modifiedMap);
        }
        else
        {
            const char* ext = GetFileExtension(path);
            char* fileDir = GetFileDirectory(path);

            if (ext != NULL)
            {
                if (strcmp(ext, "bblst") == 0 || strcmp(ext, "arclst") == 0 || strcmp(ext, "pckf") == 0)
                {
                    PackArchiveEx(path, fileDir, hashList, modifiedMap);
                }
            }

            free(fileDir);
        }
    }
}

void LoadModifiedMap(std::unordered_map<size_t, FileState>& modifiedMap)
{
    modifiedMap.clear();

    FILE* file = fopen(".archivepack", "rb");
    if (file != NULL)
    {
        size_t count = 0;
        fread(&count, sizeof(count), 1, file);

        for (size_t i = 0; i < count; i++)
        {
            size_t hash;
            FileState state = {};
            state.needsPack = false;

            fread(&hash, sizeof(hash), 1, file);
            fread(&state.modifiedTime, sizeof(state.modifiedTime), 1, file);

            modifiedMap.emplace(hash, state);
        }

        fclose(file);
    }
}

void SaveModifiedMap(std::unordered_map<size_t, FileState>& modifiedMap)
{
    if (modifiedMap.size() > 0)
    {
        FILE* file = fopen(".archivepack", "wb");
        if (file != NULL)
        {
            size_t count = modifiedMap.size();
            fwrite(&count, sizeof(count), 1, file);

            for (auto it = modifiedMap.begin(); it != modifiedMap.end(); it++)
            {
                fwrite(&it->first, sizeof(it->first), 1, file);
                fwrite(&it->second.modifiedTime, sizeof(it->second.modifiedTime), 1, file);
            }

            fclose(file);
        }
    }
}

int main(int argc, char** argv)
{
    std::unordered_map<size_t, FileState> modifiedMap;
    std::vector<size_t> hashList;

    if (argc < 2)
        FATAL_ERROR("Usage: archivepackex INPUT_DIR\n");

    // load modified state
    LoadModifiedMap(modifiedMap);

    char* inputDir = argv[1];

#if defined(_WIN32)
    GetCurrentDirectoryA(sizeof(rootDir), rootDir);

    // "normalize" slashes to be the same across systems
    for (int c = 0; c < strlen(rootDir); c++)
    {
        if (rootDir[c] == '\\')
            rootDir[c] = '/';
    }
#else
    if (getcwd(rootDir, sizeof(rootDir)) == NULL)
    {
        // failed...
    }
#endif
    rootDir[strlen(rootDir) + 1] = 0;
    rootDir[strlen(rootDir)] = '/';

    PackDirectory(inputDir, hashList, modifiedMap);

    // save modified state
    SaveModifiedMap(modifiedMap);

    return 0;
}