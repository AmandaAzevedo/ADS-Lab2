#!/bin/bash

dayD=`date +%T`
hourD=`date +%F` 

# colors
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'


exist="n"
test -d "out" && exist="y" || exist="n"
if [ "$exist" == "n" ];
	then
		mkdir out
		echo -e "{GREEN}The out/ directory was create ${NC}"
else 
	echo -e "${GREEN}The out/ directory already exists ${NC}"
fi


mkdir out/out-$dayD-$hourD
echo -e "${GREEN}The out-$dayD-$hourD/ directory was created ${NC}"


echo -e "\nStarting the execution of the practice 2"


echo -e "\n ========== Insert the input (typeVar tcm tsm numS tmpObs) ========== "
echo -e "tcm - Arrival rate of requests that are made to the web system, in requests per second."
echo -e "tsm - Average service time for processing a request, in seconds."
echo -e "numS - Number of servers (n) that will be used to process requests. In the implementation, each server is a thread of \n	the system, being possible to process up to n requests simultaneously in the web system."
echo -e "tmpObs - Time during which the web system will be observed and measured in the simulation."
echo -e "typeVar - typeVar is the parameter that does not have a fixed number, which the program will execute with different numbers"
echo -e "\nIn the position where the attribute chosen in typeVar is, type the maximum value of the interaction. The maximum value of the interaction, from 1-n"
echo -e "Enter the values ​​in the following order and format --> typeVar tcm tsm numS tmpObs"
read typeVar tcm tsm numS tmpObs

variable=""


if [ $typeVar == "tcm" ];
	then
		variable=$tcm
elif [ $typeVar == "tsm" ];
	then
		variable=$tsm
elif [ $typeVar == "numS" ];
	then
		variable=$numS
elif [ $typeVar == "tmpObs" ];
	then
		variable=$tmpObs
fi

contFor=$variable

cont=0

for i in $(seq 1 $contFor);
do
	day=`date +%T`
	hour=`date +%F`
	java -cp bin:lib/* ServidorWeb $tcm $tsm $numS $tmpObs > out/out-$dayD-$hourD/output-$typeVar-arq$cont-$day-$hour.txt
	if [ $typeVar == "tcm" ];
		then
			tcm=$(($tcm-1))
	elif [ $typeVar == "tsm" ];
		then
			tsm=$(($tsm-1))
	elif [ $typeVar == "numS"];
		then
			numS=$(($numS-1))
	elif [ $typeVar == "tmpObs"];
		then
			tmpObs$(($tmpObs-1))
	fi
	echo -e "${GREEN}\n${i}: out-$dayD-$hourD/output-$typeVar-arq$cont-$day-$hour.txt file created${NC} "
	if [ $cont == 0 ];
		then
			head -n 1 out/out-$dayD-$hourD/output-$typeVar-arq$cont-$day-$hour.txt | tail -n 1 > out/out-$dayD-$hourD/tmp.txt
	fi
	head -n 2 out/out-$dayD-$hourD/output-$typeVar-arq$cont-$day-$hour.txt | tail -n 1 >> out/out-$dayD-$hourD/tmp.txt
	echo -e "${i}: The list with the results of out/out-$dayD-$hourD/arq$cont.txt have been saved in the file out/out-$dayD-$hourDD/tmp.txt "
	cont=$(($cont+1))
done

tr -s " " < out/out-$dayD-$hourD/tmp.txt | sed 's/ /,/g' >  out/out-$dayD-$hourD/results.txt
echo -e "\nThe results are passing from the out/out-$dayD-$hourD/results.txt file to a out/out-$dayD-$hourD/atv2-results-$typeVar.csv file"

sed 's/ \+/,/g' out/out-$dayD-$hourD/results.txt > out/out-$dayD-$hourD/atv2-results-$typeVar.csv
echo -e "\n${GREEN}Results saved in out/out-$dayD-$hourD/atv2-results-$typeVar.csv file${NC}"


rm out/out-$dayD-$hourD/results.txt out/out-$dayD-$hourD/tmp.txt
echo -e "${GREEN} \nTemporary files deleted${NC}"
