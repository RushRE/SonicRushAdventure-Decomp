#include "romExtract.h"

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
// FUNCTIONS
// --------------------

int main(int argc, char** argv)
{
    const char* romPath = "baserom.nds";
    const char* fileTablePath = "FileTable.txt";

    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--rom") == 0)
        {
            i++;
            romPath = argv[i];
        }

        if (strcmp(argv[i], "--fileTable") == 0)
        {
            i++;
            fileTablePath = argv[i];
        }
    }

    // only run the tool if we haven't got a "resources" directory already!
    if (MakeDirectory(ROM_FILE_ROOT_DIR) == 0)
    {
        ExtractROM(romPath, fileTablePath);
    }
    else
    {
        printf("No need to extract rom. Exiting\n");
    }

    return EXIT_SUCCESS;
}
