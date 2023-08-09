#!/bin/bash

RED='\033[1;91m'
GR='\033[1;92m'
NC='\033[0m'

check () {
  if [[ ! $DIR_NAME =~ ^[a-zA-Z]{1,7}$ ]] ; then
    echo -e "${RED}ERROR: The third argument is a list of English alphabet \
letters used in folder names (no more than 7 characters)${NC}"
    exit 1
  elif [[ ! $FILE_FULL =~ ^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$ ]] ; then
    echo -e "${RED}ERROR: The fifth argument is a list of English alphabet letters used in the file name \
and extension (no more than 7 characters for the name, no more than 3 characters for the extension).${NC}"
    exit 1
  elif [[ ! $FILE_SIZE =~ ^[1-9][0-9]?[0]?[Mm]+[Bb]+$ ]] ; then
    echo -e "${RED}ERROR: The forth argument should be a number..${NC}"
    exit 1
  else 
    FILE_NAME=$(echo $FILE_FULL | awk -F "." '{print $1}')
    FILE_EXT=$(echo $FILE_FULL | awk -F "." '{print $2}')
    FILE_SIZE=$(echo $FILE_SIZE | awk -F '[Mm]' '{print $1}')
  fi
}
