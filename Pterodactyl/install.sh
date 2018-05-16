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