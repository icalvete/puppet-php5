class php5::php5_fpm (

  $max_requests_fpm = 512

)
inherits php5::params {

  anchor {'php5::php5_fpm::begin':
    before => Class['php5::php5_fpm::install']
  }

  class {'php5::php5_fpm::install':
    require => Anchor['php5::php5_fpm::begin']
  }

  class {'php5::php5_fpm::config':
    require => Class['php5::php5_fpm::install'],
  }

  class {'php5::php5_fpm::service':
    subscribe => Class['php5::php5_fpm::config']
  }

  anchor {'php5::php5_fpm::end':
    require => Class['php5::php5_fpm::service']
  }
}
