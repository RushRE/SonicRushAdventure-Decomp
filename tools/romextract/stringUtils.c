#include "stringUtils.h"

// --------------------
// FUNCTIONS
// --------------------

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

char* GetPathWithoutExtension(char* path)
{
	char* buffer = path;

	while (*buffer != 0)
		buffer++;

	while (buffer > path && *buffer != '.')
		buffer--;

	if (buffer == path)
		return NULL;

	char* newPath = malloc((buffer - path) + 1);
	memset(newPath, 0, (buffer - path) + 1);
	memcpy(newPath, path, (buffer - path));

	return newPath;
}

char* GetFileName(const char* path)
{
	const char* name = path;

	while (*name != 0)
		name++;

	while (name > path && (*name != '/' && *name != '\\'))
		name--;

	if (name == path)
		return (char*)path;

	name++;

	if (*name == 0)
		return NULL;

	char* ext = GetFileExtension((char*)name);

	char* nameStr = NULL;
	if (ext == NULL)
	{
		size_t len = strlen(name);
		nameStr = malloc(len + 1);
		memset(nameStr, 0, len + 1);
		memcpy(nameStr, name, len);
	}
	else
	{
		size_t len = strlen(name) - strlen(ext);
		nameStr = malloc(len + 1);
		memset(nameStr, 0, len + 1);
		memcpy(nameStr, name, len);
	}

	return nameStr;
}