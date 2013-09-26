class php5::php5-pcntl (

  $fpm = true,
  $cli = true

) {

  file {'pcntl.so':
    ensure => present,
    path   => '/usr/lib/php5/20090626/pcntl.so',
    source => "puppet:///modules/${module_name}/pcntl/pcntl.so",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  if $fpm {
    augeas{'pcntl_fpm':
      context => "/files/etc/php5/fpm/php.ini/PHP",
      changes => "set extension pcntl.so",
    }
  }

  augeas{'pcntl_cli':
    context => "/files/etc/php5/cli/php.ini/PHP",
    changes => "set extension[last()+1] pcntl.so",
    onlyif  => "match extension[. = 'pcntl.so'] size == 0"
  }
}
