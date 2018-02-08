class gruntcli::install{
    exec {"npm install -g grunt-cli":
          path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
      }
}