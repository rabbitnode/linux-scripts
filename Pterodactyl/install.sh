# Add "add-apt-repository" command
apt-get -y install software-properties-common
# Add additional repositories for PHP, Redis, and MariaDB
add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:chris-lea/redis-server
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
# Update repositories list
apt-get update
# Install Dependencies
apt-get -y install php7.2 php7.2-cli php7.2-gd php7.2-mysql php7.2-pdo php7.2-mbstring php7.2-tokenizer php7.2-bcmath php7.2-xml php7.2-fpm php7.2-curl php7.2-zip mariadb-server nginx curl tar unzip git redis-server
# Directory creation
mkdir -p /var/www/html/pterodactyl
cd /var/www/html/pterodactyl
# panel files install
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/download/v0.7.6/panel.tar.gz
tar --strip-components=1 -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
cp .env.example .env
composer install --no-dev
chown -R www-data:www-data *
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
echo "Dameon Files will now be installed";
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl enable docker
systemctl start docker
curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
yum install -y tar unzip make gcc gcc-c++ python
yum install -y nodejs
mkdir -p /srv/daemon /srv/daemon-data
cd /srv/daemon
curl -Lo daemon.tar.gz https://github.com/pterodactyl/daemon/releases/download/v0.5.5/daemon.tar.gz
tar --strip-components=1 -xzvf daemon.tar.gz
npm install --only=production
cd /etc/systemd/system/
exit
fi
