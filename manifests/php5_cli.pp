class php5::php5_cli (

  $env                    = $php5::params::env,
  $max_execution_time_cli = $php5::params::max_execution_time,
  $memory_limit_cli       = $php5::params::memory_limit,
  $phalcon                = false,

) inherits php5::params {

  anchor {'php5::php5_cli::begin':
    before => Class['php5::php5_cli::common']
  }

  class {'php5::php5_cli::common':
    require => Anchor['php5::php5_cli::begin']
  }

  class {'php5::php5_cli::install':
    require => [
      Class['php5::php5_cli::common'],
      Class['apt::update']
    ]
  }

  class {'php5::php5_cli::config':
    require => Class['php5::php5_cli::install']
  }

  anchor {'php5::php5_cli::end':
    require => Class['php5::php5_cli::config']
  }
}
