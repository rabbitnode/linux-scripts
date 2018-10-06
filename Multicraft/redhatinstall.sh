yum -y update
yum install -y epel-release
yum -y install nano httpd php php-common php-gd php-mbstring php-ldap php-odbc php-pear php-xml php-xmlrpc php-bcmath php-mysql php-pdo wget vim tar zip curl java-1.8.0-openjdk
systemctl start httpd.service && systemctl enable httpd.service
systemctl start mariadb && systemctl enable mariadb
mysql_secure_installation
yum -y install phpmyadmin
wget phpMyAdmin.conf
rm -rf /etc/httpd/conf.d/phpMyAdmin.conf
cp phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf
wget http://www.multicraft.org/download/linux64 -O multicraft.tar.gz
tar xvzf multicraft.tar.gz
cd multicraft
./setup.sh
chown -R apache.apache /var/www/html
awk '/AllowOverride None/{c++;if(c==2){sub("AllowOverride None","AllowOverride All");c=0}}1' /etc/httpd/conf/httpd.conf > /tmp/httpd.conf; mv -f /tmp/httpd.conf /etc/httpd/conf/httpd.conf
systemctl restart httpd.service
