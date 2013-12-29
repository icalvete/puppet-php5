class php5::pear () inherits php5::params {

  anchor{'php5::pear::begin':
    before => Class['php5::pear::install']
  }

  class{'php5::pear::install':
    require => Anchor['php5::pear::begin']
  }

  anchor{'php5::pear::end':
    require => Class['php5::pear::install']
  }
}
