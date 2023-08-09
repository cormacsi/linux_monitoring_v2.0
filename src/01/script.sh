#!/bin/bash

# DIR=$1
# NUM_DIR=$2
# DIR_NAME=$3
# NUM_FILES=$4
# FILE_NAME=$5
# FILE_SIZE=$6

DATE_EXT=$(date +"_%d%m%y")

run () {
  touch files.log

  while [[ ${#DIR_NAME} -lt 5 ]] ; do
    DIR_NAME="${DIR_NAME:0:1}$DIR_NAME"
  done

  while [[ ${#FILE_NAME} -lt 5 ]] ; do
    FILE_NAME="${FILE_NAME:0:1}$FILE_NAME"
  done

  for (( d=0 ; d<$NUM_DIR ; d++ )) ; do
    NEW_DIR="$DIR_NAME$DATE_EXT"
    NEW_FILE=$FILE_NAME
    mkdir "$DIR/$NEW_DIR"
    echo "$DIR/$NEW_DIR $(date +'%e.%m.%Y %H:%M:%S')" >> files.log
    for (( f=0 ; f<$NUM_FILES ; f++ )) ; do
      fallocate -l $FILE_SIZE"KB" "$DIR/$NEW_DIR/$NEW_FILE$DATE_EXT.$FILE_EXT"
      echo "$DIR/$NEW_DIR/$NEW_FILE$DATE_EXT.$FILE_EXT $(date +'%e.%m.%Y %H:%M:%S') $FILE_SIZE KB" >> files.log
      if [[ $(df -m | grep "/$" | awk '{print $4}') -le 1024 ]]; then
        ERROR=$(echo -e "${RED}There is no left space. Stopped${NC}")
        echo -e "$ERROR" >> files.log
        echo -e "$ERROR"
        exit 1
      fi
      NEW_FILE=$NEW_FILE${FILE_NAME: -1}
    done
    DIR_NAME=$DIR_NAME${DIR_NAME: -1}
  done
}
