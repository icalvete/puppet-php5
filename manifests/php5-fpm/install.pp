class  php5::php5-fpm::install {

  package { $php5::params::php5_fpm_package :
    ensure => present
  }

  file {'fpm_syslog_config':
    ensure  => present,
    path    => "${php5::params::php5_includepath}/fpm_log.php",
    content => template("${module_name}/fpm_log.php.erb"),
    mode    => '0664',
  }
}
