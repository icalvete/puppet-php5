class php5::php5-cli::config {

  augeas{'include_path_cli' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => "set include_path .:${php5::params::php5_includepath}",
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
      'set max_execution_time 15',
      'set max_input_time 15',
      'set memory_limit 32M',
      "set date.timezone ${php5::params::timezone}",
    ]
  }

  augeas{'cli_debug' :
    context => "/files/${php5::params::php5_cli_phpini}/PHP",
    changes => [
      'set error_log syslog',
      'set auto_prepend_file cli_log.php',
    ]
  }

  if $php5::phalcon {
    file{ 'phalcon_config_cli':
      ensure  => present,
      path    => "${php5::params::php5_cli_phpconf}/50-phalcon.ini",
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => 'extension=/usr/lib/php5/phalcon.so'
    }

  }

  if $php5::env == 'DEV' {
    augeas{'display_errors_cli':
      context => "/files/${php5::params::php5_cli_phpini}/PHP",
      changes => 'set display_errors On',
    }
  }
  
  augeas{'cli_max_execution_time' :
    context => "/files/${php5::params::php5_fpm_phpini}/PHP",
    changes => [
      "set max_execution_time ${php5::max_execution_time_cli}",
    ]
  }
}
