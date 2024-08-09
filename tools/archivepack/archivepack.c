#include "global.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include "cJSON.h"

#if defined (_WIN32)
#include <windows.h>
#else
#include <unistd.h>
#include <spawn.h>
#include <sys/wait.h>

extern char** environ;
#endif

// --------------------
// CONSTANTS
// --------------------

#define NONE_TAG 0x00
#define LZ77_TAG 0x10
#define HUFF_TAG 0x20
#define RLE_TAG  0x30

#define ALIGN_DWORD(stream)\
if ((ftell(stream) % 4) != 0)\
{\
	for (int i = 4 - (ftell(stream) % 4); i-- > 0; )\
	{\
		fputc(0xFF, stream);\
	}\
}

// --------------------
// STRUCTS
// --------------------

typedef struct File_
{
	// common
	const char* name;
	void* data;
	unsigned int size;
	unsigned int offset;

	// archives
	unsigned int dataStartPos;
	unsigned int dataEndPos;
	unsigned char dirID;
} File;

// --------------------
// VARIABLES
// --------------------

static char* toolNtrComp = "../bin/ntrcomp.exe";

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

char* GetFileExtension(char* path)
{
	char* extension = path;

	while (*extension != 0)
		extension++;

	while (extension > path && *extension != '.')
		extension--;

	if (extension == path)
		return NULL;

	extension++;

	if (*extension == 0)
		return NULL;

	return extension;
}

const char* GetFileName(const char* path)
{
	const char* name = path;

	while (*name != 0)
		name++;

	while (name > path && (*name != '/' && *name != '\\'))
		name--;

	if (name == path)
		return path;

	name++;

	if (*name == 0)
		return NULL;

	return name;
}

char* GetFileDirectory(char* path)
{
	char* pathPtr = path;

	while (*pathPtr != 0)
		pathPtr++;

	while (pathPtr > path && (*pathPtr != '/' && *pathPtr != '\\'))
		pathPtr--;

	if (pathPtr == path)
		return NULL;

	pathPtr++;

	if (*pathPtr == 0)
		return NULL;

	size_t len = (size_t)pathPtr - (size_t)path;

	char* filePath = malloc(len + 1);
	memcpy(filePath, path, len);
	filePath[len] = 0;

	return filePath;
}

static int GetDirectoryCount(const char* path)
{
	int count = 0;

	const char* pathPtr = path;
	while (*pathPtr != 0)
	{
		if (*pathPtr == '/' || *pathPtr == '\\')
			count++;

		pathPtr++;
	}

	return count;
}

static char *GetDirectoryName(const char* path, int dirID)
{
	int count = 0;

	const char* pathPtr = path;
	int dirStartPos = 0;
	while (*pathPtr != 0)
	{
		if (*pathPtr == '/' || *pathPtr == '\\')
		{
			if (dirID == count)
			{
				size_t len = (size_t)pathPtr - (size_t)path;
				len -= dirStartPos;

				char* name = malloc(len + 1);
				memcpy(name, &path[dirStartPos], len);
				name[len] = 0;
				return name;
			}

			count++;

			dirStartPos = (int)((size_t)pathPtr - (size_t)path) + 1;
		}

		pathPtr++;
	}

	return NULL;
}

unsigned char* ReadWholeFile(char* path, int* size)
{
	FILE* fp = fopen(path, "rb");

	if (fp == NULL)
		FATAL_ERROR("Failed to open \"%s\" for reading.\n", path);

	fseek(fp, 0, SEEK_END);

	*size = ftell(fp);

	unsigned char* buffer = malloc(*size);

	if (buffer == NULL)
		FATAL_ERROR("Failed to allocate memory for reading \"%s\".\n", path);

	rewind(fp);

	if (fread(buffer, *size, 1, fp) != 1)
		FATAL_ERROR("Failed to read \"%s\".\n", path);

	fclose(fp);

	return buffer;
}

