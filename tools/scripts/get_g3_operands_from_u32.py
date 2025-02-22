# operand u32 => individual opcode ids
operand = 0x24222422

def op1():
    return (operand) & 0xFF

def op2():
    return (operand >> 8) & 0xFF

def op3():
    return (operand >> 16) & 0xFF

def op4():
    return (operand >> 24) & 0xFF

print("operand => " + hex(operand) + " (" + "{0:b}".format(operand) + ")")
print("op1 => " + str(op1()) + ", " + hex(op1()))
print("op2 => " + str(op2()) + ", " + hex(op2()))
print("op3 => " + str(op3()) + ", " + hex(op3()))
print("op4 => " + str(op4()) + ", " + hex(op4()))