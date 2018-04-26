class  php5::php5_fpm::install {

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {'libapache2-mod-php5.6':
        ensure  => purged,
        require => Package[$php5::params::php5_package, 'apache2']
      }

      package {'libapache2-mod-php5filter':
        ensure  => purged,
        require => Package[$php5::params::php5_package, 'apache2']
      }
    }
    default:{}
  }


  package { $php5::params::php5_fpm_package :
    ensure => present
  }

  file {'fpm_syslog_config':
    ensure  => present,
    path    => "${php5::params::php5_includepath}/fpm_log.php",
    content => template("${module_name}/fpm_log.php.erb"),
    mode    => '0664',
  }
}
