include gretelupload
include apache2
include nodejs
include gruntcli

package {["libxft*", "libxss*"]:}
class {'gretelupload::dep': } ->
class { 'gretelupload::install': } ->

file {
    '/vagrant/vagrant_data/scripts/config_application.sh':
      ensure => 'file',
      path => '/vagrant/vagrant_data/scripts/config_application.sh',
      owner => 'root',
      group => 'root',
      mode  => '0755', # Use 0700 if it is sensitive
}->
exec { "configure":
  command => "/bin/bash /vagrant/vagrant_data/scripts/config_application.sh",
  path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  notify => Class["apache2::service"]
}


file {
    '/home/ubuntu/uploads':
      ensure => 'directory',
      owner => 'root',
      group => 'root',
      mode  => '0777', # Use 0700 if it is sensitive
}





class{'nodejs::install':} ->
class{'gruntcli::install':}->

exec {"clone":
      command => "git clone https://github.com/UUDigitalHumanitieslab/gretel.git /vagrant_data/gretel",
      require => Package["git"],
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
} ->
exec{ "npm install" :
    command => "sudo npm install --unsafe-perm",
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    cwd => '/vagrant_data/gretel',
    require => Class['nodejs::install'],
}
exec{ "cp -f /vagrant_data/config/gretel_config.php /vagrant_data/gretel/config.php":
   path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  require => Class['php7::install']
} ->
exec{ "cp -f /vagrant_data/config/gretel_php.ini /etc/php/7.0/apache2/php.ini":
   path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
} ->
file {
    '/vagrant_data/gretel/log':
      ensure => 'directory',
      owner => 'root',
      group => 'root',
      mode  => '0777', # Use 0700 if it is sensitive
} ->
file {
    '/vagrant_data/gretel/log/alpino.log':
      ensure => 'file',
      owner => 'root',
      group => 'root',
      mode  => '0777', # Use 0700 if it is sensitive
      notify => Class["apache2::service"]
}
