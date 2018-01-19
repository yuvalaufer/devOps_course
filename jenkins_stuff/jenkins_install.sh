#!/bin/bash
if [ "$(whoami)" != "root" ]; then
	echo "please run from root user"
	exit 1
fi
if [ "$(which yum |wc -l)" == "0" ]; then
	echo "this is not a yum based installation manager. exiting script."
	exit 1
fi

if [ "$(rpm -qa |grep openjdk |wc -l)" != "0" ]; then
	if [ "$(rpm -qa |grep openjdk |grep 1.8)" == "0" ]; then
		yum remove java-*-openjdk* -y
	fi
fi
wait

yum install java-1.8.0-openjdk.x86_64 -y
wait
if [ "$(which wget |wc -l)" == "0" ]; then
	yum install wget -y
fi
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
wait
rpm -import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum install jenkins -y
wait
which firewall-cmd
test "$?" -eq "0" && (firewall-cmd --zone=public --add-port=8080/tcp --permanent) && (firewall-cmd --zone=public --add-service=http --permanent) && (firewall-cmd --reload)
wait
service start jenkins
chkconfig jenkins on
