#!/bin/bash

echo "please supply bucket name to create"
read -r bucket1

echo """please supply filename to upload from the following list:
"""
ls |sort
read -r file1

/usr/bin/aws s3 mb s3://$bucket1

if [ "$(/usr/bin/aws s3 ls |grep -i $bucket1 |wc -l)" != "0" ]; then
	echo "bucket was created successfuly"
else
	echo "bucket was not created. exiting...."
	exit 1
fi

/usr/bin/aws s3 cp $file1 s3://$bucket1/

wait
if [ "$(/usr/bin/aws s3 ls s3://$bucket1/ |grep $(basename $file1) |wc -l)" != "0" ]; then

	echo "file $file1 was successfully uploaded to bucket $bucket1"
else
	echo "problem occure when trying to upload $file1 to $bucket1..... exiting"
fi

#eof

