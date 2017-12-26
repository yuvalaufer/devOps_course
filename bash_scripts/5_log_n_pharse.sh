#!/bin/bash

LOGFILE=/var/log/5_script.log

echo """
log file: $LOGFILE

"""

INPUTF="/root/devOps_course/bash_scripts/5_bash_excercise_resourse"

if [ -z "$INPUTF" ]; then
	echo "inputfile is missing. please supply path to bash_excercise_resourse input file"
	read INPUTF
fi


LOGFILE=/var/log/5_script.log
lines="$(cat 5_bash_excercise_resourse |wc -l)"

function log () {
comm1=$1
time=[$(date +"%m-%d-%Y"T"%H:%M")]
echo "$time $comm1" |tee -a $LOGFILE
$(echo $comm1) |tee -a $LOGFILE
}

line_arr=($(cat $INPUTF |grep -n Instances |awk -F: '{print $1}' |awk 'BEGIN { ORS = " " } { print }'))

instances_count=$(grep Instances $INPUTF |wc -l)
instance_count=1

function instance_grep () {
firstl=$1
lastl=$2
open=0
close=0
for ((i=firstl;i<lastl;i++)); do
	check=$(awk -v n=$i 'NR == n' $INPUTF |tr -d ' ')
	if [ "$(echo $check |grep "{" |wc -l)"  != "0" ]; then (( open ++ )); fi
	if [ "$(echo $check |grep "}" |wc -l)"  != "0" ]; then (( close ++ )); fi
	if [ "$(echo $check |grep -i groupid |wc -l)" != "0" ]; then echo $check >> instance.$instance_count; fi
	if [ "$(echo $check |grep -i privateip |wc -l)" != "0" ]; then echo $check |grep "\." >> instance.$instance_count; fi
	if [ "$open" != "0" ]; then	
		if [ "$open" == "$close" ]; then
			(( instance_count ++ ))
		fi
	fi

done
}

log "echo using instance_grep function to isolate instances from file"
for ((k=1;k<$instances_count;k++)); do
	instance_grep "${line_arr[$(expr $k - 1)]}" $(expr "${line_arr[k]}" - 1)
done

groupid_arr=($(grep -i groupid instance.* |awk -F: '{print $3}' |sort -u |awk -F\" '{print $2}' |awk 'BEGIN { ORS = " " } { print }'))
instance_arr=($(ls |grep instance |awk -F. '{print $2}' | awk 'BEGIN { ORS = " " } { print }'))

m=1 ; touch gid_ips.1
function merge_gids () {
gid=$1
for insfile in "${instance_arr[@]}"; do
	if [ "$(grep $gid instance.$insfile |wc -l)" != "0" ]; then
		if [ "$(grep $gid gid_ips.$m |wc -l)" == "0" ]; then
			echo """##############
group id: $gid
--------------
ip addresses:""" >> gid_ips.$m
		fi	
		cat instance.$insfile |grep -i address |sort -u |awk -F: '{print $2}' |awk -F\" '{print $2}' >> gid_ips.$m
	fi
done
}

log "echo using merge_gids function to merge duplicate group ids"
for g_id in "${groupid_arr[@]}"; do
		merge_gids $g_id
		cat gid_ips.$m >> final_list
		(( m++ ))
done



log "rm -f instance.* gid_ips.*"
log "cat final_list"

# end of script

