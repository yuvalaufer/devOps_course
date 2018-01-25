#! /bin/bash
sudo /bin/cp /home/centos/first_conf/hosts /etc/hosts
sudo /bin/cp /home/centos/first_conf/hostname /etc/hostname
sudo /bin/hostname "$(cat /etc/hosts |grep 127 |awk '{print $3}')"
