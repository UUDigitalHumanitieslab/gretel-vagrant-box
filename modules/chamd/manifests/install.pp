class chamd::install{

  exec {"sudo git clone https://github.com/JanOdijk/chamd.git /opt/chamd":
      require => Package["git"],
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  }

}