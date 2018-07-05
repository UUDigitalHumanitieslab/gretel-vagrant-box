include gretelupload
include apache2
include basex

class {'gretelupload::dep': } ->
class {'gretelupload::install': } ->

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
} ->
class { 'gretel::install': } ->

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
