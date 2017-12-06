#!/bin/bash

cat /etc/passwd |awk -F: '{print $1}' > user_list
usercount=$(cat user_list | wc -l)
longl=$(cat user_list |wc -L)


function longest_user {
for ((i=1;i<=$usercount;i++)); do
        cur_user=$(awk -v n=$i 'NR == n' user_list)
		test "$(echo "$cur_user" | wc -L)" -eq "$longl" && echo "$cur_user"
done
}

function shortest_user () {
sindex=0
short_list[$sindex]=$(awk 'NR == 1' user_list)
for ((i=2;i<=$usercount;i++)); do
	cur_user=$(awk -v n=$i 'NR == n' user_list)
	if [ "$(echo "$cur_user" |wc -L)" -lt "$(echo "${short_list[$sindex]}" |wc -L)" ];then 
		short_list=()
		sindex=0
		short_list[$sindex]="$cur_user"
	elif [ "$(echo "$cur_user" |wc -L)" == "$(echo "${short_list[$sindex]}" |wc -L)" ]; then
		(( sindex++ )) 
		short_list[$sindex]=$cur_user
	fi
done

for ((i=0;i<=$sindex;i++)); do
	echo "${short_list[$i]}"
done
}

echo """
the longest username/usernames in the system:"""
longest_user

echo """
the shortest username/usernames in the system:"""
shortest_user

rm -f user_list

#end of script

