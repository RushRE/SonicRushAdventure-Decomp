input = "HubControl__Func_2157288"

parts = input.split("__")

output = ""
if "Constructor" in parts[1]:
    output = f"_ZN{len(parts[0])}{parts[0]}{'C1'}Ev"
elif "VTable" in parts[1]:
    output = f"_ZN{len(parts[0])}{parts[0]}{'D1'}Ev"
else:
    output = f"_ZN{len(parts[0])}{parts[0]}{len(parts[1])}{parts[1]}Ev"

print(f'mangled "{input}" => "{output}"')