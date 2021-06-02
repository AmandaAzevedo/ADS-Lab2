import os
import csv

def loaddingFiles(x):
    listNameFiles=[]
    for k in range(x):
        x = "arq%s.txt"%str(k)
    return listNameFiles

def importData(listNameFiles):
    data=[]
    for file in listNameFiles:
        if (os.path.exists(file)):
            file=open(file, 'r', encoding='utf-8')
            for line in file:
                l=line.strip()
                data.append(l[1])
            file.close()
    return data

def convertDataInLineOfCSV(data):
    lineCSV=[]
    for item in data:
        line=item.split(" ")
        lineCSV.append(line)
    return lineCSV

def createCSVFile():
    exit=os.system('test -d "out/activity-data2.csv" && return 1')
    if (exit != 1):
        os.system('touch out/activity-data2.csv')
    else:
        print("out/activity-data2.csv file already exists")

def writeToCSVFile(itemList):
    createCSVFile()
    fileCSV=open("out/activity-data2.csv", 'w', newline='', encoding='utf-8')
    w=csv.writer(fileCSV)
    for item in itemList:
        w.writerow(item)
    w.close()
    fileCSV.close()




    