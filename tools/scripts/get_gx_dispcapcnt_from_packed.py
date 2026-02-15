# register => compiled value for GX_SetCapture
register = 0x80320010

def e():
    return (register & 0x80000000) >> 31

def mod():
    return (register & 0x60000000) >> 29

def cofs():
    return (register & 0xC000000) >> 26

def srcb():
    return (register & 0x2000000) >> 25
    
def srca():
    return (register & 0x1000000) >> 24
    
def wsize():
    return (register & 0x300000) >> 20
    
def wofs():
    return (register & 0xC0000) >> 18
    
def dest():
    return (register & 0x30000) >> 16
    
def evb():
    return (register & 0x1F00) >> 8
    
def eva():
    return (register & 0x1F) >> 0

print("register => " + hex(register) + " (" + "{0:b}".format(register) + ")")
print("e => " + str(e()))
print("mod => " + str(mod()))
print("cofs => " + str(cofs()))
print("srcb => " + str(srcb()))
print("srca => " + str(srca()))
print("wsize => " + str(wsize()))
print("wofs => " + str(wofs()))
print("dest => " + str(dest()))
print("evb => " + str(evb()))
print("eva => " + str(eva()))