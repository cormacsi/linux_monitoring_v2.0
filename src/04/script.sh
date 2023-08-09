#!/bin/bash

RED='\033[1;91m'
NC='\033[0m'

# examples of nginx log files in combined format:
# 127.0.0.1 - dbmanager [20/Nov/2017:18:52:17 +0000] "GET / HTTP/1.1" 401 188 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0"
# 188.28.166.180 - - [16/Apr/2022:00:02:30 +0300] "GET /contact-us HTTP/2.0" 501 255 "/signup" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36 PingdomPageSpeed/1.0 (pingbot/2.0; +http://www.pingdom.com/)"
# 153.78.107.192 - - [21/Nov/2017:08:45:45 +0000] "POST /ngx_pagespeed_beacon?url=https%3A%2F%2Fwww.example.com%2Fads%2Ffresh-oranges-1509260795 HTTP/2.0" 204 0 "https://www.suasell.com/ads/fresh-oranges-1509260795" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0" "-" a02b2dea9cf06344a25611c1d7ad72db Uganda UG Kampala Kampala 

write_logs () {
  for i in {1..5}; do
    log_file="logs$i.log"
    rm -rf $log_file
    touch $log_file
    log_rows=$(($RANDOM%700+300))
    new_date="$(date --date="$(($RANDOM%100)) days ago" +'%Y-%m-%d') 08:00:00 $(date +'%z')"
    for (( j=0; j<$log_rows; j++ )) ; do
      plus_time=$(($RANDOM%60+30))
      new_date="$(date --date="$new_date + $plus_time seconds" +'%Y-%m-%d %H:%M:%S %z')"
      echo -n "$(($RANDOM%256)).$(($RANDOM%256)).$(($RANDOM%256)).$(($RANDOM%256))" >> $log_file
      echo -n " - - " >> $log_file
      echo -n "[$(date --date="$new_date" +'%d/%b/%Y:%H:%M:%S %z')] " >> $log_file
      echo -n "\"$(shuf -n1 tools/methods) " >> $log_file
      echo -n "$(shuf -n1 tools/req_url) " >> $log_file
      echo -n "$(shuf -n1 tools/protocol)\" " >> $log_file
      echo -n "$(shuf -n1 tools/response) " >> $log_file
      echo -n "$(($RANDOM%1024)) " >> $log_file
      echo -n "\"$(shuf -n1 tools/ref_url)\" " >> $log_file
      echo "\"$(shuf -n1 tools/agents)\"" >> $log_file
    done
  done
}
