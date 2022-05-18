include nodejs

class gretel::install {
    package{["libxml-twig-perl", "libxml-xpath-perl"]:}

    if ! defined(Package['composer']) {
        package { 'composer':
            ensure => installed,
        }
    }

    # install alpino-query from local copy
    vcsrepo { "/vagrant_data/alpino-query" :
        ensure   => latest,
        user     => 'vagrant',
        owner    => 'vagrant',
        group    => 'vagrant',
        provider => 'git',
        source   => 'https://github.com/UUDigitalHumanitieslab/alpino-query.git',
        revision => 'develop',
    } ->
    exec {"pip3 install -e .":
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
      cwd => '/vagrant_data/alpino-query',
      require => Package['python3-pip'],
      user => 'vagrant'
    } ->
    file {'/usr/local/bin/alpino-query':
      ensure => 'link',
      target => "/home/vagrant/.local/bin/alpino-query"
    }

    class {'nodejs::install':} ->

    exec {"git config --global --add safe.directory /vagrant_data/gretel":
      path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
      environment => ['HOME=/home/vagrant'],
      user => 'vagrant',
    } ->
    vcsrepo { "/vagrant_data/gretel" :
        ensure   => latest,
        user     => 'vagrant',
        owner    => 'vagrant',
        group    => 'vagrant',
        provider => 'git',
        source   => 'https://github.com/UUDigitalHumanitieslab/gretel.git',
        revision => 'develop',
    }

    file {
        '/var/www/.npm':
        ensure => 'directory',
        owner => 'vagrant',
        group => 'vagrant',
        mode  => '0755',
    } ->
    exec{ "npm install" :
        command => "npm install",
        path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
        cwd => '/vagrant_data/gretel',
        require => Class['nodejs::install'],
        user => 'vagrant',
    } ->
    exec{ "npm build" :
        command => "npm run build",
        path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
        cwd => '/vagrant_data/gretel',
        require => Class['nodejs::install'],
        user => 'vagrant',
    }

    exec{ "cp -f /vagrant_data/config/gretel_config.php /vagrant_data/gretel/config.php":
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    require => Class['php7::install']
    } ->
    exec{ "cp -f /vagrant_data/config/gretel_php.ini /etc/php/7.2/apache2/php.ini":
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    } ->
    file {
        '/vagrant_data/gretel/tmp':
        ensure => 'directory',
        owner => 'root',
        group => 'root',
        mode  => '0777', # Use 0700 if it is sensitive
    } ->
    file {
        '/vagrant_data/gretel/log':
        ensure => 'directory',
        owner => 'root',
        group => 'root',
        mode  => '0777', # Use 0700 if it is sensitive
    } ->
    file {
        '/vagrant_data/gretel/log/alpino.log':
        ensure => 'file',
        owner => 'root',
        group => 'root',
        mode  => '0777', # Use 0700 if it is sensitive
        notify => Class["apache2::service"]

    }
}
