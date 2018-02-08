class nodejs::install{
  exec{ 'download':
    command =>  'curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -',
    path =>     '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  }
  exec{ 'sudo apt-get install -y nodejs':
        require => Exec['download'],
        command => 'apt-get install -y nodejs',
        path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    }

}