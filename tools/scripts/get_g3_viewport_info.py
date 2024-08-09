# register => compiled value for GX_SetVisiblePlane
register = 0xBFFF0000

def x1():
    return (register) & 0xFF

def y1():
    return (register >> 8) & 0xFF

def x2():
    return (register >> 16) & 0xFF

def y2():
    return (register >> 24) & 0xFF

print("register => " + hex(register) + " (" + "{0:b}".format(register) + ")")
print("x1 => " + str(x1()))
print("y1 => " + str(y1()))
print("x2 => " + str(x2()))
print("y2 => " + str(y2()))