#!/bin/bash
source func.sh

if [[ $# != 1 ]]; then
        echo "Only one parameter is expected!!!"
        exit
fi

if ! [[ $1 =~ ^[1-4]+$ ]]; then
        echo "Your input must be a number between 1 and 4"
        exit
fi

echo "$(find ../04/ -name *-*-*.log)" >> logs.txt
if [ "$(cat logs.txt)" == "$(echo -e '\n')"  ]; then
        echo "there are no logfiles!"
        rm -f logs.txt
	exit
fi

Unite
case $1 in
        1) bash method1.sh;;
        2) bash method2.sh;;
        3) bash method3.sh;;
        4) bash method4.sh;;
esac
rm -f logs.txt tmp.txt temp.txt
