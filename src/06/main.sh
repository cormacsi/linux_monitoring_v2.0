#!/bin/bash

# https://goaccess.io/get-started

if [[ $# -ne 0 ]] ; then
  echo -e "${RED}No arguments needed${NC}"
  exit 1
else
  LANG="en_US.UTF-8" bash -c 'goaccess ../04/*.log --log-format=COMBINED'
fi
