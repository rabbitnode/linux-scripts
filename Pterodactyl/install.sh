# Add "add-apt-repository" command
apt-get -y install software-properties-common
# Add additional repositories for PHP, Redis, and MariaDB
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:chris-lea/redis-server
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
# Update repositories list
apt-get update
# Install Dependencies
apt-get -y install php7.2 php7.2-cli php7.2-gd php7.2-mysql php7.2-pdo php7.2-mbstring php7.2-tokenizer php7.2-bcmath php7.2-xml php7.2-fpm php7.2-curl php7.2-zip mariadb-server nginx curl tar unzip git redis-server
# passwords input
read -p 'Set MySQL ROOT Password: ' mysql_password
if [ -z $mysql_password ]; then
 echo "[Error]: Please enter a password"
 read -p 'Set MySQL ROOT Password:: ' mysql_password
else
 echo "input saved"
fi
#
read -p 'Set Pterodactyl Database username: ' webmaster_user
if [ -z $webmaster_user ]; then
 echo "[Error]: Please enter a username"
 read -p 'Set panel Database username: ' webmaster_user
else
 echo "input saved"
fi
#
read -p 'Set Pterodactyl Database name: ' webmaster_name
if [ -z $webmaster_name ]; then
 echo "[Error]: Please enter database name"
 read -p 'Set panel Database name: ' webmaster_name
else
 echo "input saved"
fi
#
read -p 'Set panel Database password: ' webmaster_password
if [ -z $webmaster_password ]; then
 echo "[Error]: Please enter a password"
 read -p 'Set panel Database password: ' webmaster_password
else
 echo "input saved"
fi
# Directory creation
mkdir -p /var/www/html/pterodactyl
cd /var/www/html/pterodactyl
# panel files install
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/download/v0.7.9/panel.tar.gz
tar --strip-components=1 -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache/
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
cp .env.example .env
composer install --no-dev
chown -R www-data:www-data *
cd /etc/nginx/sites-available/
wget https://raw.githubusercontent.com/rabbitnode/linux-scripts/Pterodactyl/pterodactyl.conf
ln -s /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-enabled/pterodactyl.conf
rm -rf /etc/nginx/sites-available/default.conf
rm -rf /etc/nginx/sites-enabled/default.conf
cd /etc/systemd/system/
wget https://raw.githubusercontent.com/rabbitnode/linux-scripts/Pterodactyl/pteroq.service
systemctl enable pteroq.service
systemctl start pteroq.service
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$mysql_password') WHERE User = 'root'"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE IF EXISTS test"
mysql -e "CREATE USER '$webmaster_user'@'localhost' IDENTIFIED BY '$webmaster_password';"
mysql -e "CREATE DATABASE $webmaster_name;"
mysql -e "GRANT ALL PRIVILEGES ON $webmaster_name.* TO '$webmaster_user'@'localhost' IDENTIFIED BY '$webmaster_password';"
mysql -e "FLUSH PRIVILEGES"
cd /var/www/html/pterodactyl
php artisan key:generate --force
php artisan p:environment:setup
php artisan p:environment:database
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
echo "Dameon Files will now be installed";
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
	add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce
systemctl enable docker
systemctl start docker
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt -y install nodejs
apt -y install tar unzip make gcc g++ python
mkdir -p /srv/daemon /srv/daemon-data
cd /srv/daemon
curl -L https://github.com/pterodactyl/daemon/releases/download/v0.5.6/daemon.tar.gz | tar --strip-components=1 -xzv
tar --strip-components=1 -xzvf daemon.tar.gz
npm install --only=production
cd /etc/systemd/system/
wget https://raw.githubusercontent.com/rabbitnode/linux-scripts/master/Pterodactyl/wings.service
exit
fi
