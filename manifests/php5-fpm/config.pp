class php5::php5-fpm::config {

  augeas{'include_path_fpm' :
    context => "/files/${php5::params::php5_fpm_phpini}/PHP",
    changes => 'set include_path .:/usr/share/php5',
  }

  augeas{'fpm_security' :
    context => "/files/${php5::params::php5_fpm_phpini}/PHP",
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'fpm_performance' :
    context => "/files/${php5::params::php5_fpm_phpini}/PHP",
    changes => [
      'set max_execution_time 15',
      'set max_input_time 15',
      'set memory_limit 32M',
      "set date.timezone ${php5::params::timezone}",
    ]
  }

  augeas{'fpm_debug' :
    context => "/files/${php5::params::php5_fpm_phpini}/PHP",
    changes => [
      'set error_log syslog',
      'set auto_prepend_file fpm_log.php',
    ]
  }

  exec{ 'config_www_pool_listen':
    command => "/bin/sed -i -e \"s/listen = .*/listen = 0.0.0.0:9000/\" ${php5::params::php5_fpm_www_pool}",
    unless  => "/bin/grep 'listen = 0.0.0.0:9000' ${php5::params::php5_fpm_www_pool}"
  }

  exec{ 'config_www_pool_listen_allowed_clients':
    command => "/bin/sed -i -e \"s/listen.allowed_clients = .*/listen.allowed_clients = 0.0.0.0:9000/\" ${php5::params::php5_fpm_www_pool}",
    unless  => "/bin/grep 'listen.allowed_clients = 0.0.0.0:9000' ${php5::params::php5_fpm_www_pool}"
  }

  exec{ 'config_fpm_syslog_error_log':
    command => "/bin/sed -i -e \"s/error_log = .*/error_log = syslog/\" ${php5::params::php5_fpm_conf}",
    unless  => "/bin/grep 'error_log = syslog' ${php5::params::php5_fpm_conf}"
  }

  exec{ 'config_fpm_syslog_ident':
    command => "/bin/sed -i -e \"s/;\?syslog.ident = .*/syslog.ident = ::${environment}::php-fpm::/\" ${php5::params::php5_fpm_conf}",
    unless  => "/bin/grep 'syslog.ident = ::${environment}::php-fpm::' ${php5::params::php5_fpm_conf}"
  }

  exec{ 'config_fpm_syslog_facility':
    command => "/bin/sed -i -e \"s/;\?syslog.facility = .*/syslog.facility = ${php5::params::syslog_facility}/\" ${php5::params::php5_fpm_conf}",
    unless  => "/bin/grep 'syslog.facility = ${php5::params::syslog_facility}'"
  }

  if $php5::phalcon {
    augeas{'phalcon_fpm':
      context => "/files/${php5::params::php5_fpm_phpini}/PHP",
      changes => "set extension ${php5::params::extension_dir}phalcon.so",
      onlyif  => "match extension[. = '${php5::params::extension_dir}phalcon.so'] size == 0",
    }
  }

  if $php5::params::environment == 'DEV' {
    augeas{'display_errors_fpm':
      context => "/files/${php5::params::php5_fpm_phpini}/PHP",
      changes => 'set display_errors On',
    }
  }
}
