#!/bin/bash
usercount=`cat /etc/passwd |awk -F: '{print }' |wc -l`

for ((i=0;i<$usercount;i++)); do
	cat /etc/passwd |awk -F: '{print $1}' |awk -v n=$i 'NR == n' |wc -L
	
done



#cat /etc/passwd |awk -F: '{print }' |awk 'FNR==5'
#cat /etc/passwd |awk -F: '{print }' |wc -l
#test 3 -ge 6 && echo var1 is larger || echo var2 is larger 