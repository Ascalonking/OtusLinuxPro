#!/bin/bash
sudo mkdir /etc/mdadm/
sudo touch /etc/mdadm/mdadm.conf
sudo echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
sudo  mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
#sudo bash autoreid.sh