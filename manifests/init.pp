class php5 (

  $fpm  = false,
  $amqp = false

) inherits php5::params {

  anchor {'php5::begin':
    before => Class['php5::install']
  }

  class {'php5::install':
    require => Anchor['php5::begin']
  }

  class {'php5::config':
    require => Class['php5::install']
  }

  if $fpm {

    if $amqp {

      class {'php5::php5-fpm':
        require => Class['php5::config'],
        before  => Class['php5::php5-amqp']
      }

    } else {

      class {'php5::php5-fpm':
        require => Class['php5::config'],
      }

    }
  }

  if $amqp {
    class {'php5::php5-amqp':
      fpm     => $fpm,
      require => Class['php5::config']
    }
  }

  anchor {'php5::end':
    require => Class['php5::config']
  }
}
