#!/bin/bash
if [ "$(whoami)" != "root" ]; then
	echo "please run from root user"
	exit 1
fi
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
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
wait
systemctl start jenkins
systemctl enable jenkins
