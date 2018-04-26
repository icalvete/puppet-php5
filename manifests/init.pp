class php5 (

  $fpm                             = false,
  $amqp                            = false,
  $phalcon                         = false,
  $opcache                         = false,
  $opcache_blacklist               = [''],
  $env                             = pick($::env, $php5::params::env),
  $file_uploads                    = 'Off',
  $file_uploads_size               = $php5::params::file_uploads_size,
  $max_execution_time_cli          = $php5::params::max_execution_time,
  $max_execution_time_fpm          = $php5::params::max_execution_time,
  $memory_limit_cli                = $php5::params::memory_limit,
  $memory_limit_fpm                = $php5::params::memory_limit,
  $memcached_compression_threshold = $php5::params::memcached_compression_threshold

) inherits php5::params {

  if $phalcon and ! $phalcon_support[$osfamily][$lsbdistcodename] {
    fail("Falcom module isn't supported in $osfamily $lsbdistcodename")
  }

  anchor {'php5::begin':
    before => Class['php5::common']
  }

  class {'php5::common':
    require => Anchor['php5::begin']
  }

  class {'php5::install':
    require => Class['php5::common']
  }

  class {'php5::config':
    require => Class['php5::install']
  }

  if $fpm {
    class {'php5::php5_fpm':
      require => Class['php5::config'],
    }
  }

  anchor {'php5::end':
    require => Class['php5::config']
  }
}
