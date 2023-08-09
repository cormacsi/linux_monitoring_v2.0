#!/bin/bash

if [[ $# -ne 0 ]] ; then
  echo "No arguments needed"
  exit 1
fi

while [[ 1 ]] ; do
  CPU=$(top -b -n 1 | grep "%Cpu(s):" | awk '{print $2}')
  RAM=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
  HD=$(df / -m | grep / | awk '{print $4}')
  echo "my_node_cpu $CPU" > /var/www/pumpkin/metrics
  echo "my_node_ram $RAM" >> /var/www/pumpkin/metrics
  echo "my_node_hd $HD" >> /var/www/pumpkin/metrics
  sleep 3
done
