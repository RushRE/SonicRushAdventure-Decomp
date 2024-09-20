import sys

with open("arm9.lsf") as file:
    mode = 0
    totalCount = 0
    srcCount = 0
    moduleTotalCount = 0
    moduleSrcCount = 0
    moduleName = "_UNKNOWN_"

    for line in file:
        split = line.strip()

        if "Static " in split or "Autoload " in split or "Overlay " in split:
            mode = 1
            moduleSrcCount = 0
            moduleTotalCount = 0
            moduleName = split.split(" ")[1]
            continue
        
        if mode == 1:
            if split.startswith("Object "):
                # print(split)
                moduleTotalCount += 1
                totalCount += 1

                if split.startswith("Object src/") or split.startswith("Object lib/"):
                    srcCount += 1
                    moduleSrcCount += 1

            if split == "}":
                mode = 0

                print("{0} Info:".format(moduleName))
                print("{0}/{1} => {2}%".format(moduleSrcCount, moduleTotalCount, "{:.2f}".format((moduleSrcCount / moduleTotalCount) * 100)))

    print("Total Info:")
    print("{0}/{1} => {2}%".format(srcCount, totalCount, "{:.2f}".format((srcCount / totalCount) * 100)))
