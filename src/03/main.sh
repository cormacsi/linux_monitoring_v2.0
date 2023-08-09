#!/bin/bash

source ./script.sh

# 1. By log file
# 2. By creation date and time
# 3. By name mask (i.e. characters, underlining and date).

if [[ $# -ne 1 ]] ; then
  echo -e "${RED}ERROR: The program needs 1 parameter.${NC}"
  exit 1
elif [[ ! $1 =~ ^[1-3]$ ]] ; then
  echo -e "${RED}ERROR: The argument should be a number from 1 to 3.${NC}"
  exit 1
fi

if [[ $1 -eq 1 ]]; then
  clean_logfile
elif [[ $1 -eq 2 ]]; then 
  clean_time
else 
  clean_mask
fi
