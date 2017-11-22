#!/bin/bash
num1=$1
if [ -z $num1 ]; then
	echo "enter a number to check if it is a prime number"
	read num1
fi

for i in "2" "3" "5" "7"; do
	if [ "$num1" == "$i" ] ;then
		echo "$num1 is a prime number"
		exit 0;

	elif [ "$(expr $num1 % $i)" == "0" ] ;then
		echo "$num1 is not a prime number, since it devides by $i"
		exit 0;
	fi
done

	k=$(expr `expr $num1 - 1` / 2)
	for ((i=3;i<$k;i++)); do
		if [ `expr $num1 % $i` == "0" ]; then
			echo "$num1 is not a prime number , since it devides in $i"
			exit 0;
		fi
	done
echo "$num1 is a prime number!!!"
