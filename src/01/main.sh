#!/bin/bash

# Parameter 1 is the absolute path. 
# Parameter 2 is the number of subfolders. 
# Parameter 3 is a list of English alphabet letters used in folder names (no more than 7 characters). 
# Parameter 4 is the number of files in each created folder. 
# Parameter 5 - the list of English alphabet letters used in the file name \
# and extension (no more than 7 characters for the name, no more than 3 characters for the extension). 
# Parameter 6 - file size (in kilobytes, but not more than 100).

source ./script.sh
source ./check.sh

rm -rf files.log

if [[ $# -ne 6 ]] ; then
  echo -e "${RED}ERROR: The program needs 6 parameters.${NC}"
  exit 1
fi

DIR=$1
NUM_DIR=$2
DIR_NAME=$3
NUM_FILES=$4
FILE_FULL=$5
FILE_SIZE=$6

check
run
echo -e "${GR}Work completed successfully${NC}"
