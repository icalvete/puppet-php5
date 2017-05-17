class php5::install inherits php5::params {

  package {$php5::params::php5_package:
    ensure  => present,
    require => [
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update']]
  }

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {'libapache2-mod-php5.6':
        ensure  => purged,
        require => Package[$php5::params::php5_package, 'apache2']
      }

      package {'libapache2-mod-php5filter':
        ensure => purged,
        require => Package[$php5::params::php5_package, 'apache2']
      }
    }
    default:{}
  }

  if $php5::phalcon {
    include php5::phalcon
  }

  if $php5::fpm {
      include php5::php5_fpm
  }

  class {'php5::php5_cli':
    phalcon => $php5::phalcon
  }
}
