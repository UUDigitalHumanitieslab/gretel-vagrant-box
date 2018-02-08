class alpino::install{

  exec {"wget -P /opt/ http://www.let.rug.nl/vannoord/alp/Alpino/versions/binary/latest.tar.gz":
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  }
  exec {"sudo tar -xzf /opt/latest.tar.gz -C /opt/":
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
  }

}