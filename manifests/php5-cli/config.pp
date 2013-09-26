class php5::php5-cli::config {

  php5::module { $php5::params::curl:}
  php5::module { $php5::params::mysqlnd:}

  augeas{'include_path_cli' :
    context => '/files/etc/php5/cli/php.ini/PHP',
    changes => 'set include_path .:/usr/share/php5',
  }

  augeas{'cli_security' :
    context => '/files/etc/php5/cli/php.ini/PHP',
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'cli_performance' :
    context => '/files/etc/php5/cli/php.ini/PHP',
    changes => [
      'set max_execution_time 15',
      'set max_input_time 15',
      'set memory_limit 32M',
    ]
  }
}
