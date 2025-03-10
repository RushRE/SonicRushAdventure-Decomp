# packed => polyon attributes
packed = 0x1F0C8880

def lightFlags():
    return ((packed >> 0) & 0x3)
    
def polygonMode():
    return ((packed >> 4) & 0x3)
    
def cullMode():
    return ((packed >> 6) & 0x3)
    
def xluDepthUpdate():
    return ((packed >> 11) & 1)
    
def farClipping():
    return ((packed >> 12) & 1)
    
def display1Dot():
    return ((packed >> 13) & 1)
    
def depthTestDecal():
    return ((packed >> 14) & 1)
    
def enableFog():
    return ((packed >> 15) & 1)
    
def alpha():
    return ((packed >> 16) & 0x1F)
    
def polygonID():
    return ((packed >> 24) & 0x3F)

print("packed => " + hex(packed) + " (" + "{0:b}".format(packed) + ")")
print("lightFlags => " + str(lightFlags()))
print("polygonMode => " + str(polygonMode()))
print("cullMode => " + str(cullMode()))
print("xluDepthUpdate => " + str(xluDepthUpdate()))
print("farClipping => " + str(farClipping()))
print("display1Dot => " + str(display1Dot()))
print("depthTestDecal => " + str(depthTestDecal()))
print("enableFog => " + str(enableFog()))
print("alpha => " + hex(alpha()))
print("polygonID => " + str(polygonID()))