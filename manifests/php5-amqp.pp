class php5::php5-amqp (

  $fpm = false,
  $cli = true

) {

  file {'librabbitmq.la':
    ensure => present,
    path   => '/usr/local/lib/librabbitmq.la',
    source => "puppet:///modules/${module_name}/amqp/librabbitmq.la",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file {'librabbitmq.so':
    ensure => present,
    path   => '/usr/local/lib/librabbitmq.so',
    source => "puppet:///modules/${module_name}/amqp/librabbitmq.so",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file {'librabbitmq.so.1':
    ensure => link,
    path   => '/usr/local/lib/librabbitmq.so.1',
    target => '/usr/local/lib/librabbitmq.so',
  }

  file {'librabbitmq.so.1.0.1':
    ensure => link,
    path   => '/usr/local/lib/librabbitmq.so.1.0.1',
    target => '/usr/local/lib/librabbitmq.so',
  }

  file {'amqp.so':
    ensure => present,
    path   => '/usr/lib/php5/20090626/amqp.so',
    source => "puppet:///modules/${module_name}/amqp/amqp.so",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  if $fpm {
    augeas {'amqp_fpm':
      context => '/files/etc/php5/fpm/php.ini/PHP',
      changes => 'set extension[last()+1] amqp.so',
      require => [File['librabbitmq.la'],File['librabbitmq.so'],File['librabbitmq.so.1'],File['librabbitmq.so.1.0.1'],File['amqp.so']],
      onlyif  => "match extension[. = 'amqp.so'] size == 0",
    }

    exec {'active_amqp_fpm':
      cwd     => '/tmp',
      command => "/etc/init.d/php5-fpm reload",
      require => Augeas['amqp_fpm']
    }
  }

  if $cli {
    augeas {'amqp_cli':
      context => '/files/etc/php5/cli/php.ini/PHP',
      changes => 'set extension[last()+1] amqp.so',
      require => [File['librabbitmq.la'],File['librabbitmq.so'],File['librabbitmq.so.1'],File['librabbitmq.so.1.0.1'],File['amqp.so']],
      onlyif  => "match extension[. = 'amqp.so'] size == 0"
    }
  }
}
