#!/bin/bash -x

if [ "$(rpm -qa |grep -i sshpass |wc -l)" == "0" ]; then
	yum install sshpass -y
	wait
fi

echo "to how many servers do you want to send the command?"
read servercount
echo "what is the command you want to send?"
read comm1

sindex=0
for ((i=1;i<=$servercount;i++)); do
	echo "enter ip address for server no. $i"
	read serverip
	echo "enter username for server no. $i"
	read user
	echo "enter password for server no. $i"
	read pass
	server_arr[$sindex]=$serverip
	user_arr[$sindex]=$user
	pass_arr[$sindex]=$pass
	(( sindex ++ ))
done

#sshpass -p Adm1Cmv4 ssh -o StrictHostKeyChecking=no root@192.168.137.139 'hostname' 

echo "${server_arr[@]}"
echo "${user_arr[@]}"
echo "${pass_arr[@]}"


#"avoid the ssh check and the need to write yes in the first command"
#"ssh -o StrictHostKeyChecking=no 192.168.137.139 -l root"
