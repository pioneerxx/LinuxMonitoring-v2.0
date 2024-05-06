#!/bin/bash

sed -i 's|sudo echo -e "$(sudo bash SystemMetrics.sh)" > /var/www/metrics/mynodes.html|sudo echo -e "$(sudo bash '$(pwd)'/SystemMetrics.sh)" > /var/www/metrics/mynodes.html|' MyNodeExporter.sh
mkdir /var/www/metrics
sudo apt install sysstat -y
sudo apt-get install -y stress
sudo apt-get install nginx prometheus -y
sudo snap install grafana
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo nginx -s reload
sudo cp prometheus.yml /etc/prometheus/prometheus.yml
systemctl restart prometheus.service
sudo chmod +x SystemMetrics.sh
sudo chmod +x main.sh

#creating a node_exporter service
sudo echo -e "[Unit]\nDescription=My Node Exporter\nWants=network-online.target\nAfter=network-online.target\n\n[Service]\nUser=$(whoami)\nGroup=sudo\nType=simple\nExecStart=$(pwd)/MyNodeExporter.sh\n\n[Install]\nWantedBy=default.target" > /etc/systemd/system/my_node_exporter.service
sudo systemctl daemon-reload
sudo systemctl start my_node_exporter
