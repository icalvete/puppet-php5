class php5::common {

  include apt
  apt::ppa { 'ppa:ondrej/php': }

  realize Package['augeas-lenses']

  file {'augeas_php_len':
    ensure  => present,
    path    => '/usr/share/augeas/lenses/dist/php.aug',
    content => template("${module_name}/php.aug.erb"),
    mode    => '0664',
    require => Package['augeas-lenses']
  }

  file { $php5::params::php5_includepath:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  file { $php5::params::extension_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }

  include php5::modules
}
