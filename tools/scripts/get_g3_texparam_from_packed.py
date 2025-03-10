# packed => texture param
packed = 0x4DB30000

def addr():
    return ((packed >> 0) & 0xFFFF)
    
def repeat():
    return ((packed >> 16) & 0x3)
    
def flip():
    return ((packed >> 18) & 0x3)
    
def s():
    return ((packed >> 20) & 0x7)
    
def t():
    return ((packed >> 23) & 0x7)
    
def format():
    return ((packed >> 26) & 0x7)
    
def pltt0():
    return ((packed >> 29) & 0x1)
    
def texGen():
    return ((packed >> 30) & 0x3)

print("packed => " + hex(packed) + " (" + "{0:b}".format(packed) + ")")
print("addr => " + hex(addr()))
print("repeat => " + str(repeat()))
print("flip => " + str(flip()))
print("s => " + str(s()))
print("t => " + str(t()))
print("format => " + str(format()))
print("pltt0 => " + str(pltt0()))
print("texGen => " + str(texGen()))