class php5::php5-cli () inherits php5::params {

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
