class folia2alpino::install{
   exec{  "sudo -H pip3 install folia2alpino":
     path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
     require => Package['python3-pip'],
   }
}