from dataclasses import dataclass
import re
import os

@dataclass
class Address:
    addr: str
    size: str
    section: str
    name: str
    file: str
    decompiled: bool

overlays = {
    "unknown": [],
}

# read info from xmap file
def ReadXMAP(path):

    with open("build/rush2.eu/arm9.elf.xMAP") as file:
        region = "unknown"
        for line in file:
            split = line.strip()

            if split.startswith("# ."):
                region = split.replace("# .", "")

            result = re.match(r"^([0-9A-Fa-f]*) ([0-9A-Fa-f]*) (\.[A-Za-z]*)\s*([A-Za-z0-9_]*)\s*\(([A-Za-z0-9_.]*)([^\)]*)\)", split)
            if result:
                info = Address(result.group(1), result.group(2), result.group(3), result.group(4), result.group(5), True)

                if region not in overlays:
                    overlays[region] = []
                    
                overlays[region].append(info)

#parse any asm (.s) files and set the functions in there to be NOT decompiled
def ParseAsmFiles(includeLib = True):
    rootdir = './'
    if not includeLib:
        rootdir = 'asm/'

    for subdir, dirs, files in os.walk(rootdir):
        for file in files:
            path = os.path.join(subdir, file)
            
            if not path.endswith(".s"):
                continue

            text = ""
            with open(path, 'r') as file:
                text = file.read()

            for result in re.finditer(r"arm_func_start ([A-Za-z0-9_]*)", text):
                labelName = result.group(1)

                for key, value in overlays.items():
                    for i in range(len(value)):
                        if value[i].name == labelName:
                            overlays[key][i].decompiled = False

            for result in re.finditer(r"thumb_func_start ([A-Za-z0-9_]*)", text):
                labelName = result.group(1)

                for key, value in overlays.items():
                    for i in range(len(value)):
                        if value[i].name == labelName:
                            overlays[key][i].decompiled = False

#parse any c (.c & .cpp) files and set the functions in there with the "NONMATCH_FUNC" macro to be NOT decompiled
def ParseCFiles(includeLib = True):
    rootdir = './'
    if not includeLib:
        rootdir = 'src/'

    for subdir, dir, files in os.walk(rootdir):
        for file in files:
            path = os.path.join(subdir, file)
            
            if not path.endswith(".c") and not path.endswith(".cpp"):
                continue

            text = ""
            with open(path, 'r') as file:
                text = file.read()

            for result in re.finditer(r"NONMATCH_FUNC [static ]*([A-Za-z0-9_]*)[*]* [*]*([A-Za-z0-9_]*)", text):
                labelName = result.group(2)

                for key, value in overlays.items():
                    for i in range(len(value)):
                        if value[i].name == labelName:
                            overlays[key][i].decompiled = False

def PrintProgress():
    # calculate config
    version = "eu"
    includeLib = True
    
    ReadXMAP("build/rush2.{0}/arm9.elf.xMAP".format(version))
        
    ParseAsmFiles(includeLib=includeLib)
    ParseCFiles(includeLib=includeLib)

    allSrcCount = 0
    allTotalCount = 0

    for key, value in overlays.items():
        srcCount = 0
        totalCount = 0

        for info in value:
            # for now, just count functions (labels in .text section)
            if info.section != ".text":
                continue

            totalCount += 1
            allTotalCount += 1

            if info.decompiled:
                srcCount += 1
                allSrcCount += 1

        if totalCount == 0:
            continue

        percent = (srcCount / totalCount) * 100
        print("{0}: {1}/{2} => {3}%".format(key, srcCount, totalCount, "{:.2f}".format(percent)))

    percent = (allSrcCount / allTotalCount) * 100
    print("Total: {0}/{1} => {2}%".format(allSrcCount, allTotalCount, "{:.2f}".format(percent)))

PrintProgress()