// stupid simple copy file func
static inline int copy_file(const char* src, const char* dst)
{
	const int bufsz = 0x10000;

	char* buf = malloc(bufsz);
	if (!buf)
		return -1;

	FILE* hin = fopen(src, "rb");
	if (!hin)
	{
		free(buf);
		return -1;
	}

	FILE* hout = fopen(dst, "wb");
	if (!hout)
	{
		free(buf);
		fclose(hin);
		return -1;
	}

	size_t buflen;
	while ((buflen = fread(buf, 1, bufsz, hin)) > 0)
	{
		if (buflen != fwrite(buf, 1, buflen, hout))
		{
			fclose(hout);
			fclose(hin);
			free(buf);
			return -1;
		}
	}
	free(buf);

	int r = ferror(hin) ? -1 : 0;
	fclose(hin);
	return r | (fclose(hout) ? -1 : 0);
}

// handle running ntrcomp in the archive list directory so all paths are local (and work on all filesystems!)
#if defined (_WIN32)
static inline void HandleCreateProcess(char* executable, char* processDir, char* args)
#else
static inline void HandleCreateProcess(char* executable, char* processDir, char* argv[])
#endif
{
#if defined (_WIN32)
	// on win32 systems we can just pass processDir as an argument!
	STARTUPINFOA si;
	PROCESS_INFORMATION pi;

	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));

	// Start the child process. 
	if (!CreateProcessA(executable, args, NULL, NULL, FALSE, 0, NULL, processDir, &si, &pi))
	{
		printf("WARNING: HandleCreateProcess failed (%d).\n", GetLastError());
		return;
	}

	// Wait until child process exits.
	WaitForSingleObject(pi.hProcess, INFINITE);

	// Close process and thread handles. 
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
#else
	// on non-win32 systems, we have to copy the ntrcomp executable since there's no easy way to use 'posix_spawn' with an initial cwd
	char cwd[0x100];
	char dest[0x100];
	getcwd(cwd, sizeof(cwd));

	size_t bufferSize = snprintf(NULL, 0, "%sntrcomp.exe", processDir);
	char* processPath = malloc(bufferSize + 1);
	snprintf(processPath, bufferSize + 1, "%sntrcomp.exe", processDir);

	pid_t pid;

	copy_file(executable, processPath);
	chdir(processDir);

	int status = posix_spawn(&pid, "ntrcomp.exe", NULL, NULL, argv, environ);
	if (status != 0)
	{
		free(processPath);
		remove("ntrcomp.exe");
		chdir(cwd);
		printf("WARNING: HandleCreateProcess failed (%s).\n", strerror(status));
		return;
	}

	if (waitpid(pid, &status, 0) == -1)
	{
		free(processPath);
		remove("ntrcomp.exe");
		chdir(cwd);
		printf("WARNING: HandleCreateProcess failed (%s).\n", strerror(status));
		return;
	}

	free(processPath);
	remove("ntrcomp.exe");
	chdir(cwd);
#endif
}

static inline char* GetCompressionArg(int compression)
{
	switch (compression & 0xF0)
	{
	case LZ77_TAG:
	{
		int config = compression & 0xF;

		if (config != 0)
		{
			printf("WARNING: Unknown LZ77 config '%d'\n", config);
		}

		return "-h -l2";
	}

	case HUFF_TAG:
	{
		int depth = compression & 0xF;
		if (depth == 4)
		{
			return "-h -h4";
		}
		else if (depth == 8)
		{
			return "-h -h8";
		}
		else
		{
			printf("WARNING: Unknown huffman depth '%d'\n", depth);
			return "-h";
		}
	}

	case RLE_TAG:
		return "-h -r";

	case NONE_TAG:
	default:
		return "-h";
	}
}

