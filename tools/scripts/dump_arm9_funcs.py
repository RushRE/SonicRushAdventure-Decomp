import idautils, ida_funcs, ida_segregs, idc

def get_func_names():
    names = []
    for ea in idautils.Functions():
        if ea >= 0x2152960:
            continue
    
        name = ida_funcs.get_func_name(ea)
        names.append(hex(ea) + " " + name)
    return names

print('\n'.join(get_func_names()))