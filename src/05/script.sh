#!/bin/bash

RED='\033[1;91m'
GR='\033[1;92m'
OR='\033[1;93m'
NC='\033[0m'

current_dir="$(pwd | awk -F 'src/0' '{print $1}')src/04"

sort_by_response () {
  rm -rf sorted*.log
  for i in {1..5}; do
    log_file="$current_dir/logs$i.log"
    if [[ ! -f $log_file ]] ; then
      echo -e "${RED}ERROR: File $log_file doesn't exist.${NC}"
    else
      sort --key=9 $log_file --output="sorted$i.log"
    fi
  done
}

unique_ips () {
  rm -rf unique_ips*.log
  for i in {1..5}; do
    log_file="$current_dir/logs$i.log"
    if [[ ! -f $log_file ]] ; then
      echo -e "${RED}ERROR: File $log_file doesn't exist.${NC}"
    else
     awk '{print $1}' $log_file | uniq | sort > unique_ips$i.log
    fi
  done
}

errors () {
  rm -rf errors*.log
  for i in {1..5}; do
    log_file="$current_dir/logs$i.log"
    if [[ ! -f $log_file ]] ; then
      echo -e "${RED}ERROR: File $log_file doesn't exist.${NC}"
    else
      awk '($9 >= 400) {print}' $log_file > errors$i.log
    fi
  done
}

unique_ips_with_errors () {
  rm -rf ips_with_errors*.log
  for i in {1..5}; do
    log_file="$current_dir/logs$i.log"
    if [[ ! -f $log_file ]] ; then
      echo -e "${RED}ERROR: File $log_file doesn't exist.${NC}"
    else
      awk '($9 >= 400) {print $1}' $log_file | sort | uniq > ips_with_errors$i.log
    fi
  done
}
