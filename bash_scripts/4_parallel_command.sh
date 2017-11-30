#!/bin/bash

echo "to how many servers do you want to send the command?"
read servercount
echo "what is the command you want to send?"
read comm1

# maybe try to do it in a function...
for ((i=1;i<=$servercount;i++)); do
	echo "enter ip address for server no. $i":
	read serverip.$i
done

#"avoid the ssh check and the need to write yes in the first command"
#"ssh -o StrictHostKeyChecking=no 192.168.137.139 -l root"
