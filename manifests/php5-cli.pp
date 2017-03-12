class php5::php5-cli (

  $env                    = $php5::params::env,
  $max_execution_time_cli = $php5::params::max_execution_time,
  $memory_limit_cli       = $php5::params::memory_limit,

) inherits php5::params {

  anchor{'php5::php5-cli::begin':
    before => Class['php5::php5-cli::install']
  }

  class{'php5::php5-cli::install':
    require => Anchor['php5::php5-cli::begin']
  }

  class{'php5::php5-cli::config':
    require => Class['php5::php5-cli::install']
  }

  anchor{'php5::php5-cli::end':
    require => Class['php5::php5-cli::config']
  }
}
