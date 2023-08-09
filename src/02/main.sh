#!/bin/bash

source ./script.sh
source ./check.sh

# Parameter 1 is a list of English alphabet letters used in folder names (no more than 7 characters). 
# Parameter 2 the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). 
# Parameter 3 - is the file size (in Megabytes, but not more than 100).

rm -rf files.log

if [[ $# -ne 3 ]] ; then
  echo -e "${RED}ERROR: The program needs 3 parameters.${NC}"
  exit 1
fi

DIR_NAME=$1
FILE_FULL=$2
FILE_SIZE=$3

check
run
