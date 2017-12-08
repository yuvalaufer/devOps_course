#!/bin/bash

comm1=$1
LOGFILE=/var/log/5_script.log

function log1 () {
time=[$(date +"%m-%d-%Y"T"%H:%M")]
echo "$time $comm1" |tee -a $LOGFILE
$(echo $comm1) |tee -a $LOGFILE
}

log1

