#!/bin/bash

if [ "$(rpm -qa |grep -i sshpass |wc -l)" == "0" ]; then
	yum install sshpass -y
	wait
fi

sindex=0
for ((i=0;i<2;i++)); do
	echo "enter ip address for server no. $(expr $i + 1)"
	read serverip
	echo "enter username for server no. $(expr $i + 1)"
	read user
	echo "enter password for server no. $(expr $i + 1)"
	read pass
	serverips[$sindex]=$serverip
	user_arr[$sindex]=$user
	pass_arr[$sindex]=$pass
	(( sindex ++ ))
done

echo "what is the command you want to send?"
read comm1

function send_command () {
index1=$1
sshpass -p "${pass_arr[$index1]}" ssh -o StrictHostKeyChecking=no "${user_arr[$index1]}"@"${serverips[$index1]}" "$comm1"
}

send_command 0 & send_command 1

#end of script
