#!/bin/bash

if [ "$(rpm -qa |grep -i sshpass |wc -l)" == "0" ]; then
	yum install sshpass -y
	wait
fi

echo "to how many servers you want to send the command?"
read servernum

sindex=0
for ((i=0;i<$servernum;i++)); do
	echo "enter ip address for server no. $(expr $i + 1)"
	read serverip
	while [ "$(ping -c 1 $serverip |grep "1 received" |wc -l)" == "0" ]; do
		echo "$serverip is not alive or not valid. please check your ip and enter again"
		read serverip
	done
	echo "enter username for server no. $(expr $i + 1)"
	read user
	echo "enter password for server no. $(expr $i + 1)"
	read pass
	server_arr[$sindex]=$serverip
	user_arr[$sindex]=$user
	pass_arr[$sindex]=$pass
	count_arr[$sindex]=$sindex
	(( sindex ++ ))
done

echo "what is the command you want to send?"
read comm1

function send_command () {
index1=$1
echo""
sshpass -p "${pass_arr[$index1]}" ssh -o StrictHostKeyChecking=no "${user_arr[$index1]}"@"${server_arr[$index1]}" "$comm1"
}

k=0;i=0
for index1 in "${count_arr[@]}"; do
	comm_arr[$k]="send_command $i"
	comm_arr[$k+1]="&"
	k=$(expr $k + 2)
	(( i++ ))
done

eval "${comm_arr[@]}"

#end of script
