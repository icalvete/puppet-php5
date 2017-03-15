class php5::phalcon inherits php5::params {

  $phalcon_module = 'phalcon2.so'

  file {'phalcon.so':
    ensure  => present,
    path    => "${php5::params::extension_dir}/phalcon.so",
    source  => "puppet:///modules/${module_name}/phalcon/${::osfamily}/${::lsbdistcodename}/${$phalcon_module}",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
