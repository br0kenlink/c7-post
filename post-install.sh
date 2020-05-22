#!/bin/bash
echo "Welcome to Binia's Centos 7 post install script! "

echo "Fist will update system... "

yum update -yyy &>/dev/null

echo "System is updated"

echo "Adding Epel repo... "

yum install epel-release -y &>/dev/null

echo "Done! "

yum update &>/dev/null

echo "Installing Development tools and few other things... "

yum install nano git -y &>/dev/null
yum group install "Development Tools" -y &>/dev/null
yum install yum-utils device-mapper-persistent-data lvm2 -y &>/dev/null
yum install python-pip -y &>/dev/null
pip install --upgrade pip &>/dev/null

echo "Done! "

echo "Adding Docker Community Edition repository and installing docker-ce with docker-compose... "
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose &>/dev/null
cp /usr/local/bin/docker-compose /usr/bin/docker-compose &>/dev/null
chmod +x /usr/bin/docker-compose &>/dev/null
yum upgrade python* &>/dev/null
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &>/dev/null
yum update &>/dev/null
yum install docker-ce -yy &>/dev/null
systemctl start docker &>/dev/null
systemctl enable docker &>/dev/null

echo "Done! "

echo "Installing NTP syncing..."
yum install ntp ntpdate &>/dev/null
systemctl start ntpd &>/dev/null
systemctl enable ntpd &>/dev/null
ntpdate -u -s 0.uk.pool.ntp.org 1.uk.pool.ntp.org 2.uk.pool.ntp.org 3.uk.pool.ntp.org &>/dev/null
systemctl restart ntpd &>/dev/null
hwclock -w &>/dev/null

echo "Done!"

mkdir .ssh &>/dev/null
touch .ssh/authorized_keys &>/dev/null
chmod -R 600 .ssh/

## Azuracast docker install ##
# echo "Azuracast docker install... "
# curl -L https://raw.githubusercontent.com/AzuraCast/AzuraCast/master/docker.sh > docker.sh
# chmod a+x docker.sh
# ./docker.sh install
