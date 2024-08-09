import idautils, ida_funcs, ida_segregs, idc

def function_mode(ea):
    value = ida_segregs.get_sreg(ea, 20) # T
    
    if value == 1:
        return "thumb_func"
        
    if value == 0:
        return "arm_func"
        
    return "unknown_func_" + str(value)

def get_func_names():
    names = []
    for ea in idautils.Functions():
        name = ida_funcs.get_func_name(ea)
        type = function_mode(ea)
        names.append(type + " " + hex(ea) + " " + name)
    return names

def get_strings():

    names = []
    for s in idautils.Strings():
        type = "ascii"
        name = idc.get_name(s.ea)
        names.append(type + " " + hex(s.ea) + " " + name)
    return names

print('\n'.join(get_func_names()))

print('\n'.join(get_strings()))