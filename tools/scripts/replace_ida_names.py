import idautils, ida_funcs, ida_segregs, idc

toFind = "Task::Unknown2173B98::"
toReplace = "VSMenu::"

def replace_func_names():
    names = []
    for ea in idautils.Functions():
        name = ida_funcs.get_func_name(ea)
        
        if toFind in name:
            name = name.replace(toFind, toReplace)
            set_name(ea, name, 0)

replace_func_names()