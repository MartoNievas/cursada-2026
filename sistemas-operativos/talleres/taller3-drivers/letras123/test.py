DEVICE = "/dev/letras123"

f = open(DEVICE, "r+b", buffering=0)
f.write(b'h')
data = f.read(10)
print(data.decode())
f.close()
