#!/bin/bash
echo "what is your name?"
read name1
echo "what is your age?"
read age1
echo "Hi, $name1"
echo "there are: $(ls -lrt ~ |grep -v total |wc -l) files in your home directory"
echo "today's date is: $(date +"%d/%m/%Y")"
echo "your age is: $age1"

if [ `/usr/bin/uptime |awk '{print $4}' |awk -F, '{print $1}'` == "days" ]; then
	sys_up=`/usr/bin/uptime |awk '{print $3,$4,$5,$6}'`
elif [ `/usr/bin/uptime |awk '{print $4}' |awk -F, '{print $1}'` == "day" ]; then
	sys_up=`/usr/bin/uptime |awk '{print $3,$4,$5}' |awk -F, '{print $1,",",$2}'`
else
	sys_up=`/usr/bin/uptime |awk '{print $3,$4}' |awk -F, '{print $1}'`
fi

echo "the system is up for: $sys_up"
