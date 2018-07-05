class corpus2alpino::install {
  package {["libfolia-dev", "libicu-dev", "libxml2-dev", "libticcutils2-dev", "libucto-dev", "ucto"]:}
  exec {
    "sudo -H pip3 install Cython":
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
      require => Package['python3-pip'],
    } ->
    exec { "sudo -H pip3 install corpus2alpino":
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
      require => Package['python3-pip'],
    }
}
