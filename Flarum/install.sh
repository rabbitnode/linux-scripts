#!/bin/bash
echo ""
echo "  ____       _      ____    ____    ___   _____   _   _    ___    ____    _____ "
echo " |  _ \     / \    | __ )  | __ )  |_ _| |_   _| | \ | |  / _ \  |  _ \  | ____|"
echo " | |_) |   / _ \   |  _ \  |  _ \   | |    | |   |  \| | | | | | | | | | |  _|  "
echo " |  _ <   / ___ \  | |_) | | |_) |  | |    | |   | |\  | | |_| | | |_| | | |___ "
echo " |_| \_\ /_/   \_\ |____/  |____/  |___|   |_|   |_| \_|  \___/  |____/  |_____|"
echo ""
echo "##########################################"
echo "#       Install script for Flarum        #"
echo "##########################################"
echo "#               BETA v0.1                #"
echo "##########################################"
echo ""
read -p 'set MySQL Password: ' mysql_password
#
yum update -y
yum install nano zip unzip wget curl httpd firewalld -y
#
systemctl start httpd.service
systemctl enable httpd.service
#
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --add-port=22/tcp
firewall-cmd --permanent --add-port=21/tcp
firewall-cmd --reload
#
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
#
echo ""
echo "################################################"
echo "#          Flarum has been installed.          #"
echo "################################################"
#
exit
