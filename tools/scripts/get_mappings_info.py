# mapping => info
mapping = 0x11111111
mapping = mapping & 0xFFFF

def charName():
    return ((mapping >> 0) & 0x03ff)
    
def flipX():
    return ((mapping & 0x0400) >> 10)
    
def flipY():
    return ((mapping & 0x0800) >> 11)
    
def palette():
    return ((mapping & 0xf000) >> 12)

print("mapping => " + hex(mapping) + " (" + "{0:b}".format(mapping) + ")")
print("charName => " + str(charName()) + ", " + hex(charName()))
print("flipX => " + str(flipX()) + ", " + hex(flipX()))
print("flipY => " + str(flipY()) + ", " + hex(flipY()))
print("palette => " + str(palette()) + ", " + hex(palette()))