void WriteBundleFile(const char* name, char* inputDir, unsigned int fileCount, File* fileList)
{
	size_t bufferSize = snprintf(NULL, 0, "%s%s.bb", inputDir, name);
	char* path = malloc(bufferSize + 1);
	snprintf(path, bufferSize + 1, "%s%s.bb", inputDir, name);

	FILE* bundle = fopen(path, "wb");
	if (bundle != NULL)
	{
		// write signature
		fputc('B', bundle);
		fputc('B', bundle);
		fputc(0x00, bundle);
		fputc(0x00, bundle);

		// fileCount
		fwrite(&fileCount, 1, sizeof(unsigned int), bundle);

		// write (temp) offsets
		for (unsigned int f = 0; f < fileCount; f++)
		{
			fwrite(&fileList[f].offset, 1, sizeof(unsigned int), bundle);
			fwrite(&fileList[f].size, 1, sizeof(unsigned int), bundle);
		}

		// write file data
		for (unsigned int f = 0; f < fileCount; f++)
		{
			fileList[f].offset = ftell(bundle);
			fwrite(fileList[f].data, 1, fileList[f].size, bundle);
		}

		// write (proper) offsets
		fseek(bundle, 8, SEEK_SET);
		for (unsigned int f = 0; f < fileCount; f++)
		{
			fwrite(&fileList[f].offset, 1, sizeof(unsigned int), bundle);
			fwrite(&fileList[f].size, 1, sizeof(unsigned int), bundle);
		}

		fclose(bundle);
	}

	free(path);
}

void WriteBundleEnum(const char* name, char* inputDir, unsigned int fileCount, File* fileList)
{
	size_t bufferSize = snprintf(NULL, 0, "%s%s.h", inputDir, name);
	char* path = malloc(bufferSize + 1);
	snprintf(path, bufferSize + 1, "%s%s.h", inputDir, name);

	FILE* bundle = fopen(path, "w");
	if (bundle != NULL)
	{
		char nameBuffer[0x80];
		char buffer[0x200];

		snprintf(nameBuffer, sizeof(nameBuffer), "%s", name);
		char* nameBufferPtr = nameBuffer;
		while (*nameBufferPtr != 0)
		{
			*nameBufferPtr = toupper(*nameBufferPtr);

			if (*nameBufferPtr == ' ')
				*nameBufferPtr = '_';

			nameBufferPtr++;
		}

		snprintf(buffer, sizeof(buffer), "#ifndef RUSH2_BUNDLE_%s_H\n", nameBuffer);
		fputs(buffer, bundle);

		snprintf(buffer, sizeof(buffer), "#define RUSH2_BUNDLE_%s_H\n\n", nameBuffer);
		fputs(buffer, bundle);

		snprintf(buffer, sizeof(buffer), "enum FileList_Bundle%s\n", nameBuffer);
		fputs(buffer, bundle);
		snprintf(buffer, sizeof(buffer), "{\n");
		fputs(buffer, bundle);

		for (unsigned int f = 0; f < fileCount; f++)
		{
			snprintf(buffer, sizeof(buffer), "\tBUNDLE_%s_FILE_%s,\n", nameBuffer, fileList[f].name);

			char* bufferPtr = buffer;
			while (*bufferPtr != 0)
			{
				*bufferPtr = toupper(*bufferPtr);

				if (*bufferPtr == ' ' || *bufferPtr == '.')
					*bufferPtr = '_';

				bufferPtr++;
			}

			fputs(buffer, bundle);
		}

		snprintf(buffer, sizeof(buffer), "};\n\n");
		fputs(buffer, bundle);

		snprintf(buffer, sizeof(buffer), "#endif // RUSH2_BUNDLE_%s_H\n", nameBuffer);
		fputs(buffer, bundle);

		fclose(bundle);
	}

	free(path);
}

