class php5::php5-cli::config {

  if $php5::params::php5_modules {
    php5::module { $php5::params::php5_modules:}
  }

  augeas{'include_path_cli' :
    context => "/files/${php5::params::php5_phpini}/PHP",
    changes => "set include_path .:$php5_includepath",
  }

  augeas{'cli_security' :
    context => "/files/${php5::params::php5_phpini}/PHP",
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'cli_performance' :
    context => "/files/${php5::params::php5_phpini}/PHP",
    changes => [
      'set max_execution_time 15',
      'set max_input_time 15',
      'set memory_limit 32M',
    ]
  }
}
