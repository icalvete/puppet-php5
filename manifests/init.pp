class php5 (

  $fpm               = false,
  $amqp              = false,
  $phalcon           = false,
  $environment       = $php5::params::environment,
  $file_uploads      = 'Off',
  $file_uploads_size = $php5::params::file_uploads_size

) inherits php5::params {

  if $phalcon and ! $phalcon_support[$osfamily][$lsbdistcodename] {
    fail("Falcom module isn't supported in $osfamily $lsbdistcodename")
  }

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
      class {'php5::php5-fpm':
        require => Class['php5::config'],
      }
  }

  anchor {'php5::end':
    require => Class['php5::config']
  }
}
