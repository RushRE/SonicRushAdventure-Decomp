# register => compiled value for GXx_SetVisiblePlane
register = 0x1100

def bg0():
    return (register >> 8) & 1

def bg1():
    return (register >> 9) & 1

def bg2():
    return (register >> 10) & 1

def bg3():
    return (register >> 11) & 1

def obj():
    return (register >> 12) & 1

print("register => " + hex(register) + " (" + "{0:b}".format(register) + ")")
print("bg0 => " + str(bg0()))
print("bg1 => " + str(bg1()))
print("bg2 => " + str(bg2()))
print("bg3 => " + str(bg3()))
print("obj => " + str(obj()))