void WriteArchiveFile(const char* name, char* inputDir, unsigned int fileCount, File* fileList, unsigned char compression)
{
	const bool NO_FNT = false;

	struct Header
	{
		uint32_t signature;
		uint16_t byteOrderMark;
		uint16_t version;
		uint32_t fileSize;
		uint16_t chunkSize;
		uint16_t chunkCount;
	};

	struct FileAllocationTable
	{
		uint32_t id;
		uint32_t chunkSize;
		uint16_t fileCount;
		uint16_t reserved;
	};

	struct FileAllocationTableEntry
	{
		uint32_t start;
		uint32_t end;
	};

	struct FileNameTable
	{
		uint32_t id;
		uint32_t chunkSize;
	};

	struct FileNameTableEntry
	{
		uint32_t offset;
		uint16_t firstFileId;
		uint16_t utility;
	};

	struct FileImages
	{
		uint32_t id;
		uint32_t chunkSize;
	};

	struct Directory
	{
		char* name;
		unsigned char parent;
	};

	size_t bufferSize = snprintf(NULL, 0, "%s.tempnarc", name);
	char* tempName = malloc(bufferSize + 1);
	snprintf(tempName, bufferSize + 1, "%s.tempnarc", name);

	bufferSize = snprintf(NULL, 0, "%s%s", inputDir, tempName);
	char* tempPath = malloc(bufferSize + 1);
	snprintf(tempPath, bufferSize + 1, "%s%s", inputDir, tempName);

	FILE* archive = fopen(tempPath, "wb");
	if (archive != NULL)
	{
		// file access table setup
		for (unsigned int f = 0; f < fileCount; f++)
		{
			File* file = &fileList[f];

			file->dataStartPos = 0;
			file->dataEndPos = file->size;

			if (f > 0)
			{
				file->dataStartPos += fileList[f - 1].dataEndPos;
			}

			if ((file->dataStartPos % 4) != 0)
			{
				file->dataStartPos += 4 - (file->dataStartPos % 4);
			}

			file->dataEndPos += file->dataStartPos;
		}

		struct FileAllocationTable fat =
		{
			.id = 0x46415442, // BTAF
			.chunkSize = sizeof(struct FileAllocationTable) + (fileCount * sizeof(struct FileAllocationTableEntry)),
			.fileCount = fileCount,
			.reserved = 0x0
		};

		struct FileNameTable fnt =
		{
			.id = 0x464E5442, // BTNF
			.chunkSize = sizeof(struct FileNameTable),
		};

		struct FileImages fi =
		{
			.id = 0x46494D47, // GMIF
			.chunkSize = sizeof(struct FileImages) + (fileList[fileCount - 1].dataEndPos)
		};

		// .chunkSize = (sizeof(struct FileNameTable) + (dirCount + fileCount * sizeof(struct FileNameTableEntry)))
		struct Directory* dirList = malloc(sizeof(struct Directory) * 0x80);
		memset(dirList, 0, sizeof(struct Directory) * 0x80);
		dirList[0].name = NULL;

		unsigned char dirCount = 1;
		if (NO_FNT)
		{
			fnt.chunkSize += sizeof(struct FileNameTableEntry);
			fnt.chunkSize++; // end of table byte
		}
		else
		{
			fnt.chunkSize += sizeof(struct FileNameTableEntry);
			fnt.chunkSize++; // end of table byte

			for (unsigned int f = 0; f < fileCount; f++)
			{
				File* file = &fileList[f];

				int count = GetDirectoryCount(file->name);

				if (count == 0)
				{
					file->dirID = 0;

					fnt.chunkSize += sizeof(unsigned char);
					fnt.chunkSize += (uint32_t)strlen(GetFileName(file->name));
				}
				else
				{
					int prevDir = 0;
					for (int d = 0; d < count; d++)
					{
						char* name = GetDirectoryName(file->name, d);

						bool exists = false;
						for (int i = 1; i < dirCount; i++)
						{
							if (strcmp(name, dirList[i].name) == 0)
							{
								exists = true;
								file->dirID = i;
								prevDir = i;
								free(name);

								fnt.chunkSize += sizeof(unsigned char);
								fnt.chunkSize += (uint32_t)strlen(GetFileName(file->name));

								break;
							}
						}

						if (exists == false)
						{
							dirList[dirCount].name = name;
							dirList[dirCount].parent = prevDir;
							file->dirID = dirCount;
							prevDir = dirCount;
							dirCount++;

							fnt.chunkSize += sizeof(unsigned char);
							fnt.chunkSize += (uint32_t)strlen(name);
							fnt.chunkSize += sizeof(unsigned short);

							fnt.chunkSize += sizeof(unsigned char);
							fnt.chunkSize += (uint32_t)strlen(GetFileName(file->name));

							fnt.chunkSize += sizeof(struct FileNameTableEntry);
							fnt.chunkSize++; // end of table byte
						}
					}
				}
			}
		}

		if ((fnt.chunkSize % 4) != 0)
			fnt.chunkSize += 4 - (fnt.chunkSize % 4);

		struct Header header =
		{
			.signature = 0x4352414E, // NARC
			.byteOrderMark = 0xFFFE,
			.version = 0x100,
			.fileSize = (sizeof(struct Header) + fat.chunkSize + fnt.chunkSize + fi.chunkSize),
			.chunkSize = sizeof(struct Header),
			.chunkCount = 3
		};


		// header
		fwrite(&header, 1, sizeof(header), archive);

		// file allocation table
		fwrite(&fat, 1, sizeof(fat), archive);
		for (unsigned int f = 0; f < fileCount; f++)
		{
			File* file = &fileList[f];

			struct FileAllocationTableEntry entry = { 0 };

			entry.start = file->dataStartPos;
			entry.end = file->dataEndPos;

			fwrite(&entry, 1, sizeof(entry), archive);
		}

		// file name table
		fwrite(&fnt, 1, sizeof(fnt), archive);
		if (NO_FNT)
		{
			struct FileNameTableEntry entry;

			// empty root dir
			entry.offset = sizeof(struct FileNameTable) - 0x4;
			entry.firstFileId = 0x0;
			entry.utility = 0x1;

			fwrite(&entry, 1, sizeof(entry), archive);
		}
		else
		{
			// write directory list
			size_t startPos = ftell(archive);
			int dirOffset = (dirCount) * sizeof(struct FileNameTableEntry);
			for (unsigned int d = 0; d < dirCount; d++)
			{
				struct FileNameTableEntry entry;

				// directory info
				entry.offset = dirOffset;

				if (d == 0)
				{
					entry.utility = dirCount;
				}
				else
				{
					entry.utility = 0xF000 + dirList[d].parent;
				}

				entry.firstFileId = 0x0;
				for (unsigned int f = 0; f < fileCount; f++)
				{
					File* file = &fileList[f];

					if (file->dirID != d)
						continue;

					entry.firstFileId = f;
					break;
				}

				fwrite(&entry, 1, sizeof(entry), archive);

				for (unsigned int f = 0; f < fileCount; f++)
				{
					File* file = &fileList[f];

					if (file->dirID != d)
						continue;

					const char* name = GetFileName(file->name);
					unsigned char len = strlen(name) & 0x7F;
					dirOffset += sizeof(unsigned char);
					dirOffset += len;
				}

				for (unsigned int c = 1; c < dirCount; c++)
				{
					struct Directory* dir = &dirList[c];

					if (dir->parent != d)
						continue;

					const char* name = GetFileName(dir->name);
					unsigned char len = strlen(name) & 0x7F;
					dirOffset += sizeof(unsigned char);
					dirOffset += len;
					dirOffset += sizeof(unsigned short);
				}

				// end of table
				dirOffset += sizeof(unsigned char);
			}

			// write file contents
			for (unsigned int d = 0; d < dirCount; d++)
			{
				for (unsigned int f = 0; f < fileCount; f++)
				{
					File* file = &fileList[f];

					if (file->dirID != d)
						continue;

					const char* name = GetFileName(file->name);
					unsigned char len = strlen(name) & 0x7F;
					fwrite(&len, 1, sizeof(len), archive);
					fwrite(name, 1, len, archive);
				}

				for (unsigned int c = 1; c < dirCount; c++)
				{
					struct Directory* dir = &dirList[c];

					if (dir->parent != d)
						continue;

					const char* name = GetFileName(dir->name);
					unsigned char len = 0x80 | (strlen(name) & 0x7F);
					fwrite(&len, 1, sizeof(len), archive);
					fwrite(name, 1, (len & 0x7F), archive);

					unsigned short id = 0xF000 + c;
					fwrite(&id, 1, sizeof(id), archive);
				}

				// end of table
				fputc(0x00, archive);
			}
		}
		ALIGN_DWORD(archive);

		fwrite(&fi, 1, sizeof(fi), archive);
		size_t offset = ftell(archive);
		for (unsigned int f = 0; f < fileCount; f++)
		{
			File* file = &fileList[f];

			if ((ftell(archive) - offset) != file->dataStartPos)
			{
				continue;
			}

			fwrite(file->data, 1, file->size, archive);
			ALIGN_DWORD(archive);
		}

		fclose(archive);

		for (int i = 0; i < dirCount; i++)
		{
			if (dirList[i].name != NULL)
			{
				free(dirList[i].name);
			}
		}
		free(dirList);
	}

	if (compression != 0xFF)
	{
		// compression is applied, compress source file and read the result
		size_t bufferSize = snprintf(NULL, 0, "%s.narc", name);
		char* outName = malloc(bufferSize + 1);
		snprintf(outName, bufferSize + 1, "%s.narc", name);

#if defined (_WIN32)
		bufferSize = snprintf(NULL, 0, "%s -o \"%s\" \"%s\"", GetCompressionArg(compression), outName, tempName);
		char* args = malloc(bufferSize + 1);
		snprintf(args, bufferSize + 1, "%s -o \"%s\" \"%s\"", GetCompressionArg(compression), outName, tempName);
		HandleCreateProcess(toolNtrComp, inputDir, args);
		free(args);
#else
		char* argv[] = { GetCompressionArg(compression), "-o", outName, tempName, NULL };
		HandleCreateProcess(toolNtrComp, inputDir, argv);
#endif

		if (remove(tempPath) != 0)
		{
			// couldn't remove the temp file...
		}

		free(outName);
	}
	else
	{
		size_t bufferSize = snprintf(NULL, 0, "%s%s.narc", inputDir, name);
		char* path = malloc(bufferSize + 1);
		snprintf(path, bufferSize + 1, "%s%s.narc", inputDir, name);

		// no compression at all, copy file to destination
		copy_file(tempPath, path);

		free(path);
	}

	free(tempName);
	free(tempPath);
}

