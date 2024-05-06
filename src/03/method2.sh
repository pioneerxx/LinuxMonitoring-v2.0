#!/bin/bash

echo "Type in the start and end dates of file and directory creation up to minutes in this format: YYYY-MM-DD HH:MM"
echo -n "Start date: "
read start_date
echo -n "End date: "
read end_date
echo "$(sudo find / -maxdepth 100 -newermt "$start_date" ! -newermt "$end_date")" > tmp.txt
while read -r line
do
	if ! [[ $line == *"/DO4_LinuxMonitoring_v2.0-1/"*  ]]; then
		sudo chattr -a $line
		sudo rm -rf $line
	fi
done < tmp.txt
rm -f tmp.txt

echo "***************************************"
echo "*     OPERATION CLEANUP COMPLETED     *"
echo "***************************************"
