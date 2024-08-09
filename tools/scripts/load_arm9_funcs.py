import idautils, ida_funcs, ida_segregs, idc

with open("E:/Github/rushing-around/func_names_arm9.txt") as file:
    for line in file:
        split = line.rstrip().split(" ")
        
        if split[1].startswith("sub_") or split[1].startswith("nullsub"):
            continue # we can ignore these for now!
        
        print(split)
        set_name(int(split[0], 16), str(split[1]), 0)