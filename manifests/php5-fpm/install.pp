class  php5::php5-fpm::install {

  package { $php5::params::php5_fpm_package :
    ensure => present
  }
}
