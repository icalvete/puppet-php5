class php5::install inherits php5::params {

  package {$php5::params::php5_package:
    ensure  => present,
    require => [
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update']]
  }

  class {'php5::php5_cli':
    phalcon => $php5::phalcon
  }

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {'libapache2-mod-php5.6':
        ensure => purged
      }

      package {'libapache2-mod-php5filter':
          ensure => purged
      }
    }
    default:{}
  }

  if $php5::phalcon {
    include php5::phalcon
  }
}
