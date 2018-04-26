class php5::install inherits php5::params {

  package {$php5::params::php5_package:
    ensure  => present,
    require => [
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update']]
  }

  class {'php5::php5_cli':
    max_execution_time_cli => $php5::max_execution_time_cli,
    memory_limit_cli       => $php5::memory_limit_cli,
    phalcon                => $php5::phalcon
  }
}
