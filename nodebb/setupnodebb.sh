yum -y update
yum -y install epel-release
yum -y groupinstall "Development Tools"
yum -y install git redis ImageMagick npm
curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
source ~/.bash_profile
nvm install v0.12.7
npm install forever -g
systemctl start redis
systemctl enable redis
mkdir /etc/nodebb/
cd /etc/nodebb/
git clone -b v1.7.x https://github.com/NodeBB/NodeBB nodebb
cd nodebb

./nodebb setup
forever start ./etc/nodebb/dev.json
