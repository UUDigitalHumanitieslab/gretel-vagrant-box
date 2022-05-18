class gretelupload::install{
  if ! defined(Package['composer']) {
    package { 'composer':
        ensure => installed,
    }
  }
  exec { "git config --global --add safe.directory /vagrant_data/GrETEL-upload":
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    environment => ['HOME=/home/vagrant'],
    user => 'vagrant',
  } ->
  vcsrepo { "/vagrant/vagrant_data/GreTEL-upload" :
    ensure   => latest,
    user     => 'vagrant',
    owner    => 'vagrant',
    group    => 'vagrant',
    provider => 'git',
    source   => 'https://github.com/UUDigitalHumanitieslab/GrETEL-upload.git',
    revision => 'develop',
  }
}
