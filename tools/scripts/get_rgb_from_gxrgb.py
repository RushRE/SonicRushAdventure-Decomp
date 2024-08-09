# color => packed RGB5551 color
color = 0x7FFF

def getR():
    return ((color >> 0) & 0x1F)
    
def getG():
    return ((color >> 5) & 0x1F)
    
def getB():
    return ((color >> 10) & 0x1F)
    
def getA():
    return ((color >> 15) & 1)

print("color => " + hex(color) + " (" + "{0:b}".format(color) + ")")
print("r => " + hex(getR()))
print("g => " + hex(getG()))
print("b => " + hex(getB()))
print("a => " + hex(getA()))
print("========================")
print("r8 => " + hex(getR() << 3))
print("g8 => " + hex(getG() << 3))
print("b8 => " + hex(getB() << 3))
print("a8 => " + hex(getA() * 255))