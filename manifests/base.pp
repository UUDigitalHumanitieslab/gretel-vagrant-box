include gretelupload
include apache2
include nodejs
include gruntcli
include basex

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


package{["libxml-twig-perl", "libxml-xpath-perl"]:}


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
    '/vagrant_data/gretel/tmp':
      ensure => 'directory',
      owner => 'root',
      group => 'root',
      mode  => '0777', # Use 0700 if it is sensitive
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

exec { "change_httpd_user":
    command => "sed -i 's/www-data/vagrant/g' /etc/apache2/envvars",
       path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    onlyif => "/bin/grep -q 'www-data' '/etc/apache2/envvars'",
    notify => Service['apache2'],
    require => Package['apache2'],
}

file { "/var/lock/apache2":
    ensure => "directory",
    owner => "vagrant",
    group => "vagrant",
    require => Exec['change_httpd_user'],
}
