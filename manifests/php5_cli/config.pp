class php5::php5_cli::config {

  augeas{'include_path_cli' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => "set include_path .:${php5::params::php5_includepath}:/usr/share/php",
  }

  augeas{'cli_security' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'cli_performance' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => [
      "set max_execution_time ${php5::params::max_execution_time}",
      'set max_input_time 15',
      "set date.timezone ${php5::params::timezone}",
    ]
  }

  augeas{'cli_memory_limit' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => [
      "set memory_limit ${php5::params::memory_limit}",
    ]
  }

  augeas{'cli_debug' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => [
      'set error_log syslog',
      'set auto_prepend_file cli_log.php',
    ]
  }

  if $php5::php5_cli::phalcon {
    file{ 'phalcon_config_cli':
      ensure  => present,
      path    => "${php5::params::php5_cli_phpconf}/50-phalcon.ini",
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => 'extension=/usr/lib/php/phalcon.so'
    }

  }

  if $php5::php5_cli::env == 'DEV' {
    augeas{'display_errors_cli':
      context => "/files/${php5::params::php5_cli_phpini}/PHP",
      changes => 'set display_errors On',
    }
  }

  file {'cli_syslog_config':
    ensure  => present,
    path    => "${php5::params::php5_includepath}/cli_log.php",
    content => template("${module_name}/cli_log.php.erb"),
    mode    => '0664',
  }
}
