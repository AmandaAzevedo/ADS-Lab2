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


cont=0
for i in $(seq 1 2);
do
	java -cp bin:lib/* ServidorWeb 10 10 1 10 > out/arq$cont.txt
	echo "out/arq$cont.txt file created"
	if [ $cont == 0 ];
		then 
			head -n 1 out/arq$cont.txt | tail -n 1 > out/tmp.txt
	fi
	head -n 2 out/arq$cont.txt | tail -n 1 >> out/tmp.txt
	echo "The list with the results of out/arq$cont.txt have been saved in the file out/tmp.txt"
	cont=$(($cont+1))
done

tr -s " " < out/tmp.txt | sed 's/ /,/g' >  out/results.txt
echo "The results are passing from the results.txt file to a atv2-results.csv file"

sed 's/ \+/,/g' out/results.txt > out/atv2-results.csv
echo "Results saved in results.csv file"


rm out/results.txt out/tmp.txt
echo "Temporary files deleted"
