class gretelupload::install{
  if ! defined(Package['composer']) {
    package { 'composer':
        ensure => installed,
    }
  }
  exec {"git clone -b develop https://github.com/UUDigitalHumanitieslab/GrETEL-upload.git /vagrant/vagrant_data/GreTEL-upload":
      require => Package["git"],
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  }

}