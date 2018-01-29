#! /bin/bash
install_type=$1

if [ "$(whoami |grep root |wc -l)" == "0" ]; then
		echo "please run script again with sudo or from user root"
		exit 1
fi

function install_master {
echo "running puppet master installation............"
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
wait
sudo yum -y install puppetserver
echo "puppet server is installed"
wait
test "$(free -m |grep Mem |awk '{print $2}')" -le "2024" && sudo sed -i 's/JAVA_ARGS="*".*/JAVA_ARGS="-Xms256m -Xmx256m -XX:MaxPermSize=256m"/g' /etc/sysconfig/puppetserver
echo "starting puppetserver service......."
sudo systemctl start puppetserver
wait
if [ "$(grep "Puppet Server has successfully started" /var/log/puppetlabs/puppetserver/puppetserver.log |wc -l)" != "0" ]; then
	echo "Puppetserver was started successfully"
else
	echo "Puppetserver failed to start. please check /var/log/puppetlabs/puppetserver/puppetserver.log file.."
fi
sudo systemctl enable puppetserver
if [ "$(which firewall-cmd |wc -l)" != "0" ]; then
	sudo firewall-cmd --zone=public --add-port=8140/tcp --permanent
else
	sudo iptables -I INPUT -p tcp -m tcp --dport 8140 -j ACCEPT
	service iptables restart
fi
echo """finished installation of puppet master.
"""
}

function install_client {
echo "running puppet client installation............."
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
wait
sudo yum -y install puppet-agent
wait
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
wait
echo """finished installation of puppet client
"""
}

if [ "$install_type" == "master" ]; then
	install_master
elif [ "$install_type" == "client" ]; then
	install_client
else
	echo """
missing parameter!!!

please run script again with installation type parameter:
run: './puppet_install.sh master' for puppet master installation , or './puppet_install.sh client' for client installation'
"""
exit 1
fi
