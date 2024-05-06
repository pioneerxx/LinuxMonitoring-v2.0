#!bin/bash

echo "-------------------------------------------"
echo "|        DAGESTAN CLEANING COMPANY        |"
echo "-------------------------------------------"

if [[ $# != 0  ]]; then
	echo "No parameters allowed!!!"
	exit
fi

echo "Type in the method for cleaning:"
echo "1 - based on log file"
echo "2 - based on date and time of creation"
echo "3 - based on name's mask"
echo -n "Your choice: "
read answer
if ! [[ $answer =~ ^[1-3]+$ ]]; then
	echo "Your input must be a number between 1 and 3"
	exit
fi

case $answer in
	1) bash method1.sh;;
	2) bash method2.sh;;
	3) bash method3.sh;;
esac
