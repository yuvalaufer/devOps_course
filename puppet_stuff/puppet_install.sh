#! /bin/bash
install_type=$1

function install_master {
echo "running puppet master installation............"
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
wait
sudo yum -y install puppetserver
wait
test "$(free -m |grep Mem |awk '{print $2}')" -le "2024" && sudo sed -i 's/JAVA_ARGS="*".*/JAVA_ARGS="-Xms256m -Xmx256m -XX:MaxPermSize=256m"/g' /etc/sysconfig/puppetserver
sudo systemctl start puppetserver
wait
sudo systemctl enable puppetserver
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
