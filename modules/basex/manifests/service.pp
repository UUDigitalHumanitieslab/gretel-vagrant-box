class basex::service {


  exec{"basexserver -S":
    require => Package['basex'],
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/'
  }

}