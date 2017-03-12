class php5::install inherits php5::params {

  include apt
  apt::ppa { 'ppa:ondrej/php': }

  file { $php5::params::php5_includepath:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  package {$php5::params::php5_package:
    ensure  => present,
    require => [
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update']]
  }

  class {'php5::php5-cli::install':
    require => [
      Package[$php5::params::php5_package],
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update']]
  }

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {'libapache2-mod-php5.6':
        ensure => purged
      }

      package {'libapache2-mod-php5filter':
          ensure => purged
      }
    }
    default:{}
  }

  include php5::modules

  if $php5::phalcon {

    if $php5::phalcon == '2' {
      $phalcon_module = 'phalcon2.so'
    } else {
      $phalcon_module = 'phalcon.so'
    }

    file {'phalcon.so':
      ensure  => present,
      path    => "${php5::params::extension_dir}/phalcon.so",
      source  => "puppet:///modules/${module_name}/phalcon/${::osfamily}/${::lsbdistcodename}/${$phalcon_module}",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$php5::params::php5_package]
    }
  }

  if $environment == 'DEV' {

    package { 'php5-xdebug':
      ensure  => present
    }
  }

  file {'augeas_php_len':
    ensure =>  present,
    path =>  '/usr/share/augeas/lenses/dist/php.aug',
    content =>  template("${module_name}/php.aug.erb"),
    mode =>  '0664',
  }
}
