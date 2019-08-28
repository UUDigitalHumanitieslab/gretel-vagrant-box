include nodejs

class gretel::install {  
    package{["libxml-twig-perl", "libxml-xpath-perl"]:}

    if ! defined(Package['composer']) {
        package { 'composer':
            ensure => installed,
        }
    }

    class {'nodejs::install':} ->

    vcsrepo { "/vagrant_data/gretel" :
    ensure   => latest,
    owner    => 'www-data',
    group    => 'www-data',
    provider => 'git',
    source   => 'https://github.com/UUDigitalHumanitieslab/gretel.git',
    revision => 'develop',
    } ->

    exec{ "npm install" :
        command => "sudo npm install",
        path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
        cwd => '/vagrant_data/gretel',
        require => Class['nodejs::install'],
    }
    exec{ "npm build" :
        command => "sudo npm run build",
        path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
        cwd => '/vagrant_data/gretel',
        require => Class['nodejs::install'],
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
