# register => compiled value for GXx_SetBGXControl
register = 0x20C

def screenSize():
    return (register & 0xC000) >> 14
    
def bgPaletteSlot():
    return (register & 0x2000) >> 13
    
def screenBase():
    return (register & 0x1F00) >> 8
    
def colorMode():
    return (register & 0x0080) >> 7
    
def mosaic():
    return (register & 0x0040) >> 6
    
def charBase():
    return (register & 0x003C) >> 2
    
def priority():
    return (register & 0x0003) >> 0

print("register => " + hex(register) + " (" + "{0:b}".format(register) + ")")
print("screenSize => " + str(screenSize()))
print("bgPaletteSlot/areaOver => " + str(bgPaletteSlot()))
print("screenBase => " + str(screenBase()))
print("colorMode => " + str(colorMode()))
print("mosaic => " + str(mosaic()))
print("charBase => " + str(charBase()))
print("priority => " + str(priority()))