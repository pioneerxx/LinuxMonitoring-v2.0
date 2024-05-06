#!/bin/bash

echo -n "Enter the path to the log file: "
read path
if ! [[ -f $path  ]]; then
	echo "The log file doesn't exist"
	exit
fi

while read -r line
do
	pathing="$(echo $line | awk '{print $1}')"
	isfile="$(echo $line | awk '{print $3}')"
	if [[ $isfile == ""  ]]; then
		rm $pathing
	else
		rm -rf $pathing
	fi
done < "$path"

echo "***************************************"
echo "*     OPERATION CLEANUP COMPLETED     *"
echo "***************************************"
