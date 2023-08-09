#!/bin/bash

source ./script.sh

# 200 - OK
# 201 - Created
# 400 - Bad Request
# 401 - Unauthorized
# 403 - Forbidden
# 404 - Not Found
# 500 - Internal Server Error
# 501 - Not Implemented
# 502 - Bad Gateway
# 503 - Service Unavailable

if [[ $# -ne 0 ]] ; then
  echo -e "${RED}No arguments needed${NC}"
  exit 1
fi
write_logs
