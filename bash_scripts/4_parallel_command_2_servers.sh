#!/bin/bash

if [ "$(rpm -qa |grep -i sshpass |wc -l)" == "0" ]; then
        yum install sshpass -y >> yum.log 2>yum.err
        wait
        rm -f yum.log yum.err
        echo " "
fi

if [ "$(rpm -qa |grep -i sshpass |wc -l)" == "0" ]; then
        echo "sshpass couldn't be installed. please install manually before running the script again. script failed."
        exit 1
fi


sindex=0
for ((i=0;i<2;i++)); do
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
	serverips[$sindex]=$serverip
	user_arr[$sindex]=$user
	pass_arr[$sindex]=$pass
	(( sindex ++ ))
done

echo "what is the command you want to send?"
read comm1

function send_command () {
index1=$1
echo " "
sshpass -p "${pass_arr[$index1]}" ssh -o StrictHostKeyChecking=no "${user_arr[$index1]}"@"${serverips[$index1]}" "$comm1"
}

send_command 0 & send_command 1

#end of script
