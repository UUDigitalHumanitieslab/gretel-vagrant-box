class gretelupload::install{
  if ! defined(Package['composer']) {
    package { 'composer':
        ensure => installed,
    }
  }
  vcsrepo { "/vagrant/vagrant_data/GreTEL-upload" :
    ensure   => latest,
    owner    => 'www-data',
    group    => 'www-data',
    provider => 'git',
    source   => 'https://github.com/UUDigitalHumanitieslab/GrETEL-upload.git',
    revision => 'develop',
  }
}
