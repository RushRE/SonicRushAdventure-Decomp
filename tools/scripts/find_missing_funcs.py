rom_start = 0x08000000
end_of_code = 0x0809B670
end_of_data = 0x087ff04B

addresses = set()

with open('asm/main.s') as code:
    dataDefined = False
    prevLine = ""

    for line in code.readlines():
        line = line.strip()

        if dataDefined:
            dataDefined = False
            if ".byte" in line:

                try:
                    address = int(prevLine, 16)
                    addresses.add(address)
                except ValueError:
                    # Not valid, just ignore for now
                    continue

        if ":" in line:
            dataDefined = True
            prevLine = line.replace(":", "").replace("_", "")

sorted_addresses = sorted(addresses)

for i in range(len(sorted_addresses)):
    address = sorted_addresses[i]
    
    print("arm_func 0x" + f'{address:X}' + " sub_" + f'{address:X}')
