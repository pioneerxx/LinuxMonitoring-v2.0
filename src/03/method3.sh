#!/bin/bash

echo "Enter the name mask in this format: *abc*_DDMMYY"
echo -n "The mask: "
read mask
file_date=$(echo $mask | awk -F "_" '{printf $2}')
file_abc=$(echo $mask | awk -F "_" '{printf $1}')
abc_length=${#file_abc}
last_symb="${file_abc: -1}"
until [ $abc_length -ge 5  ]
do
	file_abc+="$last_symb"
	((abc_length=abc_length+1))
done

echo "$(find / -name $file_abc*_$file_date -type d)" > tmp.txt
while read -r line
do
	sudo rm -rf $line
done < tmp.txt
rm -f tmp.txt

echo "***************************************"
echo "*     OPERATION CLEANUP COMPLETED     *"
echo "***************************************"
