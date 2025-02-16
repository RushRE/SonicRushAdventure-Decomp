# idx => float deg
angle = 0xF1C8

print("angle_idx => " + hex(angle) + " (" + str(angle) + ")")
print("angle_deg => " + str((angle / 65536.0) * 360.0))