class php5::php5-fpm::config (

  $apache = true

) {

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
    ]
  }

  if $apache == true {
    file {'fpm_config':
      ensure => present,
      path   => '/etc/apache2/conf.d/fpm',
      source => "puppet:///modules/${module_name}/fpm",
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
     #notify => Service['apache2']
    }
  }
}
