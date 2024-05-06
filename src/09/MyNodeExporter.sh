#!/bin/bash

while :
do
	sudo echo -e "$(sudo bash /home/danyellt/DO4_LinuxMonitoring_v2.0-1/src/09/SystemMetrics.sh)" > /var/www/metrics/mynodes.html
	sleep 3
done