void WriteArchiveEnum(const char* name, char* inputDir, unsigned int fileCount, File* fileList)
{
	size_t bufferSize = snprintf(NULL, 0, "%s%s.h", inputDir, name);
	char* path = malloc(bufferSize + 1);
	snprintf(path, bufferSize + 1, "%s%s.h", inputDir, name);

	FILE* bundle = fopen(path, "w");
	if (bundle != NULL)
	{
		char nameBuffer[0x80];
		char buffer[0x200];

		snprintf(nameBuffer, sizeof(nameBuffer), "%s", name);
		char* nameBufferPtr = nameBuffer;
		while (*nameBufferPtr != 0)
		{
			*nameBufferPtr = toupper(*nameBufferPtr);

			if (*nameBufferPtr == ' ')
				*nameBufferPtr = '_';

			nameBufferPtr++;
		}

		snprintf(buffer, sizeof(buffer), "#ifndef RUSH2_ARCHIVE_%s_H\n", nameBuffer);
		fputs(buffer, bundle);

		snprintf(buffer, sizeof(buffer), "#define RUSH2_ARCHIVE_%s_H\n\n", nameBuffer);
		fputs(buffer, bundle);

		snprintf(buffer, sizeof(buffer), "enum FileList_Archive%s\n", nameBuffer);
		fputs(buffer, bundle);
		snprintf(buffer, sizeof(buffer), "{\n");
		fputs(buffer, bundle);

		for (unsigned int f = 0; f < fileCount; f++)
		{
			snprintf(buffer, sizeof(buffer), "\tARCHIVE_%s_FILE_%s,\n", nameBuffer, fileList[f].name);

			char* bufferPtr = buffer;
			while (*bufferPtr != 0)
			{
				*bufferPtr = toupper(*bufferPtr);

				if (*bufferPtr == ' ' || *bufferPtr == '.')
					*bufferPtr = '_';

				bufferPtr++;
			}

			fputs(buffer, bundle);
		}

		snprintf(buffer, sizeof(buffer), "};\n\n");
		fputs(buffer, bundle);

		snprintf(buffer, sizeof(buffer), "#endif // RUSH2_ARCHIVE_%s_H\n", nameBuffer);
		fputs(buffer, bundle);

		fclose(bundle);
	}

	free(path);
}

