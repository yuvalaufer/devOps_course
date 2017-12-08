#!/bin/bash


if [ "$(which sshpass |wc -l)" == "0" ]; then
	if [ "$(whoami)" != "root" ]; then
		echo "sshpass is not installed. please run the script in root user or install manually and run again."
		exit 1
	fi
	if [ "$(which yum |wc -l)" != "0" ]; then
		yum install sshpass -y >/dev/null 2>/dev/null
		echo "installing sshpass.."
	elif [ "$(which apt-get |wc -l)" != "0" ]; then
		apt-get install sshpass >/dev/null 2</dev/null
		echo "installing sshpass.."
	else
		echo """ unknown installation manager. (no yum and no apt-get).
				please install sshpass manually and run the script again. """
	fi
	wait
	echo " "
fi

if [ "$(which sshpass |wc -l)" == "0" ]; then
	echo " sshpass couldn't be installed. please install manually before running the script again. script failed."
	exit 1
fi

FILE1=$1
comm1=$2

if [ -z $FILE1 ]; then
	echo """
	before you start please verify that you have prepaired the input file.
	input file should look like this:
	<first server ip>	<first server's username you want to send command to> <password to that username>
	<second server ip>	<second server's username you want to send command to> <password to that username>
	etc.. 
	e.g.:
	192.168.137.129	user1	user1pass
	192.168.137.130	user3	user3pass

	***  enter full path to the input file. if you don't have one , enter 0. script will exit and you'll have to run it again after you prepare 
		your input file.
	"""
	read FILE1
fi

if [ "$FILE1" == "0" ]; then
	exit 1
elif [ ! -f "$FILE1" ]; then 
	echo "file doesn't exist. check input file location and run again."
	exit 1
fi


servernum="$(cat $FILE1 | wc -l)"

sindex=0;
for ((i=1;i<=$servernum;i++)); do
		serverip="$(awk -v n=$i 'NR == n' $FILE1 |awk '{print $1}')"
		pingtest="$(ping -c 1 "$serverip" |grep "1 received" |wc -l)"
		if [ "$pingtest" == "0" ]; then
			echo "$serverip is not alive or not valid. no command was sent to this ip"
		else
			count_arr[$sindex]=$sindex
			(( sindex ++ ))
			cat $FILE1 |grep $serverip >> TEMPFILE
		fi
done
FILE1=TEMPFILE

if [ -z $comm1 ]; then
	echo "what is the command you want to send?"
	read comm1
fi

function send_command () {
i=$1
echo""
sshpass -p "$(awk -v n=$i 'NR == n' $FILE1 |awk '{print $3}')" ssh -o StrictHostKeyChecking=no "$(awk -v n=$i 'NR == n' $FILE1 |awk '{print $2}')"@"\
$(awk -v n=$i 'NR == n' $FILE1 |awk '{print $1}')" "$comm1"
}

k=0;i=1
for count in "${count_arr[@]}"; do
	comm_arr[$k]="send_command $i"
	comm_arr[$k+1]="&"
	k=$(expr $k + 2)
	(( i++ ))
done

eval "${comm_arr[@]}"
wait
/bin/rm -f TEMPFILE

#end of script
