class php5::php5-fpm (

  $apache = false

) inherits php5::params {

  anchor {'php5::php5-fpm::begin':
    before => Class['php5::php5-fpm::install']
  }

  class {'php5::php5-fpm::install':
    require => Anchor['php5::php5-fpm::begin']
  }

  class {'php5::php5-fpm::config':
    require => Class['php5::php5-fpm::install'],
    apache  => $apache
  }

  class {'php5::php5-fpm::service':
    subscribe => Class['php5::php5-fpm::config']
  }

  anchor {'php5::php5-fpm::end':
    require => Class['php5::php5-fpm::service']
  }
}
