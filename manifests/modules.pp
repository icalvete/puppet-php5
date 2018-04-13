class php5::modules inherits php5::params {

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

  if $php5::env == 'DEV' {

    package { 'php5.6-xdebug':
      ensure  => present,
    }
  }
}
