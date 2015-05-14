class php5::install inherits php5::params {

  package {$php5::params::php5_package:
    ensure => present
  }

  class {'php5::php5-cli::install':
    require => Package[$php5::params::php5_package]
  }

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {'libapache2-mod-php5':
        ensure => purged
      }

      package {'libapache2-mod-php5filter':
          ensure => purged
      }
    }
    default:{}
  }

  if $php5::params::php5_modules {
    php5::module { $php5::params::php5_modules:}
  }

  if member($php5::params::php5_modules, 'php5-mongo') {
    exec {'enable_php5-mongo':
      command => '/usr/sbin/php5enmod mongo',
      user    => 'root',
      require => Php5::Module[$php5::params::php5_modules]
    }
  }

  if $php5::phalcon {

    if $php5::phalcon == 2{
      $phalcon_module = 'phalcon2.so'
    } else {
      $phalcon_module = 'phalcon.so'
    }

    file {'phalcon.so':
      ensure => present,
      path   => "${php5::params::extension_dir}/phalcon.so",
      source => "puppet:///modules/${module_name}/phalcon/${::osfamily}/${::lsbdistcodename}/${$phalcon_module}",
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
  }

  if $environment == 'DEV' {
  
    package { 'php5-xdebug':
      ensure  => present
    }
  }
}
