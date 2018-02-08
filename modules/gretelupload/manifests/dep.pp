include apache2
include php7
include git
include python3
include basex
include folia2alpino
include alpino
include chamd
include gretelupload

class gretelupload::dep {


  class { 'apache2::install': }
  class { 'apache2::service': }
  class { 'php7::install':
    notify => Service['apache2']
  }


  class { 'git::install': }

  class { 'python3::install': }
  class { 'basex::install': }
  class { 'basex::service': }

  class { 'folia2alpino::install': }
  class { 'alpino::install': }
  class { 'chamd::install': }

}
