import os
import csv

def loaddingFiles(x):
    listNameFiles=[]
    print("The files read will be:")
    for k in range(x):
        i = "out/arq%s.txt"%str(k)
        listNameFiles.append(i)
        print(i)
    importData(listNameFiles)

def importData(listNameFiles):
    data=[]
    print("\n")
    for nameFile in listNameFiles:
        if (os.path.exists(nameFile)):
            file=open(nameFile, 'r', encoding='utf-8')
            cont=0
            for line in file:
                if(cont == 0):
                    cont=1
                else: 
                    l=line.strip().split(" ")
                    data.append(l)
                    cont=0
                    print("%s data that was read:"%nameFile)
                    print(l)
            file.close()
    writeToCSVFile(data)
  

def createCSVFile():
    os.system('touch out/activity-data2.csv')

def writeToCSVFile(itemList):
    createCSVFile()
    print("\nThe data is being saved to the file out/activity-data2.csv...")
    fileCSV=open("out/activity-data2.csv", 'w', newline='' , encoding='utf-8')
    header=["TaxaDeChegadaMedia", "TempoDeServicoMedio", "NumServidores", "RequisicoesSubmetidas", "RequisicoesConcluidas", "TempoMedioDeResposta", "TamanhoMedioDaFila"]
    w=csv.writer(fileCSV)
    w.writerow(header)
    for item in itemList:
        w.writerow(item)
    fileCSV.close()
    print("\nData has been saved to file out/activity-data2.csv")


loaddingFiles(2)
