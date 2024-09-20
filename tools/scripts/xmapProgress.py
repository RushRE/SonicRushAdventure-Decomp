from typing import NamedTuple
import re

class Address(NamedTuple):
    addr: str
    size: str
    section: str
    name: str
    file: str

def pretty(d, indent=0):
   for key, value in d.items():
      print('\t' * indent + str(key))
      if isinstance(value, dict):
         pretty(value, indent+1)
      else:
         print('\t' * (indent+1) + str(value))

with open("build/rush2.eu/arm9.elf.xMAP") as file:
    mode = 0

    overlays = {
        "unknown": [],
    }

    region = "unknown"
    for line in file:
        split = line.strip()

        if split.startswith("# ."):
            region = split.replace("# .", "")

        result = re.match("^([0-9A-Fa-f]*) ([0-9A-Fa-f]*) (\.[A-Za-z]*)\s*([A-Za-z0-9_]*)\s*\(([A-Za-z0-9_.]*)([^\)]*)\)", split)
        if result:
            info = Address(result.group(1), result.group(2), result.group(3), result.group(4), result.group(5))

            if region not in overlays:
                overlays[region] = []
                
            overlays[region].append(info)

            # print(info)
        
        # if mode == 1:
        
    for key, value in overlays.items():
        print(key)

        srcCount = 0  #TODO: count these
        totalCount = 0

        for info in value:
            totalCount += 1
            #print("\t" + info.name)

        percent = 100
        if totalCount > 0:
            percent = (srcCount / totalCount) * 100

        print("{0}/{1} => {2}%".format(srcCount, totalCount, "{:.2f}".format(percent)))
