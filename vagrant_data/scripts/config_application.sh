# Copies a bunch of configuration files to the right location
cp /vagrant/vagrant_data/config/database.php /vagrant/vagrant_data/GreTEL-upload/application/config/database.php
cp /vagrant/vagrant_data/config/ldap.php /vagrant/vagrant_data/GreTEL-upload/application/config/ldap.php
cp /vagrant/vagrant_data/config/000-default.conf /etc/apache2/sites-enabled/000-default.conf
cp /vagrant/vagrant_data/config/apache2.conf /etc/apache2/apache2.conf
cp /vagrant/vagrant_data/config/composer.json /vagrant/vagrant_data/GreTEL-upload/application/composer.json
cp /vagrant/vagrant_data/config/config.php /vagrant/vagrant_data/GreTEL-upload/application/config/config.php

composer install --working-dir=/vagrant/vagrant_data/GreTEL-upload/application/
cp /vagrant/vagrant_data/config/phpunit.xml /vagrant/vagrant_data/GreTEL-upload/application/phpunit.xml

# Create a mysql db
mysql -u root --password=root -e "CREATE DATABASE gretel_upload;"

# Migrate the php database
php /vagrant/vagrant_data/GreTEL-upload/index.php migrate

basexserver -S

/vagrant_data/GreTEL-upload/alpino.sh

sudo a2enmod rewrite
sudo service apache2 restart
