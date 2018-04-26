class php5::php5_cli::install {

  package {'php5.6-cli':
    ensure => present,
    require => Class['apt::update'],
    before => Class['php5::modules']
  }

  include php5::modules

  if $php5::php5_cli::phalcon {
    include php5::phalcon
  }
}
