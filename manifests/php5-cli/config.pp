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

  if $php5::phalcon {
    augeas{'phalcon_cli':
      context => "/files/${php5::params::php5_cli_phpini}/PHP",
      changes => "set extension[last()+1] ${php5::params::extension_dir}phalcon.so",
      onlyif  => "match extension[. = '${php5::params::extension_dir}phalcon.so'] size == 0"
    }
  }

  if $php5::params::environment == 'DEV' {
    augeas{'display_errors_cli':
      context => "/files/${php5::params::php5_cli_phpini}/PHP",
      changes => 'set display_errors On',
    }
  }
}
