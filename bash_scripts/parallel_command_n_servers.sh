#!/bin/bash

if [ "$(rpm -qa |grep -i sshpass |wc -l)" == "0" ]; then
	yum install sshpass -y
	wait
fi

sindex=0
#for ((i=0;i<2;i++)); do
	echo "enter ip address for server no. $((expr $i + 1))"
	read serverip
	echo "enter username for server no. $(expr $i + 1)"
	read user
	echo "enter password for server no. $(expr $i + 1)"
	read pass
	server_arr[$sindex]=$serverip
	user_arr[$sindex]=$user
	pass_arr[$sindex]=$pass
#	(( sindex ++ ))
#done

echo "what is the command you want to send?"
read comm1
#sshpass -p Adm1Cmv4 ssh -o StrictHostKeyChecking=no root@192.168.137.139 'hostname' 
sshpass -p ${pass_arr[$0]} ssh -o StrictHostKeyChecking=no ${user_arr[0]}@${server_arr[0]} 'hostname' 

echo "${server_arr[@]}"
echo "${user_arr[@]}"
echo "${pass_arr[@]}"

