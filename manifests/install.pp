class php5::install inherits php5::params {

  package {$php5::params::php5_package:
    ensure => present
  }

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      package {'libapache2-mod-php5':
        ensure => absent
      }

      package {'libapache2-mod-php5filter':
          ensure => absent
      }
    }
    default:{}
  }

  if $php5::params::php5_modules {
    php5::module { $php5::params::php5_modules:}
  }

  if $php5::phalcon {

    file {'phalcon.so':
      ensure => present,
      path   => "${php5::params::extension_dir}/phalcon.so",
      source => "puppet:///modules/${module_name}/phalcon/${::osfamily}/${::lsbdistcodename}/phalcon.so",
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
  }
}
