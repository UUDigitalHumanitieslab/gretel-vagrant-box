class gretelupload::install{

  exec {"git clone https://github.com/UUDigitalHumanitieslab/GrETEL-upload.git /vagrant/vagrant_data/GreTEL-upload":
      require => Package["git"],
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  }

}