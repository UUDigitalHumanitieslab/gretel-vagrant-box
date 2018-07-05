# Installs a bunch of dependencies
sudo apt-get install -y basex
sudo apt-get install git

# clones gretel upload and copies the pre-made config
git clone https://github.com/UUDigitalHumanitieslab/GrETEL-upload.git /vagrant/vagrant_data/GreTEL-upload
cp /vagrant/vagrant_data/config/config.php /vagrant/vagrant_data/GreTEL-upload/application/config/config.php

# Clones some other git project that gretel-upload depends on
git clone --depth 1 git://urd.let.rug.nl/Alpino.git /opt/Alpino
sudo mv Alpino /opt/Alpino
sudo apt-get install -y python3
sudo apt-get install -y python3-pip
sudo apt-get install -y php-mdb2-driver-mysql
