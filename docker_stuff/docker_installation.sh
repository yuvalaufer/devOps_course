#!/bin/bash
if [ "$(whoami)" != "root" ]; then
	echo "please run from user root"
	exit 1
fi

if [ "$(rpm -qa |grep docker |wc -l)" != "0" ]; then 
	echo "removing old docker version"
	yum remove -y docker \
                  docker-common \
                  docker-selinux \
                  docker-engine   
fi

echo """###########################
installing docker-ce
###########################"""

curl -sSL https://get.docker.com/ | sh ; wait

echo """###########################
installing docker-machine"
###########################"""

curl -L https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine; wait
chmod +x /tmp/docker-machine
cp /tmp/docker-machine /usr/local/bin/docker-machine
docker-machine version
if [ ! -z "$?" ]; then
	echo "docker-machine wasn't installed correctly please install manually"
fi

echo """###########################
installing docker-compose
###########################"""
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose; wait

if [ ! -z "$?" ]; then
	echo "docker-compose wasn't installed correctly please install manually"
fi

end of script