void PackBundle(char* inputPath, char* inputDir)
{
	int fileLength;
	unsigned char* jsonString = ReadWholeFile(inputPath, &fileLength);

	cJSON* json = cJSON_Parse((const char*)jsonString);

	if (json == NULL)
	{
		const char* errorPtr = cJSON_GetErrorPtr();
		FATAL_ERROR("Error in line \"%s\"\n", errorPtr);
	}

	const char* name = GetJSONString(GetJSONObject(json, "name"));

	cJSON* files = GetJSONObject(json, "files");
	unsigned int fileCount = cJSON_GetArraySize(files);

	File* fileList = malloc(sizeof(File) * fileCount);
	memset(fileList, 0, sizeof(File) * fileCount);

	cJSON* file = NULL;
	File* bundleFile = fileList;
	cJSON_ArrayForEach(file, files)
	{
		if (cJSON_IsObject(file) == false)
		{
			bundleFile++;
			continue;
		}

		const char* fileName = GetJSONString(GetJSONObject(file, "path"));
		unsigned char compression = GetJSONInt(GetJSONObject(file, "compression"));

		size_t bufferSize = snprintf(NULL, 0, "%s%s", inputDir, fileName);
		char* path = malloc(bufferSize + 1);
		snprintf(path, bufferSize + 1, "%s%s", inputDir, fileName);

		if (compression != 0xFF)
		{
			// compression is applied, compress source file and read the result

			bufferSize = snprintf(NULL, 0, "%s.comp.bin", fileName);
			char* tempName = malloc(bufferSize + 1);
			snprintf(tempName, bufferSize + 1, "%s.comp.bin", fileName);

			bufferSize = snprintf(NULL, 0, "%s%s", inputDir, tempName);
			char* tempPath = malloc(bufferSize + 1);
			snprintf(tempPath, bufferSize + 1, "%s%s", inputDir, tempName);

#if defined (_WIN32)
			bufferSize = snprintf(NULL, 0, "%s -o \"%s\" \"%s\"", GetCompressionArg(compression), tempName, fileName);
			char* args = malloc(bufferSize + 1);
			snprintf(args, bufferSize + 1, "%s -o \"%s\" \"%s\"", GetCompressionArg(compression), tempName, fileName);
			HandleCreateProcess(toolNtrComp, inputDir, args);
			free(args);
#else
			char* argv[] = { GetCompressionArg(compression), "-o", tempName, (char*)fileName, NULL };
			HandleCreateProcess(toolNtrComp, inputDir, argv);
#endif

			bundleFile->offset = 0;
			bundleFile->data = ReadWholeFile(tempPath, &bundleFile->size);

			// LZ77 files are padded to 0x4 bytes & padded with 0xFF (ntrComp pads with 0x00)
			if ((compression & 0xF0) == LZ77_TAG)
			{
				int padding = 4 - (bundleFile->size & 3);

				if (padding < 4)
				{
					void* paddedData = malloc(bundleFile->size + padding);

					memcpy(paddedData, bundleFile->data, bundleFile->size);
					for (int b = 0; b < padding; b++)
					{
						((unsigned char*)paddedData)[bundleFile->size + b] = 0xFF;
					}

					bundleFile->size += padding;
					free(bundleFile->data);
					bundleFile->data = paddedData;
				}
			}

			if (remove(tempPath) != 0)
			{
				// couldn't remove the temp file...
			}

			free(tempName);
			free(tempPath);
		}
		else
		{
			// no compression at all, read source file
			bundleFile->offset = 0;
			bundleFile->data = ReadWholeFile(path, &bundleFile->size);
		}

		bundleFile->name = fileName;

		free(path);

		bundleFile++;
	}

	WriteBundleFile(name, inputDir, fileCount, fileList);
	WriteBundleEnum(name, inputDir, fileCount, fileList);

	if (fileList != NULL)
	{
		for (unsigned int f = 0; f < fileCount; f++)
		{
			if (fileList[f].data != NULL)
			{
				free(fileList[f].data);
			}
		}
		free(fileList);
	}

	cJSON_Delete(json);
	free(jsonString);
}

