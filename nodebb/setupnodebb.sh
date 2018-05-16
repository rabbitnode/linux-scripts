#!/bin/bash
yum -y update
yum -y install epel-release
yum -y groupinstall "Development Tools"
yum -y install git redis ImageMagick npm
curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
source ~/.bash_profile
nvm install v0.12.7
npm install forever -g
cd /etc/systemd/system/
wget https://raw.githubusercontent.com/rabbitnode/linux-scripts/master/nodebb/nodnodebb.service
systemctl start redis
systemctl enable redis
adduser nodebb
passwd -f -u nodebb
mkdir /etc/nodebb/
cd /etc/nodebb/
git clone -b v1.7.x https://github.com/NodeBB/NodeBB nodebb
cd nodebb
./nodebb setup
echo start
echo "NodeBB is now installed"
echo "You may start it by running systemctl start nodebb"
echo end

