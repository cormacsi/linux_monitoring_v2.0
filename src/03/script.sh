#!/bin/bash

RED='\033[1;91m'
GR='\033[1;92m'
OR='\033[1;93m'
NC='\033[0m'

clean_logfile () {
  filename="./../02/files.log"
  if [[ ! -f $filename ]] ; then
    echo -e "${RED}ERROR: File $filename doesn't exist.${NC}"
    exit 1
  fi
  echo -e "" >> $filename
  while read -r line; do
    rm -rf $line
  done < $filename | grep / | awk '{print $1}'
  echo -e "${GR}Success: files and directories are cleaned${NC}"
  rm -rf $filename
}

clean_time () {
  while [[ 1 ]] ; do
    echo -e "${GR}Enter START date and time of file's creation in a format: YYYY/MM/DD HH:MM:SS${NC}"
    read start_date start_time
    start_date+=" $start_time"

    echo -e "${GR}Enter END date and time of file's creation in a format: YYYY/MM/DD HH:MM:SS${NC}"
    read end_date end_time
    end_date+=" $end_time"

    validation="^[2][0-9][0-9][0-9]/[0-1][0-9]/[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]$"
    if ! [[ $start_date =~ $validation && $end_date =~ $validation ]] ; then
      echo -e "${RED}The date is incorrect. Try again!${NC}"
    else
      echo -e "${GR}The date is valid. Going on!${NC}"
      break
    fi
  done
  find /$USER/ -type d,f -newermt "$start_date" ! -newermt "$end_date" 2>/dev/null | grep -v -e "/$" -e "/src/"
  echo -e "${OR}Warning: Do you want to delete all these files? Y / N${NC}"
  read answer
  if [[ $answer == "y" || $answer == "Y" ]] ; then
    find /$USER/ -type d,f -newermt "$start_date" ! -newermt "$end_date" 2>/dev/null | grep -v -e "/$" -e "/src/" | xargs rm -rf
    echo -e "${GR}The job is done!${NC}"
  fi
}

clean_mask() {
  echo -e "${GR}Please enter the FILES name mask (i.e. characters, underlining, date and extention)${NC}"
  read file_mask

  echo -e "${GR}Please enter the FOLDERS name mask (i.e. characters, underlining and date)${NC}"
  read dir_mask

  file_name=$(echo "$file_mask" | awk -F "_" '{print $1}')
  file_date_ext=$(echo "$file_mask" | awk -F "_" '{print $2}')
  dir_name=$(echo "$dir_mask" | awk -F "_" '{print $1}')
  dir_date=$(echo "$dir_mask" | awk -F "_" '{print $2}')

  while [[ ${#file_name} -lt 4 ]] ; do
    file_name="${file_name:0:1}$file_name"
  done
  while [[ ${#dir_name} -lt 4 ]] ; do
    dir_name="${dir_name:0:1}$dir_name"
  done

  find /$USER/ -type f -name "${file_name}*_${file_date_ext}"
  echo -e "${OR}Files name: ${file_name}, files date: ${file_date_ext}${NC}"
  echo -e "${RED}Are these the files you want to delete? Y / N${NC}"
  read file_answer
  if [[ $file_answer == "y" || $file_answer == "Y" ]]
  then
    find /$USER/ -type d -name "${file_name}*_${file_date_ext}" | xargs rm -rf
    echo -e "${GR}Success: files are cleaned${NC}"
  fi

  find /$USER/ -type d -name "${dir_name}*_${dir_date}"
  echo -e "${OR}Folders name: ${dir_name}, folders date: ${dir_date}${NC}"
  echo -e "${RED}Are these the folders you want to delete? Y / N${NC}"
  read dir_answer
  if [[ $dir_answer == "y" || $dir_answer == "Y" ]]
  then
    find /$USER/ -type d -name "${dir_name}*_${dir_date}" | xargs rm -rf
    echo -e "${GR}Success: directories are cleaned${NC}"
  fi
}