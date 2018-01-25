#! /bin/bash
install_type=$1

function install_master {
echo "running puppet master installation............"
}

function install_client {
echo "running puppet client installation............."
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
