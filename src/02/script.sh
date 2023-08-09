#!/bin/bash

DATE_EXT=$(date +"_%d%m%y")
RUN_START=$(date +'%Y/%m/%d %T')

run () {
  touch files.log
  START=$(date +%s%N)

  while [[ ${#DIR_NAME} -lt 4 ]] ; do
    DIR_NAME="${DIR_NAME:0:1}$DIR_NAME"
  done

  while [[ ${#FILE_NAME} -lt 4 ]] ; do
    FILE_NAME="${FILE_NAME:0:1}$FILE_NAME"
  done

  while [[ 1 ]] ; do
    DIR_TMP=$( find /$USER/ -type d | egrep -v -e [\/+][.+] -e '[\/+](s?)(bin)' | shuf -n1 )
    NUM_DIR=$(( $RANDOM % 100 + 1 ))
    for (( d=0 ; d<$NUM_DIR ; d++ )) ; do
      NEW_DIR="$DIR_NAME$DATE_EXT"
      NEW_FILE=$FILE_NAME
      mkdir "$DIR_TMP/$NEW_DIR"
      echo "$DIR_TMP/$NEW_DIR $(date +'%e.%m.%Y %H:%M:%S')" >> files.log
      NUM_FILES=$(( $RANDOM % 100 + 1 ))
      for (( f=0 ; f<$NUM_FILES ; f++ )) ; do
        fallocate -l $FILE_SIZE"MB" "$DIR_TMP/$NEW_DIR/$NEW_FILE$DATE_EXT.$FILE_EXT"
        echo "$DIR_TMP/$NEW_DIR/$NEW_FILE$DATE_EXT.$FILE_EXT $(date +'%e.%m.%Y %H:%M:%S') $FILE_SIZE MB" >> files.log
        if [[ $(df -m | grep "/$" | awk '{print $4}') -le 1024 ]]; then
          echo -e "${RED}There is no left space. Stopped${NC}"
          end_script $START
          exit 0
        fi
        NEW_FILE=$NEW_FILE${FILE_NAME: -1}
      done
      DIR_NAME=$DIR_NAME${DIR_NAME: -1}
    done
  done
}

end_script () {
  RUN_END=$(date +'%Y/%m/%d %T')
  END=$(date +%s%N)
  DIFF=$((($END - $1)/1000000))
  RESULT=$( echo -e "${GR}START: $RUN_START -- END: $RUN_END -- Time: $(($DIFF/1000)) seconds and $(($DIFF%1000)) milliseconds${NC}" )
  echo -e "$RESULT" >> files.log
  echo -e "$RESULT"
}
