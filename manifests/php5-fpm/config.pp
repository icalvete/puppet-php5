class php5::php5-fpm::config {

  augeas{'include_path_fpm' :
    context => '/files/$php5::params::php5_fpm_phpini/PHP',
    changes => 'set include_path .:/usr/share/php5',
  }

  augeas{'fpm_security' :
    context => '/files/$php5::params::php5_fpm_phpini/PHP',
    changes => [
      'set expose_php Off',
      'set file_uploads Off',
    ]
  }

  augeas{'fpm_performance' :
    context => '/files/$php5::params::php5_fpm_phpini/PHP',
    changes => [
      'set max_execution_time 15',
      'set max_input_time 15',
      'set memory_limit 32M',
      "set date.timezone ${php5::params::timezone}",
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
}
