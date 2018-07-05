class chamd::install{
  exec{  "sudo -H pip3 install chamd":
     path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
     require => Package['python3-pip'],
  }
}
