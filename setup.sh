#!/bin/bash

exist="n"
test -d "out" && exist="y" || exist="n"
if [ "$exist" == "n" ];
	then
		mkdir out
		echo "The out/ directory was created"
else 
	echo "The out/ directory already exists"
fi


echo "Starting the execution of the practice 2"


echo "Insert the input (typeVar tcm tsm numS tmpObs): "
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
echo "=================== $contFor ========================"
for i in $(seq 1 $contFor);
do
	day=`date +%T`
	hour=`date +%F`
	java -cp bin:lib/* ServidorWeb $tcm $tsm $numS $tmpObs > out/output-$typeVar-arq$cont-$day-$hour.txt
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
	echo "out/output-$typeVar-arq$cont-$day-$hour.txt file created"
	if [ $cont == 0 ];
		then 
			head -n 1 out/output-$typeVar-arq$cont-$day-$hour.txt | tail -n 1 > out/tmp.txt
	fi
	head -n 2 out/output-$typeVar-arq$cont-$day-$hour.txt | tail -n 1 >> out/tmp.txt
	echo "The list with the results of out/arq$cont.txt have been saved in the file out/tmp.txt"
	cont=$(($cont+1))
done

tr -s " " < out/tmp.txt | sed 's/ /,/g' >  out/results.txt
echo "The results are passing from the results.txt file to a atv2-results-$typeVar.csv file"

sed 's/ \+/,/g' out/results.txt > out/atv2-results-$typeVar.csv
echo "Results saved in out/atv2-results-$typeVar.csv file"


rm out/results.txt out/tmp.txt
echo "Temporary files deleted"
