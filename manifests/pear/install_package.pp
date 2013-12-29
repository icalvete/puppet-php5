define php5::pear::install_package (

  $ensure = 'present'

) {

  case $ensure {
    'present': {
      exec{ "install_${name}":
        command => "/usr/bin/pear install --alldeps ${name}",
        unless  => "/usr/bin/pear info ${name}",
      }
    }
    'absent': {
      exec{ "uninstall_${name}":
        command => "/usr/bin/pear uninstall ${name}",
        onlyif  => "/usr/bin/pear info ${name}",
      }
    }
    default:{}
  }
}