void PackArchive(char* inputPath, char* inputDir)
{
	int fileLength;
	unsigned char* jsonString = ReadWholeFile(inputPath, &fileLength);

	cJSON* json = cJSON_Parse((const char*)jsonString);

	if (json == NULL)
	{
		const char* errorPtr = cJSON_GetErrorPtr();
		FATAL_ERROR("Error in line \"%s\"\n", errorPtr);
	}

	const char* name = GetJSONString(GetJSONObject(json, "name"));
	unsigned char arcCompression = GetJSONInt(GetJSONObject(json, "compression"));

	cJSON* files = GetJSONObject(json, "files");
	unsigned int fileCount = cJSON_GetArraySize(files);
	File* fileList = malloc(sizeof(File) * fileCount);
	memset(fileList, 0, sizeof(File) * fileCount);

	cJSON* file = NULL;
	File* bundleFile = fileList;
	cJSON_ArrayForEach(file, files)
	{
		if (cJSON_IsObject(file) == false)
		{
			bundleFile++;
			continue;
		}

		const char* fileName = GetJSONString(GetJSONObject(file, "path"));
		unsigned char compression = GetJSONInt(GetJSONObject(file, "compression"));

		size_t bufferSize = snprintf(NULL, 0, "%s%s", inputDir, fileName);
		char* path = malloc(bufferSize + 1);
		snprintf(path, bufferSize + 1, "%s%s", inputDir, fileName);


		if (compression != 0xFF)
		{
			// compression is applied, compress source file and read the result

			bufferSize = snprintf(NULL, 0, "%s.comp.bin", fileName);
			char* tempName = malloc(bufferSize + 1);
			snprintf(tempName, bufferSize + 1, "%s.comp.bin", fileName);

			bufferSize = snprintf(NULL, 0, "%s%s", inputDir, tempName);
			char* tempPath = malloc(bufferSize + 1);
			snprintf(tempPath, bufferSize + 1, "%s%s", inputDir, tempName);

#if defined (_WIN32)
			bufferSize = snprintf(NULL, 0, "%s -o \"%s\" \"%s\"", GetCompressionArg(compression), tempName, fileName);
			char* args = malloc(bufferSize + 1);
			snprintf(args, bufferSize + 1, "%s -o \"%s\" \"%s\"", GetCompressionArg(compression), tempName, fileName);
			HandleCreateProcess(toolNtrComp, inputDir, args);
			free(args);
#else
			char* argv[] = { GetCompressionArg(compression), "-o", tempName, (char*)fileName, NULL };
			HandleCreateProcess(toolNtrComp, inputDir, argv);
#endif

			bundleFile->offset = 0;
			bundleFile->data = ReadWholeFile(tempPath, &bundleFile->size);

			if (remove(tempPath) != 0)
			{
				// couldn't remove the temp file...
			}

			free(tempName);
			free(tempPath);
		}
		else
		{
			// no compression at all, read source file
			bundleFile->offset = 0;
			bundleFile->data = ReadWholeFile(path, &bundleFile->size);
		}

		bundleFile->name = fileName;

		free(path);

		bundleFile++;
	}

	WriteArchiveFile(name, inputDir, fileCount, fileList, arcCompression);
	WriteArchiveEnum(name, inputDir, fileCount, fileList);

	if (fileList != NULL)
	{
		for (unsigned int f = 0; f < fileCount; f++)
		{
			if (fileList[f].data != NULL)
			{
				free(fileList[f].data);
			}
		}
		free(fileList);
	}

	cJSON_Delete(json);
	free(jsonString);
}

int main(int argc, char** argv)
{
	if (argc < 2)
		FATAL_ERROR("Usage: archivepack INPUT_PATH\n");

	char* inputPath = argv[1];
	char* fileExtension = GetFileExtension(inputPath);
	char* fileDir = GetFileDirectory(inputPath);

	if (fileExtension == NULL)
		FATAL_ERROR("Input file \"%s\" has no extension.\n", inputPath);

	if (strcmp(fileExtension, "bblst") == 0)
	{
		PackBundle(inputPath, fileDir);
	}
	else if (strcmp(fileExtension, "arclst") == 0)
	{
		PackArchive(inputPath, fileDir);
	}
	else
	{
		FATAL_ERROR("Unknown archive format for: %s.\n", inputPath);
	}

	free(fileDir);

	return 0;
}