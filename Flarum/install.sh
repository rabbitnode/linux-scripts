#!/bin/bash
yum update -y
yum upgrade -y
yum install wget curl httpd -y
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update -y
yum install yum-utils -y
yum-config-manager --enable remi-php70 -y
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-dom php-ldap php-zip php-fileinfo php-mbstring mysql-server zip unzip -y
mkdir /etc/composer/
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/etc/composer/
php -r "unlink('composer-setup.php');"
cd /var/www/html/
/etc/composer/composer.phar create-project flarum/flarum . --stability=beta
wget https://raw.githubusercontent.com/RabbitNode/Scripts/master/Flarum/.htaccess
chown -R apache:apache /var/www/html
chmod -R 775 /var/www/html
service httpd start
service mysqld start
systemctl enable httpd
systemctl enable mysqld
mysql_secure_installation
yum install phpmyadmin

 

