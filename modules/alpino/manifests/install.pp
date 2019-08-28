class alpino::install{
  package {["libxss1"]:}
  exec {"wget -P /opt/ http://www.let.rug.nl/vannoord/alp/Alpino/versions/binary/latest.tar.gz":
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    timeout => 5000,
    unless => "test -d /opt/Alpino"
  } ->
  exec {"sudo tar -xzf /opt/latest.tar.gz -C /opt/":
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
      timeout => 5000,
      unless => "test -d /opt/Alpino"
  }

}
