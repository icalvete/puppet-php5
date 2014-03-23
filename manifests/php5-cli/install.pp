class php5::php5-cli::install {

  package {'php5-cli':
    ensure => present
  }

  file {'cli_syslog_config':
    ensure  => present,
    path    => "${php5::params::php5_includepath}/cli_log.php",
    content => template("${module_name}/cli_log.php.erb"),
    mode    => '0664',
  }
}
