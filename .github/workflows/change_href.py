import sys
arg=sys.argv[1]
lines=[]
file= sys.argv[2]
found=False
with open(file, 'r') as f:
    # Get the previous contents
    lines = f.readlines()
    # print(lines, arg)
    # Overwrite
    for i in range(len(lines)):
        if("<base href=\"/\">" in lines[i]):
            lines[i]="\t<base href=\"/"+str(arg)+"\">\n"
            found=True
            break
print(lines)
with open(file, 'w') as f:
    for i in range(len(lines)):
        f.write(lines[i])
       
if found:
    print("Base href has been replaced")
else:
    print("Base href has not been replaced")
