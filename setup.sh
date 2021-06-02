#!/bin/bash

exist="n"
test -d "out" && exist="y"
if [ "$exist" == "n" ];
	then
		mkdir out
		echo "The created directory has been created"
fi


echo "Starting the execution of the practice 2"
cont=0

for i in $(seq 1 10);
do
	java -cp bin:lib/* ServidorWeb 10 10 1 10 > out/arq$cont.txt
	echo "out/arq$cont.txt file created"
	cont=$(($cont+1))
done

#head -n 2 out/arq0.txt | tail -n 1 
