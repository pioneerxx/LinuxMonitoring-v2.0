#!/bin/bash

if [ $# -gt 0 ]; then
	echo "No parameters allowed"
fi

echo -n "Go straight to network testing? [Y/n]: "
read answer3
if [[ $answer3 != 'Y' && $answer3 != 'y' ]]; then
	timeout 1m sudo bash ../02/main.sh az az.az 2MB
	echo "Check the results on grafana dashboard and don't forget to clean the system using script from part 3!"
	echo -n "Do you wish to continue? [Y/n]:"
	read answer
	if [[ $answer != 'Y' && $answer != 'y' ]]; then
		exit
	fi
	stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 1m
	echo "Check the stats on the dashboard again"
fi
echo -n "Have you launched a second VM in the same network with this one? [Y/n]: "
read answer2
if [[ $answer2 != 'Y' && $answer2 != 'y' ]]; then
	echo "Then launch it and start the script again"
        exit
fi
iperf3 -s
echo "Check the stats for the last time and goodbye."
