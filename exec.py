import os

os.system("mkdir /out")


for k in range (10):
    os.system("java -cp bin:lib/* ServidorWeb 2 5 1 6 > arquivo /out/aqr%+d.txt" %k+1)
