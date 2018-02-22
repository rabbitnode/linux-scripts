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
yum install nano zip unzip wget curl httpd firewalld sudo -y
#
systemctl start httpd.service
systemctl enable httpd.service
#
#
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
#
systemctl start firewalld
systemcrl enable firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --add-port=22/tcp
firewall-cmd --permanent --add-port=21/tcp
firewall-cmd --reload
#
yum -y install yum-utils
yum -y update
yum -y install php
yum-config-manager --enable remi-php71
systemctl restart httpd.service
#
yum -y install php-mcrypt php-cli php-gd php-curl php-mysql php-dom php-ldap php-zip php-fileinfo php-mbstring mysql-server -y
#
sudo systemctl start mysqld
sudo systemctl enable mysqld
mysql_secure_installation -y
#
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$mysql_password') WHERE User = 'root'"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"
#
mkdir /etc/composer/
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/etc/composer/
php -r "unlink('composer-setup.php');"
chown -R apache:apache /var/www/html
chmod -R 775 /var/www/html
#
yum -y install phpmyadmin
echo ""
echo "#################################################"
echo "     Visit your domain to finish the install     "
echo "     MySQL rootuser: root                        "
echo "     MySQL password: $mysql_password             "
echo "#################################################"
#
exit
