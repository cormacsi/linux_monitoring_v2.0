#!/bin/bash

source ./script.sh

# 1. All entries sorted by response code
# 2. All unique IPs found in the entries
# 3. All requests with errors (response code - 4xx or 5xxx)
# 4. All unique IPs found among the erroneous requests

if [[ $# -ne 1 || $1 =~ [^1-4$] ]] ; then
  echo -e "${RED}The script is run with 1 parameter, which has a value of 1, 2, 3 or 4.${NC}"
  exit 1
fi

if [[ $1 -eq 1 ]] ; then
  sort_by_response
elif [[ $1 -eq 2 ]] ; then
  unique_ips
elif [[ $1 -eq 3 ]] ; then
  errors
elif [[ $1 -eq 4 ]] ; then
  unique_ips_with_errors
fi
