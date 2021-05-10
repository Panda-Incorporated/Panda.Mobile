import sys
arg=sys.argv[1]
lines=[]
with open('./index.html', 'r') as f:
    # Get the previous contents
    lines = f.readlines()
    # print(lines, arg)
    # Overwrite
    for i in range(len(lines)):
        if("<base href=\"/\">" in lines[i]):
            lines[i]="\t<base href=\"/"+str(arg)+"\">\n"
            break
print(lines)
with open('index.html', 'w') as f:
    for i in range(len(lines)):
        f.write(lines[i])
       