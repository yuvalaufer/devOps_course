#!/bin/bash
echo "what is your name?"
read name1
echo "what is your age?"
read age1
echo "Hi, $name1"
echo "there are: $(ls -lrt ~ |grep -v total |wc -l) files in your home directory"
echo "today's date is: $(date +"%d/%m/%Y")"
echo "your age is: $age1"

if [ `who -b |awk '{print $3}'` == `date +"%Y-%m-%d"` ]; then
	sys_up=`uptime |awk '{print $3,$4}'`
else
	sys_up=`uptime |awk '{print $3,$4,$5,$6}'`
fi

echo "the system is up for: $sys_up"
